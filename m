Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7066B1AB164
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441754AbgDOTO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 15:14:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:15254 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441746AbgDOTOy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:14:54 -0400
IronPort-SDR: uNPov8B7QUKj5K6qUWagJEFWgCfzzN2VwPe3mG+Yj7kkwtHjqFPA09MxLMuqL8Ghn3jsre/6Do
 TRsIVMabYTQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:14:52 -0700
IronPort-SDR: 7PTC/XR0QNy6eWAG1dmEGZdP686/BpC1G/stOZBy1TC/E3yJp34kdFRlNT/1KE0DEUGhlHDlGi
 aPIm544g1tvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="455008505"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga006.fm.intel.com with ESMTP; 15 Apr 2020 12:14:52 -0700
Date:   Wed, 15 Apr 2020 12:14:52 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200415191451.GA2305801@iweiny-DESK2.sc.intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-3-ira.weiny@intel.com>
 <20200415120002.GE6126@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415120002.GE6126@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:00:02PM +0200, Jan Kara wrote:
> On Mon 13-04-20 21:00:24, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Verity and DAX are incompatible.  Changing the DAX mode due to a verity
> > flag change is wrong without a corresponding address_space_operations
> > update.
> > 
> > Make the 2 options mutually exclusive by returning an error if DAX was
> > set first.
> > 
> > (Setting DAX is already disabled if Verity is set first.)
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/ext4/verity.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> > index dc5ec724d889..ce3f9a198d3b 100644
> > --- a/fs/ext4/verity.c
> > +++ b/fs/ext4/verity.c
> > @@ -113,6 +113,9 @@ static int ext4_begin_enable_verity(struct file *filp)
> >  	handle_t *handle;
> >  	int err;
> >  
> > +	if (WARN_ON_ONCE(IS_DAX(inode)))
> > +		return -EINVAL;
> > +
> 
> Hum, one question, is there a reason for WARN_ON_ONCE()? If I understand
> correctly, user could normally trigger this, couldn't he?

Ok.  I did not think this through but I did think about this.  I was following
the code from the encryption side which issues a warning and was thinking that
would be a good way to alert the user they are doing something wrong...

I think you are right about both of them but we also need to put something in
the verity, dax, and ...  (I can't find a file in Documentation which talks
about encryption right off) documentation files....  For verity something like.

<quote>
Verity and DAX
--------------

Verity and DAX are not compatible and attempts to set both of these flags on a
file will fail.
</quote>

And the same thing in the DAX doc?

And where would be appropriate for the encrypt doc?

Ira

> 
> 								Honza
> 
> >  	if (ext4_verity_in_progress(inode))
> >  		return -EBUSY;
> >  
> > -- 
> > 2.25.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
