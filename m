Return-Path: <linux-fsdevel+bounces-50113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B7AC84D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 01:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A85B179C9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706D3242928;
	Thu, 29 May 2025 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DP7urY4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05260610B;
	Thu, 29 May 2025 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748560225; cv=none; b=tevuhXbFwepYPzL21zU5Z6zymNw4yKnAXJsZjj60i25yqX+J86TFe+diub1M0tpMvc4wxV+FwMKloQQukF2ADa/tL+B2NRT+L/JPWxPm3+zZnDeULkVb+bfZsPsBxPocM9FDlyeVnoZAtAui0Cz2LvckHDK/XqpFkQRjkPJmkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748560225; c=relaxed/simple;
	bh=uFjp7SU8YEP82YOaIJFGFLpBgle1lTi5iLyd36oc6mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7rvmH5grvi9KcGqgE9vYwY34wdyZAjaChomu9Pw19V5OQLiwd1jnwrb8sU/GQV73rCHTmWgyuNOsJhWmo+IyPs4UXzZKqzi5WxY2JCWaeZWvL8XWW4KVwpof3M0cljFuDXXqVKeK/gEa3oxZkc5PI3H1JiYM1tBDL4TaU0zMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DP7urY4K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M2hE6XVOgu6lYN3x94mg3U8DaOZrftu1a2UwXyrz0Og=; b=DP7urY4K8Y5glUGrUOP+xuF0ls
	IW5g9yEzsYP86aiY11HyMIhVY5yEpo9ZoCtyVC3YD554vHM5GcJkAazctaB9rk4F/VgO2cFPf6ale
	09bdHWBRWxHWQWFtfzAFR+mjmjNehq2d+Fp//kVgyirE1mNGdcvdW4TbDNEPlux51ww2YXmcMqz0F
	vO0YStNXrni6a8zD1XGkO0VzXz0r8+tGv/kv0UdFTKqHxaDUom6hyFkhk2AOD0hMvAjGgnZBXBwex
	eCN5b+97ckPGxIIipHNWt2Bzd6g37v2eXBm3p57ZJzXE6vREgaZeAoV49XvgGVMbtUpA8l0TRtOLv
	VSZaYefw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKmOA-00000004ZQe-34xh;
	Thu, 29 May 2025 23:10:18 +0000
Date: Fri, 30 May 2025 00:10:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com,
	mic@digikod.net, gnoack@google.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250529231018.GP2023217@ZenIV>
References: <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV>
 <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
 <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 29, 2025 at 03:13:10PM -0700, Song Liu wrote:

> Is it an issue if we only hold a reference to a MNT_LOCKED mount for
> short period of time? "Short period" means it may get interrupted, page
> faults, or wait for an IO (read xattr), but it won't hold a reference to the
> mount and sleep indefinitely.

MNT_LOCKED mount itself is not a problem.  What shouldn't be done is
looking around in the mountpoint it covers.  It depends upon the things
you are going to do with that, but it's very easy to get an infoleak
that way.

> > OTOH, there's a good cause for moving some of the flags, MNT_LOCKED
> > included, out of ->mnt_flags and into a separate field in struct mount.
> > However, that would conflict with any code using that to deal with
> > your iterator safely.
> >
> > What's more, AFAICS in case of a stack of mounts each covering the root
> > of parent mount, you stop in each of those.  The trouble is, umount(2)
> > propagation logics assumes that intermediate mounts can be pulled out of
> > such stack without causing trouble.  For pathname resolution that is
> > true; it goes through the entire stack atomically wrt that stuff.
> > For your API that's not the case; somebody who has no idea about an
> > intermediate mount being there might get caught on it while it's getting
> > pulled from the stack.
> >
> > What exactly do you need around the mountpoint crossing?
> 
> I thought about skipping intermediate mounts (that are hidden by
> other mounts). AFAICT, not skipping them will not cause any issue.

It can.  Suppose e.g. that /mnt gets propagation from another namespace,
but not the other way round and you mount something on /mnt.

Later, in that another namespace, somebody mounts something on wherever
your /mnt gets propagation to.  A copy will be propagated _between_
your /mnt and whatever you've mounted on top of it; it will be entirely
invisible until you umount your /mnt.  At that point the propagated
copy will show up there, same as if it had appeared just after your
umount.  Prior to that it's entirely invisible.  If its original
counterpart in another namespace gets unmounted first, the copy will
be quietly pulled out.

Note that choose_mountpoint_rcu() callers (including choose_mountpoint())
will have mount_lock seqcount sampled before the traversal _and_ recheck
it after having reached the bottom of stack.  IOW, if you traverse ..
on the way to root, you won't get caught on the sucker being pulled out.

Your iterator, OTOH, would stop in that intermediate mount - and get
an unpleasant surprise when it comes back to do the next step (towards
/mnt on root filesystem, that is) and finds that path->mnt points
to something that is detached from everything - no way to get from
it any further.  That - despite the fact that location you've started
from is still mounted, still has the same pathname, etc. and nothing
had been disrupted for it.

And yes, landlock has a narrow race in the matching place.  Needs to
be fixed.  At least it does ignore those as far as any decisions are
concerned...

Note, BTW, that it might be better off by doing that similar to
d_path.c - without arseloads of dget_parent/dput et.al.; not sure
how feasible it is, but if everything in it can be done under
rcu_read_lock(), that's something to look into.

