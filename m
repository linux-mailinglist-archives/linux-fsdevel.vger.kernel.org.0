Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2CF5FB0AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJKKpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 06:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJKKpb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74FC558FA;
        Tue, 11 Oct 2022 03:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C440061172;
        Tue, 11 Oct 2022 10:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEB4C433C1;
        Tue, 11 Oct 2022 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665485128;
        bh=0ORIrMiaafE9HpXjJhzaRxJC8Sfc1yVXNywVExlpX0w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tqR2roEfrqpljaxqHYAPae3TOyO7jn3CmcaOCuD1dE4P9rDsPSU8XnD7lNL5H32yG
         5dQ68Xc32iWRotbd/pDSgZAvWy0hZidn4Klfzh9DdeLJ7hD7S599ykxu9wW+m4H5n6
         phfNXZFwodv7evkaeMr1gTgC0r+svVGZB/6l7dxkXZOtyyznj18By/IS5rCr44lKBF
         W9hCgmdVbnH5HjbQ0epujd2jkGLXWECqHOeaXwkul/nGdlc1oUyokFXmaRjByd9CPA
         x9sRWVr1xHzy88Lb1iqbqasFPuki/qGrfcDQIJ3mHUW3cym0efMthxoR7KszLzT1Eg
         zsMSh68AFevOw==
Message-ID: <cd5ed50a3c760f746a43f8d68fdbc69b01b89b39.camel@kernel.org>
Subject: Re: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        Max Kellermann <max.kellermann@ionos.com>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Oct 2022 06:45:26 -0400
In-Reply-To: <baf42d14-9bc8-93e1-3d75-7248f93afbd2@redhat.com>
References: <20220927120857.639461-1-max.kellermann@ionos.com>
         <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com>
         <CAKPOu+88FT1SeFDhvnD_NC7aEJBxd=-T99w67mA-s4SXQXjQNw@mail.gmail.com>
         <75e7f676-8c85-af0a-97b2-43664f60c811@redhat.com>
         <CAKPOu+-rKOVsZ1T=1X-T-Y5Fe1MW2Fs9ixQh8rgq3S9shi8Thw@mail.gmail.com>
         <baf42d14-9bc8-93e1-3d75-7248f93afbd2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-10-10 at 10:02 +0800, Xiubo Li wrote:
> On 09/10/2022 18:27, Max Kellermann wrote:
> > On Sun, Oct 9, 2022 at 10:43 AM Xiubo Li <xiubli@redhat.com> wrote:
> > > I mean CEPHFS CLIENT CAPABILITIES [1].
> > I know that, but that's suitable for me. This is client-specific, not
> > user (uid/gid) specific.
> >=20
> > In my use case, a server can run unprivileged user processes which
> > should not be able create snapshots for their own home directory, and
> > ideally they should not even be able to traverse into the ".snap"
> > directory and access the snapshots created of their home directory.
> > Other (non-superuser) system processes however should be able to
> > manage snapshots. It should be possible to bind-mount snapshots into
> > the user's mount namespace.
> >=20
> > All of that is possible with my patch, but impossible with your
> > suggestion. The client-specific approach is all-or-nothing (unless I
> > miss something vital).
> >=20
> > > The snapdir name is a different case.
> > But this is only about the snapdir. The snapdir does not exist on the
> > server, it is synthesized on the client (in the Linux kernel cephfs
> > code).
>=20
> This could be applied to it's parent dir instead as one metadata in mds=
=20
> side and in client side it will be transfer to snapdir's metadata, just=
=20
> like what the snapshots.
>=20
> But just ignore this approach.
>=20
> > > But your current approach will introduce issues when an UID/GID is re=
used after an user/groud is deleted ?
> > The UID I would specify is one which exists on the client, for a
> > dedicated system user whose purpose is to manage cephfs snapshots of
> > all users. The UID is created when the machine is installed, and is
> > never deleted.
>=20
> This is an ideal use case IMO.
>=20
> I googled about reusing the UID/GID issues and found someone has hit a=
=20
> similar issue in their use case.
>=20

This is always a danger and not just with ceph. The solution to that is
good sysadmin practices (i.e. don't reuse uid/gid values without
sanitizing the filesystems first).

> > > Maybe the proper approach is the posix acl. Then by default the .snap=
 dir will inherit the permission from its parent and you can change it as y=
ou wish. This permission could be spread to all the other clients too ?
> > No, that would be impractical and unreliable.
> > Impractical because it would require me to walk the whole filesystem
> > tree and let the kernel synthesize the snapdir inode for all
> > directories and change its ACL;
>=20
> No, it don't have to. This could work simply as the snaprealm hierarchy=
=20
> thing in kceph.
>=20
> Only the up top directory need to record the ACL and all the descendants=
=20
> will point and use it if they don't have their own ACLs.
>=20
> >   impractical because walking millions
> > of directories takes longer than I am willing to wait.
> > Unreliable because there would be race problems when another client
> > (or even the local client) creates a new directory. Until my local
> > "snapdir ACL daemon" learns about the existence of the new directory
> > and is able to update its ACL, the user can already have messed with
> > it.
>=20
> For multiple clients case I think the cephfs capabilities [3] could=20
> guarantee the consistency of this. While for the single client case if=
=20
> before the user could update its ACL just after creating it someone else=
=20
> has changed it or messed it up, then won't the existing ACLs have the=20
> same issue ?
>=20
> [3] https://docs.ceph.com/en/quincy/cephfs/capabilities/
>=20
>=20
> > Both of that is not a problem with my patch.
> >=20
> Jeff,
>=20
> Any idea ?
>=20

I tend to agree with Max here. The .snap dir is a client-side fiction,
so trying to do something on the MDS to govern its use seems a bit odd.
cephx is really about authenticating clients. I know we do things like
enforce root squashing on the MDS, but this is a little different.

Now, all of that said, snapshot handling is an area where I'm just not
that knowledgeable. Feel free to ignore my opinion here as uninformed.
--=20
Jeff Layton <jlayton@kernel.org>
