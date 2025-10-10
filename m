Return-Path: <linux-fsdevel+bounces-63781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABABCDA99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890C33BA143
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB012F533E;
	Fri, 10 Oct 2025 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBOsJd/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A21A4F3C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108474; cv=none; b=EVOO8aggJv6i6MmYrN434vQLHhwKTFq+wlgc/+fQpf7BLx/RT6DI94PKPZhR9U3ymBdGdENikICqq9RlzpDXeAQfQrysmseycxQAeGhYgGVWIUC2qWBzjNd4ucxvITY3Vz0ujE7KMBCqK7xEbIkSZe4mwdfVotJ0L3f5H4fSvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108474; c=relaxed/simple;
	bh=lbH+lEeu5N25Pi3fQ5k8QqlIt8M7U3yz3hhIZ3ULEa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwN3APvHHEyNv/zQkDPo7FlprPHwJJuY8eOZyAA8ORHZr2joQ13y657nsA+emDXxyBhO2zy94ynVUX/DBaist2rkazQZgFu38Sr8ctWOKDtSoccZ8MSqVNkkwcIOTQaRWWmzlyzwtlhJeJpyOH6CtSxoB/xj1cAnd4KyJf9gpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBOsJd/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA13C4CEF1;
	Fri, 10 Oct 2025 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760108473;
	bh=lbH+lEeu5N25Pi3fQ5k8QqlIt8M7U3yz3hhIZ3ULEa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBOsJd/tACsANWy5+03n3DtD8cZ2v+gBluBfgYpxF1xs+an/9CmEI3r0za5oTxQxT
	 8M1Kw9ZYefe0KtuNgR00jx4IHROw87N7DHKlpOG4/wxno+b3OqoQL9AxeTotu/fy9D
	 v2iEvZgh6YMUjlmpKHpjmhDDDD2MBoq86ASFuWKWRouOTzA8DS8lV5lqRALORXuNIp
	 d2Zl1st0wZEyIh/eSjKK7/XKCIgFWfrrreUuY0zx0HZAc4/Rb/Ri8khK+QXcuve/iJ
	 7/wFKFcB44fxQ4khqaiW7jDZ1z7kqvXntNlcUU/iaZzxZwydCeNDbXJOsknlu2LobD
	 KDSEhLNQG1B2A==
Date: Fri, 10 Oct 2025 08:01:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
Message-ID: <20251010150113.GC6174@frogsfrogsfrogs>
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>

[cc willy in case he has opinions about dynamically changing the
pagecache order range]

On Thu, Oct 09, 2025 at 11:36:30AM -0700, Joanne Koong wrote:
> On Thu, Oct 9, 2025 at 7:17 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, 8 Oct 2025 at 22:42, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > > Since fuse now uses proper writeback accounting without temporary pages,
> > > strictlimiting is no longer needed. Additionally, for fuse large folio
> > > buffered writes, strictlimiting is overly conservative and causes
> > > suboptimal performance due to excessive IO throttling.
> >
> > I don't quite get this part.  Is this a fuse specific limitation of
> > stritlimit vs. large folios?
> >
> > Or is it the case that other filesystems are also affected, but
> > strictlimit is never used outside of fuse?
> 
> It's the combination of fuse doing strictlimiting and setting the bdi
> max ratio to 1%.
> 
> I don't think this is fuse-specific. I ran the same fio job [1]
> locally on xfs and with setting the bdi max ratio to 1%, saw
> performance drops between strictlimiting off vs. on
> 
> [1] fio --name=write --ioengine=sync --rw=write --bs=256K --size=1G
> --numjobs=2 --ramp_time=30 --group_reporting=1

Er... what kind of numbers? :)

> >
> > > Administrators can still enable strictlimiting for specific fuse servers
> > > via /sys/class/bdi/*/strict_limit. If needed in the future,
> >
> > What's the issue with doing the opposite: leaving strictlimit the
> > default and disabling strictlimit for specific servers?
> 
> If we do that, then we can't enable large folios for servers that use
> the writeback cache. I don't think we can just turn on large folios if

What's the limitation on strictlimit && large_folios?  Is it just the
throttling problem because dirtying a single byte in a 2M folio charges
the process with all 2M?  Or something else?

> an admin later on disables strictlimiting for the server, because I
> don't think mapping_set_folio_order_range() can be called after the
> inode has been initialized (not 100% sure about this), which means
> we'd also need to add some mount option for servers to disable
> strictlimiting.

I think it's ok to increase the folio order range at runtime because
you're merely expanding the range of valid folio sizes in the mapping.

Decreasing the range probably won't work unless you take the inode and
mapping locks exclusively and purge the pagecache.

--D

> Thanks,
> Joanne
> >
> > Thanks,
> > Miklos
> 

