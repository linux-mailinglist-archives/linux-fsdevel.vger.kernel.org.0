Return-Path: <linux-fsdevel+bounces-62668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75005B9C20B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 22:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D883BF29D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16832A839;
	Wed, 24 Sep 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1RJUEe3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDED32A3DE;
	Wed, 24 Sep 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746127; cv=fail; b=RyvzePgdDbNqmn97J+zE/+qRUSJiKokRAi4lntvoV/pB8uInhEP6Cg+3FjlWVvs26S25ewkzxhss6N5LMS2WvHXjSrYzmLLvZpwtt73HFNfmoyUeQjuk0Bx8sKG7Vo8G1m3cGN4w/+SkovSEZSL71cbv7xnHRbh6jInLXWeSeko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746127; c=relaxed/simple;
	bh=q+bD5SmhIL3qBSvQDac8JLl3an5Aa6v1Vy8SrRfxaOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jFqpkpRcRRENrhOKc73IV/9sOWOImqlrRy0C24aMAKiOT0mzh9gktOpWBOzw8VcKFDwwBHPrdlJBeWnBoLFPiOY+s75G40Rxgkyg9JmTJAQUBncdaXjLxIFBkIKjJgRNH7sJF5KUMRBuanYf4j1RGYyVcOA3QIVDnqO4N2GFrTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1RJUEe3G; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVt84lDl6Yjq5Qa1UTUN7JGeY489oJGgjIPHP/fp+001Q0+xpMg/ay/3Dxkq5LrvBPaoxzggg83euLbjN7KRqdQ+hh3HpXJfzRoepVQsTh91HeTuIdy8VYpGpBS1S/5yXS0KHi2oV99+qHxQwstdJ/2Z7YSXJq3M31TuQcy1B15/H6qDJnPyGxiu/85ij+x5ZYgISka4YghukGTJ5z6BPYSF/TS/7G+QKuPy4EIWOzA3zhm1ZBgh83QEEWwfrExrpwUzwIB+YwGwGS2N/bPXvDyAbyYm9gfN8wy6F0NXv2pDz+YhIwIiS3r1Gk3eEN+mWyIiSZDRr9VRH4wnqTzeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suh4C75ktQKXPgZ1yuZpuqhdixVMXh0SuYK+jegbXWI=;
 b=Of88vWkIxB0v9qHIlvNtCXoWQvSYjgGy8qRkn0wZ0bvE7j6Qj9G4cokw7queE4YgF4Z8LQX4ILbHi6HKsmtf7mEWo0zbAdRjDGpPNp73zVS5xx3foGAhWRWOjYgdwEdXljsgQzI+AM/s5NXVkZa9ueGEdlfo9w+vsdW+E8s1iaSQaF391pHZsHO8Yr7jFeAcH22R+0UzxyWhh76ItKdBklSiLGKd2B4P4q0L8aXOOKofOaahDQkrR8td399HMoBCuwIBD1lu8oG4yKChJFss6X9elNO9md2CPCcHr17qWb2yXJme3PrQUAUhAPcbQ29CG2OolgfEzoY6ai8v8byCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suh4C75ktQKXPgZ1yuZpuqhdixVMXh0SuYK+jegbXWI=;
 b=1RJUEe3GdJNGQwsfmz3Eid8db/tmjSumgINLFfsQnm3hPAIAxlwX1lTaacbLQb/OfXnuAxhAo7DsW7R21ziysI7vFXyHqxuuN//XLyZ3my4cYmcYYerijT24ASpIEFwtw8uFQXAV9eVLnceRbGn5VAlZlb0+SqngSTCSAXmXC94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 20:35:19 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 20:35:19 +0000
Message-ID: <b4abbdfa-8a4e-4c2b-a979-f940fcab37aa@amd.com>
Date: Wed, 24 Sep 2025 15:35:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 0/7] Add NUMA mempolicy support for KVM
 guest-memfd
