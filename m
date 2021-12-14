Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3A474027
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 11:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhLNKMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 05:12:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60228 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhLNKMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:12:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 771EB6144A;
        Tue, 14 Dec 2021 10:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A609BC34600;
        Tue, 14 Dec 2021 10:12:11 +0000 (UTC)
Date:   Tue, 14 Dec 2021 11:12:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH - regression] devtmpfs: reconfigure on each mount
Message-ID: <20211214101207.6yyp7x7hj2nmrmvi@wittgenstein>
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
 <20211213125906.ngqbjsywxwibvcuq@wittgenstein>
 <YbexPXpuI8RdOb8q@technoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbexPXpuI8RdOb8q@technoir>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:46:53PM +0100, Anthony Iliopoulos wrote:
> On Mon, Dec 13, 2021 at 01:59:06PM +0100, Christian Brauner wrote:
> > On Mon, Dec 13, 2021 at 12:12:26PM +1100, NeilBrown wrote:
> > > 
> > > Prior to Linux v5.4 devtmpfs used mount_single() which treats the given
> > > mount options as "remount" options, updating the configuration of the
> > > single super_block on each mount.
> > > Since that was changed, the mount options used for devtmpfs are ignored.
> > > This is a regression which affects systemd - which mounts devtmpfs
> > > with "-o mode=755,size=4m,nr_inodes=1m".
> > > 
> > > This patch restores the "remount" effect by calling reconfigure_single()
> > > 
> > > Fixes: d401727ea0d7 ("devtmpfs: don't mix {ramfs,shmem}_fill_super() with mount_single()")
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > 
> > Hey Neil,
> > 
> > So far this hasn't been an issue for us in systemd upstream. Is there a
> > specific use-case where this is causing issues? I'm mostly asking
> > because this change is fairly old.
> 
> This is standard init with systemd for SLE, where the systemd-provided
> mount params for devtmpfs are being effectively ignored due to this
> regression, so nr_inodes and size params are falling back to kernel
> defaults. It is also not specific to systemd, and can be easily
> reproduced by e.g. booting with devtmpfs.mount=0 and doing mount -t
> devtmpfs none /dev -o nr_inodes=1024.
> 
> > What I actually find more odd is that there's no .reconfigure for
> > devtmpfs for non-vfs generic mount options it supports.
> 
> There is a .reconfigure for devtmpfs, e.g. shmem_init_fs_context sets
> fc->ops to shmem_fs_context_ops, so everything goes through
> shmem_reconfigure.
> 
> > So it's possible to change vfs generic stuff like
> > 
> > mount -o remount,ro,nosuid /dev
> > 
> > but none of the other mount options it supports and there's no word lost
> > anywhere about whether or not that's on purpose.
> 
> That's not the case: even after d401727ea0d7 a remount can change any
> shmem-specific mount params.
> 
> > It feels odd because it uses the fs parameters from shmem/ramfs
> > 
> > const struct fs_parameter_spec shmem_fs_parameters[] = {
> > 	fsparam_u32   ("gid",		Opt_gid),
> > 	fsparam_enum  ("huge",		Opt_huge,  shmem_param_enums_huge),
> > 	fsparam_u32oct("mode",		Opt_mode),
> > 	fsparam_string("mpol",		Opt_mpol),
> > 	fsparam_string("nr_blocks",	Opt_nr_blocks),
> > 	fsparam_string("nr_inodes",	Opt_nr_inodes),
> > 	fsparam_string("size",		Opt_size),
> > 	fsparam_u32   ("uid",		Opt_uid),
> > 	fsparam_flag  ("inode32",	Opt_inode32),
> > 	fsparam_flag  ("inode64",	Opt_inode64),
> > 	{}
> > }
> > 
> > but doesn't allow to actually change them neither with your fix or with
> > the old way of doing things. But afaict, all of them could be set via
> 
> As per above, all those mount params are changeable via remount
> irrespective of the regression. What d401727ea0d7 regressed is that all

Ah, I missed that. So shmem_reconfigure simple ignores some options for
remount instead of returning an error. That's annoying:

root@f2-vm:~# findmnt  | grep devtmpfs
├─/dev                         udev          devtmpfs    rw,nosuid,noexec,relatime,size=1842984k,nr_inodes=460746,mode=755,inode64

root@f2-vm:~# mount -o remount,gid=1000 /dev/
root@f2-vm:~# findmnt  | grep devtmpfs
├─/dev                         udev          devtmpfs    rw,nosuid,noexec,relatime,size=1842984k,nr_inodes=460746,mode=755,inode64

root@f2-vm:~# mount -o remount,mode=600 /dev
root@f2-vm:~# findmnt  | grep devtmpfs
├─/dev                         udev          devtmpfs    rw,nosuid,noexec,relatime,size=1842984k,nr_inodes=460746,mode=755,inode64


> those params are being ignored on new mounts only (and thus any init
> that mounts devtmpfs with params would be affected).
> 
> > the "devtmpfs.mount" kernel command line option. So I could set gid=,
> > uid=, and mpol= for devtmpfs via devtmpfs.mount but wouldn't be able to
> > change it through remount or - in your case - with a mount with new
> > parameters?
> 
> The devtmpfs.mount kernel boot param only controls if devtmpfs will be
> automatically mounted by the kernel during boot, and has nothing to do
> with the actual tmpfs mount params.

Thanks!
I'm not a fan of a proper mount changing mount options tbh but if it is
a regression for users then we should fix it.
Though I'm surprised it took that such a long time to even realize that
there was a regression.
