Return-Path: <linux-fsdevel+bounces-7328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B85823A5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E192286D9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 01:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D3442D;
	Thu,  4 Jan 2024 01:53:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B74C65;
	Thu,  4 Jan 2024 01:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0647AC433C7;
	Thu,  4 Jan 2024 01:53:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLCwN-00000000qgq-23WX;
	Wed, 03 Jan 2024 20:54:35 -0500
Message-ID: <20240104015247.075935881@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 03 Jan 2024 20:52:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ajay Kaher <akaher@vmware.com>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] eventfs: Don't use dcache_readdir() for getdents()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


After having a "pleasant" conversation with Linus over on the security
mailing list, we came to the conclusion that eventfs should not be
using the dcache_readdir() routine for iterating the entries of a
directory (getdents()).

Instead, the .open and .release callbacks of the directory file
operations was removed and all the work is now done in the .iterate_shared.

The function dcache_readdir_wrapper() was renamed to eventfs_iterate().

As the files and directories of eventfs is all known within the meta
data, it can easily supply getdents() with the information it needs without
traversing the dentry.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240103102553.17a19cea@gandalf.local.home/

- Broke up into two patches, one to fix the lookup parameter and the
  other to do the meat of the change.

- Moved the ctx->pos count up to skip creating of dentries in those cases.


Steven Rostedt (Google) (2):
      eventfs: Remove "lookup" parameter from create_dir/file_dentry()
      eventfs: Stop using dcache_readdir() for getdents()

----
 fs/tracefs/event_inode.c | 241 ++++++++++++++++-------------------------------
 1 file changed, 80 insertions(+), 161 deletions(-)

