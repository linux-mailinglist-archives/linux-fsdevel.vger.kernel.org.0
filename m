Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C339206932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 02:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbgFXAzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 20:55:14 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:43045 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387764AbgFXAzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:55:14 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 3A00CD7B989;
        Wed, 24 Jun 2020 10:55:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jntgz-0001dO-9M; Wed, 24 Jun 2020 10:55:09 +1000
Date:   Wed, 24 Jun 2020 10:55:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Satya Tangirala <satyat@google.com>
Subject: Re: [f2fs-dev] [PATCH 1/4] fs: introduce SB_INLINECRYPT
Message-ID: <20200624005509.GA5369@dread.disaster.area>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-2-satyat@google.com>
 <20200618011912.GA2040@dread.disaster.area>
 <20200618031935.GE1138@sol.localdomain>
 <20200623004636.GE2040@dread.disaster.area>
 <20200623015017.GA844@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623015017.GA844@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
        a=7-415B0cAAAA:8 a=_JHsV_7MbDpF1hl6ON4A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 06:50:17PM -0700, Eric Biggers wrote:
> On Tue, Jun 23, 2020 at 10:46:36AM +1000, Dave Chinner wrote:
> > On Wed, Jun 17, 2020 at 08:19:35PM -0700, Eric Biggers wrote:
> > > Are you objecting to the use of a SB_* flag, or just to showing the flag in
> > > show_sb_opts() instead of in the individual filesystems?  Note that the SB_*
> > > flag was requested by Christoph
> > > (https://lkml.kernel.org/r/20191031183217.GF23601@infradead.org/,
> > > https://lkml.kernel.org/r/20191031212103.GA6244@infradead.org/).  We originally
> > > used a function fscrypt_operations::inline_crypt_enabled() instead.
> > 
> > I'm objecting to the layering violations of having the filesystem
> > control the mount option parsing and superblock feature flags, but
> > then having no control over whether features that the filesystem has
> > indicated to the VFS it is using get emitted as a mount option or
> > not, and then having the VFS code unconditionally override the
> > functionality that the filesystem uses because it thinks it's a
> > mount option the filesystem supports....
> > 
> > For example, the current mess that has just come to light:
> > filesystems like btrfs and XFS v5 which set SB_IVERSION
> > unconditionally (i.e. it's not a mount option!) end up having that
> > functionality turned off on remount because the VFS conflates
> > MS_IVERSION with SB_IVERSION and so unconditionally clears
> > SB_IVERSION because MS_IVERSION is not set on remount by userspace.
> > Which userspace will never set be because the filesystems don't put
> > "iversion" in their mount option strings because -its not a mount
> > option- for those filesystems.
> > 
> > See the problem?  MS_IVERSION should be passed to the filesystem to
> > deal with as a mount option, not treated as a flag to directly
> > change SB_IVERSION in the superblock.
> > 
> > We really need to stop with the "global mount options for everyone
> > at the VFS" and instead pass everything down to the filesystems to
> > parse appropriately. Yes, provide generic helper functions to deal
> > with the common flags that everything supports, but the filesystems
> > should be masking off mount options they doesn't support changing
> > before changing their superblock feature support mask....
> 
> I think the MS_* flags are best saved for mount options that are applicable to
> many/most filesystems and are mostly/entirely implementable at the VFS level.

That's the theory, but so far it's caused nothing but pain.

In reality, I think ithe only sane way forward if to stop mount
option parsing in userspace (i.e. no new MS_* flags) for any new
functionality as it only leads to future pain. i.e. all new mount
options should be parsed entirely in the kernel by the filesystem
parsing code....

> I don't think "inlinecrypt" qualifies, since while it will be shared by the
> block device-based filesystems that support fscrypt, that is only 2 filesystems
> currently; and while some of the code needed to implement it is shared in
> fs/crypto/, there are still substantial filesystem-specific hooks needed.

Right. I wasn't suggesting this patchset should use an MS_ flag -
it was pointing out the problem with the VFS code using SB_ flags to
indicate enabled filesystem functionality unconditionally as a mount
option that can be changed by userspace.

> Hence this patchset intentionally does *not* allocate an MS_INLINECRYPT flag.
> 
> I believe that already addresses half of your concern, as it means
> SB_INLINECRYPT can only be set/cleared by the filesystem itself, not by the VFS.
> (But the commit message could use an explanation of this.)
> 
> The other half would be addressed by the following change, right?

Yes, it does. Thanks, Eric!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
