Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714977290E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfGXHbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 03:31:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfGXHbb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:31:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12D7EAEF8;
        Wed, 24 Jul 2019 07:31:28 +0000 (UTC)
Date:   Wed, 24 Jul 2019 09:31:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Kevin Hilman <khilman@baylibre.com>,
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
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        wfg@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>,
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
        devicetree <devicetree@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream
 like logger
Message-ID: <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz>
References: <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
 <20190716175021.9CA412173C@mail.kernel.org>
 <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org>
 <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
 <20190719000834.GA3228@google.com>
 <20190722200347.261D3218C9@mail.kernel.org>
 <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
 <20190722235411.06C1320840@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722235411.06C1320840@mail.kernel.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 2019-07-22 16:54:10, Stephen Boyd wrote:
> Quoting Brendan Higgins (2019-07-22 15:30:49)
> > On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > >
> > > What's the calling context of the assertions and expectations? I still
> > > don't like the fact that string stream needs to allocate buffers and
> > > throw them into a list somewhere because the calling context matters
> > > there.
> > 
> > The calling context is the same as before, which is anywhere.
> 
> Ok. That's concerning then.
> 
> > 
> > > I'd prefer we just wrote directly to the console/log via printk
> > > instead. That way things are simple because we use the existing
> > > buffering path of printk, but maybe there's some benefit to the string
> > > stream that I don't see? Right now it looks like it builds a string and
> > > then dumps it to printk so I'm sort of lost what the benefit is over
> > > just writing directly with printk.
> > 
> > It's just buffering it so the whole string gets printed uninterrupted.
> > If we were to print out piecemeal to printk, couldn't we have another
> > call to printk come in causing it to garble the KUnit message we are
> > in the middle of printing?
> 
> Yes, printing piecemeal by calling printk many times could lead to
> interleaving of messages if something else comes in such as an interrupt
> printing something. Printk has some support to hold "records" but I'm
> not sure how that would work here because KERN_CONT talks about only
> being used early on in boot code. I haven't looked at printk in detail
> though so maybe I'm all wrong and KERN_CONT just works?

KERN_CONT does not guarantee that the message will get printed
together. The pieces get interleaved with messages printed in
parallel.

Note that KERN_CONT was originally really meant to be used only during
boot. It was later used more widely and ended in the best effort category.

There were several attempts to make it more reliable. But it was
always either too complicated or error prone or both.

You need to use your own buffering if you rely want perfect output.
The question is if it is really worth the complexity. Also note that
any buffering reduces the chance that the messages will reach
the console.

BTW: There is a work in progress on a lockless printk ring buffer.
It will make printk() more secure regarding deadlocks. But it might
make transparent handling of continuous lines even more tricky.

I guess that local buffering, before calling printk(), will be
even more important then. Well, it might really force us to create
an API for it.


> Can printk be called once with whatever is in the struct? Otherwise if
> this is about making printk into a structured log then maybe printk
> isn't the proper solution anyway. Maybe a dev interface should be used
> instead that can handle starting and stopping tests (via ioctl) in
> addition to reading test results, records, etc. with read() and a
> clearing of the records. Then the seqfile API works naturally. All of
> this is a bit premature, but it looks like you're going down the path of
> making something akin to ftrace that stores binary formatted
> assertion/expectation records in a lockless ring buffer that then
> formats those records when the user asks for them.

IMHO, ftrace postpones the text formatting primary because it does not
not want to slow down the traced code more than necessary. It is yet
another layer and there should be some strong reason for it.

> I can imagine someone wanting to write unit tests that check conditions
> from a simulated hardirq context via irq works (a driver mock
> framework?), so this doesn't seem far off.

Note that stroring the messages into the printk log is basically safe in any
context. It uses temporary per-CPU buffers for recursive messages and
in NMI. The only problem is panic() when some CPU gets stuck with the
lock taken. This will get solved by the lockless ringbuffer. Also
the temporary buffers will not be necessary any longer.

Much bigger problems are with consoles. There are many of them. It
means a lot of code and more locks involved, including scheduler
locks. Note that console lock is a semaphore.

Best Regards,
Petr
