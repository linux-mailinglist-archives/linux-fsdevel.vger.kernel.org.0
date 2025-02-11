Return-Path: <linux-fsdevel+bounces-41503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547AA30269
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 04:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357AE7A1A58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 03:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47031D61BB;
	Tue, 11 Feb 2025 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bGNVVSmv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152226BD8E;
	Tue, 11 Feb 2025 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739246385; cv=fail; b=UWTD1DXbJQ5KDv4zXg8OWW4u6skEjMj0WRvknnAjsKt0oyYXLUV3i6ANFoCiwHWKTvW8l5cgduoPfjarhUFw5EbBesTamR3VLnAWTI225FLBwjMpruSsAx5kXndV61F50jjTiH7M2oJ/oi4n/HcUkEl0Th7qjyvY2dyyITiIsLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739246385; c=relaxed/simple;
	bh=twbG7yY8I5BZGDKXOxhE1QcKcilPOIu3SeE51y2BwAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zoburmzu3rXV2VXqtYa81VWZbi9RL1yMkDpOne/FE8Z9lXq2c6yUENGOPp2a66PGsTDK71vA69QW/EgD0TJodYQwBcIRXlqU2E9eSX0WsXQty2IDSfF8WrQuT7Mk38qTVZ7hMWja2iSCYlXZM4aU5tIxrJKo8b42hsm7uacUN7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bGNVVSmv; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a08Ix4/YqZZc8ZoEON7YvRGURhEk6ceKfFot85+Bmapj3JBQEFhwAGQycX0uQgkYoM5kZBvUuAj59uDxb5PwzPWECMDNEA1/5g3mv1Msa/RPiVB3EiId53P7PMd/6toVNUD+d4CAQpCo8XgC8VFPSd2+Ue9OGc9PgLU15AhUj767PrTq3dDo9ZNMKrJBR7NvJw0Ke6sq7sjHDZ8t4DCXYR0hwjjU8c1ISbTpGF+yV9SQzbalJe/Y/Qor93JEiw5LVkOAcFKdj97fUb2gOtic6S/rVN5TU0DlsexdvbV02ihsWYGY7lxFgmi1d/y53uqoUL5bA5gDCzbEpOsdJwpf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtU9XlG8GhvKetMNjIAwRFYIPD1lto0nh089+TU9epU=;
 b=I9y+siINqoaaGVOlLsvOiBKJ6EEBrCeICleiPD+jySqZFFJdXiLDFT8kC0+sN0PQ4l3YHqz0r6Q9ZpRtB6xyv6l5sMC2z6F5PEIx6PHQ0UzEZJWhgxivG45HCHpt185aWQANhjixuFxNTE3VDFK9XBoxxF7q55hl46o1PKRHFYiREIJQwyD+8byJG7P5YKORrQ9UEqVy0ulWn3UTOeeKuqLU6tiynRyJStHq5+UqXyBpm5suaNjZtJAmtYRy0R7dCjrSCTxZMY8gyfK+fmOfiiUSuUz/P7TqLcapnQvpNebkgbj0GtLRoqYlBgz7TYVPbMtVKznSpq1voVliceZoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtU9XlG8GhvKetMNjIAwRFYIPD1lto0nh089+TU9epU=;
 b=bGNVVSmvEZoOOyGIcPQFv+wvg/4Dp/zchqb5ywE7dn7mPlsI43etXrMwuGndukK1mKOjar3qMGk3iT0jNGgspUNNO8aXjPJOKxNQ8cj9zK6dtMXUa/sz0xpDl70kfPZPSegI9z8hC1u7RlhD3e9cyDrLQ+sUot2EuQpRRKeZEYk=
