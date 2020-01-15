Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91B113BA70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 08:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgAOHoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 02:44:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOHoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ctm/g+NZQYltLbHvtUEEJZpfTsIztBgG6NKt7IazLOU=; b=CLFSx02/zlch79fq9AQXeHkLp
        7eHHY82B+pgRluHiAR+e1E+canab9O4fvnDMsMtojQfdx3huD/zbgsRtKJhpIJkGqjugJC+VdZ+YH
        KbbAKdHokLl+oX8d4/IR7ysQOl1QqQwXWq6YtWKFdCUfbDlKvCi6M0cp52N4KBkoRLB+rSV427OXK
        X4MtoAlVeC9oTWNjpn9ncIl1JeDP8cjkb2TWK43i/hjAJGjRo6Yvdse2gVCAnPdfw5XosxxKdSOwF
        Xpf09JgLfxmA0mnmWc27GfYXgpuUxAyEjCUz9jWk2Di2pnHz5Qy9vbRY708ngAUZ5DIq3ksRk/o2a
        np2lL5EmQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irdLt-0001iI-Tm; Wed, 15 Jan 2020 07:44:33 +0000
Date:   Tue, 14 Jan 2020 23:44:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2 9/9] mm: Unify all add_to_page_cache variants
Message-ID: <20200115074433.GB31744@bombadil.infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200115023843.31325-10-willy@infradead.org>
 <20200115072004.GB3460@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115072004.GB3460@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 11:20:04PM -0800, Christoph Hellwig wrote:
> On Tue, Jan 14, 2020 at 06:38:43PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > We already have various bits of add_to_page_cache() executed conditionally
> > on !PageHuge(page); add the add_to_page_cache_lru() pieces as some
> > more code which isn't executed for huge pages.  This lets us remove
> > the old add_to_page_cache() and rename __add_to_page_cache_locked() to
> > add_to_page_cache().  Include a compatibility define so we don't have
> > to change all 20+ callers of add_to_page_cache_lru().
> 
> I'd rather change them.  20ish isn't that much after all, and not
> keeping pointless aliases around keeps the code easier to read.

Almost all of them are called in the ->readpages() function, so they'll
go away as filesystems are converted to ->readahead().  I'd rather not
introduce something that makes patches harder to reorder.
