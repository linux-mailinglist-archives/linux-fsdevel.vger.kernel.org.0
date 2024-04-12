Return-Path: <linux-fsdevel+bounces-16768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7508A2532
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 06:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D7C1C216D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 04:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325BC14F;
	Fri, 12 Apr 2024 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bi5dC5PI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D8A41;
	Fri, 12 Apr 2024 04:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896568; cv=fail; b=gtNXj02WzHLGilQRimFII3twHgFKoCNwaNqy2FuggEuPHaQ7tvvADcxGdMfRoeV5haEr4SNN0BS/tavLL6Scybq5VKtwcAz7nP+JTAPgchlNRFFMnbcC13r6bDA9bFZe7XQav05ZF3g7JCH5t+K17o0VkZt3bmSZF4LoX798Ni0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896568; c=relaxed/simple;
	bh=SJhwciydB3QuQcZeNvB+efjoyyJBfqWsG8zjJfl0UgQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=fXutqNa57gwRXlkbsD4Th388FqJkhSJId2cjUqLJHetzARMsx6XXiRFlRmKI5t6eLDtoyuIfWN2VQNtqyc52QEKigRUfGjTy2heOHoSCVyD3UI6KhSkpJpiB/HnZp/KCGriaNCTwe+TiUbgApPMMQKKDaxZEgMvikJx0pUqG6yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bi5dC5PI; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtleGsfbPYLrLYUMqjVlyzxX+EdVV4dr+DW0EKczsx99KyNTDAfayZ6Y8wewuFRfddCNK250Y/wWes48Xo8wchKnLgWiFRaybd/WFV58m0atXAvT+arOasVz4ZANCdr9MZWBes3pe5IJideahrWfNZHHLBqaYugdY5kpaXxKB9xUrk8BeP6rkJlz5qnBFVf/PCCsgWqlJKyPzRO9YkovWJU+6zTeCvpar4rlLsbZ3xhT7Un+X1gEixftn+sYdm9fMTHxHhx+/x+8tUnfzHQ4M+cWRmEerTC0sR5b8d4LuhgSE/nUu1OEcuijGQ7SPExq+39WALwJ8QuMw3jbAWwtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZA9IS5VgrhZLszt9iMi7zedZar5ykx83c7gNboWD/0=;
 b=b0rl5p7gceFIlyMMTZWzJd2aTItmZH9oiaX5zGmPIEkoRjmIDOHTglD8cHABOspiKSkqbDul8W6SoupyghDj/epdkT32P1WoYKf4iTSLlpTeDf4A1d6wKbdIOj1FWYD1CeXaUGcDcXnHcJOWN1Ym0+YpQHnuoGwb6mxPoCXeEHjzX2+i9vWBiWLaqWEoiBCHvs8cg42etU0TDXLb+PKKcVBr+GYVnda8X343qz0Fb7/QO9Emz1tppwXhaFMT5hkDXrTnbpv6axetJFtVcCybVtxN5oKF0R8pk4MhbKX1oXZV+DCdMe42SxTTO0itaFCpKqJyntrBVyUC9/Kqx64IZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZA9IS5VgrhZLszt9iMi7zedZar5ykx83c7gNboWD/0=;
 b=bi5dC5PIWtxy/PIxWmc2nFaGk2Mi1l1m5CWOoWPleEgy0sT2wZG9Oq1E/TwDagz4ih7oQn25CuJqWk79d1u/KyMBsHDayibuJjIe1xfULxgUYBV1G2rvCGjBz7p4uhHOSEiaSSRTiW88IB5N2OdO+rdrePcNzUxUBd/noaDvKroPMAKQHKHJFwbdICrbwUpxBQ8XS1bzQ6+9GONB3OBZRruaLdzra1CQcjRLrPusC43Q8Ife6A6lhfYXQUC37VIDuLR6QEum/Leg+thpSpcywiKhg8H3F3EF3SF9YQCsS4ELhjnE9CZ6sxI5PLRUMZqHWV+8NlpO2CBld1KXawoFaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 04:36:01 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 04:36:01 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <66181dd83f74e_15786294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, willy@infradead.org, jgg@nvidia.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
 hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 00/10] fs/dax: Fix FS DAX page reference counts
