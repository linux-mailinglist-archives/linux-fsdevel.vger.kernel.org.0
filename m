Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7068D48B6AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350426AbiAKTQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350449AbiAKTQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A3C06173F;
        Tue, 11 Jan 2022 11:16:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B98261260;
        Tue, 11 Jan 2022 19:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5E3C36AE9;
        Tue, 11 Jan 2022 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928576;
        bh=2GPch3V33XgOw4ukyOQphOiW9OrOmvXkpqmGccRI4Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RT8ay7UR39WjcZSX3fExCTcQrOclpbXsaTRkE1ZfL/WNIp4zbhcxH6H1cgK6Vm7gw
         flyEAVeChydWcqz++Lvw/PzMPNzM77+sTIc151X3IemWaa/kRIl9XGc4gw4AwO9FPx
         W5GHO2eUPrUlgGRWAaFfIu6QbXGyZpuqq7uVNP8b12/TiRxH0EGX5eDMUuQdZAAgjx
         gnJp8vswGStyFfCj/Iid76GQVqpu0+H3NYPvYbzndHvSl1f0DP12hktPIca2UX2j3/
         hZ7PN3tMmV1RAzx6jzWdl5YxPmHMoKBxJXoCU/RzssbJx9q0fw1ztiumdmfE5yw6pz
         oNBo0orBN9GQg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 07/48] ceph: parse new fscrypt_auth and fscrypt_file fields in inode traces
Date:   Tue, 11 Jan 2022 14:15:27 -0500
Message-Id: <20220111191608.88762-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...and store them in the ceph_inode_info.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c       |  2 ++
 fs/ceph/inode.c      | 18 ++++++++++++++-
 fs/ceph/mds_client.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  4 ++++
 fs/ceph/super.h      |  6 +++++
 5 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ace72a052254..5937a25ddddd 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -597,6 +597,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	iinfo.xattr_data = xattr_buf;
 	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
 
+	/* FIXME: set fscrypt_auth and fscrypt_file */
+
 	in.ino = cpu_to_le64(vino.ino);
 	in.snapid = cpu_to_le64(CEPH_NOSNAP);
 	in.version = cpu_to_le64(1);	// ???
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 649d7a059d7b..d090fe081093 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -609,7 +609,10 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
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
@@ -620,6 +623,9 @@ void ceph_free_inode(struct inode *inode)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	kfree(ci->i_symlink);
+#ifdef CONFIG_FS_ENCRYPTION
+	kfree(ci->fscrypt_auth);
+#endif
 	kmem_cache_free(ceph_inode_cachep, ci);
 }
 
@@ -1020,6 +1026,16 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
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
index 57cf21c9199f..bd824e989449 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -184,8 +184,50 @@ static int parse_reply_info_in(void **p, void *end,
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
+		info->fscrypt_file = NULL;
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
@@ -626,8 +668,21 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 
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
index c3986a412fb5..98a8710807d1 100644
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
index 532ee9fca878..5b4092e5f291 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -433,6 +433,12 @@ struct ceph_inode_info {
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
2.34.1

