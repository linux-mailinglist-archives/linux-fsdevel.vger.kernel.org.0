Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3289338F7DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 04:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhEYCGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 22:06:25 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:42740 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbhEYCGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 22:06:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ua0e85D_1621908284;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Ua0e85D_1621908284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 May 2021 10:04:44 +0800
Subject: Re: [PATCH v2] ocfs2: fix data corruption by fallocate
To:     Junxiao Bi <junxiao.bi@oracle.com>, ocfs2-devel@oss.oracle.com
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org
References: <20210521233612.75185-1-junxiao.bi@oracle.com>
 <35a1d32b-b8d7-ea9b-d28c-6b4fd837605d@linux.alibaba.com>
 <8aa90f5d-e4db-5107-1d3c-383294871196@oracle.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <21d8b289-541d-50f5-6f86-de3ee69c56c5@linux.alibaba.com>
Date:   Tue, 25 May 2021 10:04:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8aa90f5d-e4db-5107-1d3c-383294871196@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the explanations.
A tiny cleanup, we can use 'orig_isize' instead of i_size_read() later
in __ocfs2_change_file_space().
Other looks good to me.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

On 5/25/21 12:23 AM, Junxiao Bi wrote:
> That will not work, buffer write zero first, then update i_size, in between writeback could be kicked in and clear those dirty buffers because they were out of i_size. Beside that, OCFS2_IOC_RESVSP64 was never doing right job, it didn't take care eof blocks in the last cluster, that made even a simple fallocate to extend file size could cause corruption. This patch fixed both issues.
> 
> Thanks,
> 
> Junxiao.
> 
> On 5/23/21 4:52 AM, Joseph Qi wrote:
>> Hi Junxiao,
>> If change_size is true (!FALLOC_FL_KEEP_SIZE), it will update isize
>> in __ocfs2_change_file_space(). Why do we have to zeroout first?
>>
>> Thanks,
>> Joseph
>>
>> On 5/22/21 7:36 AM, Junxiao Bi wrote:
>>> When fallocate punches holes out of inode size, if original isize is in
>>> the middle of last cluster, then the part from isize to the end of the
>>> cluster will be zeroed with buffer write, at that time isize is not
>>> yet updated to match the new size, if writeback is kicked in, it will
>>> invoke ocfs2_writepage()->block_write_full_page() where the pages out
>>> of inode size will be dropped. That will cause file corruption. Fix
>>> this by zero out eof blocks when extending the inode size.
>>>
>>> Running the following command with qemu-image 4.2.1 can get a corrupted
>>> coverted image file easily.
>>>
>>>      qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
>>>               -O qcow2 -o compat=1.1 $qcow_image.conv
>>>
>>> The usage of fallocate in qemu is like this, it first punches holes out of
>>> inode size, then extend the inode size.
>>>
>>>      fallocate(11, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2276196352, 65536) = 0
>>>      fallocate(11, 0, 2276196352, 65536) = 0
>>>
>>> v1: https://www.spinics.net/lists/linux-fsdevel/msg193999.html
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Cc: Jan Kara <jack@suse.cz>
>>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>>> ---
>>>
>>> Changes in v2:
>>> - suggested by Jan Kara, using sb_issue_zeroout to zero eof blocks in disk directly.
>>>
>>>   fs/ocfs2/file.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 47 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
>>> index f17c3d33fb18..17469fc7b20e 100644
>>> --- a/fs/ocfs2/file.c
>>> +++ b/fs/ocfs2/file.c
>>> @@ -1855,6 +1855,45 @@ int ocfs2_remove_inode_range(struct inode *inode,
>>>       return ret;
>>>   }
>>>   +/*
>>> + * zero out partial blocks of one cluster.
>>> + *
>>> + * start: file offset where zero starts, will be made upper block aligned.
>>> + * len: it will be trimmed to the end of current cluster if "start + len"
>>> + *      is bigger than it.
>>> + */
>>> +static int ocfs2_zeroout_partial_cluster(struct inode *inode,
>>> +                    u64 start, u64 len)
>>> +{
>>> +    int ret;
>>> +    u64 start_block, end_block, nr_blocks;
>>> +    u64 p_block, offset;
>>> +    u32 cluster, p_cluster, nr_clusters;
>>> +    struct super_block *sb = inode->i_sb;
>>> +    u64 end = ocfs2_align_bytes_to_clusters(sb, start);
>>> +
>>> +    if (start + len < end)
>>> +        end = start + len;
>>> +
>>> +    start_block = ocfs2_blocks_for_bytes(sb, start);
>>> +    end_block = ocfs2_blocks_for_bytes(sb, end);
>>> +    nr_blocks = end_block - start_block;
>>> +    if (!nr_blocks)
>>> +        return 0;
>>> +
>>> +    cluster = ocfs2_bytes_to_clusters(sb, start);
>>> +    ret = ocfs2_get_clusters(inode, cluster, &p_cluster,
>>> +                &nr_clusters, NULL);
>>> +    if (ret)
>>> +        return ret;
>>> +    if (!p_cluster)
>>> +        return 0;
>>> +
>>> +    offset = start_block - ocfs2_clusters_to_blocks(sb, cluster);
>>> +    p_block = ocfs2_clusters_to_blocks(sb, p_cluster) + offset;
>>> +    return sb_issue_zeroout(sb, p_block, nr_blocks, GFP_NOFS);
>>> +}
>>> +
>>>   /*
>>>    * Parts of this function taken from xfs_change_file_space()
>>>    */
>>> @@ -1865,7 +1904,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>   {
>>>       int ret;
>>>       s64 llen;
>>> -    loff_t size;
>>> +    loff_t size, orig_isize;
>>>       struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>>>       struct buffer_head *di_bh = NULL;
>>>       handle_t *handle;
>>> @@ -1896,6 +1935,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>           goto out_inode_unlock;
>>>       }
>>>   +    orig_isize = i_size_read(inode);
>>>       switch (sr->l_whence) {
>>>       case 0: /*SEEK_SET*/
>>>           break;
>>> @@ -1903,7 +1943,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>           sr->l_start += f_pos;
>>>           break;
>>>       case 2: /*SEEK_END*/
>>> -        sr->l_start += i_size_read(inode);
>>> +        sr->l_start += orig_isize;
>>>           break;
>>>       default:
>>>           ret = -EINVAL;
>>> @@ -1957,6 +1997,11 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>       default:
>>>           ret = -EINVAL;
>>>       }
>>> +
>>> +    /* zeroout eof blocks in the cluster. */
>>> +    if (!ret && change_size && orig_isize < size)
>>> +        ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
>>> +                    size - orig_isize);
>>>       up_write(&OCFS2_I(inode)->ip_alloc_sem);
>>>       if (ret) {
>>>           mlog_errno(ret);
>>>
