Return-Path: <linux-fsdevel+bounces-7747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24982A1AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 21:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E756B23AC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBC14E1DE;
	Wed, 10 Jan 2024 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVS4MaRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15754CB44;
	Wed, 10 Jan 2024 20:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5DEC433F1;
	Wed, 10 Jan 2024 20:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704917092;
	bh=74bvc1MrtZiDKmQ/bu3C4RVeT5D3DZCGTl3NffxKvZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVS4MaRMctsxFwGuMyM23YFJV6gby6teko8iKECcrhunk0OEiqeoTkDr1l/TiVGJo
	 D3PqK71jNSb9LbpdngAb4xBI+6SuDkZvu8aVnJYNxh/OMisBhHqJ1KhotiNpAmbU80
	 wgGpQlW/jizt5hj1i4Su4y/pEDtNZeoWx582CriSM2ffbCyVxzXepeD/lZhUpUFhEL
	 3pZ64QIq99+20Ie61mUYNRaPAw8gMJJKci/GPwmdlok9izzYq7VX5rwp35NC0GRRW9
	 PaQ/HQP+gcVFQn1ip2QVte75pNWIrnqTRTsBfuM9W4XhUOM/TRqAV2Ms7tnOQHiw6E
	 Dr+uuHbo0VtIA==
Date: Wed, 10 Jan 2024 12:04:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	x86@kernel.org, linux-sgx@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: disable large folio support in xfile_create
Message-ID: <20240110200451.GB722950@frogsfrogsfrogs>
References: <20240110092109.1950011-1-hch@lst.de>
 <20240110092109.1950011-3-hch@lst.de>
 <20240110175515.GA722950@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110175515.GA722950@frogsfrogsfrogs>

On Wed, Jan 10, 2024 at 09:55:15AM -0800, Darrick J. Wong wrote:
> On Wed, Jan 10, 2024 at 10:21:09AM +0100, Christoph Hellwig wrote:
> > The xfarray code will crash if large folios are force enabled using:
> > 
> >    echo force > /sys/kernel/mm/transparent_hugepage/shmem_enabled
> > 
> > Fixing this will require a bit of an API change, and prefeably sorting out
> > the hwpoison story for pages vs folio and where it is placed in the shmem
> > API.  For now use this one liner to disable large folios.
> > 
> > Reported-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Can someone who knows more about shmem.c than I do please review
> https://lore.kernel.org/linux-xfs/20240103084126.513354-4-hch@lst.de/
> so that I can feel slightly more confident as hch and I sort through the
> xfile.c issues?
> 
> For this patch,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

...except that I'm still getting 2M THPs even with this enabled, so I
guess either we get to fix it now, or create our own private tmpfs mount
so that we can pass in huge=never, similar to what i915 does. :(

--D

> --D
> 
> > ---
> >  fs/xfs/scrub/xfile.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
> > index 090c3ead43fdf1..1a8d1bedd0b0dc 100644
> > --- a/fs/xfs/scrub/xfile.c
> > +++ b/fs/xfs/scrub/xfile.c
> > @@ -94,6 +94,11 @@ xfile_create(
> >  
> >  	lockdep_set_class(&inode->i_rwsem, &xfile_i_mutex_key);
> >  
> > +	/*
> > +	 * We're not quite ready for large folios yet.
> > +	 */
> > +	mapping_clear_large_folios(inode->i_mapping);
> > +
> >  	trace_xfile_create(xf);
> >  
> >  	*xfilep = xf;
> > -- 
> > 2.39.2
> > 
> > 
> 

