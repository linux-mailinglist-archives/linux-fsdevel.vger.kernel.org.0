Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3825D23B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 09:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgIDHSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 03:18:05 -0400
Received: from song.cn.fujitsu.com ([218.97.8.244]:1711 "EHLO
        song.cn.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDHSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:18:03 -0400
X-Greylist: delayed 622 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2020 03:18:00 EDT
X-IronPort-AV: E=Sophos;i="5.76,388,1592841600"; 
   d="scan'208";a="4857635"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.250.3])
  by song.cn.fujitsu.com with ESMTP; 04 Sep 2020 15:07:35 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 6564543DC18E;
        Fri,  4 Sep 2020 15:07:31 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 4 Sep 2020 15:07:30 +0800
Subject: Re: [PATCH] fs: Handle I_DONTCACHE in iput_final() instead of
 generic_drop_inode()
To:     Dave Chinner <david@fromorbit.com>
CC:     <viro@zeniv.linux.org.uk>, <ira.weiny@intel.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <y-goto@fujitsu.com>
References: <20200831101313.168889-1-lihao2018.fnst@cn.fujitsu.com>
 <20200903215832.GF12131@dread.disaster.area>
From:   "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
Message-ID: <025cd000-48c7-7cd2-5b89-f76d1b44079a@cn.fujitsu.com>
Date:   Fri, 4 Sep 2020 15:07:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
MIME-Version: 1.0
In-Reply-To: <20200903215832.GF12131@dread.disaster.area>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 6564543DC18E.AC4DE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/9/4 5:58, Dave Chinner wrote:
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
>
> FWIW, the format used in fs/inode.c is to align the logic
> statements, not tab indent the additional lines in the statement.
> i.e.
>
>     if (!drop &&
>         !(inode->i_state & I_DONTCACHE) &&
>         (sb->s_flags & SB_ACTIVE)) {
>
> Which gives a clear indication that there are all at the same
> precedence and separate logic statements...
>
> Otherwise the change looks good.
>
> Probably best to resend with the fixes tag :)

Got it! Thanks.

>
>
> Cheers,
>
> Dave.



