Return-Path: <linux-fsdevel+bounces-49986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC37EAC6E21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E256F7B1C0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30328D8EE;
	Wed, 28 May 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Mt+XyesU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011054.outbound.protection.outlook.com [52.101.129.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355528CF7F;
	Wed, 28 May 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450288; cv=fail; b=MzKG9t/c0mc1jHX32RUCElbKNN58HJGyqgaMKTPco4M8zIsJPHzjACkbILGOibJH1NUFge1/GK6X4Wktsgmv5pqp8D3dA5RkxylwLFSZEZEepNOiY8JElidCH63SRhX9PdsMgmZT0L9evmpr7YLNVZMhpKjzB9VUvKKjm9hKmE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450288; c=relaxed/simple;
	bh=Yqxkh0sworeC5UMhi11SqhrMb0Mj7pp7oRw/us1MEQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qak/9b2fTqC9eMs1GdEceNdlRzL4qd8/Lvig/25tGYjgUyj2NnrHtVB+TtNehg06NESRRfgDnONHknkI9ZauD8w4CytgYFU3n3IC1H8uDr9TNr97fofli1aG9/I1ydrB9Os8FQXgfTUdisscA5f1h2JnqvcRrYz5Pici2PTmgZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Mt+XyesU; arc=fail smtp.client-ip=52.101.129.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUkr5UN0T7R3EP7DlEWYb1qgcrXKdxePlDiwFejn3Dqe+stiT9UxQWs/QuF9P7WYkjyoSd0K9quvZSO5luR2m/E9KgF5Rk5QPxdwNpOmMAVX9WIziie3NJl+dlzEdC9cpr8hGKSxZqEGmD11mLrC54YnhOWzIbmmUOKYviHCmO2fvke7d+4FUpUQSD0yuyZEIo24ykPWTocA7zBX94v3rDSHRx0FO6r5KI3G3IsdLLhDDEMav+cxmB8EVpeMAg9g5/b/pVxbb7uzkO6/fYUP+a03e3cd4WSJPZDGGGd0lkK03vdJugOZTmb/Ta6fjydq7oWaZbxVxygtkyBiwEiHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yqxkh0sworeC5UMhi11SqhrMb0Mj7pp7oRw/us1MEQc=;
 b=Q5t7J+o3rDiDnw1Y/R1dh8zMk+SSmHbKtcBfscjxi76vRz29gSENVQy61hwUox66xCBrgF6Sx6RIW3spPAZuZPFMd8hCb7j3sQh4Fjj2XnPGESSn6hztx2sRlfT+Ak4kwQVLp0RbYskpcISLT73f+ZsUqj0nniTZIGJebY+lWqUWQTdNaAREp1Op1gJrk6ccdrF2GiFHlQ/LJmC49/Jk+7lv00NNeNS3g0UFp4XSpmDrza9KvLQ1bMVGA158cneDcFXmq/exm+bBgUWh9GZR/4/2l+gQadrPHxzG0Fm1ASFNi6hNNwap+23ALHCeTNdCDwQIhX+IzZEK2eFy0yVG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqxkh0sworeC5UMhi11SqhrMb0Mj7pp7oRw/us1MEQc=;
 b=Mt+XyesUeKn7oFzLlcI0jM5BKmYwXEVOvfCQsjwbZVLTS7C3A+k/vovd/REhMRUiG49gUXFpsAzsdr8kacf52M9/UWZSiearet7acX0deb0Ek2QaaqODOBNmEdm0m+k2TEMn9K+YpINk4R0A2nLWPE7fQNj4YwRfAjIvie7ExSrDPXyoDKlrjXN9eFA5/M3O7O0z2x/z/XOuK+a+M1BxCqCHdihTLa0z17VlL7JvnSi9lq05csPTIMczU33kSKz+hXJPge9rJQJFkj24lwPeII73i4ZiIcWh15Mxxh3yxPSO9oqixebkW+faDIWmaJsiPmdk+OS3sCVYKkkJCNcfCg==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6190.apcprd06.prod.outlook.com (2603:1096:400:33f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 16:37:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 16:37:57 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi8zXSBoZnM6IGNvcnJlY3Qgc3VwZXJibG9j?=
 =?utf-8?Q?k_flags?=
Thread-Topic: [PATCH v2 2/3] hfs: correct superblock flags
Thread-Index: AQHbyNuJv/srDI0VbU2+b3+qqSvHfLPnHcmAgAEtSsA=
Date: Wed, 28 May 2025 16:37:57 +0000
Message-ID:
 <SEZPR06MB5269D12DE8D4F48AF96E7409E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250519165214.1181931-1-frank.li@vivo.com>
	 <20250519165214.1181931-2-frank.li@vivo.com>
 <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
In-Reply-To: <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|TYZPR06MB6190:EE_
x-ms-office365-filtering-correlation-id: 105b1226-8f7f-449f-2d1f-08dd9e0600d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REJjWXdjclVCZk5TNDFodmRpdUhaTXRNdUFkS0dyTHpWRTBsakJrYmNwVFE0?=
 =?utf-8?B?eWgvL2Mwc2lXQlNBTE8weGZucXNJaDBBa21oQjBFWHp1NUk4QitVaGpSaXpM?=
 =?utf-8?B?RERwVGZlRE80dElmalBUcjJkbjhJekt3RmVCNWVPQmQvN0lzYkxENXFiSmhO?=
 =?utf-8?B?bjhqQmhMMlRmeCt1bll4dCtHL1E5ZVA4akZua1dPMEN3NDl0MFVORWYvTTBE?=
 =?utf-8?B?MkIwM0lKM1BYYXZjYmw1WVNFVjArTTA5czladFg5Zk13WFBCSzhLZnBlTXJa?=
 =?utf-8?B?dnVyaWc2Zk85Tk1jM2hxYS9qVkFsY3BzbDZJZVlXc2hWNzJDUzc0d2hRRldP?=
 =?utf-8?B?RUk3LzBmWE0rY3E5bk9iRnpmaThHejBxaTdpbG4zZ2hpRnlaS1NKVmRTNmZ5?=
 =?utf-8?B?b3cxQnB1Vlg2YmM4NmlmbDJ0RG1rOE1sYWF6YW1oL1JZbVZqK2pVT1ZPWGtN?=
 =?utf-8?B?Y3d3SWV3YUFKSVhnWXAwRS9DLzJsemVCNGZQRlBjN0thbmovSDFQbk1qc3Iw?=
 =?utf-8?B?YlJCVlpzUWQ0KzAzdWwvVEN4YndyUy8xTWN2WkhGMXpZNXNPQndhQ21DZ0Y4?=
 =?utf-8?B?aWR0Yy80RkMwdldpcFRWL0ZhVllvMTlXYmJYVmdEOHVzcEIwN01RdE9icUhK?=
 =?utf-8?B?VGkyaWZYcGhIMTJRZTk0ZkJSUzJsSWVHYjhjeUhKU01xVmRzVTN3ZnNHU29r?=
 =?utf-8?B?WTBVbDM5SDBJTnZ4eXpGOTc0L3NlTWovRlFScFY4RGhsUVNzKzNsS0tPNlJy?=
 =?utf-8?B?NG9rM2g4TkYxTUdZNytaa1VtVzBDNUNkOERReDdyTFNIdXBoei9sM3JwNjda?=
 =?utf-8?B?M1VhVG83bGQ2VXNhMDNjRmRPVVlvZFBwd1hZUXFXY0xFKys2V2hpQkZJcXd5?=
 =?utf-8?B?WitBdUxNeGNPVGl4S3pXR2NUTjdZR1EvK0JCejE0QmF2bzUrVjBYUVlpbGZi?=
 =?utf-8?B?YWFrVGY0bVAvUjNibnZ3eEw5TUlpcWJUdFVOLzlUWWV2Z3pWUi9qbmFEeTRN?=
 =?utf-8?B?aTRsSVN1SmhhNVliRktNNXZwN3RKb2pvRGxHK2oxanBuUWRtMHZNbVlhZExB?=
 =?utf-8?B?Ym03cFVockFENXd1bEtxcCtpVDl0blhlNzcwNS9sb3NXNUthandLOURQMkMw?=
 =?utf-8?B?NUtydklNaHliQmZGRFUycHM5TXFySDVmaG5GcEJ2U3N3ZXZESGFSK2puanJD?=
 =?utf-8?B?T0tMVWlldlpMbm9TY2dpVnNuZk9jK2FSWU1wZWxvYllUUHlRc0gwcllMQlJU?=
 =?utf-8?B?V0lSQ1dUR2U3OFAvU09tVVJ1L1AzWDVWTVk2RkhoUkNRZ1krVkNnYjNhUWxR?=
 =?utf-8?B?OFFndDlaUTZVbDBPbG1xQkdwT1hCQWRkWUgzSGxtMzJVOWVQOUVVVWZNaWZi?=
 =?utf-8?B?VGhUNEtiS2JvMzJCR1I0SzIzeTBoSGdCZkphZEl1MGNkMmJEZW5tS3lWTWs4?=
 =?utf-8?B?STJmQUFOeGpRT1NnMGtDVXBIbExFRmI0Y0JGWlRNL3ZDL0tQc1NoUDE2b3hM?=
 =?utf-8?B?MzkwSlJXN0tBR0JtM2lNZmtmWVZ1Z3poSy9vZnI2MmxXUXNQRytyN0FOdld6?=
 =?utf-8?B?Q21oa0tCUHQ0TE0rYnJPcUxOUXV6S2lYY3FLNFRobkpaQWV2R2Z4cVh5amJX?=
 =?utf-8?B?LzRlZ3pwSnYwVFpQbWtrQS80MVNyejBiVVJSdjh0OWJDQ1ZZMlZOZzFMbEg3?=
 =?utf-8?B?KzZzOWZQeVZGMDczdEhwcENTQ1pHZm9KclIybzhibUpCQmU0WG1BaXlvbzNw?=
 =?utf-8?B?bmhqT1pPdjdnZDdMYlk4d3VVMCtvVVB4MEJxa2IyTkIrZmFNTXFML25EZUg4?=
 =?utf-8?B?V2lwT1RhWUxHTkNxNE9yVXo5L1g1VzJqUXhSLzZHQVZyMDRJV0d2U0RUa2kz?=
 =?utf-8?B?bzBjaVFKR1BGZnkrK0dCczhid1RGY21adW0wc3luZnFTMlNRRXpheExZQnpy?=
 =?utf-8?B?eUR6aTFNcUFkVkxVRitYL1RBNWFaYUdGanlKYmtiT2hnSmdEQWVMNktxZUZS?=
 =?utf-8?Q?wBHcgFNDRG4LaWSK4EEg8CugFBQ5AM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjJsakxyazlZUk1zWHhHbEx4M1RoRVFqVlFHNEZDNFUwSE4xNkt4TlhGV2RR?=
 =?utf-8?B?bWdaNURJYmVFOFRnbXhPR3JKWmpuYWx5R1dyd3IvS09CTzFqMm9EQlVhd21j?=
 =?utf-8?B?TG51bkp5Z0xTUXkxT3VrS3RzT2U4aS82Y1dTQXVqK1ZDZGlMSUxFOWtqR3pQ?=
 =?utf-8?B?aFh0ZmEwVk9BUG9ZSGkvTWpkc09HL2kwNHkzejJjNEtwblVXWFNuSjh0bDVa?=
 =?utf-8?B?YU9lTkgvMWFqSnJsZlVHeUNmYTUxdEtvNFBtMUI4OVorNnJQZVlYUVI5MEc4?=
 =?utf-8?B?a0tiT2pFRVdOcGdFZGJCY0tjeWg3TjVTb3lqbnVMNmZ4QUJIVU5RZ2ZZZUtl?=
 =?utf-8?B?M1NJMnNLU1FLbUsybG5VMmE5cWtwVnA3VWpwQ0xuQ2NTbkw0emtlQmgvOGx4?=
 =?utf-8?B?NFJnVjFSckM1QXBVRGVCcnRXNDdqbTJKVnlmYmFmNXBNS0tBczRleTIzTGxW?=
 =?utf-8?B?eFk3eWpDQ2ZmNkk1TE9sUVZlRUZsekY4SVdVdVFibWxpTFMzYzRqOHhaaHpI?=
 =?utf-8?B?c29uQ2ROUjhLS2FnTGxNUGVHaUxMV1R0MGcxcEpqRVJQRy92QWk2RGVBaWpD?=
 =?utf-8?B?aHZJTW04TFJKdmlYbXhHWldCeEs1YVc1WVhFTlUzdnowNkh6YlVmOGpBbDgz?=
 =?utf-8?B?ZytYZ2VJNVRpcWJ1dDRZRFR4U0N6bGVlM2cxMTNrZ2dPLzJTWTF1MkR4bFF3?=
 =?utf-8?B?anNVR0xUdWRDV2VBS0RLakZYdTdvWEMvUGEvaXBXWnYwdE1YcVFwTU1pM0lK?=
 =?utf-8?B?dkgrQjBYeFA2ZFpGWE4rUG9BYmpHYWZHemxIZE0wREFlc2N2U2VpR0hzQ2JS?=
 =?utf-8?B?cHlib1dwQ1p2WlZ4MFNreEpFTTloaTZ3akdPcXdGdGdmbnpWWWltRFo4V1hD?=
 =?utf-8?B?VmJOMDhkRlk3bTE4TlIvdU9FMWNab0Y2dTA0MDA1NGwxbWdnMU1JTzdaNDEy?=
 =?utf-8?B?WjlNbkRBVUZOY2hXT1BxTkNRSVZ2MGhiTEFGQmxGc2o4SG1QZFhSOGMzMHZa?=
 =?utf-8?B?T3lGclQ1SnREdThWK25ZWXg0NHlRc1l3RTdabDZMQTZCVGJhTVR0R3o1aUJz?=
 =?utf-8?B?REdFV1d1Q2VKQTdEYWExcDJOTkl1dTZoVXRIblByZVE1WFgzdFJVTGl3ZGJr?=
 =?utf-8?B?emlCOUZRaU1QOVBjRUxFa3M0c1l0bVlGSVg0R3cyVWo4aXlLSzlHSnN1RHBu?=
 =?utf-8?B?bC9vOEhjeGVSTmxEZU9iaS9ndEtaMERPdlI5S1pxcHVQZkU0OExrTWEwNlVZ?=
 =?utf-8?B?WUdsSEZMa0J2UHhZb0JoT1RpZWZtbHlNanlhRUhJZXhreG1VeTZnb1FMK0Uw?=
 =?utf-8?B?cDFhYUh6SHB6RlVaRWp2cWM1UjZic0FWcGJvRVVvRCtLVEhjQ3BIT0ZreTdv?=
 =?utf-8?B?T2RlaEtqcDJIK2tKTjYvU1U3cm9XRGNWQW50VE1pQTdzaUphNTRsMzJyT25a?=
 =?utf-8?B?VkQ5ZU1TdTNFbWJvSzlEaUJnOWgrMEZCYTRPUDE0WUlmVnRCK3hPdFl5bG1O?=
 =?utf-8?B?M2xQblM4eGtjeFNpNUs1THNkQnl2cDJGYUdoM1prSjZnZUFvZUZnVHJVVEpz?=
 =?utf-8?B?bEhRR3grYzEwVk90K3cyNTJMOU12dlJJM3E1RVdiVmdrOHhJK25jMW9aekN0?=
 =?utf-8?B?aTJzSGEwN09oVWF3eGlSaUg5eXh4UXJaODRLOW5TbGxOL2RSNXZuYllYMnVZ?=
 =?utf-8?B?dEd4VnpzWUNyTXhJMHBxT0xienBPOVBVQWlpNGl3bHVPUktXdUF0Z3R2MGZj?=
 =?utf-8?B?SlpzZkthcGNrNTlLOGxKUTZoU3JEVXlKN1lZQ1Nrd2xManE2SERUaTlqbDMz?=
 =?utf-8?B?UlV6Q3ozam0ycVF1dGVqdThtYUtEY0dXbkxKalluL2FMNkVpYndsWExxRzhP?=
 =?utf-8?B?d2doWHFYeld1THlXdnlPQ0xuWEdzNnNzS3J3K0ZVRlY0dlJkOUJnTzRJRWUv?=
 =?utf-8?B?UjRWRklYT1VHRnovdWxnNVl0Nm1kR2pxdXkwM2RrYk1ZVjZraW9CVndMUjBB?=
 =?utf-8?B?L0laZjNCbjZMaDVlS1pBZmFoQ2RiTzJldlpwMXN3VDI1TThhRnJheXJFUG83?=
 =?utf-8?B?cmFCc1RlNzQzK1Q5T0MxMzNhUlpBNFdud0hxUk1WRlV0aHNqMHp0NUkwNWMr?=
 =?utf-8?Q?lYXY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 105b1226-8f7f-449f-2d1f-08dd9e0600d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 16:37:57.6609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8+Jwp7RgJosSOsCbPOt3ClN5xr7somr5iBaFam+c/wWawczA3Fmd/wRCHd3NkP0TtqB1KxDFJJJ11HizIxF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6190

SGkgU2xhdmEsDQoNCj4gSSBhbSBzbGlnaHRseSBjb25mdXNlZCBieSBjb21tZW50LiBEb2VzIGl0
IG1lYW4gdGhhdCB0aGUgZml4IGludHJvZHVjZXMgbW9yZSBlcnJvcnM/IEl0IGxvb2tzIGxpa2Ug
d2UgbmVlZCB0byBoYXZlIG1vcmUgY2xlYXIgZXhwbGFuYXRpb24gb2YgdGhlIGZpeCBoZXJlLg0K
DQpJJ2xsIHVwZGF0ZSBjb21taXQgbXNnLg0KDQo+IHMtPnNfZmxhZ3MgfD0gU0JfTk9ESVJBVElN
RSB8IFNCX05PQVRJTUU7DQoNCklJVUMsIFNCX05PQVRJTUUgPiBTQl9OT0RJUkFUSU1FLg0KDQpT
byB3ZSBzaG91bGQgY29ycmVjdCBmbGFncyBpbiBzbWIsIGNlcGguDQoNCjIwOTEgYm9vbCBhdGlt
ZV9uZWVkc191cGRhdGUoY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsIHN0cnVjdCBpbm9kZSAqaW5v
ZGUpDQoyMDkyIHsNCjIwOTMgICAgICAgICBzdHJ1Y3QgdmZzbW91bnQgKm1udCA9IHBhdGgtPm1u
dDsNCjIwOTQgICAgICAgICBzdHJ1Y3QgdGltZXNwZWM2NCBub3csIGF0aW1lOw0KMjA5NQ0KMjA5
NiAgICAgICAgIGlmIChpbm9kZS0+aV9mbGFncyAmIFNfTk9BVElNRSkNCjIwOTcgICAgICAgICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCjIwOTgNCjIwOTkgICAgICAgICAvKiBBdGltZSB1cGRhdGVz
IHdpbGwgbGlrZWx5IGNhdXNlIGlfdWlkIGFuZCBpX2dpZCB0byBiZSB3cml0dGVuDQoyMTAwICAg
ICAgICAgwqYqIGJhY2sgaW1wcm9wcmVseSBpZiB0aGVpciB0cnVlIHZhbHVlIGlzIHVua25vd24g
dG8gdGhlIHZmcy4NCjIxMDEgICAgICAgICDCpiovDQoyMTAyICAgICAgICAgaWYgKEhBU19VTk1B
UFBFRF9JRChtbnRfaWRtYXAobW50KSwgaW5vZGUpKQ0KMjEwMyAgICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KMjEwNA0KMjEwNSAgICAgICAgIGlmIChJU19OT0FUSU1FKGlub2RlKSkNCjIx
MDYgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCjIxMDcgICAgICAgICBpZiAoKGlub2Rl
LT5pX3NiLT5zX2ZsYWdzICYgU0JfTk9ESVJBVElNRSkgJiYgU19JU0RJUihpbm9kZS0+aV9tb2Rl
KSkNCjIxMDggICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCg0KVGh4LA0KWWFuZ3Rhbw0K

