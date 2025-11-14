Return-Path: <linux-fsdevel+bounces-68414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F6C5AFDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 03:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC303BC76C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07923D294;
	Fri, 14 Nov 2025 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="og0PVXo8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D91F5842;
	Fri, 14 Nov 2025 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086674; cv=fail; b=Kwp7xr/9FWcEJf31UUpLBFdtwCxD41knWsD1+Mii7bL9y0ciXRbApieXuu+3YlFQUUDoYUK6hQToeRsa+ocuyV28Jh7QknRH0r6q+LL/6r+y1hy9SA9j/ybm/+dMSWGtQfXAzCS2Sd9iICFIYbOxbDZcSRjvhM7DGc9TI9Yhgiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086674; c=relaxed/simple;
	bh=59DV98NBTLSKEnhQ4b/OzuPFYsqto5z9OVpo+/ezJc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OWMJYGcpXl9/ycfn4OqeNNZc2pvCjSSKIHUVWh52te98NWZ7JrQ0ZeB/+sYOGbwBaZx2pucoJDm0RUFeOb9BEvUyDDza08WQvJUyiBWsHD1qoDF6yXR9H6xoMPMbKwj1qbKGh7Ad/2MNloKnyQ6r3U4wuUJ7nP+hLb9ncinEx3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=og0PVXo8; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AE150QN2410002;
	Thu, 13 Nov 2025 18:17:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KLIJTHdXgv2IfSmg4UnBBJfMSx01Vk5HC/ZbCVwbofE=; b=og0PVXo8WBTd
	ld0hXmfNs3pS9c4KVvKGgWm5fmxxRxF6kIHLAiXKiLgPWB7DS32915ouPHRxziS5
	iepUKVt7CorZoFANpCyI18JSXBHiLPWGz/tZH5tcqZ6rcnptJbKjr7zngMF3zYvB
	dT/bwDAgazKTuSw7BWHlj1t+chZa/iusRT3AUznltwFWZFGmUx2wzCyoR9Cw8QOc
	V5LUcL6dWVJxNlN3CVBnoSmDRUqi9ij4hIY8/FxOPxdNQeIjnWVzd5eT2wQmUg+m
	gfCCoUJPr+m6R5PC2qPo5r+fCTIfRSvl5Xvc2mWDiRGzXwxh5tVSZ6qVG2/SKJXJ
	2a0GCWCAWQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	by m0089730.ppops.net (PPS) with ESMTPS id 4adr8a9ehy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 18:17:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wmd9ySpi0+JZ9ycdcKkqoFSA3k9WmypdBSypSwWXMWMiOUEa/jltRo9FNLcrRuFqCw9q8wKpd8UocxwDN9PkrWV/Ns5zfISRehNbqmd/8dcIakd4HX7M0pG4JcL0rNGdrW0VBLIAJs31Lqh6szNJxxIqcAcZXh8llu72AIDx5ro0oAqcfeNmDzTnz0OYsQqPaffhiw0tFsBMPoIFIQzPQT5IzciGpCNAVH1RiFSbl9TDYRBAYMrG5MzMgo3vw5zwdYemXKfIOdnbmTennsUTKT4V16MJh4GoWMdL2AxFm/KfpDexiZwAldkZZsq915BGb5p+hVflmf8xLCQhJpPnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLIJTHdXgv2IfSmg4UnBBJfMSx01Vk5HC/ZbCVwbofE=;
 b=ca3qXgu1Mxbj17tVKW4so5Sinv2mazKiHDukFbQgEnwsuG4lkR9oSTdTShXf64n1RS6mZ2CDJ9523TOdTQd7btdJWHTmcz0qaJRjAdWbXGfXDdzG8rzN7/6TwaB9Jkv27zZMyVzsNIfIb1ki8wM7nmytcOkstXS8lz2fjVmyI5t/qsxLwwDiKAfKJrJAQg7Udjr3O/+DVqNzDXZtnQfNKzzYOjbPgXeebrKgzi+7QTjEcGxCuTYxvgFVNulKg/8AstbdKYkpRWcehTih2d6/2wSseqLp7fpVUsmncwaeShoBugMz343Dt8wHdVME+a0GUFst/oxVnEweqhIkPMfIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by DM4PR15MB6034.namprd15.prod.outlook.com (2603:10b6:8:189::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 02:17:02 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9298.007; Fri, 14 Nov 2025
 02:17:02 +0000
Message-ID: <3984c9bd-2ac8-424e-9390-7170fdab3c03@meta.com>
Date: Thu, 13 Nov 2025 21:16:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [functionfs] mainline UAF (was Re: [PATCH v3 36/50] functionfs:
 switch to simple_remove_by_name())
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
        raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
        a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
        linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
        linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV> <2025111316-cornfield-sphinx-ba89@gregkh>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <2025111316-cornfield-sphinx-ba89@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0050.namprd20.prod.outlook.com
 (2603:10b6:208:235::19) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|DM4PR15MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6417f566-8f32-4773-ab84-08de2323e62e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm41YVg3aHJKQVlhMktwdjJIcUxKd1pMWGd1YVdoazVucVczRkdKM29OaEdD?=
 =?utf-8?B?Nk5kekJjM1AvbUlJUUdYVXo4ZzlXN09ZYVgwKzExS2E0U1loOGtsS2RXL0VY?=
 =?utf-8?B?SGttMDRlY2grRktDdktFSEMwbmhZN2dQa3RiNGRHQ2Q2aW9FeXNGRG5ZaE9x?=
 =?utf-8?B?S2xtQU5BTE9xV3g3d0p4Sit2a3VVL2d2WTA0N3gyRGhkRFFlS1oweDBJNDdv?=
 =?utf-8?B?anNHUFFRTlB5YWNsUFdQWU84d1ZFdVBlckVoblVxUjBucE5WOUFwUVNFWlJF?=
 =?utf-8?B?UVVHUktDRWFwaXdwYS9YMHUxR2g2b0IzYWY1NXJ4b1JtMWpvMzhwMGRNZUFK?=
 =?utf-8?B?MjltNldDL3pkZXFjUHpqdjAzbFRDNVQ5NDc3eDdxWmtNVG14N0NSZHYxSUpY?=
 =?utf-8?B?MGlLM2YrUWM5YW0zcm40WlY4TlJndUpNY3RaSFJrNzZaUWRxVnJPOVFzTzN1?=
 =?utf-8?B?T2tCTkFGbTFqZ2hkMXhpcDRIN2grRGZxZVdYQWJJbTNpVkdldm9tc2Y1blYv?=
 =?utf-8?B?bFo5UjVvRlMrd3NMQzFHZ29NNWlqSmsweU1rbTZtRnNWSFFrM3pwTmlieTJD?=
 =?utf-8?B?UXZlR3pKdU82L1owbi9GMms1R3lGckRCZGZ1TkpRL3l1N1dhV1EvSmVPQlFO?=
 =?utf-8?B?YW1pZzZUeENwaTdndjJwV1BxVEh4eEVDZHRpMnU1TGhiWEgvcGpMdUFDSUZh?=
 =?utf-8?B?UHRGWDhYTjZORHp0amdoYUx0NzZ5LzhlOWpPL3hFc0F3YzZGQjhVWmpJbkNY?=
 =?utf-8?B?MG1vdHo0MTJCcURGVEw4dFViOE1ha3BINGdzUTUvbUE3eTNYKzlRUUdnMXdq?=
 =?utf-8?B?aldTc2dXRGxBaWhHM0ZOaElTNG9NdHdMNEJlVmUvVk5CWmljTElpaUxsZXNi?=
 =?utf-8?B?M2NYbU1HVjZ2Q2RFZThxdnNnYi9GUXZzbUo0WHhLaVBrR2ZNaytHbmhzSkRo?=
 =?utf-8?B?QzhhWnN0cTQ2MzMzN01jRXAydHZ1ZjV1c1k0clVmVnEzU01vR2NOTjBPck9C?=
 =?utf-8?B?RXRpUDF3NDFXS25jRktCdEx4VUsxeW5KWDQ1d0pMNVdNR1lhY2dKN1c5WDJk?=
 =?utf-8?B?c1F3SWZwM2xtdU9KNWUvU0lzZjU0cFpNalc3ZE5VelBtQ0M5N2taNlF2dCtE?=
 =?utf-8?B?T0tlUWJGQ090b3U5amR5dHF4QkR3THdJVjNKb0puNnJxWEZLb3VTTHFtczRQ?=
 =?utf-8?B?TGttRHIyRTJUS1NxdGFlU3FlWTBUZWF1Z1hxWUpaMklxZEUwNVhGT0k0UkRi?=
 =?utf-8?B?a2hKcEF3cnNQTkRQRVI4Wjd1V3FIR1dKeXN5dW9aNVdJR3VmaE1ZSXJMZWpm?=
 =?utf-8?B?VElVZTVUZTg5d0YraU5wRW5mYzNtTHFmSWhrV1d0dEhzMUlVeDV1Rm0rMURB?=
 =?utf-8?B?TlJoWmVNa0dzTlZpUktuRGRMaGZSeWZIZ0s2OUJkTURoQS9iZ0RiQ3pITlVX?=
 =?utf-8?B?V0pudjNtZWNYT28rWlg0V1k1bkRBZmFLZ3ZXMDk0VkMrTDdCU1IxV0R6VzJi?=
 =?utf-8?B?U1UyVE9mL0U2R0lySUVlbHp4UDhkOHlucndsazhzZDI1ay9saWU4aGhSQjR0?=
 =?utf-8?B?b2tQaDRncHBJdThLb3pwaXNtdE80N3FmWEhpNGNBc01hQ1ArU1M5QkNkOGht?=
 =?utf-8?B?M0hsWkh0clQ3aVArOUJ0d2tpZzRRWWRORVRsMGt0U2hTTlUzQnVybDNzTHlB?=
 =?utf-8?B?QXptS1pHLzByclZETkJqMDgyd1dFbjVYa3Q3andZTy9lNENmT2lHaFhaNzFz?=
 =?utf-8?B?bENlTUpmU0kzcUZmTjVSbTBiYVFzejdyRGdmUlN5cHRrZGw5LzFQSVlzcEV6?=
 =?utf-8?B?V21tcXROcVMyU05uNHhwSEpVck8vVG1POGV4c1J2NnZvZ2JmbXdWOFdlaEFq?=
 =?utf-8?B?YjNSZ3UvZk9jcXhadFZ1aW1zUENYb3JwWkt6TXdVNVh0ckh5RWk2VGhnUTJC?=
 =?utf-8?Q?bFTauiMkwG7adbET2T0BecyOE/G9joZb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1dXelJ6OXV6WlhaS0daT3k3SVArckx0VFRQZnI2akNpMDJlWDFIVTVQUkdh?=
 =?utf-8?B?bWVYb1RJZ0VIVFBKVkdnTWI2R1EyN24wTlhDdFlqZkVHV0MrSHlrZnM1SGUr?=
 =?utf-8?B?UVpoNjgzZms2c0ZReTJLU2Z3ZysvcWhheVVZNUhpc2FEYnB6VjlFS2NiaC9r?=
 =?utf-8?B?VldVVDJFdmJOaThHRzk2eUhsbUxmV2hDWGZtREIrajBpRHF4Ni96RU1tSUtw?=
 =?utf-8?B?bFhQNjBwTFhxL3NCWEZ4Tm5UR0Z2cCsrVy9kaisvYWhjL2JwaEZzWlRpUzQv?=
 =?utf-8?B?ZWZwemEvdGQ3SFJBSDFXVWw5NUp3a0h0ZkFNSjZTZkdMdG1FYVlPUFZtUXhj?=
 =?utf-8?B?VWIvQW1UTGx1N2NUUWZGOEFYbnowVXBKZHQ4aDNUT0VrS0hBM3J5cDI2VHRI?=
 =?utf-8?B?c3NTaktybnRSRENIRGo1VjQxZkpIUGh6VWFWNHV1KzhwR3ZWbHk2MzhXVnlW?=
 =?utf-8?B?NTE3L01OMlQ3aDFCcFNrNE5DaHo3OUpGN1lyL2JhS1kyM1h0dlRJTmlOR2Nq?=
 =?utf-8?B?UDJieGVWR1BKUEdiMzN1aVpOc1VUM2VzeTdVV29YRC9BVjhDUzNKcVZyMlUz?=
 =?utf-8?B?NUdodE1wUWY3dGdZd3ZjU3QvVWNXaFEvd29ZVlVLT3NIYUdqNTRxZlYvcFhI?=
 =?utf-8?B?MzFEWnV1L3BEN0JQSks3N1IzeVlwNXhPd1Vpd2crWDZSY1huNlhPQjQxRkdV?=
 =?utf-8?B?Z0Y5V1JjSysxMm5QdEdYdGVFKytkNWRLQngxUUJpcmo4VWk2YTlWaXpSREds?=
 =?utf-8?B?S28xZ0gzakhvYVY3cmEvNGlyckV5K1FYY3NFZmEvQW1tTm05UjJkTk1aTzBI?=
 =?utf-8?B?U0RvaFpFOXpoVm95aGFUQVZka1psN0hpMHN2ZWRzc2U5TFNtU2J2OTR6NlU3?=
 =?utf-8?B?T1RYZytOZFlNZ282OTFsWi9VSFJvWlppb3dTYUwyOHd2ODZRWTVDZXhxQXd1?=
 =?utf-8?B?aHE4Q29HU3pzeEdLdGxOTTZZSGcwdnhtcm53ZXRiWnRiY2RRYVdCYS9xUDE3?=
 =?utf-8?B?dUJJTWlQanhvS2J3ZnNZOUpBWG9lMjk5UVdjWkNVMXRUOW13SUNWSUtva0VZ?=
 =?utf-8?B?NXBnSkMxdEQ1dTNWbzRYcFlwYjN4T3ZjM3FYS3BOQlZCaTBpazB1OU5GVUhu?=
 =?utf-8?B?WmZkcktscFd0a2xJZGdIak93WmxwZ2R3UmlwS2prUzlnLzFPZ0VkQ0xqdHEr?=
 =?utf-8?B?NHBHalQrUjdiSmlmYmRlbytsYnh5TFVJUGZoODVFY0dwc2ZsdnlDSkFWSFBi?=
 =?utf-8?B?ZXZtTHdBSFV3RWh2YS9tdXNaNFI1QjBuUUw2c2YxZ2d0OVc4NUY5dU0xb0FM?=
 =?utf-8?B?ajRpeW4za3QxSFkyNlVxSkZtbDZZQ1lpV1NQNy9HUU9md1JSdHArdm8zNytG?=
 =?utf-8?B?MXZPZ09ubGJqY3FYRzJJWXdWSWJUczlyUFp0dFU0QXJIdmRnMVhqcnFJTzBZ?=
 =?utf-8?B?TE5pT2lpcFVLWkN4QjhES08zRUdMU3RGeGN4NkZ6akExTm4zL0xVY3Npc05Q?=
 =?utf-8?B?cE9pZVhmR1FxbmQ1R1F1MFJFaXVocEpIdXF6RWhhRVhZeXEyOVRZanluOGIz?=
 =?utf-8?B?SHRnbjdydHhwVzIyWXY5YWxpNzV2bXdRVWFTNWNscDlZMXRZRXUyMEZBTEpn?=
 =?utf-8?B?TGh2OFo5Nm9IaWZrZGtpeFZlNjVQL1daeUlMczhPWUNiMkNyaW9WSldKZWk5?=
 =?utf-8?B?c0xVVUI4TTVGQnNIem5vUzBoRVVvVWNPczNYWXFBUTBETUNVUkUyUHlOQXV4?=
 =?utf-8?B?T0RIR3NwMDBzSVdVY0JMd0UvLzdOR3grUlVqRCs3N2djK1crbXBhN1pRbEcr?=
 =?utf-8?B?ckFzcmZTdGZ2WDF0WEtkc01XRzVIV2V5U1ZLb2N6WUVtTkthNUkwYjR2MzFa?=
 =?utf-8?B?RWlVTHRxV1p2OFNOUWk4clYxblpzUEFyV0EvZVVSbGQ0TXBZMDlpM3lKYlov?=
 =?utf-8?B?RjdaSWNoMnlCQnJXU2I3dkM0MWhZS2NkcmdYajRjUXJCc2pBQmRXOWpPcW5G?=
 =?utf-8?B?c3F5NWF1bVJYMm5OTkNpaG1FWEU4U1kyWXV3WG8xRy9icXlCb0ZZUmNKVmZM?=
 =?utf-8?B?WG1FdW5LV3NDZEdYK0drcitJY1pZa3E2d21iSXJjNm5SOXM4TEs5dGxZamda?=
 =?utf-8?Q?1F/Y=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6417f566-8f32-4773-ab84-08de2323e62e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 02:17:02.7318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYLw/u3nKvioSDvRjATEeS9uQEUtBZetlLSS93smUfy712etiCym4+/0ZzQOe39q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6034
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDAxNSBTYWx0ZWRfX/LgSfRDtyDtH
 TJldFCceGiPepvc5+GYTmiA+ziCmMbslSwzmdE0KNBGdPCPQJiUGU7kdFmnOw5aTu8UXaObGRfv
 AfA5kGdkbNCsLP42gsWr0f1rB3Ek0Zu0fWF2+MOLSqU+EbtQ1zU+w/rma9oWJ5p2VMPNur98zly
 AST8ncLmaz+CL2l1wCTLWh0oQ7KMjY8NAZztPR/BvDQCM2Qg8T/PFqNyWjG0fYAOgAisLPEZFKr
 JX7FaKYBXyFl3ZAGyGsqHZNFFQSX/WtdoExQ8glbfrJUc2oz2IMDMI11vvZIk3fs0M+f0fBQU/U
 I+XD3Wld35P6Ln9+ElaAPL2cUTU/UsZb+7j6ALH85T/2UgjXZ6JCDL3EKt0Nr3ZpUOZpzfcqlMD
 cSuY9CCeaqyUfpXJhY1YiIIVS4aM+Q==
X-Proofpoint-ORIG-GUID: xfVBWqs8FqkI4eRp4g7C46DxVwzWVErM
X-Authority-Analysis: v=2.4 cv=I69ohdgg c=1 sm=1 tr=0 ts=69169121 cx=c_pps
 a=nvwb1BjkeYK3HDx+lqLWkw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wJNMY6CPLibaGjMAeTcA:9 a=QEXdDO2ut3YA:10
 a=DXsff8QfwkrTrK3sU8N1:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-GUID: xfVBWqs8FqkI4eRp4g7C46DxVwzWVErM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_07,2025-11-13_02,2025-10-01_01

On 11/13/25 4:20 PM, Greg Kroah-Hartman wrote:
> On Thu, Nov 13, 2025 at 09:26:36AM +0000, Al Viro wrote:
>> On Tue, Nov 11, 2025 at 10:44:26PM -0500, Chris Mason wrote:
>>
>>> We're wandering into fuzzing territory here, and I honestly have no idea
>>> if this is a valid use of any of this code, but AI managed to make a
>>> repro that crashes only after your patch.  So, I'll let you decide.
>>>
>>> The new review:
>>>
>>> Can this dereference ZERO_SIZE_PTR when eps_count is 0?
>>>
>>> When ffs->eps_count is 0, ffs_epfiles_create() calls kcalloc(0, ...) which
>>> returns ZERO_SIZE_PTR (0x10). The loop never executes so epfiles[0].ffs is
>>> never initialized. Later, cleanup paths (ffs_data_closed and ffs_data_clear)
>>> check if (epfiles) which is true for ZERO_SIZE_PTR, and call
>>> ffs_epfiles_destroy(epfiles, 0).
>>>
>>> In the old code, the for loop condition prevented any dereferences when
>>> count=0. In the new code, "root = epfile->ffs->sb->s_root" dereferences
>>> epfile before checking count, which would fault on ZERO_SIZE_PTR.
>>
>> Lovely.  OK, this is a bug.  It is trivial to work around (all callers
>> have ffs avaible, so just passing it as an explicit argument solves
>> the problem), but there is a real UAF in functionfs since all the way
>> back to original merge.  Take a look at
>>
>> static int
>> ffs_epfile_open(struct inode *inode, struct file *file)
>> {
>> 	struct ffs_epfile *epfile = inode->i_private;
>>
>> 	if (WARN_ON(epfile->ffs->state != FFS_ACTIVE))
>> 		return -ENODEV;
>>
>> 	file->private_data = epfile;
>> 	ffs_data_opened(epfile->ffs);
>>
>> 	return stream_open(inode, file);
>> }
>>
>> and think what happens if that (->open() of dynamic files in there)
>> races with file removal.  Specifically, if we get called with ffs->opened
>> equal to 1 due to opened ep0 and get preempted away just before the
>> call ffs_data_opened().  Another thread closes ep0, hitting
>> ffs_data_closed(), dropping ffs->opened to 0 and getting
>> 			ffs->state = FFS_CLOSING;
>> 			ffs_data_reset(ffs);
>> which calls ffs_data_clear(), where we hit
>> 		ffs_epfiles_destroy(epfiles, ffs->eps_count);
>> All files except ep0 are removed and epfiles gets freed, leaving the
>> first thread (in ffs_epfile_open()) with file->private_data pointing
>> into a freed array.
>>
>> open() succeeds, with any subsequent IO on the resulting file leading
>> to calls of
>> static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
>> {
>> 	struct ffs_epfile *epfile = file->private_data;
>>
>> and a bunch of accesses to *epfile later in that function, all of them
>> UAF.
>>
>> As far as I can tell, the damn thing intends to prevent removals between
>> ffs_data_opened() and ffs_data_closed(), so other methods would be safe
>> if ->open() had been done right.  I'm not happy with the way that FSM
>> is done (the real state is a mix of ffs->state, ffs->opened and ffs->mutex,
>> and rules bloody awful; I'm still not entirely convinced that ffs itself
>> can't be freed with ffs->reset_work scheduled for execution), but that's
>> a separate story.  
>>
>> Another variant of that scenario is with ffs->no_disconnect set;
>> in a sense, it's even nastier.  In that case ffs_data_closed() won't
>> remove anything - it will set ffs->state to FFS_DEACTIVATED, leaving
>> the removals for ffs_data_open().  If we have *two* threads in open(),
>> the first one to call ffs_data_open() will do removal; on another CPU
>> the second will just get past its increment of ->opened (from 1 to 2)
>> and move on, without waiting for anything.
>>
>> IMO we should just take ffs->mutex in there, getting to ffs via
>> inode->i_sb->s_fs_info.  And yes, compare ffs->state with FFS_ACTIVE -
>> under ->mutex, without WARN_ON() and after having bumped ->opened
>> so that racing ffs_data_closed() would do nothing.  Not FFS_ACTIVE -
>> call ffs_data_closed() ourselves on failure exit.

I was curious what else would get flagged if I ran the whole f_fs.c through
the review prompt.  It found a variant of Al's bug above, along with additional
concerns around unprotected ffs->gadget?  BUGS #1 and #2 below look
the most important, did AI miss some locking there?

-chris

================================================================================
BUG #1: NULL pointer dereference in ffs_dmabuf_find_attachment()
================================================================================

In ffs_dmabuf_find_attachment(), the gadget pointer is dereferenced without
a NULL check:

static struct dma_buf_attachment *
ffs_dmabuf_find_attachment(struct ffs_epfile *epfile, struct dma_buf *dmabuf)
{
        struct device *dev = epfile->ffs->gadget->dev.parent;
                                           ^^^^^^^

Can epfile->ffs->gadget be NULL here? This function is called from dmabuf
ioctl handlers which can execute at any time the file is open. If the USB
function is unbound or the gadget is being torn down, gadget will be NULL.

================================================================================
BUG #2: Race condition in ffs_data_closed()
================================================================================

In ffs_data_closed(), there's an unsynchronized state modification:

static void ffs_data_closed(struct ffs_data *ffs)
{
        ...
        if (atomic_dec_and_test(&ffs->opened)) {
                if (ffs->no_disconnect) {
                        ffs->state = FFS_DEACTIVATED;
                        ...
                } else {
                        ffs->state = FFS_CLOSING;
                        ffs_data_reset(ffs);
                }
        }
        if (atomic_read(&ffs->opened) < 0) {
                ffs->state = FFS_CLOSING;
                ffs_data_reset(ffs);
        }
        ...
}

Can this race with concurrent state changes? The atomic_read() check is not
synchronized with the subsequent state assignment. Between the read and the
assignment, another thread could modify the state, potentially causing state
machine corruption or double cleanup via ffs_data_reset().

================================================================================
BUG #3: race with gadget pointer in ffs_dmabuf_attach()
================================================================================

In ffs_dmabuf_attach(), the gadget pointer is checked then used without
synchronization:

static int ffs_dmabuf_attach(struct file *file, int fd)
{
        ...
        struct usb_gadget *gadget = epfile->ffs->gadget;
        ...
        if (!gadget || !gadget->sg_supported)
                return -EPERM;

        dmabuf = dma_buf_get(fd);
        if (IS_ERR(dmabuf))
                return PTR_ERR(dmabuf);

        attach = dma_buf_attach(dmabuf, gadget->dev.parent);
                                        ^^^^^^^

Can the gadget be freed between the NULL check and use? The gadget pointer
is cached early in the function, checked for NULL, but then used later
without any locks. If the function is unbound between the check and use,
gadget->dev.parent dereferences freed memory.

A mutex is held when ffs->gadget is set to NULL, but ffs_dma_buff_attach
is Called from ff_epfile_ioctl(), with no locks are held.

================================================================================
BUG #4: dma_fence_put on uninitialized fence in ffs_dmabuf_transfer()
================================================================================

In ffs_dmabuf_transfer(), error paths call dma_fence_put() before the fence
is initialized:

static int ffs_dmabuf_transfer(...)
{
        ...
        fence = kmalloc(sizeof(*fence), GFP_KERNEL);
        if (!fence) {
                ret = -ENOMEM;
                goto err_resv_unlock;
        }

        fence->priv = priv;

        spin_lock_irq(&epfile->ffs->eps_lock);

        if (epfile->ep != ep) {
                ret = -ESHUTDOWN;
                goto err_fence_put;
        }

        usb_req = usb_ep_alloc_request(ep->ep, GFP_ATOMIC);
        if (!usb_req) {
                ret = -ENOMEM;
                goto err_fence_put;
        }

        seqno = atomic_add_return(1, &epfile->seqno);

        dma_fence_init(&fence->base, &ffs_dmabuf_fence_ops,
                       &priv->lock, priv->context, seqno);
        ...

err_fence_put:
        spin_unlock_irq(&epfile->ffs->eps_lock);
        dma_fence_put(&fence->base);
        ...
}

Can dma_fence_put() be called on an uninitialized fence? The error paths at
epfile->ep != ep and usb_ep_alloc_request failure jump to err_fence_put, but
dma_fence_init() isn't called until after those checks. Calling
dma_fence_put() on an uninitialized fence violates the DMA fence API and
likely crashes on uninitialized refcount.

================================================================================
BUG #5: NULL pointer dereference in ffs_epfile_ioctl()
================================================================================

In ffs_epfile_ioctl() handling FUNCTIONFS_ENDPOINT_DESC, the gadget pointer
is dereferenced without a NULL check:

static long ffs_epfile_ioctl(...)
{
        ...
        case FUNCTIONFS_ENDPOINT_DESC:
        {
                int desc_idx;
                struct usb_endpoint_descriptor desc1, *desc;

                switch (epfile->ffs->gadget->speed) {
                                   ^^^^^^^

Can epfile->ffs->gadget be NULL here? The gadget can be
NULL if the function is unbound. The function holds eps_lock but this
doesn't protect against gadget being NULL.

================================================================================
BUG #6: NULL pointer dereference accessing descriptor array
================================================================================

In the same FUNCTIONFS_ENDPOINT_DESC handler, the descriptor pointer from
the array is used without NULL check:

                switch (epfile->ffs->gadget->speed) {
                case USB_SPEED_SUPER:
                case USB_SPEED_SUPER_PLUS:
                        desc_idx = 2;
                        break;
                case USB_SPEED_HIGH:
                        desc_idx = 1;
                        break;
                default:
                        desc_idx = 0;
                }

                desc = epfile->ep->descs[desc_idx];
                memcpy(&desc1, desc, desc->bLength);
                                     ^^^^

Can desc be NULL here? The descs array elements may not all be populated if
userspace only provided descriptors for certain speeds. Accessing
desc->bLength without a NULL check can crash.

================================================================================
BUG #7: Out-of-bounds array access in ffs_func_get_alt()
================================================================================

In ffs_func_get_alt(), the interface parameter is used to index cur_alt[]
instead of the validated intf value:

static int ffs_func_get_alt(struct usb_function *f,
                            unsigned int interface)
{
        struct ffs_function *func = ffs_func_from_usb(f);
        int intf = ffs_func_revmap_intf(func, interface);

        return (intf < 0) ? intf : func->cur_alt[interface];
                                                    ^^^^^^^^^
}

Can func->cur_alt[interface] overflow the array? The function calls
ffs_func_revmap_intf() to validate and map the interface number, returning
the validated index in intf. However, it then uses the unvalidated
interface parameter to index cur_alt[] instead of intf.

If interface >= MAX_CONFIG_INTERFACES, this reads beyond the array bounds.

ffs_func_set_alt() follows the same incorrect pattern:
func->cur_alt[interface] = alt;

Data flow analysis:

The interface parameter originates from the USB HOST (the PC or device that
the USB gadget is plugged into), NOT from the userspace application. Here's
the call chain:

1. USB HOST sends USB_REQ_GET_INTERFACE control request over the wire
2. composite_setup() in drivers/usb/gadget/composite.c handles it
3. Extracts w_index from ctrl->wIndex (16-bit value from USB packet)
4. Validates LOW 8 bits: checks intf >= MAX_CONFIG_INTERFACES
5. Gets function: f = cdev->config->interface[intf]
6. Calls: value = f->get_alt(f, w_index)

The composite layer validates the low 8 bits (intf), but passes the FULL
16-bit w_index as the interface parameter. The FunctionFS code:

1. Calls ffs_func_revmap_intf(func, interface) which validates and returns
   a local index
2. **But then uses the original interface parameter to index cur_alt[]
   instead of the validated intf**

The interface number comes from the USB HOST over the wire,
not from userspace application. It's validated partially by composite, but
FunctionFS uses the wrong variable for array indexing.


