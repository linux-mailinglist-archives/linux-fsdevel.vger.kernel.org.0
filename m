Return-Path: <linux-fsdevel+bounces-38269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCEB9FE540
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 11:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F571882872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECF1A83EF;
	Mon, 30 Dec 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LauSOo0m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1yvnCOfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9A1A4E70;
	Mon, 30 Dec 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553867; cv=none; b=M+9rTWSJaGMfzCjIDWnObZ+151MKO39/pIu+UVXQRMeEhLOhps7uXtrj3hm+L1WiXVIJXDmIxkmny2xSz8eW4Q3Y13ennBOUcwmXtx60Z7hjVhTS3i5Wffk9qHeqYsG0F7VXMacM2nNzmfaE7qBNETfxRqMamsGQWwTc2+IkK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553867; c=relaxed/simple;
	bh=jQaDqFkDHGAbbzbTmVB6dRBzxKKbeUg+TFQXF/cEm2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3w/NJfyXZJ2BVs1WBav7FCM3Bx1voJHwqELpObWM2WPTFxbewbowYbeOxVRpJ/MUDCKK6KrrZjqa3dF2zOV6vCdUrwWv5D1Us3HAxEHKRY84JHrZxI1lV+bAmtLnWck0N+0igq39kPFjVJNfTpDifZCm/3g7iNZOSlEOkMfZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LauSOo0m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1yvnCOfO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735553857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HSMEuHKYFqyUXO5hSBj5GEYvpwE9Diu8J7sZ9HXVnwU=;
	b=LauSOo0mWYZQUKn/UV1tMd9MUZj48JpkjVdvZqCamSGNUfuzuW/C6/AmsF5HRhXtQlMn0j
	cTnE/rSsRECIYcQvnhfPd//1z/ICt74cz/90T1Jg29a1gQBerzp3s3033ea9jVibBe92m0
	+i/JnDwCltOkQC3fMwdN4fJjnwmbHHRyQ913vgG+Eq+LOB8ZKwzaz4CcwF/shgccrnbvAE
	5lStKFhH6Cz5MEADuENh1hh0i7nOa0oyNksAzPDNIQtcW3MJqJz9WB5hebW8qMJpgs+A5S
	P3zoZrHpfen+Yf8BeW6ujbU5USKEQa0knQtgKRvKzO4qcFKJOWDhDW6Qlq5New==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735553857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HSMEuHKYFqyUXO5hSBj5GEYvpwE9Diu8J7sZ9HXVnwU=;
	b=1yvnCOfO9AjTe2U6DozHgDMppGb8BoCefDsGLDUqqKG1kzi6j/yUSizjiwGY8Skx0Jgdg9
	z/04PA92WbB5ksCA==
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
Subject: [PATCH v2 0/2] fix reading ESP during coredump
Date: Mon, 30 Dec 2024 11:17:29 +0100
Message-Id: <cover.1735550994.git.namcao@linutronix.de>
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

v2:
  - Change the fix patch to use PF_POSTCOREDUMP [Oleg]

Link to v1:
  https://lore.kernel.org/lkml/cover.1730883229.git.namcao@linutronix.de/

Nam Cao (2):
  fs/proc: do_task_stat: Fix ESP not readable during coredump
  selftests: coredump: Add stackdump test

 fs/proc/array.c                               |   2 +-
 tools/testing/selftests/coredump/Makefile     |   7 +
 tools/testing/selftests/coredump/README.rst   |  50 ++++++
 tools/testing/selftests/coredump/stackdump    |  14 ++
 .../selftests/coredump/stackdump_test.c       | 154 ++++++++++++++++++
 5 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/coredump/Makefile
 create mode 100644 tools/testing/selftests/coredump/README.rst
 create mode 100755 tools/testing/selftests/coredump/stackdump
 create mode 100644 tools/testing/selftests/coredump/stackdump_test.c

--=20
2.39.5


