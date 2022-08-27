Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39785A38AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiH0QKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiH0QKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:10:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB2A140A2;
        Sat, 27 Aug 2022 09:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BAF7B80108;
        Sat, 27 Aug 2022 16:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEE4C433C1;
        Sat, 27 Aug 2022 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661616610;
        bh=Xt9w6d/BMpg4HCQF+DVXYkjlOISDU6YmCgUqhgfpx4w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hzBBMC8uxIpbrC7pdEarm3Og5fFgFWzXqJIXnbbGoKSgL/L5an+e8/y2PPR4i7ljM
         8+7gz9cXH8lRSXeaPthHGNT1MqTl147ilLo+xHD2vyADDsatR+fkPscYpyWaHG73RX
         nLO/MTmAV1xf7KkhXJ5CPtxK9jPJcpDjNhDGWIsXeK6zya49102BV553hFq48xYPbC
         BxSXonEp0ybjY37Fh1efSUlF/+Tin93JdFqZwo7w3d4jYWpP4xw7zJwLd23/udj3sJ
         /G9iFlH2d/ErCrX5bJinu8CAiSy54yQLxyUWhIU8gEhsoZqEfOYdzwJXo3Rs5h/dvH
         Io4EXCiEY305w==
Message-ID: <b13812a68310e49cc6fb649c2b1c25287712a8af.camel@kernel.org>
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "djwong@kernel.org" <djwong@kernel.org>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Date:   Sat, 27 Aug 2022 12:10:06 -0400
In-Reply-To: <079df2134120f847e8237675a8cc227d6354a153.camel@hammerspace.com>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-5-jlayton@kernel.org>
         <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
         <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
         <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org>
         <Ywo8cWRcJUpLFMxJ@magnolia>
         <079df2134120f847e8237675a8cc227d6354a153.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Sat, 2022-08-27 at 16:03 +0000, Trond Myklebust wrote:
> On Sat, 2022-08-27 at 08:46 -0700, Darrick J. Wong wrote:
> > On Sat, Aug 27, 2022 at 09:14:30AM -0400, Jeff Layton wrote:
> > > On Sat, 2022-08-27 at 11:01 +0300, Amir Goldstein wrote:
> > > > On Sat, Aug 27, 2022 at 10:26 AM Amir Goldstein
> > > > <amir73il@gmail.com> wrote:
> > > > >=20
> > > > > On Sat, Aug 27, 2022 at 12:49 AM Jeff Layton
> > > > > <jlayton@kernel.org> wrote:
> > > > > >=20
> > > > > > xfs will update the i_version when updating only the atime
> > > > > > value, which
> > > > > > is not desirable for any of the current consumers of
> > > > > > i_version. Doing so
> > > > > > leads to unnecessary cache invalidations on NFS and extra
> > > > > > measurement
> > > > > > activity in IMA.
> > > > > >=20
> > > > > > Add a new XFS_ILOG_NOIVER flag, and use that to indicate that
> > > > > > the
> > > > > > transaction should not update the i_version. Set that value
> > > > > > in
> > > > > > xfs_vn_update_time if we're only updating the atime.
> > > > > >=20
> > > > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > > > Cc: NeilBrown <neilb@suse.de>
> > > > > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > > > > Cc: David Wysochanski <dwysocha@redhat.com>
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > > =A0fs/xfs/libxfs/xfs_log_format.h=A0 |=A0 2 +-
> > > > > > =A0fs/xfs/libxfs/xfs_trans_inode.c |=A0 2 +-
> > > > > > =A0fs/xfs/xfs_iops.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
| 11 +++++++++--
> > > > > > =A03 files changed, 11 insertions(+), 4 deletions(-)
> > > > > >=20
> > > > > > Dave has NACK'ed this patch, but I'm sending it as a way to
> > > > > > illustrate
> > > > > > the problem. I still think this approach should at least fix
> > > > > > the worst
> > > > > > problems with atime updates being counted. We can look to
> > > > > > carve out
> > > > > > other "spurious" i_version updates as we identify them.
> > > > > >=20
> > > > >=20
> > > > > AFAIK, "spurious" is only inode blocks map changes due to
> > > > > writeback
> > > > > of dirty pages. Anybody know about other cases?
> > > > >=20
> > > > > Regarding inode blocks map changes, first of all, I don't think
> > > > > that there is
> > > > > any practical loss from invalidating NFS client cache on dirty
> > > > > data writeback,
> > > > > because NFS server should be serving cold data most of the
> > > > > time.
> > > > > If there are a few unneeded cache invalidations they would only
> > > > > be temporary.
> > > > >=20
> > > >=20
> > > > Unless there is an issue with a writer NFS client that
> > > > invalidates its
> > > > own attribute
> > > > caches on server data writeback?
> > > >=20
> > >=20
> > > The client just looks at the file attributes (of which i_version is
> > > but
> > > one), and if certain attributes have changed (mtime, ctime,
> > > i_version,
> > > etc...) then it invalidates its cache.
> > >=20
> > > In the case of blocks map changes, could that mean a difference in
> > > the
> > > observable sparse regions of the file? If so, then a READ_PLUS
> > > before
> > > the change and a READ_PLUS after could give different results.
> > > Since
> > > that difference is observable by the client, I'd think we'd want to
> > > bump
> > > i_version for that anyway.
> >=20
> > How /is/ READ_PLUS supposed to detect sparse regions, anyway?=A0 I know
> > that's been the subject of recent debate.=A0 At least as far as XFS is
> > concerned, a file range can go from hole -> delayed allocation
> > reservation -> unwritten extent -> (actual writeback) -> written
> > extent.
> > The dance became rather more complex when we added COW.=A0 If any of
> > that
> > will make a difference for READ_PLUS, then yes, I think you'd want
> > file
> > writeback activities to bump iversion to cause client invalidations,
> > like (I think) Dave said.
> >=20
> > The fs/iomap/ implementation of SEEK_DATA/SEEK_HOLE reports data for
> > written and delalloc extents; and an unwritten extent will report
> > data
> > for any pagecache it finds.
> >=20
>=20
> READ_PLUS should never return anything different than a read() system
> call would return for any given area. The way it reports sparse regions
> vs. data regions is purely an RPC formatting convenience.
>=20
> The only point to note about NFS READ and READ_PLUS is that because the
> client is forced to send multiple RPC calls if the user is trying to
> read a region that is larger than the 'rsize' value, it is possible
> that these READ/READ_PLUS calls may be processed out of order, and so
> the result may end up looking different than if you had executed a
> read() call for the full region directly on the server.
> However each individual READ / READ_PLUS reply should look as if the
> user had called read() on that rsize-sized section of the file.
> > >=20

Yeah, thinking about it some more, simply changing the block allocation
is not something that should affect the ctime, so we probably don't want
to bump i_version on it. It's an implicit change, IOW, not an explicit
one.

The fact that xfs might do that is unfortunate, but it's not the end of
the world and it still would conform to the proposed definition for
i_version. In practice, this sort of allocation change should come soon
after the file was written, so one would hope that any damage due to the
false i_version bump would be minimized.

It would be nice to teach it not to do that however. Maybe we can insert
the NOIVER flag at a strategic place to avoid it?
--=20
Jeff Layton <jlayton@kernel.org>
