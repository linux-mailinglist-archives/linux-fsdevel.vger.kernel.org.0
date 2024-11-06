Return-Path: <linux-fsdevel+bounces-33780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7089BEB66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF42847FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF031F76C0;
	Wed,  6 Nov 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnrIZ6/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D81EABB4;
	Wed,  6 Nov 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897047; cv=none; b=C3H2DJnPYbL1NlrCaseBHvDA3jS0MW4U1NeOw9gwNvVSkZfumFjwe6MFLrY1nYgK36ibVCC6D2EY70FNTuuCfFRks0fsEYRo0BGWcYy8rbVfgIj1TOCjodf3BGr4xEloEkJ4KjgrrdHCZANS8O2M4w9RaxZiiI6EZRyBSNiEBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897047; c=relaxed/simple;
	bh=Frj4Ogwq6Y1vQinHa87bLiHzhSHlVsD4JFf2H8rye9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7j7XolQxGX3KIQbtdPJP09KQySsQxr4yxZcka+yt4lKjHBnE9uzIkB6d+tFu6idqCAbZInNcbvODehxWxGIKxFVaptn4iVK4LWQUtBJfYKl1RdYmApWFBPZNv3uQ2cqdt4Q4ReePjoOFNFnX1s5pm6F63baMXMCXQ0O1D/zPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnrIZ6/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE429C4CECD;
	Wed,  6 Nov 2024 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897047;
	bh=Frj4Ogwq6Y1vQinHa87bLiHzhSHlVsD4JFf2H8rye9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnrIZ6/ryWl0BiL2ThVHU0qj0xIygeMQ8KncHm+d/koFII/Ul2XSDywYiLYAjux8c
	 7oO4BmTOmO7tEDBWQYpMCuLv9uP608Cez3bs+rgKW4SwE5u4Ij9nPSv58AVGpRyU7H
	 Awfa686dQYqM75xCspgdAK9Gm4uXWRmRJyD3Yjyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 049/126] afs: Automatically generate trace tag enums
Date: Wed,  6 Nov 2024 13:04:10 +0100
Message-ID: <20241106120307.428878329@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2daa6404fd2f00985d5bfeb3c161f4630b46b6bf ]

