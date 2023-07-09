Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C174C474
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 15:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGIN7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjGIN7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:59:19 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B0C0;
        Sun,  9 Jul 2023 06:59:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VmvDNm8_1688911149;
Received: from 30.0.148.243(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VmvDNm8_1688911149)
          by smtp.aliyun-inc.com;
          Sun, 09 Jul 2023 21:59:10 +0800
Message-ID: <ad525873-0061-3986-0d6d-e1a66f327e27@linux.alibaba.com>
Date:   Sun, 9 Jul 2023 21:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 62/92] ocfs2: convert to ctime accessor functions
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@lists.linux.dev
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-60-jlayton@kernel.org>
 <2033ce6a-761e-b891-42e0-2659506eb61d@linux.alibaba.com>
 <4f7d791d516897e4b281a5bd3889e83ef7e2b52e.camel@kernel.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <4f7d791d516897e4b281a5bd3889e83ef7e2b52e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/7/23 6:07 PM, Jeff Layton wrote:
> On Fri, 2023-07-07 at 11:15 +0800, Joseph Qi wrote:
>>
>> On 7/6/23 3:01 AM, Jeff Layton wrote:
>>> In later patches, we're going to change how the inode's ctime field is
>>> used. Switch to using accessor functions instead of raw accesses of
>>> inode->i_ctime.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  fs/ocfs2/acl.c          |  6 +++---
>>>  fs/ocfs2/alloc.c        |  6 +++---
>>>  fs/ocfs2/aops.c         |  2 +-
>>>  fs/ocfs2/dir.c          |  8 ++++----
>>>  fs/ocfs2/dlmfs/dlmfs.c  |  4 ++--
>>>  fs/ocfs2/dlmglue.c      |  7 +++++--
>>>  fs/ocfs2/file.c         | 16 +++++++++-------
>>>  fs/ocfs2/inode.c        | 12 ++++++------
>>>  fs/ocfs2/move_extents.c |  6 +++---
>>>  fs/ocfs2/namei.c        | 21 +++++++++++----------
>>>  fs/ocfs2/refcounttree.c | 14 +++++++-------
>>>  fs/ocfs2/xattr.c        |  6 +++---
>>>  12 files changed, 57 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
>>> index 9fd03eaf15f8..e75137a8e7cb 100644
>>> --- a/fs/ocfs2/acl.c
>>> +++ b/fs/ocfs2/acl.c
>>> @@ -191,10 +191,10 @@ static int ocfs2_acl_set_mode(struct inode *inode, struct buffer_head *di_bh,
>>>  	}
>>>  
>>>  	inode->i_mode = new_mode;
>>> -	inode->i_ctime = current_time(inode);
>>> +	inode_set_ctime_current(inode);
>>>  	di->i_mode = cpu_to_le16(inode->i_mode);
>>> -	di->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
>>> -	di->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
>>> +	di->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
>>> +	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>>>  	ocfs2_update_inode_fsync_trans(handle, inode, 0);
>>>  
>>>  	ocfs2_journal_dirty(handle, di_bh);
>>> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
>>> index 51c93929a146..aef58f1395c8 100644
>>> --- a/fs/ocfs2/alloc.c
>>> +++ b/fs/ocfs2/alloc.c
>>> @@ -7436,10 +7436,10 @@ int ocfs2_truncate_inline(struct inode *inode, struct buffer_head *di_bh,
>>>  	}
>>>  
>>>  	inode->i_blocks = ocfs2_inode_sector_count(inode);
>>> -	inode->i_ctime = inode->i_mtime = current_time(inode);
>>> +	inode->i_mtime = inode_set_ctime_current(inode);
>>>  
>>> -	di->i_ctime = di->i_mtime = cpu_to_le64(inode->i_ctime.tv_sec);
>>> -	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
>>> +	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
>>> +	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>>>  
>>>  	ocfs2_update_inode_fsync_trans(handle, inode, 1);
>>>  	ocfs2_journal_dirty(handle, di_bh);
>>> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
>>> index 8dfc284e85f0..0fdba30740ab 100644
>>> --- a/fs/ocfs2/aops.c
>>> +++ b/fs/ocfs2/aops.c
>>> @@ -2048,7 +2048,7 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
>>>  		}
>>>  		inode->i_blocks = ocfs2_inode_sector_count(inode);
>>>  		di->i_size = cpu_to_le64((u64)i_size_read(inode));
>>> -		inode->i_mtime = inode->i_ctime = current_time(inode);
>>> +		inode->i_mtime = inode_set_ctime_current(inode);
>>>  		di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
>>>  		di->i_mtime_nsec = di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
>>>  		if (handle)
>>> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
>>> index 694471fc46b8..8b123d543e6e 100644
>>> --- a/fs/ocfs2/dir.c
>>> +++ b/fs/ocfs2/dir.c
>>> @@ -1658,7 +1658,7 @@ int __ocfs2_add_entry(handle_t *handle,
>>>  				offset, ocfs2_dir_trailer_blk_off(dir->i_sb));
>>>  
>>>  		if (ocfs2_dirent_would_fit(de, rec_len)) {
>>> -			dir->i_mtime = dir->i_ctime = current_time(dir);
>>> +			dir->i_mtime = inode_set_ctime_current(dir);
>>>  			retval = ocfs2_mark_inode_dirty(handle, dir, parent_fe_bh);
>>>  			if (retval < 0) {
>>>  				mlog_errno(retval);
>>> @@ -2962,11 +2962,11 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
>>>  	ocfs2_dinode_new_extent_list(dir, di);
>>>  
>>>  	i_size_write(dir, sb->s_blocksize);
>>> -	dir->i_mtime = dir->i_ctime = current_time(dir);
>>> +	dir->i_mtime = inode_set_ctime_current(dir);
>>>  
>>>  	di->i_size = cpu_to_le64(sb->s_blocksize);
>>> -	di->i_ctime = di->i_mtime = cpu_to_le64(dir->i_ctime.tv_sec);
>>> -	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(dir->i_ctime.tv_nsec);
>>> +	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(dir).tv_sec);
>>> +	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime(dir).tv_nsec);
>>>  	ocfs2_update_inode_fsync_trans(handle, dir, 1);
>>>  
>>>  	/*
>>> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
>>> index ba26c5567cff..81265123ce6c 100644
>>> --- a/fs/ocfs2/dlmfs/dlmfs.c
>>> +++ b/fs/ocfs2/dlmfs/dlmfs.c
>>> @@ -337,7 +337,7 @@ static struct inode *dlmfs_get_root_inode(struct super_block *sb)
>>>  	if (inode) {
>>>  		inode->i_ino = get_next_ino();
>>>  		inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
>>> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
>>> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>>>  		inc_nlink(inode);
>>>  
>>>  		inode->i_fop = &simple_dir_operations;
>>> @@ -360,7 +360,7 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
>>>  
>>>  	inode->i_ino = get_next_ino();
>>>  	inode_init_owner(&nop_mnt_idmap, inode, parent, mode);
>>> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
>>> +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>>>  
>>>  	ip = DLMFS_I(inode);
>>>  	ip->ip_conn = DLMFS_I(parent)->ip_conn;
>>> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
>>> index c28bc983a7b1..c3e2961ee5db 100644
>>> --- a/fs/ocfs2/dlmglue.c
>>> +++ b/fs/ocfs2/dlmglue.c
>>> @@ -2162,6 +2162,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
>>>  	struct ocfs2_inode_info *oi = OCFS2_I(inode);
>>>  	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
>>>  	struct ocfs2_meta_lvb *lvb;
>>> +	struct timespec64 ctime = inode_get_ctime(inode);
>>>  
>>>  	lvb = ocfs2_dlm_lvb(&lockres->l_lksb);
>>>  
>>> @@ -2185,7 +2186,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
>>>  	lvb->lvb_iatime_packed  =
>>>  		cpu_to_be64(ocfs2_pack_timespec(&inode->i_atime));
>>>  	lvb->lvb_ictime_packed =
>>> -		cpu_to_be64(ocfs2_pack_timespec(&inode->i_ctime));
>>> +		cpu_to_be64(ocfs2_pack_timespec(&ctime));
>>>  	lvb->lvb_imtime_packed =
>>>  		cpu_to_be64(ocfs2_pack_timespec(&inode->i_mtime));
>>>  	lvb->lvb_iattr    = cpu_to_be32(oi->ip_attr);
>>> @@ -2208,6 +2209,7 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
>>>  	struct ocfs2_inode_info *oi = OCFS2_I(inode);
>>>  	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
>>>  	struct ocfs2_meta_lvb *lvb;
>>> +	struct timespec64 ctime;
>>>  
>>>  	mlog_meta_lvb(0, lockres);
>>>  
>>> @@ -2238,8 +2240,9 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
>>>  			      be64_to_cpu(lvb->lvb_iatime_packed));
>>>  	ocfs2_unpack_timespec(&inode->i_mtime,
>>>  			      be64_to_cpu(lvb->lvb_imtime_packed));
>>> -	ocfs2_unpack_timespec(&inode->i_ctime,
>>> +	ocfs2_unpack_timespec(&ctime,
>>>  			      be64_to_cpu(lvb->lvb_ictime_packed));
>>> +	inode_set_ctime_to_ts(inode, ctime);
>>
>> A quick glance, it seems not an equivalent replace.
>>
> 
> 
> How so?
> 
> The old code unpacked the time directly into the inode->i_ctime. The new
> one unpacks it into a local timespec64 variable and then sets the
> inode->i_ctime to that value. The result should still be the same.
> 
IC, it looks fine to me.

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

