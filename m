Return-Path: <linux-fsdevel+bounces-46628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F9FA92101
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 17:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E114644F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AB25332B;
	Thu, 17 Apr 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht2lYnbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66B1CB9F0;
	Thu, 17 Apr 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902753; cv=none; b=Ek6A7r7s/82zoKb5Ar+nb0RuM7fCBVumfssxcFO2eecnRu5JtiOuZ2LoSxbp4ujZ7XMBlvZTOqUeLal7VXIvkLpgJTwYzJ2elYaDkuj27MoOmORIYamq+Yy1BVlT2xTht7OG8k0HOKQzJShfbRQW7jsiUUsAGqreoAUgvR7POaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902753; c=relaxed/simple;
	bh=CGKcGlf+tb1zXeKVHWWfHyN3Tjqkmof0RT5+YcBCtwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlCBH4ARbOGdkRgSiVsLa3gVSNDb0sSLhE1YX3836vz/ixxT3AGHIBXnggpGSgV7xgquem/5ibvXd684sMlJqCZOkNK2ynfCjaQF0EdLKzcV9ay5iMyMj7MfAwlnU9kHo32+tbd4r8wPKZiK/7HOaNTQbcDowuI5K/ppi4BRBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht2lYnbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B39C4CEE4;
	Thu, 17 Apr 2025 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744902752;
	bh=CGKcGlf+tb1zXeKVHWWfHyN3Tjqkmof0RT5+YcBCtwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ht2lYnbfzHLOjJkcDW0yOLpNaCHwyWao4PBFQ75A6UTqi8+ls6XvX0EfSzEJ+7IZF
	 td2uN5bJPfYP+7jLmsGn5cqemx5wn6++OyQYMGLalSf6sQxONt6cQv7oMmaMfpwDVR
	 cjfxj//Zhh+W6OVg8MyiMltvkmrf9oPpECTKJTqaZKvJi/8C3TX9ol+J0o75g6Q+xj
	 /H9xGRfRPHoA9YtscZkQJxgkjWibnyNZUCxo2LtypeD1zT0LckOUOCIPXbzLhujDlA
	 tYkiokej6g8xHnj9EmaLCJuIEgUGWnbS8A16ARZLzYmM/nZaeqLxPNUCB+lu9ts+BE
	 Ev9Qklz9/szmw==
Date: Thu, 17 Apr 2025 17:12:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250417-outen-dreihundert-7a772f78f685@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250417-abartig-abfuhr-40e558b85f97@brauner>

On Thu, Apr 17, 2025 at 01:31:40PM +0200, Christian Brauner wrote:
> On Thu, Apr 17, 2025 at 06:17:01PM +0800, Ian Kent wrote:
> > 
> > On 17/4/25 17:01, Christian Brauner wrote:
> > > On Wed, Apr 16, 2025 at 11:11:51PM +0100, Mark Brown wrote:
> > > > On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> > > > > Defer releasing the detached file-system when calling namespace_unlock()
> > > > > during a lazy umount to return faster.
> > > > > 
> > > > > When requesting MNT_DETACH, the caller does not expect the file-system
> > > > > to be shut down upon returning from the syscall. Calling
> > > > > synchronize_rcu_expedited() has a significant cost on RT kernel that
> > > > > defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
> > > > > mount in a separate list and put it on a workqueue to run post RCU
> > > > > grace-period.
> > > > For the past couple of days we've been seeing failures in a bunch of LTP
> > > > filesystem related tests on various arm64 systems.  The failures are
> > > > mostly (I think all) in the form:
> > > > 
> > > > 20101 10:12:40.378045  tst_test.c:1833: TINFO: === Testing on vfat ===
> > > > 20102 10:12:40.385091  tst_test.c:1170: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > > > 20103 10:12:40.391032  mkfs.vfat: unable to open /dev/loop0: Device or resource busy
> > > > 20104 10:12:40.395953  tst_test.c:1170: TBROK: mkfs.vfat failed with exit code 1
> > > > 
> > > > ie, a failure to stand up the test environment on the loopback device
> > > > all happening immediately after some other filesystem related test which
> > > > also used the loop device.  A bisect points to commit a6c7a78f1b6b97
> > > > which is this, which does look rather relevant.  LTP is obviously being
> > > > very much an edge case here.
> > > Hah, here's something I didn't consider and that I should've caught.
> > > 
> > > Look, on current mainline no matter if MNT_DETACH/UMOUNT_SYNC or
> > > non-MNT_DETACH/UMOUNT_SYNC. The mntput() calls after the
> > > synchronize_rcu_expedited() calls will end up in task_work():
> > > 
> > >          if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
> > >                  struct task_struct *task = current;
> > >                  if (likely(!(task->flags & PF_KTHREAD))) {
> > >                          init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
> > >                          if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
> > >                                  return;
> > >                  }
> > >                  if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
> > >                          schedule_delayed_work(&delayed_mntput_work, 1);
> > >                  return;
> > >          }
> > > 
> > > because all of those mntput()s are done from the task's contect.
> > > 
> > > IOW, if userspace does umount(MNT_DETACH) and the task has returned to
> > > userspace it is guaranteed that all calls to cleanup_mnt() are done.
> > > 
> > > With your change that simply isn't true anymore. The call to
> > > queue_rcu_work() will offload those mntput() to be done from a kthread.
> > > That in turn means all those mntputs end up on the delayed_mntput_work()
> > > queue. So the mounts aren't cleaned up by the time the task returns to
> > > userspace.
> > > 
> > > And that's likely problematic even for the explicit MNT_DETACH use-case
> > > because it means EBUSY errors are a lot more likely to be seen by
> > > concurrent mounters especially for loop devices.
> > > 
> > > And fwiw, this is exactly what I pointed out in a prior posting to this
> > > patch series.
> > 
> > And I didn't understand what you said then but this problem is more
> > 
> > understandable to me now.

