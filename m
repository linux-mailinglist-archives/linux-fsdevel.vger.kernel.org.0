Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DCE5A3E20
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 16:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiH1Ohq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiH1Ohp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:37:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F5923142;
        Sun, 28 Aug 2022 07:37:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A72E2B80B18;
        Sun, 28 Aug 2022 14:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD3EC433D7;
        Sun, 28 Aug 2022 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661697461;
        bh=M1V3+Cg+gDKIrqRPd6nEgr9Tn2VZgdz17LsFqQjYQ+0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ca7nILzc7JuJ458qXwTnDn1oX24HrvatDH9ZIosa8sF9uLZo0xm5WJr6shQ6KiG/3
         yz3ALUDZMAj+Kzk7Gy4FwYTTN/uzV7wCXwz9eItXwO+WXhGIv/bYO7GqrnlY/9asNV
         nodmesjk6EUsRTs52rNkRJvXbtULfHq438ZZL6ft86jzW9wRwhx1mfHSPDsRhhEQwy
         jbMtQOSHGRTGMiCayNZsPxFo44UEV8R0qnqx0gPrOvVdXmiIelRF6a0ZL79zheyfcT
         tqYY+fgqiry/nfZRq8NbzuUrzuJTft2DNRH5EsM5u9dt79igBn1k2N6C2TV3qV/IXj
         tVtzXXd1JCdKw==
Message-ID: <732164ffb95468992035a6f597dc26e3ce39316d.camel@kernel.org>
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
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
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Date:   Sun, 28 Aug 2022 10:37:37 -0400
In-Reply-To: <CAOQ4uxgThXDEO3mxR_PtPgcPsF7ueqFUxHO3F3KE9sVqi8sLJQ@mail.gmail.com>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-5-jlayton@kernel.org>
         <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
         <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
         <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org>
         <Ywo8cWRcJUpLFMxJ@magnolia>
         <079df2134120f847e8237675a8cc227d6354a153.camel@hammerspace.com>
         <b13812a68310e49cc6fb649c2b1c25287712a8af.camel@kernel.org>
         <CAOQ4uxgThXDEO3mxR_PtPgcPsF7ueqFUxHO3F3KE9sVqi8sLJQ@mail.gmail.com>
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

