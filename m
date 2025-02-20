Return-Path: <linux-fsdevel+bounces-42143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7DA3D156
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 07:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F443B36AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 06:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A871DFE20;
	Thu, 20 Feb 2025 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="OYz5tuIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E701632DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032513; cv=fail; b=vBe7ygPGFG6UMVBOSHPKJ0XnWpgsfcBY37j578ujD9HLGEpHW3WY5+Qgv2WsnETLGwgHKBDvkPr5FiBaqHEPZH3qUlY0rfSEhDoSwaZnDYrvm9w+srjyW3m4BNHPbsU7GNtDEBhLAxlL4y0hTUEZSSx5rq6SfiGQSUxrSrxctLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032513; c=relaxed/simple;
	bh=TMLdnRALm7KunhM5/ypENw34IbdywnzYqy7sK72Pkoo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XtJ19A+sw579evsBv04K2/QntEs87MWoWtrToTt0f39xtYNZUyn2yETS02tzAkJ2HzbAJwcUbkg6Un3q7dc93lPK9Rw5iFUOHnzbwTjAHOHeq4FFF+D9zw2w1EjhYI2LocoAuNqoBxs6Rsutys6S0Tmd+P/7MeoqQTYgYSUFsRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=OYz5tuIK; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5a9t8003723;
	Thu, 20 Feb 2025 06:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=TMLdnRALm7KunhM5/ypENw34Ibdyw
	nzYqy7sK72Pkoo=; b=OYz5tuIKKtIaMZB63Wslui7wfLsIVHstouBcMwOxE585x
	Okt8QK2bRHoWbbvA6NgrxiXEfnrr4pZtkmNqzxae16kTOPp8RDLlD6CxEV1k8ZgD
	3ZldRPLX4vOQsCrblf9kQ6lWDF/YinFxPU+f8OrPquboLJu1zwIMy/+CrY1jTeGL
	nCqW8+DQE4Y2AWR9W7USwz4ghqBVc5O9LLC0D/uhKefbNs0ra/9XjqPmqi21JsgZ
	+/cHMUkJlX+EGFnbMnmrSFGm9j0XrarRRtcwzjL1FcMEX6obYpgaT9cjLV8lsOZV
	cbjxB9BqjCb+idDRV2KVo2iTwSq3mDPGy6MR2hNig==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2104.outbound.protection.outlook.com [104.47.26.104])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44vyyk1fkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 06:21:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyUj6p6papOMjJgotXMRoEUPaL0vXAmZfTzUqI+5vac8vyqk8s9xbLvt1XRT+L4qrCbTqOh7uvEFzGMrVbcAVOGbzVwgc2g5G43MMZDRsjfbluSXEMxpUgyMTS6FWTydPqN0PkQRsZFKN3h2bQjI0JJ4jtK7f4m54Vp5HxtwfponMDdmB/4v1tKhrN0oDDOpkKE86VsO3sGpm1X3CoPbACuzKNL3dIGH9RqUo9zEVxkJFkBlZbNuNxnDV3aoBJrTnYfeMMYEYJougeK+cRQfTlohZsvAldxSYCjBbM25KsOtib2vc2f6yd32L2RjJlXBAnfCZcN54aXMHMmnix4AQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMLdnRALm7KunhM5/ypENw34IbdywnzYqy7sK72Pkoo=;
 b=lDtlrBXc28NcyU63MleHRpEsV2+0aG2iAxz+XCdkoO/Aw/hPL0pXLH1VvectbvTQNbZMkDS7z08Jb+VhJftCKUXEghoipuLcuaLF9RK7r4AQX5VAUsx2XHNU2JdcKUnRPJ2E8ZJYAROdXET9Bd4CrSAPINx+4FgeGPyRxusUXLbkvoZ7jgVvLhF1AWrvAMDrY4/0DhEkCV0EtF/g9DDlj1hkZ/QFpQIeiyWJWloZaB80PH3+Ml0QeQ3RYGWmnOSHEw+7lCtg/BW0F3fkOnlLSd411sITZzGVEqdKLbvUHOuUQbGtduKlv+OXkQUjZvIvTWKFhRQFe5wL67iEm2uGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6782.apcprd04.prod.outlook.com (2603:1096:820:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 06:21:25 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 06:21:24 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: support batch discard of clusters when freeing
 clusters
Thread-Topic: [PATCH v1] exfat: support batch discard of clusters when freeing
 clusters
Thread-Index: AduDXeUlpyGxMJJzQEyYkRvhiBs3Ng==
Date: Thu, 20 Feb 2025 06:21:24 +0000
Message-ID:
 <PUZPR04MB63166087C78BBC8ECA38B0EC81C42@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6782:EE_
x-ms-office365-filtering-correlation-id: 83c0500d-46c6-49d3-2296-08dd5176cd3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHg5dFBmeGpKOExyK2JzTTBWVGl2UkJrVm84QWZUc2E0V09DK2NRbTgwVCt2?=
 =?utf-8?B?Ull4enNzVm1LME4wYkllVEJKblo2SGZMUENMRW5jNU03cXhET3ZBcmMvUTM1?=
 =?utf-8?B?ckJTZHJYSEdXdzNRamJUNTRZbWIxdzZrbm5KRXlUcmhJM09yUjJ4N3kwZmVN?=
 =?utf-8?B?Tmg2SndMS2tubENWbjJTOHBZblhGcDB0cnllcFNocm1yZWdxanhSM1pBSWFE?=
 =?utf-8?B?QlVJbW1IcHVkYlZFMzk5SlZFSjhUUXU0M2VoVGx5RWtXSTZoQkFMN1ZTS3Ix?=
 =?utf-8?B?K2pNUUsxa2VRV0hnQjR5UnJuN3FnMThGRFpwZkl0TEw4MC9PNkxQT1BESS9R?=
 =?utf-8?B?azlkR2RlR2trR0RuTFJRT0c5OFczUlhHd3AvTnhvMzdKSytOVTI0YS8xUndI?=
 =?utf-8?B?Z21hRFhMWi9lakdxMzRpdWtoRDE3VzNua3hlU0hpSVJqaStpaWdET3ZEdDBM?=
 =?utf-8?B?UnRuL0tUcFNSS1BLVWVTOVZyRDJ4dzkwTjNFN25OR1loN0QwdlZWR0pzWlV5?=
 =?utf-8?B?ZDBoSEt5RDZOSUYvaVlwckw0T3RyV09KSEdNSGVhR3ZjSHlONG9DcFVVcmM4?=
 =?utf-8?B?c2w1SEEvZTNLQzJTaTgvR200Y0lqaEZlZEIwd2p4Z0VkalJ5bzgya3RpTVBp?=
 =?utf-8?B?QlUrL2pjS3hpUUVuNnlTOWFOanNmaXpybkZlSnFaZ3QrMnByK1BaR3FZTFNk?=
 =?utf-8?B?MTFzdWxwZ2VZd2o3LzBYS25CblZWNTF4NWpqSWhmVitwenhWblM5TzlTTjhF?=
 =?utf-8?B?U1E2OUVhb1dIOVJzVTd6VnVYUXB1UVJ3SXBhN0QrTm9oS2pRUGJqd1dqbnU4?=
 =?utf-8?B?azlwZlNXbHV4OGptNFpRYkNFL3ZMWkVyd3JWK2xBbndkbFkxVVVnOWdQMytU?=
 =?utf-8?B?NDJWRG9CZzRib21xckRrbkJKajdGS1FPQVNJQTBPOXZsWnFGeDhsNzl0TDF3?=
 =?utf-8?B?R1RXSU1QbU9LMEhNbW9uUW9LWHFaek1lckZTdVBWakVZejQrQlhiNDhJbkYr?=
 =?utf-8?B?Qlh2d0M5MnJEUFJqUEZXbFViMURta3VFZXhrY3N3Yk5UQ1RGRjg5UHhaYTQz?=
 =?utf-8?B?ckk4cy9UMVZnNjhTZ0tjaW5TeWpNV2lRb3VJL0p0aHJRVFk2WnRYSTJFZXRn?=
 =?utf-8?B?N3Z3bWg1bWRTTTNmY0FuRVU3Qzk2NGR6cGlITTlWNTZ5dFlZSWRLYjBSc2ph?=
 =?utf-8?B?dUNtNEZLNDlqa2ozOUVGMnRrbWxoMVZOeWZWZzdKSWdzcGd5NFBKclJ3aVZ4?=
 =?utf-8?B?bHlPUWxBd2pidFpKRSs3RHI3ZFgwcFpEV0lEWDdja2NDNGJzSHU1RlVOVVVT?=
 =?utf-8?B?VGZubVhlRTdLY2I4N2NObjNGZitVNjlZUjdJNFk1ODZkODFRdXJWVnpaZ010?=
 =?utf-8?B?N0VwTWwyTXBRVFZVaUtqclN6NjNmdjIyUnBGV3lpUWZpTUFXZXhsaWgzckpV?=
 =?utf-8?B?VVNpTUtWMTZ0MW1LV01VM2xyMUpuT2JVbldrSHVIWHZNQ2ZteHE4bjBlM0Zk?=
 =?utf-8?B?emxCa0FZZWgvVDNxTzRIVzBCSjNRdi8vL0hTRm8vVHkzMEwrbURtajhiSms3?=
 =?utf-8?B?VThqalpCN3hFY2g5TzRRRGRFOWJlanlpRzJIcUhUeXdpbDV0MWIxbXg1VnNm?=
 =?utf-8?B?QURVaEdad2QyY2FRUWJVUmZqNWRYUEZsNXFtMjU5TWNDUFdIWWRZbUFhTFVh?=
 =?utf-8?B?aGtld3FpaENueDVhQ2Y0ZFZSazlZYUdWQ0FYa3hzTVl0ZTRiUlhRcHVPeEph?=
 =?utf-8?B?Ky9WS1k5OWVic0JIYkhiU3NmRmsrUXhzeitybmNwclBmYzU2d3RNcU5LMHlv?=
 =?utf-8?B?U1N3SzFYUVIwWTZZQnlBeDVYaWxKVVhmUTRYT1dPRUpYVDY2TFE2d1NUYUNn?=
 =?utf-8?B?a1NSQXFaK3hHNjdPaGFhVWZlU1J0RHhVTUptSFV4ZDA3Nm5uUFUyUXlCZVJ4?=
 =?utf-8?Q?FKp337hFjeF8FwiecVPgg0XDp7K7t3Gh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnBTaDdRY0FrQkw5VDVlcEdVblpHSWFjU1JTNVVvbThTZmhMZmNXc2Rlc05X?=
 =?utf-8?B?MEJKY3p1cGh5MXdQUHZrUVN1RWJnUUZZaktHcTJyUU9WaExlbElGWXh6ZUZV?=
 =?utf-8?B?UkZDVGNrNUdaWVVtdFdjSHRRT2xlaWR5dkk0UW45dE9oenBoN2s4WDVLblNZ?=
 =?utf-8?B?TFZhK1h4R1BVL0lxWTMyTmpYSkJsQ01DZloyNU0vb0tyNjFCcFJNdVBSY0t4?=
 =?utf-8?B?dDNoQUZadjVBNWppYkVkZ25hZURleCtaR0tadVNOQnJvRmdoL0NGalRYMEhL?=
 =?utf-8?B?R3B3UTRPVlJ0alhrNStRbXRabDFtSStGVGtMRWdLUlgvRThzTGtla2c4YjVU?=
 =?utf-8?B?bkExeWtYeVVvbmc1UUd2clhOd1BiV0NhYVZOT3AyYVZ2QlkzVWg2Qit0bjdz?=
 =?utf-8?B?ZDJVdFdsbktoMWFvWGxnWXNEaFpQYVFJamR1UHNFSmN1UUFWa1N1bjlGK0NO?=
 =?utf-8?B?YnNPbzZtUzRQOHBQOUtCVHRLcDM3UUx3aEE4YnExbEZmTWJWTDNreENtcFVv?=
 =?utf-8?B?OEpPK2tuWjVNK3FJM0V6SjJVRWJkVk4waDZQSWliMlF1aGcvZktmQTVNS2Iy?=
 =?utf-8?B?b28vTE9MQ1hRYWpJYW83bDNocXJEaFVjZXJ2YVlGYWtjTzdGRjVoZlhhSGE3?=
 =?utf-8?B?OW9pWDloTlRRNGtLRFlYOVQzYU1mOUwvaEpVY1Q0WXE2YXhkTmtzY09tQlZu?=
 =?utf-8?B?bEpJQmtWeVN1T1FXZFgySjNnWWYrdS8xRFdscEQrMHRtbERpZEZXZU1pVVU0?=
 =?utf-8?B?ZUpoTWFtSFZLZVN6MUU2L2VWL0pRYitmakJmQnRRMWJKZUplRnp5bDZ1M0VJ?=
 =?utf-8?B?S0d2eTQ0S2x6TmxDL29WZlQ3Z0M3azcweEkvNmtYc2ROOEZNQkxFSk9YUlN4?=
 =?utf-8?B?aVVWdmhkZEZydzY4S3dxWU9QQ3lwMHYwQ0lwd3hoa3JYbGF6a2huKzlDZzVh?=
 =?utf-8?B?QlNBejZpdXUwajh0dEtyRTdWeHA4QUl0MEJwWTZOY2ovbXA3RXVKWFRDemJB?=
 =?utf-8?B?VHJzOFhEQmtkK3JRVS9WM2Z2Z2FhTzJOOTRTNEtmUEpyQllhOVNTR1lSMUR1?=
 =?utf-8?B?WXVUenZpN2xvRkVWb3ZZd2NVSDFnSk1yNllvRWRNcm9OZFRFeEc0QXd6a3JV?=
 =?utf-8?B?VmV0ckJ4d3FJZkRTdG9kSDhQbWg3Q0QzTGR4c3hQaDlxd2pGNFhDaS9RVUhn?=
 =?utf-8?B?ckdkaldqVWZHMEVVNWpOMzJlcmM0cWRiRVU1a04yemt3RlRlckFnOSt2S3dS?=
 =?utf-8?B?dEdHTmRUZGpmU3JBa0xmUnhqa05ueTM1Nng2dGR6aTZ3M3F6cFdLcS9QR2Iw?=
 =?utf-8?B?S0FaQmtzeURtYjNVNHlXNVhSNHlGUXBnOHNNVklRdEIvbXRnSFJrZkJBQlhr?=
 =?utf-8?B?S0JnZHBvbWxSd3Vid21DdXU2VHJYajBmNzVwa0NROGxBa2FBMkJ6RlhYRzZy?=
 =?utf-8?B?UjVJb2JpUHlRVXY1cEJ3OWxlSUp4L3gzR1V1dnJlSXhBTG4zTzNXRWRWNGZu?=
 =?utf-8?B?S3V3YW1PQTFMbnRXQ0tpRGIrOGxVQTVYZldteGUyWDh5K0ZXTklCeisyWkZu?=
 =?utf-8?B?d1hMVlU0VmJ5czkwZzl6NkFnV29Sbk0zdGdKVWRxQ25GbXNNZm5FMDJGd2R0?=
 =?utf-8?B?elJVTFZsTnJldjdnTkxsUVhQcERQOFRsbkVQRHhwbHNPVmQrQk9SQVB2VlA2?=
 =?utf-8?B?ZW8ySlgrOFkzY2swR1hGSkwxS1g5V1ZZWStBWjhVZjJCSE5aVWdlK040OGpR?=
 =?utf-8?B?Q0dodTVtL2J0UVdwekE3UWdBVFpmZHI1d2pZV05LZGhIeHM2T3dOV2UvWWhQ?=
 =?utf-8?B?YmhjdDAwdDdHWi9BQXZFVlFJY0ltU1VTTVdPQkFEMFI0UWJlLzZqRTdWVGpK?=
 =?utf-8?B?NXZFMmhqdXRWQ2pGeVJaNGpKRElzcnFRTUkyQUdsaW1QK29hVUxFWk9kbTh3?=
 =?utf-8?B?RGFLdmhZSld1YlAxR0NZUU9TNnpOSmJqaFpSbjJmRkFraW1iaGhoZUFaenlU?=
 =?utf-8?B?ZXFjNW1qOUNSbUQyVlhZQnMxUVExM0N5VzRtS3kvV2dPUW5WWVBJZ2pNMm1Y?=
 =?utf-8?B?ZDlwM0ZFUUVETzlFQ2lmL0NSZW43eStnQWExd2tjN1VJekx5N0RDZ1ZMY2x2?=
 =?utf-8?Q?jiAs=3D?=
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
	6xHGVVb9QOMZs3i/uT1LJ3UJw1zMzuzJa08sCxfCRvnqvnl3ZA48PTljTdtpgH6S++p6xFGBus4dixO46JkPqNVItFYNmccn5C62+zEkhZ6KtRxORX8OqtOA/BvT1oJHch6cMaFPY2KOveCn1Peg0/mjanVdYc/XV4Il0+LjShASWmfHlsjguADvpWntRpRi8vp5ttanUI2EbccMtpjKtIgXezPz9uz2Prn1U56a3CqkWVLV2N0rSFu8bZmN+V2/DZLUTXW4eUh65vF8KNl8HGyPjs9DaNaqSfdy/rsQUHTA8J1TNMi7hqOZgLMZGodpSYH+TY2Kcf4bGRcBQYkUcIvfC42L2vvZo//BWauQI2MyOvBAzBwjwEE5IiQuuEVwclrd2k/12FNFu9ryVPXml++nM5twn89mm5dXSMy1encz++Jn80UbKelUw2+lpdJ/Zc6pVeth0CZ8hRqvs//UikGfnVCxD0/AePMGHKUtvQwMp+0zrP74zF+k3yZmkgDCt0DoFFWA7ODDJsiyTOwLX22sDPvtPLWx7nEMUHBvPcZOFHat4zb6Xz9HxGYzbxIk4EfkQc68GNZWNGxM3MVMWmhsLxa9UV2NohSYpD5pZ4+kNH2MXD6KfqVuxlBqdcYd
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c0500d-46c6-49d3-2296-08dd5176cd3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 06:21:24.7221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehs1Dq+GL7aq3LPeluw6ODMARdCaehyoMTnm06SN8iBDsiNAE9fSMwk+gYUZcGnM2pGjq7i5lgguVj7lNA2kCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6782
X-Proofpoint-ORIG-GUID: lZpTa4W9yfNMPnAL1gPiDRfq3z-CA94_
X-Proofpoint-GUID: lZpTa4W9yfNMPnAL1gPiDRfq3z-CA94_
X-Sony-Outbound-GUID: lZpTa4W9yfNMPnAL1gPiDRfq3z-CA94_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_02,2025-02-20_02,2024-11-22_01

SWYgdGhlIGRpc2NhcmQgbW91bnQgb3B0aW9uIGlzIGVuYWJsZWQsIHRoZSBmaWxlJ3MgY2x1c3Rl
cnMgYXJlDQpkaXNjYXJkZWQgd2hlbiB0aGUgY2x1c3RlcnMgYXJlIGZyZWVkLiBEaXNjYXJkaW5n
IGNsdXN0ZXJzIG9uZSBieQ0Kb25lIHdpbGwgc2lnbmlmaWNhbnRseSByZWR1Y2UgcGVyZm9ybWFu
Y2UuIFBvb3IgcGVyZm9ybWFuY2UgbWF5DQpjYXVzZSBzb2Z0IGxvY2t1cCB3aGVuIGxvdHMgb2Yg
Y2x1c3RlcnMgYXJlIGZyZWVkLg0KDQpUaGlzIGNvbW1pdCBpbXByb3ZlcyBwZXJmb3JtYW5jZSBi
eSBkaXNjYXJkaW5nIGNvbnRpZ3VvdXMgY2x1c3RlcnMNCmluIGJhdGNoZXMuDQoNCk1lYXN1cmUg
dGhlIHBlcmZvcm1hbmNlIGJ5Og0KDQogICMgdHJ1bmNhdGUgLXMgODBHIC9tbnQvZmlsZQ0KICAj
IHRpbWUgcm0gL21udC9maWxlDQoNCldpdGhvdXQgdGhpcyBjb21taXQ6DQoNCiAgcmVhbCAgICA0
bTQ2LjE4M3MNCiAgdXNlciAgICAwbTAuMDAwcw0KICBzeXMgICAgIDBtMTIuODYzcw0KDQpXaXRo
IHRoaXMgY29tbWl0Og0KDQogIHJlYWwgICAgMG0xLjY2MXMNCiAgdXNlciAgICAwbTAuMDAwcw0K
ICBzeXMgICAgIDBtMC4wMTdzDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFu
Zy5Nb0Bzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2JhbGxvYy5jIHwgMTQgLS0tLS0tLS0tLS0t
LS0NCiBmcy9leGZhdC9mYXRlbnQuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQogMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2JhbGxvYy5jIGIvZnMvZXhmYXQvYmFsbG9jLmMNCmluZGV4
IDlmZjgyNWYxNTAyZC4uY2MwMTU1NmM5ZDliIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvYmFsbG9j
LmMNCisrKyBiL2ZzL2V4ZmF0L2JhbGxvYy5jDQpAQCAtMTQ3LDcgKzE0Nyw2IEBAIGludCBleGZh
dF9jbGVhcl9iaXRtYXAoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IGNsdSwgYm9v
bCBzeW5jKQ0KIAl1bnNpZ25lZCBpbnQgZW50X2lkeDsNCiAJc3RydWN0IHN1cGVyX2Jsb2NrICpz
YiA9IGlub2RlLT5pX3NiOw0KIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRfU0Io
c2IpOw0KLQlzdHJ1Y3QgZXhmYXRfbW91bnRfb3B0aW9ucyAqb3B0cyA9ICZzYmktPm9wdGlvbnM7
DQogDQogCWlmICghaXNfdmFsaWRfY2x1c3RlcihzYmksIGNsdSkpDQogCQlyZXR1cm4gLUVJTzsN
CkBAIC0xNjMsMTkgKzE2Miw2IEBAIGludCBleGZhdF9jbGVhcl9iaXRtYXAoc3RydWN0IGlub2Rl
ICppbm9kZSwgdW5zaWduZWQgaW50IGNsdSwgYm9vbCBzeW5jKQ0KIA0KIAlleGZhdF91cGRhdGVf
Ymgoc2JpLT52b2xfYW1hcFtpXSwgc3luYyk7DQogDQotCWlmIChvcHRzLT5kaXNjYXJkKSB7DQot
CQlpbnQgcmV0X2Rpc2NhcmQ7DQotDQotCQlyZXRfZGlzY2FyZCA9IHNiX2lzc3VlX2Rpc2NhcmQo
c2IsDQotCQkJZXhmYXRfY2x1c3Rlcl90b19zZWN0b3Ioc2JpLCBjbHUpLA0KLQkJCSgxIDw8IHNi
aS0+c2VjdF9wZXJfY2x1c19iaXRzKSwgR0ZQX05PRlMsIDApOw0KLQ0KLQkJaWYgKHJldF9kaXNj
YXJkID09IC1FT1BOT1RTVVBQKSB7DQotCQkJZXhmYXRfZXJyKHNiLCAiZGlzY2FyZCBub3Qgc3Vw
cG9ydGVkIGJ5IGRldmljZSwgZGlzYWJsaW5nIik7DQotCQkJb3B0cy0+ZGlzY2FyZCA9IDA7DQot
CQl9DQotCX0NCi0NCiAJcmV0dXJuIDA7DQogfQ0KIA0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Zh
dGVudC5jIGIvZnMvZXhmYXQvZmF0ZW50LmMNCmluZGV4IDZmMzY1MWM2Y2E5MS4uYjk0NzNhNjlm
MTA0IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZmF0ZW50LmMNCisrKyBiL2ZzL2V4ZmF0L2ZhdGVu
dC5jDQpAQCAtMTQ0LDYgKzE0NCwyMCBAQCBpbnQgZXhmYXRfY2hhaW5fY29udF9jbHVzdGVyKHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIGludCBjaGFpbiwNCiAJcmV0dXJuIDA7DQog
fQ0KIA0KK3N0YXRpYyBpbmxpbmUgdm9pZCBleGZhdF9kaXNjYXJkX2NsdXN0ZXIoc3RydWN0IHN1
cGVyX2Jsb2NrICpzYiwNCisJCXVuc2lnbmVkIGludCBjbHUsIHVuc2lnbmVkIGludCBudW1fY2x1
c3RlcnMpDQorew0KKwlpbnQgcmV0Ow0KKwlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhG
QVRfU0Ioc2IpOw0KKw0KKwlyZXQgPSBzYl9pc3N1ZV9kaXNjYXJkKHNiLCBleGZhdF9jbHVzdGVy
X3RvX3NlY3RvcihzYmksIGNsdSksDQorCQkJc2JpLT5zZWN0X3Blcl9jbHVzICogbnVtX2NsdXN0
ZXJzLCBHRlBfTk9GUywgMCk7DQorCWlmIChyZXQgPT0gLUVPUE5PVFNVUFApIHsNCisJCWV4ZmF0
X2VycihzYiwgImRpc2NhcmQgbm90IHN1cHBvcnRlZCBieSBkZXZpY2UsIGRpc2FibGluZyIpOw0K
KwkJc2JpLT5vcHRpb25zLmRpc2NhcmQgPSAwOw0KKwl9DQorfQ0KKw0KIC8qIFRoaXMgZnVuY3Rp
b24gbXVzdCBiZSBjYWxsZWQgd2l0aCBiaXRtYXBfbG9jayBoZWxkICovDQogc3RhdGljIGludCBf
X2V4ZmF0X2ZyZWVfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hh
aW4gKnBfY2hhaW4pDQogew0KQEAgLTE5Niw3ICsyMTAsMTIgQEAgc3RhdGljIGludCBfX2V4ZmF0
X2ZyZWVfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBf
Y2hhaW4NCiAJCQljbHUrKzsNCiAJCQludW1fY2x1c3RlcnMrKzsNCiAJCX0gd2hpbGUgKG51bV9j
bHVzdGVycyA8IHBfY2hhaW4tPnNpemUpOw0KKw0KKwkJaWYgKHNiaS0+b3B0aW9ucy5kaXNjYXJk
KQ0KKwkJCWV4ZmF0X2Rpc2NhcmRfY2x1c3RlcihzYiwgcF9jaGFpbi0+ZGlyLCBwX2NoYWluLT5z
aXplKTsNCiAJfSBlbHNlIHsNCisJCXVuc2lnbmVkIGludCBucl9jbHUgPSAxOw0KKw0KIAkJZG8g
ew0KIAkJCWJvb2wgc3luYyA9IGZhbHNlOw0KIAkJCXVuc2lnbmVkIGludCBuX2NsdSA9IGNsdTsN
CkBAIC0yMTUsNiArMjM0LDE2IEBAIHN0YXRpYyBpbnQgX19leGZhdF9mcmVlX2NsdXN0ZXIoc3Ry
dWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2NoYWluDQogDQogCQkJaWYg
KGV4ZmF0X2NsZWFyX2JpdG1hcChpbm9kZSwgY2x1LCAoc3luYyAmJiBJU19ESVJTWU5DKGlub2Rl
KSkpKQ0KIAkJCQlicmVhazsNCisNCisJCQlpZiAoc2JpLT5vcHRpb25zLmRpc2NhcmQpIHsNCisJ
CQkJaWYgKG5fY2x1ID09IGNsdSArIDEpDQorCQkJCQlucl9jbHUrKzsNCisJCQkJZWxzZSB7DQor
CQkJCQlleGZhdF9kaXNjYXJkX2NsdXN0ZXIoc2IsIGNsdSAtIG5yX2NsdSArIDEsIG5yX2NsdSk7
DQorCQkJCQlucl9jbHUgPSAxOw0KKwkJCQl9DQorCQkJfQ0KKw0KIAkJCWNsdSA9IG5fY2x1Ow0K
IAkJCW51bV9jbHVzdGVycysrOw0KIA0KLS0gDQoyLjQzLjANCg0K

