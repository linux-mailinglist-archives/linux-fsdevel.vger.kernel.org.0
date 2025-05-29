Return-Path: <linux-fsdevel+bounces-50048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412BDAC7BED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 12:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E254A753C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DE1277016;
	Thu, 29 May 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eFe+B6kF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013001.outbound.protection.outlook.com [52.101.127.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE0155335;
	Thu, 29 May 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515593; cv=fail; b=EVHgDjIParME4FxEbGoN8GrehZSjQjugsTBLU7h98kqEqBcTxSqv7bhhYKpWdhFX6Jmzdd2NTqzv1qdCoKHtOyKH6QYN9Yxz8pUotfcJ5Wl7YJdoKamnEavKaNFB1iiZU05CZSqoCcHrMr29NCC0e/vx/ttHRzvnqTPSw3RLdUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515593; c=relaxed/simple;
	bh=9q82cXjpMLLhfMZGnbHwAPmky3yq28g+vXEsjgeNwhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuzRcLI+HoU8Jo5A+dy0+vt80bsLNzk6RSl+d58GVdue8tK+bR/U3boyrPWme1Jwh6P3v7HGMZc430A1wK/+jaVfQ8dj3B2IGx5mQoN1b+7fq+53anF3aAU9ZRupzGCoCW52gCCbPKa898H/Rhvq43IbtBnFCFHaXlO/KXJ4E/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eFe+B6kF; arc=fail smtp.client-ip=52.101.127.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8y/fitLfNRQRXO3osACEze/lI8DFSw8s6Qt5N/ey6eer1z5T/qmAVL8CL2h/7RqKaP4QzlvXD86ncb3BIzxXrPLTtRAMy6F7CNR4dmBh9FjireZIzYhHFtkmXCwq9YX4RdojzoP6ZHfbkzoM3hhX3CSmaJHL7xomTqOSYk366MRqv7TmpmGSzU2bn28CkPbFaIUCpIjZi2F2IUlWoJ0bTvRtp+vV8nQAjj+IEx04tzVYO8JIXVvXncYauiXjZvdu0HopPs+du2RNVnV7M19mElel3VRU2b4BwUp5isaYpx9a5HX98atvf6zvvQhnEz+7unlPH4SNbWSDh+OKczIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoGtHV9PYEDb+j1CMkISe3HVQYAftMq01bNs8pPx1Uw=;
 b=MzTaQv0lsyvb/p2XjmPPMlRKXfeqUoBWMFhJMf8HuMkWG36CgucCYs5htSYiiL/1vcxdN0r+/ouisfUpfvnHN04ziGYtj30Vlr/po9g86KkcxY53oCArFmANc8IYJolR6wUoZZNBuYQ7eh/Tvgz8bIRpmbCN/QV4NRkpKxSu40bgyEMv35g0I0dgTYIkbINcrAlrLwUZUh+G4mZ3dOvymgBAspxfRb6WfKU8WWz0MCW9cV0KDLgmql76XHoN+s279wPUVo8wzzMhLwMF+m+YyRjw5TeRtWJxh6oylg21nCQlpt+hKcerhTgQKyr/aDM8QlvwUU9S+mHb+OzEQYbBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoGtHV9PYEDb+j1CMkISe3HVQYAftMq01bNs8pPx1Uw=;
 b=eFe+B6kFJIoSk6bZTzP8Mq/GkO8vXrBWrIYSX9wr4a55Zbg5YpAfHJ39NQAT/dDfkbY7ZnWhjJ2jEmmaEvb7/c6uFcvKCwpVKRVuGrsHNcyi/yeMeWxaU5QQmD+HMF3c7pl9sFcPpV034Dl2+YoNIMHAEX7pkQkbaXpBSaTrUePMP6YbQ65zUeuPMENrMsJZpLsvlASI8yMN4Gpj7iiZxcxKJBD80q7g12JiIvGiDKn86zIy9p5g9TpZ/SeM4mmKjSVpjHEpDsndF3hfNGoAmr2IOIFUdDCYnaZh7HPgiVLnqhwgMhLB44nCepVqxNqAmFKD7yF887Jl7L3NUQIVkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5711.apcprd06.prod.outlook.com (2603:1096:400:281::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Thu, 29 May
 2025 10:46:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 10:46:25 +0000
Message-ID: <e90474a7-a84c-4585-a4f3-120b783ee0a8@vivo.com>
Date: Thu, 29 May 2025 18:46:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfsplus: remove mutex_lock check in
 hfsplus_free_extents
To: "wangjianjian (C)" <wangjianjian3@huawei.com>, slava@dubeyko.com,
 glaubitz@physik.fu-berlin.de, Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
References: <20250529061807.2213498-1-frank.li@vivo.com>
 <7fd48db1-949a-46d9-ad73-a3cf5c95796e@huawei.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <7fd48db1-949a-46d9-ad73-a3cf5c95796e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8db7a7-620a-47b5-653b-08dd9e9e0eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkhuL25CZTRjT2JudytYSnBOOXhLd3J0d3hCMEVSQTUxcDI0SERTR3Bac2hO?=
 =?utf-8?B?QW1yZnUwcjlJcGczeTVCV3BSOHQvc254NEdRUmFEQU5UeDlubWtUTFp0ZU1K?=
 =?utf-8?B?N2hvTnUrUEV1VVBJdFR0M3lXVjZuemtvRTU1Qkg2citKZEVTTWdOaFdsekNm?=
 =?utf-8?B?NUhPa3dVbVkrSms1REZQbFNoVmpMbHlueFNGRU96a2plT0F4eVNraDA5RmlS?=
 =?utf-8?B?ckwwaGVmNS9jd3Ezck1ON1JtQStJUWdQRGFTT01hUG1YaVk5dk01Ni8wYU12?=
 =?utf-8?B?SWlQNW1ua3BwbzR0c1lidWx1U3hDempzQjh0UWl4ZWV6TkE3UGprVU0vTGNF?=
 =?utf-8?B?M0Fmb1dLdEs0YkQ3dCtjUTBKWEsxTlVWRnluV2dlQkNkemh3MnU5LzBoUXph?=
 =?utf-8?B?VUpHYUlXdkZlM1JvWjVzMU5nVUJqM3h0YWpLeGZzSWJxRjg2cEIrdnhSZHBL?=
 =?utf-8?B?Q255aUZEdCtBbVpDNlhodHlGcnVNakFEaGRnT1JXTGxXaklCbmRQZ3NHUmpB?=
 =?utf-8?B?YXpVRndWY3AybnBCWGZqbkhVejJqeCtKRjV2UkhzSStjQ25GUVNibjdyTmNo?=
 =?utf-8?B?VnRFd202K2lSdngwdnFLR0FGU2t6aDhhdGh1ckpJbWU5RldXZmNjNWx5S1BV?=
 =?utf-8?B?eUtIQUhQdjl6YThzTjA4N3kzWkpmUDkzZUFUWUJHcklTb0dBRDh1WVQ1UVl3?=
 =?utf-8?B?a2ZoWDJQbXAzOXB5Zlg1NFJ5UXRvR0FNTTVMU0ZQaHFjZjFaMlgzN0dkSkRN?=
 =?utf-8?B?UlZoTkxRcjdqT3BLWjRBRU11dW9YVGZUSTU3TWp0UGx5Qmk2TTBTOEJMUCtn?=
 =?utf-8?B?S1hQZ2tGTTU1cHlkQSt3amxxc2treElCczZLb09jaWxkTkhYVWJwSEg5ZE1I?=
 =?utf-8?B?V1BlMTUzNVd2ZWN1MmIyeXJ5eU1HZ25PVTk3cERycm5LRWt2NXY5dHBUQ1Zw?=
 =?utf-8?B?R1FORnlaTndCZjQ1bTNsYUhjeG9FSCttUEY3Uyt3R0pFNFZUOW1qZ3h6RS93?=
 =?utf-8?B?Nlh1aEhiVXd3L1FiM0wraHRab2w3WkY4ekxXa3ZRUUF0SUdEY3pJaW9BKzln?=
 =?utf-8?B?MXl0RVFzRzdvb042aFEwcnN3VlFyd0dLSTF6QUhHdXhIQXdNTnRaUEVPN1g4?=
 =?utf-8?B?UXpqL1p1dVA1UlJkMGE3RWhLZ3A5bTJUZTdlVFR4c1NVT1ZKcTFYQXNxQVFh?=
 =?utf-8?B?Z1pVeWdNdERjTFRqSmpJbHB1OTAyNUQ0WXNLbUkyVnNwUDZwdFpjb3pUMHJX?=
 =?utf-8?B?T0FOamZDQXdLb1RoWGFPSUdBQ3JMNnBIcEhmbXNVblBJQ0thVm5BZ0NrNjh1?=
 =?utf-8?B?YUFpOFYvdFdoR2hyMk1zRXc4WTB2UGVlQTFGM3NCZEkzYkZLVnFDMkdqSGFl?=
 =?utf-8?B?ckJKN2RTY2NFQ2xBMzNtT01jWHptam9pazZtQWdqRnlqSkd4Ykc4NHphZmsy?=
 =?utf-8?B?cTUyNDNvYTBlVHhCbmkvdWxwb0ZyZWVLSW5IUnpxbCt2SE1pRWp5R0hiRUVl?=
 =?utf-8?B?ZmI4VndMcGJSSjFPaFZCeDhFaVp2UmdXUTVPVU13SnhHR0FMcFpLd28vdDZn?=
 =?utf-8?B?cmU2Z1pzcjV0dy9kbVNEa1NPZUVNYmp5anl5N1ZEdHNnVm1CeHVvRWNLNWpi?=
 =?utf-8?B?SFBsU0hPeGt0bFNDWHhvWVVBWUhjZDVuMWx0UzJ6Z2lSbGVjSDdxTHdOeVBm?=
 =?utf-8?B?dTdaZGxNOXd5aGVpNW9UQ3BWUjZRNTBFRVIyaW11NTJPV2Y5SW1ReXF4Vnoz?=
 =?utf-8?B?a2phK0hueHB5QzRjNlhJWjFScnhiY254R3ZRS3M3NTR4REtpODZGT09pOHMz?=
 =?utf-8?Q?7l7HJZxkSIwiFB5fQZV0Uxi+A74sBnVYIp4I4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3ZjQnhyeTg3b3RUditIcnJPWDhKSGxxMlhkQlN1Y29zZTEyaldVQVBVaTI5?=
 =?utf-8?B?bVVBZ09OMEdBUXFsYWtIT2R1UEpNenJnUjlIVGxNRmNLcm5jTTc0ZXgvU2pI?=
 =?utf-8?B?S1lpNjNGTTladVlnL01lK3hTZHZENDB2bjBQTEd0aEZ6RFpxTTUybHRyM01Z?=
 =?utf-8?B?ellUNGcvNitlY3JOM0lOOHA1dFVwQnk2YUJMbGl2MENDTkFacGJiZnpnRGFm?=
 =?utf-8?B?NTVkU0dVQVFWM0RDT2djcXl3OUVwWUUrMVVJbEZmam82UERkRUk4WXppS0Qv?=
 =?utf-8?B?RjVUMTZVcUpNNUQzKzNhSGFjV01hTC81d3VoK3B2VVZsODZsY3dUbnBrakFU?=
 =?utf-8?B?QU1SMFJsWUsvS2FVdU5ibk93dFR6OTIyYWwwQWEvcldyZCtmZ2w0R1lnVkFN?=
 =?utf-8?B?UzEwYXJZVTk5N2VDbkpJWHJHb0YyQnE0M0kvYjhmbDNxZmJKYStKOFZUcitD?=
 =?utf-8?B?ZEduVWUzQVlCWmVEaEc0Z3F2cTJlZVZENE14Mko0T1lIbVprOEtCaFFBR21n?=
 =?utf-8?B?OFppczZ3VDdDTnhsVmw2cC9BY0tSM0RuZnJxcXdvZ2c0UEdhOXhqUnAzR1lU?=
 =?utf-8?B?UlNDRHdwZWc0WDk2YXlRbmJCSzVvTUxYeWdLU3JPbDkxRG1PM1NwOGtxRWVO?=
 =?utf-8?B?d21TSDlLdjBmcElUbmVkYVROc0VQWXp6MURGQ2tnQUE5SnBLbjNvQVZpU1Fl?=
 =?utf-8?B?MlBERnRmUTFpQUNZam9KZnVaUlpPTGJhd29ldHVlU1ZOblBpVTVhVnloWnBr?=
 =?utf-8?B?WTZPODhwT0dSWWt4SGFrc3hueTFQMXZGYWpXaDNoK3FKYk5iQkl3M2ltK1Yz?=
 =?utf-8?B?RWt0N2szUFJyL0NyYkcrV01VckY3YnFQSkxBMTRBZnl3ZmlmdjM0eXNNaXRC?=
 =?utf-8?B?SlN1UHRBZzdVcGlkSUNScHdMcXhXdVZJU3VlaWZWdnFZOFNrUldPMlp5WWVH?=
 =?utf-8?B?VGxtOXlDTVpWdWFmOTVFTEc1Vkg5VTNaSHhWcVZBQTc1WXFzcXZsS2dDbVh3?=
 =?utf-8?B?U3owaThIR09hOW9TUmZMTllRUE9YOERYSGhhZ2J3V3VUZTlycEl6ZExVcFJJ?=
 =?utf-8?B?c0wwUDlzU1dKeUt5RitMeGVDNkxNaVhxVDdTQ0g2QjE0WlRBdXhiZUdLTVdY?=
 =?utf-8?B?RE0rUlFRZTBUNzAvVUxaYjNCSjFPQXRNZ29VWUtieVltMUJuRXRVR0NERWo5?=
 =?utf-8?B?akduSUZKd3VpQlVOMitUTUl3Q0hNbGFSQzNFb0l0OVBoSmFra2xYWkdFclpr?=
 =?utf-8?B?R09oYXh4N3JEU3NuVkVWWjhVdG51aEc2dWhabXh6WWhVWEdqb2JCVWFRczB6?=
 =?utf-8?B?aTBHeVlmMVZSQTNucUF1MStwWFBBYXAveTk3ME1QaFc0Q01BU1ZMZWhDOWl1?=
 =?utf-8?B?R1FZZXhMWDI1ZktaS09VcmswQnk3eEsvR0Y0LzU4NHNxS2R6NEFjU3JraFA3?=
 =?utf-8?B?NVhjUno5NVJmcXkxMWhEaGxhSkhxWjVCdTRPVStyZ3hVZnJuTFF6ZG00dkVm?=
 =?utf-8?B?QmJHSjh5elNueXp5d2pKMWNwaC9ZaFAvdDdRWHRma2lzaE1jMEZQaG8vc2RR?=
 =?utf-8?B?cDZENnpkY0VweU8vTjJWdXR6ZjdrK3d3THpRUFVnemZxM20vaThJK21FcTNs?=
 =?utf-8?B?aGtaR2NNbGdIYjNsTUY5eHZQWmNuQk5qTFdaNGlGWDJIY0pVQmd6dW0xT3pP?=
 =?utf-8?B?LzNla1lGTDE5VjZlVnFLL3B0Ym1uODF0TTJucGlybW9UOTd5dFRhZlVwdG80?=
 =?utf-8?B?aSs1am5UOWV1WE5oL2FYSStvN0NGQUJ4dVVrTWpTU2paL0p0VG5EbHN6NWdG?=
 =?utf-8?B?QXpvVHhIcW55czJSNGVUcDNVSkFtRUo3bll5MTkxdlVNendoSzM5ajZqSksw?=
 =?utf-8?B?bVYrZlUyWHBzcjZtRC8rTXlRSHdyQWRBMkY1T3VwNElCYi9wc255dzllSVEz?=
 =?utf-8?B?eUthNllQZ1J3VURxVHVxWE5wQmJIS2VuSGxLcWo1ZGpHQU1vUC9KNk12Vzc4?=
 =?utf-8?B?UU9remN0VjV5YnhGYlFXWXpsbndkZi8wTWcyUy9XOTBlS1lBQ3FRNlpHdmZy?=
 =?utf-8?B?TW5HdThZN3VCb3NrZkt4ekpyZDVxeXVibEJRbnZ0M0NRTnU3VU9MY2NKaVNX?=
 =?utf-8?Q?4co82O5MScvArcZjtcWBiOzo2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8db7a7-620a-47b5-653b-08dd9e9e0eb2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 10:46:24.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnYyedqjIO5x6iDBf20czZAb9caP4fNDXJm0mkGJXu5wKHXO3e7ytLqUqIe02iWJcnorEZ+gDhUqJAxuK8tF4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5711

Hi,

在 2025/5/29 18:34, wangjianjian (C) 写道:
> [You don't often get email from wangjianjian3@huawei.com. Learn why this 
> is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 2025/5/29 14:18, Yangtao Li wrote:
>> Syzbot reported an issue in hfsplus filesystem:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 4400 at fs/hfsplus/extents.c:346
>>       hfsplus_free_extents+0x700/0xad0
>> Call Trace:
>> <TASK>
>> hfsplus_file_truncate+0x768/0xbb0 fs/hfsplus/extents.c:606
>> hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
>> cont_expand_zero fs/buffer.c:2383 [inline]
>> cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
>> hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
>> generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
>> hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
>> notify_change+0xe38/0x10f0 fs/attr.c:420
>> do_truncate+0x1fb/0x2e0 fs/open.c:65
>> do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> To avoid deadlock, Commit 31651c607151 ("hfsplus: avoid deadlock
>> on file truncation") unlock extree before hfsplus_free_extents(),
>> and add check wheather extree is locked in hfsplus_free_extents().
>>
>> However, when operations such as hfsplus_file_release,
>> hfsplus_setattr, hfsplus_unlink, and hfsplus_get_block are executed
>> concurrently in different files, it is very likely to trigger the
>> WARN_ON, which will lead syzbot and xfstest to consider it as an
>> abnormality.
>>
>> The comment above this warning also describes one of the easy
>> triggering situations, which can easily trigger and cause
>> xfstest&syzbot to report errors.
>>
>> [task A]                      [task B]
>> ->hfsplus_file_release
>>    ->hfsplus_file_truncate
>>      ->hfs_find_init
>>        ->mutex_lock
>>      ->mutex_unlock
>>                               ->hfsplus_write_begin
>>                                 ->hfsplus_get_block
>>                                   ->hfsplus_file_extend
>>                                     ->hfsplus_ext_read_extent
>>                                       ->hfs_find_init
>>                                         ->mutex_lock
>>      ->hfsplus_free_extents
>>        WARN_ON(mutex_is_locked) !!!
> I am not familiar with hfsplus, but hfsplus_file_release calls
> hfsplus_file_truncate with inode lock, and hfsplus_write_begin can be
> called from hfsplus_file_truncate and buffer write, which should also
> grab inode lock, so that I think task B should be writeback process,
> which call hfsplus_get_block.

Did you read the commit log carefully? I mentioned different files.

> 
> And ->opencnt seems serves as something like link count of other fs, may
> be we can move hfsplus_file_truncate to hfsplus_evict_inode, which can
> only be called when all users of this inode disappear and writeback
> process should also finished for this inode.
>>
>> Several threads could try to lock the shared extents tree.
>> And warning can be triggered in one thread when another thread
>> has locked the tree. This is the wrong behavior of the code and
>> we need to remove the warning.
>>
>> Fixes: 31651c607151f ("hfsplus: avoid deadlock on file truncation")
>> Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
>> Closes: https://apc01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fall%2F00000000000057fa4605ef101c4c%40google.com%2F&data=05%7C02%7Cfrank.li%40vivo.com%7C54c2b4030d4c4a98c6c908dd9e9c71b1%7C923e42dc48d54cbeb5821a797a6412ed%7C0%7C0%7C638841116945048579%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4snXozMFZN%2FsmsL9CP5VJb4mf2p0ReNhQIEuA%2B3tD3A%3D&reserved=0
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/hfsplus/extents.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
>> index a6d61685ae79..b1699b3c246a 100644
>> --- a/fs/hfsplus/extents.c
>> +++ b/fs/hfsplus/extents.c
>> @@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct super_block 
>> *sb,
>>       int i;
>>       int err = 0;
>>
>> -     /* Mapping the allocation file may lock the extent tree */
>> -     WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree->tree_lock));
>> -
>>       hfsplus_dump_extent(extent);
>>       for (i = 0; i < 8; extent++, i++) {
>>               count = be32_to_cpu(extent->block_count);
> -- 
> Regards
> 

Thx,
Yangtao

