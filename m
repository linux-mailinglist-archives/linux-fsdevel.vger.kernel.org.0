Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524BA329406
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 22:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbhCAVoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 16:44:55 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19828 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbhCAVmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:42:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d5f880000>; Mon, 01 Mar 2021 13:41:28 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:41:26 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:41:25 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 21:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMUs9fYISKyh38KzkRgFTV/Ej4la9RxC/cXIgcsCMUr8TZx7pt8WGJ15S3yWs+t4mbz4PZNEExNsmbf2SnSD5PeBJgmLX5ISASQsWC8FK++dwXcvSuQo+UiqF2hOkMNd3t6puzebU6W4J2qqbF6UEUc/miv0AL+JNlE+h7IdRReTY5LySv9RniEN2ny7tjSsKFIRsBHwvSTHWlI8zaaNDd2oz0ov06Lt9IaHz5tkksX31tItFFPQ+bAp7vn2sp9dmjypmoG3iOz68bgg0GR39VzkabLe0Ac03dfmUFfczn5lneuNCnMu0t9kGAFsxtnHI8xzFa3Uy5feFXt63OXl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsIMf3k5isMJXt/9c23GMaIW59O9sp5G3ubs2/6hekA=;
 b=DAn04TCeyrvHhZBKzlRQJOPnMZ1A+RR2MvBaTTR9D0NKEg4OIU19qN8S53tcZk1V5X1Zgqk3wIRxjjS7SMMGrA766ux9IHRpqMViWxcx5Wz/nKb3Gv7IXTKgtb46GTi9tJR71tRVlaMYBlDlP9mAJ6/4DtioelATJff6o44tBfnf2o6yHZcF6V9ygJ4AsQlFPwrJCwWgxdlEBvSGIT1f+hZ9kcoFPyijNUmkThKE21efAJyRdZ2qU7o1S2eyO3MQtDJc0CpviiZirKmKCDiUtLNcVQnvcXht4YbbHY+tl3b6AMt7NS6yEe8yI6ZXgiHWNEmp/jH+9Atw/kZQTrui4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3712.namprd12.prod.outlook.com (2603:10b6:208:164::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 21:41:21 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 21:41:21 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/25] mm: Add put_folio
