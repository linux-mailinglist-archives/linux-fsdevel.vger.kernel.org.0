Return-Path: <linux-fsdevel+bounces-49472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09BABCE68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733E01B62A28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEBE25A322;
	Tue, 20 May 2025 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Gx+s6AbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011016.outbound.protection.outlook.com [52.101.129.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56D25745F;
	Tue, 20 May 2025 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747717749; cv=fail; b=fLjBHT86AIwJn05HNRBS2YZ8XfB72jGpCPZvYX4AF6/e7GTbvfwh/0eXcTu+dA/p3LMVGou4n7qDrMv8v+twlK21FXkYl2ETcNv8xUk2Wj5tgoYAc+Q1FP/vKqCXaRWDAsHr0M00f11AxYEyFHvx1tf6DzzUBLKoC64KkeNk/Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747717749; c=relaxed/simple;
	bh=CI2MAzf/Uwj+vVeCJMIla7Tjbs7yI1fWj5QQ8EMpqTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UuzV5EQbU/cNRCL7yg75CBJBG0C7g5ZCwba3IC57KAHQ6rKyL97bmkxPpKrYjaiDU+xYjN0I5Sa3Kpf5JCu/rGVjqosaAvF+UGPNTyuxhKuDP6d77XjlwceKfyiIrMz1QDIUjnUyeWzk14SJdbS8exDphPwEytges80CLLK4kBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Gx+s6AbB; arc=fail smtp.client-ip=52.101.129.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rj8X7ajfAfa57I7GrKKYI+DI/LL6fpqxf/rHpae1qIXnQzKb0AgMVn66ke/UJyd8DRim/QNwLpN8I4WLW5RImfMCOTQyHxIHEMS6prDeqiru6D3boeX2fieir6emdSRd7ecWbMxDZ1kXhD74z4lShqI8Nk9t6B5d5WXh7NHhXcqFDhgw9cLru7Th8aFa9Ey2LcF0a7UHbKIPCQNjAgY0WfwNsljOc4G70628GF39Vrn3AXY0mQtItFYx5fikSyGhF+HaalEhkz+arDK4k/I5847qfOWlf6ZNj/adp+khk2MZ5VEP8tuaANYOEt5QAoHGFpa8x9QRsHSVS9igVmem+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQaqZyoAWpNXcEetO7Ks2HSswjU1diOg1cKutGF0suY=;
 b=OE7LrBIO9mHBOzKX4SBO44QddfaeI7xpMC0JyKBpIcRkzYtIKIhkv4rlKf8zG1osdn5NWvK7AgVC7qKDFRmWYpHjcUXvMEZEOVhOfIEt+eTnqDJmNRVnX/rK8HMRDqJm7nWRG+z0iKFnvYBNyT0Jw0WdjqnBBUcS/fk4PjQc45zU0jVZ9Fm5v6+eyn8M3kMXCxcNgmMLIEwjeM37DpL+vT3W1M3yLeJ3wLKggEpw/6NBKcT7Nu5DwH419wySh/7M4kg5s4qVxxnyQcbf/xtuZWrrfqQWX3m3PuDs44YXSI8v9PPCSsNVKgosj4SsA/qHMf60QnyyJGA3hfKBcSLUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQaqZyoAWpNXcEetO7Ks2HSswjU1diOg1cKutGF0suY=;
 b=Gx+s6AbBJQska4H+zm1TtCCgyKq4RyAVzB1WuqUg8rqMrHMejxpDDnOUzJh2saJ2obRihm2UK0OlbHYPjpROQhgLzsaxr5LH//D/P3luEza3D+5affe0b6tHCMD+QByKSkXfffDFnHw2RUlGBL52REI7azSKLTcjrMRD9oGcHB0x+0rCFXFo1NwRvlEkB48i/onj7APU3qJ4Qry/w0Q9nQ4xISdRz1icXgaFuO8gBYlfmmThheUROKRGL96xP22TyRPIxNk2TE43VXjBvBJfb7RNtlXg5oM6CJDw7wnp1J4Tma3ZwsoMPFiQdfiAlTm97RWEZsAQWT5W9mvtn3rFrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6488.apcprd06.prod.outlook.com (2603:1096:101:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 05:09:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:09:00 +0000
Message-ID: <226043d9-068c-496a-a72c-f3503da2f8f7@vivo.com>
Date: Tue, 20 May 2025 13:08:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
To: =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: ethan@ethancedwards.com, asahi@lists.linux.dev, brauner@kernel.org,
 dan.carpenter@linaro.org, ernesto@corellium.com, gargaditya08@live.com,
 gregkh@linuxfoundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 sven@svenpeter.dev, tytso@mit.edu, viro@zeniv.linux.org.uk,
 willy@infradead.org, slava@dubeyko.com, glaubitz@physik.fu-berlin.de
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com> <20250512234024.GA19326@eaf>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250512234024.GA19326@eaf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: ea975da3-bed1-4636-30dd-08dd975c6e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTlvRHdYeHRxS3cra0p0ZmFNSGxqSEdhYXJlYVFwZldVanlPT0tuUVRzV0Z4?=
 =?utf-8?B?MHZXSDZ0L0tBaDF1N0prT29LL0pPZS9GRGNaVktRSWhxaTZWbkZCK2czQkFm?=
 =?utf-8?B?bFlqekpzUFRMLy9nbDM0S1hxRlVaM1BhenZzaHVRVm0xZEVoUkowVDJFM1Vp?=
 =?utf-8?B?M1B3NFVmbUl4Zmc2aVJSMURWYzlOL1FkelNmVDUyWGczUEl1aHk1M0UrRmRH?=
 =?utf-8?B?a2plTHlLeUZsZU5QMG5yU3NSVm84Qmh1ZVhjZ0pmalNndG9CZFV0US9uWTNj?=
 =?utf-8?B?NkpSdk5MYjUxUUxjcElha3F5cXJwN1FXZEhzVWdYaW80NTg3WlFSZXRKdE05?=
 =?utf-8?B?NUh0ekllMGhtSk5TbStKdUFwUHVGdncvdk0zNjZ5ZFRENis0bmkrdGczNGlF?=
 =?utf-8?B?MDBZUTA4MHBJQlYyM0Q2SVdEdmtEYUsxRmpTMVd6WksyV3JQdDJyQUhYc29H?=
 =?utf-8?B?L2w4Q3J1eVJVcTVtRmduT3R3QTZoamRKNWs5cGlpZmhGd0t1MitSOUZQaGl6?=
 =?utf-8?B?TWtYYTJpa3QzODhFUjUvS0pmVW01cDFVTUNMSElxTlViREJFRlVsYjJ6Tzk1?=
 =?utf-8?B?QWU2TzZmUG1CMHg3Q0dOUXV5cGxlNUZoMkxzRE1LcDdHUUpsN0RBaUR5aGJY?=
 =?utf-8?B?ZGNvZTVLeFVHOEVhaFNBcWgxZkthY0NDTnpvZHlOdjNGQzJmbFlvQkJQYU1s?=
 =?utf-8?B?bGoxS2V6ZFBMeGxhVXM2dVVnZmJUN2s5ZjhCeGtjenBhQ3NucnNQdWxkMk9q?=
 =?utf-8?B?cmh1ZmljUW5yUG9YTitrMTFrSlhpV3Exang2U0thWG9mZzB1bkFjR2IvaGtR?=
 =?utf-8?B?ajlHYUljS0tkc2luS3FJc3VOTzc3UE5XZDBwblBicGFuZllLTWZJS0srSUx2?=
 =?utf-8?B?SUxZd3dxeFBkRElyYW1ZSE5EK0x4VzlQVG9pU1lSMEJDNENkMkJBdWhkYm1T?=
 =?utf-8?B?RzRTVWlDS2QwenRVZnBXaXBTbTNyQ3Y3Rzk1UWpuUGU5ZjBzZktUSENTREJR?=
 =?utf-8?B?Y0FxVStGek1UY1RjMWE2eXlIUTFWRURlSjVhUGtaOHB1ZGkvVkJUeHZUNk1S?=
 =?utf-8?B?dHQvV3JZQXVEVXoxcmlXSDBUUDF0OFZZOGR5QTNnVXhlVEVjMzNzS3d0aFVG?=
 =?utf-8?B?UXNnQTBhZDdkUWZuVktha09SQUVSVEhPTUx4WU9DdHcrbE54OHdUMWl6UllY?=
 =?utf-8?B?ODlWNkNlSk5LNG9vZ25XMVdjYk42RHFrN204STJZSFBZNWFnWm9IZFg2Smc5?=
 =?utf-8?B?eG5WV1VqcStuTGJONXhYZzhqeU44WjU5dUJaR1lWMXgvVmhUaWNFUzZRdzVP?=
 =?utf-8?B?M0swb2JMSWp6WlV3a2lyaXM3ZDZrbFBLZC9mRkQzdW1zcWhkQnUvYTRRbWFZ?=
 =?utf-8?B?bWVYUTJvazJrWnFyZ1VQMlVKT0NyQXVEeHBSMmF0cEhzbVU2RTdHeXJOQjJo?=
 =?utf-8?B?TjNzMGkwUElWVFBjdGxYMGlsWmlnSVZjdFpld0xLMElxeFN0cFhxN05nQTYz?=
 =?utf-8?B?MXZpVlROTU9jbXprQmNTUzFLcEs2YmpNKzdDazJiaGxvQ1MxVUNYakJNdmVs?=
 =?utf-8?B?Z0lJWk52UVFya2hzVkJjdjhIMDZHNk9KSk9SYUxPU0YvWmJaU3VGYmJzVU9z?=
 =?utf-8?B?RE1ybGN6ajZUQW52azRlWVkzcmpTT0hGbC82bEZrakhxaytWYWNVMkgrR2E4?=
 =?utf-8?B?ekcwQ0NBNFEvSHZXdFphK3ZsbWJHM3RhMG1rLzNJaU5xWWJXdDVlMXJwUWR5?=
 =?utf-8?B?bDZXWCtMa2FENkVDTnBIVHdvV0I0T1lKUTBmZmZLdTluQjVWbVk3am5xSmEx?=
 =?utf-8?B?VmlCQ0hsNWl1YWV6VENrRVBoY1NIaDV2ZjM0SDB3SUozRzE3NGJ6Z3NDRkdG?=
 =?utf-8?B?b0JFK1h2bUI5UDBNMzZNZGV6WXNWT3gydTd6V2Q5TDNVeFI3dXdMRXJUbi9s?=
 =?utf-8?Q?y8U3WZpu3UY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXppUDNKVXVWb1hBcGE1WlB3WHBCeHlGMGZyNXd1WU9KdS90RVNsZXA4ak9T?=
 =?utf-8?B?MzRDTllldEtMMXZWOHBBS3lCOUR4aEY0cStDWDlIbnNZSzFZM3pQaW9YUlQw?=
 =?utf-8?B?L0F3MmpFWThUOFI5TGpqekd0T3B1NlUzYVF2Q3BkWlRieXZLaENIR0JCVDkr?=
 =?utf-8?B?aTM5dTBLUEZZbXduOGxjcUVGdGl6RkF3MGJ5NTVvRlp5ZDlQaFhRZ1RFNXhu?=
 =?utf-8?B?QmxwSkJrRGpJbkhNa0orQ2M4RWhsZEdMcXBlQlB2eUFJajdaYXZHaS9xNlQy?=
 =?utf-8?B?YWtuV3N0S1BjUWRQKy9weUNwd29hVnBIY2ZCZmlqNXcyMU9UYm1BUDBiTkpJ?=
 =?utf-8?B?Z3NJc241eDhSMjdFOGFRSU56ckU0OW92UjJFL1NTZUZhWTU0dEhuSU16NWdv?=
 =?utf-8?B?SE9LbG5qUUoraW1VVzkweVdGWFFoN1Z4Z2lzeE1BazVaR0FBbjNsNUN6RnZl?=
 =?utf-8?B?ZVpmL3BJU2NNc3A4emM4bWwrMWNFYUU1akNvTFRBdGRUZjM3RFk5L2pqc1pZ?=
 =?utf-8?B?SmVkSm10bXNaN1FhcFUyMUl5dWlDYjRvbXNPVDJJWitZQ3hQY1lBc3lCU1hr?=
 =?utf-8?B?NjZRNjBvVGVhdXduZjFDOXlQaEZJQmo5ZFlmWjl0Z3VNdkxJMzExSmNIa1VI?=
 =?utf-8?B?Z0JSYklPU0ljejZ4M0FWL29wUG5MbHJwbUZZeFVvVTdDQnc0aGo0RVI4YlVD?=
 =?utf-8?B?d0ltTjJLRlVLK2NSUGlPY2czMVdTSnFaTEViL3VKOEpmTjUrT09QL1d3aWQ3?=
 =?utf-8?B?UHpFaHJNZjZlMDlnTzBGWllTdmxzemxDOWNrc1FxL0NUT0hkczBUbVcxQXRk?=
 =?utf-8?B?cHNjYmdVdlNRd05YeVE2ZTJ1Sm0vWnVMbmM1amtONmYwSGZvb3JRdHlJQTY0?=
 =?utf-8?B?bDUwWnpVb09ieTdxRTRlOEo3SzYwdUdvVUZQNDd6ak5OdXpSVi91L0hxK24w?=
 =?utf-8?B?MGtqYmhwUWhTbWRQUk5FTlNMUlZZVXRSUDBPM3lKWW5PQW96dGxzc0JKNGFW?=
 =?utf-8?B?aGJmWFk2UUNPbDh2RTZrQXVvZnZxaVFCREEyRmUzWVprU3BHQTkrak5ka0Zo?=
 =?utf-8?B?UGFLNjNPNXFLemZ3QTltSHlIVWtjdnJMRTN2OXhybVBWbEI3MVh5UUFaMEdJ?=
 =?utf-8?B?alVOQnJwZHQvZ3lhckpYeUswUnpkQmFQK2U4WldqRDAwbDIyV0FLbWd6TC9O?=
 =?utf-8?B?SHJxbnZNWkZHdStybnljRWd5Q0E1czFDSlA2elIvL3NPVkhqb0tLSEJvYkNh?=
 =?utf-8?B?amcxQWJtZFBYVmZ0QzZVeWQ2WWVhWVRKOHczK0sxQ2Ftdm1NSW1QWGtOdzdU?=
 =?utf-8?B?dmJONXg3clh5cSt0ZUhqWUd3L2VuWFhzUUczdGtFa1Z6VkFNZTlQYTlCdlJn?=
 =?utf-8?B?YnU5Vk5KNWFHOElDUDRoQkE3TW1GdEdIc1R3cWQzZERiL3hkLzhjT2xGdU5s?=
 =?utf-8?B?eXd6WWR6RFhSZDFOdjB4blRKbm55VHVIc1BBWTZFdmlESjZJUkYzUytvVkpl?=
 =?utf-8?B?RzdnMDY2WjUvenByWG01eEo2Nm5IbUZURmtpNlB1RFg1ZFpGRnBvbjZJSzlQ?=
 =?utf-8?B?eXhkWjNtRG1KUXZYaXUwdG4yNU1Kd1I2ZnZJQ3VXN3dRZ05zZkw1WW1jYUo4?=
 =?utf-8?B?eFg4cis1OXBhMlYxdUdESWRuUU80VW1HeWd0OHdLM0gvRGxKaUZwdFRiVzBo?=
 =?utf-8?B?YU16VGZkYWZUSHhjbGp3NXJMWXIvYUFFRnp1WEl0N0NRdm0zMGdEdklXdjJL?=
 =?utf-8?B?UFJpTktjNEZOS2JXeVdHN1lYeHFUSFNsTXZXaENRUHBCMmZNaU1tRWd3NXR0?=
 =?utf-8?B?SDZ1UjM2MmdycFN0RlhVeThLZDVyU1hEQjdCSDF0SUt6Zm9pQVNuYTlyQm9D?=
 =?utf-8?B?YkxoYStBbXk5K1lycmhXZE9peGtGRlRIeVBiWnJLTiszdWQ4Y3RyS0U1SzBY?=
 =?utf-8?B?L3ZiaXJ0djAxcVM5bTluUTQ1aFp0NVVkL3gvVzZoN3lOR1R0OC9VYi9Xb3BC?=
 =?utf-8?B?aEg4UTcycmgyOGVlZ3Z0T29ucXdDdkN6SzVFd1BIU2R4TVVZaWJVQlRrQUhP?=
 =?utf-8?B?bkpPNzdvNnF3bEp6ekFHRG9PaDZUa3JnSTdIQUlYUUlVMXhPTVp0ZExGa2FG?=
 =?utf-8?Q?Y0HkuGra5oku3MeKPeWJiQbdQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea975da3-bed1-4636-30dd-08dd975c6e7a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:09:00.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/guwDOwwV9tS1RcgC7jCD3pFcRXXrKp4D7ddtmNEO562yzs9Kcizfp30ksrnh0xPg5Ag0qQ9l9/F/MflOvdLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6488

Hi Ernesto，

On 5/13/25 7:40 AM, Ernesto A. Fernández wrote:
> Hi Yangtao,
> 
> On Mon, May 12, 2025 at 04:11:22AM -0600, Yangtao Li wrote:
>> I'm interested in bringing apfs upstream to the community, and perhaps
>> slava and adrian too.
> 
> Do you have any particular use case in mind here? I don't mind putting in
> the work to get the driver upstream, but I don't want to be fighting people
> to convince them that it's needed. I'm not even sure about it myself.

Now that some current use cases have already been provided, I'm curious 
about what the biggest obstacles are at present. APFS in the kernel 
should have better performance than a FUSE implementation. Are there any 
TODO items moving forward in this direction, such as IOMAP support and 
other similar things? I can't guarantee that I have a lot of time to 
invest heavily in this at the moment, but there should be others who are 
interested.

Thx,
Yangtao

