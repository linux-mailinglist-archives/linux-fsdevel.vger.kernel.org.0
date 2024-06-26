Return-Path: <linux-fsdevel+bounces-22531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FAC9187F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 18:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929982843C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88C818FC8B;
	Wed, 26 Jun 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReY6pkAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63841F94C;
	Wed, 26 Jun 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420773; cv=none; b=E3i0FfhWUpAJFKA2+YOS9zb1PYCvc13ytSTeBU3X02Og6OvDC9EmBYHEvUoxh+8gP0QLD4ztaruZoLj8bPpKUIL8dBDi9mVLd4jYxqrbrWGmxc4uawZ3ovsk+FIC/xLyuf5CT9cH0CmyyfpSmsB8Bh9NTPlftsUUHq9TWxOch1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420773; c=relaxed/simple;
	bh=RqiwFZ3/x5mZbBYDbfsmFO2HZkjcTWfLQWKMBl63Jj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcqkqdUZYHK+JPOuCHm07xVEor/bFBtVBP29IYfdEjnySqVsJ/+SMr0NGMGupAwL4EuoZe8XMJ+PgCCXLwTaiDKIVRAkG8PDb+BzG1t813WRajkP5VrpqmwJkWus3jdxUV9+2Y/2BlOpVtWgSVmxxS/G1BSI1W6MG2itIkKcnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReY6pkAa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719420772; x=1750956772;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RqiwFZ3/x5mZbBYDbfsmFO2HZkjcTWfLQWKMBl63Jj4=;
  b=ReY6pkAa7xZ48YaYVN11kmP1emU9ZOJF2Yd5YShvr2MUB9ZyubYj8+Xy
   uATJ2MctdOly3KMlxFWkuUyEVy7ARa4sKGPdHww2FxlubQzPNcexSx+ti
   oj2LyzZXS9BqSKdJPwm4r0qk8BlXx6UMLYbr8iLPthwl5muRUhd0DN36o
   mL4wxniq4fV5SM00+Y5AGqeTUm7Yq3sPE2fElGFj/Cq+FBibHpIwtfz3A
   an6dGj9EdKUgUH7xAyfOOWN1gQpeVoooqN4PTxq4/WmRWRMDea8glkiv7
   g6M/dI+X0dKTVW2MzCiHUx0rF7LqxZlyJkaM2kAwu3ESOx4R5sIjWwAld
   A==;
X-CSE-ConnectionGUID: i8GlrM7kRRGOf9Nvy6owtQ==
X-CSE-MsgGUID: c+Dywl41RQGQaqa36V+5UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16343908"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16343908"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 09:52:51 -0700
X-CSE-ConnectionGUID: wV5umO2eSzSLji7TE8F4LQ==
X-CSE-MsgGUID: MHTBxJDjQdqxx30vEaLIPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="44780133"
Received: from anagara1-mobl.amr.corp.intel.com (HELO [10.209.55.145]) ([10.209.55.145])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 09:52:50 -0700
Message-ID: <3d553b6571eaa878e4ce68898113d73c9c1ed87d.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Jan Kara <jack@suse.cz>, "Ma, Yu" <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, mjguzik@gmail.com, 
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com
Date: Wed, 26 Jun 2024 09:52:50 -0700
In-Reply-To: <690de703aeee089f86beca5cb90d3d43dcd7df56.camel@linux.intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
	 <20240622154904.3774273-1-yu.ma@intel.com>
	 <20240622154904.3774273-2-yu.ma@intel.com>
	 <20240625115257.piu47hzjyw5qnsa6@quack3>
	 <20240625125309.y2gs4j5jr35kc4z5@quack3>
	 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
	 <20240626115427.d3x7g3bf6hdemlnq@quack3>
	 <690de703aeee089f86beca5cb90d3d43dcd7df56.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 09:43 -0700, Tim Chen wrote:
> On Wed, 2024-06-26 at 13:54 +0200, Jan Kara wrote:
> >=20
> >=20
> > Indeed, thanks for correcting me! next_fd is just a lower bound for the
> > first free fd.
> >=20
> > > The conditions
> > > should either be like it is in patch or if (!start && !test_bit(0,
> > > fdt->full_fds_bits)), the latter should also have the bitmap loading =
cost,
> > > but another point is that a bit in full_fds_bits represents 64 bits i=
n
> > > open_fds, no matter fd >64 or not, full_fds_bits should be loaded any=
 way,
> > > maybe we can modify the condition to use full_fds_bits ?
> >=20
> > So maybe I'm wrong but I think the biggest benefit of your code compare=
d to
> > plain find_next_fd() is exactly in that we don't have to load full_fds_=
bits
> > into cache. So I'm afraid that using full_fds_bits in the condition wou=
ld
> > destroy your performance gains. Thinking about this with a fresh head h=
ow
> > about putting implementing your optimization like:
> >=20
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtable *f=
dt, unsigned int start)
> >         unsigned int maxbit =3D maxfd / BITS_PER_LONG;
> >         unsigned int bitbit =3D start / BITS_PER_LONG;
> > =20
> > +       /*
> > +        * Optimistically search the first long of the open_fds bitmap.=
 It
> > +        * saves us from loading full_fds_bits into cache in the common=
 case
> > +        * and because BITS_PER_LONG > start >=3D files->next_fd, we ha=
ve quite
> > +        * a good chance there's a bit free in there.
> > +        */
> > +       if (start < BITS_PER_LONG) {
> > +               unsigned int bit;
> > +
> > +               bit =3D find_next_zero_bit(fdt->open_fds, BITS_PER_LONG=
, start);
>=20
> Say start is 31 (< BITS_PER_LONG)
> bit found here could be 32 and greater than start.  Do we care if we retu=
rn bit > start?

Sorry, I mean to say that we could find a bit like 30 that is less than sta=
rt instead
of the other way round.=20

Tim
>=20


