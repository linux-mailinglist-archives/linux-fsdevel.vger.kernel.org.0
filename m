Return-Path: <linux-fsdevel+bounces-11727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA7856819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D396B285194
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA131339A5;
	Thu, 15 Feb 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRiJqQFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8D133993
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011622; cv=none; b=sxvQfP73n9Ldop05Xx+GuELEL9QnkziCSyIOwroehXkMg4rNjLKM6PLy/hiO5rARAyDgKeVxNAZql6az+ZIwQW45gyO+WBFp0wXfstPBqdjD+0YhSyN6nhyNZyR2s7NnrzdkhR80ardpqv1vxjJ/FwPDFLf2c+j4v/3chkXP7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011622; c=relaxed/simple;
	bh=aIp3FALo3jDm7PmtcxVw5Ftpb+DUm7+VKjRt+6Xtajo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvihd13n9w+EUaANrTY37LKzqg2wrBxNMdZJMJJDToBZgDU6GuyP4XZ8sqYhbK8WBj1J8g2y9KAVqp0ReZhSv5rO6SJFhavcn1Wx2BqtKr11JJ9nDGCykBfkFyDbIW2fgpF8vg7DDBio4ZI3FVivaJFSyD+QMIVBluZFO/RUOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRiJqQFZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42dc883547fso5934171cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 07:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708011619; x=1708616419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8XUCaPFgJ8Q8tjrVbCovjt/o7aPLMlOVDEl7JUzTEXE=;
        b=SRiJqQFZS7XNAfUNYFdqsUAl5Temv5UCSQLDxmnGqbj9SniVaCpTFwUUw85trmfE3w
         jdgwBtWpG+eBI9iU1vRejjdOZ0NRdzD2UnQpy6IHN0Wb4t1fnV7QOEv5GrtzfQTXl43J
         u4X9IMcKOBxG55cajuncOg5rr3KSNZMy9BR5Wk8l0loAJS3b/3EBd3gUBqks4enRAD+c
         8cSzgsXfk11N1GEuKK6efp8vPp9Eeu/Id+vv01cADplpDnR/hl+ps4zGFpVE59o+cOpb
         U8tvPPg7WQzUof5jez67QFPde2QxcRuMqyPkWcaCM5uCQtsd8TksCRjlG1ZMKsozNiOi
         Wd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011619; x=1708616419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XUCaPFgJ8Q8tjrVbCovjt/o7aPLMlOVDEl7JUzTEXE=;
        b=ib54Bv2XYS/F1FjFaCcF6IwDXkrp57i9TxRWwsRkcrobuXDdnjE0F2KZ8e6MAepmyy
         d3LGWIMBOoqB61/tTa/cQsPAO9yMw0HY1eE19QqbBixNdmZ4l7uVHw/V7r2KH464XEyW
         8PZJxlQ4g+29lwKjn7X7fGoFVqHvrPGF7g361q2atbvlgQYpStK20j9WZ+JJC7+nb6WJ
         IGNwLjKLcrZMoVdBfy201EkHG1C3Noo4fKbfgumsNcb56Z5NtOWvWOuc+/9cnSCY3+QC
         bP8FQXKK+iiUVdnr5TTMfjng2LsVHOipEnuPtuvAAU/9JQf+cp5/OMowb32w/zeokR4R
         ydQg==
X-Forwarded-Encrypted: i=1; AJvYcCX0f0i/lwJ97FMvrxlDwI/3qK18QWYDfgT/DPgLv4B/3od6pQ+z7gWIAMlPZBkg/fKqi1JlWhtIJamozpLXhKCffJGZw73H9k13EQQg2A==
X-Gm-Message-State: AOJu0YzD2Z4KqW7gg3SATXCvbi9hDprPy/NF4IapjU4ikl1CRzlGxOxu
	JfJ/S389iXJ4MSo2IegYWUqeHq8e0CFZ4JqNs4A7PaR2ZjRFmQMBFoopoj1dsR7KVvBPnATNkDj
	aI8MdXm01EjIWxzGMb1q5tM1WpAkRpKaJ
X-Google-Smtp-Source: AGHT+IEYbn5En1SLQJuxFZI6m9GgLNzArcyukkOK0iw2AvY0QEbHdRf5m12ld9LEF8PnjVQ+YeogD/xWLxLBz3andcs=
X-Received: by 2002:ac8:7d81:0:b0:42c:14b7:b603 with SMTP id
 c1-20020ac87d81000000b0042c14b7b603mr2004108qtd.36.1708011619503; Thu, 15 Feb
 2024 07:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218143504.abj3h6vxtwlwsozx@quack3> <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
 <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
 <20240205182718.lvtgfsxcd6htbqyy@quack3> <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
 <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
 <20240208183127.5onh65vyho4ds7o7@quack3> <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3> <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
 <20240215115139.rq6resdfgqiezw4t@quack3>
In-Reply-To: <20240215115139.rq6resdfgqiezw4t@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Feb 2024 17:40:07 +0200
Message-ID: <CAOQ4uxh-zYN_gok2mp8jK6BysgDb+BModw+uixvwoHB6ZpiGww@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"

