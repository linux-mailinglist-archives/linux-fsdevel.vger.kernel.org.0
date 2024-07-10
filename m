Return-Path: <linux-fsdevel+bounces-23489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C081292D482
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768122827A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C51940B3;
	Wed, 10 Jul 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bMrRdvzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171915E97;
	Wed, 10 Jul 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622905; cv=fail; b=co8zDD2PrwZ+ildOMlHCQCONosVi/7zbcDUJz74EDE0+/ZNTjBwUOT2nCdt1ODLkRCf6AsUBBjiVIf6kqzR5jVfPFehfMZW89gifz1VrRGJG1Y2AIlOFFe336iTLJf2qoKZkLCGMRjSJg/ma3gcW3xWXY0MWZ2ERybDOzEEtvLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622905; c=relaxed/simple;
	bh=OMsN+opJDx5WyALIo5bKC4M3ox0i9xD6Pmu9uSwksGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JRQDdXyby1o/IJI0uI/NUbYBJMfUy4D2hDIRxBOMg/ARqTJv4AqEdOGXQjLFC2N1jLNxQh8nX+tCtOT3Q65SPF4ey8FHDTHpDiMT2uL+VOTondsUrdaZX2F9eFgPiTHluJP1HCQSqh1tiMVeYS6huaGlKd22upnSfN4aiZ+dyp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bMrRdvzn; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feWMJ0vZJDw4VCcR5wb5ms0E4VTL3qS01aXjZ29nL7qG6W8PRy3xq/cYI/AiajTCXm+Rc8Ir3qLBFLwt9JBNZ7k9HdWaf55nEZN19IXVxPTZbk/TFPUj9oKOVThqtutAxOsWedbDpFvNOlU88oHI3QsLWu8u+QAYzvHsdLOfm3NUfKaacPEsQQqe0cGF78j8z0gL5DAXX4pzSuFYmEMR4oERd9J+ymwjye1KG81SSihe8wYD30Jj9SOx00ieyw6cJR/3a5gk9CmvtIMm7O/MS0JdMR8HF27bVC1ZqCEiM3d0a1vMf7DgYqFhMJR29Mf+7lEnvYbA+qgEgnrZISuk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CBzI8yAb0Pn8ANnJ7k83L1gWb1Ok+HOBPvyMpbF+Tk=;
 b=awTFJXgK0EaRpwg1q5g2EKHS7amdiNSq00VgjFq3Ieu1sCyIa4JhHDLzmPkamHQ1M045GLfo7qeEjELHpjQa7rU6KuMzgOqO26OmtDegDiG78prnUuMacpwXh0ntS8Aq+MCTJKvwZpmwacS53+R3gScTAJ0Um8pY/faaVTFCikK9OHykWToiGUUQoXVQ2x6SlXQLZbj0OBxkuY54FaHClXGmkh4dqpnhJgq8P6IZTnX+HFvm56hHSyX1xkaXlRQjHeF+Ql0L7RwgTECn7SFB1yuycGIL2sV5JjZ3oMzYehV7M4WOUyiTGOluOz5rw/lOk3fYWOS5yWPleoIgWkSu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CBzI8yAb0Pn8ANnJ7k83L1gWb1Ok+HOBPvyMpbF+Tk=;
 b=bMrRdvzndLQS3fqGB+V9FiDetekbdRfPB+N5J8jVHca+BHVYYMWLH3uM9PviDBEZeVrf9yFFod/SSuOXuBDFOGsfROKpSUulilzPCnF98SqaVULCAjjfyVFkt26VRjZhTvViDvPAQYXXzhl0cj4wV8npJ385l1u0yBkwE4IGxqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 14:48:17 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%3]) with mapi id 15.20.7741.027; Wed, 10 Jul 2024
 14:48:16 +0000
Message-ID: <0393cf47-3fa2-4e32-8b3d-d5d5bdece298@amd.com>
Date: Wed, 10 Jul 2024 16:48:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support direct I/O read and write for memory
 allocated by dmabuf
To: Lei Liu <liulei.rjpt@vivo.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrei Vagin <avagin@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Daniel Vetter <daniel@ffwll.ch>,
 "Vetter, Daniel" <daniel.vetter@intel.com>
