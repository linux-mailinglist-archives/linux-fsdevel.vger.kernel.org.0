Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1D2329344
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 22:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhCAVJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 16:09:43 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15777 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbhCAVGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:06:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d57340000>; Mon, 01 Mar 2021 13:05:56 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:05:55 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 21:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyabvRd0p1RLoEdQUd9cSyOShhR7eXy3slk0YaAe4DePkCgPzOoMigS2QrU7X+xoR7ZEQctNqOJ64ARdR01i3LH2xAAT/gHSkO8dTs4tT5qAf1VYXPAahHM8mjErponMe4UWIQDgpt4Esv5S7s4ZmIUPoSrBRGrn4CAU/8r4UXDAQkp9KKIm/4m/1nEZ+2hj++fe+2gbCsxzOuas3WRuQqVnqN5IhpuxfPOX2tQllpUN6d0ep0SMlU/SbuD8j8JLsu8BUKAv5p8nU80LVBFzLnpeKp9qe3guT1JHixbZyLX0fmpnIOLiOuJs9zTjXuGM7sNABYCUEo5LdECECycTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/gC30Ik0MpAVi/nRfpdZwotRdPXsR7icEzP4NbT9Zo=;
 b=du+lHjTixevhhSyMNQVKNCiIlx3EzlkDpXdB+kO+mCP+EJ4CM6xyKBOjZkNAptvEzjHMO4bI/FdEfd/WABM6gb5ByLsATKnNWQD81Q1rxTlXKthMyC8sw7tpBjUNv+RibBBqHnpBiyqSQv6jqbFkJJERowS+GSsWDIpRwC82o02FiefWxs3r/JZGYReWI4wq7oEvuXXETd3YL+1cv7wa7cnTtBEUzdKQJcxkyPPFEWol6csn1Ml/Da9FZSj4eqO5fifx7KDcH8Xthszm4XsQg82d6JWmbV+kGdz1Ztj+pz42Ix8fhah8G3KclH7zonJojzyxT4myhjzOPG2bcMzhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 21:05:54 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 21:05:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/25] mm: Add folio_pgdat
Date:   Mon, 1 Mar 2021 16:05:49 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <4140A4A3-05E7-4A13-BB81-2AE4E0FDC34A@nvidia.com>
In-Reply-To: <20210128070404.1922318-3-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-3-willy@infradead.org>
Content-Type: multipart/signed;
        boundary="=_MailMate_ABEE9594-6CA4-45A3-8A59-49F4167AE1B9_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0342.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::17) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by BL1PR13CA0342.namprd13.prod.outlook.com (2603:10b6:208:2c6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 21:05:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4804c4aa-cc7f-4928-343b-08d8dcf5cd51
