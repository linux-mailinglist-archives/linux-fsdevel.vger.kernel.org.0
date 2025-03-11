Return-Path: <linux-fsdevel+bounces-43739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE4A5D146
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 21:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04933B83ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 20:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702E264A96;
	Tue, 11 Mar 2025 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqgI8vXg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1D23F378;
	Tue, 11 Mar 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726750; cv=none; b=aTccXIrvia8XGEY0mwhie7WBXhOyNdSWzrfpYaB/gFk6bkjNVCooZYvYv8V1qbHSXDu9ftEknJO65pV8a/7AQE5rg9rNp+R7pIxo+mwCLoIaxEvTtQdsMjSQ/x2eXrk0jdqXusCI07hNSAOYhc06B1/SE7CGXVx4L+qEi33flbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726750; c=relaxed/simple;
	bh=0xRMvRm4vCrR3Z1ccNJo+c6Xs7IGImXOfqk7Fe1kZzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kO3k0b6gODqudC5yP6kI25Ue4my76jayZ2SSNQ1pOFcYjy2UNTLu4HQ58W2hmXVRF7i6Koe1AjeLvtH5GCWq5CWifIy/MMAp+79WdAx63II1Df+HLTq8TvkXlo8/XUjxNsn5Hb0QeMHmpayK4cd70LyZpShaVroUBfodiyfkz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqgI8vXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D37C4CEEF;
	Tue, 11 Mar 2025 20:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741726749;
	bh=0xRMvRm4vCrR3Z1ccNJo+c6Xs7IGImXOfqk7Fe1kZzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BqgI8vXgFuu5YOiB/k2w2+EMQwDkK24fWnWhzNYrZHkQzhOGCKYOn13ssQrb9/IRM
	 rpDPazIeHPoHfKlAFQJnBLIeL7RPXLSF4cvDiCC5ef0DaJTkRdlU4rgrvNwNnRiaxm
	 Og+Sd4sh9VRcW53HOWuytoXKY4sizxLs7jkE7XGDR4eRW7OxTU8yfffhv5Gn5WhjnW
	 Nu1PZvTZtgZKTYo+Tg6+N9yA+nT3juhhhyA6TQR5wUTZQLKBEJrBKFPWfhy390YBk9
	 Unra8dOHEBmbMvYdvAW2d1Dnzfk0efKiNbKDzh3QN3NKaK9piMbT5uXeaXADpeoDtb
	 yAV6yE5usV69g==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d3db3b68a7so49043765ab.0;
        Tue, 11 Mar 2025 13:59:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8W/AnT5r5F753MRThmwwK+D/UKOq9zO+PYJ2/wh1uaO1nGZsGFZdfMR2T9vSoWvJXtpkFPCnjVgJuAOqkqotYGyRcgJTh@vger.kernel.org, AJvYcCXr26frWBUxs27pRUjMHjIAAsFFNWpWZx8T1I+5BfTi4KXCLSWnsF/vAj3vSOxd0gi52Q6GgFQE7Y2WfegC@vger.kernel.org
X-Gm-Message-State: AOJu0YzXw4Tagk1Ttq9LX9FFcyh2LoeNlH/RthTB3T6wu1V5Og09mL+z
	uKSmXbKo1mdmv01yPhZ4PjaTDMpmzjAyRFd5yo3UXQAmylK61klbo4wYfckfeCFyTC674Nd+ED/
	C9G+3wd6toVPQGhE1AFo/QO3dqo4=
X-Google-Smtp-Source: AGHT+IFcqLpAQEN4TNjzJWix5Q/CgWY1Co/fQT+HcrZxnc7I85sHG0VvKAL2EUYPw9pz8Se7djX9/F2+77JT1Uijbc8=
X-Received: by 2002:a05:6e02:1d8d:b0:3d3:e287:3e7a with SMTP id
 e9e14a558f8ab-3d441962873mr197868225ab.19.1741726749030; Tue, 11 Mar 2025
 13:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741047969.git.m@maowtm.org> <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org> <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
 <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org> <20250311.Ti7bi9ahshuu@digikod.net>
