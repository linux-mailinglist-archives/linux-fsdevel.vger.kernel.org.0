Return-Path: <linux-fsdevel+bounces-7748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E1B82A1B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 21:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB5F1F23988
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440384EB2B;
	Wed, 10 Jan 2024 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ignPQt+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF14E1CA;
	Wed, 10 Jan 2024 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T9JnV3Cmtz9srQ;
	Wed, 10 Jan 2024 21:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1704917422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJ2kCA8YCwYpXpZJNP0ssP+4NJQXe95ZM95bicTX6po=;
	b=ignPQt+v9oJPex7kdcjnzAMGI+5KEmpVf4PYzJwEgoelMJNzpBYxvHPT3EPUuUFnTLI4dN
	JM86hWbKTAW5un+Q5IC2xNoy/Ag9i6YmBHL/DgpJBCrnNoZkJqRw8FwA1qkhiEh9ItWQWz
	DEEXCTnz8sroyiher4k/qCHanWMO//bD/uiTlJsRuNf4kxLEpApWcVoyoIMRLMLSB095KA
	TdpZ7jQ5OTPSkRn77xMyLmL5NArdxZH9S9UPcTuviX9Ipl6MTqqMg60NsMjD/OLkX+T8DE
	i0uHcn0qcCehDnQxBHTWYSfvcQnPvJSErILaWfrQlZGXjUIs38rmNrK5hR4XuQ==
Date: Wed, 10 Jan 2024 21:10:19 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.raghav@samsung.com
Subject: Re: [PATCH v2 5/8] buffer: Add kernel-doc for brelse() and __brelse()
Message-ID: <20240110201019.mrmrdelyndweempw@localhost>
References: <20240109143357.2375046-1-willy@infradead.org>
 <20240109143357.2375046-6-willy@infradead.org>
 <20240110143054.lc5t6vewsezwbcyv@localhost>
 <ZZ7TX/f5/+svtB6i@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ7TX/f5/+svtB6i@casper.infradead.org>
X-Rspamd-Queue-Id: 4T9JnV3Cmtz9srQ

On Wed, Jan 10, 2024 at 05:26:55PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 10, 2024 at 03:30:54PM +0100, Pankaj Raghav (Samsung) wrote:
> > > + * If all buffers on a folio have zero reference count, are clean
> > > + * and unlocked, and if the folio is clean and unlocked then
> > 
> > IIUC from your [PATCH 3/8], folio only needs to be unlocked to free the
> > buffers as try_to_free_buffers() will remove the dirty flag and "clean"
> > the folio?
> > So:
> > s/if folio is clean and unlocked/if folio is unlocked
> 
> That's a good point.  Perhaps "unlocked and not under writeback"
> would be better wording, since that would be true.

Yeah. That sounds good to me!

