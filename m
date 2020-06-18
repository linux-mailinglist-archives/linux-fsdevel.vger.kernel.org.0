Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7421FE962
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 05:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgFRDTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 23:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgFRDTh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 23:19:37 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA20121655;
        Thu, 18 Jun 2020 03:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592450377;
        bh=tb8eihrC/QSLy1DAOwhuACWDwQVJ7zu3gsQrF0KN6W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a5nCURSUqqX0UUIMT3I1h+OR1Z2Lak9E0lXPKq4jwQjzuth5mpakN9gMWOWgW28le
         iBadBT/YYRVhbmROBTA8eyC4fXxTYGMBV6FXAkaHv0RPZTWMbFzIkffZxMoC7MZbDp
         pHdoOal6ViKvmNvO1MAYr0rTmaoWUMSAjjssWUlE=
Date:   Wed, 17 Jun 2020 20:19:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Satya Tangirala <satyat@google.com>, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] fs: introduce SB_INLINECRYPT
Message-ID: <20200618031935.GE1138@sol.localdomain>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-2-satyat@google.com>
 <20200618011912.GA2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618011912.GA2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:19:12AM +1000, Dave Chinner wrote:
> On Wed, Jun 17, 2020 at 07:57:29AM +0000, Satya Tangirala wrote:
> > Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
> > blk-crypto for file content en/decryption. This flag maps to the
> > '-o inlinecrypt' mount option which multiple filesystems will implement,
> > and code in fs/crypto/ needs to be able to check for this mount option
> > in a filesystem-independent way.
> > 
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> > ---
> >  fs/proc_namespace.c | 1 +
> >  include/linux/fs.h  | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> > index 3059a9394c2d..e0ff1f6ac8f1 100644
> > --- a/fs/proc_namespace.c
> > +++ b/fs/proc_namespace.c
> > @@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
> >  		{ SB_DIRSYNC, ",dirsync" },
> >  		{ SB_MANDLOCK, ",mand" },
> >  		{ SB_LAZYTIME, ",lazytime" },
> > +		{ SB_INLINECRYPT, ",inlinecrypt" },
> >  		{ 0, NULL }
> >  	};
> >  	const struct proc_fs_opts *fs_infop;
> 
> NACK.
> 
> SB_* flgs are for functionality enabled on the superblock, not for
> indicating mount options that have been set by the user.

That's an interesting claim, given that most SB_* flags are for mount options.
E.g.:

	ro => SB_RDONLY
	nosuid => SB_NOSUID
	nodev => SB_NODEV
	noexec => SB_NOEXEC
	sync => SB_SYNCHRONOUS
	mand => SB_MANDLOCK
	noatime => SB_NOATIME
	nodiratime => SB_NODIRATIME
	lazytime => SB_LAZYTIME

> 
> If the mount options are directly parsed by the filesystem option
> parser (as is done later in this patchset), then the mount option
> setting should be emitted by the filesystem's ->show_options
> function, not a generic function.
> 
> The option string must match what the filesystem defines, not
> require separate per-filesystem and VFS definitions of the same
> option that people could potentially get wrong (*cough* i_version vs
> iversion *cough*)....

Are you objecting to the use of a SB_* flag, or just to showing the flag in
show_sb_opts() instead of in the individual filesystems?  Note that the SB_*
flag was requested by Christoph
(https://lkml.kernel.org/r/20191031183217.GF23601@infradead.org/,
https://lkml.kernel.org/r/20191031212103.GA6244@infradead.org/).  We originally
used a function fscrypt_operations::inline_crypt_enabled() instead.

- Eric