Automatically generate trace tag enums from the symbol -> string mapping
tables rather than having the enums as well, thereby reducing duplicated
data.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Stable-dep-of: 247d65fb122a ("afs: Fix missing subdir edit when renamed between parent dirs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/afs.h | 233 +++++--------------------------------
 1 file changed, 27 insertions(+), 206 deletions(-)

diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index e9d412d19dbbb..54d10c69e55ec 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -18,97 +18,6 @@
 #ifndef __AFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __AFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
-enum afs_call_trace {
-	afs_call_trace_alloc,
-	afs_call_trace_free,
-	afs_call_trace_get,
-	afs_call_trace_put,
-	afs_call_trace_wake,
-	afs_call_trace_work,
-};
-
-enum afs_server_trace {
-	afs_server_trace_alloc,
-	afs_server_trace_callback,
-	afs_server_trace_destroy,
-	afs_server_trace_free,
-	afs_server_trace_gc,
-	afs_server_trace_get_by_addr,
-	afs_server_trace_get_by_uuid,
-	afs_server_trace_get_caps,
-	afs_server_trace_get_install,
-	afs_server_trace_get_new_cbi,
-	afs_server_trace_get_probe,
-	afs_server_trace_give_up_cb,
-	afs_server_trace_purging,
-	afs_server_trace_put_call,
-	afs_server_trace_put_cbi,
-	afs_server_trace_put_find_rsq,
-	afs_server_trace_put_probe,
-	afs_server_trace_put_slist,
-	afs_server_trace_put_slist_isort,
-	afs_server_trace_put_uuid_rsq,
-	afs_server_trace_update,
-};
-
-
-enum afs_volume_trace {
-	afs_volume_trace_alloc,
-	afs_volume_trace_free,
-	afs_volume_trace_get_alloc_sbi,
-	afs_volume_trace_get_cell_insert,
-	afs_volume_trace_get_new_op,
-	afs_volume_trace_get_query_alias,
-	afs_volume_trace_put_cell_dup,
-	afs_volume_trace_put_cell_root,
-	afs_volume_trace_put_destroy_sbi,
-	afs_volume_trace_put_free_fc,
-	afs_volume_trace_put_put_op,
-	afs_volume_trace_put_query_alias,
-	afs_volume_trace_put_validate_fc,
-	afs_volume_trace_remove,
-};
-
-enum afs_cell_trace {
-	afs_cell_trace_alloc,
-	afs_cell_trace_free,
-	afs_cell_trace_get_queue_dns,
-	afs_cell_trace_get_queue_manage,
-	afs_cell_trace_get_queue_new,
-	afs_cell_trace_get_vol,
-	afs_cell_trace_insert,
-	afs_cell_trace_manage,
-	afs_cell_trace_put_candidate,
-	afs_cell_trace_put_destroy,
-	afs_cell_trace_put_queue_fail,
-	afs_cell_trace_put_queue_work,
-	afs_cell_trace_put_vol,
-	afs_cell_trace_see_source,
-	afs_cell_trace_see_ws,
-	afs_cell_trace_unuse_alias,
-	afs_cell_trace_unuse_check_alias,
-	afs_cell_trace_unuse_delete,
-	afs_cell_trace_unuse_fc,
-	afs_cell_trace_unuse_lookup,
-	afs_cell_trace_unuse_mntpt,
-	afs_cell_trace_unuse_no_pin,
-	afs_cell_trace_unuse_parse,
-	afs_cell_trace_unuse_pin,
-	afs_cell_trace_unuse_probe,
-	afs_cell_trace_unuse_sbi,
-	afs_cell_trace_unuse_ws,
-	afs_cell_trace_use_alias,
-	afs_cell_trace_use_check_alias,
-	afs_cell_trace_use_fc,
-	afs_cell_trace_use_fc_alias,
-	afs_cell_trace_use_lookup,
-	afs_cell_trace_use_mntpt,
-	afs_cell_trace_use_pin,
-	afs_cell_trace_use_probe,
-	afs_cell_trace_use_sbi,
-	afs_cell_trace_wait,
-};
-
 enum afs_fs_operation {
 	afs_FS_FetchData		= 130,	/* AFS Fetch file data */
 	afs_FS_FetchACL			= 131,	/* AFS Fetch file ACL */
@@ -202,121 +111,6 @@ enum yfs_cm_operation {
 	yfs_CB_CallBack			= 64204,
 };
 
-enum afs_edit_dir_op {
-	afs_edit_dir_create,
-	afs_edit_dir_create_error,
-	afs_edit_dir_create_inval,
-	afs_edit_dir_create_nospc,
-	afs_edit_dir_delete,
-	afs_edit_dir_delete_error,
-	afs_edit_dir_delete_inval,
-	afs_edit_dir_delete_noent,
-};
-
-enum afs_edit_dir_reason {
-	afs_edit_dir_for_create,
-	afs_edit_dir_for_link,
-	afs_edit_dir_for_mkdir,
-	afs_edit_dir_for_rename_0,
-	afs_edit_dir_for_rename_1,
-	afs_edit_dir_for_rename_2,
-	afs_edit_dir_for_rmdir,
-	afs_edit_dir_for_silly_0,
-	afs_edit_dir_for_silly_1,
-	afs_edit_dir_for_symlink,
-	afs_edit_dir_for_unlink,
-};
-
-enum afs_eproto_cause {
-	afs_eproto_bad_status,
-	afs_eproto_cb_count,
-	afs_eproto_cb_fid_count,
-	afs_eproto_cellname_len,
-	afs_eproto_file_type,
-	afs_eproto_ibulkst_cb_count,
-	afs_eproto_ibulkst_count,
-	afs_eproto_motd_len,
-	afs_eproto_offline_msg_len,
-	afs_eproto_volname_len,
-	afs_eproto_yvl_fsendpt4_len,
-	afs_eproto_yvl_fsendpt6_len,
-	afs_eproto_yvl_fsendpt_num,
-	afs_eproto_yvl_fsendpt_type,
-	afs_eproto_yvl_vlendpt4_len,
-	afs_eproto_yvl_vlendpt6_len,
-	afs_eproto_yvl_vlendpt_type,
-};
-
-enum afs_io_error {
-	afs_io_error_cm_reply,
-	afs_io_error_extract,
-	afs_io_error_fs_probe_fail,
-	afs_io_error_vl_lookup_fail,
-	afs_io_error_vl_probe_fail,
-};
-
-enum afs_file_error {
-	afs_file_error_dir_bad_magic,
-	afs_file_error_dir_big,
-	afs_file_error_dir_missing_page,
-	afs_file_error_dir_name_too_long,
-	afs_file_error_dir_over_end,
-	afs_file_error_dir_small,
-	afs_file_error_dir_unmarked_ext,
-	afs_file_error_mntpt,
-	afs_file_error_writeback_fail,
-};
-
-enum afs_flock_event {
-	afs_flock_acquired,
-	afs_flock_callback_break,
-	afs_flock_defer_unlock,
-	afs_flock_extend_fail,
-	afs_flock_fail_other,
-	afs_flock_fail_perm,
-	afs_flock_no_lockers,
-	afs_flock_release_fail,
-	afs_flock_silly_delete,
-	afs_flock_timestamp,
-	afs_flock_try_to_lock,
-	afs_flock_vfs_lock,
-	afs_flock_vfs_locking,
-	afs_flock_waited,
-	afs_flock_waiting,
-	afs_flock_work_extending,
-	afs_flock_work_retry,
-	afs_flock_work_unlocking,
-	afs_flock_would_block,
-};
-
-enum afs_flock_operation {
-	afs_flock_op_copy_lock,
-	afs_flock_op_flock,
-	afs_flock_op_grant,
-	afs_flock_op_lock,
-	afs_flock_op_release_lock,
-	afs_flock_op_return_ok,
-	afs_flock_op_return_eagain,
-	afs_flock_op_return_edeadlk,
-	afs_flock_op_return_error,
-	afs_flock_op_set_lock,
-	afs_flock_op_unlock,
-	afs_flock_op_wake,
-};
-
-enum afs_cb_break_reason {
-	afs_cb_break_no_break,
-	afs_cb_break_no_promise,
-	afs_cb_break_for_callback,
-	afs_cb_break_for_deleted,
-	afs_cb_break_for_lapsed,
-	afs_cb_break_for_s_reinit,
-	afs_cb_break_for_unlink,
-	afs_cb_break_for_v_break,
-	afs_cb_break_for_volume_callback,
-	afs_cb_break_for_zap,
-};
-
 #endif /* end __AFS_DECLARE_TRACE_ENUMS_ONCE_ONLY */
 
 /*
@@ -391,6 +185,7 @@ enum afs_cb_break_reason {
 	EM(afs_cell_trace_unuse_fc,		"UNU fc    ") \
 	EM(afs_cell_trace_unuse_lookup,		"UNU lookup") \
 	EM(afs_cell_trace_unuse_mntpt,		"UNU mntpt ") \
+	EM(afs_cell_trace_unuse_no_pin,		"UNU no-pin") \
 	EM(afs_cell_trace_unuse_parse,		"UNU parse ") \
 	EM(afs_cell_trace_unuse_pin,		"UNU pin   ") \
 	EM(afs_cell_trace_unuse_probe,		"UNU probe ") \
@@ -614,6 +409,32 @@ enum afs_cb_break_reason {
 	EM(afs_cb_break_for_volume_callback,	"break-v-cb")		\
 	E_(afs_cb_break_for_zap,		"break-zap")
 
+/*
+ * Generate enums for tracing information.
+ */
+#ifndef __AFS_GENERATE_TRACE_ENUMS_ONCE_ONLY
+#define __AFS_GENERATE_TRACE_ENUMS_ONCE_ONLY
+
+#undef EM
+#undef E_
+#define EM(a, b) a,
+#define E_(a, b) a
+
+enum afs_call_trace		{ afs_call_traces } __mode(byte);
+enum afs_cb_break_reason	{ afs_cb_break_reasons } __mode(byte);
+enum afs_cell_trace		{ afs_cell_traces } __mode(byte);
+enum afs_edit_dir_op		{ afs_edit_dir_ops } __mode(byte);
+enum afs_edit_dir_reason	{ afs_edit_dir_reasons } __mode(byte);
+enum afs_eproto_cause		{ afs_eproto_causes } __mode(byte);
+enum afs_file_error		{ afs_file_errors } __mode(byte);
+enum afs_flock_event		{ afs_flock_events } __mode(byte);
+enum afs_flock_operation	{ afs_flock_operations } __mode(byte);
+enum afs_io_error		{ afs_io_errors } __mode(byte);
+enum afs_server_trace		{ afs_server_traces } __mode(byte);
+enum afs_volume_trace		{ afs_volume_traces } __mode(byte);
+
+#endif /* end __AFS_GENERATE_TRACE_ENUMS_ONCE_ONLY */
+
 /*
  * Export enum symbols via userspace.
  */
-- 
2.43.0




