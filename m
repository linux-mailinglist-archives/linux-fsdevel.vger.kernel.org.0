Return-Path: <linux-fsdevel+bounces-73863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D2BD2217A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65FA23016BE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10A92750ED;
	Thu, 15 Jan 2026 02:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="REXQv3vr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C21E9906;
	Thu, 15 Jan 2026 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768443067; cv=none; b=lX4BU63ZhPqCwO3aKIlHAIkYmfkS2yCKiBy1ZWQX74SDELtiyodI19aCU+opY0O10p1qjen7BvCYWwwt1/OI9Ofg9f+RKJDIHptLKEauTfLZN2Qb1hdtZgbRy1/SpHieAxhp1/9DrF4j4EGLKdCdafk9OTCyTb7YWtCUYMuLY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768443067; c=relaxed/simple;
	bh=9FMKeZ0KrXa9oi+OtFx9Q9oCDvS7OqNqKBZwK5nusnc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MS/3TQCW4+UzR+rq+eB6odh3EINiLEb35jMcxyp2l0toGascNuUMMKIH+rCi7PvSqsbJ/BIKqSzvRwwTe8QE6PUaoxCteRFowvq/pCRLkHhQEZfTW+PpJeeB9w9FX+ujFm6cZXGhNk+HYFttCdMAN8pM8tdV7ZoUmVSPHtCHRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=REXQv3vr; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768443062; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=cdLZUFeSNBWzfXS9yLhivmdnpU0BPw9LiR+DVluv9Dw=;
	b=REXQv3vre9UAfmRSTDdEiIc/rwICCm4OxU9EVDv+J9YY6nwLogfuQ6J6wYZqC6lvFHaHQyYLNHML3brpu2DLcaCwRDuwribwpUUSBo/838p3uZ0KMqQNjpgx7J/nEqto4f/hsLye1lwPAAKN8U19FPcXX+xpstqKScUeD9yDB+8=
Received: from 30.221.146.238(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wx4ugsu_1768443061 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 10:11:01 +0800
Message-ID: <52674b2d-627f-428a-89f7-36c39caa76fe@linux.alibaba.com>
Date: Thu, 15 Jan 2026 10:11:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: fix premature writetrhough request for large
 folio
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, horst@birthelmer.de,
 joseph.qi@linux.alibaba.com
References: <20260114124514.62998-1-jefflexu@linux.alibaba.com>
 <CAJnrk1bjxyUw58WyiwsyBcJ0CcsBJZKNkcm_U+A+2KSmNqvjyQ@mail.gmail.com>
 <a9fa2da0-91e7-4671-95a6-a0a44c83a92d@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <a9fa2da0-91e7-4671-95a6-a0a44c83a92d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

On 1/15/26 9:56 AM, Jingbo Xu wrote:
> 
> 
> On 1/15/26 2:41 AM, Joanne Koong wrote:
>> On Wed, Jan 14, 2026 at 4:45 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>> When large folio is enabled and the initial folio offset exceeds
>>> PAGE_SIZE, e.g. the position resides in the second page of a large
>>> folio, after the folio copying the offset (in the page) won't be updated
>>> to 0 even though the expected range is successfully copied until the end
>>> of the folio.  In this case fuse_fill_write_pages() exits prematurelly
>>> before the request has reached the max_write/max_pages limit.
>>>
>>> Fix this by eliminating page offset entirely and use folio offset
>>> instead.
>>>
>>> Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes")
>>> Cc: stable@vger.kernel.org
>>
>> This should not need the stable tag or any backports. The bug cannot
>> trigger until the future patch for turning on large folios lands.
> 
> I think 6.18 stable also needs this fix?
> 

Sorry I got it mixed up.  I remembered that the patch enabling large
folio is along with the whole patch series supporting large folio, but I
missed the fact that it was not merged to mainline.

So the stable tree indeed doesn't need the fix.  Sorry for the noise.  I
will drop the stable CC tag later.

-- 
Thanks,
Jingbo


