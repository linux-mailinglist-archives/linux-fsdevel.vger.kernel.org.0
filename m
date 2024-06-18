Return-Path: <linux-fsdevel+bounces-21895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10EA90D9E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 18:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF45B1C2251A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8113DDD2;
	Tue, 18 Jun 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IAatnFbo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6213AD2F;
	Tue, 18 Jun 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729490; cv=none; b=skN1lD9X4T9LHysXVWY9XN8doD5rVAppLFf3VJ942RIJl6hTNJ9hfQ71U4wc1g4QeubGPmcNhw3MRnI5RS4utWsmwtbOsbvZVIAd+tR9Tf/icUNDXnTBN05jN+bXwImvgqme7zqFnZsiYFVARC9OKoG2l+6PGpq+elh4oP1kfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729490; c=relaxed/simple;
	bh=Y3aAJgJAHNUzv7HCpjADYb0VWexqaz2jNCxzThrc01c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssMzNgLZAieVJAtYGk+eySfIucYVeLzrdvbQjvf2RwPRlh1ZG+ev+TZ9zkVHSKTLGNh1Lc9P595yuS8gWOVWKMRjVntfXU0Zy+qTstTrDRRNrrMQXcx3uIL8B5RFDJyVpQDQfGxNyLvonP3nz9F8+jfQEDyhvpJRdpSm77YPcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IAatnFbo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gNwWvVPDuFQMa8mCQ6H3iJIPwNDRw1EEOJraqpFJaVM=; b=IAatnFbo1rQj4iMoo+iZl/kvBI
	GIrN683fTy+XzQLg7pWMdpq+B9bMeiVgrnVm0OXXG2lJR3dnFS1XqixeGKc02f0BJYqt2a7Xw5wHn
	O7uR85eCzzycIVeuBw79hKbcQXnaFEX00ywUkeQmz0emngRvUAkInhQYHXqDPxGf1ochV8ngzvGur
	Eo3cwRkkWn+MU5RzGIw2noGe+mYpJ8N46Ih1cQrK3xhHropnCOGF/20GpUDH4Zb57SBP2f4WiSx/g
	kzb1CUHYtc9r0YvhwecVJgakK3gCIGMVRRGR1DjAcmcnAVlKOuUn+S9dyCZ5RtpsNl1MpDkKmtgD1
	+RggggxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJc3I-00000003YsD-3jNx;
	Tue, 18 Jun 2024 16:51:24 +0000
Date: Tue, 18 Jun 2024 17:51:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com
Subject: Re: [PATCH 1/2] xfs: reorder xfs_inode structure elements to remove
 unneeded padding.
Message-ID: <ZnG7DJrVov5n6O5m@casper.infradead.org>
References: <20240618113505.476072-1-sunjunchao2870@gmail.com>
 <20240618162327.GE103034@frogsfrogsfrogs>
 <CAHB1NajUvCmPK_fTVgpdXz--Qn69Ttx5W4k9Xbq18MbarzUfVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NajUvCmPK_fTVgpdXz--Qn69Ttx5W4k9Xbq18MbarzUfVA@mail.gmail.com>

On Tue, Jun 18, 2024 at 12:40:23PM -0400, JunChao Sun wrote:
> Darrick J. Wong <djwong@kernel.org> 于2024年6月18日周二 12:23写道：
> >
> > On Tue, Jun 18, 2024 at 07:35:04PM +0800, Junchao Sun wrote:
> > > By reordering the elements in the xfs_inode structure, we can
> > > reduce the padding needed on an x86_64 system by 8 bytes.
> >
> >
> > > Does this result in denser packing of xfs_inode objects in the slab
> > > page?
> 
> No. Before applying the patch, the size of xfs_inode is 1800 bytes
> with my config, and after applying the patch, the size is 1792 bytes.
> This slight reduction does not result in a denser packing of xfs_inode
> objects within a single page.

The "config dependent" part of this is important though.  On my
laptop running Debian 6.6.15-amd64, xfs_inode is exactly 1024 bytes,
and slab chooses to allocate 32 of them from an order-3 slab.

Your config gets you 18 from an order-3 slab, and you'd need to get
it down to 1724 (probably 1720 bytes due to alignment) to get 19
from an order-3 slab.  I bet you have lockdep or something on.

