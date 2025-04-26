Return-Path: <linux-fsdevel+bounces-47446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F50A9D844
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 08:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2DA17E51B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444CD1B0406;
	Sat, 26 Apr 2025 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="blJnxcPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011055.outbound.protection.outlook.com [52.101.129.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB346FC3
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648285; cv=fail; b=l1/jG6pYIBQDrZ220BgdIoimSGb216m3r2vjGuFcotZRpV1fyxW7JDsFecWPcC6xgI9k/VE/cg3rcusYs0mnww0XvrqmfW0YA32UzbXZfMMtL0IRS78DDwv0OveSFMlH5g7YnuCXmyQEjuaVesKBmC8eTo/r2KGG6WysB561D80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648285; c=relaxed/simple;
	bh=Ve3cCRFBHTlnoIKAXO5YiOMD/ixn2FM8SsVmwksfEck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XIpK1avAtxusPfjYa8yO7Sx2HRsnSypPDeQo4ZdxA1P4Org22N0zaidZDDPxpXt1X6/c9AnKf+oRc6FUMBjWDxfljj5F1Mk3w5TFr4+CrUY/JSZbZsX3BXN/bN7cKMFY2uIHkaMf28UZZr0h3g+onsIfsBxTTcWpzKmh5uUrhqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=blJnxcPT; arc=fail smtp.client-ip=52.101.129.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jel7/eQW11i6Re8icR1tg7I1ecavVFnOErqe/V3dqiFJ+6zSDG2iz6a2XECGRwIkp+NAwkRy15DDulHrOrGwfBkWr8YaYADsNbz0t5Rof8nR1U+H4OjK61UKb/L/VJ79Px7s7vm2yb5Y2oQPC0sUqo+TSqbSkN1YWp2K55s3p3JyDIcT5kVBbaYLP2aNHkJzp1Fat0+cx9Xky8mN9QkeX0lbDnBwjyJcwit04+TehgKoeu8pefqdQDCh7K/ZxhFXZfOsGOitXR0YfTg04fl5SJnRdFiCnus2Ze15d03Wxmf1q3wsXo+HucJnTW6z9rNJx8pOA2+KTm5fNT2+B6zyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve3cCRFBHTlnoIKAXO5YiOMD/ixn2FM8SsVmwksfEck=;
 b=q1hz74/ufWyhtfIONG8AMc4H7EOdcC5E5G8yrGNsG7WR0LNAgPcSAOwq+eI1xRha+HBrLYWX0oUq27Vh4AkacOEAAfgTASqx3dekXDSbGI7AFH+Id4cNwTU9rKOfQnuWt38TlZ3mT73g5OhCTHYCToSsNd1EsDKH+I58zRTgFdVuC8P1R0M7o1PLNOcDYDxBKGgD7/PrhgFshyMfNEJe5pCDMVTUz/qX7N8eA69n1T6mesB3Igz7ZWlg5qB7JcfTABMN3r2yCHmK2QLoqQZLqsMY/N+YJsHZPd1QhMInx2a/EqtYNn0elcnJAz7TAmkDY+ff4y2kv1e3NX4oiqZVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve3cCRFBHTlnoIKAXO5YiOMD/ixn2FM8SsVmwksfEck=;
 b=blJnxcPTOf65+/C8L2YrVV+n6O09Fhlx5adhuyXHjsVvYosrKJcuzCGEt/t99Pkcln2YICWoQgmWOVyy5fCWYQu66qIxEicJR0Ii9lKfv+XoplWY/sMZOEsBqdIHwfhzrRwOnZfsd1QmDtKJV3MnhHmWQWq/x9cd0+Nntj9B4dg3nAxczp5zzbTfpC1yvrC/BxPpAh7wsO85ob9DOzFYKwlyf+o8oVN36u8+A2BFQ8/meHgYSfr0tzLBUTqtSH0YvXD60hFNRdGhcV7FES54f2f/RAOx1pxOpw+gREiGFRj8e5rnakyTnscSgg7JLB0P+u54PCqfFp+BF1nj0EelJA==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Sat, 26 Apr
 2025 06:17:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8678.025; Sat, 26 Apr 2025
 06:17:56 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "slava@dubeyko.com"
	<slava@dubeyko.com>
