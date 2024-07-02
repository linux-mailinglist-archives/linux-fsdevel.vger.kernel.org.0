Return-Path: <linux-fsdevel+bounces-22910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD691EDF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 06:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5251282ADF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 04:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB8A3D0D0;
	Tue,  2 Jul 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBmJWKUT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C43211;
	Tue,  2 Jul 2024 04:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719895808; cv=none; b=cIip629gH8hqQCWsWbmJocM9ErBAyp7nCzCSvW++Jo6O0ouGf5GZ7DKeCL6eTGOrZhJk44NV9TEWmMlRziFC0AHSBfcILX5qV2XeNJ81kBvwp7DRvKX6EYe63/w5GvNmqXCRhQDIhKIBksu47eUVRG5JAw1d2WdZZNEUdzbr1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719895808; c=relaxed/simple;
	bh=cWdaJVgiIgCz72RgaamzM5zQYGzPUHCAk7zYeXdbHIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2HcS2JHV6EJ9kzzFG+ivvN/cavZbSZk3AAqi8ReFLpfLNceDgxKI6TkE3jAjlw4hSvCdvG2A9E6bWJvOtGIaopMwvEmc6RNKVFdV1rc5WoeYBDVWBYPljPB9VV20ChyrSw8JP4bxYEs+C64ScpVTKSsI5L67mvofcufv7HZSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBmJWKUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978CAC116B1;
	Tue,  2 Jul 2024 04:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719895808;
	bh=cWdaJVgiIgCz72RgaamzM5zQYGzPUHCAk7zYeXdbHIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBmJWKUTctfthdK7mGatvHKM7E5MN2+xZah+VxoXXVGwS6UrTLJuAVe4dJ8Vnj/nQ
	 vrFuoOT+Qp3qLnfTTL/eP07djR9ehp2U27fe2vy2qTM+9HLFE/nQx9ecFuLIXG+NSe
	 oQUyiWpmopD5Lu5yQhQAG38m+e+WWNiZ9psyzse+I0etWcAWcE+CSMwjUoloA0a1GJ
	 oVP66lYSFUl7hpuVkSax5F2rq9mXNC1/ODctwnm9jZhBqRhovq7iLvk4t1fGMQaBSt
	 dGotrlmtcT3QrFe/brnacu0GVMTEgz0olcdbAFRu+4QYQHv7MfxjN1NMQnLOHZIa8m
	 PmVOnKfvCmPiA==
Date: Tue, 2 Jul 2024 06:50:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Ian Kent <ikent@redhat.com>, Alexander Larsson <alexl@redhat.com>, 
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240702-rebel-hierher-6502ac863cbb@brauner>
References: <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
 <20240701-zauber-holst-1ad7cadb02f9@brauner>
 <312e4e43-886c-42ab-abfb-3388d9380f6e@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <312e4e43-886c-42ab-abfb-3388d9380f6e@themaw.net>

On Tue, Jul 02, 2024 at 09:29:49AM GMT, Ian Kent wrote:
> On 1/7/24 13:50, Christian Brauner wrote:
> > > I always thought the rcu delay was to ensure concurrent path walks "see" the
> > > 
> > > umount not to ensure correct operation of the following mntput()(s).
> > > 
> > > 
> > > Isn't the sequence of operations roughly, resolve path, lock, deatch,
> > > release
> > > 
> > > lock, rcu wait, mntput() subordinate mounts, put path.
> 
> Sorry but I'm still having trouble understanding the role of the rcu wait.

Ok, maybe I'm missing what you're after.

> 
> 
> > The crucial bit is really that synchronize_rcu_expedited() ensures that
> > the final mntput() won't happen until path walk leaves RCU mode.
> 
> Sure, that's easily seen, even for me, but the rcu read lock is held for
> 
> the duration of the rcu walk and not released until leaving rcu walk more
> 
> and, on fail, switches to ref walk mode and restarts. So the mount struct
> 
> won't be freed from under the process in rcu walk mode, correct?

Yes.

> 
> 
> > 
> > This allows caller's like legitimize_mnt() which are called with only
> > the RCU read-lock during lazy path walk to simple check for
> > MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
> > that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
> > be freed until an RCU grace period is up and so they know that they can
> > simply put the reference count they took _without having to actually
> > call mntput()_.
> > 
> > Because if they did have to call mntput() they might end up shutting the
> > filesystem down instead of umount() and that will cause said EBUSY
> > errors I mentioned in my earlier mails.
> 
> Again, I get this too, but where is the need for the rcu wait in this?

The rcu wait is there to allow lazy path walk to not call mntput().
Otherwise you'll see these EBUSY issues. Maybe I'm confused now but you
just said that you got it. 

One thing that I had misremembered though is that a lazy umount won't
set MNT_SYNC_UMOUNT on the mounts it kills. So really for that case
synchronize_rcu_expedited() won't matter.

> Originally I had the notion that it was to ensure any path walkers had seen
> 
> the mount become invalid before tearing down things that enable the
> detection
> 
> but suddenly I don't get that any more ...

For a regular umount concurrent lazy path walkers want to be able to not
steal the last umount. So the synchronize_*() ensures that they all see
MNT_SYNC_UMOUNT and don't need to call mntput().

Afaict, what you're thinking about is handled by call_rcu(&mnt->mnt_rcu,
delayed-free_vfsmnt() in cleanup_mnt() which is always called and makes
sure that anyone still holding an rcu_read_lock() over that mount can
access the data.

That's how I had always understood it. 

> 
> 
> Please help me out here, I just don't get the need (and I'm sure there is
> 
> one) for the rcu wait.
> 
> 
> Ian
> 
> > 
> > > 
> > > So the mount gets detached in the critical section, then we wait followed by
> > > 
> > > the mntput()(s). The catch is that not waiting might increase the likelyhood
> > > 
> > > that concurrent path walks don't see the umount (so that possibly the umount
> > > 
> > > goes away before the walks see the umount) but I'm not certain. What looks
> > > to
> > > 
> > > be as much of a problem is mntput() racing with a concurrent mount beacase
> > > while
> > > 
> > > the detach is done in the critical section the super block instance list
> > > deletion
> > > 
> > > is not and the wait will make the race possibility more likely. What's more
> > Concurrent mounters of the same filesystem will wait for each other via
> > grab_super(). That has it's own logic based on sb->s_active which goes
> > to zero when all mounts are gone.
> > 
> > > mntput() delegates the mount cleanup (which deletes the list instance) to a
> > > 
> > > workqueue job so this can also occur serially in a following mount command.
> > No, that only happens when it's a kthread. Regular umount() call goes
> > via task work which finishes before the caller returns to userspace
> > (same as closing files work).
> > 
> > > 
> > > In fact I might have seen exactly this behavior in a recent xfs-tests run
> > > where I
> > > 
> > > was puzzled to see occasional EBUSY return on mounting of mounts that should
> > > not
> > > 
> > > have been in use following their umount.
> > That's usually very much other bugs. See commit 2ae4db5647d8 ("fs: don't
> > misleadingly warn during thaw operations") in vfs.fixes for example.
> > 
> > > 
> > > So I think there are problems here but I don't think the removal of the wait
> > > for
> > > 
> > > lazy umount is the worst of it.
> > > 
> > > 
> > > The question then becomes, to start with, how do we resolve this unjustified
> > > EBUSY
> > > 
> > > return. Perhaps a completion (used between the umount and mount system
> > > calls) would
> > > 
> > > work well here?
> > Again, this already exists deeper down the stack...

