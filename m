Return-Path: <linux-fsdevel+bounces-71680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D67CCCF3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2FC5302921E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BAD2D1914;
	Thu, 18 Dec 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="c1VGnETl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B233E374;
	Thu, 18 Dec 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077906; cv=fail; b=QnoIhuXReiqhaD7qV3cMWR0KdRHmpWzlmTAkkunNt6N5OuitqcYYwgWzSUs3OeLpQGSgdo0UXag4Jmycg5XDOs8xV6aIPyqJPMThVwIldOckqN3kJqLBQV6kssi15oJf439TkVAskYAR/5IAqJUeLdWCLJj0mZz9RLnyrS+dYME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077906; c=relaxed/simple;
	bh=9KjAbGuX1zN2il40x/K5Xbj7NW/BVa8qi3GKTmInhRg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qCF02zLJKMn9OCR7ZkMHk5zWp0dQh2BjiyxY4/XUIAsrR6W4fYLUj5+ZK63QbLGGIs1OP/l8vvLGnS1i622nQvLs39heSGqpcGYLI8TMj5vVR/yLKY/hh7MUmgqedFeZv/N8ATfL6FIgmKNEIFlcziOx0GVplCwb7CXqzKgipEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=c1VGnETl; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIGDZ7n753807;
	Thu, 18 Dec 2025 09:11:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eG9+6KfAmt0QmOLrAqsKLE77PzTDChG1hNmO0TG/OBI=; b=c1VGnETl2/QN
	KJB6gm5AVLAjBCsGAh7mtF5cvd87hAFwTfbdhXg2irUfdiRAYBLNUukHePpBhkrJ
	eue03uN4XSIVE5yD7htKCss5TDiYuq8lyp9aoD4wu6u/HB7M7Jx51cbN6+jqqSAA
	gli6Gskf5LX+fyOZByBeAjugRh/aDj68xLVEI9Xj1MBEiziorg3kbl46Ihnmr/bn
	tjmFtd8PHmTgK24bl794EUHfBR4XvjfL2m52FhMbwV9253+kTjCnqzlNbupBJqnm
	tNJ63QcHAIGepq/ju1tiogUzApeFJy5EsZa5osrD3tQu6ZZpUMG81b0untX4sQp9
	Ite3Sk95ug==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4b4b6c4ys5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 09:11:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuLXStMRcOY6840SOQJUIyuF8T95krdwL5Vfmgm4rxgna16tUaudFTVvujEzSWbU17BEFd+zB2BCh/qa5IIK7jhgcAN+LCeq5a5mmUhGEr0shljO+mF1S/ftWWQji+eZfDwKzhXO0bYkFCdq4Cd1O05OHpL22aqtagMuIZPqjFvWH/CjlLFHb4P4Na1J6pHL4eq16+Lje/RTNfMM191VmrPi4J45lISwSwRK6o1LKDOmHE+RyodfU1iLDBAL3CMzgfdb7RLEjBghNFsvnLkNLZGhnABkREzIva6Yekip/p4ldq+rLAkQ4Ucwf+mSIk1jKHNSVOn7edGlGHbKB3Uucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eG9+6KfAmt0QmOLrAqsKLE77PzTDChG1hNmO0TG/OBI=;
 b=y4gfy303ZCzUU/4NnonpSxA3LrSIx9lEY0ol3PZ6mZCLykIYTV2VsQy8/B1EZYeoUKutmFb0fP6YI+R4To/UGeWTETAYmGVCA5vZ943P/8vsIUiSoSOVnxfvMw0SCiOmq4LmaweydBT636HMUa0Z9WWPj/w3RBvAUUZF/mER+VpRCc4Eo8EXKyuKMy86CTjl6VruwYrQGwOos5xZWRXClHuO8wfOKVmDNsJCoiVKaJXQLrJaUT2GojvcTd553z9RJv//s6XHZDGzA3oH7bESDy1s+dB7lqS8WO5Uj/ktIzqWM6kiMQ8M1SwXJuOpK7yBeOk7J9qwcjRQRX3eH1TGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW3PR15MB4010.namprd15.prod.outlook.com (2603:10b6:303:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 17:11:33 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 17:11:33 +0000
