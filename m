Return-Path: <linux-fsdevel+bounces-53074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9725AE9B21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D9D1C40E7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB22248BE;
	Thu, 26 Jun 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDhD5ZWC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616922331C;
	Thu, 26 Jun 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933390; cv=none; b=HnkXIubxm7hgiDF/MsCiLpQbJVm5pp+vBojrclfzI4BgyDzfqdZooXV5xL1roIlvgGdn4cdfM0Og4qZ+dIKaUsEU2MG7A9ZvS1KxHWuev6p+HCmfoPAqFpEhNeFQhiWLCIs654hYvxtmqEtfzTNN9TQUXi6LMN1BANXNxqUaWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933390; c=relaxed/simple;
	bh=+Y7cfV8ukQFEM8ggZpwCVTtwQ7HAl+vGElHMn/TXX3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urESUM6MXa5VufqmfZwIep7qwc+5x2y2xwdtQGCmjKVsyCwS/K7ywYD/4U465B7L9L5FkklPCu9KWLVGbI8qY6xGxKiX0xRGevHGdET1vC6JoZuzIH73z8/DZh3OPVLQhf8onFYtpxsiQmTe/yc3mxRarJ4xgY5Uh1MRK+VxMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XDhD5ZWC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2llYS3l8vxoUqVS+YVvm8OK4VC+gfuuXrhJeOKG14Fg=; b=XDhD5ZWCYvZE4lP546HmojsH0V
	YHk60Nnv4IqioBKNMPi1XQuySU6FDarngmumFIfhdMMXWeoQfVWwQ0F0TOu4bFc6y09V7g0ZBTB6+
	fDPox0DTZzyNsqd4yQYOl6nqzeoAfKj8JqfvDUlDfMJlpgDlZdAwdExh8yCBvzjB61f0BPGJ2/W5C
	pB3SdIq83jThQwH//fHlI0g4aRqswO3OKy6P5o+HAPtG9JsXMAqhs8pZb24SxzMkm4X/K4XKfIiTs
	LSZ8Ptnnr1B9j6KcETUCXDEryDEKFmmo5ZaumicCvivfRjClnd5KeQPVteL1FnrkwUNDA8sxzJ32W
	RMyvr7IQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUjl6-0000000BGi8-0f7S;
	Thu, 26 Jun 2025 10:23:08 +0000
Date: Thu, 26 Jun 2025 03:23:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	david@fromorbit.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, yc1082463@gmail.com
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
Message-ID: <aF0fjKq2zVKnkCsS@infradead.org>
References: <aFqyyUk9lO5mSguL@infradead.org>
 <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
 <aFuezjrRG4L5dumV@infradead.org>
 <88e4b40b61f0860c28409bd50e3ae5f1d9c0410b.camel@kernel.org>
 <aFvbr6H3WUyix2fR@infradead.org>
 <6ac46aa32eee969d9d8bc55be035247e3fdc0ac8.camel@kernel.org>
 <aFvkAIg4pAeCO3PN@infradead.org>
 <11735cf2e1893c14435c91264d58fae48be2973d.camel@kernel.org>
 <CALOAHbDtFh5P_P0aTzaKRcwGfQmkrhgmk09BQ1tu9ZdXvKi8vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDtFh5P_P0aTzaKRcwGfQmkrhgmk09BQ1tu9ZdXvKi8vQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 26, 2025 at 10:41:47AM +0800, Yafang Shao wrote:
> As you mentioned earlier, calling fsync()/fdatasync() after every
> write() blocks the thread, degrading performance—especially on HDDs.
> However, this isn’t the main issue in practice.
> The real problem is that users typically don’t understand "writeback
> errors". If you warn them, "You should call fsync() because writeback
> errors might occur," their response will likely be: "What the hell is
> a writeback error?"
> 
> For example, our users (a big data platform) demanded that we
> immediately shut down the filesystem upon writeback errors. These
> users are algorithm analysts who write Python/Java UDFs for custom
> logic—often involving temporary disk writes followed by reads to pass
> data downstream. Yet, most have no idea how these underlying processes
> work.

Well, if you want to immediately shutdown we should not report writeback
errors but do a file system shutdown.  Which given how we can't recover
from them in general is the right default.

> > Personally, I like the fcntl() idea better for this, but maybe we have
> > other uses for a fsync2().
> 
> What do you expect users to do with this new fcntl() or fsync2()? Call
> fsync2() after every write()? That would still require massive
> application refactoring.

That's why I'm asking what your intended use case for the writeback
reporting is.


