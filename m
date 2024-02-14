Return-Path: <linux-fsdevel+bounces-11574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA61854DF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47181F2546A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFCB5FF17;
	Wed, 14 Feb 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fx/DlMs/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC05FDD5;
	Wed, 14 Feb 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927565; cv=fail; b=IrtUg7vE2nlaj264lUEiQqeKAhiWnSd+Xzsz4M6ijYs2E7ZX4GqPcMIvv0c0n0mHUydA24l0E3cqfPdnxjQP2BojhgwcvkYVgmztXc3d/x/AWh03EPLWcXxGjZTjKG7+C64X2vvAadgTc0F2x2OTVWpga56Q1cInC8Js7aL76AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927565; c=relaxed/simple;
	bh=jVFfDsUGEuOMER3k3M9fUuYsIdDNL2Y+V0CElwPnSuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqewCRZDYPbKyrdAhNMGPWu4pvOwegxuma8MRywTWnl3wVC86b0UmRu3MIcm48nGSijEVptuVsnJBW0PHtLBq70r0dQnxHYfczJVSm2Xe9AaGeEfDw0A6R8rO66fQ+GJ2LicEsXsQqUCyUlcVWx0z+infHAAEMiH+g6+CrEg744=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fx/DlMs/; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBIcyrIJfHx7x6VJ2BbGFfKkVosIcGHsADsaoB+aOYkg8W4QZlyFYS+iE4UVYtZSngwj9yc5v315mojajbuHTg3Scuj3e5Tm1LBd2m8SDZLbjcaAtTnCC0un2L/gfjEUQwIceyH4S9AF2Br+BP9itxbyNyoKztppK1VclYPK2sjoTmx/HgXl3au5M6eGWd3Gxrl7iJbTo3KpJgZM63POGwIXR6AIOBkq2neKpDy8D78xuxy9pB+DHP2M+SsK960CDDYvVmOO+mbFt5Oh4FGeAfKvFuzPiiUBuj3LG16Ao2efX4qC3xM1lvkyawYqNNZfzjAMVUkK7IyqaqVLtEFhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwM2RMgHDT351PRZBHPbEQUzKB14UFx04pBk69+9Szc=;
 b=Y3as0WEhtKZA2EgITzS7g9b+ZN8iqRwW14acRiIkHLNDgIGbHPi4j0z8xfJmIs2FCrRuuDS330/fpGFaNirVICSRIpciS+aFvd8wV4H0Zlcc6JcPYgSJslfMH7Q8cRB0bxlC03+QRBjcJQQ1lYW72A7lDPTcn1w3A3KuuwlIuk7e5YfWaJcIB6F1RxN9R8G3IqAeUtphVvl0wmdbCYr1sArwD43BeVxmXYHt9GBlZeuHZM15iltKc5rsV1Q2NEMyUjDps27U+d1n8K5T9IAZX0j1BAERkXKUqK72hKQKZ0fKuPYfxI22oD19LoLEZodqRMDZZkNoaa1piRUsSpCkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwM2RMgHDT351PRZBHPbEQUzKB14UFx04pBk69+9Szc=;
 b=fx/DlMs/DzE54d8p9MUYf12hkt1Gg8YhTbH2SPgpY5VT+V/8iw4OwzWXjo6el4L4xLqQhSSQInHI578O8pT7vnU3DbXc56YwOh+iwhqV13KpjzNzbIt1tBEw0HS+kB+1ZSCeng83RWTR2/XRN2SWq0JXlcbhMdD72Wn0QKKUYD7aupFNpi3Qu/LvooEP6HbZRcYdNfx6MwhLAO7blmIeJmGsEnPRWEktEvZB5I6eCIgVSKnFZqZurSfXImZtiSy6rc4IUDE2EgmLjXj/OE04iKQpZuX25xHDGuvmSuTh90gkENrXAt+RS4G68o4COqpC5tTouQap5v9rDceuSLM93A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Wed, 14 Feb 2024 16:19:20 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 16:19:20 +0000
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
Subject: Re: [PATCH v4 6/7] mm: truncate: split huge page cache page to a
 non-zero order if possible.
