Return-Path: <linux-fsdevel+bounces-55633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72449B0D031
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 05:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEA43AB00E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 03:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E3428C2BB;
	Tue, 22 Jul 2025 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qnVg6DxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013067.outbound.protection.outlook.com [52.101.127.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57D374F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 03:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154201; cv=fail; b=ZzQJ1J/h3s7yY0Fbumm0D/aXL4OXSvGWwoWi6XDwev9DZu2PQzr3W5gexu84+Wvjyo6Zi8kD35TixUb2GqsobCZbOflbq3Hoywt0cLaFN0VXq4DKTI87BaOr2kLAzaLtJRmzwjCNiMlkRPm5RMhpd0PhwTM394B53kqcmC2jE6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154201; c=relaxed/simple;
	bh=pQhQiHVdKcPulMRCoumLSMccWJ0LGP22fltM3hA9Kgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fH2mQyOTE2JNVMn0/y4/liki8EdY7wfnvA8RMBnzOtwAseTASNWBUgy9YF28JfS8Drlb3gPY9PKlgfpso9SZKyu8pUbjSKz9G/Aqq9lM6kbIvtcWO7bv5+KuQXaqdFKLadvARakejj8YcmxYFEjeOmKYC9HpMOGJPtvyfxrKZWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qnVg6DxG; arc=fail smtp.client-ip=52.101.127.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hybJyMpS2us1qBVq5i3Du9w7BhrA8oLTRR74trELlri+ncQ/xHuvflxBB5nbapzBOAnp1Lf3SheA09tRpW8S3ztvOVIIurFbJET5oDmZT/Ai2QFarfcVYpMDo6kmFmZOg5jJkFA0ptkbF6//e06XH1TL1nrzB8f7kFaUQ7RzfE86GlwfmNAOGoCii85Ooub9Wdp4IJqeLC/yisZEMAHw6mcDFYD3CHoozDUD8rj6HB3mcbbyFqODaxHyDYObsErCuo8L/c+fqHQ+Tv5YGZyDDhx4KnOsR3dWJUibk2ta7GaKBIjqTenugq6eXliDPwsAna2kz/YXQMp97c29k6QZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfprNzlu8yeNEMtgLOpCVQGb8XcgbXIA1zBxx01whB0=;
 b=WBOON7S9ARvZEyFjnMJAB6rD5edAO83yMv8l9zZXtJBlIPrVPydfHZP0oZGDH9tWNMMJx5YZLlSyhLkySZOn9avdwdMZFtg23JwbrjAMsnI1iKuIjOKqu2Cg3ZGbBycof/saiUYFayuj3lp3GqFkI8eNbh9xtQWVDXXty2yAKzGfVD1apYEjeWa2Z6iRdAdB7diyHsxzc1WwTJ7doxG9G5nWdcinleQxJnTZbHCTrC4uLdJOMVzRuuJvo7n+eF4OHVqKsbp9okaY4sB1oz+KapPHFJuGIjfODsiAoG6U8gJqwpI1ouKBqBvUlone13UULhDwK8c3gczuu2EYOYtCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfprNzlu8yeNEMtgLOpCVQGb8XcgbXIA1zBxx01whB0=;
 b=qnVg6DxGH/y6Pa9tz29MqnCXZvBSxns2uo7TPFE1QZIHlElrvyt3XbFGJGN7qzSA7OxfED9B3D6ftt4X6f7H4Tv45zIEVUlrHc/e7AbWWhkyzWrbzFQefv+0riWArER7pDv1Pz31Vd1oD5QcG1fUNFNYhE8Uocz6GVTijfxWLSQ6H7hUDmeLMv/0xp6581HIAMiQylJvZaM/hDMQGU/yqN82NpQzaFiip4ptnd45hKGFfENtX6uakxLmSxjGlFjNnyxHiF9Oi6mE/WOG6dNagizAwfxiBNrfLbg9e93Yhg05rBZZBNwpsruqYplhg2+uqJZ555hwaJ+C/ZZcIMnGng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6996.apcprd06.prod.outlook.com (2603:1096:405:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:16:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 03:16:31 +0000
Message-ID: <278ef641-f812-4ea3-ba63-b3c6299f7136@vivo.com>
Date: Tue, 22 Jul 2025 11:16:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: don't set REQ_SYNC for hfsplus_submit_bio()
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org
References: <20250710063553.4805-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250710063553.4805-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 04870985-b340-47b8-ea50-08ddc8ce27a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTltQTNsSEVoRFMyODgwSTNNQzZSZ2ZOWTBDbEFMT3NaMnNYSjRoMW1GN3kx?=
 =?utf-8?B?Vm1sWjBTclRpNHBNOUxkdy9JQ1M0cEd6UkxIb3ZCVDhTdlZRM3RpRUt4aFEv?=
 =?utf-8?B?K0cvdjJmT3JGcnREOHM2bnJiVUFoTUJWbTdtYmJoVEFRcGhMbjFiYjJ6VTVG?=
 =?utf-8?B?U3hQWTdjRTJ1NnBvbXJ6bGlPMk5OTG85cktLUnZNbWtTbTA1NmRwQU9NVWtD?=
 =?utf-8?B?dnYxTERrd3BsY2NIMEp6bXh1TWlzU1lmNjBNRHJScXFYVTlPMUk2ZDNoUzA4?=
 =?utf-8?B?c0RRWUdlSWh1UmIzSWlBVDJDcWdzUldsZ3hjY1JLeDd0MTBLaVQ4MUtnSmZ4?=
 =?utf-8?B?Z1o0UjYxOUlUb3VBZ3dYczBlcEhZMklCNE01MDBMdEtsVVRWenpBM1hkRTUv?=
 =?utf-8?B?ak9FNUlSSmtzSFVHcDE0bU1iMWtRTDlYK1djbXV3VlJXLzNQSUZGWi9kcmN6?=
 =?utf-8?B?TFJrbnRaWU9BZ0c5S1c5Z1NocUQyeVBzTmZQSXU4THFVV2NjMmdLVW1KRWhB?=
 =?utf-8?B?Z0pqTlc0eExZSWN0RG0wUXNmMzJ2K280MXgrYjY2MFlRZENmMUlzRk5MZHF6?=
 =?utf-8?B?bzNYcHdwUG95VFptUUJKSjNtcTA5a3h3RmNOWlhPbkNrQnpZTjkwbXNMNEdU?=
 =?utf-8?B?RFJ6dGF0QUw2bGdQWWJMbVRvOVhrbWtZNmVadkIzZitwSEMwNHRTTG5ZR1Ju?=
 =?utf-8?B?aUZMdlhGMW5Dc21uSW4vam1PdnY2K2p6VjFodm45ZDlWSFBQaTJ4ZGU4a0hk?=
 =?utf-8?B?dld4dk1ja1BRQTF4V0FoR1lucldJSS9kSjJIVVVWZEN1N1NjL3R1YkxTUkVL?=
 =?utf-8?B?Mm11UDdLYnZkSDRmQUVwY2JHVGtsUGxrV1VxVXhPZzNGWFowVTE2RnNJZ0Ur?=
 =?utf-8?B?Tzc0bEg2VFU1UmpUNUJOd1d4MncyeThXbnVyOVR4Z2RRMFRwSFB1bTdia0N0?=
 =?utf-8?B?TkJPMVRxbUZkVE1aNVlIeko2bkEyc05URVZmc3RSV1BUMTFhOFRxZ09IK00r?=
 =?utf-8?B?ZFJKOE1GdG94SkpsYk9uNEFPWWh2cE1mOTNITVdkY1MxQmJwb2Y4V1JJMDhJ?=
 =?utf-8?B?QWg2QWQ2RjV2RkNXK01GRXVkckNFSDFjeW9oWjZaaGlXUGxab3FVT3pxQnBO?=
 =?utf-8?B?Qi9tZXdHYjh4SWFWNXlISlUvbTBmd0NQcGdkdVBoZDZkRUlPeG9YRnlQeEdl?=
 =?utf-8?B?QkxBSE9tWS9IY3JTcGVuUll4T3pVeWlkQVVmRjM5SDE5VVlVZXl0ZFFTeCsz?=
 =?utf-8?B?WGhBT0FEUXBwdDZRU0JrSkZQVlJLd2F5cGk0eEV3bGhoa1EwUis0dWhUMmhu?=
 =?utf-8?B?aFVhR2lxSWpRWHZpblVyZzM4UDZNU2d3Uk9vVnFLK3pPenlFSENxcERSTXNX?=
 =?utf-8?B?SzE1cVZxM09vZXFkV0hTWXdLZmEvOUc1U0FSRmZEbnNzSldoWWxTaUpOdCs4?=
 =?utf-8?B?NEYxdVJheXhZSUlPMURaOU5OTHI4N3ZGOTdPVWxhOEl5ZnI0UHVpWUNkTEpv?=
 =?utf-8?B?M2VYNTRMZ1BmOXVBSVN1akV5SFY5dW5aRnZ0dkVRUnU0YnY4ZkdYYkg3eTQ0?=
 =?utf-8?B?ZDJiTDdzWXV6R3g4Wm8yczJvRUd6cDBCalowYWloMHBUdzVDZ0ZncVhDeHFO?=
 =?utf-8?B?elNmY0JpVkNpeGpLTzFjSHpaTXQ2N3l6RG51RzdvTXNLa2diaktRNTA2ZFhq?=
 =?utf-8?B?YTQzMUw1TFAveW5IbmtEdXViemQvM0NmSEtHUTJZQVl5Ti9XT3Fhc1JWbkxy?=
 =?utf-8?B?aHBHK0RZeXlDdTdkSUh0OGdsNDR0R0J1MVpPSVU5cXBrSXlqbmRRbVFCblgw?=
 =?utf-8?B?Z3lxS1ZQMXVyU3pDeGR1Sk9RMEM3dTk1RjJjWlorR3lxREVicUE3L1FLTlZx?=
 =?utf-8?B?MVEvZ0Q5cUFrZFFBMyt6bXBnSXZ1SkhUREkxcGdsSVJlL3dtQVJIOGpGenpj?=
 =?utf-8?Q?cJEyz3iYNvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW5vZ1Q2YUN0cWM2V1FsMnZSdkJQWVR6Tm5PQUJmdStqcDBwc1RwQ25PQUpJ?=
 =?utf-8?B?VTNGcXZyakt2ZXBCclJUd0JRSGdhT2lIYitWdUxoMVZtQ2cwUVBMR011ck5X?=
 =?utf-8?B?UnV0TkYyM1UvdEN0amt4ajgvR0UzMFZSKzIxeVk0akxFdVFwbTFvYmxTVFlY?=
 =?utf-8?B?cUlIY2lJNlhiUFdzS1JvR2V6emRESFhhcEVTc0RWUG9sR2FVeFU2VzFjS2No?=
 =?utf-8?B?N3FyZ3Q1Q3BuaEg3WUw2NExRMW5oQmcrOTBsQVduODlBRndibGwrRGpaTm9j?=
 =?utf-8?B?UHROVnpDOVB4S1dZbFRobHFSWlhwQlBjaDJTZk9KcEIyUXRwQklNMDZobmwv?=
 =?utf-8?B?UFBRcjVQT2xqdGVueDJ2YWpESENMMmRXV2dCcnZwRXR0THBodW8wK09kZmZJ?=
 =?utf-8?B?Yit4VkZvN2RnME03cUI1REp6dTd6b0xUOGcwUVBkejV3U09XVThlOUw0cm1W?=
 =?utf-8?B?b0pjUmdiUHJ0TWNtZ2xQWkw3SUpDWW41VnVHVFJTaE95RVNRdnBNWGNJWHAx?=
 =?utf-8?B?VnI5QTNPZDVaWEpuTXdHVGlrcTV6eklqeUtEeXZVZUpPQ0ZMOHlMSWt4WUtz?=
 =?utf-8?B?MjhwcVY3V0pkVmRxNFhYeHY0YURSL3BVbjl4MERGbjVKc1Q0S2ZLbmdGN05x?=
 =?utf-8?B?UDJjQ1BjRVhoZWwyTmZLREkxc0xkVmkvMmhidElidEJlWmYzQysxRU9oTFl0?=
 =?utf-8?B?NEI0M3k5dEJkSEtqNlptRFJVSUZ0ckM2NzJaQ1E2cVpyRVZWa2dqVEJIOGNW?=
 =?utf-8?B?THdzelBRRWpZamJnNXVoTWtoR3loTFB4MHJqaE1qZTdYcGticWROQnZ6RTJD?=
 =?utf-8?B?azBGMFBjRmFBM09URUdZV3ZzL1YyRU1Tbm1XTjRiY1VFN2lwK3pseGovbEk2?=
 =?utf-8?B?Tkdzb0pFWndiYVRwTFh1TUh0YWRlSlEwZ3dsSjZodmQ2MlFRK004Nk1sK0RY?=
 =?utf-8?B?SjcyRlNRdWRGZ3ErdVd6cDE5RjZ1cGE5Y2JCMVZWL3owclh4T3lIL3pLZ0lt?=
 =?utf-8?B?NFRFNjYvUDAyRkdQUG9ZSDZKZG5sc0VqcWF3V0l1SmRNczlTdTNTZUNLL2Z2?=
 =?utf-8?B?UG0xZHhwd21UbEZRVlE1c0tKOVZpVERUWENGUHlSaFI1cm9SR1NEMTU5UHdV?=
 =?utf-8?B?UENiRmpLZjhWT2lVR2VPVUo5MjdoREdRT3dWU0dabHZ2T05xak9xaWdFQ1Fj?=
 =?utf-8?B?alJxQXp1M1RyYWxGSmRHMG9aNXRtZTlCckpLdkxrRmZzOTZpMnplRnJtZ285?=
 =?utf-8?B?aGlnRWNtSlBEVjh2OE56Q004QzF2SWxlQVA0VTUyZFQxMDZkS2RRRENrVVZD?=
 =?utf-8?B?Z001NjE0SG85K0dCa0IxOHpIT3B6My9uR0pzREdMWVhydy9CZFlqVi9iTXNE?=
 =?utf-8?B?T0lLeWQ3UXRSNkZOejBvYWFDUkEvVXNiaGVFQ08zeFAvY0dlNjVHUmFVOWxa?=
 =?utf-8?B?UXBkYXhQRVVMWVF2YzB0UDc3VERhVHp2eHJjWnBZUVlLQzFBN09TaGMrWFAx?=
 =?utf-8?B?SXhoY3A3WitQcFlqMnBmOG5qS0cyVlIxZ3FiQmpQY2NtYlp2Y3VkSUFxTlQr?=
 =?utf-8?B?UFpkaUo3c2oycDlLeTFOUGpPODhSaE5tcElyMTJVUEZFVUpWUXlBaHpLb0lI?=
 =?utf-8?B?UkVqS1NJNVV3Y0JGNzR5SjJGVXRYZFhpcnRzYm1tMnlIcW1lbnpqQjR6MnE2?=
 =?utf-8?B?U0huRTkvWWlHU0VLcTZWUmh3ZzBPSDZPNlhmMnpQRTJqMXo3UkhaWWRhTlFL?=
 =?utf-8?B?ZXBwWGFiTGdGQWExdmlxYmRxT0xTQXplTWJnSko3dWhjeEh4SU9RckEzdDR5?=
 =?utf-8?B?b3BRb0tsbjZVMHR6dFdVSWlJN2Y3QVdvY3NsQTc2ME4rTVRKd3dxYmZNd3Vv?=
 =?utf-8?B?amdTNkRKZjJSaE1hNDFYWURoME9QbHZCSSs1L1pLRG0yeWxGZGowNUhOREU2?=
 =?utf-8?B?VXlvYTY5VjRNbThLNTJJUlpVRzUraVBVNGg1T0lwOEtHOEErbkl1MDkwL2pB?=
 =?utf-8?B?VEIzZGV3WWE3LzVmTzRHbUVEQVFBaC9VRWQ0OTFBa3RXdG5ndGpYWXFodWpV?=
 =?utf-8?B?OUVQVWQrd3RHMFVTYkJmOVBxMjY4T0J6b2xGcnFoUVhoZXl3U2d2MW0rMjdI?=
 =?utf-8?Q?m8Vi29xaBh9rNBbxsJuRRHmhC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04870985-b340-47b8-ea50-08ddc8ce27a7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:16:31.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mG5IYqvl6Guujg0FR1YHTfONsV5AyCQBlD4YEWfyRqW99woAViuE6RxtbLabMaNrc3RrHvzNXExEtbFHznBTJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6996

在 2025/7/10 14:35, Johannes Thumshirn 写道:
> hfsplus_submit_bio() called by hfsplus_sync_fs() uses bdev_virt_rw() which
> in turn uses submit_bio_wait() to submit the BIO.
> 
> But submit_bio_wait() already sets the REQ_SYNC flag on the BIO so there
> is no need for setting the flag in hfsplus_sync_fs() when calling
> hfsplus_submit_bio().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

LGTM!

Reviewed-by: Yangtao Li <frank.li@vivo.com>

Thx,
Yangtao

