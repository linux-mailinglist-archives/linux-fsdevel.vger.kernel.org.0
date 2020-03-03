Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270D9177AE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 16:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgCCPrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 10:47:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgCCPrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:47:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023FeOd4074471;
        Tue, 3 Mar 2020 15:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=DSh98OXNZBqX/7goKk1PCpebVxNc2LpXfEH1oAZ3aKw=;
 b=KcB50+THWexCecBfE9eucUnuYXs+9SEEt3usQicDIV/tQqdly4opJByVWWBi4G7SQwJy
 2gPwazp5ciaSlD53jlb7xvtOO7dHE7gsvUzaZu99zZKHHN4EXwTpGfGAU3tPiAW0bIH2
 IixVW22FjQR7kRsuvq1XlCrSsxjeanQM/kRhW9QvU6kvvLAL/UGO8d6gkzwl9svHFAcl
 8HWe1+4i2Ar4so+DeXQvDpKkGdeZ9hSHeY7MzDJOtzh/yumqMm7T2zcNiateWA+lCXOm
 zyB3MP7ioTlgaopZQq5MT+1c+84MJEoB8LTJ9qWBor0Y69qCouxhSE1QQsVswjp1HT4I VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yffcug7g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 15:47:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023Fic17027448;
        Tue, 3 Mar 2020 15:47:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yg1p4qe2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 15:47:17 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 023FlC8k031965;
        Tue, 3 Mar 2020 15:47:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 07:47:12 -0800
Date:   Tue, 3 Mar 2020 07:47:09 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
Message-ID: <20200303154709.GB8037@magnolia>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <8bbd53bd719d5ccfecafcce93f2bf1d7955a44af.1582880246.git.riteshh@linux.ibm.com>
 <20200228152524.GE8036@magnolia>
 <20200302085840.A41E3A4053@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302085840.A41E3A4053@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 02:28:39PM +0530, Ritesh Harjani wrote:
> 
> 
> On 2/28/20 8:55 PM, Darrick J. Wong wrote:
> > On Fri, Feb 28, 2020 at 02:56:56PM +0530, Ritesh Harjani wrote:
> > > ext4_iomap_begin is already implemented which provides ext4_map_blocks,
> > > so just move the API from generic_block_bmap to iomap_bmap for iomap
> > > conversion.
> > > 
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > ---
> > >   fs/ext4/inode.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 6cf3b969dc86..81fccbae0aea 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -3214,7 +3214,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
> > >   			return 0;
> > >   	}
> > > -	return generic_block_bmap(mapping, block, ext4_get_block);
> > > +	return iomap_bmap(mapping, block, &ext4_iomap_ops);
> > 
> > /me notes that iomap_bmap will filemap_write_and_wait for you, so one
> > could optimize ext4_bmap to avoid the double-flush by moving the
> > filemap_write_and_wait at the top of the function into the JDATA state
> > clearing block.
> 
> IIUC, delalloc and data=journal mode are both mutually exclusive.
> So we could get rid of calling filemap_write_and_wait() all together
> from ext4_bmap().
> And as you pointed filemap_write_and_wait() is called by default in
> iomap_bmap which should cover for delalloc case.
> 
> 
> @Jan/Darrick,
> Could you check if the attached patch looks good. If yes then
> will add your Reviewed-by and send a v6.
> 
> Thanks for the review!!
> 
> -ritesh
> 
> 

> From 93f560d9a483b4f389056e543012d0941734a8f4 Mon Sep 17 00:00:00 2001
> From: Ritesh Harjani <riteshh@linux.ibm.com>
> Date: Tue, 20 Aug 2019 18:36:33 +0530
> Subject: [PATCH 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
> 
> ext4_iomap_begin is already implemented which provides ext4_map_blocks,
> so just move the API from generic_block_bmap to iomap_bmap for iomap
> conversion.
> 
> Also no need to call for filemap_write_and_wait() any more in ext4_bmap
> since data=journal mode anyway doesn't support delalloc and for all other
> cases iomap_bmap() anyway calls the same function, so no need for doing
> it twice.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Hmmm.  I don't recall how jdata actually works, but I get the impression
here that we're trying to flush dirty data out to the journal and then
out to disk, and then drop the JDATA state from the inode.  This
mechanism exists (I guess?) so that dirty file pages get checkpointed
out of jbd2 back into the filesystem so that bmap() returns meaningful
results to lilo.

This makes me wonder if you still need the filemap_write_and_wait in the
JDATA case because otherwise the journal flush won't have the effect of
writing all the dirty pagecache back to the filesystem?  OTOH I suppose
the implicit write-and-wait call after we clear JDATA will not be
writing to the journal.

Even more weirdly, the FIEMAP code doesn't drop JDATA at all...?

--D

> ---
>  fs/ext4/inode.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6cf3b969dc86..fac8adbbb3f6 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3174,16 +3174,6 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>  	if (ext4_has_inline_data(inode))
>  		return 0;
>  
> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
> -			test_opt(inode->i_sb, DELALLOC)) {
> -		/*
> -		 * With delalloc we want to sync the file
> -		 * so that we can make sure we allocate
> -		 * blocks for file
> -		 */
> -		filemap_write_and_wait(mapping);
> -	}
> -
>  	if (EXT4_JOURNAL(inode) &&
>  	    ext4_test_inode_state(inode, EXT4_STATE_JDATA)) {
>  		/*
> @@ -3214,7 +3204,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>  			return 0;
>  	}
>  
> -	return generic_block_bmap(mapping, block, ext4_get_block);
> +	return iomap_bmap(mapping, block, &ext4_iomap_ops);
>  }
>  
>  static int ext4_readpage(struct file *file, struct page *page)
> -- 
> 2.21.0
> 