Date:   Mon, 1 Mar 2021 16:41:16 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <61E16B01-4D4B-4ACA-A7C4-307CDABB3453@nvidia.com>
In-Reply-To: <20210128070404.1922318-6-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-6-willy@infradead.org>
Content-Type: multipart/signed;
        boundary="=_MailMate_7A5814D3-557A-4A76-9775-61CA1D015059_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:208:235::35) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 21:41:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0633c2b7-ea24-4542-e312-08d8dcfac0e1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3712:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37126F37FA0DE0BCD2008C0CC29A9@MN2PR12MB3712.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsvR+AVWTa0VE8w8HoX3l37IyytW9KzjvIcva33TehIKC7tIjwa+eKyVB9wamtFrQa1zhLLkQvYAXrRSnKVGMerE0abVpnKBIjb3APi4VkkzwKOtkpPd1yCrg0BACKaF6NYoexCAqeEVTdIjbv5KgKlU+63dMjOSaxTPDG7K1CHfTHHvoE0993Q1oragX7K/V4rmZcWBG9hrfX6U5uKocv+L2WDez6zEYPS54I96q4HlUWwGcUmii57gRFZeG3AIxkwlvf6ivSWAzkJ6VbIewcIjGrTD2MiZQpSgfQ9NkzsWlP6dTNHjmsRLs+6aqSCk3stLRlvNc83o6VbWkGnCtZ4JQmZIfhlmBTIF+sKnneE4Soe4x1ggAaZRees3V5+EwyDLNxEoSi0h8LcQvSOa1lk/lQAxjXKTalVDJFzwsqx0u3OJIpE3MP+J+98qX6qTATBWInhoL2UnM6C+JdzGuV2xuGwBTqpR8u4at3dgb7726KMTTMGW2caPFFT5Uds0Jsiyh+pX6U9OcWQhh9uhCrK062PyazTnm3+yyknwlP8igfZEq2wgKruq+J8T73+UptGCjum96gKdxb1DYV01yEfbEuhu2Gu1iCvExEQSL3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(33964004)(2616005)(235185007)(956004)(26005)(4326008)(66556008)(53546011)(33656002)(8936002)(86362001)(66476007)(16526019)(6666004)(186003)(66946007)(478600001)(8676002)(5660300002)(2906002)(316002)(6486002)(6916009)(36756003)(16576012)(83380400001)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SDBGT0NCTmNhSzhHcHhPa3JKZWRFRi9JMW56Y0JGYktsMmVVb3pPb0RFUng2?=
 =?utf-8?B?V3FjS29xREk3ZDc3Uytkbms1YTRVYkxEblAzRVEwTGFQVWE4UTlRQ3VuZW5U?=
 =?utf-8?B?ZE1qdjRpMWdOUzBIZlg5aHhxeVlPeHdpZGdmOWJHQTlUb3U4RlZER1VYbTh0?=
 =?utf-8?B?S2p2blBzRUo2MDJZdW9MTEsxNGhrVmxMaTBkMythS2NHdkhjWlZNYjA1SENW?=
 =?utf-8?B?TU04cE9ScjUyWDg5NHBVRHJnMTFyNTl6L0E5THVOL0Y1aS9Ha2g3NmZkUFJv?=
 =?utf-8?B?OWxLVHZZRnF2QVBWWktMU09YZitGZEE2Z1VNMmtUb3IyYitsUkJsN2FQbk0v?=
 =?utf-8?B?dlpSNmNPK3ZwOVJZVzRGM2dBV2tBQWxld0MxWUpFdTQ3WVJtZkRoU0NUVk40?=
 =?utf-8?B?aVp1VFlHZHB2Qmk0RFM1SjdVaWsxTkJYTWpqTm85RGNpbTJMMmlVRGxpWWZm?=
 =?utf-8?B?NEV1eHkwU3U4c0IrTGgvT0Ntdm9pTjBtblBjUE14eG5jTjUyNFkxcWVXK3Vj?=
 =?utf-8?B?MVJQRng4Ny9DRmE2UDhNOGROZnZTSVlFNjZLdGZqTUJPb0NDUHA0c2d0Qmpx?=
 =?utf-8?B?VVF1OTBFTFMxWEtZL3Z5Q0hpdDRhNnNEWnI1c0RVR2QremRMSmF3SDhxRnRG?=
 =?utf-8?B?UzV6ZXBiY3RwemV3U2ZId2lIelFBYkt2VVh3d2JleDFXbUZNazNqVDQ3a1Fs?=
 =?utf-8?B?YnlteFdSRTdydkFYbHZyQWRBWThyOHU0VmxzN0MwZXpjVzdVNlJYUEgrdGJn?=
 =?utf-8?B?QnJRdnpoR1pXdytZNWRod20yaXdjOEhWNnRERHFQeEFoZTM3ZnNxWjZBeW85?=
 =?utf-8?B?MGFuTkU5S2RJeHpOdUxRdjRYdTNjWmI1Mm5kZFdnV0RJRlBjVHA2WldzT3JT?=
 =?utf-8?B?VDJ6Uk1wbmhtRnEvdmJsZEdyU0hjeDVlSWlxc0R1MTNWK2dBRHQ4UzN3eVhL?=
 =?utf-8?B?MDJ6WXZXcDFCSm9tQzRvSGhYQXUyNWRwQzJwNU5JUUNkL2pMKzZMVG45dEp2?=
 =?utf-8?B?YlMwN1lXUHVrUk55ZWxrZHdTdlphNFFWOFl6R1RDSmc5aTEyYUIxcWJ6MzIv?=
 =?utf-8?B?TTczSEF4dWNOWnozSHgxa2JueGRNQi9wRCtSbVo1V3hDMkpKMGt0bHQ1ZUJu?=
 =?utf-8?B?WmRZOW10OTlyc2NsUWJ1dEdvUlQ4KzBvNTFzYUk1eHpqUDdocm5tdUVmZkdx?=
 =?utf-8?B?Q3A5L2dxYllBeGlISzJPRFFaNDRFQmN5ZHhQbFZVeThBc01VUDZUREh0NW1B?=
 =?utf-8?B?dzgrQ082Ry9hWnczNVpNSVNVOGQwNzdQT3dhNFdmOFdvN1duOHp4OTZoMjFN?=
 =?utf-8?B?UGFTVlg1dGh4NExOall2NlBxZStKNGZEdUxvSkptd05OQm56bEFXVmtCUUJX?=
 =?utf-8?B?VWZtc2F1aTNIYjl5d3ByVlZiMlJML09OczhzOEVIRTJCN3oyMUJvR2VBOE0v?=
 =?utf-8?B?V2xNaHpOMS9zOHAvWk5PN043dmhQdzJTcDhyaFBlRjJUcmRMRVM3OTAvaHV5?=
 =?utf-8?B?N2pnNjg4UDF6ZFVsSElJODNxSDJCekQwRzNMRjE3WjZyTXBCdElsS3JDZEtQ?=
 =?utf-8?B?VFBsOEljeGY5c2VIakR3ZzJhSUlyTitORjhsdlp3bVI0MytSWjBZSytoRlVP?=
 =?utf-8?B?VEtoQ1FsZCtnMXZHVnlWNVBMMzVRQkphOG45NFJTTmkrRTVYL1RXaGtZSE0x?=
 =?utf-8?B?ODYyOVF6TGFlWkZXMy9hNC91YUhaNm1wS2p0clE4dHZDcUdOY2x5Nk9lT0pw?=
 =?utf-8?Q?qhUATkez1fssCiPLX82N1NgdEPqTZBprJ9ElhFY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0633c2b7-ea24-4542-e312-08d8dcfac0e1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 21:41:21.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmTwhAs/XamTodn08FJDqVdQbBcnHnt5anG8Gd48syR9n7S0KYaUA9jCkTt9wfEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614634888; bh=UbdWyA6UByi4SaBS+icpBCVYnFxPmP3U+vBv6D8FPks=;
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
        b=WFmFjNxBtSlLyswqbWAyKgW4hRbINIP18BsGr0NtVLurscnjJNm8rcxqNsE7K9nMX
         LnA8UWpUHysf4xWNCxPWDswQsqkYAXvyAKhqjzYqMQxYd46c1M8XvAk4DXzT2UJYLw
         AWvhFlUcvQj0KGbkohJQ2RzhjWipCxBiMO+CN3c1b5KBZikqLhtvdzlAdcWuZmBnnv
         n87lt7YTXYk8bCz9ZQ2Vc3/d6eDVWWaowsGmB/E2fOG0bCu5KLAi2t/LP1IckiD1t+
         HHxl/JDzYKEOfpyobVsnmj3v6J5y/R30Qrmb68XWUxly/PvfK11CqymnRji/pOMkA+
         lnWXHkLxJUw2A==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_7A5814D3-557A-4A76-9775-61CA1D015059_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Jan 2021, at 2:03, Matthew Wilcox (Oracle) wrote:

