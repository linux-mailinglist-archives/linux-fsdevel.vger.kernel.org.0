Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481EA47447E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 15:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhLNOGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 09:06:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbhLNOGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:06:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 220BB2112A;
        Tue, 14 Dec 2021 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639490791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TeoUQzfB0p+Iw/W5+piv2iohXPmMvpV8EeVXds9/+C0=;
        b=ZIMG3MuhzqN4g9PchnYBPlVCPi0uP/jn4VpoH9aUX6BU9RJ8g6R/tSym3E/er7cM+OUNLV
        DweN3bcGlBmA7wHa/m6L19PQbOOUMVUeSRaavBJMRqT/NbxLgRuaxLRwrSMOZrn4EkA9Og
        VgfkZXTy23fbf696FN40bXsV0nNfpc0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB0D613C66;
        Tue, 14 Dec 2021 14:06:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8hseNOakuGHCPAAAMHmgww
        (envelope-from <ailiop@suse.com>); Tue, 14 Dec 2021 14:06:30 +0000
Date:   Tue, 14 Dec 2021 15:06:29 +0100
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH - regression] devtmpfs: reconfigure on each mount
Message-ID: <Ybik5dWF2w06JQM6@technoir>
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
 <20211213125906.ngqbjsywxwibvcuq@wittgenstein>
 <YbexPXpuI8RdOb8q@technoir>
 <20211214101207.6yyp7x7hj2nmrmvi@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211214101207.6yyp7x7hj2nmrmvi@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:12:07AM +0100, Christian Brauner wrote:
> On Mon, Dec 13, 2021 at 09:46:53PM +0100, Anthony Iliopoulos wrote:
> > On Mon, Dec 13, 2021 at 01:59:06PM +0100, Christian Brauner wrote:
> > > On Mon, Dec 13, 2021 at 12:12:26PM +1100, NeilBrown wrote:
> > > > 
> > > > Prior to Linux v5.4 devtmpfs used mount_single() which treats the given
> > > > mount options as "remount" options, updating the configuration of the
> > > > single super_block on each mount.
> > > > Since that was changed, the mount options used for devtmpfs are ignored.
> > > > This is a regression which affects systemd - which mounts devtmpfs
> > > > with "-o mode=755,size=4m,nr_inodes=1m".
> > > > 
> > > > This patch restores the "remount" effect by calling reconfigure_single()
> > > > 
> > > > Fixes: d401727ea0d7 ("devtmpfs: don't mix {ramfs,shmem}_fill_super() with mount_single()")
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > 
> > > Hey Neil,
> > > 
> > > So far this hasn't been an issue for us in systemd upstream. Is there a
> > > specific use-case where this is causing issues? I'm mostly asking
> > > because this change is fairly old.
> > 
> > This is standard init with systemd for SLE, where the systemd-provided
> > mount params for devtmpfs are being effectively ignored due to this
> > regression, so nr_inodes and size params are falling back to kernel
> > defaults. It is also not specific to systemd, and can be easily
> > reproduced by e.g. booting with devtmpfs.mount=0 and doing mount -t
> > devtmpfs none /dev -o nr_inodes=1024.
> > 
> > > What I actually find more odd is that there's no .reconfigure for
> > > devtmpfs for non-vfs generic mount options it supports.
> > 
> > There is a .reconfigure for devtmpfs, e.g. shmem_init_fs_context sets
> > fc->ops to shmem_fs_context_ops, so everything goes through
> > shmem_reconfigure.
> > 
> > > So it's possible to change vfs generic stuff like
> > > 
> > > mount -o remount,ro,nosuid /dev
> > > 
> > > but none of the other mount options it supports and there's no word lost
> > > anywhere about whether or not that's on purpose.
> > 
> > That's not the case: even after d401727ea0d7 a remount can change any
> > shmem-specific mount params.
> > 
> > > It feels odd because it uses the fs parameters from shmem/ramfs
> > > 
> > > const struct fs_parameter_spec shmem_fs_parameters[] = {
> > > 	fsparam_u32   ("gid",		Opt_gid),
> > > 	fsparam_enum  ("huge",		Opt_huge,  shmem_param_enums_huge),
> > > 	fsparam_u32oct("mode",		Opt_mode),
> > > 	fsparam_string("mpol",		Opt_mpol),
> > > 	fsparam_string("nr_blocks",	Opt_nr_blocks),
> > > 	fsparam_string("nr_inodes",	Opt_nr_inodes),
> > > 	fsparam_string("size",		Opt_size),
> > > 	fsparam_u32   ("uid",		Opt_uid),
> > > 	fsparam_flag  ("inode32",	Opt_inode32),
> > > 	fsparam_flag  ("inode64",	Opt_inode64),
> > > 	{}
> > > }
> > > 
> > > but doesn't allow to actually change them neither with your fix or with
> > > the old way of doing things. But afaict, all of them could be set via
> > 
> > As per above, all those mount params are changeable via remount
> > irrespective of the regression. What d401727ea0d7 regressed is that all
> 
> Ah, I missed that. So shmem_reconfigure simple ignores some options for
> remount instead of returning an error. That's annoying:
> 
> root@f2-vm:~# findmnt  | grep devtmpfs
> ├─/dev                         udev          devtmpfs    rw,nosuid,noexec,relatime,size=1842984k,nr_inodes=460746,mode=755,inode64
> 
> root@f2-vm:~# mount -o remount,gid=1000 /dev/
> root@f2-vm:~# findmnt  | grep devtmpfs
> ├─/dev                         udev          devtmpfs    rw,nosuid,noexec,relatime,size=1842984k,nr_inodes=460746,mode=755,inode64
> 
> root@f2-vm:~# mount -o remount,mode=600 /dev
> root@f2-vm:~# findmnt  | grep devtmpfs
> ├─/dev                         udev          devtmpfs    rw,nosuid,noexec,relatime,size=1842984k,nr_inodes=460746,mode=755,inode64

