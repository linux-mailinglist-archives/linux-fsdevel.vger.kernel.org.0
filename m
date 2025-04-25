Return-Path: <linux-fsdevel+bounces-47399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8A3A9CF4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 19:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D9A9E804E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9AB1E00A0;
	Fri, 25 Apr 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meH8PVrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022181A5BA0;
	Fri, 25 Apr 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601138; cv=none; b=rN+eSwwNS4xNanNRC2lHFIW8XMnSsrqJtjXH59n0etttvKeD44WXSE42daowEaH6Rc6tkEsgdtPRtQkNNVXgxP/vmRF09GqQEZxmMEmyaUT6UbD2dMNbetNYk9GCDBQu4fLvn4Lutzd9w9OKIy02C8D7M+25BfcWCA1BMgI8FiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601138; c=relaxed/simple;
	bh=3U78nk8+OCaeXgDy4P6JXWxliABBj1zQnA3H/RaZDHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8UFL9EkNTF4ffmc3o1jCrUv56tUov+jtGw1ylLE8xtDtroorgWbbmeuGrkJovGownoyb0vN8l+JbpjBELzax24SrVeUfou81C6On0mt/7jowTjI7vHc/ztN2sIRS8WukO2e/ygYcQ7RnY0Pkn6SVkyUqQLuw51YqBQb2i0AX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meH8PVrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE266C4CEE4;
	Fri, 25 Apr 2025 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745601137;
	bh=3U78nk8+OCaeXgDy4P6JXWxliABBj1zQnA3H/RaZDHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meH8PVrvMt3xXKv0+RutK/uTNkhuORnaRPsqFBrurq9b2X7jON8JVhUqynwBfTAb5
	 BUfHGI11ypsuqUdKEKoq0y0oiRNFZBXK6U9Ba8RopuRE6hco2lCUOge7XxWBiAJW3h
	 Hxo6gpBSBm0tI00doKzBV66QdrnRME3QE+bbhB4F6iytJdf3MSRPRI2/HUrWaBRA1m
	 JCcgQY0qdX1r6/M4p1NyvzLlFg/s+oS9oM4vWfEftg51+HfFIBV8P4ccO7Kvf1izPi
	 DCKR6urteIZU/xLjvpfkl9nXB1B1jmkZ0a86G1z9vsytA/JyT4qbjwoZ8qW1dy6yKY
	 ozJXJgq8V19eQ==
Date: Fri, 25 Apr 2025 10:12:14 -0700
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <202504251010.C5CCE66@keescook>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <51903B43-2BFC-4BA6-9D74-63F79CF890B7@kernel.org>
 <7212f5f4-f12b-4b94-834f-b392601360a3@lucifer.local>
 <n6lrbjs4o6luzl3fydpo4frj35q6kvoz74mhlyae5gp7t5loyy@ubmfmzwfhnwq>
 <CAJuCfpErtLvktCsbFSGmrT_zir9z0g+uuVvhr=QEitA7ARkdkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpErtLvktCsbFSGmrT_zir9z0g+uuVvhr=QEitA7ARkdkw@mail.gmail.com>

On Fri, Apr 25, 2025 at 08:32:48AM -0700, Suren Baghdasaryan wrote:
> On Fri, Apr 25, 2025 at 6:55 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250425 06:40]:
> > > On Thu, Apr 24, 2025 at 08:15:26PM -0700, Kees Cook wrote:
> > > >
> > > >
> > > > On April 24, 2025 2:15:27 PM PDT, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > > >+static void vm_area_init_from(const struct vm_area_struct *src,
> > > > >+                        struct vm_area_struct *dest)
> > > > >+{
> > > > >+  dest->vm_mm = src->vm_mm;
> > > > >+  dest->vm_ops = src->vm_ops;
> > > > >+  dest->vm_start = src->vm_start;
> > > > >+  dest->vm_end = src->vm_end;
> > > > >+  dest->anon_vma = src->anon_vma;
> > > > >+  dest->vm_pgoff = src->vm_pgoff;
> > > > >+  dest->vm_file = src->vm_file;
> > > > >+  dest->vm_private_data = src->vm_private_data;
> > > > >+  vm_flags_init(dest, src->vm_flags);
> > > > >+  memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> > > > >+         sizeof(dest->vm_page_prot));
> > > > >+  /*
> > > > >+   * src->shared.rb may be modified concurrently when called from
> > > > >+   * dup_mmap(), but the clone will reinitialize it.
> > > > >+   */
> > > > >+  data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
> > > > >+  memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> > > > >+         sizeof(dest->vm_userfaultfd_ctx));
> > > > >+#ifdef CONFIG_ANON_VMA_NAME
> > > > >+  dest->anon_name = src->anon_name;
> > > > >+#endif
> > > > >+#ifdef CONFIG_SWAP
> > > > >+  memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> > > > >+         sizeof(dest->swap_readahead_info));
> > > > >+#endif
> > > > >+#ifdef CONFIG_NUMA
> > > > >+  dest->vm_policy = src->vm_policy;
> > > > >+#endif
> > > > >+}
> > > >
> > > > I know you're doing a big cut/paste here, but why in the world is this function written this way? Why not just:
> > > >
> > > > *dest = *src;
> > > >
> > > > And then do any one-off cleanups?
> > >
> > > Yup I find it odd, and error prone to be honest. We'll end up with uninitialised
> > > state for some fields if we miss them here, seems unwise...
> > >
> > > Presumably for performance?
> > >
> > > This is, as you say, me simply propagating what exists, but I do wonder.
> >
> > Two things come to mind:
> >
> > 1. How ctors are done.  (v3 of Suren's RCU safe patch series, willy made
> > a comment.. I think)
> >
> > 2. Some race that Vlastimil came up with the copy and the RCU safeness.
> > IIRC it had to do with the ordering of the setting of things?
> >
> > Also, looking at it again...
> >
> > How is it safe to do dest->anon_name = src->anon_name?  Isn't that ref
> > counted?
> 
> dest->anon_name = src->anon_name is fine here because right after
> vm_area_init_from() we call dup_anon_vma_name() which will bump up the
> refcount. I don't recall why this is done this way but now looking at
> it I wonder if I could call dup_anon_vma_name() directly instead of
> this assignment. Might be just an overlooked legacy from the time we
> memcpy'd the entire structure. I'll need to double-check.

Oh, is "dest" accessible to other CPU threads? I hadn't looked and was
assuming this was like process creation where everything gets built in
isolation and then attached to the main process tree. I was thinking
this was similar.

-- 
Kees Cook