Subject:
 =?utf-8?B?5Zue5aSNOiAg5Zue5aSNOiAg5Zue5aSNOiDlm57lpI06IEhGUy9IRlMrIG1h?=
 =?utf-8?Q?intainership_action_items?=
Thread-Topic:
 =?utf-8?B?IOWbnuWkjTogIOWbnuWkjTog5Zue5aSNOiBIRlMvSEZTKyBtYWludGFpbmVy?=
 =?utf-8?Q?ship_action_items?=
Thread-Index:
 AQHbswekna2OCwxWoE2e/XeZ/ACbe7Ovn+GAgACQiQCAAAnhgIAAAEsAgANb3oCAAJkF0IAAFf8AgAAA2+CAAHKYAIAAEYKwgAAETICAAK4T4A==
Date: Sat, 26 Apr 2025 06:17:56 +0000
Message-ID:
 <SEZPR06MB52699F3D7B651C40266E4445E8872@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
							 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
						 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
					 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
				 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
			 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
			 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
		 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
		 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <d35a7b6e8fce1e894e74133d7e2fbe0461c2d0a5.camel@ibm.com>
	 <SEZPR06MB5269BB960025304C687D6270E8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <97cd591a7b5a2f8e544f0c00aeea98cd88f19349.camel@ibm.com>
