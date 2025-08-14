Return-Path: <linux-fsdevel+bounces-57918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BA9B26BA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421681CE106B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198523D280;
	Thu, 14 Aug 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqU/zdZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBABF3A8F7;
	Thu, 14 Aug 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186786; cv=fail; b=kxCSkaq4VKm056SNHgEb/W7IQ5hA44Z5FJYJL/z79PmNG+Bfh2mwWiun2185wgfy7f+9FAamrusX0R8oIRsTjL5Vc6jlr0tcHbkGDYNVixgr+CkS50LRGs2tidb6X3MAkPwoKUKAcD4ZiBm4YcfXSIRpqwgRqGS9GNVEvDzsa48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186786; c=relaxed/simple;
	bh=0P/5nxRD9peTxLfJE8cYuVX0qvg5iUnB/62g65uogsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EchcL9Pvbif92wzyqAerjQNF2QAf5gfJMoNqOKcz5hPJLFGqYb1aULe7RWCW5R0WKgHkT8wXqDeS18B35jddTE8pJs4+3/X1baYSWR+VId5bmLcPUJPN5kOupojcz5qwO4IzGsKrVlZz1sZMCM+mRN28JYnpfhem9l5ow37ZMac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqU/zdZ6; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3aX6738YKDobH64on1HRNvVDKbCxYPbQdOYJaM82NMsOkpps+2JIcE4bSrAGHE3lnuXUgwmSQenOEayIGZbCOCCfeB6yCoLm86xdVbnV12RqGYeV807ynstd/4fl3cVARAzbdsOB//LLwWgNVe8hq9abrcUS1GVkjk0G2QUXsocf08HDS5JzjiamOp4CgczVJ3DGXSbNgFPrnwWAaXKP7MMR9gYLzh7sUbMI31CO1d5lrWKaKAJbJ8fdFDYuLZfDHkJbP72KDowRS7QAJg3QWlEySMfZm7aNPAhWtZ58qXNB1KeqnKjXgClyly12TOCsDofefQ37zWllJka+qKqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coye6i8oHaHQ2bdF3UW1jPG1mc3iee9wOtEN1DTXaw0=;
 b=FqaEBdh9WZiwiTaFmMUx2nhzWWinNajrFwaZ73c3Mb0mrEDhVQhhlT8mtayp9QfapN6JB1QYbSR7WT7bYAJa/Bd+zZ6Gpi8mDwD4r78jKUrPAyAQqZYzcwxSP0SPMDXJO+jLg/RI1e8LFSvGI4oRAb3yZwf2V+FpwxH2w03WgX5LX94rhM4u7F3SNmQUz9kPhV7rBP2SmR385pYH7U1TKcVE8JMoP2hn6tMotgeNVr0t+++FLsP/kK6zJG0Wy3Jyy4g1vUsYkI3ESMXlTXCzXKxUKtqfggcEuISjBhvfPzFuYsErHmqjfP/S6sx1IluRok3ukcmHSCI1HVOIIjgwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coye6i8oHaHQ2bdF3UW1jPG1mc3iee9wOtEN1DTXaw0=;
 b=uqU/zdZ6JQoHfayTmIuCivL21IUG6a7M5ybmplC2S1gzqjb3yN2Vxmjj4LHlKHzNfh5B1Tbvv80CsTVB+bi9wlWTmB6Djg2POpve1DWvKmAEJIROxo6LfikxUDU1Lv9fboa1eFxa3fnVDyN9mCHKQWmPDVxetQRIHJkIIB1SVv/2m5i/2q+t6Md0/g4mN+zM1KzD7HMorMIC7R3yAtACvqDHid1o1bJABMQXPXiYiLOAxGI3JgBj3xc4WK1XYJJvnJZaW2CMXixIT1IaiJT0duauY6JEvmw/WJBD5wCBxPedKhIgXoSoB/y3VYMlRupf98qf6fE9TA2nAcjFqIsQhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 15:53:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 15:53:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 5/7] selftest/mm: Extract sz2ord function into
 vm_util.h
