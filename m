Return-Path: <linux-fsdevel+bounces-55635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3176FB0D113
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 07:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DB117B135
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 05:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030828B4F3;
	Tue, 22 Jul 2025 05:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gyvt522G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E1239E9E;
	Tue, 22 Jul 2025 05:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160629; cv=fail; b=cdSRnYZP+y1tsfxi07WYQQ0m/+1jw9bdCWGIXf80n/qvRm/nkeO8hDvZI55TVHnVJwSsCA3tJWN3pQLSL+Y3e47qG4+y2YKpMYlSJyLKOB0J2EoNbIEvO3I1UcTV9znAP2ERn2DSiVEa/9j619HFbwQBsCh1kWFIPDNAAgCdS4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160629; c=relaxed/simple;
	bh=Dg5rXHHetPwaxAY1HcjR9CzxqQP0eqUKxX9h3IpxRkE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fkuc3P2ugzdLr2h87fXAigLTSJGFgiY9IkpAhJiiyhbDYG1RW/u6Md0TCr3Kpkv5Ap5/5bsbhhPVMMYIzlvUIrUEfFpvzNLQDfRQFO1cYEywGNAd8PFKeP4rJi8JOQ0sbGn/uAxM0fVKxqeJXfJb9OO20awlsZXYZnD7rpuTPvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gyvt522G; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuWW1NJS0w5sBeuFqpX5rgKC0hrmSUiP84Y1nkrNIONz8BLE+v2iqzA0TCtLCkvMcd0O42rM4lUP91L7m1rdJPvSnnX+L4DY8xI3ffFxa8CJO4H+DW4u0An68sBBYO829QBM9Z2sSGwuN1WpZBrK88B/OgibX7cdYp+J+ye0/vwtAzZSsMMO7DQNtQRT2upE7CJ1AZ9ttiY7BKbljiiGR82bgn0PAIiVTk0UCd+NJ1dSjKt/Bb3sIVl3hRhZtq71vXz5dB3lbSpI5jHzslYsdOwNUuGkcFBvjO/PH5X0qQJr5o0zvrSUvoj3Tqid4I1OTVAAVm4c8lVIsTLQlE/0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpziEwX72ofLhYwd8I8BEgyS8aRVIk6TgbweiHUswVU=;
 b=YPFaR0NGbD4JTD6iV2GodjVy2VAGlu1jyxJOYA76Wi7pbJM6BBWcDTt431wHRSyskPuU2BL2434+8/vJ/16veUu7Oi0Bu+NrcnBsn/U7wiCBpLUAroNL3Mmt8cl+khBmKUJFLXLHFQAtsDMbvIVzBF07j96tPWgfsPOh+24G/Rq5lygwTyK+R+WgcVqht0SL4ItfJ6MphlVNvWNvN4UxL4dxjKUPIZJOxphuq/5N48BoR7udERnwzGVfQ5vT3qPEw/l0sDl5XbmowM+2YGfYFPO1xdP6hFJ4QEzrdSF9Ed4l/bKcY5ru9vP+XO4zbQmq+QIkBGFT17cUZzVmnC+NGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpziEwX72ofLhYwd8I8BEgyS8aRVIk6TgbweiHUswVU=;
 b=Gyvt522Gv6J2BcgvvW/IJhwtmhZyfdwND/2/Z/gplnlvi+d1dMSZ1pO4/CxC6RNi4jrWp6p0PFNiwpAlq+mROjmDlYc3yBkVuxgnOaBoEIpfKZ9wy+unaDz41uDZ9iePaN9Vh31fE7ZR6iEalLr7hrjDNXbl+pqTFUkEAmdO+SM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by PH0PR12MB5630.namprd12.prod.outlook.com
 (2603:10b6:510:146::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 05:03:46 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Tue, 22 Jul 2025
 05:03:45 +0000
Message-ID: <696256a9-8acd-4036-9a97-b0aae6411d5c@amd.com>
Date: Tue, 22 Jul 2025 10:33:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 5/7] KVM: guest_memfd: Add slab-allocated inode cache
To: Vlastimil Babka <vbabka@suse.cz>, seanjc@google.com, david@redhat.com,
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
 <20250713174339.13981-8-shivankg@amd.com>
 <78f3032d-dfa4-4907-be42-6a7e8a34371e@suse.cz>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <78f3032d-dfa4-4907-be42-6a7e8a34371e@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::15) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd604dc-81e5-40be-4424-08ddc8dd21f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWRvSHA0YWJYbTBybElqVGdjQ0JmVTZRdUlyVy92WXdUSStjYW50RHVJL1dh?=
 =?utf-8?B?NVZOYnRJRlBhZ2dRYkRxcDI2dEJPTTIzY09mWStVVmJDdGtxdkdpSENZRFFV?=
 =?utf-8?B?Q2FjMVpCTVk1cUZ4czViakZSdllGYXlrVzNmc2ErVy9OVTMyTklkS3Q5Ykpy?=
 =?utf-8?B?MDFNNFdlYkJVbno2ZHYwblR4bjZPWXVqS3AvcHVMeUJIZkE1OFBqYXNYRXpK?=
 =?utf-8?B?YWhnMzA1dzZibG0xRUZxT0Zwb3M5djc1SS9NRSt1clhCNXVKbi9rK2pJNU53?=
 =?utf-8?B?QUhlWVNlaFU2MXo5RmtjdnZLWnBFSXhKNzc1RXg0UW1lNDVuYktzNEt1QXJV?=
 =?utf-8?B?b0RnRUI0M1ROSWJ0dEtocE1IeGVFOE9XNzBhdy9ueHZialFwaTg2SzRqQVZS?=
 =?utf-8?B?emFoaWcvMU5Xeko5a2tMdUVIS0lWK1RMdS9DL3kzMjg5QnQ0emlsdC9VOUtF?=
 =?utf-8?B?RUFCbGVOSzNrNW44cHJBZzRmVU5TTVNaZmFyZldwZWpVUlBseTBWTzU2WjBF?=
 =?utf-8?B?aVBzSkNGYzhneU9yek8zVVl6eldSNEpMNyt1NzZyS3ZOUmlKUUs0OHNWNUZs?=
 =?utf-8?B?N0tpNkd4aXIwd0x4Rk5EcHZ2dVRxUlYrTDNaUkhOWTJrckQxdk90RWc2aFdO?=
 =?utf-8?B?UDJCcDhVdlRBTjRZSDBUNUh2SGh2cGZZc0FnTENkNUpQeTUzSFlXWnJLM3Zk?=
 =?utf-8?B?czBQY3JiL3M1OU44SG84WnphSVVlRFVzQ2xSTG5FUmpUTFhQc0thcjlmQyt5?=
 =?utf-8?B?d2xERE9RSXR4T0hvcGFCVW01a282REVYTW8yWE1FNjBRdWVQWW9UWHF3RHU2?=
 =?utf-8?B?a05xZDFiNDU4RiszZkprVmdHNVBnTFBmNnZtdFdBZE5iMFBDWjJiNTZMQnBW?=
 =?utf-8?B?Skp4UEVXNHVqQklHQWE0ODB6WmlEb0FqSTV4TXNkRjRPcWpHQmFxMEZGOUIv?=
 =?utf-8?B?NlJ6ZDNmcEtkTGRHZEdjbEE2czduamtIR29TdUgyazMvemxyNzRGTVU2eFly?=
 =?utf-8?B?a1BlaGVGRGgwNVNWdzdsSFJYcDZpcUZNZTFHN1NTVStUd05xbC9HRkk4ZnRK?=
 =?utf-8?B?aVY0SXBpem94WGxTNEhzeW0rMVh3ZEs4ZUV3QVZqWGxMcnhMUjN1YmN1Tk43?=
 =?utf-8?B?OUUxbXc3d2V6T3lobE1UamZaTjBMWm5melUvTUI0K0dzNGI4RElmVmxEdGRl?=
 =?utf-8?B?VnZVbUIyK2V5TDMraEZGQmpOS3lnSW40Rng5dlpDWUJSUURIQ2NBekxDL21h?=
 =?utf-8?B?OXZIc0V0VGwwcEk1dEIxZ3owK2ZDNHBDd1JGN0dodlVyTjNldHozSk44N2ky?=
 =?utf-8?B?SHovckoya0NCUkR3TVV1aEplWkxkbDYwdHFQT2h6R2VscEJWbVJEYThBek44?=
 =?utf-8?B?MlNyMUJmZURvcWV0Y1hHWWJoY1ZQalArclJiM2FiZ25nRXlOQTVhZ0lyWVlH?=
 =?utf-8?B?endEcTRPRWtSWlVXWW9uM3BQZjVjdnNzR3l3UkNNMVJRTGlmVjBLSHU4K1JK?=
 =?utf-8?B?Z0VKQkJsMnRSa0R2Vlg1dVdTOUVIenZRdEdWdWg1M1Mrek9yV3Jvdnh0ZDBm?=
 =?utf-8?B?Qm9uR2FvVFhPTXhReWROb2d5M29jaVo5ZDRjZ2xKMkM5eVVkOGIrQ1I0UGtX?=
 =?utf-8?B?TE9KTm8vWVZYOGxwdTYzaUN2UmxqdWxydER3L0NCaU5ZUXpWSnZvUS9POGZW?=
 =?utf-8?B?U0ovM3hBOWhzQ05tRWpEV2tzMkpad0NjS0ZBNUM3ZUFjM0wvMWJnZ1h4U1Mz?=
 =?utf-8?B?OG9vMmYrZnNsYTVkWFpueTZaeGxoUDZKd1YxNWptNW10RllRRWpmbzA4dU9N?=
 =?utf-8?B?OElYMzNGZUJjLyttTEx2QXRnZkt3ekRLUm5PSHUza2s1Q09NZlQzc0N1M3Fx?=
 =?utf-8?B?MXNLQWY1R1JsRVhpMm8yQkdXQk02enN3UjJYNGNHVk1FVkZ6WUp3ZVdraTBj?=
 =?utf-8?Q?/FMmKHpmjrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTd2bFRxSlh2RURrMzZybGJWUVFoQzlDdjhQSnFZTXVtM05hMEZWeVZrVDJJ?=
 =?utf-8?B?TlRIM2dSUUhaa1F6ZGFEWTVEaHFsVG1uWmZrZXZOTzRsRHdPbGZYRHdLVG9H?=
 =?utf-8?B?bkxYYVAzNDByVHRPT2dYUVk4QXhmMEtObTl3L05UT3NyeW9XbCtnZlZoMlh5?=
 =?utf-8?B?aVBXaS92TXB0bCtUUndTVkZmZktjU2l4WEIvWHdSWHY4SlhGcnpFRjMrcEh5?=
 =?utf-8?B?UWkrK1RGNnFXN3hjSGFDaU9qQk1JU0k5bVVmV2w5QVJ2ay9yMXhsbzgybGt5?=
 =?utf-8?B?YXpWMHJTMTNtREFqeWwyenV3RDhrc1pVSDhNWWhUM21KUXljTkRPeGFUNDZ1?=
 =?utf-8?B?SHNqQXpSeDhMVURONGtma1kxaWxrc3J1R2szQ2xrNVhDcERwMWZPbDVxVXFJ?=
 =?utf-8?B?SmJKckpRUFpNRFBXVC9nNTVmMHVId3FUaFRVWjY3QVZqVXJYcllDN3NnOGc1?=
 =?utf-8?B?ODR1d3MvcUhxSHhZN0N1YUxlTlArV0RGOXdkR3NVeCtKTmxEUzYzYVJqeWFR?=
 =?utf-8?B?ODBqQllrMWFyUWNiWTcvUTBLaXZ5cmFnenlnUW90YW9SSE9xSWpEeXg3RkNB?=
 =?utf-8?B?d0xRY0xsSGFLUzBQVk4wOE5KTWs2WW5GTGZGRFE4cEs2TFhFQ2NLcDExc0Nh?=
 =?utf-8?B?Y1o2WlVxV0NRbnZDbmVrY0EvSytxQ05KaTdINTZNT1A5ZzNNSnJBUG4xdGNw?=
 =?utf-8?B?cGVtZHh4YTNqOWdqekZwbHY0Zm5qQ1ViVTBmT05jQUQraUtRb3VLOE9EWFpB?=
 =?utf-8?B?K0RDeWVlakhZN0kwVDFZakdsMU1kWTY2ckZIMjFtMy8wMjM0dnVLNHQ0QmtF?=
 =?utf-8?B?UlAzNlVKbFJZZUVKS2I5eHhVU2xzT0M2OFFMVjVzd1ludFVaODE3eTRkR1FS?=
 =?utf-8?B?ZUp3R2JvWVlBSkFvdlFUbGtBcStIalo1S21vbG9yZ3lTUWgyRVRUY0hvSXgr?=
 =?utf-8?B?S2lCV1k4Q2xKampYSE5hRXN6ZEppL21XWUpLdGpJOGJxRXliUUxGSkJET2VG?=
 =?utf-8?B?Q09rQU5kYXlnQmtacUJlWDljMk9QRGEzYUYwUldVSWlGSFBaRUN5R1lDQVho?=
 =?utf-8?B?M3MyTlhEM1c0TWxEbDVNSVNXdFFndHRyOGdSb2htS0dLODJocFRhY24vWVY4?=
 =?utf-8?B?QUNqazlGUnlSYTFFRHBPZjJQbjJLTG1Vak94ck0zdGpZVjB6OXdGTi9XM0dw?=
 =?utf-8?B?V2E5OWN2VGpzL2hhR1dId2pFeUhyUEx5eUxKekgra0dBZlllSzduM3orbDNX?=
 =?utf-8?B?TkhwdU1CejBYcjJQTnJsRjE5dHdzdWtyQnlCOGF6bFNPQ3Y4ck90K3I4V3ox?=
 =?utf-8?B?WVNUYlZGRk9nTTNBbjZ3clV5TmZ6aU5RK3FoZXFXR3drZnBwTVVxeENGVG4r?=
 =?utf-8?B?dkNlYWdPSkxoLzc4UFBwdFZiYzJJQjdJbUVyaHFuTGxMbTZTZjVubm05eXgw?=
 =?utf-8?B?a000YU5UZWxqWjFrWE40MTk0RFNHalY4WUR2ZS9MWmNNZi9rOUdjWm5KYWRP?=
 =?utf-8?B?a2NLOFFaai82dXJUd0svc3IzdkFDdVgyTDFBOHdUYkh1dXZ3bXlnNkEzN3o4?=
 =?utf-8?B?OWNHc01nUE5vTGdGcXhFTkdBUE1zSVkyekxCQnZlazZiN0ZxUVlkMFVrQ3Ix?=
 =?utf-8?B?VjgyekJiVnRHM3dRLzlHbmVXbVFIczhhY2F2OTVSaGRWQTNrd0pXdmU0ZEJt?=
 =?utf-8?B?OTE1UVZDejh1NDVSSzJYUXZmYkpIUHpHSGJITERabC9Obk90Rk5Fa1JCcmRF?=
 =?utf-8?B?QW02Z1AvZENwaTdaNkgzM1ZyRTBzOVJHOEZmS0NoSnZIUUpCdHZSamJ1SVRQ?=
 =?utf-8?B?c29vQ241dHd1VkhvdUlwWVluZVJLekpzWC9kbGplbm15Y2JaZUFFTnhxSTBP?=
 =?utf-8?B?UkpEWkJxbTNvUjlhcG5HWUQ1djNHR0ZYVzNXdVQ1M1A2YkNiRGlWb0lwVVBS?=
 =?utf-8?B?eCt1bGVGLzl1R1RMVzEzM3o1TU1IZlJTdUEwOW9UZytXLzY1V1R2elRVUG53?=
 =?utf-8?B?M01XV1Bnc3d0M3VZdkJyNnFrQ1loUjlUajQ4Zk53VmZSMzgwRms4dzNES2F1?=
 =?utf-8?B?OVZYU1BBRStrZW5LV3hFM0FiSmRUSmw4OHhtMjR6V2Z2UHQydmhFRExCK0RY?=
 =?utf-8?Q?Ei9hT/JX7LSuW5gELMFmbZ43O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd604dc-81e5-40be-4424-08ddc8dd21f4
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 05:03:45.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L72FraOX+G6+UJbbjh/X0VRU+LqmGHa7KYgLfDjBa+gtFZrawVg0xLeXcL7MUkbAu06AOtAvWOJatf/6Cw3tLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630



On 7/21/2025 5:14 PM, Vlastimil Babka wrote:
>> +	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
>> +						  sizeof(struct kvm_gmem_inode_info),
>> +						  0, SLAB_ACCOUNT,
>> +						  kvm_gmem_init_inode);
> Since this is new code, please use the new variant of kmem_cache_create()
> that takes the args parameter.

Thank you for the review and suggestion.
I'll update this in the next version.