In-Reply-To: <97cd591a7b5a2f8e544f0c00aeea98cd88f19349.camel@ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: 627ec4b3-318f-4f8d-2714-08dd848a15c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2k4MmpZd3RiZ1k4NHo4UEd3RWVYeHZYRmhsVys5M29YZEpweWF6MmFWbjZi?=
 =?utf-8?B?elQrMlcyY0lNSnE5MGczMEFDL3ljSjFkcHlDWllYc2VqdmtES3BJTWpTY09l?=
 =?utf-8?B?dnRGdXZkd1lKMkE2a0d1eGU5OHp4MDhjOGg4ODkramk2MlFsaUVFTVlBWUlh?=
 =?utf-8?B?VXNTZXAwUUNaU21NOEZOV0F3Nm95Y2hTczArbk55SitSYjgyckRUNFFrZjBR?=
 =?utf-8?B?dHJtSGZhMHpnaUFwNDhZQlhIMkZCcStoNGRHYnZmU1czbjZmcEp0d1RhUUYz?=
 =?utf-8?B?QUZqVHJpTUJWU1lPcmNybUVPS2NCMmQvTHpHQlA3MUdBeHNvbWFsTzlIWUZR?=
 =?utf-8?B?cURYdzNveWRxRWhWRzNZQnA3c3lZUmlZa0d4RElLYU5nVzVCNVJIQVV2bVZl?=
 =?utf-8?B?OHFINXdLa0FGRUNSYTZVa3FmQ09ZcnoybFp3czJ0N0N1Q0h5U2lxSXpKNDVB?=
 =?utf-8?B?RWtod1ZtNEdQN3hXS2htZnJ4dllmRFQ1eVhTNFFLL3JoaUEzcEx0NkVPYXI2?=
 =?utf-8?B?ejcwN3VHTUtwb09FaVZ4Y21nSGxFR0xhdlBQUmRWN3RjTkhRZlkzdDFtd29C?=
 =?utf-8?B?NGZubkVTbUdiYWZyM3FCdDRyOXJDSmc4WnRBMWZXOElEZ3VXQkxqOEx2ZmpG?=
 =?utf-8?B?UkRjTXFOZUlhZlZVYUhESE41c0llMFlxSFhLM2FwaG9qNlVSaUpkODc5UGlG?=
 =?utf-8?B?QjFIVGtEYzNwdVVKYXk4QVVPYVJGa1kxVHB0MHN1aElyWTRXRkt0Q2xQWmxa?=
 =?utf-8?B?ZzBoN01kNTNneEQ1bDJIL1M0RHhodUs2aERCMUh3SjdYeDBWekoyaGVNZEpV?=
 =?utf-8?B?YW1td1J5UlVsN0o0NjUrS3JIWEdnTHZCMkVMZlV5MmdjeU5IN2o4QnVpdHp5?=
 =?utf-8?B?dE9XVUY4OVBrWktBbFNzQnppcnVjTHJlVGxEVThxdzZ0bTJYMTBnRTQ3aCtP?=
 =?utf-8?B?eElJT2V1OXQwbjNwSmRrUDg0NERsd2tQc2VtZ21kOHNmUmgvNEtuYi9LZ3Fh?=
 =?utf-8?B?d0pnT2o2aXpxMXRUYmx1NVFONGdLZEl3Zi94NnpwRnZMSEFkMGtnTEZRbDlp?=
 =?utf-8?B?cUJYRkdjbnRZcjYzRVdQaXlVUjF2cUFZSkQrMjcwcUFHQ3hWZG9sYzJIWlpP?=
 =?utf-8?B?V3hwdzE4Y1ZWRFgyblp1TnJXT2puU2dtTXUxVllGSTA2T0p1SzE4azFYTVVs?=
 =?utf-8?B?Z0R3WHpyZFV6UjJsSk4yYzV0WW0xMGFxWVk0Mmx1STk0NVVjdUUyYzM3amMx?=
 =?utf-8?B?cDUwajF0WDYweVdxWWtXWGc2NUpSKzdJUTIwUWJaY1ozaXFrUG1FaVBqeHJI?=
 =?utf-8?B?WUJ2cjVLOVNabDROYkU0QjBlRWJzR0IrY2g1eHdBOS8rNmtXdzJHaDUyenFV?=
 =?utf-8?B?RUJNa0FSemFNY0g1L25nY050emw4M2RtMWhhVDQwMzNXYnJYVGV1Q1J0bktr?=
 =?utf-8?B?ZXg0Sm1NdU1UWkU2cllpeXNGelFLVmc4bVpVVzJLbGZuZVJqVkZwYjZpL0NB?=
 =?utf-8?B?YkxPNVJTNGtYWFZnbDJIWFkvWDh5aUhsQUw3NVRYVGVCSHJLbUZWQ2JjbnF1?=
 =?utf-8?B?cTlxUWRDVkhCdlcramtHcUowYkZvWU9HeEF6K2hWU29CUis3bjZrZzI5NHRi?=
 =?utf-8?B?Y3ZLVVc4YVI2TUtDbWN6ZW5xWUQycE1RNEthUi9TMUwwL0hBb0tRTzZJMGIv?=
 =?utf-8?B?enVkd1E1MXZIN2hsSU4yU2dTMi9uanhVbUl0OTlxZkVMM2dBeVdMdUUxY1Q5?=
 =?utf-8?B?RklMUFVSZy9GWHl4ZVNIbE1XemZ0TUJtYnQ2WUErbVRLZXFLQnc3ZkR0ejhq?=
 =?utf-8?B?bWpGNlpYVzkwN3JJdENVb0hzNlNGckl4UmFDNDlBT24xeHhNWUxUVVNrMy9a?=
 =?utf-8?B?ZllvRUtGN0IrSG1jVWdMVGdJa2Y3SGs2SGRTT0JKN2MzSUVxREpJVDBQWW9l?=
 =?utf-8?B?emNwbDI5WVNRZkhkdWtibzBXT1c2Zmp4VWZTMndyelhlV2hFaXBkQkxWZTlX?=
 =?utf-8?Q?YfWiI+iX0Ve2WLWYQ4aRXFYS2Z6KEQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekZIWWdOTnBSUElGbktvQnFYMHJ4Skl5T1Q2U3g0VXVzTkpDOGNSS0F1SytV?=
 =?utf-8?B?L3UxeGZLWm1SREZZZHpQbmErcVljTU5BTWNicVpYS1VoSG1hTDBqb1NSdWJz?=
 =?utf-8?B?TG9QbDdXYVc4RzM4U1p6bUNLazZoUmY3eU9PNVordWp5TmI1OHdDNDVRUmFm?=
 =?utf-8?B?RTYyZVYyOEdZbC9GL0NPQ2YxNWtMNXVyMmtmdGhVS0JJcm9BcGtoMFRGUHo4?=
 =?utf-8?B?aXh5Z2srNFh6akI1ZHJpbkRBWk12ZjJJbDZlUGxoL1FHMFhzbnJCK2E0RUdj?=
 =?utf-8?B?NlNMb1I1eTdnOGdOYW81dGM2NEFQR0dxUXh3NGR0SkY3UFVJV2pBR3NPRkhL?=
 =?utf-8?B?MStkREZ2L242WlFibzBBdjA0T1JLb2YzeUNRSGlLd3JweWQ0RmZvU2U0NnRz?=
 =?utf-8?B?OFB6YmY0K1dwNmtOalc1QXZ0U0J5enlYeGNxa3VWNEEveDdsckZPY0JUR3dj?=
 =?utf-8?B?VUord2pNYVdJTXgrb3pWTnVuemxQaklzUUJTdFFuWmdKODliSTU5SEh1aHk5?=
 =?utf-8?B?K1Z3Uk4rbmc5VFBDUDViWGZ4VTMxYU9zb3RYOHZReFROK3dCbHQ2TGRJZmtj?=
 =?utf-8?B?U2FKYUxzTThyc0UxZGJESUpnNytOMTBrMER4c0EzYnI0RlcxK1VNRk9qZy95?=
 =?utf-8?B?dlBqOFdqZERmWCs1MGt2cHBhQzlKTk9jQkRDZCs4VnlDMGVsWDFURmxRdW1x?=
 =?utf-8?B?MVB3RmhxTmJqcXpQbEZQWWFMQ2JkdytPTmQ0bHZtY1c5clBSTWdMR3pLdFRu?=
 =?utf-8?B?c0oxNUpmb3ZXV2F3Rnc5VmJ4K0JjbWZ4SDJyb2xwSGlucWh0bVJRQm5HdGlK?=
 =?utf-8?B?Rm5WNUJ6bStPTDJzbWpscUQxS0JtbUNxMGhJZTRvbHYyczN5YzFTZGFRaFM4?=
 =?utf-8?B?MytiellVOVZ0VFFQNm80T1UzQUx5QWlES3N2VWJtbHArRmpYWnVJQmhySnND?=
 =?utf-8?B?VExhbEk5R3QwY3gyUTRMLzIxaEl3ZXkvdGVtbXptN0tXdnpOdlU3ZUxGRHNC?=
 =?utf-8?B?dUhwR1RSektic29qRWJZWExiMmgzTTkwY3B2VmQ2dTN4RjNSbkVqQ25ENzZo?=
 =?utf-8?B?VkZxUTNDTEphQ2FJYzU2cXM3Qzg0anhqajR2WUtLZWJRR3psSnNFL1E5SlIz?=
 =?utf-8?B?bTk1WGh0TXNFZ0YzOHNuYmMwNkYvNnpjRXJwMjRidG9CUXZPZ1FpWVhKVVVZ?=
 =?utf-8?B?MEprcnQvY1dlNnpSRElnZTJNRkRZOW9ySXhCa2VUQkVZcFgxU042OGtsQTNa?=
 =?utf-8?B?Y0JsSlFVQk96RHhGSnIwVnZuRG14QURxaUJPWFlRUndGVTd5S2FkbmFldkhP?=
 =?utf-8?B?WkxQeDloSERUR3dwTWV6bUV6YkJ6MGFrNElxc1Z6YldEMml6dHFBaTVIcllG?=
 =?utf-8?B?bFRMZWs2R29RMFl0RXFxK3ByMUZ5dUFWMDlYNG1nL0xMUXFuN1BISW15VTJJ?=
 =?utf-8?B?VEdURUZzVDNFM1FmMG5xcFVMYnpRWGNvR0ltdjJDU1MvYStSTk5nSUl6K05r?=
 =?utf-8?B?MG1mUithUUU1YmRWRlNQTWF2OTV2WStCbUhvQzlWck94ODRRZXNXZzQ5WlZj?=
 =?utf-8?B?LzkyZWpLYjBSeSsyaTREeWV6NzZvTUY0UkJJaWtZdERaTVU0VTRZcy9oSzJp?=
 =?utf-8?B?cWdlRDlrNWJ2TmV5NmxSS2lVR3B5RElaVTdWeFVJdkZYODR1NVZGQnY2czFF?=
 =?utf-8?B?ZXZEci9ubEJzTG9MM3RlSUNqTm93THZuVFRqUTQwMGgzenFQd1ptZnFxb2lO?=
 =?utf-8?B?RmNHWHBpSlg4cy9VS3dsMjNqL0UxL0RpNFA5RjRmcHdyTmQ3N3ByaDNvQWkz?=
 =?utf-8?B?N05IRVlnbUlkcjQ1OUxCWis3TkJBTzdIL2lreFZlVXpFZGtUYUxkZ2dpdTgy?=
 =?utf-8?B?STBXbFRLREZwa3NQOGdMS3dFa2RoQ2FhZFhRZWN5WW1wakJ3NVBjdFpkdWpG?=
 =?utf-8?B?MXkzSWpybW5wck5QWVY2TDloTHFHTWtGckozZVJaOU9LSFA2blhJUm1Ya2pD?=
 =?utf-8?B?SW9sajdVVitpV1hLMnNad096YWNkNko5NHNNMEZYb3RlWWFveGwzWDljMUZT?=
 =?utf-8?B?M3p0Qi9FZ1YvWUdTb2pHQ21yMUJrM0o2QjhHWG5ESkJXUjhSNUZDY3pCVGF4?=
 =?utf-8?Q?dIio=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627ec4b3-318f-4f8d-2714-08dd848a15c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2025 06:17:56.1769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vE5UGxsLm9r48xJ3nd227rNTkcWCWpH325hf88Pv89lfYX7tdaA0+M1eWUgpx0NjK05RpWyKoiNXDVVdORk9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034