Cc: opensource.kernel@vivo.com
References: <20240710135757.25786-1-liulei.rjpt@vivo.com>
 <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
 <d70cf558-cf34-4909-a33e-58e3a10bbc0c@vivo.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d70cf558-cf34-4909-a33e-58e3a10bbc0c@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::17) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 919a9205-e24c-4d81-eae1-08dca0ef553f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anpiUmVQbmFJN2NnSG4vQmxBNi9DNWRTbTFrZThLcG5tMndrbEg2dlY0TGVq?=
 =?utf-8?B?VEt6eU50R1NFV0FYN3dXS3JrdDdUeXNESVN6dzAxNkhuWU9XbmR1dmlNTzNw?=
 =?utf-8?B?MGV0ckI0ZkJaR2FaRVl5RW9pMDBZZGF6K0hKKzFEaFBUZTBXY1VjekszTFhr?=
 =?utf-8?B?WlR2eTg5TDltNkJodHgwRXE3MUkza0dBdE1qUm9tSmFSZlp0aStwNGhWZ1Er?=
 =?utf-8?B?VEdxYVplM1U1cVZiYktQR01TTzNpdGd6bnl4Nk1RQlFSRDVQdlZXd0dEZDVz?=
 =?utf-8?B?bGRsR2t6RTVSeHJBS01kMGR6cEJWbnNSaUZ5VFZvRkFrUTNRcGlHcFlGNU1z?=
 =?utf-8?B?UEM2U0ticldUdG13MlB4dkJPZkMvbERUNEdmTWZuZkZiVnIwT1VVeVdTWFhp?=
 =?utf-8?B?WDIrSlhPQm1XcXl2bnBPWHNjblB2b0pFc2prQ0JnZEovZXhhQkhWcmNiSzVG?=
 =?utf-8?B?cmRjOE81WURRLy9SWmVNV0Q0RGVIU05aNVM2SDBjNVhvblhqTjJad2xxTkhV?=
 =?utf-8?B?RjRFSTVJQk4wc1hTTTdSdjRRZlR1WHpmVmY1YUdsRHJ6V2pVWGI0NVVDSHV6?=
 =?utf-8?B?cm9SNjJISHN3QzJ4YXYxU3BrbzU1RDNEVHhFZWZVMFIweGRkM2pzV1lTYjBX?=
 =?utf-8?B?d1ZXa3UraUpuZXduczVGZW9PdmpINVBjZ0JuS0ZQd2R1UUNGTTlLNmZ1T1li?=
 =?utf-8?B?V3E4SUNuTmMrVm44eWhUcjNsMGt2MWZPdkNacUhXUXp4Y2dOWkhZWjd3VEVQ?=
 =?utf-8?B?SjErSGJzWmVMQkgxTFlabnBZQUhQMUV0anRua2c5bDdKbWFhd290VXE2L0g4?=
 =?utf-8?B?QVJQdHR3VVkrTGdQRU4rTU9xSGdRRmVweEF1Y0JzdSs1T2diWVNKNHlsL05Z?=
 =?utf-8?B?Z3Rob09seUhLb2k0UUlMa2lQd3N5anc2VXNBSnczZkNnWTk0WWJoRXR4cncr?=
 =?utf-8?B?VXdHM0gzZ01KMlhXMjhpQ0JjRzZNZEZMYmZiY1Q4cUJiYmRvM0M4cmw3dE9K?=
 =?utf-8?B?Nkt2dGdvNXJVRnJ5TXFuSTdTakpMNVRMUHA4a0tmUytKRGNEcmJoUHVIeFMv?=
 =?utf-8?B?UThjYXIydUozK1RZRVVLMVh5UU4xSFlEVjVpK2ttbFJSTmd6b0d1S2Q0WTU1?=
 =?utf-8?B?MW9NYmlXYUgrcmROUUhxWk9CcXZPWW1GdWZZTFpoaEtSWGJWQlUrR0tDZHJK?=
 =?utf-8?B?MzM3LzhrWkkzL3ZVQk9yYVcyK2VsSm9hNGFteENocHFnd3ZHUXJnZDdPamg0?=
 =?utf-8?B?V0E0R0prLzQ3WHNzeHk0bm5VS3dzWkJKWmtFT1JzODNLTk1ucEFwSVc2UGtM?=
 =?utf-8?B?VFJjSGUwVWVHV0tpVE1ZbnFZYlorY1N1dXNSZlB3QVArOWxudUQ4MVBjVmNK?=
 =?utf-8?B?RHE0aDlJam1yQTlxUlk3ekt4TmZ1UWNZajRrUDR3RGpRQlVxNFk3TDJPajhR?=
 =?utf-8?B?eXhUV21DQkdUMWQ2VHd6T09yY2lZb3VKd1ptNlBMRGc3bjQyeWxsZWJSeVJy?=
 =?utf-8?B?ZmpCc1hYZHd6bHZGV0RnWFNwZnVUL1I3MWJvL3dqeDV2Y0x5S2Y5T0wyZzNR?=
 =?utf-8?B?U1VudURxWmRkNnB1eFNoWURCNmlnUlNVbVVpQ2JZUGVvQkhaTTIzbndrTFo4?=
 =?utf-8?B?TzBZSDBZTUhPNGZtb3pmR2Vsdm1RaE1DejAxdlRwS3AwSWVCVGZXcHd4b0p3?=
 =?utf-8?B?NkVPN2tqSDN4UVljbi8rUmg4dnhNRTQzTm9GTnJqZFJjWGQxcmtyRVVsU3c2?=
 =?utf-8?B?UVBjcXJZbGduUWhYSUxINlRsU2ZoR1VVTlQ0SWJMSjQwQnpUbXo4bENlVzZz?=
 =?utf-8?B?RGsyL1NHMVExY0VqTGhDbzUycXM3dytUT1NaeUxyL0FKeDNzUmJxdXpOY0RF?=
 =?utf-8?Q?QAqgtY+2W0Zoq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5673.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1VJRElDNGZHSjdtbUQrQUxNWHpaSlRoL2JBTjE5L2Fla09PRnhPamFDRlZI?=
 =?utf-8?B?UkwvT2JIMFExemwrOU5KRlUvN1hpSE1rOXc5R1hhZEFGdVV3Wlc1TGxpV0FX?=
 =?utf-8?B?WmtKaXBoeVRMcVRzTXpySHRabXlYRmFYdTg1MGQ3V1hmVlZNa043VndZN0Vq?=
 =?utf-8?B?WkczQ1ZUTEJ3Q2lrQ2Q4MW5OelBBUmI4VVJ1NFpCQjFWQXQ3VmRDZ0hrMDNU?=
 =?utf-8?B?SHM4elUxZmtQVWVLNDIvSk9tS1lodzZjbDFZb3ZXOVI2NzgrODhHeFFDeW1J?=
 =?utf-8?B?ZG53ZWJRdGdTV3hSTzAyQXJoM3didFV2TzRVT1Z5TzhVOHRsaldYMnBJbWQ3?=
 =?utf-8?B?ai9ja0FxTXluN0Y4VHpUa2YwalVONVhyWkRuQWdMOVp1cHlsSmVmRjhRUDRZ?=
 =?utf-8?B?MkFaRDJqZWNtZHZnQlJRMXdHUDV4TTlSd3N5RkFsQmRSb0phNVk0Zzhwa2FE?=
 =?utf-8?B?a0JmQUI3dlhqQkREMEk5LzNaQVNtaUdUSi9Ba1ZQRjZlR1B2dVNHejh2blVQ?=
 =?utf-8?B?TW5wSFE5cXpvWmF5ck1KQjVLQnpnMDAyVnFpU0R3bUlRN0tzQWlWNlFicTVQ?=
 =?utf-8?B?Q0tNOXp1Z2lhRjFMTitRWkpzSGFzMUtQdWtvTDh4aWQ1RnQxa2toUGFxWDJC?=
 =?utf-8?B?bm5POHdvZmpCNjBoMC94YXdxR3QwSU9tVnFGSHRkUUhibGhjNU1yYXJXdWtp?=
 =?utf-8?B?eE5pL2pUUVJYR3Vxa2NvbkhJVDZKQnZXQzhvb0lTWDVGRERXSjJvazFwR3FV?=
 =?utf-8?B?Nkhqd1lIQk0vT2JjT0ZBUFVCSlNvTEtnM0RvY0pHSDRBRnFZOWs4N0kxZlJ2?=
 =?utf-8?B?OEVjRWpPRnJZcjJ1WldCWkxmN0FVaFdHM3ZwME8vTk4vcU1rdVBucVdFQkdF?=
 =?utf-8?B?Z0xMZXE0YXBTRVJvZHYxRDVGU0hLQ000cjB6VGsyZHpzL0FIS2ZyWWN0YkQv?=
 =?utf-8?B?clkyeGIyeWN6WWpYOEZlc1EvYTZsM1V3eTRXdW53NWRPeHBNcUJhQXVaSTVT?=
 =?utf-8?B?VTR6THBVZi83UWdxSmdQa0l1NHdBRk52OHFnUVVnMktqRW1GTTRGT3dVWnNT?=
 =?utf-8?B?YlhBR1dFenhSc3hVVnJ1TGkrSVVtRXhBUGdod3E1WFBFeG5lR2dKanZ6R21w?=
 =?utf-8?B?VmVQb1ZxWHBZeWNhUHZvMW9nTXFwdjV2UDV1ck5Kb1RIQjRRUFAza1pEY1hw?=
 =?utf-8?B?RVpqMHZVbDZlL1gvaEx1Z0ZGaVpwNHFvTXFpVm1wVkhhSTRrSHF6VkxTSGJv?=
 =?utf-8?B?UUgwOURJTnY4REhvbEcxcW1RamswcHRzamFHZjJJOEl6WDArVFVqRlQxN3d0?=
 =?utf-8?B?MGhHMm1zeDZabSthYkFxUEs5STFRL0pCREZMT1JBQWF5OTFncVlra1F4bkdE?=
 =?utf-8?B?VWQvMzdSSHYvblhqOUtxcEJRS3VjUXlINGtWWlovb1VUZWxIYlk4K3R4TFEr?=
 =?utf-8?B?bkpIcFZxekExcWk5R2NBQnA3VU92WklMaC91U1pCL3ord0hKRysyTGViMWJo?=
 =?utf-8?B?WHVRSFpnV2N6L05PaCtlRDYvTDB6SE9GTkMrcWxURmF6aENuUFdUM01RZ0ps?=
 =?utf-8?B?eStaWjFleXRkcXJyWk1QdEJhNUdIN01iZEN0OER0RWp4OHl0R3pXRUdYWHBk?=
 =?utf-8?B?VGZKSXdnQ2NobSs5dlNPSXQzNEJEalQ4QnF1Nm1meHJlUS8yUW9wWktXZDFw?=
 =?utf-8?B?ZmFNL0pleldyUmlKaGxteUVYMGRVeFRiSVJvd3NsdEFlbk54TUlmTXBvMFhv?=
 =?utf-8?B?RHFobWp1Ni81ME9LL3d2Y05Rd3Q0VWIxcWRFNmlVdGI4WVg2K2l6b1RNa0FV?=
 =?utf-8?B?a1RiRUVJTnBNdWtJZ3I1UmNPUXJ1TVlFYXFEa0FKRkYzK0krZUVnZXovd1Mz?=
 =?utf-8?B?STdiOWNKRDV3bUgzaFJJazNha0I2RmlpbnF1aDkvYk5QQm5FOGVic1B2VWY5?=
 =?utf-8?B?RDhJdVc2VUNtR1AwTms1dEV1QWphNndRMjBLZU9NS3kwSUZQTTV4UWU3Z2dB?=
 =?utf-8?B?RjRUeEhkSWhtN0NXeENjSmV2T2RsZlZteWQ3TkVWVTJoNzY1SzZwT0J5cGhH?=
 =?utf-8?B?b2QrTkN0Z3dZQ3lYODJhWlF2NCtBSVg2eTBFK1RoVW84NmtBTzlaUlZVSUV6?=
 =?utf-8?Q?YavE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919a9205-e24c-4d81-eae1-08dca0ef553f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:48:16.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQ/pWqGmU0i8YbcTENfdUQRo92/2Xdfz9Kgpg76Dks/i7Kz/GKXqb6mZIQOprJrR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692

