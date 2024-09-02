Return-Path: <linux-fsdevel+bounces-28281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427D6968E30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B99BB2222A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1019CC2E;
	Mon,  2 Sep 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaQ1xhjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACE19CC1C;
	Mon,  2 Sep 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304127; cv=none; b=dIQuGrUOjgOfJVKDK3pYSXt1Ewy4seUjShygsCFPho4kEoys4MYUNZKi2ecTSxVcyUuiPx/75nbN9kJhQTaDOqhWrOgCaLmc1jrv/NSXg87DuD+N5P+gZWFNax76mMKbANNRXRVkGI8Yt5yp24EqFiLrUXpnyYep8ixsJFrSctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304127; c=relaxed/simple;
	bh=apI5HiY67Z6hG4LwlOvdVoI6AOvyzBAzhK3n1UGdu9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSxLQ+rY05EQfTEtcs4C86H0Z/qb9o8O/VB+exnlM5IlB9p0LXzcTCes7bGTBvIIxgiOxt9l6W/qtDBeLbobc2ROOaKc6DwHHjZhfjKcqAvimYbUORpatB18bzF77+X0KbaX0VqixssRc3paQO9IKNoLpqB/XDM2vEGy3bj1PIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaQ1xhjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D487AC4CEC7;
	Mon,  2 Sep 2024 19:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725304125;
	bh=apI5HiY67Z6hG4LwlOvdVoI6AOvyzBAzhK3n1UGdu9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaQ1xhjD2FPmkjAlwi/ht1PYDXQrbuM5jyqYs1DUdmLk+4PwKguPDVR/IddiDq2+q
	 BWBYE2/OmFDfPcW4zb0YxAWYCD7QrquIS96zFI1l4Be9WVxLSuI+pIJ7IuWK29lGxw
	 ASs4cT5FUdn4zogy2UP8srbIbHtb+90k5iKMQQZ13hR6/n7d7QcCZpH8mDn+95PMvC
	 Whz7WHwcs5j9HWVChNGvHbWtsS+OpekfaOmw+Wez2z2J84ykkQEhcT7P3uUDtdqHwi
	 PQZ/F05v8TX09Zoi+VTnJ/rOY/0en1bh/ZuJLNtKJ2zplJUHBbx1k9NoRu5CsAvJbJ
	 CuVBAv1iGBH9g==
Date: Mon, 2 Sep 2024 21:08:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, sfr@canb.auug.org.au, 
	akpm@linux-foundation.org, linux-next@vger.kernel.org, mcgrof@kernel.org, ziy@nvidia.com, 
	da.gomez@samsung.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] mm: don't convert the page to folio before splitting in
 split_huge_page()
Message-ID: <20240902-leiblich-aufsehen-841e42a5a09d@brauner>
References: <20240902124931.506061-2-kernel@pankajraghav.com>
 <ZtXFBTgLz3YFHk9T@casper.infradead.org>
 <20240902-wovor-knurren-01ba56e0460e@brauner>
 <20240902144841.gfk4bakvtz6bxdqx@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902144841.gfk4bakvtz6bxdqx@quentin>

On Mon, Sep 02, 2024 at 02:48:41PM GMT, Pankaj Raghav (Samsung) wrote:
> On Mon, Sep 02, 2024 at 04:21:09PM +0200, Christian Brauner wrote:
> > On Mon, Sep 02, 2024 at 03:00:37PM GMT, Matthew Wilcox wrote:
> > > On Mon, Sep 02, 2024 at 02:49:32PM +0200, Pankaj Raghav (Samsung) wrote:
> > > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > > 
> > > > Sven reported that a commit from bs > ps series was breaking the ksm ltp
> > > > test[1].
> > > > 
> > > > split_huge_page() takes precisely a page that is locked, and it also
> > > > expects the folio that contains that page to be locked after that
> > > > huge page has been split. The changes introduced converted the page to
> > > > folio, and passed the head page to be split, which might not be locked,
> > > > resulting in a kernel panic.
> > > > 
> > > > This commit fixes it by always passing the correct page to be split from
> > > > split_huge_page() with the appropriate minimum order for splitting.
> > > 
> > > This should be folded into the patch that is broken, not be a separate
> > > fix commit, otherwise it introduces a bisection hazard which are to be
> > > avoided when possible.
> > 
> > Patch folded into "mm: split a folio in minimum folio order chunks"
> > with the Link to this patch. Please double-check.
> Thanks a lot!
> 
> I still don't see it upstream[1]. Maybe it is yet to be pushed?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.blocksize&id=fd031210c9ceb399db1dea001c6a5e98f3b4e2e7

Pushed now.

