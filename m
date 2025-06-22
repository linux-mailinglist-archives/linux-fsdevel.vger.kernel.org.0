Return-Path: <linux-fsdevel+bounces-52404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD90AE3197
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482CC7A2A4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755A61F560D;
	Sun, 22 Jun 2025 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ans+2pyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933E72625;
	Sun, 22 Jun 2025 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750618954; cv=fail; b=Ri+3OK1WqEDf40akGHIYWCcD7entagAKPO7Cj0/YK/Y6VqETaMpx4+/ZIuYDJUkPAsmPUAJtknm2dpDuYOgkGGtVnElrTjRsAX0EgS4PpVsWws4rgSM5XJdtorYe9urTwADEM4qniyut99Fdw3WSZEMO1DXakKdOK1zF42ynytc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750618954; c=relaxed/simple;
	bh=Qy+e82zKdTOo+UEEzhyZj/Cz5lzmKgwEC98As2+KIlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IgeUBp/CKOtaq4sVP4hNCpWRuyZe6vwNdvKDGLtAtkgw25pf9OGmPSjnBqltVkQK4Fmceawwlzzs0b6G2AaUDOQHcLffv0hYd5xLSTgfcbWCyx81P6kQ+Ry4hTmQQ5C5PiYL3/t/AXiLlJafcYPYUk1VGFqBhHnFwilCCaEq3lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ans+2pyg; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxaTd1VXV1tQh4JN1aLNddnZe7kg1xGRXKrsk4C7RPCojvDd9R7Il41Mx2t8kpfRghbMZql/WvPrNw2sRjm/vgJkZS/+jwccjxRZRVodvk1mJMqAsTr22n4arM6/k1OcVC/GbJNnhaSxV41QPKVgzO5E4JvQ75x0NzUvnG9FZLxFMepfbrTHe0PqJ6deK4UvuOsuopTwc7mpIVXcbbzev+2vEL1R7q2t3+envFNTIvjtFYrwxMeUoI1c6dtdgGafTlwa/HF7UNLV071ehnLPnXy/H7raEIQqgdP7vlaG9LnvCUAmtmM6MAH8jy8ml8bMnqInEeBlUfEGmlEQIJccww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piFz6VUhxmOMQd2w6w7A5HRtw0SnS71S+PPc/KNu7co=;
 b=dbcT0qlhW9rMXB6FUhE+PmwLTbKe3sNQR9N3yb/J0RhxhBwJlTcv0Zh1zdxjXR/6juIRxHHUIvg3xWpdmF3bNxavn2zvDpr1tt0cFgk3SO9ha+PokPFciQMBWSeo5L+PWg+qA4rZi4ZHTAlXYCmOlrkjYsbPnk+9IimC0AIZSOZ/bSbXBUNJp+0KzzHgR9OVkUNQHAysgcUS5r1y3wKDUCqfgPlK89lWgB+ZpdgOVGHrFIOq0wrJh+txCtVWC7T+/vx3dEVTEAbBwxdpQFjTMOj2ov0LjadLC/R51blk88YuHKBfCUZwhEnT+eF87VDMxHeMYwQjONAmwOn7zxPy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piFz6VUhxmOMQd2w6w7A5HRtw0SnS71S+PPc/KNu7co=;
 b=Ans+2pygTty7XKJYVaaR1wS5Fx5FHzyrmesr3BGG0SNv9kvaws6tzpufLL+2JzIQYxEjHNwDRH4JdTsZoM54H+VuwkGvcQ99eOhCr7BoRnl7HHwj3HJjvUkfLN+e1NQOfAECBmmsyf/b6ISRBIIPCv4DGh1Mg2lBtFG1zPXTDWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by DS7PR12MB5838.namprd12.prod.outlook.com
 (2603:10b6:8:79::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Sun, 22 Jun
 2025 19:02:29 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Sun, 22 Jun 2025
 19:02:29 +0000
Message-ID: <d1d7feed-c450-4b88-ab73-a673f4029433@amd.com>
Date: Mon, 23 Jun 2025 00:32:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] filemap: Add __filemap_get_folio_mpol()
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
 ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com,
 amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com,
 ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com,
 pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com,
 suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250618112935.7629-4-shivankg@amd.com>
 <20250620143502.3055777-2-willy@infradead.org>
 <aFWR-2WAQ283SZvg@casper.infradead.org>
 <20250622114322.c6c35800e01e4cc4007a0f89@linux-foundation.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250622114322.c6c35800e01e4cc4007a0f89@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::33) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 989488bc-1f70-400e-8bc4-08ddb1bf5555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTVBS3JJT2E5SEVNV2lMOU5VOHF4Rk56SHZtTWpMaXlxcitzWG1iNFFiUmsw?=
 =?utf-8?B?VU9wU0c1amk0RC8vamtQcTBZeXljdjByYXVwMU1oNmFobkNpeUVPNnJNMFJJ?=
 =?utf-8?B?N3o3QUY2WTVkeCs1NUw0OThldjR2aWJRZ1lzaU9MUkI5Z21VYlJlcG4va2dM?=
 =?utf-8?B?LzFlOHR2Nk9sTWsvR3lLUVJJNE1NcFZad0hQLzhrdEwrcElDR0gwd3kvYWdD?=
 =?utf-8?B?bWxnMmo3UjJ5OEV4V3lwUmszeXhaend1aGgyZEtKRFpPR1o1elhRdlV5OXBv?=
 =?utf-8?B?Ymo2TGhVbkFZUnFyZmpPMzV3bG9NYUxLRlg5SUNBMVVSZllBKzhxM0FHNTZT?=
 =?utf-8?B?aUFHZFNJeFAzQks5WUNDcTAzM0ZTd3VwbFV4T0xTaFc2SVpJTnZKWktkenkr?=
 =?utf-8?B?dk5vWjczLzdZSHl2WGErcFE3UkVDYW9rWWgrN0thV1Q3eGJrSk9yMXl5WHpX?=
 =?utf-8?B?Sy94UkxSZ3JIWGtZOUtFZm9BaDkwbEVUL2tDMitnMGJxdDA0dzZTdUIyc2k1?=
 =?utf-8?B?eGJTTXlEQ2cxeHdnWnBsc2hzWFNlaGcxNVBCREI5NnFnV3dXY0QwZDU3SWhX?=
 =?utf-8?B?TDdWVVNrZklsY1IvdFVHQk1PQVoydUdCMklIWWVkQzlmRklaejM2TmNnRWFz?=
 =?utf-8?B?OEplZjVwenRQd1dTNElvNFRLY01hZzhwNGpRMlFBQWxuSUlVSmM1b3AxamNr?=
 =?utf-8?B?VEV4UnRQY1pRZlRUQy81TWlHYVhHMmhPMVJCUlpQMnZQdHdubDlmUWxVYk9k?=
 =?utf-8?B?TGlnTG82a3pFdHc5Z1paQUUrNmxzZDl5Mzl1dTVHMjh0R0xPWVJZS3AyaU5V?=
 =?utf-8?B?N1hzU1VtMStvVUdYWmpHbHN4byswN2VieGtFU3lMN0tVNFZNSEg0NDExaENL?=
 =?utf-8?B?ODFUVHBIN3B4S0VDUldNMDNybmRkN2N4QnpTV0hac2xMV2VoNW5JbGZTdE5w?=
 =?utf-8?B?T1AvbW9mSnUxR2pkc2JybnZoZlg2YlIvTmk5Z0ZSWDBsY2tGaWtITlBQLzVP?=
 =?utf-8?B?dXdwcDNPeWNzMmd2aUZ4RFB0a0EvcHRrK3RhclVXUXpLdUsrMVhpYUFSblh3?=
 =?utf-8?B?OWs3dlNBR0MzMkdUbWJLV2RjM1Q5YnhOK3JnYWNvWDY4bHE0REpMVy80Tmo3?=
 =?utf-8?B?a1VvRDNLK05QcktpT1djemtHcmFzSVFiZmFBWm5rWmRxSG1uNC9PWm5PM1BQ?=
 =?utf-8?B?ekhvK3JLUXlQOHNpcXFmN3p2a0tKeFBLN2NSbUNUY2xmd3lWNWhHNGEwZm9J?=
 =?utf-8?B?TEFRSi9CUDhKS09FVzBNL0ZiY0pTWmNkdmQ3MzM0VHhZQklGVjQ0VFRFMkJM?=
 =?utf-8?B?T3JMVitEc0lPcW9tcDg4YlZ2UGEvS1V4UWZicnBwR1prTjZ0RkRNOFhpbTNX?=
 =?utf-8?B?WXo0aHNKSUl0U3F0TEkvaEdjT0NtUFM3eFEwTFMzZWNpTlVUWFd5dXBObitw?=
 =?utf-8?B?SDdnZ1N5NEI1SExrajRMR3hhRUpoTDc5b28xL1EwN0dXVm5rVWlQM0hsM2dh?=
 =?utf-8?B?eHJyQVJFc0UzNUdBWkZIOXZCdkMrSk04VFFzdEpLYWpYZ2R6U1lGYjFnWDhv?=
 =?utf-8?B?ZTMvMWdKbmJGL0xUMjV1aVFFb1pXM3NSY1JkdmtwYmtiK2NVcWpja2JJeWpI?=
 =?utf-8?B?YUQxanRNdEFUZmMrUHBvRmtIajlZRlVweFZ3eVl2UDdScU53aXE5NTF5U05v?=
 =?utf-8?B?MitlbitpTGoxSG11QkNJeGV1V0FHRFFiMkFJSkpSazBBOWpDWGFBc1R2cUs1?=
 =?utf-8?B?WVAybnZXbEwwakd2dGdVVmhWaXNUOTJXS0U5OU5jUm1sTUhaaVNJRk5QZ1VL?=
 =?utf-8?B?NThBRWNnUjBqc2crVEg4bnNYWmhRKys0dkczNzRhbnM3ZGRRREtCUjd3QnJN?=
 =?utf-8?B?cU1kVkpiRUQ1ZitJSXUrWFlUa0oxd0I2NUUxUWxhTUVwYkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm5JOGkyM3pUWUJiQ2laM2I4ci9keWNkUFVUcXpkdkoyS0tIWVNpeG9pRWVk?=
 =?utf-8?B?bHdEb25Udi82TklBZGtpV2Q5Ym9TaHJ0SzNCOU8yWlVDeHEzY1drUVk5aXdF?=
 =?utf-8?B?RUx5TkpTbEFQblhqb3F4K2M2ZW1LVzFJajF4OFFENmFkMTBoa2VnU0ZmYkZn?=
 =?utf-8?B?OWc3a3VRdnJHazlqZzlyRzQ3bm9xL1M3aVJpa01vaWpFWmpxM1dTeHdZUGxP?=
 =?utf-8?B?RE56dXFPNC85ZVdZZXE1RzdxWlhPOFRabCtudm5yZStaa2dHNVh4K0lkTWZ2?=
 =?utf-8?B?UXBoM05CckpGd3g1WUppbHNsZGRJL2FaQmdLOUV3VkxnZ0JrM1JXdE5mU0N6?=
 =?utf-8?B?djR0SEtadzRSVUM0TlpWdkJ6QmlEQWlSSmJBU3BqM1lXNjlhcEhIUHpRUENm?=
 =?utf-8?B?eWV2Z1VSbnFCMm1MSXdhR2ViQWY0T1NtYkM0cW84WnhFZTQxems2VFI2Zkpz?=
 =?utf-8?B?SVZkeTN2dnp6ZldqL3VibkVEdkx3d0MxUnVGSkJKa3ZOOVJPQkkwa2FtTVB5?=
 =?utf-8?B?L3h4aTFrY21uNlNuVHJBM29XMWowd3M4WmJZRzlsbkwwWHorVk5QdDMwekRH?=
 =?utf-8?B?SHZKbE9rajdrY0VUQ1p4YVY3OCtndSt6WEFNY1d2Ulk3ZTV6R0NmZU82bVIw?=
 =?utf-8?B?R0piSTRJTWlCRzRJZTFBSkNVbWdzZVlybUV6OGRIMWMzN3hoSVE5em1IUXZD?=
 =?utf-8?B?QzdQSk5kdjM4MTdHSWM1SnBBT0JZV0hwQWFpVDMxWmUrL2lrQ3BBK0xxK05Y?=
 =?utf-8?B?QngvNGZ1T3NTNFlzT01NUVhlZDExUGxyNFluTWZSRUhMczRXQzNrTWlhQTJI?=
 =?utf-8?B?RGZFRmZobFhzcHNSZXN4ZzlRa3I0VEkvQnp1RmFWbmM5VVlaN2ZScHFRc2ZM?=
 =?utf-8?B?MkYrNndkbUNXN3FCN1ZLUEQ4cDg3Q25WejJiVjYvbnVBSHZHRWtSaXRTMnNB?=
 =?utf-8?B?YmdLSW4yOC9zeEt1WE91VVgxWTRTQ2pRdFZNWmRsL2U3QlUrL1llTVNrQlBY?=
 =?utf-8?B?cXJaRnFRSHFvbkYxQXZHdjdWUG1ZWEd2QWg3Y2JtbmVhQ2Z3b3B6Lzlnc3J6?=
 =?utf-8?B?ODVPU3ozeGZYd0pKOG8xeFZnUkEwMjJxSEltNDdaK1kzME5iYjNEZEhrUkxE?=
 =?utf-8?B?OC9ORWZLdVFmRUdyS3VoRE9vcGJtQVQwWmhMUys4cDZIcFdzbGhod201ODZZ?=
 =?utf-8?B?MnYrOXFEZGVxbXhDci94b1RXeGgwdFR0bzRXQUlxeTFRQXMxRTJRYzkyMnRk?=
 =?utf-8?B?STdZbzc0RDBNdGlxZEZGTHhabjEvb1FPVWxDaiszd2RrWU9DT2Z5RFkyLy9u?=
 =?utf-8?B?dzBkSEszdno1SFl2dGpjbDB0VXUzbEx4ZWVlMU9vUCtOTXoyK2F3Z3lBWCtK?=
 =?utf-8?B?b0pEV1FBTzhWV2dDTGdoNlFKL0l4WVM2eXg5cm9zK2lKMnl3cWliYjYwZHRs?=
 =?utf-8?B?Q2MrQnpHTG12ZWcwcE5sMDNhR3pUTHhTRy91R1pwQWEvRlUxSCtCOGNyTVUx?=
 =?utf-8?B?RlhvZkdiSTk5eXFORkN0UythdTBBa0ZwdW5xbTlqd05TNUhRUVlJc3h0UHRu?=
 =?utf-8?B?bzRHb1MzYXlOSzlyZ0FsZzNHdkpMOXpVVVh2NHhEMHFER3pMV3MyT3ROeDNn?=
 =?utf-8?B?bDdxaUFkMTBGbG9UYVdsYStFRVI5MEdLTHNPNmZ1dHJwRWt2STI4dXZ6K2pS?=
 =?utf-8?B?Y3dGYnM1S2d2cHhHUHhzT2dYeUQxTjJDUm5xVi9MOWNUWnRxb1BlYm9hYklX?=
 =?utf-8?B?VVAvd3VYd01zQ051TytlWWRpUTN6WGliWWRKVE9Oa05rRVp1VXVpMWpReDI4?=
 =?utf-8?B?Q2g0cTd0U0JFUWtBSDcxQXFOd3lmNTAraDZseXc5THNyZmUrUERtc1ZXL0ZX?=
 =?utf-8?B?TzFhaVFCRTJHRHVTTGV1cW94bFlmUTBBelowLzhweldlZy9IWWpTL2dlMXdS?=
 =?utf-8?B?UFQ5MlVtNDlJSHlHZmYyOEJoR0dXZHdVa3gyTzRBYkxxWElOWE5iOXZQeWFk?=
 =?utf-8?B?bUQwc1RCcUxsb0hmUXd2TE13YTlzODhlK05Bb2Zyam9raU1hWEZGY1IrOXZa?=
 =?utf-8?B?OEFFdCtmWU90TUx3NXhlWVRwVldGMmhkZkVsWlJPK1RBaE1LaEtjNkVkckFt?=
 =?utf-8?Q?372k/HEMCSKYW/3j5yTIvlQiY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989488bc-1f70-400e-8bc4-08ddb1bf5555
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 19:02:29.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybDEWp8KB4n4OOeQGgccK/ewj3DbuBq4pO9xFFBjuia0T4XWkIAAlBvo4pM15szJGtIqkQfFUAY/W1rDiN/GdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838



