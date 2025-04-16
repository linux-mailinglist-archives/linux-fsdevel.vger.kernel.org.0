Return-Path: <linux-fsdevel+bounces-46556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2793EA8B69D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 12:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAEF190458A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE61238C10;
	Wed, 16 Apr 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="CnpXb3tJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3D238143
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798707; cv=fail; b=qusfCV7dDmCwiQgj/t1snIqm8CYiXbwTLa3/S4PThIWUZMYwa+aNnmWbS/UsdpXOi4x7vcqim3Ob5T2sEyGJjYKabrXvyMZ/D/hM37CllBIqamUbHQ7lu9Rm8hQi9mVcoSvtJqoNlfWj25pGmBXwuC1yv8u6eQcUmf1mW2cYNW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798707; c=relaxed/simple;
	bh=ecd3jFPwgbbjY2Kfn6UtjU+56xjWE/68OsK6klHMuQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rQQAHaAEcheryseJQVo4opKoZ7g09pWaPivUXYLYxQOx+cBMqKvVz3b4rCv251fx2M5CtGIuG/7AslooWoUV5yt4sN4fckSEsuQkfVusbay2EV90cuQgjNEBEDtxOQbirAO69Q24HIGR8V8uZz5VYlmngyWhZlkSN0teKf76ZaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=CnpXb3tJ; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46]) by mx-outbound-ea8-37.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 16 Apr 2025 10:18:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf+aYE5VV7eU6Uc8VvuYS4BJHUJ1F4k84ugd9UbahWvYTjBc0lGUtwkbD+RmikABZI+pYKBz40FXroHUh6RpBVb+T5EQHGBJhHTLHL1DJfhIZPjiB/uQCLLem0n3QlGR6Gagm0sS42wxbr0zPQl58Aa81EskBT6VG8m42gQesVNK5dKWFb7xlgv236XAqL7fDdquvoxQDTlK0RKIc9YlgqYZcgUQ7qHnwhAyz7B7derA650rvemAKVAMoEJSmjaOCNz8g5SsLV/+w6pklpK0WzTet0dS+Wvq3LIp4e4JgfxHsrIu7mWIyMhN9xA0Zh/twMG9rXhMx8NvaFw6Pq0Esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL2TWtG2daH6dOTJ0qTX9fqpcB+2FXBKor9QRmn4iBU=;
 b=U3QPI/5fvzosq9BZbfNgukS1jbJSdOnZ6QcdMvCjvazd7z/Xb11oJ8duiMPr+RNDd6Uzo4KQ3eIxodIrCF4RMT++TSSeS45+ICa2EQcO3bHfeAOu8GX6cJBOOf1fQlucCJbGz2QUyJNl/MGWTV1Miezt3/+YXVfBa36f8vJnOvrg39PEwiZQX/oaKPCaYQXPRgvp08EUnhM86BtvsMfKjPvKTzKJ6Gq4Czy76a8FUe0dJtEuCb0ReRpx7z5THWyz46g50FPPcrRw5AGa4bjk0ullesJkxrmUxCgM48xgNGSG4sybFLSeNwIByaMpPjeYxW/dWahXIjo+WFXgDYHSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL2TWtG2daH6dOTJ0qTX9fqpcB+2FXBKor9QRmn4iBU=;
 b=CnpXb3tJh6VyLvWSRh9YK4OiaK7TKGMCfzMcSEzcEZnsn4oJGfBhLThSA40dOm1Bgh3mdD6/sr+n2Q6H4nuL3GTPlfEMxSVkKpnqOdXxRHAqITE5A7RROyCSNA0G5D7/wTlmR61bol37PynT6PEIjbU7TiyTNIFlwdu+y1+4ss0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from BN6PR19MB3187.namprd19.prod.outlook.com (2603:10b6:405:7d::33)
 by SJ2PR19MB7313.namprd19.prod.outlook.com (2603:10b6:a03:4c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 10:18:12 +0000
Received: from BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00]) by BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00%5]) with mapi id 15.20.8632.036; Wed, 16 Apr 2025
 10:18:11 +0000
