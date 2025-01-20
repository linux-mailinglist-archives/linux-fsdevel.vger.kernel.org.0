Return-Path: <linux-fsdevel+bounces-39731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FE6A17322
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A4F167D4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79121EF080;
	Mon, 20 Jan 2025 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OXnOpm7i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9EE17A5BE;
	Mon, 20 Jan 2025 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737401393; cv=fail; b=r0TKusSFx6RD+7xt6WjSbYktfjoIUSVQQ+DHHtSAhe8jW/33tQusHwvmzSOu6BPjuxT9f8rlHi2pTXAtOpMWW5jVAfRq9dbawLew0c7hvHkUGiichC5ra0MK4CDtj4mFtgWsQfBdsfcLUI0MkeKshQKYS+w/3VvA2O3kao5F654=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737401393; c=relaxed/simple;
	bh=b4Q0KNxquL/OsXsFsCaZdMCwyxMir+6H1G+h6FpFO8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6HVK98dw/rffUgYnV11Jbf6h1Azc0V38dz76X0QGf3sosslmOjiBUtHq4+eGEn7txzwDXZBW6c7b+wcO85JqhdAoVSWF8wFQadvHWqHePzk/V5Z+BmJyGFwGB1kFZs32/n3Uzc8al8Lrtu9auEBNK5X2y14vFU4FQ16OovKCKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OXnOpm7i; arc=fail smtp.client-ip=40.107.237.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjB2oAovpvjCsxQTvrxrX4MkrmsOSr9Es4oRNM7K+8ucK+Fv0JnIWmolzLbrpydkVYZaLun+7J+Ao+J7c88pmBV04siI+/GdPE/BbFMygPwtwr3c0jpOWhnevbsiTPiIATFHOjINv4zf0cE/EO8zdjnwt4WldwRThs4XkqWABezk7kHyB3OCYK0a8fyUPZ2TzShE3EZiIjqDrx6bdxXM+IQRnPNWvqd/0unHsA4haA0DelupY2Ie/BGRmD6WRkQpVDBjv2jQfWm/S79Sr3K9/c1NyKrnOaItwyykTA+w7KROQ7l5GaUKMvQNnFOKE5SCiKeUCipMS62uw0GJGJP9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4Q0KNxquL/OsXsFsCaZdMCwyxMir+6H1G+h6FpFO8o=;
 b=wpW0ARdavSTBUhxayKtRaIBk/f8sygfQmQEPGSDHNLV/UANj4DRw/2HRpHVJNFK/FypiofpPCp7uvri1N0QJFEoHIy8thB7yr36ri+wplysUKMjq/ucPxi51t4e+SzT/LP7p4/6IULftlACOJWg58X4plQTWWNvOWk7UhKyaJ+xioceQGOx87oR79IFTLA6/jDCycSLCsDVJ4zOMfvCke/TbQ7RvGFbUL/7ZDnTxtHeDAHqPJmCNWNP7UvQF0pT0n1CeznBfU1NMiS4+/mIHj8t60omuPSC3X5aYyAlatipr73y1k/f7gfRGFXNlJ9MEnEdWtyLIqb1Ts5tJN2JepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4Q0KNxquL/OsXsFsCaZdMCwyxMir+6H1G+h6FpFO8o=;
 b=OXnOpm7iDoZSFadZ0zrsyTKaNZhA7J011kWMfvN4MAsZ/DludS8Nk79vykl2ZNcUyHtcFHBu79A8zX8TFgbLwhqaKebGWeP8E3nJxIPHV71gH46h3t8gG1kHvsQ/rLD6qI1Cc6D4RpDflM69iRibTENxkZYAKDtOfNQAgIMSffs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA6PR13MB6927.namprd13.prod.outlook.com (2603:10b6:806:41a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 19:29:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 19:29:47 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "amir73il@gmail.com" <amir73il@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
Thread-Topic: [PATCH] nfsd: map EBUSY for all operations
Thread-Index: AQHba1+fzw+WkJ1joUqohuwhSceLX7Mf6qKAgAAO6wCAAAawAIAACAcAgAAEUAA=
Date: Mon, 20 Jan 2025 19:29:47 +0000
Message-ID: <f7c76f0e70762a731de62f2db67cddba79ad03d0.camel@hammerspace.com>
References: <20250120172016.397916-1-amir73il@gmail.com>
	 <c47d74711fc88bda03ef06c390ef342d00ca4cba.camel@hammerspace.com>
	 <CAOQ4uxgQbEwww8QFHo2wHMm2K2XR+UmOL3qTbr-gJuxqZxqnsQ@mail.gmail.com>
	 <9fc1d00dc27daad851f8152572764ae6fe604374.camel@hammerspace.com>
	 <CAOQ4uxiLsfK0zRGdMCqsvUzsQ05gkvQCJbsUiRcrS3o-sCPf1A@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxiLsfK0zRGdMCqsvUzsQ05gkvQCJbsUiRcrS3o-sCPf1A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA6PR13MB6927:EE_
x-ms-office365-filtering-correlation-id: defdf9d1-9861-4bd0-d840-08dd3988cd2c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2FpVnh4aGZSdXN1UWdiZHU1ajVwVWdYTFNTbHBGU3JRSDh2Z2RFMVZheFFM?=
 =?utf-8?B?M3hCT28wdFBLMUxleWtnYWJXNEZ2K3kvZysyTWE4UWtScjBtaFJDRnFwT1Zt?=
 =?utf-8?B?blMzb3pzNXlEUXdTaHk4RENvc2VCOC9qdE15bjhDMlB1em14L3FZVkd1NmM0?=
 =?utf-8?B?VlpKVmg4dFROVENkUmt2d1RFRkRkRGZGS1BMdndmNS9oTklZSnhmTXp6R09s?=
 =?utf-8?B?cFBYV0JpRlFDbFdERnhXQmI5d0ZaK2t4K25EenI3ckNUdTZndDdRUDgwV0hD?=
 =?utf-8?B?N1d3eCt1Ti9Rc2pZb09QVHB5N1V1RWhyRDN1R1dMU1dWd0g2V3VJbzI1M0ZP?=
 =?utf-8?B?M0lVMHpiQUNyRWlWSlpYczNrT0EycmZQYnp1SWNBQkVWMlRseStvR1dnVHY5?=
 =?utf-8?B?TzArNlBhdnNEbEFXRWFOalBQWkNNdW0xWlFCNFZzRUxrVldvbWtCb04xV0ho?=
 =?utf-8?B?U1NBY09CcGVsUnRXMGw1OHRZRVFzRVpla0JlcXFKYTlaVHUyOWYvZENzcWY2?=
 =?utf-8?B?STNMdmtYQTA3ZW1BQ3NuTFYvdGl2bVRrV1Vra2hYdmFoQ21BK1dSQ3BpRklB?=
 =?utf-8?B?b2pZQmUvMkFmSCsrY3h0OE5HeDErWGVLdmIwb2Vmb1FYNXhqbnp4SWZSU1E4?=
 =?utf-8?B?bm1zakMxYzV5WElsd2tIYmM4YmtRQzFBOUJBRTJKc1BDK3k3TzZYaU1lcDRp?=
 =?utf-8?B?MzUvNVVlUWRxNktEYlhJYWxXRnJLSk5jUnc5U3RJZ1dWaGk5eTFSZkVtdFhq?=
 =?utf-8?B?anFxNlROa2QveElkTVZzelNVcHlLY1o1ZWx2UGN6SGw5eUhqbmdYK2NSYnJR?=
 =?utf-8?B?cE4zWUpDelp5OFlvM2pBbGZlNTkreGpueHBES1pqc0lNM1REQmFoQzExRkxE?=
 =?utf-8?B?d3JuR2p3UisyMzJ5VWt2MUplUEd6VjVPbFQzWCsvTnBlSWpXa0xXbGZIenYr?=
 =?utf-8?B?VnlQQWRCdG1kYkF1aTk3TTYzaFRESi9RblcwNUplQlYzeFg1bGxMNGVjYXVm?=
 =?utf-8?B?T0M1dEh4aTl4Nnd0V09yd1NLeGM1QUpOQzdPQ0xuT0dyQ2hpNUtDVUZ4Vk9U?=
 =?utf-8?B?bndwZmFVS3RHVUorR2w1NjdvTWdiZS9XdTJzWHQ2VUFDUWFWbkZBR0hPbytE?=
 =?utf-8?B?MzZDZ3d5cFMxVllkUTNUUVFDaTRsTCs0NDA5dFcvYk1sckh1aXVxSXczREJx?=
 =?utf-8?B?NEY3V3lyb1FmNVNVT1hzTmdlcmw1blFSTnM4V3lRa1pqOXRoMTBZaWRMemxT?=
 =?utf-8?B?RVBZcnNLQjVnbUFvb0ZUMERhdGNXRitrM01laFQ3NmY4RmlsTG1iVTRacFMv?=
 =?utf-8?B?aWwyZTBZWEM0cHBIY2ZwZ0JUeVhNcWxyRjlZcno2aGNiUG00R1hXZzRDOXlG?=
 =?utf-8?B?ZnREY3BLb1pVTUJiMEJNZEpJeEV3UFlYZHp0eENKaXVsb3drczhvTUpsMkhp?=
 =?utf-8?B?M09lQlJSclM2cXhydTF2R09tQlJhTFVRaTlSSVBITlVXWng5czBiZkRwZVhi?=
 =?utf-8?B?ZWd0MUdiZzc1bDBad3E5cWtGLzZqUUV4UlNRMEpqSUJpc3BJNlhuNzlBK2RZ?=
 =?utf-8?B?SWs1MjRJSFNxalMwKzVqQnJyMG9FQTVRek55TG91bXZ3dDlydzQ4ZkllMjdk?=
 =?utf-8?B?aGxJRmszaW9lTVcwTSthMDNSSHU5VHExeHRWT2JUYTFCdHhZUHF6NTRTNjhU?=
 =?utf-8?B?cjgyVHV0QnFvVDl5NjErZmp5TE5la1NVemx5T3V2ZnNJSm5kU3B6cGM2aFNV?=
 =?utf-8?B?T0hUeTZzdXhxNG9VVFkxRk1JeDVzeFFrYldjc1dvcnFSZkdnb3pTR2NzSUZ4?=
 =?utf-8?B?eU9pa0hldUMwWngyUWQrQnphcGZCbnc0elUvemZYZDhOMW1jcVI4VTAxL01D?=
 =?utf-8?B?M3VaazFkcm4ralJUeVdDY1Y1eEgxaVhRUUtjMWtEaVlEOFlORFV5VTd5MmQv?=
 =?utf-8?Q?QpotaOOWkezP6NqHkFrlVpcx7Nc8tQkg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RndrY0lMTGJPL1FkcG54S3o3VzBNbGRJMlFjMkw0VlBWRG9RY2lGc1BCK2dX?=
 =?utf-8?B?elVNd0dRdktkYll0dzRMUXZ1MnlJdUtXbml5QjdYK0x2V1lEUTBTZTJTQVMr?=
 =?utf-8?B?dVFBbmR5SjVnUStaM3BySk96UTRyU0R4V2phVk5GOFJvcEVYRUFiS0N6ZWVX?=
 =?utf-8?B?bXJic1FBeWxDbnFsaGZscmw4QjVWbVZSdnhWcnh0Z1FWaE9nY0U0TmJFUlFW?=
 =?utf-8?B?U1pLVDRpd2h6d2Z4QVpGbExzaERJeG9LbWMwL2pSOWVpaTlyc25GN1d5Q2cw?=
 =?utf-8?B?K2E0ZTRwK1dIMER2WWVYK1VHOTdhRm91VzMwckMrSlRwaGFWdndxNi9WeENL?=
 =?utf-8?B?SWFNeTVxdFovQmk5bkJBZUxKVmVjcHYvY29LWStvQlBxMTIzODUzci9GSEpj?=
 =?utf-8?B?Nms0MExRbTQrVTVBdVIvL0ZsMkYrOVhrR3gvdVdhNTVVeW9CcWJtUy8welVl?=
 =?utf-8?B?Rk1oM1BQWHRiWGl5R2pUNUlKb3hGejZvZmx0alk0WVV5cmxUK216YkEzR0k2?=
 =?utf-8?B?RkRxWUtEVEVEa2tzM2Zld1psT2M1dEJjNnltYm5weGZ5SXcwWUxlam81MkRn?=
 =?utf-8?B?SVdNVTh1UVljZjhIem5PQWREZ0xhUlVCN1B3VHN4eFhsMVdITlBGN245UFhm?=
 =?utf-8?B?b1hFSlp1TUdnMzQrUkNKbmRuVjcyeXZFbENLdWY4MDVER09qM3R3MWMwdWh4?=
 =?utf-8?B?VEdEeDIvZlk1bjlCYnp5ak93djVjVlpiTGdGVmdpM1hqNjBNaUVJK1E5cTNx?=
 =?utf-8?B?aUhYTTd3MVIyeG1LTFhOQjJjQ0NnUTRNUFJOMVUzaHlXTlRKVFZCVWIrZVYy?=
 =?utf-8?B?Y1FqTkV0ZWpGR2oyQ2JFanc3M3VCRWVVU1huRVQzajA0SENSVjd1UHE1SjlO?=
 =?utf-8?B?R0NJQ3ZkU3RkckxUQ0V6aFN6ckQ5Zjh5OXdtUzVPNEdyRzFpZnpXcG5jRDA0?=
 =?utf-8?B?RlZoWm0rV1YxZWtsVEVhUDZDU3RUeUJKNGJmb09Pd29ZUnpFcFFLUW1MZGRF?=
 =?utf-8?B?Q1FMcTJuVm1vTjg1cmxaakEzT0ZWa3d6UkFKdjNxenM1ZmttQmgwMDhHNk1u?=
 =?utf-8?B?QlVDZmRKMEhQaWVOMEo5Rk9HbjhKUnR5Q3RwVlUxdVQwVmQyY3NFY0F1dHMw?=
 =?utf-8?B?MklHTVA5T1AyYTc1N05FbGJ4eDZ1RmlpVlZtWTg1Qkk4NngzcHVQNnU1TGV3?=
 =?utf-8?B?V0o0RTZGT1ZicW41dnRnYXE4dllKTjdrS2p4SWErbWhKQ2xHMUxsbGZmR05H?=
 =?utf-8?B?aGkyWW9QMnFzNThZWVlZMFVSbDc3YmNWRmNaZzRQUDcrQWpRWE1DUkJzSDlM?=
 =?utf-8?B?bGVzVGFZQWZ6cWdvSFpmaStLMThiSTdOSkZ6V1lVcXRHaUxpK2VkLzFRb2sx?=
 =?utf-8?B?Q0Y4aDd1WHBRR21BTVM1UkJ4YnRmckJUYTJNRXEyeFYwNDByWmtUeFNEdlps?=
 =?utf-8?B?VjM4TU1ZSnI3QklEUXBKODA2cGRsMUQxdExFZFhWM2JGalhvclZ4L1NYREc3?=
 =?utf-8?B?YjNoQVR4MVhSbU44SVM1VVh0SjUwVDVmbGZHbWt2UGZ4eU9acEIybkxrUjZQ?=
 =?utf-8?B?RkUzZkhZRkpVR2l5VU5NMDhhWFFyNnRrRkUzbjJWM3lZZ1IrbVJKdys1RnVL?=
 =?utf-8?B?bkFhZHlsenlHZmJpVFlVMURYMVEzSkdqNzRmYUdvSXl3V0x4M0tKTy9JUkJw?=
 =?utf-8?B?c2FCTkJjZDh3YVBPZG9xdmtqVTcrMExYTFpsYnJReU40Vkp1SkkrenBuUDZW?=
 =?utf-8?B?VlBBVk1wUUlZTm1BWGpGaG01TmFMS09aTFZQU3Q5UmVLRm00YStQVHRUZEVT?=
 =?utf-8?B?N3FLMkllTk1KOUdXNjZublpoQVcydDhVR0RvUTlmMUoyN3JLQzkwNy9FREpv?=
 =?utf-8?B?QVBjMTZycDhTcnB5RWIrMVlvaDA0QlpTaG11U1JHbDA1SURKWkx2NTZJWVFC?=
 =?utf-8?B?OTNlMzZJNTlEUTZ3cG1VTDBYQitHWEkzWjBVRHVPR0JNUlhuTjFQRkZVSnJ0?=
 =?utf-8?B?bVBSNGJ1NStnMHlYZ0JoczdoSmFhV0QvR1J2cFp5SWlkYVMxZC9BR01zZW85?=
 =?utf-8?B?VU55UW5uVmtTZ0J6ZHUwRWZPQmlTNEJYMy9NVTZJUmNIdTZYT2FKQ1ZvaTcw?=
 =?utf-8?B?R3p0dm9hSlNRTThvaDNKUHZnc0FHZ0cxdUc4WUhDMXZVZ0I0b0IwcEhiV0F6?=
 =?utf-8?B?OXV0VS9WQmUvR2N2VXNRdGZJamFDYVgwWE5ZSTB3U3ZOMnVqNHZXUmhsU1h6?=
 =?utf-8?B?bDJDNDlVL2xrZWg1QkFvYmZ5dDRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20CD3F13FE54DA479DB595FD1C1AE43D@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: defdf9d1-9861-4bd0-d840-08dd3988cd2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 19:29:47.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5p8vtEGVcO5PFZMI+EpME5Nn8jQJkbpxxk3El/yuQvXxt3zqwmzBBi5a2fXBmc9f5zHHv2FKKh/KQQmThW8fmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB6927

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDIwOjE0ICswMTAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gT24gTW9uLCBKYW4gMjAsIDIwMjUgYXQgNzo0NeKAr1BNIFRyb25kIE15a2xlYnVzdA0KPiA8
dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyNS0w
MS0yMCBhdCAxOToyMSArMDEwMCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6DQo+ID4gPiBPbiBNb24s
IEphbiAyMCwgMjAyNSBhdCA2OjI44oCvUE0gVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA8dHJvbmRt
eUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gTW9uLCAyMDI1
LTAxLTIwIGF0IDE4OjIwICswMTAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gPiA+ID4gPiB2
NCBjbGllbnQgbWFwcyBORlM0RVJSX0ZJTEVfT1BFTiA9PiBFQlVTWSBmb3IgYWxsIG9wZXJhdGlv
bnMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gdjQgc2VydmVyIG9ubHkgbWFwcyBFQlVTWSA9PiBO
RlM0RVJSX0ZJTEVfT1BFTiBmb3INCj4gPiA+ID4gPiBybWRpcigpL3VubGluaygpDQo+ID4gPiA+
ID4gYWx0aG91Z2ggaXQgaXMgYWxzbyBwb3NzaWJsZSB0byBnZXQgRUJVU1kgZnJvbSByZW5hbWUo
KSBmb3INCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBzYW1lDQo+ID4gPiA+ID4gcmVhc29uICh2
aWN0aW0gaXMgYSBsb2NhbCBtb3VudCBwb2ludCkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRmls
ZXN5c3RlbXMgY291bGQgcmV0dXJuIEVCVVNZIGZvciBvdGhlciBvcGVyYXRpb25zLCBzbyBqdXN0
DQo+ID4gPiA+ID4gbWFwDQo+ID4gPiA+ID4gaXQNCj4gPiA+ID4gPiBpbiBzZXJ2ZXIgZm9yIGFs
bCBvcGVyYXRpb25zLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXIg
R29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gQ2h1Y2ssDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSByYW4gaW50byB0aGlz
IGVycm9yIHdpdGggYSBGVVNFIGZpbGVzeXN0ZW0gYW5kIHJldHVybnMgLQ0KPiA+ID4gPiA+IEVC
VVNZDQo+ID4gPiA+ID4gb24NCj4gPiA+ID4gPiBvcGVuLA0KPiA+ID4gPiA+IGJ1dCBJIG5vdGlj
ZWQgdGhhdCB2ZnMgY2FuIGFsc28gcmV0dXJuIEVCVVNZIGF0IGxlYXN0IGZvcg0KPiA+ID4gPiA+
IHJlbmFtZSgpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gPiBBbWly
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgZnMvbmZzZC92ZnMuYyB8IDEwICsrLS0tLS0tLS0N
Cj4gPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25z
KC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvdmZzLmMgYi9m
cy9uZnNkL3Zmcy5jDQo+ID4gPiA+ID4gaW5kZXggMjljYjdiODEyZDcxMy4uYTYxZjk5YzA4MTg5
NCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9mcy9uZnNkL3Zmcy5jDQo+ID4gPiA+ID4gKysrIGIv
ZnMvbmZzZC92ZnMuYw0KPiA+ID4gPiA+IEBAIC0xMDAsNiArMTAwLDcgQEAgbmZzZXJybm8gKGlu
dCBlcnJubykNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7IG5mc2Vycl9w
ZXJtLCAtRU5PS0VZIH0sDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeyBu
ZnNlcnJfbm9fZ3JhY2UsIC1FTk9HUkFDRX0sDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgeyBuZnNlcnJfaW8sIC1FQkFETVNHIH0sDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB7IG5mc2Vycl9maWxlX29wZW4sIC1FQlVTWX0sDQo+ID4gPiA+ID4gwqDC
oMKgwqDCoCB9Ow0KPiA+ID4gPiA+IMKgwqDCoMKgwqAgaW50wqDCoMKgwqAgaTsNCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBAQCAtMjAwNiwxNCArMjAwNyw3IEBAIG5mc2RfdW5saW5rKHN0cnVjdCBz
dmNfcnFzdCAqcnFzdHAsDQo+ID4gPiA+ID4gc3RydWN0DQo+ID4gPiA+ID4gc3ZjX2ZoICpmaHAs
IGludCB0eXBlLA0KPiA+ID4gPiA+IMKgb3V0X2Ryb3Bfd3JpdGU6DQo+ID4gPiA+ID4gwqDCoMKg
wqDCoCBmaF9kcm9wX3dyaXRlKGZocCk7DQo+ID4gPiA+ID4gwqBvdXRfbmZzZXJyOg0KPiA+ID4g
PiA+IC3CoMKgwqDCoCBpZiAoaG9zdF9lcnIgPT0gLUVCVVNZKSB7DQo+ID4gPiA+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBuYW1lIGlzIG1vdW50ZWQtb24uIFRoZXJlIGlzIG5vIHBl
cmZlY3QNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBlcnJvciBzdGF0
dXMuDQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4gPiA+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBuZnNlcnJfZmlsZV9vcGVuOw0KPiA+ID4g
PiA+IC3CoMKgwqDCoCB9IGVsc2Ugew0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZXJyID0gbmZzZXJybm8oaG9zdF9lcnIpOw0KPiA+ID4gPiA+IC3CoMKgwqDCoCB9DQo+ID4g
PiA+ID4gK8KgwqDCoMKgIGVyciA9IG5mc2Vycm5vKGhvc3RfZXJyKTsNCj4gPiA+ID4gPiDCoG91
dDoNCj4gPiA+ID4gPiDCoMKgwqDCoMKgIHJldHVybiBlcnI7DQo+ID4gPiA+ID4gwqBvdXRfdW5s
b2NrOg0KPiA+ID4gPiANCj4gPiA+ID4gSWYgdGhpcyBpcyBhIHRyYW5zaWVudCBlcnJvciwgdGhl
biBpdCB3b3VsZCBzZWVtIHRoYXQNCj4gPiA+ID4gTkZTNEVSUl9ERUxBWQ0KPiA+ID4gPiB3b3Vs
ZCBiZSBtb3JlIGFwcHJvcHJpYXRlLg0KPiA+ID4gDQo+ID4gPiBJdCBpcyBub3QgYSB0cmFuc2ll
bnQgZXJyb3IsIG5vdCBpbiB0aGUgY2FzZSBvZiBhIGZ1c2UgZmlsZSBvcGVuDQo+ID4gPiAoaXQg
aXMgYnVzeSBhcyBpbiBsb2NrZWQgZm9yIGFzIGxvbmcgYXMgaXQgaXMgZ29pbmcgdG8gYmUgbG9j
a2VkKQ0KPiA+ID4gYW5kIG5vdCBpbiB0aGUgY2FzZSBvZiBmYWlsdXJlIHRvIHVubGluay9yZW5h
bWUgYSBsb2NhbA0KPiA+ID4gbW91bnRwb2ludC4NCj4gPiA+IE5GUzRFUlJfREVMQVkgd2lsbCBj
YXVzZSB0aGUgY2xpZW50IHRvIHJldHJ5IGZvciBhIGxvbmcgdGltZT8NCj4gPiA+IA0KPiA+ID4g
PiBORlM0RVJSX0ZJTEVfT1BFTiBpcyBub3Qgc3VwcG9zZWQgdG8gYXBwbHkNCj4gPiA+ID4gdG8g
ZGlyZWN0b3JpZXMsIGFuZCBzbyBjbGllbnRzIHdvdWxkIGJlIHZlcnkgY29uZnVzZWQgYWJvdXQg
aG93DQo+ID4gPiA+IHRvDQo+ID4gPiA+IHJlY292ZXIgaWYgeW91IHdlcmUgdG8gcmV0dXJuIGl0
IGluIHRoaXMgc2l0dWF0aW9uLg0KPiA+ID4gDQo+ID4gPiBEbyB5b3UgbWVhbiBzcGVjaWZpY2Fs
bHkgZm9yIE9QRU4gY29tbWFuZCwgYmVjYXVzZSBjb21taXQNCj4gPiA+IDQ2NmUxNmYwOTIwZjMg
KCJuZnNkOiBjaGVjayBmb3IgRUJVU1kgZnJvbSB2ZnNfcm1kaXIvdmZzX3VuaW5rLiIpDQo+ID4g
PiBhZGRlZCB0aGUgTkZTNEVSUl9GSUxFX09QRU4gcmVzcG9uc2UgZm9yIGRpcmVjdG9yaWVzIGZp
dmUgeWVhcnMNCj4gPiA+IGFnbyBhbmQgdmZzX3JtZGlyIGNhbiBjZXJ0YWlubHkgcmV0dXJuIGEg
bm9uLXRyYW5zaWVudCBFQlVTWS4NCj4gPiA+IA0KPiA+IA0KPiA+IEknbSBzYXlpbmcgdGhhdCBj
bGllbnRzIGV4cGVjdCBORlM0RVJSX0ZJTEVfT1BFTiB0byBiZSByZXR1cm5lZCBpbg0KPiA+IHJl
c3BvbnNlIHRvIExJTkssIFJFTU9WRSBvciBSRU5BTUUgb25seSBpbiBzaXR1YXRpb25zIHdoZXJl
IHRoZQ0KPiA+IGVycm9yDQo+ID4gaXRzZWxmIGFwcGxpZXMgdG8gYSByZWd1bGFyIGZpbGUuDQo+
IA0KPiBUaGlzIGlzIHZlcnkgZmFyIGZyb20gd2hhdCB1cHN0cmVhbSBuZnNkIGNvZGUgaW1wbGVt
ZW50cyAoc2luY2UgMjAxOSkNCj4gMS4gb3V0IG9mIHRoZSBhYm92ZSwgb25seSBSRU1PVkUgcmV0
dXJucyBORlM0RVJSX0ZJTEVfT1BFTg0KPiAyLiBORlM0RVJSX0ZJTEVfT1BFTiBpcyBub3QgbGlt
aXRlZCB0byBub24tZGlyDQo+IDMuIE5GUzRFUlJfRklMRV9PUEVOIGlzIG5vdCBsaW1pdGVkIHRv
IHNpbGx5IHJlbmFtZWQgZmlsZSAtDQo+IMKgwqDCoCBpdCB3aWxsIGFsc28gYmUgdGhlIHJlc3Bv
bnNlIGZvciB0cnlpbmcgdG8gcm1kaXIgYSBtb3VudCBwb2ludA0KPiDCoMKgwqAgb3IgdHJ5aW5n
IHRvIHVubGluayBhIGZpbGUgd2hpY2ggaXMgYSBiaW5kIG1vdW50IHBvaW50DQoNCkZhaXIgZW5v
dWdoLiBJIGJlbGlldmUgdGhlIG5hbWUgZ2l2ZW4gdG8gdGhpcyBraW5kIG9mIHNlcnZlciBiZWhh
dmlvdXINCmlzICJidWciLg0KDQo+IA0KPiA+IFRoZSBwcm90b2NvbCBzYXlzIHRoYXQgdGhlIGNs
aWVudCBjYW4gZXhwZWN0IHRoaXMgcmV0dXJuIHZhbHVlIHRvDQo+ID4gbWVhbg0KPiA+IGl0IGlz
IGRlYWxpbmcgd2l0aCBhIHNlcnZlciB3aXRoIFdpbmRvd3MtbGlrZSBzZW1hbnRpY3MgdGhhdA0K
PiA+IGRvZXNuJ3QNCj4gPiBhbGxvdyB0aGVzZSBwYXJ0aWN1bGFyIG9wZXJhdGlvbnMgd2hpbGUg
dGhlIGZpbGUgaXMgYmVpbmcgaGVsZA0KPiA+IG9wZW4uIEl0DQo+ID4gc2F5cyBub3RoaW5nIGFi
b3V0IGV4cGVjdGluZyB0aGUgc2FtZSBiZWhhdmlvdXIgZm9yIG1vdW50cG9pbnRzLA0KPiA+IGFu
ZA0KPiA+IHNpbmNlIHRoZSBsYXR0ZXIgaGF2ZSBhIHZlcnkgZGlmZmVyZW50IGxpZmUgY3ljbGUg
dGhhbiBmaWxlIG9wZW4NCj4gPiBzdGF0ZQ0KPiA+IGRvZXMsIHlvdSBzaG91bGQgbm90IHRyZWF0
IHRob3NlIGNhc2VzIGFzIGJlaW5nIHRoZSBzYW1lLg0KPiANCj4gVGhlIHR3byBjYXNlcyBhcmUg
Y3VycmVudGx5IGluZGlzdGluZ3Vpc2hhYmxlIGluIG5mc2RfdW5saW5rKCksIGJ1dA0KPiBpdCBj
b3VsZCBjaGVjayBEQ0FDSEVfTkZTRlNfUkVOQU1FRCBmbGFnIGlmIHdlIHdhbnQgdG8NCj4gbGlt
aXQgTkZTNEVSUl9GSUxFX09QRU4gdG8gdGhpcyBzcGVjaWZpYyBjYXNlIC0gYWdhaW4sIHRoaXMg
aXMNCj4gdXBzdHJlYW0gY29kZSAtIG5vdGhpbmcgdG8gZG8gd2l0aCBteSBwYXRjaC4NCj4gDQo+
IEZXSVcsIG15IG9ic2VydmVkIGJlaGF2aW9yIG9mIExpbnV4IG5mcyBjbGllbnQgZm9yIHRoaXMg
ZXJyb3INCj4gaXMgYWJvdXQgMSBzZWNvbmQgcmV0cmllcyBhbmQgZmFpbHVyZSB3aXRoIC1FQlVT
WSwgd2hpY2ggaXMgZmluZQ0KPiBmb3IgbXkgdXNlIGNhc2UsIGJ1dCBpZiB5b3UgdGhpbmsgdGhl
cmUgaXMgYSBiZXR0ZXIgZXJyb3IgdG8gbWFwDQo+IEVCVVNZIGl0J3MgZmluZSB3aXRoIG1lLiBu
ZnN2MyBtYXBzIGl0IHRvIEVBQ0NFUyBhbnl3YXkuDQo+IA0KPiANCg0KV2hlbiBkb2luZ8KgTElO
SywgUkVOQU1FLCBSRU1PVkUgb24gYSBtb3VudCBwb2ludCwgSSdkIHN1Z2dlc3QgcmV0dXJuaW5n
DQpORlM0RVJSX1hERVYsIHNpbmNlIHRoYXQgaXMgbGl0ZXJhbGx5IGEgY2FzZSBvZiB0cnlpbmcg
dG8gcGVyZm9ybSB0aGUNCm9wZXJhdGlvbiBhY3Jvc3MgYSBmaWxlc3lzdGVtIGJvdW5kYXJ5Lg0K
DQpPdGhlcndpc2UsIHNpbmNlIExpbnV4IGRvZXNuJ3QgaW1wbGVtZW50IFdpbmRvd3MgYmVoYXZp
b3VyIHcuci50LiBsaW5rLA0KcmVuYW1lIG9yIHJlbW92ZSwgaXQgd291bGQgc2VlbSB0aGF0IE5G
UzRFUlJfQUNDRVNTIGlzIGluZGVlZCB0aGUgbW9zdA0KYXBwcm9wcmlhdGUgZXJyb3IsIG5vPyBJ
dCdzIGNlcnRhaW5seSB0aGUgcmlnaHQgYmVoYXZpb3VyIGZvcg0Kc2lsbHlyZW5hbWVkIGZpbGVz
Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

