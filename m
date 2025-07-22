Return-Path: <linux-fsdevel+bounces-55703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E65ADB0E0E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DB51C24F06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDEA279DDB;
	Tue, 22 Jul 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wgB2oVdy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC81156228;
	Tue, 22 Jul 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199401; cv=fail; b=Eb1PX7/DhiqNqGoQtuGNPqT7BEDPo4yYf87fguURwgTB2DXxCHfqXkXrYv+AGesg1G4QRXu752du69lcvjCbOTTx/hhU8JGJSTiUUEUwKKVpZioquXIgJtriMxUol7B0NbziT/MWjSzWLpfyBptgptWfCJ5We3ypPLyr3H8PBls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199401; c=relaxed/simple;
	bh=5tVfwIZAc5vMjGHdz/25lf0+H7NlQ97gsF6O8Hfz63k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UVqUDAozHE2YUyVPfrRleOl+DFucjq96dT0vZ1BfXh2xLOxUIHiiAwNFgtTvvlBXYF8ZgxnHCgT/gyFXeFV8RKbwAHOw0mZmhkdPrf7ImHLy5YmD4nLV3LFjU7QOJSbBdvVia/r/1KpsXiLm9fymCiE0brO2cx4mm3lw6S4Xpk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wgB2oVdy; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4F83gkWSew0RnPA5hCv7rYHs4NVKuY52Er0u+G2GFdlHg3TER5QkMnotlgP3VZruB9shCf+AIKiwRoUW73K6SjcJcEvgyYjU248GkO9+jobzdMs3WL9V/+yaqccLV92aYcYYAo7F98OuSN+gg0MS526lMAKOE53579ooo5l0ETVjJremDf2LYpu3yCmDVTZxhsNv5ZE4I6b8dPJ/11LAWUeUEnp7yPYLabQTzWsMd/tYleHg86FTmT0vvEUc+1U4ULcFzpSoqPhoSA9jZHesjsx6OZ71WyEQKGTJtVCJQW8Idqeow0xJt2CeHJ8S9nSpIrtFl4tTCkEfSusivBc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttTtSFwOOSjtkAYK4J6wDUfcEM67+Jzr5qnUBviQmiM=;
 b=NGk0pP0z/3Z+DppxET1JxxpqzSHm75GYM4FmdECgqES5vwdvltjWvxsng9sNMjj4aW4aAAw0i8f/aVmHvJhfM1agnxX4jnw+GguxC8ggqK2uxaaq4zfYzC7hok20DkHF2ZejN3L2BptObxso5XTYcyMRJmwV6/nAH3dDwcfjl9fOSLvC2mQEBrZYcI7T63PcrNcSEyxi3WjN/UVJ4vH72vETibIA+Sh99d1w3F8arTfB/6DF/DJgq7E0jMaFdVysE79EarwzcQF3ai0262xFsKpIZCmvagVT34BChSqhoW23gxWuGTFa64lxZ08k3unjUfU61hObPOgNOvEeMCCcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttTtSFwOOSjtkAYK4J6wDUfcEM67+Jzr5qnUBviQmiM=;
 b=wgB2oVdyIPKJWGAohQyAtzZVo30kqhNYzwnHN2z6Qyi5ARJXAltYjgl25hmdsahiTSl5CemfMZrl6m5KD+l6/I/OB4bb4L8mLKKCy6YxNxEc8g9V9R2U41uBjLlB5rhNxffo6b4e97lANsZw37+/aR1vlMa2Sgdg76x4cdEt6AE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by CYYPR12MB8937.namprd12.prod.outlook.com
 (2603:10b6:930:cb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 15:49:57 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Tue, 22 Jul 2025
 15:49:57 +0000
Message-ID: <ba19f253-e46f-4cb4-9681-fa1d0b43bc31@amd.com>
Date: Tue, 22 Jul 2025 21:19:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 0/7] Add NUMA mempolicy support for KVM guest-memfd
To: David Hildenbrand <david@redhat.com>, seanjc@google.com, vbabka@suse.cz,
 willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, rppt@kernel.org, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250713174339.13981-2-shivankg@amd.com>
 <bdce1a12-ab73-4de1-892b-f8e849a8ab51@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <bdce1a12-ab73-4de1-892b-f8e849a8ab51@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::17) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: af2fd44f-bb57-4afa-d969-08ddc9376881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek5FajlYd01JTWtub1Z1czhhdU5Uc20vQXNZOXh6OGFQK2xoMmNHVmdKTk5h?=
 =?utf-8?B?TmQ2M0xseVJCL2FGRllDNktLbE10UVpsR05kRWxyUktkVWk1UENxd0J4VGlk?=
 =?utf-8?B?ekZmdFhZZmNaWU5kYkk0UFl3MURoWkgxdjgwUkdFWUhNay8wcVM0RW9ERTVl?=
 =?utf-8?B?K3AySFhLb1k2YXJLTmk2by9makc5eEwwU2t1VGQ4bi85ejkwVFFLTVE0V25N?=
 =?utf-8?B?ZGY3aE04VFRReGRrN0FxOE5zbFhKM0JOZVhzNGJVcStad2F6dDA4V3pucjVt?=
 =?utf-8?B?YW1rc0p0YzNXZzFRYUpwL0U5UDExRkpKWHdzVitYTVlPbjBTVEdmTWtOT2Nq?=
 =?utf-8?B?RHJTUGVuS0kvQlNXeXRMZmNyaTBLTFNUOUJ4NU1tMjlIV2NZeVdTMnhPTmUx?=
 =?utf-8?B?d0xodXZ6QmlMaHRaQ2Q3NE03MjdNTGVOb3Y0eWU0V0VEQkEwL0FBZm1EZGJB?=
 =?utf-8?B?R3MrWHVrWnpzZkdMNFZFVWJaOXpHR3pxWUR1WmQxQ2M4OEh1bGdPaVcyZlpu?=
 =?utf-8?B?Wm04bmU0S0V3L0poUWJlVTNCMGRnMUQ1V3EySDFEeGlYY2tOeERTQ3ZkakFH?=
 =?utf-8?B?ZjZ0SnFCVDJBVXZaNWkyS2NEcnFSaStyOElvRktmODZrQVljbXJ5UUp0VmJ0?=
 =?utf-8?B?UFNRdGFHeVVkMC9GNHUyWWFWMmJubmtTOFFFaFl4cm5QOE1QQ2hEMHd6WVdP?=
 =?utf-8?B?U1p6Z1c5K3ovRU5XT0IvcXVZek5ETkNoWjFmZmd3WGdWVDFaSC9zazBPVW1N?=
 =?utf-8?B?Q0hET2g0eXJ4U0ZlZFdOczZpTDkwVi9qV1o3VDMydHltT1V3bDVra2hKWHZp?=
 =?utf-8?B?RWRXQ201cnJvWVc1QWZCVnV2RHNNdGwwRDVRRWVFSCtrY05ieTU5NmRQd21n?=
 =?utf-8?B?ay92NzlxNXVLaVUyenpaU29iaEZ2MUxJSXNtUDF2UC9LZXBwWWM4Sk9PcXMz?=
 =?utf-8?B?aGpPY2N1YUNLTGdybUwxZWYzQjB3OW1XUkU2QmREenhtZlVtYzVvczNIeGpo?=
 =?utf-8?B?cG1yRHdxRE1DZThGc1RCK3pWVEpJVm9MRGEzWGdOeDBXR2RNeEdPQ3JyWSto?=
 =?utf-8?B?YVFSV1F2RmVWNVZUMWw0UlJ2Y2o3Zm1BaW92VkY4RTV5aWltR3hXTkp0UzI5?=
 =?utf-8?B?cHFCekkzZlhqdXBtbHdGckhwcnVOYkl4Vzc5bjZabkdTR0dzUHZuempMSGEx?=
 =?utf-8?B?TjJ1Z2VmcEVCUW4xZUdTLzNJL2ZjY1h0RVEwYmtNZ0t0eC9sKy9ic3d1ZjVx?=
 =?utf-8?B?dXpkb29icHpiS21jU081dEl6S1BkRGc3RWNMY1R3bC9BdWk4dTNWZURCVUNu?=
 =?utf-8?B?ZS8yRXRqY284WlBBQ0NndmtZT05MV2dPcklaSmlaMmlQVG00TkszNjNNNFFX?=
 =?utf-8?B?azkrU2I4OW9sdkN4emhQdnM4bDlOUlpsNWgyNk9rcXR3bjUreS93RW92d0Jv?=
 =?utf-8?B?cnVvcExla0Q0bktFcHhpdllwcWlDVktRZHFVZFc0MDQ4REtoSVlPSTllZWM0?=
 =?utf-8?B?VnZha2pra1pYaFBrcjMvSE1IQ1lnMGx1NkdIek8ydGJhRkhzRTlPTkhHNGJa?=
 =?utf-8?B?VW1RRlUwQkJPa0s1T1hKOERZRFViRnBtODZ6bFM4YTF4ZGFyREo4RTRuNUpN?=
 =?utf-8?B?dUhHOW9FSGVSazViTHJEdTZJeHc2VzhnQjZEc0lxNGYrZ0E3Wk5uMU1lWkVa?=
 =?utf-8?B?RElkak1pOFdjSUkzWmhraFhQREtteGE1M25KNGV2eXpGZ0JyaFp4MjFvOXZB?=
 =?utf-8?B?K3FtRDk0aEZ1Y29BVTJSTlVrblBHd1FRQjRXZ2tINkpwa2s4ZUZOaWJiVnVC?=
 =?utf-8?B?QXJaUnUxb0t3Ky9MUUlIVkRKSUtxbEZNSUIydFlBbEhKWlpmSnBLVGFYS3hJ?=
 =?utf-8?B?OVNia0dzeThRNW52bnhNWWJiQTk0aWJmZXByUGF0UkxQU3ZSYWdkSG5xREg5?=
 =?utf-8?Q?y52ryvtO3cY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21tUXp0SWtuWWJaYkhqU05lT3ljS1JzbEM4OWU1SWlzU0RZV0FxK09kc3FL?=
 =?utf-8?B?MEVMRmt0QUJ1MFo3QXFGSWY0VTZ1Nk9sKzJoT01XYXJHQlNUUmlxRm5MZG0y?=
 =?utf-8?B?NFNiTEtUMkYzWHRiR1hzY3FMNUNHdHp1WXJtejg3dE11RHN6clFMN0taTklR?=
 =?utf-8?B?Ui8xUzJCcmd3S2l0b1BBcDM5WDlNZTBxMk5ySkpUdUhMdW8vSWs0dlRFQ3Vx?=
 =?utf-8?B?T1hRV3hSTy9sd2RjWFVTcCtFSEpRdFd1QnpNQjlaY1d5S1FKN0RVdGVKQVEy?=
 =?utf-8?B?Q2k5YWhwb293bmQ4dzhPSkI5ZGdiUW9GNlNHenl6SmQySkcxNzJWY0VvMzFr?=
 =?utf-8?B?cU9hcmE5ZUtNSkJ1ZWZwTnkzeElXWDl3THpYZ2hnbitJNE0zRUNLM1RDdmoz?=
 =?utf-8?B?RHJuejc4QXlnSHAvdVl6cW0yK1VpcUdaejdnOVFkNGlkNWV3UUljNi9ydkln?=
 =?utf-8?B?TzBCWTBURldyRS9tZURHeUFSVXU5cFBnVm5KZTZHSXZRU1Y5a2I3Z3o5Ri9y?=
 =?utf-8?B?NTRYSTBQS0x5M0Q5RW44a1NSck5FTDFTc0JPcHlTdWdIZzdRcUU2VEYwRTdt?=
 =?utf-8?B?WlV4TzdRenp6ZTFFdDZ0RTJPc1RTN092RUF5U2VQU3ZqcWpYT0JFalBoMlMr?=
 =?utf-8?B?T2lTT0pwMHBDdUNJMTVqWi92UzRpcys3VjZORzlmMzhCaTFDRC9SanYwTUly?=
 =?utf-8?B?ZWZ1cXprR0U1VWtxT0dhVHo0WHNMTVp5VHhyNHdqVC9LcDM3bmtpRmRiRmcx?=
 =?utf-8?B?RkEzcU81b3FON2hVNFY5S3l4MGpGSWtwZ0pvd2xqZVpHZzljRWVpWG1pRUdq?=
 =?utf-8?B?L042SzRQbE0zYmRFcEQ1SHNXZ2Nwc3diSnc3K00wWlZFQ2F6QWlBQXFDdWht?=
 =?utf-8?B?aUdNUk8vZ2w1aGZ1Y2k5WDFTN3plVGtpdWJBY0l4eHZwVFZFNFhpTm9FTkJS?=
 =?utf-8?B?NFNlRFVOV05ESXFlbkI5YWE4RzF4WWpwdll2R3RRKzdQWWIzemhiUEozOEhw?=
 =?utf-8?B?VGJGbzZGNVhxcEN1WGt4a1JhUW9rK1c4Qkk2SXl2TnJ1dS9VYkxJM255d29p?=
 =?utf-8?B?bEhNZXZTMDd3N2p1bFY4SHN5R0xGdEVJZWdLWndnVFFOK3EvM2ZyUks1akxO?=
 =?utf-8?B?am82bTQ4UTZKVXZGKzIyTkFxMVB3dmE0NlMvd0F4ZEpPaVJXaSsyazdrN0wy?=
 =?utf-8?B?bUNHaGh3MmFTSUdLMFBxZk5od1Q3QzB6dElXeHRkM0xQUTF4L0ZwdXd1d0ZD?=
 =?utf-8?B?QUVOUjEzb1dVdkJZOXRPa3huYnFNeDFOTmhVVW9LMjZYYzZMVWZKbGFWU3Uz?=
 =?utf-8?B?MXpEYXRMV1ZzK2UxN0RDN0pnWXVGSEg1VG5senQydStjdzlSVzJnNlU3djhW?=
 =?utf-8?B?Mkc3bWFTQkh2dEdwMS9tQ2RUeVljUWdjeUZ3UXJxT3VhK3JtY0JFRFBWUUJ5?=
 =?utf-8?B?eTEzM1VyNFdyc1ZZOE9LTmlzdTROa3BCdStKNUE2OEFyNE9QYjRUblp6N3pM?=
 =?utf-8?B?MmhMUTl4ZThEWFNjMzlVOHFpS2oxbkxkb05rZVN3czVrNG1sYzJjb1drZHo4?=
 =?utf-8?B?ckZ4c1k0MjYyQmQ4WGJFMXRwZXBLNE5DajFpd0h1V2ovNWxidndHMGdrSk1t?=
 =?utf-8?B?cXZQVHl3bWRhNHppbkVBanh4alFkanRQWEJVTzNCOEdKVTJ5S2RyNjFVdEht?=
 =?utf-8?B?Q3RORkJaUDkrSlFmbHpUUGxYL3RsQ21Wcm9kalA3dEpFcEtWWi9ycVdSQlY1?=
 =?utf-8?B?SWpncTdaR0k5VU12UkphdWsvRlMwNDhxRjFFUzFjTE1HSlZDUUVSVjhRakRx?=
 =?utf-8?B?QmxHa0NGSmFKMDB0Y0MzVEIzY1ZiMlg3WWl1VUpRbFZabytUbTd1RW8ySWJB?=
 =?utf-8?B?UXpzdi9aSUtSR2pEclpqU2wzQnpHaDdOdXlXMG9jLzBMNUJreTNRa1d1cDE4?=
 =?utf-8?B?MmN2WWd5YUNHdnl6eVVWQ0FDRDhRQkJ6QTlhQWx4RFQycGNFOFVBMldIUDVm?=
 =?utf-8?B?N0YrRTFoUGQ0NHI3d1I3T1JjcE5jUEJVL290M0dXOXFjNS8ycFVJdjFNS2ZG?=
 =?utf-8?B?MFU4VnJmN2RTQjFKTTNBVTdST0J0RkhFL3E2UGVqOU4yNkJoSXJmTDBLV1kx?=
 =?utf-8?Q?6aLKb+LZt7etYFayM0OgerO2S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2fd44f-bb57-4afa-d969-08ddc9376881
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:49:57.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+ARh/LcN5iGQ8QuWM8aZxksP1tfxBATZFa6yOj4oglBYfnK3NdI8ZJ8xRraOIdq0xMezRM4fFnQVXVk2l3EPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937



