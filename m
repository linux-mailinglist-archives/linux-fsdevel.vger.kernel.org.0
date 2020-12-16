Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C932DC46E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgLPQjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 11:39:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:47338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgLPQjr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:39:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A76CAC7F;
        Wed, 16 Dec 2020 16:39:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8FA5FDA6E1; Wed, 16 Dec 2020 17:37:25 +0100 (CET)
Date:   Wed, 16 Dec 2020 17:37:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH] vfs: fix fsconfig(2) LSM mount option handling for btrfs
Message-ID: <20201216163725.GG6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
References: <20201118102342.154277-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118102342.154277-1-omosnace@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:23:42AM +0100, Ondrej Mosnacek wrote:
> When SELinux security options are passed to btrfs via fsconfig(2) rather
> than via mount(2), the operation aborts with an error. What happens is
> roughly this sequence:
> 
> 1. vfs_parse_fs_param() eats away the LSM options and parses them into
>    fc->security.
> 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
>    nothing to btrfs.
> [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
>  that for simplicity]
> 3. btrfs calls security_sb_set_mnt_opts() with empty options.
> 4. vfs_get_tree() then calls its own security_sb_set_mnt_opts() with the
>    options stashed in fc->security.
> 5. SELinux doesn't like that different options were used for the same
>    superblock and returns -EINVAL.
> 
> In the case of mount(2), the options are parsed by
> legacy_parse_monolithic(), which skips the eating away of security
> opts because of the FS_BINARY_MOUNTDATA flag, so they are passed to the
> FS via ctx->legacy_data. The second call to security_sb_set_mnt_opts()
> (from vfs_get_tree()) now passes empty opts, but the non-empty -> empty
> sequence is allowed by SELinux for the FS_BINARY_MOUNTDATA case.
> 
> It is a total mess, but the only sane fix for now seems to be to skip
> processing the security opts in vfs_parse_fs_param() if the fc has
> legacy opts set AND the fs specfies the FS_BINARY_MOUNTDATA flag. This
> combination currently matches only btrfs and coda. For btrfs this fixes
> the fsconfig(2) behavior, and for coda it makes setting security opts
> via fsconfig(2) fail the same way as it would with mount(2) (because
> FS_BINARY_MOUNTDATA filesystems are expected to call the mount opts LSM
> hooks themselves, but coda never cared enough to do that). I believe
> that is an acceptable state until both filesystems (or at least btrfs)
> are converted to the new mount API (at which point btrfs won't need to
> pretend it takes binary mount data any more and also won't need to call
> the LSM hooks itself, assuming it will pass the fc->security information
> properly).
> 
> Note that we can't skip LSM opts handling in vfs_parse_fs_param() solely
> based on FS_BINARY_MOUNTDATA because that would break NFS.
> 
> See here for the original report and reproducer:
> https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/
> 
> Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Can we get this merged via the vfs tree, please? Possibly with

CC: stable@vger.kernel.org # 5.4+

> +	/*
> +	 * In the legacy+binary mode, skip the security_fs_context_parse_param()
> +	 * call and let the legacy handler process also the security options.
> +	 * It will format them into the monolithic string, where the FS can
> +	 * process them (with FS_BINARY_MOUNTDATA it is expected to do it).
> +	 *
> +	 * Currently, this matches only btrfs and coda. Coda is broken with
> +	 * fsconfig(2) anyway, because it does actually take binary data. Btrfs
> +	 * only *pretends* to take binary data to work around the SELinux's
> +	 * no-remount-with-different-options check, so this allows it to work
> +	 * with fsconfig(2) properly.
> +	 *
> +	 * Once btrfs is ported to the new mount API, this hack can be reverted.
> +	 */
> +	if (fc->ops != &legacy_fs_context_ops || !(fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)) {

Line is way over 80, it could be split like

	if (fc->ops != &legacy_fs_context_ops ||
	    !(fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)) {

> +		ret = security_fs_context_parse_param(fc, param);
> +		if (ret != -ENOPARAM)
> +			/* Param belongs to the LSM or is disallowed by the LSM;
> +			 * so don't pass to the FS.
> +			 */

The multi line comment should have the /* on a separate line (yes it's
in the original code too but such things could be fixed when the code is
moved).

> +			return ret;
> +	}
>  
>  	if (fc->ops->parse_param) {
>  		ret = fc->ops->parse_param(fc, param);
