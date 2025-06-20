Return-Path: <linux-fsdevel+bounces-52330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C09AE1DE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 16:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1A53B35BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C72BDC09;
	Fri, 20 Jun 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e7nuMaFV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3E2836AF;
	Fri, 20 Jun 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431196; cv=fail; b=IX0EeSdc2Nx3BEassB7OuS3BgpvgH55Utsd23fMM6Mbi6HdOoxyuHUQU23eNiEHzeCw2A5MH6u5lwlwa6MIe2159lD4HqgYGbtMxRzXBY3h6ATQU4+o83FCGW1NCEMAqRN1cqbqdhWqCZJnM05dWCaGdBo9FxDqUqR/skKe7RBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431196; c=relaxed/simple;
	bh=z8DP80xL3+B6tLlZFyZKiso0nGT2KrJxKbHyXgVQBC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AegzJElCqH+2LbRMWILYKlcmxwgprjjNXet3mz9VUUX+0BwFrWZqIBX6yWp29qvyDk7jnJa5aqCCAjEBB2MBc2ElajzwtNJSrWgU7e8CyLj6YGp95qxPOJ7H2lEutTkWuLMa1Qcfi/6CBIESk0BgrbLwOi9ul0BtV9uQgKak35M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e7nuMaFV; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATdMQoVPqqUdJnXGSKKfVLYyFYP/Qz//6aYRAU+NTRApJArHz95fLk+YWNwU/mYhFsBXEibtyR6XhOMqrU5LEfuhSo6v6uPHlccmIpycE1BFiVjZ98LlAEtRtYTMhuT8WkerhWRTnEl6cIUIbCYROY4978gfr9uRd4onF7xpUI87Jpi2Inyhb1YwAXkevEdq496fAbsN9tjOZ6BC19TaWbh1eg6TxzXOyBy12LGhkMJu33R5lnDBLsXXDB20U55p0eYnDOIeYi8vYfbY+GwwkIYRglaBH2orUEJDQnQtuYUa/9r71RVr54PGeBlYejr0YhnG+kb5ii4i4/BBn7E6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCwfbwa4Ne80UZ4/osA1I0rNCDZN/V0Eke91Slxbh0o=;
 b=Edt0/05hTqv4TXZqgy1XLp+v74vvdsX2e5qNUcIYH+g19XR+0o7tqxAD9pdYGMAAvDk2Z/KbUYlIIOYy2hTBJSAEGkpADTKUiQ/PeJBs84N6paZWkXRS7J07bdEzgNa6JvxMZZ4OVQnBXOAksYrhFWl+G2WuXdPTDeIgmOTIJa6lvOWXGWEhnYYq/vMmAaFAT9Qy4U1DpKTQn7IARwToYSqsZsyBbYFXny9V4pOrGX388A+jAqZrc1vXbACG/JI7ni+619vEhHLv8oQE4jDQv/omwLQNSiveoO12FKHSXUwRREA78YUa27vSgtXfWu0uwj5TnjwTk+hRDH56j4vpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCwfbwa4Ne80UZ4/osA1I0rNCDZN/V0Eke91Slxbh0o=;
 b=e7nuMaFVDoILdEQgIyce7rOopZ552czUNzB2FZBwdsxVdnx58nJ3qcgaB48KQCJMc0ImGwrcyvvlpEd7VXseNkWoJp1vkqNDNpc7sK7g1LBr+izM86mx4erUQFhKT0OHtXSu89Y7kEcNNoSxJjewsEcS7lwvt0czkdimWMJ6Czw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 20 Jun
 2025 14:53:11 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 14:53:11 +0000
Message-ID: <2d571f86-67bf-42f5-a20f-6c691ececae9@amd.com>
Date: Fri, 20 Jun 2025 20:22:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 3/7] mm/filemap: Add mempolicy support to the
 filemap layer