To: David Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>,
 willy@infradead.org, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, seanjc@google.com, vbabka@suse.cz
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com,
 josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com,
 jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, ackerleytng@google.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, gshan@redhat.com, jgowans@amazon.com,
 pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com,
 suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <1b01ebab-a43e-4344-ae38-50f0a031332f@redhat.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <1b01ebab-a43e-4344-ae38-50f0a031332f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0058.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::9) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 67873eba-aa38-473e-a5ab-08ddfba9e069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm5Zek5iRFhtb3lHS3hSYktBbWt4SUlMeFRJZnFEc3pEdFhLaCtQdjZmT0Ru?=
 =?utf-8?B?TXZCQ085QmpGNm1uRWdMMTFBOEFhd3Z6c0hqN1V4T1pKYk9Qb1pwdkZ6UWFk?=
 =?utf-8?B?YlFQWnFwREVwRnUxY0pOTTZGZDJNUlJobFRrbTVhS2MyL3pNbjJtL1hueFV6?=
 =?utf-8?B?MnNRL1VVejFhQ0lURVJkdmRaYm9OdHk0Mm8vdVVNZWFtbDRIdVUvL1Jwek1Y?=
 =?utf-8?B?STJCZVNIS2JIOHNNL0Vxd1RESzhiUUNKeUtBQ2dUNU9xYk9UMS81ajdDZWhP?=
 =?utf-8?B?NDdKOVRGRTNiakZYaEJ5bHNOTGdKUUJVbkNobENsaUNCMmtlYkRxWDJORkdz?=
 =?utf-8?B?Vzk3M1FiZ3JKcGZmc3ZXWlBWUC9KYnoyU2hSeU01dVR3RlMrRjIvdWFJSXNx?=
 =?utf-8?B?R1dhcDVOMjNVam03N3lyUG1jd2I1LzdHQjZyWWRHYnJxWFByM1V3TVVpU0pp?=
 =?utf-8?B?aXBGaEhaUzFMNzI4S3dPMzB4ZjdsYktEaDJDNTNlaFhwUXo3WlJGSk1Xcmcr?=
 =?utf-8?B?Z0hYU1k0SEQ0a0hJcXdMSk41d0RpTVNQNmpwOWNMN0h4UWY1OG1jMkJ4SUJ5?=
 =?utf-8?B?M0JaZXZsejUxSnc2SGoyL1pYdjRsNkp5RDR5bDFZRU5iOVJyU3hYUVl2ZDhu?=
 =?utf-8?B?ZmlRZmhJN3ZEazJnSVJvbnRyR1l4cUljWjVlVVNleGFSbnNWWG1zQytMb25B?=
 =?utf-8?B?OGxpYkUwRXU3aTJEbndkSTZrQXgzREpUd0V6UE5ON2oyLytrMkpObnlSN2tk?=
 =?utf-8?B?S2plcGFUZ3FSaTQ2VTMwdzlockhpTzFxUm8yR2NjV1F5RDNKZW5naGg1dERu?=
 =?utf-8?B?cHZwZkhKd04zdGZMVjFTVXB6aXBvektRNk9iZ1N3NEZwczBJYis4dDgxWm9J?=
 =?utf-8?B?Y3Myd0h5NnhBSVlMUHAxcTllRmtTY2tGVmhNYXFHd1Rad0tmVTR1ZDE3TEhz?=
 =?utf-8?B?YTViNi92ME44dXA3alQyYmxZZTlTcmxlT1hUa1lwM3lkNllNQTlrMzQzdEJz?=
 =?utf-8?B?cjQydjdlUXZzZzJBVWFkZFhZRFY5dGNKZUZCbFdZeDQ1ZVBieXFZWGt5Z2g3?=
 =?utf-8?B?NEVzWi9QeW1IcnVZUldhQTJKVzhJQzZHSURPMzdXMlNNb2lpdENoSzVCS212?=
 =?utf-8?B?YTl3aDd6Z092T3FiVXZuTXFWUlkyOUN1L2tZSFRmUjdkZWRnTTB3V3lmdFNB?=
 =?utf-8?B?MHVLcjk5M01GVGNLbCt0bmJtU3BKaHVNLy9FVjVqVGM3R2NvcGRxeFFFb3Nl?=
 =?utf-8?B?NW51ajNSZWNiTkN1ZmkvRk9yOW5FK2xOK29aYUJLeVlJMzVIbU5NaHlMN05P?=
 =?utf-8?B?RGJPZkRsWWhCcVpKSGlvRmhBcjUzTHFDTE9pTlgvR3JXeWIwZnNseW15SHlY?=
 =?utf-8?B?eG1oTWJFdE8xUmR5amd2Y0JNMlVlaHNnWnp2Y0drVVlvdkphcXNETXdmeUE3?=
 =?utf-8?B?Vi9ET2VrK29nZFZJR215bmVTYzgrWS8zd3NndXhON3pZZ3E1c3FkYk9XS29w?=
 =?utf-8?B?MFFmRUd0OC9yTGxPYk5EREdnUGtTN01tWFcyMkNwYXFhNnZmU3lhNC9NYWJG?=
 =?utf-8?B?NklZUGRtUUVNREM3UnVlZUFjQTFUNS9XaFFFVGJyL3lTM0dHeXc4UVpzemJk?=
 =?utf-8?B?aVdCMHdMRkczWlVZWTQxZTNjeTRYd0xlY1NXMk9Fb2tXa2h3RGlWVmpJSWR3?=
 =?utf-8?B?NHVRZnBhWEJ0M3IrTHBxNzNVK01sdlJJSkFBNnJBNTdlbkphQU56Wm9tVE9r?=
 =?utf-8?B?UHE3MWhUNzJlT3ZONVc2Z3BYOGJxcnBPNWVtclhybGJzZ3RRYUN3MGhMUWZP?=
 =?utf-8?B?bzV3S0VWZ0Y5dURTVmpmT2FUcE5NdHVrRHVRcFlVOFQ1ZEl2UzFiY0JMbFJw?=
 =?utf-8?B?ajBOWXdNM0NIc1BvMXFRalZrOG5RY1AzL1ZmVkREMFJzeTBnb09uUHozS0dY?=
 =?utf-8?Q?Cd8iQK1pkUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWduQjJnTzRLVjU5eVpGd0xUdVVWQzcwZk0vMEdsMWxVY010b1BMRnJkWXZk?=
 =?utf-8?B?ZG8ycitFbnBZVERpQ2J4VjRqbjdpY2NmRXZKZjhEM1Q2MXBVekNFQ2ZkR2lP?=
 =?utf-8?B?Yk9rYmRMQmdJOEdzb28zQUQwRGFxUVpaaUtnY0lDNHh2K014WFlyaGY4TFpP?=
 =?utf-8?B?VU5Nc1FSbTcrMkNJdW5CUm16Yk54M2FseUZGclZFR1RGUXUveFFOZmVHcnBa?=
 =?utf-8?B?NTg1NHI3TVJZbm1semh5Z0VSSGVnd1dHYTNjUnJ1OUdCS1FsSlU3d3FTK0tB?=
 =?utf-8?B?OGJwM2JmbVZjOW1wZjFVOERuc2RMYzVVUm1Fb2MwZVE3bER0NjJrRVkwblhz?=
 =?utf-8?B?ekpVaXZLdkx5SjhFcTdEL2tHZmU1UkE1VHNSdE5tcEJLVldwNS85M3BTcDhF?=
 =?utf-8?B?T3F5UXJXMVRxbEp0c0c3ZG4zUnk5ZDA0U2QwMXIxQjhSNXk4ZDRxcjlEWXNV?=
 =?utf-8?B?eUpGeERCSDNTVGorT09oNnZuMnh2ekwzckJjNHltS2VPWHZEbzEybk10S2pz?=
 =?utf-8?B?R3lBTjM4Q0g3dU5KWkVUR0ZXU1RyNEpzUVhVZG5iUmY1OFVwaVBPV1d4Wm9V?=
 =?utf-8?B?aFpTVThadktIK0d5VjVzS28vRDIzTUY5TENWaEx5N3FneFJWK05YNGdqRXQv?=
 =?utf-8?B?bG1ydUk5amdHQVRadXpKbzFobFl0VCt3Umtrdks4eFcvTnJsa1ljL0k2UWp3?=
 =?utf-8?B?L080L3FsVFEra0JuRlhWY3RUM0RmT2hCNVVzamFGOGJGZ1FydFhrMTVvQWRQ?=
 =?utf-8?B?V01RV1Z4U1FLREN0cVJleHF3cG9WejN6QjhkZTFjMmtuYTlBWVg0UklsaWdM?=
 =?utf-8?B?eFo4NjdqamJGSGRlNFlOSTlpbkVwbUlsKzFNYmNGQ0d4eUpvNmsyUVRXSFo0?=
 =?utf-8?B?c2FHUFo3aHJXQzNXblBaUTBDY1ZlNi9xZ0VYV1h4alZRV1d2NzQvc01rbXBh?=
 =?utf-8?B?NUF6L2FQV25QdXgrR1o5emFtKzZ6Mzc3M0M1TUU1akxhYms4S2hZVnBjUEJ0?=
 =?utf-8?B?bUpJWDZTdHd2ZXVNb2NHcmhxbzU3UW1WZnUyR2pSN1YrSGhyckt2dTJZa3Zx?=
 =?utf-8?B?bS9LTFBDdUVHNWJ0MEpKQkFxT01hTU1kcEFWcll3cmYrRnJhOFg1MjR5QWxB?=
 =?utf-8?B?dXFPeTVFc3FiOXdDSzk5cDlkczM5T2dQTFl6YUM5Z1IrSEZ5N1JBZldob3FG?=
 =?utf-8?B?UG15cCtvbXJjT3FzTnVFWW5CcklURXdpeGhud0RqTUIwaU8xbDd5RmZ3dk4v?=
 =?utf-8?B?d2NXa0tkVFdKWEVLSUp2dGd5SS9kNmVnNFFLb2d2WExZNkNjM2s2TWdBcW1v?=
 =?utf-8?B?MWxrMkxQSURlaHA5dlR1VWFaajRKZy9GTis5d05UOUpjeHVkbGwvMGt2SXpU?=
 =?utf-8?B?eFowcWVuUkozTTNYOGFvay9ham0ybFBZWCtWUTNIMEh0OW9ZcFJjbnZrd0Vt?=
 =?utf-8?B?clJXK296eEpwZ1NadW1vTE0xOVVWUG0xK0Joa3VpaTBhVC9UaXdpYVpVeEx3?=
 =?utf-8?B?WUFMajY3WnduZFU3RGJNUHlBaU1KM2lmcUYvclV3VkZTSnE5VzlyZTV6dDA3?=
 =?utf-8?B?ZERuYnozYVRzbEpqb2g0MkY5bUIzcC9lWWJvM21RZE5PckoraXNINThjV3E2?=
 =?utf-8?B?dU02M3lNcXVOeXZNcWVDb2lRNnMxYjVla0tVQ3FRRTVSMlRiR2lkM0xpSktJ?=
 =?utf-8?B?bHJpNGpsNzNRWHpPQUF4eUJYUktFZDZnR3lrYnQvUzJ5RzAwcS9hL01Hc29x?=
 =?utf-8?B?TjlNd09BRnFtbWhmZU85Ym9sWHdMam1jWm5RRUZzL1RtcmZuUnpjdkd0QU5V?=
 =?utf-8?B?VGhIUy9KMk9SMXFCRXByZU1aTFhUb3JsMnh1Yi9Vd3QvcjdiRm4vdW1mTDRi?=
 =?utf-8?B?NTE0RFcvQVVuU0ZGOUt6RmJlUktlTVFjMWJSUjUyRU9yVnJWNlVNKyt2V1hs?=
 =?utf-8?B?RThTUHRiWWorM2hRdmJGaGs2OENTWXZZNVA4aG1IYmxrUVpLdk5OYVdlNDhq?=
 =?utf-8?B?Q2t1bElSNjJ6cXlwZ0x3NWc2WVd6OW1VTU5KSzhxWFJ5SjBpeFJtTVQ1L2h3?=
 =?utf-8?B?cUt6R1JYMGFHWXJOTWRmNkZJUHIzY2ZyY085YUpkTDN4c21jNmtsb09LbUp2?=
 =?utf-8?Q?ijPlpT+Il+LaYH0egt/5hcJhE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67873eba-aa38-473e-a5ab-08ddfba9e069
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:35:19.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCMTo9GysLar1J+9LclyPYzGP96O5SNYNpl7u87iacJi4hyw0At1cN/aJ00a+jZZgfH+dD7PnvBknB1WgEqj5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202

