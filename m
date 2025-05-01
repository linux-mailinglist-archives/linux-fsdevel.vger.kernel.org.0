Return-Path: <linux-fsdevel+bounces-47824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEAAA5E40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 14:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E2B4C3286
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446D122577E;
	Thu,  1 May 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM259zVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E61EB189;
	Thu,  1 May 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746101838; cv=none; b=P9Hzwfxow5BTFYtkY6O5d/aAIA6/iwsHW4wFx6HQJKxXLW+FRoso6Zy9XbNnk2RZwv87NOzOAsWe+s8JHl+IKstg3qt4KWRB6uGhmF/EMMyHiP24PbX2xThkrjI4HwySB9ViYWh0ab0IfbvDhszeWqHqaJKVDXyXuVLKzmbWXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746101838; c=relaxed/simple;
	bh=a7VyWzbLsXgj9plmo5+OkoEU6S32yqKBmnsZ5ada3EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoEyf91fajG6p0SxN5ehhIc4o92WXwFWPhpFPHK9n8U951Ug1+dfKOi49kDZ1oOTyGrVUH0CAqEH92aSAvBAnJONUB2NI/vw2tWYsttxhjFsPbkFWQabxVlMjqJWvjm2NCKAitbHODYDeaH4PvuoaTmOFxLHIvWRRa/72kkmVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM259zVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05545C4CEE3;
	Thu,  1 May 2025 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746101836;
	bh=a7VyWzbLsXgj9plmo5+OkoEU6S32yqKBmnsZ5ada3EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CM259zVuI12c6B8yJGt4xuuGFcwl7G3oFP2FnevTmzXZE1hgPB3RimiTtjCaRNvgV
	 WMSBQuB365NPgNaQE9ZjZs97E0QlPE96jb486tK2LX3jixJvNPkI4KauF6YytT/BNy
	 hVFbfifO1VKeCrKzJp7R1fx3BvwtAzRKMHtG5s0SuIa87xufoQgXErQdzmDtjDM/We
	 NXWlWzCP6VO83HZbjWjwvtmWtiM1QHaFeqEMLY4U6uKvn+Kl+nnEmaVeRgxtSQ/S2Q
	 zaqF4RRkeyOaysQDk4KNdDogoQmTAEtihGYHmGjedJ8GORArrbBfGTl6HDJbO/IR+F
	 jmL32GVyCxwUA==
Date: Thu, 1 May 2025 15:17:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Message-ID: <aBNmQ2YVS-3Axxyh@kernel.org>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
 <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
 <982acf21-6551-472d-8f4d-4b273b4c2485@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982acf21-6551-472d-8f4d-4b273b4c2485@lucifer.local>

On Thu, May 01, 2025 at 11:23:32AM +0100, Lorenzo Stoakes wrote:
> On Wed, Apr 30, 2025 at 11:58:14PM +0200, David Hildenbrand wrote:
> > On 30.04.25 21:54, Lorenzo Stoakes wrote:
> > > Provide a means by which drivers can specify which fields of those
> > > permitted to be changed should be altered to prior to mmap()'ing a
> > > range (which may either result from a merge or from mapping an entirely new
> > > VMA).
> > >
> > > Doing so is substantially safer than the existing .mmap() calback which
> > > provides unrestricted access to the part-constructed VMA and permits
> > > drivers and file systems to do 'creative' things which makes it hard to
> > > reason about the state of the VMA after the function returns.
> > >
> > > The existing .mmap() callback's freedom has caused a great deal of issues,
> > > especially in error handling, as unwinding the mmap() state has proven to
> > > be non-trivial and caused significant issues in the past, for instance
> > > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > > error path behaviour").
> > >
> > > It also necessitates a second attempt at merge once the .mmap() callback
> > > has completed, which has caused issues in the past, is awkward, adds
> > > overhead and is difficult to reason about.
> > >
> > > The .mmap_proto() callback eliminates this requirement, as we can update
> > > fields prior to even attempting the first merge. It is safer, as we heavily
> > > restrict what can actually be modified, and being invoked very early in the
> > > mmap() process, error handling can be performed safely with very little
> > > unwinding of state required.
> > >
> > > Update vma userland test stubs to account for changes.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> >
> > I really don't like the "proto" terminology. :)
> >
> > [yes, David and his naming :P ]
> >
> > No, the problem is that it is fairly unintuitive what is happening here.
> >
> > Coming from a different direction, the callback is trigger after
> > __mmap_prepare() ... could we call it "->mmap_prepare" or something like
> > that? (mmap_setup, whatever)
> >
> > Maybe mmap_setup and vma_setup_param? Just a thought ...
> 
> Haha that's fine, I'm not sure I love 'proto' either to be honest, naming is
> hard...
> 
> I would rather not refer to VMA's at all to be honest, if I had my way, no
> driver would ever have access to a VMA at all...
> 
> But mmap_setup() or mmap_prepare() sound good!

+1

and struct vm_area_desc maybe? 

> >
> >
> > In general (although it's late in Germany), it does sound like an
> > interesting approach.
> 
> Thanks! Appreciate it :) I really want to attack this, as I _hate_ how we
> effectively allow drivers to do _anything_ with VMAs like this.
> 
> Yes, hate-driven development...

Just move vm_area_struct to mm/internal.h and let them cope :-D

-- 
Sincerely yours,
Mike.

