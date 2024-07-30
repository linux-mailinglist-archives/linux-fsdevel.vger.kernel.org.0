Return-Path: <linux-fsdevel+bounces-24542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234439406F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B412DB22929
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369841922E5;
	Tue, 30 Jul 2024 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUASOf7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABA16728B;
	Tue, 30 Jul 2024 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316496; cv=none; b=arHwg+VQ7F6Ra2fy0ij2ALce9xRndBVt7cNjSLqRV31ek6grnOzyCXglX9IBYl+vw3r34SxjAgdqzZWHk+UDi65M5tgOSfztm3HsfNzofc8xw4uBFzuAyOICq3S/Z4H1sjcEHzTc/2CwOinsKiBCnluG1P0RBzAnXsRdwDA6OkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316496; c=relaxed/simple;
	bh=mF4FNYo87q0v9iKFXaWZ3IE5/zlazvPTfa1axnXq7RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8ZulrBtjPByUDe58nVLmuYpzIXJgENn0l65yqKmUUoBodEj0DyiUEo47+DdYGd4ImwPj8aOPDiE8vlq/WJFA03yvgXSsPCXsIF6UIkJMexTr4D7QvNEpjEeL4Ii+fdC+vhIrynT0vN54CMEuoKJaUTYvHC0N+AjY2tWPfKq4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUASOf7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4F6C32782;
	Tue, 30 Jul 2024 05:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316496;
	bh=mF4FNYo87q0v9iKFXaWZ3IE5/zlazvPTfa1axnXq7RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUASOf7oQWW8nwXMgsoXd79ICUXLNfLmQbMWE7QW6pr/N7IEukufOpkv6QhNuCYNF
	 aGZCtXFPDxjABzsdWKds7bO7EqZQLPLE6bOWfBh2gPiBezbs9G8pAfDMomimtgSHY2
	 U3/MAnIMF3X7qUcA4sS52E8meWHxkd4efnv1pPHv3eWOkyFgv5STY7ZfoDwflKukmW
	 hfLdqzeEFosKMZUY/3iC+yDcIv0axWgrmWo4TLp4+uzh/j9iSUnN/T1c9EoGxSCxg+
	 1UdsmEk6Wx8lQRxvGEg0KT9rDK4qbtDf8uxQOjcFzfqhYWn7pCQWM5ZdQ5b1BBFDRM
	 3ROjlKSDwLTqw==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 10/39] get rid of perf_fget_light(), convert kernel/events/core.c to CLASS(fd)
Date: Tue, 30 Jul 2024 01:15:56 -0400
Message-Id: <20240730051625.14349-10-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

Lift fdget() and fdput() out of perf_fget_light(), turning it into
is_perf_file(struct fd f).  The life gets easier in both callers
if we do fdget() unconditionally, including the case when we are
given -1 instead of a descriptor - that avoids a reassignment in
perf_event_open(2) and it avoids a nasty temptation in _perf_ioctl()
where we must *not* lift output_event out of scope for output.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/events/core.c | 49 +++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fd2ac9c7fd77..dae815c30514 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5895,18 +5895,9 @@ EXPORT_SYMBOL_GPL(perf_event_period);
 
 static const struct file_operations perf_fops;
 
-static inline int perf_fget_light(int fd, struct fd *p)
+static inline bool is_perf_file(struct fd f)
 {
-	struct fd f = fdget(fd);
-	if (!fd_file(f))
-		return -EBADF;
-
-	if (fd_file(f)->f_op != &perf_fops) {
-		fdput(f);
-		return -EBADF;
-	}
-	*p = f;
-	return 0;
+	return !fd_empty(f) && fd_file(f)->f_op == &perf_fops;
 }
 
 static int perf_event_set_output(struct perf_event *event,
@@ -5954,20 +5945,14 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 	case PERF_EVENT_IOC_SET_OUTPUT:
 	{
-		int ret;
+		CLASS(fd, output)(arg);	     // arg == -1 => empty
+		struct perf_event *output_event = NULL;
 		if (arg != -1) {
-			struct perf_event *output_event;
-			struct fd output;
-			ret = perf_fget_light(arg, &output);
-			if (ret)
-				return ret;
+			if (!is_perf_file(output))
+				return -EBADF;
 			output_event = fd_file(output)->private_data;
-			ret = perf_event_set_output(event, output_event);
-			fdput(output);
-		} else {
-			ret = perf_event_set_output(event, NULL);
 		}
-		return ret;
+		return perf_event_set_output(event, output_event);
 	}
 
 	case PERF_EVENT_IOC_SET_FILTER:
@@ -12474,7 +12459,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct perf_event_attr attr;
 	struct perf_event_context *ctx;
 	struct file *event_file = NULL;
-	struct fd group = EMPTY_FD;
 	struct task_struct *task = NULL;
 	struct pmu *pmu;
 	int event_fd;
@@ -12545,10 +12529,12 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (event_fd < 0)
 		return event_fd;
 
+	CLASS(fd, group)(group_fd);     // group_fd == -1 => empty
 	if (group_fd != -1) {
-		err = perf_fget_light(group_fd, &group);
-		if (err)
+		if (!is_perf_file(group)) {
+			err = -EBADF;
 			goto err_fd;
+		}
 		group_leader = fd_file(group)->private_data;
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;
@@ -12560,7 +12546,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		task = find_lively_task_by_vpid(pid);
 		if (IS_ERR(task)) {
 			err = PTR_ERR(task);
-			goto err_group_fd;
+			goto err_fd;
 		}
 	}
 
@@ -12827,12 +12813,11 @@ SYSCALL_DEFINE5(perf_event_open,
 	mutex_unlock(&current->perf_event_mutex);
 
 	/*
-	 * Drop the reference on the group_event after placing the
-	 * new event on the sibling_list. This ensures destruction
-	 * of the group leader will find the pointer to itself in
-	 * perf_group_detach().
+	 * File reference in group guarantees that group_leader has been
+	 * kept alive until we place the new event on the sibling_list.
+	 * This ensures destruction of the group leader will find
+	 * the pointer to itself in perf_group_detach().
 	 */
-	fdput(group);
 	fd_install(event_fd, event_file);
 	return event_fd;
 
@@ -12851,8 +12836,6 @@ SYSCALL_DEFINE5(perf_event_open,
 err_task:
 	if (task)
 		put_task_struct(task);
-err_group_fd:
-	fdput(group);
 err_fd:
 	put_unused_fd(event_fd);
 	return err;
-- 
2.39.2


