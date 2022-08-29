Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623FB5A473D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 12:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiH2Kdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiH2Kdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:33:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1564558DD6;
        Mon, 29 Aug 2022 03:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB9F60EBF;
        Mon, 29 Aug 2022 10:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07915C433D6;
        Mon, 29 Aug 2022 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661769232;
        bh=6DAR8T+W2Q7LmltliFe+TTpmuPSmhq+NdCB9DSU6028=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Oz09llMilBr4uXy+02t9fGAUJReZYnQDREi+PNl8NcgmsftNAqg5vckPDuWXXaP7u
         p1E2sWT9FK4BbXoF/V+uN0TRUODbMpH0TRLXXqjm6qcQGi48KXkshLElfgmoPKwwNA
         2avBz28gV3ixxWYoqDI0xawBCQ7HeMbI9PbrvWLoX3TAH52Hap4O/pneEJES4aP3Nn
         UqOqEB0R7vt8CWrEBIecIQSO4i5YfxDv0WgW+p70eax7Sn/5qeWcO1qya95kQUNqB9
         X4qA56ZoYPlW+mzpmk4F74crcbd+OMM4Yxm3jxibhhqDXMay4wjwLy/T8Cc3rlYgyk
         SeWrqmhBoz//g==
Message-ID: <8510ff07fdba7dd4c59a14e2f202ff38b83a9ef1.camel@kernel.org>
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
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
Date:   Mon, 29 Aug 2022 06:33:48 -0400
In-Reply-To: <20220829054848.GR3600936@dread.disaster.area>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-5-jlayton@kernel.org>
         <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
         <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
         <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org>
         <Ywo8cWRcJUpLFMxJ@magnolia>
         <079df2134120f847e8237675a8cc227d6354a153.camel@hammerspace.com>
         <b13812a68310e49cc6fb649c2b1c25287712a8af.camel@kernel.org>
         <CAOQ4uxgThXDEO3mxR_PtPgcPsF7ueqFUxHO3F3KE9sVqi8sLJQ@mail.gmail.com>
         <732164ffb95468992035a6f597dc26e3ce39316d.camel@kernel.org>
         <20220829054848.GR3600936@dread.disaster.area>
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

On Mon, 2022-08-29 at 15:48 +1000, Dave Chinner wrote:
> On Sun, Aug 28, 2022 at 10:37:37AM -0400, Jeff Layton wrote:
> > On Sun, 2022-08-28 at 16:25 +0300, Amir Goldstein wrote:
> > > On Sat, Aug 27, 2022 at 7:10 PM Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > > Yeah, thinking about it some more, simply changing the block alloca=
tion
> > > > is not something that should affect the ctime, so we probably don't=
 want
