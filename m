Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA011CB2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 11:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfLLKm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 05:42:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbfLLKm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G8moV6U9IyfN6eSPjxNYgUZFe+n4Kjcckdv5yKxVadk=; b=N1S01205tkf6X1x18eDtvPVFH
        jwgTUXcx0TJNgKI0sf1tt98Wt6WoslV3f5x5Ft9yw2IkHA9d6fyI5K5uMmubG0BNuGDJCo7rw1FuW
        X7VlrNSrgOKvaWHirz5lSv4BAm03ua/UCYEUfNoptanCEFkelZI4XiFoPwSaNNOMq2FPnhmfcqqX3
        2oT48kwmlMWrSsnw5VAOyXkkqP/j8nmnSotpg9W2e/xY45aJDScDMwZQTSH9yXHmhJsSAVH801TgX
        lQmHD1RUvEYLnqaNwG4/bbGmUF6dS+p0F6akYbSqfcm6mG+KIoTdm2HhgFF63ox7X4PCxNSkRkrrr
        MfwO79fQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifLvo-00057S-Rx; Thu, 12 Dec 2019 10:42:52 +0000
Date:   Thu, 12 Dec 2019 02:42:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [PATCH 15/15] gfs2: use iomap for buffered I/O in ordered and
 writeback mode
Message-ID: <20191212104252.GA3956@infradead.org>
References: <20191210101938.495-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210101938.495-1-agruenba@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:19:38AM +0100, Andreas Gruenbacher wrote:
> @@ -75,13 +75,12 @@ static int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head *dibh,
>  		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
>  		memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
>  		kunmap(page);
> -
> -		SetPageUptodate(page);
>  	}
>  
>  	if (gfs2_is_jdata(ip)) {
>  		struct buffer_head *bh;
>  
> +		SetPageUptodate(page);
>  		if (!page_has_buffers(page))
>  			create_empty_buffers(page, BIT(inode->i_blkbits),
>  					     BIT(BH_Uptodate));
> @@ -93,6 +92,9 @@ static int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head *dibh,
>  		set_buffer_uptodate(bh);
>  		gfs2_trans_add_data(ip->i_gl, bh);
>  	} else {
> +		iomap_page_create(inode, page);
> +		iomap_set_range_uptodate(page, 0, i_blocksize(inode));
> +		set_page_dirty(page);
>  		gfs2_ordered_add_inode(ip);
>  	}

Can you create a helper that copies the data from a passed in kernel
pointer, length pair into the page, then marks it uptodate and dirty,
please?

> @@ -555,6 +555,8 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
>  out_uninit:
>  	gfs2_holder_uninit(&gh);
>  	if (ret == 0) {
> +		if (!gfs2_is_jdata(ip))
> +			iomap_page_create(inode, page);

What is this one for?  The iomap_page is supposed to use lazy
allocation, that is we only allocate it once it is used.  What code
expects the structure but doesn't see it without this hunk?  I
guess it is iomap_writepage_map, which should probably just switch
to call iomap_page_create.

That being said is there any way we can get gfs2 to use
iomap_page_mkwrite for the !jdata case?
