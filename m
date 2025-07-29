Return-Path: <linux-fsdevel+bounces-56224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA79B14732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 06:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1C04E407B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 04:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A8022D4C3;
	Tue, 29 Jul 2025 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kvpP3Tn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013036.outbound.protection.outlook.com [52.101.127.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0972218858;
	Tue, 29 Jul 2025 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753762965; cv=fail; b=f5eXMZEwdjnQuDtm0DrIRC+Ur0sGr8Gxnry2OUWtEaMpDnkI1CcBdmBc4ghid2UabSuU++BfJnwoHp5cM04tYkXCs7L1PfPjSE02OB8aZC9AcdNPnKT47PWImVDwbSaTqDPEj83XLiOfReE5fjNk67vvwJ6TFz1EhOUdfDbJDzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753762965; c=relaxed/simple;
	bh=UGJ7PXdOX/AD0QWji7URgP1D1xn18x/Qqpz+cD0mWjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gfE42cvZqSkIy7Q5mdvs5ZTl1BUo8x5VQjdhK+gXUh8zOa1rkoQe7oAmNemcU35NdLKgBMFyKPgUjMpzrcBCzQVZ6Zws9+6W7QpxhI9Y+NWkYbxwI5X7THCNK3kP1GntgRniOBmTto+oppcCDmBSTgA8EKFtHxh+ORcMJeGtbnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kvpP3Tn0; arc=fail smtp.client-ip=52.101.127.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYydWxg57lnWF6umhwrMoITci/da+QIgRNtxqc8egtcQayRZB8YMcAc5Rh1DPUizRapocwjbefiDdlnlhqujGEnJRC/DN7hl29S3/HpZFvpI7FdrT5uEoIKh6ckE1731b+rTHjS3Vyg9bwvf/HDQlxFVqZScEW3oKRjjAWAuEEuZdjNS1GyvHS++AblCwNN0rTLH5rQYO6eRD2nwcK7jzFM/st+QWLlN+34+5SMHaj8c+q5UT8Wd8gEZbcsEcT3crRWtAW2Xngnap+4fEsT1sROeHV7Qbjq20mfJdPMPqvpRBKopXMFTkllkzcF3zi4MPqSJ8wHOCAtWD0r7XA7g7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mfu25BdACvBEfpz4JzlHxLyvuuYOPBk9e9FwF8aX++E=;
 b=l4NotJ1OHTOgWhd91+hWkco58M4xtgC0J9bUCo3EbkB0uj4Hw4v7hDV54ADyphfJt46LKZqsnZWeoPsMwsUdtChhjwlOPj3ttcNe9RDnFalr2tnrqOsmLCnEUfJckgTrAprLDZXWxq70fEsxGfV8J5PNGNylbWDmou0NGGal1beAYTRAgh34yO6eN0sZ5OywX7HidZImglXRDT8eb1fcXsIdPoHT84E7RRowfgx2pLZkGPf5Db1KnYxQIGuLxEGyoh9SkNT14l6iVPj4zS6k3iOCVVttf3qFlNdFvoq7I5jspgtt6EFO2OoRXdqf1xWw4//Xg/uNsyXF6gj+DoJSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mfu25BdACvBEfpz4JzlHxLyvuuYOPBk9e9FwF8aX++E=;
 b=kvpP3Tn0luFUWgnJhygq0RYhs0HiUz6lLCGshBJ9j4AjaTN5OLLv3eO4TyxtoHUhMj/0HBWEVHG4b1XOPmPUzfRrjVQgQwd/gsKUfPsYDgWvFCezXIMMzK3NFboRvoL/8CnKYyVebPCgNJvgOcZkcrTGCkv1ri+JF0Ok4ayEMqWztlhYJ3Jg+qSybg+0gVGlHVpZeFbYJLmIF66784gFrcFzAT8UCt5VPwcWxj0BVDba2TbDdXZ9uufaZuZy+TNZM048xi1WhQOrnWWpB6Yk66pnOAwq6oXY6UJIh4lBuW1VshLnLpgK0/jd5QWPKDF95qCWU9hXhJcXwWIPTNw8dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 by TY0PR06MB5401.apcprd06.prod.outlook.com (2603:1096:400:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 04:22:38 +0000
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768]) by TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768%6]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 04:22:38 +0000
Message-ID: <892f97f8-f07a-41d8-90da-1a776dd69ab9@vivo.com>
Date: Tue, 29 Jul 2025 12:22:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs: Prevent spurious wakeups with TASK_FREEZABLE
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20250725030341.520-1-daijunbing@vivo.com>
 <vgi3yig4zi3t54pfqdbsspge4wa3n5mucx5antazw7at36c4ja@wi7gtgu7itsu>
