Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B7C2B035D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 12:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgKLLD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 06:03:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgKLLDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:03:24 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605179001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RyoQNma1D4GVgEfBEnD9HpKfLsmdKQZ2swCCbsJ89u4=;
        b=IyNoaFaiD+NM5KphnaangmvfL0El+UAOD+w5h3trf2Yyosfdrv/YLVOkMULOW/ZGBhg+Y/
        CdApJJvXGBIZ5Y44ibFQmafGLFWCU3g2FoxBkEzR7mbT6bdJj8sJZKMh9WrX346Yk/RRPA
        ObPEWbP1WIFj7Nu0oQW4DAuIZK/gvLY9xJn27pRRcuIRXasgXoUZIFo7CFG246Z8CyXPW3
        lDFsIyNmic0931dDytsaIyKfHvx6VLixbP2g5wvqVZcSxNyP0kB6LHCFDa/PWmE2zunoqs
        ONbIDGQXkPDZeN2NEzrt5DA5ZmFd/tf+3b4Z7uRwEDxb+zVSTZJFZcQwZtL5UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605179001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RyoQNma1D4GVgEfBEnD9HpKfLsmdKQZ2swCCbsJ89u4=;
        b=3CYfPdTtsJ7bzsqrZTQJEvt1hjj5oOsRpY9HRk4W6lYOEOtLJxrx+ZTCMYthtsl9eIeQcX
        u0l5A2sNhnUsiqCg==
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-aio@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Huang Rui <ray.huang@amd.com>, sparclinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paul McKenney <paulmck@kernel.org>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@suse.de>, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        spice-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-mips@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-btrfs@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [patch V3 10/37] ARM: highmem: Switch to generic kmap atomic
In-Reply-To: <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
References: <20201103092712.714480842@linutronix.de> <20201103095857.582196476@linutronix.de> <CGME20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df@eucas1p1.samsung.com> <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
Date:   Thu, 12 Nov 2020 12:03:20 +0100
Message-ID: <87v9ean8g7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Marek,

On Thu, Nov 12 2020 at 09:10, Marek Szyprowski wrote:
> On 03.11.2020 10:27, Thomas Gleixner wrote:
>
> I can do more tests to help fixing this issue. Just let me know what to do.

Just sent out the fix before I saw your report.

     https://lore.kernel.org/r/87y2j6n8mj.fsf@nanos.tec.linutronix.de

Thanks,

        tglx
