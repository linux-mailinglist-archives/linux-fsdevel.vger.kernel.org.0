Return-Path: <linux-fsdevel+bounces-38316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB04B9FF6CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 09:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAF5188243B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422361946DF;
	Thu,  2 Jan 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tK3eQ0vH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oe6+KMvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32236124;
	Thu,  2 Jan 2025 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735806193; cv=none; b=nQ50RJoz3lGn3y0XmrQ8bLZTdzqh812CAGstbDL4xn+q10BQyz1I6hMb+1zK3F2d6PL2YljnD3hhGKSwz1JGKpvRWsXPQnWeHQaeWMJbRCMAy08nwZtcnzoLxml8KVNs1tsBMEuKZWyc97f9nl4y5GYppjsMUdEFIHtvIiAkhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735806193; c=relaxed/simple;
	bh=aQHNSSy5Ih+DpC3x3If0FYnsbKM/oZ8oORHcWAGnTrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHnoSE9VTw21erpjSM4UHkMEdVT1e2YiX5JdMXnIKeWJtoSH7a7UYmrCpIDoN3ACx3EPWFcZr9ZEjvSCwDkI6osdRHs6+rqte6Ot3dTzT5UlRKk11cXZWLJZDqI9/RBV8kLMYaSQBoRhNw2vdvSoTGh0qJLZydgYHzYk9+1iW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tK3eQ0vH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oe6+KMvT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735806189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nNo3GWZsCbJrB3XF4Zzi8CRZqhU8R5/xqD4yAPh4C9A=;
	b=tK3eQ0vHRyFe7Nj2uVETaf9s2GmCOLhF+8sxIVyUp141uVFr0+pnXhPUK146oroo1tZPpw
	ro1xhgUnW2mArZtitoDIEPbu8guJDwZqA17r/3z3ZWdaCSTLEoMyRFBkaaa7gPmLAnpD4+
	FIByEkkEg1Wo5J0rTcJ+TWQOd83grjZJxe+d3Nv4ODT6hHul/9EExFChLEwC1TFyker8DF
	zH7C2PIi2BneRH0du80pmW1u1f4JAmAQSIO6P8sByVk+49bl5ohLbvemBuLqRwSkadM3WX
	jWGY0rL7IvxMjcu5GvMDJzdo184RC5GhO5OFtbxJm1sZd9IGL3RcJGHGZOrxzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735806189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nNo3GWZsCbJrB3XF4Zzi8CRZqhU8R5/xqD4yAPh4C9A=;
	b=oe6+KMvTYJcEAStm34boIc5EthtgFVNT4S762LkKgi4cGpkq65WmqaZDHmUAeqiscXkLbp
	oIc7OhX2hycT2MAg==
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 0/2] fix reading ESP during coredump
Date: Thu,  2 Jan 2025 09:22:55 +0100
Message-Id: <cover.1735805772.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

In /proc/PID/stat, there is the kstkesp field which is the stack pointer of
a thread. While the thread is active, this field reads zero. But during a
coredump, it should have a valid value.

However, at the moment, kstkesp is zero even during coredump.

The first commit fixes this problem, and the second commit adds a selftest
to detect if this problem appears again in the future.

v2..v3 https://lore.kernel.org/lkml/cover.1735550994.git.namcao@linutronix.=
de/
  - Move stackdump file to local directory [Kees]
  - Always cleanup the stackdump file after the test [Kees]
  - Remove unused empty function

v1..v2 https://lore.kernel.org/lkml/cover.1730883229.git.namcao@linutronix.=
de/
  - Change the fix patch to use PF_POSTCOREDUMP [Oleg]

Nam Cao (2):
  fs/proc: do_task_stat: Fix ESP not readable during coredump
  selftests: coredump: Add stackdump test

 fs/proc/array.c                               |   2 +-
 tools/testing/selftests/coredump/Makefile     |   7 +
 tools/testing/selftests/coredump/README.rst   |  50 ++++++
 tools/testing/selftests/coredump/stackdump    |  14 ++
 .../selftests/coredump/stackdump_test.c       | 151 ++++++++++++++++++
 5 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/coredump/Makefile
 create mode 100644 tools/testing/selftests/coredump/README.rst
 create mode 100755 tools/testing/selftests/coredump/stackdump
 create mode 100644 tools/testing/selftests/coredump/stackdump_test.c

--=20
2.39.5


