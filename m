Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE516C4DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCVO2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjCVO2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:28:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D5FF3C;
        Wed, 22 Mar 2023 07:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRDblTeDE1l51J3MpZ/fnDILnQWaJbDdMxr/FOymyr5JCVEhWxDL6NibeQjfGacizl6gcAib/nE/AGYDQLKJWgAvUBHGLwk4yLaSljEF+JnZBLWk8lQ0Z0ctorCIfGsCsCwUoGc/2fY8xZysrcio8uubJih6bvri8DWHmr5CKdicbmnXXOMHe89mgeadWfZJCnNzidpdxVQcEZBt9dqwk+eN4NwMFRRRzqxbhotOkgxLgr3ctfxLbJ8seFfsXyzbUcdfkWy4fHW+911tYf+VH5x8aLs5Tlh/E7qvCyTBJpmmfQT5ABLpPFc3e/7GUaSl3NbQjmHSs9X8lJNMFFzkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZL3IyaYxSK6xfQ0gelaoVpNmPpTFT1cXRPOOGhpbBY=;
 b=NYWJDKJcY4crzLwparM7uKjvuvjhpNGwXMSDKBTFDO06F78TJR3I63H+y1h/6ommntchUPjwSg1L/PwQ9OlpTQ8or1VOtGPGwJF4wv/oQNmNwlgCbXDuf/WPzVy7bFavzwQ5REC4GSgNwO1lBTdRZNg2DGEvIGBrJ7E3e264DkxAPK5LwdG5mKnr7Y7Bk+nYxm600y0hJaGyB/rDyVjIJNTx7NG3ctr+zisaIL6rMKe2wqXvIzxBnDx4ccXy4NQVtcYXjfgGwXUzNlfe6cqSO1JzIzAsf+GT5Eam5MMrH5mWwmxnroAV4shFKASu0Bbtuv4s88oW7oKqxTkPTwGtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZL3IyaYxSK6xfQ0gelaoVpNmPpTFT1cXRPOOGhpbBY=;
 b=L+baqRU7aZJ9OWEHs2l8gDtGWC099xdXtxmCLQdWHHFtrTvOfnlsXmOJMNKdOcfYmecyby95LLsVRlmafMWeAvbQj83OmwSETuIy0rpDRS7EsNY3hlB7bmhNTXwRY8NBl83f59aGG0JfdOkhuaWpsdghRrQwOrBPE/r2mYhD7HW+H25KDhMgvo6CarXRtEmauv1mBoH0LgM8FhJATsr9f56YKEeFqBI/PnXINLaYkQDEkwx1vPE2Up3XiFRGwt/+Hc+42f7WhGcX9myQrz6LQx2OicPLgfTOATZ0VBUrj5YgE4VCzXfkQdhfLIbC9a6lLDuLgH8zQJMlA2kat+ot/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 14:28:02 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:28:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: thp: split huge page to any lower order pages.
