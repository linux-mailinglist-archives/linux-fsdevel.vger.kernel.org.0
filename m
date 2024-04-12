Return-Path: <linux-fsdevel+bounces-16778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ADF8A2796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD37AB25D9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 07:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839550A6E;
	Fri, 12 Apr 2024 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LLBXWU+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9847A6A;
	Fri, 12 Apr 2024 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905388; cv=fail; b=oakC+y6Nxq1m0023gmQ9HalgrZPfWda63e2GZoc2P4qP4zO12pBOF0SiUEiEj+sh0E3ZhOJdBKeniV/2kdYzbLF2WRrtcgRQa9horj4igbIW06Fu+O5ZphpE/Br0p7YKjIOwQzGM5dxzVOdy9ygD2m/XF+NEqy8DIFYXGNSj+7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905388; c=relaxed/simple;
	bh=vrrOPxPnsD5MugYxTOl27CG5P5KN0cN+J0Omq6LaviY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=uKDImimyXu5ETlro2mxYbNsabIi4vu3YdrM/BjbSU8WcoKZdWDxtx353xYt18XjwskO+/YlFV3HR055sA7KbTc5KrcxgFxwsn6EH1RMqvx7fvaWqL6HdaSMyojuYb1TAfh8NKpdvBmT7UekT4wpAJbJ4ibneoh8MUkCJzcC2rr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LLBXWU+8; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfLZXjF3oGm+jv5LxFifQEgsbXsoV8KERCG349O0BzC8XnI//sFFy3kZVmpDX09WX9pKEE2PSmFkplXcpUi6qt/aGZvHmx7pZJRAYAiVt8kd0uO9rsgNIT8sPzIhHnpF5FeAMI98N3zTjmvOoLRoduIdON+CuggX5JaISoV69kPrDWBVHG9oNQKnyVRaATTmFkR7WqrwLLqBh4BAEooDEobrR2TvgRrEIIW+C7/qgfvaoxnwK0QcJdCrLDyW1kMTTnH+cMWFoRBgNVH8CXn2VAdQkcVaXhzuKpdfgR4vl10pPKEPLl36ZgE/iRHmrjr+rq7lfEz02uJ/DUZucR9NfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPdlyirbUElXOTD4vWRwifD/f73CKWirrEdF1g1xxF8=;
 b=ZtI51DbR3K7pt+ZlkVeB+g139igSeyp9s4585mDE0SI52zrqD3JEoCl4xIV2Q78v/S+TIEFyCPeGSsDjswT9pULFmsJmO40Ga/Smi1P7nd9fCy1S7vvHCKWuNuMzcInC+FaiEzKCbuSBdKiXTnfU/MdNX1o7hM1GtPhkK8Tlv1solAn53v66T9QwCJfZ34HLm3DCzhxA+sYsiauOlNXcnUfaZXB16HD0cBRzEmTqEDdCuwuqE3H0kdYc9ijOFya/z0dZGq6Q1ZmVX8aC9yXRgLH78HtG3RpPxAYBqSZsDCgB+vCIEwc0AhPnIWqGjwV5afQlFS/mMsuiTJMO5lzyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPdlyirbUElXOTD4vWRwifD/f73CKWirrEdF1g1xxF8=;
 b=LLBXWU+88KnL5Olhe+Qs1xan7N5s0NpnoIxIJsGH8JQ9PEPOhKSAfnNfHZ3l0xlK1KX0iDLv06LcgLJwL4sT0scXSxlvQJUWTIfqqak5CH4HWzfC/DO3AmhRh5TQOZAl5jXxG0It7dMrWb2l4BRIbH+6CuKd2FpVqBN0v8ogRnqLSMF3Q1KoYDsx5EYUOWjT1Mk36GXbmpF5RmR9yentlYsjuHUesEAzNfL3peYbPzr67Nj9l6gRx3EII1Tc/lemxdhLWeowGJGCO0u2qHgXK2/lIGIG3dNXhui5Qyw2GW7Exj2Dut5yU47M69QhkodorxR5lcagfgvS67eD5vxCFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Fri, 12 Apr 2024 07:02:59 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309%7]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 07:02:59 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <66181dd83f74e_15786294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87frvr5has.fsf@nvdebian.thelocal>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
 david@fromorbit.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
 willy@infradead.org, jgg@nvidia.com, linux-fsdevel@vger.kernel.org,
 jack@suse.cz, djwong@kernel.org, hch@lst.de, david@redhat.com,
 ruansy.fnst@fujitsu.com, nvdimm@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 00/10] fs/dax: Fix FS DAX page reference counts
