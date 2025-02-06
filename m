Return-Path: <linux-fsdevel+bounces-41000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F47A29F4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 04:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B662F3A79AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 03:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3E14A4F0;
	Thu,  6 Feb 2025 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aNptVgs2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED852BA33;
	Thu,  6 Feb 2025 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811776; cv=fail; b=TipxcZY8/zqvPfdJ9wKZC19PRBFOJaquHo5lEOPUQK12z12bSSocGYgepT3opjcBfClC0h+xk9ukR2fc1ABs0h0jkC9tcVtefB3xpPcgSco1Ac6k1bgFOiVA/oOXbPW7yKWV3bXRWqNt5uQWgK2rIQMS2pmfARcQB0/leglGusY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811776; c=relaxed/simple;
	bh=kD24G8G5VtsLO5NB9MQUnSX00NQp6iz4QvzDzhFQ650=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C2AVAc8Qxm60cCcpbRldiRvbsn5h8YYAz13xTW9+dCq6njcDOMNTi8qTRYzpZbMC3uQMrZe7X6sNzanRiEJP8zaiV5zbtnzXXQntru5xbWAljdlTcRlG94ySmksWu2QZBcM3mM1Hg7IouVzKYHl558zopopm0SotWcR9GeW50zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aNptVgs2; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V29uiwa1VaKV2euY/42XjB0ptlKBqCXnL6jmFfXbc6kMci/zyaHYll+oRyfFM8KyRxEQ9VP0P9uCdO/2OCu/7SDrLrf4oIJOC0F8ut2Pj5SAInJsoqU9sIEQnvNlOExvVDX6bsNhWhW9wy9GUK4pJt1HtTv7naE0iJEwjo8A1zBuJHBfWJLAGqP7ZG2jTcuJbGpemkCiNVJ+7ivUTNA7I+ufiQvRYMw9tz0n6aK/JHgdm1KVieQdI+sfUnhxZdak25UBtXiGtbfU9IuUM03EzfIItnGSo4ZtJ+8MZ/pdTHug/1Sq2FAaD9mJBAKqL4hKUt53N3wfj/uIpMsNN1m97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/T1fC1oAC98z0b6PDhtI7ba6jI0t8WSKkPI0DW16YE=;
 b=s8s4rHRubgh7QZ0TPo+Np6uA8KsIUgKwAmYNpOmBzGugxnuSEClWBezlrRPsVrYWmy42ZoscnP5xK/8EKIWhkvsZFVVyuhi7UQyfyUeRuMmx9hTyWhQjD2J6WWc5bCbEjeJY6JJ3E9yXAYWS40l+anCm+HzE3N/xZzAjnSDykXFD05eU/+TrUDaOgMMXZfQ31opvHKB7us56ZYCjfG3HpLOEjJf7A9h+YkrRbzUUFSe0GEcY3hNqe1AWcd2O1OzMe74Y2MGRHHQJ5WEQ5UQlmMHEIwLLMzveOA9edgWmh1wA5tqwBSIXDLqweYUpvtbFaS9WScBo4/5Y0SV661OFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/T1fC1oAC98z0b6PDhtI7ba6jI0t8WSKkPI0DW16YE=;
 b=aNptVgs2F544ARj4z0lCrjOl83W5Ro2B3wD0rvmE065O13HDvh7aNu0g8URdNmyB/a4xFOFOqE+Ffq7dqOx+iVFv65GdyzqfITPRrOy1zlgyoZJOv17DDUnVCafO9lZzvEskCpubWVqnbLMYdccAsAUg1Wm03COwnwZV1h+iCyU=
