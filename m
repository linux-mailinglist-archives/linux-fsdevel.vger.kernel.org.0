Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEBC765653
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjG0OrT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 10:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbjG0OrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:47:04 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADE3C38
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 07:46:32 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so1869850e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 07:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690469190; x=1691073990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljpBQH2qNQhiX/CKG2FDM7D9f+JnAt6COG592tmGJdU=;
        b=AM7+kgP7+0YLW3uoOpV+7AppsWfQFdLqiB0WLrZ7njG1mGyvezwmhATFNRqEYeWZJn
         AbI9E7rHB56AleKQuJVHz7QFpcv+wUpJ7ZWyr2XCqIR/LFO6jdzmcgwgSm44gDacgC33
         LRvbyVrg8MOaAU6zh3IP9OBvTEbxfD10zQoHgY/Mu2BvNM+gr3/GvnlrXCCg8eG68Xbi
         04Z6QhHTiHAzK2eoZIXkAAhNGvfiRPzsvyn/S//mxfU8LX20QWIbmpSfa8snc7AuHeYp
         mkChrifkQhRHAKOuItr4pHIoWsPH6gqclwigeofuQuo2qqBtzT6ey3C+BuxY53a7RSP6
         FKFw==
X-Gm-Message-State: ABy/qLZtsPZ9VGqjEVmxiC/URwvmNMqQ4Qc2RBZxL1takHa1RfCVgI8Y
        CCD0DktowIGm0LYCY3CCnxPUMxt7yXVPDB6SEOaHuq6a
X-Google-Smtp-Source: APBJJlGzEEpR0He7OHAnNIOC9nqPyJWDiKoGHIrxF5pBG4zd9JnRCXOvjW4/BXMWQNtcMJfeGPyebQ==
X-Received: by 2002:a05:6512:252a:b0:4fb:978e:95b8 with SMTP id be42-20020a056512252a00b004fb978e95b8mr2027145lfb.59.1690469190109;
        Thu, 27 Jul 2023 07:46:30 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id l5-20020aa7d945000000b005223e54d1edsm714212eds.20.2023.07.27.07.46.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 07:46:29 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so1448788a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 07:46:29 -0700 (PDT)
X-Received: by 2002:aa7:d311:0:b0:522:29c9:d30 with SMTP id
 p17-20020aa7d311000000b0052229c90d30mr2015473edq.10.1690469189494; Thu, 27
 Jul 2023 07:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
 <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
 <6ea8bf93-b456-bda4-b39d-a43328987ac9@redhat.com> <CAEivzxeQubvas2yPFYRRXr3BP7pp1HNM3b7C-PQQWy-0FpFKuQ@mail.gmail.com>
 <20230727-bedeuten-endkampf-22c87edd132b@brauner> <CAEivzxcx31k3M1jWhhDrx6jxYtw=VOd84N-cMNWc+BZjq6QuFQ@mail.gmail.com>
