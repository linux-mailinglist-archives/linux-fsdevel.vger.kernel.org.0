Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06A579DCCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 01:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbjILXnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 19:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjILXnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:43:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F510C7;
        Tue, 12 Sep 2023 16:42:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57309C433C7;
        Tue, 12 Sep 2023 23:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694562176;
        bh=FTp6QbUojXypnPY4wsouYYzFaR9mgQ62iznyfT9c/pg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sqVeZDE3XlB88LIk0ChtwHv/e3RbMbekhLfF3dAhFQhxH0zbYo6fspVsvyGIZ+ZfU
         kk1XSrcjkgv4gpYKQzUe69sIXpChPoYe4lNNLIrLnwms2nl+uXCTqhjlr6wYcgzqcl
         aPf6FQmmgInkf1JoDBYXtw7VSY8L+mhAkBt9WbFqzRIVCkLLNWh0QQexRaVN1whL/K
         V3i1N94jhKiXL/T676cR7V1pjnA0SWIMW4jBSsXDxbIUi71sY7lkPly2j2+2A88k4b
         lWVm+RReJyygXMuwwhSSuKPtpNJMyJo2Rv8oHTAjAUGtU95yXqZlxrquSeN1ifzf62
         +Tbf7QBWJMskQ==
Message-ID: <6ca8150eb6e84533ee2a687a542350b5be17966c.camel@kernel.org>
Subject: Re: [PATCH] fs: have setattr_copy handle multigrain timestamps
 appropriately
From:   Jeff Layton <jlayton@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Sep 2023 19:42:53 -0400
In-Reply-To: <20230912231014.GA795188@dev-arch.thelio-3990X>
References: <20230830-kdevops-v1-1-ef2be57755dd@kernel.org>
         <20230912231014.GA795188@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-09-12 at 16:10 -0700, Nathan Chancellor wrote:
