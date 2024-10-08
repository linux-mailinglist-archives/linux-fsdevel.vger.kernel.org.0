Return-Path: <linux-fsdevel+bounces-31336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7516994D01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC088B249A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA9B1DF740;
	Tue,  8 Oct 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mw0dG3RS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678F1DF73A;
	Tue,  8 Oct 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392158; cv=none; b=TYCGL8ux0hBp8swrlvGFOtc84rdscxUq6KEi5fSjUHOw+Q3m4CzMo6/n8P/IZSsMPWdRUWTsS+LuD6b0+wVHvG9S6XSV1faaz2dxpg/+AJQBL7XnNjjuF8E+OsXX6evC2ynhxVHOx+a7sJuu5vzgiDq9xXjU81xEfxh+w7ww7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392158; c=relaxed/simple;
	bh=Vgp/xKtJboxc+kG3KTH2G2MM1dwKAkSs1/b5QSn/HzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLabTJlCEHnL1QI5bTzQQz1NtSlgEVWnKAzARgU0bMmqVWyvVd7M8sUfpux8q9EIIVGubvOVvCHLzM9s9CvPjnf+chqh2zZgOEotkOOLamatlnRllSsAmSR+z6UBzcuIoUriUAjjEEI0KLy+Xmgl9wDvZgQIIxVYFs2ugZLGP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mw0dG3RS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d4cHsnC3TBo8c4sySnC2hojW9m7YjVLgXXnPhZPoswQ=; b=Mw0dG3RSJahn+N5QDQW5LVfqJu
	WaObqx4JIfFPnfJg3XWZOaL8FE6Mz9lrmlP7hecQiJEui0m3cb1ZqxI+8+6TSidsVrdDswYz2qXNG
	wJPeG/0iIqW8f5DbVN78SLJJtbdEdb7GHhRfthw0pVgCWtWp94y9r0sH66Kg0FZebtEezUJQZACtv
	FNLrDVIRpYt2gTnY/IKl7m0E8tDD3hE51fkG15LvgVyxFZErww5Nqqv6NVHDvElSsAC3f8hESZSrE
	1MlLwn90OR0cgnOKOyzKDuwhq4DPAlXT5I9MSdlb/2D6Mu0SXDM0L8yDb2lzK/F/jshEnbgzgyiYd
	ikf2DR0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy9km-00000005srg-19Pg;
	Tue, 08 Oct 2024 12:55:52 +0000
Date: Tue, 8 Oct 2024 05:55:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
Message-ID: <ZwUr2HthVw9Hc1ke@infradead.org>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
 <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
 <ZwUkJEtwIpUA4qMz@infradead.org>
 <ca887ba4-baa6-4d7d-8433-1467f449e1e1@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca887ba4-baa6-4d7d-8433-1467f449e1e1@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 08:33:27PM +0800, Gao Xiang wrote:
> how about
> int get_tree_bdev_flags(struct fs_context *fc,
> 		int (*fill_super)(struct super_block *,
> 				  struct fs_context *), bool quiet)
> 
> for now? it can be turned into `int flags` if other needs
> are shown later (and I don't need to define an enum.)

I'd pass an unsigned int flags with a clearly spellt out (and
extensible) flags namespae.


