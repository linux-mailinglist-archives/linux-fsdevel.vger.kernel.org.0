Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72494EDCE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiCaPds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiCaPdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:33:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107A42220D1;
        Thu, 31 Mar 2022 08:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A38F1B82011;
        Thu, 31 Mar 2022 15:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A328FC340ED;
        Thu, 31 Mar 2022 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740700;
        bh=vDtZXn/ZiNvmpJIRkD0PuasEdD1hRQt58Off0VmCv2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUyGb48YBNlXpEL3RSwl1Vak9Jq9C9hBoC+vWsLUSmOhgB46ru38d/xb26cC0FwPU
         qY87OpB8pyxzaEsCQX6JL9hYsBYKbiu/85ugFHVAU5I2OxDUxb4P1UJcMFZlWa3vjE
         mMUti0AOFXo42bbBvKJ4luJNRDym9e9uO267sLdA7g8RA8JfiP1kFfdQzBOsM1Ijy+
         afdmrBpvmLH4QLjPZ8yD9vzfrUJRkCgPq6Shu3rbCKD+Har/B4XCQLthV4QYRUQQI4
         /52BZ1HRkzVhkLO50Dj1x30FWtHYKijwC7dJ31aBmsIYlpeGWhaZF66gcu0ybaLnnl
         4djmiWk396T2A==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 08/54] ceph: add a has_stable_inodes operation for ceph
Date:   Thu, 31 Mar 2022 11:30:44 -0400
Message-Id: <20220331153130.41287-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

...and just have it return true. It should never change inode numbers
out from under us, as they are baked into the object names.

Tested-by: Luís Henriques <lhenriques@suse.de>
Reviewed-by: Luís Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c     | 11 +++++++++
 fs/ceph/file.c       |  2 ++
 fs/ceph/inode.c      | 18 +++++++++++++-
 fs/ceph/mds_client.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  4 ++++
 fs/ceph/super.h      |  6 +++++
 6 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index d1a6595a810f..3ec01702e7be 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -57,6 +57,11 @@ static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t l
 	return ret;
 }
 
+static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
+{
+	return ceph_sb_to_client(sb)->dummy_enc_policy.policy;
+}
+
 static bool ceph_crypt_empty_dir(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -64,11 +69,17 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
 	return ci->i_rsubdirs + ci->i_rfiles == 1;
 }
 
+static bool ceph_crypt_has_stable_inodes(struct super_block *sb)
+{
+	return true;
+}
+
 static struct fscrypt_operations ceph_fscrypt_ops = {
 	.key_prefix		= "ceph:",
 	.get_context		= ceph_crypt_get_context,
 	.set_context		= ceph_crypt_set_context,
 	.empty_dir		= ceph_crypt_empty_dir,
+	.has_stable_inodes	= ceph_crypt_has_stable_inodes,
 };
 
 void ceph_fscrypt_set_ops(struct super_block *sb)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index cccf729b55a8..5832dcea2d8c 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -629,6 +629,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	iinfo.xattr_data = xattr_buf;
 	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
 
+	/* FIXME: set fscrypt_auth and fscrypt_file */
+
 	in.ino = cpu_to_le64(vino.ino);
 	in.snapid = cpu_to_le64(CEPH_NOSNAP);
 	in.version = cpu_to_le64(1);	// ???
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9b333e9966f0..216e90779a55 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -615,7 +615,10 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ci->i_work, ceph_inode_work);
 	ci->i_work_mask = 0;
 	memset(&ci->i_btime, '\0', sizeof(ci->i_btime));
-
+#ifdef CONFIG_FS_ENCRYPTION
+	ci->fscrypt_auth = NULL;
+	ci->fscrypt_auth_len = 0;
+#endif
 	ceph_fscache_inode_init(ci);
 
 	return &ci->vfs_inode;
@@ -626,6 +629,9 @@ void ceph_free_inode(struct inode *inode)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	kfree(ci->i_symlink);
+#ifdef CONFIG_FS_ENCRYPTION
+	kfree(ci->fscrypt_auth);
+#endif
 	kmem_cache_free(ceph_inode_cachep, ci);
 }
 
@@ -1026,6 +1032,16 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		xattr_blob = NULL;
 	}
 
