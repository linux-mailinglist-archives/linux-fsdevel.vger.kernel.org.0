Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4FD43A03D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhJYT3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:29:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:36498 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhJYT0L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:26:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="228501246"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="228501246"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:02:01 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="446367107"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:02:01 -0700
Date:   Mon, 25 Oct 2021 12:02:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 2/7] fuse: make DAX mount option a tri-state
Message-ID: <20211025190201.GG3465596@iweiny-DESK2.sc.intel.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-3-jefflexu@linux.alibaba.com>
 <YW2AU/E0pLHO5Yl8@redhat.com>
 <652ac323-6546-01b8-992e-460ad59577ca@linux.alibaba.com>
 <YXAzB5sOrFRUzTC5@redhat.com>
 <96956132-fced-5739-d69a-7b424dc65f7c@linux.alibaba.com>
 <20211025175251.GF3465596@iweiny-DESK2.sc.intel.com>
 <YXbzeomdC5cD1xfF@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXbzeomdC5cD1xfF@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 02:12:10PM -0400, Vivek Goyal wrote:
> On Mon, Oct 25, 2021 at 10:52:51AM -0700, Ira Weiny wrote:
> > On Fri, Oct 22, 2021 at 02:54:03PM +0800, JeffleXu wrote:
> > > cc [Ira Weiny], author of per inode DAX on xfs/ext4
> > > 
> > > On 10/20/21 11:17 PM, Vivek Goyal wrote:
> > > > On Wed, Oct 20, 2021 at 10:52:38AM +0800, JeffleXu wrote:
> > > >>
> > > >>
> > > >> On 10/18/21 10:10 PM, Vivek Goyal wrote:
> > > >>> On Mon, Oct 11, 2021 at 11:00:47AM +0800, Jeffle Xu wrote:
> > > >>>> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
> > > >>>> operate the same which is equivalent to 'always'. To be consistemt with
> > > >>>> ext4/xfs's tri-state mount option, when neither '-o dax' nor '-o dax='
> > > >>>> option is specified, the default behaviour is equal to 'inode'.
> > > >>>
> > > >>> Hi Jeffle,
> > > >>>
> > > >>> I am not sure when  -o "dax=inode"  is used as a default? If user
> > > >>> specifies, "-o dax" then it is equal to "-o dax=always", otherwise
> > > >>> user will explicitly specify "-o dax=always/never/inode". So when
> > > >>> is dax=inode is used as default?
> > > >>
> > > >> That means when neither '-o dax' nor '-o dax=always/never/inode' is
> > > >> specified, it is actually equal to '-o dax=inode', which is also how
> > > >> per-file DAX on ext4/xfs works.
> > > > 
> > 
> > It's been a while so I'm fuzzy on the details of the discussions but yes that
> > is the way things are now in the code.
> > 
> > > > [ CC dave chinner] 
> > > > 
> > > > Is it not change of default behavior for ext4/xfs as well. My
> > > > understanding is that prior to this new dax options, "-o dax" enabled
> > > > dax on filesystem and if user did not specify it, DAX is disbaled
> > > > by default.
> > 
> > Technically it does change default behavior...  However, NOT in a way which
> > breaks anything.  See below.
> > 
> > > > 
> > > > Now after introduction of "-o dax=always/never/inode", if suddenly
> > > > "-o dax=inode" became the default if user did not specify anything,
> > > > that's change of behavior.
> > 
> > Technically yes but not in a broken way.
> > 
> > > >
> > > > Is that intentional. If given a choice,
> > > > I would rather not change default and ask user to opt-in for
> > > > appropriate dax functionality.
> > 
> > There is no need for this.
> > 
> > > > 
> > > > Dave, you might have thoughts on this. It makes me uncomfortable to
> > > > change virtiofs dax default now just because other filesytems did it.
> > > > 
> > > 
> > > I can only find the following discussions about the earliest record on
> > > this tri-state mount option:
> > > 
> > > https://lore.kernel.org/lkml/20200316095509.GA13788@lst.de/
> > > https://lore.kernel.org/lkml/20200401040021.GC56958@magnolia/
> > > 
> > > 
> > > Hi, Ira Weiny,
> > > 
> > > Do you have any thought on this, i.e. why the default behavior has
> > > changed after introduction of per inode dax?
> > 
> > While this is 'technically' different behavior the end user does not see any
> > difference in behavior if they continue without software changes.  Specifically
> > specifying nothing continues to operate with all the files on the FS to be
> > '_not_ DAX'.  While specifying '-o dax' forces DAX on all files.
> > 
> > This expands the default behavior in a backwards compatible manner.
> 
> This is backward compatible in a sense that if somebody upgrades to new
> kernel, things will still be same. 
> 
> I think little problematic change is that say I bring in persistent
> memory from another system (which has FS_XFLAGS_DAX set on some inodes)
> and then mount it without andy of the dax mount options, then per
> inode dax will be enabled unexpectedly if I boot with newer kernels
> but it will be disable if I mount with older kernels. Do I understand it
> right.

Indeed that will happen.  However, wouldn't the users (software) of those files
have knowledge that those files were DAX and want to continue with them in that
mode?

> 
> > The user
> > can now enable DAX on some files.  But this is an opt-in on the part of the
> > user of the FS and again does not change with existing software/scripts/etc.
> 
> Don't understand this "opt-in" bit. If user mounts an fs without
> specifying any of the dax options, then per inode dax will still be
> enabled if inode has the correct flag set.

But only users who actually set that flag 'opt-in'.

> So is setting of flag being
> considered as opt-in (insted of mount option).

Yes.

> 
> If setting of flag is being considered as opt-in, that probably will not
> work very well with virtiofs. Because server can enforce a different
> policy for enabling per file dax (instead of FS_XFLAG_DAX).

I'm not sure I understand how this happens?  I think the server probably has to
enable per INODE by default to allow the client to do what the end users wants.

I agree that if the end user is expecting DAX and the server disables it then
that is a problem but couldn't that happen before?  Maybe I'm getting confused
because I'm not familiar enough with virtiofs.

> 
> And given there are two entities here (client and server), I think it
> will be good if if we give client a chance as well to decide whether
> it wants to enable per file dax or not. I know it can alwasy do 
> "dax=never" but it can still be broken if client software remains
> same but host/server software is upgraded or commnad line changed.

But the files are 'owned' by a single user or group of users who must have
placed the file in DAX mode at some point right?

> 
> So for virtiofs, I think better behavior is to continue to not enable
> any dax until and unless user opts-in using "-o dax=foo" options.

I'm not sure, maybe.

Ira
