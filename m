Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69068225B20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 11:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgGTJQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 05:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgGTJQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:16:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E717BC061794;
        Mon, 20 Jul 2020 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cqaPo6c/vbm75ZN40kWjbOeNcOmsa5cD3xE0rxriFws=; b=KD2SKYY0Vz7CTxTngq1V8OW17+
        8yc7CrhiRACK9sqKsxycaWO1WvV5WmEy2MdHZ0GX7NjeZ2QzKmUxYPYv9Y7E50BrD/04zU8IEM3+c
        vSy4mPNcIYnLS57Of5l7ZYoU0Mz4hueu0BsuOLLVJIxJ6ZQZLJbsiVF5Yu+gAbTD+2fy+w+2UQqBA
        rajGHu6G75zDYhe9xObUs9xqV4CuSgvh4Mibirb+fLOO6kn5SMLGcGqyU1FthlfD+zH4fjfV2gl+R
        lBk6ZSUlV1I371mjJjjuAjeKrCH0FrK0yiHVQm+3PvYqU7N2wT70KH0f/lCQZgH+IObMlynpcU2qE
        LuE2rMdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxRua-0001Vp-0P; Mon, 20 Jul 2020 09:16:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 266A33010C8;
        Mon, 20 Jul 2020 11:16:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19135205A7673; Mon, 20 Jul 2020 11:16:39 +0200 (CEST)
Date:   Mon, 20 Jul 2020 11:16:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 12/17] memremap: Add zone device access protection
Message-ID: <20200720091639.GO10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-13-ira.weiny@intel.com>
 <20200717091053.GZ10769@hirez.programming.kicks-ass.net>
 <20200718050650.GT3008823@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718050650.GT3008823@iweiny-DESK2.sc.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:06:50PM -0700, Ira Weiny wrote:
> On Fri, Jul 17, 2020 at 11:10:53AM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 17, 2020 at 12:20:51AM -0700, ira.weiny@intel.com wrote:
> > > +static pgprot_t dev_protection_enable_get(struct dev_pagemap *pgmap, pgprot_t prot)
> > > +{
> > > +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> > > +		pgprotval_t val = pgprot_val(prot);
> > > +
> > > +		static_branch_inc(&dev_protection_static_key);
> > > +		prot = __pgprot(val | _PAGE_PKEY(dev_page_pkey));
> > > +	}
> > > +	return prot;
> > > +}
> > 
> > Every other pgprot modifying function is called pgprot_*(), although I
> > suppose we have the exceptions phys_mem_access_prot() and dma_pgprot().
> 
> Yea...  this function kind of morphed.  The issue is that this is also a 'get'
> with a corresponding 'put'.  So I'm at a loss for what makes sense between the
> 2 functions.
> 
> > 
> > How about we call this one devm_pgprot() ?
> 
> Dan Williams mentioned to me that the devm is not an appropriate prefix.  Thus
> the 'dev' prefix instead.
> 
> How about dev_pgprot_{get,put}()?

works for me, thanks!
