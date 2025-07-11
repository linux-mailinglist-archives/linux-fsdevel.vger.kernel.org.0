Return-Path: <linux-fsdevel+bounces-54579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D92B01143
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 04:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A07D3AB05E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 02:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD19189BB0;
	Fri, 11 Jul 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UcQwNMIC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012068.outbound.protection.outlook.com [52.101.126.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2910E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201342; cv=fail; b=fgWODOHqCKGEWI7T9RcgO1/I1BzthPl1oozAceP7KeXXMBURnlZC3EIl8SCiOzk5Ea0KjMqbbKuBxXeyD/jbVa+IWxgE90Cs3d6wOwMzTFqA3RyPW17T2mFQxCxjkkU4a8PDIl4v6eLWGrZzo2BrrrZNyvaWVTLUf1JT1HSbQBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201342; c=relaxed/simple;
	bh=7D60ny0YP75l7LMPYZ2BQsbC1syLOtz0ErobfljjaOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YtZA2JkE0TheXYPcwCh+zgJil0ugSKOXLISgEYpxUzzQfQ6KTPbnm9a1FQWP62CInggFUNvYjNaHqVVTUXlA2m9/JEOOBG5FmbkkDNofN9PTvqd9FiL5hEoJbwjZxfF4JLtgpleumXcwntCvppv+BMxpViQKMfP0Pu+Wtg0kzRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UcQwNMIC; arc=fail smtp.client-ip=52.101.126.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq+IBOVYtUNtvnQlZczXohDfMPMqXtRmk1mzTahOsiBIv+ePjc8eV2N2bQ4bQ1h2N8pIGtXHScY2S4FpZkHXIOMUme86N84Iyhehxfr39jmAjZ3hWUFXcA5FONIBaeaER0pO8/hQXHGr6dSSohkaHD2Jti5RyV6LVXjUBe2T/wx9QqP5JG4CHg/0JeTquzJjwJbUUCaIYGoII8ZxtXFgZW/4ags44yWpGa6eDeKKn2Gu/EJoVtpZk+SWadWEU6UkraVik4Tj7e74yatm6qhkO8CaOqUdkTce2KgVJqiBQ5J5djLC7tTPxkd+lPoYjvcxcA4KejMOiWet13QHm6AHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6vG38SK3LeaO5Xnhddz0xOe31QvQri7cr6IVvDnbNM=;
 b=XUBRX2fRlHIlke5hmKSsbHYq6LPT41zmIrWolyR9wzgr7mw3Rd55szvB1y7dw0m4pTYSSQHAxyeRJof7/xBltsp9Jiy8XnZynst6l/mQ0ASoBapzH0dCs8c2bax7DqZh/6obo5+/dO7upwYVcYP0rzb7r1ANoiYnIUkzwrN6qEVvigRcn3bV1bR/OpfLhr5VxmT8rfK1zWsKK90qydtwTOIAmtccHEnA7Get9DXCJGGsWRV8e0NWijohAm4Bjz+/0byh/IUoucvRscqzCjybMlaIiIBx3oVxq4pLYd/mKz6n9lrkiKsoa3oAr55z71Y8btVhBRugBVIH3+hUTOSfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6vG38SK3LeaO5Xnhddz0xOe31QvQri7cr6IVvDnbNM=;
 b=UcQwNMICvbWXhoUmPqeaZyAO2i9n/frjDPuVyHo8v6xF1pyJW7vrbbpF9JvDAbaSA4zHgETz3T4mLjePIV/b7vdQdSra7QJEMZnyzN7amWQNBMsoRVDJIsDmq5LljKRwmhN2p3h9aMrKyulBWfyyf2pLTZ1dIgI7+bpNWSYjjfT22Ab9hQpzi4ihzt5KRnrKXeQAbhHBQvoq/B1QS4q0vCupcwMXJ9vuyDgmIubKt1+Ta0EmhLUsA2Qxq//ynDrVQKJ5rIcf/pTE7GCFlL5o0mMxnwUgZU1gnDY4gM+CDcP8SU8GT1F7Ly/vIBNcf6gIz5hzQ05nGivF9etfDfJG+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB8038.apcprd06.prod.outlook.com (2603:1096:101:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 02:35:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 02:35:32 +0000
Message-ID: <92b8b763-45a6-4e57-b6b1-88432e70040e@vivo.com>
Date: Fri, 11 Jul 2025 10:35:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfsplus: fix slab-out-of-bounds read in
 hfsplus_uni2asc()
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org, wenzhi.wang@uwaterloo.ca,
 liushixin2@huawei.com
Cc: Slava.Dubeyko@ibm.com
References: <20250710230830.110500-1-slava@dubeyko.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250710230830.110500-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7a4849-392e-4b3a-ce2a-08ddc0239a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGE4VGx2Nm94K1N5VVJ0ckJmNHRtNnZuMTZKaEQ3djEzVEFyMC8rWktyaWdD?=
 =?utf-8?B?Yk5xQlU3K1RHSUl1OEZRNDBqR2h0ZW16Sk1yK2VQeG1oRUlGaExTdmZuMDhj?=
 =?utf-8?B?WDI1RndHWm95TFlJNU50Q1BwNlFoU2NlRUc0Rk9WWFozNzMzbU1rMDJuODN2?=
 =?utf-8?B?WG0vV0JDTGJ6SndEcThxdWRhMUJzdnlBZktzb0hVeXR4Z0FGd04rcklKeWwy?=
 =?utf-8?B?aFhzUWRCU3AzK3hsSmlTd2dOZFpnVjN1NmJFUHBGcE5ERGsrTjJ2bm5TOUJG?=
 =?utf-8?B?UkwwU3FRMVozNlBuRjFQeFcvM2dacmJqbWxKUmNVWWRpdHliZU9Gd296MEFL?=
 =?utf-8?B?NXNpcC9aa1RSV2ZlODJOZjVWdGRLVU40TmtyN3lJQ3d2QUN4Q0RpQzVua0NO?=
 =?utf-8?B?clVWMVZyT2VCUkRvNG5yRjJTOUZ4V2xtd3lYOEUyaFB2U2FaeWxxajNDUW1t?=
 =?utf-8?B?cmdGLzk3bHpvOEVaS01nM1JORk0wUU10YXpJWk0xMkI2ckZKbmphNitXZ1JJ?=
 =?utf-8?B?djdLa0xXYWV0M1UwU0E3RC9oRmRjT1dadGxsbWp2YWxKV1o1SjJhMnA1b1lt?=
 =?utf-8?B?c0U1TzVoazYwZjlORWJnTDdhR1A5V1Y3K002V1lZenhGeWhnMWQ2QWlaOE1w?=
 =?utf-8?B?RkJyVU9wRzB5dEwyN2poM1VJeGxTeVpZYjdqWFJvTXcvTmtGWDBPdXFrUHgw?=
 =?utf-8?B?Ni9XcEREc0J5SitHb1dYWXlhN1oyVjJRQktKV0xTUnBMMGQraGJ6ZFZRMWRD?=
 =?utf-8?B?MHFpbUFwTmh4QnRxTThrV3JRU3EwY2ZoQjJiZFN4SXFwSmlTeG1xS2hOTm81?=
 =?utf-8?B?Z3BoUGNOak14bWhVSThuVWRYbFFXZUREdTM0d0I4ay9XOXZsL0wwbjlhU215?=
 =?utf-8?B?cGwzK3Q5SXNDSXd5VW4zU0NZMjNiNnlNNURXM2VtUVpmekd6QTJTb0Y1OTRw?=
 =?utf-8?B?N3NURXRDR2RiYjI5RGFUWHk2OWxsenFvS05kVE9abGxxblJLbVZXZnZwYXVw?=
 =?utf-8?B?SUNJekdOU0R6T2EwbjAxZW44U3dNZVhIcGlCam9vUzREVExsMnRzUmk5T3hl?=
 =?utf-8?B?TVNqL1A4MEJmcWlsajg4RC95ZVpUQUtRMjVsTWdNRzFrcm51ZS9teUpIaVR6?=
 =?utf-8?B?L1ZrTVQwZEUyZEZWV0Jpa0RMK0NaVGV2REtjbkJseTlhUmZEWjl5eGZTZG1y?=
 =?utf-8?B?c3BVM0QrVld4cU5LK1ZDTWFzSlV5UUxwQ3U0cFdJYjVkSGJKSVd5Y1pmRHYx?=
 =?utf-8?B?WU5PcUFPb0gxaGZTSUdML3pKMXdHWGxPSEQ4SUNxSWlncmF5M2RXMG5nLzd3?=
 =?utf-8?B?VjcvN29mYUNIT3FqbElrdmZVdkN2RWVTSDhxMnkxdHdtVEgrUkk2aWpsTTJD?=
 =?utf-8?B?NTZFdjBlZWZLM0FIdmhYSFAyREdKM3FnT3lReEMyTTRTNEJVcGhGMFJ4ZnRz?=
 =?utf-8?B?WW5HUHhYQ0YwTEx4OEQ4ZXBEWmhKVU1Td25iOXJjTCtFNUNtcG9SY3NNZEJn?=
 =?utf-8?B?TWFmZmZRN2J5N2FDa2QyNDhTL1cvamRtOS9DNU1maklURFNjSVlBRXVqUW9J?=
 =?utf-8?B?TWNkTkJwMUpMMUorYlN6RWluNm1iWnlESDdmV3paZ1J2YmNsMjVEeHFLb0FN?=
 =?utf-8?B?T2ltTGVpSEUyZkR2bm5GcmFTNXFlRk1TMzBnODNuS3Rva2xMalBrMnV2Vkgx?=
 =?utf-8?B?QVJtTjBqMHErQVhJMjZGNWdNU1pybFRMMXVBUkFnb1phUXB3R0hMTWp3WXZV?=
 =?utf-8?B?WjNLWU9PRitpbUNQeWZqQmp2eGFXaktqOXpPK2l1a01FTlF5YTV1UHpBaTlK?=
 =?utf-8?B?M1lRRm1IbklKdVo2WnE0KzR3S0ZWdCtqbzJoL1d5YUUyeVBxMUs3WVZsOXpr?=
 =?utf-8?B?RGdRRU15OHNia1B0d25HMytncHFtYXNnaEo0WXgrSjB6dFYzeXBPNnZDWG40?=
 =?utf-8?Q?g6Jo08O1HXI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmtQYk1wSnJJN1NybkozTHFIbXZmdUViMjhCZjg3VHQrNnpySWZnd2lqQ1dB?=
 =?utf-8?B?a3lsWHlacFNNaEwxMUd3QkVZY29Gck5aREZCM2NGd3NSc3NJa2lUWnh1bGpL?=
 =?utf-8?B?UUdTdERnUUZJdVlPZVNXRjZHKzJGOTI2eTNmYjJTR25tNG1PQmllTXNXSDVo?=
 =?utf-8?B?ZUpKc3NCQkRFZ01XZHJ2cGxBWjgwQldzOGRNSytTbUM4ZVU5RHA5RGR0ajJn?=
 =?utf-8?B?ZWIyTjBtVW5TZTFmOVRIZEcvWUtpTUxYR0RWME9JQTN1bDN0S2F6MWJWUEx4?=
 =?utf-8?B?eFZxbnNKbFR0QTdUZzVYV095bHVpT0NJQkJkNmhnYkREdTFsVFZKbno4RGtK?=
 =?utf-8?B?Y21wZlNSOTNZTngxMW5HNTFTR1lra0ZINDVmOTk3NVQ2eGYrNS9lMEx3N0pj?=
 =?utf-8?B?T084dHV6SFRLMHJocThCV1VuVlFqbGh5b0x4S0ZjOGVxWjNyWkFGRXR3REsr?=
 =?utf-8?B?SFVmcXovVEVhN290WFpVL2RzR1d3TzhLcDREWkJjcFlQc0g1alVqN245ck9T?=
 =?utf-8?B?dUxwdmlCRDFDKzBHUFBsemhrUzlaSWdMM0NEeGVpVnZReW85MUFnb2VHcFFL?=
 =?utf-8?B?dXJMQXNxUGZtOXduZDlodzk2clJvNDFpN2k2RjV3MTBrclNxNFZNcUg4WEp6?=
 =?utf-8?B?NklUZy9JRzVGNU1FN0hZN2VURlBqRGtnWGQxN3U1RG5TdW9FYzhkSkdONmZG?=
 =?utf-8?B?bFZkMkdSc1F6cEFCVCtiaFVON2xSditLTDRVSkZDS2ZJZ1lGdlNVVXE2NUly?=
 =?utf-8?B?ZWUzdEtWa2t4M29jTkh5aTNaSjB1TUZaQmhzSkQwV3gwOGgya1g5MUVzTGEx?=
 =?utf-8?B?VUhEZUduVHZBSnlXWFRjb1kybG9wNVFTdjBrQ1RlUXBzenQ1MkJPY3hIRFFm?=
 =?utf-8?B?dGtUanBBc3c1bVhkMUVmZ1ZBSHErQjBwT0FkMW1FZ0M2QU1EK3lZSlgzL1hi?=
 =?utf-8?B?amlSVFBFS2JGYWswQ3RKVVNBTDlVeTMyQ2pwaWkyZ25TWWlLNzBIbTlqUGp3?=
 =?utf-8?B?YzBkbk9XTVZEb0hrUy95OCtIbWppOUNLd1RhTUhIOVhzdjBSc1JYVWVkbkZQ?=
 =?utf-8?B?RXVsamNGc1BHQjNlb2ZDMHJyMTZuMllpV0c4UStGMHFNV2RIU0hNZHpwYzk3?=
 =?utf-8?B?TmdNSjM2L3RLQXk0M2lKY0JUTzNCeml5eWZBK0twd2J0ZjdEYWhKMUcxcnhn?=
 =?utf-8?B?R041K2hCY3Vxd1krWEJhZ2lLYmw1SzBRSXAwMVM0Sll1ZFpuT2NjNGNlVFBE?=
 =?utf-8?B?ZitWRFhuMEFIK2g2L3ZxYnBsYnJMdnhVUzR5anF5em81OHI4UEV6ajQ5eW95?=
 =?utf-8?B?Y2d4M2NqMlpqbkxzbUlsVHZsRDRCVW5ZZVN2eDJWVTlFdEJIdGR2ZnJkUUh1?=
 =?utf-8?B?MVZzS2x5c3JTY2hsaEJSclpabHhEMDE1dldwa3VNaHhxaElNdjAxd0V4bTZj?=
 =?utf-8?B?aXMvQW1CU2M3a05VMjFOVkJkWGlvVlhhZ3hyUUJ0TWZ6U3FxSnNnQ3ZkTjFU?=
 =?utf-8?B?a1RCbGNpcnZzNndkNEtCbW9FYjNRZm9YOHpUcEZNSk9JLzlxUDQzbysxSzhM?=
 =?utf-8?B?d0Jtbmc3OGNNQlFuNzNkTGdxdVNZV09aY0dyWUJOZzcwVXFGMXdxdUs3WXlS?=
 =?utf-8?B?Z2s3RlNxZEl3SmpwR3VlK1FNRlcrTG5pNitCdk9MaHI3ZDBTMGYrTldGR3ln?=
 =?utf-8?B?QVhWS084aEU2KzNkd0l4UXN3MDFocXVvTjVMbjErRE1XTFdzVGttNXZnanpJ?=
 =?utf-8?B?WU83dGkzejVLUkdPVVlIeUswMzZRTG1kTVY1TXRlUHVZeHEra1UzZ2p5S1A3?=
 =?utf-8?B?N2dwSUtTSTh3VlB0RmFLYjNhUUVjTDV6MEs4L1pxYjVnUVRlWWR2M3BYMWFr?=
 =?utf-8?B?bHAzMm4yMGNZVWNQaGkxUjZJcm04czM0czQ5K0ZkakxIVDlHSlZMb3lienpE?=
 =?utf-8?B?T0dIaHRTbHp1bzRsRERsVXE3L2tkcFgrY1ZjdlROZjJsYmp3MXhSRytka0lF?=
 =?utf-8?B?RzFtZm9ZVEczZ2d5Q0RibjVUdEpSZ2NuRjdGOTIxajFHSldSR21FREp0TzFU?=
 =?utf-8?B?ZjMrdEVNV0tRSXhSUmNOTTJaN2JaV3NDMWhiMUlhTXREbWRZYnVoUjNmZlFW?=
 =?utf-8?Q?IyjhFFtVHXMB9bpKWfoGdH2ps?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7a4849-392e-4b3a-ce2a-08ddc0239a74
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 02:35:30.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhg/gKrw67EqJv4DjJdnyRzwOmhUFHWYzE1TzaCRSPGcijZz+HEXS1igJLValdOGLq49ISbyfo0guEVLwhlV9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8038

在 2025/7/11 07:08, Viacheslav Dubeyko 写道:
> The hfsplus_readdir() method is capable to crash by calling
> hfsplus_uni2asc():
> 
> [  667.121659][ T9805] ==================================================================
> [  667.122651][ T9805] BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0x902/0xa10
> [  667.123627][ T9805] Read of size 2 at addr ffff88802592f40c by task repro/9805
> [  667.124578][ T9805]
> [  667.124876][ T9805] CPU: 3 UID: 0 PID: 9805 Comm: repro Not tainted 6.16.0-rc3 #1 PREEMPT(full)
> [  667.124886][ T9805] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  667.124890][ T9805] Call Trace:
> [  667.124893][ T9805]  <TASK>
> [  667.124896][ T9805]  dump_stack_lvl+0x10e/0x1f0
> [  667.124911][ T9805]  print_report+0xd0/0x660
> [  667.124920][ T9805]  ? __virt_addr_valid+0x81/0x610
> [  667.124928][ T9805]  ? __phys_addr+0xe8/0x180
> [  667.124934][ T9805]  ? hfsplus_uni2asc+0x902/0xa10
> [  667.124942][ T9805]  kasan_report+0xc6/0x100
> [  667.124950][ T9805]  ? hfsplus_uni2asc+0x902/0xa10
> [  667.124959][ T9805]  hfsplus_uni2asc+0x902/0xa10
> [  667.124966][ T9805]  ? hfsplus_bnode_read+0x14b/0x360
> [  667.124974][ T9805]  hfsplus_readdir+0x845/0xfc0
> [  667.124984][ T9805]  ? __pfx_hfsplus_readdir+0x10/0x10
> [  667.124994][ T9805]  ? stack_trace_save+0x8e/0xc0
> [  667.125008][ T9805]  ? iterate_dir+0x18b/0xb20
> [  667.125015][ T9805]  ? trace_lock_acquire+0x85/0xd0
> [  667.125022][ T9805]  ? lock_acquire+0x30/0x80
> [  667.125029][ T9805]  ? iterate_dir+0x18b/0xb20
> [  667.125037][ T9805]  ? down_read_killable+0x1ed/0x4c0
> [  667.125044][ T9805]  ? putname+0x154/0x1a0
> [  667.125051][ T9805]  ? __pfx_down_read_killable+0x10/0x10
> [  667.125058][ T9805]  ? apparmor_file_permission+0x239/0x3e0
> [  667.125069][ T9805]  iterate_dir+0x296/0xb20
> [  667.125076][ T9805]  __x64_sys_getdents64+0x13c/0x2c0
> [  667.125084][ T9805]  ? __pfx___x64_sys_getdents64+0x10/0x10
> [  667.125091][ T9805]  ? __x64_sys_openat+0x141/0x200
> [  667.125126][ T9805]  ? __pfx_filldir64+0x10/0x10
> [  667.125134][ T9805]  ? do_user_addr_fault+0x7fe/0x12f0
> [  667.125143][ T9805]  do_syscall_64+0xc9/0x480
> [  667.125151][ T9805]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  667.125158][ T9805] RIP: 0033:0x7fa8753b2fc9
> [  667.125164][ T9805] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 48
> [  667.125172][ T9805] RSP: 002b:00007ffe96f8e0f8 EFLAGS: 00000217 ORIG_RAX: 00000000000000d9
> [  667.125181][ T9805] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa8753b2fc9
> [  667.125185][ T9805] RDX: 0000000000000400 RSI: 00002000000063c0 RDI: 0000000000000004
> [  667.125190][ T9805] RBP: 00007ffe96f8e110 R08: 00007ffe96f8e110 R09: 00007ffe96f8e110
> [  667.125195][ T9805] R10: 0000000000000000 R11: 0000000000000217 R12: 0000556b1e3b4260
> [  667.125199][ T9805] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  667.125207][ T9805]  </TASK>
> [  667.125210][ T9805]
> [  667.145632][ T9805] Allocated by task 9805:
> [  667.145991][ T9805]  kasan_save_stack+0x20/0x40
> [  667.146352][ T9805]  kasan_save_track+0x14/0x30
> [  667.146717][ T9805]  __kasan_kmalloc+0xaa/0xb0
> [  667.147065][ T9805]  __kmalloc_noprof+0x205/0x550
> [  667.147448][ T9805]  hfsplus_find_init+0x95/0x1f0
> [  667.147813][ T9805]  hfsplus_readdir+0x220/0xfc0
> [  667.148174][ T9805]  iterate_dir+0x296/0xb20
> [  667.148549][ T9805]  __x64_sys_getdents64+0x13c/0x2c0
> [  667.148937][ T9805]  do_syscall_64+0xc9/0x480
> [  667.149291][ T9805]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  667.149809][ T9805]
> [  667.150030][ T9805] The buggy address belongs to the object at ffff88802592f000
> [  667.150030][ T9805]  which belongs to the cache kmalloc-2k of size 2048
> [  667.151282][ T9805] The buggy address is located 0 bytes to the right of
> [  667.151282][ T9805]  allocated 1036-byte region [ffff88802592f000, ffff88802592f40c)
> [  667.152580][ T9805]
> [  667.152798][ T9805] The buggy address belongs to the physical page:
> [  667.153373][ T9805] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25928
> [  667.154157][ T9805] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [  667.154916][ T9805] anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> [  667.155631][ T9805] page_type: f5(slab)
> [  667.155997][ T9805] raw: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
> [  667.156770][ T9805] raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
> [  667.157536][ T9805] head: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
> [  667.158317][ T9805] head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
> [  667.159088][ T9805] head: 00fff00000000003 ffffea0000964a01 00000000ffffffff 00000000ffffffff
> [  667.159865][ T9805] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> [  667.160643][ T9805] page dumped because: kasan: bad access detected
> [  667.161216][ T9805] page_owner tracks the page as allocated
> [  667.161732][ T9805] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN9
> [  667.163566][ T9805]  post_alloc_hook+0x1c0/0x230
> [  667.164003][ T9805]  get_page_from_freelist+0xdeb/0x3b30
> [  667.164503][ T9805]  __alloc_frozen_pages_noprof+0x25c/0x2460
> [  667.165040][ T9805]  alloc_pages_mpol+0x1fb/0x550
> [  667.165489][ T9805]  new_slab+0x23b/0x340
> [  667.165872][ T9805]  ___slab_alloc+0xd81/0x1960
> [  667.166313][ T9805]  __slab_alloc.isra.0+0x56/0xb0
> [  667.166767][ T9805]  __kmalloc_cache_noprof+0x255/0x3e0
> [  667.167255][ T9805]  psi_cgroup_alloc+0x52/0x2d0
> [  667.167693][ T9805]  cgroup_mkdir+0x694/0x1210
> [  667.168118][ T9805]  kernfs_iop_mkdir+0x111/0x190
> [  667.168568][ T9805]  vfs_mkdir+0x59b/0x8d0
> [  667.168956][ T9805]  do_mkdirat+0x2ed/0x3d0
> [  667.169353][ T9805]  __x64_sys_mkdir+0xef/0x140
> [  667.169784][ T9805]  do_syscall_64+0xc9/0x480
> [  667.170195][ T9805]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  667.170730][ T9805] page last free pid 1257 tgid 1257 stack trace:
> [  667.171304][ T9805]  __free_frozen_pages+0x80c/0x1250
> [  667.171770][ T9805]  vfree.part.0+0x12b/0xab0
> [  667.172182][ T9805]  delayed_vfree_work+0x93/0xd0
> [  667.172612][ T9805]  process_one_work+0x9b5/0x1b80
> [  667.173067][ T9805]  worker_thread+0x630/0xe60
> [  667.173486][ T9805]  kthread+0x3a8/0x770
> [  667.173857][ T9805]  ret_from_fork+0x517/0x6e0
> [  667.174278][ T9805]  ret_from_fork_asm+0x1a/0x30
> [  667.174703][ T9805]
> [  667.174917][ T9805] Memory state around the buggy address:
> [  667.175411][ T9805]  ffff88802592f300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  667.176114][ T9805]  ffff88802592f380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  667.176830][ T9805] >ffff88802592f400: 00 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  667.177547][ T9805]                       ^
> [  667.177933][ T9805]  ffff88802592f480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  667.178640][ T9805]  ffff88802592f500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  667.179350][ T9805] ==================================================================
> 
> The hfsplus_uni2asc() method operates by struct hfsplus_unistr:
> 
> struct hfsplus_unistr {
> 	__be16 length;
> 	hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];
> } __packed;
> 
> where HFSPLUS_MAX_STRLEN is 255 bytes. The issue happens if length
> of the structure instance has value bigger than 255 (for example,
> 65283). In such case, pointer on unicode buffer is going beyond of
> the allocated memory.
> 
> The patch fixes the issue by checking the length value of
> hfsplus_unistr instance and using 255 value in the case if length
> value is bigger than HFSPLUS_MAX_STRLEN. Potential reason of such
> situation could be a corruption of Catalog File b-tree's node.
> 
> Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org

Reviewed-by: Yangtao Li <frank.li@vivo.com>

BTW, how about to add add errors=ro,panic,continue,repair mount opt?

User counld choose error mode, convert to readonly node, quickly panic,
ignore error or repair it.

Thx,
Yangtao

