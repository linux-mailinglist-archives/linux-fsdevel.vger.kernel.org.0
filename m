Return-Path: <linux-fsdevel+bounces-39715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA857A172BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F73C3A8F36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B621E9B1A;
	Mon, 20 Jan 2025 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="al96S/kq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3531156678;
	Mon, 20 Jan 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737398742; cv=fail; b=cBLxqod1bT4FbEb6p9z1elwvb1IHLCJinHQXXminBe4Op6tmFa90HWZdJjp0l5o0PNuyQRcJadn8GGux4QIFgIp5MLWOvcMsYXk1R3o1iXKJ3aHMxq+ybWtMHcK0mglcuWXUnU/pZX5wPy74hxEOQb+4yF2CaU2hhpkvxNZg3cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737398742; c=relaxed/simple;
	bh=GNVyCnVQ3/cSCAsMdLEEWk9MXkbC4mmSFRYztVUicZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WPw+FPAEHShACnra6yNm6AtZjutXAlqXwphbkMSQPSq4amOrwONsV828GwHrMND+UjknN883apGfufrMG/prR1le7KgYymn8PhSXRy93Zmc4q4Ccw5zktq/AedqDJUhY+t3vvEGPBhRz4iRaAEZHTNZImeRS0WX9SGu66KWquTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=al96S/kq; arc=fail smtp.client-ip=40.107.243.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cC+ljUpt2qPlxRaYg6+KGx59wwiC5zHP8d0/ya5xn0FZipOEMOC6QvYFLL33aG7a9TTyUZrXCwOqFyVRIqGF3w1TeS3yGSz+knHuUtt8vwCic38isIY2U60DpX5bPWHKxkGqPcnn2OdtcQP/xbzJuLo1pp9M70/LiXiJxB8uBzd6PjdwYDHvu+2Q1e9A5jVivYKaUeSFGBKm8YQbR4CahOIQCEZjhA6KiDDohD+HRoYX29Akvm5xeFnnKQN+++TdKTznL67zCx1G+beJn4xetyWLnyWwkbKGGR3YbgHD/rIWBIobhe/OUyrsz2ofN5IK3s+BqqLG3+EKoXNoCfp+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNVyCnVQ3/cSCAsMdLEEWk9MXkbC4mmSFRYztVUicZQ=;
 b=ujHPXSelZJ3AfBoLBMGJgZWxhMnn8rSWMK81Eo5FKARDav9vJzjTlZklIyImZUX+KPb6xMXLNYGny5uf+GKiNM201GdYEM38EHJdJNHPFdHWBsUP7YXHbQWbVRPWlTFGl+XxRNMFNVjTQGIF5hQP3Y3h3RGpBmz3kTygncZPhAfjDy7zRf+a26KX8L09S/5DH5uBsbLQJdME/oH6nh7hQQskeXLCJGx/Vl76REYjsppprOLeApMiLVZOMwN8/1S+yl4p8sMNMWaJd3r/gYFjki72vERK8WjdkRQzJ1uPvIsALGmGCVC3Znr2F8UBMyfS8uzjc43GvrqRfEp5Rkk8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNVyCnVQ3/cSCAsMdLEEWk9MXkbC4mmSFRYztVUicZQ=;
 b=al96S/kqPaEdmZGaUqFKCplpxYUUL2Bn+tub9+7d3PtN12DOB864DBRCCqUKzdwaahFLDY0/A4HkqEngVLAYZfv6kafg6Dr+D8wi4xdRs+6l6B5FAU53c3Cgo9WAb5fr9WjLQW4ZzUKWnFdprIbrpZ7Lyu799xaBcN9ecX2c5uc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB4990.namprd13.prod.outlook.com (2603:10b6:806:1a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 18:45:37 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 18:45:37 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "amir73il@gmail.com" <amir73il@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
Thread-Topic: [PATCH] nfsd: map EBUSY for all operations
Thread-Index: AQHba1+fzw+WkJ1joUqohuwhSceLX7Mf6qKAgAAO6wCAAAawAA==
Date: Mon, 20 Jan 2025 18:45:37 +0000
Message-ID: <9fc1d00dc27daad851f8152572764ae6fe604374.camel@hammerspace.com>
References: <20250120172016.397916-1-amir73il@gmail.com>
	 <c47d74711fc88bda03ef06c390ef342d00ca4cba.camel@hammerspace.com>
	 <CAOQ4uxgQbEwww8QFHo2wHMm2K2XR+UmOL3qTbr-gJuxqZxqnsQ@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxgQbEwww8QFHo2wHMm2K2XR+UmOL3qTbr-gJuxqZxqnsQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB4990:EE_
x-ms-office365-filtering-correlation-id: 0099c233-eaab-4a09-7fef-08dd3982a15c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2hjc2l0aGNsRCtwN1FsTDBpbnpxUkNQWGJRWVNJaDJNYlpwUzY1RjRmeEs1?=
 =?utf-8?B?K1dST3RBbVg0UDdBb00yaUdSSzZwMkQ4aTI3MXc4RDBmbWtPSFRiejRnTUs1?=
 =?utf-8?B?QlU2Z0tWOWExSG9IODZ1OVVvbWw4ZUNyWHEwMU1hZVQwQjg1TDhKR3ZIK01E?=
 =?utf-8?B?cUlSWFpteWZWckF6VGVSN0NJc0pQMi9oZ1lkRDY3b3FhWGtkTFNlNm1CT1VS?=
 =?utf-8?B?UzQ2WTVrMnprSTZHUzdDVGJhajM4OHg4M2NTN0Y4RjRYbGZLUG5ZWkRBOEVX?=
 =?utf-8?B?dE1EZkQ0cVpVazY1Q3QxbjRobkNURWdzRGZYV3pjUElEOVgyZ1V5b2lwREcy?=
 =?utf-8?B?dTNNMUFWSlRoQ0UxK3htV0U4VjFmT2xaS0duZitnK095QWg3WnhuMGh2cEw3?=
 =?utf-8?B?V0ZpTy9Ja2VsQTV5WjFTODMyem1NSEhhMEFmc0VHellVY00zK2xVak8yZkdU?=
 =?utf-8?B?YjV6R2k5TEpwd2tXSmp3Z281WkNJQzVDRktMSVlqMjZnWDlKUlg1SVBKczlo?=
 =?utf-8?B?enZtNWNBeDZVMG1hdk85UlZMNFFhRlJaNDMxbTIzZjhmNlJLSHRuWmpoMDVx?=
 =?utf-8?B?UWFkVDlNcHdwbGtYbE5VUDF5OE1nTThvQVB2SVh4Z0NYdEkrTG12NnBUUUlB?=
 =?utf-8?B?TzZ5TXRtREZCYkJwMHVRenNPVlRiU2JGYlowQy9rcDNDOEN6WldhbmhpMmo2?=
 =?utf-8?B?OFBYdTk0V3p3dlpqUkN1ay9MY2FwU0g2M2Y0TW5GNTBNTW10ZXZwRkdXSUR4?=
 =?utf-8?B?eENXMW8zcklaOHkwaytUTWQraE5tQzlzYXBnQTVjQmRCeXRBcHhPbTQrR3VY?=
 =?utf-8?B?N3Q4bDB0S3NXUmFqNm9RL0plMXkzd1hZMDdEeVZJaFdqSzg5ZFJFWEVrNVph?=
 =?utf-8?B?c1dUalRvMzlPZXZ2UFlVUDZ4VjJXcHZUNEFtM3RkemNySjQwSlZ0QVY3RnJJ?=
 =?utf-8?B?RjFiRjV0UjdvY05tdFVEd3Uybi93RkN0OUIrQ1RrMEdDalIrTGI5YXRDYmFU?=
 =?utf-8?B?QWp1b01XVnZHVTJxVE45ZDNWYU5nY1BDb0k2a1JtRmxwaVFaUEZSWUk0VS9a?=
 =?utf-8?B?Zmk2SGZCMWU1MXRBTUJJVFJJek1NQUJ3NkR5Tzg4djZyL0NiaTRFUTVITXdw?=
 =?utf-8?B?MmFyRkFNM3EvYkRlNGhCN091ZHRVUDdlNzJxUjY1b2dYdCtQcEFPc0dDeUth?=
 =?utf-8?B?Vk1VdlJkbnV2VGx5dFlkeml6VVNRbmdMMVNxd2tSTUFIZzlOMU96NEdqU3d6?=
 =?utf-8?B?VytDWmNqSCtBdDhidmFDSkxUd1A5WFM3eW5MbHlIYVJUL3Jtbm12TkZjNnYz?=
 =?utf-8?B?TTByekxBcW9IVlQrNHQyTktKL254R29uZlFKb21zWUZKcUwra3FwbVhTMUdG?=
 =?utf-8?B?NHYxYkhKbjMxZGFadDBFa1dKelFaWjc0cUYxZnpSV1lCSy9Ra1Qvckk5YStP?=
 =?utf-8?B?MnlmT1puQVJ6ckdDL3NNSHU2WE1SQ2NFKzF0TmZsYUFtS3o4UHY3L3VKbTRJ?=
 =?utf-8?B?VnpBa1FuUTJQb2FaRGpWSnlJTU9qeStWbm5IbFNnNjNxdkhLWTBOSHFueHpq?=
 =?utf-8?B?czErY2FRUk9wZTErNTNCdGMwUDk3VE9BTnNSdFRRUzhpNGxPMDNjZ3hVS0pm?=
 =?utf-8?B?M0Z0VEZiSERENHk3bkFMY3NxV3R0NGdpclpXV0VhQnhLYjUrVkRvYWU0WGQ3?=
 =?utf-8?B?RjFjVzkzOHFQN3FzazJkVDA4c2hWV1AxcllRbk1qQnR4bmdrR0Q1eCs2b1BK?=
 =?utf-8?B?MG5DaTBlWG9kTGorQWlKT3V1cnczajZ3bzFybVBkWnpqZGozZVdXZWtWR1I3?=
 =?utf-8?B?Q1p1MXhQREVqazJRc0ViUmRDVDBWQTFSM2JLT2ZZRDlOSzhoemZ4b292S3VQ?=
 =?utf-8?B?aWpOMHFrTG5BcFhlTnJWOEIvS2VRSjVsbjAvVjAzeEdjbDlvOEpDeVNTVXVW?=
 =?utf-8?Q?hTozKb85lgyAfwJKJMN0UH/E501izMiJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjRSVUhtUHVDMFk3Tkg3QW9iUXNWTCtLQnRoZTdKWW5EV2twUkw1Sjd4UUJG?=
 =?utf-8?B?Zml0Vy94elA5QXpEUkthMXlKZFlhSVpTQkRPWlRDWXMvK2xHaHFWRlVWaHA5?=
 =?utf-8?B?M1ZxWTkvMGVXa0pwT01BZzJFLzNjbXYxbGFCUHlwbi9MejlXa0NUVmtMZzlI?=
 =?utf-8?B?L0dLL3BwMkZVZ2hSWVFkTDlOU3V3OG1XblN5NjBYRzdpSVozNlg2dFRXZFVJ?=
 =?utf-8?B?SjJFVGFNT1hxRkx5dVgzSXRrR1BOWHl4RS9YdStWWFdFSno3OEtUaVNNQTBx?=
 =?utf-8?B?QW5ITDVMalhKb1ByUUVRYkhYQ2o1TmVUK3NCMVMvQTJmU1Fmc0xCcEVPQ1RN?=
 =?utf-8?B?bFdraVhkaTFWVzBQMzBkckNPRnZaemNweWJFSCtuMEczZ0l6U1VsbW1oY2R2?=
 =?utf-8?B?WGJiMHZWRHNTQjRCQUR1R2ZIUFlkSnAzTmFGNTk2VnliM3kyM1NGbFZPdkFw?=
 =?utf-8?B?SXZPV3RYa3hlWXEyWjVTaUJqMmtvdmhXNkZMTGw1bzdEZ0Nod2xxeHFkeGNQ?=
 =?utf-8?B?YUtRaDBhWTRLVUNMd1kwejVWT1dLOUJGWjVGdDlJNDlIblZPUUs0Qll1S3pa?=
 =?utf-8?B?bWR5elBlYXZ6T1JGTDJUeDJmNVlhOGRnWDdvdDhWKzhmZHhCOEsvOG9EOGFJ?=
 =?utf-8?B?R2pJUDBrMyt1RlVOUEdUcStxcXFWQkw1ZUx2N0tzWEpkcUVTS2tTb1ZyMUd3?=
 =?utf-8?B?SzFRM1lMUWRmeHkwYS92M3d4NEpRZm9CVVBQdWNuOWhNbmhPRVpWd3orak4r?=
 =?utf-8?B?eUJhb05ybzhQc20wRmFMYTh1cmkzeEs5TVFCcFE5QXphOEtrbm0zc21PTFU2?=
 =?utf-8?B?NEQzeVptUmZRWE5nakJ1bXdlVnU4SmFvR0t1c09nTlg1ZUY0WnlNWGk0d09D?=
 =?utf-8?B?MXZtRk5vOGg4NkRKLzhYZHAzdXJoSTdxY2RoaFB3UDVjQldhcDg3aDNqZVVa?=
 =?utf-8?B?cHdXU1Y1Q0ZoeVlKNm5ZY1AxZDJ5c1RTNjZQZDF0ZE5Nd3Y0UTgyQUVnMFFB?=
 =?utf-8?B?YVV0aDkyZVpDcE8va3V2d0d1RTM0cjVJbTJ5VFIvbERIUHVCVTQ1RC9IUXhp?=
 =?utf-8?B?Y0s2TlRNK1BOT1M2dzBFUEQ3U3dmTXlOL1lFR01mZlB4aWY5NC9udCswZ0Zj?=
 =?utf-8?B?dCtqdFlTM2VGTGdxVkVwbDF2Q09nemVQY2FWY0tkV0JIaXJqQUx2cG5yc0FD?=
 =?utf-8?B?YTFueW43NVF5MmpXV2RkeHg4UnpJMllQd2Jqckx3eWJMb0V0cEM4Q3MwQTB4?=
 =?utf-8?B?ZzBoWm1aWk1lWWpjZ1VMN0t4ck1KTUpKcUJ6cXVjQVBpc3Y1cTRtUGJQeGZX?=
 =?utf-8?B?Wm14VWhYNWNqbU9TbHlscjJBeW5yaUk0VUdiaStOVU9XZE9HNHVqLytFazJx?=
 =?utf-8?B?czFwUXg1WHJzWlR5MjlsMXNVeTRoU0ZaSTFDc0ZKOHFMaVlwd0padTgrbVpR?=
 =?utf-8?B?MGlEZ25ZK2U5eVBLd2poYjV6L0pVdjFBZjZ2eUdRWTVsYWYvZzBqaWFTSXMw?=
 =?utf-8?B?L1FsR1NVWmd0TURDckNZWmMwR00xUWlQYlM0bGtrTGRucE9xUkp1SGpxbmVQ?=
 =?utf-8?B?TDVWaml1ZjhVMG92SEdIODlrWGQxRlY0YUpwcG10bm84b0hKSE42Y2V1Rldx?=
 =?utf-8?B?aElISU9taDZoUWw3akZyT2NSeDdvOGJjQXhKemtZbWNmZUREeXJBai96MHRB?=
 =?utf-8?B?WmVMd0lCVWFtQStFWjRDTlY2N2hSZlFUS3pYMUQvUE1Xc0k3cGhIM2dKZTE2?=
 =?utf-8?B?VjBCT0VNdDhyZUh1RllaYlkwL3VIang2dGI4Q0dNbnU5Z3BxU3ZuSmtwbjNW?=
 =?utf-8?B?RXc2Y2pSS0IrSmlKU1d5OFphbGZyc1p3MEVKU3BQTE5SMVVFQkdDMTVpdE84?=
 =?utf-8?B?WEFxa3RLYTJ4eUNVUFQ1V1dIWGZJcElOcTJzbGJ6L0V0eVhTUmlNZi9oQ0gv?=
 =?utf-8?B?VTFsRmQyckovMmh3N0grSGswOFVsNmNJR3UyQis0NWRYc2tIbVNBQmhFV3FK?=
 =?utf-8?B?TDE4OThCQm1YRkZOK1ZJa3JXYUc2bmQ2dC9OTUpFNnMvRTg3VVlGSWROTTRi?=
 =?utf-8?B?bTY1anFLb2xwQ0taTHVIb3hhZXFNTHhNMzJ5dGJZZElHdG9UQm5oenA1QUpQ?=
 =?utf-8?B?Y2NlQ0l2WmgvNHhndHVsYUVwQ2RUbDhoS3dtZXpCR09KUlltVDEzakc2d0Y1?=
 =?utf-8?B?NkloRWpRN3IyR2xQQTBLL200OU80OUZZWS9WaHFGOXFhdkppR1F6OFoxSVFk?=
 =?utf-8?B?RlFGS1NzcGsvcjdLcWFzZ3MyKytnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9750F18D52A38A489731E55049694050@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0099c233-eaab-4a09-7fef-08dd3982a15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 18:45:37.2151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jgzve9z4YKoIq3wCWVPEUDpljK6/G/Db5JydgD+6GYBrW1xhU0CyxoThNY3W6CEMV0DCnk8AP32sRaLOy00STQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4990

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDE5OjIxICswMTAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gT24gTW9uLCBKYW4gMjAsIDIwMjUgYXQgNjoyOOKAr1BNIFRyb25kIE15a2xlYnVzdA0KPiA8
dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyNS0w
MS0yMCBhdCAxODoyMCArMDEwMCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6DQo+ID4gPiB2NCBjbGll
bnQgbWFwcyBORlM0RVJSX0ZJTEVfT1BFTiA9PiBFQlVTWSBmb3IgYWxsIG9wZXJhdGlvbnMuDQo+
ID4gPiANCj4gPiA+IHY0IHNlcnZlciBvbmx5IG1hcHMgRUJVU1kgPT4gTkZTNEVSUl9GSUxFX09Q
RU4gZm9yDQo+ID4gPiBybWRpcigpL3VubGluaygpDQo+ID4gPiBhbHRob3VnaCBpdCBpcyBhbHNv
IHBvc3NpYmxlIHRvIGdldCBFQlVTWSBmcm9tIHJlbmFtZSgpIGZvciB0aGUNCj4gPiA+IHNhbWUN
Cj4gPiA+IHJlYXNvbiAodmljdGltIGlzIGEgbG9jYWwgbW91bnQgcG9pbnQpLg0KPiA+ID4gDQo+
ID4gPiBGaWxlc3lzdGVtcyBjb3VsZCByZXR1cm4gRUJVU1kgZm9yIG90aGVyIG9wZXJhdGlvbnMs
IHNvIGp1c3QgbWFwDQo+ID4gPiBpdA0KPiA+ID4gaW4gc2VydmVyIGZvciBhbGwgb3BlcmF0aW9u
cy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2ls
QGdtYWlsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiBDaHVjaywNCj4gPiA+IA0KPiA+
ID4gSSByYW4gaW50byB0aGlzIGVycm9yIHdpdGggYSBGVVNFIGZpbGVzeXN0ZW0gYW5kIHJldHVy
bnMgLUVCVVNZDQo+ID4gPiBvbg0KPiA+ID4gb3BlbiwNCj4gPiA+IGJ1dCBJIG5vdGljZWQgdGhh
dCB2ZnMgY2FuIGFsc28gcmV0dXJuIEVCVVNZIGF0IGxlYXN0IGZvcg0KPiA+ID4gcmVuYW1lKCku
DQo+ID4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IEFtaXIuDQo+ID4gPiANCj4gPiA+IMKgZnMv
bmZzZC92ZnMuYyB8IDEwICsrLS0tLS0tLS0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2Zz
L25mc2QvdmZzLmMgYi9mcy9uZnNkL3Zmcy5jDQo+ID4gPiBpbmRleCAyOWNiN2I4MTJkNzEzLi5h
NjFmOTljMDgxODk0IDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZzZC92ZnMuYw0KPiA+ID4gKysr
IGIvZnMvbmZzZC92ZnMuYw0KPiA+ID4gQEAgLTEwMCw2ICsxMDAsNyBAQCBuZnNlcnJubyAoaW50
IGVycm5vKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeyBuZnNlcnJfcGVybSwg
LUVOT0tFWSB9LA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeyBuZnNlcnJfbm9f
Z3JhY2UsIC1FTk9HUkFDRX0sDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7IG5m
c2Vycl9pbywgLUVCQURNU0cgfSwNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeyBu
ZnNlcnJfZmlsZV9vcGVuLCAtRUJVU1l9LA0KPiA+ID4gwqDCoMKgwqDCoCB9Ow0KPiA+ID4gwqDC
oMKgwqDCoCBpbnTCoMKgwqDCoCBpOw0KPiA+ID4gDQo+ID4gPiBAQCAtMjAwNiwxNCArMjAwNyw3
IEBAIG5mc2RfdW5saW5rKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdA0KPiA+ID4gc3Zj
X2ZoICpmaHAsIGludCB0eXBlLA0KPiA+ID4gwqBvdXRfZHJvcF93cml0ZToNCj4gPiA+IMKgwqDC
oMKgwqAgZmhfZHJvcF93cml0ZShmaHApOw0KPiA+ID4gwqBvdXRfbmZzZXJyOg0KPiA+ID4gLcKg
wqDCoMKgIGlmIChob3N0X2VyciA9PSAtRUJVU1kpIHsNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyogbmFtZSBpcyBtb3VudGVkLW9uLiBUaGVyZSBpcyBubyBwZXJmZWN0DQo+ID4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBlcnJvciBzdGF0dXMuDQo+ID4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZXJyID0gbmZzZXJyX2ZpbGVfb3BlbjsNCj4gPiA+IC3CoMKgwqDCoCB9IGVsc2Ugew0KPiA+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBuZnNlcnJubyhob3N0X2Vycik7DQo+
ID4gPiAtwqDCoMKgwqAgfQ0KPiA+ID4gK8KgwqDCoMKgIGVyciA9IG5mc2Vycm5vKGhvc3RfZXJy
KTsNCj4gPiA+IMKgb3V0Og0KPiA+ID4gwqDCoMKgwqDCoCByZXR1cm4gZXJyOw0KPiA+ID4gwqBv
dXRfdW5sb2NrOg0KPiA+IA0KPiA+IElmIHRoaXMgaXMgYSB0cmFuc2llbnQgZXJyb3IsIHRoZW4g
aXQgd291bGQgc2VlbSB0aGF0IE5GUzRFUlJfREVMQVkNCj4gPiB3b3VsZCBiZSBtb3JlIGFwcHJv
cHJpYXRlLg0KPiANCj4gSXQgaXMgbm90IGEgdHJhbnNpZW50IGVycm9yLCBub3QgaW4gdGhlIGNh
c2Ugb2YgYSBmdXNlIGZpbGUgb3Blbg0KPiAoaXQgaXMgYnVzeSBhcyBpbiBsb2NrZWQgZm9yIGFz
IGxvbmcgYXMgaXQgaXMgZ29pbmcgdG8gYmUgbG9ja2VkKQ0KPiBhbmQgbm90IGluIHRoZSBjYXNl
IG9mIGZhaWx1cmUgdG8gdW5saW5rL3JlbmFtZSBhIGxvY2FsIG1vdW50cG9pbnQuDQo+IE5GUzRF
UlJfREVMQVkgd2lsbCBjYXVzZSB0aGUgY2xpZW50IHRvIHJldHJ5IGZvciBhIGxvbmcgdGltZT8N
Cj4gDQo+ID4gTkZTNEVSUl9GSUxFX09QRU4gaXMgbm90IHN1cHBvc2VkIHRvIGFwcGx5DQo+ID4g
dG8gZGlyZWN0b3JpZXMsIGFuZCBzbyBjbGllbnRzIHdvdWxkIGJlIHZlcnkgY29uZnVzZWQgYWJv
dXQgaG93IHRvDQo+ID4gcmVjb3ZlciBpZiB5b3Ugd2VyZSB0byByZXR1cm4gaXQgaW4gdGhpcyBz
aXR1YXRpb24uDQo+IA0KPiBEbyB5b3UgbWVhbiBzcGVjaWZpY2FsbHkgZm9yIE9QRU4gY29tbWFu
ZCwgYmVjYXVzZSBjb21taXQNCj4gNDY2ZTE2ZjA5MjBmMyAoIm5mc2Q6IGNoZWNrIGZvciBFQlVT
WSBmcm9tIHZmc19ybWRpci92ZnNfdW5pbmsuIikNCj4gYWRkZWQgdGhlIE5GUzRFUlJfRklMRV9P
UEVOIHJlc3BvbnNlIGZvciBkaXJlY3RvcmllcyBmaXZlIHllYXJzDQo+IGFnbyBhbmQgdmZzX3Jt
ZGlyIGNhbiBjZXJ0YWlubHkgcmV0dXJuIGEgbm9uLXRyYW5zaWVudCBFQlVTWS4NCj4gDQoNCkkn
bSBzYXlpbmcgdGhhdCBjbGllbnRzIGV4cGVjdCBORlM0RVJSX0ZJTEVfT1BFTiB0byBiZSByZXR1
cm5lZCBpbg0KcmVzcG9uc2UgdG8gTElOSywgUkVNT1ZFIG9yIFJFTkFNRSBvbmx5IGluIHNpdHVh
dGlvbnMgd2hlcmUgdGhlIGVycm9yDQppdHNlbGYgYXBwbGllcyB0byBhIHJlZ3VsYXIgZmlsZS4N
ClRoZSBwcm90b2NvbCBzYXlzIHRoYXQgdGhlIGNsaWVudCBjYW4gZXhwZWN0IHRoaXMgcmV0dXJu
IHZhbHVlIHRvIG1lYW4NCml0IGlzIGRlYWxpbmcgd2l0aCBhIHNlcnZlciB3aXRoIFdpbmRvd3Mt
bGlrZSBzZW1hbnRpY3MgdGhhdCBkb2Vzbid0DQphbGxvdyB0aGVzZSBwYXJ0aWN1bGFyIG9wZXJh
dGlvbnMgd2hpbGUgdGhlIGZpbGUgaXMgYmVpbmcgaGVsZCBvcGVuLiBJdA0Kc2F5cyBub3RoaW5n
IGFib3V0IGV4cGVjdGluZyB0aGUgc2FtZSBiZWhhdmlvdXIgZm9yIG1vdW50cG9pbnRzLCBhbmQN
CnNpbmNlIHRoZSBsYXR0ZXIgaGF2ZSBhIHZlcnkgZGlmZmVyZW50IGxpZmUgY3ljbGUgdGhhbiBm
aWxlIG9wZW4gc3RhdGUNCmRvZXMsIHlvdSBzaG91bGQgbm90IHRyZWF0IHRob3NlIGNhc2VzIGFz
IGJlaW5nIHRoZSBzYW1lLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==

