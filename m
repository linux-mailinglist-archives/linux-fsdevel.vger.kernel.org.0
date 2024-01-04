Return-Path: <linux-fsdevel+bounces-7427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC58824A90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 23:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF4D1C21FCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEC2CCD1;
	Thu,  4 Jan 2024 21:59:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111622C851;
	Thu,  4 Jan 2024 21:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76E5C433C8;
	Thu,  4 Jan 2024 21:59:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLVlg-00000000vgE-0dzN;
	Thu, 04 Jan 2024 17:00:48 -0500
Message-ID: <20240104220048.016261289@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 04 Jan 2024 16:57:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/4] eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is
 set
References: <20240104215711.924088454@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If ei->is_freed is set in eventfs_iterate(), it means that the directory
that is being iterated on is in the process of being freed. Just exit the
loop immediately when that is ever detected, and separate out the return
of the entry->callback() from ei->is_freed.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 72912b5f9a90..0aca6910efb3 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -788,11 +788,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		name = entry->name;
 
 		mutex_lock(&eventfs_mutex);
-		/* If ei->is_freed, then the event itself may be too */
-		if (!ei->is_freed)
-			r = entry->callback(name, &mode, &cdata, &fops);
-		else
-			r = -1;
+		/* If ei->is_freed then just bail here, nothing more to do */
+		if (ei->is_freed) {
+			mutex_unlock(&eventfs_mutex);
+			goto out;
+		}
+		r = entry->callback(name, &mode, &cdata, &fops);
 		mutex_unlock(&eventfs_mutex);
 		if (r <= 0)
 			continue;
-- 
2.42.0



