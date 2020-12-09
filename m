Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787352D4EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 00:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbgLIX1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 18:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbgLIX1C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:27:02 -0500
Date:   Wed, 9 Dec 2020 15:26:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607556378;
        bh=1zRKaA9Luc+OpPKmuiCXmU1neqYl4nmvzLRli8ibigY=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r2+rKUck/0WL+VcbfLmdJZsW79gi8ruci+1FQooOkuTHCsMgK2ie1v2NmspFm6vD/
         eTIz2yLrnwQQEzGBMqOw/9tvlwVx1s6ElIDL6T+Hefu292rbXMzXVR2nf6ysOZg4bf
         T0/XmagzUWMqwF+Fwp57XcgIqggsLHmYnQWPXav/KwcprYjcPjFxf1H+JfHplk4TDI
         Px0Hp/yAzF4zJ17yM3oFmpKD16UwZpsu8Qq+yyiTGZuaE5BOqsF2NOiDAyWXjNJgfs
         vMAzRtzHexpX2nZUO5HI2PZW8YNXS4XK5dZ7nCvIreU2+qHenukJ+ONndAnHDGDZ+N
         H65iP8VDMqrcQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201209232618.GK2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201207232900.GD4115853@ZenIV.linux.org.uk>
 <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <20201209194938.GS7338@casper.infradead.org>
 <20201209225828.GR3579531@ZenIV.linux.org.uk>
 <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
 <20201209230755.GV7338@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209230755.GV7338@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:07:55PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 09, 2020 at 03:01:36PM -0800, Linus Torvalds wrote:
> > On Wed, Dec 9, 2020 at 2:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Wed, Dec 09, 2020 at 07:49:38PM +0000, Matthew Wilcox wrote:
> > > >
> > > > Assuming this is safe, you can use RCU_INIT_POINTER() here because you're
> > > > storing NULL, so you don't need the wmb() before storing the pointer.
> > >
> > > fs/file.c:pick_file() would make more interesting target for the same treatment...
> > 
> > Actually, don't.
> > 
> > rcu_assign_pointer() itself already does the optimization for the case
> > of a constant NULL pointer assignment.
> > 
> > So there's no need to manually change things to RCU_INIT_POINTER().
> 
> I missed that, and the documentation wasn't updated by
> 3a37f7275cda5ad25c1fe9be8f20c76c60d175fa.

Can't trust the author of that patch!  ;-)

> Paul, how about this?
> 
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -1668,8 +1668,10 @@ against mishaps and misuse:
>     this purpose.
>  #. It is not necessary to use rcu_assign_pointer() when creating
>     linked structures that are to be published via a single external
> -   pointer. The RCU_INIT_POINTER() macro is provided for this task
> -   and also for assigning ``NULL`` pointers at runtime.
> +   pointer. The RCU_INIT_POINTER() macro is provided for this task.
> +   It used to be more efficient to use RCU_INIT_POINTER() to store a
> +   ``NULL`` pointer, but rcu_assign_pointer() now optimises for a constant
> +   ``NULL`` pointer itself.
>  
>  This not a hard-and-fast list: RCU's diagnostic capabilities will
>  continue to be guided by the number and type of usage bugs found in

Looks good to me!  If you send a complete patch, I will be happy to pull
it in.

							Thanx, Paul
