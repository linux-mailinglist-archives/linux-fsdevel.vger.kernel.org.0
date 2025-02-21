Return-Path: <linux-fsdevel+bounces-42205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD1A3EACB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 03:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477AB17C677
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 02:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EADBA34;
	Fri, 21 Feb 2025 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TZjaqWkW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBF18C937;
	Fri, 21 Feb 2025 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740105237; cv=fail; b=JrLcDWOAfs1VuNZtgfjXz/BPzv87TsFsuSzNRjeDGMA04Fmdy21eVcIoF1hoxpXcF4gSFM9SjmxNS0z2uS0ir7mLWVeqH+87ywgkC49MDhQ0iK+46BsqMiEo/L/faBZwuMzoZTEP99/rg3IMw0vUgILyoXfD5fvh5TiPh+qpFkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740105237; c=relaxed/simple;
	bh=XRX/BxNnUhhCF56BSp19EKoIBzSGxbSHIL/sNIxYKvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ThOXp9/cIuNG6hK/4tdD8pwlvsM35Jz0maw772gA4Aj7+lJCgIkEOS2T9f4PRkDsezQgqa0n81BQ+KwpDM7Fh4xmz3rqR4CGue+/c9hn4VwX6SOp6SSChFfjhwgl0F/LTZOqbeWmKuzXtZDgsrp12jefG6+Yq6XSBj88UFEeoAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TZjaqWkW; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkKwYGb+kYwegWOchlWu2lVR7k8U0jh26uPqdbDVaEAWCNgKtBlan9d6B5PWayqfnmfqIrdZ6hn9HYnrFISYuoMnOBkIdJ04Suh43O9DWRWZV+13GsaKjpMflfmTXnusx63d/iL1Sa7QTQ2a0Dni5wVgAAeEsJG/BcH9e/FfUG6IYGCPbvqQxCZvtY8gAhZjoFzPbyq3qzNYX8GGZMFdMrtXdyq8vv+ZyovSw+p5pIL5J5aaT7oBHDZ+3pMdunO9QfvrH3wM9+xEE3D0XJrPk6VTuMQ8UR+3USUueC5b+Vg/Z8TMMFSySxAR9Mr5Cz/C/QZ/HZH/wv4MY3eIeR1rzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDxCp8dtbzfDm1t8t4tycv9TiPJ5m8VftfQdR43sJhc=;
 b=pYgOgr8HK/r1a+5nWM2XDfsbf0Lf9tDrcKydY7H7se34KcSm1M/VfXVZh/f5cdljd7nEsUtfJS0yOIqT59EOXh3aui5lnB2m3Ad4dIJEhzILCKU9XX02ebqbqIBuvZ7x3F0E8INZDt2lAxUK9ARbqzF3OQYx/wvffagB8B9SJ33iXGgP0+JGLbQXIrOml2F8zkq31RjWopOldfx2/x0p0OFY2RwshHS8CB7mZjXr4GCPtVbmkaKrLQA88PD6+dYLuvGuJ+iuHR9toSrUF3i5QPmFvkMRNw9VMinDg28gJlIkMx+/SZbbpNhmK5saB1kNpj4zUp3qTtLM0oyvsLFcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDxCp8dtbzfDm1t8t4tycv9TiPJ5m8VftfQdR43sJhc=;
 b=TZjaqWkWAJnnCiexKi+EXjuTasdoCnEL3tUTXkRDy1e+zAXEePIrrCTo1n9kCU+2X6NY2LC9E3D6LMhrX/mf9EtNYHj0PVI8UF9gdTwZchXclI3pUkmRFgMiuosiXa5YyyrT/BXjBSwbf1PX8IY/YoqJs4vdhbihdrNbgj+t6535FiH0sRCpvvuAK7hByg1r76gMhyjpx4pya1YHhL3muxckmBQTKyaZGGg+F/mucir5bw0bcQJ2AM0AURFFC5ttjfSGieRMT/MtlkaGy0pvCk/55vwotFpxWjJRwNUKYT/HlbG4jdomXODGrqLIRWTnBUYViD0vdk3xcs38rk3+eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 02:33:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 02:33:52 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
