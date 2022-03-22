Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CBE4E40F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiCVORa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiCVOPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65246B6B;
        Tue, 22 Mar 2022 07:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C2A9B81CFB;
        Tue, 22 Mar 2022 14:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B609C340F2;
        Tue, 22 Mar 2022 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958405;
        bh=tVadd8LwjoyYofOsJbAOFQlVirx99R4joCkVOsRtgQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ippsUmTNG88pDO7iRnlMD/ccEvVyzV7yGqjcoyrE8rl2HA+muiD1PqER/uWKmLRCq
         3hQgl6ci8irUzREpSw0m41MWrJNB+7Aa4c2mz/5PhvQbzHXE+8Mcx9OZPB2QeCOP6H
         0HdY7PoclWB+uUgQ6/NWemY231uXC7aoIlcOLLXt89X4+KXnUAd0l3qOoT87praxrt
         P0W2F9rlqg5bkb22Jk6dWZiQQSym/Yawz4ZbW+dYrK/oM52vDk+yJsO206Wnd9SugP
         ORiaN+jraLFUYzwpKAS56nWD15yV6I0Y67h/bhPquCC/6tNwRCyNiEKGo87bg9PAg1
         7lUoLE42hloPQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 07/51] ceph: parse new fscrypt_auth and fscrypt_file fields in inode traces
Date:   Tue, 22 Mar 2022 10:12:32 -0400
Message-Id: <20220322141316.41325-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...and store them in the ceph_inode_info.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c       |  2 ++
 fs/ceph/inode.c      | 18 +++++++++++++-
 fs/ceph/mds_client.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  4 ++++
 fs/ceph/super.h      |  6 +++++
 5 files changed, 86 insertions(+), 1 deletion(-)

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
index 2e0e321a58cb..2c9a482444e0 100644
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
index e64a8cefdb7f..8e7ef76d80ea 100644
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

