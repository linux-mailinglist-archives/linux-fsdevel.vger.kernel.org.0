Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8C64EBC0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 09:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbiC3HtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 03:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiC3Hs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5791A2E091;
        Wed, 30 Mar 2022 00:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7714617CC;
        Wed, 30 Mar 2022 07:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47502C340EC;
        Wed, 30 Mar 2022 07:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648626434;
        bh=MN+6wrLSHdhHDerUzQoJEbRy3mWG1/GnSrFz1G0/kSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6K7RbunaLLGzh9PlHjB1evsZeV2XxNSPnoA1GghTcF9drWhrmZ5D9e3ZBmKsBBWO
         PerWbLpQdfHqxwBXdEQIlgQBgdcSkNtEXUwZP5lk9XlOjkKH0PaFe4mI0sXZ8HW0tH
         Gc4mszYZ0+KFRaKfp1hQjX8cP6w8kurg7qbe05RGg1U5P7U6uBwiloGRL1pRYEcDIm
         II9o3nrzLR3xyJoROyLNoJNibubSa+ZKWDRY4N+y0gyPveuMCyBBIeGCn2kslgwPOg
         MldMNpOt6O73SGm4eLvElx7JXa1TtTDrlMBY9SI7LiTwV3q0Bzeg8YhgxiwtsNu8gs
         GDQ+nA5UdnlqA==
Date:   Wed, 30 Mar 2022 09:47:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
Message-ID: <20220330074709.oyeehornuictzumk@wittgenstein>
References: <20220326114009.1690-1-aissur0002@gmail.com>
 <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67>
 <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
 <CAHk-=wjsdDBmaD-sS5FSb3ngn820z3x=1Ny+36agbEXhDuGOsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjsdDBmaD-sS5FSb3ngn820z3x=1Ny+36agbEXhDuGOsg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 03:23:10PM -0700, Linus Torvalds wrote:
> On Tue, Mar 29, 2022 at 3:18 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ok, applied as commit 1c24a186398f ("fs: fd tables have to be
> > multiples of BITS_PER_LONG").
> 
> Oh, forgot to mention...
> 
> Christian - it strikes me that the whole "min(count, max_fds)" in
> sane_fdtable_size() is a bit stupid.
> 
> A _smarter_ approach might be to pass in 'max_fds' to
> count_open_files(), and simply not count past that value.
> 
> I didn't do that, because I wanted to keep the patch obvious. And it
> probably doesn't matter, but it's kind of silly to possibly count a
> lot of open files that we want to close anyway, when we already know
> the place we should stop counting.
> 
> Whatever. I just wanted to mention it in case you decide you want to
> clean that part up. This is mostly your code anyway.

I put it on my TODO and will look at this soon!

Thank you!
Christian
