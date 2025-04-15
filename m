Return-Path: <linux-fsdevel+bounces-46442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51DA8973B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1320440287
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D427A934;
	Tue, 15 Apr 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="zBQ1sLIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AA24169D
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707351; cv=fail; b=lHA3YJ4+8zcGlH3Hnrb4350vMdS6Wr8Es1wU7qVhwgG5aGWZ/DMxXZVX3KJGuho22CzQxi/uFopqjj2WMnbIPghHp/j3SvOhluc5XSxVeFkv4B4gUgcpfZCixzbOHq85dz4HT8IP7TLHryjw/kau254N7Y4213YZDYmaeLzk5qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707351; c=relaxed/simple;
	bh=YYju8S8BNtCxLOW/X/K/rZPjgm8GxchipqLP9LpHOKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fWeJSoS0/kts1he6s9+GQcyY/wOf++1veGPO5BJUQ8pxyJjLglF3btvrWaqDTM8Zi3aKi9Ggz4e7aO3C/nF2/SaOIxpfIkYBtO1mAATao9sa6x/DYBTeWi3b8PK+wSZ2peqk20YKdSbK2gj16tpR87FkDEOqRB0eaX4u4e+Muc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=zBQ1sLIl; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44]) by mx-outbound20-234.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 15 Apr 2025 08:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCTLRGnOyXmTPs/EvWYIbFPFro3fL5qIG8d+RJNNMPkZuSMRBtQse5KMR1NnkhEJneJxVXSZ79oakyBuNeKwWISqxxjPYe+pMTFaDaNjNMr39ydJXAYCrSpR+d/APKJeCR/1AaYLGDQW4acfrIS/W11v4Iq9ArkXBUiRaTvpUTCuwtyJNT4sDy4CgeA+QK3FSDrgMPMT8hmr0sjNhHZ/26UMOswXiNn7rNfe1GguMZkTXG2xNjclT97Qzo8K0VGhkOpkrfGTlMw/o1eZj4vtasI7AGPJBIz41JI32CtVkANvKqvBC3jguF2JCnTMdLLtoZePMh5SnVNXdVtz7kah2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=463/bxyQQcNG9qj026rPY8UAmoR0MYtrNxfKKdW8PBk=;
 b=OAdSfytpYOm9NhwGcgOch84CuqlMmfw2kqereYpOnRE6eptKWcslWd5cKePTuYy9wHB0wej9OOpJS16qipkN7PdQ3KLGB2NQwkfEQl/lo46Tgyxy+mwvdsN58sDIiAglLpnESbtQCkd0BJkVRilKNz37M+cjUCZ7iuTo9GtHsuI4yGY7bkxchdIfO7xwDC3jDyKWT8mLqOqQm51NrG6OwwoG4nVD1gV8o3RIlP4lYjcCLEWK9OQtM4Vi9H8P5mC+OhnT4D5KPEP8KZRQ/OnMp2lbxjsDGYJjAvEWF7hbC5dZgj7NVv84P5ebX39Eg4X7PT23uWYkCUbqVnDePkEOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=463/bxyQQcNG9qj026rPY8UAmoR0MYtrNxfKKdW8PBk=;
 b=zBQ1sLIlZvCt1YRFfSogYYjxG8GupEnzCvkgFdNv3l3WRT6MwbCoF/swzpX8rvExvaS4vqApYDtxsVWjijVxeFOR9tyaKqdqx/ZJza3o+vXpxGIOjQ229AWj2ECdNbP2bFyrK1nOY1ADe4fcEcU/I61UVQoIF1cafdkzgt63Kxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by IA0PPF0747E8EB3.namprd19.prod.outlook.com (2603:10b6:20f:fc04::c86) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Tue, 15 Apr
 2025 08:55:44 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 08:55:44 +0000
Message-ID: <c6ee9685-510e-4ac4-873d-abd48cc3d5ae@ddn.com>
Date: Tue, 15 Apr 2025 10:55:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
To: Guang Yuan Wu <gwu@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: "mszeredi@redhat.com" <mszeredi@redhat.com>
References: <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
 <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
 <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
 <8b6ab13d-701e-4690-a8b6-8f671f7ea57a@ddn.com>
 <BN6PR19MB31873E7436880C281AACBB6DBEB22@BN6PR19MB3187.namprd19.prod.outlook.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <BN6PR19MB31873E7436880C281AACBB6DBEB22@BN6PR19MB3187.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0189.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::33) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|IA0PPF0747E8EB3:EE_
