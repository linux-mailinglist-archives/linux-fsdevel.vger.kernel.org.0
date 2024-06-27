Return-Path: <linux-fsdevel+bounces-22638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83D091AAF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436DDB28EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A53198A2B;
	Thu, 27 Jun 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpdSuyX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD9197A90;
	Thu, 27 Jun 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501395; cv=none; b=ji6Hd0dfzW+MNjB85zEHxbffwWSf/YSInrnhvAHuzjihxi2o/K7HDCqIhMYyKQQgmSnX0cKPIHeC2dG1z/Kq0GaRpAtyiXr5lzGYmA50mWjx5/bh1QA0g1wHRXY0Y1BtK6+04FwyFJuxaXSjSyuu+f7aGtTAryu73Pg77GRsPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501395; c=relaxed/simple;
	bh=wjjEufZ41AUoOLd05jyoxLk3rwtu6jIvnI98K2hPGkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntUNMfyeS1gJfHpwo8hFM7EFDieZuORGLevYZ7jz/wkAl00r5v/dV1krphtTxfRrjhWO9cjgzGjG43Kve4KDzNTr8BK+G7WB0XflEQWoCFD6Xt4lp/yxJ17ejj5BRI+prvNRtgEDmf/ua+17S/23OGCX7k9i5SfzrKVLliATCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpdSuyX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA09C2BBFC;
	Thu, 27 Jun 2024 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719501394;
	bh=wjjEufZ41AUoOLd05jyoxLk3rwtu6jIvnI98K2hPGkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpdSuyX2YlDJ2Tb7sFhdgY0lyTbfLDtzddZ4PVa5SLyWaJSI+TfFnV3xipBsEuFs8
	 EuXn4C+338qYjvdEwWadLta0PlgyFd4uN8QoR1eWudm0eIQuGyo4i8A+eqDBPAmT+P
	 H49er30u1jRBJ5oUYrnOx0AOoLSecdUBN7fjBROj0nqqCmry273f1MC102y28rr7CJ
	 xl0q+BOgxdAMPUdkouaDHkB/5WtaZIAR0IDAUYVpbx4ZzcbOhbIh24h+OoW0dt37kS
	 03RcbdqOrcZgzNLO78PSux+ilDex+jYauGMA2Krd5FgPXVdTt5sYh3utiNwiJave5I
	 nATmbqsTniCTQ==
Date: Thu, 27 Jun 2024 17:16:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Ian Kent <ikent@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, raven@themaw.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>, Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627115418.lcnpctgailhlaffc@quack3>

On Thu, Jun 27, 2024 at 01:54:18PM GMT, Jan Kara wrote:
> On Thu 27-06-24 09:11:14, Ian Kent wrote:
> > On 27/6/24 04:47, Matthew Wilcox wrote:
> > > On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
> > > > +++ b/fs/namespace.c
> > > > @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
> > > >   static DECLARE_RWSEM(namespace_sem);
> > > >   static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
> > > >   static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > > > +static bool lazy_unlock = false; /* protected by namespace_sem */
> > > That's a pretty ugly way of doing it.  How about this?
> > 
> > Ha!
> > 
> > That was my original thought but I also didn't much like changing all the
> > callers.
> > 
> > I don't really like the proliferation of these small helper functions either
> > but if everyone
> > 
> > is happy to do this I think it's a great idea.
> 
> So I know you've suggested removing synchronize_rcu_expedited() call in
> your comment to v2. But I wonder why is it safe? I *thought*
> synchronize_rcu_expedited() is there to synchronize the dropping of the
> last mnt reference (and maybe something else) - see the comment at the
> beginning of mntput_no_expire() - and this change would break that?

Yes. During umount mnt->mnt_ns will be set to NULL with namespace_sem
and the mount seqlock held. mntput() doesn't acquire namespace_sem as
that would get rather problematic during path lookup. It also elides
lock_mount_hash() by looking at mnt->mnt_ns because that's set to NULL
when a mount is actually unmounted.

So iirc synchronize_rcu_expedited() will ensure that it is actually the
system call that shuts down all the mounts it put on the umounted list
and not some other task that also called mntput() as that would cause
pretty blatant EBUSY issues.

So callers that come before mnt->mnt_ns = NULL simply return of course
but callers that come after mnt->mnt_ns = NULL will acquire
lock_mount_hash() _under_ rcu_read_lock(). These callers see an elevated
reference count and thus simply return while namespace_lock()'s
synchronize_rcu_expedited() prevents the system call from making
progress.

But I also don't see it working without risk even with MNT_DETACH. It
still has potential to cause issues in userspace. Any program that
always passes MNT_DETACH simply to ensure that even in the very rare
case that a mount might still be busy is unmounted might now end up
seeing increased EBUSY failures for mounts that didn't actually need to
be unmounted with MNT_DETACH. In other words, this is only inocuous if
userspace only uses MNT_DETACH for stuff they actually know is busy when
they're trying to unmount. And I don't think that's the case.

