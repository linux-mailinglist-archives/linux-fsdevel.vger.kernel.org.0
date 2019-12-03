Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE810FCF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 12:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfLCLyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 06:54:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4162 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfLCLyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:54:53 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3Bbav5193235
        for <linux-fsdevel@vger.kernel.org>; Tue, 3 Dec 2019 06:54:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wkm47suxh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2019 06:54:52 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 3 Dec 2019 11:54:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 11:54:48 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3BsloB33030252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 11:54:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53A6FAE045;
        Tue,  3 Dec 2019 11:54:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F802AE059;
        Tue,  3 Dec 2019 11:54:45 +0000 (GMT)
Received: from [9.199.158.219] (unknown [9.199.158.219])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 11:54:45 +0000 (GMT)
Subject: Re: [RFCv3 4/4] ext4: Move to shared iolock even without
 dioread_nolock mount opt
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-5-riteshh@linux.ibm.com>
 <20191120143257.GE9509@quack2.suse.cz>
 <20191126105122.75EC6A4060@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20191129171836.GB27588@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 3 Dec 2019 17:24:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191129171836.GB27588@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120311-0016-0000-0000-000002D05384
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120311-0017-0000-0000-000033324C90
Message-Id: <20191203115445.6F802AE059@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_02:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 suspectscore=2 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030095
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jan,

I have compiled something based on our discussion.
Could you please share your thoughts on below.

On 11/29/19 10:48 PM, Jan Kara wrote:
> Hello Ritesh!
> 
> On Tue 26-11-19 16:21:15, Ritesh Harjani wrote:
>> On 11/20/19 8:02 PM, Jan Kara wrote:
>>> On Wed 20-11-19 10:30:24, Ritesh Harjani wrote:
>>>> We were using shared locking only in case of dioread_nolock
>>>> mount option in case of DIO overwrites. This mount condition
>>>> is not needed anymore with current code, since:-
>>>>
>>>> 1. No race between buffered writes & DIO overwrites.
>>>> Since buffIO writes takes exclusive locks & DIO overwrites
>>>> will take share locking. Also DIO path will make sure
>>>> to flush and wait for any dirty page cache data.
>>>>
>>>> 2. No race between buffered reads & DIO overwrites, since there
>>>> is no block allocation that is possible with DIO overwrites.
>>>> So no stale data exposure should happen. Same is the case
>>>> between DIO reads & DIO overwrites.
>>>>
>>>> 3. Also other paths like truncate is protected,
>>>> since we wait there for any DIO in flight to be over.
>>>>
>>>> 4. In case of buffIO writes followed by DIO reads:
>>>> Since here also we take exclusive locks in ext4_write_begin/end().
>>>> There is no risk of exposing any stale data in this case.
>>>> Since after ext4_write_end, iomap_dio_rw() will wait to flush &
>>>> wait for any dirty page cache data.
>>>>
>>>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>>
>>> There's one more case to consider here as I mentioned in [1]. There can be
>>
>> Yes, I should have mentioned about this in cover letter and about my
>> thoughts on that.
>> I was of the opinion that since the race is already existing
>> and it may not be caused due to this patch, so we should handle that in
>> incremental fashion and as a separate patch series after this one.
>> Let me know your thoughts on above.
> 
> Yes, I'm fine with that.

Sure thanks, will do that.

> 
>> Also, I wanted to have some more discussions on this race before
>> making the changes.
>> But nevertheless, it's the right time to discuss those changes here.
>>
>>> mmap write instantiating dirty page and then someone starting writeback
>>> against that page while DIO read is running still theoretically leading to
>>> stale data exposure. Now this patch does not have influence on that race
>>> but:
>>
>> Yes, agreed.
>>
>>>
>>> 1) We need to close the race mentioned above. Maybe we could do that by
>>> proactively allocating unwritten blocks for a page being faulted when there
>>> is direct IO running against the file - the one who fills holes through
>>> mmap write while direct IO is running on the file deserves to suffer the
>>> performance penalty...
>>
>> I was giving this a thought. So even if we try to penalize mmap
>> write as you mentioned above, what I am not sure about it, is that, how can
>> we reliably detect that the DIO is in progress?
>>
>> Say even if we try to check for atomic_read(&inode->i_dio_count) in mmap
>> ext4_page_mkwrite path, it cannot be reliable unless there is some sort of a
>> lock protection, no?
>> Because after the check the DIO can still snoop in, right?
> 
> Yes, doing this reliably will need some code tweaking. Also thinking about
> this in detail, doing a reliable check in ext4_page_mkwrite() is
> somewhat difficult so it will be probably less error-prone to deal with the
> race in the writeback path.

hmm. But if we don't do in ext4_page_mkwrite, then I am afraid on
how to handle nodelalloc scenario. Where we will directly go and
allocate block via ext4_get_block() in ext4_page_mkwrite(),
as explained below.
I guess we may need some tweaking at both places.


> 
> My preferred way of dealing with this would be to move inode_dio_begin()
> call in iomap_dio_rw() a bit earlier before page cache invalidation and add
> there smp_mb_after_atomic() (so that e.g. nrpages checks cannot get
> reordered before the increment).  Then the check on i_dio_count in
> ext4_writepages() will be reliable if we do it after gathering and locking
> pages for writeback (i.e., in mpage_map_and_submit_extent()) - either we
> see i_dio_count elevated and use the safe (but slower) writeback using
> unwritten extents, or we see don't and then we are sure DIO will not start
> until writeback of the pages we have locked has finished because of
> filemap_write_and_wait() call in iomap_dio_rw().
> 
> 

