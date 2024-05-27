Return-Path: <linux-fsdevel+bounces-20205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA98CF869
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 06:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECFC1C215A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 04:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082510979;
	Mon, 27 May 2024 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwRInvlB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63AFC12
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 04:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784506; cv=none; b=ITjFbNLObOp8LxPJl6aaoYyENIk4FbID0LkTD7jRt45JhsvxAMsKibfZqU7TZdrvEgCUTiXjarSziL+iWgEECwyGcBVVGPvwK+aCQD6dizVwVMidfawXqtEGZSDC7dsIU0LRZr7MnXQAwBxYRjdiUpHknfsOuyzGIOooP2UWygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784506; c=relaxed/simple;
	bh=A1miyeVqdr5HpvR3Mcokz2oEljmDSLFgKCbfM92IPZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQcVto/v0ZqDGUupQoo6mFWCd1RwlDKlT+Aj8/haK2mwH6Yv+6bxU6wQgW2XdC+nJ+aF1F8iFEyCnoUFWhQH8RxzzwY/bwt+rs/41d/G2Ba3BLvJFSqu91Rwu5ck1a6k9FclxPuJO14T7sndXNGwxZA0UTRidlZvcvCLZZxsMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwRInvlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46682C2BBFC;
	Mon, 27 May 2024 04:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716784506;
	bh=A1miyeVqdr5HpvR3Mcokz2oEljmDSLFgKCbfM92IPZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CwRInvlBLo79WMvriBIIiRW2VOUxMz6vFnCIaRhPhZTBXgA0hfi528d/7676+QJf2
	 V09cATmXA+ZR9KcQA2bAgtKKGEK9PS7hBuBf+DwG3Rc7b30GnOrbbz6ZyuImnJqMBY
	 mM2GJwlZyEyg7Gms5vnlCZC+la7Dsb/aoZhnO2aLFBLckVWFQv9T50RZkfKkkmSOqW
	 8ThZKTo6egv8JF3//evCMXVsu130eqSgPDm0imLDK3rh4p1meKxFxqan4QWopqzC53
	 ED6Us/6anrakTV6hDursEdGjJjUkfcORbHmy86p9B54CCFP5IfkHnBTSyGBvrUZkff
	 dz7ywIckdNU/g==
Message-ID: <0dba9dbd-c08d-4137-be6e-fca5f0e0e553@kernel.org>
Date: Mon, 27 May 2024 13:35:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] zonefs: move super block reading from page to folio
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240523150253.3288-1-jth@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240523150253.3288-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/24/24 12:02 AM, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Move reading of the on-disk superblock from page to folios.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Applied to for-6.11. Thanks !

-- 
Damien Le Moal
Western Digital Research


