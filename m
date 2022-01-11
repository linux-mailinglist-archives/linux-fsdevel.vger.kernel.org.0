Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9404148B6CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350596AbiAKTQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350594AbiAKTQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B5C06118A;
        Tue, 11 Jan 2022 11:16:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D20DD61785;
        Tue, 11 Jan 2022 19:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2FDC36AE3;
        Tue, 11 Jan 2022 19:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928582;
        bh=CjJg0W2YyOITRe4GaKM37QKNK5Yp/LRkhsx8xgXc2Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfWgu0KJT9aCLRgaY9o+kw2AUv6vBfYnXh0Nr6lYZ6CVO0blD/Ggtvzl0oPU/6KHj
         imiTSkxJc8Y8OxpgXAHtE9YwaCPFC9moKS2lyodEDh5yjBvRyfqHpO38hFJys2gj0B
         IDZXW+hFNA4/0ikBlN0WmdIqQb/axwYUV2L+LRKZN4FlOM3ab+iK4MFAfB8BsObC4+
         3zKno87ORagmx5y52n2rTN/1jRvkRNL5A9tKWUKnCJ9iEIxNVlboPI8z9RGwOR2gtF
         B9FFduRTTMFrEESpGn8VQ/0vfrcpP/BER4DfLd9qPehqpbr9pmgIuX15T0Q7ccD2b0
         ZLwU3D4Eb8aag==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 16/48] ceph: encode encrypted name in dentry release
Date:   Tue, 11 Jan 2022 14:15:36 -0500
Message-Id: <20220111191608.88762-17-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c       | 31 +++++++++++++++++++++++++++----
 fs/ceph/mds_client.c | 20 ++++++++++++++++----
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 87ee9766dc2e..3a9672e822d9 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4584,6 +4584,18 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 	return ret;
 }
 
+/**
+ * ceph_encode_dentry_release - encode a dentry release into an outgoing request
+ * @p: outgoing request buffer
+ * @dentry: dentry to release
+ * @dir: dir to release it from
+ * @mds: mds that we're speaking to
+ * @drop: caps being dropped
+ * @unless: unless we have these caps
+ *
+ * Encode a dentry release into an outgoing request buffer. Returns 1 if the
+ * thing was released, or a negative error code otherwise.
+ */
 int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 			       struct inode *dir,
 			       int mds, int drop, int unless)
@@ -4616,13 +4628,24 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
 		dout("encode_dentry_release %p mds%d seq %d\n",
 		     dentry, mds, (int)di->lease_seq);
-		rel->dname_len = cpu_to_le32(dentry->d_name.len);
-		memcpy(*p, dentry->d_name.name, dentry->d_name.len);
-		*p += dentry->d_name.len;
 		rel->dname_seq = cpu_to_le32(di->lease_seq);
 		__ceph_mdsc_drop_dentry_lease(dentry);
+		spin_unlock(&dentry->d_lock);
+		if (IS_ENCRYPTED(dir) && fscrypt_has_encryption_key(dir)) {
+			int ret2 = ceph_encode_encrypted_fname(dir, dentry, *p);
+			if (ret2 < 0)
+				return ret2;
+
+			rel->dname_len = cpu_to_le32(ret2);
+			*p += ret2;
+		} else {
+			rel->dname_len = cpu_to_le32(dentry->d_name.len);
+			memcpy(*p, dentry->d_name.name, dentry->d_name.len);
+			*p += dentry->d_name.len;
+		}
+	} else {
+		spin_unlock(&dentry->d_lock);
 	}
-	spin_unlock(&dentry->d_lock);
 	return ret;
 }
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8d84995481f2..1d3334b99047 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2789,15 +2789,23 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 		      req->r_inode ? req->r_inode : d_inode(req->r_dentry),
 		      mds, req->r_inode_drop, req->r_inode_unless,
 		      req->r_op == CEPH_MDS_OP_READDIR);
-	if (req->r_dentry_drop)
-		releases += ceph_encode_dentry_release(&p, req->r_dentry,
+	if (req->r_dentry_drop) {
+		ret = ceph_encode_dentry_release(&p, req->r_dentry,
 				req->r_parent, mds, req->r_dentry_drop,
 				req->r_dentry_unless);
-	if (req->r_old_dentry_drop)
-		releases += ceph_encode_dentry_release(&p, req->r_old_dentry,
+		if (ret < 0)
+			goto out_err;
+		releases += ret;
+	}
+	if (req->r_old_dentry_drop) {
+		ret = ceph_encode_dentry_release(&p, req->r_old_dentry,
 				req->r_old_dentry_dir, mds,
 				req->r_old_dentry_drop,
 				req->r_old_dentry_unless);
+		if (ret < 0)
+			goto out_err;
+		releases += ret;
+	}
 	if (req->r_old_inode_drop)
 		releases += ceph_encode_inode_release(&p,
 		      d_inode(req->r_old_dentry),
@@ -2839,6 +2847,10 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 		ceph_mdsc_free_path((char *)path1, pathlen1);
 out:
 	return msg;
+out_err:
+	ceph_msg_put(msg);
+	msg = ERR_PTR(ret);
+	goto out_free2;
 }
 
 /*
-- 
2.34.1