SGkgU2xhdmEgYW5kIEFkcmlhbiwNCg0KPiBEbyB5b3UgaGF2ZSBsaWJibGtpZC1kZXYgaW5zdGFs
bGVkPw0KDQpBcmNoIExpbnV4IGRvZXNuJ3Qgc2VlbSB0byBoYXZlIHRoaXMgcGFja2FnZS4gQW55
d2F5LCBzaW5jZSBpdCB3b3JrcyBub3csIEkgdGhpbmsgSSBjYW4gaWdub3JlIHRoaXMgcHJvYmxl
bS4NCg0KPiBBcyBmYXIgYXMgSSBrbm93LCB5b3UgbmVlZCB0byB1c2UgLWggb3B0aW9uIHRvIGNy
ZWF0ZSBIRlMgdm9sdW1lOg0KDQpUaGlzIHNlZW1zIHRvIGJlIHRoZSBwb2ludCBtZW50aW9uZWQg
YnkgQWRyaWFuLCB3aGljaCBpcyBjYXVzZWQgYnkgdGhlIGhmc3Byb2dzIGNvZGUgcmVtb3Zpbmcg
bWtmcy5oZnMuDQoNCj4gSSBhbSBhbHNvIHdvcmtpbmcgb24gY3JlYXRpbmcgYSBwYXRjaCBzZXQg
dGhhdCBhbGwgTGludXggZGlzdHJpYnV0aW9ucyBjYW4gdXNlIG9uIHRvcCBvZiBBcHBsZSdzIHZh
bmlsbGEgdXBzdHJlYW0gc291cmNlcy4gVGhlIGN1cnJlbnQgV0lQIGNhbiBiZSBmb3VuZCBpbiBb
M10uDQoNCkFkcmlhbiwgV291bGQgeW91IG1pbmQgYWRkaW5nIGEgYnJhbmNoIHRoYXQgc3VwcG9y
dHMgbWtmcy5oZnMgaW4geW91ciBnaXQgcmVwb3NpdG9yeSBub3c/DQoNCk1heWJlIHRoZSBoZnNw
cm9ncy1yZWxhdGVkIGNvZGUgd2lsbCBiZSB3b3J0aCByZXdyaXRpbmcgaW4gdGhlIGZ1dHVyZSwg
DQpidXQgdGhpcyBpcyBwcm9iYWJseSBub3QgdGhlIGZvY3VzIGF0IHRoZSBtb21lbnQgKGF0IGxl
YXN0IGZvciBtZSkuDQoNCkkgcGxhbiBvbiBsb29raW5nIGF0IGEgZmV3IGhmc3BsdXMgZmFpbHVy
ZXMgZmlyc3QsIG9yIGlmIHRoZXJlIGlzIHNvbWV0aGluZyBlbHNlIHBsYW5uZWQgSSdsbCBnbyBm
b3IgdGhhdCB0b28uDQoNCk1CUiwNCllhbmd0YW8NCg==

