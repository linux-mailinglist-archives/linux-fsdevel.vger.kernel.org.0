Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C84696FEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 22:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjBNVk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 16:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjBNVkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:40:25 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79162B084;
        Tue, 14 Feb 2023 13:40:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9o0W35UMAASQjz8V6b4xQqZzDVvc1K+SbNHhax0eay9c4dFnWcGf8zAmJhWaZnIcf5onGCMqdxSNvTlsj19w9Gv9pI9yQYgxHdQV+6ZXtl4j2d1newqgZELC3XQVLEF1ZdvaQzjguQbBsbjR7S+iHMzmhpYRO1awYZjo1Zd83Ye5wzJtuV7edaVcjddZKlscmDSDc0RKfS+u5A0MrWpMsGixDsUS9+ANLgzgOwkcvUkcE9AluerxR20xJ8XQFEaqwOOHFwQdAts40wbrLdL4LwFB4q53rmvxBKE3TkHLYL3DRZRfT9iQgYBOVMOadBgAPHwF+zsIa/ynTxRvE86zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRlrirk6FiGvA0H4GBXrfWoGA4SpAomqJEEVRU1ci0U=;
 b=FGPh57lYMS13nR2D4zYnDBRvMp036CErpYLxu60FlYVuh3d1HRLdtfedQe5WoOhn1NIkbRk3nblcd6Me0+PcFzQJrR6AUVehCEg2LDkUmgwRtq84SK0sIcbHZsuGC6r8VvSXt8GrbjDzrPqlr2nMqz4sF8vdunwMVO6Z1YrEkLhSiUDS24Xhp2Fh1HwMdJpYimQGcHmIRSnB+SOf8WpguFsvD6tSyi10Z2MTZj88+yj4hH0HwLTn58ZcTmc83AvakEMKmXlAy4qPP1xTYLdyf7hAmaTI5tdgfjNhQGwKnrQcT/hFx2dtjScQjBbrtZ4Bkf24Ak1JSznb6e/TSZmD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRlrirk6FiGvA0H4GBXrfWoGA4SpAomqJEEVRU1ci0U=;
 b=YGN2foYQxih6mvfriAK498/LPLm1gFBLIGNDoBL8QvKNQMDahMdQDx3CQebVM+fROIKiGi+pefchidie8tAya9ahK1wLkdFh8JvJELUJK2M4+h6YqyD7SqD7WbCzyQbe6Q0BcC+4js9a2OCS5zOCprXS+OjHxzYCMWqiF0uYyS+hJ0PQoDWaR7dJnYv2rLqDBJHtpCDNppJi3QOxGKmLHptOsNrDobi/nWIp4ctemVjliFnRXqGS/Kt0VGJFfRgdkqUDBSkzX/Tv1ZZZsdh5LYy6uIVtKg7HCy7ejxSYMAuz2B9gf3gx9BplxpZm9nr3DEhYdPdRWKMbssXGDZIRKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 21:40:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3b11:5acd:837b:c4c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3b11:5acd:837b:c4c7%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 21:40:19 +0000
