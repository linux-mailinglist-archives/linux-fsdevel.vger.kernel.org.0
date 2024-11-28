Return-Path: <linux-fsdevel+bounces-36045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2459DB238
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 05:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F57166FE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 04:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CCA13B7BC;
	Thu, 28 Nov 2024 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MEXMCEib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41D322B;
	Thu, 28 Nov 2024 04:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768666; cv=fail; b=AsBHdEDQWq1YjxBl5+HTZLarnO8celJ4o9UKzfGnffo+evRiFIW/9vtDUQIcT0z7AbPzei6YdkDUHNp4h8tDjghftgyPYLfpSmkJPST/O3G7JpO0wddJkaPjlCFpMaWoFVnPm6uWhGXU2sR3+nD+7Kz0odYIj+gTofoEKHLyUA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768666; c=relaxed/simple;
	bh=5y2tk8EqIvjKpq4aD4lnHv+1sKTOHukBTFvaJa/yQn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d6WrbpUH2jVk0CRtDUOA7jPRxRG2hvLHz67FPFF7rn6yEs6NKL1QP6Z2uNsp/n2rajwey0eypa8YB4qjo2j/qM1zZ6REtYxquGunE2S/4VRRLazMdPqX3MS1Sml3A2F0q/eRDrURmUvWBHiEdLNzUJJykhZJyMdTc/Ys7RviXDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MEXMCEib; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlsxeaPepnlZLsNX7I5iy09zdvlNQVdrYGP/4KLIZo7W6iutYzITy+lauNut9Qot04qnYz0wg2sqdyhwC57oOiGNhhDJR0MPZpU9Efx2tbGSpSkN22OVHfyJWS0wGfCqybdJ7BI2DK8Pz/3bobh7IgXzO2GTfx+US+UkM0QQBytngg5hhvWh3bHBGpiHFCVf5czqeX3VVZYgdRofMhMxvlWCT8cielJx2gmVZQCyDSM7kXUHg15ijoKvAVLRJJvnw+8t6KuCj8bzjQIWTIwkirdM9jdamhFaVb0h3kS64pMKSJpIxMxK6NV7gZCas9BPurhzcpDHv3WH2uYIcRLvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KayYo00ZMVvPQwg7iPsq6X5GTKLURylVM1dntaJWp+A=;
 b=jT3QJMfcphKJO23OpqW+l2mmZUejPXLnEREJioTqANL5vJa4PRdSGNp5xNnV24fR8XlOp0JIPazE/a1T2AVipVRmHOZI792FOccrYn9ewXmkbij9ubXD29VRwwml8RWwiaOpfL0b/kUZYGphuy/or06UznKTj53UwbGLbcO5AXgqHy8ucxlup5wT1hR1SUZByNDB8hEhZndSgyu5w19tik3Bp8b0Jdg+yMQbUgeoPuvY1bOidTyPzcXIM4/X6LnRiMDwe+2foo4v1k0xiwZ9yI6HaCDVCfAzBEWhieWwgC+OZjn4w/blGIjpaKhUUZBccyiXpVtiLXsi+qVzNp0kLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KayYo00ZMVvPQwg7iPsq6X5GTKLURylVM1dntaJWp+A=;
 b=MEXMCEibQ/9JSuAsY6/kja3CxxqYYgP194Xvnjzv6tAhi7hVqR2bpJ9DH3FOTRjAlYijsiyCO6r0VnTZfpMoNBfAhRiBq8wr7Fc3g31kO0xQRc+Xr0dYuSdZjGroLhcgKZeNQW0fHSByynwPBG8IeL4O8QrgWkIIwdPzPrLGXDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 04:37:41 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%4]) with mapi id 15.20.8182.018; Thu, 28 Nov 2024
 04:37:40 +0000
