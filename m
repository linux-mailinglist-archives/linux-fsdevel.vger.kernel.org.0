Return-Path: <linux-fsdevel+bounces-75247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OX4NFs3c2lItAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:54:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D4872C25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BEB301DB82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E838B3242A3;
	Fri, 23 Jan 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf0svvbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0426ADC;
	Fri, 23 Jan 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158478; cv=none; b=QclYgSvJ935sPkuAP7U7gSgHuYX1/aZPwCtWvRJXOTMBU47A73vglbtwxPJCDFOB60+49bQh3pBzezRYKzMnzD+g1tKzoq/i20WSReIxYTqLZp259auxQfbVEyrBcHzYAWm7chNc9bWQ9XSWfiZS6Gsi0HwPYjyi3VyPqdHk9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158478; c=relaxed/simple;
	bh=5tspAZvYOf1OZWpIiHGdZkAvcBDjt76r35rQpOx9fSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHxRs9TpTh2qK+x4/MChdMhvl0waeojhCMPeL1SshMGYRkyzxRC3D1l7rMMwUrimdHUTl+6DfYT5NAndy/cDqnpbacSS2XnGtfJDjlOGysM8TUEhLRRL5xtJ5cMX+xAAymIuoxruggcnQ/j99GNlAPXTj3dECUphUJk0jwf4Wqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf0svvbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A28C4CEF1;
	Fri, 23 Jan 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769158478;
	bh=5tspAZvYOf1OZWpIiHGdZkAvcBDjt76r35rQpOx9fSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uf0svvbflJV6wJ1uNwqneX5adAYNJRrmAeFHE2DCQPBSirRYca9lioUUJOoZyU91U
	 QLGyBa/TRbTFNFHd5KHuKjZa0VOWROpprk2KlzS269gWXA10IWI9WqweBZP8fT2LZL
	 ZS+ZSUsrGIT54oYsU/AqtctPhzSBGKt8OUl2Jn7bsSTVJcrJBrswCiCsJnnM1jZwEm
	 t7ng0Q/3r/TR+v8zDZbNSTKq5RfWRtwcHNrHWlBMydEq89FNerNrJ4tcJdpIxaDuSx
	 JkEUkJp0I8qQxD2mqnl4tbiXjVkliGnF17JqCllA3C+O2TosMUA+cRf9a2XYyVT1pH
	 PI1iTNaec6YFA==
Message-ID: <cf6099d4-6b05-4c74-b92f-ee0cf1ed15e1@kernel.org>
Date: Fri, 23 Jan 2026 19:54:34 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] iomap: fix submission side handling of completion
 side errors
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-7-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-7-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75247-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 32D4872C25
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> The "if (dio->error)" in iomap_dio_bio_iter exists to stop submitting
> more bios when a completion already return an error.  Commit cfe057f7db1f
> ("iomap_dio_actor(): fix iov_iter bugs") made it revert the iov by
> "copied", which is very wrong given that we've already consumed that
> range and submitted a bio for it.
> 
> Fixes: cfe057f7db1f ("iomap_dio_actor(): fix iov_iter bugs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

