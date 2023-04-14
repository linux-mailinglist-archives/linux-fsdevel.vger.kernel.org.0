Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5C6E204C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDNKJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDNKJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:09:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61641FF7;
        Fri, 14 Apr 2023 03:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44ED06223F;
        Fri, 14 Apr 2023 10:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A50C433D2;
        Fri, 14 Apr 2023 10:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681466988;
        bh=nr947F56m6325zW1COKJH1Btv7pX83NFx31ZY+F3jos=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AoI0sBfkcJo7DfGfxxMHZWdJFGiAzxoV8tRDhx+Hjw9vu/yDqabcnHhykbQfeg9ir
         5OlyLR6QiKDIX9Kme+DWEPcmINxGT8H8Ztknd6ph0Op9pt8Yg4W0lzUI1FBQ5bWmoI
         oQNZhi5a8FTVl1SP1S4tVHnSxQT/D9Fxw7TOHGa3Jpsb+lSDLar/PU+hbO4c2dw0ZU
         cIuDnzudL5ah2BFOpelHShA1YvKEkruE0PiRmojAw/InDAqgi3+gvqdsa8ZRpBhXzC
         Jc7WLPYdqWuqdYtTBvLQV1i3TtZqvg24eqstUOsFaE50s5kJQsiZoiODXoLhquqGbx
         alklAFuxvTypw==
Message-ID: <3492fa76339672ccc48995ccf934744c63db4b80.camel@kernel.org>
Subject: Re: allowing for a completely cached umount(2) pathwalk
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Fri, 14 Apr 2023 06:09:46 -0400
In-Reply-To: <20230414-leihgabe-eisig-71fb7bb44d49@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
         <168142566371.24821.15867603327393356000@noble.neil.brown.name>
         <20230414024312.GF3390869@ZenIV>
         <8EC5C625-ACD6-4BA0-A190-21A73CCBAC34@hammerspace.com>
         <20230414035104.GH3390869@ZenIV>
         <20230414-leihgabe-eisig-71fb7bb44d49@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-04-14 at 11:41 +0200, Christian Brauner wrote:
> On Fri, Apr 14, 2023 at 04:51:04AM +0100, Al Viro wrote:
> > On Fri, Apr 14, 2023 at 03:28:45AM +0000, Trond Myklebust wrote:
> >=20
> > > We already have support for directory file descriptors when mounting =
with move_mount(). Why not add a umountat() with similar support for the un=
mount side?
> > > Then add a syscall to allow users with (e.g.) the CAP_DAC_OVERRIDE pr=
ivilege to convert the mount-id into an O_PATH file descriptor.
> >=20
> > You can already do umount -l /proc/self/fd/69 if you have a descriptor.
>=20
> Way back when we put together stuff for [2] we had umountat() as an item
> but decided against it because it's mostely useful when used as AT_EMPTY_=
PATH.
>=20
> umount("/proc/self/fd/<nr>", ...) is useful when you don't trust the
> path and you need to resolve it with lookup restrictions. Then path
> resolution restrictions of openat2() can be used to get an fd. Which can
> be passed to umount().
>=20
> I need to step outside so this is a halfway-out-the-door thought but
> given your description of the problem Jeff, why doesn't the following
> work (Just sketching this, you can't call openat2() like that.):
>=20
>         fd_mnt =3D openat2("/my/funky/nfs/share/mount", RESOLVE_CACHED)
>         umount("/proc/self/fd/fd_mnt", MNT_DETACH)

Something like that might work. A RESOLVE_CACHED flag is something that
would involve more than just umount(2) though. That said, it could be
useful in other situations.

>=20
> > Converting mount-id to O_PATH... might be an interesting idea.
>=20
> I think using mount-ids would be nice and fwiw, something we considered
> as an alternative to umountat(). Not just can they be gotten from
> /proc/<pid>/mountinfo but we also do expose the mount id to userspace
> nowadays through:
>=20
>         STATX_MNT_ID
>         __u64	stx_mnt_id;
>=20
> which also came out of [2]. And it should be safe to do via
> AT_STATX_DONT_SYNC:
>=20
>         statx(my_cached_fd, AT_NO_AUTOMOUNT|AT_SYMLINK_NOFOLLOW|AT_STATX_=
DONT_SYNC)
>=20
> using STATX_ATTR_MOUNT_ROOT to identify a potential mountpoint. Then
> pass that mount-id to the new system call.
>=20
> [2]: https://github.com/uapi-group/kernel-features

This is generating a lot of good ideas! Maybe we should plan to discuss
this further at LSF/MM?

--=20
Jeff Layton <jlayton@kernel.org>
