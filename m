Return-Path: <linux-fsdevel+bounces-58277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D03DB2BD7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603DC189C131
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181331CA50;
	Tue, 19 Aug 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI4zolhT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2426D4EF;
	Tue, 19 Aug 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595750; cv=none; b=Eq3f//rZQ1j/JedtPcR/PZ4JJ7ZCMe3X0OwzNuJ/WG0+054wevgrone/H4hFpPSkntXyE73VPsUKc5t/Oya5/vpGAnRaJaCnJzgEGcM2ArF6tu4hLPqpEheITx++XTN4rWKwdPixbJIrelbLKSgW0PsydnPwiq4alHfJEJM0lQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595750; c=relaxed/simple;
	bh=tEc4t+AeYeHjeIn8cFoASltWUSVs0rVeGRrPfy1XwyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN+FILZ3ct8voTKb1rpTy34krLnJGlXCMllXgBZeXt8CNHPhRXMsrKedWZPRFJwxVC4eAb52/xjvHq1mMPj6YnKuEC3CzufzhPIPTdmMqFCmc/ZKiD3nrWt2XltGzZj/2ZLctHudUj/kmKG1wvK3dnM9BqPxCdyDremIRz0bwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI4zolhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB091C116B1;
	Tue, 19 Aug 2025 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755595749;
	bh=tEc4t+AeYeHjeIn8cFoASltWUSVs0rVeGRrPfy1XwyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jI4zolhTDS/Rb/R6P3zrHxmdDr0MIB2PWBfLJzPrr2YfLXjIacW/uKhVZd2VW5jIE
	 41jvcd8vK3ygv506FVQxTbVZzWD2suFgOM7FdeeR7hS1kXGqd0mVGWLNhZ3WpZxI0A
	 m1iwQLoBBWG3tMQlHXWpMpOXlQYGt+NH5TBnM6WJoIvnffBtJvWJCsI0NsniO/GwJA
	 s7XAXlhKe4UuE0QhZx6FM+lSD9MsxFuebkUxbS6GmiqlN0HqK5OJoQNNErXqvp4KfK
	 tLs5TrF/Tq4Re1QGNYgNPgPfxwjEHjvbd3t7PNOWeNS0SO45pHu2Bo7nSoJxoLgt0q
	 kSwEHB+95dvwg==
Date: Tue, 19 Aug 2025 11:29:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Christoph Hellwig <hch@infradead.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, "Darrick J . Wong" <djwong@kernel.org>, 
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
Message-ID: <20250819-benachbarten-bahnnetz-a19e10cd40d2@brauner>
References: <20250814142137.45469-1-kernel@pankajraghav.com>
 <20250815-gauner-brokkoli-1855864a9dff@brauner>
 <aKKu7jN6HrcXt3WC@infradead.org>
 <CGME20250818141331eucas1p21bf686b508f2b37883a954fd8aed891f@eucas1p2.samsung.com>
 <4b225908-f788-413b-ba07-57a0d6012145@igalia.com>
 <43bca78e-fa89-4b0e-94f1-de7385818950@samsung.com>
 <20250818201403.33f469f169957d46ef061d52@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818201403.33f469f169957d46ef061d52@linux-foundation.org>

On Mon, Aug 18, 2025 at 08:14:03PM -0700, Andrew Morton wrote:
> On Mon, 18 Aug 2025 16:35:04 +0200 Pankaj Raghav <p.raghav@samsung.com> wrote:
> 
> > >>> Applied to the vfs-6.18.iomap branch of the vfs/vfs.git tree.
> > >>> Patches in the vfs-6.18.iomap branch should appear in linux-next soon.
> > >>
> > >> Hmm, AFAIK largest_zero_folio just showed up in mm.git a few days ago.
> > >> Wouldn't it be better to queue up this change there?
> > >>
> > >>
> > > 
> > > Indeed, compiling vfs/vfs.all as of today fails with:
> > > 
> > > fs/iomap/direct-io.c:281:36: error: implicit declaration of function 
> > > ‘largest_zero_folio’; did you mean ‘is_zero_folio’? [-Wimplicit- 
> > > function-declaration]
> > > 
> > > Reverting "iomap: use largest_zero_folio() in iomap_dio_zero()" fixes 
> > > the compilation.
> > > 
> > 
> > I also got some reports from Stephen in linux-next. As Christoph 
> > suggested, maybe we drop the patches from Christian's tree and queue it 
> > up via Andrew's tree
> 
> Thanks, I added it to mm.git.

Please ask before you move stuff around between trees. You've complained
to me before about this before too. I haven't agreed to that at all.

There's a bunch more iomap work coming and this will most certainly not
start going through mm trees. So if there's merge conflicts where we
rely on a helper that's in mm-next the good thing would simply to
provide a branch for us with that helper that we can base this off of.