Date:   Wed, 22 Mar 2023 10:27:59 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <A75E3B03-C00C-45B5-8D8E-688F091B1F4D@nvidia.com>
In-Reply-To: <e8352d76-29e4-5e4a-063b-60e279e0b070@arm.com>
References: <20230321004829.2012847-1-zi.yan@sent.com>
 <20230321004829.2012847-4-zi.yan@sent.com>
 <e8352d76-29e4-5e4a-063b-60e279e0b070@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_61EBCF05-1BA1-4F02-A4DD-46D41C663989_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:207:3c::38) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cdd382-1c2a-407e-9cae-08db2ae1a488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpcmhBjZeIXTx/KRh6TsmppUzn6zH9sze+kwmzRS867537g89GSMGpsf4v4Yc4mOT5z0QxIcLLhja2dP/yPCcJtyk3LawDGVkHYIiYfOdKLCqQ8B6CD3fbTwn5e+mySrG9zF2TZkVK0lRhrRJMTVkPgn1DGggAKahmfiGIJRQYFIsSrtHrN0OclMwqJzfe9R5CoCFsInVewErU6n6Bbp4Rse9/h8w7Rc1rP2t/Wf6APVLxLZ7WHW45MwMwEH+Sta3O3y+SEK2ypZt2KEuuJXM1lD08QsiedmdBmraTOCRT8Xdosq8LPbXMgh12McN5cPeHiuePICoP5Wp9TS8APDqH9GoPUsJDiB+D3B1ofV4Yp5+guSvgpOL90OJpKq11frEAy9dKFEFqRix+cNVZCKm4wLY3XCG+rRh88ooN0j+CUvS6Iss4ePC/+2OmIID6tBdH3loXycRIYnb4dXZST7yB1els6Wu++/4oS0+O5se4d3acUZVlgP+fdqU//hueD+erZ9p97StNVVnV5WqXtzxzBxKqFrpPUTPiFr/QfeIrpeqOjox7XS1txqkOSbBS2HLxZsnuGRWxRic6AOm3bZiqhahXLDNEIcAOdx4datoJH/ZePQni5NuIuOsOan5HaLiwxUGmxcrlsYjeikgOfzl8XMkSseqmdPjBlMzF3BPdP3rMyg1TLtKrLSKBMsLHuDCYVtmaE5ghmtbFFUgLpE7hyUWg8z6ufQ++9PvXvN12oHOTJPlGaYe6h+TEvAo1/GHu9GAqzmZ+0gYvJV2yelhmHw+xxt2QVLg4sJqIFS1tQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199018)(966005)(6512007)(2616005)(54906003)(26005)(316002)(6506007)(478600001)(53546011)(6486002)(5660300002)(33656002)(7416002)(6666004)(83380400001)(186003)(235185007)(38100700002)(86362001)(66946007)(6916009)(41300700001)(8676002)(8936002)(4326008)(66556008)(66476007)(2906002)(36756003)(14583001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GqdVTCdO2d9D9xoHdrgCHs128IjujlJnGLQImB+PrfNiwQfvzr+Uoh8xpAI7?=
 =?us-ascii?Q?kAO+ycSw3FD6Pm/m+EetNOHJTH8B3Ah7Un9pj7j7Ces6k/AkMQbISUVftxNd?=
 =?us-ascii?Q?8m/sNyfumA0vdfXm0yjZiIoq3UlK/gX3Cp5+zo1tSRNv3ehsDv/UJWpEMMu4?=
 =?us-ascii?Q?cn6eOx9zb4la0pWeadjHWTnw+WspaoBrayMhjDm99rsH1qCPbeAi26QVEI/8?=
 =?us-ascii?Q?o2/AAdwzZ8LN+CStXkSiEpzUguQ1ZXiIlLHjHGXV002XHO6/EMT2Xk9Gr0bz?=
 =?us-ascii?Q?ArT8eUYudan/Gff1R/W+9t4WzWPprnKRmL7dIntcuthqHAArLKlHSpkF93cX?=
 =?us-ascii?Q?URVnl6CZEgjXsKxxFjKB9LOurAogqGKTYzMRlcPmp5oVhQKo3yn/w0n+gB8r?=
 =?us-ascii?Q?rvsc0jueebPFGlr+RbS+vAvbB4Pdq8qpbeWqDG5ANjlK59PmW84t7GU1+gaR?=
 =?us-ascii?Q?OHRa3SCZBRkxy73z53AWzSp1boUYUx3E6VxMHtsidYeXZy5o5PYdHGfuPaYJ?=
 =?us-ascii?Q?WhWEnhyzzb8fgr+qWLNbuSpys2FInHsA+IcGtNFvz2oNOdeQzoK2Tc2k5u8t?=
 =?us-ascii?Q?cgV69SpVGKQa3ddP6GpvflN5fYimc+/913m4wlb2MdvPOc1bG13GOg4vdWzy?=
 =?us-ascii?Q?P6QU+8DP5PLxo6rltbGOWhDwFS41VSCUKRXcFTeCPFE2e1tpjHa58dek84n+?=
 =?us-ascii?Q?oomL/pSw9jjIjtDTntTsHdqyX0neOJJoxJlQVINytvXu58YSkJpR8AscVl67?=
 =?us-ascii?Q?Q3KtSL5//f7cWc3fwLlHPRtJ3WMf80zXuaayNfew+nfZsFdSMbm2TW1IPLDB?=
 =?us-ascii?Q?xRLUjU7NPwnpmrGUkhaAD8O4Ouf+AWMPOGdVF24jjvZxvIn1Uy4J1Ed/QmPL?=
 =?us-ascii?Q?IRGWUN2UD1Ogwn4PSXIphMqYQz4QiUAUvFCor4TUyf8MJSFCkjYNJy5aAkEN?=
 =?us-ascii?Q?B+uQt/l+tIV2DMon9qhkaAE228uq5yZBbUYMiMqqYRh9Bqg7inNX+FdRDhro?=
 =?us-ascii?Q?XJ+EPyM7f0yW9hTUL8XuIpp0Kq79EkW+1UttcKAH692FlhFpqDCKUjQg/FQN?=
 =?us-ascii?Q?V9BmlkiXXBRtGL27eJGedlaNHWbexdv2hWUeVywII1e20fXseLY+ve0WN4g9?=
 =?us-ascii?Q?9mC32PZV2N8Jrs6KlWDvCeFIOZgHFqQ515fqSzQdAJXkfVxNBQkF881/Z/ml?=
 =?us-ascii?Q?/xFaHPI2zqVLma8Qv08MXEMbvNIAFxZfeUClickAQTZl8sEVOhcQ8ZUCOV12?=
 =?us-ascii?Q?2nkKL1fNV4IgIixFVHxCVgEKPVA/ZOeTniYnldvgYdLXXR8mdbRXpTz8/gsU?=
 =?us-ascii?Q?gBq5rjAE1TmGwBzAzZAeYUEOJv5K5KPRM+TX3+787H2bu9MZXTEH1+kOzMfM?=
 =?us-ascii?Q?juWzY+Zv+Bqyhjh9VY0FsOSdGTclgaSfMDHIi+dLBzILqhVW43M2uTTEBovY?=
 =?us-ascii?Q?cTj1cD4NGiNtK574IhOkk138kSrbHQO0QqYByioU9gH468GOJUuQ/RU2NEuR?=
 =?us-ascii?Q?NSdGQfrh2yRlWmqYttqkaS7BtHEHLvGjx6Z9YPXauYr8Wwvgo+mxEb+qBIm+?=
 =?us-ascii?Q?N4kqyRwbFg5vEFHFInsyssa6XDMrtXydC3m3GIbP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cdd382-1c2a-407e-9cae-08db2ae1a488
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 14:28:02.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ajiPn+HNXUinKvRKqpO7KJOa7sDngfxTd1A3+u9jiOU36wS8TfdkxntAywYoFyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_61EBCF05-1BA1-4F02-A4DD-46D41C663989_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 22 Mar 2023, at 3:55, Ryan Roberts wrote:

