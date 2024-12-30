Return-Path: <linux-fsdevel+bounces-38277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358449FEA1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 19:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1DB161460
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADC41917D6;
	Mon, 30 Dec 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCtEZCrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB34189BAF;
	Mon, 30 Dec 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735584241; cv=none; b=ZnC67TTrRVx05O/FLc4U6CEimBQtGSVLjcd+YVrZ3Sj8YGd+u2BMkTwP0Hqjjcm5fjjDKUqp9qlnk2F/zSrTKJ7eYUjphusJzng8kq33rTqt4EL3h8YxZeuoUEtQ+plpvWijnSczWplJ46M3QdwYVFJDvbspKFBCPTAu8CmUmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735584241; c=relaxed/simple;
	bh=EaGvYshQAYBF6LKL/0EP5Ojxz4m17etFuYNOpimT77U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBvUylgAtDL50m7f+amh295/NMmUyNhsMNAGtD4riARRHCbLNVzp07CvBLZgVs2oRJfoC7BYKxBs6X7uTqW3vxC9N0rccIc18n4RJV/bNW99N+1F7OoEUlPEAVa+sBHujKewtdnwQt7ew0WIe4mJj6yOaEM4a/2kwW0qQMHG2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCtEZCrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F296DC4CED0;
	Mon, 30 Dec 2024 18:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735584241;
	bh=EaGvYshQAYBF6LKL/0EP5Ojxz4m17etFuYNOpimT77U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCtEZCrJQikaZ0APHkYa8PUHU9/D0b+d21VFJbBSyLqNEWn8fat7df4oF+Gpm77Qb
	 WurCGl/bKh/b2+l+8aJ9wzYR2U2FEsfeIA68Xm9ccGY26kfI7SYmj9uzbz5jg5wa3p
	 gRbleZYLx+I6+LjXyZB0qdORzwMXE9Juqf7YWluUEB1Axf9Uax0GqZfkHX3pGriFyl
	 nCgjEbsaTVOkYVdMfRNN+nvLAUdr4si9RYx9XHnyiKjeKYV1BgPklKep9gqYp9kFpb
	 +NlkZx0o4wBIjH3jL/ENWm/OeV5eyQaJ/QB2C6NgRWIEphcej7tXIl3Ypq1NzyiYNf
	 DnhuTBLEKuhyQ==
Date: Mon, 30 Dec 2024 10:43:58 -0800
From: Kees Cook <kees@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs/proc: do_task_stat: Fix ESP not readable
 during coredump
Message-ID: <202412301043.78340B2FD@keescook>
References: <cover.1735550994.git.namcao@linutronix.de>
 <c2f1b742c2b8f230f8e0ffa10a061116934dcf5b.1735550994.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f1b742c2b8f230f8e0ffa10a061116934dcf5b.1735550994.git.namcao@linutronix.de>

On Mon, Dec 30, 2024 at 11:17:30AM +0100, Nam Cao wrote:
> The field "eip" (instruction pointer) and "esp" (stack pointer) of a task
> can be read from /proc/PID/stat. These fields can be interesting for
> coredump.
> 
> However, these fields were disabled by commit 0a1eb2d474ed ("fs/proc: Stop
> reporting eip and esp in /proc/PID/stat"), because it is generally unsafe
> to do so. But it is safe for a coredumping process, and therefore
> exceptions were made:
> 
>   - for a coredumping thread by commit fd7d56270b52 ("fs/proc: Report
>     eip/esp in /prod/PID/stat for coredumping").
> 
>   - for all other threads in a coredumping process by commit cb8f381f1613
>     ("fs/proc/array.c: allow reporting eip/esp for all coredumping
>     threads").
> 
> The above two commits check the PF_DUMPCORE flag to determine a coredump thread
> and the PF_EXITING flag for the other threads.
> 
> Unfortunately, commit 92307383082d ("coredump:  Don't perform any cleanups
> before dumping core") moved coredump to happen earlier and before PF_EXITING is
> set. Thus, checking PF_EXITING is no longer the correct way to determine
> threads in a coredumping process.
> 
> Instead of PF_EXITING, use PF_POSTCOREDUMP to determine the other threads.
> 
> Checking of PF_EXITING was added for coredumping, so it probably can now be
> removed. But it doesn't hurt to keep.
> 
> Fixes: 92307383082d ("coredump:  Don't perform any cleanups before dumping core")
> Cc: stable@vger.kernel.org
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Thanks for fixing this!

Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

