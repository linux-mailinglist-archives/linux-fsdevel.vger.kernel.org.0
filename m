Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8857EDA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 09:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfHBHiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 03:38:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38634 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfHBHiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:38:15 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1htS8S-0005sF-R0; Fri, 02 Aug 2019 09:37:56 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Petr Mladek <pmladek@suse.com>, Jeff Dike <jdike@addtoit.com>,
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
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, wfg@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Knut Omang <knut.omang@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
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
        <20190726083148.d4gf57w2nt5k7t6n@pathway.suse.cz>
        <CAFd5g46iAhDZ5C_chi7oYLVOkwcoj6+0nw+kPWuXhqWwWKd9jA@mail.gmail.com>
Date:   Fri, 02 Aug 2019 09:37:53 +0200
In-Reply-To: <CAFd5g46iAhDZ5C_chi7oYLVOkwcoj6+0nw+kPWuXhqWwWKd9jA@mail.gmail.com>
        (Brendan Higgins's message of "Thu, 1 Aug 2019 11:55:20 -0700")
Message-ID: <871ry4yq3y.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-08-01, Brendan Higgins <brendanhiggins@google.com> wrote:
> On Fri, Jul 26, 2019 at 1:31 AM Petr Mladek <pmladek@suse.com> wrote:
>> On Thu 2019-07-25 13:21:12, Brendan Higgins wrote:
>>> On Wed, Jul 24, 2019 at 12:31 AM Petr Mladek <pmladek@suse.com> wrote:
>>>> On Mon 2019-07-22 16:54:10, Stephen Boyd wrote:
>>>>> Quoting Brendan Higgins (2019-07-22 15:30:49)
>>>>>> On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>>>>>> What's the calling context of the assertions and expectations? I
>>>>>>> still don't like the fact that string stream needs to allocate
>>>>>>> buffers and throw them into a list somewhere because the calling
>>>>>>> context matters there.
>>>>>>
>>>>>> The calling context is the same as before, which is anywhere.
>>>>>
>>>>> Ok. That's concerning then.
>>>>>
>>>>>>> I'd prefer we just wrote directly to the console/log via printk
>>>>>>> instead. That way things are simple because we use the existing
>>>>>>> buffering path of printk, but maybe there's some benefit to the
>>>>>>> string stream that I don't see? Right now it looks like it
>>>>>>> builds a string and then dumps it to printk so I'm sort of lost
>>>>>>> what the benefit is over just writing directly with printk.
>>>>>>
>>>>>> It's just buffering it so the whole string gets printed
>>>>>> uninterrupted.  If we were to print out piecemeal to printk,
>>>>>> couldn't we have another call to printk come in causing it to
>>>>>> garble the KUnit message we are in the middle of printing?
>>>>>
>>>>> Yes, printing piecemeal by calling printk many times could lead to
>>>>> interleaving of messages if something else comes in such as an
>>>>> interrupt printing something. Printk has some support to hold
>>>>> "records" but I'm not sure how that would work here because
>>>>> KERN_CONT talks about only being used early on in boot code. I
>>>>> haven't looked at printk in detail though so maybe I'm all wrong
>>>>> and KERN_CONT just works?
>>>>
>>>> KERN_CONT does not guarantee that the message will get printed
>>>> together. The pieces get interleaved with messages printed in
>>>> parallel.
>>>>
>>>> Note that KERN_CONT was originally really meant to be used only
>>>> during boot. It was later used more widely and ended in the best
>>>> effort category.
>>>>
>>>> There were several attempts to make it more reliable. But it was
>>>> always either too complicated or error prone or both.
>>>>
>>>> You need to use your own buffering if you rely want perfect output.
>>>> The question is if it is really worth the complexity. Also note
>>>> that any buffering reduces the chance that the messages will reach
>>>> the console.
>>>
>>> Seems like that settles it then. Thanks!
>>>
>>>> BTW: There is a work in progress on a lockless printk ring buffer.
>>>> It will make printk() more secure regarding deadlocks. But it might
>>>> make transparent handling of continuous lines even more tricky.
>>>>
>>>> I guess that local buffering, before calling printk(), will be
>>>> even more important then. Well, it might really force us to create
>>>> an API for it.
>>>
>>> Cool! Can you CC me on that discussion?
>>
>> Adding John Oggness into CC.
>>
>> John, please CC Brendan Higgins on the patchsets eventually switching
>> printk() into the lockless buffer. The test framework is going to
>> do its own buffering to keep the related messages together.
>>
>> The lockless ringbuffer might make handling of related (partial)
>> lines worse or better. It might justify KUnit's extra buffering
>> or it might allow to get rid of it.
>
> Thanks for CC'ing me on the printk ringbuffer thread. It looks like it
> actually probably won't affect my needs for KUnit logging. The biggest
> reason I need some sort of buffering system is to be able to compose
> messages piece meal into a single message that will be printed out to
> the user as a single message with no messages from other printk
> callers printed out in the middle of mine.

printk has this same requirement for its CONT messages. You can read
about how I propose to implement that here[0], using a separate prb
ringbuffer for buffered storage until all the pieces are available.

It is not my goal that multiple subsystems start making use of the prb
ringbuffer. However, its features can be attractive if you don't want to
worry about multiple writers/readers or context (including NMI). Before
writing "yet another ringbuffer" [1] it might be worth the effort to at
least see if one of the existing implementations can work (or be
extended to work) for you.

John Ogness

[0] https://lkml.kernel.org/r/87imt2bl0k.fsf@linutronix.de
[1] https://lwn.net/Articles/789603/

> The prb does look interesting; however, it appears that to get the
> semantics that I need, I would have to put my entire message in a
> single data block and would consequently need to know the size of my
> message a priori, which is problematic. Consequently, it seems as
> though I will probably need to compose my entire message using my own
> buffering system.
>
>>>> Note that stroring the messages into the printk log is basically
>>>> safe in any context. It uses temporary per-CPU buffers for
>>>> recursive messages and in NMI. The only problem is panic() when
>>>> some CPU gets stuck with the lock taken. This will get solved by
>>>> the lockless ringbuffer. Also the temporary buffers will not be
>>>> necessary any longer.
>>>
>>> Sure, I think Stephen's concern is all the supporting code that is
>>> involved. Not printk specifically. It just means a lot more of KUnit
>>> has to be IRQ safe.
>>
>> I see.
>>
>> BTW: I wonder if KUnit could reuse the existing seq_buf
>> implementation for buffering messages.
>>
>> I am sorry if it has already been proposed and rejected for some
>> reason. I might have missed it. Feel free to just point me to
>> same older mail.
>
> Yeah, we discussed it briefly here:
>
> https://lkml.org/lkml/2019/5/17/497
>
> Looks like I forgot to include my reasoning in the commit text, sorry
> about that.
>
>>>> Much bigger problems are with consoles. There are many of them. It
>>>> means a lot of code and more locks involved, including scheduler
>>>> locks. Note that console lock is a semaphore.
>>>
>>> That shouldn't affect us though, right? As long as we continue to
>>> use the printk interface?
>>
>> I guess that it should not affect KUnit.
>>
>> The only problem might be if the testing framework calls printk()
>> inside scheduler or console code. And only when the tested code
>> uses the same locks that will be used by the called printk().
>
> Yeah, well printk will not be our only problem in those instances.
>
>> To be honest I do not fully understand KUnit design. I am not
>> completely sure how the tested code is isolated from the running
>> system. Namely, I do not know if the tested code shares
>> the same locks with the system running the test.
>
> No worries, I don't expect printk to be the hang up in those cases. It
> sounds like KUnit has a long way to evolve before printk is going to
> be a limitation.
>
> Thanks!
