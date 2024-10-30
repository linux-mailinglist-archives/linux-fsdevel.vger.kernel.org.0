Return-Path: <linux-fsdevel+bounces-33238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940EE9B5BCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F4B2287F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A861D1F6B;
	Wed, 30 Oct 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QzlShpuI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542D63CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270264; cv=none; b=uhmS8ID/rKzpNn0uFM1VFsW0huLMLD08KoZ6JluBhIlobNYEEiR/QiYCm373Za1OmPcsFQJ9TFxehoLBpxREHmjGfNr9vugxwP/jbi6cOcKzCtPc/LOz3k2monitTjIskcFy1Bs89dIsVHzb8JeqT3i/l9ijgBAruvEdp2/CA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270264; c=relaxed/simple;
	bh=hmimsU+x1cu2VtOERVaUmRHZiJ0bC6RzjqhahQK6HvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd/JRDXgZJE6tJmnTtiBDnHBKg43QiEBCelTN8G+/Pn/WPVVliRrYvLyqW9pZUO6V854Lt/7CVeQNaoVt2pV3hv+jkeKwv5LQH6N4r5ub5tMLc25D74TcYWF2TqX87ECaDIpUJCp4fIet+4dUa9Mj1N0efIxT1Uy3tSxyGGXKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QzlShpuI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=CGS8Z3qJ72fjE7V3vNbEpqFKadKt3KedyyOxJIq4NHM=; b=QzlShpuIvOR3cJ8U9qMSx5+IzL
	tWO+ENgAhAHZWzxDMm4xUkzXRxlHX4TkpHazPHC3TLmo+U6BEshw69TT2R8JXQyb8eI/JeLJE4WJi
	3/jbCu98ZPbRYsOMtNQb5qbcpvel1zIZmm1eep97gOjtxA9EiA0HODjCr7kqDk8xq8n9+D+vsNayy
	o3o/5IxAFMDXWwEvyo2ZLxMasZhTgYXMqneYBrH6R56Ub9ZrbEgfhjaTca7zjZKfTqr3LSHkBrkUC
	I616WKW0gg6oOvYcJhLlR3LVTnsgzgzBRAZhWFv2xQZG1cNzXkiU3dIZb3wSFljREijQwre2rfJ/u
	MHPugljQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Ko-00000009N6U-1s8k;
	Wed, 30 Oct 2024 06:37:38 +0000
Date: Wed, 30 Oct 2024 06:37:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241030063738.GH1350452@ZenIV>
References: <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
 <20241019050322.GD1172273@ZenIV>
 <20241021-stornieren-knarren-df4ad3f4d7f5@brauner>
 <20241021170910.GB1350452@ZenIV>
 <20241021224313.GC1350452@ZenIV>
 <20241022-besten-beginnen-a2c5ffa6e7d7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022-besten-beginnen-a2c5ffa6e7d7@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 22, 2024 at 10:49:59AM +0200, Christian Brauner wrote:

> > 1) why is STATX_MNT_ID set without checking if it's in the mask passed to
> > the damn thing?
> 
> If you look at the history you'll find that STATX_MNT_ID has always been
> set unconditionally, i.e., userspace didn't have to request it
> explicitly. And that's fine. It's not like it's expensive.

Not the issue, really - the difference between the by-fd (when we call vfs_fstat())
and by-path (calling vfs_statx()) cases of vfs_fstatat() is what worries me.

In by-fd case you hit vfs_getattr() and that's it.  In by-path case you
hit exact same helper you do for statx(2), with STATX_BASIC_FLAGS for the
mask argument.  Which ends with vfs_getattr() + a bunch of followups in
vfs_statx_path().  _IF_ all those followups had been no-ops when mask
is just STATX_BASIC_FLAGS, everything would've been fine.  They are not,
though.

And while all current users of vfs_fstatat() ignore stat->attributes,
stat->attributes_mask and stat->mnt_id (as well as stat->result_mask),
that's a property of code we feed that struct kstat to after vfs_fstatat()
call has filled it.  Currently that's 9 functions, spread over a lot of
places.  Sure, each of those is fine, but any additional instance that does
care and we are getting an unpleasant inconsistency between by-fd and by-path
users.

Variants:

1) We can clone vfs_statx(), have the clone call vfs_getattr() instead
of vfs_statx_path() and use it in vfs_fstatat().  That would take care
of any future inconsistencies (as well as a minor side benefit of losing
request_mask argument in that thing).  OTOH, it's extra code duplication.

2) go for your "it's cheap anyway" and have vfs_fstatat() use
vfs_statx_fd(fd, flags, stat, STATX_BASIC_FLAGS) on the by-fd path.
Again, that restores consistency.  Cost: that extra work (tail of
vfs_statx_path()) done for fstat(2) just as it's currently done for
stat(2).

3) add an explicit "none of that fancy crap" flag argument to vfs_statx_path()
and pass it through vfs_statx().  Cost: extra argument passed through
the call chain.

And yes, it's all cheap, but {f,}stat(2) is often _very_ hot, so it's worth
getting right.


> > 2) why, in the name of everything unholy, does statx() on /dev/weird_shite
> > trigger modprobe on that thing?  Without even a permission check on it...
> 
> Block people should know. But afaict, that's a block device thing which
> happens with CONFIG_BLOCK_LEGACY_AUTOLOAD enabled which is supposedly
> deprecated.

Umm...  Deprecated or not, one generally expects that if /dev/foo is
owned by root:root with 0600 for permissions, then non-root won't be
able to trigger anything in the vicinity of the hardware in question,
including "load the driver"...  Note that open(2) won't get anywhere
near blkdev_open() - it will get EPERM before that.  stat(2) also
won't go there.  statx(2) will.  And frankly, getting the STATX_DIOALIGN
and STATX_WRITE_ATOMIC information out of such device is also somewhat
dubious, but that's less obviously wrong.

