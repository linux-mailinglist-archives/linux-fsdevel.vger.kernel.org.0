Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D95D1A8BB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 21:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505332AbgDNT60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 15:58:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:50661 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731053AbgDNT6X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:58:23 -0400
IronPort-SDR: zG49AjFpBKZzOYozt6qw0qRxLrAwTeHJRkf5oMZ3sKXXW0zQ8laTZxP00sdnlAfm5BzLZoOgpH
 UpofhJOL1Qbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 12:58:21 -0700
IronPort-SDR: luUCkfmnkOthQB7k3FD7/z/f2Fe1nIR7IEbxbAwxqumnSiD6m4Mt1g/3ZUThB9XL6JznlC7Edb
 HDHa/uV1OXMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="454674819"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2020 12:58:21 -0700
Date:   Tue, 14 Apr 2020 12:58:21 -0700
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
Message-ID: <20200414195820.GE1853609@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-10-ira.weiny@intel.com>
 <CAPcyv4g1gGWUuzVyOgOtkRTxzoSKOjVpAOmW-UDtmud9a3CUUA@mail.gmail.com>
 <20200414161509.GF6742@magnolia>
 <CAPcyv4hr+NKbpAU4UhKcmHfvDq1+GTM+y+K28XGbkDYBP=Kaag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hr+NKbpAU4UhKcmHfvDq1+GTM+y+K28XGbkDYBP=Kaag@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:04:57PM -0700, Dan Williams wrote:
> On Tue, Apr 14, 2020 at 9:15 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Mon, Apr 13, 2020 at 10:21:26PM -0700, Dan Williams wrote:
> > > On Sun, Apr 12, 2020 at 10:41 PM <ira.weiny@intel.com> wrote:
> > > >
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > >
> > > > Update the Usage section to reflect the new individual dax selection
> > > > functionality.
> > > >
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > >
> > > > ---
> > > > Changes from V6:
> > > >         Update to allow setting FS_XFLAG_DAX any time.
> > > >         Update with list of behaviors from Darrick
> > > >         https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> > > >
> > > > Changes from V5:
> > > >         Update to reflect the agreed upon semantics
> > > >         https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
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
> > > > +
> > > > +Enabling DAX on ext4
> > > > +--------------------
> > > > +
> > > > +When mounting the filesystem, use the "-o dax" option on the command line or
> > > > +add 'dax' to the options in /etc/fstab.
> > > > +
> > > > +
> > > > +Enabling DAX on xfs
> > > > +-------------------
> > > > +
> > > > +Summary
> > > > +-------
> > > > +
> > > > + 1. There exists an in-kernel access mode flag S_DAX that is set when
> > > > +    file accesses go directly to persistent memory, bypassing the page
> > > > +    cache.
> > >
> > > I had reserved some quibbling with this wording, but now that this is
> > > being proposed as documentation I'll let my quibbling fly. "dax" may
> > > imply, but does not require persistent memory nor does it necessarily
> > > "bypass page cache". For example on configurations that support dax,
> > > but turn off MAP_SYNC (like virtio-pmem), a software flush is
> > > required. Instead, if we're going to define "dax" here I'd prefer it
> > > be a #include of the man page definition that is careful (IIRC) to
> > > only talk about semantics and not backend implementation details. In
> > > other words, dax is to page-cache as direct-io is to page cache,
> > > effectively not there, but dig a bit deeper and you may find it.
> >
> > Uh, which manpage?  Are you talking about the MAP_SYNC documentation?
> 
> No, I was referring to the proposed wording for STATX_ATTR_DAX.
> There's no reason for this description to say anything divergent from
> that description.

Ok I think the best text would be to simply refer to the STATX_ATTR_DAX man
page here.  Something like:

<quote>
 1. There exists an in-kernel access mode flag S_DAX that is set when file
    accesses is enabled for 'DAX'.  Applications must call statx to discover
    the current S_DAX state (STATX_ATTR_DAX).  See the man page for statx for
    more details.
</quote>

Ira

