Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4825867A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 05:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIADsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 23:48:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15047 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725987AbgIADs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:48:29 -0400
X-IronPort-AV: E=Sophos;i="5.76,377,1592841600"; 
   d="scan'208";a="98758136"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Sep 2020 11:48:26 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A5F2F48990DB;
        Tue,  1 Sep 2020 11:48:23 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 1 Sep 2020 11:48:22 +0800
Subject: Re: [PATCH] fs: Handle I_DONTCACHE in iput_final() instead of
 generic_drop_inode()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <y-goto@fujitsu.com>
References: <20200831101313.168889-1-lihao2018.fnst@cn.fujitsu.com>
 <20200831171257.GF1422350@iweiny-DESK2.sc.intel.com>
From:   "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
Message-ID: <db5d145a-3b63-48db-6bd2-eb1d91323697@cn.fujitsu.com>
Date:   Tue, 1 Sep 2020 11:48:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200831171257.GF1422350@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: A5F2F48990DB.ADBB7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/9/1 1:12, Ira Weiny wrote:
> On Mon, Aug 31, 2020 at 06:13:13PM +0800, Hao Li wrote:
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
>> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
>
> Thanks!  I think this looks good, but shouldn't we add?  It seems like this is
> a bug right?
>
> Fixes: dae2f8ed7992 ("fs: Lift XFS_IDONTCACHE to the VFS layer")

Yeah, this is more meaningful.

I'm not sure if I need to submit a v2 patch, or this tag will be added
by the maintainer when applying this patch. I have no experience with
this before. Thanks!

Regards,
Hao Li

>
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>
>> ---
>>  fs/inode.c         | 3 ++-
>>  include/linux/fs.h | 3 +--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/inode.c b/fs/inode.c
>> index 72c4c347afb7..4e45d5ea3d0f 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -1625,7 +1625,8 @@ static void iput_final(struct inode *inode)
>>      else
>>          drop = generic_drop_inode(inode);
>>  
>> -    if (!drop && (sb->s_flags & SB_ACTIVE)) {
>> +    if (!drop && !(inode->i_state & I_DONTCACHE) &&
>> +            (sb->s_flags & SB_ACTIVE)) {
>>          inode_add_lru(inode);
>>          spin_unlock(&inode->i_lock);
>>          return;
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index e019ea2f1347..93caee80ce47 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2922,8 +2922,7 @@ extern int inode_needs_sync(struct inode *inode);
>>  extern int generic_delete_inode(struct inode *inode);
>>  static inline int generic_drop_inode(struct inode *inode)
>>  {
>> -    return !inode->i_nlink || inode_unhashed(inode) ||
>> -        (inode->i_state & I_DONTCACHE);
>> +    return !inode->i_nlink || inode_unhashed(inode);
>>  }
>>  extern void d_mark_dontcache(struct inode *inode);
>>  
>> --
>> 2.28.0
>>
>>
>>
>
>



