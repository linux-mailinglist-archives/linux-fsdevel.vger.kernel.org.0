Return-Path: <linux-fsdevel+bounces-75241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFkWD+Qzc2lItAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:40:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB0772A00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A96309387F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8386E319847;
	Fri, 23 Jan 2026 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwlmIziE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFF22127A;
	Fri, 23 Jan 2026 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157336; cv=none; b=EsUaz2RLYgBi89POgxY1VUc71qOaMoWMdeHUpvcTIatDV2PjUFfTmCxN2e4OqKdk7ZPuU1SYgDUrvdBMi9BtYAPN0lCJ90WFFBm3j4+1qAndiOni8wLsz4jFJBQpfQczBAyfoVLxfhPxEIF+1C6tDOjLLYmdSAk9WM7cBKXzMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157336; c=relaxed/simple;
	bh=YWoxs7nsFFibtQyfdgCURZOgdOC2+7Z/xUCkrnzIlls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mI+CTmyjxrNmosGl3+dgYyq44avqMYmyeBDwRxIeEo3IyBnG2FZoZePwDK+SxipreoPgMKxSm+D2HC/NQDy3sP7e+hvvtBzchQ3urZnNnGW5uLAtgSDL2bKQOWG5yzeQjBcZwHMfoKbLuz6hLvcmgg1Lhjq+t+9peAGpFEt72nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwlmIziE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FC1C4CEF1;
	Fri, 23 Jan 2026 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769157335;
	bh=YWoxs7nsFFibtQyfdgCURZOgdOC2+7Z/xUCkrnzIlls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QwlmIziEymIVxPmhmgZxGg4K2UbMaODC5vWsI9ypVUJuBjGsM1fzUYn+zVrlrgR5N
	 SX0c8EiKbXKqdJQmzxunGYW9J+w89uxpqVTLElzk/uA5HqlKFre9oknNMr/kjdB7PY
	 v2ACbwNPQrohTP2L/Gzi1CDaLuFX66PjoGxfobXIiqB6P8pr9rso4t1ylyVCUQAsGi
	 9L24HjvuyTtzhYJt4qVSQWu9k2rKaS/G6Rcq4AMeE54xFKIzTdEzIUcRf3EFgmihSX
	 qoGi0lgTJOQHIufIhX9FOzAQhyM5/TTGvL0Srrc4ftutp2X3CkEl7zRfEY3rGAIQB6
	 lqZJu8GRB9/SQ==
Message-ID: <3b15d90f-ef86-4ecf-a21e-1e748075868a@kernel.org>
Date: Fri, 23 Jan 2026 19:35:31 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] block: open code bio_add_page and fix handling of
 mismatching P2P ranges
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-3-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75241-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: ABB0772A00
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> bio_add_page fails to add data to the bio when mixing P2P with non-P2P
> ranges, or ranges that map to different P2P providers.  In that case
> it will trigger that WARN_ON and return an error up the chain instead of
> simply starting a new bio as intended.  Fix this by open coding
> bio_add_page and handling this case explicitly.  While doing so, stop
> merging physical contiguous data that belongs to multiple folios.  While
> this merge could lead to more efficient bio packing in some case,
> dropping will allow to remove handling of this corner case in other
> places and make the code more robust.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

