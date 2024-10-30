Return-Path: <linux-fsdevel+bounces-33242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330209B5D2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 08:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA79D1F243B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC41E00A1;
	Wed, 30 Oct 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="YjG+JEJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B51B86E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274451; cv=fail; b=gV5e/nM5zdtg8gew3ydNpCVGX79rkyJBT7FzlqpfNa1Kmx9BJU9RBABZOjk3xXn6GKIZTvMgmLwxEzS4JvMc9yYKLdZm2zSPcVUCaE5JKxYOK0YswcDGmyEN5uEOuDWgD1YoTbsnDBdlb4W64lzNesrmleLdy9yd7XZBeE+MmRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274451; c=relaxed/simple;
	bh=nEcjN4PtFE1022k4jxmuK8zxoFM7Xd661+jmu4qJtRg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dQomOaNL7pQQOmxq3EO5CteoaKubhGrAr+vjL35GovRuFU03UlRhcrBI+/aAMlWIXRvUvDCRaM+B2Qt3vSCihgBYM0agAZUOkYX4e+ZXG2ZprqapWZf54UutFg+oDDznAQaKDRWsqDlUU7p7s94BT27aYCLZLu/Y3/y5vRiHyvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=YjG+JEJH; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U6P3QG018401;
	Wed, 30 Oct 2024 07:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=nEcjN4PtFE1022k4jxmuK8zxoFM7X
	d661+jmu4qJtRg=; b=YjG+JEJHXnWBWhD3G7bNf3dGOPdIxhBelaaIVwGHKDNPj
	ShMuufGBOuyEvpY/YrwMeSQ7pc6PrBomOfyuCq4OAWDzDy1F9Xn16Pie5OXxV8bI
	pNgnRtOXfAMr58peauQUk96m2Q/5RDejjOgdxYAsSjUpSuX9sINBoD5RqjgZPc2o
	seOw0AhBkE9nHiK51hUvd97x8vfPT0OKHixWf5dqE/aJStIiVRb8Bf6wgZsbw0uk
	BBmxn6/IWwE4fN1Lb5IbNjbVtiA1iVs/LGhTcGiqFFqTGmSrLHcntBS/TQVS/HZ6
	zc2OZcu4td9JfqMpGcDsQX/LNvTviduusXJ1Gr0VQ==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2044.outbound.protection.outlook.com [104.47.110.44])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42k2yprm69-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:47:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVex5R8xY2YXIHoHyuk5nWCwa8Vw+432AHbE+4Xua1aUcnqpFAsuRHnZRgrix6s5gt2tMVEchDXPuFvSu+yeKatwyn7kA6RGiOgYRA0L+9TaKoUELQMuLBVwVuBknHO/Mm44YCzTwdWh4Cr+NOOuFL4eLIPSjZ9F2Cnnt2/k1asTmZ16U7ngh+zldm9nhUSwMgKFwjZ3ZXk7RDpycrJciIAghHEGizQpNe1REYKw0lGcAnisS8lnRQFKpgNWHNJWrZjbDdaOHi4Fu/v+PRjJEJ98xaoHwZUf/NObUzb9Fx6CYNzlfNtzPE9CDqhxDs8Z91M495u5Vsevrwso3LR/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEcjN4PtFE1022k4jxmuK8zxoFM7Xd661+jmu4qJtRg=;
 b=rUFvP8FCRGh6wn9ADNBtmDUy/cg4p5Zlgpqctl+nL+tSAI5MkhTLBW/EnDeK8JR/kQo7SFWWv+Gvpgf+nbvmCaHrBQ3khvGENZ3/H+A2mHjwXpA9Qy0Ka5Tc+Jsxak+5bda+ppa0/Uda4mDnapViiSSeaOkh9h5rn2bRmEfnRz5T9zLViqfVKPdkILGLgwiVJiLflLYA9JkcjVrdk9BwMHjFoNJAntx58W/Hm8QQPbADDLh2EMDZ8K0v5y2fsSrIJn3/frhSHFpcRrygSKbzO1tdDtWIW1ClqJnJ4jXs4f3bCfBWbaw4Pe59Cxp2jfGex9nrb2W0LOKFiihLc4TBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7707.apcprd04.prod.outlook.com (2603:1096:820:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 07:47:16 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 07:47:16 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1 2/2] exfat: fix uninit-value in __exfat_get_dentry_set
