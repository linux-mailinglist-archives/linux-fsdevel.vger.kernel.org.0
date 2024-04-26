Return-Path: <linux-fsdevel+bounces-17861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051568B30B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989771F24CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8376613A890;
	Fri, 26 Apr 2024 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yzo4DG2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65E517C8B;
	Fri, 26 Apr 2024 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114201; cv=none; b=u/gYGsAnFTGMT7w0MCiXDgp+Kl7MpkvfIPk26DdUQ0+GihWPSkprbdnH50zwVOHqO9umMqDn0Zwiqs9z7YVQJzXfi+QFYG01c4d1aYl1XAJk9zXBWex9atrTZ0CRr0WNLk111IOFK+MKkHecqQ6snPTq8QAPU+715qJ38piFsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114201; c=relaxed/simple;
	bh=oOh3iDvWfU2xQkc8qDfMvuKOth/slhquYVFXR6lYplA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlTEJ7s8n5pOgNWbD8KpgXE18oU5r3E3nknRRDhNRjuuOyWvwt8wbjC3dVEF6YcexshyIFgbGocclUkySDjOwLuEOd/23pYT2O1AJpXkxznKjLMVHrsbroAoU15i6EFKHS3rDD3l7ZGaY6y78njujn1ERq+pO/LNelQwfyE+MY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yzo4DG2/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oOh3iDvWfU2xQkc8qDfMvuKOth/slhquYVFXR6lYplA=; b=yzo4DG2/PC16+4Q/9Wvwe9vVZ1
	ib62SZdaCIxaAr2gAF+fkA8cKuG2JnZDa6VZRAUzGOX/zk3Eiie7X4ihHQLNhq7pr9UyKke2nZR+O
	KBdI7GiR3domTJ4/SEGYH1/slVd8pN8qoMVscbp9B/Vlz72DzEz+ajx8UsibTR8feE1uwVQZzqiF3
	iFdSp8kSAgiMqRaw5LGD4pImoh/X308Ie9ULxxT+F8FW4F2J1xoDJUX9cwbpzgeVyxfhhW8TkRm+F
	+o0quAfh/PfLlVgud+fHTY0+kyHw0TQY0hH1tjZNx1qd9bUh6QviNuo90XejJpaHln5dsJ35Y77yl
	WUSPfkWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0FPB-0000000BMRG-0ZcU;
	Fri, 26 Apr 2024 06:49:57 +0000
Date: Thu, 25 Apr 2024 23:49:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 5/7] iomap: Fix iomap_adjust_read_range for plen
 calculation
Message-ID: <ZitOlbeIO4_XVw8r@infradead.org>
References: <cover.1714046808.git.ritesh.list@gmail.com>
 <deb8991ce9aa1850b82471cf3e76cd8fdc1a9e92.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb8991ce9aa1850b82471cf3e76cd8fdc1a9e92.1714046808.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 25, 2024 at 06:58:49PM +0530, Ritesh Harjani (IBM) wrote:
> If the extent spans the block that contains the i_size, we need to

s/the i_size/i_size/.

> handle both halves separately

.. so that we properly zero data in the page cache for blocks that are
entirely outside of i_size.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


