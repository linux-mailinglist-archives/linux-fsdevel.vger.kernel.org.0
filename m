Return-Path: <linux-fsdevel+bounces-56118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E533DB134D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 08:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EBC173A0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 06:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F6E21FF49;
	Mon, 28 Jul 2025 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gO50dxp/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CE86344
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683494; cv=fail; b=c3g/rZxaxX8yJRks6YZT89zOBGsbHx2ravBlcXncd//tMQ/LExweKwPu3X73jMvGNNtoKH+yK4/gPdk/yiUs4JhPQxpQUaqkEXkdH0KSDjaKhsM5OYENb03uBtEiDL/3TA481FtyYHr0GkwwVOBWtEcCBftCMOqSuXa41xJIHSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683494; c=relaxed/simple;
	bh=LQilVTbb3XcT8o8ND/cV4Q7HocMdelvibetpgheQ9PQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KRWe3OAgx3TfSJpYDcdOrWyxkA2IMP+NeHvfLpUP687Pm2AFSR2D+SOkS8WAHFP+E+HCqGQiFk20t5Vkodm+g/rmp6m3vSL+PYL0Ncv+HTakuN28BwF231ZP1R/1IstfD5SPtjUu9c+5UXBZxgjLze9HZ//i23Ns0snCyDXDoIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gO50dxp/; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQkio20cRHZ5UxEkcS7oXuriEl8Q4eQKHBjpxgIMmwKOK7ouls+0p8/e/V2l7Kz6qYXmoNWaCqHgsdXn90u4GXmjQR32icR7/8B+YSZa0Rp96uhrrT5yVBNi+zERmxcmsmEW5TWhvU0t/jtBANQMttqarYDrnpatEjAwHhtuC9W8EyIQpkBfIvqMgRonPJiiOyB9+X2E5d8zkw+kZHIXOse7t7dkmqSiejmpiYPobM1zOMHe7ikZGoYrVQF+sQU/MSp01hsSCCZ1Ok65FON9vhLtSJ6yhW1sJKLopJJVcQ29DlSe42yjhf7plcyWDbZ2cP4PFcK9g+eU+HhWLl1/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfVLGW9QSZ8X82DaoObnNgcPS9L4GaL2YdNvAvzvQKA=;
 b=NmUVD6yVBzbLlWd2AzLppb+yfs/tONAZ6B0gzUfQ3SvZPFMkyIJrXBuM8i8t+L/9p6b/5iWCc6y3SGue9bjxQuhQ47PWvryM11cNf/y/pG2WXy2M4H5fO6OvC0HmOj3TtP5fTFTnOmpiEpVUmXAX5CD+Nxn8LaGqsU2NGYaltjVDCZ08CXJKgsrtADHRCzUiQWHgPf+uX2DSZJn653D7Kf1k1pZ25F3E22QPwQ2wmIExhvjemqM8VgwiTGbNW0iLz+s3aKE1aHoMdbpz2YZfau8sZh8gm7A43HVMSxb2vRZaJclevKD+3J58TbsrB6VqQ1ylfr+H9iHEUkMgNhsXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfVLGW9QSZ8X82DaoObnNgcPS9L4GaL2YdNvAvzvQKA=;
 b=gO50dxp/INlZqLKSixN0kXLPLF4q6Dx6R8rtpYAuoexFkhziifW2iXV8mA+YS4BBqK50D3IJOzT49Tp+0JzEUxJxXBhZaIK/L+6bUghADacTwkUlVxx4AWft/DqrgDNppwuPqvKfsAu89Tl0tNtKLuBr2BD9Xr4Z5GrwnP6Qf9pX34urcWPskglsBUbeatCwOj0B4lGFZM5fntqUjhzj+DuaUkD/jWYG/sk/L61AXXzolZDUGcKXl56/xhmPerac1XY9hHn60+xr7CxWezzd4VXcf0EQXGM0nvJwbxew3DVApQgfImWjmgRbv7YyGe75jx0gDHVhG44+TWAH8MP9Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SE2PPFCFB43FE7A.apcprd06.prod.outlook.com (2603:1096:108:1::7ea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 28 Jul
 2025 06:18:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 06:18:01 +0000
Message-ID: <feb8ff05-90a9-4ab4-a820-99118918cd2b@vivo.com>
Date: Mon, 28 Jul 2025 14:17:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: fix general protection fault in hfs_find_init()
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org, wenzhi.wang@uwaterloo.ca
Cc: Slava.Dubeyko@ibm.com
References: <20250710213657.108285-1-slava@dubeyko.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250710213657.108285-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SE2PPFCFB43FE7A:EE_
X-MS-Office365-Filtering-Correlation-Id: 086dd4ca-2a0b-447b-2c5c-08ddcd9e80c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkdCS3NTelQ1cDRRai9uUG96M3N2V0V2UlZUUUlweWRPUDlEbVZEYXRJd3ox?=
 =?utf-8?B?cXUxemVOWmI3NitCMEdQem1RVTdjNUY1OFNQQVU1ckZ6Z3NnVHVQNlV0TWFE?=
 =?utf-8?B?aEp6eDVKSk85RjRTcHd2cUUrV3lTZTVUeTBjQWZJZ2t2eHR2M1dZWHBJU1hk?=
 =?utf-8?B?d0J6RmJYcDFEZ0RRQk04QnBtbENUbzJGRDc1Nm12VzdIc3pKWG1ScTVBWU9i?=
 =?utf-8?B?ci9BanMyU0tYZzZPRm0xbnpQRDFDT1hDQU1ZYTU2SzIwR2lZS0QyaUNkWVAy?=
 =?utf-8?B?UVByNE90VGhEYlNZVVJnWVBYbDUwQjkxaUtmb2tjNDhrdW1sc2lZbm9heDhl?=
 =?utf-8?B?S2FoZXlraUZoQ1F5a0ttVmM4Y1dZeW9CM0FtZ1k1WUZQRUJKN3JBL3huSnN1?=
 =?utf-8?B?WEd1TFJnWHBqMnNlS2NDaHMvRU0xOXhxSlV2emZmbDFoZnkrRTdpQ0hJK3hy?=
 =?utf-8?B?WFRINnp3RzlwRWRVVkNXWEhCU1BoNzVWcmg5UXVXVUNkOVljOFZPaUdDU1lI?=
 =?utf-8?B?UzFuMkZRME5tMkk4WGRpMEwyNzBOUzdkakZwT09nNFdROTlPOU5zVTVHMEZV?=
 =?utf-8?B?RDY3OXBuYjVIT1VsdEVHVHpJc3I5SzhTWjhxTU8wa3RKZEUxMllxZ3djeU5S?=
 =?utf-8?B?MFNRVzVGZkJEQmJ2OTlRMVdIZTIyNFhMYzRDdTJSMWIyVzhDdkE2MDd5eXpP?=
 =?utf-8?B?V0UvRWQ4N01tZEk4ME5CRjEvSDdJUE5icWgzR3JtMWxLMCtPbDNJQjdTOVI3?=
 =?utf-8?B?TGtoSkY1ZEc4c0E5dDFBT3M2blFFemlGaXVCOFFBTFZBZkpETTY2WklETmVI?=
 =?utf-8?B?a2lLcS85VUY4MkpjY2tLeFJ4Um1KT3c5QXBmQ2w1eGRzazRpbFprT01VdUlS?=
 =?utf-8?B?d2ZzRDRCb2JqeTgzeGlEdGVmemkyYVhCNmVzdzVEL2Uxc0lOSEs2L1ZDUm1m?=
 =?utf-8?B?Wnk5TkJJcGFoMEZORUNmd29aMkN1Z0pHV2JhbXhjQkFyU0d6Kzd0M3BENHVI?=
 =?utf-8?B?b3dNakI5TW10enBmYy9nTytCRXcwMVFVdDByUVBaSGNSUDJKcDRMV094WjJl?=
 =?utf-8?B?ZEllaHR2MWR6aHoxOEp3YmsxMTZaWVBVaTZJNFdsY3E0WFFaYkxTNjRsR1A4?=
 =?utf-8?B?TVZwa3JONVZYNTlreGR3TklPYWN6M2llRmRjNHNrL2dpZHBZZzR3T2hQS2lZ?=
 =?utf-8?B?UVhOeVIrMVdKZm9vcG56SWR2enhNOStka3ZpNkI1ZXBuVVFXd3B5a1BhRDhP?=
 =?utf-8?B?YVZNUUdDU1M4OXlEME5vL250eEdzN2h6dmVLSFRoM0tJVkR2RUFKZW1zUGp0?=
 =?utf-8?B?cTRwZzIyQTJ5Vm1NR0N4Tk1CNC9NWmlkUy9MQ3Iyc0RFOTkxTTA2U0dZeElt?=
 =?utf-8?B?Nm82QlZKQXFpdm01VEZYdHAxY3lWSXdabzFtdVo2UkRjRUsyRG4wVW1qS3lt?=
 =?utf-8?B?RTJRWW9acVdFWVdwUy84dG11RTJvMGszalNYWi9NMHFDM2tlYTBodHBCTFdw?=
 =?utf-8?B?cmFuWHVaQnllQXdyS2x6SG1aQXF0a3RDcGs5bDhUZlZmTjJzeWR6bC9Tc1hU?=
 =?utf-8?B?ZWRCT20xeFRlUkZvbGhHaVlTZUc0SVVGL0U2MDJZektLcWV3V2tYUUJXdzU3?=
 =?utf-8?B?bXh4cnpLU2FFVGFFcjlZajZRRUNtc2t5M0lWUmJWelh0SE9rSUl1NWJMbGwv?=
 =?utf-8?B?ZWs2eVZLeEk3aUhQWU5nclRESk80QVJtaUJtcjRZZGp1U1lXVHVPSy93eGtU?=
 =?utf-8?B?NHJMdnNYRlJ1cHYycUNnZ3luTjlPMjBxOUxyTTRCMHdtRFNTNXpvSlN1bE1Q?=
 =?utf-8?B?QU82VnQwMGpaZ0FMZHNwUmhhdUp1OFB3dnBPdFFJYmlrTUJVUURpTjFlSk5K?=
 =?utf-8?B?dEJwNTdCcy9qblZkWGdNK01wdFg4NFVuQ2ZYQzNyUDJseWVIcHBWbnNUaHhP?=
 =?utf-8?Q?uM5lXm7XA2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEZYQXFiZ2JOZUNYNEVTckY3QWxwQWVBVlBBMkZULzcrVCs0MUE2MjBDaUFo?=
 =?utf-8?B?RmdJTlUybjJxQ1Zic2dRNk43aEZIbk4xY0F2aFJhZGo1VVA5WXF6Vk1ldVZj?=
 =?utf-8?B?dTEvTi9NTnU5UXRCbnVJYkNGS2lmTFJSdm1McUU1Q3JHbDRxTmRqeGx6K3g4?=
 =?utf-8?B?M2RmQ3F2OHJFWTkyTmNuN1pBUFh1UEZnbmg2VkRBY0JLZkFWYXdtcUVoUWtv?=
 =?utf-8?B?b2tHalV5VDd6VlJvUGlMeTZXRThZSjRDNHJkcERwWGZzUWVBYnIwdUNtc1Na?=
 =?utf-8?B?Zi9LRjdXeDUwTFpJU0Jqa081d2l3NFBveGhSZ1pQUjEwL2xPeGJaS1BkWkZ0?=
 =?utf-8?B?Q0JXWkJlTVhLbjhNd3c3bmc1eHU3cGxOUVJRWlVwVUx2dDBiU21mQm9UVy9H?=
 =?utf-8?B?czVnMGg4aXJvdW5XcElqaFVPZStTZndDdVhhcmhzaU43c0VGSkxaaUVMck15?=
 =?utf-8?B?bi81Mm9xVGRLdGF5eUVLMHFoTFB3aHJzMkluNVRHcmkrR0xYSUxzQjBOaldv?=
 =?utf-8?B?N0xXa1A3QWZGdWZhRDJFY1RFaXhvdytITGNjYllzMEJ3NEh0aXdYbUZZZDZn?=
 =?utf-8?B?OEp0UUVYcEw2bjlJeU13Vm12dWNjNmRZajIzVGorc1RRMjlOb2dZZktLQWdH?=
 =?utf-8?B?Y0NUMC91UzlDMHJ0dVFMYUFlSm1YWDRKRC9JcTNQWVRIRC8wQ3VYN0Q4enhI?=
 =?utf-8?B?TXRDRjdPcTdRYmNkajdySTMwLzhKdXU5a2tyZk5NTGg5WCtJOVllMmRrVDRi?=
 =?utf-8?B?S2FNSGdtSWJUcDY0ZkVxbWg5U3VYMFdWZk9NaU9DWGt2YmxMbDZqTXhDSmRT?=
 =?utf-8?B?R0gyMDlvUmF5Yzdzd3N5VnhscnhZenBiaEF3RHlSb1pVbmQ4bUh0MzQ2eDVL?=
 =?utf-8?B?VFlNT2hmdXdFWWZ2cUsvTTk2dEJGZ05CVTIrbzRUV2ZTZ3B4N21vWmszN0dZ?=
 =?utf-8?B?UXFIeWdwWVdGZGZXUVExekhrRXJFWHF1QVNqaEh0cmhoZ2oyMDI5VjV6VFVJ?=
 =?utf-8?B?ZlJUYVh6SWQrMVhpUG0ydjViMWZPRURlRHZRT3lyNDl5OUJ3S2ZLWkFpVnVB?=
 =?utf-8?B?bVc3RHJIYXgrWE01Ymp3RVhHb3A1ZXBtaHdUUnZkWllkWHh6Tk1IV0ZCTEVL?=
 =?utf-8?B?QjJETlJUTVYvM3lxQ3RnMHhaT0VYTGI2OWFxUWNmVG1zbFh6ak8rNTFLc2Zs?=
 =?utf-8?B?bXR3bzc3UmZZdjJYanByU3RBUHhnYldWK3AxNUhlaFRUYUlXaWhSV1BYMGNR?=
 =?utf-8?B?eTUzSzlwazVlYnl3bjR4dkl6aFN5U213bDNMSGlaQkh4UU9LYU9tQXB0UUNm?=
 =?utf-8?B?Z29RbGp6TEIvNnhFeStvWTlpMGx2K2k3WUNPSHJWdUhpNDV3UE1PVm5nbFVB?=
 =?utf-8?B?ZVBiWmxDV3N2UlE5Vjl4TnNrSzRGL2dnWlVRVWhrTGtPdHhqc0RLejhnNWxu?=
 =?utf-8?B?N2h1Qit3Q0lNMzZ1UjgrQ1pPQXEvK0ZRV2RrN3BUVFVyV2dWNnBnM0JPWm85?=
 =?utf-8?B?NnV4RG1hUlRvNG9xdm1JMW9NQVRFMFFDMThBUjYzVjVtNVlXMjdXTEswLzRx?=
 =?utf-8?B?aTBDSG1paEdnUFV1eEUraFcycUhxam9VMDUxL3kyeWxMaGRNV3h1R3hVaUdy?=
 =?utf-8?B?eXdrTzlWR1kxckxmRzhPSEwxY1NDZ2RZSDF6dHhxS25JeWNPYlZUQzhvNGVS?=
 =?utf-8?B?UmFBNHdyZzlsUTBOdURWaTZwR2RBRVRMdERIS3lPQjd3Rk5WMjA1SENaN2dE?=
 =?utf-8?B?anZBZjNtdHR2d3MwR3dUMTJ0dFdka01IaCtnM3dRbFhUMjhwMFU0Tm55WG1y?=
 =?utf-8?B?WFBVSmJ1YkNQZjNDSnRUWjlmU2FpUTYyczlQOG9FWkYvV21HdkVDYnN0VVVl?=
 =?utf-8?B?ZnhzSDlyL0xWdVVqVkxBRmNKc1MxbnhMdGwzLzRUUy83RW9qS1FRZjdHQzBN?=
 =?utf-8?B?LzV3ajFmZk5iQXVhVDRxQTU1WFdJd0lXTUFiSGxnaDZFWnQ2NW05VDhzS29w?=
 =?utf-8?B?Z29JbFlFNWsxdDNoSWJET2Z2dHF0cnhRZDFRSDVGaDU0ZVBQU2NCWmJaV1Zi?=
 =?utf-8?B?dHNEZGdXWmVFQldQR09wV2ttK2FPRkhKRmdjK3IwUzZZV2NmTEVRRUFQOENV?=
 =?utf-8?Q?xBPm9xpRM+4i000DiuUoUNv9x?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086dd4ca-2a0b-447b-2c5c-08ddcd9e80c6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:18:01.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmhviwjI4kcMYdn+qi39BKjInB5nJobKgAImFLuXgwjB8cQwVKTRiCYH6lY4CcCgaG/Bi0LO+liszOMBOK4WQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFCFB43FE7A

Hi Slava,

Sorry for the late reply.

在 2025/7/11 05:36, Viacheslav Dubeyko 写道:
> The hfs_find_init() method can trigger the crash
> if tree pointer is NULL:
> 
> [   45.746290][ T9787] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KAI
> [   45.747287][ T9787] KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
> [   45.748716][ T9787] CPU: 2 UID: 0 PID: 9787 Comm: repro Not tainted 6.16.0-rc3 #10 PREEMPT(full)
> [   45.750250][ T9787] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   45.751983][ T9787] RIP: 0010:hfs_find_init+0x86/0x230
> [   45.752834][ T9787] Code: c1 ea 03 80 3c 02 00 0f 85 9a 01 00 00 4c 8d 6b 40 48 c7 45 18 00 00 00 00 48 b8 00 00 00 00 00 fc
> [   45.755574][ T9787] RSP: 0018:ffffc90015157668 EFLAGS: 00010202
> [   45.756432][ T9787] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff819a4d09
> [   45.757457][ T9787] RDX: 0000000000000008 RSI: ffffffff819acd3a RDI: ffffc900151576e8
> [   45.758282][ T9787] RBP: ffffc900151576d0 R08: 0000000000000005 R09: 0000000000000000
> [   45.758943][ T9787] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000004
> [   45.759619][ T9787] R13: 0000000000000040 R14: ffff88802c50814a R15: 0000000000000000
> [   45.760293][ T9787] FS:  00007ffb72734540(0000) GS:ffff8880cec64000(0000) knlGS:0000000000000000
> [   45.761050][ T9787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   45.761606][ T9787] CR2: 00007f9bd8225000 CR3: 000000010979a000 CR4: 00000000000006f0
> [   45.762286][ T9787] Call Trace:
> [   45.762570][ T9787]  <TASK>
> [   45.762824][ T9787]  hfs_ext_read_extent+0x190/0x9d0
> [   45.763269][ T9787]  ? submit_bio_noacct_nocheck+0x2dd/0xce0
> [   45.763766][ T9787]  ? __pfx_hfs_ext_read_extent+0x10/0x10
> [   45.764250][ T9787]  hfs_get_block+0x55f/0x830
> [   45.764646][ T9787]  block_read_full_folio+0x36d/0x850
> [   45.765105][ T9787]  ? __pfx_hfs_get_block+0x10/0x10
> [   45.765541][ T9787]  ? const_folio_flags+0x5b/0x100
> [   45.765972][ T9787]  ? __pfx_hfs_read_folio+0x10/0x10
> [   45.766415][ T9787]  filemap_read_folio+0xbe/0x290
> [   45.766840][ T9787]  ? __pfx_filemap_read_folio+0x10/0x10
> [   45.767325][ T9787]  ? __filemap_get_folio+0x32b/0xbf0
> [   45.767780][ T9787]  do_read_cache_folio+0x263/0x5c0
> [   45.768223][ T9787]  ? __pfx_hfs_read_folio+0x10/0x10
> [   45.768666][ T9787]  read_cache_page+0x5b/0x160
> [   45.769070][ T9787]  hfs_btree_open+0x491/0x1740
> [   45.769481][ T9787]  hfs_mdb_get+0x15e2/0x1fb0
> [   45.769877][ T9787]  ? __pfx_hfs_mdb_get+0x10/0x10
> [   45.770316][ T9787]  ? find_held_lock+0x2b/0x80
> [   45.770731][ T9787]  ? lockdep_init_map_type+0x5c/0x280
> [   45.771200][ T9787]  ? lockdep_init_map_type+0x5c/0x280
> [   45.771674][ T9787]  hfs_fill_super+0x38e/0x720
> [   45.772092][ T9787]  ? __pfx_hfs_fill_super+0x10/0x10
> [   45.772549][ T9787]  ? snprintf+0xbe/0x100
> [   45.772931][ T9787]  ? __pfx_snprintf+0x10/0x10
> [   45.773350][ T9787]  ? do_raw_spin_lock+0x129/0x2b0
> [   45.773796][ T9787]  ? find_held_lock+0x2b/0x80
> [   45.774215][ T9787]  ? set_blocksize+0x40a/0x510
> [   45.774636][ T9787]  ? sb_set_blocksize+0x176/0x1d0
> [   45.775087][ T9787]  ? setup_bdev_super+0x369/0x730
> [   45.775533][ T9787]  get_tree_bdev_flags+0x384/0x620
> [   45.775985][ T9787]  ? __pfx_hfs_fill_super+0x10/0x10
> [   45.776453][ T9787]  ? __pfx_get_tree_bdev_flags+0x10/0x10
> [   45.776950][ T9787]  ? bpf_lsm_capable+0x9/0x10
> [   45.777365][ T9787]  ? security_capable+0x80/0x260
> [   45.777803][ T9787]  vfs_get_tree+0x8e/0x340
> [   45.778203][ T9787]  path_mount+0x13de/0x2010
> [   45.778604][ T9787]  ? kmem_cache_free+0x2b0/0x4c0
> [   45.779052][ T9787]  ? __pfx_path_mount+0x10/0x10
> [   45.779480][ T9787]  ? getname_flags.part.0+0x1c5/0x550
> [   45.779954][ T9787]  ? putname+0x154/0x1a0
> [   45.780335][ T9787]  __x64_sys_mount+0x27b/0x300
> [   45.780758][ T9787]  ? __pfx___x64_sys_mount+0x10/0x10
> [   45.781232][ T9787]  do_syscall_64+0xc9/0x480
> [   45.781631][ T9787]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   45.782149][ T9787] RIP: 0033:0x7ffb7265b6ca
> [   45.782539][ T9787] Code: 48 8b 0d c9 17 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48
> [   45.784212][ T9787] RSP: 002b:00007ffc0c10cfb8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> [   45.784935][ T9787] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffb7265b6ca
> [   45.785626][ T9787] RDX: 0000200000000240 RSI: 0000200000000280 RDI: 00007ffc0c10d100
> [   45.786316][ T9787] RBP: 00007ffc0c10d190 R08: 00007ffc0c10d000 R09: 0000000000000000
> [   45.787011][ T9787] R10: 0000000000000048 R11: 0000000000000206 R12: 0000560246733250
> [   45.787697][ T9787] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   45.788393][ T9787]  </TASK>
> [   45.788665][ T9787] Modules linked in:
> [   45.789058][ T9787] ---[ end trace 0000000000000000 ]---
> [   45.789554][ T9787] RIP: 0010:hfs_find_init+0x86/0x230
> [   45.790028][ T9787] Code: c1 ea 03 80 3c 02 00 0f 85 9a 01 00 00 4c 8d 6b 40 48 c7 45 18 00 00 00 00 48 b8 00 00 00 00 00 fc
> [   45.792364][ T9787] RSP: 0018:ffffc90015157668 EFLAGS: 00010202
> [   45.793155][ T9787] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff819a4d09
> [   45.794123][ T9787] RDX: 0000000000000008 RSI: ffffffff819acd3a RDI: ffffc900151576e8
> [   45.795105][ T9787] RBP: ffffc900151576d0 R08: 0000000000000005 R09: 0000000000000000
> [   45.796135][ T9787] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000004
> [   45.797114][ T9787] R13: 0000000000000040 R14: ffff88802c50814a R15: 0000000000000000
> [   45.798024][ T9787] FS:  00007ffb72734540(0000) GS:ffff8880cec64000(0000) knlGS:0000000000000000
> [   45.799019][ T9787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   45.799822][ T9787] CR2: 00007f9bd8225000 CR3: 000000010979a000 CR4: 00000000000006f0
> [   45.800747][ T9787] Kernel panic - not syncing: Fatal exception
> 
> The hfs_fill_super() calls hfs_mdb_get() method that tries
> to construct Extents Tree and Catalog Tree:
> 
> HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
> if (!HFS_SB(sb)->ext_tree) {
> 	pr_err("unable to open extent tree\n");
> 	goto out;
> }
> HFS_SB(sb)->cat_tree = hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_keycmp);
> if (!HFS_SB(sb)->cat_tree) {
> 	pr_err("unable to open catalog tree\n");
> 	goto out;
> }
> 
> However, hfs_btree_open() calls read_mapping_page() that
> calls hfs_get_block(). And this method calls hfs_ext_read_extent():
> 
> static int hfs_ext_read_extent(struct inode *inode, u16 block)
> {
> 	struct hfs_find_data fd;
> 	int res;
> 
> 	if (block >= HFS_I(inode)->cached_start &&
> 	    block < HFS_I(inode)->cached_start + HFS_I(inode)->cached_blocks)
> 		return 0;
> 
> 	res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
> 	if (!res) {
> 		res = __hfs_ext_cache_extent(&fd, inode, block);
> 		hfs_find_exit(&fd);
> 	}
> 	return res;
> }
> 
> The problem here that hfs_find_init() is trying to use
> HFS_SB(inode->i_sb)->ext_tree that is not initialized yet.
> It will be initailized when hfs_btree_open() finishes
> the execution.
> 
> The patch adds checking of tree pointer in hfs_find_init()
> and it reworks the logic of hfs_btree_open() by reading
> the b-tree's header directly from the volume. The read_mapping_page()
> is exchanged on filemap_grab_folio() that grab the folio from
> mapping. Then, sb_bread() extracts the b-tree's header
> content and copy it into the folio.
> 
> Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/hfs/bfind.c  |  3 +++
>   fs/hfs/btree.c  | 57 +++++++++++++++++++++++++++++++++++++++----------
>   fs/hfs/extent.c |  2 +-
>   fs/hfs/hfs_fs.h |  1 +
>   4 files changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index ef9498a6e88a..34e9804e0f36 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
>   {
>   	void *ptr;
>   
> +	if (!tree || !fd)
> +		return -EINVAL;
> +
>   	fd->tree = tree;
>   	fd->bnode = NULL;
>   	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2fa4b1f8cc7f..e86e1e235658 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -21,8 +21,12 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
>   	struct hfs_btree *tree;
>   	struct hfs_btree_header_rec *head;
>   	struct address_space *mapping;
> -	struct page *page;
> +	struct folio *folio;
> +	struct buffer_head *bh;
>   	unsigned int size;
> +	u16 dblock;
> +	sector_t start_block;
> +	loff_t offset;
>   
>   	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
>   	if (!tree)
> @@ -75,12 +79,40 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
>   	unlock_new_inode(tree->inode);
>   
>   	mapping = tree->inode->i_mapping;
> -	page = read_mapping_page(mapping, 0, NULL);
> -	if (IS_ERR(page))

We need to read hfs_btree_header_rec(106 bytes) from first block,
which is much smaller than a sector(512 bytes) or a page (4k or bigger?).

Maybe we don't need to read a full page?

> +	folio = filemap_grab_folio(mapping, 0);
> +	if (IS_ERR(folio))
>   		goto free_inode;
>   
> +	folio_zero_range(folio, 0, folio_size(folio));
> +
> +	dblock = hfs_ext_find_block(HFS_I(tree->inode)->first_extents, 0);
> +	start_block = HFS_SB(sb)->fs_start + (dblock * HFS_SB(sb)->fs_div);

It's not elegant to expose such mapping logic code.
Could we have a common map func converting logic block to physical 
block, xxx_get_block uses it, and here uses it?

> +
> +	size = folio_size(folio);
> +	offset = 0;
> +	while (size > 0) {
> +		size_t len;
> +
> +		bh = sb_bread(sb, start_block);
> +		if (!bh) {
> +			pr_err("unable to read tree header\n");
> +			goto put_folio;
> +		}
> +
> +		len = min_t(size_t, folio_size(folio), sb->s_blocksize);
> +		memcpy_to_folio(folio, offset, bh->b_data, sb->s_blocksize);
> +
> +		brelse(bh);
> +
> +		start_block++;
> +		offset += len;
> +		size -= len;
> +	}

We don't need to read full page, and it might be a good optimization for 
hfsplus too？

Could we get rid of using buffer_head?

I'm not sure weather bdev_rw_virt is a good choice to simplify it.

Thx，
Yangtao

