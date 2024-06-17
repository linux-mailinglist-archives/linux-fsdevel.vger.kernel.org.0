Return-Path: <linux-fsdevel+bounces-21844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639D890B894
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 19:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BD2285504
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7FB1922D3;
	Mon, 17 Jun 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJKuA1wC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1116CD3D;
	Mon, 17 Jun 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646920; cv=none; b=pA51l2/OkpPX2zoyCCH0CZ7ARLh/W06GIbkSQidFjesFMpcCbvIaigFe0zNRyh7nhyd8loWlP5kSsULafK23eWwbSv0ZSQnMT1t+XXE6o9zqaEqhHMXi54GHQM97cxIDjT58gRk/CdFoSMe2SZHrxSnsCFK8Pv0rJW9mypHnUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646920; c=relaxed/simple;
	bh=/MKX8zWua164F+o5W2SmDmo38TgloRooE2/wMgG4hOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sy4wFMJrnzlInnvrZN/Aj9XmOJkgkQvwetJWap1m2/2aQb/lm1Jw8vpDPZhvZq1UrSZ1SfVx4QT9lVu7U6V0GKY+2kNV1Nzx0SyZfEr238lmOxEzr2ibL/sOaQTHaWxilNS4F8YM27OAV3DG7msVFxr/c4CqM8aPptrrApMQ6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJKuA1wC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718646919; x=1750182919;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/MKX8zWua164F+o5W2SmDmo38TgloRooE2/wMgG4hOc=;
  b=XJKuA1wCotKDqGCim2jZl4zFfDWaLyJGfM0pbndzVuiED0Wiq9HJQkfP
   VUkWg2zqHvxbgkz99QamTWYICq4vI+gLNdXk/l5jhzWcRZCI66VU5krNG
   53RnIAGyEixL4Vq/xMlre/UNDLFE3UHjsXiile+w/wt02XP6Vtf4+VVFX
   rveS3+qe/FpeSGyJ59Dn9cN5ctPERjWlYMDvztWaPmeM68sAfOi60ESNO
   sEcEh/rwWb/AsSthyo6TrOk4cJVyxgPq1HE885WOkLtwjkxDGHPHbNnHl
   SA8if+/1PoOxwrx9svDi0fSA5YV/YxbfzmC+Wx9iUVEXNaDGh5O3qU+u2
   A==;