X-MS-Office365-Filtering-Correlation-Id: 594709b3-e6be-4281-f44d-08dd7bfb4ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHBPZlFOY1ByREhVQVBoMHlsb1IvVG9KaEYyajQ4QllBS1JCaTJnV2owNlF5?=
 =?utf-8?B?V3JWTmhWT252QUE5ZklsaTV3N1NJMmxObkJ1Rmx2OTVycWVJZC9hNG1WTnBI?=
 =?utf-8?B?a3QyT0I4VXE0NjV2UUZDMmcvQnFEeTVhelNXV1pIa292eS9tVU5WbUtGU0Z4?=
 =?utf-8?B?Y1RqVE5tdTJEakJmd2pUZm44VDFlU0J1ZjhDOHBvbTF6RGNvUkg4QUpJbG01?=
 =?utf-8?B?S0JIbEJiZEtEaFZQcDhmRXlUQnBnTjJLU25rZjM1WldQNUw2T2t4bE9OdnNC?=
 =?utf-8?B?U1p6OTdkblUwRTc0WVRzd3I1NEVvcDJKZjFveFc5bzZjbTBxenFXZEJqMW9F?=
 =?utf-8?B?UXFlZWVFYlBUOTdJSVp6TzMxMEZFaGxraVF1Szh2Vjd3aDRXemVEUzlBZ2NO?=
 =?utf-8?B?KzR0OVRwSUF5cGU2QzZWakRob1JXZ3grcTRJOThra2p0THNWMFhrTlZVdmo4?=
 =?utf-8?B?dENxY2Uwc1ZwZXV3WXhPWmZ4TEx1dXRTSDdUMm11R0JZNFZzbE5KejJpbmpG?=
 =?utf-8?B?aHNtWmFYVDExNWZWa1c1dHBZSDRGekxWVGc5aGpYSVUvYXFkdStvUjdWVWdP?=
 =?utf-8?B?OGpRcWhzQnYwanJ0UDBwTkU1aktrSkpIMmt2c1ZhdGtpSXk1dnZWRStnM2Uz?=
 =?utf-8?B?U0w2MTVRMm43ZEFrVHdoVVFFT0MyMjBpKzJUM1dQeVBVUTR2ZDVOT1RuRXFK?=
 =?utf-8?B?RDFZQzRyUTFVZGZTeHR6MjNpNWRtMWNWdWRqM0NUMUNhbHUzV1Fnak51RVlQ?=
 =?utf-8?B?ei94dUNUWk9YNXBtT3cwdldDT3djZ1hqeE9hVksydHBEcW0rZnM2eEJIa2t6?=
 =?utf-8?B?VWJMOWpPdkpsMHJoSlVkRlQvbE1oNkRPWTN2WEhjejFOSUF0MmIwRG8vbmRR?=
 =?utf-8?B?Znp3MFJLaEdqNkh0OS9PeWFlOTI2MTBtOGhtSVRsL3E2OFlnUit4alc0cUhp?=
 =?utf-8?B?Z2w3WUtrVHQ1Yyt3d2VycmY1ZkVKdU8zVlBjWkJSNkt3eVQxOUhydDNzMDBO?=
 =?utf-8?B?aFhMMUlQTm1tMlBScGVLTFZ6UDlhRXBRbW5IU1BBNGYzS2J0RXBvMFlnZUR2?=
 =?utf-8?B?NFU4QktIMldhbEZDT2ZlLzFWR1JHNHY3Sk1LcG94OXlLdkNKNGdIU21WeHBz?=
 =?utf-8?B?ZSt1eWJTRnhxWnRycisrZmM5WlhlZXhIUlg5czN1ZEc2ak1Fdm5hOXdtMmVE?=
 =?utf-8?B?K3NGZHNCbWdVbnlSKzhhNDMySXpJNCtIVVMwYW5FNmYrOXNHSE5IbUJ0VEJq?=
 =?utf-8?B?L2FYZlRuM2Uzb0dWVkFFdVhocGRISytUOEZJdlFwOHIwQmZKdzZHVzNNNitx?=
 =?utf-8?B?TlJ6REZ1cEh4ckd6VW9RNFZ6dFVPbmRwYWlLQ2lJN3dLb2Z2eDZuNHV5RkJT?=
 =?utf-8?B?ZWxYc2NySnFJV1FQblVvZGFzdWpISmQweStyWFZiT0JtdHV2eEQzRUZtYWNK?=
 =?utf-8?B?dW5lc3BwS21MeUFSdXlSL2xjQWNyaXhCcy9TaWZ1dzhST1h1QUduMDFzRjUy?=
 =?utf-8?B?Q0VLT3d1bGpycU1lZHRKNXZLNnl0RGhsRkxRQW5HRDJCdTZHZkxleGhMSFU2?=
 =?utf-8?B?VVlad0Y0aWxNUHhRVndkdEN0UnRON2lQU3NuNzdxa3lvMGxZMmZ2ZWxQQnV4?=
 =?utf-8?B?Qkxacm05ZnN0YWwzcDFJZWFnQkNmV2p6NnBPVnVMbFVwb0tGcVlFU1ZQZ1RH?=
 =?utf-8?B?QkNJNXpPcno4blFNNlZ5NURBdE4weGFrUFFuWHA5U1lMOGpUUWE2R24vbEVm?=
 =?utf-8?B?KzhYcGNVV25kTTZOanZIblBKSTY4bldwNDE5K2NvQXNuNmhacVcxRWI2NzJ6?=
 =?utf-8?B?SzczRGxaSmpidnJNdGdGWnM0N2ptbmg0dXZJZk92N010ekVWSWlqWWx6b1Vo?=
 =?utf-8?B?eElPdEZXeTFxS1FZUWVBNms2bjZ5a0I4QnZ2T1lyVHQwaFVSbjgrSGorTmxV?=
 =?utf-8?Q?rCU1mfR19N8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFQ0MmNwbXVXTGQrRVFlSlU5cFl4Zlg1UVJOUzFETUtSU1Jkd2RMQlhOS0p2?=
 =?utf-8?B?THFCSUo0WnlzMVgybWE4Q0RnKzJQM2dvQXBrUWR6bndHaE9vdmRIMVM0ZjZK?=
 =?utf-8?B?Smt4ZDdVd0VmQVRzRHUycmdrMnhlWC80V1RMOUJBU3llL2NPR3RkOTFHU1h0?=
 =?utf-8?B?UGxTVTkzSmxsajM1K3I4THRaUDR0NnlKak04VEJkQVhPSjJjZ1ZyMXdEdFpI?=
 =?utf-8?B?UTdLaWVtVmZ1WUgyblg1cmRveFlKK2pDOEo0UUJzZEx0Uk5ZVkdEY29uRWw5?=
 =?utf-8?B?QmpCSWQ3YllhellENnRaYUJQQ082SmphY3dVV0toaGNnVFNIUE5ObEVEMXMz?=
 =?utf-8?B?SnQrUmNKTEtmUUkybW42RER4RXVFYVJIbWVCdU42UVJ0Rnh4eTZXL3lMTUpk?=
 =?utf-8?B?cGxRRTgrenlsTTAyd2JMSVROYXorWlZtTGd6ZXNNMXVVNURuNGg4UVdUcmtv?=
 =?utf-8?B?aVJSai9PbWhEYVcxOUQwQ1pjTXc1QzJSUEdUdUdaaVpGeDhhRTB2SUpBbk1B?=
 =?utf-8?B?MWpZTVErOVRaRmFtZzhtRm5SNjFSNmFxUDRXZEorYjB5dmFLNmFGL0EyWEt4?=
 =?utf-8?B?Y2h0OUxpRXJmMzZIRWdtS1JmREQrckMwZHVpZFg3SFZ3OVB0Wld2R01RMnRw?=
 =?utf-8?B?cTFqSC9ZaGc1Tm1PNUJWU1JIZEdnUnFlWjVXUmZNbk5sOW9LZW10c2VsQTRy?=
 =?utf-8?B?Ry9TYmVmQlpGNWFZd0hiNlZHZnFqTjVMOUoxeFIvd0dac0p4TW8ycHNXbGF2?=
 =?utf-8?B?YTBQQlpOeUk2MFEvZEsrRWdGMUIvTGpFRFBuR1B4U1JOeGdjSklGYTdEcmVW?=
 =?utf-8?B?enF4TldYZHJORVl1aWgzQUdxZ212SGFFaXdGRlFBbmRwRjhNeCsvK21vQ3Y2?=
 =?utf-8?B?NzJaTmd5YXowbUpMNzZNaGU0SHFuRXJqbjhHU3RZNElqUVVCM2c4QmVPTTh4?=
 =?utf-8?B?ZzdhV3lzYUpoQXpJMVlCOE1mOXVLYkUxV2JscXVRV2NvcG9UVFBPYkY1L2Z1?=
 =?utf-8?B?QnJBWlgvN21GQlpmNDV2VUs1ZlYxdXBBYkdXRDNhUHhmUzcvQXR5bFpXTTdu?=
 =?utf-8?B?R2EzQ3hGRGlOVDROelJUQkJEblhHbTRHUjJKcytDNzV0Mm5XdHFncmlFNEJX?=
 =?utf-8?B?QTNIcTNiVkxWZDZIa0FsK1UwMjNIV0xZRFZ3RFJiSXd5YitqamM0dGtBakhh?=
 =?utf-8?B?OEMxaVRNdFI2RndVa2t1eUpiL0RTbUJQYUc1QWhncW9iVVNoNTZUSW9qQ3Z5?=
 =?utf-8?B?L3BjTWhDaVB0Wmpzb3JWaGtQenErUGZYSjhsYnlTNTNrNUp6UjlVVnRTWTAv?=
 =?utf-8?B?cDlBdHJvcCs2dUhibDFyNlh2WUdsSnNqRXh1MlNoN21yYmFoa2lqbW56SURq?=
 =?utf-8?B?dUloQmZaNnRRSDBic3FveVpQenRlV0luL3ZTWVJtb1AxaTZlTWxuZDZWbXJ1?=
 =?utf-8?B?RWxraGNVUkVLQ3AzWC9Ud2U3ZCtmeUNHK2c1Q0dSNU5yNFdqem9uNG1tRHNa?=
 =?utf-8?B?dzNsV0JVeHZmMkZ2THBVSUlzTGFYcVhJRUtGRjk3aStQV2hPUXRyYm93bUZT?=
 =?utf-8?B?MHEzTitXRElzQ1QzVC9GTDVGcmFSVE5JbTYzZzZ6MFF3TTYvYXhUZW9ZSWx3?=
 =?utf-8?B?NFlqRGVEbzg2SGpVd3E4TThtN0VMOFdDUll6NDBIaStMcFVsZ1F2NVNKdFla?=
 =?utf-8?B?MTVGNStVOC9vRWQ2MTF1bWtqMDdQaXZRK3NSdDNRTktHdjRSRlZxS05qZURW?=
 =?utf-8?B?NW1UUXhOQnRTUUM0MmYrUk5LMVBESTFBQUxLc2FwLzFobUlTU2pWSXZnUnl2?=
 =?utf-8?B?RytUM01MSEdpTy9xd3BTUmZyakI2ZXFJNWxzUThQclN1MUdxVVArMk14eGNF?=
 =?utf-8?B?cnlrdzdxU0VxbHZNZGJ0VkNpVnRMSWcxa1VwaWl1S092TE9IaUlNc2F4WEh0?=
 =?utf-8?B?UGpDNENqN244TDFZRHNoQVVWRnhiQ0FMRmgwU3hJaEg2cncyMG45VG1HOHh1?=
 =?utf-8?B?d00wYUExMERRUDNjL1V3MVBjdE1jMlozMWVJL0h2dFdCcWV6QXYxRFRHUXZi?=
 =?utf-8?B?Q1NzYTJaZGlMWUdEU1NJMHZ4TjdxYjlNTndqY2dtc2FsbU1TdjljNjlBMy9p?=
 =?utf-8?B?RVNEL1laWnhGM2NicW04bnJydTE2Y2hhRFFXRVpsSjRmUEtHQUduVXczbDlr?=
 =?utf-8?Q?9UjQz2FwqMCJGz734AnPuPmdPFBiCJT6z6pKwUrlLmol?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VcQ9pzNePU2G1ckq8BR+z3HgVCuBtAcec/Pv6c+WWKIA7Twyoex+CIyEt0Xdtf5A30zEu/ZVP61cKke/RUjV4gYAbeU0a2okoKYHLEHm+rJLl7qoVzqpu0kgj1UayXuw11AVSfEeJGjo194HV7pV65Qq0byLudE3tXtKSgfJHC8cG7Ivs1YQ8b7b2ASfOB5X+ZQkbBB64BtLxjArfq6CsZmxPTAnC95vXu21Q5s1SGv6qBDo2udGWVsemEom+B3j9fxVwWwLQSthRp4OMmph2NPeEXI9S4Q9S8gGzOkOrIGo+sRdciy9bjWSz1dzoH4DVsQHjEDcJ6MsE7dHxo4cjjGm6S236hSCLHBAvDBqFHFApO18hsk/nC6q25k4XMYTp/DpQPB59bGsT2d9diR1udYsGCKenpqCVQdqqUfogaLUUrYbHS0Kef/z1C1XCynz4P8pigOkNtPTgOxdLiv/TZ0iw5X8s6/c0j893Y7RKyeuIff7FPfQjR3dOS1iyVESEYBUKnf+en1fGArkp4Cva3xLL39vQca7FN2eaAyu6xT7Sji4IEdDv0KaIDt/qIuFjhCJHoP3StuRIm6OnSE7gPZcNqFXrYbpaLCoHQLheaekj9G4VuajgINBfRSj3LguRPx2aprGXLJkLbJvdlenvw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594709b3-e6be-4281-f44d-08dd7bfb4ea6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:55:44.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sizRnp8YVCx4LeI8J3sMT/34TbOg2t1KvcAdidkepnZwZaYTTjmheHwVnJ159dwqnL1zTpHaY9s/K5iMeIWbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0747E8EB3
