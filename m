Return-Path: <linux-fsdevel+bounces-26956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6B95D491
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C113B22377
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD98488;
	Fri, 23 Aug 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1zf/04A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C4188939;
	Fri, 23 Aug 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434901; cv=none; b=j0F5LlEF2BWjulNshjD2EZ9y21L7mW7+kUu0Tjp9fkYwHBuue8qmZVAGMabiQ70kfi4OiTWZX0KlrN2R+o27x+5Cr6S0tpipgGbmvxH5EnjSRC32uPycYAWKcnUdsdzfY9QFModEkyp/GloBcWiUi0fhNalzi4Q00Yhf/NygaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434901; c=relaxed/simple;
	bh=2p3QEMWRfgv2vPL3sfcPViAEuSutcnGMSODw4D6OGso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJRz1RANXuNfdWXaFqfYckmRnj0uxLtZ1wsytlYv4jIAfw5COZBnm9vJjYyyUXJzFneCQaxVCMOGmi17M6rdzKhhqma+yTgyxhEqFtwNIBREzUU6swK5Od6J0QyFqoohRj+RwqFfekITnbyiTyOsDVHfvWOoOwT0Je5GN9X9Dks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1zf/04A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D5BC32786;
	Fri, 23 Aug 2024 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724434901;
	bh=2p3QEMWRfgv2vPL3sfcPViAEuSutcnGMSODw4D6OGso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1zf/04ABhuZP2uUpMSTPaL7c6KTEA/o22z9pb5OD0dlijGdTAwMvu2yw24SotERm
	 3Tyo3hwj//N1okj4sTV72xtAGhGofc7JsOwNRpN7c+TYlhyiozMrInFwHunsvIRY6T
	 P+DGOOwIUUJ+cXVFGgHduY8qmEsQct888Xwd/8chf37buP3/1oT6BNI8nX6/WCZH7a
	 rlb/aAGc6XPvqbXXikt91lSq/RJAfl96i+XsAPEOZ8RdBRT0vKmzYcfaln0ldvh1yH
	 MWASKT2rjKw/5/+ubXtHk6SKO2a5A2YOn8OtJXjsupWxO/DRMqowGv9kW4QU1R91p+
	 o98FUe9ne521A==
Date: Fri, 23 Aug 2024 10:41:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: introduce new file range commit ioctls
Message-ID: <20240823174140.GJ865349@frogsfrogsfrogs>
References: <172437084258.57211.13522832162579952916.stgit@frogsfrogsfrogs>
 <172437084278.57211.4355071581143024290.stgit@frogsfrogsfrogs>
 <ZsgMRrOBlBwsHBdZ@infradead.org>
 <e167fb368b8a54b0716ae35730ddc61a658f6f6a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e167fb368b8a54b0716ae35730ddc61a658f6f6a.camel@kernel.org>

On Fri, Aug 23, 2024 at 09:20:15AM -0400, Jeff Layton wrote:
> On Thu, 2024-08-22 at 21:12 -0700, Christoph Hellwig wrote:
> > On Thu, Aug 22, 2024 at 05:01:22PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > This patch introduces two more new ioctls to manage atomic updates to
> > > file contents -- XFS_IOC_START_COMMIT and XFS_IOC_COMMIT_RANGE.  The
> > > commit mechanism here is exactly the same as what XFS_IOC_EXCHANGE_RANGE
> > > does, but with the additional requirement that file2 cannot have changed
> > > since some sampling point.  The start-commit ioctl performs the sampling
> > > of file attributes.
> > 
> > The code itself looks simply enough now, but how do we guarantee
> > that ctime actually works as a full change count and not just by
> > chance here?
> > 
> 
> With current mainline kernels it won't, but the updated multigrain
> timestamp series is in linux-next and is slated to go into v6.12. At
> that point it should be fine for this purpose.

<nod> If these both get merged for 6.12, I think the appropriate port
for this patch is to change xfs_ioc_start_commit to do:

	struct kstat	kstat;

	fill_mg_cmtime(&kstat, STATX_CTIME | STATX_MTIME, XFS_I(ip2));
	kern_f->file2_ctime		= kstat.ctime.tv_sec;
	kern_f->file2_ctime_nsec	= kstat.ctime.tv_nsec;
	kern_f->file2_mtime		= kstat.mtime.tv_sec;
	kern_f->file2_mtime_nsec	= kstat.mtime.tv_nsec;

instead of open-coding the inode_get_[cm]time calls.  The entire
exchangerange feature is still marked experimental, so I didn't think it
was worth rebasing my entire dev branch on the multigrain timestamp
redux series; we can just fix it later.

--D

> -- 
> Jeff Layton <jlayton@kernel.org>
> 

