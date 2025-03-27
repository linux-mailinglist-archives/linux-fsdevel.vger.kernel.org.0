Return-Path: <linux-fsdevel+bounces-45133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AEFA73416
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 15:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0E917B4C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA2B217F30;
	Thu, 27 Mar 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FkkjEflF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7621770B;
	Thu, 27 Mar 2025 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084817; cv=none; b=f025pzr+aD/4D2LFgPjdhI8MV9U0VCFIZy4NrXl2sA5oFYyKiDHqsYKXfemHkCaTgV+M8B9OuPison9Zeqm3BNlF8UiLLmmb6oga6/pmWtcUDCr1NwXb5JTVuG7a38bs6DyixlJrbBhWUHsDfEEGZm7aFPGV+gwrHlXpaHC23iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084817; c=relaxed/simple;
	bh=AC3KJnyD5eJrBTt/dLWLwarC9GfJJ4quvVlr3IuI7Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PchT77ybcutn7zzob4gphO1xfw20RMeU8/Ss5cwreTSDiF1ZiLiFHFYkceW9E/PIXuwjgT1H7Ol1VF4wNe6ixzWBW96/L43GIraZcq0eNW9jSYieguamfxjAhoMuGVqaATd9GJNN1UMTGhFzEQZ1oovePShbDevo0AECBvo8LtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FkkjEflF; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1743084814;
	bh=AC3KJnyD5eJrBTt/dLWLwarC9GfJJ4quvVlr3IuI7Ew=;
	h=From:To:Subject:Date:Message-ID:From;
	b=FkkjEflFiBVJAUMvtpXUq4wHhwaZzou/NgGnwX8Mmgaw3VBXCEdumPAnb/uHa8WQf
	 Exhi26pwCoESJwwAspr+b5jEq22W/vAMIQd9jmCoaRz8qKsPQyTYHszogNkNIFDeoZ
	 dQkDyCd343Dnb8Mrd6sPOt7EoklaQfas5xDgBwsY=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id F290F1C0015;
	Thu, 27 Mar 2025 10:13:33 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mcgrof@kernel.org,
	jack@suse.cz,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [RFC PATCH 0/4] vfs freeze/thaw on suspend/resume
Date: Thu, 27 Mar 2025 10:06:09 -0400
Message-ID: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This sequence is posted as an RFC because it needs to be combined with
Luis' patch set:

https://lore.kernel.org/linux-fsdevel/20250326112220.1988619-1-mcgrof@kernel.org/

In particular I've done nothing to replace the kthread freezing in
filesystems.  I can say that this works flawlessly on 6.14 with my
limited test rig (I only have access to my laptop while at LSF/MM).
My test VM is ext4 root with a file on the root attached to a loop
device and mounted (to test nesting) while running a fio workload on
the upper ext4.

The rwsem rework is absolutely necessary because without it hibernate
immediately fails because systemd-journald tries to record the kernel
messages and gets blocked in sb_start_write() on TASK_INTERRUPTIBLE
which inhibits hibernation.

My goal in doing this is to be able to add a thaw_super() callback to
efivarfs and remove our deadlock prone pm notifier.

Regards,

James

---

James Bottomley (4):
  locking/percpu-rwsem: add freezable alternative to down_read
  vfs: make sb_start_write freezable
  fs/super.c: introduce reverse superblock iterator and use it in
    emergency remount
  vfs: add filesystem freeze/thaw callbacks for power management

 fs/super.c                    | 109 ++++++++++++++++++++++++++++------
 include/linux/fs.h            |   8 ++-
 include/linux/percpu-rwsem.h  |  20 +++++--
 kernel/locking/percpu-rwsem.c |  13 ++--
 kernel/power/hibernate.c      |  12 ++++
 kernel/power/suspend.c        |   4 ++
 6 files changed, 137 insertions(+), 29 deletions(-)

-- 
2.43.0


