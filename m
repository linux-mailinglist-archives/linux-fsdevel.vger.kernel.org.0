Return-Path: <linux-fsdevel+bounces-7821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A182B73B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 23:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAF8B2440A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B930FC17;
	Thu, 11 Jan 2024 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EomzbTzJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22BBFBF3;
	Thu, 11 Jan 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0rn15vikwOjPu92WIZ1pOLLnXWU6x//npevyjHw8yaU=; b=EomzbTzJzQx9U5EbbMaV2qfdKn
	m+8Aks0QGEeOKbhHlYUfGI0ESzbPCwu4+T1iJwpAMaa+P+8S7WdUdv0uh9VymFzvAlHqWZdS+1v42
	VYO+5aZ+YLqzQ9VrPT3bL2J2+Jh26pmRT3GsCtQ+FuTAp5ogzJOhfRTDdZd5nGFmbyHf4Nic43+/j
	wDbX0twq5Rj7iSd2OySjSEWRPCXpPbuXe/3Q1RVKFIc6G732IcUWMPMXjEy7Po9B7TOpSfuH09+Si
	ksPBNd2g30LsyFYsilKTNDIkvoFAxmh97MurNp5o/ueUNwULbN3H1vFGwAFhHlhdxkhCRy3J2stsU
	Y5bchWlg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rO3o9-00FAPE-3J; Thu, 11 Jan 2024 22:45:53 +0000
Date: Thu, 11 Jan 2024 22:45:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <ZaBvoWCCChU5wHDp@casper.infradead.org>
References: <20240110092109.1950011-1-hch@lst.de>
 <20240110092109.1950011-3-hch@lst.de>
 <20240110175515.GA722950@frogsfrogsfrogs>
 <20240110200451.GB722950@frogsfrogsfrogs>
 <20240111140053.51948fb3ed10e06d8e389d2e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111140053.51948fb3ed10e06d8e389d2e@linux-foundation.org>

On Thu, Jan 11, 2024 at 02:00:53PM -0800, Andrew Morton wrote:
> On Wed, 10 Jan 2024 12:04:51 -0800 "Darrick J. Wong" <djwong@kernel.org> wrote:
> 
> > > > Fixing this will require a bit of an API change, and prefeably sorting out
> > > > the hwpoison story for pages vs folio and where it is placed in the shmem
> > > > API.  For now use this one liner to disable large folios.
> > > > 
> > > > Reported-by: Darrick J. Wong <djwong@kernel.org>
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > Can someone who knows more about shmem.c than I do please review
> > > https://lore.kernel.org/linux-xfs/20240103084126.513354-4-hch@lst.de/
> > > so that I can feel slightly more confident as hch and I sort through the
> > > xfile.c issues?
> > > 
> > > For this patch,
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > ...except that I'm still getting 2M THPs even with this enabled, so I
> > guess either we get to fix it now, or create our own private tmpfs mount
> > so that we can pass in huge=never, similar to what i915 does. :(
> 
> What is "this"?  Are you saying that $Subject doesn't work, or that the
> above-linked please-review patch doesn't work?

shmem pays no attention to the mapping_large_folio_support() flag,
so the proposed fix doesn't work.  It ought to, but it has its own way
of doing it that predates mapping_large_folio_support existing.