On 6/23/2025 12:13 AM, Andrew Morton wrote:
> On Fri, 20 Jun 2025 17:53:15 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
>> On Fri, Jun 20, 2025 at 03:34:47PM +0100, Matthew Wilcox (Oracle) wrote:
>>> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
>>> +		pgoff_t index, fgf_t fgp_flags, gfp_t gfp,
>>> +		struct mempolicy *policy)
>>>  {
>>>  	struct folio *folio;
>>>  
>>> @@ -1982,7 +1984,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>>  			err = -ENOMEM;
>>>  			if (order > min_order)
>>>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>>> -			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
>>> +			folio = filemap_alloc_folio(alloc_gfp, order, policy);
>>>  			if (!folio)
>>>  				continue;
>>
>> This is missing the EXPORT_SYMBOL_GPL() change
> 
> I added this:
> 
> --- a/mm/filemap.c~filemap-add-__filemap_get_folio_mpol-fix
> +++ a/mm/filemap.c
> @@ -2032,7 +2032,7 @@ no_page:
>  		folio_clear_dropbehind(folio);
>  	return folio;
>  }
> -EXPORT_SYMBOL(__filemap_get_folio);
> +EXPORT_SYMBOL(__filemap_get_folio_mpol);
>  
>  static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
>  		xa_mark_t mark)
> _
> 

Hi Andrew,

Thank you for addressing this.

If you don’t mind me asking,
I was curious why we used EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL here.
I had previously received feedback recommending the use of EXPORT_SYMBOL_GPL
to better align with the kernel’s licensing philosophy, which made sense to me.

Thanks,
Shivank

