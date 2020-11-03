Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D12A4508
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 13:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgKCMZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 07:25:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbgKCMZq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:25:46 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAE822403;
        Tue,  3 Nov 2020 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604406345;
        bh=JnG9AEM3urtQJZbyh27ncRK5xtNjXhkMpT9pLY6ruAw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S3ilUxfLmh/0Pv4skyGqFEAG0vwDSS5i5psimoXmAELMEWHSH2fW4IuM4Z+qMebRf
         WAXWrrJnkn0me0BHoC6LmAQbdfefgrg1IUndUDBw+RKZdCT9Ym0K7hlLMGCU1lFFO3
         Zsx6vPAhW90E/61D8322HI52wvm4X0FuC5QxUJR0=
Received: by mail-wr1-f50.google.com with SMTP id k10so17011011wrw.13;
        Tue, 03 Nov 2020 04:25:44 -0800 (PST)
X-Gm-Message-State: AOAM531fAqcyHHSv2U9CZ9dP3oPogr0zh4cTugMzh94Ysy/X6sIGtfQM
        XykDjgWFCFOGJqS5maLpA0+4zpavr1VWgO7H7Fg=
X-Google-Smtp-Source: ABdhPJzaMTU0V4sDEP7WFi1D19pueRl5ySNY/GA/QmiGvW8mi19ZpCI6gDmcGIwe2rHXpOPoRB6cN5TL6gD3Vvt/QEU=
X-Received: by 2002:adf:eb4f:: with SMTP id u15mr19654094wrn.165.1604406343518;
 Tue, 03 Nov 2020 04:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20201103092712.714480842@linutronix.de> <20201103095857.078043987@linutronix.de>
In-Reply-To: <20201103095857.078043987@linutronix.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 3 Nov 2020 13:25:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3q1O=vTLHpjkufNhspj+OJFn0BkMD6XaPZvN_0D+=FFQ@mail.gmail.com>
Message-ID: <CAK8P3a3q1O=vTLHpjkufNhspj+OJFn0BkMD6XaPZvN_0D+=FFQ@mail.gmail.com>
Subject: Re: [patch V3 05/37] asm-generic: Provide kmap_size.h
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
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
        ML nouveau <nouveau@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 3, 2020 at 10:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> kmap_types.h is a misnomer because the old atomic MAP based array does not
> exist anymore and the whole indirection of architectures including
> kmap_types.h is inconinstent and does not allow to provide guard page
> debugging for this misfeature.
>
> Add a common header file which defines the mapping stack size for all
> architectures. Will be used when converting architectures over to a
> generic kmap_local/atomic implementation.
>
> The array size is chosen with the following constraints in mind:
>
>     - The deepest nest level in one context is 3 according to code
>       inspection.
>
>     - The worst case nesting for the upcoming reemptible version would be:
>
>       2 maps in task context and a fault inside
>       2 maps in the fault handler
>       3 maps in softirq
>       2 maps in interrupt
>
> So a total of 16 is sufficient and probably overestimated.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
