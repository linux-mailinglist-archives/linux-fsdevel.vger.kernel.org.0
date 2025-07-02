Return-Path: <linux-fsdevel+bounces-53739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68234AF6514
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D8E4E06C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 22:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC00246BA5;
	Wed,  2 Jul 2025 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx8C1zUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689970805;
	Wed,  2 Jul 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751494995; cv=none; b=FtUfNUE6GUHOdV/urvKqUuJS1MlIlO8vbzETVcbVOTJiaSSQC1k/kibC0IHAZzzefS2zXBBg5zMKgR1nhdjAf+ukb8kMWHvN2fe8nSEJon9jXsiTIAFusx4ePud50ZlJhB7iGUXT7+1/HCNO07G5UZcxeaK8J23EjQFHms0iQuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751494995; c=relaxed/simple;
	bh=LVmaI22NMWk9nHFNJ/A528jljikC5KaEan2NqadkjSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYWBgu4ZK42PifNFdb0ZDhqJo/Dt9bs7b5dgYbIOrQ+Axy+SdziqCU6NU/SvS/6vVcfsUUjQLFneQ3ofogHZSW2R2ZUflum76yKOl3u2pmeyrRTu/lI4nkmxLlwYdmv90qh4DD8zSs6c0ONo4CHLl9A5I/BzdEThSBZGpKPwqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx8C1zUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB73C4CEE7;
	Wed,  2 Jul 2025 22:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751494995;
	bh=LVmaI22NMWk9nHFNJ/A528jljikC5KaEan2NqadkjSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mx8C1zUsS1ZWyO8ZpwurYk+HZEZ9ouQ4ugxjMEb0F+Us68GPGF7iqMHer3boyd3Sw
	 a1nvIjNgDsnJR4QIxn5sWTqoJxAhpn39/QF7rAI49MSNPkVq1OYP/VfuoXZKMoffXi
	 2ihvbZ1s4M6IFD06t+ToXPFa1oX3ywC8PjkNbrESbYa03ZKRQHfNi3LFwqdy1FAEsY
	 SUlgei1ECb2vYcCMSecVu+KnyhH+wvu/iKvyYw2Xg94Vqex3aYRZ6cl51j++QCBSX+
	 viKdCeHEydawfI4Eq3MsBw+S+0wPdNYxP6shPmrnVpUz3qMtANooHFH6lqAZrtTXa/
	 +monDaqm4OKCQ==
Date: Wed, 2 Jul 2025 15:23:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/12] iomap: pass more arguments using the iomap
 writeback context
Message-ID: <20250702222314.GE9991@frogsfrogsfrogs>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-2-hch@lst.de>
 <aF601H1HVkw-g_Gk@bfoster>
 <20250630054407.GC28532@lst.de>
 <aGKF6Tfg4M94U3iA@bfoster>
 <20250702181847.GL10009@frogsfrogsfrogs>
 <CAJnrk1YWjSO-FmnzHGRerBP6r6rPSAAm3MgUKfkr_AYjDJjUxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YWjSO-FmnzHGRerBP6r6rPSAAm3MgUKfkr_AYjDJjUxA@mail.gmail.com>

On Wed, Jul 02, 2025 at 03:00:42PM -0700, Joanne Koong wrote:
> On Wed, Jul 2, 2025 at 11:18 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Jun 30, 2025 at 08:41:13AM -0400, Brian Foster wrote:
> > > On Mon, Jun 30, 2025 at 07:44:07AM +0200, Christoph Hellwig wrote:
> > > > On Fri, Jun 27, 2025 at 11:12:20AM -0400, Brian Foster wrote:
> > > > > I find it slightly annoying that the struct name now implies 'wbc,'
> > > > > which is obviously used by the writeback_control inside it. It would be
> > > > > nice to eventually rename wpc to something more useful, but that's for
> > > > > another patch:
> > > >
> > > > True, but wbc is already taken by the writeback_control structure.
> > > > Maybe I should just drop the renaming for now?
> > > >
> > >
> > > Yeah, that's what makes it confusing IMO. writeback_ctx looks like it
> > > would be wbc, but it's actually wpc and wbc is something internal. But I
> > > dunno.. it's not like the original struct name is great either.
> > >
> > > I was thinking maybe rename the wpc variable name to something like
> > > wbctx (or maybe wbctx and wbctl? *shrug*). Not to say that is elegant by
> > > any stretch, but just to better differentiate from wbc/wpc and make the
> > > code a little easier to read going forward. I don't really have a strong
> > > opinion wrt this series so I don't want to bikeshed too much. Whatever
> > > you want to go with is fine by me.
> >
> > I'd have gone with iwc or iwbc, but I don't really care that much. :)
> >
> > Now I'm confused because I've now seen the same patch from joanne and
> > hch and don't know which one is going forward.  Maybe I should just wait
> > for a combined megaseries...
> 
> Christoph's is the main source of truth and mine is just pulling his
> patches and putting the fuse changes on top of that :) For the v3 fuse
> iomap patchset [1], the iomap patches in that were taken verbatim from
> his "refactor the iomap writeback code v2" patchset [2].
> 
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250624022135.832899-1-joannelkoong@gmail.com/
> [2] https://lore.kernel.org/linux-fsdevel/20250617105514.3393938-1-hch@lst.de/

<nod> Well I migrated all my replies to hch's "refactor the iomap
writeback code v3" patchset so I guess I'll... wait for whoever makes
the next move. ;)

--D

> >
> > --D
> >
> > > Brian
> > >
> > >
> 

