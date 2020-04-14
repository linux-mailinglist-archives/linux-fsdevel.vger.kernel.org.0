Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D401A8B7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 21:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgDNTum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 15:50:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:47138 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505188AbgDNTst (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:48:49 -0400
IronPort-SDR: Fzz8nA7FwzUXByu/1QJRb0mCQ7Hpm6ynkr/+OcfzwI3BgArq4mu9PG1tom98rkcvlb7l30Nujh
 EOrsKGlgQEVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 12:48:48 -0700
IronPort-SDR: /9PXD6UyYfnTEnbuhi6ZiIjqDVppnyJ2nPEU9AuDspmduyNhwdFw8pICveKs/c+tIj7vTxfy4A
 HF7rEguRJHCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="245504497"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2020 12:48:48 -0700
Date:   Tue, 14 Apr 2020 12:48:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V7 9/9] Documentation/dax: Update Usage section
Message-ID: <20200414194848.GD1853609@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-10-ira.weiny@intel.com>
 <20200413161912.GZ6742@magnolia>
 <20200414043821.GG1649878@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hfCnFTRsDv8Kviux7=2teu9Tdyc3HDjNJQpagG-JaM+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hfCnFTRsDv8Kviux7=2teu9Tdyc3HDjNJQpagG-JaM+Q@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:12:22PM -0700, Dan Williams wrote:
> On Mon, Apr 13, 2020 at 9:38 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Mon, Apr 13, 2020 at 09:19:12AM -0700, Darrick J. Wong wrote:
> > > On Sun, Apr 12, 2020 at 10:40:46PM -0700, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > >
> > > > Update the Usage section to reflect the new individual dax selection
> > > > functionality.
> > >
> > > Yum. :)
> > >
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > >
> > > > ---
> > > > Changes from V6:
> > > >     Update to allow setting FS_XFLAG_DAX any time.
> > > >     Update with list of behaviors from Darrick
> > > >     https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> > > >
> > > > Changes from V5:
> > > >     Update to reflect the agreed upon semantics
> > > >     https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > > > ---
> > > >  Documentation/filesystems/dax.txt | 166 +++++++++++++++++++++++++++++-
> > > >  1 file changed, 163 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> > > > index 679729442fd2..af14c1b330a9 100644
> > > > --- a/Documentation/filesystems/dax.txt
> > > > +++ b/Documentation/filesystems/dax.txt
> > > > @@ -17,11 +17,171 @@ For file mappings, the storage device is mapped directly into userspace.
> > > >  Usage
> > > >  -----
> > > >
> > > > -If you have a block device which supports DAX, you can make a filesystem
> > > > +If you have a block device which supports DAX, you can make a file system
> > > >  on it as usual.  The DAX code currently only supports files with a block
> > > >  size equal to your kernel's PAGE_SIZE, so you may need to specify a block
> > > > -size when creating the filesystem.  When mounting it, use the "-o dax"
> > > > -option on the command line or add 'dax' to the options in /etc/fstab.
> > > > +size when creating the file system.
> > > > +
> > > > +Currently 2 filesystems support DAX, ext4 and xfs.  Enabling DAX on them is
> > > > +different at this time.
> > >
> > > I thought ext2 supports DAX?
> >
> > Not that I know of?  Does it?
> 
> Yes. Seemed like a good idea at the time, but in retrospect...

Ah ok...   Is there an objection to leaving ext2 as a global mount option?
Updating the doc is easy enough.

Ira

> 
> In fairness I believe this was also an olive branch to XIP users that
> were transitioned to DAX, so they did not also need to transition
> filesystems.
