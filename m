Return-Path: <linux-fsdevel+bounces-35058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340349D07EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 03:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97181F214DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F72F855;
	Mon, 18 Nov 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NNcwgf86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE11EEF9
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731897626; cv=fail; b=RdKXcU+Z/cT6tIGm34Z8uL65zBQpBc2bwYJ9A2VgT8y12X4xj/9GvI+44YzT1cIQ54aqNccZG9A7uWt29ISC4fOtRtb4AfYKjf3aeW7AXtYMJEOcX4qGLpw9asBE3F45WKMkTu5L/KjoH1g/oC+CBndPHkcAvGHYZ97Sb9rR6u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731897626; c=relaxed/simple;
	bh=NivdX8AtRVA6JNFvv/TVGM9USOTDI0TcVF/YlAo3/Gs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R0tVhQQbFbLX99qvMSNdRveneeLMKOfZeUVBaQClr2iSwI0GyhyJWzrTSPqeZ96PuaTwRr1n38kmUKJqG5XeUar06mmpCnvsHe8jkDI+oAbauLuje39HeM2e8/kK3ScqMHmKfugxk5crYYTlAOR/LS1pxXWHBnOYtGP+EqLGUoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=NNcwgf86; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI090Zf023366;
	Mon, 18 Nov 2024 02:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=NivdX8AtRVA6JNFvv/TVGM9USOTDI
	0TcVF/YlAo3/Gs=; b=NNcwgf86MZ7nXY2WPZmRpEAhHcE+BbSllV5CgtXeobSyL
	1cs5Evb1/0CTfUAjW/nc163ztJKRXApi6AOxH5JGNgsTY5iRdF9upsxZ05cNF5Ag
	Lkzm/MS5bg03Y5QfAYW5eZz8RdwBU/lZgcDRJqAKyZRbdDaOwYXfhiTKFxQ0pcSy
	kc4BjtBmOhqotCbM+raNpG6qZMJHJPanRCXDPCpPMZEcgeH4ty6wkpy/IvyQr3yn
	fYs/iiMwZA7rBR3u4Oin9Bwe/pcDdJT+Nz9kOJuywL7APwMufJle5zmzvtbI3ZN/
	zictzPOk/Zxq7zpNHEYrqbsJLNM07etr/ljWWiiNA==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2042.outbound.protection.outlook.com [104.47.26.42])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42xm7xgxg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 02:01:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptk1iYjQM28YEjlxMNtM9M31W89DN97kktpl3iATq0LO8PFexmt8ggR9k4aSoVxpdmnl2mL3qCOA3S9qRBwVb+jyUm5v4uhHoFuCn4JAWlHzA5I0rdeQjb95r09kKHSWpIFWSo7cdPpHpuODdAk38HSABZTxzB8IygCfB8URgd0qPO1ehVhnN9mUTOedUheVr579dCoMf8gK9okHaKNoMKlDnhq5GbaXXxfG9QVvpzN/Bo/TZXEHjTfTzfy61KzPo+4H0UsdOUzCEVL9iFrwaYzDdGbtxQghuJgUMzkb2nXilj5JFO7mE1LNxS8WPA4pLB9TRTx75I1IBwlqNVO4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NivdX8AtRVA6JNFvv/TVGM9USOTDI0TcVF/YlAo3/Gs=;
 b=ZzGzKMsZPl/3s2EegJLXqWouABQJl812k1qoyA8p/2IRtBo0RJlzpEZKZYXxuTiUwvhkBthzufZvwGTICrYKKsIKweEi3crKAcfMlmP/uo+VaEpj4S4HKrXU4SEE/MNy9qk1NN39dGcABP2NhqPU+PmFWG0Mh71XK1I8QaxFXItmVEQ6s9zhF6OyQRKo+XzsjVBdUFjOc+SCG2q2k837+09OxClGwukNYADZ5wWEyGAkfBrRllkRs5nQu9m/xMriVqoC2t1vpI9Mu6LJxoJBvwe3rTM2CzCs/K8PUwH6wTomIhEWYWYz1jZJI5OscpfLGv0COVbQrjdk7Lhi9vMS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6119.apcprd04.prod.outlook.com (2603:1096:400:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 02:01:37 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8158.013; Mon, 18 Nov 2024
 02:01:36 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3 1/7] exfat: remove unnecessary read entry in
 __exfat_rename()
