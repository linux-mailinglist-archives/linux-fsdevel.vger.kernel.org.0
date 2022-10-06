Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744875F7014
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 23:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiJFVRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 17:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiJFVRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:17:09 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21A00BCBB4;
        Thu,  6 Oct 2022 14:17:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B26898AC9FD;
        Fri,  7 Oct 2022 08:17:03 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ogYEn-00GSwS-1i; Fri, 07 Oct 2022 08:17:01 +1100
Date:   Fri, 7 Oct 2022 08:17:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 6/9] nfsd: use the getattr operation to fetch i_version
Message-ID: <20221006211700.GQ3600936@dread.disaster.area>
References: <20220930111840.10695-1-jlayton@kernel.org>
 <20220930111840.10695-7-jlayton@kernel.org>
 <166484034920.14457.15225090674729127890@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166484034920.14457.15225090674729127890@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=633f45d2
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=Qawa6l4ZSaYA:10 a=7-415B0cAAAA:8
        a=ytSwbLbjndvwotgT2MMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:39:09AM +1100, NeilBrown wrote:
> On Fri, 30 Sep 2022, Jeff Layton wrote:
> > Now that we can call into vfs_getattr to get the i_version field, use
> > that facility to fetch it instead of doing it in nfsd4_change_attribute.
> > 
> > Neil also pointed out recently that IS_I_VERSION directory operations
> > are always logged, and so we only need to mitigate the rollback problem
> > on regular files. Also, we don't need to factor in the ctime when
> > reexporting NFS or Ceph.
> > 
> > Set the STATX_VERSION (and BTIME) bits in the request when we're dealing
> > with a v4 request. Then, instead of looking at IS_I_VERSION when
> > generating the change attr, look at the result mask and only use it if
> > STATX_VERSION is set. With this change, we can drop the fetch_iversion
> > export operation as well.
> > 
> > Move nfsd4_change_attribute into nfsfh.c, and change it to only factor
> > in the ctime if it's a regular file and the fs doesn't advertise
> > STATX_ATTR_VERSION_MONOTONIC.
....
> > +
> > +/*
> > + * We could use i_version alone as the change attribute.  However, i_version
> > + * can go backwards on a regular file after an unclean shutdown.  On its own
> > + * that doesn't necessarily cause a problem, but if i_version goes backwards
> > + * and then is incremented again it could reuse a value that was previously
> > + * used before boot, and a client who queried the two values might incorrectly
> > + * assume nothing changed.
> > + *
> > + * By using both ctime and the i_version counter we guarantee that as long as
> > + * time doesn't go backwards we never reuse an old value. If the filesystem
> > + * advertises STATX_ATTR_VERSION_MONOTONIC, then this mitigation is not needed.
> > + *
> > + * We only need to do this for regular files as well. For directories, we
> > + * assume that the new change attr is always logged to stable storage in some
> > + * fashion before the results can be seen.
> > + */
> > +u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)
> > +{
> > +	u64 chattr;
> > +
> > +	if (stat->result_mask & STATX_VERSION) {
> > +		chattr = stat->version;
> > +
> > +		if (S_ISREG(inode->i_mode) &&
> > +		    !(stat->attributes & STATX_ATTR_VERSION_MONOTONIC)) {
> 
> I would really rather that the fs got to make this decision.
> If it can guarantee that the i_version is monotonic even over a crash
> (which is probably can for directory, and might need changes to do for
> files) then it sets STATX_ATTR_VERSION_MONOTONIC and nfsd trusts it
> completely.

If you want a internal-to-nfsd solution to this monotonic iversion
problem for file data writes, then all we need to do is take the NFS
server back to NFSv2 days where all server side data writes writes
were performed as O_DSYNC writes. The NFSv3 protocol modifications
for (unstable writes + COMMIT) to allow the NFS server to use
volatile caching is the source of all the i_version persistent
guarantees we are talking about here....

So if the NFS server uses O_DSYNC writes again, by the time the
WRITE response is sent to the client (which can now use
NFS_DATA_SYNC instead of NFS_UNSTABLE so the client can mark pages
clean immediately) both the file data and the inode metadata have
been persisted.

Further, if the nfsd runs ->commit_metadata after the write has
completed, the nfsd now has a guarantee that i_version it places in
the post-ops is both persistent and covers the data change that was
just made. Problem solved, yes?

Ideally we'd want writethrough IO operation with ->commit_metadata
then guaranteeing both completed data and metadata changes are
persistent (XFS already provides this guarantee) for efficiency,
but the point remains that STATX_ATTR_VERSION_MONOTONIC behaviour
can already be implemented by the NFS server application regardless
of when the underlying filesystem bumps i_version for data writes...

Yeah, I know writethrough can result in some workloads being a bit
slower, but NFS clients are already implemented to hide write
latency from the applications. Also, NFS servers are being built
from fast SSDs these days, so this mitigates the worst of the
latency issues that writethrough IO creates....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
