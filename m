Return-Path: <linux-fsdevel+bounces-77086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gg+INvTjmlFFQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:33:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF73A13399B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A44C130692F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1210E2F39BE;
	Fri, 13 Feb 2026 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sZJ3SA0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB1286D7E;
	Fri, 13 Feb 2026 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968022; cv=none; b=c8PDERR7QGsXx+NMXtM+7S3t5ph24vK3EaK3keZ0YKp9EbBgwrVw8QCdvdhqE2lRVUubxPPNrerN9bUBL6N4s2TPRbZohibvjhddGXq7vluwoiBnrC2owcPUioKc1Yqh3CeQM8UgWGFL19nCL931DWlmwSbY6gII1oCSUZP1lD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968022; c=relaxed/simple;
	bh=2pI8ejnF/hPegomvE5m5LZPZsi9W6WotN6jVhhGMM4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xhb1nixN2/z6GAU0nfA+SpIkA+8n0eV7Pn1YhFLBvKa1MY1+twPBe/mvyN2xPTc70sdM4U7Vir9ZlGtIM2+P38VPFJKPeVyHakfNpTB9prMlNagLg55C2rpMkSR5lPXcEZW0VWJs8skVzj8oHD7XzPWp18e6Qgg/aE8covuIS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sZJ3SA0W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k+shCV56jRGCAYiUIQONlQS4eFINeE+LcPXmzs3QJFw=; b=sZJ3SA0WInt8mMNiC9cE4s1MBo
	+6jFbES3PS9YFabiiEsUsJLa/j+3AUCoq/Kgt7iLokxRA1tYyfdGbk+Yf7hFILZbCr6Qxn7Jp5ton
	YLN+DH2ykY7dDvpI3hT6GD4LqfotFEE9OJ1PXQtjrNaTWop1XZWvdkGUWJmUfv1Wh0mRPRZjgT1oR
	Y/9yx/t2bWKLNcWWrlE67Kuz6j0NkqJJHY3uIyjZoitwy9KEdyd/p4+PGqZyGyvh1FrjnO6+WdIFg
	yjIzfbcj8PGpChdb3qfEYp4WNssHsjj/xy/rZWqzp86nDKSXUJC8D5jic9RozSxOxIxssH0PhYs7P
	IsisKTMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqngK-000000036mB-2ldi;
	Fri, 13 Feb 2026 07:33:40 +0000
Date: Thu, 12 Feb 2026 23:33:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: File name is not persisted if opened with O_SYNC and O_TRUNC
 flags
Message-ID: <aY7T1LS5vnZI-ZxE@infradead.org>
References: <4b207a36-5789-41d2-ac17-df86d4cde6da@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b207a36-5789-41d2-ac17-df86d4cde6da@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77086-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: EF73A13399B
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 02:51:47PM +0300, Vyacheslav Kovalevsky wrote:
> Detailed description
> ====================
> 
> Hello, there seems to be an issue with O_SYNC flag when used together with
> O_TRUNC on various file systems.
> Opening a file with O_SYNC (or using fsync(fd)) should persist directory
> entry.

No, it should not.  I'm not sure who hallucinated, but O_SYNC has always
always applied to persistency semantics after writes and nothing else.


