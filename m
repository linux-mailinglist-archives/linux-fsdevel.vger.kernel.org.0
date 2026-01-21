Return-Path: <linux-fsdevel+bounces-74935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAnIFMRgcWkHGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:27:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C05F7A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEC50607B50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99394338905;
	Wed, 21 Jan 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="RnxCtGYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2543B8D70;
	Wed, 21 Jan 2026 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037662; cv=none; b=S+MUrTCY/0F3aH1kgaqnxHiTISL6MhdQLga3HlWf4w7KHHaGMErSsKdErLNUbGtcQwrltu4XedNmvgZqG059I+AGDodMyqMNynixaPtw08bsYn3QyEkZrrEQWoeo3AC88VcR14422DyJn0q5SzjW3aFGPIcPKXqvIozZCsgyvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037662; c=relaxed/simple;
	bh=OGS/fNnlPes+JePKrm0CsA/gNGfnZi7LTgyUV5rtYQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoAG46aP1YQ40jthyzvwgKbX0adGnxPJ5xHzXjajf3+dI2WbCoJOCnWTXvFs9yO7J2V/di+Cmfbdvj8hE3wWFt42QYLuIxkvjRDMT0e67+UhUONHFltPPUKtudmGjCUwSgpDeAPZKEqpXRJk1m3ZL3COyVUs5f/Y8fhdOlMMyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=RnxCtGYR; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0CA0D14C2D6;
	Thu, 22 Jan 2026 00:20:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1769037651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CuLgIEQicKxAzOp7ggur18BjDbH0Izb2IJBPplUcKjY=;
	b=RnxCtGYROU3Pzp2Z6VJ6IjGSi82WzhLXQc24UTMxeHcSzMD7dKgx/s1lQ88dCz+4EKmJbu
	0CGoB0nFkL0VurFlq1k/wtHBeu1decs5N6FkwlJIIaCxZQr8Rl6DCEO8k/RQl/4ruMm9yM
	e/dvKLZzP6oX9xZVUoM3yrBr+0KGgmvM0zYThcfFKp28ZECgcdNmWnngl3FAp/YV3ivqG0
	aHSag9Vwx0hi/RdFekpyOC74Pk1PNFvi92UlvgBTE4qzHrpvy/WeH7yFYKnoxg3SFmSlDt
	GQYzFqPj/Nbte+2rHZw8SzqNROl008NDHIe9tjY5OrGDk+VMxG6kg7adLupryw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 6abc6ff1;
	Wed, 21 Jan 2026 23:20:46 +0000 (UTC)
Date: Thu, 22 Jan 2026 08:20:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	v9fs@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] 9p: Track 9P RPC waiting time as IO
Message-ID: <aXFfPweqq25iE-UC@codewreck.org>
References: <cover.1769009696.git.repk@triplefau.lt>
 <47f0b44f159084f4032a9424e0e2e586b8640a12.1769009696.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47f0b44f159084f4032a9424e0e2e586b8640a12.1769009696.git.repk@triplefau.lt>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[codewreck.org,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74935-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2D3C05F7A5
X-Rspamd-Action: no action

Remi Pommarel wrote on Wed, Jan 21, 2026 at 08:21:59PM +0100:
> Use io_wait_event_killable() to ensure that time spent waiting for 9P
> RPC transactions is accounted as IO wait time.

Thanks for splitting this out of your other 9p improvements!

I was about to ask Peter/Ingo which tree this should go through, but
could you also convert the other few wait_event_killable() calls in
net/9p/trans_*.c ?
They're either waiting for other IO to complete (virtio x2) or for the
current IO to complete (virtio/xen), so I think they qualify just as
much.

(the virtio ones will likely conflict with some other rework that's been
dragging on last month, but given the patch is trivial it won't matter
much, you can send as of master)

Thanks,
-- 
Dominique Martinet | Asmadeus

