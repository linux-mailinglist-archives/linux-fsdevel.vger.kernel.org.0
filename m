Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C292C589567
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 02:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiHDAmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 20:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiHDAme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:42:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2333E5A2F5;
        Wed,  3 Aug 2022 17:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nAB+N4hwyXZEv+zCt+3ePS/cJYUGpbG3i/MA3cVn1QA=; b=ENEeIvyBL5BLCD1ba/tFivvEJw
        Vy/QWIPpDui+2ZX5pbndYY2nd4hYbYlwykX/Q78DuPcOEhzI0ua2uAAkjkobDquI0M2Xho2OBUYLv
        0tRz/GD1U0wsyY/fJJsKaOS4lx4EgCSqFtXQo56nCLvBbPPPOA0/QNMzl4FCejNNB4jhlyYbhkW1z
        k0N4ODNRV51ze4h6SGvWE/CQKcsJzwng5R+1pQ/Gb5+XX9qRIW1fExKoKR+vN8VV2glLXFGuHdnVI
        eCMVu0FUQBCq2pMxu9au7U6hqqaoXxvvPtde4LwjEd9o7kMmdEaDa5i6OE63zRf72hWRyiXLeSvRL
        OJPa0M+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oJOwT-009n3G-L6; Thu, 04 Aug 2022 00:42:25 +0000
Date:   Thu, 4 Aug 2022 01:42:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git pile 3 - dcache
Message-ID: <YusV8cr382PeBNLM@casper.infradead.org>
References: <YurA3aSb4GRr4wlW@ZenIV>
 <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org>
 <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home>
 <YusDmF39ykDmfSkF@casper.infradead.org>
 <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 03, 2022 at 04:42:43PM -0700, Linus Torvalds wrote:
> On Wed, Aug 3, 2022 at 4:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Aug 03, 2022 at 06:59:36PM -0400, Steven Rostedt wrote:
> > >
> > >       preempt_disable_inlock() ?
> >
> > preempt_disable_locked()?
> 
> Heh. Shed painting in full glory.
> 
> Let's try just "preempt_enable_under_spinlock()" and see.
> 
> It's a bit long, but it's still shorter than the existing usage pattern.
> 
> And we don't have "inlock" anywhere else, and while "locked" is a real
> pattern we have, it tends to be about other things (ie "I hold the
> lock that you need, so don't take it").
> 
> And this is _explicitly_ only about spinning locks, because sleeping
> locks don't do the preemption disable even without RT.
> 
> So let's make it verbose and clear and unambiguous. It's not like I
> expect to see a _lot_ of those. Knock wood.

Should we have it take a spinlock_t pointer?  We could have lockdep
check it is actually held.