Message-ID: <92a32c99-d996-480f-8641-d8dca1a077c1@meta.com>
Date: Thu, 18 Dec 2025 12:11:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] fs: touch up symlink clean up in lookup
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251217112345.2340007-1-mjguzik@gmail.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <20251217112345.2340007-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:c0::31) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW3PR15MB4010:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e84264-e680-4563-4bfb-08de3e587e3f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajZ0TzZKL05QSGFKMDFOWjZuWFhXZTEzNUdBUTBsVGlndDRLR2tZRVdnd2V2?=
 =?utf-8?B?Z3pwdXE5bjVFN0xKT1J2ZHNXWmdzMGVpTDNxVzNIN0dKbnVkVFNsSWFiUW8w?=
 =?utf-8?B?Zzk1bURDRzByTzNlVEhuYmpPVjNyYXdKZ0JWRU9hR2ozTmxZa3lHK2lNMVFS?=
 =?utf-8?B?eW8rSXpLeStyMGVxUUhzdEJjZUU0Y3hFeVpORHBmTlpOQW00VkNtVGhiMGVt?=
 =?utf-8?B?T09XOXZnb1Q1TkMxUnRtZUs3OUpKSnd2K0gwaloxMkx5aVJCV001MmpmVlBa?=
 =?utf-8?B?dndydVdmMjdma2xlWVppMG9tcGhlT1FZUnkzTEQ4cUo3QmlOWWFweTNXNU9l?=
 =?utf-8?B?SFpjTHRwckdDS2orcndDMUVwQ3Vqc2NQZDc5SVRRblNpZlRwSS9UdXJ3UFVF?=
 =?utf-8?B?ZjRhYlRJZm4vNTdxeU1JcXp5cU1xM3IvZURlRXBBNGprMENGSHZPS01Db0Nr?=
 =?utf-8?B?MDJhVnRXc1VUamZXZGhSNWNWazdKd2sxWTlRaXpDKzRiVXVKcGFMdTBsMnBj?=
 =?utf-8?B?WXR5VUxBelhwUTd3eUExRnBaR1pycUZSQWdUVXkzT0RvTzZ2L1BqL0ZqZm8x?=
 =?utf-8?B?QmllYkJZWkh3V3l4cWNFbXRiR28xWExkdUtmUVp3UzVPTUNQc1ZwT0JVNEo5?=
 =?utf-8?B?ME0yZk1LUTNteDlsb0xIcnRXdEpzcFoyNFE5ODh3RGJjekNaMUVjcmtCdmt4?=
 =?utf-8?B?V0MyMTliQ0Nrbms3RG5KSWE2OCtmSW9ncWtUVTJaMFU3dFkvTTBXM3BuanpK?=
 =?utf-8?B?dm9rV05PaklMUVcwMEFrdUczM2VhZGdRUC9qSkMxYklSQ0NtSE56Rk1VSEdH?=
 =?utf-8?B?czRJbnY2dXlHR3NjMjZCQnJQYytGYzV3YTIybkg1NlJ6QXZQVnJxYzF5T2F5?=
 =?utf-8?B?RGl1dzVnakkrMDBUWmpKQ2V0OVg0Z2xvTmYzUWsyeDZsY2ZqbVpWYm1rZU1n?=
 =?utf-8?B?NXo0UDJQZTRRTExFR0RxQVVybXdOSVhCWnQ0ZHFmaHZ0VmdFT3huYTVFUjZ6?=
 =?utf-8?B?c20xVG4xV2RXZ1lxdEg5QlFBYjFONFFsd1oxWkV2bUp5Y1FUUDdSQmtCQXlz?=
 =?utf-8?B?dTZyb0NLT285cWU5R0J4bHhvTkwrbmtkbjRWa2d1V1NHTUNPMjUxU3JUTXBz?=
 =?utf-8?B?SmFwU29oWkdoTkxBWkRkb2daU0hHanplNFFabHdvYi8wdDV4K2VtVWNkWFVx?=
 =?utf-8?B?NVhRdVhUcks4TUhldFJhVm5OMUd2c3VMN1JERFZvS0hYRVQ5RDluTEFiNTV2?=
 =?utf-8?B?MHNKWVI0SlZocmJwODFpNmJXd3N2OGVlVGxwd21KR1B3ZFlYQjMyTGFTMGZF?=
 =?utf-8?B?SFNSR25iRWhCZzA1NHNWYXhEUjRDWjVFdHlJc1JnRHFjUlhoVzVEUUZvd09i?=
 =?utf-8?B?MkpGTkhRczVsaS9rRmVlSm1GU2pDSjFFeVJCamdGQ2xMNVdJQ05LcTdXcSs1?=
 =?utf-8?B?VWRSdXBJR3M5K2pONFR0MGJqMXl5dnh3SUp5ZS9BeDVyeFpHc0p5SDU1SHZ4?=
 =?utf-8?B?YjdKRDlHS3VlOUVUWitPMHUxbkpJeEtGRWFDSi9naVdKdnZhR2RGWWZIN2cx?=
 =?utf-8?B?dEQ4Z0x3MjdWQVNXbDJYYng4bkU1Qys1UEY5ZXZwUWNnU1c3SW1FRWhWdHJ4?=
 =?utf-8?B?K3ZqY2k4amlGbVhUNVBydVhNVWNWU0IvODNoVlBTUzZwYlgwNkwxRmdkL1dz?=
 =?utf-8?B?bVBjc3ROMGtIS2twcWYwc05FaHBYSWJJK0l2cFV5TnB5V1FiUVhzYlFWOUhq?=
 =?utf-8?B?eHhyVFBhRFFLWFJXMUFmcmFHWC9zd1gzN2p0TVBMT28ya3JtdFRwTXpnQ1M5?=
 =?utf-8?B?SXpFWjlEcFdDdjFkejA5WmhVNEljVW5iQ3BJU0tKMXNUNytFdjVnZndpWmYv?=
 =?utf-8?B?cVdyQWpaazVYekQ3WEZucjdqU0VGMkQ3cGpTOENmT0lwVHF0VEhuNCtYUmRS?=
 =?utf-8?B?WUlHbVlsTzQ1Y29WY2UwMjZuRkRmRWl6emxvR3QzTXBobm9BMjJkQ0xrOEs1?=
 =?utf-8?B?VURzOS91Z2dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0xib1U2Qmh1VzZwa3AzZytSWDhldEJTT1NhL01sTk9za09Ud2VKbHhjRmVQ?=
 =?utf-8?B?MTRZdG5jbW5mOVBscVViUEhrNVU5WVFHclJ5ODVDbjhSMmhiWlBQQksra2hj?=
 =?utf-8?B?YzFMeG9uK2ZRZUR4cXJaRGlvZGpYdHQ0ak5FTmxwTEZESWgxOElwTUhkYm80?=
 =?utf-8?B?bFVFSEVETnp4b2RicFYvdGNWZFBQNG5sWFdqWnhzRWJaR2Q3OC9wd2F1L0p3?=
 =?utf-8?B?aTQ4bGkzUXVMSVdQZVFvazl6QnBGazUxN0E2MVNJT3EvdjVHV0htWHp4Wi9W?=
 =?utf-8?B?WDd5NUJmQnVUSzBaaWJFUmRaZGhKcDJOTlJ6SmpPSVMyN2RUUFkxSWF4S1FI?=
 =?utf-8?B?UVU3QkNxSFY2QzhKbmZqRXc1ZW5HSUpqTTE2NVpyYlNLS1VuNkxsdTB5enhU?=
 =?utf-8?B?OGFvREdpK3ZrVmlKYzJsVEIzWDNKd1JiNFFiMGpIMThaWFlzL0RuTXNjU1ZZ?=
 =?utf-8?B?d2tDcVBzRzlnTUxkaExCU0Y4OEtRRGlsZmxXQ0RpcWlMOWpmVUV5S1oySGJn?=
 =?utf-8?B?KzZickEyVWxVN2c0aTVxTTIzc1ZDMThieFRTSmhQYi85Z0tjUGJ3YUwvMTlL?=
 =?utf-8?B?OU5DcG5WL1RVNDZGRkZNMzNEdTZmdTRqOE1kMk1mSmlEdERDbXZsZjRWVk9x?=
 =?utf-8?B?a012TkJhMW1OdFlCNmdGMEZYejdFR0hEZndGVXJvU0h3Y2JBQ0VxSmF1UFZW?=
 =?utf-8?B?ZlY1TERHQmZ6UmtVbnpaU2gyTHNRN3ZvOUJpVVI4NnRnblBpMFlhWURvRFA2?=
 =?utf-8?B?WHp0Q25MQkpxSTgzSUo1NnpmTmE4ZUVsa2ppbDlMdkRwY3VPNFByQTBhOGxn?=
 =?utf-8?B?blhRSEJJUFBkS1dodm9xeU5TS1Vob0xxT1kySHRSQTAvTUorWUpqTzJCTFNN?=
 =?utf-8?B?bWZ0SDJUOHZiVUVOT2JHUU5Ob1pKV3pvYytVRVcyZysvRHFwNFMzTHYxN2JU?=
 =?utf-8?B?YWplTG5zRDhBS0ZhaDgxTGNsQWlRYVljVG1aYW9IRUtiUnNaczBlcEZnbEF5?=
 =?utf-8?B?ZW0zMFN3d1FtbXN0YkhjdU0ycVk4alYzQkRSSVBBY3NaSXJFdFBWTXIvdEth?=
 =?utf-8?B?U1ZIdmNWK1JSTGRKQVVQbHdYbGM5UGZZZVRwY3E0TU4xcEFDL3NrMy95Skhw?=
 =?utf-8?B?Mk4xOGFuNElYRHdhelRLalVFM2owRDNTRldkTzZYL0dsbEZMRCtBWmdBVDVt?=
 =?utf-8?B?clFRbkRsYjFDL3BzUEJSS1JVOWRrQjVsc3Mvb0lJTVhmODQ4dVV0K3k3ZzA1?=
 =?utf-8?B?ajdTWjZhdlhVSHJtNzdFMGxTWmltUjEwMXIxOWtJQSswZTRHMlJtTmREVFBS?=
 =?utf-8?B?eWY5ZjhiQjBqejQ0QkF5SWNkc2lhQlFFMzBYOFNXZ2FvUFNBUit0bzFMVUtj?=
 =?utf-8?B?U2J4dHJib3ZZZHlTeTlKb0R1MXRhSldteXNyMUVSYU1ELysrdlJOQU1UL21y?=
 =?utf-8?B?b0JHR09GTmF2cVNBTzE2b2o5MkpHWDRUZjlSK3BQOFduaTE4cTRRNGVNQTJl?=
 =?utf-8?B?NG1DcmxSeEZ6MmpISHQ3UlF6MzR1OGQ1cmluWE5ZQmJvZHE4Ymc3ZXg4bGxZ?=
 =?utf-8?B?Y1JNeTdJRkVrQUVidEgyNXVtNFM4UlY0bVFZK0NtcWVHbWY3UFQ4dUd1MzZY?=
 =?utf-8?B?cndWQnZ4T1ZSSjlnQ05UcGl6aFlDS3JlQ2wwVXV5UWE2NXYzeSt2bEZDc0Fm?=
 =?utf-8?B?N1pqVUYyTjRkY1dENzlzZDRlUXVaQ1E4K3A3VWJxd3JMY1hqQmV4cThKalow?=
 =?utf-8?B?S29lcE9EbWxOSTFLRjU2TTdxT1ZYSlVhLzA5YlB1NkpvRG91T3hFTHdpRDdp?=
 =?utf-8?B?V2p0TEh3WG9FQW5hcWFoVWN4Sk9RWFpXZVZ5MXlLN3JaVDU5czF4cnJNclVJ?=
 =?utf-8?B?c0JKNEJsV1E4UTF6Y010dWxtcXRGanRiMTVkZ2JKbWdGMVRVZGlSQWl6K0JW?=
 =?utf-8?B?V3g0RzJPK21XMmV5NmI1NkVZazZvclU2S29PNlVLeUFWTC93clpXK0dBVGwv?=
 =?utf-8?B?K2FjN0VmL1IwSU9zWk44bjBuSTlFaGh1bTZGelY1QVNRNGRiR2ZSOHBRdkdY?=
 =?utf-8?B?MjRZMlBYZ2VIb0N6Q2wxVythSXJkWWpsK1pDTzhxdDE3SzJMVEphLzdramtw?=
 =?utf-8?Q?fHak=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e84264-e680-4563-4bfb-08de3e587e3f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 17:11:33.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N02rYsAQBBy3ZME8B8fI3ZQ5Xiv+ZNLfI52sMBQbSStEXWRc+DX+sgDUoq+sEXfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4010
