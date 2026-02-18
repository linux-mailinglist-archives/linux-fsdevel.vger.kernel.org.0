Return-Path: <linux-fsdevel+bounces-77635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPQ2J7c8lmkycwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:27:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E226315A9EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5431C302713F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188333556E;
	Wed, 18 Feb 2026 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YCaFgtec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F37223DD6;
	Wed, 18 Feb 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771453613; cv=none; b=HVrHNt4IUEen9Cw3KUScSefK4CjB7+IaZmtoHKezrPo5o1WgEJ1cbeKbKElHmyyGzMcGi5F+x2QKDxEIOxyo0HF6t0keGxdee4FHEkDqgXCNCCcrrFzrb9RUETXrJiU3xPz64K+DNAEou57Ih4aCQWG6T68SufQxIkoU+9LhQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771453613; c=relaxed/simple;
	bh=iaIACN78TBqP85RyQV7yWMmTo81+wzL0JQ8VxTQglw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkDcMmcl2w37LVCJIUTBoTrz4MxWuwAAQq6ogRSzJHWcnOzCq/zUDRTaaEdh8j+u+TgdWNOtdk/aLScB94vpItFjHvjHruX+y3BT0/zoqi/sKMCWLU5qCQfO8kk1gsIIs0lHNdVhb1XJOBFMc1ze2iytZ+ztIUNl8XB7Cdj4wX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YCaFgtec; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V+AI2PSMhjEy+wYOIImmve2/jF2yiEoqib372fgT190=; b=YCaFgtecU9AVUeUGy1lSw7VSZW
	sVS4j6D4XfaarXSs8Qr+KCMOxlWc/Np7dR8/ALOxZJFNBcaobuYgmIDqqNQGdQ1Z1ZclhxRktlNeb
	8Rl+imJFIpY7e0writro7uZUvW1HG0rlF97noD8zU8nUaB29NZOfMtG2LCYye+Kr8OZlffkumMBB3
	msH2xWxqouToALfbCU1tYk0cDGOCbHfBVOLhoGC83Xvx/+qExF386nLF5SVUA4Tkw1i7a6pWBz499
	kg4MWO7eWKfOh/6BTyNi16AwDOVqq6SYDt/2Hsa4Dq/j4YhtDEexl0pqM0xRb+fF542eyibVI/5So
	6rEASZGw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsq0K-00000006jhG-3PA8;
	Wed, 18 Feb 2026 22:26:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9814A300B40; Wed, 18 Feb 2026 23:26:43 +0100 (CET)
Date: Wed, 18 Feb 2026 23:26:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/1] rwsem: Shrink rwsem by one pointer
Message-ID: <20260218222643.GC1395266@noisy.programming.kicks-ass.net>
References: <20260217190835.1151964-1-willy@infradead.org>
 <20260217190835.1151964-2-willy@infradead.org>
 <CAHk-=wjkyw-sap1dNkW7v8at8MvF3j5wshC1Gw3XEpHBbBw6BQ@mail.gmail.com>
 <aZYoXsUtbzs-nRZH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZYoXsUtbzs-nRZH@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,kernel.org,gmail.com,vger.kernel.org,infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-77635-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: E226315A9EF
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 09:00:14PM +0000, Matthew Wilcox wrote:

> Here's all the changes I made, and I'll post a rolled-up version
> next.

That all seems reasonable.

One small nit:

> +	if (list_empty(&waiter->list)) {
> +		sem->first_waiter = NULL;
> +		return true;
>  	}
>  
> +	if (sem->first_waiter == waiter)
> +		sem->first_waiter = list_first_entry(&waiter->list,
> +				struct rwsem_waiter, list);

Since that's multiple lines, could you wrap in {}, also I tend to prefer
cino=(0:0 style wrapping. That is, something like so:

        if (sem->first_waiter == waiter) {
                sem->first_waiter = list_first_entry(&waiter->list,
                                                     struct rwsem_waiter, list);
        }


> +	list_del(&waiter->list);
> +
>  	return false;
>  }



