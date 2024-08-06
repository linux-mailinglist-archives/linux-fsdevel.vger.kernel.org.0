Return-Path: <linux-fsdevel+bounces-25122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C899494A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F7C1F2301F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE202AE90;
	Tue,  6 Aug 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cF4cOo5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457432A1D3;
	Tue,  6 Aug 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958594; cv=fail; b=t2KwkzUExa6tiFeAhcnAQfD06ZHdftxN/fml5PbZQUUFiaaH5Cbf8QsMm69Wwi3N0FLZ1LLEJEZvmQ3qnv/ec+ImhI9uKj9i8VzalB0HutliFQ6TmNWZRYfWe0D1Nko6K/1Ntc6j3WSYyiswJhmBybUzseTYC6kAXO6BVkzA7Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958594; c=relaxed/simple;
	bh=Y6jPE2mio+IIoSnB49rhjnyaSxUKUHu7KJjIidK8b8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=byvClWHJPL0J/gMDdRmwlhxyoyRjVDQ9G0AwGbWGk1om2ivvqFgBpDLa9YSQknvYAMtQYURP0MYGByewX0aFp+YHCelHVHCVSKrVSicY66D2V+cJwWr1LlK3598CKO92a1kBr92hrxJIQTj7Ym+dQFhEilenEmyu3rhsCWimSlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cF4cOo5y; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKT/HA/L0x63cxQh08FBCIMTmUxv2vlyspo1CCLtaVwBxZITuQUH+21TC13nFPy9D98gM35dxW7yNfFM0Lm5aVc3hFLFnP/V2c99Y/tpVNxcMvlY8jv2fcm4w++RG9bCcgcvlUpNfqHkD/etmW6jI1zs5DbICS1t3CNgL9ZKPDrhvykwyz/WlSFmRGYBjOcnoY4FQAmWQEFiGcNwriCFZ5P+mEQigOyf482nK9qDf+94XjFf7Zr+JEg9Wphy4+ye10nwBjcxKGDLLUUdG6FHHeJ6bLhWqC2A54luXj4+5pP3qLG8YsYzbZUVBOzwwP1/cIM0mRz46w+eE+fzEyAE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaggBkzvqEUG6f5QmAG+k40yvYDVETYmcKkiKcF/C6s=;
 b=a1YjgWUvwYTPX1EgN+RuaR0WdmV4HiklWSfL4afVRxEQZ9oIreRFIX6+5NKXK/Q26obQxcfuYz7kjdNf4GwjQK5DY71ub+Zl0RuNXLd9rl2k8FdK5JRoHzfLfUY3+Q1XkBQLkxueidnKBikZmh2lQOz6+NVQW3BQgvs69UDQRQGN80haV2asJREdjM9kXohx47+lsCs342sHopPtID72GOcIeM84nhru550WRh+OVt5i4wdjAsClJlZK8XQxAAV3tNC7fIFK63YO4p68ujCaQo+Zd3iwXVm5l4LzozMWJXqiqugYlxpDSwbYtInNOz0+iJfPwKC9trQmaBFLb6hlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaggBkzvqEUG6f5QmAG+k40yvYDVETYmcKkiKcF/C6s=;
 b=cF4cOo5yzutmG8tXNbDzfxmSnk5MqZ3QsmXwzcgga5CLdhGdKOoR+JCyEMQtZUvkeUU8i7AmS1NadtkE1UljzQN8yc6Vu5EbQp9yO3RosrGxbhf0IxzjjD/3p8llAywlwvEUFenZV5W0jryKyDVrtWBFOdASoj7w2ftdhH6fHLsvY5aaS5l+ZQyU63dZOCwcEshuPks/ctqMbJlAY7JdMuB8ulcVj6psV2T+dJSq2tQaqHewX5VB8XMPQZnAmY2vS8vlZwdY1n+DvV1FOMufMdPO3hKu16mBPhNCjXqbkOXV7vRtnZyZWxmhpcE/M4sekvv5qd8eGRWrzhLdORCMCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11; Tue, 6 Aug
 2024 15:36:24 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 15:36:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid()
 from follow_page() to folio_walk
