Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA21E750E55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 18:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjGLQXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjGLQWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651ED2708;
        Wed, 12 Jul 2023 09:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD576183B;
        Wed, 12 Jul 2023 16:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80352C433C7;
        Wed, 12 Jul 2023 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689178914;
        bh=hV01vRDBqDVhCk7HkDnQvXIyuKJkaKNeBRpl+iIAIWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b76h8IjetXfb90gQuJOmNTgw7qn0+gha+VuzsUX77igkDgFznRrwOvv7hJsZggrlm
         LwGx9pHOWV64cbg85IuCQCzdkcTA/UDGzd4/sjK9+WH/ro83syk6fAlBVee5A9gqfS
         JY9tLjCZ7SjQ5qsqmMWphekUfqwNXvjDercwpvC4=
Date:   Wed, 12 Jul 2023 18:21:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
Message-ID: <2023071228-puppet-regalia-484f@gregkh>
References: <20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:56:35AM +0200, Christian Brauner wrote:
> Changing the mode of symlinks is meaningless as the vfs doesn't take the
> mode of a symlink into account during path lookup permission checking.
> 
> However, the vfs doesn't block mode changes on symlinks. This however,
> has lead to an untenable mess roughly classifiable into the following
> two categories:
> 
> (1) Filesystems that don't implement a i_op->setattr() for symlinks.
> 
>     Such filesystems may or may not know that without i_op->setattr()
>     defined, notify_change() falls back to simple_setattr() causing the
>     inode's mode in the inode cache to be changed.
> 
>     That's a generic issue as this will affect all non-size changing
>     inode attributes including ownership changes.
> 
>     Example: afs
> 
> (2) Filesystems that fail with EOPNOTSUPP but change the mode of the
>     symlink nonetheless.
> 
>     Some filesystems will happily update the mode of a symlink but still
>     return EOPNOTSUPP. This is the biggest source of confusion for
>     userspace.
> 
>     The EOPNOTSUPP in this case comes from POSIX ACLs. Specifically it
>     comes from filesystems that call posix_acl_chmod(), e.g., btrfs via
> 
>         if (!err && attr->ia_valid & ATTR_MODE)
>                 err = posix_acl_chmod(idmap, dentry, inode->i_mode);
> 
>     Filesystems including btrfs don't implement i_op->set_acl() so
>     posix_acl_chmod() will report EOPNOTSUPP.
> 
>     When posix_acl_chmod() is called, most filesystems will have
>     finished updating the inode.
> 
>     Perversely, this has the consequences that this behavior may depend
>     on two kconfig options and mount options:
> 
>     * CONFIG_POSIX_ACL={y,n}
>     * CONFIG_${FSTYPE}_POSIX_ACL={y,n}
>     * Opt_acl, Opt_noacl
> 
>     Example: btrfs, ext4, xfs
> 
> The only way to change the mode on a symlink currently involves abusing
> an O_PATH file descriptor in the following manner:
> 
>         fd = openat(-1, "/path/to/link", O_CLOEXEC | O_PATH | O_NOFOLLOW);
> 
>         char path[PATH_MAX];
>         snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
>         chmod(path, 0000);
> 
> But for most major filesystems with POSIX ACL support such as btrfs,
> ext4, ceph, tmpfs, xfs and others this will fail with EOPNOTSUPP with
> the mode still updated due to the aforementioned posix_acl_chmod()
> nonsense.
> 
> So, given that for all major filesystems this would fail with EOPNOTSUPP
> and that both glibc (cf. [1]) and musl (cf. [2]) outright block mode
> changes on symlinks we should just try and block mode changes on
> symlinks directly in the vfs and have a clean break with this nonsense.
> 
> If this causes any regressions, we do the next best thing and fix up all
> filesystems that do return EOPNOTSUPP with the mode updated to not call
> posix_acl_chmod() on symlinks.
> 
> But as usual, let's try the clean cut solution first. It's a simple
> patch that can be easily reverted. Not marking this for backport as I'll
> do that manually if we're reasonably sure that this works and there are
> no strong objections.
> 
> We could block this in chmod_common() but it's more appropriate to do it
> notify_change() as it will also mean that we catch filesystems that
> change symlink permissions explicitly or accidently.
> 
> Similar proposals were floated in the past as in [3] and [4] and again
> recently in [5]. There's also a couple of bugs about this inconsistency
> as in [6] and [7].
> 
> Link: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/fchmodat.c;h=99527a3727e44cb8661ee1f743068f108ec93979;hb=HEAD [1]
> Link: https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c [2]
> Link: https://lore.kernel.org/all/20200911065733.GA31579@infradead.org [3]
> Link: https://sourceware.org/legacy-ml/libc-alpha/2020-02/msg00518.html [4]
> Link: https://lore.kernel.org/lkml/87lefmbppo.fsf@oldenburg.str.redhat.com [5]
> Link: https://sourceware.org/legacy-ml/libc-alpha/2020-02/msg00467.html [6]
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=14578#c17 [7]
> Cc: stable@vger.kernel.org # no backport before v6.6-rc2 is tagged

How far back should this go?

thanks,

greg k-h
