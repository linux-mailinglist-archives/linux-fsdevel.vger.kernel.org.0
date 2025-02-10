Return-Path: <linux-fsdevel+bounces-41350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C48A2E311
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD86A3A5954
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 04:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE6516F265;
	Mon, 10 Feb 2025 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gqg/+nrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12861581EE;
	Mon, 10 Feb 2025 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739161093; cv=fail; b=T2fwXyEWzrwCB+wLaU6Ec/re7+3J+P9Z3/rSd1J0Uu3kgjGccgdhOApjWI7fM4vshR9gy1mhz2qMQyg/UOa97ujRxMQDL79PV6JYSjHL9ZhvFS9aKcEXv8blA187a3wANWd1W6QgoiamFh55UlMqP/BupI5CP+6PB7KI6KmQNOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739161093; c=relaxed/simple;
	bh=nwquAUsRJkZdVkW5/oecBX397Nnh0FcQ/S3BWUBbvBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LMogA9GBCujKLle0VCfDEeb1bVJS67rZ8Vx90uL86RqfHYhG28uwAOH73NiNfHgZyoeEMBXXMSVCakefAppLgfu4ZjKXC9MWT8jBeir2An7FNByNqeMBE8wuw6EJfPg6Jwl3uyaRjSqlManKI0ksxPzafXcpwji6/g53dvlxoVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gqg/+nrq; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEHpRcYRhZ/+DqzCnM9AKUZX7xVRW1I4CQlwy/GcPblnXzGWIJ7GYIHMU41LhwT/U5H+H0SkkRqItSHveWLFZimWe+kJTBuD9ivf6BxlBKLlEbD9bndZo2VwcJ5g4rCrQcBi7U631g66ruOazTkmeBRkoPUgXBg4MG/4FGIwQbU0+xyg82JO3EsckpY4xuq1aF9kPNXfa0/sxtirtIRI7z5oN68AKX2ZeCugHgRCnh3fvA1+xuBHqUL/inKGthnAU1VltNMXc3MNz+Bd6aSRzS7g9sm54Vjf8LUZkuewcjK4ow0ThTGmpu0V4lBkHV8qw6VdmuRHfMDuDNJjR/4Wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwquAUsRJkZdVkW5/oecBX397Nnh0FcQ/S3BWUBbvBM=;
 b=tNV92s7OjhGQ4KwB8Dwwa6N22LVA+ZpghTtM+NIbUAwrKYFCg5LJUrmCptBxGT/rYgivHNhWNEB6RoyGjQMYZ33oinvBcaVnIAxdXRG1hlM1+0hJHAUjnrj58I/MvWaoJNFVXG2qr0ILLUtIyd41bB63pkkFpqWR8kO1UxjlE9HLRdkEtOD/5qZ3s7truh6PNPyu7+YTjWvtC6F68lG/EBNqKeg6STjCDWuOmI+46gkwN44vUWaPMqIYAryQBYK2SzNhvGJ0L4JthLGAKmXarj6S8Th4cd5TNrny89UGrzRLllyaAN9r1M3rO7e0tObn3CF3/tGELMKNs+6z6ko9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwquAUsRJkZdVkW5/oecBX397Nnh0FcQ/S3BWUBbvBM=;
 b=Gqg/+nrqqGa4w7AzUFR7JhzYMp/j6FD9cGC29N8Z3pVu3p795WJ41kxU1FoW8fU6Wsjt/cD6dXnxafbmuiEj2iO5ZwsOqeK5ad89zbVIbprVvTAQno/ytE7Z+EAYmpjU3PW1yHHmxFVrwpw6u6nxAqsjNsVaDehC3UUola/LyqXCXSGR61yMGOBs4o+dpZo/+fZpLh+n4u1Abw6xRucN4ljfzC0FpD9Umnv7y+9EjhxQr4GKUlX9Rih7/+wVO8JRfnQGDMDaUcbIfdz1ERwBWN1Pjh0VQU9IzT3XRUjPmgO0Dbtiw2WDjaRIRGnO4DCfpr9EhNAImxUnJSfDwlmE4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Mon, 10 Feb
 2025 04:18:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 04:18:05 +0000
