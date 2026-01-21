Return-Path: <linux-fsdevel+bounces-74937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHjgLzdhcWkHGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:28:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBE5F847
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A492298C306
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26208343D74;
	Wed, 21 Jan 2026 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ao+RHABZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0A23A99E;
	Wed, 21 Jan 2026 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037998; cv=none; b=t7AbBfceBSPGOMy9FltYvDcA+Xs7A7XghnXsiDWRyGCDKGf804uAKzo1vEI6jp9XzjJOb71LRprZwIJwC/vbbnrYs5eBCaN4iDEVGhjAUz1GRaK/xx6+nZHjvXLCMhW7o9LkNlhuBIMo9ZkT9D0D/BJ/MEEI46T3xK8YATJNR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037998; c=relaxed/simple;
	bh=kcQHkUKp1SjMbh7K0xzUeeer+Jw+MfHqvaWcaX6zmiU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jmvoQK020OI9ED6buJGOqLAi1XamdlNmhQqQ5HnOsvI8Q3cqEWwmrkQ/sK+87Ke3KnL1Jt8VZG05n6cLFaCB3C1CECGK9cWkWZ4Ai4MAmzrU2M9DxuNOkbk3TRxLUf2JzNEsVUIHFW5VI8OxTNvj6GWPPpkMtIiwsSDiI7QmoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ao+RHABZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tMWWX7HsqJ3ljAFcwqBEgriz3Rdl/95aGxaN9VUpAOI=; b=ao+RHABZIpt0Ho9w4kNITNOA2U
	wzy6NOXwxbeI4dRvbkQgetDbS57koUt5hpwOEz+X/mJ8uSkHLRBZc+nhZiRdaiyP/MXItJh6S2da/
	ur2idGHiBwBANYn+4IwB09xbU/5OOOUQQt3LgUxnU91krpkrA4ZXLNiO65DMOsaz88Tc4TGP6s2lk
	X47IppplwPpVK2oPYh4wqa0b55ZKcgNb8AP1wJG3hNdFlh3zj8mwkOWN3u7sBrlzqFFtyeEaSIH0+
	o5kyIvg3/P9IzjT66mzh9vQr3kMg5H4vIEYmGfrkCI9x4hOOU9BF8TzRtNjTj864AZuSREbKBXE6M
	TvH6jLIg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vihar-00000006AwT-1vRF;
	Wed, 21 Jan 2026 23:26:33 +0000
Message-ID: <9680d4f2-4bc0-4093-8a7d-7142c5d490cc@infradead.org>
Date: Wed, 21 Jan 2026 15:26:32 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: filesystems: add fs/open.c to api-summary
From: Randy Dunlap <rdunlap@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20260104204530.518206-1-rdunlap@infradead.org>
 <871pjpo0ya.fsf@trenco.lwn.net>
 <501f8b16-272b-4ea5-92ef-6bdb6f58f77b@infradead.org>
 <c7d47b56-2d37-4893-b8ec-1fb23f75a55e@infradead.org>
 <87wm1hmk82.fsf@trenco.lwn.net>
 <7db41ccc-11c8-4d3c-adbf-9d4f1f70f386@infradead.org>
Content-Language: en-US
In-Reply-To: <7db41ccc-11c8-4d3c-adbf-9d4f1f70f386@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[infradead.org,none];
	TAGGED_FROM(0.00)[bounces-74937-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 75EBE5F847
X-Rspamd-Action: no action



On 1/16/26 2:24 PM, Randy Dunlap wrote:
> 
> 
> On 1/16/26 11:27 AM, Jonathan Corbet wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>
>>> Seems I was confused with fs/namei.c, where I see similar warnings.
>>> I don't see those warnings in fs/open.c.
>>>
>>> I'm using today's linux-next tree, where the latest change to
>>> fs/open.c is:
>>> ommit 750d2f1f7b5c
>>> Author: Al Viro <viro@zeniv.linux.org.uk>
>>> Date:   Sun Dec 14 03:13:59 2025 -0500
>>>     chroot(2): switch to CLASS(filename)
>>>
>>> Do you have something later (newer) than that?
>>>
>>> Also, at fs/open.c lines 1147-1157, I don't see anything that would
>>> cause docs warnings.
>>
>> No, docs-next is older - based on -rc2.  It seems that linux-next has
>> significantly thrashed thing there, and the offending function
>> (dentry_create()) moved to namei.c...
> 
> 2 patches have been sent for these warnings:
> 
> 2025-12-19:
> https://lore.kernel.org/all/20251219-dentry-inline-v2-1-c074b5bfb3a6@gmail.com/
> 
> 2025-12-31:
> https://lore.kernel.org/all/20251231153851.7523-1-krishnagopi487@gmail.com/
> 

Oh, so a third option was merged.
https://lore.kernel.org/all/20260118110401.2651-1-jaybenjaminwinston@gmail.com/

I only care for backporting reasons:
https://lore.kernel.org/linux-doc/202601211140.pWd7ohTh-lkp@intel.com/

since I am being blamed for some new warnings and these patches fix them (except
that they have been moved from fs/open.c to fs/namei.c).


-- 
~Randy


