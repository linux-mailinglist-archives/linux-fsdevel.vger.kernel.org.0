Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705271B96D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgD0Fzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 01:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0Fzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:55:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4EC061A0F;
        Sun, 26 Apr 2020 22:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R3+pbJIQteflo4uZ0aWi5kA4IXjwF0WSfqzTyP9nDZg=; b=OUvliz3ACGuJUvGnnk2irZ8Szf
        9mbtz2wa6iso5Tmx8uHxbTcc5bK75uyEgtUyHO9bYMO6d9++UD8fKtQaSSHI7F0RO01IgnnrKrjxe
        Y6kY8Y0/Tpyz0sWBIo/Lkzxy9aO3E4QOvDjNGizxw1uwrMF53voV7aFTSzqJmpiXYURbw0jLz0SaS
        OMjV0MyEmIDXJoiRzUp65JvWRAc3qbuM44hKw5K6yzrggdfV/AJ1PuzY87hnexeytyes6F4F0Ics9
        8oHSLZIheBvCMwKDGTTjDSsCrgYJulBU3fvLUgxmvQ0ws5gVr8S+8e7lJ0atbqiyVHZpTZFhCvWh6
        i7BtMSRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSwk0-0007pN-6J; Mon, 27 Apr 2020 05:55:40 +0000
Date:   Sun, 26 Apr 2020 22:55:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH 6/9] iomap: use set/clear_fs_page_private
Message-ID: <20200427055540.GC16709@infradead.org>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-7-guoqing.jiang@cloud.ionos.com>
 <20200427002631.GC29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427002631.GC29705@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 26, 2020 at 05:26:31PM -0700, Matthew Wilcox wrote:
> On Sun, Apr 26, 2020 at 11:49:22PM +0200, Guoqing Jiang wrote:
> > @@ -59,24 +59,18 @@ iomap_page_create(struct inode *inode, struct page *page)
> >  	 * migrate_page_move_mapping() assumes that pages with private data have
> >  	 * their count elevated by 1.
> >  	 */
> > -	get_page(page);
> > -	set_page_private(page, (unsigned long)iop);
> > -	SetPagePrivate(page);
> > -	return iop;
> > +	return (struct iomap_page *)set_fs_page_private(page, iop);
> >  }
> 
> This cast is unnecessary.  void * will be automatically cast to the
> appropriate pointer type.

I also find the pattern eather strange.  A:

	attach_page_private(page, iop);
	return iop;

explains the intent much better.
