Return-Path: <linux-fsdevel+bounces-47358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13817A9C7D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069D1462485
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44E24466D;
	Fri, 25 Apr 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="abeKt7Dv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012045.outbound.protection.outlook.com [40.107.75.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89824337D
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581203; cv=fail; b=MjZrMdQvMSguW/ybzsUqaxJAKRUfjz78VlRPQV6scOMKjH+a8uatMl2UIaoUsObk3FAKeCW1NGUM6hJ0GSufCS4Y3r2gAj/vap5FtVNXadmjL+NJLwDGPFosRO9ZmVTd2jZ/yFrdGHrh4eDSg5JTdlJE2ghx4+6hzl3T1bbm5nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581203; c=relaxed/simple;
	bh=ni2i7n5PTvA8QeLScfW4nBUqcO4pamB6Mkz2/OyQ7YE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SCjD8Woh6UwSUSMQYG1j9rdjySGSaEwgTG5nHEHrK1+rO9hVD86YywwB6DFDqrdcHdTo914/E/TyEKWS0eKHPDpmXyY2q50XiFw4ItMnMcfJxETlNyx+mzdcK2jonSmqm6Rr/ahEQuza1vKh3/bzAlbaz7C4fHXzxx6ukTIMG4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=abeKt7Dv; arc=fail smtp.client-ip=40.107.75.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efO/NasRP3Rfximmp7jWKWZiudMKlsEl8oyZFGFX+1UOrr/TlunVNtYgEWFNeVNMRbBJ0FlYsvSe/ynTT4Lf/qxIXuP0UoYg3oEJLfgBMrsvGN64WESTa8/lQzG/eIF8ZAh6T2XoIL6b9ere3mBdJvIw1p/QHjtDlRoWZxOOd9aeb8n2u5ASc8LZ5Hh/uPN9Ec7c9vKdIVgo/uHPgQ56H45Y9W6KdyD1Ac0egbo4ZeXd2xnYxVtN698inZ5Lk5QA0ykwTdzw5T/DlrsDksyATrOzNQe+M5kdfc5lWH/rc0GjJbS82X5huf+f/kiXKEuC2SX3W/XJp0fWr4STtBDXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni2i7n5PTvA8QeLScfW4nBUqcO4pamB6Mkz2/OyQ7YE=;
 b=lz6zxUwQ8CDCGRfwJSKOxEFEbqDybgTHKx0jEefHCAMbLcQpYOYZp4m6+LWSoO1g27Trhhg9fdACI96HlhM/8Z74EJYTPbSvvKQsk+VS5TFuDtZvGQG3Nd6Ukb9Ryu9JhPwbRpSlivOhPLFF57YxIUc2KLWtlee+pod0NoF1a6nyhChjVbc7t5vmN6NdnU0o9dRB9QJN/jOWnpxz5JQo0dP4VeAZkRD18AOpWXdoyWZo5kUZJpBLhU394STYujExx8WzUwT8pydYOlgeI0t2GEzTg1Fju5p+FWJYtyfdk/B9S+cX8WDognLnxU7nKhLl7XqRvYJbTErjrD2coWhRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni2i7n5PTvA8QeLScfW4nBUqcO4pamB6Mkz2/OyQ7YE=;
 b=abeKt7DvzJ9X/xq3BVhmaWrNikkzt6NAFN772L2WRV3VEBSNsGybfdp5OsqBF9lIgwxv4Ty5nb2Qlfv6BeHZHRvIXODgU2oR0BxSXmP6yqn5AOpDDvE45KB7Ht6BaOr6+x2nQDQW0lOUEEJ8WOsCKkmlW+2W0Y01YCxcsjT+12QtTD4x965WAAvi9BHiPFJqUT15wM1SUtUy9CYfvKhBJ+Uh8SuFpudzxIRRTmtvaDTD3fHz1xQnhBsMh6g5R1T6FEUr8q1PVV90wpt36IHPBw+Z/iw1jhDc5r6hMdjp7dYM0n3f5tNxz+q7cgcJvhb1uVLnq4n+6/9khwwKLyt3Wg==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 11:39:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 11:39:53 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viacheslav
 Dubeyko <Slava.Dubeyko@ibm.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "slava@dubeyko.com"
	<slava@dubeyko.com>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IEhGUy9IRlMrIG1haW50YWluZXJzaGlwIGFjdGlv?=
 =?utf-8?Q?n_items?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBIRlMvSEZTKyBtYWludGFpbmVyc2hpcCBhY3Rpb24gaXRlbXM=?=
Thread-Index:
 AQHbswekna2OCwxWoE2e/XeZ/ACbe7Ovn+GAgACQiQCAAAnhgIAAAEsAgANb3oCAAJkF0IAAFf8AgAAA2+A=
