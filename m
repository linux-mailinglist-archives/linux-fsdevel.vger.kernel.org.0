Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504B020461C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 02:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbgFWAqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 20:46:47 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:46388 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731920AbgFWAqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:46:46 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 55F0410E30E;
        Tue, 23 Jun 2020 10:46:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jnX5A-0001Xm-Kw; Tue, 23 Jun 2020 10:46:36 +1000
Date:   Tue, 23 Jun 2020 10:46:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] fs: introduce SB_INLINECRYPT
Message-ID: <20200623004636.GE2040@dread.disaster.area>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-2-satyat@google.com>
 <20200618011912.GA2040@dread.disaster.area>
 <20200618031935.GE1138@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618031935.GE1138@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=c4diDk9UUco1MpDPBz8A:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 08:19:35PM -0700, Eric Biggers wrote:
> On Thu, Jun 18, 2020 at 11:19:12AM +1000, Dave Chinner wrote:
> > On Wed, Jun 17, 2020 at 07:57:29AM +0000, Satya Tangirala wrote:
> > > Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
> > > blk-crypto for file content en/decryption. This flag maps to the
> > > '-o inlinecrypt' mount option which multiple filesystems will implement,
> > > and code in fs/crypto/ needs to be able to check for this mount option
> > > in a filesystem-independent way.
> > > 
> > > Signed-off-by: Satya Tangirala <satyat@google.com>
> > > ---
> > >  fs/proc_namespace.c | 1 +
> > >  include/linux/fs.h  | 1 +
> > >  2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> > > index 3059a9394c2d..e0ff1f6ac8f1 100644
> > > --- a/fs/proc_namespace.c
> > > +++ b/fs/proc_namespace.c
> > > @@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
> > >  		{ SB_DIRSYNC, ",dirsync" },
> > >  		{ SB_MANDLOCK, ",mand" },
> > >  		{ SB_LAZYTIME, ",lazytime" },
> > > +		{ SB_INLINECRYPT, ",inlinecrypt" },
> > >  		{ 0, NULL }
> > >  	};
> > >  	const struct proc_fs_opts *fs_infop;
> > 
> > NACK.
> > 
> > SB_* flgs are for functionality enabled on the superblock, not for
> > indicating mount options that have been set by the user.
> 
> That's an interesting claim, given that most SB_* flags are for mount options.
> E.g.:
> 
> 	ro => SB_RDONLY
> 	nosuid => SB_NOSUID
> 	nodev => SB_NODEV
> 	noexec => SB_NOEXEC
> 	sync => SB_SYNCHRONOUS
> 	mand => SB_MANDLOCK
> 	noatime => SB_NOATIME
> 	nodiratime => SB_NODIRATIME
> 	lazytime => SB_LAZYTIME

Yes, they *reflect* options set by mount options, but this is all so
screwed up because the split of superblock functionality from the
mount option API (i.e. the MS_* flag introduction to avoid having
the superblock feature flags being directly defined by the userspace
mount API) was never followed through to properly separate the
implementation of *active superblock feature flags* from the *user
specified mount API flags*.

Yes, the UAPI definitions were separated, but the rest of the
interface wasn't and only works because of the "MS* flag exactly
equal to the SB* flag" hack that was used. So now people have no
idea when to use one or the other and we're repeatedly ending up
with broken mount option parsing because SB flags are used where MS
flags should be used and vice versa.

We've made a damn mess of mount options, and the fscontext stuff
hasn't fixed any of this ... mess. It's just stirred it around and so
nobody really knows what they are supposed to with mount options
right now.

> > If the mount options are directly parsed by the filesystem option
> > parser (as is done later in this patchset), then the mount option
> > setting should be emitted by the filesystem's ->show_options
> > function, not a generic function.
> > 
> > The option string must match what the filesystem defines, not
> > require separate per-filesystem and VFS definitions of the same
> > option that people could potentially get wrong (*cough* i_version vs
> > iversion *cough*)....
> 
> Are you objecting to the use of a SB_* flag, or just to showing the flag in
> show_sb_opts() instead of in the individual filesystems?  Note that the SB_*
> flag was requested by Christoph
> (https://lkml.kernel.org/r/20191031183217.GF23601@infradead.org/,
> https://lkml.kernel.org/r/20191031212103.GA6244@infradead.org/).  We originally
> used a function fscrypt_operations::inline_crypt_enabled() instead.

I'm objecting to the layering violations of having the filesystem
control the mount option parsing and superblock feature flags, but
then having no control over whether features that the filesystem has
indicated to the VFS it is using get emitted as a mount option or
not, and then having the VFS code unconditionally override the
functionality that the filesystem uses because it thinks it's a
mount option the filesystem supports....

For example, the current mess that has just come to light:
filesystems like btrfs and XFS v5 which set SB_IVERSION
unconditionally (i.e. it's not a mount option!) end up having that
functionality turned off on remount because the VFS conflates
MS_IVERSION with SB_IVERSION and so unconditionally clears
SB_IVERSION because MS_IVERSION is not set on remount by userspace.
Which userspace will never set be because the filesystems don't put
"iversion" in their mount option strings because -its not a mount
option- for those filesystems.

See the problem?  MS_IVERSION should be passed to the filesystem to
deal with as a mount option, not treated as a flag to directly
change SB_IVERSION in the superblock.

We really need to stop with the "global mount options for everyone
at the VFS" and instead pass everything down to the filesystems to
parse appropriately. Yes, provide generic helper functions to deal
with the common flags that everything supports, but the filesystems
should be masking off mount options they doesn't support changing
before changing their superblock feature support mask....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
