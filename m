Return-Path: <linux-fsdevel+bounces-46665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285EDA934FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 10:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DFC19E6BF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558226FD8C;
	Fri, 18 Apr 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXIIftVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D726FA54;
	Fri, 18 Apr 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966760; cv=none; b=AFEzdQVe6YEcVhB9nGwWwi8xysO1Tkk7UVXuOhqaJG5HxJuhmMwADzzL4i+Sr90L9stKpdFKMDi+MmCVh9xWjA29c5AO4AFS8M52rvIhijXcqsY7rKdCd65/NhYLVrue8U9ddAJ7Zpdh25Htb5Lp0vhjT+V1aPy45k0OAHqvd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966760; c=relaxed/simple;
	bh=PGhLBQKQMeyXyuqv5cOedapStDNMfi9p9P2MX9PvVOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POit+TTmgwBN+JqifRmGo6uUJwIG58QbUGKGxWBPtvu1XYHIM3vRnkGbn6bMDrOmU/pXTVOcUjNLKhOipr5SOUL1c8jMyXsj3yJBmEdPRR16dwQ+0vzPQJwhbikVLywQBnjOKJpQTTlPP/xHum91TWZIjbQ1wYRlhhfPm9Izmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXIIftVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CE0C4CEE2;
	Fri, 18 Apr 2025 08:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744966759;
	bh=PGhLBQKQMeyXyuqv5cOedapStDNMfi9p9P2MX9PvVOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXIIftVnIzJ/1DPPwmhlS7BkEdJoLr7Aex7uDbuW5jeh13fRazwb7ImOc8Ozd7ATI
	 0Ek3vE91ZF9gdxHQ/yqRd50ErZb9sJxxOyjX/4cQEw8wdjqk1u7P2hcjfuhkksYhm0
	 RChSJ6t9MdZx63xX1IBO1cUuZv+H8X4G8Y+f7FccMvHPLxVUEL03BW0eIjV1hsZc4N
	 g1GEimZ7erlRfPHK8GhcPTRIBv1auN0tb4XlULqiTVRHYqqB+J5HXdy2c19j52G5tw
	 tc9cxKfB9+bMZBfMMIuowFvJTSVqFKBlowgZcijBOIX0D3ZDP98IJVOzrgdJLkQFRN
	 yjPG9LldOxLuw==
Date: Fri, 18 Apr 2025 10:59:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250418-bekunden-virusinfektion-3ec992b21bfb@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <7980515f-2c5f-4279-bb41-7a3b336a4e26@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7980515f-2c5f-4279-bb41-7a3b336a4e26@themaw.net>

