Return-Path: <linux-fsdevel+bounces-50965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B455AD1814
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691E2188B45C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 04:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD7127FB16;
	Mon,  9 Jun 2025 04:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tkneNtCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE772F2E;
	Mon,  9 Jun 2025 04:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749444278; cv=none; b=ss25oSa/dyLVX57eI+/2Y3iNCr47NkRE6DG63jkEeWbPZn4GFR9hV4H8ceKwkvaE1bpVdFintZexiqRBTgImFB/PJnj7gH7sQvwwAWi+q/paWdkImHrqK3GJlKGIxeEWFdizoWFVe+gLqZMiVr7lzGTnbBxovADes8VB0Xcn+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749444278; c=relaxed/simple;
	bh=WzkCOyQQSLfDJxoVMfs8xIXH0l2vVYR8pBpaZOvZm5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD0blKx9oBs2lDc87ic34fpT7szNWWAEavMefdb1scrrqOL87qABjXDJ0d0ZvMpc/JQyCxdKY+IakRffg/lN4FT/SwpOwqUODLR6k6ZdrI5TnQT6yzRaxYczkBB84RhfrW54NG6NPVQiCm369J3yIiYbA50BQArUakbXgCbQmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tkneNtCK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ubcvXhR1oGcimDGZQPdgCJHD2Pcy9E1iB1j0fsb5wk4=; b=tkneNtCKG5KbpmDBADkRBlrPKk
	n6X97n5hX/4HTQRxq+TJRiGfpImMY/L6rPaweva/Sz0x2ITCpn2fLUFIbmurg+m+KBA9IipHv4lnp
	dVNw4dSUooO++7abiTU8E2PQMV06zqp4/UXH/nK2fnK9qsWhgRyM6Bk7cabseRwX++qe8XB4EYqzj
	fxZP+Vk+Nvx7LzY2PYDrK6Su2A4XhC/ke5VkoUHDCmJrQ/in9rSLvsUPCS9E9p7Fz6kKTSarfZNLR
	wm05l4NuuNvnc+P/e6Sl4xbUIC+8kSnje+bTQnnNHENpG8bRh2c/N60vJtHtQ5ofddsAX2TWSwcCD
	1+OeUZnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOUNA-00000003Qoz-0jJK;
	Mon, 09 Jun 2025 04:44:36 +0000
Date: Sun, 8 Jun 2025 21:44:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 1/8] iomap: move buffered io bio logic into separate
 file
Message-ID: <aEZmtI1Hqj5I2F8d@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606233803.1421259-2-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +++ b/fs/iomap/buffered-io-bio.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bio.h>

Please keep the copyrights from the original file.

From a quick look the split looks a bit odd.  But I'll wait for
a version that I can apply and look at the result before juding
it.

> +void iomap_submit_bio(struct bio *bio)
> +{
> +	submit_bio(bio);
> +}

This is an entirely new function and not just a code movement.

Please add new abstractions independent of code movement.


