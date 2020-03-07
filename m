Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0CC17C9EF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 01:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCGAwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 19:52:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43580 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCGAwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:52:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0270i0Oc125345;
        Sat, 7 Mar 2020 00:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cGlP2xDtxWov+ixpsS87ko90M5TohN95IcRoc4L1azk=;
 b=XeUM6n3N899mRQZM2Zp7Yw37DzQhvnQDaiP+XjyjyXHCIJJmU41iY9RAuXbDqH2o3Mrc
 LnwXj0Ac0aKLmsEPDjm7FcmGmE5rrx0m2xsus/CDjaLIkz+mQfv60m5yhTwq5SOBdZ6Q
 ZoCv6bnPdAEs5ZGh7WB/eYXqdIIyxjfdiLoMUgTKyNuPIJzEntXoKUkPJJOYgPJhUQeq
 n6Ld411Q51vKLS2vw1ueOVU2uCqcf/AZn8Qz8DXpjtUInIYnoPw6s3kWPqq8XNjk3f7P
 M21QHLKF9mC+EiPW/h4X5wpF5RbLU/8gKcdI5AbDf8wB+I5pDGaGLtZvP7plNNIRhSWU eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ykgys4sjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 00:51:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0270gx2l047830;
        Sat, 7 Mar 2020 00:51:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ym0qutfk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 00:51:34 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0270pOGa013311;
        Sat, 7 Mar 2020 00:51:24 GMT
Received: from localhost (/10.159.149.78)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2020 16:51:24 -0800
Date:   Fri, 6 Mar 2020 16:51:22 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
Message-ID: <20200307005122.GI1752567@magnolia>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <8bbd53bd719d5ccfecafcce93f2bf1d7955a44af.1582880246.git.riteshh@linux.ibm.com>
 <20200228152524.GE8036@magnolia>
 <20200302085840.A41E3A4053@d06av23.portsmouth.uk.ibm.com>
 <20200303154709.GB8037@magnolia>
 <20200304124211.GC21048@quack2.suse.cz>
 <20200306174932.9D81D4C04E@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306174932.9D81D4C04E@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 11:19:31PM +0530, Ritesh Harjani wrote:
