Return-Path: <linux-fsdevel+bounces-77664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OUOKEyllmmTiQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:53:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E377D15C37A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 106163006F33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 05:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF91E2D0C94;
	Thu, 19 Feb 2026 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qqVrP+c7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B614B950;
	Thu, 19 Feb 2026 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480281; cv=none; b=S8g2o1G2PcCngJYyTwRsCZ0rO2QV/lY0YuM7m7kO79yq9Od7qpVp7UmD1QYqg1wjoIvYq0Yocv7TsgyY1dKXzH32z6ZWDMoGHT0aGgaRj15ouF71NEiMXbaC3+zbqW+aDmJqiP6B+OYdj/+TC8It37fDEOViLixgq4M392HshZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480281; c=relaxed/simple;
	bh=23yxitaLJh9K+F70KO9TUq3LVQsS0jR5Haq/qZlTDAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZcihD3kM7kqb9ZdafeuVolnyX7nBrhmaNyuyXKVrZYFyI/VE2D5xQtfpjr4D0PXIBJFg5bZ8fWI8FQgjMNqvXtlRXCD1t/h0kudoUUPmkz2ZFYkLrqQ4HDJDmPUaBOzUwk4z8IDXO+xhSRF2FzsxcSoW9/7J9hZgr0aJ8Bint8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qqVrP+c7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=23yxitaLJh9K+F70KO9TUq3LVQsS0jR5Haq/qZlTDAo=; b=qqVrP+c7XzoD6OPCU6RBJzmtw2
	I5nshpCAwFmUMLg2kvj86wUIcoByUmVFn5eBfe1EqEtWVm1n7bMVhIdoC2VDQ42qz8JUzxOJ1V471
	mWFajE+4S+CzlhuViP7rSDS9hsXUmoc1ZeqwrpfxjruglAqGazKSXm6+Jxr5I4wGGOsAk5aTq7lin
	3hBGt5/3J+8IXcE8cRAQTMG0zoHWUz34wYOqj+Idk9tr/ryjLwA0PJu+8EGQI4A2hgclzk/i0XWV+
	M+0P4SvnvMMX2/XdX34L4u2YuGXGacq1oea7CbLf/zF10MPnFERODL8n7BPIRSXju/ZAqvRPt09Jl
	tb9koOjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vswwQ-0000000AvQZ-1uRM;
	Thu, 19 Feb 2026 05:51:10 +0000
Date: Wed, 18 Feb 2026 21:51:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Tom Spink <tspink@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] Introduce filesystem type tracking
Message-ID: <aZakzr_QAY6a-dlB@infradead.org>
References: <1211196126-7442-1-git-send-email-tspink@gmail.com>
 <7b9198260805200606u6ebc2681o8af7a8eebc1cb96@mail.gmail.com>
 <20080520134306.GA28946@ZenIV.linux.org.uk>
 <20080520135732.GA30349@infradead.org>
 <20260218-goldrausch-hochmoderne-2b96018fbe5b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-goldrausch-hochmoderne-2b96018fbe5b@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,zeniv.linux.org.uk,gmail.com,vger.kernel.org,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-77664-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: E377D15C37A
X-Rspamd-Action: no action

I'm not sure what replying to an 18 year old thread that's been paged
out of everyones memory is supposed to intend?


