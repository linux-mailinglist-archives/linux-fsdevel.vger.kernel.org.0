Return-Path: <linux-fsdevel+bounces-2393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B57E599E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D041C2087B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43730323;
	Wed,  8 Nov 2023 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TU1MDXlL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FD2FE39
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 14:59:56 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB421BE4
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 06:59:56 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231108145954euoutp01caf903cb69e4c2181b02ba583d3dedeb~VrdvmxtNg2876028760euoutp01a
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 14:59:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231108145954euoutp01caf903cb69e4c2181b02ba583d3dedeb~VrdvmxtNg2876028760euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699455594;
	bh=NApL8B7nte/YmWD26fSdgwZvvm1AYprOAtO/0MTGZLE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TU1MDXlLSyZij8KDEG5HyxEzr6ElA8CFWZr8TylF4GznkEWmRyeej7CoFAEmrDGwU
	 8/1kJpCtpwXBKQFCsAFzZtmpVuCWq4QNmgczg+cB7Xlc1iUyOa54dIYp6tnHTJDf1U
	 dgZYvYYb0YWkyz7/mJfyIw9WGwaI/Km0MrTMuh+0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231108145954eucas1p2db8e2682bc3d280dee7ae997b1c0ab29~VrdvgKKtT2518425184eucas1p2i;
	Wed,  8 Nov 2023 14:59:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 0E.FE.52736.A62AB456; Wed,  8
	Nov 2023 14:59:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231108145953eucas1p2eeaf54e93c10cbf501a43f594e23438a~VrdvMZLqX2696526965eucas1p2Y;
	Wed,  8 Nov 2023 14:59:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231108145953eusmtrp2a2c373829523d9aefce7ec64c8041686~VrdvLpDRs3275132751eusmtrp2T;
	Wed,  8 Nov 2023 14:59:53 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000ce00-56-654ba26ad6b0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CD.C5.10549.962AB456; Wed,  8
	Nov 2023 14:59:53 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231108145953eusmtip275b9d57af8f64543bbdbf0f3ff0d6c4f~VrdvBFaJ_0066400664eusmtip2R;
	Wed,  8 Nov 2023 14:59:53 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 8 Nov 2023 14:59:52 +0000
Date: Wed, 8 Nov 2023 15:59:51 +0100
From: Pankaj Raghav <p.raghav@samsung.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke
	<hare@suse.de>, Luis Chamberlain <mcgrof@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <p.raghav@samsung.com>
Subject: Re: [PATCH 2/5] buffer: Calculate block number inside
 folio_init_buffers()
Message-ID: <20231108145951.a7o3uld7nd5icslf@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231107194152.3374087-3-willy@infradead.org>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOd2sRd6pBsvP8VjMWb+GzWLPoklM
	Fnv2nmSxuDHhKaPF7x9z2BxYPTav0PLYtKqTzePEjN8sHptPV3t83iQXwBrFZZOSmpNZllqk
	b5fAlXF4X1TBYYmKKRsvszcwXhLuYuTkkBAwkfjScpO9i5GLQ0hgBaPE5okXWCGcL4wSO3q3
	sEA4nxklllxazAjT8vj7TKjEckaJXd+PsIMkwKr+PcqBSGxmlPhy8w1YgkVARWLPzi9A3Rwc
	bAJaEo2dYGERAWOJicv3s4HUMwtsYJT49X8jWEJYIFTi6d8vbCA2r4C5xJIrRxkhbEGJkzOf
	sIDYzAI6Egt2f2IDmcksIC2x/B8HSJhTwFpi7vG9UIcqSTRsPsMCYddKnNpyiwlkl4TADQ6J
	pY+aoBIuEocWLGKFsIUlXh3fwg5hy0j83zmfCcKulnh64zczRHMLo0T/zvVgiyWAtvWdyYGo
	cZTYtmw3E0SYT+LGW0GIM/kkJm2bzgwR5pXoaBOCqFaTWH3vDcsERuVZSB6bheSxWQiPLWBk
	XsUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYUE7/O/51B+OKVx/1DjEycTAeYpTgYFYS
	4f1r75EqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwGTq
	8KiDs2Xa9w9rcyLP3baa/LH20t5Z+2LfzxLP+8TxW/bL9VVLr/etOd3p1WC24+alJcGTow3n
	xfE+cTqhEMK++Leg6Bst11CPjqdyLdrz480/OPz+x7Zf3PtXGQPPosgP69YLZ9pqTzu+c7NG
	/kwpnlZmkY5/iqcVpLc3+Rfp7U+/JOHEoKZ04YGy4Dq+BxqpzXeuv2FV1J1yX2HN/I5z+332
	hFs/dJZX2hR8S+XHQabvOzUZM7aeFrCw3hYfvNlrk5cOH2ev0lyb9wwBmcdFX4U/mftN6G/G
	bcvTyR3NUhvDW4481KyY/fldK3OI1OSa5m/9z/ISL07YeW6dTSij6/Pu2gytFK99v88X5Sux
	FGckGmoxFxUnAgAlCZr4lwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7qZi7xTDZ40mVjMWb+GzWLPoklM
	Fnv2nmSxuDHhKaPF7x9z2BxYPTav0PLYtKqTzePEjN8sHptPV3t83iQXwBqlZ1OUX1qSqpCR
	X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3F4X1TBYYmKKRsvszcw
	XhLuYuTkkBAwkXj8fSZLFyMXh5DAUkaJa8t+M0EkZCQ2frnKCmELS/y51sUGUfSRUeL7nEZm
	CGczo8SV5QfYQapYBFQk9uz8wtjFyMHBJqAl0dgJFhYRMJaYuHw/WDOzwAZGiePfb4FNFRYI
	lXj69wsbiM0rYC6x5MpRRhBbSCBb4tSlxawQcUGJkzOfsIDYzAI6Egt2f2IDmc8sIC2x/B8H
	SJhTwFpi7vG9jBCHKkk0bD7DAmHXSnz++4xxAqPwLCSTZiGZNAth0gJG5lWMIqmlxbnpucWG
	esWJucWleel6yfm5mxiBkbXt2M/NOxjnvfqod4iRiYPxEKMEB7OSCO9fe49UId6UxMqq1KL8
	+KLSnNTiQ4ymwJCYyCwlmpwPjO28knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILU
	Ipg+Jg5OqQYmq9UX1/qZ/764LtBo+gf/LseE/zleTNHCehk7GheX7mk4f8WlKKx4ShoDs7b3
	Br/td+zeiW+apCbvdvz2t9NJjvUdv/N/6b4RXMW69l2XvuJq/o7/PSxKz7ivba2/uZLzsrqr
	HVuyefPEEs5l6kYVdu8u9XFeaNty5b/X9qc/511OCTlorvXOc4pU3uWKvozLF6/Ont5/bGlZ
	hciaPzqWEo5lW5U4eBKv5shH7J+xOP+J4eJop48Gm28Xs2Ukz/z8aGNV+gG/tq5pC7aFZppd
	N97+e+WFkmCO7a07krcsWFCxjeHvPi/ezYIyVfz/2RJOvfqZszvkl7PHdv7t7R4c+3cYT8/Z
	qBpQdGv2nBu3lViKMxINtZiLihMB69hWYTUDAAA=
