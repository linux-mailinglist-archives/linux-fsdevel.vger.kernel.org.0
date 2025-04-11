Return-Path: <linux-fsdevel+bounces-46236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0EA853E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 08:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB38A7AD0C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 06:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574CA27CCCE;
	Fri, 11 Apr 2025 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EhS5czb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6D1C54AF;
	Fri, 11 Apr 2025 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351666; cv=fail; b=RKkUgk/e5EfDUFZPQ4ovsAHwB9ILPAvYHrStBF4xY3dyy1jsh5EOq6cvTtY9cOe6iLhw/qVBRWw9iZMmI6MPDcCIsCtSoRBJ4Ms2bgKV6GMQeO4W14oQPFq0OKAIotb+lCquwsh1cyQmJOmgt3bQNC2RAu3BRhyC2Ux83pUDfF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351666; c=relaxed/simple;
	bh=hfqEXLeysPWszMcRlBCed2lZMr386062z6p6Oyg1H+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TZ9tHMagT9e17LS6POlCbGxlgW8x/qjJrD94udgcZEXPA4JWQRD+y9DvNtMalu+V/ijdIBTh52HOyLgqEo7xZUaInPe0957lbVfANRBpv5lsvWXPwhHIf5hxT3BTksb/kVpHDfXg9hjqBFVtjh2lAN6cNjNKsEuUexBI+W7kcoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EhS5czb9; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txT4fsUewiUKIpaBu6a8AyIu4l29Wm1XdypMCBIZEDoKvo3LEsfrBVBlbzx/rpp2AaRx1zel7FHtkGtCGAkXPKWaeHDPQ0AewTBD0KtKeLKnpzW29BL2buFKDGoMZRNMUpwN7iD6SEOVDEsoptwfwjsrSz6GkVU6N2Na00CsabOrybCB/HMTF83haEAhIqSKJZLlpE3WYJ4zbWoj7DTCdunOm3Xr/VklGFzMvUUwMP7k+OfkiuqcROqumuizZGp3IGL0x1y9lOm4DbCSWk1hEfYq8CbLJpIh/m7QgW4mz/pcYKPdx0xtl26jwKljospWWMTrdwWTX/aOquyJPqXntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLR40Y3w/D35ncZ5VcGV9RLhMR1Rpwtl7Oh3s+hVsG8=;
 b=QN7vrcT+qyrbHfXf2r4ov6NtBc8vqia7pTOMSzYs02gRCv1s9a0iUYLT087p/3b0gtL1sEtsXkaZQp5wiH7qp12TOtHRQE4eouR7WaCCgVgjPtH0O6ityy2mfdIAxnfy7032EiNK5o5CPcFXa0uzr5JHnEvBJlqJx40Lfy3LpxbVtRnoFz5xSReayKvEdMVKijHAUbrab42iy7f7SCPIJ3ui1ubbVLAtCYSqnGaRFN1F7Y/MfbRji6DyQaAhM4Md7Y9ImbssId42w4CJNMpZ9Lk+59b0w3sEwLZS7jmOI497u7XZ5NP4ElcQB/4BIVKT/vpx0BV+P375jZ7RlDt4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLR40Y3w/D35ncZ5VcGV9RLhMR1Rpwtl7Oh3s+hVsG8=;
 b=EhS5czb9XqDK13owb7bYb4bYD5tEu/mvEw9YMdBTIJuYagqKk9+ZEjKqBATdXgC3SXevySbsAgz3cJG0UVmdMZDOajviy5dXZmU+YMCVnnLKkG6MCuCaREgWesvVUGJWbhDvrSfcgYC8dzTBv7YudIUn6DwAgEps6MmYHtK5vEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 06:07:39 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 06:07:38 +0000
Message-ID: <b98f7b78-1834-4fa0-b79c-d5ac562e4809@amd.com>
Date: Fri, 11 Apr 2025 11:37:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v7 3/8] security: Export
 security_inode_init_security_anon for KVM guest_memfd
