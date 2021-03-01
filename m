Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF3B32937D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 22:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhCAVU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 16:20:57 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1994 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244227AbhCAVS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:18:27 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d59fa0000>; Mon, 01 Mar 2021 13:17:46 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:17:45 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 21:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWVOGZpEPtmUtyrJGzUydUrwT+tgGdwas9KAvszF5+YLlZmreq9K2g0ac/BZ89C11qTDXIE4mWRXF31YE3ADLT0HxCBf6O/2JZMDUOX8RdSxtWI9yIMF+OGZ8INXjHrHhHUQAQu9MAPFoCh2y4mOxiymLaDpQrUl3qMRiYQe91ElFMzClAAmfjD4N2dKiksM8rbvE09ehuu0FH3gkAGJDijILLOTS1cDN7RXjHakOnDPCwF/E5jBuXHih7gmjHy6TPX0hyq/OcrOBMJ5gDaPLZ/bf50kKkhzU/6Cabo0fW+SShhOttGwtYtp7LZkH3bsRkrFFFJVHjn74OsXmufqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/VlZ8GVVJez4DnkCb/2UEptumWPDzXUhsXqkGxVExM=;
 b=h3A4TE8ko2Rqp3Mg2ISkdYvlQrMvWdrq/+GkcFDM9N6K98CdXyXWubrR3WyyuaCykdB2VhlFT9s3G2gjMI1aQglcgeT05kqx26vZWLaoamVD3j1e6Hpg6c0F1l61RQMR7zPSUQSVkRaQfsmC3Ry2V5YcXLgqP6ztc5TsUUFUkrknBwidCe9qLAetYqdd6WCwd5d1rjvC5Wg3wX8/1WBi7gf0kKlv21PPLtINh3P3fpOi9T93ySt929INLHbXYaQdkzy0lVXd+jeplbZhp1Ohzg2+5gdyGfNwzSsZ1kFOIsvzVsiEym1D3Svsr08Gpsabl/hEmmTF/qkACrmW58sOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 21:17:44 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 21:17:44 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/25] mm/vmstat: Add folio stat wrappers