> 
> 
> On 3/4/20 6:12 PM, Jan Kara wrote:
> > On Tue 03-03-20 07:47:09, Darrick J. Wong wrote:
> > > On Mon, Mar 02, 2020 at 02:28:39PM +0530, Ritesh Harjani wrote:
> > > > 
> > > > 
> > > > On 2/28/20 8:55 PM, Darrick J. Wong wrote:
> > > > > On Fri, Feb 28, 2020 at 02:56:56PM +0530, Ritesh Harjani wrote:
> > > > > > ext4_iomap_begin is already implemented which provides ext4_map_blocks,
> > > > > > so just move the API from generic_block_bmap to iomap_bmap for iomap
> > > > > > conversion.
> > > > > > 
> > > > > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > > > ---
> > > > > >    fs/ext4/inode.c | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > > > index 6cf3b969dc86..81fccbae0aea 100644
> > > > > > --- a/fs/ext4/inode.c
> > > > > > +++ b/fs/ext4/inode.c
> > > > > > @@ -3214,7 +3214,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
> > > > > >    			return 0;
> > > > > >    	}
> > > > > > -	return generic_block_bmap(mapping, block, ext4_get_block);
> > > > > > +	return iomap_bmap(mapping, block, &ext4_iomap_ops);
> > > > > 
> > > > > /me notes that iomap_bmap will filemap_write_and_wait for you, so one
> > > > > could optimize ext4_bmap to avoid the double-flush by moving the
> > > > > filemap_write_and_wait at the top of the function into the JDATA state
> > > > > clearing block.
> > > > 
> > > > IIUC, delalloc and data=journal mode are both mutually exclusive.
> > > > So we could get rid of calling filemap_write_and_wait() all together
> > > > from ext4_bmap().
> > > > And as you pointed filemap_write_and_wait() is called by default in
> > > > iomap_bmap which should cover for delalloc case.
> > > > 
> > > > 
> > > > @Jan/Darrick,
> > > > Could you check if the attached patch looks good. If yes then
> > > > will add your Reviewed-by and send a v6.
> > > > 
> > > > Thanks for the review!!
> > > > 
> > > > -ritesh
> > > > 
> > > > 
> > > 
> > > >  From 93f560d9a483b4f389056e543012d0941734a8f4 Mon Sep 17 00:00:00 2001
> > > > From: Ritesh Harjani <riteshh@linux.ibm.com>
> > > > Date: Tue, 20 Aug 2019 18:36:33 +0530
> > > > Subject: [PATCH 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
> > > > 
> > > > ext4_iomap_begin is already implemented which provides ext4_map_blocks,
> > > > so just move the API from generic_block_bmap to iomap_bmap for iomap
> > > > conversion.
> > > > 
> > > > Also no need to call for filemap_write_and_wait() any more in ext4_bmap
> > > > since data=journal mode anyway doesn't support delalloc and for all other
> > > > cases iomap_bmap() anyway calls the same function, so no need for doing
> > > > it twice.
> > > > 
> > > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > 
> > > Hmmm.  I don't recall how jdata actually works, but I get the impression
> > > here that we're trying to flush dirty data out to the journal and then
> > > out to disk, and then drop the JDATA state from the inode.  This
> > > mechanism exists (I guess?) so that dirty file pages get checkpointed
> > > out of jbd2 back into the filesystem so that bmap() returns meaningful
> > > results to lilo.
> > 
> > Exactly. E.g. when we are journalling data, we fill hole through mmap, we will
> > have block allocated as unwritten and we need to write it out so that the
> > data gets to the journal and then do journal flush to get the data to disk
> 
> So in data=journal case in ext4_page_mkwrite the data buffer will also
> be marked as, to be journalled. So does jbd2_journal_flush() itself
> don't take care of writing back any dirty page cache before it commit
> that transaction? and after then checkpoint it?

Er... this sentence is a little garbled, but I think the answer you're
looking for is:

"Yes, writeback (i.e. filemap_write_and_wait) attaches the dirty blocks
to a journal transaction; then jbd2_journal_flush forces the transaction
data out to the on-disk journal; and it also checkpoints the journal so
that the dirty blocks are then written back into the filesystem."

> Sorry my knowledge about jbd2 is very naive.
> 
> > so that lilo can read it from the devices. So removing
> > filemap_write_and_wait() when journalling data is wrong.
> 
> Sure I understand this part. But was just curious on above query.
> Otherwise, IIUC, we will have to add
> filemap_write_and_wait() for JDATA case as well before calling
> for jbd2_journal_flush(). Will add this as a separate patch.

Well you could just move it...

bmap()
{
	/*
	 * In data=journal mode, we must checkpoint the journal to
	 * ensure that any dirty blocks in the journalare checkpointed
	 * to the location that we return to userspace.  Clear JDATA so
	 * that future writes will not be written through the journal.
	 */
	if (JDATA) {
		filemap_write_and_wait(...);
		clear JDATA
		jbd2_journal_flush(...);
	}

	return iomap_bmap(...);
}

(or did "Will add this as a separate patch" refer to fixing FIEMAP?)

--D

> 
> -ritesh
> 
> > 
> > > This makes me wonder if you still need the filemap_write_and_wait in the
> > > JDATA case because otherwise the journal flush won't have the effect of
> > > writing all the dirty pagecache back to the filesystem?  OTOH I suppose
> > > the implicit write-and-wait call after we clear JDATA will not be
> > > writing to the journal.
> > > 
> > > Even more weirdly, the FIEMAP code doesn't drop JDATA at all...?
> > 
> > Yeah, it should do that but that's only performance optimization so that we
> > bother with journal flushing only when someone uses block mapping call on
> > a file with journalled dirty data. So you can hardly notice the bug by
> > testing...
> > 
> > 								Honza
> > 
> 
