Return-Path: <linux-fsdevel+bounces-57979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1363B276AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 05:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594DA16F4B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 03:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812D296148;
	Fri, 15 Aug 2025 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSe4YfHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D51C5D77
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227979; cv=none; b=inhYTs3wPi9zzzNyXrOfY4pYKewDqEOedOm9BbllUiaPXIp0mbxYnO34CLJ4Xv7zYUX5DdJMPWFEXeaFsfib/HjcQqjuI60FEWnpmyZlsCBLA85P0IC5ozSuGVPNodXMLCpB0XaNjJZHzpMlvcqFXniNHWxXkONHsYAoNDrzlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227979; c=relaxed/simple;
	bh=lqpDLYaw52mUtUuCc1h7LX26PmiquULT03cQeR3XKhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZXalcX8TbIJ5kl7ephy2armwUUvEXfSefTYqovGL5OVMusELnkRWloppFwf5Th9IXQMBBy7dO/7LyPT62zUf5i75Wy7Do7ae879JPAcQ3pYC+x5OUVgh2+vipjqwfZ1LOpk0cA4klDLhuloJCxckTqpvKXmjnkgQQL6tTY3uUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSe4YfHO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755227977; x=1786763977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lqpDLYaw52mUtUuCc1h7LX26PmiquULT03cQeR3XKhw=;
  b=SSe4YfHOdZf2eNsihLA0Ha4ogeoRjxLzBXkMdxUcDBvHc4sDsA1F3yZ0
   8wYLB/L+AkB2YlcVA+8i3bEk9+gzDtUdS1Hjz4oLhgPf6/3UU96MYKX/J
   0xGfFpbZwAr5W8uUMJk6dLNR9ZilmvpqRebNd3pnBaptNlCGjgI0/M0fX
   IYN5/V3oSRDiNOkxEa5/jYAr8Ds49TDdSyVYD2ZceAtLeGt4bEEIGADxY
   pOpsSfcS7WGCnIIzWr94Tu+lrFarVqXrRQF9ajQj8Gdutp0QY1Ckubt8u
   NTkU54N/yLZJjV6KpgDfbKyTiyy9IMv0Cs94auGTnrhMsGQOMqKlJEeeH
   Q==;
X-CSE-ConnectionGUID: FQn9tjM2Q5CtGOPJoQf6YA==
X-CSE-MsgGUID: 1JpDJLZ5QwiVI4SFyhF1Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="69007114"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="69007114"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:19:36 -0700
X-CSE-ConnectionGUID: uPFYWGINRxCDnLtndWdzQA==
X-CSE-MsgGUID: j1uKGlAAT6qGpIuGKXimtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166138269"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.53])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:19:34 -0700
Date: Fri, 15 Aug 2025 11:19:31 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, yi1.lai@intel.com,
	ebiederm@xmission.com, jack@suse.cz, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 44/48] copy_tree(): don't link the mounts via mnt_list
Message-ID: <aJ6nQzZx6/pWou/j@ly-workstation>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
 <20250630025255.1387419-44-viro@zeniv.linux.org.uk>
 <aJw0hU0u9smq8aHq@ly-workstation>
 <20250813071303.GH222315@ZenIV>
 <20250813073224.GI222315@ZenIV>
 <20250814232114.GQ222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814232114.GQ222315@ZenIV>

On Fri, Aug 15, 2025 at 12:21:14AM +0100, Al Viro wrote:
> On Wed, Aug 13, 2025 at 08:32:24AM +0100, Al Viro wrote:
> > On Wed, Aug 13, 2025 at 08:13:03AM +0100, Al Viro wrote:
> > > On Wed, Aug 13, 2025 at 02:45:25PM +0800, Lai, Yi wrote:
> > > > Syzkaller repro code:
> > > > https://github.com/laifryiee/syzkaller_logs/tree/main/250813_093835_attach_recursive_mnt/repro.c
> > > 
> > > 404: The main branch of syzkaller_logs does not contain the path 250813_093835_attach_recursive_mnt/repro.c.
> > 
> > https://github.com/laifryiee/syzkaller_logs/blob/main/250813_093835_attach_recursive_mnt/repro.c
> > 
> > does get it...  Anyway, I'm about to fall down right now (half past 3am here),
> > will take a look once I get some sleep...
> 
> OK, I think I understand what's going on there.  FWIW, reproducer can be
> greatly simplified:
> 
> cd /tmp
> mkdir a
> mount --bind a a
> mount --make-shared a
> while mount --bind a a do echo splat; done
> 
> Beginning of that thing is to make it possible to clean the resulting mess
> out, when after about 16 iterations you run out of limit on the number of
> mounts - you are explicitly asking to double the number under /tmp/a
> on each iteration.  And default /proc/sys/fs/mount-max is set to 100000...
> 
> As for cleaning up, umount2("/tmp/a", MNT_DETACH); will do it...
> 
> The minimal fix should be to do commit_tree() just *before* the preceding
> if (q) {...} in attach_recursive_mnt().
> 
> Said that, this is not the only problem exposed by that reproducer - with
> that kind of long chain of overmounts, all peers to each other, we hit
> two more stupidities on the umount side - reparent() shouldn't fucking
> bother if the overmount is also going to be taken out and change_mnt_type()
> only needs to look for propagation source if the victim has slaves (those
> will need to be moved to new master) *or* if the victim is getting turned
> into a slave.
> 
> See if the following recovers the performance:
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a191c6519e36..88db58061919 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1197,10 +1197,7 @@ static void commit_tree(struct mount *mnt)
>  
>  	if (!mnt_ns_attached(mnt)) {
>  		for (struct mount *m = mnt; m; m = next_mnt(m, mnt))
> -			if (unlikely(mnt_ns_attached(m)))
> -				m = skip_mnt_tree(m);
> -			else
> -				mnt_add_to_ns(n, m);
> +			mnt_add_to_ns(n, m);
>  		n->nr_mounts += n->pending_mounts;
>  		n->pending_mounts = 0;
>  	}
> @@ -2704,6 +2701,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  			lock_mnt_tree(child);
>  		q = __lookup_mnt(&child->mnt_parent->mnt,
>  				 child->mnt_mountpoint);
> +		commit_tree(child);
>  		if (q) {
>  			struct mountpoint *mp = root.mp;
>  			struct mount *r = child;
> @@ -2713,7 +2711,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  				mp = shorter;
>  			mnt_change_mountpoint(r, mp, q);
>  		}
> -		commit_tree(child);
>  	}
>  	unpin_mountpoint(&root);
>  	unlock_mount_hash();
> diff --git a/fs/pnode.c b/fs/pnode.c
> index 81f7599bdac4..040a8559b8f5 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -111,7 +111,8 @@ void change_mnt_propagation(struct mount *mnt, int type)
>  		return;
>  	}
>  	if (IS_MNT_SHARED(mnt)) {
> -		m = propagation_source(mnt);
> +		if (type == MS_SLAVE || !hlist_empty(&mnt->mnt_slave_list))
> +			m = propagation_source(mnt);
>  		if (list_empty(&mnt->mnt_share)) {
>  			mnt_release_group_id(mnt);
>  		} else {
> @@ -595,6 +596,8 @@ static void reparent(struct mount *m)
>  	struct mount *p = m;
>  	struct mountpoint *mp;
>  
> +	if (will_be_unmounted(m))
> +		return;
>  	do {
>  		mp = p->mnt_mp;
>  		p = p->mnt_parent;

After applying this patch on top of linux-next, issue cannot be reproduced.

Regards,
Yi Lai


