Return-Path: <linux-fsdevel+bounces-21843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848A90B872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 19:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7E8B26354
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8645F19409A;
	Mon, 17 Jun 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CF88GXAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468018EFF7;
	Mon, 17 Jun 2024 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646591; cv=none; b=t9bfXTKPBbmKrYyL5JGMFyzRaXtLSMtLYamDfMZSI4Boj97wChik4FpfskA6ZWZeSfjczMZKb/sK6dZxyrVRDOLBNE1/kIaqI5bq0yidJmgEN5M5AP5KjWUpYZ6ehjzLcAdV4jqmEeCpPSuKnLQZCqZzs7pkn9+NwSSX6WjhSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646591; c=relaxed/simple;
	bh=qpDntFPtwMdRw1kIqWrCDSTqi53ygQuaa/Yi2Ci4BFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e78cuExAf1FJWcPJt4Ph2DJ9iN2Fy93NAPPuiI85K0uw7EjYour8ZEx3lxdxEnQlL5xaJI54QULEyOZaA0ankN9x1mo9yXpSIz8XktgJbv26aG1DqXUZMopub4JVaxfnoGPiYimOACEJgdG08s/3oPqcmlzsBHXQgeN/m1fFZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CF88GXAm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718646590; x=1750182590;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qpDntFPtwMdRw1kIqWrCDSTqi53ygQuaa/Yi2Ci4BFI=;
  b=CF88GXAmiwmn+iBf0Y0aXP7p0A4jQOChGfctFvpiBMrqxghYJnUe893E
   yXsl/DejxxBPoIvPTpL4kGRhFyf/HbOS7WJD6LIH7pcpjB87xSZEfesD6
   wZbc/E39Bb2yCkHLuKjSO7t6eall3P1Jv0/IxlGGQuYeKAgV+AGTDRx0g
   W/dcW69FF3pRyjbetA5pC80hQheMyZCGggkhmqfHEDRAKaOQSZsCg9fSw
   /UzKhfxD8Ty4W3venI1c4uDRiNRPwys404FOkFdYIX0Vv0EMdBpq3Erd4
   Y7ANVzU+DJ/pliqN+1gfBE6qQV1q669BeVNyaBC+NVjLGC82xX5ZKDoq7
   g==;
X-CSE-ConnectionGUID: 1UGBELYVQnW9NHLefYCWlg==
X-CSE-MsgGUID: tjjrch3wQ4WvfqWPtfg3Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="19272201"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="19272201"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:49:49 -0700
X-CSE-ConnectionGUID: NN/x4ef7RKCeVvwPf5nftw==
X-CSE-MsgGUID: s5XxExTSQ0uQIakeymyFYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41202878"
Received: from schen9-mobl2.jf.intel.com (HELO [10.24.8.70]) ([10.24.8.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:49:49 -0700
Message-ID: <419b8828fa6bed5e0da1b1aaf53a53c78e91a792.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] fs/file.c: add fast path in alloc_fd()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Date: Mon, 17 Jun 2024 10:49:48 -0700
In-Reply-To: <egcrzi4bkw7lm2q4wml2y7pptpxos4nf5v3il3jmhptcurhxjj@fxtica52olsj>
References: <20240614163416.728752-1-yu.ma@intel.com>
	 <20240614163416.728752-2-yu.ma@intel.com>
	 <egcrzi4bkw7lm2q4wml2y7pptpxos4nf5v3il3jmhptcurhxjj@fxtica52olsj>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 08:31 +0200, Mateusz Guzik wrote:
> On Fri, Jun 14, 2024 at 12:34:14PM -0400, Yu Ma wrote:
> > There is available fd in the lower 64 bits of open_fds bitmap for most =
cases
> > when we look for an available fd slot. Skip 2-levels searching via
> > find_next_zero_bit() for this common fast path.
> >=20
> > Look directly for an open bit in the lower 64 bits of open_fds bitmap w=
hen a
> > free slot is available there, as:
> > (1) The fd allocation algorithm would always allocate fd from small to =
large.
> > Lower bits in open_fds bitmap would be used much more frequently than h=
igher
> > bits.
> > (2) After fdt is expanded (the bitmap size doubled for each time of exp=
ansion),
> > it would never be shrunk. The search size increases but there are few o=
pen fds
> > available here.
> > (3) There is fast path inside of find_next_zero_bit() when size<=3D64 t=
o speed up
> > searching.
> >=20
> > With the fast path added in alloc_fd() through one-time bitmap searchin=
g,
> > pts/blogbench-1.1.0 read is improved by 20% and write by 10% on Intel I=
CX 160
> > cores configuration with v6.8-rc6.
> >=20
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  fs/file.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/file.c b/fs/file.c
> > index 3b683b9101d8..e8d2f9ef7fd1 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -510,8 +510,13 @@ static int alloc_fd(unsigned start, unsigned end, =
unsigned flags)
> >  	if (fd < files->next_fd)
> >  		fd =3D files->next_fd;
> > =20
> > -	if (fd < fdt->max_fds)
> > +	if (fd < fdt->max_fds) {
> > +		if (~fdt->open_fds[0]) {
> > +			fd =3D find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);

Will adding a check here work to ensure fd < end?

			if (unlikely(fd >=3D end)) {
				error =3D -EMFILE;
				goto out;
			}
				=09
> > +			goto success;
> > +		}
> >  		fd =3D find_next_fd(fdt, fd);
> > +	}
> > =20
> >  	/*
> >  	 * N.B. For clone tasks sharing a files structure, this test
> > @@ -531,7 +536,7 @@ static int alloc_fd(unsigned start, unsigned end, u=
nsigned flags)
> >  	 */
> >  	if (error)
> >  		goto repeat;
> > -
> > +success:
> >  	if (start <=3D files->next_fd)
> >  		files->next_fd =3D fd + 1;
> > =20
>=20
> As indicated in my other e-mail it may be a process can reach a certain
> fd number and then lower its rlimit(NOFILE). In that case the max_fds
> field can happen to be higher and the above patch will fail to check for
> the (fd < end) case.
>=20
Thanks.

Tim

