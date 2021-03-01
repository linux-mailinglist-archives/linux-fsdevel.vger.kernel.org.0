Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9675F3293A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 22:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbhCAV3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 16:29:44 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14226 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbhCAV0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:26:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d5bd20001>; Mon, 01 Mar 2021 13:25:38 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:25:37 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:25:35 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 21:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+sHmjscju1aPeMAkgK1Ers7upA4o9SukJvULr6VILENwFN+8jP3B6F7iw96nxehXh8U4rTEh4tnBXttExY1AWfcp3I9QINhqTtb62rhy4hiWeKDbSkBnT30czwK10q3fM6ty0Vg8rHqonNLo12fLymvXBa5rrwE2fHGq4aN1SiSA4qatNUbAeRxqmRBlmHOwJxWofJ7WBumPKOkVgD8bkaGkoepvQqte2nIWfskPPOnD4l87Jz5KrSBj56OA7C374h/l/sOXequ3Rq4PLP5eR2dKtkUnkwA/hsXV97ixRtbICdI7In5u9v6FcV84X0Dhsx2O/U/s8FjzaOTBthTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4u2sZJvYfuxJbDB/lZV0+cBoZJlfKuFAm2OVkhhMlU=;
 b=ZWrtwyv/84/QCCJCaUPMxdHYeBrgoDYsdWqKZD+msIb/U2vECP4rBzgY7Ivwm4NtKZb7oB2/+8t/slC7B08YFGBU/VBqUwS8Oh8eIsaniGw1GEl7amstfgZi2G3TEqDnarSrTL/fhuNATyYlfEWB6onQvirBXq+PMIEYSOqnzwYsgAshZ622KHWALagsmLmTu7iM3JTKzjzmngaWy59FIz2milzJAB1I+aNOsVt7IMvFqhuEktaJDfwaTcR38KOdclChdbww1oVwkfiKlrT9hh0ZQVAEmR54b2oDn26yhjeh/t+ulXWL2bMItQvmRL4nvAASqEorq0ESq9cZcnStFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 1 Mar
 2021 21:25:32 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 21:25:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/25] mm/debug: Add VM_BUG_ON_FOLIO and
 VM_WARN_ON_ONCE_FOLIO
Date:   Mon, 1 Mar 2021 16:25:28 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <58BAD811-AB12-486A-86DE-BC2B1ECBDE42@nvidia.com>
In-Reply-To: <20210128070404.1922318-5-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-5-willy@infradead.org>
Content-Type: multipart/signed;
        boundary="=_MailMate_10BE2818-D1F1-47F1-9C40-FA3F705E3D58_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL0PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:208:51::27) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 21:25:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed4cd3d2-c46f-4b23-0736-08d8dcf88b94
