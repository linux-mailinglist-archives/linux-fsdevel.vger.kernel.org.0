Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDA7764EF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjG0JNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjG0JNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:13:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD07D91;
        Thu, 27 Jul 2023 02:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96A561DC6;
        Thu, 27 Jul 2023 09:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55442C433C7;
        Thu, 27 Jul 2023 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690448485;
        bh=RCIxAq+J6KM/JUYFtqw9jn62QLvzZlvWqd22bpCy8BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYq/bF6zhUZ6NptcTbtJ5x0bg7xdgOwVxE0cFCL2YbzKnA8Rg4kDb4rEeAyMQ4jDt
         E/oa8kraypY43zR7ScAYwqrp1WjXb35nVSJM1vnjcmbz6Cw37ITU0JHAupYsx6fYg5
         UiSNz+FUMF3h8YcAJcx4i+JjVrwgh/AX5kF7RXE3uBSutffA6TsXXKOTgzV/V10N/d
         n8eYNkOgSZ+zVHoD6cYuJdaJM2/hvcgUGk2GIt4ce6Sug93wLldCPrf0Zia5eKMEX2
         qLjZl51CCtpmkXHW9/0M32urJ7NF6kEKnCqIlMkf9ggTXGi/V6gLNtibwfiEbTiSGq
         qhxwPylU95Tlg==
Date:   Thu, 27 Jul 2023 11:01:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Xiubo Li <xiubli@redhat.com>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/11] ceph: handle idmapped mounts in
 create_request_message()
Message-ID: <20230727-bedeuten-endkampf-22c87edd132b@brauner>
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
 <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
 <6ea8bf93-b456-bda4-b39d-a43328987ac9@redhat.com>
 <CAEivzxeQubvas2yPFYRRXr3BP7pp1HNM3b7C-PQQWy-0FpFKuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxeQubvas2yPFYRRXr3BP7pp1HNM3b7C-PQQWy-0FpFKuQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:36:40AM +0200, Aleksandr Mikhalitsyn wrote:
> On Thu, Jul 27, 2023 at 7:30 AM Xiubo Li <xiubli@redhat.com> wrote:
> >
> >
> > On 7/26/23 22:10, Alexander Mikhalitsyn wrote:
> > > Inode operations that create a new filesystem object such as ->mknod,
> > > ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
> > > Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> > > filesystem object.
> > >
> > > In order to ensure that the correct {g,u}id is used map the caller's
> > > fs{g,u}id for creation requests. This doesn't require complex changes.
> > > It suffices to pass in the relevant idmapping recorded in the request
> > > message. If this request message was triggered from an inode operation
> > > that creates filesystem objects it will have passed down the relevant
> > > idmaping. If this is a request message that was triggered from an inode
> > > operation that doens't need to take idmappings into account the initial
> > > idmapping is passed down which is an identity mapping.
> > >
> > > This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
> > > which adds two new fields (owner_{u,g}id) to the request head structure.
> > > So, we need to ensure that MDS supports it otherwise we need to fail
> > > any IO that comes through an idmapped mount because we can't process it
> > > in a proper way. MDS server without such an extension will use caller_{u,g}id
> > > fields to set a new inode owner UID/GID which is incorrect because caller_{u,g}id
> > > values are unmapped. At the same time we can't map these fields with an
> > > idmapping as it can break UID/GID-based permission checks logic on the
> > > MDS side. This problem was described with a lot of details at [1], [2].
> > >
> > > [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
> > > [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
> > >
> > > Cc: Xiubo Li <xiubli@redhat.com>
> > > Cc: Jeff Layton <jlayton@kernel.org>
> > > Cc: Ilya Dryomov <idryomov@gmail.com>
> > > Cc: ceph-devel@vger.kernel.org
> > > Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > > ---
> > > v7:
> > >       - reworked to use two new fields for owner UID/GID (https://github.com/ceph/ceph/pull/52575)
> > > ---
> > >   fs/ceph/mds_client.c         | 20 ++++++++++++++++++++
> > >   fs/ceph/mds_client.h         |  5 ++++-
> > >   include/linux/ceph/ceph_fs.h |  4 +++-
> > >   3 files changed, 27 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > index c641ab046e98..ac095a95f3d0 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -2923,6 +2923,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> > >   {
> > >       int mds = session->s_mds;
> > >       struct ceph_mds_client *mdsc = session->s_mdsc;
> > > +     struct ceph_client *cl = mdsc->fsc->client;
> > >       struct ceph_msg *msg;
> > >       struct ceph_mds_request_head_legacy *lhead;
> > >       const char *path1 = NULL;
> > > @@ -3028,6 +3029,16 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> > >       lhead = find_legacy_request_head(msg->front.iov_base,
> > >                                        session->s_con.peer_features);
> > >
> > > +     if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
> > > +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
> > > +             pr_err_ratelimited_client(cl,
> > > +                     "idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
> > > +                     " is not supported by MDS. Fail request with -EIO.\n");
> > > +
> > > +             ret = -EIO;
> > > +             goto out_err;
> > > +     }
> > > +
> >
> > I think this couldn't fail the mounting operation, right ?
> 
> This won't fail mounting. First of all an idmapped mount is always an
> additional mount, you always
> start from doing "normal" mount and only after that you can use this
> mount to create an idmapped one.
> ( example: https://github.com/brauner/mount-idmapped/tree/master )
> 
> >
> > IMO we should fail the mounting from the beginning.
> 
> Unfortunately, we can't fail mount from the beginning. Procedure of
> the idmapped mounts
> creation is handled not on the filesystem level, but on the VFS level

Correct. It's a generic vfsmount feature.

> (source: https://github.com/torvalds/linux/blob/0a8db05b571ad5b8d5c8774a004c0424260a90bd/fs/namespace.c#L4277
> )
> 
> Kernel perform all required checks as:
> - filesystem type has declared to support idmappings
> (fs_type->fs_flags & FS_ALLOW_IDMAP)
> - user who creates idmapped mount should be CAP_SYS_ADMIN in a user
> namespace that owns superblock of the filesystem
> (for cephfs it's always init_user_ns => user should be root on the host)
> 
> So I would like to go this way because of the reasons mentioned above:
> - root user is someone who understands what he does.
> - idmapped mounts are never "first" mounts. They are always created
> after "normal" mount.
> - effectively this check makes "normal" mount to work normally and
> fail only requests that comes through an idmapped mounts
> with reasonable error message. Obviously, all read operations will
> work perfectly well only the operations that create new inodes will
> fail.
> Btw, we already have an analogical semantic on the VFS level for users
> who have no UID/GID mapping to the host. Filesystem requests for
> such users will fail with -EOVERFLOW. Here we have something close.

Refusing requests coming from an idmapped mount if the server misses
appropriate features is good enough as a first step imho. And yes, we do
have similar logic on the vfs level for unmapped uid/gid.