X-CSE-ConnectionGUID: d2I3aOgpTnGSkxoGcu4UBA==
X-CSE-MsgGUID: DmfnGH7mSVOA5CnRppCU3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15454769"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15454769"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:55:18 -0700
X-CSE-ConnectionGUID: a6YoO4xoQG2b7gX3udiXMQ==
X-CSE-MsgGUID: rONlxxEqQQyd+C4MCtn4gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41198172"
Received: from schen9-mobl2.jf.intel.com (HELO [10.24.8.70]) ([10.24.8.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:55:18 -0700
Message-ID: <fd4eb382a87baed4b49e3cf2cd25e7047f9aede2.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Date: Mon, 17 Jun 2024 10:55:17 -0700
In-Reply-To: <lzotoc5jwq4o4oij26tnzm5n2sqwqgw6ve2yr3vb4rz2mg4cee@iysfvyt77gkx>
References: <20240614163416.728752-1-yu.ma@intel.com>
	 <20240614163416.728752-4-yu.ma@intel.com>
	 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
	 <lzotoc5jwq4o4oij26tnzm5n2sqwqgw6ve2yr3vb4rz2mg4cee@iysfvyt77gkx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 07:07 +0200, Mateusz Guzik wrote:
> On Sat, Jun 15, 2024 at 06:41:45AM +0200, Mateusz Guzik wrote:
> > On Fri, Jun 14, 2024 at 12:34:16PM -0400, Yu Ma wrote:
> > > alloc_fd() has a sanity check inside to make sure the FILE object map=
ping to the
> >=20
> > Total nitpick: FILE is the libc thing, I would refer to it as 'struct
> > file'. See below for the actual point.
> >=20
> > > Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read impro=
ved by
> > > 32%, write improved by 15% on Intel ICX 160 cores configuration with =
v6.8-rc6.
> > >=20
> > > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > > ---
> > >  fs/file.c | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/fs/file.c b/fs/file.c
> > > index a0e94a178c0b..59d62909e2e3 100644
> > > --- a/fs/file.c
> > > +++ b/fs/file.c
> > > @@ -548,13 +548,6 @@ static int alloc_fd(unsigned start, unsigned end=
, unsigned flags)
> > >  	else
> > >  		__clear_close_on_exec(fd, fdt);
> > >  	error =3D fd;
> > > -#if 1
> > > -	/* Sanity check */
> > > -	if (rcu_access_pointer(fdt->fd[fd]) !=3D NULL) {
> > > -		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> > > -		rcu_assign_pointer(fdt->fd[fd], NULL);
> > > -	}
> > > -#endif
> > > =20
> >=20
> > I was going to ask when was the last time anyone seen this fire and
> > suggest getting rid of it if enough time(tm) passed. Turns out it does
> > show up sometimes, latest result I found is 2017 vintage:
> > https://groups.google.com/g/syzkaller-bugs/c/jfQ7upCDf9s/m/RQjhDrZ7AQAJ
> >=20
> > So you are moving this to another locked area, but one which does not
> > execute in the benchmark?
> >=20
> > Patch 2/3 states 28% read and 14% write increase, this commit message
> > claims it goes up to 32% and 15% respectively -- pretty big. I presume
> > this has to do with bouncing a line containing the fd.
> >=20
> > I would argue moving this check elsewhere is about as good as removing
> > it altogether, but that's for the vfs overlords to decide.
> >=20
> > All that aside, looking at disasm of alloc_fd it is pretty clear there
> > is time to save, for example:
> >=20
> > 	if (unlikely(nr >=3D fdt->max_fds)) {
> > 		if (fd >=3D end) {
> > 			error =3D -EMFILE;
> > 			goto out;
> > 		}
> > 		error =3D expand_files(fd, fd);
> > 		if (error < 0)
> > 			goto out;
> > 		if (error)
> > 			goto repeat;
> > 	}
> >=20
>=20
> Now that I wrote it I noticed the fd < end check has to be performed
> regardless of max_fds -- someone could have changed rlimit to a lower
> value after using a higher fd. But the main point stands: the call to
> expand_files and associated error handling don't have to be there.

To really prevent someone from mucking with rlimit, we should probably
take the task_lock to prevent do_prlimit() racing with this function.

task_lock(current->group_leader);

Tim

>=20
> > This elides 2 branches and a func call in the common case. Completely
> > untested, maybe has some brainfarts, feel free to take without credit
> > and further massage the routine.
> >=20
> > Moreover my disasm shows that even looking for a bit results in
> > a func call(!) to _find_next_zero_bit -- someone(tm) should probably
> > massage it into another inline.
> >=20
> > After the above massaging is done and if it turns out the check has to
> > stay, you can plausibly damage-control it with prefetch -- issue it
> > immediately after finding the fd number, before any other work.
> >=20
> > All that said, by the above I'm confident there is still *some*
> > performance left on the table despite the lock.
> >=20
> > >  out:
> > >  	spin_unlock(&files->file_lock);
> > > @@ -572,7 +565,7 @@ int get_unused_fd_flags(unsigned flags)
> > >  }
> > >  EXPORT_SYMBOL(get_unused_fd_flags);
> > > =20
> > > -static void __put_unused_fd(struct files_struct *files, unsigned int=
 fd)
> > > +static inline void __put_unused_fd(struct files_struct *files, unsig=
ned int fd)
> > >  {
> > >  	struct fdtable *fdt =3D files_fdtable(files);
> > >  	__clear_open_fd(fd, fdt);
> > > @@ -583,7 +576,12 @@ static void __put_unused_fd(struct files_struct =
*files, unsigned int fd)
> > >  void put_unused_fd(unsigned int fd)
> > >  {
> > >  	struct files_struct *files =3D current->files;
> > > +	struct fdtable *fdt =3D files_fdtable(files);
> > >  	spin_lock(&files->file_lock);
> > > +	if (unlikely(rcu_access_pointer(fdt->fd[fd]))) {
> > > +		printk(KERN_WARNING "put_unused_fd: slot %d not NULL!\n", fd);
> > > +		rcu_assign_pointer(fdt->fd[fd], NULL);
> > > +	}
> > >  	__put_unused_fd(files, fd);
> > >  	spin_unlock(&files->file_lock);
> > >  }
>=20


