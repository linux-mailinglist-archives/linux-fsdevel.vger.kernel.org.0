Return-Path: <linux-fsdevel+bounces-54329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF58AFDF07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 07:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADBF585634
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 05:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6CE269D11;
	Wed,  9 Jul 2025 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C9Qji9qJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012020.outbound.protection.outlook.com [52.101.126.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E426771B
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037835; cv=fail; b=rF9wVrXDuviuU5kgLZ0iiQC8Y71fLDXmH0jOKI+Kyp2v6XeUC5A97vzTw9ClJtoHdGgcmWSuGOhs/UGTuXKHZbStKPu8nz8pD0G2NEA7P8aSUuyHsPk/XSz5nem5QAwGDBIHWyW5CmJ2++YeWW9HhxBgqDLA4NkuTz6ynJuBAkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037835; c=relaxed/simple;
	bh=ATeYK09MVM9IYyOB76XpPEjfizdhBWoGQIRmn9AdEnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hlnSRPgUaoPk6UgxUO3BHzPS80jxKInhGGGg+40fLf72vOqejNjUCz/A+cTz5z3rkYfT/JktiloRFBsQsZgZ888FkuQEetPRohj3knfffpdZiRbrI4JN9Xh5xXXu2eicPi6kidVOUcGx6YACBhuDU3khymV0cgdr8JUVDHKeXk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C9Qji9qJ; arc=fail smtp.client-ip=52.101.126.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBPkbwuApmyDEvvQe8pAaWJgoX0ey3S2phnP27KMmnVJwFqOdc1/gx/2NV0ucpPtnYs0EFQS1anreS7BTBICKRqLJbBu0tswXltA+DYotOXyPZ2OV4+h1OgRcAZnStPuvkibEgi1YfxW7g0xLkeZe6VG+RP+1fa16CcMJ2VS0XBg5T9Q4QlKA7fCRJ3Igqp6Q1ID6r0TXuSSGKHWsw7LvdpcHs0qurq7KhZMN04fd6596oRFHJ6pEtAsW//d8vEu9F8aJ2LA6RmNEbhW51B1fIpjxTIbpb1Z/w/QkyI1vY3CUe5waqmquYPxS3Rs7815pGUQF5DTzvCdKBfruBGhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jqZZqDZTRDQcbOiGUjhnOYjlby0UnUvBcGsJyBH1s4=;
 b=ElGC/KjdFJ4krkRp3OTfyBk/R02oBrg0JKY7jvBPx0wQRwYjuatinOz/xYIWBdAqiUwfhhIoN2tx0xUrxmc286dUK4bRXov+6w0z5fzXKQxlwKn0aLkQAKhsOJmTozUzzAE9X2+b7fsRO7pPCUkVkGckQVZe7Ax88Lybcfh+bYScQEo5rwd3zKwwy33k84fmfX130XalGPuiWGz6sydBAbKHJY6bThNd85ZPXfYRC7OJkeJeSBecm4Oy0hpqVf9gcReXw0/MDKLjXTdZlKWVJrw516JCpUsXEvP6E3wQQVyv206jHQD7i/TA2cpkfd5ZtFKgNKX5VyEH3KXBGxg/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jqZZqDZTRDQcbOiGUjhnOYjlby0UnUvBcGsJyBH1s4=;
 b=C9Qji9qJMH+I/5yTdVpEgM4vJ4Nm9TwX+HNrUwNwVLCqfSMgMnJ4HIy0xWJ29Of5CDZTY4DP5rdMSAk3TOaq4C0NEJXjh9ZKvndqTyjbiAZRHXSvZxzww85jrCyKIa608iMxjWHNEExdycTfZ6CHoAac4tXaE5rHPH+Bjeb5A2QEyiCKx9+dY1MDn9p+H7M7k4Gh2HiuV90xxOXSKmR1j/uiT8PwAQZ9FHICD6smMY95EawlVlgGh6Cbbj/dCB749pe83HLNkW4RLESkMakmEgyCnWCwWCVA7ekHiPQ+GPk8SkLnwnjiyq4WjfKkU/cW2gH5Eha5Jf7Ze0pp/V2DdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by KL1PR06MB5881.apcprd06.prod.outlook.com (2603:1096:820:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 05:10:27 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::6257:d19:a671:f4f1]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::6257:d19:a671:f4f1%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:10:26 +0000
Message-ID: <29d9127f-037b-46fe-8616-89d3526b64ae@vivo.com>
Date: Wed, 9 Jul 2025 13:10:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org, wenzhi.wang@uwaterloo.ca
Cc: Slava.Dubeyko@ibm.com
References: <20250703184150.239589-1-slava@dubeyko.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250703184150.239589-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|KL1PR06MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: c05b8b10-f1e5-454f-3e49-08ddbea6ea4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDFkbnJSbnRTWGM0Nit1V1NQTGRIdGNQUlBJeUtCVXFyRG9PVTVMMG83alZa?=
 =?utf-8?B?RHRBL2ZFeFo2Y0dKTDVsV05BTWRtWGtxVkhId3lmUlFtWEtTSUEwNXh2SmR4?=
 =?utf-8?B?Zk1wWXgrS3RtaWJWakxuempmVExBckJhMzJ6U3djLzdFK21uSGxlUFM2YVJ4?=
 =?utf-8?B?UVRFekkyMWhZWVpXZGNpQXVCY0lSN0J6MnZRUHBYenQyN0VVV3R0WUpqZXpW?=
 =?utf-8?B?OVJ3ZjN0SDdUSnlMTFhSM2pLcmJsS04yNEFDTStvM09SOUNyOVhQQXR1djZ5?=
 =?utf-8?B?QXYzRVdsVlFuS3BBNkhBdU1qQ1BKL1AzdXdiWmhMc0JKZ25EYTJjSkZqaG5i?=
 =?utf-8?B?amJzZG93d1JpMDZscTFZOFdhdUxURG9KYkNNTVhhU3U1YWZFRm15eDNkNDdy?=
 =?utf-8?B?RC9rR3o4TkZNWjN5OXRMUlM2aTBZMHdtSVNHZTdPajJlMjEwL3NrM09ra1lE?=
 =?utf-8?B?emllRlpLZWZBUjlxaThFSkJVZE9ZeG94aFVudkEyRzlwYmtOMEc0K2JQa3lw?=
 =?utf-8?B?YzJNL3MwSE0vR0t6dFRaQmRWR2pSNDlpalM0YUFjek9NT1lUazFqZGlUWWNt?=
 =?utf-8?B?UkJneTVMZVE0UU1IUXJxdEUyUGM0SGlFbDUwdWpmTGpsTmdWaEI3WjBYYXN3?=
 =?utf-8?B?ZFVFVkM0R0kyeGtqZDFhcFhxWmdJM0pDTWwydU92WCtGNUNvdUx3Q0c5TVpN?=
 =?utf-8?B?Q0NWc0d2WlpmTWphdmpuQTJuUmlkTnQrK2JhbGU4MkdseXkrZVI1YlgvSmxa?=
 =?utf-8?B?L2pWYU5JQ3lwaFphN05zT0V5ZmxYcXArQ3FaVFFuMFFMVldwMHI4QWdUaCtB?=
 =?utf-8?B?dk5sOFhzZ09yZ091TVp2N3A4ZW5taUVvV2RpUHBERjg0ejdhSGNqdEFPRE9v?=
 =?utf-8?B?V2NwMEN6ZTRyOVExcHJ0NjNSTFVnanpJZ0dRYnU1M2hLOTZKc0FqeVdFMVRY?=
 =?utf-8?B?RkoyMTBhOXgxTlNwZVJPbGxTM3Y0c2M4YTlaVzN2eEkrc0ErR05pK2d5SkN4?=
 =?utf-8?B?YzZGQk0wQWxIblhsMXlGSXEzVTFnUTZ3a2NEZG5PaEZrUVI0YjhBcXU1ZEVj?=
 =?utf-8?B?cldLa0JlTTc2U0RVMG1yWDFaU1pXWjN6Zlp4dzU0UnlnMUZMYU9IMGJVNUFi?=
 =?utf-8?B?OFNEekJyaDlhSk9PUUJxbm10QTcwYTJIeGIvNjZsNlFkT1NUZHhDOHp5WDZQ?=
 =?utf-8?B?Y3Q1Wkx6M1RoWFVMTXRlaXVVMUIvbmVBaUJGT2dXNlpWYmFjcENpSFpZR2xu?=
 =?utf-8?B?SndOdmN1clcxWkkzRTVXWkxVWnB2em1SRU42OHd2Mm5PblYxVm03WlpRaHgv?=
 =?utf-8?B?TEJUTWM1R1N0Z2NLMXZLL0EyeEFlSytpTHIxUm5oRVB0Q09HTjlNWDJVNEE4?=
 =?utf-8?B?N1ByUGxuTkxYTGV2dm5Td0NseHNJV0VCZE0zemJyOHdpSkd3QXVYOEhiZmNP?=
 =?utf-8?B?S1ZiY095MytZV0sxUVdvSXltb3F3SHMrbjNHS0F5ZUJjM25tQmRUSzZkMFFx?=
 =?utf-8?B?cFgvWGZqY0Fwb083S0dqTmZ6dUFlWDhvYlJaalBzemlWcXA4TUw2Mkxsdno3?=
 =?utf-8?B?emgycGpUOVdaNTExZ25Ka3ZZMTBhckxwUlBDaTRTMjZaaCtGZDN5cmoxRDN2?=
 =?utf-8?B?QmlGdjdLZzJibk5pQk1oSWcya09lU204QTRpdTYrUi9VMFF5UVZMbDNsR1l1?=
 =?utf-8?B?T1VER0ZlWW5mVnZGQll3NDlSUGpXejV5QUJzUExyamh2NFhUL2NDSXhxSndL?=
 =?utf-8?B?TUd6T3RXcHhibzI1NGhCMlNVbDVQRTBraEMvZURjQ1h6T1hpMTZ4RlpmL3Aw?=
 =?utf-8?Q?8LZgkyFmDFOHfF3v2kn3l75w+YMMq5Rbil4VE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2ZFSzNrcWlNUGdMLzJYeTd2RFE4S2s3ZS9veVFiOG8vdm50eGdjOWFaTnM4?=
 =?utf-8?B?c01rN0VEVlpIbW80aW0yTHZpSXJ0NXpHVC9CVXUxb05IZVZxS1lROFlNVmtj?=
 =?utf-8?B?OXc5d2ErQU5yL0JLOGNWQStuc3JSU21RR2pqK1UzK2lpN2c5N3QwNkZWR0xQ?=
 =?utf-8?B?dHdCUWRRRTdmM0RRdnEyUC9teVl3ZFhxSnluWXVBU2xUZi8rdVlmMU5nVnoz?=
 =?utf-8?B?ZjVLY2w2cjdLcU5PWWJReDdtMy9TeHpITGpNSEpUaTdYdGpuOHR6cjhIcmhK?=
 =?utf-8?B?bW9VUWpBai9aTFVZYTN1Z29NU2hoRnlOakhmL1ptVjRrZG5XUHhIOEw2Q1N4?=
 =?utf-8?B?MlFoK2I1dXFvVWZOWHlhSEx4U2dRYzAveDJ3SG1vYnJHbSticS9keVMvbjNF?=
 =?utf-8?B?MUI3UHBYeW54VW9FT2pKaktscFplTncyUGZJZXNSWkF0aHBXNWZKWmdsRmNj?=
 =?utf-8?B?eGl3eTV4UWZIMVJZTm10VkltL1A5YUZ3YWNubUMxNE1HekxTZjNOZGZ4eHJM?=
 =?utf-8?B?V3BiYm9aTk1qK0x0bTFMRERxbkJKT05FMmxldUVMNERtdTJtOGgxZk1FdWVQ?=
 =?utf-8?B?cUxJYTMzNWRMZDBQMVhJL25EaFBLeVR0ZHdQT3dDRmFxa2o4ZTg5eW80bkhV?=
 =?utf-8?B?NUdyNjlRSDVQcDlGTHR2anRCams0N0t0ZzUwdm1nOGg5WnNQU3lKdDVGRXp4?=
 =?utf-8?B?Uk0vNG5JTFlsa3lHb2lnbDdQLzc4Uk54MFZiNk5nVzc1bmFQSnhUdkkyQUNw?=
 =?utf-8?B?QUYzVS80QWdKS1kzUVNLdXdUZnNIc1kweS9uN3dPTlM5SFNsU25CalowZEJP?=
 =?utf-8?B?UWJPcEg4TFRpZERQZmN5NnYyNDdQYS9PaC9XMk5qRXBKdjZqN0Q5elJWTXFw?=
 =?utf-8?B?RDlkanZNQlVNYVVzOEdxTW5ocDVXNXZveVU3R3h1Q3NYcnEvMkxqRk1QYnJS?=
 =?utf-8?B?YTk4VFp6M0xDeUE4OFl4YlE3OEVFaUtiOXJSVmJqQTNWVythaEllYkI2RnVh?=
 =?utf-8?B?bTNybEsySVN6NkNPOFV4ZkVCNDE3bzdTWjJDQ2M3SWUvTnhSOVRoTFlteEVt?=
 =?utf-8?B?YWxmdzdGMGlDaHZOZ3kvcFZXSjBLRVZQN3dyWTZRTTFWOXlreStXeHcvM0d5?=
 =?utf-8?B?R1J5MHpCdWVKbmdya2J2cnV5YzJPdG9wNjhqUUF5K0hNTXpoTTNiZUZLdjJL?=
 =?utf-8?B?djIwalEvZHgvNzBMMVNMNng4QW8vd2xiM24rTWxFemFuRWdjUEE2MXpZRmVE?=
 =?utf-8?B?WmtvOFlVYkJZTXVFNGQ0MWRlaG1tMUtkVWlPUmc3RnZQVHY1Qm5tNVU4d0VP?=
 =?utf-8?B?enpCWWt6MXE4QWZrQ1lWYzlvQXEwRlhhMnhTWTVTc2JMVjJ4MWcxR29DSnV3?=
 =?utf-8?B?cFFQOUtyUml3a2ZvZXdYM0NVQ2NkUTZmcjNWUjlFSU9MTFhwdUVkSmQ0enlu?=
 =?utf-8?B?cVF2c2l4R1VMYlZuRmRWK1BEcVBaNzdDMVplcExWWGVmcHhmTk5NSXlFT2tN?=
 =?utf-8?B?azlUYkhJZFBVVU45Qm5iMzNMdkRsc0xlZ2JZeVloQmdmNXF3cW5oSFhVM1BD?=
 =?utf-8?B?YWx0NndOYmZ4MytrbzVFcVk4cFZtdXlFUUdoQXQwWWMza0F6ODVrT0tBM1M5?=
 =?utf-8?B?VjA5MFVZRk1lYWd5MXdTRWVxeWJPTHZDWVQ2L0dVQ09PL2tLaFRMWnFabVpU?=
 =?utf-8?B?SnJiajFkNzFkb2hndXlFT3hBcVFGVzAyeHB4bXpTb0czMHN6OHI3SjBLM0do?=
 =?utf-8?B?VFFuTEZFbStzdEJwcDRhZjY3TXlrbU1rZUhMN3JoR1g2ajBXTjN3dlhEclhS?=
 =?utf-8?B?OXRiMlhZRGNCYVhueEpOcUplVi8wS0Y0cTNxeXh4RkU0TmNXVnFDZCtOaWwv?=
 =?utf-8?B?LzFCWGtrWUZYcXV0aEtTZUZSU0lOTHlHV0dwOXZvZFEzSUZyaVNhak9yaVNm?=
 =?utf-8?B?ZS9YYUlEUUFqcXhGai9EbUN5K2hVSlhOYk96UHFmVjhJY2RvWk1KTFRVNk1R?=
 =?utf-8?B?ekhzRE5pbzZ4a3FwK3BWZGVkd1Nrc3F4WjFzbkJGL3J0eHZPNnpWZnAwcm5o?=
 =?utf-8?B?ZG1RLzJMbG5QYU52OUh1VU1OTlRSWkVlWEowY2tGcVBabW9NVmRMeVUxdW85?=
 =?utf-8?Q?SewqkVbnbbEvOdVtyb+axaFOA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05b8b10-f1e5-454f-3e49-08ddbea6ea4d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 05:10:26.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lf2yNHsesu/PzyQThjIxADPh5cSnf+dB+paxePBoXaRlBEVFJtfywnIQIPwIXFUKJ2UQ8KAaZLpRssgPSlcdWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5881

Hi Slava,

在 2025/7/4 02:41, Viacheslav Dubeyko 写道:
> The hfsplus_readdir() method is capable to crash by calling
> hfsplus_uni2asc():
> 
> [  667.121659][ T9805] ==================================================================
> [  667.122651][ T9805] BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0x902/0xa10
> [  667.123627][ T9805] Read of size 2 at addr ffff88802592f40c by task repro/9805
> [  667.124578][ T9805]
> [  667.124876][ T9805] CPU: 3 UID: 0 PID: 9805 Comm: repro Not tainted 6.16.0-rc3 #1 PREEMPT(full)
> [  667.124886][ T9805] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  667.124890][ T9805] Call Trace:
> [  667.124893][ T9805]  <TASK>
> [  667.124896][ T9805]  dump_stack_lvl+0x10e/0x1f0
> [  667.124911][ T9805]  print_report+0xd0/0x660
> [  667.124920][ T9805]  ? __virt_addr_valid+0x81/0x610
> [  667.124928][ T9805]  ? __phys_addr+0xe8/0x180
> [  667.124934][ T9805]  ? hfsplus_uni2asc+0x902/0xa10
> [  667.124942][ T9805]  kasan_report+0xc6/0x100
> [  667.124950][ T9805]  ? hfsplus_uni2asc+0x902/0xa10
> [  667.124959][ T9805]  hfsplus_uni2asc+0x902/0xa10
> [  667.124966][ T9805]  ? hfsplus_bnode_read+0x14b/0x360
> [  667.124974][ T9805]  hfsplus_readdir+0x845/0xfc0
> [  667.124984][ T9805]  ? __pfx_hfsplus_readdir+0x10/0x10
> [  667.124994][ T9805]  ? stack_trace_save+0x8e/0xc0
> [  667.125008][ T9805]  ? iterate_dir+0x18b/0xb20
> [  667.125015][ T9805]  ? trace_lock_acquire+0x85/0xd0
> [  667.125022][ T9805]  ? lock_acquire+0x30/0x80
> [  667.125029][ T9805]  ? iterate_dir+0x18b/0xb20
> [  667.125037][ T9805]  ? down_read_killable+0x1ed/0x4c0
> [  667.125044][ T9805]  ? putname+0x154/0x1a0
> [  667.125051][ T9805]  ? __pfx_down_read_killable+0x10/0x10
> [  667.125058][ T9805]  ? apparmor_file_permission+0x239/0x3e0
> [  667.125069][ T9805]  iterate_dir+0x296/0xb20
> [  667.125076][ T9805]  __x64_sys_getdents64+0x13c/0x2c0
> [  667.125084][ T9805]  ? __pfx___x64_sys_getdents64+0x10/0x10
> [  667.125091][ T9805]  ? __x64_sys_openat+0x141/0x200
> [  667.125126][ T9805]  ? __pfx_filldir64+0x10/0x10
> [  667.125134][ T9805]  ? do_user_addr_fault+0x7fe/0x12f0
> [  667.125143][ T9805]  do_syscall_64+0xc9/0x480
> [  667.125151][ T9805]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  667.125158][ T9805] RIP: 0033:0x7fa8753b2fc9
> [  667.125164][ T9805] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 48
> [  667.125172][ T9805] RSP: 002b:00007ffe96f8e0f8 EFLAGS: 00000217 ORIG_RAX: 00000000000000d9
> [  667.125181][ T9805] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa8753b2fc9
> [  667.125185][ T9805] RDX: 0000000000000400 RSI: 00002000000063c0 RDI: 0000000000000004
> [  667.125190][ T9805] RBP: 00007ffe96f8e110 R08: 00007ffe96f8e110 R09: 00007ffe96f8e110
> [  667.125195][ T9805] R10: 0000000000000000 R11: 0000000000000217 R12: 0000556b1e3b4260
> [  667.125199][ T9805] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  667.125207][ T9805]  </TASK>
> [  667.125210][ T9805]
> [  667.145632][ T9805] Allocated by task 9805:
> [  667.145991][ T9805]  kasan_save_stack+0x20/0x40
> [  667.146352][ T9805]  kasan_save_track+0x14/0x30
> [  667.146717][ T9805]  __kasan_kmalloc+0xaa/0xb0
> [  667.147065][ T9805]  __kmalloc_noprof+0x205/0x550
> [  667.147448][ T9805]  hfsplus_find_init+0x95/0x1f0
> [  667.147813][ T9805]  hfsplus_readdir+0x220/0xfc0
> [  667.148174][ T9805]  iterate_dir+0x296/0xb20
> [  667.148549][ T9805]  __x64_sys_getdents64+0x13c/0x2c0
> [  667.148937][ T9805]  do_syscall_64+0xc9/0x480
> [  667.149291][ T9805]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  667.149809][ T9805]
> [  667.150030][ T9805] The buggy address belongs to the object at ffff88802592f000
> [  667.150030][ T9805]  which belongs to the cache kmalloc-2k of size 2048
> [  667.151282][ T9805] The buggy address is located 0 bytes to the right of
> [  667.151282][ T9805]  allocated 1036-byte region [ffff88802592f000, ffff88802592f40c)
> [  667.152580][ T9805]
> [  667.152798][ T9805] The buggy address belongs to the physical page:
> [  667.153373][ T9805] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25928
> [  667.154157][ T9805] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [  667.154916][ T9805] anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> [  667.155631][ T9805] page_type: f5(slab)
> [  667.155997][ T9805] raw: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
> [  667.156770][ T9805] raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
> [  667.157536][ T9805] head: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
> [  667.158317][ T9805] head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
> [  667.159088][ T9805] head: 00fff00000000003 ffffea0000964a01 00000000ffffffff 00000000ffffffff
> [  667.159865][ T9805] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> [  667.160643][ T9805] page dumped because: kasan: bad access detected
> [  667.161216][ T9805] page_owner tracks the page as allocated
> [  667.161732][ T9805] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN9
> [  667.163566][ T9805]  post_alloc_hook+0x1c0/0x230
> [  667.164003][ T9805]  get_page_from_freelist+0xdeb/0x3b30
> [  667.164503][ T9805]  __alloc_frozen_pages_noprof+0x25c/0x2460
> [  667.165040][ T9805]  alloc_pages_mpol+0x1fb/0x550
> [  667.165489][ T9805]  new_slab+0x23b/0x340
> [  667.165872][ T9805]  ___slab_alloc+0xd81/0x1960
> [  667.166313][ T9805]  __slab_alloc.isra.0+0x56/0xb0
> [  667.166767][ T9805]  __kmalloc_cache_noprof+0x255/0x3e0
> [  667.167255][ T9805]  psi_cgroup_alloc+0x52/0x2d0
> [  667.167693][ T9805]  cgroup_mkdir+0x694/0x1210
> [  667.168118][ T9805]  kernfs_iop_mkdir+0x111/0x190
> [  667.168568][ T9805]  vfs_mkdir+0x59b/0x8d0
> [  667.168956][ T9805]  do_mkdirat+0x2ed/0x3d0
> [  667.169353][ T9805]  __x64_sys_mkdir+0xef/0x140
> [  667.169784][ T9805]  do_syscall_64+0xc9/0x480
> [  667.170195][ T9805]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  667.170730][ T9805] page last free pid 1257 tgid 1257 stack trace:
> [  667.171304][ T9805]  __free_frozen_pages+0x80c/0x1250
> [  667.171770][ T9805]  vfree.part.0+0x12b/0xab0
> [  667.172182][ T9805]  delayed_vfree_work+0x93/0xd0
> [  667.172612][ T9805]  process_one_work+0x9b5/0x1b80
> [  667.173067][ T9805]  worker_thread+0x630/0xe60
> [  667.173486][ T9805]  kthread+0x3a8/0x770
> [  667.173857][ T9805]  ret_from_fork+0x517/0x6e0
> [  667.174278][ T9805]  ret_from_fork_asm+0x1a/0x30
> [  667.174703][ T9805]
> [  667.174917][ T9805] Memory state around the buggy address:
> [  667.175411][ T9805]  ffff88802592f300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  667.176114][ T9805]  ffff88802592f380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  667.176830][ T9805] >ffff88802592f400: 00 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  667.177547][ T9805]                       ^
> [  667.177933][ T9805]  ffff88802592f480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  667.178640][ T9805]  ffff88802592f500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  667.179350][ T9805] ==================================================================
> 
> The hfsplus_uni2asc() method operates by struct hfsplus_unistr:
> 
> struct hfsplus_unistr {
> 	__be16 length;
> 	hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];
> } __packed;
> 
> where HFSPLUS_MAX_STRLEN is 255 bytes. The issue happens if length
> of the structure instance has value bigger than 255 (for example,
> 65283). In such case, pointer on unicode buffer is going beyond of
> the allocated memory.
> 
> The patch fixes the issue by checking the length value of
> hfsplus_unistr instance and using 255 value in the case if length
> value is bigger than HFSPLUS_MAX_STRLEN. Potential reason of such
> situation could be a corruption of Catalog File b-tree's node.
> 
> Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---
>   fs/hfsplus/unicode.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
> index 73342c925a4b..7e62b3630fcd 100644
> --- a/fs/hfsplus/unicode.c
> +++ b/fs/hfsplus/unicode.c
> @@ -132,7 +132,11 @@ int hfsplus_uni2asc(struct super_block *sb,
>   
>   	op = astr;
>   	ip = ustr->unicode;
> +
>   	ustrlen = be16_to_cpu(ustr->length);
> +	if (ustrlen > HFSPLUS_MAX_STRLEN)
> +		ustrlen = HFSPLUS_MAX_STRLEN;
> +
>   	len = *len_p;
>   	ce1 = NULL;
>   	compose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);

I found that Liu Shixin already sent a similar patch [1].

 From [2], Long file names for hfsplus is 255 characters.

Could we mark it as EIO?

[1]
https://lore.kernel.org/all/20221129023949.4186612-1-liushixin2@huawei.com/
[2]
https://dubeyko.com/development/FileSystems/HFSPLUS/tn1150.html#HFSPlusBasics

Thx,
Yangtao

