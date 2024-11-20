Return-Path: <linux-fsdevel+bounces-35319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13649D3A3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B08A1F219A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84C1A0BE1;
	Wed, 20 Nov 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VfjN89wL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30A19F41C
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104442; cv=none; b=Vw6bY8tMu7OSbgUnRkdP6PgqjxKimkQGdVdSgI8GunQFMnb3De9dGBuff4fr8PlX7V/jXbsSQFXjylK20g7Eceguz2M+X0GL6/dyiJTcgNGPuPnhUIwQM0IO4WH+5qIkdrP14oRYY/71objH3DFUV0xIRQBwWLOh5GpvHbvu6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104442; c=relaxed/simple;
	bh=YMPZcK+LWOQMxuzR75vyl3z+azBefix69xmXJ5cgyw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaAXh64GrDVJQwB/nNRsGrC3FNSLY2GqDC2O92S1nKQRcRGTxnCLvkBF9xPfNcqnLMGv2hntyu7BxYyviqUcCzhpb7jAl007jOvIwtwhSjR0XAwwX2VDMFDwWhjLDrWJkDcNCB0P6p9f7cO2uyOCCS9iiOwNB5A3855DUQbQFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VfjN89wL; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732104429; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uc4FeWg62+0tPnC8EZ1b1Ba4o8yAWdikfuNASs5qR+4=;
	b=VfjN89wLQNNSjWTUwIrRznk1FsYbl+0spNZRQA3sVn626igmbU5fLeCSJ0wqijlBx0O92R0sd+UErT78j38UBHAWGra5uGZibtkApPe2P/nw+fkB0PqMU6oJtGFACGRvhP4azv5aqedh/eqPBkFaSxHzNbPhbYK/R15UcfyXzOU=
Received: from 30.221.144.243(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WJsG-ew_1732104427 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 20:07:08 +0800
Message-ID: <949e9cf4-60df-4e2e-96a3-2219cfcbb46a@linux.alibaba.com>
Date: Wed, 20 Nov 2024 20:07:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] fs/writeback: in wait_sb_inodes(), skip wait for
 AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev, josef@toxicpanda.com, linux-mm@kvack.org,
 bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20241115224459.427610-1-joannelkoong@gmail.com>
 <20241115224459.427610-4-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241115224459.427610-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/16/24 6:44 AM, Joanne Koong wrote:
> For filesystems with the AS_WRITEBACK_INDETERMINATE flag set, writeback
> operations may take an indeterminate time to complete. For example, writing
> data back to disk in FUSE filesystems depends on the userspace server
> successfully completing writeback.
> 
> In this commit, wait_sb_inodes() skips waiting on writeback if the
> inode's mapping has AS_WRITEBACK_INDETERMINATE set, else sync(2) may take an
> indeterminate amount of time to complete.
> 
> If the caller wishes to ensure the data for a mapping with the
> AS_WRITEBACK_INDETERMINATE flag set has actually been written back to disk,
> they should use fsync(2)/fdatasync(2) instead.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fs-writeback.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index d8bec3c1bb1f..ad192db17ce4 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2659,6 +2659,9 @@ static void wait_sb_inodes(struct super_block *sb)
>  		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
>  			continue;
>  
> +		if (mapping_writeback_indeterminate(mapping))
> +			continue;
> +
>  		spin_unlock_irq(&sb->s_inode_wblist_lock);
>  
>  		spin_lock(&inode->i_lock);

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

