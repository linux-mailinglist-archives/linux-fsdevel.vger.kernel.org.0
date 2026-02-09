Return-Path: <linux-fsdevel+bounces-76755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP05NrNDimn3IwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:29:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B8114766
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4DFC3025A67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 20:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B2339853;
	Mon,  9 Feb 2026 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PIbSDC/U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0IpxhuiK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA269241CB7;
	Mon,  9 Feb 2026 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668968; cv=fail; b=VORvwVjsVCBnB7+sD/tFMHyWBjLuXS304G7sUIugb0KCKFDdc1bNhWsVxH/eTTWGpuO9mgZJvYtSTVlXKZfcFSGGHCNK0Q8UAQGAw68IXYqD1u6t6VO5YPrrvQk5B8/68GObBdKZw4GBH7L5kM8cc5mN7PJUmTFKGcQJuN8sLuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668968; c=relaxed/simple;
	bh=mIUBwscpnC+Z1VK8YTQU/yyxBRFisHwoC62TQ2zCvzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ncAu7V9SbyVGzFUZafVeKfZiVMJXr8kh//aj6e1JMDWtCFTd3DY7WEy83VhVnzgZ42Q4sv2DXIwjBFsXDPVJmo/d6zUN8d3QubvTHbfVpvAmb3pW5vu+vmk8vIYf3Coac/MdBmFN2uPRh6QpCLPCUxFqFejDEqP0Iug960DbaZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PIbSDC/U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0IpxhuiK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECZK01945097;
	Mon, 9 Feb 2026 20:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9ni0J3V1lqsCQyZibhZjo1F6x9LM6qLr2dFP3esiAfs=; b=
	PIbSDC/UORsErtfW3dLQAjF5yIjpKOfn+0aM/NNLx5zKbq+R2Fwjex5l4InH6WF2
	gZDuidcmDRYABtw1As7E9faK18b0ET81Yfo3+CFtMgVQhVZAOXCTDEHsYIVPb4UT
	bYgUeRVYdIzEBbKUQhAkG0x3Usm4Gua9QFXKVXxty7ixwJbGTdtXskvpv8d7qiT1
	buUaC3GQPZtS+4ejEpfSVM2hURoxCvPJnXpUYLLqUQ8mql1P3ihlk8Ut9zZlBbwz
	QEW3gz1vFDLHcpcImb5rGHgJpjVUT0p3SYHbGksMJYfJE2IPNYQtG0tBPPPJpYhR
	KXN8VMVqPm6VI6jn4kKuDA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xj4jpk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 20:29:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619Ji2s3033578;
	Mon, 9 Feb 2026 20:29:16 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c7ctxy8ar-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 20:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx7c7RUrS77QxGc00RM1LbKl35B3ZAVT+W878IvwrudbLDALe+4ZJk3Ni1K03OaG9E+sp+PovR+edr+wDe9TtFeRj2QlynM3VDB7k+B/4pk8qZj1VcUjT/8EbEVqAj1nRGPZW67AOdhD7k8+lr1kkQS7OWTZyURp/GgdLEkDRglK2so7ZtwG9vRcLJlCk2SHC18fiqzXPDZj6U3ciJdGjIWrLrKwcArbg30arpQUyT+jnVF1PzTSBZnWNDOqUPDq/crD/s8/T1hEoRQkQfkA4RGEqtCyo40DlQcTsFxIKmYFya2ighWKe8cG3bO8ynIfoGnUNIBgOT8ByIw01rlvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ni0J3V1lqsCQyZibhZjo1F6x9LM6qLr2dFP3esiAfs=;
 b=D8qVg9HJ9O+cTuKQ+iV1UBA+D3SxzOIk6t1yWO6MQno1CKnQHJSaE4vSzNrxyY5gUhjUsRBo1luMR+8euH1Kh4vPkZKlBTy1NYryKHlr8tRg/azXm1zdGp34efJDRD1zgD00aJe+uOIoHQFq5mTObYW7YB7FsutExeGBRTKgkeB2UhJEXwo0H6VVEEH81M4Uco0We8R21y4T4UfT964mLDCufKUkBjXtf8osYvv/V7d06onoHlLcW9R59csniD2yLJpO3Rw4paGznEkw1IlukPmrFtBfvtXkHjRF73qrzMkzEsGxukO1kcZ6lH8fVgu4LAOUCLAJt/jlrtqTayT6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ni0J3V1lqsCQyZibhZjo1F6x9LM6qLr2dFP3esiAfs=;
 b=0IpxhuiKRL52nIAK8G7i7zTUfxA+wGL1FwuPPeq0cnymuSjZavq2Fr19nl9P36/5VzI3Fwep7xi4BcIvVTlNYzEGjt4Bl22N+29YcXqvHa9fSjkhWdoihPCUkr4eZqwXdWFAK11Egu2p4ZCJTCn25L+mYuCX0iLx46icOo8WxY4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS4PPFAFF9EAD68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 20:29:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 20:29:09 +0000
