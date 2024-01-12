Return-Path: <linux-fsdevel+bounces-7843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE0382B977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 03:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242152865A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 02:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1FD4A28;
	Fri, 12 Jan 2024 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKNsFv9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B9C4A14;
	Fri, 12 Jan 2024 02:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE15C433C7;
	Fri, 12 Jan 2024 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705026171;
	bh=tyTBV9IdekZEBA9xRLni4pD40DGjP3N58wftXn8ECG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKNsFv9kgq5yYP/cIwrMz0dnUCYFA0JwvReXfKnhB6RchpvGmsAMX2ImUNInYSbgy
	 0MlIM5a6ChjbnWvGg/mMwr0MziKA+O4JdGkHyAFKZ6wqINFKUcPz/BfJ3s2YVBCCsl
	 uDY11gr6C0B9G2Pw3NkDcWFKHJJmOnl8QaplWAE4dD+btdy8IedQvLy+g81SjRzopZ
	 tP9ybX81j0pP7w+ZLI8qhv7/NhA9rS/yGXioHOISF+2caZdUoPDJ+RFG3KbrXsGD5z
	 UDXQeHGHZd8y+6eHOCw2cgsZcDpl2uqRxVBJFnqHlNqe6+44bi3i9FKpv2pIo0+eMs
	 xiRW06EpYwf1A==
Date: Thu, 11 Jan 2024 18:22:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Hugh Dickins <hughd@google.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
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
Message-ID: <20240112022250.GU723010@frogsfrogsfrogs>
References: <20240110092109.1950011-1-hch@lst.de>
 <20240110092109.1950011-3-hch@lst.de>
 <20240110175515.GA722950@frogsfrogsfrogs>
 <20240110200451.GB722950@frogsfrogsfrogs>
 <20240111140053.51948fb3ed10e06d8e389d2e@linux-foundation.org>
 <ZaBvoWCCChU5wHDp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaBvoWCCChU5wHDp@casper.infradead.org>

On Thu, Jan 11, 2024 at 10:45:53PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 11, 2024 at 02:00:53PM -0800, Andrew Morton wrote:
> > On Wed, 10 Jan 2024 12:04:51 -0800 "Darrick J. Wong" <djwong@kernel.org> wrote:
> > 
> > > > > Fixing this will require a bit of an API change, and prefeably sorting out
> > > > > the hwpoison story for pages vs folio and where it is placed in the shmem
> > > > > API.  For now use this one liner to disable large folios.
> > > > > 
> > > > > Reported-by: Darrick J. Wong <djwong@kernel.org>
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > 
> > > > Can someone who knows more about shmem.c than I do please review
> > > > https://lore.kernel.org/linux-xfs/20240103084126.513354-4-hch@lst.de/
> > > > so that I can feel slightly more confident as hch and I sort through the
> > > > xfile.c issues?
> > > > 
> > > > For this patch,
> > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > ...except that I'm still getting 2M THPs even with this enabled, so I
> > > guess either we get to fix it now, or create our own private tmpfs mount
> > > so that we can pass in huge=never, similar to what i915 does. :(
> > 
> > What is "this"?  Are you saying that $Subject doesn't work, or that the
> > above-linked please-review patch doesn't work?
> 
> shmem pays no attention to the mapping_large_folio_support() flag,
> so the proposed fix doesn't work.  It ought to, but it has its own way
> of doing it that predates mapping_large_folio_support existing.

Yep.  It turned out to be easier to fix xfile.c to deal with large
folios than I thought it would be.  Or so I think.  We'll see what
happens on fstestscloud overnight.

--D

