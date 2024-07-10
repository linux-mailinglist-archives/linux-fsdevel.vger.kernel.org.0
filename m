Return-Path: <linux-fsdevel+bounces-23473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7F92CEF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 12:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D6BB21289
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB6E190473;
	Wed, 10 Jul 2024 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AoNZZj8i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ze0EJfiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE184A2F;
	Wed, 10 Jul 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606411; cv=fail; b=vCr/qtwsGclADFvhYjJTwUFll1+Gz76RWwTbKu+wFVJZ3rBmMycTVidVKiz0i6By6UUD2lrvGQm1jrwOBJxVnOjWWLDQL7o9MCF5vdWxGnK2dOjGMMCEmoD+/gWV02SZmxyx1BEA2FrE3twXOf73I2To8jZ5D2bhNrxOTJKr6q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606411; c=relaxed/simple;
	bh=MVL3ZH2cWxRmiKK83CYipwBP1rCJjOM5747UX4oSQCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GrJsEiuWG9q/OMtaDcPRZzBOy6W8q9tSosG9ao0ZZ+hk+142C0BqYFscba8lKpgku8vLbVoIA20oS+THBWBJ56PM/vXbhsSoeK5NstEN4Uggcn0g80dCPaDhfMPNkwWZfiuh7j+RYQjz0NrDOghkBvC5acrff4Xri36oY4MVkvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AoNZZj8i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ze0EJfiD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fX65004054;
	Wed, 10 Jul 2024 10:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ArRFYYKGHVHoxutepm1GdgImqF4erckiOYXXPEZBNDY=; b=
	AoNZZj8iUlFH28CMokBZjxl+hJosdhOg15ZiOuM8tKwdQfRKs7PAzjcY5ZBVV1Uh
	YBJwcggzYPQbbaL0LFFj3OhTVuoasS6eJoB+qYhXuxECZ20OtB6dpoRPWVa5ZHvs
	5/46oMtoVYtQXxiVw+XxS4weE2HhzlduflDOLrFBzdlDSH0uuG1SPx1eHM4/dmgQ
	dhuQhuj/WNIUIgJnxylvnLUkSB49uLYLksb8LtTpJevtRRo8N4ouylIzZtT686qB
	9UteSfue4T0ZlSTAlbMuB2Jhxqr5qCjiD3vIY3nYXwgtTWpcoQ7AklN6+Nk307kf
	V0LnlgvvqvwrXA1PoXhXAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfspx22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 10:13:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AA7SaV005056;
	Wed, 10 Jul 2024 10:13:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvf05gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 10:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0/C8R0/3xWfN0HLyYdniwMw7h4bUWFd6AxsxbpjoSsPB060ZfnkoK0SnTI9KuQ+J+wZ1RFmhAHUfa44CTwiT7IDay5umk78Bes4gWcmC+4wbDTvcAZsbSatcRp0NI+6n25/RRgrQVeyz+TO/QcoKCkRpty4yaSAJdTM9QjRIHomu+ZDv6bLGjwSypW9/NmNocCr3dNTNGf+HARz0yHED5Cz/SEKbtmYoq+MSvhyXTBiTh3Uowf5Q/KjV/i6oj0kTCv1PZnV5xatobwMC3BE7QX5UgeArKSJMqr1YdKbAifebs1LSjWEVSxkDG2jd2nArFm3hTDeY7kYYPdranV7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArRFYYKGHVHoxutepm1GdgImqF4erckiOYXXPEZBNDY=;
 b=CNH8IBjI1AYTQvNlf4muoG9A7x97SzSqk2+KfFboS5H4g1WjJ8CF3wxVl8yfaCAWamFk5ShLQ1SOQWPkhKbktU6lny9AE9oEV4oYIMhc8GAsVdw0hF/C/RYsABwUX5irIZtta2iXlZR7UA0gYsSs3aBYzgynPh/xfyH/ko55Ck3zjnN4g2bdjkhtNm8n6St/QliEulOrmteLHjXV99NZp9fQpBKSqCGUgFr7iANs+/R5TM9pKoHVijQpe773c/rxC97AwUFTEPfNB+IPMGn8uq8KTBa4P3v8n9PbPvcDHcKfd1LHsv7MgT9EmNPFQZBKhlGEvADUY08FDmLJKnSfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArRFYYKGHVHoxutepm1GdgImqF4erckiOYXXPEZBNDY=;
 b=ze0EJfiD/x2M+j9+V61+bJdTd9shfCYqSDGBbMJe1Z8nd7CSJ5X9dx+icjzY6Ehwv2j6H4LlvvhjxJ3xn/OFVtzFJKnVIPjsT/3GUGn/TOHz0spF7fvJ4K48z2q446h6IzLqZ7XApjubmjz648Ib0ebbtdkGErthu5T18DKvFYs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4567.namprd10.prod.outlook.com (2603:10b6:510:33::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 10:13:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 10:13:20 +0000
Message-ID: <4a51397a-85d9-4467-80f8-0d4c3d997eae@oracle.com>
Date: Wed, 10 Jul 2024 11:13:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] io_submit.2: Document RWF_ATOMIC
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-4-john.g.garry@oracle.com>
 <yyqi4f6pphnpjhhlwnbvsdyaxsronpfumg4bjp4eig6rh2d4ka@uyy5y37waxbd>
 <zonwu3dsyz6fk5unic2rgxqpvrceqrtj4k5epb6hdj44fbzxkm@vbfqorsyw7te>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <zonwu3dsyz6fk5unic2rgxqpvrceqrtj4k5epb6hdj44fbzxkm@vbfqorsyw7te>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 9579f657-3c9c-43c4-7cf5-08dca0c8ec5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UG14Ym9QOG1uN2dwUzFkZWp2UlhQbTVDeHVEZ0MvcVdIR3k1K1dOZW5jUGRk?=
 =?utf-8?B?cTgzOGFoUlpZZWJxa1NZSXJpVFdaUTJFVVZmQVVFdVZKbVpOT2lZQ3JpeDFX?=
 =?utf-8?B?MVVaYWlDWVJQWEhOZHpLaE9qM2JQS2h4OE9yOFpvUTVTdnJpUmc0RUw1S3VX?=
 =?utf-8?B?YjFKUndPc1dRMlVkQnBMR0ZYc3RzVEhoNytxUHh4d0hPMDA1TXZSck5SdFVm?=
 =?utf-8?B?NHB0dWpqUnNUSnFZcHRBTFc4LzZBeG55K0o2eW1WSG9VRGxUVzJmY09RdWNz?=
 =?utf-8?B?djlyYXp0RzZKMkNwMVlYblpPZjZsNzc4K1VDWjFVNlFWa0hqTDBVRU9RbU5S?=
 =?utf-8?B?ZE91NCtXNEZQWHpRd09VTE5lWk5qOTY0VXd3WHhBQk1senpxOHRVU2hrY2Ex?=
 =?utf-8?B?Uml4bU9tbnlud3NJbzcwam9oSWs1ZWJkUWRxbjFsZkQ5T3FIbzZiZUVxN0dJ?=
 =?utf-8?B?M1Z3Z21xdmdkZnlKcGZYSnRkZGdBd1JNU0o0dkNpUkMwZjVnUGtqWlB4d2gz?=
 =?utf-8?B?QUZZRGU1bnhzTFdvTzMrcWpHN1pJclJCMW9NWGZncHBKaCtmM1lZUjA4eWV0?=
 =?utf-8?B?ZmFtcERCV1dPeFJJc1lKelFmc1dWbjloK3dCSmt2d3ZtOHU2TGw0Zm9FbFRw?=
 =?utf-8?B?aEx6R082bklHUzVTK2k0b00zOWNMU1pxZTlOYjNCU2REMmtWaVFhN3JyRk1G?=
 =?utf-8?B?cUlrbWFJdXVzdENEeGtaWU5NazAyZ0YrMExFRGZkQk0ySzdEVlFMdEFwdzRC?=
 =?utf-8?B?TWY2OWdiUmNTVHlYNHhhY3ZNczROVVAvVE9JUXVWUTQzNEhDazVjaWxFVG9i?=
 =?utf-8?B?R0RmcG9SUXBWa1JwR0FBZ254WTAyTFExY3hERU9pQjBZR2Q0WmNzUExaMUVO?=
 =?utf-8?B?WmZlT3FETXJISXI1YzF5Mm9keHRaK2VLSEcyaFlNYWxsU2Zzc3M4RlA4clh1?=
 =?utf-8?B?OTg4WU14YWgrbzFjR0xrR3p4VU54T2xLYzRhTHQ2T3hDbEZNU245WGZqOEFQ?=
 =?utf-8?B?SDYvTS9vb3VRQWtWY0M2Q0xSU2lMbFVZZndtSDdpaHdjVGFKUDNVaXhJUG5x?=
 =?utf-8?B?MGN0TmF1aVhkbktTdkcxRmtBZGhheUZaU2VDdTZtVWNtRGxnY2hTTjk1MVUz?=
 =?utf-8?B?dUIyeWlFTUdST3VzeiswbTVtalNiK2NYSUtLcjlaQ1NBdWVyRXpqNWZ0YVg1?=
 =?utf-8?B?NHBzbHpySkphdGhzcmRwK1pONGZxUmZTa1ZDMkxtTHJidWloa0V4Y0x3cXoz?=
 =?utf-8?B?MG50cWhjQy83c1YybGNnb3AzaDgxMTZybklBdHFtYjc0eEtPV00wWS84eHl5?=
 =?utf-8?B?aDlxVjVsSVI3VGc3OGxFak12REgzMnV3aGczWTZWOTNEZk0zYUhvMXRaSFlM?=
 =?utf-8?B?b1hDL05laTZKN0ZLYU9wZzF5YUwyTVd2QXZSVVUzYXRyQjQ4WlZGbUV6VDdn?=
 =?utf-8?B?WS9vUkpwUmpUUmxzMnZyNXdFRDVHcTk3VWJRL1Z5YVpqM0hDNHZFeG9VZXpZ?=
 =?utf-8?B?bXNzVGovL3VHK3lpYzlDYzF0c05mcVBFYTg2MjVUb2hrOURicS9GVEdPWi9l?=
 =?utf-8?B?Yy9nSzVvLzVjcDBNM29sUklZWW1oN1Q5RTlRVVVjZkRicGlaYmNhTGJPNUhY?=
 =?utf-8?B?Y21vUXZoanhydFQ1d0poS3VZbHg1NE5aOEpPSkdaczlSZVBXRU56YWk1SFNT?=
 =?utf-8?B?TWNmN3NwNU1PWDBNYUEvNGs0OGxsaXVnQnhqUWZ0SnJ1YWZCS2pna0t0Z2hF?=
 =?utf-8?B?ek41Wmw4TUo4ZU9tTzFxUGUzeG81YVFmNFFLUzZTYW1vKzlFdnRuTi9xQ2lp?=
 =?utf-8?B?YjJyYm9GeGUrUEhpRDNPQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3M0SUFWc0xBeXlXR01zeGFlNXZEcWoyMytTTVFiektxbWlUZkJHTVlqTm1U?=
 =?utf-8?B?ejFzdmxsUndlbm02ZDhnT3QraWZ5TTZSeVdaaCt3ZUpXNTBtQjhRV01VRm1Z?=
 =?utf-8?B?Y0l3dU50bkhpRTgrcGYxL25HWDVmMHR4b2V0UzNadXpRVnFnTDh0cEh3NjVD?=
 =?utf-8?B?WnRjUFRhNXViZmRsd3U3cVdrdENrNlpjUWo2SSs4cDJyMnYwOGdjamNnd28y?=
 =?utf-8?B?bW80Q09YNDI1WUZwS1o2bHQ1djBNN0tVZ0tCSjYvSU0rUEFSNTMzK0RBUmdM?=
 =?utf-8?B?L2V2cjN2Z0M2UFdOL2dlMEFhQmJmOVZFbGs4MlJoZGttQWh4TWdPcXB2UTB0?=
 =?utf-8?B?dUhqUDAydG1iUkJ0aktBUmtwYmxTRmk1VDFUNzVzdjNTVUtVbHRVdWc2Z1g1?=
 =?utf-8?B?SU1iK2VWSjZER1hLbVpaV25NMFV3WThlZGhVK3dWTnRaZDFHSVBDWHZnams3?=
 =?utf-8?B?dEhUMFl5dTZhNXhlMGxuS21rajZ1eGVJWE41WEw3REZsZjFmeHFCaHpObHpV?=
 =?utf-8?B?eEJCL3lOdE12K0JiYi90VXNyUVJGVnBWY2w4VzFJdExwblF6YkJFOW5HKzJl?=
 =?utf-8?B?VENaL1lyWU85RlNTMm5UM3p5SVRZdUo2OHRjZU5VT0VRWVM3SGtqL3NCby90?=
 =?utf-8?B?V2xVeitLOHpDS1NXcWorYmUva0FJdXdBOVBoNG9nUGxnUS9aa0pUeWdGQits?=
 =?utf-8?B?YjBqZkkyMGsxYUZtQ2ljY0tQWm9qZ2wzNENDN21wVkVmbjM5NlJUUVR1a0Fu?=
 =?utf-8?B?aWI4cWpqelJpTVVVOFdkYjlnU2dPd3pjUVQ4OUkwczFaSTVxYVFuQjg1YjFE?=
 =?utf-8?B?N2NlVHpJWU42RjZFUmVCUGRyL2tJYXRyelQwNXZtM3o5MDhra1NIa2hsV2VF?=
 =?utf-8?B?TjF0RGRiMy9BcUJPRVBraXREdVZVZ2grakZOVElYUCtUSkpFbFNPN0VFS0I3?=
 =?utf-8?B?MDIxZjhqcDM1U25LYUliSGtxQkgwYzlqZ0xkWVNIU2V4THFBZndIYm1iRVZo?=
 =?utf-8?B?MXlyQnQ1UEo0eC9pc1ljT3dnWUlwWFdXWFRRaTVoWi9seEJwTHNTVGVjSUlG?=
 =?utf-8?B?aHpPUDdmY0RGem82aHhZYzNyeG9weGh5RzRaS3R6dEhDeXE0MExXcWY5R29u?=
 =?utf-8?B?NFRmUVdramozTFJncmE2cThUWld6U2Z1bXMyeVA2RFdKdDNkQmNRWkNMckJ3?=
 =?utf-8?B?L2I2MFhtS0JqNHJCTjdLUGVISjVDY0FpVGhEMDRlTW1zYVlyd0kyeExIcTVJ?=
 =?utf-8?B?OHkyRUVTYzBCSXhjbWQydFMzVHA2alBneVhycGVLazJxaGRaK0lkMW0vbVpx?=
 =?utf-8?B?QVdVd004aXR6UnNtNHphSTdFeWFlOEhzMENJVmY5R01FT2tZeVVFOFgvMmdv?=
 =?utf-8?B?SjQwL1dXZkthL0tJZWwwTzNmUjRPd2xLMnZMQzhhKzd5V1hoOS9rTDVPOVhy?=
 =?utf-8?B?Z3E0dXpHaWRHeXBJcUhUN1QxWFRha0IzUlVTV1Vna1J4S0R5RXdDTFBlZWhH?=
 =?utf-8?B?RUJpY212d2w1bk8zbWxDSnJGZ2cwOEZqYU5zajcxRWkyMVh6Slc3d1hhRlNw?=
 =?utf-8?B?L0ZJNlgwS3gvcjJzZzN2TnpTTmJKamdNcUcvclFDbzR0MEJHbjY1b2VXL0Fh?=
 =?utf-8?B?eWdRNlFlNkZNL0J4RkJCV1BUcWlqOVoyTjZ2RURRbDN5K1R2MGdkRzVtRytQ?=
 =?utf-8?B?czJlMUhxMENvYStkSngyTzNiWTkwdHVLNlBLTDZYVG1PcGFkSjJ4emdDU3hU?=
 =?utf-8?B?cGpSSm9DUWdwMGtTYmJHZ2dBUURjVm51NWhObFRWcHFOWW5ucDM0MzhCSFNO?=
 =?utf-8?B?ZUJOUzlNSXE0Mkx1eGZmaGRQb3NUUmVKU1Z4MDFLQUtzc0djeUZsZStYdlNK?=
 =?utf-8?B?N2JUTHdQSXk4MUNYSU4rUG4zSmpZYzkzTFlNRGw1RGJzY1RKMmRVRCtyZjEv?=
 =?utf-8?B?a0xjNjFsWVVRL2txa1paZjB3eXpQNUoySEFFd2RxRGRtMEZMaHNTQTY5Y09r?=
 =?utf-8?B?dTRFcndUZmNJS211Wm55RmcxMElsaFN0bm9FN0RiYTRDUWthRGVOeHplNXZU?=
 =?utf-8?B?QWpBdWd1MWh2QU9YSEtWU01vNjVsMWhGRjNabWpjYXN6QUQ5ODhodjk3eldI?=
 =?utf-8?B?T0E1V0FsTHlaNFdRRnVIQm15UGZVSUlQZnNCNU1Remg0QXlWRkpsM0NJTmRS?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Kty+T/p7BD1N9xdONEWLcuKvcAJbRv+lYhMrXwLZq2q4dNkx6ymPeTXlQQq8NmXxOAprZGxV6Eb/suAmGBCII1Mvv/CozVG97aUV6UanLMgzuW8wgAKzpZax7nl8Xg1l1GZl3rjcJ8Ph6BSCper0lJTPv2j8ogRfzY7tRDShuVol7KbhTe7eP6kNRN1ZFzsOCgvLvR3MQnxA5clb23ZmC1259O3b2I30FbjWS1LRbrB9dFQG5vmleIc1ImRepcXUAjCnZVfRSfa+741UEbYM58/EkakcomWOxmoToJebGHTjfduIeIjmhV5eFUrEm+Cvt78IO6dVK78mG967yvIcBiU7uJ7Z7Knuhfc3Uav/u5tQCNiZWyekt0j8w4J2uUPBizqumaHG4JnzZbceTDJu2+WpGfMIyAd8uIRKZFsthc5fYx5TMcOLyUANIb9LKrvQDZhlA3D9NJAMmMnZ9bLfiZ8tVx+oQUKAU8vAEFzjKpXDHnx8GTjsSlyJTkRa20PKUJwQwZAEAeUF+OCcoK6MWsrfZppVJqN1RH39ioaFtcA71SeH/EOOWw1SDbgXrTE9YMazZIGsyxrqh6ev0vNqaGJh0VkhF/RZ7YIW2uzAhDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9579f657-3c9c-43c4-7cf5-08dca0c8ec5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 10:13:20.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7k5piSUDeb4Q4pA4O0q/Ba36+2+vJPZITk/1lxupvxHtJOHP+q8fhh084vn4WmMmfwIBN1KxQ3Vh15gKD0buQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=902 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407100069
X-Proofpoint-ORIG-GUID: n-O2JYZgzePL0465EQTYRLDdI6gFLtMO
X-Proofpoint-GUID: n-O2JYZgzePL0465EQTYRLDdI6gFLtMO

On 09/07/2024 17:53, Alejandro Colomar wrote:
>>> +.BR RWF_ATOMIC " (since Linux 6.11)"
>>> +Write a block of data such that a write will never be
>>> +torn from power fail or similar. See the description
>>> +of the flag of the same name in
>> Maybe?:
>>
>> of this same flag in
> Or just to be less ambiguous:
> 
> See the description of
> .B RWF_ATOMIC
> in


ok, that seems better.

Thanks,
John

