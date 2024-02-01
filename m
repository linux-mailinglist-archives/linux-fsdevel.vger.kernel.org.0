Return-Path: <linux-fsdevel+bounces-9893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CB0845CF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8BE1C2AC42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B027160891;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6E15D5C6;
	Thu,  1 Feb 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804160; cv=none; b=MRLQzrjPKurUjPUEeMaiJnEsyCgxlfVDuQPQSVdprD2U2Lk9yDags+p2TVQ0iQPr2ttQ8yKkhQN8NFwp/udoteWCPLM6p4KCtDSX/2v8pFBN4YOloRdo45aFuzWMbw4IZwSemyR737TaYHcAa76y9JSXEhiUEmW55LkPCFhIZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804160; c=relaxed/simple;
	bh=DyCrvgsA9ba5cHK2UEU+zFvlGHeNhP1QegBE0CHgiGc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=HJNs+fxcD7Bck9MyU1JHrMpckZAPCWCxsv2HRBYJ6cpARRLq1SclVSmDm8DxmQwu/qfCHQ3Awfuv/p6N/D1J29yB6fypWsOtzz/9h9Ak+Zl4ZUDeNrvzn+Nz3/BqKpB8AKkZmYLsONif/ZYxnZQwBOmgSBDuzqKPP/DhnwUIHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C006DC433C7;
	Thu,  1 Feb 2024 16:15:59 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVZjc-00000005TiE-3Q98;
	Thu, 01 Feb 2024 11:16:16 -0500
Message-ID: <20240201153446.138990674@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 10:34:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [PATCH 0/6] eventfs: More fixes and clean ups
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Al Viro reviewed the latest patch set from Linus and had some comments.
One was on the return code of the eventfs_root_lookup() which I already
sent a patch for:
  https://lore.kernel.org/linux-trace-kernel/20240131233227.73db55e1@gandalf.local.home/

The other comments had to do with code that was there before Linus's
updates. Those were:

 - It made no sense to have the fsnotify*() functions triggering
   from file/directory creation in the lookup()

 - The directory inode count wasn't accurate. The updates to
   the link nodes for the parent directory was also happening in
   lookup. Al Viro told me to just set them all to 1, as that
   tells user space not to trust the hard link counts.

I added a WARN_ON_ONCE() in case of the eventfs_inode being freed without
is_freed being set.

I restructured the eventfs_inode structure to be a bit more compact.

The last two changes I included here but do not plan on pushing for
v6.8.  Those are:

 - Adding WARN_ON_ONCE() to the conditionals that Al asked about
   as the logic should prevent them from being true.

 - Moving the dentry pointer out of eventfs_inode and creating a new
   eventfs_root_inode that contains the eventfs_inode and the dentry
   pointer. This only gets used by the "events" directory.

Steven Rostedt (Google) (6):
      eventfs: Warn if an eventfs_inode is freed without is_freed being set
      eventfs: Restructure eventfs_inode structure to be more condensed
      eventfs: Remove fsnotify*() functions from lookup()
      eventfs: Keep all directory links at 1
      eventfs: Add WARN_ON_ONCE() to checks in eventfs_root_lookup()
      eventfs: Create eventfs_root_inode to store dentry

----
 fs/tracefs/event_inode.c | 104 +++++++++++++++++++++++++++++++++++++----------
 fs/tracefs/internal.h    |  29 ++++++-------
 2 files changed, 94 insertions(+), 39 deletions(-)

