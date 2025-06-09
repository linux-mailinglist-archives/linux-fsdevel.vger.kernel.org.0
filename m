Return-Path: <linux-fsdevel+bounces-51010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A094AD1C00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 12:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B873A8BA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE92C2571C5;
	Mon,  9 Jun 2025 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SRegt26E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013044.outbound.protection.outlook.com [52.101.127.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A93255F59
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466376; cv=fail; b=qG1FPBOIuJzoVc/zAX0vll4KPaRXRN1P/fIbczYfEBbJRofPugBAxNo3pJv3G3NVeVdbEha1DQrwViFYDYp1/Aorn1J8ykoAqDLqeEO0JuCnDSmR1K4BJWLPnXpm71hr7B6CmxLhGtV3aEdnsr1LtbNSXZzpmfsJo7gFFwT506g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466376; c=relaxed/simple;
	bh=nBp6CtW0e1iOLuxsxpD3CJkQ8CpfPQtdhs+qKph6Qm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AGxZmA4IgLukoNw7YN0AoIBY0SQnAbczjzfeGy7JtME/yS776Z0xSzutCqgBoWDYvyhq/zftNWCOduTK+iRqAFlcP1+uBd3WbPi+XzWJKh26murzzjOKyCgLmeOo97kcRroGS0I29vJnJUQQR5SnAbufKpNBkitSBStddqaQAjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SRegt26E; arc=fail smtp.client-ip=52.101.127.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySLmxt9eL7Q3CHNFQBfHtMeM1PU9/V7pZ5NOEUsj6645hDndVJ4WTbwBnU31+U+XB8/TNCZndD/PO4UpMCZydCbNF523lsGxaMZvrGxexgryaRQyczE3mUR/JescS/00V9MNmXhzPwlEqnc3/1gNdPDUArIAE0M2TYWDlkqLQsAh91uws3FauvEWlDrG2VkN77l8wC76j0Xf49L0u13rasECpyThfREn85Xt3kfPanDhM0rdh8A1Bk2yQtfp2NOGJUCSsMRKX+c6Zobebl8UnBjxb7JggLMiWDF20QNxUY7Ua6zXPgyPKKuLeOHBm6+F3sHlhiXU4MoJYpTit6bdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dZ7cxvSjVntD8VIOlnIIltu9MVSNiTx87MJ8slWRtw=;
 b=Enprj8QbkeuGO14JVnmXW9kP/D5W2naPdr5k794t89epqRO83XAM6wFSTO8hPbQhd6uICo1+C6TMtViGBgBwKhpC1R5LV3hDOTRZqukwC7xYwLOdHysLbR1tSxPWOFKLpZ3/xuc8UaBb19naQDPpTBJpjiIcJEChyJGSVmzCN+xYHk+d3C9U85qWfnph2W4CZ6Lb7OS8JHHwy9Hg3AH/Sfcs7tuHApBpugdA627lzsaLW1HC7/CCUAkZ260v5zDNbr4d5S0m0xuCMTGTnZG4ulvDBAG6+yUE6Tfye36BOGKO5bpdebmlcm5RyM3YF56c+3rNWGiTEmQDT8/sjcaa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dZ7cxvSjVntD8VIOlnIIltu9MVSNiTx87MJ8slWRtw=;
 b=SRegt26Ex+hnEdERy+ph+OcJcEXalVfXTmotWbfEzO4xC3SfOMKtbOUx57Jry8SuH/IfvgWjdRa+8W5NY5R5NxZadbukBft5zWPKzCxkCvq+qtk30SE9vNo7oRi66u8K53HmAdcmlqFQ7btskedRphhEb9dE8OZx47oLy9bRq09QLOYxqo1v9a7H68232uJNfvrTFeUG+s22qxPhqMolbM5sVnZzIM75IH3uxlJwvWNL80Jksw6S84sMteG5YRi0L15qHoLzLn7KglfFgxqRkiIxpb2c6ZNxM5l0JC13W7H6L6kgALxevC2X0vZ3Lj4G+hHltW/vEJ7BcBZjKGIMeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KUZPR06MB7961.apcprd06.prod.outlook.com (2603:1096:d10:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Mon, 9 Jun
 2025 10:52:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 10:52:50 +0000
Message-ID: <5b8df0f3-e2da-43d4-8940-0431429eccee@vivo.com>
Date: Mon, 9 Jun 2025 18:52:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [HFS] generic/740 failure details
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <ab5b979190e7e1019c010196a1990b278770b07f.camel@ibm.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <ab5b979190e7e1019c010196a1990b278770b07f.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KUZPR06MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 4512f001-2ad9-4f9f-e17f-08dda743c6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXVvSVNPNGg0aFYrTzhJZU0yem5xQmtNRGlOaWxMeGkyeWtnU0k0NG1LRFl0?=
 =?utf-8?B?cDY0RHdsWU5TeUFlSi9kUVRneE1yYkJ6NDY5UzhrMmFmcklqVkVKR1dVNkVN?=
 =?utf-8?B?NWF3ZGJFejhHa3JGRjBPWGpKR2dDNTNFaHRuL1dsY2VHd09neGRPNG85S2x3?=
 =?utf-8?B?SWVxaHVFM1YrZlpnb2l4TjZsVGFPWE9DaE16TnVuOUQ0RXRXVW5DRzZiU09D?=
 =?utf-8?B?dXk5L1VGQkxZUGgzVFZhQWxLc05maEJMRTJ0QlBZWjBNSExmaVF0eG5QMjR3?=
 =?utf-8?B?RUNEekVNbzN6NkRxZlBicDY5NVhyVmZRdG1iSno4bTk2MVdoOTI0M053UFZT?=
 =?utf-8?B?Mm5SZWdHVnVmSnlpaXM0Y2R1RExyTGF6dUVkSTlEMFpCR2xCWHA0YzUyMjVP?=
 =?utf-8?B?aDh6VHpwaDNpNmRZaUprTm1ad0hrZUpjVytTTVhvb3VuYzBBY0FxUUY2dVFQ?=
 =?utf-8?B?dGJsL3RZYTREdm9CaFYwaHV5Skc0dzVkU0pOWjV3ZlpwcjlZU2F0VXV6TWZT?=
 =?utf-8?B?VzM3eUQ0TzZQSzZac05MMlBJL2tsdDk4SUlNbkl0cmNTdkVFZ25IUnVoMTJz?=
 =?utf-8?B?aFFmekhjOVgzeXA0eEgxK0RYWE9XODRQWjlOMjBQbDk0NVdrSjVxbyt5eE9G?=
 =?utf-8?B?ZHYzYVhsWDlHaGhkS3RRU1I2MWtkUXN6bUlXd2gyYjJMN3lWN3N1amJTRmpP?=
 =?utf-8?B?QTFMTDhISU1yckdiSGtTclFBei9qT0VmWXJ6VmQxSjlXM2tEY3VqTWlQV205?=
 =?utf-8?B?VE1pWHZTV0hOeFZ6T3EwODJPczMrbmhrZVEyTTdZckcvcTYvWE8yN0VjMzc0?=
 =?utf-8?B?K0V3THZvYVp2ZjVwYVl4dUxqYSsySUlEaTNJcWxvY1htaGFSbHFKREFXQUps?=
 =?utf-8?B?NGhGTU0wOVFvWXhweTN4NFVRNmZYS2lHQmY4c1o1ellmSzZVd2FOeUE1ZHhH?=
 =?utf-8?B?cmUwUzVTMUU0K0pHVE9zeXl6RUJBVVhiaFVTZXFGK0F0WkwxUjAyZm5kSHAv?=
 =?utf-8?B?UExHbkhUVU5lWGxVMXFUdWRNcUZkVmpjYktoeHVLQ1pOQk5XazR0c0ljNDNi?=
 =?utf-8?B?RUlURjdoQnMwMk1ucFMrVDBYLzNzc0hhYzdGS2xyU3M3ZFRtVUlIdFU4NmdJ?=
 =?utf-8?B?WkJtWXl0VHI5L1FpTVNDRFVnQXAzdU83NWdZMzNPRThWanNOOFBuVnVoUkxF?=
 =?utf-8?B?dmozOVUvZ2xMSjNVU1RidFlTUzkrSGJoU0tUWGtBR2pqUC9aZ3BZMkw1eUZK?=
 =?utf-8?B?K2hMV1VMZnFkVVJ6MnBIeFpOOGRtNnBBbjIzWXZwN2RuZmZPK1dJbDRLNy90?=
 =?utf-8?B?RXZEci9QNW5reEhGcnQ3UWwxUm5XQWR1aTZ6SG9rUUNUNmlxVWd4MUhOcWNF?=
 =?utf-8?B?YVVBZ0h2VVRTc3ZaQitiYkkvVkRjUGpGeFM4MkRhNjNHTjdwcmNxZXV5a2dE?=
 =?utf-8?B?ZFg4UWZyeEtoY3J4UkVwQnA3S1ZSYWNlNjZEUGFxTVRuUU5oTEtnL3FUQlhm?=
 =?utf-8?B?YldLNWJUR3RpaWJNYVlNbmFsaGJ2b012bHVSUGNsZzl1UVBaNTBKbncwc3BG?=
 =?utf-8?B?OUp6WWw5YzYvWVV2Yk1YWXlOUHBUUkN6K0RNL0RhdldFTW04S3RBZ2hZa1Iy?=
 =?utf-8?B?Qm8vcWNNZldPNFpYY3dyQlRiT245cDVabnVxSVhDQnJHSFhXejJFUkhlR05I?=
 =?utf-8?B?VkQ3TkxISEZoSnMzTy9KNUdyN1hLSzdyY0VxZEpIdjU4ZDh2K0ZnTEp0bFRU?=
 =?utf-8?B?MVNxZnhZcE9laXNxTERIaG5qUmRmZE9iL0JWZ1RaeHBYa1hwSkNsOTVpUXhq?=
 =?utf-8?B?WlVzMzBvM0hjVGJ0QWNoQTNWTzBvWVQyUG8vZmNRaGZZZDRLYUYya0gwTEJ2?=
 =?utf-8?B?RjlnRWoxNy9JNlhXcTVhb1VKakJ0Uk5sSzNFemdyWmNBbnhXTmlrdzlaSDlt?=
 =?utf-8?Q?HEu+g/8PeUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmFUTTRGcFh0L25xY1JjcDhPaDdhK2xQMFVxSTk3QzVWdS9RdHllclJ6VEQx?=
 =?utf-8?B?YlRWa1ZpZC9QZklZem95ZWJCL2pqaFI0N0tBakdCUXBSV0VTY0d3VUFzdjZF?=
 =?utf-8?B?UXh2MUFiVFFjSGVjUDA1ZzRXeXBxb1JkRFFLTFVCVEM4SGpxN3hOOXVnalVl?=
 =?utf-8?B?MHIvTWJCanZMRUREWno4d2tMUE9rMmIyZXM2RXVPbGU4aXNKbXZPNTNhQjJO?=
 =?utf-8?B?ZWVvZ0o2SVRWcVQxbEtwcHBtV0R4bmpwRGx1Z0VxNTRYOTFlR1dIZkh4b25G?=
 =?utf-8?B?b0ZGcmlpdW1pOC91TmVETUNDWUJEWWEvaXYzR2xMT3VIOVpibTkxbGdZbkc2?=
 =?utf-8?B?V3NxWkxVSm5tZzFFOUloakNONHZ3TGpLeEp0Q3U1UmhkS003YkdsZjdQdmVE?=
 =?utf-8?B?Uk9ocDllRk9lMW5uYVpnUDVNbUJBRG1EbDFmTnVCQWNZZTNsU1MrbFRoNFhC?=
 =?utf-8?B?dmgrUnhNdzBjS2pTMWpDZFlpcXRacEgzOVkxUGpFVzMrQVBPZUhkY2J5T3Nx?=
 =?utf-8?B?ek5DQ3JJOWh3Y2d6OVIxdEloVjZ5a2JhTDBQZVprZ3pZTEFFL3o4NW9UV0R3?=
 =?utf-8?B?eGZ6REtBcjBJQXVPdmdINlI2VlhMWEZIWGVnelBpeE9ndkV4eDZVb1NtSUFN?=
 =?utf-8?B?RnI3UUx0N09NRGdBN2lyQndhZkgwRlZFKzJ6cVdsVThOQ2Q4clRtb0NXRENm?=
 =?utf-8?B?MGtYTno3L2Y2a3MyV1VQbFdQL0duVDZ3eE9leVJEck5aTVdMRHlOV3VTZnNj?=
 =?utf-8?B?amM1T3hsYXBVR0JONTRQaktKejIxeTlKYzZTNGtBV0lYRnhZM0dFSEJ4bStX?=
 =?utf-8?B?TEZGQzNpODlXMFNmMG1ENUVWODVIeGVvcUZqNmxPcEtRSUt5SFY3ZVRmMlk1?=
 =?utf-8?B?R3RMeVVQaXluL0liVmNjVVRhdmNMRUdvZTFDbGd1Wlp1VXExTVJZMk1qenBO?=
 =?utf-8?B?N1luNTFZQ1NRdHZwMFdNZ0ZCYkVDSnZjTlNqZFJLbjVaS0FCOExYSVJMajBW?=
 =?utf-8?B?ekxLMVFxaG90aloyaTNuNCtnZ1YrbXdPM3pwTlFKS1drRW1wTGFvRWFwaTF4?=
 =?utf-8?B?QU1OMzRFN29PMzY0ZlN5N05JdW1MMGoxMDh1aDV1M0RtZmNPOFV1MFlNMUtO?=
 =?utf-8?B?Um9nMUtjVTVCTkpRSEdOcXorZnhaV2p1N0pDMndRd3BTSU5HazhNSENLR3VW?=
 =?utf-8?B?Z3ZaK1RndXVFMjdCblc5aEhHRnU3YTR5RXBBeDZQRVFBd2NmOUVVQS9mTnUx?=
 =?utf-8?B?dEFFdk5ackFhNTBNQUl1TENmaEsvQjBpL05PRXpUOFBYVVpEdXl2ZlcrZEox?=
 =?utf-8?B?TmhPV2M3S0ZhZWNXVEIxNHdYWUtqQlk0VTJHMjFUYmU5akVSNFFoSlM3R2ZH?=
 =?utf-8?B?dE9EbGtlN3lrdnpVOHpHUW05bHB4VUMvNGtBVnRyVzlTc2Z0MHM3S3pBc3hp?=
 =?utf-8?B?aHR6M05BcFhoWUd6Y3BlOEtwSGxHM3ROODhXNDhCYklRRkMvUDA4aVB0RUt6?=
 =?utf-8?B?Z0pqdnpUM2dLK21keXBRWk9ydHlGL20yK0dEaGZSb0M4M3ZtOHNLT1I2cW9y?=
 =?utf-8?B?dkUvbmNtUWZmVXhuNTNLMnkvZFlyd2phcmxZWWJmYTVYK3BmWUVEdmNDc1dV?=
 =?utf-8?B?WHNZYmRWLzJ0U0JsdHlrNWxaQjhlNnFIeDJlMkExQW5PQ3N2SXo2eGxCNVhU?=
 =?utf-8?B?UUVKQ1dueVExZ1BFUko1RTliTDd0QXJOb3haYUtidzZBem9HZzVhbTlBRERQ?=
 =?utf-8?B?ZElIRW1KRkRxQnNJQTVsYXl3Q1ltcFFZelVUbzN1T2M2VjdSUFZxUGtDUmZC?=
 =?utf-8?B?alovTVQzMnpVWWtSaXI3UGlmNndRYUd6NDFEQjArcFU0VXQ4WUxMVHV0akdl?=
 =?utf-8?B?T1dsdU5Wd2U3YUtLZFdJZTdoOHZ4djFZSG42ai9ySjdDVG42TkJtd2NqV09T?=
 =?utf-8?B?b0hlZUljeS92T3JTS1FvL1RqNnF5cmFIRCtQWmRROVpxVnRmMTFJQmh3RFhD?=
 =?utf-8?B?b2hXMlJ0UWhIRXRWK0F6SzJaUmx6NmM1Qm1udnpnNlMrSzZWdEQ3WmdselQ1?=
 =?utf-8?B?cjBvYWNpTHd4dFZUU2ViZGVZNEkxNHowTEx2eC91MjlFLzc4UmdnQXB5dVJi?=
 =?utf-8?Q?gaAE/UnBve23klhbLmFKVF86E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4512f001-2ad9-4f9f-e17f-08dda743c6f8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:52:50.6029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpZoR5o/qIuBMAmLDvPL0FPk4zYJz7MabFqNClKaLfIRgtvUdyDvGsRMNQd3YxjsNMXaxfXpFvW2Huk9Xql0ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB7961

Hi Slava and Adrian,

在 2025/6/6 06:41, Viacheslav Dubeyko 写道:
> Hi Adrian, Yangtao,
> 
> We have failure for generic/740 test:
> 
> ./check generic/740
> FSTYP         -- hfs
> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP
> PREEMPT_DYNAMIC Thu May  1 16:43:22 PDT 2025
> MKFS_OPTIONS  -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/740       - output mismatch (see /home/slavad/XFSTESTS-2/xfstests-
> dev/results//generic/740.out.bad)
>      --- tests/generic/740.out	2025-04-24 12:48:45.964286739 -0700
>      +++ /home/slavad/XFSTESTS-2/xfstests-
> dev/results//generic/740.out.bad	2025-06-05 15:25:18.071217224 -0700
>      @@ -1,2 +1,16 @@
>       QA output created by 740
>       Silence is golden.
>      +Failed - overwrote fs type bfs!
>      +Failed - overwrote fs type cramfs!
>      +Failed - overwrote fs type exfat!
>      +Failed - overwrote fs type ext2!
>      +Failed - overwrote fs type ext3!
>      ...
>      (Run 'diff -u /home/slavad/XFSTESTS-2/xfstests-dev/tests/generic/740.out
> /home/slavad/XFSTESTS-2/xfstests-dev/results//generic/740.out.bad'  to see the
> entire diff)
> Ran: generic/740
> Failures: generic/740
> Failed 1 of 1 tests
> 
> As far as I can see, the workflow of the test is to reformat the existing file
> system by using the forcing option of mkfs tool (for example, -F of mkfs.ext4).
> And, then, it tries to reformat the partition with existing file system (ext4,
> xfs, btrfs, etc) by HFS/HFS+ mkfs tool with default option. By default, it is
> expected that mkfs tool should refuse the reformat of partition with existing
> file system. However, HFS/HFS+ mkfs tool easily reformat the partition without
> any concerns or questions:
> 
> sudo mkfs.ext4 /dev/loop51
> mke2fs 1.47.0 (5-Feb-2023)
> /dev/loop51 contains a hfs file system labelled 'untitled'
> Proceed anyway? (y,N) n
> 
> sudo mkfs.ext4 -F /dev/loop51
> mke2fs 1.47.0 (5-Feb-2023)
> /dev/loop51 contains a hfs file system labelled 'untitled'
> Discarding device blocks: done
> Creating filesystem with 2621440 4k blocks and 655360 inodes
> Filesystem UUID: 2b65062e-d8d5-4731-9f3d-dddcf1aa73ee
> Superblock backups stored on blocks:
> 	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632
> 
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (16384 blocks): done
> Writing superblocks and filesystem accounting information: done
> 
> sudo mkfs.hfs /dev/loop51
> Initialized /dev/loop51 as a 10240 MB HFS volume
> 
> It looks like we need to modify the HFS/HFS+ mkfs tool to refuse the reformat of
> existing file system and to add the forcing option.

I wonder if this is a good time to reimplement hfs-progs in rust.

Thx,
Yangtao