Message-ID: <0e1a8384-4be4-4875-a4ed-748758e6370e@ddn.com>
Date: Wed, 16 Apr 2025 18:18:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "mszeredi@redhat.com" <mszeredi@redhat.com>
References: <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
 <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
 <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
 <8b6ab13d-701e-4690-a8b6-8f671f7ea57a@ddn.com>
 <BN6PR19MB31873E7436880C281AACBB6DBEB22@BN6PR19MB3187.namprd19.prod.outlook.com>
 <CAJfpeguiPW-1BSryqbkisH7k1sxp-REszYubPFaA2eFc-7kT8g@mail.gmail.com>
Content-Language: en-US
From: Guang Yuan Wu <gwu@ddn.com>
In-Reply-To: <CAJfpeguiPW-1BSryqbkisH7k1sxp-REszYubPFaA2eFc-7kT8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:408:e6::19) To BN6PR19MB3187.namprd19.prod.outlook.com
 (2603:10b6:405:7d::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR19MB3187:EE_|SJ2PR19MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf36413-49b9-428d-a0e9-08dd7ccffdd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yy93TlFrSkZGNS9jenNyb29pdVdoRXN6VmZyWjQxdW40clZRR1F5NnovUUdR?=
 =?utf-8?B?azlZQStYOXNXaW1jQTlyUDFRajFrVUxEUjZReW5tUU1lWTdJeG8xOHJ6Z3lF?=
 =?utf-8?B?NUdXcXhXaHpzWGxQTmtVeldwYjQ2eWljVnpiRW1YZFJpUDNEcnNTdm92TWRm?=
 =?utf-8?B?bnZpakk2YW9tQWF2RHo1Qy9Fc0NtT1FkQk9DSk1JYjhORkdqSkYyTjdBaDBt?=
 =?utf-8?B?UmdEU1h3cWFoOW9uZExPOWd6S3RWQWtWeDdGNTRNbndsa2RlUFlhT0dvTFp1?=
 =?utf-8?B?V0JDS1AxQ3lHNk85V2VPT0pjTi9uRDZVMEZhV3pBY2plUTJnSUZxaWNRQUdk?=
 =?utf-8?B?bHV3d3VLaEhTT1NjZmYvaUkwWDBiUHBZNVhKeHFLL3I0KzFQL1BlVEtMeXdD?=
 =?utf-8?B?NHVhVTN3ejZSTGJhL05acFhLUWorcDlidlorRmdSTWZUWGw1SjVFeGJvZ0lG?=
 =?utf-8?B?WGIrNWN6MjdHUXhiUTFoNnJ3VkVxbXJpODZFYVJhMG1NOHBjWmhNaXFIUDQy?=
 =?utf-8?B?ejM3dWZmUFgweU56UHVmLzlLRjYvS04vOFZkL2NYMzgwbzdwcjMwbUh5VXdo?=
 =?utf-8?B?aDNmV0FtamtHTTdzaU9lYmJndDJaYVdYV3JFdmZzd0xrQmd2Q2xKdmN3NFFo?=
 =?utf-8?B?ZjY5TC9wL3RHYjBEOEpaU2NnbU1XRjluMzFTdTU4ZmRmMm1rV0taWE13c29L?=
 =?utf-8?B?WU9MZjlZSkt0Z1FyekpFWmlvMkdYU2ZTdkQ0YjV1c3J4YmZZalZsQ2QwQlpX?=
 =?utf-8?B?Y243S3hCeTE2a3JjQ0JraGFkZUpab3ZMRWRTWU9nVGZmY05UVlhmVGtSUko3?=
 =?utf-8?B?Vm5JdXcvQ0R1R3Bwd2MyK3hmbk42TUNXYnpIenBQVmRiTmxucWUwbC9iY3RQ?=
 =?utf-8?B?UmdYcjl2ZGo5dksxWnhWQS9vT1hsUTlvR1VPbjBrSVpYdXJrV1NFUWF5UXhW?=
 =?utf-8?B?UGJtMkR0OVI1dG12dkdTT0g4enhFSDVOclFZSEVod2piQThGNG9vUVJ0SVdo?=
 =?utf-8?B?dzV2T2xSK0hXWGVWMTVKRENCWnFGL25MZUwrY0xwZU5XdkdvNDMvaVVlREx0?=
 =?utf-8?B?RGJYOFI4ZnN6MDJ5ZlVzNFJpNDMzclNTU3JpQ01FQ0pFUUczeG5tVnVGSFFw?=
 =?utf-8?B?VGNHRnNWZ0huazVXZkxzVk5yNkpDaFdocXNPNTZjeERjUmRNRGZqZm1yMXd3?=
 =?utf-8?B?cW9RY1MvWlU1RUZyQ1ZRU045R1BjdHAxSHVKYmpzdjdob2FQbUVLUjFiaGVL?=
 =?utf-8?B?V2ppa3ArbWl1N0txWENtT0Vha1ZJekgwOXVzUktPZUJXMms4R2M0YWVaRDh2?=
 =?utf-8?B?cG1lV1JHdkl6bkQzOTVIc0NIU0hoNUpnTTdQQ3VwWE5mUkVxQmZLMUpuK1JP?=
 =?utf-8?B?UWgrdUY3MGZwajc2dUJsVkd4akRDQ2JMMlFjSDhRbktjUk5MQkM4MTVobHYx?=
 =?utf-8?B?Nzl3Y0FnTy9FcHltejB1cWdPMUNCVkhvdVBpRlNKWjB6VmdVS3FFeStiRDJH?=
 =?utf-8?B?TjVISjkwT3E1SitLUU03Qk1UdHNLcGR6TzlsUWU1Yk5iUVVIZGVkd1Y1bnV6?=
 =?utf-8?B?T1Y1N2RjOVI1ODltR1Frb0Qwa2RETDlUYnNNOHkyRC9oU1RqemYzSUdJTFc4?=
 =?utf-8?B?YkgzNUp3MVAxK2tUZzYyTUxzazRPRnpNait6MkN0QzBOZzhKaG5qaVlSTmJB?=
 =?utf-8?B?dVcySEEwZEtuT2EvUzJBbmJQL2g1RjY0cUtkRFd0K0t2eFZqQlR5NHlud3BN?=
 =?utf-8?B?NmZuWWMvRWd0LzJpeUYzcTZLeThGWkxMNXJ2Vkxya2tNb1kxbHhKMGltVTF3?=
 =?utf-8?B?V1NSWE9xeElBYzhLWGttOFRsUVlEZ1RZUkVSTDU0WDY3RzN1U3FnVXpiZ2g2?=
 =?utf-8?B?YWp4REV1UFBWZlBqUnh1cmhzWlExTmp1cElMdE1IMzdXOGc2elpEd1l1b3pv?=
 =?utf-8?Q?IKYuzwdHK10=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR19MB3187.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVliZUxvZnRJMmRTYjFRc1hPcVhFUjBHdkxLRGlKblB0dGlOeVdEbkdIazE1?=
 =?utf-8?B?RGJyS0FDS0wxN01aZUZFeXlJMmJROERTMDExMkx3alh6VkVndzVORitKa3FB?=
 =?utf-8?B?eXdYemp5T05lWEN5NCt1ekVXRS9MYWpvdjBabjd4MDJ0eXNKdU0zek9Tejk5?=
 =?utf-8?B?SHoyVmhsbS9oN1Z4SGxzVXYxTmdQUkhpOGt5L29hYStjZ1JvQWFNVlg1cTlo?=
 =?utf-8?B?aDBNa3ZOYS9pNTRxckdBbzNpUkcxcTJqY01SWGZXbVM3bTFGbW9PdGdJN0V0?=
 =?utf-8?B?TUN5LytMeW90SzBXUXFSY0lJdmxCWEhYZ3J6cVNRdldwczJlKzB0Z2gyTEJk?=
 =?utf-8?B?RUwxN3NKS0VaOWFLKzEzbXJpSjJBaXk2VVNkOFFheG9jM3B5MjhJYitnWjhN?=
 =?utf-8?B?STJrWEVpd1ljand3U08yWjNxYVVxK1lRY1h5K2t6UTJYY3g0eForb28xUEFX?=
 =?utf-8?B?YTc4UzN4RlNoVGhsV3hMODNEUStKeFpBN3c3VVh2YkN2Q2ZPZEE1dzc0TkpX?=
 =?utf-8?B?RlNpckhJSXVRNUJWcWpGOXpGbkZ5N3d6YVFKVjVpV1RhSFdBa1hFUnUvZ0dn?=
 =?utf-8?B?WURtajBzNzR3NlFWYkVha29DTk9QNE41cmhFb2tXSm9MSjZXc2syV1BUVVgx?=
 =?utf-8?B?L0k1MWJKMUQ3SFk5UGszMXNVUjZ1UTc3Rm1FZUF1aUN5ZENqZ0xmNW1oR0dQ?=
 =?utf-8?B?dGxLT0M0WXJwZVBsKzVDa2h4MjJENWc1L1BuaEpQWEZnRkpsWE92cXFWZWRL?=
 =?utf-8?B?cHE3aS96UjRES1ZjNmF1YlBaNTB0WlhPa2t4TzEydWRLZTRFZC9qNzdySXg3?=
 =?utf-8?B?ZS84TURab2E1cXVTS3piSVdmUzN3SGx6bmxjOU50Zm40L2ZycDJHaWFUYXph?=
 =?utf-8?B?RkV0N2luT0FXUDk1a0p2TlY5bXJnN2JkR3NkcXFYMEhnSnVOcWhtMDdLL2Mr?=
 =?utf-8?B?Q0JGYXRnclZhRmcwQTRuRlVRUW9HUElBRXJ2czBUL0NsRkpEaEZ0MVJxbTNR?=
 =?utf-8?B?T2dHa0MyWUFxQ2s5cnFUVVVoMW9ncUQ3clY4OHR2V1E1TnQ1dGVzdlN4bUUy?=
 =?utf-8?B?WmlOb1krZnVBT3RrWWZDem9QRXN1TzZyTjdEdk5TZ0hOc2JtWnFUQ2hseUIv?=
 =?utf-8?B?YTAybmNPWWFCMWdpYy8vaHhWVXJ4akhkcmRQZWttbEVUcmNIbDk4dGp4UWNY?=
 =?utf-8?B?RGF2SWNNWlNZSjRUV3JpM1gvYzBtUHViT2hEQmlpcnN4cFRDV25jMGFwek04?=
 =?utf-8?B?bFM0K0lrSUVpQUxxdjloZ3Blb1UyTGUxeWhPSWpWTGE0V3JrZ0sreEtnczZ1?=
 =?utf-8?B?S2ZUeUM3cHJEQWVrOGJaRmROVUNKOFBNZUZSTkhuK2R6VW1qZ0tMVHNBdjJT?=
 =?utf-8?B?aWNlTm5YbDdlQzQ1T012SHRWN1g4RFBudU4yOFFsVkdKRnJlUTNGSmppQjZ2?=
 =?utf-8?B?VzhhYUVCYkpyYW9vTUR0UFdJR2tOczZpZU9teUdJdHYyMitDdmhoK1g5MmNm?=
 =?utf-8?B?Mnk0aWwwRENuckZwZmRtdi8vMGJ5RUxkd2lkUmZYSkNFUEtvMUVPZzBNVERT?=
 =?utf-8?B?Z2gzUFMrM0pRUS8yRjhSVGg5eHFmYy9XTDdJU0JmVlhtTEQvMTBMTFFRZWxh?=
 =?utf-8?B?ZFphdUNjYjJ3QXVHVVRTakp5c0FJVjI2aHJXbTYvdFpFMjRleEYyK1JVY3Jr?=
 =?utf-8?B?UWdGUmlvTmRMY3hzK2FNYnh6K3lnRCtvRE5vTzUySmVXWlIwazA1UlVnMUVN?=
 =?utf-8?B?SzlBMVhWY3dCREVKb3FqeXRtQ24xbEVMWnZQdUgrTjdmamtCcW9HUmZBMjl4?=
 =?utf-8?B?SVBlRFJKb0JsNVl4QTNrN2JtakpCaGRGa1FvRDZFaG1jYzM4SklXQnEvR0Nn?=
 =?utf-8?B?a2NiUC9ZcUFSbWd2REJMOGdMWUUxM2UrY0R4dDY3VkZkb1hlSmdnaHNsWWla?=
 =?utf-8?B?Lzd6SThCY29GNDgwSXRERU1qKzc1b3BwR2ZOSXE2OElxSkJieG9zS3ROMVF2?=
 =?utf-8?B?OG5PMGpMNEcxc3ovRWxxSlpDaElFV1dqOXdLUktsNFJ1eDRIbExtbmVIMlJU?=
 =?utf-8?B?TWdnU29pMnZUQVZhMGM2NHczcmsrbjZXR2tqaENpd3hBMGFhVHY4MExDc0ZF?=
 =?utf-8?Q?OuEs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fwSU22dOR+2YvY0VWweAEchNgYt6b9+7JQUR4gNBNv+rexACYdhWH1eslNOZ9aP9Ljf7Phyp7EFd1oZRlRQaeGs6fJim4JoBY7nAR5Gg1Vz58hRs/YzjrwmoMfbm+5JJv5BXYVEGUj0bBhDN8VWIDvA5lUUGOWJoAMAEUXAhhkgqHMmKx6pJ1bpSOlzf/3pJXS5e27Yp1hwJG5tEiPVXhIcOmnMC3sdcMb4caRRKkdybRYTyxxrQPCmSbW9jxjmIXDp1Ug35TeFGxptX8QNaIJSofNXcd9Zmp5AtlfFk2VCCt1CHtE1s0VhAhBUan95T2yiCc2mxip2oPRnErk02LdtJ5ArFJqUkWg5XTEU5d/FYscIb1Mxw9Rc+joxUS6r5IDigVuzwnd+tnqF29rKNHYFghdDlfCpQyvV0NIfk7Zu0Jylf7Pdj+JivQNk80S5gZSwticm2o6lebRlP3vBmWjdbYte+mAweOCZJr8ngktYkojsq0CurV0eCLXG3x3oq3BPrICLetoS9Barj2C6WXG8rjSqCziC+yewsdD3C/WzbBYCfFaUH9Mun756sa+inRqRcyT2fADXhbnusPR6BXNElsioXLPWbMiRXbS1yY1W3eo3XPRBLVJt3QnUfAkTUolAJ56FS3meZ2hKAQU2EVg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf36413-49b9-428d-a0e9-08dd7ccffdd9
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3187.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 10:18:11.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gtANx1a/OejfFH5ffkLEVF5k18UO1VMKow6RIFbiycFLWNQ3DgVVFh1QvKToSph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7313
X-BESS-ID: 1744798696-102085-15929-155211-1
X-BESS-VER: 2019.3_20250414.2256
X-BESS-Apparent-Source-IP: 104.47.70.46
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGpoZAVgZQ0NQy1cQgOTUpxd
	Q8zSIlydDAyNDcNCk1KdEwOdUiOSlFqTYWAEjhQ2tBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263927 [from 
	cloudscan20-22.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 4/15/2025 9:13 PM, Miklos Szeredi wrote:
> [You don't often get email from miklos@szeredi.hu. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, 15 Apr 2025 at 04:28, Guang Yuan Wu <gwu@ddn.com> wrote:
> 
>> I though about this ...
>> Actually, FUSE_I_SIZE_UNSTABLE can be set concurrently, by truncate and other flow, and if the bit is ONLY set from truncate case, we can trust attributes, but other flow may set it as well.
> 
> FUSE_I_SIZE_UNSTABLE is set with the inode lock held exclusive.  If
> this wasn't the case, the FUSE_I_SIZE_UNSTABLE state could become
> corrupted (i.e it doesn't nest).

Thanks.

for truncate, inode lock is acquired in do_truncate(). (not in i_op 
->setattr())

others (for example, fallocate), inode lock is acquired in f_op->fallocate()

So, I think FUSE_I_SIZE_UNSTABLE check can be removed from:

     if ((attr_version != 0 && fi->attr_version > attr_version) ||
         test_bit(REDFS_I_SIZE_UNSTABLE, &fi->state))
         /* Applying attributes, for example for fsnotify_change() */
         invalidate_attr = true;

> 
> Thanks,
> Miklos

Regards
Guang Yuan Wu


