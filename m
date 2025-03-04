Return-Path: <linux-fsdevel+bounces-43057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4560A4D91D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD53F3B3891
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5861FDE3A;
	Tue,  4 Mar 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfGwYt5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030471FDA97
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081281; cv=none; b=JOzPY9JtCoc14cBtzSXPiiKJ2Zfpfk9ckkhzZI1F7qLRdxKsfIwrzNag4Ss2fXKLi60EkqV8lvJmH5H1ZnT3FV07KU0rsvspIz5JCI5ZfhRDkx/n1f4G+uNusmCbML8XOhZeKAWEmbjhlaXHzgLpFVgZFnAgb3kJIPjfRbtJuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081281; c=relaxed/simple;
	bh=ZjULMH8o08Q3tgpr2GVXRlFaT9JjnSTHHYx1rcX56Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3CRU6OloJSnD7g92OuzkGt9fn5AYHr6s7FVsrYJARfUnS5pIQkfXiTfizf1m+rEjHBAhlQU53XwHBslslTH9/QbxyQDYoleFqVLrW0cgEyCDb3cp5+2+KTOB75zcpsSOd+1am99ALakITZbdVR4J8W/W/wVzpDXI2P7r9s53lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfGwYt5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF59C4CEED;
	Tue,  4 Mar 2025 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081279;
	bh=ZjULMH8o08Q3tgpr2GVXRlFaT9JjnSTHHYx1rcX56Cg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YfGwYt5iQinBQDvXypOkdsVFizI+ksPqhOYBE6HI70iRe1SDd47P1EjD3r7MmRHf5
	 lPIklbU+zlMkn9q0ackgtkxIM7rdh/GuQpexvba/Q6Q5SLzZJfGuRaidUKw9RzdzmB
	 dbGriGPKQjVIPqSHK1KF5AN8ecK4SweYnkatkFmPMbyj3LYwFrOr1tC0QuCXla1161
	 fEs8c6iG5Uc1yXKhnhiAzZgqKQSgxTUXMWUB1nY7i1ixhHZfu0RGqXQitsK+PfQO81
	 ZAkFX7Mba4e2dJpgh60v8n0Or4k4iZJbxOK3JGd4uI7OZDC74fojnbWWRwrUVPO51T
	 qoRVT1TGPAigg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:01 +0100
Subject: [PATCH v2 01/15] pidfs: switch to copy_struct_to_user()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-1-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZjULMH8o08Q3tgpr2GVXRlFaT9JjnSTHHYx1rcX56Cg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7Vrl2VqQEyDVp2jfW7p+akP1lsqKIaaiSev3tUhL
 /YyTNyzo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL/rzP80xUqOCM8YebJza/U
 l4nOzL0tNWXDpQ8Gr9Zybcw97Xp4oxEjwwbdBbYG677EOYYHX79+6d69uNr8lLPet3o/JxZUvuP
 +ywwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We have a helper that deals with all the required logic.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 049352f973de..aa8c8bda8c8f 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -276,10 +276,7 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	 * userspace knows about will be copied. If userspace provides a new
 	 * struct, only the bits that the kernel knows about will be copied.
 	 */
-	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
-		return -EFAULT;
-
-	return 0;
+	return copy_struct_to_user(uinfo, usize, &kinfo, sizeof(kinfo), NULL);
 }
 
 static bool pidfs_ioctl_valid(unsigned int cmd)

-- 
2.47.2


