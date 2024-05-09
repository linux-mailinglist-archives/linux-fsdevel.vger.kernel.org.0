Return-Path: <linux-fsdevel+bounces-19175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3E38C100A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC761C2082D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D614C5BE;
	Thu,  9 May 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TS/zwIpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABF13B590;
	Thu,  9 May 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259510; cv=none; b=utdBAJvSakhQvsZ9qniw3YEolmb4cKCZkUa08me0vdV0c2ynRK3XOu3RX6nKeSW8BnADXikcYqQQEPd8C571LAnTmeI+2BlnP9DlqlZHzbt8b+fzFXcFyBARALf1OXTBr+VrFUXukwT+MTq+wIng4UEdtgfwAy7870PZxya4ZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259510; c=relaxed/simple;
	bh=MKC9wCjSQVelLnxG27A3NgjqV66DuuMiZIDzudaJX34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgzUocSf3Y/GWFgBQ93Xuh2EDWf3UbIeCAzbdacwBw6PYovfAQKjtaAjnWwqWW+buEg5gPkjMXTH/Z2dOtIgQ1hFm9/FGh7i8PjaF7AfqQpbCxczZ472bKXDMD4bNWmg19ru5kv+n1+oxsNmiXWvR2ZK+0eiwHNX091kvxiWQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TS/zwIpI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P8JtwUqTZ5thY5C0o8JQ9jcIA6kib8zFsh+AmPPcQkw=; b=TS/zwIpI/RgjwOZIRNph0V1iPg
	HFcQKqlkwrUU+z/fSblzUSWWo/CcR1JozYosfXC/3cdu1Krwf7lInvpoP222XBUJKgn7j696Q9aQR
	oYbe3BcJjc1IykDXgGRB9TPZZTQis23b4wjWRNFOS+7GVflB14MGtUSobZkXZAJfT/EV3/rHtvz/E
	3DQ1XkVZK7NZoMbuowRbe/cbywe/SgPkRkpu5Jk8VXha4nEGm3JFYGO2luu2m0t5hwwRgwxFAyMLi
	ElSwArKsC7VSDkGuTwnIvysLt55peuNMyVDcWSnVM7kSpgantdDoj/5YSZIrx6ED4eSteU5z2AGhr
	aL1XHHdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s53Lr-00000001VQ2-0TaS;
	Thu, 09 May 2024 12:58:23 +0000
Date: Thu, 9 May 2024 05:58:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, willy@infradead.org,
	mcgrof@kernel.org, akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <ZjzIb-xfFgZ4yg0I@infradead.org>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZjpSx7SBvzQI4oRV@infradead.org>
 <20240508113949.pwyeavrc2rrwsxw2@quentin>
 <Zjtlep7rySFJFcik@infradead.org>
 <20240509123107.hhi3lzjcn5svejvk@quentin>
 <ZjzFv7cKJcwDRbjQ@infradead.org>
 <20240509125514.2i3a7yo657frjqwq@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509125514.2i3a7yo657frjqwq@quentin>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 12:55:14PM +0000, Pankaj Raghav (Samsung) wrote:
> We might still fail here during mount. My question is: do we also fail
> the mount if folio_alloc fails?

Yes.  Like any other allocation that fails at mount time.


