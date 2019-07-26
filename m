Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D003760C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 10:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfGZIb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 04:31:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:43146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfGZIb4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:31:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C45C9B606;
        Fri, 26 Jul 2019 08:31:52 +0000 (UTC)
Date:   Fri, 26 Jul 2019 10:31:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Kevin Hilman <khilman@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Vetter <daniel@ffwll.ch>,
        Amir Goldstein <amir73il@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@google.com>,
        David Rientjes <rientjes@google.com>,
        kunit-dev@googlegroups.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, wfg@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Knut Omang <knut.omang@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        John Ogness <john.ogness@linutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream
 like logger
Message-ID: <20190726083148.d4gf57w2nt5k7t6n@pathway.suse.cz>
References: <20190716175021.9CA412173C@mail.kernel.org>
 <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org>
 <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
 <20190719000834.GA3228@google.com>
 <20190722200347.261D3218C9@mail.kernel.org>
 <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
 <20190722235411.06C1320840@mail.kernel.org>
 <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz>
 <CAFd5g47v3Mr4GEGOjqyYy9Jwwm+ow7ypbu9j88rxEN06QCzdxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47v3Mr4GEGOjqyYy9Jwwm+ow7ypbu9j88rxEN06QCzdxQ@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2019-07-25 13:21:12, Brendan Higgins wrote:
> On Wed, Jul 24, 2019 at 12:31 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Mon 2019-07-22 16:54:10, Stephen Boyd wrote:
> > > Quoting Brendan Higgins (2019-07-22 15:30:49)
> > > > On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > >
> > > > >
> > > > > What's the calling context of the assertions and expectations? I still
> > > > > don't like the fact that string stream needs to allocate buffers and
> > > > > throw them into a list somewhere because the calling context matters
> > > > > there.
> > > >
> > > > The calling context is the same as before, which is anywhere.
> > >
> > > Ok. That's concerning then.
> > >
> > > >
> > > > > I'd prefer we just wrote directly to the console/log via printk
> > > > > instead. That way things are simple because we use the existing
> > > > > buffering path of printk, but maybe there's some benefit to the string
> > > > > stream that I don't see? Right now it looks like it builds a string and
> > > > > then dumps it to printk so I'm sort of lost what the benefit is over
> > > > > just writing directly with printk.
> > > >
> > > > It's just buffering it so the whole string gets printed uninterrupted.
> > > > If we were to print out piecemeal to printk, couldn't we have another
> > > > call to printk come in causing it to garble the KUnit message we are
> > > > in the middle of printing?
> > >
> > > Yes, printing piecemeal by calling printk many times could lead to
> > > interleaving of messages if something else comes in such as an interrupt
> > > printing something. Printk has some support to hold "records" but I'm
> > > not sure how that would work here because KERN_CONT talks about only
> > > being used early on in boot code. I haven't looked at printk in detail
> > > though so maybe I'm all wrong and KERN_CONT just works?
> >
> > KERN_CONT does not guarantee that the message will get printed
> > together. The pieces get interleaved with messages printed in
> > parallel.
> >
> > Note that KERN_CONT was originally really meant to be used only during
> > boot. It was later used more widely and ended in the best effort category.
> >
> > There were several attempts to make it more reliable. But it was
> > always either too complicated or error prone or both.
> >
> > You need to use your own buffering if you rely want perfect output.
> > The question is if it is really worth the complexity. Also note that
> > any buffering reduces the chance that the messages will reach
> > the console.
> 
> Seems like that settles it then. Thanks!
> 
> > BTW: There is a work in progress on a lockless printk ring buffer.
> > It will make printk() more secure regarding deadlocks. But it might
> > make transparent handling of continuous lines even more tricky.
> >
> > I guess that local buffering, before calling printk(), will be
> > even more important then. Well, it might really force us to create
> > an API for it.
> 
> Cool! Can you CC me on that discussion?

Adding John Oggness into CC.

John, please CC Brendan Higgins on the patchsets eventually switching
printk() into the lockless buffer. The test framework is going to
do its own buffering to keep the related messages together.

The lockless ringbuffer might make handling of related (partial)
lines worse or better. It might justify KUnit's extra buffering
or it might allow to get rid of it.

> > Note that stroring the messages into the printk log is basically safe in any
> > context. It uses temporary per-CPU buffers for recursive messages and
> > in NMI. The only problem is panic() when some CPU gets stuck with the
> > lock taken. This will get solved by the lockless ringbuffer. Also
> > the temporary buffers will not be necessary any longer.
> 
> Sure, I think Stephen's concern is all the supporting code that is
> involved. Not printk specifically. It just means a lot more of KUnit
> has to be IRQ safe.

I see.

BTW: I wonder if KUnit could reuse the existing seq_buf implementation
for buffering messages.

I am sorry if it has already been proposed and rejected for some
reason. I might have missed it. Feel free to just point me to
same older mail.

> > Much bigger problems are with consoles. There are many of them. It
> > means a lot of code and more locks involved, including scheduler
> > locks. Note that console lock is a semaphore.
> 
> That shouldn't affect us though, right? As long as we continue to use
> the printk interface?

I guess that it should not affect KUnit.

The only problem might be if the testing framework calls printk()
inside scheduler or console code. And only when the tested code
uses the same locks that will be used by the called printk().

To be honest I do not fully understand KUnit design. I am not
completely sure how the tested code is isolated from the running
system. Namely, I do not know if the tested code shares
the same locks with the system running the test.

Best Regards,
Petr