X-MS-TrafficTypeDiagnostic: MN2PR12MB4488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4488E6970ECD079AE2C1606EC29A9@MN2PR12MB4488.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6j80IjrKEXT4WQNJZvFaP5DlQLKkPDPTmzSXv2FMDpT78a+Phbk/u3TrwCf7uopROezaxruWR7Ekvg80AXXd1hXw8SZJIREPSx1+vp5GNJySJ+ezEQgIShFH9XdB8+gnSW/l4L96IkZ8ESWWcJgucL8Ybhr6ERu2/38hBe5MSOswlIcRlYGLN0+50GRs0/z/E06a2Je25fATafT9ZLF/sMSKWxJZnS8b9mFJjM9JJAitfI4B/hq2r+eLU3f3eZhMUzuUqWThV+bQcoYv6GhpqGrT2ds3sPp81SFr+sClN7yQFn27E9otwm9eJV28SMkIjAIo8q+HbGELQcFuCAi0D8pQTxUf58RPAuNJ08YxDKPbBBNVwg1b2yyq3UQcGOgInbj1h54lus7NHNdzFpbivMhBJBuLovFchn84WSBRZlcu/tWchAWdKJYBbXKUq18EPRsgiKwrpwUlWKLhPCxbCHGrUYus4hahBb2Z7nYDrhx2uGofr+osJGEsNQPxmd6fPcRrodvuAPMTHjMWNzmcWi4gyA5a24ACYdAh45VqayEs6IeiLOHd6da59H4QjgRYhmvivnvrVu3148nHBYmZV1rgkvzVPs28TdiJUb9vuK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(2906002)(316002)(16576012)(36756003)(6486002)(6916009)(86362001)(956004)(8936002)(6666004)(5660300002)(26005)(16526019)(8676002)(478600001)(66946007)(4326008)(66556008)(33964004)(2616005)(53546011)(235185007)(66476007)(33656002)(186003)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dG8xU3Noc3F1YnFyT3dkdmZRS01mbTZuaGREdWhOYUhLZmw1Q3dXN3V5NVZC?=
 =?utf-8?B?Q3NaNTY3MWZ3Y3NrMmhYdHBwMGRXU1BaSkRDTVp5d2s5MXpzQ1B4L2pzZ1ly?=
 =?utf-8?B?YmlqSjlZZ1Fwbzlja0Z1czJOUDlNRzI0YkI5YVN6OVFUK2JUbGxqYUtwOTRq?=
 =?utf-8?B?NXNORnlSdkFFUzFZbysvUkJKWnlNekdjbVlzajIvWXhFYnFPNzM0bm9MRFVi?=
 =?utf-8?B?K21Bd1REY3c1K1JYUC9ldmlBeVM2RmRTalVMWktjQVJZQ0xrdkZmRTJhbVhi?=
 =?utf-8?B?czYzZU5VeEFkSlZqNzVhNGN1VS9aRmZHMnhXQWN6M3ViRXE1YjdxYjhyZjE5?=
 =?utf-8?B?R1dsOGJWcURqZU9mcTcvOXZoNEFVclE1RWg1cWtXdDZIWmFZNERBVDRLdnBj?=
 =?utf-8?B?TDA4a0F5MVpjNHNMcVNVbzZWZERPclYvd3BtMXBzZkVZZWpidXQyZXUvQzlh?=
 =?utf-8?B?QVJ4VXIyMDgwM2JnSUJEbTVKM0RCLzBvVUp6UHV3WHdISlRXdlE5UHl4Wnlq?=
 =?utf-8?B?NXdWWTVISm9YY0ZGYzNBU3ZEMkZPcHk0WGtibmVyeWpuMTZZYnVQNzc1OG42?=
 =?utf-8?B?K2FaRk1BRnZaeWJhSi9KY2F1akM3ajV1NTBpbk1Fa2wrc2lTblIxaHoxZy9F?=
 =?utf-8?B?VnkrYlhCbS9MZGhHV0pHbkZ3RUtoaGtiZzVWZkZIUkFmU0dyTVNVeGZmYzlH?=
 =?utf-8?B?TkhzM1VXVmpwZzkvUER5NHVMZ3RYTm5CWFAwbjZrUFE3QmI1b2NoaE83OGkr?=
 =?utf-8?B?VDdmdHpUYnB5TjJlRXhWNFZhQkVxK0NiN3F5azNJWlU2MzA4cFRzN1cvZ0lG?=
 =?utf-8?B?UkxMWTRiSGdPZlk4K0trN2pXNUNsL0hWRklRUGwybXEzRUtwSlYxOHArbURl?=
 =?utf-8?B?UFRhTXgvNTFrVmF3UWZYZ210aHFDYWhkU3MvcWJQdFRsM1dpTmRRRnprWERx?=
 =?utf-8?B?ZzNiZnVxLzVRZ0FHWCtFYkhaQm1ERGNHbUJJQmpERGo2d3hDalhESWhya2NK?=
 =?utf-8?B?WEpCNFRZZDN3K2NEWExad0p6MndVNjZ3Sy9GSFNiZnhjNFQ3MXRDMDY5WUFn?=
 =?utf-8?B?VDI3QlRDTzd4SEwyVW1sOHRLRTBkLzBXckRMUS84T3IrOHkvS2xKcEo2UEVt?=
 =?utf-8?B?MGpON2xLd1dDUldmSHVUam00Y1hLQWl6Ynd6cjdqMlFsMTZSeVZNdGNzSzdE?=
 =?utf-8?B?MlBwSmFvclYyQ2VqM1RvVlFhdEg2VlkrL1VNdnI2cFNOVWpsL09XWHEwSU1M?=
 =?utf-8?B?MXBraUgvNndTVWp1dFFMMktJT3hqOHhyaXZDa1hhNSs0RDJGSUFIQVl3Q1o3?=
 =?utf-8?B?Q0I0eEZVYUFiSy91ejJLTi9QNWt3M00yWDg2aU5XTmVaZzJhSEY3V296bkJ6?=
 =?utf-8?B?TWtSSnBLMWFuVitOV0E3Z1RJSWYzZVZ3Nkh0cjdJYTVBM1RIaDNKWDkzWDEx?=
 =?utf-8?B?WDI0UnExeWdIR0gvWjN3T2phU3EzRWd6eDUzNUF0UmhkTjB4NFVQK21EK2E5?=
 =?utf-8?B?OTZ2SlBGTHJkVlluV0hVVWNHSVNRWG5JV1kva0ljNEEreTRQMHV0a2ZFNGdy?=
 =?utf-8?B?a2M3eW1xNzhndFFsbWhKZ1ZkeGx6MXpHSWxLQmRrNXV4aDl0R1BZaUNVSjlK?=
 =?utf-8?B?c3ZtWWprbDlhVjZPcWduZ1o2NktxV1JXdkVNSnBZUExWM0pMaks2MUFWTXJ1?=
 =?utf-8?B?YlByLzMxNGtZM2YrakJIZ0h1a3JUbU9kRXIxTlQ0Qm5pR2NrUTczYllhRy9S?=
 =?utf-8?Q?xID/jZMTURYD+ND7nxFGGXeczKthst1zJezgrnz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4804c4aa-cc7f-4928-343b-08d8dcf5cd51
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 21:05:54.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXUq9AtzDLhPhhUjCFCJH2Hbgxu3VdKc3rdF9n3M5XNNpH3rKbPDZIUEG/iAuTzO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614632756; bh=yI3EMQsXL78tRJkcrddD/I5l/8k94zEEqHf3TQbBVjw=;
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
        b=fCy27fi/r/I5XPto65qwE656w4RHO+tgnoAPYDzFgO52xUeNBwAX1J2eKrWY84+78
         8o1yz4tEstrj7VzsjhjnXOKb4TQ2zgHAPZo5xkokJMtXIIdAdmHWiFGWt443Fwj+gU
         6+KNZdZmGfR5I3gannvYn6QVM3yMObOJyQqbjwsaKNLgDuiTrgNGIWCSEnbm9t9EvD
         nY/Sl1YRuFURn5WgEFSzCjDKDowAB/MBFSfTdDr7MU7shFNQPDvbc17hA0cm1+fNw9
         7yitli8wVrnVGkr/Df+fV+pMxEVitxAjpx+TkR+wlxSVDdTVBAqZvs7ItUdf9HKqdr
         Hm0plEacI1SkA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_ABEE9594-6CA4-45A3-8A59-49F4167AE1B9_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Jan 2021, at 2:03, Matthew Wilcox (Oracle) wrote:

