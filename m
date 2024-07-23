Return-Path: <linux-fsdevel+bounces-24154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2A93A7C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 21:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EEA1F22E98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2B1422CA;
	Tue, 23 Jul 2024 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eWMs9ieU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2C13F456
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764133; cv=none; b=arC9jaboL13yXbzW+udkz3XbO0W7RexJRmkN6axYlE2ypV1qcVmThRAxanHuu+KL+M1Bi2dYE95T6qkd/Rd13iZXXIGrFe+fgAWboaS7oAKJYRK7ZWbLvfm7XjrfxrRcDW6mNG2jj1p7wZZeHYsv7Yq7+EmrfarBgG5A3hcWFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764133; c=relaxed/simple;
	bh=bYLxHOhEU+Zp51G0LpqfUxnSFeXVz781+ABLldwFSko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfFMtR3z7bKxrDhV1X7DEEzuTOuzisqLQJ0ic2NPN0/99g4FpgiY155SZx0z3EEDheCCVyiLHKiQKKBr0Y3ShWwgAXb/WtMX6CDkO6cYFwGSpWR+KICHAEiW+7Ic4sxbkT/4W1aUiFm1gjZ1VGMhNtM9LJlMl8tN804ayc2p1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eWMs9ieU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e05e2b2d88bso5561771276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721764130; x=1722368930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnS3xKEFgnfQyUitOQWc1I0Q6R6pqx6TXDex6LBUNdo=;
        b=eWMs9ieUQWZsr/Z04TeSYuO8OoaRGNbMelLb9wG14jQcfDYqkoMM91DWw44Wf3Ktoc
         K0ooVWhaJQrIKkj7BrE3ZuQoJdVsJbrD8xi94x/gjqN5ZQFKXFBDg2K7PEsu6r2AB3OK
         nkKtX4CK+AMAWnXpbW2bbQ+WRQ3TKJ5Hp3M07ClImCmPpkPYbLLnDbB1I5VSD7+i6XDD
         FigIt5uiz3VgHxVqkM3rRQJGXva7dEFGXSZpW3SFJJExVdFYEk3Dg5VqmMGhpV3Iui7j
         Qg/4nVZKPPpKfeSFtnxRzDE+dN86kU1ySp66JaFsJXEmrsbjgCGSVJCzcNcfoA36A3Ly
         jZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721764130; x=1722368930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnS3xKEFgnfQyUitOQWc1I0Q6R6pqx6TXDex6LBUNdo=;
        b=C/Z3ChwZxJzHRHVeuZmPqmuG+AtjXvltLiu0uDmT5Nea6X5mgfZDQe/aQVD/Vs83yc
         yC9f2oqPRcEwfUEe8CqFR6wAaP/Ky3eG5UYNrf8Xovmxgre7CjPWkYjUOIedGsdruG42
         WXNe/0ki+CMV6uWie7X2RlkBZrTuqSSyPl8Yrawr0f40FYS3BKdgmVaQFl0TdPxhwk0A
         dJ7aDJyNlunVqU9e93Y71ir7VfNuv3xxfVogOmHTevh9By5K3t5NqfiqXQnZKDK522PK
         JMYhp/9C22H2quNO0sQjbchzUth78Eel6J4RgFIv8FgTF02LDVhAQemjefNmZlgy6Mj+
         gpwA==
X-Forwarded-Encrypted: i=1; AJvYcCWMmD8uDiyN3BzVmMhK1a7Kh7UBIOICN1UnKiGDCHMwnMqXm4EidQe5kVVeXTvwig+QGBWH5kMBDBekCssh26oaxx5Gy5Bw0qtGnNujLw==
X-Gm-Message-State: AOJu0YzWjU88gbMKqyaeMGIey5mw1iPZYkq1wWGTtbgvWg/emUtrvlNf
	ffOeRLokG8MlwDI9GCTC71zubu23WgalnhIOM6cZzYyYUr1utGLGbDc0B4NFbZXQdR3KXF2G00S
	X2NUnr4H0Bh+xRwa9L9NpsWL8dq8rS+hboYam
X-Google-Smtp-Source: AGHT+IHUYrj6Sm+2gmwsGjgo1dhS7pDIA8KVhNJX5HCD4Knd5Qs8R+aNGqrPRl9vAIiVaNDRvqCWZDE2bH23Mn9FNE0=
X-Received: by 2002:a05:6902:c0a:b0:dff:1020:6f31 with SMTP id
 3f1490d57ef6-e0b0985c49fmr888654276.45.1721764130208; Tue, 23 Jul 2024
 12:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <20240710.peiDu2aiD1su@digikod.net>
 <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk> <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
 <645268cd-bb8f-4661-bab8-faa827267682@stuba.sk>
