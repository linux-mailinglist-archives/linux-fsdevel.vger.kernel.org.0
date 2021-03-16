Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3C33DCFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbhCPS7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 14:59:36 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40758 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbhCPS7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:59:31 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMEud-006adU-VV; Tue, 16 Mar 2021 18:59:28 +0000
Date:   Tue, 16 Mar 2021 18:59:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v2] vfs: fix fsconfig(2) LSM mount option handling for
 btrfs
Message-ID: <YFEAD9UClhwxErgj@zeniv-ca.linux.org.uk>
References: <20210316144823.2188946-1-omosnace@redhat.com>
 <CAHC9VhRoTjimpKrrQ5f04SE7AOcGv6p5iBgSnoSRgtiUP47rRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRoTjimpKrrQ5f04SE7AOcGv6p5iBgSnoSRgtiUP47rRg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:21:45PM -0400, Paul Moore wrote:
> On Tue, Mar 16, 2021 at 10:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
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

Let's not.  This is where the root of the problem actually lies.  Take a look
at that sucker:

        struct fs_context *fc;
        struct vfsmount *mnt;
        int ret = 0;

        if (!type)
                return ERR_PTR(-EINVAL);

        fc = fs_context_for_mount(type, flags);
        if (IS_ERR(fc))
                return ERR_CAST(fc);

        if (name)
                ret = vfs_parse_fs_string(fc, "source",
                                          name, strlen(name));
        if (!ret)
                ret = parse_monolithic_mount_data(fc, data);  
        if (!ret)
                mnt = fc_mount(fc);
        else   
                mnt = ERR_PTR(ret);

        put_fs_context(fc);
        return mnt;

That's where the problem comes - you've lost the original context's ->security.
Note that there's such thing as security_fs_context_dup(), so you can bloody
well either
	* provide a variant of vfs_kern_mount() that would take 'base' fc to
pick security options from or
	* do all options parsing on btrfs fc and then do fs_context_for_mount +
security_fs_context_dup + copy (parsed) options to whatever private data you
use for btrfs_root context + fc_mount + put_fs_context yourself. 

My preference would be the latter, but I have *not* looked at btrfs mount options
handling in any details.

> VFS folks, can we get a verdict/feedback on this patch?  The v1 draft
> of this patch was posted almost four months ago with no serious
> comments/feedback.  It's a bit ugly, but it does appear to work and at
> the very least SELinux needs this to handle btrfs properly, other LSMs
> may need this too.

It's more than a bit ugly; it perpetuates the use of FS_BINARY_MOUNTDATA,
and the semantics it gets is quite counterintuitive at that.