To: Matthew Wilcox <willy@infradead.org>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, jack@suse.cz, rppt@kernel.org, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, kent.overstreet@linux.dev, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250618112935.7629-1-shivankg@amd.com>
 <20250618112935.7629-4-shivankg@amd.com>
 <aFQ0v0DfWgUvqK6L@casper.infradead.org>
 <ce88982b-0a01-4673-a0f2-d490b66d0fa6@amd.com>
 <aFVxa-PRavav6pNd@casper.infradead.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aFVxa-PRavav6pNd@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::25) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 162325ed-8679-4d5b-aaac-08ddb00a2d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEhpMndRT1Y2NXlNc0ZDL1pkR2tma2pJR2VFcEJTa1pYM3FHV241T2ZDTUFG?=
 =?utf-8?B?T0NEdTEzU1VKa1ZvL24zOHRWaUY1SGliclVFVHhUVlRGenZiMGhKb3dTdmlz?=
 =?utf-8?B?bWE4V2Q3MnFkcHRlUGJpbVB6ZHJWbTRRNSszcEUxa3dyRmthdTdHalo2Z2w0?=
 =?utf-8?B?anhuOThkVUg3SksveTluM2tOTkFXRmhPQkdSejd6dnZWLzJiWmV3dWRmZkJm?=
 =?utf-8?B?OG9BUWxaeEZVQWFNemxaV3FjZjY4VlFKNGttakdiekI1Z29GbnYzd2pnMTV2?=
 =?utf-8?B?VGZGbmZlelZ6MXVhSVRMQ2ZsQUFRVmNWQlprWEZlZ1JBa1plT0NsRjZWMHk1?=
 =?utf-8?B?cmFTNXlJamw0ZTlra0cyOGRSZytTT2FhWXFBblI1c2ZRZWlleVFpUEhRanA3?=
 =?utf-8?B?a0Vvb0s3Nnd3RCtsYXlCUWcyTjF4MDJtZSswTVVTSGUrcFpnbDlNVHVHbXJQ?=
 =?utf-8?B?VHEwTVhnOUxlVk1SQWRHYlJRUVJDZ2c5QVRyUVZnUFFmWkxGTlMzZE96RzQ1?=
 =?utf-8?B?ZFNGWmNMbjd3b25wUDV2R1RDbHpyb1FRZS9CVkJ1SFhpVmhTRUN6NzRBYjZN?=
 =?utf-8?B?N3hlUm1td0FIcWsxQStqN0NGS3NuSTAzV0cxWTczZDhJcm1lUlpORGpBTnVj?=
 =?utf-8?B?Tlg2QzRRVUhHY3RhRFI3MmVNSWMzZ2djYTZRSmhjK3pITXlJb09QWXgzOThx?=
 =?utf-8?B?dTJUeDhXMjRDRzB5c1pmTXViUzg0SDJSWGdPYldsSzIvUnRocUd3Qkc3aEN5?=
 =?utf-8?B?Mm9EU2oyWHUwalpUT0hVV05FbE9UMTJTTjZiQnRCTXF2SW9USE5oczV4UHEw?=
 =?utf-8?B?aXcrLzByc0FweXpCR0lpMEYyUEpZdklYdE00eWlMTUJkcWN3K3pTVk5jdDZY?=
 =?utf-8?B?SWN3bjFxMUJJc3k1ZGd2QndZYVJYSkxZa3NZTTRYZG5jaEkwT2dlUGl3UTNK?=
 =?utf-8?B?akliNXRHREhURnJEU2JjMm95VlgyNHFrV2lLdlpsRjg2aE83WVFScE5nc0h4?=
 =?utf-8?B?M2FZelQyWjZncDZaYTFxaGVVaWhScXgyaWZkN0Rnc3M1d0NjR1lsREhVMFdC?=
 =?utf-8?B?Z1FNand5NWtQMEwzRzBlaTN2Ty9lZXFJZUhWaDV2Z0FGWmxvQVc3MkJCaDBK?=
 =?utf-8?B?OGhOMWF3R1RZM2JOTjh4dGQ3b0tza3ZQU1Q0MmprU2RJT1RNV3lvRHQ1M1Br?=
 =?utf-8?B?bnFHVUVJM2hoMzFveUlyenVWQ09IR0hiNVZXV3U4cEcxYkovb0s5L0lMVVpJ?=
 =?utf-8?B?T0hUa0MrMjRnWG9TQVB6NUdzVFRkT2hrcVBQTmdyY3E2TmMveTlxdURUSUI4?=
 =?utf-8?B?d0FJNmRrSEloeFZaWHJOMEZMVWdMU2grQkU4OGw5ZDVFSXk1YnhDK29UL0tu?=
 =?utf-8?B?L2twYjNlSTNXSkR2TkZnUjArcGhoZEFNOS8xYnMwVWNBd0VlNCtYSDFzZUVF?=
 =?utf-8?B?dTZnZmJMTDhFb0NwQWYrdnZ0YXgrT09SUWpiZVhPNjQ5RmpnaTJZL2c2Y0x4?=
 =?utf-8?B?bU1BZFNXSGxrcUVnUnRVR2lKS0l6eDZDVFo3NFZJSzRjRlJBRnZJSTFNcllO?=
 =?utf-8?B?Qlp6L1ZUbllQakh5TVhqK3Q3Nm5CL283cDNVTEEyZThjaHNyMmd2YXlPUk5a?=
 =?utf-8?B?UmF3REx3SW9oNVh3MzhnYkR0U01xTmlZVjV4dlJjcjZ4aHJxbWs4YmdQWTMr?=
 =?utf-8?B?dEN5NWNaTnJVZFJ4V1BiZElaTEhUWVlhRXNNb21qeGNoM3oyeWtDc0RXSXpD?=
 =?utf-8?B?bDdMd251dlBlS3k1YWtWOXoxZEJCZ1NMQ0xBWER1OFRQbWZSS3JISVVoWDB0?=
 =?utf-8?B?YzNZb3ZuSnpTUW94SXRWVVBhUWd2M0YzOFQ3U1hKcHcwbzJVNW5QTFZUNTdY?=
 =?utf-8?B?cDRTZGhreGZZbEVLdi9WdlpNcFNmSG1peVpScUlORFhOQWVTY2w2eEN6SWF5?=
 =?utf-8?Q?18MiNTvTfMY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmVwSithSnZJWk92MlRQaXJ1T1RhdU54Z3ZoZmZwaEx6dTE5dytETVY3SDFE?=
 =?utf-8?B?Z1pRNWtzQXhPUnU0TzB3OXd5TDZKWUEwakM1a1l5Yjh5NEsybW54eWtUbEZO?=
 =?utf-8?B?bW90Qk9OTFFrN0xSR1lXVVRobUpyK2xTWDZ2WTc4K1VxSGN3NWw3N0JWYldi?=
 =?utf-8?B?R2RvYTNzTkIrNzRQME5keTNjQjlORXZLSy9VUnRObGdVK0o0dmY1QjlrRTBC?=
 =?utf-8?B?UEorZTZMaFZldDZIRDU4Tm15TFc2NlVwaTFBeHh4WStvRWxnTHJXdTA1UFo0?=
 =?utf-8?B?eEdQODErOHlEbnRqSUZLaFkxTVVYMDZIV3pPS0U4aG1IaURrNjVSVDVFTElY?=
 =?utf-8?B?d0dCN09kNEVCVlBIQVhMZlZoMUNCbnF5VnFMczQwS05OVGp6TmwzNS90ZmFJ?=
 =?utf-8?B?MmVJaGpOWURidmpiV0s2QkhTS3owUmhLZEpycmRQZDlERWtEOGZxNkY4MWdJ?=
 =?utf-8?B?bk1WcnNSMzlLUEJ1TXVicWFpRHNjNWVzbCtkSTZHcXhIMllmaFVwRXVSSGNV?=
 =?utf-8?B?YUNOS3R2ZEFnNDhMQ253cHFZd1UyWXZmdVFod24zNXJlTUZ5U054Qm13QWUv?=
 =?utf-8?B?MWZySCt0WVh6NTdMWGNuVTkzT04yanV0RGRQNVJTMmJ1Q1dXa2F2MEFDQ1pP?=
 =?utf-8?B?U2tJV05ZcnZyUjgxcTFCV0Z5NGVJR0lpZXpSZEJHcEdyU2I2VHhJUHdjeCtT?=
 =?utf-8?B?TXVmMitRQzhsSE1Id1l6YVUwL01xUUl5NmUweGF2OGNVSE9UNkNpaFdPZ2hm?=
 =?utf-8?B?aDFFbG1nTU5qaHYvZmJHTjgxbVNFSXpwdjRPVG5JSXRkL2QxWUFUcW53Z09r?=
 =?utf-8?B?b3A1WWYxd2JiMzNpL01vcEVWMjVZUlZkVG5vL0IwTThOOHJXQ1laMkpaa0dv?=
 =?utf-8?B?dERtc3BtOENKa3RUMXhnaXRQMVFxVmc1VDMzVVR5SnJKMk1BYjJWbHJieE1z?=
 =?utf-8?B?WVFkaU15cFQ0Q0FhaUJEUnMyYWJ1UUZvT04xdmhlMDBrNjhZYS9XUFpZZHgy?=
 =?utf-8?B?RWlqN2sxNVZ6VTRTa05pZlFqSGVZdTROV0tLUzQzSGNJSlJJSmxnYjRMZGc2?=
 =?utf-8?B?dkUyTENpU0VxdjB4NlltRG5IaXJMa29Fdk10KzZ6YXNnc0RrcWx4TGxpVG9N?=
 =?utf-8?B?MzZsaGJzU3Bvd0c5dFBxRTJtMTVpQUhFdWNRa09jQzRFYzVHeEZkNzlrUDFy?=
 =?utf-8?B?ZzluRElxbmJVYlpvM0JaeU1uU1psbXR1NlAvVEVjUzZtbWJxY3FyV2I5TlZN?=
 =?utf-8?B?dmNnVzV2VjRsUjh2eHVEMFZPVUV5TzlGa3EwOXFEWkxHK1dmVnpIU3NNRDBJ?=
 =?utf-8?B?emV0S1pyQ3ZKTDZvbVpCSWFWWkx0T1RHRHRZOEhJdlc5amZIZUNkVmJMVTg0?=
 =?utf-8?B?S3plcHA0eHBhd3htaFpoNFlROWNQL1RQQzdteVJZOGpVZmN2bDZ4SVBoc2pa?=
 =?utf-8?B?ZUptYm9vaU1lN1FKRVBqbGJzUmVzNTFkTGRaZGE0dWw0STRmK1VWMzZXSjU0?=
 =?utf-8?B?NEJiUHYyNUlGRVVqbUlLd0ZwT09McGtCWnY2MG1DNkYwaHdZdFpVR2paajQ2?=
 =?utf-8?B?b0JSZ2thQnlRZkxROHJUeVM1b3RlK2dEcHJueUFOTjNyemZuWWRXY1paV1pi?=
 =?utf-8?B?MndBdWIzNEh3Y25hZ1Q2ZTBGMmZZSUpTWldpVlVFRURHakYwb1Z2b3FpZlZL?=
 =?utf-8?B?QWdrWW9Ocm1ORGZmeGtMZ1JNRG44R0JXVU9ITWxoTmxmSEtrZFFzTEVUdUhE?=
 =?utf-8?B?aStEZ0k4Vi9OYmZKMEdqM2hKZ2V0K1NjNzFBdXhZUVNCcDNDUXJFSGpxTzNZ?=
 =?utf-8?B?RlIyQ0ovSEZaSDhVUFFnT1ZqWGRKNlJpR0M3eXhBRWoxcHA3SDZUY0Zhanow?=
 =?utf-8?B?RDVJd1VZcEErai9ERDlDVmMrVzFnbzBraElWbklxRlJaSUI3RGJ1QlNpblFu?=
 =?utf-8?B?ZTJxWklGSjJrYUNFUGtlSVA4QTFhWG1FMjQyQ0hZaWxmZTJyeFg0SnI4ajlj?=
 =?utf-8?B?UWp2Y1VLTHRzOTkrN0MwYzBQbnpKUkxMa2dla0xGOVJnTU15dmZxbG5OTXlO?=
 =?utf-8?B?K3pFTjBZY3VERzZMZlVhaURjNXVOd0k3YUhlZkRPZjVqZWxVUVJBa0RsT3NJ?=
 =?utf-8?Q?JDbYmk+ZlrptTzlq+JzBRybzA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162325ed-8679-4d5b-aaac-08ddb00a2d37
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 14:53:11.6137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qYJ0kCDYq+vFcUJF3Q2E0BqxYSzM3+O7axYilObvarrpsVCe7Z1stLWs+aWVUiS/9cpKoDo8o0GeKI2eD6M8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122



On 6/20/2025 8:04 PM, Matthew Wilcox wrote:
> On Fri, Jun 20, 2025 at 11:29:20AM +0530, Shivank Garg wrote:
>> filemap_grab_folio_mpol() is used in [Patch 6/7] in kvm_gmem_prepare_folio().
>>
>> filemap_alloc_folio_mpol() and __filemap_get_folio_mpol()) are internally used
>> to support the filemap_grab_folio_mpol().
> 
> That's not better.  We don't add unused functions, and unless there's
> something coming that's going to use them, the entire structure of this
> is wrong.
> 
> filemap_grab_folio() is a convenience function that avoids us having to
> specify the other two arguments to __filemap_get_folio().  Since there's
> no indication at this point that there are going to be more callers of
> it, filemap_grab_folio_mpol() should not even exist.
> 
> I'll send a pair of patches which should be sufficient for your needs.

Thank you willy :)
I'll them add to my series.

Thanks,
Shivank