Message-ID: <e59466b1-c3b7-495f-b10d-77438c2f07d8@amd.com>
Date: Thu, 28 Nov 2024 10:07:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Matthew Wilcox <willy@infradead.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nikunj@amd.com, vbabka@suse.cz, david@redhat.com,
 akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 joshdon@google.com, clm@meta.com
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
 <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>
 <Z0fwCFCKD6lZVGg7@casper.infradead.org>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <Z0fwCFCKD6lZVGg7@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::32) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4deaa0-f9d8-47e2-73d0-08dd0f66647a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWM3VFVGVTZRZ3hjMkRwWWFWazZzRDJyT0NDSDF4WSs2TG5PNGdYcTBCNzdy?=
 =?utf-8?B?SlhhVENKZGhsWkxnL0xTUENySVBUejRvNjVxSGxPVkJxY1hWck1TLzdNbFQx?=
 =?utf-8?B?VklkWlRualNOcG52bWUxdUhGRTUvbjVTRk5qVnVpajUyUWFjWkx4TVFuWU5H?=
 =?utf-8?B?VHZiSGtrbnpYcEM0ejliUThUYUp1Z1RIMTZ1ZnV2R0FaZGRFeUVNVVZrM3Vp?=
 =?utf-8?B?aDNxUTJjRXlMd3FSRWVWdzZCTmtZbDhvUFFZZDc5clVGL0xZT3dxK0hsTVBz?=
 =?utf-8?B?M214RHlIVDk0cTdSSnVMQ2lFMnlNdDc2N0xjYkUxNTNOQmxNeVJjZjFHMFNy?=
 =?utf-8?B?UkZmNmp2bmtWejd0eHFMRlZSWDQxdlJJTlgvWGFXTjBPeUl0bFRCeUNwdWk5?=
 =?utf-8?B?ZU1iaXFkRDljcDZLWStCVlZXZWRHRytNNndqMkpoWlNrcW5XcnRrcGZXM0dQ?=
 =?utf-8?B?b0t1SEgwcExYSEFPQlMrWnM0OFpvOXRqNzE0dHZtTXA1bHFkaFBXNG90QWRk?=
 =?utf-8?B?dGxvcDFNRnlnZ0lWK1NOQVF2dFdNb1FqMmtYMHR5d3J4RzFkMEhYYlFVMk56?=
 =?utf-8?B?aDN2UlR1KzhlWGhZbjlKNjNXcWd1MHdkeGk0bGVUaG1QL0g5RFIxMVZ0cjFM?=
 =?utf-8?B?WnBGV1FaMDQzamx2eEZHMy81aFp6TWFIcHJFa0k4VnozQVVNcDYzRmYvSmw3?=
 =?utf-8?B?c0M1bnpjZzNzQlRyVzZOTGR1blBWOE5ubUovYmJEVWhycnE4RkFpOUNONFFI?=
 =?utf-8?B?NHlLSmRCeWp2aXd4VEJJWjJMVlpWQUlBTW1qdVBPU3pucXVKNVllSkpxN2lq?=
 =?utf-8?B?bDUzNHJObTROVW9nWkFkOC81aTJFUis3RWtPQ2pXNktmNEUxUURnNXgzMmVY?=
 =?utf-8?B?VFUrcGdjYjM1emlkc3M0UVVvQjlUWEo2TVRyQVlsZ25vb1krLzcrdnoreDhS?=
 =?utf-8?B?R0dKc2hheXc0M3lCclFuL1ZzTVgzQVZOaFc3NXZYalpORUN3YkxSanJoekNS?=
 =?utf-8?B?Nm5kQ2ZlNGFtN2VsWnBVY2FZMFkwZGhEbStWeEY1VXBFb0I3QldJNXo1NU5H?=
 =?utf-8?B?MzQ1R2pzc05xREcvVVc2bFNEZVNqNGpjQ2pVdEFCRU5sYVJvcFd3SjhrS3ZZ?=
 =?utf-8?B?VHh3RTE5cEc0VXliZldXL3RoQzhrWExuYlZSbCthdHZxU0UrM0VhZkFub3Ro?=
 =?utf-8?B?WTN2ck82TEZvMTBCdWhEejd0RlRDZDV6dFZxK3o5ak9DOVFHOVUvQ1lxN09p?=
 =?utf-8?B?YjJXKzdHWjdmOEJIYmlTcGR4bms5cnhNaXlnVGdIb3RZdStWMGZDMlIreGhZ?=
 =?utf-8?B?dkNnVnlxdkY5TXlSWGRrMGNsQ1dMMnhpSkdrS1VVT1dHSUtNRnMvZEc2djFU?=
 =?utf-8?B?ejVWaTNnQmdCVFFWUklRZGErTkJkQ1BMcXFPenE4cnZ4Z1hCcjRuYXNsYURh?=
 =?utf-8?B?VytUTk96S0c1R0k1OUFpd0dxYlJSSjRmK2N3aDJ6SmNyYUhtRjFBOVdFTE9L?=
 =?utf-8?B?Zm1sbVdXRlB1VnBtUFJ2QTRWRzFEV0NObHVSWEJVeGw1YW9UcEphc1ZjQTJr?=
 =?utf-8?B?V3U0dXQyTE1BR2dkTUpPWmkxbml0anBndHc1Wmc5NFpYcGZEYzhLUkpZVmp1?=
 =?utf-8?B?ZjI0c1FhaCtkbHBtMG9uRitTMm96eXUrdW5IUzBpdm1hQXE1bEMyM2o3V0Rj?=
 =?utf-8?B?Sko5RXUza2dzYVRGK1ozZktDL1c1dXphb2JnQkdZbzViM1Z0a2dxazY3RXVQ?=
 =?utf-8?B?c2VsVDNxbVUzSTE5RStMclhxR1lmS0JOa1JMT25ERnZGbS9lKzBvcVdQKzVF?=
 =?utf-8?B?QnozTGdnVDE1K1Jjai81Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SitxemlkRWFKWnB6V1dtVkFaMHJJdVhXWklsUlpLWWRwQUN2aENpczFlWS93?=
 =?utf-8?B?TE5sSG1NcEJkUkkvdlN6a3JZNE9EdjFtTmcwRnUxN3ZwSzgrSUV5MTJ3VjlH?=
 =?utf-8?B?Y1UyUWJrbk01b1YvZTlWZHJTU1NiRlBLMWpYcEdRck9TZXdpeEdPLy92cU9W?=
 =?utf-8?B?d2xLMU9WTTZTcHhhNHRnWkdjR3RDY2czTVM1VnV0MER2L0dRckNCc2szL3Vj?=
 =?utf-8?B?YmRWYnIwOGdtY2V0T081OGdjNlZYYnJDWm11R2VJSTFXNVVOSlFyUWtMK2o3?=
 =?utf-8?B?aU51TVlUSmlIKy9lZUdPUjh5K05FZFNkL2VMb0svK20vamFINXNwc084UDY1?=
 =?utf-8?B?UzJNREpnL0Q3R1plbW1tbE01NWIzMTgwdXF3L080Y0ozT21zdGpmd1RyWm0y?=
 =?utf-8?B?ZFVMWFpKbGt1eWFQSXdGQ3hBUUZOQjNWc1B3dVJjSm5ZZTJJdzF3SHU3Zllu?=
 =?utf-8?B?L0pjR0RhMjFiUGtrZGxVTVJ5aTQ4Z1dnbzV6cUVOVlZPZ0Zzd2hFUUlYeVc4?=
 =?utf-8?B?alMzd3Rub1NIS1dMT2drYzJyY2dlZjNXbU9WS05LK1hqZ1Q0QWk2cjI4WVpI?=
 =?utf-8?B?a2NZT3l2MWxLTnhob1dVUE9uWnpBK29ESS9mMStwQzA3a1ZocnJpSkFTK0xh?=
 =?utf-8?B?UkdySmRBTFExRDROQTdPRnVCT3pRMnVKcUcxMTdSMWJlZW1CdTdnWmZzMW5K?=
 =?utf-8?B?QVRVU3ZsTlhxV2FWK3NsTnhPL0JYUldmNmtnNThMVjNvVExRa1l1QlcyeTZD?=
 =?utf-8?B?dkIyejlvZ3lCTkcrdm5NUDhuZ2MxQXJHQm5HSFp6K1B0dXJYQW5DcmJsc01B?=
 =?utf-8?B?ZW5LcTFXU1NSV2FnejdyTmdyYTdIb1NOdlhhMlVFNlYydzE1OVZrNjRkMUFk?=
 =?utf-8?B?dUV0ZE9hOWQvMHkxcHVBNDQ1TjdUb053NU9FUXhCdEQ4dWdEbFdaYm9lM0Zy?=
 =?utf-8?B?WWE4NjRVUmFDSkpZK2NyS0ZlUVNKSHNoZnYvVk1VdUpYampuY29ScUozTk5l?=
 =?utf-8?B?NFd0ZjN2a3gzOVdEaVpRMFJGNnRPbnlGQVZQK0k0WmZzL3JaTE9vZmJYdVpo?=
 =?utf-8?B?eW1SRGxocFEyS0Q0anNnRmxBbXE0OEhCSmIrZDlMUVpOUnhzcktoOEVpUk9I?=
 =?utf-8?B?dW5ZTFNHSCtYYUxvTSs0RmNzSEVwSmJSYnViRUJkaEFHa3l1TmxaU2lPRURs?=
 =?utf-8?B?Q2ZpNk1oL2pJRE9wbVFibzdnNUlzOGFMbkNCYVQrZDNkVVlpdzcwamw4TmtU?=
 =?utf-8?B?MVZIZzZ5QmFjTVZmalMxVkdYNUhxS0hXdU1odVJCNkx0THJYTGcvOHRtQjlo?=
 =?utf-8?B?ZmFYVTJXV3B2WDJqQ1NsRnB2My9xTGVqdFlGN2U2TEZLbHdRUmNDMC93UU9Y?=
 =?utf-8?B?K1dia0N4QStVMnVObXlOVzY5L2FHNlM5SGRVRGJ3UnkrSUcrUmlrODhjd20x?=
 =?utf-8?B?M2VLNEo3VURJcnYvYmpiY2lVaHVnMDM5ZFJKWlNhS0h1TXJDeVZzOVBXRUJ6?=
 =?utf-8?B?Mnk4MWZITVZwZ1M3aWJEZHE5anpKRXFTV0Q2MVAwRUg0clZtZTE0ejlvNnkx?=
 =?utf-8?B?aUxpSXdkaXM0N080SXUzZEFWYWNiWUZJSlE0ODhvL0Jhcml3UzFsMXVDaWRj?=
 =?utf-8?B?RjcyVlVzWjE3RjVUMGhGVU95Sk5LT1NUNHNlU1JVMTlKZ2VNS1pTQ05Tc0hJ?=
 =?utf-8?B?OENHaXBKa3UyT2pDSW5WdlRyOXRNSTRHWHJIVWJtVzZrMTNtOXJIdzUvYVN5?=
 =?utf-8?B?MG8yVGRLVkF4RjVOc2tRbno5QnVURzJIN0IxNHA0cVd2YXczWXczTUVqb2V5?=
 =?utf-8?B?c00yamx4MUE5YWZPanRJRW1xUlk5QnZhei9vaFljNGphbkJyZ09tMHljaGIw?=
 =?utf-8?B?ZnMyOHRJc1FkcXh3S2tRR3hGUUk1NmhyVVo4bTRxZnpkSFlxdVR1YysxdmNy?=
 =?utf-8?B?QTZKQ1RRc2tGdVB4b21RSEx6V2w4TkdLOVZJOGpVNzFSQ2JtMjNhQ2F5SVZu?=
 =?utf-8?B?Vm1VbHNCWGd5dFJjbkVmSkFrZk1FYkFVWGp0dmNjSERRTEZMTzN3NlFwYWdO?=
 =?utf-8?B?d1dhbDhITTJrN0Rlam1ST3Zqd2l6YTF2Q09qWUh6YnJZc2tBTC9HSjZVYTh1?=
 =?utf-8?Q?shPlUtAkf1MkHxjHIEX8RQcEq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4deaa0-f9d8-47e2-73d0-08dd0f66647a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 04:37:40.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umJiLHFBsVUKJduEiLG2d05OYHRtaHvzIm8tycQFudsCu5CnWX43M4x4+m8yxBmDwAGlGDrg71oqiWs/SPX38A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

On 28-Nov-24 9:52 AM, Matthew Wilcox wrote:
> On Thu, Nov 28, 2024 at 09:31:50AM +0530, Bharata B Rao wrote:
>> However a point of concern is that FIO bandwidth comes down drastically
>> after the change.
>>
>> 		default				inode_lock-fix
>> rw=30%
>> Instance 1	r=55.7GiB/s,w=23.9GiB/s		r=9616MiB/s,w=4121MiB/s
>> Instance 2	r=38.5GiB/s,w=16.5GiB/s		r=8482MiB/s,w=3635MiB/s
>> Instance 3	r=37.5GiB/s,w=16.1GiB/s		r=8609MiB/s,w=3690MiB/s
>> Instance 4	r=37.4GiB/s,w=16.0GiB/s		r=8486MiB/s,w=3637MiB/s
> 
> Something this dramatic usually only happens when you enable a debugging
> option.  Can you recheck that you're running both A and B with the same
> debugging options both compiled in, and enabled?

It is the same kernel tree with and w/o Mateusz's inode_lock changes to 
block/fops.c. I see the config remains same for both the builds.

Let me get a run for both base and patched case w/o running perf lock 
contention to check if that makes a difference.

Regards,
Bharata.