From: Zi Yan <ziy@nvidia.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>,
 "Darrick J . Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>
Subject: Re: xfs/folio splat with v6.14-rc1
Date: Sun, 09 Feb 2025 23:18:03 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <AD32F66E-777A-43D4-8DFB-F2D5402AD3F4@nvidia.com>
In-Reply-To: <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
 <Z6aGaYkeoveytgo_@casper.infradead.org>
 <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
 <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0396.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: d10e5fb5-756b-4c26-f55e-08dd4989eaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YE/yLxhVvCXGplEPa/OJSb3lTynnspX+yjnH9NiKxz4sip11ij/q29qjIQ4q?=
 =?us-ascii?Q?I8gS9ZWrpXc7vUoWsPkoOUuX+hbFDBHcqM4nPGmBRSQ+FY10Dt0s1r7Ocugs?=
 =?us-ascii?Q?qvbadaosySvRwZbdJqzqiBhQMZ6Oj/Q/gMjw5WB79xfaoMhgDgWdLdqztFxt?=
 =?us-ascii?Q?tGbuNmEn2EUL3FtoMcF3PK1ZsZMyPOUKVgMrlbB48JUyXcJVGmBAh/XTEQAY?=
 =?us-ascii?Q?osr3yw8gMUkrxhjSOjQQaFMlDMumEjtqs35/uGL5oWpJmXvTLXqd5Ylh3cyJ?=
 =?us-ascii?Q?BXqWVTRvww8wxCdCaOMU1RcVs6rjJ1cAhncPMemFp0lS1oJxmFWIfgSmvUlD?=
 =?us-ascii?Q?eBOv3hxmJHTd9tj9TbiKltUyELwIgTUNJSyaAZ/e0Hd7HUq3xzfRTRuW8Xgb?=
 =?us-ascii?Q?ZHPl9Bun48A33b4xjHiQUFpUum+nFYTyf0ESAQIi5c2B8IuA2J3ZdoHZlQJO?=
 =?us-ascii?Q?+2+BSMGTdA/bUFEMetLqyT8wcIdGevGzkfCb3VRXpb/omSA/XArcaXg/yijV?=
 =?us-ascii?Q?kaIWiddKNQP8MjjAohef2Gz41Yom1Aut8IhAR3B/bmOg8UEbHTGSAgRBfLfv?=
 =?us-ascii?Q?DbHs9J9xQwVg60hTXSyiqxyg8mDe1a7hQQe2oMSPVQ7bmFZNFZkCwhuQ/w6m?=
 =?us-ascii?Q?rQ0rd2A1x1f7gyN3HJXGmMUkKnIs0cISEusZvzXJ7Bq+N99tag66eGiSujVO?=
 =?us-ascii?Q?GRMxKx1E3ZgejS2GNdh4+wp1YU5UZw2cDToMGE1NqBmMqUKBkusXgC11pF7t?=
 =?us-ascii?Q?UjDuN8ejIiHHsghmESEsbuaLRyQtfU7ix3FESyClrsIkM5DlLGblrzmAs8oz?=
 =?us-ascii?Q?XHrF0eXiP2ocqLpfi3WMEzg+oqFt1iIR4YCwqyjnspwlQsRY59yodopfoAob?=
 =?us-ascii?Q?82CvV9OT2NUKpYo7SA1QMAzzI+tSuEV5UVohGj8SZmWtDUnBMw/TUt3F2cKa?=
 =?us-ascii?Q?QYA+hS4hnG9sc1daRXmxXlX8ezLpZkh5qk/Yk05OqPwt47MiVpke7hsr8EV+?=
 =?us-ascii?Q?K/WMchmykRW/P0BuMTP2jOyvdV+WqXqqhJGeNIYOWeH5ckbZXiIpa//QQsfF?=
 =?us-ascii?Q?M11bi/XZ51+3yVBr1rgtIV1bhDt1Zz6YZoH9xinc7EDLLYcGWo1PYdJlVMjI?=
 =?us-ascii?Q?NnxbD0F1oDxtkgijcOkYxaTHvbjkkLP9hwQM4b3cRh+aEJCC0VInRBEbI0lK?=
 =?us-ascii?Q?V+2GiA+L/vIe3eu9OHIHWn5Jc4xbvnDQGlylMtPWKPSByxwdqfouXyfNHXOk?=
 =?us-ascii?Q?jkZo0QgkKO9tnUZxWD5e4zPEOBC/pvJNKTQ0N/ShPpzvvXtjrisXN0bwApIv?=
 =?us-ascii?Q?HMFZdXJAkMiwW/o7UQ8yjYUnui6Ih/qucnkJP4Rawz2uMjhvJi5o5Zl4EOK7?=
 =?us-ascii?Q?vsEz9Rxb0FUwzNhWUHvxE+hZdg1L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+fmMS4UTQkTTIMxeaer6F7Flx083cls8/ok1bn0CPtxhiFedmC9gyBwUc6/0?=
 =?us-ascii?Q?xTzQGvjy/kfg0Cq/E9FfkPoTjlCf9SMQJJPoiklF2z47Jzac8xdVdXwYSLel?=
 =?us-ascii?Q?aVN0QQ5aVQAHE35xE7hdGQ/GdAfQSWCpoITZtHXeiwbOvQmnf6+7JH8JDIp/?=
 =?us-ascii?Q?dmMwejQPzW2bPmt+UiKf7RMNFMJuWEOXiNVZKfPpAl33VWj2393anbiA0xD8?=
 =?us-ascii?Q?iJrTcPBbjdtjRsMYYtmdBrg6Qmfww7Qi8KAOkFVROOtx+50TS91f0yWctmxI?=
 =?us-ascii?Q?G3Nvn5dDnYxr4INWpPDnp3O2nbkshyPQARqrIzT5H/SYAFt60JBLrOedbhnx?=
 =?us-ascii?Q?iktmc2MWdtj+RibqsRCXSKOidN2uyCExTzTPM+hv3q4pNdghL33AGKFwOArL?=
 =?us-ascii?Q?utkbaioQWkbO6ikSGDBBaKFk5Q/kTVPJIu58c7XqExL1lcWg54APG53mpkbO?=
 =?us-ascii?Q?IrO7uYpiVYVIN3wBDVrBPzm8mA4cE9UfcBZie36RQRDq7kKX0w801tnC7KGK?=
 =?us-ascii?Q?hRI4Bdh7KWEwVGfxYfOgX0nCZisiTqgn9CbrIUdR8chThw+l70s4b9qAvYeI?=
 =?us-ascii?Q?oCYfCiRLfrSx2kqNLno3MzyKCjO2HQ1Idsz/s9kp73S1b5Kq2YFFG945+U8M?=
 =?us-ascii?Q?O7GcgzQWyIVZR0tRIxNsVIXKFJ1NnAVZO1VOw5aNOmYuO/hbqFN9KzyvKIr9?=
 =?us-ascii?Q?ugM8csP874/8SBDPFDA7q9t25fWML34dHF+14Kc9BrkbSJb1H+xWv6Hp0vi7?=
 =?us-ascii?Q?LNSDTKG7fOneY29Sm/tn8g+n8ByytVicM+kAcyrpKwRuJPCpHuxjowbm2nwn?=
 =?us-ascii?Q?XnpFNvyvAQVd1Z1MTQDSVyZ4fcPZC8huHtjkVgzgY3kZHoUEhteljfOnLpKq?=
 =?us-ascii?Q?ozoQunpnzIUdebZ7iAt5loeU5ajSQmxYNbVk+6UKVUoSFc2kd1XwNo1mJFr3?=
 =?us-ascii?Q?l4UlyJd6+q5ErFSlnISKJSPQdeJrM5d86K5zPff0N46yhk77z4WYYoLkBQlQ?=
 =?us-ascii?Q?5erSDCwMKmzdOk0OSiKh1cEnMq8LRnm2EE69ItcfkimVXwBpo/P20kxsr2+z?=
 =?us-ascii?Q?QimjBZCThy49m3ElLsZu0Jjo/k+gc38+45/jHLIfxnAo1Qgoj1G8P5Iarbun?=
 =?us-ascii?Q?b4GdHqdysbJtYpyGY1fcsh5pgAs9h6HpCN8xW6W/r6WtNZLEHJO2PamLooFN?=
 =?us-ascii?Q?oSIzdSFzTGJ2HDhXjBnQ6T4S38px97D2Qz5qJSwM465i63Fn0LZrhvlwOYv1?=
 =?us-ascii?Q?Ha3VSyw3JS3wrTqCELGWS7mHjzbO5kAoL/QuBnkILRL3czvvClW7C4tlqq48?=
 =?us-ascii?Q?gNjTNJn9oYXXocOEIJb5cWU2BCKBqtfK7RyyX71tUENI9dkCKs71E5fir2Vl?=
 =?us-ascii?Q?MR/pR5/nJ1YrnV2pXqkMTD0QJ9RT02a1YvzS8qWKUZ1n9IEJlLyDo2Ahvg3I?=
 =?us-ascii?Q?uSJElx7IWrE0oswU6bstUPj6rOonOnykKx/Wb4ghayhsWv5MPDnwl5/8SKr9?=
 =?us-ascii?Q?+URNSTnR1+kowNyf5XoPtkK9KcjbIui3Cyp7TBVTC7eiV2PJnYso9Cf71tZD?=
 =?us-ascii?Q?mdPzABwmBp+m5AM2aEU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10e5fb5-756b-4c26-f55e-08dd4989eaae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 04:18:05.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRZckX7rA68SKKwA1gj2xP30WLkAQq2kMeETOvgN8ruGmFECIRXkn1ocjpuGsYbd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702

