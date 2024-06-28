Return-Path: <linux-fsdevel+bounces-22768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3536D91BF14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D362853ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 12:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E611BE234;
	Fri, 28 Jun 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIG+wuYo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092E4C3BE;
	Fri, 28 Jun 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579273; cv=none; b=J3hRxj9kc4c6SEQzg2rcglsYql9exew6QHN018bJhc+nGPBox/4Cd2c8VZ3835pynO5jvoKbx4tSJlYRzF3bT1k+Nedqe3ZI8ey/04bXcDSvbR5rZpyTjA2jjA1cq8iEeC+RA7GHLbVqWbOel/5EPreJRY8AGFda7jnHG8JeIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579273; c=relaxed/simple;
	bh=T5ZiFqiiahTf0Z+foH93BsTf+Jw1dMPer/7O4oy2z5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9bVTB6ctStAm96AVmsq/ASJHwlXsqDVVuqsjIYy6r0eGeK0/Noa7LdXSKs4AllI6ncZycrheNvjy/t17lntWh8fJOjCwwBA3KofEQndPAGO5sDYf/ZFILtvCqTPLYv6TI9FzkTIwNuJcs4B9CnJ1fah/770EFAsz/R/d8by9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIG+wuYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7919CC116B1;
	Fri, 28 Jun 2024 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719579273;
	bh=T5ZiFqiiahTf0Z+foH93BsTf+Jw1dMPer/7O4oy2z5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIG+wuYoEequKJNofhPtykiiv4T2PXApI8UT87e60SQ7YyR0aOZwnHq1eSXwVTqwa
	 ZLdkEyc70XkIGuRUhNMA8V3+SYVVsV/4x9isg4SZWH/GWjHJh93HXzxaER20xr13Q9
	 7GSnAO10++PNJY+rXosfEm8/z2+//HNPK+V3k9CmHjIeLy1wo4octhWbhO5ebVMy9a
	 AFU9b7GC9xc35JIA1O2For1RUDfsHdOggwSZ07DWM4Kot4s60G1joiL09BBoV7AfDN
	 kbabwETJsQG73rKsgkDEq9Dkk5E9CYQncEOtg5wtP6fu/W29i2x9NOcAVw69UUyBv+
	 45ZJqFa8/1uEg==
Date: Fri, 28 Jun 2024 14:54:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <ikent@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, raven@themaw.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>, Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240628-gelingen-erben-0f6e14049e68@brauner>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>

On Fri, Jun 28, 2024 at 11:17:43AM GMT, Ian Kent wrote:
> 
> On 27/6/24 23:16, Christian Brauner wrote:
> > On Thu, Jun 27, 2024 at 01:54:18PM GMT, Jan Kara wrote:
> > > On Thu 27-06-24 09:11:14, Ian Kent wrote:
> > > > On 27/6/24 04:47, Matthew Wilcox wrote:
> > > > > On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
> > > > > > +++ b/fs/namespace.c
> > > > > > @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
> > > > > >    static DECLARE_RWSEM(namespace_sem);
> > > > > >    static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
> > > > > >    static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > > > > > +static bool lazy_unlock = false; /* protected by namespace_sem */
> > > > > That's a pretty ugly way of doing it.  How about this?
> > > > Ha!
> > > > 
> > > > That was my original thought but I also didn't much like changing all the
> > > > callers.
> > > > 
> > > > I don't really like the proliferation of these small helper functions either
> > > > but if everyone
> > > > 
> > > > is happy to do this I think it's a great idea.
> > > So I know you've suggested removing synchronize_rcu_expedited() call in
> > > your comment to v2. But I wonder why is it safe? I *thought*
> > > synchronize_rcu_expedited() is there to synchronize the dropping of the
> > > last mnt reference (and maybe something else) - see the comment at the
> > > beginning of mntput_no_expire() - and this change would break that?
> > Yes. During umount mnt->mnt_ns will be set to NULL with namespace_sem
> > and the mount seqlock held. mntput() doesn't acquire namespace_sem as
> > that would get rather problematic during path lookup. It also elides
> > lock_mount_hash() by looking at mnt->mnt_ns because that's set to NULL
> > when a mount is actually unmounted.
> > 
> > So iirc synchronize_rcu_expedited() will ensure that it is actually the
> > system call that shuts down all the mounts it put on the umounted list
> > and not some other task that also called mntput() as that would cause
> > pretty blatant EBUSY issues.
> > 
> > So callers that come before mnt->mnt_ns = NULL simply return of course
> > but callers that come after mnt->mnt_ns = NULL will acquire
> > lock_mount_hash() _under_ rcu_read_lock(). These callers see an elevated
> > reference count and thus simply return while namespace_lock()'s
> > synchronize_rcu_expedited() prevents the system call from making
> > progress.
> > 
> > But I also don't see it working without risk even with MNT_DETACH. It
> > still has potential to cause issues in userspace. Any program that
> > always passes MNT_DETACH simply to ensure that even in the very rare
> > case that a mount might still be busy is unmounted might now end up
> > seeing increased EBUSY failures for mounts that didn't actually need to
> > be unmounted with MNT_DETACH. In other words, this is only inocuous if
> > userspace only uses MNT_DETACH for stuff they actually know is busy when
> > they're trying to unmount. And I don't think that's the case.
> > 
> I'm sorry but how does an MNT_DETACH umount system call return EBUSY, I
> can't
> 
> see how that can happen?

Not the umount() call is the problem. Say you have the following
sequence:

(1) mount(ext4-device, /mnt)
    umount(/mnt, 0)
    mount(ext4-device, /mnt)

If that ext4 filesystem isn't in use anymore then umount() will succeed.
The same task can immediately issue a second mount() call on the same
device and it must succeed.

Today the behavior for this is the same whether or no the caller uses
MNT_DETACH. So:

(2) mount(ext4-device, /mnt)
    umount(/mnt, MNT_DETACH)
    mount(ext4-device, /mnt)

All that MNT_DETACH does is to skip the check for busy mounts otherwise
it's identical to a regular umount. So (1) and (2) will behave the same
as long as the filesystem isn't used anymore.

But afaict with your changes this wouldn't be true anymore. If someone
uses (2) on a filesystem that isn't busy then they might end up getting
EBUSY on the second mount. And if I'm right then that's potentially a
rather visible change.

