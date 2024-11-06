Return-Path: <linux-fsdevel+bounces-33727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B89BE24A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EFE1F226B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DFD1D9341;
	Wed,  6 Nov 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MM2bZesW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g9eGje0F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D4198E80;
	Wed,  6 Nov 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884953; cv=none; b=EC4wKh9dltt4fbFvQN/EC8pFZTDRv1D1dAHdAAzFM06sAmyC+2tUUAAcEtmu2NOmIampNtRKlqHPrdXAdn6lZO2G5wx1JLq/x/9zrzFteRU6Zx7VXk1v28uYE+18AKuJRUv14iFV/+sdaKqqUoaK2XGns1s/t3T0F06Y+m82uzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884953; c=relaxed/simple;
	bh=5qoJM70NTtWWb/4K3e0/PrPCH6R3eYNFuNWINYpsrT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cK8FpfqBgfn+BJUtD2MnFUcqC2Oh38+yhZFLdwPBbpW1KFZ+AjaagOHKyNy3tGa8/4g2XTJnTORG8CB8YebJ9c7ENvzYri38ZCky41aR1SCH+bDU1MVkEGtUwoQNJ+zUKds76n3WVV8ugoMWMpflnk5QtEF2BHTaRzpjgfmYRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MM2bZesW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g9eGje0F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730884949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ucM0Xa47bBE4k1wlq/Myz0uqZ1pLu02YCO0xbf8QpEw=;
	b=MM2bZesWsCbcKBfa0q8cS+XEZW0U5nWH3KZ7HZOZhFUTe6QijkfQh02+/gOLBLDxyTMFEA
	Kc63MvZ23L1kqSshrPLgKeiexwwMuSMZJEWbxEjBXNV6RbNAc5Z5/xVsv40GDEA4GdkeDu
	QHWgpjTknVzJjgDT/YFcJ9yMvJN3RyKLym6xgXCP1Q3djpJk7TVcS3KRbSGYfXf0VUYD83
	Lp4pn9+KFsrnrW5a+KTN26Hg+LMUCGYKYeNz5vhPh1aJES7pUFcq/5d7xzY8d5OpJxJ0fs
	Pg8WAwhEYQNT6XrVuJ/6ku/5WLk26AHpklZ7v2FHEK6xDDmr+LccLGDS3rsC3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730884949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ucM0Xa47bBE4k1wlq/Myz0uqZ1pLu02YCO0xbf8QpEw=;
	b=g9eGje0FRaJMSZh/4E9padn4xjOtOfJY2Sxw7teIk7BLeF7Yr1+fV5UTS4SyjQDTpT6IM0
	iw0m3vX0ifi7V3Bw==
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
Subject: [PATCH 0/2] fix reading ESP during coredump
Date: Wed,  6 Nov 2024 10:22:14 +0100
Message-Id: <cover.1730883229.git.namcao@linutronix.de>
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

Nam Cao (2):
  fs/proc: do_task_stat: Fix ESP not readable during coredump
  selftests: coredump: Add stackdump test

 fs/proc/array.c                               |  36 ++--
 tools/testing/selftests/coredump/Makefile     |   7 +
 tools/testing/selftests/coredump/README.rst   |  50 ++++++
 tools/testing/selftests/coredump/stackdump    |  14 ++
 .../selftests/coredump/stackdump_test.c       | 154 ++++++++++++++++++
 5 files changed, 243 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/coredump/Makefile
 create mode 100644 tools/testing/selftests/coredump/README.rst
 create mode 100755 tools/testing/selftests/coredump/stackdump
 create mode 100644 tools/testing/selftests/coredump/stackdump_test.c

--=20
2.39.5


