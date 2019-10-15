Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63853D71C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 11:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfJOJGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 05:06:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfJOJGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ScswIQBKRvt0vRsU+j1tcLpW9Xtj3tO8tiUdFEtFncw=; b=mx7Pn28BaLko9nhuopP5CjmAZ
        c0NR8SjdPO028AWHpFt8T20vSMOa59P08xerMLYBNlnq9YpxRJ+vmJAIfzjYkY2uuIeX2he2egxB2
        noiYpHi8/QDXc6JcoyPP+pm0JUiGpDpliXqgnOY0HDZsJ3SYsjbcXWOHEEwbE7+OJ53Hu686pEMpj
        43VaeVPWDQ06xDlYxVLIH04TtxFfz+D1vrntD1Hnz0UQPOEPiK9e1EzT4tsRZ2hAkZmM9FR5HjXwR
        +USSticjJnYKBA4kzR61H5qkSmVHCBOqWXe2m3y+WKBxYHExW2GaA9xh4Xwyyqc6aqMfPuJDsDoqT
        Zez0/lrzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKImv-0003Fs-9l; Tue, 15 Oct 2019 09:06:41 +0000
Date:   Tue, 15 Oct 2019 02:06:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] mm, swap: disallow swapon() on zoned block devices
Message-ID: <20191015090641.GB7199@infradead.org>
References: <20191015043827.160444-1-naohiro.aota@wdc.com>
 <20191015085814.637837-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015085814.637837-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:58:14PM +0900, Naohiro Aota wrote:
> A zoned block device consists of a number of zones. Zones are either
> conventional and accepting random writes or sequential and requiring that
> writes be issued in LBA order from each zone write pointer position. For
> the write restriction, zoned block devices are not suitable for a swap
> device. Disallow swapon on them.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> v2: add comments according to Christoph's feedback, reformat chengelog.
> ---
>  mm/swapfile.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index dab43523afdd..f2c4224d1f8a 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2887,6 +2887,14 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>  		error = set_blocksize(p->bdev, PAGE_SIZE);
>  		if (error < 0)
>  			return error;
> +		/*
> +		 * Zoned block device contains zones that have
> +		 * sequential write only restriction. For the restriction,
> +		 * zoned block devices are not suitable for a swap device.
> +		 * Disallow them here.
> +		 */
> +		if (blk_queue_is_zoned(p->bdev->bd_queue))

Please use up all 80 chars per line  Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
