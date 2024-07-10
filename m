Return-Path: <linux-fsdevel+bounces-23530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13B92DCB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 01:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9128F1C218AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C1157480;
	Wed, 10 Jul 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alQFnqww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08A848E;
	Wed, 10 Jul 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654806; cv=none; b=nCEQwnTvoAbaxOeKbyrMi/nj6KW396zC0jkFsPxB1MU2+1Fd28vct2q9AFdOVKQ6T066/v/9cFfynJzmerE9xO08h8uTgdcO0VAhi48dc2IoU0ZRjfgMVJvSwDJ4xvSWJuHrnzzHyZpN2hVFQoMuiDNdbcOjw82f/p/1zjyceBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654806; c=relaxed/simple;
	bh=TMcVvqG6rqVWGaTOFcCtZt0wtwQV7k2OgSE8df3s+dw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3HyC6NHqYkc0tIwwBSQEJKRLkGFQOkvjiWo/TTF4HgRm1zdmiMLoUEi4tYAV5DLbcN0zaZFRueePD/pQ7Fo9FvPQYRUbCbj3+xZweCtG4+IE2/V92qyRUgh8D6C9QMsuzrJz2nwVqT6YGwbGujfgGIguJw4jopjLAmwT03HMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alQFnqww; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720654805; x=1752190805;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TMcVvqG6rqVWGaTOFcCtZt0wtwQV7k2OgSE8df3s+dw=;
  b=alQFnqwwxSfCLxfqReb/VHbjGJGaaPw5rdCra9g0yhvzW+hls7DNabb9
   9eK1CeF4EJfTstvvArIlXvRhkfyGmZHenqPhcGPpZUtpfj0RUZFH1Iq61
   l5tQ/TnMl/42SYv+k2cZJmNF9BZw3AeUC61S1+OcxcTgMM33vu5fF/lwv
   a4cHfs1W/Fky1tQnTIFHZSPDW1lZFmOJKpXO/Ebn36bSylE081EnbCnHi
   5cVVnQv6Cjz7HrJmWDboiaulJt5uuQCnx7uxzqIRsj4gG3BSO3UCcIGkB
   7tO/Um95E1dA8aE244WHE/GmRXGFvNcJnjzQib4H9R+VZznB+39KmsepO
   A==;
X-CSE-ConnectionGUID: +SYmIUZsRqOHKLbLr2iWFQ==
X-CSE-MsgGUID: xSv7L7X1SKCfKa1VYJGiZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17629061"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="17629061"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:40:04 -0700
X-CSE-ConnectionGUID: FB96FvRfR8eHP9iQ8Umqtg==
X-CSE-MsgGUID: 0DhXPLq3TLOQkmbqVF/05Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48432626"
Received: from sbalki-mobl.amr.corp.intel.com (HELO [10.209.73.56]) ([10.209.73.56])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:40:04 -0700
Message-ID: <0b928778df827f7ea948931c3358616c8e7f26f7.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, "Ma, Yu" <yu.ma@intel.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com
Date: Wed, 10 Jul 2024 16:40:03 -0700
In-Reply-To: <CAGudoHGJrRi_UZ2wv2dG9U9VGasHW203O4nQHkE9KkaWJJ61WQ@mail.gmail.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
	 <20240703143311.2184454-1-yu.ma@intel.com>
	 <20240703143311.2184454-4-yu.ma@intel.com>
	 <CAGudoHH_P4LGaVN1N4j8FNTH_eDm3SDL7azMc25+HY2_XgjvJQ@mail.gmail.com>
	 <20240704215507.mr6st2d423lvkepu@quack3>
	 <3c7a0cd7-1dd2-4762-a2dd-67e6b6a82df7@intel.com>
	 <1296ef8d-dade-46e5-8571-e7dba158f405@intel.com>
	 <CAGudoHGJrRi_UZ2wv2dG9U9VGasHW203O4nQHkE9KkaWJJ61WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 12:17 +0200, Mateusz Guzik wrote:
