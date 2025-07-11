Return-Path: <linux-fsdevel+bounces-54584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75908B01154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 04:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886F77BD03C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 02:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9D190477;
	Fri, 11 Jul 2025 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pe64xcqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012030.outbound.protection.outlook.com [40.107.75.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF88155C87
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201674; cv=fail; b=E3vF67g9FGNyc1ixUU3xVhv7NGDJ2XcLZVTqhfjsZQ0RP2Qga6w1JVu+KfU0geDNsWLM0v3LX+/ajquRlgbjiNujarnWtFkoDjNK1TwpCJUbuWrzjLAiH5mmS12ISJnGZY3rqVoNFzo3CRZdeTITouqWdpYBiasMFikmFoOxer4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201674; c=relaxed/simple;
	bh=YtXfYLgChp0C5g/G8WoOe7ByXRlnzHidnePMqiyLSuI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHpP47yrpV80jFVWFve/aCXvpwsOcxP+jtMhaRF6Te4k8XSuzy+S4HjCkdghxoeepI5rtcfTnytQ1/rQOPI77OzMoejfgcqTjDHo0QMvLDysLPYIwYnGQslS+Ex4Z+/ZFHgsVdxjVE9FHUEvkmAiKKHt1qusAdJBpfYZmtu03K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pe64xcqb; arc=fail smtp.client-ip=40.107.75.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzAA4Sy5yr0QUyF7Uou7a4FhfrabOxVGPtfU4HExGQCNy6Qf2TfpH3SUDCKGvPNYsDv5yKope2t4W2OzxA/1kl8nwC0RDnVknF2VLDamh+Pdg/AS5DiL+39KWE/IrACWUtQrHIVksOvIbGOv7zCr4ZXaiOg+1OPszeOmgkoWiXclLTiEMO8kuHfaY9gTif9yon4qgm9Ase5N7BISVs60A+/GZo7NSOMc8pQhqtvuOYINjXVF1vTAdp+HHF3E3xfAEEBy9z/2l8hYLOsgbgVe4mF38ImPcfndCvJwYxR1iYK8QE2uVMoGwN8w3qMITSQn8TpOVDdakgGHlj75UrZQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJqOOpvz+vPPxss8M6Au96lX7maPY1tfLdGRIkxdfWI=;
 b=h8BFkRB1lzZTOFoy9ZIt18TvLpsbaWG6V3T6lFJ7JHLrWYefwA7P8FbQydeLKogw/gAJ8BLqONd52J2ubCqEcauLbDA98phFc5z1YsaO5TM2eOvLuRDY0UIy5JheP1s3/HS1SpGWIJNpLnEa3GKmT/EqPPEzpJSMqGsqKwk1Hk+0VKAF63BQlMHn4uDa+74fniIFs5V7KD27FWo7LJxbVSegBgrb3ic2QKknAp37vEO5htsXpGoR9LZq+9ZZDD4tFquoOEoxz0mqE1SPnh/JKBpHaOIR+YYL5kQ9wRTeIomsoucdcRxFNd87lY5paWClJGOxuGD146vO2ARuckNToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJqOOpvz+vPPxss8M6Au96lX7maPY1tfLdGRIkxdfWI=;
 b=pe64xcqb341rjq/XY6gQOnUftydyVunnZ7UgcG8CuaCxTqzGpcNcPcDc1sWL6U/duyz2sJfCutV+skBjpGmj+BM8uYEP17q0lWs8zUpKCGw9c0VH089X0c+uRe2RSfaOi6s0cwZgxKeIa9gk+vPyZjYVnNY5nxZlckynodHZpx3WlIpiO7cvMWKnkddY4z6VCAtzqyybxj4jNh+RhHUOPGdsSCKqRLY6Ml3d/PAt0NRlpanR6HonGZXHXn4lhKBd20HGhjiFddlYKbkqr1QoXB8U8WGD76XDH3IpaPhey4Uq/uyNzrs97upnpsMowrPxFgpzCy2AKZ4F6F6skTKSlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 02:41:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 02:41:07 +0000
Message-ID: <a52e690c-ba13-40c5-b2c5-4f871e737f72@vivo.com>
Date: Fri, 11 Jul 2025 10:41:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfs/hfsplus: rework debug output subsystem
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org, Johannes.Thumshirn@wdc.com
Cc: Slava.Dubeyko@ibm.com
References: <20250710221600.109153-1-slava@dubeyko.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250710221600.109153-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: e95d92ae-2608-4765-0070-08ddc0246360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODYxeVlmSzdaMXZZa2NTUWZyT29tNXFiYUxBOWsvdmFYNmY2OFJOcUdWay84?=
 =?utf-8?B?Y1U3NlJ2YnR5ekF6NEFzTGlFNE9Odk1oRk1BS0NnRHZaMzhFQVlvZGVRcDNG?=
 =?utf-8?B?elI3T0x1RlU3Y2VxVjZsWVJoejVhNTdMa0JUUEw3VjFvS3pZL3RHKzBCdWww?=
 =?utf-8?B?YUQzWm11L1NPWlNybEs1czYreTRIYTNmKzlWZG5IQ3VzWDVpSmlyS3kvM0Fy?=
 =?utf-8?B?S1VQcHpKNHg1TElOa2Z4REE2dk1PajdUdHdKVWNWUGlSTGlDVnRLZVNLNXBn?=
 =?utf-8?B?ejNucEdpVGdmendhK3VZK2xWZHhrQ2tCYit5Kzh6NTJDN0g2TUFwcmhPZGhq?=
 =?utf-8?B?OXFROUt6MWNDdnBpNURwY2wwVERqcDViTzhaakFBYm9WeFZuOUxIZnRVaEZk?=
 =?utf-8?B?OGFMSHUyTmxYaG44SmNtMWRmQzlSY2s1VHZQVDFCaGJYR0EyMEJBWGJvM2FU?=
 =?utf-8?B?Um1VRGZWdUphbGlwNzRvbnM5aUZGVnZmVFJidUdvM21lcmNZUUp5U3FLNHNF?=
 =?utf-8?B?S01VZ1NCR1RBRzJCMURXYVJsRkE0bnVIUmxVU2VTSlhCWDI1aUFTY0ZXT01B?=
 =?utf-8?B?Mmh4cUJyV3hXUk9mUEhmM2NPWXRXeXFPMC9mQ0ZGTzNPTGl2QVNkRmQvWmND?=
 =?utf-8?B?dzB1b2RMNk5sOFp5MkpVdUZOUDFDVGVYbURIQndCeUYvYTdGdFRJYUsyWWh1?=
 =?utf-8?B?TGxWSEFZOFpwcHJiYW9ML0JIOHRtRXhSMDlSUnZRUGMwMjVvMWNBQ2hueVgy?=
 =?utf-8?B?VUdYYUZ5NE1FQmxJMWRWNGtQbDI1aWtLcURqcDNQMXZoczRlY0ZKZDNNc3cz?=
 =?utf-8?B?RTZWN0UrUEdRZUpUN3ppR3BBbDA1UWR2ZU1QdFdCbjVyVC82YVlHNTNwUDl4?=
 =?utf-8?B?aUZMTVNqZ2MwT0dBOWthVEx1anJRMFEwa0gzTWg2dXp6VlNxa3pIcFZPVDJl?=
 =?utf-8?B?em15cXRwQU9udW5FV2RJdTBlUnRWR2owRjdjM1QvTWxkc2VpS0lLSHROWnc4?=
 =?utf-8?B?Sml1L3FwNlJrd2x2b3Qzc2JyOG9KU3AvMTI2ejR6SHpiUis0QU1IYVBxNXlJ?=
 =?utf-8?B?WlJ3ZzMzdldCWmgwVTBlandjRjVnWEdmQ3lOMVIvMHB6QkU1aXdraU9jOGFr?=
 =?utf-8?B?RFdSeEFhcjFPTW9TQWNUWTA4UG9mZDc3VXZ4aDJSTnVROHJXK3BJLzNFTjF1?=
 =?utf-8?B?S2xKSTExUzc4Z1VCdElvZHJHczJWdnlCeXVKcGNBeUdzd284U0NnRm1tWVZl?=
 =?utf-8?B?N1hydEUzY2pvUWJIenJydDZFVFo2YkNxcWdoM1FaRFlDTXVEbmxkNTI3RUlh?=
 =?utf-8?B?c25vTitqQjFBbXlqc3BWRTNWdkNyQU5lSnBTV3lEckJyNGNGNFM4Y2x6WkVI?=
 =?utf-8?B?Y3ZBcEhXVXdhWUpxTmlNU2h2K3JTNCthT3ZLSXg0RlBZT3NSWVBVZEFKdDN5?=
 =?utf-8?B?dUlpRW4vVlJzcVFMUHFWUFk0V0czMlMrTUYzbmw4T1RmSTFWZG4zRU5MZEg2?=
 =?utf-8?B?VSttVWpYZ1Y3b3V6emtudU9yMS9IZWhhWGd6OUtaM0FON01tNFA3WlZrUkV4?=
 =?utf-8?B?aVlLcGVocUE0c0RUMjVIMzFORWN1Tms1emViQjQ3WEU0WXM3UkRGcC9JUXFP?=
 =?utf-8?B?anUzcnRuRWREY0xkSzFQa3BQaUpYcGM4b2haS083dEtIdEVtbWM4Nm1pUGIw?=
 =?utf-8?B?aXI3cFdkeGJpZVRNRzIzT1VHMGVlWkNYYmovVU5CamNuWFNMcktxU2NmK25U?=
 =?utf-8?B?VzQ5SG9jMXRKaGJYeW5CL0V0RVV5cS9ic0N0UUV1TzBKZkJLbG9pb1l2T1RZ?=
 =?utf-8?B?NzZoVmsyak52L0RMVlJyczZFNWNCQjlwUmc1Yk5jelZaWkFZMWx6aEI3dEk1?=
 =?utf-8?B?Y1g3bVV6b05neFVGVzl5YmtEdURSK2I1aVlUb1puNnF3YkswZVJWQjY0eFZ3?=
 =?utf-8?Q?2HHkrG7ZmWc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTFUeVU3b2ptS0R3c1JFZSs4MjhxdWwwRllpUUpnYmtlb3BUeXcxNGlSZTcw?=
 =?utf-8?B?MUNpM1FGZG9DQnkwUnRSd1JIbVVTbVdwWnhLOVpURm1qM2YrbERzMVNZRFgv?=
 =?utf-8?B?cDlpTTk5VFphNlJTNUROQWdqZTZLN0lnUmpJc1lMZ0JNd3FXWloyWE1VK0U2?=
 =?utf-8?B?QW1kQjRTTWxmaENEbW1XTXE3UGZsME9PNlhLcjl0NXBSSWJpa01RdWpBeisw?=
 =?utf-8?B?eGhWektGL1ZtNUcrTG1VR1Y5ay8rTmxRa3dtVmtSeSs1eHlMK3dKSy85OXUz?=
 =?utf-8?B?cG9UYW5qeWJzMVRjMExpT1hPSXRwdEhoWEhrREVBcFVUTGloT0V3dU9oOGhZ?=
 =?utf-8?B?eXQweWpOR1g2UDVvdnUyVnFHRkcyQlFRUzdxY2RkVDJlc0UzK1VzdTR1NG1X?=
 =?utf-8?B?N0pLek9xT0o0bDJRa1BScFBNbUc2WFVoMkJuYm1OOElQU00rMDV4ajIxem1p?=
 =?utf-8?B?NkY3OWFXbWZ4K3gvS2xTWGlzWDJ6MjhCQitqeWRDMXdhWXIyNEt1TCt5cE9h?=
 =?utf-8?B?M2FKVXRsVmdPeUpmQ3dEbHl2WlRybXBxK2FHZTJ2Qk5TM2c1RHIzOElxSEFY?=
 =?utf-8?B?ZDJKR09iaE1GZ2xlZTNJM0xkNzBLK25EdTlRSmtpRXN1T3l1b1lBMnZyWmRI?=
 =?utf-8?B?bDNvOWFhWVVqM2RtaVlkNFgyY3ZSTFV3Z3VMQ2d0Y2hISVl5amd5TUd1Ti9p?=
 =?utf-8?B?cm54K3QzY2pDRXRVZWdhbGNVYUMzeUt5SXpib2p2MnA5V3lDbjFmTlNLQ1Vq?=
 =?utf-8?B?L28xNHdFL3F6ZGFMdXJWUm1jcm9MS0Y4T3U4aUVDNWVaRTU3eklDNFlKRFNw?=
 =?utf-8?B?MzNDMGppaDJjRGZvZ2s1TjZsTUdONGxxSWRDL0VIZGVTYU5jVE1qOGVqWkQr?=
 =?utf-8?B?cnRvN2NNSFRRZjJGeCs3b2YrVXVGbUw5UXBZRk5FQnhyQTNvVExyM1ZyWXJh?=
 =?utf-8?B?RmgxVDI3aFB5TGs2QzdxUzRDdzZIUmh0WTN1emhKaWlCR1l4aU1xNElkK0c1?=
 =?utf-8?B?K0twdXZ0bXpLUjdJWVBuUyt6TFlsamhFekhlZGhHQmVSZk5vVXhKd1lTbkIy?=
 =?utf-8?B?K3c1UzUyZmRpOFgwTWZiV3BXMEs5RkZlQXJrZFh1ZXIyakdQVjBkZFdkMFFP?=
 =?utf-8?B?V1VtWm5ERmJmMGFHejlueHJLSVc4cnVGR2pWQjRTejZwR3BMbk03dDN5S3hl?=
 =?utf-8?B?cDhkUnNWbm5PbXdrdVRMQjI2VDVVT2haRGg1Q09xbG9PemIyM2JZQmJGdVNE?=
 =?utf-8?B?RGd5RGtFcDdJaTNEVzhjWWZhVE9hVnRzNEZsVmp5UzBIRVJPWlhoNmRaemdw?=
 =?utf-8?B?RVZWZk9UeHpyOVB3SENndEhjNVRLR3d6OVd0Q0Q1RUt5djdjTVBualJoUkRz?=
 =?utf-8?B?bjNrQTdTTmsydm1STXRabFdPVWI0SGx3OWVFNTNuWTE3cmozZEtZaWpxQXVH?=
 =?utf-8?B?NWxHdHNwdlgvYWxFVmoxV2EwM2t3cW1ML1gwMzAzUUFUNjNYZE1CdkUyT3Z5?=
 =?utf-8?B?MXlPb3V1a3hEZmw1K2FUaW9LM2oyZS8xZjdVaGpZTlJNSXRXbTREY0s1ZW81?=
 =?utf-8?B?c3pHWUVGNCt0UjBqb2xaZmhBd1pvekw3NmtqQzlPUUdCSURWWUxjc2c1VDZB?=
 =?utf-8?B?MWJkalRka1dTOTBRS2RKZmlDY2swanBFdUVVbDhHd2paTHdyVmduZ0czaFdK?=
 =?utf-8?B?WEdIT3pNZEc1Ry84QzhXTUduMlhaWlRkakhwNDNHcHIwbHBwTWR4NHZoOEpr?=
 =?utf-8?B?SzFXSk5ucnpVNVJOa1hXR0tXTERHQitORjhoMjdGT2YrdG9JMkRRaFNSd1Nx?=
 =?utf-8?B?R2JKNjRvSURTaCtRWjBPSE1ZWHpGSldITGg3NkVZOHVYdEM3WHBUd1BkL2Uw?=
 =?utf-8?B?VlRGU3d5K1l4ait0SC9Eck9rTjJpb2k3K1V1bFFNZDExR2JVMkFCMjErUHZB?=
 =?utf-8?B?TTZIcG5XZldVMUZoM1pIK1I0SE5uaVgvNDlnM0h4cUdzbnNMeWlpWXZERTQ0?=
 =?utf-8?B?UTNtV3dNR0dpYlZuQzBZMTJXU3pibm8rRzR2WWJROGRLdlMxd1NtVXFhZFpZ?=
 =?utf-8?B?NTJkYm5mYzBTdHpKVW9ZdzNxc2U3aDBiNHZqYnU0RXNOZm9GS1lMdWpJUktx?=
 =?utf-8?Q?iJuY/IW60JoSuUs8jdTaKO6WM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95d92ae-2608-4765-0070-08ddc0246360
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 02:41:07.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54WQWDbrErkWPrBOwnRrfSpQATXYJ6XVcvWchLqa1oQt2NfIsHYbLNrhA2DOnYfQucBBWCU92l5xzflnnLvsMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

Hi Slava,

在 2025/7/11 06:16, Viacheslav Dubeyko 写道:
> Currently, HFS/HFS+ has very obsolete and inconvenient
> debug output subsystem. Also, the code is duplicated
> in HFS and HFS+ driver. This patch introduces
> linux/hfs_common.h for gathering common declarations,
> inline functions, and common short methods. Currently,
> this file contains only hfs_dbg() function that
> employs pr_debug() with the goal to print a debug-level
> messages conditionally.
> 
> So, now, it is possible to enable the debug output
> by means of:
> 
> echo 'file extent.c +p' > /proc/dynamic_debug/control
> echo 'func hfsplus_evict_inode +p' > /proc/dynamic_debug/control
> 
> And debug output looks like this:
> 
> hfs: pid 5831:fs/hfs/catalog.c:228 hfs_cat_delete(): delete_cat: m00,48
> hfs: pid 5831:fs/hfs/extent.c:484 hfs_file_truncate(): truncate: 48, 409600 -> 0
> hfs: pid 5831:fs/hfs/extent.c:212 hfs_dump_extent():
> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  78:4
> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  0:0
> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  0:0
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> ---
>   fs/hfs/bfind.c             |  4 ++--
>   fs/hfs/bitmap.c            |  4 ++--
>   fs/hfs/bnode.c             | 28 ++++++++++++++--------------
>   fs/hfs/brec.c              |  8 ++++----
>   fs/hfs/btree.c             |  2 +-
>   fs/hfs/catalog.c           |  6 +++---
>   fs/hfs/extent.c            | 18 +++++++++---------
>   fs/hfs/hfs_fs.h            | 33 +--------------------------------
>   fs/hfs/inode.c             |  4 ++--
>   fs/hfsplus/attributes.c    |  8 ++++----
>   fs/hfsplus/bfind.c         |  4 ++--
>   fs/hfsplus/bitmap.c        | 10 +++++-----
>   fs/hfsplus/bnode.c         | 28 ++++++++++++++--------------
>   fs/hfsplus/brec.c          | 10 +++++-----
>   fs/hfsplus/btree.c         |  4 ++--
>   fs/hfsplus/catalog.c       |  6 +++---
>   fs/hfsplus/extents.c       | 24 ++++++++++++------------
>   fs/hfsplus/hfsplus_fs.h    | 35 +----------------------------------
>   fs/hfsplus/super.c         |  8 ++++----
>   fs/hfsplus/xattr.c         |  4 ++--
>   include/linux/hfs_common.h | 20 ++++++++++++++++++++

For include/linux/hfs_common.h, it seems like to be a good start to 
seperate common stuff for hfs&hfsplus.

Colud we rework msg to add value description?
There're too much values to identify what it is.

You ignore those msg type, maybe we don't need it?

Thx,
Yangtao