Date: Thu, 20 Feb 2025 21:33:50 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <37C4B6AC-0757-4B92-88F3-75F1B4DEFFC5@nvidia.com>
In-Reply-To: <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
 <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
 <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:208:120::42) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b4312c-3a0d-409b-bf2c-08dd52202e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDE0Y0t2MXN5bE1BN0pCK1g0QndYcENUcy9VSDhpMWlBRG94Uk51c0hDYnha?=
 =?utf-8?B?VmRUN2laRDBZY29HS0JBL3NGeXV0YmdGbmVSZGVUV0tVMWtUVFVUYTFldUlB?=
 =?utf-8?B?WTJvdExZTkhveEI4WURYR3Y0NXZyc29yRWpPMGM5NzVlMnVUblQxT25kdG5Q?=
 =?utf-8?B?QWxhQUp0aWtvNzlYalBKdU1UNS9nSVFSK3dzNUtOVFE0SE5MSGRNOU9GOGI1?=
 =?utf-8?B?c3FCMm1EUUJ2RlM0UC8wSllaWGF2UkR3a1lzVENVcFFZbTZVV3J1czZuMm1G?=
 =?utf-8?B?Y2RpVEJIQW1QZm9wK2RoTENPMXJSYk1uSGZJVk9EMm1uZjFaanp5S0VoUHpM?=
 =?utf-8?B?VWZaMkVWbGltdVpUUEVMYVQ2eSttdTc0U3ZBVE1KVWFqeGZYRU9XWjZzbDcv?=
 =?utf-8?B?U2R3S1hxNWpsSkw5T1BjY3BCdnE0bGlEZUR3ZlhpYkRLZGgzUmcrVE1iRkdi?=
 =?utf-8?B?K3VzaE45VnN0VS9ZZUhzOTRFbHlXZWNxY0x5bTVuYjRzS2tHOTcvSTYrZ2VL?=
 =?utf-8?B?SFpPT3lPd0orYm43NlNhWU9NT2QySk9FRXF1K0JlSmVuSmc4RFUwdWFCbkUz?=
 =?utf-8?B?eTByK1ZBMU5ZelhHaU1RcTIwVHhiZlJoNzZIRUNiL0RtWjR4Mm5keU0wdlJV?=
 =?utf-8?B?VWpUL0hrbW9peHFVTzEyWXU4cmRMV21jSlhLU2MxYXRoSXQyeG9JSGVoZUgv?=
 =?utf-8?B?MUFNOXJhMHZtbTVrL3ppazJYNmhMVm5rQ1ptSllzZlRRWm1HRlRuM204L2FS?=
 =?utf-8?B?elVrTngzWTRUeHl0UytGVWFleWQ5L1BLb2dIcEhrSmh3WkM4d0N4Y21ScjQr?=
 =?utf-8?B?SGRsY1cxOTBaY0xrdUdBZU8rc2lSbzZ2ZnJCK1ZMMHJFWGZSWDIxQWNvcGhY?=
 =?utf-8?B?YURFYmU4WjhkUkRkaFdybkR4bStJSmEvZUQ1SjRsdEJIMDEydjlOVlNoc2xr?=
 =?utf-8?B?QXQyUFNUMW1IZmdqV3JKRFhpcTVOYjNnVlNHZ0hOOENVUXJ4aXgzbEdkc1ZE?=
 =?utf-8?B?UStDVzl6cjVzTllKNUNkN25XKzRWTHM2VHB3cm5ZWjdCVVZMQ3VKK0liejRa?=
 =?utf-8?B?TzljUzFoUFBXK2FUNWNROUhSSWtPMmVZT0lHNHFLVTMxVTlQM3hlMVhxcERu?=
 =?utf-8?B?RkVkODYwdTNLWThud3ZLaGJVN09BZ1AvQ013L2h5NjMxVm13UnNTU1lYWkh0?=
 =?utf-8?B?bmt6bjhzaDc4ZWxzZWhOeDJrLzBmQys3YndKaUErajYySUY1aG5zOFVScFpW?=
 =?utf-8?B?eHpyb09GZ1pXL0RKMEEyZEZwaktjYmVyUVU1ODdyM2pDcEZHVy84azhkTFlp?=
 =?utf-8?B?aWpqYi8yOXBEY0RaM2ZSU1lFZDlWMXZWaHc1cGRjbHc4clByZjA1VG0xYlNG?=
 =?utf-8?B?ZC9hUXVUNEI5bHZkNFZHd2ZIQVJXMllrWmpWS2VUYTR5YmMwdmhqN3hkTTVm?=
 =?utf-8?B?N3pjYy90dGpIdUJSN1JRVlR2UW14STQ4eDdoNUJRdTdZSkxsOGRNUjMzL0M2?=
 =?utf-8?B?Z29vUjM5bUtmUjYwM0RFYVVycUR1czVENmRjeWhQRndvQmZnUjdoZTdPYVdU?=
 =?utf-8?B?cTZpRWNHWmNmdnpmL2R0dy9Pc1Z0MlZHanFSOXZWVWlXMHJmUjY2S2daRjhr?=
 =?utf-8?B?bTc2cnVwNSt4UkJQOVJRTDdoWG9JODJXMktWOWQyMm1ITC9wRE1pNnBsLzBX?=
 =?utf-8?B?K3Z4YlJ0WjVTQ3JkT1RmN1FBbVhXNUp5eDRnNzBjY3haTi9xZjRkbUYvS204?=
 =?utf-8?B?OWtqUHkvdEltT2lkSW5CSFhBZDhRRkluSWZ5WXUwUmFsYUtRNkJCcWg2UnBS?=
 =?utf-8?B?UXdUcmFLU0h1Q0J2LzZBQnY5SlZoTDFGSlkvdVByZzVuWStsdkVOODZJVGth?=
 =?utf-8?Q?cLrUgulM49Y92?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azVQU0Y3REZGakd1azNWRG9NWUErM1JZbVo5S281VXRENGluZzlLWk1Cdmlh?=
 =?utf-8?B?RjBBS05aVU0xMDEzMnJjc0UwYmJqVzNYdHlRUFdwUFY0TmlCbThVUDNTTURX?=
 =?utf-8?B?bXU2WldBbGRmNHhaRVRLQkx4WXBKVE9YQ0dZK2dWWGdDSitRMDhMTDFKS2pw?=
 =?utf-8?B?czVHNDVBa2hia2dUOStXUTRyYjFqQ3NMS1NoWUZhN1Y5cVNxMXBpWlV4Mkg3?=
 =?utf-8?B?bWtrUW9Ic1FoUUkrbGxFQmF2c01IQ2pTZXF6Mm1aNFRnU1hRYncwQytQNEVp?=
 =?utf-8?B?VkJPV3hEak9aeVBQdnlhZ1Z3Rm1YeXcxV2o0KzErc0piU2tTT0hLV25pMzZG?=
 =?utf-8?B?cWluWGJzYkRzYTl0aEY0bUsvWXF5VWZuKzdjV0xlRHlxSDhRZlJXbGk1SWN6?=
 =?utf-8?B?cm43ZTZSTENhRUs3dmVHeXhwdlJ6S1ZIdUZOc082QkFCTGtQRWtud0lDSjRi?=
 =?utf-8?B?Y0dCRUNMbm0yck1vckdCYlYzK3oxVVArU3pKd2VORjNUcVJ3TWhiQTlxODly?=
 =?utf-8?B?OTl6cFl2L1QvK0gwK0lBV1hlY1RoZ0FzTEpabUxrRVY5a3NyN3pTQ2kzSUlu?=
 =?utf-8?B?TlVPVFZkVzFIS3JrdHUrUnh1ZE1yRUlaNm41T2tRV1VBQndpL1doYUxVY1lW?=
 =?utf-8?B?eUJtSnE2MHZTYVY5TnRoUmdNMmZ1ZEd6VUJJUCsvaWZYZDg5NThRQWhrZGlk?=
 =?utf-8?B?UUQ3WDhRcmJJMzNWVTUwcFplMjcxS0FqdzIwMThoV1l1TStwR25aVDdGalNu?=
 =?utf-8?B?d0VNQXdJL0VBV1Y0b0NmUWlXT3htSnc1NER5ZmR1WGpxQy8wMnA3bHVRR1U3?=
 =?utf-8?B?b3gwVXF4N3hOejFad1NRdjJXUUN0U1gvSUVtRHJxZ2ZsRFlzK3E0ZmYwV3hh?=
 =?utf-8?B?SE9OSEFZQndZQ2FNSXV5VTlvSW1uci9KSmNYaDVVSmF3ejFKVTA0ZnNKK0tN?=
 =?utf-8?B?ZjhyTlZybTk2K0cvVDEzcENiZXZRYXJZREFWdm9HWTE4bEJkOHFrWURSY2sr?=
 =?utf-8?B?YUlETjhldXVXTGxxOFFiK0lwcWwzR0pjOFZTOE1rNHVzY2E0YkVGYVhQVEdu?=
 =?utf-8?B?Q3dyMW53NndUd29tZzcyZmN5UWJhVk1POWpEUUFSbzBzV3lON2JvSlkrb1Rt?=
 =?utf-8?B?UW9FSUpJbnJMcm9Wd2NtTUZxN1hvRUNOd3R1M1AwVWJuRXd6bDZwcG92REJx?=
 =?utf-8?B?OHBrSzRsRW1FV1ZYNFQ4ZGFQUVdLSGVuVCs3SUFvV1lwMjBIcDBvNjJjNTBC?=
 =?utf-8?B?cC9oNkJWcm1MdGwvaG5lYytVcFBsWkRuNXFaTGxBdDJzbzRPWFdVa3IwUEhC?=
 =?utf-8?B?TmZ5ZVpTc1JzUmdDWWN3R2phRVhEemg4MjFPbEZ6dm1neUJaL1ljZlZxcUtp?=
 =?utf-8?B?Q00zemJxak1vbnZNTXR3MlMzQkN5eXNnalFZME5oNjRTcWJHeUNiNitzSmpj?=
 =?utf-8?B?UEZ6ZXVVei95aTg5aW1HRmowbFZMdXZDVmpvUStOR0pNVCtRRFo2UkVjVmFr?=
 =?utf-8?B?bzlYYkNyT2c2V2JhMW51NVJoN2o5bmVzRERJVEZ6OUJDZUxOVnlqWkMyNSsx?=
 =?utf-8?B?THJFWThGdWdQcitVTlA0cmpDQ2xYRWdDMnNWUkJPOXlMT25uWHBGeWxMSkVZ?=
 =?utf-8?B?aXdSbXNDVWxieE9uOHJWallySk9XelhFRlRTemRZdlV3WnJXdkI3eG94RDdQ?=
 =?utf-8?B?NldLb0o1dUNaNk53VVVmQTdvM0FOM0llNVliNW5MazdzQ1NWcGVPMDN2STJt?=
 =?utf-8?B?WEdMVFY4aWRFZFFTQmpLNlgyMnlhUk51ZG9WK0tJcUVsVzJiNDFmS1d0QW02?=
 =?utf-8?B?bVV2UlcrOVVzcC9BRW9reisyMis2MkpIQzNTTXM5OUtaY3dmWUR6VXBtb21y?=
 =?utf-8?B?VUpzak5seVpDUjhpUmNrLzhVeHlOMVFzUzJzZUJjN1lqL2dPcWoyVFV1R1JJ?=
 =?utf-8?B?TTkxYVdEeC9FR0g1Vy9GeUdhZ2ZXT01taWZCbFlMbktab21yazRnSmdITmhC?=
 =?utf-8?B?MndCNnlrQlowenE1WWVPOUdIVncybTBaSDZIR1BWWWZKdTZJb2hRbXgxSEIz?=
 =?utf-8?B?clgxYTN1SlhZa0QwbEhyQVFSd2E3SXlFbmtEbC9GREZrT2tqZlJvcmZRbzla?=
 =?utf-8?Q?72d5AvYDKAwlmVJQJ6sSlan9X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b4312c-3a0d-409b-bf2c-08dd52202e02
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 02:33:52.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyLGCJClWN5lv/V3Oagjvao1VEBVlfCCIjwYa9lRbtFHEOKRFzz0n5023GAMZTqA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

