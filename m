Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A77329245
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 21:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242478AbhCAUmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 15:42:20 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14905 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbhCAUgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:36:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d50040000>; Mon, 01 Mar 2021 12:35:16 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 20:35:15 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 20:26:21 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 20:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glrWQzAUM3e6/Z1WPHlXzcUE5tlcH4gInqEPMDM4REhlF1QHC0oBL+bkQeA2H45GyOfilToI+gz4Bu474PN5ehs/mZvwWP0t6GDLoTxru9QHZ2fgeNNSAbVYialgt6VOkpY2O0FXs6doYGePhEeac/5OjUl4U3SSvhw5G/MLSgaMkbsQHHDKsfSrBp2EI1FRKsAZhCHtF3x+vaE19cS2+ddQ85XS+VxuUo7m8MBwxY5ARloP4KZMr/sgH6OEVgc7uluEjVFkE3lfPEKAHwjIozRQmIWS/ETTE0nv3PfTfiifn0Ns7fek6N4iK2/vmw6w1jkJGqloSdzDjVnnieAS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnbHebE4w4j6uvPA7UIPO8pKivQIDjyrVhKBV5rExLs=;
 b=d9+fsJBgBErIfrLNEJqTv0nZdTbfTASO11sooI7LFxDb5F+Ji0OVwaD21OwfpYeJVCZJoLEZsazUf4CfjBrooK3ZeGl1WQwDYQz3LYgsWmpqom8z77HP1V9xjzqoxn71SicwMZRYRfjzPJZAoPNShOYwOgmn/IvXGSCk0qSvwSnqDGfierQvQYOIb+sxfJFdHCa5DCKUeFSWowkL1FDUuoP/e2MWetFwV/GN6EJAZlhg4l17BItDzBZjcHF/1Br43P/wKsPJ6VN8Jkgd+EwwIWOHyrhDKLlqqM/om4b1ys7YqJxY2L5OwLOVUizbzPiM82H0eSJck4wtcVsi8UslXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 20:26:17 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 20:26:17 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 01/25] mm: Introduce struct folio
Date:   Mon, 1 Mar 2021 15:26:11 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <68723D50-AFD1-4F25-8F10-81EC11045BE5@nvidia.com>
In-Reply-To: <20210128070404.1922318-2-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-2-willy@infradead.org>
Content-Type: multipart/signed;
        boundary="=_MailMate_35B182F9-D59B-4424-93FE-9E511CE5CE30_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:208:257::28) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by BL1PR13CA0053.namprd13.prod.outlook.com (2603:10b6:208:257::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 20:26:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f3c13e6-c3e5-4272-de89-08d8dcf043db
