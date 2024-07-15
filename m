Return-Path: <linux-fsdevel+bounces-23657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96F930F47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 10:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9EB1F2116F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F91849F1;
	Mon, 15 Jul 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="07gYJqQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C751849C1;
	Mon, 15 Jul 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030573; cv=fail; b=nJ/IkR8zNcH4FKi9+JBck91XeT3Yxb4mmX+gLERX402dH5t4944RMVunsrBQ5x1or1Q+WrFQBxBZ51+Y679VjhKOXyt/5fcfj9JaamTfOYyjVOqjhD3lDsr3Eo7GWUHTAFlpZt18fmddroZpJEpRqEeCncfilp/MfQ2etCxdmOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030573; c=relaxed/simple;
	bh=EaLXnNbC3BfGEVr8XNbLUfL40Zg2HDPgkOdgtSlrJ7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1Qhw752TPjccUnTmqTkRIMXqxMe56Lm243ARUKaG6noqW6uc/fuO8LRuuiaR15nV58oEnjt0Zf4MS00SY2qURZ9NPYZNYlAmEHllHPRfGUEHstk0IuoTRggD6ZKF6iwbH2YLjUNonpUpruWT9MzDXzkLsw5HCIKOhD1j4fWSrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=07gYJqQV; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9dCjUs7FjQKYQTie23lLdNRujSD0dy5c7tt+VXfO7A8qPWzkRpNnl6PyO6r+reHDknYqLgRhHDRGcXCM8nTgdjaWluu4VQ719GTTu3LH75QBbHkCBlZOYIpsKvz9uXzhFXpg0cWAzzwHSpZevJq9EXS8B6c+xYl5Q+FFI6COY0H6FevNKCzqZYcm2ORO8sqO7Jef73bwPHGc8H/i9gqnW1dpUxL3tWA6tHbP8Xfs466JiQW9/T6YY+LLMUQUo+IxdRKU72WgkLPd330/gferJGxXkMksS7GwCbmLFWYqdfccGaCF9tqYoJD40ArSrflRUA8wPGuGMKrQ0S0qonPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAB85UftTvFs3ZEmavLLWRMCqqDJUIwpNWWFFzZntAQ=;
 b=Hwaxy2nPS6vVhUkBKUhRwpxi/xE5FlrlR1Pb16eb7GPRcqzlaiGltA4FRd140ORlZj9wj79P0960+92ShYr1Y2WcALFiJ8KrOq1HAbI+dRUPgMqJlfq1mEe8EYOkSC6UMlHNKPoXFO/H7+emTbjlLp5Be/Hm6WkLw61jLM5rKnuuQ3twLOtdbyYPgPuvDJllPrjJOkI/7IFE/Dk0RNp4SdezbBtVG3GN8hZyzk0S+sah5VQgr+ii4CFEfM9BfH2Sid6mXEVm6KpeNhxw1COvkMxKp7EYhEiupIY8oz3Uw0ZSW2bK/VykO6N+fPNHrYP2CPHGfegko+6U0GznqLtcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAB85UftTvFs3ZEmavLLWRMCqqDJUIwpNWWFFzZntAQ=;
 b=07gYJqQV+Sd4kYShE1TOms2onbpZHlg/hED61LwjioWz3KvuKY4SaN/ErFc9qX7b5QPaIOQ/K8I8u6huzJKIePcxRpTSNv9HTMUZxZ9a76aUbsKgolIi8RvZpiFr2Xj1s3QIphWeXp31B8ZOcgb9Sk4/X9jSDO1VAQBz4MLh8Iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Mon, 15 Jul
 2024 08:02:48 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 08:02:48 +0000