> Hi,
>
> I'm working to enable large, variable-order folios for anonymous memory=
 (see
> RFC, replete with bugs at [1]). This patch set is going to be very usef=
ul to me.
> But I have a few questions that I wonder if you can answer, below? I wo=
nder if
> they might relate to the bugs I'm seeing at [1].
>
> [1] https://lore.kernel.org/linux-mm/20230317105802.2634004-1-ryan.robe=
rts@arm.com/
>
>
>
> On 21/03/2023 00:48, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To split a THP to any lower order pages, we need to reform THPs on
>> subpages at given order and add page refcount based on the new page
>> order. Also we need to reinitialize page_deferred_list after removing
>> the page from the split_queue, otherwise a subsequent split will see
>> list corruption when checking the page_deferred_list again.
>>
>> It has many uses, like minimizing the number of pages after
>> truncating a huge pagecache page. For anonymous THPs, we can only spli=
t
>> them to order-0 like before until we add support for any size anonymou=
s
>> THPs.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/huge_mm.h |  10 ++--
>>  mm/huge_memory.c        | 103 +++++++++++++++++++++++++++++----------=
-
>>  2 files changed, 82 insertions(+), 31 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 20284387b841..32c91e1b59cd 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -147,10 +147,11 @@ void prep_transhuge_page(struct page *page);
>>  void free_transhuge_page(struct page *page);
>>
>>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>> -int split_huge_page_to_list(struct page *page, struct list_head *list=
);
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +		unsigned int new_order);
>>  static inline int split_huge_page(struct page *page)
>>  {
>> -	return split_huge_page_to_list(page, NULL);
>> +	return split_huge_page_to_list_to_order(page, NULL, 0);
>>  }
>>  void deferred_split_folio(struct folio *folio);
>>
>> @@ -297,7 +298,8 @@ can_split_folio(struct folio *folio, int *pextra_p=
ins)
>>  	return false;
>>  }
>>  static inline int
>> -split_huge_page_to_list(struct page *page, struct list_head *list)
>> +split_huge_page_to_list_to_order(struct page *page, struct list_head =
*list,
>> +		unsigned int new_order)
>>  {
>>  	return 0;
>>  }
>> @@ -397,7 +399,7 @@ static inline bool thp_migration_supported(void)
>>  static inline int split_folio_to_list(struct folio *folio,
>>  		struct list_head *list)
>>  {
>> -	return split_huge_page_to_list(&folio->page, list);
>> +	return split_huge_page_to_list_to_order(&folio->page, list, 0);
>>  }
>>
>>  static inline int split_folio(struct folio *folio)
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 710189885402..f119b9be33f2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2359,11 +2359,13 @@ void vma_adjust_trans_huge(struct vm_area_stru=
ct *vma,
>>
>>  static void unmap_folio(struct folio *folio)
>>  {
>> -	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
>> -		TTU_SYNC;
>> +	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SYNC;
>>
>>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>
>> +	if (folio_order(folio) >=3D HPAGE_PMD_ORDER)
>> +		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
>> +
>
> Why have you changed the code so that this flag is added conditionally =
on the
> folio being large enough? I've previously looked at this in the context=
 of my
> bug, and concluded that the consumer would ignore the flag if the folio=
 wasn't
> PMD mapped. Did I conclude incorrectly?

Since if folio order is not larger than PMD order, there is no way of map=
ping
a PMD to the folio. Thus, TTU_SPLIT_HUGE_PMD does not make sense. Yes, th=
e consumer
will not split any PMD, but will still do page table locks and mmu notifi=
er
work, which cost unnecessary overheads.

I think I better change the if condition to folio_test_pmd_mappable().

>
>
>>  	/*
>>  	 * Anon pages need migration entries to preserve them, but file
>>  	 * pages can simply be left unmapped, then faulted back on demand.
>> @@ -2395,7 +2397,6 @@ static void lru_add_page_tail(struct page *head,=
 struct page *tail,
>>  		struct lruvec *lruvec, struct list_head *list)
>>  {
>>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>>  	lockdep_assert_held(&lruvec->lru_lock);
>>
>> @@ -2416,9 +2417,10 @@ static void lru_add_page_tail(struct page *head=
, struct page *tail,
>>  }
>>
>
> [...]
>
>> -int split_huge_page_to_list(struct page *page, struct list_head *list=
)
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +				     unsigned int new_order)
>>  {
>>  	struct folio *folio =3D page_folio(page);
>>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(folio);=

>> -	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>> +	/* reset xarray order to new order after split */
>> +	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_orde=
r);
>>  	struct anon_vma *anon_vma =3D NULL;
>>  	struct address_space *mapping =3D NULL;
>>  	int extra_pins, ret;
>> @@ -2649,6 +2676,18 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
>>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>
>> +	/* Cannot split THP to order-1 (no order-1 THPs) */
>> +	if (new_order =3D=3D 1) {
>> +		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>> +		return -EINVAL;
>> +	}
>
> Why can't you split to order-1? I vaguely understand that some data is =
kept in
> the first 3 struct pages, but I would naively expect the allocator to f=
ail to
> allocate compound pages of order-1 if it was a problem? My large anon f=
olios
> patch is currently allocating order-1 in some circumstances. Perhaps it=
s related
> to my bug?
>

Yes, some data is kept in first 3 struct pages, so order-1 THP is not pos=
sible.
The page allocator does not know this restriction, but still allocate an =
order-1
page. That might be related to your bug. You can have order-1 compound pa=
ges,
but it does not mean you can use them for THPs. AFAIK, slab uses order-1 =
compound
pages, but it does not store slab information on the 3rd struct page.

Basically, page allocator can allocate an order-N page, and it can be:
1. 2^N consecutive physical pages (not a compound page),
2. an order-N compound page,
3. an order-N THP (also an order-N compound page),
4. an order-N hugetlb page (also an order-N compound page).

For THP and hugetlb page, there are prep_transhuge_page() and
prep_new_hugetlb_folio() are called respectively after the page is alloca=
ted.
That makes them kinda subclasses of a compound page.

>
>> +
>> +	/* Split anonymous folio to non-zero order not support */
>> +	if (folio_test_anon(folio) && new_order) {
>> +		VM_WARN_ONCE(1, "Split anon folio to non-0 order not support");
>> +		return -EINVAL;
>> +	}
>
> Why don't you support this? What is special about anon folios that mean=
s this
> code doesn't work for them?

split_huge_page() code can split to non-0 order anon folios, but the rest=
 of
the mm code might not have proper support yet.
That is why we need your patchset. :)

