Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCBD4C7B9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 22:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiB1VPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 16:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiB1VPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:15:39 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA110B7CC;
        Mon, 28 Feb 2022 13:14:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4935y4Ycf+6OW9yhvwJpzTFidgzSvKbAJThY4n4Fm8VXzJgI2wwJXSUuge5w5zYIJkdaWURS9JB9rC+btxKznqDGmvX9vNXZnXOG4/gsCPtiC9BHrnkOI60OQncLAwOkLDxWq1O/oBbQRJyGdENGx3Jh22TYTyqro8ql7/2aZFFUWB27ZyC94sJVxAj7gWXK+MsEZljVT/+mjnQuUHqY10Jkq2znMrkchuZ02tSO+u55Z1ai0f7ZvjlAdgJo0G63RMSeX7OYsK9ZbcDKojJZDFChefNQtipfplUs/uNrZ9XOfAhP7NrAN0Tq7fDPiuhA+M12Z8HiqabIECZq3l1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/ZB4Quop1pUh6lxFi0WAeCkJtSG4frH/hStn25g8PA=;
 b=kQBlYZKzayJiWYp4wsoOWuoUti9wDobYN/JUfE0uBb8xxRK68dQChnNcNWoUagfIF/1PUNLSNDYRwf6HxdJ3mbqD2FMQjKX4gGx6ubGhRpd3tDYrem0dNMYwCaGKcOYvqtYyvFblR+19nGYyy6CupI5Q2A56GCqI4iq515pCd52N87KQV38CtYRgTQO3ZMKw2qz7eyNUTcgYPgu6wC6PTIpdA6fYZ9X5NYpgfHLz3PcV7wSpm/OewQ3Ovj8Yt959OjlqEzmzonXXSdAGmFjWznFrj1UJacfPsYcaOflOj11/VhR84yN3dAxBFLsErcEDBxvx6FtbHOF6f9qgRapUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/ZB4Quop1pUh6lxFi0WAeCkJtSG4frH/hStn25g8PA=;
 b=mrMhf5bwFBYSuDzI6xeTlx3ETiLHTSyyI99JhUPocrvUVNLgVX5aUQbHYpfHwXphCouSpuuVtoVYTiODu1/Ji8437DafS61fcitgASEfuuEkoucgZlAHL0PO2wxXtYLLV2yISlS4eN41P6g6hRod6NIACB1moaa5WvWPdPBkYh1XLux3ChtVUziOGZvwtN8bpe4mB8OlFlRi133Xrsz9z1CSyRfirVWv1VOLsDQgBLl8x4hug606G7/9VHjFuATFoheSzQjwu54R7MxaYO6WtU6/N7pmEHyDU55GIQvt30PqQ8KeLnj0NffF1//aDg4ngBmGvmm0eSdExHCCFyD9dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR12MB1718.namprd12.prod.outlook.com (2603:10b6:903:120::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 21:14:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 21:14:56 +0000
Message-ID: <36300717-48b2-79ec-a97b-386e36bbd2a6@nvidia.com>
Date:   Mon, 28 Feb 2022 13:14:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 1/7] mm/gup: introduce pin_user_page()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <20220225085025.3052894-2-jhubbard@nvidia.com>
 <6ba088ae-4f84-6cd9-cbcc-bbc6b9547f04@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <6ba088ae-4f84-6cd9-cbcc-bbc6b9547f04@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bab33367-5349-45b7-2ef8-08d9faff5e94