Am 10.07.24 um 16:35 schrieb Lei Liu:
>
> 在 2024/7/10 22:14, Christian König 写道:
>> Am 10.07.24 um 15:57 schrieb Lei Liu:
>>> Use vm_insert_page to establish a mapping for the memory allocated
>>> by dmabuf, thus supporting direct I/O read and write; and fix the
>>> issue of incorrect memory statistics after mapping dmabuf memory.
>>
>> Well big NAK to that! Direct I/O is intentionally disabled on DMA-bufs.
>
> Hello! Could you explain why direct_io is disabled on DMABUF? Is there 
> any historical reason for this?

It's basically one of the most fundamental design decision of DMA-Buf. 
The attachment/map/fence model DMA-buf uses is not really compatible 
with direct I/O on the underlying pages.

>>
>> We already discussed enforcing that in the DMA-buf framework and this 
>> patch probably means that we should really do that.
>>
>> Regards,
>> Christian.
>
> Thank you for your response. With the application of AI large model 
> edgeification, we urgently need support for direct_io on DMABUF to 
> read some very large files. Do you have any new solutions or plans for 
> this?

We have seen similar projects over the years and all of those turned out 
to be complete shipwrecks.

There is currently a patch set under discussion to give the network 
subsystem DMA-buf support. If you are interest in network direct I/O 
that could help.

Additional to that a lot of GPU drivers support userptr usages, e.g. to 
import malloced memory into the GPU driver. You can then also do direct 
I/O on that malloced memory and the kernel will enforce correct handling 
with the GPU driver through MMU notifiers.

But as far as I know a general DMA-buf based solution isn't possible.

Regards,
Christian.

>
> Regards,
> Lei Liu.
>
>>
>>>
>>> Lei Liu (2):
>>>    mm: dmabuf_direct_io: Support direct_io for memory allocated by 
>>> dmabuf
>>>    mm: dmabuf_direct_io: Fix memory statistics error for dmabuf 
>>> allocated
>>>      memory with direct_io support
>>>
>>>   drivers/dma-buf/heaps/system_heap.c |  5 +++--
>>>   fs/proc/task_mmu.c                  |  8 +++++++-
>>>   include/linux/mm.h                  |  1 +
>>>   mm/memory.c                         | 15 ++++++++++-----
>>>   mm/rmap.c                           |  9 +++++----
>>>   5 files changed, 26 insertions(+), 12 deletions(-)
>>>
>>


