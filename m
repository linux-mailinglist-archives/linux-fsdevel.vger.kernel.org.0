Return-Path: <linux-fsdevel+bounces-75248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKwBIqk3c2lItAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:56:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4D972C52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 868BE300BE98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C931A571;
	Fri, 23 Jan 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4TCPNZy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4323D2B4;
	Fri, 23 Jan 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158548; cv=none; b=DFwicvK4liswtoypn2NLSm6ulrXPPxsOoB/pqpQVWnDInT34cDivLsEsFvJaVfCsqHcr/xNc5nTLtiO5EbW5EvJGoMM+t6zO55OzGBY36jgRgkJow91jdMwPOIW0+81DnnC9oFe3I4OQiNxcdnfs0FRrZnbmvXI+tbHmSWojXYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158548; c=relaxed/simple;
	bh=D2STUJJevpR1tZfKzuqQPSXtPsstfQuMrp0UWl6vYkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtUni5EV12ekQ+lTXPxPQqp53xwp+RcOSbugCUo8H53gTbWFXzzdPV8LdbA14hhKhfV2AiQWhg1fG9LtDUB3zMDbyO0pkia27AuMOkYDWB0TBOnwbzMb/rrhptunfhSw7cL1Yho7G9K1rpizYjaIDo8uXp4wdxF86S460n1jdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4TCPNZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E5FC116D0;
	Fri, 23 Jan 2026 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769158548;
	bh=D2STUJJevpR1tZfKzuqQPSXtPsstfQuMrp0UWl6vYkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l4TCPNZyS9Yc36pw3fs0/9/Fcy/yRu/1/cs3jUycB9RN3tm4ShmrVAZrFWzmVvK23
	 W2uPkHbAd5DkHEs22oFaycAYVHda4ZD021cf2dCVxXv1oGyagkZFylknGPiEwOc4w3
	 hGOs8gy/19lDos4WpA17gLZ1HFw5OKg7sxZbchNWKGvOi48E0GjFbF+6+ehWdQM7v+
	 Rt5djmgJHRfsDTJa5sG376uC6TICrDPzBuCRtnelD9EIkNH2XV3GGXI/2Esja/4RPM
	 ZmsnsaHiwRZpOCy6nD+6gqM4bh2y5k/xtFXn1Bwk5W9W7g0CboL5s/1EQEkFPvrvAz
	 kc9mJlBlngoWw==
Message-ID: <5d471215-c06c-4eda-afd7-68876616e923@kernel.org>
Date: Fri, 23 Jan 2026 19:55:43 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] iomap: simplify iomap_dio_bio_iter
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-8-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75248-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B4D972C52
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> Use iov_iter_count to check if we need to continue as that just reads
> a field in the iov_iter, and only use bio_iov_vecs_to_alloc to calculate
> the actual number of vectors to allocate for the bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

