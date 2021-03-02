Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA632B4C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354196AbhCCF2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:28:10 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12195 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351738AbhCBRti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:49:38 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603e7a4d0002>; Tue, 02 Mar 2021 09:47:57 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 17:47:56 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 17:47:27 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Mar 2021 17:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coixYDaC1yGBCeCC61W/5QxcDjXwUaL6nRJOAs/rNvrIyqnVdo7Ygee+5+SHVmlSVjlUL+UTsJv3yQA+8d6wbRRRSiK6gDuFVvqJw2xJuA5DuuaHyKcHlnQFv8BLEn+Tcy35ach+BmCEKQmrIvsWqmV+5jt7O41jtZz3v2f44rCW8OEafME2aIjf5YLpsLVgTViorG5EQo85aVldnhkwN5o5YEBN/sjSNNyzemtJ3phK7gmENVAlkrfuLzvzG8+LL5J+9HvT/CfpsYnE/wJHr0j2LuPHatefnnatntkPUHU6W5ElEBQIVGw1jKhc3HjjAb4tzZhZ6pQEkg/FJfEJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MX9Lz33D+v3gHgjyq2frdDH1IJLjx2IxBYwOSHJkR4=;
 b=QgBv8Z8HGj+bm7jdKP1Ct1e244sGNwIhHa24AZuAASogCJyaxN2A0LvCW/2Xqsi9eSf5O9QYa4A8KtVlpLgf3hJ7A/4exj+ziWSsiMzhb1CCLiiZZL+1TGjFpRr4iqkhbO386UZ3fptoYw/j6yQMXje64KEj+U4XfwisgrNk/nYYyY85udY6XTl5MBwH/jQgGUVRcUXLYHTrrm8LAdlDSC7v1mViWrU1OF57i0yiAmR5fhuYl3nzzzp2BIRSWF7gtFE4Jf+JqJ6sNkIXAezhu2U1yfIszyZ57WtDAxSws6XetE5AhWziWhZM8MFmsf9TIstUMr2Xm0CGFFgm7GscIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24; Tue, 2 Mar
 2021 17:47:25 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 17:47:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 01/25] mm: Introduce struct folio
Date:   Tue, 2 Mar 2021 12:47:20 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <261604C5-E25E-4216-A9D4-BD5490E5E89A@nvidia.com>
In-Reply-To: <20210302132249.GX2723601@casper.infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-2-willy@infradead.org>
 <68723D50-AFD1-4F25-8F10-81EC11045BE5@nvidia.com>
 <20210302132249.GX2723601@casper.infradead.org>
