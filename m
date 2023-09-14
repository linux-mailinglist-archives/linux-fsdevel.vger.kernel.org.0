Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47D17A0449
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbjINMsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 08:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjINMsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:48:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E561FD7;
        Thu, 14 Sep 2023 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vjEMrjw2C/jTAB+E0NqGEn/Bqv/9rRmcZIO86x/4wRQ=; b=B0sCLfazPBAGsbEZeWcayfQbh5
        uT0mKgzbqGikyzNOd3EyNLVgaNP6VulcWnXiG0IpVV8KYAauTyMc1A1MbG2depWPYn9cka8FXGrI7
        T+ZyjN1s0WHkKas/U48Gzlm2+qBVklO5o3Kl6TUDiHfi1YVCDLHs4WzUOmxecQc2+d56onboyan1J
        eGCUD0ziAW3lpO2vEHS8BZ2lkwOVwN2YLWT5hVhohCdsloTDVFsDAQlA5mZ3GEJcqJIq2xPg8sepN
        tPbZX0eKcfLx3DElFYlUWqUNTb6YNkEf0e2XBHvKKoTMG1h8wo29JhMGsWwjOghsu/CR0+QCi4KXB
        XLUXP8+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgllH-002y7n-2c; Thu, 14 Sep 2023 12:47:59 +0000
Date:   Thu, 14 Sep 2023 13:47:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, david@redhat.com, rdunlap@infradead.org,
        chenlinxuan@uniontech.com, yang.yang29@zte.com.cn,
        tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 1/1] mm: report per-page metadata information
Message-ID: <ZQMA/63agV42szfc@casper.infradead.org>
References: <20230913173000.4016218-1-souravpanda@google.com>
 <20230913173000.4016218-2-souravpanda@google.com>
 <20230913205125.GA3303@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913205125.GA3303@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:51:25PM +0300, Mike Rapoport wrote:
> > @@ -387,8 +390,12 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> >  
> >  	while (nr_pages--) {
> >  		page = alloc_pages_node(nid, gfp_mask, 0);
> > -		if (!page)
> > +		if (!page) {
> >  			goto out;
> > +		} else {
> > +			__mod_node_page_state(NODE_DATA(page_to_nid(page)),
> > +					      NR_PAGE_METADATA, 1);
> 
> We can update this once for nr_pages outside the loop, cannot we?

Except that nr_pages is being used as the loop counter.
Probably best to turn this into a normal (i = 0; i < nr_pages; i++)
loop, and then we can do as you say.  But this isn't a particularly
interesting high-performance loop.