Tested the patch series by auditing the actual userspace (HVA) mappings and seeing if the
corresponding physical PFNs correspond to the expected NUMA node.

Enabled QEMU's kvm_set_user_memory tracepoint to dump the HVA/guest_memfd/guest_memfd_offset/base GPA/size.
This helped determine the HVAs and the memslot that QEMU registers with KVM via the kvm_set_user_memory_region() helper.

After that dumped the PFNs getting mapped into the guest for a particular GPA via enabling the
kvm_mmu_set_spte kernel trace events, performed the GPA->memslot->HVA mapping (via QEMU traces above) and then looked in 
/proc/<qemu_pid>/numa_maps to validate the HVA is bound to the NUMA node associated with that memslot/guest_memfd.
 
Additionally, looked up the PFN (from kernel traces) in /proc/zoneinfo to validate that the physical page belongs to the
NUMA node associated with the memslot/guest_memfd.


This testing/validation is based on the following trees:

Host Kernel: 

https://github.com/AMDESE/linux/commits/snp-hugetlb-v2-wip0/

This tree is based on commit 27cb583e25d0 from David Hildenbrand's guestmemfd_preview tree
(which already includes base mmap support) with Google's HugeTLB v2 patches rebased on top of those
(which include both in-place conversion and hugetlb infrastructure), along with additional
patches to enable in-place conversion and hugetlb for SNP.