Message-ID: <406c3480-ab59-5263-b7bf-d47df0f6267c@nvidia.com>
Date:   Tue, 14 Feb 2023 13:40:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/5] mm: Do not reclaim private data from pinned page
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-1-jack@suse.cz> <Y+Ucq8A+WMT0ZUnd@casper.infradead.org>
 <20230210112954.3yzlyi4hjgci36yn@quack3> <Y+oI+AYsADUZsB7m@infradead.org>
 <20230214130629.hcnvwpgqzhc3ulgg@quack3>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230214130629.hcnvwpgqzhc3ulgg@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f3fbb9-eb74-4480-ce3e-08db0ed4117a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLI351cMkxDB0nk7K+6KLBcJv1WhW26hXGoMa37rtiJelgi8uqz+Vob+26pbB9qLpe0mUPGpbGWPbh/jAxmbCPBts8He7kI5viXPdCsHwYupSbcSc5oY8xTB8HUISqm3HSscmt4gfT8Nyb4ITfSP1D4IVT6M0DxX7PyJJD2mSvEzgGV+XkyA3z0Vh/lrQ1gFwm/TJ4nlBJeCjWwqc0waBTS7tJUxwp20wZKTACtcrfiXTWtc/PLzOFrf6aO6lULoA+uHZibMmqvi14v5mcd3T3ltvfzn6nHIOB5FLMdvduI4FvWCHPiycm6IxeW0z0UQag5pJkZXMBIQeDSfVttjjezw7lHxisZztKisutg95ChTjTVF8dMiPAtuBY4WVueZs13draXFhYCi2RxtVvCABIAlwryrSFVbC2FW03uXcebmd645E/m8iq8chkMG88GJpY9dpZoayk9h0YUXOr9vyotdJgxHvp/REkBPoEbn0qsP2jnhMbZjx0NioDCDJl8SPfP/jCAAfUHAceqQYE6b9jG+SHjMsv/24uC9dDsoUMdJ2n9ok6EIiPL8FL1e/vxzaOTi1mcwcEQ1uU2fP+Mr6r9UAm/MNW/Ineh70KTk5Q2+sl++bJ8Wf1OsvtBI2a5zctP4NKm8DZzvLgkHaQdHhQkTVYOGjl5uNiKL9kjJxz01+YgHNA9BddSPPnH7/wFrMTpJLQW/NnAv5cGCkHnLd0ofJLqasv9YkPNjnrJrIeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199018)(26005)(31686004)(6512007)(186003)(2616005)(316002)(6486002)(478600001)(8676002)(4326008)(66556008)(66476007)(66946007)(6506007)(54906003)(110136005)(53546011)(41300700001)(5660300002)(38100700002)(2906002)(8936002)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFsdGxhbXA3UWh1dXNycDZOak5XQVBreHpjY3NhSWtZdHJ3RTgraG5ta3Nq?=
 =?utf-8?B?a20wV0FwcDZ2dm5Kc0trNCtBRVVROUVrUEREM3k4bTZ1T09TeDZpY1E3Yy9n?=
 =?utf-8?B?bjBIOGRWcGlUL3BhckFTQ3lGK0tGaFAzd3NrSUhLNVJUZzV2cXgrb1BKQ21w?=
 =?utf-8?B?dWZ2QzJRa21mS0laR1pvUjUxU2RpUWVwcFRKaEI4cDAwN283K29EM0htV3J6?=
 =?utf-8?B?MkVIVitGRVRzVkhHckw4Q04raDJySEFjVkxQSldMdUE0RHVWenFCdkJCc2FO?=
 =?utf-8?B?U2lIaGE2ZHRyTzRlTm1DS1loSUVKV1gwSlM4bVppUU9DMU4yR0gxRVAyZys1?=
 =?utf-8?B?d1JvTVFKMFJJV2I4azFUclBvRTVJQUNob2FyeXhYRjRNRnF0a1JvRTRUdDc1?=
 =?utf-8?B?ZlA5UDNMd0xuTlVET3c2UGowZHdBd0dIZmdFaXNRZUVvMmVSR2IzWDNZZmFu?=
 =?utf-8?B?ZUY0bHlIN2srM2RSdGdMdS8vSnJQZU50UStHTzNlazNYakFrUzd0VUNJYW5t?=
 =?utf-8?B?S1dONEVpcG9WRUtMcHdkNkpMOWtoMlBiQ1BQK3BGa1BaMWlVeGJTMk5paUE3?=
 =?utf-8?B?RDlwYjFDTEEvUlAyVGpLM1gveGZpOThmUUhjYnhvbWJVZjJ6cm1jWFF5OGt4?=
 =?utf-8?B?Z0t6Tzh5NFE4QldaL241djNta1haUFhDR2ZYYjZFRnpIN082Nlo5SmEvTXh2?=
 =?utf-8?B?NXpmdHBkemFzVDdlT1BNbTVOQkIzdmt0UU1wMzdIKzhqNlQzZm4zcDkvY2pi?=
 =?utf-8?B?dWNXRE5iZVphRDdYTUx5emlRSnQ3TGdpQmJ3Q0E5ZzByN0NGU1JTNjFxM2Q0?=
 =?utf-8?B?RXdMZzZJU2tYOGFBc25tdFg1Y0lUZk15M1NvZHR3N2ZJTWN5bjZ3RGN3YlV2?=
 =?utf-8?B?NkFHYkk0bk5CWFpQMy9OQU1jajNOV052Ry90NHZMR2prdFptT2ZHajlRZHlR?=
 =?utf-8?B?NU1QTWZKcVB6cHNlOFRySkg4WHl3OXIxMi9zbU1SV3pQbmx4YzRDY0lIS0Zn?=
 =?utf-8?B?cXVWL2pOb0RQdkgzUVUvRGFNY3Q3MzhVakZubHBtTE5SVkhPOFNnYklNRnFM?=
 =?utf-8?B?UXk3V2hJWkl1ek9iUVFkbmJGS1hTeFdMZC9GSXNNZGRTT2FIU2RGdEtpaE8v?=
 =?utf-8?B?Znk5eFMvY2owbitoak10M3MyQ0dDMGFlYnQvY2FWb2luTXZsSjdVRXJtZXZS?=
 =?utf-8?B?aFNMV1VoQVQ3YkhST0JkeXN6NXlFTFNadHA0M1lUQk9lQ0JGckozakpiZ3lx?=
 =?utf-8?B?SEpVazRnRUVRVHdvMjR6bU5nZ3hXb1pHY1N0L0JEVy9FSUdkNSttTndZOVBM?=
 =?utf-8?B?aTZYUG85TDI3dTdRQnpKb1dSZStWQ1p0a1MrdmhXSzZUZm1GbWpkYkRpZndJ?=
 =?utf-8?B?TnV6Y1VZcFo1bnZManJkN3grRWcreDErcks0OW04SVRjdzY4QVBJcjk2NWww?=
 =?utf-8?B?UlFsOXJjYjhZcUd4eVN2WkFjTXNLaXdLSENlVCtSVGNiRXM3eHY1QVVTT2h0?=
 =?utf-8?B?ZkxHdVZaZzlJWXRDc0I4VGxBaDR5d0JaK1pLWGRTRnlOOVlzcE9XUVlURmdT?=
 =?utf-8?B?ZndlK01BamZDaGpMeXI3eHVXNzJBOFZ5NEFhNGlDSFZGMEUzajdXUlVzTlQ3?=
 =?utf-8?B?cUkrT0tNUEF1VVBlT2VPalpUd0RVS3cyT05wNlpkQUhKNlBSZjlWajRPTlZS?=
 =?utf-8?B?WWxjbXduRGlLK3I4Qk9yeU1wVU1BK1poTm1PeXBNUm81SnRIeHpFZkNVZXhz?=
 =?utf-8?B?SWRXMDV3ZWYvb0pOQlpacm52dytZUEVVaFQxbUZ3VjBQU2lRU0ZkSXF0V3hy?=
 =?utf-8?B?RndUZm5XOGc2bUlsZ0lSRUdITWtxaFQzVmFodTByZlVmR000ck5nMS9qS1Zj?=
 =?utf-8?B?VzQxN3RpRit1Q2pNa0x2WUVQcGQzTkZPVFdOb24rWlUyRFByYkwvUG4vbFBC?=
 =?utf-8?B?SFp2Nm5maTlBN214NzViR0pJZldlZ0tOdFg2Rk1KenRwdlZ2Sk13YXlIM3g3?=
 =?utf-8?B?NUhkbGxHN3lGZVBpdDJMR2VaeFVQQUJOWnFHY2twRjI1dlBKcTdnY0E1Z3pW?=
 =?utf-8?B?VWhpMmR1Wno3VjNDcGh5MUpYUVpZamc1Y05vMkdQb3VVMXlRS29mamNUMnEz?=
 =?utf-8?B?b0E2dFF4YmxUb0JDTTh4NktTWFdoYzVsRVlNdlRJRUlhdEV4MHM4VjAvOEJp?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f3fbb9-eb74-4480-ce3e-08db0ed4117a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 21:40:19.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vKUAXa3uxtH4ZxzaZXlLOLoVkKAJ+M4JmAmhxQwHLt6rgmPDBnMF3Gm2JnB6++HT6N+GeisD+TGgE/hYL1RmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/23 05:06, Jan Kara wrote:
