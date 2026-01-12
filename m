Return-Path: <linux-fsdevel+bounces-73265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27AD136DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C86C31211F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59B2DCBE6;
	Mon, 12 Jan 2026 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mf4+9422"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C742989A2;
	Mon, 12 Jan 2026 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229785; cv=none; b=fFheMPd8nfgur6ngZxcyLrJ4ljNOodlBAtbbMGB7V+GSSfoqyqRnvZVlcjM2O6t1/SUZjTCl/zVBPFpbjzIvAXkI/2QrmH4nxV4R7I2ROvswOV+mfTvozxqpGh+HFjjLVoi0Cz1L8do7cOkAVSvztKaQLZE1W3rnE932vDZnBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229785; c=relaxed/simple;
	bh=m477eRIQKL6+kbWgLpJVhpGGKXyfo8DtsbwQc4IdVjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awzE8Kz1WyT9tKQNndEAzG4IxgyjoztH8YzegLu6LnPETMV8JgxpHbWRyBX/l4FY/Nidh3sFo8skJOKiU0sMCgaReAo0LFrfvl6JTgMs6Pbgu8WM9QF/i787ZK3z9As+CdTpw5Sd9wGw3e/D9fuQUFEk7hbYBWKDg8iEhb2nztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mf4+9422; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768229774; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bWzdgp2CS2X31/zzChh3XFiUbP6b5dWYiArq4z741J4=;
	b=mf4+9422+C3zFDspcWEATYmPol6o2IDdNjGfjrRyIVsaKSxHaAteEdM36kGXtKVn8t5hCfq2KbQK/7X0OMmoajcFBjQenO9fQYS/BDPHXmetPVQsLe37nObCxwowC/eC2t6rktME0Gd0bFFn82mSVWoVJmUQ5EdROoubaKM4Pog=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwv.v-g_1768228832 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 22:40:33 +0800
Message-ID: <d6ea54ae-39cf-4842-a808-4741d9c28ddd@linux.alibaba.com>
Date: Mon, 12 Jan 2026 22:40:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/10] erofs: Introduce page cache sharing feature
To: Christian Brauner <brauner@kernel.org>
Cc: chao@kernel.org, djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260112-begreifbar-hasten-da396ac2759b@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260112-begreifbar-hasten-da396ac2759b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2026/1/12 17:14, Christian Brauner wrote:
> On Fri, Jan 09, 2026 at 10:28:46AM +0000, Hongbo Li wrote:
>> Enabling page cahe sharing in container scenarios has become increasingly
>> crucial, as it can significantly reduce memory usage. In previous efforts,
>> Hongzhen has done substantial work to push this feature into the EROFS
>> mainline. Due to other commitments, he hasn't been able to continue his
>> work recently, and I'm very pleased to build upon his work and continue
>> to refine this implementation.
> 
> I can't vouch for implementation details but I like the idea so +1 from me.

Thanks, I think it should be fine.
Let me finalize the review this week.

Thanks,
Gao Xiang

