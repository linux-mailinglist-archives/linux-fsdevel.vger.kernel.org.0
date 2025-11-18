Return-Path: <linux-fsdevel+bounces-68982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0EEC6A889
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3F24E2C8F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5239A36B05A;
	Tue, 18 Nov 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzWrwAHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815C30E84D;
	Tue, 18 Nov 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482343; cv=none; b=ClY4OCILue9jGi/jLoMTea31iEEkjinWbtSd/bxZk1rxu4TY7/Ng6ejvox3g+ptPratwWIafKYmWAc9oKKaNqqp8QB/3/A4ttUOsaMhoL2OpMhkSzdKuS3d67GNNOd8i+pfPYod/mroux7eYGDE3nP5j5R6ZjKoNPIRGkD9zJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482343; c=relaxed/simple;
	bh=ZP5K4o/QCarBYT0cdcf/UtWV0Qrt3XMjzieN6I85paY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYhqqiwXBBItK+9SgU0VL+ROM6BP+ii4UjLmWwOKU2za5RCt9bvJqOVuMl7ppYJojsBvapwNdcg1dc0foFiY/kE6l0bT/sI4DZRl7RBolTNl/fdhuLxIqqPHe/IeteuKXqxNEqqBk1ZgMYl1Dvgb/rrWt7XM0WO8VcDJ5m8pNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzWrwAHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B969C19423;
	Tue, 18 Nov 2025 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763482342;
	bh=ZP5K4o/QCarBYT0cdcf/UtWV0Qrt3XMjzieN6I85paY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzWrwAHz6PlrkLBt6xTex441mtplP/B1zXXOCxql4XgVwKlmlxscpS6VEFJXtZLDW
	 n5RqZyKy2RAVlvkr1hTQLMH2vuBy3+2viD00B6NVy/DyOLZ5btxAd0VjFfdZfB04X3
	 FFx2/sYXRruhb3SawrX4VXfJorB4MwUBcwYuTrpnnzYvz5nUjLr9dnedTui1e1P0o9
	 OFOexYhysPY7FJKEI7dKUpjj6VeeC8AqVZRHljg6HYVTkUeGdnIa5PJV4m15bd7el7
	 9bavzNe4widEMWjmwwBYWel2t+VdQMLzF81jn3RxPNYb36X9WIa6kxexaU01dYfY0O
	 68u1oGca1gwRQ==
Date: Tue, 18 Nov 2025 08:12:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
Message-ID: <20251118161220.GE196362@frogsfrogsfrogs>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
 <20251117164155.GB196362@frogsfrogsfrogs>
 <aRtjfN7sC6_Bv4bx@casper.infradead.org>
 <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
 <aRxunCkc4VomEUdo@infradead.org>
 <aRySpQbNuw3Y5DN-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRySpQbNuw3Y5DN-@casper.infradead.org>

On Tue, Nov 18, 2025 at 03:37:09PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 18, 2025 at 05:03:24AM -0800, Christoph Hellwig wrote:
> > On Mon, Nov 17, 2025 at 10:45:31AM -0800, Andrii Nakryiko wrote:
> > > As I replied on another email, ideally we'd have some low-level file
> > > reading interface where we wouldn't have to know about secretmem, or
> > > XFS+DAX, or whatever other unusual combination of conditions where
> > > exposed internal APIs like filemap_get_folio() + read_cache_folio()
> > > can crash.
> > 
> > The problem is that you did something totally insane and it kinda works
> > most of the time.
> 
> ... on 64-bit systems.  The HIGHMEM handling is screwed up too.
> 
> > But bpf or any other file system consumer has
> > absolutely not business poking into the page cache to start with.
> 
> Agreed.
> 
> > And I'm really pissed off that you wrote and merged this code without
> > ever bothering to talk to a FS or MM person who have immediately told
> > you so.  Let's just rip out this buildid junk for now and restart
> > because the problem isn't actually that easy.
> 
> Oh, they did talk to fs & mm people originally and were told NO, so they
> sneaked it in through the BPF tree.
> 
> https://lore.kernel.org/all/20230316170149.4106586-1-jolsa@kernel.org/
> 
> > > The only real limitation is that we'd like to be able to control
> > > whether we are ok sleeping or not, as this code can be called from
> > > pretty much anywhere BPF might run, which includes NMI context.
> > > 
> > > Would this kiocb_read() approach work under those circumstances?
> > 
> > No.  IOCB_NOWAIT is just a hint to avoid blocking function calls.
> > It is not guarantee and a guarantee is basically impossible.
> 
> I'm not sure I'd go that far -- I think we're pretty good about not
> sleeping when IOCB_NOWAIT is specified and any remaining places can
> be fixed up.
> 
> But I am inclined to rip out the buildid code, just because the
> authors have been so rude.

Which fstest actually checks the functionality of the buildid code?
I don't find any, which means none of the fs people have a good signal
for breakage in this, um, novel file I/O path.

--D

