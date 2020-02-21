Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E432A166CAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 03:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgBUCHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 21:07:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:47210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgBUCHB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:07:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 44C7EAE89;
        Fri, 21 Feb 2020 02:06:59 +0000 (UTC)
Date:   Thu, 20 Feb 2020 20:06:53 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200221020653.ontjbxhorjymsbqx@fiona>
References: <20200220152355.5ticlkptc7kwrifz@fiona>
 <20200220174255.GA24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220174255.GA24185@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  9:42 20/02, Matthew Wilcox wrote:
> On Thu, Feb 20, 2020 at 09:23:55AM -0600, Goldwyn Rodrigues wrote:
> > In case of a block device error, written parameter in iomap_end()
> > is zero as opposed to the amount of submitted I/O.
> > Filesystems such as btrfs need to account for the I/O in ordered
> > extents, even if it resulted in an error. Having (incomplete)
> > submitted bytes in written gives the filesystem the amount of data
> > which has been submitted before the error occurred, and the
> > filesystem code can choose how to use it.
> > 
> > The final returned error for iomap_dio_rw() is set by
> > iomap_dio_complete().
> > 
> > Partial writes in direct I/O are considered an error. So,
> > ->iomap_end() using written == 0 as error must be changed
> > to written < length. In this case, ext4 is the only user.
> 
> I really had a hard time understanding this.  I think what you meant
> was:
> 
> Currently, I/Os that complete with an error indicate this by passing
> written == 0 to the iomap_end function.  However, btrfs needs to know how
> many bytes were written for its own accounting.  Change the convention
> to pass the number of bytes which were actually written, and change the
> only user to check for a short write instead of a zero length write.

Yes, thats right.  I was trying to cover base from the previous patch
and made a mess of it all. Thanks..


> 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/ext4/inode.c      | 2 +-
> >  fs/iomap/direct-io.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index e60aca791d3f..e50e7414351a 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3475,7 +3475,7 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> >  	 * the I/O. Any blocks that may have been allocated in preparation for
> >  	 * the direct I/O will be reused during buffered I/O.
> >  	 */
> > -	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
> > +	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written < length)
> >  		return -ENOTBLK;
> >  
> >  	return 0;
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 41c1e7c20a1f..01865db1bd09 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -264,7 +264,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		size_t n;
> >  		if (dio->error) {
> >  			iov_iter_revert(dio->submit.iter, copied);
> > -			copied = ret = 0;
> > +			ret = 0;
> >  			goto out;
> >  		}
> >  
> > -- 
> > 2.25.0
> > 

-- 
Goldwyn
