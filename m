Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3801F550839
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 06:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiFSEJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 00:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFSEJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 00:09:30 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AC5EE01
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 21:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NnRlbjha01+k+UZWPdmwf0ejV1URFcdY/c9rc9f4HlU=; b=rzqQvgL0eLnsD+tl6VP8eHU742
        YtTfS9bFZ03JZcSIftOVk4zDckVEMltqY4VYxnLhbdg/oRLKcw7LN0OOk/xHe9wUTSksn1pQCuOKS
        lwE7+feaEb7PL9gT+fb8zRNFqZ3oKchunXAds+foap9mURS7U1vW1NSTDrbNCMvsoRvLqWeIg+sqf
        yivZfWCalFYkS1Nks5irZCcA++AazupNvzsKIHSBGkUnFcSnH44D4dGuu7TSkNvLdZH2NDqWC9JI2
        +5GkE9eQyxzKlAal+ZdqAsk7YsskDDghHe9/cbXfL6VWB5VILCJ12HIWuDfxY21Ogj0jqdaDtVeng
        UVVZEmCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2mFZ-001wZS-1T;
        Sun, 19 Jun 2022 04:09:25 +0000
Date:   Sun, 19 Jun 2022 05:09:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 30/31] pipe_get_pages(): switch to append_pipe()
Message-ID: <Yq6hddBpTM0LG37+@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-31-viro@zeniv.linux.org.uk>
 <Yq6fmQOOhpAyIs3k@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq6fmQOOhpAyIs3k@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 19, 2022 at 05:01:29AM +0100, Al Viro wrote:
> On Sat, Jun 18, 2022 at 06:35:37AM +0100, Al Viro wrote:
> 
> >  		get_page(*p++ = page);
> > -		left -= size;
> 
> Argh...
> 		if (left <= PAGE_SIZE - off)
> 			return maxsize;
> > +		left -= PAGE_SIZE - off;
> >  	}
> >  	if (!npages)
> >  		return -EFAULT;
> > -	maxsize -= left;
> > -	iov_iter_advance(i, maxsize);
> > -	return maxsize;
> > +	return maxsize - left;
> >  }
> >  
> >  static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
> > -- 
> > 2.30.2
> > 

Might be better to have it return npages and let the caller do the usual
min(maxsize, npages * PAGE_SIZE - offset) song and dance...  Not sure.

Anyway, with these fixes it seems to survive xfstests and ltp without regressions
compared to mainline.  Updated branch force-pushed...
