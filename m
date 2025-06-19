Return-Path: <linux-fsdevel+bounces-52194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F19DAE021C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F152F175ECB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5222170B;
	Thu, 19 Jun 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U8gwvysv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B0220F55;
	Thu, 19 Jun 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326848; cv=fail; b=KXnfhVA40tRT4p73yJeJvNLaY/mC1ubR0RWbt9cnd/8g0/hhzch56Qvy01AwamsmuXCEt8lHvxWGYkewEM1L88LAe+4GXoYin2SSU573Ub6KNS/4X9QPQOiaweKcuBuHxEAqRtUCV3GHVnhuq6OBy9r8ufVZt9iqCn6nvgHTvMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326848; c=relaxed/simple;
	bh=C9Y+BxzazJHjjxtRxKxzDwPVaBvsjnJCvrd5AcPCgdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C4FGhkVdWLhYYHAV+Fq5v/8ilaDxtl54W/dl2HBnRh+uYifDtKgskz1V80uNWZfKht4YsZ84rvhzXQ+4e4y7t8ZCn25/TzlHeZBt6gBLfVuIeCcoy5MZvM+cl8eMDVLS6BrngvJ7SfIE2BEjoy3oHHJoEO77GXiF2sN9riPSyZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U8gwvysv; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On99XUgng4R4rOB1G4v5HW2+wAxzxUBm6a/sceWB99lLBTnbhWYsRJqrwgh1ipItxvivkRdfmOJFLHrs2xI9RdEkadQxXMb5O+dCgdJgbSrYsvzsoApMxOs4C5Fh8d/9ypLjPGJ7lgqr/GJHB2e+1Sib/pGl5PQpvjN8cHhRjVATeI99hjWK92jSaAp20E/rLKiMEs21GTvhdVdzoH59+Eazp0SffvpE3iepULjXsbNJPifRMC9q7rW+Wf+ZIEfKrLK3qlrcXnHP25LKenylAxiGrKPKkelDNJ2wP5gpJaL6KxqXqmoYAXH4OAS7IIGBw1HliZqlJnr5ahdk0Xb2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCE0cu3gWQ4L1/IJVdaapBefi5BLzopF1yYXo2wzHp8=;
 b=tr3q8+oE86rOQwwZJdF93sTKy9+IKn2uDlLO2z7v92oYvDFoIXnjPc1JarhO5p2ehJ6MOxxJONDBQFZUoZe0BZDd6E9jheUJ3KDhEKgZfIWk1zLb4igHea7BzMIMLOEexHpBFhwGq0vWTTObL+wVgvHQdeJS4o2UFcPazHLMpgaM3dMc0F8jLqQRVfyjTkCoEoOs8yRwBXf8leaV1kKe6DjaCrBHgpWWQkM/HLE3oNDb+XjcQ8XDX4kOfLGSEymVoyLdPEIbwBN5uj4HNVOQG3Ekg9RFogEtHL+xEcOGE6ssIoPocX3COnEd8aetJGrVpg7KzZhGFgSTDOb2rLjEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCE0cu3gWQ4L1/IJVdaapBefi5BLzopF1yYXo2wzHp8=;
 b=U8gwvysvJ2Uwe3A0g9SX0ao7qbA2fQHKwT2FLhydciCpwKipKq6b1HhO5K++0dLkX7jb1/4GmMEf/lF52r4i3tU6sHUorABlkiyd4kvSgef1jZpVl0xoMp46zUNBh8kK/57U1026TnHV52mIEZrpo61PmQq4rr4JyHbYC8+hcpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 09:54:03 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 09:54:02 +0000
Message-ID: <abf72717-f0ca-4180-9e6f-83908581cbc1@amd.com>
Date: Thu, 19 Jun 2025 15:23:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Vlastimil Babka <vbabka@suse.cz>, david@redhat.com,
 akpm@linux-foundation.org, brauner@kernel.org, paul@paul-moore.com,
 rppt@kernel.org, viro@zeniv.linux.org.uk
