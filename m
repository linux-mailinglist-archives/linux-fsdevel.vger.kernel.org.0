Return-Path: <linux-fsdevel+bounces-23477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB9D92D140
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8691C2387A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243818FDBB;
	Wed, 10 Jul 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MtUGYhyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1517B05F;
	Wed, 10 Jul 2024 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613044; cv=fail; b=QDaJIvqu9CSi8btj6ClwIuDtWxZ9Z1GShh+0LLOUWNKeNw6FnJTVT4unkBxvpyzisJS7s2VmuD3YkdyJuFcr/eRa6GYDDuLd6k3Hvdq40yEnPJ6spG8GYUZh6H/pZTCNb6giBTLorFcmC3BeQ5o9FU5xbAbk1pGdu7FP+6AGI8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613044; c=relaxed/simple;
	bh=cbLiSXQfdz+eC3z6VyjJ5m8el1GT+3CYkdmDI9UssEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UbtEQcpZNtehZwTA8z2ozkcy/QXf8KuarqlpxtvFqrAGEo52impZO0omsxKJtHWKBIsYm/21UjkLZfXmtb5JrXVb4tXW5Xn8FxTUlIvvR1yHV0ucd1Ci3hrlSGJny4SdcoXorXvhT0A3PnD7McKlTUu3NqdnKB9nO6Xj1SaCvTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MtUGYhyg; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2nI/RsqQy7pjPFZFvW61+Gb6hvKZx0pYYvDUmLDukoJ8xdB1ONd5RDNQTKi4PnxOFFYZKXmte8HgJDhuh8fMt4Q9J3Z/nwDw+BqIFuKSWZaYxdoZ7tMTKmUjPaFCMtuKo64cGeHYv2fuWzssAQMnTeNKSOcqXm/INzbpUcRFELx+9czN2B+BCNrD42S7bDLZqFooQ/FZHFozW1qu0Vq0VMFjhdjURpbZtkOUscnaQDK2jN+Ff0+Ygl/VoCoIN+sFVIstuy4IR8eLEUAt/7yheXtRubYBGDJ8ASewkLjh0ehbZANVYI6dZCyKN+brsf4UK373bZbQY2Y8cqQjjppDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI0OAN9qpw5kvL46/YxSKPqdM4s4XeT2CCebjitDP6o=;
 b=hNt+aSj0/km+qBROmUhCbXG0WQ714I1X0VMAyGgf+gP3FMQiAJ04HvcxGb+gFU3c0jtdeHy49iKJDJaYYhPqudz+XOOo2csxHbKqGji5FJ2Z3Inoitn8ApoNgq6qD47c62HEtvb79WvbZCMx/YeOoH6/uUOerOnCS9idMDIXcOzy86I17V3HQa33pGF4V0CvsFToPf7EFqpDf5tWcxb3wZd1EkBcKjDCQj0tZwkidJdx+rQ0cVv0xpd2bM3+IkQXm4TtjCCOf3SGmYnIFb/YIgpCkrimMFD0MJ9aXlOVYzt3XA2wL0ysC+dT8Rocz7842G5SptQew9fmvn9bN78BgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI0OAN9qpw5kvL46/YxSKPqdM4s4XeT2CCebjitDP6o=;
 b=MtUGYhygXM+sj4xbujiwGuhQ7DRWb75JoZbQGCaB9nEFcUEjHuXfhS6UzGl45IfRKKEYchBbkTlpO4UbYwChxU27w5vWnlpwHIi5YYRHWBnLToA9l1nsNV0KCYjScOrjw2kEXp9v3IILkifswfTPCeCFTXsrbXYqcE+0j3DV4Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 12:03:59 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 12:03:59 +0000
