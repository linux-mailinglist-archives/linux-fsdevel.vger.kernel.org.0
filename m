Return-Path: <linux-fsdevel+bounces-68954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6CBC6A5AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEBA034C846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9CD364EA0;
	Tue, 18 Nov 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OnohOJXb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB42BEC3A;
	Tue, 18 Nov 2025 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480234; cv=none; b=TT2PknGFmEjtnfevmsPCRC/TTFrpFk1qkuEaOoFvhhMDFJNyyoi8wLtDSKe/IVfxNLeUhCc2CKrCvZEdhEiVrj1g49Rs/Ufw/jNy1FonHQsq0Ywe3ArqVTBf59ANiRFWuATBO1h5Tiq3KnWNDXpqR9OSg8Bf3T+OWcoGhH6P43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480234; c=relaxed/simple;
	bh=6xlKYzD6EOZfLwu07/W6iZb9R+p741L+sRVO+pYXTPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfIcPCOrBn0Ut9OUvTN0lx6WLb6dv9q/9z7qU4RwPKZGZUI5aitiM0PIvveosf5sjG8w2w/M+vImkjwj0o+jiMxda/9wPHC2kokXByyBE6yD6prVrIjcGEkgrXfsq5vpvdwBWIXtovJ7S/RHe9dxHy7L0JyYklNHfEtUKaQ2blI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OnohOJXb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9qRBOpRFp/y3fjy/IOWET6iwhgiraMFiQ0WP7HK72L8=; b=OnohOJXbkOwQ7YKpHLtvPNlxnX
	zCJ7Gu6R/b6rQm45h7RhZAQIhc9gMHB/1TUz8nEr81ED1rXx55nva88Vg0XwIZPBDpf9i2THDUJQu
	As49cZ11Y611hd0FpeIdAbKsQLZXJQRWfiJhuM+plSknTqYXy2lxCljOrQrDNstY1KZZbJ1ezrN0l
	tBlq3e0g4r5B0W6xufYIi3Bovt3Dfyl0BIy8O0VsZOdSN7wVf6g6r7PpOtkPu4lrOLyTTAAMVjBqN
	YftY6B/THUev24ihZV0FRT/NTZ1YBE4nSACUOZTAc6MnMD+OF85SE6r5iQJzs6OWcshv1/IzCOX9c
	WsYj+WnA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLNlV-0000000FgQf-2CDq;
	Tue, 18 Nov 2025 15:37:09 +0000
Date: Tue, 18 Nov 2025 15:37:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
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
Message-ID: <aRySpQbNuw3Y5DN-@casper.infradead.org>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
 <20251117164155.GB196362@frogsfrogsfrogs>
 <aRtjfN7sC6_Bv4bx@casper.infradead.org>
 <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
 <aRxunCkc4VomEUdo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRxunCkc4VomEUdo@infradead.org>

On Tue, Nov 18, 2025 at 05:03:24AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 17, 2025 at 10:45:31AM -0800, Andrii Nakryiko wrote:
> > As I replied on another email, ideally we'd have some low-level file
> > reading interface where we wouldn't have to know about secretmem, or
> > XFS+DAX, or whatever other unusual combination of conditions where
> > exposed internal APIs like filemap_get_folio() + read_cache_folio()
> > can crash.
> 
> The problem is that you did something totally insane and it kinda works
> most of the time.

... on 64-bit systems.  The HIGHMEM handling is screwed up too.

> But bpf or any other file system consumer has
> absolutely not business poking into the page cache to start with.

Agreed.

> And I'm really pissed off that you wrote and merged this code without
> ever bothering to talk to a FS or MM person who have immediately told
> you so.  Let's just rip out this buildid junk for now and restart
> because the problem isn't actually that easy.

Oh, they did talk to fs & mm people originally and were told NO, so they
sneaked it in through the BPF tree.

https://lore.kernel.org/all/20230316170149.4106586-1-jolsa@kernel.org/

> > The only real limitation is that we'd like to be able to control
> > whether we are ok sleeping or not, as this code can be called from
> > pretty much anywhere BPF might run, which includes NMI context.
> > 
> > Would this kiocb_read() approach work under those circumstances?
> 
> No.  IOCB_NOWAIT is just a hint to avoid blocking function calls.
> It is not guarantee and a guarantee is basically impossible.

I'm not sure I'd go that far -- I think we're pretty good about not
sleeping when IOCB_NOWAIT is specified and any remaining places can
be fixed up.

But I am inclined to rip out the buildid code, just because the
authors have been so rude.

