Return-Path: <linux-fsdevel+bounces-20525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81CF8D4CEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13327B21D08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0625D17CA0C;
	Thu, 30 May 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ijtdwFRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00F17C232
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076323; cv=fail; b=rKQBxa86MkEWtqOWZEjKhCWbL+/cw2BEKxijhjilzh7xRWF716HVAKiXrvzpR1KolTPkE14/5poaxOVEHr/tubFa55On3pohC5Irdh7DxUOBC0PNpnfoNdhxbal94ifaQ7x5S5K6lOig2jpUjxvkZnxHT2Di0/8cf/30GQYzGJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076323; c=relaxed/simple;
	bh=pDAyI4lLmWB7Rfbn5gon+p2i4VT46Q758KuBh2NX39M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OklS/5QVGiFE+G/yqZzs7GKiIxoT1XYWQ55V7Mc2ptkCmW77xgG4M+vPHaU4N21BDIxCsrOP63chxF4FQI6+Q7FL84aUzFHT04dhW54AsPG8zXTC5g47IK/G+Mi/y1v//dm5RXWArSKu7yidz4bwJ4kBpr3la9Z+cAnp88MMmag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ijtdwFRp; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1G9I94Qr/0WSONj5BA8xVzYPyDnKdagpJEDzjNPOULIkI6CIF/3tqcTjf/iRyilcjRiHXudmfTwBNGDMvpKpCVTTSpOnDveA03RDiZJ3zLz1vUTNe0gWYRlEcYJHP0GWpY2sYByAAA2Z8DDjU7YMcFG9OQpcCCNYiYqZzSVOUjjxF3DX+UJer1Zl/tvXmI4jTxLI/m374fx6Cx5Qs03jbffPQVbg26PY42SDe8FgsFY31/4l69EZjYfRUZZd32H8DJWIbkRH/lx4p/utTcsms60xG4Fwq/cA1ruv0MVSjvJU1DRfMZruiqhKAL9XeGJC9c19Ohnjf2A8KyK/0AetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDAyI4lLmWB7Rfbn5gon+p2i4VT46Q758KuBh2NX39M=;
 b=heA/VnGrf+z6wlJjcpZS6LrjLDui++LVqPmf4L4xH3tk4+M5vBq1v/hrIYtHdRsHAzL8QDzSJHeHQslLF++UfQlua4ZF00YOxgoiNwbSyA6P9jHri3F+kJUw5A1G5hDrhS0Ls3kxVtKPUq+wYZ2D7gIPHYKqBT88hxoCYLw3iFT0uDkoH9/VhHWtfo5mQDqiQf3TjSEndzWRsMT2GDKRjcoWrxLtqTxSq3Lk1UV5dgMOQGw1Bl5t/CHKlX/y1lmzpL3lX197Y5HkD9TCatH/HYR7lWitBLqehDU7s67ustfZfT/PyVTHtrmahMMTLbY7GfAvBjq+sH9lxZ6S9eed9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDAyI4lLmWB7Rfbn5gon+p2i4VT46Q758KuBh2NX39M=;
 b=ijtdwFRpLpxVbAeSHO3+e24HLBQ36pbAJ7dDNDX3Z8/bUHJ4/dAv5l2G1g4YzJbqp19a8W04ThX0T9m68OCbURClCD1Qnc3ioOLBCC7I/PQI74NQpRo3bMqGx7nSfCxDwc3mKCKsunfAtAaBO4gXLEYlnieKs5HS4lpD8Rv4Jl3Y2pXDLIkvX3x56rZhf7DZNkD+G12uleWCAIVc7u4bLX1k8O3JY5ap3IpmLqdhxL2BjAJ6hx64vR4N3R8Nf5r7L+0UYlZIWOWsTxT5vcexpfmG8tJIuLjsdMb/5eHbpmtgfs0xvqT0aPxMAG2fbDM5kmthABygOZBP8A0GWOiTRw==
Received: from SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.35; Thu, 30 May
 2024 13:38:37 +0000
Received: from SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19]) by SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19%6]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 13:38:36 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "stefanha@redhat.com" <stefanha@redhat.com>, "mszeredi@redhat.com"
	<mszeredi@redhat.com>