Message-ID: <4307e984-a593-4495-b4cc-8ef509ddda03@amd.com>
Date: Wed, 10 Jul 2024 17:33:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Yu Zhao <yuzhao@google.com>, mjguzik@gmail.com, david@fromorbit.com,
 kent.overstreet@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz,
 kinseyho@google.com, Mel Gorman <mgorman@suse.de>,
 linux-fsdevel@vger.kernel.org
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::36) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c0c832-e241-48f4-fa52-08dca0d86153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTlxclJEMFVxT1pZTC9oZDRnSTZwYjdxRmtGeDc4SGljYUNoNTc2b3VvZzRT?=
 =?utf-8?B?TysyM3ZoOFJyblRtQmpGSXExbkVZc1lQUVJCc3FTeE4zUVYvaW1aTjNlWTJF?=
 =?utf-8?B?aHJMMllPYmQzSXMwRWJBVXI5UnpobWtSQnZaNDVCVDR3ZW5ldUtrUnY5akZD?=
 =?utf-8?B?MGNUL3ZhenpwamQ1eGNqZC9qS3ZGTnRhYnBlVmJpdG5HdXFsQ3A1UzNiYU1R?=
 =?utf-8?B?YmxWZGJtTlFJcmcyRXUrSFdmc1cwc3J6OFJnOXJDNVJ3KzJHbmNoUXVjRlFJ?=
 =?utf-8?B?L0RTcFlRNnFhaVNTeURoU1pQSEtQNjd2VFh5dmtEek1MU0xNcVArTFA3ZmI0?=
 =?utf-8?B?eEQ4UjNnM2RTbkJvR3RKaThmTjlJYkViQTVvMjBpUTU5VGt0aFBFRU5kV3Z0?=
 =?utf-8?B?MkUxMTJMWTltbDhFakZJcFo0MDAwSVYyejV6aldJbHlzbFhXd1pleElRREpC?=
 =?utf-8?B?dTg1UE1kbktkZW5mWGZkQ2FGaVg5MmxwUkhtK1RFYWE5OXlycmV2NjdzU09S?=
 =?utf-8?B?OVQySXl3SG1iSUtwV3JFdG5HdjA2RVZwUmNaUFNzZ2VHU2VjRlpmZS9XYTJn?=
 =?utf-8?B?Ym5qK095bkhWOHR1d2Mwc0JqTTR5Vi9NOXF0OVpCMElaSEtxOStheFE3Q0tq?=
 =?utf-8?B?M2pYV0JiUGRoRTNOUjdsOEh4dXZRREEzOE53UEw3aVRHeTdkK2lrZ3l6OHM4?=
 =?utf-8?B?OS9xVXZhdFlQTFJ2REdmZUxOZW41Q1lXdmppanV5ZUVvVFNoajQzbEFkMk9R?=
 =?utf-8?B?ZEsrV2d6QkdqbTB5azZwZDM2NVVVZitEQ1NyMVdsRkJhb2Y0WWJKNXdKTkx3?=
 =?utf-8?B?TDZSblZmOFo5MHM2VDFFN0RSL0RmKzZpNmZPRGZPTzBaNVBSNXVlc2NVR094?=
 =?utf-8?B?c2VzTFNVQ0NtZENyT2JvRyt3K2lQSzFDbUgzbEVOd2ltYjBueXBJR0RrNnJH?=
 =?utf-8?B?TmdMOVFwSFkwcWpCN0FUV28yRDFaNnpCMjl2Y0hjR3dONVpuSzB3MEljcTNT?=
 =?utf-8?B?TExSVWJHVjIvM25rQ1p2N2o4ZzFRc04ydG1NM1NpbDR6RTJLZEtKdVlmc3Nt?=
 =?utf-8?B?ekNWM0ZUN3dicngxaHlvb21GRGl2MXdJS1JIRXEyZFdVb3E2L1d6Q0lXVWR6?=
 =?utf-8?B?M1hwZXcxcDIwY01xaGY1M1o1czlUVHFJU2pZR1I2SFYrUnQxRzNqUjlGNnZD?=
 =?utf-8?B?UHRWeXF4N3pCOTF1ditjbC9rLzZiK05rZ0FVUUl6RUgyb3dZaHJZQ0RkY0s5?=
 =?utf-8?B?cWtTdUFORy9XZDRKRWpWcHRycjkvYW1tS1JRNnY1TXVFRmZaSHhVTFY3NWJh?=
 =?utf-8?B?R3o2VmlraTBhQmFhdHdFbjJZUW9oQjNmZExCNlBVeVJWbFhlR1VSeTZxbExC?=
 =?utf-8?B?aHJRSitlWmRjVXB6UEU5a1BhOWVDUUUvRWpERWwvb1M1RXp6eUUwbXZVMFlj?=
 =?utf-8?B?aWhiSXJ1UktpcEp3N0xDT3JaUDBkUElQQjU5ekc1NnczeVRvRy9rYUpReTdU?=
 =?utf-8?B?ODB0V1JWZ01QYzY2MTloZVdyTnQyN2FQaGpVUzBQNGNtaXNsU2k4Nm1pdjda?=
 =?utf-8?B?cjhYMEc2eDZ4czFYNWhwZUpDQzJXTm1xZnRlOFpuRG5rSGFXOFhGUTNEdHBD?=
 =?utf-8?B?SmRSNGs3K1M4RmExZXZxMEFCL3greEhtWklhVCsxblRDZTlObUkwdjZNcVpU?=
 =?utf-8?B?L0dBUmhaSHNDM0trVW1PbUd4eGpFYlc5RFZtVUtmVzQ1QmJIK2lkdDN1cU1U?=
 =?utf-8?Q?v7yCjGeSwP3YLdQrmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmVXb1lhNE9sMXBaQjdCN0ZKWTQ4YU8yRUYwU0NYdngxUkIwR0Z1MFdNNTVE?=
 =?utf-8?B?NmxTTm41dDJZZkRsK2poRW4yb3VIQmk0dUQrc2dOVlgzTm1ieHlmRkxITjFw?=
 =?utf-8?B?SFgvMytUKzhpRzZtZXZITTJ2c1dxdFpsaHdjRUNmMkFaemhZV1had25VYUs4?=
 =?utf-8?B?SjJ2dGQvUGgwTG5rVStQRTNtV2Z6UXpCTjlsTTlBNnBwWGh5RmlzTFVUaTFD?=
 =?utf-8?B?S3oyNCtNMzhQVFBNRXFXYUpwVGhwK2o3L0hzRWRTMWI5eGJrVDhVdTVYZFgr?=
 =?utf-8?B?Q2lpU1FnQ256d1BpZkc1WEZzNGpLYldBSnBYMm9nMStvZkJoVnB4Qy9jMStv?=
 =?utf-8?B?Ymg4Y1dUTmJSTnl1WUhLOTdydm8vYllrMzEweE5VNGpmdjVGZ0dpbGgraHpo?=
 =?utf-8?B?VWwwSkNmaDhBQWY1ckFJTGN6WE5HUEg2T2VpQXEzdmJEYnZ6bll6NE9LUU5n?=
 =?utf-8?B?eXZEVUNLenZlS3BBQndBMWVnYjBpRmpnTkI0cktTTzQ3UVRZV3d5K2JmM1U3?=
 =?utf-8?B?a0h2Vk1sejNEcGkyYjFDcmdPKzZQaDRGSHcyMkMvKzd2QmROZS9Zd0pPWXR0?=
 =?utf-8?B?bGtMN281QlZKTlB3TXJ3TEU0WUxvVHQ4THRaQVZOTENhRklUNExZV1dQTjJr?=
 =?utf-8?B?ZGNMVEROMUgvV3VKcytZbUNkRjNvVWhLOCtMUElJcnpVQ3N6ZlkxMFJoUXBQ?=
 =?utf-8?B?TExpeWo4U1pGSzYrN01yd1pqLysrS04rV09ibmVZQTVhSDZDSml6NE5ndTFl?=
 =?utf-8?B?bUo2Q2R3RUJSL0xOVG1SUDRrVjRSK0JCQmluSWJ0emJZZ0wrNkFVV2hkMmU5?=
 =?utf-8?B?K3JVUHh0R3N6eHZKQXJnano0a1BtVjlrNXB1VnF3Tm1HVTF1SW51UVBCeGNH?=
 =?utf-8?B?SHowQWlaYTJaMjZGbUFyQjNWQlBYdzMwL001NlNPUTY3dWVacEdvdGxER0hV?=
 =?utf-8?B?ek9LL2t6ZURGR2ZvYzk1dlo5Tms2cDRvc2haQ05pa2N2MXhrWHlKbGdtVTVi?=
 =?utf-8?B?cW9pbnhOZHJ2NW1FeDMzTUdqUkZGQlV0TU5pN2NMTTlQTkMwQnRZUzRucE5w?=
 =?utf-8?B?U0JIN1hhZTZOQ285UTdMZWFaQTMzcG1XckJkaU54WDc2Z1Jld29ydlBtSWRI?=
 =?utf-8?B?bkJoa3BGM1R0NC8xM0NHZHYxYTFaRGphd1dLNENsU0lNT1AydVZTby83QUti?=
 =?utf-8?B?NSt6bTFFMDFzWWpnVTdqSTFYYU5sMUVZQ2pEQmZFWUhjdTFQS3YvS2RqWFVr?=
 =?utf-8?B?b2tZZUMzcVQzcFF1M3VocFVoVk1YK2czOWt0cFdEa2lJZTNVQ3lJd21neEZs?=
 =?utf-8?B?dmVmQVVmVDlaTkt1Ym9IcVQzZXBQOHR3bFRPZG9UbWNXcmd1RWpOdEF1ejdJ?=
 =?utf-8?B?YWVxMjltc1VuLy9UNWRZY0ZFVGJhMmEyZlhxU0dJUGd6RG9mRUh0eHhJek5V?=
 =?utf-8?B?VUNaR1gza3JvRlNPejBmNGZwTXZYUkVDS0xvK2xBSVJkeUZVK3RUQlhUTHQ5?=
 =?utf-8?B?M1N6bElHbHhaZTF1N1BWcVNJa1JqRHBDeUZsTk5QYnRFYy85MmtYWnQ5SWV0?=
 =?utf-8?B?eDF0dVVWbEtzMjNMK01NY0xBUml6YWFyN3VCVTloMDErQ1Zkdmo3ZW9zeU9X?=
 =?utf-8?B?ZnVrb1NXdFY4ck1rZXlIVE5BZW1CUjdWdXMrTDRqbGIxMURVc0daRTB6Sms1?=
 =?utf-8?B?eGhVQjZWNUlrdVdteC9YN3NucEJpTDNZK1c2Ymowbno3ZW1SOEdNR3VERHNs?=
 =?utf-8?B?SlBDNWg0VVdaTVdDYkxkUnB0Zys3Q3dIbVRUYjF6NHpldTJjbUdPSjUvOU9p?=
 =?utf-8?B?THlXcUlaczF6N0d2WEJPZmk3OHpaTjZDRlI4c1BPN21aL0h6WGxHWEdCK1Zt?=
 =?utf-8?B?NXBocC9LcTY2Yy9wUjRDR29zS1FGaXRkUkcxUDF1U04rdXhrRUwvSDc1MDRr?=
 =?utf-8?B?MnkvU1dkbzZQR0lYUnZUSWtIZTQybnZrcHpFSWx5S0Nra1J1UGY2K3RiMEFw?=
 =?utf-8?B?aU42em5HQzFodFNRU2dDVldMcEVsTytoMTZ6cEZaTDZobUVCTUlETVNMRmxB?=
 =?utf-8?B?b2pkRGoxSmh5aVp4UWdMaGtsb0RkUjl3U3pCVzFYQjhrTnpQcU9IeVBHNXhr?=
 =?utf-8?Q?GoS/TQKwvIIS7Tt4dTtdMD8Gv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c0c832-e241-48f4-fa52-08dca0d86153
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 12:03:58.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4NKPsr105lVIb49jTD8MSijKTVTLY+LscW5sI+IvRKqvg23tLDN8KJFeYbHztuSzsNVNlUHSS3zRarPXOGtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825

