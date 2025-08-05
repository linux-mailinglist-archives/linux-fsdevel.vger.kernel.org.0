Return-Path: <linux-fsdevel+bounces-56783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66725B1B8B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855D617F1EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA154292B38;
	Tue,  5 Aug 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="X30S9BGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012013.outbound.protection.outlook.com [40.107.75.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39842571D4;
	Tue,  5 Aug 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412242; cv=fail; b=HFSSc0SD8QP8f7pCGm3blnAg504MeFrSQNX4yeKRiQr3AUCU1E9X48ksbPFTn9Ssz64xVspBJ2PUwNCP6Notbka9GVvVWpGF//4+QlFpyMXbdDzrnFIvQJb9RcbBwTMJwiZK9Ei1wSi2yXlhSWxyRVZ7PVhchV8UE+56jwEL2RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412242; c=relaxed/simple;
	bh=DQX5W+eXge/1WzDLuW+aXPOyfOXwwelBz2t/Se9dVmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I8EPVNFgLVOonVchluxyBh0ToroPuDt4v9TQNthgWvvCeqj0ppn6yc5oik0Mn/TMF8GbLyXvaOfsw3+Xizcd6qSzGr2RbcKHadwH9s6lBMNp5RtC/rC1f5m0+JwuvBK8K947Sb9cKeFo4uppxpkUu4ZV5VCB3hc+yMYtZrHEIvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=X30S9BGQ; arc=fail smtp.client-ip=40.107.75.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4JsZF//EqL38w/O/ANzMdQ61XXGTMrmLmkMvY5fezaMxYNp6pZtiqsv0JVS4Cz04ftv5TV1jrRKTvPpYlbyFnB/lvB9r2x50FEuJ4N3lV5Wy2bdIFxZDvFHJuZkFNUqvzILv3DMLOgWlGkxgq/YuwlALw0B015fRd+aNUzQBpgnUrBmu2AUNBDib5fZ3cepY3VSk1XHtKfUiVaa41v8fgiQXgWRRsrO7LAjh2iLfh3TIQqchIfndQGqSC9+v7v4JiH5eBIQmJem2yc1MjG6zsegofT/PuCeXpyrC6A8rPj+6nZBqVhLjRmRP4i8Dp87A0Hvv/4xZapwPMvT/xZjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm/eFlldLOQ+xHI7ttS19IrSAU6QWHAZkWSnSr8+rog=;
 b=isNaemCGvGYFWD0gYseji/d6NjxuTM5FSUectSHhm1r/P5CCXfRqJEluAeetrFPbcKnhuh48lDYNgl25446DjR5vqiKaa5DPoUp7T2z6jcMELDiLjBXpt1WvvygmPegiBK8Dsem5zxmCxisA0I69sSKeG1wNdMPY92ne84kJz6m4aH+KV8+EiOosgjTDXjXX+MRLwrAeEeoeC+qzxI+fB/67T7CAedkht/3usMyNpbqsKJFuCw/JgdmhNwnlpvZa8Er8nZjPRVvKz9B4KsHrByCGibrXkEuqTFqedSx8/Vjtw/6o5nQk5IYOsA6eWxL1OtKmN3F+xq/UtZnQE5u9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm/eFlldLOQ+xHI7ttS19IrSAU6QWHAZkWSnSr8+rog=;
 b=X30S9BGQcU76JrqsFF/KkJreqZdwJ84lxe+YAxvcwpr6QG2/vadDs3ELnN80aNiw2WiTww92ron66sJuW2CMv3o3b9k8Qjq+lh56/GT9Sp5jKH3ge3fJWVHL8T3H9siB/SEkwbE2RMIy1kkKo4HeLQA8gq22jHUrwNjyxN7XRgarB7bRfSJtfiPPfPCadjsmiYzTBPJYWsa77ynuLmCc6/pD2xCX1K+/cL2esTbK5hCPWQAOEwfbi1iaO4pthqGjkqP5+R2MwGKfKTMqj6Q/5KG71zpBg7qwDP2IR4kGZhMOYPpYibu3c/H4yGGwU84pPJFbTQTBDeXILzjUDQgxNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6616.apcprd06.prod.outlook.com (2603:1096:101:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 16:43:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 16:43:57 +0000
Message-ID: <c17cd9f3-0651-49ce-805f-d94ef2b232c1@vivo.com>
Date: Wed, 6 Aug 2025 00:43:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update location of hfs&hfsplus trees
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250729160158.2157843-1-frank.li@vivo.com>
 <d359b20348c17c5426cca6937a96a739e9f1a7dc.camel@ibm.com>
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <d359b20348c17c5426cca6937a96a739e9f1a7dc.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: c5771cbf-df1e-433d-fb9d-08ddd43f4595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnRPeU10b1huV3ZLQ1lSL1RPdDJrVVBpamJoWnFpckE2bFkraXI2elZoZHAx?=
 =?utf-8?B?aXVqY1hmTERJWlNrMjBKa1BpTXdNTmV3NzlOSWNOOEhqcTZ2TU9rZmx6RHJI?=
 =?utf-8?B?Y0ovc1lyZG9kZ3lkTXJuOVJ2MUpORE40M3VGdkJvV3M2M3J0SGFlTHlmL2RZ?=
 =?utf-8?B?bDlHK2ZRQWo2cy8zS0I4TFZOZWR2ZkNzb2ZhYmhMZjZ0M0lTbDlmMlRnK2pF?=
 =?utf-8?B?VHZKZndmd3dhdXR5NGZOQjVaTTNET0oyWlVBM3ZaYlVOQU81TGRwUkJPdGx6?=
 =?utf-8?B?aEhiQ0dmZ0FOcnp1WjdTNWxwMVFXV2Yzdk9JenRRZ294TlllSzhlNTlDZ3JU?=
 =?utf-8?B?dDhYdkp6K2kyaWJVdFdhTElTcXVyRmsyVnVlUjY3T3lYWlNNdWhwa2dJcVJ6?=
 =?utf-8?B?Nk80WUN4WGYvM3hVUmhEbXdDV3gwZUxYTGV6YWlVcGVFdklQZGNZUUU0cEc0?=
 =?utf-8?B?MzJuV3R5R1ZuRkswMkN5azdOK2h6TFpiQm5TSFJpQW9lcWdFeDRLaExvUGJI?=
 =?utf-8?B?cWVmN1pWOVZLMjlLRk9rVG4wM1l6VXAwT25lK1lhSWtIVFpkK1d6WFczdUhh?=
 =?utf-8?B?RTlJZDdGeVAxVzloVzFWMXVFTnlZVEZOOGNkamdxejNLS29pR2RZeUZpUmNP?=
 =?utf-8?B?V3dXSVB5akExSklRNy9WTHNkL3lDNkZTc3RSQjhLN0U4aEgyaTB0VmVKRWRI?=
 =?utf-8?B?TkJsSmZuQ2txQmNGWU16VzdtelJPSHBESnovaVpJTitpVG5kTGdvTk1rUVg2?=
 =?utf-8?B?NndpWCtMRDFuZEI5NWZRL2dtYys1VTdRRzhyNWQ2Vlg4RkE5MXJXWjdNd29P?=
 =?utf-8?B?UnpPUmtINlJTY1lOSVlNaEl4eXJNSXdON081MFRnQnR6K0RkSHRETTVybE52?=
 =?utf-8?B?YzBpTjVXTmwrRnZiSFhWREVPTnlWY0VNWitqWnc4NlloM1hwaWFWUXM2TkV5?=
 =?utf-8?B?bVlKQ1hBM0QrRUcwbk1lRHdtbXNFSGgrTWV4WTAzTFgvVDlYcGlRcVdtbndZ?=
 =?utf-8?B?OS8wNjBoU3RPVWZ2bjVFYXBWTFMrckFZRnVOcE4zVHMzWnArZjgrWnZVaSs5?=
 =?utf-8?B?VGRmbDVBeUt6UEo2a0w4M0RKODFDbjl2V2lRRDNoU1djWjMzcXlVRzY2Si9x?=
 =?utf-8?B?ZC9MWUp5UFFNVUxnTFljdVQ5YU1WVldiQzRoVVhJQmlxY3ZWa3l6NW9laDhm?=
 =?utf-8?B?UGdVRVQ2R1V0L1FGQWlNVzZxeWJpcjVwNVVQdnVwNW83MDRqUjMwOFU5Z2ll?=
 =?utf-8?B?NFJHdW9NWHU1eWhraHYvTUlHRTBNZTJBektRdHBONWprY3VyQmdLZGN0NXhq?=
 =?utf-8?B?M1FlazY4Njd3a3JZVGtxQS9iYXdIVjlFWlpRWXVpM0ErY00zNFFicDhSQWJE?=
 =?utf-8?B?ZGhCdENVUDN2aGt0Z0RwekpGWG14TUN5azlBTUlxL09IT3Z2ZWV4elBPcFBi?=
 =?utf-8?B?S09CK1lDNnRtYUZqejNnU2RIVTlybnd1cFFwWWNaMGhmU2RReThlc01Oc1hC?=
 =?utf-8?B?bTBzeEVLamtQZDlEWWJwejErek9zeXQ3cUNYbVZOK1hjNjc5a09VL0s1bG1O?=
 =?utf-8?B?RGRsNk0rVkd3a21JdnF5Qm8yZFlwaXVoZi9DN1VUM25qOWFpdHVvalM2S1hN?=
 =?utf-8?B?UGJYdEpVTGtJK3ZvenBVRGlQWHdWdzdibnN0eU5zTUptZXU4Z2VnZFlNRVJV?=
 =?utf-8?B?T2ZZT2VDYUdhazM4ZURFY2tURnh2SnBjTkZHQmZOTU8wQVlQZy94eHpUc1FS?=
 =?utf-8?B?anYvMlliV2pOU29XZHVISk84TVdJYXIreUQ3V2c2Y0ttRE5UYlpvQ280bTRK?=
 =?utf-8?B?MW5OT2RpaGhKYVN5L3kvektUaEF2QmxVL2NoZTI4YjhIQkRZUFVIdUJQaHV1?=
 =?utf-8?B?a2R1Sllib0tDNjNoOVV2V0MrTUMyd0hZWERQeGd6UXY0YkF1YU5VVWNEc085?=
 =?utf-8?Q?fhNsCG0dj6U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVBoYyttTWdmUHl0TktTVTNhd2tJd0RaN0tDUE9PZUFxUUhyeEZ3cWJ4WTFn?=
 =?utf-8?B?Mk01ZmMzRmhVK05Qb3YzbTlKdUF0ZWlDQnJac3NCNG5HSy95a3pzK25Wamsy?=
 =?utf-8?B?cHJxeXBSaUtMU2o2bFd6UDh6RDJvR1J1dThDTnZGZ3VKSjhxTDlwTjFpM0ow?=
 =?utf-8?B?c1dHdStxNHFzaWhsQkJTdGdTdGdtQVpTd2tkenB3a0FZOThZV0lwdW1XZVJs?=
 =?utf-8?B?MDJESFU2WmV0am1pZmxxQktaWTE0TlN2YUJ2ZzMycDNrZldYTEhuQ1ZIRnlv?=
 =?utf-8?B?Mnptd3Z0dytGKzZ3SEptZkxBNXNsdVpXWEMvMDhRT3Vpc0djaVlFKzZwbDlo?=
 =?utf-8?B?ejhEQi9mcnJLTGgyMGpocXJnT0ZXdUk2WXJIa2FnOXhHTGpKU1Q2UmlXSWxV?=
 =?utf-8?B?MFJwa2FYZk5qMkR3VWlxZmRJelBYVkNDakVGVW5KNUN3QVg4K2JCaEVDVStE?=
 =?utf-8?B?NEdnajRyVndGZmV3WnN5dTVncmpzaWxJdmlvQUoxbXNlU1FMZ1NVajNZMTlQ?=
 =?utf-8?B?cmw3bTZTVjJCUTNXbEp3Ry92RnFXK2Z5bWpxTFIxckxabTd1T0l0WnNITW5H?=
 =?utf-8?B?Qnkyc0NKcHhuTk9qQ2hWM05OUkZXOXo5NGpsMFJpa0FEVHdUKzBsS1YwTkVo?=
 =?utf-8?B?MXlqZjBVNHg0dC9UT25NbGdwdXdSbzBrRnlUNU5yREdhNGJSUXdnNUlxaWFC?=
 =?utf-8?B?Nmc5RFhaZWpPeXhiMFo4UXgwVkQrODA5VWc0czVxTXBaMjYrdDBHdnNpbVEr?=
 =?utf-8?B?WElxcTNnbFcxVlBOQTQyK2VOSDZPUmJJeWpOaXphWWJsOStRbXFJdFBoNGkv?=
 =?utf-8?B?RUgwTjFIUkJkd0h0SWVJM1IzckE4Y1hrZTFtdkY4Z2I3eVBZUGI3dVk4c01q?=
 =?utf-8?B?emtUMGdKUllJRFA3R1huSFI4VDUxbUdIOTd1TUhKZDNWVlU3M0ZQSmNzNksw?=
 =?utf-8?B?NGZUTVNHSUlJZFJSeHpZQ2U1N1pCUFF3eXNwK3dWMkN6RWUrdnI3TjYyYW9N?=
 =?utf-8?B?TzFsYkFrbkNMcEVvYitXR3NKSXk4RGNqT21CTmE4bkZEcW1XdXIvanMzZTQr?=
 =?utf-8?B?ZFU2YUcvcGxUcWc4K1VZRzlpVjh5eEd3ZGR3N2tZZVRMR1ZqbmcyWTJkMlZ4?=
 =?utf-8?B?UjkzTUZVZGdHM2pFSXFOTmJvbTNHcCtMK04wdk54VE1RUWl2OEtBamxnQ1gr?=
 =?utf-8?B?YWMwc3hJSURtN1B3c0FXb1I3cU5oWlVuWVpJYzNOY3JnZVhSNnJCUENLWE5I?=
 =?utf-8?B?TkJlUGtEZnphVkxDbm9SUHV3SWRiRHB5VmwvNEtlU3QyOG5MckhpNVZtN2d6?=
 =?utf-8?B?WkFJZDUzSWw0TzByMFRPZmdnUUZvdGU0c0x2Q2JuVCtBSzFoWitEeHZIVERJ?=
 =?utf-8?B?N0NNbFE0eFd1OXlEVmdkdEJ5eTNRVE5PTEpzRk1na3FxUUVycU95am1DNUdI?=
 =?utf-8?B?OWdmVjFOS0dIR2pRcC8wM0RGZkFMaWo0anl0L2d6MHpZMStXbUhjWXRPYXBW?=
 =?utf-8?B?VTFYZEVKb2xLR01qUkN4dlZqbHA5SDFLVXkxZjN2RnlVQ2pXcit5RERvNWtw?=
 =?utf-8?B?RjU4NERuUzRiby9BYjBMc1poL3IvZGl3KzlUTUpaRU1qNEdlQ2pDb1pkRHZo?=
 =?utf-8?B?ZS9HWEgweDJXWVdoQXltNVZpOXJoME02TFNoaEFTdmVCR1pINWx1aVBjOUtY?=
 =?utf-8?B?YkxqSDBQVWRWOEF6cFJvQ2UxOFNCaUJIS1l3dXFQckZTZnFVaEFRNDdFMXpE?=
 =?utf-8?B?SHcvdmErWE9CREhPVlB1THdGVDB1dGk3bXVTZWFNRk9rcDk1NldsaERCWUpU?=
 =?utf-8?B?eGhqakc3cTRKbytXWUpRbDVZYkVpQzVQOXNOTkFiTVRCbTdVb0ZtbU5qNW1Z?=
 =?utf-8?B?NW5DN21uclFEUjQ1dm1PVzAwWkhpckIybGp6Q01TL1V2Vm1MYmtMakh2QTZ3?=
 =?utf-8?B?VnVnOUlrYVRQREh3d0lKRk5WK3hkdWtDaC9nVWFlN1N0dlU0VWo1SXdGY0Ez?=
 =?utf-8?B?WG8rV1Q1Um56alJWOURYMUpQRmpIZC82MTdFMDk1ekNPMDZ1OTIra1RDcUw4?=
 =?utf-8?B?WDhpZ0UwcU83SncvOXN0dTRuN3hwQ3VxWVpuL3R6YTlxeVMrZE5kcTZZYzFU?=
 =?utf-8?Q?mahCZcbdT0hNL0XVNrnp7BUMJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5771cbf-df1e-433d-fb9d-08ddd43f4595
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 16:43:57.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jh0Q4ZpwKfECSAisKeG1o74BHE7BMCiZkRqbXr9vsXxfnI01qqKMTLtEyGYjidgC144JP2QH1eooLDDbW0gN/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6616

Hi Slava,

在 7/30/2025 3:12 AM, Viacheslav Dubeyko 写道:
> On Tue, 2025-07-29 at 10:01 -0600, Yangtao Li wrote:
>> Update it at MAINTAINERS file.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   MAINTAINERS | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7a4e63bacaa4..48b25f1e2c01 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10659,6 +10659,7 @@ M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>   M:	Yangtao Li <frank.li@vivo.com>
>>   L:	linux-fsdevel@vger.kernel.org
>>   S:	Maintained
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
>>   F:	Documentation/filesystems/hfs.rst
>>   F:	fs/hfs/
>>   
>> @@ -10668,6 +10669,7 @@ M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>   M:	Yangtao Li <frank.li@vivo.com>
>>   L:	linux-fsdevel@vger.kernel.org
>>   S:	Maintained
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
>>   F:	Documentation/filesystems/hfsplus.rst
>>   F:	fs/hfsplus/
>>   
> Makes sense. We need to update it here.
>
> By the way, we have also [1]. I am collecting patches there at first too and we
> can use it for the initial testing. Also, we have very simple bug tracking
> system [2] and I am tracking the known and opened issues there. Should we add
> this information too?
>
> We have empty WiKi there, but we could add the information there too.


Do you mind we add those facility step by step, or add those facility in 
one patch?


Thx,

Yangtao


