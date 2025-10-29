Return-Path: <linux-fsdevel+bounces-66286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACFFC1A7D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B75C585723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB825393C;
	Wed, 29 Oct 2025 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJgv2viE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B542286897;
	Wed, 29 Oct 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741130; cv=none; b=Lp8pGDwcgUgXiz947EE4avYXs3COHPuLEZewnARs//rUFBOg9W82B6x48qO/BSAsSb9VJuaqQ7XeczvvlqUtRztxnRT1YdxgguA27jElRAtPADgQuRKT6f720oQ0dQ8sIUNpRQEw6R+Jp8/9VNsVsi2EZ56Nmzl5w9/MKVldBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741130; c=relaxed/simple;
	bh=bwJ2LDA4HRhC+HobQk4QKdidu746ps7rOg5uVjEgqro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTUNaKa8j06erUvGhX7TforPocf92nki/K/gBbtMHEI6jWsQDZ1B1CzmVjBcuyhkR8Oah1HoHoMBIRwJ35FMif4Aoe1YcetR1cJBjDR9He01sIbdv4JN/jGPPqaycJHZDO4J/vgYLz8DC3vBixVcCV8CPTHLFoSBGga5ZA5mxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJgv2viE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C35C4CEF7;
	Wed, 29 Oct 2025 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761741129;
	bh=bwJ2LDA4HRhC+HobQk4QKdidu746ps7rOg5uVjEgqro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJgv2viE4T0S7HMJU6Yh7xCC80x72PQjEKuQzhXPuI+TXewfU5c5NVc/W52pu7PQ7
	 e5k/ft0v6KR0Wb16oe7Q37oPx+ZQEeGi6s/xnccQrVaKwi91vkHYJXFRUReY/IZ3nc
	 4T97Tr1tWM9CQOEhIqJfxhtbk/zLt8h/HLZx2l64WfT7BRo8ZITf3nhN7slWoTc8dt
	 oNjOLZpMChg/E6wI6M2RLrWSalIRfMVI6zvruFfFi5MDVHjLMgws2oM92LLZVguItY
	 uScNW57JyDgVNiPgPx/zywwoqvGhxQ/EvK2QveGnFjEJ4jUyqupUot16mS9/hUiRZe
	 sv6QR5mXH2ACw==
Date: Wed, 29 Oct 2025 13:32:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, hch@infradead.org, djwong@kernel.org, 
	willy@infradead.org
Subject: Re: [PATCH v5 0/7] iomap: zero range folio batch support
Message-ID: <20251029-entrichten-anrollen-b9eb57a2914f@brauner>
References: <20251003134642.604736-1-bfoster@redhat.com>
 <20251007-kittel-tiefbau-c3cc06b09439@brauner>
 <CAJnrk1Yp-z8U7WjH81Eh3wrvuc5erZ2fUjZZa2urb-OhAe_nig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Yp-z8U7WjH81Eh3wrvuc5erZ2fUjZZa2urb-OhAe_nig@mail.gmail.com>

On Mon, Oct 20, 2025 at 05:14:07PM -0700, Joanne Koong wrote:
> On Tue, Oct 7, 2025 at 4:12 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, 03 Oct 2025 09:46:34 -0400, Brian Foster wrote:
> > > Only minor changes in v5 to the XFS errortag patch. I've kept the R-b
> > > tags because the fundamental logic is the same, but the errortag
> > > mechanism has been reworked and so that one needed a rebase (which turns
> > > out much simpler). A second look certainly couldn't hurt, but otherwise
> > > the associated fstest still works as expected.
> > >
> > > Note that the force zeroing fstests test has since been merged as
> > > xfs/131. Otherwise I still have some followup patches to this work re:
> > > the ext4 on iomap work, but it would be nice to move this along before
> > > getting too far ahead with that.
> > >
> > > [...]
> >
> > Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.19.iomap branch should appear in linux-next soon.
> >
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> >
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> >
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-6.19.iomap
> >
> > [1/7] filemap: add helper to look up dirty folios in a range
> >       https://git.kernel.org/vfs/vfs/c/757f5ca76903
> > [2/7] iomap: remove pos+len BUG_ON() to after folio lookup
> >       https://git.kernel.org/vfs/vfs/c/e027b6ecb710
> > [3/7] iomap: optional zero range dirty folio processing
> >       https://git.kernel.org/vfs/vfs/c/5a9a21cb7706
> 
> Hi Christian,
> 
> Thanks for all your work with managing the vfs iomap branch. I noticed
> for vfs-6.19.iomap, this series was merged after a prior patch in the
> branch that had changed the iomap_iter_advance() interface [1]. As
> such for the merging ordering, I think this 3rd patch needs this minor
> patch-up to be compatible with the change made in [1], if you're able
> to fold this in:
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 72196e5021b1..36ee3290669a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -867,7 +867,8 @@ static int iomap_write_begin(struct iomap_iter *iter,
>         if (folio_pos(folio) > iter->pos) {
>                 len = min_t(u64, folio_pos(folio) - iter->pos,
>                                  iomap_length(iter));
> -               status = iomap_iter_advance(iter, &len);
> +               status = iomap_iter_advance(iter, len);
> +               len = iomap_length(iter);
>                 if (status || !len)
>                         goto out_unlock;

Thank you! Folded as requested!

