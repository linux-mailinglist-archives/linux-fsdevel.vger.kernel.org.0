Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872F84360B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhJULsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231232AbhJULru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ut1Cgv8d+XAiY6laTTF4x/X2AmUg4DeGYK3iV2eB2U=;
        b=h0G+owscEbS8Q54fVeh780pHLlgR7xUp9OCsxvCPsapV6qStv9qGdUDhsmu9HEvCrIjpie
        dYq+SupmbDXT+IAI11LPYXZgRzWBIw7j4ifVoDGzfNmKClyasjucrnKnJS1uNrYVxCY9lF
        qSnk4Yi56w0/a+9CdxtedmBGUxBuu+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-f88uIu7uPw-pYZsAt90qrA-1; Thu, 21 Oct 2021 07:45:30 -0400
X-MC-Unique: f88uIu7uPw-pYZsAt90qrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 752F31808308;
        Thu, 21 Oct 2021 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6372F6911D;
        Thu, 21 Oct 2021 11:45:28 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 13/13] ext4: Remove unused match_table_t tokens
Date:   Thu, 21 Oct 2021 13:45:08 +0200
Message-Id: <20211021114508.21407-14-lczerner@redhat.com>
In-Reply-To: <20211021114508.21407-1-lczerner@redhat.com>
References: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unused match_table_t, slim down mount_opts structure by removing
unnecessary definitions, remove redundant MOPT_ flags and clean up
ext4_parse_param() by converting the most of the if/else branching to
switch except for the MOPT_SET/MOPT_CEAR handling.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 374 +++++++++++++++++-------------------------------
 1 file changed, 131 insertions(+), 243 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16d434a512d8..c4674e943905 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1682,7 +1682,7 @@ static const struct export_operations ext4_export_ops = {
 
 enum {
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
-	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
+	Opt_resgid, Opt_resuid, Opt_sb,
 	Opt_nouid32, Opt_debug, Opt_removed,
 	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
 	Opt_auto_da_alloc, Opt_noauto_da_alloc, Opt_noload,
@@ -1691,8 +1691,7 @@ enum {
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_data_err_abort, Opt_data_err_ignore, Opt_test_dummy_encryption,
 	Opt_inlinecrypt,
-	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
-	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
+	Opt_usrjquota, Opt_grpjquota, Opt_quota,
 	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
 	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version,
 	Opt_dax, Opt_dax_always, Opt_dax_inode, Opt_dax_never,
@@ -1712,16 +1711,16 @@ enum {
 };
 
 static const struct constant_table ext4_param_errors[] = {
-	{"continue",	Opt_err_cont},
-	{"panic",	Opt_err_panic},
-	{"remount-ro",	Opt_err_ro},
+	{"continue",	EXT4_MOUNT_ERRORS_CONT},
+	{"panic",	EXT4_MOUNT_ERRORS_PANIC},
+	{"remount-ro",	EXT4_MOUNT_ERRORS_RO},
 	{}
 };
 
 static const struct constant_table ext4_param_data[] = {
-	{"journal",	Opt_data_journal},
-	{"ordered",	Opt_data_ordered},
-	{"writeback",	Opt_data_writeback},
+	{"journal",	EXT4_MOUNT_JOURNAL_DATA},
+	{"ordered",	EXT4_MOUNT_ORDERED_DATA},
+	{"writeback",	EXT4_MOUNT_WRITEBACK_DATA},
 	{}
 };
 
@@ -1732,9 +1731,9 @@ static const struct constant_table ext4_param_data_err[] = {
 };
 
 static const struct constant_table ext4_param_jqfmt[] = {
-	{"vfsold",	Opt_jqfmt_vfsold},
-	{"vfsv0",	Opt_jqfmt_vfsv0},
-	{"vfsv1",	Opt_jqfmt_vfsv1},
+	{"vfsold",	QFMT_VFS_OLD},
+	{"vfsv0",	QFMT_VFS_V0},
+	{"vfsv1",	QFMT_VFS_V1},
 	{}
 };
 
@@ -1859,111 +1858,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	{}
 };
 
-static const match_table_t tokens = {
-	{Opt_bsd_df, "bsddf"},
-	{Opt_minix_df, "minixdf"},
-	{Opt_grpid, "grpid"},
-	{Opt_grpid, "bsdgroups"},
-	{Opt_nogrpid, "nogrpid"},
-	{Opt_nogrpid, "sysvgroups"},
-	{Opt_resgid, "resgid=%u"},
-	{Opt_resuid, "resuid=%u"},
-	{Opt_sb, "sb=%u"},
-	{Opt_err_cont, "errors=continue"},
-	{Opt_err_panic, "errors=panic"},
-	{Opt_err_ro, "errors=remount-ro"},
-	{Opt_nouid32, "nouid32"},
-	{Opt_debug, "debug"},
-	{Opt_removed, "oldalloc"},
-	{Opt_removed, "orlov"},
-	{Opt_user_xattr, "user_xattr"},
-	{Opt_nouser_xattr, "nouser_xattr"},
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_noload, "norecovery"},
-	{Opt_noload, "noload"},
-	{Opt_removed, "nobh"},
-	{Opt_removed, "bh"},
-	{Opt_commit, "commit=%u"},
-	{Opt_min_batch_time, "min_batch_time=%u"},
-	{Opt_max_batch_time, "max_batch_time=%u"},
-	{Opt_journal_dev, "journal_dev=%u"},
-	{Opt_journal_path, "journal_path=%s"},
-	{Opt_journal_checksum, "journal_checksum"},
-	{Opt_nojournal_checksum, "nojournal_checksum"},
-	{Opt_journal_async_commit, "journal_async_commit"},
-	{Opt_abort, "abort"},
-	{Opt_data_journal, "data=journal"},
-	{Opt_data_ordered, "data=ordered"},
-	{Opt_data_writeback, "data=writeback"},
-	{Opt_data_err_abort, "data_err=abort"},
-	{Opt_data_err_ignore, "data_err=ignore"},
-	{Opt_offusrjquota, "usrjquota="},
-	{Opt_usrjquota, "usrjquota=%s"},
-	{Opt_offgrpjquota, "grpjquota="},
-	{Opt_grpjquota, "grpjquota=%s"},
-	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
-	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
-	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
-	{Opt_grpquota, "grpquota"},
-	{Opt_noquota, "noquota"},
-	{Opt_quota, "quota"},
-	{Opt_usrquota, "usrquota"},
-	{Opt_prjquota, "prjquota"},
-	{Opt_barrier, "barrier=%u"},
-	{Opt_barrier, "barrier"},
-	{Opt_nobarrier, "nobarrier"},
-	{Opt_i_version, "i_version"},
-	{Opt_dax, "dax"},
-	{Opt_dax_always, "dax=always"},
-	{Opt_dax_inode, "dax=inode"},
-	{Opt_dax_never, "dax=never"},
-	{Opt_stripe, "stripe=%u"},
-	{Opt_delalloc, "delalloc"},
-	{Opt_warn_on_error, "warn_on_error"},
-	{Opt_nowarn_on_error, "nowarn_on_error"},
-	{Opt_lazytime, "lazytime"},
-	{Opt_nolazytime, "nolazytime"},
-	{Opt_debug_want_extra_isize, "debug_want_extra_isize=%u"},
-	{Opt_nodelalloc, "nodelalloc"},
-	{Opt_removed, "mblk_io_submit"},
-	{Opt_removed, "nomblk_io_submit"},
-	{Opt_block_validity, "block_validity"},
-	{Opt_noblock_validity, "noblock_validity"},
-	{Opt_inode_readahead_blks, "inode_readahead_blks=%u"},
-	{Opt_journal_ioprio, "journal_ioprio=%u"},
-	{Opt_auto_da_alloc, "auto_da_alloc=%u"},
-	{Opt_auto_da_alloc, "auto_da_alloc"},
-	{Opt_noauto_da_alloc, "noauto_da_alloc"},
-	{Opt_dioread_nolock, "dioread_nolock"},
-	{Opt_dioread_lock, "nodioread_nolock"},
-	{Opt_dioread_lock, "dioread_lock"},
-	{Opt_discard, "discard"},
-	{Opt_nodiscard, "nodiscard"},
-	{Opt_init_itable, "init_itable=%u"},
-	{Opt_init_itable, "init_itable"},
-	{Opt_noinit_itable, "noinit_itable"},
-#ifdef CONFIG_EXT4_DEBUG
-	{Opt_fc_debug_force, "fc_debug_force"},
-	{Opt_fc_debug_max_replay, "fc_debug_max_replay=%u"},
-#endif
-	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
-	{Opt_test_dummy_encryption, "test_dummy_encryption=%s"},
-	{Opt_test_dummy_encryption, "test_dummy_encryption"},
-	{Opt_inlinecrypt, "inlinecrypt"},
-	{Opt_nombcache, "nombcache"},
-	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
-	{Opt_removed, "prefetch_block_bitmaps"},
-	{Opt_no_prefetch_block_bitmaps, "no_prefetch_block_bitmaps"},
-	{Opt_mb_optimize_scan, "mb_optimize_scan=%d"},
-	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
-	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
-	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
-	{Opt_removed, "noreservation"}, /* mount option from ext2/3 */
-	{Opt_removed, "journal=%u"},	/* mount option from ext2/3 */
-	{Opt_err, NULL},
-};
-
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 #define DEFAULT_MB_OPTIMIZE_SCAN	(-1)
 
@@ -1975,22 +1869,18 @@ static const char deprecated_msg[] =
 #define MOPT_CLEAR	0x0002
 #define MOPT_NOSUPPORT	0x0004
 #define MOPT_EXPLICIT	0x0008
-#define MOPT_CLEAR_ERR	0x0010
-#define MOPT_GTE0	0x0020
 #ifdef CONFIG_QUOTA
 #define MOPT_Q		0
-#define MOPT_QFMT	0x0040
+#define MOPT_QFMT	0x0010
 #else
 #define MOPT_Q		MOPT_NOSUPPORT
 #define MOPT_QFMT	MOPT_NOSUPPORT
 #endif
-#define MOPT_DATAJ	0x0080
-#define MOPT_NO_EXT2	0x0100
-#define MOPT_NO_EXT3	0x0200
+#define MOPT_NO_EXT2	0x0020
+#define MOPT_NO_EXT3	0x0040
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
-#define MOPT_STRING	0x0400
-#define MOPT_SKIP	0x0800
-#define	MOPT_2		0x1000
+#define MOPT_SKIP	0x0080
+#define	MOPT_2		0x0100
 
 static const struct mount_opts {
 	int	token;
@@ -2023,40 +1913,17 @@ static const struct mount_opts {
 				    EXT4_MOUNT_JOURNAL_CHECKSUM),
 	 MOPT_EXT4_ONLY | MOPT_SET | MOPT_EXPLICIT},
 	{Opt_noload, EXT4_MOUNT_NOLOAD, MOPT_NO_EXT2 | MOPT_SET},
-	{Opt_err_panic, EXT4_MOUNT_ERRORS_PANIC, MOPT_SET | MOPT_CLEAR_ERR},
-	{Opt_err_ro, EXT4_MOUNT_ERRORS_RO, MOPT_SET | MOPT_CLEAR_ERR},
-	{Opt_err_cont, EXT4_MOUNT_ERRORS_CONT, MOPT_SET | MOPT_CLEAR_ERR},
-	{Opt_data_err_abort, EXT4_MOUNT_DATA_ERR_ABORT,
-	 MOPT_NO_EXT2},
-	{Opt_data_err_ignore, EXT4_MOUNT_DATA_ERR_ABORT,
-	 MOPT_NO_EXT2},
+	{Opt_data_err, EXT4_MOUNT_DATA_ERR_ABORT, MOPT_NO_EXT2},
 	{Opt_barrier, EXT4_MOUNT_BARRIER, MOPT_SET},
 	{Opt_nobarrier, EXT4_MOUNT_BARRIER, MOPT_CLEAR},
 	{Opt_noauto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_SET},
 	{Opt_auto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_CLEAR},
 	{Opt_noinit_itable, EXT4_MOUNT_INIT_INODE_TABLE, MOPT_CLEAR},
-	{Opt_commit, 0, MOPT_GTE0},
-	{Opt_max_batch_time, 0, MOPT_GTE0},
-	{Opt_min_batch_time, 0, MOPT_GTE0},
-	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
-	{Opt_init_itable, 0, MOPT_GTE0},
-	{Opt_dax, EXT4_MOUNT_DAX_ALWAYS, MOPT_SET | MOPT_SKIP},
-	{Opt_dax_always, EXT4_MOUNT_DAX_ALWAYS,
-		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
-	{Opt_dax_inode, EXT4_MOUNT2_DAX_INODE,
-		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
-	{Opt_dax_never, EXT4_MOUNT2_DAX_NEVER,
-		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
-	{Opt_stripe, 0, MOPT_GTE0},
-	{Opt_resuid, 0, MOPT_GTE0},
-	{Opt_resgid, 0, MOPT_GTE0},
-	{Opt_journal_dev, 0, MOPT_NO_EXT2 | MOPT_GTE0},
-	{Opt_journal_path, 0, MOPT_NO_EXT2 | MOPT_STRING},
-	{Opt_journal_ioprio, 0, MOPT_NO_EXT2 | MOPT_GTE0},
-	{Opt_data_journal, EXT4_MOUNT_JOURNAL_DATA, MOPT_NO_EXT2 | MOPT_DATAJ},
-	{Opt_data_ordered, EXT4_MOUNT_ORDERED_DATA, MOPT_NO_EXT2 | MOPT_DATAJ},
-	{Opt_data_writeback, EXT4_MOUNT_WRITEBACK_DATA,
-	 MOPT_NO_EXT2 | MOPT_DATAJ},
+	{Opt_dax_type, 0, MOPT_EXT4_ONLY},
+	{Opt_journal_dev, 0, MOPT_NO_EXT2},
+	{Opt_journal_path, 0, MOPT_NO_EXT2},
+	{Opt_journal_ioprio, 0, MOPT_NO_EXT2},
+	{Opt_data, 0, MOPT_NO_EXT2},
 	{Opt_user_xattr, EXT4_MOUNT_XATTR_USER, MOPT_SET},
 	{Opt_nouser_xattr, EXT4_MOUNT_XATTR_USER, MOPT_CLEAR},
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
@@ -2068,7 +1935,6 @@ static const struct mount_opts {
 #endif
 	{Opt_nouid32, EXT4_MOUNT_NO_UID32, MOPT_SET},
 	{Opt_debug, EXT4_MOUNT_DEBUG, MOPT_SET},
-	{Opt_debug_want_extra_isize, 0, MOPT_GTE0},
 	{Opt_quota, EXT4_MOUNT_QUOTA | EXT4_MOUNT_USRQUOTA, MOPT_SET | MOPT_Q},
 	{Opt_usrquota, EXT4_MOUNT_QUOTA | EXT4_MOUNT_USRQUOTA,
 							MOPT_SET | MOPT_Q},
@@ -2079,23 +1945,15 @@ static const struct mount_opts {
 	{Opt_noquota, (EXT4_MOUNT_QUOTA | EXT4_MOUNT_USRQUOTA |
 		       EXT4_MOUNT_GRPQUOTA | EXT4_MOUNT_PRJQUOTA),
 							MOPT_CLEAR | MOPT_Q},
-	{Opt_usrjquota, 0, MOPT_Q | MOPT_STRING},
-	{Opt_grpjquota, 0, MOPT_Q | MOPT_STRING},
-	{Opt_offusrjquota, 0, MOPT_Q},
-	{Opt_offgrpjquota, 0, MOPT_Q},
-	{Opt_jqfmt_vfsold, QFMT_VFS_OLD, MOPT_QFMT},
-	{Opt_jqfmt_vfsv0, QFMT_VFS_V0, MOPT_QFMT},
-	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
-	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
-	{Opt_test_dummy_encryption, 0, MOPT_STRING},
+	{Opt_usrjquota, 0, MOPT_Q},
+	{Opt_grpjquota, 0, MOPT_Q},
+	{Opt_jqfmt, 0, MOPT_QFMT},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
-	{Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN, MOPT_GTE0},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
-	{Opt_fc_debug_max_replay, 0, MOPT_GTE0},
 #endif
 	{Opt_err, 0, 0}
 };
@@ -2324,20 +2182,41 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		return token;
 	is_remount = fc->purpose == FS_CONTEXT_FOR_RECONFIGURE;
 
+	for (m = ext4_mount_opts; m->token != Opt_err; m++)
+		if (token == m->token)
+			break;
+
+	ctx->opt_flags |= m->flags;
+
+	if (m->flags & MOPT_EXPLICIT) {
+		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
+			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_EXPLICIT_DELALLOC);
+		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
+			ctx_set_mount_opt2(ctx,
+				       EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM);
+		} else
+			return -EINVAL;
+	}
+
+	if (m->flags & MOPT_NOSUPPORT) {
+		ext4_msg(NULL, KERN_ERR, "%s option not supported",
+			 param->key);
+		return 0;
+	}
+
+	switch (token) {
 #ifdef CONFIG_QUOTA
-	if (token == Opt_usrjquota) {
+	case Opt_usrjquota:
 		if (!*param->string)
 			return unnote_qf_name(fc, USRQUOTA);
 		else
 			return note_qf_name(fc, USRQUOTA, param);
-	} else if (token == Opt_grpjquota) {
+	case Opt_grpjquota:
 		if (!*param->string)
 			return unnote_qf_name(fc, GRPQUOTA);
 		else
 			return note_qf_name(fc, GRPQUOTA, param);
-	}
 #endif
-	switch (token) {
 	case Opt_noacl:
 	case Opt_nouser_xattr:
 		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
@@ -2375,41 +2254,21 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 #endif
 		return 0;
 	case Opt_errors:
-	case Opt_data:
-	case Opt_data_err:
-	case Opt_jqfmt:
-	case Opt_dax_type:
-		token = result.uint_32;
-	}
-
-	for (m = ext4_mount_opts; m->token != Opt_err; m++)
-		if (token == m->token)
-			break;
-
-	ctx->opt_flags |= m->flags;
-
-	if (m->token == Opt_err) {
-		ext4_msg(NULL, KERN_ERR, "Unrecognized mount option \"%s\" "
-			 "or missing value", param->key);
-		return -EINVAL;
-	}
-
-	if (m->flags & MOPT_EXPLICIT) {
-		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
-			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_EXPLICIT_DELALLOC);
-		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
-			ctx_set_mount_opt2(ctx,
-				       EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM);
-		} else
-			return -EINVAL;
-	}
-	if (m->flags & MOPT_CLEAR_ERR)
 		ctx_clear_mount_opt(ctx, EXT4_MOUNT_ERRORS_MASK);
-
-	if (m->flags & MOPT_NOSUPPORT) {
-		ext4_msg(NULL, KERN_ERR, "%s option not supported",
-			 param->key);
-	} else if (token == Opt_commit) {
+		ctx_set_mount_opt(ctx, result.uint_32);
+		return 0;
+#ifdef CONFIG_QUOTA
+	case Opt_jqfmt:
+		ctx->s_jquota_fmt = result.uint_32;
+		ctx->spec |= EXT4_SPEC_JQFMT;
+		return 0;
+#endif
+	case Opt_data:
+		ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
+		ctx_set_mount_opt(ctx, result.uint_32);
+		ctx->spec |= EXT4_SPEC_DATAJ;
+		return 0;
+	case Opt_commit:
 		if (result.uint_32 == 0)
 			ctx->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE;
 		else if (result.uint_32 > INT_MAX / HZ) {
@@ -2421,7 +2280,8 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		}
 		ctx->s_commit_interval = HZ * result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_commit_interval;
-	} else if (token == Opt_debug_want_extra_isize) {
+		return 0;
+	case Opt_debug_want_extra_isize:
 		if ((result.uint_32 & 1) || (result.uint_32 < 4)) {
 			ext4_msg(NULL, KERN_ERR,
 				 "Invalid want_extra_isize %d", result.uint_32);
@@ -2429,13 +2289,16 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		}
 		ctx->s_want_extra_isize = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_want_extra_isize;
-	} else if (token == Opt_max_batch_time) {
+		return 0;
+	case Opt_max_batch_time:
 		ctx->s_max_batch_time = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_max_batch_time;
-	} else if (token == Opt_min_batch_time) {
+		return 0;
+	case Opt_min_batch_time:
 		ctx->s_min_batch_time = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_min_batch_time;
-	} else if (token == Opt_inode_readahead_blks) {
+		return 0;
+	case Opt_inode_readahead_blks:
 		if (result.uint_32 &&
 		    (result.uint_32 > (1 << 30) ||
 		     !is_power_of_2(result.uint_32))) {
@@ -2446,24 +2309,29 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		}
 		ctx->s_inode_readahead_blks = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_inode_readahead_blks;
-	} else if (token == Opt_init_itable) {
+		return 0;
+	case Opt_init_itable:
 		ctx_set_mount_opt(ctx, EXT4_MOUNT_INIT_INODE_TABLE);
 		ctx->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
 		if (param->type == fs_value_is_string)
 			ctx->s_li_wait_mult = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_li_wait_mult;
-	} else if (token == Opt_max_dir_size_kb) {
+		return 0;
+	case Opt_max_dir_size_kb:
 		ctx->s_max_dir_size_kb = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_max_dir_size_kb;
+		return 0;
 #ifdef CONFIG_EXT4_DEBUG
-	} else if (token == Opt_fc_debug_max_replay) {
+	case Opt_fc_debug_max_replay:
 		ctx->s_fc_debug_max_replay = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_fc_debug_max_replay;
+		return 0;
 #endif
-	} else if (token == Opt_stripe) {
+	case Opt_stripe:
 		ctx->s_stripe = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_stripe;
-	} else if (token == Opt_resuid) {
+		return 0;
+	case Opt_resuid:
 		uid = make_kuid(current_user_ns(), result.uint_32);
 		if (!uid_valid(uid)) {
 			ext4_msg(NULL, KERN_ERR, "Invalid uid value %d",
@@ -2472,7 +2340,8 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		}
 		ctx->s_resuid = uid;
 		ctx->spec |= EXT4_SPEC_s_resuid;
-	} else if (token == Opt_resgid) {
+		return 0;
+	case Opt_resgid:
 		gid = make_kgid(current_user_ns(), result.uint_32);
 		if (!gid_valid(gid)) {
 			ext4_msg(NULL, KERN_ERR, "Invalid gid value %d",
@@ -2481,7 +2350,8 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		}
 		ctx->s_resgid = gid;
 		ctx->spec |= EXT4_SPEC_s_resgid;
-	} else if (token == Opt_journal_dev) {
+		return 0;
+	case Opt_journal_dev:
 		if (is_remount) {
 			ext4_msg(NULL, KERN_ERR,
 				 "Cannot specify journal on remount");
@@ -2489,7 +2359,9 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		}
 		ctx->journal_devnum = result.uint_32;
 		ctx->spec |= EXT4_SPEC_JOURNAL_DEV;
-	} else if (token == Opt_journal_path) {
+		return 0;
+	case Opt_journal_path:
+	{
 		struct inode *journal_inode;
 		struct path path;
 		int error;
@@ -2511,7 +2383,9 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->journal_devnum = new_encode_dev(journal_inode->i_rdev);
 		ctx->spec |= EXT4_SPEC_JOURNAL_DEV;
 		path_put(&path);
-	} else if (token == Opt_journal_ioprio) {
+		return 0;
+	}
+	case Opt_journal_ioprio:
 		if (result.uint_32 > 7) {
 			ext4_msg(NULL, KERN_ERR, "Invalid journal IO priority"
 				 " (must be 0-7)");
@@ -2520,7 +2394,8 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->journal_ioprio =
 			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
 		ctx->spec |= EXT4_SPEC_JOURNAL_IOPRIO;
-	} else if (token == Opt_test_dummy_encryption) {
+		return 0;
+	case Opt_test_dummy_encryption:
 #ifdef CONFIG_FS_ENCRYPTION
 		if (param->type == fs_value_is_flag) {
 			ctx->spec |= EXT4_SPEC_DUMMY_ENCRYPTION;
@@ -2542,53 +2417,65 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ext4_msg(NULL, KERN_WARNING,
 			 "Test dummy encryption mount option ignored");
 #endif
-	} else if (m->flags & MOPT_DATAJ) {
-		ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
-		ctx_set_mount_opt(ctx, m->mount_opt);
-		ctx->spec |= EXT4_SPEC_DATAJ;
-#ifdef CONFIG_QUOTA
-	} else if (m->flags & MOPT_QFMT) {
-		ctx->s_jquota_fmt = m->mount_opt;
-		ctx->spec |= EXT4_SPEC_JQFMT;
-#endif
-	} else if (token == Opt_dax || token == Opt_dax_always ||
-		   token == Opt_dax_inode || token == Opt_dax_never) {
+		return 0;
+	case Opt_dax:
+	case Opt_dax_type:
 #ifdef CONFIG_FS_DAX
-		switch (token) {
+	{
+		int type = (token == Opt_dax) ?
+			   Opt_dax : result.uint_32;
+
+		switch (type) {
 		case Opt_dax:
 		case Opt_dax_always:
-			ctx_set_mount_opt(ctx, m->mount_opt);
+			ctx_set_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
 			ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
 			break;
 		case Opt_dax_never:
-			ctx_set_mount_opt2(ctx, m->mount_opt);
+			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
 			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
 			break;
 		case Opt_dax_inode:
 			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
 			ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
 			/* Strictly for printing options */
-			ctx_set_mount_opt2(ctx, m->mount_opt);
+			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_INODE);
 			break;
 		}
+		return 0;
+	}
 #else
 		ext4_msg(NULL, KERN_INFO, "dax option not supported");
-		ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
-		ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
 		return -EINVAL;
 #endif
-	} else if (token == Opt_data_err_abort) {
-		ctx_set_mount_opt(ctx, m->mount_opt);
-	} else if (token == Opt_data_err_ignore) {
-		ctx_clear_mount_opt(ctx, m->mount_opt);
-	} else if (token == Opt_mb_optimize_scan) {
+	case Opt_data_err:
+		if (result.uint_32 == Opt_data_err_abort)
+			ctx_set_mount_opt(ctx, m->mount_opt);
+		else if (result.uint_32 == Opt_data_err_ignore)
+			ctx_clear_mount_opt(ctx, m->mount_opt);
+		return 0;
+	case Opt_mb_optimize_scan:
 		if (result.int_32 != 0 && result.int_32 != 1) {
 			ext4_msg(NULL, KERN_WARNING,
 				 "mb_optimize_scan should be set to 0 or 1.");
 			return -EINVAL;
 		}
 		ctx->mb_optimize_scan = result.int_32;
-	} else {
+		return 0;
+	}
+
+	/*
+	 * At this point we should only be getting options requiring MOPT_SET,
+	 * or MOPT_CLEAR. Anything else is a bug
+	 */
+	if (m->token == Opt_err) {
+		ext4_msg(NULL, KERN_WARNING, "buggy handling of option %s",
+			 param->key);
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	else {
 		unsigned int set = 0;
 
 		if ((param->type == fs_value_is_flag) ||
@@ -2616,6 +2503,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 				ctx_clear_mount_opt(ctx, m->mount_opt);
 		}
 	}
+
 	return 0;
 }
 
@@ -3103,7 +2991,7 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	for (m = ext4_mount_opts; m->token != Opt_err; m++) {
 		int want_set = m->flags & MOPT_SET;
 		if (((m->flags & (MOPT_SET|MOPT_CLEAR)) == 0) ||
-		    (m->flags & MOPT_CLEAR_ERR) || m->flags & MOPT_SKIP)
+		    m->flags & MOPT_SKIP)
 			continue;
 		if (!nodefs && !(m->mount_opt & (sbi->s_mount_opt ^ def_mount_opt)))
 			continue; /* skip if same as the default */
-- 
2.31.1

