Return-Path: <linux-fsdevel+bounces-23446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C092C525
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 23:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1A71F22A63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238F18562B;
	Tue,  9 Jul 2024 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="fU0YrPQt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50E12E1E9;
	Tue,  9 Jul 2024 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559326; cv=none; b=HvugQ6d1psg6dW2pM0Er3sIwKtaTQ02nK5ka7fm+2fGoO/BwMRiMVZAMA1b+QuuArP8wDk2xR8PwsLMV51jZLK9iqy9T+WRQJ4CUo4qSyRs2pdolQRvrZGzww2a32A6eMfj7QDgXPsGDDjK9hW5MlZOpi3SbYmkwjxxPXsIJeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559326; c=relaxed/simple;
	bh=Q9YZ4dMO4FrcXEYd8kqmrues+YkMLPsOb9HS455Udr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCPS1+nOa3lHQSu6DMEnJe5KGw89nh+m+/r8TdoRpS9uQr5D+TVxL9jSq7c63O+hm+SZFAMb49UbR4w/ZIMeK7hKOHkGkM/x7pI2kaVlURz5M4CHGtmyk1C2ePjSP3OPB/nMOJUT0ooZNogLCZ6OynFRQ6tnpzmVfJk3xON9VW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=fU0YrPQt; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WJYW61S9Cz9scJ;
	Tue,  9 Jul 2024 23:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720559314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVjuijbIr/b7fVxDSSOmDOpSaFlx4V8o7i65KF3sL+E=;
	b=fU0YrPQtSaMiHdH59A/z/WbCWtgL0Gd/ubUJnDLi2lbwjYRFYc8YzmqEiJz27+ZLPOU0FF
	LqJodweJikQZgbdVSSdCBNMnMQTeP/nUQku5UEuzhJ+zVSnSmWUNA18D4O5VQdi9+EbJV4
	/v5sGpyGDyS0JgB7wWmM7s3xx3CyuzS/7VyTsWQE3iX3GyMKduF8PLWILwyaWoiqmrM+NF
	uCm2KCrNmitAmVV6ZOPKNmlN8t50hMo+jsE0M05OrbaEgvjfc+OPqvPcVkkSSHaUG/BpVl
	f/VEqIz9YlUiOLjkxZ0J0OxqxVugHxAjssgPPP2ITzAVVnUO9QYLCjVv+vA6hQ==
Date: Tue, 9 Jul 2024 21:08:29 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: david@fromorbit.com, willy@infradead.org, ryan.roberts@arm.com,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>,
	akpm@linux-foundation.org, chandan.babu@oracle.com
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240709210829.dgm6dsirkry3fgu6@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <20240709162907.gsd5nf33teoss5ir@quentin>
 <20240709165047.GS1998502@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709165047.GS1998502@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4WJYW61S9Cz9scJ

> > 
> > - We make THP an explicit dependency for XFS:
> > 
> > diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
> > index d41edd30388b7..be2c1c0e9fe8b 100644
> > --- a/fs/xfs/Kconfig
> > +++ b/fs/xfs/Kconfig
> > @@ -5,6 +5,7 @@ config XFS_FS
> >         select EXPORTFS
> >         select LIBCRC32C
> >         select FS_IOMAP
> > +       select TRANSPARENT_HUGEPAGE
> >         help
> >           XFS is a high performance journaling filesystem which originated
> >           on the SGI IRIX platform.  It is completely multi-threaded, can
> > 
> > OR
> > 
> > We create a helper in page cache that FSs can use to check if a specific
> > order can be supported at mount time:
> 
> I like this solution better; if XFS is going to drop support for o[ld]d
> architectures I think we need /some/ sort of notice period.  Or at least
> a better story than "we want to support 64k fsblocks on x64 so we're
> withdrawing support even for 4k fsblocks and smallish filesystems on
> m68k".
> 
> You probably don't want bs>ps support to block on some arcane discussion
> about 32-bit, right? ;)
> 

:)

> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 14e1415f7dcf..9be775ef11a5 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -374,6 +374,14 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
> >  #define MAX_XAS_ORDER          (XA_CHUNK_SHIFT * 2 - 1)
> >  #define MAX_PAGECACHE_ORDER    min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
> >  
> > +
> > +static inline unsigned int mapping_max_folio_order_supported()
> > +{
> > +    if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +      return 0;
> 
> Shouldn't this line be indented by two tabs, not six spaces?
> 
> > +    return MAX_PAGECACHE_ORDER;
> > +}
> 
> Alternately, should this return the max folio size in bytes?
> 
> static inline size_t mapping_max_folio_size(void)
> {
> 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> 		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
> 	return PAGE_SIZE;
> }

We already have mapping_max_folio_size(mapping) which returns the
maximum folio order set for that mapping. So this could be called as
mapping_max_folio_size_supported().

So we could just have mapping_max_folio_size_supported() instead of
having mapping_max_folio_order_supported as you suggest.

> 
> Then the validation looks like:
> 
> 	const size_t	max_folio_size = mapping_max_folio_size();
> 
> 	if (mp->m_sb.sb_blocksize > max_folio_size) {
> 		xfs_warn(mp,
>  "block size (%u bytes) not supported; maximum folio size is %u.",
> 				mp->m_sb.sb_blocksize, max_folio_size);
> 		error = -ENOSYS;
> 		goto out_free_sb;
> 	}
> 
> (Don't mind me bikeshedding here.)
> 
> > +
> > 
> > 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index b8a93a8f35cac..e2be8743c2c20 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1647,6 +1647,15 @@ xfs_fs_fill_super(
> >                         goto out_free_sb;
> >                 }
> >  
> > +               if (mp->m_sb.sb_blocklog - PAGE_SHIFT >
> > +                   mapping_max_folio_order_supported()) {
> > +                       xfs_warn(mp,
> > +"Block Size (%d bytes) is not supported. Check MAX_PAGECACHE_ORDER",
> > +                       mp->m_sb.sb_blocksize);
> 
> You might as well print MAX_PAGECACHE_ORDER here to make analysis
> easier on less-familiar architectures:

Yes!

> 
> 			xfs_warn(mp,
>  "block size (%d bytes) is not supported; max folio size is %u.",
> 					mp->m_sb.sb_blocksize,
> 					1U << mapping_max_folio_order_supported());
> 
> (I wrote this comment first.)

> 
> --D
> 
> > +                       error = -ENOSYS;
> > +                       goto out_free_sb;
> > +               }
> > +
> >                 xfs_warn(mp,
> >  "EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
> >                         mp->m_sb.sb_blocksize);
> > 
> > 
> > --
> > Pankaj

