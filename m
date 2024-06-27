Return-Path: <linux-fsdevel+bounces-22644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41BF91AC7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C988B218BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9661993B2;
	Thu, 27 Jun 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krwV9Qk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98F15278F;
	Thu, 27 Jun 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505303; cv=none; b=jOuX6qY3bYr35E2glPzGv9+vO0dGkOaMOD4GSCY7fajhCZ1Y4MBHfObNk1U+0Py6QE0Ni9IukWrYN2y4ei40YAOKxYIiDaR9QXGbRu7v4kV68fsqvFejgvObzys4Z37ycxyU/iUXPVq5GXJ8IY6rAOSNdMFW2GoGte661VMNwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505303; c=relaxed/simple;
	bh=CtyL09YmkjYmx0ltwOtdbd/7qrkuTlx8HCGTtSyncEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bCI7eX/6d9j3sJQmt3UjwxR8mX0kKy6vbRE+r7jwvpho9q2AXpIAjb1ah/IBUh7rKQYCmszogTzkgKwOqBD/6Di+D8G8nkEdoMxl41CuEtZ3nRDBMowqtUI07rdLUDTM0u1ppmx6LzoVj+8D/cpPA13Dlka8ZibocG6HU/jsZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krwV9Qk0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719505302; x=1751041302;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CtyL09YmkjYmx0ltwOtdbd/7qrkuTlx8HCGTtSyncEI=;
  b=krwV9Qk0dXRs18RkBcZFwvDxZj4kQDa7S2r/8tgdbBEiYXmebOVP/6Cw
   QwQa9IgTg0/Ff7EBvcpE7FBDvTWV6ncYEey/HZMCp+JmZfDjXK/hScKQX
   FX3r3kqfkOIdyLQXllS1R9CuSfprFTKOIrr+2B8WmKCQ9bJsEiok92Vu/
   38Oi0hSwA6kAIzw921fodwcMno3uwdNxdsTo+mi5o54aPl/qVeKaOUII0
   R6xrSAjxkF9M90CCRprUBiDbmgumTPsRHS2ZGRCUwkok7M6Iy/pvhzhKc
   WXQT8+NNBNGSOTjkIU2aAEQBmCUq4KxcKrgZwb8b7vpbtiy0Gqa8GgZVj
   Q==;
X-CSE-ConnectionGUID: ZCDaRLZ0RbC5De4qSmzpbw==
X-CSE-MsgGUID: QnfPnR+gRBGSClqJx9Lw4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16875608"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16875608"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 09:21:41 -0700
X-CSE-ConnectionGUID: nW2qhl9GTO+kt09O5nYR9Q==
X-CSE-MsgGUID: hoVk+0XJThu+/h/g4chp6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44267677"
Received: from antondav-mobl.amr.corp.intel.com (HELO [10.209.41.155]) ([10.209.41.155])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 09:21:41 -0700
Message-ID: <122c7b9adf440b6e42b16195590d3ef8fbdafaeb.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Jan Kara <jack@suse.cz>
Cc: "Ma, Yu" <yu.ma@intel.com>, viro@zeniv.linux.org.uk, brauner@kernel.org,
  mjguzik@gmail.com, edumazet@google.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, 
 tim.c.chen@intel.com
Date: Thu, 27 Jun 2024 09:21:40 -0700
In-Reply-To: <20240627120922.khxiy5xjxlnnyhiy@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
	 <20240622154904.3774273-1-yu.ma@intel.com>
	 <20240622154904.3774273-2-yu.ma@intel.com>
	 <20240625115257.piu47hzjyw5qnsa6@quack3>
	 <20240625125309.y2gs4j5jr35kc4z5@quack3>
	 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
	 <20240626115427.d3x7g3bf6hdemlnq@quack3>
	 <690de703aeee089f86beca5cb90d3d43dcd7df56.camel@linux.intel.com>
	 <3d553b6571eaa878e4ce68898113d73c9c1ed87d.camel@linux.intel.com>
	 <20240627120922.khxiy5xjxlnnyhiy@quack3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-27 at 14:09 +0200, Jan Kara wrote:
> On Wed 26-06-24 09:52:50, Tim Chen wrote:
> > On Wed, 2024-06-26 at 09:43 -0700, Tim Chen wrote:
> > > On Wed, 2024-06-26 at 13:54 +0200, Jan Kara wrote:
> > > >=20
> > > >=20
> > > > Indeed, thanks for correcting me! next_fd is just a lower bound for=
 the
> > > > first free fd.
> > > >=20
> > > > > The conditions
> > > > > should either be like it is in patch or if (!start && !test_bit(0=
,
> > > > > fdt->full_fds_bits)), the latter should also have the bitmap load=
ing cost,
> > > > > but another point is that a bit in full_fds_bits represents 64 bi=
ts in
> > > > > open_fds, no matter fd >64 or not, full_fds_bits should be loaded=
 any way,
> > > > > maybe we can modify the condition to use full_fds_bits ?
> > > >=20
> > > > So maybe I'm wrong but I think the biggest benefit of your code com=
pared to
> > > > plain find_next_fd() is exactly in that we don't have to load full_=
fds_bits
> > > > into cache. So I'm afraid that using full_fds_bits in the condition=
 would
> > > > destroy your performance gains. Thinking about this with a fresh he=
ad how
> > > > about putting implementing your optimization like:
> > > >=20
> > > > --- a/fs/file.c
> > > > +++ b/fs/file.c
> > > > @@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtabl=
e *fdt, unsigned int start)
> > > >         unsigned int maxbit =3D maxfd / BITS_PER_LONG;
> > > >         unsigned int bitbit =3D start / BITS_PER_LONG;
> > > > =20
> > > > +       /*
> > > > +        * Optimistically search the first long of the open_fds bit=
map. It
> > > > +        * saves us from loading full_fds_bits into cache in the co=
mmon case
> > > > +        * and because BITS_PER_LONG > start >=3D files->next_fd, w=
e have quite
> > > > +        * a good chance there's a bit free in there.
> > > > +        */
> > > > +       if (start < BITS_PER_LONG) {
> > > > +               unsigned int bit;
> > > > +
> > > > +               bit =3D find_next_zero_bit(fdt->open_fds, BITS_PER_=
LONG, start);
> > >=20
> > > Say start is 31 (< BITS_PER_LONG)
> > > bit found here could be 32 and greater than start.  Do we care if we =
return bit > start?
> >=20
> > Sorry, I mean to say that we could find a bit like 30 that is less than
> > start instead of the other way round.=20
>=20
> Well, I propose calling find_next_zero_bit() with offset set to 'start' s=
o
> it cannot possibly happen that the returned bit number is smaller than
> start... But maybe I'm missing something?

Yes, you're right. the search begin at start bit so it is okay.

Tim

>=20
> 									Honza


