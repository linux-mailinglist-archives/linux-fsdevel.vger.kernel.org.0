Return-Path: <linux-fsdevel+bounces-31340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4D994DF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96EA1C252BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53A1DF265;
	Tue,  8 Oct 2024 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBVDWWgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E151DE4CD;
	Tue,  8 Oct 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393058; cv=none; b=CAemjhLoPnq90gEZkJ45yz/QAGcj1RgJfXOw6OeujzLmZPmYt1aqE0f8I2HiVGJcFwcwH1SRlrB/7BTMSRwLq4I3CgF5hBRry1HVznabxTW7QpJSLxh4Ru0eEo2stSgC4OumpRQXrV+9eG6XuzXxUX1R7QNhJ90eWc7MD6cZ04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393058; c=relaxed/simple;
	bh=tY4N1IuuWaKx0TQWzes5g60+uBIn2G6WmEWkTSqvueU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5+tmBJDU0TJtnUGrVWF5Jc91blx+IVNpZ6cjaCMs9ytetGzv2SCKecvQaecKhdoPrwUnWmkqhjODXzqIwZwqXlqNx47SAf6bLJh7s5mskCIMOGSt6AeC5REgxGruh/UrzTTHevWADQgxNuoA94WXHPK9iKxugqezYEY4LE0+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBVDWWgF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e25f3748e0so56337867b3.0;
        Tue, 08 Oct 2024 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728393055; x=1728997855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1X88XkNaciEBMOOukkde66JRe9dk6pAw1yAJWCuM2g=;
        b=TBVDWWgFYRmsoxBQy4D4e1/v2BKL0LqCj5SmXvy2ndNHxl+5ml4+GoZ+u/coJ9h48T
         PuEGP/0SeDqjfgWoQko6iPCGT9RAp1Cs5KyV4i4GKsaZF+4nYZfbeRl3Ux4dpO3hNpMD
         tgx90kpmrBOwwIJU6rUFvRaEQza37pH15LiS2zXRvLxpPerd9cMxKOAj+DgFXRqVq78+
         YQ3a9JuiM8QPl935NDKEog1gcD8iSqbNj4AzkNlqkNcsiCAkWK5po7nF2sC9MwS+5mz1
         114q/6t5ShXP4iJp0FXBLzia3aj4l5JfRspK3TPNruUjZ6pFZ2K3u2rRdObE7BKPgKz7
         LIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393055; x=1728997855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1X88XkNaciEBMOOukkde66JRe9dk6pAw1yAJWCuM2g=;
        b=X5xpea4Myj4xjZL1TR9MxMVTdGLg2lBgWgrliN6mUHJu8ZPFXWGaskxzcAgunQp1fp
         AAmpp7B6pTWTxW6v7fHyC0jqd5fq9xaozozI66z+WcWXPCqnfa6ANkL5RrEyQf3t3ef3
         50+u4q9BTEFGdZnvDLpG8ITF4pEsMeg94WYx3pjsIixbWb9VZqhoT+F/Dys5Lnqb+GrA
         JVQgpk4sXVWC/k/KSXWyGmntAxBibtfElTjySh5e9CnqSBQ3F93yjoeKGUX6tLaVkXZr
         GDisk59r1P7MPfSzHOjk8CDwKnX9g2XA6Txni30cB7Y4Nv7yLPQ+24Vo0psLL0lTLwjH
         DVOw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Q5uEi01BEn13E7S65ZZSeAK+K8JWN0LuMFDPHCWLrGHdpZlW6iI4zO5ZOThw8NNVG9Z8af9J3p5bdbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQ26iKhkxdDBX/caOW1SluOva/7eT09CTU2+PGKrDaoFlSau1
	Tu2H9Fl6XvfXjtBEBS+gXerKa9e9CaqKFMV9Dhsu/yReAg1hbK/0KHZYBjxOb61EwZfbcgBekkS
	GLcOn4foS8rWcMnvhA1zdybjv93w=
X-Google-Smtp-Source: AGHT+IEKytZnckel6sjSADs+X5jQ0julszOHP4P+Snh8nCjHTLBsuYxtKV1YmAxX1xpSIa+Qc65AYHVMCWU4EKOHSUs=
X-Received: by 2002:a05:690c:12:b0:6b2:28c3:b706 with SMTP id
 00721157ae682-6e2c728a23amr121961527b3.34.1728393055291; Tue, 08 Oct 2024
 06:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008121930.869054-1-luca.boccassi@gmail.com> <20241008-parkraum-wegrand-4e42c89b1742@brauner>
In-Reply-To: <20241008-parkraum-wegrand-4e42c89b1742@brauner>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 8 Oct 2024 14:10:43 +0100
Message-ID: <CAMw=ZnSEwOXw-crX=JmGvYJrQ9C6-v40-swLhALNH0DBPLoyXQ@mail.gmail.com>
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, christian@brauner.io, 
	linux-kernel@vger.kernel.org, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 14:06, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Oct 08, 2024 at 01:18:20PM GMT, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > A common pattern when using pid fds is having to get information