On 20 Feb 2025, at 8:06, Zi Yan wrote:

> On 20 Feb 2025, at 4:27, Baolin Wang wrote:
>
>> On 2025/2/20 17:07, Baolin Wang wrote:
>>>
>>>
>>> On 2025/2/20 00:10, Zi Yan wrote:
>>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>>
>>>>> Hi Zi,
>>>>>
>>>>> Sorry for the late reply due to being busy with other things:)
>>>>
>>>> Thank you for taking a look at the patches. :)
>>>>
>>>>>
>>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>>> During shmem_split_large_entry(), large swap entries are covering n =
slots
>>>>>> and an order-0 folio needs to be inserted.
>>>>>>
>>>>>> Instead of splitting all n slots, only the 1 slot covered by the fol=
io
>>>>>> need to be split and the remaining n-1 shadow entries can be retaine=
d with
>>>>>> orders ranging from 0 to n-1.=C2=A0 This method only requires
>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>>> xas_split_alloc() + xas_split() one.
>>>>>>
>>>>>> For example, to split an order-9 large swap entry (assuming XA_CHUNK=
_SHIFT
>>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>>
>>>>>> xas_try_split_min_order() is used to reduce the number of calls to
>>>>>> xas_try_split() during split.
>>>>>
>>>>> For shmem swapin, if we cannot swap in the whole large folio by skipp=
ing the swap cache, we will split the large swap entry stored in the shmem =
mapping into order-0 swap entries, rather than splitting it into other orde=
rs of swap entries. This is because the next time we swap in a shmem folio =
through shmem_swapin_cluster(), it will still be an order 0 folio.
>>>>
>>>> Right. But the swapin is one folio at a time, right? shmem_split_large=
_entry()
>>>
>>> Yes, now we always swapin an order-0 folio from the async swap device a=
t a time. However, for sync swap device, we will skip the swapcache and swa=
pin the whole large folio by commit 1dd44c0af4fa, so it will not call shmem=
_split_large_entry() in this case.
>
> Got it. I will check the commit.
>
>>>
>>>> should split the large swap entry and give you a slot to store the ord=
er-0 folio.
>>>> For example, with an order-9 large swap entry, to swap in first order-=
0 folio,
>>>> the large swap entry will become order-0, order-0, order-1, order-2,=
=E2=80=A6 order-8,
>>>> after the split. Then the first order-0 swap entry can be used.
>>>> Then, when a second order-0 is swapped in, the second order-0 can be u=
sed.
>>>> When the last order-0 is swapped in, the order-8 would be split to
>>>> order-7,order-6,=E2=80=A6,order-1,order-0, order-0, and the last order=
-0 will be used.
>>>
>>> Yes, understood. However, for the sequential swapin scenarios, where or=
iginally only one split operation is needed. However, your approach increas=
es the number of split operations. Of course, I understand that in non-sequ=
ential swapin scenarios, your patch will save some xarray memory. It might =
be necessary to evaluate whether the increased split operations will have a=
 significant impact on the performance of sequential swapin?
>
> Is there a shmem swapin test I can run to measure this? xas_try_split() s=
hould
> performance similar operations as existing xas_split_alloc()+xas_split().
>
>>>
>>>> Maybe the swapin assumes after shmem_split_large_entry(), all swap ent=
ries
>>>> are order-0, which can lead to issues. There should be some check like
>>>> if the swap entry order > folio_order, shmem_split_large_entry() shoul=
d
>>>> be used.
>>>>>
>>>>> Moreover I did a quick test with swapping in order 6 shmem folios, ho=
wever, my test hung, and the console was continuously filled with the follo=
wing information. It seems there are some issues with shmem swapin handling=
. Anyway, I need more time to debug and test.
>>>> To swap in order-6 folios, shmem_split_large_entry() does not allocate
>>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
>>>> error below. Let me know if there is anything I can help.
>>>
>>> I encountered some issues while testing order 4 and order 6 swapin with=
 your patches. And I roughly reviewed the patch, and it seems that the new =
swap entry stored in the shmem mapping was not correctly updated after the =
split.
>>>
>>> The following logic is to reset the swap entry after split, and I assum=
e that the large swap entry is always split to order 0 before. As your patc=
h suggests, if a non-uniform split is used, then the logic for resetting th=
e swap entry needs to be changed? Please correct me if I missed something.
>>>
>>> /*
>>>  =C2=A0* Re-set the swap entry after splitting, and the swap
>>>  =C2=A0* offset of the original large entry must be continuous.
>>>  =C2=A0*/
>>> for (i =3D 0; i < 1 << order; i++) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t aligned_index =3D round_down(index, 1 =
<< order);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0swp_entry_t tmp;
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0tmp =3D swp_entry(swp_type(swap), swp_offset(s=
wap) + i);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0__xa_store(&mapping->i_pages, aligned_index + =
i,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_to_ra=
dix_entry(tmp), 0);
>>> }
>
> Right. I will need to adjust swp_entry_t. Thanks for pointing this out.
>
>>
>> In addition, after your patch, the shmem_split_large_entry() seems alway=
s return 0 even though it splits a large swap entry, but we still need re-c=
alculate the swap entry value after splitting, otherwise it may return erro=
rs due to shmem_confirm_swap() validation failure.
>>
>> /*
>>  * If the large swap entry has already been split, it is
>>  * necessary to recalculate the new swap entry based on
>>  * the old order alignment.
>>  */
>>  if (split_order > 0) {
>> 	pgoff_t offset =3D index - round_down(index, 1 << split_order);
>>
>> 	swap =3D swp_entry(swp_type(swap), swp_offset(swap) + offset);
>> }
>
> Got it. I will fix it.
>
> BTW, do you mind sharing your swapin tests so that I can test my new vers=
ion
> properly?