To: Paul Moore <paul@paul-moore.com>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 ackerleytng@google.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250408112402.181574-1-shivankg@amd.com>
 <20250408112402.181574-4-shivankg@amd.com>
 <CAHC9VhRFBOC=cZB+Dm00cshwBSBaK6amv+=XFLPF0Bub0gHN+Q@mail.gmail.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <CAHC9VhRFBOC=cZB+Dm00cshwBSBaK6amv+=XFLPF0Bub0gHN+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::8) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 72829d0a-70db-4cae-c731-08dd78bf2926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rkd1Q1lxR2w0Q2tqbVpJdHNNS1lrenZyS2NhRUlKSzhid3ptbWtjNjJnQ3Bm?=
 =?utf-8?B?TDUvenQvUnQ0dFhnSlBFNDlXYXQ4VDhPVm0wLzB2RzZsV2VnTzJneHlwaW9x?=
 =?utf-8?B?OUhtak5wdlpSdURGQTVvSkUxTVhTb0xvMHJsUURoQzdyUnNvdUtCK1lvbEU5?=
 =?utf-8?B?Nnl2Y3h5bFJWYzdodlowYklIajVRL3BjVklCMWdMOVhTVEZIYjJPUzlacG9q?=
 =?utf-8?B?SkxOVjhEZlNHTnplaUdQU2J4TXY4MXdWZ1lzRlljblV2K2pYVXZLR00rVGY2?=
 =?utf-8?B?eFZMV0hsM2RYWE5XZHZyeGdwdzdGOUthdkdZcXFHUnlCMDZoc0tHbnlySUFy?=
 =?utf-8?B?MnlDbjhVMExNa3dFODE5VkFCTGhxZjg4UzYraFpHdkVjZXRER1F4MXVLczFy?=
 =?utf-8?B?NURSUDJOYUJYbUM1ZG03enBsM0FGb3RIUTdaL2MwdWZlbG05bTU2MlRQeWMw?=
 =?utf-8?B?aTdhTE80MGhCRm9aZDhLUmdkRW1BbFlKRFdBSGQ3TWU1WHJ4WFlEQlU1NEZP?=
 =?utf-8?B?R0xxaGVPamtTQ2YrZjJVcVBUQ3ZNaXJ6d3dEQlZTZU1ubTJlL2ZlWkFTTHhB?=
 =?utf-8?B?aDc4UExBSVNiNUNzV2hZZTJxdG9OVmFGUENsdU5nZHF6bnVYWGVqeUJ1TVNa?=
 =?utf-8?B?WkhHSThWMGkrKzhBL1owL2VHendXVGRlSUNUR3dJREZrMmt0d05SSGRodlhk?=
 =?utf-8?B?VGJ4U3FVYU0wVzd6Wno2c1FmUVFkbzhxVHJCcWY5alkvVTZFalg4RDJwY2dF?=
 =?utf-8?B?bFJsQkl6c0JnNDB6akVKdFUyZ2NBc0VyTlRhTmRXbUVMK1dCYnlKR1o1MkRY?=
 =?utf-8?B?ZFJJZ0JkOUdhUU5kOGJlN3lwRVlpQVg2d2RiYXJBNmVJQXdBVFFXc0JUa3lB?=
 =?utf-8?B?eEc1NGsva0dvNXBSV0kyVFNIT1NxQ3gxRVJ4c3cyZTBNazJIL1lDZ1pHOXNi?=
 =?utf-8?B?Y25oMm5kd2EvcU4wT2ZGRjQ5M2ZCU25CNE95b0FaaWYxSjROcEVyVWdhYVhz?=
 =?utf-8?B?VVl2dC9nTk5hcU83dmd1TnVBV1ZtSTdoRUNtT2p1bHBnTGdTZTRLRll3eDJs?=
 =?utf-8?B?NG54SHU3bVFFM0ZQbkpXUWRhdCt1Q1JGd3dBUlozN05UNWhiZXdrYVcxRm82?=
 =?utf-8?B?M3JBdlI1SkdZUjZDSEhFZmxpbTlzTFlVTWtKRU1KM1JxUHpCcVB0R0k3ZEdn?=
 =?utf-8?B?QWFCOHRZbjN1NldVSC91VzNBZkM5anFtOThqRG51MzRPWkNtbzl3ZnJORzFY?=
 =?utf-8?B?N3F4ZlRsUnRPbjlnaE5vUE5kR1lxQ1JnYlZDdklSZ0xvOThwMGVjV3dYNWZQ?=
 =?utf-8?B?Q1JzNEJpSHArbDhrMzZ6SCs2N3lrVlpkM2xYYnpWVE5mUHZpbVFPYlAyOWwv?=
 =?utf-8?B?TE9NZ254dWw3akpoUDlxMjdGcGxPTUIrSG4xRjM3cE9vQXo4ck82cThxQjJl?=
 =?utf-8?B?ZXhDajBtR2pRdnJTdEFOU3kwSElRQ1dqY1A2S2ZwbXhPUGJvT3l5SlY5TXRK?=
 =?utf-8?B?cHVmZ2dNd3dteStyTHNBM2lKeHU3Y1FSOXFTRENyTTNxUU5GeC9VeGVYQXor?=
 =?utf-8?B?bStOeG1sTXVsVE42WUVkbGgxUnlnT2U1V2J5TEZKZU1CcG1DMHUxSnhNY1Ez?=
 =?utf-8?B?L2lJNkc3MmdldmEyU2JTYnNuRnVoT0FoTjd0eVMwQ09BVk15NHdTZEtHeXVR?=
 =?utf-8?B?RWQwTFFoZWY1N3hOMXRvSHVCSU9MVlVHUkRwTkI2dG5kdTdNb1pkNWJiK3V5?=
 =?utf-8?B?VitMTnVwUHBRMTByME5rQ0VhM2kwclpVTENJeFBqdFd3UFN1V05Rc3htQ3Ja?=
 =?utf-8?B?S1VVZitSYklseHJ1UWk2OE1yTDk2L2kxQVV0SzUwa0Z3ZWZJMmVCYVNNWVBu?=
 =?utf-8?B?ZGptbUdxb2dvVjU2VkVodTdtV0ZNUzRxVHpVUTcraTd5LzFSdzNzeTJCOGkr?=
 =?utf-8?Q?SFy0OV8BIQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0pCOE4rQWZtTWNwcUl6RW16a1NzZEN2QS9uWGpDTHUxYkt1NzFIRWR0cUc0?=
 =?utf-8?B?Q3dLVHprUmE0UWVRc1FENHp6YXZKSnZiUUMybG43WkNvcTF6TEVHZVU0UDBX?=
 =?utf-8?B?M3REcnZZWXAwVTB1Z0ZSMTBSclAwRFlKU3lES3RMQzBKUGprelVOcnlGVUND?=
 =?utf-8?B?M3F4dTBURHozYmhXN05mTXB1NFFFSnlyZHVmNkJMUjVmNHorVU5EZzl6MVh3?=
 =?utf-8?B?eXRaRWNRY1p6d09ZcVFpdGoxZlpvQStLb3p6NlRFMHZpdE14YUdEcTRrczVz?=
 =?utf-8?B?QmtGeGY2Q1R1NFIrWG0wVmZLcUwxZEh5aDhXT2hUVVNwVEFpOUhEQ0FZQlM0?=
 =?utf-8?B?OVBSUXFnS0hLL3pRNy9zcTdma2JPZUgxeHVWemI4KzAzSmV5anpKT2h2bUFE?=
 =?utf-8?B?UFZBeUlDTVVDekdndWJZeEpxVUFMeWJMRDFISHRCSm91ZWc3ZVBmaVpvbkJo?=
 =?utf-8?B?a1QrMzVweDFjc2FuUC83YmdCRzAzNHZRS0VLZ2FvNFIzVEovVGkzRW9qRlhZ?=
 =?utf-8?B?NzMyVVhJVGEwYXVManJtSnJTTVkwNG9mMnQ4OWxxblhDWHIrZEJxNDVtck1G?=
 =?utf-8?B?MXZLMkM4WnM2c2pRdHprRlJHNkNWVlZQRWVlWGdRRjQ0cFpuajdpYjFvY1N6?=
 =?utf-8?B?TitTeW95VTZLR1NITklkOU9iaTd1QjlpWDN4UGEydUwycU1pa2FWYTAxRFFQ?=
 =?utf-8?B?RGdzYTBrRGxlcjUwSlpQQ2RWU0h2QnhSU3NlUERiQ3UvZjdiM0xNMVlPbmRT?=
 =?utf-8?B?eVZlRWR0ZUpVL2dmbk9RNDBaSWdmT1hJdWViNWNsREdHeGk2THR6L0kzdUZH?=
 =?utf-8?B?Mmlva0lGU2RZdnIyWU90Z1l4RXoxdWJ5MjE3d0d4d3RNQUdzbCttb25UL0t2?=
 =?utf-8?B?Nnh4UmpMTnM5Q2lYRS90ak9RdmVRbndiMkYxTWF6Q2k4RjRNM3ByTGxIQVlq?=
 =?utf-8?B?cGN0VWxyT3hNdnI5V3VYNElOZ0h4YjhSQnpET0U3VTdUWHRuckhQcWNRNnpk?=
 =?utf-8?B?VzdrOEZEeXpQOFdoYytQdGtuRXZjS1NBRS9pL1hrZDlzQk5PUFJQektzNkpm?=
 =?utf-8?B?V1RDYWJzblVqK2l2ZGtxU3hSN2h2eWVuUkVIUlVuRjBTYzNzRS9ub3oyZnMr?=
 =?utf-8?B?Z3cxUVR4SnR0SDZpaTd1NmlwY3huWXlkei94MnlLeS9NU1JaZGtSM3Yrd29y?=
 =?utf-8?B?VTNMSjR6NTdPRXNmL2pzZlowckNFTWF3a0ZCalFyY2ZMVVRpZTJTNFJ3K1Aw?=
 =?utf-8?B?L25YQVFiejliSFNyWFp3T1kvMGtWZktmT3diL1VSMzV2cHhGdThlNDRkUlNN?=
 =?utf-8?B?Ti9hN3QzZmlyWDhwcWYyNlpiOWwzc1ZrYlA4a2FFV1FERFIwK1pVcHovVVpo?=
 =?utf-8?B?WnhKa24vUThEUEk0aklDVFRsTkdRUU94ckozeEtOWE5iam1CZldaaEJVcWwx?=
 =?utf-8?B?TVJ6UFNYWjhSMEVzMUV6bGt4M2RuV2tlN0ZEVGxXQWh2cFYwYnh3Y0xhQkVB?=
 =?utf-8?B?ZUFhMERwSm9rUFZxa2VwbE9nRk5oSkEvODhjODVxZWltUzc3S0dud2hFUWZh?=
 =?utf-8?B?TE1vVUFQYW41dXNPL3ZMVU9pREhXU3lFWEhSTEpoL3FYQ2toTEs4WHdoV2hZ?=
 =?utf-8?B?TGlJMTl5akYvdS9rU2JLU3VhU0F1a3pDSjZha0RYYXNZbDZ0dVpzVDVXc2lY?=
 =?utf-8?B?bnBPajYrSjVtYWpoMUtOZ2pLZ00xekErZ2FhdFg2L2ZGV29YN1g1MWZFZDBn?=
 =?utf-8?B?b1V1UnNyZklYSFZSemw3ZmJZRmJQYXpPZXRGblV3YzJDeDBtTS9LZ2t6TGdQ?=
 =?utf-8?B?RUkrUWJqRDVIcldCeElaOEFpZnQyRHVmREJtZGZzK2dLaUx2eGNjTTZ1SHVK?=
 =?utf-8?B?eW9tZUlxWkp6OHV3VGFhTURRVXFuSWFmRlh1a1ZSUDZhcGRYaE42UEdLa21X?=
 =?utf-8?B?bjJVNzZHVEZKS2hpZURFM3VmRVBVV3QrYWV4eGJsR2c1alFtTFJ1RzcrR01u?=
 =?utf-8?B?M3k1bHh6bDNqRm1iVkJQa3dZZC9ORDZoSTZHR0NmTXlUc0lLZGx5SXRGVnZB?=
 =?utf-8?B?LzZLRSszYmtMQlNUb0NqeE1mYWtCa1lXYWNpaDBBYm41L1k0QU5UTFlEU0dF?=
 =?utf-8?Q?OZdldaW8TiRFFymBy8AyHh0Lq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72829d0a-70db-4cae-c731-08dd78bf2926
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:07:38.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aiqQn9mEOqoZt7RStn89qUHhLOhRUVwnG439Mm4MUaoRUJke3sq9Qxdm9XgbR5urOjR222iG75iVQ8YvuyuoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833

