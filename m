Return-Path: <linux-fsdevel+bounces-62721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6DB9EF91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA3B7B0061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747AA2FC014;
	Thu, 25 Sep 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5f0YcL10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B712FB977;
	Thu, 25 Sep 2025 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800707; cv=fail; b=TKmfOLzolKTl+pdfs7jHzXU9AtkMv66V1Xx/PRp7tOqzNgI1wnaOVcaQcRe1mm6GTiONGWI+QyXVh16IKr/5Ph8VrAM1ee8SOTf6N229ipk85f17qbVdmOiorT7WysdC1u4jJjP3auLVblV/mdTJ0n19lGwQ74vMzq6YrJidJBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800707; c=relaxed/simple;
	bh=gUPAYw7X9jVVDwpHC5sLgnxmBzO7CLNz2DHSnhGjL6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ok2rKdelu3ElnmI5Y+3vUB8RIDEc9kH8SNLJiGQKwfzDKw7MmtbO1ecVueL9N7CDc4yD3ppf0tQ0O2XK7JLIRJFBHjTG6Vm5FO5ysrzxLc/RKT1iJTzlas0x77WNKa//lcGge9LjPhaAZFN2Rgyq3nl4X9JHujy+vF4t57lTPMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5f0YcL10; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI0v1c2/x+WnXnmIlIBfAlU3M03AK2DMij3xa5Xfi5vK0sfw8K4eZyB2OxX1pUVbXgP0LiKLLASZcSYExZJ4+7ZAmiWFb5l64yPMnTMM0dxJ1c9XLXgTrxyu0DDZBNPM5qhS0cnc9Fn22cJ5eAxN8wTpW2vEZninAaDtu1BmEMbCoWkR/0C9MHcem+no5/OS3DHyIeNDbi/9roJmwr6m6727Vv9VuLjCqHXKB5+mAMNLMdRHfi23beSt/HXfyx4AdbvkSOOGtWBHc4KQEcIEvCORSqvsjwd9LjKt8umvliTcGFA96S4j/VREP/wfO2gpBHk1b+KiIboIgYoRG6tUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wco19X9g2exgW/ipYOTIuCFWywnAWlCBfELFa4piagM=;
 b=lpfEwLkgzaczmY2W99uV3XfQdv9ouc+ig9KiakmoUrXHuwrlo5TvwN9tyEoL7t1quFHiwx5CA0p5+RPwhvmH/gZkTdda879UUR9bzQ0sHjyDNhTpV5NYZG9sM1NH058cRS3xGKYiRS3PUPYcHM7Cd9j89dxe3zeYZ1Ukirri165A6lkaagQdQytTWIAl/P1D3dRvJ1JGoPr40fx8YZybfcaAAv5au/EYRbjawoWHTc6vWl4CdnSLpP4CT6x2GmkdWMp8fVhK/u5r+yW28/ISHg6Pt+g0DjBbrPvnQrabocoCQ5VRhHFKrYJ82oO7hgSZT7ly0Z7VoXi1FdOJW8lzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wco19X9g2exgW/ipYOTIuCFWywnAWlCBfELFa4piagM=;
 b=5f0YcL10E6SnLzAesd/5TSx7m/r6MD18shFz2dzDYfCTqpajP3tVaMlTyzuyf6coLmSgIDo98d82/9iePkuTyjKefiNWcsvzYsZwMneKfrlMzzZ1rWyG76+K6YSarUd48cnHkOLOALcRWU9VnetThV02PozA2cgNdYAzxUYpHQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 11:45:02 +0000
