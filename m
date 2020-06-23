Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B132046DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 03:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbgFWBu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 21:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730252AbgFWBu2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:50:28 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068C1206C0;
        Tue, 23 Jun 2020 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592877027;
        bh=8UutbfDGamPe3ZKaMOvbwFpQtYMQKVsrskqNhLKbQSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPGyXP4X1RlkThfcxkpXUATCoiH0+DsJrly4/RuW2wok260LAgXM7cYiBpCsUOvX5
         qRYyXyKcdoVz93S0J3ZNAdTkxmwvdJKjceCDadcD17NKWXZVDzPm177haDzaRhuyzm
         fNM2cz11JMR2/Fama08LYSGi8lA1DVei/rrd2G/I=
Date:   Mon, 22 Jun 2020 18:50:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Satya Tangirala <satyat@google.com>
Subject: Re: [f2fs-dev] [PATCH 1/4] fs: introduce SB_INLINECRYPT
Message-ID: <20200623015017.GA844@sol.localdomain>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-2-satyat@google.com>
 <20200618011912.GA2040@dread.disaster.area>
 <20200618031935.GE1138@sol.localdomain>
 <20200623004636.GE2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623004636.GE2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Tue, Jun 23, 2020 at 10:46:36AM +1000, Dave Chinner wrote:
