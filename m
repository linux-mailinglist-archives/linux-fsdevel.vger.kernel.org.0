Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D74F3D3495
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhGWFmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 01:42:15 -0400
Received: from mail-eopbgr1310059.outbound.protection.outlook.com ([40.107.131.59]:24068
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233835AbhGWFmN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 01:42:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUUTwdd0nfgRXNj2w76szE/rlhyDxFLaXEhDd2Gw6masQhW8c0baAKveBA//sBgypCjq1UqUlUGm7RoMfmKFmaNg19Q8yIkD77JzD9RzFIYp0akAHpi2L9LAbCvcDPiSiWaR/oUTFlJWEU9bDbG2S+UvuW+ga16DaAhbtEGLW59F5ysDSiGuR8fGsXywu1VvBN4HZ8T4tmgBOLM+/hWVs7R0o7EqiI0kBW4pCKezu90UfPWlf1RTaZEyVQ7GTPaVp9kzCDuB9BnnVYUlEbttTiU+kpNN2x6USEM4OLOZdRdkOdzUwvzJQ/IAnLvTnIsfMmz5mx7YAZC++1I2QX5hig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5PIvRWzoCSp7aNYd+MHpYEL9D5GJ/iYdneovGsXhXk=;
 b=CZrzq1R6cE+kIk5qvlPO5vB9H6QwPilqg/koGUnlEA7I9m21t+iVQ04wplcX16hLwXZ02nfMX4PUQeJv11ZArpZ4/pniKADxqEurgu/1QIBkE7LLdpWvdfUxvQqGvc3D+RKGF5CskoAuhhTlbrxX0WOcF3BWRJY51yTmZ4FwuqYAz7g+oRLolugHWRoard0NfFyC/M6NaCV+L5N0s18tJtjfu/iSx9zpHrCtAOak+4lVpLCw9SNNw2qfSLdBhks4Oh7IoF26RkrH+AjZ3v+N7t4ah4qEayR9fx11ljzTzIZ7Mv7h4pUlZrPKp721eGU+fb45yrVAHYoWZgV6+m89QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5PIvRWzoCSp7aNYd+MHpYEL9D5GJ/iYdneovGsXhXk=;
 b=jdU/I5sNkY5g9cMJI76oKGw4cLeFATNnPl62HViTmrkto6WV+PMVb82fqCbWtLA/pkBI+pmOGHY0WhIQ8r4jsQw9vBckQ6Tra6C6rIDk69wbhJlraIBuIHAHnM28WIEG2k3EjYXp5UStHhItW0HFRFptweo25v91sRKsE0cOvH0=
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4105.apcprd02.prod.outlook.com (2603:1096:4:9d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.30; Fri, 23 Jul 2021 06:22:44 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4331.034; Fri, 23 Jul 2021
 06:22:44 +0000
Subject: Re: [PATCH v6] iomap: support tail packing inline read
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de> <20210722165109.GD8639@magnolia>
 <YPoa4x6d3giqq5z6@B-P7TQMD6M-0146.local>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
        "yh@oppo.com" <yh@oppo.com>, Weichao Guo <guoweichao@oppo.com>
From:   Huang Jianan <huangjianan@oppo.com>
Message-ID: <ecd277ac-c0a6-8451-de45-d6d1b1eb0dd4@oppo.com>
Date:   Fri, 23 Jul 2021 14:22:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YPoa4x6d3giqq5z6@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR03CA0033.apcprd03.prod.outlook.com
 (2603:1096:203:c9::20) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.252.5.73) by HKAPR03CA0033.apcprd03.prod.outlook.com (2603:1096:203:c9::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Fri, 23 Jul 2021 06:22:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73746ca8-d423-49d9-cee3-08d94da247df
X-MS-TrafficTypeDiagnostic: SG2PR02MB4105:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB41053A7AA31B3E4A0EE559F9C3E59@SG2PR02MB4105.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9Q+sRfOmtVcxt8/arydDVM/hM12IqcvXPBoOUVcmH4qneXryEc09QiwuIACZYymgAAnkSiV3TFHkU7fd5onyi/zmK2813dXlK0SVNs4PyNHn19QhJaQ+dS2/NAqTpfvZKYuoLY82VyFFDnJh4MvgHWoSacl01d71j/e2qY/4E2XZ4D48xUn5eflwJQetn8nj2yxhx68eMa/M3LgrTW7KfbgOC/y3DYD2M9m+SDleHyKF68JJOGbSZFIuvRVG4dlYCZYElG8YLPwryysS8auT2Pi3EEn9xFQ0dTrSm/XL51ML0u84RvwqmiuJNElEUCxE7OVfpvPDfwy2XUrd+yDqTwx/6UpIQa87w/XnEUyr3E3aHuk+HFkfpACSyS5i5DCytvVVH+TvnoQhCqd7PmAwIROuCqIET4Na8HuVYp7VeZa7Wa0Z+hAX9JLCoaOpttJFlWXXUF1n/mXcOIf6Yf8nkBLDKUxkIkdOqHMdyMh+eysNGY9cBzO/cBWT0TA3q7vlQwXE5myrtPA0JvBSoso0228nhAtgmD2324KTXjHSYmOORsj9IZnEtHOgdXIDwEtkGiNDuncCuOtvaloKvCt8RQqY8X2ONWWAmSRAPdk89gxAs5AZvWipDWRr5sDLwGQy5rBVnQwg+TSfZbIVi7XDvmidGnw47HJZu9tqP1DKuauowZkqR7Syr4EcPQ77Fdz/F46osMnm2dt5aBWORU7Ebg9Mp/niy2tYJIJiVkVJK/HgHy0eG69rtn0+L0klxoXKRtjS1i8xli/CgmOMYBUF5ruvtyYP00828Uc1SZZAlBjVH51i2L1k2GxUIj7B8O/GraZmMo2vIb1QQVnHxQ1aV88EAfkOxule9tofeT9QFd60DqsHAKt8/IjdENObyvf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(6916009)(478600001)(52116002)(16576012)(316002)(86362001)(8936002)(107886003)(8676002)(31686004)(6486002)(53546011)(83380400001)(5660300002)(956004)(2616005)(36756003)(66556008)(26005)(4326008)(66946007)(54906003)(186003)(966005)(2906002)(38350700002)(31696002)(66476007)(38100700002)(11606007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlVkaERRWUdONUloc3lpb2w2UklFb3o4TElwMVNPNlliQzI3NWVKOTE2U0Nt?=
 =?utf-8?B?Tm9MT2M3alhnY0VieU9IV1owLzExY2Nod2pYQTlZdmhPcjljUjRXL3hhc2VM?=
 =?utf-8?B?Tjk5WGRnWTdQemtJbkdyMHJHbTZTSFFpTWFhRHNkNW94cTJtUXowUzVFb09H?=
 =?utf-8?B?ODdlSXRPd3NJRDF0Tmg4Q0crWHpLc3Q5c2VDQUZ1SnpRemhCU24wbk1TUnV0?=
 =?utf-8?B?ajN4dC9VVGdWVEFxQTlTNGk1SHpCOTBiTGREa2dxOU8vS1BaRURvZ3ZxRFJX?=
 =?utf-8?B?d0dZVlpJWXFUYSsxbXl0c01yclpaSk04d3pLZVRnRnhFeTlLQTFFNmx5cFNj?=
 =?utf-8?B?MFNBWHAxanltcEs4enJKMnd0YlJYc1BML0lxamlsVVQ3aG0waDZHNjhYMmNt?=
 =?utf-8?B?TDlRQkpuYW9xQUhiMW5ZWEFYY0NCZFdGYWcxbDR6KzA5ZmZzbldDVXVSMmtE?=
 =?utf-8?B?VElYMFViNk9FV1ZhTjJrUFZlY2JzZytOOElIRDVGOW1oWEZ3SVNTV3h3YVJo?=
 =?utf-8?B?RXNqRk5RVVFmb3pGUTRrajJaV1dRRVFjU0dmUm81dEU0K0R2OFpBb2V3a3Zr?=
 =?utf-8?B?YjJWVGV2S3VuS215dmllNUVKRlprRWZnMTBMejdtQ1ZNcHZHL3Iwdkl4bHd4?=
 =?utf-8?B?NDFXVHBrc3JrTm1ZNzlGMkxOYTVZeFV1L3VkazlxQmtqQlFxN2ZCTFo1WVNQ?=
 =?utf-8?B?K21RT0hKNFY3ZFpnajZ6eTlhbmpJd1J0MHZoYURVYXo2M0RsSlptQkxYTmRr?=
 =?utf-8?B?SXZQY0g3WGsxbkpkVkpKbDhVQTMvUlJPM3VzTFpEeXg5RExldGc1Y2tQb3Ni?=
 =?utf-8?B?bTJ4eUlIVzAwWUdIZ1JRSzk2YWU1NWthaVpVY1I5WmhXWCsrb3NVQWt4YXlK?=
 =?utf-8?B?NCtuR25GckRGM0ZOR3NoUEZEM3VIY28rcU4wVjU0R204STJScFlOeFo3SmRq?=
 =?utf-8?B?bkFwb0p2aVNXb3lZU0ZrcnVUVGJCRjBvemdXdTBuQ1MrMjFrQWxLYUorNVFS?=
 =?utf-8?B?K3M1VkRHM0NCaEV5eE5SOS9VbGk5dVl4aU9rR2ZnY2tjNXliRno0OWoreS9K?=
 =?utf-8?B?NUhKUzFDSElPZ0cvVVBWSHV6RU1CNnZRZFk5djBiYmRJWWZzQ01oV05pK1dW?=
 =?utf-8?B?Q21IYjZjNU9mUlpDbThzTzBUUVRtSGd0ZG45YkRscVZNUmZSRDduVDhGRFI5?=
 =?utf-8?B?RUJsRTVQanNHQ1h5ZHJqYkFxaWhMSGhDVXBVeXZVV0JNVmxGUWhMamdYcTJO?=
 =?utf-8?B?U1pNTTFRQkU5Qy9ZOEpMVXQ5RzJnQzg5UGErdnNrZGFmWGtJdXFKeHBxd0hJ?=
 =?utf-8?B?WXU1b21CQnlTcVd2WTdhYXNWOTNHaTVVUlEzUnJ0eWIyQ2RLaWU5L2wzZnBF?=
 =?utf-8?B?SWJQTHhPdTJaWUp4aVA4YlF5cTBVNzltWVptc3FXeHZIeXpoM0hPTlllM0JB?=
 =?utf-8?B?SU0zWkorL2lidGVWRU5qTXNEZDh2RGVBcTRxSXI0T3p2Y0NpSG1UZTJ1WGZZ?=
 =?utf-8?B?cDNQUGxrOWVrb1JXYmxsUm1NbnhvSW9aTHZlaC9rMlJCbUQ0Zm43NjlUS0RN?=
 =?utf-8?B?T0ZIM2pETFMrcEJOWmZrVjc2dWJ1UzNPT0EvYjVzUUlRZW9xZHFjanRqaHpl?=
 =?utf-8?B?dEJtNkVtclppTDdwc2pSVDhLZEowRFFtYWRCaTlacm5VbHY4dTNkek5JOEdN?=
 =?utf-8?B?WXlYZXRPcXZ1YUN0TG10eTBlWmIzR2wxdTJ0cFo5N0oyZ1ViUGN6aTVHWkMz?=
 =?utf-8?Q?FFOtcFbz/wNX2fpElwE9MsnqPUowdx5nxjdVHZV?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73746ca8-d423-49d9-cee3-08d94da247df
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 06:22:43.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck10fn/kV5Ne31O8aBqqJnyYBB0JNQk5JYS4WAk3HPsAF7QgYURBNXAk/AFRFSPfoy5NLH8hCI7qqNZkltRwCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4105
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xiang,

I have tested this patch based on the erofs dax support below, It works 
well for me.

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/dax

Tested-by: Huang Jianan <huangjianan@oppo.com>

Thanks,

Jianan

On 2021/7/23 9:26, Gao Xiang wrote:
> Hi Darrick,
>
> On Thu, Jul 22, 2021 at 09:51:09AM -0700, Darrick J. Wong wrote:
>> On Thu, Jul 22, 2021 at 07:39:47AM +0200, Christoph Hellwig wrote:
>>> I think some of the language here is confusing - mostly about tail
>>> packing when we otherwise use inline data.  Can you take a look at
>>> the version below?  This mostly cleans up the terminology, adds a
>>> new helper to check the size, and removes the error on trying to
>>> write with a non-zero pos, as it can be trivially supported now.
>>>
>>> ---
>>>  From 0f9c6ac6c2e372739b29195d25bebb8dd87e583a Mon Sep 17 00:00:00 2001
>>> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> Date: Thu, 22 Jul 2021 11:17:29 +0800
>>> Subject: iomap: make inline data support more flexible
>>>
>>> Add support for offsets into the inline data page at iomap->inline_data
>>> to cater for the EROFS tailpackng case where a small data is stored
>>> right after the inode.
>> The commit message is a little misleading -- this adds support for
>> inline data pages at nonzero (but page-aligned) file offsets, not file
>> offsets into the page itself.  I suggest:
>>
>> "Add support for reading inline data content into the page cache from
>> nonzero page-aligned file offsets.  This enables the EROFS tailpacking
>> mode where the last few bytes of the file are stored right after the
>> inode."
>>
>> The code changes look good to me.
> Thanks for your suggestion. I've tested EROFS with no problem so far.
>
> I could update the commit message like this, what should I do next?
>
> Many thanks,
> Gao Xiang
>
>> --D
>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>>   fs/iomap/buffered-io.c | 35 ++++++++++++++++++-----------------
>>>   fs/iomap/direct-io.c   | 10 ++++++----
>>>   include/linux/iomap.h  | 14 ++++++++++++++
>>>   3 files changed, 38 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>>> index 87ccb3438becd9..0597f5c186a33f 100644
>>> --- a/fs/iomap/buffered-io.c
>>> +++ b/fs/iomap/buffered-io.c
>>> @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
>>>   	struct readahead_control *rac;
>>>   };
>>>   
>>> -static void
>>> -iomap_read_inline_data(struct inode *inode, struct page *page,
>>> -		struct iomap *iomap)
>>> +static int iomap_read_inline_data(struct inode *inode, struct page *page,
>>> +		struct iomap *iomap, loff_t pos)
>>>   {
>>> -	size_t size = i_size_read(inode);
>>> +	size_t size = iomap->length + iomap->offset - pos;
>>>   	void *addr;
>>>   
>>>   	if (PageUptodate(page))
>>> -		return;
>>> +		return PAGE_SIZE;
>>>   
>>> -	BUG_ON(page_has_private(page));
>>> -	BUG_ON(page->index);
>>> -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
>>> +	/* inline data must start page aligned in the file */
>>> +	if (WARN_ON_ONCE(offset_in_page(pos)))
>>> +		return -EIO;
>>> +	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
>>> +		return -EIO;
>>> +	if (WARN_ON_ONCE(page_has_private(page)))
>>> +		return -EIO;
>>>   
>>>   	addr = kmap_atomic(page);
>>> -	memcpy(addr, iomap->inline_data, size);
>>> +	memcpy(addr, iomap_inline_buf(iomap, pos), size);
>>>   	memset(addr + size, 0, PAGE_SIZE - size);
>>>   	kunmap_atomic(addr);
>>>   	SetPageUptodate(page);
>>> +	return PAGE_SIZE;
>>>   }
>>>   
>>>   static inline bool iomap_block_needs_zeroing(struct inode *inode,
>>> @@ -246,11 +250,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>>>   	unsigned poff, plen;
>>>   	sector_t sector;
>>>   
>>> -	if (iomap->type == IOMAP_INLINE) {
>>> -		WARN_ON_ONCE(pos);
>>> -		iomap_read_inline_data(inode, page, iomap);
>>> -		return PAGE_SIZE;
>>> -	}
>>> +	if (iomap->type == IOMAP_INLINE)
>>> +		return iomap_read_inline_data(inode, page, iomap, pos);
>>>   
>>>   	/* zero post-eof blocks as the page may be mapped */
>>>   	iop = iomap_page_create(inode, page);
>>> @@ -618,14 +619,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>>>   	}
>>>   
>>>   	if (srcmap->type == IOMAP_INLINE)
>>> -		iomap_read_inline_data(inode, page, srcmap);
>>> +		status = iomap_read_inline_data(inode, page, srcmap, pos);
>>>   	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>>>   		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>>>   	else
>>>   		status = __iomap_write_begin(inode, pos, len, flags, page,
>>>   				srcmap);
>>>   
>>> -	if (unlikely(status))
>>> +	if (unlikely(status < 0))
>>>   		goto out_unlock;
>>>   
>>>   	*pagep = page;
>>> @@ -675,7 +676,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>>>   
>>>   	flush_dcache_page(page);
>>>   	addr = kmap_atomic(page);
>>> -	memcpy(iomap->inline_data + pos, addr + pos, copied);
>>> +	memcpy(iomap_inline_buf(iomap, pos), addr + pos, copied);
>>>   	kunmap_atomic(addr);
>>>   
>>>   	mark_inode_dirty(inode);
>>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>>> index 9398b8c31323b3..a6aaea2764a55f 100644
>>> --- a/fs/iomap/direct-io.c
>>> +++ b/fs/iomap/direct-io.c
>>> @@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>>>   		struct iomap_dio *dio, struct iomap *iomap)
>>>   {
>>>   	struct iov_iter *iter = dio->submit.iter;
>>> +	void *dst = iomap_inline_buf(iomap, pos);
>>>   	size_t copied;
>>>   
>>> -	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
>>> +	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
>>> +		return -EIO;
>>>   
>>>   	if (dio->flags & IOMAP_DIO_WRITE) {
>>>   		loff_t size = inode->i_size;
>>>   
>>>   		if (pos > size)
>>> -			memset(iomap->inline_data + size, 0, pos - size);
>>> -		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
>>> +			memset(iomap_inline_buf(iomap, size), 0, pos - size);
>>> +		copied = copy_from_iter(dst, length, iter);
>>>   		if (copied) {
>>>   			if (pos + copied > size)
>>>   				i_size_write(inode, pos + copied);
>>>   			mark_inode_dirty(inode);
>>>   		}
>>>   	} else {
>>> -		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
>>> +		copied = copy_to_iter(dst, length, iter);
>>>   	}
>>>   	dio->size += copied;
>>>   	return copied;
>>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>>> index 479c1da3e2211e..5efae7153912ed 100644
>>> --- a/include/linux/iomap.h
>>> +++ b/include/linux/iomap.h
>>> @@ -97,6 +97,20 @@ iomap_sector(struct iomap *iomap, loff_t pos)
>>>   	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>>>   }
>>>   
>>> +static inline void *iomap_inline_buf(const struct iomap *iomap, loff_t pos)
>>> +{
>>> +	return iomap->inline_data - iomap->offset + pos;
>>> +}
>>> +
>>> +/*
>>> + * iomap->inline_data is a potentially kmapped page, ensure it never crosseѕ a
>>> + * page boundary.
>>> + */
>>> +static inline bool iomap_inline_data_size_valid(const struct iomap *iomap)
>>> +{
>>> +	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
>>> +}
>>> +
>>>   /*
>>>    * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
>>>    * and page_done will be called for each page written to.  This only applies to
>>> -- 
>>> 2.30.2
>>>
