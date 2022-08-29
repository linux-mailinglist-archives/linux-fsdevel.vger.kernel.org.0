Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE615A4293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 07:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH2Fs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 01:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2Fs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:48:57 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAC9146214;
        Sun, 28 Aug 2022 22:48:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 43D3562DA32;
        Mon, 29 Aug 2022 15:48:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oSXdg-001DXe-Mw; Mon, 29 Aug 2022 15:48:48 +1000
Date:   Mon, 29 Aug 2022 15:48:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
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
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
Message-ID: <20220829054848.GR3600936@dread.disaster.area>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <732164ffb95468992035a6f597dc26e3ce39316d.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=630c5345
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=Emwzr4xTW__1gdtk8LEA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 28, 2022 at 10:37:37AM -0400, Jeff Layton wrote:
> On Sun, 2022-08-28 at 16:25 +0300, Amir Goldstein wrote:
> > On Sat, Aug 27, 2022 at 7:10 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > Yeah, thinking about it some more, simply changing the block allocation
> > > is not something that should affect the ctime, so we probably don't want
> > > to bump i_version on it. It's an implicit change, IOW, not an explicit
> > > one.
> > > 
> > > The fact that xfs might do that is unfortunate, but it's not the end of
> > > the world and it still would conform to the proposed definition for
> > > i_version. In practice, this sort of allocation change should come soon
> > > after the file was written, so one would hope that any damage due to the
> > > false i_version bump would be minimized.
> > > 
> > 
> > That was exactly my point.
> > 
> > > It would be nice to teach it not to do that however. Maybe we can insert
> > > the NOIVER flag at a strategic place to avoid it?

No, absolutely not.

I've already explained this: The XFS *disk format specification*
says that di_changecount is bumped for every change that is made to
the inode.

Applications that are written from this specification expect the on
disk format for a XFS given filesystem feature to remain the same
until it is either deprecated and removed or we add feature flags to
indicate it has different behaviour.  We can't just change the
behaviour at a whim.

And that's ignoring the fact that randomly spewing NOIVER
into transactions that modify inode metadata is a nasty hack - it
is not desirable from a design or documentation POV, nor is it
maintainable.

> > Why would that be nice to avoid?
> > You did not specify any use case where incrementing i_version
> > on block mapping change matters in practice.
> > On the contrary, you said that NFS client writer sends COMMIT on close,
> > which should stabilize i_version for the next readers.
> > 
> > Given that we already have an xfs implementation that does increment
> > i_version on block mapping changes and it would be a pain to change
> > that or add a new user options, I don't see the point in discussing it further
> > unless there is a good incentive for avoiding i_version updates in those cases.
> > 
> 
> Because the change to the block allocation doesn't represent an
> "explicit" change to the inode. We will have bumped the ctime on the
> original write (in update_time), but the follow-on changes that occur
> due to that write needn't be counted as they aren't visible to the
> client.
> 
> It's possible for a client to issue a read between the write and the
> flush and get the interim value for i_version. Then, once the write
> happens and the i_version gets bumped again, the client invalidates its
> cache even though it needn't do so.
> 
> The race window ought to be relatively small, and this wouldn't result
> in incorrect behavior that you'd notice (other than loss of
> performance), but it's not ideal. We're doing more on-the-wire reads
> than are necessary in this case.
> 
> It would be nice to have it not do that. If we end up taking this patch
> to make it elide the i_version bumps on atime updates, we may be able to
> set the the NOIVER flag in other cases as well, and avoid some of these
> extra bumps.


<sigh>

Please don't make me repeat myself for the third time.

Once we have decided on a solid, unchanging definition for the
*statx user API variable*, we'll implement a new on-disk field that
provides this information.  We will document it in the on-disk
specification as "this is how di_iversion behaves" so that it is
clear to everyone parsing the on-disk format or writing their own
XFS driver how to implement it and when to expect it to
change.

Then we can add a filesystem and inode feature flags that say "inode
has new iversion" and we use that to populate the kernel iversion
instead of di_changecount. We keep di_changecount exactly the way it
is now for the applications and use cases we already have for that
specific behaviour. If the kernel and/or filesystem don't support
the new di_iversion field, then we'll use di_changecount as it
currently exists for the kernel iversion code.

Keep in mind that we've been doing dynamic inode format updates in
XFS for a couple of decades - users don't even have to be aware that
they need to perform format upgrades because often they just happen
whenever an inode is accessed. IOWs, just because we have to change
the on-disk format to support this new iversion definition, it
doesn't mean users have to reformat filesystems before the new
feature can be used.

Hence, over time, as distros update kernels, the XFS iversion
behaviour will change automagically as we update inodes in existing
filesystems as they are accessed to add and then use the new
di_iversion field for the VFS change attribute field instead of the
di_changecount field...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
