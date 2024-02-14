Return-Path: <linux-fsdevel+bounces-11579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04403854EBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123871C2091A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA52604DD;
	Wed, 14 Feb 2024 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jRXu04P7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88475364BD;
	Wed, 14 Feb 2024 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928561; cv=fail; b=qK8SF97xnhaHPl9qIpSPm11EDAdGSRmLb6v66Ga+2Q/fO8emV1cx23JrWQ3SokzpeKkoXTXHVDT+jhZwX3h3nhApbXSgom6jx9SD4jzJs+NHJF70cG6OCkpRoqzvelQb0w71EOnvqakmJLnZWL67pkfE0kTYujR5iZfxbMTM4y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928561; c=relaxed/simple;
	bh=gmSoxnMEwsA1i7R6vXFAa7ryWVHURQckQiU2eakc4b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QydtlwhYwpscVhPC5/kyiTzYBQrGThO83N4WKuwUnq3EcJ3Stjzj8dAjotszTWfoIjUI0y9/vrHzMO3oopn+/R1TIqxzAos+7FP7q2Qe4a1weNgAvcLdwR61eb0rai+ObB56lpccWPf9YRPbCTEOKnV13RaHNL4UAARir1+9D54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jRXu04P7; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8MrCNJNVNq2cdfp5QnQNFNGDCaERR0ECbyeuwrI+nLNB0WpshZ8XjQRILCSpbk3UF7iO6ZhN45x0pZKnc+P9XSsHuy3aXTlvp5UpGOwpOtbrEW5bNnxHjs13AztVwahAUVXzS0y/eZsoUbISMr7eDz/fEId+k2lUHXD087aW5vkRNr614PpDisfrH3SVJb7FWVtp+hPj1avkw0uC6YqAeTzxUlUskrYronRsQj+1n1RCtKWCVoTd3zGn9ZvidvTvHzCWU99WwY7puLR5CQX3kogJV1QR5ywi9/3GxNVxP/fNzTzAkogJ0Co2B8NbZ0HqI/urfrQvMEyHvAxwPDhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiGKdbn967pSLN7QyB2/nldHKGt9kw98GWWSN5BW85I=;
 b=nZmgAxaulCHRIIa8+mDp7JJbhkfq+RAsSZbP5hZW0yzOJ0tVj5PfAgYH40KqWJO/ONzAR6DZFuFXOa5lvg+j/LqfI3FniN+lMxGs0LsfiW1sOW5s9ekAZhgAMlciWvzqm9wcbgM1sBd/Du+kYuHqknn4MqH+ybfn/gE956nMlk3WzyaBXDu3jbajQeoyfdiIcooJTTTYPj7+olH7ZK7yHgOmFMXsJcHkoVDwHsKNrRbPqUA9r10wYzRCEa5k8j6biJ3gGKk4+X9xKwYSg3q8qedlenurdxsdbGBzbDQ9HRl6MsDJdscGAcff9PnFgnZcGXSXSrmkNLLTSnCzUPu/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiGKdbn967pSLN7QyB2/nldHKGt9kw98GWWSN5BW85I=;
 b=jRXu04P7XnxhXwtJaq+3i/i7jYvMw68kPayBwr28eG2EdgxugtQSRuyq8pjrLAiyzvCY+PFIyLz18Lu+/Gwn7LtWZG+xkK4+gypuxxiIvUi1Vn96WxDEX86NCW+bxcXyJXeovqeIYPRMZR22ft7LXWQPBl+slf0M6g62ysEKr0AexiOoS9vIjgx4roDqm4z+/mQE8YM7i5ClPTsto9lPfQeIWTM3wrStV88upNKvGIZYuhOcIguKMED8dQJaV/qNwobgL835gtXWljCsaNPv4DLLok9HVgTz+1ncHtOl/nR5ryzdKJYEZ1u0R8CbZ6be+Sl7eDqoNeVKQDacBMaK4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Wed, 14 Feb
 2024 16:35:53 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 16:35:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Split a folio to any lower order folios
