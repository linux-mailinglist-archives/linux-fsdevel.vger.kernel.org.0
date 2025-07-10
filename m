Return-Path: <linux-fsdevel+bounces-54468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B40AFFFCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22233587CDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328642E2EE7;
	Thu, 10 Jul 2025 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QQf1nX+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D11A841A;
	Thu, 10 Jul 2025 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144851; cv=none; b=scUfbvV8pWGgZyGC/9SkcoyQBSwCWMj8od6FEJS7ra1Pr5BHFQfsG2Fju/Zzo7Cc7Mzp8zX9RnBlzfje+E+z/xGAwHk4DB0A0TG0T+oWsak945gG+ZgHa5fo0zlj661Vg4iMIAeZlMjxmhMU2fNq31aQ6neMDNXrc12CWz94sUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144851; c=relaxed/simple;
	bh=uFv47dHfdNnzeZzIZS0n/RnhJQWe/OVZIM3dcQlOs2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4jy3CZfSxp9HTFDDwT3rBpLm021MLanFi/0QO6CaR1a+N2j8lXIUJ7A1PpVv1gkxJIMpK/c5N5LKWHYRKCC02zqGh6vF0snQq2nQH1a0yA9lGeC23kp9e7ErDXanBJtY6ddWDzXMVFXRlDiMvCsePfFYKuNQLq+qSpRQUItbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QQf1nX+r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0yeu9AVJZq7XsJ/NofubcOe4TkI8w75i5jtGUPaKRhY=; b=QQf1nX+rxWvBDzBjXAkHamOoe8
	T+DYoYnfuomu+IQtuhFaCjlX4pzRCDJMStjBg+QmdisOEVnjMRydP+1AeNWKALESnz3YiaQ3iaqbj
	GkxBLV+twxmqgmLbwahiwKvasuKNY5fnFaCMlAm5HQXlcqmw5koSOQKjx7r9ozIcUiFiylgl8MtsI
	KLJI1hf7DF9CJXj2oBE7XjIcuYj6lg2m4IFy/2UQQG1D0YC5inAXVALU1VXLTSfR22PFfSmElixw+
	1F79n2ltfN2qFTs1stsD4WUD/o5DBl9ZIYv7fzMwcP7R44oj30/DfufQ2V9jwNoGLhx085Uiad+Se
	Ni53zqPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZoun-0000000BXn2-2LbQ;
	Thu, 10 Jul 2025 10:54:09 +0000
Date: Thu, 10 Jul 2025 03:54:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <aG-b0UiIEX4G2-UC@infradead.org>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <20250708-geahndet-rohmaterial-0419fd6a76b3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-geahndet-rohmaterial-0419fd6a76b3@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 08, 2025 at 09:55:14AM +0200, Christian Brauner wrote:
> I think letting filesystems implement their own holder ops should be
> avoided if we can. Christoph may chime in here.

Ccing helps for that..

>
> I have no appettite for
> exporting stuff like get_bdev_super() unless absolutely necessary. We
> tried to move all that handling into the VFS to eliminate a slew of
> deadlocks we detected and fixed. I have no appetite to repeat that
> cycle.

Exactly.

> The shutdown method is implemented only by block-based filesystems and
> arguably shutdown was always a misnomer because it assumed that the
> filesystem needs to actually shut down when it is called. IOW, we made
> it so that it is a call to action but that doesn't have to be the case.
> Calling it ->remove_bdev() is imo the correct thing because it gives
> block based filesystem the ability to handle device events how they see
> fit.
> 
> Once we will have non-block based filesystems that need a method to
> always shut down the filesystem itself we might have to revisit this
> design anyway but no one had that use-case yet.

I'm not sure what non-block file systems would need it for except
maybe for a generic IOC_SHUTDOWN implementation, but that would have
a different signature anyway as it needs to pass flags that don't
fit here.  So that would be a separate method.

