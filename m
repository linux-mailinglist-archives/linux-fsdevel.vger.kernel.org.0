Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F251846EBAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbhLIPk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbhLIPkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F62C0617A1;
        Thu,  9 Dec 2021 07:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0EA49CE268E;
        Thu,  9 Dec 2021 15:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3DEC004DD;
        Thu,  9 Dec 2021 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064221;
        bh=UOxWGYDzA3hGIHgcVK9H9t3qA64rDr06RiX+dL44Deo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCgGFCmUjJEkDznOm550Hq2ZCXPnhBxNjX5GAOhdHzqFbD0peDZYL+pgWtH/YGN/y
         N3akMDMdfPUvmRXBVXO29qxzyyGkhePWLhnQB2PYGUuwvrCkj1dnO9Ye5mavHvpPqH
         2nxxMRHbLueZ4R4Uy8jIqIHCmxwRaDbV4wMhfRr6BmpUIZEnBRhVxmslRGh1bDd890
         tZyLsKJqxO+CgaebfvsahnJu/NRJzEvCWjuSRgfxLKjATCVgXE/Gjt37vol332UPzP
         cMttzcEDdmAylq8KJ9toLnT3kWLMGnCu7BwiGgSrevMkf+AP06Lv9urRpjTVQ9HQh4
         qsjEK77V2YOgw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/36] ceph: encode encrypted name in dentry release
Date:   Thu,  9 Dec 2021 10:36:28 -0500
Message-Id: <20211209153647.58953-18-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
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
index c1332c261b0d..4188fa5d3d08 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4583,6 +4583,18 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
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
@@ -4615,13 +4627,24 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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
2.33.1

