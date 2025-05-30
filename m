Return-Path: <linux-fsdevel+bounces-50131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB9AC8659
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 04:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49700172BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F02A15A864;
	Fri, 30 May 2025 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="G3e/VUNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011045.outbound.protection.outlook.com [52.101.129.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9F2DCBE6;
	Fri, 30 May 2025 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573240; cv=fail; b=rfGfWOidLCEezg2kpymQ8bLjzpzcW06qyaboiU3Ti9cML9yswc3/ec4JLOU+msA2ZzlEZRbLCqgWxDBy/7k+lJ/e2OaHYnURx3YAogXnNGD2m6v+hFNZYv1HkY+t9EiD6hSj5SK952VG1tIYId5Ze/7P49n5T5oxHNxkgm3pVkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573240; c=relaxed/simple;
	bh=HUsCoWn3OwSThg4uQjAUxHUw4SlRMHkZmgSrxZlIJH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S3Cc+6HPtU+gj4fkyppsL7EMWOKIgKqpyWulGkeA/G4dtHerRWR4al4ooZ8TcdGj+OwwsrV53jAD8Rd69Uz2o7Nz3dbWcJewLNVKSRqMdb02NP6HcKo5kERIuGAUQCC0WT1HLFBex8nfeTLmI3Y7MZhI+YY+fTPWyzPThIQ3ksU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=G3e/VUNB; arc=fail smtp.client-ip=52.101.129.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oByEcpj5fEVGyLCCwP6RfpMVsU4lU/SjmbU5lmkqcT6FBMbQW514AzoZatksdsW+XPBareuxOP/OCmhwAteF76SuaIJxjtNmJR9RG8xDPQHhEC+H3Z/UtoBterTQW15lZAzJRHa/MO7W1CGB5wUeeVOTWDMAlOnVwuse19xpgb2PWk5iLG8NRUjr4ee1Np5eD870IsmRYeJ3DOPhanDNIxgDf07qomx6XMzyTmNHz9zGput/lJj+gV6TIYtydjQ62NY4OhQe4+uzdcEi9XV5AlYRdJ2YsuL9LWW0g/DYOiAr63xxi8I8q2tOKe5JdACrMZbBv5B+LaqkzDeCucs1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCiAlcjyIDUvbFVVqmcKfDzMFRshIc5YzdO4rMbs/kk=;
 b=nFxYb+R25cubmREJA8GgQWS+11oyE++uk0cAoFF9bifVv6wRkXegqY0dNvpVBtQnwyOcnwWvx47xyvPBv88Zcg8Xy1JgySi3D7JJwZyh2/Ck36PHDtRNomchuNk52ocGguBD5oMJzCAhk8xy2bGVGIfymasUw1nq1DmtMHe0g09PBI+QkRBwIEC3WOZmY29vguGFCcgt4UFpN18v/vl1AvXqBr7EpNML5FJuovprQqc7tOJbkN9zibdK+DXZdRcuyd7tDwGLD7BSShMlHzMAj4iPRYAbqdeNl/Pl+yQvd/CCmGOcdAylZ2TY2APZjTwhTPtyxW9oOEPRS3EdFXB0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCiAlcjyIDUvbFVVqmcKfDzMFRshIc5YzdO4rMbs/kk=;
 b=G3e/VUNBVax+oTfTTqGM2f51vzcuyA6295PlezdYQ8jVlWQE4ePPV3mtC4CPunX3BT3NcgHuQrYYoUR4ynddrrYgYpajSj2Vf1kUGSY8uuxrNt3DKy0Yirbb1GPp7Vj/Kq+mtWz0ZwOJGh8HyscvkCc/c+9QhOQ8mBrILUmPtT8UpGcsR3TVkDYsrUltUHIb6b7zNwbLQZegXpfHor4sEIlzukK3fVRFOpC1EZrIicpjjKHvCk4KG6rr3EqMwa7S8ujiyNNyjpe9sfnFg2lZKF33k1i5VtyNvMiVk3xEKzxgSVueXvexukL8XRyXtjPlZKbCNDex1ChfsO/5qCoiYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6060.apcprd06.prod.outlook.com (2603:1096:101:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 02:47:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 02:47:12 +0000
Message-ID: <73f8170c-0abd-4a54-80a4-ac98ab812cba@vivo.com>
Date: Fri, 30 May 2025 10:47:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfsplus: remove mutex_lock check in
 hfsplus_free_extents
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "ernesto.mnd.fernandez@gmail.com" <ernesto.mnd.fernandez@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com"
 <syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
References: <20250529061807.2213498-1-frank.li@vivo.com>
 <2f17f8d98232dec938bc9e7085a73921444cdb33.camel@ibm.com>
 <20250529183643.GM2023217@ZenIV>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250529183643.GM2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 16201caf-3721-4ff8-8e97-08dd9f244796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW9Vamd5Yk9vUm5EbTVTTG5BakFycHUycy9hcVoxWjl4Q1lHdmVMZWs4WkJi?=
 =?utf-8?B?cVR3K2JYOUI0cWtZUWtMYU1wcFFVb0czSy9wY3N4YytmTXc5Qk1DMEIyTlM4?=
 =?utf-8?B?WHZsMVpTSU5XS2JPcndjMnVCMDQ4OEtDdWFCUHZCRGdmUXNIa3BnSWNrR1Zo?=
 =?utf-8?B?dWhnRktDSm1CR0Y4SjZVelRvWUptUGEwV1ZnZWtQTzE0ZmtGQlNUVjB1dFZI?=
 =?utf-8?B?aTFtbkp2OVhteDFicUUraXd2QTRTZTYvN2JYdXFqUXFhekxabDBTMnc4R3VD?=
 =?utf-8?B?amxFbHpnQ0VGcVRrbEMvdWgzbU9Hd1VKb1VnWjBYSjdzYm5FNUZvS3R1endY?=
 =?utf-8?B?RkRrK3BCbGU0dmdQcm96cVRYM1VxemxNYVNGTFFoR2tHQVhLZXdzV3QzWWxV?=
 =?utf-8?B?cVNISUozNlZHV1N2Y2x0TnVCazR3c2RxOVJ3aVhvNzVlQzNTS2FsZEpaRUdl?=
 =?utf-8?B?cndxWTByOGI3RCswc0FRR2diRC9qM3JRTFkzSVh2YjNpTGN4NFlzZERXeUxJ?=
 =?utf-8?B?TFI5T3piZjY1Mk14VEU3a2l5ZGVmY3ZxTmpNb1JxSkxMWW5ianYyMkNYa3or?=
 =?utf-8?B?SlI2OHpRMzVKTUEzWVlLOVlnaGNvaVNyOS9lVUZ2bHVtTjAzTUdDanVCaktL?=
 =?utf-8?B?aXBaZWNUQWJ6S1NuNS8rdmxoOUFKem9UR3E4UThKL2ZyZ3VYSERsVHR4bmpz?=
 =?utf-8?B?Z0tDM1dLRnYzTkJqVWpjT1ZSSTN2U1pROUxkMjM4Y0IrZFRkY0JkRVdramRa?=
 =?utf-8?B?ckhXQWlBWWVRd1dJdWpmSmN2UERuRTJMeitDbVVYazlsTXdnbU1hK0ZtZHNQ?=
 =?utf-8?B?MkJSbjZPV3RjNSsvb1BzOWV4Y284MmJQOURUZkg3M25ibVY4amVCT2YwaGRT?=
 =?utf-8?B?clRsTnV4Uy9ac1ZqQTlOeWM5c2VFekFLOUUwWkt2WEd0OW5rVkM3UE8rcEFM?=
 =?utf-8?B?OVdaYmI4dk1vd1ZIL25WbnBKcDMvNjY3VDViKyt6cDFadTN4RmFvbW1iVURl?=
 =?utf-8?B?eERWeW9pUEU0REVTK2NCQlhtSnByNURWc0JMeEV6ZURNZStGOGdQWWorcWJ6?=
 =?utf-8?B?TXlmWm5XQnp3ZlZsNmFLK2E0KzZLUWhoVUpaa0EwTGdrMW52MzFtQlFoYVRs?=
 =?utf-8?B?L0RGMGhweDV4aUJCSWNOR1ppRmtJRmRUZ2FJM1c2Rmx4NE9EbWQ0ZDdwT0pF?=
 =?utf-8?B?d2w2b1VRQ2d6d1JFYkc3L3Y1QW04anNsV1o1QnY4b3dxRjZMd3gzY2RQaUlT?=
 =?utf-8?B?N3d6ekVLeUNLRG92SStiRGlUZTF5bEpoOGtCcER6MWNKd2swcUZDMkhRUUNI?=
 =?utf-8?B?L0JxSm5UNHBqRzgvcGp3WkNyNnhFOXVQOE9DVjVmeE5HbnFMNU1uWHFjYkE5?=
 =?utf-8?B?MTFIaGhjdW1tcnU4OFV0NGhpZlZJVHlWWUd4aWRlRFRueVNUT2UvbjdIV21x?=
 =?utf-8?B?VDY4Sm5NQ3I1NEdGSjB1WFdTYm5FTmdvT1U3Q2F4ZjRSb1JsNUVRQk1tN1A4?=
 =?utf-8?B?aWJickVMeFZ3bXU5bHpyMW42djdMQTFvUVRIRTgvd1FPTGc1Z0p3UjZZRTdQ?=
 =?utf-8?B?YTQwMTJQYnNpNGtYVTlIdWR2V3VsL3YxUFpLSDdVMFpMeDZDM0M3NmxPUUtR?=
 =?utf-8?B?Q2ppb3ZFcStjamV1RlRJQ2xTOXl3ckNCK3RWV3FraUp5UmJJZytmY0pOeDBn?=
 =?utf-8?B?ZkNkT3ZadU5FRUZlVDNMSUlxczQ5VnA3QnRKbUZ2b2lBTGRqbm5VcUppWnhW?=
 =?utf-8?B?THZLTkFIdnJxeFhJVDMxMFpPc0p5S3FodVBkcnVNNU5FMWVmTWpyeXFxS2w2?=
 =?utf-8?B?Q3pMNExjWGgyeDhYNlpHQ2gxOHFpSmoxRnJmOUF5VW02QWdvTTV0c3kzc2ZP?=
 =?utf-8?B?eDZpTXhSd1E1SlByRVJxeW02Z2o2L2lrczZ0eWJHZkwxYkE3MWJTVHAzL0cr?=
 =?utf-8?Q?X1Gqx/YZPOA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzc4QUkyK25IZFRGS3FZTXJjRmlOUUNsUWx4OWM2V25QYWZYa1c4cEVmaEdp?=
 =?utf-8?B?U0FnVStITkdTRXNQVTYxclcrdE1ycks3T2x2QlJTbEw2Qkx2VGpYQUUvK3ZS?=
 =?utf-8?B?UEZ6cm1wVHZ3T1A1OUJVV0RmUjl1TGpqNkRUZER3MnFnbjF1eW1FbjhQWHNR?=
 =?utf-8?B?TjIrb2FPbllaMnNqa2ZNT3l3OXBUMlY5RFVGaFNDRTk3T2EzS2lHck9CUDg1?=
 =?utf-8?B?Uk0yRURqN09iQVhzZGV1bkp3bTlBK2QzenFLT1Ezd0lzWXV4RWJkYTV4NVVC?=
 =?utf-8?B?R042VWdQL2tBSDlPQWx3UkVrbEdxbWtjMnFDTE5KcE14a0lkdWR5RkI4L0FN?=
 =?utf-8?B?Mzc3RFRPbklacEdnMFpVZWFyNUhKcTRvb2NycGhVTlFDNzZiN1pEU0pHM2kv?=
 =?utf-8?B?UFl0QWtGazltTnV2M0VVZjFuUEJtRlZUSmQ3VE41d3JCSTNISHNhMnM0VHNk?=
 =?utf-8?B?a3cwQVJKbXRpU1NFaDJyOHAyODEvZGNmdVFqZ2FHNkM5UThXVzdSQUpmY1M2?=
 =?utf-8?B?Uk9kSFJUWFAzK0pPdlRCMFJtVnRkM0lnditVK3pPMXU0NTYraE1FZTlSQU5P?=
 =?utf-8?B?QnE0Y1dmaXFuVVQwZDRuQXA2NXAyM2JNVFM5NENpZG1sZ1BoREh6czk3dWZ0?=
 =?utf-8?B?ODk2MXJSSHo4OEdydWZlYk8yL2NRNnVvRFJraStVRzU3ZWZjLy9zZjVNV0tN?=
 =?utf-8?B?SjlkMHBIYW9KNGVqTTFObkI2WExackZ6SzYwWDhMNFpRblVkWDVLVlFxNDVx?=
 =?utf-8?B?KzdocXRaNE4veTZ5UFd3NVBVQ1Z2dDlFOXB1K0syK2pRdjFTUHJpbXBMZmY2?=
 =?utf-8?B?OHh4dkY2K2tITzcyaU43c2xrZzFzTjk4UEk3WFhPaHVjSk1TYUdWYU4zYWxx?=
 =?utf-8?B?VUsrL1dlNjZtT25mamRHN0F0UUkrUk92RDM4eFlQUndaVGR1b0k1NDlOV1p2?=
 =?utf-8?B?Z2ppOGl4NnJBalpxaEc0OFp6OWQzaDI2WWtYeTlzRjRtMERjWDJna29pUWZX?=
 =?utf-8?B?akxJMmVzenE2Z0F2NDBZb1JtOHE4ay9BU3gwQnJLWEF1bEJaUHM0VXFqT1M3?=
 =?utf-8?B?UzlTMmttb0JTS0g3cXZieWdOZFpaaGMwREd3eTFtbEFCRHNHT25zSWZOSVJz?=
 =?utf-8?B?YkRIVk1uSkdJY3FlVDBNTG9KWDNNRHpLbDRxVVlVZ3doY3JKV1VQNHgvZlBV?=
 =?utf-8?B?aThXMHlTVURoMHh4L2JUTEYwSlRaMU55Y0NaQUkvTm5CMnVKUmFNNkZYNy9r?=
 =?utf-8?B?UElmL2hySTFTK1cwWnlmdE5ERnBSblRzQjBjeThKNkNXbGcwY2ZYRVdSWUpI?=
 =?utf-8?B?OUJ0TWpFOWFZNW1sMWNRdWZiNUxCMkhtbUFSV2dwL2VrRW1vTS9GWHp4U2F5?=
 =?utf-8?B?cnduKytmWmp6SXVOaHArRXljc2JMOHJVL2liV1ZnbCtyVUFGOE01Zy9lVHU0?=
 =?utf-8?B?YmFSUlRNMGJ2cTBDSW1sbGVxZXRHWHFUSE1YWGd3MWx1Y3M0QkZEL25ENnZE?=
 =?utf-8?B?enlwaGU0SVdLR3NXR2tJWkx6NkJNaFRZRWFPc0N4ckNOTTJxZklvcjZLMU9Q?=
 =?utf-8?B?dTBlZm1teUZISzlSeUg5cFFoeVVITHRFMjUrREJFYWhucUQ5UUZqdHpjR21w?=
 =?utf-8?B?cGh5SnpUcTE1U0Z6djZmMU00cWJDdGdJczdFWXV1VTJYc0IwMUF6RmoreHY4?=
 =?utf-8?B?Si9mNjFsMFJWZXhlL25VQmNwdzkwL1pvMXNKTUxrcFhReXpjckIyM1pXaXdG?=
 =?utf-8?B?OG5lQ0JsTE9uelR4eGJmRDQrLzRzZXJmcTZkZEtMaSsrNjRVY0lNVDlzVG5V?=
 =?utf-8?B?Z3RoMkdKdjcvRVMwRytieTRuZG9jOTZackR6RkpONEI2dGcycEViU0ZidHNL?=
 =?utf-8?B?QmxQanFLMGVzbjJaN0o3ajhkRXpxeXJGYXZDd1lBVnZIV3FvY1RId0RGMjFo?=
 =?utf-8?B?b1Jkdy9iaC9MN2YyYlJpVjhlUDM4UFNCeFpCbklIZHVPWitXM3JEWkc3ZXUy?=
 =?utf-8?B?U2ZLVEduZWpNdFYrOGtPQm9xdDg1b0JHbTFlVm1qVTZwZ1BBVjMwaVdmTm1z?=
 =?utf-8?B?amFwbURZU0pFQ1RUWWY0bk50RHJnalRnSkEwZzlNV2VycEc5aExYdjlvRkxV?=
 =?utf-8?Q?xmrhlMBXxOtNrnDZzypvfhEzt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16201caf-3721-4ff8-8e97-08dd9f244796
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 02:47:12.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K90qAWsbR1qDzouX/f6kg5opJCWmGVKsdIABVXikqeLhqQ+FVr7wKFy1BWMuMr3Oudgl7/6dB6/nAa+qPPwWhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6060

Hi,

BTW, I would like to ask for your opinion on [1] and vfs in rust.

[1] 
https://lore.kernel.org/all/7deb63a4-1f5f-4d6c-9ff4-0239464bd691@vivo.com/

MBR,
Yangtao

