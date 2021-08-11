Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4477D3E9AB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhHKWHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 18:07:46 -0400
Received: from mail-mw2nam08on2043.outbound.protection.outlook.com ([40.107.101.43]:45920
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232166AbhHKWHo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:07:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nq4GUO2vzS6L1xPMcX9sRHKTUAzXjbJyWsNGl3Nn+mbUM0FgwsfLpjQPBzmJmQagbm/5mzjNeryHs5afLUmgrO6vOCvw38doo5WRNwFO7khxIm31H+Do4JLFsmOzkhz8Hbf2TbMTuelhKEaYxWP+vxABXuKUQsxtgE+uvNof+iwDwfroClLK8BXerKvboOUVxtLrcxiZ+QqLV9BzIE4XtsjV9COdFTUoGRT4wsR1KSK+eavb5sXouqOLmIW1GlEWCIy1s480BdeefqOQe386PRKGjXn9AOK4wTPVhdAH8ipxrZ4bHnsiuRocC/WhR+fi1zcqvOqYreJo/I0+yTOd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPtd9GdA9BGX4eJNRUe7Te03gIl0ZBct1vPwWtXSqgM=;
 b=d9LL9g0/I9Yk5p5FUi5lQvVturo1KQoP8H4wFXNSfa//zwcX9/EPrH2zIfi7YBMsZL5PriW2kZteyysBq/D9vbXEGIpI/q6QZNDDnnj0Ih60WghPMO95P/MPYWOghwr+V7PWrz6TJCk4BQi2rX6Eevw6xuy8dIXzrS8LX12HDi+l63zuS5LSyicoO2s6Kp9ZVpM7Z2KZy1MBwcZ0a6zAcRSlr+B+gDJA1faYlBBiqs66d2S1+yFjgxmyGHo5xk0tfy28DgjzPMS8qcdGOwu0V0HSpPh6NF9FnChXA/k8CB1esJpek0OgjZh5u9hyBxoL3B2bXXhvzyh9qk5Lp1tlrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPtd9GdA9BGX4eJNRUe7Te03gIl0ZBct1vPwWtXSqgM=;
 b=CJnMluM6r4K0yNk7IeU7TOwnaxP3swd6ypWR6h5G7nLyncE7BnJoNpzy6gcWAfYgiv/3/2pez6RVlhfvwcmwWcwrEse1S124rwbOAaj/Mbuabr4/C+t6Gaiu+va2SzOSXNZ8+Z0XCvbDnFrUcDadiUuiRIVUdHbzUi4QfDuzZSsihOUTsPuwJLh7nDLFSjh4tNQiFjOnhm+dzs4Zgio0Nrvd9F4JdC9IYJ3wUeJdbV1db5+HKxn8nuy3yhSDpe5HdPsA3OrWNSDmhWTWwqk1geewqNbs3Ti6yHN658cmKKtwfsvhZP8T9Mes5Ugu97jk969oLsMpqv5Boi57AtwNkg==
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 22:07:18 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::aa) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Wed, 11 Aug 2021 22:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 22:07:17 +0000
Received: from [10.2.53.40] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Aug
 2021 22:07:16 +0000
Subject: Re: [PATCH v2 3/3] mm/gup: Remove try_get_page(), call
 try_get_compound_head() directly
To:     William Kucharski <william.kucharski@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20210811070542.3403116-1-jhubbard@nvidia.com>
 <20210811070542.3403116-4-jhubbard@nvidia.com>
 <20FB1F52-61FB-47DB-8777-E7C880FD875E@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0253d7e6-8377-a197-f131-e73249d8dbe8@nvidia.com>
Date:   Wed, 11 Aug 2021 15:07:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20FB1F52-61FB-47DB-8777-E7C880FD875E@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9add5cbe-1c8a-4910-f1c4-08d95d146204
X-MS-TrafficTypeDiagnostic: BN9PR12MB5226:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5226A9CC6F909F3CD41447D7A8F89@BN9PR12MB5226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n08xSfEyWSMyUWsk9bgzauXud3th0zHq7pIHtq6oLocRjBWGl5DpCL9KibVv9QtuivsXVgG7+9cXwkVTTE3SmBPBt0hcDTpdUe6L/5iAzv2j7kCyguX1cWyR8+y16Ai7lLJWxLaKRXYwQ2RqXQWp2+NTXLd+sf4MSuWDrQDW60fMWdGD3M5PowZ0CuqRiIGz8Hhv3EFbPYmn79UTS/VYhPyh+vmHKPWIQ9vKz9e2/3e+rtCfq9O4D/mnwTWD2+bqPjIiXFxLENUxt4JbvcV59HnYkWKY9gCNK6HQlihP39sHvlt5X9WCLZTpRxnyNf+vtP/7ss7h9UcepslWFp7QuP9VpLUo1fOCNPyVXO2kNp8e4ogYRWnYLdabAHtScpIDtzypeASEe+mHGaMf3cK5eKLyTPSoYx9qhrlssJxZuxwXsbysgUySsL5V8Y/4n8KDYWLcm+XMNLuob7y7zp2ml0rvzF64314amu32MztcewU0NH6xohB+DuHzjYTOZmvDHWon1P5VEyqEnL07tsueqGGoWBBrNo1YrpJjOLHbz5X4kVCHkx8imVD+7orZ1qO8TJElROy/mn6yTennAKJmCnTY5uKkdzNSSaRlI/RkRSUNw2l1UYz/0jt9FfDzXU/vyCKxrQ51oolM+UH1BVbCKPXU5Oz95e8erPM9VD/GBy6g45iweYt3azJSgaZRxQcJFFFzpQTyKPBLIDbVTv6T5P86wSCHkG04YGpJo+wc4Y8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(86362001)(31696002)(2906002)(82740400003)(16526019)(54906003)(316002)(186003)(83380400001)(478600001)(26005)(2616005)(8936002)(70206006)(82310400003)(8676002)(47076005)(36906005)(70586007)(336012)(6916009)(36756003)(7416002)(7636003)(4326008)(53546011)(5660300002)(31686004)(36860700001)(16576012)(356005)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 22:07:17.3836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9add5cbe-1c8a-4910-f1c4-08d95d146204
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/21 1:35 PM, William Kucharski wrote:
> I agree that try_get_page() should probably be removed entirely; is there
> a reason you didn't in v2 of the patch?

