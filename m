Return-Path: <linux-fsdevel+bounces-43366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A6A54F1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 16:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC443B5340
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA35B221F01;
	Thu,  6 Mar 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bh0FIp92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A903210190;
	Thu,  6 Mar 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274806; cv=fail; b=iUhb/mk4DIR0QMANL5LZP0vFPmZRiTzMEw1mmw+cMScfLrE65XX/X6QCUpqGnTFQ+bAy1rFboKaD/geXOVmk6oJuElXRS33sqcoqID2GfU71PHhdHXYebFUmplKXwFKwu/KjXNtlxPhONsP4VZ0qQC2QhzUtvPPkL+0yqXpHrPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274806; c=relaxed/simple;
	bh=uviyzIoecn7aNu21NgE7YAX0jZZjzwGXc0E8SCFwGWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cX7Ue9L+LkIX2tLci6Z5XFjc8pshdRGG3tCLecvndpPinafcVWk5mtdaUIbEBOPDsguoNfiey9hRoFhrN0XIdYnBFa21NghGtMwjR7Wf1DwRC7OwaWVMwRm3+2rFnIQgilhqt5mB7X4Vu7FpDc2B6+CiQrcXgmr3GKYIavi08JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bh0FIp92; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbbH1KuiMtEKkx1FtjkZkR0XbYn+MMCNnKrDA4ev7oLMlBFzpkSjoSIbH/NueDRMOl6nLgtITlFZsiNxeZzs15GSWNyuJEh/sYeeyzrQX87hj5py4RXSslGQO87+We+TX/nL2CXy6P0ApZ4j9d7kDaXCnJRAp4wXo50xSU9nixv1jcj4mpOF+LqjLZPghrYBcGgiiyTc2X+BKMTaXP2pBfcJ00wXOsLyXyv045P8UhP4cmdoQ911KKq8g0f0uPxFl+CnNM7Yvi7GpuIMPC4iqW2KJPDfPCW/Q4Kto4Vy/gcFR+jBIUPTzcmiyyf+8QjwD2LHd7vVX4SEfJqF/RZIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSMdXXv0ltM9w5dyg1OUtcLDFeQHu+1OcDgilhJKeqo=;
 b=AdxtUqob1AVexh+8IcLmtu3pJaqN1MtKS4mbKlgVD3PPQtftPNYjegS9oEvuUy9wBr4RGDXVRYtsowx8v0fZF/s25pU+UGWYXnQl28zc2lKL8d+KttPyFsoSc014r2lJEuo7x+B0o/tdGM2uCNznJ+n5YeZKg/0TZJKPtsvbDLbKnl+ht3ZmUQZrji2+ujEWFYAYM1CWsWbclikRl+ofBVrLgvmdE/fBWMv5UsCzECksI5PRiM+r6DepUygdaVBArXji7u8z5FjMcGImg37cMQU9cWlYRiFxKt+rISj0E9TUi6sTCJtakj9eyBBfL9qnm+IXxcM9pswRqfWDiEYKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSMdXXv0ltM9w5dyg1OUtcLDFeQHu+1OcDgilhJKeqo=;
 b=bh0FIp92nsZWWkA/L5WRPDaHAh/n3wLhDSHg9qSM99LCMCaZ8wXa9m7c92TK50jvoLt/12F+jv61GOXqNfS3kBxDYrWUHqAp+uZGR3vzSNOngBkvEsyNQUi7tdBLEU29clSo5cX+EK+Q3ZTx/A9GvyK+YTvRJgVTFAqsluv2aMc=