This is a slightly different issue: shmem_reconfigure intentionally and
specifically does not reconfigure any of the uid/gid/mode options that
you picked in the above examples, and those can only be set on initial
mounts (and only on tmpfs, not devtmpfs).

This was the case since devtmps inception given that there was always an
internal kernel mount with hardcoded mount options (mode=0755), and any
subsequent public mounts from userspace are simply remounts (thus for
devtmpfs specifying uid/gid/mode was never possible).

But any other shmem-specific mount option that can be reconfigured via
remounts is working irrespective of this regression. What has really
regressed is the ability to set the rest of the shmem_fs_parameters on
devtmpfs on initial mounts (remounts work just fine).

> > those params are being ignored on new mounts only (and thus any init
> > that mounts devtmpfs with params would be affected).
> > 
> > > the "devtmpfs.mount" kernel command line option. So I could set gid=,
> > > uid=, and mpol= for devtmpfs via devtmpfs.mount but wouldn't be able to
> > > change it through remount or - in your case - with a mount with new
> > > parameters?
> > 
> > The devtmpfs.mount kernel boot param only controls if devtmpfs will be
> > automatically mounted by the kernel during boot, and has nothing to do
> > with the actual tmpfs mount params.
> 
> Thanks!
> I'm not a fan of a proper mount changing mount options tbh but if it is
> a regression for users then we should fix it.
> Though I'm surprised it took that such a long time to even realize that
> there was a regression.

I think this is due to the devtmpfs shmem options falling back to kernel
defaults, which are apparently good enough for most use-cases. The only
reason we observed the regression is due to a customer case where the
avail inodes in /dev where exhausted and thus userspace was getting
-ENOSPC. Subsequent attempts to raise the nr_inodes during boot were
failing due to the regression.

Regards,
Anthony
