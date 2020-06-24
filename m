Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EC7207B8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406116AbgFXSb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 14:31:58 -0400
Received: from verein.lst.de ([213.95.11.211]:45566 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405832AbgFXSb6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:31:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4DA0E68B05; Wed, 24 Jun 2020 20:31:55 +0200 (CEST)
Date:   Wed, 24 Jun 2020 20:31:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200624183154.GA26685@lst.de>
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com> <20200624181437.GA26277@lst.de> <CAHk-=wgC4a9rKrKLTHbH5cA5dyaqqy4Hnsr+re144AiJuNwv9Q@mail.gmail.com> <20200624182437.GB26405@lst.de> <20200624182944.GT21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624182944.GT21350@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:29:44PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 24, 2020 at 08:24:37PM +0200, Christoph Hellwig wrote:
> > On Wed, Jun 24, 2020 at 11:20:26AM -0700, Linus Torvalds wrote:
> > > On Wed, Jun 24, 2020 at 11:14 AM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > So we'd need new user copy functions for just those cases
> > > 
> > > No. We'd open-code them. They'd look at "oh, I'm supposed to use a
> > > kernel pointer" and just use those.
> > > 
> > > IOW, basically IN THE CODE that cares (and the whole argument is that
> > > this code is one or two special cases) you do
> > > 
> > >     /* This has not been converted to the new world order */
> > >     if (get_fs() == KERNEL_DS) memcpy(..) else copy_from_user();
> > > 
> > > You're overdesigning things. You're making them more complex than they
> > > need to be.
> > 
> > I wish it was so simple.  I really don't like overdesigns, trust me.
> > 
> > But please take a look at setsockopt and all the different instances
> > (count 90 .setsockopt wireups, and they then branch out into
> > various subroutines as well).  I really don't want to open code that
> > there, but we could do helper specific to setsockopt.
> 
> Can we do a setsockopt_iter() which replaces optval/optlen with an iov_iter?

We could.  The only downside is int-sized sockopts are common, and used
in the fast path of networking applications (e.g. cork,uncork) and this
might introduce enough overhead to be noticable.
