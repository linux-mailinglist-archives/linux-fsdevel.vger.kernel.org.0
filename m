Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5A81DDAEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 01:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgEUXal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 19:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbgEUXal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 19:30:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66914C061A0E;
        Thu, 21 May 2020 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RhE3yWup8bHUwtywMD5yH07SvtWjgpVhodD0ZZuomP0=; b=N5J5du6CShT9yrhCSYdsYxYRZg
        +xctwrcmgRx7E1WIBTd/kqRzdaaqMPw+9dL390Bga2Heo3zXhU2LR4FV3JcGqHZ/tIOY7aOQIGWdJ
        lCjCZC4TxxVYTHhj8KEDMc3pN1/DYq18prmZ7q8uFBtu5vy51KaJnOt/Zy3a3AphyIw+LeynfQRb7
        rRQXvzpR1ssWXjzj5CnnIWICS++w+/2aUGu1V5ZwVoFHPG0P+h8JQKNumwr76fbQyqssJ7y9a3rx9
        hHVryxdOhYpFD7b2qT4f39LFXvmWAnXhhfnfP9rIl+vTKYC9z7m8sbbIcQh7pgIP+CotEMMe1Dyzz
        m6wB7xaQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbue9-0000Na-6b; Thu, 21 May 2020 23:30:41 +0000
Date:   Thu, 21 May 2020 16:30:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v4 10/36] fs: Make page_mkwrite_check_truncate thp-aware
Message-ID: <20200521233041.GG28818@bombadil.infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-11-willy@infradead.org>
 <20200521220139.GS2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521220139.GS2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 08:01:39AM +1000, Dave Chinner wrote:
> On Fri, May 15, 2020 at 06:16:30AM -0700, Matthew Wilcox wrote:
> >  	if (page->mapping != inode->i_mapping)
> >  		return -EFAULT;
> >  
> >  	/* page is wholly inside EOF */
> > -	if (page->index < index)
> > -		return PAGE_SIZE;
> > +	if (page->index + hpage_nr_pages(page) - 1 < index)
> > +		return thp_size(page);
> 
> Can we make these interfaces all use the same namespace prefix?
> Here we have a mix of thp and hpage and I have no clue how hpages
> are different to thps. If they refer to the same thing (i.e. huge
> pages) then can we please make the API consistent before splattering
> it all over the filesystem code?

Yes, they're the same thing.  I'll rename hpage_nr_pages() to thp_count().
