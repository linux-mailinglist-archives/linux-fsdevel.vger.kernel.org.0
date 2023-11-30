Return-Path: <linux-fsdevel+bounces-4380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F677FF292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C859B20DD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3351010
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyphNFlc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD653B28A
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6C2C433C9;
	Thu, 30 Nov 2023 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701348573;
	bh=ZvwItoXx0k/brQZ8mZ58tI0k5W8jRqXALE+vqboThis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qyphNFlc4v4QercXeJa0gAEERPEoBc0V0esDMnAhK7pfY8ie1pjJKgyZUBMAOzotf
	 ViX1FdzIveD53iL9IWE1XeOIHN/MASYZ4OinvqiLzQYwI94Yads5aMtR5q9El7wbb9
	 r6th2B2GqgqCPvxrOM0dIQMLNM++gmXRwxFw3Q0uR4V8ll05io+VvYl/kplaJYQGmo
	 BPRAL5MTSG62LMTwn7S6yRE8vKmoTbohbQ1+01G/gfXMX+Xi3LNBdQ8O7KfhUsDz3C
	 UH7dF7G4gYg0+EZ24BaS+Ubusrp89F6UQdvHUPm1HDjc6V+IWbhwuVRTgzFf1busop
	 CpMg10l/JOnOg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Nov 2023 13:49:09 +0100
Subject: [PATCH RFC 3/5] fs: replace f_rcuhead with f_tw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-vfs-files-fixes-v1-3-e73ca6f4ea83@kernel.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
In-Reply-To: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, 
 Carlos Llamas <cmllamas@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-7edf1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZvwItoXx0k/brQZ8mZ58tI0k5W8jRqXALE+vqboThis=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRmtFz1u+fKcqPiCuOJMsc/LTsnPVu18eCZt9uzplTxC
 8ltvT1Nv6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAij9gY/odNDphZ5sXYvkQz
 lufL6SsnTbYs/BzbsUVglsnHjbsXZnxnZPi3+zzrstkOGSl/a7/7nSuxv1bgInXSyXfGUzPByR7
 8PXwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The naming is actively misleading since we switched to
SLAB_TYPESAFE_BY_RCU. rcu_head is #define callback_head. Use
callback_head directly and rename f_rcuhead to f_tw.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c    | 6 +++---
 include/linux/fs.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 6deac386486d..78614204ef2c 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -407,7 +407,7 @@ static void delayed_fput(struct work_struct *unused)
 
 static void ____fput(struct callback_head *work)
 {
-	__fput(container_of(work, struct file, f_rcuhead));
+	__fput(container_of(work, struct file, f_tw));
 }
 
 /*
@@ -438,8 +438,8 @@ void fput(struct file *file)
 			return;
 		}
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
-			init_task_work(&file->f_rcuhead, ____fput);
-			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
+			init_task_work(&file->f_tw, ____fput);
+			if (!task_work_add(task, &file->f_tw, TWA_RESUME))
 				return;
 			/*
 			 * After this task has run exit_task_work(),
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f171505940ff..d23a886df8fa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -992,7 +992,7 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
 struct file {
 	union {
 		struct llist_node	f_llist;
-		struct rcu_head 	f_rcuhead;
+		struct callback_head 	f_tw;
 		unsigned int 		f_iocb_flags;
 	};
 

-- 
2.42.0


