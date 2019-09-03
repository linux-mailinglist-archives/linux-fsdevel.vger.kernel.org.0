Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F246AA6207
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 08:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfICG6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 02:58:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfICG6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4hSYkiCPCpSgRGHZSvIjoW5chKDDuf7TDPZ/KesWimM=; b=rpXp0SPnAU2Bqz1hm0nm2/Yhf
        UNxaHXOTptV/vZxgW3l45UkXmbSzFCF6jpcGgR4N3NWzh00kL4gHglfJtSMHQvR60R6+PNJDDrW0d
        nlQ6UmPC6dG+rbeDzAOVh+DAfSlcO467RK/ptDPHANCLGc0TquzUn/UuPyqUQQAs9e/x7qVnC0pN5
        oGhHbdcJW7UypcG0tDscA3Rv00tKuFzAz15Ot23KmxGbbcv4gjTz0zF3F72iLahRGtWWNR3c8raTD
        m0dAbbkkgkLz1z+7Yy5HZ8Y5BF/zMkUDMO5uyeI7JxTtiMS8hPeSYqePPLoHLc+WsBf4OrHTAsIfJ
        W14CT7M+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i52lP-0003At-I5; Tue, 03 Sep 2019 06:58:03 +0000
Date:   Mon, 2 Sep 2019 23:58:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190903065803.GA11205@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190902124645.GA8369@infradead.org>
 <20190902142452.GE2664@architecture4>
 <20190902152323.GB14009@infradead.org>
 <20190902155037.GD179615@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902155037.GD179615@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 11:50:38PM +0800, Gao Xiang wrote:
> > > You means killing erofs_get_meta_page or avoid erofs_read_raw_page?
> > > 
> > >  - For killing erofs_get_meta_page, here is the current erofs_get_meta_page:
> > 
> > > I think it is simple enough. read_cache_page need write a similar
> > > filler, or read_cache_page_gfp will call .readpage, and then
> > > introduce buffer_heads, that is what I'd like to avoid now (no need these
> > > bd_inode buffer_heads in memory...)
> > 
> > If using read_cache_page_gfp and ->readpage works, please do.  The
> > fact that the block device inode uses buffer heads is an implementation
> > detail that might not last very long and should be invisible to you.
> > It also means you can get rid of a lot of code that you don't have
> > to maintain and others don't have to update for global API changes.
> 
> I care about those useless buffer_heads in memory for our products...
> 
> Since we are nobh filesystem (a little request, could I use it
> after buffer_heads are fully avoided, I have no idea why I need
> those buffer_heads in memory.... But I think bd_inode is good
> for caching metadata...)

Then please use read_cache_page with iomap_readpage(s), and write
comment explaining why your are not using read_cache_page_gfp.
