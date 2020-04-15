Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE07B1AAC64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414974AbgDOPzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 11:55:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59571 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1414948AbgDOPzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:55:47 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03FFtPQK002015
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 11:55:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4E92242013D; Wed, 15 Apr 2020 11:55:25 -0400 (EDT)
Date:   Wed, 15 Apr 2020 11:55:25 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200415155525.GI90651@mit.edu>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-3-ira.weiny@intel.com>
 <20200415120002.GE6126@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415120002.GE6126@quack2.suse.cz>
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

Tes, the WARN_ON_ONCE isn't appropriate here.  We should also disallow
setting the DAX flag if the inode has the verity flag set already.

And if we need to decide what to if the file system is mounted with
"-o dax=always" and the verity file system feature is enabled.  We
could either (a) reject the mount with if the mount option is given
and the file system can have verity files, or (b) make "-o dax=always"
mean "-o dax=mostly_always" and treat verity files as not using dax
even when dax=always is selected.

Also, in theory, we *could* support dax and verity files, but
verifying the crypto checksums of all of the pages when the file is
first accessed, and then marking that in a flag in the in-inode flag.
Or we could have a per-page flag stored somewhere that indicates that
the page has been verified, so that we can on-demand verify the
integrity of the page.  Given that verity files are read-only, the
main reason why someone might want to use dax && verity would be to
reduce page cache overhead of system files; if executing out of dax
pages doesn't have significant performance impacts, this might be
something which might be a nice-to-have.  I don't think we need to
worry about this for now; if there are use cases where mobile devices
want to use dax && verity, we can let them figure out how to make it
work.  I'm just pointing out that it's not really a completely insane
combination.

Cheers,

						- Ted
