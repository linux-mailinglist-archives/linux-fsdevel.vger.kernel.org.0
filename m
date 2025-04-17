Return-Path: <linux-fsdevel+bounces-46615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B35A91728
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 11:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017FA19E18DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB82218584;
	Thu, 17 Apr 2025 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVBeZB0Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7242DFA4F;
	Thu, 17 Apr 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880474; cv=none; b=LS7t5YfScMmP/d7YklXWx/yC033Bdf6OVTEwwMJZsuZFyHFKtT2maklCadUR9NiiQN1WB5k1gcqZQnDtbyxleS2MAK+4wpqqNhgZ3jimQxhdPC53RGlowW7vpm6w2UULqeCk/qJaDcln5geS5QseBEAXcaaPiusuwJhIAtCBvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880474; c=relaxed/simple;
	bh=VfSC6I/OG0eMCqe2vBONpRLTXOy+zIgjcUwPbGFwitY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLAWo9Bmu4Bi0W2Zc4uFK9opmrgskohkBKz3tURNuXs3sSIsp/ic1zj8GOFNljFnDR7A2NpZsbh9CaqQwQqs3V1ekOPzkSkGs8JFJjTJJhP3jPfTUIEn9r65CbUOV0vl5nwYziDVaBWGM08b8CdHbFdluA1KXWPPBEJ4KG/EE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVBeZB0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4B8C4CEE4;
	Thu, 17 Apr 2025 09:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744880473;
	bh=VfSC6I/OG0eMCqe2vBONpRLTXOy+zIgjcUwPbGFwitY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVBeZB0Z5hsW2lMoZAnW0YScvMu0AI2NXksAInEzIq+dwf4G/tapElP5903u4Ur5t
	 m1jTYDlFOTUkogilmrIagHY6EeQ/HUzJZvQyS+dYd/KJnfK5Lk9BvvJShXNmfbNAXi
	 5WWKrHzzUh186HY16N8dZqbbu9xIaaGlvX5CqqES19cCDiqEg6eG66DiSYVkoXkT+D
	 8Cm+ihCvMW58Xw3KVb+zXcOMcrP5EBl8LfXJ9gsQWzAfEeQOsYkRhz8MbNY2uQZXNo
	 eqhcwxUi3JrOSWP5Lp7x4xc49zKZA8N/DOU5xANXInJvw7tzw+RAqYbpfSugdytXSM
	 7MOEVEeXwBCjg==
Date: Thu, 17 Apr 2025 11:01:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>

On Wed, Apr 16, 2025 at 11:11:51PM +0100, Mark Brown wrote:
> On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> > Defer releasing the detached file-system when calling namespace_unlock()
> > during a lazy umount to return faster.
> > 
> > When requesting MNT_DETACH, the caller does not expect the file-system
> > to be shut down upon returning from the syscall. Calling
> > synchronize_rcu_expedited() has a significant cost on RT kernel that
> > defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
> > mount in a separate list and put it on a workqueue to run post RCU
> > grace-period.
> 
> For the past couple of days we've been seeing failures in a bunch of LTP
> filesystem related tests on various arm64 systems.  The failures are
> mostly (I think all) in the form:
> 
> 20101 10:12:40.378045  tst_test.c:1833: TINFO: === Testing on vfat ===
> 20102 10:12:40.385091  tst_test.c:1170: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> 20103 10:12:40.391032  mkfs.vfat: unable to open /dev/loop0: Device or resource busy
> 20104 10:12:40.395953  tst_test.c:1170: TBROK: mkfs.vfat failed with exit code 1
> 
> ie, a failure to stand up the test environment on the loopback device
> all happening immediately after some other filesystem related test which
> also used the loop device.  A bisect points to commit a6c7a78f1b6b97
> which is this, which does look rather relevant.  LTP is obviously being
> very much an edge case here.

Hah, here's something I didn't consider and that I should've caught.

Look, on current mainline no matter if MNT_DETACH/UMOUNT_SYNC or
non-MNT_DETACH/UMOUNT_SYNC. The mntput() calls after the
synchronize_rcu_expedited() calls will end up in task_work():

        if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
                struct task_struct *task = current;
                if (likely(!(task->flags & PF_KTHREAD))) {
                        init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
                        if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
                                return;
                }
                if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
                        schedule_delayed_work(&delayed_mntput_work, 1);
                return;
        }

because all of those mntput()s are done from the task's contect.

IOW, if userspace does umount(MNT_DETACH) and the task has returned to
userspace it is guaranteed that all calls to cleanup_mnt() are done.

With your change that simply isn't true anymore. The call to
queue_rcu_work() will offload those mntput() to be done from a kthread.
That in turn means all those mntputs end up on the delayed_mntput_work()
queue. So the mounts aren't cleaned up by the time the task returns to
userspace.

And that's likely problematic even for the explicit MNT_DETACH use-case
because it means EBUSY errors are a lot more likely to be seen by
concurrent mounters especially for loop devices.

And fwiw, this is exactly what I pointed out in a prior posting to this
patch series.

But we've also worsened that situation by doing the deferred thing for
any non-UMOUNT_SYNC. That which includes namespace exit. IOW, if the
last task in a new mount namespace exits it will drop_collected_mounts()
without UMOUNT_SYNC because we know that they aren't reachable anymore,
after all the mount namespace is dead.

But now we defer all cleanup to the kthread which means when the task
returns to userspace there's still mounts to be cleaned up.

