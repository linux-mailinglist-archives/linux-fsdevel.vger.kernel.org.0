Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C866A4719DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Dec 2021 12:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhLLLru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 06:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLLLrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:47:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84685C061714;
        Sun, 12 Dec 2021 03:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cdIWjpexE795gzuTbGkhPUpnRr/U2TeKiWDOHNiXINU=; b=DBuAHgfzGOIMRSDJohGgbB9HgK
        ghrV2KCPdFwOYiKPJbGZmSBlu830exEyDU1H933xIMmToosr9grTCGE55WJZij6cZJgiJ1q30Hz6n
        hZ10t4g0j/sD0EiJhnKSD6jRzu1/6oOpBcVGGwdhdZP63WKKmTkX5QTrHpV8qjjFHIi/X5QMWkaoG
        kknEssmq/uipXQiDMvDkVUnKo+GmhJFGjhExQwE0EWBz9jMfQIQFxVuyBDOWKu8J+hXb6Owf3uTdh
        8Fl4Is3Mc1bjDe5u/B8VTKoy9i1C2ETLTUE3K71/BU8t21Bssus2/nA1qsleo4QX3UFxfJvaTfFhq
        xMZgWXeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwNKJ-00Bt8s-Ff; Sun, 12 Dec 2021 11:47:35 +0000
Date:   Sun, 12 Dec 2021 11:47:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Tiezhu Yang' <yangtiezhu@loongson.cn>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2 0/2] kdump: simplify code
Message-ID: <YbXhVxRJfjvKw++W@casper.infradead.org>
References: <1639193588-7027-1-git-send-email-yangtiezhu@loongson.cn>
 <0c5cb37139af4f3e85cc2c5115d7d006@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5cb37139af4f3e85cc2c5115d7d006@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 11, 2021 at 05:53:46PM +0000, David Laight wrote:
> From: Tiezhu Yang
> > Sent: 11 December 2021 03:33
> > 
> > v2:
> >   -- add copy_to_user_or_kernel() in lib/usercopy.c
> >   -- define userbuf as bool type
> 
> Instead of having a flag to indicate whether the buffer is user or kernel,
> would it be better to have two separate buffer pointers.
> One for a user space buffer, the other for a kernel space buffer.
> Exactly one of the buffers should always be NULL.

No.  You should be using an iov_iter instead.  See
https://lore.kernel.org/all/Ya4bdB0UBJCZhUSo@casper.infradead.org/
for a start on this.
