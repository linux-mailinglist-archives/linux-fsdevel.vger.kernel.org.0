Return-Path: <linux-fsdevel+bounces-11577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D19F854E8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CAC1F25C06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C5371B5F;
	Wed, 14 Feb 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uhbAE1UL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EAF64A87;
	Wed, 14 Feb 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928096; cv=fail; b=GWpACTs7MKU+qwnRlgKh2SpdT6jmQ9uBoxdM9IsmLsyk8o7JNcT6UmbrkmnsUfZVTx6b4MYbcW65x8FwBKU4RCo46qsGnE9gj6q7bO7dyaWiV6KV6T97usKw5Duisj7huXNvoO2pJ0JtMey3CHz+PCvL/CxagErZXqcSc/r8JH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928096; c=relaxed/simple;
	bh=/QeCv/dTflrH63J9zzvYEkfKOcfnfli1wZj4yBDGDwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxAbCE6K4yDHiVktTk/eL6hptzeK244eJO9qihiXD5wwa2xuqpdjNNqkAgPicTNgagI6hh+rXbr7RBJENoMXHgE4TjvZYdeNjdzdScaTLFvoV/A20HeG0sIRTlkncJYCyC/Jyr6nIRsMEnghw3gZdFgoQFV7P6z1fuOm0XScss8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uhbAE1UL; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcTcoaTY4g/Zj3/7tiLpRkqlrqqgN+0e80OZrBazW/FTi22mlmmyE2WijPPMmsb0YUQP8hLVjeB2rFUnZjhpkQ9/YivlG8en/5u6qBGFaEHDkKyemVZgCR4f/L9jlKIURocxzg6ZUQoioI6+M8A+dIyRxzbXWZgVzb1MEPWc+MohZ+UlLV1kpWMs27H15BuXRiwBEE+q9GDg9rEE1lOHfAG/V11GeiDzNcIiWj9H0FM1IqBzm//2+cU001rdZeDbAxqSf7K07wPMMBwIAhDc9pEufrb7zZoVJoqYjoTfgqgOlKDKHAeOSzUvUgGxG5JN+EJPGf+cA/0xsOLkr/6E4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUKDFiOX2CXHfIpda/J+vTchc0k2z+EtOA1UM9vI+z8=;
 b=eN4tJM3+gZo90xRhQLwAe3jux3E/qolWLL6PZFe2zvnO248hiYLWSrHw/6KpNg57B4AX7JewFoR5Y1KiK87OG66D2rA8bcYxEvInaJVGZc53ot0Mb+rxR8uayVsHsxfoP64WFbONUBH2t2U4osgblIU06wAGfrW4aKQzE+SECV4m/IgLQk8UOSk4Mm179HMsMiCrqw9ck1LP5JpG0eW78EysKkytPblarL2xertTXX7FTAw/LmmjEHL88CMOSvQ8NO0i+6mQdFdXT6mzC1iVycnrv72x9b4xSMykmm+6Ye+JuwGdDcLuc2Z6WTv5B5lMe5X1itfmMnhlTOwZWj6Uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUKDFiOX2CXHfIpda/J+vTchc0k2z+EtOA1UM9vI+z8=;
 b=uhbAE1ULb8sDcXjw3aOQ4zKAH5CZXzQ6ne69P6gwIRWvk3GMIMguEmoskQu0k7U4CWhQiywAvdwHYqUtsfMDVc5/X0pzqSwwDHz4lP3Y2lAbV4pEk4BCmpEHeSUE3isZSboSKm9thAs+VoC7kCx2Osy5UQVfe/KCJciVqwzdFsbE87vGm3CrajpiqGpowUGVPL7sk6byLBgptDCtxuxub6BV6As9ABi37XRTvz5Hu3mC1z33WUyCfO2W1a8cL4C1woNczOXANlP5M/Ja0PBWZ/39NtyaBBkghbgKtHuytRRPbR5/gwrKT8X2nbGdxuHgMxZItUfmSc+64paHvVuJwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Wed, 14 Feb
 2024 16:28:11 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 16:28:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/7] mm: thp: split huge page to any lower order pages
 (except order-1).
