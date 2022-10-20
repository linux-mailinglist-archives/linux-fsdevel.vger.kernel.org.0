Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B4605BE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 12:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiJTKN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJTKN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7281D100A;
        Thu, 20 Oct 2022 03:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B109161A6A;
        Thu, 20 Oct 2022 10:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70800C433D6;
        Thu, 20 Oct 2022 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666260836;
        bh=2u36TOSuCcs9T6khBWH+thYjLJLzTyP78vKXOIt9YRg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RwvO/WRZjSQDm+QiaU9OHWal+FA2UHvw+1/Rlwn7ddpifVk7kpeI08Sit9dWaxeKR
         yKq2kAGOYf5bFgZV0/+KtgC+1+Ws4Cm69D0HjwBUbKLuSvDQ1cnE3iv6Hpv+1DTqsm
         ii5+UtukeoIV08SgLe4xqDNaIGkbiihQvBlqYBpzC8v1r68blSrIEjp5ENnzF6RJS0
         DfHFGfSB+1F4+TN70vTR1g4t7J3l7QiyqqoZpGpTK7sx5gQw+DKwB2VWqa4L4FaWkN
         rrOGfcmhgh9yUrp65wd0hRwQgAb9GTcA+KKBRn98OMYYIxgG0XFYYC+z2sflsSn5OA
         8wXjVDwZA7q7Q==
Message-ID: <8ef79208adc82b546cc4c2ba20b5c6ddbc3a2732.camel@kernel.org>
Subject: Re: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        Max Kellermann <max.kellermann@ionos.com>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Oct 2022 06:13:53 -0400
In-Reply-To: <7e28f7d1-cfd5-642a-dd4e-ab521885187c@redhat.com>
References: <20220927120857.639461-1-max.kellermann@ionos.com>
         <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com>
         <CAKPOu+88FT1SeFDhvnD_NC7aEJBxd=-T99w67mA-s4SXQXjQNw@mail.gmail.com>
         <75e7f676-8c85-af0a-97b2-43664f60c811@redhat.com>
         <CAKPOu+-rKOVsZ1T=1X-T-Y5Fe1MW2Fs9ixQh8rgq3S9shi8Thw@mail.gmail.com>
         <baf42d14-9bc8-93e1-3d75-7248f93afbd2@redhat.com>
         <cd5ed50a3c760f746a43f8d68fdbc69b01b89b39.camel@kernel.org>
         <7e28f7d1-cfd5-642a-dd4e-ab521885187c@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-10-20 at 09:29 +0800, Xiubo Li wrote:
