Return-Path: <linux-fsdevel+bounces-52433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D84CAE3446
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F633B04F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFCC1A072C;
	Mon, 23 Jun 2025 04:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d2M7u88N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8772FB2;
	Mon, 23 Jun 2025 04:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750652355; cv=fail; b=cyXNYrI9sYxNwsRCq6wREcY+mZWRxpe9mg/0Kb5ylhiJTmSBBX83bGJP+lLa3BNmT68PgEBiFlt9aE1azHdk3eTzRGRrDzMHHFwzPyqmoOPLY6gcw5bVYcsQwpGFwDaio8dgsnwZG7xSL/8KKJ+/le7TFyVZkM8h27JD8peEsC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750652355; c=relaxed/simple;
	bh=t/oPb4vw6l3r9nRwmfmx6t0ndvdJpnGypLohb9lttVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IM0UG/mZ7DbNC33JgfPlWvkHYLSw3xu/uNNL9MqGLS9Uz80uZl2yaLby6lfJAog4dl8WMw6SruA22QT+hAJviVwgg6oZvVdhSN/uYjoYFrmlacQorOcaUd95JN4o4lNqfTCy54gF8AsX7Ei7cPmbgx1ysGagmp3jidpHSRR+cCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d2M7u88N; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIoyknlf4gFhwL17fr8R+aI5+jDG+HgJcCD1by22jBXMD/PdqcVJ4wxpx6yo9wJ8Rtdbd7eJUycOVdupc3lDAY1r8mSbWonHMHFDCzI2PoAppowXKKLnv9mnusYugcE88ucAkVTwiJBYSiKfjUhJP0d/OjTCh14VOswvrjf6fzTnJE5CFaMZQMyB8yjNowVlOF0zJHSe4tQ+doyscl3K6MNZr8fWU3uvEPU5XKa4XAlsYNE/Lmw8/0Ka24+ATCzRTYcxA0zjEjgk66rQsC1AvgKZOazlC9bzYbSoMpRsjV6S6+Dc2hf65OG1kVq75bbmP1cw7+DxxLOc4uFgNFZ2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XvF8IK1T4UrMTL5OBIkuMJkgHqTAdf7NplHNZ6kym4=;
 b=yHBiQb9IIREXdf2LAn20PGLu/+oWbTtT3hYGtK5imgOUiB90KWNNu3zegeNW2LNvGmbuo0qXYV3d2mrzlcH1YgRjhH1PqESpX1Lm1ThaMqcjuSpNln6lgClhjZ+vUFh2n0Htl3V/x+h+CB5kZ68uzMkiab5NkF3BgNUh8VyvvAJacWen6KR1E4RjjOkEOVxxAqIpEvUBkWXQw2YBssXxfmM9UhcYfBRbzRjgFJHJPlAOqu4wUPQv9HBHa0MpdcBKfuoMRZsncWedaKAYWe/+XTA8QSw1EA7QGAP435jN7xTWPZHIwIYN/Q/0HE2+k2hdI7/nylr+en9tlFgvPNcmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XvF8IK1T4UrMTL5OBIkuMJkgHqTAdf7NplHNZ6kym4=;
 b=d2M7u88NUdfs82cB1Otj9jl1stjvwiDecp2OQscSkbUY8/xN82wSesbJjBStRrfZ/nr6rG3cFN0w/sx2eD+R5I384L5k+kfOK2jvXoeYObnnvnixRUdOgepDOKRviYGzr+cqpMcfxVo8NVQ5QxRzpwdQMEQGvZVF7I4jivJeyk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by LV2PR12MB5991.namprd12.prod.outlook.com
 (2603:10b6:408:14f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Mon, 23 Jun
 2025 04:19:08 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Mon, 23 Jun 2025
 04:19:08 +0000
Message-ID: <1af44ef0-8651-440c-b3ac-ef22a539b559@amd.com>
Date: Mon, 23 Jun 2025 09:48:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] filemap: Add __filemap_get_folio_mpol()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, seanjc@google.com,
 david@redhat.com, vbabka@suse.cz, shuah@kernel.org, pbonzini@redhat.com,
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
References: <20250618112935.7629-4-shivankg@amd.com>
 <20250620143502.3055777-2-willy@infradead.org>
 <aFWR-2WAQ283SZvg@casper.infradead.org>
 <20250622114322.c6c35800e01e4cc4007a0f89@linux-foundation.org>
 <d1d7feed-c450-4b88-ab73-a673f4029433@amd.com>
 <20250622151625.fb5d23362c2c3d1af22878d2@linux-foundation.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250622151625.fb5d23362c2c3d1af22878d2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 77790a96-f9fd-49d4-1723-08ddb20d1921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0YrL2VFU3VWdHdGSmdGcjRqcFBYOE9oc3loWlpoQ05xWXFaL3lKN3ZhQmd5?=
 =?utf-8?B?ZDBydDdnUk90aDhySzZLZXRLekRVR01GSUE2YXRZNk5FN2U3NEI2c1JXbWtq?=
 =?utf-8?B?YVgzMm5SaGxWNHBkTUZZeXZsaHZDaFdJWUZWRnJ5ZkNpM2lLZUZNUVBCUFRB?=
 =?utf-8?B?ZWRNUkNNNFVhMkF1aXhtb3ZuRkN3TXR6OW5KN2Z5TTEwQ1BPU1VxRTFJdHB2?=
 =?utf-8?B?R2pBSGNNbkhEaE1XQUNBdmxvbklXSS9xQldxbFhJUk9FVk9RQXZEZnpPMWlN?=
 =?utf-8?B?MnRPY213SHIvS2o5TURhWGxFMzlUNFhCcTBxaHVzNFFWSTA3MThIV2IyWEwr?=
 =?utf-8?B?NXpDb05uZWFpcnk5Z0pyQk9MYTZ4amp2d1F1amc3dDNKcmxjY3RydzVqTjln?=
 =?utf-8?B?UkttUjRKVUtHMUU1cHdCWDMvMHMvZDA4Y1RhVzFNMERqMHZWUC9PZ1RxamQv?=
 =?utf-8?B?Qy9pMTdyNElLbDVhWjVWbldiNlNydzJDS3Z6LzRmU1puL3VYUXdRTEZKdWhN?=
 =?utf-8?B?NkxMM1JudVNPNVIyMXQ3aG9vRDYyYnVNWEQrU0FXRitYZVBRMDdlWmc3YTUz?=
 =?utf-8?B?cnJFRERGbWpSbVk1a29WVjErQTVxbGtxWVZKUEZuNERycGZ3MWlRNEZPWGc2?=
 =?utf-8?B?V1I0dHhRRlNOOXR1QUVrYTRyYXlQQ2EzU3BzSDhpRUV2anM1LzlOaFB3ZlBO?=
 =?utf-8?B?SWFCYkd3dXo2MUZkc3l5WVkxVG96N0VjdkNlRW1rbVRLZFJxRVJic2xvVFdD?=
 =?utf-8?B?eWhBUlJpMjcvWTg1UVFFVEkyUC9HOEJ1ZzZoRVlTV3Bab2FKMFZKODdrd2JM?=
 =?utf-8?B?NVhWQ2NNd0IrOU1JUnFURmpVNkRIZjJscEtBM2NwRkYrUHpoNldVb2ZFWEdH?=
 =?utf-8?B?WTVFYmpFWUFEYVY1aE5Sd2RZMnBxbDFabjFUMmRpOGwySzM2UDhoUTZiMHBW?=
 =?utf-8?B?SjFHK2x3UUw5NzNRK3BCSFE5Qzk5QjRFa1NtNVlZWUNWWGdEVzVpV2wxbnJW?=
 =?utf-8?B?YmlXTUl0czF0OVNFdXVOTkZNZVNqNnFVNWp6aWtQTnI4T3hCWnRxMkkzWXpk?=
 =?utf-8?B?NWcyYUw0WWV3azhMS1hHS094eXNPVERJZTFib1BsUWppRFd0V2plMVQ3dWg3?=
 =?utf-8?B?TDIyMEt4dEtCMURTSWJNY2UrTHZ6T1JLZkw2Q0RJSDgxNUw4ZHI5ZXFmb245?=
 =?utf-8?B?R0pOWGtKYnhqeVJOaDhIOEdveUY1Yld2UHRDS3JWSFU1Q0R0VllSM1RKUGVB?=
 =?utf-8?B?MzUwbmlPMnkvVGxJNHBhQi9BQm9nM1lVMHR3MTNTbWhCZFdzS0FTN0FuWHFJ?=
 =?utf-8?B?a2c0VUppQ2U2UzNBcnVobm91bjVRbklLeHhPdGJUWlUyc29LRHJuMWxPZ290?=
 =?utf-8?B?NFlYNUNENWJ3NURMRVdqM0RWSk5NM000UTRUZUxGS2VuZnFwWGdDWlBnTDF6?=
 =?utf-8?B?akxLOUdPYXRLekRNbmhvMmlMRVRhdXJFcW56bzZiZ1QxVG40bW5zV2krS3FI?=
 =?utf-8?B?Nm1DM3NMTGYvZWtwaDN5Zjh2NmcxamQ4ekpmeXRhRURwUFdLZU5aSzVDb3pw?=
 =?utf-8?B?Y0lBdGdHbkVLemsva3UySE1uTkFjZWE3QXIyNnk3b0RmTVFRcjZ1ZTBxZWpB?=
 =?utf-8?B?RkRFdmdLZUwrSXJZTzBrekpIc2ZVUzE0K1JjaHptMDc4NHl4TXlwWXJkY050?=
 =?utf-8?B?aUVpWnFiRHZXQTIxRTdzMUpFSWd1U051MGh4RXYybGl1NmdtRVQ4eGxPVGNa?=
 =?utf-8?B?enpWbkhwRWVEUGtkZG9rSG9haXBodHhnSXRqeWI1ZGpaS1B3RmlOQ1ZPaC9B?=
 =?utf-8?B?OGNtdG4zSHZBbzlyd3diQ2Nzc1A0cldtN1YzZG5GRjFVMVlnOHN4RFJUVmZw?=
 =?utf-8?B?aTBxb053dy9mY3MyYXhBWFM1M2JwK2NyMjJtQVh2aFJxRFNJOVRsVk8xYlNT?=
 =?utf-8?Q?JaeVxGmDqiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXlwZ2VNMnV4RmFHZEFyTEwxcDROeUZVcnFHZnJLRU44WXMxQkxlWHBWMDJp?=
 =?utf-8?B?bDdyWDVKeWJtQWY4RkkvbU5KMm1LUUNTbmVnMzV3Q3EvbFRucW9sZnZLWFp4?=
 =?utf-8?B?VXBqSUR3SXoxbDhpdk5ERjBBRGw5NWVOMlIyaUJPNHNRWjU2akJjR3htc1N5?=
 =?utf-8?B?Ym50Q2pyT2ZsWE80QlpLYmhya2xzNk9JL2FjWVN5V3BieHpXZWF1djAwVm9E?=
 =?utf-8?B?d1BDemhpWnZzT0xaeDRzaFAzT2tqRS92WFkrSXVJODVkUUVMTzRUSWZ6bGN1?=
 =?utf-8?B?c2d3VjY0SC8zNmQvSmNkdUFwSjhsU0FLdjhMSGY5c2RiMUptNk5xTnJKWmZB?=
 =?utf-8?B?M0oxTHA1WnhDTnMrbmxYV2Z3SUR0c0orNU5QMEFwYjhNSWhvbk5HcTRSV25l?=
 =?utf-8?B?bHc1UC81Tm5RcFk2Vm9BSTVLTWxxa3A3OVZ1UVAySWZUYUFleDJqSUM1eTVa?=
 =?utf-8?B?Q0dHN3pWay9ySURMR2JvRExqNE9hZkFXVWxVbFcyc05qNlBqOGRVYmppSXE4?=
 =?utf-8?B?aGgzV3pZNndpaXc1bk8vdm52djBCbWlocnhmS1EySGZZbWRnNVRkLzlpc0pM?=
 =?utf-8?B?ckk3UURJdXVVWWtaYW85Q2drdFJZUzdJRm1YVHVZeVU0RzdvcS9mK243R1kr?=
 =?utf-8?B?L21jVC9nODRjZFZGdC9paHliODVwMTB5bUFhVWVEdFdzL2NGS2ZFdVpkZVQ0?=
 =?utf-8?B?ejR0c2FiN0tXWmJXbXRkRHNhbWVvaSttdC9mdHg2eE1GM3lvbzVMMHRGV0xk?=
 =?utf-8?B?NjVqZlRxay9OaTRnbFlCd2lYbW41RnVuYVZ6MnBPcUlzWWdHZUkxcDFvL2M4?=
 =?utf-8?B?dW03Z0RYM2R5RVJBQXZsakJPQU5TT2JXa3Q1OTZNTVUzVDFYVjA2UjZvZmwx?=
 =?utf-8?B?ME41NHZFVEEzc05DWDVhd0JTOXJ3eG5rRGwrR0xCYng0eHByVUNPRVBzOFdI?=
 =?utf-8?B?NzN3UmUxOEtYbVF5ZGRkOGVnM3puN2Y2MEM0RXAyUnZDemdpcHhRdDh1VitE?=
 =?utf-8?B?cHNsWTNOSXRydFJYMlZtY3Q3V0FBaUx1NlJWeGVpSDJybGJoTDRxTnBmaEtw?=
 =?utf-8?B?TzNJTG5LbFFMeXlEK2VqS3h1cEYvTnhKc0pJcmtvNFcvd0hGdUJhM3VyUDZh?=
 =?utf-8?B?TWFDNWtEOVlwdlNMLzhrOEZubWJTTnhFQ1VhR1VINmFidE4ra3N6cDdsRnFy?=
 =?utf-8?B?NFJ6aDVSM1U3N0tsUFJVQmFkaFpDaGdPY1RoRDc5ZERFUkFtTk04TXZHekti?=
 =?utf-8?B?VCtZMXhrR2VqeTNENjVwSFVOeG1KMnRIVG1LdElzOFRMc240Rmp6cGJRYmox?=
 =?utf-8?B?VitKZktoNnZibHpodlhSWm8zYXZNNHY1OUMzU2ZmcGlnSEt3c2ZMS2RiWGZL?=
 =?utf-8?B?VnpraUU4SnlXS0ZlT1dFYis3VmxWTURWRkxvcm82T1F2dXp2V05WaEpaQjQ0?=
 =?utf-8?B?ZER6Z1UxWXRMQVprMTFINStFb3lzaU5sa2RPQWVuY3FSZ0VCMk45SEZCV0tX?=
 =?utf-8?B?VnJpUmNMM2RaUmk3dTFyK1VVaFZLbGNGU2VsSFRtTmpOQVFXVjFPQVB6RkI2?=
 =?utf-8?B?LzVvOGdJU2I1Uk1md1pZTUkxUXZJbk5FcW9POHI5ZTMrS3V1ZlFXU21DblFQ?=
 =?utf-8?B?em1vMTNoOFNIMjEyMC9EaWkrbHlCcWptTEdBTEdEdzdldFV0SnVIekxxUU9D?=
 =?utf-8?B?aVd3TjFtdEIxbnREVVJvM3dtT3R1WXYrdnYzSURxazRHK0kyMitRT0FtQkdX?=
 =?utf-8?B?SFY5amoxekVNTGxvQUljMVF5VzQ4dFMvU01VeGFLdDNBVjFxckZIVEFnVmNu?=
 =?utf-8?B?Yko4VEdJa0dva0gxcDFCU1FjUC9KUnJPUlFTaCtpM093dGg3UFZ5RDJpaTdQ?=
 =?utf-8?B?c3VwL3lpZTlsOUl2UGc4WS83dEdPUWViQ1dxVXNoT3UxRVlTWEFEeU56alg4?=
 =?utf-8?B?bTE2UUw0NW9DUEQ4dW51L1FmS3ZpaFFLWUpCT3dBNEZXZE8wc1RXY2tLYUtw?=
 =?utf-8?B?ZzNQeC9JcGNRdGhMdEs5cnhPRzBidFlRNU5aKzN2akswY0srZU9yRTBMSUhL?=
 =?utf-8?B?VWg1b1RaSFl3ei8zOWdJazcrb1NCR1RUcmpqSytVaVVqNW5jc0RLR3IxYVRp?=
 =?utf-8?Q?nNGBEeokhURL6mktpjKLBupIJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77790a96-f9fd-49d4-1723-08ddb20d1921
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 04:19:08.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+9icrSPbSQwcu0W7oEev/tolXzjLTa1tXQpo4AEN1Yh7DkXRKGrISv1/EkVnIg988HNq3pVsymZW9AOfbKxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991