Date: Tue, 06 Aug 2024 11:36:19 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <5BEF38E0-359C-4927-98EF-A0EE7DC81251@nvidia.com>
In-Reply-To: <c75d1c6c-8ea6-424f-853c-1ccda6c77ba2@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
 <20240802155524.517137-8-david@redhat.com>
 <e1d44e36-06e4-4d1c-8daf-315d149ea1b3@arm.com>
 <ac97ccdc-ee1e-4f07-8902-6360de80c2a0@redhat.com>
 <a5f059a0-32d6-453e-9d18-1f3bfec3a762@redhat.com>
 <c75d1c6c-8ea6-424f-853c-1ccda6c77ba2@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_EF315A2D-DFF5-497B-8D01-8B983751DA52_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::27) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 486c4399-9623-4481-efd0-08dcb62d8727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DJsD7utkoZH/49YeyGmKQy+UNtavMMBTZjH33BrJynayYx+zl4//EVWuEhLJ?=
 =?us-ascii?Q?B1mp8DDfqBCb3Wo1ejqS41dDdRAkdo38YXHnhXqkObK67vOFQxwG3Y5mhdEj?=
 =?us-ascii?Q?1ZSvDwnWCpTutUHekKa1bRBXqlCzBJkBPpPYalgnSv5VWfHKfGVEoXyTlEuU?=
 =?us-ascii?Q?EyDgp1Az369R+IjujKFlQ/DWmPY35vlHvOn70KJSeZOvDZXG33DNBeC0Lsz7?=
 =?us-ascii?Q?XR1NlRG+UPyLq+F5tv8mCIrZWhqtod3/ZP/ypMwKk50QIBPmEw4wxLYCv1m7?=
 =?us-ascii?Q?qZViGoAYHz1gDjYl+AOs0NafEzwRQDdvLxQIT3oqnYACNmZKqWgormxIWb9/?=
 =?us-ascii?Q?VyYEoX6bNw8d0tlVQRahFyhQ6bKqDJWJ5cQrvVu9ohMcD/CsTTFRomsM07+Y?=
 =?us-ascii?Q?+wsj2tlP7KmZUMSjIMhL8UISNnzaZzOFLPpe/NUOwlfnu6TIE+NMgiJ38kdG?=
 =?us-ascii?Q?wyZYqOJ7cm+u4ksnJ2Z2gAlVc/s6THvDOdNC8cU2RpjlsCAAlc3SyB0aufgF?=
 =?us-ascii?Q?aBns+SLGYVcaWzX1bJeUsCIeU2AvL9W/sQsYwVlfxIs+arcp21hvYKiC6gRa?=
 =?us-ascii?Q?4D+AW/t4EEeP3W8jdLlGWh7vd1jF3sQpNnRoZtZ1SfgPzad42O65azWGAiVE?=
 =?us-ascii?Q?xbNH3gn1ybf3twyMGumBB8+7vtLMRaOLVnGeu1vOHrNmwMC+kEV4Koz+k2fb?=
 =?us-ascii?Q?QaQBL64AoprqTfp5VRDnVLfRRRTOE3vMBTkl27TwulojF5a3OPxJhlgs+N6i?=
 =?us-ascii?Q?0vW99pnOTOtPiEtYYEuqFtewGcWdxixUwzvSiuAscj5j02pD22IRjDapgprx?=
 =?us-ascii?Q?jHqCL4HYdi6uv+qS6ljAst0f8hXalRv+6UTTs7WQ2VcABdXqwJGf+kjlLtST?=
 =?us-ascii?Q?9V0bJ5n24VryEud0qbI/FI1b4RFTO9P0zwNawzaB//0IsMjcd/QjoVsBBtiM?=
 =?us-ascii?Q?qswlESK5OuQcDB9CZv3qCC65TwqJVkHeEbHv+KRuXe3+a0fXAkFULUlOEdqY?=
 =?us-ascii?Q?ekj40nRZFCkYEM1M0rd50IXgpL1olhMNrdiOTNnPeMqp3t4YPMiLZ+20AB5X?=
 =?us-ascii?Q?ee9BFM150OLwPwAtr8XxQAOnW/taZhJD8lZQOjvjBpzfcE0/INatn+qT3j6/?=
 =?us-ascii?Q?I7JUM4HrNswWnMjtQ/+GAbpvcE5fwzF1LN/PGFZSZ67WKafjL1dxkyGo44ZB?=
 =?us-ascii?Q?wScayULTG96CA4ck8N9vQzW3BRzCrh3POXSxsak8jNdDm6Wwa7gMgS//dlFF?=
 =?us-ascii?Q?FjUOU74nGnBzlCSDGDO0ls3BOEorJ+lZ7jDgJP+iP1zDijkior4ZdZeAMoNB?=
 =?us-ascii?Q?R3/AtT3S9UIQKE1IpprX4xer5x6nKasR5LNKIBgezRmNeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6OaOULjYERSDovg80JD1+tbkatvlkagVnE3UspRmSqLrTO+xA2ErfkDKyCjp?=
 =?us-ascii?Q?Whkuhvc/T6URvAO9juNYOhfLqO4s00sDDizII+YCtAUWdRv03TOSohvCQKOy?=
 =?us-ascii?Q?30+0Hdau6qZ1mU0Jj+FuRvM10C7asNQSyLkogvBLRJlLwlwpNwqG3F20Oo/t?=
 =?us-ascii?Q?Z9tWCm4R3NsKmNfgtDt6vWhIWB276zLS5Rj8dzFeULmVTuzQEkr4XL9p4s14?=
 =?us-ascii?Q?0rwpwV7n1vzYHTuqnNtLApCiMwQGIl7SuKGKqw+AWSE+muOKxjayczSb0KaM?=
 =?us-ascii?Q?2fFNdgwS2RAi0ajS9mdH/OKSs8w8AjJoKOg0A89tuNzHV0+SeEmiGEVKq8AJ?=
 =?us-ascii?Q?FPiILU+GwZi4gFdedIn75x+9xWA+c7zMnRzPmicVoayQlyWYnXt/5uGmPsgd?=
 =?us-ascii?Q?37CeKrhwYAvFggQ72ECarmoVjTBgGFhioQq72u3L+AO7B/e5m3C9bR5SNQGs?=
 =?us-ascii?Q?uQSYJYMq73M8lzPAOoOGsqG1EA1jds2ZeiBvU2SWRNUTapqCmtZJTTJqhLAO?=
 =?us-ascii?Q?kpg2G8wWWaQpHRkPLAG+A3rOQ6cfQLUu3qKPnHsm2AwbtQ2057pEIGuVYf7c?=
 =?us-ascii?Q?uxMQ8Cdk0vdYpkxveKViiVuXqDutDE2QVfoLLZCXQ8K4vANul+HaV2PKk0yn?=
 =?us-ascii?Q?QYj2jbDnymuF/gK8Htsz0Uq+71k67dmOGnW7pD15eflYnVKDkPpKTWmSQZLk?=
 =?us-ascii?Q?1C0UvIQ/pdXE2ZIKIRUljP/ZCGWVgrFrsNbIWNvGx7SZSmIzTixyeQGTLoRJ?=
 =?us-ascii?Q?UZ4r4wfVT5LjCWW/muhhhu7Y+iNtzpM+zg40iqXzJ8/b4l9KGtorvx/qE2Z8?=
 =?us-ascii?Q?Aivx15Wa8HE/QmCLm380ZRitlXcd1inj6esYwUV3X9PyOqUkQuIymqB7Nyzz?=
 =?us-ascii?Q?8zZP34FPR4iimf06U9WId+tusauRcvnJLSeWIAtAnO2jr67k0rHr1w64RzBG?=
 =?us-ascii?Q?eqd40tNMRc6Ir4km6taIdgKtww+XXlZfm+cnN1r3sWkww01bpSx+4T42+q+O?=
 =?us-ascii?Q?9jFw8QdjM4jLAokUZk8Eql1drKlz9ca8/O1+w+4OJfjjHDhHh3iNPdWGB3Pe?=
 =?us-ascii?Q?FTiXdr+zQfGuj5FtX6+st0YKnhd3PzXVVPn50//lIqdL/N6PKfFkJFMTSmG2?=
 =?us-ascii?Q?Gj1YkjOhJgqksM/kxRpzS0CCdl3j1lkIjwBjIr7FefuktWDVCdLbbHVRUskn?=
 =?us-ascii?Q?hgdfjbUzNEFHZxWx6AiveIO0JlA0N+bbGX9GOUTK21kB7qV4IYlF0dEd82x/?=
 =?us-ascii?Q?fLxr8RZIOu5aq/WLfT20tLJMejKbQ5By0X6V89QfH/0eB4sc8AayAWb43/ud?=
 =?us-ascii?Q?PJtW7zPh5DqTZ64AABhh3rKMMK6mdImBl1mX6wi24FwYTzaQUH8zeqY7phJD?=
 =?us-ascii?Q?vy4ndkCgvCk5ya9C56mNuSyIxwxf5ePbDYbXjCtyErACpG1PE68Kmp1CogCA?=
 =?us-ascii?Q?NJWYx0qHK99y5FvPlqqNpntkm8KJGVLFV1LOLdR7aDGPg0xV9JrBebft3Dkr?=
 =?us-ascii?Q?ynx7A7i80mdP4WZrEdQ2EYlUAaBr6kLMRMIPo5uR7341zL8wJgu/XX2H3gYF?=
 =?us-ascii?Q?8WgHBpHi73DHlOyBm1HeUOqnKfDvFdtl5+kt4R6Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486c4399-9623-4481-efd0-08dcb62d8727
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 15:36:23.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpR6QcpzJFJ3Ig5bOQRTyi503AUeVTJFaQ8vjv8Tb515M6k0TD6xV5yKkhQgVeye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297

