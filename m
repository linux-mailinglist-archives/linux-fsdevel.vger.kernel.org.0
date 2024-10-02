Return-Path: <linux-fsdevel+bounces-30752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB4E98E144
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D891F239E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34E1D12EB;
	Wed,  2 Oct 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzEVuL1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CFA16419;
	Wed,  2 Oct 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888230; cv=none; b=qrkDlbSFNgLsqdoOWPVKcJqQDZMYLA+yrU0JojwSbHSxDUKfvoKlLji9z6M3/Rps1AGNX66luF/A9ZPjbEhPuN1yk5H2HGYivEQGvbVFJULmJYG1ssN2DBpr0VjhEMm3vpjLHCT9Jo2vlVVqMuWL2F51dkHAinuX+/vo08WBfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888230; c=relaxed/simple;
	bh=ZcWUEPBkasOZ4r64xl4TpQmpWpGSv+VbxE8JlrGlY2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXDgjrEWvHdY/CUWHMi/29BtoEMQ9AfhAEeFGZcZNtXUGwqewTbHlL+yLVc6QrWlSYObIBVweyMJvL8mHFWdgPCRFzZ89r6Q3rmSQSeOJitd3c2IyFTqjZSAm+Qm5UIGIdBTsznW+Wvw3ITXCePdBB7HexRg2a/j5rHVopMbG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzEVuL1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6246C4CEC2;
	Wed,  2 Oct 2024 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727888229;
	bh=ZcWUEPBkasOZ4r64xl4TpQmpWpGSv+VbxE8JlrGlY2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TzEVuL1yMGQ755MH+1Fh+CznOM4HSzM2NlLhoAb9Rlb0ou6i8BQOHFylvcJVNT64J
	 YLI1hM+zbBrzqys17cg8Pcdaej82qPPjwbPTOLedwNY2Hb1HZDEdRymKoG/cOnYoO3
	 FcWwNj1bTg+KEy/bG54+JR3aRRuo57fxNiHcJYmWzv+XwGi+8ALW/GYP5n8JH8ap17
	 F+xG0Dn7Xg8yORu6ym1FBQ3+B3Fzlw0xu4ArERMtIKzLskEMY4qcZyoaKkX/28Roql
	 9K1W3RbOLRfGcfgO9zjpP7bnfLJj0Da4B3WuP/Gmdppctjz181d90iIOJUihZ8GAFA
	 D1doNmD6wqZlQ==
Date: Wed, 2 Oct 2024 09:57:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] iomap: don't bother unsharing delalloc extents
Message-ID: <20241002165709.GD21853@frogsfrogsfrogs>
References: <20241002150040.GB21853@frogsfrogsfrogs>
 <Zv1uQnLdM_GgIEo3@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv1uQnLdM_GgIEo3@bfoster>

On Wed, Oct 02, 2024 at 12:01:06PM -0400, Brian Foster wrote:
> On Wed, Oct 02, 2024 at 08:00:40AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > If unshare encounters a delalloc reservation in the srcmap, that means
> > that the file range isn't shared because delalloc reservations cannot be
> > reflinked.  Therefore, don't try to unshare them.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/iomap/buffered-io.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 11ea747228aee..c1c559e0cc07c 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1321,7 +1321,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
> >  		return length;
> >  
> >  	/*
> > -	 * Don't bother with holes or unwritten extents.
> > +	 * Don't bother with delalloc reservations, holes or unwritten extents.
> >  	 *
> >  	 * Note that we use srcmap directly instead of iomap_iter_srcmap as
> >  	 * unsharing requires providing a separate source map, and the presence
> > @@ -1330,6 +1330,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
> >  	 * fork for XFS.
> >  	 */
> >  	if (iter->srcmap.type == IOMAP_HOLE ||
> > +	    iter->srcmap.type == IOMAP_DELALLOC ||
> >  	    iter->srcmap.type == IOMAP_UNWRITTEN)
> >  		return length;
> >  
> > 
> 
> IIUC in the case of shared blocks srcmap always refers to the data fork
> (so delalloc in the COW fork is not an issue). If so:

Yep.

> Reviewed-by: Brian Foster <bfoster@redhat.com>

Thanks!

--D