> If we know we have a folio, we can call put_folio() instead of put_page=
()
> and save the overhead of calling compound_head().  Also skips the
> devmap checks.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7d787229dd40..873d649107ba 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1220,9 +1220,15 @@ static inline __must_check bool try_get_page(str=
uct page *page)
>  	return true;
>  }
>
> +static inline void put_folio(struct folio *folio)
> +{
> +	if (put_page_testzero(&folio->page))
> +		__put_page(&folio->page);
> +}
> +
>  static inline void put_page(struct page *page)
>  {
> -	page =3D compound_head(page);
> +	struct folio *folio =3D page_folio(page);
>
>  	/*
>  	 * For devmap managed pages we need to catch refcount transition from=

> @@ -1230,13 +1236,12 @@ static inline void put_page(struct page *page)
>  	 * need to inform the device driver through callback. See
>  	 * include/linux/memremap.h and HMM for details.
>  	 */
> -	if (page_is_devmap_managed(page)) {
> -		put_devmap_managed_page(page);
> +	if (page_is_devmap_managed(&folio->page)) {
> +		put_devmap_managed_page(&folio->page);
>  		return;
>  	}
>
> -	if (put_page_testzero(page))
> -		__put_page(page);
> +	put_folio(folio);
>  }
>
>  /*
> -- =

> 2.29.2

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_7A5814D3-557A-4A76-9775-61CA1D015059_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA9X3wPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKBFkP+wddu5JVCCc9KDwDX34N31JeSuIqRSLaPy3c
pQZhTOoMaZPlaFR7V93yzEFB95RqZcQxwSjDmsyHzWnqtwiThMowBhd135JzStPD
sjFoj1DvW7/KFUi5n3i8N/vv/3H12zgBGfudQ3cqgl92wDzScs9U9Q191OSJ1os5
FNkE4EDI0aHjn8TzWcUdOGsHTx2pZXNhponc4D9BSeUYCI/Vhac+peeH9dE3BOG+
xIGj1p/WTIv/jRC5BTSmd/t+ygatycI8EIW1iL9q1CGO502seIyyzE9dTjXUZGs9
tJmAdbqmvjJ1T04KJpA/SKCZJa2nOUZKc07aCLqld5JekFpXQYCW7XOULfdSqcjZ
7YjuJcVrbXVBpuKqb2BSWLsJCh0q0fm33wrzkoPc5eEcjLVB5FuWeffo1UXO0RtK
IQmLLzpMunP82qSdEc/udJ6GlcRQcTN+3PAt5gMisRPPqUA26O0Rrtz5M2LCW3A2
4LuW72Uq7ff+1go6Y2xfzm8YyTFNv7CmHt5ix8bqcX28JEGxy6f+hciKU0db5/kl
pUa8F81rIxu0m4IcZ2C5UOdX5QsBLk5xm/W+ecOkPd7TU72pFPR21Awq70OL6nB8
Q3QdpCmMm+L0lVNQ0soTZC+ZKtuuomqSRoLzG7HQttybG22kYVgZW1QrhKk1g3VP
VhC6/NM9
=8BzP
-----END PGP SIGNATURE-----

--=_MailMate_7A5814D3-557A-4A76-9775-61CA1D015059_=--
