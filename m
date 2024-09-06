Return-Path: <linux-fsdevel+bounces-28822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789396E816
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 05:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0BF1C23319
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 03:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE036130;
	Fri,  6 Sep 2024 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="McRKcKr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3A1EB35
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592696; cv=none; b=W+tWocm3dx6i9MqLPdiBiycQCOGn6eW3GjQlO+FOvE5Ktg4H39IfN79mZed7uEg3xbw3+sDy7sSDDThltn4BvzDrmHNgBdieaMYg3oUhAhV7m7LlNhYQp3bAjKZznl12KcNuyHdku/v9M0CDcQGg1CWw2iILPnu1f/Dzhp/TXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592696; c=relaxed/simple;
	bh=V0qeoYoaYqYQrWHfFNyDQMNz4I8TIWhdXiPDVH3a4fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkTZHhej2qSLi/T+V80A+bZEsemERHWa4X0tzr4yUKpen9uMpCenwjKPsUbw9qBVXgT6h/sYdiEFQ1oGvgpjX4Hb5bX1pnseXwIJMnqvtKYOuD44DK+zw9ikBNijZEZsTQKdyVNYE9GW4tbtbOf4Zxwiv71N8GKPv1hEu1v7z5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=McRKcKr8; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725592686; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IOH8nVZ7cR1ziSpckgC9zmGTHvdGY5gms9aDGiPCogs=;
	b=McRKcKr8wNpTNrywYWpacndTzdk5HxAH4W4Qb3m5wgzfNPS4Oc95GVld/wBGCqs7NciQbCFkVLEFoPshMQ0R7K/QeymtAjQ2KHsur4TOyOgOR0LVJ43sMpQ4rOBm5psLexaQ4SSnbZ5eQlfkgMJEzg7USPloIu1bbogLgvx6SXw=
Received: from 30.221.145.151(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WENuky-_1725592684)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 11:18:05 +0800
Message-ID: <8fc5fd4f-b466-42b1-af9e-1d9cd63aab62@linux.alibaba.com>
Date: Fri, 6 Sep 2024 11:18:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, sweettea-kernel@dorminy.me, kernel-team@meta.com
References: <20240905174541.392785-1-joannelkoong@gmail.com>
 <27b6ad2f-9a43-4938-9f0d-2d11581e8be7@fastmail.fm>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <27b6ad2f-9a43-4938-9f0d-2d11581e8be7@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/24 5:16 AM, Bernd Schubert wrote:
> Hi Joanne,
> 
> On 9/5/24 19:45, Joanne Koong wrote:
>> Introduce the capability to dynamically configure the fuse max pages
>> limit (formerly #defined as FUSE_MAX_MAX_PAGES) through a sysctl.
>> This enhancement allows system administrators to adjust the value
>> based on system-specific requirements.
>>
>> This removes the previous static limit of 256 max pages, which limits
>> the max write size of a request to 1 MiB (on 4096 pagesize systems).
>> Having the ability to up the max write size beyond 1 MiB allows for the
>> perf improvements detailed in this thread [1].
> 
> the change itself looks good to me, but have you seen this discussion here?
> 
> https://lore.kernel.org/lkml/CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com/T/
> 
> 
> Miklos is basically worried about page pinning and accounting for that
> for unprivileged user processes. 

Yeah this is the blocking issue here when attempting to increase the max
pages limit.

For background requests, maybe this could be fixed by taking the max
pages limit into account when calculating max_user_bgreq. (currently
max_user_bgreq is calculated "assuming 392 bytes per request")

While for synchronous requests, I'm not sure if this indeed matters.  Or
at least it won't be such severe as the pinned memory is limited by the
number of the user process in this case.

-- 
Thanks,
Jingbo

