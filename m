Return-Path: <linux-fsdevel+bounces-9701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651984478C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB9DB23FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368643E479;
	Wed, 31 Jan 2024 18:54:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B738F8F;
	Wed, 31 Jan 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727297; cv=none; b=S+xXs50JvCNhvFcngqqhtUr9xrHf1AnCOVZ7QsfJbZ5c+rT58vuT7Gpc3gYHjOxKFUdwi96QOljNILqhEA2YdzCSz17ARQWSFCCTvttjt6ywz0D2JpyGKoywHEP8y6IBgDo8o56PMs04R3NoA9bC+0luGjshxg+5nqD7iyu0tjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727297; c=relaxed/simple;
	bh=hP5oi3pik9tl/wFh8yLt0CHX3qLM0Nq6RxKvbz2ASZs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=sgsGovtRHaKn4orfMw5Bh4E9TEMCT5Jfd3OnxSA8SNlSz63qJbYX/Cxgo7kT3s4xjiIbmLCRCh1zRFTgXAObcANeCKSu7NDbmvdgEXf/+4Hgttmxqick44EejPu1GOe68KejlGr5FdfKJQRBW9GYZC1vHcNmXL79guw7AFWS6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E16C433C7;
	Wed, 31 Jan 2024 18:54:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVFjs-000000055PM-1C1Z;
	Wed, 31 Jan 2024 13:55:12 -0500
Message-ID: <20240131184918.945345370@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 31 Jan 2024 13:49:18 -0500
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
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/7] eventfs: Rewrite to simplify the code (aka: crapectomy)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Linus took the time to massively clean up the eventfs logic.
I took his code and made tweaks to represent some of the feedback
from Al Viro and also fix issues that came up in testing.

The diff between v1 and this can be found here:
  https://lore.kernel.org/linux-trace-kernel/20240131105847.3e9afcb8@gandalf.local.home/
 
  Although the first patch I changed to use memset_after() since
  that update.

I would like to have this entire series go all the way back to 6.6 (after it
is accepted in mainline of course) and replace everything since the creation
of the eventfs code.  That is, stable releases may need to add all the
patches that are in fs/tracefs to make that happen. The reason being is that
this rewrite likely fixed a lot of hidden bugs and I honestly believe it's
more stable than the code that currently exists.

Note, there's more clean ups that can happen. One being cleaning up
the eventfs_inode structure. But that's not critical now and can be
added later.

This made it through one round of my testing. I'm going to run it
again but with the part of testing that also runs some tests on
each patch in the series to make sure it doesn't break bisection.

In Linus's first version, patch 5 broke some of the tests but was fixed
in patch 6. I swapped the order and moved patch 6 before patch 5
and it appears to work. I still need to run this through all
my testing again.

Version 1 is at: https://lore.kernel.org/linux-trace-kernel/20240130190355.11486-1-torvalds@linux-foundation.org/



Linus Torvalds (6):
      eventfs: Initialize the tracefs inode properly
      tracefs: Avoid using the ei->dentry pointer unnecessarily
      tracefs: dentry lookup crapectomy
      eventfs: Remove unused 'd_parent' pointer field
      eventfs: Clean up dentry ops and add revalidate function
      eventfs: Get rid of dentry pointers without refcounts

Steven Rostedt (Google) (1):
      tracefs: Zero out the tracefs_inode when allocating it

----
 fs/tracefs/event_inode.c | 551 ++++++++++++-----------------------------------
 fs/tracefs/inode.c       | 102 ++-------
 fs/tracefs/internal.h    |  18 +-
 3 files changed, 167 insertions(+), 504 deletions(-)

