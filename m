Return-Path: <linux-fsdevel+bounces-29070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB869747D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 03:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2392EB238F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 01:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC21B22075;
	Wed, 11 Sep 2024 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a0Bwsn4Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C21EB46
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018589; cv=none; b=mx6gcGzUQDrNWE1djTEY51Gks3uGTDw3B7PrffAw7dxFpSnSC/3I0LUtxvpYhG+cNrudYpsLygZkaqQWUHAmyWffxrAKlYcLl6RbKwSHciVP8dlVDpRPUOcOgzAXHw0bkAJRIUBOBPCHiAT9p4YZWyKT5sRPmmkA+5N30+VdZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018589; c=relaxed/simple;
	bh=dUdeyK4GFd0v+oog67D+ntldPdZ1ZKcOGRBMR2tXJzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8HzLrWn+j6RB1h3ZTWxuBkP9gEHhpqT9D3Yz8CghrEPJhjTNJncbyFaPbn2RwtM4xOyZfXy2Ul9CjXVEFxesOLp6CnSkMbTiQaVApOPxu06Ms50yI0jHbMhd63S8cDdwpfSRjAhEFyiMppJbruOZV07OhI59cSvjLjaaQu6mX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a0Bwsn4Y; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726018578; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lImV2yxhI9NRThSTlfO0PUTTKBqBOUskzAMBHxelpvY=;
	b=a0Bwsn4YA5CtTno5+J4bGsKeXUKpWpSRukVxvs3VkEiEzqU5B+rkIcp4B5ZST7qi7VbA1vEDXytKP/swXwNfSLVCiufMyqeBo08jgFsCJpof/bc0pLNWqxyc9Hkb9eR5XyTcM1809Y228b2qXE4+CuNd1dDAfVAWqey4jMGaDKk=
Received: from 30.221.145.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WElz96H_1726018576)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 09:36:17 +0800
Message-ID: <58a8117f-e005-4620-a3b6-c48cf57bd5a2@linux.alibaba.com>
Date: Wed, 11 Sep 2024 09:36:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] fuse: writeback clean up / refactoring
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20240826211908.75190-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/27/24 5:19 AM, Joanne Koong wrote:
> This patchset contains some minor clean up / refactoring for the fuse
> writeback code.

Sorry maybe it's too late and not sure if it's still needed, but anyway,

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>



-- 
Thanks,
Jingbo

