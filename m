Return-Path: <linux-fsdevel+bounces-27016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF2895DB05
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 05:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCEB1F22A0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 03:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB90029406;
	Sat, 24 Aug 2024 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NBx+hSss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8355EEB1;
	Sat, 24 Aug 2024 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724470163; cv=none; b=aPP8se9OlOOvjAqXpEbtGsMRpBCiYnDiMwkkmp9PttLRB7kMD5AQjwflDBW3cLY9ZzxRnWi+PQHzUqPQrP7Et38lSshIo3mIeGOSoQmAQVUzqDyBqztBjtwKdGcGKeW4QFKnHyiG6p+OH0t8FkhcoBgfG/TECABgfRBbDWTDhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724470163; c=relaxed/simple;
	bh=I+UA0DtqVRNMwNddX2/+zvywFUO6Ica33yhxa7iohXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9IBfyvmECK1q4JEWNR9YBlEndXo+G8tSDg3N18VEnRT7o+tOGdOgYydn6XDMnU41YIQPetCWZVPYBju9N/bmCLTsBt1+FqQNdeaRdVP0onpyjj9u5H3vczLAEPsMss18tu7+RKyUp9sJ/Ob3KLcMgFN2RzHbhK1eSp07zTb4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NBx+hSss; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g1CG2B51tCqSNzpwpij5/A+ywYWXS3gis9aP6EwKM1I=; b=NBx+hSssXTA48oPQ4k76DKDJFz
	u3RqRRSdyvU/QyYDg+2xCXIgvzokcJuyBXHyMIJy/YMxrc5aYK6usvETRKGnsnmrcbaCWE74grdZX
	g9v/Ob4ciPg5QHh5kvxdUziz3gmtA6AA0V2aaqFvzIoE22g7KoQ07YAXsoV4NOpbnjoFSrS4QcCNh
	N0GOzzKnorXtPMxMSNIbi0xKDJVyE7+mLgqNOFSlJsYtMdq2UHFkNqD8jWN0ybegDq63ZeFM7Pp2X
	CQWDV/WDsVV7Chi6/2Ll1JlxD9XKTaTNfc360qk9Nx3ILk5BPqSWmTQ7RajhB3orsVhlL++Tk0OK4
	q44lejWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shhSo-00000001LAD-18Hl;
	Sat, 24 Aug 2024 03:29:18 +0000
Date: Fri, 23 Aug 2024 20:29:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: introduce new file range commit ioctls
Message-ID: <ZslTjr9P-2JUKVg7@infradead.org>
References: <172437084258.57211.13522832162579952916.stgit@frogsfrogsfrogs>
 <172437084278.57211.4355071581143024290.stgit@frogsfrogsfrogs>
 <ZsgMRrOBlBwsHBdZ@infradead.org>
 <e167fb368b8a54b0716ae35730ddc61a658f6f6a.camel@kernel.org>
 <20240823174140.GJ865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823174140.GJ865349@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 23, 2024 at 10:41:40AM -0700, Darrick J. Wong wrote:
> <nod> If these both get merged for 6.12, I think the appropriate port
> for this patch is to change xfs_ioc_start_commit to do:
> 
> 	struct kstat	kstat;
> 
> 	fill_mg_cmtime(&kstat, STATX_CTIME | STATX_MTIME, XFS_I(ip2));
> 	kern_f->file2_ctime		= kstat.ctime.tv_sec;
> 	kern_f->file2_ctime_nsec	= kstat.ctime.tv_nsec;
> 	kern_f->file2_mtime		= kstat.mtime.tv_sec;
> 	kern_f->file2_mtime_nsec	= kstat.mtime.tv_nsec;
> 
> instead of open-coding the inode_get_[cm]time calls.  The entire
> exchangerange feature is still marked experimental, so I didn't think it
> was worth rebasing my entire dev branch on the multigrain timestamp
> redux series; we can just fix it later.

But the commit log could really note this dependency.  This will be
especially useful for backports, but also for anyone reading through
code history.


