Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09287779F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjHJN5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJN5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5236C212B;
        Thu, 10 Aug 2023 06:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E464C64A1F;
        Thu, 10 Aug 2023 13:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88C1C433C7;
        Thu, 10 Aug 2023 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691675858;
        bh=8TLHDCTColfLSCdxEVFmLaRfu1yS1/99cHLfJeUUwA4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WBhsUVuR/RFO+wlrVpHGFEl49UYiU3eSfSTZmXJVEdoAdppwGGfY1w94k5Awt0ScR
         Mqsx+eEA35BFxGTQ6rkQd/rL3nPeGShFLDkTNa42ScNw5j4b/fjbB05P7hiyqzbNYJ
         nN7kCP3gcuWcsLOE62Yuk4R+iQPdGPvIi6q/A10mLqSk7zYclfVcVqEi2fIsVKmcFj
         Xic7aeTVbHof/AB+wNsYOau7ha5h5XA3NAN0mFV1OnC2glqxt4UQWeFDy/jX8q/X4y
         fJHzeKfg1Khy1hd/P0L7mEFqlG9B9C7f4sn9WirH0GBvu4zmim+X7zZnn1Tmdz+YfY
         EjgoHPnX7wiBw==
Message-ID: <7d596fc2c526a5d6e4a84240dede590e868f3345.camel@kernel.org>
Subject: Re: [PATCH v9] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Date:   Thu, 10 Aug 2023 09:57:35 -0400
In-Reply-To: <20230808-erdaushub-sanieren-2bd8d7e0a286@brauner>
References: <20230808-master-v9-1-e0ecde888221@kernel.org>
         <20230808-erdaushub-sanieren-2bd8d7e0a286@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-08-08 at 15:31 +0200, Christian Brauner wrote:
> On Tue, Aug 08, 2023 at 07:34:20AM -0400, Jeff Layton wrote:
> > From: David Howells <dhowells@redhat.com>
> >=20
> > When NFS superblocks are created by automounting, their LSM parameters
> > aren't set in the fs_context struct prior to sget_fc() being called,
> > leading to failure to match existing superblocks.
> >=20
> > This bug leads to messages like the following appearing in dmesg when
> > fscache is enabled:
> >=20
> >     NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,10=
0000,100000,2ee,3a98,1d4c,3a98,1)
> >=20
> > Fix this by adding a new LSM hook to load fc->security for submount
> > creation.
> >=20
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount(=
) to it.")
> > Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> > Tested-by: Jeff Layton <jlayton@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>

I've made a significant number of changes since Casey acked this. It
might be a good idea to drop his Acked-by (unless he wants to chime in
and ask us to keep it).

Thanks,
Jeff

> > Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > Link: https://lore.kernel.org/r/165962680944.3334508.661002390034914203=
4.stgit@warthog.procyon.org.uk/ # v1
> > Link: https://lore.kernel.org/r/165962729225.3357250.143507288464715271=
37.stgit@warthog.procyon.org.uk/ # v2
> > Link: https://lore.kernel.org/r/165970659095.2812394.686889417110231879=
6.stgit@warthog.procyon.org.uk/ # v3
> > Link: https://lore.kernel.org/r/166133579016.3678898.628319501948056727=
5.stgit@warthog.procyon.org.uk/ # v4
> > Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.u=
k/ # v5
> > ---
> > ver #2)
> > - Added Smack support
> > - Made LSM parameter extraction dependent on reference !=3D NULL.
> >=20
> > ver #3)
> > - Made LSM parameter extraction dependent on fc->purpose =3D=3D
> >    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
> >=20
> > ver #4)
> > - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux =
or Smack.
> >=20
> > ver #5)
> > - Removed unused variable.
> > - Only allocate smack_mnt_opts if we're dealing with a submount.
> >=20
> > ver #6)
> > - Rebase onto v6.5.0-rc4
> > - Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d4829916=
8b@kernel.org
> >=20
> > ver #7)
> > - Drop lsm_set boolean
> > - Link to v7: https://lore.kernel.org/r/20230804-master-v7-1-5d4e484072=
98@kernel.org
> >=20
> > ver #8)
> > - Remove spurious semicolon in smack_fs_context_init
> > - Make fs_context_init take a superblock as reference instead of dentry
> > - WARN_ON_ONCE's when fc->purpose !=3D FS_CONTEXT_FOR_SUBMOUNT
> > - Call the security hook from fs_context_for_submount instead of alloc_=
fs_context
> > - Link to v8: https://lore.kernel.org/r/20230807-master-v8-1-54e249595f=
10@kernel.org
> >=20
> > ver #9)
> > - rename *_fs_context_init to *_fs_context_submount
> > - remove checks for FS_CONTEXT_FOR_SUBMOUNT and NULL reference pointers
> > - fix prototype on smack_fs_context_submount
>=20
> Thanks, this looks good from my perspective. If it looks fine to LSM
> folks as well I can put it with the rest of the super work for this
> cycle or it can go through the LSM tree.

--=20
Jeff Layton <jlayton@kernel.org>
