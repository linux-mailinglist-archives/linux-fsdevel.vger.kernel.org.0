Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97043CA60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbhJ0NRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 09:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236464AbhJ0NRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635340492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6lYaDAFuy3wt+ZO/zKfRWwoq5pybwrOMZoYnxodYxNE=;
        b=erHkmr1LZJQOepLGqqaO2W+nJMC+mxttB6I0EkQddF0vL2D70a2X6cSRMldmRn4NQpICwH
        9TMWaZWnIFSB+0sA9K8ZqCykFTPIJl/DAxUU37S6T1y6RKArM3kf9rxYBEjbOJ0FSmWv50
        gpTlTPZ2nU/QMDuu/jwxqcTmz03c480=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-Q5cUAYpoMiC8w9SP8OSISw-1; Wed, 27 Oct 2021 09:14:51 -0400
X-MC-Unique: Q5cUAYpoMiC8w9SP8OSISw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E29A0CAB;
        Wed, 27 Oct 2021 13:14:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.34.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B8A21001B3B;
        Wed, 27 Oct 2021 13:14:49 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E3E8F2204A5; Wed, 27 Oct 2021 09:14:48 -0400 (EDT)
Date:   Wed, 27 Oct 2021 09:14:48 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        ira.weiny@intel.com, linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <YXlQyMfXDQnO/5E3@redhat.com>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia>
 <YXhWP/FCkgHG/+ou@redhat.com>
 <20211026223317.GB5111@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026223317.GB5111@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 09:33:17AM +1100, Dave Chinner wrote:
> On Tue, Oct 26, 2021 at 03:25:51PM -0400, Vivek Goyal wrote:
> > On Tue, Oct 26, 2021 at 08:48:34AM -0700, Darrick J. Wong wrote:
> > > On Tue, Oct 26, 2021 at 10:12:17PM +0800, JeffleXu wrote:
> > > > Hi,
> > > > 
> > > > Recently I'm working on supporting per-file DAX for virtiofs [1]. Vivek
> > > > Goyal and I are interested [2] why the default behavior has changed
> > > > since introduction of per-file DAX on ext4 and xfs [3][4].
> > > > 
> > > > That is, before the introduction of per-file DAX, when user doesn't
> > > > specify '-o dax', DAX is disabled for all files. After supporting
> > > > per-file DAX, when neither '-o dax' nor '-o dax=always|inode|never' is
> > > > specified, it actually works in a '-o dax=inode' way if the underlying
> > > > blkdev is DAX capable, i.e. depending on the persistent inode flag. That
> > > > is, the default behavior has changed from user's perspective.
> > > > 
> > > > We are not sure if this is intentional or not. Appreciate if anyone
> > > > could offer some hint.
> > > 
> > > Yes, that was an intentional change to all three filesystems to make the
> > > steps we expose to sysadmins/users consistent and documented officially:
> > > 
> > > https://lore.kernel.org/linux-fsdevel/20200429043328.411431-1-ira.weiny@intel.com/
> > 
> > Ok, so basically new dax options semantics are different from old "-o dax".
> 
> Well, yes. "-o dax" is exactly equivalent of "-o dax=always", but it
> is deprecated and should be ignored for the purposes of a new FSDAX
> implementation. It will go away eventually.
> 
> > - dax=inode is default. This is change of behavior from old "-o dax" where
> >   default was *no dax* at all.
> 
> No, it's not actually a change of behaviour. The default behaviour
> of a filesystem that supports DAX is identical when you have no
> mount option specified: if you've taken no action to enable DAX,
> then DAX will be disabled and not used.
> 
> We originally implemented DAX with per-inode flags an no mount
> option in XFS - the mount option came along with the ext4 DAX
> implementation for testing because it didn't have on-disk inode
> flags for DAX.
> 
> IOWs, the dax=inode default reflects how we originally intended
> FSDAX to be managed and how it originally behaved on XFS when no
> mount option was specified. Then we came across bugs in dynamically
> changing the per-inode DAX state, we temporarily disabled the
> on-disk flags on XFS (because EXPERIMENTAL). Then some people
> started incorrectly associated "no dax option" with "admin wants dax
> disabled". Then we fixed the bugs with changing on-disk inode flags,
> ext4 added an on-disk flag and we re-enabled them. The result was a
> tristate config situation - never, always and per-inode...
> 
> > - I tried xfs and mount does not fail even if user mounted with
> >   "-o dax=inode" and underlying block device does not support dax.
> >   That's little strange. Some users might expect a failure if certain
> >   mount option can't be enabled.
> 

Hi Dave,

Thanks for all the explanaiton and background. It helps me a lot in
wrapping my head around the rationale for current design.

> It's perfectly reasonable. If the hardware doesn't support DAX, then
> we just always behave as if dax=never is set.

I tried mounting non-DAX block device with dax=always and it failed
saying DAX can't be used with reflink.

