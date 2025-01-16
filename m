Return-Path: <linux-fsdevel+bounces-39382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314BA1330D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 07:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C19B188AB1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4CB190052;
	Thu, 16 Jan 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ymjb+7BY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F0149C7B;
	Thu, 16 Jan 2025 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737008660; cv=none; b=FgtqQs4vUVVvhYebPB0kQuaQcsR1D4j5PiJ+n58fvXkTcRpDUKiF2ik3JgzwmZJesA36hypC1O1W6aoo1nVrEosZYpYhIPb0dXGMGcrtBincnbqdjJnt+sjyCoq2yheo2qHpgOQ0IRAxd6WUmQBEx8+ArvyqMNfmSU3OkosuX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737008660; c=relaxed/simple;
	bh=D9uiLlV0hub95fMCeVXZEA5JbCeciyzfJZgkkf6FJCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFMGrZmIsDaqU150VTu29/DykTlVinaM+5dcZfAgOtlKkskQrI7lAUrzmwxJq/DfsI5XxPxAkghka0w/8SCbxEraHZzHQWRhDnanAHXG2NyWGUyZdjvo0t1eBoRgUslIm2XPR+aORO/deGHpwvlm7uN1AyVVUR5dmbLL04b0d28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ymjb+7BY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/iG6R5K0Z2xKca55Hx2rIbmMDwC2MV6uVlIzu7zRCWI=; b=Ymjb+7BYVxoCw+M/sNN4wdisbP
	ayhJHEGpjmyd6H684XMLOR9R9shcxsCHehwmag5PviSwAT2uew33gQ9miFcb5KJr/hjixumDomthP
	zFvVxJSu1+p4TXuB1ohV9dKknfbxghWuyTtCphYjOR8q3INr6I2PLNXVWlC1j1FaXOhVYdK9FzrRg
	AGIjb3F8Fs7e7YX85URRNHWT5R2u8uLbBCDggD4wloFQeEQ6mvJ5d2XMRiN1CSUMITiyLmuKFUkdJ
	2JSIQl31pVG/MwneEGGO6/jMpz1ry7EjUKymoiIHKUu3iVgLItPGQoPZRGS+/dsY+vtAvlxwlJ7/U
	lUO5COIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJIg-0000000Dwbn-3UBD;
	Thu, 16 Jan 2025 06:24:18 +0000
Date: Wed, 15 Jan 2025 22:24:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org
Subject: Re: [PATCH 1/2] f2fs: register inodes which is able to donate pages
Message-ID: <Z4imEs-Se-VWcpBG@infradead.org>
References: <20250115221814.1920703-1-jaegeuk@kernel.org>
 <20250115221814.1920703-2-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115221814.1920703-2-jaegeuk@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 15, 2025 at 10:16:51PM +0000, Jaegeuk Kim wrote:
> This patch introduces an inode list to keep the page cache ranges that users
> can donate pages together.
> 
>  #define F2FS_IOC_DONATE_RANGE		_IOW(F2FS_IOCTL_MAGIC, 27,	\
> 						struct f2fs_donate_range)
>  struct f2fs_donate_range {
> 	__u64 start;
> 	__u64 len;
>  };

> e.g., ioctl(F2FS_IOC_DONATE_RANGE, &range);

This is not a very good description.  "donate" here seems to basically
mean a invalidate_inode_pages2_range.  Which is a strange use of the
word.  what are the use cases?  Why is this queued up to a thread and
not done inline?  Why is this in f2fs and not in common code.

I also which file systems wouldn't just add random fs specific ioctls
all the time without any kinds of discussion of the API.  f2fs is by
far the worst offender there, but not the only one.

