Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878EE797A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbjIGR2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbjIGR2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:28:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86181BC;
        Thu,  7 Sep 2023 10:28:11 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3877C0BA008822;
        Thu, 7 Sep 2023 07:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6wEW6rUbawVbn6n2wTq18oowgf0dFNp2rdpqNQSG58Q=;
 b=mDGYooDF1wkTeDhxXUtzjvZDYL34lj9xFhAPiGKWuDsxs0lA5UP/5geQEJ1iM3y0L9G1
 gRLwTXOAUiwqmMizSKUHZkGUP3Gghc5TFOlbooc90/GknPK3Vma2/eUEiIMHgieCCwpo
 ttISv69eNu7XJmnNlWJPwKisMDBipWDHt7WgEKmNdksYOPxlTYOYavxcKauBJARx7CPS
 XxSKIxRADaWGsZStmCwGfXP47wJ+D0+eN4xpdoIk7jhHpnTTfeep/E6QhGjEYYGaM80z
 5giDPcSY9hECjHtF1zbRzML7aN3R3s25qM8c753qhSnSAz+C9Qxg3xZux3ZKrfbE9uie aQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sy9wx0sda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 07:37:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 387507qp001691;
        Thu, 7 Sep 2023 07:37:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfct28bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 07:37:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3877b1lv61735256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 07:37:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C48F72004B;
        Thu,  7 Sep 2023 07:37:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C17B20040;
        Thu,  7 Sep 2023 07:36:59 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.80.205])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Sep 2023 07:36:59 +0000 (GMT)
Date:   Thu, 7 Sep 2023 13:06:56 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] ext4: Mark buffer new if it is unwritten to avoid
 stale data exposure
Message-ID: <ZPl9gAImu85zEbXP@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1693909504.git.ojaswin@linux.ibm.com>
 <c307579df7e109eb4eedaaf07ebdc98b15d8b7ff.1693909504.git.ojaswin@linux.ibm.com>
 <20230905135629.wdjl2b6s3pzh7idg@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905135629.wdjl2b6s3pzh7idg@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ue752K_Y0_dS1vsuqCf4V4Bpo2s4j7Os
X-Proofpoint-GUID: ue752K_Y0_dS1vsuqCf4V4Bpo2s4j7Os
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 05, 2023 at 03:56:29PM +0200, Jan Kara wrote:
> On Tue 05-09-23 15:58:01, Ojaswin Mujoo wrote:
> > ** Short Version **
> > 
> > In ext4 with dioread_nolock, we could have a scenario where the bh returned by
> > get_blocks (ext4_get_block_unwritten()) in __block_write_begin_int() has
> > UNWRITTEN and MAPPED flag set. Since such a bh does not have NEW flag set we
> > never zero out the range of bh that is not under write, causing whatever stale
> > data is present in the folio at that time to be written out to disk. To fix this
> > mark the buffer as new in _ext4_get_block(), in case it is unwritten.
> > 
> > -----
> > ** Long Version **
> > 
> > The issue mentioned above was resulting in two different bugs:
> > 
> > 1. On block size < page size case in ext4, generic/269 was reliably
> > failing with dioread_nolock. The state of the write was as follows:
> > 
> >   * The write was extending i_size.
> >   * The last block of the file was fallocated and had an unwritten extent
> >   * We were near ENOSPC and hence we were switching to non-delayed alloc
> >     allocation.
> > 
> > In this case, the back trace that triggers the bug is as follows:
> > 
> >   ext4_da_write_begin()
> >     /* switch to nodelalloc due to low space */
> >     ext4_write_begin()
> >       ext4_should_dioread_nolock() // true since mount flags still have delalloc
> >       __block_write_begin(..., ext4_get_block_unwritten)
> >         __block_write_begin_int()
> >           for(each buffer head in page) {
> >             /* first iteration, this is bh1 which contains i_size */
> >             if (!buffer_mapped)
> >               get_block() /* returns bh with only UNWRITTEN and MAPPED */
> >             /* second iteration, bh2 */
> >               if (!buffer_mapped)
> >                 get_block() /* we fail here, could be ENOSPC */
> >           }
> >           if (err)
> >             /*
> >              * this would zero out all new buffers and mark them uptodate.
> >              * Since bh1 was never marked new, we skip it here which causes
> >              * the bug later.
> >              */
> >             folio_zero_new_buffers();
> >       /* ext4_wrte_begin() error handling */
> >       ext4_truncate_failed_write()
> >         ext4_truncate()
> >           ext4_block_truncate_page()
> >             __ext4_block_zero_page_range()
> 	>               if(!buffer_uptodate())
> >                 ext4_read_bh_lock()
> >                   ext4_read_bh() -> ... ext4_submit_bh_wbc()
> >                     BUG_ON(buffer_unwritten(bh)); /* !!! */
> > 
> > 2. The second issue is stale data exposure with page size >= blocksize
> > with dioread_nolock. The conditions needed for it to happen are same as
> > the previous issue ie dioread_nolock around ENOSPC condition. The issue
> > is also similar where in __block_write_begin_int() when we call
> > ext4_get_block_unwritten() on the buffer_head and the underlying extent
> > is unwritten, we get an unwritten and mapped buffer head. Since it is
> > not new, we never zero out the partial range which is not under write,
> > thus writing stale data to disk. This can be easily observed with the
> > following reporducer:
> > 
> >  fallocate -l 4k testfile
> >  xfs_io -c "pwrite 2k 2k" testfile
> >  # hexdump output will have stale data in from byte 0 to 2k in testfile
> >  hexdump -C testfile
> > 
> > NOTE: To trigger this, we need dioread_nolock enabled and write
> > happening via ext4_write_begin(), which is usually used when we have -o
> > nodealloc. Since dioread_nolock is disabled with nodelalloc, the only
> > alternate way to call ext4_write_begin() is to fill make sure dellayed
> > alloc switches to nodelalloc (ext4_da_write_begin() calls
> > ext4_write_begin()).  This will usually happen when FS is almost full
> > like the way generic/269 was triggering it in Issue 1 above. This might
> > make this issue harder to replicate hence for reliable replicate, I used
> > the below patch to temporarily allow dioread_nolock with nodelalloc and
> > then mount the disk with -o nodealloc,dioread_nolock. With this you can
> > hit the stale data issue 100% of times:
> > 
> > @@ -508,8 +508,8 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
> >   if (ext4_should_journal_data(inode))
> >     return 0;
> >   /* temporary fix to prevent generic/422 test failures */
> > - if (!test_opt(inode->i_sb, DELALLOC))
> > -   return 0;
> > + // if (!test_opt(inode->i_sb, DELALLOC))
> > + //  return 0;
> >   return 1;
> >  }
> > 
> > -------
> > 
> > After applying this patch to mark buffer as NEW, both the above issues are
> > fixed.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Hi Jan, thanks for the review.

