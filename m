Return-Path: <linux-fsdevel+bounces-49976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68170AC6994
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 14:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620F5188A76C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 12:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0E12857DD;
	Wed, 28 May 2025 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jBc9Jihu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011017.outbound.protection.outlook.com [52.101.129.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8A1E3DC8;
	Wed, 28 May 2025 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436066; cv=fail; b=NbeBWGgOBBhyDqCqJ/2q8j8kW4nmeCIlIlTgVjeIOriQ4QU4Z4HUoaf0Fnj/n9Xc7H3ODXG/VdMoTkrc6PEbxUsmyeiQIESIgPpuQIIgnjSKRCZpJTGNZYITxj7YsDskWT5pa8yn6lGhnRHHS+Kmr0Z/BGTj2hiX7sm5cBOM5Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436066; c=relaxed/simple;
	bh=z0VTXTKXi7uV/Vc/oHXZY3cQmqW6cacDe74bhHUufTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nPmex34W1apAWS08d2l0Lh+ilJc/UhBVEr7AuOLDZLg8wGGVccoK6gjTDR02n7PQguChxAfsmPx2lYJvj+S1roRp4mXTsTXvHYk/sZ3yfhUAQts/J+SKwapwBK19kKt7elvjI/ri6E9F+neRZ5zaXY6GXictNo5geHoAz7Y42OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jBc9Jihu; arc=fail smtp.client-ip=52.101.129.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRxITWxMwhCW2wdy+RT/dBSy7/+DgPiE4vTfT66ne7V4CIBwrSi6BoSPXyT77/rVzo3n5fEXFQV7evhqicSgjBsiNu5AuZ4S/lic1CxoWtYdwcRUkS3OayNi9VnU+ED8L10qC0fZxMWp5uGecz5xHcIppLrt0F39D8qqtsbmNfPFSILuWlwfpE2m/+AKeBVGwjqoGaaJqhrh+SrhdACF+NTwkFbkCndQi1l3EVZsTPp/jJgVq4bpdmNo3tvzYm1bdmOu8eeFLUVkBAlbzy8ea7T33hpGbozmiAypY3po1Z7SYO7YQ5NB7g25oZChPE/L3QKEi8kbidKGcvXxQj6fBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfSyS/h6/bPgExJSqVXV48aVMpOxhRdl2RTfPnV66D4=;
 b=Xl1KWaqednz293wc80T43cWHZESK/Gy9o2HCD4JDZ317x2N87Hld1LRbc92ml1XxdNFzC7Q7/B62H/kws761ZvcRpqMKLXNTadkf61eY6BW5xQczIHIaYijK8l3SHFp6E9TBuagZUJtL5ZdXfwuVvXH4x7ygiS/rKmCArsQMOUgEcthC7EoPoGEWqnK/jEUPceKLGLb0YcxhkDKhigSS3+4w6vlDz31NpdzXRd56HKGFjRJjaakB902AMizlj+pSJlyP9V/MB/HhmZkAAnSP/gRZyL3sFUZIc9MjRyTscCX3b91kUteFaZ9hsx05wiUdYpCkfX/OFBVpwa7Flx2U+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfSyS/h6/bPgExJSqVXV48aVMpOxhRdl2RTfPnV66D4=;
 b=jBc9JihuSdlSu/qs0DW8fRCMUXzxsmXHDrJ0uXSE3gWlwlwJ4T5y1oyehCKpGLd+EIjNfnftW6NA4lNNL7rMg+JkrvsgkG7CHGHeRRW7xFZVc942qpdpymZ0WbAyzN3y/4Nup+QZN821bwVcOrWyGzpswyJmPzYqjIYQY3YbWdhlRjlp3rXPymd/1Fs5DmOtoA4BjV3344cJh8DiE4Jy5RMzKd9d6llwikRib1fcIlb/ck6u15hqU9n17bvSR2T5wyvT2jLKM3qrCg12Jgg5z2WemgF1TXw21n/OOMPmXf5R3JzaXfsqlECCtoWl+lt8aygn0UwSrlqP/ZyIZuu4Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6303.apcprd06.prod.outlook.com (2603:1096:101:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 12:40:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 12:40:56 +0000
Message-ID: <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
Date: Wed, 28 May 2025 20:40:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "slava@dubeyko.com" <slava@dubeyko.com>, rust-for-linux@vger.kernel.org
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c78d4c-6796-4449-71b7-08dd9de4e415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjgwbEhlVUJpYjllY1hFNDMrNmxST2NLWWU0WDkvTTl4M2NrUXdDN1VudVZP?=
 =?utf-8?B?T2ZDcFJkaTNKeUc5OG5kN1ZmYVIyZHMrUGw3a3l4RVRwRFgyMVZwemZqaEN1?=
 =?utf-8?B?MkgwT1J0QmdaTTdzbmkzYzh6djg3bHFJT3VUbVduYTZPanZLSEVtalVaWjNB?=
 =?utf-8?B?WHhtcFlNaS8rSjBIV0g3YzFtYlZ6OG5FeHB6bU5ldkxuV2FpVVlrK2JQUm45?=
 =?utf-8?B?MlBPUmVCVjVibkNLR1Y3Vkg5cHlRK0gzZGN3N0c3dUtTaUc2VXZGOFpwaTUr?=
 =?utf-8?B?V2hjMWhDMWJQQW1DU3JUUDFTbHFtNUNLTllna282YkkzamZQMm5OamxWUWU2?=
 =?utf-8?B?enlLYnAxVU84b053NG1zcEcyV3VKaHdtek1mRU0ybTNYakRQcHFFOFJOdDh3?=
 =?utf-8?B?TzU2RVQza1Z1b0JrZmZWSHdWai85QUFJd0hBeVJGSXZyU2FyZU92ckl4bXpz?=
 =?utf-8?B?NjF1WlZ1TzVhSVBUTE05cU1kcmRGKzR4Y2FMbFptNU02S0U0QVcwOEd4OWcz?=
 =?utf-8?B?MjV5MkZEc09BQSsxcnRFRlk2TkE4ZUZUeXkzNjAvcUlMWnpsM1hqR1lMNG5L?=
 =?utf-8?B?NGl3a2NjMDA5bnd2cWhoSks1aG9ZNmdDSmc5VllmSStDRFA1eUVrL01PM2FI?=
 =?utf-8?B?amVNWkh5OGV4YVFJbFhZNjB4cTUrOUh6c3BEVjd1bmtOQWN1Q2Z4QW53MDNE?=
 =?utf-8?B?MHpQOVhlU28wc3plZ2U5UkMvb0RGYjFuQm1GQ3JyQTR5ZGNCRXlqUmNBRnBB?=
 =?utf-8?B?U1JOL1Y3VXVPc2svWmZQSkxxVlc2M1FndDUyRFR6TWJVcEk3U0xHNGNCeFUy?=
 =?utf-8?B?a2hJLzZuTWt5dG8zZUlmb1hDcGVHNjFuVzNWUXBzUWZaWXhXVHhlM3ZWV2Zw?=
 =?utf-8?B?czZ0N3hkeWJGbE9aTXowc3FFY0tMSjhnMENGbGdFTHFGY1NDUXNHSUtkc0lh?=
 =?utf-8?B?eXcxVWMvdCs3V0MvM1R1Zm1CMFR2c2VVTnYzQVArZEZVZFN5dW55a2x0bm9q?=
 =?utf-8?B?VkphQlBGQnlkM3puekgxNXB1QzdEekxtVldlNmY3VlhQTndGTVI4aHNibUZz?=
 =?utf-8?B?Z2dpVmUzYzU5ZXZxVFU4MkFnL292UTBGUXRNYTJDTm1tQ3JKNmFVYUdSS1Yx?=
 =?utf-8?B?UEZXNlN1cmprd2xvL1ZBMDUzZk4wQURrN3orT2h2ZlhId1pQZjdkNkxqRWRV?=
 =?utf-8?B?RWc0THpKcndxMWUxcUVGV2NKWXNzYzRqTXRyZWg1VnJWMjdMcGVxUGNMamtw?=
 =?utf-8?B?NTZDdlpOajJlQUNzTjlHazJubTdwcVdmNk1pc3g4Rm1FeG92bXB4Y0xxZlhW?=
 =?utf-8?B?dExEK2lCRDg3TXBGOTJjc3ZVY0VSR3VlNXZ5MVZkaG5kNms0RUo2c3NYdnFM?=
 =?utf-8?B?SUVlYW9kS1JYdEJaZWhUblNvZUpOSjRBdDlha1R5WmdMNFZJbllrRGtBa1Jz?=
 =?utf-8?B?YU1Ub1VIZlNiZGE5M1JFVkdRYnlZUFdZSVF3TUpENW1ZcExXQU0yRjg3RWdo?=
 =?utf-8?B?QUN1S1p4OWVEdTBjWjBnWjJ6NGhUUCtTZmc2UnFCbFdBeWgyaUF5WHVBZVRy?=
 =?utf-8?B?VTBpbHBnT2ZKL0FCZWUydk4wS0YvMXpQOWp1WjNwSnpxM1VHNklZSCttRlg5?=
 =?utf-8?B?MG9xQVZxNGlCTnNoWC9xZlZrR2VOWHpLVFhLNDBQeFB5Y0sweHZFSWhQek9H?=
 =?utf-8?B?WmkyOU5Lb2c3ak0zNXlTUE50MEpJUnBZV3FlRlZqbll3Ukd5Sys2K0Riam0x?=
 =?utf-8?B?VFhqaFN5YTRrTlRYWHVqYmdCOVgwSTY4Y2w5UGZFakN4QTAyMGF3MGI4ajZq?=
 =?utf-8?B?MWRNcHN6Nm8wa005OUtWQlBGTG00eDk3clZQK09GUm4zaEdva3Z3WTRMNGha?=
 =?utf-8?B?emRIYlFORXpxMFl3Vkc0WlR5UWJjVWx0WEJiQnZzN0djbTBhMVVDZ3BOc3hC?=
 =?utf-8?Q?pjJ1v4rGvKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVVTMTVyMUxNMWNaQjlZYjB6ODJ4NFZaUzN6UC9EbWFFaE81QW9RQ3o0VDBQ?=
 =?utf-8?B?Q04rSnJieGdFTUNFZU1xZUNDaXJwNVl1bmd1TVpKQ3RITnVxOVFjekF6R29X?=
 =?utf-8?B?QXFJTjA1Z1JWYSszaUU1NzE3WXpJb3FNQm1MS245NThOT0JSb0JjeTJxSUdk?=
 =?utf-8?B?aWsxYzE0R1poZE81QWFWbU4rVTBqaVgzSHd2L0JybnhNdW5xMFNjRmVqeU5J?=
 =?utf-8?B?SS9tanVtb2ZoZStLK1hUQm1PcjJDcEF4c2RqYjJFWERyODZ4cVp0RlhvcSsx?=
 =?utf-8?B?bS9UTkdNQWRXV3pBKy9zWU5QdnJuTVR2cnZLNWVLTmpQT0hBN25QODIrMkNv?=
 =?utf-8?B?TmFFOHEwcm5RYURMbHA4QzRGNlhIVDJKK2MxZTI1RVExejR1dkxpbFRrTks3?=
 =?utf-8?B?VU5GdVFLTHhmUEJRU3VBTEZmVnV5MjNDN3I0VlZ0VlhVMjMvdUdaZDRURkZL?=
 =?utf-8?B?NkZYZzZhYlBFdHhOTlhnMkp4M1JNNHFBcnQ4QmlSZFlBeldRUStFaWVqbEZC?=
 =?utf-8?B?WlhpV2ptdEZKMHlOdGVIYkNiZXR3WDN4QzFaVjN1azFqSTl6ZlVpWTZCVDJl?=
 =?utf-8?B?MGJvdGxBWkFWYlg0cDllcFFWYXlUaEt3MXcrZStSQ3o0MGFBeUk4dExnak1O?=
 =?utf-8?B?T0Z2NjNTNktpTmVSUlJ2dEEyRFNjTHRvYlM5bzRPaDJmTXpBL0NHeUdGazRF?=
 =?utf-8?B?V2MxYjB4d1d3NlJVczE2UUdaQ0RVUkEwWW9sRWpCek8xek9sVXRnOTFTczhQ?=
 =?utf-8?B?blBqaUZXcDVpSXhKV1Z3N25XTmorTFVyM2RGdmE1OHdsUVFWVmlLd0RWRE9N?=
 =?utf-8?B?ZzNUWTJ0c0hCRGJLT3lvNUNIOEJZNW11VmNQbndyQVlsSHhDbXdHMkZsSjhn?=
 =?utf-8?B?cWdJLzJRdDhscWRhM1RSanlJTGJjQ1lzSFR6MjZ2UXlTbXd4ZXF0akNncWdq?=
 =?utf-8?B?YU9aN2VLdEJsVlVjZWFGSksyK0F5eUw0MDkzeG9KWkhLVWFkNlh6Zkkva1pl?=
 =?utf-8?B?NW95STdSbVpHNXpPM09rLythTE80WkRpMFQwVm5PWndMeXJTL2pUcHEvOHFC?=
 =?utf-8?B?aS9pUEtGMzlLVDZXcGpCNTBpQ2poT0tjdWdSTDQwR1k3eHhoWjN5QmNvKzM3?=
 =?utf-8?B?SHo3RnRxb0RmMStiUXRRTFFWNE9vdWhyMjdaTDB0dVBjZVdmTGZmMzdWc09w?=
 =?utf-8?B?Mml0Zk5KSkYxcTBaRS93NHQwMjBLUnR6VTZ1c3huRWt4MjBUVUIxS1FKUFd2?=
 =?utf-8?B?V0ZVbGdmeDBLMmdMMjlKdEM5T0xPRXZRaGVKTmloMnE4cUhaeS82SS83S0Jm?=
 =?utf-8?B?dUI2aFFEQm1jYlQ1clIvc2syMEVEM0VGUEl1Z2phU3g0YXlITVdrY0NYVXNh?=
 =?utf-8?B?czhiSnV3NzJZY1JVODdnK3kxSWhHRnB1dUZHN0p4YVFhdVd3UG1TVmp4SllE?=
 =?utf-8?B?OXJGeWQ0Q1lCUnJ5c3Z1WEI5WThyeWNBNGF0M2ZwTTNuY2NuTVZJaXg4bnBp?=
 =?utf-8?B?Z1h3bjVYaUM4TkhHRFpJWmE2VmE2WXdFVVJpYjZndVB3WEJnZnFIK1dPd29s?=
 =?utf-8?B?STRFNEowMFVlOGVIdkZjeTViblpPMXJ6SmZHU2h3OXY5bHdneFhCajFmckpJ?=
 =?utf-8?B?dHI4RWpuQ3ZqaTRaamZZanI2VG5MRzkxbFBPSzZMQzdZdnJhejJBZ2FiQndR?=
 =?utf-8?B?ZFFsK0hqN0Z6RzFsSnZnZDk0UDkwL3dpVkhmL2ZwNHpHb0NERWZZQ29Fb3M2?=
 =?utf-8?B?dFZCSjNpaXVOWVZkN2JrM01rdU83OHhkUTJjMVVmblVHanlycm1jdmtvNzFN?=
 =?utf-8?B?SmdDdHlWcTAwM0tBYU1xZ002U0VwSzVNSW5pZXg5ZmhKVjVpK3d6bWFmVGJs?=
 =?utf-8?B?V2E0bTVEeXh1cUdJd0lhRGIya3kyZnNielRPTXQrY3c4eElORlBNRUNFNVRD?=
 =?utf-8?B?dTYxU3FVQ1Rjc2pvUHEvVS9RTzh4TEJCSmpJQXVqcVJRaFdiNEJNTjVvR29t?=
 =?utf-8?B?TlUyWXNraEdSN2VKc3NRd0lwWVBxbHlRWDBwZ1VqYUVIUndqRXAzWEtVYkVQ?=
 =?utf-8?B?QnpwUERwL1diUmZQREYxQ1Mxdm14akpmeDFpTmEraVFGQ1BxUEVhV3kwNGE2?=
 =?utf-8?Q?G2vys16Y2Ue+aSxQBBIn/KH4Y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c78d4c-6796-4449-71b7-08dd9de4e415
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:40:56.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOVtUAZRjTpDHTy9SLHbPKqUZQz6LYxzvWZgAYD/K/rmvKD5uXZe9fQIRHjdmFOcQn3hDPAqlutbX6KsMetsCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6303

+cc rust-for-linux

在 2025/5/28 07:39, Viacheslav Dubeyko 写道:
> Hi Adrian, Yangtao,
> 
> One idea crossed my mind recently. And this is about re-writing HFS/HFS+ in
> Rust. It could be interesting direction but I am not sure how reasonable it
> could be. From one point of view, HFS/HFS+ are not critical subsystems and we
> can afford some experiments. From another point of view, we have enough issues
> in the HFS/HFS+ code and, maybe, re-working HFS/HFS+ can make the code more
> stable.
> 
> I don't think that it's a good idea to implement the complete re-writing of the
> whole driver at once. However, we need a some unification and generalization of
> HFS/HFS+ code patterns in the form of re-usable code by both drivers. This re-
> usable code can be represented as by C code as by Rust code. And we can
> introduce this generalized code in the form of C and Rust at the same time. So,
> we can re-write HFS/HFS+ code gradually step by step. My point here that we
> could have C code and Rust code for generalized functionality of HFS/HFS+ and
> Kconfig would define which code will be compiled and used, finally.
> 
> How do you feel about this? And can we afford such implementation efforts?

It must be a crazy idea! Honestly, I'm a fan of new things.
If there is a clear path, I don't mind moving in that direction.

It seems that downstream already has rust implementations of puzzle and 
ext2 file systems. If I understand correctly, there is currently a lack 
of support for vfs and various infrastructure.

I'm not an expert on Rust, so it would be great if some Rust people 
could share their opinions.

Thx,
Yangtao

