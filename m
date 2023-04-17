Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE046E4BDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDQOto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQOtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:49:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E715FEB;
        Mon, 17 Apr 2023 07:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHUQjk54DtfSAYNxPrG5STEYYjHgmQEZo0g8ZGmhoGtR3dSWym9HWgoCuQH/NpIRQxbDPrcIuaG0Ez4vdR0CoxhNGXegN3OiCfbFAOqBIC7PdKVGSgBpBPEVRzklCdD2uM3A80Z8VUMWENCx1DKW2RMob0oxXERJMWVDNu4iX/zT5hQDfqeiVHMFWYaNDijD2DjZ0ushZgZgzfK0f9k3dq+ggKJPfADs+3suV9TQCJSnGR2L2lFSkp014aFpsPpD6JVw1xWDrQrNKf3kcW8ngul0kt/NjbsG/G8ca3qqdR8F2HqVapDjP7MrdRThbWwhSsqpaJb4o41c4qs/S8Z+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5aRtImfkoQ1djdihoVfF3Oi5BalMHo8UpAtjiBqKHs=;
 b=nlhOyG8Kord5BGukWbU7Mu7QPG+anrlX+4gBUOn9SzLG32ucoghkvj7IOgFheRUwVjiQg3HdrEcBFhe4CScTJfjTMlg/w9Ulc68QFOF5relyNYwXMYgtcyKTEdKqd+L9xOCHltQal3BSw+yKk37pf3c1UVOn4SuB3H23Gv4fdvj/sHb015RWiTKra5pfaZAkQiUtWbSfqgzlO5Lf9Sehg4r2CpmE65AdI7NqbYXglz7oLqHaV2w7Ryq351MHS9mXbJcDlM7ET+aE02PTzdXpBST39iTuOvmMz63bL1tSg++zpCnYe8HiX6AuT6QFgfYA34h2LK1T+z7LMdi0xVHwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5aRtImfkoQ1djdihoVfF3Oi5BalMHo8UpAtjiBqKHs=;
 b=gYg3JW9szwW/aX1NZo2Iqb63pToWpvalrGDrd2guf20OAbC5NG5RjLFRzXJev01UYrfjIrOopSnqejBjycpR/jRBq53OICswo5Kd3heht1tbjhwT4v0dzVNhViwge/Hh1t+ecX22NQYfypmGsbE8JSnUdYBGRKCW+aFz2yMFm9b0ij4nHGyBtb3QxFFQisU5onkryegaqtMmmuNIAKDYERucaAxcmlMz3tBCBjx0IXKrEInUkcylihueMmlBS1D+vB5gf1CkeVetMjXArGE6NNFQy2cqba3xcRgReRjYoEEnXKj9aze9cuJsHOs+MIK6DvIOw/DagCFhqPDYtg5M7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 14:49:39 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::80d4:b482:3e2f:ae9c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::80d4:b482:3e2f:ae9c%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 14:49:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 5/7] mm: thp: split huge page to any lower order pages.
