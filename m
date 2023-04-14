Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905806E23A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDNMv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 08:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDNMv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3506595;
        Fri, 14 Apr 2023 05:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58DC9647BB;
        Fri, 14 Apr 2023 12:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA92C433D2;
        Fri, 14 Apr 2023 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681476714;
        bh=Iyh4xTtXuze4H/6oI56wzVbayIYvvhVkskqCwi4it/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTQFPDlyODkgv6j5FdrTkjl0WDZjzQaDHW/loG53tnG6+O+87L5BH9dd1pnJR9O9y
         uCTAWlOYphlrC1rMY/RKhDy7MHpKSW5uIHmKsEp411XAl2xj4wGGyJLA22ZNnC8uTX
         1jpOitzWMSIglN2aBfG3U0C3wNeaQlxTESTcGZpWyCtXnm4i+rHKeyA6GfEYaoXva6
         sNt+icarhrfDKZaBuDwOoClO7oc4hQPpaf2PPFLa6OBJ3Lh7DpAWIoThxOh/+GWDTx
         doV3fZQ4VYWagup7CFT/sq3dG9eT1mE14CQ86/DyPLfU7ILuv+jH+fDlAdD/5MnFmk
         Epak8t5psdj8Q==
Date:   Fri, 14 Apr 2023 14:51:49 +0200
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
Message-ID: <20230414-felsvorsprung-neuzeit-e19cd155ecb3@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <8EC5C625-ACD6-4BA0-A190-21A73CCBAC34@hammerspace.com>
 <20230414035104.GH3390869@ZenIV>
 <20230414-leihgabe-eisig-71fb7bb44d49@brauner>
 <3492fa76339672ccc48995ccf934744c63db4b80.camel@kernel.org>
 <20230414-gerissen-bemessen-835e95dc7552@brauner>
 <fabbb94e0e35190ce8033107dbbff99188f72e18.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fabbb94e0e35190ce8033107dbbff99188f72e18.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 08:33:09AM -0400, Jeff Layton wrote:
> On Fri, 2023-04-14 at 13:16 +0200, Christian Brauner wrote:
> > On Fri, Apr 14, 2023 at 06:09:46AM -0400, Jeff Layton wrote:
> > > On Fri, 2023-04-14 at 11:41 +0200, Christian Brauner wrote:
> > > > On Fri, Apr 14, 2023 at 04:51:04AM +0100, Al Viro wrote:
> > > > > On Fri, Apr 14, 2023 at 03:28:45AM +0000, Trond Myklebust wrote:
> > > > > 
> > > > > > We already have support for directory file descriptors when mounting with move_mount(). Why not add a umountat() with similar support for the unmount side?
> > > > > > Then add a syscall to allow users with (e.g.) the CAP_DAC_OVERRIDE privilege to convert the mount-id into an O_PATH file descriptor.
> > > > > 
> > > > > You can already do umount -l /proc/self/fd/69 if you have a descriptor.
> > > > 
> > > > Way back when we put together stuff for [2] we had umountat() as an item
> > > > but decided against it because it's mostely useful when used as AT_EMPTY_PATH.
> > > > 
> > > > umount("/proc/self/fd/<nr>", ...) is useful when you don't trust the
> > > > path and you need to resolve it with lookup restrictions. Then path
> > > > resolution restrictions of openat2() can be used to get an fd. Which can
> > > > be passed to umount().
> > > > 
> > > > I need to step outside so this is a halfway-out-the-door thought but
> > > > given your description of the problem Jeff, why doesn't the following
> > > > work (Just sketching this, you can't call openat2() like that.):
> > > > 
> > > >         fd_mnt = openat2("/my/funky/nfs/share/mount", RESOLVE_CACHED)
> > > >         umount("/proc/self/fd/fd_mnt", MNT_DETACH)
> > > 
> > > Something like that might work. A RESOLVE_CACHED flag is something that
> > > would involve more than just umount(2) though. That said, it could be
> > > useful in other situations.
> > 
> > I think I introduced an ambiguity by accident. What I meant by "you
> > can't call openat2() like that" is that it takes a struct open_how
> > argument not just a simple flags argument.
> > 
> > The flag I was talking about, RESOLVE_CACHED, does exist already. So it
> > is already possible to use openat2() to resolve paths like that. See
> > include/uapi/linux/openat2.h
> > 
> 
> Oh, thanks! I haven't tried this yet, but I doubt it'd fix the problem
> David was reproducing. There, the problem is mostly permission checks
> during the pathwalk. It tries to contact the server to check the
> permission, but because it's unexported, EACCES bubbles up.
> 
> Also, to follow up: I tried Al's suggestion of lazily unmounting the bad
> intermediate mount closest to the root, and it does seem to clean up
> child mounts as expected. So, it does look like there is recourse in
> current kernels, even if the method is a bit unintuitive.

See my other mail about this.

Lazy umount is often the way to go. In fact, there'll be mount trees
that you cannot unmount without MNT_DETACH because of mount propagation.

> 
> Still, it might be worth discussing at LSF or here on the list. It'd be
> nice if umount "just worked" in this situation. Is there any reason to
> do a full-blown d_revalidating and permission-checking pathwalk on
> umount, assuming the caller already has CAP_SYS_ADMIN or similar?

I find this to be conceptually the wrong way of doing this. Because even
if you can piggy-back on LOOKUP_CACHED you probably still need special
cases handling for umount. And at that point I think a umount by mnt-id
is just nicer. Because you would also need to expose the new umount()
behavior under a new flag otherwise you risk breaking userspace
assumptions.
