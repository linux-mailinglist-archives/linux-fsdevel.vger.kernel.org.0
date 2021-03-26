Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6FA34AD87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCZRcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhCZRci (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AEA461A2B;
        Fri, 26 Mar 2021 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779957;
        bh=C77FPiXyQYcU/8fTelD3ZMx6YlBkXH7rNgFoqNr1Vt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvGFkspZyvovaebnf4vnqRKLiXDd3Qhg0kr1JA9rVHFtFye+ruvVam3InvLyATDnc
         9HsUq+DsmkEWR4d5HrkH81rEnJz38h1OnEjJ6nT9aDTTW+10GGQO7Fko1EskO21fxa
         0Kjz9eSh2zSqTfpVJJjW6oGNGa5jRNL1DblSNC1UCZHr5zFpT4+LeoRLae8kJJ2gfS
         TdAUOxKMJlmFz4/CM+LDkd5RUUaZnLi8lFJdjaCrbyL95SxHFy6tZ2KjyxvDEDDzhy
         K3dIKFUu7eqms2xWh0Idj6k9+/bc5eO0D1DcMT0PLFwBBoHvXVgrME8G81tC9LkLH4
         uaS4g4qXJdNlA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 12/19] ceph: send altname in MClientRequest
Date:   Fri, 26 Mar 2021 13:32:20 -0400
Message-Id: <20210326173227.96363-13-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the event that we have a filename longer than CEPH_NOHASH_NAME_MAX,
we'll need to hash the tail of the filename. The client however will
still need to know the full name of the file if it has a key.

To support this, the MClientRequest field has grown a new alternate_name
field that we populate with the full (binary) crypttext of the filename.
This is then transmitted to the clients in readdir or traces as part of
the dentry lease.

Add support for populating this field when the filenames are very long.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.c | 79 +++++++++++++++++++++++++++++++++++++++++---
 fs/ceph/mds_client.h |  2 ++
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 31a4c9674681..a2c25292c4b1 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -858,6 +858,7 @@ void ceph_mdsc_release_request(struct kref *kref)
 	put_cred(req->r_cred);
 	if (req->r_pagelist)
 		ceph_pagelist_release(req->r_pagelist);
+	kfree(req->r_altname);
 	put_request_session(req);
 	ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
 	WARN_ON_ONCE(!list_empty(&req->r_wait));
@@ -2382,11 +2383,66 @@ static int encode_encrypted_fname(const struct inode *parent, struct dentry *den
 	dout("base64-encoded ciphertext name = %.*s\n", len, buf);
 	return elen;
 }
+
+static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
+{
+	struct inode *dir = req->r_parent;
+	struct dentry *dentry = req->r_dentry;
+	u8 *cryptbuf = NULL;
+	u32 len = 0;
+	int ret = 0;
+
+	/* only encode if we have parent and dentry */
+	if (!dir || !dentry)
+		goto success;
+
+	/* No-op unless this is encrypted */
+	if (!IS_ENCRYPTED(dir))
+		goto success;
+
+	ret = __fscrypt_prepare_readdir(dir);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* No key? Just ignore it. */
+	if (!fscrypt_has_encryption_key(dir))
+		goto success;
+
+	if (!fscrypt_fname_encrypted_size(dir, dentry->d_name.len, NAME_MAX, &len)) {
+		WARN_ON_ONCE(1);
+		return ERR_PTR(-ENAMETOOLONG);
+	}
+
+	/* No need to append altname if name is short enough */
+	if (len <= CEPH_NOHASH_NAME_MAX) {
+		len = 0;
+		goto success;
+	}
+
+	cryptbuf = kmalloc(len, GFP_KERNEL);
+	if (!cryptbuf)
+		return ERR_PTR(-ENOMEM);
+
+	ret = fscrypt_fname_encrypt(dir, &dentry->d_name, cryptbuf, len);
+	if (ret) {
+		kfree(cryptbuf);
+		return ERR_PTR(ret);
+	}
+success:
+	*plen = len;
+	return cryptbuf;
+}
 #else
 static int encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
 {
 	return -EOPNOTSUPP;
 }
+
+static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
+{
+	*plen = 0;
+	return NULL;
+}
 #endif
 
 /**
@@ -2601,7 +2657,7 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
 	return r;
 }
 
-static void encode_timestamp_and_gids(void **p,
+static void encode_mclientrequest_tail(void **p,
 				      const struct ceph_mds_request *req)
 {
 	struct ceph_timespec ts;
@@ -2610,11 +2666,16 @@ static void encode_timestamp_and_gids(void **p,
 	ceph_encode_timespec64(&ts, &req->r_stamp);
 	ceph_encode_copy(p, &ts, sizeof(ts));
 
-	/* gid_list */
+	/* v4: gid_list */
 	ceph_encode_32(p, req->r_cred->group_info->ngroups);
 	for (i = 0; i < req->r_cred->group_info->ngroups; i++)
 		ceph_encode_64(p, from_kgid(&init_user_ns,
 					    req->r_cred->group_info->gid[i]));
+
+	/* v5: altname */
+	ceph_encode_32(p, req->r_altname_len);
+	if (req->r_altname_len)
+		ceph_encode_copy(p, req->r_altname, req->r_altname_len);
 }
 
 /*
@@ -2659,10 +2720,18 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 		goto out_free1;
 	}
 
+	req->r_altname = get_fscrypt_altname(req, &req->r_altname_len);
+	if (IS_ERR(req->r_altname)) {
+		msg = ERR_CAST(req->r_altname);
+		req->r_altname = NULL;
+		goto out_free2;
+	}
+
 	len = legacy ? sizeof(*head) : sizeof(struct ceph_mds_request_head);
 	len += pathlen1 + pathlen2 + 2*(1 + sizeof(u32) + sizeof(u64)) +
 		sizeof(struct ceph_timespec);
 	len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
+	len += sizeof(u32) + req->r_altname_len;
 
 	/* calculate (max) length for cap releases */
 	len += sizeof(struct ceph_mds_request_release) *
@@ -2693,7 +2762,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	} else {
 		struct ceph_mds_request_head *new_head = msg->front.iov_base;
 
-		msg->hdr.version = cpu_to_le16(4);
+		msg->hdr.version = cpu_to_le16(5);
 		new_head->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
 		head = (struct ceph_mds_request_head_old *)&new_head->oldest_client_tid;
 		p = msg->front.iov_base + sizeof(*new_head);
@@ -2744,7 +2813,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 
 	head->num_releases = cpu_to_le16(releases);
 
-	encode_timestamp_and_gids(&p, req);
+	encode_mclientrequest_tail(&p, req);
 
 	if (WARN_ON_ONCE(p > end)) {
 		ceph_msg_put(msg);
@@ -2853,7 +2922,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 		rhead->num_releases = 0;
 
 		p = msg->front.iov_base + req->r_request_release_offset;
-		encode_timestamp_and_gids(&p, req);
+		encode_mclientrequest_tail(&p, req);
 
 		msg->front.iov_len = p - msg->front.iov_base;
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index b6aeca9b241b..33b8dba7a44e 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -278,6 +278,8 @@ struct ceph_mds_request {
 	struct mutex r_fill_mutex;
 
 	union ceph_mds_request_args r_args;
+	u8 *r_altname;		    /* fscrypt binary crypttext for long filenames */
+	u32 r_altname_len;	    /* length of r_altname */
 	int r_fmode;        /* file mode, if expecting cap */
 	const struct cred *r_cred;
 	int r_request_release_offset;
-- 
2.30.2