Date:   Mon, 17 Apr 2023 10:49:37 -0400
X-Mailer: MailMate (1.14r5963)
Message-ID: <1EFDB083-B8A4-4CFD-B541-14E3E7D2673A@nvidia.com>
In-Reply-To: <26723f25-609a-fe9c-a41a-e692634d892@google.com>
References: <20230403201839.4097845-1-zi.yan@sent.com>
 <20230403201839.4097845-6-zi.yan@sent.com>
 <26723f25-609a-fe9c-a41a-e692634d892@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E27FE2B1-7DD0-4834-8A18-60CDA8705A11_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0341.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::16) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3fa59d-3b4a-4996-9d64-08db3f52f85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/T6iRA3hKxCSbT0PcowKvqtgZwqImBqPEZpuskvE7uImluQh9RKdPKyQlJg4dU+T9fuBcbq5P/ml08VVCBdm2W5tv6YR7qgF4vvIUBs2fT5UStAQTE7aA/UcswPuF816aneol6Ci2XbnTSnl1lwKUl0Kg1SRwfg3ptJQ8wDo6RzQSJO8anzJu5fabh22atbvNYh5cL+279Q5ZLBx6xLpkeiC4ym0RsglLazcYpVvYYSU11vMGCJRzAgZ9Rp8hu/47mFe8fIaGOFn19WcamM0r3lufNbiPGKHqbriJH1linvEudKxskgF1Su1Gq7W+vEpwXIXhd8uFjO4nDd2RZNj9mBb+FQk3i6CJxfwLuxVCTeqWOX7/0ymxy/P2YpW0KO5rAWGoINg3EkaF5C9OX2UrzYzL7GRjoxGBlXzo6lrujk4jyzzzWXMIdXEwh93/FqYp1AMzjhtUVjzQMwje0L53jfYhQQu2mCbQFrSXOoip+9rCZsnFjvtPNdIOshPnUxOjfQx0m1vM36AOUZywtp3qWrZRohDjUXsr89da70+S2IGqHx0mcoYY1N16Hp7cRcQ/yEEKN2Wl/nIOuPEiyYrkUF3Oo6LTR8vCI3b2qxXV0nlNkEFN0fBsYCTkldT3n/xx7WCI3kiZpVj4JiET0GffXuqAugU6j5HeJUIax2rLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(2906002)(54906003)(316002)(86362001)(2616005)(83380400001)(33656002)(53546011)(186003)(6512007)(6506007)(26005)(38100700002)(6486002)(478600001)(36756003)(66946007)(8936002)(5660300002)(235185007)(41300700001)(7416002)(8676002)(66556008)(4326008)(66476007)(6916009)(14583001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BSYdTiAlpuRB7Da8EceMRfQJuD/wrzsdDCQfdqDM46W1rv8uQNYZtl2BUgsC?=
 =?us-ascii?Q?wsq7cWSebVGirDzdz0DwkMRhY8eBkWcIYK1QxJp60cimap0Ezsl3tBITFwSh?=
 =?us-ascii?Q?7UlL3kBBzbfnbMjmvlCWm432KmBo262dPz0sFsj4ZKtdb5acXjYF+DMfohYs?=
 =?us-ascii?Q?u5BT4QBeCA161qXgVKXCx/qWlx7sV40msbAlXkt7jaq3m7N/n2kpa5yLnu6E?=
 =?us-ascii?Q?NI+gDvupCqbpQ94Q/XMoeKrzW7q08hdVxak6DwxV/jZnD0ghjOYNbagLKAV0?=
 =?us-ascii?Q?K/HCoww26WGR8cwl+23i73Hra9mJpRx75A6saheIoG2oOXyU1tYk/opb5VIZ?=
 =?us-ascii?Q?NHbc0H44uNhAMF+M0AcVlSVRiUzNa4ODRGEE94ts6mP0YrmcaJugIrljmtx0?=
 =?us-ascii?Q?A7PNjiib+bJ8/7gekKkDFOg63sDFX2pYjcludXxLGO95/mOK6KQZDJGUFSyM?=
 =?us-ascii?Q?OF3CVLph+tWwN4SihrJT2hEAOdSvpB2eDPWPJqx0RJgAglPJilgxBGVH1E6n?=
 =?us-ascii?Q?Zzwcu3PaetuJgog2djfz+Yiwl3FChn4fvSHvtS8bys8Gz+lNvdbiVYxpN/Pg?=
 =?us-ascii?Q?plkKUSxcO4/Q1Fi+HB41IFiSAx1vjDpZ5h55dxxrizqmwQk3oQQPuf0Sjfas?=
 =?us-ascii?Q?/SZ6wl62d4/RpJtaqkoelt74oNQhiV/e09l5hFW+AjYpGRWguVe/gG4CKULG?=
 =?us-ascii?Q?M24vAH+XW8siTlyelsaN83x4PGARPGh+boMkZgcK5AMCijGUBRieCDMVE8qC?=
 =?us-ascii?Q?tybHhhOsF9ENYr2ftx/ZhY1VJBu8jZxvxVW2sFfd1lE4mYmKg7EaBBcaAV4j?=
 =?us-ascii?Q?N6K8zjuPmSLOJZtRBIFuXLzr9H/ChCb5Fd+QL9NYJ5khu8rMArEJ+8L68tl5?=
 =?us-ascii?Q?tnnpwVBHwTD2tnwW4iTmhk5z2z5/k1OgAaHPo/VB+roktOfJZwUeFj80bXHj?=
 =?us-ascii?Q?OBhSYi63J1VosmDboMHNVFJsN6CBeed4tU3mQSsvaYUbcPlJlNU+ubYMqvxX?=
 =?us-ascii?Q?jPqyWSxentHQLaMsnIkZJWflyW49r2VVYF31kBcZ3PqSbwKbueObgOgTYUkr?=
 =?us-ascii?Q?yq3KUl5rmxJcwwPUnAXluShfFiEcu7UpEbW2HFUZP8syxRvjdpSR6wTyHhIo?=
 =?us-ascii?Q?sAqo3tH2uwFjqB/NhoESMrCUxxDd41BE0FeEGAXafYpVDTpropyyZX4togHM?=
 =?us-ascii?Q?EsEDXImaw5xmjCh77CRXFwJl2WC23Iw8RP1iKMir8pJno6SuHUjUZZYHCgwG?=
 =?us-ascii?Q?DGp6jC5FS2Og4MA+ry8T34XB9e1NHeKRqUCB8UBNHPyRXnidEXd+TAy7CO2D?=
 =?us-ascii?Q?grq3ud/4zKReaYiDOvHuO0fmp7F7Yk0kJVuT7tu2zpaEnBZcnsdMuKAYjJ4h?=
 =?us-ascii?Q?qNQekhGKuJ5E2UIB0HVRz4xC0KPQ0uGab+mcRPzT7L6XYr9vPJ/6mCTlsBCZ?=
 =?us-ascii?Q?KCllSkdap8KCKOdgUpd++asDcZoYiEa3Ugt1WHFlt62JzgqG5Hz67PWntDzu?=
 =?us-ascii?Q?nNzFQ5zE2beIFyeXUBWDY19zj7aGiWC02T+ULm/Ey+sGhVKQAb536vD61TZa?=
 =?us-ascii?Q?WFHUbdyKQugO7ClX05E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3fa59d-3b4a-4996-9d64-08db3f52f85f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 14:49:39.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2lqSd1J9lu1aEZfEb0m/q5tzMECMh4C+x0Lz8Lbo+fym37lCRDTrbPyJiMk6NJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_E27FE2B1-7DD0-4834-8A18-60CDA8705A11_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Apr 2023, at 15:25, Hugh Dickins wrote:

> On Mon, 3 Apr 2023, Zi Yan wrote:
>
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
> ...
>> @@ -2754,14 +2798,18 @@ int split_huge_page_to_list(struct page *page,=
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
>
> This part is wrong.  The problem I've had is /proc/sys/vm/stat_refresh
> warning of negative nr_shmem_hugepages (which then gets shown as 0 in
> vmstat or meminfo, even though there actually are shmem hugepages).
>
> At first I thought that the fix needed (which I'm running with) is:
>
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2797,17 +2797,16 @@ int split_huge_page_to_list_to_order(str
>  			int nr =3D folio_nr_pages(folio);
>
>  			xas_split(&xas, folio, folio_order(folio));
> -			if (folio_test_swapbacked(folio)) {
> -				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
> -							-nr);
> -			} else if (!new_order) {
> -				/*
> -				 * Decrease THP stats only if split to normal
> -				 * pages
> -				 */
> -				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
> -							-nr);
> -				filemap_nr_thps_dec(mapping);
> +			if (folio_test_pmd_mappable(folio) &&
> +			    new_order < HPAGE_PMD_ORDER) {
> +				if (folio_test_swapbacked(folio)) {
> +					__lruvec_stat_mod_folio(folio,
> +							NR_SHMEM_THPS, -nr);
> +				} else {
> +					__lruvec_stat_mod_folio(folio,
> +							NR_FILE_THPS, -nr);
> +					filemap_nr_thps_dec(mapping);
> +				}
>  			}
>  		}
>
> because elsewhere the maintenance of NR_SHMEM_THPS or NR_FILE_THPS
> is rightly careful to be dependent on folio_test_pmd_mappable() (and,
> so far as I know, we shall not be seeing folios of order higher than
> HPAGE_PMD_ORDER yet in mm/huge_memory.c - those would need more thought=
).
>
> But it may be more complicated than that, given that patch 7/7 appears
> (I haven't tried) to allow splitting to other orders on a file opened
> for reading - that might be a bug.
>
> The complication here is that we now have four kinds of large folio
> in mm/huge_memory.c, and the rules are a bit different for each.
>
> Anonymous THPs: okay, I think I've seen you exclude those with -EINVAL
> at a higher level (and they wouldn't be getting into this "if (mapping)=
 {"
> block anyway).
>
> Shmem (swapbacked) THPs: we are only allocating shmem in 0-order or
> HPAGE_PMD_ORDER at present.  I can imagine that in a few months or a
> year-or-so's time, we shall want to follow Matthew's folio readahead,
> and generalize to other orders in shmem; but right now I'd really
> prefer not to have truncation or debugfs introducing the surprise
> of other orders there.  Maybe there's little that needs to be fixed,
> only the THP_SWPOUT and THP_SWPOUT_FALLBACK statistics have come to
> mind so far (would need to be limited to folio_test_pmd_mappable());
> though I've no idea how well intermediate orders will work with or
> against THP swapout.
>
> CONFIG_READ_ONLY_THP_FOR_FS=3Dy file THPs: those need special care,
> and their filemap_nr_thps_dec(mapping) above may not be good enough.
> So long as it's working as intended, it does exclude the possibility
> of truncation splitting here; but if you allow splitting via debugfs
> to reach them, then the accounting needs to be changed - for them,
> any order higher than 0 has to be counted in nr_thps - so splitting
> one HPAGE_PMD_ORDER THP into multiple large folios will need to add
> to that count, not decrement it.  Otherwise, a filesystem unprepared
> for large folios or compound pages is in danger of meeting them by
> surprise.  Better just disable that possibility, along with shmem.

OK. I will disable for these two cases. I will come back to them
once I figure the details out.

>
> mapping_large_folio_support() file THPs: this category is the one
> you're really trying to address with this series, they can already
> come in various orders, and it's fair for truncation to make a
> different choice of orders - but is what it's doing worth doing?
> I'll say more on 6/7.
>
> Hugh


--
Best Regards,
Yan, Zi

--=_MailMate_E27FE2B1-7DD0-4834-8A18-60CDA8705A11_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQ9XIEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU+5YQAIaT1VlOupXgx3vGwTALiqgfGq0c0ypYIZOM
bQOYetyTLiI0v2U1fEFibLNDhIQMrozTK1YQFf6hGMgzWWZToY8diRrLKI/3wurv
VfpE9CW2Exg5GchTtixI4wQ4/gKd+H75WLZ6qaaIvCFPL9R01J1ZiDKYwve2NG3H
KpJ+vgYQk62VHIhtuA+s62UoLzpr8Iz87vhFYMQOchUYvtNHmhNMhmNfv7MjhhyU
/FzUZeE/mDckFxRkXIvFyf9SltcLQX9IyMrucnCEpz/+5Ah+K8j1QdTNe9LP6Fja
IfbevN+dHmkKrCrH0ajfJwlVGjiBXvFBzXGNogzO+ukZP3+xSgRY/TWwKGqsYv8D
FQz0W/6HmxofEjFu6KcTxAbPyK9DU/CND7jAYc0SQPMg1snP8CSs9d+hifJg1Xqb
04lsppZMbbqX8tyen5ddTLTWiU/gk0KZxYRrbIhF2rwbACstGmvgShRUa3ux6G99
+zGVzv8A2jjQJWMChdShVqoSZ3jNsz2rggG4mfaTCLLs+1tlv5GlUaHDpJVSKVV3
8GZ9bPIri3VERUqwXvQcnm/BfcUhuzpAJFH5CuWkvs7wJtDH5i7kE2is1mn2ZKXf
qUAL2XuMlYJRGtkAgumz/jqlbwu3SBl73Kf88/kkZQjbagl9uHDjmLnlsNXEbFIU
HlW/6LOg
=XWIr
-----END PGP SIGNATURE-----

--=_MailMate_E27FE2B1-7DD0-4834-8A18-60CDA8705A11_=--