Date: Thu, 14 Aug 2025 11:52:57 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <D3D3F7A5-A7CD-4D93-AB76-2200569AF98E@nvidia.com>
In-Reply-To: <20250813135642.1986480-6-usamaarif642@gmail.com>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-6-usamaarif642@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a9b36f-cfbf-4ab7-8061-08dddb4aa56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WiSM8WTHbMHCq76y4GA3q07LdsiJHBwm+lHRl760fCUixcJz1Otr11yrPeEw?=
 =?us-ascii?Q?3b5RGG5LT8cPZVZJ59B9LP7H7neIK0D/ly47G1P1iy4Hhb12h1wXLzFtkUrf?=
 =?us-ascii?Q?B4gFbsvNYyq6nRIvrYbSx77WnIJpWUY6vwMuDnk6pFxYClQdySw41ixaft5G?=
 =?us-ascii?Q?7ecaSbdkFK+8coEedO7gYcyCZnR4mubggfhYcvvj45n/6zy3ylidQP/uBhE3?=
 =?us-ascii?Q?3Z/JwjKnwveM6V2oJ5UN1NjN4YYhDs9xprdPDeKrDN0aRqazsnIBSwiWD/mC?=
 =?us-ascii?Q?sQ+oFmTXkGeEcj35Pm38Z2paYWLPUokKxuoiwkS5RejT517eNyRD+LcpU7CO?=
 =?us-ascii?Q?nqaMAVETsczf1DRvyeBMyycVSrjmtYQh6PVyYnOly9TAh60yKg+dupKTLwf2?=
 =?us-ascii?Q?eVRcM79oGawFIOBmndzwnNGuPVyaKfo7PeQKaM38VzAy0YitmrbnoFYhaI7l?=
 =?us-ascii?Q?5Tb2wBIFwUuHYn+MHvCPES+6XS1LobSqphgycGKy5b92ZtW6482k/siahlrm?=
 =?us-ascii?Q?o01rZd3MFpxAmWPwZ9pBRNlc/EZDQgYxwxAmbekqSIiZPqi1FFQRhdGaiS5p?=
 =?us-ascii?Q?mzChgNO16rq+RmQLsfzYaR2bnNmLGwl2i5aW2o1+drl5jG5PqeufD41dehF/?=
 =?us-ascii?Q?INHfWkhXIcQJvDf/wBzvv/HQ7brUcykZkZK3kbIt0BwmlfnfLM1pT5GCEf6H?=
 =?us-ascii?Q?eST8mDPwDXhQuSuffJ9R3ob9wupv0hHYfEN8ulxaO3M55rH1y2EYu1yRMVZr?=
 =?us-ascii?Q?VeZnO54PinXE8nMVAtzQlQ+GZbL0Qws2VQoikdWLiD15rwNq3ncEFSv7eao+?=
 =?us-ascii?Q?VrpouqNZJecQdpO4Sk+em/2+R5cMA08tg7Mt+8jbJ8/VU3DAqmPUPI/I0Bqn?=
 =?us-ascii?Q?s7PxzAL8gMRb1lwtMecLfDXbeLDcQC2dr9wuEc871AChzSPfE1+g++siMnho?=
 =?us-ascii?Q?xMiAf/mj5vT4VFxTmGk2bLyb3Y5bUMzenHu8gM8a3VM/VWWqn8cSVl/cK5Oy?=
 =?us-ascii?Q?F9vD6BQrcSsa5l9tbtBndK0179+rFpLQM+AIzlcNu1w0cMJHj2sU/zi66G3b?=
 =?us-ascii?Q?p76CAYYPmyrt0gje8Lcg7ijXrTmqXHpskk7Gw6PodePZBmZYgJ1FZW0JtHZk?=
 =?us-ascii?Q?OljogoBPyV+gy4MLw5zqmZkAuuvOLwPZYLqz0cRaO/kbWwsxhMGFPriCayg8?=
 =?us-ascii?Q?etaSjNqMyFHB0BMlD8a5soh66LxJ/eMR9PZzlPXPldJ+33A2zBETHiYu2sh9?=
 =?us-ascii?Q?+2rLZjWWu6XviclLDfvs+YjOv8dk1A/s+JuZa+XUA5b568mNykU3Nc5GbH0Y?=
 =?us-ascii?Q?aUO/+3MkDUSfFIJEmd6wq77xtovcCRUKzHucmxTyo7a+iOnDqfrPLJyvFeeN?=
 =?us-ascii?Q?p7HxErYLemN5uNIPZdc54RISuu9e/QEcQhBlegZRnYPzEcduRxkQHeVwQ/ze?=
 =?us-ascii?Q?i4hXg5Hd3uA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9d+p5/N7X4mZKgFDalwQRGEYBv5KiUdRqfJaRdXx2z0gUrHP9gwDKhAMYo9D?=
 =?us-ascii?Q?O6RL3I9HaS3Kd2CZoJmGjWBY79QjtFQScYwgdtLgNoSPzscbN8ocK5BpUj6a?=
 =?us-ascii?Q?naAe7QQWHUHZ8NixM2B+HDjZFuyvPwIEm3E/jcUkzfJN3a7MJZXL8o9nJchb?=
 =?us-ascii?Q?8Zl4eigj7Y4Hwdk+BE8YIz/M2z3uwTHapYSmu49k/mq/eDmS/mlpJJUEaOLu?=
 =?us-ascii?Q?YvEnJveuhFMRI8JtuZtOpVWzWvTOvWR7kn//Ds0T6LI0LJnZJgOAoo2Dj+mz?=
 =?us-ascii?Q?bN+vn66mT/2tginsN2GwdluVtCxxJfoaEBeCRTr2O47+ZnNLmjMt9tFQRNNT?=
 =?us-ascii?Q?lO8y9t44Vyez8NblVG0ecY3/RXRjp9g6tmivpO61RII0v1Dr7JeodocxLlGP?=
 =?us-ascii?Q?us8fTvC9lSidDliGR8LIWFjWqpBuNKwqqc2YoQyTWgdOG7G9JijDxR8ICbrt?=
 =?us-ascii?Q?0jLIhWZTm5YSbH4sVEg/lqX3NmOVFhDCM9gldoEbRBLSmwfXhDF7JbO8kJr+?=
 =?us-ascii?Q?8rZkdLZG+1OejSvTsIWDb/tHHRFX+S/xcLsniSE80rDY/6ashosEUYbASaR6?=
 =?us-ascii?Q?Jijm3Utf7ocxtRq7FDnbiFwzYXODTZEC9c3HwWN6L3PX+YSXuosfN8ZDS1Pv?=
 =?us-ascii?Q?H0hxFUAELb938z0Wu8Q+jF6hhZqh+ISVsutvLlsrnZ3bWXwuiDsxDOqb7ejK?=
 =?us-ascii?Q?lhw0+XiHr7XLx1ImpdNmDO8qQwytviDK5fneEGGB+x6WcHsO6/sSNBVHfA3c?=
 =?us-ascii?Q?lDBy1MvE2NOKHY/7bhakGzeblZKZYOqjixMjZm3+GXdeOuiKrhCp5XozkFTs?=
 =?us-ascii?Q?QRZbglC/mh1kwnyC90Jh2wjS/3P0NpEfKFasRb4j+oWptTIy+iASzeuXdMBl?=
 =?us-ascii?Q?bpiSBZhDQLPjhahZBy8gREBqFibv/5gmOHJR/84yk4BQDWl4dqHwCwWvttqO?=
 =?us-ascii?Q?iLTLUPu4evoMeO+B1CzNFmdoxb/XEf2hoNxTtJI2ptgRUSlaHqhflv3R7Y79?=
 =?us-ascii?Q?4SMdiF506KLeNtsuQ87McRIAmc4q9vPsPhUj369wArbI1sEdLCbhTaQH6Zdg?=
 =?us-ascii?Q?+PwtuECkVNFu/TPyBnsbeCmPqn/0bfbxCqM9icDLsrC0a/LETjxlf6RK+j+d?=
 =?us-ascii?Q?nbkWWWMdHEusdxSWTlGEJaddiC6QK7XUCfYYEsw7Vghnez623dfXhnIODPEf?=
 =?us-ascii?Q?Md8XGVlVwYriZTKnJGiicyF94FdOYh+yAeRYq/7aV3HHEt++Vbj9gGpIVYW0?=
 =?us-ascii?Q?Cy41wGHWruWfSeRwaH0+u1AdhuBIb5dDN9TE6e34YHszrqke7Egb2/2zowU4?=
 =?us-ascii?Q?Qm5IzZHGt/A4lezExkPGVZq6vz7Pf14XfFloXHcEG7vdI3fZRC0DxbmYwOl8?=
 =?us-ascii?Q?qUyCo7R35SGylKkmj28kTybfYLpFbvgrzJD+o7H9kUe4MKl+Py8XJy+OpRpW?=
 =?us-ascii?Q?gAAXra/j9ni6m24og48ARiBaQ6aetepufaWwtFgeoWcBz4Yj9KPC9lD0Umx3?=
 =?us-ascii?Q?GpfmzY48UE+2A8wIDAa88gwY2/7YpqW1LpL5jdRgHwO/fGFc4tMJv7D5iw/C?=
 =?us-ascii?Q?eFCHhhfKGSC/IoiBfxaCeLP9Rkm3JweRcGDs6noK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a9b36f-cfbf-4ab7-8061-08dddb4aa56e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:53:00.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJhXASYfmaRy2W3xgin3w9EU+9fjmGFk4+rG90cF4vRPU1AhdAVt//MQAWJ2+2OH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111

On 13 Aug 2025, at 9:55, Usama Arif wrote:

> The function already has 2 uses and will have a 3rd one
> in prctl selftests. The pagesize argument is added into
> the function, as it's not a global variable anymore.
> No functional change intended with this patch.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  tools/testing/selftests/mm/cow.c            | 12 ++++--------
>  tools/testing/selftests/mm/uffd-wp-mremap.c |  9 ++-------
>  tools/testing/selftests/mm/vm_util.h        |  5 +++++
>  3 files changed, 11 insertions(+), 15 deletions(-)
>

<snip>

> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selft=
ests/mm/vm_util.h
> index 148b792cff0fc..e5cb72bf3a2ab 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -135,6 +135,11 @@ static inline void log_test_result(int result)
>  	ksft_test_result_report(result, "%s\n", test_name);
>  }
>
> +static inline int sz2ord(size_t size, size_t pagesize)
> +{
> +	return __builtin_ctzll(size / pagesize);
> +}
> +

There is a psize() at the top of vm_util.h to get pagesize.
But I have no strong opinion on passing pagesize or not.

Anyway, Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

