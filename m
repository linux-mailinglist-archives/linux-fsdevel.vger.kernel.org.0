Return-Path: <linux-fsdevel+bounces-71217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76983CB9E27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 22:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C214300AB14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 21:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7430F2D5C9B;
	Fri, 12 Dec 2025 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F1D00qff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119B1FFC6D;
	Fri, 12 Dec 2025 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765574804; cv=fail; b=O05JuL2KKt001NJo3yYOyaLUWqZCIyr7dY+5dPUXVYcD1iAa86FcCve/SPMjPJFHqmy7yevbb43W6ZNzqwqaTRP7CNhVD690Oi3vw41rutudFgEOdmeittKNNEG+vYeoeSDag1IyjWTd/5arLRJskHdWUonleA3lToubSBekGiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765574804; c=relaxed/simple;
	bh=YsvYnyqqQRbN+1Be+g4+3gwE2QA8jD6CmAcyxC/wR2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qebY13Y3c1eSF/Athc6WKq9zdVkhg3ITgkvMzvOcJcUcDCBOruLxONtUZUS1+YM31L5Ef/kU9tZDX9m1lE+Fw/+j7a22fmAbPJZ6yuv0ZItEF6m7TD/HiS6c1nW1J/crUQlF8eT2hU3/claSy3fmAFECw2lY/EPs6jZIFxC4Q3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F1D00qff; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCH0gxs604221;
	Fri, 12 Dec 2025 13:26:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=QEXu78ivGjUTF4rKySiV2fb+Qiipp/oFTg0FVLoNHpU=; b=F1D00qffBPG8
	uhsrL/mRpmlezmm5/O7+JLt4TUcEro20v9vXM5y9UPV+xSPFjE8HuXnlv06rkl3P
	VdBiVDQY/9IJtzbCenZCtP3lYEza/FhZ0jQ4lZSHWWi1yUbSEuw4DVtR6nmIhO53
	G8xIO77cOXhXCQ9cTQf0ffRitFhYzi7czD5x8z7/XeoTvyCEBQFDAJiNHVpLN38X
	MF3gBHWozJqoj1FPwHIVrYirNikJe57GbCpEXgLJU2uRnhmVgsizW1SBmuEE71Od
	ohdTfr4t6jFc7jTxr2yrrFuY+wOKolyQyGNPw3qevTISJcEAl9lPq3l3fev55/I2
	dhed/4JvKA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4b0q2vt45w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 13:26:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1wJskJp9HUZNrNMkEFP+EZXqTltbzshUApE4riT3NJFEg+x5LqWzi1VAU0IFdcEiw5tiQ6Ime3lqRqY4IK5WXU5hkAcxBFUs0XyAMjxO8eMt3/ZN5nrpXsncM9Jq8C3/p5WGx27ca/81/v59yrc+sskBQk1f49sTH09hR1poiRc3CsfDQFFwCFUSaDQNoe2c6p0AQ4HS/pIM7eo8kqshjfp7A4XpKXM1ouIttEsebvcNDQm9N1R2zX6MkXFEgUjSPC0nkWeY+uaoSMgnIE9gi/ClmRz48o8oDjS/U7TXINisSXUnd+XL9G82O43K1xfkf3FQZN5K7mm+xRjrJbtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEXu78ivGjUTF4rKySiV2fb+Qiipp/oFTg0FVLoNHpU=;
 b=PDuVJ36tzpNnVxSpDLVyciceqqRel9TqakhTASq2h3cPW7a27lFB+M7G8g/LNR9QdRmqUwe03fBDtZ1K9KOjGihRWMEczbzLaZ27NXk0fBkRn0L+Mzp9nN3nkoxNayl4Y/3RZZ/bmXhihGvca7TaoPP+E5NDYwPuNwUdAOp8E4OTGjGe6RkN4I6H9fCD7QprhEFlZqcKgONZVAgmVnEXnHAdlISg0pIWXKTvQoqGJM9djlIh/g0ggM8OG5cL9NbaKZ4kRtGDsXfRxaDmjJFBpxrnNaFLTqQ7mxkYSfng8MRWj9nrQVsK1QT4U4gyUf59mcT6P+MAAyhARO31zINKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by DS0PR15MB6110.namprd15.prod.outlook.com (2603:10b6:8:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 21:26:33 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 21:26:33 +0000
Message-ID: <daf45c76-65e3-4db7-8b2f-a1fe0dee98ab@meta.com>
Date: Sat, 13 Dec 2025 06:26:21 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: make sure to fail try_to_unlazy() and try_to_unlazy()
 for LOOKUP_CACHED
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20251212121119.1577170-1-mjguzik@gmail.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20251212121119.1577170-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|DS0PR15MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 05169b4b-77e6-45ab-c65b-08de39c51f6a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHZXRm9BcSs3ajdzcjN1V29WN3h5bEl2c1E5YmJqWmpGY1NTTU5nK29QT3Vl?=
 =?utf-8?B?ZlZWcHVsYzJYaGxjK2VKZHB0K28rN1ZHNUlQckRjemc5WjkvbXJXTTBReGZk?=
 =?utf-8?B?OHQ3blhjQk1Pb3RpU2IrbXhacHdkNENQS011V2IvcFd1MHZwMlErNmEzTnZ5?=
 =?utf-8?B?TjhoT0JIbWkvRkZvNnIxT0t5bm1YU3VIWkI4YURLcTlJM2NrRE9GdkFtVXFB?=
 =?utf-8?B?N3F1SmxMSEl3c1ZtRVE4dEk1TGk3NlpvVHFFT21TdS9paWxURS83aWQ2bFhm?=
 =?utf-8?B?UDVodVRxbnVGbmluUytQUGJHd3ZrVGlpUGhZa3pIQmJaMWlFazl3b1ZzYitL?=
 =?utf-8?B?S2pxNjdUZ3VqZDZMUXBKT1FsQzBYYVRQQVBHdWEyZzQxTFhvTmxHZ2MrVXFO?=
 =?utf-8?B?bi8ySlRtRnI1cnI0NEhCZHBmcG5BNzFvWW9va21YYzI4ZkRCYnVnOTJOeUhn?=
 =?utf-8?B?elhMMjU2Z3hkWmtYZnBzMVhSaTlGcXhPd1k1SGR2b0FhSHpkNVFYTVkxZlVS?=
 =?utf-8?B?bTA0YUJTd2l6M0ZReFdGbXF3dEJmYlFLbDVObzZHcXFjcjBZaElHR1JlQnFE?=
 =?utf-8?B?ZGdjUVUyYjk3SktQRjdxc20zaVhvWGN0NXZCbkp0K0h4SjRQSGRKdUtNZ1FS?=
 =?utf-8?B?ZmhUNHNHa0U5ZEg5NnNpZGZQY2xOelhFUXcrdkllTjZ5TlhJcHIrTFpjSm1Q?=
 =?utf-8?B?Ym8yQ0FmelR1ODRTb3NjT29mWE45SnlJc3VER2ZwWWVBT1B6bnAyLzZrWHY2?=
 =?utf-8?B?WUdhVDNDRjA4ZjlXTDFlZE5rYk12U25Cbk9ZZkJOaUZOY3orbXpSUWFPT0hx?=
 =?utf-8?B?ZFNFU1FSSlU5Wm1jUmgvYUprQmJzRnYwcDMrSEdyVkM0RVBGVXdkd3hROUJv?=
 =?utf-8?B?UUhsdXpsTTlPUW5pRUNGaS90WWNxaTVFNVlsYm9LeThSUFZzUVhxTU9BcE9v?=
 =?utf-8?B?RDI0eENQb0hLWktVMFRKTGRMdCtHN0pRMHdteTlZc0tMNmlxSHJDTzNKWXBR?=
 =?utf-8?B?R0s0KytXRUN6dmgydEIwdkE5Q1RJWXg2TXRpY0xERzc3ckxKWEFoSUZJVGdS?=
 =?utf-8?B?VW5lUkZSY0c1ZEtYZlNlcVNiaklMc2llbktUdnIzeGlKTWFHRDhReEFVRTN4?=
 =?utf-8?B?UDltWFQxaE0yempPVXcvdmRVUUFoTkdBL2VoUzg1L2h2RkRuVXlCSDM0SjBI?=
 =?utf-8?B?THNpL0tkKzlvd0dWUWNqY1YzVXNDWnlUMnFUQ2l1d041Qkx4WnNobVlsYzVQ?=
 =?utf-8?B?dDN5RG5rcWhoRmh1L2lYK3hGVDhJQ3U3OUlDb0J3a3ovV1YwSGNtYjdSTGJT?=
 =?utf-8?B?L3AvN3diVEhpeHQvRUlHSnNmY0xRRVBidnlIekNDaStqQUFodXZiVTBBRnhy?=
 =?utf-8?B?a0g5blJjS1FzbXBJVC8venI4YW5hU29DdjBSQlhiWmVjaExTOU9jam1TbGtn?=
 =?utf-8?B?ZCtIVVZweERLTENLMWxnNDFsUElYbTFROTlIM3QxZVNBQWVzcit2Rnp1SHh4?=
 =?utf-8?B?UkcxZnFQdmhZSmEvbVNtNk9vU0xQRXpheG4rb0ZndEFwK0VsRFROTHcyMXg3?=
 =?utf-8?B?NzdrcHBoVzd0bytlNHFudnBZU0lKSXBmQm5LdGlESDA4R21PdFdmUjFMZWh6?=
 =?utf-8?B?cG02cldBSSt5dXNnWFBEaWpXZXl0Q25DaStFaFBxN3BXbjFvZjJIRGtKTWUz?=
 =?utf-8?B?d1BQRUo2SHRYTWlWN2d4Z0F3RkYzSWoyTjgvWUJjSVZseWQ5Qk5oa0NrQ2d5?=
 =?utf-8?B?RktxYnZWSUJoenZhYUl0eUpZTHc4VzlJSDVzbHFxRkNtcHhpQjBLY3pHTFVZ?=
 =?utf-8?B?RDhjaXFwVFlXU0h6VTNRMUQyTGE0d0gyUkdqbk9QVXFmUlE5clJqUXl3bnlD?=
 =?utf-8?B?emMxZlFuK01YR090YmJ4QmVJQXdib2E0M0svZGlYN0htREZpWUhtajVjSnhJ?=
 =?utf-8?Q?ILmwS6ylnpc7SiFKL8EaJKs5vOHGjlD0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THZmYzZJV0M5SUVNQ0NZMnZndmMzUXdoZkc5SHdjYTZsWUozWWEySlpqTjAw?=
 =?utf-8?B?L3N2YjNORHJ0ZExCaktZeTRsS29WbDRxOGVDeFRObWJ6VUtDR2dGQWxEblVs?=
 =?utf-8?B?K0x0dE1jMEd4V21qeXB1cXdlemJ1cHdPUWdoNDJGRnMxWE1ubGFRM2NSUUFW?=
 =?utf-8?B?c3MreTNvU09wZDVwTXpCVzVPZHJZUS9YeWd0NHZ2TnMweWNpKyszSzRCa0lj?=
 =?utf-8?B?ZmdtZElqS1p5YUFSRTEwcXpEd3JadGZVUVVrRjBWYmF6dy96dTRkMThBeHQ4?=
 =?utf-8?B?R1ZpTGN6R0YxUUdFSGRWaDFYcWh4dXBucHNuOHB1RjFLQjA4YWhONkY4N3E0?=
 =?utf-8?B?azdMQ2Nrc1hFZEhTT29vOVRUc2lqbHd4QnUxb25nR3d2NThRbytaa29HTThR?=
 =?utf-8?B?ZStvOGlaazVMSEJUcEpwLzhLZ0JubjdoRURLNmk5Z29Wc2VZdTRqWnI4TDgv?=
 =?utf-8?B?U2pXZWZTeG1VUGFoUDI3bmJGZ3lpOGg3ZWhHbXpjVVlHemNWZzlXMU9VMGR0?=
 =?utf-8?B?VURRSjRldmR1S1dQVGZjcjJjaG11cTA3OVpOZm56TXlEc0x2a0JOWTRsK3E1?=
 =?utf-8?B?a21Ed0NwZFZqaTQyWjQ1anhvS3h1SGREa1l2TktHTFpVd204RmdTSDJMTGRP?=
 =?utf-8?B?YWZnS2NCR1Jpb3l5aTdQaEcyQ2Z5N0RkTCtUZUFkMWNPN0dlc0J4TXhpVk56?=
 =?utf-8?B?ekNRdVhmL002bU1Yb051b3lscU00eS9VaU1rL1F2NGhnRzVOZzNMYVJQdEE2?=
 =?utf-8?B?SW5Da0I4SFZEVXg5NS9HTTdDaXFHeEZOd3dsMER6d1B4Z1pmbWNndTVjT1Vo?=
 =?utf-8?B?Vlk5bjZKait3K1FrMThVUVFTaC8zcW52RmE2V0QwMmZ5ZmpnK2ZOVkk4MHF4?=
 =?utf-8?B?ZTV1VnhyY2tza3VSbURib3hQOGM0R1ZRdFNtSGtBWVVyaXU0SWxLZWxqaks1?=
 =?utf-8?B?Z0dQR210UXkyekwveVU5cnUxRG9kdk1oeHQ4cVhnblVramt0YVpseXE3cTE0?=
 =?utf-8?B?QUdjck84TjExRjArWDNLSDdTN1NEQnFuUEc1cmVwaGpKTHFnd0Z6VGdLRDhI?=
 =?utf-8?B?Y2FNRmhBdjBxS2tKOUtxQlZETGFGM0lmU2J3VzBtdW8xSzZLZTZUWGEyelg3?=
 =?utf-8?B?aUJLMUFnTE1hMWx5SE5MOFhjTUtHNmVick15Y215dXI4SjNhQ2xNRytRU0Vn?=
 =?utf-8?B?TUdWd1poYnc1RVdRTXhnc1I4VXAxelhNRitoUVJmaUNyNGd0OXYzekVJN0Fn?=
 =?utf-8?B?YmJ2b1IyQ1llWFhqelJ1bjNvc1RQaUJLUFlkQkNqZVNhcjBiTnQzZVVPclV2?=
 =?utf-8?B?UUt5ei9JeHBIeWx2QnhVcWl5WWJSWWVMR09Qb1JIc0NvQUhrcjVlTHpjL2g3?=
 =?utf-8?B?K3ZuR3dGaFh5eGpkd3lET1UzOGZOUzZaREtUZnIyVThwZC9DRmxsNVk2aHRi?=
 =?utf-8?B?MnpTWm5OY1F5bVVVRThyRVhSM1hCSldKRjNQYWJzWW40dllnQ2d6QXc0VzhF?=
 =?utf-8?B?MGRBQXFBMXBjenVJLzNuWjIxYzFoU09xNWpGeGVZNHhEZWtReWFlK2ovck5U?=
 =?utf-8?B?aHIzK2JSMXh4OUhXTXlxaXdzL3BxQ2dZZVJQbGVaUjhpQ0l1WTdETzB1NTAy?=
 =?utf-8?B?aHpSUEZCSnNLRlpKYmxCaGRxQ3JCc3JPRnhPNzVoZTlnc0x0R2tNOXBxcHht?=
 =?utf-8?B?empTSDJlV0tLU0JiUjREVnQ0c0Y2aVo3clVxSnV6QjF6bzlzNFFsSytiK3ZV?=
 =?utf-8?B?ZEFZTDRkS2ZxSkI5d0VpZUpKM2FFdVRZeDJyYk5MU21jYTdSaHl0TUVlV2Q4?=
 =?utf-8?B?SDVkRzhsRmpqOUFVcTJZWldCOVFWM25SV3hDT1dPVDh1N1NqTWZCL3QwMGVD?=
 =?utf-8?B?SSsxU1dGV0YvRHNlVmVVa1ZLVTZwaWpzcFJDT2dvUEhZdFdNbG4yYjk4SWd0?=
 =?utf-8?B?T2VDQmxDU2FVTy9EeGRBUld6eitzUnBqSWZDbERDWVh3OE9LUkF5YWdUVjha?=
 =?utf-8?B?cnpVSTF6NFFwWDh5UXF1Ty9jMG41VXEwT0lxVkZpOUNnSzl2M0VqQlFQNjNB?=
 =?utf-8?B?TGJOWVN5aDdZdDNqZll3Y2V4ckN1d3NRSlhuMWRmWlExM3hkT1VjRmptWWkx?=
 =?utf-8?Q?OuWA=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05169b4b-77e6-45ab-c65b-08de39c51f6a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 21:26:33.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00P3at+enoJyChA5rRu9rbhTmc64CFhIPqwywSt4FgggutG4gHqsUT/DBJQyB8eN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDE3MiBTYWx0ZWRfX4+SAIjzlPxuk
 tFwwylQ+jyO2gXHibWje2AEGdAkClPcgk3UwzdkfWK+auEGvLUek8AQ8fDStGjuN69f8JgfBela
 +DU5IXn9kmJ/9a2f0ySKDxsOJUIM5CPfOJDrY2EGEQADi8qW52uWX+l+AtZ2XbyVXKsN0/YERgd
 NyGusvuPL9PzenJyCmmBoet4ay5XchlrAYOYJaFXNGViFezDWaTIQijX6Yk6IvLeh2WlT9yMIFn
 CxgwBkP3Up5Ac6FQj87hgBgrex3JGnqttNsTLhKsH3Ji2n7gLnZKLAF0yvITwPSEXhKNyWes8n9
 pgQMKKgNo7m+C3bUvj4r76ooaQTltUV1WeIWXzscRe+l5Ctzf9CUqKo2X7WYWjFaB8X73cSScRQ
 EgtKvv6T6Qa1eHGFleIscbL2zsex+A==
X-Proofpoint-ORIG-GUID: x0l8hOMxBuxBU1p8at4a1gmIjJ6_mQ2S
X-Proofpoint-GUID: x0l8hOMxBuxBU1p8at4a1gmIjJ6_mQ2S
X-Authority-Analysis: v=2.4 cv=e/MLiKp/ c=1 sm=1 tr=0 ts=693c888b cx=c_pps
 a=R7TnPQtMnhj+722GCxzAsw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=5_fWomeBUgpP5f-lCqMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_06,2025-12-11_01,2025-10-01_01

On 12/12/25 7:11 AM, Mateusz Guzik wrote:
> Otherwise the slowpath can be taken by the caller, defeating the flag.
> 
> This regressed after calls to legitimize_links() started being
> conditionally elided and stems from the routine always failing
> after seeing the flag, regardless if there were any links.
> 
> In order to address both the bug and the weird semantics make it illegal
> to call legitimize_links() with LOOKUP_CACHED and handle the problem at
> the two callsites.
> 
> While here another tiny tidyp: ->depth = 0 can be moved into
> drop_links().
> 
AI flagged that last ->depth = 0 in drop_links().  I made it list
out the ways it thinks this can happen to make it easier to
call BS if it's wrong, but I think you can judge this a lot faster
than me:

> diff --git a/fs/namei.c b/fs/namei.c
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -774,6 +774,7 @@ static void drop_links(struct nameidata *nd)
>  		do_delayed_call(&last->done);
>  		clear_delayed_call(&last->done);
>  	}
> +	nd->depth = 0;
>  }
>
>  static void leave_rcu(struct nameidata *nd)
> @@ -799,7 +800,7 @@ static void terminate_walk(struct nameidata *nd)
>  	} else {
>  		leave_rcu(nd);
>  	}
> -	nd->depth = 0;
> +	VFS_BUG_ON(nd->depth);
>  	nd->path.mnt = NULL;
>  	nd->path.dentry = NULL;
>  }

