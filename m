Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70F396F33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 10:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhFAIrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 04:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhFAIrF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:47:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EBF260FDA;
        Tue,  1 Jun 2021 08:45:23 +0000 (UTC)
Date:   Tue, 1 Jun 2021 10:45:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     tianyu zhou <tyjoe.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Missing check for CAP_SYS_ADMIN in do_reconfigure_mnt()
Message-ID: <20210601084520.y6wph3rdtehdxmxl@wittgenstein>
References: <CAM6ytZrBUMB6xpP_srni8VParnNiuFPZZ2H-WsWUJEZH_vSk1w@mail.gmail.com>
 <YLUXvOI433/W8EvD@casper.infradead.org>
 <CAM6ytZo5H3rvGqwJOAXmo1Zp3fxXH_ZLivGg1jNc9c_PgAkTUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM6ytZo5H3rvGqwJOAXmo1Zp3fxXH_ZLivGg1jNc9c_PgAkTUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 01, 2021 at 03:02:42AM +0800, tianyu zhou wrote:
> Thanks for reminding!
> 
> But here is one more question about the CAP_SYS_ADMIN check inside
> may_mount(): why does it check the CAP in
> current->nsproxy->mnt_ns->user_ns?

Because the caller needs to be privileged enough to create mounts in
that mount namespace. That's the first requirement. You don't want a
caller creating mounts or altering mounts even though someone explicitly
wanted to prevent them from doing that. Or from someone creating a new
user namespace mapping their own uid and gaining cap_sys_admin in the
userns and then starting to change mount options for everyone in that
mount namespace.

> 
> for do_remount(), it checks CAP_SYS_ADMIN in path->mnt->mnt_sb->s_user_ns;
> for path_mount(), it checks CAP_SYS_ADMIN in current->nsproxy->mnt_ns->user_ns.

You can't reach do_remount() other via path_mount(). So you get:

1. may_mount()
2. check_mnt()

which translates to:

1. Is the caller allowed to create/destroy etc. mounts in that mnt
   namespace?
2. Is the caller in the same mnt namespace that the mount is visible in
   they try to operate on?

The it comes down to the question whether the caller is trying to change
an option that affects the superblock, i.e. _all places where that
filesystem is visible_ or whether they try to change mount specific
options, i.e. options that only affect a specific mount.

For do_remount() it affects the whole filesystem so you need to check
whether the caller is privileged over the filesystem itself, i.e.
whether they are capable in the s_user_ns of the filesystem. That should
also answer the next question:

> 
> Is these two user ns are same during runtime? (If they are same, then

No they don't need to be the same. Take a look at in do_remount():

	fc->oldapi = true;
	err = parse_monolithic_mount_data(fc, data);
	if (!err) {
		down_write(&sb->s_umount);
		err = -EPERM;
		if (ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {

^^
Here is were we check that the caller is allowed to alter the
superblock. So if you end up there you have checked 3 things so far:

[x] Allowed to mount in that mnt namespace 
[x] Located in the same mnt namespace as the mount
[x] Privileged wrt to the superblock


> it will be redundant check in path_mount() and its callee
> do_remount(); if they are not same, maybe do_reconfigure_mnt() need

No, do_reconfigure_mnt() affects mount specific options, not the
superblock. So it's enough to know:

[x] Allowed to mount in that mnt namespace
[x] Located in the same mnt namespace as the mount

> more check for path->mnt->mnt_sb->s_user_ns)
> 
> Tianyu
> 
> Matthew Wilcox <willy@infradead.org> 于2021年6月1日周二 上午1:07写道：
> >
> > On Mon, May 31, 2021 at 10:59:54PM +0800, tianyu zhou wrote:
> > > Hi, function do_remount() in fs/namespace.c checks the CAP_SYS_ADMIN
> > > before it calls set_mount_attributes().
> > >
> > > However, in another caller of set_mount_attributes(),
> > > do_reconfigure_mnt(), I have not found any check for CAP_SYS_ADMIN.
> > > So, is there a missing check bug inside do_reconfigure_mnt() ? (which
> > > makes it possible for normal user to reach set_mount_attributes())
> >
> > You weren't looking hard enough ...
> >
> > path_mount()
> >         if (!may_mount())
> >                 return -EPERM;
> > ...
> >         if ((flags & (MS_REMOUNT | MS_BIND)) == (MS_REMOUNT | MS_BIND))
> >                 return do_reconfigure_mnt(path, mnt_flags);
> >
> > (this is the only call to do_reconfigure_mnt())
> >
> > and:
> >
> > static inline bool may_mount(void)
> > {
> >         return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
> > }
> >