I mean I'm saying it could be problematic for the MNT_DETACH case. I'm
not sure how likely it is. If some process P1 does MNT_DETACH on a loop
device and then another process P2 wants to use that loop device and
sess EBUSY then we don't care. That can already happen. But even in this
case I'm not sure if there aren't subtle ways where this will bite us.

But there's two other problems:

(1) The real issue is with the same process P1 doing stupid stuff that
    just happened to work. For example if there's code out there that
    does a MNT_DETACH on a filesystem that uses a loop device
    immediately followed by the desire to reuse the loop device:

    It doesn't matter whether such code must in theory already be
    prepared to handle the case of seeing EBUSY after the MNT_DETACH. If
    this currently just happens to work because we guarantee that the
    last mntput() and cleanup_mnt() will have been done when the caller
    returns to userspace it's a uapi break plain and simple.

    This implicit guarantee isn't there anymore after your patch because
    the final mntput() from is done from the system_unbound_wq which has
    the consequence that the cleanup_mnt() is done from the
    delayed_mntput_work workqeueue. And that leads to problem number
    (2).

(2) If a userspace task is dealing with e.g., a broken NFS server and
    does a umount(MNT_DETACH) and that NFS server blocks indefinitely
    then right now it will be the task's problem that called the umount.
    It will simply hang and pay the price.

    With your patch however, that cleanup_mnt() and the
    deactivate_super() call it entails will be done from
    delayed_mntput_work...

    So if there's some userspace process with a broken NFS server and it
    does umount(MNT_DETACH) it will end up hanging every other
    umount(MNT_DETACH) on the system because the dealyed_mntput_work
    workqueue (to my understanding) cannot make progress.

    So in essence this patch to me seems like handing a DOS vector for
    MNT_DETACH to userspace.

> > 
> > 
> > > 
> > > But we've also worsened that situation by doing the deferred thing for
> > > any non-UMOUNT_SYNC. That which includes namespace exit. IOW, if the
> > > last task in a new mount namespace exits it will drop_collected_mounts()
> > > without UMOUNT_SYNC because we know that they aren't reachable anymore,
> > > after all the mount namespace is dead.
> > > 
> > > But now we defer all cleanup to the kthread which means when the task
> > > returns to userspace there's still mounts to be cleaned up.
> > 
> > Correct me if I'm wrong but the actual problem is that the mechanism used
> > 
> > to wait until there are no processes doing an rcu-walk on mounts in the
> > 
> > discard list is unnecessarily long according to what Eric has seen. So a
> 
> I think that the current approach is still salvagable but I need to test
> this and currently LTP doesn't really compile for me.

I managed to reproduce this and it is like I suspected. I just thought
"Oh well, if it's not UMOUNT_SYNC then we can just punt this to a
workqueue." which is obviously not going to work.

If a mount namespace gets cleaned up or if a detached mount tree is
cleaned up or if audit calls drop_collected_mounts() we obviously don't
want to defer the unmount. So the fix is to simply restrict this to
userspace actually requesting MNT_DETACH.

But I'm seeing way more substantial issues with this patch.