> > Last time we discussed this the conclusion was an API of a group-less
> > default mask, for example:
> >
> > 1. fanotify_mark(FAN_GROUP_DEFAULT,
> >                            FAN_MARK_ADD | FAN_MARK_MOUNT,
> >                            FAN_PRE_ACCESS, AT_FDCWD, path);
> > 2. this returns -EPERM for access until some group handles FAN_PRE_ACCESS
> > 3. then HSM is started and subscribes to FAN_PRE_ACCESS
> > 4. and then the mount is moved or bind mounted into a path exported to users
>
> Yes, this was the process I was talking about.
>
> > It is a simple solution that should be easy to implement.
> > But it does not involve "register the HSM app with the filesystem",
> > unless you mean that a process that opens an HSM group
> > (FAN_REPORT_FID|FAN_CLASS_PRE_CONTENT) should automatically
> > be given FMODE_NONOTIFY files?
>
> Two ideas: What you describe above seems like what the new mount API was
> intended for? What if we introduced something like an "hsm" mount option
> which would basically enable calling into pre-content event handlers

I like that.
I forgot that with my suggestion we'd need a path to setup
the default mask.

> (for sb without this flag handlers wouldn't be called and you cannot place
> pre-content marks on such sb).

IMO, that limitation (i.e. inside brackets) is too restrictive.
In many cases, the user running HSM may not have control over the
mount of the filesystem (inside containers?).
It is true that HSM without anti-crash protection is less reliable,
but I think that it is still useful enough that users will want the
option to run it (?).

Think of my HttpDirFS demo - it's just a simple lazy mirroring
of a website. Even with low reliability I think it is useful (?).

> These handlers would return EACCESS unless
> there's somebody handling events and returning something else.
>
> You could then do:
>
> fan_fd = fanotify_init()
> ffd = fsopen()
> fsconfig(ffd, FSCONFIG_SET_STRING, "source", device, 0)
> fsconfig(ffd, FSCONFIG_SET_FLAG, "hsm", NULL, 0)
> rootfd = fsconfig(ffd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)
> fanotify_mark(fan_fd, FAN_MARK_ADD, ... , rootfd, NULL)
> <now you can move the superblock into the mount hierarchy>
>

Not too bad.
I think that "hsm_deny_mask=" mount options would give more flexibility,
but I could be convinced otherwise.

It's probably not a great idea to be running two different HSMs on the same
fs anyway, but if user has an old HSM version installed that handles only
pre-content events, I don't think that we want this old version if it happens
to be run by mistake, to allow for unsupervised create,rename,delete if the
admin wanted to atomically mount a fs that SHOULD be supervised by a
v2 HSM that knows how to handle pre-path events.

IOW, and "HSM bit" on sb is too broad IMO.

> This would elegantly solve the "what if HSM handler dies" problem as well
> as cleanly handle the setup. And we don't have to come up with a concept of
> "default mask".

We can still have a mask, it's just about the API to set it up.

> Now we still have the problem how to fill in the filesystem
> on pre-content event without deadlocking. As I was thinking about it the
> most elegant solution would IMHO be if the HSM handler could have a private
> mount flagged so that HSM is excluded from there (or it could place ignore
> mark on this mount for HSM events).

My HttpDirFS demo does it the other way around - HSM uses a mount
without a mark mount - but ignore mark works too.

> I think we've discarded similar ideas
> in the past because this is problematic with directory pre-content events
> because security hooks don't get the mountpoint. But what if we used
> security_path_* hooks for directory pre-content events?
>

No need for security_path_ * hooks.
In my POC, the pre-path hooks have the path argument.
For people who are not familiar with the term, here is man page draft
for "pre-path" events:
https://github.com/amir73il/man-pages/commits/fan_pre_path/

This is an out of date branch from the time that I called them
FAN_PRE_{CREATE,DELETE,MOVE_*} events:
https://github.com/amir73il/linux/commit/29c60e4db3068ff2cd7b2c5a73108afb2c19b868

They are implemented by replacing the mnt_want_write() calls
with mnt_want_write_{path,parent,parents}() calls.

This was done to make sure that they take the sb write srcu and call
the pre-path hook before taking sb writers freeze protection.

> > There is one more crazy idea that I was pondering -
> > what if we used the fanotify_fd as mount_fd arg to open_by_handle_at()?
> > The framing is that it is not the filesystem, but fanotify which actually
> > encoded the fsid+fid, so HSM could be asking fanotify to decode them.
> > Technically, the group could keep a unique map from fsid -> sb, then
> > fanotify group could decode an fanotify_event_info_fid buffer to a specific
> > inode on a specific fs.
> > Naturally, those decoded files would be FMODE_NONOTIFY.
> >
> > Too crazy?
>
> It sounds a bit complex and hooking into open_by_handle_at() code for this
> sounds a bit hacky. But I'm not completely rejecting this possibility if we
> don't find other options.

Your idea sounds better :)

Thanks,
Amir.