In-Reply-To: <645268cd-bb8f-4661-bab8-faa827267682@stuba.sk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 23 Jul 2024 15:48:39 -0400
Message-ID: <CAHC9VhRnv0+4PZ9Qs-gFhMxmQc07_wr-_W41T45FztOkzD=__g@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Matus Jokay <matus.jokay@stuba.sk>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 5:27=E2=80=AFAM Matus Jokay <matus.jokay@stuba.sk> =
wrote:
> On 22. 7. 2024 21:46, Paul Moore wrote:
> > On Mon, Jul 22, 2024 at 8:30=E2=80=AFAM Matus Jokay <matus.jokay@stuba.=
sk> wrote:
> >> On 10. 7. 2024 12:40, Micka=C3=ABl Sala=C3=BCn wrote:
> >>> On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
> >>>> The LSM framework has an existing inode_free_security() hook which
> >>>> is used by LSMs that manage state associated with an inode, but
> >>>> due to the use of RCU to protect the inode, special care must be
> >>>> taken to ensure that the LSMs do not fully release the inode state
> >>>> until it is safe from a RCU perspective.
> >>>>
> >>>> This patch implements a new inode_free_security_rcu() implementation
> >>>> hook which is called when it is safe to free the LSM's internal inod=
e
> >>>> state.  Unfortunately, this new hook does not have access to the ino=
de
> >>>> itself as it may already be released, so the existing
> >>>> inode_free_security() hook is retained for those LSMs which require
> >>>> access to the inode.
> >>>>
> >>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>>
> >>> I like this new hook.  It is definitely safer than the current approa=
ch.
> >>>
> >>> To make it more consistent, I think we should also rename
> >>> security_inode_free() to security_inode_put() to highlight the fact t=
hat
> >>> LSM implementations should not free potential pointers in this blob
> >>> because they could still be dereferenced in a path walk.
> >>>
> >>>> ---
> >>>>  include/linux/lsm_hook_defs.h     |  1 +
> >>>>  security/integrity/ima/ima.h      |  2 +-
> >>>>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
> >>>>  security/integrity/ima/ima_main.c |  2 +-
> >>>>  security/landlock/fs.c            |  9 ++++++---
> >>>>  security/security.c               | 26 +++++++++++++-------------
> >>>>  6 files changed, 30 insertions(+), 30 deletions(-)
> >
> > ...
> >
> >> Sorry for the questions, but for several weeks I can't find answers to=
 two things related to this RFC:
