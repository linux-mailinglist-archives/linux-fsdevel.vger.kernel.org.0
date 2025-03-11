Return-Path: <linux-fsdevel+bounces-43730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F20A5CF58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3581759AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4F2641E9;
	Tue, 11 Mar 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QarJBAeF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED542641E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721301; cv=none; b=bhPMPWJaaoZIsqSNO1XVIHnkadlJOXbcQn6DwUbPTE7AgJtgzH0+CBsiHh/iF5TLpSN4GdJAz9wUSK0CP4xF0H4irPZYaqdPk/nk4U3oSwefphaLubt5cc5K494XznWQXiiuMB7PPle1iS0Z+xHqh5e+8d2VDQfQ8OlSzOjMZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721301; c=relaxed/simple;
	bh=+prohcgqG8OKfoANG5mqxomKxBEue1x3HFri4Qconac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2aScI0x/5B8q6otz1m9u3Tc5Y+WoTlT5PUhrYkcmK+3IvpIzjNmeqGgYjhjHr7PFSb2w7oxAEWtO4NNsxWeyqHuEkgMnCmaKXQqM5/frFnm/vC8aPQgPz4RlKcK7Ivsmjct4qs4oGD7bDO4O1HZxV+p54NLkYeZpD62Brrfa54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QarJBAeF; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZC3h71kSLzCYQ;
	Tue, 11 Mar 2025 20:28:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741721287;
	bh=iHBkaI9yvQpH+nVlWc9AYNOrXuU2ymFIm93WY1nPg0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QarJBAeFRpuOwevpKonAFeMKGw2V3pToXhQ0y9Vh/tsX6zjBzti2LvAd+u1coEmMl
	 BartU+JAQ0YDUdeYHZEn1EtbyoVCKo2GUn5I8sQd9QLTsWlOVUvasyVxz5e0rpwexc
	 FlOpjWraeVlZ87zp66QY4M6EjEd3ZObS31T61a54=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZC3h45fxBzC9f;
	Tue, 11 Mar 2025 20:28:04 +0100 (CET)
Date: Tue, 11 Mar 2025 20:28:03 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>, Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Tycho Andersen <tycho@tycho.pizza>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Song Liu <song@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
Message-ID: <20250311.Ti7bi9ahshuu@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
 <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
 <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 11, 2025 at 12:42:05AM +0000, Tingmao Wang wrote:
> On 3/6/25 17:07, Amir Goldstein wrote:
> [...]
> > 
> > w.r.t sharing infrastructure with fanotify, I only looked briefly at
> > your patches
> > and I have only a vague familiarity with landlock, so I cannot yet form an
> > opinion whether this is a good idea, but I wanted to give you a few more
> > data points about fanotify that seem relevant.
> > 
> > 1. There is already some intersection of fanotify and audit lsm via the
> > fanotify_response_info_audit_rule extension for permission
> > events, so it's kind of a precedent of using fanotify to aid an lsm
> > 
> > 2. See this fan_pre_modify-wip branch [1] and specifically commit
> >    "fanotify: introduce directory entry pre-modify permission events"
> > I do have an intention to add create/delete/rename permission events.
> > Note that the new fsnotify hooks are added in to do_ vfs helpers, not very
> > far from the security_path_ lsm hooks, but not exactly in the same place
> > because we want to fsnotify hooks to be before taking vfs locks, to allow
> > listener to write to filesystem from event context.
> > There are different semantics than just ALLOW/DENY that you need,
> > therefore, only if we move the security_path_ hooks outside the
> > vfs locks, our use cases could use the same hooks
> 
> Hi Amir,
> 
> (this is a slightly long message - feel free to respond at your convenience,
> thank you in advance!)
> 
> Thanks a lot for mentioning this branch, and for the explanation! I've had a
> look and realized that the changes you have there will be very useful for
> this patch, and in fact, I've already tried a worse attempt of this (not
> included in this patch series yet) to create some security_pathname_ hooks
> that takes the parent struct path + last name as char*, that will be called
> before locking the parent.  (We can't have an unprivileged supervisor cause
> a directory to be locked indefinitely, which will also block users outside
> of the landlock domain)
> 
> I'm not sure if we can move security_path tho, because it takes the dentry
> of the child as an argument, and (I think at least for create / mknod /
> link) that dentry is only created after locking.  Hence the proposal for
> separate security_pathname_ hooks.  A search shows that currently AppArmor
> and TOMOYO (plus Landlock) uses the security_path_ hooks that would need
> changing, if we move it (and we will have to understand if the move is ok to
> do for the other two LSMs...)
> 
> However, I think it would still make a lot of sense to align with fsnotify
> here, as you have already made the changes that I would need to do anyway
> should I implement the proposed new hooks.  I think a sensible thing might
> be to have the extra LSM hooks be called alongside fsnotify_(re)name_perm -
> following the pattern of what currently happens with fsnotify_open_perm
> (i.e. security_file_open called first, then fsnotify_open_perm right after).

Yes, I think it would make sense to use the same hooks for fanotify and
other security subsystems, or at least to share them.  It would improve
consistency across different Linux subsystems and simplify changes and
maintenance where these hooks are called.

