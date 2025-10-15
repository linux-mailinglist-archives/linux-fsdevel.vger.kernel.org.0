Return-Path: <linux-fsdevel+bounces-64255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F11EBDFE84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7B2834F604
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A182EB5D2;
	Wed, 15 Oct 2025 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FN9Wxdv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73A2D8767
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550029; cv=none; b=p9usrniGy+K1nn2b0mwasiDg9JINWmZdB7mmSfqBdcl0kdJdBRIQiVD/CGlsrJTJRAEIB9/YYGHQU1HEWhsY0jvZWRtOQcxkFMn8zKWoIvQkCPUQY4L1BOgLxt5GG2jtXgq1Dgy/YJoDARW06UMw2WCvb9kubdFO8vp7Eq5p7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550029; c=relaxed/simple;
	bh=cDP5VWZW9m+cg1OZFipaBsjCX1JqlocRKCDxc+LBSbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQuu/VgIIDlnqR//vx+kqJ5/Z5MusFQ2Vw444xoqIuc+mso2mpQ/UesUyX2zzqj0L6Pk/s+01UytRDH0oVs4JaRu1ilgcuUlqO+Yrp27eiNlb3g+cMqhepTAQvqZt1Xu4rxLvv74JDQaeVVYT2HAAZUsWenIPYD9VdJybIwzKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FN9Wxdv7; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760550023; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MuHtoNp5Himmgrf46rYsZc4HM+9tCzYzJJHOnVnHtaI=;
	b=FN9Wxdv7pzYEjrK6ibTd74bTeDe8gTRhJrhWWpOpCLofnLut801Cw95kxEHJUcFQKm1pFCnofynwNkWBSo19RQfSbce74sP9IUVz3exKhz9Qm4BhB9vKuovZ4o73XNc5WsbyrC5HKz3UCnrUWXJQsbIk23f9ALxohaAsQlSFxFo=
Received: from 30.134.15.121(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqHGeBV_1760550022 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 01:40:23 +0800
Message-ID: <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com>
Date: Thu, 16 Oct 2025 01:40:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Joanne Koong <joannelkoong@gmail.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, bfoster@redhat.com,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com>
 <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/16 01:34, Joanne Koong wrote:
> On Sun, Oct 12, 2025 at 8:00 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Thu, Oct 09, 2025 at 03:56:03PM -0700, Joanne Koong wrote:
>>> The end position to start truncating from may be at an offset into a
>>> block, which under the current logic would result in overtruncation.
>>>
>>> Adjust the calculation to account for unaligned end offsets.
>>
>> Should this get a fixes tag?
> 
> I don't think this needs a fixes tag because when it was originally
> written (in commit 9dc55f1389f9 ("iomap: add support for sub-pagesize
> buffered I/O without buffer heads") in 2018), it was only used by xfs.
> think it was when erofs started using iomap that iomap mappings could
> represent non-block-aligned data.

What non-block-aligned data exactly? erofs is a strictly block-aligned
filesystem except for tail inline data.

Is it inline data? gfs2 also uses the similar inline data logic.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> Joanne
> 
>>
>> Otherwise looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>


