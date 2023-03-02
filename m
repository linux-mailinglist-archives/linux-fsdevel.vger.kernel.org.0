Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87F96A886A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCBSSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBSSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:18:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778A232E71;
        Thu,  2 Mar 2023 10:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=6ZbSRd9H+lkeIXySMnl2e4FQvXpmm6EbThjgjlUfRiI=; b=ahduqHW0pupAY1Wjd/TmIMCrZp
        NIhUdp2M3dv57MpPgxwBPUMLuTdt7QqIcGb3ZicKWown2FMdADu/1RYisPLsnaiP86H+mSKzGGBvY
        m6xd49eB2mkf+ztYFC8Y/ULhU47ow6KCpuRIScCNr57l9Sx++FvupSqJvc35fY3K1+eQfKnHtyQtS
        W3ObH95ygIbbuXTUbJ+F2F1Lu/NK1qhaAbUfRLsQS9P/UGVfRBJ0G93tZCqe77eiqpyxn71bvMxd0
        Y5cRrW5njNX3GQU+auMmFtEDkAl4XsD+8BxnWOCcA7yw8VByMW5NEv/PGgKamXZtRONF+nohoexpC
        Bq7SY5aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXnVg-00DN3N-38;
        Thu, 02 Mar 2023 18:18:33 +0000
Date:   Thu, 2 Mar 2023 18:18:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZADoeOiJs6BRLUSd@ZenIV>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 07:14:24PM +0100, Mateusz Guzik wrote:
> On 3/2/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Thu, Mar 2, 2023 at 12:30 AM Christian Brauner <brauner@kernel.org>
> > wrote:
> >>
> >> Fwiw, as long as you, Al, and others are fine with it and I'm aware of
> >> it I'm happy to pick up more stuff like this. I've done it before and
> >> have worked in this area so I'm happy to help with some of the load.
> >
> > Yeah, that would work. We've actually had discussions of vfs
> > maintenance in general.
> >
> > In this case it really wasn't an issue, with this being just two
> > fairly straightforward patches for code that I was familiar with.
> >
> 
> Well on that note I intend to write a patch which would add a flag to
> the dentry cache.
> 
> There is this thing named CONFIG_INIT_ON_ALLOC_DEFAULT_ON which is
> enabled at least on debian, ubuntu and arch. It results in mandatory
> memset on the obj before it gets returned from kmalloc, for hardening
> purposes.
> 
> Now the problem is that dentry cache allocates bufs 4096 bytes in
> size, so this is an equivalent of a clear_page call and it happens
> *every time* there is a path lookup.

Huh?  Quite a few path lookups don't end up allocating any dentries;
what exactly are you talking about?

> Given how dentry cache is used, I'm confident there is 0 hardening
> benefit for it.
> 
> So the plan would be to add a flag on cache creation to exempt it from
> the mandatory memset treatment and use it with dentry.
> 
> I don't have numbers handy but as you can imagine it gave me a nice bump :)
> 
> Whatever you think about the idea aside, the q is: can something like
> the above go in without Al approving it?

That one I would really like to take a look at.