Date: Fri, 12 Apr 2024 16:55:31 +1000
In-reply-to: <87frvr5has.fsf@nvdebian.thelocal>
Message-ID: <877ch35ahu.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY6PR01CA0064.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::15) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e460ca0-f880-427d-33b6-08dc5abe95a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ft9XzJ5ZJ2rRlUVlF475wSn43Fbu/PyNMlNgXBrCT0cbFFBhHKhSZHEJnAUJ3XHFl++wu/PUme/7xnz4TP6BMXzGL0ZA6K8YmXDgAeCl5G8CafO7FNV4PH9Tks9r/W1YXOpQbK5GDI5b5YTkkh4K7r9xQuLBKH8hMuA9+0oM5NQ0HQ6LzZM+8skyoyfbVX7+2PDAJfmtlRNV3BhHWUXV3s0vpnWwtc680/RC8E6ULQc0VWgrTA4bdIfpXk3vqD6VYE0O1iV1Q/dSkZ/FoWsOHb/XlBMJVndo/p2ezVmIMO7gA4lfoVLYGpDz5J45PFcWljVTVkxxS0zl615E58nD6SJMy2wDXSc/62GnMCaA7GKYWzcW05JT1YhOl2ezNX2T6EBIogvKNZlpK3NexzDaDZHIcOHHZlUlQW2ZNETFo4AdATM0MQ5cqJjVKxnWZ7FQkY3MG4pUvnI0U8ZZ8jiJNhBWe5CBAO9cx+fPqpFIoryjnU5voZ9L+B5EqNyqK2+aDcDuwLulgGcEpIN0da/vARBAAkqhlc39xcDwivhdgzPdKu4QsXjnnR/AeuQqsGl32fcrl6Q6LfoEvLcTCXuVYP9p+pkY2oVuOWiIbaB4b6k8sWmh3Og39/SI4OAWd3Ekht62298N82yEOCDQ9bLa1dmdilhcM5W3Jxpv/GMCo8M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHdBR0xjeks2QmMyRXN2UFd5ZzkySHJHV2NURXFOV3E1Z3Y3bDBSVFBpVDlU?=
 =?utf-8?B?bmJKVG5RaTU1S3N0d1pBQUJXYlBQK0RsSGRTR2NNaGlEd0tBQTdqUURTNEJQ?=
 =?utf-8?B?TElpYzJHaEwyeUdaeWxOWTkvaDJ3akgwakx2VnJFWUFhanR3RWQySUdrVVIv?=
 =?utf-8?B?T3UrUFd6WlRjQ1pnUlRYNVNmYU5Tc0ZJMjMrWmlXbENXdjN0ZjQwcE5IVnox?=
 =?utf-8?B?b3E3L1YyTFZtem1RQTNIWTVFaHhmeURHQWtXM3FlUndDbnlHSHlpbDBKOFZE?=
 =?utf-8?B?UEVZRlNHQWUyYVJzTTJYbDM0MithdUJCeStaTFhqek1HeXpmRE5BVlc0Ull4?=
 =?utf-8?B?eVBoOFEyMGphM3pNaUorbHkxaFE1bU45UDZmNHBGSk9QbW5aZkRGUDlCTWc2?=
 =?utf-8?B?RDllZUZYTHFncEZwYjFob3JKc1I5T2pNcnA4VmFFLzBBTUV1UlFaeUFkTFdP?=
 =?utf-8?B?cTlZbExWTFZrVzB3UnMwT1NLZnk4RDA4cEdWdHRtYjNlNW5qQ0pBdnpuVmN1?=
 =?utf-8?B?d21scUdKbWxNT1JYMkc0aFA4M1BmQWNHK2pnL0tlY3pVb2ozbVBvR3NXNjl1?=
 =?utf-8?B?UWx1blppVG1sS3FmYmt5aWZTbjBJQ2VHc2pxRldKYmp1UzhJdktxNDZYbEFD?=
 =?utf-8?B?bkZ1SGtNM0xNTGZYVUpHekdUWjhTOUwya2J4WnJySnEvOGcwQkJBOFRjNTdO?=
 =?utf-8?B?eHkybERJOUxCdzhHN2U0TlluTEF2bXJaY3lSUTdBUG92U24rTm1DQlBEdFdw?=
 =?utf-8?B?Y285UDVQMHFaQWV2U3psWUhOYy9SWVlnVkgzb2VuSnZuNzcrYVp3LzRPWUhV?=
 =?utf-8?B?S0lJMFRJc0FjYVVUUzYzcUl4dXVkZUpmY1Voc3BHa1ljaEhXY2F4ajZEeURl?=
 =?utf-8?B?QmVZTGpndUFuaXl6SVBBSFVrWkhMWUlaN3BBTy9Da3NQaVR1bWp5VmxDNHJ0?=
 =?utf-8?B?d1FibHh3TDBaRzlOWjlHcUh6bHhNSW1sa256Si9laHU0dzg5VkVIK04rL3JB?=
 =?utf-8?B?Z3czTUwrTUQyeFZOdXdmV0puYXVuV3QzOGdqd1g5V3JVSlZUeklIZ1RwV2xW?=
 =?utf-8?B?d1BWU20wUytabmR4QkRqUHJObkVJemJYbFJWbzVBR09hREs5Sy9iUnE4NjU5?=
 =?utf-8?B?clZyd2JCSmR6REJvVkpOU3h1dW4yck9EbTRWYUVRUkFrbVFVekJ6dnIwcDJz?=
 =?utf-8?B?VW1rdmNJazhWQk9ab1BKV1o0alpKVTFXdTFyUERNUGlWL0VmVWNCR1RGcE1C?=
 =?utf-8?B?RXJOclVlM21OcUovSWhaN2pxREtGY0JyMGpPeWpXWkQrMjQ1VG1XSEV0MkRB?=
 =?utf-8?B?dGxCdnpmRzR3bFdXdlEyWFYzdzVGYUdSRFNaQ1lsKzk1ZkMyaHlPUmQwOS9l?=
 =?utf-8?B?Si9NSUFUbkI3dnNtdno5Sm5CYXh1TTA0c3ZRSHAyWjBiQWkyUjE2eXBmSlhW?=
 =?utf-8?B?ZlJuOExhTmc1QW1WWVlQSTBCWTlWTjBlWUtoU0h4b3NlcFIva3ZXb2pEVSty?=
 =?utf-8?B?R1NSWW41QkJVVnZQRnlHTDA4SDdEVklZNDFvM0podE1XVW5GZDhFdHRKREZ2?=
 =?utf-8?B?bXVVZ0JHOTZnY2huYXBMaVMwZEFldlV1aFY3RkpDMUE1bUZiVURZZU44MXlE?=
 =?utf-8?B?Y3dCSUFTN0JKdzdQT0VuTElNalFQeE81cWhpVHRXYnpObnhkRi8vcWdYMG9S?=
 =?utf-8?B?MklFTGxXK2ZqRzZidVBDZEtqSFlpY1cwd2s0b0NJVERVSzd4OWZFeTVzcmtX?=
 =?utf-8?B?K3F5NmdjbXAweGovSkhZU1NmZWh5aVdlWkE5eWQyM2djUUU4NWNySzVaVlQz?=
 =?utf-8?B?bjI2Y0FIQU05dVNtT2RDY3hIeWk1N0lKQjB6ci9RTUszd1dEK3p0Snp0cFEw?=
 =?utf-8?B?Y3ZIc2dnTmt3RWNtVmh0TmUyOHFhWHg4NG0zZVdjYXJ0T2kxQW9UQ2pabVpP?=
 =?utf-8?B?MmNzV0tsckR2SURIRUVIMnc3VzUwTFZIZW05RWVDcWhGbDcwYjlVMEMyZXVy?=
 =?utf-8?B?V0diUFAxcWwwMC9vQXBZbnY3RmlKMEI4bnBsc2EvVUFYRktwT0gzK2luZ0Fm?=
 =?utf-8?B?Ym1LT3NFZmlGTmRFNWZicEpjMmFHQUh0cm9mVXovdThoa1lJMWh6OW5EQW5C?=
 =?utf-8?Q?BRrxtVxclUfPAJPS6gV7LejF1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e460ca0-f880-427d-33b6-08dc5abe95a8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 07:02:58.9117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2/65vmx2oXqtBMkUi01YCbuSolMN0aGFX8qpS0sqbneGtiFlvWS91NyZ8keY1BVveMkaVIQ2H+XHeTFMQ4mfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194