Date: Wed, 14 Feb 2024 11:35:50 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <3D59E86D-0B66-4829-AE33-280317F913D8@nvidia.com>
In-Reply-To: <46f61262-e197-456c-97f1-d464ad5688c1@redhat.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <659e1abb-40d0-42ba-ba0a-8256d7eb1c5a@redhat.com>
 <F4470D3A-DC2C-4A6A-B65C-1C94D732A60E@nvidia.com>
 <66d4b27f-85e4-458e-8d66-54f800c5c65f@arm.com>
 <46f61262-e197-456c-97f1-d464ad5688c1@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F12DAB28-7693-40ED-B067-53D889A5D109_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0338.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::13) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c815335-ce51-45c1-d35d-08dc2d7b030a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3yJDn+MKBP3IK7Mat2zoTj+rUbBvl9w71x9l/wUARaGxtSZGg/fttSVBmvIA5BuPuuaJZMuJkpkzdFtJ2Wfpv0LtZDYYcPW8kSGaGbw//TZd9Nd1q+pvoyhPIEPnTxMTAywpJvnqWLmxO5avddQbpxks2D+2L1+4OctDdWHPqSYxpmlhIY+xZNP28EOx/Q8gQDch2VK2S848oIMtE8dCh87LLN19dnlWGsz0I/zWTjSO3MhJNCdESGiB0xO7NeEnrmwbDsGyFfnd8RTzjCb//hj379PjYSlWiQrghNKKmZmo9ShpiycJrK3/PrzM+pDC/jmzFL/SWSe8RvZFNg/EzT3axqrFwOzCanmUJBjqxB3XU5+z7mgM+GkAe8KZuZv9hKbaBajh3NKEaweAWsJRhu5DJEn3T8U0H5J7EKEUr9PxSicxjPf63e03D9kYrCAj1VaIrXfbBNUaYd9z/NRnes82b4x5iblFEXGVi6tS4LnD+cLorFeLa+yhKRycivQE9byB4vqLjX+u18OEpQaieSj8UsOJ6Z20j1s0nlWFEgqEiPPAD/dtceDxme9eedTt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(86362001)(41300700001)(83380400001)(66556008)(66476007)(66946007)(4326008)(235185007)(36756003)(478600001)(8676002)(5660300002)(6506007)(7416002)(8936002)(54906003)(6916009)(2906002)(316002)(6486002)(53546011)(26005)(2616005)(33656002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?72lrftXv0rGSbFRfhAjsOIMClmX48KUJtPewWVXdvbTz9/RQXetk9QnoVo7t?=
 =?us-ascii?Q?2mwNmNF34D3nVNYs5CZ5+xjjGZRMaiJvGKFH4VhkdewC1U/PGkwlNwrSO2iF?=
 =?us-ascii?Q?p471dg0XbZ4Tp4lRjWefkegdjOeZijZl4UB0bYklSdnrVFE2l0TshuZ166XH?=
 =?us-ascii?Q?hg03WB7gX3RInAEV0XWFISzKJAhwjF1mNnVapjlczxuAP2QRcFDt/D16zQnZ?=
 =?us-ascii?Q?mTev8PO7MqJMnHg1KJD2/sg4/sYzlVRfE2BiHtO7bRRO2FpWWbAmn36w13C9?=
 =?us-ascii?Q?iWB2mSRu/WoA4x05JUrcvHMAZaGNqiNau/VqdsgZQ1fUpeW+RrcTT0PuNzCh?=
 =?us-ascii?Q?b3OcbLQy4UvzVKOltwUTJ5iDnvfHmhf+aDeUUBxXw4IdzdeElg5kRtw8Efsv?=
 =?us-ascii?Q?C/Pe527bCWZyT1+UZSrjLaUxU70W0FzgIZncsauVasZqFRQIQPFBuo7YC6Yd?=
 =?us-ascii?Q?5lzaylKG+jDMhU5wW+nyBbfcoF9tXUfInp8Zj4UU39Lr6zYQQqQ26ZOu1a9g?=
 =?us-ascii?Q?r7vUKy4GcVHj7JS+KpCHeXoDfQGyknbnPbm9VB0gwF6S5kklIjVxtLBd89CZ?=
 =?us-ascii?Q?C8+FUrITwP9auxqMSv9mXyZb2iKYwKcgag/tXVajnJRMyeu/Kmx0QsEF3/lO?=
 =?us-ascii?Q?n9Uipkzfe35v73PlyCtAcufu/xYWsPi4OfiRf05bGFDKco4z9D8U6O720ZZs?=
 =?us-ascii?Q?rJ92RkdyTzaYeFcKv2se2TlnG267/5cmipOa1hIMMX98+VEdId9h7XcMcECu?=
 =?us-ascii?Q?ntkRS+zM5W6irroG+/UcWzZ9RMbcynt2j/rLjHCmkT+Sjc7Stjio/aLtgWcm?=
 =?us-ascii?Q?YScobhIPubGkftbzCpkK/BieVfPAS0fsxu+lmyEgMqbf0/Tnh85nqflM6EC6?=
 =?us-ascii?Q?jDYzxxd3AsM8TTd+pOlSSyiLnU/jjUmJ3zdj1LtmQA3XRYBvkc4kxwqhcBfP?=
 =?us-ascii?Q?RhwfzvgMDvjMU1J/7Kvcgg0SD9uov8du9dAd+gPbiRTMkSbL5ymFjT17/zcn?=
 =?us-ascii?Q?3AmnONh1+eyrQXmkUiqK3eP0Z9XhFe3/VhHV8Or7E5xMrdNPZ+CVQCtHg/z1?=
 =?us-ascii?Q?gER2fePCRw6mMxUS/TOC8jPLrDAMH9BkjKuSL3ET10NBQRvpXtFlttxUBY8Y?=
 =?us-ascii?Q?Or6Mms9jPCsI97T7Yq03BoOKQNQC4gPxHjEuQo5JhdtktlTfvojrh2/bqbWr?=
 =?us-ascii?Q?mxsDPRDFXZGpBdAPg6B8cnMZwZ5oNK27+dk5GThoKFfzStVOVTkdAmdj4a0N?=
 =?us-ascii?Q?IjwphT9fjDPUl2Hsyg+p1A293EJt15JF7FbXo/ExH+1L8oh4PcqRYgr/YxGk?=
 =?us-ascii?Q?9yzyRgjPppCwbT9SFB7OBN7yeePGep4Tv44rTKGPgIm02dfCRaobODlrj03I?=
 =?us-ascii?Q?+o/3R+gUbC5OCt+TTUhxmo0yRREozOsAqYOaPcJc0JIVD49booNT5VW/qPUz?=
 =?us-ascii?Q?QfVX7krwvXI0Y5aCcWma2MpcT6iVmK4OIr5PTMkQcerZKG7zsDdrxrxoooDj?=
 =?us-ascii?Q?AVeAHpdrR6NgcZI9PGqcJe2JvZgtYnhZxig3QBAO5ldlk8fY1PCg0T8ImZ9p?=
 =?us-ascii?Q?f4SLOweV3zPiKjOLmoDw/3CQHrTdyMAGonYkXoG6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c815335-ce51-45c1-d35d-08dc2d7b030a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:35:53.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zxIAs04AC+DjKeMG9MgB1g7Pf0rkzzA9OYKtTjtUgSf5xFOAsp3qPtJUM6XwUNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

