Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65481AB65B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 05:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbgDPDsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 23:48:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:19725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbgDPDsM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:48:12 -0400
IronPort-SDR: /wZTq7bzQ0E2k8W/6XYNSgW1CO7wELK0a4a0VcxVCIN37lfF+DtwwWlY/1ZF2w4zwxoVHaQFTi
 otbtaWhvrEYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 20:48:09 -0700
IronPort-SDR: cGlxBQg4ApLsZNxgWwU23EqDS+zS9AKNnudf6RGW9EJiuVSZKIvfqcnZn9JXpx2LoQzprTKucW
 nOfLuM2iPAbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="299183864"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2020 20:48:10 -0700
Date:   Wed, 15 Apr 2020 20:48:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200416034809.GE2309605@iweiny-DESK2.sc.intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-3-ira.weiny@intel.com>
 <20200415120002.GE6126@quack2.suse.cz>
 <20200415191451.GA2305801@iweiny-DESK2.sc.intel.com>
 <20200416012901.GA816@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416012901.GA816@sol.localdomain>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:29:01PM -0700, Eric Biggers wrote:
> On Wed, Apr 15, 2020 at 12:14:52PM -0700, Ira Weiny wrote:
> > On Wed, Apr 15, 2020 at 02:00:02PM +0200, Jan Kara wrote:
> > > On Mon 13-04-20 21:00:24, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > Verity and DAX are incompatible.  Changing the DAX mode due to a verity
> > > > flag change is wrong without a corresponding address_space_operations
> > > > update.
> > > > 
> > > > Make the 2 options mutually exclusive by returning an error if DAX was
> > > > set first.
> > > > 
> > > > (Setting DAX is already disabled if Verity is set first.)
> > > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > ---
> > > >  fs/ext4/verity.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> > > > index dc5ec724d889..ce3f9a198d3b 100644
> > > > --- a/fs/ext4/verity.c
> > > > +++ b/fs/ext4/verity.c
> > > > @@ -113,6 +113,9 @@ static int ext4_begin_enable_verity(struct file *filp)
> > > >  	handle_t *handle;
> > > >  	int err;
> > > >  
> > > > +	if (WARN_ON_ONCE(IS_DAX(inode)))
> > > > +		return -EINVAL;
> > > > +
> > > 
> > > Hum, one question, is there a reason for WARN_ON_ONCE()? If I understand
> > > correctly, user could normally trigger this, couldn't he?
> > 
> > Ok.  I did not think this through but I did think about this.  I was following
> > the code from the encryption side which issues a warning and was thinking that
> > would be a good way to alert the user they are doing something wrong...
> > 
> > I think you are right about both of them but we also need to put something in
> > the verity, dax, and ...  (I can't find a file in Documentation which talks
> > about encryption right off) documentation files....  For verity something like.
> > 
> > <quote>
> > Verity and DAX
> > --------------
> > 
> > Verity and DAX are not compatible and attempts to set both of these flags on a
> > file will fail.
> > </quote>
> > 
> > And the same thing in the DAX doc?
> > 
> > And where would be appropriate for the encrypt doc?
> > 
> 
> Documentation/filesystems/fscrypt.rst mentions that DAX isn't supported on
> encrypted files, but it doesn't say what happens if someone tries to do it
> anyway.  Feel free to improve the documentation.

Thanks for pointing this out!

Ira

