Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C645A584C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 02:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiH3AI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 20:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH3AI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 20:08:58 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9213681B3F;
        Mon, 29 Aug 2022 17:08:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7988E62D9D2;
        Tue, 30 Aug 2022 10:08:52 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oSooF-001WMc-0c; Tue, 30 Aug 2022 10:08:51 +1000
Date:   Tue, 30 Aug 2022 10:08:51 +1000
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
Message-ID: <20220830000851.GV3600936@dread.disaster.area>
References: <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
 <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
 <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org>
 <Ywo8cWRcJUpLFMxJ@magnolia>
 <079df2134120f847e8237675a8cc227d6354a153.camel@hammerspace.com>
 <b13812a68310e49cc6fb649c2b1c25287712a8af.camel@kernel.org>
 <CAOQ4uxgThXDEO3mxR_PtPgcPsF7ueqFUxHO3F3KE9sVqi8sLJQ@mail.gmail.com>
 <732164ffb95468992035a6f597dc26e3ce39316d.camel@kernel.org>
 <20220829054848.GR3600936@dread.disaster.area>
 <8510ff07fdba7dd4c59a14e2f202ff38b83a9ef1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8510ff07fdba7dd4c59a14e2f202ff38b83a9ef1.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=630d5517
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=3_uRt0xjAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=eRzXFghn495hSQseSe0A:9 a=CjuIK1q_8ugA:10
        a=z1SuboXgGPGzQ8_2mWib:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:33:48AM -0400, Jeff Layton wrote:
> On Mon, 2022-08-29 at 15:48 +1000, Dave Chinner wrote:
> > > 
> > > The race window ought to be relatively small, and this wouldn't result
> > > in incorrect behavior that you'd notice (other than loss of
> > > performance), but it's not ideal. We're doing more on-the-wire reads
> > > than are necessary in this case.
> > > 
> > > It would be nice to have it not do that. If we end up taking this patch
> > > to make it elide the i_version bumps on atime updates, we may be able to
> > > set the the NOIVER flag in other cases as well, and avoid some of these
> > > extra bumps.
> > 
> > 
> > <sigh>
> > 
> > Please don't make me repeat myself for the third time.
> > 
> > Once we have decided on a solid, unchanging definition for the
> > *statx user API variable*, we'll implement a new on-disk field that
> > provides this information.  We will document it in the on-disk
> > specification as "this is how di_iversion behaves" so that it is
> > clear to everyone parsing the on-disk format or writing their own
> > XFS driver how to implement it and when to expect it to
> > change.
> > 
> > Then we can add a filesystem and inode feature flags that say "inode
> > has new iversion" and we use that to populate the kernel iversion
> > instead of di_changecount. We keep di_changecount exactly the way it
> > is now for the applications and use cases we already have for that
> > specific behaviour. If the kernel and/or filesystem don't support
> > the new di_iversion field, then we'll use di_changecount as it
> > currently exists for the kernel iversion code.
> > 
> 
> Aside from NFS and IMA, what applications are dependent on the current
> definition and how do they rely on i_version today?

I've answered this multiple times already: the di_changecount
behaviour is defined in the on-disk specification and hence we
*cannot change the behaviour* without changing the on-disk format
specification.

Apart from the forensics aspect of the change counter (which nobody
but us XFS developers seem to understand just how damn important
this is), there are *many* third party applications that parse the
XFS on-disk format directly. This:

https://codesearch.debian.net/search?q=XFS_SB_VERSION_DIRV2&literal=1

Shows grub2, libparted, syslinux, partclone and fsarchiver as
knowing about XFS on-disk superblock flags that tell them what
format the directory structure is in. That alone is enough to
indicate they parse on-disk inodes directly, and hence may expect
di_changecount to have specific meaning and use it to detect
unexpected changes to files/directories they care about.

If I go looking for XFS_SB_MAGIC, I find things like libblkid,
klibc, qemu, Xen, testdisk, gpart, and virtualbox all parse the
on-disk superblocks directly from the block device, too. They also
rely directly on XFS developers ensuring there are no silent
incomaptible changes to the on disk format.

I also know of many other utilities that people and companies have
written that parse the on disk format directly from userspace. The
functions these perform include low level storage management tools,
copying and managing disk images (e.g. offline configuration for
cluster deployments), data recovery tools that scrape all the data
out of broken filesystems, etc.

These applications are reliant on the guarantee we provide that the
on-disk format will not silently change and that behaviour/structure
can always easily be discovered by feature flags in the superblock
and/or inodes.

IOWs, just because there aren't obvious "traditional" application on
top of the kernel filesystem that consumes the in-memory kernel
iversion field, it does not mean that the defined behaviour of the
on-disk di_changecount field is not used or relied on by other tools
that work directly on the on-disk format.

You might be right that NFS doesn't care about this, but the point
remains that NFS does not control the XFS on-disk format, nor does
the fact that what NFS wants from the change attribute has changed
over time override the fact that maintaining XFS on-disk format
compatibility is the responsibility of XFS developers. We're willing
to change the on-disk format to support whatever the new definition
of the statx change attribute ends up being, and that should be the
end of the discussion.

> > Keep in mind that we've been doing dynamic inode format updates in
> > XFS for a couple of decades - users don't even have to be aware that
> > they need to perform format upgrades because often they just happen
> > whenever an inode is accessed. IOWs, just because we have to change
> > the on-disk format to support this new iversion definition, it
> > doesn't mean users have to reformat filesystems before the new
> > feature can be used.
> > 
> > Hence, over time, as distros update kernels, the XFS iversion
> > behaviour will change automagically as we update inodes in existing
> > filesystems as they are accessed to add and then use the new
> > di_iversion field for the VFS change attribute field instead of the
> > di_changecount field...
> > 
> 
> If you want to create a whole new on-disk field for this, then that's
> your prerogative, but before you do that, I'd like to better understand
> why and how the constraints on this field changed.
> 
> The original log message from the commit that added a change counter
> (below) stated that you were adding it for network filesystems like NFS.
> When did this change and why?

It never changed. I'll repeat what I've already explained twice
before:

https://lore.kernel.org/linux-xfs/20220818030048.GE3600936@dread.disaster.area/
https://lore.kernel.org/linux-xfs/20220818033731.GF3600936@dread.disaster.area/

tl; dr: NFS requirements were just one of *many* we had at the time
for an atomic persistent change counter.

The fact is that NFS users are just going to have to put up with
random cache invalidations on XFS for a while longer. Nobody noticed
this and/or cared about this enough to raise it as an issue for the
past decade, so waiting another few months for upstream XFS to
change to a different on-disk format for the NFS/statx change
attribute isn't a big deal.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
