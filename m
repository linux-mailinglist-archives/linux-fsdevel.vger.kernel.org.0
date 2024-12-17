Return-Path: <linux-fsdevel+bounces-37629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B799F4B41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5FE7A2873
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727651F3D3D;
	Tue, 17 Dec 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROTbsHut";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UII679xc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECA1F03DE;
	Tue, 17 Dec 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439858; cv=none; b=rQ3I2xuYSB7suZHbPVXdlzT3I+ZklyqSUbdZ2s3woxR104j//QtgxBXOj6wSzUzOm9IdVZUwKRZNF3RRur96qEB7jZeBJf/SAXNrH7s8aT7pC4fsWEqLq4bYeiRXRYRhoXcIsLdNKU1rDNvrq9oMQqoFlIqeYSvBgQiSdTqAGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439858; c=relaxed/simple;
	bh=bJ7gV9ZTsNMLg72djeBgvkiG+fSzkNAJOAfn7NKUhoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=COcvoJszWh715j3xs930G0RFbUFgLwBdhOU0ckPpZ4gyBnUcnptV7mptgSIu+ipYn6Xa0bmzVX6Ng08Egi71vx7a7E6ysFLtOSKRWzE4bgFZf9+pL6f391AhtnVwHk5W7Nwbv6HfIEAUrTJwJwFI6Fp+2ydRrCw8XQvCY/CKQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROTbsHut; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UII679xc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734439855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUQK/2cgQvJUh9azohhqCQ3JLsguJVsMctqPqKzroTM=;
	b=ROTbsHutu1rdCy3pVLTO7Kj7iQshqnqDuTWuHGo5x4LqDjsYHwuW2j8VKd4eqxfLYDvQaO
	VJZUM93MxfeK0si0fXmDu++Hxhh9LFHswzmi1mhLKsmOVZM80R7Ya3KXGsZ7MTf9YczhuJ
	SYi1dCammp2IIuoQPX/d86OdN0SgYvah/AamW8+DTlf04wcrXI4HvXyKKTMalytoxtQdmx
	ax6jJMyylhMh9Hy3qJxx9UvHRiq0l9ls8HDupu5U327Q7wOT1G+RimqT3XxKbStSJAGqqD
	8S5fqr1Ob0cX7ACjA/MV31QqLZgJiNLF11lcWMBVgYQY1/3BN8o4Xo48K4o2wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734439855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUQK/2cgQvJUh9azohhqCQ3JLsguJVsMctqPqKzroTM=;
	b=UII679xc6aTw1hNve01KMUBsOp1JwDduSPPP2uXkvPWkwR5JHhaIIDIGkd0QLAndlKaUdl
	xlvzMFfDO2JpGvDg==
To: Nam Cao <namcao@linutronix.de>, Shuah Khan <shuah@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Dylan
 Hatch <dylanbhatch@google.com>, "Eric W . Biederman"
 <ebiederm@xmission.com>, John Ogness <john.ogness@linutronix.de>, Kees
 Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/proc: do_task_stat: Fix ESP not readable during
 coredump
In-Reply-To: <11e1777296b7d06085c9fd341bafc4b9d82e6e4e.1730883229.git.namcao@linutronix.de>
References: <cover.1730883229.git.namcao@linutronix.de>
 <11e1777296b7d06085c9fd341bafc4b9d82e6e4e.1730883229.git.namcao@linutronix.de>
Date: Tue, 17 Dec 2024 13:50:54 +0100
Message-ID: <87pllq79sh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 06 2024 at 10:22, Nam Cao wrote:
> Commit 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in
> /proc/PID/stat") disabled stack pointer reading, because it is generally
> dangerous to do so.
>
> Commit fd7d56270b52 ("fs/proc: Report eip/esp in /prod/PID/stat for
> coredumping") made an exception for coredumping thread, because for this
> case it is safe.
>
> The exception was later extended to all threads in a coredumping process by
> commit cb8f381f1613 ("fs/proc/array.c: allow reporting eip/esp for all
> coredumping threads").
>
> The above two commits determine if a task is core dumping by checking the
> PF_EXITING and PF_DUMPCORE flags.
>
> However, commit 92307383082d ("coredump:  Don't perform any cleanups before
> dumping core") moved coredump to happen earlier and before PF_EXITING is
> set. Thus, the check of the PF_EXITING flag no longer works.
>
> Instead, use task->signal->core_state to determine if coredump is
> happening. This pointer is set at the beginning of coredump and is cleared
> once coredump is done. Thus, while this pointer is not NULL, it is safe to
> read ESP.
>
> Fixes: 92307383082d ("coredump:  Don't perform any cleanups before dumping core")

Can we please make progress with that? It's a user space visible change
which causes a regression in core dumper tools.

Thanks,

        tglx

