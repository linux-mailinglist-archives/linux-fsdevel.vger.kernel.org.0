Return-Path: <linux-fsdevel+bounces-75781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL5MLLFGemkp5AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:26:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26872A6D53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED419301A170
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870433123B;
	Wed, 28 Jan 2026 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GaMYfLff";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b6KFpwS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65130E820;
	Wed, 28 Jan 2026 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621160; cv=fail; b=K03WlH01eUXsCxBz/kFAxo8vEMb7R5kBsvNaiWb4aemBsyHwdQY6RHw3tNB/akqZZpOZ9wqH4fIxJkNRDF1atgTYAXVX+kCxxWQ+4Go7GFxPK72YPiVsTSTXiYz5P3KMbaB1p5n6RvW1VJCATmv+7R8Vr0cX4Vf7YSs+r75Micc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621160; c=relaxed/simple;
	bh=WmnwDrx3JzGc1NZ5NmhwI5Vv5IQprnnkznUBjbxVRc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gl7RZ7kg+aSWhJf0jXvvt+TcwURAe6e9xCSROE5seZ4isQ9fa+iyd7FYh4sTVKCTL/QyoS3sAksVU0SomDvxeMDPpjb4tETNLiZau5zjRvujSYlBQSEjsfV8e23MgmTDSE2YXTGsR8cOJ+VN4ynPZ4ERKIQFBrNtPrmnxiPD1HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GaMYfLff; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b6KFpwS4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SGetwt837976;
	Wed, 28 Jan 2026 17:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TFbsI9S0QKYY4zbS0/MsHyqf5Ewcwtm4xhTeuLramng=; b=
	GaMYfLff1gAAAk7rPYc6X1a0i0tid4zxEkhEFoJbXid2l6/8tZ51RWsZV6EIWgtO
	906ma0/PqNINhxrWCYC4hN6uAd9nmpQ22Wh34pMb/iT26QkbV73VasxtSf3nRruc
	rv0eYYSqm5sILB+DszFv0mJevq3YUHoQ9MB6aVQbkjl1iUxutbmHADEa3hsVYvCl
	3DnSafU/PYFkc0H8kPsVN4lXrysrutR1gQhrNdVn3TDZdCw9y0MxZnbosHVkiMiI
	hHy7l6Zlj2ftJyzhq9jsS0rGOEBmshJGsrpyl8UCGQxoViYkWw+QioWOAOWC019e
	Pkf+C7fJZPrsk4kOZqybGw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by378hsu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 17:25:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60SGWFmR036073;
	Wed, 28 Jan 2026 17:25:42 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhqg2wf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 17:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVtbKD5TQ8OxQE4CPnxdLCkkvqPCBrDAHoQag0FHINDKeL1xiCB1X2zihkZ3UCu0WYFeil0TYU2vBzQ174ekDptWV5/bZ2hn9sdbu291uRavquu8Jtqk6PDzJjPILJ0NqIIydzpk7obsRG3kf0z+fNVX4W8hmmkLHk0W131CeTKn8Q/tJfa9kSfUi+dbPgyELoiwblMLCwtWdlfgwAK6NA+XeEZQHZMMi9WA60mWB++MPV5n/RrSiz9BNipDWg5BfZWfyp1tbLUozKsvWGIsC994WsBpjXtCGvFmzUwuzTldRMuO3/h5TBfouaz7jTKNl9ykR5nFFD+rYyxNHsOEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFbsI9S0QKYY4zbS0/MsHyqf5Ewcwtm4xhTeuLramng=;
 b=yoXmxzdqZWl1oh6QqciyhbrTcmcHr2Rgt79W04GHRK4SJt0eqAPmb+wz6qjAqA59KsUDxyF7te3mMarFTqSUkJzWkYqvXpvkn28KUIC6j5PfM6PHQUTqmQ1HvT4QXe/G3Rj3MbVjTBqZ5hAY9dlzMCFjMdN/XwqU4POLefL2fUKNxlDSJ/iLBOb5LiGPNg2LaLB9QQGFMCnNxxoIWFFhep2F7cxvqKHidpuUE/yv7+ftpxEbaOsEJ8QLXg3v7ijbw16kS8WMLvQFnmLAOxFtTNudNhvadV3u0pxYsKPE3azABLmQVjOF72Isy6UyJlGfotATGCB9Lubye0movHYEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFbsI9S0QKYY4zbS0/MsHyqf5Ewcwtm4xhTeuLramng=;
 b=b6KFpwS4qEhTnUcNS/8gxr1K6FQcAcBLAPrvvhswVaaXZ7rl/Ows/c5EdfoJsZZebmCUMh8l0LvZvLJ+D3y7GFfNB7x6wEtbcj2hTJO78nV0IeEGZx41e/YubDu4hUzBPWC3QsZp4ESJoMsblHQbZ0D69MKt46X8QA896Uy5eks=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SA2PR10MB4572.namprd10.prod.outlook.com (2603:10b6:806:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Wed, 28 Jan
 2026 17:25:38 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 17:25:38 +0000
Message-ID: <c566182b-2256-45a0-844e-a7c8614ec895@oracle.com>
Date: Wed, 28 Jan 2026 09:25:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260127005013.552805-1-dai.ngo@oracle.com>
 <5d2288d77498582f78152bdb411222930a7e5978.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <5d2288d77498582f78152bdb411222930a7e5978.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:510:325::29) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SA2PR10MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: 277999e7-a3df-4ab7-4707-08de5e9240b4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K1hoaTZQTGN2aWJJdDJVR3UzRFRYTEhUMFdtNENmL0pZQkh3SDVYTlV1UGxG?=
 =?utf-8?B?TnluTGV3Rm5DbVluQnNhWXl0RVhwR0NBTUVtSnVSZEVKR3lFd0FzY1dqa2xV?=
 =?utf-8?B?NWcyMmlLL2hGZ0l0M09SOTF0d09GK1pjU1RjR2ZVaCtTNDZ4ZGIrVjAzYSsv?=
 =?utf-8?B?R1hCUDVseGhCR2JuVzdxTXdOZHRHamY4T1lwWGsrKzk0Q1ZRSDJkWTZyTVpJ?=
 =?utf-8?B?VE55SFp0YjhwdDJyNVdnY3pmbGNqVFMwdkVOekwvR1dGODM2b0NlQ1JTTDRY?=
 =?utf-8?B?N1N3OFlTbEVMeUVseks4MVcwd00rR3J5QjhsLzY2T1VkME40L2N3M2JLRmZo?=
 =?utf-8?B?QlFIV290alNadkNPSmgybXVYbGdrZXV1ZFB0bWxUWE9jcTZDTENzZGV5a0ZG?=
 =?utf-8?B?V0RxMlZJU0h5SkJ5MVN5VUt4Y2M2dkRWT0podGdhdjlWOVFOMkxQTnA0MTNz?=
 =?utf-8?B?Z0R0cm9mVEhSYlRBUTY4ZFRnLythZGY0bEJMVnV2Vnk3REQwN1NtaWY2emRQ?=
 =?utf-8?B?UnB3ZC9SbWZjUSt1SEhZWWlZSGVIaWtGQWpjcTNPSjNCdU04dTduQzUweDVw?=
 =?utf-8?B?VVRrWlFyVm9vQ1l5ZjhFVHlCV1VQWG95SDdDQ0xtdWE3bHM5aVhyMWdtS1NK?=
 =?utf-8?B?UHN1UEZMakVPMnZXSnl0Yms0Mm1DZWdBMnBGa3U0MExpUXVOY2NVb1FvUC83?=
 =?utf-8?B?OWVma3NudCtvR0ZyUG1Ed1ordTJkbllwOUNKZ2hiUlo0dk8wRnZKTjhRR1h1?=
 =?utf-8?B?WkNoV2NKMXpGd2VDSUtIYU9XU1poZVFoMTgvVXh6eFcwZE1zN2s5N0VJVm8v?=
 =?utf-8?B?YTVlOFlaN3p0dnloZklBRFhYNmdRR3lCaUlPZnlwV0lnTG1NSFhOdzlhMHA5?=
 =?utf-8?B?RUl2enJOOSt4cUhvSUxteW5aOWNYSG9PcEdoS1VyZ0FBNktxME5tOVp4YTlP?=
 =?utf-8?B?bm9Senk0d3dnZVNPOTc4QkJPSThoUDlsWE5sRnBZSjFaamY0NW4zbWZJVk1o?=
 =?utf-8?B?anMzalFZOG1OU0xmU3BiUHlJMGtsa1J6Q2ZtcGFkanRoYzZEazZ0Uk00N1Ar?=
 =?utf-8?B?cHpNUUtkL3pKbDZqemE3UTM1TVNiNGU1Y1BGRUtTbWJ1eUswemVGYlh3UC9D?=
 =?utf-8?B?bHYwOGtUMnBkS09KMFFadWR4TmlzM3Z0SW10V0IwRWVCd3dEaStDa3pNcGpj?=
 =?utf-8?B?YkI2dTgzNk9ob0U2UjdiUFNkR245RGV1Tk9wOHEyVHJNNUcvWC9Dbnc4Ymo5?=
 =?utf-8?B?K0o4QVhaWEJQUkxPUnY0QlpISGV1OU9DZFp5cHpqVFd5MnBTeUZuS01uSy9R?=
 =?utf-8?B?UEQyZ29teVU5MWZpMTl1cGxOc3hpQVovaVIxRHdPZVlCempwZFZlZXYxamVB?=
 =?utf-8?B?SW9aN285TG9JZVVRQndXYUxBVVhrcHZPUGg5QW5xbi8wRUVJYkdJMWxocnZq?=
 =?utf-8?B?VDFWVDZUZHlHODlzWmRtSXZOa3Y4TjlrU1lpVzdBYVcwT0pSYmp4UjBZMk8v?=
 =?utf-8?B?L0JpdVFQZHh4U0YvWE1uM0NDNG41cW9EYWV6aGI1bzg3Q1M3YWtNQnNaTndX?=
 =?utf-8?B?UjY4aENUZi9zMzI0OFR4QTU4Q3poUG1rVUxvR3MyanJITzVac09ESy8vLzFi?=
 =?utf-8?B?U0krWFl4T1RUYVpsRmtnY3hrYnlONlVsVlQ1cmQ5eG5nc1F5bDZVL3NlWGRD?=
 =?utf-8?B?NEQwRkpzaXRQOE1rSkZaVHFjVzU3eFR5dFg4cGZudTg4dWZxM1VPVE53MVVP?=
 =?utf-8?B?YkNRK3U5REhWc1BrSitKNHU0cTBNV2drMmFtMW8zOWxnWHlGcTg5L2pqak80?=
 =?utf-8?B?T3JhN3pYQlV3K2FuRXhHY2Y5MTBVT01ESTRpZWhiOTNwbFNIekxRalE3NHFo?=
 =?utf-8?B?Z2xTckViSTZJRDB3S2xYZzl4U2ZFS0poaWRVOHVtejB0M1Q3YTRPdEZSRExY?=
 =?utf-8?B?c1VGbFZJR3AwNjdhTTVHVXd5bWRpZ1hNRHhkamc0aVl3d2dIeFdJaUtnU2Fn?=
 =?utf-8?B?Y2MyL3oyMmRnbXZNMVNoWjJnRWxDbThOUXhOWDNsRENJeEJKMElSQzIxcGxK?=
 =?utf-8?B?M09NVG1WUW9TZytEM1V6VGZWWHNONklSZm5HczRYVnBKVlVaN0ZmSDFGNHJE?=
 =?utf-8?B?WjNzWUgvYW5aUVV2T0VCM2JrMUt4S3JyUkg0YzZXbVZZVG1zaTVSZ2w0d1lT?=
 =?utf-8?B?b1E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VWNHaGU4R0E1djk0T2ExMkwxRnNGLzJiK0xLSGtkYnZtUE5Ya0tEUUhCQmZt?=
 =?utf-8?B?QWZUUC9rV2ZPNllORFNRUmgxT09zM2N5UTdJaXdScmx5eDhtZ25hVkZIa3hT?=
 =?utf-8?B?QXh4NlczWGhuYVZ5ek5GL3Rvbm5ma09LNFhSdmdlQjFicG5EaXI5TDh3eFBX?=
 =?utf-8?B?SlNMTlZ6Z1ZFQ0ZMTlJGMXN5RnpCbXF1YUF5bi9XMjY2cjltRnJPdVJ5Y1M1?=
 =?utf-8?B?M0Nva1l1a0MrTUN3cCtnaEc0MUlZOENEQkJsZ3dnbHdwT2NKZFE4MXpwRmJQ?=
 =?utf-8?B?a0VibVRtVURjSUh6TFh4M0J2cWUyaXdSeXV4S1V0aXJEdXdGYkF2K1BjWHRu?=
 =?utf-8?B?K3Jrc3I3aVo3UFRjSXdsQkdWUW9XT1RocXpGak9Qdzg5Q3hNQzVGcUp6M2FN?=
 =?utf-8?B?YVhYK2FMTlFMbncyRkNCOSswMk10QVo0ZjYzMWJ5cWZSWURxRWREMTJDWHli?=
 =?utf-8?B?Mmd4V1RjSGlMTnRxUWtDRWptcXEwUE9aaE44SHpDWnNUa3JhdGV2YUxCeGM2?=
 =?utf-8?B?NHZoTVM3MVR5ZVBkU3JyVWV5aXhUNDdBbnRrUmlleHBCcnZWZ2laY3N5ZUUy?=
 =?utf-8?B?NnhpQ1VQcXNkMUZhZjkxWUlPc3h3b2dHeWkzay95cW04YWVHcTJOaEJwYlM2?=
 =?utf-8?B?VDh4KzBQeUJpUU9iQUNGd0NoTFV5cWJNajlzYmlBTXZ1aDRYTTBwaG8zNndN?=
 =?utf-8?B?Tm1MSG8rR01uMEpRRDRweHhUb3FlZGdtaUoyVWhIeXltbHlwNXJSNEN1bm8x?=
 =?utf-8?B?YWxxZVIrQ2tWK0lqY0dSTFpmZjZ2d210Nnk4dVk1V3pQK2tnNTVrY2FNUVNm?=
 =?utf-8?B?dE1VQ2pwYmh6OWc3NEprQ1dsMDhIZzdhZWN2cjJHRW1aSDNNdUhaanQ0Snln?=
 =?utf-8?B?UDJIdmRsVjRrdityNHNmdW5rdGxQWEdUQ2EzSTJwZXExaUkvYnJyeWRBd2c3?=
 =?utf-8?B?SE1GYmQ4STZUeWxCdDEvTGcvZWMzQjVmMnBFMlBaeC84M08wWG1uNWJwbTNB?=
 =?utf-8?B?UXAyNXFELy9qVm5VWDE5eWs3UjQ4N3FuWUdLaWF1WG5XRUo0enYyNHI4S2Zq?=
 =?utf-8?B?eWdmZW1sQUI3U0dGaC9xQXZ2MEdvaGFPc000NkFiNjA4U2pLVTZuZ2RvcUZM?=
 =?utf-8?B?R2RoYzcvOTN3ZUV5UFdBOXVSVDFmSFpSdmdVeFVsM0M5MTUvb2w4Y2V0WjRh?=
 =?utf-8?B?aHVrN1crK1J1alY0Z1YwOEx2emNmK1plbkptUWp1NnFra0tVZnFvM3Qwbllt?=
 =?utf-8?B?Y1R0STVVaGNnRHQwNEVjMmpsTk4yQzZxbEQ5bGQwd2JtQ3l6UThFc1dBbXpw?=
 =?utf-8?B?aHhsSGs5MFBiVnhlWXJuM25lMDVEWGpaM0ZvMWNPT0dTVUZMOHpCSGQ1TlBp?=
 =?utf-8?B?QzNTRTNiUWlCMmFmZkdvYnJXV3p4Qnl2eFp1WXlVMFd4Q0VabkRpR1J3WHlX?=
 =?utf-8?B?a1Ivc1diQmhsZlY1by9aZlFMT0ppY2tYZytrZ2M0WHl4cUNjcjk0bXBFQWVZ?=
 =?utf-8?B?QlFDYlkwTzhCUVV5ZmROcFhJSWcvd1RPTHRnT0I5cjN1V0E2NXU1MENkbXI5?=
 =?utf-8?B?b2RKdDl4MDdGVHl2bUFVdmlFQlo5K2pxOG51WFJIKzFZaUJxREwyQ2s5TjU1?=
 =?utf-8?B?OTRsd3o3dGJqR04wT21sa01Lc015LzE0T25GSm5KSWlCSlJGVVVlT2xQVVU1?=
 =?utf-8?B?UWZyOHF2clZWRFJLZjNXRmRhOHNwN0Y3dmhaSzJQbm5jMWN6MTh5V1prVzZC?=
 =?utf-8?B?dWRlOEJ4QUE5NDdiaTZYcW8yVnN0RDlaUVdhM2JmdzkrRXBTbHBJVEoyZTF1?=
 =?utf-8?B?ZTVXYUh1OHVKd0xPSGk3RHlUczBVZGtBUHRWNjJ3OHd3Ymxqb0NWK3BRVEta?=
 =?utf-8?B?TlRIcG9mZ3pGV3V6K2VXSThnNE5YRHNQaEhRdGlCRzJxSFBxL1k4SzhpS084?=
 =?utf-8?B?ODZka0YreXFicURHTUI5aW5jQ1lRZUZGWElxZXRGN2hEb1V0Zi90MHMweDZN?=
 =?utf-8?B?WmVSZ0JSQjVSUmJDSHNjY2E4eHo4ejVZU3d5Y3JhV2tFWXdLUC9HTXc2eHlv?=
 =?utf-8?B?MWdKc1RmZmhRM3k1Wk9JVDdlY0NUUFpJeU5WMHVQNmt6VE9SbkpUVUN4d2JP?=
 =?utf-8?B?TGtxRThwb2habWVRQjc2aHRuS3RTemFUemNrWFJhc3lHbUQ2QVR2TG5GSXly?=
 =?utf-8?B?Nll5SU5JRkwwTXVuays1eExvU0pHem56eWcySVdFWStHdGQ2Tm9Ud3pBWU9R?=
 =?utf-8?B?OUxSbmxsTm9IOHVQY05NaWxYQXFpSzhLWVhkdDhwSUpMUFI4TzhCd2FNTWVW?=
 =?utf-8?B?SFgvSmI1UGVtdEVyci9mUVVhcnlKSlZtenVXUXVVYzZuUHcvQlo4dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mzqfFO0tksqV93Znus6NU+3v53jb0GUJpu/6aR5K37Tzk6mF3aO6WRHpxD1pFyxQQVrlRFOM0jLek65iLKqLKMtPYy6uiWkdKxLD1/SbRlCXQDc+zBOQty1uNC16xrV8CbXblfK2N954AAx2prw6soHE37xudkwHv+gq1FyXpUIDz9A0kClKRvurqiNE6YYzvZY3gvtasTnHal5WOGGH3mI0Tv2alhzhVMzFSSXNZsM1UlVDsCaSe7pkMvtbVxpsrsk/8TJnGFS3Y6a1eAVGQtYK1uSXrpkZ39dcSLpK+DAdrMzP9tFPHMUvHPlqI1r6K4MakAJnl5E0cqHQz3cDzhjQXkzCPYbGZ8+DcVy4EseM5un5EeLIuIP1yDf2NfH5XLmlXXjP1SBIL8KWBH2aMUZ0pvMzdiGL64t0Ewyg7AFijyBG848zR6FuFKGcq8H5SOod0Wi0fsFgnZJHLcf5S45k5AxYT789Wed+fP358K/4K+CPzmBOX/QhVKZ6eKeOASpE4JC6mb/a62jVbeknYRRF7SH8lCTWQCngHxYnZ75/LflCB3Bt6oaow3bFtL7Efjdo7Se4D8PpNLdJsz5os5j9NLiZ9txxkCGyk5xtbsA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277999e7-a3df-4ab7-4707-08de5e9240b4
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 17:25:38.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NlV60JLwI4Nd9AhlfX8aspVsTT9ijbpo7jRxkO492XJEEIX5aChBh9T+MvJ3GUbsmJAvHLNZf5a+0Gm8E6WXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE0MyBTYWx0ZWRfXxTzUG1aLXo1e
 HlF6Anbk/1MQPgI3AbQtHjWYCSpksFJUFisPLLXIUDQ1xaCv302kStRvnysYwNyNuPdfgbt6Gb4
 5BSh1+joEx05F6pQrDXgSUSdPaKsTBhqy5XlTQTAVzbZQ7UDEHHrAM7X0o2Al1uQw0cab4yP+20
 IFvD5f9dq4Q7w6ekZ4TeQGt7y1Wc+HcSCNI6swyOgqas0EUIxIgszV0qsgHsuSRr5r6qHJY07EK
 L/NLXwUfMTKXKi+TF9t0eSTORjUzKQX/hYllEv+7WVY6IzkERqmKd9LVTpeq1FqPMq9FYEZavCZ
 +hgcUF92DJJl2ggkwtLmhoVp8XZi9Ju36aghbcOyMkA59e8KA2L70AtS1ILzE8Bn9s8K6+Tyj17
 UDXRqi1EghwpYDjBZVcnHC1/+sS/g+2glJsH9bNVhJATigKUztSeKTwS2w0aHtYHAgE/nx3yQ93
 TU3tJsstaDhQ82tkmpSxCihfdHdJAYuPiWiiGEjo=