--=_MailMate_F12DAB28-7693-40ED-B067-53D889A5D109_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Feb 2024, at 5:55, David Hildenbrand wrote:

> On 14.02.24 11:50, Ryan Roberts wrote:
>> On 13/02/2024 22:31, Zi Yan wrote:
>>> On 13 Feb 2024, at 17:21, David Hildenbrand wrote:
>>>
>>>> On 13.02.24 22:55, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> Hi all,
>>>>>
>>>>> File folio supports any order and multi-size THP is upstreamed[1], =
so both
>>>>> file and anonymous folios can be >0 order. Currently, split_huge_pa=
ge()
>>>>> only splits a huge page to order-0 pages, but splitting to orders h=
igher than
>>>>> 0 is going to better utilize large folios. In addition, Large Block=

>>>>> Sizes in XFS support would benefit from it[2]. This patchset adds s=
upport for
>>>>> splitting a large folio to any lower order folios and uses it durin=
g file
>>>>> folio truncate operations.
>>>>>
>>>>> For Patch 6, Hugh did not like my approach to minimize the number o=
f
>>>>> folios for truncate[3]. I would like to get more feedback, especial=
ly
>>>>> from FS people, on it to decide whether to keep it or not.
>>>>
>>>> I'm curious, would it make sense to exclude the "more" controversial=
 parts (i.e., patch #6) for now, and focus on the XFS use case only?
>>>
>>> Sure. Patch 6 was there to make use of split_huge_page_to_list_to_ord=
er().
>>> Now we have multi-size THP and XFS use cases, it can be dropped.
>>
>> What are your plans for how to determine when to split THP and to what=
 order? I
>> don't see anything in this series that would split anon THP to non-zer=
o order?
>>
>> We have talked about using hints from user space in the past (e.g.  mr=
emap,
>> munmap, madvise, etc). But chrome has a use case where it temporarily =
mprotects
>> a single (4K) page as part of garbage collection (IIRC). If you eagerl=
y split on
>> that hint, you will have lost the benefits of the large folio when it =
later
>> mprotects back to the original setting.
>
> Not only that, splitting will make some of these operations more expens=
ive, possibly with no actual benefit.
>
>>
>> I guess David will suggest this would be a good use case for the khuge=
paged-lite
>> machanism we have been talking about. I dunno - it seems wasteful to s=
plit then
>> collapse again.
>
> I agree. mprotect() and even madvise(), ... might not be good candidate=
s for splitting. mremap() likely is, if the folio is mapped exclusively. =
MADV_DONTNEED/munmap()/mlock() might be good candidates (again, if mapped=
 exclusively). This will need a lot of thought I'm afraid (as you say, de=
ferred splitting is another example).