X-Proofpoint-ORIG-GUID: 8AwFjVDPadlXuaP5mRAe1JTTlUeXWLSM
X-Proofpoint-GUID: 8AwFjVDPadlXuaP5mRAe1JTTlUeXWLSM
X-Authority-Analysis: v=2.4 cv=YLeSCBGx c=1 sm=1 tr=0 ts=694435c7 cx=c_pps
 a=gJSDm7Sez3IyWyplfMHn2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=Q7gpkmmcOSroeDVMJPcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE0MiBTYWx0ZWRfX3MwWwe1z+5qB
 gbqWTyZRBZFkGPoYoKuquMPMJ2Jz1OrzbiCWAZMEsNUHfiQqxXUBLspFq75LQJyx2pF1FdQ/geq
 +V9cqf2GGySJXrNZIdBkZnaXh77lWrFjQvZ6RhVf28ZNS3a5XaOdPWwVCx8XPpbGonkzIoaEagr
 Y0aopGhkm3O5iWwEIxUJyk3UI9rFcxDpW5iA+DTKd93DF4+1dDw2Y4/EybiYWivJ+8gNfMArwcS
 W/TlhuzVLqw8QDYW6huw5cG5DIFZnCu6FHWbZ7yZZQqgiheKzyj/y63i/ZJjA44+S0gqZehRVaw
 Vslz25+DqvgmRJyNIg0A5B6p4c9PiAPHKGTORlL8PC8CXf1D4JkWizDV4YWbdmwTuxmlAQwUJ4P
 U1MLBx5XbNGkTSVVdxYMt/mGJ48nBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01

