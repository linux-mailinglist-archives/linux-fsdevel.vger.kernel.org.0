Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6D674CE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 06:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjATF4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 00:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjATF4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:56:10 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB78AD09;
        Thu, 19 Jan 2023 21:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5L8b9+6lFLvmsEhRZ8nAxeepW7lwqOKRUfjfE9A+xf4=; b=nvH1AyXrH6mgsG41yfNyLvr0ar
        L4Bh8wYJLS/Axo9nm8GvLjYknRvqAA2UbIWop3KVkLAoaLc3NbaIhl2pOElDG2csVvEaIlcgp/TPD
        Tml/7R2TYACkWhHxh4aeYdJqDabkfLkw8JjN552Oi30xTNC6pSbPhVIiDWpCcUTseRejn18Xyv18t
        ks5yiRosowg9RUy2okDuD72dVGlM6I4M5eHQKSRlLdWO9ovZzyoDjzPKufMpfwOhDDnq5qnPqvZkh
        AwgkMd6U56w51Tci1yEAjj3q1uU73Qdkd8wHolQnsq0gU1K6c4q5e6xuFv4Krw2nDuvwXor8W1bpZ
        Tq5T49mg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIkNd-002vuk-2d;
        Fri, 20 Jan 2023 05:56:01 +0000
Date:   Fri, 20 Jan 2023 05:56:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <Y8os8QR1pRXyu4N8@ZenIV>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com>
 <Y8oWsiNWSXlDNn5i@ZenIV>
 <Y8oYXEjunDDAzSbe@casper.infradead.org>
 <Y8ocXbztTPbxu3bq@ZenIV>
 <Y8oem+z9SN487MIm@casper.infradead.org>
 <Y8ohpDtqI8bPAgRn@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ohpDtqI8bPAgRn@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:07:48AM +0000, Al Viro wrote:
> On Fri, Jan 20, 2023 at 04:54:51AM +0000, Matthew Wilcox wrote:
> 
> > > Sure, but... there's also this:
> > > 
> > > static inline void __kunmap_local(const void *addr)
> > > {
> > > #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> > >         kunmap_flush_on_unmap(addr);
> > > #endif
> > > }
> > > 
> > > Are you sure that the guts of that thing will be happy with address that is not
> > > page-aligned?  I've looked there at some point, got scared of parisc (IIRC)
> > > MMU details and decided not to rely upon that...
> > 
> > Ugh, PA-RISC (the only implementor) definitely will flush the wrong
> > addresses.  I think we should do this, as having bugs that only manifest
> > on one not-well-tested architecture seems Bad.
> > 
> >  static inline void __kunmap_local(const void *addr)
> >  {
> >  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> > -       kunmap_flush_on_unmap(addr);
> > +       kunmap_flush_on_unmap(PAGE_ALIGN_DOWN(addr));
> >  #endif
> >  }
> 
> PTR_ALIGN_DOWN(addr, PAGE_SIZE), perhaps?

	Anyway, that's a question to parisc folks; I _think_ pdtlb
quietly ignores the lower bits of address, so that part seems
to be safe, but I wouldn't bet upon that.  And when I got to
flush_kernel_dcache_page_asm I gave up - it's been a long time
since I've dealt with parisc assembler.
