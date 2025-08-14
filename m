Return-Path: <linux-fsdevel+bounces-57822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77360B25940
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 03:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A997880412
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 01:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840321C9F1;
	Thu, 14 Aug 2025 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYALRBxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC521B9D6;
	Thu, 14 Aug 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135918; cv=none; b=duJu1ujakaMDFhmtuo/hkrWrHA2aqWkbQz72HeKzvrT5tKjSYQKS0PebncPtL92NShUtH4Rd7FREMC/FfWWY0aL9B/1MfEqOsoCo8zXMQRItVhgia+Ue6KEPFgcSr7KfW7YdVDzvm1lxRMh10ium4g25EUcjD7+QRPrrefyH7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135918; c=relaxed/simple;
	bh=i1y7qQa9SFhRvqFt20v8XEo9Q9dbavK0njZxN1E1hEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QR0CiZCYxRyFtSBTcvvPfLwtRKtxqieXD6SQe+YnG49n3l8i8XXjDVRRrxLKXck+Eru6+/Aucp7dbNVXZZTTkZt80YEQ8+NllExpRUsiOnceIWgtzyr7Y1bsR+L6Uy0rdd5I8qtX6ln//GQ17g7fxlLw2r/cUo+WAjvVPehiWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYALRBxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0192C4CEED;
	Thu, 14 Aug 2025 01:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755135918;
	bh=i1y7qQa9SFhRvqFt20v8XEo9Q9dbavK0njZxN1E1hEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YYALRBxUqMJ+a9O2DJA0OI+d8U2eVb4vghGmYmkHPuACCSxiAyNFcZN9CKtvACSnq
	 JtBXiJAprlL8dieMg+YUqZenFdoYTMQM3qCM+sFvAfw0ZJKnbklA3b1CCl2sLivabS
	 Jyq6QcJ/hMtxUC2Eg7vb0AQozFUM9UiuiGe9B4S/t6LZGASKEg85nJKT4oYSFQfhvZ
	 Jj7SP53EACoQARdrD4OiletkRcQ2NAy0nPdYU63lTkQNSnyXo4zTd/5YA8SzP1SlTy
	 9W5wuCcs94qevo8gdrhzjCK1E9zTB7stWmlDMvju/ewfItbTbiTzR2/uUz/AU5OQok
	 ggHvEA8Ed32cw==
Message-ID: <b6860c56-e91d-45c8-8d4c-05bcae97a2bb@kernel.org>
Date: Thu, 14 Aug 2025 10:42:35 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
To: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Hannes Reinecke <hare@suse.de>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com> <aJzwO9dYeBQAHnCC@kbusch-mbp>
 <d9116c88-4098-46a7-8cbc-c900576a5da3@acm.org> <aJz9EUxTutWLxQmk@kbusch-mbp>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aJz9EUxTutWLxQmk@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 6:01 AM, Keith Busch wrote:
> On Wed, Aug 13, 2025 at 01:41:49PM -0700, Bart Van Assche wrote:
>> On 8/13/25 1:06 PM, Keith Busch wrote:
>>> But I can't make that change because many scsi devices don't set the dma
>>> alignment and get the default 511 value. This is fine for the memory
>>> address offset, but the lengths sent for various inquriy commands are
>>> much smaller, like 4 and 32 byte lengths. That length wouldn't pass the
>>> dma alignment granularity, so I think the default value is far too
>>> conservative. Does the address start size need to be a different limit
>>> than minimum length? I feel like they should be the same, but maybe
>>> that's just an nvme thing.
>>
>> Hi Keith,
>>
>> Maybe I misunderstood your question. It seems to me that the SCSI core
>> sets the DMA alignment by default to four bytes. From
>> drivers/scsi/hosts.c:
> 
> Thanks, I think you got my meaning. 
> 
> I'm using the AHCI driver. It looks like ata_scsi_dev_config() overrides
> the dma_alignment to sector_size - 1, and that pattern goes way back,
> almost 20 years ago, so maybe I can't change it.

That is probably buggy now in the sense that the scsi layer should be able to
send any command with a size not aligned to the LBA size or ATA sector (512 B)
and libata-scsi SAT should do the translation using an internal 512B aligned
command size.

What makes a mess here is that SCSI allows having a media-access command
specifying a transfer size that is not aligned on the LBA size. The transfer
will be "short" in that case, which is perfectly fine with SCSI. But ATA does
not allow that. It is all or nothing and the command size thus must always be
aligned to the LBA size.

I think that dma_alignment was abused to check that. But I think it should not
be too hard to check the alignment in libata-scsi when translating the command.
SAS HBAs should be doing something similar too. Have never exactly tested that
though, and I am afraid how many SAS HBAs will not like unaligned command to
ATA devices...

We also have the different alignment for management commands (most of which use
512B sector size) and media access commands which use the actual device LBA
size alignment.

So it is a mess :)

-- 
Damien Le Moal
Western Digital Research