Content-Type: multipart/signed;
        boundary="=_MailMate_075B6C17-6BA9-4434-B07A-489391131A4F_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13)
 To MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 17:47:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a646e00-b33a-4725-42b2-08d8dda33d1a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4583:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4583C27C14F5E3B8BE96C9DCC2999@MN2PR12MB4583.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IndMuY3Wh7bTfz6zM2i0L9bzSFOor5qxdjcvJiLP8/qk2ytDMapy/OcxBUaqyyrTYmrr4d4Je54LwHE1E/GG+D1a8x/sgcbtOkAhTGDhhZCWsCmN7r5McIWnfQPjhjmzMaV3OXsfVdiS7vJyYNHybPwzs6tc9YfvYPrVQV/nSULyom8tlX6N/Jx/8RQKgEe9gGjels0ekVacWWrXhxN5CjRzcr2/yBnFPbDRSg0Xh0mtP7I5yZXlpKmCEJSGyP/gb5wgq7aD8lDBUHlp2n7VR2NwNp/7a2KmfT1RRo+A70JGSE6ar2A6ZONO1TyoSyyTaCFWKDl3BFilAqgvBhvqbYUdANf/qzCbttgjCTcDiSEe2pn2/Vc7T4Wb4e42r5bwIlX70eoLBAlP/MCQDKdG3VkKDt3HdWwRdt4hEJRQTjJPvLloTDElRrnCrMsBxldkDlYYxHTmFXrozpQ6xqe83n0cywE0J1Ap0GgA2e6zDmPu4cVQ7maMfpX1LbVXiSD0RD/RzuhrswBH8NK8gBqKjTBxGgUYk/ewce/M1K8vZsa/3S79oBNm+RDDnlX0xIU6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(26005)(6916009)(956004)(16576012)(316002)(2906002)(186003)(8936002)(2616005)(8676002)(53546011)(16526019)(33964004)(4326008)(36756003)(83380400001)(6486002)(66556008)(33656002)(86362001)(66476007)(5660300002)(235185007)(478600001)(66946007)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K3pveDU5Q3hrVnFDVndLK0Zub0xZVHR5MTJXWk9sNzNUVkVEWlVDYkI5ZDI5?=
 =?utf-8?B?enB1MEpVUUdmV3ZCTDdMeUt4MnNoSEpmMHFrUmlzOUM5S3IxS3ZDN0JSVndi?=
 =?utf-8?B?OG0xVW82OWE5VEhiRXRYaHBMT2cwNEFWQ0FadGZpdVptL0licmJOYjFyS0N0?=
 =?utf-8?B?WGtJRXRocDlCbHB1U0lQSmJFaTdDb1NRUnA5cmNqa2UxMG14aXdwY05UaGRE?=
 =?utf-8?B?U1NSRzUrVDcrN2ZIb1o1b0k4Qy9MV3BIZndnejc2dU5YdTZpZFRMNGZtaDFi?=
 =?utf-8?B?M3lHVXRPUGpwcCtZRnRuU0phVTl3VVA2aFZrQXozQ3MyR2RiNlJnaDY4L252?=
 =?utf-8?B?MkljNTdRYnJvOEpjWjE5UytsY3pHK0xnVVNjREZQV1JKMzFIdEdpWFFmc3Fv?=
 =?utf-8?B?cDgzT1loeHZPRXM0ZE4rL1J2ZUVYSTZRTVNsRzdKTzNiaXk1djZlZGtSenNK?=
 =?utf-8?B?MUxjTkQxdkJ3QUVHZFp3ZE9ZaGZ4VWJRbjZ3dkY3bHd0ZEFFWitEa2RxY1g2?=
 =?utf-8?B?cEgzaHhrT1d6TEZNeWt3WXBEQXdsRXBtYXQ3blQzYTYwTlYwTmRGUmNvWSsx?=
 =?utf-8?B?enZVdnZnUGFVYm9lQTdoRkJBQzd6MHZ3d0NXM3ZaRG9ZV3diME5RQjBWaTZR?=
 =?utf-8?B?SnUyL0RqSHJURGxCYUxzQjVJaXZqejRQSnhHTEdXTFZ6bnF6Q203cEFKTmtB?=
 =?utf-8?B?UGdHOHFLOUM3dk85T3JVTElJRkdZd0JScThxdUUvMzM4SDJ4emdoS1MxTTVP?=
 =?utf-8?B?K3VGckloTm53SExxWUJBQndJc0dwNmplcEUyR1laS0EweUg5dXRZSmMyTUJz?=
 =?utf-8?B?cDBnbHVhbi9BaytlN1RuUERISk41eGN0OHVJRWhDNWdqZHB0VUZtdWFCV2Yv?=
 =?utf-8?B?QzZRK2xBckRhVVZSN2M3RHYxSjJPVnRxdm8xRllHZlpBVkNXUURTeWhzYmhY?=
 =?utf-8?B?QjRITlo4Q2g0TUgvOFVRazljTFdYbm8yWlJvb0FGZDJsV2xDVFZzVTlGemtv?=
 =?utf-8?B?b2Z2M0xsMlBlRkwxQ3lTZFRzeVk1b2kvL1BTVytibXJ0ZmkyM2lMbktxaGZM?=
 =?utf-8?B?aUZxUlZnVDU1dGhPR1cwZDFsUlpIdklVMmFJeEFkLzg0VEt6d3N3Y0VSYWpP?=
 =?utf-8?B?VFUzd1Y5OEJ0VDJYeVZFZnBhQ2Joa21zcVRPMXZYOTFmdTYvR3JJczNUSTVV?=
 =?utf-8?B?QWJoenpVeHNPVER0NHNGYmNTa0JwWVN3bnh0eFplT2JuR1hMTEU3SFJ0RUVl?=
 =?utf-8?B?ZDJXbzBVa1psVDRvTDhpUVZkR1VnNlI4UUJSS1pxbzZKdHJBajI0UzdmTmFk?=
 =?utf-8?B?eGllVm1CUEhLOElyYjlWeENGS00yaCtkZXZ6Q3RTcEd0YkhiWXFIak1WTUZW?=
 =?utf-8?B?THpJZUhqMGhuV21VTUc2ZHIxYldyRUxBMWtQNDlGOERoN1hhdGx6T1NMMnRM?=
 =?utf-8?B?cHlHZHczcURHSmVoSHFPY0syc2s4US9rR1hBdnJFbEZBc0tMR2Q4REMrb1py?=
 =?utf-8?B?MFllUlhDKzVGV0NpcUpQTGVBUVFQTXFYRklWd0NzbmdIUEozcFZCdVh1cGdX?=
 =?utf-8?B?RWlSNUdYL1VOOWh2M0FPaFVCKzhUbUMyNUJ2azJTZ1RDbUt6Mjc2KzBDZ2Qz?=
 =?utf-8?B?ZElhc1J0Y2pHaTlGeU1ieGIwbWdzZmNKWkxuTEtkUEJXbmpDcGVQaU5PRFJs?=
 =?utf-8?B?dHhiMUFndzI1akpQaG5kZHRXYmREa1p2VUxUc0l4bi9xVDluQXNmOW9FdUVB?=
 =?utf-8?Q?Gqrt8X0bJOGL7sFrZinCMV/51oUHGjKi0Y1jXS6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a646e00-b33a-4725-42b2-08d8dda33d1a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 17:47:24.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdi6IMJteJGNfeDPKXZbMBsyQmmYnhvKSWyiNzMA8OJUxNK9en5/EUfbtasdBJJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614707277; bh=FRwHBwaT15NEpPS7Itfi/1XGLi0mbWz5R19IKSZt5Oc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:Content-Type:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:X-Header:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=sCQEsjQmusifSQwt21Un6WNW9VHZQPV/h10baNZRLFQJTRZ+oII2ER0ZzTHX5oIN1
         Es+70zvyljFZX5QQOriRi+uviUvg3qgrKE6az+L4nmJdZXcgIWJr8GE56daiJM7FF5
         5zUENTW5geA8GkRV8CLnYYXIcuJu5PDQhNY2+zOu3TP4hIqPVnsyhd8CL/hAKVlAdP
         2RMuiZ5EnWo9gEvdxbncPNre/QECd5IfhssaxifGmzWlOw6/B9/lWNPSMqrSghgLCI
         NTDyRCW/XMORaSDRK2jBxiZ51COdBvBZmgw49LeQZ5QM35rlpQYUMkYMCTeBsp0HJP
         gXgVryaTQmeFg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_075B6C17-6BA9-4434-B07A-489391131A4F_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2 Mar 2021, at 8:22, Matthew Wilcox wrote:

