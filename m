Return-Path: <linux-fsdevel+bounces-56778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04CB1B84E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8F13ADA37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB128BABE;
	Tue,  5 Aug 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hA6cOd5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012012.outbound.protection.outlook.com [40.107.75.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A782E371C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410743; cv=fail; b=qFAjDRal8s+8TD5/apYULyFW/CO556oUje/5MNm07NBDr6d0NE88ar77gmlv5R8VjCS+HGgFgfEyYrdfq/uZd+DR695ZCudTorlKG0QItT2l4EgnklghrDQK6TY9hY7BgYPQ5+yrTa/A+F6wjCYrte/dsC+7QmBmn8QMhKiNSq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410743; c=relaxed/simple;
	bh=3gHkPWjGZSIrDp06gO1074HHUSk6ZMF6fdAT9mFhg/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X/+IpNpFbtaYzcapdezVgwYwnw/ilBifBMm99Fr/sfINuewCdyrIMhxFPXWETkpZvmDmJgyZ7feRHkhuzHfOzzCI5qwJMt3HQCUxbc+8FzKHDd1yHRwFDB0s/hF9mzmtOoi4a2fxKEwY2xnSnMgrgVTReABxWDMzf1QWrkwt8OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hA6cOd5I; arc=fail smtp.client-ip=40.107.75.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzpTk5dk18D1Jx+J72TvKsf2DOyzLn0SnqYkMBcTkOgWzLliLjDNlcABsY1BWNnIgld7FcPpM/YE/irDyqnW9/4zdz/0IE0gvEN/AzAeE8ppCeHqtrnU1oLh+gqYEAKHtTQbQ43zIJlrRksd8h+cL/vG6xzvTYjezN59KBhjUio24RwMd9pU+pQspNooUf6vyTdS4glTplMBCzdY6JudIpObwIfGMwUXyJPSSQP/QGWkGj9gbQUhc0SakYiv3JWHvqtEPcm9YiKeJ020NHYPnGotlCsMvuBiW8HPY0wWBLLcQgkQAhVxPcRtFJMVeZ3aF2saJsDTSM+T4QSPYMyBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0dmHG5yXaT7DaFGkqxVZ0PhrQLF28PwpTF1+CnuNi0=;
 b=RX5OcIxnJy9OoWlmB3FLtOO/7tmugR2QqP0BbTFlSz0LaWBkAJymHyAZ4VOOw2Q33psU9kcVk0X2PRBl3l79kPzH5IyfW7mfb23Y9QjkBJw37fsxXqpoxsNEbBWeBQ0/FuMgaWkdKlw//8NFd8j6lvMEqcbFnvKrroLf5OhYZVTREsJqatEaGEKH1xU1wGBxj4r2OO2iT8hU4DTiY/tyvL+ChfzQdWgCCJrH9d8i2wT/8Im8MKYS6RU0cZ78rm8DyWRreVQpptEJdqV3CoahWUbTHMcVQSH7x+mCjQ06/S9vqo9hNshP+6Mu1onajavSoMwPKh+493YBxSX/61DwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0dmHG5yXaT7DaFGkqxVZ0PhrQLF28PwpTF1+CnuNi0=;
 b=hA6cOd5IOvZYmMuBm+fs62nOHswLyj5rnge0NwWvpiO90fnNikS5wMYwmBO7NviO1Fkoto5uoQmw5gdjCLPFN9nE7vWEkFovpMu/ekdcgI9+vRXPbe1y74v0TYc74CTcdGbPl6HoUpftLZxx467VPHOVZFSwLVczXAXX5FnXzNyscOHvJuDepqILpkpLYy+dsfSuwwrjHuBmd316TkuyXv/5EIoYoOzj2H4JXEdfYR+mhnaQxLFf6KWerUG4SuapNFOYVnp0z1e/aehlxsf6KSILJl3XU859U3gol1M4uAIpvPN5Fpe/WuwPS1u3fVNsp8dPlg4mo+FJ+kILxyJ+SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6908.apcprd06.prod.outlook.com (2603:1096:820:127::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 16:18:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 16:18:53 +0000
Message-ID: <894eb3d4-b7eb-474e-ae4d-457a099deb76@vivo.com>
Date: Wed, 6 Aug 2025 00:18:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: fix KMSAN: uninit-value in hfsplus_lookup()
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
 syzbot <syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com>
References: <20250804195058.2327861-1-slava@dubeyko.com>
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250804195058.2327861-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: aabd8740-11e0-4a72-bf38-08ddd43bc50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGVSU0VSY0xScVV6eTlheTVKZkZqMDJyb3E3WjkvSVVwdEtjL0IwVnlsVjRq?=
 =?utf-8?B?ZUswTi95WkluL1NJdERibXN3OU1jTkxBNFNDSWk0a3JmTUpoaFRFTGVaQ3RN?=
 =?utf-8?B?M0U4RTg2RlNEbjl0ZVZ5RXE0M2JlWlhpTHlwT0xXR0JmZEV2eVRGYlVFTFF0?=
 =?utf-8?B?cXZudTczMDlhRGVuMFUvOEZzWWo0aXQzUUl5TXNGYm0yYjVIMUVXdlBUZ2pB?=
 =?utf-8?B?ZENPQU8yQ2NwNklOQXBuSGdBYTAzbGU4c1dMQWdNckxNREYrZTBSdTRNT2RJ?=
 =?utf-8?B?cTRIc1RudW45WGxFcE9FbEVhL0ZYYjYvTU5Bclp5YkJzZDhaNTRZd0JFN3pW?=
 =?utf-8?B?YUprYllldDJOOUpjdExrWFBVaTJEWlI0dlBLRndrbWp0akQ2dGROQ3BGVm83?=
 =?utf-8?B?aU96M2tvZXc2QlhKdEkxMkJUek5LSGs0S1pvR2tIcXhZSWZDR0h2Z1JsUzlV?=
 =?utf-8?B?K2Z6UXpVdXljeWpORkMySWNHZk1FWkZMbUp5ZDNSaThLNHJVS1VxbmpmbVo4?=
 =?utf-8?B?TEczajBDK0doajVwcWljOURVWS9aM0Vuc3RHM3plak1hNnhIRkd5dkFLTjBh?=
 =?utf-8?B?QjJmbTdGM2NrM1JsUjRMc0VNcFl6dFExK2o4MG5aUktoeGM4eHJ0UFpLWmxL?=
 =?utf-8?B?aERudE1yNWJzZlZqU2FOK1ViMUlSaWpYZU5IYUNhZ1g2aTJSelhTTy9wUHZu?=
 =?utf-8?B?VjFoRlIxaXYwb3BKVHJkUFJZWlUwVzRrSmpMa2lSMUJRSWl5Q3hvV2prdlBj?=
 =?utf-8?B?Y3Z1UmI2cTlwVHpsN20yRFB1SDVJZkJrZmo5LzhsNDJUS01WRk5PYWZVdTFU?=
 =?utf-8?B?VGJUQ2JHWm9CNzBQZHVOYnAwREt5UVN0eGdGL1dZMiszRXpjMjNQS284U1Q5?=
 =?utf-8?B?T3JmWndJMXVVT3BuUVl1MXl1OWp5YldDb3o4bE1iVkJ2QmJ3SVQ1c3JiVTZZ?=
 =?utf-8?B?N0U0ZmZTYURDQkU1ZnQzM1F6MExzWTJYd1lSOHVEaEg2UnZqRmNaQjJnbSsv?=
 =?utf-8?B?L0ZzemwzWDA4OHZDaDNCTGI2V2k2RjI5ejN0d0hKUktNOVR1cDFEZXQzbjRl?=
 =?utf-8?B?eFFBWU1UYlU2TE1uTTZ1WkxUNUV5WE1xVjRhL2RrN3U5RDhPUmpPaSt6ZjFV?=
 =?utf-8?B?U1FIUWlFaEhvUlZYWWhZOGE0WGJoL0lXbnhKQ2ZmcUVjZlk1d25odW9NcXZi?=
 =?utf-8?B?UnFlL0c2NElGZVNJeHpzYUdSNW5QcVk1UHQrSDFjenhCU21EVE51eC8wTzlY?=
 =?utf-8?B?eXFoU3IvM0dsTHpyWjJGVGVUcjROWWNOYTgvcWx1dERqUXRUM0hzaW53V2tz?=
 =?utf-8?B?a2R2cjhYM3VleTU5emJCY3ZDVEprWXdUTE53TWdmWVdhQ2NqZmhGNHJlY0d4?=
 =?utf-8?B?aXM4WWYwell5UXJQWlpzaTNpUXZoZXFzR0E1UC9GRjViUG45MGJ3Z2lieE05?=
 =?utf-8?B?OUEydTUzRisvb2tzR2hhMUpmSzFlN2NWUjdkTmlFbEkrSjExYTBzQkZjdzd0?=
 =?utf-8?B?SjhqREhQaFZRSkZKWDU0TzU5MmRUTXZ6OUhQMjdpQWdJOTRTQzVuOXN3NWIw?=
 =?utf-8?B?amRpeHY1aU4ycCtnSk1tLzFGZFFOaFk0UUVONG1WdG81UVB6NDlCSW00Tmtq?=
 =?utf-8?B?NHdab3B4anFMaG1PbGhlVHVQaE0zVFAvRnlOcW5MOUZ1R0MwOXZYQytGU1JV?=
 =?utf-8?B?THhFNGovRkh6MHlBVEJLZ3ZrN2ZWWkdrb1NTdU5zR3RpZytFanhDdDZhNG80?=
 =?utf-8?B?ZEVha0c5Y1ViR0FrWlcrSW9zSmJMeENxUHBhdE11TkMrSnAzNytpS2Ywa3dn?=
 =?utf-8?B?ZjlrZ0lVekZNaW1ScVpURXRMTjRYdmNRdy9tR0FGQ3dSTktTYzI3ZXlNQmlS?=
 =?utf-8?B?Z0FRbnY0MFR3VGs3WjJMU0doOXFVenluUFAwdy9MR2RNZEd1ZzA1Ny85NVdD?=
 =?utf-8?Q?dJg4CWs7IYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2FtQVhBNzVaYWdHV2tSUllDTDdFR3VDVHRZcWJxNTlTYi95azFGcGlZLzNx?=
 =?utf-8?B?bUpSV1A0TC9hRGlORFUxT1RmM2o5THI4cmVDOHZFY2RwNVoydjJCV2dDYXZG?=
 =?utf-8?B?aEwwY2NpYXRmY3ZuY0NyMUltQ2dmcmFpMUJrUlYwT29TSkZWd00xVU9PdGNP?=
 =?utf-8?B?TkFjcVlJTmE5a1NKanlXS3RjeEhuVTU1S2ROZlZPOUl3aDdSK2FnSi8wS2tS?=
 =?utf-8?B?dm1NMkJ5eEs4dHRRUWIzcTBubXFBRHphOWk2bDBrZXB6cjhFamVaV0hDa0xn?=
 =?utf-8?B?NEZNQlQyUnFYM05rRWZlRW4yMmdSb092Um94OU9aLy9sY012VE5DVlFTWkFV?=
 =?utf-8?B?MHF1b3prVmZOOHFoOSswK3BiRzNBN01UUVkzd3FUcWh2T1E0UTN0aTRQcVZY?=
 =?utf-8?B?WlVSY3Ryc3gxVmkybGthTzZSZWgxODNZTDU3eFdOZTA4c0tSUHJpcVBGQmda?=
 =?utf-8?B?Tm5idVpteU9jNi9xVCtveHlHM1FYZi9lVXJmdllHbmVJem9uVnk4QktLNUpR?=
 =?utf-8?B?U253dzFsUTAzSCtIVUY4V2NSd25PeloyTVFwb3ZZd2hCbFVnTlZXV0krOEFH?=
 =?utf-8?B?RGNTUXIzS3liU2VqVmsyRkd2QWlaT0NwWU5SRUJXOSt5dkc4MDh5emlCWXhI?=
 =?utf-8?B?VXJlZ1hzZ3hPWUR1bFAxY014c3dwcTNuNm1HdTV3aHZUb3NEcFBIRnJ0N2Q4?=
 =?utf-8?B?QnUyNzd6V1A2elRBS0dxYkNXbGVpb1ZlMTc1WHlIY2kwN2gzRnJpVmVqby9K?=
 =?utf-8?B?T2srVDloZXFMaUppOXVRSVkvVXpiVlVjTFNQMkpaVjdkUXIxbGdsY2xaMXRh?=
 =?utf-8?B?Q3o1QnlPWnZMM2RmQUs3VWNDTHZxdzVzaFJFcGYrZ0FsQnVSOWtSV3l2UXhR?=
 =?utf-8?B?aW1MbzFlN2JIRUludXRHdVlSSFZFcXlncXNhRW5pMlFNVmRoektROTNGdDA3?=
 =?utf-8?B?NFljc3lNWjJBZmxPUEUxSkJsd0UyWFZ3NSthaEE4UWJoTWNHcjBSb3J1cHo5?=
 =?utf-8?B?bjJWVzZFSjd6anl5S2gxaEQ5cUJ5UWIrcWJjQ3ZSQjdMK0doRjdYcExTeU1V?=
 =?utf-8?B?RkV4WDdMMmlpSllZdm8xakVJWTYvd1VrMGtWT2Y4bXpSWW12QXA3QSticXdq?=
 =?utf-8?B?NEVnN2t3cFdCUVBnQmFzU3VqUE5ROTdWSFY5UjNxV3N3ZHVyYXhLT2Q0UWZa?=
 =?utf-8?B?c1ZBZkJLc3ZMUjNXR21HangrOUk2QXIvQzk3ZUxGQ0V6UEhyQVFBWEhmVlBu?=
 =?utf-8?B?dmljcXBpRjZEOFFBdEhhWUNDOGNTOXRlRzZ4emFIWWVVRFJXNHRTMjRZRkF0?=
 =?utf-8?B?OVpmY1p4bzZ2dVhXdnVLVnZ0RHBBaVh3ZUZzenBMM1U1YzFqdlBqNlR0bU5O?=
 =?utf-8?B?amY4ejFZeUNhQUorSDdla3VGV05MRDRvaFZxc1R3TzNPOFl6c0RCUVdxNVZT?=
 =?utf-8?B?VGNRQlFISXdRK0VLY2xlSlBydUljb2RzbjZKNGQyeGFWeit0TEMwQjVYeE5p?=
 =?utf-8?B?QTRDb1d5dDFBcklNTzZ2bCtpLzFpMjFmK2ZQWEswNHBjd2IyTDE0cjNwTnRo?=
 =?utf-8?B?MkVRTGt5a1BTTFFLM2VUVzJCbzlOQXF2MjVYVnpzOFdKeno3TWdyUlcxRmV5?=
 =?utf-8?B?NCt0UVZUS3ViOEFjN2RDbDd5bTZ6L242RkNidWNZdVQwRTBmbFpzNDdNQ3FD?=
 =?utf-8?B?V1k1R0pLNW84bHJhRzFNemN4b3pDZkZxYjd0cXVPcndMeitpN3A0VmZKU1pL?=
 =?utf-8?B?U1NkN21mYjRIQVEwR3JSbWpQb2EwaGlpZ0VLL3hvakNycEhFSWJHcnZWQnpr?=
 =?utf-8?B?cldxTGc4elh0NHhDZ0hvSUZLdzhEcnMxaEN4Vll4RjYxZ0Z3bjB4YndRRUVx?=
 =?utf-8?B?aStZTjN6MGZ6bVR1Q21vWnFiSDJycGIzQ1RZMlg3WElWT0l0dmNmY0FRNFU0?=
 =?utf-8?B?eUdzc1k3S01WZWVPZ2NBaTdnVit6QkpQSEZKL0k5cEZkL0RWZFBudnVHOC9n?=
 =?utf-8?B?L1I3Z01wZm9hYStoWTI0UEZWTktGWVkxSDRaZytNbWJqRGI3N0M2VzFFdGtq?=
 =?utf-8?B?N2RsUlZIT2pkSnFCMkVXVE1LTFdubi80cGxSNytPSkI4Q1FaSXpleW1ldXlw?=
 =?utf-8?Q?1vKYHcsyUnxm3XALOYHQKL/sJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabd8740-11e0-4a72-bf38-08ddd43bc50b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 16:18:53.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WceDYBXpFTmO816tjMEn/Pp5hXNuUkNHAA7dYLyC7zVldUvkXxd58Fwic7Qu5gLeLkzrl8p/ZCSuERek9ggx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6908

Hi Slava,

在 2025/8/5 3:50, Viacheslav Dubeyko 写道:
> If Catalog File contains corrupted record for the case of
> hidden directory (particularly, entry.folder.id is lesser
> than HFSPLUS_FIRSTUSER_CNID), then it can trigger the issue:
>
> [   65.773760][ T9320] BUG: KMSAN: uninit-value in hfsplus_lookup+0xcd7/0x11f0
> [   65.774362][ T9320]  hfsplus_lookup+0xcd7/0x11f0
> [   65.774756][ T9320]  __lookup_slow+0x525/0x720
> [   65.775160][ T9320]  lookup_slow+0x6a/0xd0
> [   65.775513][ T9320]  walk_component+0x393/0x680
> [   65.775896][ T9320]  path_lookupat+0x257/0x6c0
> [   65.776313][ T9320]  filename_lookup+0x2ac/0x800
> [   65.776693][ T9320]  user_path_at+0x8f/0x3c0
> [   65.777078][ T9320]  __x64_sys_umount+0x146/0x250
> [   65.777484][ T9320]  x64_sys_call+0x2806/0x3d90
> [   65.777851][ T9320]  do_syscall_64+0xd9/0x1e0
> [   65.778263][ T9320]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   65.778716][ T9320]
> [   65.778906][ T9320] Uninit was created at:
> [   65.779294][ T9320]  __alloc_frozen_pages_noprof+0x714/0xe60
> [   65.779750][ T9320]  alloc_pages_mpol+0x295/0x890
> [   65.780148][ T9320]  alloc_frozen_pages_noprof+0xf8/0x1f0
> [   65.780597][ T9320]  allocate_slab+0x216/0x1190
> [   65.780961][ T9320]  ___slab_alloc+0x104c/0x33c0
> [   65.781543][ T9320]  kmem_cache_alloc_lru_noprof+0x8f6/0xe70
> [   65.782135][ T9320]  hfsplus_alloc_inode+0x5a/0xd0
> [   65.782608][ T9320]  alloc_inode+0x82/0x490
> [   65.783055][ T9320]  iget_locked+0x22e/0x1320
> [   65.783495][ T9320]  hfsplus_iget+0xc9/0xd70
> [   65.783944][ T9320]  hfsplus_btree_open+0x12b/0x1de0
> [   65.784456][ T9320]  hfsplus_fill_super+0xc1c/0x27b0
> [   65.784922][ T9320]  get_tree_bdev_flags+0x6e6/0x920
> [   65.785403][ T9320]  get_tree_bdev+0x38/0x50
> [   65.785819][ T9320]  hfsplus_get_tree+0x35/0x40
> [   65.786275][ T9320]  vfs_get_tree+0xb3/0x5c0
> [   65.786674][ T9320]  do_new_mount+0x73e/0x1630
> [   65.787135][ T9320]  path_mount+0x6e3/0x1eb0
> [   65.787564][ T9320]  __se_sys_mount+0x73a/0x830
> [   65.787944][ T9320]  __x64_sys_mount+0xe4/0x150
> [   65.788346][ T9320]  x64_sys_call+0x3904/0x3d90
> [   65.788707][ T9320]  do_syscall_64+0xd9/0x1e0
> [   65.789090][ T9320]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   65.789557][ T9320]
> [   65.789744][ T9320] CPU: 0 UID: 0 PID: 9320 Comm: repro Not tainted 6.14.0-rc5 #5
> [   65.790355][ T9320] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   65.791197][ T9320] =====================================================
> [   65.791814][ T9320] Disabling lock debugging due to kernel taint
> [   65.792419][ T9320] Kernel panic - not syncing: kmsan.panic set ...
> [   65.793000][ T9320] CPU: 0 UID: 0 PID: 9320 Comm: repro Tainted: G    B              6.14.0-rc5 #5
> [   65.793830][ T9320] Tainted: [B]=BAD_PAGE
> [   65.794235][ T9320] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   65.795211][ T9320] Call Trace:
> [   65.795519][ T9320]  <TASK>
> [   65.795797][ T9320]  dump_stack_lvl+0x1fd/0x2b0
> [   65.796256][ T9320]  dump_stack+0x1e/0x25
> [   65.796677][ T9320]  panic+0x505/0xca0
> [   65.797112][ T9320]  ? kmsan_get_metadata+0xf9/0x150
> [   65.797625][ T9320]  kmsan_report+0x299/0x2a0
> [   65.798105][ T9320]  ? kmsan_internal_unpoison_memory+0x14/0x20
> [   65.798696][ T9320]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
> [   65.799291][ T9320]  ? __msan_warning+0x96/0x120
> [   65.799785][ T9320]  ? hfsplus_lookup+0xcd7/0x11f0
> [   65.800294][ T9320]  ? __lookup_slow+0x525/0x720
> [   65.800772][ T9320]  ? lookup_slow+0x6a/0xd0
> [   65.801239][ T9320]  ? walk_component+0x393/0x680
> [   65.801730][ T9320]  ? path_lookupat+0x257/0x6c0
> [   65.802225][ T9320]  ? filename_lookup+0x2ac/0x800
> [   65.802720][ T9320]  ? user_path_at+0x8f/0x3c0
> [   65.803202][ T9320]  ? __x64_sys_umount+0x146/0x250
> [   65.803683][ T9320]  ? x64_sys_call+0x2806/0x3d90
> [   65.804177][ T9320]  ? do_syscall_64+0xd9/0x1e0
> [   65.804634][ T9320]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   65.805251][ T9320]  ? kmsan_get_metadata+0x70/0x150
> [   65.805764][ T9320]  ? vprintk_default+0x3f/0x50
> [   65.806256][ T9320]  ? vprintk+0x36/0x50
> [   65.806659][ T9320]  ? _printk+0x17e/0x1b0
> [   65.807107][ T9320]  ? kmsan_get_metadata+0xf9/0x150
> [   65.807621][ T9320]  __msan_warning+0x96/0x120
> [   65.808103][ T9320]  hfsplus_lookup+0xcd7/0x11f0
> [   65.808587][ T9320]  ? kmsan_get_metadata+0x70/0x150
> [   65.809108][ T9320]  ? kmsan_get_metadata+0xf9/0x150
> [   65.809627][ T9320]  ? kmsan_get_metadata+0xf9/0x150
> [   65.810142][ T9320]  ? __pfx_hfsplus_lookup+0x10/0x10
> [   65.810669][ T9320]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
> [   65.811258][ T9320]  ? __pfx_hfsplus_lookup+0x10/0x10
> [   65.811787][ T9320]  __lookup_slow+0x525/0x720
> [   65.812258][ T9320]  lookup_slow+0x6a/0xd0
> [   65.812700][ T9320]  walk_component+0x393/0x680
> [   65.813178][ T9320]  ? kmsan_get_metadata+0xf9/0x150
> [   65.813697][ T9320]  path_lookupat+0x257/0x6c0
> [   65.814196][ T9320]  filename_lookup+0x2ac/0x800
> [   65.814677][ T9320]  ? strncpy_from_user+0x255/0x470
> [   65.815193][ T9320]  ? kmsan_get_metadata+0xf9/0x150
> [   65.815706][ T9320]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
> [   65.816290][ T9320]  ? __msan_metadata_ptr_for_load_8+0x24/0x40
> [   65.816886][ T9320]  user_path_at+0x8f/0x3c0
> [   65.817342][ T9320]  ? __x64_sys_umount+0x6d/0x250
> [   65.817834][ T9320]  __x64_sys_umount+0x146/0x250
> [   65.818333][ T9320]  ? kmsan_internal_set_shadow_origin+0x79/0x110
> [   65.818945][ T9320]  x64_sys_call+0x2806/0x3d90
> [   65.819420][ T9320]  do_syscall_64+0xd9/0x1e0
> [   65.819876][ T9320]  ? irqentry_exit+0x16/0x60
> [   65.820353][ T9320]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   65.820951][ T9320] RIP: 0033:0x7f822cb8fb07
> [   65.821427][ T9320] Code: 23 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 08
> [   65.823225][ T9320] RSP: 002b:00007fff4858f038 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
> [   65.824037][ T9320] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f822cb8fb07
> [   65.824818][ T9320] RDX: 0000000000000009 RSI: 0000000000000009 RDI: 00007fff4858f0e0
> [   65.825568][ T9320] RBP: 00007fff48590120 R08: 00007f822cc23040 R09: 00007fff4858eed0
> [   65.826329][ T9320] R10: 00007f822cc22fc0 R11: 0000000000000202 R12: 000055bd891e22d0
> [   65.827086][ T9320] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   65.827850][ T9320]  </TASK>
> [   65.828677][ T9320] Kernel Offset: disabled
> [   65.829095][ T9320] Rebooting in 86400 seconds..
>
> It means that if hfsplus_iget() receives inode ID lesser than
> HFSPLUS_FIRSTUSER_CNID, then it treats it as system inode and
> hfsplus_system_read_inode() will be called. As result,
> struct hfsplus_inode_info is not initialized properly for
> the case of hidden directory. The hidden directory is the record of
> Catalog File and hfsplus_cat_read_inode() should be called
> for the proper initalization of hidden directory's inode.
>
> This patch adds checking of entry.folder.id for the case of
> hidden directory in hfsplus_fill_super(). The CNID of hidden folder
> cannot be lesser than HFSPLUS_FIRSTUSER_CNID. And if we receive
> such invalid CNID, then record is corrupted and hfsplus_fill_super()
> returns the EIO error. Also, patch adds invalid CNID declaration and
> declarations of another reserved CNIDs.
>
> Reported-by: syzbot <syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/hfsplus/hfsplus_raw.h | 7 +++++++
>   fs/hfsplus/super.c       | 4 ++++
>   2 files changed, 11 insertions(+)
>
> diff --git a/fs/hfsplus/hfsplus_raw.h b/fs/hfsplus/hfsplus_raw.h
> index 68b4240c6191..bdd4deab46c6 100644
> --- a/fs/hfsplus/hfsplus_raw.h
> +++ b/fs/hfsplus/hfsplus_raw.h
> @@ -194,6 +194,7 @@ struct hfs_btree_header_rec {
>   #define HFSPLUS_BTREE_HDR_USER_BYTES		128
>   
>   /* Some special File ID numbers (stolen from hfs.h) */
> +#define HFSPLUS_INVALID_CNID		0	/* Invalid id */


Could we drop those for this patch?

If they're needed, we can add them in other patches.

I don't see their usage.



>   #define HFSPLUS_POR_CNID		1	/* Parent Of the Root */
>   #define HFSPLUS_ROOT_CNID		2	/* ROOT directory */
>   #define HFSPLUS_EXT_CNID		3	/* EXTents B-tree */
> @@ -202,6 +203,12 @@ struct hfs_btree_header_rec {
>   #define HFSPLUS_ALLOC_CNID		6	/* ALLOCation file */
>   #define HFSPLUS_START_CNID		7	/* STARTup file */
>   #define HFSPLUS_ATTR_CNID		8	/* ATTRibutes file */
> +#define HFSPLUS_RESERVED_CNID_9		9
> +#define HFSPLUS_RESERVED_CNID_10	10
> +#define HFSPLUS_RESERVED_CNID_11	11
> +#define HFSPLUS_RESERVED_CNID_12	12
> +#define HFSPLUS_RESERVED_CNID_13	13
> +#define HFSPLUS_REPAIR_CAT_CNID		14	/* Repair CATalog File id */


Same.


>   #define HFSPLUS_EXCH_CNID		15	/* ExchangeFiles temp id */
>   #define HFSPLUS_FIRSTUSER_CNID		16	/* first available user id */
>   
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 86351bdc8985..8f2790a78e08 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -527,6 +527,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
>   			err = -EINVAL;
>   			goto out_put_root;
>   		}
> +		if (be32_to_cpu(entry.folder.id) < HFSPLUS_FIRSTUSER_CNID) {
> +			err = -EIO;
> +			goto out_put_root;
> +		}


Otherwise, LGTM.

Reviewed-by: Yangtao Li <frank.li <http://frank.li/>@vivo.com 
<http://vivo.com/>>

Thx,

Yangtao