Date: Fri, 12 Apr 2024 13:54:24 +1000
In-reply-to: <66181dd83f74e_15786294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Message-ID: <87frvr5has.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY2PR01CA0045.ausprd01.prod.outlook.com
 (2603:10c6:1:15::33) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 022ea168-f5e4-47de-bb0b-08dc5aaa0e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L7uUD6eB0JOnEKP81h3KNzDmSY6R9dIAdriavS/CNjBI+4xK52nhgltTFJ/WiWHTqYupJcdvJFU1+ejY1HhDezUUAC2c/ed7Oinc8cI/t2pD27TmBm3qD7UzKRg/XoKsQKv/lVdsX3ofmwzG6+MqvVLwQkaixfE7cvLxRDmvkh+AX/3GonVCZzeL71bhLkfZdBXM+ROD8MqZPGhzD4lN/GZlhZ0CJwOI94D/CXQhGq+5m3fGDr58UkrU/g7FI0phVvlY4Xfup3868CeG6kxOYMAS2XhLsaJAQb4Dt9XnYlsh28wdjA3dyfB0exOgyk7aertYVrCSKZ2VjPaC+ap5KvVf+qkXZpGTPIIwGtXgZWwBVTpcVMw1MmWD/+sE+o1/X7NZpBxhu+xd22yE5wZeyaNbU9ADa5Zd20zCypOA4U/kt3cSQJFKUVjp24t/S95AUq+9FsXk56HtIRc9vO/iWcArQBEDwnYg1bdft+p66C7khCcOoPxsdcjZ6ZQ4hSTw7nY1h1dW2csBBBW02aDTUPxLBrY0sobE4C4FrYCWEPcq7EuVYq1kIJdiBKu8tEHRF+LBIxVMhKWi/ukQ4j1IZnIgmMnzWQVtl+wl8VK+x1Aiid+ZO4qUHVCpOqJE6kG9YpdNVI1KkHTQNTyVthG2gLJtrIMrcoS8DLihXtu7v5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE43RWhLejRRa0dENmoyNVdBcFI5NFh3ajVXS2FNb1N2VG01MnVYYkg2Z0dj?=
 =?utf-8?B?Qm5JQVBSNjFvbWRDUXQwajY1VWhEd29jeGsxOUNYaU1oWWx4RmlHRk9ia3Zx?=
 =?utf-8?B?ZFROTkloRnJ4dFRaNmRMcXFTNlFEN1dEN3lmL0N3R0tRUkQwTVozMjZEeEg1?=
 =?utf-8?B?ZTMzdWZWQVN1Y01WVGRxWHQ2M1FWM2VWTWFRUVZNMUVIY3dsQTc3WVgvaEJv?=
 =?utf-8?B?dERHUEFaNWNtUG9VUll2NVJhc0tiNTk3NnVQNkdoV0ZsdGlMOFdJZmxzMldk?=
 =?utf-8?B?bk5wQ09SVmhHNk9zM0U1NTRQTzJTMGxJTUVOc0pyVGtTQ25HeUxmLzUvTjJi?=
 =?utf-8?B?aDZNbnVreERmZ3p2a3dNOTZMWW1rc2lnZUg5MHF6QjVuOGxoemE5cm1sYUFJ?=
 =?utf-8?B?b1Z0dHJjNHZJN2lIVWFQS0huZkJTYW5Yeng4Ti85OCtuRDNnS3Z1K1JqdTNE?=
 =?utf-8?B?aXpPRDJDQi8wQlNnbmU2NXNqM0g0dFk1cXBSQzNXY1hlb3lsSERXbW96N1dV?=
 =?utf-8?B?dXc4VlhtNGJ6alM2UFhaRU9xV2pVbDdaL3g1SVlPeUZNWmNkbnNDdEVET0Yw?=
 =?utf-8?B?d2dkNUhTMHZrbkZJd0plRkVUWWhVU0UzOU95NnBUVEhjVHdadFk4R2ZoRXdO?=
 =?utf-8?B?c1V0T0RxelNELytCd0ExZVJhNlU4VUNPZS9LMWJIMUo4S09KTjJyTlJZdGJG?=
 =?utf-8?B?ekFhNGlDTU9GYkZFMkFJeGFlREhVVU1pd29zc01XQStOblhnL0NsTWw0dzRi?=
 =?utf-8?B?VE9vQ2h6bG00TkY2M0FMd0tJZzltOU8rU2NldERFK2pQcGRyWWFJWWwyMlpH?=
 =?utf-8?B?WGVheHFSbWFEcVZSTjlaU1lMQkg4aU81Y21wODBEa3lrTlYzMjhLZ0diZnU5?=
 =?utf-8?B?ZWdPOU9rM2dMbkR1cjZDUGJSSmxwV3JvOHdqMW1tUGNuNkoxZ1dud1BnSWx6?=
 =?utf-8?B?M1pBVGRZbVE2dVVvbGd6YWVZVmxndjdaMXB5VjJ2R0loekJJcXoraEZ5NUEx?=
 =?utf-8?B?TFhUd0lyZnZWcjBUaEJqMWNCcnlYOGY3UThPYkVJUGdVUGM3VTNIYmFCTDZH?=
 =?utf-8?B?dy9QaEpMMWJqdk5EeVkweS9HdzhHVEdkV3BJYjR2SDJqVldrWVd2ZWJ6QUFS?=
 =?utf-8?B?MTdubzBnWjFpa0c3NTE5TXp5N0ticWZPU2JrWmdWazdtV2xxZ095Y01yNmRp?=
 =?utf-8?B?V05SbDc1TDAwTkNSVGNaUjE3SldrQ3pwM1FkRHoxNUdHU0RTVVhQRENUcmp4?=
 =?utf-8?B?TEVRU0pQRCsyWnlRdWU4aE1odmFQcWZucTZvVkZZVGhUK0xiVnU1ZmN2czFT?=
 =?utf-8?B?a1ZJRmYxRDlpZ1NYeWdUQnllOFhuc3ljWS9PSXNGNzIvY21IRTIxMENxUjJ3?=
 =?utf-8?B?ckxHRUJqZm5SQWVTSGNvYmpFbFdpT00wak5yc2VjQmM4eFFHVnFFeWZZZWtK?=
 =?utf-8?B?NmVoWmhDaXFrdThRN1Vac2R5Wm9yTmZ4bkhIMWpSVVR4eWRUbVVTekIxYlBE?=
 =?utf-8?B?cFZoS1lqQS9HTWtxa1BZWTRFZU85dFZIN2JFbjNXYklDTlBLdEZoS2pqRCtp?=
 =?utf-8?B?eGJCOHdMY3pvUVBJL2taYVhSQXNiTnk5bGs2eDQ2WmdkNlR2REtXdFU4cnZu?=
 =?utf-8?B?aGt1L2tUVEZ1ZHE5WVpkN3ExU2kxckdHVTZ1ekgzWjBRbi9lMUFhZ29HNXpQ?=
 =?utf-8?B?U2tyNGNJUHRuMVpodDRaUjBnYlpLU0p1WUMvNWdQY2dENGxkaTU0ZlU1TUUz?=
 =?utf-8?B?bVJCRFYrM25pSlRMbXVlUHluTDBkdzBJeCtJNEJpSnV1Slgxcy9TMjFOeTFv?=
 =?utf-8?B?aWFHUG1JQitHWDE5ODNxZXpTa0FLMzloaGVxU2x2RjB3dWJjQlRpYTNna0h3?=
 =?utf-8?B?TGVJM2hvNlF5dHRncVFIZUU2QUlPcEd3TW1xcWROaUtaSzRNSlVPWktDMFhE?=
 =?utf-8?B?S0ZZZUwvN0xRbEVseTBtOStMR20xbkNMRFBieDRFMjdnNC9FUVVKdVgyTWFm?=
 =?utf-8?B?aWVmdHZiSC9GVkRMeHA4akVKRFhyUUpvKy9kYnJsaVNaVXlrek9INEhLUURQ?=
 =?utf-8?B?NW1UQ3lLZnh2b01PRDFvWXZiV2JYZFFFd2U4MkRVTEQ5aS9HendPZkZSZ3pa?=
 =?utf-8?Q?dd/Gi/Vb7NnnlF4kfmnNfolWx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022ea168-f5e4-47de-bb0b-08dc5aaa0e44
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 04:36:01.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpxexkBbCn4bfTyEZu/XWIsVOZw1XRjDHz88lMTJP+tlurjwz7UzlAflarjjJmXvzuF6GFOw00JhSxbpvVJ20w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
>> FS DAX pages have always maintained their own page reference counts
>> without following the normal rules for page reference counting. In
>> particular pages are considered free when the refcount hits one rather
>> than zero and refcounts are not added when mapping the page.
>
>> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
>> mechanism for allowing GUP to hold references on the page (see
>> get_dev_pagemap). However there doesn't seem to be any reason why FS
>> DAX pages need their own reference counting scheme.
>
> This is fair. However, for anyone coming in fresh to this situation
> maybe some more "how we get here" history helps. That longer story is
> here:
>
> http://lore.kernel.org/all/166579181584.2236710.17813547487183983273.stgi=
t@dwillia2-xfh.jf.intel.com/

