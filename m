Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2CF3CA1C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhGOQBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 12:01:36 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:32352
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239415AbhGOQBg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuhDOU4ob2qBhuDTatFXAeOO9yNma0PAZe4WxiwJz9FrRS+z7DOitrq2FRWLqH/xQmBC/cy7XcIEODgKqzGM91LsTU+Ckc3e3rhdXsfaRb2kFxttrK6/GGYO6cs3AXnPrA3sDJtzv5L+AqNq+GpfXeAxd8RQgL9CnohSGrXxMQOVDh7GbPWAzNtsmKaTuEnM8V3HJqvPhExbUJ5qW5kAFN2sgyAba+ga/NEzcg0V4zifcPYEW0/SR6lEMOnlEuMvR1Ydc2Yl10krRDklXGsIyU+d0THDDOoMUFNKoP4e84pQi1uxq4X6hmnT/TvE5XGLPtfZjAwvWhIFcY1eg7uQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lXDK3FrFmvmGj+at8/lmpCZPLMWoEYhkhXIVLh/yTI=;
 b=Mxg6ABoCOUbxmMdNSag0LIQGdb92yytrd9qho9/b5b4Pt41be6EXBQ6h77WfddsFjPris47s9PZowFgOqFks9Rh2kzim9rtWQHeDvZAbAvbFQDukxtgFIKQGvhcZSMXxrJcsFNxen/EJTn5uewfjs1giz39nMbf7ls28y8siuLYqxxhCv+K531mXYNJaz3giLZt6DDHCRHgFSb9/KfioT+VwJW9y+i5SI6dIYCNiRTZDcKwO9QFbLLaJYc3DxTLSqTsn8SYLKfFRfyx+6hBSAElU29mmiCyOnY6Ax1KkjOzzRb/zAEIWaTljZnf773okXGREq+s9CDcrQg7BSLODiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lXDK3FrFmvmGj+at8/lmpCZPLMWoEYhkhXIVLh/yTI=;
 b=ecorZfE25mNb0KIvVbf8vLwpf8cq8uS77ty1b1uHEXznvVX9M4I2pEy7QpTEWaXu/lx73iP0UxqXGujJdeUCjEfk2B6GvKlB22oxlnqHC11e9yGCyG5Alya4RjZUzq5y4tqkUwfMGzLJ8pVjGJ+1iQnEfl7IzxGXpVF4yF4lzeVo+m9jJa2kZemY9EnV7UTN3DpP+IlW4ehcJsJEnqDPTdbY2tUdiGi0YSoZQR3tJyYHQOCyYWNo9NBIhSZB0APwqX3kemjGuikREy+Dc9gaJPLc9TFfaMUIDt+sMKHABeQqoLKqbvGB0MYTeyVeNIS8OcY2dNKBE1AXJkl5koc5+g==
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3983.namprd12.prod.outlook.com (2603:10b6:208:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 15 Jul
 2021 15:58:41 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 15:58:41 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 062/138] mm/migrate: Add folio_migrate_copy()
