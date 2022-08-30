Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9565A6F4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 23:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiH3Vm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 17:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiH3VmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:42:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB79F7D1DF;
        Tue, 30 Aug 2022 14:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kia6xP9vAGncaI733rfkg+lU8kovM1EBhfeC9Dh4h5GM3HJTLd/x+qXaIvdQXfzYTiAPlTS5ETt6veqkJqia+I9VgtY3wPJtmc0DZ9A9FiHsWpvenK6JpzZsJadPWTPvWqJco5CVNhYahqrYMIIyzSGn8QglRAmQ7czEtZxCoFcfqIEqsYkl5YYaM90vHie7no80lxV0vzaLtcXx+7vxgRsLA9ktcc+qhFdmhIrTKgc8WHsXRCQ6EZq2r043F5q2ot6nK1e5m9dOwMW+PUDn6d0EnU9x1bg41CRvugj7SbNkIPKH7oaO3ntEOOvDHmIa7Nk1mh8YeV05LOAHDjUFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjVwidUR1XHm3oyqPfRwoIbfyrA0owIjpLt7qjxk428=;
 b=j4dDC7lHQJ91WbDLi2dCoyXE5Zu5Z+laz8ALtFlUv8iWWsxM4IIrJyS8CmhJ20jrF/pCTO1O12VjUT5XdTs3VNFeTxxLwSG0TudageLy9Xp49PYBjvCbRkUQUn+nO6E9islw46ygNakM8/tenybLu3zwIiUL59jY4yzZZ6Dg/7C3/lBXSkXbTOicDRh3wvje3IkkFNhYKHFkt8nKi+vCG3i2BFq8I5rpzjp52NSOWk3jPsRrW/oJHmgtDWK531ING0mpkxZXyebt5gL2YxU4ZwQ68vx2EnmQ5rPNAM6O8rocW4O8UBgXA2Su6xsWsqRVWQL0mQ6jIADD8cqIR1SGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjVwidUR1XHm3oyqPfRwoIbfyrA0owIjpLt7qjxk428=;
 b=mcRd9+FryZycC/TjF7VWVHW3ojyIkK7A3Ezl7e1/qvayBvxrTTsY+mJeOKxjc66/GPLAksd/I/yhNUhtuvJHytQFX060GzYFkJHrtaaXAiqMFods39prR+2K7H1jDIuBcdG6YmJOeEbeznE5ldz70nfJ8dUSgqXFhMYJT+RoOuYniQ9MQqGx1XhZyxAz4997onTZpyBMtjDZrzmDfO7/yEr2CPlDnUR+MeXy6i6svEHd+qXciTNCJDmyMNX+GN7JXAsRRg711ds/Kg7RLADdhizjVSaODDfqYZI08QjYWf5Byyed1W0u8yPI1BTnPWxCPgGuUYPHahxgxWhQSJWGOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 21:42:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 21:42:19 +0000