> Hi Jeff,
>=20
> On Wed, Aug 30, 2023 at 02:28:43PM -0400, Jeff Layton wrote:
> > The setattr codepath is still using coarse-grained timestamps, even on
> > multigrain filesystems. To fix this, we need to fetch the timestamp for
> > ctime updates later, at the point where the assignment occurs in
> > setattr_copy.
> >=20
> > On a multigrain inode, ignore the ia_ctime in the attrs, and always
> > update the ctime to the current clock value. Update the atime and mtime
> > with the same value (if needed) unless they are being set to other
> > specific values, a'la utimes().
> >=20
> > Note that we don't want to do this universally however, as some
> > filesystems (e.g. most networked fs) want to do an explicit update
> > elsewhere before updating the local inode.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/attr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 46 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/attr.c b/fs/attr.c
> > index a8ae5f6d9b16..8ba330e6a582 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -275,6 +275,42 @@ int inode_newsize_ok(const struct inode *inode, lo=
ff_t offset)
> >  }
> >  EXPORT_SYMBOL(inode_newsize_ok);
> > =20
> > +/**
> > + * setattr_copy_mgtime - update timestamps for mgtime inodes
> > + * @inode: inode timestamps to be updated
> > + * @attr: attrs for the update
> > + *
> > + * With multigrain timestamps, we need to take more care to prevent ra=
ces
> > + * when updating the ctime. Always update the ctime to the very latest
> > + * using the standard mechanism, and use that to populate the atime an=
d
> > + * mtime appropriately (unless we're setting those to specific values)=
.
> > + */
> > +static void setattr_copy_mgtime(struct inode *inode, const struct iatt=
r *attr)
> > +{
> > +	unsigned int ia_valid =3D attr->ia_valid;
> > +	struct timespec64 now;
> > +
> > +	/*
> > +	 * If the ctime isn't being updated then nothing else should be
> > +	 * either.
> > +	 */
> > +	if (!(ia_valid & ATTR_CTIME)) {
> > +		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
> > +		return;
> > +	}
>=20
> After this change in -next as commit d6f106662147 ("fs: have
> setattr_copy handle multigrain timestamps appropriately"), I see the
> following warning on all of my machines when starting my containers with
> podman/docker:
>=20
> [    0.000000] Linux version 6.6.0-rc1-00001-gd6f106662147 (nathan@dev-ar=
ch.thelio-3990X) (x86_64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41=
) #1 SMP PREEMPT_DYNAMIC Tue Sep 12 16:01:41 MST 2023
> ...
> [   91.484884] ------------[ cut here ]------------
> [   91.484889] WARNING: CPU: 2 PID: 721 at fs/attr.c:298 setattr_copy+0x1=
06/0x1b0
> [   91.484920] Modules linked in:
> [   91.484923] CPU: 2 PID: 721 Comm: podman Not tainted 6.6.0-rc1-00001-g=
d6f106662147 #1 33e7e76d587862399371bcd9c318a44e2ec9ced1
> [   91.484927] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0=
.0.0 02/06/2015
> [   91.484930] RIP: 0010:setattr_copy+0x106/0x1b0
> [   91.484933] Code: 44 0f 44 f8 48 8b 43 28 66 44 89 3b 48 8b 40 28 f6 4=
0 08 40 0f 84 59 ff ff ff 45 8b 2c 24 41 f6 c5 40 75 49 41 83 e5 30 74 94 <=
0f> 0b eb 90 48 8b 43 28 41 8b 54 24 0c 4c 89 f7 48 8b b0 90 04 00
> [   91.484934] RSP: 0018:ffffc90003d8f778 EFLAGS: 00010206
> [   91.484940] RAX: ffffffff9bb407c0 RBX: ffff888102ae44f8 RCX: ffff88811=
27ad0c0
> [   91.484941] RDX: ffffc90003d8f900 RSI: ffff888102ae44f8 RDI: ffffffff9=
bb346a0
> [   91.484942] RBP: ffffc90003d8f7a0 R08: ffff888101017300 R09: ffff88810=
2ae44f8
> [   91.484943] R10: 000000006500ee8f R11: 000000000cf2ee13 R12: ffffc9000=
3d8f900
> [   91.484943] R13: 0000000000000030 R14: ffffffff9bb346a0 R15: 000000000=
0000000
> [   91.484946] FS:  00007f155effd6c0(0000) GS:ffff88846fc80000(0000) knlG=
S:0000000000000000
> [   91.484947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   91.484948] CR2: 00007f155dffbd58 CR3: 000000010694a000 CR4: 000000000=
0350ee0
> [   91.484950] Call Trace:
> [   91.484951]  <TASK>
> [   91.484952]  ? setattr_copy+0x106/0x1b0
> [   91.484956]  ? __warn+0x81/0x130
> [   91.484969]  ? setattr_copy+0x106/0x1b0
> [   91.484971]  ? report_bug+0x171/0x1a0
> [   91.484987]  ? handle_bug+0x3c/0x80
> [   91.484991]  ? exc_invalid_op+0x17/0x70
> [   91.484992]  ? asm_exc_invalid_op+0x1a/0x20
> [   91.485007]  ? setattr_copy+0x106/0x1b0
> [   91.485009]  btrfs_setattr+0x3d0/0x830
> [   91.485021]  ? btrfs_setattr+0x3ea/0x830
> [   91.485023]  notify_change+0x1f5/0x4b0
> [   91.485028]  ? ovl_set_timestamps.isra.0+0x7d/0xa0
> [   91.485033]  ovl_set_timestamps.isra.0+0x7d/0xa0
> [   91.485040]  ovl_set_attr.part.0+0x9f/0xb0
> [   91.485043]  ovl_copy_up_metadata+0xb1/0x210
> [   91.485046]  ? ovl_mkdir_real+0x32/0xc0
> [   91.485048]  ovl_copy_up_one+0x6ab/0x14f0
> [   91.485050]  ? btrfs_search_slot+0x8c8/0xd00
> [   91.485056]  ? xa_load+0x8c/0xe0
> [   91.485063]  ovl_copy_up_flags+0xcf/0x100
> [   91.485067]  ovl_do_remove+0xa5/0x500
> [   91.485068]  ? inode_permission+0xde/0x190
> [   91.485075]  ? __pfx_bpf_lsm_inode_permission+0x10/0x10
> [   91.485081]  ? security_inode_permission+0x3e/0x60
> [   91.485090]  vfs_unlink+0x112/0x280
> [   91.485094]  do_unlinkat+0x14b/0x320
> [   91.485096]  __x64_sys_unlinkat+0x37/0x70
> [   91.485098]  do_syscall_64+0x60/0x90
> [   91.485100]  ? syscall_exit_to_user_mode+0x2b/0x40
> [   91.485104]  ? do_syscall_64+0x6c/0x90
> [   91.485106]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   91.485108] RIP: 0033:0x55d4e18b04ee
> [   91.485112] Code: 48 83 ec 38 e8 13 00 00 00 48 83 c4 38 5d c3 cc cc c=
c cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <=
48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
> [   91.485113] RSP: 002b:000000c0003874a0 EFLAGS: 00000212 ORIG_RAX: 0000=
000000000107
> [   91.485114] RAX: ffffffffffffffda RBX: 000000000000000a RCX: 000055d4e=
18b04ee
> [   91.485115] RDX: 0000000000000000 RSI: 000000c00027e1c0 RDI: 000000000=
000000a
> [   91.485116] RBP: 000000c0003874e0 R08: 0000000000000000 R09: 000000000=
0000000
> [   91.485116] R10: 0000000000000000 R11: 0000000000000212 R12: 000000000=
000001c
> [   91.485117] R13: 000000c000100800 R14: 000000c0000061a0 R15: 000000c00=
02f0060
> [   91.485119]  </TASK>
> [   91.485119] ---[ end trace 0000000000000000 ]---
>=20
> Is this expected?
>=20

No. Most likely this is a bug in overlayfs. It's trying to set the atime
and mtime w/o setting the ctime. I'll have to look at an appropriate
fix. Stay tuned.

Thanks for the bug report,
--=20
Jeff Layton <jlayton@kernel.org>
