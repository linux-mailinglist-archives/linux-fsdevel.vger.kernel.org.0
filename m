Return-Path: <linux-fsdevel+bounces-19195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9AA8C11CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5949A282145
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2239F15B543;
	Thu,  9 May 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tKoN2z+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592C12F378
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267803; cv=none; b=pj21yM8BvF0VK54kuAqk791j9IB7IfmWCo3CHbmaRXrRafdy32sIfQOBbWDK07qOH5EGeLuIXAipmQs47DnnrQDVU1oLOAH1VXUwwPUDdVESTFHHLpfioWUxHJzbSPmpiFeCfgpe3OQ2yl2HwA7L9vOKjPQU6c0ZS237xLqbbgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267803; c=relaxed/simple;
	bh=rENpYzuzYep+kKpc+ClGh2Jqy7GxYlD0JOeoKeVYATU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h3Ibep4/BNWoJWCXvzPpFTOfGzNf1+HipUCdLu4FJa9frT8iAiTJk6Q9sz8R52eUWhxS6Y+BGYmYPMHCbcuQy5i+PddDX88Gc1LSpjtt+w1XEMFJl5Pae9OsxOiZQxqmbm3d0H5TFFHVmRfnL+Jb8K+U1+Cq8kVZJG2PFqY1AvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tKoN2z+0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715267799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WuV7M9mHf7zLGoXyvtH3Is1VnuTrzUZ1N2ISvLJru+k=;
	b=tKoN2z+02HEGPxaMBMX19ZneYgaEWjlQx1yjDRa+5EtNM+Tk4h+QyONWXsiZlzBqwIkM0v
	y02jbP0F9WK/J4dQxTDaCsJa9HxkYxUlN07D+ppV/DoxZeEABmqSngg/D+YBoNgF7iuP38
	uWCX/WykcZyS911GVQsXeGumCrHpsR8=
From: Luis Henriques <luis.henriques@linux.dev>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  tytso@mit.edu,
  adilger.kernel@dilger.ca,  jack@suse.cz,  ritesh.list@gmail.com,
  hch@infradead.org,  djwong@kernel.org,  willy@infradead.org,
  zokeefe@google.com,  yi.zhang@huawei.com,  chengzhihao1@huawei.com,
  yukuai3@huawei.com,  wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 03/26] ext4: correct the hole length returned by
 ext4_map_blocks()
In-Reply-To: <20240127015825.1608160-4-yi.zhang@huaweicloud.com> (Zhang Yi's
	message of "Sat, 27 Jan 2024 09:58:02 +0800")
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
	<20240127015825.1608160-4-yi.zhang@huaweicloud.com>
Date: Thu, 09 May 2024 16:16:34 +0100
Message-ID: <87zfszuib1.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Sat 27 Jan 2024 09:58:02 AM +08, Zhang Yi wrote;
<...>
> +static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
> +						  struct ext4_ext_path *path,
> +						  ext4_lblk_t lblk)
> +{
> +	ext4_lblk_t hole_start, len;
> +	struct extent_status es;
> +
> +	hole_start = lblk;
> +	len = ext4_ext_find_hole(inode, path, &hole_start);
> +again:
> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
> +				  hole_start + len - 1, &es);
> +	if (!es.es_len)
> +		goto insert_hole;
> +
> +	/*
> +	 * There's a delalloc extent in the hole, handle it if the delalloc
> +	 * extent is in front of, behind and straddle the queried range.
> +	 */
> +	if (lblk >= es.es_lblk + es.es_len) {
> +		/*
> +		 * The delalloc extent is in front of the queried range,
> +		 * find again from the queried start block.
> +		 */
> +		len -= lblk - hole_start;
> +		hole_start = lblk;
> +		goto again;

It's looks like it's easy to trigger an infinite loop here using fstest
generic/039.  If I understand it correctly (which doesn't happen as often
as I'd like), this is due to an integer overflow in the 'if' condition,
and should be fixed with the patch below.

From 3117af2f8dacad37a2722850421f31075ae9e88d Mon Sep 17 00:00:00 2001
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Date: Thu, 9 May 2024 15:53:01 +0100
Subject: [PATCH] ext4: fix infinite loop caused by integer overflow

An integer overflow will happen if the extent_status len is set to
EXT_MAX_BLOCKS (0xffffffff).  This may cause an infinite loop in function
ext4_ext_determine_insert_hole(), easily reproducible using fstest
generic/039.

Fixes: 6430dea07e85 ("ext4: correct the hole length returned by ext4_map_blocks()")
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e57054bdc5fd..193121b394f9 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4064,7 +4064,7 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
 	 * There's a delalloc extent in the hole, handle it if the delalloc
 	 * extent is in front of, behind and straddle the queried range.
 	 */
-	if (lblk >= es.es_lblk + es.es_len) {
+	if (lblk >= ((__u64) es.es_lblk) + es.es_len) {
 		/*
 		 * The delalloc extent is in front of the queried range,
 		 * find again from the queried start block.

