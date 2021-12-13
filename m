Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454D6472FB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbhLMOoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 09:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbhLMOoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:44:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9BBC061574;
        Mon, 13 Dec 2021 06:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WN0UBRQSaVnqth1lPLeu1h3m2LsiDV8FPn8ylQJCtw8=; b=p3RXvBFb2so3jcvbNtFm9YqLoy
        Db6NHe524T07Hi4ZiyLaxSrQxikXMESk//fQ258u8C8HwL4tvSiBf9GqWsbjwUJj0MpZb99Q3r7Gn
        U8I4uIl0lJmqmxhPuXIO2nSstlKIwd5Iq6DRxuuB+XewafpJUhhMkxy8nn3Di3UE6QlKKR/tkzwqN
        82AY01mLzM89zRBTPtsel1HfkWhp0iwheQwoshPsb7I7IaBR/GEnNFzI6tMIojo9QsGW9FNyl0q0u
        8cNlSbM2lT2wank3wbXnRWxj4TWJs6JahqJ/E/e+nJSdtlRCOOK0S/1TpqDLQhR1BBCV9fSEeWv7a
        TVTjir2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmYS-00Csn8-Vy; Mon, 13 Dec 2021 14:43:53 +0000
Date:   Mon, 13 Dec 2021 14:43:52 +0000
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
Message-ID: <YbdcKK3Cq6ITTg/l@casper.infradead.org>
References: <1639193588-7027-1-git-send-email-yangtiezhu@loongson.cn>
 <0c5cb37139af4f3e85cc2c5115d7d006@AcuMS.aculab.com>
 <YbXhVxRJfjvKw++W@casper.infradead.org>
 <b7a75ae9253445af81ff2fedd5268af4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a75ae9253445af81ff2fedd5268af4@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:30:33AM +0000, David Laight wrote:
> From: Matthew Wilcox
> > Sent: 12 December 2021 11:48
> > 
> > On Sat, Dec 11, 2021 at 05:53:46PM +0000, David Laight wrote:
> > > From: Tiezhu Yang
> > > > Sent: 11 December 2021 03:33
> > > >
> > > > v2:
> > > >   -- add copy_to_user_or_kernel() in lib/usercopy.c
> > > >   -- define userbuf as bool type
> > >
> > > Instead of having a flag to indicate whether the buffer is user or kernel,
> > > would it be better to have two separate buffer pointers.
> > > One for a user space buffer, the other for a kernel space buffer.
> > > Exactly one of the buffers should always be NULL.
> > 
> > No.  You should be using an iov_iter instead.  See
> > https://lore.kernel.org/all/Ya4bdB0UBJCZhUSo@casper.infradead.org/
> > for a start on this.
> 
> iov_iter gets horribly expensive...

Oh, right.  Reading the kcore is a high-performance path, my mistake.
