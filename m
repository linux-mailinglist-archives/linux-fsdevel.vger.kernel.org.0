Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC530674BCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 06:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjATFJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 00:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjATFIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:08:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06080B90;
        Thu, 19 Jan 2023 20:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AgSRB+mgoCTnHm8pcHJStBFI1tbB4PFeuxr32dF+q1I=; b=m/LXF6aDW8XnPkVzayqKAoi9G5
        MFuhM+DkNyUv7XxxxNEKIkZgCiuXOylKdcJOC87wvTEUItyPUr43o5SgA1zTs9VTiSruEjSjxlz4H
        ytf34ZfHN5dz8+ggf0UzcFIh4XD8qwkvLUkGRUdvKkkcxGudCX66iL9KCR8d1mknRZYrZ1dhXQ+aS
        WIkftehBCvolqC0Hf0BZWBcEcFRXm7W+g2g+3XAynoTzMLFpKXcD1zRE+jW6ufWlkHE7+Xa1aEjXG
        XqN3PbRKsgxXgGPQtIhchhs9SW5ZOEadjtk+xe6iCf3AzxavZVpQj6kod5nDXTgtgJU1sf9iK4KCl
        N7mIS0eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIjQR-001fc3-QV; Fri, 20 Jan 2023 04:54:51 +0000
Date:   Fri, 20 Jan 2023 04:54:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <Y8oem+z9SN487MIm@casper.infradead.org>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com>
 <Y8oWsiNWSXlDNn5i@ZenIV>
 <Y8oYXEjunDDAzSbe@casper.infradead.org>
 <Y8ocXbztTPbxu3bq@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ocXbztTPbxu3bq@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 04:45:17AM +0000, Al Viro wrote:
> On Fri, Jan 20, 2023 at 04:28:12AM +0000, Matthew Wilcox wrote:
> > On Fri, Jan 20, 2023 at 04:21:06AM +0000, Al Viro wrote:
> > > On Thu, Jan 19, 2023 at 04:32:32PM +0100, Fabio M. De Francesco wrote:
> > > 
> > > > -inline void dir_put_page(struct page *page)
> > > > +inline void dir_put_page(struct page *page, void *page_addr)
> > > >  {
> > > > -	kunmap(page);
> > > > +	kunmap_local(page_addr);
> > > 
> > > ... and that needed to be fixed - at some point "round down to beginning of
> > > page" got lost in rebasing...
> > 
> > You don't need to round down in kunmap().  See:
> > 
> > void kunmap_local_indexed(const void *vaddr)
> > {
> >         unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
> > 
> 
> Sure, but... there's also this:
> 
> static inline void __kunmap_local(const void *addr)
> {
> #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>         kunmap_flush_on_unmap(addr);
> #endif
> }
> 
> Are you sure that the guts of that thing will be happy with address that is not
> page-aligned?  I've looked there at some point, got scared of parisc (IIRC)
> MMU details and decided not to rely upon that...

Ugh, PA-RISC (the only implementor) definitely will flush the wrong
addresses.  I think we should do this, as having bugs that only manifest
on one not-well-tested architecture seems Bad.

 static inline void __kunmap_local(const void *addr)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
-       kunmap_flush_on_unmap(addr);
+       kunmap_flush_on_unmap(PAGE_ALIGN_DOWN(addr));
 #endif
 }

Thoughts?
