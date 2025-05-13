Return-Path: <linux-fsdevel+bounces-48899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB6AB5774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5833B267A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4328C87E;
	Tue, 13 May 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gj3XyjEz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C801E5B65
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147390; cv=none; b=E71PxaIPVDjFjLO20zlhoJMCraw4OJwoi0xXCZ2zWfvwKu3L047NoA+32ps3IzLurMYx8UoIG0cSU+huJOAKt3oOGqPSzdAz64oq3RY8w5AWz3jlz95WJwxMucshwxN+jnBmprZ3PvJyFzr/fLGzJj4TW9EQjBZcgoTMXDd6HRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147390; c=relaxed/simple;
	bh=K4kcd1FYE6Qcv37fYbSljHtC9TN4iMyxcYCpixOSFxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ4xyaKVCFdkg6AX7PUzyLZFuZ1+3xKJmquyXCMntTALk2JusA03Aq+f0IA4R73B4ctdwaTjsfgDypI/VYdO+no0ztRZEpuGsfXeKN8lfFluFTxbr7KSXg4ZXkegWL4dsh7pPG1rcvX4i0+QBLIWzZM3QWgOyZJwZDUBxOIdYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gj3XyjEz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747147389; x=1778683389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K4kcd1FYE6Qcv37fYbSljHtC9TN4iMyxcYCpixOSFxE=;
  b=gj3XyjEz8GQEfa1yGlkwyLbp5jc1AuY8d2pxOjsocAiBIJIkbb7m35KN
   Ys/Px8uoOqMmA4Dgqx44P/9/o9jDhpYfJNQbaFazAbdaZ2z/iyWbOVn48
   Kd87J0U/CTHizBA+ceXNEmal8aVfoRBpxeVlCf+RoZFR+nlQl5oAXyHU1
   4NwuR3brhcKuffU1A2G0Xxm3yLIyRRGhk3iHuVlLLjen+N7KZYhiZrCY+
   s2VFTIeO8p/Qi/eW9LX7dX5pPADGDqXH1ZzRaENh8OYMFQqSbgpxDd+IP
   5zzJqsop/A6zTmJHS2vXugis6v1fWS5oqr5PDYLPO6ElvVesv9xyleii4
   A==;
X-CSE-ConnectionGUID: znTEdUjiQO+Im4b5Ap4wGA==
X-CSE-MsgGUID: e5uTarJ6Rgy+7FtDAlP7jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66545559"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="66545559"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:43:08 -0700
X-CSE-ConnectionGUID: 3ncQer10RjyVRzbDTm/L4A==
X-CSE-MsgGUID: mzCOl3BBRASuf0P6XrQlcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="142845184"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.35.3])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:43:07 -0700
Date: Tue, 13 May 2025 22:33:23 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, yi1.lai@intel.com
Subject: Re: [PATCH 3/4] do_move_mount(): don't leak MNTNS_PROPAGATING on
 failures
Message-ID: <aCNYM7XAXBXTdo9G@ly-workstation>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
 <20250508200211.GF2023217@ZenIV>
 <aCMm8r48BuZ8+DTo@ly-workstation>
 <20250513120858.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513120858.GG2023217@ZenIV>

On Tue, May 13, 2025 at 01:08:58PM +0100, Al Viro wrote:
> On Tue, May 13, 2025 at 07:03:14PM +0800, Lai, Yi wrote:
> > Hi Al Viro,
> > 
> > Greetings!
> > 
> > I used Syzkaller and found that there is general protection fault in do_move_mount in linux v6.15-rc6.
> > 
> > After bisection and the first bad commit is:
> > "
> > 267fc3a06a37 do_move_mount(): don't leak MNTNS_PROPAGATING on failures
> > "
> > 
> > All detailed into can be found at:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount
> > Syzkaller repro code:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/repro.c
> > Syzkaller repro syscall steps:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/repro.prog
> > Syzkaller report:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/repro.report
> > Kconfig(make olddefconfig):
> > https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/kconfig_origin
> > Bisect info:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/bisect_info.log
> > bzImage:
> > https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250513_095133_do_move_mount/bzImage_82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
> > Issue dmesg:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/250513_095133_do_move_mount/bzImage_82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
> 
> Are you sure that stack traces are from the same reproducer?  Because they
> look nothing like what it's doing...
>

Yes. The reproducer causes the OOP in do_move_mount().
> I'm pretty sure I see the problem there, but I don't see how it could
> fail to oops right in do_move_mount() itself if triggered...
> 
> As a quick check, could you see if the same kernel + diff below still
> gives the same report?
> 

After applying the diff, the issue cannot be reproduced.
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1b466c54a357..a5983726e51d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3722,7 +3722,7 @@ static int do_move_mount(struct path *old_path,
>  	if (attached)
>  		put_mountpoint(old_mp);
>  out:
> -	if (is_anon_ns(ns))
> +	if (!IS_ERR_OR_NULL(ns) && is_anon_ns(ns))
>  		ns->mntns_flags &= ~MNTNS_PROPAGATING;
>  	unlock_mount(mp);
>  	if (!err) {

