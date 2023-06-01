Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC347195DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 10:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjFAInp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 04:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFAInn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:43:43 -0400
Received: from out-42.mta1.migadu.com (out-42.mta1.migadu.com [IPv6:2001:41d0:203:375::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D269F
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 01:43:41 -0700 (PDT)
Message-ID: <b85c0d63-f6a5-73c4-e574-163b0b07d80a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685609019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GrV1KM3/y3S5hBdJqzM74vPmzXw6kimHKx1fZTZGaeI=;
        b=D81vOtJuXcfgtNau4PafJgR+tR3LuhpfN/OgTKmkEmM+eZZJnb+fqBG1j2aMobjbEuGL/h
        bnnqxNLO7ovuGmBZAWSKGlfQ1ZrgInPMLp7O4m8wvHw5mM2vXYwnHDdUwuTRZHp32SWOW/
        0esYzjRYjctiv6T19eWTOTn0tmnh7eQ=
Date:   Thu, 1 Jun 2023 16:43:32 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 6/8] xfs: introduce xfs_fs_destroy_super()
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-7-qi.zheng@linux.dev>
 <ZHfc3V4KKmW8QTR2@dread.disaster.area>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <ZHfc3V4KKmW8QTR2@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On 2023/6/1 07:48, Dave Chinner wrote:
> On Wed, May 31, 2023 at 09:57:40AM +0000, Qi Zheng wrote:
>> From: Kirill Tkhai <tkhai@ya.ru>
>>
>> xfs_fs_nr_cached_objects() touches sb->s_fs_info,
>> and this patch makes it to be destructed later.
>>
>> After this patch xfs_fs_nr_cached_objects() is safe
>> for splitting unregister_shrinker(): mp->m_perag_tree
>> is stable till destroy_super_work(), while iteration
>> over it is already RCU-protected by internal XFS
>> business.
>>
>> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   fs/xfs/xfs_super.c | 25 ++++++++++++++++++++++---
>>   1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 7e706255f165..694616524c76 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -743,11 +743,18 @@ xfs_fs_drop_inode(
>>   }
>>   
>>   static void
>> -xfs_mount_free(
>> +xfs_free_names(
>>   	struct xfs_mount	*mp)
>>   {
>>   	kfree(mp->m_rtname);
>>   	kfree(mp->m_logname);
>> +}
>> +
>> +static void
>> +xfs_mount_free(
>> +	struct xfs_mount	*mp)
>> +{
>> +	xfs_free_names(mp);
>>   	kmem_free(mp);
>>   }
>>   
>> @@ -1136,8 +1143,19 @@ xfs_fs_put_super(
>>   	xfs_destroy_mount_workqueues(mp);
>>   	xfs_close_devices(mp);
>>   
>> -	sb->s_fs_info = NULL;
>> -	xfs_mount_free(mp);
>> +	xfs_free_names(mp);
>> +}
>> +
>> +static void
>> +xfs_fs_destroy_super(
>> +	struct super_block	*sb)
>> +{
>> +	if (sb->s_fs_info) {
>> +		struct xfs_mount	*mp = XFS_M(sb);
>> +
>> +		kmem_free(mp);
>> +		sb->s_fs_info = NULL;
>> +	}
>>   }
>>   
>>   static long
>> @@ -1165,6 +1183,7 @@ static const struct super_operations xfs_super_operations = {
>>   	.dirty_inode		= xfs_fs_dirty_inode,
>>   	.drop_inode		= xfs_fs_drop_inode,
>>   	.put_super		= xfs_fs_put_super,
>> +	.destroy_super		= xfs_fs_destroy_super,
>>   	.sync_fs		= xfs_fs_sync_fs,
>>   	.freeze_fs		= xfs_fs_freeze,
>>   	.unfreeze_fs		= xfs_fs_unfreeze,
> 
> I don't really like this ->destroy_super() callback, especially as
> it's completely undocumented as to why it exists. This is purely a
> work-around for handling extended filesystem superblock shrinker
> functionality, yet there's nothing that tells the reader this.
> 
> It also seems to imply that the superblock shrinker can continue to
> run after the existing unregister_shrinker() call before ->kill_sb()
> is called. This violates the assumption made in filesystems that the
> superblock shrinkers have been stopped and will never run again
> before ->kill_sb() is called. Hence ->kill_sb() implementations
> assume there is nothing else accessing filesystem owned structures
> and it can tear down internal structures safely.
> 
> Realistically, the days of XFS using this superblock shrinker
> extension are numbered. We've got a lot of the infrastructure we
> need in place to get rid of the background inode reclaim
> infrastructure that requires this shrinker extension, and it's on my
> list of things that need to be addressed in the near future.
> 
> In fact, now that I look at it, I think the shmem usage of this
> superblock shrinker interface is broken - it returns SHRINK_STOP to
> ->free_cached_objects(), but the only valid return value is the
> number of objects freed (i.e. 0 is nothing freed). These special
> superblock extension interfaces do not work like a normal
> shrinker....
> 
> Hence I think the shmem usage should be replaced with an separate
> internal shmem shrinker that is managed by the filesystem itself
> (similar to how XFS has multiple internal shrinkers).
> 
> At this point, then the only user of this interface is (again) XFS.
> Given this, adding new VFS methods for a single filesystem
> for functionality that is planned to be removed is probably not the
> best approach to solving the problem.

Thanks for such a detailed analysis. Kirill Tkhai just proposeed a
new method[1], I cc'd you on the email.

[1]. 
https://lore.kernel.org/lkml/bab60fe4-964c-43a6-ecce-4cbd4981d875@ya.ru/

Thanks,
Qi

> 
> Cheers,
> 
> Dave.

