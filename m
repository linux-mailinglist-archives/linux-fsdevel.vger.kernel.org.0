Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E49543A4E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhJYUoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:44:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:7143 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231748AbhJYUoJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:44:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="230035076"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="230035076"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 13:41:46 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="465038806"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 13:41:46 -0700
Date:   Mon, 25 Oct 2021 13:41:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 2/7] fuse: make DAX mount option a tri-state
Message-ID: <20211025204145.GH3465596@iweiny-DESK2.sc.intel.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-3-jefflexu@linux.alibaba.com>
 <YW2AU/E0pLHO5Yl8@redhat.com>
 <652ac323-6546-01b8-992e-460ad59577ca@linux.alibaba.com>
 <YXAzB5sOrFRUzTC5@redhat.com>
 <96956132-fced-5739-d69a-7b424dc65f7c@linux.alibaba.com>
 <20211025175251.GF3465596@iweiny-DESK2.sc.intel.com>
 <YXbzeomdC5cD1xfF@redhat.com>
 <20211025190201.GG3465596@iweiny-DESK2.sc.intel.com>
 <YXcGiw6m9363Cz83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXcGiw6m9363Cz83@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 03:33:31PM -0400, Vivek Goyal wrote:

[snip]

> > > > > > 
> > > > > 
> > > > > I can only find the following discussions about the earliest record on
> > > > > this tri-state mount option:
> > > > > 
> > > > > https://lore.kernel.org/lkml/20200316095509.GA13788@lst.de/
> > > > > https://lore.kernel.org/lkml/20200401040021.GC56958@magnolia/
> > > > > 
> > > > > 
> > > > > Hi, Ira Weiny,
> > > > > 
> > > > > Do you have any thought on this, i.e. why the default behavior has
> > > > > changed after introduction of per inode dax?
> > > > 
> > > > While this is 'technically' different behavior the end user does not see any
> > > > difference in behavior if they continue without software changes.  Specifically
> > > > specifying nothing continues to operate with all the files on the FS to be
> > > > '_not_ DAX'.  While specifying '-o dax' forces DAX on all files.
> > > > 
> > > > This expands the default behavior in a backwards compatible manner.
> > > 
> > > This is backward compatible in a sense that if somebody upgrades to new
> > > kernel, things will still be same. 
> > > 
> > > I think little problematic change is that say I bring in persistent
> > > memory from another system (which has FS_XFLAGS_DAX set on some inodes)
> > > and then mount it without andy of the dax mount options, then per
> > > inode dax will be enabled unexpectedly if I boot with newer kernels
> > > but it will be disable if I mount with older kernels. Do I understand it
> > > right.
> > 
> > Indeed that will happen.  However, wouldn't the users (software) of those files
> > have knowledge that those files were DAX and want to continue with them in that
> > mode?
> 
> I am not sure. Say before per-inode dax feature, I had written a script
> which walks though all the mount points and figure out if dax is enabled
> or not. I could simply look at mount options and tell if dax could be
> enabled or not.
> 
> But now same script will give false results as per inode dax could
> still be enabled.

The mount option is being deprecated.  So it is best to start to phase out
scripts like that.

> 
> > 
> > > 
> > > > The user
> > > > can now enable DAX on some files.  But this is an opt-in on the part of the
> > > > user of the FS and again does not change with existing software/scripts/etc.
> > > 
> > > Don't understand this "opt-in" bit. If user mounts an fs without
> > > specifying any of the dax options, then per inode dax will still be
> > > enabled if inode has the correct flag set.
> > 
> > But only users who actually set that flag 'opt-in'.
> > 
> > > So is setting of flag being
> > > considered as opt-in (insted of mount option).
> > 
> > Yes.
> > 
> > > 
> > > If setting of flag is being considered as opt-in, that probably will not
> > > work very well with virtiofs. Because server can enforce a different
> > > policy for enabling per file dax (instead of FS_XFLAG_DAX).
> > 
> > I'm not sure I understand how this happens?  I think the server probably has to
> > enable per INODE by default to allow the client to do what the end users wants.
> > 
> 
> Server can have either per inode disabled or enabled. If enabled, it could
> determine DAX status of file based on FS_XFLAG_DAX or based on something
> else depending on server policy. Users want to be able to determine
> DAX status of file based on say file size.

'file size'?  I'm not sure how that would work.  Did you mean something else?

> 
> > I agree that if the end user is expecting DAX and the server disables it then
> > that is a problem but couldn't that happen before?
> 
> If end user expects to enable DAX and sever can't enable it, then mount
> fails. So currently if you mount "-o dax" and server does not support
> DAX, mount will fail.

The same could happen on a server where the underlying device does not support
DAX.  What if the server was mounted without '-o dax'?  Wouldn't a client mount
with '-o dax' fail now?  So why can't the same be true with the new set of
options?

> 
> I think same should happen when per inode DAX is introduced for virtiofs.
> If sever does not support per inode dax and user mounts with "-o
> dax=inode", then mount should fail.

I think that is reasonable.  The client can't mount with something the server
can't support.

> 
> In fact, this is another reason that probably "dax=inode" should not be
> default. Say client is new and server is old and does not support
> per inode dax, then client might start failing mount after client
> upgrade, and that's not good.

Shouldn't the client fall back to whatever the server supports?  It is the same
as the client wanting DAX now without server and/or device support.  It just
can't get it.  Right?

> 
> More I think about it, more it feels like that "dax=never" should be
> the default if user has not specified any of the dax options. This
> probably will introduce least amount of surprise. Atleast for virtiofs.
> IMHO, it probably would have made sense even for ext4/xfs but that
> ship has already sailed.

I disagree because dax=never is backwards from what we really want for the
future.  'dax=inode' is the most flexible setting.  In fact that setting is
best for the server by default which allows more control to be in the clients
hands.  Would you agree?

> 
> > Maybe I'm getting confused
> > because I'm not familiar enough with virtiofs.
> > 
> > > 
> > > And given there are two entities here (client and server), I think it
> > > will be good if if we give client a chance as well to decide whether
> > > it wants to enable per file dax or not. I know it can alwasy do 
> > > "dax=never" but it can still be broken if client software remains
> > > same but host/server software is upgraded or commnad line changed.
> > 
> > But the files are 'owned' by a single user or group of users who must have
> > placed the file in DAX mode at some point right?
> 
> Yes, either users/groups/admin might have set FS_XFLAG_DAX on inodes. But
> now there is another controller (virtiofs server) which determines whether
> that flag takes affect or not (based on server settings).

I think this is just like the file being on a device which does not support
DAX.  The file inode flag can be set but the file will not be in DAX mode on a
non-dax device.  So in this case the server is a non-dax device.

Ira

> 
> We did not have this server scenario in case of local filesystems.
> 
> Thanks
> Vivek
> >
> > > 
> > > So for virtiofs, I think better behavior is to continue to not enable
> > > any dax until and unless user opts-in using "-o dax=foo" options.
> > 
> > I'm not sure, maybe.
> > 
> > Ira
> > 
> 