Message-ID: <3a0a814e-1317-2cc4-045d-296df9181d39@nvidia.com>
Date:   Tue, 30 Aug 2022 14:42:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/6] mm/gup: introduce pin_user_page()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-2-jhubbard@nvidia.com>
 <10a9d33a-58a3-10b3-690b-53100d4e5440@redhat.com>
 <a47eef63-0f29-2185-f044-854ffaefae9c@nvidia.com>
 <5aa08b4f-251e-a63d-c36c-324a04ba24f4@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <5aa08b4f-251e-a63d-c36c-324a04ba24f4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c195f3-4685-404c-cfbe-08da8ad083e9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5057:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBQCM5Ey5wTCDf5est56dDQI/MCXgNj3oTQQPgZJoAxn5kFEZOGFmd2eODPRyqkwOGGYphMMuRt0M4dxJDomR8DG8CruCikKOarvc1A8CDULeQP+MrQVeiYYxAWBmrZIOeU/iCNmzpGXoX5wyoQAujYqfvendxchHxMnZ4bHLO5/vGiwqsfT9YELJVIWGgsY0mn39na2F9raLp+3JQ4JWMXMOFNpCP7meCGpsfQgV1KoygFM85/UNfKvmhIi9OFErq7qPFddOgn0om5ywF+WEDJcKPicrHhZsAtl/aIDwYTdj84pj4jH0saG5gqgR2jV4RdvBxHT3KodADLcshKwmWycS+bA9HVTStsfCjym85tPD5zAwBy6G5om2qUlBSt3/YmxeFn0fm8p/GJGyI1COymEb4kfvKGs9JW1NiY4HblFVl355sT6JpFeg0YZ9UyX+5PGF4eC0pIkVaPU+SXApeLBJdtZvH1tvHS2cELoWV/z2+3AxF8mtEdFuk2oMlfOFmQ4ST/bIiBcGcfsQTebdjWHoS32l4mtj/O/M1eOpHu0jK1F4VEL668ayzqw13xXllP4G2kgoLXSyp6cX6p9bE+1OJ+g9Tgs7aJAkkRHfBiywyqmJ2b3G0BZA925Sv36u8Eqm09xoQ63MQ73TqQVLNwLJSAf91X5KaoT6Hb8ct1/TBW6GgqALJt7WxUIczfRso7n+GWWjTWJXDd9IHr8rLkpqr5i3mi8Q8S5+u1rj3DxblHMcHB1ZBKj36csS32agzF85ndz4HSHAxXiUxfYvOFRWgEUs1oWFV3e4+iwFNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(110136005)(66946007)(478600001)(36756003)(54906003)(316002)(31686004)(66556008)(8676002)(38100700002)(66476007)(6486002)(4326008)(41300700001)(8936002)(5660300002)(7416002)(6506007)(26005)(6512007)(2906002)(83380400001)(53546011)(186003)(6666004)(31696002)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVYxUWRUdEtLV0Jtc2dnaG15UHlIdVVRdzl5TFJzNTZtT2x1TlNzemVoT29x?=
 =?utf-8?B?d2JzQzQ5SHJFRjUweE5KVnJiTDgzenZiZXdEbDRlMDdWWm5rVTdaYjNyRGg5?=
 =?utf-8?B?bytCL1RNTi9VNTkydW9Qamt2akdscVZlNGtKTmV1MlF6MHZXeXlHZ2hxR0NL?=
 =?utf-8?B?QmRFcEVoZ0Fqa0MrUHRrT1VGSE1CdFI0WkxXN3VLMFR2MVIvODl4NTlPcHp6?=
 =?utf-8?B?VlpVS0swdjlMNXpoWmIwN1FhUnl5T21ZeU5YZFJ1bkFCd3BQN3M3NlJiZFZC?=
 =?utf-8?B?UDZ0QVBOUFlONEpuVCt6M2VKWVhzc3JKdmM5c0J0WGN6RmZMbzZYdXBTRFAz?=
 =?utf-8?B?YTZJSHN4TFgxblhXdGNmWWlaVVpqNWxUWG1LRDhSaFNzRE4rMmthSTlyYjhY?=
 =?utf-8?B?NkxZdTBzUmN4by9td0plMjV5M1UrS1dJOG96Q2VHQUNOQlg0TzAyS0pWcys3?=
 =?utf-8?B?Y2N2SkJ3VDJTYllkTGFkSmttMktQb0czQnZWaFY1VTVaR1J5cWhGUlBVcEto?=
 =?utf-8?B?WVdnbXlObWswTStkakt3bDBHdy91VkJRd2orTDNhWitZNnBiMW1xcytRa050?=
 =?utf-8?B?Nk9KTml5S2QvY1lWbHV4NTRiY29tOWNWRnVrUjJBZHMzTVl2QmtwT1V6eS9M?=
 =?utf-8?B?NExRTjVDRlduNjdaS1RxWEFIU09Zd0dmQkszcmFPTU1pTm1CeHphbkxTelVH?=
 =?utf-8?B?ZE43THBQRWhBdHc2MlhUMEdBdzBtcWlCUlVmV0tNdlJDZlorVGswbm1wc1BQ?=
 =?utf-8?B?ZEJ1UisxSmEzK25JdlZsZDFudmRjdUdqZ1JnYkxiUGlPT1NuSXcrVGFyVHZV?=
 =?utf-8?B?RHFySlM5MVFJUnExMWtqQ3VDdjUvZDdkYnBEMGNyY2p2V1h6TTA1RWFTQW1h?=
 =?utf-8?B?eWlqVUtDWnE4T2hiejJMZldaZ2tYSlBUSEUrazY4Q011S1IxZGNFbks5Y0ZS?=
 =?utf-8?B?bkxmbS9Ga0loNzhnVUVqRVZtQUFCMTJwZE5nOXdjNHhXVmZRYVJnNHFIOHV2?=
 =?utf-8?B?NDJzeW9SdlZDdkVIMFhmU3JEaDBaN3AydkpjOFdyMlpBRW1mMUtxTlI5TjBr?=
 =?utf-8?B?N2ZnZGxPODFkRGtFZ3MrbUliMDVvaWlhUHZmU3AwUUt5bzhKazAzL2x6R0FE?=
 =?utf-8?B?SFlDMmszSnNDRlpKLy8yNUFzeWtWeGZCNnJDamVncHFqL2FuU3lwR2FsbVVV?=
 =?utf-8?B?V2ovQkd0d04vdm5mbkFTdVo1Q2F5WlRDUkxhdllhMWxHWkRSWWJOajhweEFT?=
 =?utf-8?B?QWhBL0Zocm04MUZpOGlWNllZVkxoamRWMXN5eUdsNC9ZUHVEVFFWczE5MUR5?=
 =?utf-8?B?WUtKZHR2VUNXMUpGWUNKWWlGNUVIS2oveVBnOGJOanhsM2Z0MWJsbEVpblZx?=
 =?utf-8?B?MGxTcXlGTEdobWF6b1J0T2NRcEZBVEF5WmlMdVRwNWFCcGZ2Vm1PUnUrV01h?=
 =?utf-8?B?bzVBb0lVckF0d0JaQ2VXUjg1UVJvNU9JL05wN2tCdHJYTjVFZUlWMzQvVGVV?=
 =?utf-8?B?eTBHMFNZVFlHaFFCbWhJUEJ1UmVrNDU3Z0xHaDVTeDN0VGFDbzBWMXcycFFC?=
 =?utf-8?B?REduMkFMVlprbXRxT25PNjlYYTRtRkFOU2xNMGhKUlNXai81OFFhL1FJQXhE?=
 =?utf-8?B?UGhXMGxFc2QvQ0dkcUVsUzlnTmtRT2R3ZXVONmZTZkRmamZWQnIrNDRHdXBE?=
 =?utf-8?B?eC9qQ1dMZ1UxaUtTeTVVS25qaHQxS2RkQzVEM29OeFZHbjJlUUwyTThRWEFt?=
 =?utf-8?B?NGlyUGlFL3ZVaGVmb0FNUWdDeEgramJJeUdUNHFTNGhSY0kxR1NSd3NtWlRv?=
 =?utf-8?B?QllwNUpEK1FVRVJQYmpNYW5jaWcyNVQ3elNWSkJMUWR4SDJKck1ZdEk4NE5j?=
 =?utf-8?B?b3pITFJkbmc0L3pnZXRWTFN5RjF2VURPSkl5VUdKYXFpUk5XNEIzZVFZRmo2?=
 =?utf-8?B?UFpZMnI1dDg5eUhlL05CT1d0N0xlbGU2M3J2U2x3Znk5M25vRVNGd1lDL040?=
 =?utf-8?B?ZS9TNW1PdXdBM1lkS3JNUHcvUWNqaGdBVkVCUXoyVjAwTEM0Yk1OVFc2cE5N?=
 =?utf-8?B?QnBxd1dBUjBibG1oMHIxbFJwSjRJUHJoOGgvMDFkWUdZdithelZ4cEFrbFp3?=
 =?utf-8?Q?/NtUqJL21ttOdmT/HqnhIstI7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c195f3-4685-404c-cfbe-08da8ad083e9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 21:42:19.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOeJXuUJ76IDVYMnOLaIkF8hvSQe5LD3/1bq20Py+8W7FxECs1O/oJlUvtAAjT3pdSyXIoDeD+uTymRRyhXzHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/22 05:17, David Hildenbrand wrote:
