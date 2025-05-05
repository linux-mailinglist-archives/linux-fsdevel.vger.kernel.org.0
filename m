Return-Path: <linux-fsdevel+bounces-48080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B851AA9488
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E02189B687
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E425A2A3;
	Mon,  5 May 2025 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnKa1edm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EE258CF5;
	Mon,  5 May 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451755; cv=none; b=d8R6ZM29+a5H2yPcjFT+uyj+x8hCoXMAng0s1fKtE4+C2zW99h1bRDDPxDQI2x/28bXn2YRsdfjXVe6MlUMHwvBlCrdPELDSs+HpPVXOKmQcWxuIge90lQwhZuYpjeu9XS36IeAPkvDjs4QGPHTx0dGsC/MOnvAc5dBigx9+LLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451755; c=relaxed/simple;
	bh=B3/FRvlQ4Ek+yQv/ze582YtVqXmXHDnQWRaAtVxCn8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1KvMgs1ij07XKckVU3obSQzBLGMst7bTZjsehAxmhiocjmFPW8oNLCuPIfj96nBEfNGXhK1k7kkhZSnw5WyaLa+ibdahQUzie6phFHzBCjIrYKsB073Ybo2rTF6t38wAKu1nJi+ZovyXZDHbnRargj4kIhA07i/YP6FcFaNMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnKa1edm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE50C4CEE4;
	Mon,  5 May 2025 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746451754;
	bh=B3/FRvlQ4Ek+yQv/ze582YtVqXmXHDnQWRaAtVxCn8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnKa1edmjn1Cn2AsWiz8IKivzXXO6qPQ9v4dBHB4S+nNyFlvbRWKTlsZsWX/Lsqgg
	 f+omQXZhpmhCWtT6p/zJ7aRS6x/7n+vFZ3whQ+v/cfyoSDzKE11JUbZrfYy1yq+tg9
	 k1e6IRASfwrs8zrH6nxfF4CHhFRMNMHcQV44wdluXOQzQ/gH5+//YYDJRWpM537/ue
	 eI99p/dOow/mLjMPwkXd3CL7YmzM7mxCxTG4mhew3qQTiz9ZPAvVxottlMAmp849gK
	 UT/msChtLHn0vDX+PMq9dCaO5/1K/4hKYohCzsy6emg0XBjJCIp02mtYj3bidDjKQl
	 S6oC6fA7PxJeA==
Date: Mon, 5 May 2025 15:29:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Message-ID: <20250505-woanders-verifizieren-8ce186d13a6f@brauner>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
 <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>

On Wed, Apr 30, 2025 at 11:58:14PM +0200, David Hildenbrand wrote:
> On 30.04.25 21:54, Lorenzo Stoakes wrote:
> > Provide a means by which drivers can specify which fields of those
> > permitted to be changed should be altered to prior to mmap()'ing a
> > range (which may either result from a merge or from mapping an entirely new
> > VMA).
> > 
> > Doing so is substantially safer than the existing .mmap() calback which
> > provides unrestricted access to the part-constructed VMA and permits
> > drivers and file systems to do 'creative' things which makes it hard to
> > reason about the state of the VMA after the function returns.
> > 
> > The existing .mmap() callback's freedom has caused a great deal of issues,
> > especially in error handling, as unwinding the mmap() state has proven to
> > be non-trivial and caused significant issues in the past, for instance
> > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > error path behaviour").
> > 
> > It also necessitates a second attempt at merge once the .mmap() callback
> > has completed, which has caused issues in the past, is awkward, adds
> > overhead and is difficult to reason about.
> > 
> > The .mmap_proto() callback eliminates this requirement, as we can update
> > fields prior to even attempting the first merge. It is safer, as we heavily
> > restrict what can actually be modified, and being invoked very early in the
> > mmap() process, error handling can be performed safely with very little
> > unwinding of state required.
> > 
> > Update vma userland test stubs to account for changes.
> > 
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> 
> I really don't like the "proto" terminology. :)
> 
> [yes, David and his naming :P ]
> 
> No, the problem is that it is fairly unintuitive what is happening here.
> 
> Coming from a different direction, the callback is trigger after
> __mmap_prepare() ... could we call it "->mmap_prepare" or something like
> that? (mmap_setup, whatever)
> 
> Maybe mmap_setup and vma_setup_param? Just a thought ...
> 
> 
> In general (although it's late in Germany), it does sound like an
> interesting approach.
> 
> How feasiable is it to remove ->mmap in the long run, and would we maybe
> need other callbacks to make that possible?

If mm needs new file operations that aim to replace the old ->mmap() I
want the old method to be ripped out within a reasonable time frame. I
don't want to have ->mmap() and ->mmap_$new() hanging around for the
next 5 years. We have enough of that already. And it would be great to
be clear whether that replacement can actually happen.

