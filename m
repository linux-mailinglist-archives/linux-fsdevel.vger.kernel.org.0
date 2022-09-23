Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835015E7824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 12:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiIWKTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 06:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiIWKTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D19A16583;
        Fri, 23 Sep 2022 03:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6A8611BC;
        Fri, 23 Sep 2022 10:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D6FC433D6;
        Fri, 23 Sep 2022 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663928375;
        bh=WKF/etRdydviG3/y3Y0AoNpRXxEQIEqA8KePNsIopAA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BiMNTTyzHQABsA/KKyvWH1h/rRoAV9oJlKE6TnzaPQcD4vipU3oxuvmgC13e/1JtT
         wyTdwlj45t4Lf8JDs+7ruqqxdu2o438/B93OcmbjrfdGjYHcjdBw4gIfaELR8+9vAl
         6Pj3tKo7d2egYOTO9g0hpD5+EsottpWXnK9qhpUMYytSt9ad32nK98+UKYqz5p6vko
         EA9ThF7++KdcCT52Dquq5JsrJlfVZ6NV9I7PwbFbAZK+YUM2GmSuXZvMrRkcj37uoV
         vcMMmY7KBIsJIGRFTSvgr5TUfovNF+9SOd+RbUdi+IXBoypTX66a2T0s8cXJxiGx4c
         WUqSTI+DNyCEQ==
Message-ID: <a30414b7b720217082a8245d10e50e9c342ec8ad.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
        NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Fri, 23 Sep 2022 06:19:31 -0400
In-Reply-To: <20220923095653.5c63i2jgv52j3zqp@quack3>
References: <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
         <20220918235344.GH3600936@dread.disaster.area>
         <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
         <20220920001645.GN3600936@dread.disaster.area>
         <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>
         <20220921000032.GR3600936@dread.disaster.area>
         <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>
         <20220921214124.GS3600936@dread.disaster.area>
         <e04e349170bc227b330556556d0592a53692b5b5.camel@kernel.org>
         <1ef261e3ff1fa7fcd0d75ed755931aacb8062de2.camel@kernel.org>
         <20220923095653.5c63i2jgv52j3zqp@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-09-23 at 11:56 +0200, Jan Kara wrote:
> On Thu 22-09-22 16:18:02, Jeff Layton wrote:
> > On Thu, 2022-09-22 at 06:18 -0400, Jeff Layton wrote:
> > > On Thu, 2022-09-22 at 07:41 +1000, Dave Chinner wrote:
> > > > e.g. The NFS server can track the i_version values when the NFSD
> > > > syncs/commits a given inode. The nfsd can sample i_version it when
> > > > calls ->commit_metadata or flushed data on the inode, and then when
> > > > it peeks at i_version when gathering post-op attrs (or any other
> > > > getattr op) it can decide that there is too much in-memory change
> > > > (e.g. 10,000 counts since last sync) and sync the inode.
> > > >=20
> > > > i.e. the NFS server can trivially cap the maximum number of
> > > > uncommitted NFS change attr bumps it allows to build up in memory.
> > > > At that point, the NFS server has a bound "maximum write count" tha=
t
> > > > can be used in conjunction with the xattr based crash counter to
> > > > determine how the change_attr is bumped by the crash counter.
> > >=20
> > > Well, not "trivially". This is the bit where we have to grow struct
> > > inode (or the fs-specific inode), as we'll need to know what the late=
st
> > > on-disk value is for the inode.
> > >=20
> > > I'm leaning toward doing this on the query side. Basically, when nfsd
> > > goes to query the i_version, it'll check the delta between the curren=
t
> > > version and the latest one on disk. If it's bigger than X then we'd j=
ust
> > > return NFS4ERR_DELAY to the client.
> > >=20
> > > If the delta is >X/2, maybe it can kick off a workqueue job or someth=
ing
> > > that calls write_inode with WB_SYNC_ALL to try to get the thing onto =
the
> > > platter ASAP.
> >=20
> > Still looking at this bit too. Probably we can just kick off a
> > WB_SYNC_NONE filemap_fdatawrite at that point and hope for the best?
>=20
> "Hope" is not a great assurance regarding data integrity ;)=A0

By "hoping for the best", I meant hoping that we never have to take the
the drastic action of returning NFS4ERR_DELAY on GETATTR operations. We
definitely don't want to jeopardize data integrity.=20

> Anyway, it
> depends on how you imagine the "i_version on disk" is going to be
> maintained. It could be maintained by NFSD inside commit_inode_metadata()=
 -
> fetch current i_version value before asking filesystem for the sync and b=
y the
> time commit_metadata() returns we know that value is on disk. If we detec=
t the
> current - on_disk is > X/2, we call commit_inode_metadata() and we are
> done. It is not even *that* expensive because usually filesystems optimiz=
e
> away unnecessary IO when the inode didn't change since last time it got
> synced.
>=20

At >X/2 we don't really want to start blocking or anything. I'd prefer
if we could kick off something in the background for this, but if it's
not too expensive then maybe just calling commit_inode_metadata
synchronously in this codepath is OK. Alternately, we could consider
doing that in a workqueue job too.

I need to do a bit more research here, but I think we have some options.
--=20
Jeff Layton <jlayton@kernel.org>