> This is just a convenience wrapper for callers with folios; pgdat can
> be reached from tail pages as well as head pages.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f20504017adf..7d787229dd40 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1503,6 +1503,11 @@ static inline pg_data_t *page_pgdat(const struct=
 page *page)
>  	return NODE_DATA(page_to_nid(page));
>  }
>
> +static inline pg_data_t *folio_pgdat(const struct folio *folio)
> +{
> +	return page_pgdat(&folio->page);
> +}
> +
>  #ifdef SECTION_IN_PAGE_FLAGS
>  static inline void set_page_section(struct page *page, unsigned long s=
ection)
>  {
> -- =

> 2.29.2

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_ABEE9594-6CA4-45A3-8A59-49F4167AE1B9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA9Vy0PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKEaAP/1vJZb6a6p+NGQvW7pM84QWKxa2jLvd/wuY0
grvAjlxMx3TTO7mubA56pQLHm4QbI423SanYa5qPBF6f9qt1gFxpe/NoN01i8BmK
RmZLv1tBrIFIaVkAyp+k1+C4EctDBTKpQPUCRXQiH0mGM4PNNpBrMHF3e3sjaPAl
pe75r4pLG+heyd6DpVjPaBx4Zr5thixg0+6gt64mFImueLZNXrNPnro4P0TasHXo
uif6iBYrWDgxz3OqZJCpYAca+E8vNWQc4SzCliaWM4ioydgEOAclPwVGWQmfUFgu
TFcPnuILsWO+k8/dCbwGDFp6ifGmEZlnIJGc8zQZRnl/1hOMd6+e+tUlTS6NUTTM
DxkYXPqh6mUFxjPyypAuC4Gnkr/Xnq/qsUoJ/ftSyYJa2YyN1SkgUPPSo9eErTGt
TKCskHjx3DwKpe+M/K1O6C9tyE9ZKtnBom7B/o3mJhEbqfQiSJxi8xdhcjkbhvAI
inFRYaOZIjCeiQCWh4mJN7WctP+81/y73DPSylCO8N3aX46+dljkmpEtB6mRO0le
8eg4r3r5zQNqBwbBv6Ah5R2XRJqEiH5tarYs8lOXcwJPO8r3DY275VLCLITqr1Qi
CK/RUu+Pd2kdYcI93MIbj4i7GpogQwBJpq6rBBG/lvp4Rt1hLH4T0F69Mcxk5VV6
9IwYR3Kt
=mnyS
-----END PGP SIGNATURE-----

--=_MailMate_ABEE9594-6CA4-45A3-8A59-49F4167AE1B9_=--