Message-ID: <8574c412-31fb-4810-a675-edf72240ae29@oracle.com>
Date: Mon, 9 Feb 2026 15:29:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] NFSD: Sign filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <cover.1770660136.git.bcodding@hammerspace.com>
 <c24f0ce95c5d2ec5b7855d6ab4e3f673b4f29321.1770660136.git.bcodding@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c24f0ce95c5d2ec5b7855d6ab4e3f673b4f29321.1770660136.git.bcodding@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:610:4d::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS4PPFAFF9EAD68:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1e3a27-8bea-4510-9402-08de6819e0fb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MC9Ra0dNaUdvVTNzYmE3dzFnNGhCMkEzUjdhVGVaZEpKRW43MmNROU9uaHBs?=
 =?utf-8?B?WVMvRDJQcEI2RE1oTTVuQ29IQzVOOUZHSVpzQ1NJYXhDNVZQQlJaTXZvaU1s?=
 =?utf-8?B?dCtsNlB5NUlnaXN4M1daZWlETlNZbjd0MlcvdExNNWp6c2hBSnIzTFJUbDh5?=
 =?utf-8?B?UmUvS3FBZlBIYmI4L1BlL0svZHYyeUJueVVtVUk3SjBFVE0zd3BWTEVrM3Vm?=
 =?utf-8?B?K3pxaEs1ak1vS0xzazlhUUdaZ3R4R2t0QlI5RlRDYWNJTUV1MldleWJmWnVu?=
 =?utf-8?B?Z0xCcGdITDR3WVNRSzU1T2d2d3lnQUpqaGhPYlUwNkluWTArcTg1NWM4ZVk0?=
 =?utf-8?B?UXdDYThtK05EWmpWQ0ZtWEYwR2tPVUJKenNNWnRKU3NVZXpxU1dMMzFkZjVO?=
 =?utf-8?B?bnVVdlZQZWw2OW94MUZDaWk2V1NaS2pIajlWSnVRT1hGdHR1ZXcvS0lWS0d6?=
 =?utf-8?B?cmpUNDVSb3JlVU5DZnJYc3VybHJndklFdDNZOHVvN1JrYnNJVlRHL3hOajFs?=
 =?utf-8?B?OTMxQVJJdStuWTNoNm5mM0xkYlozWDdsUzRYb3dtWGNzeU9OY2tFSFQ1OFFt?=
 =?utf-8?B?N3BtTEhRdUpVQm4xeHBDaFFFeWFJS3hIWkJXejVVVHI2NFNQK0Y4Nmh0OUMx?=
 =?utf-8?B?RDduR1ZhNkJuZ0hFV1JjVEdWMHVHSHV1YnVHNUNSbFhrOGM2dkV0K2hadTEv?=
 =?utf-8?B?WDJVQ3ZtRVBzVGZJY2V4MmJuZmtuTjZRSnpmREpUOE96eFJpeGpXM1pIZGpL?=
 =?utf-8?B?Zkd0OVNBRXRNcUhmR0tKV2srVzl6UWZkOEdJM1U3SU1TZEdGSEdyRUdBcFY5?=
 =?utf-8?B?TWpFQ25xdHIveVJRRks5cUsvSmJJL0tNVlRrUUFVUHl6cnNqc2ZGWVlDYkZR?=
 =?utf-8?B?NlR4RExxQklaWUlLS05PL2ZDYUlvb3ZPcnYrZkUzUFlvL0hNNlowdnhBd3pq?=
 =?utf-8?B?UmptYm90Q2I0bDYxbENpZTZNaHkrUUo2Q0U1NjliRmJjeHdrR2VYQmNTcWZ6?=
 =?utf-8?B?cjFMZUJza29TZjlNcndndjhuSmluVkNYbEpiSUpFNjR6UXFSR2JlSmZCOThG?=
 =?utf-8?B?N0dtUkhLSzY2YzZSVnFPeWt3M2wraVFUSFNkdTBXMjhJcW1zSHJzY3I1dGlp?=
 =?utf-8?B?WHYzWGVySXVJNm1oL0tZV1hpOVJQUDVjRG51WU04SGtWUWJCTkgxNVFzakFZ?=
 =?utf-8?B?WWtWQWkzblFxallnMlBUQzdPUjhlNHA1bEFWQ2ZTVEZRd0M3WlFoSmdGK2Y2?=
 =?utf-8?B?WjVVTG9TaUtQSWFtRjlXZVVwNklObm9HR0pTMkpoejVxdy9XMUFSY0RKL0xj?=
 =?utf-8?B?cWxERy9WbXRYVFhLUTl4b3NWbnZ4aGVtUGY2NGtyM3FvMWpJc1lrV3d1MTRO?=
 =?utf-8?B?bTlydE9tUVExdzdvQm9jVytUcFVsVHFZVVJ5Z0t6VERwNjV3SWx4TS9DVzFj?=
 =?utf-8?B?aXBueUZ0K1laMUN2WUJIYk1GemllMGs4U2ZDUG9leERvUjI1bEw4QWRuNFdU?=
 =?utf-8?B?RGt1cVdZNGkzSi9HNUtDbjlGOHEwV29WK1p3TkhuNmNwSGxVeXJKMGFoVGJR?=
 =?utf-8?B?YTNvUGNraFkva0E3cDg5V1g0dm1PeEVkUzdNK0dlbUg0NVU5V2RNMHdHN2Nj?=
 =?utf-8?B?RFh2UytsNU5oUnMrVlJrWmpreEFBWVpjSHNYNFRWUGZEdXZVOE43UUJIYVRS?=
 =?utf-8?B?TTNPaGtZM3lOY0h6T3p5WklPRk1MUi9aWXk1UkRIMk9Jay9lWjdCZythVmJn?=
 =?utf-8?B?aEowWjVxSGpWK1Z0SWFINkUvS1VmSmFwOVBGZEh3NEFxSU5sL0I0Y3VRbmph?=
 =?utf-8?B?Y1EzZGF2L1NyWlE2bk5rR3l6TDVFVVUyVVl1L0cwUXF3RmpJRHlaMXR3SmJh?=
 =?utf-8?B?YWZVdmVvb2tRU3o5UkdNaTJ0Z3U2TkdNZlpEUy9Pc09lOGFPemNqNzhyZ09V?=
 =?utf-8?B?SVorZWZOTExHUEZPNXFUcW15UkEwM1dmZ096UHZKbU5yTUplQWEyOUlEZDQw?=
 =?utf-8?B?eHN0S3lVMmV5bklhSlpSTWdVY3JSWVlIM3VRQVNLZkV1YVZaZHVNbmNyOFlI?=
 =?utf-8?B?eGYxeEY5UUtTbHhQemx4Rm5LWFZmMkZ3YkdkWi9FL3BsVGY3ZTVlZWhUZnJ1?=
 =?utf-8?Q?3yag=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VncwblhpYXNyOU9NZXMvOWR1OE1vWkg5Y3ZVenhqelBtcFM0ZTlCbDRUSkVY?=
 =?utf-8?B?TG04L0ZjOEt6blJxb3VyWGQyRjVHaHZyMnpsUTlwTU1yMGtvVllDaG16cXFT?=
 =?utf-8?B?MUZUMnZ1bmtxYkl6WEkwZHcybFUzL05xNzFQLzJoUVlqRnR4N0pkNXN6VFN3?=
 =?utf-8?B?L3dYSVo4b1B6K21SWjRSWFY2WnN1ZW53SFFOc1RFQkV4cXQ1Qzk2L1N0cDRt?=
 =?utf-8?B?bXdRREFXLzUxZXVId2NaVlVqYXA2MzlzLzBmMEh0b01aRHB1YXl6YXNjR2Yw?=
 =?utf-8?B?OGh4K0V1WUpRa01PN2NtTGxTNWtET1BjNnNYa1lCNzhNdklhMGhFaTE1Vksy?=
 =?utf-8?B?VHNsOGNlVG82LzlzZXhwT0NpbCs3bldQUDNsVE44QUw1Y1A1ZVMzakdNdmNs?=
 =?utf-8?B?MlBTMkMwcG9Gby84YzJ6RnBudTlOSXBmalNCTmgwSUcycDZBTlc3WHo2UzNz?=
 =?utf-8?B?d1YzcTk2ZlNXWWE3STJTb05ObFlzTUZIQmV5MjhKWXBFendLZTlGaWY4U2cr?=
 =?utf-8?B?TGJ5eDBnYzNWNXA5dnlYSTAybVpSWWZyeEpRS1pnazc1ZzB5VGpwOXN5OWtM?=
 =?utf-8?B?WEFpRGw3VmlWcnFOTnVDRmloRCt3cG1zMG9mWUpJRFgzcWNwa1EzcEUwVVA1?=
 =?utf-8?B?VzJMNzJQaHg3K1dTSnV0MENubENIVnh6S2dyYmM1cXZ2SW9iejhNbnd6T1ph?=
 =?utf-8?B?STdDZGUzdHBDVHpBTkp1NnVHR0NsRmxxcS9hK3VhYWtyT0g0b3VjN1Eya1Nx?=
 =?utf-8?B?d1p0bExrcWk1TERJUC9BNEovQnRqV2dlNDNNOHJXMUtHSHFKQ2J5dmtKeG9T?=
 =?utf-8?B?bDhtZVYzdHhlRVlYd1JpSHRjSjZIcFg3WkRPeW9wc0RNR09OUk95SEpNV3Zp?=
 =?utf-8?B?WXhFUjVkU1NHeVphY1QyWHNIVVh2UVF3MUk0S3g4SWVXajA5Z3p0bk1lMzl4?=
 =?utf-8?B?TmxMZGc1ZmFoQUFRYjBEaGI0Z1NOQmZUckZQbVA4UDhkbSthVlVrRjN5N0l5?=
 =?utf-8?B?RFFwOTBvVzE1ZzZFVUlHbnB1bENkUjlRQmxrcUt1Y3dIWGlOWXZ6QS9BaG5B?=
 =?utf-8?B?M08wOC9RYTlaYXdKODZGMkx5bEl4US9kbDlyUng2Q2xWWEFUMkdiRWZqMDdi?=
 =?utf-8?B?R2JDTU5YTmVuOFo2aWUwNi9ObTk3cVMyaWVCb2EycElSeG92KzlzOENYdVJR?=
 =?utf-8?B?NDdwbTVNRXBrN0wzSXF2dXhvOXBBN1NpdDd4emZlSGdWb25US3hWSWxpMXNY?=
 =?utf-8?B?aHFCV1MzTXY5bnRkSC8yMUJQR2dJYXY4dVVuLzVIc1AvbkRyN1lYT3NxR2xQ?=
 =?utf-8?B?S2VkRkxKeUEya3NOZ2VGVktReGpoMXlpUzYrN2R1SVZVWGE5ejl1RmtkU3Zw?=
 =?utf-8?B?VkJ4VVcva2NqSlZ2V1d3Yk1hekFlVzhIckxTZ3UvNEpwU3JDdjJIVWpNZmVu?=
 =?utf-8?B?eTZ2V3I4UzRQQjJGdWNOSlByTlZxQUNkSmMrclpseEhwb0NZamQzcmc3L2hj?=
 =?utf-8?B?R0xUc2YyMS9MNm81S21zZmVMTlBhcnJTRG16L0UyaXFZN0NScjZkZE1OMDFp?=
 =?utf-8?B?YWlvODFzdUR2aTk3dG5JS0xqb3BRTEYyU0x1UDV5UTg4bTRUSVZydytEQzV2?=
 =?utf-8?B?V3NoRzFqR0tDVVFQUXRhcUFVUXhnZVU1L0RHeXNlYjBIcVRJMGZ6R00zTWY5?=
 =?utf-8?B?TkdKc1BoalRXWU9YdjBOako3MVRYdklwUWtIVkhEU0lOMWZxZGlRdXR6VVBZ?=
 =?utf-8?B?UnA5bC8zNXlEbmpUQkgxVGhKUTVkajlMU29ORUVKbG9FZEJmcHRjV0tBUjJ0?=
 =?utf-8?B?aEhMQytoMEpUUmZOZTc0M2p1ZWZvUHZzZG5vMnZKUWhJSHdwcGtaYWJ3QkpS?=
 =?utf-8?B?SVpsVmRqQUd4QTVHSS9ZS21hY2JyY1dQSG5OL09TcnFqbytYVm0yTHFFOUow?=
 =?utf-8?B?OWhpREg1U2hrR3ZRVmFPTXZDRTB0cGdrSlJBbHBxL0g0MjdSUEJGc1dHdkZh?=
 =?utf-8?B?Vm5kdjgxNkdsQTRmUUlrU21Jc1FrUGdJVmQ4OVgzTkZIcEczSlFYR2xuNzFh?=
 =?utf-8?B?ejNyME5YOUtKaUgwbW9PNDlweUluV21LQkt3RE4weGdHcDAxSDhDaCtYTGxs?=
 =?utf-8?B?dDd5dy96bFdIWDdOTnUrMUovWlJ0L1Zka0k0ZzZUYk9Ud2JIQUxxdWFSUUU4?=
 =?utf-8?B?b3ZrZVlDU3loNDduSWhMeFFWQlpQY3R2cDdKSExRK2FZYmVDQ1hCbUc1NjZY?=
 =?utf-8?B?RjhvVXpiWHhzYzhLZmJqdVhSZXpzVDkrVmhXcjhXUnJ6SWt6dFFMZXZSUzRn?=
 =?utf-8?B?blFBendDeE9SL0ozU09ZMWxwZkI3MldsR2thTXd3bG14Z1pXVzZwZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wzeRK0EHVEMYQOyAM+BwQI52xkR+Q16vcVBuo0QTYIpz7i1zQ5vke8U2JOE2gJiPFDCvqOTI4orQFwbpF71hWOqTlshJfKArWRxIl1hDq/6GGWvM1e+qZTi+j7Gc8bmvsXlOV+nrCCYeLqgIfFM9KUinsVAfIYxM5fa8HGuG+qh/ib2al9KfNOj7KwDEFyR40lJjuEeZGysNM1cAAB7V267/9BTIFVynjo8Z1cBeiUqVUnfTLhITGtKSSVc6im6S9nASf3u9eld8pgjFifbybz17vD8fYRzKjE88Hz7M/nJWCBAJ/mH2odP17PalBKANZzHZx98jfvHA7Ad4qhLhxj52AeXcCxwGEgTK9UEcqSGmEA/GbKci8cOXQ4LFO16zHS43P2USdXTJ5KkpjXhMkVfD7T9sQTEz9rpqhzWyHAl9vfVTC5pJNNwKq/hhPJVyOkXwDLXegH3yYP3VUrOPNzQqiIDh/XNEaEqgyWGRw2IETL7udCwebNAc2ncLfgshuEAGOoBJME2jC7SHyjvFAJ/bThbE6RA79dDgjJq35ZEJg8Z06NVheLmRCO2RmUv03KRBILkdNiOvNvGeePOKPqL9ZbfuxKZX6XH8HqDPkOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1e3a27-8bea-4510-9402-08de6819e0fb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 20:29:09.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpkHYfMPWchTP8HumnklO4kHyu4BLaQ0J+ilwwKZkGwM009lZu9hnSX0KhWlfL0GU1XYwA/eAubEjNbxr1ezxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAFF9EAD68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090173
