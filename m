Return-Path: <linux-fsdevel+bounces-21847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD890B90E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 20:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AE11C23C7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB4198856;
	Mon, 17 Jun 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2Jm1Ycf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55979198826;
	Mon, 17 Jun 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647491; cv=none; b=nB9u4NmNpobC/QvdLofSDe12KWxyGhm97DeGade8KTyXrgRtN78K7QS2Ap3kRulm5oDUi9w5Gcm2PImaVwmlRWZC9t9a1p+EyPikZIzDgWM5C1rtANM8Kue66r63emmnaKyGYjd1s7PdXB+kNGookkO1Wp3iP5KHX4ZPYVFhdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647491; c=relaxed/simple;
	bh=/PiP6ISTK77HZuQsk5qCo7feUbQOYQc0dfx+xjlirGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PBa2Ow3g1kVYdN8bRoJzaDgnFx3jP98trmmYELCSw2jRR3tgCgwjaFXhjhLIeSEW21GCWL4iui9C5b+E144+Eok/WdvBP+EbYKkTph5/tVleeUt7Q/rTRawU0P4+veKdL0tDEV7ng9ZGDRup+SLm9V8Z3jTnEAQUacaF4qUlov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2Jm1Ycf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718647491; x=1750183491;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/PiP6ISTK77HZuQsk5qCo7feUbQOYQc0dfx+xjlirGw=;
  b=e2Jm1Ycf+l37NQKhPOmVYDGEuRw+kfTZVpPhYWFxTon8XQEfBb+C7yoU
   nBhnVHRETRkDt4khK7SGnfQwK1oTz6cKm/ZNm2Wier6a71fWTT2/PP64w
   +PGbpVFQAsUOMUuEfhqRsD9iZOJw9RZy6/N2YsZMbbltGY0Ji0g9/tilN
   6gVT/D8kApYfUXtpflgHqGv0ZhAcJE6naab6G0+SYtW9zUktiC49sx52g
   uPm6DF81AxUzGbKtWJF2Z2JbslMcvV86mzesCCeiZQfX2QTZhjBIEric0
   ooSBg90idehn8ZpNdB6+zW3zNuNH0bxmlzsxzP4CGCpTgL/nKz8Yh0+yk
   A==;
X-CSE-ConnectionGUID: GdUmT9UrTouDNghkt8GLIQ==
X-CSE-MsgGUID: q9VXsCfSQQ2eDOxsgiXIEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15258518"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15258518"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:04:50 -0700
X-CSE-ConnectionGUID: BMfcN9DrQHOFwz2LELqXmw==
X-CSE-MsgGUID: EJrbztOpSJyYMh541vuh1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="46389757"
Received: from schen9-mobl2.jf.intel.com (HELO [10.24.8.70]) ([10.24.8.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:04:41 -0700
Message-ID: <8fa3f49b50515f8490acfe5b52aaf3aba0a36606.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Date: Mon, 17 Jun 2024 11:04:41 -0700
In-Reply-To: <fd4eb382a87baed4b49e3cf2cd25e7047f9aede2.camel@linux.intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
	 <20240614163416.728752-4-yu.ma@intel.com>
	 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
	 <lzotoc5jwq4o4oij26tnzm5n2sqwqgw6ve2yr3vb4rz2mg4cee@iysfvyt77gkx>
	 <fd4eb382a87baed4b49e3cf2cd25e7047f9aede2.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 10:55 -0700, Tim Chen wrote:
> On Sat, 2024-06-15 at 07:07 +0200, Mateusz Guzik wrote:
> > On Sat, Jun 15, 2024 at 06:41:45AM +0200, Mateusz Guzik wrote:
> > > On Fri, Jun 14, 2024 at 12:34:16PM -0400, Yu Ma wrote:
> > > > alloc_fd() has a sanity check inside to make sure the FILE object m=
apping to the
> > >=20
> > >=20
> >=20
> > Now that I wrote it I noticed the fd < end check has to be performed
> > regardless of max_fds -- someone could have changed rlimit to a lower
> > value after using a higher fd. But the main point stands: the call to
> > expand_files and associated error handling don't have to be there.
>=20
> To really prevent someone from mucking with rlimit, we should probably
> take the task_lock to prevent do_prlimit() racing with this function.
>=20
> task_lock(current->group_leader);
>=20
> Tim


And also move the task_lock in do_prlimit() before the RLIMIT_NOFILE check.

diff --git a/kernel/sys.c b/kernel/sys.c
index 3a2df1bd9f64..b4e523728c3e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1471,6 +1471,7 @@ static int do_prlimit(struct task_struct *tsk, unsign=
ed int resource,
                return -EINVAL;
        resource =3D array_index_nospec(resource, RLIM_NLIMITS);
=20
+       task_lock(tsk->group_leader);
        if (new_rlim) {
                if (new_rlim->rlim_cur > new_rlim->rlim_max)
                        return -EINVAL;
@@ -1481,7 +1482,6 @@ static int do_prlimit(struct task_struct *tsk, unsign=
ed int resource,
=20
        /* Holding a refcount on tsk protects tsk->signal from disappearing=
. */
        rlim =3D tsk->signal->rlim + resource;
-       task_lock(tsk->group_leader);
        if (new_rlim) {
                /*
                 * Keep the capable check against init_user_ns until cgroup=
s can

Tim
> >=20
> > > This elides 2 branches and a func call in the common case. Completely
> > > untested, maybe has some brainfarts, feel free to take without credit
> > > and further massage the routine.
> > >=20
> > > Moreover my disasm shows that even looking for a bit results in
> > > a func call(!) to _find_next_zero_bit -- someone(tm) should probably
> > > massage it into another inline.
> > >=20
> > > After the above massaging is done and if it turns out the check has t=
o
> > > stay, you can plausibly damage-control it with prefetch -- issue it
> > > immediately after finding the fd number, before any other work.
> > >=20
> > > All that said, by the above I'm confident there is still *some*
> > > performance left on the table despite the lock.
> > >=20
> > > >  out:
> > > >  	spin_unlock(&files->file_lock);
> > > > @@ -572,7 +565,7 @@ int get_unused_fd_flags(unsigned flags)
> > > >  }
> > > >  EXPORT_SYMBOL(get_unused_fd_flags);
> > > > =20
> > > > -static void __put_unused_fd(struct files_struct *files, unsigned i=
nt fd)
> > > > +static inline void __put_unused_fd(struct files_struct *files, uns=
igned int fd)
> > > >  {
> > > >  	struct fdtable *fdt =3D files_fdtable(files);
> > > >  	__clear_open_fd(fd, fdt);
> > > > @@ -583,7 +576,12 @@ static void __put_unused_fd(struct files_struc=
t *files, unsigned int fd)
> > > >  void put_unused_fd(unsigned int fd)
> > > >  {
> > > >  	struct files_struct *files =3D current->files;
> > > > +	struct fdtable *fdt =3D files_fdtable(files);
> > > >  	spin_lock(&files->file_lock);
> > > > +	if (unlikely(rcu_access_pointer(fdt->fd[fd]))) {
> > > > +		printk(KERN_WARNING "put_unused_fd: slot %d not NULL!\n", fd);
> > > > +		rcu_assign_pointer(fdt->fd[fd], NULL);
> > > > +	}
> > > >  	__put_unused_fd(files, fd);
> > > >  	spin_unlock(&files->file_lock);
> > > >  }
> >=20
>=20