Message-ID: <f6ba51c5-e2e0-4287-b995-8a7dff59d5b9@amd.com>
Date: Mon, 15 Jul 2024 13:32:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfs: use RCU in ilookup
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20240715071324.265879-1-mjguzik@gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20240715071324.265879-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0231.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::7) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 949ceecb-ea63-48e4-c092-08dca4a48483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUlScEFyR04zL214b0Q0ZzNDcEI1YkFMb2QyTVRrU3hwaDlUT1BremtLcCtt?=
 =?utf-8?B?UUNWRWVvZXNHVlRSczZVdkhTQ3VjUk8wb1RoZnk3Vk1TbmRabTkzakhWT2ZF?=
 =?utf-8?B?d2lnMCtXTXhtRHEwQ3lxVi8xeklIUWovQlRGTzA0Qjc3SmxqSytZNE1UNmZm?=
 =?utf-8?B?RHZxeGxSalRxbTN5Vm1QMFhiYlQrYmdLOVNJRjNLSEdVcE12dlRzSEhJbzNu?=
 =?utf-8?B?OXgyZGdDSDFlUkRWMXVqanlwZzNSUDRMVHZvd29jMXh2cFc3S3Z0MWFnMThN?=
 =?utf-8?B?SkFHQmFTb0lxL1Y5YlBGZFM2T1NBSmpEOHFmNDFCRjI0WjFrNFlKNTQzQjRV?=
 =?utf-8?B?S1pzcUlGUGdXRXNFcHFhazhxcjR2eDdqdnFUMGlmYUNBNmo0dVV5QVVqL1J6?=
 =?utf-8?B?R0xNM3FrWE10ZjdBbkRjVXNXWHppS2R1QnhsMzM3V1g5MUxxU3J0TjVGWXgy?=
 =?utf-8?B?UGp1Q1lGSDBXRXhVVlFLM2xWSGxtWXVhb2Q4MkpaQnZKTGZSVnBwSTl0ZXdi?=
 =?utf-8?B?cytzSnNNTjNrd1dFZll4WmFKc2p0eHliLzRjSWw5ZjdoTVFYWWxCZHM2NVh2?=
 =?utf-8?B?ckE0eWhTd1dWT0FoVkkxNjdRSDUvMFIxM0FOTzZ0cENCT1V4VDJNS21iMHB4?=
 =?utf-8?B?QVgvSFdBVzJoTzhuYUhRaTdtMUFtZ3ZyVWpRbkVNY2x3S1p1UC9PYXJNeC9m?=
 =?utf-8?B?YTJhb1dwcUNFZ2JGVUNxM2hhYm1xcTFvdnZ3cmEzdS9oQXRFZ0U4eEUyaE1q?=
 =?utf-8?B?dFpsYkRkcGN2bi83aE00K010L2ZNUE1aNWtEQjE5NmJLeEZEQ25penJCVkRk?=
 =?utf-8?B?bFdpekErdVd6QXJ3eWRIM2l2elNyRWZUOVZEZ3BWVEJYem9SMlp4SkdZRzlh?=
 =?utf-8?B?NWh4elpCbTZuOHBWS1Z6cCs3OFl0OEZzNTdsUkszWWNKZ01XZ1Nwdk96UUVo?=
 =?utf-8?B?VEtnWU1oNjhEK0NmeFFQOGtKeWhyelFwRXFIUGhrREpWQ2Q3MU52NC85YlA2?=
 =?utf-8?B?VWJrUVgzQ3hFTzVpRFkxN2l4QWU1TzlVKzVLZEZVQlJpSlBNb0ttODFWNmR5?=
 =?utf-8?B?UFFQZTFWK0t3VFRLVVRlRDZYc3UyT21DdGJiZGFCWUg0SkVTNzYxL1RoTkZo?=
 =?utf-8?B?MTBqSXRMaEFNM3dENEpidWlZQzNuRGVOTFVCNWlNNFJEQzBpQTUxRlFmWnh4?=
 =?utf-8?B?WkFmODRVd0pxRkxlTmRxalVhek5SakdHM0c2Y2lHTitWSlhXUU9WS0l1VTNs?=
 =?utf-8?B?cjl1R0RXUElKbUhSZExkdFI1STFMNjlEMmpaU3BvLzRvc0dOTU1scDBwS29U?=
 =?utf-8?B?MTRwZzg3WURzb1g1alRhUmN5U3FLQXMwUGh2a1E2NldCUU5NL1NCV3AwOW5n?=
 =?utf-8?B?QXg4TTdHaTl4aEtuWlp4QTB1YUV1SzJTbWJKYlI0dnpYd2cvbFpkNUVFZS9S?=
 =?utf-8?B?anVMTk03U0JJUVV3L1NXWGZNTnBKNituNERqZjNvN1g1VXFTcUNqdm16MVNT?=
 =?utf-8?B?QWplTmdUeFY4UWZyNk1hK29mZ2RwczUzbit2ZWxJY091WlQyZU1DQitGbG5H?=
 =?utf-8?B?cFY4UkFWVkRHL3Q4Q3E5Ky9jSFlnVm9FRWhadEhhUzhGaG9lKzVDb3BHcUU1?=
 =?utf-8?B?dDBNbmNEbUxWbWJmNCtxekRTK0J3MDA1cUlxVEl0TjVydXlaWnowTklXdThj?=
 =?utf-8?B?RzNLS24xM2ZGUlJIUVE3N0VtbmFYN3NBd0hMK1FBS0ZCbGNBVzFDTWJrNWNq?=
 =?utf-8?Q?pw4QM4Wf31mAK63eDLlmFkv0goIRL0EAwfL5aHK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akdOcWZIQ1ZyK0Jvd2huU01rR0ZJUDhyOG9seStaTFFneW9mODJEdk91VldL?=
 =?utf-8?B?dGlzY01ha3JFaHNUS0ZzaDNQbnBkZDNueUdBYU1FQkE1T2g0WS9XWW5wL1h3?=
 =?utf-8?B?Q1BIZ1ZtVDgwSFBrU1A2NTJQZVJmTzFQQUxVekRYQUYyVzhsT0lmeFVJN2N2?=
 =?utf-8?B?SDRrUkZqSENzd3RZNHZZbVRxcHh6Vko4ejBuUWxna1dFaG1EaUJkM0tTUmtD?=
 =?utf-8?B?SGNVcHpaczRKUjlkOUNEdUpuZ2tsWmlMNlVmVHh1REJ2MGJ5V1F4QmlNZHFa?=
 =?utf-8?B?VVh6dkdHRUxVSXhSeHQrb3FONFpQVDd2VFJuNi9zOUJZei84M0k5R2NXR01q?=
 =?utf-8?B?Tzh2akJXSkRFZVFialNnVU9wZFNtdDQrTHFyait1VjBacGdIVkNmZjlrNGwr?=
 =?utf-8?B?a2UrbTExaHNFME1xRFB4bmRtZUF1MTNtNTVRQzBFZHBtc3JjeFg1U0t4U0w3?=
 =?utf-8?B?SVIrODI3Qm1pY012cmVKZjU2TjFUbzZSa0xNcDU2WVltOGZsbEJMYVVJRmYy?=
 =?utf-8?B?OFV4QmF1YzJMaHZESGgvV0lBQ3VUYWR1YjZla3pWSFllUklOL2FRczQ1UDk5?=
 =?utf-8?B?SVFNdUdvSTA1ZVZHZXQrYzhIaXJXR1FEUytmWWJJdG5VdUxhZ0dZYzY2elF2?=
 =?utf-8?B?VUlJRXRCSUkxL3NNNVhFbVNjbmxkVzQzZGxKa0R1VCtVbHdQdzI4U0ZMWCtU?=
 =?utf-8?B?UnZWVXNBSllSMnZwNXA3SUlmUlJndURtaHdlNUNFOTlCQmZySmxzWHRTVHJG?=
 =?utf-8?B?WUl2K3p3VHVjdVdidWNuSEcxVFdPZ3hPdDFtZi9oYk14eldua0pYZEU4Rjgv?=
 =?utf-8?B?V1I0M25LZzVNWXA4TXFaQTNlNUxXbjNmWVdWckU5N1dsNVRkdEJNN3VibW4r?=
 =?utf-8?B?QW42YmN0SnlISDNUL0Z6Tkw4TnNsNm5YYU9uMnNtdHlIS0dIemRQaGY2OXVW?=
 =?utf-8?B?YTFvRGJ5ZUFTby9XY3ZiV211S2pXUWRqK0pjS01SajFDZFlvR1VSZkVTejZ6?=
 =?utf-8?B?SmpWQUhZQi9Na00xa21OKzB4SmsxL3FTaTkzcFJRN1YxRVorMWZXdVFqZnVN?=
 =?utf-8?B?V0VqbFRCQU8zNkZGZFNzNVk1ejFyclV5Nk00WnN2SlBMQ1d1THFiUXhxTDNo?=
 =?utf-8?B?YVRUOHJaMGRnUGRFamNQTnZ0SDk1ZGo4NjE3aVhCRnhaYWFKeENRMkVxeFZx?=
 =?utf-8?B?U1lCUkREbStzaVpHaEpjVjBia3VoT1IydnlINlByMHQrSFoyUzZpdWFUQmNo?=
 =?utf-8?B?NlMrV0UyL0lFc3o3Umhuek1ieC9pMVNlU1FGd2NsQ3UyWWo0K2FwZTlJRFN3?=
 =?utf-8?B?anRwd0JnS2VvZWI5Nks5ZDZXQU1SNFdtS2RQYjJDaVMvSzhXbXVTUlZUZmRQ?=
 =?utf-8?B?OUw4bWlTelNNRDdXZERWNFl3eW5rT1c3c3Myd2J3NTZDa3JvNCtrSGJpV1lv?=
 =?utf-8?B?c081WENma0ZrcUJtS285S1BMZWoxUE44VlRxOTYwVXNYL0JKZVpzZXRGazYx?=
 =?utf-8?B?anlYZUlkY3VGeDBSN0RKTnFBQ1BiaTVSREJWc3hjd1pQN3IzUWhVcDFnNUJl?=
 =?utf-8?B?UHBFL2pVYklzckExVjFhb0E4S3VYenhvRks3RW1kdEFkcjNmVTU0MWd1d0xo?=
 =?utf-8?B?TjhoKzBvQTRUZm5wQkxRVGFVdWw3LzVXT1J0UzM1cmdvZndHM29NMW9FbTBy?=
 =?utf-8?B?d2ZuRENoVWJwNVpvTE9WdXNlVFE1OGhIM3lpd3BXbENESHVtbVhDWFdsbjRN?=
 =?utf-8?B?enpobkI1WHpxWVpYTGY0TTlWbGFOQnR2dzFueDlMT25kYlNjODBIYmpIZjJV?=
 =?utf-8?B?UFpKcXFWNjNtbXRZRng5S05IQnMwRmlFSlZWckVtK2JLWFVPZlVzUHF2WFZE?=
 =?utf-8?B?SFVMeG9ucVZJY3ppNWpxWVJERHc1VDBGdmtEVjB2NFJ1YlpQbzJVRjNzSzZE?=
 =?utf-8?B?Q0F5TEhwSFB4aHFlanBGYWhreFVrZ1RvTGlKelVqdVdwUUxsV1hreEdITUda?=
 =?utf-8?B?dXVmbnZGS3ZmVVpaK2NnL0dINFNwQkZueXE0YVBGVkY4M29TcU8yTGF1ckdP?=
 =?utf-8?B?aUd3dTlhUnBiNVpuQngyOEFpVmFwaEFtNjJkM0VDL2c3QnkwL2lCNTB2cHBr?=
 =?utf-8?Q?7IrlhMT4W08VV8rDGGY1/CCiv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949ceecb-ea63-48e4-c092-08dca4a48483
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 08:02:48.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXcvU/nG9ZJnxnxXbhL6ugfk1gWQ33GxjLyEVNNucRKFw5K9h0KClWUuaVwl4Uc6O0g813JAwoniWEkEs9v13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794

On 15-Jul-24 12:43 PM, Mateusz Guzik wrote:
> A soft lockup in ilookup was reported when stress-testing a 512-way
> system [1] (see [2] for full context) and it was verified that not
> taking the lock shifts issues back to mm.
> 
> [1] https://lore.kernel.org/linux-mm/56865e57-c250-44da-9713-cf1404595bcc@amd.com/

Mateusz,

Just want to mention explicitly that in addition to the lockless lookup 
changes that you suggested in [1], the test run also included your other 
commit 
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.inode.rcu&id=7180f8d91fcbf252de572d9ffacc945effed0060 
as you had suggested.

Regards,
Bharata.

