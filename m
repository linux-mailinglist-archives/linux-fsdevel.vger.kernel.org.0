Return-Path: <linux-fsdevel+bounces-32160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF59A1854
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 04:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49491F270E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F694D8D0;
	Thu, 17 Oct 2024 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kA/38MTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396842040;
	Thu, 17 Oct 2024 02:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130506; cv=fail; b=WL+JE+f21o/MDeIvjZ983ZRYni9ugQ6xCb44t8HFaRo2XZVrBM3DueuszyEUtTtXy3gt8MsejBmoqQdmHwm9bF/E0H++jIYAcjpja7dHeI8wR18GAOcGWNR3I+2+ZAW34E/dj7p6A1Y+qbbBSLTGs0zG8K/9zuLMcjRn3RgJuoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130506; c=relaxed/simple;
	bh=JjfGjrBqLPaPvrezUjJszjel297Au4tnP6gfI/SJCt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HR8cb51WFZq3tSEhGwxre8Kq8haBfKS4PPYVBZRCPVEPmN289UZQAeeiu+skYW08qeBdBPQ9kMV/+HMv+N5IjDW779iQWYnJ7PxChrWVHOOqXabN2U4EW9oQIpfGIXcRwj8er5axuFxvZXqI6mWkJZVAfxCt67gvFiZfkUJsHwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kA/38MTF; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmcCkCG3eEF0JsjS7FKJF8tGxhaA81Z4QpYgU231OUI/4mZJ3QScDD2+8wauE141YW9bb8KVBtLv1/NK+sVfokhLWxadUuSG0+miTjTP3kNwH6iT4rvQIMg+bt+S5bPC6hFM+QqzHtmOOkTQKpW2VeshC7ltdjDWgLFo2dw5gFR8ib6SMUr7YTggJga+x3bBjmqTugZrTTeARro5q2AhA9t7ZNDtPd7LisFnCUZljw8xjpkVlHEi8LoQPxMHozDbG1GQGDydWJoC2qJRGIC0pcUDYup42tra2ausns+alXIccFgfUxx1MHgp5Eqe3p+z/390LRntxiTN4oeYtkZcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUgbMO0odbDh4slxg5Cb6UL4WeXU7xyppWX79OymsEI=;
 b=H+Asxwpg/daG0k5nEXSa67BkN4+Mbud1DK4aHq6xg0dCTzScBRi4TpupSE9qshAqakpKcvuevUVd+FDnoz+PNq876VFHH3/23bzQWISb7Ive8ZxdzXOvn3WnHwwNZjSi+8Oj2JaX08afRMCK1qt9hCy4t9fRXxFcE2NMGmSlnWmTFtmgQkBwD5xlmvyNE+BQ9VNfGNcR7/lYbV5n0KwBnTnNclaLkFtd1pvFLMpbqGypSrHeZtTjr0I7R8a51OQyzCbH+meHREjuaCmYr6JAsvw4zlH+ejcY0jBmJonelBr+pFcEKWxhE93hy5gKtZwrllmLwiE9pc/ic1QLtMRlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUgbMO0odbDh4slxg5Cb6UL4WeXU7xyppWX79OymsEI=;
 b=kA/38MTFYihna1QKKg3CBhMEsWyDPI2KJqQL926CnZtqqoNCG5/v7wEr1j/kGf+gT/6qN2dhlGgmWaNNEkJbnakowSS+EmfWbJuTGhHg2XgjXderhZE6cN64UZIxvmsqQrpcNhibcC8qmVVwmAbNg7wj60WH3pbtc6Kzwyr9l+64beIkUuYaDNMPPAyE3fS9CWVkiuoGU00z2RmAtF4JP+quIwfcbNVi3h0grbJ7et/sVQbTi20MlLhq+I5j0MM9SB/wBy4tYqkBd1KnrHRWfOZasj5b6gUvbBvBTBUQfY65JdXA/jeto975bv4wnLLvEzePXzy3CgtzFbA4AXJi3A==
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 02:01:39 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com (2603:10b6:408:f6::4)
 by BN9PR03CA0332.outlook.office365.com (2603:10b6:408:f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 02:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 02:01:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 19:01:27 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 19:01:26 -0700
Message-ID: <6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com>
Date: Wed, 16 Oct 2024 19:01:25 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: The "make headers" requirement, revisited: [PATCH v3 3/3] selftests:
 pidfd: add tests for PIDFD_SELF_*
To: Shuah Khan <skhan@linuxfoundation.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Christian Brauner <christian@brauner.io>,
	"Peter Zijlstra" <peterz@infradead.org>
CC: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, <pedro.falcato@gmail.com>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Oliver Sang <oliver.sang@intel.com>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: c7780986-0990-4e36-4235-08dcee4fa2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTRQNlNYSnhxMHU0eVZwK3ArV1poamh5NlJoejJweVArbnkrSE9tdkJwUU9x?=
 =?utf-8?B?UHJDUU1UNGhMTko0QTBldWpISXB5czF5S2RTd2dwM3dCc3pFVVBGQ0E5VjBW?=
 =?utf-8?B?cGdqWkl6Q0FPaU9XQmMrL1VWbTd0YmJ2dEFna3U1ZzA1bDlhejFQUDRSNmhN?=
 =?utf-8?B?TzBFcmlRQnJtVVRlNjQ0c1ZOakJJSklIQ3hEZVc0QVZqRDlsYnVtalpqVTd0?=
 =?utf-8?B?QVdWQ0FBa1hyN2hiRGloejRXQ01aQS9nNG5FM29vSWNYZGd4b0xaOGNvR3RL?=
 =?utf-8?B?NHpMQTFpRFBlVnovWmRhVXoxRjBZZ1YzdjV6MUJJVWpyaWlXYU1HMGlJbnc3?=
 =?utf-8?B?TzZmUkMrK3FBQ09nOTB4RG5oSkZkN0huQnkyRWdvVkhUSTh0Zm84QUdKQVN0?=
 =?utf-8?B?QVMvWXk4N3pFWkN4RnpiVDllU2J0bDdaUDIzNnd3QmJ6di9JRWJpVHluemFR?=
 =?utf-8?B?eHQ4ajNDWFRwVDhjYUlyVk1QNCt2VGpWN1JvYW55N01IM3ZvSmZBNEFuVjJY?=
 =?utf-8?B?Mk5DU2hYZVRVbFJ1a29oRXZ5OXp3UjdzTUx0NStseE9ER1Z3alRGSTFFL2hC?=
 =?utf-8?B?TDd5T1R6bnRyQys0Z0VabEhETVlBSkhqTVh1K29UQkZsWDFrOXdkakRGWUNn?=
 =?utf-8?B?Snp3NWxTZGdDNXNteEd4b0ZkRU80V3lOSlYycGx6N0RZV3JhZ3ZVMkF2U1E2?=
 =?utf-8?B?ME5VNVBISTkraGpMT2VCY1FCVGhPUGtZR09Ya1JWNmlYU0wrQVpFZ3k0Mytw?=
 =?utf-8?B?dmg0aytoRUJOK0IzbXhZTDNqZTdWNWk2OXkyLzFrM2RkclluMWhtckRQNklL?=
 =?utf-8?B?TXJYdjRHdkk5Rk9neXhvRUFkV2w3clU3NnYrOUJZTFNocWFobXhieGpiWENS?=
 =?utf-8?B?SEtoVlgxR1B4TDNmUjZ3b3RDT1RHVDFUcDJKNjNBVjlnYzh0YkRUeHl4Qngx?=
 =?utf-8?B?K2p5a0lqSk9hUWZXdWUzM2F5K1JHUURTQ3VCZ1NocUYvYW5od2NWalIzaFVm?=
 =?utf-8?B?bkNIajVrRUlsZFY4R0FoM2FyVXlKUFlMWmxWNkloSnh2V3RmeFZxaGYrWGpT?=
 =?utf-8?B?TUhaUzRVVDlxSXpuVk9DZW1JMUpxV2xwOUVNMEdZcTgxOHdXZWFFbnBjUEZn?=
 =?utf-8?B?Mzc3eXdITlNRSUJqR29zZDZjS0dkS1ZIc1cxdERYZURzbFA1OGo4Q1k2K1BO?=
 =?utf-8?B?SHNCMXNua2RGZFNTU2M5bzBCZGpYVFJoWFZUQjRZczZtemJHVTFZZGtNTTNE?=
 =?utf-8?B?Wk1tbWljMUNZT05TclN4TWxQd3p2c25kelk4YmlwenhyTVpXYlZpR3NiYklY?=
 =?utf-8?B?cEZ4aTRPclp5UURwOFZRdEZFUHVGa0FuV1dBaHR3UDZEMW5peU9hcUVOak45?=
 =?utf-8?B?OHArWGxvRll2VVoxcERzd1V5b0ZOSUxIS2JIU1NxL1BZU3J5dnh2U1ExcDk1?=
 =?utf-8?B?L0hQMWVsZmN2V2ZEaHFEUmVJblRlUjY0MmpkekFSYUxxOXhJaW1KUjNlWHht?=
 =?utf-8?B?aGtvdVU0ZDg3VG5tQyt2K1FCYTJvSFVmdGs5VkZDcDNublgwUUxJSW5JWjNw?=
 =?utf-8?B?c1VnaXo5cnAzRXlCY2FOWGR1Y05lWWh0TEJNOGs3eE4zbVRXMlhFcXdNQXdv?=
 =?utf-8?B?cmJmMWdnZ1MxbEVHSmIycXNMRmpWRkNSMFdWWVdTaU9GaXVERkZQVHlDR29l?=
 =?utf-8?B?M0taMmQ3YUZ4Z0gwZmlKRld1cTNJTno5Z3FBRUFKeVNWdUtvd1pkcXQ0bmlC?=
 =?utf-8?B?K1BUTU9qUFNNd2hEWmZQVnMzdW9oQk9NaUJ2TnNIMG1IVHhzRkduemh0MXNl?=
 =?utf-8?B?YjVUUVdXc2VjaW9pT2p0UUU3N2dTWUlLcXo3dVN2MzJETUthTUlUYmRaUlJp?=
 =?utf-8?B?aUFJTytuOXhCeDZEdTlpbVgwSHJ2bFRkRjF0NDI3NUlxaVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:01:38.1939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7780986-0990-4e36-4235-08dcee4fa2fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

On 10/16/24 1:00 PM, Shuah Khan wrote:
> On 10/16/24 04:20, Lorenzo Stoakes wrote:
...
>> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
>> index 88d6830ee004..1640b711889b 100644
>> --- a/tools/testing/selftests/pidfd/pidfd.h
>> +++ b/tools/testing/selftests/pidfd/pidfd.h
>> @@ -50,6 +50,14 @@
>>   #define PIDFD_NONBLOCK O_NONBLOCK
>>   #endif
>> +/* System header file may not have this available. */
>> +#ifndef PIDFD_SELF_THREAD
>> +#define PIDFD_SELF_THREAD -100
>> +#endif
>> +#ifndef PIDFD_SELF_THREAD_GROUP
>> +#define PIDFD_SELF_THREAD_GROUP -200
>> +#endif
>> +
> 
> As mentioned in my response to v1 patch:
> 
> kselftest has dependency on "make headers" and tests include
> headers from linux/ directory

Wait, what?! Noooo!

Hi, Shuah! :)

We have had this conversation before. And there were fireworks coming from
various core kernel developers who found that requirement to be unacceptable.

And in response, I made at selftests/mm tests buildable *without* requiring
a "make headers" first, in [1].

I haven't followed up with other subsystems, but...maybe I should. Because
otherwise we're just going to keep having this discussion.

The requirement to do "make headers" is not a keeper. Really.

> 
> These local make it difficult to maintain these tests in the
> longer term. Somebody has to go clean these up later.

There are other approaches to making things work. Again, please see [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e076eaca5906


thanks,
-- 
John Hubbard

