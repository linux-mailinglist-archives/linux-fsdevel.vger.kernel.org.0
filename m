Return-Path: <linux-fsdevel+bounces-31082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089FB991ACC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 23:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9FE283E8B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 21:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F7A15A86B;
	Sat,  5 Oct 2024 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DwijrrEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF9231CA7
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728163265; cv=none; b=GHgHLm00PYuAKpuJntPf/ctxv7iKA6iYxWpjhzb7GjQvmCDhqdrffJU3nOSUtSmfAH4iU2L3yYUVOSgH+wgX4feASegiahjcEGwaLkPStRFFck10S2h3XVxntj2xluVq3fD4Rre9RbDpP9YvQWbox+lNmhGcxkn+jOk392LDBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728163265; c=relaxed/simple;
	bh=F2XWpN2hfxxQtnvs6ySBxCVlqPDaGX6lA2VLSFA7ano=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdMbseS0jjFI3iL31eFA/UB144fTM44PHL7LZiyKEOuw7A2YeyubGEFr8BncTXzXbgAVgqNUVQastVytJxuKsv0Y/g/5LW8HRjI/FxqtDjF9JreuClhsRM7jG84nTg/hUOeWGRrqpopGvBFpzbNe2cc6lQi3XurelcgzsnfuHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DwijrrEg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gRHQV9j4K0OqjjZ788F0fmO3xD3FPLWuCWi/SQJBUhM=; b=DwijrrEgc40R96tCYqYVXfrRRl
	iOZX8IKcMNzmVITR/eGdt2XSRFxBHgcG781/GjFHJ62qHK+a0kf9o02GtEnX61tDULh6l/OwQrD9H
	vDL0yAs4TILjaNtMaDnAM2W75AMzoek2cxAUxnaXyQ+l1bmii2xIiRvaZAa8Jlr2c2FCGtZ1Zk5h2
	yvntDcxNXn5a6hr2WcVK+FCYq0bouRPKuXSvO3CjMi43HfB4JJ4uc5fB61KM0vCM6B8gvmMOUyJUd
	Vse0bGe8FOMRvBKlmdt9S2oDpc/i9rAJc8EoDs+oV4J8+mvqFMCI9iNMkjj6evAmvhbBh6PBELfpL
	k/zGaJdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxCCz-00000001AGD-2IMc;
	Sat, 05 Oct 2024 21:21:01 +0000
Date: Sat, 5 Oct 2024 22:21:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] UFS: Final folio conversions
Message-ID: <20241005212101.GZ4017910@ZenIV>
References: <20241005180214.3181728-1-willy@infradead.org>
 <20241005183108.GX4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005183108.GX4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 05, 2024 at 07:31:08PM +0100, Al Viro wrote:
> On Sat, Oct 05, 2024 at 07:02:03PM +0100, Matthew Wilcox (Oracle) wrote:
> > This is the last use of struct page I've been able to find in UFS.
> > All the hard work was done earlier; this is just passing in bh->b_folio
> > instead of bh->b_page.
> > 
> > Matthew Wilcox (Oracle) (5):
> >   ufs: Convert ufs_inode_getblock() to take a folio
> >   ufs: Convert ufs_extend_tail() to take a folio
> >   ufs: Convert ufs_inode_getfrag() to take a folio
> >   ufs: Pass a folio to ufs_new_fragments()
> >   ufs: Convert ufs_change_blocknr() to take a folio
> > 
> >  fs/ufs/balloc.c | 16 ++++++++--------
> >  fs/ufs/inode.c  | 30 ++++++++++++++----------------
> >  fs/ufs/ufs.h    |  8 ++++----
> >  3 files changed, 26 insertions(+), 28 deletions(-)
> 
> Looks sane (for now - there's really interesting shite around the block
> relocation, hole filling, etc.); I've got a bunch of UFS patches and IMO
> it makes sense to keep it in the same branch.  Mine is in #work.ufs
> and there's pending work locally.
> 
> I'll add yours to the mix and see if xfstests catch any problems there;
> will post tonight.

No regressions.

