Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14289214C1C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGELoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 07:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELox (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 07:44:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4064720723;
        Sun,  5 Jul 2020 11:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593949493;
        bh=A49BrhVeW4i0gMdACaS6R6Bgo64PtoM0qL8tcoWxIAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTW6kU/mEPS4lUzNYBF2hVwi/8EhViX1SAwXw4Z/RD0VF2iMd9YFDO1t4U2t0Y1es
         zUgKZxfagndBWCUbksdrlEon3iyEB4CbnvEMVeycpjNnmxl6LqKPMWAT7PK9hjrm4E
         1o2+vwokkrc5EynLt8FLENYxMsnAD7cm5x5kGOZE=
Date:   Sun, 5 Jul 2020 13:44:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705114454.GB1224775@kroah.com>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
 <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <20200705031208.GS25523@casper.infradead.org>
 <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
 <20200705032732.GT25523@casper.infradead.org>
 <20200705080714.76m64pwwpvlzji2v@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705080714.76m64pwwpvlzji2v@shells.gnugeneration.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 01:07:14AM -0700, Vito Caputo wrote:
> On Sun, Jul 05, 2020 at 04:27:32AM +0100, Matthew Wilcox wrote:
> > On Sun, Jul 05, 2020 at 05:18:58AM +0200, Jan Ziak wrote:
> > > On Sun, Jul 5, 2020 at 5:12 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > You should probably take a look at io_uring.  That has the level of
> > > > complexity of this proposal and supports open/read/close along with many
> > > > other opcodes.
> > > 
> > > Then glibc can implement readfile using io_uring and there is no need
> > > for a new single-file readfile syscall.
> > 
> > It could, sure.  But there's also a value in having a simple interface
> > to accomplish a simple task.  Your proposed API added a very complex
> > interface to satisfy needs that clearly aren't part of the problem space
> > that Greg is looking to address.
> 
> I disagree re: "aren't part of the problem space".
> 
> Reading small files from procfs was specifically called out in the
> rationale for the syscall.
> 
> In my experience you're rarely monitoring a single proc file in any
> situation where you care about the syscall overhead.  You're
> monitoring many of them, and any serious effort to do this efficiently
> in a repeatedly sampled situation has cached the open fds and already
> uses pread() to simply restart from 0 on every sample and not
> repeatedly pay for the name lookup.

That's your use case, but many other use cases are just "read a bunch of
sysfs files in one shot".  Examples of that are tools that monitor
uevents and lots of hardware-information gathering tools.

Also not all tools sem to be as smart as you think they are, look at
util-linux for loads of the "open/read/close" lots of files pattern.  I
had a half-baked patch to convert it to use readfile which I need to
polish off and post with the next series to show how this can be used to
both make userspace simpler as well as use less cpu time.

> Basically anything optimally using the existing interfaces for
> sampling proc files needs a way to read multiple open file descriptors
> in a single syscall to move the needle.

Is psutils using this type of interface, or do they constantly open
different files?

What about fun tools like bashtop:
	https://github.com/aristocratos/bashtop.git
which thankfully now relies on python's psutil package to parse proc in
semi-sane ways, but that package does loads of constant open/read/close
of proc files all the time from what I can tell.

And lots of people rely on python's psutil, right?

> This syscall doesn't provide that.  It doesn't really give any
> advantage over what we can achieve already.  It seems basically
> pointless to me, from a monitoring proc files perspective.

What "good" monitoring programs do you suggest follow the pattern you
recommend?

thanks,

greg k-h