[  100.371978] XFS (vdb): DAX unsupported by block device. Turning off DAX.
[  100.374185] XFS (vdb): DAX and reflink cannot be used together!

So looks like first check tried to fallback to dax=never as device does
not support DAX. But later reflink check thought dax is enabled and
did not fallback to dax=never.

> IOWs, we simply ignore
> the inode DAX hint, because we can never enable it. There's just no
> reason for being obnoxious and rejecting mounts just because the
> block device doesn't support DAX.
> 
> Then we have to consider filesystems with multiple block devices
> that have different DAX capabilities. dax=inode has to transparently
> become dax=never for the block devices that don't support DAX, but
> still operate as dax=inode for the other DAX capable block devices.
> 
> We also have to consider that block devices can change configuration
> dynamically - think about teired storage (e.g a dm-cache device)
> that has pmem for hot access and SSDs for backing store. That could
> mean we have DAX capable access for hot data, but not for cold data
> fetched/stored from SSD. We might manually migrate data between
> teirs and so the dax capability of the data sets can change
> dynamically.
> 
> The actual presence of DAX should be completely transparent and
> irrelevant to the application unless the application is specifically
> dependent on DAX being enabled (i.e. using application level CPU
> cache flushes for data integrity purposes). If so, it is up to the
> application to check STATX_ATTR_DAX on it's open files and refuse to
> operate.
> 
> >   So in general, what's the expected behavior with filesystem mount
> >   options. If user passes a mount option and it can't be enabled,
> >   should filesystem return error and force user to try again without
> >   the certain mount option or silently fallback to something else.
> > 
> >   I think in the past I have come across overlayfs users which demanded
> >   that mount fails if certain overlayfs option they have passed in
> >   can't be honored. They want to know about it so that they can either
> >   fix the configuration or change mount option.
> 
> It's up to the filesystem how it handles mount options. XFS just
> turns dax=always into dax=never with a warning and continues
> onwards. There's no point in forcing the user to mount with a
> different mount option - the end result is going to be exactly the
> same (i.e. dax=never because hardware doesn't support it).
> 
> > - With xfs, I mounted /dev/pmem0 with "-o dax=inode" and checked
> >   /proc/mounts and I don't see "dax=inode" there. Is that intentional?
> 
> Yes, XFS policy is to elide default options from the mount table.

For my education purposes, why do we hide default options. These defaults
can vary from system to system based on kernel version or based on
kernel CONFIG options. So if I login into a system and try to figure
out what defaults xfs (or any other filesystem is working with), I
probably will have no idea. Looking at /proc/mounts still might help
me a bit with debugging what filesystem might be doing.

IOW, I thought that from debugging point of view it can be very helpful
to even show default options. But there must be reasons to hide defaults
that I am not aware of.

> 
> > So following is the side affects of behavior change.
> > 
> > A. If somebody wrote scripts and scanned for mount flags to decide whehter
> >    dax is enabled or not, these will not work anymore.
> 
> Correct - this was never supported in the first place and we went
> through this years ago with intel doing dodgy things like this in their
> userspace library that we never intended to support.
> 
> >    scripts will have
> >    to be changed to stat() every file in filesystem and look for
> >    STATX_ATTR_DAX flag to determine dax status.
> 
> If you are scanning the filesystem for "DAX capability" then you are
> doing it wrong. DAX capability is a property of the underlying block
> device:
> 
> $ cat /sys/block/pmem0/queue/dax 
> 1
> $
> 
> And that tells you if the filesystem is on DAX capable hardware
> and hence can be used if the admin and/or application turns it on.
> 
> > I would have thought to not make dax=inode default and let user opt-in
> > for that using "dax=inode" mount option. But I guess people liked 
> > dax=inode default better.
> > 
> > Anway, I guess if we want to keep the behavior of virtiofs in-line with
> > ext4/xfs, we might have to make dax=inode default (atleast in client).
> 
> Yes, I've been asking you to make dax=inode the default for some
> time now.
> 
> > Server default might be different because querying the state of
> > FS_XFLAG_DAX is extra ioctl() call on each LOOKUP and GETATTR call and
> > those who don't want to use DAX, might not want to pay this cost.
> 
> The admin cost of managing per-inode/per-directory DAX capability is
> negliable. It's a "set-once" operation done at application
> installation/configuration/data set initialisation time, and never
> changed again.

Agreed.

> Performance/overhead arguments for per-inode flag
> admin hold no water at all.

Not sure I understand this. If we make dax=inode default in server, then
server will always have to call ioctl() to figure out if FS_XFLAG_DAX
is set or not on LOOKUP and GETATTR calls. So that's one extra system
call all the time. That's not an admin overhead but runtime overhead
of virtiofs file server. And if user never intends to use DAX, then
there is no need to have this overhead (by default).

Thanks
Vivek