Date: Wed, 14 Feb 2024 11:19:18 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <1C274CBB-C809-442E-9575-858460C0F62D@nvidia.com>
In-Reply-To: <cbb1d6a0-66dd-47d0-8733-f836fe050374@arm.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-7-zi.yan@sent.com>
 <cbb1d6a0-66dd-47d0-8733-f836fe050374@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_61BFBE49-0C64-490F-8FAA-24E0AA16EAC7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:2d::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 1814d39b-145a-4d71-9562-08dc2d78b32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PTfuRE3ooUYO7ayHQhVxBSAo8tsQZG1mJb7QSHgxMXwkxwL4Y/oTs1bFtkdKl5I9jZVMdvhXjexfh4pRxEQow4FKFTG1sTPssQmsCGpTOsKJeFyH+Fmr5xmHage8dIsMuwsik0caVWUfa4OC3NJF2x31P4dL6XHtuNLMgbzgSLXAkfFO0pviyM3DFdo+gfFMyAzjyfQhmMbauHT6p3rjCcNBclaTmAtwLXqfJpKAPBfjaVzVPaQmeyl6bzvOHB8mDoDYvVgmijTPPOEWdFziL/Ey5LYLZyem5ikqWyQ9NQXt5mfkzhvnpVlkf+/zH7+H35Mm3PbmnTSvtf7M9o28RFncfGRlWJGd4dWYDaBzxJBNs6agHlt4uocA1EKRF4oUTGbw+ivW9DReUT9SZ5CuvBfKJJXunW6+nz+15K/T0TR9XPw+Lyr0fxi+41t/L+7GemAaxZYARmjrJteXaCIprrkD/GBRNPYjXM+JH8yO7sNwpYzs3dtOecvDU4z0EugiXZHTBPq+BH3WC6dPCnRHamGa2tf0VGM081wBi2SSVnom+ZTvfP3qyn4IlXTq8YqkPzHnZ/fLkBY1nsli5nB5mf4Cw4QC7Bhtzy49coudDeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(966005)(6512007)(6486002)(478600001)(41300700001)(4326008)(7416002)(8676002)(8936002)(2906002)(5660300002)(235185007)(6506007)(66556008)(53546011)(316002)(66476007)(54906003)(66946007)(6916009)(83380400001)(2616005)(86362001)(26005)(38100700002)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uyH1KNfomN6kmPf030lTA1cnjrfuhcc1VP0xxoQKuLnt9Le24MACgzDs3fN0?=
 =?us-ascii?Q?QBPYZLUG5gY2f8YjngAf5avJaRJne0riOd5Xz65FWBp+kGxk3MUqZJy3iEkq?=
 =?us-ascii?Q?YChHbOjKe3j8u7hoTGjuRrmrLoUCGT85pr2UO7eXTZjg+gOLrgiX/HGfL5wE?=
 =?us-ascii?Q?kusHMIz5zVfC4xG6sTrNCxOsnYWFQqLTvM5vpJzxXEB1sL0RaYX9s9sGDb37?=
 =?us-ascii?Q?cOPsFCneCJsk8XbnM3vjGBsmUU1OpzXSAmej20wL1k/FSSQevhGREUYOpAdJ?=
 =?us-ascii?Q?5b+ZxqSvvsqDC6kl5DRpr6A8B1MBEIs/IljDMsRmSZ9v1XBbyug7HrkRxAoV?=
 =?us-ascii?Q?A3gjCbMUVTKWXAl8VGGOC/xgtRzvChcNcVrtRfFZSvT0bY8NVLuYFwJOdniC?=
 =?us-ascii?Q?httX6r3aigC0RL6wyklWmlzqjjpyv0Bf5iOy4JTv8q6mDqRgr5WTAZUDKb2/?=
 =?us-ascii?Q?NGwaFpupInxwweAmjUVV1pR2Rx3dkvgJHlqwS2ZilqGZ2MJRjab1mzMZWNGK?=
 =?us-ascii?Q?2K5ej49W4BGxLxH2ju38QnRdPOa+yR3Cw8KBtgX82m+gZ7IrfuVt3BA/VwEl?=
 =?us-ascii?Q?kx1tz1Esw4SGNG1QOAG519wIoc6OwK6bRF5uf3LLfvqfy55QxPRfpnzn8GZz?=
 =?us-ascii?Q?T0O3DygO0Km6EkQFod2JEkbQOehWJx28+MF6tV0KYRgUnA3LW9UPUVzOjAX7?=
 =?us-ascii?Q?8hBE5eymJENCPWEDZ4pBRBl2yD5BpAQ8AGU7gVOUX/uNtZs6kodXBTnWM8O/?=
 =?us-ascii?Q?4Zf1SFpzEIuqDvhiPidxavbpNK1V5QSCwdlxkRGT/L873/sx0z/eukCrr47c?=
 =?us-ascii?Q?UOkCY5FwHzMva0o+X8Uyeu+eWbcWh8P+AL/T3BAK0pIrnq7XXJSue0nM7p7H?=
 =?us-ascii?Q?cG2hQCWJetczBY+C6VY9l+ZLWxLJ5rAvEZNiMR14z0ega2VQFDBeEE89ucWN?=
 =?us-ascii?Q?xLeg6kGCXz/gWsYPJuxd8uc944LVw1BDQy67qxMdKdHibon9lV55Wm2TrGFm?=
 =?us-ascii?Q?4LHuL4vKLIvPZIYnWg88wqQITqCuGTJGETIbrwg2bYoVxWN7LZAzoJrxuiau?=
 =?us-ascii?Q?9hJKy04ivtliTkmFL5NfA31I95bmzjfkA5+GU+m34cmCIg8klNm049fHOZbi?=
 =?us-ascii?Q?c1na16nTmXw7SY5ChS6tvxkyZYFkavmAwLzgpetolocstvhhRS/kx6NZCGjs?=
 =?us-ascii?Q?Xf3vhPd73/hC4IXZrtqfoApPXO4kw3XmcaacqCQmWFD/9b3JJweZIfCXNMgR?=
 =?us-ascii?Q?CvIWQmERNGdwwV6PobNog3XtU4bkujBNx9hDJHuhicHnCJ8QZffPc7Bep1N1?=
 =?us-ascii?Q?M6Ham7VtTAbHly0tadCR8jYtlmF511U6S+Ceq7DERrTztHM57DcaoUMjm8t8?=
 =?us-ascii?Q?EF8Nw15OPMI8Zsu3ExO/MjZprHVpQ8Az2gHGAYtBfWXqNfUv6o0XuUxLX1mL?=
 =?us-ascii?Q?Ho4w5CnzL1RxacKbXLSqGq26iBwgGmeSqhPdyOqdhbVL/DI/H414kOvEuI8o?=
 =?us-ascii?Q?u5D60RF1Ixz1rE8FpFo0wEL2H3hhq8rXDQzA0haBsu4z0DvaP3DLRjTvXgU1?=
 =?us-ascii?Q?7T2Ox0i3yykwv0Z/v760AHDr7kHoALMhWcjgdf5H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1814d39b-145a-4d71-9562-08dc2d78b32f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:19:20.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8A2nrujJxa3yPj1JH6uelMW45H4Rh75eRLWgfK+Va2wlKtz04ii8Pi/Y3bR5DlJA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181