Date: Wed, 14 Feb 2024 11:28:07 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <5D3CF5B4-FB16-4CE7-9D8E-CBFFA7A1FA43@nvidia.com>
In-Reply-To: <6c986b83-e00d-46fe-8c88-374f8e6bd0fa@arm.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-6-zi.yan@sent.com>
 <de66b9fb-ee84-473f-a69a-2ac8554f6000@arm.com>
 <6859C8DA-5B7F-458E-895C-763BA782F4B9@nvidia.com>
 <6c986b83-e00d-46fe-8c88-374f8e6bd0fa@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B8C3C027-FEFE-458C-95A5-CEBF71F01278_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b0c968-eeb8-4839-16b8-08dc2d79ef44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OLSDUckowh+5C1VMMsiKWNvq8bURafx68OeoA4oViszijM3ASEZDEB0s904AlU+s1NQdY9mQjPuCpCktTjNs9j7vqSMAOmNsuj68HYcdF4JRqReW4A360ZPZllEC8h9qoo71MiY5RR5zoHW3q7XcgktazKF987uyUiOrg7NaFtAWnOMHj69yVTZmRg7eYXUaH4LmahfuatS64fJHa7lHRezg+Cn2gSqXxBz8oc+JAQ1XPQr3oE3qluY1osuQhdrWVVfbCJfo1Dlan0xatiB/7BA1OeV8NLwFS/PK7bpKDFvURCaMvuBxKOPCj6M2nWCLp8aHt9yMJdKOBMRAuNN+cKbavNKZQA09oSx1nAu5DR7DCxXDwUTD45C3X4MGYe2ak7KWpZfR5JSjw+KF+AqAgWMnYBaSWeGdZ+8lCYd67zMq8M82gvG+8yWRZwsGAk0rPfqiaV4blVZWnTTue/2Psd49Yn2ZLuWbkqMJGqr/tBN8UbRevx1uYmaS7TDS+04CT43SQmpnXpmfL3wbdrpcVYWzaD+2pplvVsr4Q8NHOj3+Bh/Th3gxRqzemDk5SVEM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230273577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2616005)(83380400001)(26005)(38100700002)(478600001)(4326008)(7416002)(66476007)(66556008)(5660300002)(8936002)(41300700001)(6916009)(6512007)(66946007)(2906002)(6486002)(53546011)(6506007)(316002)(6666004)(54906003)(36756003)(235185007)(8676002)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5TXq5+SxK5E8dEmOJYd5I4Hwz/u2GAxZwvJ53GGivS5IbgvXP4aac07xQDZx?=
 =?us-ascii?Q?X8ae/ty5XaCYd+gK07Vm017hbBsI4bV2iiEmNdzHs8VVdOu/N2HkB3DE3Z7F?=
 =?us-ascii?Q?TtcaIdJgcrUWfo3HG3j3hdMqsfVT5Bc8jG0B96WVDJLtKybsFeiQ5jkHpcFe?=
 =?us-ascii?Q?MP7c4v3WVjJ6VE8JDQRHjBjJHRRCxlFJOlVu0ISr9UL0JUCSRSlV4WuqTpqu?=
 =?us-ascii?Q?ogWyNINSA906oY1jUgmvKLfc72j5kfvuURJ0TU5xlrEWn8+u87WxKzgR+JuD?=
 =?us-ascii?Q?HCXUZ4rhwoWZocxceDtmZpg1AJCjNxJjr3yBL64hxWk+1nyA1dHXFrY3iDy2?=
 =?us-ascii?Q?a1LhplrhuB5u7W8C0l7DZOEi1z5AXmbITRKdAoLpa2jpNOHiudnCX9ViefZJ?=
 =?us-ascii?Q?o7EKWFzMfwtFXW4ZEjPnZI+Y7g+G0se3640LKgc1fDX+SxFmZheJwFScjLSE?=
 =?us-ascii?Q?ASw9Sbcmy6cJzvHkSNT+HOhdw986bvRplcyuwvBKzL3/8c/AI7e5mVxnqUqi?=
 =?us-ascii?Q?2EUmeBCPz1DFEcSbX1I+H3iTICiloYQAlZVFLTRQQVhdEe4vK/4J4YAaCzZr?=
 =?us-ascii?Q?gjLlwVfJGWALj631DgwcERfSF8+joVjYzhF6kc4jNQkWWeokZoBzZkJCfCQ2?=
 =?us-ascii?Q?UiHGJBOWlB96hv48yjI/iDFiACJnKeJwpH1HZIeT/qRkU2UVi6Lj2lg8fLfT?=
 =?us-ascii?Q?Zi3jFegsdRDUY1BQTy3uMg9fDGWTVcCRkuLJ+KzupvWNQ2JFonXuajwUamwG?=
 =?us-ascii?Q?ybdWG4CYmiZRWuHhVv7c85wiomBCHXO/QRu0dsE+15wNlBrtRkfx01EhOnFd?=
 =?us-ascii?Q?jCvWgmf+1I6qSpdhzajBzdmS5X7mbayIHKhYKGw+2vJlPHU8XCl0OjwyR9Ze?=
 =?us-ascii?Q?NUneMB5vGCxMZDqDMK9iP3WA3S3f81MVthBbOxmYC2S3xsnuQwtoBvyiOpUl?=
 =?us-ascii?Q?v9IvsXMozuRuuijE+RFseFoYlkcD5qqKkpSBDREeK7TKTo6Ds/g3DhOpf3PQ?=
 =?us-ascii?Q?xI7Zs/OUnTQt3FJa5CPds/Uv4zGEb6GqNzW1yCVNHNboDDggINLoxlpKt9Ol?=
 =?us-ascii?Q?R9+4o81wlFq3nxrA2ZdS0SqFQn21PKWnAl4Z+3akNCxEl1KOHNPlAUu4/huC?=
 =?us-ascii?Q?jWFJN28P8cEJnuaBW1HXN9stpzYeVecG5hwD5to+/RsXsgYY434lrbZdzWjU?=
 =?us-ascii?Q?2QAK+B33ve9Zy5HmvJ/6kMFnCyl8eoUyPAYWc2ix92RjZl8+8+zTNjWV/E98?=
 =?us-ascii?Q?5Z+rOQWv0F5sK+PYiDP1HIKFc31Bng0uvukBdUSpxzyKSlPs+cKQu0iDOE36?=
 =?us-ascii?Q?E3htD5ghO/Ws4TKDIcF48ZlKRU+FOZTD9n8BA7B5ic8IdCu8gGV3F6BbKSoP?=
 =?us-ascii?Q?UrnRgLisZ/f9yGysXG50l4sxs0vnv9LgHbgWVo1IageT/5g0r1LHxCzWolw+?=
 =?us-ascii?Q?9Qp5lUBQWelIpkihJMLHXW16AOfHnv30MYnCXNTZxhRvhmmoFJnSsjdYN1d5?=
 =?us-ascii?Q?kkPqxd4VKkIWDfWtzFv/jApIXTJqzlfVQBCm3q4oZbiAkSpr78A4xMkYessr?=
 =?us-ascii?Q?QKy/l+mHuF3zZBSb3JL7gOfcWB4ViCSb5PzgSv+5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b0c968-eeb8-4839-16b8-08dc2d79ef44
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:28:10.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpETOXiRc59aTd//horPJSJw7/5kcrUFFBWlFHOEke4W8nJMBLyjESo5HvdVCe45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

