Return-Path: <linux-fsdevel+bounces-25428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0922194C17C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 17:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9908AB2A893
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE918F2DF;
	Thu,  8 Aug 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="reNSuzD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4B18E039
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131187; cv=none; b=bXenNLBnUQ+LSW++eRnslMeSkg1FTNLog38mlf2Am1qRnlFx6wbFHzBQS7+7SAkq5YJGvVzFltCmJcpNax9iHStjQ6ydgyfdhN/wGUqpoYJ9ZdIGi/S90qZhajeX7Ro5E1J34O3xcGKRqbiz5brqSgz22vQG7boiDS/Y1JiOwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131187; c=relaxed/simple;
	bh=KHg2dgQ3z4l3jlTadypXtknojw0gY6/D9vnUC/+ymoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qfrfLwqMnYqWs6FMJn5/V/bWkVKWy+OJL3RnfkdqKJCG3EnE7nbkDtUUOIQ3K+yAsHw1xLanS1LEV6/cZNv1JnkC+9kGNCJFsIgZ/r4V6pUe1Sa6TRFd7KOMoVlOH0jizQkG5Fp6vQsWXemCOmFLxJ6z2LWp1YpKzwtv5YY4QFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=reNSuzD2; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Aug 2024 11:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723131181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QoOV+LDhOiZeXkQuut+ECTaJ3C1I3khBkfy80ox2qUc=;
	b=reNSuzD2lX5QuE1FYBKqzVSb/aYzCRkIaYVcdXWvXnTccNPOCWaq0/gyJ/+KegW8axX5no
	GAEzb4CU975IdS6nU1Our6GU1Xg6NuX5fcLTOdK60gl77/cTiBDQb8Qx2WxcVbk1XOuheD
	CAj33OXeYctobZf+TrnMazHOMPTS8ps=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.11-rc3
Message-ID: <6dvutmoo566vc3vr5ezzz6rjhqjjsqhwnrfu2v5tkoieh23mwp@qo2cc2bpin3n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, couple little ones for you...

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-08

for you to fetch changes up to 73dc1656f41a42849e43b945fe44d4e3d55eb6c3:

  bcachefs: Use bch2_wait_on_allocator() in btree node alloc path (2024-08-07 21:04:55 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.11-rc3

Assorted little stuff:
- lockdep fixup for lockdep_set_notrack_class()
- we can now remove a device when using erasure coding without
  deadlocking, though we still hit other issues
- the "allocator stuck" timeout is now configurable, and messages are
  ratelimited; default timeout has been increased from 10 seconds to 30

----------------------------------------------------------------
Kent Overstreet (10):
      bcachefs: Fix double free of ca->buckets_nouse
      lockdep: Fix lockdep_set_notrack_class() for CONFIG_LOCK_STAT
      bcachefs: Don't rely on implicit unsigned -> signed integer conversion
      bcachefs: Add a comment for bucket helper types
      bcachefs: Add missing bch2_trans_begin() call
      bcachefs: Improved allocator debugging for ec
      bcachefs: ec should not allocate from ro devs
      bcachefs: Add missing path_traverse() to btree_iter_next_node()
      bcachefs: Make allocator stuck timeout configurable, ratelimit messages
      bcachefs: Use bch2_wait_on_allocator() in btree node alloc path

 fs/bcachefs/alloc_background.h      | 12 ++++++++++--
 fs/bcachefs/alloc_foreground.c      | 32 ++++++++++++++++++++++++++++----
 fs/bcachefs/alloc_foreground.h      |  9 +++++++--
 fs/bcachefs/bcachefs.h              |  2 ++
 fs/bcachefs/bcachefs_format.h       |  2 ++
 fs/bcachefs/btree_iter.c            |  5 +++++
 fs/bcachefs/btree_update_interior.c |  2 +-
 fs/bcachefs/ec.c                    | 34 +++++++++++++++++++++++-----------
 fs/bcachefs/io_misc.c               |  6 +-----
 fs/bcachefs/io_read.c               |  1 +
 fs/bcachefs/io_write.c              |  5 +----
 fs/bcachefs/opts.h                  |  5 +++++
 fs/bcachefs/super-io.c              |  4 ++++
 fs/bcachefs/super.c                 |  1 -
 fs/bcachefs/sysfs.c                 |  6 +++++-
 kernel/locking/lockdep.c            |  6 ++++++
 16 files changed, 101 insertions(+), 31 deletions(-)

