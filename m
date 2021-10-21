Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C973436B60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 21:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhJUTeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 15:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUTeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:34:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B179C061764;
        Thu, 21 Oct 2021 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g9ZT/0FoZ5x3CiuBFCIM2YP2UyvqhoFmEIhEg8pmdwA=; b=t7VYyTyL+zzJmyk7lTrCVP0pez
        49bdDOM1ylEshNaga0LR0NiqVO7TwU3sEtDIn8iK2BsMimXC8z3ingoHZw9TbC3P9atfQUE3vD1JO
        OzKhqPsoPFgZobOqz2Vg9JVzeTuGQs69r8tDIMfdQnGVIIn6G8UvlEOB9NwDGC8W3OheCqjNmoBUE
        AxAMo2LXC1Rt2IKCqtdPdzPFBBqnpkS8tnYWUDmJLQRN/CjIFW33GamDdQd6x8Xt6vSc99scNHzTP
        HrYS7wfwBelOBZfNEn17LxVEmQhL1xJfsUcIkdLaUBWVb2tHQpIaA8GY7WAvyE9VN1Z/9v/Du5Rzm
        wgeZO64A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mddlp-00DUnf-A3; Thu, 21 Oct 2021 19:31:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82CFA986DD9; Thu, 21 Oct 2021 21:30:33 +0200 (CEST)
Date:   Thu, 21 Oct 2021 21:30:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>, jannh@google.com,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian.brauner@ubuntu.com,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Make sure wchan works when it exists
Message-ID: <20211021193033.GW174703@worktop.programming.kicks-ass.net>
References: <20211008235504.2957528-1-keescook@chromium.org>
 <202110211008.CC8B26A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110211008.CC8B26A@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 10:09:33AM -0700, Kees Cook wrote:

> > Hi Peter,
> > 
> > Can you add this to the wchan series, please? This should help wchan from
> > regressing in the future, and allow us to notice if the depth accidentally
> > changes, like Mark saw.
> > ---
> 
> I'd like to make sure we have a regression test for this. Will you add
> this to the wchan series please?

I have it there, but it's in the part that didn't make it in yet. I'm
currently in the progress of reworking that.

Do you want it it ahead of all that?