On Fri, Apr 18, 2025 at 08:31:03AM +0800, Ian Kent wrote:
> On 17/4/25 23:12, Christian Brauner wrote:
> > On Thu, Apr 17, 2025 at 01:31:40PM +0200, Christian Brauner wrote:
> > > On Thu, Apr 17, 2025 at 06:17:01PM +0800, Ian Kent wrote:
> > > > On 17/4/25 17:01, Christian Brauner wrote:
> > > > > On Wed, Apr 16, 2025 at 11:11:51PM +0100, Mark Brown wrote:
> > > > > > On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> > > > > > > Defer releasing the detached file-system when calling namespace_unlock()
> > > > > > > during a lazy umount to return faster.
> > > > > > > 
> > > > > > > When requesting MNT_DETACH, the caller does not expect the file-system
> > > > > > > to be shut down upon returning from the syscall. Calling
> > > > > > > synchronize_rcu_expedited() has a significant cost on RT kernel that
> > > > > > > defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
> > > > > > > mount in a separate list and put it on a workqueue to run post RCU
> > > > > > > grace-period.
> > > > > > For the past couple of days we've been seeing failures in a bunch of LTP
> > > > > > filesystem related tests on various arm64 systems.  The failures are
> > > > > > mostly (I think all) in the form:
> > > > > > 
> > > > > > 20101 10:12:40.378045  tst_test.c:1833: TINFO: === Testing on vfat ===
> > > > > > 20102 10:12:40.385091  tst_test.c:1170: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > > > > > 20103 10:12:40.391032  mkfs.vfat: unable to open /dev/loop0: Device or resource busy
> > > > > > 20104 10:12:40.395953  tst_test.c:1170: TBROK: mkfs.vfat failed with exit code 1
> > > > > > 
> > > > > > ie, a failure to stand up the test environment on the loopback device
> > > > > > all happening immediately after some other filesystem related test which
> > > > > > also used the loop device.  A bisect points to commit a6c7a78f1b6b97
> > > > > > which is this, which does look rather relevant.  LTP is obviously being
> > > > > > very much an edge case here.
> > > > > Hah, here's something I didn't consider and that I should've caught.
> > > > > 
> > > > > Look, on current mainline no matter if MNT_DETACH/UMOUNT_SYNC or
> > > > > non-MNT_DETACH/UMOUNT_SYNC. The mntput() calls after the
> > > > > synchronize_rcu_expedited() calls will end up in task_work():
> > > > > 
> > > > >           if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
> > > > >                   struct task_struct *task = current;
> > > > >                   if (likely(!(task->flags & PF_KTHREAD))) {
> > > > >                           init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
> > > > >                           if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
> > > > >                                   return;
> > > > >                   }
> > > > >                   if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
> > > > >                           schedule_delayed_work(&delayed_mntput_work, 1);
> > > > >                   return;
> > > > >           }
> > > > > 
> > > > > because all of those mntput()s are done from the task's contect.
> > > > > 
> > > > > IOW, if userspace does umount(MNT_DETACH) and the task has returned to
> > > > > userspace it is guaranteed that all calls to cleanup_mnt() are done.
> > > > > 
> > > > > With your change that simply isn't true anymore. The call to
> > > > > queue_rcu_work() will offload those mntput() to be done from a kthread.
> > > > > That in turn means all those mntputs end up on the delayed_mntput_work()
> > > > > queue. So the mounts aren't cleaned up by the time the task returns to
> > > > > userspace.
> > > > > 
> > > > > And that's likely problematic even for the explicit MNT_DETACH use-case
> > > > > because it means EBUSY errors are a lot more likely to be seen by
> > > > > concurrent mounters especially for loop devices.
> > > > > 
> > > > > And fwiw, this is exactly what I pointed out in a prior posting to this
> > > > > patch series.
> > > > And I didn't understand what you said then but this problem is more
> > > > 
> > > > understandable to me now.
> > I mean I'm saying it could be problematic for the MNT_DETACH case. I'm
> > not sure how likely it is. If some process P1 does MNT_DETACH on a loop
> > device and then another process P2 wants to use that loop device and
> > sess EBUSY then we don't care. That can already happen. But even in this
> > case I'm not sure if there aren't subtle ways where this will bite us.
> > 
> > But there's two other problems:
> > 
> > (1) The real issue is with the same process P1 doing stupid stuff that
> >      just happened to work. For example if there's code out there that
> >      does a MNT_DETACH on a filesystem that uses a loop device
> >      immediately followed by the desire to reuse the loop device:
> > 
> >      It doesn't matter whether such code must in theory already be
> >      prepared to handle the case of seeing EBUSY after the MNT_DETACH. If
> >      this currently just happens to work because we guarantee that the
> >      last mntput() and cleanup_mnt() will have been done when the caller
> >      returns to userspace it's a uapi break plain and simple.
> > 
> >      This implicit guarantee isn't there anymore after your patch because
> >      the final mntput() from is done from the system_unbound_wq which has
> >      the consequence that the cleanup_mnt() is done from the
> >      delayed_mntput_work workqeueue. And that leads to problem number
> >      (2).
> 
> This is a bit puzzling to me.
> 
> 
> All the mounts in the tree should be unhashed before any of these mntput()
> 
> calls so I didn't think it would be found. I'll need to look at the loop
> 
> device case to work out how it's finding (or holing onto) the stale mount
> 
> and concluding it's busy.

Say you do:

mount(/dev/loop0 /mnt);

Unmounting that thing with or without MNT_DETACH will have the following
effect (if no path lookup happens and it isn't kept busy otherwise):

After the task returns the loop device will be free again because
deactivate_super() will have been called and the loop device is
release when the relevant filesystems release the claim on the block
device.

IOW, if the task that just returned wanted to reuse the same loop device
right after the umount() returned for another image file it could. It
would succeed with or without MNT_DETACH. Because the task_work means
that cleanup_mnt() will have been called when the task returns to
userspace.

But when we start offloading this to a workqueue that "guarantee" isn't
there anymore specifically for MNT_DETACH. If the system is mighty busy
the system_unbound_wq that does the mntput() and the delayed_mntput_work
workqueue that would ultimately do the cleanup_mnt() and thus
deactivate_super() to release the loop device could be run way way after
the task has returned to userspace. Thus, the task could prepare a new
image file and whatever and then try to use the same loop device and it
would fail because the workqueue hasn't gotten around to the item yet.
And it would be pretty opaque to the caller. I have no idea how likely
that is to become a problem. I'm just saying that is a not so subtle
change in behavior that might be noticable.

