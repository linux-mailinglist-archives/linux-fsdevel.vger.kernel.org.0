Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3591FA5A74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfIBPX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 11:23:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbfIBPX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qlt1XZvn+qXgX2CBCaJ2bCzou441y9kxu8YsfHGoCq0=; b=NCN9+wvdBIRI2Pfb0QIrDqKWa
        qHDXFSl8v9/HhWPrQ/KFTTKLr9x6MilMwRmZRtlpqvUzB91OTeE0EzFNVz6N84SRzAFGVCl5mK6F1
        MMXmumOBHphfa6vwNFPuxMkpT8P8DSD8LoROBqhL7pd3u+osqxIdiFgBpAojI6n2uNpqYfbKxnZbN
        Va5jRgrOJPmLpoSDQRd/VPVHigQ1Y9H3PH56mh20OIjulyQPprs/AaysOdvi0NrqLH2RtRHmF2fuK
        AaqYeJuBeFX2e1Bv39sBrB0YpPwcbtcT29m/uZlJ4ouiXq6EHJc8s4H+48oUyuNG2VToIoIVuRjci
        ILfA9cMow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4oAt-0006QV-Jw; Mon, 02 Sep 2019 15:23:23 +0000
Date:   Mon, 2 Sep 2019 08:23:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190902152323.GB14009@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190902124645.GA8369@infradead.org>
 <20190902142452.GE2664@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902142452.GE2664@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:24:52PM +0800, Gao Xiang wrote:
> > code quality stuff.  We're not addressing the issues with large amounts
> > of functionality duplicating VFS helpers.
> 
> You means killing erofs_get_meta_page or avoid erofs_read_raw_page?
> 
>  - For killing erofs_get_meta_page, here is the current erofs_get_meta_page:

> I think it is simple enough. read_cache_page need write a similar
> filler, or read_cache_page_gfp will call .readpage, and then
> introduce buffer_heads, that is what I'd like to avoid now (no need these
> bd_inode buffer_heads in memory...)

If using read_cache_page_gfp and ->readpage works, please do.  The
fact that the block device inode uses buffer heads is an implementation
detail that might not last very long and should be invisible to you.
It also means you can get rid of a lot of code that you don't have
to maintain and others don't have to update for global API changes.

>  - For erofs_read_raw_page, it can be avoided after iomap tail-end packing
>    feature is done... If we remove it now, it will make EROFS broken.
>    It is no urgent and Chao will focus on iomap tail-end packing feature.

Ok.  I wish we would have just sorted this out beforehand, which we
could have trivially done without all that staging mess.
