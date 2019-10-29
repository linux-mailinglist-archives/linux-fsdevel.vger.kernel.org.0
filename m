Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10259E801B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 07:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbfJ2GM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 02:12:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727462AbfJ2GM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 02:12:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9T6BkV1121450
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 02:12:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vxccsdwd3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 02:12:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 29 Oct 2019 06:12:24 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Oct 2019 06:12:22 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9T6CLC953936330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 06:12:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BF61A405F;
        Tue, 29 Oct 2019 06:12:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 889B2A405C;
        Tue, 29 Oct 2019 06:12:18 +0000 (GMT)
Received: from [9.199.158.60] (unknown [9.199.158.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 06:12:18 +0000 (GMT)
Subject: Re: [PATCH v6 10/11] ext4: update ext4_sync_file() to not use
 __generic_file_fsync()
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <b58782fcf631b6248174fb69f3314fd60b760404.1572255426.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 29 Oct 2019 11:42:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b58782fcf631b6248174fb69f3314fd60b760404.1572255426.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102906-4275-0000-0000-00000378B3D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102906-4276-0000-0000-0000388BE8F3
Message-Id: <20191029061218.889B2A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290062
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/28/19 4:23 PM, Matthew Bobrowski wrote:
> When the filesystem is created without a journal, we eventually call
> into __generic_file_fsync() in order to write out all the modified
> in-core data to the permanent storage device. This function happens to
> try and obtain an inode_lock() while synchronizing the files buffer
> and it's associated metadata.
> 
> Generally, this is fine, however it becomes a problem when there is
> higher level code that has already obtained an inode_lock() as this
> leads to a recursive lock situation. This case is especially true when
> porting across direct I/O to iomap infrastructure as we obtain an
> inode_lock() early on in the I/O within ext4_dio_write_iter() and hold
> it until the I/O has been completed. Consequently, to not run into
> this specific issue, we move away from calling into
> __generic_file_fsync() and perform the necessary synchronization tasks
> within ext4_sync_file().
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>


Thanks for the patch. Looks good to me.
You may add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
> 
> Thanks Jan and Christoph for the suggestion on this one, highly
> appreciated.
> 
>   fs/ext4/fsync.c | 72 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 47 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
> index 5508baa11bb6..e10206e7f4bb 100644
> --- a/fs/ext4/fsync.c
> +++ b/fs/ext4/fsync.c
> @@ -80,6 +80,43 @@ static int ext4_sync_parent(struct inode *inode)
>   	return ret;
>   }
> 
> +static int ext4_fsync_nojournal(struct inode *inode, bool datasync,
> +				bool *needs_barrier)
> +{
> +	int ret, err;
> +
> +	ret = sync_mapping_buffers(inode->i_mapping);
> +	if (!(inode->i_state & I_DIRTY_ALL))
> +		return ret;
> +	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
> +		return ret;
> +
> +	err = sync_inode_metadata(inode, 1);
> +	if (!ret)
> +		ret = err;
> +
> +	if (!ret)
> +		ret = ext4_sync_parent(inode);
> +	if (test_opt(inode->i_sb, BARRIER))
> +		*needs_barrier = true;
> +
> +	return ret;
> +}
> +
> +static int ext4_fsync_journal(struct inode *inode, bool datasync,
> +			     bool *needs_barrier)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> +	tid_t commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
> +
> +	if (journal->j_flags & JBD2_BARRIER &&
> +	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
> +		*needs_barrier = true;
> +
> +	return jbd2_complete_transaction(journal, commit_tid);
> +}
> +
>   /*
>    * akpm: A new design for ext4_sync_file().
>    *
> @@ -91,17 +128,14 @@ static int ext4_sync_parent(struct inode *inode)
>    * What we do is just kick off a commit and wait on it.  This will snapshot the
>    * inode to disk.
>    */
> -
>   int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>   {
> -	struct inode *inode = file->f_mapping->host;
> -	struct ext4_inode_info *ei = EXT4_I(inode);
> -	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>   	int ret = 0, err;
> -	tid_t commit_tid;
>   	bool needs_barrier = false;
> +	struct inode *inode = file->f_mapping->host;
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> 
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> +	if (unlikely(ext4_forced_shutdown(sbi)))
>   		return -EIO;
> 
>   	J_ASSERT(ext4_journal_current_handle() == NULL);
> @@ -111,23 +145,15 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>   	if (sb_rdonly(inode->i_sb)) {
>   		/* Make sure that we read updated s_mount_flags value */
>   		smp_rmb();
> -		if (EXT4_SB(inode->i_sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
> +		if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
>   			ret = -EROFS;
>   		goto out;
>   	}
> 
> -	if (!journal) {
> -		ret = __generic_file_fsync(file, start, end, datasync);
> -		if (!ret)
> -			ret = ext4_sync_parent(inode);
> -		if (test_opt(inode->i_sb, BARRIER))
> -			goto issue_flush;
> -		goto out;
> -	}
> -
>   	ret = file_write_and_wait_range(file, start, end);
>   	if (ret)
>   		return ret;
> +
>   	/*
>   	 * data=writeback,ordered:
>   	 *  The caller's filemap_fdatawrite()/wait will sync the data.
> @@ -142,18 +168,14 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>   	 *  (they were dirtied by commit).  But that's OK - the blocks are
>   	 *  safe in-journal, which is all fsync() needs to ensure.
>   	 */
> -	if (ext4_should_journal_data(inode)) {
> +	if (!sbi->s_journal)
> +		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
> +	else if (ext4_should_journal_data(inode))
>   		ret = ext4_force_commit(inode->i_sb);
> -		goto out;
> -	}
> +	else
> +		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
> 
> -	commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
> -	if (journal->j_flags & JBD2_BARRIER &&
> -	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
> -		needs_barrier = true;
> -	ret = jbd2_complete_transaction(journal, commit_tid);
>   	if (needs_barrier) {
> -	issue_flush:
>   		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
>   		if (!ret)
>   			ret = err;
> 