> On Mon, Mar 01, 2021 at 03:26:11PM -0500, Zi Yan wrote:
>>> +static inline struct folio *next_folio(struct folio *folio)
>>> +{
>>> +	return folio + folio_nr_pages(folio);
>>
>> Are you planning to make hugetlb use folio too?
>>
>> If yes, this might not work if we have CONFIG_SPARSEMEM && !CONFIG_SPA=
RSEMEM_VMEMMAP
>> with a hugetlb folio > MAX_ORDER, because struct page might not be vir=
tually contiguous.
>> See the experiment I did in [1].
>
> Actually, how about proofing this against a future change?
>
> static inline struct folio *next_folio(struct folio *folio)
> {
> #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> 	pfn_t next_pfn =3D page_to_pfn(&folio->page) + folio_nr_pages(folio);
> 	return (struct folio *)pfn_to_page(next_pfn);
> #else
> 	return folio + folio_nr_pages(folio);
> #endif
> }
>
> (not compiled)

Yes, it should work. A better version might be that in the top half
you check folio order first and if the order >=3D MAX_ORDER, we use
the complicated code, otherwise just folio+folio_nr_pages(folio).

This CONFIG_SPARSEMEM && !CONFIG_SPARSEMEM_VMEMMAP is really not friendly=

to >=3DMAX_ORDER pages. Most likely I am going to make 1GB THP
rely on CONFIG_SPARSEMEM_VMEMMAP to avoid complicated code.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_075B6C17-6BA9-4434-B07A-489391131A4F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA+eigPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKbuMP/366qwt/v/jgjUVAR1tr8e2dLB+bg/kNr48I
CcpMMGRlFnaVpQh1sLZUo2Tj5OXW3yLhihNKF+JFjq7Nvlb4kGjGVp2fiEE/XCn2
qvvcMruLtx6wM5xKbNMQr7LbNz2V8r1/QoE0y8EodnKY8hkVHldyWuhEmKvIkCXD
sMViFWOMq66MMSH7ViZnUYyBa/HgaPHu+S7FyfoyoUZMvHHpXIAu7CRmfH0Q9BiK
KhwlSAawJTDZTibX29gtlalleQUo7X9JWAT9BmIqkFFvpgxR6XU35ZfVlB/p9L7S
f8OzxbggcT5lJiWmddqnUSi7BJcosWv4A77IZTA734JzhxXupSxFKkUy0BJ7ttSo
tB/AJltqfTlbcGmI6siUePd1Hm8R5rqOi6i2/OwNb0fE+b5y6qT+LwSOI28GF8Rd
pg7FgBtNpBimlLnVs8l/AE3KRL8GsDTKpGB6WPsfalf/tYvYhQ48Kz1ByNkEK//C
PND7AvJb3Msz94PX7TlHQas6M6T8nwVOSAwJ2VvPFy1F3yribPfrQa2CJfkQucIj
wHNDR+uigJWBOEIN5vhkjAjKjaxQz6PUmL2e5vwUcqQW50aO8itzTVz1Om9Q0CEG
LPM81PDdM5UIsU3fH3EH/W3DWcDp/H1nQ6lj/P+Ag/ISAGTPyia1CuxdOcd5vlg/
k81VOKot
=mJQn
-----END PGP SIGNATURE-----

--=_MailMate_075B6C17-6BA9-4434-B07A-489391131A4F_=--