Received: from BN0PR04CA0187.namprd04.prod.outlook.com (2603:10b6:408:e9::12)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Thu, 6 Feb
 2025 03:16:08 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::7d) by BN0PR04CA0187.outlook.office365.com
 (2603:10b6:408:e9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Thu,
 6 Feb 2025 03:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 03:16:07 +0000
Received: from [10.136.39.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 21:13:02 -0600
Message-ID: <28ed3e72-d219-4a02-aa8a-5b3ab413bc65@amd.com>
Date: Thu, 6 Feb 2025 08:42:12 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] pipe: don't update {a,c,m}time for anonymous pipes
To: Oleg Nesterov <oleg@redhat.com>
CC: David Howells <dhowells@redhat.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mateusz Guzik <mjguzik@gmail.com>, Neeraj Upadhyay
	<Neeraj.Upadhyay@amd.com>, Christian Brauner <brauner@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, Oliver Sang <oliver.sang@intel.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
References: <20250205181716.GA13817@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250205181716.GA13817@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: ba830744-5834-45fe-5149-08dd465c9956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVpjeVFiSjNoSHlwNHlmQ3FTeS9kT1ZkRkxkMlN5WVBJSE1YQW8zZEhROEF5?=
 =?utf-8?B?eFJ0djdBVVFQMHJXWk9GOG14Q1lnM0Y5Q3k2SDg2Q1Y1K1FjRnF5ZU5pdE9T?=
 =?utf-8?B?RUJjWWIzaTJYRkdJTXc0MWZWUjhrNDNmSUZiVU9sOFEzcWVqYnZFdVk3OTJi?=
 =?utf-8?B?OGRSQnNTNGwycWhob0RBTTJVQnhiYi82Y3IvTmlkOTN5a05Ra0Z5V05sOFpV?=
 =?utf-8?B?d29FVlk0NjllME5DS2JVK1hDVXBYQzR1dlVxZndhK1BJTlVmTjRETG42OU8z?=
 =?utf-8?B?WjRQRWd3MDZRUEVwQ1FPc3JCSmJFT041M0pud2trSWZrNWlMMTdNSm1OQ3pW?=
 =?utf-8?B?eENESjd6Y01mNDdGUVhjaVJaekVYdUNZb2pEOUQxV3JHd1JGdkp3cjE1cTZ1?=
 =?utf-8?B?VkpmVkRjb291UHd1YW95bmtRSzhXbWRvaHpUZVpnYWwyeXVVNWltNUVzQnB5?=
 =?utf-8?B?T05sYzJ2MWZkemVrR2RPNjhJZk5xZ2lyZ1I5US9lMlhQKzlwYnRJRXUxTitn?=
 =?utf-8?B?bTJlRjVuRzhBazBaTDdRWTVPZ2E2TXQydUhNUXA5OTVHU1h4YlAyNkxrY3Vw?=
 =?utf-8?B?UXp4WWJFZVVqa2Y3Rk03MEtrTmlTRzdQZHdjN3kwNXRnTDBSYkphYkRrRzVu?=
 =?utf-8?B?MytSUXJQLzQwdEVOSERodm9YRWoyZnhVNTVpMXY4WDlJZlQvbitaWTB0eTZ6?=
 =?utf-8?B?S2RreVdIRVRkTFhDNkhrWTMzaDExbVVHc1VUalhFQW9MM1V3R2NXTDZWM1ZE?=
 =?utf-8?B?ZndLNHYxRUdCZDNSOW5uN3p0eXVncVdmMFQ2UXVveXNuVUpndThLeGtJTUpy?=
 =?utf-8?B?MGl1RXF0cVNlQTdVMk1kTnYvL2FJYW9WRUZrZjBMUHFBUU41NHRxY3dvVFBQ?=
 =?utf-8?B?Y21kUERjc3IzMlFXL1FCTDRJckpmN21SaFBWTmJnaUhLNDBnbFpGc0xIRnFT?=
 =?utf-8?B?ZmdYSmg1TC9na0E0Q0wrb3pGQkpXandhY0hLTU41K29vSG5RQ3JwcnZmeVNo?=
 =?utf-8?B?ajNlZndZby8xQUczRU9RWGNSQ0Ixc0hYWTUyc1BrRGsvcXhydWJLNVJHTUIy?=
 =?utf-8?B?YWlsNFNsKzZKTk1tTG1aeXhrUjUrREUvQnVLdEVEcUx2MVA5WGdHQnM5bnBp?=
 =?utf-8?B?Z0hVWURJY1YxZk5SQ2cxZENIQy9STVpwNjk3QkRVdTVjb1U0VCt0R2Jid2Js?=
 =?utf-8?B?Q3RNM1BYbS9vRThwWWEzUGpoQm9rZEV0MHk5ZzRHOWZkZ0VkNVF0eEl6WXp3?=
 =?utf-8?B?am0xdURkSWtWYjJ3N1NicWhBWFBzWTB4SmdSeTNIaEE1dmFvaXdMc0JRcE5E?=
 =?utf-8?B?TWpzdTEwOEk5MVljdUlCcCtSZlVqdjFxUzVKMTVDQmpyMWFpdnlOVXIvMlFG?=
 =?utf-8?B?OFBRcFBZOC8zak1uWHRQSWhZNVRBRGJRS0xCYkVJdWZ0MllyenZZeHdJWlFC?=
 =?utf-8?B?Wjd4bm40U3hWanZCRStHdERnTnNOd0pabURjYVE1bTZFa0VrRGp4S1E2QmNM?=
 =?utf-8?B?SWZ5OGlzUWFRQngwQVNsTWwvaDA3cUt1UzdzcXNSQk5UNEtCNGlncWkyY3R0?=
 =?utf-8?B?ZWFXMzJkbUN1R3ZLV3pTdXVPMkVyUFRvWi9hdElNd3pLMUhvdDg3M1BlTjZW?=
 =?utf-8?B?WEJFOUtQaXdjc0Z4UE5rVTVhTFBRTWthT3ZsWkMzek1jWmtnWGR2d2VDcUd4?=
 =?utf-8?B?NVB3Z1IzbnVOa0dlVmNJbnRCcldHVVpTNVFsSkpNSmxXUkFpTGt4bTYwc0tP?=
 =?utf-8?B?RmlJRG9GN3lmL281OFV2M2FCUDVNRWFoMHNvc29DMEEwL0Y1VDVveUczVEt0?=
 =?utf-8?B?RFBheGpxblcxVDM4ejg4UEdBM3JRNnF5ak13bEUrYXEyWTh3RnJsdEx3MkZm?=
 =?utf-8?B?MnB5b3lpTTFYUlJlK3pjaDhkYTJhRldZNjdQZllyV0hRTUdOTVlNTGN6RjZl?=
 =?utf-8?B?dVVTL25lMEtKTTIzWGE2bTA5SDl3eWNEcmhJNDZsWGNYTVF5MTF2SDN1NmU4?=
 =?utf-8?Q?mc/tcsNrnLzRdKxJF35Whmu5TOQGVI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 03:16:07.9359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba830744-5834-45fe-5149-08dd465c9956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459

Hello Oleg,

On 2/5/2025 11:47 PM, Oleg Nesterov wrote:
> OK, let me send v3 right now...

Tested this series with sched-messaging on my 3rd Generation EPYC
system (2 x64c/128T, boost on, C2 disabled) and I see slight
improvements:

   ==================================================================
   Test          : sched-messaging
   Units         : Normalized time in seconds
   Interpretation: Lower is better
   Statistic     : AMean
   ==================================================================
   Case:      upstream[pct imp](CV)    skip_{a,c,m}_time[pct imp](CV)
    1-groups     1.00 [ -0.00]( 9.88)     1.05 [ -5.16]( 7.19) *
    2-groups     1.00 [ -0.00]( 3.49)     0.97 [  2.70]( 3.54)
    4-groups     1.00 [ -0.00]( 1.22)     0.97 [  2.70]( 2.78)
    8-groups     1.00 [ -0.00]( 0.80)     0.99 [  0.94]( 1.04)
   16-groups     1.00 [ -0.00]( 1.40)     0.98 [  2.43]( 1.02)
   
   * Disregard these data points due to large run to run variation

Feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

I'll go test the pipe_{read,write}() cleanup you had posted on the
other thread.

-- 
Thanks and Regards,
Prateek

> 
> Changes: make pipeanon_fops static.
> 
> Link to v1: https://lore.kernel.org/all/20250204132153.GA20921@redhat.com/
> Link to v2: https://lore.kernel.org/all/20250205161636.GA1001@redhat.com/
> 
> Oleg.
> ---
> 
>   fs/pipe.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 47 insertions(+), 15 deletions(-)
> 


