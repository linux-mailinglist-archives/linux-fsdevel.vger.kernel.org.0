Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09B63B4516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhFYOBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231879AbhFYOBJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:01:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF7EF61981;
        Fri, 25 Jun 2021 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629528;
        bh=gKA4v39S04dXzF72RjujhWHEUWVifFouoeHVYAlDY00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/f7c95NSN+23aMClSdzW2zKvWpEx23IzOMyU7BflThFLgO+b0oc/x3JCWZKjazrI
         /zfjM0gnMTx521fLdv2gHRDfyjLtDKVdYYs7GFJlRqFe9Gki+08k6ClqKUmkDHR5iV
         TvhDQkDqj1yQfPhtnOmqop8QSsHlHv2U1oKfwNYdTL00E1/G6J0C3dxd8Enxo0bkv1
         xiZMSzONmDdj+lnDsAnfAYBpjXz/6fZ+XuJjT5kzXRVX3ZcrpoxiXsEAMwva0YbIF2
         DyqrPol6fAZDF8a8n0bG42Vvg/q7t/jtT+wcVTdM0Z+jTpLKm/nDZ8LlwqGBV3l9OJ
         LSrf35jVb0hwA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: [RFC PATCH v7 16/24] ceph: send altname in MClientRequest
Date:   Fri, 25 Jun 2021 09:58:26 -0400
Message-Id: <20210625135834.12934-17-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625135834.12934-1-jlayton@kernel.org>
References: <20210625135834.12934-1-jlayton@kernel.org>
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
 fs/ceph/mds_client.c | 72 +++++++++++++++++++++++++++++++++++++++++---
 fs/ceph/mds_client.h |  3 ++
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2692468d2dc4..25d1b09781e2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -917,6 +917,7 @@ void ceph_mdsc_release_request(struct kref *kref)
 	put_cred(req->r_cred);
 	if (req->r_pagelist)
 		ceph_pagelist_release(req->r_pagelist);
+	kfree(req->r_altname);
 	put_request_session(req);
 	ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
 	WARN_ON_ONCE(!list_empty(&req->r_wait));
@@ -2435,11 +2436,66 @@ static int encode_encrypted_fname(const struct inode *parent, struct dentry *den
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
@@ -2662,14 +2718,15 @@ static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *
 	ceph_encode_timespec64(&ts, &req->r_stamp);
 	ceph_encode_copy(p, &ts, sizeof(ts));
 
-	/* gid_list */
+	/* v4: gid_list */
 	ceph_encode_32(p, req->r_cred->group_info->ngroups);
 	for (i = 0; i < req->r_cred->group_info->ngroups; i++)
 		ceph_encode_64(p, from_kgid(&init_user_ns,
 					    req->r_cred->group_info->gid[i]));
 
-	/* v5: altname (TODO: skip for now) */
-	ceph_encode_32(p, 0);
+	/* v5: altname */
+	ceph_encode_32(p, req->r_altname_len);
+	ceph_encode_copy(p, req->r_altname, req->r_altname_len);
 
 	/* v6: fscrypt_auth and fscrypt_file */
 	if (req->r_fscrypt_auth) {
@@ -2726,11 +2783,18 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
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
-	len += sizeof(u32); // altname
+	len += sizeof(u32) + req->r_altname_len;
 	len += sizeof(u32); // fscrypt_auth
 	if (req->r_fscrypt_auth) {
 		len += offsetof(struct ceph_fscrypt_auth, cfa_blob);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 40ff9da2d90b..c58fad3f2a87 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -284,6 +284,9 @@ struct ceph_mds_request {
 
 	struct ceph_fscrypt_auth *r_fscrypt_auth;
 
+	u8 *r_altname;		    /* fscrypt binary crypttext for long filenames */
+	u32 r_altname_len;	    /* length of r_altname */
+
 	int r_fmode;        /* file mode, if expecting cap */
 	const struct cred *r_cred;
 	int r_request_release_offset;
-- 
2.31.1