X-Authority-Analysis: v=2.4 cv=a/o9NESF c=1 sm=1 tr=0 ts=697a4697 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Nq0Cz6u9avnQy8Juz70A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12104
X-Proofpoint-GUID: 2xhSfb3lx9aJUbPkEOs9VmFLMJSf0dae
X-Proofpoint-ORIG-GUID: 2xhSfb3lx9aJUbPkEOs9VmFLMJSf0dae
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75781-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 26872A6D53
X-Rspamd-Action: no action


On 1/27/26 9:54 AM, Jeff Layton wrote:
> On Mon, 2026-01-26 at 16:50 -0800, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout is
>> necessary to prevent excessive nfsd threads from being blocked in
>> __break_lease ensuring the server continues servicing incoming
>> requests efficiently.
>>
>> This patch introduces a new function to lease_manager_operations:
>>
>> lm_breaker_timedout: Invoked when a lease recall times out and is
>> about to be disposed of. This function enables the lease manager
>> to inform the caller whether the file_lease should remain on the
>> flc_list or be disposed of.
>>
>> For the NFSD lease manager, this function now handles layout recall
>> timeouts. If the layout type supports fencing and the client has not
>> been fenced, a fence operation is triggered to prevent the client
>> from accessing the block device.
>>
>> While the fencing operation is in progress, the conflicting file_lease
>> remains on the flc_list until fencing is complete. This guarantees
>> that no other clients can access the file, and the client with
>> exclusive access is properly blocked before disposal.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  2 +
>>   fs/locks.c                            | 10 +++-
>>   fs/nfsd/blocklayout.c                 | 38 ++++++-------
>>   fs/nfsd/nfs4layouts.c                 | 79 +++++++++++++++++++++++++--
>>   fs/nfsd/nfs4state.c                   |  1 +
>>   fs/nfsd/state.h                       |  6 ++
>>   include/linux/filelock.h              |  1 +
>>   7 files changed, 110 insertions(+), 27 deletions(-)
>>
>> v2:
>>      . Update Subject line to include fencing operation.
>>      . Allow conflicting lease to remain on flc_list until fencing
>>        is complete.
>>      . Use system worker to perform fencing operation asynchronously.
>>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>>        valid before starting the fencing operation, nfs4_stid.sc_count
>>        is released after fencing operation is complete.
>>      . Rework nfsd4_scsi_fence_client to:
>>           . wait until fencing to complete before exiting.
>>           . wait until fencing in progress to complete before
>>             checking the NFSD_MDS_PR_FENCED flag.
>>      . Remove lm_need_to_retry from lease_manager_operations.
>> v3:
>>      . correct locking requirement in locking.rst.
>>      . add max retry count to fencing operation.
>>      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>      . remove special-casing of FL_LAYOUT in lease_modify.
>>      . remove lease_want_dispose.
>>      . move lm_breaker_timedout call to time_out_leases.
>> v4:
>>      . only increment ls_fence_retry_cnt after successfully
>>        schedule new work in nfsd4_layout_lm_breaker_timedout.
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..a339491f02e4 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>   
>>   locking rules:
>>   
>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     yes             no                      no
>>   ======================	=============	=================	=========
>>   
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..1b63aa704598 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   {
>>   	struct file_lock_context *ctx = inode->i_flctx;
>>   	struct file_lease *fl, *tmp;
>> +	bool remove = true;
>>   
>>   	lockdep_assert_held(&ctx->flc_lock);
>>   
>> @@ -1531,8 +1532,13 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> -			lease_modify(fl, F_UNLCK, dispose);
>> +
>> +		if (past_time(fl->fl_break_time)) {
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
>> +			if (remove)
>> +				lease_modify(fl, F_UNLCK, dispose);
> I'd not bother with the return code to lm_breaker_timedout.
>
> Make it void return and have it call lease_modify itself before
> returning in the cases where you have it returning true. If the
> operation isn't defined then just do the lease_modify here like we
> always have.

The first call to lm_breaker_timedout schedules the fence worker so
fencing is not done yet. If lm_breaker_timedout return to time_out_leases
without any return value then lease_modify is called to remove the lease.

Am i missing something?

-Dai

>
>> +		}
>>   	}
>>   }
>>   
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 7ba9e2dd0875..69d3889df302 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
>>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>   }
>>   
>> +/*
>> + * Perform the fence operation to prevent the client from accessing the
>> + * block device. If a fence operation is already in progress, wait for
>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>> + * update the layout stateid by setting the ls_fenced flag to indicate
>> + * that the client has been fenced.
>> + */
>>   static void
>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   {
>> @@ -450,31 +458,23 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>>   
>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>> +	mutex_lock(&clp->cl_fence_mutex);
>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>> +		ls->ls_fenced = true;
>> +		mutex_unlock(&clp->cl_fence_mutex);
>> +		nfs4_put_stid(&ls->ls_stid);
>>   		return;
>> +	}
>>   
> I don't understand what this new mutex is protecting, and this all
> seems overly complex. If feels kind of like you want nfsd to be driving
> the fencing retries, but I don't think we really do. Here's what I'd
> do.
>
> I'd just make ->fence_client a bool or int return, and have it indicate
> whether the client was successfully fenced or not. If it was
> successfully fenced, then have the caller call lease_modify() to remove
> the lease. If it wasn't successfully fenced, have the caller (the
> workqueue job) requeue itself if you want to retry. If the caller is
> ready to give up, then call lease_modify() on it and remove it (and
> probably throw a pr_warn()).
>
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>>   			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>> -	/*
>> -	 * Reset to allow retry only when the command could not have
>> -	 * reached the device. Negative status means a local error
>> -	 * (e.g., -ENOMEM) prevented the command from being sent.
>> -	 * PR_STS_PATH_FAILED, PR_STS_PATH_FAST_FAILED, and
>> -	 * PR_STS_RETRY_PATH_FAILURE indicate transport path failures
>> -	 * before device delivery.
>> -	 *
>> -	 * For all other errors, the command may have reached the device
>> -	 * and the preempt may have succeeded. Avoid resetting, since
>> -	 * retrying a successful preempt returns PR_STS_IOERR or
>> -	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>> -	 * retry loop.
>> -	 */
>> -	if (status < 0 ||
>> -	    status == PR_STS_PATH_FAILED ||
>> -	    status == PR_STS_PATH_FAST_FAILED ||
>> -	    status == PR_STS_RETRY_PATH_FAILURE)
>> +	if (status)
>>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>> +	else
>> +		ls->ls_fenced = true;
>> +	mutex_unlock(&clp->cl_fence_mutex);
>> +	nfs4_put_stid(&ls->ls_stid);
>>   
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>   }
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..1c498f3cd059 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -222,6 +222,29 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>>   	return 0;
>>   }
>>   
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct nfsd_file *nf;
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	u32 type;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf) {
>> +		nfs4_put_stid(&ls->ls_stid);
>> +		return;
>> +	}
>> +
>> +	type = ls->ls_layout_type;
>> +	if (nfsd4_layout_ops[type]->fence_client)
>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
> If you make fence_client an int/bool return, then you could just
> requeue this job to try it again.
>
>> +	nfsd_file_put(nf);
>> +}
>> +
>>   static struct nfs4_layout_stateid *
>>   nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>   		struct nfs4_stid *parent, u32 layout_type)
>> @@ -271,6 +294,10 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>   	spin_unlock(&fp->fi_lock);
>>   
>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>> +	ls->ls_fenced = false;
>> +	ls->ls_fence_retry_cnt = 0;
>> +
>>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>   	return ls;
>>   }
>> @@ -708,9 +735,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
>>   		rcu_read_unlock();
>>   		if (fl) {
>>   			ops = nfsd4_layout_ops[ls->ls_layout_type];
>> -			if (ops->fence_client)
>> +			if (ops->fence_client) {
>> +				refcount_inc(&ls->ls_stid.sc_count);
>>   				ops->fence_client(ls, fl);
>> -			else
>> +			} else
>>   				nfsd4_cb_layout_fail(ls, fl);
>>   			nfsd_file_put(fl);
>>   		}
>> @@ -747,11 +775,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +808,51 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * @fl: file to check
>> + *
>> + * Return true if the file lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	bool ret;
>> +
>> +	if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
>> +		return true;
>> +	if (ls->ls_fenced || ls->ls_fence_retry_cnt >= LO_MAX_FENCE_RETRY)
>> +		return true;
>> +
>> +	if (work_busy(&ls->ls_fence_work.work))
>> +		return false;
>> +	/* Schedule work to do the fence operation */
>> +	ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	if (!ret) {
>> +		/*
>> +		 * If there is no pending work, mod_delayed_work queues
>> +		 * new task. While fencing is in progress, a reference
>> +		 * count is added to the layout stateid to ensure its
>> +		 * validity. This reference count is released once fencing
>> +		 * has been completed.
>> +		 */
>> +		refcount_inc(&ls->ls_stid.sc_count);
>> +		++ls->ls_fence_retry_cnt;
>> +		return true;
> The cases where the fencing didn't work after too many retries, or the
> job couldn't be queued should probably get a pr_warn or something. The
> admin needs to know that data corruption is possible and that they
> might need to nuke the client manually.
>
>> +	}
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>   };
>>   
>>   int
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 583c13b5aaf3..a57fa3318362 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>>   #endif
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	xa_init(&clp->cl_dev_fences);
>> +	mutex_init(&clp->cl_fence_mutex);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 713f55ef6554..57e54dfb406c 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>   	time64_t		cl_ra_time;
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	struct xarray		cl_dev_fences;
>> +	struct mutex		cl_fence_mutex;
>>   #endif
>>   };
>>   
>> @@ -738,8 +739,13 @@ struct nfs4_layout_stateid {
>>   	stateid_t			ls_recall_sid;
>>   	bool				ls_recalled;
>>   	struct mutex			ls_mutex;
>> +	struct delayed_work		ls_fence_work;
>> +	bool				ls_fenced;
>> +	int				ls_fence_retry_cnt;
>>   };
>>   
>> +#define	LO_MAX_FENCE_RETRY		5
>> +
>>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>>   {
>>   	return container_of(s, struct nfs4_layout_stateid, ls_stid);
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..13b9c9f04589 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>   
>>   struct lock_manager {

