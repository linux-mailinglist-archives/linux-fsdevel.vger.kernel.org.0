Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA1245222
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Aug 2020 23:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgHOVnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 17:43:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:54986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgHOVns (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:43:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A01C2B17A;
        Sat, 15 Aug 2020 19:08:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FCC0DA6EF; Sat, 15 Aug 2020 21:06:42 +0200 (CEST)
Date:   Sat, 15 Aug 2020 21:06:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Message-ID: <20200815190642.GZ2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:29:01PM +0000, Konstantin Komarov wrote:
> This patch adds NTFS Read-Write driver to fs/ntfs3.
> 
> Having decades of expertise in commercial file systems development and huge
> test coverage, we at Paragon Software GmbH want to make our contribution to
> the Open Source Community by providing implementation of NTFS Read-Write
> driver for the Linux Kernel.
> 
> This is fully functional NTFS Read-Write driver. Current version works with
> NTFS(including v3.1) normal/compressed/sparse files and supports journal replaying.
> 
> We plan to support this version after the codebase once merged, and add new
> features and fix bugs. For example, full journaling support over JBD will be
> added in later updates.
> 
> The patch is too big to handle it within an e-mail body, so it is available to download 
> on our server: https://dl.paragon-software.com/ntfs3/ntfs3.patch

The way you submit the driver does not meet significant number of
requirements documented in https://www.kernel.org/doc/html/latest/process/submitting-patches.html .
so this may lead to ignoring the patch as this puts the burden on the
kernel community to make the merge somehow happen. I don't see kernel
involvement from Paragon, so let me build our half of the bridge.

As I reckon, there is interest to have NTFS implementation that's better
than the existing FUSE based support by NTFS-3G (namely performance), so
let me propose something that might lead to merging the patch
eventually.

1. check existing support in kernel

There is fs/ntfs with read-only support from Tuxera, last change in the
git tree is 3 years ago. The driver lacks read-write support so there's
not 100% functionality duplication but there's still driver for the same
filesystem.

I don't know what's the feature parity, how much the in-kernel driver is
used (or what are business relations of Tuxera and Paragon), compared to
the FUSE-based driver, but ideally there's just one NTFS driver in linux
kernel.

The question I'd ask:

- what are users of current fs/ntfs driver going to lose, if the driver
  is going to be completely replaced by your driver

  If the answer is 'nothing' then, the straightfowrad plan is to just
  replace it. Otherwise, we'll have to figure that out.

2. split the patch

One patch of 27k lines of code is way too much to anybody to look at.

As an example, what worked for the recent EXFAT support, send each new
file as a patch.  This will pass the mailinglist size filters and keep
the patches logically separated, so eg. there are smaller patches
implementing interaction with VFS (on the inode or directory level) and
leaving out the other internal stuff of the filesystem.

I'm counting about 20 files, that's acceptable. The last patch, or maybe
a separate patch, adds the actual build and config-time support.

The situation is a bit more complicated as there's an existing driver
and I don't see a clear way how to do the transition from 2
implementations (one intermediate) to just one in the final state. We
have that already with the old VFAT and new EXFAT drivers, and it's
solved on the module level. Just one can be loaded (AFAIK). The same
could be done here but it puts some burden on users to know what driver
to load to get the expected set of features.

3. determine support status

You state intentions to work on the driver and there's a new entry in
MAINTAINERS file with 'Supported', so that's a good sign that it's not
just one-time dump of code. Fixing bugs or adding functionality is
expected.

4. development git tree

Once the filesystem is merged, you'd be getting mails from people
running eg. static checkers, build tests, sending cleanups or other
tree-wide changes.  The entry in MAINTAINER file does not point to any
git tree, so that's not clear to me what's the expected way to get the
fixes to Linus' tree or where are people supposed to look for 'is this
fixed already'.

There's maybe more I missed, but hopefully HTH.
d.
