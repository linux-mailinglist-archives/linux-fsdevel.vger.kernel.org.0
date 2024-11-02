Return-Path: <linux-fsdevel+bounces-33537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1B9B9D3D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FFD1F2275F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9609A1B0F25;
	Sat,  2 Nov 2024 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bWJgUW5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BAE156677;
	Sat,  2 Nov 2024 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524123; cv=none; b=LYEHciHt/Swd2ScDBPJNf/P7njj1Kflwtie681ymoSL/scbusT453Wf6UCydd1vSnfX8q7ofFhgJvoj78/eGR15OjQV03WN4fOQAD9WE25maAcTYks4IWaDwDPBs9mHM7ckbX12daLtChpqC74j56GhLFcs83mm48ENFjgJrjw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524123; c=relaxed/simple;
	bh=IQsUsKxTYHR/UWSxnzKXVjsg4zRNBpAAmVoUHBiqT2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrgIuuoBayf0Pca48rH4lJbOKkDdInqQ7A2VJdpei5TG+PvMFgDj/ZeVy5Q2IlMAyRfAE75mil4ZuOzvxLzspPlN9cUJRhUKtjMrZBODDl+QAi8mc4zEDMQHpnU+jeNDpESGWDIf57gmC2eOicgHCyUdr1dWNh8kqh5Wme1KrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bWJgUW5z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/ON4xfM/I52yPPOjnFJDfTb7C6U4u5Iw3hGLWaLbWO8=; b=bWJgUW5zQ5ZP2IgHiJnXgfGOlx
	NrX92siEnSvGGWqQ55QdjRtH7qY0RiVgZp/CAyc86hZo05Aim0PoSuHmCb35Lp8hY4usCOvhVh1FZ
	sQ8VMoimGh8U8xCYd8+jZ/tF81LWuefB12Hew1zlugZTU0hPNpHFDohPIhaBEe8FS5hv3tPyVVc5L
	s/AHDxd0r7ikQf6WKp9b/0inya+Rb6prb9bd1wtG9LuMUuAeFM1M02d3sttmk7YDBobl5C1dJKHu1
	f9CL6P4b5E24xxjKvzeQxJL0nS69gKoSVAe7KGbJ6qjo7QLVUZWLqkEZV5qAWhidw50a1LPMesFxl
	ATvlB9pw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76N9-0000000AHm8-2vHc;
	Sat, 02 Nov 2024 05:08:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 04/28] get rid of perf_fget_light(), convert kernel/events/core.c to CLASS(fd)
Date: Sat,  2 Nov 2024 05:08:02 +0000
Message-ID: <20241102050827.2451599-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Lift fdget() and fdput() out of perf_fget_light(), turning it into
is_perf_file(struct fd f).  The life gets easier in both callers
if we do fdget() unconditionally, including the case when we are
given -1 instead of a descriptor - that avoids a reassignment in
perf_event_open(2) and it avoids a nasty temptation in _perf_ioctl()
where we must *not* lift output_event out of scope for output.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/events/core.c | 49 +++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3589c4287cb..85b209626dd7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5998,18 +5998,9 @@ EXPORT_SYMBOL_GPL(perf_event_period);
 
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
@@ -6057,20 +6048,14 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
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
@@ -12664,7 +12649,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct perf_event_attr attr;
 	struct perf_event_context *ctx;
 	struct file *event_file = NULL;
-	struct fd group = EMPTY_FD;
 	struct task_struct *task = NULL;
 	struct pmu *pmu;
 	int event_fd;
@@ -12735,10 +12719,12 @@ SYSCALL_DEFINE5(perf_event_open,
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
@@ -12750,7 +12736,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		task = find_lively_task_by_vpid(pid);
 		if (IS_ERR(task)) {
 			err = PTR_ERR(task);
-			goto err_group_fd;
+			goto err_fd;
 		}
 	}
 
@@ -13017,12 +13003,11 @@ SYSCALL_DEFINE5(perf_event_open,
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
 
@@ -13041,8 +13026,6 @@ SYSCALL_DEFINE5(perf_event_open,
 err_task:
 	if (task)
 		put_task_struct(task);
-err_group_fd:
-	fdput(group);
 err_fd:
 	put_unused_fd(event_fd);
 	return err;
-- 
2.39.5