--=_MailMate_EF315A2D-DFF5-497B-8D01-8B983751DA52_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 6 Aug 2024, at 6:24, David Hildenbrand wrote:

> On 06.08.24 12:03, David Hildenbrand wrote:
>> On 06.08.24 11:56, David Hildenbrand wrote:
>>> On 06.08.24 11:46, Ryan Roberts wrote:
>>>> On 02/08/2024 16:55, David Hildenbrand wrote:
>>>>> Let's remove yet another follow_page() user. Note that we have to d=
o the
>>>>> split without holding the PTL, after folio_walk_end(). We don't car=
e
>>>>> about losing the secretmem check in follow_page().
>>>>
>>>> Hi David,
>>>>
>>>> Our (arm64) CI is showing a regression in split_huge_page_test from =
mm selftests from next-20240805 onwards. Navigating around a couple of ot=
her lurking bugs, I was able to bisect to this change (which smells about=
 right).
>>>>
>>>> Newly failing test:
>>>>
>>>> # # ------------------------------
>>>> # # running ./split_huge_page_test
>>>> # # ------------------------------
>>>> # # TAP version 13
>>>> # # 1..12
>>>> # # Bail out! Still AnonHugePages not split
>>>> # # # Planned tests !=3D run tests (12 !=3D 0)
>>>> # # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>> # # [FAIL]
>>>> # not ok 52 split_huge_page_test # exit=3D1
>>>>
>>>> It's trying to split some pmd-mapped THPs then checking and finding =
that they are not split. The split is requested via /sys/kernel/debug/spl=
it_huge_pages, which I believe ends up in this function you are modifying=
 here. Although I'll admit that looking at the change, there is nothing o=