> 
> Good catch! But I'm wondering whether this is really the right fix. For
> example in ext4_block_truncate_page() shouldn't we rather be checking
> whether the buffer isn't unwritten and if yes then bail because there's
> nothing to zero out in the block? That would seem like a more logical
> and robust solution of the first problem to me.

Right, I agree. I will look into it and prepare a patch for this in v2.

> 
> Regarding the second issue I agree that using buffer_new flag makes the
> most sense. But it would make most sense to me to put this special logic
> directly into ext4_get_block_unwritten() because it is really special logic
> when preparing buffered write via unwritten extent (and it relies on
> __block_write_begin_int() logic to interpret buffer_new flag in the right
> way). Putting in _ext4_get_block() seems confusing to me because it raises
> questions like why should we set it for reads? And why not set it already
> in ext4_map_blocks() which is also used by iomap?

Originally I had kept it there because it didn't seem to affect any read
related paths, and marking an unwritten buffer as new for zero'ing out
seemed like the right thing to do irrespective of which code path we
were coming from. However, I think its okay to move it
ext4_get_block_unwritten() it seems to be the only place where we need
to explicitly mark it as such.

That being said, I also had an alternate solution that marked the map
flag as NEW in ext4_map_blocks() -> ext4_ext4_map_blocks() ->
ext4_ext_handle_unwritten_extents(). Do you think it makes more
sense to handle this issue in ext4 map layer instead of relying on special
handling of buffer head?

Yesterday I looked into this a bit more and it seems that all the other
code paths in ext4, except ext4_da_get_block_prep(), rely on
ext4_map_blocks() setting the NEW flag correctly in map->m_flags
whenever the buffer might need to be zeroed out (this is true for dio
write via iomap as well). Now this makes me incline towards fixing the
issue in ext4_map_blocks layer, which might be better in the longer for
eg when we eventually move to iomap.

Regards,
ojaswin

> 
> 								Honza
> 
> 
> > ---
> >  fs/ext4/inode.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 6c490f05e2ba..a30bfec0b525 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -765,6 +765,10 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
> >  	if (ret > 0) {
> >  		map_bh(bh, inode->i_sb, map.m_pblk);
> >  		ext4_update_bh_state(bh, map.m_flags);
> > +
> > +		if (buffer_unwritten(bh))
> > +			set_buffer_new(bh);
> > +
> >  		bh->b_size = inode->i_sb->s_blocksize * map.m_len;
> >  		ret = 0;
> >  	} else if (ret == 0) {
> > -- 
> > 2.31.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
