Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605D02B038A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 12:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgKLLIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 06:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgKLLHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:07:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B564AC0613D1;
        Thu, 12 Nov 2020 03:07:33 -0800 (PST)
Date:   Thu, 12 Nov 2020 12:07:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605179252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GScfsa8nOXUlNCCC/0bnPZszGImDlkAqoVu5Twbqets=;
        b=zZ3ortjpGyVdT6l5Epo+oXEihOo3YsbgeWmCO4SNBn297T52hhepV9lm5suD/944+Sz1gu
        BkYylnk8pMKlYkb4csofMkEGSrhcQcyIn5AL1i1pw3/utYozF/zdo6+bRfmnph5PP7xve1
        PpOVvXxebOQE5U3JtIzNhA0Fc1104xhNai+afx4A4y2O3Fs5x58WbqWTdn5gkAWgcM/duh
        sMgxr+wPIZY9f8FrD3RrbmLqGk62lK9VfUOJuVBmyG+rJup0NYxJRRrKBRd/enHEx2zhIx
        UfbLWY8NE5CqXAlPHU3T/T5B/66csi1W6K2Uz4Y5UeWB8lzg0bfoVIlYejlz5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605179252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GScfsa8nOXUlNCCC/0bnPZszGImDlkAqoVu5Twbqets=;
        b=IHlNPa7GPp5Ilh/x3NSZBuxoBCag1CyU3lSY94fXEHyvLJqz7JXMYGP0aqsiN8HGB3WFr5
        ZFMQ/3qvo+nJiyAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-aio@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20201112110729.vx4xebavy6gpzuef@linutronix.de>
References: <20201103092712.714480842@linutronix.de>
 <20201103095857.582196476@linutronix.de>
 <CGME20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df@eucas1p1.samsung.com>
 <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-11-12 09:10:34 [+0100], Marek Szyprowski wrote:
> I can do more tests to help fixing this issue. Just let me know what to do.

-> https://lkml.kernel.org/r/87y2j6n8mj.fsf@nanos.tec.linutronix.de

Sebastian
