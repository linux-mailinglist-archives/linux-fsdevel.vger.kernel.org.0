Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B828A5ACC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfIBPvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 11:51:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbfIBPvf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:51:35 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id D87F48830A7DEFEEDC58;
        Mon,  2 Sep 2019 23:51:29 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 23:51:29 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 23:51:29 +0800
Date:   Mon, 2 Sep 2019 23:50:38 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190902155037.GD179615@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190902124645.GA8369@infradead.org>
 <20190902142452.GE2664@architecture4>
 <20190902152323.GB14009@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902152323.GB14009@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 02, 2019 at 08:23:23AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 10:24:52PM +0800, Gao Xiang wrote:
> > > code quality stuff.  We're not addressing the issues with large amounts
> > > of functionality duplicating VFS helpers.
> > 
> > You means killing erofs_get_meta_page or avoid erofs_read_raw_page?
> > 
> >  - For killing erofs_get_meta_page, here is the current erofs_get_meta_page:
> 
> > I think it is simple enough. read_cache_page need write a similar
> > filler, or read_cache_page_gfp will call .readpage, and then
> > introduce buffer_heads, that is what I'd like to avoid now (no need these
> > bd_inode buffer_heads in memory...)
> 
> If using read_cache_page_gfp and ->readpage works, please do.  The
> fact that the block device inode uses buffer heads is an implementation
> detail that might not last very long and should be invisible to you.
> It also means you can get rid of a lot of code that you don't have
> to maintain and others don't have to update for global API changes.

I care about those useless buffer_heads in memory for our products...

Since we are nobh filesystem (a little request, could I use it
after buffer_heads are fully avoided, I have no idea why I need
those buffer_heads in memory.... But I think bd_inode is good
for caching metadata...)

> 
> >  - For erofs_read_raw_page, it can be avoided after iomap tail-end packing
> >    feature is done... If we remove it now, it will make EROFS broken.
> >    It is no urgent and Chao will focus on iomap tail-end packing feature.
> 
> Ok.  I wish we would have just sorted this out beforehand, which we
> could have trivially done without all that staging mess.

Firstly, I'd like to introduce EROFS as a self-contained
filesystem to introduce new fixed-sized output compression
to upstream and promote it...

And then we can do many improvements for EROFS in parallel...
(if we introduce EROFS and touch many core modules like
iomap, mm readahead code or modify LZ4 code at once...
It could be more careful... Let's improve it step-by-step...
We are a dedicated team if the Linux community needs us,
we will still here... It will be actively maintained.)

Thanks,
Gao Xiang


