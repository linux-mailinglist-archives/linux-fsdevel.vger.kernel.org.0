Return-Path: <linux-fsdevel+bounces-37351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F109F1426
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325DC16A089
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65F1E571B;
	Fri, 13 Dec 2024 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jkHoEITX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZQRWJPqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37817B505;
	Fri, 13 Dec 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111806; cv=fail; b=XCdpRrK+efSp0DBFj26zEwLZUkScMv79V9U4DuYdOKcOmMjhQHs4T4nmzq+2W338skrSXEzBrB1jK2wLS11HzefIpa082Xlha2ScrgVr7OYMPO2J/7h/yV5Lgyni/ko+fJ32Hv5+Vtz+iYzMPxhhiMJvw1fqTl7nMVl3vbIIWuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111806; c=relaxed/simple;
	bh=hxi0aPohnW4QIQ84Uw0EUMxTp4Dr5sYvOFWw68q2FMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HP3mRICKtXSCy5VCdgfH50ULp9i5bs8WoJoHWGJQsPcz51xByFpCIWbHhcFdvcaJ6uwDubA+oBli6VTZyFEeYh/8ftrCVeSSHVSiF+BxRsAiaUTcj27gsyeO+Bs/l7FO7+pnArLbUFXCWsNdaCwaprWrKfjNaaiRIp5P1fUr2XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jkHoEITX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZQRWJPqi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDjr16019430;
	Fri, 13 Dec 2024 17:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zGMYZ6q7sXwZgw2snbo5xubpBFbVWX6Mv+ON8ElFMw4=; b=
	jkHoEITXrjEFIwwQ10B01k9x+z528J+fB+vbEeYAV8zI4MOmaWmdpixZWGHhx36e
	2fC2q0t//fOZYIWDy8tKg6u7CARFkwQ1pD0Rrp+dNZYHj+yaXWYibSBJlowq4Jr0
	mxtKOcdYiONMeqbxgVBSJy+uK58Pu6LLXOkKuDmubhcTOiKYCujJgbtpnoQn7uV4
	s8c14rWx1qNQhfvoUaSWD9u2rmVZ0sRVQr2BJNDcTDbnvmSCEhJxopef17e2u1XR
	HIUcCiJk//7CuXhFCzXs3i3vtCxZ84XgeavNayn7CiupaSkSa2njQDYq11xBQGoG
	ZAuW0yXv2L/1+z6Ech3QaA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedcdypx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 17:43:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDFtDcO019330;
	Fri, 13 Dec 2024 17:43:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcy76b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 17:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCg38/+inilbVGXd9jjSI8zBHMdU6ymRZuOOXMaD+7cu7I868vIUP04FCtK0WvfAF68Oy5rq1S8EJ6JHAScrOWf9d4tyg2/EuBDvTHcC1NRICEAcjynl3/01TfOb7eS3158uTpPQ0kSMKa8J0BwyI7DOS/ww+55U/4xYiiYA4twGhsJ8XXkjhYYkMJCrig9VGhTVkIQGsS5MwqSvnJz+WTlRk6h7FqRSBqCZ9OxK7s8+Shg0MlaoV7aXTiyi+Nxzyp896JoxobCmllxWTboVbtA1MEotzwXLjwwffkAv8OY/E0pndCuVtlJgYGiL74bbJ26k45qdmAv8A1hTQdJ/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGMYZ6q7sXwZgw2snbo5xubpBFbVWX6Mv+ON8ElFMw4=;
 b=oRR8+vuCTF5cM3Ow6BMFUGKrQFFdU7jJZmxUACrdxBYfV7MtetpXv0CSVIM1WmJTpB0IXkGed2hDNM/qWlddldaJPEj75u/5txWRJnCjxKJHbhhn4qbJk591dKrjUy1IkBRsMH74h/amh7Ze1w6yOPX+B5WlvdglEHEozEFQXAycfIYxzmQ4/gn+wfmsbgDyVU4RYbnq5KkyxK8fdU3N4vjLUCSer9G5RvDhqo3FYofMinY/YGJthBxqN9ikK7sdwaDoBxsuZMDu7eQYJvEy9SxUmfzkUVBG9z62pF56r9rObOmJXTsKijRWuIz7iET9S5+6aujLqFmYfAyDhPhFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGMYZ6q7sXwZgw2snbo5xubpBFbVWX6Mv+ON8ElFMw4=;
 b=ZQRWJPqiIOCOXoko9JmNLywm9Z69gzcQIWP/Aq26ayN7+NWLOhu2dt4Nf/I3DPg1TeqK20RVxQp9nktsbQEfbQmgeWR0Tb1dr3GFwiWxgQLZnJZVA6L6+vD1HNGtgvjLrVHRCCg9mrrcpwzG7g05heJHSG9XXL15ZBYRLfB0Xcw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6656.namprd10.prod.outlook.com (2603:10b6:303:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 13 Dec
 2024 17:43:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 17:43:12 +0000
Message-ID: <9e119d74-868e-4f60-9ed7-ed782d5433da@oracle.com>
Date: Fri, 13 Dec 2024 17:43:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] large atomic writes for xfs
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241213143841.GC16111@lst.de>
 <51f5b96e-0a7e-4a88-9ba2-2d67c7477dfb@oracle.com>
 <20241213172243.GA30046@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241213172243.GA30046@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d61ea72-54c2-4ed3-81b5-08dd1b9d9d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmhnOUNCNDRDRkVqajI4S3cvN2NmUGQ5RG91YllCWTVJRjJkeS9iaHNIRGNj?=
 =?utf-8?B?WW1WL3JLejVSZkQ5QkJRVE8wVG0rU2pkQi9NUkNWYS9wK2UybGNmcS9Ja0xs?=
 =?utf-8?B?WTNFRlAvL3J5YnZiVXczVzhWTCt1bkNXSXVmT0QzMU9RMHgvR3dDQy9LVXB4?=
 =?utf-8?B?T1FZQ0wxM1ZvdTViN1BlRlhvQUl6YWF0RSt1ZXEwUmZkdVJ6WmNpMk54ZFZF?=
 =?utf-8?B?dENOSVVycXNTd1pwMTRiNGtoN1FKTTNCMkxkRXVxNWdWY3IxNXJjVjh0ZVBi?=
 =?utf-8?B?SWJmVXZ3S0ZmOGxFcXl2ZStRbndnaXZHRjc4emZUdmdhRHpVb3NFSTlUaGd3?=
 =?utf-8?B?SlMyNHZyaDdGUG5XY3U1bjNJK2J5SEFLUVh4QURJdWxVRG1MTm12YXQ0NFRk?=
 =?utf-8?B?S1RUYStSUWVvY0tBekpwWTFlS0pTNVJzcTM3UjBIY1ZyV3hOYk00SHhrK21C?=
 =?utf-8?B?MElZUUZ4ZmJXdG1Qc2hxZTNyZDFJYVhCcVlvUTROeGthT015RTczS3BydjMv?=
 =?utf-8?B?VUpCbVI3MXQ0ZXRoeW1DeTJENVRIWlFSRjdMNGFVWUxXSmNuemlLSkZCVWZz?=
 =?utf-8?B?WElRanZ6dVF1aG5rM2FuTnBCRHlLVTRRWmdFS2lUdHYrS2NOeW81TVhBTGFh?=
 =?utf-8?B?Z1UwUHJUamxRRUROWDhkc2Ztd1VuVHNRSGdxYU92OWUzR2tEcVJrOFFoTTI2?=
 =?utf-8?B?dEpqcVBZSDAwbkxzazVMT3RlTUV5c0tjUEJ2V0k3OEpxbTV1amlwUllBQzN0?=
 =?utf-8?B?NldrL3lSZUR0OS95RUtwc3NEUW1yMWdNa01tRFB6NU5OOHlkM2hoRWc5OVA1?=
 =?utf-8?B?NnJ6R0VSYlh4M2RTaENETk5xSjJqclB4U2t1NFFSUDdtRXRmRUNLZTdEWmlo?=
 =?utf-8?B?cUFWb1JWenBMWkhWMDd6QklybEk5TmV5c2x3SndUbklZejZFRmJrOUhZQnY0?=
 =?utf-8?B?dFQyUmFkT1pmaldIMWIyQWJLUkJkVkh4QVUxTnRocE15YnNrckc2aEJBVnQz?=
 =?utf-8?B?ZTI5WU5ab3Y1b012d3pXZWszSUtsYVRuRktoSU1XYzI0WGdzb0RRNXZMT0Jz?=
 =?utf-8?B?WmpXREJTd1BmaW9YMmJQMzRkSWNuUWhBNlBrdjkwWVlxTGdKU3U2K0V6dWtT?=
 =?utf-8?B?QUNMS25EUzJUSFFTSHdlc0FyQjY3SWVrMWlrdFEvZHhkQ05sOVZEa1FQTHhK?=
 =?utf-8?B?eDVjb0hWRXlMOVVLLysxejZHZHNWQkhsampodW90YUVGaTIzcVZVRXVHUUxG?=
 =?utf-8?B?WFJIZmlqanFpMG5YdkVpU0E3YUlkM2dhTEt3c0dLZVM3ZWUyV2JoZ01ZNGtx?=
 =?utf-8?B?N3p6dVJQdE14ZmxTN1A5bVRDVW1QSUtoL3ZPVVV1aVhEQjZvdlcxeHpGN1U5?=
 =?utf-8?B?M2dCTFB3VUphbmtEVlBmTFg5dmJGNzBVRWltY0NZSjdPY0JJZDIzUGRBazFm?=
 =?utf-8?B?QTVHRHAxTWhWS1ZyWTVucXg2ZTdQU0g1OUFXMEkyWGY4Zmdwckg1SWEyMnpK?=
 =?utf-8?B?WnRPZEtxVFZoaDNPN2NBam0zdWxGY3ZVOWc1eHdUTW9obEVaeEFhSEZ3Z01W?=
 =?utf-8?B?NEIvZ2Q0WDNSRjdkbG1CL2ZxekcyZmxTZWhyVjZIaEovbjNRZXRvZEZsWnJu?=
 =?utf-8?B?WTA4YWI2dFdnRlBnOStDV3E1cUpnTnVqckptU0dNQlBvQUhJbWFjUmwrZW5q?=
 =?utf-8?B?UGlCdlh6ZUxuZ0FnQVh5Wms1aDhQM2s3SEhVWnlmbHd3YVJtdmc2U09aREpk?=
 =?utf-8?B?THJZU1BHNEdTdDRmT1A3V2psQStneG9NYk9yVlNVa1k1TzZBdGZyVEx6eCtD?=
 =?utf-8?Q?rLYdlZdezCKDHZ/IkOB66UwjwgtfOuvlJICwA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEcwczFuOW9aSXlveTYrdTR5cmpZd1N3TzlvYllnMXJ5TzUxVHAybWs5VERN?=
 =?utf-8?B?MWtIQkxHZlFPUWs0Z3YxQTBxMTkySTlUSkR1bEtuaHI4Y1RXeFQ0TmVZWWg1?=
 =?utf-8?B?b1NnbFI2dCttTkZGTUJmaUthVlFtN2toZHAyV3ZJdnpIaWZRTVJlMWdLalZw?=
 =?utf-8?B?VW5TTjBuRGhBeisvTC9tRGVQVHRvKytOU3ZsRFVSZG9ncVRIbmQ3cWdQMHVa?=
 =?utf-8?B?a1pCNXc1cEp6UGFibWMzTG9MYzFSekdSQ3ZxV2M0YSt2MzdJVGFCSnAvcjV3?=
 =?utf-8?B?TC9LRWhGOW05cmFzWFZaa1RCa3hZb29WTTE0STcxS1Z4cUFweUc2WmNVQXVk?=
 =?utf-8?B?NDJqZVdrWEtMdXJ2UDFwbVRzZ09KNTJGckJDeWx1RTFVOCtGbk9WMEN5U0pS?=
 =?utf-8?B?ZERHMUNyR2J3MEZ3UWdNZkxaVU1naTFYREhNWmZLZlgrN3NOYWRmTElZWTY5?=
 =?utf-8?B?bmxFeHJDUnNBV2FKd1dxN1k1elE4NHpYUFIwMk50ZGE3VFdmL0EvVE1vZDJn?=
 =?utf-8?B?RmxlL2QwOE92c3dnb1NJZlBDNFJrRUVnN1hVOTViSmNXMW12K2c5NDQ1MGMy?=
 =?utf-8?B?NHBBZDh6OXRuQWt5MUdnbXFwQmErcHk4b1lnMDBzd2NWSlVBNW5jSnBqMEhz?=
 =?utf-8?B?T2NyME5xWTI5Q0pWbkwyVWhXTWUxQU9MRVVkRkNFV3kvS2g2OXFmZ2ozYVgz?=
 =?utf-8?B?SStBczdxemkyK1AwaGJKdk15bGVwRGRCMm1TWUJaUERnQUxLZmZnMitvQVV5?=
 =?utf-8?B?d2lSb204eEJJREpIV2w4aFNsOUNYejd5WU5nTzFaaWVyNXplc1Zlc3lQN2o4?=
 =?utf-8?B?MHJIdEtXRm00aTdiM2h4RUVCZGZFVlRpZllPNlNBVllqVDAzVmRZQVZ6d3R4?=
 =?utf-8?B?Sk9TY0VGNFgyTHhxVEZ6SFRtMm1rZXMxMTFRUkVJa0M5NGdvZkJoaVJmMlMv?=
 =?utf-8?B?d1R6MUp1eFgxSW5sVVk2eFV2YTJEaWs1ZkF2ZlJsVW9nZnk5ZnVVQ0IvY1JX?=
 =?utf-8?B?NGlyWWg5b2ZOcU5OUm5sc3I5QmR5bDFSVWluaU81YjFuZm5CWVVOdWF5V2M4?=
 =?utf-8?B?NDY0cDZTVEN1dG1oSDVTTndYSm5qWjVKbHljbldBUi9ESUJCU0hRODlhcVo5?=
 =?utf-8?B?Q09tOU9LTFJodjUwTFgwWFhMVWpCOXl0Sk9QbHRsZUpKdWFhTHhvODRSSU1z?=
 =?utf-8?B?SjFUVE02bE92SnR1T1Y2Unc1RUlrZVZWT0ZsSk1WOElVTDBhcnM3aGFjdXZl?=
 =?utf-8?B?Skk2ZytpRkc3MDBNY2J6TTJEdGZJQWt1NFNsM0d6L0ZWYjZOOEFJUDhhaWdh?=
 =?utf-8?B?OVI4aU5tSmxVcDVSSTB2YTFNSXYxd3ZjVVkweHJpdVRhOG16aWhWREZmWXR0?=
 =?utf-8?B?NG5XaHlZcjlxZ0JPY001RXdMVkZFVW5FdTZ0Qng3QktMcWUva2s2RlhrSWx6?=
 =?utf-8?B?WnpLUEdNWG1scWxya3RJZ3hNcGtYcVU0UEczRnpxUE8xUmExTGhJck02NTl6?=
 =?utf-8?B?aUlTQ0x3bE53NWpUdDg3YTlVVlhqV1VDTFJHL2FmYjhBd3pQeHc1OEpTZG5k?=
 =?utf-8?B?ellqWkxOdUFpeWhoQytZQWxzT0ZhNDFxeTl1UnprdkJNaXRsbDZLMkRCanRi?=
 =?utf-8?B?MFdIdnBYeUt6TnE0NWZoQ0Zpb1c2S09aMTFVN1l5elBTS2JqMFhVcm5BRzVm?=
 =?utf-8?B?U1FwZ293bjQ0Ry9YL2NZb1Y1L1RSb1FyNnlVZlJTUkdrSUlmQ3BKbmJocnBV?=
 =?utf-8?B?RzFkWFpxWnA0WDBidlVQTGhXSDFDRmVTSmJxeXBObktaczVUbEcxZUZLZ3Z4?=
 =?utf-8?B?RjVVL3NUeDEzRmppTW5sZEF5d3RzZFpIZkh2ZFFSU1lkN2JQamNzSXFZS3pW?=
 =?utf-8?B?cFI2a2x3Sm9oN0g4Y1VodDdlS2RJaGtxaE5oUU5IcGZ0S0F6Q2V4QWpaSWUw?=
 =?utf-8?B?Y2o3TmJNRkNRSTFWd0ZMU2xqODJUb091a0ZLZDMwYktVUWc0V3lYMUswRUJ5?=
 =?utf-8?B?c2V3V1RYSkZRejNSSGhZbG1VbWU1aE5hRGxOOGVoZEJ6K1RrRkZvR0E3UzlK?=
 =?utf-8?B?S1ZSc0l3ek9GMTU4eWM0T3d2cXBsS2p4QUYrTXRwRkxOd3hqQ0c2TmplelAw?=
 =?utf-8?B?UGtGd3M1TGZnS2g4RnlNOXdlYWdLQ0pBYWJ1RXBpRjhraVJJQnVBL2xUYis0?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qEIhILBG6PmC791aePSWcZJ4zyctUeA5Z1GEnobuF1ePHVmqkEZwtg2J+GBiEjIhk5le6UOC9uHh2oRktAG8+CN1zmmwQIb/vU2Xz8vkRsRfi+XY02zBLpifE48SKhYbEHGotb4FgoA38Ej07OovArNHlQHNZkUyHgatS0oFPBS7JzgE84T8DhVBFDHVRMnZ9m8mSh0k+uIuaY4VUUPu/TJqzCkMZrN4kfxM4yy4BX2APn/rH80AWV8LJ6Nu/rKhDrryKFHRzsouvsufVycipZYSvdIVP5eh8axbp7ubka82CMznU0M6MX6HQ0J83qGZ8+0pyFqdJpvHzgorYYJjmHMqhhvMVvkG7qeMSdP+TJEFb3kcHXIaCVvwz9wVKsni5u5CXBZm4cIQybS4OV2rCzmN2/TjmnVF26pQmSrgTP+RfwNJfVd4OHkq0yxHnaXQWgI/s9xg8MDQ5UjvdzqFZKUtqXsofcTqS/9UkZTMLnu9Lx1BhtvfZxqf+47ouUAp3aBEeI6Xi1u9xJkV3aB86uOVPUYdysQ0WmgiD/1Lvv8LpJ/XtSTc1XWwFHiYihWZ6oHHsv/zrGzj/fBMLjoUtK5G0cDHvsye1FozaIfsUzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d61ea72-54c2-4ed3-81b5-08dd1b9d9d56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:43:12.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOjkH2RcZ8/IA+F0G65mvUK+UmvW0j14YasefHb3ek/3ScrX74uNhzJe0R1WivUSbiZBTjM+jWFnMw3t+KDB5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_07,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130125
