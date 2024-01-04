Return-Path: <linux-fsdevel+bounces-7430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0BC824A9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 23:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4081F25709
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E18D2D043;
	Thu,  4 Jan 2024 21:59:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399802C862;
	Thu,  4 Jan 2024 21:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B90C43391;
	Thu,  4 Jan 2024 21:59:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLVlf-00000000vfj-49as;
	Thu, 04 Jan 2024 17:00:47 -0500
Message-ID: <20240104215711.924088454@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 04 Jan 2024 16:57:11 -0500
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
Subject: [PATCH 0/4] eventfs: More updates to eventfs_iterate()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

With the ongoing descussion of eventfs iterator, a few more changes
are required and some changes are just enhancements.

- Stop immediately in the loop if the ei is found to be in the process
  of being freed.

- Make the ctx->pos update consistent with the skipped previous read index.
  This fixes a bug with duplicate files being showned by 'ls'.

- Swap reading ei->entries with ei->children to make the next change
  easier to read

- Add a "shortcut" in the ei->entries array to skip over already read
  entries.


Steven Rostedt (Google) (4):
      eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is set
      eventfs: Do ctx->pos update for all iterations in  eventfs_iterate()
      eventfs: Read ei->entries before ei->children in eventfs_iterate()
      eventfs: Shortcut eventfs_iterate() by skipping entries already read

----
 fs/tracefs/event_inode.c | 67 ++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

