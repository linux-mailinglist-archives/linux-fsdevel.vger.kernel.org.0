Return-Path: <linux-fsdevel+bounces-67377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F164C3D622
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 21:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406663AE947
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026EA340DA6;
	Thu,  6 Nov 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nrFTzTEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A833C50F;
	Thu,  6 Nov 2025 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461643; cv=fail; b=O3nCKltS0HNyqzZhiz16cWxjrwEKHRv0SNkNaJuQ9kuS0Kpe8Y91LfKR5gzcDFFKbVUIDt1sv7kfBxVKt0+xX+xrfp3a+2gGR2Jf7CgxKB4UtIVOJZ9zUuAmNQI2a/20wV9b8RkdqQ4nsfV/NfvjnbLN2DD673NL40c4KYt8Txg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461643; c=relaxed/simple;
	bh=FjUzg5+J3xEVxMYt+8ZdedrIC4CQW80wa+JodRrvUBI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fE6ngGxgit4DM0ViulzWRmgzzxMloO4htxKUlR+RBX5h+/xSa40mhWIDJoKmVJaNa1BiEmX8PcRbVDjlFSedAHcVEk3g+4I/r8mHLzULXQEuoDwaVmUsyzs24hH8g0mtoGqYNtjRJojjtfEHJvKcqwGAWNED7ZZMuYk2GXTlA/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nrFTzTEN; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6EJdVV028910;
	Thu, 6 Nov 2025 20:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=FjUzg5+J3xEVxMYt+
	8ZdedrIC4CQW80wa+JodRrvUBI=; b=nrFTzTENSsQpT3EorGV5UHGSx4z0Y1ciJ
	rtpV3l1EcxHRzz0ssEktuaLx99BAeI09MmZ57TNA27zn/p7OUdVw34p1gokqyQ64
	UnZqVzVY97v92/mQXE2kyTik5vPgkkYd/1ihP+QWlVXbn2i3apFdaiQ+8nsVbTI4
	CNiaCX2+lBLQJJmM5qy08AFKZ0oXU4YF/Mpyejkh1D7PVcjoeAmPH1nrdUxA4fV8
	QqvTM7ftWmvIdkY8Ma8a1AoR3BfasMXb/z5n1dcTUiHxCUveUBLiBHE1/HZT8+NC
	QvqZxwqwvglmd1kFKsa+8h/KpP9OJP5wYvbbdoekSil6AEdZvOnsQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v2896n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 20:40:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blo6m1srbLMUxCWNojuM0xlKJS36RwdIlFE+f7F5IDfuqX3WVZHeKFbLfcHvdLAHO9t14WVCB0iv5oONYIGM3bW2KcNRMLK29ia5NbRtpM9dnpknYk4Ob7aSUgVrvUn4qM+kzfQMtjOd06wlhctHiFyhSRDpB4qc5UwL9epE7DTUBbexZGnljWp/WZxWxG+ez/TwgVmySWunWteR/1oIcF4dGCyW8NR2AVOnyOHCRTKvjuGPMqBwVlJVGZql7EJMbRYLjsRkM9ofUBQlIDyp+5Tr4BiTnmnKPjCYVK+ESt9EYr+nFvsIxW4o2l4tLuT/xQebLDYaRGfvNdR5fwERSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjUzg5+J3xEVxMYt+8ZdedrIC4CQW80wa+JodRrvUBI=;
 b=FPeFRG4f+qN9Rm858lhHVfnTwNkmYoccCt0HMZJygBE8m3ovvc+A8JXfLfpI19rRvpqmLJezdny+Ma2mdLVIq9aDmJ3SLaV+XBN2q/vDDg+qyBGB5VHTcD8qZVZxyiSGGdeyEWyw/bj2JVkDWotXHun8suL/BHgJJDxoR4V8uSL4/G2OxukXwbml2mYDIrPFMdJJo6WKhN1L2wlp9msMFkRKs7rDgoazwsk5/aZ1kyXRZeB5AqVCgkcNprEMctvY01TrnUIEnWU5G1kOIp3SCd8VFVM5z7Ju2HqX9DIZW0jM3eNehnspHPb9/KsdHrcnoOFFxlvLungFb8YFMz2oGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW5PR15MB5124.namprd15.prod.outlook.com (2603:10b6:303:19b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 6 Nov
 2025 20:40:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 20:40:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: [RFC] Why generic/073 is generic but not btrfs specific?
Thread-Topic: [RFC] Why generic/073 is generic but not btrfs specific?
Thread-Index: AQHcT12Yh6lLNevRjkO1oS1HPlyWxA==
Date: Thu, 6 Nov 2025 20:40:33 +0000
Message-ID: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW5PR15MB5124:EE_
x-ms-office365-filtering-correlation-id: 65a25af1-6fd6-447c-5332-08de1d74bb70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEVraHFWeUdSOUxNbXlKakNkTUhEMWpwVzhmeXJDaTRzZzFRYzhobm5HanVs?=
 =?utf-8?B?YTNDbTFLM0t2OFdBRi83c3o2RnFaczc4WHZYazlqcXJPckxaWi9HeVdjWlFU?=
 =?utf-8?B?dHJkK2VYdytSYmRnRHE5WW5OdUQ2SzVWNkYvZDhoQUxOZzRoQzFwV2E1eFBJ?=
 =?utf-8?B?RGJzZzB1Q0o2YlZCVTJzM3kxem9UaXlwTDJDYjJuQTQrY2EyTXQvTzZOcnZ4?=
 =?utf-8?B?ZnptRDNOeWVTbE5zQkl5RERsL3M5bzNRdWl0M3JCd2xFa1VJbHFFV3RSQlJu?=
 =?utf-8?B?OEVHL0pKUkZ5RldBaWJFSGNENURTZ1Qxc3czaGk3aml1NWZlamgvYW1oYUkr?=
 =?utf-8?B?VDdMaHpHTEVxZ3gyZ2cyVUZmb3U5WVBvbmZ0VVdwS0ZIdXUyK0hKZmZOUHN3?=
 =?utf-8?B?QnR6Vm1tZFNyQW1tZGR4U2RkVEtkWXB6a0Y2NHdkNW54N05KajZsanVUM3k5?=
 =?utf-8?B?Z0hNZTEwdU5SY0ZOeUdiWFBZZ25TN3gyMk4vbU5DSjNJR1FaOTlGM2hRcExx?=
 =?utf-8?B?MG9TVStJOWtCMktGNzFXRnR5S1BoRTZFREp5WWhvZDI5djNpL0lXZjZ2MEE3?=
 =?utf-8?B?NFJ1VEpMY2RqVE5yM1VZR0R5bHZFZzllaE95ODM1NUhKM1RncnlUeWRPUkNQ?=
 =?utf-8?B?T0hYZVVqbTF1bWo5TzZYRTJiQ2pJR0F2bk1UTDJqT0dLSk9GaVZHVW9qM01n?=
 =?utf-8?B?K0F2NU1xQVVEeFpLN3pIcmJlc0pkLzh0ZGxPZEVnOFVqRG1tMkh1ZFc5L0dC?=
 =?utf-8?B?aTU1SFB0YVZ4SU1ycy9pVzJuNWI3OE91c0Y1OE00OERpMVBqbmUwc3I1WlFF?=
 =?utf-8?B?SkQyelRTWEs5eHBrRFZlVUVLeGptcHA1L0N1YUsxOHBmSFlyenBUOG12alhJ?=
 =?utf-8?B?Nk5DcXNvTWFLbUtYbkR1WVdpL2d6Q1AxSTI5Zk9WZjVkR25JM3U1UWkwT2Zo?=
 =?utf-8?B?alR2eGFKditQZ0dWMktZeWhyNytBYTZYdmJVK2NVTjBGTjhUdEN4amhDVUpP?=
 =?utf-8?B?S0gyYU5wYUh5c3o0UGJhMEVJR3F6ZlZyamQvYUJNVzd5VTJudzdYeW84NUdz?=
 =?utf-8?B?R01uMzVPWHRzTmVodmVraDZualF3TmpOaFYyaCtIRFR4QU5XR2g2cUYwOC8v?=
 =?utf-8?B?bUU3aUI3aEdkS2V0MVpnK0lVTFJMREV3VVFCRlJVT09kVUNxSDViTks1YkZt?=
 =?utf-8?B?UGpCcTFGRVJMSkE4V3RsaXdYbER3UFNtaGhpL0JEamJtZDBXN09hTitUenlr?=
 =?utf-8?B?UWR6dy9qUWhKdnEwOVUreWI3LzNYcXg5NWQyWFpiVnE1ZVhHOFNzQmpPYWxH?=
 =?utf-8?B?VVBaUHNXZjhueWZ6U2tNMHUrTkZPNE9Zb3ZoSFFOV0RRRUJyRGM3ZTltSmlU?=
 =?utf-8?B?UVJtRDQ4WTZHK09WUlVicFVrd3AzNmREbFV1R1drKzViWFhLUytUbUtUVlVJ?=
 =?utf-8?B?cWxpUzIvL2lJU2t5ODBXRGgzVHl3NFVxQnQvNHNIZ01pRy9PTTA4SGVKbVE1?=
 =?utf-8?B?MUlLTFpyVVBTS3BTeUpWQ1JneXV3di93STlmNEl2R0JBQXRmVFVJSmdjMUho?=
 =?utf-8?B?L3VwT1Z5MlNDM21WcDBKUmZHSHd0aUtLQkhXNkZ0Nmx3eUdjRDV2VGhEV2dQ?=
 =?utf-8?B?SDFTQlJWY2hQVmlveWRjUHJGY2E2NWNLRjFzNXNHZ0pSbWdJUnRPL1ExRXk0?=
 =?utf-8?B?VGxmODBGMDJ2S3kvNzNBNTJDNW9VcXovWWRGOVlHWHpaZnpNRStubHFQT1pK?=
 =?utf-8?B?VEl0dm1XZUtQRWhwQTVkVm9Wbm14bHZ3VVQ3MkJxVERoeHVRS2RHanBrLy9s?=
 =?utf-8?B?ejhJNFM4TUY1SFUwbHBFc1psVSswVjlMempUbDhncXFuYTYvK3ovS1FWc1NT?=
 =?utf-8?B?dzBTakxyclhqVWFKMm1vRjNJUUk3WTVCTVBFQ0pTeTZIOTNiemJsN1NVby9H?=
 =?utf-8?B?QSs3dFNhR0pSZ0VaRkhQbEJsR3pIOHJURk5YbjBDRVhIVUhlK0JwVHozcDZG?=
 =?utf-8?B?ZHhKZ2ExbnBIQ04zaktRakVaVG5OVzU1cjYydDU4aWhva0s4TTJRQ3ZoKzZ5?=
 =?utf-8?Q?Fbs2HB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3psSXdBdTBzRUNrcENzYVBFbEhGTkpCRmVPMEpySUZFNURqck9EU0ZyZGc5?=
 =?utf-8?B?SFdzblhTWDhhT1hCT1RsRzFmOXJ1K1F5UzVxZ2JuM2JhWEo2Z1VSTzRLN2do?=
 =?utf-8?B?dTROVnIyUVRrS3VBVlUxeVM0VHZDWjdmU1luckFwOXhWaDhFeTl5QzBzeGVC?=
 =?utf-8?B?cW5aM3lUUXFaY2puRGNTUE1JMTFHZEZlQUhOM2h1ajJ6OHc4WExYTmtnNHIx?=
 =?utf-8?B?QzlVc2hzY0psdkFKTzRsUmJ0Z0s1aDVTTDh1ZEJmdHVGaVRUL0JGUnh4TUdr?=
 =?utf-8?B?c1B1T2tOWTUrZFZCWW0wVEMzajZsMDI0dzU1LzA3Z1R2R1BqWEVPMVRid0Y2?=
 =?utf-8?B?Tkhpd0xhSk1ROTU3aG9ROTVGQkgweWtKVm5OL0hVVkdadEFJRTZOUCthUE1S?=
 =?utf-8?B?ZGE0NmtrcitpK1ZUTkN4WmdRNTFLUG1abjM1YzRyelcrd0dNVUt4UENvRzZ4?=
 =?utf-8?B?b3lsajR1RExsYzU2ZWxSY3FwMkNwbkgvaVZvMHh0ODZlMkJDQkhVVmN0dTc3?=
 =?utf-8?B?UXZzWVZBUGJOOE1nVUx6MTNUa3B2cGl1a2ZMc2F0bldwQndzdjhXekNGMVVM?=
 =?utf-8?B?TzFPeDNlVWVZdUpFRkFKV2paRGpYZTRObld5Zy8wdE9peEFKT2NPUkNCWmlr?=
 =?utf-8?B?OEEyNWt0ZHRFWTI5aDd0c0E0UmlyOUdTNys5WHl4amxRempyaVJQSFBnTllm?=
 =?utf-8?B?cGRMWUFzbXFiNlBlbHRXdDRtRDBHdklyUmRmTUxLa1Nha1hRQUhRd1BLalhE?=
 =?utf-8?B?WGtsbkQxS2RmYTI5SitFeTJaRVZpbU1uSTQySGNqbFBON2p6WGs5ZXFkS1dG?=
 =?utf-8?B?V1JxZmFVeitTWXNBRXJPOWtJaU9uTmI5RVpjVnRIQ1AzaERlOHZSV1lZNUY0?=
 =?utf-8?B?M3NxTE5uUU02Kzkva0dYYThGUW1WV3Rvcktic0tLZ2pGc3FKTlFUUDRISHJj?=
 =?utf-8?B?ZmsrelZCZkk2RDl2RHh4ekRpaEplODI2eEkrVE1tOEhtaGR4cjRyUEJLSy9R?=
 =?utf-8?B?Q2NHQnhuU2loek8xT0NpMVdPY1g1L2p0VXkwQStCd3ZscmJLYm9zVllTQk1u?=
 =?utf-8?B?TUx3L25MVCtoRkxQbTFkeVN3enNXMG5LdFM3Q2NLVkpTOVIzMjBETDJJZXZ5?=
 =?utf-8?B?MWFBTXg1SGFDY1E3WFZxVTJ2dldRUFF1MXhUSldoQlh5Z1RTeWp1L0xhMDht?=
 =?utf-8?B?cHY5QzZzQUM0N09iWEpiazhWbUtleVZuTHZlMUNWeTR0UWttL2Jxb2EvTnYv?=
 =?utf-8?B?bkdOb1JXK0wwOGZXelZBUmtldFk5cEpPMjE2TnBPcEtMaVhqemY0aWZTdjF6?=
 =?utf-8?B?cUpmRmJIYlFzV2sxNk9waFVRcFlGMFVKdFdhWjRlUFBTRVhvQ3VZeWI5aGVM?=
 =?utf-8?B?dVJCenFvTURFRmhzZXBTM3pGMmgyeFhhSCtKaGVnTXBrV2FNYjR1Rm1FSXBN?=
 =?utf-8?B?aG5OOUJ2TStkYzBVTktnZVNzQm5nK0pHQTh4c0t3UnJyMC96Nzk4R1ZFKzM3?=
 =?utf-8?B?QitWcGZ6QTFlQndJUUFKTTl5WS9rYTdFeFdBQnFKSXVWTEV1RHlGYlRUUzFJ?=
 =?utf-8?B?RVhyU1NnQjRHNUwyZldPTTNUcWJ6L3FWYlZyY2dkbFRXRlhCeDlwQ09NYkxk?=
 =?utf-8?B?NkRUbUMzTTEwMUwzdEVUbUpMZDhFeXRmTWF0WWpiQXNMSHVvaC94YUFMY0ZK?=
 =?utf-8?B?RGNiUXVzSldja3IvZkxUaUxFeUF4aWFOTnRTYk5jYnJiN0pER1NxMUcrUFdi?=
 =?utf-8?B?WUpKRFVjcEpVemRHbWtjNkVCYjZWaUprREMwMHh4K1FIYnYyUHNDeGFmRlo0?=
 =?utf-8?B?Qk5yKzJCWlR0V0xQK2ZLWmR0TkNBNlJiY2VhWDQwT2dCV3QvVTNvQUlpVmpG?=
 =?utf-8?B?eDh6YlZvUGxnYkRlSTlndHBMdnduZWp6K0lvc21JU1kwVUJvckhsZDFqQzh5?=
 =?utf-8?B?QmFkQzlVSUcwWjRXTzJBRkxTelFmRm1xTWp6WndZU2lKQjdNMkVxTlA2Yzhr?=
 =?utf-8?B?ckFxVjYxNmh6VFc1WUR2aC8rR3lLK2ZCS3JQRG5aRWdIZ2VRdlRyM25DV3hh?=
 =?utf-8?B?bTZqS2lQTnBXVWtadjEwSmNtSWNseWVuMWlqdUpXY2lUMEN4WEpzejY2OHVP?=
 =?utf-8?B?TmZQcWEwemxseFQ0R1dobjVzaHBHUGhSZDlxbHp4eU8vc3hHRlp6SXlJQVB4?=
 =?utf-8?Q?qjwXFie7W/x4BPBZoPMtixQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D8E60418A8B194B8044A1CAA5FCDB77@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a25af1-6fd6-447c-5332-08de1d74bb70
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 20:40:33.0778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z48r0ljMKd0sZDw2cJF+hGuwswlIrHxqlnfJ6IndSnRm3cIEoxacmk9YiktimLwTseCahFp+PKwKLSWLtOrUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5124
X-Proofpoint-GUID: 5JC0xbzxYw_EwaqB3LGqwAPb2XT6bxAx
X-Proofpoint-ORIG-GUID: 5JC0xbzxYw_EwaqB3LGqwAPb2XT6bxAx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX8mplMtzuy1F0
 ZFMi6H2YR6mL/6Zj6Ocwkf87hok0KmBYsfwOQqtY+VGCw25Ei3eXjCTyw8llxnzvjcEBDqgSMkG
 Y9J1sy2Q/KMvKRb+2TGniW43JEEsFhYwsW59YVh2yiCOKlhZSbNSCRbtGrAgUSH/M0tevkTGZ2v
 lBRaDyBQNK1az0U2P/MVhvs4QN/kulOXrSY1DFyoZiE/4h+cgZswU3nyQ1Ph8cMdcTaq1/jnjhN
 89cGMAYnN4/UpawydVd6k18/XZcjxVLyq55i/TPm9OcLTbvBJqTS+lGGziQyzKpbCBHYm9SumSb
 Af1hlJuddMOJxsD0dQW0Fyd3udhqodUOAMpt1YNIuvGJMjvrxox1H0GaZgHw12Kp389qx7gKW67
 pCY4gpp4qw9ESjpmwTm1a3mpnIaJ0Q==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690d07c5 cx=c_pps
 a=OtY9ot+kQuHgQW+LdoSONA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=lDRJJpYFbt-PUc39stMA:9
 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

SGVsbG8sDQoNClJ1bm5pbmcgZ2VuZXJpYy8wNzMgZm9yIHRoZSBjYXNlIG9mIEhGUysgZmluaXNo
ZXMgd2l0aCB2b2x1bWUgY29ycnVwdGlvbjoNCg0Kc3VkbyAuL2NoZWNrIGdlbmVyaWMvMDczDQpG
U1RZUCAtLSBoZnNwbHVzDQpQTEFURk9STSAtLSBMaW51eC94ODZfNjQgaGZzcGx1cy10ZXN0aW5n
LTAwMDEgNi4xNy4wLXJjMSsgIzQgU01QIFBSRUVNUFRfRFlOQU1JQw0KV2VkIE9jdCAxIDE1OjAy
OjQ0IFBEVCAyMDI1DQpNS0ZTX09QVElPTlMgLS0gL2Rldi9sb29wNTENCk1PVU5UX09QVElPTlMg
LS0gL2Rldi9sb29wNTEgL21udC9zY3JhdGNoDQoNCmdlbmVyaWMvMDczIF9jaGVja19nZW5lcmlj
X2ZpbGVzeXN0ZW06IGZpbGVzeXN0ZW0gb24gL2Rldi9sb29wNTEgaXMgaW5jb25zaXN0ZW50DQoo
c2VlIFhGU1RFU1RTLTIveGZzdGVzdHMtZGV2L3Jlc3VsdHMvL2dlbmVyaWMvMDczLmZ1bGwgZm9y
IGRldGFpbHMpDQoNClJhbjogZ2VuZXJpYy8wNzMNCkZhaWx1cmVzOiBnZW5lcmljLzA3Mw0KRmFp
bGVkIDEgb2YgMSB0ZXN0cw0KDQpzdWRvIGZzY2suaGZzcGx1cyAtZCAvZGV2L2xvb3A1MQ0KKiog
L2Rldi9sb29wNTENClVzaW5nIGNhY2hlQmxvY2tTaXplPTMySyBjYWNoZVRvdGFsQmxvY2s9MTAy
NCBjYWNoZVNpemU9MzI3NjhLLg0KRXhlY3V0aW5nIGZzY2tfaGZzICh2ZXJzaW9uIDU0MC4xLUxp
bnV4KS4NCioqIENoZWNraW5nIG5vbi1qb3VybmFsZWQgSEZTIFBsdXMgVm9sdW1lLg0KVGhlIHZv
bHVtZSBuYW1lIGlzIHVudGl0bGVkDQoqKiBDaGVja2luZyBleHRlbnRzIG92ZXJmbG93IGZpbGUu
DQoqKiBDaGVja2luZyBjYXRhbG9nIGZpbGUuDQoqKiBDaGVja2luZyBtdWx0aS1saW5rZWQgZmls
ZXMuDQoqKiBDaGVja2luZyBjYXRhbG9nIGhpZXJhcmNoeS4NCkludmFsaWQgZGlyZWN0b3J5IGl0
ZW0gY291bnQNCihJdCBzaG91bGQgYmUgMSBpbnN0ZWFkIG9mIDApDQoqKiBDaGVja2luZyBleHRl
bmRlZCBhdHRyaWJ1dGVzIGZpbGUuDQoqKiBDaGVja2luZyB2b2x1bWUgYml0bWFwLg0KKiogQ2hl
Y2tpbmcgdm9sdW1lIGluZm9ybWF0aW9uLg0KVmVyaWZ5IFN0YXR1czogVklTdGF0ID0gMHgwMDAw
LCBBQlRTdGF0ID0gMHgwMDAwIEVCVFN0YXQgPSAweDAwMDANCkNCVFN0YXQgPSAweDAwMDAgQ2F0
U3RhdCA9IDB4MDAwMDQwMDANCioqIFJlcGFpcmluZyB2b2x1bWUuDQoqKiBSZWNoZWNraW5nIHZv
bHVtZS4NCioqIENoZWNraW5nIG5vbi1qb3VybmFsZWQgSEZTIFBsdXMgVm9sdW1lLg0KVGhlIHZv
bHVtZSBuYW1lIGlzIHVudGl0bGVkDQoqKiBDaGVja2luZyBleHRlbnRzIG92ZXJmbG93IGZpbGUu
DQoqKiBDaGVja2luZyBjYXRhbG9nIGZpbGUuDQoqKiBDaGVja2luZyBtdWx0aS1saW5rZWQgZmls
ZXMuDQoqKiBDaGVja2luZyBjYXRhbG9nIGhpZXJhcmNoeS4NCioqIENoZWNraW5nIGV4dGVuZGVk
IGF0dHJpYnV0ZXMgZmlsZS4NCioqIENoZWNraW5nIHZvbHVtZSBiaXRtYXAuDQoqKiBDaGVja2lu
ZyB2b2x1bWUgaW5mb3JtYXRpb24uDQoqKiBUaGUgdm9sdW1lIHVudGl0bGVkIHdhcyByZXBhaXJl
ZCBzdWNjZXNzZnVsbHkuDQoNCkluaXRpYWxseSwgSSBjb25zaWRlcmVkIHRoYXQgc29tZXRoaW5n
IGlzIHdyb25nIHdpdGggSEZTKyBkcml2ZXIgbG9naWMuIEJ1dA0KYWZ0ZXIgdGVzdGluZyBhbmQg
ZGVidWdnaW5nIHRoZSBpc3N1ZSwgSSBiZWxpZXZlIHRoYXQgSEZTKyBsb2dpYyBpcyBjb3JyZWN0
Lg0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlLCB0aGUgZ2VuZXJpYy8wNzMgaXMgY2hlY2tpbmcgc3Bl
Y2lmaWMgYnRyZnMgcmVsYXRlZCBjYXNlOg0KDQojIFRlc3QgZmlsZSBBIGZzeW5jIGFmdGVyIG1v
dmluZyBvbmUgb3RoZXIgdW5yZWxhdGVkIGZpbGUgQiBiZXR3ZWVuIGRpcmVjdG9yaWVzDQojIGFu
ZCBmc3luY2luZyBCJ3Mgb2xkIHBhcmVudCBkaXJlY3RvcnkgYmVmb3JlIGZzeW5jaW5nIHRoZSBm
aWxlIEEuIENoZWNrIHRoYXQNCiMgYWZ0ZXIgYSBjcmFzaCBhbGwgdGhlIGZpbGUgQSBkYXRhIHdl
IGZzeW5jZWQgaXMgYXZhaWxhYmxlLg0KIw0KIyBUaGlzIHRlc3QgaXMgbW90aXZhdGVkIGJ5IGFu
IGlzc3VlIGRpc2NvdmVyZWQgaW4gYnRyZnMgd2hpY2ggY2F1c2VkIHRoZSBmaWxlDQojIGRhdGEg
dG8gYmUgbG9zdCAoZGVzcGl0ZSBmc3luYyByZXR1cm5pbmcgc3VjY2VzcyB0byB1c2VyIHNwYWNl
KS4gVGhhdCBidHJmcw0KIyBidWcgd2FzIGZpeGVkIGJ5IHRoZSBmb2xsb3dpbmcgbGludXgga2Vy
bmVsIHBhdGNoOg0KIw0KIyAgIEJ0cmZzOiBmaXggZGF0YSBsb3NzIGluIHRoZSBmYXN0IGZzeW5j
IHBhdGgNCg0KVGhlIHRlc3QgaXMgZG9pbmcgdGhlc2Ugc3RlcHMgb24gZmluYWwgcGhhc2U6DQoN
Cm12ICRTQ1JBVENIX01OVC90ZXN0ZGlyXzEvYmFyICRTQ1JBVENIX01OVC90ZXN0ZGlyXzIvYmFy
DQokWEZTX0lPX1BST0cgLWMgImZzeW5jIiAkU0NSQVRDSF9NTlQvdGVzdGRpcl8xDQokWEZTX0lP
X1BST0cgLWMgImZzeW5jIiAkU0NSQVRDSF9NTlQvZm9vDQoNClNvLCB3ZSBtb3ZlIGZpbGUgYmFy
IGZyb20gdGVzdGRpcl8xIGludG8gdGVzdGRpcl8yIGZvbGRlci4gSXQgbWVhbnMgdGhhdCBIRlMr
DQpsb2dpYyBkZWNyZW1lbnRzIHRoZSBudW1iZXIgb2YgZW50cmllcyBpbiB0ZXN0ZGlyXzEgYW5k
IGluY3JlbWVudHMgbnVtYmVyIG9mDQplbnRyaWVzIGluIHRlc3RkaXJfMi4gRmluYWxseSwgd2Ug
ZG8gZnN5bmMgb25seSBmb3IgdGVzdGRpcl8xIGFuZCBmb28gYnV0IG5vdA0KZm9yIHRlc3RkaXJf
Mi4gQXMgYSByZXN1bHQsIHRoaXMgaXMgdGhlIHJlYXNvbiB3aHkgZnNjay5oZnNwbHVzIGRldGVj
dHMgdGhlDQp2b2x1bWUgY29ycnVwdGlvbiBhZnRlcndhcmRzLiBBcyBmYXIgYXMgSSBjYW4gc2Vl
LCB0aGUgSEZTKyBkcml2ZXIgYmVoYXZpb3IgaXMNCmNvbXBsZXRlbHkgY29ycmVjdCBhbmQgbm90
aGluZyBuZWVkcyB0byBiZSBkb25lIGZvciBmaXhpbmcgaW4gSEZTKyBsb2dpYyBoZXJlLg0KDQpC
dXQgd2hhdCBjb3VsZCBiZSB0aGUgcHJvcGVyIHNvbHV0aW9uPyBTaG91bGQgZ2VuZXJpYy8wNzMg
YmUgZXhjbHVkZWQgZnJvbQ0KSEZTL0hGUysgeGZzdGVzdHMgcnVuPyBPciwgbWF5YmUsIGdlbmVy
aWMvMDczIG5lZWRzIHRvIGJlIGJ0cmZzIHNwZWNpZmljPyBBbSBJDQptaXNzaW5nIHNvbWV0aGlu
ZyBoZXJlPw0KDQpUaGFua3MsDQpTbGF2YS4NCg==

