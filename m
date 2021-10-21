Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE24360AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhJULsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230505AbhJULrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bd9w+/fI9WJupYUQXWmdB7UuwoXlQm1B39YJnmChGl0=;
        b=OZ+82PlTNC2toO0JOy1tX1osPcduEzeaidJp/ltvAthdGl0SE1ApbN4YSVxPuhaXLDfg+h
        AQYrICh7OTDNwRHfV7dd9TcmHiF5Var8KZ68T/CD7xydBQec1F5KqXeJKhFFC+I7zdFcH8
        p6OPQgKm0DZVGDdCRfWhHoWLQ9JtRS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-zaJQXMHvMFqAktB0hJSy1Q-1; Thu, 21 Oct 2021 07:45:16 -0400
X-MC-Unique: zaJQXMHvMFqAktB0hJSy1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD2D8066F1;
        Thu, 21 Oct 2021 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65309652AC;
        Thu, 21 Oct 2021 11:45:14 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/13] ext4: Add fs parameter specifications for mount options
Date:   Thu, 21 Oct 2021 13:44:57 +0200
Message-Id: <20211021114508.21407-3-lczerner@redhat.com>
In-Reply-To: <20211021114508.21407-1-lczerner@redhat.com>
References: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create an array of fs_parameter_spec called ext4_param_specs to
hold the mount option specifications we're going to be using with the
new mount api.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 88d5d274a868..42f4a3741692 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -46,6 +46,8 @@
 #include <linux/part_stat.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 
 #include "ext4.h"
 #include "ext4_extents.h"	/* Needed for trace points definition */
@@ -1681,11 +1683,160 @@ enum {
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
+	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
 };
 