The diff below adjusts the swp_entry_t and returns the right order after
shmem_split_large_entry(). Let me know if it fixes your issue.

diff --git a/mm/shmem.c b/mm/shmem.c
index b35ba250c53d..190fc36e43ec 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2192,23 +2192,23 @@ static int shmem_split_large_entry(struct inode *in=
ode, pgoff_t index,
 				xas_try_split(&xas, old, cur_order, GFP_NOWAIT);
 				if (xas_error(&xas))
 					goto unlock;
+
+				/*
+				 * Re-set the swap entry after splitting, and the swap
+				 * offset of the original large entry must be continuous.
+				 */
+				for (i =3D 0; i < 1 << cur_order; i +=3D (1 << split_order)) {
+					pgoff_t aligned_index =3D round_down(index, 1 << cur_order);
+					swp_entry_t tmp;
+
+					tmp =3D swp_entry(swp_type(swap), swp_offset(swap) + i);
+					__xa_store(&mapping->i_pages, aligned_index + i,
+						   swp_to_radix_entry(tmp), 0);
+				}
 				cur_order =3D split_order;
 				split_order =3D
 					xas_try_split_min_order(split_order);
 			}
-
-			/*
-			 * Re-set the swap entry after splitting, and the swap
-			 * offset of the original large entry must be continuous.
-			 */
-			for (i =3D 0; i < 1 << order; i++) {
-				pgoff_t aligned_index =3D round_down(index, 1 << order);
-				swp_entry_t tmp;
-
-				tmp =3D swp_entry(swp_type(swap), swp_offset(swap) + i);
-				__xa_store(&mapping->i_pages, aligned_index + i,
-					   swp_to_radix_entry(tmp), 0);
-			}
 		}

 unlock:
@@ -2221,7 +2221,7 @@ static int shmem_split_large_entry(struct inode *inod=
e, pgoff_t index,
 	if (xas_error(&xas))
 		return xas_error(&xas);

-	return split_order;
+	return order;
 }

 /*


Best Regards,
Yan, Zi