Good idea.

>> This RFC is an initial attempt at removing the special reference
>> counting and instead refcount FS DAX pages the same as normal pages.
>>=20
>> There are still a couple of rough edges - in particular I haven't
>> completely removed the devmap PTE bit references from arch specific
>> code and there is probably some more cleanup of dev_pagemap reference
>> counting that could be done, particular in mm/gup.c. I also haven't
>> yet compiled on anything other than x86_64.
>>=20
>> Before continuing further with this clean-up though I would appreciate
>> some feedback on the viability of this approach and any issues I may
>> have overlooked, as I am not intimately familiar with FS DAX code (or
>> for that matter the FS layer in general).
>>=20
>> I have of course run some basic testing which didn't reveal any
>> problems.
>
> FWIW I see the following with the ndctl/dax test-suite (double-checked
> that vanilla v6.6 passes). I will take a look at the patches, but in the
> meantime...

Hmmm...

> # meson test -C build --suite ndctl:dax
> ninja: no work to do.
> ninja: Entering directory `/root/git/ndctl/build'
> [1/70] Generating version.h with a custom command
>  1/13 ndctl:dax / daxdev-errors.sh          OK              14.46s
>  2/13 ndctl:dax / multi-dax.sh              OK               2.70s
>  3/13 ndctl:dax / sub-section.sh            OK               7.21s
>  4/13 ndctl:dax / dax-dev                   OK               0.08s
> [5/13] =F0=9F=8C=96 ndctl:dax / dax-ext4.sh                            0/=
600s

...thanks for pasting that output. Turns out I didn't have destructive
testing enabled during the build so hadn't noticed these tests were not
running. It would be nice if these were reported as skipped when not
enabled rather than hidden.

With that fixed I'm seeing a couple of kernel warnings (and I think I
know why), so it might be worth holding off looking at this too closely
until I've fixed these.

> ...that last test crashed with:
>
>  EXT4-fs (pmem0): mounted filesystem 2adea02a-a791-4714-be40-125afd16634b=
 r/w with ordered
> ota mode: none.
>  page:ffffea0005f00000 refcount:0 mapcount:0 mapping:ffff8882a8a6be10 ind=
ex:0x5800 pfn:0x1
>
>  head:ffffea0005f00000 order:9 entire_mapcount:0 nr_pages_mapped:0 pincou=
nt:0
>  aops:ext4_dax_aops ino:c dentry name:"image"
>  flags: 0x4ffff800004040(reserved|head|node=3D0|zone=3D4|lastcpupid=3D0x1=
ffff)
>  page_type: 0xffffffff()
>  raw: 004ffff800004040 ffff888202681520 0000000000000000 ffff8882a8a6be10
>  raw: 0000000000005800 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(fol=
io) + 127u <=3D 127
>
>  ------------[ cut here ]------------
>  kernel BUG at include/linux/mm.h:1419!
>  invalid opcode: 0000 [#1] PREEMPT SMP PTI
>  CPU: 0 PID: 1415 Comm: dax-pmd Tainted: G           OE    N 6.6.0+ #209
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3=
.fc38 05/24/2023
>  RIP: 0010:dax_insert_pfn_pmd+0x41c/0x430
>  Code: 89 c1 41 b8 01 00 00 00 48 89 ea 4c 89 e6 4c 89 f7 e8 18 8a c7 ff =
e9 e0 fc ff ff 48
> c b3 48 89 c7 e8 a4 53 f7 ff <0f> 0b e8 0d ba a8 00 48 8b 15 86 8a 62 01 =
e9 89 fc ff ff 90
>
>  RSP: 0000:ffffc90001d57b68 EFLAGS: 00010246
>  RAX: 000000000000005c RBX: ffffea0005f00000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffffffffb3749a15 RDI: 00000000ffffffff
>  RBP: ffff8882982c07e0 R08: 00000000ffffdfff R09: 0000000000000001
>  R10: 00000000ffffdfff R11: ffffffffb3a771c0 R12: 800000017c0008e7
>  R13: 8000000000000025 R14: ffff888202a395f8 R15: ffffea0005f00000
>  FS:  00007fdaa00e3d80(0000) GS:ffff888477000000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fda9f800000 CR3: 0000000296224000 CR4: 00000000000006f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? die+0x32/0x80
>   ? do_trap+0xd6/0x100
>   ? dax_insert_pfn_pmd+0x41c/0x430
>   ? dax_insert_pfn_pmd+0x41c/0x430
>   ? do_error_trap+0x81/0x110
>   ? dax_insert_pfn_pmd+0x41c/0x430
>   ? exc_invalid_op+0x4c/0x60
>   ? dax_insert_pfn_pmd+0x41c/0x430
>   ? asm_exc_invalid_op+0x16/0x20
>   ? dax_insert_pfn_pmd+0x41c/0x430
>   ? dax_insert_pfn_pmd+0x41c/0x430
>   dax_fault_iter+0x5d0/0x700
>   dax_iomap_pmd_fault+0x212/0x450
>   ext4_dax_huge_fault+0x1dc/0x470
>   __handle_mm_fault+0x808/0x13e0
>   handle_mm_fault+0x178/0x3e0
>   do_user_addr_fault+0x186/0x830
>   exc_page_fault+0x6f/0x1d0
>   asm_exc_page_fault+0x22/0x30
>  RIP: 0033:0x7fdaa072d009