Received: from BY5PR17CA0047.namprd17.prod.outlook.com (2603:10b6:a03:167::24)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 03:59:38 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::e3) by BY5PR17CA0047.outlook.office365.com
 (2603:10b6:a03:167::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 03:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 03:59:37 +0000
Received: from [10.136.45.220] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 21:59:28 -0600
Message-ID: <fff8727a-29d7-45fe-a997-d9bd55e07f52@amd.com>
Date: Tue, 11 Feb 2025 09:29:02 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized
 buffer
To: Oleg Nesterov <oleg@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mateusz Guzik <mjguzik@gmail.com>, Neeraj Upadhyay
	<Neeraj.Upadhyay@amd.com>, Oliver Sang <oliver.sang@intel.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
References: <20250209150718.GA17013@redhat.com>
 <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
 <20250209180214.GA23386@redhat.com>
 <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
 <20250209184427.GA27435@redhat.com>
 <CAHk-=wihBAcJLiC9dxj1M8AKHpdvrRneNk3=s-Rt-Hv5ikqo4g@mail.gmail.com>
 <20250209191510.GB27435@redhat.com>
 <b050f92e-4117-4e93-8ec6-ec595fd8570a@amd.com>
 <20250210172200.GA16955@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250210172200.GA16955@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c97c079-2cc3-4bd0-40d7-08dd4a5080fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFB5bGJ4WkYzenJDUGt3V09oVTZaR09YeWJrbXpudGFEQW11UGZONWtBSzRj?=
 =?utf-8?B?Zkt4RitETWQ4QUhqbFl5L3d1a1d5M0MrNlRheVdoZWg1dng1bEkyZjY0M2xQ?=
 =?utf-8?B?Z3NKeXBMRGZKUlJvRkZhRjk2dzBueE4zYkM5Q2RxdjQ2RW9leDB3TDl1QXlI?=
 =?utf-8?B?eXpwYTJVMWVRQXdjcnI4TlJTTzBrUkFhaFpnNGNTVUE1VzVYRk1tTDQ1ZStm?=
 =?utf-8?B?RGlVemhBV1FnSEprZy9kUWFaSEFFRTl1UXJUMksveVhXTlFud3l4dy9YREJD?=
 =?utf-8?B?NDZuak1kNjRuVTRpYXBYYlVTUFJPMy9IU1N3VVFKWTVEYVRENVliRDNTNDRB?=
 =?utf-8?B?Y0J5cFFnMDJ0dXhiKzM3WXpRV3dLNzRzRGJTOUh4V3hSbVdqaENFRjFESmZK?=
 =?utf-8?B?VmpiWkVZOEdCTUFDMHdkQWRQa1pYdkdmQjQ5aU1rREVhaW42cGlwUkViNGJY?=
 =?utf-8?B?cnpiR25DZ2FwRUtRU282bHFMTmRURi9vc08xZWRsSzNIMG00NHRaSWtLU3BL?=
 =?utf-8?B?T2dTMFh5RWRtSzhITEs3K2I3N3VOOExvbzNiVDc0YXZJMTU4RXJBcmk4TFN1?=
 =?utf-8?B?VlN6dE5IZTFYSHV0VFZWUkJOdTUvWExHdEFLMlZPYW5GbGpRbzJRUDhRWUph?=
 =?utf-8?B?bE9xMUtZRTFlYitMWGlyMTI5UWV1SldFNmZCY1dkYVhhc3YyNEtqMDR3Ukto?=
 =?utf-8?B?WGtVR0JzM1gxUXhHdG92M1ZIRnBqWnkxV0M3K2tQdGdGTXM3anJQdDhhbzBQ?=
 =?utf-8?B?cVRteEYySnBpRVZ4Z1RwMzdXSkNkd0RFQnpOUjljanlQVmo1Y3RpeFlnSktS?=
 =?utf-8?B?MHhZOUE5V3BOaHhORkFEaWxhSWc4Z1NhRW1Gc3dTeVpqUEZmajNpeVkxZWpq?=
 =?utf-8?B?Tk9yNjcvc0c4YzVpTSs5YTJxZGhHSUs5b2ZlaERsM0s2VVhLMmpkM0RQUk8r?=
 =?utf-8?B?V1NvQ2hFeml6bFZJVno3YUUwZmhNdGswbWR1ZEFqTVVSVVIxc3MyMWFIMUI4?=
 =?utf-8?B?MU9nWjQ2VkI1ZHROSjd3WmoybC9PQVlNMHVSUmJKZHdyTmRDYVJtRTljNkZD?=
 =?utf-8?B?d3ZnZ0xMNldxTktJOStZQmxFbVo5d1B6clF1eFNaNlA0V3dmaHRsUVpWTWx2?=
 =?utf-8?B?UUpiN1ZGaENCemUyWHIyRGxOK1dXSUQxdnE4aGc0bnMyZ0N0bkQ3MDlZelNY?=
 =?utf-8?B?TFBKbDlzbGh0dmNodzdlTVJhSzBwODRiZG9jNDQ0bi82V2VJbC82RGJpVkhW?=
 =?utf-8?B?b1ZNWmJxRDhlSnMyQzVKbGl4ZEpkNFZicVA4NnhjOXFKUkVOMi83a0x2V0NY?=
 =?utf-8?B?akY4MVYwUnNxNE9maE02Y3JLUU9PdWE1LzBXd0RiRTZOQWMrcXdsUTduSlBQ?=
 =?utf-8?B?dVA1NHVoYjdMTjBhR1Zna3RFUWc1d2hjbmltSktUbnNYQkFDR2h5Uk51ZUdu?=
 =?utf-8?B?cktFU3REQ3JPbURlbXkwVkdrVTBPRXo4eUUvMGdGanZTa2NNZmxtQkxxZlk0?=
 =?utf-8?B?Sm1DaFk4YWZsSUtBb056cE9ZZ0xJdnV5N0RIZFFFaXhzNS9jRW9JMXFlNlpV?=
 =?utf-8?B?bTFldzFTaVdQWllPbHg5S3h1bnhJbmVzRGllTzJadlVaSmZTamJoR0syZ1Fu?=
 =?utf-8?B?d2JGRk5FdTRERmptQjNxKzA4UFgwc2kvbjJBNjIzS1krY1NjZ3lsMXhYM2Fr?=
 =?utf-8?B?akVwTmRBdTZZQmRmaDlWN3NKNkNzcDBUbUdKTVhtQnZNaHVDQVBiZWwwRVY3?=
 =?utf-8?B?eWlGcm5wNG9GZyt1Yk1zbmE5T3RCWVNzNlFUdk9TV2dFWGNyOWhMbW5NWVlM?=
 =?utf-8?B?LzB1OWpnYnNPa3RINWUwQXdkWmV6YlFsUUM3bEdEYlplOSt3Q25ocjZ3R1pt?=
 =?utf-8?B?dFkxREFYWThDa3Y0dWw5TXNqb0h2RnVjS3RFRTEzelFoVGN4TldnZk5JTEU4?=
 =?utf-8?B?b1ZaWWRPWEQxYlg2bms2TzdZcXFlT1hraWQrOW44SUc3TWlpb1FyRVkrRlBW?=
 =?utf-8?Q?FfTYCY9eZnflDnB4gOSJ0BMTa84Uu0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 03:59:37.6770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c97c079-2cc3-4bd0-40d7-08dd4a5080fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744

Hello Oleg,

On 2/10/2025 10:52 PM, Oleg Nesterov wrote:
> Hi Prateek,
> 
> On 02/10, K Prateek Nayak wrote:
>>
>>   1-groups     1.00 [ -0.00]( 7.19)                0.95 [  4.90](12.39)
>>   2-groups     1.00 [ -0.00]( 3.54)                1.02 [ -1.92]( 6.55)
>>   4-groups     1.00 [ -0.00]( 2.78)                1.01 [ -0.85]( 2.18)
>>   8-groups     1.00 [ -0.00]( 1.04)                0.99 [  0.63]( 0.77)
>> 16-groups     1.00 [ -0.00]( 1.02)                1.00 [ -0.26]( 0.98)
>>
>> I don't see any regression / improvements from a performance standpoint
> 
> Yes, this patch shouldn't make any difference performance-wise, at least
> in this case. Although I was thinking the same thing when I sent "pipe_read:
> don't wake up the writer if the pipe is still full" ;)
> 
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Thanks! Please see v2, I've included you tag.

Thank you. I can confirm it is same as the variant I tested.

> 
> Any chance you can also test the patch below?
> 
> To me it looks like a cleanup which makes the "merge small writes" logic
> more understandable. And note that "page-align the rest of the writes"
> doesn't work anyway if "total_len & (PAGE_SIZE-1)" can't fit in the last
> buffer.
> 
> However, in this particular case with DATASIZE=100 this patch can increase
> the number of copy_page_from_iter()'s in pipe_write(). And with this change
> receiver() can certainly get the short reads, so this can increase the
> number of sys_read() calls.
> 
> So I am just curious if this change can cause any noticeable regression on
> your machine.

For the sake of science:

==================================================================
Test          : sched-messaging
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:         baseline[pct imp](CV)  merge_writes[pct imp](CV)
  1-groups     1.00 [ -0.00](12.39)     1.08 [ -7.62](11.73)
  2-groups     1.00 [ -0.00]( 6.55)     0.97 [  2.52]( 3.01)
  4-groups     1.00 [ -0.00]( 2.18)     1.00 [  0.42]( 1.97)
  8-groups     1.00 [ -0.00]( 0.77)     1.03 [ -3.35]( 5.07)
16-groups     1.00 [ -0.00]( 0.98)     1.01 [ -1.37]( 2.20)

I see some improvements up until 4 groups (160 tasks) but beyond that it
goes into a slight regression territory but the variance is large to
draw any conclusions.

Science experiment concluded.

> 
> Thank you!
> 
> Oleg.
> 
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -459,16 +459,16 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>   	was_empty = pipe_empty(head, pipe->tail);
>   	chars = total_len & (PAGE_SIZE-1);
>   	if (chars && !was_empty) {
> -		unsigned int mask = pipe->ring_size - 1;
> -		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
> +		struct pipe_buffer *buf = pipe_buf(pipe, head - 1);
>   		int offset = buf->offset + buf->len;
> +		int avail = PAGE_SIZE - offset;
>   
> -		if ((buf->flags & PIPE_BUF_FLAG_CAN_MERGE) &&
> -		    offset + chars <= PAGE_SIZE) {
> +		if (avail && (buf->flags & PIPE_BUF_FLAG_CAN_MERGE)) {
>   			ret = pipe_buf_confirm(pipe, buf);
>   			if (ret)
>   				goto out;
>   
> +			chars = min_t(ssize_t, chars, avail);
>   			ret = copy_page_from_iter(buf->page, offset, chars, from);
>   			if (unlikely(ret < chars)) {
>   				ret = -EFAULT;
> 

-- 
Thanks and Regards,
Prateek