> Right, forgot to respond.
>=20
> I suspect the different result is either because of mere variance
> between reboots or blogbench using significantly less than 100 fds at
> any given time -- I don't have an easy way to test at your scale at
> the moment. You could probably test that by benching both approaches
> while switching them at runtime with a static_branch. However, I don't
> know if that effort is warranted atm.
>=20
> So happens I'm busy with other stuff and it is not my call to either
> block or let this in, so I'm buggering off.
>=20
> On Tue, Jul 9, 2024 at 10:32=E2=80=AFAM Ma, Yu <yu.ma@intel.com> wrote:
> >=20
> >=20
> > On 7/5/2024 3:56 PM, Ma, Yu wrote:
> > > I had something like this in mind:
> > > > > diff --git a/fs/file.c b/fs/file.c
> > > > > index a3b72aa64f11..4d3307e39db7 100644
> > > > > --- a/fs/file.c
> > > > > +++ b/fs/file.c
> > > > > @@ -489,6 +489,16 @@ static unsigned int find_next_fd(struct fdta=
ble
> > > > > *fdt, unsigned int start)
> > > > >          unsigned int maxfd =3D fdt->max_fds; /* always multiple =
of
> > > > > BITS_PER_LONG */
> > > > >          unsigned int maxbit =3D maxfd / BITS_PER_LONG;
> > > > >          unsigned int bitbit =3D start / BITS_PER_LONG;
> > > > > +       unsigned int bit;
> > > > > +
> > > > > +       /*
> > > > > +        * Try to avoid looking at the second level map.
> > > > > +        */
> > > > > +       bit =3D find_next_zero_bit(&fdt->open_fds[bitbit], BITS_P=
ER_LONG,
> > > > > +                               start & (BITS_PER_LONG - 1));
> > > > > +       if (bit < BITS_PER_LONG) {
> > > > > +               return bit + bitbit * BITS_PER_LONG;
> > > > > +       }

I think this approach based on next_fd quick check is more generic and scal=
able.

It just happen for blogbench, just checking the first 64 bit allow a quicke=
r
skip to the two level search where this approach, next_fd may be left
in a 64 word that actually has no open bits and we are doing useless search
in find_next_zero_bit(). Perhaps we should check full_fds_bits to make sure
there are empty slots before we do
find_next_zero_bit() fast path.  Something like

	if (!test_bit(bitbit, fdt->full_fds_bits)) {
		bit =3D find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
					start & (BITS_PER_LONG - 1));
		if (bit < BITS_PER_LONG)
			return bit + bitbit * BITS_PER_LONG;
	}
Tim

> > > > Drat, you're right. I missed that Ma did not add the proper offset =
to
> > > > open_fds. *This* is what I meant :)
> > > >=20
> > > >                                 Honza
> > >=20
> > > Just tried this on v6.10-rc6, the improvement on top of patch 1 and
> > > patch 2 is 7% for read and 3% for write, less than just check first w=
ord.
> > >=20
> > > Per my understanding, its performance would be better if we can find
> > > free bit in the same word of next_fd with high possibility, but
> > > next_fd just represents the lowest possible free bit. If fds are
> > > open/close frequently and randomly, that might not always be the case=
,
> > > next_fd may be distributed randomly, for example, 0-65 are occupied,
> > > fd=3D3 is returned, next_fd will be set to 3, next time when 3 is
> > > allocated, next_fd will be set to 4, while the actual first free bit
> > > is 66 , when 66 is allocated, and fd=3D5 is returned, then the above
> > > process would be went through again.
> > >=20
> > > Yu
> > >=20
> > Hi Guzik, Honza,
> >=20
> > Do we have any more comment or idea regarding to the fast path? Thanks
> > for your time and any feedback :)
> >=20
> >=20
> > Regards
> >=20
> > Yu
> >=20
>=20
>=20