> On Mon 13-02-23 01:55:04, Christoph Hellwig wrote:
>> I think we need to distinguish between short- and long terms pins.
>> For short term pins like direct I/O it doesn't make sense to take them
>> off the lru, or to do any other special action.  Writeback will simplify
>> have to wait for the short term pin.
>>
>> Long-term pins absolutely would make sense to be taken off the LRU list.
> 
> Yeah, I agree distinguishing these two would be nice as we could treat them
> differently then. The trouble is a bit with always-crowded struct page. But
> now it occurred to me that if we are going to take these long-term pinned
> pages out from the LRU, we could overload the space for LRU pointers with
> the counter (which is what I think John originally did). So yes, possibly
> we could track separately long-term and short-term pins. John, what do you
> think? Maybe time to revive your patches from 2018 in a bit different form?
> ;)
> 

Oh wow, I really love this idea. We kept running into problems because
long- and short-term pins were mixed up together (except during
creation), and this, at long last, separates them. Very nice. I'd almost
forgotten about the 2018 page.lru adventures, too. ha :)

One objection might be that pinning is now going to be taking a lot of
space in struct page / folio, but I think it's warranted, based on the
long-standing, difficult problems that it would solve.

We could even leave most of these patches, and David Howells' patches,
intact, by using an approach similar to the mm_users and mm_count
technique: maintain a long-term pin count in one of the folio->lru
fields, and any non-zero count there creates a single count in
folio->_pincount.

I could put together something to do that.


thanks,
-- 
John Hubbard
NVIDIA