X-MS-TrafficTypeDiagnostic: CY4PR12MB1718:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB17185C75FEF71EB2C7A50A06A8019@CY4PR12MB1718.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaAiVK7eP0XQvyth83gmiS92F13C57Pxe8VhP6tktiWXPdOqrSGwCI3VXWacJnuQ6RL0kq5EZ/0wQicTXUdIfZeZ8V6O1FReYOMxkWKe03Po0BPx7fZm20DpefhGLnspzyiFSpxn9qZ3EjOaUWXzvH5k+1OTM+bou0mfwQtRWjwzMNuo2aKYP0Zr3T+lqSb16LVq+gy3+UdoUA8fu5fUtZJ1FSJpnUDaSrI25ie+pNJYFfwibTyAFNKkp5KFk1qGbNbC4Q4e611BHe8e6vvMsVbw38YA+TAyldI1aDAfT5aZB37Q6lOQxPL7+wcNwvJyRhPa0QafFdf5Es+vtsjjS4uKY5BpS05pPJUWrIK59xSsVJGTyDaPj4w1l6gX+0VV6ZANCo9P0oiwK81kB8CWibEC+t9rrIB031diKIi7wVyAKoZh0Th9YbOz7Pw6f4Kid9c9UHm/mKbXASKjuP8Jss3Q8FyOn+g9YNeWLKSN0JVx1zVKRwXw2ftm2CNbhegc73QS+iv8PyYTaHb29u0oxbGw65lkOr2w5i4uPoAmk7e9n7EoejwwQSg8xPamdZAhwo+pA0Yk0x/KjvumwkBmvvDI9eBTtNygFJG/PED1m8tS0kT6JEiebAQzxlTxnH4E3vQaYou5Pm0um8fy2Ns6iOYtNaNx/m22FNsJdrUimLSP11h8OEBS1r0k4y/voeFJJcjOCXkwRSWfWxzXiYQ7Z237NnrN58zIhlp/0If+0tZoa22cpzPBI0FkMH6HTC9D3a7n3X3dgOOi+Ax8Aa9Tow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(110136005)(53546011)(2616005)(6486002)(36756003)(26005)(6506007)(6512007)(31686004)(83380400001)(2906002)(31696002)(921005)(316002)(86362001)(508600001)(66946007)(8936002)(7416002)(38100700002)(66556008)(66476007)(5660300002)(4326008)(8676002)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFVQkhyQ2c2dGorZXZ6R0orVkNtZ0tBY2x4cFlPemJ0MzJuOFZaamppcklM?=
 =?utf-8?B?aGhGWVZLbEdYalFWS0QvVEZJT3hjUkFKY2tFek1aRVM1VjRqTGdudVRKbWZw?=
 =?utf-8?B?citjSldhTEFQc25DNENCVUswVG1wNmd2c0ZvaDBxM3hoWnZ6VUp1NW1JRU1G?=
 =?utf-8?B?Q1E3ajl4d1N6Z3RlUGtvcHdqMk4wYlMxRXJZRFZsUUpZTUtHUEdsS2twelJx?=
 =?utf-8?B?U0VJbjh5a0tNV0g4K1djeW1HRzBqWlhxekNoSU45Y0RFaEYrOGg4SkgzSFhQ?=
 =?utf-8?B?d0JEam9laWJtQjM3U0wwc3U1U1JOTCsrdU80dHNmSWtRbzN2MkpyU1VIcDlU?=
 =?utf-8?B?R3BvRzNsWU9jVHNjUGFBSjJNTTVuSjhKOGJVcncrdW12SVErOVNxSkN5eWc5?=
 =?utf-8?B?cnBTM3huR3hmN3JINCt6OXFSK3ZUM2UyODdNVWsxc1EwUytuNXliOEswd0Zn?=
 =?utf-8?B?ckpVNTVQajkyT281RWxnR0lDb0Z6djRvNlloc2hORitzdExtbDd1U0ZkVWx6?=
 =?utf-8?B?TEh4QXFQbnhZR0lqVGhzYWcrcklkV1RSUDlTc2pnb1IxVVBhRTQ0Q01kZDlm?=
 =?utf-8?B?U0dub2RzbGV5b0ViWmxlNmJYcTRpK3hJRE9JRUFUTDRPbnFrOFIwYmxjMXpl?=
 =?utf-8?B?YUM5TS9ZaUFLekx4c1dlbjlyRDRQeTdwSnRycTBNSWxkSDd1TlJTMXEvaFR2?=
 =?utf-8?B?YUtCN2pjOHI1NHFvdSs4SGdyN0FUSVZMd1BTL3VSbVRBbUhab3BMREhDL1FU?=
 =?utf-8?B?bHJTUHZvV2MzM3grRW1OYkFneis5a2dJSzJXZlNLaHkxOElPWVhQdmlsSUc3?=
 =?utf-8?B?RWJQTkhqTWx2Yk1la0d5M3dsdnlOdE9kc0NPQmg3NlRQV2V4dmo2cUI4cDRB?=
 =?utf-8?B?MDBwdUtZT0lKRXRSbzdUSWgwOGdhemJoY0JjaDhyM21tQnNqcVhVdnpTMFhG?=
 =?utf-8?B?WkRjZWlUTkdkL3JZUUZkYU8yMEZqWXBsaVdDNk5FZHRsRStmaUF4TitjendN?=
 =?utf-8?B?d1hkNzJmU0xJV2RpczI4NElIaTJKOTdMSTc4N1pMVWxBaFB0aHFkTHhBZVlj?=
 =?utf-8?B?Vk9INDVBTFQ3aW1CWVVYUTJibnNSSCtKR0VlYjFrZWpIckYyeEpBblUwaDB1?=
 =?utf-8?B?WU04ZTlZa0lyNUlvUHQ3WmI0TWtZOGRPWm9ZWHprRHo0U3pGRGllSmdCNEV2?=
 =?utf-8?B?ZUdGOG8xeG15TzJKZ3M1SjlUQmRRUHhqTkl0WFBsV1gwV1JoZmVLeXRyZi9V?=
 =?utf-8?B?c09mUjd4ak1pOHlIQjV2VGJ1eGtNcldwM052czZjb2pPekFLWTd4RWVnbVJF?=
 =?utf-8?B?N1BZWjVsdTlrMWVRKzYyY0sweTBjNWl2RWpITkZYN05IdjloN1I5a3B1endi?=
 =?utf-8?B?TlZsZFZhYVAzd0M4SDFpVXFDTjZQTVFIK1ppWmlENkxCTXl6YmU2enBSMGZE?=
 =?utf-8?B?QVBtL3Fya0pyWXRqZUI5bTNyZmpjMk1BVHZ6R3pGcWJTY2FtQVUyQ0E5OTFq?=
 =?utf-8?B?Mkh0ZWo5NC9GTzAwOXpSaHBOR3ZFQWFFNjNaVDlzVzBXOHRCcjlmSmg5aEhL?=
 =?utf-8?B?TDNrYkVndXcxT3FBU0VwWnI2OUltVzBGY0dMNHg0WHBZbjZMU3lQTmFCK2lK?=
 =?utf-8?B?cXRIbzd4MHRNL2sxTU52MGVZQTc3cGViNzl5UzgwaGpvckpCU0g2Z2pCMnl0?=
 =?utf-8?B?VDJaS3p0ZzRmK1l2L1l1VXhmMWtTK1UwY0I2TEl5Z05OYlNLNWFERXY2Qmho?=
 =?utf-8?B?eVovK2I4SHdVbjVCbXRQV1A1QW1UcWVSck5pYnUyTmU5SUNvZXhsNS9UT2lC?=
 =?utf-8?B?M2UvNTZ5KzgybHJTKy9ZUjd1VHNFLzB4N29ZKzF5NGYyRmNFT1ZYRldRMVRt?=
 =?utf-8?B?czlCOUFuSFZVUVVKRjVpNHFKdGZTWTVvOHBmeTQ0dXFaMVZsYzlsNlhuWk1L?=
 =?utf-8?B?L3dEVHEvRDVMK2dGMUJYOGNnWUZCZUJXa202L1B2M0hMNVRMOHpxZ3cvZTls?=
 =?utf-8?B?cDM4MEpJQjMvUEJRM2VwRVZjVWt2QmpLZGtFNy9KSWdxQlhxbGNheHFRR1lj?=
 =?utf-8?B?ekFwT3hBMG91dTdNbmhZOFpNNFBGN2d5Tm51ejRJUzFGNGJtQklvenVoWlM4?=
 =?utf-8?B?Uk4vVnlRM0w1WmZYQVVTTTZQZHNSUi9GdUFESDV5S1ZSYWcyd0U1czNmOGlj?=
 =?utf-8?Q?FOzLCph2YNtH6ajxAtMJrlU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab33367-5349-45b7-2ef8-08d9faff5e94
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 21:14:56.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjwsSeOiKA4i9/gMWTsN+Z1hIZqhtozyqW+5q2ensckK7q71yHO8XdXLS82aAH9IOh1R0rJsHnQFLjPrI9jRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1718
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/28/22 05:27, David Hildenbrand wrote:
...
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 5c3f6ede17eb..44446241c3a9 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -3034,6 +3034,40 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>>   }
>>   EXPORT_SYMBOL(pin_user_pages);
>>   
>> +/**
>> + * pin_user_page() - apply a FOLL_PIN reference to a page ()
>> + *
>> + * @page: the page to be pinned.
>> + *
>> + * Similar to get_user_pages(), in that the page's refcount is elevated using
>> + * FOLL_PIN rules.
>> + *
>> + * IMPORTANT: That means that the caller must release the page via
>> + * unpin_user_page().
>> + *
>> + */
>> +void pin_user_page(struct page *page)
>> +{
>> +	struct folio *folio = page_folio(page);
>> +
>> +	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
>> +
>> +	/*
>> +	 * Similar to try_grab_page(): be sure to *also*
>> +	 * increment the normal page refcount field at least once,
>> +	 * so that the page really is pinned.
>> +	 */
>> +	if (folio_test_large(folio)) {
>> +		folio_ref_add(folio, 1);
>> +		atomic_add(1, folio_pincount_ptr(folio));
>> +	} else {
>> +		folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
>> +	}
>> +
>> +	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
>> +}
>> +EXPORT_SYMBOL(pin_user_page);
>> +
>>   /*
>>    * pin_user_pages_unlocked() is the FOLL_PIN variant of
>>    * get_user_pages_unlocked(). Behavior is the same, except that this one sets
> 
> I assume that function will only get called on a page that has been
> obtained by a previous pin_user_pages_fast(), correct?
> 

Well, no. This is meant to be used in place of get_page(), for code that
knows that the pages will be released via unpin_user_page(). So there is
no special prerequisite there.


thanks,
-- 
John Hubbard
NVIDIA
