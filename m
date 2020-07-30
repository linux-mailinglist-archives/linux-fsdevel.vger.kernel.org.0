Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD96233B12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 00:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgG3WCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 18:02:24 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41060 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgG3WCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:02:23 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1Gcs-004a9H-FX; Thu, 30 Jul 2020 16:02:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1Gcr-000601-6f; Thu, 30 Jul 2020 16:02:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
        <20200730152250.GG23808@casper.infradead.org>
        <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
        <20200730171251.GI23808@casper.infradead.org>
        <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
        <20200730174956.GK23808@casper.infradead.org>
        <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
Date:   Thu, 30 Jul 2020 16:58:58 -0500
In-Reply-To: <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com> (Steven
        Sistare's message of "Thu, 30 Jul 2020 14:27:21 -0400")
Message-ID: <87y2n03brx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k1Gcr-000601-6f;;;mid=<87y2n03brx.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX196C4Bc9XRPT8Fq7uQRPXVtTpJ1Q6VZOFs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4779]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Steven Sistare <steven.sistare@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 651 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (1.4%), b_tie_ro: 8 (1.2%), parse: 1.41 (0.2%),
        extract_message_metadata: 19 (2.9%), get_uri_detail_list: 4.0 (0.6%),
        tests_pri_-1000: 8 (1.3%), tests_pri_-950: 1.88 (0.3%),
        tests_pri_-900: 1.62 (0.2%), tests_pri_-90: 100 (15.4%), check_bayes:
        97 (14.9%), b_tokenize: 17 (2.6%), b_tok_get_all: 9 (1.5%),
        b_comp_prob: 5 (0.8%), b_tok_touch_all: 61 (9.4%), b_finish: 0.89
        (0.1%), tests_pri_0: 496 (76.1%), check_dkim_signature: 0.82 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 0.38 (0.1%), tests_pri_10:
        1.93 (0.3%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steven Sistare <steven.sistare@oracle.com> writes:

> On 7/30/2020 1:49 PM, Matthew Wilcox wrote:
>> On Thu, Jul 30, 2020 at 01:35:51PM -0400, Steven Sistare wrote:
>>> mshare + VA reservation is another possible solution.
>>>
>>> Or MADV_DOEXEC alone, which is ready now.  I hope we can get back to reviewing that.
>> 
>> We are.  This is the part of the review process where we explore other
>> solutions to the problem.
>> 
>>>>> Also, we need to support updating legacy processes that already created anon segments.
>>>>> We inject code that calls MADV_DOEXEC for such segments.
>>>>
>>>> Yes, I was assuming you'd inject code that called mshare().
>>>
>>> OK, mshare works on existing memory and builds a new vma.
>> 
>> Actually, reparents an existing VMA, and reuses the existing page tables.
>> 
>>>> Actually, since you're injecting code, why do you need the kernel to
>>>> be involved?  You can mmap the new executable and any libraries it depends
>>>> upon, set up a new stack and jump to the main() entry point, all without
>>>> calling exec().  I appreciate it'd be a fair amount of code, but it'd all
>>>> be in userspace and you can probably steal / reuse code from ld.so (I'm
>>>> not familiar with the details of how setting up an executable is done).
>>>
>>> Duplicating all the work that the kernel and loader do to exec a process would
>>> be error prone, require ongoing maintenance, and be redundant.  Better to define 
>>> a small kernel extension and leave exec to the kernel.
>> 
>> Either this is a one-off kind of thing, in which case it doesn't need
>> ongoing maintenance, or it's something with broad applicability, in
>> which case it can live as its own userspace project.  It could even
>> start off life as part of qemu and then fork into its own project.
>
> exec will be enhanced over time in the kernel.  A separate user space implementation
> would need to track that.
>
> Reimplementing exec in userland would be a big gross mess.  Not a good solution when
> we have simple and concise ways of solving the problem.

The interesting work is not done in exec.  The interesting work of
loading an executable is done in ld.so, and ld.so lives in userspace.

>> The idea of tagging an ELF executable to say "I can cope with having
>> chunks of my address space provided to me by my executor" is ... odd.
>
> I don't disagree.  But it is useful.  We already pass a block of data containing
> environment variables and arguments from one process to the next.  Preserving 
> additional segments is not a big leap from there.

But we randomize where that block lives.

It has been found to be very useful to have randomization by default and
you are arguing against that kind of randomization.



Here is another suggestion.

Have a very simple program that does:

	for (;;) {
		handle = dlopen("/my/real/program");
		real_main = dlsym(handle, "main");
		real_main(argc, argv, envp);
		dlclose(handle);
	}

With whatever obvious adjustments are needed to fit your usecase.

That should give the same level of functionality, be portable to all
unices, and not require you to duplicate code.  It belive it limits you
to not upgrading libc, or librt but that is a comparatively small
limitation.


Given that in general the interesting work is done in userspace and that
userspace has provided an interface for reusing that work already.
I don't see the justification for adding anything to exec at this point.


Eric
