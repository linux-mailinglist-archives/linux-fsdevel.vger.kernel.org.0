Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1633C669413
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 11:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjAMKZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 05:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbjAMKYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:24:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261D76EC5;
        Fri, 13 Jan 2023 02:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=43nvZBmwF6Qr7XsH1Yo0nO4bX86Vu4LJvgWe0kE/8zg=; b=oHlQZGuI+g1+745A8mnKSGv0Ip
        ArshDCSE9wETafPSA1owBRlBpYnq7N63PUC2bOIlNWCfzOcvg0baIddP9aWaqirXFy++TQxH6O55d
        6Ht7LAqrr9nfXLFRKCENIm2kB+U2INdOVCnod3dPJE1kgx7YCVu9BA1fpFAowI2d7nJU8WslTyIMn
        M5iGi3KUooTTakfSADotxIBNQ4JuVmDVdcohxLmYwXtuVupgup5E1Q0jfVADtwBZSwhOC6aHhMFij
        iVxfEAWRRf4m/fxKAAwH6mQegB+PpPs3VziQCzLcYwGhtn3/vplyg93tOLR7qP8wxF8frSpjDtM4c
        i9tMbXiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGHEA-006068-0t; Fri, 13 Jan 2023 10:24:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75F8E300094;
        Fri, 13 Jan 2023 11:23:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5006D20B16472; Fri, 13 Jan 2023 11:23:45 +0100 (CET)
Date:   Fri, 13 Jan 2023 11:23:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jan Glauber <jan.glauber@gmail.com>, tony.luck@intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
Message-ID: <Y8ExMQaevecjWjg5@hirez.programming.kicks-ass.net>
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 06:13:16PM -0600, Linus Torvalds wrote:
> On Thu, Jan 12, 2023 at 5:36 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > To my understanding on said architecture failed cmpxchg still grants you
> > exclusive access to the cacheline, making immediate retry preferable
> > when trying to inc/dec unless a certain value is found.
> 
> I actually suspect that is _always_ the case - this is not like a
> contended spinlock where we want to pause because we're waiting for
> the value to change and become unlocked, this cmpxchg loop is likely
> always better off just retrying with the new value.
> 
> That said, the "likely always better off" is purely about performance.
> 
> So I have this suspicion that the reason Tony added the cpu_relax()
> was simply not about performance, but about other issues, like
> fairness in SMT situations.
> 
> That said, evern from a fairness perspective the cpu_relax() sounds a
> bit odd and unlikely - we're literally yielding when we lost a race,
> so it hurts the _loser_, not the winner, and thus might make fairness
> worse too.

I've been writing cmpxchg loops that have strict termination conditions
without cpu_relax() in them for a while now.

For example, the x86 atomic_fetch_and() implementation looks like so:

static __always_inline int arch_atomic_fetch_and(int i, atomic_t *v)
{
	int val = arch_atomic_read(v);

	do { } while (!arch_atomic_try_cmpxchg(v, &val, val & i));

	return val;
}

And I did that because of the exact same argument you had above, it
needs to do the op anyway, waiting between failed attempts will only
increase the chance it will fail again.
