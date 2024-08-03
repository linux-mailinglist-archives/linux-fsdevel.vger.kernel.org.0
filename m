Return-Path: <linux-fsdevel+bounces-24908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559794670E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 05:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0729F282288
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 03:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDD31401F;
	Sat,  3 Aug 2024 03:26:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A7511CA9;
	Sat,  3 Aug 2024 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655567; cv=none; b=Yna5EqNpIMZ9oGnaPzaNEYwFnZddgHTZyloABJK9EBlhF+tIfGJkU+j5Z3ycicMWKDIKd0KORniJe80vfruqicOdwFxPe8f1SNfy7xrWNVJB2+n8l3WAZ0o4BKfm6XoWC5ZA3ylw9gkgNiknt7AV/TUHzQo30iUpIZuNLROaiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655567; c=relaxed/simple;
	bh=Dzwv9n15SCMSRnnQGlDA1DIoFT71ZYDAoIsgMndEgBY=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=BFB+6wWndzNuBQLrSwVggpEUw19zIMdU+Oh/WQKVPZssmleq3H4y0CrrRaSkWJcr7gjiXLeb8hNmzRHtInW8jvV0E4h44QHw0dVSew/kmZJ9mYm4JM0Eo3GsgkqDaqlwmSa+EJrPVRffpRqZOUQSSsBaCFOIB16bvg1evOfA9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:50552)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sa5P9-006D1f-R6; Fri, 02 Aug 2024 21:26:03 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:41068 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sa5P8-004BKb-DJ; Fri, 02 Aug 2024 21:26:03 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Brian Mak <makb@juniper.net>
Cc: Kees Cook <kees@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Oleg
 Nesterov <oleg@redhat.com>
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
Date: Fri, 02 Aug 2024 22:25:55 -0500
In-Reply-To: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net> (Brian Mak's
	message of "Fri, 2 Aug 2024 22:37:37 +0000")
Message-ID: <8734nmuw1o.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sa5P8-004BKb-DJ;;;mid=<8734nmuw1o.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX195fMAOoz0EAYwydxkl9prq82nlShK7aXo=
X-SA-Exim-Connect-IP: 68.227.165.127
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Brian Mak <makb@juniper.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 812 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.8 (0.6%), b_tie_ro: 3.3 (0.4%), parse: 1.28
	(0.2%), extract_message_metadata: 16 (1.9%), get_uri_detail_list: 4.0
	(0.5%), tests_pri_-2000: 22 (2.8%), tests_pri_-1000: 2.0 (0.2%),
	tests_pri_-950: 0.98 (0.1%), tests_pri_-900: 0.81 (0.1%),
	tests_pri_-90: 346 (42.6%), check_bayes: 336 (41.4%), b_tokenize: 8
	(1.0%), b_tok_get_all: 11 (1.3%), b_comp_prob: 3.3 (0.4%),
	b_tok_touch_all: 311 (38.2%), b_finish: 0.82 (0.1%), tests_pri_0: 405
	(49.8%), check_dkim_signature: 0.43 (0.1%), check_dkim_adsp: 3.0
	(0.4%), poll_dns_idle: 1.36 (0.2%), tests_pri_10: 2.6 (0.3%),
	tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] binfmt_elf: Dump smaller VMAs first in ELF cores
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Brian Mak <makb@juniper.net> writes:

> Large cores may be truncated in some scenarios, such as with daemons
> with stop timeouts that are not large enough or lack of disk space. This
> impacts debuggability with large core dumps since critical information
> necessary to form a usable backtrace, such as stacks and shared library
> information, are omitted.
>
> Attempting to find all the VMAs necessary to form a proper backtrace and
> then prioritizing those VMAs specifically while core dumping is complex.
> So instead, we can mitigate the impact of core dump truncation by
> dumping smaller VMAs first, which may be more likely to contain memory
> necessary to form a usable backtrace.

I think I would say something like:  We attempted to figure out which
VMAs are needed to create a useful backtrace, and it turned out to
be a non-trivial problem.  So instead you tried simply sorting
the vma's by size and that worked.

Something to convey it is a tricky problem without an easy solution,
and that it wasn't work solving.