> On 11/10/2022 18:45, Jeff Layton wrote:
> > On Mon, 2022-10-10 at 10:02 +0800, Xiubo Li wrote:
> > > On 09/10/2022 18:27, Max Kellermann wrote:
> > > > On Sun, Oct 9, 2022 at 10:43 AM Xiubo Li <xiubli@redhat.com> wrote:
> > > > > I mean CEPHFS CLIENT CAPABILITIES [1].
> > > > I know that, but that's suitable for me. This is client-specific, n=
ot
> > > > user (uid/gid) specific.
> > > >=20
> > > > In my use case, a server can run unprivileged user processes which
> > > > should not be able create snapshots for their own home directory, a=
nd
> > > > ideally they should not even be able to traverse into the ".snap"
> > > > directory and access the snapshots created of their home directory.
> > > > Other (non-superuser) system processes however should be able to
> > > > manage snapshots. It should be possible to bind-mount snapshots int=
o
> > > > the user's mount namespace.
> > > >=20
> > > > All of that is possible with my patch, but impossible with your
> > > > suggestion. The client-specific approach is all-or-nothing (unless =
I
> > > > miss something vital).
> > > >=20
> > > > > The snapdir name is a different case.
> > > > But this is only about the snapdir. The snapdir does not exist on t=
he
> > > > server, it is synthesized on the client (in the Linux kernel cephfs
> > > > code).
> > > This could be applied to it's parent dir instead as one metadata in m=
ds
> > > side and in client side it will be transfer to snapdir's metadata, ju=
st
> > > like what the snapshots.
> > >=20
> > > But just ignore this approach.
> > >=20
> > > > > But your current approach will introduce issues when an UID/GID i=
s reused after an user/groud is deleted ?
> > > > The UID I would specify is one which exists on the client, for a
> > > > dedicated system user whose purpose is to manage cephfs snapshots o=
f
> > > > all users. The UID is created when the machine is installed, and is
> > > > never deleted.
> > > This is an ideal use case IMO.
> > >=20
> > > I googled about reusing the UID/GID issues and found someone has hit =
a
> > > similar issue in their use case.
> > >=20
> > This is always a danger and not just with ceph. The solution to that is
> > good sysadmin practices (i.e. don't reuse uid/gid values without
> > sanitizing the filesystems first).
>=20
> Yeah, this sounds reasonable.
>=20
> > > > > Maybe the proper approach is the posix acl. Then by default the .=
snap dir will inherit the permission from its parent and you can change it =
as you wish. This permission could be spread to all the other clients too ?
> > > > No, that would be impractical and unreliable.
> > > > Impractical because it would require me to walk the whole filesyste=
m
> > > > tree and let the kernel synthesize the snapdir inode for all
> > > > directories and change its ACL;
> > > No, it don't have to. This could work simply as the snaprealm hierarc=
hy
> > > thing in kceph.
> > >=20
> > > Only the up top directory need to record the ACL and all the descenda=
nts
> > > will point and use it if they don't have their own ACLs.
> > >=20
> > > >    impractical because walking millions
> > > > of directories takes longer than I am willing to wait.
> > > > Unreliable because there would be race problems when another client
> > > > (or even the local client) creates a new directory. Until my local
> > > > "snapdir ACL daemon" learns about the existence of the new director=
y
> > > > and is able to update its ACL, the user can already have messed wit=
h
> > > > it.
> > > For multiple clients case I think the cephfs capabilities [3] could
> > > guarantee the consistency of this. While for the single client case i=
f
> > > before the user could update its ACL just after creating it someone e=
lse
> > > has changed it or messed it up, then won't the existing ACLs have the
> > > same issue ?
> > >=20
> > > [3] https://docs.ceph.com/en/quincy/cephfs/capabilities/
> > >=20
> > >=20
> > > > Both of that is not a problem with my patch.
> > > >=20
> > > Jeff,
> > >=20
> > > Any idea ?
> > >=20
> > I tend to agree with Max here. The .snap dir is a client-side fiction,
> > so trying to do something on the MDS to govern its use seems a bit odd.
> > cephx is really about authenticating clients. I know we do things like
> > enforce root squashing on the MDS, but this is a little different.
> >=20
> > Now, all of that said, snapshot handling is an area where I'm just not
> > that knowledgeable. Feel free to ignore my opinion here as uninformed.
>=20
> I am thinking currently the cephfs have the same issue we discussed=20
> here. Because the cephfs is saving the UID/GID number in the CInode=20
> metedata. While when there have multiple clients are sharing the same=20
> cephfs, so in different client nodes another user could cross access a=
=20
> specified user's files. For example:
>=20
> In client nodeA:
>=20
> user1's UID is 123, user2's UID is 321.
>=20
> In client nodeB:
>=20
> user1's UID is 321, user2's UID is 123.
>=20
> And if user1 create a fileA in the client nodeA, then user2 could access=
=20
> it from client nodeB.
>=20
> Doesn't this also sound more like a client-side fiction ?
>=20

idmapping is a difficult issue and not at all confined to CephFS. NFSv4
has a whole upcall facility for mapping IDs, for instance. The MDS has
no way to know that 123 and 321 are the same user on different machines.
That sort of mapping must be set up by the administrator.

The real question is: Does it make sense for the MDS to use directory
permissions to enforce access on something that isn't really a
directory?=A0

My "gut feeling" here is that the MDS ought to be in charge of governing
which _clients_ are allowed to make snapshots, but it's up to the client
to determine which _users_ are allowed to create them. With that concept
in mind, Max's proposal makes some sense.

Snapshots are not part of POSIX, and the ".snap" directory interface was
copied from Netapp (AFAICT). Maybe CephFS ought to enforce permissions
on snapshots the same way Netapps do? I don't know exactly how it works
there, so some research may be required.

I found this article but it's behind a paywall:

    https://kb.netapp.com/Advice_and_Troubleshooting/Data_Storage_Software/=
ONTAP_OS_7_Mode/How_to_control_access_to_a_Snapshot_directory

--=20
Jeff Layton <jlayton@kernel.org>
