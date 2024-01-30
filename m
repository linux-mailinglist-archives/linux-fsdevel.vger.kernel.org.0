Return-Path: <linux-fsdevel+bounces-9543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA4842882
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E891C25E1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5558612E;
	Tue, 30 Jan 2024 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rhtipgg+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998260B9C;
	Tue, 30 Jan 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630255; cv=none; b=It5iUT/z9RPxec3L47nbxsAEYMyYEaEmUnob3kfKOisUQaAF8BSfwTQNDYU1QNIQb8gNjLemd7iO4kEX98O7IzRO8y5+5CiluXx64iorqnvd6CpMdgCqdJbYNA0+hq9K9h54actHlCBi/z22RN+jvlC9mOTW9iOC0MjpdtNEjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630255; c=relaxed/simple;
	bh=jAoBcGW3ZHozXc2DsAC7JkkvJtdAbp7g4SQEqnThwIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awwijhRC5YEW/IpVWzhs6BCENVxpdVCEI2yRH4+HeH4XOfqXIyrvCujeO+yCZ9DC+FNDBRQWAwouCo+1q4SRbqL1mp4ux4t9i59y2PrUjMXXU853gLHRIa7PYyWTKNlTE2/3GW3BZf6iZaX0LcqqCtEc0YPykgY3kYgMPDWgMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rhtipgg+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jAoBcGW3ZHozXc2DsAC7JkkvJtdAbp7g4SQEqnThwIU=; b=rhtipgg+iPpTqSsPN0YjIcsv1q
	sSvuXVNm63fYRxI8XchuOHJ6Z9Xc/vE724WIvsH3bsSXdV/YyZAtl0ebzq8wAwADfZRuIYDdcznUK
	Vw5Lr+maiTNV1Z1Cnf3++xTfhNv1lo3l3T7ZRUlb7ukfkKy7oW9rfog5/EGNEeHUZo1bwmqwaTF5b
	QPtyHBtmInepMVwLjKa49zY+RW+Ih92Q7OwpRyIqJOAIuR68a6irh/zebn6OOCwaMn4gKgP5DSfvx
	SaQ8hPD06MPlgeujVV/L/cbIxrDnsMi50sIbTYBg38AUoYQOFSLdOqOfW2NH2MGA9nBSB/1C3+/WM
	/yeCzDyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUqUK-0000000HGGz-3F8c;
	Tue, 30 Jan 2024 15:57:28 +0000
Date: Tue, 30 Jan 2024 07:57:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
	chenzhongjin@huawei.com, dchinner@redhat.com, hch@infradead.org,
	hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid
 context in __getblk_gfp
Message-ID: <ZbkcaFYIv-FPj2Xj@infradead.org>
References: <0000000000000ccf9a05ee84f5b0@google.com>
 <0000000000000d130006101f7e0e@google.com>
 <20240130115430.rljjwjcji3vlrgyz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130115430.rljjwjcji3vlrgyz@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 30, 2024 at 12:54:30PM +0100, Jan Kara wrote:
> sb_bread() under a RWLOCK - pointers_lock - in get_block(). Which more or
> less shows nobody has run sysv in ages because otherwise the chances of
> sleeping in atomic context are really high? Perhaps another candidate for
> removal?

I'd be fine with it, but I think Al has an attachment to it :)


