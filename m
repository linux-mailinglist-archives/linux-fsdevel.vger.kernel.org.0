Return-Path: <linux-fsdevel+bounces-25593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7794DD06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 15:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F072BB219B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8047515886A;
	Sat, 10 Aug 2024 13:07:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3F4502F;
	Sat, 10 Aug 2024 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723295246; cv=none; b=GnbWRwB2pA3zxFpuCL2M0oKvUFfBU6SdHWFnfP78bTXZ/FQWIGoGoR4/RwB6rhjw3iBZo7t25tqomwvX6skNlgkIGnL9+gs2OYLB0NBw86K780sFS0VRe71fG3Y2rVQnuGrSd5nqrSP1T3vgOZ4rH+znZUVpf25GhoxJOTn12L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723295246; c=relaxed/simple;
	bh=lA7wfsTzEeALFVA1uePvAiyAa2UikxL8+WrnzDm/SRo=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=IgaROTYh/+H+sgpSdFAH+1KCd8EsuIyGG2nAHPyEEVWuaDKVyc1niZzN8M6D8hDS5PRg8CJF7cy0YuxtjIZA2EpCGAoFggCNZIUrwmFp62aBY73jcoa1tcI6KYCTx5rK4fJROXUYZftjtOdBlFVb9Gy5Bv+NCW2FyDDu2oYrejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:40214)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sclEN-009WSV-KQ; Sat, 10 Aug 2024 06:30:00 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:33268 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sclEM-00GlCe-80; Sat, 10 Aug 2024 06:29:59 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Brian Mak <makb@juniper.net>
Cc: Kees Cook <kees@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Oleg
 Nesterov <oleg@redhat.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
Date: Sat, 10 Aug 2024 07:28:44 -0500
In-Reply-To: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net> (Brian Mak's
	message of "Tue, 6 Aug 2024 18:16:02 +0000")
Message-ID: <87ttfs1s03.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sclEM-00GlCe-80;;;mid=<87ttfs1s03.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/rrQC2FQR/9/Kgl9SrfSvI8sFe1P4ilOg=
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
X-Spam-Timing: total 509 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 3.9 (0.8%), b_tie_ro: 2.6 (0.5%), parse: 1.02
	(0.2%), extract_message_metadata: 15 (3.0%), get_uri_detail_list: 2.3
	(0.5%), tests_pri_-2000: 13 (2.6%), tests_pri_-1000: 2.0 (0.4%),
	tests_pri_-950: 1.04 (0.2%), tests_pri_-900: 0.79 (0.2%),
	tests_pri_-90: 158 (31.1%), check_bayes: 144 (28.2%), b_tokenize: 7
	(1.4%), b_tok_get_all: 43 (8.5%), b_comp_prob: 2.2 (0.4%),
	b_tok_touch_all: 88 (17.2%), b_finish: 0.73 (0.1%), tests_pri_0: 303
	(59.5%), check_dkim_signature: 0.42 (0.1%), check_dkim_adsp: 6 (1.2%),
	poll_dns_idle: 0.84 (0.2%), tests_pri_10: 1.72 (0.3%), tests_pri_500:
	6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Brian Mak <makb@juniper.net> writes:

> Large cores may be truncated in some scenarios, such as with daemons
> with stop timeouts that are not large enough or lack of disk space. This
> impacts debuggability with large core dumps since critical information
> necessary to form a usable backtrace, such as stacks and shared library
> information, are omitted.
>
> We attempted to figure out which VMAs are needed to create a useful
> backtrace, and it turned out to be a non-trivial problem. Instead, we
> try simply sorting the VMAs by size, which has the intended effect.
>
> By sorting VMAs by dump size and dumping in that order, we have a
> simple, yet effective heuristic.

To make finding the history easier I would include:
v1: https://lkml.kernel.org/r/CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net
v2: https://lkml.kernel.org/r/C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

As Kees has already picked this up this is quite possibly silly.
But *shrug* that was when I was out.


> Signed-off-by: Brian Mak <makb@juniper.net>
> ---
>
> Hi all,
>
> Still need to run rr tests on this, per Kees Cook's suggestion, will
> update back once done. GDB and readelf show that this patch works
> without issue though.
>
> Thanks,
> Brian Mak
>
> v3: Edited commit message to better convey alternative solution as
>     non-trivial
>
>     Moved sorting logic to fs/coredump.c to make it in place
>
>     Above edits suggested by Eric Biederman <ebiederm@xmission.com>
>
> v2: Edited commit message to include more reasoning for sorting VMAs
>     
>     Removed conditional VMA sorting with debugfs knob
>     
>     Above edits suggested by Eric Biederman <ebiederm@xmission.com>
>
>  fs/coredump.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 7f12ff6ad1d3..33c5ac53ab31 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -18,6 +18,7 @@
>  #include <linux/personality.h>
>  #include <linux/binfmts.h>
>  #include <linux/coredump.h>
> +#include <linux/sort.h>
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task_stack.h>
> @@ -1191,6 +1192,18 @@ static void free_vma_snapshot(struct coredump_params *cprm)
>  	}
>  }
>  
> +static int cmp_vma_size(const void *vma_meta_lhs_ptr, const void *vma_meta_rhs_ptr)
> +{
> +	const struct core_vma_metadata *vma_meta_lhs = vma_meta_lhs_ptr;
> +	const struct core_vma_metadata *vma_meta_rhs = vma_meta_rhs_ptr;
> +
> +	if (vma_meta_lhs->dump_size < vma_meta_rhs->dump_size)
> +		return -1;
> +	if (vma_meta_lhs->dump_size > vma_meta_rhs->dump_size)
> +		return 1;
> +	return 0;
> +}
> +
>  /*
>   * Under the mmap_lock, take a snapshot of relevant information about the task's
>   * VMAs.
> @@ -1253,5 +1266,8 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
>  		cprm->vma_data_size += m->dump_size;
>  	}
>  
> +	sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
> +		cmp_vma_size, NULL);
> +
>  	return true;
>  }
>
> base-commit: eb5e56d1491297e0881c95824e2050b7c205f0d4

