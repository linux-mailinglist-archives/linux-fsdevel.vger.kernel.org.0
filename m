Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6E679150
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 07:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjAXGzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 01:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAXGzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:55:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D8C36FC7;
        Mon, 23 Jan 2023 22:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUYuUtl8x0ITEKMZjbh5vYXXkyrlWD8QQwKb4Zgijc2qwaUk/ALmuA52gZhcq1PpPN8ogBXle+box4K9t1es4fDFDPVZ2sRWTRCwnOPM0F2hBglKu8frqFF04tpGKfY2MlCxTPe2HXSnS/wyt0/VuKt+OeiH0IdY51hYu0w6drh1yzCEc1HeEbBxISUg8f2ikjnEEA59pu5VPQvLkuNGz3HLfRSoO9nl0VhUhZVrHO11NDfS5sVgsNLUEQ7ldAOeGbTFhtw9+tUAo+hQ/jR0qY5iKpeqU5IKng4pY0eWknlKoBq2bltFKorbSBUqFcMvMAkLBgsc5r/snVEW1UZzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6mzUoJiYnDJPELUB2/QCIKoOtFpVnWrS6k/kasKn0g=;
 b=bvLZxSCZ4axx0dSbhHT4FQs9Eq5q38MHKWn+3vP1RHwrdwDFY1x/RtjP/veyeaROG+kH0CWEmz2mAiBLA451Yb90xDt5QCmWicwV99/Izvg8c4LE2H1cPfd6Ybo+CZYsjY2guOOYYgNOpzpWJO4bMCYagXM2+SyKQr4AIrbC4HpHUbNNEXrrTTsb6Z2+7YtfRXrDmqSZhZ0fXfa3cJMOqvXt+CMokxi8zp3ZINrYnSh+LObhB9xatK0SSMqIv1RUhcHI3Ij7fdxZCFv3Ud/3EY5GoEuZ9BEuuwFyGQ/KZJWtq1N6JQKCktIr70Tdq67WnYPFqyQQm+M/i3Fc6MrDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6mzUoJiYnDJPELUB2/QCIKoOtFpVnWrS6k/kasKn0g=;
 b=cbuoSVs7gEnRIqIqVvdkBbtcfS4gXh7hKQPSbg7tjgo4n+lnIx22hPTLb2cZ8CrkSLjuS7OdB+BZfQA8Gb+gJCr2rcx5dckdlIRRZJZruMpm8Ebl4qLb3Ik8IFzmWuX/Cq4M3KFpAYpAQPfG0cG0xfPzFNxjEQeLMo7GPjx/t9FowZF43fWqj7iheTtc3YbPmkkw6PteZbjqTbDcX9wNNmRpF6z8ywgjXonczE66QeOgpbIGZ6nRQt0eYeZCiK2RVwd5KktjByh9c3+ckYh9W1pCDpYgjpjhjTbvQ9odWh/ZQVR7Ys5in5jOPVo61HsfBp8WjSo2PixBScqjw0/xHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 06:55:35 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::7895:c4d1:27d2:5b0a]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::7895:c4d1:27d2:5b0a%9]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 06:55:35 +0000
