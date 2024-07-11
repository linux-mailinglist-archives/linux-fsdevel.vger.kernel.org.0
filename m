Return-Path: <linux-fsdevel+bounces-23553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E51E92E21E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 10:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2530E1F21663
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE2815217F;
	Thu, 11 Jul 2024 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PQaTuRoA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93583BE6F;
	Thu, 11 Jul 2024 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686393; cv=none; b=tdcMcWygcGkQd6MWG9fuVKZkuN+nMfrbFWVVH1xaPMab9hj+rfi4ysJ6/Upj3MB+EFbp+LTXeKCgPd0bXvMWgklrE6XNRtSx+07+mdb8Jd7hp8AbhQsZlJ2lzwyENIMmxXIFSFWusei8E8cHW6xCGs/s4xoYdtbEQa4rcvcgYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686393; c=relaxed/simple;
	bh=PXqQ+xvRcwFYqjNiQ2YRemoNo2jA6llAw+agI//5xaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlIAEkeE9CKR+kGeKFbn0rBpX/HKcovjtN5lcGjB6y8iOlkdSpCnkmEOITC7hRuRv/rGQEmHEfzezQ8FO3IfPNHAT1T1+l3zeKXZ+JFxxHGg/xL2g1qZ4qKkVv1CjBAGfycJJjjFuZ5v+eDjPBfpTBNO9GrirgpzzvMzC2HTB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PQaTuRoA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IoLwNlzL5pVMes7pL0SN66rptxB5HrdHgJG/HnPw4go=; b=PQaTuRoAFO4mYSXAy4lP5USzkH
	J4gUlSWhlzUH/NiDp2KgLiNQyEPTdMu168GNAB9Xrv/R/ZrGvfNdcgkIvvJIWj09Vgk9a8ggoHSFy
	2KdfrQSuu3vW2ButEYbttpqj5waDZW3iB310fOAvvWUrQ0P6VtNMOZZhB4EdwxlfRxhXlznlQ+YqR
	F/JweXuda1clgoNwnhjEhvu83qwhnqHcOpvSIE+DVIhIpDdijDtzz2i/7LW7MTKT26TVRbl8P1zD3
	0Ng39ttpebR98ql+1a2w6xoV1vfdIooxibBfDUpFPdCoZXuIPevrR572JixXR9My07LBNLwmXvfyR
	XMs3+RKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRp8E-0000000DAT4-2xks;
	Thu, 11 Jul 2024 08:26:26 +0000
Date: Thu, 11 Jul 2024 01:26:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 0/3] Add {init, exit}_sequence_fs() helper function
Message-ID: <Zo-XMrK6luarjfqZ@infradead.org>
References: <20240711074859.366088-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711074859.366088-1-youling.tang@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Can we please stop this boilerplate code an instead our __init/__exit
sections to supper multiple entires per module.  This should be mostly
trivial, except that we'd probably want a single macro that has the
init and exit calls so that the order in the section is the same and
the unroll on failure can walk back form the given offset. e.g.
something like:

module_subinit(foo_bar_init, foo_bar_exit);
module_subinit(foo_bar2_init, foo_bar2_exit);



