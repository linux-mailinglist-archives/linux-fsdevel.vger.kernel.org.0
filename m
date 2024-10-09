Return-Path: <linux-fsdevel+bounces-31478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A05D69976A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00C71F22BC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FD11E3DD4;
	Wed,  9 Oct 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="slXIN3T8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BC1E1A04;
	Wed,  9 Oct 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506497; cv=none; b=Ea1ub5Guo7jvHR99pArhDMS2FeyknWVd73JMdNG/vsEUeN9P0H7PTLdhJWpd+X+vmdpJbWSx/G6Kstw+/jXZn8tNZoQmgdy9prTm4P0NQO71cQyPEMO7/x7NuGK+6MrfFjlyQonYXHemUQelepp4GLEKETpsp2DiwNQCrMXAKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506497; c=relaxed/simple;
	bh=HHdoaMHdkVQWx0FkhugGfSdSqGDM4p2QXOJQBPWZ+bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttOT4AfQzXgVZEwfQICSvctCDtwwQ87ypN8xj/B4pvggi0NAkdg9ANgFpNOQP95RI173pqquIcmVJlnCwRvO7l6Wijn68cbUgDEs3y8qpfJaqEnrHDyhtHrYmmunKFNfNelUXGCZ6FJGQ+18ZaYIwX5mIaA/lmDHrVj51cPJp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=slXIN3T8; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XP4YR4vTPz9tnm;
	Wed,  9 Oct 2024 22:41:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728506491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHaYV9nP73oZ6uB0oR4WRKvQDPGRHwYwcifbf4Jh92g=;
	b=slXIN3T8XIYncnTRetCVjUj8DfJg+NOBD0EOn9mTZhv/LyNq4wmwsFqcKmGyK95SsmfWCA
	HLIWf16K7r+OqxGan2slZ7copCdWJjfpNw0CnO9aMYYNEDv1GYLvKOBT6kFfQrrjfkLkeM
	wdHJ5DzF84d40Aa56Sklwu3Oe80IzT6A/865354ssZfpiz5WNximqOlRJhhYplRvmNN143
	mqv03TdvJvdUXfEzi5E02XGbuYaChPaVL7DIxtyWFSgk/AMT218/aV/udDqRsqLvj64087
	8nEzxLwlDcCeodXPKksXi+IKwKZRHBn3tLB2Bh1Mzr499xU0UaJBAVCivXadbA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 10 Oct 2024 07:40:36 +1100
Subject: [PATCH RFC v3 03/10] openat2: explicitly return -E2BIG for (usize
 > PAGE_SIZE)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-extensible-structs-check_fields-v3-3-d2833dfe6edd@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
In-Reply-To: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=HHdoaMHdkVQWx0FkhugGfSdSqGDM4p2QXOJQBPWZ+bQ=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaSzvQr87Z/06/j0Nffc1sXu3nRypSM/175w9yWKFUfju
 GXky9LedJSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJnHjByNDBIftiE9u7Ystv
 CfnfqwRDpJYFOp6Kme66aFLW9wMWgvWMDHv3Tp2aesyN7dzMZ3W88nvWWpzYw77gsv/ubyyPZXm
 2PecHAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4XP4YR4vTPz9tnm

While we do currently return -EFAULT in this case, it seems prudent to
follow the behaviour of other syscalls like clone3. It seems quite
unlikely that anyone depends on this error code being EFAULT, but we can
always revert this if it turns out to be an issue.

Cc: <stable@vger.kernel.org> # v5.6+
Fixes: fddb5d430ad9 ("open: introduce openat2(2) syscall")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/open.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..30bfcddd505d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1458,6 +1458,8 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
 
 	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
 		return -EINVAL;
+	if (unlikely(usize > PAGE_SIZE))
+		return -E2BIG;
 
 	err = copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
 	if (err)

-- 
2.46.1


