Return-Path: <linux-fsdevel+bounces-62860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0EBBA2D2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 09:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB111BC83A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC72882A9;
	Fri, 26 Sep 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eyYKDUg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B821A295;
	Fri, 26 Sep 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872313; cv=fail; b=T9RWtC3+m+Z45S39pENUFsUr4KBPKgM4kTxzpSy77YP7WZlT/1gCdysfDDsn1l2Vt6Fg4Z3V7bsrw7MjDc/YQb303hojyLS8h+sMEXs/qR8y3I3/xOnazMp1NrFEn76qtTrILuMWL1Kh6SUcRq+ckid4cjUDVgTN2i+bGX9Ijrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872313; c=relaxed/simple;
	bh=esWJPoLNWh2+PrgR7RMMstPoWQo+puJ/AWLewC67N4Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L5c2f/NjA/QPAWSVZ99thA9SYBZl1l6yXhpLkZQIjILYfgrBLFUSBvrQJITK3Lh54MopEYyA+fY5c9tWgXG6KLeey/b5yfKDke3Rh/7U7OIuJCuROPDukwezPfN/ta2oZJdlv70502NiMwf1NJDaD9wQ+rmmTnA50eokPm6Bn3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eyYKDUg1; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVOYIbQqfMUx3/6ZPoak37c28QM2MyI1jpWOpcR2IBoWfwtlGfFb1mDe1vxsLCe+V7bjrmRYOO4QCEwij9eOxIYEoUTbyJ9ZJVteDcNJs2zNAGe/Sojf1i1c1A6wMhA7a2vnkJsN5jXHTQlK8UbX4wTM7s1osh9rQMTSvG34lR8UIzz4uSS5QF6wup2WRJikysBz/6tielaPcrTzKv/krRYweZB2oSBpZFVeM16rIK/ZfNVOW1leNQ6Y6MMuXjcN3dTkcQHqKnp0g2pCOCJC0i3EEgoFaQNh2LAormoThLzvFlirj5wvGqpgotpfum6wjIDPNyi0DbVKAzU2ArfgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nO6v1jBPXrL9qfNdMcZLxyETTA/u3Yf9lFrozO5XKw=;
 b=exjy5DTx3WMe3VNAthT65JIOchcWqanLq+xBW0Weluu1yb9rLZ/Mgrn/6xlufw8nu+L6uQa9BwRmig7IeFSEeAFL4y2rNcGFVbdEOiAxvBVae7uACUf29N1ZHRKBe8IttLmDsqPgJSZ61I3pK8PUHRMGFQcJ2j63n72UkNt4g+OoWcFamj+EWVGCeXtYN6w+k0ZjpFqTgeApGYEPKSGZ1aWmSQ+cIApE+MipJGK62M4W+qJ98V5rWJRgNS4jDyT81LOCqsmLLhlTJ13Q0qa+g0Itw+FqSZR9sHkQnNa5yHmW6lsashnhObTpaRb8YzD3GR3wTFp2SonTSw7YhoKjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nO6v1jBPXrL9qfNdMcZLxyETTA/u3Yf9lFrozO5XKw=;
 b=eyYKDUg1Vcce3H74yR4y6l94iMdafVA6VM32B3gkZ5y5DSr9JsjwIKDTzsGHxhF1JbujsHRoG9+r13VtSS3StpKl48SVW/mHcGvQ+7j9HD84m1JHAeCeoPbywBz5RFmI5onCWwDFEsCtUcUV986GLJA8gXw6S9XVefRDRQy+2/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Fri, 26 Sep
 2025 07:38:27 +0000
