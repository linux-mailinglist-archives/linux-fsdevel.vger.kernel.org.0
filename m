Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2A3F8BF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbhHZQVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243135AbhHZQVT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF53461153;
        Thu, 26 Aug 2021 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994831;
        bh=dSWV0UZNLg7FfasCEFVJKMV7fBgFN7E1QnVj1YpQa+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7g6AyoTvSj47JQe8jhobt6m+Dr+6EWzdUOkW/gTh6bJ8C6B4a+OYZEdt/fo0V8AW
         a8PlF/eriTBv+HDWAsLhA7M4NhvwIwxtXzNj020u+24fLN4i3xpi1YDeAXi7KRLrAh
         9qcxM5kDqgNSZ0yylF5tlElrVhgCoIh80SZynbv+/TXUXIg8ulL9rEsTtDejcHpAcc
         V3w+pR25mR7vnHN2egIufQc1naMK+VbiwVZnSAa5tGzLV8A+HfQx3Y/yoTI3xZGHHb
         RhCfkO1zdKkKbnA/W+w8tqgS0LaY/6uKn440sc6E9DwLQhD35R5YGlomku5OiQOHsD
         wUHySTjvkBd9Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 16/24] ceph: encode encrypted name in dentry release
Date:   Thu, 26 Aug 2021 12:20:06 -0400
Message-Id: <20210826162014.73464-17-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
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
index b4c4a82d48fd..570b3aa86bc4 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4570,6 +4570,18 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
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
@@ -4602,12 +4614,23 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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
index 6e7cc6ea5502..a9d15f4eeee0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2908,15 +2908,23 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
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
@@ -2958,6 +2966,10 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
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
2.31.1

