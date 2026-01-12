Return-Path: <linux-fsdevel+bounces-73317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 773EFD15808
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38DAF305E2A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 21:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD5A346AC2;
	Mon, 12 Jan 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWrIlGYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48124A05D;
	Mon, 12 Jan 2026 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255089; cv=fail; b=fgZTgKRuo5IZNICDRaCVhAxua5vw963q1xf4tUtl9Pq3IR0TuE3aYWgBxGbuOS2ONa52wwih/ApOVH8XXpRzXuyoXYzuawV8wOjMElNf03OYzSeOY4W4dCNg7Jx6J8tA9EaFJ7XgLHX4nwIFMx7lXGERRpjGonMIEdkJmHj9+xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255089; c=relaxed/simple;
	bh=JyEkgCBdpZUjjjkWVp0bI4Bqd6VN6w5CZzj1YRXTJH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qj6SGBx4y47LVG5stA9UPdvxy3z75POZI3sACRr1aE3oEhnvfdQiwuiH6oYu3k+Uiu8i+N37n8gGIvQa+shnh/vQGjQrUqS+IrGVcBBRZRdzH6fupgmFUcK1gOMVWdh3H5uDQTOUvaOzBE43CqWUjezfpCrn8KPxkDmuOU4SUGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AWrIlGYm; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYzI6QvBST94/vutapFCk+Oslt8DjWLtp7oQ7puVEU9APVJdx3Sfu5C3VXUTcECknAFoe9UEJKM4RUBo8PeBlKzzM1rHYQ+Cp/xLoMLu1Ac3JaEprIzaFZgZc3npKP5ckFUfeh9CB0rtcPdZjnjIqMXFgpaTMHrk88pZJSBEuMRsFTtH0R8ivEnzrx2G5UQVkKwqtoAYOiR19Lq0eoj3IK+xwOJd7NcwbSF6FR1AdIJkquHX0wwMlYq5Pw2G0lGIsCAHQCXXN4cvuMtVVKm36tFAjluHorPO2bXbanMUn+rhJN33WuupP+zta8TGMX/kte4JOzUV7IvaQbXHvWNgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfG4GKKh+BhO7S5ZbAYHYyk3ue7Sc0gsHGRFslJF99E=;
 b=vZXGklNYqqkAg6446C4LIsnb0e68bpmLv/Jj3diYzge3jKrJpM24NipHEREmzzbxDIN6L7YV4bKYElfGR5TQX7+m3iBf3Guj9dGtoTf0VKl2+faUC2p2hOCsCgBdUWC1gZusU3HBLnC1xIXxFbbydvZKlQomToqpNoMIgPFE35HLIJeumUL819JhVMC/0IB6oIEtlmKXFIVqKmmSOhnWha44lIGMJsP1FhLWHBfO1htLkmheKMOjXm+KkOUAQsRmwHfMMQh6IAKH4MyMXyuwDeA3YFiWcwBhHXv0mxrRCYrUOiPDBKfYltTv6jLLniPZS8TnHoXGOff3bbkRWao8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfG4GKKh+BhO7S5ZbAYHYyk3ue7Sc0gsHGRFslJF99E=;
 b=AWrIlGYmKQb7YO0bicuYK3BC0jWa3lXiCEHv23EmRmHeecO9kY33v5YpF0jHy/lG+QTvUH1VIkWds3AixGBoncZ+qySSszgKocq8Myn/o9u/4oFSMYwPSjHfo06XUVFfxuYyB4CGs95n0TvNVuKVIPUxAUenT7NgUNCdebYBw7XgfRM2D57DHi+tMU2eab5MIumD+KWiDvNlA2P9wddRm+3KnPWN7a95YieU+1YzUUr6EFwRwnr5NCVSChx8i6DheVIrkix9cRa/nvlwH6hUxnKVIdiJbcln4eBkcHUkSDm2bwa45f6KhBfIXxx2aTrURvwf3psASx26BpDoZ/whDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Mon, 12 Jan
 2026 21:58:04 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 21:58:04 +0000
