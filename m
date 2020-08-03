Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD81623A960
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgHCPbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:31:47 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47446 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCPbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:31:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2cR0-00877r-MU; Mon, 03 Aug 2020 09:31:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2cQz-00048L-7z; Mon, 03 Aug 2020 09:31:30 -0600
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
        <87y2n03brx.fsf@x220.int.ebiederm.org>
        <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
Date:   Mon, 03 Aug 2020 10:28:14 -0500
In-Reply-To: <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com> (Steven
        Sistare's message of "Fri, 31 Jul 2020 10:57:44 -0400")
Message-ID: <877dufvje9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k2cQz-00048L-7z;;;mid=<877dufvje9.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/TnIbHCfTWSuRtxPvgCFD72EF12cavVvA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4767]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Steven Sistare <steven.sistare@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 773 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (1.6%), b_tie_ro: 11 (1.4%), parse: 1.88
        (0.2%), extract_message_metadata: 19 (2.5%), get_uri_detail_list: 3.3
        (0.4%), tests_pri_-1000: 16 (2.0%), tests_pri_-950: 1.42 (0.2%),
        tests_pri_-900: 1.23 (0.2%), tests_pri_-90: 170 (22.0%), check_bayes:
        168 (21.7%), b_tokenize: 17 (2.2%), b_tok_get_all: 12 (1.6%),
        b_comp_prob: 6 (0.8%), b_tok_touch_all: 128 (16.6%), b_finish: 1.14
        (0.1%), tests_pri_0: 532 (68.9%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 11 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steven Sistare <steven.sistare@oracle.com> writes:

> On 7/30/2020 5:58 PM, ebiederm@xmission.com wrote:
>> Here is another suggestion.
>> 
>> Have a very simple program that does:
>> 
>> 	for (;;) {
>> 		handle = dlopen("/my/real/program");
>> 		real_main = dlsym(handle, "main");
>> 		real_main(argc, argv, envp);
>> 		dlclose(handle);
>> 	}
>> 
>> With whatever obvious adjustments are needed to fit your usecase.
>> 
>> That should give the same level of functionality, be portable to all
>> unices, and not require you to duplicate code.  It belive it limits you
>> to not upgrading libc, or librt but that is a comparatively small
>> limitation.
>> 
>> 
>> Given that in general the interesting work is done in userspace and that
>> userspace has provided an interface for reusing that work already.
>> I don't see the justification for adding anything to exec at this point. 
>
> Thanks for the suggestion.  That is clever, and would make a fun project,
> but I would not trust it for production.  These few lines are just
> the first of many that it would take to reset the environment to the
> well-defined post-exec initial conditions that all executables expect,
> and incrementally tearing down state will be prone to bugs.

Agreed.

> Getting a clean slate from a kernel exec is a much more reliable
> design.

Except you are explicitly throwing that out the window, by preserving
VMAs.  You very much need to have a clean bug free shutdown to pass VMAs
reliably.

> The use case is creating long-lived apps that never go down, and the
> simplest implementation will have the fewest bugs and is the best.
> MADV_DOEXEC is simple, and does not even require a new system call,
> and the kernel already knows how to exec without bugs.

*ROFL*  I wish the kernel knew how to exec things without bugs.
The bugs are hard to hit but the ones I am aware of are not straight
forward to fix.

MADV_DOEXEC is not conceptually simple.  It completely violates the
guarantees that exec is known to make about the contents of the memory
of the new process.  This makes it very difficult to reason about.  Nor
will MADV_DOEXEC be tested very much as it has only one or two users.
Which means in the fullness of time it is likely someone will change
something that will break the implementation subtlely and the bug report
probably won't come in for 3 years, or maybe a decade.  At which point
it won't be clear if the bug even can be fixed as something else might
rely on it.

What is wrong with live migration between one qemu process and another
qemu process on the same machine not work for this use case?

Just reusing live migration would seem to be the simplest path of all,
as the code is already implemented.  Further if something goes wrong
with the live migration you can fallback to the existing process.  With
exec there is no fallback if the new version does not properly support
the handoff protocol of the old version.

Eric
