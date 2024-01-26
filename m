Return-Path: <linux-fsdevel+bounces-9088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA983E12B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739771C235B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC920B3D;
	Fri, 26 Jan 2024 18:18:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8220B11;
	Fri, 26 Jan 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293116; cv=none; b=U/a0qPZ/JyvH6oe3VmtJJzCOxFVE07nPGlP/oh8t+XSpRbQ0wOJttKDGROzQN9/3jXKz2pevtzl7BSb5at6TJlB4id1CxP8Zkn67JMqGGJzdCWIRnxZ8c5PxTmnXa4Dar6G65RLaHJ5WDg/TNPJNRmyWkUMW+lr79kWEW0AJhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293116; c=relaxed/simple;
	bh=pjd/YFQ6rf4ZVdy510nEnS7abEh43iY3k8/MZiWP3Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qNS+0+PoTTiEV5I1jF3krGNxtB7sYexOmS+PaF5FoLLt61dvlS2gDXKJoAlzxQX97OneokEWvIx3LjlShtKe35v+KsLJN/aeoPTpoEEhjzZ9ZCnvh5sF/ot7voSS5L82bspK9kRsjBCvD1YvQLnPdSeK2f722XIHRIehgZmXCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9344EC433C7;
	Fri, 26 Jan 2024 18:18:34 +0000 (UTC)
Date: Fri, 26 Jan 2024 13:18:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] eventfs: Give files a default of PAGE_SIZE size
Message-ID: <20240126131837.36dbecc8@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The sqlhist utility[1] (or the new trace-cmd sqlhist command[2]) creates
the commands of a synthetic event based on the files in the tracefs/events
directory. When creating these commands for an embedded system, it is
asked to copy the files to the temp directory, tar them up and send them
to the main machine. Ideally, tar could be used directly without copying
them to the /tmp directory. But because the sizes presented by the inodes
are of size '0' the tar just copies zero bytes of the file making it
useless.

By following what sysfs does, and give files a default size of PAGE_SIZE,
it allows the tar to work. No event file is greater than PAGE_SIZE.

Although tar will give an error of:

 tar: events/raw_syscalls/filter: File shrank by 3904 bytes; padding with zeros

Which is consistent to the error it gives to sysfs as well:

~# (cd /sys/ && tar cf - firmware) | tar xf -
 [..]
 tar: firmware/acpi/interrupts/ff_slp_btn: File shrank by 4057 bytes; padding with zeros

But only add size if the file can be open for read. It doesn't make sense
for files that are write-only.

[1] https://trace-cmd.org/Documentation/libtracefs/libtracefs-sqlhist.html
[2] https://trace-cmd.org/Documentation/trace-cmd/trace-cmd-sqlhist.1.html

Link: https://lore.kernel.org/all/CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 7be7a694b106..013b8af40a4f 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -363,6 +363,8 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	inode->i_fop = fop;
 	inode->i_private = data;
 	inode->i_ino = ino;
+	if (mode & (S_IRUSR | S_IRGRP | S_IROTH))
+		inode->i_size = PAGE_SIZE;
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
-- 
2.43.0