> > > > to bump i_version on it. It's an implicit change, IOW, not an expli=
cit
> > > > one.
> > > >=20
> > > > The fact that xfs might do that is unfortunate, but it's not the en=
d of
> > > > the world and it still would conform to the proposed definition for
> > > > i_version. In practice, this sort of allocation change should come =
soon
> > > > after the file was written, so one would hope that any damage due t=
o the
> > > > false i_version bump would be minimized.
> > > >=20
> > >=20
> > > That was exactly my point.
> > >=20
> > > > It would be nice to teach it not to do that however. Maybe we can i=
nsert
> > > > the NOIVER flag at a strategic place to avoid it?
>=20
> No, absolutely not.
>=20
> I've already explained this: The XFS *disk format specification*
> says that di_changecount is bumped for every change that is made to
> the inode.
>=20
> Applications that are written from this specification expect the on
> disk format for a XFS given filesystem feature to remain the same
> until it is either deprecated and removed or we add feature flags to
> indicate it has different behaviour.  We can't just change the
> behaviour at a whim.
>=20
> And that's ignoring the fact that randomly spewing NOIVER
> into transactions that modify inode metadata is a nasty hack - it
> is not desirable from a design or documentation POV, nor is it
> maintainable.
>=20
> > > Why would that be nice to avoid?
> > > You did not specify any use case where incrementing i_version
> > > on block mapping change matters in practice.
> > > On the contrary, you said that NFS client writer sends COMMIT on clos=
e,
> > > which should stabilize i_version for the next readers.
> > >=20
> > > Given that we already have an xfs implementation that does increment
> > > i_version on block mapping changes and it would be a pain to change
> > > that or add a new user options, I don't see the point in discussing i=
t further
> > > unless there is a good incentive for avoiding i_version updates in th=
ose cases.
> > >=20
> >=20
> > Because the change to the block allocation doesn't represent an
> > "explicit" change to the inode. We will have bumped the ctime on the
> > original write (in update_time), but the follow-on changes that occur
> > due to that write needn't be counted as they aren't visible to the
> > client.
> >=20
> > It's possible for a client to issue a read between the write and the
> > flush and get the interim value for i_version. Then, once the write
> > happens and the i_version gets bumped again, the client invalidates its
> > cache even though it needn't do so.
> >=20
> > The race window ought to be relatively small, and this wouldn't result
> > in incorrect behavior that you'd notice (other than loss of
> > performance), but it's not ideal. We're doing more on-the-wire reads
> > than are necessary in this case.
> >=20
> > It would be nice to have it not do that. If we end up taking this patch
> > to make it elide the i_version bumps on atime updates, we may be able t=
o
> > set the the NOIVER flag in other cases as well, and avoid some of these
> > extra bumps.
>=20
>=20
> <sigh>
>=20
> Please don't make me repeat myself for the third time.
>=20
> Once we have decided on a solid, unchanging definition for the
> *statx user API variable*, we'll implement a new on-disk field that
> provides this information.  We will document it in the on-disk
> specification as "this is how di_iversion behaves" so that it is
> clear to everyone parsing the on-disk format or writing their own
> XFS driver how to implement it and when to expect it to
> change.
>=20
> Then we can add a filesystem and inode feature flags that say "inode
> has new iversion" and we use that to populate the kernel iversion
> instead of di_changecount. We keep di_changecount exactly the way it
> is now for the applications and use cases we already have for that
> specific behaviour. If the kernel and/or filesystem don't support
> the new di_iversion field, then we'll use di_changecount as it
> currently exists for the kernel iversion code.
>=20

Aside from NFS and IMA, what applications are dependent on the current
definition and how do they rely on i_version today?

> Keep in mind that we've been doing dynamic inode format updates in
> XFS for a couple of decades - users don't even have to be aware that
> they need to perform format upgrades because often they just happen
> whenever an inode is accessed. IOWs, just because we have to change
> the on-disk format to support this new iversion definition, it
> doesn't mean users have to reformat filesystems before the new
> feature can be used.
>=20
> Hence, over time, as distros update kernels, the XFS iversion
> behaviour will change automagically as we update inodes in existing
> filesystems as they are accessed to add and then use the new
> di_iversion field for the VFS change attribute field instead of the
> di_changecount field...
>=20

If you want to create a whole new on-disk field for this, then that's
your prerogative, but before you do that, I'd like to better understand
why and how the constraints on this field changed.

The original log message from the commit that added a change counter
(below) stated that you were adding it for network filesystems like NFS.
When did this change and why?

    commit dc037ad7d24f3711e431a45c053b5d425995e9e4
    Author: Dave Chinner <dchinner@redhat.com>
    Date:   Thu Jun 27 16:04:59 2013 +1000

        xfs: implement inode change count

        For CRC enabled filesystems, add support for the monotonic inode
        version change counter that is needed by protocols like NFSv4 for
        determining if the inode has changed in any way at all between two
        unrelated operations on the inode.

        This bumps the change count the first time an inode is dirtied in a
        transaction. Since all modifications to the inode are logged, this
        will catch all changes that are made to the inode, including
        timestamp updates that occur during data writes.

        Signed-off-by: Dave Chinner <dchinner@redhat.com>
        Reviewed-by: Mark Tinguely <tinguely@sgi.com>
        Reviewed-by: Chandra Seetharaman <sekharan@us.ibm.com>
        Signed-off-by: Ben Myers <bpm@sgi.com>

--=20
Jeff Layton <jlayton@kernel.org>
