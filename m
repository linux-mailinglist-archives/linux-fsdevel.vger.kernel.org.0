Return-Path: <linux-fsdevel+bounces-25793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60001950857
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB311F2139B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7B19F46C;
	Tue, 13 Aug 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kN/NXSgN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MHi89s8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3E1DFD1;
	Tue, 13 Aug 2024 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561312; cv=fail; b=LL4x89f24mJDsKeyxMdbl+M3aGJAaBJarDGJI6LbZ0NsrHAF2AX2dQDPLY1D19lFhhFFp6cd/UDBEckJvfrzSU6HWK+cU6UuCjVXDeBfA9raFV7BWzVIvVUUDdbvw1t97gdXZxb0lLUc8NJpV1Ta1zrpHXmg28nzED8zILBVHow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561312; c=relaxed/simple;
	bh=+9pIgCPoQAOMVVvf+m+JAbQ8r+qAZf/9ntHRntogEnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lqLRwk8javt8MUur5ub8w5lEc1U3R91DQFE3ppNCfZPpCz8u8kwAitKmGhdFhdFE+VnMzJy20yEXl29r/GCU0PaTyLd3wSzZ0h0mV6k8gGo8mBqan4NL2vf6yYTJyEp5Xpe8Yhypl3xq1A+Ae8xttwBDJciRryW3lLWD/fvGT9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kN/NXSgN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MHi89s8U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D7tYMJ006748;
	Tue, 13 Aug 2024 15:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=N98S3w9/oz1l0bOkbS63+Jfm8RjL95l9BE1Qi57cNZU=; b=
	kN/NXSgNnnI2X/ifihYVe7ddn3bNUlLOco8Mz+hfsJRc2L6gMIlxNY4ocSqtjrLr
	Jv221w7Eco8EvB+ee3mUkVnpPa6oQEQFDUIPJh0dpTkVfizLDrx1ziS5tdYeip92
	OqmK6L4/CwQgL5pNQx8BPsJ8rFMEZqUhzgTsoMKx7YlfPt+roUyPC8TxWl0OgvQD
	ku+c2UWEX8gSOfIKRkmTTRYrKDwgoVcfuXSCal8Ty8hjrjGRkgxKy33fQ12DrUyG
	Jplf5YZRFMZ/1piykujRMv6/5kUqMMGnT3hjzYcEt5Bx4mmJb16CRTKUjednpIKk
	zRkfSEUf7l/L3xXavimyGQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0396204-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 15:01:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DDhvVH017699;
	Tue, 13 Aug 2024 15:01:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9j0jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 15:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3t6h3eI545ZlwupMCkEXtjKvPFrTPrb08B7j2cONuuCWiXSf8j6B2G93MVjw0DcjoVdwpCeKCouBJLZEKfqoMeQ93JvFssUV51Igws+UNzzkoxemnGTGiD6JSvnZkQEVoaHri5xxLNRpVNdngox6IOvGIUHQnXt3Dz6WqnWbQ2SOkpAZk3x+rlG866AEF/A1rWpCRdz//qkUMxNGo/v/edGwxldCsnihn6ZJcBXrBxGxCz8hmxocLL9p732bjfDthX9eizGejcvVLwxn0pb/98jDyjQAOCDTNb6QjvbUvT16wmWf4bfjlK4EHnuyhSnHK+GvfUbyXu1JXh92cWYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N98S3w9/oz1l0bOkbS63+Jfm8RjL95l9BE1Qi57cNZU=;
 b=Ef3DeL+VqEpn4Ne/nYvcCNtZ8L5XpQum+jp5mOpRL2TyHNvAuLStcB+7qYf3xA4y1yyhPGnUruEb9chf0Z50Yh4MEYGLCknFffUejB1cI0QM2dLh9wXlGpovgELO71ewy72sao59IpptgMxMazpHs+v/f1U1Gg6aQQ2AtLbCYF/B+37hk+sOLi+fg6IGCTHfNK8otzRUsBSAhc0LRfoQwEKDsiGqhdZ2FK9Zb1tO/V9Yf9B87J5wOevwpJ8PGgAoxS0YCTsMjqsG3MUgt9TKa4hN6Ux321K9B2CxfMlLuKjS3F9xcKN406M8DeoQIJdUXaeiHgEuIs55zQqHvm3ORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N98S3w9/oz1l0bOkbS63+Jfm8RjL95l9BE1Qi57cNZU=;
 b=MHi89s8UMKU9nOYsZYfYrBZ3YOPf+5ctbi5D1CG7j3Vk5TN+6vNMZ5LZYYgVr6+ZDEtEvgKljfY5WTFD4YUnYh1EE7Xrn6XhGcAzXhgyZthuxMlYI+GfS6C8Zo4OG7fY4yaaz7ZLqtRWnwLAaxGETFvntG91uALEWOW88mLzGZk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7713.namprd10.prod.outlook.com (2603:10b6:610:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Tue, 13 Aug
 2024 15:01:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 15:01:27 +0000
Message-ID: <8f499ed7-b220-496d-a008-2320266d394f@oracle.com>
Date: Tue, 13 Aug 2024 16:01:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] xfs: always tail align maxlen allocations
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-3-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240801163057.3981192-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0010.eurprd03.prod.outlook.com
 (2603:10a6:208:14::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: c337423a-7e78-4ed5-44aa-08dcbba8ce50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEZiMExhKzZsR2ZNVHVlcmNEN01JVUNRaDQzTkc5SU92OVprYmc5ME9VVGRh?=
 =?utf-8?B?U0p3Q0lWNnNLdHk3eHJiN0dTR2dmK3dNV1o5YWtDZVA3TXdzSzdqUVlZMUFw?=
 =?utf-8?B?OHVTWWM1RHhRaFR3ZXNZZ2lzQW16cXN0TGdQVVoyajhvSmFrZDFXZWZNVmE3?=
 =?utf-8?B?OHcvRU13Z2tGVWQ5ODkvRSszYlNBU29CVnZOVzFhQzJ2SUY0dENWVWFBN2dI?=
 =?utf-8?B?bENVYWwwQ01mQk82TEQwdzJPMHNDejc2NjN1TkdOMTRwWjQyRitvMjBWTDJE?=
 =?utf-8?B?bWQxTDBFMkxmRnEwVjFDbHFGVnpKRnc1WXZ2M09JQ1pXMFEyWXdUeVY2dDhk?=
 =?utf-8?B?amRUcEpvYzFRSFZwaXVWSDk2ZE1iVmYyeTd6VGFuY0lMeWhQWmFUbFpuYXdt?=
 =?utf-8?B?YXZrUVVES2dMblZnejRKM1o3QWlUVUw4NFU0ZDRlZCt1ME5CMWNFTU1tZWNr?=
 =?utf-8?B?VnZWK0dMa2hYYXVDaVNiQ2xKN05HcmI4SmlYK2VkVDRhbEowSnY0NldRbzVz?=
 =?utf-8?B?Qys5VGRKNUVzcWVqSTVNa2FVWTBkMThnLy9lY2FHWXhRWm10RXJSbWRwK3dj?=
 =?utf-8?B?YmFhM0tDenFTb1M2UHNmdmhobUZrdTJOdk9DMkQ1eks3SW90eFU0M3I3cjY0?=
 =?utf-8?B?d0MzNWdPWTRBTGkrUlFvSlZQeTJMOTJqN2JFK29RTktLVU96ZFM0U0RnK1pG?=
 =?utf-8?B?dmFCb0lGSmExY2FieEdrU0lyL1lzVEdjVlJlOER4ZFlUOWhpdm54cllyRmgy?=
 =?utf-8?B?Q2laV2FYREcrdkdUV2ZZRk9PS2hRQmY4Q2sxdStEdytkQXNFRGhZWTU0eUFB?=
 =?utf-8?B?Sk5PUmNReTVINzUzb1NxbFNrV1pXc2ZZRzJJVUN0NTQ0R2RPeURQWmFNS3JJ?=
 =?utf-8?B?YUV3eVhPMW1TWUl0VDR3clcvclJjWHgwQUpXZUhEN3pPYndwek01ZWRSdllF?=
 =?utf-8?B?OFcrTjhEQ3BjL0pJcTF6OEgzVndxWTYrcXZaUlBtbUZ4alV4UVlkMWJiZnp0?=
 =?utf-8?B?cDZ6RXhFQnk1L0FvSzBWcm1xR0xUVy9SdG9PbDZzaGJGR2hpK1RZNERaUUZF?=
 =?utf-8?B?bXZ6UlREdGcwdGlzak5tZmx3ZytDakEvYkpweGJKdnRib09pYXhrbVR5UFo0?=
 =?utf-8?B?bUxLSjJhcTRTYTFWUDYxVXBvRHIvWTIvMFg1SDJwSWVBMFE4aFI1QURoczFC?=
 =?utf-8?B?K0tJUkZlczBWSzdmSnpjTzQzL1gzY0xGOGVqSkRyTERiMjJXUW1Jc0xvcnRL?=
 =?utf-8?B?cXNWRjNkYU9ybmJQSVdEYXFyb1V4cmg0aW9KWXZySVhveDhXWXpzbmM0ODZC?=
 =?utf-8?B?N20rUFNrTS9PTklPZjd6UXl1RGsrVHFBdjgzOTRoQ2daYUNJZDBXWEFxT3hw?=
 =?utf-8?B?dCtTbkdBZVFvUit6QmFkV0ZpYXQxS0wyUXpNNU9meWl4SGppcFgyRGVLRlFB?=
 =?utf-8?B?SWJXZzhFc2VlaXhBUkp0bGF5Zy9MWjl4Z3c3VElPd3A4TXc5dHRxNFdxUWZy?=
 =?utf-8?B?Y0UzZU13VTBrei9sVVBvTVZveG5CNUt3eWhLT2hjQU9YVjBGWmMrVzFzRUFu?=
 =?utf-8?B?bEQ5YVo4WnVrR0NIZDdtMk9tR2FxQkRIbmtBUVppUDA0WmpCNjBBSFR1VU10?=
 =?utf-8?B?NVJUK2RqTVJyYjJBUXVlc0lpcnJGNGNLODdWNzZZQmw5Yk5ZZ1pOdWdncFhq?=
 =?utf-8?B?K0RLdXhNV1ZkMkdrMjc2cmRCMlJuK01iY0pWeG12aGFDMit6WGxZUmdSSHJu?=
 =?utf-8?Q?e1QYFspFLL83FD8q1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmxJNXJ6aGZCaVVJN0VDdS8zNVUvMXQzYXo4dmVtRWYybFZmbkNtemNsQmkr?=
 =?utf-8?B?cVZBZzQxbHoyb0pKRFFEbzBkWUwvN1ZLelJ2ZGI1QkY1UXdTZUlVUnIvUFVN?=
 =?utf-8?B?KzlmR01LYlR6c1RkUThSbElMeE1RZ2dTekdiTUx1SkVpR0NzWWxkRVl1Rmc2?=
 =?utf-8?B?M1VyY3czaU96RFB1QUdzQUdoUlhZQ0Fockg4UGdqbUtqbWhRdHVtcnhTRmV5?=
 =?utf-8?B?SUVXdDdqVUQ3cUlvNGlsQzErMDR1MzFpL0dsc3RaV0dUUXZHQURWc2pTMXZF?=
 =?utf-8?B?UTlRWjdyUFdXbGdXZEw2TFUrRGwwTE5LYm1LMnVyWUc3eVVFNHRsWkhqU29J?=
 =?utf-8?B?R0kxc2J0YSt6bmowMUI2UkEzcjF1aVBmcUo0cURxM3o2MVBwUWhxdzRLWmMv?=
 =?utf-8?B?THBvdVMxZlVDeC9PalEweHp6ZHIxL3BUajl0TDJEbFJMclZFclcydmM3ay9W?=
 =?utf-8?B?WXduN1pjOTQ2aEYxVXZ2Rnl4R2YvUUlYUmkyY0Vta0xWUG9xcXpIQXN1MC9K?=
 =?utf-8?B?ZW03M1FnZkkraVROckxkN2JSdU5MVFBNOHNkYzBHYVhTSXZWSUF3czRtdGFz?=
 =?utf-8?B?MXZBUHFJbmNkR3N4dzFUclF1aWJway9zN2lxTHdUcVFrNU5EWHdhQXFVQTJQ?=
 =?utf-8?B?WWdxaWROWnZJeUFaWUw4WHVMbjU0UHJOSmxITUsvZGYzNWNpUmVyWFprYktH?=
 =?utf-8?B?ZmxXb2NnM05yYWNSU3RrTWYxd3hHWGg0ZWplcUhKci9EcjR6TWo5aXc0SStB?=
 =?utf-8?B?VFZEUnlacVQ1eU5rRDF2Q2pYZ1MzaHNFdFRaR3hFdlVKK2ZSa1k1bFZJNkRn?=
 =?utf-8?B?NTlndHNpd1puRDJJMm12bmMrYWJOWUc5TFNIdGRYaUp0My9pR3ZDbTN3bjBX?=
 =?utf-8?B?eTBoVWt6UmNFR3B5Ulhucy9NOC9DcUlnQURua1MzRUJxUkxzVTlEVi9VcnRH?=
 =?utf-8?B?VEJpRUlPNG1KRGtZOC9MMzY4eTNOT1Q1Mkgrc2hOaEhYWXF6Ykw0NEpjZFVS?=
 =?utf-8?B?V2llUWRLd21mV2ZUQlRQV0RuSHc2a2lXVDJSbCs5ZGdvYUtDUUt3V1NRSHZD?=
 =?utf-8?B?OGcyQWZtcmhicTR1ckJYeXBGR1l4YlJQcXFad2FDR3pNSjdma3B3eFdZcU5h?=
 =?utf-8?B?c2xhYUsyQTJhSmw4bmdLbXp3WnQraXpTaGpybEV3RjNDQlFNbG9mZzQzWEhM?=
 =?utf-8?B?cjI2dE13Qzk5NUZXRTVETUxUaldJRFplK1VGT2VDMWR2RlVmZHpmWmQ4eDFu?=
 =?utf-8?B?K282R01pUzJCRUZ5L3l6aGQzRndYNW84MVJ3dXVhdktpM2R1aXdEbEVTVkt0?=
 =?utf-8?B?V3VmaW5xSkpPTWFvSmZ4SDNjWTg4ZmJpSnB3OVdkRVpteXpHQ1pXN0NnNTZN?=
 =?utf-8?B?V05HcjJYVHY4WGRQTnYyYnlydzRjNldQV2xZNmtvdWVyZm94RnY4Q0pBVW9P?=
 =?utf-8?B?S004d09zclpxR1hpNFdZdHoreWxlZWU1SWFOb3o1cWlVSVpHVUQ5ZFF5RU5k?=
 =?utf-8?B?cTk5dU9ESUt0T01HSEQ2QUlIbmRKQWdxbU5vSlk3dmovU1J5VlhHemNsQ0ov?=
 =?utf-8?B?dDArTXNyNkRoQUwxM0p5eGhQa3JGVmVEaTlTdUlhTDAzdTFYYXVaOUxFZ3dF?=
 =?utf-8?B?VlpQN3ZKT0ZaV1prS21IQnpoeTcvTWZtd0lyaG83T3N2MCtvSkZrSzk3ODlW?=
 =?utf-8?B?YXZudzJBZktqM2RxWjJYdVBOVW4wTFgrTE9Ydk1CdmFTMGYzK0w0MUROcGdG?=
 =?utf-8?B?SWJGOURwRlA0S29rdGljWnB4WHgwOEtOYU1mTzRibHdjRU9VT0JaZG5EZUh4?=
 =?utf-8?B?MG0yNGFxRlJCV0RsUCt5aEZydVdGZHAzaGhEMndxUWljYS9nVHhHZlUxNXJK?=
 =?utf-8?B?SWloODErSW54eGdneXIzWlRLK3ZNM3VIUGlOQkZZcTVVNFQ4TVhrVTVUME1D?=
 =?utf-8?B?eGhIOHM1RE9jN2lRRXBBcVVZQ0dZNkhkVjltT2R4akVkRlJQTFZ5eTFMeFYv?=
 =?utf-8?B?cWxWbHBLOGRBbjgyd2UxQjF6OEpJVDJsUDZ3dmxpekx0OU41YmhPTjB3RlJ3?=
 =?utf-8?B?K1J1eUk5Z1FUQjNNVXF4WTArVlYyRlhUZzRkYTNiRVlraGdzdjhUREswaDRt?=
 =?utf-8?B?c1JLZWNRRFY2WnVYS08waUxNQXhadVZtNTBxdXA0KytWSGtlTDEycVlUalNZ?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mncC5vKhIk+ZyXN8GLeTR44bdrrBKWm6cEtdvMJmIqQqI/DFRJ0scaHZQlS8gPZFs/Om7jo5MbL+7XVtb3SUudVNinIvTbLFdflzOCOTP/2dD5628R4GHx/9RqD8W2MCKZSOTnod2KDzP+022BnwtEhmimc3b48Kv5M1wmvn6mgSP3jAfnbR3GdDrTxPA8J6X2//PgYBSZZwqz9Jp0ID15/Zo2pwOvumELRx0aaoEhwLpQrOXEy8mpvkX5ASaMHpREtwCD13dyO/5Y0nmgCp70soEAhwtptXc+rO/AoEwIt2AzUQuLjPOG4JDsyIN+Wh6aM4tsq0h4li2uvvgRdsP9NFGhKjHz0h25JBKHRoEytOcmjQeobhqBMwQkZsGyE6iFYwPfCvAC0wn/93oeYgm/6NEAlQFiubpye3r+Yq4G5yME7XLDwnazbGaEZcdrpYb3vn9eUDDK7BqVLkCgwaJGPVIWN1v+UODCDirgm/EGSs+EKoFUgxlkl/DZdccqo8CX44WRc9MwUENSb55/YLz96w5ZdsFD5Ztahx7J1Te+iONyKfuOFhgaM08hzrGtkoGdaBvK+rVsy8dFZz5s68gMyHDNcxKl5daSKCVKnqrjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c337423a-7e78-4ed5-44aa-08dcbba8ce50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:01:27.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jF0bmJR/O2/JMYt6tKKnhbj5IvF66ZE7ESdJ7CGIjZpuW6U3PcJ7EucNiaZ/J4w89zuJ1rw4W2pUYQfG7XLGGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130108
X-Proofpoint-ORIG-GUID: 3twLnQVT51eMNA8jxXX2qR_EEc1ny-va
X-Proofpoint-GUID: 3twLnQVT51eMNA8jxXX2qR_EEc1ny-va

On 01/08/2024 17:30, John Garry wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When we do a large allocation, the core free space allocation code
> assumes that args->maxlen is aligned to args->prod/args->mod. hence
> if we get a maximum sized extent allocated, it does not do tail
> alignment of the extent.
> 
> However, this assumes that nothing modifies args->maxlen between the
> original allocation context setup and trimming the selected free
> space extent to size. This assumption has recently been found to be
> invalid - xfs_alloc_space_available() modifies args->maxlen in low
> space situations - and there may be more situations we haven't yet
> found like this.
> 
> Force aligned allocation introduces the requirement that extents are
> correctly tail aligned, resulting in this occasional latent
> alignment failure to be reclassified from an unimportant curiousity
> to a must-fix bug.
> 
> Removing the assumption about args->maxlen allocations always being
> tail aligned is trivial, and should not impact anything because
> args->maxlen for inodes with extent size hints configured are
> already aligned. Hence all this change does it avoid weird corner
> cases that would have resulted in unaligned extent sizes by always
> trimming the extent down to an aligned size.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> [provisional on v1 series comment]

Note that I marked this as provisional, as not all questions were 
answered from v1:
https://lore.kernel.org/linux-xfs/20240621195058.GS3058325@frogsfrogsfrogs/

I plan on sending v4 today like this, and hope to clear up any 
unanswered questions then.

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index d559d992c6ef..bf08b9e9d9ac 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -433,20 +433,18 @@ xfs_alloc_compute_diff(
>    * Fix up the length, based on mod and prod.
>    * len should be k * prod + mod for some k.
>    * If len is too small it is returned unchanged.
> - * If len hits maxlen it is left alone.
>    */
> -STATIC void
> +static void
>   xfs_alloc_fix_len(
> -	xfs_alloc_arg_t	*args)		/* allocation argument structure */
> +	struct xfs_alloc_arg	*args)
>   {
> -	xfs_extlen_t	k;
> -	xfs_extlen_t	rlen;
> +	xfs_extlen_t		k;
> +	xfs_extlen_t		rlen = args->len;
>   
>   	ASSERT(args->mod < args->prod);
> -	rlen = args->len;
>   	ASSERT(rlen >= args->minlen);
>   	ASSERT(rlen <= args->maxlen);
> -	if (args->prod <= 1 || rlen < args->mod || rlen == args->maxlen ||
> +	if (args->prod <= 1 || rlen < args->mod ||
>   	    (args->mod == 0 && rlen < args->prod))
>   		return;
>   	k = rlen % args->prod;