On Sun, 2022-08-28 at 16:25 +0300, Amir Goldstein wrote:
> On Sat, Aug 27, 2022 at 7:10 PM Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Sat, 2022-08-27 at 16:03 +0000, Trond Myklebust wrote:
> > > On Sat, 2022-08-27 at 08:46 -0700, Darrick J. Wong wrote:
> > > > On Sat, Aug 27, 2022 at 09:14:30AM -0400, Jeff Layton wrote:
> > > > > On Sat, 2022-08-27 at 11:01 +0300, Amir Goldstein wrote:
> > > > > > On Sat, Aug 27, 2022 at 10:26 AM Amir Goldstein
> > > > > > <amir73il@gmail.com> wrote:
> > > > > > >=20
> > > > > > > On Sat, Aug 27, 2022 at 12:49 AM Jeff Layton
> > > > > > > <jlayton@kernel.org> wrote:
> > > > > > > >=20
> > > > > > > > xfs will update the i_version when updating only the atime
> > > > > > > > value, which
> > > > > > > > is not desirable for any of the current consumers of
> > > > > > > > i_version. Doing so
> > > > > > > > leads to unnecessary cache invalidations on NFS and extra
> > > > > > > > measurement
> > > > > > > > activity in IMA.
> > > > > > > >=20
> > > > > > > > Add a new XFS_ILOG_NOIVER flag, and use that to indicate th=
at
> > > > > > > > the
> > > > > > > > transaction should not update the i_version. Set that value
> > > > > > > > in
> > > > > > > > xfs_vn_update_time if we're only updating the atime.
> > > > > > > >=20
> > > > > > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > > > > > Cc: NeilBrown <neilb@suse.de>
> > > > > > > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > > > > > > Cc: David Wysochanski <dwysocha@redhat.com>
> > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > ---
> > > > > > > >  fs/xfs/libxfs/xfs_log_format.h  |  2 +-
> > > > > > > >  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
> > > > > > > >  fs/xfs/xfs_iops.c               | 11 +++++++++--
> > > > > > > >  3 files changed, 11 insertions(+), 4 deletions(-)
> > > > > > > >=20
> > > > > > > > Dave has NACK'ed this patch, but I'm sending it as a way to
> > > > > > > > illustrate
> > > > > > > > the problem. I still think this approach should at least fi=
x
> > > > > > > > the worst
> > > > > > > > problems with atime updates being counted. We can look to
> > > > > > > > carve out
> > > > > > > > other "spurious" i_version updates as we identify them.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > AFAIK, "spurious" is only inode blocks map changes due to
> > > > > > > writeback
> > > > > > > of dirty pages. Anybody know about other cases?
> > > > > > >=20
> > > > > > > Regarding inode blocks map changes, first of all, I don't thi=
nk
> > > > > > > that there is
> > > > > > > any practical loss from invalidating NFS client cache on dirt=
y
> > > > > > > data writeback,
> > > > > > > because NFS server should be serving cold data most of the
> > > > > > > time.
> > > > > > > If there are a few unneeded cache invalidations they would on=
ly
> > > > > > > be temporary.
> > > > > > >=20
> > > > > >=20
> > > > > > Unless there is an issue with a writer NFS client that
> > > > > > invalidates its
> > > > > > own attribute
> > > > > > caches on server data writeback?
> > > > > >=20
> > > > >=20
> > > > > The client just looks at the file attributes (of which i_version =
is
> > > > > but
> > > > > one), and if certain attributes have changed (mtime, ctime,
> > > > > i_version,
> > > > > etc...) then it invalidates its cache.
> > > > >=20
> > > > > In the case of blocks map changes, could that mean a difference i=
n
> > > > > the
> > > > > observable sparse regions of the file? If so, then a READ_PLUS
> > > > > before
> > > > > the change and a READ_PLUS after could give different results.
> > > > > Since
> > > > > that difference is observable by the client, I'd think we'd want =
to
> > > > > bump
> > > > > i_version for that anyway.
> > > >=20
> > > > How /is/ READ_PLUS supposed to detect sparse regions, anyway?  I kn=
ow
> > > > that's been the subject of recent debate.  At least as far as XFS i=
s
> > > > concerned, a file range can go from hole -> delayed allocation
> > > > reservation -> unwritten extent -> (actual writeback) -> written
> > > > extent.
> > > > The dance became rather more complex when we added COW.  If any of
> > > > that
> > > > will make a difference for READ_PLUS, then yes, I think you'd want
> > > > file
> > > > writeback activities to bump iversion to cause client invalidations=
,
> > > > like (I think) Dave said.
> > > >=20
> > > > The fs/iomap/ implementation of SEEK_DATA/SEEK_HOLE reports data fo=
r
> > > > written and delalloc extents; and an unwritten extent will report
> > > > data
> > > > for any pagecache it finds.
> > > >=20
> > >=20
> > > READ_PLUS should never return anything different than a read() system
> > > call would return for any given area. The way it reports sparse regio=
ns
> > > vs. data regions is purely an RPC formatting convenience.
> > >=20
> > > The only point to note about NFS READ and READ_PLUS is that because t=
he
> > > client is forced to send multiple RPC calls if the user is trying to
> > > read a region that is larger than the 'rsize' value, it is possible
> > > that these READ/READ_PLUS calls may be processed out of order, and so
> > > the result may end up looking different than if you had executed a
> > > read() call for the full region directly on the server.
> > > However each individual READ / READ_PLUS reply should look as if the
> > > user had called read() on that rsize-sized section of the file.
> > > > >=20
> >=20
> > Yeah, thinking about it some more, simply changing the block allocation
> > is not something that should affect the ctime, so we probably don't wan=
t
> > to bump i_version on it. It's an implicit change, IOW, not an explicit
> > one.
> >=20
> > The fact that xfs might do that is unfortunate, but it's not the end of
> > the world and it still would conform to the proposed definition for
> > i_version. In practice, this sort of allocation change should come soon
> > after the file was written, so one would hope that any damage due to th=
e
> > false i_version bump would be minimized.
> >=20
>=20
> That was exactly my point.
>=20
> > It would be nice to teach it not to do that however. Maybe we can inser=
t
> > the NOIVER flag at a strategic place to avoid it?
>=20
> Why would that be nice to avoid?
> You did not specify any use case where incrementing i_version
> on block mapping change matters in practice.
> On the contrary, you said that NFS client writer sends COMMIT on close,
> which should stabilize i_version for the next readers.
>=20
> Given that we already have an xfs implementation that does increment
> i_version on block mapping changes and it would be a pain to change
> that or add a new user options, I don't see the point in discussing it fu=
rther
> unless there is a good incentive for avoiding i_version updates in those =
cases.
>=20

Because the change to the block allocation doesn't represent an
"explicit" change to the inode. We will have bumped the ctime on the
original write (in update_time), but the follow-on changes that occur
due to that write needn't be counted as they aren't visible to the
client.

It's possible for a client to issue a read between the write and the
flush and get the interim value for i_version. Then, once the write
happens and the i_version gets bumped again, the client invalidates its
cache even though it needn't do so.

The race window ought to be relatively small, and this wouldn't result
in incorrect behavior that you'd notice (other than loss of
performance), but it's not ideal. We're doing more on-the-wire reads
than are necessary in this case.

It would be nice to have it not do that. If we end up taking this patch
to make it elide the i_version bumps on atime updates, we may be able to
set the the NOIVER flag in other cases as well, and avoid some of these
extra bumps.
--=20
Jeff Layton <jlayton@kernel.org>
