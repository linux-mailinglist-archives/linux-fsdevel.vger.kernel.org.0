Return-Path: <linux-fsdevel+bounces-14099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C2877A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382B6281FF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B6134C9;
	Mon, 11 Mar 2024 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="G7CayjdV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FA12B81
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131124; cv=fail; b=H7XAlnHb9fr44TPuFgmgZwq9G21cAQiJx6C9veMQcsM9vN9zLLIGZ+YQlPHOosTkKT/lcP3gnVLzbuRM1j2oeSYOeDikr1qf4lV8Jdqyo6ldppi+gZK9f1KObqk2wDYAmhMfQpfHaKkbUnW/o7Xl8uNZ+HyvRK+a9PezqsiGcnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131124; c=relaxed/simple;
	bh=ClHDg9yXO96nfRqgz6SeJri1e9Wdx1wYki+b08NFJOQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hS5ZeOw5uUOADY/eHd90rIRW65y3YsH1wDko/gVEEPm+IHgNa7oTz00/3dasPbuRKhCJPXoXU8Tm25L9pRfeoYA+w+h4hhi/wh1r27hym9311qk1z9l5V7oRwhZ7mCUh0y/8PK5uTe0ZIAHX9t8TBvws1XwKRcr4VMJXvbm2CPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=G7CayjdV; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B4EKVq001813;
	Mon, 11 Mar 2024 04:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=ClHDg9yXO96nfRqgz6SeJri1e9Wdx1wYki+b08NFJOQ=;
 b=G7CayjdV0k2SMobd2vvNRSYdmqYi/YkWFCH06LS7kHsWdcmacDUqWV0R6EV3EXqe3K3s
 3JcDE/kFTklFVqflayjK4GmlA8Eax2dA/rMFMpjo/RJTqR2pcUmdmDFboLC/5ZtK9OJe
 pe+d0RotQPUc+jO4wzn0KXyN7YdKoWzLFB0PgNv895UYoxgiSVFFAr2Bhl52xdPUiITY
 y4z03HQxR5826Q0pB6uI1Ay8+33/DlSwcQufBKUjTR1CMZL5X/sx32FEdf1UVKV/SQgM
 /d9MS+65liHiNXDAfIRfTWv+Ew6h1Zye5ZZc/b0py6yOldSRobcUUh6HkB385YuRN57d OQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wsqt585gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ+hxw/ttLWfE6mSbMmzdE6c45LKWc0LqKapD/5d7EM+1gfQ8SYKuRNTzZTE9eDl5ZH3DWIwKPJAltrOE90MyrG4ag9kT7KqVGR6/qZywFuycQpjSvTP8fWI8oA2HusQuOSC9koV/X0obnYdvEloLF6ETwZmmaSH/J90V0vJUvP1i6oU06NT1hn8X+OwON5Q6qhe5lw5/rE07tTTeKl2VNrk65o9gcY+XwWkD2K7Vr1kgFl4SweONVxBr9oWeK280KRLYL7pHfI74HkdZitUp8N8TYBHhUzA3jumawPV2awwO76tzSWIBURxbYRPTyn7SbTibXOjop+KRHO/n8XvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClHDg9yXO96nfRqgz6SeJri1e9Wdx1wYki+b08NFJOQ=;
 b=Rp1stGv3/ytjB//LrdgU4aI6zbajqQKd0kiSHNA5hsGnkavYLGgZs84p/xkqKeNt6/Beixj6Hj5Jk8HXYNM3OlagpvB+IQ+IRjsXWhZkGYmXiif23Al4O8GzSgLYFAFQGEMnJGJwCPZniQ0pLgMRjq7amgb1bN650l+qp33b3lfwtVwPpVeVmBU9of7khz/lkEhkPa5uprsqHUEy7yZETze3x+EfdlHU0+VZFdDuepWgif3Lb3GlVhFuNjtDP7ZlJa03D88YQrw7LysnECy3PDeCm3FQdU9yOlqVFGGj/h+NeUk5h1rLPWD8z2cFAL7hRCgyuzyYli1BZEffVBUumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by SEYPR04MB7362.apcprd04.prod.outlook.com (2603:1096:101:1a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 04:25:08 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd%7]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:25:08 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v3 05/10] exfat: move free cluster out of
 exfat_init_ext_entry()
Thread-Topic: [PATCH v3 05/10] exfat: move free cluster out of
 exfat_init_ext_entry()
Thread-Index: Adk2K2Rlcvd5MS9gRPmcSF0nOdraqE9PvTLw
Date: Mon, 11 Mar 2024 04:25:08 +0000
Message-ID: 
 <TY0PR04MB6328B7A3504E4641FDCB59BC81242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|SEYPR04MB7362:EE_
