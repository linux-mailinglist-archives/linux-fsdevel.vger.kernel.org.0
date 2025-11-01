Return-Path: <linux-fsdevel+bounces-66668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD2C280A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 15:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBCE3BA536
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4072F5330;
	Sat,  1 Nov 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YDMFem7B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73252E54B9;
	Sat,  1 Nov 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762006626; cv=fail; b=qIdh695kU4VBjrguoUA25F5gPqeaICvD3/D7kGPDoCN8vONwkS+ssRclobDxjrH2qPT2jNEfHVEHbssH3/SZBKMiBebL96GlFSUJv83UgG6CCRls6oCayX04Okv5rHT9pdMKVOZ4ZFF8lmpFNsRqmQNmtpihjgIV8RZ+EShQNls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762006626; c=relaxed/simple;
	bh=aI4MtqYeVF2RQ7E6gerN7E/DzDth+2rxhE5WqDcRfWI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=UpMr80GdNiroPLQHirP0Zm6qL5bdXnTz57+GSePM+jt54yWohNQWutRj9xBqQSbvl37iokNPr0/by2pBBG+qIkxq6lRLYxdXocHBQLq/gnvfpZYuZGMfowP6CtHtnGMSYzjiV6H8UtUtT0LGfyjuWw7RlJayiVIl/i07Og/bl2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YDMFem7B; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nu4JrjJYwx7mOznW2mEO1ZRKLwrEfqZ1pY1fvV/oCE7Ca9OZUx5otU3UAQK8liDOCZHmiekratcr3q8RGrNLfVDxYIveGY8d5+JBcOWGY0Y5WCgIcXFwJP8h1YYeyRD4BR6lSkpxWDxG1/ju697OpbzcxP68aRkwzt/oaZJgtMeL0yR9JM4+Hxe3uux4TctkEU+5j/IeP7wMELCVpn5BiKOTiR/JskNdeXN/WlwtG13ewylOQdv1toi75a6em/nVO+zlQnm7btzgx6hwPFITmR8sbyS6C+MWs5OVg3jvpvFBR4GSS8fy5475Bdo4BA3pmDU1LhAyP3wFaZh+I8CM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGRwmV0NZiyO1LDD4L3xQ67o4xIp3YgE2ZXRx2xbnwQ=;
 b=kYf5QEg0rTws2koYDgNEcHz35gQGWS0gJLmqhxRdZ7DZD/Q9G5A5OrdkyprQJI9hHYDrHF2/UGpLwcU1PVRwQZnoFrIjep/yNiZswaRoVZtMH+HVtX7lJ6unmFmRXm3/8J4X7aT9Bd1xiA8dfL04FZvdIudIw8k1Tz7EiKRbCjr6beudtdGjJvl/IoL83OZ2+/PuuNWE2PFiqpqCmqNzauqVUSdpm1bG4cuGEZsxisYgC+smZquzUxt9OHGSRoPeo8C4TaK4kjPlDi7cMsJBI40MESK06mvbh/mYSjf+bOoMnORZMaThpIxk3WfDUGqK+PlyvtSOmRfaFBLpf4ye1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGRwmV0NZiyO1LDD4L3xQ67o4xIp3YgE2ZXRx2xbnwQ=;
 b=YDMFem7BSXjo8O8LMGGakIuUwmBIAlNBO94pFdOLYDdeei5r3bhSG5YEgehME7u1sRCvko0SSRVvZ7kJluDVruo/7Tl+nSOwEvGVSs2YSkEZ1HrvgBivDYVwD2Tiy9B6Qkr+XY36XuaHGrYtOnbnZRBS0/g4Lt+U9vIgNLfR1hArjkLZspUderFu86e4c2h68IWTChHjVsdu+JX5c/5otZusFJ8Q8f8o9fpDvyc7CoXFSeA/LHHytrLbc9lXCvziPscIG4yXfTABpLhO6LGJG42c7ij8XL0ReI/g7w3NDZVRmH1uU4XbshxWjSWQ1x7HhziiX9+z6/tvnBuqvFkYSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 14:17:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 14:17:02 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Nov 2025 23:16:58 +0900
