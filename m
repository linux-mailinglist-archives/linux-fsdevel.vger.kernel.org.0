Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C72B8297
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 18:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgKRRDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 12:03:17 -0500
Received: from twin.jikos.cz ([91.219.245.39]:37771 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgKRRDR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:03:17 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 12:03:14 EST
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 0AIGm1ih027570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Nov 2020 17:48:02 +0100
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 0AIGm0pS027563;
        Wed, 18 Nov 2020 17:48:00 +0100
Date:   Wed, 18 Nov 2020 17:48:00 +0100
From:   David Sterba <dave@jikos.cz>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH] vfs: fix fsconfig(2) LSM mount option handling for btrfs
Message-ID: <20201118164800.GD17322@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Casey Schaufler <casey@schaufler-ca.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
References: <20201118102342.154277-1-omosnace@redhat.com>
 <a2454627-88ec-9e36-445c-baef82568aaa@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2454627-88ec-9e36-445c-baef82568aaa@schaufler-ca.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:39:14AM -0800, Casey Schaufler wrote:
> On 11/18/2020 2:23 AM, Ondrej Mosnacek wrote:
> > When SELinux security options are passed to btrfs via fsconfig(2) rather
> > than via mount(2), the operation aborts with an error. What happens is
> > roughly this sequence:
> >
> > 1. vfs_parse_fs_param() eats away the LSM options and parses them into
> >    fc->security.
> > 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
> >    nothing to btrfs.
> > [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
> >  that for simplicity]
> > 3. btrfs calls security_sb_set_mnt_opts() with empty options.
> > 4. vfs_get_tree() then calls its own security_sb_set_mnt_opts() with the
> >    options stashed in fc->security.
> > 5. SELinux doesn't like that different options were used for the same
> >    superblock and returns -EINVAL.
> >
> > In the case of mount(2), the options are parsed by
> > legacy_parse_monolithic(), which skips the eating away of security
> > opts because of the FS_BINARY_MOUNTDATA flag, so they are passed to the
> > FS via ctx->legacy_data. The second call to security_sb_set_mnt_opts()
> > (from vfs_get_tree()) now passes empty opts, but the non-empty -> empty
> > sequence is allowed by SELinux for the FS_BINARY_MOUNTDATA case.
> >
> > It is a total mess, but the only sane fix for now seems to be to skip
> > processing the security opts in vfs_parse_fs_param() if the fc has
> > legacy opts set AND the fs specfies the FS_BINARY_MOUNTDATA flag. This
> > combination currently matches only btrfs and coda. For btrfs this fixes
> > the fsconfig(2) behavior, and for coda it makes setting security opts
> > via fsconfig(2) fail the same way as it would with mount(2) (because
> > FS_BINARY_MOUNTDATA filesystems are expected to call the mount opts LSM
> > hooks themselves, but coda never cared enough to do that). I believe
> > that is an acceptable state until both filesystems (or at least btrfs)
> > are converted to the new mount API (at which point btrfs won't need to
> > pretend it takes binary mount data any more and also won't need to call
> > the LSM hooks itself, assuming it will pass the fc->security information
> > properly).
> >
> > Note that we can't skip LSM opts handling in vfs_parse_fs_param() solely
> > based on FS_BINARY_MOUNTDATA because that would break NFS.
> >
> > See here for the original report and reproducer:
> > https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/
> >
> > Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> > Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  fs/fs_context.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > index 2834d1afa6e80..cfc5ee2e381ef 100644
> > --- a/fs/fs_context.c
> > +++ b/fs/fs_context.c
> > @@ -106,12 +106,28 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
> >  	if (ret != -ENOPARAM)
> >  		return ret;
> >  
> > -	ret = security_fs_context_parse_param(fc, param);
> > -	if (ret != -ENOPARAM)
> > -		/* Param belongs to the LSM or is disallowed by the LSM; so
> > -		 * don't pass to the FS.
> > -		 */
> > -		return ret;
> > +	/*
> > +	 * In the legacy+binary mode, skip the security_fs_context_parse_param()
> > +	 * call and let the legacy handler process also the security options.
> > +	 * It will format them into the monolithic string, where the FS can
> > +	 * process them (with FS_BINARY_MOUNTDATA it is expected to do it).
> > +	 *
> > +	 * Currently, this matches only btrfs and coda. Coda is broken with
> > +	 * fsconfig(2) anyway, because it does actually take binary data. Btrfs
> > +	 * only *pretends* to take binary data to work around the SELinux's
> > +	 * no-remount-with-different-options check, so this allows it to work
> > +	 * with fsconfig(2) properly.
> > +	 *
> > +	 * Once btrfs is ported to the new mount API, this hack can be reverted.
> 
> If the real fix is to port btrfs to the new mount API why not do that instead?

Porting to the new API is much more work compared to this fix, which can
be also backported to older stable trees if needed. The port will
happen eventually but nobody is working on it right now.