+#ifdef CONFIG_FS_ENCRYPTION
+	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
+		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
+		ci->fscrypt_auth = iinfo->fscrypt_auth;
+		iinfo->fscrypt_auth = NULL;
+		iinfo->fscrypt_auth_len = 0;
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+	}
+#endif
+
 	/* finally update i_version */
 	if (le64_to_cpu(info->version) > ci->i_version)
 		ci->i_version = le64_to_cpu(info->version);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7aa253be7edc..cd7ad033492b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -184,8 +184,52 @@ static int parse_reply_info_in(void **p, void *end,
 			info->rsnaps = 0;
 		}
 
+		if (struct_v >= 5) {
+			u32 alen;
+
+			ceph_decode_32_safe(p, end, alen, bad);
+
+			while (alen--) {
+				u32 len;
+
+				/* key */
+				ceph_decode_32_safe(p, end, len, bad);
+				ceph_decode_skip_n(p, end, len, bad);
+				/* value */
+				ceph_decode_32_safe(p, end, len, bad);
+				ceph_decode_skip_n(p, end, len, bad);
+			}
+		}
+
+		/* fscrypt flag -- ignore */
+		if (struct_v >= 6)
+			ceph_decode_skip_8(p, end, bad);
+
+		info->fscrypt_auth = NULL;
+		info->fscrypt_auth_len = 0;
+		info->fscrypt_file = NULL;
+		info->fscrypt_file_len = 0;
+		if (struct_v >= 7) {
+			ceph_decode_32_safe(p, end, info->fscrypt_auth_len, bad);
+			if (info->fscrypt_auth_len) {
+				info->fscrypt_auth = kmalloc(info->fscrypt_auth_len, GFP_KERNEL);
+				if (!info->fscrypt_auth)
+					return -ENOMEM;
+				ceph_decode_copy_safe(p, end, info->fscrypt_auth,
+						      info->fscrypt_auth_len, bad);
+			}
+			ceph_decode_32_safe(p, end, info->fscrypt_file_len, bad);
+			if (info->fscrypt_file_len) {
+				info->fscrypt_file = kmalloc(info->fscrypt_file_len, GFP_KERNEL);
+				if (!info->fscrypt_file)
+					return -ENOMEM;
+				ceph_decode_copy_safe(p, end, info->fscrypt_file,
+						      info->fscrypt_file_len, bad);
+			}
+		}
 		*p = end;
 	} else {
+		/* legacy (unversioned) struct */
 		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
 			ceph_decode_64_safe(p, end, info->inline_version, bad);
 			ceph_decode_32_safe(p, end, info->inline_len, bad);
@@ -650,8 +694,21 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 
 static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
 {
+	int i;
+
+	kfree(info->diri.fscrypt_auth);
+	kfree(info->diri.fscrypt_file);
+	kfree(info->targeti.fscrypt_auth);
+	kfree(info->targeti.fscrypt_file);
 	if (!info->dir_entries)
 		return;
+
+	for (i = 0; i < info->dir_nr; i++) {
+		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
+
+		kfree(rde->inode.fscrypt_auth);
+		kfree(rde->inode.fscrypt_file);
+	}
 	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
 }
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 2e945979a2e0..96d726ee5250 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -88,6 +88,10 @@ struct ceph_mds_reply_info_in {
 	s32 dir_pin;
 	struct ceph_timespec btime;
 	struct ceph_timespec snap_btime;
+	u8 *fscrypt_auth;
+	u8 *fscrypt_file;
+	u32 fscrypt_auth_len;
+	u32 fscrypt_file_len;
 	u64 rsnaps;
 	u64 change_attr;
 };
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index f23e49f46440..e12e5b484564 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -438,6 +438,12 @@ struct ceph_inode_info {
 	struct work_struct i_work;
 	unsigned long  i_work_mask;
 
+#ifdef CONFIG_FS_ENCRYPTION
+	u32 fscrypt_auth_len;
+	u32 fscrypt_file_len;
+	u8 *fscrypt_auth;
+	u8 *fscrypt_file;
+#endif
 #ifdef CONFIG_CEPH_FSCACHE
 	struct fscache_cookie *fscache;
 #endif
-- 
2.35.1

