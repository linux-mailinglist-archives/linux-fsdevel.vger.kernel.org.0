Return-Path: <linux-fsdevel+bounces-21153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DB38FF9D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C9C1F24987
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68E3364BE;
	Fri,  7 Jun 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iRKzay+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940717993
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725604; cv=none; b=WLt7aBz8pJFDAIvQpSBv42uYtUFNlpF0c/itjUsh6URJdNg77YQe+H24pjPndfZv62XuVnq68Rqj1LuhV0wDxs4e/NldjZAi7S2waW+MIdbTl3miDs9yhXID022GCUbW1jbx2zcupiSabA0ib1Pwz8zfWptn2PyiYwl0xeAp3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725604; c=relaxed/simple;
	bh=Aoxye/3r+Tkd6it4lBau172BvqTiSaMU7DutziPJ7DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2WyZfh+BVlYm7RzcJBuSL48U1z25KPHGRWZ76n3UQM//2WstpqIDF4BDbWyf1hMmrwXlcGT7wmumXGjr+FhIXvV8ClyfexMhxWApcrduoomK+0dAhAlQj+cwGu+x+dN/6WKnIUEZUnOMu4yIoNYzZAqVydKlPfUGaB+0txV5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iRKzay+/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CrhFp38Wl+BRvfPnNGeMzey4FrksonZ0F0/f98StwqY=; b=iRKzay+/JGSBTomsxvf5L14fjx
	tejWdHPtgHtlqOsxrNtZFuJjHcp/yin8vJ9/02C8qI+gChSJ6R+RxuM9wWBN/3/SP5pRIRTmGmrAw
	oV4tmEu1WBlxaN6dmVmxBhqpHoR4NdlsL+YW2rcCMGgjXZP51y020P15IuopOgvKhqNIQqnoiUY10
	msxs6XIV54u0ToX1oR8bC63Pg8fi0STmKNot8gXFUVrUOHPu9JtyfdzR2GZwSZBiVyKxCGDrxm4W3
	HIfn6Df7kr5ywv8DaUoRJEWTTBHP2PUhU/Lk+CD4EzePQrvNSqIRWpptcE97KxJICaQF2v69MZjTh
	U0RV6M7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtc-009xCv-2J;
	Fri, 07 Jun 2024 02:00:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 18/19] convert kernel/events/core.c
Date: Fri,  7 Jun 2024 02:59:56 +0100
Message-Id: <20240607015957.2372428-18-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

a questionable trick in perf_event_open(2) - deliberate call of
fdget(-1), expecting it to yield empty.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/events/core.c | 47 +++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bc4910442642..0cb3ecdaecae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5866,18 +5866,9 @@ EXPORT_SYMBOL_GPL(perf_event_period);
 
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
@@ -5925,20 +5916,16 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 	case PERF_EVENT_IOC_SET_OUTPUT:
 	{
-		int ret;
 		if (arg != -1) {
 			struct perf_event *output_event;
-			struct fd output;
-			ret = perf_fget_light(arg, &output);
-			if (ret)
-				return ret;
+			CLASS(fd, output)(arg);
+			if (!is_perf_file(output))
+				return -EBADF;
 			output_event = fd_file(output)->private_data;
-			ret = perf_event_set_output(event, output_event);
-			fdput(output);
+			return perf_event_set_output(event, output_event);
 		} else {
-			ret = perf_event_set_output(event, NULL);
+			return perf_event_set_output(event, NULL);
 		}
-		return ret;
 	}
 
 	case PERF_EVENT_IOC_SET_FILTER:
@@ -12434,7 +12421,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct perf_event_attr attr;
 	struct perf_event_context *ctx;
 	struct file *event_file = NULL;
-	struct fd group = EMPTY_FD;
 	struct task_struct *task = NULL;
 	struct pmu *pmu;
 	int event_fd;
@@ -12505,10 +12491,12 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (event_fd < 0)
 		return event_fd;
 
+	CLASS(fd, group)(group_fd);	// group_fd == -1 => empty
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
@@ -12520,7 +12508,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		task = find_lively_task_by_vpid(pid);
 		if (IS_ERR(task)) {
 			err = PTR_ERR(task);
-			goto err_group_fd;
+			goto err_fd;
 		}
 	}
 
@@ -12787,12 +12775,11 @@ SYSCALL_DEFINE5(perf_event_open,
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
 
@@ -12811,8 +12798,6 @@ SYSCALL_DEFINE5(perf_event_open,
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