On 07-Jul-24 4:12 AM, Yu Zhao wrote:
>> Some experiments tried
>> ======================
>> 1) When MGLRU was enabled many soft lockups were observed, no hard
>> lockups were seen for 48 hours run. Below is once such soft lockup.
<snip>
>> Below preemptirqsoff trace points to preemption being disabled for more
>> than 10s and the lock in picture is lruvec spinlock.
> 
> Also if you could try the other patch (mglru.patch) please. It should
> help reduce unnecessary rotations from deactivate_file_folio(), which
> in turn should reduce the contention on the LRU lock for MGLRU.

Thanks. With mglru.patch on a MGLRU-enabled system, the below latency 
trace record is no longer seen for a 30hr workload run.

> 
>>       # tracer: preemptirqsoff
>>       #
>>       # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-mglru-irqstrc
>>       # --------------------------------------------------------------------
>>       # latency: 10382682 us, #4/4, CPU#128 | (M:desktop VP:0, KP:0, SP:0
>> HP:0 #P:512)
>>       #    -----------------
>>       #    | task: fio-2701523 (uid:0 nice:0 policy:0 rt_prio:0)
>>       #    -----------------
>>       #  => started at: deactivate_file_folio
>>       #  => ended at:   deactivate_file_folio
>>       #
>>       #
>>       #                    _------=> CPU#
>>       #                   / _-----=> irqs-off/BH-disabled
>>       #                  | / _----=> need-resched
>>       #                  || / _---=> hardirq/softirq
>>       #                  ||| / _--=> preempt-depth
>>       #                  |||| / _-=> migrate-disable
>>       #                  ||||| /     delay
>>       #  cmd     pid     |||||| time  |   caller
>>       #     \   /        ||||||  \    |    /
>>            fio-2701523 128...1.    0us$: deactivate_file_folio
>> <-deactivate_file_folio
>>            fio-2701523 128.N.1. 10382681us : deactivate_file_folio
>> <-deactivate_file_folio
>>            fio-2701523 128.N.1. 10382683us : tracer_preempt_on
>> <-deactivate_file_folio
>>            fio-2701523 128.N.1. 10382691us : <stack trace>
>>        => deactivate_file_folio
>>        => mapping_try_invalidate
>>        => invalidate_mapping_pages
>>        => invalidate_bdev
>>        => blkdev_common_ioctl
>>        => blkdev_ioctl
>>        => __x64_sys_ioctl
>>        => x64_sys_call
>>        => do_syscall_64
>>        => entry_SYSCALL_64_after_hwframe

