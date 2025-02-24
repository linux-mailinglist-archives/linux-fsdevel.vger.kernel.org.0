Return-Path: <linux-fsdevel+bounces-42534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B793A42EFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB49C3AEF37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38FA1DC997;
	Mon, 24 Feb 2025 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9eu0B6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3D1F5FA;
	Mon, 24 Feb 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432202; cv=fail; b=uz7E5MdapfN2WnYYIrN0WTGryy2/3e7b/PZgjxGZjR81py6noJIWLnT3WAcS6ZLV2eY7cKk79PBV7oqA9xeMCTqdeyOKkOdSzQ1P8iZbRZT2ejfQgDX5qWRBYfCTnleABZPT61l64TLrl4gOFMn0WkakdGl2pgJ963H5fmFWmd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432202; c=relaxed/simple;
	bh=T8Jwos1KEp6nca82UIXlz6b0zXggw4YkeyfsmeUpJAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDQ9uTd5FtajAB0auINU/bEkIRadNx8fwpUfU+kBLhaJ3N/Oow2Vq/CrnPfnn9ze1+FbywLWiVuuQAhx8NqLl8XPObm8ru2XmIyDa/ahDn5Xjs6LO5nA6UuixaX7ozxlYTmQBoUPGMONtAcApf8W6qJFQp6EsR34wY+sPHpn818=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9eu0B6n; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVet1Smf/fP0qwfCMT2urstPhk3WM5mcjumkkq/BkuuibrD7STfhIm1XtSekACMX1Fd+coDBXY+KMn+E76hsBl/5wyKU3AHi9v8ASJYRmt+2uZd64Bz5Az91hK1M9CL7KQHIKqEZOAY60rKTPcX/91RYylrLXTgVUezI9ajvDG46WO55ipI+/VE4UWxc0BC9kb7H5VeAQ7vUB0gQxeXVCFegUfDF8W5qinOsULGRV7DgHJRdrC4HeLg3pDNwp/R5F1ue7bSXOx/mDVz+R/EeJdilCuEFGjPrf+OTPoRdVYbz8v4kABIO07yYAv7M81B3KfUWen0Jx0njJBCFHVkUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bug8cDQ7ep0eULDmXuFD5tjgNFtvu+WaP1h6K1fjGv8=;
 b=cC4KnAywXlDJBzYENVStsD6PcwT23TFHCoROtHB8t8BogkZ52g5lNBL+qOIF6Xkz+oXz4ze1wIhzXaXMQj3ePB5CQHYatGqg0lJU1Zdp5oNpncLIEbqLh9eOKeiuWzsZxiTVKowkY9LnWnNvlmGcuNM0ZGvPBD4nsely0ajSTc8uGJvK/PAclSgwL5GnKOzHd3rLKxiv+gElSMAysDbe5UcOehRGpgjDu6Lwbwe5Vr9w/14w3xlv3cYz3T7HstZkvg30NO8Snfbuj2HP8zxNbxTlIvlks1t6KPa+SsUih3YntXptWmGs4ouZVEvEsuMOsOKJwzK1nycAaG3LDCbuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bug8cDQ7ep0eULDmXuFD5tjgNFtvu+WaP1h6K1fjGv8=;
 b=f9eu0B6n0w3UMj79uxAepE4bjNcRzZPJue11DN+557lSPSMY+XxnGxIbjJNF304WWuur1z+hidITosxT7TwZ05sHmnzCWX9jQLaE2XYAwxSUoDY3U8ZPLjf2UELATv//4pcNJ1RfsJf28eHmVxboe0Jp7LYYD8dbK/SxPDacSqzXAF2M4iuAV5FIS6wQsinoAaGzoMpZbl09ftkERKrMFrgYJu5bQhI11FcElkBXEiECXYq93/dRSBx11LEYFruZYImyOkMQlUSmiuYMHBAfatCWPO5XTGo+LRcAocNisp2ERUqst4cb5ObdNKgQ67h2zx6xEqtNcBOrfu86dy31tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 21:23:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 21:23:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 16/20] fs/proc/page: remove per-page mapcount
 dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon, 24 Feb 2025 16:23:14 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <30C2A030-7438-4298-87D8-287BED1EA473@nvidia.com>
