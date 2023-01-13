Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17B669355
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 10:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbjAMJwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 04:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbjAMJwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:52:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C093AB0C;
        Fri, 13 Jan 2023 01:46:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 738F961129;
        Fri, 13 Jan 2023 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DEBC433D2;
        Fri, 13 Jan 2023 09:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673603191;
        bh=kDe7hS+qa0Bf7KyA3VgUqyS71vPuErxEYrU/YagG7mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jI9DnyYMV4DxUmCjBcxXADH2AifhseMB7Vnetety5OQkISbdvZJ0AtIvvkI7iE7F+
         R6YO+tnbkzWAlWr2e5EevipFGVhCJdar6D+9j5wGcke8xUFHMlcwnflEWKTL4vYyyz
         S2DVuAdUoeqF17dzj4o46ZlRZt9s1d7RBgladKzDfuxphvZsW03ojfdOx90ntxR2/H
         NGR7oWcy6USxj4dso4H0kDqHBNsVV2gGNo3vQqm/d4yAVl4N5HFRQMEQf46F9vR5Yj
         bxkjYP2p5/xV9q5lUH5KX0Zv/KGJjYxL2Jel58w2PPdGdtOTmUcz7NjplbdfrRoQRo
         EX59UNORygCNg==
Date:   Fri, 13 Jan 2023 09:46:25 +0000
From:   Will Deacon <will@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jan Glauber <jan.glauber@gmail.com>, tony.luck@intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
Message-ID: <20230113094625.GA12235@willie-the-truck>
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
 <CAGudoHE0tzL8OAqvwpDR4Nn_g70a8qBdE_+-fmhXF-DEx_K6kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHE0tzL8OAqvwpDR4Nn_g70a8qBdE_+-fmhXF-DEx_K6kg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:12:50AM +0100, Mateusz Guzik wrote:
> On 1/13/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Side note on your access() changes - if it turns out that you can
> > remove all the cred games, we should possibly then revert my old
> > commit d7852fbd0f04 ("access: avoid the RCU grace period for the
> > temporary subjective credentials") which avoided the biggest issue
> > with the unnecessary cred switching.
> >
> > I *think* access() is the only user of that special 'non_rcu' thing,
> > but it is possible that the whole 'non_rcu' thing ends up mattering
> > for cases where the cred actually does change because euid != uid (ie
> > suid programs), so this would need a bit more effort to do performance
> > testing on.
> >
> 
> I don't think the games are avoidable. For one I found non-root
> processes with non-empty cap_effective even on my laptop, albeit I did
> not check how often something like this is doing access().
> 
> Discussion for another time.
> 
> > On Thu, Jan 12, 2023 at 5:36 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >> All that said, I think the thing to do here is to replace cpu_relax
> >> with a dedicated arch-dependent macro, akin to the following:
> >
> > I would actually prefer just removing it entirely and see if somebody
> > else hollers. You have the numbers to prove it hurts on real hardware,
> > and I don't think we have any numbers to the contrary.
> >
> > So I think it's better to trust the numbers and remove it as a
> > failure, than say "let's just remove it on x86-64 and leave everybody
> > else with the potentially broken code"
> >
> [snip]
> > Then other architectures can try to run their numbers, and only *if*
> > it then turns out that they have a reason to do something else should
> > we make this conditional and different on different architectures.
> >
> > Let's try to keep the code as common as possibly until we have hard
> > evidence for special cases, in other words.
> >
> 
> I did not want to make such a change without redoing the ThunderX2
> benchmark, or at least something else arm64-y. I may be able to bench it
> tomorrow on whatever arm-y stuff can be found on Amazon's EC2, assuming
> no arm64 people show up with their results.
> 
> Even then IMHO the safest route is to patch it out on x86-64 and give
> other people time to bench their archs as they get around to it, and
> ultimately whack the thing if it turns out nobody benefits from it.
> I would say beats backpedaling on the removal, but I'm not going to
> fight for it.
> 
> That said, does waiting for arm64 numbers and/or producing them for the
> removal commit message sound like a plan? If so, I'll post soon(tm).

Honestly, I wouldn't worry about us (arm64) here. I don't think any real
hardware implements the YIELD instruction (i.e. it behaves as a NOP in
practice). The only place I'm aware of where it _does_ something is in
QEMU, which was actually the motivation behind having it in cpu_relax() to
start with (see 1baa82f48030 ("arm64: Implement cpu_relax as yield")).

So, from the arm64 side of the fence, I'm perfectly happy just removing
the cpu_relax() calls from lockref.

Will