X-Proofpoint-ORIG-GUID: _t-KJMBDIf0-PZ73R4xBsLmtRJqFy2JE
X-Proofpoint-GUID: _t-KJMBDIf0-PZ73R4xBsLmtRJqFy2JE

On 13/12/2024 17:22, Christoph Hellwig wrote:
> On Fri, Dec 13, 2024 at 05:15:55PM +0000, John Garry wrote:
>> Sure, so some background is that we are using atomic writes for innodb
>> MySQL so that we can stop relying on the double-write buffer for crash
>> protection. MySQL is using an internal 16K page size (so we want 16K atomic
>> writes).
> 
> Make perfect sense so far.
> 
>>
>> MySQL has what is known as a REDO log - see
>> https://dev.mysql.com/doc/dev/mysql-server/9.0.1/PAGE_INNODB_REDO_LOG.html
>>
>> Essentially it means that for any data page we write, ahead of time we do a
>> buffered 512B log update followed by a periodic fsync. I think that such a
>> thing is common to many apps.
> 
> So it's actually using buffered I/O for that and not direct I/O?

Right

 > >> When we tried just using 16K FS blocksize, we found for low thread 
count
>> testing that performance was poor - even worse baseline of 4K FS blocksize
>> and double-write buffer. We put this down to high write latency for REDO
>> log. As you can imagine, mostly writing 16K for only a 512B update is not
>> efficient in terms of traffic generated and increased latency (versus 4K FS
>> block size). At higher thread count, performance was better. We put that
>> down to bigger log data portions to be written to REDO per FS block write.
> 
> So if the redo log uses buffered I/O I can see how that would bloat writes.
> But then again using buffered I/O for a REDO log seems pretty silly
> to start with.
> 

Yeah, at the low end, it may make sense to do the 512B write via DIO. 
But OTOH sync'ing many redo log FS blocks at once at the high end can be 
more efficient.

 From what I have heard, this was attempted before (using DIO) by some 
vendor, but did not come to much.

So it seems that we are stuck with this redo log limitation.

Let me know if you have any other ideas to avoid large atomic writes...

Cheers,
John