> On Wed, Jun 17, 2020 at 08:19:35PM -0700, Eric Biggers wrote:
> > On Thu, Jun 18, 2020 at 11:19:12AM +1000, Dave Chinner wrote:
> > > On Wed, Jun 17, 2020 at 07:57:29AM +0000, Satya Tangirala wrote:
> > > > Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
> > > > blk-crypto for file content en/decryption. This flag maps to the
> > > > '-o inlinecrypt' mount option which multiple filesystems will implement,
> > > > and code in fs/crypto/ needs to be able to check for this mount option
> > > > in a filesystem-independent way.
> > > > 
> > > > Signed-off-by: Satya Tangirala <satyat@google.com>
> > > > ---
> > > >  fs/proc_namespace.c | 1 +
> > > >  include/linux/fs.h  | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > > 
> > > > diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> > > > index 3059a9394c2d..e0ff1f6ac8f1 100644
> > > > --- a/fs/proc_namespace.c
> > > > +++ b/fs/proc_namespace.c
> > > > @@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
> > > >  		{ SB_DIRSYNC, ",dirsync" },
> > > >  		{ SB_MANDLOCK, ",mand" },
> > > >  		{ SB_LAZYTIME, ",lazytime" },
> > > > +		{ SB_INLINECRYPT, ",inlinecrypt" },
> > > >  		{ 0, NULL }
> > > >  	};
> > > >  	const struct proc_fs_opts *fs_infop;
> > > 
> > > NACK.
> > > 
> > > SB_* flgs are for functionality enabled on the superblock, not for
> > > indicating mount options that have been set by the user.
> > 
> > That's an interesting claim, given that most SB_* flags are for mount options.
> > E.g.:
> > 
> > 	ro => SB_RDONLY
> > 	nosuid => SB_NOSUID
> > 	nodev => SB_NODEV
> > 	noexec => SB_NOEXEC
> > 	sync => SB_SYNCHRONOUS
> > 	mand => SB_MANDLOCK
> > 	noatime => SB_NOATIME
> > 	nodiratime => SB_NODIRATIME
> > 	lazytime => SB_LAZYTIME
> 
> Yes, they *reflect* options set by mount options, but this is all so
> screwed up because the split of superblock functionality from the
> mount option API (i.e. the MS_* flag introduction to avoid having
> the superblock feature flags being directly defined by the userspace
> mount API) was never followed through to properly separate the
> implementation of *active superblock feature flags* from the *user
> specified mount API flags*.
> 
> Yes, the UAPI definitions were separated, but the rest of the
> interface wasn't and only works because of the "MS* flag exactly
> equal to the SB* flag" hack that was used. So now people have no
> idea when to use one or the other and we're repeatedly ending up
> with broken mount option parsing because SB flags are used where MS
> flags should be used and vice versa.
> 
> We've made a damn mess of mount options, and the fscontext stuff
> hasn't fixed any of this ... mess. It's just stirred it around and so
> nobody really knows what they are supposed to with mount options
> right now.
> 
> > > If the mount options are directly parsed by the filesystem option
> > > parser (as is done later in this patchset), then the mount option
> > > setting should be emitted by the filesystem's ->show_options
> > > function, not a generic function.
> > > 
> > > The option string must match what the filesystem defines, not
> > > require separate per-filesystem and VFS definitions of the same
> > > option that people could potentially get wrong (*cough* i_version vs
> > > iversion *cough*)....
> > 
> > Are you objecting to the use of a SB_* flag, or just to showing the flag in
> > show_sb_opts() instead of in the individual filesystems?  Note that the SB_*
> > flag was requested by Christoph
> > (https://lkml.kernel.org/r/20191031183217.GF23601@infradead.org/,
> > https://lkml.kernel.org/r/20191031212103.GA6244@infradead.org/).  We originally
> > used a function fscrypt_operations::inline_crypt_enabled() instead.
> 
> I'm objecting to the layering violations of having the filesystem
> control the mount option parsing and superblock feature flags, but
> then having no control over whether features that the filesystem has
> indicated to the VFS it is using get emitted as a mount option or
> not, and then having the VFS code unconditionally override the
> functionality that the filesystem uses because it thinks it's a
> mount option the filesystem supports....
> 
> For example, the current mess that has just come to light:
> filesystems like btrfs and XFS v5 which set SB_IVERSION
> unconditionally (i.e. it's not a mount option!) end up having that
> functionality turned off on remount because the VFS conflates
> MS_IVERSION with SB_IVERSION and so unconditionally clears
> SB_IVERSION because MS_IVERSION is not set on remount by userspace.
> Which userspace will never set be because the filesystems don't put
> "iversion" in their mount option strings because -its not a mount
> option- for those filesystems.
> 
> See the problem?  MS_IVERSION should be passed to the filesystem to
> deal with as a mount option, not treated as a flag to directly
> change SB_IVERSION in the superblock.
> 
> We really need to stop with the "global mount options for everyone
> at the VFS" and instead pass everything down to the filesystems to
> parse appropriately. Yes, provide generic helper functions to deal
> with the common flags that everything supports, but the filesystems
> should be masking off mount options they doesn't support changing
> before changing their superblock feature support mask....

I think the MS_* flags are best saved for mount options that are applicable to
many/most filesystems and are mostly/entirely implementable at the VFS level.
I don't think "inlinecrypt" qualifies, since while it will be shared by the
block device-based filesystems that support fscrypt, that is only 2 filesystems
currently; and while some of the code needed to implement it is shared in
fs/crypto/, there are still substantial filesystem-specific hooks needed.

Hence this patchset intentionally does *not* allocate an MS_INLINECRYPT flag.

I believe that already addresses half of your concern, as it means
SB_INLINECRYPT can only be set/cleared by the filesystem itself, not by the VFS.
(But the commit message could use an explanation of this.)

The other half would be addressed by the following change, right?

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index faf9e5eaa029..954b132ae36b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2362,6 +2362,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 
 	fscrypt_show_test_dummy_encryption(seq, sep, sb);
 
+	if (sb->s_flags & SB_INLINECRYPT)
+		SEQ_OPTS_PUTS("inlinecrypt");
+
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3621969b2665..23c49c313fb6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1599,6 +1599,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 
 	fscrypt_show_test_dummy_encryption(seq, ',', sbi->sb);
 
+	if (sbi->sb->s_flags & SB_INLINECRYPT)
+		seq_puts(seq, ",inlinecrypt");
+
 	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_DEFAULT)
 		seq_printf(seq, ",alloc_mode=%s", "default");
 	else if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index e0ff1f6ac8f1..3059a9394c2d 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,7 +49,6 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
-		{ SB_INLINECRYPT, ",inlinecrypt" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_opts *fs_infop;
