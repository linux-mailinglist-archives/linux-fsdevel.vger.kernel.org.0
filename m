Return-Path: <linux-fsdevel+bounces-7711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4EB829C9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABBF1C25764
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 14:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25C4B5B4;
	Wed, 10 Jan 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="fW14vjtT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12BF17C9;
	Wed, 10 Jan 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T99Ft3qTGz9srN;
	Wed, 10 Jan 2024 15:30:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1704897058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u+is9lVWUyd2B8sJ46D7VtCubhSyJxqMiGf3TjCy1Mc=;
	b=fW14vjtTnjTSTg/rRqZ9p+pNE12JckicMl8pHUj1MOnGM614S4392nAqHapU6Hhvq5zwxk
	TUlcHdHj4kYuRaKtH3wI+wF9cT+o6s1aOhFq79Ci384/8si+dpe+hNigyP00fJYcGMl1nf
	5aBE9BDLRgyzU9VCwJL4GqtI4ZPrdjWEAFGL/obRnzjEhHJlfryOwEBUR/ZE1/uGQAWDBg
	vrlF8rDZhtuWd7MMiWZWi2y87I+DGbhbw4xCVUOrAMAQzfv6bVe+YzEp4kioV1Au90oPHm
	uYfc4nfivJQLqzBVcPIvwmGt4WiJ9ER1disqYXK84v2+PvyBTg9cxCHL8NJT6Q==
Date: Wed, 10 Jan 2024 15:30:54 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.raghav@samsung.com
Subject: Re: [PATCH v2 5/8] buffer: Add kernel-doc for brelse() and __brelse()
Message-ID: <20240110143054.lc5t6vewsezwbcyv@localhost>
References: <20240109143357.2375046-1-willy@infradead.org>
 <20240109143357.2375046-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109143357.2375046-6-willy@infradead.org>

> + * If all buffers on a folio have zero reference count, are clean
> + * and unlocked, and if the folio is clean and unlocked then

IIUC from your [PATCH 3/8], folio only needs to be unlocked to free the
buffers as try_to_free_buffers() will remove the dirty flag and "clean"
the folio?
So:
s/if folio is clean and unlocked/if folio is unlocked

> + * try_to_free_buffers() may strip the buffers from the folio in
> + * preparation for freeing it (sometimes, rarely, buffers are removed
> + * from a folio but it ends up not being freed, and buffers may later
> + * be reattached).
> + *
> + * Context: Any context.
> + */
>  static inline void brelse(struct buffer_head *bh)
>  {
>  	if (bh)
> -- 
> 2.43.0
> 

