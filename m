Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30D4FA15C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 03:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiDIBq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 21:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiDIBqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:46:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3BE10;
        Fri,  8 Apr 2022 18:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OgLQ9aa2Ll1qzof8jP14x/YA/bXhQ5LusxQEfz4RR7o=; b=jRF0GBhcKeXEgZP7anRr2kF8AM
        iZFXR4zMjLIRIivbW06XLbEBp3NsDMVVZ7jINiVksrOIClwIU8fZ6pS6bv3+47+GemzGcoyDoMnwW
        zjjuqML5IE2pwXoZOqvpDXBPgcYsVtRr/zAMmK3431l825FhftMkgBr3Dym3TD/jG4BEyTGCUkzY3
        LSPzSpsJfyMH1xjerXMSwK3Om4+15Q0mlYTj95RKwlAzTkcKf5iTSDlAPceF00Q+SaLooxHeFw8qK
        i3cGY0JrCcLhVrHbEUhACITB3MF+u9LDnT1/qT5WPgJ2Jp2ykRdepYN7Lvnp/ZXCPNg0xKX7liKoa
        hEgux/7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd09V-00AL1l-TW; Sat, 09 Apr 2022 01:44:37 +0000
Date:   Sat, 9 Apr 2022 02:44:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, hch@lst.de, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 RESEND 1/3] vmcore: Convert copy_oldmem_page() to take
 an iov_iter
Message-ID: <YlDlBQYr9ldLWpFz@casper.infradead.org>
References: <20220408090636.560886-2-bhe@redhat.com>
 <202204082128.JKXXDGpa-lkp@intel.com>
 <YlDbJSy4AI3/cODr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlDbJSy4AI3/cODr@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 09, 2022 at 09:02:29AM +0800, Baoquan He wrote:
> I tried on x86_64 system, for the 1st step, I got this:
> 
> [ ~]# wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> /root/bin/make.cross: No such file or directory

... I don't think we need to reproduce it to see the problem.

> > sparse warnings: (new ones prefixed by >>)
> > >> arch/sh/kernel/crash_dump.c:23:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem * @@
> >    arch/sh/kernel/crash_dump.c:23:36: sparse:     expected void const *addr
> >    arch/sh/kernel/crash_dump.c:23:36: sparse:     got void [noderef] __iomem *
> > 
> > vim +23 arch/sh/kernel/crash_dump.c
> > 
> >     13	
> >     14	ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
> >     15				 size_t csize, unsigned long offset)
> >     16	{
> >     17		void  __iomem *vaddr;
> >     18	
> >     19		if (!csize)
> >     20			return 0;
> >     21	
> >     22		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> >   > 23		csize = copy_to_iter(vaddr + offset, csize, iter);

Unlike other architectures, sh4 does this by calling ioremap().
That gives us an __iomem qualified pointer, which it then warns about
passing to copy_to_iter().

There are a bunch of hacky things we could do to fix it, but for such an
unmaintained arch as sh, I'm inclined to do nothing.  We're more likely
to break something while fixing the warning.  Someone who knows the arch
can figure out what to do properly.
