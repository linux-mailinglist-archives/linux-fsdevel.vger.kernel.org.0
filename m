Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D83BEBE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhGGQV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 12:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhGGQV1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:21:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5961B61C99;
        Wed,  7 Jul 2021 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625674727;
        bh=90iNmx/AkPH8fdgdLjCtbmY3qOUXv1LAHfCzVLGhZRU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AKCWt0W2GTf+Ns7AXc/Chy7zn9Z5bqoOWWcYa4EJC6UfCX3WSubUPrMm7mdi+vndQ
         5sDaYU5EhlwrH7qSCzJ+a9ToFmtAIb+Z6Hf1ieuPErH0lAhT+iWoqH7hyaxMfAxcTS
         ZK2mTTnrf1uxhlIsOBZ2uPtvUyKv42pTZLD4SqYo3FNNNvCAqziV4QTptVhCM9MvU1
         3VnaonJnPcoIUft8bM+FU6xLlpGIqgBnc8Af7iMkptnrUKMNmglfRZR/gJ+YCeoz18
         EFFSJTwBT+s66KkhpBjqQH5L/khTMLoVlxV4c8w5AtR7WpQeMMaPWajdrmhH+QpR5a
         NPpIiooXjm1cw==
Message-ID: <03748f0bf038826f879b4429441d5a0fa8331969.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] fcntl: fix potential deadlocks for
 &fown_struct.lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Date:   Wed, 07 Jul 2021 12:18:45 -0400
In-Reply-To: <YOXMcJAZPms7Gp8a@kroah.com>
References: <20210707023548.15872-2-desmondcheongzx@gmail.com>
         <YOVENb3X/m/pNrYt@kroah.com>
         <14633c3be87286d811263892375f2dfa9a8ed40a.camel@kernel.org>
         <YOWHKk6Nq8bazYjB@kroah.com>
         <4dda1cad6348fced5fcfcb6140186795ed07d948.camel@kernel.org>
         <20210707135129.GA9446@fieldses.org> <YOXDBZR2RSfiM+A3@kroah.com>
         <20210707151936.GB9911@fieldses.org> <YOXIuhma++oMbbiH@kroah.com>
         <20210707153417.GA10570@fieldses.org> <YOXMcJAZPms7Gp8a@kroah.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 17:46 +0200, Greg KH wrote:
> On Wed, Jul 07, 2021 at 11:34:17AM -0400, J. Bruce Fields wrote:
> > On Wed, Jul 07, 2021 at 05:31:06PM +0200, Greg KH wrote:
> > > On Wed, Jul 07, 2021 at 11:19:36AM -0400, J. Bruce Fields wrote:
> > > > On Wed, Jul 07, 2021 at 05:06:45PM +0200, Greg KH wrote:
> > > > > On Wed, Jul 07, 2021 at 09:51:29AM -0400, J. Bruce Fields wrote:
> > > > > > On Wed, Jul 07, 2021 at 07:40:47AM -0400, Jeff Layton wrote:
> > > > > > > On Wed, 2021-07-07 at 12:51 +0200, Greg KH wrote:
> > > > > > > > On Wed, Jul 07, 2021 at 06:44:42AM -0400, Jeff Layton wrote:
> > > > > > > > > On Wed, 2021-07-07 at 08:05 +0200, Greg KH wrote:
> > > > > > > > > > On Wed, Jul 07, 2021 at 10:35:47AM +0800, Desmond Cheong Zhi Xi wrote:
> > > > > > > > > > > +	WARN_ON_ONCE(irqs_disabled());
> > > > > > > > > > 
> > > > > > > > > > If this triggers, you just rebooted the box :(
> > > > > > > > > > 
> > > > > > > > > > Please never do this, either properly handle the problem and return an
> > > > > > > > > > error, or do not check for this.  It is not any type of "fix" at all,
> > > > > > > > > > and at most, a debugging aid while you work on the root problem.
> > > > > > > > > > 
> > > > > > > > > > thanks,
> > > > > > > > > > 
> > > > > > > > > > greg k-h
> > > > > > > > > 
> > > > > > > > > Wait, what? Why would testing for irqs being disabled and throwing a
> > > > > > > > > WARN_ON in that case crash the box?
> > > > > > > > 
> > > > > > > > If panic-on-warn is enabled, which is a common setting for systems these
> > > > > > > > days.
> > > > > > > 
> > > > > > > Ok, that makes some sense.
> > > > > > 
> > > > > > Wait, I don't get it.
> > > > > > 
> > > > > > How are we supposed to decide when to use WARN, when to use BUG, and
> > > > > > when to panic?  Do we really want to treat them all as equivalent?  And
> > > > > > who exactly is turning on panic-on-warn?
> > > > > 
> > > > > You never use WARN or BUG, unless the system is so messed up that you
> > > > > can not possibly recover from the issue.
> > > > 
> > > > I've heard similar advice for BUG before, but this is the first I've
> > > > heard it for WARN.  Do we have any guidelines for how to choose between
> > > > WARN and BUG?
> > > 
> > > Never use either :)
> > 
> > I can't tell if you're kidding.
> 
> I am not.
> 
> > Is there some plan to remove them?
> 
> Over time, yes.  And any WARN that userspace can ever hit should be
> removed today.
> 
> > There are definitely cases where I've been able to resolve a problem
> > more quickly because I got a backtrace from a WARN.
> 
> If you want a backtrace, ask for that, recover from the error, and move
> on.  Do not allow userspace to reboot a machine for no good reason as
> again, panic-on-warn is a common setting that people use now.
> 
> This is what all of the syzbot work has been doing, it triggers things
> that cause WARN() to be hit and so we have to fix them.
> 

This seems really draconian. Clearly we do want to fix things that show
a WARN (otherwise we wouldn't bother warning about it), but I don't
think that's a reason to completely avoid them. My understanding has
always been:

BUG: for when you reach some condition where the kernel (probably) can't
carry on

WARN: for when you reach some condition that is problematic but where
the machine can probably soldier on. 

Over the last several years, I've changed a lot of BUGs into WARNs to
avoid crashing the box unnecessarily. If someone is setting
panic_on_warn, then aren't they just getting what they asked for?

While I don't feel that strongly about this particular WARN in this
patch, it seems like a reasonable thing to do. If someone calls these
functions with IRQs disabled, then they might end up with some subtle
problems that could be hard to detect otherwise.
-- 
Jeff Layton <jlayton@kernel.org>

