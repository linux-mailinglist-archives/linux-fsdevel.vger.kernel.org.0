Return-Path: <linux-fsdevel+bounces-51096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7668AD2C63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4915188C5B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06DF25D20D;
	Tue, 10 Jun 2025 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ij0pXANl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDEC11712;
	Tue, 10 Jun 2025 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749528252; cv=none; b=bASVnEQUtXl/hfv4P9B9H9pmd4VfX3lT5vyKT042b2oR8kxK5Y4T7C3p/KBZiPFtfNLu1epb7jivHXR4R9CKgTnetaHahM97gIjOT5qruCZl11cvpgtobE+RukGbHKPCN3QOo11AiBAwCUvthQ8DSdM3qOEA4mlzNYu1GmEVGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749528252; c=relaxed/simple;
	bh=BmGJS6I+NChOcdJFw7W+Bo5Kv0YTfLtr6VVrpHJQZh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzhwT/lg/uX97WvKinp5XQGsxoSObIFdic8awipAUMhgZ0eaN0cbu8WAGf2n8mBcKbCyYEPvVIa6C5780LITnJi4uh00U6bDarOMGiRpAl+YTyWT7E3/9Tsl5HNybBreAJIXbImTzyIRN49pF+ok8/U9xtO54afRI6J3B5YKwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ij0pXANl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4JY/GXvKvuSF+Gv+dyI6WEbQbn/XNxNx/VjsNZPP8rY=; b=Ij0pXANlfvLd1MbZZNmNWCijzy
	6uvsJ/TOgAkEwFIYLnVQ8jqUQX0VUAc/HpI9ZmCSz7jgO69M1cPmcKYy0Tppu/hHfqrlveimlkpvl
	dBaWB6xFleaK6AP6/CvuyfFGGOq+P3ret2+bAqvP0iEoULNiW8+Vkh3DwOkLSDkP5LccnEWaDtcMf
	H6v6KKe2jF6Fh6vDeq50LKoZVz/AnmvtpB4WMFRUalDm/ynPtjimZByeQClmPZ20PONCNceADn4k4
	GeZ8MNYORbMevS/Q47US6tGSMZKqvOxjuvpMptBuiCY8/e/AvtTcC372MnwewZAcMb5UhXSWDAMSu
	enpsCL7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqDa-00000005isc-1zmj;
	Tue, 10 Jun 2025 04:04:10 +0000
Date: Mon, 9 Jun 2025 21:04:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
Message-ID: <aEeuuvdJWGEuFKX3@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <aEZly7K9Uok5KBtq@infradead.org>
 <CACzX3AsfbJjNUaXEX6-497x+uzHptrxM=wTUnDwy_tH6jAEMTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzX3AsfbJjNUaXEX6-497x+uzHptrxM=wTUnDwy_tH6jAEMTQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 06:08:30PM +0530, Anuj gupta wrote:
> On Mon, Jun 9, 2025 at 10:10 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Can you also point to a branch or at least tell the baseline?
> > The patches won't apply against Linus' 6.16-rc tree.
> >
> Yes I had a hard time too, figuring that out. FWIW, it applies fine on
> top of this branch [1]. It would be a great, if base commit can shared
> in the next iterations.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=for-next

Looks like this is still behind on mainline as even applying to
linux-next doesn't work.  Hope the merge window has settled a bit more
before the next version.


