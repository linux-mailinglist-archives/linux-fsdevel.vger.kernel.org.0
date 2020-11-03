Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC22A4F8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 20:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgKCTAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 14:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgKCTAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:00:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8B3C0613D1;
        Tue,  3 Nov 2020 11:00:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604430021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p7vA0Pp8Yw32NcCmeGMglrNZNTsusNNmUR0JbokXn0s=;
        b=Wh43mnWM8kdYti+K6Ejg70IQfa+GmZ8DCSo20FQE/hkLNmxVT4iphQnlk6m40FPrmWktQO
        8ayXKz0ztE1cqx/iEhmcbhojQh9yCHEkFANOGr1w8fGEwrPOcrWAWxi/OenSb5evTEILWa
        oclhRZDu2W0eltn+sc+1j25HCEzKjNSXz+4io/CbYUyMFuxTbNnNJEiCm1jMBn8PGej5s3
        E3JpbZR0aFWpI6lV+SZv22HUNUyPWbXG8oMYz+BmJikgi+ivLhTWpXqqgXf53DcJR+Ltrn
        dCfpJUdQQNPCTgPlSMPzbs0whzNCaCVS/fZbTm34UVovthqkFff3qyFpeY0sbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604430021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p7vA0Pp8Yw32NcCmeGMglrNZNTsusNNmUR0JbokXn0s=;
        b=STcwQ6RaI64DeextSGHfCvrA9zLqnmZlfhd6kn3GgHfcpWRfVbJIkhHpoM7lA8B8jXR4lp
        QBLUYE/euA+zomCg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list\:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Subject: Re: [patch V3 22/37] highmem: High implementation details and document API
In-Reply-To: <CAHk-=wg2D_yjgKYkXCybD3uf0dtwYh6HxZ9BQJfV5t+EBqLGQQ@mail.gmail.com>
References: <20201103092712.714480842@linutronix.de> <20201103095858.827582066@linutronix.de> <CAHk-=wg2D_yjgKYkXCybD3uf0dtwYh6HxZ9BQJfV5t+EBqLGQQ@mail.gmail.com>
Date:   Tue, 03 Nov 2020 20:00:20 +0100
Message-ID: <87y2ji1d17.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03 2020 at 09:48, Linus Torvalds wrote:
> I have no complaints about the patch, but it strikes me that if people
> want to actually have much better debug coverage, this is where it
> should be (I like the "every other address" thing too, don't get me
> wrong).
>
> In particular, instead of these PageHighMem(page) tests, I think
> something like this would be better:
>
>    #ifdef CONFIG_DEBUG_HIGHMEM
>      #define page_use_kmap(page) ((page),1)
>    #else
>      #define page_use_kmap(page) PageHighMem(page)
>    #endif
>
> adn then replace those "if (!PageHighMem(page))" tests with "if
> (!page_use_kmap())" instead.
>
> IOW, in debug mode, it would _always_ remap the page, whether it's
> highmem or not. That would really stress the highmem code and find any
> fragilities.

Yes, that makes a lot of sense. We just have to avoid that for the
architectures with aliasing issues.

> Anyway, this is all sepatrate from the series, which still looks fine
> to me. Just a reaction to seeing the patch, and Thomas' earlier
> mention that the highmem debugging doesn't actually do much.

Right, forcing it for both kmap and kmap_local is straight forward. I'll
cook a patch on top for that.

Thanks,

        tglx


