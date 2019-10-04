Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF7CC3A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 21:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfJDTga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 15:36:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDTg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a1QaMbENTx2wPCRJlxCQxSCl/1rs0+AA4qfie4ADJHU=; b=QP+yW2FQA9w7cQTmFlhqGcR/l
        S1y1iJhwiJIo8YrrDwUdT3axKcQdx4fbiRqzK4rfLxA/inEkVU7EvYfGpM1fkLwltZYt7TuVuo7Ls
        GIhSQpoW8xQDa3pZfcOpDyam5sLaPxL35T4UVXUuG859qDU704K1O7ErNbmmz++J/HkhsR+6bj6bQ
        1bdT+mnrtSh/2mabnjWC8kCF1MvnrRktjZiblFDitTir5E9BEV+AItxbmBGtF/x+FFX5sca+DWjfR
        mEUlqRom0O8praN5/Hqzi2Vye0nwRjHAXC4Fba/MvlYjwEL0bfvw6ERq+Ohr+X8ddikT+bv6li1OU
        E9UYqjG2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGTNN-0007ZI-ME; Fri, 04 Oct 2019 19:36:29 +0000
Date:   Fri, 4 Oct 2019 12:36:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] mm: Remove hpage_nr_pages
Message-ID: <20191004193629.GO32665@bombadil.infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
 <20191003050859.18140-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003050859.18140-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:08:59PM +0800, Hillf Danton wrote:
> 
> On Tue, 24 Sep 2019 17:52:02 -0700 From: Matthew Wilcox (Oracle)
> > 
> > @@ -354,7 +354,7 @@ vma_address(struct page *page, struct vm_area_struct *vma)
> >  	unsigned long start, end;
> > 
> >  	start = __vma_address(page, vma);
> > -	end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
> > +	end = start + page_size(page) - 1;
> > 
> > @@ -57,7 +57,7 @@ static inline bool pfn_in_hpage(struct page *hpage, unsigned long pfn)
> >  	unsigned long hpage_pfn = page_to_pfn(hpage);
> > 
> >  	/* THP can be referenced by any subpage */
> > -	return pfn >= hpage_pfn && pfn - hpage_pfn < hpage_nr_pages(hpage);
> > +	return (pfn - hpage_pfn) < compound_nr(hpage);
> >  }
> > 
> > @@ -264,7 +264,7 @@ int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma)
> >  	unsigned long start, end;
> > 
> >  	start = __vma_address(page, vma);
> > -	end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
> > +	end = start + page_size(page) - 1;
> > 
> >  	if (unlikely(end < vma->vm_start || start >= vma->vm_end))
> 
> Be certain that nothing is added other than mechanical replacings in
> the above hunks.

Are you saying I've made a mistake?  If so, please be clear.
