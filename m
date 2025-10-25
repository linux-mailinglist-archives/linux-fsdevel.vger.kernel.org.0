Return-Path: <linux-fsdevel+bounces-65590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D567EC0895A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A855352000
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA12561B9;
	Sat, 25 Oct 2025 03:20:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11922A4DA;
	Sat, 25 Oct 2025 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761362451; cv=none; b=P0pSXbg40Jz/iRe6xykWDsjvHFhB5nOqhxa/L34zf9SdhZoLk9Aog3jznAV80i/553wdLGdlBurkjZ9i3IGhmjQDoh6V81/1/Ny0MtbTsbw5jDDq+xn6W6O94jubuuCTiJdI8N9KlCiJOhQi9IAOohOI3KQ7EUnEX6dc5mya1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761362451; c=relaxed/simple;
	bh=+HtuhKWNbWuurs46qG8vqq6ZUX7hNXP29A6rpNEF6os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdKK7NDgnMulwyxjlRE/doQdRo/XCgswuohEAkOubSTHB9/bNNXGtwvJ35D6hx2t5Kmkuid31n8agSG+ad0FVv92VjUuLTOf4kjRcYfNsiVs01tv/sL5+V6MRc0fPVP4nRBHgLZFxUgEl2GZKwAJ/DEAMDT+zjxdtae++YsJCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlPj53glzKHLyS;
	Sat, 25 Oct 2025 11:19:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 658721A0E8F;
	Sat, 25 Oct 2025 11:20:45 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgCH3UULQvxowpgaBg--.43262S3;
	Sat, 25 Oct 2025 11:20:45 +0800 (CST)
Message-ID: <273dc469-cc25-479c-8cdf-b21253873354@huaweicloud.com>
Date: Sat, 25 Oct 2025 11:20:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] ext4: Use folio_next_pos()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-ext4@vger.kernel.org
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-5-willy@infradead.org>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251024170822.1427218-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCH3UULQvxowpgaBg--.43262S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4DXrW7Zw4rXF45Kr15Arb_yoW8CF4fpr
	4kKF1DZrZxZF1DuFy3XFnrZFyIk3s8Ww4UGasrG3W3XF98JrnYgr40qw1qgF1Ykry8XF48
	Zr10qr1kW3WrAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/25/2025 1:08 AM, Matthew Wilcox (Oracle) wrote:
> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: linux-ext4@vger.kernel.org

A nice cleanup!

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e99306a8f47c..1b22e9516db4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1319,8 +1319,8 @@ static int ext4_write_begin(const struct kiocb *iocb,
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> -	if (pos + len > folio_pos(folio) + folio_size(folio))
> -		len = folio_pos(folio) + folio_size(folio) - pos;
> +	if (len > folio_next_pos(folio) - pos)
> +		len = folio_next_pos(folio) - pos;
>  
>  	from = offset_in_folio(folio, pos);
>  	to = from + len;
> @@ -2704,7 +2704,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  
>  			if (mpd->map.m_len == 0)
>  				mpd->start_pos = folio_pos(folio);
> -			mpd->next_pos = folio_pos(folio) + folio_size(folio);
> +			mpd->next_pos = folio_next_pos(folio);
>  			/*
>  			 * Writeout when we cannot modify metadata is simple.
>  			 * Just submit the page. For data=journal mode we
> @@ -3146,8 +3146,8 @@ static int ext4_da_write_begin(const struct kiocb *iocb,
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> -	if (pos + len > folio_pos(folio) + folio_size(folio))
> -		len = folio_pos(folio) + folio_size(folio) - pos;
> +	if (len > folio_next_pos(folio) - pos)
> +		len = folio_next_pos(folio) - pos;
>  
>  	ret = ext4_block_write_begin(NULL, folio, pos, len,
>  				     ext4_da_get_block_prep);