Thread-Topic: [PATCH v3 1/7] exfat: remove unnecessary read entry in
 __exfat_rename()
Thread-Index: AdrpZcjCRKtT0hm3SA+WwfLpTFDiWBP9lkEg
Date: Mon, 18 Nov 2024 02:01:36 +0000
Message-ID:
 <PUZPR04MB6316C3ABF6A986238159982C81272@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6119:EE_
x-ms-office365-filtering-correlation-id: 97a4eefc-f213-46aa-257d-08dd0774ef50
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?djVWNnhXVlNrV2I4OUNkTzBaekNWWkY1RTVURmJsenNQL2drWmdiM1QxWkFK?=
 =?utf-8?B?cjJPRFM4c0daZUlJSm9mM0pvbnhlL3V6R1IwQUVsS0hGci9HK0p4eTh6TmRy?=
 =?utf-8?B?R25Pd0Fud3JFUDJnV1dGQkFNQmpFNHBTTTlrZHVsbzhXWHdCTER2aWU5RGR0?=
 =?utf-8?B?OGhEWVFOMDd4MVJRNU5MT0hHT3FBVktvSklaUFZaa1p5T1JuTEM4ODNSU1pV?=
 =?utf-8?B?TncwbEx2Q2V5RE8wNTNQRXZYRlF0dzdVK0RXK3JxOEFKTlR0eXZPaENvUUls?=
 =?utf-8?B?LzNxZUNkeVJJOHoxQTdKUGR6c1h4MVI5ZDZQMUo3N0JoOVNRSUU5cHk4NkRm?=
 =?utf-8?B?SlNkRElkYXVWb3ZhR0NLKzd3SjV0OHc5TXZST2F1VndnV0o3NDBmUENQUm9y?=
 =?utf-8?B?UWhkU0dUU0J2NkxXYm9UMURJMG5TcnhYRi9DeXlBaTlHN0lkU3hESHh5TTBT?=
 =?utf-8?B?YUFNcWdPeXVRRXVWNGJyTGFpV0ZYNUg1TENMOStNVGk3T1UvYUpVMTQzNUVn?=
 =?utf-8?B?M1c2V1Zrck9aeGpld3FqTXBPejhEa25kcGkvTGdld2JEMGpqWkgzUTVBbFVQ?=
 =?utf-8?B?ZjVpeExQeUE3TklNVEFOK0pyM3dMaVYvRW5yZExKOUI0VG1MVUVZTnZkQ0lT?=
 =?utf-8?B?VEFTUENXZEF1VndRWHZjdUxEWVQ4Y1NObGUvSzRyUEt5VmlNcEUxSlZ4VDdF?=
 =?utf-8?B?YURiL1B5dTVWMmcvaHJRU2c3bE9SWTVmTGtNcnlEd2N4K1ByRlpRVU5iRDFJ?=
 =?utf-8?B?ZHR0b3lMTlREMk55S1NzdlVFYzY2UFJoWWxCVHJ1QlpRcHZBcHhYb3g3aGdq?=
 =?utf-8?B?Y2tTR2xId0tsT0hGaU84dk85WEp2K2lpOWtOK3NXWHRIZWIwa0pxSVlMS29F?=
 =?utf-8?B?Y2ZzRW1Ba3oxZ2hHcnJBWkQrelhNblE1TEtxOGdodnVPVUkyV0NjcVpCRVFU?=
 =?utf-8?B?RGZCa0ErWDMydkxvNlM1c3BNS3p2aWc0NW1GQVlhaThGR2w4eFA0ZjdDSUpL?=
 =?utf-8?B?SzZwN0xQWTMxNVNFeVZHWXJMd3J5bjhranFUREVjNkIyZTkzRmdIcW0vSUpN?=
 =?utf-8?B?NVdiaS9sSjdFUkdSMEJwVVJnaFRHbXpZWEtKNzBibUtPWEhkZ2pLRGZ2U1N2?=
 =?utf-8?B?c2dJdWprUWNtazFwNlFLejh2OGRxMDU0a0xGNU9oWVY2WGYveEwxRVJjV20v?=
 =?utf-8?B?RnRqNW05ZEtBVXg1dXVtOEpzMk9Qd1VOMFVNVGlBekdmNWJ2VHZzaFBxcDYw?=
 =?utf-8?B?UitBL3VsQllncU53aGFWV0k5VnBqa3R0N01BS2ptbjdqWXVUWEprcmpHbXpM?=
 =?utf-8?B?eTBuNzNJbHF6TmQweDBMVm9NNGZ2ZVI1MG9qQlEybERQZHhXMkU2ODliQWpM?=
 =?utf-8?B?NG82RkZGUEkwbjRrWWwrUE5LWFNVYjlJYUVXOWRrbEt2YTNzNGNsblBnTkJO?=
 =?utf-8?B?ZGFOUG93R28weEpsYS9EMVVTOFBNNTRMWDBjQ0VXN21XemdXSnloTlBkM3Mv?=
 =?utf-8?B?NGZRM3dlaER6TVFwNEZGUFhtUVluZjF3N0ltYU9BM3dCYndSRHg0dzFob3VQ?=
 =?utf-8?B?dndjbWZ5dWdWRWxUdmJubUF0SVVZTlFKRUc1RDFvTmpHTTYxb0J4TE50RFN4?=
 =?utf-8?B?U3EyakZXY2lYUExpYUlRa3p6VmN5MkJLUjMxRk9UKzRaNHprZUtvaVFEVEhh?=
 =?utf-8?B?VjlXYzIvU0xMM3kyMEhWaXhWMnFtWnJFSEIyMG9sMmxlcTY5eEhDZXJtbWwv?=
 =?utf-8?B?eEc4SW9nUTJIRVhjRStNNWE4WjZid2NHSUo4QWVhQk5UaE9Ycm9BMFdOM0F0?=
 =?utf-8?Q?n6EMzF/1Az59h95LEkGjla552oz5b3qO9LSN0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0s4VVpXRThSTEw4YWRHVEoyY2VHZFBRSENIN28xdHZVZDZZSGxsV01WR2VK?=
 =?utf-8?B?Mkg0dWxRTG5Sa0RjZzdLbFRGSm9DWU1XUEZxZnFYeTBMUCtwRk8yblBoQnJW?=
 =?utf-8?B?aDREaHVlNEtiQitnRWNNL1I1VGs0Z3FrOVd0ZDdmWFZocFRab3lBeGJ5R0Y5?=
 =?utf-8?B?NjVBdVloQUNDNTIwdE5tb3RCOXh1V3pWZDZ5ZENrZmdFdFZENE00RnpGSlF2?=
 =?utf-8?B?aVpSNUUzNkhaOVBFNG0yZDREellVc2FCcEdvdWpiUGFlMTNxcGtyOERaY0N0?=
 =?utf-8?B?NVZZKytJVUFnL2J5a1F1dXYraUNxdG0rVjZyTjZPTDUxdWY2NDkxS3VCc0Iv?=
 =?utf-8?B?WlN3VlNuWlp5QUQzSXdITDJyd3NRSGdtQkR4WE9SdFBxZmViZmpJcy9NN0x3?=
 =?utf-8?B?Vmc4Zjk2QndaMWFZeU1CTlo0cW80NjFTVlI0UWlDL2cvTGg5UjViV1k5ZkJ2?=
 =?utf-8?B?UlNnK1JNc1JkQlk1MlVoWG5URFQyaklQRnhxWDhmbHlQbkhZZEI0d0JBRWhr?=
 =?utf-8?B?UWx2L2J1K3E5QVRUMW5mdDZVSU5ISlZUNEMzVjNTWThFVTBjNHVoTUJLOVVp?=
 =?utf-8?B?WGgwM0RwY0piQ2h3STh0OGVodVk3T3BuTzhBa0tlRkNJTTVDMUgzUm9mRENk?=
 =?utf-8?B?OFBFMXErUGF2bWdXcXBmdURvdDh0bDJUM1gvbU50c0pPZVI3dXkvNXdoT3lZ?=
 =?utf-8?B?eW1uazNjaDZlSWJVeUFrUUFOZkk4OGdkSjJqc3lBeE53a0hVY1c1NzgrMEgz?=
 =?utf-8?B?aUNjK1llNGRkLytIVFVGYUFPUXBXbTNWakVhVE9JNDdzYUdqcHBIbisyenUr?=
 =?utf-8?B?K0NVVWg1M0ZnTGFPellaekNaUlMzcHhLelczZ0IwZjQ1VjUyaFZHM0E2aXI5?=
 =?utf-8?B?c3VVNlhrQWRsbDNFVm9LYUZmNUNna0dRN1FYUTcxY3UxMjJST1hVVzk3dzZp?=
 =?utf-8?B?alBWVEpqbDFVTFRKOWFobklpZnBFeWg1ZnhUR3lGb3ZvNisrKzIxNGl6Sk80?=
 =?utf-8?B?WEhlTVBNVkIzVnlyZ0tBODZnZnROQlFWYUJUUkZKRGJOU1k4b2p1WmxNQ25l?=
 =?utf-8?B?SmpWWmxFZEpSajZiaFhMdjJtVi9oRjZFWTB4Z2FHdjdSQWtJeVFXZWliOUli?=
 =?utf-8?B?cUR1MlVIS1E0dnlKSnk2RHhpcFM4N2QyZ0FUcWx1Mmt3SUI1V2I5TWhtVkdj?=
 =?utf-8?B?N0ZzeVhmaDZ6blA1RWgvb2x2YjdtY2NQemdqQU43Q1h5Q1pXLzRmaFI0RHYw?=
 =?utf-8?B?MS9CNkxPUkZKUE55TU5aQkV3dVJvZVZDZ2dTWTlUQ0RINnQrd2tBYkNTalFy?=
 =?utf-8?B?TUttOWNuT01wUDZzMm5wWUYvZktkQ0UrR0wyVGlVcmNYRHh5ckQ1RCszcGp4?=
 =?utf-8?B?cER5NU1RRmlUeHpPbEVra0ZDQWE2OE92QUs1czFNTjBVVmw2N2cxWXBBNkhX?=
 =?utf-8?B?bnpJclk4ekhLU0RSeUlINW5PU2NhNHFRYTJqU1JiekMvRFNXSEgra1h4QjdZ?=
 =?utf-8?B?UGVzdXluRzdsSVp6VEtyTnRnK0ptWXZnVjdLcWpGSDVIanpZNUlDdUNUWGs5?=
 =?utf-8?B?R2FmQVpqcjg4L21uaEtmSUFIcVRCNFdYK3F0VUdFTWxzUEovb0RiU3NPbnho?=
 =?utf-8?B?eHpjS0szMWw4b1A2N2FXZVJPUTZKdHVpdnFSMXJHMWlKaElLK2VxVFp4R1pW?=
 =?utf-8?B?Q3pQdFpkWFpRempWYUx0VER2aFh4c3p2a01QYnhNM1QrWWxFM1FFSGdpTHJt?=
 =?utf-8?B?MzdUUkYzcjhQT2dQSkdXS0lXZXZIYm9MSklBTTZEcm5JbjVNVGlGcXYyYkts?=
 =?utf-8?B?cm9BTVdWbVVieE5aWUtSQzJFZzJFRUw0TlMxMTFHUGxicnNxZ3RTazdHcnM5?=
 =?utf-8?B?VG84OVBobll1RUNvNUtVN3NjMkdKZG5KaDg2RGNaS3F6UFJaQzZLbXh5eW5j?=
 =?utf-8?B?WHQ0SkV5OHh0dnVodzB2QjhBWm94TGpTUUVKZGJTaXY4Y3BEb3Q0UTFmU3BX?=
 =?utf-8?B?R0I0WmJyM2F2QnZMbE5aSTU3YmlWWExzbW9DRFZlcTNZMUtYK2UxMld4VW91?=
 =?utf-8?B?NGFNd0xsbWVJTkViUW8wYjdOMzYzT0xiL2N6YzFFd2RZczBhTGFITE51TmZ0?=
 =?utf-8?Q?X7s2gf+VrFtXUZ+pk2poJELLg?=
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
	al9Ddb4wAdgjzdTUgxYiXDxH05Kpe5GF7OdnLlZK5xcGnLYTT7XeM73DmawsLpCGGskBo5t8UoDgZpDdO9OW9PZxf/O9TeyFA1QCSiEdVUpVWsGuyzoKtjGRsqqGRvgsLWSDTNlslblKPuLPWLATB0OwfENMWoDInetR0Qp36NTAAkQPF0KCW54T/HLeFEDpkJCxOnzp+1tz0ghjXqQSGH5AvOLuJ4dD/taVikRChLeM1ax78QcmKT9wkya7XTa0u09gGNwxVQ8OonRfetYg55YGZT1Z5LLa549IBkI+Bw6ktDQzbPY3B5Egw5mv3wCGAiHQMdDQ4B2qiEyIsR8R1tRd39YZXW/DbFFGkcXSVEo2D35YnYkhcGw6nsjOk0Ijw0G2i49VfOaNSG38ebIJ3YNlFeT74vHRaq01FEvU6CzRS7Xsfr/LucHOkXA5FTQhSx/kIIc/NJWee5OwhEGrMklMbkga/XrygNmf5uwto9RXAf2qh8XEiWxlshiY5IghWC6lWPSbQSejlqbz7fYPaBxcbPqjCUuRKOfk195qbzfp3wCIXAfAoVTh445PQZ8fOJl9N2+uumPRh0H8Zr9aU/yv5wkbQA3i4YCo8FaPmGsMHxVA4KITEAgVHOjW6DlS
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a4eefc-f213-46aa-257d-08dd0774ef50
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:01:36.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+n8c6ElkRubjddFCTsuzLNqwHUkN7dY1Y5Uf5w5LUlXKSZhJ8GqzwA27e3BDdgtYOXH9aBBuUV+ZzDk0Hq/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6119
X-Proofpoint-GUID: Pb27w_B8xuVOUccb6BiWsZGY0Zhopn0R
X-Proofpoint-ORIG-GUID: Pb27w_B8xuVOUccb6BiWsZGY0Zhopn0R
X-Sony-Outbound-GUID: Pb27w_B8xuVOUccb6BiWsZGY0Zhopn0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01