On 12/17/25 6:23 AM, Mateusz Guzik wrote:
> Provide links_cleanup_rcu() and links_cleanup_ref() for rcu- and ref-
> walks respectively.
> 
> The somewhat misleading drop_links() gets renamed to links_issue_delayed_calls(),
> which spells out what it is actually doing.
> 
> There are no changes in behavior, this however should be less
> error-prone going forward.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> v2:
> - remove the mindless copy-paste in links_cleanup_ref, instead only move
>   path_puts on the symlinks
> 
> this performs path_put on nd->path later, which should not be a material
> difference.
> 
> this assumes the LOOKUP_CACHED fixup is applied:
> https://lore.kernel.org/linux-fsdevel/20251217104854.GU1712166@ZenIV/T/#mff14d1dd88729f40fa94ada8beaa64e0c41097ff 
> 
> technically the 2 patches could be combined, but I did not want to do it
> given the bug
> 
> Chris, can you feed this thing into the magic llm? Better yet, is it
> something I can use myself? I passed the known buggy patch to gcc
> -fanalyze and clang --analyze and neither managed to point out any
> issues.
> 

Looks like you and Al are still discussing the specifics, but I ran this
version through the review prompts and it didn't find any problems.

With claude or gemini subscriptions, you can run them locally:

https://github.com/masoncl/review-prompts

(Other AI providers may work too, but those are the only two I've heard
about so far)

-chris


