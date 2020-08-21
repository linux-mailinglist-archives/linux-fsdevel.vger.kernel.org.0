Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22A224D55F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 14:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgHUMs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 08:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgHUMs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:48:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01174C061385;
        Fri, 21 Aug 2020 05:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BGM5ZvRWq1tHvEi5qIUzOP5QdqrrvuPPh/jW7ffuOuY=; b=oamX2t9TrjIA63ujaKlq2z9qZr
        6cO7BrVvfkxVp0QJCArzLkx9y+EnmYgRaoQ7ReFJI9LxdigKyN8hUuvDiDo1Ohxox65Y6m5pIjwuv
        bNYKwBcCKBDeXDd6LL8CWTYPR6FHN1TQ1YnVRcwLmhLrqdCcdhLggJ9kJhKOWdA1wZ2mPlLrFpQur
        uM2vTfA3pbsUKD1WdnJaQHXqto4kJSQ3s7sIYPyhe4bTHfXIJXWzb2SDmKrELIk7JbVVb3YrEa77u
        UTt8UFwCip6e0PvUGu49luapWDI+W6MhcOVVxyjiE1bDWA8FLpuROyESwTbH2IDMFSWFEUvlvbh7e
        OuCIRosA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k96TU-0002qL-Pw; Fri, 21 Aug 2020 12:48:52 +0000
Date:   Fri, 21 Aug 2020 13:48:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>, hch@infradead.org,
        darrick.wong@oracle.com, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 3/3] iomap: Support arbitrarily many blocks per page
Message-ID: <20200821124852.GR17456@casper.infradead.org>
References: <20200821124424.GQ17456@casper.infradead.org>
 <20200821124606.10165-1-willy@infradead.org>
 <20200821124606.10165-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821124606.10165-3-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 01:46:06PM +0100, Matthew Wilcox (Oracle) wrote:
> @@ -45,11 +46,13 @@ static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
> +	unsigned int nr_blocks = i_blocks_per_page(inode, page);
>  

i_blocks_per_page isn't part of this series.  It's here:

http://git.infradead.org/users/willy/pagecache.git/commitdiff/e3177f30c0d0906bec49586a86704a2a5736b6c3
