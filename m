Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEA2D1E80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 00:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgLGXk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 18:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgLGXk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:40:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BBC061749;
        Mon,  7 Dec 2020 15:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5AE7BSE6Le8OpJjv+/Aj3F3qvVXYZeWZq3mq2zg0PHQ=; b=fPiiJZs5xU73noEHWcJcm4NTp7
        QBEqwAjgUw28ab1vCCPxeqXcKGimGpc+CN7lt97fuyKgS71wexBhXgVOKo4pzYDq52SX3HJ/TtS2w
        VyBaLTV00ttN8I+BYiFMsHM4UgpX8ShWh6PaikCuoS+DGO9ACavqY1i5ZEazpgRfkpvrc6gaMFhO7
        gz/89aWpUueRFu9BcElEvmaZQrZlnIjyGGtMUgPypMJ+h2HLRXiAhZCTYqzTBvlqvDvn+OzPsxyxO
        znOwjxoDUqODM2NiXu2tq0AOHX8teaAPgKmjnVWke6VONPMkZcb/ndx0Mugb5EIjhtuS5BznDQsj0
        Dh9xJ4PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmQ6z-0002gV-0P; Mon, 07 Dec 2020 23:40:09 +0000
Date:   Mon, 7 Dec 2020 23:40:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
Message-ID: <20201207234008.GE7338@casper.infradead.org>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
 <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201207232649.GD7338@casper.infradead.org>
 <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:34:44PM -0800, Dan Williams wrote:
> On Mon, Dec 7, 2020 at 3:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > > +static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> > > +                            struct page *src_page, size_t src_off,
> > > +                            size_t len)
> > > +{
> > > +     char *dst = kmap_local_page(dst_page);
> > > +     char *src = kmap_local_page(src_page);
> >
> > I appreciate you've only moved these, but please add:
> >
> >         BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> 
> I imagine it's not outside the realm of possibility that some driver
> on CONFIG_HIGHMEM=n is violating this assumption and getting away with
> it because kmap_atomic() of contiguous pages "just works (TM)".
> Shouldn't this WARN rather than BUG so that the user can report the
> buggy driver and not have a dead system?

As opposed to (on a HIGHMEM=y system) silently corrupting data that
is on the next page of memory?  I suppose ideally ...

	if (WARN_ON(dst_off + len > PAGE_SIZE))
		len = PAGE_SIZE - dst_off;
	if (WARN_ON(src_off + len > PAGE_SIZE))
		len = PAGE_SIZE - src_off;

and then we just truncate the data of the offending caller instead of
corrupting innocent data that happens to be adjacent.  Although that's
not ideal either ... I dunno, what's the least bad poison to drink here?
