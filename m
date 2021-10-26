Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6C43BBF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbhJZVAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 17:00:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:35285 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhJZVAA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:00:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="210795343"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="210795343"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 13:57:33 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="486357039"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 13:57:31 -0700
Date:   Tue, 26 Oct 2021 13:57:31 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <20211026205730.GI3465596@iweiny-DESK2.sc.intel.com>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia>
 <YXhWP/FCkgHG/+ou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXhWP/FCkgHG/+ou@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
> 
> - dax=inode is default. This is change of behavior from old "-o dax" where
>   default was *no dax* at all.

Again I think this is debatable.  The file system will still work and all files
will, by default, _not_ use DAX.  Specifying '-o dax' or future proof '-o
dax=always' will override this just like it did before.

> 
> - I tried xfs and mount does not fail even if user mounted with
>   "-o dax=inode" and underlying block device does not support dax.
>   That's little strange. Some users might expect a failure if certain
>   mount option can't be enabled.

But the mount option _is_ enabled.  It is just that the files can't be used in
DAX mode.  The files can still have their inode flag set.  This was
specifically discussed to support backing up file systems on devices which did
not support DAX.  This allows you to restore that file system with all the
proper inode flags in place.

If a DAX file is on a non-DAX device the file will not be in DAX mode when
opened.  A statx() call can determine this.

> 
>   So in general, what's the expected behavior with filesystem mount
>   options. If user passes a mount option and it can't be enabled,
>   should filesystem return error and force user to try again without
>   the certain mount option or silently fallback to something else.

But it is enabled.

> 
>   I think in the past I have come across overlayfs users which demanded
>   that mount fails if certain overlayfs option they have passed in
>   can't be honored. They want to know about it so that they can either
>   fix the configuration or change mount option.

I understand how this is a bit convoluted.  However, for 99% of the users out
there who are using DAX on DAX devices this is not going to change anything for
them.  (Especially since they are all probably using '-o dax').

> 
> - With xfs, I mounted /dev/pmem0 with "-o dax=inode" and checked
>   /proc/mounts and I don't see "dax=inode" there. Is that intentional?

Yes absolutely.  I originally implemented it to show dax=inode and was told
that default mount options were not to be shown.  After thinking about it I
agreed.  It is intractable to print out all the mount options which are
defaulted.  The user can read what the defaults are an know what the file
system is using for options which are not overridden.

> 
> I am just trying to wrap my head around the new semantics as we are
> trying to implement those for virtiofs.
> 
> So following is the side affects of behavior change.
> 
> A. If somebody wrote scripts and scanned for mount flags to decide whehter
>    dax is enabled or not, these will not work anymore. scripts will have
>    to be changed to stat() every file in filesystem and look for
>    STATX_ATTR_DAX flag to determine dax status.

Why would you need to stat() 'every' file?  Why, and to who, is it important
that every file in the file system is in dax mode?  I was getting the feeling
that it was important to the client to know this on the server but you last
email in the other thread has confused me on that point.[1]


> 
> I would have thought to not make dax=inode default and let user opt-in
> for that using "dax=inode" mount option. But I guess people liked 
> dax=inode default better.

Yes, because it gives the _end_ user (not the sys-admin) the control on their
individual files.

> 
> Anway, I guess if we want to keep the behavior of virtiofs in-line with
> ext4/xfs, we might have to make dax=inode default (atleast in client).

Yes, I think we should make dax=inode the default.

> Server default might be different because querying the state of
> FS_XFLAG_DAX is extra ioctl() call on each LOOKUP and GETATTR call and
> those who don't want to use DAX, might not want to pay this cost.

I've not responded on the other thread because I feel like I've reached the
depth of my virtiofs knowledge.  From your email:

	"In general, there is no connection between DAX in guest and device on
	host enabling DAX."[1]

But then you say:

	"... if server does not support DAX and client asks for DAX, mount will
	fail. (As it should fail)."[1]

So I decided I need to review the virtiofs code a bit to better understand this
relationship.  Because I'm confused.

As to the subject of having a file based policy; any such policy is not the
kernels job.  If users want to have different policies based on file size they
are free to do that with dax=inode.  I don't see how that works with the other
2 mount options.

Furthermore, performance of different files may be device specific and moving a
file from one device to another may result in the user wanting to change the
mode, which dax=inode allows.

All of this this supports dax=inode as a better default.

I get the feeling that your most concerned with the admin user being able to
see if the entire file system is in DAX mode.  Is that true?  And I can't argue
that indeed that is different.  But I'm failing to see the use case for that
being a requirement.

Is the biggest issue the lack of visibility to see if the device supports DAX?

Ira

[1] https://lore.kernel.org/linux-fsdevel/YXgGlrlv9VBFVt2U@redhat.com/