bviously wrong! Any ideas?
>>>
>>> Nothing jumps at me as well. Let me fire up the debugger :)
>>
>> Ah, very likely the can_split_folio() check expects a raised refcount
>> already.
>
> Indeed, the following does the trick! Thanks Ryan, I could have sworn
> I ran that selftest as well.
>
> TAP version 13
> 1..12
> ok 1 Split huge pages successful
> ok 2 Split PTE-mapped huge pages successful
> # Please enable pr_debug in split_huge_pages_in_file() for more info.
> # Please check dmesg for more information
> ok 3 File-backed THP split test done
>
> ...
>
>
> @Andrew, can you squash the following?
>
>
> From e5ea585de3e089ea89bf43d8447ff9fc9b371286 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 6 Aug 2024 12:08:17 +0200
> Subject: [PATCH] fixup: mm/huge_memory: convert split_huge_pages_pid() =
from
>  follow_page() to folio_walk
>
> We have to teach can_split_folio() that we are not holding an additiona=
l
> reference.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/huge_mm.h | 4 ++--
>  mm/huge_memory.c        | 8 ++++----
>  mm/vmscan.c             | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e25d9ebfdf89..ce44caa40eed 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -314,7 +314,7 @@ unsigned long thp_get_unmapped_area_vmflags(struct =
file *filp, unsigned long add
>  		unsigned long len, unsigned long pgoff, unsigned long flags,
>  		vm_flags_t vm_flags);
>  -bool can_split_folio(struct folio *folio, int *pextra_pins);
> +bool can_split_folio(struct folio *folio, int caller_pins, int *pextra=
_pins);
>  int split_huge_page_to_list_to_order(struct page *page, struct list_he=
ad *list,
>  		unsigned int new_order);
>  static inline int split_huge_page(struct page *page)
> @@ -470,7 +470,7 @@ thp_get_unmapped_area_vmflags(struct file *filp, un=
signed long addr,
>  }
>   static inline bool
> -can_split_folio(struct folio *folio, int *pextra_pins)
> +can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins=
)
>  {
>  	return false;
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 697fcf89f975..c40b0dcc205b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3021,7 +3021,7 @@ static void __split_huge_page(struct page *page, =
struct list_head *list,
>  }
>   /* Racy check whether the huge page can be split */
> -bool can_split_folio(struct folio *folio, int *pextra_pins)
> +bool can_split_folio(struct folio *folio, int caller_pins, int *pextra=
_pins)
>  {
>  	int extra_pins;
>  @@ -3033,7 +3033,7 @@ bool can_split_folio(struct folio *folio, int *p=
extra_pins)
>  		extra_pins =3D folio_nr_pages(folio);
>  	if (pextra_pins)
>  		*pextra_pins =3D extra_pins;
> -	return folio_mapcount(folio) =3D=3D folio_ref_count(folio) - extra_pi=
ns - 1;
> +	return folio_mapcount(folio) =3D=3D folio_ref_count(folio) - extra_pi=
ns - caller_pins;
>  }
>   /*
> @@ -3201,7 +3201,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
>  	 * Racy check if we can split the page, before unmap_folio() will
>  	 * split PMDs
>  	 */
> -	if (!can_split_folio(folio, &extra_pins)) {
> +	if (!can_split_folio(folio, 1, &extra_pins)) {
>  		ret =3D -EAGAIN;
>  		goto out_unlock;
>  	}
> @@ -3537,7 +3537,7 @@ static int split_huge_pages_pid(int pid, unsigned=
 long vaddr_start,
>  		 * can be split or not. So skip the check here.
>  		 */
>  		if (!folio_test_private(folio) &&
> -		    !can_split_folio(folio, NULL))
> +		    !can_split_folio(folio, 0, NULL))
>  			goto next;
>   		if (!folio_trylock(folio))

The diff below can skip a folio with private and extra pin(s) early inste=
ad
of trying to lock and split it then failing at can_split_folio() inside
split_huge_page_to_list_to_order().

Maybe worth applying on top of yours?


diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a218320a9233..ce992d54f1da 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3532,13 +3532,10 @@ static int split_huge_pages_pid(int pid, unsigned=
 long vaddr_start,
                        goto next;

                total++;
-               /*
-                * For folios with private, split_huge_page_to_list_to_or=
der()
-                * will try to drop it before split and then check if the=
 folio
-                * can be split or not. So skip the check here.
-                */
-               if (!folio_test_private(folio) &&
-                   !can_split_folio(folio, 0, NULL))
+
+               if (!can_split_folio(folio,
+                                    folio_test_private(folio) ? 1 : 0,
+                                    NULL))
                        goto next;

                if (!folio_trylock(folio))

Best Regards,
Yan, Zi

--=_MailMate_EF315A2D-DFF5-497B-8D01-8B983751DA52_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmayQvQPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKBBcQALAnYBO27/vspagzhg8KQNaFWeGtg1UHvSgK
c3HLGgbulN2oHz0hHyGFkvsNnCJYjjdul1R/JExzs8ZT9cZu7TmzKUyCL0iSNw4W
m2l+VrYLwRpzIL/wQlEydzC0cbcOSVo/OTygg0OpRJO7cjE4dLQOG6DOUYrRRCd0
88NWCLWWPJphpe4hKfUuM9VHBIfJMjKLYREv18AjHT8Z+BG0959UHrPN9lqDW47I
vKS6XgOTTDEvGwtcwyW7+C1X+WYnFfN6cf54AZLO/gx1o8lBDC0a6ly8Yf/wCFSz
w5nqISyrnJF+nKrJqiaqByvs0hx95qKhDJ+9yuJBfCa9JSdVTEsoCUnZoTO0wYob
QQYeshDSwizbm2nu0LByxCKTyztEzHPvZDHISoxlGvo8ZUs6wr9u0DM00nL1dNje
mm7GwzxBFT3DqeYHhuPLEJejaClM3oKUiFRSlXyRa96UDXjAC6BEOas8CRIXBB7f
8xsrnooTmHD5W6AXOmVxla4PYD1DnvUapyF8fh7Y9J5O4/3TgsAA82UqwG1MTABE
LV+39W4gfdZdZDZCDM9oesdwQy97ZOVekkBzGeOJNQQ5a9erO5lyYGuk8vxR4NPo
VbowakeTWTzFF/xV8KLWEcmh/QRE1/oVroo+aW87qd5P1VpjJEuPb3xgfwy/+ptS
P+edxUcs
=7h2r
-----END PGP SIGNATURE-----

--=_MailMate_EF315A2D-DFF5-497B-8D01-8B983751DA52_=--

