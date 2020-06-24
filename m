Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA10207B76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406082AbgFXSYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 14:24:41 -0400
Received: from verein.lst.de ([213.95.11.211]:45536 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405892AbgFXSYl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:24:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E110B68B02; Wed, 24 Jun 2020 20:24:37 +0200 (CEST)
Date:   Wed, 24 Jun 2020 20:24:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200624182437.GB26405@lst.de>
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com> <20200624181437.GA26277@lst.de> <CAHk-=wgC4a9rKrKLTHbH5cA5dyaqqy4Hnsr+re144AiJuNwv9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgC4a9rKrKLTHbH5cA5dyaqqy4Hnsr+re144AiJuNwv9Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:20:26AM -0700, Linus Torvalds wrote:
> On Wed, Jun 24, 2020 at 11:14 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > So we'd need new user copy functions for just those cases
> 
> No. We'd open-code them. They'd look at "oh, I'm supposed to use a
> kernel pointer" and just use those.
> 
> IOW, basically IN THE CODE that cares (and the whole argument is that
> this code is one or two special cases) you do
> 
>     /* This has not been converted to the new world order */
>     if (get_fs() == KERNEL_DS) memcpy(..) else copy_from_user();
> 
> You're overdesigning things. You're making them more complex than they
> need to be.

I wish it was so simple.  I really don't like overdesigns, trust me.

But please take a look at setsockopt and all the different instances
(count 90 .setsockopt wireups, and they then branch out into
various subroutines as well).  I really don't want to open code that
there, but we could do helper specific to setsockopt.

Honestly my preference would be to say that no eBPF isn't actually
a user API and just rip out the crap added to it, but I fear that
is not an option.  Because in that case we'd basically be done.

> Basically, I do *NOT* want to pollute the VFS layer with new
> interfaces that shouldn't exist in the long run. I'd much rather make
> the eventual goal be to get rid of 'read/write' entirely in favour of
> the 'iter' things, but what I absolutely do *NOT* want to see is to
> make a _third_ interface for reading and writing. Quite the reverse.
> We should strive to make it a _single_ interface, not add a new one.

Completele agreement on this.  I actually hate the new fops, and only
added them reluctantly as I mis-interpreted what you said.