My initial use was for splitting 1GB THP to 2MB THP, but 1GB THP is not u=
pstream
yet. So for now, this might only be used by XFS. For anonymous large foli=
os,
we will use this when we find a justified use case. What I can think of i=
s
when a PMD-mapped THP happens to be split and the resulting order can be =
a HW/SW
favored order, like 64KB or 32KB (to be able to use contig PTE), we split=

to that order, otherwise, we still split to order-0.

--
Best Regards,
Yan, Zi

--=_MailMate_F12DAB28-7693-40ED-B067-53D889A5D109_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXM6+cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUVosP/0Fd8rJzrwcJQR1fD6IRLWQ2HLeASzM37Uec
5aSfg9tHn9hsNzYXmwaLcJhYjBRWWQ+9SBAfG+pdeYtudAxmOhmBECuf6evnE6uS
Obx4+f6xgXU19SiKe60q1OijOjIS2VAVcItGjA327xVkJ9vniPWYj4Wv0nRYcGaF
S0+z9I/H/7FkW+Tz9VVCYJqC/zDaWyMlImacY3ccX8OvNyiRiLwDI/R8G1jKRFt/
HghzYcPNlPRF2vgiW3fKR6Hrpy4Vo/nZs+0N5JPCNbQY/KHDx2Uc+bZbZetGFqak
4a63k/J3bAcaoRx1pFZeSWRxT1fpjHx0/r5EmCx/lmI78Zsz/HAzllEgAa5m4U+d
S3BST4m3SFpAEBc0oEIIzhr2S+ZRCHAQ7WiRYYtxiLiuDIoG+yA78qvUbHG3duIa
tt+ixRtryYyBidios+X0deLt+AVxsEfQA5ASy7mp4c7wZ7/E6b9dnQLD0YRhQ0Vt
ehguEnv7xtusxQQFS4Qc0wZrqWalkH9Z7beTFRFi3sD1+DZKY64vCoVCoWgSMBo6
R9xRyTk3xSHhLwR23xnQ1RG7FNWLoLa/qhxploO745CkgUD72hdolFSgii1x6rpf
jOgAGi3XHRhaFM//LOW9aVFKIOjVIEIBuT62Yu1p7ltuCi6DjJYEutbB9BCpDKKQ
S2Z7WO/a
=z7b4
-----END PGP SIGNATURE-----

--=_MailMate_F12DAB28-7693-40ED-B067-53D889A5D109_=--

