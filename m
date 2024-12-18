Return-Path: <linux-fsdevel+bounces-37753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3DC9F6E1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 20:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EA31885D20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 19:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475371FA8CE;
	Wed, 18 Dec 2024 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dVcjyo9T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C413597C;
	Wed, 18 Dec 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549632; cv=none; b=CnNQcZ2g8xt2n1oCgOM3ZP7ClqNw1wywoCbXwhne6KxGH1vfDOEn4c7FKUaRLvoCagim73Dwp5Zia43GLCjru+/rN6eO5HQZRWzcWFjjcTBq5tgLBG+9YbBUc05/4Y2/oJTyf94PXMbW2uHUH6X4nkWJWUv7W/g2g3M+AYufHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549632; c=relaxed/simple;
	bh=mf18uw6yGLXbRpE4iWTCOFO0L5oozHSQS4s/+arltbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH7p0rWIMw/LtFljZqPyWFcTa2R4Lb7dXS2E+50vrJEWd0BhWmffO0T3ouY/kretCBvJYDh+CB7iskgbOMTICnuC2tmujmJzE86WFD72hKAmK8Nd8SavxaSBsdlKXFWPSRMlXLJqUmVo9p3b/0aqdD0agkBZTwfFkm7DxtIQlqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dVcjyo9T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y+H9mbq07YmrLuzXQ/5j05Zjf+pa75UyPx0ekdw5M40=; b=dVcjyo9TeM8t8yyHKAvE06yW1b
	6dvo+oWvfE1e1HDS0w8nFVagY6dfnoqUOEDoETffTcThfsnzrFZoVv3lDpg0Qyg8V9wSOqEKoPNKO
	1+wiUEfJYuU26EkFXBi53t4kD5Z5LJW4Iyp93IM6rpY35y6DEu3L9uS9OFSIrfEHcmsFpErIb5Rnq
	/ZnItbzfHWRcVeFR10JMZhm7lpOgZdDZku3aDFMnBAX7iz0k1ReWpk6l72JexGCbzzGPjWRtrPdXo
	Zy8bbp0CwoFbhLT6C8hkGxxC4ZfF5d/Uf6tvqYSpaxTm60Bw3HT+VtHMsqL7sPU0WDu8sxMuP2Arn
	wTsuGQog==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNzaq-00000000VuC-0B2T;
	Wed, 18 Dec 2024 19:20:24 +0000
Date: Wed, 18 Dec 2024 19:20:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH 3/5] fs/buffer: add a for_each_bh() for
 block_read_full_folio()
Message-ID: <Z2Mgd4kYqPeDC4mP@casper.infradead.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
 <20241218022626.3668119-4-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218022626.3668119-4-mcgrof@kernel.org>

On Tue, Dec 17, 2024 at 06:26:24PM -0800, Luis Chamberlain wrote:
>  	/* Stage one - collect buffer heads we need issue a read for */
> -	do {
> -		if (buffer_uptodate(bh))
> +	for_each_bh(bh, head) {
> +		if (buffer_uptodate(bh)) {
> +			iblock++;
>  			continue;
> +		}

I'm not loving this.  It's fragile to have to put 'iblock++' before each
continue.


