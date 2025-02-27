Return-Path: <linux-fsdevel+bounces-42791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79264A48B26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 23:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE383B6FC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6E2271827;
	Thu, 27 Feb 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lJ7b1qSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D951E51E0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694390; cv=none; b=UMSqGhi6FGgA9W9Mwxux90HwaeNbQ6XJzz2c9uCqmilLrTirLwlBmknzky/wEdFFSLl5gbut5dEUbAhodan0bbXpmazzl0lq8ggOPeKe5x92voU4YFsQdAXdL0XT71jNqtvtdxvFov+PdFcqVim6xrdG6MKFeXvsPanT7nZrJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694390; c=relaxed/simple;
	bh=5UvuhxZ0KkH9bLFtzdL5uKUf/WhVtuA2yhkgzU4wNSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFfAZDxkSgEhXaNjIy+2kvFh2TfkDrq37QDMasTP9xatyjLJogAq/lRLP4wYR0bzoy37loDefNQoTOh9v615HswthEfyASNQdg9DoVjYMzgWQkvjPWJXgZIfEaCCEM0JTQuzd9wcYOL8ePEc5QX3Id5py7UwvlxtmUNpz5W4Om0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lJ7b1qSI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IjcRWZ8Lvb7WvhvvISj1HcODhsYVUVcOolxyu3/O/yE=; b=lJ7b1qSIXp1DVOSBXCe0B3oUyY
	Gmo5TZ8v186AroD4PLQoD+OS0mnPGDN7aIOL7KPrSF7UmrdnvLnB0SBzF7m7EIU9sAydMTeGXSo8p
	0x5bc73K4lznrghzD32VpU6XmhFZ6zJGA6dP6yt5CcALUbq9ziDb64d4ZKriTnNL/yESl2nFydzx3
	90tSi5/0M8u4Z10QHpKVRZ9gmN1YtbobPYgr2rDPKYKY79Px3qqCd2stFPhU8kLhwpuLPkzgI4idx
	9NTv+NPGSOUKN3L9d0zm/4pcJXqbkfncO1CIN47TZiTRc2E6076AAriMfLmKAK+hYOWMPLRx2Vw2r
	pXTXxdvw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnm7f-00000000hhB-0KpP;
	Thu, 27 Feb 2025 22:12:51 +0000
Date: Thu, 27 Feb 2025 22:12:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Kalesh Singh <kaleshsingh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Juan Yescas <jyescas@google.com>,
	android-mm <android-mm@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	"Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
Message-ID: <Z8DjYmYPRDArpsqx@casper.infradead.org>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
 <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local>
 <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
 <Z70HJWliB4wXE-DD@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z70HJWliB4wXE-DD@dread.disaster.area>

On Tue, Feb 25, 2025 at 10:56:21AM +1100, Dave Chinner wrote:
> > From the previous discussions that Matthew shared [7], it seems like
> > Dave proposed an alternative to moving the extents to the VFS layer to
> > invert the IO read path operations [8]. Maybe this is a move
> > approachable solution since there is precedence for the same in the
> > write path?
> > 
> > [7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infradead.org/
> > [8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disaster.area/
> 
> Yes, if we are going to optimise away redundant zeros being stored
> in the page cache over holes, we need to know where the holes in the
> file are before the page cache is populated.

Well, you shot that down when I started trying to flesh it out:
https://lore.kernel.org/linux-fsdevel/Zs+2u3%2FUsoaUHuid@dread.disaster.area/

> As for efficient hole tracking in the mapping tree, I suspect that
> we should be looking at using exceptional entries in the mapping
> tree for holes, not inserting mulitple references to the zero folio.
> i.e. the important information for data storage optimisation is that
> the region covers a hole, not that it contains zeros.

The xarray is very much optimised for storing power-of-two sized &
aligned objects.  It makes no sense to try to track extents using the
mapping tree.  Now, if we abandon the radix tree for the maple tree, we
could talk about storing zero extents in the same data structure.
But that's a big change with potentially significant downsides.
It's something I want to play with, but I'm a little busy right now.

> For buffered reads, all that is required when such an exceptional
> entry is returned is a memset of the user buffer. For buffered
> writes, we simply treat it like a normal folio allocating write and
> replace the exceptional entry with the allocated (and zeroed) folio.

... and unmap the zero page from any mappings.

> For read page faults, the zero page gets mapped (and maybe
> accounted) via the vma rather than the mapping tree entry. For write
> faults, a folio gets allocated and the exception entry replaced
> before we call into ->page_mkwrite().
> 
> Invalidation simply removes the exceptional entries.

... and unmap the zero page from any mappings.