> >>
> >> 1) How does this patch close [1]?
> >>    As Micka=C3=ABl pointed in [2], "It looks like security_inode_free(=
) is called two times on the same inode."
> >>    Indeed, it does not seem from the backtrace that it is a case of ra=
ce between destroy_inode and inode_permission,
> >>    i.e. referencing the inode in a VFS path walk while destroying it..=
.
> >>    Please, can anyone tell me how this situation could have happened? =
Maybe folks from VFS... I added them to the copy.
> >
> > The VFS folks can likely provide a better, or perhaps a more correct
> > answer, but my understanding is that during the path walk the inode is
> > protected by a RCU lock which allows for multiple threads to access
> > the inode simultaneously; this could result in some cases where one
> > thread is destroying the inode while another is accessing it.
> > Changing this would require changes to the VFS code, and I'm not sure
> > why you would want to change it anyway, the performance win of using
> > RCU here is likely significant.
> >
> >> 2) Is there a guarantee that inode_free_by_rcu and i_callback will be =
called within the same RCU grace period?
> >
> > I'm not an RCU expert, but I don't believe there are any guarantees
> > that the inode_free_by_rcu() and the inode's own free routines are
> > going to be called within the same RCU grace period (not really
> > applicable as inode_free_by_rcu() isn't called *during* a grace
> > period, but *after* the grace period of the associated
> > security_inode_free() call).  However, this patch does not rely on
> > synchronization between the inode and inode LSM free routine in
> > inode_free_by_rcu(); the inode_free_by_rcu() function and the new
> > inode_free_security_rcu() LSM callback does not have a pointer to the
> > inode, only the inode's LSM blob.  I agree that it is a bit odd, but
> > freeing the inode and inode's LSM blob independently of each other
> > should not cause a problem so long as the inode is no longer in use
> > (hence the RCU callbacks).
>
> Paul, many thanks for your answer.
>
> I will try to clarify the issue, because fsnotify was a bad example.
> Here is the related code taken from v10.
>
> void security_inode_free(struct inode *inode)
> {
>         call_void_hook(inode_free_security, inode);
>         /*
>          * The inode may still be referenced in a path walk and
>          * a call to security_inode_permission() can be made
>          * after inode_free_security() is called. Ideally, the VFS
>          * wouldn't do this, but fixing that is a much harder
>          * job. For now, simply free the i_security via RCU, and
>          * leave the current inode->i_security pointer intact.
>          * The inode will be freed after the RCU grace period too.
>          */
>         if (inode->i_security)
>                 call_rcu((struct rcu_head *)inode->i_security,
>                          inode_free_by_rcu);
> }
>
> void __destroy_inode(struct inode *inode)
> {
>         BUG_ON(inode_has_buffers(inode));
>         inode_detach_wb(inode);
>         security_inode_free(inode);
>         fsnotify_inode_delete(inode);
>         locks_free_lock_context(inode);
>         if (!inode->i_nlink) {
>                 WARN_ON(atomic_long_read(&inode->i_sb->s_remove_count) =
=3D=3D 0);
>                 atomic_long_dec(&inode->i_sb->s_remove_count);
>         }
>
> #ifdef CONFIG_FS_POSIX_ACL
>         if (inode->i_acl && !is_uncached_acl(inode->i_acl))
>                 posix_acl_release(inode->i_acl);
>         if (inode->i_default_acl && !is_uncached_acl(inode->i_default_acl=
))
>                 posix_acl_release(inode->i_default_acl);
> #endif
>         this_cpu_dec(nr_inodes);
> }
>
> static void destroy_inode(struct inode *inode)
> {
>         const struct super_operations *ops =3D inode->i_sb->s_op;
>
>         BUG_ON(!list_empty(&inode->i_lru));
>         __destroy_inode(inode);
>         if (ops->destroy_inode) {
>                 ops->destroy_inode(inode);
>                 if (!ops->free_inode)
>                         return;
>         }
>         inode->free_inode =3D ops->free_inode;
>         call_rcu(&inode->i_rcu, i_callback);
> }
>
> Yes, inode_free_by_rcu() is being called after the grace period of the as=
sociated
> security_inode_free(). i_callback() is also called after the grace period=
, but is it
> always the same grace period as in the case of inode_free_by_rcu()? If no=
t in general,
> maybe it could be a problem. Explanation below.
>
> If there is a function call leading to the end of the grace period betwee=
n
> call_rcu(inode_free_by_rcu) and call_rcu(i_callback) (by reaching a CPU q=
uiescent state
> or another mechanism?), there will be a small time window, when the inode=
 security
> context is released, but the inode itself not, because call_rcu(i_callbac=
k) was not called
> yet. So in that case each access to inode security blob leads to UAF.

While it should be possible for the inode's LSM blob to be free'd
prior to the inode itself, the RCU callback mechanism provided by
call_rcu() should ensure that both the LSM's free routine and the
inode's free routine happen at a point in time after the current RCU
critical sections have lapsed and the inode is no longer being
accessed.  The LSM's inode_free_rcu callback can run independent of
the inode's callback as it doesn't access the inode and if it does
happen to run before the inode's RCU callback that should also be okay
as we are past the original RCU critical sections and the inode should
no longer be in use.  If the inode is still in use by the time the
LSM's RCU callback is triggered then there is a flaw in the inode
RCU/locking/synchronization code.

It is also worth mentioning that while this patch shuffles around some
code at the LSM layer, the basic idea of the LSM using a RCU callback
to free state associated with an inode is far from new.  While that
doesn't mean there isn't a problem, we have a few years of experience
across a large number of systems, that would indicate this isn't a
problem.

> For example, see invoking ops->destroy_inode() after call_rcu(inode_free_=
by_rcu) but
> *before* call_rcu(i_callback). If destroy_inode() may sleep, can be reach=
ed end of the
> grace period? destroy_inode() is *before* call_rcu(i_callback), therefore=
 simultaneous
> access to the inode during path lookup may be performed. Note: I use dest=
roy_inode() as
> *an example* of the idea. I'm not expert at all in fsnotify, posix ACL, V=
FS in general
> and RCU, too.
>
> In the previous message I only mentioned fsnotify, but it was only as an =
example.
> I think that destroy_inode() is a better example of the idea I wanted to =
express.
>
> I repeat that I'm aware that this RFC does not aim to solve this issue. B=
ut it can be
> unpleasant to get another UAF in a production environment.

I'm open to there being another fix needed, or a change to this fix,
but I don't believe the problems you are describing are possible.  Of
course it's very possible that I'm wrong, so if you are aware of an
issue I would appreciate a concrete example explaining the code path
and timeline between tasks A and B that would trigger the flaw ... and
yes, patches are always welcome ;)

--=20
paul-moore.com