Date:   Mon, 1 Mar 2021 16:17:39 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <FED22A41-FCD3-4777-9433-69990C145C7F@nvidia.com>
In-Reply-To: <20210128070404.1922318-4-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-4-willy@infradead.org>
Content-Type: multipart/signed;
        boundary="=_MailMate_14715C1B-E598-45B9-9046-A1F2C5E7222B_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.10 via Frontend Transport; Mon, 1 Mar 2021 21:17:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76faed03-620b-4a6f-b590-08d8dcf7747a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8760
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4486BF3BFDFBD277EE0E7277C29A9@MN2PR12MB4486.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yGuAHdP+NhZWIL1adGpwR+6o3Jj5nHt36lqtyXl6GAaCw5bz0PtHd0sFrepCintuJTGSPW/zf0kZDdE1RpLKvoLByfe+WxhX2rm7UoW7cO0ECbHMnVbKnCzaj8At5AxNbtGjVTflxoI7+Xga7XUIMSRR/PwM7U/YBIpJpd3+YHQXMFW/i+WxoR30vkJL5ZNxlRAuRGfhTZSUlQY45N8gqpZAtTUAJApnwjgPE5hWujAs8PwAt8THTCG1hlzHzCh+dq0AUuqKZZqBus2c3zUsKlAE1cOlPQ93V6VZR2SurxvOa28kaKmGZa5alr2fad75ST/ANLSS7spipw6G668qw2pdQvmEg1ISzuNWTVexB5JA63NxyOLcIpdEOzKaeS3cTrQivqo02M1fF3n6uWFI7PEH8EHkoLps4hADYCMk5EHt0jHZLqDJ0Diig2FayxzQ5XJB45ClhRAIDnuKZyYqZbYAO/HVEpfokbjqI8q6I+B3y9ZMQe5oHEYVU2SlHaVR6Zh3idXfwNdw1VUKjTRK9iZW3ZUSMlw8fRXeQULO9xorq/4uzW5Z3pkKuGNLBa3VQHR/np1SpkwHneScRt/ODp2Re8j2IaZrhWZTbs1Y9vxh59nccQ/ctacxXCUY3mOzqyq+3IHfgHTavKxd1AROiYnT16jhPcOpVS5otPEzuKwAr1BUKdDAhfQkmGIDFx5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(53546011)(33964004)(33656002)(8676002)(83380400001)(235185007)(66476007)(66556008)(66946007)(2906002)(6916009)(8936002)(5660300002)(956004)(2616005)(478600001)(36756003)(966005)(16576012)(186003)(6486002)(6666004)(316002)(4326008)(86362001)(16526019)(26005)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eStPeTBaSDRSTWZzN2NOaC93VFFndytmVmpUUE12NURmSTlPT1kxMnBaK2dk?=
 =?utf-8?B?dkM4dGVzakdsNFVUYm1nTDRkaHNvRGwydi9vK0pYd2ZsYzQzU3h2QlppR24v?=
 =?utf-8?B?ZXRVQzl5eUtmS2lIbzYwZ013WGxoWlVrbUJsMURrSXJTNjZvb0RoNkRNUndK?=
 =?utf-8?B?S3lObEU3ZjF4MEl2QXgxdkU4Q2VRbG1uRnFta0JBZW9DZ29CREpwb0g2amMv?=
 =?utf-8?B?V1Y4MXNjQTJGUHV6N2o3UVhpOE9rS3R2anBTSUZSeGdjUnBabTBXbWpWd09l?=
 =?utf-8?B?VEE5enhkbWk2bGpkU0F4b2pVRUZ3bTBwK2JrM3ZmemY4eGFTUHRYOS9WbWlj?=
 =?utf-8?B?dVBneW04TTd4SnlWY2Z6MUxFNnFhMm8zRUFrbmZvdytmcTFnakZLaEtkbjJ2?=
 =?utf-8?B?MTdjbUcvWjVVdVZ3WFowUHQvaXpxSm5HTW1BSFllUGNaWlZlVXpqT3UxdjRa?=
 =?utf-8?B?MXBKUStQdUMvM2U3SzhiRncvaE9IelZtUnBHaDhzclU1RTkyUkVaNzVCcVg0?=
 =?utf-8?B?TjVma1Y4Yk5oOVJHcEdSaCtuNVQveXJXSUZXNUhzRGUwQWltT0k5d2I4RFJn?=
 =?utf-8?B?Uk4xZmhOOVBONElOTEVHMGVybFFKcVlGS1BRQjJOQ2Vub29qRHQ4b2N5emdI?=
 =?utf-8?B?QkVkOUhXWGJLMURwY3ZKSjdaRUJ4R1kyNlZCTGdKSmxxaGNpZXovZzRmM1dI?=
 =?utf-8?B?blRBbTA0MGErSkRTdHdLMUdKd082ZmVXRTVmRnhqNzBTNG51dkNoMXFwelNM?=
 =?utf-8?B?WTNoeDVnZ29zRExReHdmcEY1Z2VyYjFaNlRKTloyNFhSMHdUaE4xUmNIbnlF?=
 =?utf-8?B?OUw0RzZNWlJ4ang4cXAxcDRTNU1zWUZObUwvakMzSXQ1eUtqY01FRjNubmFt?=
 =?utf-8?B?c1pRTThwaGlNeG1mVUpVNEtPSGxuOE9OY1F6RkRmSEVScWgwU08wejFyR213?=
 =?utf-8?B?SFd3SFNsbEZoSE9HRzJwaHNYclBqd1MrcW9NZVJra1BXdzRaL3FqR2NXQWZz?=
 =?utf-8?B?blU4WlYrbnEyS1ZZaHp0QWZRVVUzSlFtUEg3Tm9uNjZ3bEs0QUM0WXdCaTBr?=
 =?utf-8?B?aTIwMlFEM2dHWTF6VFIvaHVTV01SQng2SnJ1djRGWEpXN0FTNjZBY01BckVu?=
 =?utf-8?B?ekkwd3B3aGV6aGZRS1A0dERCemxlVVNqa3NKOGVWTTlnb0NlU0xkRVVvUzZD?=
 =?utf-8?B?Zjd3cHNEZFJub0MyaFdpNzVTeGprRXl5ZXVqMjdOSkl4RHorOStLR0c3NUxP?=
 =?utf-8?B?YmVjNDRqaVJKWldVOHFPL1VlcEs1NmZQNzlHMktsUTM2aHdRaHB6SWt5eFRv?=
 =?utf-8?B?ejlKZ20vc0NEbnpVZDJLVGN2UVhzQ2tzSVorb3d6RmNuNm5oMjJLQ2FJUXZW?=
 =?utf-8?B?eVVsQUVLNU03SVgwbWNkbU5VWDJWa0RMY1hXYWNEWWlHUDFXMXNicDhmNXRw?=
 =?utf-8?B?TzBsUWZwYjFXTDBTc0tCeVY3cUMrOC9HclQ0Z0gvdGNUU2IwYUlJaTBBL3Jw?=
 =?utf-8?B?ZkhuUWRiUVZBRXc5emlyMUdzYjI4cWxlaGVsRHhrTjhCd2N4Z1hUZ0IzTDVI?=
 =?utf-8?B?S3VabDBvdHJPUEw1SDdHQU0zTkxRR0FPU3NuYytMcy9qTmYybUVoL0xBdlVI?=
 =?utf-8?B?K2ZPQ3BJZTlpQ1F4N2E2ZnRxbWxlUGcrbm9CQklwekRMck1zWGhFbEhJNkRY?=
 =?utf-8?B?aGZ1dHJocWYvQ3dJTjJiU0tRaExhdmlVM00rbEJEWFNKakNtRkk1V01ybzBw?=
 =?utf-8?Q?QKQNBh1PVtIh4AyIRj6CgO2Uhym20Z1yrt05S+o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76faed03-620b-4a6f-b590-08d8dcf7747a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 21:17:44.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbUXrlOMxlldBSXAPYypNSf2bDq/o3Dqtvuq7OWaZp8aiW6FUNV9Tu2aNtyMZZOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614633466; bh=ub3eXwzdRbczRuKMjxlJQWT4P4TAes1f12H2xY8gi1A=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:Content-Type:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-MinimumUrlDomainAge:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-Header:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Iz1dZwl+HyhB54CL7o1rdBNDS5effw9+Yk93fDcgiofD0gEuB0bGUBv07HUTM4RC/
         NdJPFpp87ADaICwSjwEcWEjiMWlB+pRaYqVd7L4asL6L/YEO1OJIFQrCrwPhfpEYpx
         BxXIlOYFKfZFqpeBDU2AZkmgfRoK780FBUkcR+MXf7SEvw675RCrB8DW+4v8V5wk1G
         culy0mcLuLP4VCaD5/vzYe+3PA+XJS61gDUBK/wonujrrQx2meX+veS+BR2OrQ9Fd5
         2BKsZdeuv44iwjHcGG1/rmMRdEcAosBY/M903m6SJZbTGt1UsRlJeO/sbaCYg19vwq
         L5HvoOWWhx3Cg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_14715C1B-E598-45B9-9046-A1F2C5E7222B_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Jan 2021, at 2:03, Matthew Wilcox (Oracle) wrote:

