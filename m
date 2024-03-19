Return-Path: <linux-fsdevel+bounces-14845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7180880796
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 23:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6281F237DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC160263;
	Tue, 19 Mar 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1d9EvFPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E845FEF5;
	Tue, 19 Mar 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888901; cv=none; b=VOPl4WzPy9uSnea/PgCsh20es8OuPF3i/hjplusLTg36aMX+JFV0uE2762I68noHhLePLAbq0zrl9IGs3NUqn7cXyWsL4nkmDaZBX97zXrYkVIdwEnxo+dcC0m4p2smVv4w6K+cW9Du3vZXHDPKVJ3CycLxzOGvPEvdRTXXzLLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888901; c=relaxed/simple;
	bh=r5Tu6X6VL9KipsoIQiuF55AUNOvOjQfhfCgiDN+WS38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwPpucCLIeFiiug4bIoXoh1Y0w+2NEQe3u8gVKUOiQgHMmBMHqqXQfQpVoJaiWnnQoCyxk0FOXOCzn6Iwnnt/MTkoRL72h98xX5WCieYLaY2AuXSyIaGgeECAgo9Cf2SUExcvRaU3jdQaTP8JdtXRbHrfXfOhskXRyqUGwWH8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1d9EvFPF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eJ6eNnKP0QQ+UFFnJPSmQPHRB07lfb47KMCICxJUdHk=; b=1d9EvFPFK4lijQPAimqDHzWTaB
	ZHiaqJeAO2D+rzCqeKEDeoKLxeXrVy/fdSQHX61LeEraL4uUQJi5CTtp7Bje5XCOEb3pnNcUGTaFQ
	TWuIyad9gaOakhSPGQq6aU2gmQqnI9q1+YW6rnRCuT3jJKuwdLJIwjffxs07c9c/SELKqlpwjVhHz
	LHBRtjiDUIRunKYvfLvLqJHjgW0bc165sgCVRbMOBhxbGY+s/fmYFkWTkzR0T8YO66YS1epw4LIyE
	R6vbYSzel1OY+b+JmC0nJPzlCIxAraklCWIjbDkGXzurpGnvIPlqWFJy2/Vxvfbpavc/od+rKqhdF
	jMdT9pyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmiMD-0000000EWxf-3fIM;
	Tue, 19 Mar 2024 22:54:57 +0000
Date: Tue, 19 Mar 2024 15:54:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, brauner@kernel.org, david@fromorbit.com,
	tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/9] xfs: make xfs_bmapi_convert_delalloc() to
 allocate the target offset
Message-ID: <ZfoXwW9G6Lr8vKHZ@infradead.org>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-4-yi.zhang@huaweicloud.com>
 <20240319204552.GG1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319204552.GG1927156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> > -xfs_bmapi_convert_delalloc(
> > +static int
> 
> static inline?

I'd just leave that to the compiler, no need to second guess all the
decisions.

> Double underscore prefixes read to me like "do this without grabbing
> a lock or a resource", not just one step in a loop.
> 
> Would you mind changing it to xfs_bmapi_convert_one_delalloc() ?
> Then the callsite looks like:

Fine with me.


