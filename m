Return-Path: <linux-fsdevel+bounces-26877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C9C95C5D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE81B21299
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 06:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A701311AC;
	Fri, 23 Aug 2024 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L3mVF0oI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A98BEF
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395963; cv=none; b=XFIwgMfAhgIIiDKcORvpZ7QuKqBiRlgB/hQfdriQacQfCxX5UigTHL1d/41MAKmqJ+GZXFMFNPrCcaXjSZJaGZUrkL/sFLwlZlurPIW69j+k8v21rGb8uamDCtXhIUhI56BsA6v1U3lHF0qNVjiJBulNCntoQioQrQCljTXyDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395963; c=relaxed/simple;
	bh=4iTLVZUKsFMrK3dLcaZCueU43QR3UiqpHCtRqnXOt58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG4jbScBEu+E3Gwl6TrMa43f3ppABfIsE57OQ7CREFpgLJcRAQNpNw3NfrU8oAIyM5GRxiUy+n8TCWZa4jK9h1+8Z2HDXQATM3M8LXwgKM5XbPwilzGRw0ArYQKuTOECCkJGm5dYa9Bm1FEhYPx5BqIT6bazlOA6vX1KB2N5yA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L3mVF0oI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m7YzhX8TAjHnnnqKGm94Y1IWKX7tH7+O0yvnz3Wo5PY=; b=L3mVF0oICF+fBP7+PnjGPjxq82
	EyUgPSVWfNQ1CFBIvRcmxXfM3TULm0bW1aNYwPAjJwCLy0xmJ3+A1OyEavCxzLkvpNLoPZQr0s8ta
	gmDpkotd2UZpGVA7CWJqlh1YF69dIHrJe1249gzFfZjXYLjtETq/wfC58I0PwdY/0X3jOuuVoljda
	rEyCpbwjlHfO9scWb/cVru9jEDumVLBLel5aO6XPx+qbcXr9BAq3qCSkn8LTdPIOlQZGURktIVsBX
	1BLkffes9vCjIpbXUs/dA896domKlxKNH9hRjlhqrC6as6poeZQtgdGRqra/YXE+ARqaoApgO70U7
	2CpYyKKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shOA5-0000000FXDR-2qNq;
	Fri, 23 Aug 2024 06:52:41 +0000
Date: Thu, 22 Aug 2024 23:52:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: switch f_iocb_flags and f_version
Message-ID: <ZsgxucX2leSUcbUT@infradead.org>
References: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
 <ZsgrKxvTko9sLCXD@infradead.org>
 <20240823063411.GB1049718@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823063411.GB1049718@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 23, 2024 at 07:34:11AM +0100, Al Viro wrote:
> On Thu, Aug 22, 2024 at 11:24:43PM -0700, Christoph Hellwig wrote:
> > Given that f_version only has about a dozen users maybe just kill
> > it and make them use the private data instead?  Many of the users
> > looks pretty bogus to start with as they either only set or only
> > compare the value as well.
> 
> Take a look at the uses in fs/pipe.c

I did not say "all", but "many" (and maybe should have said "a few").

