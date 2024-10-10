Return-Path: <linux-fsdevel+bounces-31527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEB0998280
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132B51F2417A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E01C1BC9F9;
	Thu, 10 Oct 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5JiThZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6619258C;
	Thu, 10 Oct 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553116; cv=none; b=uKxuXUK9wF2vqnqAnZtegkcBBmIpuDl3zENgTA5yopiNToRJMbVdyi86PbPgDclAV07N0vg5T/a9ISffGLtmt0xRDNuEAvo9WUSYU4H5OBtzMhSWjrLxkcgFkLNDQRMHiK/7At6rTqxeDwwNfyEbFKVb4TTZStk63bNjp9dZmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553116; c=relaxed/simple;
	bh=s8pq7zq5S4UhlLRf5W3BVvCYiyiabLKKdxg3puAo+pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on63dv9zmfS5LHw4VPx1BhHTJ1hFK++5rBtUw5R142Xn1ISKBAa63JqO40V3h6DFbrm9aIHauObzO0fLm8gO43k6biV9QGS1LkCrP92+MaUgnRPaek3OldP38FXCib3sCJ+fP3fS0PaNifJBnyd79rS9IxWeTThkxeccY2OyxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5JiThZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9CBC4CEC5;
	Thu, 10 Oct 2024 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728553115;
	bh=s8pq7zq5S4UhlLRf5W3BVvCYiyiabLKKdxg3puAo+pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5JiThZOpajg13EsllPyorCz5erBUyOxbbwpJgk/6eH8A4lK/sOtlTqLmOreQXNR+
	 vgD42TyOJYWJcznHgfhVj4+UDk4rEvjOK082kj1FNcF6XCozMgzhiFGGV+l+Hb/K25
	 jOAPYqkoFtW9n0R7GJaQlNWH0XLrC4i3HqWP1kewtkD8Q8uC+2kh6JFRFAriDWuJiY
	 q7KKuvf+nPynf9cZvYZ6zw9BJ3uIfttyWlYQklkoX8yFFhU93N+zdgww8bbw7O4Lj9
	 h5+dqqmLegG1UTsEv/Kb5HY/Ht6GUpDUHk3krwbGI4D3gTxA4WydSTe722/6t00aAS
	 PFQ90q6tWF2ew==
Date: Thu, 10 Oct 2024 11:38:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Luca Boccassi <luca.boccassi@gmail.com>, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241010-bauordnung-gewarnt-781b740ad813@brauner>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <20241008-parkraum-wegrand-4e42c89b1742@brauner>
 <CAMw=ZnSEwOXw-crX=JmGvYJrQ9C6-v40-swLhALNH0DBPLoyXQ@mail.gmail.com>
 <20241009.205103-sudsy.thunder.enamel.kennel-kyrq7lTfmNRZ@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009.205103-sudsy.thunder.enamel.kennel-kyrq7lTfmNRZ@cyphar.com>

