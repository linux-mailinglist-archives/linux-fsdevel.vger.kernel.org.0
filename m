Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61E3D517B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 05:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhGZC1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 22:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhGZC1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 22:27:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA1EC061757;
        Sun, 25 Jul 2021 20:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AYpWJ6BCk5U3aPIE349DotIfhgOJ6VkVS2u6igeGNOc=; b=v5neQT1bwQasHW8elIq7v7bG1k
        UjsJQU2W8X6j6pGh5eKYSm+TC6bwPG8oRAKCcPTTs5P4VZrMhIV93euz9UejW4XLyeuOxRtSlMjqm
        mjes2ySsvSeSF6SnoDH27Bis/HmyMhfRdYwf1pXH0313pz++IMJiyckG7Sls8zfvjzrOilz2KezNc
        riaQ+fvwb/VcTEc9RcFAkRvP9F2ZsAulAAg3j4Ad29mHB3OMaVY0jvofyDSpPr825QPEi7zyAqFSF
        +7qEuQBBW5tDv/PuoDk7AgVOUBBE1G1LHWEF2XAdt7Y8el6vN9xhrhsO3+2G6fCdVLdPeqPZJ4K3t
        kaJ+RPBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7qxA-00DYCU-Cq; Mon, 26 Jul 2021 03:06:54 +0000
Date:   Mon, 26 Jul 2021 04:06:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YP4mzBixPoBgGCCR@casper.infradead.org>
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725221639.426565-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> @@ -247,7 +251,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	sector_t sector;
>  
>  	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
>  		iomap_read_inline_data(inode, page, iomap);
>  		return PAGE_SIZE;

This surely needs to return -EIO if there was an error.

