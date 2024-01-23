Return-Path: <linux-fsdevel+bounces-8539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91A838D8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 12:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23E81F242A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DEE5D8E9;
	Tue, 23 Jan 2024 11:35:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4D5EE62;
	Tue, 23 Jan 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009738; cv=none; b=jC4UWMdcHdD3jH7enPBNeHYMly9znEakbpxkWTsnvJ22jTGqiBwQcGw3ydEkdFONCYwlzaF5x+NXTxTwx9ke6VqYTseAJwZAtfbY3mRdxiqmn1CyLHUe/zThbVb6tpYVhiFxeKquvTH+6yIakiUPqHXs3nMP5JxpxdpMPeGMQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009738; c=relaxed/simple;
	bh=zqxFj5ZGxR3PD3HXVtGinV/PNYZoCcA/Vkh+1WVU82U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFqzI33D2TMfqv/jxE07axs/p/8f6Rt2vzK5PRTtDig69NT4itmONKO7cIai9dlv7MIofEr141mDBcd8PRN2afU7AdG5hKdwqrUVXuaZKjFhYXar1iNh9pnDfSZ57DeStGCZRtMQCaG+pHT7uew56o93A91X/29iOeknDa7IroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.CfNdu_1706009725;
Received: from 30.221.145.142(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.CfNdu_1706009725)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:35:26 +0800
Message-ID: <77355a90-77eb-4095-b3d4-6c828b18aacf@linux.alibaba.com>
Date: Tue, 23 Jan 2024 19:35:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: disable support for file handle when
 FUSE_EXPORT_SUPPORT not configured
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123093701.94166-1-jefflexu@linux.alibaba.com>
 <CAOQ4uxgna=Eimk4KHUByk5ZRu7NKHTPJQukgV9GE_DNN_3_ztA@mail.gmail.com>
 <3d1d06de-cb59-40d7-b0df-110e7dc904d6@linux.alibaba.com>
 <CAJfpegtwmngLUfKeziO3dDpJ-XGU92DFLwhTpTrEJ0vqHnHLJg@mail.gmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegtwmngLUfKeziO3dDpJ-XGU92DFLwhTpTrEJ0vqHnHLJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/24 6:46 PM, Miklos Szeredi wrote:
> On Tue, 23 Jan 2024 at 11:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>>
>> On 1/23/24 6:17 PM, Amir Goldstein wrote:
>>> If you somehow find a way to mitigate the regression for NFS export of
>>> old fuse servers (maybe an opt-in Kconfig?),
> 
> Better would be if the server explicitly disabled export support with
> an INIT flag (FUSE_NO_EXPORT).
> 

I would give it a try (as a mitigation) if it's on the right direction.


-- 
Thanks,
Jingbo