X-CMS-MailID: 20231108145953eucas1p2eeaf54e93c10cbf501a43f594e23438a
X-Msg-Generator: CA
X-RootMTR: 20231108145953eucas1p2eeaf54e93c10cbf501a43f594e23438a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231108145953eucas1p2eeaf54e93c10cbf501a43f594e23438a
References: <20231107194152.3374087-1-willy@infradead.org>
	<20231107194152.3374087-3-willy@infradead.org>
	<CGME20231108145953eucas1p2eeaf54e93c10cbf501a43f594e23438a@eucas1p2.samsung.com>

On Tue, Nov 07, 2023 at 07:41:49PM +0000, Matthew Wilcox (Oracle) wrote:
> The calculation of block from index doesn't work for devices with a block
> size larger than PAGE_SIZE as we end up shifting by a negative number.
> Instead, calculate the number of the first block from the folio's
> position in the block device.  We no longer need to pass sizebits to
> grow_dev_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Not totally related to the patch but even though the variable "block"
is sector_t type, but it represents the block number in logical block
size unit of the device? My mind directly went to sector_t being 512
bytes blocks.

But the math checks out.
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/buffer.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 8dad6c691e14..cd114110b27f 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -995,11 +995,12 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
>   * Initialise the state of a blockdev folio's buffers.
>   */ 
>  static sector_t folio_init_buffers(struct folio *folio,
> -		struct block_device *bdev, sector_t block, int size)
> +		struct block_device *bdev, int size)
>  {
>  	struct buffer_head *head = folio_buffers(folio);
>  	struct buffer_head *bh = head;
>  	bool uptodate = folio_test_uptodate(folio);
> +	sector_t block = folio_pos(folio) / size;
>  	sector_t end_block = blkdev_max_block(bdev, size);
>  
>  	do {
> @@ -1032,7 +1033,7 @@ static sector_t folio_init_buffers(struct folio *folio,
>   * we succeeded, or the caller should retry.
>   */
>  static bool grow_dev_folio(struct block_device *bdev, sector_t block,
> -		pgoff_t index, unsigned size, int sizebits, gfp_t gfp)
> +		pgoff_t index, unsigned size, gfp_t gfp)
>  {
>  	struct inode *inode = bdev->bd_inode;
>  	struct folio *folio;
> @@ -1047,8 +1048,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
>  	bh = folio_buffers(folio);
>  	if (bh) {
>  		if (bh->b_size == size) {
> -			end_block = folio_init_buffers(folio, bdev,
> -					(sector_t)index << sizebits, size);
> +			end_block = folio_init_buffers(folio, bdev, size);
>  			goto unlock;
>  		}
>  
> @@ -1069,8 +1069,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
>  	 */
>  	spin_lock(&inode->i_mapping->private_lock);
>  	link_dev_buffers(folio, bh);
> -	end_block = folio_init_buffers(folio, bdev,
> -			(sector_t)index << sizebits, size);
> +	end_block = folio_init_buffers(folio, bdev, size);
>  	spin_unlock(&inode->i_mapping->private_lock);
>  unlock:
>  	folio_unlock(folio);
> @@ -1105,7 +1104,7 @@ static bool grow_buffers(struct block_device *bdev, sector_t block,
>  	}
>  
>  	/* Create a folio with the proper size buffers */
> -	return grow_dev_folio(bdev, block, index, size, sizebits, gfp);
> +	return grow_dev_folio(bdev, block, index, size, gfp);
>  }
>  
>  static struct buffer_head *
> -- 
> 2.42.0
> 

-- 
Pankaj Raghav

