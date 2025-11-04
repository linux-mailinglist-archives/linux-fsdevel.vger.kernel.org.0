Return-Path: <linux-fsdevel+bounces-67005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE0C33166
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 22:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10E43B238A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293E62F9D98;
	Tue,  4 Nov 2025 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT9vl5y3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CE2EFDA2;
	Tue,  4 Nov 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291795; cv=none; b=KJZVm1C44l+Q0l0UwpQVUI+d2u67pFqX9ug8plPM75PakFLbwxh6hMr15NIDdfCi69CVc0b9cu7TyzdpZv/xHG/ep58h89Ftg1N0pCqEm4sJ4pmF5/T3XXoWsELgvO50aIcJF04y2LSKPofUSKegsemGrsavvt66OAfZ2HKVgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291795; c=relaxed/simple;
	bh=mrRpMfTe3Bep9D/fnxQr/mofWMHONG4SnKlqpOiGoBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlgOo3ZsuTm7hNP2+EP7+TR2d8UBjxnFUiw37/8f/oQ60eOBGPGzOfduZSrEJS+nA9Zn3LIKHNSUcGRrQkBx9rHyzuQmt7+Y/q3IzyyfA8j+0xEPJD3fMqBt/AH+09KaWRCBweB/X+IlNVac5xu+BpElvRmbwN+ijYfOEI46AU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT9vl5y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21400C4CEF7;
	Tue,  4 Nov 2025 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291795;
	bh=mrRpMfTe3Bep9D/fnxQr/mofWMHONG4SnKlqpOiGoBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gT9vl5y3uqGwa/ed4zRxOEeOJcCsbQBOBpsqmYR+IEIbeEKW+IuJ7C4Mg1WIXMf1V
	 wbmwn5WsMpBte85oSkZU2msvXY7hg4TB2mDXhx+HKGCfb4U/yAOcIMrRQR7jH7jfnm
	 /+u5gPay55lL1cwcWX0S8qj1H1KI7kIOgx1jU/yHDaS78f//cNtSkYe13tyg0fW48p
	 QzOZe/98qSRyvcQ66D/E5b3eXO2pYuhXjBaBaC1dhgwwPM2wrxXjpo1FyHURRrIk8f
	 QgVv6am5G0p0ClqHrX9RMDGXH0e1su8g6kdI1fG79eSl5SXva1us33DUS1LjrojzGk
	 tkqwpKYYKjEFQ==
Message-ID: <0a04e68d-5b2a-4f0b-8051-60a0b7381d17@kernel.org>
Date: Wed, 5 Nov 2025 06:29:50 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] isofs: check the return value of
 sb_min_blocksize() in isofs_fill_super
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Kara <jack@suse.cz>,
 Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, stable@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong"
 <djwong@kernel.org>, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
 <20251104125009.2111925-4-yangyongpeng.storage@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251104125009.2111925-4-yangyongpeng.storage@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 21:50, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> sb_min_blocksize() may return 0. Check its return value to avoid
> opt->blocksize and sb->s_blocksize is 0.
> 
> Cc: <stable@vger.kernel.org> # v6.15
> Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>  fs/isofs/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 6f0e6b19383c..ad3143d4066b 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
>  		goto out_freesbi;
>  	}
>  	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
> +	if (!opt->blocksize) {
> +		printk(KERN_ERR
> +		       "ISOFS: unable to set blocksize\n");

Nit: using pr_err() maybe better here ? Not sure what isofs prefers.

> +		goto out_freesbi;
> +	}
>  
>  	sbi->s_high_sierra = 0; /* default is iso9660 */
>  	sbi->s_session = opt->session;


-- 
Damien Le Moal
Western Digital Research

