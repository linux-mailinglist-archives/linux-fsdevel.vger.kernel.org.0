Return-Path: <linux-fsdevel+bounces-55169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66463B07779
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAB81C28112
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1511E3DDB;
	Wed, 16 Jul 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EnJXOD8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2731E1E1C
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674269; cv=none; b=GYuZRvshgmv1chPeKoh3lMxKAtbTEoqV3NDC0E1OO7abJrGRC1es+891MERyYUnDwGikpkI2tuYD8Kh19eRM3LHR1vpMu5heMCM9z0s3kies0bnl1BXsO+DlRt2I0K4/Em1aYUhU/MmloIy7xKWnSQzOl6ZXVvKRakQhhiGtjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674269; c=relaxed/simple;
	bh=bkmHW8Q/T3S5U9duZDJqPHjbOoEA+HgWFD29O+cJUdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbotI+2PICQohmu9PE/5G4ZKmeUGE5Xg4iyuCS2paqIU7gl7DzMaxdXeO7TPX8qbI7/NGEE/oJqNXy5adJjDSThJdc1F9627DzpEeZ1YrPJYoiCkwSTK9BVszhVO0Gx1FTyu3m6K2Cm6zB8I6Aj896GfAs2e/+1b6vVQvJWaQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EnJXOD8I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=iQF16LAFIzKF6XmZ9FjYPE5wuHNnxgcniHJYsQcG96Q=; b=EnJXOD8IfUg77dCXkuBbbrUujW
	PN6RV9ku+ogBx0YVSgXp0x2zqCfG2UDR27N4N1V0lV3UbTKShzHVIYX2I2VNAMcfqb4BGuD4y2DvS
	BikMvR1Fqnxzw2Zv3swrHBArFel++SkCXF/XEWLjsYCq16SgKalvRFvnsYdw3aazVV5jEXiuzStdd
	iSNuFeaKSTE6Mya1zUECVhh7z/yj79u6UKDZnV4VQFM1R5Z79brZDKanvUVSpDcRCi8TXokyYYpuk
	lbDBeRsi9es+92B/1ZPLHQ9ZN+kcvYvti1k+/4unhJMmnWVWLr1UEX0g/70VoI2RRcJVEOOUFdWiI
	4Nlbbo+g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2dl-0000000GktA-25YO;
	Wed, 16 Jul 2025 13:57:45 +0000
Date: Wed, 16 Jul 2025 14:57:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alex <alex.fcyrx@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Remove obsolete logic in i_size_read/write
Message-ID: <aHev2X8439xaamsX@casper.infradead.org>
References: <20250716125304.1189790-1-alex.fcyrx@gmail.com>
 <20250716131250.GC2580412@ZenIV>
 <CAKawSAmp668+zUcaThnnhMtU8hmyTOKifHqxfE02WKYYpWxVHg@mail.gmail.com>
 <aHesCjzSInq8w757@casper.infradead.org>
 <CAKawSAkQd_V9wJn6fiQQWVguTB0e7vDNnQqjuZRUZ1VwzXuvog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKawSAkQd_V9wJn6fiQQWVguTB0e7vDNnQqjuZRUZ1VwzXuvog@mail.gmail.com>

On Wed, Jul 16, 2025 at 09:44:31PM +0800, Alex wrote:
> On Wed, Jul 16, 2025 at 9:41 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jul 16, 2025 at 09:28:29PM +0800, Alex wrote:
> > > On Wed, Jul 16, 2025 at 9:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > On Wed, Jul 16, 2025 at 08:53:04PM +0800, Alex wrote:
> > > > > The logic is used to protect load/store tearing on 32 bit platforms,
> > > > > for example, after i_size_read returned, there is no guarantee that
> > > > > inode->size won't be changed. Therefore, READ/WRITE_ONCE suffice, which
> > > > > is already implied by smp_load_acquire/smp_store_release.
> > > >
> > > > Sorry, what?  The problem is not a _later_ change, it's getting the
> > > > upper and lower 32bit halves from different values.
> > > >
> > > > Before: position is 0xffffffff
> > > > After: position is 0x100000000
> > > > The value that might be returned by your variant: 0x1ffffffff.
> > >
> > > I mean the sequence lock here is used to only avoid load/store tearing,
> > > smp_load_acquire/smp_store_release already protects that.
> >
> > Why do you think that?  You're wrong, but it'd be useful to understand
> > what misled you into thinking that.
> 
> smp_load_acquire/smp_store_release implies READ_ONCE/WRITE_ONCE,
> and READ_ONCE/WRITE_ONCE avoid load/store tearing.
> 
> What am I missing here?

They only avoid tearing for sizes <= word size.  If you have a 32-bit
CPU, they cannot avoid tearing for 64-bit loads/stores.

