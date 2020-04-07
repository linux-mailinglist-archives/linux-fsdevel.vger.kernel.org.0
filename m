Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4291A1208
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDGQsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 12:48:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgDGQsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e8b1O8jV+JN/uoUxKnD8m+97vHPiluoR2Ew7ifP7Ph4=; b=P6aTtaImf8AXFV94wCyXBfvy7u
        6YsPGYrcSmuwcGdCYDx+lBDezD0WKe7gb7jeeRqsjZQsn+/fIJ5g5IZwtFbPZETf3ODkDN/eoUcFT
        uXeQfAebQqv1r7mmtiAbDNbOhV0hOTuNKFQ0+y42ywO9WSIFmLH0l5CyKK+I5wGD/NfpPRQdeWFq/
        tiZeumiERpRjxMWWiWK8wfnxWbNFotAwMIvMVzs3gajTJEzB7pdFTiQX1XeT7tarC/NLii2dwV16e
        hpFs3wYtkJDFHR0YOCcMoYOFNar0tjLtBlWrnKLTqbRWUYTDTK0C93sgGadze7gr++yDDYQB4A6MB
        WO+0TNEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLrOb-0004r7-6s; Tue, 07 Apr 2020 16:48:17 +0000
Date:   Tue, 7 Apr 2020 09:48:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 02/10] block: Introduce REQ_OP_ZONE_APPEND
Message-ID: <20200407164817.GA13893@infradead.org>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403101250.33245-3-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -927,6 +970,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	ssize_t size, left;
>  	unsigned len, i;
>  	size_t offset;
> +	unsigned op = bio_op(bio);
>  
>  	/*
>  	 * Move page array up in the allocated memory for the bio vecs as far as
> @@ -944,13 +988,20 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		struct page *page = pages[i];
>  
>  		len = min_t(size_t, PAGE_SIZE - offset, left);
> +		if (op == REQ_OP_ZONE_APPEND) {
> +			int ret;
>  
> +			ret = bio_add_append_page(bio, page, len, offset);
> +			if (ret != len)
> +				return -EINVAL;

I think zone append needs the same try to merge logic to deal with
page refcounts doesn't it?
