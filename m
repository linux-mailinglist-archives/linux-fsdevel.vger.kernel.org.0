Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6678543BD45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbhJZWft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 18:35:49 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:52955 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230411AbhJZWft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 18:35:49 -0400
Received: from dread.disaster.area (pa49-180-20-157.pa.nsw.optusnet.com.au [49.180.20.157])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id EC7EC862E6B;
        Wed, 27 Oct 2021 09:33:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mfV0P-001OjH-W4; Wed, 27 Oct 2021 09:33:18 +1100
Date:   Wed, 27 Oct 2021 09:33:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        ira.weiny@intel.com, linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <20211026223317.GB5111@dread.disaster.area>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia>
 <YXhWP/FCkgHG/+ou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXhWP/FCkgHG/+ou@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61788232
        a=t5ERiztT/VoIE8AqcczM6g==:117 a=t5ERiztT/VoIE8AqcczM6g==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
        a=7-415B0cAAAA:8 a=Yd87Uj8TZwFvIcvWS4wA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 03:25:51PM -0400, Vivek Goyal wrote:
> On Tue, Oct 26, 2021 at 08:48:34AM -0700, Darrick J. Wong wrote:
> > On Tue, Oct 26, 2021 at 10:12:17PM +0800, JeffleXu wrote:
> > > Hi,
> > > 
> > > Recently I'm working on supporting per-file DAX for virtiofs [1]. Vivek
> > > Goyal and I are interested [2] why the default behavior has changed
> > > since introduction of per-file DAX on ext4 and xfs [3][4].
> > > 
> > > That is, before the introduction of per-file DAX, when user doesn't
> > > specify '-o dax', DAX is disabled for all files. After supporting
> > > per-file DAX, when neither '-o dax' nor '-o dax=always|inode|never' is
> > > specified, it actually works in a '-o dax=inode' way if the underlying
> > > blkdev is DAX capable, i.e. depending on the persistent inode flag. That
> > > is, the default behavior has changed from user's perspective.
> > > 
> > > We are not sure if this is intentional or not. Appreciate if anyone
> > > could offer some hint.
> > 
> > Yes, that was an intentional change to all three filesystems to make the
> > steps we expose to sysadmins/users consistent and documented officially:
> > 
> > https://lore.kernel.org/linux-fsdevel/20200429043328.411431-1-ira.weiny@intel.com/
> 
> Ok, so basically new dax options semantics are different from old "-o dax".

Well, yes. "-o dax" is exactly equivalent of "-o dax=always", but it
is deprecated and should be ignored for the purposes of a new FSDAX
implementation. It will go away eventually.

> - dax=inode is default. This is change of behavior from old "-o dax" where
>   default was *no dax* at all.

No, it's not actually a change of behaviour. The default behaviour
of a filesystem that supports DAX is identical when you have no
mount option specified: if you've taken no action to enable DAX,
then DAX will be disabled and not used.

We originally implemented DAX with per-inode flags an no mount
option in XFS - the mount option came along with the ext4 DAX
implementation for testing because it didn't have on-disk inode
flags for DAX.

IOWs, the dax=inode default reflects how we originally intended
FSDAX to be managed and how it originally behaved on XFS when no
mount option was specified. Then we came across bugs in dynamically
changing the per-inode DAX state, we temporarily disabled the
on-disk flags on XFS (because EXPERIMENTAL). Then some people
started incorrectly associated "no dax option" with "admin wants dax
disabled". Then we fixed the bugs with changing on-disk inode flags,
ext4 added an on-disk flag and we re-enabled them. The result was a
tristate config situation - never, always and per-inode...

> - I tried xfs and mount does not fail even if user mounted with
>   "-o dax=inode" and underlying block device does not support dax.
>   That's little strange. Some users might expect a failure if certain
>   mount option can't be enabled.

It's perfectly reasonable. If the hardware doesn't support DAX, then
we just always behave as if dax=never is set. IOWs, we simply ignore
the inode DAX hint, because we can never enable it. There's just no
reason for being obnoxious and rejecting mounts just because the
block device doesn't support DAX.

Then we have to consider filesystems with multiple block devices
that have different DAX capabilities. dax=inode has to transparently
become dax=never for the block devices that don't support DAX, but
still operate as dax=inode for the other DAX capable block devices.

We also have to consider that block devices can change configuration
dynamically - think about teired storage (e.g a dm-cache device)
that has pmem for hot access and SSDs for backing store. That could
mean we have DAX capable access for hot data, but not for cold data
fetched/stored from SSD. We might manually migrate data between
teirs and so the dax capability of the data sets can change
dynamically.

The actual presence of DAX should be completely transparent and
irrelevant to the application unless the application is specifically
dependent on DAX being enabled (i.e. using application level CPU
cache flushes for data integrity purposes). If so, it is up to the
application to check STATX_ATTR_DAX on it's open files and refuse to
operate.

>   So in general, what's the expected behavior with filesystem mount
>   options. If user passes a mount option and it can't be enabled,
>   should filesystem return error and force user to try again without
>   the certain mount option or silently fallback to something else.
> 
>   I think in the past I have come across overlayfs users which demanded
>   that mount fails if certain overlayfs option they have passed in
>   can't be honored. They want to know about it so that they can either
>   fix the configuration or change mount option.

It's up to the filesystem how it handles mount options. XFS just
turns dax=always into dax=never with a warning and continues
onwards. There's no point in forcing the user to mount with a
different mount option - the end result is going to be exactly the
same (i.e. dax=never because hardware doesn't support it).

> - With xfs, I mounted /dev/pmem0 with "-o dax=inode" and checked
>   /proc/mounts and I don't see "dax=inode" there. Is that intentional?

Yes, XFS policy is to elide default options from the mount table.

> So following is the side affects of behavior change.
> 
> A. If somebody wrote scripts and scanned for mount flags to decide whehter
>    dax is enabled or not, these will not work anymore.

Correct - this was never supported in the first place and we went
through this years ago with intel doing dodgy things like this in their
userspace library that we never intended to support.

>    scripts will have
>    to be changed to stat() every file in filesystem and look for
>    STATX_ATTR_DAX flag to determine dax status.

If you are scanning the filesystem for "DAX capability" then you are
doing it wrong. DAX capability is a property of the underlying block
device:

$ cat /sys/block/pmem0/queue/dax 
1
$

And that tells you if the filesystem is on DAX capable hardware
and hence can be used if the admin and/or application turns it on.

> I would have thought to not make dax=inode default and let user opt-in
> for that using "dax=inode" mount option. But I guess people liked 
> dax=inode default better.
> 
> Anway, I guess if we want to keep the behavior of virtiofs in-line with
> ext4/xfs, we might have to make dax=inode default (atleast in client).

Yes, I've been asking you to make dax=inode the default for some
time now.

> Server default might be different because querying the state of
> FS_XFLAG_DAX is extra ioctl() call on each LOOKUP and GETATTR call and
> those who don't want to use DAX, might not want to pay this cost.

The admin cost of managing per-inode/per-directory DAX capability is
negliable. It's a "set-once" operation done at application
installation/configuration/data set initialisation time, and never
changed again.  Performance/overhead arguments for per-inode flag
admin hold no water at all.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
