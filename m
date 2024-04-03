Return-Path: <linux-fsdevel+bounces-15998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8C8968A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 10:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3BA2875F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DF56EB73;
	Wed,  3 Apr 2024 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R9aXz0Ht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6903E48E;
	Wed,  3 Apr 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132969; cv=none; b=ho6+ijI8R78pxaONgStjw4TUFIkPxn6vGz4Yxltvkzw8nbwGdLlI0EBE3QGakhnH9RZfdxRD1tZr3UKMQumBzzHSsCEl5parC41U1k6dEBkF3Q2PGxPY8YfjH/z1xC6td8SFhudA383whBZjNMWEoKpCEAyerTif96X5kTxmwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132969; c=relaxed/simple;
	bh=Ldfjw0TveG1bC27L02CGJ1El9aX9iApZ9fZGyu1A5wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HQuM189R0MWqJgf153p1wXmA2Lq/2s5TiMbkAmh8H2O3SfOOqiNt3cR2wuWoHaKnvd6S2BgsjlWLR69JtPANyo+Jc1WZVg3oinOXY1M1ic3Z2ZywYbIQs6qACB2V+ZBYG55azUMvi0O1+ey+n7VT5WOWKDgAp93LUu6t1xWIvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R9aXz0Ht; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712132958; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6ARyxKsG7GVlym8JkJymXRlceZpVJP0pu/mDsnbzovQ=;
	b=R9aXz0HtchVxIj0OkVENOP7cn2AfFizRkz0mdt8mvI73FcWSx0ysGaFPOaN+ZaHguEqXNlsr/eeR24y4bKKSzrI8BZ373JQxfl/fwJPrV4hYPSVbj6wg7FluO1tL1kw8ugKsABUjFoL8ZiB7LZ0EV3h0tQaP03EESXs0Njme5JM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W3r6Fd3_1712132955;
Received: from 30.97.48.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3r6Fd3_1712132955)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 16:29:16 +0800
Message-ID: <dce83785-af96-4ff8-9552-56d73b5daf98@linux.alibaba.com>
Date: Wed, 3 Apr 2024 16:29:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] fiemap extension for more physical information
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Jonathan Corbet <corbet@lwn.net>, Kent Overstreet
 <kent.overstreet@linux.dev>, Brian Foster <bfoster@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/4/3 15:22, Sweet Tea Dorminy wrote:
> For many years, various btrfs users have written programs to discover
> the actual disk space used by files, using root-only interfaces.
> However, this information is a great fit for fiemap: it is inherently
> tied to extent information, all filesystems can use it, and the
> capabilities required for FIEMAP make sense for this additional
> information also.
> 
> Hence, this patchset adds various additional information to fiemap,
> and extends filesystems (but not iomap) to return it.  This uses some of
> the reserved padding in the fiemap extent structure, so programs unaware
> of the changes will be unaffected.

I'm not sure why here iomap was excluded technically or I'm missing some
previous comments?

> 
> This is based on next-20240403. I've tested the btrfs part of this with
> the standard btrfs testing matrix locally and manually, and done minimal
> testing of the non-btrfs parts.
> 
> I'm unsure whether btrfs should be returning the entire physical extent
> referenced by a particular logical range, or just the part of the
> physical extent referenced by that range. The v2 thread has a discussion
> of this.

Could you also make iomap support new FIEMAP physical extent information?
since compressed EROFS uses iomap FIEMAP interface to report compressed
extents ("z_erofs_iomap_report_ops") but there is no way to return
correct compressed lengths, that is unexpected.

Thanks,
Gao Xiang


