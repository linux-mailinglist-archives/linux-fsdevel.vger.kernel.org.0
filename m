Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE341A6CF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfICPhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 11:37:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICPhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TOMcH7snttb2Sr7cqyYUxOSzNPnn0zJCorjl1PxxkD8=; b=iPZa9nn0+EclNXulN9PX55CfF
        gjiZ/RcbonRlNHqkBzmGEe6Ioj+rAZKWUTmZvc8doirxhztv7FprjyzD7VGiWIB7qATK55E7i7a1x
        TmDqOuFRVBJbmG60tr0ElwbLZ46pwJskgV7Cz8NNRFQitmpy5Nz/lO1P2FXCuvPwzYgXor8S0FMf6
        LAmnu/Qk8ARcx6Ev1/WBOUwEB1FDGT6iVSDqwPmo763jvjWRJqLnfmylBY0Mx+wmdggFpEJOWd14L
        UHDHQLEhg+ERlFoN1IzFKJI+sahK6t1WEtjnYNVxM2f8AqkTLjGHcU8IooYs/dyfk3rjjLyTwS9xf
        nr5m+CE5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Arg-0000dg-Ql; Tue, 03 Sep 2019 15:37:04 +0000
Date:   Tue, 3 Sep 2019 08:37:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190903153704.GA2201@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190902124645.GA8369@infradead.org>
 <20190902142452.GE2664@architecture4>
 <20190902152323.GB14009@infradead.org>
 <20190902155037.GD179615@architecture4>
 <20190903065803.GA11205@infradead.org>
 <20190903081749.GA89379@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903081749.GA89379@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:17:49PM +0800, Gao Xiang wrote:
> I implement a prelimitary version, but I have no idea it is a really
> cleanup for now.

The fact that this has to guess the block device address_space
implementation is indeed pretty ugly.  I'd much prefer to just use
read_cache_page_gfp, and live with the fact that this allocates
bufferheads behind you for now.  I'll try to speed up my attempts to
get rid of the buffer heads on the block device mapping instead.
