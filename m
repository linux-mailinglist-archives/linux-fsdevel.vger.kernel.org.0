Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B518412B86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347073AbhIUCTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 22:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbhIUBy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:54:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CCAC0313FF;
        Mon, 20 Sep 2021 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dFAUFg/mX5umZGWtfy03pLeHbDGj6EjlCd5lUAE3GFQ=; b=dObeiqsndcF+lNoh24bcIlQ0Z4
        8K6tr6/HQqzHejW7tcCx2uFWkOSwSDGccUZUOO2HSbtwyHL2bzieHlxL/ZHYYKEk4p9CFnO8yXcPK
        f/HQ2/ZQdndlnXyIUJdZ0aJXLTxz6QwLUg1BzKdC6l5F015c1tMcwzAgGVNaIhiqeaim5LUH14T5q
        SfrB2JGYzUuVFRpexD44YBdIJt19FFXMuXQ78E+NFAQjPzOw2KYPs158O36UwjUA4HwZgR9XHQuYE
        ogpEbh3JR5+EHuSxOJT6kAbYkYcwK3PhKk2oYu4rhbOLPFOZheHL/NsJp3sMZeprOIKrHIsh9/J3J
        bDfWazSw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSTFv-003Nm8-F2; Tue, 21 Sep 2021 00:03:27 +0000
Date:   Mon, 20 Sep 2021 17:03:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, jeyu@kernel.org,
        shuah <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, yzaikin@google.com,
        Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        vitor@massaru.org, elver@google.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        rf@opensource.cirrus.com,
        Stephen Hemminger <stephen@networkplumber.org>,
        David Laight <David.Laight@aculab.com>, bvanassche@acm.org,
        jolsa@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        trishalfonso@google.com, andreyknvl@gmail.com,
        Jiri Kosina <jikos@kernel.org>, mbenes@suse.com,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, lizefan.x@bytedance.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        senozhatsky@chromium.org, Christoph Hellwig <hch@lst.de>,
        Joe Perches <joe@perches.com>, hkallweit1@gmail.com,
        Jens Axboe <axboe@kernel.dk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-spdx@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YUkhTxhgPWRxMMJo@bombadil.infradead.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
 <20210918050430.3671227-10-mcgrof@kernel.org>
 <CAPcyv4i0xEwMQ5kSK-xGroV7aZr3j1YNrGMVLiLMr3U8nFCMKA@mail.gmail.com>
 <YUj6TrGbqlNI0OGC@bombadil.infradead.org>
 <CAPcyv4jFaNTfpKq6hQsFrWXTwHz-wG+5K4m-hmsPeteLX4p5AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jFaNTfpKq6hQsFrWXTwHz-wG+5K4m-hmsPeteLX4p5AQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:55:10PM -0700, Dan Williams wrote:
> On Mon, Sep 20, 2021 at 2:17 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Sep 20, 2021 at 01:52:21PM -0700, Dan Williams wrote:
> > > On Fri, Sep 17, 2021 at 10:05 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > This deadlock was first reported with the zram driver, however the live
> > > > patching folks have acknowledged they have observed this as well with
> > > > live patching, when a live patch is removed. I was then able to
> > > > reproduce easily by creating a dedicated selftests.
> > > >
> > > > A sketch of how this can happen follows:
> > > >
> > > > CPU A                              CPU B
> > > >                                    whatever_store()
> > > > module_unload
> > > >   mutex_lock(foo)
> > > >                                    mutex_lock(foo)
> > > >    del_gendisk(zram->disk);
> > > >      device_del()
> > > >        device_remove_groups()
> > >
> > > This flow seems possible to trigger with:
> > >
> > >    echo $dev > /sys/bus/$bus/drivers/$driver/unbind
> > >
> > > I am missing why module pinning
> >
> > The aspect of try_module_get() which comes to value to prevent the
> > deadlock is it ensures kernfs ops do not run once exit is on the way.
> >
> > > is part of the solution when it's the
> > > device_del() path that is racing?
> >
> > But its not, the device_del() path will yield until the kernfs op
> > completes. It is fine to wait there.
> >
> > The deadlock happens if a module exit routine uses a lock which is
> > also used on a sysfs op. If the lock was first held by module exit,
> > and module exit is waiting for the kernfs op to complete, and the
> > kernfs op is waiting to hold the same lock then the exit will wait
> > forever.
> >
> > > Module removal is just a more coarse
> > > grained way to trigger unbind => device_del().
> >
> > Right, but the device_del() path is not sharing a lock with the sysfs op.
> 
> The deadlock in the example comes from holding a lock over
> device_del() [...]

No sorry, that is my mistake not making it clear that the mutex held
in the example is on module exit. Or any lock for that matter. That is
these locks are driver specific.

> > > Isn't the above a bug
> > > in the driver, not missing synchronization in kernfs?
> >
> > We can certainly take the position as an alternative:
> >
> >   "thou shalt not use a lock on exit which is also used on a syfs op"
> >
> > However that seems counter intuitive, specially if we can resolve the
> > issue easily with a try_module_get().
> 
> Again, I don't see how try_module_get() can affect the ABBA failure
> case of holding a lock over device_del() that is also held inside
> sysfs op.

It is not device_del(), it is on module exit. Sorry for this not being
clear before. I'll fix the commit log to make it clearer. The subject
at least was clear but I think the example could be clearer.

  Luis
