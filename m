Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9F9296A9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 09:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375913AbgJWHuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 03:50:09 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8343 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S375898AbgJWHuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:50:08 -0400
X-IronPort-AV: E=Sophos;i="5.77,407,1596470400"; 
   d="scan'208";a="100439341"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Oct 2020 15:50:01 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9C9E14CE1A07;
        Fri, 23 Oct 2020 15:50:00 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 23 Oct 2020 15:50:00 +0800
Subject: Re: [PATCH v2] fs: Handle I_DONTCACHE in iput_final() instead of
 generic_drop_inode()
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>, <linux-xfs@vger.kernel.org>,
        <y-goto@fujitsu.com>, "Ira Weiny" <ira.weiny@intel.com>
References: <20200904075939.176366-1-lihao2018.fnst@cn.fujitsu.com>
 <20200908230331.GF1930795@iweiny-DESK2.sc.intel.com>
From:   "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
Message-ID: <f1d1a56f-caec-3c68-6c70-1b6f995cab95@cn.fujitsu.com>
Date:   Fri, 23 Oct 2020 15:49:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20200908230331.GF1930795@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 9C9E14CE1A07.AB7FC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Ping.

This patch need to be merged... Thanks.

On 2020/9/9 7:03, Ira Weiny wrote:
> On Fri, Sep 04, 2020 at 03:59:39PM +0800, Hao Li wrote:
>> If generic_drop_inode() returns true, it means iput_final() can evict
>> this inode regardless of whether it is dirty or not. If we check
>> I_DONTCACHE in generic_drop_inode(), any inode with this bit set will be
>> evicted unconditionally. This is not the desired behavior because
>> I_DONTCACHE only means the inode shouldn't be cached on the LRU list.
>> As for whether we need to evict this inode, this is what
>> generic_drop_inode() should do. This patch corrects the usage of
>> I_DONTCACHE.
>>
>> This patch was proposed in [1].
>>
>> [1]: https://lore.kernel.org/linux-fsdevel/20200831003407.GE12096@dread.disaster.area/
>>
>> Fixes: dae2f8ed7992 ("fs: Lift XFS_IDONTCACHE to the VFS layer")
>> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>
>> ---
>> Changes in v2:
>>  - Adjust code format
>>  - Add Fixes tag in commit message
>>
>>  fs/inode.c         | 4 +++-
>>  include/linux/fs.h | 3 +--
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/inode.c b/fs/inode.c
>> index 72c4c347afb7..19ad823f781c 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -1625,7 +1625,9 @@ static void iput_final(struct inode *inode)
>>  	else
>>  		drop = generic_drop_inode(inode);
>>  
>> -	if (!drop && (sb->s_flags & SB_ACTIVE)) {
>> +	if (!drop &&
>> +	    !(inode->i_state & I_DONTCACHE) &&
>> +	    (sb->s_flags & SB_ACTIVE)) {
>>  		inode_add_lru(inode);
>>  		spin_unlock(&inode->i_lock);
>>  		return;
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index e019ea2f1347..93caee80ce47 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2922,8 +2922,7 @@ extern int inode_needs_sync(struct inode *inode);
>>  extern int generic_delete_inode(struct inode *inode);
>>  static inline int generic_drop_inode(struct inode *inode)
>>  {
>> -	return !inode->i_nlink || inode_unhashed(inode) ||
>> -		(inode->i_state & I_DONTCACHE);
>> +	return !inode->i_nlink || inode_unhashed(inode);
>>  }
>>  extern void d_mark_dontcache(struct inode *inode);
>>  
>> -- 
>> 2.28.0
>>
>>
>>
>


