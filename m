Return-Path: <linux-fsdevel+bounces-27466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB84961A01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4381C22954
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001A71D3629;
	Tue, 27 Aug 2024 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KXNdVldP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2127.outbound.protection.outlook.com [40.107.94.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE419D093;
	Tue, 27 Aug 2024 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724797490; cv=fail; b=MFggsokPVOsw5i+D+bKlMu6q+xiEbVnNUgOswCQBdRjkUkRgYSMyc2mbahh+zN5IafFEntA/y8rAdOy2wVPb6WT76BGU3Fb2mV5T7Kg8TxYrfigYhY2VsL2CkT2Ta5wv+//HIM8pSn+aYVOZlbl/g4V6SXsiEkZHr7UDZsDNOeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724797490; c=relaxed/simple;
	bh=5XSqLiaiXX0nTO1F3u7proBRDvOd48HpO/mfES2eVLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q0U2ofbhnKzgqx5cxpEJbnAZN/riNQTmqrRHh8WYE0Hmq/+ic+hW9WcKgwjPmxHEenbevZPqYBxneNlpQM/y3dh2zTAK8meVEyFsJjWkXxcgpjp+/kzqEprXDqes4E5aMFzlYmSLiOQO9dq0MN1zgDDl07/ekSaiFuWH/PWje+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KXNdVldP; arc=fail smtp.client-ip=40.107.94.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hs+oxIeuHK1ZU14wCCQWoi80kP+MZBjcPsiuvycI56k1n/PePKdnVDCJUHX9m+3JB1rOhAFldNeF8sp6VwFEGBbcOPv617X/KyGb4LqhonzOFy6ikElqYFCJZOrbZ+/hymT2z1UWKtrNgE8xxWVGGVYJCxe8LYxCQ58xQUzV5I/AvviOCQjHQqUz0vzJQW+rlYZJQjr1M7NSo3906KKRbSqnDpbQlLEspVp0uahBcEZvXMnDMAyFWE4rDGr5qU3XTPU4D1ULZV+KUao/0Xi/yhlIuBm1DJEOLX1n0LrotsPlt9Ui7vTP/oh4gUw8V42IrvlKHpgkrPNJJyHH0vUSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XSqLiaiXX0nTO1F3u7proBRDvOd48HpO/mfES2eVLU=;
 b=RS3bwHQwr70cIfNAqcn/wXByTehjSOGu2m7Ij04KELw8ZVHtggmZyxlAvyKv+Zh+3TcDDtInZv7Ayvku8gzhQZrT3WeDayink4beKcCiEjzaBGv5S+97UMd6CX5slImNPWTGsM95Lv/xynQQ47hGVoguklFSMqJG1dYJGDOz5mfJT1TAR0zpmb+vH6Li5fwwIGvjxX4ZgzVh7Coi+06VFY8LpbdyMaNPwHL36JcN1CeFl1XFBo090HQ17OKXau3w++232lwTLxyfiEfLh7wUwcETP/PPURqWjARPHz5mA8k1BPGHNIetRUVyoz6z2fHNwcPqBOq6IT3M07b3QyZ4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XSqLiaiXX0nTO1F3u7proBRDvOd48HpO/mfES2eVLU=;
 b=KXNdVldPbJ/gz1nz4RHn0TmmqaWxzV3bWB8vnXKHzlqqxW4eZO6EX5yi4BiKCMfgpUhcmDPyRqJKz3SLVRKVTaWrdCtRfL4Euarszr2Yq5K3MtTkG+xTe9fQg7/rQmaVtY2AxfOGrJpobLpYes00ArgNbUOos/mNLGzVHXVIwt4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4132.namprd13.prod.outlook.com (2603:10b6:5:2ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 22:24:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 22:24:42 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "neilb@suse.de" <neilb@suse.de>
CC: "anna@kernel.org" <anna@kernel.org>, "snitzer@kernel.org"
	<snitzer@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Thread-Topic: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Thread-Index: AQHa9YhbSZns7TD6R0iwTEu+CeGCcLI4y2iAgADOoQCAAAl5gIACB1+AgAAJ3gA=
Date: Tue, 27 Aug 2024 22:24:42 +0000
Message-ID: <aec659a886f7da3beded2b0ecce452e1599f9adc.camel@hammerspace.com>
References: <>	,
 <85bc01d0e200ead4c20560db1ecb731f7800e918.camel@hammerspace.com>
	 <172479536130.11014.15773937499235867355@noble.neil.brown.name>
In-Reply-To: <172479536130.11014.15773937499235867355@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB4132:EE_
x-ms-office365-filtering-correlation-id: a853d619-ad66-4a6c-2e88-08dcc6e70c46
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmVKSEJmU2tvUW5tMXdUMks3ckFkSkJmWWVTT2NZK2YvazhCY01DMDZONzI0?=
 =?utf-8?B?RGhESXJzR2NobXc2OERlb2ZFanJ2VUFiaStTSm55UTkyYmNZaFI2cjc5Z1dJ?=
 =?utf-8?B?dGZzRTBIci9DeGkzSW54am1qclZyZzliUURxOWIybUFYT1JrN3l0RXFibEVM?=
 =?utf-8?B?cUQxaktLcGU0aDhYM1lxTjB6Z1NvcFh2d1JZNzNCVXdESGFGWVoxdGtXUkV1?=
 =?utf-8?B?akw0ZDRqM2g2QnZxZ29NSG9LN1l6V0RkbTdYbzMyekFUTy9tN25yYkQ1T011?=
 =?utf-8?B?d1lmUC9PaFFmdFgySVkwZFdrKzZja0FZV1ZNQXF2NkhlbHJ2SHhJZ243ZFF4?=
 =?utf-8?B?ZU1UK0QwL3FCWGFkUGF1MTEyeE11OStPc0pTRlIrRVlvcGxHY1E2dTliMTdr?=
 =?utf-8?B?YXpYMWZ4bUxkUjhBQTlUbnF4ZStydVd3a2kyTU43aUx4aFVUa241N0t0VStX?=
 =?utf-8?B?QWVyRWZrQ2l1Sy9hOTAvay9JT3RiZ3NIS0YvZmhJYXJaUityOHhhUG9aUFN5?=
 =?utf-8?B?UERVcG5qQ0VWOXV2QWNjaE1nRzdyLzUzcnVUMFBPdmczdWJmWGo0ejdlTGpY?=
 =?utf-8?B?RFdVVmNkMjBUa2V3R1hwdHB1SnhRK29lZmVzM2hPcGdCTHJIcmpWZVBUVVVL?=
 =?utf-8?B?U24rUitBN09zY0V1SmxZQ0o1ekVFc0tQcTR0OGlBZnVVUGVVMEJ1MUpYNGJq?=
 =?utf-8?B?ZW9OYmh0WHErYlBOTGlackhGSld2UHZsMXNGZHdxckhxS3FKUmZIYWtJTGIy?=
 =?utf-8?B?RC9WTnREU1pGMTZHczQ1TDlLVFRkMy82WkRaRDVjOUtqc2llTlBId0JSVXND?=
 =?utf-8?B?ZmxSNmxPYk5HZ25oWDJIU0ZjVjhPVkxzYmJuWVJpZ1BQRElZNXVnSlppNm5T?=
 =?utf-8?B?Q2pMcEp4c3BSMzgyMU55VDFwMkZabnY4QTZvcitkS2dBSFpHMmdTUDhpRWND?=
 =?utf-8?B?S2Z0OFFjL0tva2hDZHh6VHNPQmdIU3RneSszcHJsOW00b2hyMWdyRVRqNVhV?=
 =?utf-8?B?SCsyK1hxRkxhMGhLNEtTSWI2MWNZVXpQS1hoeWFWQ1c5MlE4QlErYUp3M29Q?=
 =?utf-8?B?UG9rV3FJN3h0S0c5Z0R3R0RaWFBrc3M4ZlRKZDNCTTVkUjkycVRNOTN6STRP?=
 =?utf-8?B?NjBlNHhwREdWQ00rSThOUTNCUE5oOHVGNUZ6WUZYOG56L3R0YkxKZGJGWlcv?=
 =?utf-8?B?cVpyREhvZmFEcHVSYlV6Zzh5OElSWW40aTFmeDBqVThaY1dTSzZSSkc1Mmhn?=
 =?utf-8?B?ZXJwUE8xSTZGeURyYzhSUDBBZEk0RFY4NEt3T1FrK2FkVWpjVFhsSUtYQ2dr?=
 =?utf-8?B?Szh2MDl6Ym0yM0VSRGZQRWE0RVRVYUo4a3lxbUhLanIzelo2R0w2NWw0RnBz?=
 =?utf-8?B?dmo4eHBjK21FZ2NjbFFiL1h4UCtwQzZVelFtNDk0LzRvcW0wc044VnZ1N09R?=
 =?utf-8?B?R0MvejkvbmRTbkZvY3p0M0JSWk9UL2ZQeUZrZHcrTGpSdVZFalFvaVhjTWVj?=
 =?utf-8?B?UUx4UXVMN1drS0hQT3hTUkVmMDJ6cXY3ei9VQWxOZHJDT0NPcjZ4R2R5UVJV?=
 =?utf-8?B?UjdYQlB0cU9Ja01qYmdGU0lSUzMrV0gwbDlMM1A2YWdZV2ppTG9RUmd4VWlp?=
 =?utf-8?B?aHQxcnJTWUg0UDBnT3JoY08rQXZUZTMrcmdNVnZOWXVwMk85TUZaUWc4UGkx?=
 =?utf-8?B?YU5hWjFzM0RtcVZKdXg3UUdaQTREeW9PNVpEVEs5QkIzUElLZG8yYlRmMWl2?=
 =?utf-8?B?MlBGaktrYVM1aGY3SCtLQ1BxT0JienFqOVBEUWlKN1RuOVFmOXhtdVI3WStF?=
 =?utf-8?B?RGoybkVtcERwVHk1eGQ4ZHRxTy9ETmJpc0d2NCtuSzFPWEp1bTZOek5mSGtN?=
 =?utf-8?B?eXl0a2VQRlJ2SmdGZ1o3QjlWUzNETmZDNjlTUnRjTEdsQ0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aU5seEhGTk04aHZ3NnNoRlc3TVZIWGJmNmUxN2VSeHBPeWZSZjNMa3BJNmhm?=
 =?utf-8?B?MkdJekJ5Vmt4SmdtUTQrT0tPWXYrc0EyR0drbWt3UithV2U4VVQ2dFE1d1RC?=
 =?utf-8?B?dHQ0MDNJaFVMZ01XczhkL3ZZVnM2d0MvSUFibHI1TkVhUTAvUzRNUzRXODV2?=
 =?utf-8?B?WnI4NU4wR0pHMWc0MU1RRXQybG05eGlQR0hJcWZGa0RLd2xCaE0zdE5OQ1FF?=
 =?utf-8?B?cHl3QnZ6Q2hNRmpybkRNQ1dGbEtSYXJTOGdrOUVJM09Wc2tZYUZSYlhDREZG?=
 =?utf-8?B?bE1KN0doUTBJN1pyQktqdkt0NndGL2ZiR0RKeVg3eW1DSGZ6YlNSU1g0US9P?=
 =?utf-8?B?aHp1eForM0hPWjcrTHd0anJlTmVoV0FKRnAxT20zdnpENGR1Q2xxamNWUSsv?=
 =?utf-8?B?VnBlaHVRa05IU2t3L3dIMEtIa0NVQ05hdkdjSkc4d1JqbFI0L04wZWR2eWJz?=
 =?utf-8?B?OVltWGVFVTR1aEhoT1ZReVZxd3M2UjNJMW9TZ3FwRGRuc2FRN09IVEJlUDky?=
 =?utf-8?B?Q01MM2pUUHVCOHI1RTZxVG5PcU9VOGU4R2FXL2F2R29hTWV1YjNkemRYRUhV?=
 =?utf-8?B?aG5Jb045K3RIY2pHbXMxa0EyTGI3eDJrcTNHak5xZ3BLd0FBZ1dwOXFkckJM?=
 =?utf-8?B?Q25kNkpMcU51dFR1bWRmejE2U1dzc095eWxlMnRha2pBRUNhOVBISWVrV0x3?=
 =?utf-8?B?elZRV3hGLzhSOXljYUExNWxYR3BxSWVuRVBhMzhMS3lZYkhaSFlGZXBXQTJR?=
 =?utf-8?B?Vlk3NFRpVm5CMFdiTjVQNm5pUFBCbzJjSWdmTUwxMVkzVVFQSDFOQ2k2clJr?=
 =?utf-8?B?NWdLeXEza05odGExWGZSclI1ZnlOQ05Fa0FteTNDM1Z1ZlZlVzMvUlJlenJn?=
 =?utf-8?B?WDJtenlucFU1VVZqN0pXRUtxUnJrelc5SklqRm1lbThOTDlSeS9PWi9nbks4?=
 =?utf-8?B?aGVUaDFrd2x1OVNReE9PNDlTMjJBUXpjWWpNV2tsMEpQVTFHT1AyZW8vR3Uz?=
 =?utf-8?B?K1grcXJIeHAybmN4bEQvSnR1WUhtZ0hqM1NBOXlVVFlRaThEZnFObDNoRXoy?=
 =?utf-8?B?cU56L2E0SEpUajRVV05WWHZpV2RDdzdIRUNxRVpsSUYvK0doZmtOaGtWUTFZ?=
 =?utf-8?B?WllrQWRtNXBwelFKc1VvWGJ3bm1TT296T2FFdEVxbUZIdUVJQmFmQTJVN2E4?=
 =?utf-8?B?TFFnQzNZRVkxa1FaUlk2aExLcUdIeE1HbXRXYmZwekFGdmdwQzUwYzV3L3hs?=
 =?utf-8?B?ZzU3K3FaalVQY093MWxsdjN6R0VzUTZHZUZUejNUNUJIOW9jU2MyVzVMME1h?=
 =?utf-8?B?QnByOE13aVlYZS81TkZXd09KQWxONU1qb1hHYzE3SlB3OUljWHJHdmlYT3p6?=
 =?utf-8?B?OXVlbGcwRGRhanpBUGFzd1J0cW9HTmJIbU4vNmFjTTlZRjFHbnN1elVKTmRs?=
 =?utf-8?B?M293amRxK2Y0QjcwalhyZHhmNTlHb1g2dDdlQ0U3VzVQKytUU0pocDZjWU9x?=
 =?utf-8?B?d0pLc3pOSXZVN1JHYXdZTGFpdFVRT01QcFM2eHV0bmV0ZkR1RlBITjg2d2Q3?=
 =?utf-8?B?ZUd4UHZGdlI2WVpBWmhmWUhVU3cvS2NCcytOSlQ5N3gzTFJaaGU1U1FsOHAy?=
 =?utf-8?B?SGgvZndzZXcvblZ0RVkreko3d3dHS3F5K0x1OVNaNUhybG1BRHc5YlRib0Zu?=
 =?utf-8?B?d2lwVmRsWE9TTUhpTFJnNHh2Um5FOFNVajRzRFN6QlhNbGl1c0VZZThVV3dZ?=
 =?utf-8?B?R2xpakJBeUhjeUJyZHY2NTV0RkxFYlJHMGI3TlBMV0YxOTN2dUNydnBaTk9o?=
 =?utf-8?B?MTRMNk9TWTEzdDBZeGRzVXpjQWNLQ3NwSy9LUFNXNE5zYkZHdFZnRDhOTFYv?=
 =?utf-8?B?QlVzV0lyU3lTU2F1WU9nOWJYMUJkNXhvVnQyQlNndHAvdUFXTUNUUElac2pr?=
 =?utf-8?B?MGtsR20vNFpGa1VUTGNDbDFkSW95dFdXdzU2RzV2dCtZYUtoZDVMdnVZeU1M?=
 =?utf-8?B?SHRscVpsL2NLWjl4N0VZeldFZktiVnl2WXR6N2dmSGVaYncvL2V2UVNndk05?=
 =?utf-8?B?TDlJZWtWZjZHZkpYWVVZb0pucTVQUlNCR2VBeVZJajZCS0hPU0svODQvcUZV?=
 =?utf-8?B?ajhMeXYwMHdvd3c5ZWpHcHlrbW0vQnd4a2RGaEZFOTZoSUF4OTVsTG5JdVUv?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0CDCB9ED2F9BE48A0441CF7DC6D4080@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a853d619-ad66-4a6c-2e88-08dcc6e70c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 22:24:42.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaJrnyPDjycf23sB+4kyU+v21w07QnKBPzev//sqaWg5J18S14vUnk2fbJ2UP6lOnkH/D/ynPpqEgTANpnnfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4132

T24gV2VkLCAyMDI0LTA4LTI4IGF0IDA3OjQ5ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMjcgQXVnIDIwMjQsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiA+IE9uIEF1ZyAyNSwgMjAyNCwgYXQgOTo1NuKAr1BNLCBOZWlsQnJvd24gPG5laWxi
QHN1c2UuZGU+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gV2hpbGUgSSdtIG5vdCBhZHZvY2F0
aW5nIGZvciBhbiBvdmVyLXRoZS13aXJlIHJlcXVlc3QgdG8gbWFwIGENCj4gPiA+ID4gZmlsZWhh
bmRsZSB0byBhIHN0cnVjdCBuZnNkX2ZpbGUqLCBJIGRvbid0IHRoaW5rIHlvdSBjYW4NCj4gPiA+
ID4gY29udmluY2luZ2x5DQo+ID4gPiA+IGFyZ3VlIGFnYWluc3QgaXQgd2l0aG91dCBjb25jcmV0
ZSBwZXJmb3JtYW5jZSBtZWFzdXJlbWVudHMuDQo+ID4gPiANCj4gPiANCj4gPiBXaGF0IGlzIHRo
ZSB2YWx1ZSBvZiBkb2luZyBhbiBvcGVuIG92ZXIgdGhlIHdpcmU/IFdoYXQgYXJlIHlvdQ0KPiA+
IHRyeWluZw0KPiA+IHRvIGFjY29tcGxpc2ggdGhhdCBjYW4ndCBiZSBhY2NvbXBsaXNoZWQgd2l0
aG91dCBnb2luZyBvdmVyIHRoZQ0KPiA+IHdpcmU/DQo+IA0KPiBUaGUgYWR2YW50YWdlIG9mIGdv
aW5nIG92ZXIgdGhlIHdpcmUgaXMgYXZvaWRpbmcgY29kZSBkdXBsaWNhdGlvbi4NCj4gVGhlIGNv
c3QgaXMgbGF0ZW5jeS7CoCBPYnZpb3VzbHkgdGhlIGdvYWwgb2YgTE9DQUxJTyBpcyB0byBmaW5k
IHRob3NlDQo+IHBvaW50cyB3aGVyZSB0aGUgbGF0ZW5jeSBzYXZpbmcganVzdGlmaWVzIHRoZSBj
b2RlIGR1cGxpY2F0aW9uLg0KPiANCj4gV2hlbiBvcGVuaW5nIHdpdGggQVVUSF9VTklYIHRoZSBj
b2RlIGR1cGxpY2F0aW9uIHRvIGRldGVybWluZSB0aGUNCj4gY29ycmVjdCBjcmVkZW50aWFsIGlz
IHNtYWxsIGFuZCBlYXN5IHRvIHJldmlldy7CoCBJZiB3ZSBldmVyIHdhbnRlZCB0bw0KPiBzdXBw
b3J0IEtSQjUgb3IgVExTIEkgd291bGQgYmUgYSBsb3QgbGVzcyBjb21mb3J0YWJsZSBhYm91dCBy
ZXZpZXdpbmcNCj4gdGhlIGNvZGUgZHVwbGljYXRpb24uDQo+IA0KPiBTbyBJIHRoaW5rIGl0IGlz
IHdvcnRoIGNvbnNpZGVyaW5nIHdoZXRoZXIgYW4gb3Zlci10aGUtd2lyZSBvcGVuIGlzDQo+IHJl
YWxseSBhbGwgdGhhdCBjb3N0bHkuwqAgQXMgSSBub3RlZCB3ZSBhbHJlYWR5IGhhdmUgYW4gb3Zl
ci10aGUtd2lyZQ0KPiByZXF1ZXN0IGF0IG9wZW4gdGltZS7CoCBXZSBjb3VsZCBjb25jZWl2YWJs
eSBzZW5kIHRoZSBMT0NBTElPLU9QRU4NCj4gcmVxdWVzdCBhdCB0aGUgc2FtZSB0aW1lIHNvIGFz
IG5vdCB0byBhZGQgbGF0ZW5jeS7CoCBXZSBjb3VsZCByZWNlaXZlDQo+IHRoZQ0KPiByZXBseSB0
aHJvdWdoIHRoZSBpbi1rZXJuZWwgYmFja2NoYW5uZWwgc28gdGhlcmUgaXMgbm8gUlBDIHJlcGx5
Lg0KPiANCj4gVGhhdCBtaWdodCBhbGwgYmUgdG9vIGNvbXBsZXggYW5kIG1pZ2h0IG5vdCBiZSBq
dXN0aWZpZWQuwqAgTXkgcG9pbnQNCj4gaXMNCj4gdGhhdCBJIHRoaW5rIHRoZSB0cmFkZS1vZmZz
IGFyZSBzdWJ0bGUgYW5kIEkgdGhpbmsgdGhlIEZBUSBhbnN3ZXINCj4gY3V0cw0KPiBvZmYgYW4g
YXZlbnVlIHRoYXQgaGFzbid0IHJlYWxseSBiZWVuIGV4cGxvcmVkLg0KPiANCg0KU28sIHlvdXIg
YXJndW1lbnQgaXMgdGhhdCBpZiB0aGVyZSB3YXMgYSBoeXBvdGhldGljYWwgc2l0dWF0aW9uIHdo
ZXJlDQp3ZSB3YW50ZWQgdG8gYWRkIGtyYjUgb3IgVExTIHN1cHBvcnQsIHRoZW4gd2UnZCBoYXZl
IG1vcmUgY29kZSB0bw0KcmV2aWV3Pw0KDQpUaGUgY291bnRlci1hcmd1bWVudCB3b3VsZCBiZSB0
aGF0IHdlJ3ZlIGFscmVhZHkgZXN0YWJsaXNoZWQgdGhlIHJpZ2h0DQpvZiB0aGUgY2xpZW50IHRv
IGRvIEkvTyB0byB0aGUgZmlsZS4gVGhpcyB3aWxsIGFscmVhZHkgaGF2ZSBiZWVuIGRvbmUNCmJ5
IGFuIG92ZXItdGhlLXdpcmUgY2FsbCB0byBPUEVOIChORlN2NCksIEFDQ0VTUyAoTkZTdjMvTkZT
djQpIG9yDQpDUkVBVEUgKE5GU3YzKS4gVGhvc2UgY2FsbHMgd2lsbCBoYXZlIHVzZWQga3JiNSBh
bmQvb3IgVExTIHRvDQphdXRoZW50aWNhdGUgdGhlIHVzZXIuIEFsbCB0aGF0IHJlbWFpbnMgdG8g
YmUgZG9uZSBpcyBwZXJmb3JtIHRoZSBJL08NCnRoYXQgd2FzIGF1dGhvcmlzZWQgYnkgdGhvc2Ug
Y2FsbHMuDQoNCkZ1cnRoZXJtb3JlLCB3ZSdkIGFscmVhZHkgaGF2ZSBlc3RhYmxpc2hlZCB0aGF0
IHRoZSBjbGllbnQgYW5kIHRoZQ0Ka25mc2QgaW5zdGFuY2UgYXJlIHJ1bm5pbmcgaW4gdGhlIHNh
bWUga2VybmVsIHNwYWNlIG9uIHRoZSBzYW1lDQpoYXJkd2FyZSAod2hldGhlciByZWFsIG9yIHZp
cnR1YWxpc2VkKS4gVGhlcmUgaXMgbm8gY2hhbmNlIGZvciBhIGJhZA0KYWN0b3IgdG8gY29tcHJv
bWlzZSB0aGUgb25lIHdpdGhvdXQgYWxzbyBjb21wcm9taXNpbmcgdGhlIG90aGVyLg0KSG93ZXZl
ciwgbGV0J3MgYXNzdW1lIHRoYXQgc29tZWhvdyBpcyBwb3NzaWJsZTogSG93IGRvZXMgdGhyb3dp
bmcgaW4gYW4NCm9uLXRoZS13aXJlIHByb3RvY29sIHRoYXQgaXMgaW5pdGlhdGVkIGJ5IHRoZSBv
bmUgYW5kIGludGVycHJldGVkIGJ5DQp0aGUgb3RoZXIgZ29pbmcgdG8gaGVscCwgZ2l2ZW4gdGhh
dCBib3RoIGhhdmUgYWNjZXNzIHRvIHRoZSBleGFjdCBzYW1lDQpSUENTRUNfR1NTL1RMUyBzZXNz
aW9uIGFuZCBzaGFyZWQgc2VjcmV0IGluZm9ybWF0aW9uIHZpYSBzaGFyZWQga2VybmVsDQptZW1v
cnk/DQoNClNvIGFnYWluLCB3aGF0IHByb2JsZW0gYXJlIHlvdSB0cnlpbmcgdG8gZml4Pw0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

