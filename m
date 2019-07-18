Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13896CE20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 14:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfGRMcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 08:32:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRMcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U9ARm0LHzsfKA/fjSbZXF/b4bcHB5wDhnFfsnrw0fBI=; b=cp/SpQku2srKdQX7oy4RTXMkH
        NfvQMoUrlVtu0cDrJFNXs5DJ52T2bzDEutYStQGvlfscwZD0J94qXqUe4OQeIeuTsEc+lfg+U5ohr
        ErJukIV2Lb3nSWlbeeK2svTXTnvclzv3JWdMyap6LNnDpP3mB+pSjADlbJ45zIjCwH2ItJQc8WHQh
        Etn8IB+NtK6+W/TM28fweYIHokPzrtLbWJzovnNdhk65ndrQNTyLWjd2znTyddJzVkqYTQti9Y7pu
        vMLlIAy0m9Yj7d5AIl9MHGiNcvvDwa1+c9cCYYmAdhYpbvR2ZBhhf6q7Yz8PnEiG4OkUi9H4Ay0b9
        gB+Nc9GRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1ho5Zj-0008QN-5Q; Thu, 18 Jul 2019 12:31:55 +0000
Date:   Thu, 18 Jul 2019 05:31:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gao Xiang <gaoxiang25@huawei.com>, chao@kernel.org
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing
 case
Message-ID: <20190718123155.GA21252@infradead.org>
References: <20190703075502.79782-1-yuchao0@huawei.com>
 <CAHpGcM+s77hKMXo=66nWNF7YKa3qhLY9bZrdb4-Lkspyg2CCDw@mail.gmail.com>
 <39944e50-5888-f900-1954-91be2b12ea5b@huawei.com>
 <20190711122831.3970-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711122831.3970-1-agruenba@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +iomap_to_bh(struct inode *inode, struct page *page, sector_t block,
> +		struct buffer_head *bh, struct iomap *iomap)
>  {
>  	loff_t offset = block << inode->i_blkbits;
>  
> @@ -1924,6 +1924,10 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>  				inode->i_blkbits;
>  		set_buffer_mapped(bh);
>  		break;
> +	case IOMAP_INLINE:
> +		__iomap_read_inline_data(inode, page, iomap);
> +		set_buffer_uptodate(bh);
> +		break;

I have to say I hate pushing this into the legacy buffer_head code.
My hope was that we could get rid of this code rather than adding to it.

The other issue is that this now calls iomap functions from buffer.c,
which I'd also really avoid.

That being said until the tail packing fs (erofs?) actually uses
buffer_heads we should not need this hunk, and I don't think erofs
should have any reason to use buffer_heads.

> +#define offset_in_block(offset, inode) \
> +	((unsigned long)(offset) & (i_blocksize(inode) - 1))

Make this an inline function, please.  I think we also have a few
other places that could make use of this helper, maybe it might
even go into fs.h.

Otherwise this looks sensible to me.