X-MS-TrafficTypeDiagnostic: MN2PR12MB4285:
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8760
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4285EAAC25B1F132D00DCCF8C29A9@MN2PR12MB4285.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hb8SZJ2XWgCtj0AIAX5VlBlNly/rWA4Wj4mJjk7aJirDJu0drLCTeX5d7/XK6vT1bdAFjum3I8DSPEBcc8AWLjiUsREvOE36odzBViSp1rn3+zbSf+yJNqphkpEANiQBNkYkcIlC6tp1xySZ9wuQlpf48t8SiRcX8bTGtFfIz0tO+KnXX8+iaGUqVaRd333SuvvagNk6bqFc2tgl7GRNQhYJi3/MWO5v9Eb9T+7TuEnqeeDmlf/Tf/fBum2e46A4DDRFMGjB0I+Za6dqyyVVe9cydRIGRm7IjHYiDWqdM1p/SPvH6spGgnobMrvI7/muA7y77KQVt17QcKfRIFvtPzce64y6sexFCP7Uxq8rb1GgmOZS7Rd18zsIGC+2VqtZbMQItYH4b0odepPJfoQKoJFq+xc5z5voMYMIDfAC2fBdTemwmYgvxR0Dugw3tew0tOKOUnp5aH2wnc3aDEjj2/zAeLqEg9YTsZcC2nrrAIWHae4qz5MEEnFbInnF22VRANiPMOmlAY0bpwEY6ttedIeYKYET1rzjboiyY3osz8U+jMtegBl3wngYy6LTies0nmVCDUrST1K4+XJ44bENOaIAEz350Pluo5ZxkfXKj5Qo93xfj5jffXxED1MagJx1TSLEd3Wuykd1MUO1zHRUXoTOYAhIn3xTrsjmTmj23acq6l3Al5BAFVv9381WRNmT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(235185007)(83380400001)(5660300002)(4326008)(26005)(36756003)(316002)(16576012)(2906002)(33964004)(33656002)(66946007)(66556008)(66476007)(53546011)(86362001)(8676002)(478600001)(6666004)(8936002)(6486002)(2616005)(956004)(966005)(186003)(16526019)(6916009)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cWdJbkJ4UjBCWm1oa0VLeEN1NFRmZ3piTEtuTDdTcmY4ZnZCbDI2Zkc4U1VZ?=
 =?utf-8?B?YStYb2xrY3BLS215V1pjTktEcldhZmMwQXdBUVBTMWY5UTVDYys0TG43d2V1?=
 =?utf-8?B?c3ZCQ1FSK1l0WFAzT1pwVjJjek1EM1ZLb0VtYjFJVDlmeml2QS92TnZIZ2VH?=
 =?utf-8?B?ZEtVa0N4UnB1UVV3NEcxdG5pVWsvZTFCbmErR0RoNXJLUXZ4Nm5JeW1qMFFB?=
 =?utf-8?B?WXhJVzRrSnRaenArS2NuQ3JDbWpvelZrQ0M2R21DQlhCZ1hLVFVBREFQNkhQ?=
 =?utf-8?B?UUlwYlpRQ2xRS3dzU01zaGo4WjYzQ2hWaVJVeGp0MjhvS2FqTkJjMENURU1k?=
 =?utf-8?B?cmZnV1lNSW9BTkNpWUtqZ01IejdZS2JSTDl6VXoyRVpEME9BV3R4eXc0QUNN?=
 =?utf-8?B?S09BQjFCUmV3MVBHcWFjZ0J5aDZ0UXJCYys3QmY0c3ZOUmZXUkNFbE5IakYx?=
 =?utf-8?B?VHJ1emFEWis3bnpNOE1sTW9vWXhadkVZQ2x2MWhKU2hnMWsyMTZFaXhTTm0r?=
 =?utf-8?B?Z3p3c25KanJhUWwzQjgzSTNGSVAxWWR3Si9CQm9DdnlMRXBCZEdMSzBWVW1U?=
 =?utf-8?B?UXZEWE5WcWFvV2U3NVVFdi9VZjJ6VEZ0andwTEZ6SUtpam1xSllzQisybUtv?=
 =?utf-8?B?RXpNRVFlK1lMNm5yMFg5ZTZHVE1UQjVRZXV0QlVRT2h0Y1FKL1k5MDQ1TUU2?=
 =?utf-8?B?VVExSU1SMW84YjQ0aVZYbVpvWDFOWDFFOW9vTG9pYkZTRXpUTTMyR0tjWEpU?=
 =?utf-8?B?NzFkTDNtK0ZoUlpxNFlaL0kzaTJKalBaMGFzSFRTNitFMFRVNkJ1YUFNdmVZ?=
 =?utf-8?B?R2lISnpRby9mRExHUzQ4eGwyU3ZRSlRienYxeDQ4Y0pWS0F6QU1MOUZPc2Vh?=
 =?utf-8?B?UDV1NHZTNjZzZDdwVk11ZEJEdWNycE1YNUFSOGc5dkJBWnF1RWtnc2U1QzEy?=
 =?utf-8?B?ejdSOU9aMzlwYkpaVCtkbjl3NkYrK3g1THpxems1MkloVHlVSkswZ21LRDZF?=
 =?utf-8?B?VlFXRklwbStFT042UHFuZHpTSjU5d1lJcWIvTU42N3MrUUFFNzY1UTNYWUxK?=
 =?utf-8?B?eXdramQ3MFFBVHgyYkR2WENVNTgzdjAzZjZkeWVGMjJTWnJHZ2tNSG9QVnVh?=
 =?utf-8?B?WjZtZlEvUHpuNytwTTFURzVhTXBTdG1FUzBCQzd0aFczYktXL05CWG85NE83?=
 =?utf-8?B?TTNLNC8xZlU5RUVoQ0czMi9MVW9qQUZoNzdPNmZpMVF3K1hVMzB5Tm5vMnhz?=
 =?utf-8?B?YTZNUGxaaFVFcmQ3cG9xZWQ5K3VraHJnL1p5QmNUK2F0ZFpJT25uYWczUkxG?=
 =?utf-8?B?d1pTVityOXA1VDR2c291eHR1NDhOcDN6bkxDYjFwc1dTMHBCU05LbTMwOXFT?=
 =?utf-8?B?NFZjSXQzdTJtUGk0Zm1HRXFvTDZmNFQrdGhyT0RPL08zRldhS3BXM3dkc1Y1?=
 =?utf-8?B?M0ZieTZqZFloRVFkM0FRU3gza3Z2blFsNGdMSFQ5ZFZXTG4xSjJxTTlMaTdL?=
 =?utf-8?B?d1lrWXpnaENqWEtPd2x6MnU5eWplVXFMcFZoZitOS1A3dGhIQ1NUMlJpRkEy?=
 =?utf-8?B?N1BldGE4eFkxZDRxSll5eklOeFdwU3M2ZkdVakQ0RTl2QWdrMWNnbmI1OTZR?=
 =?utf-8?B?UExIQkhnN0FVRGFJcXlSRGhhcVN6OC8vdEJNd3AwWUJrblF6Vm5sM3FzbnhP?=
 =?utf-8?B?TkhwSE95cWtiTVBtNldlcmtLVWgxMkc5cUY3ellhKzJlTkxiL1N3MmxraXQz?=
 =?utf-8?Q?kyB/3wc4GAqU/uQwIRtRlxDxztdRq1H+sJVYLc0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3c13e6-c3e5-4272-de89-08d8dcf043db
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 20:26:17.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMVqs6VJmNTLqdNsHOTL23OOYVq+Vzk/p+pYW8q+kPulCEfNgyZfaJDixlDSFwoJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614630916; bh=TcXNkwWtPCEi561wawVkFCbNQlEdLaajqKxpzBscl1Y=;
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
        b=kaOEQDzrJfZRaxadeZCNoSytJSrS1r3iUzh6pafBNn4nCjtcIe5cKLAfPjkBSqmQj
         06gmUkmJbRXDxVLvhCgv9BJY2Gi3pXE8gJM8ZOqlYhrjiIv3bNk88P2YSjGm2TGgS+
         P3Yu4Figqn582dWLyobVOLcqaYnS1CLIoEV7KSf7kGdvAq9t5D9epv6FCSm93VY7Vl
         3sF2endYI1/YfAONmwxU1bgHee0++u2YSe7khdebAeQ33SWTj4DfDCr0r/c8Yxajki
         lNomKGiltjY94c1ycZl4Q/0DG1DZkuERX10wcCRoKQnE4Q5k3fL8AY6o8/sIZA04i1
         PF3nAFCRyl+Lw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_35B182F9-D59B-4424-93FE-9E511CE5CE30_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Jan 2021, at 2:03, Matthew Wilcox (Oracle) wrote:

