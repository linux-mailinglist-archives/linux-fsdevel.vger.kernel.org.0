Return-Path: <linux-fsdevel+bounces-14692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B539987E232
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 03:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51721C2115A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8E1DDF5;
	Mon, 18 Mar 2024 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gYC3wuoi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977417740;
	Mon, 18 Mar 2024 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729576; cv=none; b=HXpHLGurpQK6CwOARA6Q6D2DRLyl5n749cuIocBPxuQB4ggPA71et4RjwmJ05DwacjLyvXUxJtZEu5xLpnT/ZGWO5gWJNWLhSGJmTlFeVzOzLBlNUEthHLNE+byRAhd2rXode43ZvDVR4t6iw3TSwTqQAUh4NxNIHOe3F3zcNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729576; c=relaxed/simple;
	bh=Ok9NgkJ94aVUsT/Ecsl8eXl7sp8dAd8bVcabvxBng88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMxV55tVMorksmv1aRtv78xeIAOCOQZoOmvHYqcaCL65kdZR9V4oM3VVNE1GU+0Sxnbgyr/tT8e1RoS46+rELoGyYXnkRj9IS8dED8XBRsMMJtvlj8MobCxpyx2Kiw4mBp1H38g8x9NGkLMgXkUJqxbNrIAFwKKYlWvjLGrRD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gYC3wuoi; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710729570; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=b/6hq+RqUhOezh+Gvf+LN+C8jYCt9btUaZVWgOxfR+s=;
	b=gYC3wuoinJoMVN5RsFO6SMDlWmUvHSCCkapQL3+sqrw55iqar1MyrDFGQilhrWaOtlgE2pURwDsDSKMbbXA96YrAMPWGIjhy1paW2DH7r2bbHvpZtfeLoGC0H0k34Ih7IVBsFFcKXeGoXl6/TOPvIbtCzZ/tCh2nMiHnRZH38Vs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W2dkl1k_1710729569;
Received: from 30.97.48.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2dkl1k_1710729569)
          by smtp.aliyun-inc.com;
          Mon, 18 Mar 2024 10:39:30 +0800
Message-ID: <5e04a86d-8bbd-41da-95f6-cf1562ed04f9@linux.alibaba.com>
Date: Mon, 18 Mar 2024 10:39:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 linux-next 07/19] erofs: prevent direct access of
 bd_inode
To: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
 brauner@kernel.org, axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-8-yukuai1@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240222124555.2049140-8-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/22 20:45, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all filesystems stash the bdev file, it's ok to get inode
> for the file.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(BTW, it'd be better to +Cc EROFS mailing list for this patch.)

Thanks,
Gao Xiang

> ---
>   fs/erofs/data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 433fc39ba423..dc2d43abe8c5 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -70,7 +70,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>   	if (erofs_is_fscache_mode(sb))
>   		buf->inode = EROFS_SB(sb)->s_fscache->inode;
>   	else
> -		buf->inode = sb->s_bdev->bd_inode;
> +		buf->inode = file_inode(sb->s_bdev_file);
>   }
>   
>   void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,