QEMU:

https://github.com/AMDESE/qemu/commits/snp-hugetlb-dev-wip0/
   
QEMU command line used for testing/validation:

qemu-system-x86_64 --enable-kvm -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,convert-in-place=true
-object memory-backend-memfd,id=ram0,host-nodes=0,policy=bind,size=150000M,prealloc=false 
-numa node,nodeid=0,memdev=ram0,cpus=0-31,cpus=64-95 
-object memory-backend-memfd,id=ram1,host-nodes=1,policy=bind,size=150000M,prealloc=false
-numa node,nodeid=1,memdev=ram1,cpus=32-63,cpus=96-127 

(guest NUMA configuration mapped 1:1 to host NUMA configuration).

Tested-by: Ashish Kalra <ashish.kalra@amd.com>

Thanks,
Ashish

On 9/24/2025 1:19 PM, David Hildenbrand wrote:
> On 27.08.25 19:52, Shivank Garg wrote:
>> This series introduces NUMA-aware memory placement support for KVM guests
>> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
>> that enabled host-mapping for guest_memfd memory [1] and can be applied
>> directly applied on KVM tree [2] (branch kvm-next, base commit: a6ad5413,
>> Merge branch 'guest-memfd-mmap' into HEAD)
>>
> 
> Heads-up: I'll queue this (incl. the replacement patch for #4 from the reply) and send it tomorrow as a PR against kvm/next to Paolo.
> 