Message-ID: <b30ba310-2099-71a4-dc1d-67624d4635b5@nvidia.com>
Date:   Mon, 23 Jan 2023 22:55:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
References: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
 <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <3911637.1674481111@warthog.procyon.org.uk>
 <20230123161114.4jv6hnnbckqyrurs@quack3>
 <c3e0b810-9f17-edb7-de6b-7849273381d0@nvidia.com>
 <Y89zZofd63LCZYcG@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y89zZofd63LCZYcG@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: faaf99a9-497b-4797-dd71-08dafdd7fdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeqnAwnfbnzYNeNNb6ckOx+dzEVjkQUxUvC5WE35C2odakhrGhyXwPQq/9jEW0Lxygx16ChA+/porHKqoeEfINqGJT71E6XZdGbxck7tfv7AbD/0jO+URw6TX6k4HNghQPCnVZN1Rm4mccJWz7mhKZrx0W2CJaRGxo6Q2R0nwBlSvnU4/tAkt9StsSN4SpP+0BBNKboLM23CPtS0Q2I8jI8CbtqFo6WAFmLVcneSIFwBY+A1W22zJ6VDvhkaoNgwb3HlLfvWBZ2CwnhshTT4IxnenwvoFwqVvRvTcT3cO4Dzzv5zOWzWSSNTYy+NOinwhHwAR3L4YFfaljka5HLv47npx4SApi3GI9+QOdhIzutR7mprei9oavPIsEIMD8dwp6Bm0ahj5EcBzP1qfdbmh9cNQ/yzCaiuQXAuVPDt0jKyn5r/QUy0uBNZuRKrRD5WQnTNV4m3ayvFkelzQD5K1D6HNvXwZsYsA+HREczPB4AZzZUggzjl7K2q3W67eet7bp1l7DFqFcv8TTjyBToBRfSs0TdSf2MOLf0gJ1uioBOGHhSoFupBpPRwT+3vhafVnW2ia3d3DD5fPcoq2z9y5qkbh+4Mht45PcvUh6rCEPRPAuouNWNrT4O2WlFjc+uld72QOD9DxkM+FHYTHWu76WhqKEgxR9uBWy5HKWmgRK3FpPMefs5xHxXQD0n6LYEnbGKM/iHV7Mso69Ct2XgoSrYmMYxOovzSbzeoEk1Wios=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(66476007)(66946007)(86362001)(66556008)(8676002)(6916009)(4326008)(54906003)(53546011)(36756003)(316002)(6506007)(26005)(186003)(6512007)(6486002)(478600001)(2616005)(31686004)(8936002)(5660300002)(7416002)(31696002)(41300700001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHA4UVNPVnl3Nk96alhIckhvMHlFZ3hmOXVwQmNyS2d2YXR1T3dLcjYydDFT?=
 =?utf-8?B?VjJ0UTJFYnBtdFE3c2dxei9FNXl6ZkFURGxpS0dFV3VHb2hlT2ZBTHB3UUl1?=
 =?utf-8?B?a3lBd1hIWUtjTWVxd2ROUVlGeEtqWXpiL2I5U2hUdVhkUFM3QlVGTHFMRVJG?=
 =?utf-8?B?UTU3c0l5ZFlUOVVLaFFaekNvakFsdXhFazVVSnNQT3hWWlh2a1RxRTl2NWl1?=
 =?utf-8?B?M2lhaldTUVJudUwzZ2JaY0NuNGZDZmgxRDhURDY4U0dlcmJCODlST1RXYWRP?=
 =?utf-8?B?VnEwS25NT1NELy9zV0ZoSG9zb3ZoL2tmdzZJNnoxZ2VkejBnTW9lNzhRTHhr?=
 =?utf-8?B?NDJPNUxyb05wUFcyRXFvZVlRNlMyN20zTnlQb093WUw3NlV2VjFUNlhESXlS?=
 =?utf-8?B?Rmk4djU3d3A0QWpHN050bnM2WjkyUjJkd2U3dVEvaDhNV3JiVUlWcE1ZU0xZ?=
 =?utf-8?B?eWQyUTk4MHFOS0RaaEFST2dvS0JIY1JVVVdCYmhhUWphRjhqeDd0aHk2aEtB?=
 =?utf-8?B?eE1xV2tLQlY4YTllbHZzRDVaUTg4ZHRBYmh0bFN2aVVMYnd5UDBzZkMycVNE?=
 =?utf-8?B?bjZGWjBjUy8xMUl6SjE1OEhVSk9YbGRsQWo4elkweFZ2MHZCK1VPd2JVZzl5?=
 =?utf-8?B?djJKZWpvTFltSk45eGh5YzZ3QmxPeWJ6eDhEWjMzTjZOM0dwUzZQY25qL2Rx?=
 =?utf-8?B?RVBuWkhMTCtnVkpWZ3k3UmpIaTZtZ0kzazFpNXBxSlR5eU40TnVXK1ZCNjFZ?=
 =?utf-8?B?bUI1eVJKaWhLaGFkV2IrR3NoQU1zMHJ0MTAxaktCT1l6c0pLYWhGZGxIZ3BT?=
 =?utf-8?B?MW16ZDh0N3h5QW9rL0hCbXh3eFlGa2RBT2liS0RRcjR0MWd6S3dCcmZ4SVNG?=
 =?utf-8?B?RkRDMGpDVUIxSVpFNkhBNXN3NkdNSG52Y28yOGtPU1IxeEdKaEYvZGtFT0F0?=
 =?utf-8?B?NmZwczZyNzRzK1AzdTRhUy9QQUdhaEF5M3dPNTB0N1Q2OXlzWnRDV3BveW1i?=
 =?utf-8?B?dnU3K3lnQUJqSkRHK09WWkc5MlZ0UFN2Si8rWXFpczYvUU1DbXlDVTAxMkJl?=
 =?utf-8?B?dEp4VFRXMnExSUVzd1lvaXR3VjdNcno5RDFydkFGemU4YmZ3V0VkU0U1bDF3?=
 =?utf-8?B?REhSUUVZMUJEb1MvOE9VTmRXZ0NZa0gxNHI0MnVjNW5YbXlsMVBrY29zVy9D?=
 =?utf-8?B?UGlhQW1iVmFrVnFiTDZtaVNjZWxibFM2a0V1d1RrNG9YMnBEUCs2UUJiRG0x?=
 =?utf-8?B?a2FPdUkrMldwTTI1ZW1FaFRyMWsvR3dHb1ZnODBwVEZaWEhpRGNQSHZ3UFpW?=
 =?utf-8?B?UzVPTm5HcGUvSUFMOUhyNFlWbktiOFduQW1sbnJ5NTRFZWlqYk1XdCtnQm9l?=
 =?utf-8?B?ZVI5bDdZekNZY1JKTWtERm12QlRWWlFyUEhyZk5BV0I1WkR3dVpmU3BiVWs2?=
 =?utf-8?B?bmRUWmpNZG9qU0pvSENJdGkrelR4MUVMb3BmdUYwODF2cjl1UllLZE5CZVVr?=
 =?utf-8?B?M01EKzltZEhzTjlUblZnR2VaSno4VzZwbHljT0JUdVViRGYvWUVoTDloaHJE?=
 =?utf-8?B?Q21Sc0YrOUtGVVFTT0VYS3Y5bFFrWUVkVHFEN0ZOZmhYa1JYeFJlWDFKNkRE?=
 =?utf-8?B?MjR4Z3dKYkM0MFNmWUVUWWo3aDA3cytjV2hHZjlMQi9jSW0wVzd0MTZPa1Q2?=
 =?utf-8?B?U1FqckhSMUUzSnpsRURKZzJDTEQ1T2xpWHpyMjQvS0t3Q3g0SDlFcG1Ea2dR?=
 =?utf-8?B?OWVXUDdMQzJLVGxaTEZjUWQvSyt3cFpSNFJyRmZjTk9qcWlJTTZWL2RDK2gz?=
 =?utf-8?B?VTFQTkJDMGdlUTF0RGxvS1dsR3dRZ3pNazViTEJXZGpPanNCMm1uS01xZU5I?=
 =?utf-8?B?YWhuWmc2Uy9PU1A2M3U3ZUtwTjk0VUxqZXlhVVNXT0d5ZHJ5Z2x4L1N6TWpI?=
 =?utf-8?B?N0JUMVFaM2tudUFtdFlKWkxqV0NQWVU3ZThtd0FFNVdTQ1dKYlR4V05aNjBv?=
 =?utf-8?B?bnkycVg2OVZ5dzlxK0VjZXhTUnFKbTZHTldWN1VBeE1qY2pJL2txV2pVT0xr?=
 =?utf-8?B?azY4L3V1NnYrTzRFWUVzWGVweVY0SjYrVTFHNU0zY21lOE5GVjNDUlprdVYy?=
 =?utf-8?Q?mhas7W7rbJlnq5EiE23uwrlPG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faaf99a9-497b-4797-dd71-08dafdd7fdf6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 06:55:34.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4AJ7+mBFI6dxFzDWHsvK0Nu6KUVBjhMPGMOWKyniRAsBywHbIJfiL5G5QbZGO0AmKWHzeLZ3nuyMFvehPzA1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 21:57, Christoph Hellwig wrote:
> On Mon, Jan 23, 2023 at 03:07:48PM -0800, John Hubbard wrote:
>> On 1/23/23 08:11, Jan Kara wrote:
>>>> For cifs RDMA, do I need to make it pass in FOLL_LONGTERM?  And does that need
>>>> a special cleanup?
>>>
>>> FOLL_LONGTERM doesn't need a special cleanup AFAIK. It should be used
>>> whenever there isn't reasonably bound time after which the page is
>>> unpinned. So in case CIFS sets up RDMA and then it is up to userspace how
>>> long the RDMA is going to be running it should be using FOLL_LONGTERM. The
>>
>> Yes, we have been pretty consistently deciding that RDMA generally
>> implies FOLL_LONGTERM. (And furthermore, FOLL_LONGTERM implies
>> FOLL_PIN--that one is actually enforced by the gup/pup APIs.)
> 
> That's weird.  For storage or file systems, pages are pinnen just as
> long when using RDMA as when using local DMA, in fact if you do RDMA
> to really fast remote media vs slow local media (e.g. SSD vs disk) you
> might pin it shorter when using RDMA.

ah OK, it is possible that I've been thinking too much about the HPC
cases that set up RDMA and leave it there, and not enough about
storage.

> 
> I think FOLL_LONGTERM makes sense for non-ODP user space memory
> registrations for RDMA, which will last basically forever.  It does
> not really make much sense at all for in-kernel memory registration for
> RDMA that are very short term.

Agreed.


thanks,
-- 
John Hubbard
NVIDIA

