Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F22F1B94B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 02:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgD0AMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 20:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbgD0AMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 20:12:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF94C061A0F;
        Sun, 26 Apr 2020 17:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sv3KzlHXHSNzqCfln1zX1+cYvetQ25Ui6UHInWko+bo=; b=rEb+lE/0+PtIQJdRbjS2xjuy+o
        oSuqS+/IwVu0sy4fCBtWk7SuEB22rklJevn4zj9wnt4SG9IaNVUSlQbdp8tLG4xGcFlChDqU9Hdp8
        LSZD0cVat+rHWqK4vYCIQfqKBNzpNloawwp5432WYgqdqYklL3xej2tZpQa1Z2c2Sp0vudw1U0aV2
        8YhjOjoLPsdQ1qmpE/Rtx5bn40vIsybG4bpGkMU6yNDtnIlstQZWDQrLFZ6QkdRS6odl8LuHfUAhS
        BxvVdaRF++aRN9IF/VQTPEUdZwxcmS2G+OtGu4bM+Q7fR0GRS+nF/Ppq/nR8Hzzsn9U0a5/b8liA8
        TBKguqDA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSrNy-0003Ft-9I; Mon, 27 Apr 2020 00:12:34 +0000
Date:   Sun, 26 Apr 2020 17:12:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: Re: [RFC PATCH 8/9] orangefs: use set/clear_fs_page_private
Message-ID: <20200427001234.GB29705@bombadil.infradead.org>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-9-guoqing.jiang@cloud.ionos.com>
 <20200426222455.GB2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426222455.GB2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:24:55AM +1000, Dave Chinner wrote:
> > @@ -460,17 +456,13 @@ static void orangefs_invalidatepage(struct page *page,
> >  
> >  	if (offset == 0 && length == PAGE_SIZE) {
> >  		kfree((struct orangefs_write_range *)page_private(page));
> > -		set_page_private(page, 0);
> > -		ClearPagePrivate(page);
> > -		put_page(page);
> > +		clear_fs_page_private(page);
> 
> Ditto:
> 		wr = clear_fs_page_private(page);
> 		kfree(wr);

You don't want to be as succinct as the btrfs change you suggested?

		kfree(clear_fs_page_private(page));