X-Authority-Analysis: v=2.4 cv=Adi83nXG c=1 sm=1 tr=0 ts=698a439e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=SEtKQCMJAAAA:8
 a=VwQbUJbxAAAA:8 a=wTdxEJ7fpPm18nyNNa4A:9 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-ORIG-GUID: vbmq2Zee9AYDur4kf6xVHrKJkEjlkUyx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3MyBTYWx0ZWRfXxF+4sywMrSxv
 UUZp/bZSJvFyuWXY2jtGnw0GlAiGEHoyZRlwFf7HMx7VA3LHpxvMVkDwAXoNi+AgO1JcFahHw+b
 A30YTdmEUDPuaSqnZxnZ+VnuMQTsOFRKy8bnkjOUG4q7YK6KMjmsgW5jI6yOchzk9tnbiUpZplG
 uNVL4h1XPe+iIF9/X+sfKtT5euhFrj5VsKcjXe49MU4wMehbhGDPvnpkbbC0r48g5q3LXpfuTPU
 PeKc3p9J+Tt4ESSfV/e1zRSx/0iqbjKodYB3hOHwGHlVaxLo0bzEpf5f+kn61Q0b1VK1bvn0LQ8
 5quig6+xlupuP1CjMzY1JUI35YVN+5p96skAnputLchoJprqexNgcA7eMoBM01azXofG5UBO/4U
 HpoVqUsM87jAS7xiOuXZrfMynXn87V1GpZi9KTNlgpS45svdnlxk26BxQ6Sncieu3C/xxctgBES
 QhbCiW6FQfLHBa9oorA==
