Return-Path: <linux-fsdevel+bounces-11069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ECB850C89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 02:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4335E1C20F1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 01:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE5E110A;
	Mon, 12 Feb 2024 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsDe0Ob0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06A10E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707700384; cv=none; b=uDmSt/yAZu789VkVK6eUfubkXPiB9SoJIMWhJWH9+u2cUgMQW0V+tEJyFjGai9krwm5OS6lpujDkFMBvhnLmzI2c3jhG6gAmsgQG2ta1uT/hpagLXorAVEsqcNs0ArirGjJ/X6+Xq7xYQ0vRc/29ZmWxw9cfSjtZ4+nc9SJryeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707700384; c=relaxed/simple;
	bh=x7b0wCBqas2o/5lDf+9QVmhe02lFfoKv/GEIDoUpTz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LNzaZpDDxB4kM2eLZah4W4BsZZOxRtl6lDvNJOQ1YMdA4JGjOc748GShcA4U3Dd30akPeNL/NW9KcAQqLhxiM2YuzGFhNepNhJE2XLdSdf73pqJ0SyVRys3IHKtRC3AdgLRHm6r4r+i2P0oSjYnf/B+Fc9O8xn9GsKKdMaMybSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsDe0Ob0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC80C433F1;
	Mon, 12 Feb 2024 01:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707700384;
	bh=x7b0wCBqas2o/5lDf+9QVmhe02lFfoKv/GEIDoUpTz8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PsDe0Ob0lDyevV4xmhEDA5QaoFTSqFgdFCwSVZ1lqyL2XZo+DcxWnNen3MPPWcABt
	 GZ7ejJD9rK7MY4rIGOqSHbjdJ4jkBnidNG5L7z/YjceD1cyicQ0kvCegmfrcNgQtv7
	 GZj1KD56xP7xbD2hB6z0cghSuEtc1Bj7WoA2EbDnwPTwVJHxD30fguPSRsRau3bmfg
	 yZU5rofbRJgPgoVXDYWq1+GRa7Xh11afiLKN21Dy/0aDcdbYcDGG3C1/zQHFC/XLqC
	 Klb6bWsc4G2mUQk48n1KWcinyteOjbFlAoPlD1CLBy7aOZVy85F2k/YhYUaA4A0uL7
	 7gNtn4eIB2fBg==
Message-ID: <7cf58fb0-b13c-473c-b31c-864f0cac3754@kernel.org>
Date: Mon, 12 Feb 2024 10:13:02 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: convert zonefs to use the new mount api
Content-Language: en-US
To: Ian Kent <raven@themaw.net>, Bill O'Donnell <bodonnel@redhat.com>,
 linux-fsdevel@vger.kernel.org
References: <20240209000857.21040-1-bodonnel@redhat.com>
 <54dca606-e67f-4933-b8ca-a5e2095193ae@kernel.org>
 <3252c311-8f8f-4e73-8e4a-92bc6daebc7b@themaw.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3252c311-8f8f-4e73-8e4a-92bc6daebc7b@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/24 12:36, Ian Kent wrote:
>>> +static void zonefs_free_fc(struct fs_context *fc)
>>> +{
>>> +	struct zonefs_context *ctx = fc->fs_private;
>> I do not think you need this variable.
> 
> That's a fair comment but it says fs_private contains the fs context
> 
> for the casual reader.
> 
>>
>>> +
>>> +	kfree(ctx);
>> Is it safe to not set fc->fs_private to NULL ?
> 
> I think it's been safe to call kfree() with a NULL argument for ages.

That I know, which is why I asked if *not* setting fc->fs_private to NULL after
the kfree is safe. Because if another call to kfree for that pointer is done, we
will endup with a double free oops. But as long as the mount API guarantees that
it will not happen, then OK.

> 
> 
> This could be done but so far the convention with mount api code
> 
> appears to have been to add the local variable which I thought was for
> descriptive purposes but it could just be the result of cut and pastes.

Keeping the variable is fine. After all, that is not the fast path :)


-- 
Damien Le Moal
Western Digital Research


