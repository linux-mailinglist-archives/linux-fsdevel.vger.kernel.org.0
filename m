Return-Path: <linux-fsdevel+bounces-18163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F458B6138
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 20:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C621F2225B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B1512A157;
	Mon, 29 Apr 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n2Sigmal"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9B67A14;
	Mon, 29 Apr 2024 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415926; cv=none; b=GgoYfTNBiJc7UBjxByGeCx9ES1G7kRaMlirI/b3nf/ZZuh/hdcDlcTQIhk4Ju0pqX3NQmK70P9YOQP7UWedRYdMjH1GvZLAbHQMlQyALzN8NR6eCAlgdl+EQHFcFd5znVUu/akpnlER1ggGalc9EazbJrhCjYBAS4NXnkbPrWxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415926; c=relaxed/simple;
	bh=195C9nIwNh1lmaOXqjfZD4ItUOxg/XueSkuoCzneoWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY4lugn/FemBNQXWtEQWN5z5fjxLZKsywW/qO0c3h9qn1depEPDs5bZRchwSMRoMDrF+19ElVWTHcTIQ7Ink3vk2YYhHLqqQuQZNxXUhEvC37ay8u8CwkMJm456n6kOEZQH8qM6eokTp41BbtbMca1v4No6k4f68Vv7Iu3QXmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n2Sigmal; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Un8ngqywrftT4NxpkTUiNzqeWjbiCXUSCQfTmTunVeQ=; b=n2SigmalDCeek8ry5sud7+wrNg
	jLEW9gVIj3LtZCcbB4u3TclX75PGVogMBEzvslg4nQBEtFlYwfz7Y7Uio2F+AGnVZZU4UsMsvDkfj
	dT2CV2H+/kv76TLykHa42wLq64Iy9r92eZ9b2GkrVBZAJSsqP17CGFSLrwer+8lXMVrvLbsbrjYSz
	77GQU55gtpQrv39XZnCaaZDrOlPbaC37GV8dkGlo2KHyZkPQpqQ4QbPA9hzfUmx92Mzs1LPhalpKr
	5bBzMbQPXU5aWuWxvgjgOl1MDDGSzgCn+9e3H3QKW/jifURER2TizGLIzbM9TYG4Kj4A/TFJPBq4a
	FN+HX5IA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Vtk-00000003tLh-2HjW;
	Mon, 29 Apr 2024 18:38:44 +0000
Date: Mon, 29 Apr 2024 11:38:44 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, ebiederm@xmission.com, keescook@chromium.org,
	j.granados@samsung.com
Subject: Re: [RFC PATCH] fs/coredump: Enable dynamic configuration of max
 file note size
Message-ID: <Zi_pNF0OMgKViIWe@bombadil.infradead.org>
References: <20240429172128.4246-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429172128.4246-1-apais@linux.microsoft.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Apr 29, 2024 at 05:21:28PM +0000, Allen Pais wrote:
> Introduce the capability to dynamically configure the maximum file
> note size for ELF core dumps via sysctl. This enhancement removes
> the previous static limit of 4MB, allowing system administrators to
> adjust the size based on system-specific requirements or constraints.
> 
> - Remove hardcoded `MAX_FILE_NOTE_SIZE` from `fs/binfmt_elf.c`.
> - Define `max_file_note_size` in `fs/coredump.c` with an initial value set to 4MB.
> - Declare `max_file_note_size` as an external variable in `include/linux/coredump.h`.
> - Add a new sysctl entry in `kernel/sysctl.c` to manage this setting at runtime.
> 
> $ sysctl -a | grep max_file_note_size
> kernel.max_file_note_size = 4194304
> 
> $ sysctl -n kernel.max_file_note_size
> 4194304
> 
> $echo 519304 > /proc/sys/kernel/max_file_note_size
> 
> $sysctl -n kernel.max_file_note_size
> 519304

This doesn't highlight anything about *why*. So in practice you must've
hit a use case where ELF notes are huge, can you give an example of
that? The commit should also describe that this is only used in the path
of a coredump on ELF binaries via elf_core_dump().

More below.

> Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> ---
>  fs/binfmt_elf.c          | 3 +--
>  fs/coredump.c            | 3 +++
>  include/linux/coredump.h | 1 +
>  kernel/sysctl.c          | 8 ++++++++
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5397b552fbeb..5fc7baa9ebf2 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
>  	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
>  }
>  
> -#define MAX_FILE_NOTE_SIZE (4*1024*1024)
>  /*
>   * Format of NT_FILE note:
>   *
> @@ -1592,7 +1591,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
>  
>  	names_ofs = (2 + 3 * count) * sizeof(data[0]);
>   alloc:
> -	if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
> +	if (size >= max_file_note_size) /* paranoia check */
>  		return -EINVAL;
>  	size = round_up(size, PAGE_SIZE);
>  	/*
> diff --git a/fs/coredump.c b/fs/coredump.c
> index be6403b4b14b..a83c6cc893fc 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -56,10 +56,13 @@
>  static bool dump_vma_snapshot(struct coredump_params *cprm);
>  static void free_vma_snapshot(struct coredump_params *cprm);
>  
> +#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> +
>  static int core_uses_pid;
>  static unsigned int core_pipe_limit;
>  static char core_pattern[CORENAME_MAX_SIZE] = "core";
>  static int core_name_size = CORENAME_MAX_SIZE;
> +unsigned int max_file_note_size = MAX_FILE_NOTE_SIZE;
>  
>  struct core_name {
>  	char *corename;
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index d3eba4360150..e1ae7ab33d76 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -46,6 +46,7 @@ static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
>  #endif
>  
>  #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
> +extern unsigned int max_file_note_size;
>  extern void validate_coredump_safety(void);
>  #else
>  static inline void validate_coredump_safety(void) {}
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 81cc974913bb..80cdc37f2fa2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -63,6 +63,7 @@
>  #include <linux/mount.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/pid.h>
> +#include <linux/coredump.h>
>  
>  #include "../lib/kstrtox.h"
>  
> @@ -1623,6 +1624,13 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> +	{
> +		.procname       = "max_file_note_size",
> +		.data           = &max_file_note_size,
> +		.maxlen         = sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec,
> +	},
>  #ifdef CONFIG_PROC_SYSCTL

No, please move this to coredump_sysctls in fs/coredump.c. And there is
no point in supporting int, this is unisgned int right? So use the right
proc handler for it.

If we're gonna do this, it makes sense to document the ELF note binary
limiations. Then, consider a defense too, what if a specially crafted
binary with a huge elf note are core dumped many times, what then?
Lifting to 4 MiB puts in a situation where abuse can lead to many silly
insane kvmalloc()s. Is that what we want? Why?

  Luis

