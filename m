Return-Path: <linux-fsdevel+bounces-56391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B3B1707C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10623A81EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004D12C15A5;
	Thu, 31 Jul 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alzogFGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750612C159B
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962184; cv=none; b=qRedIfXEKrB0iA1gBp3EaNlYHCPfksL+DgV5QunZbrTam9bp2GM0GyXj7dHB4LUU4ROLQoSXL7tqDpP5SlKyHG+ja38zHxF+Da0uFAI8ZhZ6cPXGSd68W5FcIe/0Ngea2hxc6RvatPbFGDd/xRj5xY7b8WlHo7jD4K+JLAVkRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962184; c=relaxed/simple;
	bh=lPPR+xOELWOjgNYZPLA2fZ8JUQ13Q6IiXHiwQiLDycc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIbR6ENhUQJF/9bfADdMj/4au81jsuZ3lRy4ngzoMbtaKhAjuU3l95jm/+k604atA29yrBzuebobaXtkfF/3bHlf6wz4mKD8TJMNlXSzhq1WV/8D9ZcrByXXHWVemJdIe3xiixRQoEKE+XDQNdCAlGFbATWE5iFu6PfG3iUkyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alzogFGO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753962181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fo+NPNjMxlQ2cBw7t4Z+XizD1fhqWsIHl9ucwxzn9EA=;
	b=alzogFGOo1d1photn8iAKkbAFhqos/a1OSOFSV8YwjLMjy4WeqWBWYIbt+wPT0SvtOzoP9
	3PR26amSC7lYnnshn/NXJgkZ0BhRKwTSGNjBXumdfPnswunxYGDfOtSCHNa3/nj9URy1Oz
	Offd65ths7xkjXfdTvGylpE22fmVkgQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-m8LgnQmBOlOz63xnNUbxJg-1; Thu, 31 Jul 2025 07:43:00 -0400
X-MC-Unique: m8LgnQmBOlOz63xnNUbxJg-1
X-Mimecast-MFC-AGG-ID: m8LgnQmBOlOz63xnNUbxJg_1753962177
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae1c79fb8a9so35362966b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 04:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962177; x=1754566977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo+NPNjMxlQ2cBw7t4Z+XizD1fhqWsIHl9ucwxzn9EA=;
        b=hPyR7atR1p2pOd3H1DxGICExP//sx4xwFMFXy7NosUE84UBjdPGtNiR0A3hQjecMkQ
         3/oj/JnUjlq/itjiuIHwk6iSiaR0arTKadep7qpssSLvVpzCZKn3Jj0dgzUkO9axWLKh
         5rsAkVnExPkx/Pc3mLqEBOsqdO6EYvpEwd/x+NsfPPKiDuvVeDp8TJD3CR1eAA1gGAch
         945k3Q34MPIT9G3DGJfxaJfzm4i6oVYQm0kTDoHYORoSYE/zEOR6jg62QVawb6nv+qRo
         EXXFEzjaVaFJXBN9PPOM8YtwyuQqfLvPnglS3ALTkXYYAMECjSwWSlTlKoiZbdGnbOpY
         xdIw==
X-Forwarded-Encrypted: i=1; AJvYcCV/NWmLHmjMPEYmJVdD+PLwDn7Vl8mXqr5/rji+fJWC8/roLxKTepnCS+IGoXyTuQE/QKvo50WX+M0jeo17@vger.kernel.org
X-Gm-Message-State: AOJu0YzniOjxkNjGmiDHZhgmhcqIG8QgMPbsJEFsH41d3dTcLYIR74MX
	Rrb3quPyJiuQAkaEugvSEqAPYWZFgtx2vVnCWtq2BnPLaF77HC0XZJe+fTV8OtfDxuXNkGFjYrN
	5hiPIAwOlCCQW224QP8RG4l73ZIgju6Ls5rWF8N7F03NiOsyRWroe/JedYTuH7J2y9Q==