On 7/22/2025 8:10 PM, David Hildenbrand wrote:
> On 13.07.25 19:43, Shivank Garg wrote:
>> This series introduces NUMA-aware memory placement support for KVM guests
>> with guest_memfd memory backends. It builds upon Fuad Tabba's work that
>> enabled host-mapping for guest_memfd memory [1].
>>
>> == Background ==
>> KVM's guest-memfd memory backend currently lacks support for NUMA policy
>> enforcement, causing guest memory allocations to be distributed across host
>> nodes  according to kernel's default behavior, irrespective of any policy
>> specified by the VMM. This limitation arises because conventional userspace
>> NUMA control mechanisms like mbind(2) don't work since the memory isn't
>> directly mapped to userspace when allocations occur.
>> Fuad's work [1] provides the necessary mmap capability, and this series
>> leverages it to enable mbind(2).
>>
>> == Implementation ==
>>
>> This series implements proper NUMA policy support for guest-memfd by:
>>
>> 1. Adding mempolicy-aware allocation APIs to the filemap layer.
>> 2. Introducing custom inodes (via a dedicated slab-allocated inode cache,
>>     kvm_gmem_inode_info) to store NUMA policy and metadata for guest memory.
>> 3. Implementing get/set_policy vm_ops in guest_memfd to support NUMA
>>     policy.
>>
>> With these changes, VMMs can now control guest memory placement by mapping
>> guest_memfd file descriptor and using mbind(2) to specify:
>> - Policy modes: default, bind, interleave, or preferred
>> - Host NUMA nodes: List of target nodes for memory allocation
>>
>> These Policies affect only future allocations and do not migrate existing
>> memory. This matches mbind(2)'s default behavior which affects only new
>> allocations unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL flags (Not
>> supported for guest_memfd as it is unmovable by design).
>>
>> == Upstream Plan ==
>> Phased approach as per David's guest_memfd extension overview [2] and
>> community calls [3]:
>>
>> Phase 1 (this series):
>> 1. Focuses on shared guest_memfd support (non-CoCo VMs).
>> 2. Builds on Fuad's host-mapping work.
> 
> Just to clarify: this is based on Fuad's stage 1 and should probably still be
> tagged "RFC" until stage-1 is finally upstream.
> 

Sure.

> (I was hoping stage-1 would go upstream in 6.17, but I am not sure yet if that is
> still feasible looking at the never-ending review)
> 
> I'm surprised to see that
> 
> commit cbe4134ea4bc493239786220bd69cb8a13493190
> Author: Shivank Garg <shivankg@amd.com>
> Date:   Fri Jun 20 07:03:30 2025 +0000
> 
>     fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass
>     was merged with the kvm export
> 
>     EXPORT_SYMBOL_GPL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");
> 
> I thought I commented that this is something to done separately and not really
> "fix" material.
> 
> Anyhow, good for this series, no need to touch that.
> 

Yeah, V2 got merged instead of V3.
https://lore.kernel.org/all/1ab3381b-1620-485d-8e1b-fff2c48d45c3@amd.com
but backporting did not give issues either.

Thank you for the reviews :)

Best Regards,
Shivank