--=_MailMate_61BFBE49-0C64-490F-8FAA-24E0AA16EAC7_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Feb 2024, at 5:43, Ryan Roberts wrote:

> On 13/02/2024 21:55, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To minimize the number of pages after a huge page truncation, we do no=
t
>> need to split it all the way down to order-0. The huge page has at mos=
t
>> three parts, the part before offset, the part to be truncated, the par=
t
>> remaining at the end. Find the greatest common divisor of them to
>> calculate the new page order from it, so we can split the huge
>> page to this order and keep the remaining pages as large and as few as=

>> possible.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/truncate.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/truncate.c b/mm/truncate.c
>> index 725b150e47ac..49ddbbf7a617 100644
>> --- a/mm/truncate.c
>> +++ b/mm/truncate.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/task_io_accounting_ops.h>
>>  #include <linux/shmem_fs.h>
>>  #include <linux/rmap.h>
>> +#include <linux/gcd.h>
>>  #include "internal.h"
>>
>>  /*
>> @@ -210,7 +211,8 @@ int truncate_inode_folio(struct address_space *map=
ping, struct folio *folio)
>>  bool truncate_inode_partial_folio(struct folio *folio, loff_t start, =
loff_t end)
>>  {
>>  	loff_t pos =3D folio_pos(folio);
>> -	unsigned int offset, length;
>> +	unsigned int offset, length, remaining;
>> +	unsigned int new_order =3D folio_order(folio);
>>
>>  	if (pos < start)
>>  		offset =3D start - pos;
>> @@ -221,6 +223,7 @@ bool truncate_inode_partial_folio(struct folio *fo=
lio, loff_t start, loff_t end)
>>  		length =3D length - offset;
>>  	else
>>  		length =3D end + 1 - pos - offset;
>> +	remaining =3D folio_size(folio) - offset - length;
>>
>>  	folio_wait_writeback(folio);
>>  	if (length =3D=3D folio_size(folio)) {
>> @@ -235,11 +238,25 @@ bool truncate_inode_partial_folio(struct folio *=
folio, loff_t start, loff_t end)
>>  	 */
>>  	folio_zero_range(folio, offset, length);
>>
>> +	/*
>> +	 * Use the greatest common divisor of offset, length, and remaining
>> +	 * as the smallest page size and compute the new order from it. So w=
e
>> +	 * can truncate a subpage as large as possible. Round up gcd to
>> +	 * PAGE_SIZE, otherwise ilog2 can give -1 when gcd/PAGE_SIZE is 0.
>> +	 */
>> +	new_order =3D ilog2(round_up(gcd(gcd(offset, length), remaining),
>> +				   PAGE_SIZE) / PAGE_SIZE);
>
> Given you have up to 2 regions remaining, isn't it possible that you wa=
nt a
> different order for both those regions (or even multiple orders within =
the same
> region)? I guess you just choose gcd for simplicity?