X-Gm-Gg: ASbGncvoS3P+vP3IHGFiQV2H1wigv5LKxHdtw6VlA/3z1MCgNkY/5j9Z+Kl/4V2GQWk
	ovjA3k21dVCIZPuArLm+daxJD9mXi4VTBiPfLw9t7lhBu3zjf6AWrJPhLVlgv0sGWF93siyNCwD
	xQn+wmyURAZ6g9nFppfKJjhHcJ3AG7ePT2g3buWOa3UMRolShXgAhgeGHKUBv0DqeEqeXyLhK49
	ftTcPB/m+MTA53cUnfll5uo67TBWBaG+uaon717GqcVULesl9VH7d5BXBPDjne7MgSgFG16VAg4
	1lPsbpDI0X4gNvl8YqGFfeFRaK3lNm2h2vQzffjv8D195EDrArQFXyDerlk=
X-Received: by 2002:a17:907:3da5:b0:ae3:cd73:efde with SMTP id a640c23a62f3a-af8fd9b8cd8mr840014566b.44.1753962176760;
        Thu, 31 Jul 2025 04:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE67P8ng9AVSUESMcuBOxJ0x4LQSgKEPKDtRaQgthvJXLuQrA842cvO1Io0AFJoyaHMXBrfDA==
X-Received: by 2002:a17:907:3da5:b0:ae3:cd73:efde with SMTP id a640c23a62f3a-af8fd9b8cd8mr840012166b.44.1753962176183;
        Thu, 31 Jul 2025 04:42:56 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078a11sm98404766b.7.2025.07.31.04.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:42:55 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:42:54 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org, hch@lst.de, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 20/29] xfs: disable preallocations for fsverity
 Merkle tree writes
Message-ID: <hnpu2acy45q3v3k4sj3p3yazfqfpihh3rnvrdyh6ljgmkod6cz@poli3ifoi6my>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-20-9e5443af0e34@kernel.org>
 <20250729222736.GK2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729222736.GK2672049@frogsfrogsfrogs>

On 2025-07-29 15:27:36, Darrick J. Wong wrote:
> On Mon, Jul 28, 2025 at 10:30:24PM +0200, Andrey Albershteyn wrote:
> > While writing Merkle tree, file is read-only and there's no further
> > writes except Merkle tree building. The file is truncated beforehand to
> > remove any preallocated extents.
> > 
> > The Merkle tree is the only data XFS will write. As we don't want XFS to
> > truncate file after we done writing, let's also skip truncation on
> > fsverity files. Therefore, we also need to disable preallocations while
> > writing merkle tree as we don't want any unused extents past the tree.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/xfs/xfs_iomap.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index ff05e6b1b0bb..00ec1a738b39 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -32,6 +32,8 @@
> >  #include "xfs_rtbitmap.h"
> >  #include "xfs_icache.h"
> >  #include "xfs_zone_alloc.h"
> > +#include "xfs_fsverity.h"
> > +#include <linux/fsverity.h>
> 
> What do these includes pull in for the iflags tests below?

Probably need to be removed, thanks for noting

> 
> >  #define XFS_ALLOC_ALIGN(mp, off) \
> >  	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
> > @@ -1849,7 +1851,9 @@ xfs_buffered_write_iomap_begin(
> >  		 * Determine the initial size of the preallocation.
> >  		 * We clean up any extra preallocation when the file is closed.
> >  		 */
> > -		if (xfs_has_allocsize(mp))
> > +		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> > +			prealloc_blocks = 0;
> > +		else if (xfs_has_allocsize(mp))
> >  			prealloc_blocks = mp->m_allocsize_blocks;
> >  		else if (allocfork == XFS_DATA_FORK)
> >  			prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork,
> > @@ -1976,6 +1980,13 @@ xfs_buffered_write_iomap_end(
> >  	if (flags & IOMAP_FAULT)
> >  		return 0;
> >  
> > +	/*
> > +	 * While writing Merkle tree to disk we would not have any other
> > +	 * delayed allocations
> > +	 */
> > +	if (xfs_iflags_test(XFS_I(inode), XFS_VERITY_CONSTRUCTION))
> > +		return 0;
> 
> I assume XFS_VERITY_CONSTRUCTION doesn't get set until after we've
> locked the inode, flushed the dirty pagecache, and truncated the file to
> EOF?  In which case I guess this is ok -- we're never going to have new
> delalloc reservations,

yes, this is my thinking here

> and verity data can't be straddling the EOF
> folio, no matter how large it is.  Right?

Not sure, what you mean here. In page cache merkle tree is stored
at (1 << 53) offset, and there's check for file overlapping this in
patch 22 xfs_fsverity_begin_enable().

-- 
- Andrey


