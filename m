Return-Path: <linux-fsdevel+bounces-57812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F7B2575D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 01:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DD45880CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 23:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C592FB99E;
	Wed, 13 Aug 2025 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nqVXzWar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEA301462;
	Wed, 13 Aug 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127086; cv=none; b=ltdpxXMdbyv42ce46nIH+tq5QOy/clR5WpqKZ5gufSyiz3r13s0VxkLGcL6uKrNHIGs8waJVlGCGUaWPerHnaEpKFBS0FrPAPsFO1Uqyytws/h8/J6Hem5YOgKuAD6q+aRGDnBqF2Vl/bynrZS75kzD+DTr8y4/IBc3jUxpwWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127086; c=relaxed/simple;
	bh=XcpIxI3Kza+KlS7nav08N2XpPAC2+IEz61rOMpvZXxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCKTfocF85+rk6dcrftoAq11J4QJRdzqBdZrGOzi6PbSJZwz1bfBG92UlSZBTnAQQU/CiIDZXJhMOdAxjBCyhWCfXNmAVw6GrnDcShmGxqTZs4S2vbyOswK4F9BYb5+4mi7J9n//Got37FQrNbvNDTAug7DH5F2CFJf1/Dpih8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nqVXzWar; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c2PRv0lpQzlvX7x;
	Wed, 13 Aug 2025 23:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1755127081; x=1757719082; bh=AEV57I4CJV4Mttizx6a8pEEt
	tPypHfB0/YPycEt6mc4=; b=nqVXzWarOX4zMSFucbW7ffFZxP9HO34B9aWBnKKA
	Zm32DijgAgoCKh8LlL25ZxnKuHqjo51nYlgYYtjVc1TfyKLQIiB2xjbtHf/+dFTr
	Q3dViL6GZtDFQKDmx3NwOxt1zpAhvspLViCJ3c5A8Odbi5285cUhVv1wG3rBpuM0
	ry2QttQIgR5bVnkXxidmgHOxyoCchz34oSKbcF6mDgjtcjxH/43vN/jXJEZVfcgp
	dsrLy7oQo5BCFlP7rvuazuU/d7YnBGfhV3yfN7DvpCgLIpRForgeQlpePgGcBs9E
	qCG0SSXtbAdQ90mOSmKtCjAJgn7EcuiL1ur9Nk8GlADJRA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SH6xn7L3igvD; Wed, 13 Aug 2025 23:18:01 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c2PRj11tVzlvbmy;
	Wed, 13 Aug 2025 23:17:51 +0000 (UTC)
Message-ID: <279bdc31-ee29-4156-ab5b-9592e8297ebb@acm.org>
Date: Wed, 13 Aug 2025 16:17:49 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Hannes Reinecke <hare@suse.de>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com> <aJzwO9dYeBQAHnCC@kbusch-mbp>
 <d9116c88-4098-46a7-8cbc-c900576a5da3@acm.org> <aJz9EUxTutWLxQmk@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aJz9EUxTutWLxQmk@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 2:01 PM, Keith Busch wrote:
> I'm using the AHCI driver. It looks like ata_scsi_dev_config() overrides
> the dma_alignment to sector_size - 1, and that pattern goes way back,
> almost 20 years ago, so maybe I can't change it.

 From an AHCI specification
(https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/serial-ata-ahci-spec-rev1-3-1.pdf):
"Data Base Address (DBA): Indicates the 32-bit physical address of the 
data block. The block must be word aligned, indicated by bit 0 being 
reserved."

Please note that I have no experience with programming AHCI controllers.

Bart.