+static const struct constant_table ext4_param_errors[] = {
+	{"continue",	Opt_err_cont},
+	{"panic",	Opt_err_panic},
+	{"remount-ro",	Opt_err_ro},
+	{}
+};
+
+static const struct constant_table ext4_param_data[] = {
+	{"journal",	Opt_data_journal},
+	{"ordered",	Opt_data_ordered},
+	{"writeback",	Opt_data_writeback},
+	{}
+};
+
+static const struct constant_table ext4_param_data_err[] = {
+	{"abort",	Opt_data_err_abort},
+	{"ignore",	Opt_data_err_ignore},
+	{}
+};
+
+static const struct constant_table ext4_param_jqfmt[] = {
+	{"vfsold",	Opt_jqfmt_vfsold},
+	{"vfsv0",	Opt_jqfmt_vfsv0},
+	{"vfsv1",	Opt_jqfmt_vfsv1},
+	{}
+};
+
+static const struct constant_table ext4_param_dax[] = {
+	{"always",	Opt_dax_always},
+	{"inode",	Opt_dax_inode},
+	{"never",	Opt_dax_never},
+	{}
+};
+
+/* String parameter that allows empty argument */
+#define fsparam_string_empty(NAME, OPT) \
+	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
+
+/*
+ * Mount option specification
+ * We don't use fsparam_flag_no because of the way we set the
+ * options and the way we show them in _ext4_show_options(). To
+ * keep the changes to a minimum, let's keep the negative options
+ * separate for now.
+ */
+static const struct fs_parameter_spec ext4_param_specs[] = {
+	fsparam_flag	("bsddf",		Opt_bsd_df),
+	fsparam_flag	("minixdf",		Opt_minix_df),
+	fsparam_flag	("grpid",		Opt_grpid),
+	fsparam_flag	("bsdgroups",		Opt_grpid),
+	fsparam_flag	("nogrpid",		Opt_nogrpid),
+	fsparam_flag	("sysvgroups",		Opt_nogrpid),
+	fsparam_u32	("resgid",		Opt_resgid),
+	fsparam_u32	("resuid",		Opt_resuid),
+	fsparam_u32	("sb",			Opt_sb),
+	fsparam_enum	("errors",		Opt_errors, ext4_param_errors),
+	fsparam_flag	("nouid32",		Opt_nouid32),
+	fsparam_flag	("debug",		Opt_debug),
+	fsparam_flag	("oldalloc",		Opt_removed),
+	fsparam_flag	("orlov",		Opt_removed),
+	fsparam_flag	("user_xattr",		Opt_user_xattr),
+	fsparam_flag	("nouser_xattr",	Opt_nouser_xattr),
+	fsparam_flag	("acl",			Opt_acl),
+	fsparam_flag	("noacl",		Opt_noacl),
+	fsparam_flag	("norecovery",		Opt_noload),
+	fsparam_flag	("noload",		Opt_noload),
+	fsparam_flag	("bh",			Opt_removed),
+	fsparam_flag	("nobh",		Opt_removed),
+	fsparam_u32	("commit",		Opt_commit),
+	fsparam_u32	("min_batch_time",	Opt_min_batch_time),
+	fsparam_u32	("max_batch_time",	Opt_max_batch_time),
+	fsparam_u32	("journal_dev",		Opt_journal_dev),
+	fsparam_bdev	("journal_path",	Opt_journal_path),
+	fsparam_flag	("journal_checksum",	Opt_journal_checksum),
+	fsparam_flag	("nojournal_checksum",	Opt_nojournal_checksum),
+	fsparam_flag	("journal_async_commit",Opt_journal_async_commit),
+	fsparam_flag	("abort",		Opt_abort),
+	fsparam_enum	("data",		Opt_data, ext4_param_data),
+	fsparam_enum	("data_err",		Opt_data_err,
+						ext4_param_data_err),
+	fsparam_string_empty
+			("usrjquota",		Opt_usrjquota),
+	fsparam_string_empty
+			("grpjquota",		Opt_grpjquota),
+	fsparam_enum	("jqfmt",		Opt_jqfmt, ext4_param_jqfmt),
+	fsparam_flag	("grpquota",		Opt_grpquota),
+	fsparam_flag	("quota",		Opt_quota),
+	fsparam_flag	("noquota",		Opt_noquota),
+	fsparam_flag	("usrquota",		Opt_usrquota),
+	fsparam_flag	("prjquota",		Opt_prjquota),
+	fsparam_flag	("barrier",		Opt_barrier),
+	fsparam_u32	("barrier",		Opt_barrier),
+	fsparam_flag	("nobarrier",		Opt_nobarrier),
+	fsparam_flag	("i_version",		Opt_i_version),
+	fsparam_flag	("dax",			Opt_dax),
+	fsparam_enum	("dax",			Opt_dax_type, ext4_param_dax),
+	fsparam_u32	("stripe",		Opt_stripe),
+	fsparam_flag	("delalloc",		Opt_delalloc),
+	fsparam_flag	("nodelalloc",		Opt_nodelalloc),
+	fsparam_flag	("warn_on_error",	Opt_warn_on_error),
+	fsparam_flag	("nowarn_on_error",	Opt_nowarn_on_error),
+	fsparam_flag	("lazytime",		Opt_lazytime),
+	fsparam_flag	("nolazytime",		Opt_nolazytime),
+	fsparam_u32	("debug_want_extra_isize",
+						Opt_debug_want_extra_isize),
+	fsparam_flag	("mblk_io_submit",	Opt_removed),
+	fsparam_flag	("nomblk_io_submit",	Opt_removed),
+	fsparam_flag	("block_validity",	Opt_block_validity),
+	fsparam_flag	("noblock_validity",	Opt_noblock_validity),
+	fsparam_u32	("inode_readahead_blks",
+						Opt_inode_readahead_blks),
+	fsparam_u32	("journal_ioprio",	Opt_journal_ioprio),
+	fsparam_u32	("auto_da_alloc",	Opt_auto_da_alloc),
+	fsparam_flag	("auto_da_alloc",	Opt_auto_da_alloc),
+	fsparam_flag	("noauto_da_alloc",	Opt_noauto_da_alloc),
+	fsparam_flag	("dioread_nolock",	Opt_dioread_nolock),
+	fsparam_flag	("nodioread_nolock",	Opt_dioread_lock),
+	fsparam_flag	("dioread_lock",	Opt_dioread_lock),
+	fsparam_flag	("discard",		Opt_discard),
+	fsparam_flag	("nodiscard",		Opt_nodiscard),
+	fsparam_u32	("init_itable",		Opt_init_itable),
+	fsparam_flag	("init_itable",		Opt_init_itable),
+	fsparam_flag	("noinit_itable",	Opt_noinit_itable),
+#ifdef CONFIG_EXT4_DEBUG
+	fsparam_flag	("fc_debug_force",	Opt_fc_debug_force),
+	fsparam_u32	("fc_debug_max_replay",	Opt_fc_debug_max_replay),
+#endif
+	fsparam_u32	("max_dir_size_kb",	Opt_max_dir_size_kb),
+	fsparam_flag	("test_dummy_encryption",
+						Opt_test_dummy_encryption),
+	fsparam_string	("test_dummy_encryption",
+						Opt_test_dummy_encryption),
+	fsparam_flag	("inlinecrypt",		Opt_inlinecrypt),
+	fsparam_flag	("nombcache",		Opt_nombcache),
+	fsparam_flag	("no_mbcache",		Opt_nombcache),	/* for backward compatibility */
+	fsparam_flag	("prefetch_block_bitmaps",
+						Opt_removed),
+	fsparam_flag	("no_prefetch_block_bitmaps",
+						Opt_no_prefetch_block_bitmaps),
+	fsparam_s32	("mb_optimize_scan",	Opt_mb_optimize_scan),
+	fsparam_string	("check",		Opt_removed),	/* mount option from ext2/3 */
+	fsparam_flag	("nocheck",		Opt_removed),	/* mount option from ext2/3 */
+	fsparam_flag	("reservation",		Opt_removed),	/* mount option from ext2/3 */
+	fsparam_flag	("noreservation",	Opt_removed),	/* mount option from ext2/3 */
+	fsparam_u32	("journal",		Opt_removed),	/* mount option from ext2/3 */
+	{}
+};
+
 static const match_table_t tokens = {
 	{Opt_bsd_df, "bsddf"},
 	{Opt_minix_df, "minixdf"},
-- 
2.31.1