> On 29.08.22 21:33, John Hubbard wrote:
>> On 8/29/22 05:07, David Hildenbrand wrote:
>>>> +/**
>>>> + * pin_user_page() - apply a FOLL_PIN reference to a page
>>>> + *
>>>> + * @page: the page to be pinned.
>>>> + *
>>>> + * This is similar to get_user_pages(), except that the page's refcount is
>>>> + * elevated using FOLL_PIN, instead of FOLL_GET.
>>
>> Actually, my commit log has a more useful documentation of this routine,
>> and given the questions below, I think I'll change to that:
>>
>>  * pin_user_page() is an externally-usable version of try_grab_page(), but with
>>  * semantics that match get_page(), so that it can act as a drop-in replacement
>>  * for get_page().
>>  *
>>  * pin_user_page() elevates a page's refcount using FOLL_PIN rules. This means
>>  * that the caller must release the page via unpin_user_page().
> 
> Some thoughts:
> 
> a) Can we generalize such that pages with a dedicated pincount
> (multi-page folios) are also covered? Maybe avoiding the refcount
> terminology would be best.
> 
> b) Should we directly work on folios?
> 
> c) Would it be valid to pass in a tail page right now?

I would fervently prefer to defer those kinds of questions and ideas,
because the call sites are dealing simply in pages. And this is 
really for file system call sites. The folio conversion is a larger
thing. Below...

> 
>>
>>>> + *
>>>> + * IMPORTANT: The caller must release the page via unpin_user_page().
>>>> + *
>>>> + */
>>>> +void pin_user_page(struct page *page)
>>>> +{
>>>> +	struct folio *folio = page_folio(page);
>>>> +
>>>> +	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
>>>> +
>>>
>>> We should warn if the page is anon and !exclusive.
>>
>> That would be sort of OK, because pin_user_page() is being created
>> specifically for file system (O_DIRECT cases) use, and so the pages
>> should mostly be file-backed, rather than anon. Although I'm a little
>> vague about whether all of these iov_iter cases are really always
>> file-backed pages, especially for cases such as splice(2) to an
>> O_DIRECT-opened file, that Al Viro mentioned [1].
> 
> If we can, we should document that this interface is not for anonymous
> pages and WARN if pinning an anonymous page via this interface.

Yes. OK, I've rewritten the documentation again, and changed the 
warning to just 

    WARN_ON_ONCE(PageAnon(page));

So it looks like this now, what do you think?

/**
 * pin_user_page() - apply a FOLL_PIN reference to a file-backed page that the
 * caller already owns.
 *
 * @page: the page to be pinned.
 *
 * pin_user_page() elevates a page's refcount using FOLL_PIN rules. This means
 * that the caller must release the page via unpin_user_page().
 *
 * pin_user_page() is intended as a drop-in replacement for get_page(). This
 * provides a way for callers to do a subsequent unpin_user_page() on the
 * affected page. However, it is only intended for use by callers (file systems,
 * block/bio) that have a file-backed page. Anonymous pages are not expected nor
 * supported, and will generate a warning.
 *
 * pin_user_page() may also be thought of as an externally-usable version of
 * try_grab_page(), but with semantics that match get_page(), so that it can act
 * as a drop-in replacement for get_page().
 *
 * IMPORTANT: The caller must release the page via unpin_user_page().
 *
 */

> 
> The only reasonable way to obtain a pin on an anonymous page is via the
> page table. Here, FOLL_PIN should be used to do the right thing -- for
> example, unshare first (break COW) instead of pinning a shared anonymous
> page.
> 
> Nothing would speak against duplicating such a pin using this interface
> (we'd have to sanity check that the page we're pinning may already be
> pinned), but I assume the pages we pin here are *not* necessarily
> obtained via GUP FOLL_PIN.
> 
> I would be curious under which scenarios we could end up here with an
> anonymous page and how we obtained that reference (if not via GUP).

Let's see if the warning ever fires. I expect not, but if it does,
then I can add the !PageAnonExclusive qualifier to the warning.

> 
>>
>> Can you walk me through the reasoning for why we need to keep out
>> anon shared pages? 
> 
> We make sure to only pin anonymous pages that are exclusive and check
> when unpinning -- see sanity_check_pinned_pages(), there is also a
> comment in there -- that pinned anonymous pages are in fact still
> exclusive, otherwise we might have a BUG lurking somewhere that can
> result in memory corruptions or leaking information between processes.
> 
> For example, once we'd pinned an anonymous pages that are not marked
> exclusive (!PageAnonExclusive), or we'd be sharing a page that is
> pinned, the next write fault would replace the page in the user page
> table due to breaking COW, and the GUP pin would point at a different
> page than the page table.

Right, OK it all clicks together, thanks for that.

> 
> Disallowing pinning of anon pages that may be shared in any case
> (FOLL_LONGTERM or not) simplifies GUP handling and allows for such
> sanity checks.
> 
> (side note: after recent VM_BUG_ON discussions we might want to convert
> the VM_BUG_ON_PAGE in sanity_check_pinned_pages())
> 
>>
>>>
>>> I assume the intend is to use pin_user_page() only to duplicate pins, right?
>>>
>>
>> Well, yes or no, depending on your use of the term "pin":
>>
>> pin_user_page() is used on a page that already has a refcount >= 1 (so
>> no worries about speculative pinning should apply here), but the page
>> does not necessarily have any FOLL_PIN's applied to it yet (so it's not
>> "pinned" in the FOLL_PIN sense).
> 
> Okay, then we should really figure out if/how anonymous pages could end
> up here. I assume they can't, really. But let's see :)
> 
> 

Yes, again, the warning will reveal that. Which reminds me that I also
have it on my list to also write some test cases that do things like Al
Viro suggested: ITER_BVEC + O_DIRECT.


thanks,

-- 
John Hubbard
NVIDIA
