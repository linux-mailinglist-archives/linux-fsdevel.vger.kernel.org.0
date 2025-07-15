Return-Path: <linux-fsdevel+bounces-54955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F3B05A80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3473016E180
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6A1FF7B3;
	Tue, 15 Jul 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r82pXi5O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="20GbRVCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEED3165F13;
	Tue, 15 Jul 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583620; cv=none; b=Or6a2jCY/9xpTy2cHwNtELfJxlroQD8dDuBqEugGRqfpLH74lnAe53t1iXglLzIeJLrwUrQAsmrBt2QGK5gKPmBy8XTA2hpcCwBAmBsOKsaHUQWFsjXfMTT4LxrOFK1ORGNKuawYcQS4x6hiOb72fiUUwdtn6pjJHdGb94zZpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583620; c=relaxed/simple;
	bh=7l0HLwbIFY5jQKaEEHEWgRFWPZXFk7ktFjztHqkPNq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPxRz2CrEGle093B+soqM75p7kf90cC7r7hQMGW0tIPAQO69uoQxU6u4u5C8uQRSphkzV68QIrRFYl/R2H+j73IlvaT0yxmsgwYq2zuSpkFdenjDS+yZuL8AERQvXSaiELGQXz0mD2bx8Q4QQdR4UQYPgXxdWo7op19BiL5mRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r82pXi5O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=20GbRVCC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752583616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R6hyjXimt51rOnx9vfzRTF4fIg372HBQtp81PTyL8OM=;
	b=r82pXi5O1CAz5J00C19uXMJm6yrx44vNy4NxsIAAyfi2k2suYevO/BRWItxQ8UCAff/WVR
	3bdvqqsz1QhzqkZXWUwpP9qz236/0OXLVzAH89wrUfk2x1k3CZWXD315QHv/zpoDcs77hL
	gfvMdYWgiB1mapXAbEtq783x/Dpmtquk0qlVPqFhqBQ5ZiqBdexCxH8ZVZRpIS9a9W6LuA
	zbDAtASM10XwClmnkx2eHbFOlFlbyD2YKFfBvva70vDdG5l+8xPpbFlujnEiTUmxX+uNwY
	u0alb24Ft4I9MjnJi2DGX5vvIN3K8GfBrBnkqmgbHEfg0AF9KAamUzSXYefKxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752583616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R6hyjXimt51rOnx9vfzRTF4fIg372HBQtp81PTyL8OM=;
	b=20GbRVCCP0lQbkgC+LWeMUTzobMvO0KCk6YTt4Hi9i18a2/WlOq20Qd9RVAtS3caqatTIy
	KG0zzSjOCYSoDuAw==
To: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Xi Ruoyao <xry111@xry111.site>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 0/1] eventpoll: Fix priority inversion problem
Date: Tue, 15 Jul 2025 14:46:33 +0200
Message-Id: <cover.1752581388.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This v4 is the follow-up to v3 at:
https://lore.kernel.org/linux-fsdevel/20250527090836.1290532-1-namcao@linut=
ronix.de/
which resolves a priority inversion problem.

The v3 patch was merged, but then got reverted due to regression.

The direction of v3 was wrong in the first place. It changed the
eventpoll's event list to be lockless, making the code harder to read. I
stared at the patch again, but still couldn't figure out what the bug is.

The performance numbers were indeed impressive with lockless, but the
numbers are from a benchmark, which is unclear whether it really reflects
real workload.

This v4 takes a completely different approach: it converts the rwlock to
spinlock. Unfortunately, unlike rwlock, spinlock does not allow concurrent
readers. This patch therefore reduces the performance numbers.

I have some optimization tricks to reduce spinlock contention and bring the
numbers back. But Linus appeared and declared that epoll's performance
shouldn't be the priority. So I decided not to post those optimization
patches.

For those who are curious, the optimization patches are at:
    git@github.com:covanam/linux.git epoll_optimize
be warned that they have not been well-tested.

The regression with v3 turned me into paranoid mode now. So I made this v4
as obvious as I can.

Nam Cao (1):
  eventpoll: Replace rwlock with spinlock

 fs/eventpoll.c | 139 +++++++++----------------------------------------
 1 file changed, 26 insertions(+), 113 deletions(-)

--=20
2.39.5