In-Reply-To: <567b02b0-3e39-4e3c-ba41-1bc59217a421@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-17-david@redhat.com>
 <D80YSXJPTL7M.2GZLUFXVP2ZCC@nvidia.com>
 <8a5e94a2-8cd7-45f5-a2be-525242c0cd16@redhat.com>
 <9010E213-9FC5-4900-B971-D032CB879F2E@nvidia.com>
 <567b02b0-3e39-4e3c-ba41-1bc59217a421@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:208:23b::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 96df20c6-f2b9-463b-fb59-08dd55197420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KC/5vZGFIibSGxYZKLc5veAA9v/QbAkAsTCeYRYpvYtJOMJBciF068ODB38/?=
 =?us-ascii?Q?8V7Jj4NYvtfd/SFVoJ8VrC9nuJu0cN0Kh4SyWGCuJhzg86iCnpsfkMwuzhDr?=
 =?us-ascii?Q?sWA1JzlkL6HDL0xImUsrTH1+tcNgTB1XfX2gAc1gjh2x2RHQ4YPCa0jtR89x?=
 =?us-ascii?Q?KTHihQ3B383v/bJAl3/Pqk57V+M8ZCJh5OXIuUWZit9kvIISSYwRN4iqmBNL?=
 =?us-ascii?Q?+ZAfkkEfeZqNJzOMF0hZb5sCz3JVRtyiFtmRJoiMXmnjt74pSENLxym/lmo8?=
 =?us-ascii?Q?cKxavKqKA1I4UY+KLN7pIhfzH+iTGu9QySrObBH4ZBZIjl4L7xK63cM5w3aG?=
 =?us-ascii?Q?8CpTykg6hH/sQVu2L0Oeasfc09hYXOpMHH/OkwZVXlf7CrIYV1Y/004zhQU5?=
 =?us-ascii?Q?psLwjOmTPHrt12mlfAGmbQSMxjutRC8G9gUhXc6jf5Oxueqf1PmI1yrre2g+?=
 =?us-ascii?Q?gYlI1IHIm+6VjYZZzUjoGzq0/riV/0XSHsa4h3ULft2Se8esKrKRe0tjSWy6?=
 =?us-ascii?Q?E6IGLYyczbELf1OKH27plbePWX6tynUIXWqAhGymt6Mh9BjgLPvFpgm6k7Oy?=
 =?us-ascii?Q?+dBBxEe5MEHC3/yA7NxXvakN9htZJMxablwQgRMmSGdLAGQrzyHLLfWSn1kA?=
 =?us-ascii?Q?TcGH4w8Jd6QW58181IDTtHk/Y/NDvG2lK8AUcuAY8hGrDh27qQrCNytBRfGN?=
 =?us-ascii?Q?yjcUcGR2fkdQYlNVc3LBG2eK9Mm6VhH2HXmv2ghr+zS+TiqAML5Ck5srF0hm?=
 =?us-ascii?Q?UXYTflqAFJkE5Bz3hmJhs81bULXzOUUrgkA23ZVFnuyG2PUKwRVIH+GbdGRp?=
 =?us-ascii?Q?tY+jP3TzwwlYv17OFlJt5gY+wvl1LG9rVAJA81k2NPD0FU2zmd9uVzcAklgw?=
 =?us-ascii?Q?DW4ZOfcV7+aBiGHaTBkP4qUOEoOxUSAKLDihHEanWcPIFQrQd3kEqWzoOGOu?=
 =?us-ascii?Q?wfuqs+9oDS5yHs3dwJWLKb90PS8/It/9My4JBOQWbfGWgxMDlLEf5BnUljpD?=
 =?us-ascii?Q?AJjowTp6SpJKp70Jk/FvSdGiAHtQgcl6uBOFWDCEq0dTxkR6XgPdXE5qwK/+?=
 =?us-ascii?Q?k8PNbcu4e24eOXV/alLArsB0GWt58GxnVe3CJpjTwgJbrwQCEv8kEpQbiND2?=
 =?us-ascii?Q?/QhPGU7SDjKdjbpb8IDUvQKCr8hOFiBmEK6PdO3yLfHMMIH0vcKISHeZOcWU?=
 =?us-ascii?Q?Mfj0MjF4E2WcuF7bkFItXBTJ/tLX4wi04aXlJ7afoOOcS+BsMwkqQ1MUA+A4?=
 =?us-ascii?Q?VU5LFXlRD5J8wLF63J0tHGBOttWQQIvx/RfNjpXcs3u8gT/x6YSalQa50J9/?=
 =?us-ascii?Q?VEqHkDdQ1PlYYgga4y5AYL4i2bUDlu0SUolAA/Rr45HcSwecQ+iquiKZCoRV?=
 =?us-ascii?Q?BFp6G/Rp1HlDxrtamnN1eiy08/cT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgSbEeGyu58OcV/G5qx3Rwgu8RqiSQbFGWc5Co8h7PFDbqwqtquH7XCFRuYG?=
 =?us-ascii?Q?Tv5oCw/FXaZD5+So9ZOjY6WRTRVzf9oABVK3Ne6NFN8OMhw98g19707ZsUZb?=
 =?us-ascii?Q?eLO+uTjctOpAuVo/e7eupfmnxoUuVRcm/gXcntEj+zInIH0fzMBG7OOxPrQE?=
 =?us-ascii?Q?U/W9jhI0d7vA1/6nEd8vgNKGFxlit0imih4nXlewBBqbkPLJYivoCqhtUV8z?=
 =?us-ascii?Q?Z4xlb174bDIMLMNpZQlrVQYv2Efx6bZyG1myi/O16isax7SKrBL5xY/SnRSo?=
 =?us-ascii?Q?5eOQ3GE2X4ZkThV4kRl5yBRa/TmWKkVMasGdPvReYK0gDV+zzRbC76cbJJJ0?=
 =?us-ascii?Q?9Mx0hMkRjkRNEbn6SC5zXkGYhT6hRp7+6wQwF6m1vkIs74ymgueKyJN1XMSc?=
 =?us-ascii?Q?zR05WNjSOaqX7ka+Y4+LFRqYvGePVzWClEEthbkhofzzu2N2XK0QRCPinPKU?=
 =?us-ascii?Q?WOXwV637OG37qLvfyiJMCZpHGKbNIQ1RCPvupKYEUL2oy/Lvbw0sM+19JFel?=
 =?us-ascii?Q?uqUm3MnoCSDr70kvP0J8HTlqaL6akEkoR9R3dBqMGlo71KdF06glCaVJ/Bkq?=
 =?us-ascii?Q?bRJ+Y7Mg9uZWesWiWswGojRWoSHDkw09d/p2L5YlJm4n22oBip+wYu8QDput?=
 =?us-ascii?Q?mhQvucfObC9o9OBsEmNHlsjz3GKQQkLGQmP7np8uBCMTgYnSVqvhCtIyBI2I?=
 =?us-ascii?Q?hArkizaxL+n8KfmBDa5rvPPwRR19Vqs0YS1k5b7WMvLDnVXGvjF1YmSPbWB0?=
 =?us-ascii?Q?svh64WZdUOa/tyCX34r7NmTRYAh4+6CZvQXSA56pZNR57gkTLeFn9rUWwYsh?=
 =?us-ascii?Q?7IF75zw5EpuPAeCupns0f/F9+BB7NaePgZfIF7rEnMkTMUm/T1o7hltJVmSe?=
 =?us-ascii?Q?/KMBtDVPwZdvrFE++yoPZ98uIqJe36hJ07oRytEj59v7g5VaNPI31UlAux9w?=
 =?us-ascii?Q?CmYcqOOhWHSCAXfb+gKsG9h769Z7Dxzj7ZZWHQATETKUhq2nRse+lAwI6DeO?=
 =?us-ascii?Q?1EJjz5wSFDcFTwQUm5IahB5F/ymiSXal0hW9vNYlrL+3/kOU/Q/BzU0xWEtB?=
 =?us-ascii?Q?k9ubh6Bi86P0TiHXbFySOG3FA5yb9y9HHLWdO/EwR85ifEVrhihWnMilAXcs?=
 =?us-ascii?Q?KfXPPlXLpSw3f0bhlmJaXSEGzWV9fdqretnRnSHdr3RF4xKtK1sxjb7vZ8Z8?=
 =?us-ascii?Q?uxkv6fMbZsaJQo6xFJDGijW7i4peN/UbCwXd6s/MnT4JIlf3RpKAZHF5/lQN?=
 =?us-ascii?Q?HqCloCFx/FY18d52ioAU0H22ZE/NjuHFdhwNd7c67A3LX6xOI+WM4LE3ln0H?=
 =?us-ascii?Q?q/BqfWDq9U7UT10amoNySC4yEwTEIeGHEnYK0rNHcl863nHV/zmSk4lvXXVN?=
 =?us-ascii?Q?flA7dCcw6zihxQQCUZz1j/adgS5BTTaiZi9GgIBlTWrK0C69NsXtPjIumRRu?=
 =?us-ascii?Q?jDrp3hBu7/wDsKvEUC/Pzo8ldV+rXJa2fqmm8EuMr4Zub1Mu4lLV4DTRMzlq?=
 =?us-ascii?Q?B3SABJI1JoPXF/DjGY/45ZO3DC1Pr0FWqlxQpkaUbFyjJ6HnB5XLG5k5ZDtt?=
 =?us-ascii?Q?eheOLxUPbG/CfN3UHlaJ+6GmbGIndnXi13Hj6vXV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96df20c6-f2b9-463b-fb59-08dd55197420
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:23:16.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z87/DJuvwnaKud1+LUHoDHdaJZkxzLzaa9azKd85rlJ7I4cUwLhZCvDvkBDoWiFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354

