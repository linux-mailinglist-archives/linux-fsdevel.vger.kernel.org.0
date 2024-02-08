Return-Path: <linux-fsdevel+bounces-10783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA084E4A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5601F25161
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ACC7D40A;
	Thu,  8 Feb 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXka1czU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14947C0A9;
	Thu,  8 Feb 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408216; cv=none; b=IUK5sWTqbYzb2oyiIOu31yMH/2Own0C269HZH6Xyph0sbc8DJWUlDORGR92h8DQwv55oz/yDDSjwbHTUhimZCm03qvdhBitxyU3kOlM3CAUPXtFNxMDcB97o1sZ5FnpVqAxZahMgQPuvD1G1Kyn1OC4Vb/uCLELowH/zJpoARig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408216; c=relaxed/simple;
	bh=Igdsqh4bs6NiYnvDyhbANp18ct18WHK41QmYJ0p6Duk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze6yUNbD3LwTnrK9YspmLp0C+zrRI1aXYvk8pfyGRLyzRtRX4cHo3j1KA7GhdHMKiodAjTagMjI25ZbcY3qBFqFu+5/BbhbjxsEnxn+v3BVpFdAhODIIP/RCnI4kveWR/+X+ZUxaQ3I63k/fSGs1i0Rxgr/xgxakQYb1bC+0VL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXka1czU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82305C433C7;
	Thu,  8 Feb 2024 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707408216;
	bh=Igdsqh4bs6NiYnvDyhbANp18ct18WHK41QmYJ0p6Duk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXka1czU0HxJAe9/Z7tqp2IwCy9Q7ND1ud7yKWgr0aPaEVbYVwqMOntZqEIM7tDup
	 fyZ/7DXkg7PF38L7oykrP7viPizC7oA/enqhJFWWvgGBGU7osfq8yChKKHb+9vVdwO
	 elNtxaGsUW1a9WOhIyyvO4IMI+3unJKVWXzamEiVLdFxl3TgXEkfdVfgEC6XFo2r7o
	 /Q9X/yELfNXpTjnehQAQOAIH3aiUBAkAAavp404eHDHl5D5E47vxGbgAJYonZmal0W
	 e9Dm1oRowc9Ml0tArZvIPSo8GFRBsC+d1PMwvQis4p2xEKNRIV9M7qI6OXS9on4RmR
	 jdnJQ2p9qRXJA==
Date: Thu, 8 Feb 2024 08:03:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
	Hugh Dickins <hughd@google.com>,
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
Message-ID: <20240208160335.GN6184@frogsfrogsfrogs>
References: <20240110092109.1950011-1-hch@lst.de>
 <20240110092109.1950011-3-hch@lst.de>
 <20240110175515.GA722950@frogsfrogsfrogs>
 <20240110200451.GB722950@frogsfrogsfrogs>
 <20240111140053.51948fb3ed10e06d8e389d2e@linux-foundation.org>
 <ZaBvoWCCChU5wHDp@casper.infradead.org>
 <20240112022250.GU723010@frogsfrogsfrogs>
 <20240207175621.dd773204e7928dbeee7a92bf@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207175621.dd773204e7928dbeee7a92bf@linux-foundation.org>

On Wed, Feb 07, 2024 at 05:56:21PM -0800, Andrew Morton wrote:
> On Thu, 11 Jan 2024 18:22:50 -0800 "Darrick J. Wong" <djwong@kernel.org> wrote:
> 
> > On Thu, Jan 11, 2024 at 10:45:53PM +0000, Matthew Wilcox wrote:
> > > On Thu, Jan 11, 2024 at 02:00:53PM -0800, Andrew Morton wrote:
> > > > On Wed, 10 Jan 2024 12:04:51 -0800 "Darrick J. Wong" <djwong@kernel.org> wrote:
> > > > 
> > > > > > > Fixing this will require a bit of an API change, and prefeably sorting out
> > > > > > > the hwpoison story for pages vs folio and where it is placed in the shmem
> > > > > > > API.  For now use this one liner to disable large folios.
> > > > > > > 
> > > > > > > Reported-by: Darrick J. Wong <djwong@kernel.org>
> > > > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > > 
> > > > > > Can someone who knows more about shmem.c than I do please review
> > > > > > https://lore.kernel.org/linux-xfs/20240103084126.513354-4-hch@lst.de/
> > > > > > so that I can feel slightly more confident as hch and I sort through the
> > > > > > xfile.c issues?
> > > > > > 
> > > > > > For this patch,
> > > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > 
> > > > > ...except that I'm still getting 2M THPs even with this enabled, so I
> > > > > guess either we get to fix it now, or create our own private tmpfs mount
> > > > > so that we can pass in huge=never, similar to what i915 does. :(
> > > > 
> > > > What is "this"?  Are you saying that $Subject doesn't work, or that the
> > > > above-linked please-review patch doesn't work?
> > > 
> > > shmem pays no attention to the mapping_large_folio_support() flag,
> > > so the proposed fix doesn't work.  It ought to, but it has its own way
> > > of doing it that predates mapping_large_folio_support existing.
> > 
> > Yep.  It turned out to be easier to fix xfile.c to deal with large
> > folios than I thought it would be.  Or so I think.  We'll see what
> > happens on fstestscloud overnight.
> 
> Where do we stand with this?  Should I merge these two patches into
> 6.8-rcX, cc:stable?

This patchset doesn't actually fix the problem, so no, let's not merge
it.

For 6.9 we'll make xfile.c clean w.r.t. large folios:
https://lore.kernel.org/linux-xfs/20240129143502.189370-1-hch@lst.de/

I don't think we need a 6.8 backport since xfile.c is only used by an
experimental feature that is default n in kconfig.

--D