>
>
>> +
>>  	is_hzp =3D is_huge_zero_page(&folio->page);
>>  	VM_WARN_ON_ONCE_FOLIO(is_hzp, folio);
>>  	if (is_hzp)
>> @@ -2744,7 +2783,13 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
>>  	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>>  		if (!list_empty(&folio->_deferred_list)) {
>>  			ds_queue->split_queue_len--;
>> -			list_del(&folio->_deferred_list);
>> +			/*
>> +			 * Reinitialize page_deferred_list after removing the
>> +			 * page from the split_queue, otherwise a subsequent
>> +			 * split will see list corruption when checking the
>> +			 * page_deferred_list.
>> +			 */
>> +			list_del_init(&folio->_deferred_list);
>>  		}
>>  		spin_unlock(&ds_queue->split_queue_lock);
>>  		if (mapping) {
>> @@ -2754,14 +2799,18 @@ int split_huge_page_to_list(struct page *page,=
 struct list_head *list)
>>  			if (folio_test_swapbacked(folio)) {
>>  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
>>  							-nr);
>> -			} else {
>> +			} else if (!new_order) {
>> +				/*
>> +				 * Decrease THP stats only if split to normal
>> +				 * pages
>> +				 */
>>  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
>>  							-nr);
>>  				filemap_nr_thps_dec(mapping);
>>  			}
>>  		}
>>
>> -		__split_huge_page(page, list, end);
>> +		__split_huge_page(page, list, end, new_order);
>>  		ret =3D 0;
>>  	} else {
>>  		spin_unlock(&ds_queue->split_queue_lock);

--
Best Regards,
Yan, Zi

--=_MailMate_61EBCF05-1BA1-4F02-A4DD-46D41C663989_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQbEHAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUPq4P/3cqoLUEWmT2KybO/wcH/qZp7uxyPZjVGIcu
DbppBaHpNbYpDC6eU84iuwQ5D453pRiEjZ49j/mVY7ENcbGFfC/376l51hG2GB1c
Mh9q6ngxYfxTmgE7T59GtYywkdiDlbDr/fm2YhlBLa3ADjuHj83AvO6C/xiEYDrY
2fbeMVorCdhuyN3VtntHTHNRwj80VJgLl67h6DuBOECGf/yslBI4+LFWToFrzrlv
+yNzLSGz9i3cBYhYcJD61Rh8inFKtGA5xryitEG81pOvx6DR1AEUxTXu3OVDyE0f
X86lHLDfT7PQqHRGW+OnGCBkYMQMHxSJAM3c9QAYHkT2MofRCLDBtp4SJ5o4C/ec
IdTY/WoY5BHg5KEzULpvHP5Kf1n+seFq25MSPH1t9dwdV1sth9AvDMbvRozFA01A
Q4tOibyszQW5qSpmQ7G7H2QXneDWfRZxDrx0O3eid0UkjS9mbBxjEPJcgqjkTKzb
VGDwQBLprbN5mrOHlTRqpzqlzS+gEyTkDtuyJziXWyswED5fOALPczYIU8uSdtjH
yhbS2xylq3eGACNW7ldrAmLeP0ly+/BBHPu87HPX3kf99Qim8np/8717/0sV6Zuw
15efchBAmIOebmYQDp0Ims7sKIXIb9zaEJ5sPdy81VZa3vEwgmR2R5nRNevhOWP/
bMoeVCH4
=WRcL
-----END PGP SIGNATURE-----

--=_MailMate_61EBCF05-1BA1-4F02-A4DD-46D41C663989_=--