--=_MailMate_B8C3C027-FEFE-458C-95A5-CEBF71F01278_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Feb 2024, at 11:22, Ryan Roberts wrote:

> On 14/02/2024 16:11, Zi Yan wrote:
>> On 14 Feb 2024, at 5:38, Ryan Roberts wrote:
>>
>>> On 13/02/2024 21:55, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> To split a THP to any lower order (except order-1) pages, we need to=

>>>> reform THPs on subpages at given order and add page refcount based o=
n the
>>>> new page order. Also we need to reinitialize page_deferred_list afte=
r
>>>> removing the page from the split_queue, otherwise a subsequent split=
 will
>>>> see list corruption when checking the page_deferred_list again.
>>>>
>>>> It has many uses, like minimizing the number of pages after
>>>> truncating a huge pagecache page. For anonymous THPs, we can only sp=
lit
>>>> them to order-0 like before until we add support for any size anonym=
ous
>>>> THPs.
>>>
>>> multi-size THP is now upstream. Not sure if this comment still makes =
sense.
>> Will change it to reflect the fact that multi-size THP is already upst=
ream.
>>
>>> Still its not completely clear to me how you would integrate this new=
 machinery
>>> and decide what non-zero order to split anon THP to?
>>
>> Originally, it was developed along with my 1GB THP support. So it was =
intended
>> to split order-18 to order-9. But for now, like you and David said in =
the cover
>> letter email thread, we might not want to use it for anonymous large f=
olios
>> until we find a necessary use case.
>>
>>>>
>>>> Order-1 folio is not supported because _deferred_list, which is used=
 by