On 9 Feb 2025, at 23:02, Qi Zheng wrote:

> Hi Zi,
>
> On 2025/2/10 11:35, Zi Yan wrote:
>> On 7 Feb 2025, at 17:17, Matthew Wilcox wrote:
>>
>>> On Fri, Feb 07, 2025 at 04:29:36PM +0100, Christian Brauner wrote:
>>>> while true; do ./xfs.run.sh "generic/437"; done
>>>>
>>>> allows me to reproduce this fairly quickly.
>>>
>>> on holiday, back monday
>>
>> git bisect points to commit
>> 4817f70c25b6 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64").
>> Qi is cc'd.
>>
>> After deselect PT_RECLAIM on v6.14-rc1, the issue is gone.
>> At least, no splat after running for more than 300s,
>> whereas the splat is usually triggered after ~20s with
>> PT_RECLAIM set.
>
> The PT_RECLAIM mainly made the following two changes:
>
> 1) try to reclaim page table pages during madvise(MADV_DONTNEED)
> 2) Unconditionally select MMU_GATHER_RCU_TABLE_FREE
>
> Will ./xfs.run.sh "generic/437" perform the madvise(MADV_DONTNEED)?

Yes. See: https://github.com/kdave/xfstests/blob/master/src/t_mmap_cow_ra=
ce.c#L34

>
> Anyway, I will try to reproduce it locally and troubleshoot it.

You will need xfstests and run "while true; do sudo ./check "generic/437"=
; done".

The local.config for xfstests is at:
https://lore.kernel.org/linux-mm/20250207-anbot-bankfilialen-acce9d79a2c7=
@brauner/


--
Best Regards,
Yan, Zi

