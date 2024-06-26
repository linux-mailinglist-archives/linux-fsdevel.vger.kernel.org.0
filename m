Return-Path: <linux-fsdevel+bounces-22530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203EB9187A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA40E282E44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A0E18F2FA;
	Wed, 26 Jun 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODZVe35m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18518EFE2;
	Wed, 26 Jun 2024 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420211; cv=none; b=BOKLhqHBFMe10gVBxiVlUo8zOplB22sFR4yJXiv9mdpFa6nUcYQwlStYNhVAVtyylUZvUHJRn//aECjqiG+FV0y1xa3fJTk50dKbZSmSzxEL+m9aOYaNbsVqRBYNzcTZsXXJQzyGGZOCthkV4o5OqGfVMl8xSxVDDLXKM7YhN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420211; c=relaxed/simple;
	bh=7BwUhgnCTsmUzblK3PGtJGAOBTmrjaY4L99j/zFGOU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihsusn+cw4zDvAMOEfkUxj18v87sBcGC+zw43rv5eKsAz9LMLndu+jM0xTlpiD32hLs2CvPmJU23gdlLMG9RWR1l+IOWLeI6zgwaS9jNukKH5yzX7QCQ7+8ttkJqHtmEVUnFCstIGy0xJP08wjYjH5OUqcvmLaQ5fBr8SW/bAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODZVe35m; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719420210; x=1750956210;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7BwUhgnCTsmUzblK3PGtJGAOBTmrjaY4L99j/zFGOU8=;
  b=ODZVe35mMpTL+UPe9cwnlO88aNSgsB//JjysttI8wvtj2lWUv3rNDzTw
   mnXnkXPl7fakFErAWDY9bt/lOSrk8WIjKzRcDPqhnFLzw+XuaZZl7jHSa
   VoPPd9BRY2Zhl50JVSObm8SFQXvjdO4OznplNzo+FQMM9vEcjs6OMucBp
   oJqYKy4TWoGeavihdOcg9taZDBmpnnXVUl0QDM2SmBpwM6vpQ9JWLKp2E
   CVz1bzmmbVWmU6VcTQ3d3yTUl/G7dSsWyPtKe8nnbjNDvyOSKfhodDBLC
   4e7X9Oe2ZtSc4nfiMTI8PUzGaOqCEEknqlyINTBqPLzft4OfocCiu5KMP
   A==;
X-CSE-ConnectionGUID: 9LSOKdnEQjOvMDnY6lRXqg==
X-CSE-MsgGUID: TTcf+nUgQv20zkwWECFACw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="12262895"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="12262895"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 09:43:29 -0700
X-CSE-ConnectionGUID: 4G1wLPpJRi6LxTgP/yNkSw==
X-CSE-MsgGUID: sMoAWuLtQwSZ7PmA8kwg3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43957080"
Received: from anagara1-mobl.amr.corp.intel.com (HELO [10.209.55.145]) ([10.209.55.145])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 09:43:29 -0700
Message-ID: <690de703aeee089f86beca5cb90d3d43dcd7df56.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Jan Kara <jack@suse.cz>, "Ma, Yu" <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, mjguzik@gmail.com, 
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com
Date: Wed, 26 Jun 2024 09:43:28 -0700
In-Reply-To: <20240626115427.d3x7g3bf6hdemlnq@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
	 <20240622154904.3774273-1-yu.ma@intel.com>
	 <20240622154904.3774273-2-yu.ma@intel.com>
	 <20240625115257.piu47hzjyw5qnsa6@quack3>
	 <20240625125309.y2gs4j5jr35kc4z5@quack3>
	 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
	 <20240626115427.d3x7g3bf6hdemlnq@quack3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 13:54 +0200, Jan Kara wrote:
>=20
>=20
> Indeed, thanks for correcting me! next_fd is just a lower bound for the
> first free fd.
>=20
> > The conditions
> > should either be like it is in patch or if (!start && !test_bit(0,
> > fdt->full_fds_bits)), the latter should also have the bitmap loading co=
st,
> > but another point is that a bit in full_fds_bits represents 64 bits in
> > open_fds, no matter fd >64 or not, full_fds_bits should be loaded any w=
ay,
> > maybe we can modify the condition to use full_fds_bits ?
>=20
> So maybe I'm wrong but I think the biggest benefit of your code compared =
to
> plain find_next_fd() is exactly in that we don't have to load full_fds_bi=
ts
> into cache. So I'm afraid that using full_fds_bits in the condition would
> destroy your performance gains. Thinking about this with a fresh head how
> about putting implementing your optimization like:
>=20
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtable *fdt=
, unsigned int start)
>         unsigned int maxbit =3D maxfd / BITS_PER_LONG;
>         unsigned int bitbit =3D start / BITS_PER_LONG;
> =20
> +       /*
> +        * Optimistically search the first long of the open_fds bitmap. I=
t
> +        * saves us from loading full_fds_bits into cache in the common c=
ase
> +        * and because BITS_PER_LONG > start >=3D files->next_fd, we have=
 quite
> +        * a good chance there's a bit free in there.
> +        */
> +       if (start < BITS_PER_LONG) {
> +               unsigned int bit;
> +
> +               bit =3D find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, =
start);

Say start is 31 (< BITS_PER_LONG)
bit found here could be 32 and greater than start.  Do we care if we return=
 bit > start?

Tim

> +               if (bit < BITS_PER_LONG)
> +                       return bit;
> +       }
> +
>         bitbit =3D find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit)=
 * BITS_PER_LONG;
>         if (bitbit >=3D maxfd)
>                 return maxfd;
>=20
> Plus your optimizations with likely / unlikely. This way the code flow in
> alloc_fd() stays more readable, we avoid loading the first open_fds long
> into cache if it is full, and we should get all the performance benefits?
>=20
> 								Honza
>=20
> =20
> > > > > +			goto fastreturn;
> > > > > +		}
> > > > >   		fd =3D find_next_fd(fdt, fd);
> > > > > +	}
> > > > > +
> > > > > +	if (unlikely(fd >=3D fdt->max_fds)) {
> > > > > +		error =3D expand_files(files, fd);
> > > > > +		if (error < 0)
> > > > > +			goto out;
> > > > > +		/*
> > > > > +		 * If we needed to expand the fs array we
> > > > > +		 * might have blocked - try again.
> > > > > +		 */
> > > > > +		if (error)
> > > > > +			goto repeat;
> > > > > +	}
> > > > > +fastreturn:
> > > > >   	/*
> > > > >   	 * N.B. For clone tasks sharing a files structure, this test
> > > > >   	 * will limit the total number of files that can be opened.
> > > > >   	 */
> > > > > -	error =3D -EMFILE;
> > > > > -	if (fd >=3D end)
> > > > > +	if (unlikely(fd >=3D end))
> > > > >   		goto out;
> > > > > -	error =3D expand_files(files, fd);
> > > > > -	if (error < 0)
> > > > > -		goto out;
> > > > > -
> > > > > -	/*
> > > > > -	 * If we needed to expand the fs array we
> > > > > -	 * might have blocked - try again.
> > > > > -	 */
> > > > > -	if (error)
> > > > > -		goto repeat;
> > > > > -
> > > > >   	if (start <=3D files->next_fd)
> > > > >   		files->next_fd =3D fd + 1;
> > > > > --=20
> > > > > 2.43.0
> > > > >=20
> > > > --=20
> > > > Jan Kara <jack@suse.com>
> > > > SUSE Labs, CR
> > > >=20
> >=20


