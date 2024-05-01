Return-Path: <linux-fsdevel+bounces-18402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2558B85B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08285284706
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B4C4C635;
	Wed,  1 May 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1vzrBMl0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121A7F;
	Wed,  1 May 2024 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546473; cv=none; b=mDrw7qoqcoHyMrbuTjDe38lvX0EKxov6uynJrXG/jth49Aqy36pxqWGZnhDetBYtSSuBL6Eq0HPfcKFiJNVjP/QrLg/0TPUfEIGqxGp2eoEIHFRzyqSnUX/lj6JjGX2LE6RnvritoxsDfL+xDjRBek1uWZ854alx7T3YDAB3bp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546473; c=relaxed/simple;
	bh=Drt/KMy6/zX0sfw8Yc83NAUA/A2+mwDgsW7Fs6R5Gis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHKLxIA1ybMgO7FvXv2o4ZYc81rntWJ0pYCd6A52R1n8lu29C+neLiCtwrdF1k9h0ZzBEgLdiyStFX14tJ6qkL0Ls5vROO+kwyI78L3jQ+FiyYMYwmnhvZeH6aEYXsSWGXAVBywG5BmKlzletLwBYGQ38XGnvWK5yTAWYcZBuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1vzrBMl0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lGwwxT0mpwx7O2ptAVkArbeQHWRcI2b+SOB6soNI5D8=; b=1vzrBMl0mshoTMfA9elkeKTC/X
	amwEs4f0xuOAQbye7JieZAcKSLFPOfoTj30qUIneWNP/Y5pxs2R9x6PDp5Kad7G7GCi8ISkRdqOKs
	hTShce8Ql/inQfwrZyF0toGHzrzmkMpcqc6kjER6HS0xDEKXxwOC7m+3CBLREU2p0Uivr4E13x+NO
	WbA2EHMUCcAM5uRqgQM13+48dmaESpc343JBHCO5rt6zYLtq/nO4KqGN22OZrPOJaTg03nYcyqA43
	u0TeV5Zrah/itNyw+0aHBskIrIaz3FVf+n/8w/MtsvisBb3Of2JJs/8fmsjCywcUF/3CNdVrVpr+1
	YeXn45Wg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s23rK-00000008i8i-3AML;
	Wed, 01 May 2024 06:54:30 +0000
Date: Tue, 30 Apr 2024 23:54:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/26] xfs: widen flags argument to the xfs_iflags_*
 helpers
Message-ID: <ZjHnJpG5MOQU6WYP@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680584.957659.3744585033664433370.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444680584.957659.3744585033664433370.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 08:27:29PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> xfs_inode.i_flags is an unsigned long, so make these helpers take that
> as the flags argument instead of unsigned short.  This is needed for the
> next patch.
> 
> While we're at it, remove the iflags variable from xfs_iget_cache_miss
> because we no longer need it.

I just reinvented this for another flag in work in progress code.
Can we just get included in the current for-next tree?


