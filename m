Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5912F6E9832
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjDTPUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 11:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjDTPUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8CA1FF0;
        Thu, 20 Apr 2023 08:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB52764A48;
        Thu, 20 Apr 2023 15:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87468C433D2;
        Thu, 20 Apr 2023 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682004012;
        bh=T6HLU7+mO3saRsM+1LT/GdRuU7MztyqvGe8hOSpGXYE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PlrUHLz3NMsc8RVDXVAUXquuhws9Rhj7Fz+rom5+NCpvmF3T2qpNHCUDdY98g7dFI
         MxGDVBY7w/LThpu/uFGWKX9zrIsbnRueEiursFUmN8m8YLH6SrML4ab0GfbVYu42u9
         y8ykvhhvK9mKIVFz27WWheKmyJKcbT7G1PH2niN/pGcQeeFGP6DOvk4c7tkqTzSLY7
         EckxQQjMQeZVKLoiT0mNBqHmuRdo+IKEjd/kTpXR/sdwFWRZe/WFEbMXyemPQiFZYg
         e0HrWrrHpb5DeVjEX52ZYQ0OEERcV4p1sjhuBcqXTT3AdvhiIm26bPuU2xsJOKIjzK
         zFX4sb0Hcll4g==
Message-ID: <d3bfe08079a859b361e436570cdfb31d45ca56a4.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 20 Apr 2023 11:20:10 -0400
In-Reply-To: <20230416233758.GD447837@dread.disaster.area>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
         <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
         <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
         <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
         <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
         <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
         <20230416233758.GD447837@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-04-17 at 09:37 +1000, Dave Chinner wrote:
> On Sun, Apr 16, 2023 at 07:51:41AM -0400, Jeff Layton wrote:
> > On Sun, 2023-04-16 at 08:21 +0900, Tetsuo Handa wrote:
> > > On 2023/04/16 3:40, Jeff Layton wrote:
> > > > On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
> > > > > On 2023/04/16 1:13, Chuck Lever III wrote:
> > > > > > > On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-l=
ove.SAKURA.ne.jp> wrote:
> > > > > > >=20
> > > > > > > Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNE=
L | GFP_NOFS
> > > > > > > does not make sense. Drop __GFP_FS flag in order to avoid dea=
dlock.
> > > > > >=20
> > > > > > The server side threads run in process context. GFP_KERNEL
> > > > > > is safe to use here -- as Jeff said, this code is not in
> > > > > > the server's reclaim path. Plenty of other call sites in
> > > > > > the NFS server code use GFP_KERNEL.
> > > > >=20
> > > > > GFP_KERNEL memory allocation calls filesystem's shrinker function=
s
> > > > > because of __GFP_FS flag. My understanding is
> > > > >=20
> > > > >   Whether this code is in memory reclaim path or not is irrelevan=
t.
> > > > >   Whether memory reclaim path might hold lock or not is relevant.
> > > > >=20
> > > > > . Therefore, question is, does nfsd hold i_rwsem during memory re=
claim path?
> > > > >=20
> > > >=20
> > > > No. At the time of these allocations, the i_rwsem is not held.
> > >=20
> > > Excuse me? nfsd_getxattr()/nfsd_listxattr() _are_ holding i_rwsem
> > > via inode_lock_shared(inode) before kvmalloc(GFP_KERNEL | GFP_NOFS) a=
llocation.
> > > That's why
> > >=20
> > > 	/*
> > > 	 * We're holding i_rwsem - use GFP_NOFS.
> > > 	 */
> > >=20
> > > is explicitly there in nfsd_listxattr() side.
>=20
> You can do GFP_KERNEL allocations holding the i_rwsem just fine.
> All that it requires is the caller holds a reference to the inode,
> and at that point inode will should skip the given inode without
> every locking it.
>=20
> Of course, lockdep can't handle the "referenced inode lock ->
> fsreclaim -> unreferenced inode lock" pattern at all. It throws out
> false positives when it detects this because it's not aware of the
> fact that reference counts prevent inode lock recursion based
> deadlocks in the vfs inode cache shrinker.
>=20
> If a custom, non-vfs shrinker is walking inodes that have no
> references and taking i_rwsem in a way that can block without first
> checking whether it is safe to lock the inode in a deadlock free
> manner, they are doing the wrong thing and the custom shrinker needs
> to be fixed.
>=20
> > >=20
> > > If memory reclaim path (directly or indirectly via locking dependency=
) involves
> > > inode_lock_shared(inode)/inode_lock(inode), it is not safe to use __G=
FP_FS flag.
> > >=20
> >=20
> > (cc'ing Frank V. who wrote this code and -fsdevel)
> >=20
> > I stand corrected! You're absolutely right that it's taking the i_rwsem
> > for read there. That seems pretty weird, actually. I don't believe we
> > need to hold the inode_lock to call vfs_getxattr or vfs_listxattr, and
> > certainly nothing else under there requires it.
> >=20
> > Frank, was there some reason you decided you needed the inode_lock
> > there? It looks like under the hood, the xattr code requires you to tak=
e
> > it for write in setxattr and removexattr, but you don't need it at all
> > in getxattr or listxattr. Go figure.
>=20
> IIRC, the filesytsem can't take the i_rwsem for get/listxattr
> because the lookup contexts may already hold the i_rwsem. I think
> this is largely a problem caused by LSMs (e.g. IMA) needing to
> access security xattrs in paths where the inode is already
> locked.

> > Longer term, I wonder what the inode_lock is protecting in setxattr and
> > removexattr operations, given that get and list don't require them?
> > These are always delegated to the filesystem driver -- there is no
> > generic xattr implementation.
>=20
> Serialising updates against each other. xattr modifications are
> supposed to be "atomic" from the perspective of the user - they see
> the entire old or the new xattr, never a partial value.
>=20
> FWIW, XFS uses it's internal metadata rwsem for access/update
> serialisation of xattrs because we can't rely on the i_rwsem for
> reliable serialisation. I'm guessing that most journalling
> filesystems do something similar.

(Almost?) All of the existing xattr implementations already have their
own internal locking for consistency. Given that they can't rely on
taking the i_rwsem during getxattr or listxattr, it's hard to see how
any of them could rely on that to ensure consistency there.

We probably ought to see if we can push the inode_lock down into the
various setxattr/removexattr handlers and then we could just have them
drop that lock on a case-by-case basis after validating that it wasn't
needed.
--=20
Jeff Layton <jlayton@kernel.org>