Alistair Popple <apopple@nvidia.com> writes:

> Dan Williams <dan.j.williams@intel.com> writes:
>
>> Alistair Popple wrote:
>>> FS DAX pages have always maintained their own page reference counts
>>> without following the normal rules for page reference counting. In
>>> particular pages are considered free when the refcount hits one rather
>>> than zero and refcounts are not added when mapping the page.
>>
>>> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
>>> mechanism for allowing GUP to hold references on the page (see
>>> get_dev_pagemap). However there doesn't seem to be any reason why FS
>>> DAX pages need their own reference counting scheme.
>>
>> This is fair. However, for anyone coming in fresh to this situation
>> maybe some more "how we get here" history helps. That longer story is
>> here:
>>
>> http://lore.kernel.org/all/166579181584.2236710.17813547487183983273.stg=
it@dwillia2-xfh.jf.intel.com/
>
> Good idea.
>
>>> This RFC is an initial attempt at removing the special reference
>>> counting and instead refcount FS DAX pages the same as normal pages.
>>>=20
>>> There are still a couple of rough edges - in particular I haven't
>>> completely removed the devmap PTE bit references from arch specific
>>> code and there is probably some more cleanup of dev_pagemap reference
>>> counting that could be done, particular in mm/gup.c. I also haven't
>>> yet compiled on anything other than x86_64.
>>>=20
>>> Before continuing further with this clean-up though I would appreciate
>>> some feedback on the viability of this approach and any issues I may
>>> have overlooked, as I am not intimately familiar with FS DAX code (or
>>> for that matter the FS layer in general).
>>>=20
>>> I have of course run some basic testing which didn't reveal any
>>> problems.
>>
>> FWIW I see the following with the ndctl/dax test-suite (double-checked
>> that vanilla v6.6 passes). I will take a look at the patches, but in the
>> meantime...
>
> Hmmm...
>
>> # meson test -C build --suite ndctl:dax
>> ninja: no work to do.
>> ninja: Entering directory `/root/git/ndctl/build'
>> [1/70] Generating version.h with a custom command
>>  1/13 ndctl:dax / daxdev-errors.sh          OK              14.46s
>>  2/13 ndctl:dax / multi-dax.sh              OK               2.70s
>>  3/13 ndctl:dax / sub-section.sh            OK               7.21s
>>  4/13 ndctl:dax / dax-dev                   OK               0.08s
>> [5/13] =F0=9F=8C=96 ndctl:dax / dax-ext4.sh                            0=
/600s
>
> ...thanks for pasting that output. Turns out I didn't have destructive
> testing enabled during the build so hadn't noticed these tests were not
> running. It would be nice if these were reported as skipped when not
> enabled rather than hidden.
>
> With that fixed I'm seeing a couple of kernel warnings (and I think I
> know why), so it might be worth holding off looking at this too closely
> until I've fixed these.

Ok, I think I found the dragons you were talking about earlier for
device-dax. I completely broke that because as you've already pointed
out pmd_trans_huge() won't filter out DAX pages. That's fine for FS DAX
(because the pages are essentially normal pages now anyway), but we
don't have a PMD equivalent of vm_normal_page() which leads to all sorts
of issues for DEVDAX.

So I will probably have to add something like that unless we only need
to support large (pmd/pud) mappings of DEVDAX pages on systems with
CONFIG_ARCH_HAS_PTE_SPECIAL in which case I guess we could just filter
based on pte_special().

>> ...that last test crashed with:
>>
>>  EXT4-fs (pmem0): mounted filesystem 2adea02a-a791-4714-be40-125afd16634=
b r/w with ordered
>> ota mode: none.
>>  page:ffffea0005f00000 refcount:0 mapcount:0 mapping:ffff8882a8a6be10 in=
dex:0x5800 pfn:0x1
>>
>>  head:ffffea0005f00000 order:9 entire_mapcount:0 nr_pages_mapped:0 pinco=
unt:0
>>  aops:ext4_dax_aops ino:c dentry name:"image"
>>  flags: 0x4ffff800004040(reserved|head|node=3D0|zone=3D4|lastcpupid=3D0x=
1ffff)
>>  page_type: 0xffffffff()
>>  raw: 004ffff800004040 ffff888202681520 0000000000000000 ffff8882a8a6be1=
0
>>  raw: 0000000000005800 0000000000000000 00000000ffffffff 000000000000000=
0
>>  page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(fo=
lio) + 127u <=3D 127
>>
>>  ------------[ cut here ]------------
>>  kernel BUG at include/linux/mm.h:1419!
>>  invalid opcode: 0000 [#1] PREEMPT SMP PTI
>>  CPU: 0 PID: 1415 Comm: dax-pmd Tainted: G           OE    N 6.6.0+ #209
>>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-=
3.fc38 05/24/2023
>>  RIP: 0010:dax_insert_pfn_pmd+0x41c/0x430
>>  Code: 89 c1 41 b8 01 00 00 00 48 89 ea 4c 89 e6 4c 89 f7 e8 18 8a c7 ff=
 e9 e0 fc ff ff 48
>> c b3 48 89 c7 e8 a4 53 f7 ff <0f> 0b e8 0d ba a8 00 48 8b 15 86 8a 62 01=
 e9 89 fc ff ff 90
>>
>>  RSP: 0000:ffffc90001d57b68 EFLAGS: 00010246
>>  RAX: 000000000000005c RBX: ffffea0005f00000 RCX: 0000000000000000
>>  RDX: 0000000000000000 RSI: ffffffffb3749a15 RDI: 00000000ffffffff
>>  RBP: ffff8882982c07e0 R08: 00000000ffffdfff R09: 0000000000000001
>>  R10: 00000000ffffdfff R11: ffffffffb3a771c0 R12: 800000017c0008e7
>>  R13: 8000000000000025 R14: ffff888202a395f8 R15: ffffea0005f00000
>>  FS:  00007fdaa00e3d80(0000) GS:ffff888477000000(0000) knlGS:00000000000=
00000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 00007fda9f800000 CR3: 0000000296224000 CR4: 00000000000006f0
>>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>  Call Trace:
>>   <TASK>
>>   ? die+0x32/0x80
>>   ? do_trap+0xd6/0x100
>>   ? dax_insert_pfn_pmd+0x41c/0x430
>>   ? dax_insert_pfn_pmd+0x41c/0x430
>>   ? do_error_trap+0x81/0x110
>>   ? dax_insert_pfn_pmd+0x41c/0x430
>>   ? exc_invalid_op+0x4c/0x60
>>   ? dax_insert_pfn_pmd+0x41c/0x430
>>   ? asm_exc_invalid_op+0x16/0x20
>>   ? dax_insert_pfn_pmd+0x41c/0x430
>>   ? dax_insert_pfn_pmd+0x41c/0x430
>>   dax_fault_iter+0x5d0/0x700
>>   dax_iomap_pmd_fault+0x212/0x450
>>   ext4_dax_huge_fault+0x1dc/0x470
>>   __handle_mm_fault+0x808/0x13e0
>>   handle_mm_fault+0x178/0x3e0
>>   do_user_addr_fault+0x186/0x830
>>   exc_page_fault+0x6f/0x1d0
>>   asm_exc_page_fault+0x22/0x30
>>  RIP: 0033:0x7fdaa072d009


