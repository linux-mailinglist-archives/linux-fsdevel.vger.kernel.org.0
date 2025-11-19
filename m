Return-Path: <linux-fsdevel+bounces-69052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F91C6CF29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 07:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7651F385E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461B531B808;
	Wed, 19 Nov 2025 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICUwuB8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111131984C;
	Wed, 19 Nov 2025 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533783; cv=none; b=arApvLuiDEZ9aladKWB02P/W+7wHlELCgeqdWH/TFu20lwPSkNhc/hpA1wLtWy95SxVHJY0oLlEnHfTzL2qC5XAGUGfX/dx58mTwnF5NTtqhWVmczf/JhHJff206siyoOFvAwzsQ6mMLJabCuXCusl2r1cjbdYkSMR0dEysZ3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533783; c=relaxed/simple;
	bh=j4jzM65eMJ8upAfaVJtxFTNQTor5sIf6Au4okDTN5Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZDVoP4S1F+7895a5mG8fWpXzOQMBD7yGxptdgvtgPQnz7trrjgi5Pm6gj56vVRS2d0xOrcFTdMZ/3UIaE0MiYOQsN/lRen5e1Km/5j1byTJXKYNXHoZysVkVkMqdAEIOe5LCP26jhpTo8V+l7ZKqJHWuoM9mZtFRmIp9r6eBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICUwuB8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80499C2BCB8;
	Wed, 19 Nov 2025 06:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763533782;
	bh=j4jzM65eMJ8upAfaVJtxFTNQTor5sIf6Au4okDTN5Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICUwuB8eXhY6IyN+rUtf1idZGkjP6gvdnW4JPd1qpyAO4bXwdKdAlmzpB+dC6k+g3
	 nop7z27kCcURFARY1nR5/VBH9UKLGLDz7a0EiM+7L+a1p5gVAWHttRBOi+pCNN44Ce
	 z3zfJgUEyxI5S2MlrMdmPjOHR3e6VsLDQq6mRRJeQOSvzYPXE8rWo0m+2Zik7tcdm8
	 qDW1YnQ4F1E+1ce96CYJ5XMq8eEy+X/0uRp65LurPVFQIV9lFY5d43LxK215yZql/R
	 7XmAi9TqfpIhI2g3SEJgHS2dxrNSi7sl/ln/9aunkp81T9WPhgNqszZzYUGglYwWyH
	 BXidO39mzhX+g==
Date: Tue, 18 Nov 2025 22:29:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org,
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org,
	ast@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <20251119062941.GF196362@frogsfrogsfrogs>
References: <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
 <20251117164155.GB196362@frogsfrogsfrogs>
 <aRtjfN7sC6_Bv4bx@casper.infradead.org>
 <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
 <aRxunCkc4VomEUdo@infradead.org>
 <aRySpQbNuw3Y5DN-@casper.infradead.org>
 <20251118161220.GE196362@frogsfrogsfrogs>
 <CAEf4BzYkPxUcQK2VWEE+8N=U5CXjtUNs6GfbfW2+GoTDebk19A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYkPxUcQK2VWEE+8N=U5CXjtUNs6GfbfW2+GoTDebk19A@mail.gmail.com>

On Tue, Nov 18, 2025 at 11:38:36AM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 18, 2025 at 8:12 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, Nov 18, 2025 at 03:37:09PM +0000, Matthew Wilcox wrote:
> > > On Tue, Nov 18, 2025 at 05:03:24AM -0800, Christoph Hellwig wrote:
> > > > On Mon, Nov 17, 2025 at 10:45:31AM -0800, Andrii Nakryiko wrote:
> > > > > As I replied on another email, ideally we'd have some low-level file
> > > > > reading interface where we wouldn't have to know about secretmem, or
> > > > > XFS+DAX, or whatever other unusual combination of conditions where
> > > > > exposed internal APIs like filemap_get_folio() + read_cache_folio()
> > > > > can crash.
> > > >
> > > > The problem is that you did something totally insane and it kinda works
> > > > most of the time.
> > >
> > > ... on 64-bit systems.  The HIGHMEM handling is screwed up too.
> > >
> > > > But bpf or any other file system consumer has
> > > > absolutely not business poking into the page cache to start with.
> > >
> > > Agreed.
> > >
> > > > And I'm really pissed off that you wrote and merged this code without
> > > > ever bothering to talk to a FS or MM person who have immediately told
> > > > you so.  Let's just rip out this buildid junk for now and restart
> > > > because the problem isn't actually that easy.
> > >
> > > Oh, they did talk to fs & mm people originally and were told NO, so they
> > > sneaked it in through the BPF tree.
> > >
> > > https://lore.kernel.org/all/20230316170149.4106586-1-jolsa@kernel.org/
> > >
> > > > > The only real limitation is that we'd like to be able to control
> > > > > whether we are ok sleeping or not, as this code can be called from
> > > > > pretty much anywhere BPF might run, which includes NMI context.
> > > > >
> > > > > Would this kiocb_read() approach work under those circumstances?
> > > >
> > > > No.  IOCB_NOWAIT is just a hint to avoid blocking function calls.
> > > > It is not guarantee and a guarantee is basically impossible.
> > >
> > > I'm not sure I'd go that far -- I think we're pretty good about not
> > > sleeping when IOCB_NOWAIT is specified and any remaining places can
> > > be fixed up.
> > >
> > > But I am inclined to rip out the buildid code, just because the
> > > authors have been so rude.
> >
> > Which fstest actually checks the functionality of the buildid code?
> > I don't find any, which means none of the fs people have a good signal
> > for breakage in this, um, novel file I/O path.
> 
> We have plenty of build ID tests in BPF selftest that validate this
> functionality:
> 
>   - tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
>   - tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>   - tools/testing/selftests/bpf/prog_tests/build_id.c
> 
> This functionality is exposed to BPF (and PROCMAP_QUERY, which has its
> own mm selftests), so that's where we test this. So we'll know at the
> very least when trees merge that something is broken.

Only if you're testing the buildid functionality with all known file I/O
paths implemented by all filesystems.  Or you could add a new testcase
to fstests and we'd do all that *for* you.

--D

> >
> > --D
> 

