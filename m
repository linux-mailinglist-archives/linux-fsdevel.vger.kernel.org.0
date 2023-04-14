Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8826E21E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 13:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjDNLRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 07:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjDNLRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FBC9019;
        Fri, 14 Apr 2023 04:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5211D646D8;
        Fri, 14 Apr 2023 11:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72259C433EF;
        Fri, 14 Apr 2023 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681471011;
        bh=J5/c5HwC8g/Oc7bpdijzK2LOpYemXEpG0yZE4puCamw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7kVPMZp9pulhGpovfkZJNN/7YgeIUGWz+35i1O1tlsftQgMzBYBoM3SJh0Ph9fPc
         NebblWOtn19uejh8fU3b52om8Oc541uG94SQVDnAzxOJM1vyxVeiYg+Bx221zTOY2v
         fdZELOFqZemL1+cmbHsIxiJFko03PcNuiIs4PjDp++oeyEI+gSJK2b/nXxa5aEdEX9
         l1gM/MEi6egpwNfjof5kh61KAWL0AtqzL2o1cN2rxeOOkla9zxJwJX8m+E7uOI6Iox
         MzOUYHe+IoRNVUMADQ6WCkdPfqvYpj4aN3Kkvt9BwaZBOqhT8Oc4WFXzGVAubacQ8J
         xEY71mekQTu1A==
Date:   Fri, 14 Apr 2023 13:16:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Message-ID: <20230414-gerissen-bemessen-835e95dc7552@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <8EC5C625-ACD6-4BA0-A190-21A73CCBAC34@hammerspace.com>
 <20230414035104.GH3390869@ZenIV>
 <20230414-leihgabe-eisig-71fb7bb44d49@brauner>
 <3492fa76339672ccc48995ccf934744c63db4b80.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3492fa76339672ccc48995ccf934744c63db4b80.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 06:09:46AM -0400, Jeff Layton wrote:
> On Fri, 2023-04-14 at 11:41 +0200, Christian Brauner wrote:
> > On Fri, Apr 14, 2023 at 04:51:04AM +0100, Al Viro wrote:
> > > On Fri, Apr 14, 2023 at 03:28:45AM +0000, Trond Myklebust wrote:
> > > 
> > > > We already have support for directory file descriptors when mounting with move_mount(). Why not add a umountat() with similar support for the unmount side?
> > > > Then add a syscall to allow users with (e.g.) the CAP_DAC_OVERRIDE privilege to convert the mount-id into an O_PATH file descriptor.
> > > 
> > > You can already do umount -l /proc/self/fd/69 if you have a descriptor.
> > 
> > Way back when we put together stuff for [2] we had umountat() as an item
> > but decided against it because it's mostely useful when used as AT_EMPTY_PATH.
> > 
> > umount("/proc/self/fd/<nr>", ...) is useful when you don't trust the
> > path and you need to resolve it with lookup restrictions. Then path
> > resolution restrictions of openat2() can be used to get an fd. Which can
> > be passed to umount().
> > 
> > I need to step outside so this is a halfway-out-the-door thought but
> > given your description of the problem Jeff, why doesn't the following
> > work (Just sketching this, you can't call openat2() like that.):
> > 
> >         fd_mnt = openat2("/my/funky/nfs/share/mount", RESOLVE_CACHED)
> >         umount("/proc/self/fd/fd_mnt", MNT_DETACH)
> 
> Something like that might work. A RESOLVE_CACHED flag is something that
> would involve more than just umount(2) though. That said, it could be
> useful in other situations.

I think I introduced an ambiguity by accident. What I meant by "you
can't call openat2() like that" is that it takes a struct open_how
argument not just a simple flags argument.

The flag I was talking about, RESOLVE_CACHED, does exist already. So it
is already possible to use openat2() to resolve paths like that. See
include/uapi/linux/openat2.h

> 
> > 
> > > Converting mount-id to O_PATH... might be an interesting idea.
> > 
> > I think using mount-ids would be nice and fwiw, something we considered
> > as an alternative to umountat(). Not just can they be gotten from
> > /proc/<pid>/mountinfo but we also do expose the mount id to userspace
> > nowadays through:
> > 
> >         STATX_MNT_ID
> >         __u64	stx_mnt_id;
> > 
> > which also came out of [2]. And it should be safe to do via
> > AT_STATX_DONT_SYNC:
> > 
> >         statx(my_cached_fd, AT_NO_AUTOMOUNT|AT_SYMLINK_NOFOLLOW|AT_STATX_DONT_SYNC)
> > 
> > using STATX_ATTR_MOUNT_ROOT to identify a potential mountpoint. Then
> > pass that mount-id to the new system call.
> > 
> > [2]: https://github.com/uapi-group/kernel-features
> 
> This is generating a lot of good ideas! Maybe we should plan to discuss
> this further at LSF/MM?

Sure, happy to.
