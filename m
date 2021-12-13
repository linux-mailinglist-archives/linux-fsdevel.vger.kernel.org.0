Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C4473641
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 21:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbhLMUqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 15:46:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37182 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhLMUqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:46:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B7241F3B9;
        Mon, 13 Dec 2021 20:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639428414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IDroOlXAdO810vX1XF/59TmTl0cShSH1xEbqsk7KJ7M=;
        b=RPH26rMJzCkd02IPh9vazOqXJxpTXNto3h0uahP3kJ1Wro+LUP5eKrZ+Hh+b1hq9KKFCnn
        MW7bIhSPHFrRW/9CzIkqZ2bI3bBt2eWnZbZzZ9HqTYX1zS2JkfC1o+6z+35DYsEj8h7lVP
        4ynbQQoT7sjLqTGg281Vw2iAGWuJ+zA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C770C13EC0;
        Mon, 13 Dec 2021 20:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Id4LLz2xt2EFNwAAMHmgww
        (envelope-from <ailiop@suse.com>); Mon, 13 Dec 2021 20:46:53 +0000
Date:   Mon, 13 Dec 2021 21:46:53 +0100
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH - regression] devtmpfs: reconfigure on each mount
Message-ID: <YbexPXpuI8RdOb8q@technoir>
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
 <20211213125906.ngqbjsywxwibvcuq@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213125906.ngqbjsywxwibvcuq@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 01:59:06PM +0100, Christian Brauner wrote:
> On Mon, Dec 13, 2021 at 12:12:26PM +1100, NeilBrown wrote:
> > 
> > Prior to Linux v5.4 devtmpfs used mount_single() which treats the given
> > mount options as "remount" options, updating the configuration of the
> > single super_block on each mount.
> > Since that was changed, the mount options used for devtmpfs are ignored.
> > This is a regression which affects systemd - which mounts devtmpfs
> > with "-o mode=755,size=4m,nr_inodes=1m".
> > 
> > This patch restores the "remount" effect by calling reconfigure_single()
> > 
> > Fixes: d401727ea0d7 ("devtmpfs: don't mix {ramfs,shmem}_fill_super() with mount_single()")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> 
> Hey Neil,
> 
> So far this hasn't been an issue for us in systemd upstream. Is there a
> specific use-case where this is causing issues? I'm mostly asking
> because this change is fairly old.

This is standard init with systemd for SLE, where the systemd-provided
mount params for devtmpfs are being effectively ignored due to this
regression, so nr_inodes and size params are falling back to kernel
defaults. It is also not specific to systemd, and can be easily
reproduced by e.g. booting with devtmpfs.mount=0 and doing mount -t
devtmpfs none /dev -o nr_inodes=1024.

> What I actually find more odd is that there's no .reconfigure for
> devtmpfs for non-vfs generic mount options it supports.

There is a .reconfigure for devtmpfs, e.g. shmem_init_fs_context sets
fc->ops to shmem_fs_context_ops, so everything goes through
shmem_reconfigure.

> So it's possible to change vfs generic stuff like
> 
> mount -o remount,ro,nosuid /dev
> 
> but none of the other mount options it supports and there's no word lost
> anywhere about whether or not that's on purpose.

That's not the case: even after d401727ea0d7 a remount can change any
shmem-specific mount params.

> It feels odd because it uses the fs parameters from shmem/ramfs
> 
> const struct fs_parameter_spec shmem_fs_parameters[] = {
> 	fsparam_u32   ("gid",		Opt_gid),
> 	fsparam_enum  ("huge",		Opt_huge,  shmem_param_enums_huge),
> 	fsparam_u32oct("mode",		Opt_mode),
> 	fsparam_string("mpol",		Opt_mpol),
> 	fsparam_string("nr_blocks",	Opt_nr_blocks),
> 	fsparam_string("nr_inodes",	Opt_nr_inodes),
> 	fsparam_string("size",		Opt_size),
> 	fsparam_u32   ("uid",		Opt_uid),
> 	fsparam_flag  ("inode32",	Opt_inode32),
> 	fsparam_flag  ("inode64",	Opt_inode64),
> 	{}
> }
> 
> but doesn't allow to actually change them neither with your fix or with
> the old way of doing things. But afaict, all of them could be set via

As per above, all those mount params are changeable via remount
irrespective of the regression. What d401727ea0d7 regressed is that all
those params are being ignored on new mounts only (and thus any init
that mounts devtmpfs with params would be affected).

> the "devtmpfs.mount" kernel command line option. So I could set gid=,
> uid=, and mpol= for devtmpfs via devtmpfs.mount but wouldn't be able to
> change it through remount or - in your case - with a mount with new
> parameters?

The devtmpfs.mount kernel boot param only controls if devtmpfs will be
automatically mounted by the kernel during boot, and has nothing to do
with the actual tmpfs mount params.

Regards,
Anthony
