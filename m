Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BADD1AB184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 21:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506496AbgDOTVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 15:21:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:32108 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506488AbgDOTVM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:21:12 -0400
IronPort-SDR: NPd6gfBajyvyHr7RyOBS3A6EK29v6qBNXabp9CQcdvxcamcfgSi5tDQ/cXRLF6pEnp/ZWjPhYh
 oZSAHaHsyTdA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:21:10 -0700
IronPort-SDR: N///KnG0ylC98jG1+jptn3y3oYTzEBzWF1y1Rr80K1+fJ5GuXL1I722wgIOELCAeAVvNXRBJT8
 KwGRnHjw3S4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="455010042"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga006.fm.intel.com with ESMTP; 15 Apr 2020 12:21:10 -0700
Date:   Wed, 15 Apr 2020 12:21:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200415192110.GB2305801@iweiny-DESK2.sc.intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-3-ira.weiny@intel.com>
 <20200415120002.GE6126@quack2.suse.cz>
 <20200415155525.GI90651@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415155525.GI90651@mit.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:55:25AM -0400, Theodore Y. Ts'o wrote:
> On Wed, Apr 15, 2020 at 02:00:02PM +0200, Jan Kara wrote:
> > On Mon 13-04-20 21:00:24, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Verity and DAX are incompatible.  Changing the DAX mode due to a verity
> > > flag change is wrong without a corresponding address_space_operations
> > > update.
> > > 
> > > Make the 2 options mutually exclusive by returning an error if DAX was
> > > set first.
> > > 
> > > (Setting DAX is already disabled if Verity is set first.)
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  fs/ext4/verity.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> > > index dc5ec724d889..ce3f9a198d3b 100644
> > > --- a/fs/ext4/verity.c
> > > +++ b/fs/ext4/verity.c
> > > @@ -113,6 +113,9 @@ static int ext4_begin_enable_verity(struct file *filp)
> > >  	handle_t *handle;
> > >  	int err;
> > >  
> > > +	if (WARN_ON_ONCE(IS_DAX(inode)))
> > > +		return -EINVAL;
> > > +
> > 
> > Hum, one question, is there a reason for WARN_ON_ONCE()? If I understand
> > correctly, user could normally trigger this, couldn't he?
> 
> Tes, the WARN_ON_ONCE isn't appropriate here.  We should also disallow
> setting the DAX flag if the inode has the verity flag set already.

This is taken care of and is part of ext4_enable_dax() after this series.

> 
> And if we need to decide what to if the file system is mounted with
> "-o dax=always" and the verity file system feature is enabled.  We
> could either (a) reject the mount with if the mount option is given
> and the file system can have verity files, or (b) make "-o dax=always"
> mean "-o dax=mostly_always" and treat verity files as not using dax
> even when dax=always is selected.

The later is implemented in this series...  Not the most explicit thing.  :-(

> 
> Also, in theory, we *could* support dax and verity files, but
> verifying the crypto checksums of all of the pages when the file is
> first accessed, and then marking that in a flag in the in-inode flag.
> Or we could have a per-page flag stored somewhere that indicates that
> the page has been verified, so that we can on-demand verify the
> integrity of the page.  Given that verity files are read-only, the
> main reason why someone might want to use dax && verity would be to
> reduce page cache overhead of system files; if executing out of dax
> pages doesn't have significant performance impacts, this might be
> something which might be a nice-to-have.  I don't think we need to
> worry about this for now; if there are use cases where mobile devices
> want to use dax && verity, we can let them figure out how to make it
> work.  I'm just pointing out that it's not really a completely insane
> combination.

Fair enough.  The main issue I need to correct here is to keep the 2 mutually
exclusive.  Which AFAICT is not true today.  This makes it so even without the
per-file enablement.

Ira

> 
> Cheers,
> 
> 						- Ted