Hi William,

This patch *does* remove try_get_page() entirely! Look below. I'll reply
inline, below, to show where that happens.

> 
> I'm also curious why you changed try_get_compound_head() into a routine
> from an inline.

It was part of the change to make it available to callers outside of
gup.c. try_get_compound_head() is slightly messy and doesn't like to
live in mm.h, because it calls page_cache_add_speculative(), which lives
in linux-pagemap.h, which, in turn, has its own set of different headers
that it pulls in.

So, leaving it in gup.c, and exposing it to the other callers as a
non-static function, seemed appropriate here.

> 
> If you want to retain try_get_page() it should be an inline as well, especially
> in its current implementation.
> 
>      William Kucharski
> 
>> On Aug 11, 2021, at 1:05 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> try_get_page() is very similar to try_get_compound_head(), and in fact
>> try_get_page() has fallen a little behind in terms of maintenance:
>> try_get_compound_head() handles speculative page references more
>> thoroughly.
>>
>> There are only two try_get_page() callsites, so just call
>> try_get_compound_head() directly from those, and remove try_get_page()
>> entirely.
>>
>> Also, seeing as how this changes try_get_compound_head() into a
>> non-static function, provide some kerneldoc documentation for it.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>> arch/s390/mm/fault.c |  2 +-
>> fs/pipe.c            |  2 +-
>> include/linux/mm.h   | 10 +---------
>> mm/gup.c             | 21 +++++++++++++++++----
>> 4 files changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
>> index 212632d57db9..fe1d2c1dbe3b 100644
>> --- a/arch/s390/mm/fault.c
>> +++ b/arch/s390/mm/fault.c
>> @@ -822,7 +822,7 @@ void do_secure_storage_access(struct pt_regs *regs)
>> 		break;
>> 	case KERNEL_FAULT:
>> 		page = phys_to_page(addr);
>> -		if (unlikely(!try_get_page(page)))
>> +		if (unlikely(try_get_compound_head(page, 1) == NULL))
>> 			break;
>> 		rc = arch_make_page_accessible(page);
>> 		put_page(page);
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index 8e6ef62aeb1c..06ba9df37410 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -191,7 +191,7 @@ EXPORT_SYMBOL(generic_pipe_buf_try_steal);
>>   */
>> bool generic_pipe_buf_get(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
>> {
>> -	return try_get_page(buf->page);
>> +	return try_get_compound_head(buf->page, 1) != NULL;
>> }
>> EXPORT_SYMBOL(generic_pipe_buf_get);
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index ce8fc0fd6d6e..cd00d1222235 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1207,15 +1207,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags);
>> __maybe_unused struct page *try_grab_compound_head(struct page *page, int refs,
>> 						   unsigned int flags);
>>
>> -
>> -static inline __must_check bool try_get_page(struct page *page)
>> -{
>> -	page = compound_head(page);
>> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>> -		return false;
>> -	page_ref_inc(page);
>> -	return true;
>> -}

This is where try_get_page() is removed entirely.

thanks,
-- 
John Hubbard
NVIDIA


>> +struct page *try_get_compound_head(struct page *page, int refs);
>>
>> /**
>>   * folio_put - Decrement the reference count on a folio.
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 64798d6b5043..c2d19d370c99 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -62,11 +62,24 @@ static void put_page_refs(struct page *page, int refs)
>> 	put_page(page);
>> }
>>
>> -/*
>> - * Return the compound head page with ref appropriately incremented,
>> - * or NULL if that failed.
>> +/**
>> + * try_get_compound_head() - return the compound head page with refcount
>> + * appropriately incremented, or NULL if that failed.
>> + *
>> + * This handles potential refcount overflow correctly. It also works correctly
>> + * for various lockless get_user_pages()-related callers, due to the use of
>> + * page_cache_add_speculative().
>> + *
>> + * Even though the name includes "compound_head", this function is still
>> + * appropriate for callers that have a non-compound @page to get.
>> + *
>> + * @page:  pointer to page to be gotten
>> + * @refs:  the value to add to the page's refcount
>> + *
>> + * Return: head page (with refcount appropriately incremented) for success, or
>> + * NULL upon failure.
>>   */
>> -static inline struct page *try_get_compound_head(struct page *page, int refs)
>> +struct page *try_get_compound_head(struct page *page, int refs)
>> {
>> 	struct page *head = compound_head(page);
>>
>> -- 
>> 2.32.0
>>
>>
> 
> 
