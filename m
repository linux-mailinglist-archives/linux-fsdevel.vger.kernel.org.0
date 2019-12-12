Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6566811CA06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 10:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfLLJ5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 04:57:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfLLJ5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xUz5jp9wumbgxgXajadYaCIzlGaUVbNhJG7drFWZvwY=; b=PpXCxCdot121DV+jWnxYXGQ8M
        XywA0K4hu3hABEG5nyvkPb54B/Ip01DJ/eU3DAiy88GPbd2BHEe6AIC/i6Q4yFcflp9opsiZTs24q
        xyw09DsippfLHlSDUy5b3P6P36wU7JnWu/4DvDfmjYKzujH7IEM0S89xS+WruXGGOdq6YFHAAs20w
        wCL9MS9+0PC0v+mKG9hmnqKb69bvLtG4wHiLm0t49pYLsX1LJnYJekRpUMIqJA9LPZXqXs6iVf2+l
        pHFIuiiYlxSGs7AQCC28B6YQzzBUgTzoPSEoWubfYEBfM98rhQQ1aWeK/QIfL7fIN1TvAGCY01GO3
        7eGethBLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifLEG-0008Tv-J9; Thu, 12 Dec 2019 09:57:52 +0000
Date:   Thu, 12 Dec 2019 01:57:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, dsterba@suse.cz,
        nborisov@suse.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191212095752.GA31597@infradead.org>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
 <20191212003043.31093-4-rgoldwyn@suse.de>
 <20191212094940.GC15977@infradead.org>
 <3f945449-bdd8-e9d7-5db9-5a565b8fc2af@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f945449-bdd8-e9d7-5db9-5a565b8fc2af@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:56:48AM +0100, Johannes Thumshirn wrote:
> On 12/12/2019 10:49, Christoph Hellwig wrote:
> >> @@ -8230,9 +8228,8 @@ static void btrfs_endio_direct_read(struct bio *bio)
> >>  	kfree(dip);
> >>  
> >>  	dio_bio->bi_status = err;
> >> -	dio_end_io(dio_bio);
> >> +	bio_endio(dio_bio);
> >>  	btrfs_io_bio_free_csum(io_bio);
> >> -	bio_put(bio);
> > 
> > I'm not a btrfs export, but doesn't this introduce a use after free
> > as bio_endio also frees io_bio?
> 
> No that's ok, as the bio_endio() frees the dio_bio, while
> btrfs_io_bio_free_csum() frees the csum of the io_bio (which is a struct
> btrfs_io_bio).

So who frees the io_bio and its embedded bio?
