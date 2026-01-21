Return-Path: <linux-fsdevel+bounces-74861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBRhO0PccGnCaQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:01:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 678C158159
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D3A394D4BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED8D3D3CE1;
	Wed, 21 Jan 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TB9H8ELB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6F23D411D;
	Wed, 21 Jan 2026 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002991; cv=none; b=ZCXW0RaxUxUfZwsuksbO8h26wuduTqX6+/6nKtYuVXo4NYd+AQ2ldSQfn6X6mzGILcMzWV38iDfRlm0MxumDwRV8/RYIbZMymzYieN3dzHD3mA6Bcds/wfF1PxG5t8KXabivn/KliHeOpc6zM71DUsuajw+1EYQTHOATAYbzQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002991; c=relaxed/simple;
	bh=BPUSs+DRWFaZUaaeSKV+bFcPdPErDhU0WKpIbS8DUQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtoPUTnWS3RvsgtE0cX7TCdPigZ2JMEnWVctjF+SpppVfTzlOdZlV0opW3mXZVErcDyhP3YlRD+Dnssi6mvdc4QIuU6rtvGLapNakjeZEVY/6FgMncqm00Xv1AmQ/XDcL7zP5UOMPH42hzPr8TAECJOFVHzYvfIJtjn1UHI4vrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TB9H8ELB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BPUSs+DRWFaZUaaeSKV+bFcPdPErDhU0WKpIbS8DUQ0=; b=TB9H8ELBvyJ5o6fkmXBGE4HzcU
	9kZIHgbsSNMa8UTK1gr6PLdBQ9DQ+98G4MdYJXDwlKI0PDa6k0DF62m2e+9bxQypK70NS9dRgdjs6
	KCXrEmoY3uismyDUFAoTuWFzrMDI0CcIZOIrtnbmF2qrUo9RF6CcjMs8ATBLLdqTWaiHTiMjyMtgO
	JcxDOomHm7tIVdPaGybioLZHIcpzAd+6cueMVtff2W6tdFhMZDvf8HismZ+B6EnBY59n5StiREDMX
	eNy2Bzzuz3aqmAfhagGKItK8pqGb+aHz7q+K5L2970v8upiGS/HR81671xwwIG3QyJV4duuxa0Z85
	F1SeW3rA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viYU8-0000000GPup-13XG;
	Wed, 21 Jan 2026 13:43:00 +0000
Date: Wed, 21 Jan 2026 13:43:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, bernd@bsbernd.com,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] flex_proportions: Make fprop_new_period() hardirq safe
Message-ID: <aXDX5IXuvghtyZZU@casper.infradead.org>
References: <20260121112729.24463-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121112729.24463-2-jack@suse.cz>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[infradead.org,none];
	FREEMAIL_CC(0.00)[linux-foundation.org,bsbernd.com,gmail.com,szeredi.hu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-74861-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,bsbernd.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,casper.infradead.org:mid,infradead.org:email,infradead.org:dkim]
X-Rspamd-Queue-Id: 678C158159
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 12:27:30PM +0100, Jan Kara wrote:
> Bernd has reported a lockdep splat from flexible proportions code that
> is essentially complaining about the following race:
[...]
> Note that a deadlock like this is only possible if the bdi has
> configured maximum fraction of writeout throughput which is very rare
> in general but frequent for example for FUSE bdis. To fix this problem
> we have to make sure write section of the sequence counter is irqsafe.

Ah, that's why we haven't seen it reported before.

> CC: stable@vger.kernel.org
> Fixes: a91befde3503 ("lib/flex_proportions.c: remove local_irq_ops in fprop_new_period()")
> Reported-by: Bernd Schubert <bernd@bsbernd.com>
> Link: https://lore.kernel.org/all/9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com/
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