From: daijunbing <daijunbing@vivo.com>
In-Reply-To: <vgi3yig4zi3t54pfqdbsspge4wa3n5mucx5antazw7at36c4ja@wi7gtgu7itsu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To TYSPR06MB6921.apcprd06.prod.outlook.com
 (2603:1096:400:468::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB6921:EE_|TY0PR06MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff07d39-0986-4805-429b-08ddce578cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitON2lCVWFPNjBtdThCN0Y0NGp2ZHo5TS9vMzNpK3NSZWxBTXBEc01hWE9L?=
 =?utf-8?B?MVBFaE9FSVhvZXR4R2JtKzZRL000RTN1Z29OeHB2MmlwMW1MVzRMS2JLK3dw?=
 =?utf-8?B?cnJrdmE2WGdwUUZhSGw1VlZrOE9oeHVPNDZkTktXU2tDSUtlZG5UeTdCaHhk?=
 =?utf-8?B?Y2JucG5RTzVCTWFGR0RLQXI5eWtFYU1hc0NORjJxVWp5S0x1bHRVZENLNGU3?=
 =?utf-8?B?UkU1YnMyVGkzQkdLVjFlUTd6ODdLbzc2LzViQ3dTRUJnWkFJOHFGeFJMQ2Fl?=
 =?utf-8?B?OVJnZmdJRDdSMzZDUmpGY1VTV3hYeGNHSmJJUmJOMjVrdml2RWVHd0FFem10?=
 =?utf-8?B?cyt1VDdadUoyczhZd25saWFHM3FBMmp4YjBQZTJDbzhxZmk5SXM5dmNIcjd5?=
 =?utf-8?B?S3N4Sm9JUHRrR0hoWjRqL3podkppaEpnNjRRdEcydXNzUlpEbmhPRHB5a3BJ?=
 =?utf-8?B?QU8rSFFmQ21wRko3TlQyVS9lV0ZZUUJ2NGpLZG15UTBnUFpqUjREY1FIRW9B?=
 =?utf-8?B?V2UrK1BqNDJielVuVXNKT0pkNnZBZWZibGJkOUtSZ3p2K21vY2ZZYUYxZjhu?=
 =?utf-8?B?QS84WFpOWiszKzBheGZZV3JQRHBFQkN5SkI5SDUvZFZNZzZ2ZGZvYVlwdEox?=
 =?utf-8?B?SXVNdmxyUXJKYkpGTVUrb1N4ajhCOUJUWlErMjdxb3RVbDc5ODE4Ykc1SFpG?=
 =?utf-8?B?Tm1YSXc5OCtWU3FQZldEVVlCaSt2VURiZnVwS3U3MklsU3dQRUlYWVM3ZmtS?=
 =?utf-8?B?SGJDVHVhamp3dTZmUVR4NFVsUnJ0SXZqNGNRTTQ0aTUrdzlXTFF2cHlEUlZP?=
 =?utf-8?B?TjQzV015OXBmcC9JUy9GeENhT0JhYU05azdqdnkzc25FMGJJaFNiNjE2V0xX?=
 =?utf-8?B?d1F3NmJoWks4SzFxbldnZGhqT2s1NlY1ZkxmRXpYYXp2NnZGTkl3bXRiVkdv?=
 =?utf-8?B?Z3NML0FoeUxqdVIvSW5jSVRkV3B4cjdtYzFmSWRWQnJTWTFLM005Sk9QOWlL?=
 =?utf-8?B?MUcxMjJTaHVGc1ZacUY1SCszSS9UUk4ySXF4RzlFejMwcWNjZmNnbXlkNlNv?=
 =?utf-8?B?ZW1hZU5BdFZTYjNZWkh0R3h3L211T0pZcENtQjY2dzE1Ylk0dE00WmYyZHM0?=
 =?utf-8?B?b1lVOENHSjRFVG5KTVdXdEx1NVB1N3NKWnFNLzNJMTBxaVJ6OE5CYitMZkZk?=
 =?utf-8?B?dng0VlJrM1lrV2x2SHF1NE00a3lrWGxYQ3pyR0IvdnMwazBVd2JXMUx0b2ha?=
 =?utf-8?B?M0I1dlpEdGZUZHpraisrSWM1eFVEaGtWelR3UnhzWFNLQU1LRjQ4MlBoNFZn?=
 =?utf-8?B?R1VLK2JJVGF4UVYrNUhpdWVSUVUwblVIZGtyYTBsWURqV24vUE0rekFOSXJ1?=
 =?utf-8?B?bGVyTmxKZXlvVGcvNExaVm5mQW9XMisxa0xOcUpsc1pFckNUTWFRTFBrYUpC?=
 =?utf-8?B?UFJkNm85MXZJMkxTaUxjVjVZM0J6Vkx2bEszcUIxcGFNanVQa1hJZ1BJK3JO?=
 =?utf-8?B?bUdud00wTXh6VkNhYXYrUXZmMXBqSTFnMlVsRnM3bngzWDBBSkpoU1psVmFy?=
 =?utf-8?B?Vlg3TE9uZ3o5WjE3b3plZ0ZKK3QxaDBvbi8vMDVYL3p2Nnl0YlRPYzlmREw0?=
 =?utf-8?B?cS93Z2c0YUU5VTdUS003UnVSSm5lWUZCKzM2VjdmckEzVHp0dWtFV0gyR0E4?=
 =?utf-8?B?Rlh5ZU9EamJxY2dHajY2TGlLZVcxZ0cwSnlmWlN4dnFuYnRLY3Y2WnRtN0Rs?=
 =?utf-8?B?OGh4cGdjTGR2YkVEbWtWbjQyS0RqTFdPb3g2ZnZkMjE3WHpOSjdqNngwMVpF?=
 =?utf-8?B?VDF1eENaeHNMeG05T1JYWVkvZHlVYk9aTjZvNExLMnVWc1I4TEoxcm9oZTVQ?=
 =?utf-8?B?SjlsSjkyQXpWcXV4OXJWN1JJcHZUeEczSFE4WVczQkZBV0ovRTNZRFpGdXlS?=
 =?utf-8?Q?ttQ8fRiQ6Aw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6921.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHNHTWJ5V2lWaDJCZE0vYmV2WStlUE9IWU9qMWx2ZGQ5c214bmRBSVZNUVVB?=
 =?utf-8?B?MWV4V1lTd0pVY1JGMUluamFlUWZvaVBjWERmUHpDbzc1b29BOGZuTmdSRGRv?=
 =?utf-8?B?SXIzNE9MTmRzcmpNNmtHOGZmZldYdHZ0UEhGWUFaU3RURWlsRmllOVdJdlha?=
 =?utf-8?B?VEt4Zk1DZHVORTJ1eVNyb2JyeWk1KzRpVnhyWkgycGNHekp0U2pnZVZGcnha?=
 =?utf-8?B?Mm9qcG12cVBtek9CVHUydEEya1lsUFFRY1VkMWZwc0ZwWmJFNW1sRVIrNWdI?=
 =?utf-8?B?QUYwYUZ1ZTJQdnFFVy9EaldQUXBNWUR5WG1PcklJYmtjUm9Dc3BrVUt3Mzcy?=
 =?utf-8?B?UlJqam1CbDY4eHI0TjNsM1pSKzJlcVNpMVNONG9lcTRsaDFncjdHK1c5UnRs?=
 =?utf-8?B?STNTZndIS2tWMURrd2VyaG1YTWhQblFPVm1OSmh5elJUMXV0RXR1VEc3Q1Q5?=
 =?utf-8?B?WU5PcWhDVmNWQUVmUTRGeW9uTFRGK1R2dUV2Mnhmd1M4dCtlL1ZEMG81ZlFs?=
 =?utf-8?B?YmVYZTZ5ZGdtdXRndVFLZEVZaWQwcmU4YWcxQ2ltNVVMaVN4ZVptUXJ4N3RV?=
 =?utf-8?B?YmhaRTVvRVRHbEE2ekZCT01VeGQ1bFNFVkphSTZqNzMyQUNtdzQxZ0xZOXJE?=
 =?utf-8?B?bHY5N2FEKzZhejVsc3Q1c0p6UjR4aUtQSXVQK05xd284UjVtY3V0NER0NTQ0?=
 =?utf-8?B?bk4vVWpPdW8xMDQ2QjhndVdJMml5WmYrbE1lSFhkS29NbkYzdEVLWkVXMDVp?=
 =?utf-8?B?MXhRblVVcEhMVUVMSG94YVFqb3lmcHllNXlhN1VSYmtuMlhXdGhTdWFueklt?=
 =?utf-8?B?YXV2Q3pvOWVaMVd3eitmZ1hJZlJFRElHbTAxVFFpcXdYYnk5R0I4RUlLNElC?=
 =?utf-8?B?UDd4TWhVWHRVOERRZzhmd2UyRmhwQy9RRkorVkpIUERudUh3UnpnamtCN0ZI?=
 =?utf-8?B?TVBmZjFHZk4vWkUyTHd2S2EwKzhrekY5RFRxVkFDTjZWVG1DSXNQc1BHeUlh?=
 =?utf-8?B?ci9jUW5kU1RXVzdLNm9CYkZIQkVNRDdIVEhMREVYM0NNN0V0TXJydy9hczM3?=
 =?utf-8?B?SWgrMWxkQ0pjTlMzMFJ5dlhtWkcybmZvTkxYOXN3NEJqbVplQXNmeENHdG5r?=
 =?utf-8?B?U2NkSTEzMWdoSUp0VzhGUUprRFVHNy9ZVWowQWZSWlVIRFBFQldNT3ZCOTRS?=
 =?utf-8?B?bDQzRFVDQjFyM2g5dFhmZlBsM00yaUhZUGM3Rjg3VnBLU3pnVXhMZFh2ZDBu?=
 =?utf-8?B?REVVSU5ZY29WWTJBbUxJd1Z1SzY0SUZIeHdVZlpSNzNuZnNPV2FoaVdRdHZX?=
 =?utf-8?B?NE5QcStleWJHbmMvR0x3aEJtaFlGV0hvc3AyeUJvZ3dJNVZYMkRXR0R1NFpi?=
 =?utf-8?B?U3plNWdTZ2NUMWIzQWNZdHlheHZwUmhSNkhoUmFPeVI5TlU3Mk5BcWRsQ0hs?=
 =?utf-8?B?U25yUnJhK3h4bHVEbXZ6T0RVQ005MXpYKzVJMkFDbTlIbk1OcEVJc1B2YzYr?=
 =?utf-8?B?SXc2WXB1Y3VBYXRsYVBuYjEwa2l3TzVHWlJ4QkNPOFNVOHpQOHdoYUN5Q01Q?=
 =?utf-8?B?ZGdnUlkrVElLV1hFZHpjYk9oRmF2elFsWHFoaFhqb0ZsNHFEbzBsT0xxQWli?=
 =?utf-8?B?dGJzWXA2UU1lSG1EbkJOTUhsL0tUS1JpTmw0VjA3ck1MTVRrWTNSSmR0ajN4?=
 =?utf-8?B?VEZRY0NlMFl0ZzVqenN0T2syblNpd1RRd3JGUVFHdmlqZWlGNFhIODYvZWJU?=
 =?utf-8?B?cUQ1WVFLNFQ0Snh4M1dTb3k1SFp5d1VPUktGSTZQYXBJVEg1dVJJd0NGVlRZ?=
 =?utf-8?B?aXRRT1pYVHhrZ1NHN2tBT3VnSTB2U05PWEg1NFVVL2tRQ0JicWdOVm9uWGZk?=
 =?utf-8?B?VkZvTnV6N09uN1ZFajRtQ0hmcERPdjYrM01yVEE0dUtHTVRmTjlpd0ZCL0FB?=
 =?utf-8?B?SXMwdURJV3NtamJxQnpYd0ZwMWgvWnNLaGtuUWFPSSsxNU81ZTVvWFR5a0tU?=
 =?utf-8?B?L1U5Z2oxWlJQRzZBVzM5RWVydTE5eVVNNTNicmtoNUVkTXBtbG82QjIwQ3ZG?=
 =?utf-8?B?bkZLd3dUbi9oa0ZNTjI4ZFZrNHExTW9JcHV3Ylpib09XazNVdW96Qnl0ek5Q?=
 =?utf-8?Q?3sDXasInLrN9ezC9Epw5GPQ9d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff07d39-0986-4805-429b-08ddce578cb9
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6921.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 04:22:37.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sX9EEKw8GvFoRHrUx/odx3KdzA1Q8RTcuI/rvh7jpmFNQHi11CCpmuIjNJ0zW1iPZW2LPU0JPA4ifmmbajigg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5401

Thank you for the suggestion. I will split the patches per modification 
site and provide detailed changelogs for each submission

在 2025/7/29 5:41, Jan Kara 写道:
> On Fri 25-07-25 11:03:39, Dai Junbing wrote:
>> From: junbing dai <daijunbing@vivo.com>
>>
>> During system suspend, processes in TASK_INTERRUPTIBLE state get
>> forcibly awakened. By applying TASK_FREEZABLE flag, we prevent these
>> unnecessary wakeups and reduce suspend/resume overhead
>>
>> Signed-off-by: junbing dai <daijunbing@vivo.com>
> 
> Thanks for the patch but I have two: This is actually less obvious than you
> make it sound because if we are holding other locks when going to
> interruptible sleep then the behavior of TASK_FREEZABLE vs
> TASK_INTERRUPTIBLE is different (you'd suspend the task while holding those
> locks). So at each place you need to make sure no other locks are held -
> this belongs to the changelog.
> 
> And because these changes are not obvious, it is good to separate them per
> site or perhaps per subsystem so that changelogs can be appropriate and
> also so that maintainers can review them properly.
> 
> 								Honza
> 
>> ---
>>   fs/eventpoll.c    | 2 +-
>>   fs/fuse/dev.c     | 2 +-
>>   fs/jbd2/journal.c | 2 +-
>>   fs/pipe.c         | 4 ++--
>>   fs/select.c       | 4 ++--
>>   5 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index 0fbf5dfedb24..6020575bdbab 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
>> @@ -2094,7 +2094,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>>   		 * the same lock on wakeup ep_poll_callback() side, so it
>>   		 * is safe to avoid an explicit barrier.
>>   		 */
>> -		__set_current_state(TASK_INTERRUPTIBLE);
>> +		__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>>   
>>   		/*
>>   		 * Do the final check under the lock. ep_start/done_scan()
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index e80cd8f2c049..b3dbd113e2e2 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1418,7 +1418,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>>   
>>   		if (file->f_flags & O_NONBLOCK)
>>   			return -EAGAIN;
>> -		err = wait_event_interruptible_exclusive(fiq->waitq,
>> +		err = wait_event_freezable_exclusive(fiq->waitq,
>>   				!fiq->connected || request_pending(fiq));
>>   		if (err)
>>   			return err;
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index d480b94117cd..a6ca1468ccfe 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -222,7 +222,7 @@ static int kjournald2(void *arg)
>>   		DEFINE_WAIT(wait);
>>   
>>   		prepare_to_wait(&journal->j_wait_commit, &wait,
>> -				TASK_INTERRUPTIBLE);
>> +				TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>>   		transaction = journal->j_running_transaction;
>>   		if (transaction == NULL ||
>>   		    time_before(jiffies, transaction->t_expires)) {
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index 45077c37bad1..a0e624fc734c 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -385,7 +385,7 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
>>   		 * since we've done any required wakeups and there's no need
>>   		 * to mark anything accessed. And we've dropped the lock.
>>   		 */
>> -		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
>> +		if (wait_event_freezable_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
>>   			return -ERESTARTSYS;
>>   
>>   		wake_next_reader = true;
>> @@ -1098,7 +1098,7 @@ static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
>>   	int cur = *cnt;
>>   
>>   	while (cur == *cnt) {
>> -		prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE);
>> +		prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>>   		pipe_unlock(pipe);
>>   		schedule();
>>   		finish_wait(&pipe->rd_wait, &rdwait);
>> diff --git a/fs/select.c b/fs/select.c
>> index 9fb650d03d52..0903a08b8067 100644
>> --- a/fs/select.c
>> +++ b/fs/select.c
>> @@ -600,7 +600,7 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
>>   			to = &expire;
>>   		}
>>   
>> -		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
>> +		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE|TASK_FREEZABLE,
>>   					   to, slack))
>>   			timed_out = 1;
>>   	}
>> @@ -955,7 +955,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
>>   			to = &expire;
>>   		}
>>   
>> -		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
>> +		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE|TASK_FREEZABLE, to, slack))
>>   			timed_out = 1;
>>   	}
>>   	return count;
>> -- 
>> 2.25.1
>>