X-MS-TrafficTypeDiagnostic: MN2PR12MB4158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41585445E4FA3705A1C66A15C29A9@MN2PR12MB4158.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fppM07udDmJUA2FhuBIWkK4AdxGn0r9gplXZM8NLlDCL9/1cqBWZ71oz9IhErcg3isSNQ0RavmVuF4FYC7iS/wLT36NzlT/2KW/ppSxKLSTlAKskm4Wi70alaXUl5p9ZlYtu8IxaWc+KN6b39ghTwyMciikX1KixA4E+69x14wV+4FdAYj8+7L6U5W9j9CRN1qqL9qyednZ1Mravgt4fwfEm2GxFWZuj0U1Y8GoRCKdDf1rqR8mKauiFpp+upyakXYjpiQ7xQr4Ph/qULVpQ19i5EJuOZWGeNJZGZRegWU5qEtYCQtZrsOOXfEHZyStMdCW6CLgEHF29G/PIlJ+zrGdj8TFNfofvHbuMBk9+Gvfk0UsCB6TA0khnJ1MsRGLQHOptfnJGntigbym4Kv8fWIroVha6Su8d5kD0nAttFEYFOOTQ4L6UDAVcc+wUpy3gZcC5W49d0aoTFWhQrQ/ZhRSOO7UWyAiN1MNL3UABHz5k6LnckTZiPpZZC/F1RSIqwY3ecjvJASSz5iwqAr0vxMPm0FWU9ejPRSqL/ERGuFF2Xpdv5TRLoBuRfAuaV50f3zF4jVo5sPvjIyPPaNwB+jqSURH1LLoAgXuMySWvd7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(956004)(478600001)(5660300002)(316002)(26005)(16526019)(4326008)(53546011)(6666004)(66946007)(66556008)(33964004)(6916009)(2906002)(8936002)(8676002)(235185007)(86362001)(66476007)(6486002)(2616005)(16576012)(36756003)(186003)(33656002)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MVZOQ3NTQWZ2OFVmUGdPRHdwVENsSVVDVTJHMTVwMmVpRFpqZVNIQnM1aFRn?=
 =?utf-8?B?blg1L3JSRW84ZHNpbXQ1Nnh3SE9aRHF4cldodU9UMDVSd2FLa2dIdk1uckZ4?=
 =?utf-8?B?RElDc0l2WEFmRHBMeE5ZcmU5S1puVjFoUjRHKzhQa0hRTFJZSGpOdEhRbVJp?=
 =?utf-8?B?a2VkYjhSMFpYTitPY1crd0VzOHYxdGxFQjNlekM1WDVXakZNM3hGVmxlUDZC?=
 =?utf-8?B?cy80aEV3RVlXNWZNZ3hlWXgxb2toK3pzN05xaE14cnFDZ0RGa2MxTytwa3JT?=
 =?utf-8?B?bWZkUnJFR043TmJTUFBvV2lHQnFyQ0tqbFYrQ3dja2FORWM5d2ZIMEV3S2dj?=
 =?utf-8?B?T0NlQjVLSkxEQlhxTGlFaWRUOWFFakdHalkwYmRHZk9BMVNNTGsyRkFjbG1O?=
 =?utf-8?B?Tk15T2g4NFVZa0lUQndaY1lCSTJOemUwYjc2enpzYTdrV0E1ZzB0WkJNTXRC?=
 =?utf-8?B?RHFIczRkdzhIMVFNc3VhUlMrMllCVjAzYUZUT0hSRDROR3hEcEdPRWR3ZGpj?=
 =?utf-8?B?aVFydGgvNno5WUJxS3pzRUZBYWxPQlJWWXR6RjJoaVVuL2xnT2VNTVJEL2FR?=
 =?utf-8?B?aTg1WUxackhNUVRybk1CSUxhcGxTUThudWFtSUU5TFphMEdOUUdWTWlZUHRn?=
 =?utf-8?B?Y3lrQzlETzBJRmIyVTZDcWMyU2hqUTVvamk1RDZ3WVhRSmplS1IrcmVqMEI3?=
 =?utf-8?B?L0RNUTdwZVpIcGNFR1hrSzc5azZXbGp2bUlST29nYjJucXBIZnM1UThSRVJT?=
 =?utf-8?B?Zjdrb3NNUFBlSVM3YlZXZU5GM3lSMFg5ZzZkYVZHbUNBcytKaHQrdFN3Z0d1?=
 =?utf-8?B?UHpOWFd3UVZDL2lXa3pKN0ZYYW1HSVg1MGRtREovRVphVnF6M0xMK2d5TTF5?=
 =?utf-8?B?SFRhbm9tZnpQSXU4MWg4SXpzbE5vZy9DSTByb1IzZm5pZFVvb1h3WDZhbThY?=
 =?utf-8?B?UzNTcG9iOEVMMk9naGlSZ3JWc3NSTjVGVU5QQkpvS0tMMGREWU5aRC9IVTF0?=
 =?utf-8?B?d2s1ZlphWUNQNklvQTF6eHZmUUZPeStCYk12dHQxNDF3bkFnT1F4dzdVTEFv?=
 =?utf-8?B?OTZkNDdtU3d4dUgwOW8yU1pqTlJOdzFDNituTmhubmpZZlNBY1NpZlFnd2lv?=
 =?utf-8?B?Rlk2d09sbzlLRitVdzRXZVBwRWVGYWlLVUhFTVlQd3BzNEZCTXl3MFZMRGUr?=
 =?utf-8?B?L05ucnA2SjgvbmUxZ2c2d2E3Qi9NT3ZCazZNOXRzR1lvY2lJY0xPbXhsWklM?=
 =?utf-8?B?REVYTDBHNUhHZVdGazR1TTZqRzQwSytFV3NPckhhSitKcW9kT0dLdi9SM0Uy?=
 =?utf-8?B?aXFKeE5xZ1VPSm1RM2gyd1haUVd4c0Z6QklrQnRhTGk2ZU9vVUJvMTgybzF0?=
 =?utf-8?B?QWFlOEdaNmRqQ1N5WlZzYis2azVhWDk0NjBGTVNRaUV4eUlXWno0WUZYU2cw?=
 =?utf-8?B?L01FaU1FWUJ2MG5PR1h1YUZWdi9YSnlOSXJKM0dPM1RKY0lyUVQxamppV3M4?=
 =?utf-8?B?aXhtWHpkbml5RFBEWERzVUxoVFF3ZXdzaFVJc0d5K2dNdWxLd0JKd1dBNmVm?=
 =?utf-8?B?cmtQVFA3bGlsUW1zSjJjd2x5WFplbUg4Rit1Y21pS3lsS0hMQStVV21PNG9O?=
 =?utf-8?B?SFp5NlZ0bnZOS1pYcXp6Qk5BVDJ6Szlmckd2ZHNIM3hSKzJyUVp4cDh3Smpw?=
 =?utf-8?B?MWxIclBNZ3J2TkczZTlJVGVsQkNaclRZVDRMNjA0dHlTMVYrOFJ6SXJyUGN0?=
 =?utf-8?Q?2FKdUAHu5hVypyPXl1iWx5iVF1ZnCEx7yh6u1+Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4cd3d2-c46f-4b23-0736-08d8dcf88b94
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 21:25:32.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUYblkWhlnY4DCLKp0rlWvUHFo9PBWmWWWRqluSiF8PAfBtJ/IRRZuDFckzGlroy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614633938; bh=6DVU2eL23zg9pwrHXz9av3LTgfDK38PY33Fj4wH5dxY=;
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
        b=DoUlk6Ey/cciztbRpmEHuavRmUku7mNcyMdP+65QI6BFnapj1WvRdQqgT08OZIWqK
         wsXDWo7MccULvCiUt2ccFDHMXVaWOeC0S3jWf3y09rqTU4FrVgDFUcrfAqMVjHHe08
         xJXg0Pv4IU0S94Ic/MiEIRFo5NuTaoRFot+VohTu4e1/AY7B8SVAx4WIv8vssJOJVe
         ZIb9/WfYpEU9DJaN0h/Ml146ZGceLr/ABcXb/GK/dvKVgKn1MytrLrlzibfO5YSmaK
         +Dx1ce8wTlfvd52Yb+gdqjlhqFcRfCCbELThnsBpFlIeeOfUPJaGW2iJPOzC7pyhJE
         FgOFSA66gRATw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_10BE2818-D1F1-47F1-9C40-FA3F705E3D58_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Jan 2021, at 2:03, Matthew Wilcox (Oracle) wrote:

