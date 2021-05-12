Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3237B4A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 05:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELDkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 23:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhELDkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 23:40:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83A7C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 20:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z81zFfDbHvSBXYaN37BiINzs0xNphc/huvF7lVWQMLg=; b=Y+7qa1HD1P+Ab3uJT25iunfmtX
        uXSVnfnwxvWZo51hWgtJ4McOXGilbkXjGEMdIiQeIQPeHhu6n7+JOBG29ucCohRFzCv4ipG2PTYW+
        oEcHhEQFfzWp1njZ24cy7BZ1kGjoRIIP43dyxA9Q7SAQVrCO9nWg6PiJGVxxP+xRDsAeyp7YYhHOz
        OWH3OrMxxcJhgz8XY63Bh9jDrcuDEdlnRCoq1UV7cmeknz2bSKfd2OVcixEf8Sm68E264A8nOv3qE
        cPDW6jvyCDa0Zsowx6FwA/9I2qXUBJLb89d4FbJHTBHhEOHiwKZytxmiSHNp6CBjUUHDXr9Q1hpxF
        wfS3NfjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgfhs-007uLE-TT; Wed, 12 May 2021 03:38:56 +0000
Date:   Wed, 12 May 2021 04:38:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 3/8] mm/debug: Factor PagePoisoned out of __dump_page
Message-ID: <YJtNxP5I8auBg/XL@casper.infradead.org>
References: <20210430145549.2662354-1-willy@infradead.org>
 <20210430145549.2662354-4-willy@infradead.org>
 <2baf684e-f35d-5c42-fa11-1e061a12a81f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2baf684e-f35d-5c42-fa11-1e061a12a81f@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 11:29:06AM +0800, Kefeng Wang wrote:
> >   void dump_page(struct page *page, const char *reason)
> >   {
> > -	__dump_page(page, reason);
> > +	if (PagePoisoned(page))
> > +		pr_warn("page:%p is uninitialized and poisoned", page);
> > +	else
> > +		__dump_page(page);
> 
> Hi Matthew, dump_page_owenr() should be called when !PagePoisoned, right?
> 
> 
> > +	if (reason)
> > +		pr_warn("page dumped because: %s\n", reason);
> >   	dump_page_owner(page);
> >   }
> >   EXPORT_SYMBOL(dump_page);

dump_page_owner() is called whether the page is Poisoned or not ...
both before and after this patch.  Is there a problem with that?

