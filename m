Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4713F28E591
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgJNRmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 13:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgJNRmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:42:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082CC061755;
        Wed, 14 Oct 2020 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N5SCUctooryolwHPCm/eaPiniU4nslCQLvVL8GRMMPE=; b=Nc/SMhiwi1YF/6L0yYbXv3s43a
        JZm89V8C74lfBiWNgv5Hq7T5THHPuaOQOapQYHXSbPK9qysoaGf18fBkJCIIw8TRkRuVqL+/iqz1E
        +Ycw8oXw5D+sTmZZMDJywSUG0DozxfB6spXavnr5NMR6njaFvxc6UvVYhBkxVY7+enq5rrBEB3g8X
        CIKbqk5IUUkcfnUyugWUVc2+UNNe3/+GZ7UrlSofnOL4spxFEnMckFwKnpCjOq4a5fVcr2mQxGmiR
        dKMkiqelTIM8REmIGJ20qmasTq1OPlcKdKrw5RvBi92LlF0pCRwTzAR0oFc2VWmCjl2dxFbANrh+L
        cYMC/NQA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSkmk-0005lv-Fc; Wed, 14 Oct 2020 17:41:58 +0000
Date:   Wed, 14 Oct 2020 18:41:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 09/14] iomap: Change iomap_write_begin calling convention
Message-ID: <20201014174158.GS20115@casper.infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-10-willy@infradead.org>
 <20201014164744.GK9832@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014164744.GK9832@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:47:44AM -0700, Darrick J. Wong wrote:
> > -static int
> > -iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> > -		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> > +static ssize_t iomap_write_begin(struct inode *inode, loff_t pos, loff_t len,
> > +		unsigned flags, struct page **pagep, struct iomap *iomap,
> 
> loff_t len?  You've been using size_t (ssize_t?) for length elsewhere,
> can't return more than ssize_t, and afaik MAX_RW_COUNT will never go
> larger than 2GB so I'm confused about types here...?

Yes, you're right.  This one should be size_t.

> >  	if (page_ops && page_ops->page_prepare) {
> > +		if (len > UINT_MAX)
> > +			len = UINT_MAX;
> 
> I'm not especially familiar with page_prepare (since it's a gfs2 thing);
> why do you clamp len to UINT_MAX here?

The len parameter of ->page_prepare is an unsigned int.  I don't want
a 1<<32+1 byte I/O to be seen as a 1 byte I/O.  We could upgrade the
parameter to size_t from unsigned int?

