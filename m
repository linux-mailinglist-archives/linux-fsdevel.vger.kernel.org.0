Return-Path: <linux-fsdevel+bounces-77814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNKNLLyqmGn5KgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:41:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE516A248
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C8423025E66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCA2366803;
	Fri, 20 Feb 2026 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lftq8RNq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173A366066
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612857; cv=none; b=tXOo0gOSe4CM3MICcVg6VZCSGJqpS0AhlV8wezH6OLXcV0MEPkJM38LMW2L8/J68b1XkS4MIoH/MRhjsF2qgTGeCn1g020i5FL4F5FOCcdRLY7il3k2UGEdizKTFGOXqhFCeQWW+jtLAD0UyUMPRT4/0JkvPOOiQXc9aAdHEPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612857; c=relaxed/simple;
	bh=QJRu6ie7e52j/TbGIrWuPslxz/Fx+zg/B5ds4yz/zwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usxSv/UmkF6QRWSngFLBfhBhgmiI+EfD0ZFnqGw+n6S6Yw6663SLrT4j17MRY/d+BEWapuZQ6AotVqTeQ0d9/jDaufSihlgyreijKbYRlvfmTiNccnKgRLf5sCDeRxQiSyYSr16Yk1Ni6WvDetXUCPR1laziQHqX8NT8WB9DwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lftq8RNq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Svo7BSgQV4vCJSDKQ04CEuFAs/IZlnbqXYSdfZ0/Cv0=; b=Lftq8RNqkiD5bR6H7u3Dfw/kRW
	O2I+2JavXhryv9T191MyUNBhtlTbI+gApgh9CZaGKbTzkapV7XjzxFpkqg9BJZO+5ezuiBQSd/kHt
	xYGM51EEfPu6P283MIn6UKTAUTG5RXB7xYEWa5nu6GqLAnHtfFgfa73Qg1C78HK6YEIcZ/1fQqtAy
	ZGzzpHaDkEd3WruJG8qXLUFFJ0KBYHzLXup/GJKxZgeeOglT6tdT7ueJsSiUsdBrA78a35pS4wCl/
	2tbwyjfOWasI05Lnf4eomtl/yP79RKSBAiQmt4VO+pwmvMDCabwylrdVXMjpLuJa0KBwLn/7sD9Ln
	LDmx4fbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtVQn-00000009zoX-39c0;
	Fri, 20 Feb 2026 18:40:49 +0000
Date: Fri, 20 Feb 2026 18:40:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Nanzhe Zhao <nzzhao@126.com>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, yi.zhang@huaweicloud.com,
	jaegeuk@kernel.org, Chao Yu <chao@kernel.org>,
	Barry Song <21cnbao@gmail.com>, wqu@suse.com
Subject: Re: [LSF/MM/BPF TOPIC] Large folio support: iomap framework changes
 versus filesystem-specific implementations
Message-ID: <aZiqsQsWFSCjcfE_@casper.infradead.org>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
 <aZiCV2lPYhiQzYUJ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZiCV2lPYhiQzYUJ@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[126.com,lists.linux-foundation.org,vger.kernel.org,huaweicloud.com,kernel.org,gmail.com,suse.com];
	TAGGED_FROM(0.00)[bounces-77814-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 26CE516A248
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:48:39AM -0800, Christoph Hellwig wrote:
> Maybe you catch on the wrong foot, but this pisses me off.  I've been
> telling you guys to please actually fricking try converting f2fs to
> iomap, and it's been constantly ignored.

Christoph isn't alone here.  There's a consistent pattern of f2fs going
off and doing weird shit without talking to anyone else.  A good start
would be f2fs maintainers actually coming to LSFMM, but a lot more design
decisions need to be cc'd to linux-fsdevel.