Date:   Thu, 15 Jul 2021 11:58:36 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <2FEB3FE6-38C0-43E0-9C0A-27839F029BEA@nvidia.com>
In-Reply-To: <20210715033704.692967-63-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-63-willy@infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_5EF0C679-0D14-4BE4-A995-A8ABDD56B992_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [169.254.198.0] (216.228.112.22) by BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 15:58:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01a7b20f-a580-4cce-304e-08d947a96ab2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3983:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3983A87798C5B11AA5A90100C2129@MN2PR12MB3983.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUkILwhbXjaBHA3OvCFJIHDoRYqjc3V9Z7AqwdrsTqZrJYVb4fleJrOrLmHzt+Wn4Ap6+VcLiU0nc2e2n8yyYP3+7EyMuOOv61nC/TyAN05rZ8MFp52elINmT4OVB+DK9kCokULMx3Rz2S4cbqLrTKwD+bX5EAA+0dgN+mUoiYpNT/mTkG6kY05NEEaZUEhj3jxFTG/tPQwFuwgBfJA9rN5Xve0K74w0BlWFK3Y65ZuPp4S71wWsVQ7P7C09CLORGlnHy/eEoK2ZDDVAeka2GzsEE73oBrIQhfkgiFiz4zjrHYr+5udkRwiuTeNmHauGYjEsfKL6MF7fdSAenWR2MLoHP8NqiaYASmtTsBe4w/kCLRtJWULrxUM2YPyRS6twlY17AoF02/ZYpQjcJjNSP915NKIwEPuSTuzhu/csAzFX44bq+KrZ6q/vFlo1TzXL3AmyXOf1xbx5tBquAMs+v48dwEV5I25wu0x2usBC+sDdm55+c+wW2ylAhQtwGKAGAdBAPxohGH9yFXVJ9BJ1nFCrjTGMDOcFfmLLbuHAa5UV5qBlWJidbmSQ1ORqKSsN/ml7xwEMXSvvaR1xviRmw6j4Y9LSd6sPSQnOSgMZ4Okwa/n9GqXGprf/jSSYRZr2VzSMia+dgrvZ0/q9o1tupe5VRDcW5Y6OT9yKxCu5Vy3NSLrYnCBesXtjZ9gdJXCf1qEvpFQm5b2rbwGm6N+2HXLzuDomcXTMVg4Xm+AdWTHMDh2rK0gpwQeoBpWj0NCs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(38100700002)(33656002)(16576012)(316002)(478600001)(2906002)(66946007)(6916009)(21480400003)(86362001)(26005)(235185007)(6486002)(5660300002)(6666004)(8676002)(33964004)(8936002)(83380400001)(4326008)(53546011)(36756003)(66476007)(66556008)(956004)(186003)(2616005)(78286007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFE3N28zTkt5QXQyeTJHWlgwQVBHUlpxYyt4SzhTQkN6K0gzREc5cXlrUVFF?=
 =?utf-8?B?RmI3SVB5ZXRvcnd6STBWWnZsU2UwblA0Y045cmRmd2VzNVVISEs1YzMwNVBN?=
 =?utf-8?B?djJvMWkza2RURUpWOXNnbk5qejZaV2Z5YllKR1UyMDNlVzdNTkc2aEhkK1lZ?=
 =?utf-8?B?aVhRSnYxOGJ0Vko0d1lPeFUvanAzZWxTcHFUK1RvUGV4bkg3Q1lZR1N0MkZz?=
 =?utf-8?B?QmdSUzRRUmplN0FzM00wQ2JyVGx0ZzExQnZlQjBwOWQ4SWxuYThuOE0wdTND?=
 =?utf-8?B?d2N4cVBIaUl6MFVtMHlWKzdGbzVyNkhqbm03ZmVna0lwRnpSRXRNL0w5NEtO?=
 =?utf-8?B?R29oNGI5bVQ1SUxPN0FETFNsWXFRNTR6QVBwdE1LTHFQVHEyM2JqZ01KRzBD?=
 =?utf-8?B?RkdudTFJcGhwOHoyWXRRaHNVckhtZG9sWDlUZTBUazRBbTg0bkRzcUlmWEpl?=
 =?utf-8?B?UXhPalc3eWV3bTFRTjlZRGNGZVhlZUdkam5ZUlpod1FsTk1NcWRuR2FjMU9L?=
 =?utf-8?B?Qzl2c2dWZjJWdFJWY2tEM2tnaXhKR0xZWXB0TFRSbDk3K1E3VStoTWw0aU96?=
 =?utf-8?B?RVZaMTl2SmVhOTc5L05SMEZEazlHTGNlQmJCTUtTdnhuZ05pNWRmbHlkam9Q?=
 =?utf-8?B?MVUxVCtBeGcrZWZBOWkweWlDZ3RZVEdUOGN3TXRnUldITEdzNDVTNjRhcVR0?=
 =?utf-8?B?czRCRDJYM3NSRTd2am8rcUt6R2VUb1gzRi9CUnFjMTd0c2hRcGtwWVcxNHlv?=
 =?utf-8?B?NmRFT1VvOFZTQlRpczNoNmFaRkJlRk9oN2hLb3dtQ3JsanlvT1RTbktHQWN5?=
 =?utf-8?B?VVBIbDd2S2s0L0lQMVpXUUt4T2M2cmdlVnVkazNtL1dmcGx6clVQNnlGVkM4?=
 =?utf-8?B?U1NSV25yTEFnenVrVy9EYS9BTWF5RDhMdXNjRDhFWWt0c0t5TERGb0oyN1o1?=
 =?utf-8?B?WVMwSHhWM3pnR1A4MUIvWGVaR3Y5T1ZRdFV5aDFPamdiNStMTWZsOGRFMTc3?=
 =?utf-8?B?TGdYUDQzWWxJSFRtV3VKb2UvL1IyM2ZLT0R5QkQ1c2hOdTUyL1J1YWM2cXFX?=
 =?utf-8?B?ZHRUd1c0UkFaR0w0ckVJVzl5OWNjVThRZ0F6Y0ZOMm9JbHYrMHRjckg1REZI?=
 =?utf-8?B?dW81bzVyZDQ0T3c3OWlXa0dXbXJ6UGM2OUpjdHBFSUdzVUV2KzUrUTFEL0ZI?=
 =?utf-8?B?T294UFUzWldweWtHM3kvbmJmYUF5NkFJSVdydWJyYS8rYksrUGl2eTZHV1NL?=
 =?utf-8?B?cjRCbXl5bjlKSDd2QmF5c1pPb3d0MFFqc05BN29TbmFKRGIyQTZMOWI4SUZ0?=
 =?utf-8?B?K3VGK1Y0YlNCUGxrWmFKZGcwTnVadHV6R2Z6WkZhSmoyS0tSZVVVWUpCNDM2?=
 =?utf-8?B?U3pQVnhOYTlDOXZteFp5Q0c2b0plQUs5OEtzWDJUUGJGdDJhNkFlTDBaTGFI?=
 =?utf-8?B?cnJhcW5LcGRzQW9PYmNMS0RuWW5qM0pBdnpPZjRDTlErZzN1MFNVOGZ2YThh?=
 =?utf-8?B?aDJNVkErZkJuSExlaTMvYzFMbzdUZVRsTms1OGlMbUt0VG5BbGVmUFNiS0Z1?=
 =?utf-8?B?Zkc0akNTQ1ZOdjNZN1VXdU9uUi9Ub1FQcU5qVDk4anhlc0V2eng4SS9hQm1R?=
 =?utf-8?B?eXY2Z2xSUEJQU2dSWHVOTXBOR0RqcmFYQlQ1MmFqNHE2MU83aHRCNVRkTE5W?=
 =?utf-8?B?TkphTEZvV0lCVTB6VlVHbGRzb1BzdDRjbWQ1REI3SDJmWWRGU1RiSTFhbjRk?=
 =?utf-8?Q?VtA+4BRnweHUW7Kei/XYChI8sDITWCLVlY/AhBe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a7b20f-a580-4cce-304e-08d947a96ab2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 15:58:41.6012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV7vXmcYwuqD2CNPPYUQhdXL8H47a3qJWGCHKH8Sw6+xGxO8XOsU28h2+ZhEhOG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_5EF0C679-0D14-4BE4-A995-A8ABDD56B992_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 14 Jul 2021, at 23:35, Matthew Wilcox (Oracle) wrote:

> This is the folio equivalent of migrate_page_copy(), which is retained
> as a wrapper for filesystems which are not yet converted to folios.
> Also convert copy_huge_page() to folio_copy().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/migrate.h |  1 +
>  include/linux/mm.h      |  2 +-
>  mm/folio-compat.c       |  6 ++++++
>  mm/hugetlb.c            |  2 +-
>  mm/migrate.c            | 14 +++++---------
>  mm/util.c               |  6 +++---
>  6 files changed, 17 insertions(+), 14 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_5EF0C679-0D14-4BE4-A995-A8ABDD56B992_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDwWywPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKvR8QALNt0F+0YGGlbfB87ylYsb1TuzvXyJXq7V3l
hS1yCLoSsexA3xiphXXijJ4U6clEqRgSjxZ21GuyuJRVCO0lD6EvIiA7jjDVPUQo
numdM86QYbB0P7qZjhFnn1GHXCafrY8RUxoCxrLGkZA8rfhWmvEiIM+h02U/FdcP
UYzCYki0GOaD8PoV6PdLCq5Ny3XJKdoi0gMpkUM3923gCaGhXvJZ5SG3ycdb+Skg
Y2xSF8pncTKzTtGsJrK6qcXxESktuO4/9W2clREU4lWbrH1kjw7SfeKbTP4tWchu
MNUz6lWDMi0Y+qiz+hAPELdIpfonTcZAzEiUEnsUSIouUz3vEbtMJ9qEEBnLtw0/
CZSWDXvsreDObagku0BuNWBHgO1UiZen6y6lAkreO68hzSt05KbdL3apiL0Bbl7c
JDF7EIB7BbrkbB71R194W9pbn7EwmVk7/249RQ0QA8dAwmev+8XBEoK3PHnTY4Wh
OlAp9v51/YtxrKLwERqmWC6JORhD/mT9pW9KknbRb+sHVVzW80etKpp+BanO6Xws
yAHZ9P4+ElWd0kRdpdssGvIN4OoEdUxlsA0JWw0EIixcxeHXZuArhhxAFSzQp32n
EY9S/B1PcbILIejgVIj0HCp2FK+9H3Kbpx5FqUNhVp7Gcd0EoQcEz0oSNlSLILPm
l6bKGloq
=YUF5
-----END PGP SIGNATURE-----

--=_MailMate_5EF0C679-0D14-4BE4-A995-A8ABDD56B992_=--