> These are the folio equivalents of VM_BUG_ON_PAGE and VM_WARN_ON_ONCE_P=
AGE.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mmdebug.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index 5d0767cb424a..77d24e1dcaec 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -23,6 +23,13 @@ void dump_mm(const struct mm_struct *mm);
>  			BUG();						\
>  		}							\
>  	} while (0)
> +#define VM_BUG_ON_FOLIO(cond, folio)					\
> +	do {								\
> +		if (unlikely(cond)) {					\
> +			dump_page(&folio->page, "VM_BUG_ON_FOLIO(" __stringify(cond)")");\
> +			BUG();						\
> +		}							\
> +	} while (0)
>  #define VM_BUG_ON_VMA(cond, vma)					\
>  	do {								\
>  		if (unlikely(cond)) {					\
> @@ -48,6 +55,17 @@ void dump_mm(const struct mm_struct *mm);
>  	}								\
>  	unlikely(__ret_warn_once);					\
>  })
> +#define VM_WARN_ON_ONCE_FOLIO(cond, folio)	({			\
> +	static bool __section(".data.once") __warned;			\
> +	int __ret_warn_once =3D !!(cond);					\
> +									\
> +	if (unlikely(__ret_warn_once && !__warned)) {			\
> +		dump_page(&folio->page, "VM_WARN_ON_ONCE_FOLIO(" __stringify(cond)")=
");\
> +		__warned =3D true;					\
> +		WARN_ON(1);						\
> +	}								\
> +	unlikely(__ret_warn_once);					\
> +})
>
>  #define VM_WARN_ON(cond) (void)WARN_ON(cond)
>  #define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
> @@ -56,11 +74,13 @@ void dump_mm(const struct mm_struct *mm);
>  #else
>  #define VM_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
>  #define VM_BUG_ON_PAGE(cond, page) VM_BUG_ON(cond)
> +#define VM_BUG_ON_FOLIO(cond, folio) VM_BUG_ON(cond)
>  #define VM_BUG_ON_VMA(cond, vma) VM_BUG_ON(cond)
>  #define VM_BUG_ON_MM(cond, mm) VM_BUG_ON(cond)
>  #define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
> +#define VM_WARN_ON_ONCE_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)=

>  #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
>  #endif
> -- =

> 2.29.2

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_10BE2818-D1F1-47F1-9C40-FA3F705E3D58_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA9W8gPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK78wP/i4I/UH7gZjCfnG5LX8AGD4Git5irfKS4XMs
T6dY0Tc6qt8UzqqQLOv+Tb+aJmfMzZmaSLem0hq4CEhKFDDacaAfQbXm9hmr/DU6
1Beh9uZj/asBwU6lskn0OocsbhcmuccFFdcRV11mwIb9I9Bq141WXUtVeOk6Kxpb
AB1nPjxdvjFeBI4stxj5aVom+uZ8iDEZ+0zbAlzz1c7qoWbAoNppPv9dEhMfmzj6
74UzGlrznALdmrMNQPSZw1h3a1Rmt7st5JX0mOLRZ5bPpd6cccd8nrvsBKVrL1Bj
4y86o/ZGer/ctQI+a2ZoUi3NWgnN+KGzTL2PER207x/m8HX8zEuBvBeXOOjjSW/s
WHhe9AAX/vZmL/4q6uwWJlwg3bX7l5xD6y2+0WstGIHIycJTMwed+sXEp/Qf8bLU
O64eXEPutRCvdjVkjm34hLLhFzM3qdV23YJaasTgab3LIKYxHx0EsrlDolL6D8wW
/WPkwnih/FZ9MeGuG6mrIVWnUDhKrGwdjnA6BTpnLHoP1a1TvDcfU9g54Flu4jx2
JpAQJopC9+5Niibvhxf1m0aJ2lZNA4wtB9XWlP8wSKVdwjB8mhFveSpH1b1Lq3pF
cCSJwE3/NjYqHrjSLMXDEwcwckwr5V76KCyaP4KLqnjQrD+rwHsLYenIRACn3RQt
cW+vEwGO
=yJqO
-----END PGP SIGNATURE-----

--=_MailMate_10BE2818-D1F1-47F1-9C40-FA3F705E3D58_=--