In-Reply-To: <CAEivzxcx31k3M1jWhhDrx6jxYtw=VOd84N-cMNWc+BZjq6QuFQ@mail.gmail.com>
From:   =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>
Date:   Thu, 27 Jul 2023 10:46:18 -0400
X-Gmail-Original-Message-ID: <CA+enf=sFC-hiziuXoeDWnb7MoErc+b1PAncOjbM2rNyB4fzfwA@mail.gmail.com>
Message-ID: <CA+enf=sFC-hiziuXoeDWnb7MoErc+b1PAncOjbM2rNyB4fzfwA@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] ceph: handle idmapped mounts in create_request_message()
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Xiubo Li <xiubli@redhat.com>, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 5:48 AM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Thu, Jul 27, 2023 at 11:01 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Jul 27, 2023 at 08:36:40AM +0200, Aleksandr Mikhalitsyn wrote:
> > > On Thu, Jul 27, 2023 at 7:30 AM Xiubo Li <xiubli@redhat.com> wrote:
> > > >
> > > >
> > > > On 7/26/23 22:10, Alexander Mikhalitsyn wrote:
> > > > > Inode operations that create a new filesystem object such as ->mknod,
> > > > > ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
> > > > > Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> > > > > filesystem object.
> > > > >
> > > > > In order to ensure that the correct {g,u}id is used map the caller's
> > > > > fs{g,u}id for creation requests. This doesn't require complex changes.
> > > > > It suffices to pass in the relevant idmapping recorded in the request
> > > > > message. If this request message was triggered from an inode operation
> > > > > that creates filesystem objects it will have passed down the relevant
> > > > > idmaping. If this is a request message that was triggered from an inode
> > > > > operation that doens't need to take idmappings into account the initial
> > > > > idmapping is passed down which is an identity mapping.
> > > > >
> > > > > This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
> > > > > which adds two new fields (owner_{u,g}id) to the request head structure.
> > > > > So, we need to ensure that MDS supports it otherwise we need to fail
> > > > > any IO that comes through an idmapped mount because we can't process it
> > > > > in a proper way. MDS server without such an extension will use caller_{u,g}id
> > > > > fields to set a new inode owner UID/GID which is incorrect because caller_{u,g}id
> > > > > values are unmapped. At the same time we can't map these fields with an
> > > > > idmapping as it can break UID/GID-based permission checks logic on the
> > > > > MDS side. This problem was described with a lot of details at [1], [2].
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
> > > > > [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
> > > > >
> > > > > Cc: Xiubo Li <xiubli@redhat.com>
> > > > > Cc: Jeff Layton <jlayton@kernel.org>
> > > > > Cc: Ilya Dryomov <idryomov@gmail.com>
> > > > > Cc: ceph-devel@vger.kernel.org
> > > > > Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > > > > ---
> > > > > v7:
> > > > >       - reworked to use two new fields for owner UID/GID (https://github.com/ceph/ceph/pull/52575)
> > > > > ---
> > > > >   fs/ceph/mds_client.c         | 20 ++++++++++++++++++++
> > > > >   fs/ceph/mds_client.h         |  5 ++++-
> > > > >   include/linux/ceph/ceph_fs.h |  4 +++-
> > > > >   3 files changed, 27 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > > index c641ab046e98..ac095a95f3d0 100644
> > > > > --- a/fs/ceph/mds_client.c
> > > > > +++ b/fs/ceph/mds_client.c
> > > > > @@ -2923,6 +2923,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> > > > >   {
> > > > >       int mds = session->s_mds;
> > > > >       struct ceph_mds_client *mdsc = session->s_mdsc;
> > > > > +     struct ceph_client *cl = mdsc->fsc->client;
> > > > >       struct ceph_msg *msg;
> > > > >       struct ceph_mds_request_head_legacy *lhead;
> > > > >       const char *path1 = NULL;
> > > > > @@ -3028,6 +3029,16 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> > > > >       lhead = find_legacy_request_head(msg->front.iov_base,
> > > > >                                        session->s_con.peer_features);
> > > > >
> > > > > +     if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
> > > > > +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
> > > > > +             pr_err_ratelimited_client(cl,
> > > > > +                     "idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
> > > > > +                     " is not supported by MDS. Fail request with -EIO.\n");
> > > > > +
> > > > > +             ret = -EIO;
> > > > > +             goto out_err;
> > > > > +     }
> > > > > +
> > > >
> > > > I think this couldn't fail the mounting operation, right ?
> > >
> > > This won't fail mounting. First of all an idmapped mount is always an
> > > additional mount, you always
> > > start from doing "normal" mount and only after that you can use this
> > > mount to create an idmapped one.
> > > ( example: https://github.com/brauner/mount-idmapped/tree/master )
> > >
> > > >
> > > > IMO we should fail the mounting from the beginning.
> > >
> > > Unfortunately, we can't fail mount from the beginning. Procedure of
> > > the idmapped mounts
> > > creation is handled not on the filesystem level, but on the VFS level
> >
> > Correct. It's a generic vfsmount feature.
> >
> > > (source: https://github.com/torvalds/linux/blob/0a8db05b571ad5b8d5c8774a004c0424260a90bd/fs/namespace.c#L4277
> > > )
> > >
> > > Kernel perform all required checks as:
> > > - filesystem type has declared to support idmappings
> > > (fs_type->fs_flags & FS_ALLOW_IDMAP)
> > > - user who creates idmapped mount should be CAP_SYS_ADMIN in a user
> > > namespace that owns superblock of the filesystem
> > > (for cephfs it's always init_user_ns => user should be root on the host)
> > >
> > > So I would like to go this way because of the reasons mentioned above:
> > > - root user is someone who understands what he does.
> > > - idmapped mounts are never "first" mounts. They are always created
> > > after "normal" mount.
> > > - effectively this check makes "normal" mount to work normally and
> > > fail only requests that comes through an idmapped mounts
> > > with reasonable error message. Obviously, all read operations will
> > > work perfectly well only the operations that create new inodes will
> > > fail.
> > > Btw, we already have an analogical semantic on the VFS level for users
> > > who have no UID/GID mapping to the host. Filesystem requests for
> > > such users will fail with -EOVERFLOW. Here we have something close.
> >
> > Refusing requests coming from an idmapped mount if the server misses
> > appropriate features is good enough as a first step imho. And yes, we do
> > have similar logic on the vfs level for unmapped uid/gid.
>
> Thanks, Christian!
>
> I wanted to add that alternative here is to modify caller_{u,g}id
> fields as it was done in the first approach,
> it will break the UID/GID-based permissions model for old MDS versions
> (we can put printk_once to inform user about this),
> but at the same time it will allow us to support idmapped mounts in
> all cases. This support will be not fully ideal for old MDS
>  and perfectly well for new MDS versions.
>
> Alternatively, we can introduce cephfs mount option like
> "idmap_with_old_mds" and if it's enabled then we set caller_{u,g}id
> for MDS without CEPHFS_FEATURE_HAS_OWNER_UIDGID, if it's disabled
> (default) we fail requests with -EIO. For
> new MDS everything goes in the right way.
>
> Kind regards,
> Alex

Hey there,

A very strong +1 on there needing to be some way to make this work
with older Ceph releases.
Ceph Reef isn't out yet and we're in July 2023, so I'd really like not
having to wait until Ceph Squid in mid 2024 to be able to make use of
this!

Some kind of mount option, module option or the like would all be fine for this.

Stéphane
