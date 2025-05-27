Return-Path: <linux-fsdevel+bounces-49939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76EEAC5DCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 01:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E11BA6381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AFB218EBF;
	Tue, 27 May 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QgGD2S5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F976F4ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748389210; cv=fail; b=mYdn42jCmSX1zaeq9d0d4js1jyl6bWnDmvYnjkhR3a3CwrDGKZeabZc5MelLfNg1i1GZ7QNL9uveU6ceegfY6WSBYHglQBbjG6J5KFgZ+b0/iK1GNR45cf1wacrE/r7BtoOJYfItoK3+f1n42yyjFSHjRnFGLpqnAr9qQyprlL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748389210; c=relaxed/simple;
	bh=TsJoC8dhMniB7ouWezkvEfkVAZKmBLHSV4lYpPigltI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VWGQ9/hnOr5h6TricIgkg/7MxjcEt+G6eYm0F6+ULto6vn/d1S7eLgubCoRIh3Z/hPXjspQzDF6U9+55FS0zOqqj1RbdMaMpoYYTS3xIpGit/zmUVoa8wsoK7cnh6Q+KtiN2+iqf2MtbeFVAwV9GLt+OefYSkBLGu2lImNiFOvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QgGD2S5V; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RGHfi8028620;
	Tue, 27 May 2025 23:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=TsJoC8dhMniB7ouWe
	zkvEfkVAZKmBLHSV4lYpPigltI=; b=QgGD2S5V3MmotHfN6r+0YUH9UBYd97kNr
	KmiNfGRKx7K3S3fot5w9i7uqCkBzWXVuVdD/vysqIYDji1qu5PjFxzLpxww1+XgZ
	AktlJyWLd8gKtzYrG30vAEvAaofZjbB2DCe+NMHwqrzStoRQWhAHBs0nRQ53Ez5N
	NCHSEZI1RDCUMjGRRt8n6F1MNbM6BR6FcvB2uUHmhkAfoZ7JST+P6LZeW99FmgYy
	fbmIK4KhxmL5jDTLzl+3L/vzx4Moc2s6nXUYswgiP1Kk+bbSFxrtW7UFmTGllEDc
	WvGKw0ymVLDd0iOTma2cT44Pu6B7NqKMjOazKAdU/xWuGvl38ltkw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsn9tb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 23:40:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClobdX8b/YunFuX2Hvsr39ky2EM3yLEN/oWLeqWWaOE+2cmTTyxitULjkgDJSHb0uVlJPv8wSJFrtan+q7ugdtYk4ebHXHJiCNHdOJkP1Or67hfLuN2kfs9k7Mg7WW7dhMXVB9qb5K1fsuU6LAHeEVMLY0bCgXLFevq73uFtiDrpop0LEnyxtunSWEIGDPogNcLH3vR/IZZgeRQLTLpWd9oMWng313Kjq82r1GqQjeTAX3O8umW/znwdqwa6NmGZYA6B/6sI/MMRfPiCj04bPHQGYZdBgFv7wYlRUuyL0D5fLFO0Vbgi9l+hZJIuykaJ12kTTrxaThoRlehHdHBo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsJoC8dhMniB7ouWezkvEfkVAZKmBLHSV4lYpPigltI=;
 b=raxI2nJABag4JEDwTOkK8l4IxcRlw8bIQqzeyR2FXlDPZu3rLpSWDWWe/QRJni74b7mBBMTvMz1CXNm3yJB133s5f3gprDtWeEqssBl4zLLZF43zko3h9IhkkuFiU55Ws6VZjSuiAVC8N/sJrdY9rX4P7aTjpcn0ZeyPkFx0KjG3xtZx7bZ/gOpZthTmwHRntixO4McbngKbDxBxkgMMq/x7ZtkSrRGpozL37nmodpOkjyff6xIMuzdmVUFJ9hy4MV5bjtHPoWH7zpHM+5HTH7ZSRleHwEs88NnUMYyzM+r2FzfDY9nswsypKa0WTVJa1IVgFoJovG/0gaNSMfdVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB5753.namprd15.prod.outlook.com (2603:10b6:806:342::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Tue, 27 May
 2025 23:40:00 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 23:40:00 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Subject: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
Thread-Topic: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
Thread-Index: AQHbz2CpCY7FD08WfUuZLsiXLlP+iA==
Date: Tue, 27 May 2025 23:39:59 +0000
Message-ID: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB5753:EE_
x-ms-office365-filtering-correlation-id: f29238c5-a60e-4523-5685-08dd9d77cbc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YW1wbUM1UklQcFZsRyt2TURmQTNTSWM0UmJtb0hsbkNoekhRbFRnZVRTcUEy?=
 =?utf-8?B?Z0t2OHFqY1RlSSt6cmJldTRmT2EvRTNQbHlEYU5rT0JMRWY1YVNVd3RBWmxi?=
 =?utf-8?B?S0t0czVDV1I0dlh2R0NYRXQrdmJrUS9nVnpSdGs1aEZxYlNnM2pRY1c4Y1Zl?=
 =?utf-8?B?NjA0Q1FQM2lReDlHNGF2cU9XY0dObUh4RE1NYXMwbmFjcFhYSVEzdmVDVGda?=
 =?utf-8?B?VTU5VHlKclVjaTBBSXh3dDN5SkNCVG1ya0N0WndWSEgwWU5uMWZmYjByRlBY?=
 =?utf-8?B?WGwraUdiek5JNDVEZU1Ob0tuSHBKWXJDL2xEVkVlUmQ3aHgvLzJBaHNvYno1?=
 =?utf-8?B?ZVpxcnlVTW5MY3d3QVhlNnF2T0w1aWlTVzhJYjlvRGVIRXdoTVRxWTBFL00v?=
 =?utf-8?B?WmNqWVlLczdnRENnOUI5THhac3N4bDNOUVpjc25LUk9wK3ZZaWQwYWo4d2Fk?=
 =?utf-8?B?cHVRaFlPM0h5b0VQU005SzVYdTJKZFJJb3VDaTR1NWRqWGRWQTJTbnNJY2dO?=
 =?utf-8?B?eCtTbzBuSGFGb01UNEtmR0hrTXJpQXRFNkt3ZXZSbk1mYk9uSXY0d3pVODVz?=
 =?utf-8?B?dWVqeGNoSDEyQ0E4L0FOU2V5K0Q2Nm1VeklBR3ZsMUxlaTRPSzB2dkg4RTkw?=
 =?utf-8?B?VHFIZlBFaDhhTFJvbVpUMk1SSExVTzFSMDNhTW1WaHJoUXl2SVlZWGpEVUFY?=
 =?utf-8?B?RGRTcGw1RWNPMlQ3YXlVSEgyM3F1cjh2aVFqVEk3SFNZSFgzYk1VZmpyamNY?=
 =?utf-8?B?K1QvRFREWkVkQTBYc3FmZU5aVS8xaXd5TDhFRFhmNThBaDZFY2NFc1VtNzJN?=
 =?utf-8?B?cDhQbkxUNzFCdUFpSFozV05yWkY2cTh0WHJUUzUwb2tvUHhKb3puQTVUZkMr?=
 =?utf-8?B?amhESk9kU213VVVzbjdVUkxrZ0dWcDhHcFY4UTM5NEVhU3V3WFRIdHA0RmRu?=
 =?utf-8?B?SDNWSGZiQUpUaDF0T2pubHRNNGpxSFBFQnJ5YmZvL3VTdE8vTjJHakMrNHN0?=
 =?utf-8?B?S1pGVE90aG13U2t1ckp3YmdkRCswb3NOZjFQcHJWVDZLdjE4Y1JjQTNudndK?=
 =?utf-8?B?UVFzOVdSeWVDME80UzlEbW1oc0lFcGNyS2ZFUXQzdXZocEFVdWtVOTVjamhV?=
 =?utf-8?B?WUxlVmhaa2kwaXIzVm0rWE5lcTI4SzR0OVgydlZQYmlLN0lMbmFOdm4vc0Vx?=
 =?utf-8?B?Mi9RcFN1SjJkZXVZdFlDTnp2L2RYK1BCRTlkYkxyOERWWm4wQ0ZWeHRLYlM2?=
 =?utf-8?B?bW5VYTlqYTlJTERaQ25XRWRuNFNWckFhQ203blBmS3Rhd1piRDJlbEEzdjZz?=
 =?utf-8?B?d2hqS0ppdWQ2ekl3ZGhyZUdpQ0pGSnkwY3NKM3ozcmFqWG81VUtIcm1kSGo3?=
 =?utf-8?B?YTJmVFVMVFMzL2FEMThyMHVmemdTekhuTStKVWVOaWlCekxpcVozcGZ4RzVI?=
 =?utf-8?B?Mm1hRSt5TEU0VXBOTWloSUhiclFvQUxDVnlBbmtHN1I3T1k1VGE1YW5LSU8w?=
 =?utf-8?B?RjFZVTUyRW1aQnJDc0RCRlFmMDlCNmUxM1piRUxjOTErWUdNNXErTDRJU1hZ?=
 =?utf-8?B?U1d6anZ5NkZYRktXbGlXMThrNVh3dElSZjB0S2xVdDA4c3A5TWJwbjdtU3Qy?=
 =?utf-8?B?ZDh6YWlDakhNUXlkdWd5RXNDMkVvKzdoRExNRFVkTHlBT2taZEdRRnN4NGN0?=
 =?utf-8?B?TUpGbVd0ektXa2lOakZOMVp3TTVxbVdMMFAwMjZOWVh1UXlxV2taSFRuVy9U?=
 =?utf-8?B?STBJY0hoYlZUdHpNOHBybUVUZjJyOSswTWxSSmZyZEhYVEJGQWJHSitmcHRC?=
 =?utf-8?B?c01GMFZNeXJLVDVIV3lRR21ST0FveVUrYkFnZmdFTnhvSTBXUklCeEtZaXdz?=
 =?utf-8?B?amJHOW1yTmZEV0dTZm0zWFhWTWNUdjJqMzBwTy9wWndrOHl6RUJISTFwY3Nw?=
 =?utf-8?B?bkFIRnVBcDRteHdWenJrRXdDMlhSZFF5ZkFQRFM4c3hSSXkwUDRJUHhiTkNS?=
 =?utf-8?B?VlQzWHE5SFVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0M3Umpka0JNaDdWT3dEZFEwSVRaTW1uT041S1Yzcy93dUpRY0VZQzZrNEgy?=
 =?utf-8?B?amV1Rk8wS2pML1lBSmRjdXY0bXFPVEFlRFN0cnFCQ25aRXhpcFdwd1dSQXR6?=
 =?utf-8?B?RWwzUjJvUTJkNWF6ZjVBUTdqR2ZqOFhtcjd4alZzK2Era2pWZlFheTVBNjVY?=
 =?utf-8?B?bnRMR1Qxbm9hUXczaUcrd3BLVmlVRm9za1lpL05IVVVtRDRTOFVNN0c5dWts?=
 =?utf-8?B?cGlsSmlOME1WTnExV04rZUJOTGVYRFNpc1QyL0tEYjlNTk1TdFdxV2ovSno3?=
 =?utf-8?B?MkkxUCtmN3pLSS9nVWZ6MnZDSlNDa25nVTA2R0w4Ty9OVWFpbjExTVJEa2VL?=
 =?utf-8?B?Z2JjdUM3bDZWcyt3S29BVFNWRUpsc2U5d21iM2NJa1cwclJEblhxaTZ2d250?=
 =?utf-8?B?MmVTaWdvQWdYQTlSdXpuQWFzVEU0Y0h4V3gyY0JqQU1RUE10cEVNVml3bDRV?=
 =?utf-8?B?bllDOFhpT2ZUV0d6Y3M2bFp1Y0VUbDU3ZHBSbkxVZjdtNUkrcTNiNzM3eFFU?=
 =?utf-8?B?cXJsQUpSWWdFK2dqejUreEl0R0lLQ1hGamNnQlBYSXRKTU5wb2VtL21QeVAx?=
 =?utf-8?B?dnVzdWJuUHRYbWxPeUlFUGJ4ZDkzZXBuV09oZ21BamVSRVJsb20zWENVWmtm?=
 =?utf-8?B?TlNlU3RaRzdPTjlxN3hBWmN4T09GdkJhdzVlclJMeEExZXVPWEJzOHpSeGRa?=
 =?utf-8?B?aVpHNWJtRnBPUXZNeHk4RnBuODljeUdYcWFHRTVOSUxmSG41cjZ4MVAxR0xj?=
 =?utf-8?B?R0pQOTRXMldzSW1KUkt6bmJNY3RKVzgzaHhhbkJXR1lLcnhGOHhWcnd5NEFZ?=
 =?utf-8?B?aVVqRTdIWDRGdUs4VWpUV0FZTkg2VktSVlpVeTlkRDRlWDkvYktoUnRUNC9k?=
 =?utf-8?B?U3hZek5jZkJNSy9PMEp4b0E5Vmt6TnV0ZDlnNkgzTXlsNGJzS0d0MDVXQjdi?=
 =?utf-8?B?VjZHaThnbHJFZWU4T1pzSjJhcWxCbEdvMmI3RmVkZ3R5aXdoN3ZZejZLMmpZ?=
 =?utf-8?B?Ynh1YllXMUdCK1E5TTNwem5GSkpOaUV5RnBPYTNFSlRlcHgxRG9uNFBLM2Nz?=
 =?utf-8?B?N0Y1RDFHdGFNNWw0NWtiTndSS3h6MWdvay9wUkh0TkFPSG5RaHVsK3AyNC8y?=
 =?utf-8?B?SHlsaXNZbnNGdkRDVmpWZXp4Yll2b2VxMWtJZUxEWEZySnhDQm1kSVM5VVE5?=
 =?utf-8?B?NER4bVRpV2NUWjZoRExZUGNidHB6cEV6VGlvMEdyWFh6Tzd6bkZsNSs3d3pR?=
 =?utf-8?B?OVUram9mdkd5NUMxVmdMYytyNHluN0h1WExVUS9kbldGNFJTL25ZajlZLzhZ?=
 =?utf-8?B?OWs5ZzAxNnQ1M29QZEpUd1IxSFpvbk1FRU5JTEJpQ2ZlZEZhYlE2aWpIWHRL?=
 =?utf-8?B?UVNGelFsTW1ZUmoyNk14UThsNW9GdkNjODB1cnFsVCt5WGV4cndoTGNjNHE1?=
 =?utf-8?B?dExPVW1sSWRQWWZJV2F2aHZXU1NDT3lKSHBRYlFiVXlETEFCNmtMdklKNC9Q?=
 =?utf-8?B?b2Exakd4K0tQa1ltb2wrRC9hcElVRDBvYzg0QW84THhoNXVUL0FwZTJ3T29j?=
 =?utf-8?B?ejNIcEU0Q1IvclM4Z3dBREYzTkpHdEJUcFpWQVVucCtIbHU3b1VBKzV2NENO?=
 =?utf-8?B?RnB5S1NndyttNFFXMS96RjVtV2JzbWJhRzEvUStWRkdIVmlvSkI3RDNCRkJ5?=
 =?utf-8?B?WHBkZ1Q1WUtsL0pWU2xaYTVqMHQvQ2ZJa2dCM2pydkk1djYydzVNeDA2UFNj?=
 =?utf-8?B?U1p1Q3hOMXdueDlUdUNIRHVsYkxFTTNQSFo4c3kyMXcwK0lsRHBnUzFCbVIr?=
 =?utf-8?B?TkxxTWtxcktLdXh2N3d6SFNEWm1HemNFVHNQbmE1OXU4N1JtQU1aWFkvRk1T?=
 =?utf-8?B?ZFJUcXRGaVdrblRnWDhZU2RtSk9qOW94ajUwVHNKeGw2Q1NEYjV5dkh2UEJI?=
 =?utf-8?B?cnQ5NEc0V1dURlNJQUlxem9JMGNFVW42WVo1MlJnVnFJMWRhSzZ6RFNFc0Uv?=
 =?utf-8?B?bElCTnFydi9mWUd1WEpSOC9WanhmeDFVSFFZbVhqSGFMaVVWRkRJZUs1OENW?=
 =?utf-8?B?MjdTSFlzckZmSjJpWmpiZytPZUJtK25UZUk5MHNPOS8rem5vdS9XbkJaZjJZ?=
 =?utf-8?B?STFxL1JtaEF5RWhRNGY1NVArSDlTT3ppR0FjWUNMZW56UEhHYkNMYWpzMjdP?=
 =?utf-8?Q?DAslM95H+2Yzkf2YdOhmj9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C5A153542C1F8458DBE30E9F10FDCFB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29238c5-a60e-4523-5685-08dd9d77cbc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 23:40:00.1304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULOpakXhhV4p+RWjdV8tAsX+vjcitd/z0H7Y5Sikg6ElLy+ZLnizEn+xLBnVMBOdo7sJqXjXmDJRU8JOGyzQRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5753
X-Authority-Analysis: v=2.4 cv=R7ADGcRX c=1 sm=1 tr=0 ts=68364d53 cx=c_pps a=qrXqrasEdc/lfzlssxSwCw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=cXFkQ2YHjkrZR8Cc8agA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDIwMCBTYWx0ZWRfX29BslPaN7bQD kv372NNqWvt4bnZTFnE2KQzQO8Ztf2YtgRcAr5NR3yLS9FYFpEMCwSK9N62zzYatds0K+aR0I6F W3J8/YV7nrjD5BjgeRpmfVaFieuao6F1WRm0hGMT1GZe2SZQbjQIf6G5eL2n0SUe9QDPszOAgzO
 3HGPyK1uf/QrXgF7PhjrauWY2Z7wHj/+XQXzbYrxR5vt9tpQhSgHIDSOExHcCIDT4OarB3sGkZL HMDZUspxUn9QoSF3F6aB8uJcXz1hlyCL1ITi/kARYAbFzele9w3Ffb4+DEJhilqW5Q2dHBIl6kX 5rEuXrBeM9CLLoo/5pMrXeuRlMO+EzrgEqv3R4/dJAoSlQxTg36u0ZNhBM5Sz4FVZ+KqZAoS4aZ
 ztrV3xKq5OKA/NtqJzWvDUSTHZMsefXUoF3JWrjdLKn9wlmp/A99xsYyft1MsDYT623vo/jD
X-Proofpoint-GUID: 52Oa0tboYPL4fTfAhKygJE4BUXPK8tma
X-Proofpoint-ORIG-GUID: 52Oa0tboYPL4fTfAhKygJE4BUXPK8tma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=308 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270200

SGkgQWRyaWFuLCBZYW5ndGFvLA0KDQpPbmUgaWRlYSBjcm9zc2VkIG15IG1pbmQgcmVjZW50bHku
IEFuZCB0aGlzIGlzIGFib3V0IHJlLXdyaXRpbmcgSEZTL0hGUysgaW4NClJ1c3QuIEl0IGNvdWxk
IGJlIGludGVyZXN0aW5nIGRpcmVjdGlvbiBidXQgSSBhbSBub3Qgc3VyZSBob3cgcmVhc29uYWJs
ZSBpdA0KY291bGQgYmUuIEZyb20gb25lIHBvaW50IG9mIHZpZXcsIEhGUy9IRlMrIGFyZSBub3Qg
Y3JpdGljYWwgc3Vic3lzdGVtcyBhbmQgd2UNCmNhbiBhZmZvcmQgc29tZSBleHBlcmltZW50cy4g
RnJvbSBhbm90aGVyIHBvaW50IG9mIHZpZXcsIHdlIGhhdmUgZW5vdWdoIGlzc3Vlcw0KaW4gdGhl
IEhGUy9IRlMrIGNvZGUgYW5kLCBtYXliZSwgcmUtd29ya2luZyBIRlMvSEZTKyBjYW4gbWFrZSB0
aGUgY29kZSBtb3JlDQpzdGFibGUuDQoNCkkgZG9uJ3QgdGhpbmsgdGhhdCBpdCdzIGEgZ29vZCBp
ZGVhIHRvIGltcGxlbWVudCB0aGUgY29tcGxldGUgcmUtd3JpdGluZyBvZiB0aGUNCndob2xlIGRy
aXZlciBhdCBvbmNlLiBIb3dldmVyLCB3ZSBuZWVkIGEgc29tZSB1bmlmaWNhdGlvbiBhbmQgZ2Vu
ZXJhbGl6YXRpb24gb2YNCkhGUy9IRlMrIGNvZGUgcGF0dGVybnMgaW4gdGhlIGZvcm0gb2YgcmUt
dXNhYmxlIGNvZGUgYnkgYm90aCBkcml2ZXJzLiBUaGlzIHJlLQ0KdXNhYmxlIGNvZGUgY2FuIGJl
IHJlcHJlc2VudGVkIGFzIGJ5IEMgY29kZSBhcyBieSBSdXN0IGNvZGUuIEFuZCB3ZSBjYW4NCmlu
dHJvZHVjZSB0aGlzIGdlbmVyYWxpemVkIGNvZGUgaW4gdGhlIGZvcm0gb2YgQyBhbmQgUnVzdCBh
dCB0aGUgc2FtZSB0aW1lLiBTbywNCndlIGNhbiByZS13cml0ZSBIRlMvSEZTKyBjb2RlIGdyYWR1
YWxseSBzdGVwIGJ5IHN0ZXAuIE15IHBvaW50IGhlcmUgdGhhdCB3ZQ0KY291bGQgaGF2ZSBDIGNv
ZGUgYW5kIFJ1c3QgY29kZSBmb3IgZ2VuZXJhbGl6ZWQgZnVuY3Rpb25hbGl0eSBvZiBIRlMvSEZT
KyBhbmQNCktjb25maWcgd291bGQgZGVmaW5lIHdoaWNoIGNvZGUgd2lsbCBiZSBjb21waWxlZCBh
bmQgdXNlZCwgZmluYWxseS4NCg0KSG93IGRvIHlvdSBmZWVsIGFib3V0IHRoaXM/IEFuZCBjYW4g
d2UgYWZmb3JkIHN1Y2ggaW1wbGVtZW50YXRpb24gZWZmb3J0cz8NCg0KVGhhbmtzLA0KU2xhdmEu
DQo=

