Return-Path: <linux-fsdevel+bounces-75440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGf8J/8Id2lGawEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 07:26:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908D847F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 07:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84944300D443
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D4274658;
	Mon, 26 Jan 2026 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6g2FgFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F41E98E3;
	Mon, 26 Jan 2026 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408756; cv=none; b=ck67HBEKCigmgARY4w2E/pCltwJF2VAYMXG8TVwpPt5JxI0JEtoTwwyJHkg2UfDZn3+EGS9QYXBmR0jImJWEmVRtj6BesEtlI3TPKSAwjM/Oe24Gmk6YyfyYl8P0C4rAJ9U8RJ+CJfJBXcH1wNlwOBYAMCu+WLJSb3CElx0HHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408756; c=relaxed/simple;
	bh=SSqDAoXbgjcNNsaZbS/cwuJuFxnb/y1raEv1zXP2ORk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbUaSrC98sYLh1UlhQ6TFVVoYnKn2cEfwAPUMyDKiHkU4wS4bpUOkPQuaHWUowpfNJ6tFNmOfJI4A5Miu8dv5/6UGPjWBXyok+lmBnB4oa2lFyf2Dwo0+w19xG+7802IBOBgG7MKL3wSoBYaYKXvGjv6O+McerwJQOEWEI3fOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6g2FgFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F7AC116C6;
	Mon, 26 Jan 2026 06:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769408756;
	bh=SSqDAoXbgjcNNsaZbS/cwuJuFxnb/y1raEv1zXP2ORk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i6g2FgFFAcGBl9re4KFa+A8ZYe7oQbIy6AVBDF3BWBbfh5PKr8cbNf/AnY7jcwf8B
	 7l+P4R5f4KzNsrLZ6h8zApw8Qom6+KMaMB5ouy/oD4O2R2trxn0I3v5pyAZ/p89THx
	 439i+wclbK3sxM72azYn7GUk0Vwa9Nt40OePyIasqqIeB6eEtV9X0b++cv4euc5hOG
	 XxHcFT4ZIkhbkkEJL6zeUW7yJiGjyIXP3nFz1liWJgyhwV9EC0y2MOVHVA4QxBXFc2
	 bBJJ+T8iBS4L4rMRIxn3+OD9Bu6lZghaiySUGi0STgfhb0ilh3QYRBU3i+7XjIQHdR
	 +/sQST6FXQf5g==
Message-ID: <55acfbf0-67f7-4acb-9d3e-ae608263cdb4@kernel.org>
Date: Mon, 26 Jan 2026 15:20:56 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] block: add a BIO_MAX_SIZE constant and use it
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260126055406.1421026-1-hch@lst.de>
 <20260126055406.1421026-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260126055406.1421026-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75440-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 3908D847F4
X-Rspamd-Action: no action

On 1/26/26 2:53 PM, Christoph Hellwig wrote:
> Currently the only constant for the maximum bio size is BIO_MAX_SECTORS,
> which is in units of 512-byte sectors, but a lot of user need a byte
> limit.
> 
> Add a BIO_MAX_SIZE constant, redefine BIO_MAX_SECTORS in terms of it, and
> switch all bio-related uses of UINT_MAX for the maximum size to use the
> symbolic names instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice cleanup !

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

