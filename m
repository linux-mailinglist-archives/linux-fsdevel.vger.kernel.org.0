Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA66E37CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 13:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjDPLvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDPLvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688E1FC7;
        Sun, 16 Apr 2023 04:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEB7E60CA3;
        Sun, 16 Apr 2023 11:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BCAC433EF;
        Sun, 16 Apr 2023 11:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681645904;
        bh=mNnJMm7iNNu8gLDmVbiscd/RfBID9+WEncb2zmYzGjg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i9BiZCczvdmzyJkPfIDcpveGRoQRdSamjC6e+aWe8N52ntLjgBmV6mUkeRZaEL0tQ
         4VtSSh8Jydovl2VTlCX4xOYGmBzNoYP7KJVHxTMdlOaUHF6qDX3rRdlBjtTm0UaHbf
         LEbJfkjDsib609aHb9X3lJD997gUwaP9q0xNHUzS14O1cpAttawvLPowPhVFVQ4K6d
         K5sOGyl5XKpxJRJcrKcf3I27NBQ6y/tY3ONEfZscNsQQd7ShUoNnqY5TDsc6xMCN1Q
         FWoyQjWLhjrfPLymbQuUhrcAMxKm8bTomSo1QO+UFjKcNO5y2hcDHG4xaFI2N9Bokg
         3nFxVBIdq2hOQ==
Message-ID: <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
From:   Jeff Layton <jlayton@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Frank van der Linden <fllinden@amazon.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Sun, 16 Apr 2023 07:51:41 -0400
In-Reply-To: <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
         <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
         <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
         <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
         <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Sun, 2023-04-16 at 08:21 +0900, Tetsuo Handa wrote:
> On 2023/04/16 3:40, Jeff Layton wrote:
> > On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
> > > On 2023/04/16 1:13, Chuck Lever III wrote:
> > > > > On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.=
SAKURA.ne.jp> wrote:
> > > > >=20
> > > > > Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | =
GFP_NOFS
> > > > > does not make sense. Drop __GFP_FS flag in order to avoid deadloc=
k.
> > > >=20
> > > > The server side threads run in process context. GFP_KERNEL
> > > > is safe to use here -- as Jeff said, this code is not in
> > > > the server's reclaim path. Plenty of other call sites in
> > > > the NFS server code use GFP_KERNEL.
> > >=20
> > > GFP_KERNEL memory allocation calls filesystem's shrinker functions
> > > because of __GFP_FS flag. My understanding is
> > >=20
> > >   Whether this code is in memory reclaim path or not is irrelevant.
> > >   Whether memory reclaim path might hold lock or not is relevant.
> > >=20
> > > . Therefore, question is, does nfsd hold i_rwsem during memory reclai=
m path?
> > >=20
> >=20
> > No. At the time of these allocations, the i_rwsem is not held.
>=20
> Excuse me? nfsd_getxattr()/nfsd_listxattr() _are_ holding i_rwsem
> via inode_lock_shared(inode) before kvmalloc(GFP_KERNEL | GFP_NOFS) alloc=
ation.
> That's why
>=20
> 	/*
> 	 * We're holding i_rwsem - use GFP_NOFS.
> 	 */
>=20
> is explicitly there in nfsd_listxattr() side.
>=20
> If memory reclaim path (directly or indirectly via locking dependency) in=
volves
> inode_lock_shared(inode)/inode_lock(inode), it is not safe to use __GFP_F=
S flag.
>=20

(cc'ing Frank V. who wrote this code and -fsdevel)

I stand corrected! You're absolutely right that it's taking the i_rwsem
for read there. That seems pretty weird, actually. I don't believe we
need to hold the inode_lock to call vfs_getxattr or vfs_listxattr, and
certainly nothing else under there requires it.

Frank, was there some reason you decided you needed the inode_lock
there? It looks like under the hood, the xattr code requires you to take
it for write in setxattr and removexattr, but you don't need it at all
in getxattr or listxattr. Go figure.

If there's no reason to keep it there, then in addition to removing
GFP_NOFS there I think we probably ought to just remove the inode_lock
from nfsd_getxattr and nfsd_listxattr altogether.

Longer term, I wonder what the inode_lock is protecting in setxattr and
removexattr operations, given that get and list don't require them?
These are always delegated to the filesystem driver -- there is no
generic xattr implementation.

Maybe we ought to do a lock pushdown on those operations at some point?
I'd bet that most of the setxattr/removexattr operations do their own
locking and don't require the i_rwsem at all.
--=20
Jeff Layton <jlayton@kernel.org>