Received: from IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823]) by IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 11:45:02 +0000
Message-ID: <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com>
Date: Thu, 25 Sep 2025 17:14:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
To: Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org,
 chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com,
 kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-7-shivankg@amd.com> <diqztt1sbd2v.fsf@google.com>
 <aNSt9QT8dmpDK1eE@google.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <aNSt9QT8dmpDK1eE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0119.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::9) To IA0PR12MB8301.namprd12.prod.outlook.com
 (2603:10b6:208:40b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8301:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 1981b7a7-9bf6-4673-8214-08ddfc28f61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mzg5VFVBU0J4REJETXcvalBYS2h6N0gyaG8zYzRNY0MwbWtITGVpaFBIYXlM?=
 =?utf-8?B?SjdoWUIyZjNUVlh0Rm04WURLbmZxZGVKRTVid3c0QmNrNm5TaFVzaEF0Qitx?=
 =?utf-8?B?d2l1TS9qRUJRWkErdkkxVU1sVUlpOUlrN3Q3eWVjN1VpNkI0eXJUMHU4Qmgy?=
 =?utf-8?B?ZlA4RE5JejkwcTRpaVlrUklFVFJJdFFtL1lXSGlpelYrdXZtemZJREVoUlNV?=
 =?utf-8?B?a3liTjRrTnkxWDVQdEVMU2tvQWplbkJZNXR1aThXcWV4MzZWZVNpdWJFR3I3?=
 =?utf-8?B?V0J3d0RqNTVmWlJWaFBRbHBmN3hzZ0JVSU5SYktLeHY2R3loS0FuMXZsQVR3?=
 =?utf-8?B?cVYvYzczZVBKSjVPeFdiclNPUnJDNTlqL0JKcGRZSVJlbXlrallVVThVKzQ0?=
 =?utf-8?B?WnFVRFpyN0lpL0liZjNYaHNQY3d1SE5jWG8vemQ1M1FINnRuRmxHWEhaQjJS?=
 =?utf-8?B?Rnd3cCt3VXZrWEdGa2RKYkU3UGRZVVdaSHViK0tuVFZHMmdXeFRiMXdReUha?=
 =?utf-8?B?YWlYYWR6YjJJMk45dkQ4SFN3ZkI0VXZWMENuTllVSFRwZkFuTElGRHNQaitw?=
 =?utf-8?B?QnIrNFd0OXlMamw5dUd5S2NheWY0M1pmVGxmY3BsVWZOTDVraGV0OCtyc0Vj?=
 =?utf-8?B?VUpiN2VSMXBITW1idlU4dVNNeTlvbHpvS0w0dDhKZFc1Wlkwd0xqSlBXczB3?=
 =?utf-8?B?UGsvTUs1RExPcG5RWTJrdDQ5eGw5eU5rZ1FmQWcvY1JvUG5NMzN0dG1tcS9I?=
 =?utf-8?B?WmZLSG42SnMzY0gvaUNuSFdSVnJGMXJVc3JQdldmODEyMHNSWlc5L0hMR09U?=
 =?utf-8?B?bm96bXBFRjJrRDN2dklZSkQ1aEJpZzZqemVHek84VCszWmY2eEZWMHFtcVdN?=
 =?utf-8?B?dlZzNStxRk5ubUpEWnQ5M3JvYmQyS0wwK3QwT1Y2bTRmVTR5RjFlaGR2ZENs?=
 =?utf-8?B?UTZLUlg1cmhpek5udVBobDBlNkZObjM2N0NhSjZFZVdyMU5FYk5KOUFvQTVT?=
 =?utf-8?B?Vm9VcXVVK0pZNmhFRlFESnFoNWQwOU5zNTVad3c0M3poSzVTRjAwanRSbjhD?=
 =?utf-8?B?REdldDZBUGxXV3dPSmtZam1QS05LcmYyelVtT3pyMTdyRUtnalgveklQWkRv?=
 =?utf-8?B?QjJ0ZS9yR21KYWNJUHcyY1pKbGJCVHpOM28rME5Kd2wxK1hYSERTYWlQZ0Z0?=
 =?utf-8?B?RHNrZXkrQ09HeWJnZE9NRkx2UUUxaFI4bG9UcGYyOU1SQ3lNWkFlU1IycXpP?=
 =?utf-8?B?UksySGdId1BzdU5WdEhqOFpURVlpd1FPdHlFb2V1azVmYVFKOFkydUh6L1hT?=
 =?utf-8?B?anAxT1ZkR2hXb3JEV1UybGJYMmRjdmtMTEdQSGdKWm4vOGQzR3RqVUMxWFl4?=
 =?utf-8?B?RHNmdGdIU2MvcXp0ZWtTN0VvYnlRd3pyNGdIRkJQci9ySHlkV2lDQTNEZUZr?=
 =?utf-8?B?Qy83MDNId3NiT1lMd2lvbWJJenFHbCtIYVRxSnpuR0NiN0FtMHdMMytMZDhq?=
 =?utf-8?B?ODdrYjBLTFRGNDdpQkJ1SEFQbXNVdSsrTnFQci9DQWJLN1dOZ3gzdzJ4SXFS?=
 =?utf-8?B?cFZyclYvc3VMOTlyNTQ3eGxGajVONnFGYkMwL2Y5MmVIanFRc2NXUFR3QXJT?=
 =?utf-8?B?QkF1eGhUWFBDM0pSZWgwR3NkYUFvaVRCb08rVkxpT202WGFwUVJpaVhWZ0Nl?=
 =?utf-8?B?Zy9mT2poOUFVSFBmWWFYcytuUUZub01ocFZEUXhwODM4UVJIWVdvWE1QOEIr?=
 =?utf-8?B?amxPZVR0WmtVUTVKZ3lOUFhKRWRXS0tJWC90MjlFYnBEejZoOVcySExkNi9L?=
 =?utf-8?B?cktZcnpaMkNzZkp1QjJDSEhkeVVqc1ZoYmZ0VVdrc1ZWVUpGWG1UWUltK0pl?=
 =?utf-8?B?SVQ5WFE4TzdqTmhUNnpBRFJZSHo1TGJ1cjV3T0dqNjBQOVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTA5Rm1XbnRsaVhrNU1KSlpvYi9PL1M0ZVkyZFVnQlQyQm1CaklzZjc5MFEz?=
 =?utf-8?B?aUs1QzFyejhlTFh0elZacHNPUy9aaGJhMnF2RVM0bEFHeU1WMEVwUG1rdWdT?=
 =?utf-8?B?UFRMaGd0YnFQcTJpcHhZdStvbUx5d3ZGeWhkSjl4djNkdC8zV3BJTE5oQkpV?=
 =?utf-8?B?Y0ZYTkJjVlJuMHNic0NOS1JUVzVMYUV1d3c5K2xPVHltWHZPaEd3QTQ0eGwx?=
 =?utf-8?B?aHJvYlBCKzB0bGx1dTRmZjljTnBWWC8waTNrbEVKV29EQVFnMms2ZStOR0Rk?=
 =?utf-8?B?Wm9CbjQxSjFES2FoUFhqY05UcTZGSEs4cngyT3NpOVR6c2RVak9YTkllZlFO?=
 =?utf-8?B?MG1nWTgwdzlGak4wak1sdHRVTHMwaG1ZNmxFeDVRbXY5VW1YMElSS2gvNklF?=
 =?utf-8?B?VXlyVFNLSHNhOTBwckh2dmlpakpxWFA4Y2ZHUVBzU2J6N0lwQy80Tzd3ZjRl?=
 =?utf-8?B?NE5BZWJqZDhVWWQxd1lDQWR0RDhSTHVBSm02U2lEZVVHaCtBd1R3TXdlTmV1?=
 =?utf-8?B?YmZoQjh4ZHVaSGF1RmhmMkRPWVI5TGx2cDJrU3dwSlFra3NlNFVqVDE5N0Np?=
 =?utf-8?B?dzBTMVljTndXeW0zR3g5N094RjdKOXNibDhrVHZOb0F5dnBYNzE5ODc1cWVo?=
 =?utf-8?B?ckdnOE5tMUppZkthRG5wcmo2LzZDWlJ4WHhlWmluN2o5ZUJDSWtFcU1RS1lF?=
 =?utf-8?B?UmVlMktrdDFSZ25VcTFuYWJTdElPS0FkaWNLZHJ6SEZlNDNjNjV1dWFuK3RK?=
 =?utf-8?B?YVY0RUNWR0FhNGpkTXhUdm9OMldyNExrQTJUVTczU0Jvc2RpQjBCQ3BIQTMx?=
 =?utf-8?B?eHdER3pObjBtV2lEeXV3SzFIakFZMzRSL2VmZEhHNGdqcVBjQU5nMDVnZWJQ?=
 =?utf-8?B?cjFac1NGYWVxbWZoaHRYV1VtRitFZlBXNk1RVEhOR1R1QzRMYStBcGF3OHpD?=
 =?utf-8?B?VWkvQ0Z4YTl2dzdkZXFML3BRZ0ZiSkJnVEtxYXZyVXpZYXhVSndqekhoYjQx?=
 =?utf-8?B?dXJUcGcxMnVqdGJpZjYrVlY0K3Q5Vy84ZnhxSlJudTRuaDliaStlaWFFRWl2?=
 =?utf-8?B?aXR1VmNEc3hIS0RZM2N3UjJ0QnJxaXM0SWVxejg1VnJRaDQ0bFNvSGExUFVt?=
 =?utf-8?B?U1A2aHQ2dUJVWXJhdEZWYWQ5bG10WVdLZGZwQWFuUDVSdmFRWEFoK0x0eENH?=
 =?utf-8?B?RWozZS9BdUVNZ3pxSk5oQWZKaW45RTI3dFhyejRDejdFV1RUQ0VXSng5aktX?=
 =?utf-8?B?UWlyVVcrYzhtTVl2SFViRGpFZitTNkh1KzVlK1NkRFkwSERxQk1IemNVM1k5?=
 =?utf-8?B?N1dwQ3A1RUJRNnBlK1pFSGtQWlJYRVpzVmx0MHNMaEEwbFZIMU9wK1hKK1V4?=
 =?utf-8?B?ajJKeXRnMEdUN3Jqcy8xNEtqY24xNW1kZ0xnSGRxcDhVYXI1WGlRdEdpeDRB?=
 =?utf-8?B?WG1IN0J5bk1XQmJXditBaG4zY244ZXNvREQrc3RSMXZpcm5KVjV6Y1FLT2VW?=
 =?utf-8?B?RFNBTkFBZmJZOFVGZFJRWmJxZWp4UXVJYWN3ZENTWmREWG56R2pKd3Y5REFQ?=
 =?utf-8?B?ZXY4U1VmaUdJK2FjelJubHFQd3poSk5oTUk0c3J2d0xMaXBkelNoKzRiTnpn?=
 =?utf-8?B?d3phVEpNcU4xSkV3TE9RWVBmUHdWR3p1c3lUdXRyUnFWOSs5Y296UWwrTlkv?=
 =?utf-8?B?a0kwWVFEc3FHNkV3clNmUnMvUjdJM1N5UnlwTVRvY2ZOTkF2U1lHdllXeEh0?=
 =?utf-8?B?cGQycHpHalk5YTlzN2U0bWVwZnpYby9zblk2NkZINEUvaTFXU2dZaVZ4Rk9H?=
 =?utf-8?B?d29GbEtpUy9jS1F1eWJ2NzZMejR6T0xqU1NtYnVVaFJ4NkY2c2U2dUpyT3k1?=
 =?utf-8?B?N2hLVkQ4RldDbjhpTlBCMEtQRC8vTi9qOGZzWTdqamNxT1N0SWV2YWJGOU1y?=
 =?utf-8?B?QnBZekI1Zy9TVWNXcU9sSGptaE85Qkk3ZGtxNE4rT2hFOGpEdSsyZm4rR2Fw?=
 =?utf-8?B?RzNIWlRBQ2NQVGlYQU9pc005R1F3Q0xNVFdIMlI4TUZRbmM1bW9McENkSEhK?=
 =?utf-8?B?SjJ5NFZCc0VVcXBSaXh2SW9KVTQxK2xwZjdWYTE4amFoYmMzQ3BYWTJDZitM?=
 =?utf-8?Q?oR8TdgCBhigxyyl3PqU7Pny7A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1981b7a7-9bf6-4673-8214-08ddfc28f61e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:45:01.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdG6/2ohUNSC4QxtMEYiYUq33uF1b0EPSH9XjLdKv5iaUIEJEhCKsel33qZSIZN2i+SDHv4UtqphLoJ9cHNQtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648



On 9/25/2025 8:20 AM, Sean Christopherson wrote:
> My apologies for the super late feedback.  None of this is critical (mechanical
> things that can be cleaned up after the fact), so if there's any urgency to
> getting this series into 6.18, just ignore it.
> 
> On Wed, Aug 27, 2025, Ackerley Tng wrote:
>> Shivank Garg <shivankg@amd.com> writes:
>> @@ -463,11 +502,70 @@ bool __weak kvm_arch_supports_gmem_mmap(struct kvm *kvm)
>>  	return true;
>>  }
>>
>> +static struct inode *kvm_gmem_inode_create(const char *name, loff_t size,
>> +					   u64 flags)
>> +{
>> +	struct inode *inode;
>> +
>> +	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
>> +	if (IS_ERR(inode))
>> +		return inode;
>> +
>> +	inode->i_private = (void *)(unsigned long)flags;
>> +	inode->i_op = &kvm_gmem_iops;
>> +	inode->i_mapping->a_ops = &kvm_gmem_aops;
>> +	inode->i_mode |= S_IFREG;
>> +	inode->i_size = size;
>> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>> +	mapping_set_inaccessible(inode->i_mapping);
>> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
>> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>> +
>> +	return inode;
>> +}
>> +
>> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
>> +						  u64 flags)
>> +{
>> +	static const char *name = "[kvm-gmem]";
>> +	struct inode *inode;
>> +	struct file *file;
>> +	int err;
>> +
>> +	err = -ENOENT;
>> +	/* __fput() will take care of fops_put(). */
>> +	if (!fops_get(&kvm_gmem_fops))
>> +		goto err;
>> +
>> +	inode = kvm_gmem_inode_create(name, size, flags);
>> +	if (IS_ERR(inode)) {
>> +		err = PTR_ERR(inode);
>> +		goto err_fops_put;
>> +	}
>> +
>> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
>> +				 &kvm_gmem_fops);
>> +	if (IS_ERR(file)) {
>> +		err = PTR_ERR(file);
>> +		goto err_put_inode;
>> +	}
>> +
>> +	file->f_flags |= O_LARGEFILE;
>> +	file->private_data = priv;
>> +
>> +	return file;
>> +
>> +err_put_inode:
>> +	iput(inode);
>> +err_fops_put:
>> +	fops_put(&kvm_gmem_fops);
>> +err:
>> +	return ERR_PTR(err);
>> +}
> 
> I don't see any reason to add two helpers.  It requires quite a bit more lines
> of code due to adding more error paths and local variables, and IMO doesn't make
> the code any easier to read.
> 
> Passing in "gmem" as @priv is especially ridiculous, as it adds code and
> obfuscates what file->private_data is set to.
> 
> I get the sense that the code was written to be a "replacement" for common APIs,
> but that is nonsensical (no pun intended).
> 
>>  static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>  {
>> -	const char *anon_name = "[kvm-gmem]";
>>  	struct kvm_gmem *gmem;
>> -	struct inode *inode;
>>  	struct file *file;
>>  	int fd, err;
>>
>> @@ -481,32 +579,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>  		goto err_fd;
>>  	}
>>
>> -	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
>> -					 O_RDWR, NULL);
>> +	file = kvm_gmem_inode_create_getfile(gmem, size, flags);
>>  	if (IS_ERR(file)) {
>>  		err = PTR_ERR(file);
>>  		goto err_gmem;
>>  	}
>>
>> -	file->f_flags |= O_LARGEFILE;
>> -
>> -	inode = file->f_inode;
>> -	WARN_ON(file->f_mapping != inode->i_mapping);
>> -
>> -	inode->i_private = (void *)(unsigned long)flags;
>> -	inode->i_op = &kvm_gmem_iops;
>> -	inode->i_mapping->a_ops = &kvm_gmem_aops;
>> -	inode->i_mode |= S_IFREG;
>> -	inode->i_size = size;
>> -	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>> -	mapping_set_inaccessible(inode->i_mapping);
>> -	/* Unmovable mappings are supposed to be marked unevictable as well. */
>> -	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>> -
>>  	kvm_get_kvm(kvm);
>>  	gmem->kvm = kvm;
>>  	xa_init(&gmem->bindings);
>> -	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
>> +	list_add(&gmem->entry, &file_inode(file)->i_mapping->i_private_list);
> 
> I don't understand this change?  Isn't file_inode(file) == inode?
> 
> Compile tested only, and again not critical, but it's -40 LoC...
> 
> 

