Return-Path: <linux-fsdevel+bounces-33798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00E9BF062
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D341F21128
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D7F202F8C;
	Wed,  6 Nov 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehYkobY5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rs+3xF/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E41CC14B;
	Wed,  6 Nov 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903455; cv=none; b=Rd53mAII1/SUG2jlRUB+Xfoeu/iugN9rDdQmwj46vh7/TlpOmjhtJV5JrespShbOvDP165srVvFwAweMP61gQz+VFMfBSXbbigmDDOWa/rWqgyLmc9GjI5YXjCZ0Tu/NdaqwR03PlNRoN/Ijz2kuRtQE5twjkfaURdxMxGK3WP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903455; c=relaxed/simple;
	bh=x7jVnVVoWPO5tiQh3eSfB3zX1+LgNqJNsOPsnti6GTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNxqIY7yXdLp3/z/RRUpLL+S15maCNJ9ajcqMZpthYbqtFw32gAp80gqGyxasGRw8WkNfyHdPNoS6R5TM62iKE+Bd55fFsMTj+RVFGdOw96SRCyoe4+w0nIHP3byZ9jd+jjqDqCklIRUEn7qpGYXBeXrpF2ijpm52nVXAQQHufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ehYkobY5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rs+3xF/7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730903446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qsFfiRe9gtcetAnwbxi6H3JMAAlIKif645qpkHp/z2E=;
	b=ehYkobY5sQguPZErJgH9bTk0IptC7qBhodoLwSs2MeKxVBXUe6F3SL/aqNuqlol3M8++kG
	IQx7SWYyIwgwnzOZp570+kSfC/WsTxQz1ed+txUUXUcD2M0pu55Yxy8WZRv3oKeDDLMGgJ
	gn9JJVelaaDGu8rPlhPdPG11LUfqaxl7IelTvNjOm31WBwtEMSYvJaM21lTFbOhYHVZHoo
	2VQOf8NPytnPcIQV5fVCrlsGTHDbksCJxcLPnEKkLIaDU/YVGwTDN/e7OHnicVe6+0tCoN
	tZE1UMuFiUDl9U6KRwjK2RX/UI68bXyTj0fUtL39MLkLxlU8Rp/NRTVNxD2Grw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730903446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qsFfiRe9gtcetAnwbxi6H3JMAAlIKif645qpkHp/z2E=;
	b=Rs+3xF/7YOpwYfSVFd1QkmE2jNS+l2s82e6ApJ41jIaRgiHXL79hI+xUR6IcRkZTjl6Bna
	fgnbyLoqPZq4unAQ==
To: Nam Cao <namcao@linutronix.de>, Shuah Khan <shuah@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Dylan
 Hatch <dylanbhatch@google.com>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/proc: do_task_stat: Fix ESP not readable during
 coredump
In-Reply-To: <11e1777296b7d06085c9fd341bafc4b9d82e6e4e.1730883229.git.namcao@linutronix.de>
References: <cover.1730883229.git.namcao@linutronix.de>
 <11e1777296b7d06085c9fd341bafc4b9d82e6e4e.1730883229.git.namcao@linutronix.de>
Date: Wed, 06 Nov 2024 15:36:45 +0106
Message-ID: <848qtwfn8q.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-06, Nam Cao <namcao@linutronix.de> wrote:
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
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

