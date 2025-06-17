Return-Path: <linux-fsdevel+bounces-51942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9BADD8B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015244A5C1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E32ED15E;
	Tue, 17 Jun 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s13JhE1W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45B2135A0;
	Tue, 17 Jun 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178212; cv=none; b=J/FMn6JtzXXE8wRbaSDWo4iYmWDNXdkx7BVt48rFD4ZEoJunw5cGntpVKgae7WWOvmjg5H1Y/Iv464fbPWgF3f1sV8+CZmzrEYLS4PL6KCBWEB5ryeBsoWXeqe6XmVa0DFvJBGZPN45gdRDl9ebV0PT1W8wsXsOOzkvDOlV01bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178212; c=relaxed/simple;
	bh=Axol25w1xwqJjlPubIhPQP4HnS8s88QWonvKfA5tAqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfElb/Wj/e0y9K9gU95xYeDcquECxiqXkcf6p6tbHy2c4Qyg4KMtHSWEe3CZI48iDWlR5JyTqFcgExywAvMat6MqUHIt+5J13Aztu4tYspJL0eOci99op+OOhPQTvj8jXJJWmGCYrbpxSvsB479VuQUW700cN0/n4T65x5w++2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s13JhE1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E77C4CEE7;
	Tue, 17 Jun 2025 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750178211;
	bh=Axol25w1xwqJjlPubIhPQP4HnS8s88QWonvKfA5tAqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s13JhE1Wkx4G5HML4OH9XQu6tV8lp+W5KnZ+4FyyYF+W0pLuOlOKmXKs+4YZwgMPA
	 4lClSEguF43KzLKM1d9U4aJKAVRzB9jFstn1mwJ++Ucz43jdKHNCJMc9iZ8rRpyCO4
	 cEjKjJ0hxWRH/oAy2Ime93ERgxkISMqhudBaTE47HdDKPuemgipwU+Iz0sRTxRWjmc
	 JR2GmU1Eaug2lAGqW5HV8BhMz2BS3DdgJ/H6Xx0DPqhYLv6s6XH2BGlvQasZsGrUoc
	 hQAyBIDXVbP00YD1O8V4EG6c1q4ph8CGGbpicUujCTnxN/M0Drtze4cfm9KVHeOBht
	 /TGnRP4W2qwOQ==
Date: Tue, 17 Jun 2025 10:36:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jason Rahman <jasonrahman@microsoft.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Adam Prout <adamprout@microsoft.com>,
	Girish Mittur Venkataramanappa <girishmv@microsoft.com>,
	"kbusch@meta.com" <kbusch@meta.com>,
	James Bottomley <james.bottomley@microsoft.com>
Subject: Re: md raid0 Direct IO DMA alignment
Message-ID: <aFGZofPWrNMT2rbW@kbusch-mbp>
References: <BL0PR2101MB1313AA35D88E8F547132B505A173A@BL0PR2101MB1313.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR2101MB1313AA35D88E8F547132B505A173A@BL0PR2101MB1313.namprd21.prod.outlook.com>

On Tue, Jun 17, 2025 at 02:19:11AM +0000, Jason Rahman wrote:
> It seems that rather than setting dma_alignment to SECTOR_SIZE - 1 in
> md_init_stacking_limits, it should be set to zero, and as
> queue_limits_stack_bdev is called on each backing device, the
> dma_alignment value will be updated to the largest dma_alignment value
> among all backing devices. Are there any thoughts/concerns about
> updating the mddev dma_alignment computation to track the underlying
> backing device more closely, without the minimum SECTOR_SIZE - 1 lower
> bound today?

I believe it should be safe to stack dma alignment to the least common
multiple of the block devices you're stacking. blk_stack_limits already
tries to do that, at least.

So I think you're right, it should be okay to not set the dma_alignemnt
limit when initializing the stacking limits. For any block device who
hasn't set their dma_alignemnt limit, it will default to SECTOR_SIZE - 1
later anyway, so I don't think stacking needs to explicitly initialize
it.

