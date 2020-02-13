Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F015CADB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgBMTCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:02:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:55974 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMTCU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:02:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 11:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; 
   d="scan'208";a="381198093"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2020 11:01:57 -0800
Date:   Thu, 13 Feb 2020 11:01:57 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
 <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
 <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:49:48PM -0500, Jeff Moyer wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > On Mon, Feb 10, 2020 at 10:15:47AM -0500, Jeff Moyer wrote:
> >> Hi, Ira,
> >> 
> >> Could you please include documentation patches as part of this series?
> >
> > I do have an update to the vfs.rst doc in
> >
> > 	fs: Add locking for a dynamic DAX state
> >
> > I'm happy to do more but was there something specific you would like to see?
> > Or documentation in xfs perhaps?
> 
> Sorry, I was referring to your statx man page addition.

Ah yea I guess I could include that as a patch.  I just wanted to get buy off
on the whole thing prior to setting documentation in.

> It would be
> nice if we could find a home for the information in your cover letter,
> too.  Right now, I'm not sure how application developers are supposed to
> figure out how to use the per-inode settings.

I'm not sure either.  But this is probably a good start:

https://www.kernel.org/doc/Documentation/filesystems/dax.txt

Something under the Usage section like:

diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
index 679729442fd2..1bab5d5d775b 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.txt
@@ -20,8 +20,18 @@ Usage
 If you have a block device which supports DAX, you can make a filesystem
 on it as usual.  The DAX code currently only supports files with a block
 size equal to your kernel's PAGE_SIZE, so you may need to specify a block
-size when creating the filesystem.  When mounting it, use the "-o dax"
-option on the command line or add 'dax' to the options in /etc/fstab.
+size when creating the filesystem.
+
+Files can then be enabled to use dax using the statx system call or an
+application using it like 'xfs_io'.  Directories can also be enabled for dax
+to have the file system automatically enable dax on all files within those
+directories.
+
+Alternately, when mounting it one can use the "-o dax" option on the command
+line or add 'dax' to the options in /etc/fstab to globaly override all files to
+use dax on that filesystem.  Using the "-o dax" does not change the state of
+individual files so remounting without "-o dax" will revert them to the state
+saved in the filesystem meta data.
 
 
 Implementation Tips for Block Driver Writers

> 
> If I read your cover letter correctly, the mount option overrides any
> on-disk setting.  Is that right?

Yes

> Given that we document the dax mount
> option as "the way to get dax," it may be a good idea to allow for a
> user to selectively disable dax, even when -o dax is specified.  Is that
> possible?

Not with this patch set.  And I'm not sure how that would work.  The idea was
that -o dax was simply an override for users who were used to having their
entire FS be dax.  We wanted to depreciate the use of "-o dax" in general.  The
individual settings are saved so I don't think it makes sense to ignore the -o
dax in favor of those settings.  Basically that would IMO make the -o dax
useless.

Ira