Message-ID: <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
Date: Tue, 13 Jan 2026 08:57:49 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
To: dan.j.williams@intel.com, Yury Norov <ynorov@nvidia.com>,
 Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com, longman@redhat.com,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com, david@kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 yury.norov@gmail.com, linux@rasmusvillemoes.dk, rientjes@google.com,
 shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
 baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev,
 roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
References: <20260108203755.1163107-1-gourry@gourry.net>
 <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
 <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F> <aWUs8Fx2CG07F81e@yury>
 <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::32) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 341b44f6-67f6-4093-133e-08de5225a916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0U0S3lNWm5QTmZLaXlOeFVPZENzS0kwU05sMTlESDZQUE1QZUN0WWNQazJU?=
 =?utf-8?B?OVdHZVk4K0x2UGRQeTZ2SXJTMXJ2Q2lqdHkvM29GRUlpc0tCeFMxK1JycEpq?=
 =?utf-8?B?QUw0TndsSVQrdmgxNXgyTnFTUVNXOGhKcjFBaXBLMUtCTExYbnU1MFV5b0xr?=
 =?utf-8?B?OVpIakRxWWg1OC9NY0hSVVBDK3craFVmdk11Rnp0TzBabFIrYWZIeFNuYlBI?=
 =?utf-8?B?Ujh0aXZhcWxXUWpua0JlR2JsT0plNjNFc085ZVFncHg1ZDBiODBwOG9pQjRx?=
 =?utf-8?B?WFJlZEt4RGRDZnF5d3VucXZ5K1p6a3JEZDZkakQ4WmNzRFlSZUpNc3VHZmlV?=
 =?utf-8?B?ZjNZaVZzU3BSeXd6anZHdlppejV6MDdLVHowU3JNZUJTK1BmSnY1cE9WdGJt?=
 =?utf-8?B?ZHZCZ0hIRkRIU3llV3F0V216K1NRQjQ1azZSdFdlRDZuNFBoMHBLa2o4dnJX?=
 =?utf-8?B?NW92c2hKYmhaaTBYd050VmRPZ0lPZmg0MUFwODBuUVVXcmRLZlpOdkFOQ1hw?=
 =?utf-8?B?L1duU0NuZVhVVVBnVVRYbXdhdTIyVmNoSHFzUGZ1S3VEOGgyWWJnK2ozbFg1?=
 =?utf-8?B?M3lucmcxK1hUOUdxZHFYUEMwRHVndGoyWWkzMEJRRDEwZVk1Z2FWdE1POE9Z?=
 =?utf-8?B?ZGNKeTlHb1YvdnBNNC85RXF1alRTeXBoZ1ZoVUZyVTBzQS9vRDRia1I4WVNH?=
 =?utf-8?B?SHFiSElONDc5aVk1R0JkUTIvWjhKV01KdmthM1ljd2ZQR3F5bFlJSkhYOEF6?=
 =?utf-8?B?bUEzTlFuRkxIY1NYUllzcTU4VnRnbE1oT2tmUUg1NlNDTGVZRFg1bjFSMFFO?=
 =?utf-8?B?c2lEZzdPTU9VN0lTY0dvT0J1cXZzdlpWS29KMDBzNXdZQmVoaEJwanhWckoz?=
 =?utf-8?B?bjVRZ2dreXhGZENwbnJGWVhmWmgxUUs1M1J6UXRqaG1GSVJ5ME9VdmRyN29n?=
 =?utf-8?B?RDV1WXFlK09OaEdFUUpVeHJ5N3BlS3pWSWVHczBKbmxCSnpYYjlVczFBQVVS?=
 =?utf-8?B?SjFoSlI0QnNaL2NKMDJuZ3kxSDZwM1hEVUM2SzRhMlBrV2kxcFBqWE80bG95?=
 =?utf-8?B?WHA1V1VjSk5mdm5FRVgrK2o2SUlwaVQwam8vOW1kTXJ4RUVENGorWUFxRkt6?=
 =?utf-8?B?MUdhR29RV1JRSEtNZ1F2eCtKeW5Oa0dOZnFkNTlzTWVUbmVTSkxoRGFFenpu?=
 =?utf-8?B?V1NtdEFJK1BIRlFkNEJBTEVWK0xTUDByQmFXZmNGOVk3eW9rbEk0NktySEhI?=
 =?utf-8?B?TUVINldReFdac3BLZjVVMXYxWE5XM2s3cCtWZFhuYklZZGtMNWtYaHFXZ3NN?=
 =?utf-8?B?YXUzblI5R2ZQakRlS25yL2JVc0VtL3pSRzQweTRVTml5czE0cXlXOGpOcnBU?=
 =?utf-8?B?Y1c2LzNDNUVVYW1BZDFEbHhHTEFIWXo0QmhaeThnTmZnbFROTXhXLzdybTB0?=
 =?utf-8?B?SFJ2Q3drQmlTU0tWa3QzNFdyY3ZudjJDa0ZPT2JibG9xbWRDSkxXOVhuL0Zs?=
 =?utf-8?B?ZXNJVnBGMHBWc2tnV3hHZjBENVFpajRKK2wyZjVIczJzb1BoY2VHd3AzRVFI?=
 =?utf-8?B?ZG9BNmFpZ1ZSVTZCOWxkZnJqVnNxcTYxQURwU05BZyt3NWYwdHU3N0E1NEho?=
 =?utf-8?B?cU5ncy9IZ25iaFcvKzU3aDI2aXRQdGNxNnhEM2VDcEZoTklWcE1reHlucHM4?=
 =?utf-8?B?NG9iYXR6ODNuc2t3RW9qVEEvaWVBd21qbzJQTXlKV05PVi9NWXA3NDVXblFD?=
 =?utf-8?B?TnpENGxnaUxEQ2hISTMxTEFZRVF0YW9WWmZtc2VpUnhOMVMzNHA0UUU5bW9O?=
 =?utf-8?B?aXRoNjVSVm9OeklHTmNaWEVSc0l1Q09uMXBLZWwybEFJNFo1YlpsR2JiM2xt?=
 =?utf-8?B?b205dGlEM2JBa3dUdVYxSllWUVhYWUd5aVVsUFYycFdmVVlzeFcvSlhlV0JM?=
 =?utf-8?Q?sdewqoOeivt6HVAtFVvRfumGVysyJfD5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGtBM2VPRHcydldzOW9reC93NWVkbGpjRjJmU0J4MmNOZ1NjeUl0SnN3ejdK?=
 =?utf-8?B?SDhhWnlmb09MaHlnaE5leTVXWkdZbTNKaWlqVFFWSkpOOStWWGFvbmFKc3Za?=
 =?utf-8?B?cXlXNFB3WHV0d1k1R3BGR1VkdDdqWXRMMlR6ZmlxUDVwUGxSTGhNV3hON00w?=
 =?utf-8?B?VUhma1lubm1oMGxwRklzR01mOUNPTHlRV0FJTUJEZ0FRWC8vWWpDd2VPUURi?=
 =?utf-8?B?ZlhLbmtOaU9JYkFMVjFlNGZRckZtdXlHZlJjLzJ4SmVnWEk0bk9oOWQxNU9y?=
 =?utf-8?B?Nmk4RTBiTlhZYUdMdXRpV3JDUStBeFpPc1k5bjh2Mng0azRFVFo1dExWbEpq?=
 =?utf-8?B?SFRlU2VNV0tIZ0gxWGNzdmpmVWlqNmllYUFmSC9YMkdETTRtOWEzU25aWGRW?=
 =?utf-8?B?Y0oyQmhOSk1aMlY3ZmJtanArOWNpaHNZNS9ScUQ3d0t1aUd2MDh4aHhuZXNE?=
 =?utf-8?B?cDNVNi80VGxSb1JDdnZ5YWtBTDIxY1EydStacmFWZXQyRUJqSkIraXp2bDZt?=
 =?utf-8?B?SXB5dWU4U3BkM1p0TTNoNmVVejVWTGZPNHAxSzhGUjBzK01NSXozTUFxY0Rx?=
 =?utf-8?B?L1c4MHliOS9jUDM3Y2J4SkRGbVpqVzFmeGhZZXZNUjQvWjNIYmpMYm9UUmtO?=
 =?utf-8?B?b3BPNHVadWQzblRjMVJpdHlvazFDeHlVVlJUVm9EMFlqVkV3WUt3bjRlbXpy?=
 =?utf-8?B?Yk1oOWpDaGNWaVlzS3NZVW9WeXVEM3prY3BNMEVqZ0hMelFweStvWnZtWHl2?=
 =?utf-8?B?RmF2UjRhdFlEa09vbDJUUFhkMkZuUitOYzRSTFkzaW4zRkI1TUFQLzdpS1pn?=
 =?utf-8?B?NnJ5OTBWVkJlY3FLMHpVMEYxZFlwVHNRbWwzMkdBdHNTWkFsejJhRUhkeUZ5?=
 =?utf-8?B?SmRKMHVWL01xdnBVWUNrYnIxYU1Oemx0TW45MGhiYnhZMkdNUTRTUnRKbno1?=
 =?utf-8?B?a3J6ZS9EalY1Tngwbmx2NDIwVEw5ZXF0S05IN2pvQVU2OVhsL205WHpUU1hq?=
 =?utf-8?B?TUdYZG0wYlFRMnRiclNETlhFS1hYcnFQaUplSVR5SmVyS0htbGE0aU9aS05H?=
 =?utf-8?B?Zk9yZnZEeG5JVG53NGVuaFdqRFJsS25xWG9QREhQQzRTcHBKaEFqaldqVTV5?=
 =?utf-8?B?SW5mcFJLUEZtTDFaK0xrc1BpT3J2ZTJ3aDN0dXRPRlp5ZGFmRlhwZ01SV2dV?=
 =?utf-8?B?NlY4ZDFqa0VKelhNeWFHRms0YUxYOGQyNGRDd0JJeWpuOU1SSGN1d2VrN0Ev?=
 =?utf-8?B?dlREckdscGpXNCtKbGd1bUJRMG42Rkdqb0xrUjZDSTl5SHR5bktEZUJXdTBl?=
 =?utf-8?B?SXBMSm95eWlxMExndXdEVWdET3RBa2ZXUXZlc1I0RVNJZENsbkx5VDlseUJt?=
 =?utf-8?B?MjZDM0hQTmhUTzdrQVIwWmVxM1ZoTnZzSWhJRm1vUUVVWkNRTTlFVWtLS1pp?=
 =?utf-8?B?UUpxYzliRDQvR05xczlJazRrL0NKS3pVWFMzV1YxTnZ6R1RpSlpMT2FKaUZG?=
 =?utf-8?B?U0RKcldkUngwTlFzZ3BVaVVwa2Ria0c5OTl0T3ZMSE5XWDFDd241OU9wbFVF?=
 =?utf-8?B?ZVB4bGxhaWVOcmQvdVl4T0NJc0hnaGpzOTVralREc1F1OVFEY0pNb2NpMVRl?=
 =?utf-8?B?MmduZ1VXNkVSd3BUaFI4dlFSYURYMnU3VmlEVU9EOW9obkhiMEs0T1lHTWdD?=
 =?utf-8?B?S091MXNGM05NVGl1SE9pMndZWkNkU2tpZEN4ZllTZjViZ0JEckxTVGgxR3lM?=
 =?utf-8?B?NzBuVVB6Z2NiNnJpVEQyWHdpSEJ0UjJDSDk1dU42bUtsREt5QnJDaENYcnRo?=
 =?utf-8?B?WVhpVnFIS05jQWNNUjk1NlUwSFVvMkRBd0pZSy9MYWhocllISXBQZXNBU0Fh?=
 =?utf-8?B?YnQ1L3JkdnRWemhLTWU4dVF4YzZCTnM0QzNST1NaRWVOKzFqTEhzek5ob09T?=
 =?utf-8?B?Q2NrUDVWd0dGUHhBNDJEZXRLdVI2ajBvektKTnNDU0VUd3NYN2dRQUFhR3Y5?=
 =?utf-8?B?OTM1TDR6dG5hSWxEYkZQV1ZWbEtZcitJdGFEY0MwVTAyRUQyZWpnZGZ1Zk9J?=
 =?utf-8?B?ZzhjL2VWVm9DSGk4MHFsNlFZT3M0dzk4UEVGRTlpNTAzdld0R0g5dk5xMUQz?=
 =?utf-8?B?NUdoaGdOZ0paTGNJTWFNcWVPeEZXMVJZWHVWZ2xJNEJkbWpucTh0bnMzd3U2?=
 =?utf-8?B?TzJHdm8zVnZoQlYxTmpYWHV3akk0cCtPZHJjU3lDaUEvR3ovYmJBSk5KRVM4?=
 =?utf-8?B?aWNxNFd2eHNpUk9jZWZOeldacU9lVjUrZ3V0TVZQT3V2TlVFZC9zOUlKeFlK?=
 =?utf-8?B?a3dFQW9QK1FTRTdQQmtrY1RLcEM5ZzNqSFM2elNuWWRLK0phWlhtMmVPTlRK?=
 =?utf-8?Q?yrnFcr6BSM2YZ5CpSn1eS/INSX8c5cQ+gx3D0ZNB4HPG3?=