Received: from IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823]) by IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 07:38:27 +0000
Message-ID: <0e986bdb-7d1b-4c14-932e-771a87532947@amd.com>
Date: Fri, 26 Sep 2025 13:07:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
To: David Hildenbrand <david@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org,
 chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com,
 kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
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
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-10-shivankg@amd.com> <aNW1l-Wdk6wrigM8@google.com>
 <95ace421-36d2-48af-b527-7e799722eb17@redhat.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <95ace421-36d2-48af-b527-7e799722eb17@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To IA0PR12MB8301.namprd12.prod.outlook.com
 (2603:10b6:208:40b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8301:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d3eeee-162b-4ee2-bff9-08ddfccfae33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K094SHRzZVpMVGNpYVFmdU5BcTQwcXJTTC9DQUVabXc4cUtScCtHYkxPcGFo?=
 =?utf-8?B?RElyaS83REZIdlIrV2RzOG1zSmNwWkNhUytwOFVqNGNDOW9ETGdxTjQ5d2JJ?=
 =?utf-8?B?Vk5TQ0JxWW0wSkRaK2x6b2wzNHdlcmNBdExpbEljOWl0RzBKNzI4YlFXVHgz?=
 =?utf-8?B?UXBTMU5GY2VoOGUrZUliSVFlcWVUdG93K0YyT0FQRXA1RVQ3Y0QzUDNBZWp4?=
 =?utf-8?B?SXZzcUFva3RwZThZNUQ0ckxRNXNad21MNWJ4L29SeWlzTnB6U1hobUlUZTV1?=
 =?utf-8?B?VnFYMExTVXFZcGhCOEdhOU5wd0Rtcm9RTmNLb2JKaFljODRUQ1FhS1VneHhh?=
 =?utf-8?B?aU5pMk9ybURMTmpudkdjSFBaUXpMbndTUTc4L2RVdWV5SzRSUFc4aFlLL1kz?=
 =?utf-8?B?Ujhib3U2V25wcElYWklsanlreEh4ZEQvUFdvWFBydHVWa0p0emZJUzBxZkhU?=
 =?utf-8?B?TmxhYUJSWHJDeCtsZzRJWGlVbXJXVVdVU1dvUi9sR1A3bUdUSnFFM1FKL0tr?=
 =?utf-8?B?SFVpMUk0RkkyU0FmR1BLQm4rWVNDUEJ4cmVqcGwzUDg2TlZKNnVSbjRvL1Av?=
 =?utf-8?B?dENjUWR3U0FvMmQzSGw4YitaTTIvU2lYLzFQUkxubm9CSW5FdDhyTWh6VjlP?=
 =?utf-8?B?YkFvVjJRSFdMTjFZOHpnbS9hSTVEQUN6L3lLQ3Npd1Zmb0pqRHNTdDVsN2NR?=
 =?utf-8?B?K01jOFBhQ1hCS1pYbUNScDgvbnMwR2pmWlZsakRsVTJRVCtYWmhUQ1lRVXFo?=
 =?utf-8?B?cTFwbFdlMWV3VWcxU05PUzMvSXJsZTQ0YjlPYTRSMGs2ZHk4blprY1NoMHRL?=
 =?utf-8?B?dmNQWjlUVzEwUE5rOTgvWExwSXB4STBlUXlXWWwxczFjajRVeW40c3hkcmZK?=
 =?utf-8?B?YWZuaXFZNElJUk41MEpwczJGdit1akJFamV3TW9YN0w2RUVTMFVZc3ZtbFZV?=
 =?utf-8?B?SEx0ZDExL2NhWFFCdFc2cFJscHFNLzloRzMwRkRCeXJvQ09PVDU2U1RJd0Zy?=
 =?utf-8?B?THpFSHVwV1Z5Y05zSStmUWRuNERiMWkrYW00S0lWcDJHNkk2QU5xMGRuR1Vw?=
 =?utf-8?B?TmYybThvMUtUalpINjZlSzN6ekt5Qk1FbWtsQzdOL1lSVElaVUNRb2xmWUlt?=
 =?utf-8?B?VkdhMWtEejNlQVlJNzFGNzdubUlKZU1MU3phalA0Vy9PVHpDN21Ba1BOcjJu?=
 =?utf-8?B?UFZXSlFTVzFTUGpPS3ZGT3VHcExuakxaK0tzYXNOYy9jYjhXVmJndGlVc2li?=
 =?utf-8?B?SENHVVlhd2U4aitra3pMMno5b1llYTdJWE9vTHFHcTNQRnBSZzhjSnZlcFdl?=
 =?utf-8?B?TitkMnpUUVJ5bGZNMDBDQzhpQksxUTI5eGpLUEgzU0s2cXV5Y2tqUEpGN01t?=
 =?utf-8?B?YUNaSFhzNU9WZUhTRk91aThObmYyVnljeEtTQzFqNWtUMS9oa3N4ZDh1a0ow?=
 =?utf-8?B?R3NaK1h1WnBHR2w1MHRGTTBzR3UzY1YxajdRL2tWdDdZdWJQcmlwUEdxSDRR?=
 =?utf-8?B?VTVrdGpOYUVDZDRmeWNnMm1CaDVJSkJkWUhtK0wyMDZiR1BERnR0WTZtV3RS?=
 =?utf-8?B?SE5YSjludWVEdDlOTWplcTNPbWNxNVpONFRkMkR2SmhCOEtNYVVWZFJOTXAr?=
 =?utf-8?B?OHovMlpnWXQxUm5KNFVJM1dTbEVCTzJhdFlBU2lXM0pqdHVwa052ODFtc3Vh?=
 =?utf-8?B?OWJENi9WUEloT2psZUVYZGxxcEJzbmVZUWVXSU5PSVZoYTgvaExoVTlHNnk5?=
 =?utf-8?B?UGhLTWhqTXlNRFlERHQ3blJobGdGMUVCT0h1Rm1CWUJmMmxOaUR1TXN0NnAr?=
 =?utf-8?B?SGkxaHZqSjhuY3VHSFNQb1d5RC9OeVVGOXFPNHdFbWwvdEpOY0dUYXpWSEJt?=
 =?utf-8?B?TWxkdk4xTXo3T3AvanJPZHNmenU0YVZHQ1Axa1I3QWo1aXFaOU1XR0hIeW1V?=
 =?utf-8?Q?uyn4ioYfTnZ9jmnje/2WgMXE68bRDrcZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmxmdzE5UXdWT0lyblR5OHpHUmlBUEYzSDBvRHR2dEllZ1hGTmgyeTQ3RUdq?=
 =?utf-8?B?L05mcXFULzdmRlpldU1NNWR0eVQ4MVlkTXhVZVJQVmJxU2lQUXM4allhRVNK?=
 =?utf-8?B?UDFHWlRNOFlaaFRtblcxWW1nYWtMNG8wZDlpT2FhYjZHbkJiQUZ0Uk1mRjFw?=
 =?utf-8?B?dFpLelJMbHFza2J1M0NNd0k5L1Vxak5iV2hpMlVHeXQwUE1senpja3VEekhH?=
 =?utf-8?B?ZnB1d0labXowQ3AvSWhBMUxvOGdUeFZxTEdXSlZHSk81M1ZCa01GRU9XSTlM?=
 =?utf-8?B?Y0Y3YmdMdzJXZlgzM1VQcGVPYUY3cVpSemRBeTNFOXFMZDZmbmkwQ2FOSzdt?=
 =?utf-8?B?Uk5rZ0ZxcTM2ZlI4Yk5SUXZiMWUrVFNLa1d1eENWTGkwY01rZU5XR3lYUld5?=
 =?utf-8?B?T28xM2FxK1c3a1ZxNkxTNUN4Tm1TNCtIdmRVQXpQOVhkWFg5NlVZaUNZelBQ?=
 =?utf-8?B?TFJPVDYyRUJSR0ZzWnphRG9GMzJhNUk4TktvWUZBZlpDMzNCZ09xYTdmZFBY?=
 =?utf-8?B?c0loN1BZTDJPV2lxVkd5TWszZEw1bW9PZ2lrTXh4QmNNNGdoY0lsd1VUMU9T?=
 =?utf-8?B?Zk8zbEZIZ2pKcTdHTGl3OW9SUTlKenNYM2Q5ekNua0szOVFUaHdvYzlpOGMz?=
 =?utf-8?B?Tk1EMFBjMUhoaTU2SHpwWjBaNklZSVJ0ZkJma3BVN2ErbG1uWlkvb1NUUHFy?=
 =?utf-8?B?UlZUajRVNWhYRm10ekZLRS9mK2ZCb0tSaXNTVllLemxJWXdzRmZQSmlkZDFU?=
 =?utf-8?B?QjFhWWZlV0ZKNU5aNDRXMjFtRDRpM0dxZXBYclRQeVBJbTZPTWV3Vm9tNDRU?=
 =?utf-8?B?cEd0NjEydjdRb2RWY0Y1RnpsbmdPR3hVR3VmTlptdU1SUjdobGJVQm9xQmtQ?=
 =?utf-8?B?Mll1UVBxc0d3ODVCMWJVWnJ6Nm12M1dpMXd1WVo2RUpzUGFOZWJTeHN6Wk9h?=
 =?utf-8?B?Y2hEb0xQWWpjRzFZMnVHcHEzK0hmU3VaSnZlOWF5M1BOWHcyZzdySEJRcW5P?=
 =?utf-8?B?YmVWVG42c09PTXphbk82bXRFU1FXWGVlQXI5MWFCcUgzUEhocEVlTXBYeDIy?=
 =?utf-8?B?dmh0MG1KZTc1UTVYa3JjaTYycnpUemluQ0ErSEI0V1lUZ09ZUkVWMlhlVE1B?=
 =?utf-8?B?Tm4rWUtpNjlXMWI5VUt0b0F4YXpiSmFKVGZram1Ta2ZPWVYydzFaRkhKZ3J6?=
 =?utf-8?B?SHZMK0czcVMrNDJ3YTVycFE2cnl0enIyOG1ZUk1DeDBsZnZIMVNlQ29CMS9w?=
 =?utf-8?B?WGE0OTF4RG03eHk5MWtIU1J1MzNSZkZjVGZZaWVRZDJsWDNGZWNCWnozWkli?=
 =?utf-8?B?ckw3aTZQNXB4UkJNTGtHMDIyUFFsMGdMSGdPbU9ENUdoU1JSdHZOQksvZHpz?=
 =?utf-8?B?NkUyeDNJZzJaWnF5TlEvZ1JzTC9pZVk1aDV1M216bURKNmZWTVlZUWtrSk9r?=
 =?utf-8?B?VEltVU5ERFlOMThQWElzYkdvL3JvM1EvTE8rQlVYblphUWxqSUtFS1RVVURU?=
 =?utf-8?B?Ui9TV1hzc3Nva05RcDFrVnh5UjczUHhNekNXSXVsWkUyV3J5dXNJSXQyZjda?=
 =?utf-8?B?QWJYV3FZSm1WeXRyYXlOSmEySHU0N0xaRzc0RU1mWDdJa2srTEwvUy9QSFVn?=
 =?utf-8?B?akhWTDQwS0N6ZWJxYUU4bC8rdGtvNWdNN1BrS2xtQ0w5aHBMT0xzTlpEb1oz?=
 =?utf-8?B?eDllQVM0UjExeGZZRWVGL2lQanVJeC9LSkh0UnUxdFArSDQxdkwxUnhDbTB2?=
 =?utf-8?B?QlhuRzNNUE41eE1DQThoUFVrNUZkSU56WUpVQk1vT29NVkVpM1hKcU5EMnNw?=
 =?utf-8?B?VVR6aDJNY0VtVThIcENFZDl4WGo4VUZ2N3BycHBtSzJTTzdRQUtrRzlqWEdn?=
 =?utf-8?B?U1RqS1haSnBzbG9jcWJhVnZMNmpoZlpIaXA2d0N2NG5oTzhpV0g2UDMvNEtK?=
 =?utf-8?B?T3RwWDl0MTBwZk5veVFrbTBmL0gvRDJiVUUvK05PYXRiVG02elhraEJzKyt2?=
 =?utf-8?B?TUhaSEhNZ1NqZDBqazRwY0hnbks3cTA3dVVzcFNFaHRxV0pKSmpGOUxQckFL?=
 =?utf-8?B?WmM3eTNrb3JOWHdhNzZ1ZEtzYU1yRGdFYW5pZnppODJIOTBSU0x3VjhFbWZ2?=
 =?utf-8?Q?9OsjLMHb9IDzFFJhMHIaCRTOm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d3eeee-162b-4ee2-bff9-08ddfccfae33
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:38:27.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qERhmwqEDTTUsf8EY331X197pDmRa9i4UjRzF5ANHDGMG30Nz9UbWrBu+vEtGiFy3YjCGFJaVXGiSwvWxOrrow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068



On 9/26/2025 1:01 PM, David Hildenbrand wrote:
> On 25.09.25 23:35, Sean Christopherson wrote:
>> On Wed, Aug 27, 2025, Shivank Garg wrote:
>>> Add tests for NUMA memory policy binding and NUMA aware allocation in
>>> guest_memfd. This extends the existing selftests by adding proper
>>> validation for:
>>> - KVM GMEM set_policy and get_policy() vm_ops functionality using
>>>    mbind() and get_mempolicy()
>>> - NUMA policy application before and after memory allocation
>>>
>>> These tests help ensure NUMA support for guest_memfd works correctly.
>>>
>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>>> ---
>>>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>>>   .../testing/selftests/kvm/guest_memfd_test.c  | 121 ++++++++++++++++++
>>>   2 files changed, 122 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
>>> index 90f03f00cb04..c46cef2a7cd7 100644
>>> --- a/tools/testing/selftests/kvm/Makefile.kvm
>>> +++ b/tools/testing/selftests/kvm/Makefile.kvm
>>> @@ -275,6 +275,7 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
>>>       $(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
>>>     LDLIBS += -ldl
>>> +LDLIBS += -lnuma
>>
>> Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
>> any of my <too many> systems, and I doubt I'm alone.  Installing the package is
>> trivial, but I'm a little wary of foisting that requirement on all KVM developers
>> and build bots.
>>
>> I'd be especially curious what ARM and RISC-V think, as NUMA is likely a bit less
>> prevelant there.
> 
> We unconditionally use it in the mm tests for ksm and migration tests, so it's not particularly odd to require it here as well.
> 
> What we do with liburing in mm selftests is to detect presence at compile time and essentially make the tests behave differently based on availability (see check_config.sh).
> 

I have an alternative that drops libnuma entirely.
If this approach looks reasonable, could we potentially factor these out into a
common test utility for other selftests that currently depend on libnuma?

What are your thoughts on this?

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index c46cef2a7cd7..90f03f00cb04 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -275,7 +275,6 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
 	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
 
 LDLIBS += -ldl
-LDLIBS += -lnuma
 LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
 LIBKVM_C := $(filter %.c,$(LIBKVM))
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 9640d04ec293..12ce91950c44 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -7,8 +7,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <numa.h>
-#include <numaif.h>
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -75,9 +73,6 @@ static void test_mmap_supported(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT(!ret, "munmap() should succeed.");
 }
 
-#define TEST_REQUIRE_NUMA_MULTIPLE_NODES()	\
-	TEST_REQUIRE(numa_available() != -1 && numa_max_node() >= 1)
-
 static void test_mbind(int fd, size_t page_size, size_t total_size)
 {
 	unsigned long nodemask = 1; /* nid: 0 */
@@ -87,7 +82,8 @@ static void test_mbind(int fd, size_t page_size, size_t total_size)
 	char *mem;
 	int ret;
 
-	TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+	if (!is_multi_numa_node_system())
+		return;
 
 	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	TEST_ASSERT(mem != MAP_FAILED, "mmap for mbind test should succeed");
@@ -136,7 +132,8 @@ static void test_numa_allocation(int fd, size_t page_size, size_t total_size)
 	char *mem;
 	int ret, i;
 
-	TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+	if (!is_multi_numa_node_system())
+		return;
 
 	/* Clean slate: deallocate all file space, if any */
 	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, total_size);
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 23a506d7eca3..ba4c316f4fef 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -12,6 +12,7 @@
 #include "linux/list.h"
 #include <linux/kernel.h>
 #include <linux/kvm.h>
+#include <linux/mempolicy.h>
 #include "linux/rbtree.h"
 #include <linux/types.h>
 
@@ -20,6 +21,7 @@
 
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
+#include <sys/syscall.h>
 
 #include <pthread.h>
 
@@ -633,6 +635,50 @@ static inline bool is_smt_on(void)
 	return false;
 }
 
+#include <dirent.h>
+static int numa_max_node(void)
+{
+	DIR *d;
+	struct dirent *de;
+	int max_node = 0;
+
+	d = opendir("/sys/devices/system/node");
+	if (!d) {
+		/* No NUMA support or no nodes found, assume single node */
+		return 0;
+	}
+
+	while ((de = readdir(d)) != NULL) {
+		int node_id;
+		char *endptr;
+
+		if (strncmp(de->d_name, "node", 4) != 0)
+			continue;
+
+		node_id = strtol(de->d_name + 4, &endptr, 10);
+		if (*endptr != '\0')
+			continue;
+
+		if (node_id > max_node)
+			max_node = node_id;
+	}
+	closedir(d);
+
+	return max_node;
+}
+
+static int numa_available(void)
+{
+	if (syscall(__NR_get_mempolicy, NULL, NULL, 0, 0, 0) < 0 && (errno == ENOSYS || errno == EPERM))
+		return -1;
+	return 0;
+}
+
+static inline bool is_multi_numa_node_system(void)
+{
+	return numa_available() != -1 && numa_max_node() >= 1;
+}
+
 void vm_create_irqchip(struct kvm_vm *vm);
 
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,