Hi Paul,

On 4/10/2025 1:49 AM, Paul Moore wrote:
> On Tue, Apr 8, 2025 at 7:25 AM Shivank Garg <shivankg@amd.com> wrote:
>>
>> KVM guest_memfd is implementing its own inodes to store metadata for
>> backing memory using a custom filesystem. This requires the ability to
>> initialize anonymous inode using security_inode_init_security_anon().
>>
>> As guest_memfd currently resides in the KVM module, we need to export this
>> symbol for use outside the core kernel. In the future, guest_memfd might be
>> moved to core-mm, at which point the symbols no longer would have to be
>> exported. When/if that happens is still unclear.
> 
> Can you help me understand the timing just a bit more ... do you
> expect the move to the core MM code to happen during the lifetime of
> this patchset, or is it just some hand-wavy "future date"?  No worries
> either way, just trying to understand things a bit better.

I am not sure about it, any ideas David?

Thanks,
Shivank

> 
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  security/security.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/security/security.c b/security/security.c
>> index fb57e8fddd91..097283bb06a5 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1877,6 +1877,7 @@ int security_inode_init_security_anon(struct inode *inode,
>>         return call_int_hook(inode_init_security_anon, inode, name,
>>                              context_inode);
>>  }
>> +EXPORT_SYMBOL(security_inode_init_security_anon);
>>
>>  #ifdef CONFIG_SECURITY_PATH
>>  /**
>> --
>> 2.34.1
> 