> Allow page counters to be more readily modified by callers which have
> a folio.  Name these wrappers with 'stat' instead of 'state' as request=
ed
> by Linus here:
> https://lore.kernel.org/linux-mm/CAHk-=3Dwj847SudR-kt+46fT3+xFFgiwpgThv=
m7DJWGdi4cVrbnQ@mail.gmail.com/
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/vmstat.h | 60 ++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 60 insertions(+)
>
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 773135fc6e19..3c3373c2c3c2 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -396,6 +396,54 @@ static inline void drain_zonestat(struct zone *zon=
e,
>  			struct per_cpu_pageset *pset) { }
>  #endif		/* CONFIG_SMP */
>
> +static inline
> +void __inc_zone_folio_stat(struct folio *folio, enum zone_stat_item it=
em)
> +{
> +	__inc_zone_page_state(&folio->page, item);

Shouldn=E2=80=99t we change the stats with folio_nr_pages(folio) here? An=
d all
changes below. Otherwise one folio is always counted as a single page.

> +}
> +
> +static inline
> +void __dec_zone_folio_stat(struct folio *folio, enum zone_stat_item it=
em)
> +{
> +	__dec_zone_page_state(&folio->page, item);
> +}
> +
> +static inline
> +void inc_zone_folio_stat(struct folio *folio, enum zone_stat_item item=
)
> +{
> +	inc_zone_page_state(&folio->page, item);
> +}
> +
> +static inline
> +void dec_zone_folio_stat(struct folio *folio, enum zone_stat_item item=
)
> +{
> +	dec_zone_page_state(&folio->page, item);
> +}
> +
> +static inline
> +void __inc_node_folio_stat(struct folio *folio, enum node_stat_item it=
em)
> +{
> +	__inc_node_page_state(&folio->page, item);
> +}
> +
> +static inline
> +void __dec_node_folio_stat(struct folio *folio, enum node_stat_item it=
em)
> +{
> +	__dec_node_page_state(&folio->page, item);
> +}
> +
> +static inline
> +void inc_node_folio_stat(struct folio *folio, enum node_stat_item item=
)
> +{
> +	inc_node_page_state(&folio->page, item);
> +}
> +
> +static inline
> +void dec_node_folio_stat(struct folio *folio, enum node_stat_item item=
)
> +{
> +	dec_node_page_state(&folio->page, item);
> +}
> +
>  static inline void __mod_zone_freepage_state(struct zone *zone, int nr=
_pages,
>  					     int migratetype)
>  {
> @@ -530,6 +578,18 @@ static inline void __dec_lruvec_page_state(struct =
page *page,
>  	__mod_lruvec_page_state(page, idx, -1);
>  }
>
> +static inline void __inc_lruvec_folio_stat(struct folio *folio,
> +					   enum node_stat_item idx)
> +{
> +	__mod_lruvec_page_state(&folio->page, idx, 1);
> +}
> +
> +static inline void __dec_lruvec_folio_stat(struct folio *folio,
> +					   enum node_stat_item idx)
> +{
> +	__mod_lruvec_page_state(&folio->page, idx, -1);
> +}
> +
>  static inline void inc_lruvec_state(struct lruvec *lruvec,
>  				    enum node_stat_item idx)
>  {
> -- =

> 2.29.2


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_14715C1B-E598-45B9-9046-A1F2C5E7222B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA9WfMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK5vwP/RQ2Yf7WUuzv1kHd/+X8+glZaBOKwuVC2rif
b+mLQeqfnxY1BHwa1Dcmve1fjS3njWEu9/dm9OkQJCH3AGZEE0RaSiezuK40KDLE
d9ZvK4F2+V1NfbVIBvNml4okeIFBd3lKZTthU8Sr9Lo/9nyW/HOJa2+jkY8Qw4S5
jz9v9Jh7Onp36PLeNfYY4MTQKLGqwsT520eQFlpnIOjxh3bNjPy/F+7lftDt93jZ
JC6bnVanz+pYotiPChMKTXrqrFPRshJF3IjgiQqCCiadJimTNON/N/vGevCv1LFA
H+HSO68pRSU+wIQqNzvCugw6A9wqYn/pHccwz+kDVnwYXUcKqlLg/zOD328nhZVE
9XIQhv3HBw9zmr5tA9se4kfmQmChwN1lopVfp6PhwGrYYvUPv+AHOmOyEHtKaRlW
8HGUSlu+1oStcEI1p5b3ZBIjYmKEvWAihCYBULm00BeJWObzqMtMxRqAGEcvN0z1
7/LUNccDu/qLRNY1uOL7Gfhbnz+hngtX2H6E1FeqXxy0mdkZI9K0LMOuKuf4i9E0
Tbses4OR5i/06Ug4nDqyghRnxKLnGkz9OOoCzBRAwIea/3YvFOp1Rgqf45m1FoBF
ACeL0ifpqBER0fzva9KkU9qDf7b/KPPfKiiwrNZBwo2sdrlV/UYTFzNQQvtqONip
yMMVC8tR
=Hpqx
-----END PGP SIGNATURE-----

--=_MailMate_14715C1B-E598-45B9-9046-A1F2C5E7222B_=--
