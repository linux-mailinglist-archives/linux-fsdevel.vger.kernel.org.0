Return-Path: <linux-fsdevel+bounces-50414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D925ACBF82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 07:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A003A5CD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 05:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B3418DB29;
	Tue,  3 Jun 2025 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjrxMipn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D744C77;
	Tue,  3 Jun 2025 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748927852; cv=none; b=QDlpOk1gkeGKhhYOeCn8sGsvLVt9ADWJQEFnhQG1TkFj8P5nrm+59gulqtsC6a+fCAyl7yt/ttdcECY/KnXVo5JrInKYsqZFbUZNeGrSfuvosiJ2U3R+9YkcWHLa9c7TN5eOJ4G7abhSL/zsj6pOXe4ZRrDfvCzdzXSz3V/x71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748927852; c=relaxed/simple;
	bh=MLe0KyADv96wFzx4eXyUYSSu1c6CrcIQIbqW6W/530c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+qZhYmRaeDdXs4xkSjNJEMGWTWd9wT6BzbeL+spMhJWz3eaCEzNIuEGzM7XL28ynj8yZzi9ORI6msQpKQO0S23df7Pgmol+7ZUayGLdk0dUnfLrJKjN91yBdGxZbhulLDihiESHVoV33SDGx8yIVKyv+HumnYX/8Yz4lCyX6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjrxMipn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DA0C4CEED;
	Tue,  3 Jun 2025 05:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748927851;
	bh=MLe0KyADv96wFzx4eXyUYSSu1c6CrcIQIbqW6W/530c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UjrxMipn1iVdrRExtBaVyIWTvrHxa+twCzDb3Yf962uWkj3mlRt26fWEnpLvG/CeN
	 VbXExsLimMLWmFz7zpA4Y+IHgQs2E4AGAWDrLbtyFqQIzb8rWDbEkFEs2rr+evSVnT
	 j08hcUYmHQXq0Yipar4BGIE3IjsjYg/CCJy79sqpNFNtc8J9MwXJa+35eQE3FkcaPq
	 +0yRfQjEwocR50koOpo14pFk9sueyubX97tWckSEr8sOxxdzL46zSSZguu3dLu0C9v
	 6GfY69Gzfts0+xKkvMhZ2UVONxqh0ZUNzDKpnJYryLGdaMaN9xZs+obB0ns+cB5X/b
	 NWtYZe6lq8mUg==
Message-ID: <e2b4db3d-a282-4c96-b333-8d4698e5a705@kernel.org>
Date: Tue, 3 Jun 2025 14:17:28 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: Christoph Hellwig <hch@infradead.org>, Yafang Shao <laoar.shao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, djwong@kernel.org, cem@kernel.org,
 linux-xfs@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aD03HeZWLJihqikU@infradead.org>
 <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
 <aD5obj2G58bRMFlB@casper.infradead.org>
 <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>
 <aD5ratf3NF_DUnL-@casper.infradead.org>
 <CALOAHbB_p=rxT2-7bWudKLUgbD7AvNoBsge90VDgQFpakfTbCQ@mail.gmail.com>
 <aD58p4OpY0QhKl3i@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aD58p4OpY0QhKl3i@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/06/03 13:40, Christoph Hellwig wrote:
> On Tue, Jun 03, 2025 at 11:50:58AM +0800, Yafang Shao wrote:
>>
>> The drive in question is a Western Digital HGST Ultrastar
>> HUH721212ALE600 12TB HDD.
>> The price information is unavailable to me;-)
> 
> Unless you are doing something funky like setting a crazy CDL policy
> it should not randomly fail writes.  Can you post the dmesg including
> the sense data that the SCSI code should print in this case?

This drive does not support CDL, so it is not that for sure.

Please also describe the drive connection: AHCI SATA port ? SAS HBA ?
Enclosure/SAS expander ?



-- 
Damien Le Moal
Western Digital Research