Date: Fri, 25 Apr 2025 11:39:53 +0000
Message-ID:
 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
					 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
				 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
			 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
		 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
	 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
	 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
In-Reply-To:
 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|KL1PR06MB6020:EE_
x-ms-office365-filtering-correlation-id: 919e1208-e3a1-40d1-871f-08dd83ede545
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3lIN2RHYWUwcDUyU01wYm9sTndRREt0ZG01dWoyczYrUnloazVxMzczbGFz?=
 =?utf-8?B?bjZhd3FtZWFHNDJTczl2ZVgrV2ovZUpoZVhCaEVuRGFVK1dGVkhUUEFrUHFT?=
 =?utf-8?B?blIyQ1B1dXRrS0hBUUhhd1FSMEVZK1ppbHB1NWx4WkVEV2ZRWWpHVmZGLytM?=
 =?utf-8?B?Tk5qVzIwNmhmaWxzT2IyVkhzZ3BsbVlsS1liR2ZOU3hheDJOYkxaaXpBejJY?=
 =?utf-8?B?WWlNZERIOGRPLy9jZFVyK2c3bkdJSkZVcVpiMDhLU0VaOUdxODAvTlJOVG02?=
 =?utf-8?B?T3FyREsxYXlWenV0KzRHK0pJdlI4MkJMbDRvdTNHWDhJcjA5K0VXUllPREh3?=
 =?utf-8?B?SE43TFRmRlorekZvd21zQXhwbklpd3R1aHJ2dUk1SHFUcndQSzZZNlMrNnNK?=
 =?utf-8?B?bkFxZUxRWWp1ZjE2bEZ3aVZNcEs1RDhlYmw5ZTBaWmF3YjRMTmdtU2ZXS2Mw?=
 =?utf-8?B?aEJuWXF1ZklreGsxanozYUVPdjVOODhVbU9LamVTQ0RIZmVHVXpvaVZLMGNB?=
 =?utf-8?B?ckRiUmlDVU1jejlQUG8zMncvS1NLUVl1VTZJbTVGemNoZ2l4ZjVRNjVPdG5t?=
 =?utf-8?B?cEJxbExmRnBFRjZaQjMvcnBEZEsyOWd5MlVlMjE3R1V0SGlneXpGQW9WMmRs?=
 =?utf-8?B?K0ZXcTJoNDRTSmUvbHJXU2YvazlQY0F5ZXVBVUNPS0xLcTlMUUVUOHRNLzNa?=
 =?utf-8?B?M2ZHSlFmdHBjTzBPdVFzTXMrYkhPTFQ4LzVRSmkxYXVGS1laZEpybStsNTJS?=
 =?utf-8?B?Nktoc0dXTEwvWVNHbS95OWtwY1doYVRHMEt1TERFR040eUZTeGM0S0FYRGtF?=
 =?utf-8?B?YVRFSFF4K2x6TXk4MEFrbFJIZUh5aEFIcTN2bnVRcmdsZlNoQW1uNmdISEdh?=
 =?utf-8?B?QnJNTTJ2aTBRQllzdkpZbHQ0TjJ6UDJjeVpGT1BqYzMvcS9DdXRleDJJL2lO?=
 =?utf-8?B?TTZPL3F3MmdUZExHa2dkRDJJM2NCazg0WkdwWlprbEVndysrT2o5WHB4OVZW?=
 =?utf-8?B?UEVWTExkQldsU2RwN1VwajdGV1FPemNBaGlOUWFtcVN1dFExRHNKUE1qZ0xa?=
 =?utf-8?B?NWhjNkZFWkV6SktoUU9WdmVKalZQVXllMzZRbnlVbDNaMmdNdklONmNXZGov?=
 =?utf-8?B?Zlh1RTM4THhSV1hEMUc0aDlXZGhZb2s4b1FDcFdZNXE1Mi85ZFcxUHBuY0NY?=
 =?utf-8?B?SjREQzlTNG4xTlVmSEJWUmM4dmN1dXp1dmMya1IyOUYrNzFQdU1QTWVRcldX?=
 =?utf-8?B?QisrZHp6T0QvaHdEVGtlbDcxektLTk90R0R3Q3lRSWFFc0RhcHlHakY0N0Ur?=
 =?utf-8?B?Y0FqNTBDbjlpRXFDeVZwRVo1di9PQ3ozZ3JhVlpLK2VUTTdEYVNkWXFLWDVL?=
 =?utf-8?B?b2RIaTlKRnoxTUVvQnRPcnFoYUYwdXpHUFBDOVgvTXp3elBKTTFTME8weWxT?=
 =?utf-8?B?cjNNc1NYVWRVWW4rUnd2eGpQNTNoSXhKK0NuaUlwV0Q4S1g5dGNBSmZDS2xJ?=
 =?utf-8?B?V3g5ekFITGU0WThncHlBZ3JKZWkrUXNoMlpjQmx3OFdCNlNPWDhDRlRUUFho?=
 =?utf-8?B?ZGdWc0FRUGVmaHloc0hZRDQ5dEpaMmpxdmpxOTVZek1ab0NRVVNKbHV5c2Nv?=
 =?utf-8?B?VFpzaU9waG5NMlh0SVR3b2pyU1VNZy9OVUhYbStRaHRiK2Z4UGNyWEVoTnMw?=
 =?utf-8?B?TUZ3UE1FdHlrWnp5TFN0Nk9oZDR3WFUvVUdkSFNtNmhUSjRJYjFsMmk2WXI5?=
 =?utf-8?B?cXM1aTZQSTBGcURsODA4NE44Z3BMbFdxb1E5ZUw2NldZZkZKOFpPOUYzYTVK?=
 =?utf-8?B?bDF6Z2wxMlQyZ2VFbjIxcjdQSGg4ZjhLK0g4OEw2eW1mcHNPNWdId24yWHo3?=
 =?utf-8?B?NGxyOUFFc215eWhHZTc5MjJkNjZwNEdrWWxVeUtaN0ZMQkZ0MnhNSkI0eGNp?=
 =?utf-8?B?SC9nZ3lYZWZUWHUrK2lBZEE1YmlXMFhPYkUyOGpKQWlkQWFwMEVxb2VoZGxx?=
 =?utf-8?Q?ztHQfSS5SWcTP/YrlDgzSAHkr3WprI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVBkdVRmVEl5SkFrUDJZaHdKK1RURGJPZGNJMWNCM0lxTHB2M2MxR2JiMnRO?=
 =?utf-8?B?bnhKQUIyaUtuelNmcVJ5eGlQZXk5R1JFWmtHT0F1ZEpXQlBoZlo2WGg1ZHJR?=
 =?utf-8?B?Mi9keU5PUUVRaHVpK0FZcitJUUJKaGlXWEJWSXc4ZW1zV1Z1aS90ay9nWXYv?=
 =?utf-8?B?RW5SZkw3Z0ROTU03TkRKNzRrZldzTitOZUg2M0kzY0Y1N2VkL09BQnVwUDQv?=
 =?utf-8?B?T3NveUlBa2Q2NzZvWFhyOHFUakpGSnJXeDdBOERSb1ZmZFNqcm4zbHh2eVlr?=
 =?utf-8?B?Q3l4NnBxeXhBKzJDL3hSTVlhMFpteTYxSUx4Z1BPTEc5bG92djYybEhjUHFz?=
 =?utf-8?B?UU44OU9WVTd4bWliWC92TFlETG5UMFhJcCtlVVFKRWRIUDRteVhrUXBjek93?=
 =?utf-8?B?VDBUVWNrSGZoSlNuOXd0dzBJWVFnOERpNGtOeG12SmRpTGUxMkIyUkVXeWhY?=
 =?utf-8?B?ckVwendmdWJkZlk0UXVlVjY3U0VNbVhjQzdjMmFlR3EycEwvRFBSQ2RuZXAr?=
 =?utf-8?B?THJwVlJuY2J5T1QreUxpUzhnN3dFUzkyeU91aWlEbzgzczlGTkg4L0FPamYr?=
 =?utf-8?B?QzVTU25VcXhwbi9iUjdTbldYbEpXRjRDQlR6bUY0RFJ4OG5XbExVeDhRaHRC?=
 =?utf-8?B?QVY3UDF5ZzBxUnhYZjVCRm1oN2ZSRktUQ21xV0VKT0R0UlBiRHRtY0ptcklm?=
 =?utf-8?B?alZXM1R1TDhDZGs4VlExU1gyQWVQcDB0Z09CbWlmUS9kYWlvL3o3czhuYnlV?=
 =?utf-8?B?Q0R5Z1lMUEQxamc1UHBOeGMyVndrYUdUYzc3aTN2L1A2b3JQVnQ4MVlyTmRq?=
 =?utf-8?B?bkREaHBzQ0h2NU4xVGd5OS9SU21NRmRLQlBUaVdab3R3RkxxeWVvekJmb01O?=
 =?utf-8?B?U1MzQUZRaGVDekdUVis4OWEvUEg4TkIzVE5GbmpRUGxha0lGZEdrT1VaRUxW?=
 =?utf-8?B?SUU4SjdaUUs2TXRKYjdaVHpOK2Z4MDVidTRGUzNHMzUwTUpKbVp4UHJQYnc4?=
 =?utf-8?B?OU1FbW1Jb0s5bjkyVXk4Y3Jqby9UWENmTVk2Y1luWmRRTzFwQ2w1TlE4Ukov?=
 =?utf-8?B?c0lwZytXS2hHU0VmL0VsT3k5N1dDT2RIaU13V016L01QeExadGUwYXV1QkRl?=
 =?utf-8?B?bkVxK2Y2V3pOQ2srTjFNbmo5aFZVWTNOTW1US2tIcVdiaHpmNWRpQ0JoZFBL?=
 =?utf-8?B?MXd1YmpmQjZMakRiK2wrTWhNcjFSRG10dzAwQzByQ2s1QWdzR2xWZVo3eUxh?=
 =?utf-8?B?UjhOcFcxYnczKzhtR2g0NUR6ZWhhUkRXdUR6cE00Z09XTjBtZy9iMDIxL0dn?=
 =?utf-8?B?eGpQWWlSWjgzYktJYVhlZnFHbDdBS1dwb2ViUjZOcDNFRDFZM3VSdWRhb1pI?=
 =?utf-8?B?ZW5nTi93ZkFMUkdkQlE3NGk0em9wektiVkJhUkJQSm1VRVZHNzVKaktiNmRj?=
 =?utf-8?B?dTRiVzNPM3ZtTndEc3BWbFBPNUdVTVlTejFSK3RFbWxPTGN6ajcwMnc3VGk0?=
 =?utf-8?B?RTFwRGZ4dGt1RlZncCthYlZDZStPci9XczJabVp4blFoaWZoZ1hPQmNGMmtp?=
 =?utf-8?B?VWFKOXl1VHQ4M2dvWUZNQlBOcU1NZ0ZNTGFIa2J4cklocTJEYW82N1ZGcVdV?=
 =?utf-8?B?U1VGL3V4K1lIMUZoaGZCT2tUenc4d1FMb2xWb1V4RURGMVJpbzB0TlF0MHJI?=
 =?utf-8?B?dkZmSDlvd2VxNFpob3k2TWgzR0xsVTVhWVVwOFBqWjE0OEplb1dtd1YyKzZk?=
 =?utf-8?B?NUxUcDAvTjFhVDc2cjVWUmJZLzFudnhJTjE1UWgyditKbUV3RnhKTUFyRWY1?=
 =?utf-8?B?UG1uSEovNmVMWU5paHhuU2dpN0hRbGRBcVRvcFFIYUptVUUzelJ5N214SUVp?=
 =?utf-8?B?ZnNhK0p1L1J0M2pGWHNGVzFYUzVhK0JSMmFjcVdhSTlDTFNkREt1YjJaOUoy?=
 =?utf-8?B?U0Y0dmtGZ2VMRm8zYTc2djVkdDVrS2UrRWRiVXFlZTdBeU80d2t2VHhJOHo5?=
 =?utf-8?B?alZkUTFCWVU5QmN3VlBKSThodlRRNitoamMvUm5ibTBHbldUeDhFWlZMcGdU?=
 =?utf-8?B?eGFlNURsdm9ScDJIY2RLN3RlVlY0UVJDUGh5Z3A0Qndxb0tBaTVJZFl5Mnlh?=
 =?utf-8?Q?6ZP0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 919e1208-e3a1-40d1-871f-08dd83ede545
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 11:39:53.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sua/RRI1Lof6rpXHkZiX9ZuYKlUxqCR2mUEoiSqg9MgOmYLo2sTfkIipG24U5RVRCMXaCl6AF5q7KfnfOY1ikw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6020

SGkgQWRyaWFuLA0KDQo+IFdvdWxkIHlvdSBndXlzIG1pbmQgaGVscCBtZSBjcmVhdGUgYW4geGZz
dGVzdCB0ZXN0IGVudmlyb25tZW50IGFzIHdlbGw/DQoNCkkgYW0gY3VycmVudGx5IHJ1bm5pbmcg
YXJjaCBsaW51eCBvbiB3c2wgMiBpbiBhIHdpbmRvd3MgbGFwdG9wLg0KDQpJJ20gZm9sbG93aW5n
IHRoZSBSRUFETUUgc3RlcHMgaGVyZSAoaW5nLCBub3Qgc3VyZSBpZiBJJ2xsIHJ1biBpbnRvIHBy
b2JsZW1zKS4NCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2ZzL3hmcy94ZnN0ZXN0
cy1kZXYuZ2l0L3RyZWUvUkVBRE1FP2g9Zm9yLW5leHQNCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vZnMveGZzL3hmc3Rlc3RzLWRldi5naXQNCg0KTWF5YmUgc2xhdmEgYW5kIHNvbWUgb3Ro
ZXIgYWRkaXRpb25zIHRvbz8NCg0KVGh4LA0KWWFuZ3Rhbw0K

