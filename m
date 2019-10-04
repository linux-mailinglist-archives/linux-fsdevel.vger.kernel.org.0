Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F46FCC3AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 21:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfJDTjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 15:39:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDTjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Dh6mxesa35qmVcJTZmiFw6dhEr9tO5B4IZfYPNiUpao=; b=ad3GJvszIb6b9FflfqMXULYkw
        E5JOdU7XF2SecosMbmOk8xCCOzS15A09lBRxi0UcSiu16qKuCDnzY1eXwaTrB/6oH/uTfSfG152Kp
        sXJwbgMShnInObtdWqPjgutj+FQ58bGUJIxNt1z0YpEQT2rWeeB0Z85s1MRiOPDGoDskGXUl1/Mdz
        G0TIKEc46kuQasDEv83v+M7kT1sCT5/FVbuNwqN2VBf8qYcVcXLlOLH9j9Ya52jO3DPxNchG8KBiZ
        E9hhKKNjoNKrY3R1kfVBAFeJkPPadPDflhgxAj6qeYgDq8IT9Jvkaxre2VLJqRCMZTKC4pthIFRH4
        InXprJIjA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGTQ0-0007ms-OK; Fri, 04 Oct 2019 19:39:12 +0000
Date:   Fri, 4 Oct 2019 12:39:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] mm: Add file_offset_of_ helpers
Message-ID: <20191004193912.GP32665@bombadil.infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-4-willy@infradead.org>
 <20190926140211.rm4b6yn2i5rlyvop@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926140211.rm4b6yn2i5rlyvop@box>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:02:11PM +0300, Kirill A. Shutemov wrote:
> On Tue, Sep 24, 2019 at 05:52:02PM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > The page_offset function is badly named for people reading the functions
> > which call it.  The natural meaning of a function with this name would
> > be 'offset within a page', not 'page offset in bytes within a file'.
> > Dave Chinner suggests file_offset_of_page() as a replacement function
> > name and I'm also adding file_offset_of_next_page() as a helper for the
> > large page work.  Also add kernel-doc for these functions so they show
> > up in the kernel API book.
> > 
> > page_offset() is retained as a compatibility define for now.
> 
> This should be trivial for coccinelle, right?

Yes, should be.  I'd prefer not to do conversions for now to minimise
conflicts when rebasing.

> > +static inline loff_t file_offset_of_next_page(struct page *page)
> > +{
> > +	return ((loff_t)page->index + compound_nr(page)) << PAGE_SHIFT;
> 
> Wouldn't it be more readable as
> 
> 	return file_offset_of_page(page) + page_size(page);
> 
> ?

Good idea.  I'll fix that up.
