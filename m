Return-Path: <linux-fsdevel+bounces-23009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17D492569F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 11:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CCF1F23730
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398113D2B5;
	Wed,  3 Jul 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQyQgr6v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62442A80;
	Wed,  3 Jul 2024 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998569; cv=none; b=tsZOY4u8cNycf+x91st0pqKb2MnGBruWLRRAirLTaa47PaxB8XwQYu0Z0V76/49Kt8kV9GIJvPjJX0MtXTvPHvbOAEeLX3q9aoEz5UJginxkrZ9U4Twk6bykBsNab6Ydjm2ico7SxdsofjGNX7af3WBc7fsOvtVD1fMmg07T610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998569; c=relaxed/simple;
	bh=VcMNyqxa/OyWVttyD2gJnZf2GezIMVfmTMgIXg2wyBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9n6aNiWIhZVOgaukacnkvns6h2qoD0rknnWq1CVOI9hkLm8JmInrMYR3Wp5CGnaeLsGE35habqRlTIkUWUBmVywF4JJgVR3/g9Wt3YFQK3I8hINSW3sxsXA+frDPvFgBOQ4LzOMa74aRi4D8Gwg1WciF6U781U1VBkG9X50V9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQyQgr6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEEFC32781;
	Wed,  3 Jul 2024 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719998569;
	bh=VcMNyqxa/OyWVttyD2gJnZf2GezIMVfmTMgIXg2wyBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQyQgr6vGRZYJ5CilNJD/htgWr0SkybCXRRAQkAxdx3pJaCx9l6tqy0zdS9W/lp5q
	 9h7qIrqIVHw4Tv82ptMGpb3ehq8vlb/Jc/9iKUxC+lAiK66z1P7CsB9h71UaWdEAYq
	 c0jnCb3SHrSA3783TJs4rLLIZtewYR9kDw+9nwGluD+knloOc4jLLQK5U+h4qQQgLm
	 eVzwEXzba7/SKtqtfKqf+k8OHAhd/fnPYmEM7d52YAXDS6/mN8oJ6B9FvvIKQ1zows
	 niZ1oenDlYM8Ghr88JTX42sfSXtJnSg3y+4HBA4DKrZ6YX6gOtppsl+ApDBgJvxp1d
	 8I//4FZMA1q0Q==
Date: Wed, 3 Jul 2024 11:22:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Larsson <alexl@redhat.com>, Ian Kent <ikent@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, raven@themaw.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240703-mahnung-bauland-ffcacea4101e@brauner>
References: <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
 <20240701-zauber-holst-1ad7cadb02f9@brauner>
 <CAL7ro1FOYPsN3Y18tgHwpg+VB=rU1XB8Xds9P89Mh4T9N98jyA@mail.gmail.com>
 <20240701-treue-irrtum-e695ee5efe83@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701-treue-irrtum-e695ee5efe83@brauner>

On Mon, Jul 01, 2024 at 02:10:31PM GMT, Christian Brauner wrote:
> On Mon, Jul 01, 2024 at 10:41:40AM GMT, Alexander Larsson wrote:
> > On Mon, Jul 1, 2024 at 7:50 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > > I always thought the rcu delay was to ensure concurrent path walks "see" the
> > > >
> > > > umount not to ensure correct operation of the following mntput()(s).
> > > >
> > > >
> > > > Isn't the sequence of operations roughly, resolve path, lock, deatch,
> > > > release
> > > >
> > > > lock, rcu wait, mntput() subordinate mounts, put path.
> > >
> > > The crucial bit is really that synchronize_rcu_expedited() ensures that
> > > the final mntput() won't happen until path walk leaves RCU mode.
> > >
> > > This allows caller's like legitimize_mnt() which are called with only
> > > the RCU read-lock during lazy path walk to simple check for
> > > MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
> > > that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
> > > be freed until an RCU grace period is up and so they know that they can
> > > simply put the reference count they took _without having to actually
> > > call mntput()_.
> > >
> > > Because if they did have to call mntput() they might end up shutting the
> > > filesystem down instead of umount() and that will cause said EBUSY
> > > errors I mentioned in my earlier mails.
> > 
> > But such behaviour could be kept even without an expedited RCU sync.
> > Such as in my alternative patch for this:
> > https://www.spinics.net/lists/linux-fsdevel/msg270117.html
> > 
> > I.e. we would still guarantee the final mput is called, but not block
> > the return of the unmount call.
> 
> That's fine but the patch as sent doesn't work is my point. It'll cause
> exactly the issues described earlier, no? So I'm confused why this
> version simply ended up removing synchronize_rcu_expedited() when
> the proposed soluton seems to have been to use queue_rcu_work().
> 
> But anyway, my concern with this is still that this changes the way
> MNT_DETACH behaves when you shut down a non-busy filesystem with
> MNT_DETACH as outlined in my other mail.
> 
> If you find a workable version I'm not entirely opposed to try this but
> I wouldn't be surprised if this causes user visible issues for anyone
> that uses MNT_DETACH on a non-used filesystem.

Correction: I misremembered that umount_tree() is called with
UMOUNT_SYNC only in the case that umount() isn't called with MNT_DETACH.
I mentioned this yesterday in the thread but just in case you missed it
I want to spell it out in detail as well.

This is relevant because UMOUNT_SYNC will raise MNT_SYNC_UMOUNT on all
mounts it unmounts. And that ends up being checked in legitimize_mnt()
to ensure that legitimize_mnt() doesn't call mntput() during path lookup
and risking EBUSY for a umount(..., 0) + mount() sequence for the same
filesystem.

But for umount(.., MNT_DETACH) UMOUNT_SYNC isn't passed and so
MNT_SYNC_UMOUNT isn't raised on the mount and so legitimize_mnt() may
end up doing the last mntput() and cleaning up the filesystem.

In other words, a umount(..., MNT_DETACH) caller needs to be prepared to
deal with EBUSY for a umount(..., MNT_DETACH) + mount() sequence.

So I think we can certainly try this as long as we make it via
queue_rcu_work() to handle the other mntput_no_expire() grace period
dependency we discussed upthread.

Thanks for making take a closer look.