X-Proofpoint-GUID: vbmq2Zee9AYDur4kf6xVHrKJkEjlkUyx
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76755-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[hammerspace.com,kernel.org,brown.name,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,hammerspace.com:email,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 528B8114766
X-Rspamd-Action: no action

On 2/9/26 1:09 PM, Benjamin Coddington wrote:
> NFS clients may bypass restrictive directory permissions by using
> open_by_handle() (or other available OS system call) to guess the
> filehandles for files below that directory.
> 
> In order to harden knfsd servers against this attack, create a method to
> sign and verify filehandles using siphash as a MAC (Message Authentication
> Code).  Filehandles that have been signed cannot be tampered with, nor can
> clients reasonably guess correct filehandles and hashes that may exist in
> parts of the filesystem they cannot access due to directory permissions.

It's been pointed out to me that siphash is a PRF designed for hash
tables, not a standard MAC. We suggested siphash as it may be sufficient
here for preventing 8-byte tag guessing, but the commit message and
documentation calls it a "MAC" which is a misnomer. Can the commit
message (or even the new .rst file) document why siphash is adequate for
this threat model?

Perhaps Eric has some thoughts on this.


> Append the 8 byte siphash to encoded filehandles for exports that have set
> the "sign_fh" export option.  Filehandles received from clients are
> verified by comparing the appended hash to the expected hash.  If the MAC
> does not match the server responds with NFS error _BADHANDLE.  If unsigned
> filehandles are received for an export with "sign_fh" they are rejected
> with NFS error _BADHANDLE.

Should this be "with NFS error _STALE." ?


> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
>  fs/nfsd/nfsfh.c                             | 70 ++++++++++++++++-
>  fs/nfsd/trace.h                             |  1 +
>  3 files changed, 152 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
> index de64d2d002a2..54343f4cc4fd 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -238,3 +238,88 @@ following flags are defined:
>      all of an inode's dirty data on last close. Exports that behave this
>      way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
>      waiting for writeback when closing such files.
> +
> +Signed Filehandles
> +------------------
> +
> +To protect against filehandle guessing attacks, the Linux NFS server can be
> +configured to sign filehandles with a Message Authentication Code (MAC).
> +
> +Standard NFS filehandles are often predictable. If an attacker can guess
> +a valid filehandle for a file they do not have permission to access via
> +directory traversal, they may be able to bypass path-based permissions
> +(though they still remain subject to inode-level permissions).
> +
> +Signed filehandles prevent this by appending a MAC to the filehandle
> +before it is sent to the client. Upon receiving a filehandle back from a
> +client, the server re-calculates the MAC using its internal key and
> +verifies it against the one provided. If the signatures do not match,
> +the server treats the filehandle as invalid (returning NFS[34]ERR_STALE).
> +
> +Note that signing filehandles provides integrity and authenticity but
> +not confidentiality. The contents of the filehandle remain visible to
> +the client; they simply cannot be forged or modified.
> +
> +Configuration
> +~~~~~~~~~~~~~
> +
> +To enable signed filehandles, the administrator must provide a signing
> +key to the kernel and enable the "sign_fh" export option.
> +
> +1. Providing a Key
> +   The signing key is managed via the nfsd netlink interface. This key
> +   is per-network-namespace and must be set before any exports using
> +   "sign_fh" become active.
> +
> +2. Export Options
> +   The feature is controlled on a per-export basis in /etc/exports:
> +
> +   sign_fh
> +     Enables signing for all filehandles generated under this export.
> +
> +   no_sign_fh
> +     (Default) Disables signing.
> +
> +Key Management and Rotation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The security of this mechanism relies entirely on the secrecy of the
> +signing key.
> +
> +Initial Setup:
> +  The key should be generated using a high-quality random source and
> +  loaded early in the boot process or during the nfs-server startup
> +  sequence.
> +
> +Changing Keys:
> +  If a key is changed while clients have active mounts, existing
> +  filehandles held by those clients will become invalid, resulting in
> +  "Stale file handle" errors on the client side.
> +
> +Safe Rotation:
> +  Currently, there is no mechanism for "graceful" key rotation
> +  (maintaining multiple valid keys). Changing the key is an atomic
> +  operation that immediately invalidates all previous signatures.
> +
> +Transitioning Exports
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +When adding or removing the "sign_fh" flag from an active export, the
> +following behaviors should be expected:
> +
> ++-------------------+---------------------------------------------------+
> +| Change            | Result for Existing Clients                       |
> ++===================+===================================================+
> +| Adding sign_fh    | Clients holding unsigned filehandles will find    |
> +|                   | them rejected, as the server now expects a        |
> +|                   | signature.                                        |
> ++-------------------+---------------------------------------------------+
> +| Removing sign_fh  | Clients holding signed filehandles will find them |
> +|                   | rejected, as the server now expects the           |
> +|                   | filehandle to end at its traditional boundary     |
> +|                   | without a MAC.                                    |
> ++-------------------+---------------------------------------------------+
> +
> +Because filehandles are often cached persistently by clients, adding or
> +removing this option should generally be done during a scheduled maintenance
> +window involving a NFS client unmount/remount.
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 68b629fbaaeb..3bab2ad0b21f 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -11,6 +11,7 @@
>  #include <linux/exportfs.h>
>  
>  #include <linux/sunrpc/svcauth_gss.h>
> +#include <crypto/utils.h>
>  #include "nfsd.h"
>  #include "vfs.h"
>  #include "auth.h"
> @@ -140,6 +141,57 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
>  	return nfs_ok;
>  }
>  
> +/*
> + * Append an 8-byte MAC to the filehandle hashed from the server's fh_key:
> + */
> +static int fh_append_mac(struct svc_fh *fhp, struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh = &fhp->fh_handle;
> +	siphash_key_t *fh_key = nn->fh_key;
> +	__le64 hash;
> +
> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
> +		return 0;
> +
> +	if (!fh_key) {
> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d would be greater"
> +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_maxsize);
> +		return -EINVAL;
> +	}
> +
> +	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
> +	fh->fh_size += sizeof(hash);
> +
> +	return 0;
> +}
> +
> +/*
> + * Verify that the filehandle's MAC was hashed from this filehandle
> + * given the server's fh_key:
> + */
> +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh = &fhp->fh_handle;
> +	siphash_key_t *fh_key = nn->fh_key;
> +	__le64 hash;
> +
> +	if (!fh_key) {
> +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key not set.\n");
> +		return -EINVAL;
> +	}
> +
> +	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key));
> +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, sizeof(hash));