Cc: seanjc@google.com, willy@infradead.org, pbonzini@redhat.com,
 tabba@google.com, afranji@google.com, ackerleytng@google.com, jack@suse.cz,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::7) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a734c8d-d0f1-4bb6-d9c4-08ddaf17387b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2RLSVNPNURkL2tlUGpsbkJsd1U4aU5OcnUrWHNXWGtRdXA3OVVMUUphQmVF?=
 =?utf-8?B?OThFdFdEdVk5d2h2eDlrbit0bzBSd1R0SVBwWEQwZ3B2STNCRis2bjVUemVN?=
 =?utf-8?B?Z3JpcGlDYTgvN0lVNU1wbHBOaGwwWFlhM2N6cVA4NC93aWZkdFowZnVneDVz?=
 =?utf-8?B?MHlsVFJwRG96cFJZTmtrMS8reGdPK0owczFYMnp2R2ovUDAxVmhPN1dvQXBD?=
 =?utf-8?B?aXpreG1lRW91K3gyeS9DVW1zZnNMbFlaL0h0YXNpUUFWbFlaZTZzL3J5TDlM?=
 =?utf-8?B?ckFBOFExamcxZWRJbFVJK2h4RGR3MHdVeDQ3emFNVWQvQVJRNU9vS0VyRTNH?=
 =?utf-8?B?QlN4UFJLUG9yUnRRSTk4UVBwaWxMcFk3aG9RVmdLRUZqV3RvVUVBTllzRlRm?=
 =?utf-8?B?M3JLc0UvUkpHamcwUEpYUGxLL1RoYXEwd24wUUIyTkVlY1FhQ0xaQ1hyTVVw?=
 =?utf-8?B?d2xjV08xMmhJd2dyMkFodE1OUW84S0tMUEQyc3ArL2JKa0x2dzhCK0lVdzZR?=
 =?utf-8?B?NzcvcmFTTTZkM1lGdlNQYVc5VlE1MHhkdktucUdzYTdRZzlDSU80WFJzVnVp?=
 =?utf-8?B?d0Y2OEhCQ0tFMmozaTMzcmw2UDB0ekQ5MUZPOGNKWWZSWmpyMnp6dTJGRXZO?=
 =?utf-8?B?dHVTWUpwcDBGbGZUcjNEU0Yvc01jZmZ4VWNNOGtmQnpmdnM1dEExZjZuQUsr?=
 =?utf-8?B?SzlVaFRMRm54RWltWUZmcFJ2RGVyYU43NUozMGpubWVvanJVZ1NKTWtkOVBL?=
 =?utf-8?B?SnhNK0xCR05VY0E5Z2ExZlF4MGQxek9WdXozeUQ1TXpvaHFieFRiRjZidktI?=
 =?utf-8?B?YUZVblJmYkFtUXdSY1o3dFc5ZW12RXl5ZEFBWVFidldZZ1dUQWlWSFJGNi9x?=
 =?utf-8?B?ejl0Y3cwVVlTdTBlL2d3Ui9JNjA3OGtyQnpBNUlSZms0MWlwcDhhSmJ5cUdy?=
 =?utf-8?B?TFFJSHk0aFBBdzR2dTNTQkU3NjJyTnVqK3pMamtzRWlLcmFFQ0J4WU9kNTNn?=
 =?utf-8?B?cUUzUVluZHV4WVdnbzB5Vko3MFBicVdlUmdYdjBDdXhTK2o5OXFFTHh6Q1Ru?=
 =?utf-8?B?SUFqZjBwSi9ETDZacFB6ekNFOHZaWlpkN1REQWREd01WRXpTWEovUTNxNWNx?=
 =?utf-8?B?SW1QWmVoSDBEL1RyY1lYalp1b2Zsc0hMdytWSG9mZHRobjluNnZQL1NTS0Fk?=
 =?utf-8?B?YmxRcVBlQjNabUdYMmYrM04wOTEyZEE2THRuUUVIK0tFZE1PbnJWRmpsakU2?=
 =?utf-8?B?dm9FR1BHQ0xKWjRDVFRvVVUrYm4xYlYxWm9NUGhLcFVQOWs5V21NVk85V296?=
 =?utf-8?B?WC96YUhtWFM1RnBCbzhZZjBIYUFvWEowUm5aa0ZuQ1c3U3RheENWRDcyUXFX?=
 =?utf-8?B?WkNRSXY3RU9nYXlaVk05R1VML29pUElSZ3l2Q2Z5d2pRWFhhd1pTOFo5SXVn?=
 =?utf-8?B?Ukhad3VoYnBXbVdJTTRlZnNDbi9hUHM0aXNWNk90RnFoSjZXYTNuaVp0cDhM?=
 =?utf-8?B?djJhS2s0dVBPVXhBZlJlekVNUmp4WDgyQVVWOGl4b3NObTBBc2QyUXhDWGty?=
 =?utf-8?B?dC9qcHIwb1lmdFdVSXpsZG83cUI5VFIwYU9oNW44dE9jTjd1RzRDb1FaU0o2?=
 =?utf-8?B?UFY5VXBrL3QyQ0VWVHBLbjFpODVueVFwWjFkTDUxak4wRUR0N1A5N2FnU242?=
 =?utf-8?B?NmlkYjJtVGdkZXNhUHNBZ29jcXY0UmJJNU9XMHZ3NDZZTStLOHZJNE5IVjln?=
 =?utf-8?B?NjJwQkg0WW9ZcVY3SElWdUZlaUVTaXUvemxzWmVlMzhYcEtNWHRSWm5NcFAv?=
 =?utf-8?B?aDBOQkdMdEt4S0U3cGZINjVWdklkTEI2V0FLSVdRd1RSdnIrZzZkdW9VWDlv?=
 =?utf-8?B?bFM4YTNmTjBVMEIrMlAySnNtUSs2UHlIdW45MVRLQWZ1SlB3c2VxZmFsem5s?=
 =?utf-8?Q?sjhcMgXyBh0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnBsTE0yWXZIYm1HNHBlZ0RRTWphamQ3NDdtMzZLcHpjQjlsd1lFTDJiMTdD?=
 =?utf-8?B?Z3ZNTTB5dWxnWlpBV2Z0eDJtaDZxSmNFaEZBVnloMjFlWW1IVG9BVmJjRHA2?=
 =?utf-8?B?OVpKL2ZraytnbUVObHdtaDR2RmdkVjA3VlAwTVVQSlZJUjFiRjkycXFNY3or?=
 =?utf-8?B?ZGxEUXNUbjA0VTVVVmtEYlRXVGVDQlBicjRUN2N5YWJZeEtXQ1BuaHEraU9k?=
 =?utf-8?B?ekdsQzZVOS91b2U2YkdHS254YzBRU01JUk91eXVTZ2JVai9OeVFUS2VtRjJY?=
 =?utf-8?B?WjZ2U01tR3AzTEFFMlF6T1cwckkwOFJRdW5aWHVXUXVHU01ZNy8zZU1HS216?=
 =?utf-8?B?Q1FPNndHUGg5ZTlscHI2czhyVU96d2lsc3ZBcE9oUnpqcXNFZXp0VnpCWUV0?=
 =?utf-8?B?c2M0OEkvVTczbkIrNDFPVEk0ZTlTeXBKcG1iUDhCb1hpd09DRW1jTVpUUkd4?=
 =?utf-8?B?alZNMnFNTWJYU0RlUExwUmVBWjF2NnN6UEdiNW9jbjBmQzE4YXRxMnJPVWFr?=
 =?utf-8?B?SEk1Q21Dbzk1QUI1bG9RU0ZMaG1wYUlSUlNUTUVPS1daMU1sMzZZazlyMWVC?=
 =?utf-8?B?L1BTOHpzdG1WbWdZWkNydEFrUE5Fc1JwNEtQZXAvU2xjZ3VNWkREQ2FFclhU?=
 =?utf-8?B?R1FTSXNwS0NxNTNIc0d2OGFaUzRYTFpmOWl5cm02Z0xkY0hhZ1lsazVvS25C?=
 =?utf-8?B?cUtackFFbFFFcUNVd0IybEY0ek5qb0FhYnZMR29VMEhxZ2pvbWNsL2VhT0Rm?=
 =?utf-8?B?blk0UDh3SkxzVUNVNjkvSHVEV2FUUTRrTUtYNzFPcGN0ak5VZjQ2MjVxMG14?=
 =?utf-8?B?ZklQcVE2S2h4ZDRqdnhGOFAyQlVIQUZrN21ndzh6NjdqRUJzYStFbnA5aHFW?=
 =?utf-8?B?WXh6a1hIM0FKZFdiUlVkZ24ybmYwM2NYRkpxUERzMDhsb3lIT0dxak4va3dx?=
 =?utf-8?B?VmNVbGJiaEUxOW1XMzRXZlprb3BFY3JZRXVGdnRpMTFGdThsUG5mMDBlVzI4?=
 =?utf-8?B?c3F2V01RZ09WSmFCbUEyd1FkYVllQ3RDVDRTNDZNWlp2bzFUd0RjZHhqRXFx?=
 =?utf-8?B?MHNibEl2VG9NYXVjMllLcWRzR2gwaUFDczRkZmtMcE1PcVV3OWhpa3FRYUox?=
 =?utf-8?B?Qk00ZnJXZDVqY2hpdVZIZ1RRQ3BISG1SenJxYlkwQkJ6VTdYeEIvNndVRm41?=
 =?utf-8?B?TnNZNWswRHNTYTJ6a1R5RG4zR3RSak54d3pPR3RkL0g1dmU4ZkhCdU1tZUxI?=
 =?utf-8?B?UjFudHF5NVNSYUp0dUhiMnJtK084ZExRMUc4ZWZXVy96NlRYQ3hCY0RJVDIy?=
 =?utf-8?B?ODJzMnA0dmo3T2lTMm1yOGl2QlZyeGJWMDdYalhVcXZWanRkVEt3SUlMeTI3?=
 =?utf-8?B?YmpLdjFnQ2g1UFdvNVRTbnhjOFlTMjRDNk12OW9oWVRpc1g1NTh0S2R6cG0y?=
 =?utf-8?B?VDRFanNHYmcyMDI3NmJKbU5RcXVGZnFtK2FHMnFubzRhTkMvWWorZ05GQXVl?=
 =?utf-8?B?Y2tsakRZdTdTT0pib2pPSjlOQk4xeEorRG9VU3JEa1ZYNXVLOTRZTXNCK3hx?=
 =?utf-8?B?V3JhZmpHOWdtOUhIUEJEK2tpZExtU0hscis5SDN2QStackJRU1VDWmt5c2dL?=
 =?utf-8?B?M0tHaG15eGREakpmeTZ0OGVVaGdGNHdzVHdGTXlMeVFzeWtjUHdTSG1SRmox?=
 =?utf-8?B?UTFjNHhCTlVwV0J3aDcxeWtNc2RNUFhHc0lRVElTWmJZaTRFK1piY0txRXdO?=
 =?utf-8?B?SUlTWHZXclUxRXRSUzRNS3lDQlN2Q2tnL1pselk0M2VSYWRxSDV4MkM2bkxE?=
 =?utf-8?B?REh1RDlmRmduTG5CeHYwdjJmdTlvSFlCVHNlaURyZFIzY0Y1aXhFNGg4blBr?=
 =?utf-8?B?dVgwRzFHTUQ2UW90SWRrTG5Td1RxU1BETmlFbjNBMURlSjFjKzV0VVlkMDRn?=
 =?utf-8?B?TlVLOXpVNXQya0hYSWFPR1N0bTRKZVZzV1ZjU2pRUHNGbU56VEpvYTRFNlFD?=
 =?utf-8?B?Z015WjJHWUNMZ0l1T3doMkhSOUt4d21OYjJXeWZxRE9vTGpoUzlaWjV3QUtH?=
 =?utf-8?B?dlpuK2hTTkpySTRjOHZRRUx1WXFIaDY4eFdkbGdESXFDeU1LeXlnZTJ5MUZp?=
 =?utf-8?Q?d5M3GUqdizCXf8Iisk1TvJNSy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a734c8d-d0f1-4bb6-d9c4-08ddaf17387b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:54:02.7707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QieL8gFNBqmT0yJZF5164lpxs1yPpmXKAx/BSz5VLHzCAMrEJwfGlGj8ywsh2z/wgwm63p4AD2h1ggUQoQSdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857



On 6/19/2025 2:43 PM, Vlastimil Babka wrote:
> On 6/19/25 09:31, Shivank Garg wrote:
>> Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
>> anonymous inodes with proper security context. This replaces the current
>> pattern of calling alloc_anon_inode() followed by
>> inode_init_security_anon() for creating security context manually.
>>
>> This change also fixes a security regression in secretmem where the
>> S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
>> LSM/SELinux checks to be bypassed for secretmem file descriptors.
>>
>> As guest_memfd currently resides in the KVM module, we need to export this
> 
> Could we use the new EXPORT_SYMBOL_GPL_FOR_MODULES() thingy to make this
> explicit for KVM?
> 

Thanks for the suggestion.
I wasn't aware of this earlier. I think it makes sense to use it now.

So, the code would look like this:

+EXPORT_SYMBOL_GPL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");

which builds fine for me. I hope this is the correct usage.

Thanks,
Shivank