Thread-Topic: [PATCH v1 2/2] exfat: fix uninit-value in __exfat_get_dentry_set
Thread-Index: AdsnXGajBcSuozFiT2qdfBwuR/bzEgDQsVMw
Date: Wed, 30 Oct 2024 07:47:16 +0000
Message-ID:
 <PUZPR04MB631639CF3C9454F9210B976B81542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7707:EE_
x-ms-office365-filtering-correlation-id: bffd7121-3619-49f4-49cb-08dcf8b71302
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVN1ZFJGQjgzekFBaXVOWFZiMTR4aTlCUlo4MGpJaW1kY3RYaGxad2VsZ3Fw?=
 =?utf-8?B?MEhXdlBiSjZiMFNyVHZPVFAyWWpzYldxOTRhdzJrMlVndXRtZm9ncEY3TTVJ?=
 =?utf-8?B?SzRZVHd2Z2JORkFFbmhOVXo4NnpIVXdKcXIySEp5UThwOS8zLzhqTVE2RVFj?=
 =?utf-8?B?MlJaTFpUajEybmRtK3FHM1I2ajhEN0JXenhLVVh1SDhPM3hFWmRXRmIrOEZT?=
 =?utf-8?B?aWRHUGNnT0grOUo2UXJHZTJDRFdzaGs5TlVwMXFMWWd2a3hkRGlaQ2VReDhY?=
 =?utf-8?B?YmlaVTdkd0dpUWNYWWV3aDJHUUlzSmhrK3c5TDEzV056dVQ4c3pKdStWZXNq?=
 =?utf-8?B?UzZtSTkzTTVzMjlUVTVaWUVIVEtJc1YyMXFCUEl1RTRPaVN3RDRKaDBySzI4?=
 =?utf-8?B?cUs2OHY2MklPekVPSytvVWVQVHIzZXNCR3BxeDhhTGM1WFdBMkc1dGNJMzg1?=
 =?utf-8?B?UFlLdVY3bUpsOUJiUGJhZmU2V0FiZVF2bVU0SmdoOWpUUFcwQWdCVmNCRHVV?=
 =?utf-8?B?YXQ2bHRVSzFNNFA0THpVbkM5Z3JBSWlvb0FuNEZ0UVpnZFRndnF0M2VoaHNF?=
 =?utf-8?B?ZEUzOUhVV01ocldVSXk3Y3lrNXdVSkF4bmp6OEZXbFJ0QkwyRUN0TnREVHMz?=
 =?utf-8?B?c29jMFEzaW03V2g0WWVHeFNXV3kyWGtHNFhiRS91K0YvOHhyQXozMWFJbnZ6?=
 =?utf-8?B?T3hpYnZ6dGZIelBHU0U5ZXp6Rk5XSTA1aDFSdzU2VzB4dCt6Zkh1dU5vcXFN?=
 =?utf-8?B?dVdpNTNLOXF5b1FOWTdCdG9Sc1BHUmZtZUtiZWJjYVA0aHR3ZE9menZnejBn?=
 =?utf-8?B?RkdydlE4S0lxb1FtYXV4eGd3N3FPcHpJaXRFdWNYR3ZlYStTOXAzY0tXbVY4?=
 =?utf-8?B?R25DNHFrZnFocTBYYldVMHM0N1dUSzlvWVZ0SFVIWGg4cGFRdk9CaGVOWU5U?=
 =?utf-8?B?cUREVmh2MWxrZ1lWYXh1cWVxdFZTOGZ6TldCbXFrenVEdEJYN2RJQzhCMHoy?=
 =?utf-8?B?NGlpNGVEU1NHMzgwZk5pcnltRUFuNy96cEQwUENoQWpFLzZ2K2ZzQzdEOHNM?=
 =?utf-8?B?Q2hjQitJUEVYZjZILzFlT0I2QVlmRHdJcm5oT0xvVk9kM1BVdHBTYTdZemZM?=
 =?utf-8?B?bGpTcDRyZ3pMb2FKM2YrRG83UkNKcUlTSVEwR0psWUVubjdndnRYU1o2T1pB?=
 =?utf-8?B?aHIwZnlRMWx3YlBWTzFCRFhCekZVK2ZEVGZ4aS8xZ2NEaFFsL1U2NVRaSDVq?=
 =?utf-8?B?Yi9lQVVIWXA4b2JqUmdpZWtueEVWbWMyQUpabHgrSmdKRUNFSk1QMUkwaUJn?=
 =?utf-8?B?SFBnc1UyTllWZHpCR1FTRm1DU3hoZmxEUTI3Sk5GM3kvNjhYdm9lbTlPUkVP?=
 =?utf-8?B?bzNCblNqVm1DRG51T3NjZndSM0lXSWIyZEY1RS9zcnk4RytoVUdST2ZMRHVi?=
 =?utf-8?B?WjhWMG9BbW9RZWJLS3JyU29sa245UE8ySURLTkxUYzd0ajFZdFdiUHU0NVR0?=
 =?utf-8?B?NHB3RnlwOTJIT1lhbFhTTTAxS3dOaUxKZDdoeHZtWkRRL1kwQ1dvVG5NTXVp?=
 =?utf-8?B?eE80SG5ZbkdVMkF1TjlPbGI2c0ZXbjNlSy85YXRHeE1kQjRDWk00QVNMenB5?=
 =?utf-8?B?ZG9MZmt5UlIxVjZsellKNFk5TTZXZndoalBzMXBiWU92SitjKzhQbFBJZVhB?=
 =?utf-8?B?MDlFWjErWE5VZ3EwdlNpbkcvYWNtczhnTms3S3JYL2s2NWJmWkc2VnppdDFS?=
 =?utf-8?B?eHBuTWNBR2xKMzFXaVpkYVVuV2RLQ2VCTndYd253MFBEUkwwLzQ5R0xJVnpv?=
 =?utf-8?Q?2RwoYVyBXfSFdaIT4c6j4WT0tOOwhwFTBwh+Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEZvcWxiMGdMbXZReFY1NTVMdXVNTUkyVWROTkRVQ2pINS9xc3kvK3poRXZj?=
 =?utf-8?B?N1Erb05FS1FnZU1pbXpjemZuTUJMTlVsL24zNXBtdXk0c3UwOEJjWGsyRXBR?=
 =?utf-8?B?bGxCaXRMVnZWSjhmaXNJMWR1YUt5enZvYzFleUxJak9TaEh5SzFyWFRZQzNH?=
 =?utf-8?B?U2Zwbys0VXh0YlBUT0VFZEdwVCtEcU0ra0RKbFZtWEd3S3lIbFI5NFNVZlJ1?=
 =?utf-8?B?dHdoVlE1aUs5MmtRZVVjVUx2cFJYZzk1KzE2NDlHZjBEQ2FXa2xSSUFSYml1?=
 =?utf-8?B?QzlaQ2k1NUJJeXFQWmFYMzNBRWg1YmhjU2xPSzdlOGVNemIxRGhQZFVNSFZX?=
 =?utf-8?B?MGIzV0pJNjVQT3lhdGtkWHoydlF5M3dGajRrU1Nzcm5rcm93aXlXT2xBTlZw?=
 =?utf-8?B?R2tNTFdVVmpPcGIrWmE4OWlIMjJZQWZ1TjliV0pVZ1Z5SXY4UGIraVM5emxi?=
 =?utf-8?B?RTRyVjZ0UmNvanJHOHNhVnp2cUtVWm5tZm9ibHpFV1NvZ0UxVHRKUVByNFEx?=
 =?utf-8?B?OXNzVVBIVUpnQjJIYjRxa3NqeUttSVhWZjdtWm90Yy9meUVmMk8vM0pvQmk1?=
 =?utf-8?B?VmRUSTNycDl5Q1EyTWdsRXY4MjZiNUxaeWZ5WXZLQ2xJMFk4Q1QyK2tHY1hL?=
 =?utf-8?B?UmRYVkhnUU9uTXNEeSs5YnRVWmpyTFpkc002Q1dOUmsyUG4zRVIrcDdrdzVp?=
 =?utf-8?B?WWJlNElNV3hDWGVWZ0Y1QUtQM2poa01BcndWOTBvWWlsL284eFNucXpNM2NN?=
 =?utf-8?B?aVhtODV3TllGZ2N5OVY0SG9FS3dlaW1BanhIOFQ4cFROeW81NG9XRGtzNmRL?=
 =?utf-8?B?MjlKV25qRFJqbmdQblc5cURrRkRZTlJ2MWM3Zzdtb0VxeWpCaFV4SHR2cm51?=
 =?utf-8?B?V1J1UlEwZzg3a28xUDljZ1g2R1laRmc1ZWo2T0Jwb1d2NzZ6R295V1FhdDZ4?=
 =?utf-8?B?Z0gvUzBzd2NjbDJhUWxtcHFud2J6cFdGVjRXUEh4QWk0SjVMTWxGQnRsNnI5?=
 =?utf-8?B?ZThWK242TjhTbWF3VGlnK0Frek5EYWlFRlhTYTlSTEM1d2hXTzcwcGFPUVNq?=
 =?utf-8?B?T055eklKWG1ndi84SEFiVXVnaUdtdTRvOWh2VXhaZWE5ZzFkQWNQbk5SVktQ?=
 =?utf-8?B?cmVjU0Ezc21YTDd3bVlJNVQ4OGo2bTg4Y0I1TUdJZzIxT2F1Rkw3QlREd2ZW?=
 =?utf-8?B?cXRmREQ2a0lVaUlzVnpVVlhSSFpqeEc0b0xpWEhjK2dTMGpFSDJueEY5MUly?=
 =?utf-8?B?a3dJT2Ntam1xZ1RjTWpmcVhkM3V1ZmFQbFZvdnY1blpxdG5CSEovYXVvK1Rs?=
 =?utf-8?B?SXpmaEVnbGg0QVBRaGRMUytNbFArUXF4YU0wZHBoQVZyZkN3RG5GaEtJQ3A1?=
 =?utf-8?B?ckV6NHZMMEJDU052eG52aGRDSm95MWp6K0ZaTkI2Zkg2ZnF3MkY2eW1qVFlN?=
 =?utf-8?B?TXRVUGplTTdpaTNXRjdkNGo3LzJvUTlRbXV1YXhPcDhyZGNGTi9lbUpHdkNq?=
 =?utf-8?B?ekhhQXhJaHBYeG9xQVA1dHFocTNVcytYZTlJcy96SmkrVTNpVTMxZERxVGlr?=
 =?utf-8?B?WWIwZEVFUEsyUGM0NThuY3FyYnFwekFnK1V3UFlvZXV3MXJSUXBNRHl0TkhC?=
 =?utf-8?B?QkVGY29HazZuc0l5clZLWG8vbVBYMDhBdzhxMStOZHVodmtGZ3htbW83Q2Jw?=
 =?utf-8?B?aHdGakFiQll4bWdXR1V4YXdBTldnNkhpeUVoemZXNHpVbFNDMlNaK1FJK1Ni?=
 =?utf-8?B?YXBsQWwrQ0JNUmJ2aWFjZVl6ME9SMnpiUk1hdHhHa0VnckFGZjFHUnY0aU41?=
 =?utf-8?B?cGhyc0ovRCtyWmhKNXFsWE40bWc2T05RL29ZcUQzYjJ5OS9ENXRaUzdlUFdq?=
 =?utf-8?B?aEtORnVqNm5oK25VbEljRFFGY21nMklSSkVmWDUweG1JT09nRGJOSlRnSk9C?=
 =?utf-8?B?cE1aa3d3dUlPUWpwams4UkQ3aDB4UXBBbmlFejVZaFgvWXhYZEpyTDl2UXdl?=
 =?utf-8?B?NVl5VWU3RHBzbVB4a1pyblo2RVp5enV2MkZnWVlCUGcybnB1QWQxWEdlc0tN?=
 =?utf-8?B?cVNZeXBnVkpSdWYwY05iTTkvY3VsazZiUUs3a1BFRmoreFNqUHJaMElrMHBj?=
 =?utf-8?Q?pxCm6kkTl/oHVNg5XZG79aC11?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VjXDc6K8Xw21IbQaK/5S7p8XC522CRFAUU8SzmyQ1TzHWZkGnUMt+l+8IHoOnUo7hcfQaM8qiCVvwL9gwErh2PkD+gB79xgsdXtLTpCW0IHzZMePx3vVjWlEsTvGo+G+bb+7nJAodHQpGPmy4L160zxc9h/DsOflIy77dod3AQCg0zQvRMx1XEmri9bqV0GmWr6R0ZyXbVt2RTOzkBuN6OBQ3z5s5x4IY+7P2VZyFAc/biBCE333BA+2MB6lZPuGfResPM3pSBqNHHDTpndcf4ilNWa0X4kivLa5CSEzhxy4zPJGJBXZ+WsHBkGb3P9IMr3yQ9279DX+Z75egl0V0VgHrERsubUDWEuOnR+2ZBUfgpfiU3/Hobh/k6iDPXDEVfW/mn0FqcD2rYrjmNJAkuGc2G9Rk03zFQn2//pJuaQsFgxOb2iTs8Q4rttSD2YHdL2OW4RjrjuAZe+o6PC/Tt5urxzS9vO9+r5goJGIrejWfCifMxPK92P+oyo3ZPqhiHyDp55c3/kQ1RW65Hvs1YvVPKgVfGwLUFwFwqW0VPPvLHdUxHw26d4x53ebarAdw5HHlN9NxGamuDh+KoQheLk/KlnVTEfqTIO3U3rm5pGQPXu37FveOeN3BbkSyyqD
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffd7121-3619-49f4-49cb-08dcf8b71302
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:47:16.0853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXa6sCLvrw8kIKrhD/fuCuLX5BWAYz84fBEyYNMb1yjPWBSbk+Ewuw9swVsNc683rgp7LUZq5mX2sT3Irq39VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7707
X-Proofpoint-ORIG-GUID: 6JaPx5CBxRtib82KJo0jsxoEBf7NxEkB
X-Proofpoint-GUID: 6JaPx5CBxRtib82KJo0jsxoEBf7NxEkB
X-Sony-Outbound-GUID: 6JaPx5CBxRtib82KJo0jsxoEBf7NxEkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_06,2024-10-30_01,2024-09-30_01