On 6/23/2025 3:46 AM, Andrew Morton wrote:
> On Mon, 23 Jun 2025 00:32:05 +0530 Shivank Garg <shivankg@amd.com> wrote:
> 
>>> -EXPORT_SYMBOL(__filemap_get_folio);
>>> +EXPORT_SYMBOL(__filemap_get_folio_mpol);
>>>  
>>>  static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
>>>  		xa_mark_t mark)
>>> _
>>>
>>
>> Hi Andrew,
>>
>> Thank you for addressing this.
>>
>> If you don’t mind me asking,
>> I was curious why we used EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL here.
>> I had previously received feedback recommending the use of EXPORT_SYMBOL_GPL
>> to better align with the kernel’s licensing philosophy, which made sense to me.
> 
> Making this _GPL would effectively switch __filemap_get_folio() from
> non-GPL to GPL.  Leaving it at non-GPL is less disruptive and Matthew's
> patch did not have the intention of changing licensing.
> 
> Also,
> 
> hp2:/usr/src/25> grep "EXPORT_SYMBOL(" mm/filemap.c|wc -l
> 48
> hp2:/usr/src/25> grep "EXPORT_SYMBOL_GPL(" mm/filemap.c|wc -l 
> 9
> 
> 

Thank you for the explanation.
This makes sense to me.

Reviewed-by: Shivank Garg <shivankg@amd.com>


Thanks,
Shivank