> We have trouble keeping track of whether we've already called
> compound_head() to ensure we're not operating on a tail page.  Further,=

> it's never clear whether we intend a struct page to refer to PAGE_SIZE
> bytes or page_size(compound_head(page)).
>
> Introduce a new type 'struct folio' that always refers to an entire
> (possibly compound) page, and points to the head page (or base page).
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h       | 26 ++++++++++++++++++++++++++
>  include/linux/mm_types.h | 17 +++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2d6e715ab8ea..f20504017adf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -924,6 +924,11 @@ static inline unsigned int compound_order(struct p=
age *page)
>  	return page[1].compound_order;
>  }
>
> +static inline unsigned int folio_order(struct folio *folio)
> +{
> +	return compound_order(&folio->page);
> +}
> +
>  static inline bool hpage_pincount_available(struct page *page)
>  {
>  	/*
> @@ -975,6 +980,26 @@ static inline unsigned int page_shift(struct page =
*page)
>
>  void free_compound_page(struct page *page);
>
> +static inline unsigned long folio_nr_pages(struct folio *folio)
> +{
> +	return compound_nr(&folio->page);
> +}
> +
> +static inline struct folio *next_folio(struct folio *folio)
> +{
> +	return folio + folio_nr_pages(folio);

Are you planning to make hugetlb use folio too?

If yes, this might not work if we have CONFIG_SPARSEMEM && !CONFIG_SPARSE=
MEM_VMEMMAP
with a hugetlb folio > MAX_ORDER, because struct page might not be virtua=
lly contiguous.
See the experiment I did in [1].


[1] https://lore.kernel.org/linux-mm/16F7C58B-4D79-41C5-9B64-A1A1628F4AF2=
@nvidia.com/


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_35B182F9-D59B-4424-93FE-9E511CE5CE30_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA9TeMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKQ0kP/iahPETeIDBFgmOBeqho0ttcjgSnEO2vxDfQ
2bwkT/BkSbJFdozgYX9XlbWABp4rePNzLXhnNvD6nZVSS1EiZ2fxk+83lnzFQ3rQ
ffq0M5/fSjpm27ZzRKksGXVFXNa/uk9CKR5YxavmQAKUSqe3GaP8ZVEQXul97twR
fhqi2MpyW2wv4TEuo6+Jby/HPwyB2jsjrx28089TqifcQp3m2odb1rOuY406t/vY
QhED5zD2wvp9/bfMeQrdEZQbUf6xj11xHhLjpeZaBgN7vbytd7FZQwjxYW1R2S8D
ReUdNEfJs1Btm76yn4yTTOOJ03w5YvSARdrV0Lvxsio34T9QqlHzwZWp9yjJ/6Uv
Kb2XfP7gi+e4J7XYrn6ZTeefO1hyxVUoNc6sCS7Y7BST4tX2O0aI2W4ftU5ng0sV
F/0v6CHb6PbbpJj+0FmoFuUqjzBQ3nJqlNSC87LoYecJGxJ8Zdce0qpAEPAidFRz
FGVbXSoMqlu+0UNprU3aH+7afLiXTklSi3ElY6o25ahAQXKC+QBVq0pHdGwmkaBA
qbhUDctrEJhWmAC2t0fJtXWolieC6K47sCTQKKUB60tZ6IYnDu8AnczwNT66Inxc
Oj1pMfUc5bxbLzEyBEHYJDrRQpr180xNSHkbgWJ5zWsWrseSHPBzSya+70lWlkEN
nVZaBvlI
=u8ZM
-----END PGP SIGNATURE-----

--=_MailMate_35B182F9-D59B-4424-93FE-9E511CE5CE30_=--