VGhlcmUgaXMgbm8gY2hlY2sgaWYgc3RyZWFtIHNpemUgYW5kIHN0YXJ0X2NsdSBhcmUgaW52YWxp
ZC4NCklmIHN0YXJ0X2NsdSBpcyBFT0YgY2x1c3RlciBhbmQgc3RyZWFtIHNpemUgaXMgNDA5Niwg
SXQgd2lsbA0KY2F1c2UgdW5pbml0IHZhbHVlIGFjY2Vzcy4gYmVjYXVzZSBlaS0+aGludF9mZW1w
LmVpZHggY291bGQNCmJlIDEyOChpZiBjbHVzdGVyIHNpemUgaXMgNEspIGFuZCB3cm9uZyBoaW50
IHdpbGwgYWxsb2NhdGUNCm5leHQgY2x1c3Rlci4gYW5kIHRoaXMgY2x1c3RlciB3aWxsIGJlIHNh
bWUgd2l0aCB0aGUgY2x1c3Rlcg0KdGhhdCBpcyBhbGxvY2F0ZWQgYnkgZXhmYXRfZXh0ZW5kX3Zh
bGlkX3NpemUoKS4gVGhlIHByZXZpb3VzDQpwYXRjaCB3aWxsIGNoZWNrIGludmFsaWQgc3RhcnRf
Y2x1LCBidXQgZm9yIGNsYXJpdHksIGluaXRpYWxpemUNCmhpbnRfZmVtcC5laWR4IHRvIHplcm8u
DQoNClJlcG9ydGVkLWJ5OiBzeXpib3QrMDEyMTgwMDNiZTc0YjVlMTIxM2FAc3l6a2FsbGVyLmFw
cHNwb3RtYWlsLmNvbQ0KVGVzdGVkLWJ5OiBzeXpib3QrMDEyMTgwMDNiZTc0YjVlMTIxM2FAc3l6
a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KU2lnbmVkLW9mZi1ieTogTmFtamFlIEplb24gPGxpbmtp
bmplb25Aa2VybmVsLm9yZz4NClJldmlld2VkLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9A
c29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9uYW1laS5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMvZXhm
YXQvbmFtZWkuYw0KaW5kZXggOThmNjdlNjMyYWQxLi4zMzcxOTdlY2U1OTkgMTAwNjQ0DQotLS0g
YS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAtMzQ1LDYgKzM0
NSw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmluZF9lbXB0eV9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLA0KIAkJaWYgKGVpLT5zdGFydF9jbHUgPT0gRVhGQVRfRU9GX0NMVVNURVIpIHsNCiAJCQll
aS0+c3RhcnRfY2x1ID0gY2x1LmRpcjsNCiAJCQlwX2Rpci0+ZGlyID0gY2x1LmRpcjsNCisJCQlo
aW50X2ZlbXAuZWlkeCA9IDA7DQogCQl9DQogDQogCQkvKiBhcHBlbmQgdG8gdGhlIEZBVCBjaGFp
biAqLw0KLS0gDQoyLjQzLjANCg0K