Message-Id: <DDXF7TVFW1TE.2X34Z4X771Z73@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <mmaurer@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] rust: uaccess: add
 UserSliceReader::read_slice_file()
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022143158.64475-1-dakr@kernel.org>
 <20251022143158.64475-4-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-4-dakr@kernel.org>
X-ClientProxiedBy: TYCP301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: a4be89bf-7743-4136-e73e-08de1951539a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWFKUy9hOHQvNlZheHJwVGFOMEZPMlM0R0xtV1hQS1dDMVdVV2NGTjdkcWl5?=
 =?utf-8?B?L1RCWkhCdEdRcTJQd0NsV2xvYmMxVTlwMTRpeEFBZ0lZSWJDbytWMjBGWUNG?=
 =?utf-8?B?SmlialpsYlU5T2JFSnVLaVJoRGtVeGs1elZSVm5VaExUTkJOSU96ajdvd2tu?=
 =?utf-8?B?OTRzTDM5aXJwdkhKVWtrQTVCbE9peGhETkdoVmduejN3Z3VoZzZaQ0Vzd3hE?=
 =?utf-8?B?UldzYXExWkRGQWtLM0N6VndCb0owSFpTSU5FQjlWZFlNVzlqM3dFdkpLOFU5?=
 =?utf-8?B?YVRCc3Rxc25zWTRhcm9CcWdoUTFRR0ZHZTB1MG1FT24zQ2hFcHhHYXptdGhP?=
 =?utf-8?B?OGY4NE4wVGxhbUFWdjNUTmhXcFBtOFRVV0x4MWUxem1ZelF4SlpsUnoxSkw4?=
 =?utf-8?B?U0NQaWNoRlNvY0NESnRzSHNmR1RxalhjUlpPN25ub29aTjdmN3EyMm1uTC9C?=
 =?utf-8?B?bHU3SUNpSlp0cVJxQkwyTXVOQm9vOFJFQm5UQkh5Ym5tb0dNNGVVZ0ZDcVNV?=
 =?utf-8?B?YWdYS1ZwZlBZZG1nM21LQXJyenpzbGpUU2Y5NDNjR1Y5bHZ0RExOSHNkR2Fi?=
 =?utf-8?B?ZXhld2w3azlSK3ZUUnpYRGRNOGhmT0pCb2hGNU1vSmhqRVVhTHJhWG1MVGJI?=
 =?utf-8?B?TnRVTkJ3a3YvWUl1OWNrRlhKZ2R6aGZjUk5YdHZRY2pxRmVodGlhZlRBOWcr?=
 =?utf-8?B?cEt0TEtuSzFVemRWblh3cG1LZ2FPZ1hXbWMvc1hzbWN1bXNiSzhnNG9oM0s4?=
 =?utf-8?B?UURWbGJBQTJkcDc2ZU5HKzNGakxwclVwenJIaXVZcGlqTERGK3Z2Y1lMamox?=
 =?utf-8?B?OW5mUlQ4UTJ6UGxkem5VYUVHTE0rUE8vSHhOckw1UHU4QVE1S0pIWHBqanI4?=
 =?utf-8?B?c3VhNlBWWFZaK1BDU0tQRWl2MGxZQmQxamdlYkpLNkNncFYyT3JwSHlLK2hI?=
 =?utf-8?B?ejlrL2grdDhkVUpFRlJFRkxUUkNzdnFXWVhDM1R4cDcrRjI4N2tGNmZRbW00?=
 =?utf-8?B?VGRUT3B4TU5kb2dMWmZXditxWWJpdjYwRSs1anQ2Z0hTb2NMbStPMFp6MThu?=
 =?utf-8?B?cGwzSi80MjZEOERJM083YmxKM1JJZDVrT1JsOTdLdVVNK3E2SXBha2hIRzRs?=
 =?utf-8?B?WGtTK3hQQkJrVUxXU1VuM3VEQ0ltS0g0cnpvVmovTlFiaEYvVlMyM2hZazBH?=
 =?utf-8?B?UHQxRFJFZmg3UWdiM1ZqcDZ5NStqWmlJNTZIc3JEWCtVby82bkQ2dEFnR3M2?=
 =?utf-8?B?akJRc24zUm1Rc3QwVnF5Q1NYemt1UmxHOS9SUWlGazRmZVRmZnViWmprTFlB?=
 =?utf-8?B?ekV2cCsreWhsbHNVNUtZcjRPdStsTnJmY0x6eWxnMWpFZ3NObExkZ1RzR2hB?=
 =?utf-8?B?NVc2bXRvaXRiVXh0K3VYTSs5c1Z3Tnh6RUI5SjgvaHFtNXRFNmZiak5yYktT?=
 =?utf-8?B?NWRZWmxhRkh1dHhldWR2bytFZGJGQzM2TTF2YXZCdVA4WEZJb0ROMlpNY0sr?=
 =?utf-8?B?OWdEQTUxbHhTOCs0U1RkSEJiVkhCKzNyOXFRUFJxTUIzU3BOMDZrU044L1kz?=
 =?utf-8?B?c2sxalB0MkVDMEFDRlN0cGtTWm52YWJMZUZmaG9Wcy9td3dvUzRkTTQvcVdh?=
 =?utf-8?B?QUhxVW90bVJiM0RocnI0WnZTQ0xDUmFKUDVMZk1ZMFRSeHRwM0Q1WEUrelJj?=
 =?utf-8?B?UG5RUWhabWtMblJwVFF5cFZlY0ZtVXpJR3g3UEYzVGdSSU5FYnhndzRrb3V5?=
 =?utf-8?B?VjUxL1VLMnk3ZkxxdzJjZlVlMUdWUXRER3loN1B6Y2FvU3Q0cDJBRmtzYUx2?=
 =?utf-8?B?bWRqTnlCcWFuZVJGN3NhRnAyM0RvMkZBUlhVY1BqSHB1R01zQ05CUnIwZEJn?=
 =?utf-8?B?K0dubFRQOVZxeTluQW9vYUVVNExFVUxrbmp3L3hKZ1Z2QXJteDlHRUZpRll0?=
 =?utf-8?B?VHZaMllwSkh6NERWQ3pvaGZYdjZDNXlSVkJEOGVjNi9QbHM1anhWTEtZeDdP?=
 =?utf-8?Q?u2Ntp4pOrdm+Kkts22LjXdyACprY0w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2FCKzRVRk51RHVnbTdHaFNPYWRaeTBVRzN3VmQ0WEFkc3FDYXZXeGdGQXRt?=
 =?utf-8?B?M244NmNIWUgvUU5QNzJ2QldVMU4xR0dtdTZMN01SU2d1ZTV3MVVHWi81THhV?=
 =?utf-8?B?Vm5MdTFsRXBpalIxUlZZeW4zR1RMaktGQmU0Q1hFUXdUcHYwcGxGcGtNMmI3?=
 =?utf-8?B?WlYvcmFjdWNSdk8xVEdpMHlIc0tqYklCSkpjMlhraW42V0FacmxHRkYybmdi?=
 =?utf-8?B?OTVudU5BdTNGZXNwSW1Damo5U2l5dDBtKzZhRTRReGgrRnZSVDQxcGduejk3?=
 =?utf-8?B?Qmk2VnBDemU5SlJLMHhIUXFFL0RWNkZNNXZ2MVdZTzlNUGFTZTYxOXpuRUUx?=
 =?utf-8?B?Q2pUOGF4RmFHVU1VL0FPSHdHK3NQVkFaQ3F4UWhSRTRNYkROcm1QUFhVYVgx?=
 =?utf-8?B?UmFtUThudHdFNWhkc251YnRRRTl2SHhmOFdmeGZDcWxmRnFYbS9Db0pjNjFC?=
 =?utf-8?B?NEZQN05oVUFTOFZSZ0lrMVZ6elk3WmhONEdwQmVua1M4TzdaZVJjR0pBaDdP?=
 =?utf-8?B?Y0VWbmtsMUo3OFNLbHU4TzBLL3lVc1YzSGdCaGUxanJsdFNUa1FtZ21DVGRW?=
 =?utf-8?B?amFkQXU0ZmhUU05PQlVQcEczS3A5S1JtY0FGNWJET2gzY3laZWRnS0ZoaUov?=
 =?utf-8?B?UDBtSGRjUGZ4L2lHakdLaWNrdWZMOUQ4VDgxcDV5WjZhTHUyMXBiMjFiczQ2?=
 =?utf-8?B?N0gxN21mV2ZCc2xYM2NiYlZFWGNmcEdzNHNPem1HRXdRdXVuM1BaZVl3Q25k?=
 =?utf-8?B?T2I0STArYnBYUFRqUXViQUp5RDc1RFNWdjF3eUE5Skh2NUd4dzlKSDIyZWNY?=
 =?utf-8?B?RkZJNVBCV1ZrUlpid1FXNXhhRWVaOGVKdUIrckxzRElxT0RUVlR6THhjUTB0?=
 =?utf-8?B?M0Zqa1c4UXJIZFIxYTRPSmFVNXhaWmxhclZRMEhwSlgxcnUxSGd2aEZ0dVpJ?=
 =?utf-8?B?NENZMitESG1DQkpRZHR6K1ZXeStiNVpVaHBMUnM3RzBqVVJ2S0xkK0FvbmFE?=
 =?utf-8?B?dHJXdHExUi8yYTJFWHNBQUJWeSszaUpyWE9qTkI3d2F0dWFOeVVnUFFOeU9I?=
 =?utf-8?B?bnZCVGdGZVl2K0tMaHdGR3ROSFA4ZDUzWTBSRnNrZVk0d3NXRkE5dzhBbXdv?=
 =?utf-8?B?bW9seXVOdUNMczZEZy9xWnQxamdmTnV1M3o5Qm5XQ2QwV3lMQ0wraDVDV0RU?=
 =?utf-8?B?ZGR6MnF4Ri9JN3FVZ1VnWnR1djBLam0xTVlYTXZBSDRkbExnbVUvYUY5bjdH?=
 =?utf-8?B?Z2NoMm16bGdVbXY0TVptMEFnQWVkY3k3Mng2c05SK3JnNnFzUlI5ZTFiS09B?=
 =?utf-8?B?ZlpmYUw3L21VRy9ncjZtMDdtWFV6Yks3VDJGRHpkWTg2L2F1bTRnaXJvVWJq?=
 =?utf-8?B?dm5lUWZ1eExmWFlXUGN3a2xjNlI3UlJ5R0wzaThUR0p0M1BTV0JaRWdnT2ZV?=
 =?utf-8?B?NERWclNQaE50KzBNK1RCSmVzQ1lnNlBEN3VCSUlzSDhmcWd5YlJITDBYNExK?=
 =?utf-8?B?UW10ajFlYlM2QjZaejJWSmZaZ2Q3OUt5eG5XRW9zN3RqUWl2aFRMZjJ3WjVz?=
 =?utf-8?B?clZSVk9OdnB0Y056dEx3TExwMjVBTkV4ZlJaOXYxVzc2U1FCL0c5bENYSW90?=
 =?utf-8?B?RFBRczlMaUJhTFcvL3ExdXNGOU51NzdaR3BEOHRJdVdRV2hva01vMTJrNDlK?=
 =?utf-8?B?ZlEzb3huc3ZWN1VVVHRLaWtSREpVaC9ZMUVyT1JjK2NtV1JtSWMwbWFhbHY5?=
 =?utf-8?B?cjAyNmR6a3dQRkE5aTFpOFZ0aVNFc0Q5NmFTQVUzMytta0xRZGw1bmNibXF6?=
 =?utf-8?B?T3ZvZ1R6U3ZaZCs2L05rN2psS05MZkkvekxUV0ttTXpuZ0RKeTBUNUt6RERH?=
 =?utf-8?B?ZnZKV3pncTVGTkhjTkdnL0p1Z29pcHp0c3JFY1NEbUErZEhtYys5bVpUV0lU?=
 =?utf-8?B?Vk9FZ0g1ZTVuQys1VGpFcFI4cUlzcUJlZHRSUzY1WTlqVGNOR3U4TUJSS00w?=
 =?utf-8?B?Qkg5NVZHODFrcHFPU0duRy9YQjRhODA3U0cyMTk4K3JBMmNMNGdhS05DZEV3?=
 =?utf-8?B?SGdSd2l2NVBCVy9HQWZVanBzS0x4eHk4ejB6YlZpejU2WkxiQU5rTUpVV1lC?=
 =?utf-8?B?eUhtMGt6c2RaRzBTOEVQck8xZGlsWkFCenZ4RmlDVllONVpnV0xOZTVSOXBR?=
 =?utf-8?Q?ik8RM/goHHXK2oGyOT1/GE5HR+exkXKnR/0xfIbUFlyk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4be89bf-7743-4136-e73e-08de1951539a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 14:17:02.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TS0uolDWyixnhDI9sX0hK81Osk09OKYy8T9z0GkqX8KPiurdjxz17rfn5JprGsn3t7I1ncRngU6rpwDryWvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740

