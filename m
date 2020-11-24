Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA82C31DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 21:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgKXUVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 15:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgKXUVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:21:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8827C0613D6;
        Tue, 24 Nov 2020 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yao9E9sn9zz+iZFIp2Psjk/MTQ2gFiyODukKu/NAT3g=; b=H3+EmdJarS1cfvvZ0ztNJkxZRb
        4w5dA2wwkBoMn1YInAvdLxa8WRVKY09lpftouA8e1FWJkbI5Dkcy+jrFllWD4PY9+KVLSO6lfZmt+
        RWHcB+yTx3JAbTdm8HdWkmAL0vj2UAQlJC3veZPlbdLtojIWnWKLAi4KIhjttMkVU86OzU9BSc4Px
        ROLC+bg2SVjEUWOyG8oPNiw0bONff2itEr9C0nHqL1fBsrlaw3vbftWq3tzbhEXGIP8bRodBCiJWt
        6/nvoi9bBlTZUGPZ86KF3SVh5qFrVTJd5ZQKmh/wvuRtBv7Kck2bNK49SwHKPdojj+lwezm6gmwUX
        sBWTziNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kheno-0001ew-4B; Tue, 24 Nov 2020 20:20:40 +0000
Date:   Tue, 24 Nov 2020 20:20:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/17] mm/highmem: Lift memcpy_[to|from]_page and
 memset_page to core
Message-ID: <20201124202040.GF4327@casper.infradead.org>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
 <20201124060755.1405602-2-ira.weiny@intel.com>
 <20201124141941.GB4327@casper.infradead.org>
 <20201124192113.GL1161629@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124192113.GL1161629@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:21:13AM -0800, Ira Weiny wrote:
> On Tue, Nov 24, 2020 at 02:19:41PM +0000, Matthew Wilcox wrote:
> > On Mon, Nov 23, 2020 at 10:07:39PM -0800, ira.weiny@intel.com wrote:
> > > +static inline void memzero_page(struct page *page, size_t offset, size_t len)
> > > +{
> > > +	memset_page(page, 0, offset, len);
> > > +}
> > 
> > This is a less-capable zero_user_segments().
> 
> Actually it is a duplicate of zero_user()...  Sorry I did not notice those...
> :-(
> 
> Why are they called '_user_'?

git knows ...

commit 01f2705daf5a36208e69d7cf95db9c330f843af6
Author: Nate Diller <nate.diller@gmail.com>
Date:   Wed May 9 02:35:07 2007 -0700

    fs: convert core functions to zero_user_page
    
    It's very common for file systems to need to zero part or all of a page,
    the simplist way is just to use kmap_atomic() and memset().  There's
    actually a library function in include/linux/highmem.h that does exactly
    that, but it's confusingly named memclear_highpage_flush(), which is
    descriptive of *how* it does the work rather than what the *purpose* is.
    So this patchset renames the function to zero_user_page(), and calls it
    from the various places that currently open code it.
    
    This first patch introduces the new function call, and converts all the
    core kernel callsites, both the open-coded ones and the old
    memclear_highpage_flush() ones.  Following this patch is a series of
    conversions for each file system individually, per AKPM, and finally a
    patch deprecating the old call.  The diffstat below shows the entire
    patchset.

