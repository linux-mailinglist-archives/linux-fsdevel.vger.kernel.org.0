Return-Path: <linux-fsdevel+bounces-60644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82751B4A8A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1044E3510
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068F82C17B3;
	Tue,  9 Sep 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="L7JcI5Xj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5802C3277
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411027; cv=fail; b=DJbCZYhc3LYWhl8uDAG27qJHCHx0T3+7j995kTDAh5FQA6dwaAY5QyQVbBh6QHz6QRrZDCAnOgBh8sGLuxcN21ADntIyznuoz9ziPvZThoTApm5+tkg1b3vQdNM1MaCH1//aC+Jd4QdoTRJnDLxWiUqfHWAGjLsHnuwPOpzp4nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411027; c=relaxed/simple;
	bh=xesEH1MG89JtHH3kQ2dW2KR9hFOAq1bEG7rynRirouA=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=BFOun98n4Wcm0MMuUt+8EyuU9IGmx/DYNEGwL2wxhg0RLNWqF8Rqkh/HnEXPKl0iSJQJ06DJERlPoEhiBMUfejkNiUzXbenLXCxELrcOAds2jp7XmF3T1GHU0LYW2aH+n5x4Ghd0ngiEKbOb6J2T2pAXQDkniTnsMDUxewDBTjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=L7JcI5Xj; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2116.outbound.protection.outlook.com [40.107.102.116]) by mx-outbound-ea9-35.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 09 Sep 2025 09:43:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAbXzA9a5GLZpeuqKQKjsOLy4QtP7LtpJ8pw0OJHXxxSN7o12f2wD8exMRs0EamtnnoELrAmWfq6vTBZ4NHS4o/6VpbKLSkN703zh7maEl+LX5E8iFBCMUQ3Y4YQJqpIteZCOhr6Tv2FHCwsK2HX9ticGDyrhAu/qYgS9JiF8kdx0bfCGr7VmTPPZXzAiJIPuD0IgRCPei9RrwRqyOfroRFwVuNbwhX6GXiDFMhsrkYkHAmRBphGdxz2W6bQU1Q0SoJ9PsMSzxJ3hBlTDitPRKPSaYDWL/LviSo3UeZdjPWOWROYadDDxtylnBw0lsBrgrHv0L9BQh7cxtlrFGR72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPZbDvFVzrPxJuDoiDW7O0IURxB5soUjkEw1qqpXQz4=;
 b=AG3eFoto3LAJylHv+eMtKc/gNt9DG2cQv+tro5U5KMDZN0P772wMllM2OFW7Uyod6nb31cERhewCDGgVb310Y93PyEWfSxFd2Io9MMHhRq3LFbXfmb/WLwQ8efKHO2exF0Zt7IBm+1Ss+PDGX5O9qjFfAdo3WxZBG5KSeGPqyNS+pKDo0enZSBu63fs7iVFSqL5+HFtVjwOhEdi4cAcW57P6KjyNnoMgi0DKN8qJWQYJQRiQNA1ttPQFwRkBFqbHkOrAcaUR3smYHh6KV01/VH/oHco575FS7NAx5pCFf0VnGTd/ANJV4/L/5Mk+lb6R/l+WG6ucAYlKpXGLODQg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPZbDvFVzrPxJuDoiDW7O0IURxB5soUjkEw1qqpXQz4=;
 b=L7JcI5XjPccQIjJsSe9Ryg6Ab+SDxPit5co6Kq9HvdBIA2Ps2Jr2/6P7ur9UGVBH5rBseKgYChIU9hCVn5SHmuvqGN6+fAC2zFrCOwMAJSmPZsiHZjzrOqg8XNyX6+0FugEpMI0Hsrn/OVqj4XfWdyFghv5jNjxTVo8n0oPRHw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SN7PR19MB7019.namprd19.prod.outlook.com (2603:10b6:806:2aa::13)
 by MW4PR19MB7006.namprd19.prod.outlook.com (2603:10b6:303:225::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 9 Sep
 2025 09:09:12 +0000
Received: from SN7PR19MB7019.namprd19.prod.outlook.com
 ([fe80::26a8:a7c5:72e9:43dd]) by SN7PR19MB7019.namprd19.prod.outlook.com
 ([fe80::26a8:a7c5:72e9:43dd%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 09:09:12 +0000
Message-ID: <4a599306-5ef1-4531-b733-4984d09b97a1@ddn.com>
Date: Tue, 9 Sep 2025 17:09:07 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
From: Jian Huang Li <ali@ddn.com>
Subject: [PATCH] fs/fuse: fix potential memory leak from fuse_uring_cancel
Cc: mszeredi@redhat.com, bschubert@ddn.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::13) To SN7PR19MB7019.namprd19.prod.outlook.com
 (2603:10b6:806:2aa::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB7019:EE_|MW4PR19MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: aa440a46-9f63-4b0b-0787-08ddef808b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|19092799006|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVpPOWF1UldYWXAyb0pNdjMrTUFTWWM2SE5aVU9GRXFiNDJEVHREcVZFa3Ir?=
 =?utf-8?B?TVJ0K2h0eEdJbjBpcEVvMFNsRFh5cmpYaEtOd2tOTTZPT2RiM1hzc2cwV0l6?=
 =?utf-8?B?Z0pDUXdjRHJBVXlrN2tkS3l0QjM0cWNHcDA4NnRzc290TWNsa0huVGVsLzZH?=
 =?utf-8?B?dWN4YlZhbFE1UDUwQUpZY1U4RVZOd2NxUjMwSkVqc3dZWHA3cy9zWFUyLzB5?=
 =?utf-8?B?RlM0am55OVpDQ2lPdUZuaEFxWDg4bmxuNE5EVHNUSHdqcFlFVVM0ZjQ4MU00?=
 =?utf-8?B?Ums4WTVOSFVaZ09OR0hTSjh2a3huaHNQUjFVRDk3WC90RlRiRTZ5R3RDWFgz?=
 =?utf-8?B?RnNSdWMrazc4MUNNclFWVHRpWG1SVGlMNWZNWWU4RjdRdCtobFF0NFlOaFc5?=
 =?utf-8?B?VGE1VXBwbVNVL0p2WVN2dm1Ea0d6Znd0dTJtdHlDMjRKR2hacHNmR2FFV1pR?=
 =?utf-8?B?UllrRjlMUVBLOXhWbHBSS244LzR3NnZPclNDNHBmSDFsTzV2ZHVLelJkZWlk?=
 =?utf-8?B?WEpQdGRmcHI1NjZaSEFxOWZKbExJYnArM2pDT0JTZDlJNGdlSGtMMzhnazZu?=
 =?utf-8?B?MDRLeElqS2NKN0E4RkFGMlBqTktmcTk0aFMxQTJWSTJiUWJZci9XOTI1L2Qw?=
 =?utf-8?B?T1hjQWt6cWhoMWEyZ3haOXNPRk01bkhRWFY0Sytsc0t5N3ZjU0paWmFqZ0w0?=
 =?utf-8?B?OXdDMTNaMjdGanBYbStrMTZpOW1iWURYZ2cxZEpodWVDcVBaeHlMcnNzSWZH?=
 =?utf-8?B?Y3dzMVhpeWJIRUZnb3V2TnBqN2ZNYXZFd25JdTVkcG4vWnhPVll0RmVnNkhw?=
 =?utf-8?B?RDBJTVZ0UXVQZlc0elpUc1VrZi9TSXlYMTI0YkQ3UDhveWhnY3RTZzlwbkZC?=
 =?utf-8?B?SVJsQ3cvbGtRNWhMa1EzZlVTdzlHbk9salpiSnNxZVE4dGozbkpsbU53b21E?=
 =?utf-8?B?VVJ3R1FQNGVreGVaeFBsV0xzZm9NdXV6Um02WCt4WEFEendObzRCSUh0bW1I?=
 =?utf-8?B?SHkvcFh5Y2JqVlNQYTZuVHJMOGdLb1k0SWRYSTVEa1dXQlBiWUFNYnIwWXJK?=
 =?utf-8?B?U00wZWlJSGJvTFRmYTdtalQwb1lURE5QUVlucEhQTkhRUzd2bWI3RCtBV29z?=
 =?utf-8?B?dFZXR0k4SXg0MzRiWnlBN09vMEJtSzRqVnNaVHRCNEd3ZGlFb2l3WjgrZDlk?=
 =?utf-8?B?YTdhbUpIRXBqSHFGbS9YU1Q0Y3NKeFdFNm9yYVk5K3kvczdhWUZUVWs0alM2?=
 =?utf-8?B?M2E5R2dSbHBtdkxXOXE3cWV1Uk1LSURPOUltUFMrMzQzdDdESFZmSHNXQSt6?=
 =?utf-8?B?ZGhPRWpWWTVoTmlDTWVaR0lrbXZsaEpabjBoeGM0d3hUaWlVZEhLRFh5ZU0x?=
 =?utf-8?B?VVVTM1JXYlJlK1N6YXZBSlI3OVo3V2ZzTnhkTGM5cTJXZ2M4MWd6cE5vNDh0?=
 =?utf-8?B?VEMvQUJHK3NkemV2dWN0aWRoOGRXTlM5U1N4Y0dXQndySDl1NVNYWEczbUt4?=
 =?utf-8?B?dDJJSmV0OWJIVW5jVFFMNk9WYmRMVndmUW14UDJZVkNidEtFdDlBR2FhRVBj?=
 =?utf-8?B?UVhrVDl0TGlQclJDRk90R0RJMnNWcmFEV3RUK2dWKzNYODhNejhvc2wzelNx?=
 =?utf-8?B?akpYR2QwMDhCT29uTVpYRWVwKzNBZ3VwYXR0WWl0b1NGNlVXSGtxY01Tb3Rh?=
 =?utf-8?B?RVJBRFpzd0NaYTFkbzlGWFlpazdFUE9FSTZwTUllUFJhdXR6dDhaOWpORlJV?=
 =?utf-8?B?RittYWtGUkFlMUNJQnYyMUVFSzhjUnlzeHFKM3VVbzVFT0RNRzhhVlA4TUtL?=
 =?utf-8?B?ZW8wQ1o3c2J5NjFnWW12V2lvbnZ1R29SYndnU1QvWUlZVFFlWHBJY1hCdUNR?=
 =?utf-8?B?Q3F5aEVMQXkwSHYrZ2QzeWJuRjhiVUpxM2hncWVRVXZ2VFhMbWsxMWU5M21h?=
 =?utf-8?Q?5Y07xe42fmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR19MB7019.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzJ1TUh1YURQQVFGczBnR0dXMUtTOG1SZXJmUWFZK2FtV1QwdjkzeWJwbUtp?=
 =?utf-8?B?UjRGUDdJZ0lhNkRWN3VMZ2dsR1ppTnZoQTNnQ0RDWEVlQTB6cnpVd0N2TVlN?=
 =?utf-8?B?T0hRd0kzdUx2eFJwSTlyQndzVld2V3psZkhrdUpHYWdYaXBnOUtHWU01TXRi?=
 =?utf-8?B?KzVUR1ZSMlFmdURtb0sxSiswdWVqUDhONzR5QzVCTmlBQ0M1aEtjSGNXeHFJ?=
 =?utf-8?B?c3NXcnh4blowZGpyMGpHaFY1RnlBbG9OQTI4MHg1bHFuekQ4M3F5a21uV3dz?=
 =?utf-8?B?cktJSWJtWndIQThvMm1jaDdhK2wrd1phaS9ZRmNJMEQ0NmpnSFd2emYxdVlJ?=
 =?utf-8?B?V29xb2hmNnFiWFpuMWhZTy9YWi9Id2Q4bTFqL1hQK0NmRktPWnlJQ21ZQURP?=
 =?utf-8?B?NFF0VlQ4S0YyNkdham45eUgyR09XS25McGJHT1ZaL2dJYU9JOEtRWW9ZL2Nr?=
 =?utf-8?B?MVdiWWV1L3VUV1o1S0M3TEwyRjQvN1lHaTBlNHBrVHBVY3RKQnY0RVVtSk84?=
 =?utf-8?B?emJvR0hmSVBrVkkxelFNclloK1Q0a1lKaDBSYk1vVWp1RmIwVVBMR3RaSU4x?=
 =?utf-8?B?TkZKd0hOUmdmbVRPK25OUDhDUWhVendPK2p2aUQzV3BtZ0hLRnFYMVdJQytN?=
 =?utf-8?B?T1lWS1lvVWtTeFUyTWZyVzVqanJSSGhDc1psYnJyZ2l3UkdDVE9OdXhBMVFG?=
 =?utf-8?B?ZERxT1p1OXN1NUdHK2J6OFlDcjVwNDhPRUZsT2lGYUdlRkduNENrTk1Ydlow?=
 =?utf-8?B?N01QSk85VWFoMjZYZlRRVGp3SGVqbURFcHRTVVdXeG1WRStIcHBUYjZYZ3gx?=
 =?utf-8?B?TXR4aUZkZnRXK3lyRW8xdEMwQ1ZGMDJiVE4vd0cwUlVKZUVPYkt0VU83czRN?=
 =?utf-8?B?Q21RNDVnV0hybFhCaW1NOUJhSlNib2Rxb2JSM1k2NGh6aTJRSkxXeGVOazJN?=
 =?utf-8?B?L1JER0NBU3Y3cEdZcGRCSXlKVjRWazJEZC9MRmJHTlM1OVpkZUp2MTJuWS9p?=
 =?utf-8?B?Q1J0RmxXZlZ3ZXF1em1xSVRvODY2VllyZU9qZ0N5ZWJRdFd2MnBmOHF3SGdi?=
 =?utf-8?B?R0M3bXkyMEplc2w1OUgramR3cCs4OEwzV1hGK2RSU0J0TE9QdTJlSE5ZNUVC?=
 =?utf-8?B?Y2s0cHM0MmZSTllUYnkrcGd3N1JYVG1NK0dnUjdYNndnQzVBSThMWGN1NFN6?=
 =?utf-8?B?anAyQVZqN0hQQWRoZXlHRjQ5ZmpaeTFRdFYwMHh1VWxyNTVzcjljT0lJaXBC?=
 =?utf-8?B?MnJxRHNUdCtUOVp4VCtwSStvQU1jbExJVDI0NkxuNnhPTURBUVQ5OHNTVzAy?=
 =?utf-8?B?ZCtzYU1EajhmaTY4TWk2dVpqaFZFaDY5T2VqWjFVaW90OWVGUmJRUHZ3SG9m?=
 =?utf-8?B?cldGNTR2VHd5WHpwUmthWnR4dmJ3ekxVRHRFaEg2TDg3N05ZMDlrVExXZFNs?=
 =?utf-8?B?b0hpNWlzWDg4T2N0L1RCMElFRG16YzAwNUltS3pVVTlRaDk1TG5BakJCSFZs?=
 =?utf-8?B?K0JXQ1AwcW5VQmNJOGgzeXV3bWE3VjU5TTN6ZTNpUlFMNkFPODRlaWQrcmhH?=
 =?utf-8?B?RGFTbXgwRU40OGVJQVY1RkJ3c1RDTCtkU0crbUVUY0dKVlQybDRLdTR5Tmd3?=
 =?utf-8?B?dC9ZVWdGaFE1aU5jdk1aV3FmY1RoZkVXSlIrVnZmZmlVVXBNZlh4Z29GK0xW?=
 =?utf-8?B?emhOZUduUTVBa0g1R1g0OUl1L2swTWtlL2xtNU9rZUJkUGpnZmF5djdiVVA3?=
 =?utf-8?B?UFVQRE1XUnBBYURLRmVYbjlSV3o3TjFHS0RWQ3BRYW5EQTgzbVpwemptZHBp?=
 =?utf-8?B?RzlXbEtDd2R5RWR1Q1BIQWxNb1pvNktpajZyTTZZSnVCcThEdGtCdGMrMFNa?=
 =?utf-8?B?UEJ3eDArMWVLM2dsYVI4VlBZOTNMWE5lbHhCZGpSb3N0bmo2T2NsOUJZUWd5?=
 =?utf-8?B?cWs4RFN4bVVyT3FDajliOURJc0JQKy9oRW0zWGF0UHhveXQwN0JYck80ajMx?=
 =?utf-8?B?RUZlOHBuYlhVSzdzRC9icEJjRHBrUmg5RVdxZkI1R3IzWG0yZlgvVzNJRGlp?=
 =?utf-8?B?L0JjakNocXdxWkJJaHpJSXN6eDh5cjZZV1EyQ0JXWC9QREUvYW1sb3pLMGZU?=
 =?utf-8?Q?1rXM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7BITTZHlRiMkKFl5s9yew42ikPSVyZ2+LmPoKOmKRanPnCPZThXwH3+9pXC4geCxqWrrVCUnLEyk1s2hH4N1QpS4IhAE9TALPK1jD5yVlLOEjAFbsGy3ioBmUl3/D6zOU/d0wRpJGfSmJFf4EFtGGkBQ0scdzGzR/LlPeW0SDes+ocodrzcvFtedVIovbAAg/QvOlAfS1fRC9Gr+aD6oWNJfo+N1i34ZdmddfpL5kv28vOPbTRH+HSvRqGc1m1r/F80k9OBYvJ7/586y//Mq2zQ19zhGXhPcZppKZys0LMyEcu/LceT9+TP4z24ux1H/LMAvbPGbTqS3uc7r67hq2rCOnMEvik6waCYfJgj2c/YiHJcvLJokvE5h2wIjToB9F4SMaVO057b+fb7MIaz+PzYha7KyeNRsqCJki0gOw7JgSidNvKOJ1hfnaruiHv87YdVWfJgBgvBd7rOW3kXFtVP6nT+HgdOkzNDv4zU7DcpY5915Xs/Rah3F1tGYOf4CjaCGriktBEr9m2KM4XECkLMODUnsSDqLD7ylDaXXdo/1RHBwiqPn0j6M8kNBhTP3kq+5FRtUSSKzDy4gZgAIydRpTp3XCn1qvXeA0gxMEVhf6WBqojEbUL9LF4owk+X0MmN5L5qv8ymQM+3HJTdhyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa440a46-9f63-4b0b-0787-08ddef808b1b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB7019.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 09:09:12.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbOxlvjaPVhvYSf3mEyIqkzDne58pmzdFKQDV+ZkM1x/8Br3rEPij/Ph+9W4hcp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB7006
X-OriginatorOrg: ddn.com
X-BESS-ID: 1757411023-102339-21187-2810-1
X-BESS-VER: 2019.3_20250904.2311
X-BESS-Apparent-Source-IP: 40.107.102.116
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYGBkZAVgZQ0CLR3CjZ3MTY0M
	w0NTXNwiQl2djI2MLUMC3RNMnIOC1NqTYWAJTyp6hBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267355 [from 
	cloudscan12-34.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

fuse: fix potential memory leak from fuse_uring_cancel

If umount or fuse daemon quits at early stage, could happen all ring queues
have already stopped and later some FUSE_IO_URING_CMD_REGISTER commands get
canceled, that leaves ring entities in ent_in_userspace list and will not
be freed by fuse_uring_destruct.
Move such ring entities to ent_canceled list and ensure fuse_uring_destruct
frees these ring entities.

Fixes: b6236c8407cb ("fuse: {io-uring} Prevent mount point hang on 
fuse-server termination")
Signed-off-by: Jian Huang Li <ali@ddn.com>
---
  fs/fuse/dev_uring.c   | 13 +++++++++++--
  fs/fuse/dev_uring_i.h |  6 ++++++
  2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1..db35797853c1 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -203,6 +203,12 @@ void fuse_uring_destruct(struct fuse_conn *fc)
  		WARN_ON(!list_empty(&queue->ent_commit_queue));
  		WARN_ON(!list_empty(&queue->ent_in_userspace));

+		list_for_each_entry_safe(ent, next, &queue->ent_canceled,
+					 list) {
+			list_del_init(&ent->list);
+			kfree(ent);
+		}
+
  		list_for_each_entry_safe(ent, next, &queue->ent_released,
  					 list) {
  			list_del_init(&ent->list);
@@ -291,6 +297,7 @@ static struct fuse_ring_queue 
*fuse_uring_create_queue(struct fuse_ring *ring,
  	INIT_LIST_HEAD(&queue->ent_in_userspace);
  	INIT_LIST_HEAD(&queue->fuse_req_queue);
  	INIT_LIST_HEAD(&queue->fuse_req_bg_queue);
+	INIT_LIST_HEAD(&queue->ent_canceled);
  	INIT_LIST_HEAD(&queue->ent_released);

  	queue->fpq.processing = pq;
@@ -391,6 +398,8 @@ static void fuse_uring_teardown_entries(struct 
fuse_ring_queue *queue)
  {
  	fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
  				     FRRS_USERSPACE);
+	fuse_uring_stop_list_entries(&queue->ent_canceled, queue,
+				     FRRS_CANCELED);
  	fuse_uring_stop_list_entries(&queue->ent_avail_queue, queue,
  				     FRRS_AVAILABLE);
  }
@@ -509,8 +518,8 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
  	queue = ent->queue;
  	spin_lock(&queue->lock);
  	if (ent->state == FRRS_AVAILABLE) {
-		ent->state = FRRS_USERSPACE;
-		list_move_tail(&ent->list, &queue->ent_in_userspace);
+		ent->state = FRRS_CANCELED;
+		list_move_tail(&ent->list, &queue->ent_canceled);
  		need_cmd_done = true;
  		ent->cmd = NULL;
  	}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce1..e62bd705e4f5 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -32,6 +32,9 @@ enum fuse_ring_req_state {
  	/* The ring entry is in teardown */
  	FRRS_TEARDOWN,

+	/* The ring entry is canceled */
+	FRRS_CANCELED,
+
  	/* The ring entry is released, but not freed yet */
  	FRRS_RELEASED,
  };
@@ -85,6 +88,9 @@ struct fuse_ring_queue {
  	/* entries in userspace */
  	struct list_head ent_in_userspace;

+	/* entries that are canceled */
+	struct list_head ent_canceled;
+
  	/* entries that are released */
  	struct list_head ent_released;