Nit: fh_verify_mac() here returns positive-on-error (crypto_memneq
convention) while fh_append_mac() returns negative-on-error (errno
convention). Would it be better if both returned bool?


> +}
> +
>  /*
>   * Use the given filehandle to look up the corresponding export and
>   * dentry.  On success, the results are used to set fh_export and
> @@ -236,13 +288,18 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
>  	/*
>  	 * Look up the dentry using the NFS file handle.
>  	 */
> -	error = nfserr_badhandle;
> -
>  	fileid_type = fh->fh_fileid_type;
>  
> -	if (fileid_type == FILEID_ROOT)
> +	if (fileid_type == FILEID_ROOT) {
>  		dentry = dget(exp->ex_path.dentry);

The control flow silently skips MAC verification for FILEID_ROOT
filehandles. The rationale (export root contains no per-file identity to
protect) exists nowhere in the code. A maintainer investigating security
boundaries must deduce this from branching logic. A comment explaining
the exemption would be helpful.


> -	else {
> +	} else {
> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
> +			trace_nfsd_set_fh_dentry_badmac(rqstp, fhp, -EKEYREJECTED);

-ESTALE might be more consistent with the documentation. Any opinion
about that?


> +			goto out;
> +		} else {
> +			data_left -= sizeof(u64)/4;
> +		}
> +

When NFSEXP_SIGN_FH is not set, the condition short-circuits to
false and the else branch executes, subtracting 2 from data_left
even though no MAC was appended to the filehandle.

For a typical FILEID_INO32_GEN filehandle on a non-signed export,
data_left at this point is 2 (the fileid portion). After the
subtraction it becomes 0, which is then passed to
exportfs_decode_fh_raw(). In generic_fh_to_dentry():

    if (fh_len < 2)
        return NULL;

This returns NULL, and nfsd_set_fh_dentry() treats that as
nfserr_badhandle/stale. Does the data_left calculation break all non-
root filehandle lookups on exports without sign_fh?

Also, let's replace sizeof(u64)/4 with a symbolic constant to survive
MAC size changes and better document the computation.


>  		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
>  						data_left, fileid_type, 0,
>  						nfsd_acceptable, exp);
> @@ -258,6 +315,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
>  			}
>  		}
>  	}
> +
> +	error = nfserr_badhandle;
>  	if (dentry == NULL)
>  		goto out;
>  	if (IS_ERR(dentry)) {
> @@ -498,6 +557,9 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
>  		fhp->fh_handle.fh_fileid_type =
>  			fileid_type > 0 ? fileid_type : FILEID_INVALID;
>  		fhp->fh_handle.fh_size += maxsize * 4;
> +
> +		if (fh_append_mac(fhp, exp->cd->net))
> +			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
>  	} else {
>  		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
>  	}
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index c1a5f2fa44ab..8f0917b1b55d 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -373,6 +373,7 @@ DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name,	\
>  
>  DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
>  DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
> +DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badmac);
>  
>  TRACE_EVENT(nfsd_exp_find_key,
>  	TP_PROTO(const struct svc_expkey *key,


-- 
Chuck Lever

