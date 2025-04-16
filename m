Return-Path: <linux-fsdevel+bounces-46538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF6A8AFCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 07:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824A4189C44F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 05:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F98822A7E3;
	Wed, 16 Apr 2025 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PhqnqDO5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33221CA0C;
	Wed, 16 Apr 2025 05:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781733; cv=none; b=dgHtouAk3AIO7Y3CZ9bxdzVBm/2zsMQh7jBp111gn8DlT3dhShJpHQC93Ttf+LZQnmIo+cSIb+YbKvIbhMuFnDB4Wxq922h09pIvvTo1eBwtcO5IrUuGjdIxkPGfTtuPzCB93sCvVccCcTnrytX4xlN4T5ByclaQoAzQ+pD1Zd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781733; c=relaxed/simple;
	bh=iXYAPNbKfKaVDtKw/C18G6/BfkjwbEFYn6q36OxB7LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC1vrJl8m0y64xaLlf4RAhM6YGkN0kiyWWn43rHd5vSxEMfKAUAvDqaQgG8aOi37o10DTTbWue27LEuPMhUHBjS9f44cexNgERBhWXxxQ9TpbFc5waAQYMHY8JsOVgjq4yQxpQxE+HrtO5ri2NTKaL1gY9DsKB5LcPcFY3dKuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PhqnqDO5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WI5r+l1/k0KdndY+13+XDhXR0dP72zFdupm/5x+wSG4=; b=PhqnqDO5qrsVbMGFrJ5S4uwc1k
	jQiIs9avTslJ8f0phKUfFbgxMflXAEyK5tFrF/zx9LbrShyYz1tXAamEvRkwvPR2hTdNVcEQEpJbL
	ITA6jMiN0Cs2JKMBX9oftbIGXVkl5bp3+ukiW77rpNQJ4UQ2YA3GnBB0d8CeIWkQKcMdbesghfLYA
	BKkUF+GQZi43AdRm/dvGnapiaPQEf1yEp8jpd3ZEp2w0FtZXT351QNXpWKgMilsi/SWsZfKLLKAgl
	oT+l9DVvGHyRyb2YDavcEie4PWUHJm5Z92/NYQTyFpMv3MpXQfJ56YRisUvrX9DW8aDEoZybq7cu/
	FfAwfuDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vQo-00000008IHL-09jG;
	Wed, 16 Apr 2025 05:35:30 +0000
Date: Tue, 15 Apr 2025 22:35:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: hch@infradead.org, almaz.alexandrovich@paragon-software.com,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH V2] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Message-ID: <Z_9Bou858C-pJnmd@infradead.org>
References: <Z_8z8CD4FKlxw5Vm@infradead.org>
 <20250416053426.2931176-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416053426.2931176-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 16, 2025 at 01:34:26PM +0800, Lizhi Xu wrote:
> On Tue, 15 Apr 2025 21:37:04 -0700, Christoph Hellwig wrote:
> > > The ntfs3 can use the page cache directly, so its address_space_operations
> > > need direct_IO.
> > 
> > This sentence still does not make any sense.
> Did you see the following comments?
> https://lore.kernel.org/all/20250415010518.2008216-1-lizhi.xu@windriver.com/

I did, but that changes nothing about the fact that the above sentence
doesn't make sense.