Right. You raise the same concern as Hugh[1]. I am minimizing the call of=

split_huge_page_to_list_to_order() and you and Hugh want to minimize the
number of folios after the split. Yours will give better outcome after sp=
lit,
but requires either multiple calls or a more sophisticated implementation=

of page split[2]. We probably can revisit this once splitting to any orde=
r
gets wider use.

>> +
>> +	/* order-1 THP not supported, downgrade to order-0 */
>> +	if (new_order =3D=3D 1)
>> +		new_order =3D 0;
>
> I guess this would need to change if supporting order-1 file folios?

Right.

>> +
>> +
>>  	if (folio_has_private(folio))
>>  		folio_invalidate(folio, offset, length);
>>  	if (!folio_test_large(folio))
>>  		return true;
>> -	if (split_folio(folio) =3D=3D 0)
>> +	if (split_huge_page_to_list_to_order(&folio->page, NULL, new_order) =
=3D=3D 0)
>
> I know you are discussing removing this patch, but since you created
> split_folio_to_order() wouldn't that be better here?

Sure. Will change the patch locally.

[1] https://lore.kernel.org/linux-mm/9dd96da-efa2-5123-20d4-4992136ef3ad@=
google.com/
[2] https://lore.kernel.org/linux-mm/0AC0520E-1BD2-497E-A7ED-05394400BFC9=
@nvidia.com/

--
Best Regards,
Yan, Zi

--=_MailMate_61BFBE49-0C64-490F-8FAA-24E0AA16EAC7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXM6AYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU+4YP/0kcuWm88beYa88Ri/oQZ/05vk4uQRaM0NCX
tIt4f7LWzye/ZfDK1/rjK2C8eT8Q4eDhP6dVJ1JccPZfg78RsAkwt/3Av72U/ShY
meVf0zgMEjL39TZgA87DTt9tk3SW815Om+eHiu5GvfM+9hQULsuL9kBcVvfms84z
N7mnhBUG8n0v9zAiNBMucG1oJDtLhC2rRWd0u7D+WcQheYIeY5t3rBKwAuTZUvlt
mN3vC/pawbs630LPb+fieixGno9KFi6vFhYhexQPSIc2iyh4xzC1VubiIB627ZYP
XJJrgdIFKyNoMdMIMBstn5bWL5Iy3Erj6tj3QZWyCbWa/ELWNWLgXyjG8JYiJtRY
Bpq08LsbI8EsN9yc6608Hdf0aP0bsiIx7PJJHgGDE69XvvUW7jXthAF3Hrxn/REo
ZBFAvcJP6STN2BJcUFTKvAeW3mAtJU50O/xcjKb7L5tF9oBZOVMzk0Dn6zVgeKHi
BBSuAMyv/tfy24OIRVdcXU/zLWPQWsshSDd9boAPfawE5iRKleFjWdTMj1NXFh3u
yqQvN5HzHbkXXW7klQDKo3cOvw/g7NVyoDCRx8q9wFxnrVG39Le7Lj7iIic8eGaE
bgByG+IfE40F6R9uqmPJrnXXxJVGXU50VgqVfbejnENQ7lfFA5kLUDloZ8st9iKt
0vwuFykP
=pOsi
-----END PGP SIGNATURE-----

--=_MailMate_61BFBE49-0C64-490F-8FAA-24E0AA16EAC7_=--