In-Reply-To: <20250311.Ti7bi9ahshuu@digikod.net>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Mar 2025 13:58:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4YXGFY___8x7my4tUbgyp5N4FHSQpJpKgEDK6r0vphAA@mail.gmail.com>
X-Gm-Features: AQ5f1Joc0GXD_ObvgOc0-61aoLMx6VfogWzLg5XLq1-76F2qnHpXXDg8tfSl408
Message-ID: <CAPhsuW4YXGFY___8x7my4tUbgyp5N4FHSQpJpKgEDK6r0vphAA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Tycho Andersen <tycho@tycho.pizza>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Paul Moore <paul@paul-moore.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:28=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> On Tue, Mar 11, 2025 at 12:42:05AM +0000, Tingmao Wang wrote:
> > On 3/6/25 17:07, Amir Goldstein wrote:
> > [...]
> > >
> > > w.r.t sharing infrastructure with fanotify, I only looked briefly at
> > > your patches
> > > and I have only a vague familiarity with landlock, so I cannot yet fo=
rm an
> > > opinion whether this is a good idea, but I wanted to give you a few m=
ore
> > > data points about fanotify that seem relevant.
> > >
> > > 1. There is already some intersection of fanotify and audit lsm via t=
he
> > > fanotify_response_info_audit_rule extension for permission
> > > events, so it's kind of a precedent of using fanotify to aid an lsm
> > >
> > > 2. See this fan_pre_modify-wip branch [1] and specifically commit
> > >    "fanotify: introduce directory entry pre-modify permission events"
> > > I do have an intention to add create/delete/rename permission events.
> > > Note that the new fsnotify hooks are added in to do_ vfs helpers, not=
 very
> > > far from the security_path_ lsm hooks, but not exactly in the same pl=
ace
> > > because we want to fsnotify hooks to be before taking vfs locks, to a=
llow
> > > listener to write to filesystem from event context.
> > > There are different semantics than just ALLOW/DENY that you need,
> > > therefore, only if we move the security_path_ hooks outside the
> > > vfs locks, our use cases could use the same hooks
> >
> > Hi Amir,
> >
> > (this is a slightly long message - feel free to respond at your conveni=
ence,
> > thank you in advance!)
> >
> > Thanks a lot for mentioning this branch, and for the explanation! I've =
had a
> > look and realized that the changes you have there will be very useful f=
or
> > this patch, and in fact, I've already tried a worse attempt of this (no=
t
> > included in this patch series yet) to create some security_pathname_ ho=
oks
> > that takes the parent struct path + last name as char*, that will be ca=
lled
> > before locking the parent.  (We can't have an unprivileged supervisor c=
ause
> > a directory to be locked indefinitely, which will also block users outs=
ide
> > of the landlock domain)
> >
> > I'm not sure if we can move security_path tho, because it takes the den=
try
> > of the child as an argument, and (I think at least for create / mknod /
> > link) that dentry is only created after locking.  Hence the proposal fo=
r
> > separate security_pathname_ hooks.  A search shows that currently AppAr=
mor
> > and TOMOYO (plus Landlock) uses the security_path_ hooks that would nee=
d
> > changing, if we move it (and we will have to understand if the move is =
ok to
> > do for the other two LSMs...)
> >
> > However, I think it would still make a lot of sense to align with fsnot=
ify
> > here, as you have already made the changes that I would need to do anyw=
ay
> > should I implement the proposed new hooks.  I think a sensible thing mi=
ght
> > be to have the extra LSM hooks be called alongside fsnotify_(re)name_pe=
rm -
> > following the pattern of what currently happens with fsnotify_open_perm
> > (i.e. security_file_open called first, then fsnotify_open_perm right af=
ter).

I think there is a fundamental difference between LSM hooks and fsnotify,
so putting fsnotify behind some LSM hooks might be weird. Specifically,
LSM hooks are always global. If a LSM attaches to a hook, say
security_file_open, it will see all the file open calls in the system. On t=
he
other hand, each fsnotify rule only applies to a group, so that one fanotif=
y
handler doesn't touch files watched by another fanotify handler. Given this
difference, I am not sure how fsnotify LSM hooks should look like.

Does this make sense?

> Yes, I think it would make sense to use the same hooks for fanotify and
> other security subsystems, or at least to share them.  It would improve
> consistency across different Linux subsystems and simplify changes and
> maintenance where these hooks are called.

[...]

> > --
> >
> > For Micka=C3=ABl,
> >
> > Would you be on board with changing Landlock to use the new hooks as
> > mentioned above?  My thinking is that it shouldn't make any difference =
in
> > terms of security - Landlock permissions for e.g. creating/deleting fil=
es
> > are based on the parent, and in fact except for link and rename, the
> > hook_path_ functions in Landlock don't even use the dentry argument.  I=
f
> > you're happy with the general direction of this, I can investigate furt=
her
> > and test it out etc.  This change might also reduce the impact of Landl=
ock
> > on non-landlocked processes, if we avoid holding exclusive inode lock w=
hile
> > evaluating rules / traversing paths...? (Just a thought, not measured)

I think the filter for process/thread is usually faster than the filter for
file/path/subtree? Therefore, it is better for landlock to check the filter=
 for
process/thread first. Did I miss/misunderstand something?

Thanks,
Song




> This looks reasonable.  As long as the semantic does not change it
> should be good and Landlock tests should pass.  That would also require
> other users of this hook to make sure it works for them too.  If it is
> not the case, I guess we could add an alternative hooks with different
> properties.  However, see the issue and the alternative approach below.
>