> > about the process, which currently requires /proc being mounted,
> > resolving the fd to a pid, and then do manual string parsing of
> > /proc/N/status and friends. This needs to be reimplemented over
> > and over in all userspace projects (e.g.: I have reimplemented
> > resolving in systemd, dbus, dbus-daemon, polkit so far), and
> > requires additional care in checking that the fd is still valid
> > after having parsed the data, to avoid races.
> >
> > Having a programmatic API that can be used directly removes all
> > these requirements, including having /proc mounted.
> >
> > As discussed at LPC24, add an ioctl with an extensible struct
> > so that more parameters can be added later if needed. Start with
> > returning pid/tgid/ppid and creds unconditionally, and cgroupid
> > optionally.
> >
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > ---
> > v9: drop result_mask and reuse request_mask instead
> > v8: use RAII guard for rcu, call put_cred()
> > v7: fix RCU issue and style issue introduced by v6 found by reviewer
> > v6: use rcu_read_lock() when fetching cgroupid, use task_ppid_nr_ns() to
> >     get the ppid, return ESCHR if any of pid/tgid/ppid are 0 at the end
> >     of the call to avoid providing incomplete data, document what the
> >     callers should expect
> > v5: check again that the task hasn't exited immediately before copying
> >     the result out to userspace, to ensure we are not returning stale data
> >     add an ifdef around the cgroup structs usage to fix build errors when
> >     the feature is disabled
> > v4: fix arg check in pidfd_ioctl() by moving it after the new call
> > v3: switch from pid_vnr() to task_pid_vnr()
> > v2: Apply comments from Christian, apart from the one about pid namespaces
> >     as I need additional hints on how to implement it.
> >     Drop the security_context string as it is not the appropriate
> >     metadata to give userspace these days.
> >
> >  fs/pidfs.c                                    | 88 ++++++++++++++++++-
> >  include/uapi/linux/pidfd.h                    | 30 +++++++
> >  .../testing/selftests/pidfd/pidfd_open_test.c | 80 ++++++++++++++++-
> >  3 files changed, 194 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index 80675b6bf884..15cdc7fe4968 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/anon_inodes.h>
> >  #include <linux/file.h>
> >  #include <linux/fs.h>
> > +#include <linux/cgroup.h>
> >  #include <linux/magic.h>
> >  #include <linux/mount.h>
> >  #include <linux/pid.h>
> > @@ -114,6 +115,83 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
> >       return poll_flags;
> >  }
> >
> > +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
> > +{
> > +     struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> > +     size_t usize = _IOC_SIZE(cmd);
> > +     struct pidfd_info kinfo = {};
> > +     struct user_namespace *user_ns;
> > +     const struct cred *c;
> > +     __u64 request_mask;
> > +
> > +     if (!uinfo)
> > +             return -EINVAL;
> > +     if (usize < sizeof(struct pidfd_info))
> > +             return -EINVAL; /* First version, no smaller struct possible */
> > +
> > +     if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
> > +             return -EFAULT;
> > +
> > +     c = get_task_cred(task);
> > +     if (!c)
> > +             return -ESRCH;
> > +
> > +     /* Unconditionally return identifiers and credentials, the rest only on request */
> > +
> > +     user_ns = current_user_ns();
> > +     kinfo.ruid = from_kuid_munged(user_ns, c->uid);
> > +     kinfo.rgid = from_kgid_munged(user_ns, c->gid);
> > +     kinfo.euid = from_kuid_munged(user_ns, c->euid);
> > +     kinfo.egid = from_kgid_munged(user_ns, c->egid);
> > +     kinfo.suid = from_kuid_munged(user_ns, c->suid);
> > +     kinfo.sgid = from_kgid_munged(user_ns, c->sgid);
> > +     kinfo.fsuid = from_kuid_munged(user_ns, c->fsuid);
> > +     kinfo.fsgid = from_kgid_munged(user_ns, c->fsgid);
> > +     put_cred(c);
> > +
> > +#ifdef CONFIG_CGROUPS
> > +     if (request_mask & PIDFD_INFO_CGROUPID) {
> > +             struct cgroup *cgrp;
> > +
> > +             guard(rcu)();
> > +             cgrp = task_cgroup(task, pids_cgrp_id);
> > +             if (!cgrp)
> > +                     return -ENODEV;
>
> Afaict this means that the task has already exited. In other words, the
> cgroup id cannot be retrieved anymore for a task that has exited but not
> been reaped. Frankly, I would have expected the cgroup id to be
> retrievable until the task has been reaped but that's another
> discussion.
>
> My point is if you contrast this with the other information in here: If
> the task has exited but hasn't been reaped then you can still get
> credentials such as *uid/*gid, and pid namespace relative information
> such as pid/tgid/ppid.
>
> So really, I would argue that you don't want to fail this but only
> report 0 here. That's me working under the assumption that cgroup ids
> start from 1...
>
> /me checks
>
> Yes, they start from 1 so 0 is invalid.
>
> > +             kinfo.cgroupid = cgroup_id(cgrp);
>
> Fwiw, it looks like getting the cgroup id is basically just
> dereferencing pointers without having to hold any meaningful locks. So
> it should be fast. So making it unconditional seems fine to me.

There's an ifdef since it's an optional kernel feature, and there's
also this thing that we might not have it, so I'd rather keep the
flag, and set it only if we can get the information (instead of
failing). As a user that seems clearer to me.

