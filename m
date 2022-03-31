Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC404EDCFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiCaPe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbiCaPd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:33:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CA5223BDF;
        Thu, 31 Mar 2022 08:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91002B82170;
        Thu, 31 Mar 2022 15:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99730C340ED;
        Thu, 31 Mar 2022 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740709;
        bh=kyYkU/Dchft4ACwgY94oRFa28SIAQLGaoAiYc1wr4Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puw6g6QP15tfEFr20GUqqfVdeiGf9zvWrUOdlRhVmsh5aCvxYTIJPo8X4L6om1Py0
         ZAE/baL457t2dFvUNma29rAOCYHfUO7Y+Gy9q9xi9bYBgZLDAuDXfUIc5pLiVP4h9R
         pwTB+wmB109xkqzewO1n7FP43SnLiIAWEytQCKIf74VGa9wakAFQJ2cJ9j1NoB1s3O
         AgJgk9YfZsDaXAYkrmwwQ7bWJ3U1vhKCGuTxfjs1Qt6YH5+cLdHVYDQwBssmhNjRDQ
         lPI5qjJRpcFFCqE+o+DXLsuqaJ7/b8+tQES447+z0tEj4Rzhy5VLHuO0setpzwn+oS
         4YpFC6HHOtVmg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 18/54] ceph: send altname in MClientRequest
Date:   Thu, 31 Mar 2022 11:30:54 -0400
Message-Id: <20220331153130.41287-19-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/ceph/mds_client.c | 75 +++++++++++++++++++++++++++++++++++++++++---
 fs/ceph/mds_client.h |  3 ++
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 13367a358a85..0be1668b2c32 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -972,6 +972,7 @@ void ceph_mdsc_release_request(struct kref *kref)
 	if (req->r_pagelist)
 		ceph_pagelist_release(req->r_pagelist);
 	kfree(req->r_fscrypt_auth);
+	kfree(req->r_altname);
 	put_request_session(req);
 	ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
 	WARN_ON_ONCE(!list_empty(&req->r_wait));
@@ -2386,6 +2387,63 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 	return mdsc->oldest_tid;
 }
 
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
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
+#else
+static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
+{
+	*plen = 0;
+	return NULL;
+}
+#endif
+
 /**
  * ceph_mdsc_build_path - build a path string to a given dentry
  * @dentry: dentry to which path should be built
@@ -2606,14 +2664,15 @@ static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *
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
@@ -2669,7 +2728,13 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 		goto out_free1;
 	}
 
-	/* head */
+	req->r_altname = get_fscrypt_altname(req, &req->r_altname_len);
+	if (IS_ERR(req->r_altname)) {
+		msg = ERR_CAST(req->r_altname);
+		req->r_altname = NULL;
+		goto out_free2;
+	}
+
 	len = legacy ? sizeof(*head) : sizeof(struct ceph_mds_request_head);
 
 	/* filepaths */
@@ -2695,7 +2760,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
 
 	/* alternate name */
-	len += sizeof(u32);	// TODO
+	len += sizeof(u32) + req->r_altname_len;
 
 	/* fscrypt_auth */
 	len += sizeof(u32); // fscrypt_auth
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 2cc75f9ae7c7..cd719691a86d 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -290,6 +290,9 @@ struct ceph_mds_request {
 
 	struct ceph_fscrypt_auth *r_fscrypt_auth;
 
+	u8 *r_altname;		    /* fscrypt binary crypttext for long filenames */
+	u32 r_altname_len;	    /* length of r_altname */
+
 	int r_fmode;        /* file mode, if expecting cap */
 	int r_request_release_offset;
 	const struct cred *r_cred;
-- 
2.35.1

