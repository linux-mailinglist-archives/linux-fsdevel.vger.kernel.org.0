Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2589D20D2D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgF2Swo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbgF2Swl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:41 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCF7C030F14
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PM2ctrNamI+FuCpU5ETwwiM78ezO5gsP8HYNzHGPK0g=; b=SqTiqegEftG01FRCWEr7nyvyYH
        x89Sbz8RMBrBwBK6WIffkxlZP36qXgEAsMeZOWx7/ZKU/+Ty9dPzhrmFe5Zy6vyOyMHnlGI+2cymu
        gwExiSBJV0sTO1HkpM/qg4TnH8XXBZ8sZhrRFH4zLtZFd6slTOWVsjMnUk7JXIydEwOPy9x7tMhEh
        CGq9uuvGwU9ojXVhvAKizOgwL2PbRLowD4h84hyX2CZL85haOroMg7Wxg1kGnxqdvprGRf1T/XhUz
        5gybG0fReig7OrRpC36+52r0GCUI8TDV/VM6YIlgC6E7kYPYEZ2XPyltmwtgRWkP+uk7hgW6RQVIe
        9qKf39jg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpwZh-0008Uy-LK; Mon, 29 Jun 2020 16:24:05 +0000
Date:   Mon, 29 Jun 2020 17:24:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] mm: Store compound_nr as well as compound_order
Message-ID: <20200629162405.GF25523@casper.infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
 <20200629151959.15779-2-willy@infradead.org>
 <20200629162227.GF2454695@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629162227.GF2454695@iweiny-DESK2.sc.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:22:27AM -0700, Ira Weiny wrote:
> On Mon, Jun 29, 2020 at 04:19:53PM +0100, Matthew Wilcox wrote:
> >  static inline void set_compound_order(struct page *page, unsigned int order)
> >  {
> >  	page[1].compound_order = order;
> > +	page[1].compound_nr = 1U << order;
>                               ^^^
> 			      1UL?
> 
> Ira
> 
> > +++ b/include/linux/mm_types.h
> > @@ -134,6 +134,7 @@ struct page {
> >  			unsigned char compound_dtor;
> >  			unsigned char compound_order;
> >  			atomic_t compound_mapcount;
> > +			unsigned int compound_nr; /* 1 << compound_order */

                        ^^^^^^^^^^^^

No