VG8gZGV0ZXJtaW5lIHdoZXRoZXIgaXQgaXMgYSBkaXJlY3RvcnksIHRoZXJlIGlzIG5vIG5lZWQg
dG8gcmVhZCBpdHMNCmRpcmVjdG9yeSBlbnRyeSwganVzdCB1c2UgU19JU0RJUihpbm9kZS0+aV9t
b2RlKS4NCg0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29t
Pg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQpS
ZXZpZXdlZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1lckBzb255LmNvbT4NCi0tLQ0K
IGZzL2V4ZmF0L25hbWVpLmMgfCAyMCArKysrLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMv
ZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMNCmluZGV4IDJjNGM0NDIyOTM1Mi4uNjcy
MzM5NmRlYWU4IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhmYXQv
bmFtZWkuYw0KQEAgLTExMTgsMTcgKzExMTgsMTIgQEAgc3RhdGljIGludCBfX2V4ZmF0X3JlbmFt
ZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsDQogCWludCByZXQ7DQogCWludCBkZW50
cnk7DQogCXN0cnVjdCBleGZhdF9jaGFpbiBvbGRkaXIsIG5ld2RpcjsNCi0Jc3RydWN0IGV4ZmF0
X2NoYWluICpwX2RpciA9IE5VTEw7DQogCXN0cnVjdCBleGZhdF91bmlfbmFtZSB1bmlfbmFtZTsN
Ci0Jc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXA7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBv
bGRfcGFyZW50X2lub2RlLT5pX3NiOw0KIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhG
QVRfU0Ioc2IpOw0KIAljb25zdCB1bnNpZ25lZCBjaGFyICpuZXdfcGF0aCA9IG5ld19kZW50cnkt
PmRfbmFtZS5uYW1lOw0KIAlzdHJ1Y3QgaW5vZGUgKm5ld19pbm9kZSA9IG5ld19kZW50cnktPmRf
aW5vZGU7DQogCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICpuZXdfZWkgPSBOVUxMOw0KLQl1bnNp
Z25lZCBpbnQgbmV3X2VudHJ5X3R5cGUgPSBUWVBFX1VOVVNFRDsNCi0JaW50IG5ld19lbnRyeSA9
IDA7DQotCXN0cnVjdCBidWZmZXJfaGVhZCAqbmV3X2JoID0gTlVMTDsNCiANCiAJLyogY2hlY2sg
dGhlIHZhbGlkaXR5IG9mIHBvaW50ZXIgcGFyYW1ldGVycyAqLw0KIAlpZiAobmV3X3BhdGggPT0g
TlVMTCB8fCBzdHJsZW4obmV3X3BhdGgpID09IDApDQpAQCAtMTE1NCwxNyArMTE0OSw4IEBAIHN0
YXRpYyBpbnQgX19leGZhdF9yZW5hbWUoc3RydWN0IGlub2RlICpvbGRfcGFyZW50X2lub2RlLA0K
IAkJCWdvdG8gb3V0Ow0KIAkJfQ0KIA0KLQkJcF9kaXIgPSAmKG5ld19laS0+ZGlyKTsNCi0JCW5l
d19lbnRyeSA9IG5ld19laS0+ZW50cnk7DQotCQllcCA9IGV4ZmF0X2dldF9kZW50cnkoc2IsIHBf
ZGlyLCBuZXdfZW50cnksICZuZXdfYmgpOw0KLQkJaWYgKCFlcCkNCi0JCQlnb3RvIG91dDsNCi0N
Ci0JCW5ld19lbnRyeV90eXBlID0gZXhmYXRfZ2V0X2VudHJ5X3R5cGUoZXApOw0KLQkJYnJlbHNl
KG5ld19iaCk7DQotDQogCQkvKiBpZiBuZXdfaW5vZGUgZXhpc3RzLCB1cGRhdGUgZWkgKi8NCi0J
CWlmIChuZXdfZW50cnlfdHlwZSA9PSBUWVBFX0RJUikgew0KKwkJaWYgKFNfSVNESVIobmV3X2lu
b2RlLT5pX21vZGUpKSB7DQogCQkJc3RydWN0IGV4ZmF0X2NoYWluIG5ld19jbHU7DQogDQogCQkJ
bmV3X2NsdS5kaXIgPSBuZXdfZWktPnN0YXJ0X2NsdTsNCkBAIC0xMTk2LDYgKzExODIsOCBAQCBz
dGF0aWMgaW50IF9fZXhmYXRfcmVuYW1lKHN0cnVjdCBpbm9kZSAqb2xkX3BhcmVudF9pbm9kZSwN
CiANCiAJaWYgKCFyZXQgJiYgbmV3X2lub2RlKSB7DQogCQlzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0
X2NhY2hlIGVzOw0KKwkJc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciA9ICYobmV3X2VpLT5kaXIp
Ow0KKwkJaW50IG5ld19lbnRyeSA9IG5ld19laS0+ZW50cnk7DQogDQogCQkvKiBkZWxldGUgZW50
cmllcyBvZiBuZXdfZGlyICovDQogCQlyZXQgPSBleGZhdF9nZXRfZGVudHJ5X3NldCgmZXMsIHNi
LCBwX2RpciwgbmV3X2VudHJ5LA0KQEAgLTEyMTIsNyArMTIwMCw3IEBAIHN0YXRpYyBpbnQgX19l
eGZhdF9yZW5hbWUoc3RydWN0IGlub2RlICpvbGRfcGFyZW50X2lub2RlLA0KIAkJCWdvdG8gZGVs
X291dDsNCiANCiAJCS8qIEZyZWUgdGhlIGNsdXN0ZXJzIGlmIG5ld19pbm9kZSBpcyBhIGRpcihh
cyBpZiBleGZhdF9ybWRpcikgKi8NCi0JCWlmIChuZXdfZW50cnlfdHlwZSA9PSBUWVBFX0RJUiAm
Jg0KKwkJaWYgKFNfSVNESVIobmV3X2lub2RlLT5pX21vZGUpICYmDQogCQkgICAgbmV3X2VpLT5z
dGFydF9jbHUgIT0gRVhGQVRfRU9GX0NMVVNURVIpIHsNCiAJCQkvKiBuZXdfZWksIG5ld19jbHVf
dG9fZnJlZSAqLw0KIAkJCXN0cnVjdCBleGZhdF9jaGFpbiBuZXdfY2x1X3RvX2ZyZWU7DQotLSAN
CjIuNDMuMA0KDQo=