On 24 Feb 2025, at 16:15, David Hildenbrand wrote:

> On 24.02.25 22:10, Zi Yan wrote:
>> On 24 Feb 2025, at 16:02, David Hildenbrand wrote:
>>
>>> On 24.02.25 21:40, Zi Yan wrote:
>>>> On Mon Feb 24, 2025 at 11:55 AM EST, David Hildenbrand wrote:
>>>>> Let's implement an alternative when per-page mapcounts in large fol=
ios
>>>>> are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>>>>
>>>>> For large folios, we'll return the per-page average mapcount within=
 the
>>>>> folio, except when the average is 0 but the folio is mapped: then w=
e
>>>>> return 1.
>>>>>
>>>>> For hugetlb folios and for large folios that are fully mapped
>>>>> into all address spaces, there is no change.
>>>>>
>>>>> As an alternative, we could simply return 0 for non-hugetlb large f=
olios,
>>>>> or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.
>>>>>
>>>>> But the information exposed by this interface can still be valuable=
, and
>>>>> frequently we deal with fully-mapped large folios where the average=

>>>>> corresponds to the actual page mapcount. So we'll leave it like thi=
s for
>>>>> now and document the new behavior.
>>>>>
>>>>> Note: this interface is likely not very relevant for performance. I=
f
>>>>> ever required, we could try doing a rather expensive rmap walk to c=
ollect
>>>>> precisely how often this folio page is mapped.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>    Documentation/admin-guide/mm/pagemap.rst |  7 +++++-
>>>>>    fs/proc/internal.h                       | 31 ++++++++++++++++++=
++++++
>>>>>    fs/proc/page.c                           | 19 ++++++++++++---
>>>>>    3 files changed, 53 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentati=
on/admin-guide/mm/pagemap.rst
>>>>> index caba0f52dd36c..49590306c61a0 100644
>>>>> --- a/Documentation/admin-guide/mm/pagemap.rst
>>>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>>>>> @@ -42,7 +42,12 @@ There are four components to pagemap:
>>>>>       skip over unmapped regions.
>>>>>      * ``/proc/kpagecount``.  This file contains a 64-bit count of =
the number of
>>>>> -   times each page is mapped, indexed by PFN.
>>>>> +   times each page is mapped, indexed by PFN. Some kernel configur=
ations do
>>>>> +   not track the precise number of times a page part of a larger a=
llocation
>>>>> +   (e.g., THP) is mapped. In these configurations, the average num=
ber of
>>>>> +   mappings per page in this larger allocation is returned instead=
=2E However,
>>>>> +   if any page of the large allocation is mapped, the returned val=
ue will
>>>>> +   be at least 1.
>>>>>     The page-types tool in the tools/mm directory can be used to qu=
ery the
>>>>>    number of times a page is mapped.
>>>>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>>>>> index 1695509370b88..16aa1fd260771 100644
>>>>> --- a/fs/proc/internal.h
>>>>> +++ b/fs/proc/internal.h
>>>>> @@ -174,6 +174,37 @@ static inline int folio_precise_page_mapcount(=
struct folio *folio,
>>>>>    	return mapcount;
>>>>>    }
>>>>>   +/**
>>>>> + * folio_average_page_mapcount() - Average number of mappings per =
page in this
>>>>> + *				   folio
>>>>> + * @folio: The folio.
>>>>> + *
>>>>> + * The average number of present user page table entries that refe=
rence each
>>>>> + * page in this folio as tracked via the RMAP: either referenced d=
irectly
>>>>> + * (PTE) or as part of a larger area that covers this page (e.g., =
PMD).
>>>>> + *
>>>>> + * Returns: The average number of mappings per page in this folio.=
 0 for
>>>>> + * folios that are not mapped to user space or are not tracked via=
 the RMAP
>>>>> + * (e.g., shared zeropage).
>>>>> + */
>>>>> +static inline int folio_average_page_mapcount(struct folio *folio)=

