Return-Path: <linux-fsdevel+bounces-51821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9097ADBD32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 00:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26160175375
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1072264A0;
	Mon, 16 Jun 2025 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZuNYZ7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0511CBA;
	Mon, 16 Jun 2025 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114017; cv=none; b=ns+aiICpCXqnKPl6R+/LobPzIwGgmqadFEE/n1opiX/thQjmFXEaUPyPXjEfG4KOZRlGwhAvlJvDBA11neGwRD0BGRemOxuROodUmfGnpJZ11OE89M8ePFkaA30q/HyEJdfmceHUy7PskVJuzV7+5tWrAuSs/7n4ALGECNOAQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114017; c=relaxed/simple;
	bh=LVGDu1jTuYYGVjID85EqlBD2xIV42eYPbWLzybbZ4TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4Djvk2vYVHtWRBlGh0ALGkB6QSFIwyB3zGo1VWJ4hMRXWd3Defgh5VvBtYxa2mSp6Yx7lJxL187Rzky7hCGVOFnMFqLR04wQZ/S6x2fgpxPB4qG7tvWcs6TlIS1J2bANF8+NRVrDO3EXsEqKM8Lof2tXpYp9pdWseipPn4TnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZuNYZ7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F22C4CEEA;
	Mon, 16 Jun 2025 22:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750114017;
	bh=LVGDu1jTuYYGVjID85EqlBD2xIV42eYPbWLzybbZ4TQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WZuNYZ7bKkO5i0xPtnqpblucSJ3ZpjVQFhezlPMH9wY1+YVC+692ASSNbHQVEEUoo
	 37ef1iKjodvEawf3GfoXfTIlt8S8wBDhl0ngObTl3RyXt5pBqhvypOtTykT9VE5hfX
	 Fjx1hnEMl+ieiBQlNho0IkJJuukXLiqGIliAwDvAPcmvi6lWu6EQXHYUY/6Y38M8zy
	 SCWkYIAp1DbAIhteWJ08e1ac60joSR/tmwSdVUjJjaLf7uSuclcG/8Z84/ehE9KSeP
	 d/FAkeyIXY4CGNSmnozt3rr+KMDFXYf3LudTFOx4DwS+wIiMlt6mHOJ6Bshu9CQO6F
	 KHHIe6B0jBDxw==
Message-ID: <8fd9ffe6-9228-40b6-bfdd-b8a281942075@kernel.org>
Date: Tue, 17 Jun 2025 07:45:00 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve read ahead size for rotational devices
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@vger.kernel.org
References: <20250616062856.1629897-1-dlemoal@kernel.org>
 <yq1zfe7xv9s.fsf@ca-mkp.ca.oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <yq1zfe7xv9s.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 6:24 AM, Martin K. Petersen wrote:
> 
> Hi Damien!
> 
>> Modify blk_apply_bdi_limits() to use a device max_sectors limit to
>> calculate the ra_pages field of struct backing_dev_info, when the
>> device is a rotational one (BLK_FEAT_ROTATIONAL feature is set).
> 
> I much prefer doing it here. I don't think overriding io_opt in SCSI is
> appropriate. Applications and filesystems need to be able to determine
> whether a SCSI device reports an optimal I/O size or not. Overloading
> the queue limit with readahead semantics does not belong in SCSI.
> 
>> For a SCSI disk, this defaults to 2560 KB, which significantly improve
>> performance for buffered reads.
> 
> I believe this number came from a common RAID stripe configuration at
> the time. However, it's really not a great default and has caused
> problems with many devices that expect a power of two. Personally, I'd
> like this default to be something like 2MB or 4MB. MD, DM, and most
> hardware RAID devices report their stripe width correctly so the
> existing "RAID-friendly" default really shouldn't be needed.

That sounds good. Recently, I have been doing a lot of performance benchmarks
with large IOs on HDDs (2, 4 8 and 16 MB IOs). And with the improved memory
allocation these days (transparent huge pages), even a simple malloc() IO
buffer can have far less memory segments that the HBA maximum a majority of the
time. So doing such large I/Os is fairly easy and really improves HDD
performance. And in that context, the current default 1280 value for
max_sectors_kb is really a limiting factor. So I am all for increasing the
default to something like 4MB. I will send a patch.

> Anyway. That's orthogonal to this particular change...
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks.


-- 
Damien Le Moal
Western Digital Research

