Return-Path: <linux-fsdevel+bounces-57791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC6CB254A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DDA1C278C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14132E2DC1;
	Wed, 13 Aug 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="35CyZhck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3562D0274;
	Wed, 13 Aug 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117724; cv=none; b=lOqK+dQYQ9qhClSe+2s4ETQ9lBDnGAtHiFCvejHH8smrDr6pdnhxXOjSWX9Yfo5GCU6hlHEjYJT3fbulsr7E5t3s8X8IESlAEUqU2IWZ0fQFXvu7L+Cc9mHIpCoxRtRA3JIgsKVLhkmX4NN+kSopkNqTFYDqQAxDekEiT3E98mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117724; c=relaxed/simple;
	bh=l0wFwJK64AHLjsb5vW3L0oEVz2gOka5eXWl+rN9RcE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWaJz5NLOZAhcit4dTy1G1khVSgMJBk0cwYpqdaemldG6ykGsvt4YjuP3USouqioI+XXE6NQJkXHk8z+3LkYKRUpSeAoP2kW7LQMbY3Z7mQXgtZmR3qeQxlxwyBGdV2BAAmH4qoWa8feoLvK7b5ncd4NaMzTmPwjjSebJ+i1fOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=35CyZhck; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c2Kzs31YQzm0yR0;
	Wed, 13 Aug 2025 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1755117719; x=1757709720; bh=p4WMof99Ip0ck6Xa/HLLLzK4
	iNdF0X6l6tTJ53Q/PJ0=; b=35CyZhckXTlwbSvUYXnTmucKPxeLkFSsyvqwrl1M
	Sxm6hNiaTR7YCn+jrdPxSf/kCrbG5LME09kwMmCxqrUjotbkfQKhkOYikMTemfdR
	+oAS+m+1zc0YYETi02E2JapgKUsRQiz86C5zp5ptrTuKhJR6tZcWYGU7YsV1IsYz
	mQaIiUHoTbpIhls9dlTum5Y1v37mY3gY1qRefgdvLadB03OhnoPp4BEQYGwiRfAO
	GAWsz23pDgE5IGMpMOwabTNFbnF3lE2aAxOmATbrZ3Ui7NT+8L//0ysJTKti7/I2
	gv0KcMDXUB/jZvc6ibW335SaWz2ZFNgkDr7xBNZjEPlTmw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wkBrp2rNFc5M; Wed, 13 Aug 2025 20:41:59 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c2Kzg3s19zm0yVk;
	Wed, 13 Aug 2025 20:41:50 +0000 (UTC)
Message-ID: <d9116c88-4098-46a7-8cbc-c900576a5da3@acm.org>
Date: Wed, 13 Aug 2025 13:41:49 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
 dw@davidwei.uk, brauner@kernel.org, Hannes Reinecke <hare@suse.de>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com> <aJzwO9dYeBQAHnCC@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aJzwO9dYeBQAHnCC@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 1:06 PM, Keith Busch wrote:
> But I can't make that change because many scsi devices don't set the dma
> alignment and get the default 511 value. This is fine for the memory
> address offset, but the lengths sent for various inquriy commands are
> much smaller, like 4 and 32 byte lengths. That length wouldn't pass the
> dma alignment granularity, so I think the default value is far too
> conservative. Does the address start size need to be a different limit
> than minimum length? I feel like they should be the same, but maybe
> that's just an nvme thing.

Hi Keith,

Maybe I misunderstood your question. It seems to me that the SCSI core
sets the DMA alignment by default to four bytes. From
drivers/scsi/hosts.c:

	/* 32-byte (dword) is a common minimum for HBAs. */
	if (sht->dma_alignment)
		shost->dma_alignment = sht->dma_alignment;
	else
		shost->dma_alignment = 3;

Bart.