X-BESS-ID: 1744707346-105354-7689-24962-1
X-BESS-VER: 2019.1_20250414.2054
X-BESS-Apparent-Source-IP: 104.47.73.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaWliZAVgZQ0MLC0sLA0DTZzN
	DSPMXAOM3YxNQwxcgkLdEgOdnE3NRUqTYWALNF62VBAAAA
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263901 [from 
	cloudscan13-35.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status:1



On 4/15/25 04:27, Guang Yuan Wu wrote:
> 
> 
> ________________________________________
> From: Bernd Schubert
> Sent: Monday, April 14, 2025 10:32 PM
> To: Guang Yuan Wu; linux-fsdevel@vger.kernel.org
> Cc: mszeredi@redhat.com
> Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from multiple nodes
> 
> 
> On 4/10/25 10:21, Guang Yuan Wu wrote:
>>
>> Regards
>> Guang Yuan Wu
>>
>> ________________________________________
>> From: Bernd Schubert
>> Sent: Thursday, April 10, 2025 6:18 AM
>> To: Guang Yuan Wu; linux-fsdevel@vger.kernel.org
>> Cc: mszeredi@redhat.com
>> Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from multiple nodes
>>
>>
>> On 4/9/25 16:25, Guang Yuan Wu wrote:
>>>  fuse: fix race between concurrent setattrs from multiple nodes
>>>
>>>     When mounting a user-space filesystem on multiple clients, after
>>>     concurrent ->setattr() calls from different node, stale inode attributes
>>>     may be cached in some node.
>>>
>>>     This is caused by fuse_setattr() racing with fuse_reverse_inval_inode().
>>>
>>>     When filesystem server receives setattr request, the client node with
>>>     valid iattr cached will be required to update the fuse_inode's attr_version
>>>     and invalidate the cache by fuse_reverse_inval_inode(), and at the next
>>>     call to ->getattr() they will be fetched from user-space.
>>>
>>>     The race scenario is:
>>>       1. client-1 sends setattr (iattr-1) request to server
>>>       2. client-1 receives the reply from server
>>>       3. before client-1 updates iattr-1 to the cached attributes by
>>>          fuse_change_attributes_common(), server receives another setattr
>>>          (iattr-2) request from client-2
>>>       4. server requests client-1 to update the inode attr_version and
>>>          invalidate the cached iattr, and iattr-1 becomes staled
>>>       5. client-2 receives the reply from server, and caches iattr-2
>>>       6. continue with step 2, client-1 invokes fuse_change_attributes_common(),
>>>          and caches iattr-1
>>>
>>>     The issue has been observed from concurrent of chmod, chown, or truncate,
>>>     which all invoke ->setattr() call.
>>>
>>>     The solution is to use fuse_inode's attr_version to check whether the
>>>     attributes have been modified during the setattr request's lifetime. If so,
>>>     mark the attributes as stale after fuse_change_attributes_common().
>>>
>>>     Signed-off-by: Guang Yuan Wu <gwu@ddn.com>
>>> ---
>>>  fs/fuse/dir.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>>> index d58f96d1e9a2..df3a6c995dc6 100644
>>> --- a/fs/fuse/dir.c
>>> +++ b/fs/fuse/dir.c
>>> @@ -1889,6 +1889,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>>>         int err;
>>>         bool trust_local_cmtime = is_wb;
>>>         bool fault_blocked = false;
>>> +       bool invalidate_attr = false;
>>> +       u64 attr_version;
>>>
>>>         if (!fc->default_permissions)
>>>                 attr->ia_valid |= ATTR_FORCE;
>>> @@ -1973,6 +1975,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>>>                 if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
>>>                         inarg.valid |= FATTR_KILL_SUIDGID;
>>>         }
>>> +
>>> +       attr_version = fuse_get_attr_version(fm->fc);
>>>         fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
>>>         err = fuse_simple_request(fm, &args);
>>>         if (err) {
>>> @@ -1998,9 +2002,17 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>>>                 /* FIXME: clear I_DIRTY_SYNC? */
>>>         }
>>>
>>> +       if ((attr_version != 0 && fi->attr_version > attr_version) ||
>>> +               test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state))
>>> +               invalidate_attr = true;
>>> +
>>>         fuse_change_attributes_common(inode, &outarg.attr, NULL,
>>>                                       ATTR_TIMEOUT(&outarg),
>>>                                       fuse_get_cache_mask(inode), 0);
>>> +
>>> +       if (invalidate_attr)
>>> +               fuse_invalidate_attr(inode);
>>
>> Thank you, I think the idea is right. Just some questions.
>> I wonder if we need to set attributes at all, when just invaliding
>> them directly after? fuse_change_attributes_i() is just bailing out then?
>> Also, do we need to test for FUSE_I_SIZE_UNSTABLE here (truncate related,
>> I think) or is just testing for the attribute version enough.
> 
> <moved comments inline>
> 
>> Hi Bernd,
>> I think in such case, although outarg.attr (reply from server) is staled, 
>> but it is still valid attr (pass above fuse_invalid_attr() check).
>> set it and then mark it as stale, is for fsnotify_change() consideration
>> after ->setattr() returns, new attr value may be used and could cause
>> potential issue if not set it before ->setattr() returns. Sure, the value
>> may be staled and this should be checked by caller.
>>
>> Later, iattr data will be revalidated from the next ->getattr() call.
> 
>> Good point about fsnotify_change(), would you mind to add a comment about
>> that?
>> 
>> +       if ((attr_version != 0 && fi->attr_version > attr_version) ||
>> +               test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
>> +               /* Applying attributes, for example for fsnotify_change() */
>> +               invalidate_attr = true;
>> 
> Ack.
> 
>>
>>> I am unclear why FUSE_I_SIZE_UNSTABLE should be checked here, can you
>>> provide more detail ? Thanks.
> 
> 
>> The function itself is setting it on truncate - we can trust attributes
>> in that case. I think if we want to test for FUSE_I_SIZE_UNSTABLE, it 
>> should check for 
> 
>> if ((attr_version != 0 && fi->attr_version > attr_version) ||
>>     (test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) && !truncate))
> 
>> I though about this ...
>> Actually, FUSE_I_SIZE_UNSTABLE can be set concurrently, by truncate and other flow, and if the bit is ONLY set from truncate case, we can trust attributes, but other flow may set it as well.
> 
>> FUSE_I_SIZE_UNSTABLE could be expanded to FUSE_I_SIZE_UNSTABLE_TRUNC, FUSE_I_SIZE_UNSTABLE_COPY_FILE_RANGE, FUSE_I_SIZE_UNSTABLE_FALLOCATE ....
>> and then we can control this much precisely:
> 
> if ((attr_version != 0 && fi->attr_version > attr_version) ||
>     (test_bit(FUSE_I_SIZE_UNSTABLE_COPY_FILE_RANGE, &fi->state)) ||
>      (test_bit(FUSE_I_SIZE_UNSTABLE_FALLOCATE, &fi->state)) ...)

Better to have that in a different patch - makes review easier. Could
be follow-up or preparation. I tend to follow-up as splitting the
flag is an improvement, while the current patch is needed for
functionality.


Thanks,
Bernd


