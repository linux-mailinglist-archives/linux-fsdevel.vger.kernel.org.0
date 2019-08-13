Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA3C8BB9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfHMOfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 10:35:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59450 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfHMOfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:35:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DEZPNZ074255;
        Tue, 13 Aug 2019 14:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=nMBb5D8Ix0hAbWYXXbLi6E1UjhMxHvShcIE7RMXcTQ4=;
 b=MTBd9dTFLiJYAf6qEJbEbV/YGmJA1JqyAqPr+wNUBlFbgnfl1Myyg+gpaHNFBEYSODl8
 kfm3RdJereGaYf0UISDhF416OSTY73cPD4Y8kQH4lcxHug7ljx57hfurP8QGH90K7cDo
 rXRyBdr7gXr/fZZpcqxTtJyATXqXhVH8y2znICARDsTcLXv857zmKVFu9MqZ3xBa6ACB
 d12jS3I+A+ewPLCbuEAk6IxB2LkgK6iZ5sGsWtbyXCfltI2MTEHJ/BYBARHxk4JrU5Nf
 aDyXz4YGpGbWlHUA2fPeO9m3AQ7GF9yJtAju6aJSSjnXstMgXhTH/Zocum57DNleZqlt ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u9nbterw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 14:35:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DEXCBU117297;
        Tue, 13 Aug 2019 14:35:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ubwrrbnna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 14:35:44 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7DEZec5032232;
        Tue, 13 Aug 2019 14:35:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 07:35:40 -0700
Date:   Tue, 13 Aug 2019 07:35:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     RITESH HARJANI <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190813143540.GA7126@magnolia>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812170430.982E552051@d06av21.portsmouth.uk.ibm.com>
 <20190813125840.GA10187@neo.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813125840.GA10187@neo.Home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:58:42PM +1000, Matthew Bobrowski wrote:
> On Mon, Aug 12, 2019 at 10:34:29PM +0530, RITESH HARJANI wrote:
> > > +	if (offset + count > i_size_read(inode) ||
> > > +	    offset + count > EXT4_I(inode)->i_disksize) {
> > > +		ext4_update_i_disksize(inode, inode->i_size);
> > > +		extend = true;
> > > +	}
> > > +
> > > +	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, ext4_dio_write_end_io);
> > > +
> > > +	/*
> > > +	 * Unaligned direct AIO must be the only IO in flight or else
> > > +	 * any overlapping aligned IO after unaligned IO might result
> > > +	 * in data corruption.
> > > +	 */
> > > +	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
> > > +		inode_dio_wait(inode);
> > 
> > Could you please add explain & add a comment about why we wait in AIO DIO
> > case
> > when extend is true? As I see without iomap code this case was not present
> > earlier.
> 
> Because while using the iomap infrastructure for AIO writes, we return to the
> caller prior to invoking the ->end_io() handler. This callback is responsible
> for performing the in-core/on-disk inode extension if it is deemed
> necessary. If we don't wait in the case of an extend, we run the risk of
> loosing inode size consistencies in addition to things leading to possible
> data corruption...
> 
> > > +
> > > +	if (ret >= 0 && iov_iter_count(from)) {
> > > +		overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> > > +		return ext4_buffered_write_iter(iocb, from);
> > > +	}
> > should not we copy code from "__generic_file_write_iter" which does below?
> > 
> > 3436                 /*
> > 3437                  * We need to ensure that the page cache pages are
> > written to
> > 3438                  * disk and invalidated to preserve the expected
> > O_DIRECT
> > 3439                  * semantics.
> > 3440                  */
> 
> Hm, I don't see why this would be required seeing as though the page cache
> invalidation semantics pre and post write are handled by iomap_dio_rw() and
> iomap_dio_complete(). But, I could be completely wrong here, so we may need to
> wait for some others to provide comments on this.

iomap_dio_rw is supposed to zap the page cache before the write and
again afterwards (and whine if someone is racing buffered and direct
writes to the same file location), so ext4 shouldn't need to do that
itself.

--D

> > > +			WARN_ON(!(flags & IOMAP_DIRECT));
> > > +			if (round_down(offset, i_blocksize(inode)) >=
> > > +			    i_size_read(inode)) {
> > > +				ret = ext4_map_blocks(handle, inode, &map,
> > > +						      EXT4_GET_BLOCKS_CREATE);
> > > +			} else if (!ext4_test_inode_flag(inode,
> > > +							 EXT4_INODE_EXTENTS)) {
> > > +				/*
> > > +				 * We cannot fill holes in indirect
> > > +				 * tree based inodes as that could
> > > +				 * expose stale data in the case of a
> > > +				 * crash. Use magic error code to
> > > +				 * fallback to buffered IO.
> > > +				 */
> > > +				ret = ext4_map_blocks(handle, inode, &map, 0);
> > > +				if (ret == 0)
> > > +					ret = -ENOTBLK;
> > > +			} else {
> > > +				ret = ext4_map_blocks(handle, inode, &map,
> > > +						      EXT4_GET_BLOCKS_IO_CREATE_EXT);
> > > +			}
> > > +		}
> > 
> > Could you please check & confirm on below points -
> > 1. Do you see a problem @above in case of *overwrite* with extents mapping?
> > It will fall into EXT4_GET_BLOCKS_IO_CREATE_EXT case.
> > So are we piggy backing on the fact that ext4_map_blocks first call
> > ext4_ext_map_blocks
> > with flags & EXT4_GET_BLOCKS_KEEP_SIZE. And so for overwrite case since it
> > will return
> > val > 0 then we will anyway not create any blocks and so we don't need to
> > check overwrite
> > case specifically here?
> > 
> > 
> > 2. For cases with flags passed is 0 to ext4_map_blocks (overwrite &
> > fallocate without extent case),
> > we need not start the journaling transaction. But in above we are doing
> > ext4_journal_start/stop unconditionally
> > & unnecessarily reserving dio_credits blocks.
> > We need to take care of that right?
> 
> Hm, I think you raise valid points here.
> 
> Jan, do you have any comments on the above? I vaguely remember having a
> discussion around dropping the overwrite checks in ext4_iomap_begin() as we're
> removing the inode_lock() early on in ext4_dio_write_iter(), so it woudln't be
> necessary to do so. But, now that Ritesh mentioned it again I'm thinking it
> may actually be required...
> 
> > >   		if (ret < 0) {
> > >   			ext4_journal_stop(handle);
> > >   			if (ret == -ENOSPC &&
> > > @@ -3581,10 +3611,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > >   		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> > >   		iomap->addr = IOMAP_NULL_ADDR;
> > >   	} else {
> > > -		if (map.m_flags & EXT4_MAP_MAPPED) {
> > > -			iomap->type = IOMAP_MAPPED;
> > > -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> > > +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> > >   			iomap->type = IOMAP_UNWRITTEN;
> > > +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> > > +			iomap->type = IOMAP_MAPPED;
> > Maybe a comment as to explaining why checking UNWRITTEN before is necessary
> > for others.
> > So in case of fallocate & DIO write case we may get extent which is both
> > unwritten & mapped (right?).
> > so we need to check if we have an unwritten extent first so that it will
> > need the conversion in ->end_io
> > callback.
> 
> Yes, that is essentially correct.
> 
> --M
