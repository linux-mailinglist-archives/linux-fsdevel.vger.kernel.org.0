Return-Path: <linux-fsdevel+bounces-8754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFEF83AAD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C905CB2732F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D977F12;
	Wed, 24 Jan 2024 13:19:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403F199D9;
	Wed, 24 Jan 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102387; cv=none; b=ByH7TR6F3rxpzuFY7qM3prtv4Q8A/9ABpAxkzV/s3h1orwXfNgu8aHafPyU4qjzOxWke2p6iDAgDvPfsj9wjg/d0Kfbd0oy/9O0YWDcECxtzFHI2dk2HmhezOq/KjTWoSAksAbWuwy/BcLqUaEGfPrP6Oj+M1cnKIHZarXCs5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102387; c=relaxed/simple;
	bh=R13y5CBCHLtriaSQtvuC+SSAGMqVsVLKkRTZC+VCqFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAj2WhYz2aplNDWd94fL6ncNH+/bxy+4jm+aRAW0gzj1Np3dc4J1JqXWyKgCebPrOITer5/zTUD5xG/SEVz4+11QtytJR527AzMyKOD6UtEtXOLKWIbKa/9afexMj7W6+QOnH9A12v/cFigytPLUYCfuUtm8hA0sDqWxBqB43cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.H-RYY_1706102373;
Received: from 30.213.145.36(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.H-RYY_1706102373)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 21:19:34 +0800
Message-ID: <6063ef59-4f9e-4413-90a8-a23001c4bb2f@linux.alibaba.com>
Date: Wed, 24 Jan 2024 21:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add support for explicit export disabling
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 amir73il@gmail.com
References: <20240124113042.44300-1-jefflexu@linux.alibaba.com>
 <CAJfpegtkSgRO-24bdnA4xUMFW5vFwSDQ7WkcowNR69zmbRwKqQ@mail.gmail.com>
 <96abca7f-8bd1-44e8-98be-c60d6d676ec6@linux.alibaba.com>
 <CAJfpegsk-zjpOKhE7y7zmUd1sZr-Sn3jbKPjDLCSU7KmLbjr5Q@mail.gmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegsk-zjpOKhE7y7zmUd1sZr-Sn3jbKPjDLCSU7KmLbjr5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/24/24 9:04 PM, Miklos Szeredi wrote:
> On Wed, 24 Jan 2024 at 13:50, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> OK I will rename it to fuse_no_export_operations.
>>
>> By the way do I need to bump and update the minor version of FUSE protocol?
> 
> It's not strictly necessary since the feature is negotiated with the
> FUSE_NO_EXPORT_SUPPORT flag.
> 
> Despite that we do usually bump the minor version once per kernel
> release if there were any changes to the API.


Got it.  Many thanks.

-- 
Thanks,
Jingbo

