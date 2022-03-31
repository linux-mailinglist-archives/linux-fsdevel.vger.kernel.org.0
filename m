Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B503C4EDD1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbiCaPe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiCaPd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA72223BE2;
        Thu, 31 Mar 2022 08:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE4D61AE4;
        Thu, 31 Mar 2022 15:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F247C340F3;
        Thu, 31 Mar 2022 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740710;
        bh=wfF3tGH8qKvl+nFYSgksxTlvs3JAAcYVqmTBEPJ1maY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgBZmHx5/r1Jb/oWkRhi1vV07SeSnZitUf2LA5dTD5AX2I6U/WETljvlA2vNy6wWy
         UHCzUZhjo0PEN5dcrKDWcCQjwdPjDraFYU45vqJ2zpvn/h1THLvj47iG0Mw4kMZXyY
         +Cc5cKZdlHuToKMp+qYdpRrdeUPLFzPO5M/7ttemlOf0fJS0vvkyccDpMoH6wSnVJW
         iy/eWezAHob1e+QWa7BsoNa1Z2xS3A5QQcv4Gf8pYj63wKBTwMiZ8Bu5DWFf9j3SA1
         SmrwgEz6pQ+5fj7tufbWOksHEdoUEom16l4cbhxzr5J5FXC5RhYSbXVcjn2lDrZGnA
         burHLa+IZgYZA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 19/54] ceph: encode encrypted name in dentry release
Date:   Thu, 31 Mar 2022 11:30:55 -0400
Message-Id: <20220331153130.41287-20-jlayton@kernel.org>
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

Encode encrypted dentry names when sending a dentry release request.
Also add a more helpful comment over ceph_encode_dentry_release.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c       | 32 ++++++++++++++++++++++++++++----
 fs/ceph/mds_client.c | 20 ++++++++++++++++----
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index fa4e16bc393c..29cb66e51977 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4619,6 +4619,18 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
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
@@ -4651,13 +4663,25 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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
+
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
index 0be1668b2c32..750a67643850 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2819,15 +2819,23 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
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
@@ -2869,6 +2877,10 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
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
2.35.1