>>>> partially mapped folios, is stored in subpage 2 and an order-1 folio=
 only
>>>> has subpage 0 and 1.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  include/linux/huge_mm.h |  21 +++++---
>>>>  mm/huge_memory.c        | 114 +++++++++++++++++++++++++++++++------=
---
>>>>  2 files changed, 101 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 5adb86af35fc..de0c89105076 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -265,10 +265,11 @@ unsigned long thp_get_unmapped_area(struct fil=
e *filp, unsigned long addr,
>>>>
>>>>  void folio_prep_large_rmappable(struct folio *folio);
>>>>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>>>> -int split_huge_page_to_list(struct page *page, struct list_head *li=
st);
>>>> +int split_huge_page_to_list_to_order(struct page *page, struct list=
_head *list,
>>>> +		unsigned int new_order);
>>>>  static inline int split_huge_page(struct page *page)
>>>>  {
>>>> -	return split_huge_page_to_list(page, NULL);
>>>> +	return split_huge_page_to_list_to_order(page, NULL, 0);
>>>>  }
>>>>  void deferred_split_folio(struct folio *folio);
>>>>
>>>> @@ -422,7 +423,8 @@ can_split_folio(struct folio *folio, int *pextra=
_pins)
>>>>  	return false;
>>>>  }
>>>>  static inline int
>>>> -split_huge_page_to_list(struct page *page, struct list_head *list)
>>>> +split_huge_page_to_list_to_order(struct page *page, struct list_hea=
d *list,
>>>> +		unsigned int new_order)
>>>>  {
>>>>  	return 0;
>>>>  }
>>>> @@ -519,17 +521,20 @@ static inline bool thp_migration_supported(voi=
d)
>>>>  }
>>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>>
>>>> -static inline int split_folio_to_list(struct folio *folio,
>>>> -		struct list_head *list)
>>>> +static inline int split_folio_to_list_to_order(struct folio *folio,=

>>>> +		struct list_head *list, int new_order)
>>>>  {
>>>> -	return split_huge_page_to_list(&folio->page, list);
>>>> +	return split_huge_page_to_list_to_order(&folio->page, list, new_or=
der);
>>>>  }
>>>>
>>>> -static inline int split_folio(struct folio *folio)
>>>> +static inline int split_folio_to_order(struct folio *folio, int new=
_order)
>>>>  {
>>>> -	return split_folio_to_list(folio, NULL);
>>>> +	return split_folio_to_list_to_order(folio, NULL, new_order);
>>>>  }
>>>>
>>>> +#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l=
, 0)
>>>> +#define split_folio(f) split_folio_to_order(f, 0)
>>>> +
>>>>  /*
>>>>   * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP =
due to
>>>>   * limitations in the implementation like arm64 MTE can override th=
is to
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index ad7133c97428..d0e555a8ea98 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2718,11 +2718,14 @@ void vma_adjust_trans_huge(struct vm_area_st=
ruct *vma,
>>>>
>>>>  static void unmap_folio(struct folio *folio)
>>>>  {
>>>> -	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD =
|
>>>> -		TTU_SYNC | TTU_BATCH_FLUSH;
>>>> +	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SYNC |
>>>> +		TTU_BATCH_FLUSH;
>>>>
>>>>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>>
>>>> +	if (folio_test_pmd_mappable(folio))
>>>> +		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
>>>
>>> Should we split this change out? I think it makes sense independent o=
f this series?
>>>
>>
>> Sure. Since multi-size THP is upstream, this avoid unnecessary code pa=
th if
>> the THP is not PMD-mapped.
>>
>>>> +
>>>>  	/*
>>>>  	 * Anon pages need migration entries to preserve them, but file
>>>>  	 * pages can simply be left unmapped, then faulted back on demand.=

>>>> @@ -2756,7 +2759,6 @@ static void lru_add_page_tail(struct page *hea=
d, struct page *tail,
>>>>  		struct lruvec *lruvec, struct list_head *list)
>>>>  {
>>>>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>>>> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>>>>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>>>>  	lockdep_assert_held(&lruvec->lru_lock);
>>>>
>>>> @@ -2777,7 +2779,8 @@ static void lru_add_page_tail(struct page *hea=
d, struct page *tail,
>>>>  }
>>>>
>>>>  static void __split_huge_page_tail(struct folio *folio, int tail,
>>>> -		struct lruvec *lruvec, struct list_head *list)
>>>> +		struct lruvec *lruvec, struct list_head *list,
>>>> +		unsigned int new_order)
>>>>  {
>>>>  	struct page *head =3D &folio->page;
>>>>  	struct page *page_tail =3D head + tail;
>>>> @@ -2847,10 +2850,15 @@ static void __split_huge_page_tail(struct fo=
lio *folio, int tail,
>>>>  	 * which needs correct compound_head().
>>>>  	 */
>>>>  	clear_compound_head(page_tail);
>>>> +	if (new_order) {
>>>> +		prep_compound_page(page_tail, new_order);
>>>> +		folio_prep_large_rmappable(page_folio(page_tail));
>>>> +	}
>>>>
>>>>  	/* Finally unfreeze refcount. Additional reference from page cache=
=2E */
>>>> -	page_ref_unfreeze(page_tail, 1 + (!folio_test_anon(folio) ||
>>>> -					  folio_test_swapcache(folio)));
>>>> +	page_ref_unfreeze(page_tail,
>>>> +		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
>>>> +			     folio_nr_pages(page_folio(page_tail)) : 0));
>>>>
>>>>  	if (folio_test_young(folio))
>>>>  		folio_set_young(new_folio);
>>>> @@ -2868,7 +2876,7 @@ static void __split_huge_page_tail(struct foli=
o *folio, int tail,
>>>>  }
>>>>
>>>>  static void __split_huge_page(struct page *page, struct list_head *=
list,
>>>> -		pgoff_t end)
>>>> +		pgoff_t end, unsigned int new_order)
>>>>  {
>>>>  	struct folio *folio =3D page_folio(page);
>>>>  	struct page *head =3D &folio->page;
>>>> @@ -2877,10 +2885,11 @@ static void __split_huge_page(struct page *p=
age, struct list_head *list,
>>>>  	unsigned long offset =3D 0;
>>>>  	unsigned int nr =3D thp_nr_pages(head);
>>>>  	int i, nr_dropped =3D 0;
>>>> +	unsigned int new_nr =3D 1 << new_order;
>>>>  	int order =3D folio_order(folio);
>>>>
>>>>  	/* complete memcg works before add pages to LRU */
>>>> -	split_page_memcg(head, order, 0);
>>>> +	split_page_memcg(head, order, new_order);
>>>>
>>>>  	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>>>>  		offset =3D swp_offset(folio->swap);
>>>> @@ -2893,8 +2902,8 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>>>
>>>>  	ClearPageHasHWPoisoned(head);
>>>>
>>>> -	for (i =3D nr - 1; i >=3D 1; i--) {
>>>> -		__split_huge_page_tail(folio, i, lruvec, list);
>>>> +	for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
>>>> +		__split_huge_page_tail(folio, i, lruvec, list, new_order);
>>>>  		/* Some pages can be beyond EOF: drop them from page cache */
>>>>  		if (head[i].index >=3D end) {
>>>>  			struct folio *tail =3D page_folio(head + i);
>>>> @@ -2910,29 +2919,41 @@ static void __split_huge_page(struct page *p=
age, struct list_head *list,
>>>>  			__xa_store(&head->mapping->i_pages, head[i].index,
>>>>  					head + i, 0);
>>>>  		} else if (swap_cache) {
>>>> +			/*
>>>> +			 * split anonymous THPs (including swapped out ones) to
>>>> +			 * non-zero order not supported
>>>> +			 */
>>>> +			VM_WARN_ONCE(new_order,
>>>> +				"Split swap-cached anon folio to non-0 order not supported");
>>>
>>> Why isn't it supported? Even if it's not supported, is this level the=
 right
>>> place to enforce these kinds of policy decisions? I wonder if we shou=
ld be
>>> leaving that to the higher level to decide?
>>
>> Is the swap-out small-size THP without splitting merged? This needs th=
at patchset.
>
> No not yet. I have to respin it. Its on my todo list.
>
> I'm not sure I understand the dependency though?

IIUC, swap cache only supports one cluster size, HPAGE_PMD_NR, so splitti=
ng
a PMD-size swapcached folio will need to split a cluster to smaller ones,=
 which
needs your patchset support. Let me know if I get it wrong.

>
>> You are right that a warning here is not appropriate. I will fail the =
splitting
>> if the folio is swapcached and going to be split into >0 order.
>>
>>>>  			__xa_store(&swap_cache->i_pages, offset + i,
>>>>  					head + i, 0);
>>>>  		}
>>>>  	}
>>>>
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_B8C3C027-FEFE-458C-95A5-CEBF71F01278_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXM6hcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUgiEP/18dlvMYmJSIGwrUYqz5rzrfeiNbQpKJhI7w
fcSyv0g209J8PdYP9lwO/7r+gMFkuC7bBv9WdH5smmNx5RifMjV8rXwlo+DW1Jmi
GqVY/yKXb2dJubrj+L7ciPUWM7he1+BCSHk7DATRXRFIHK3nuxvLfXlGb99A3I+H
uoMCGXEKDf3ApiauMHcTQrgkLd8lZXDdtC+YDcfzOlA3ELbzco7yO8xWkr0Y4dHf
1rLPD7G9F93GjpHGenEenDXEVpr8wgOsMJHUn3UcRR9K2KuSAUvEa5VdtG+FtdFQ
ueOh45Y6CdO0LQF3oogNp3Wnfe1uFFll83qcKMsJ70Aen8uhSXIENiuHa9q4MH8z
Gc2P7BNFCNKlBMdnGxNRHdomU3a3TeUeLHMR9nJhhhhmqj1q06b6BK9PY5+AsVYL
6R+eMSakbREf8I9YmJZwfUL2L0+i4XHnoJUeCSmw3rLgBNT6y+tWmUoWd7W9XIkK
oghfNdeNRLvY2tpdr2OnZCSDQFem3w74sgtLPqU8zO1QY+mmWjU71j0AkxMuUSPj
+Si/uZEVgBdkyQepMjnNnxIiSbMNpg421CdVyAWYW3RtAXugC7OGg6qHRpasTaMe
hUUj6UuTbDyZ8bSwTIiD6lsYhEI4F3f0UPUIyi5j9VrIg0vvXYM9qF1KYmB+PN2j
V2OZIL5C
=XGPg
-----END PGP SIGNATURE-----

--=_MailMate_B8C3C027-FEFE-458C-95A5-CEBF71F01278_=--