Thanks.
I did functional testing and it works fine.


> ---
>  include/uapi/linux/magic.h |  1 +
>  virt/kvm/guest_memfd.c     | 75 ++++++++++++++++++++++++++++++++------
>  virt/kvm/kvm_main.c        |  7 +++-
>  virt/kvm/kvm_mm.h          |  9 +++--
>  4 files changed, 76 insertions(+), 16 deletions(-)
> 
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index bb575f3ab45e..638ca21b7a90 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -103,5 +103,6 @@
>  #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
>  #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
> +#define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
>  
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 08a6bc7d25b6..73c9791879d5 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1,12 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/anon_inodes.h>
>  #include <linux/backing-dev.h>
>  #include <linux/falloc.h>
> +#include <linux/fs.h>
>  #include <linux/kvm_host.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> -#include <linux/anon_inodes.h>
>  
>  #include "kvm_mm.h"
>  
> +static struct vfsmount *kvm_gmem_mnt;
> +
>  struct kvm_gmem {
>  	struct kvm *kvm;
>  	struct xarray bindings;
> @@ -385,9 +389,45 @@ static struct file_operations kvm_gmem_fops = {
>  	.fallocate	= kvm_gmem_fallocate,
>  };
>  
> -void kvm_gmem_init(struct module *module)
> +static int kvm_gmem_init_fs_context(struct fs_context *fc)
> +{
> +	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
> +		return -ENOMEM;
> +
> +	fc->s_iflags |= SB_I_NOEXEC;
> +	fc->s_iflags |= SB_I_NODEV;
> +
> +	return 0;
> +}
> +
> +static struct file_system_type kvm_gmem_fs = {
> +	.name		 = "guest_memfd",
> +	.init_fs_context = kvm_gmem_init_fs_context,
> +	.kill_sb	 = kill_anon_super,
> +};
> +
> +static int kvm_gmem_init_mount(void)
> +{
> +	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
> +
> +	if (IS_ERR(kvm_gmem_mnt))
> +		return PTR_ERR(kvm_gmem_mnt);
> +
> +	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
> +	return 0;
> +}
> +
> +int kvm_gmem_init(struct module *module)
>  {
>  	kvm_gmem_fops.owner = module;
> +
> +	return kvm_gmem_init_mount();
> +}
> +
> +void kvm_gmem_exit(void)
> +{
> +	kern_unmount(kvm_gmem_mnt);
> +	kvm_gmem_mnt = NULL;
>  }
>  
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,
> @@ -465,7 +505,7 @@ bool __weak kvm_arch_supports_gmem_mmap(struct kvm *kvm)
>  
>  static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  {
> -	const char *anon_name = "[kvm-gmem]";
> +	static const char *name = "[kvm-gmem]";
>  	struct kvm_gmem *gmem;
>  	struct inode *inode;
>  	struct file *file;
> @@ -481,17 +521,17 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  		goto err_fd;
>  	}
>  
> -	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
> -					 O_RDWR, NULL);
> -	if (IS_ERR(file)) {
> -		err = PTR_ERR(file);
> +	/* __fput() will take care of fops_put(). */
> +	if (!fops_get(&kvm_gmem_fops)) {
> +		err = -ENOENT;
>  		goto err_gmem;
>  	}
>  
> -	file->f_flags |= O_LARGEFILE;
> -
> -	inode = file->f_inode;
> -	WARN_ON(file->f_mapping != inode->i_mapping);
> +	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
> +	if (IS_ERR(inode)) {
> +		err = PTR_ERR(inode);
> +		goto err_fops;
> +	}
>  
>  	inode->i_private = (void *)(unsigned long)flags;
>  	inode->i_op = &kvm_gmem_iops;
> @@ -503,6 +543,15 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	/* Unmovable mappings are supposed to be marked unevictable as well. */
>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>  
> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		goto err_inode;
> +	}
> +
> +	file->f_flags |= O_LARGEFILE;
> +	file->private_data = gmem;
> +
>  	kvm_get_kvm(kvm);
>  	gmem->kvm = kvm;
>  	xa_init(&gmem->bindings);
> @@ -511,6 +560,10 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	fd_install(fd, file);
>  	return fd;
>  
> +err_inode:
> +	iput(inode);
> +err_fops:
> +	fops_put(&kvm_gmem_fops);
>  err_gmem:
>  	kfree(gmem);
>  err_fd:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 18f29ef93543..301d48d6e00d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -6489,7 +6489,9 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
>  	if (WARN_ON_ONCE(r))
>  		goto err_vfio;
>  
> -	kvm_gmem_init(module);
> +	r = kvm_gmem_init(module);
> +	if (r)
> +		goto err_gmem;
>  
>  	r = kvm_init_virtualization();
>  	if (r)
> @@ -6510,6 +6512,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
>  err_register:
>  	kvm_uninit_virtualization();
>  err_virt:
> +	kvm_gmem_exit();
> +err_gmem:
>  	kvm_vfio_ops_exit();
>  err_vfio:
>  	kvm_async_pf_deinit();
> @@ -6541,6 +6545,7 @@ void kvm_exit(void)
>  	for_each_possible_cpu(cpu)
>  		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
>  	kmem_cache_destroy(kvm_vcpu_cache);
> +	kvm_gmem_exit();
>  	kvm_vfio_ops_exit();
>  	kvm_async_pf_deinit();
>  	kvm_irqfd_exit();
> diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
> index 31defb08ccba..9fcc5d5b7f8d 100644
> --- a/virt/kvm/kvm_mm.h
> +++ b/virt/kvm/kvm_mm.h
> @@ -68,17 +68,18 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
>  #endif /* HAVE_KVM_PFNCACHE */
>  
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> -void kvm_gmem_init(struct module *module);
> +int kvm_gmem_init(struct module *module);
> +void kvm_gmem_exit(void);
>  int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
>  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		  unsigned int fd, loff_t offset);
>  void kvm_gmem_unbind(struct kvm_memory_slot *slot);
>  #else
> -static inline void kvm_gmem_init(struct module *module)
> +static inline int kvm_gmem_init(struct module *module)
>  {
> -
> +	return 0;
>  }
> -
> +static inline void kvm_gmem_exit(void) {};
>  static inline int kvm_gmem_bind(struct kvm *kvm,
>  					 struct kvm_memory_slot *slot,
>  					 unsigned int fd, loff_t offset)
> 
> base-commit: d133892dddd6607de651b7e32510359a6af97c4c
> --

