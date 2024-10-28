Return-Path: <linux-fsdevel+bounces-33080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2279B38F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 19:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BADF1F22C2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 18:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9051DF99B;
	Mon, 28 Oct 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IhXhtoY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFE1DF254;
	Mon, 28 Oct 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139582; cv=none; b=rkv1jCYp+ht7jdn4cFsMcE+BmKvIjZSMy3CL5FUCS/TqOMfamLLTrRLvhbi0KZNYBtc7yW4mvlaKjp1NVCqmV9xNkon5tF2TCsC93tJl0Btoii8cbEhQiYs1zw44ewN8JyX/S99d/nAubx5YTwuz2jlTk7jf6VqOvIn5zOdxhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139582; c=relaxed/simple;
	bh=VtNXrQdHOOFnlzb2aIzwM2Na4zN1gnS0OqU181Pcf1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofJCoA5zgPP2YgooF9eZw0uwR1MC0ff+CJTeDy24X0n64bFBYTlseQNFs3fKFLaOioPXMwWkKDhPmxbOs9H6S2PBVSvRNn72J+0ZJo1lF39rut/Xr1JB9AKi0AeFdTiun6bozTUlmOiGiK+W2cQosNmdKfya7XCI+GQTpyhtQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IhXhtoY/; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XchVz68Mrz6Cnk9V;
	Mon, 28 Oct 2024 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730139576; x=1732731577; bh=VtNXrQdHOOFnlzb2aIzwM2Na
	4zN1gnS0OqU181Pcf1I=; b=IhXhtoY/1SgDTi0QzhE9RjmiQfm+Z39jRZttIwOq
	hT+Bcdq64+vgLi0whfU5lYW/CqJSTyMjL4PSRYIs0djO/62Iq/bjJqw//p3ovIFk
	EIPeL8acP/UvH5zRvh435EKgg35raOWZNga1JRGJVNmTb58QjWA2tn9ntGHEjL4w
	do/wBQ8bJvq9rOLb43avas9HxduqL6A0ZXTVbRoy5sn5keBc/ELUuOJXmFYTVGFi
	J4r39+z0o00eSQBdtfyvo4gdccge/7sUWlC+/luVl1z58XEqOOGhBJY/UjA8Tjax
	bEtqzx7H8uKroVIioVzX0IT/M1ehiYoLwWximNMBcitDtQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id S6r612HWI2P6; Mon, 28 Oct 2024 18:19:36 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XchVs5Q8yz6Cnk9N;
	Mon, 28 Oct 2024 18:19:33 +0000 (UTC)
Message-ID: <a86cfa72-426b-46f4-83b0-b60920286223@acm.org>
Date: Mon, 28 Oct 2024 11:19:33 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 1/7] block: use generic u16 for write hints
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>
References: <20241025213645.3464331-1-kbusch@meta.com>
 <20241025213645.3464331-2-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241025213645.3464331-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/24 2:36 PM, Keith Busch wrote:
> This is still backwards compatible with lifetime hints. It just doesn't
> constrain the hints to that definition.

Since struct bio is modified, and since it is important not to increase
the size of struct bio, some comments about whether or not the size of
struct bio is affected would be welcome.

Thanks,

Bart.