x-ms-office365-filtering-correlation-id: badc6590-d7f8-44cf-4f33-08dc41833bf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ed+Cv9PyhXfo/rh9OZEaPl1CJBMubFghQAxZl9PZZwMScgKFRgR5q5J8YSiABNf353bhN91c1ZuE521p498a4ft3KmlnmewDkQTOMwiKeksZtEmpGrhjuHL2oZq62Dpch+OmoFnrYdOFZm7hCtxO3pseLHw/NLo6gXyirm4YWmrD/ilHUvbDn1PtUSOfnwiolSHtntIhzB2rL4BCM76+elGtfCf59EeyTSYrFmoa5PN+A3T1hhTVWOsWlDquDWQEcRVuwAN4KosF5CDOfg5ekHk8RvQby4ARWgWYNwqUdZRzhm2mtkzDWwLdFpMNlRCkU6aAJ4l4d64O7oLh4Nkqwe8rH3L1K6UD0tzZcGr6zSG4igAMzYHBqSbBeWT0elT54btgI3YnVAgr6hUvrQUYfkIaWRhxEBZwLwfHP1xVOMBNDA4gpVsyi+/BeGlvAwqpiTUqxbzwkdd2AWT4HHBSdXGuUD7PhI4ZMYJML7daxCwcXhb2hF/EOEVxhJLS0p1PK2H7dZ4jXYMcyMnbYrlz772u0tz+HJCiPKZBXyfYN6ooLJXe88QjWaDn0mzL3QJti+UzwhEdPwFWDZQKTdoAQsecS7DWzBGMhU9fR5ee+CUWdzSw4lvFxWnz0n9ZGPRGNgnZ9R8SFnwcoLFkcxMcCl5OWh+poEZvz9f+6XHIBqoSpMZ2U6Xev00wTq6Vc8Tb+zWqygBf4fHsDIA/6fMmzLY/78RD8gaGhcEgsXvBc9M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WUIvV0NxWHZZOG1xUWtKQUR5dnlZZkJGR0poNjF5dCtVUTFJZ0RuV2dVRkRl?=
 =?utf-8?B?OWVTbUVzek1odDF4RjR4NWRSZStvMllXbW5wYjl4cisva1RHSGhhVTc1azJr?=
 =?utf-8?B?MTNKRlYyYnRtbGs4b0lDNGFQQUtYdHdIeWd5Q2RuZ0ZKTVoxOTlLMHVKRXM0?=
 =?utf-8?B?WTZ2aWxIODJUNE01R2RaZkdpN0t6T0N4eDN0MUU1TFduK2xQRXBlNHR3VlFt?=
 =?utf-8?B?T3lySXJXeTJEV0luelN2Qmdjb2pQbFR1TXZ3cWVoQXFKMUUrVlA4RUZoZnQ3?=
 =?utf-8?B?QTZwaktlUDFjZk5nTy9WRmltb3NUTi81SGJVY0JtYmdidmRmOGgxU3NhRXhN?=
 =?utf-8?B?SUxVeUtFTTNUdS9pK1MxMlZjN0JVdlgyMGpzZzhGMlNJOXFoalZYaVJranc5?=
 =?utf-8?B?ZW90bmZMYmxiWWd5aDV6TUlVRHNUV1ZxUld0WkpGbzI2aE5YT1U1UURmQ3Rj?=
 =?utf-8?B?UVAvQ3l4UGMyakFIWE9SODJRbkpFVlJveHBsSzRwd1Z0YWVLeUtydlRkZVlu?=
 =?utf-8?B?eTdDVm94RUJRRzRpK0x1K2djcDB6NncvaU1WczJRK0tialBjSGZ1N0Rvejdv?=
 =?utf-8?B?bXA2VUZxQXM4akVPbC9zWXBwU0pOWkNuc3pZYnZ5RkYvaTdzckVGNU5GYmVS?=
 =?utf-8?B?U3RGVG9raXZjZWVjQlRRWWpTUGVOYTFBQzhGOGlMOFdtR0lpVHp2cU11SWh5?=
 =?utf-8?B?M094T0o1aDF4V21HQ0dMNzBMdTl3VGpBS1ZtZ2V5dkdvNTlBcXpTc1NnR1hw?=
 =?utf-8?B?YXF6M05XVTc4aHRrRXNxTCt6enJRZXE0SWNGUGJHb25NQmNySFU4NWlmZk9x?=
 =?utf-8?B?RjFzQi91cVk5eDNFWENvQS8vazVyUnZtN0NCeGRDNnhUT2RlQVdGdklUSUhr?=
 =?utf-8?B?L0dwTi9CZ3kvLzJlSUVqQmdlcUY3MkFtMitIekNadmNSRWIrNlN2Mmxldkxy?=
 =?utf-8?B?M2dRblkwMG1aWjdRSFlYZ2thNncvVTk0Nmd2WHpCcy94MzJUczZISWd1bnVq?=
 =?utf-8?B?NXJLRTBrSGhmT3kxVjNiM25CaHNpVDMwYlFwTnNXeVRObXYyS3B4ZEVEMWhj?=
 =?utf-8?B?cmFFMmYyUmhaU3lveTB3dmdrV3d5Z1EyV0pLNmZsZHBOSThJZTVHZ0o2QXFv?=
 =?utf-8?B?cFpCWVBIWmcySWZ0d25FVHhSRms4Sy8zbnNlTXhDbnlQTW9PdE56N0NlV2U1?=
 =?utf-8?B?ajh0RnFLa2VBUm5kQ201L25MV1lLb0FLb2tIdk5zbjNIeXhqbkd4ald0NTJ0?=
 =?utf-8?B?VXo4MVdseFBkVmFQbURYRUt1am8zWnBzZGRTQ1BmWWNOK0FjaDlMbDlDK2h1?=
 =?utf-8?B?NzV0UkR6Mm9lYm1ZR0xmUnNyaTB2N1h2Y20wTUE1SlJtTy9oUGFORjR1SGxh?=
 =?utf-8?B?Q1huZDg3eHQ3ZVY4NWhqN2w2K09uSG5vcW00R3FaM1VqQ2xxblgxZ2FTbXRH?=
 =?utf-8?B?SDdBSHFlSlZRWUJLSCtPUWhxbXpjSW01Z0o2M3dxYVhaOUx3NWtWMFR1MS8r?=
 =?utf-8?B?a3k4eFRoSnNRKzVYbXdtSlk0ZE5vVnpwdFdQM2ZYenAxVmdyeEhDWlhaTWlZ?=
 =?utf-8?B?Q01OWFY3ZzFXQ1V6R3NXNUhMOE9vZmdiSkoySUJBTnErMytrejltYXZsWmJ5?=
 =?utf-8?B?MGlwcG0wbjdsTjh0RWRmOENPQlRDL1lOeUhGd1JjamlrRTZKbGlSY2V4MTE2?=
 =?utf-8?B?MkIrR0hhVCtBVGRhN3lTTDNSOTBhT2hCTzBDaGpKSXAxeHlhMGhxdGRxWjhq?=
 =?utf-8?B?SHJJbVYxSFhkWFArVXFUQXFsU083b1ppQ3hqMnk0b3pqR0dBMnBwYU8zd2dE?=
 =?utf-8?B?cmVmcXdlVmRnRGErMkJ3SVhLa0czb3RuT2E1MmFwTzRlbHpGbUlUcDV2cjUw?=
 =?utf-8?B?NDNRaHkrejA3bzhsdnJQQkxzYzZ2WkFtSlcvaktkY1IwTndwYWtCL1VBYUJj?=
 =?utf-8?B?Wk1FOTA4VU0rQWZSRE1KbExpNGxpemphUm9SckszVGNEMXRoWkM2QUJTMGJI?=
 =?utf-8?B?TXNQY3pQbG1PM2crd2oxQ2NWU21wdHRHSDdQM1J5b3c5cmU4djlxSWJqNFBW?=
 =?utf-8?B?UjBuM3loMkRNN0VBUzhLb29BZEhmeC90WnBJcWxaVS9OY2xZclE0bExHeHRO?=
 =?utf-8?Q?xxAZ4JfnIC3mbodozD6h7B5WG?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/zU4FfwHArnymhOTaeHd7xWwPX7YAOHaS0ZTO5uiNgv0mBiLYFyda3Bc90e/xRTeUAV/ECPhbDfCMGQiKav9ErNJKYFisNQ0r7iQDHF7pY7+W0D5UMkWqzVov8kCH5j+EFq10cvj9IiS57h7Eopu5DUNZNpwFOp8ZfOpXotH2RZEOqOYbVzbFLBR+kxm16YAS+qK0/MOcDkfOaXI3Zu8BFhk0OdSk6qJeeTV6m7AakcfrbkjQN7ei4LHlGcNEYkzcWMQaZfeiX4dVDJZ0dQf/Gv0WMRSvINiS+6LmkWc1n4s9uKnnZwid/skGqsgHhLBTIH2o4tWdcFacKJHJtAbYpeJFQ4BMY8wK8jZX3yxGRtIeAjrL6Mh0r/xUkax+lmrprEwWrz0Kr0dtXrm6jihm0mKg4hN2qepz+RonYu2d9uT291tGOeTxWK2ddLtdtjE/LuPnw5c7z5bV4svEg5oe39Wwov1YJ6qZIUfrPaV97u10w/kzWThY0cX1LHgeewkVzY6lGGt74LYcS269KOICY5eYCtc76NICAodhedo1t91UaYBYYH1Whty1jONJDDNZX2xdCg+t13wWSuc2fYdXCAZbj8e8ahPU3KEkIp9eIsG+F/A9Y4PEp59a5qQkX1w
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: badc6590-d7f8-44cf-4f33-08dc41833bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 04:25:08.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e408ZoIR0yGgzSe4key/M/nw20gysCGrmeWRQEQZ+xW8Ov2Cn3g1uB/+5Zbkx9wpUUjLQ3KZVoCOnoiJVgUMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7362
X-Proofpoint-ORIG-GUID: blP-OX9SnVJOMOHOcGKX1uUVjkL8GIp4
X-Proofpoint-GUID: blP-OX9SnVJOMOHOcGKX1uUVjkL8GIp4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: blP-OX9SnVJOMOHOcGKX1uUVjkL8GIp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02

