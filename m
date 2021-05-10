Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524523796D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhEJSNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 14:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJSNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 14:13:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245E6C061574;
        Mon, 10 May 2021 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=YL/AMILJQ/MhajJ8+fnwzdJVjELrW3Cc7diRHC8qblE=; b=PLqLn0j5PoKbrh6VvmUSIr6l8i
        m8fa8nPq4gYXhF6Rn4dgILKWMjjl7o8SH9lg5SYTpcsggrmMHPyjsoeUpUNoNTR0oe/2nflr9voHC
        mgd4g8Z7yyeIJ7q+nicXHEqYw5/hVDnntM06Is+SsQFVrdSv5ie1DvIWiwRc/g8IS2C6z+K+eFfMQ
        bABMNr7fkPmtzTzDvG1cseklK17UAEAX/5Ap27q9PJnvy8h7UN4RI4MmiAq/tz4thtJ13v84IpOw0
        XMMw3IEfcIDcHkuznaZj7wqb1rhPMwq94acK9NCfDzZKucYeUpXIsLo+5v5vi9+K2Rn2TY1i4Zidv
        ROzmVcpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgANT-006SNM-UC; Mon, 10 May 2021 18:11:43 +0000
Date:   Mon, 10 May 2021 19:11:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] I/O completions in softirq context
Message-ID: <YJl3V5q/+ovcSzJB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have some reports of the interrupt hangcheck watchdog firing when
completing I/Os that are millions of pages long.  While it doesn't
really make sense to construct single I/Os that are that big, it does
flag that even, say, a 16MB writeback I/O is going to spend a lot of time
clearing the writeback bit from pages.  With 4kB pages, that's 4096
pages.  At 2000 cycles per cache miss (and with just the struct pages
being 256kB of data, they're not in L1 cache any more and probably not
in L2 either), that's 8 million cycles with interrupts disabled.

If we could guarantee that BIOs were always ended in softirq context,
the page cache could use spin_lock_bh() instead of spin_lock_irq().
I haven't done any measurements to quantify what kind of improvement
that would be, but I suspect it could be seen on some workloads.

(this is more of an attempt to induce conference driven development
than necessarily a discussion topic for lsfmm)
