Return-Path: <linux-fsdevel+bounces-7515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6A8266BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 00:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22AC1F2149E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 23:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8968212B87;
	Sun,  7 Jan 2024 23:09:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36906125A8;
	Sun,  7 Jan 2024 23:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1270C433C7;
	Sun,  7 Jan 2024 23:09:25 +0000 (UTC)
Date: Sun, 7 Jan 2024 18:09:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] eventfs: Updates for v6.8
Message-ID: <20240107180924.38e25155@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

This is only for tracefs/eventfs. It does not contain any of the
tracing subsystem updates. It may also conflict with vfs subsystem as
they had a change in the dentry walk, but that code that conflicts is
deleted by this pull request.

eventfs updates for v6.8:

Note, this has no new features but only restructures the eventfs and
tracefs code to simplify it and depend less on how dentry works.

- Remove "lookup" parameter of create_dir_dentry() and
  create_file_dentry(). These functions were called by lookup and the
  readdir logic, where readdir needed it to up the ref count of the dentry
  but the lookup did not. A "lookup" parameter was passed in to tell it
  what to do, but this complicated the code. It is better to just always
  up the ref count and require the caller to decrement it, even for
  lookup.

- Modify the .iterate_shared callback to not use the dcache_readdir()
  logic and just handle what gets displayed by that one function. This
  removes the need for eventfs to hijack the file->private_data from the
  dcache_readdir() "cursor" pointer, and makes the code a bit more sane.

- Use the root and instance inodes for default ownership. Instead of
  walking the dentry tree and updating each dentry gid, use the getattr(),
  setattr() and permission() callbacks to set the ownership and
  permissions using the root or instance as the default.

- Some other optimizations with the eventfs iterate_shared logic.


Please pull the latest eventfs-v6.8 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
eventfs-v6.8

Tag SHA1: b24ec2b23e8b77b46510e215ea34887bfb550453
Head SHA1: 1de94b52d5e8d8b32f0252f14fad1f1edc2e71f1


Steven Rostedt (Google) (7):
      eventfs: Remove "lookup" parameter from create_dir/file_dentry()
      eventfs: Stop using dcache_readdir() for getdents()
      tracefs/eventfs: Use root and instance inodes as default ownership
      eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is set
      eventfs: Do ctx->pos update for all iterations in eventfs_iterate()
      eventfs: Read ei->entries before ei->children in eventfs_iterate()
      eventfs: Shortcut eventfs_iterate() by skipping entries already read

----
 fs/tracefs/event_inode.c | 341 +++++++++++++++++++++++------------------------
 fs/tracefs/inode.c       | 198 +++++++++++++++------------
 fs/tracefs/internal.h    |   3 +
 3 files changed, 283 insertions(+), 259 deletions(-)
---------------------------

