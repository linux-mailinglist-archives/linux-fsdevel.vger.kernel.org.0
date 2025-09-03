Return-Path: <linux-fsdevel+bounces-60125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB676B41789
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23661890828
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E72E1F13;
	Wed,  3 Sep 2025 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DPvyHiGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012043.outbound.protection.outlook.com [52.101.126.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854D2E0929
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886349; cv=fail; b=fCpBqvQ50Y3LrcasCAMR7/OSNHQg9VAVv/13UGmnSJkbjCb1DLPIlxLsDhwlLavehopfRYva1dOtP05CAo1PswxzmjaM8nSa8gxOzUwykOnPngSvxBjrz2DPCLYy0etPXzU4ZpCfVJZh5dIy+qTpWuVF9Upj8eT6nZgMrIWbzsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886349; c=relaxed/simple;
	bh=x8MnzeL90tCtIhi9zw9wpsblncHl5edXL7g2Oh37/i8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aq5rqXA6FKREoSEajjU//L8dpbfc0qgkInHfK6/6CGRx8n7YmpbfPy0mBFmCUZRlqjtfcwbD8208JpSbDNo+2F8MgcPd+OplEpXZEKxZJX6l8NlCSK9HP6+OaVUTgJsc6GkopMyf2xxqXSaJEF0ZFJm6sj9h6Yv8LcWGK0As40U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DPvyHiGf; arc=fail smtp.client-ip=52.101.126.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvZxrLAsmJD102N7gaLR9tzqjQSCcZTPglrGLjE0WamvY5AsYXwqvcSzscAF6EZyqNti0+GLu0QhLdVscpB6ML3FkgjeyGfVp5/vA3hApuzc2cTh4jU9+YJfPPNfskIxyGz4G10c8yKUIbMLbBgIPegua+ljP1bfpZzGtTvKLJw0/Ii/Kxlok9gFhGxtFsKVUWp0+8nHfUU1X1ihS/M7zjZZIgiRAzLfVWudRNCoINYZ4Rm0qMzS6W0VWo5Ndd6V/Z5tdpzIxv7jQDiMhSaDdAjW8QXMHoIs59G3jDRXtZyAcF2WuVO2G7ucokidYsI1+YgQl/cJouGzFwE9fabX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKzsQhnriOFQc5e282LlteC4jgx4XSFnU3sPaG1fKfU=;
 b=Pr4A0caaj5bsOu1kwgQzUc4NYUOm32sULzbUTTxqQlCaFZfNy9es9UI7BzsG1fCHwL92wY43A84y2LaDtbxOSyDEmH6fravA5Qx4R9Tw3yHnk+7gHCKfP+OzYh77mNOGvFLQ6xcVCGqN975cWM4i2fkxyHLoKPbB9sH06OWKtU3wMZodpK1TcPwcZ9UmkCUlADuVJcC4PiME0ti7Y6GOabjGDMhIQBPnMgYFQ+7/Xhz2abrkKltZzkyMdBtnjrOkeKUmj5dfbqn2G3FSDqan3yCy3pggo6nUeLxbyKIq3rCOTYsWw5IJm7FmSDUbJSOxZSw9pYLE7NazkGMyIPR73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKzsQhnriOFQc5e282LlteC4jgx4XSFnU3sPaG1fKfU=;
 b=DPvyHiGf6GI54L5AVoPMdEnPsCObo6BnJkVAy33nQg7YEaOYhulMnj69U4FuPMXLV5FYn0jNtSbpPlpWLKeQykAIF+GI1jHfqWXlVTtj3ttcYk5to20x7FJIFsuG+yAhMf6lWtvHGoJtuf6XtDNokfHid5IBDYrY1N6Q6k1tZbo836Tr0HxAqd7HszFYymszpVzLb3JDZP2Hq4l2vvKtUwk/ZGrEufeHDeePL8jnLOHNtz7uoY1XsPFlxN4rSIIO/DwIcFv2y7E7uaa7c+9ZGw+P61eJdRAITC9Ca4yt3ymGvPVHOjFy34Op5kTEosKlrHAL0wkikraa3BdnSiH14g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 07:59:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:59:01 +0000
Message-ID: <1e5601f4-ae07-47dd-84fe-7bc449203dff@vivo.com>
Date: Wed, 3 Sep 2025 15:58:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs/hfsplus: rework debug output subsystem
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com, Johannes.Thumshirn@wdc.com
References: <20250814193443.2937813-1-slava@dubeyko.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250814193443.2937813-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f16cc4-9e6b-4485-0833-08ddeabfbe72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2NkRHd1d1RyQTVlUlZvb0RseGYycEc0NmdERXlnaWxxNjI1L0dyNTdRbEdi?=
 =?utf-8?B?clBLQ0VYaUh3bElWN2s0YWtud2RSbndGWVZGb0RWVDdkT0lLWEhyZnI1MG4w?=
 =?utf-8?B?UDdzeFJDbmVoMS9KTlZHMnFHQmpuUkN6SlNXb2VQWUFodVk2aDZpOVhUS1Br?=
 =?utf-8?B?MnNKek9SNjhRMExBMm5rTURKNkFZZkFZQVNSNFJ5MjQ0V2pXL1RQQ0wxbjZl?=
 =?utf-8?B?dUNWdHNZMHBIZllHa25nSnFleTJPUUpqNThDM3VXWmFPOUFac2JGV0tWYUky?=
 =?utf-8?B?Mk52dFFVY1BCZytnSjVtclBKS2VWTlJndG9uNi9oSHpkZzRxRXZlN0p4ZFJq?=
 =?utf-8?B?N2xza2dTZ0tCLzA5WGJ2Y1Nzak5zdVZod21aaERKZEtoK2REZUxsVXJIOVdy?=
 =?utf-8?B?WUlXUkVNNHdKeVg2ZkdtY00yRzZ1S21TaU94d2NxWndCd0puQ1g0TVp2MEdD?=
 =?utf-8?B?R2VkRmtRSEV3VXhUeDJjT25vQ004SjBhSHViN1JPN0JZRnZIS1RXMThHU01E?=
 =?utf-8?B?eXNPRUZGU2xGMDVDbjZ0N2xVZGZwc1hEM3ZNUFN3RmcvMWhQTFdpZXlaT1NT?=
 =?utf-8?B?bFZTcUs2ZHd0aEVZRmNSTFp4QUFIVTBQQlc0RitXR3hNMWZCNjFQcmRnQjBY?=
 =?utf-8?B?QzIrU1VXVFZLaGljVVNzajFFa05pRFUrMzEzYVhvVWVQYnBKYVYzMUdvYy9n?=
 =?utf-8?B?RFJzZzJQd3c0S0thaHRkWFMyL0ZhL082VEpoQTNmc3FEcWQ0cFd6bVJYNzZy?=
 =?utf-8?B?UFpkRFE1cUExdUE3dlJnZUtZVlNrNVpUZmZadzhqZ25yQ1lmQWludzl6SXU2?=
 =?utf-8?B?V3Z0cHVXRTV6bmRIU3J2YURHSmdSdmVpMmJNN2xMeFFReG83YmlnNm9vTXpt?=
 =?utf-8?B?ekl2K2dZQWxmM0NXMUNWcnJSMXZGNWl3NjB4blp6b0IvWHByYWF0YlE2K1c0?=
 =?utf-8?B?VlI3TysvNmtrck9QamdrTHNEeUlFeGhWYkZMNFBnYmVveFM4YTRhd2VBYy85?=
 =?utf-8?B?VVQ3ZTFuOENpdjMvbkV0NDJtMlpxdjVLNDhFZm5qZ3lkRVArQ3NzZ291S3BB?=
 =?utf-8?B?SlBRUlR3a09EcS8rOEhUMHRVK3E1bVlIM1VzUnBXR2ExSHVRUkJDZ3pNSXE5?=
 =?utf-8?B?SGQwdTU3c1JvclRKSlN2V1VHVi9LYmh1TUcrTTl6eWZDdmNWVEVVYUh3ZHc1?=
 =?utf-8?B?NmplMjVJR0d1Mm5uOU9lSFg5VmVsUFN3YkZtU0hKQTNIa2FPMFBVWml1NUJH?=
 =?utf-8?B?ZUlPNEZVLzZiZk5lUjc2eXBOQ1RoOEZseEFUbU1SRnR1cWd6d2c5V3BHUHow?=
 =?utf-8?B?TExCSW0rQTdFWnNkVUZCMFN5VW5GM3o0aEUvdHBrbFBnM1MybDVUT0VWMTUy?=
 =?utf-8?B?U2FVUnVEazdXK0VSb0hMS1luOFF1eTBOdkNPaWNDTkVJaWxyc0FGamh0VEcz?=
 =?utf-8?B?WG81Sm5ETUc0VDZWOCsxQ01sR2lxVkpucGpXV2MzNytjanFxbUJldG5ENUlX?=
 =?utf-8?B?Si83Sy95YzBJa3E2Y1lEVU90NE1NZnE4VnZrNE1KYm5xU0Q1V09SYTVRQ1Rs?=
 =?utf-8?B?cDVZdmx4S3VJSmpjK3N0TEgzMmFZQlp6NXB5Y0liVlcycjN1LzEwSGl5MkVn?=
 =?utf-8?B?K0VXd0g2Z2xCdjZVWi8wbFpOMk9iTFBEU0V2NUlVa0VkSEFyZHZ1bWtRZzVO?=
 =?utf-8?B?TDlKdW9IVGZYbDJhR0o2UGRvL3d2QVVIQVVhaWg0WXhzUk5xTllJOEhjbkcy?=
 =?utf-8?B?OGZPaEdRQ0s1S3hBSGNLTXArSEhBSzZhdCtOT3FMdEgxOEdLNVBJVEQrSTlS?=
 =?utf-8?B?aTFhTThXTVlwaFhGSHBZeExmVndSTEx3c1lOVEJyVEF5YVo1NnhIb3padzhu?=
 =?utf-8?B?VkFCemJaY0wxUEVTclpOeTJNYS9LLzlDcmo3SUIxSW5KMmozMjFPOW10S0Rn?=
 =?utf-8?Q?d0HrNSifXu4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmM1MUpVUExhRmVBWi9nc0gvYmJwVVppRnJEWUVSRXB3bC90YnFyLy83cDcr?=
 =?utf-8?B?R3Y4aFBjNjhlSGY4K0VWVUwrNkNkZ1UwaGFUcHcvWXE3alZPdkxVRzA1YVNO?=
 =?utf-8?B?OG5pREU4aWR1NzRCUURneEhtcERhRlgwWkNsaUR3MTJLMzBUL1hBeDFzTWJu?=
 =?utf-8?B?TjgzMUdwVzJaUXF5UWpoOUVJTXBBdXVyeHptUSs0WGoxWmVidjhWUmxoSUJ1?=
 =?utf-8?B?dU9vazNwNnNXWjJiWHM2NVUwVzVPWmRpSDJLWlE2ZGtLMXZYNXI2MkptYTFN?=
 =?utf-8?B?bFJUdkJwNnlpdktWMGhzNDVXM1NYSGxzdkdJWkNyQXJhMWFoUVh5ZENqSnEr?=
 =?utf-8?B?SVo1ODl2dmxhdmNkM0JZVHBSK25oS3FETU4vOHl6b2VOTGE2SkFCLzlyTXE2?=
 =?utf-8?B?Z2ZkQ3BMS1IrZTlpdW9DY1JZVjUxMDVYU2VLWlowMXhpbElKVi9PMnZDaWVu?=
 =?utf-8?B?MEVMV2VxQ2pMTEtqbkM4Y2xPWmIvVG1pTUh5enBXWkkwb0JFS3RFOStoMGp3?=
 =?utf-8?B?UHArNi91dHBvbUtrNytUVUlRbjBDcDlDTVVXZkFwV3BackJ2eHBWbFAxN1Vx?=
 =?utf-8?B?VGtFa25CY0FMMy9HdWJuWWQvdHRpbzB6ODZxV2ZmNUY4WUZtaHNVLzRrQzl4?=
 =?utf-8?B?SnUwN0RkelBPNEZMQ3pRRmhFVlNZRXd4cTZSVzFDYmVYU050SlJLRzBBa0I0?=
 =?utf-8?B?V3doTHlOYTFVM3FNbFNMajlyR0JCT29pMkRQRGhORkJJN0FFRFpWUFpncFhI?=
 =?utf-8?B?cE4wZWx0NTBqSjhxd2g2YzBFNm5XUk91Z1NKZ2xzMURVMmVEV1BrVzVSclBP?=
 =?utf-8?B?UE9GVTFaLzRITkxBWjB6VGlCUzIzalB3REo2QmQ3ZUdSM2U5YkVsZnc0SGZ4?=
 =?utf-8?B?N2Yyc2FRMWU4SG9NVXlsTVBNc1Q2endMWm1ld0ZkRmtYcFU3VklxMTBicGFV?=
 =?utf-8?B?cHV4cjhMMFVhMDJZaFRyZXExQnZlS0NSR3EwSkJaaHhqR282WkQza1M5cVNw?=
 =?utf-8?B?WXBwZk55NGVDS3prMDlJOVYvOFJtRXV5dGEvZWxCWUNmdVpCZ2hUYTNHNFhl?=
 =?utf-8?B?c2VHTWFFblBkaDVZUVJNNkFkbm5IREhxbkk5R215YXlmZkJFekc0WmMxTGNm?=
 =?utf-8?B?TUdTb3hqZFI4akt6NzJ4WElQVXBFMWFzR2JEVXpXeld6MU1YWU9qOHlLOVBP?=
 =?utf-8?B?VEJmV1pqUmwxMXlTcUlkQ2xidXpRbXJzNTF2L0IybERPTS9meStlY2FZU0V6?=
 =?utf-8?B?VFU5RmxvOEszSTA5M1pnQ3FCZHBpRnl4V1gvSFhwSGYrZlV0TUdCY2ZxcnZO?=
 =?utf-8?B?SW1icHhyY2FCTStnLzF3MVBhMXZHdUlwQlltR3Y5alFFR2hHd2p1TEVERnor?=
 =?utf-8?B?ak1nbGNoYitra2NGRmJiTEMxZVloNHhVQWQ2dzRzdGY3bUJ1K21ieXBBam82?=
 =?utf-8?B?M0tyYUo2WWRzb2V3djE5a2svNTB3VVBvaDEvcDhGdGV5YmdxUGRhRHFSNWps?=
 =?utf-8?B?TkdCSGplanBORmhMMTE5aDFXa3dkbG5JbDkwNW9wSVVmR3RITkFDcXFvUHYr?=
 =?utf-8?B?eGpDa1NOK3oxckpOT3hodHlQc1d3bzRJdENlQ3hUa0lOUnBTeXNJTnRwM1JI?=
 =?utf-8?B?VXdsTXhkeEV5NHA4SGt1NGJWM3pCVndOQktacUdjRkVyQlRJajdDRnpIMTRG?=
 =?utf-8?B?a055TERrSUdtbkFQdjVUTjR5V2hTNFFqRFNEQU5HR1h5YWNlcXM5Sk9DZld5?=
 =?utf-8?B?RTBsdFlDVjVkZ0prS0xXcFoyeW5FTjJoZ3lrWXpEcW9FcWo5N0Nzd1hCYU96?=
 =?utf-8?B?V0dWQ0pCM2ZlS2lpMmlSZnh4MjdFZlhnMEdiVitlbXY0TnZoRHNzRWxlYlJN?=
 =?utf-8?B?Qy9KZmlLVXlhQ1BaVld1SW5PVGt4QnRGSnBoSHhTK3U0eXRvaDM2QzdyUy9u?=
 =?utf-8?B?YWdhOC9KaUlRN3RzNU5NT1pldmU5ZWVabXBoWUU5VDZQamtucERKak40VEx3?=
 =?utf-8?B?alNSdUgwUE0xaS9RVVJhQlBwNGJINFQ0M1FJMmZYYWJXSlNFdElUS2NrYUgw?=
 =?utf-8?B?akZYcktGT0cwVXFsOXhHL1VleWVsTytHNEhhTEJ3ZnB0NlVhZlRHQytRTC82?=
 =?utf-8?Q?QrZ79RGckUktcS5KF9/0VMLKC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f16cc4-9e6b-4485-0833-08ddeabfbe72
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 07:59:01.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKvRsPbtYw7f/LlqUPGNZdRD7S+jO/Bvn23FyZo3qKOkzAesAZKPQkt28Gcw/ebEKBm7ObKznJ5PTflgdbsQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179

Hi Slava,

在 2025/8/15 03:34, Viacheslav Dubeyko 写道:
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
> hfs: pid 5831:fs/hfs/catalog.c:228 hfs_cat_delete(): delete_cat: 00,48
> hfs: pid 5831:fs/hfs/extent.c:484 hfs_file_truncate(): truncate: 48, 409600 -> 0
> hfs: pid 5831:fs/hfs/extent.c:212 hfs_dump_extent():
> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  78:4
> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  0:0
> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  0:0
> 
> v4
> Debug messages have been reworked and information about
> new HFS/HFS+ shared declarations file has been added
> to MAINTAINERS file.
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> ---
>   MAINTAINERS                |  2 ++
>   fs/hfs/bfind.c             |  4 ++--
>   fs/hfs/bitmap.c            |  4 ++--
>   fs/hfs/bnode.c             | 28 ++++++++++++++--------------
>   fs/hfs/brec.c              |  8 ++++----
>   fs/hfs/btree.c             |  2 +-
>   fs/hfs/catalog.c           |  6 +++---
>   fs/hfs/extent.c            | 19 ++++++++++---------
>   fs/hfs/hfs_fs.h            | 33 +--------------------------------
>   fs/hfs/inode.c             |  4 ++--
>   fs/hfsplus/attributes.c    |  8 ++++----
>   fs/hfsplus/bfind.c         |  4 ++--
>   fs/hfsplus/bitmap.c        | 10 +++++-----
>   fs/hfsplus/bnode.c         | 28 ++++++++++++++--------------
>   fs/hfsplus/brec.c          | 10 +++++-----
>   fs/hfsplus/btree.c         |  4 ++--
>   fs/hfsplus/catalog.c       |  6 +++---
>   fs/hfsplus/extents.c       | 25 +++++++++++++------------
>   fs/hfsplus/hfsplus_fs.h    | 35 +----------------------------------
>   fs/hfsplus/super.c         | 17 +++++++++++++----
>   fs/hfsplus/xattr.c         |  4 ++--
>   include/linux/hfs_common.h | 20 ++++++++++++++++++++
>   22 files changed, 125 insertions(+), 156 deletions(-)
>   create mode 100644 include/linux/hfs_common.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..12ce20812f6c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10793,6 +10793,7 @@ L:	linux-fsdevel@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/filesystems/hfs.rst
>   F:	fs/hfs/
> +F:	include/linux/hfs_common.h
>   
>   HFSPLUS FILESYSTEM
>   M:	Viacheslav Dubeyko <slava@dubeyko.com>
> @@ -10802,6 +10803,7 @@ L:	linux-fsdevel@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/filesystems/hfsplus.rst
>   F:	fs/hfsplus/
> +F:	include/linux/hfs_common.h
>   
>   HGA FRAMEBUFFER DRIVER
>   M:	Ferenc Bakonyi <fero@drama.obuda.kando.hu>
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index 34e9804e0f36..d23e634657bd 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -26,7 +26,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
>   		return -ENOMEM;
>   	fd->search_key = ptr;
>   	fd->key = ptr + tree->max_key_len + 2;
> -	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
> +	hfs_dbg("tree: CNID %d, caller %p\n",

I'm kinda confused about uppercase and lowercase here.

Why use CNID instead of cnid?

Since ',' aleardy act as identify for cnid and caller,
Could we drop ':'?

And let's use %ps so we get func name?

[   62.792107] hfs: pid 1023:fs/hfs/bfind.c:52 hfs_find_exit(): tree: 
CNID 4, caller 00000000b667808d
[   62.793808] hfs: pid 1023:fs/hfs/bfind.c:30 hfs_find_init(): tree: 
CNID 4, caller hfs_lookup

  +	hfs_dbg("tree cnid %d, caller %ps\n",


>   		tree->cnid, __builtin_return_address(0));
>   	switch (tree->cnid) {
>   	case HFS_CAT_CNID:
> @@ -48,7 +48,7 @@ void hfs_find_exit(struct hfs_find_data *fd)
>   {
>   	hfs_bnode_put(fd->bnode);
>   	kfree(fd->search_key);
> -	hfs_dbg(BNODE_REFS, "find_exit: %d (%p)\n",
> +	hfs_dbg("tree: CNID %d, caller %p\n",

Ditto.

>   		fd->tree->cnid, __builtin_return_address(0));
>   	mutex_unlock(&fd->tree->tree_lock);
>   	fd->tree = NULL;
> diff --git a/fs/hfs/bitmap.c b/fs/hfs/bitmap.c
> index 28307bc9ec1e..fae26bd10311 100644
> --- a/fs/hfs/bitmap.c
> +++ b/fs/hfs/bitmap.c
> @@ -158,7 +158,7 @@ u32 hfs_vbm_search_free(struct super_block *sb, u32 goal, u32 *num_bits)
>   		}
>   	}
>   
> -	hfs_dbg(BITMAP, "alloc_bits: %u,%u\n", pos, *num_bits);
> +	hfs_dbg("RANGE: pos %u, num_bits %u\n", pos, *num_bits);

We drop all those:

-#define DBG_BNODE_REFS	0x00000001
-#define DBG_BNODE_MOD	0x00000002
-#define DBG_CAT_MOD	0x00000004
-#define DBG_INODE	0x00000008
-#define DBG_SUPER	0x00000010
-#define DBG_EXTENT	0x00000020
-#define DBG_BITMAP	0x00000040
-#define DBG_ATTR_MOD	0x00000080

Not sure, why we need RANGE...

+	hfs_dbg("pos %u, num_bits %u\n", pos, *num_bits);

>   	HFS_SB(sb)->free_ablocks -= *num_bits;
>   	hfs_bitmap_dirty(sb);
>   out:
> @@ -200,7 +200,7 @@ int hfs_clear_vbm_bits(struct super_block *sb, u16 start, u16 count)
>   	if (!count)
>   		return 0;
>   
> -	hfs_dbg(BITMAP, "clear_bits: %u,%u\n", start, count);
> +	hfs_dbg("RANGE: start %u, count %u\n", start, count);

Ditto.

>   	/* are all of the bits in range? */
>   	if ((start + count) > HFS_SB(sb)->fs_ablocks)
>   		return -2;
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index e8cd1a31f247..b2920a1c6943 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -200,7 +200,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
>   {
>   	struct page *src_page, *dst_page;
>   
> -	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
> +	hfs_dbg("copybytes: dst %u, src %u, len %u\n", dst, src, len);

remove 'copybytes:' ?

>   	if (!len)
>   		return;
>   
> @@ -221,7 +221,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
>   	struct page *page;
>   	void *ptr;
>   
> -	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
> +	hfs_dbg("movebytes: dst %u, src %u, len %u\n", dst, src, len);

Ditto.


>   	if (!len)
>   		return;
>   
> @@ -243,16 +243,16 @@ void hfs_bnode_dump(struct hfs_bnode *node)
>   	__be32 cnid;
>   	int i, off, key_off;
>   
> -	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
> +	hfs_dbg("node_id %d\n", node->this);
>   	hfs_bnode_read(node, &desc, 0, sizeof(desc));
> -	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
> +	hfs_dbg("next %d, prev %d, type %d, height %d, num_recs %d\n",
>   		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
>   		desc.type, desc.height, be16_to_cpu(desc.num_recs));
>   
>   	off = node->tree->node_size - 2;
>   	for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
>   		key_off = hfs_bnode_read_u16(node, off);
> -		hfs_dbg_cont(BNODE_MOD, " %d", key_off);
> +		hfs_dbg(" key_off %d", key_off);
>   		if (i && node->type == HFS_NODE_INDEX) {
>   			int tmp;
>   
> @@ -260,18 +260,18 @@ void hfs_bnode_dump(struct hfs_bnode *node)
>   				tmp = (hfs_bnode_read_u8(node, key_off) | 1) + 1;
>   			else
>   				tmp = node->tree->max_key_len + 1;
> -			hfs_dbg_cont(BNODE_MOD, " (%d,%d",
> -				     tmp, hfs_bnode_read_u8(node, key_off));
> +			hfs_dbg(" (%d,%d",
> +				tmp, hfs_bnode_read_u8(node, key_off));

Could we describe those information?

>   			hfs_bnode_read(node, &cnid, key_off + tmp, 4);
> -			hfs_dbg_cont(BNODE_MOD, ",%d)", be32_to_cpu(cnid));
> +			hfs_dbg(", cnid %d)", be32_to_cpu(cnid));
>   		} else if (i && node->type == HFS_NODE_LEAF) {
>   			int tmp;
>   
>   			tmp = hfs_bnode_read_u8(node, key_off);
> -			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
> +			hfs_dbg(" (%d)", tmp);

Ditto.

>   		}
>   	}
> -	hfs_dbg_cont(BNODE_MOD, "\n");
> +	hfs_dbg("\n");
>   }
>   
>   void hfs_bnode_unlink(struct hfs_bnode *node)
> @@ -361,7 +361,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
>   	node->this = cnid;
>   	set_bit(HFS_BNODE_NEW, &node->flags);
>   	atomic_set(&node->refcnt, 1);
> -	hfs_dbg(BNODE_REFS, "new_node(%d:%d): 1\n",
> +	hfs_dbg("cnid %d, node_id %d, refcnt 1\n",
>   		node->tree->cnid, node->this);
>   	init_waitqueue_head(&node->lock_wq);
>   	spin_lock(&tree->hash_lock);
> @@ -401,7 +401,7 @@ void hfs_bnode_unhash(struct hfs_bnode *node)
>   {
>   	struct hfs_bnode **p;
>   
> -	hfs_dbg(BNODE_REFS, "remove_node(%d:%d): %d\n",
> +	hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
>   		node->tree->cnid, node->this, atomic_read(&node->refcnt));
>   	for (p = &node->tree->node_hash[hfs_bnode_hash(node->this)];
>   	     *p && *p != node; p = &(*p)->next_hash)
> @@ -546,7 +546,7 @@ void hfs_bnode_get(struct hfs_bnode *node)
>   {
>   	if (node) {
>   		atomic_inc(&node->refcnt);
> -		hfs_dbg(BNODE_REFS, "get_node(%d:%d): %d\n",
> +		hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
>   			node->tree->cnid, node->this,
>   			atomic_read(&node->refcnt));
>   	}
> @@ -559,7 +559,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
>   		struct hfs_btree *tree = node->tree;
>   		int i;
>   
> -		hfs_dbg(BNODE_REFS, "put_node(%d:%d): %d\n",
> +		hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
>   			node->tree->cnid, node->this,
>   			atomic_read(&node->refcnt));
>   		BUG_ON(!atomic_read(&node->refcnt));
> diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> index 896396554bcc..195405f0ab5c 100644
> --- a/fs/hfs/brec.c
> +++ b/fs/hfs/brec.c
> @@ -94,7 +94,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
>   	end_rec_off = tree->node_size - (node->num_recs + 1) * 2;
>   	end_off = hfs_bnode_read_u16(node, end_rec_off);
>   	end_rec_off -= 2;
> -	hfs_dbg(BNODE_MOD, "insert_rec: %d, %d, %d, %d\n",
> +	hfs_dbg("RECORD: rec %d, size %d, end_off %d, end_rec_off %d\n",


We drop all those:

-#define DBG_BNODE_REFS	0x00000001
-#define DBG_BNODE_MOD	0x00000002
-#define DBG_CAT_MOD	0x00000004
-#define DBG_INODE	0x00000008
-#define DBG_SUPER	0x00000010
-#define DBG_EXTENT	0x00000020
-#define DBG_BITMAP	0x00000040
-#define DBG_ATTR_MOD	0x00000080

Not sure, why we need RECORD...

+	hfs_dbg("rec %d, size %d, end_off %d, end_rec_off %d\n",

>   		rec, size, end_off, end_rec_off);
>   	if (size > end_rec_off - end_off) {
>   		if (new_node)
> @@ -191,7 +191,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
>   		mark_inode_dirty(tree->inode);
>   	}
>   	hfs_bnode_dump(node);
> -	hfs_dbg(BNODE_MOD, "remove_rec: %d, %d\n",
> +	hfs_dbg("RECORD: rec %d, len %d\n",

Dotto.

>   		fd->record, fd->keylength + fd->entrylength);
>   	if (!--node->num_recs) {
>   		hfs_bnode_unlink(node);
> @@ -242,7 +242,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
>   	if (IS_ERR(new_node))
>   		return new_node;
>   	hfs_bnode_get(node);
> -	hfs_dbg(BNODE_MOD, "split_nodes: %d - %d - %d\n",
> +	hfs_dbg("NODES: this %d, new %d, next %d\n",

Dotto.

>   		node->this, new_node->this, node->next);
>   	new_node->next = node->next;
>   	new_node->prev = node->this;
> @@ -378,7 +378,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
>   		newkeylen = (hfs_bnode_read_u8(node, 14) | 1) + 1;
>   	else
>   		fd->keylength = newkeylen = tree->max_key_len + 1;
> -	hfs_dbg(BNODE_MOD, "update_rec: %d, %d, %d\n",
> +	hfs_dbg("RECORD: rec %d, keylength %d, newkeylen %d\n",

Ditto.

>   		rec, fd->keylength, newkeylen);
>   
>   	rec_off = tree->node_size - (rec + 2) * 2;
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index e86e1e235658..9f0f1372a5c3 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -364,7 +364,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
>   	u32 nidx;
>   	u8 *data, byte, m;
>   
> -	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
> +	hfs_dbg("node_id %u\n", node->this);

node id?

>   	tree = node->tree;
>   	nidx = node->this;
>   	node = hfs_bnode_find(tree, 0);
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index d63880e7d9d6..28f3fbf586e5 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -87,7 +87,7 @@ int hfs_cat_create(u32 cnid, struct inode *dir, const struct qstr *str, struct i
>   	int entry_size;
>   	int err;
>   
> -	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
> +	hfs_dbg("entry: name %s, cnid %u, i_nlink %d\n",

'entry: ' is redundant...

+	hfs_dbg("name %s, cnid %u, i_nlink %d\n",

>   		str->name, cnid, inode->i_nlink);
>   	if (dir->i_size >= HFS_MAX_VALENCE)
>   		return -ENOSPC;
> @@ -225,7 +225,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
>   	struct hfs_readdir_data *rd;
>   	int res, type;
>   
> -	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
> +	hfs_dbg("entry: name %s, cnid %u\n", str ? str->name : NULL, cnid);

Ditto.

>   	sb = dir->i_sb;
>   	res = hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
>   	if (res)
> @@ -294,7 +294,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
>   	int entry_size, type;
>   	int err;
>   
> -	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
> +	hfs_dbg("CNID %u - entry1(ino %lu, name %s) - entry2(ino %lu, name %s)\n",

hfs_dbg("cnid %u -(ino %lu, name %s) -> (ino %lu, name %s)\n", ?

>   		cnid, src_dir->i_ino, src_name->name,
>   		dst_dir->i_ino, dst_name->name);
>   	sb = src_dir->i_sb;
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index 580c62981dbd..c4d6ae796a3c 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -209,12 +209,12 @@ static void hfs_dump_extent(struct hfs_extent *extent)
>   {
>   	int i;
>   
> -	hfs_dbg(EXTENT, "   ");
> +	hfs_dbg("EXTENT:   ");

Uppercase is kinda stange.

+	hfs_dbg("extent:   "); ?

>   	for (i = 0; i < 3; i++)
> -		hfs_dbg_cont(EXTENT, " %u:%u",
> -			     be16_to_cpu(extent[i].block),
> -			     be16_to_cpu(extent[i].count));
> -	hfs_dbg_cont(EXTENT, "\n");
> +		hfs_dbg(" block %u, count %u",
> +			be16_to_cpu(extent[i].block),
> +			be16_to_cpu(extent[i].count));
> +	hfs_dbg("\n");
>   }
>   
>   static int hfs_add_extent(struct hfs_extent *extent, u16 offset,
> @@ -411,10 +411,11 @@ int hfs_extend_file(struct inode *inode)
>   		goto out;
>   	}
>   
> -	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino, start, len);
> +	hfs_dbg("ino %lu: start %u, len %u\n", inode->i_ino, start, len);

':' -> ',' ?

  +	hfs_dbg("ino %lu, start %u, len %u\n", inode->i_ino, start, len);

>   	if (HFS_I(inode)->alloc_blocks == HFS_I(inode)->first_blocks) {
>   		if (!HFS_I(inode)->first_blocks) {
> -			hfs_dbg(EXTENT, "first extents\n");
> +			hfs_dbg("first_extents[0]: start %u, len %u\n",

s/first_extents[0]:/first_extents ?

+			hfs_dbg("first_extents start %u, len %u\n",

> +				start, len);
>   			/* no extents yet */
>   			HFS_I(inode)->first_extents[0].block = cpu_to_be16(start);
>   			HFS_I(inode)->first_extents[0].count = cpu_to_be16(len);
> @@ -456,7 +457,7 @@ int hfs_extend_file(struct inode *inode)
>   	return res;
>   
>   insert_extent:
> -	hfs_dbg(EXTENT, "insert new extent\n");
> +	hfs_dbg("insert new extent\n");
>   	res = hfs_ext_write_extent(inode);
>   	if (res)
>   		goto out;
> @@ -481,7 +482,7 @@ void hfs_file_truncate(struct inode *inode)
>   	u32 size;
>   	int res;
>   
> -	hfs_dbg(INODE, "truncate: %lu, %Lu -> %Lu\n",
> +	hfs_dbg("ino: %lu, phys_size %llu -> i_size %llu\n",

+	hfs_dbg("ino %lu, phys size %llu -> %llu\n",    ?

>   		inode->i_ino, (long long)HFS_I(inode)->phys_size,
>   		inode->i_size);
>   	if (inode->i_size > HFS_I(inode)->phys_size) {
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index 7c5a7ecfa246..9fbdd6a86f46 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -9,12 +9,6 @@
>   #ifndef _LINUX_HFS_FS_H
>   #define _LINUX_HFS_FS_H
>   
> -#ifdef pr_fmt
> -#undef pr_fmt
> -#endif
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>   #include <linux/slab.h>
>   #include <linux/types.h>
>   #include <linux/mutex.h>
> @@ -24,35 +18,10 @@
>   
>   #include <asm/byteorder.h>
>   #include <linux/uaccess.h>
> +#include <linux/hfs_common.h>

Alph sort？

#include <asm/byteorder.h>
+#include <linux/hfs_common.h>
#include <linux/uaccess.h>


>   
>   #include "hfs.h"
>   
> -#define DBG_BNODE_REFS	0x00000001
> -#define DBG_BNODE_MOD	0x00000002
> -#define DBG_CAT_MOD	0x00000004
> -#define DBG_INODE	0x00000008
> -#define DBG_SUPER	0x00000010
> -#define DBG_EXTENT	0x00000020
> -#define DBG_BITMAP	0x00000040
> -
> -//#define DBG_MASK	(DBG_EXTENT|DBG_INODE|DBG_BNODE_MOD|DBG_CAT_MOD|DBG_BITMAP)
> -//#define DBG_MASK	(DBG_BNODE_MOD|DBG_CAT_MOD|DBG_INODE)
> -//#define DBG_MASK	(DBG_CAT_MOD|DBG_BNODE_REFS|DBG_INODE|DBG_EXTENT)
> -#define DBG_MASK	(0)
> -
> -#define hfs_dbg(flg, fmt, ...)					\
> -do {								\
> -	if (DBG_##flg & DBG_MASK)				\
> -		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
> -} while (0)
> -
> -#define hfs_dbg_cont(flg, fmt, ...)				\
> -do {								\
> -	if (DBG_##flg & DBG_MASK)				\
> -		pr_cont(fmt, ##__VA_ARGS__);			\
> -} while (0)
> -
> -
>   /*
>    * struct hfs_inode_info
>    *
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index bf4cb7e78396..983d537a25be 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -241,7 +241,7 @@ void hfs_delete_inode(struct inode *inode)
>   {
>   	struct super_block *sb = inode->i_sb;
>   
> -	hfs_dbg(INODE, "delete_inode: %lu\n", inode->i_ino);
> +	hfs_dbg("ino: %lu\n", inode->i_ino);

remove ':'

>   	if (S_ISDIR(inode->i_mode)) {
>   		HFS_SB(sb)->folder_count--;
>   		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
> @@ -425,7 +425,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
>   	hfs_cat_rec rec;
>   	int res;
>   
> -	hfs_dbg(INODE, "hfs_write_inode: %lu\n", inode->i_ino);
> +	hfs_dbg("ino: %lu\n", inode->i_ino);

Ditto.

>   	res = hfs_ext_write_extent(inode);
>   	if (res)
>   		return res;
> diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
> index eeebe80c6be4..914a06e48576 100644
> --- a/fs/hfsplus/attributes.c
> +++ b/fs/hfsplus/attributes.c
> @@ -139,7 +139,7 @@ int hfsplus_find_attr(struct super_block *sb, u32 cnid,
>   {
>   	int err = 0;
>   
> -	hfs_dbg(ATTR_MOD, "find_attr: %s,%d\n", name ? name : NULL, cnid);
> +	hfs_dbg("name %s, cnid %d\n", name ? name : NULL, cnid);
>   
>   	if (!HFSPLUS_SB(sb)->attr_tree) {
>   		pr_err("attributes file doesn't exist\n");
> @@ -201,7 +201,7 @@ int hfsplus_create_attr(struct inode *inode,
>   	int entry_size;
>   	int err;
>   
> -	hfs_dbg(ATTR_MOD, "create_attr: %s,%ld\n",
> +	hfs_dbg("name %s, ino %ld\n",
>   		name ? name : NULL, inode->i_ino);
>   
>   	if (!HFSPLUS_SB(sb)->attr_tree) {
> @@ -310,7 +310,7 @@ int hfsplus_delete_attr(struct inode *inode, const char *name)
>   	struct super_block *sb = inode->i_sb;
>   	struct hfs_find_data fd;
>   
> -	hfs_dbg(ATTR_MOD, "delete_attr: %s,%ld\n",
> +	hfs_dbg("name %s, ino %ld\n",
>   		name ? name : NULL, inode->i_ino);
>   
>   	if (!HFSPLUS_SB(sb)->attr_tree) {
> @@ -356,7 +356,7 @@ int hfsplus_delete_all_attrs(struct inode *dir, u32 cnid)
>   	int err = 0;
>   	struct hfs_find_data fd;
>   
> -	hfs_dbg(ATTR_MOD, "delete_all_attrs: %d\n", cnid);
> +	hfs_dbg("cnid: %d\n", cnid);

Ditto.

>   
>   	if (!HFSPLUS_SB(dir->i_sb)->attr_tree) {
>   		pr_err("attributes file doesn't exist\n");
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 901e83d65d20..1fe80ced03eb 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -23,7 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
>   		return -ENOMEM;
>   	fd->search_key = ptr;
>   	fd->key = ptr + tree->max_key_len + 2;
> -	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
> +	hfs_dbg("CNID %d, caller %p\n",

Ditto.

+ 	hfs_dbg("cnid %d, caller %ps\n", ?

>   		tree->cnid, __builtin_return_address(0));
>   	mutex_lock_nested(&tree->tree_lock,
>   			hfsplus_btree_lock_class(tree));
> @@ -34,7 +34,7 @@ void hfs_find_exit(struct hfs_find_data *fd)
>   {
>   	hfs_bnode_put(fd->bnode);
>   	kfree(fd->search_key);
> -	hfs_dbg(BNODE_REFS, "find_exit: %d (%p)\n",
> +	hfs_dbg("CNID %d, caller %p\n",

Reference to hfs.

>   		fd->tree->cnid, __builtin_return_address(0));
>   	mutex_unlock(&fd->tree->tree_lock);
>   	fd->tree = NULL;
> diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
> index bd8dcea85588..461dac07d3dd 100644
> --- a/fs/hfsplus/bitmap.c
> +++ b/fs/hfsplus/bitmap.c
> @@ -31,7 +31,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
>   	if (!len)
>   		return size;
>   
> -	hfs_dbg(BITMAP, "block_allocate: %u,%u,%u\n", size, offset, len);
> +	hfs_dbg("RANGE: size %u, offset %u, len %u\n", size, offset, len);

Reference to hfs.

>   	mutex_lock(&sbi->alloc_mutex);
>   	mapping = sbi->alloc_file->i_mapping;
>   	page = read_mapping_page(mapping, offset / PAGE_CACHE_BITS, NULL);
> @@ -90,14 +90,14 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
>   		else
>   			end = pptr + ((size + 31) & (PAGE_CACHE_BITS - 1)) / 32;
>   	}
> -	hfs_dbg(BITMAP, "bitmap full\n");
> +	hfs_dbg("bitmap full\n");
>   	start = size;
>   	goto out;
>   
>   found:
>   	start = offset + (curr - pptr) * 32 + i;
>   	if (start >= size) {
> -		hfs_dbg(BITMAP, "bitmap full\n");
> +		hfs_dbg("bitmap full\n");
>   		goto out;
>   	}
>   	/* do any partial u32 at the start */
> @@ -155,7 +155,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
>   	*max = offset + (curr - pptr) * 32 + i - start;
>   	sbi->free_blocks -= *max;
>   	hfsplus_mark_mdb_dirty(sb);
> -	hfs_dbg(BITMAP, "-> %u,%u\n", start, *max);
> +	hfs_dbg("RANGE-> start %u, max %u\n", start, *max);

'RANGE->' is strange.

>   out:
>   	mutex_unlock(&sbi->alloc_mutex);
>   	return start;
> @@ -174,7 +174,7 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
>   	if (!count)
>   		return 0;
>   
> -	hfs_dbg(BITMAP, "block_free: %u,%u\n", offset, count);
> +	hfs_dbg("RANGE: offset %u, count %u\n", offset, count);

remove 'RANGE: '    ?

>   	/* are all of the bits in range? */
>   	if ((offset + count) > sbi->total_blocks)
>   		return -ENOENT;
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 14f4995588ff..bd0153aebeb6 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -214,7 +214,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
>   	struct page **src_page, **dst_page;
>   	int l;
>   
> -	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
> +	hfs_dbg("copybytes: dst %u, src %u, len %u\n", dst, src, len);

remove 'copybytes: ' ?

>   	if (!len)
>   		return;
>   
> @@ -272,7 +272,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
>   	void *src_ptr, *dst_ptr;
>   	int l;
>   
> -	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
> +	hfs_dbg("movebytes: dst %u, src %u, len %u\n", dst, src, len);

Ditto.

>   	if (!len)
>   		return;
>   
> @@ -392,16 +392,16 @@ void hfs_bnode_dump(struct hfs_bnode *node)
>   	__be32 cnid;
>   	int i, off, key_off;
>   
> -	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
> +	hfs_dbg("node_id %d\n", node->this);
>   	hfs_bnode_read(node, &desc, 0, sizeof(desc));
> -	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
> +	hfs_dbg("next %d, prev %d, type %d, height %d, num_recs %d\n",
>   		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
>   		desc.type, desc.height, be16_to_cpu(desc.num_recs));
>   
>   	off = node->tree->node_size - 2;
>   	for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
>   		key_off = hfs_bnode_read_u16(node, off);
> -		hfs_dbg(BNODE_MOD, " %d", key_off);
> +		hfs_dbg(" key_off %d", key_off);
>   		if (i && node->type == HFS_NODE_INDEX) {
>   			int tmp;
>   
> @@ -410,17 +410,17 @@ void hfs_bnode_dump(struct hfs_bnode *node)
>   				tmp = hfs_bnode_read_u16(node, key_off) + 2;
>   			else
>   				tmp = node->tree->max_key_len + 2;
> -			hfs_dbg_cont(BNODE_MOD, " (%d", tmp);
> +			hfs_dbg(" (%d", tmp);

Could we describe those info ?

>   			hfs_bnode_read(node, &cnid, key_off + tmp, 4);
> -			hfs_dbg_cont(BNODE_MOD, ",%d)", be32_to_cpu(cnid));
> +			hfs_dbg(", cnid %d)", be32_to_cpu(cnid));
>   		} else if (i && node->type == HFS_NODE_LEAF) {
>   			int tmp;
>   
>   			tmp = hfs_bnode_read_u16(node, key_off);
> -			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
> +			hfs_dbg(" (%d)", tmp);
>   		}
>   	}
> -	hfs_dbg_cont(BNODE_MOD, "\n");
> +	hfs_dbg("\n");
>   }
>   
>   void hfs_bnode_unlink(struct hfs_bnode *node)
> @@ -456,7 +456,7 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
>   
>   	/* move down? */
>   	if (!node->prev && !node->next)
> -		hfs_dbg(BNODE_MOD, "hfs_btree_del_level\n");
> +		hfs_dbg("btree delete level\n");
>   	if (!node->parent) {
>   		tree->root = 0;
>   		tree->depth = 0;
> @@ -511,7 +511,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
>   	node->this = cnid;
>   	set_bit(HFS_BNODE_NEW, &node->flags);
>   	atomic_set(&node->refcnt, 1);
> -	hfs_dbg(BNODE_REFS, "new_node(%d:%d): 1\n",
> +	hfs_dbg("cnid%d, node_id %d, refcnt 1\n",

add white space?

>   		node->tree->cnid, node->this);
>   	init_waitqueue_head(&node->lock_wq);
>   	spin_lock(&tree->hash_lock);
> @@ -551,7 +551,7 @@ void hfs_bnode_unhash(struct hfs_bnode *node)
>   {
>   	struct hfs_bnode **p;
>   
> -	hfs_dbg(BNODE_REFS, "remove_node(%d:%d): %d\n",
> +	hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
>   		node->tree->cnid, node->this, atomic_read(&node->refcnt));
>   	for (p = &node->tree->node_hash[hfs_bnode_hash(node->this)];
>   	     *p && *p != node; p = &(*p)->next_hash)
> @@ -697,7 +697,7 @@ void hfs_bnode_get(struct hfs_bnode *node)
>   {
>   	if (node) {
>   		atomic_inc(&node->refcnt);
> -		hfs_dbg(BNODE_REFS, "get_node(%d:%d): %d\n",
> +		hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
>   			node->tree->cnid, node->this,
>   			atomic_read(&node->refcnt));
>   	}
> @@ -710,7 +710,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
>   		struct hfs_btree *tree = node->tree;
>   		int i;
>   
> -		hfs_dbg(BNODE_REFS, "put_node(%d:%d): %d\n",
> +		hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
>   			node->tree->cnid, node->this,
>   			atomic_read(&node->refcnt));
>   		BUG_ON(!atomic_read(&node->refcnt));
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index 1918544a7871..81683eee28c8 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -92,7 +92,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
>   	end_rec_off = tree->node_size - (node->num_recs + 1) * 2;
>   	end_off = hfs_bnode_read_u16(node, end_rec_off);
>   	end_rec_off -= 2;
> -	hfs_dbg(BNODE_MOD, "insert_rec: %d, %d, %d, %d\n",
> +	hfs_dbg("RECORD: rec %d, size %d, end_off %d, end_rec_off %d\n",

remove 'RECORD: '?

>   		rec, size, end_off, end_rec_off);
>   	if (size > end_rec_off - end_off) {
>   		if (new_node)
> @@ -193,7 +193,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
>   		mark_inode_dirty(tree->inode);
>   	}
>   	hfs_bnode_dump(node);
> -	hfs_dbg(BNODE_MOD, "remove_rec: %d, %d\n",
> +	hfs_dbg("RECORD: rec %d, len %d\n",

Ditto.

>   		fd->record, fd->keylength + fd->entrylength);
>   	if (!--node->num_recs) {
>   		hfs_bnode_unlink(node);
> @@ -246,7 +246,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
>   	if (IS_ERR(new_node))
>   		return new_node;
>   	hfs_bnode_get(node);
> -	hfs_dbg(BNODE_MOD, "split_nodes: %d - %d - %d\n",
> +	hfs_dbg("bnodes: this %d - new %d - next %d\n",

remove 'bnodes: ' ?

>   		node->this, new_node->this, node->next);
>   	new_node->next = node->next;
>   	new_node->prev = node->this;
> @@ -383,7 +383,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
>   		newkeylen = hfs_bnode_read_u16(node, 14) + 2;
>   	else
>   		fd->keylength = newkeylen = tree->max_key_len + 2;
> -	hfs_dbg(BNODE_MOD, "update_rec: %d, %d, %d\n",
> +	hfs_dbg("RECORD: rec %d, keylength %d, newkeylen %d\n",

remove 'RECORD: ' ?

>   		rec, fd->keylength, newkeylen);
>   
>   	rec_off = tree->node_size - (rec + 2) * 2;
> @@ -395,7 +395,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
>   		end_off = hfs_bnode_read_u16(parent, end_rec_off);
>   		if (end_rec_off - end_off < diff) {
>   
> -			hfs_dbg(BNODE_MOD, "splitting index node\n");
> +			hfs_dbg("splitting index node\n");
>   			fd->bnode = parent;
>   			new_node = hfs_bnode_split(fd);
>   			if (IS_ERR(new_node))
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 9e1732a2b92a..0583206cde80 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -428,7 +428,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
>   		kunmap_local(data);
>   		nidx = node->next;
>   		if (!nidx) {
> -			hfs_dbg(BNODE_MOD, "create new bmap node\n");
> +			hfs_dbg("create new bmap node\n");
>   			next_node = hfs_bmap_new_bmap(node, idx);
>   		} else
>   			next_node = hfs_bnode_find(tree, nidx);
> @@ -454,7 +454,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
>   	u32 nidx;
>   	u8 *data, byte, m;
>   
> -	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
> +	hfs_dbg("node_id %u\n", node->this);

node id?

>   	BUG_ON(!node->this);
>   	tree = node->tree;
>   	nidx = node->this;
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 1995bafee839..38ecde83bcea 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -259,7 +259,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
>   	int entry_size;
>   	int err;
>   
> -	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
> +	hfs_dbg("entry: name %s, cnid %u, i_nlink %d\n",

remove 'entry: ' ?


>   		str->name, cnid, inode->i_nlink);
>   	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
>   	if (err)
> @@ -336,7 +336,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
>   	int err, off;
>   	u16 type;
>   
> -	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
> +	hfs_dbg("entry: name %s, cnid %u\n", str ? str->name : NULL, cnid);

Ditto.

>   	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
>   	if (err)
>   		return err;
> @@ -441,7 +441,7 @@ int hfsplus_rename_cat(u32 cnid,
>   	int entry_size, type;
>   	int err;
>   
> -	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
> +	hfs_dbg("entry: cnid %u - ino %lu, name %s - ino %lu, name %s\n",

Ditto.

>   		cnid, src_dir->i_ino, src_name->name,
>   		dst_dir->i_ino, dst_name->name);
>   	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &src_fd);
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index b1699b3c246a..b22b328113e6 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -275,7 +275,7 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
>   	mutex_unlock(&hip->extents_lock);
>   
>   done:
> -	hfs_dbg(EXTENT, "get_block(%lu): %llu - %u\n",
> +	hfs_dbg("ino(%lu): iblock %llu - dblock %u\n",

 > +	hfs_dbg("ino %lu, iblock %llu - dblock %u\n", ?

>   		inode->i_ino, (long long)iblock, dblock);
>   
>   	mask = (1 << sbi->fs_shift) - 1;
> @@ -298,12 +298,12 @@ static void hfsplus_dump_extent(struct hfsplus_extent *extent)
>   {
>   	int i;
>   
> -	hfs_dbg(EXTENT, "   ");
> +	hfs_dbg("EXTENT   ");

extent: ?

>   	for (i = 0; i < 8; i++)
> -		hfs_dbg_cont(EXTENT, " %u:%u",
> -			     be32_to_cpu(extent[i].start_block),
> -			     be32_to_cpu(extent[i].block_count));
> -	hfs_dbg_cont(EXTENT, "\n");
> +		hfs_dbg(" start_block %u, block_count%u",
> +			be32_to_cpu(extent[i].start_block),
> +			be32_to_cpu(extent[i].block_count));
> +	hfs_dbg("\n");
>   }
>   
>   static int hfsplus_add_extent(struct hfsplus_extent *extent, u32 offset,
> @@ -360,7 +360,7 @@ static int hfsplus_free_extents(struct super_block *sb,
>   			err = hfsplus_block_free(sb, start, count);
>   			if (err) {
>   				pr_err("can't free extent\n");
> -				hfs_dbg(EXTENT, " start: %u count: %u\n",
> +				hfs_dbg("EXTENT: start: %u count: %u\n",

convert to pr_err ?

>   					start, count);
>   			}
>   			extent->block_count = 0;
> @@ -371,7 +371,7 @@ static int hfsplus_free_extents(struct super_block *sb,
>   			err = hfsplus_block_free(sb, start + count, block_nr);
>   			if (err) {
>   				pr_err("can't free extent\n");
> -				hfs_dbg(EXTENT, " start: %u count: %u\n",
> +				hfs_dbg("EXTENT: start: %u count: %u\n",

remove 'EXTENT:' ?

>   					start, count);
>   			}
>   			extent->block_count = cpu_to_be32(count);
> @@ -478,11 +478,12 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
>   			goto out;
>   	}
>   
> -	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino, start, len);
> +	hfs_dbg("ino %lu: start %u, len %u\n", inode->i_ino, start, len);

s/:/,    ?

>   
>   	if (hip->alloc_blocks <= hip->first_blocks) {
>   		if (!hip->first_blocks) {
> -			hfs_dbg(EXTENT, "first extents\n");
> +			hfs_dbg("first_extents[0]: start %u, len %u\n",
> +				start, len);
>   			/* no extents yet */
>   			hip->first_extents[0].start_block = cpu_to_be32(start);
>   			hip->first_extents[0].block_count = cpu_to_be32(len);
> @@ -521,7 +522,7 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
>   	return res;
>   
>   insert_extent:
> -	hfs_dbg(EXTENT, "insert new extent\n");
> +	hfs_dbg("insert new extent\n");
>   	res = hfsplus_ext_write_extent_locked(inode);
>   	if (res)
>   		goto out;
> @@ -546,7 +547,7 @@ void hfsplus_file_truncate(struct inode *inode)
>   	u32 alloc_cnt, blk_cnt, start;
>   	int res;
>   
> -	hfs_dbg(INODE, "truncate: %lu, %llu -> %llu\n",
> +	hfs_dbg("ino: %lu, phys_size %llu -> i_size %llu\n",

 > +	hfs_dbg("ino %lu, phys size %llu -> %llu\n",

>   		inode->i_ino, (long long)hip->phys_size, inode->i_size);
>   
>   	if (inode->i_size > hip->phys_size) {
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 96a5c24813dd..34039e2d5417 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -11,47 +11,14 @@
>   #ifndef _LINUX_HFSPLUS_FS_H
>   #define _LINUX_HFSPLUS_FS_H
>   
> -#ifdef pr_fmt
> -#undef pr_fmt
> -#endif
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>   #include <linux/fs.h>
>   #include <linux/mutex.h>
>   #include <linux/buffer_head.h>
>   #include <linux/blkdev.h>
>   #include <linux/fs_context.h>
> +#include <linux/hfs_common.h>
>   #include "hfsplus_raw.h"
>   
> -#define DBG_BNODE_REFS	0x00000001
> -#define DBG_BNODE_MOD	0x00000002
> -#define DBG_CAT_MOD	0x00000004
> -#define DBG_INODE	0x00000008
> -#define DBG_SUPER	0x00000010
> -#define DBG_EXTENT	0x00000020
> -#define DBG_BITMAP	0x00000040
> -#define DBG_ATTR_MOD	0x00000080
> -
> -#if 0
> -#define DBG_MASK	(DBG_EXTENT|DBG_INODE|DBG_BNODE_MOD)
> -#define DBG_MASK	(DBG_BNODE_MOD|DBG_CAT_MOD|DBG_INODE)
> -#define DBG_MASK	(DBG_CAT_MOD|DBG_BNODE_REFS|DBG_INODE|DBG_EXTENT)
> -#endif
> -#define DBG_MASK	(0)
> -
> -#define hfs_dbg(flg, fmt, ...)					\
> -do {								\
> -	if (DBG_##flg & DBG_MASK)				\
> -		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
> -} while (0)
> -
> -#define hfs_dbg_cont(flg, fmt, ...)				\
> -do {								\
> -	if (DBG_##flg & DBG_MASK)				\
> -		pr_cont(fmt, ##__VA_ARGS__);			\
> -} while (0)
> -
>   /* Runtime config options */
>   #define HFSPLUS_DEF_CR_TYPE    0x3F3F3F3F  /* '????' */
>   
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 86351bdc8985..403feb3d7411 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -150,7 +150,7 @@ static int hfsplus_write_inode(struct inode *inode,
>   {
>   	int err;
>   
> -	hfs_dbg(INODE, "hfsplus_write_inode: %lu\n", inode->i_ino);
> +	hfs_dbg("ino: %lu\n", inode->i_ino);

  +	hfs_dbg("ino %lu\n", inode->i_ino);     ?

>   
>   	err = hfsplus_ext_write_extent(inode);
>   	if (err)
> @@ -165,7 +165,7 @@ static int hfsplus_write_inode(struct inode *inode,
>   
>   static void hfsplus_evict_inode(struct inode *inode)
>   {
> -	hfs_dbg(INODE, "hfsplus_evict_inode: %lu\n", inode->i_ino);
> +	hfs_dbg("ino: %lu\n", inode->i_ino);

Ditto.

>   	truncate_inode_pages_final(&inode->i_data);
>   	clear_inode(inode);
>   	if (HFSPLUS_IS_RSRC(inode)) {
> @@ -184,7 +184,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
>   	if (!wait)
>   		return 0;
>   
> -	hfs_dbg(SUPER, "hfsplus_sync_fs\n");
> +	hfs_dbg("starting...\n");
>   
>   	/*
>   	 * Explicitly write out the special metadata inodes.
> @@ -215,6 +215,11 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
>   	vhdr->folder_count = cpu_to_be32(sbi->folder_count);
>   	vhdr->file_count = cpu_to_be32(sbi->file_count);
>   
> +	hfs_dbg("free_blocks %u, next_cnid %u, "
> +		"folder_count %u, file_count %u\n",
> +		sbi->free_blocks, sbi->next_cnid,
> +		sbi->folder_count, sbi->file_count);
> +
>   	if (test_and_clear_bit(HFSPLUS_SB_WRITEBACKUP, &sbi->flags)) {
>   		memcpy(sbi->s_backup_vhdr, sbi->s_vhdr, sizeof(*sbi->s_vhdr));
>   		write_backup = 1;
> @@ -240,6 +245,8 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
>   	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
>   		blkdev_issue_flush(sb->s_bdev);
>   
> +	hfs_dbg("finished: err %d\n", error);

  +	hfs_dbg("finished  err %d\n", error);    ?

> +
>   	return error;
>   }
>   
> @@ -288,7 +295,7 @@ static void hfsplus_put_super(struct super_block *sb)
>   {
>   	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
>   
> -	hfs_dbg(SUPER, "hfsplus_put_super\n");
> +	hfs_dbg("starting...\n");
>   
>   	cancel_delayed_work_sync(&sbi->sync_work);
>   
> @@ -310,6 +317,8 @@ static void hfsplus_put_super(struct super_block *sb)
>   	kfree(sbi->s_vhdr_buf);
>   	kfree(sbi->s_backup_vhdr_buf);
>   	call_rcu(&sbi->rcu, delayed_free);
> +
> +	hfs_dbg("finished\n");
>   }
>   
>   static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 18dc3d254d21..f34404798025 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -64,7 +64,7 @@ static void hfsplus_init_header_node(struct inode *attr_file,
>   	u32 used_bmp_bytes;
>   	u64 tmp;
>   
> -	hfs_dbg(ATTR_MOD, "init_hdr_attr_file: clump %u, node_size %u\n",
> +	hfs_dbg("clump %u, node_size %u\n",
>   		clump_size, node_size);
>   
>   	/* The end of the node contains list of record offsets */
> @@ -132,7 +132,7 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
>   	struct page *page;
>   	int old_state = HFSPLUS_EMPTY_ATTR_TREE;
>   
> -	hfs_dbg(ATTR_MOD, "create_attr_file: ino %d\n", HFSPLUS_ATTR_CNID);
> +	hfs_dbg("ino %d\n", HFSPLUS_ATTR_CNID);
>   
>   check_attr_tree_state_again:
>   	switch (atomic_read(&sbi->attr_tree_state)) {
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> new file mode 100644
> index 000000000000..8838ca2f3d08
> --- /dev/null
> +++ b/include/linux/hfs_common.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * HFS/HFS+ common definitions, inline functions,
> + * and shared functionality.
> + */
> +
> +#ifndef _HFS_COMMON_H_
> +#define _HFS_COMMON_H_
> +
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#define hfs_dbg(fmt, ...)							\
> +	pr_debug("pid %d:%s:%d %s(): " fmt,					\
> +		 current->pid, __FILE__, __LINE__, __func__, ##__VA_ARGS__)	\
> +
> +#endif /* _HFS_COMMON_H_ */

Thx,
Yangtao