CC: "vgoyal@redhat.com" <vgoyal@redhat.com>, "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Yoray Zack <yorayz@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
Thread-Topic: [PATCH] fuse: cleanup request queuing towards virtiofs
Thread-Index: AQHaseAyJXbKTYDmOEajcyxCKVzQkbGuiWGAgAFANAA=
Date: Thu, 30 May 2024 13:38:36 +0000
Message-ID: <bbdba78406b2288ee6a9132b1bdfcacd7b4fc37a.camel@nvidia.com>
References: <20240529155210.2543295-1-mszeredi@redhat.com>
	 <20240529183231.GC1203999@fedora.redhat.com>
In-Reply-To: <20240529183231.GC1203999@fedora.redhat.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7833:EE_|CYXPR12MB9426:EE_
x-ms-office365-filtering-correlation-id: 40120c61-6f07-4cfa-8988-08dc80adcee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXBqWlZ3NVk5Rnkrdlg3WFRWR1lYRE9MWW5YbFUxVldGVEt4cUVLMFlXUko4?=
 =?utf-8?B?V1NWeGNpNGtlR0s0M0VmODlzdU5wS3diVzc4R1N0UTlWNHZqQVRjNjZrTE5Z?=
 =?utf-8?B?M3A3Nlp6aXJydFZ6RzRDL25uR01DOWtudUFOdWJJOUtTQXJ4U3piWCtLc0JS?=
 =?utf-8?B?MWxaRHUvUHdsUUd2a0hYNEZxOUVndlFHZWNTL2JjRVJJY0Qvai9ML2R1SlV2?=
 =?utf-8?B?anJXajNaN1RBMEVWdEhaWVpUVCtpcXZmbWRCNFJZS0Z5NnpDUGlKbnZlRGIr?=
 =?utf-8?B?bFgwTXdJcXpqOTk3MkRCdDJJT2hmVkxrQk84VWpqMFV1bGpOeFBuUkpvK1Bk?=
 =?utf-8?B?c201d2VOd0kvUWNtbkFlbEllOElBZUxxeVlDN0V1Q0VpTWpLd0VXZm1kQ3Zx?=
 =?utf-8?B?V1pqWnF2cjdKMTBtNXI0TVVteGZZZ0xESitMWk53Tkl0Wm1HazQ0VE8vWUNa?=
 =?utf-8?B?aE9ub0l3bGNmcWJrcXJMUmJqR3dTdVZXM0lsekZlb0VvSzJod2dxWFQ2a1Jv?=
 =?utf-8?B?Q0FOZmZnd0tENFdVbnNaeXF1YjBqY2tiMjZ3cVRMa2FwRExISCtLT0dtMDl5?=
 =?utf-8?B?bjBzVDEzODh6TmgvY0ZMM2RLRkg2dVVadDgvbjZuaDZyNVdIaS9kQWV1cTRD?=
 =?utf-8?B?U0o0WEh4aThRSGZybm1QcUFwVkRwZzhiekxUaUFpZVBsV1lIVG1GSE1KaGNP?=
 =?utf-8?B?L3dZdHNQSUVjbTA5MGt1azNJd3N5Ullpb3ZPa0JNR2dtd004eklVaGZhcnJN?=
 =?utf-8?B?M0ZDMzZRcFB6OExCQ2FpOHZIdHVhUXd2cnRFU1JjS3VEK3BrbE9pR1NlMHBr?=
 =?utf-8?B?dWc5ZEZPTWlRTlNIcFlGK3p4V0p4NnpDY3FLVmFHSWQ1TUE1YkU1anFIR09D?=
 =?utf-8?B?cEtxc215c3l6ZklMVzVBdzRKNVZsYnZ2NXEweUo3ZzR3L3BydHgyS0xOV0NR?=
 =?utf-8?B?YXlRSGQ2eXhNMHZEeU1HUjZBMWwvSFZqT0dPeE94R3pBWEVOMHk1K1RyaGNj?=
 =?utf-8?B?ZWN1Y1VDeHlJN3d0OHJxcVlwZUhSS1E4ZDQzY2kvRHpZQlgrVEV6dnl1THI2?=
 =?utf-8?B?WEFHTUJlbFF5V2QvZHNRSjlUN1ZvcE45cFlmTWJ4Mnl4WUxqSDViTm9vOEVP?=
 =?utf-8?B?YUJ0bFd2SkdxM1dIQWZaREZWOWlyMmhGUndnZ0hWbGRNSmJaaEtPM2ljL0Ex?=
 =?utf-8?B?cVlvWTV4OU1HdGJKQzNoMzdXemFMMDZXd2pERk1mM2p5WHlNSlZBTy9QK2hr?=
 =?utf-8?B?OFViRGN0TGtSWm1sbzhxSUtmNE4vaVRRb0FqYlJQWWI3ZzRMeWNEbE9rMFNz?=
 =?utf-8?B?U0sxVWV5WlE2MStEd2EvUUVjMnhheFJONm9HZDNHTWl6NzBsaXRJcHhSZ2ky?=
 =?utf-8?B?WDlFeElscXdSYlhrdVBQWVNqK1JsSVZISkl3cmxFR3NOdzI5ODltOGxybDB2?=
 =?utf-8?B?d0ZTOGwzbFBlVTdaOFhRdlNWaE41amladjI2ai9xSGFFUVBNcjZxQkVJY25G?=
 =?utf-8?B?UTY5c0NRcXdjd0JTTG03RkJQUHU5aUJwLytiTmo5QTlRYWQycWFVdVNBdm5i?=
 =?utf-8?B?aXJVaGxNR3ZvUlNBUldhVEFsSTdpSk1FTStUNjN0bFllN2U4U3phSGs4bGpP?=
 =?utf-8?B?M3B6MjY1L1JtbC9kYkN1NjFzbVA4ZkRJYmwxTG51VTNVb2tMbnVyNm5lcGRE?=
 =?utf-8?B?SmtMUFdMdHpKcmlxTzl5NFJ5T0ZnV1RQL2ZGZnFYMXJoN01JZFRkVzdPVjFH?=
 =?utf-8?B?azY1bU0zWUlOTFYvc2VXSEtJVEM1ZWRLQjZIdC95c2tCd0E3VGowZkhTdUFI?=
 =?utf-8?B?elRib0RUVHoxaE1uYkJIdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7833.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXdITWNxSDhYWXRTQWpITTQvRkk4UnY4TlpLWktnak5pY0NSTUlvelVXdi9I?=
 =?utf-8?B?Q2JlRXA0WE0zL1FNbit5QnpmcnUwdkhuYUNSYjh4eVo3Q1RmRC8ya3hFYkw2?=
 =?utf-8?B?SkhrMDkvSkd2ZnlpM2p4M1BxM2VsamRvclA3QS9MclhreitQL3M5U3pXYWtx?=
 =?utf-8?B?dEQ3R0xXVEdtQVpTSW5rbFRCQzViYm5aMXMwbkhOUStQUXR6NG43bHVYWWJ1?=
 =?utf-8?B?SW8wM3g1c1JKbXFMSTVINHB2a1NEVllSTHBhMmdISDlITUUzUEs1UEdHNVZs?=
 =?utf-8?B?dHZBS0RLZFRDdGpSQ2Z4N2kwN1RzYmFsNWQxeUFBSWYwNWJiTVhDWUZhWThB?=
 =?utf-8?B?a0R4UXJaaFN3WE1LTlZoWWowQ3MzQkp6cVZiajFwQ25RbTZxQTR0enhIUld0?=
 =?utf-8?B?VkFvRi9vNk9acnR3VWQxQjdCcW41eCtpdXZMdlRlbkxPZjNmNHpnOVZyWWFH?=
 =?utf-8?B?UzVTblA1ckxMdmJRbWgzWnJTWlVWclRPRDNxMFpKSE12WHF5cUJZZkJxbFZ1?=
 =?utf-8?B?ZmM3eUVuOWFIY25kekI0MDk5VHFtU2FvVVBMNFpNaUdadUJxdlZUTlkzU0U1?=
 =?utf-8?B?ZHpTVkV2bkg2cmFycEUvazJPOXRGZ29HTmJxdWl2SmNIMUlxY2F0Q0V4UzB1?=
 =?utf-8?B?SXV1K3BrRERPTVNGNkxoUVNmcXZXR3RqcnErM0E4djJ1eHY0NndUbmpzcGFW?=
 =?utf-8?B?S21KVkJ4aHdGU2piVGt0MVZvSFJGeUlxZ2dVSmFHdXFpRUJRSHF1TFNnMVJN?=
 =?utf-8?B?eFhuWE12Ny82b1BLcG4wV0RzaDVVMlh2NGp3MXlrZTlQV2FFQ1JzRS80eENR?=
 =?utf-8?B?REtRQ0hXaHd5TmxMeDRtL3EyVXZMMFVnRDFMMDNPZ3EyRVY3QTJYYnVBait5?=
 =?utf-8?B?UHBWa3pEUnJnNml1VHhOcXBEYkRZbzlTdzlnYXhkbzBpRm9yb3hzSkR4ZVNr?=
 =?utf-8?B?TXEyUXp0QW9KMCszenRDV1Rmb0htczR2NEZ1Z1BOK2poYlRjak5WVlc3bkx1?=
 =?utf-8?B?N1gzeXJpVkJUcmsrSURYVmpGQTNDSCs0M3VmZHYzYW1NNWpQam1NdEZ5c2RO?=
 =?utf-8?B?TFlNdlFFMjNtWlhnSFlkSUhjTklxV1RBSHJMdEJkdDc2bDZkMzh5NmtyRFl1?=
 =?utf-8?B?NVAzb3RONk56ZWRnS1doN3VUZ1ppbGVDQzNSMjVkVFBBcmpEYmpmMlVGVXZW?=
 =?utf-8?B?ZkRxakN3YllEME5Kd0k4NTh0UUZZSVhmblFrQTdsb3JzTm5vN1RDWXhmNXkz?=
 =?utf-8?B?ZmQzYmMreGVDVStOWnMyQkxjVVJ6djJMT1dsSXNiV2FqVGkrL0RzYldpU29N?=
 =?utf-8?B?U2ZydEVBQS9NMWNGa0w3L3R0cTIwcUUxRVZBUTFpZk1jOUJlZllPWEVPcWZM?=
 =?utf-8?B?R05FSEV6UTdyQ1NvRVFuZk1CRE9LSUJETDN2RCsvMy9vS2hHaFlkNWhaYjlY?=
 =?utf-8?B?QXVUTVRnVWxJNGs4UzJhYzRpL3N0Rmk5ODkzVVpLK2w2eko0SEtCT3dMLy83?=
 =?utf-8?B?ams2NEpZN3p6NmhBdGowUlRleTN0dFErYWFGNW9hREs1TFZzNkhvT3VldjRv?=
 =?utf-8?B?bjluMzAwZExRM2l5S1ZRMHQ2cDdvVHdDMVM5akZneStHZWV4RU10R2t6ZUJH?=
 =?utf-8?B?b0ZWQUhyTmZaVEVUeVAyeDBwUFkveG5YS1RuNElsREgyM0lYOXNRRmVkUUxZ?=
 =?utf-8?B?ODIwWnNneDdIeWFhS1drQndnbzRPREdjNzhtV1NkbkRLMnVOcjVwRlhpbVhh?=
 =?utf-8?B?UUdhREZjRWN3YjcyN2gxazdmVS9GYXhZdzd4ZlNKS1dabW5DSUV6M2lPQzgy?=
 =?utf-8?B?WWhRbU5QeDF6TXR0MENZTTJTMDdSdXZicFBMcVREck5VaTIwLzJ6SDVIaFVo?=
 =?utf-8?B?Y0twVTV6a2VZQ0tpajRBSmdtRVp2NysxejE5WlFzNnIxNjhmaS9vUk5meXVu?=
 =?utf-8?B?UExHcEYrUzMxZkVHUm9GWklQVk5hUzJKbjRwTG1Wb3ZFNXpSdm1kbUdVWW8v?=
 =?utf-8?B?ZGl2SFU5cy9PY2ZsRHJUWThVazB0aUlzVU5GQXBWaU1SSjdsbVVRZTVXb2Qr?=
 =?utf-8?B?Nlk3dkN4ekgwUUdmd2lET25Bd21uWG9RU0RuTDFKdlg3UFhhQ2ZMWXJJYUtk?=
 =?utf-8?Q?MKiS4C4iFgc/7BIiPJpXAmrD5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2248F98B67F33C4B8B77238CDFA89490@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40120c61-6f07-4cfa-8988-08dc80adcee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 13:38:36.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hm8qng4tjphpQCkOF92GVQOysRA8uDalzcZ+HxmNFAc36vjuLMi3mW6gZUJJTrSlv+YBoJKvO+us5wMJSHagkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

