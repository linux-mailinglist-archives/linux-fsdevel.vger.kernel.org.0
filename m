Return-Path: <linux-fsdevel+bounces-68943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF54C6985F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 14:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A25672B562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D62F5A3F;
	Tue, 18 Nov 2025 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PuRCrHji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6662765C5;
	Tue, 18 Nov 2025 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763471007; cv=none; b=UVC8dPBEbhcmnuThCOJT3FHJzJ7YwolPAI+3aKVfLdgZoL6SUMuobKiI8EYBLuQzTHBQxImWwYYh8erCCrMQC/DvmBiBUIePNS82wukJGp78xOXoK2poqUJcqroa1c25BL597VVlfgSqvY0kzfWbujAd1JKNH8nDeHVpCeWdmqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763471007; c=relaxed/simple;
	bh=ZgblESNj1fOWb5XUDk3faCSe6HDicLSJis6LLJ3gbA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1KjWE6hJH9j49Gu4JLjJhpImQUcIbniaoZRRHUwXnRCNomcQKui6DXlv14+BRILWqiBrA8+WA57+W/yOm7v/v63waiRtRuQDpN+KKhW9mB3K8zpo2GJ3lqY6rYxi7olxex3jbqSIDzZiNuTLd5CVc5FGXaNNSczZBpK/Kp/+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PuRCrHji; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vLiGOr9ReViRNPVVqlOljGBjm5H3XmMece31/N2QTnE=; b=PuRCrHjiJZhUz0PHBhmikSNf97
	lvqqOO5MQKwp1dGXBXoQdq5yEbbSxfSbY4/Q1tFSKx0c7auNbphvCw08iwxirHCWMgo9N+FLvWl/l
	7SC9liYmZrp6JDd0V/Hsm/OJbpaQvGTdjgxI3iTMs/soNtcCa39GFFTYibcdh1+qaAFnK9YzWKep4
	9vTfX/XvoxumxRuSkJV2H+Y62e7avhHbkuggrsHe0Eq07ill7hmRnHA7ttZCMO3WJCYlekkxQo/zs
	jjW04WW2ZSs3uZeG4UGWs/GYB9VB8t1ZFbmD2YQEFBpU3L6qCqjSc1vF3VYKazSl37ykTkyaf54RU
	OlQYzSUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLLMi-00000000S6R-2GYS;
	Tue, 18 Nov 2025 13:03:24 +0000
Date: Tue, 18 Nov 2025 05:03:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <aRxunCkc4VomEUdo@infradead.org>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
 <20251117164155.GB196362@frogsfrogsfrogs>
 <aRtjfN7sC6_Bv4bx@casper.infradead.org>
 <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 17, 2025 at 10:45:31AM -0800, Andrii Nakryiko wrote:
> As I replied on another email, ideally we'd have some low-level file
> reading interface where we wouldn't have to know about secretmem, or
> XFS+DAX, or whatever other unusual combination of conditions where
> exposed internal APIs like filemap_get_folio() + read_cache_folio()
> can crash.

The problem is that you did something totally insane and it kinda works
most of the time.  But bpf or any other file system consumer has
absolutely not business poking into the page cache to start with.

And I'm really pissed off that you wrote and merged this code without
ever bothering to talk to a FS or MM person who have immediately told
you so.  Let's just rip out this buildid junk for now and restart
because the problem isn't actually that easy.
> 
> The only real limitation is that we'd like to be able to control
> whether we are ok sleeping or not, as this code can be called from
> pretty much anywhere BPF might run, which includes NMI context.
> 
> Would this kiocb_read() approach work under those circumstances?

No.  IOCB_NOWAIT is just a hint to avoid blocking function calls.
It is not guarantee and a guarantee is basically impossible.