> By sorting VMAs by dump size and dumping in that order, we have a
> simple, yet effective heuristic.

I like the improvement to the description, and I like the improved
simplicity of this.

I will repeat myself quickly and say I would like this even better if
the sorting could be moved to the end of dump_vma_snapshot in
fs/coredump.c, and the original array of vmas could be sorted.

That removes all concerns about taking up more memory, as well
as adding the improvement to ELF FDPIC as well.

Sorting the original array will also change file_files_notes
which will result in the NT_FILE note ordering the mapped files
in the same order as the program headers are written.  There
is enough information I don't think it matters, but consistency
is nice.

Eric

> Signed-off-by: Brian Mak <makb@juniper.net>
> ---
>
> v2: Edited commit message to include more reasoning for sorting VMAs
>     Removed conditional VMA sorting with debugfs knob
>     Above edits suggested by Eric Biederman <ebiederm@xmission.com>
>
>  fs/binfmt_elf.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 19fa49cd9907..7feadbdd9ee6 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -37,6 +37,7 @@
>  #include <linux/elf-randomize.h>
>  #include <linux/utsname.h>
>  #include <linux/coredump.h>
> +#include <linux/sort.h>
>  #include <linux/sched.h>
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/task_stack.h>
> @@ -1990,6 +1991,20 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
>  	shdr4extnum->sh_info = segs;
>  }
>  
> +static int cmp_vma_size(const void *vma_meta_lhs_ptr, const void *vma_meta_rhs_ptr)
> +{
> +	const struct core_vma_metadata *vma_meta_lhs = *(const struct core_vma_metadata **)
> +		vma_meta_lhs_ptr;
> +	const struct core_vma_metadata *vma_meta_rhs = *(const struct core_vma_metadata **)
> +		vma_meta_rhs_ptr;
> +
> +	if (vma_meta_lhs->dump_size < vma_meta_rhs->dump_size)
> +		return -1;
> +	if (vma_meta_lhs->dump_size > vma_meta_rhs->dump_size)
> +		return 1;
> +	return 0;
> +}
> +
>  /*
>   * Actual dumper
>   *
> @@ -2008,6 +2023,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	struct elf_shdr *shdr4extnum = NULL;
>  	Elf_Half e_phnum;
>  	elf_addr_t e_shoff;
> +	struct core_vma_metadata **sorted_vmas = NULL;
>  
>  	/*
>  	 * The number of segs are recored into ELF header as 16bit value.
> @@ -2071,9 +2087,20 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
>  		goto end_coredump;
>  
> +	/* Allocate memory to sort VMAs and sort. */
> +	sorted_vmas = kvmalloc_array(cprm->vma_count, sizeof(*sorted_vmas), GFP_KERNEL);
> +
> +	if (!sorted_vmas)
> +		goto end_coredump;
> +
> +	for (i = 0; i < cprm->vma_count; i++)
> +		sorted_vmas[i] = cprm->vma_meta + i;
> +
> +	sort(sorted_vmas, cprm->vma_count, sizeof(*sorted_vmas), cmp_vma_size, NULL);
> +
>  	/* Write program headers for segments dump */
>  	for (i = 0; i < cprm->vma_count; i++) {
> -		struct core_vma_metadata *meta = cprm->vma_meta + i;
> +		struct core_vma_metadata *meta = sorted_vmas[i];
>  		struct elf_phdr phdr;
>  
>  		phdr.p_type = PT_LOAD;
> @@ -2111,7 +2138,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	dump_skip_to(cprm, dataoff);
>  
>  	for (i = 0; i < cprm->vma_count; i++) {
> -		struct core_vma_metadata *meta = cprm->vma_meta + i;
> +		struct core_vma_metadata *meta = sorted_vmas[i];
>  
>  		if (!dump_user_range(cprm, meta->start, meta->dump_size))
>  			goto end_coredump;
> @@ -2129,6 +2156,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	free_note_info(&info);
>  	kfree(shdr4extnum);
>  	kfree(phdr4note);
> +	kvfree(sorted_vmas);
>  	return has_dumped;
>  }
>  
>
> base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d