On Thu, Oct 10, 2024 at 07:52:20AM +1100, Aleksa Sarai wrote:
> On 2024-10-08, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> > On Tue, 8 Oct 2024 at 14:06, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, Oct 08, 2024 at 01:18:20PM GMT, luca.boccassi@gmail.com wrote:
> > > > From: Luca Boccassi <luca.boccassi@gmail.com>
> > > >
> > > > A common pattern when using pid fds is having to get information
> > > > about the process, which currently requires /proc being mounted,
> > > > resolving the fd to a pid, and then do manual string parsing of
> > > > /proc/N/status and friends. This needs to be reimplemented over
> > > > and over in all userspace projects (e.g.: I have reimplemented
> > > > resolving in systemd, dbus, dbus-daemon, polkit so far), and
> > > > requires additional care in checking that the fd is still valid
> > > > after having parsed the data, to avoid races.
> > > >
> > > > Having a programmatic API that can be used directly removes all
> > > > these requirements, including having /proc mounted.
> > > >
> > > > As discussed at LPC24, add an ioctl with an extensible struct
> > > > so that more parameters can be added later if needed. Start with
> > > > returning pid/tgid/ppid and creds unconditionally, and cgroupid
> > > > optionally.
> > > >
> > > > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > > > ---
> > > > v9: drop result_mask and reuse request_mask instead
> > > > v8: use RAII guard for rcu, call put_cred()
> > > > v7: fix RCU issue and style issue introduced by v6 found by reviewer
> > > > v6: use rcu_read_lock() when fetching cgroupid, use task_ppid_nr_ns() to
> > > >     get the ppid, return ESCHR if any of pid/tgid/ppid are 0 at the end
> > > >     of the call to avoid providing incomplete data, document what the
> > > >     callers should expect
> > > > v5: check again that the task hasn't exited immediately before copying
> > > >     the result out to userspace, to ensure we are not returning stale data
> > > >     add an ifdef around the cgroup structs usage to fix build errors when
> > > >     the feature is disabled
> > > > v4: fix arg check in pidfd_ioctl() by moving it after the new call
> > > > v3: switch from pid_vnr() to task_pid_vnr()
> > > > v2: Apply comments from Christian, apart from the one about pid namespaces
> > > >     as I need additional hints on how to implement it.
> > > >     Drop the security_context string as it is not the appropriate
> > > >     metadata to give userspace these days.
> > > >
> > > >  fs/pidfs.c                                    | 88 ++++++++++++++++++-
> > > >  include/uapi/linux/pidfd.h                    | 30 +++++++
> > > >  .../testing/selftests/pidfd/pidfd_open_test.c | 80 ++++++++++++++++-
> > > >  3 files changed, 194 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > > > index 80675b6bf884..15cdc7fe4968 100644
> > > > --- a/fs/pidfs.c
> > > > +++ b/fs/pidfs.c
> > > > @@ -2,6 +2,7 @@
> > > >  #include <linux/anon_inodes.h>
> > > >  #include <linux/file.h>
> > > >  #include <linux/fs.h>
> > > > +#include <linux/cgroup.h>
> > > >  #include <linux/magic.h>
> > > >  #include <linux/mount.h>
> > > >  #include <linux/pid.h>
> > > > @@ -114,6 +115,83 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
> > > >       return poll_flags;
> > > >  }
> > > >
> > > > +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
> > > > +{
> > > > +     struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> > > > +     size_t usize = _IOC_SIZE(cmd);
> > > > +     struct pidfd_info kinfo = {};
> > > > +     struct user_namespace *user_ns;
> > > > +     const struct cred *c;
> > > > +     __u64 request_mask;
> > > > +
> > > > +     if (!uinfo)
> > > > +             return -EINVAL;
> > > > +     if (usize < sizeof(struct pidfd_info))
> > > > +             return -EINVAL; /* First version, no smaller struct possible */
> > > > +
> > > > +     if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
> > > > +             return -EFAULT;
> > > > +
> > > > +     c = get_task_cred(task);
> > > > +     if (!c)
> > > > +             return -ESRCH;
> > > > +
> > > > +     /* Unconditionally return identifiers and credentials, the rest only on request */
> > > > +
> > > > +     user_ns = current_user_ns();
> > > > +     kinfo.ruid = from_kuid_munged(user_ns, c->uid);
> > > > +     kinfo.rgid = from_kgid_munged(user_ns, c->gid);
> > > > +     kinfo.euid = from_kuid_munged(user_ns, c->euid);
> > > > +     kinfo.egid = from_kgid_munged(user_ns, c->egid);
> > > > +     kinfo.suid = from_kuid_munged(user_ns, c->suid);
> > > > +     kinfo.sgid = from_kgid_munged(user_ns, c->sgid);
> > > > +     kinfo.fsuid = from_kuid_munged(user_ns, c->fsuid);
> > > > +     kinfo.fsgid = from_kgid_munged(user_ns, c->fsgid);
> > > > +     put_cred(c);
> > > > +
> > > > +#ifdef CONFIG_CGROUPS
> > > > +     if (request_mask & PIDFD_INFO_CGROUPID) {
> > > > +             struct cgroup *cgrp;
> > > > +
> > > > +             guard(rcu)();
> > > > +             cgrp = task_cgroup(task, pids_cgrp_id);
> > > > +             if (!cgrp)
> > > > +                     return -ENODEV;
> > >
> > > Afaict this means that the task has already exited. In other words, the
> > > cgroup id cannot be retrieved anymore for a task that has exited but not
> > > been reaped. Frankly, I would have expected the cgroup id to be
> > > retrievable until the task has been reaped but that's another
> > > discussion.
> > >
> > > My point is if you contrast this with the other information in here: If
> > > the task has exited but hasn't been reaped then you can still get
> > > credentials such as *uid/*gid, and pid namespace relative information
> > > such as pid/tgid/ppid.
> > >
> > > So really, I would argue that you don't want to fail this but only
> > > report 0 here. That's me working under the assumption that cgroup ids
> > > start from 1...
> > >
> > > /me checks
> > >
> > > Yes, they start from 1 so 0 is invalid.
> > >
> > > > +             kinfo.cgroupid = cgroup_id(cgrp);
> > >
> > > Fwiw, it looks like getting the cgroup id is basically just
> > > dereferencing pointers without having to hold any meaningful locks. So
> > > it should be fast. So making it unconditional seems fine to me.
> > 
> > There's an ifdef since it's an optional kernel feature, and there's
> > also this thing that we might not have it, so I'd rather keep the
> > flag, and set it only if we can get the information (instead of
> > failing). As a user that seems clearer to me.
> 
> I think we should keep the request_mask flag when returning from the
> kernel, but it's not necessary for the user to request it explicitly
> because it's cheap to get. This is how STATX_MNT_ID works and I think it
> makes sense to do it that way.

So what we should do is not require userspace to request it explicitly
but always raise the flag in request_mask when it's available. I agree.