However the contention now has shifted to inode_hash_lock. Around 55 
softlockups in ilookup() were observed:

# tracer: preemptirqsoff
#
# preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-trnmglru
# --------------------------------------------------------------------
# latency: 10620430 us, #4/4, CPU#260 | (M:desktop VP:0, KP:0, SP:0 HP:0 
#P:512)
#    -----------------
#    | task: fio-3244715 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#  => started at: ilookup
#  => ended at:   ilookup
#
#
#                    _------=> CPU#
#                   / _-----=> irqs-off/BH-disabled
#                  | / _----=> need-resched
#                  || / _---=> hardirq/softirq
#                  ||| / _--=> preempt-depth
#                  |||| / _-=> migrate-disable
#                  ||||| /     delay
#  cmd     pid     |||||| time  |   caller
#     \   /        ||||||  \    |    /
      fio-3244715 260...1.    0us$: _raw_spin_lock <-ilookup
      fio-3244715 260.N.1. 10620429us : _raw_spin_unlock <-ilookup
      fio-3244715 260.N.1. 10620430us : tracer_preempt_on <-ilookup
      fio-3244715 260.N.1. 10620440us : <stack trace>
=> _raw_spin_unlock
=> ilookup
=> blkdev_get_no_open
=> blkdev_open
=> do_dentry_open
=> vfs_open
=> path_openat
=> do_filp_open
=> do_sys_openat2
=> __x64_sys_openat
=> x64_sys_call
=> do_syscall_64
=> entry_SYSCALL_64_after_hwframe

It appears that scalability issues with inode_hash_lock has been brought 
up multiple times in the past and there were patches to address the same.

https://lore.kernel.org/all/20231206060629.2827226-9-david@fromorbit.com/
https://lore.kernel.org/lkml/20240611173824.535995-2-mjguzik@gmail.com/

CC'ing FS folks/list for awareness/comments.

Regards,
Bharata.

