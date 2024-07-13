Return-Path: <linux-fsdevel+bounces-23634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C2930664
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BEE1F21ABC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED9613C818;
	Sat, 13 Jul 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph7Pb9kr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE21386DF;
	Sat, 13 Jul 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720888304; cv=none; b=OGKZ3CZeQ6pO2xsyRYMdYbglj14JABBJdCQjEbEbibTQRbL0+xKWPUfNqa1hbHMWV6oKWuFEONw+XNSvs0p/NeizIqsVZsZ2cnd4OTNaHjHVOGUfA5y4/NAfEWASPqPTY4bMZ4j8ICK2fcElX9BOerAeFzxmRLuOp3x0YrsEgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720888304; c=relaxed/simple;
	bh=K1p6MLOeYFJkkB/mYrJY/2L1UK9sdhYQYCjNk1tJ2UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiHL4VTxSc38i82rkl5P05r5rpiBWFacDveQOUcI24VAXoSchVV2UmfvlohGJYap/l8XLXFBbqtkFkCPn3Tp1/o425kceKpAI5bOBicm/CLm9kunGm/Lcp0bKFv/nBWH7L0CZJYKm7QWAVrPnHgkdvQV2vM4s+dYp1apO8QmBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph7Pb9kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6931C32781;
	Sat, 13 Jul 2024 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720888303;
	bh=K1p6MLOeYFJkkB/mYrJY/2L1UK9sdhYQYCjNk1tJ2UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ph7Pb9krgqwoAsG5PA6szWbkaFzoGg+oL3GgEJUD+4AAJwVaFNSGH/hHfY2x3k7qI
	 lhAAjPPlNt8TjN0oqp2O42H4KA+09ZlUWBg2ZrdP2PHxdJVWP1k5nls8BzIOREJ7Qt
	 LLHWsRez3JYvbOJuxbTef2EPza8ByFzQwa00eJvud1QyigVASg8NvD2XypS5+fXgp2
	 6wnkDJsOD/I4LOOmYuWUi8IyxXPqdUfCWV14x0y3kZtNyIv9Gvz0T2WLhfq8Y7KtZ+
	 Bb+d458tlV+ugAOxPNDswoX/5U7QaG3LR2ubnweduOWfx3Fkjgkc+IGPtB3RnKkLbZ
	 /7K+x6LnIsYCg==
Date: Sat, 13 Jul 2024 09:31:43 -0700
From: Kees Cook <kees@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: akpm@linux-foundation.org, apais@linux.microsoft.com, ardb@kernel.org,
	bigeasy@linutronix.de, brauner@kernel.org, ebiederm@xmission.com,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nagvijay@microsoft.com, oleg@redhat.com, tandersen@netflix.com,
	vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk,
	apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v2 1/1] binfmt_elf, coredump: Log the reason of the
 failed core dumps
Message-ID: <202407130840.67879B31@keescook>
References: <20240712215223.605363-1-romank@linux.microsoft.com>
 <20240712215223.605363-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712215223.605363-2-romank@linux.microsoft.com>

On Fri, Jul 12, 2024 at 02:50:56PM -0700, Roman Kisel wrote:
> Missing, failed, or corrupted core dumps might impede crash
> investigations. To improve reliability of that process and consequently
> the programs themselves, one needs to trace the path from producing
> a core dumpfile to analyzing it. That path starts from the core dump file
> written to the disk by the kernel or to the standard input of a user
> mode helper program to which the kernel streams the coredump contents.
> There are cases where the kernel will interrupt writing the core out or
> produce a truncated/not-well-formed core dump without leaving a note.
> 
> Add logging for the core dump collection failure paths to be able to reason
> what has gone wrong when the core dump is malformed or missing.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  fs/binfmt_elf.c          |  60 ++++++++++++++++-----
>  fs/coredump.c            | 109 ++++++++++++++++++++++++++++++++-------
>  include/linux/coredump.h |   8 ++-
>  kernel/signal.c          |  22 +++++++-
>  4 files changed, 165 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index a43897b03ce9..cfe84b9436af 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1994,8 +1994,11 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	 * Collect all the non-memory information about the process for the
>  	 * notes.  This also sets up the file header.
>  	 */
> -	if (!fill_note_info(&elf, e_phnum, &info, cprm))
> +	if (!fill_note_info(&elf, e_phnum, &info, cprm)) {
> +		pr_err_ratelimited("Error collecting note info, core dump of %s(PID %d) failed\n",
> +			current->comm, current->pid);

A couple things come to mind for me as I scanned through this:

- Do we want to report pid or tgid?
- Do we want to report the global value or the current pid namespace
  mapping?

Because I notice that the existing code:

>  			printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
>  			       task_tgid_vnr(current), current->comm);

Is reporting tgid for current's pid namespace. We should be consistent.

I think all of this might need cleaning up first before adding new
reports. We should consolidate the reporting into a single function so
this is easier to extend in the future. Right now the proposed patch is
hand-building the report, and putting pid/comm in different places (at
the end, at the beginning, with/without "of", etc), which is really just
boilerplate repetition.

How about creating:

static void coredump_report_failure(const char *msg)
{
	char comm[TASK_COMM_LEN];

	task_get_comm(current, comm);

	pr_warn_ratelimited("coredump: %d(%*pE): %s\n",
			    task_tgid_vnr(current), strlen(comm), comm, msg);
}

Then in a new first patch, convert all the existing stuff:

	printk(KERN_WARNING ...)
	pr_info(...)
	etc

Since even the existing warnings are inconsistent and don't escape
newlines, etc. :)

Then in patch 2 use this to add the new warnings?

-- 
Kees Cook