Moving nd->depth = 0 into drop_links() appears to break terminate_walk()
in non-RCU mode. The function reads:

    static void terminate_walk(struct nameidata *nd)
    {
        if (unlikely(nd->depth))
            drop_links(nd);              // <-- now sets nd->depth = 0
        if (!(nd->flags & LOOKUP_RCU)) {
            int i;
            path_put(&nd->path);
            for (i = 0; i < nd->depth; i++)   // <-- nd->depth is 0 here
                path_put(&nd->stack[i].link); // <-- loop never executes
            ...
        }
        ...
    }

When terminate_walk() is called in non-RCU mode with nd->depth > 0 (after
following symlinks), the path_put() loop for nd->stack[i].link will run
zero iterations because drop_links() has already zeroed nd->depth. Can
this leak references on the symlink paths stored in nd->stack[]?

Concrete paths where this can occur:

1. Retry after RCU-walk failure (non-RCU from the start):

   filename_lookup()
     -> path_lookupat(&nd, flags | LOOKUP_RCU, path)
     -> returns -ECHILD
     -> path_lookupat(&nd, flags, path)   // retry WITHOUT LOOKUP_RCU
         -> path_init() in non-RCU mode
         -> link_path_walk() follows symlinks
             -> pick_link() calls mntget() and increments nd->depth
         -> terminate_walk()              // nd->depth > 0, refs held

2. Mid-walk transition via try_to_unlazy():

   path_lookupat() in RCU mode
     -> link_path_walk() follows symlinks, nd->depth > 0
         -> pick_link()
             -> atime_needs_update() returns true
             -> try_to_unlazy()
                 -> legitimize_links() takes refs on nd->stack[].link
                 -> leave_rcu() clears LOOKUP_RCU
     -> error occurs later
     -> terminate_walk()                  // nd->depth > 0, refs held

3. Transition via complete_walk():

   path_lookupat() in RCU mode
     -> link_path_walk() follows symlinks, nd->depth > 0
     -> complete_walk()
         -> try_to_unlazy()
             -> legitimize_links() takes refs
             -> leave_rcu()
     -> later check fails (e.g., -ENOTDIR)
     -> terminate_walk()                  // nd->depth > 0, refs held

In all these paths, nd->stack[i].link holds references that should be
released by the path_put() loop in terminate_walk(), but the loop runs
zero iterations because drop_links() has already zeroed nd->depth.

[ ... ]

-chris

