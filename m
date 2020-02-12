Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B7A15A25D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgBLHqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:46:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgBLHqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0qAlCbTxTuvLnu+BueYLiV2ElHlLiKxhWPmCVAC5zfM=; b=VJYJ5W0eKdurn6rD14NUB2kUlu
        0nMU73wpP/6Ys1UoK+t/7DHqlIWjGY1AtEK25G1tUlQ2RxsOVJ/UtPpcCKbuT86lkE2Zaz9l037DY
        5JmHsPurg+eM8W1ET6hhQ+jgPjkI/km38elKZiyYsCNUMu8zpzVAjEAL8VbBolGy4fH3zM+zhjuzj
        dTRPy6ODmxpEs8297wxxxrSu5W2mBAM9IxjVsl0rz375n8CoPOtN7wW3QN4MvBNy3+WNy2saCBjCN
        GuBQHqhySq5c6167/pqRKbSefRVGNCEHcy8mQyH0KiAsPOuUnfAFJSAA2n7HOGpYUxXB5OUSpI2tF
        9EUbjOKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mjB-0001vK-T4; Wed, 12 Feb 2020 07:46:33 +0000
Date:   Tue, 11 Feb 2020 23:46:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/25] mm: Add file_offset_of_ helpers
Message-ID: <20200212074633.GI7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -978,8 +978,6 @@ static int ibmveth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  	return -EOPNOTSUPP;
>  }
>  
> -#define page_offset(v) ((unsigned long)(v) & ((1 << 12) - 1))

This one realy should be killed off in a separate patch, it has nothing
to do with the kernel-wide page_offset.

> +/* Legacy; please convert callers */
> +#define page_offset(page)	file_offset_of_page(page)

I'd say send a script to Linus to conver it as soon as the change is
in.
