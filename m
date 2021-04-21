Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA72367326
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 21:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbhDUTFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 15:05:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33326 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbhDUTFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:05:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lZI9x-00D0JN-R2; Wed, 21 Apr 2021 13:05:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lZI9v-00Arwg-E2; Wed, 21 Apr 2021 13:05:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.tang@intel.com>,
        Don Zickus <dzickus@redhat.com>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210421093453.6904-1-david@redhat.com>
Date:   Wed, 21 Apr 2021 14:03:49 -0500
In-Reply-To: <20210421093453.6904-1-david@redhat.com> (David Hildenbrand's
        message of "Wed, 21 Apr 2021 11:34:50 +0200")
Message-ID: <m1eef3qx2i.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lZI9v-00Arwg-E2;;;mid=<m1eef3qx2i.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oGtpTLgZT5xyLx7QaJ0kLkcjgE1O5huM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;David Hildenbrand <david@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1863 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (0.6%), b_tie_ro: 9 (0.5%), parse: 0.99 (0.1%),
         extract_message_metadata: 52 (2.8%), get_uri_detail_list: 3.7 (0.2%),
        tests_pri_-1000: 37 (2.0%), tests_pri_-950: 1.31 (0.1%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 449 (24.1%), check_bayes:
        386 (20.7%), b_tokenize: 13 (0.7%), b_tok_get_all: 11 (0.6%),
        b_comp_prob: 3.1 (0.2%), b_tok_touch_all: 356 (19.1%), b_finish: 0.93
        (0.1%), tests_pri_0: 269 (14.4%), check_dkim_signature: 0.63 (0.0%),
        check_dkim_adsp: 2.2 (0.1%), poll_dns_idle: 1019 (54.7%),
        tests_pri_10: 2.0 (0.1%), tests_pri_500: 1036 (55.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v1 0/3] perf/binfmt/mm: remove in-tree usage of MAP_EXECUTABLE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> Stumbling over the history of MAP_EXECUTABLE, I noticed that we still
> have some in-tree users that we can get rid of.
>
> A good fit for the whole series could be Andrew's tree.

In general this looks like a good cleanup.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

As far as I can see we can go after MAP_DENYWRITE the same way.
Today deny_write_access in open_exec is what causes -ETXTBSY
when attempting to write to file that is current executing.

Do you have any plans to look at that?

Eric

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Don Zickus <dzickus@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
>
> David Hildenbrand (3):
>   perf: MAP_EXECUTABLE does not indicate VM_MAYEXEC
>   binfmt: remove in-tree usage of MAP_EXECUTABLE
>   mm: ignore MAP_EXECUTABLE in ksys_mmap_pgoff()
>
>  arch/x86/ia32/ia32_aout.c |  4 ++--
>  fs/binfmt_aout.c          |  4 ++--
>  fs/binfmt_elf.c           |  2 +-
>  fs/binfmt_elf_fdpic.c     | 11 ++---------
>  fs/binfmt_flat.c          |  2 +-
>  include/linux/mman.h      |  2 ++
>  kernel/events/core.c      |  2 --
>  mm/mmap.c                 |  2 +-
>  mm/nommu.c                |  2 +-
>  9 files changed, 12 insertions(+), 19 deletions(-)
