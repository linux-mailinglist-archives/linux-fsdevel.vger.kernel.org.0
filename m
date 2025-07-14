Return-Path: <linux-fsdevel+bounces-54863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B526CB04319
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D3F7B5827
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CE126058D;
	Mon, 14 Jul 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Tr5+8PJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05812260565
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505645; cv=none; b=QomY8CwM3CsFusMczKWFujV+5pIpZu9bDPIgMLnm9PH7klMQ0xLZ2i/iGyR5YGL/3hsaWsdXcDUjUR2c6An7aJvKCSlud/fXOxJAXdcv+DESli7oDqrn+p4tEz3dqKTWC+AbntOWTAQ209k41iO/s3iMUURTIjIEYCJykr9VXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505645; c=relaxed/simple;
	bh=udOYvFf594iBgHZ847wSFlruqtoP1ZiDh6g4zZa90oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4Ot2yvpuqDkWC4ptDOu391/aoBTy+o2TH9hAPMudFtuaRgb/rK4h1CsXins2bf1PMdV07mot2J8/CZFfPgZaMAWVACvkz3YIK564C3s31PJ60rq+RR5ouAdi0YemiuAcBSObDMvOckZlMnKqGBHFF9gbapihi1CAUQKQaF7C94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Tr5+8PJO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KH/H8GwCl9KkcNw7bU6i9Xknl+x4Ez2UG/OPGPrPhyc=; b=Tr5+8PJOduABvlV0HRjteMoELU
	zODQVLPRoYCVFfnlLAbyYLwY4+UUewtt0N0XWpNLnEUp97dpRwYWfDdydlWStsbEfsXhuvGevBxSo
	hiPqQziW5JDgvZ09k2sBts+jPCXxnFsThCirhtsYoGRVnWZVxRM6md+BWI1+3f/LjyjrnQLAEsSJc
	SpDlufIj70acK9cRBYMQyPwQkOvp0I5QdpG34A0Dj35y9N4L9bj06EcBb8Sr+jinxcUcgAu7XpGIY
	rkITVdAdPO8Ko69ShQWtSWHmgd8DR0o9+J3duq3VDouMYxYNQgHDDvDCi5p+3SzDyyyC7Hxe0485q
	JAhWJOHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubKm1-00000008wzP-1LMP;
	Mon, 14 Jul 2025 15:07:21 +0000
Date: Mon, 14 Jul 2025 16:07:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix a leak in fcntl_dirnotify()
Message-ID: <20250714150721.GG1880847@ZenIV>
References: <20250712171843.GB1880847@ZenIV>
 <20250714-kniebeschwerden-wachdienst-66609223c4b5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-kniebeschwerden-wachdienst-66609223c4b5@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 14, 2025 at 10:14:38AM +0200, Christian Brauner wrote:
> On Sat, Jul 12, 2025 at 06:18:43PM +0100, Al Viro wrote:
> > [into #fixes, unless somebody objects]
> > 
> > Lifetime of new_dn_mark is controlled by that of its ->fsn_mark,
> > pointed to by new_fsn_mark.  Unfortunately, a failure exit had
> > been inserted between the allocation of new_dn_mark and the
> > call of fsnotify_init_mark(), ending up with a leak.
> >     
> > Fixes: 1934b212615d "file: reclaim 24 bytes from f_owner"
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> I'll grab this into vfs.fixes and send it with the batch I have in
> there this week.

OK...  Again, the only things I've got in the vicinity are post-rc1
fodder, so I've no preferences re which branch does that go through.