X-MS-Exchange-AntiSpam-MessageData-1: YFW7Z+kG5PVv/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341b44f6-67f6-4093-133e-08de5225a916
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:58:03.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODcF5U3rJJPx2EyvS9RoclDTYVDzsbAD1H7dHKdbPAUH1Txnl46LzUTumvUW3s8ufraWdeOH8tnCmiTWEHYCMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457

On 1/13/26 07:24, dan.j.williams@intel.com wrote:
> Yury Norov wrote:
> [..]
>>> Dan Williams convinced me to go with N_PRIVATE, but this is really a
>>> bikeshed topic
>>
>> No it's not. To me (OK, an almost random reader in this discussion),
>> N_PRIVATE is a pretty confusing name. It doesn't answer the question:
>> private what? N_PRIVATE_MEMORY is better in that department, isn't?
>>
>> But taking into account isolcpus, maybe N_ISOLMEM?
>>
>>> - we could call it N_BOBERT until we find consensus.
>>
>> Please give it the right name well describing the scope and purpose of
>> the new restriction policy before moving forward.
> 
> ...this is the definition of a bikeshed discussion, and bikeshed's are
> important for building consensus. The argument for N_PRIVATE is with
> respect to looking at this from the perspective of the other node_states
> that do not have the _MEMORY designation particularly _ONLINE and the
> fact that the other _MEMORY states implied zone implications whereas
> N_PRIVATE can span zones.
> 
> I agree with Gregory the name does not matter as much as the
> documentation explaining what the name means. I am ok if others do not
> sign onto the rationale for why not include _MEMORY, but lets capture
> something that tries to clarify that this is a unique node state that
> can have "all of the above" memory types relative to the existing
> _MEMORY states.
> 

To me, N_ is a common prefix, we do have N_HIGH_MEMORY, N_NORMAL_MEMORY.
N_PRIVATE does not tell me if it's CPU or memory related.

Balbir