Received: from CH0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:610:b2::18)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 15:26:41 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::e3) by CH0PR13CA0043.outlook.office365.com
 (2603:10b6:610:b2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Thu,
 6 Mar 2025 15:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 15:26:40 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:26:35 -0600
Message-ID: <1c4b7bb2-2b2c-472f-b392-ac75cf482ec0@amd.com>
Date: Thu, 6 Mar 2025 20:56:32 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] fs/pipe: Limit the slots in pipe_resize_ring()
To: Oleg Nesterov <oleg@redhat.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi
	<miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Hugh Dickins" <hughd@google.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Jan Kara
	<jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Mateusz
 Guzik" <mjguzik@gmail.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Rasmus Villemoes <ravi@prevas.dk>, <Neeraj.Upadhyay@amd.com>,
	<Ananth.narayan@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
 <20250306113924.20004-1-kprateek.nayak@amd.com>
 <20250306113924.20004-2-kprateek.nayak@amd.com>
 <20250306122807.GD19868@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250306122807.GD19868@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: a439caaf-e806-45ba-3964-08dd5cc34b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3JmWno0WUtUSk5lUlYzVnZYNlBEMUgzaHhva1pWVExTSzViTEdjdVFWZGxT?=
 =?utf-8?B?K1hRYWdaN3BsQ0NWWDdNVjRPU3lZTStoV2JSak5QUExrc3F3Z0N0MUNqdlFi?=
 =?utf-8?B?N1AxY05KS1dVbVFHbHZsendxZWJCUE8vNWdTa3IvMXdRM0tCd0JVOUxVT2RN?=
 =?utf-8?B?b0lrbFZIOXJjQ2xaV1pTTW4yQnZ5bXhJZzJCS1F0blc5cld3TWl3YTJpNngr?=
 =?utf-8?B?MFJIYXJheU9RNDJOc3dsbmcxd1RzMEVHd0dmQUxJdlFBVFIwdzNMT2EyeURR?=
 =?utf-8?B?cXRBbmNhVzRaWk12ekovMUNnS2ZzbkdDSWFqYzhFcFFYSUJ2MW9aV1dxZG1p?=
 =?utf-8?B?TVJ6VjlacVpVa1BFS2NTOW12WVVIVTE3WTU2YmdiWUV6YWZxU3dqblZXOGRQ?=
 =?utf-8?B?QTk4dlVFRFJjOW9DV2JKUUQ2QisySDZMK2xHYXQ3bmJTdUJWS1BpSVcybkcv?=
 =?utf-8?B?Ylh3VmZSc0NmYmZoNnJFZlNCblRYVXk0bGUxMy9NTFVqQzJiK3BsdTRXSUIv?=
 =?utf-8?B?Nk5ZeWY3YzgxSzdGVDBNeld4NXBQNWZ1VlQ5YW85T2pBNVplNUNseDVieC9w?=
 =?utf-8?B?WkVyQ0pYdklJNHBzdWZra0lDY0tHSGRmcEo4bzBzRUJBV0lpbzZ3QVlOcE5v?=
 =?utf-8?B?NFBaNzlDWTVMYy9EMHAveitLNVpEMFNqbSswaWV4ZXVnTC9QV2NkK1JRTWMv?=
 =?utf-8?B?blk5VGJOM0xCb0pKM0tDcUU1SFNCNHZtSW1hVHBnZXZIY2FxQS80OVVkWEFQ?=
 =?utf-8?B?WEhzOGZwK2RnLzgrKzJBZGhIOXM4MFpsemhHdG9wMUN0eHo1bGFidGFSb2l4?=
 =?utf-8?B?Mkt5b3BRdXZmUnRHRHZjSDZBcGMrL2R1RTZVRzMwUnlMQkZNMTQ4RHZhK0dq?=
 =?utf-8?B?ZFIwNUNtbXJjOGtQWHZnYTltYkZ4RGRreTNaUHN2TUZZR2xNb2kvbnVla1d3?=
 =?utf-8?B?SGNUZmJQZC9pbzZzMHF2eHlxMDlUWEF0MGo5T25xWHl0cERmUjFKNmowaGF5?=
 =?utf-8?B?TTZFanVIWTMwMU5rcWdjRTl6OXM2SzFzUFZ3enhOR1BkMVdVRGpQMEo3amx5?=
 =?utf-8?B?dWVGUjRrQ2F6VWg1ekhPMlk2QlRQTXlFcS9zL2NsOWZvbnNmemRJeFNDa0R6?=
 =?utf-8?B?NUgweUpTckw5RktObXVHa2FTUitVRFNacTlOT2dhRXZNUlkwU09lT0tLWm5Z?=
 =?utf-8?B?RFpDaVNzZGZGWXpmbGFMMHAzZmkzazdjWTJHK0JacnJPdHF1UDBnTlR0ZW5X?=
 =?utf-8?B?RVJMNXNnR0ZNUURWVXlQYmNjUHVKV2lGNms4VThtcFB4OHBEekFNWHQ1QjUx?=
 =?utf-8?B?ZE1Ic25NNlFkNXdKaG45d1RLQWZ6WVZsdGV5VUtoV3A3TkFvRFMySlFMaTJV?=
 =?utf-8?B?aGFRU2JIbWx0WUxtV0JMeHV6Qk0wMEZtZ2grNGxKQ2x4am1Gd3B0NHdDWDM0?=
 =?utf-8?B?aU1hdlM0V29KVmI2K3JFbC9MdDkrM0dxS2Ivc2dtdHZyVmZwNytVZkQ4TGZv?=
 =?utf-8?B?LzRoQ0VDNUJIWVFMUHZnRTY4WWM0NndObU8wcXhDbmIvTTBwRVgxVXhYSGVW?=
 =?utf-8?B?RmtLR1g1czJLZWh3TzhnWldEU0NYc2trMzhuL1gyUXRVbGxCMDl1TWxTNnpH?=
 =?utf-8?B?WE0wQTdxSXpLT21xVW9lM0RXOUdhOG5LanZ4UXVsQU9Kd1BvUzdjR0JJVnNy?=
 =?utf-8?B?TFFOckVBd2lZbFBuUlRJQkJIWWJ4Wkk1a0JjUktxREFrOFpkYXlmaGpxRDlT?=
 =?utf-8?B?YzhDN2lPWGRXcndnRGFUNFZ0V2NTbnhsMEd3QW1PODc0bEowM3N5eWRvaTZk?=
 =?utf-8?B?NzQ4YjgxTXFzT2VGZCtUR0I0eEhoY0dNYTQ0RnNxU2IzSnhiWGsxMXM4ZExQ?=
 =?utf-8?B?N3JMM0tGK05ra1B3SFIxcTZ5ak1ES2pHS2ZuMVUrektUWHI2V2NjaDBYTVd4?=
 =?utf-8?B?MUVrUytld2Z1TEVKUmdkLzRqK0xkVDloSHE3aDNsVFNpdHBRZkhNRGt0am1v?=
 =?utf-8?Q?i/6UisuRjZ4BVbItedHnKkv9S99f9w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:26:40.3258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a439caaf-e806-45ba-3964-08dd5cc34b0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

Hello Oleg,

On 3/6/2025 5:58 PM, Oleg Nesterov wrote:
> On 03/06, K Prateek Nayak wrote:
>>
>> @@ -1272,6 +1272,10 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>>   	struct pipe_buffer *bufs;
>>   	unsigned int head, tail, mask, n;
>>
>> +	/* nr_slots larger than limits of pipe->{head,tail} */
>> +	if (unlikely(nr_slots > BIT(BITS_PER_TYPE(pipe_index_t) - 1)))
> 
> Hmm, perhaps
> 
> 	if (nr_slots > (pipe_index_t)-1u)
> 
> is more clear?

Indeed it is. I didn't even know we could do that! Thank you for
pointing it out.

> 
> Oleg.
> 

-- 
Thanks and Regards,
Prateek