> 
> What's your thought on this? Do you think it would be a good idea to have
> LSM hook equivalents of the fsnotify (re)name perm hooks / fanotify
> pre-modify events?
> 
> Also, do you have a rough estimate of when you would upstream the
> fa/fsnotify changes? (asking just to get an idea of things, not trying to
> rush or anything :) I suspect this supervise patch would take a while
> anyway)
> 
> If you think the general idea is right, here are some further questions I
> have:
> 
> I think going by this approach any error return from security_pathname_mknod
> (or in fact, fsnotify_name_perm) when called in the open O_CREAT code path
> would end up becoming a -EROFS.  Can we turn the bool got_write in
> open_last_lookups into an int to store any error from mnt_want_write_parent,
> and return it if lookup_open returns -EROFS?  This is so that the user space
> still gets an -EACCESS on create denials by landlock (and in fact, if
> fanotify denies a create maybe we want it to return the correct errno
> also?). Maybe there is a better way, this is just my first though...
> 
> I also noticed that you don't currently have fsnotify hook calls for link
> (although it does end up invoking the name_perm hook on the dest with
> MAY_CREATE).  I want to propose also changing do_linkat to (pass the right
> flags to filename_create_srcu -> mnt_want_write_parent to) call the
> security_pathname_link hook (instead of the LSM hook it would normally call
> for a creation event in this proposal) that is basically like
> security_path_link, except passing the destination as a dir/name pair, and
> without holding vfs lock (still passing in the dentry of the source itself),
> to enable landlock to handle link requests separately. Do you think this is
> alright?  (Maybe the code would be a bit convoluted if written verbatim from
> this logic, maybe there is a better way, but the general idea is hopefully
> right)
> 
> btw, side question, I see that you added srcu read sections around the
> events - I'm not familiar with rcu/locking usage in vfs but is this for
> preventing e.g. changing the mount in some way (but still allowing access /
> changes to the directory)?
> 
> I realize I'm asking you a lot of things - big thanks in advance!  (also let
> me know if I should be pulling in other VFS maintainers)
> 
> --
> 
> For Mickaël,
> 
> Would you be on board with changing Landlock to use the new hooks as
> mentioned above?  My thinking is that it shouldn't make any difference in
> terms of security - Landlock permissions for e.g. creating/deleting files
> are based on the parent, and in fact except for link and rename, the
> hook_path_ functions in Landlock don't even use the dentry argument.  If
> you're happy with the general direction of this, I can investigate further
> and test it out etc.  This change might also reduce the impact of Landlock
> on non-landlocked processes, if we avoid holding exclusive inode lock while
> evaluating rules / traversing paths...? (Just a thought, not measured)

This looks reasonable.  As long as the semantic does not change it
should be good and Landlock tests should pass.  That would also require
other users of this hook to make sure it works for them too.  If it is
not the case, I guess we could add an alternative hooks with different
properties.  However, see the issue and the alternative approach below.

> 
> In terms of other aspects, ignoring supervisors for now, moving to these
> hooks:
> 
> - Should make no difference in the "happy" (access allowed) case
> 
> - Only when an access is disallowed, in order to know what error to
>   return, we can check (within Landlock hook handler) if the target
>   already exists - if yes, return -EEXIST, otherwise -EACCESS

We should avoid as much as possible to reimplement the error types in
fanotify/LSM hooks.  This is partially done for the VFS, and completely
duplicated for the network, which can lead to inconsistent errors.  It
would be good to only have one source of truth, but that might not be
possible in all cases.

> 
> If this is too large of a change at this point and you see / would prefer
> another way we can progress this series (at least the initial version), let
> me know.

For this patch series to work, we need all (used) LSM hooks to be
blockable (and interruptible).  We should then investigate if this is
possible, especially with the new fanotify hooks, but I don't think it
would work for all hooks (already or that will potentially be used by
Landlock).

An alternative approach would be to add a task_work (executed before
returning to user space) that will wait for the supervisor to take a
decision, and in the meantime the LSM hook would return -ERESTARTNOINTR
for the syscall to start again after the wait.  However, because the
request to the supervisor would be called outside of the hook, it should
not be possible to directly allow the request (because of race
condition) but to update the domain accordingly.  The restarted syscall
must not trigger a supervisor request though.

> 
> Kind regards,
> Tingmao
> 
> > 
> > 3. There is a recent attempt to add BPF filter to fanotify [2]
> > which is driven among other things from the long standing requirement
> > to add subtree filtering to fanotify watches.
> > The challenge with all the attempt to implement a subtree filter so far,
> > is that adding vfs performance overhead for all the users in the system
> > is unacceptable.
> > 
> > IIUC, landlock rule set can already express a subtree filter (?),
> > so it is intriguing to know if there is room for some integration on this
> > aspect, but my guess is that landlock mostly uses subtree filter
> > after filtering by specific pids (?), so it can avoid the performance
> > overhead of a subtree filter on most of the users in the system.
> > 
> > Hope this information is useful.
> > 
> > Thanks,
> > Amir.
> > 
> > [1] https://github.com/amir73il/linux/commits/fan_pre_modify-wip/
> > [2] https://lore.kernel.org/linux-fsdevel/20241122225958.1775625-1-song@kernel.org/
> 
> 

