Return-Path: <linux-fsdevel+bounces-63346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8EBB6223
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 09:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C07CF4E9126
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9C22A7E5;
	Fri,  3 Oct 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gBdh5iDH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0513212572;
	Fri,  3 Oct 2025 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475207; cv=none; b=S3X8UY0X76ooLLmz1lq46oDcP/HVLo1265P3xgDX5cQfA4Q4xhiE7mPcT4R+MxiVlRvWx3ug7CAAEw56rgDjsz3+MNKf58PM4PlGJxy4iSmdfulUGwoZL3tNjeTm6ldgxRZ1RSMSPjInUxlqVHxQKpL6hNOGrQ/5JHL384vukX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475207; c=relaxed/simple;
	bh=os3rKQ2WuQcD1FARsrp7dqkTOHG0az9xBxuDqD0SXH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS+m15RpPzgjiHZBeRCMLOKekeLWnyPjli85a1ReCn85Kp3FOYhrSryiSvpRl23WUvA67dj3uRVgjgd0socXoYIt0hRvEBDyxHKCLqHWiGm7B6MjfNG1bWp8q2b3XPCJAKqk8AZ0/jvJ0B3vzvK1ljdCgpsftVZZuk1610bxBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gBdh5iDH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=os3rKQ2WuQcD1FARsrp7dqkTOHG0az9xBxuDqD0SXH4=; b=gBdh5iDHd8gW9zlFw9o0EcNzjo
	X7i0PGAoW/Psmt0nxLoKgFCj3GEvGO3uKicUfiTbSeKyBCc8ooP4HaQZJL3PzGyxpVjvQBHAikynR
	5VcOteHyLMqvqgoGb5E2SG7ToU3sGq0O78KxbvFZYhsEsn8ANMLD8Jc9xZjUy+QfxIoNTrqzND21d
	dmtzKegq77CP+RTXjh3jtqOpQ/w9bWlbJxRCi+Ouoh6Fv+RDfxV2UjIGcQwgkHzfIo/40My0mws0C
	SM7jGQdzuSDbcuyY+eq9ctBKUbzUvKcHFSscjLjzFfmU/fLbP3BrIsLJLQlT3Dso+JpFkCeJdiZPE
	/8g1cRaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4ZsK-0000000Bn3W-2x6P;
	Fri, 03 Oct 2025 07:06:44 +0000
Date: Fri, 3 Oct 2025 00:06:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 6/6] loop: add hint for handling aio via IOCB_NOWAIT
Message-ID: <aN92BCY1GQZr9YB-@infradead.org>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
 <20250928132927.3672537-7-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928132927.3672537-7-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 28, 2025 at 09:29:25PM +0800, Ming Lei wrote:
> - there isn't any queued blocking async WRITEs, because NOWAIT won't cause
> contention with blocking WRITE, which often implies exclusive lock

Isn't this a generic thing we should be doing in core code so that
it applies to io_uring I/O as well?