ZXhmYXRfaW5pdF9leHRfZW50cnkoKSBpcyBhbiBpbml0IGZ1bmN0aW9uLCBpdCdzIGEgYml0IHN0
cmFuZ2UNCnRvIGZyZWUgY2x1c3RlciBpbiBpdC4gQW5kIHRoZSBhcmd1bWVudCAnaW5vZGUnIHdp
bGwgYmUgcmVtb3ZlZA0KZnJvbSBleGZhdF9pbml0X2V4dF9lbnRyeSgpLiBTbyB0aGlzIGNvbW1p
dCBjaGFuZ2VzIHRvIGZyZWUgdGhlDQpjbHVzdGVyIGluIGV4ZmF0X3JlbW92ZV9lbnRyaWVzKCku
DQoNCkNvZGUgcmVmaW5lbWVudCwgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5k
eSBXdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRh
cnUuYW95YW1hQHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQvZGlyLmMgICB8IDMgLS0tDQogZnMv
ZXhmYXQvbmFtZWkuYyB8IDUgKysrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhm
YXQvZGlyLmMNCmluZGV4IGQzNGI1MDI5M2UyZi4uODVhNTY2YzIzODExIDEwMDY0NA0KLS0tIGEv
ZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rpci5jDQpAQCAtNTY0LDkgKzU2NCw2IEBA
IGludCBleGZhdF9pbml0X2V4dF9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhm
YXRfY2hhaW4gKnBfZGlyLA0KIAkJaWYgKCFlcCkNCiAJCQlyZXR1cm4gLUVJTzsNCiANCi0JCWlm
IChleGZhdF9nZXRfZW50cnlfdHlwZShlcCkgJiBUWVBFX0JFTklHTl9TRUMpDQotCQkJZXhmYXRf
ZnJlZV9iZW5pZ25fc2Vjb25kYXJ5X2NsdXN0ZXJzKGlub2RlLCBlcCk7DQotDQogCQlleGZhdF9p
bml0X25hbWVfZW50cnkoZXAsIHVuaW5hbWUpOw0KIAkJZXhmYXRfdXBkYXRlX2JoKGJoLCBzeW5j
KTsNCiAJCWJyZWxzZShiaCk7DQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4
ZmF0L25hbWVpLmMNCmluZGV4IGY1NmUyMjNiOWI4Zi4uYmU2NzYwMjk3ZThmIDEwMDY0NA0KLS0t
IGEvZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhmYXQvbmFtZWkuYw0KQEAgLTEwODIsMTIg
KzEwODIsMTMgQEAgc3RhdGljIGludCBleGZhdF9yZW5hbWVfZmlsZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KIAkJCWVwb2xkLT5kZW50cnkuZmlsZS5h
dHRyIHw9IGNwdV90b19sZTE2KEVYRkFUX0FUVFJfQVJDSElWRSk7DQogCQkJZWktPmF0dHIgfD0g
RVhGQVRfQVRUUl9BUkNISVZFOw0KIAkJfQ0KKw0KKwkJZXhmYXRfcmVtb3ZlX2VudHJpZXMoaW5v
ZGUsICZvbGRfZXMsIEVTX0lEWF9GSVJTVF9GSUxFTkFNRSArIDEpOw0KKw0KIAkJcmV0ID0gZXhm
YXRfaW5pdF9leHRfZW50cnkoaW5vZGUsIHBfZGlyLCBvbGRlbnRyeSwNCiAJCQludW1fbmV3X2Vu
dHJpZXMsIHBfdW5pbmFtZSk7DQogCQlpZiAocmV0KQ0KIAkJCWdvdG8gcHV0X29sZF9lczsNCi0N
Ci0JCWV4ZmF0X3JlbW92ZV9lbnRyaWVzKGlub2RlLCAmb2xkX2VzLCBudW1fbmV3X2VudHJpZXMp
Ow0KIAl9DQogCXJldHVybiBleGZhdF9wdXRfZGVudHJ5X3NldCgmb2xkX2VzLCBzeW5jKTsNCiAN
Ci0tIA0KMi4zNC4xDQoNCg==