>>>>> +{
>>>>> +	int mapcount, entire_mapcount;
>>>>> +	unsigned int adjust;
>>>>> +
>>>>> +	if (!folio_test_large(folio))
>>>>> +		return atomic_read(&folio->_mapcount) + 1;
>>>>> +
>>>>> +	mapcount =3D folio_large_mapcount(folio);
>>>>> +	entire_mapcount =3D folio_entire_mapcount(folio);
>>>>> +	if (mapcount <=3D entire_mapcount)
>>>>> +		return entire_mapcount;
>>>>> +	mapcount -=3D entire_mapcount;
>>>>> +
>>>>> +	adjust =3D folio_large_nr_pages(folio) / 2;
>>>
>>> Thanks for the review!
>>>
>>>>
>>>> Is there any reason for choosing this adjust number? A comment might=
 be
>>>> helpful in case people want to change it later, either with some rea=
soning
>>>> or just saying it is chosen empirically.
>>>
>>> We're dividing by folio_large_nr_pages(folio) (shifting by folio_larg=
e_order(folio)), so this is not a magic number at all.
>>>
>>> So this should be "ordinary" rounding.
>>
>> I thought the rounding would be (mapcount + 511) / 512.
>
> Yes, that's "rounding up".
>
>> But
>> that means if one subpage is mapped, the average will be 1.
>> Your rounding means if at least half of the subpages is mapped,
>> the average will be 1. Others might think 1/3 is mapped,
>> the average will be 1. That is why I think adjust looks like
>> a magic number.
>
> I think all callers could tolerate (or benefit) from folio_average_page=
_mapcount() returning at least 1 in case any page is mapped.
>
> There was a reason why I decided to round to the nearest integer instea=
d.
>
> Let me think about this once more, I went back and forth a couple of ti=
mes on this.

Sure. Your current choice might be good enough for now. My intend of
adding a comment here is just to let people know the adjust can be
changed in the future. :)


Best Regards,
Yan, Zi

