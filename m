Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291B71AB581
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 03:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbgDPB3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 21:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732522AbgDPB3E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:29:04 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CBC7208E0;
        Thu, 16 Apr 2020 01:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587000543;
        bh=hq/+bVXnleESn8mSlWiIeOiFdqP5VlQ1XkbPhFhBPAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7Apg3PrInj1bZ5S36DCxeG04p3aKJHJiJwrLO/6Ve1tvjwUnZziTJm8y1phI+4Gq
         qj09WXqwTPZmoyuQl/UvHjdW2KG4XibW7wv0YzFOJQw378Na5/IhOsJJS4CJTq+Shr
         P3ndXnQ/1SyJbLjFawUAT8sTOdLs7Go1HtB9nKKE=
Date:   Wed, 15 Apr 2020 18:29:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200416012901.GA816@sol.localdomain>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-3-ira.weiny@intel.com>
 <20200415120002.GE6126@quack2.suse.cz>
 <20200415191451.GA2305801@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415191451.GA2305801@iweiny-DESK2.sc.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:14:52PM -0700, Ira Weiny wrote:
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
> Ok.  I did not think this through but I did think about this.  I was following
> the code from the encryption side which issues a warning and was thinking that
> would be a good way to alert the user they are doing something wrong...
> 
> I think you are right about both of them but we also need to put something in
> the verity, dax, and ...  (I can't find a file in Documentation which talks
> about encryption right off) documentation files....  For verity something like.
> 
> <quote>
> Verity and DAX
> --------------
> 
> Verity and DAX are not compatible and attempts to set both of these flags on a
> file will fail.
> </quote>
> 
> And the same thing in the DAX doc?
> 
> And where would be appropriate for the encrypt doc?
> 

Documentation/filesystems/fscrypt.rst mentions that DAX isn't supported on
encrypted files, but it doesn't say what happens if someone tries to do it
anyway.  Feel free to improve the documentation.

- Eric
