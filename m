Return-Path: <linux-fsdevel+bounces-38273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084FB9FE969
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 18:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB631882EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DE1B040A;
	Mon, 30 Dec 2024 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4ORg4K1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA47BAEC;
	Mon, 30 Dec 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735579856; cv=none; b=GkkU/qKBuU84yzvc6OnCQ31kkBE++BjZNKYJGbKGVZgmHz27kBEv7bEfzAKrcRhqJY5mnByEv+auHJe/y79i/WFErj95Mr3CxGt740o8SB52QgW84kOyJaVem1JdgGPnAAaMd+rfA92AX0uW4D+yY+jk4IDEfTF+qe5FNjEWtGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735579856; c=relaxed/simple;
	bh=VhQbO01j9UWomptl+H9hBM8wYgb2QsoNj3GCT9fVe84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZZQ5r+jaFbAd+zOc6AQm2Mf+PGsikvU2QJwtXDAGLUzbDXy+9vl007Zpc1LFga93dH1yfFbAl1oN6zUdnEiysBjLxwB5REBD3qKkUsvFORYct4eomX7rHLxMx1+vQosMrdx7UCMnyscmkreJTIGABFgFV0NhLcIeQwY2Yn2H1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4ORg4K1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3E6C4CED0;
	Mon, 30 Dec 2024 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735579855;
	bh=VhQbO01j9UWomptl+H9hBM8wYgb2QsoNj3GCT9fVe84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4ORg4K1o/s1bMTAWZD9fG2h5gt1fBDLQngLj0LpY0b3NXOo+PVQZ9NI0SOpBU/3+
	 EWOamxppI80anrRz1cb3rQHox5+Vx1pUk4nDze4q4ZSXgDXRYVNjJWU5pElh3jomU4
	 mdSmQ/GuIXyMSL/obAjt8sUBPmb1T/lemiIpnbWBajsnkJzp59DlMeekkUYuxbUDyY
	 ASGj4l+P7ZK3bE55IRiUL3oemNUWEo6GR24xwA1VUvJTw700WiGODLYq7JoJFehmWa
	 xmAFvC0nTkkbv0XiqSACw/V13p7imRewvd1WTPgLxCtv/+obfBVf4EFB8YZgKdNhTI
	 liNXuDw6N5fbA==
Date: Mon, 30 Dec 2024 09:30:53 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH 0/5] fs/buffer: strack reduction on async read
Message-ID: <Z3LYzWza0y5cHTlT@bombadil.infradead.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
 <Z2MrCey3RIBJz9_E@casper.infradead.org>
 <Z2OEmALBGB8ARLlc@bombadil.infradead.org>
 <Z2OYRkpRcUFIOFog@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2OYRkpRcUFIOFog@casper.infradead.org>

On Thu, Dec 19, 2024 at 03:51:34AM +0000, Matthew Wilcox wrote:
> So folio->mapping is NULL.
> 
> Ah, I see the problem.  end_buffer_async_read() uses the buffer_async_read
> test to decide if all buffers on the page are uptodate or not.  So both
> having no batch (ie this patch) and having a batch which is smaller than
> the number of buffers in the folio can lead to folio_end_read() being
> called prematurely (ie we'll unlock the folio before finishing reading
> every buffer in the folio).
> 
> Once the folio is unlocked, it can be truncated.  That's a second-order
> problem, but it's the one your test happened to hit.
> 
> This should fix the problem; we always have at least one BH held in
> the submission path with the async_read flag set, so
> end_buffer_async_read() will not end it prematurely.

Oh neat, yes.

> By the way, do you have CONFIG_VM_DEBUG enabled in your testing?

You mean DEBUG_VM ? Yes:

grep DEBUG_VM .config
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VM_PGTABLE is not set

>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> in folio_end_read() should have tripped before hitting the race with
> truncate.

Odd that it did not, I had run into that folio_test_locked() splat but in my
attempts to simplify this without your trick to only run into the similar
truncate race, your resolution to this is nice.

> diff --git a/fs/buffer.c b/fs/buffer.c

This is a nice resolution and simplification, thanks, I've tested it and
passes without regressions on ext4. I'll take this into this series as
an alternative.

  Luis