Thanks for explaining this in detail. I guess I understand this part now
Earlier my understanding towards mapping->nrpages was not complete.

AFAIU, with your above suggestion the race won't happen for delalloc
cases. But what if it is a nodelalloc mount option?

Say with above changes i.e. after tweaking iomap_dio_rw() code as you
mentioned above. Below race could still happen, right?

iomap_dio_rw()					
filemap_write_and_wait_range() 			
inode_dio_begin()
smp_mb__after_atomic()
invalidate_inode_pages2_range()				
						ext4_page_mkwrite()
						block_page_mkwrite()
		  				  lock_page()
						  ext4_get_block()

ext4_map_blocks()
//this will return IOMAP_MAPPED entry

submit_bio()
// this goes and reads the block
// with stale data allocated,
// by ext4_page_mkwrite()


Now, I am assuming that ext4_get_block() via ext4_page_mkwrite() path
may try to create the block for hole then and there itself.
And if submit_bio() from DIO path is serviced late i.e. after
ext4_get_block() has already allocated block there, then this may expose 
stale data. Thoughts?


So to avoid both such races in delalloc & in nodelalloc path,
we should add the checks at both ext4_writepages() & also at
ext4_page_mkwrite().

For ext4_page_mkwrite(), why don't we just change the "get_block"
function pointer which is passed to block_page_mkwrite()
as below. This should solve our race since
ext4_dio_check_get_block() will be only called with lock_page()
held. And also with inode_dio_begin() now moved up before
invalidate_inode_pages2_range(), we could be sure
about DIO is currently running or not in ext4_page_mkwrite() path.

Does this looks correct to you?

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 381813205f99..74c33d03592c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -806,6 +806,19 @@ int ext4_get_block_unwritten(struct inode *inode, 
sector_t iblock,
  			       EXT4_GET_BLOCKS_IO_CREATE_EXT);
  }

+int ext4_dio_check_get_block(struct inode *inode, sector_t iblock,
+		   struct buffer_head *bh, int create)
+{
+	get_block_t *get_block;
+
+	if (!atomic_read(&inode->i_dio_count))
+		get_block = ext4_get_block;
+	else
+		get_block = ext4_get_block_unwritten;
+
+	return get_block(inode, iblock, bh, create);
+}
+
  /* Maximum number of blocks we map for direct IO at once. */
  #define DIO_MAX_BLOCKS 4096

@@ -2332,7 +2345,8 @@ static int mpage_map_one_extent(handle_t *handle, 
struct mpage_da_data *mpd)
  	struct inode *inode = mpd->inode;
  	struct ext4_map_blocks *map = &mpd->map;
  	int get_blocks_flags;
-	int err, dioread_nolock;
+	int err;
+	bool dio_in_progress = atomic_read(&inode->i_dio_count);

  	trace_ext4_da_write_pages_extent(inode, map);
  	/*
@@ -2353,8 +2367,14 @@ static int mpage_map_one_extent(handle_t *handle, 
struct mpage_da_data *mpd)
  	get_blocks_flags = EXT4_GET_BLOCKS_CREATE |
  			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
  			   EXT4_GET_BLOCKS_IO_SUBMIT;
-	dioread_nolock = ext4_should_dioread_nolock(inode);
-	if (dioread_nolock)
+
+	/*
+	 * There could be race between DIO read & ext4_page_mkwrite
+	 * where in delalloc case, we may go and try to allocate the
+	 * block here but if DIO read is in progress then it may expose
+	 * stale data, hence use unwritten blocks for allocation
+	 * when DIO is in progress.
+	 */
+	if (dio_in_progress)
  		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
  	if (map->m_flags & (1 << BH_Delay))
  		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
@@ -2362,7 +2382,7 @@ static int mpage_map_one_extent(handle_t *handle, 
struct mpage_da_data *mpd)
  	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
  	if (err < 0)
  		return err;
-	if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
+	if (dio_in_progress && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
  		if (!mpd->io_submit.io_end->handle &&
  		    ext4_handle_valid(handle)) {
  			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
@@ -5906,10 +5926,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
  	}
  	unlock_page(page);
  	/* OK, we need to fill the hole... */
-	if (ext4_should_dioread_nolock(inode))
-		get_block = ext4_get_block_unwritten;
-	else
-		get_block = ext4_get_block;
+	get_block = ext4_dio_check_get_block;
  retry_alloc:
  	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
  				    ext4_writepage_trans_blocks(inode));
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 2f88d64c2a4d..09d0601e5ecb 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -465,6 +465,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
  	if (ret)
  		goto out_free_dio;

+	inode_dio_begin(inode);
+	smp_mb__after_atomic();
  	/*
  	 * Try to invalidate cache pages for the range we're direct
  	 * writing.  If this invalidation fails, tough, the write will
@@ -484,8 +486,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
  			goto out_free_dio;
  	}

-	inode_dio_begin(inode);
-
  	blk_start_plug(&plug);
  	do {
  		ret = iomap_apply(inode, pos, count, flags, ops, dio,



-ritesh