T24gV2VkLCAyMDI0LTA1LTI5IGF0IDE0OjMyIC0wNDAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIFdlZCwgTWF5IDI5LCAyMDI0IGF0IDA1OjUyOjA3UE0gKzAyMDAsIE1pa2xvcyBTemVy
ZWRpIHdyb3RlOg0KPiA+IFZpcnRpb2ZzIGhhcyBpdHMgb3duIHF1ZWluZyBtZWNoYW5pc20sIGJ1
dCBzdGlsbCByZXF1ZXN0cyBhcmUgZmlyc3QNCj4gPiBxdWV1ZWQNCj4gPiBvbiBmaXEtPnBlbmRp
bmcgdG8gYmUgaW1tZWRpYXRlbHkgZGVxdWV1ZWQgYW5kIHF1ZXVlZCBvbnRvIHRoZQ0KPiA+IHZp
cnRpbw0KPiA+IHF1ZXVlLg0KPiA+IA0KPiA+IFRoZSBxdWV1aW5nIG9uIGZpcS0+cGVuZGluZyBp
cyB1bm5lY2Vzc2FyeSBhbmQgbWlnaHQgZXZlbiBoYXZlIHNvbWUNCj4gPiBwZXJmb3JtYW5jZSBp
bXBhY3QgZHVlIHRvIGJlaW5nIGEgY29udGVudGlvbiBwb2ludC4NCj4gPiANCj4gPiBGb3JnZXQg
cmVxdWVzdHMgYXJlIGhhbmRsZWQgc2ltaWxhcmx5Lg0KPiA+IA0KPiA+IE1vdmUgdGhlIHF1ZXVp
bmcgb2YgcmVxdWVzdHMgYW5kIGZvcmdldHMgaW50byB0aGUgZmlxLT5vcHMtPiouDQo+ID4gZnVz
ZV9pcXVldWVfb3BzIGFyZSByZW5hbWVkIHRvIHJlZmxlY3QgdGhlIG5ldyBzZW1hbnRpY3MuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5j
b20+DQo+ID4gLS0tDQo+ID4gwqBmcy9mdXNlL2Rldi5jwqDCoMKgwqDCoMKgIHwgMTU5ICsrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0tDQo+ID4gwqBmcy9m
dXNlL2Z1c2VfaS5owqDCoMKgIHzCoCAxOSArKy0tLS0NCj4gPiDCoGZzL2Z1c2UvdmlydGlvX2Zz
LmMgfMKgIDQxICsrKystLS0tLS0tLQ0KPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMDYgaW5zZXJ0
aW9ucygrKSwgMTEzIGRlbGV0aW9ucygtKQ0KPiANCj4gVGhpcyBpcyBhIGxpdHRsZSBzY2FyeSBi
dXQgSSBjYW4ndCB0aGluayBvZiBhIHNjZW5hcmlvIHdoZXJlIGRpcmVjdGx5DQo+IGRpc3BhdGNo
aW5nIHJlcXVlc3RzIHRvIHZpcnRxdWV1ZXMgaXMgYSBwcm9ibGVtLg0KPiANCj4gSXMgdGhlcmUg
c29tZW9uZSB3aG8gY2FuIHJ1biBzaW5nbGUgYW5kIG11bHRpcXVldWUgdmlydGlvZnMNCj4gcGVy
Zm9ybWFuY2UNCj4gYmVuY2htYXJrcz8NCg0KWWVzIHdlIGNhbiBwcm92aWRlIHRoYXQgd2l0aCBv
dXIgQmx1ZUZpZWxkIERQVSBzZXR1cC4gSSB3aWxsIHJldmlldywNCnRlc3QgYW5kIHBlcmZvcm0g
c29tZSBleHBlcmltZW50cyBvbiB0aGUgcGF0Y2ggYW5kIGdldCBiYWNrIHRvIHlvdSBhbGwNCm9u
IHRoaXMgd2l0aCBzb21lIG51bWJlcnMuDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQoNCi0gUGV0ZXItSmFuDQoNCg==