On Wed Oct 22, 2025 at 11:30 PM JST, Danilo Krummrich wrote:
> Add UserSliceReader::read_slice_file(), which is the same as
> UserSliceReader::read_slice_partial() but updates the given file::Offset
> by the number of bytes read.
>
> This is equivalent to C's `simple_write_to_buffer()` and useful when
> dealing with file offsets from file operations.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/uaccess.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index c1cd3a76cff8..c2d3dfee8934 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -9,6 +9,7 @@
>      bindings,
>      error::Result,
>      ffi::{c_char, c_void},
> +    fs::file,
>      prelude::*,
>      transmute::{AsBytes, FromBytes},
>  };
> @@ -303,6 +304,30 @@ pub fn read_slice_partial(&mut self, out: &mut [u8],=
 offset: usize) -> Result<us
>              .map_or(Ok(0), |dst| self.read_slice(dst).map(|()| dst.len()=
))
>      }
> =20
> +    /// Reads raw data from the user slice into a kernel buffer partiall=
y.
> +    ///
> +    /// This is the same as [`Self::read_slice_partial`] but updates the=
 given [`file::Offset`] by
> +    /// the number of bytes read.
> +    ///
> +    /// This is equivalent to C's `simple_write_to_buffer()`.
> +    ///
> +    /// On success, returns the number of bytes read.
> +    pub fn read_slice_file(&mut self, out: &mut [u8], offset: &mut file:=
:Offset) -> Result<usize> {
> +        if offset.is_negative() {
> +            return Err(EINVAL);
> +        }
> +
> +        let Ok(offset_index) =3D (*offset).try_into() else {
> +            return Ok(0);
> +        };
> +
> +        let read =3D self.read_slice_partial(out, offset_index)?;
> +
> +        *offset =3D offset.saturating_add_usize(read);
> +
> +        Ok(read)

Not sure whether this would be better, but you can avoid the `read`
local variable with the following:

    self.read_slice_partial(out, offset_index)
        .inspect(|&read| *offset =3D offset.saturating_add_usize(read))

In any case,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

