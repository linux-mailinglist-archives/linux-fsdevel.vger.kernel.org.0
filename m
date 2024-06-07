Return-Path: <linux-fsdevel+bounces-21206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC938900662
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B4B27E72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0134C196444;
	Fri,  7 Jun 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TFRlf80Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CN8qHcXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4A1DFC5;
	Fri,  7 Jun 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770253; cv=fail; b=ch5rGIXkFu87gG0QtsubZrpGlF1xIUkW3xtZIqqiHyyJl/RvV48vXKDDGlSGxJzQfFYAQ7TB9NcR6MGYimSbfJt+3Ytvw9eRe13zpVyGhm0BE37Q3SX94FdnMlDLt49YoWDyY2eRMuBkL9JEcCwvJBQAXyBp3Ij6DCglViJgZfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770253; c=relaxed/simple;
	bh=mQRx2k+NSN8uXaEdc6XjB9QaAQ8Nlfm5rQsikaxXF9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ewp73uG0HmKUiP5yzNFLS8bEmUQe9JJJHQj6W0Fox/lyKvusIkGxvIGnyXZF2Vifdg+whIZafHvMNwo1BfecOxNrKNP3fIBMeJq0n1RO1ED2NaaYwO/efF3fqJFaLmeuoZ1CuwBJA5JZyByiEyWNHwRnvw5QxwDlNQ6Wi7kLTrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TFRlf80Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CN8qHcXQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuhWs009446;
	Fri, 7 Jun 2024 14:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=lOXaNAaUnPK8S+zMLxtdqCPVinPTi6JxZrAyG4Js4VY=;
 b=TFRlf80Q2ZNIIXqPjeuTLLnoIKex8p9DHyU1Qzxopkm3I/Ol/NRdlZVV0+lGYYoEkegn
 M0ctZjsZHHjxsC48zn5RpBVxOApSG3hsnQwFNHS42uCMPjR8Xi4frO+Wy2PjM725Upeh
 PP/Z+VEb7N/kMViQLPolAkZ8egz1mcoqd/O98UoS92ID9zvenYxyJkrDMzT1F+GXqpEp
 fo9SnBWpfxwKRR5LRFghfazZfQsn0HsUysE5I+oDfrBPZhjIZAVpj4Rm8xMKI7u5tkDs
 p3tHs3BCuJCUI40+UdgpxuQ1sgSlqBbCOgsYHANf8lMjKJBOFR/7r18giUqJm47IzJrX RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwdrfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:23:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DEJLa016183;
	Fri, 7 Jun 2024 14:23:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsehvg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc2AFQXE1Qkcj1y1UJ/RXne5Zz6YkjNS/kAZy6guXCaadmp43BkTLvgqtD0swDJPrI9lKDWgWt6ObTBgt+t9biLRYXpLV72swaAqisxibKL5FrMydmt4PkJW/ltLkrBTiZkLpenfjhnMOObTGqq9zAfqoWYktbE7+O/3tgtQqvNOqS2jElqtb4JMIXRjsOrAFeAsQgaUpKVWrO3NTzN73gTft2JDtnmzPcV/ybLg4Oh1Rm0ZJWHqleE6Ixc4AlF79w0btkqs+YFxWam08XX98Aa7XLF4LEppSj4HWFYtTHm2loS25bpe6Wy8d/7m/Kd3jLZuzR24Mm/i91hgK9wJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOXaNAaUnPK8S+zMLxtdqCPVinPTi6JxZrAyG4Js4VY=;
 b=Gqun2WnVsvSGF/4kctozkhnyYNUP9OJ7fx1MW8APoRNUtKhH24ghY3vYe/n4ci3TJIxmJ+Ia7Dqo420zSjGt/K2oMxbwsQA2fuS3WdJ643OH2+YKmYGZIm7QmqBeO3KBrenkjEknlTGmrpJSr+04t0kAjxKS0WftjF72EKws5ewE+/lWe5r4SJEbxmYcOqLwgZpOR8En2NhAJo/BMpALjM2cqQQNc4nW7PF7crVCrarN3gNWL1bm3YxJFDLBZwY7y/HsXkbkSmDtTHY8ZFq1F1hNh0Mb2iNmCfS9I6ooBek2S5pys3KEyLyDedJymPk2fBBNHUF3B2M5272uI1ZUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOXaNAaUnPK8S+zMLxtdqCPVinPTi6JxZrAyG4Js4VY=;
 b=CN8qHcXQK+h45Du0V7SF8wXVq2j60HW7uLpEkRI8UJv7nT8H8/hPIZA+E4d32L+ZgseM+HDK7Z02+U4MWXCNmERtkGEK0wh9Q1O54ZM/c1zp9ZxqBth7H1w9Cn7ObqVB9GFDFQaqXzPIqDfpvjW00T82scxKtclG0yNdZwAQ4b8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW4PR10MB6322.namprd10.prod.outlook.com (2603:10b6:303:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:23:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:23:37 +0000
Date: Fri, 7 Jun 2024 10:23:35 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] mm/mmap: Split do_vmi_align_munmap() into a
 gather and complete operation
Message-ID: <cpufg5nonojewqgjjjzyyxhkrxxenwe2vvtakvcbe5oleym35j@yzwccr6qim7q>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
 <20240531163217.1584450-3-Liam.Howlett@oracle.com>
 <CAJuCfpFDW-=35GyRikn3-yZPPrKx_aFbaJj-yFqGut4dJfCsdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpFDW-=35GyRikn3-yZPPrKx_aFbaJj-yFqGut4dJfCsdw@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW4PR10MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f67a58d-ae68-4e93-3736-08dc86fd6bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U1dacFNEaW51bmRxNzRvUzBBS3lVVTFwckV4UzJPSWwxa1QzWU5LdE5lOFJT?=
 =?utf-8?B?QmVab2ZaSm5Ma1gvVHRBMEsvVUFVUFBFK0w3anBDZVQvYkJjemJhbmZDMEpF?=
 =?utf-8?B?dTBleHhJY2tXVHlYbjlGWkpaeG5mRDBVQlBPYmd3QnFpMjFvd2cvUUZOd2JZ?=
 =?utf-8?B?dHJKQXBDTTJFMU1lTHpiVS9GaWFwVlFtcFZnaDNoYlA0NE9vTFpZWmt6aWtq?=
 =?utf-8?B?L2lZRVJpN0dkYzdTeUVZS3VlVDB2VEpISHA4cDR2Q3c2YUhMcUtiY2xublJ2?=
 =?utf-8?B?SndzL0FBVUxuQk1JRndiWVhKWXZjYk41azhzWEFZRElLK1pkTkJiNkd5VXRm?=
 =?utf-8?B?MDlYZWN4VWJKUHdzY2FyOEFsdE9heGp4aHA0MlBqc0ttS2R3bWQ0akNLNjM2?=
 =?utf-8?B?SlUwVFZHNFhGMnJ2c1RPSThUN20xbzR5SUFZV3l2NklUUzhNRzl5RnFBMDFr?=
 =?utf-8?B?VjZZa2ZiRW1kRnR4RmVxM2ZuaFJrZ1BGUDFrZ3NVZmU1cG9HYXkrYjNnaWN4?=
 =?utf-8?B?Zll0cnlYMWZxTWcyczdzakxacGxOelFibzhTazZ2UHRlUlQ1K3VTdXBFKzA4?=
 =?utf-8?B?dUg2cHpXRGpMQUorUjZSL2kwZVJLR1dHMGtndGZudGJNcC9Qb3RFdDVuVlRx?=
 =?utf-8?B?bFVvbzFYWlgrTW5IUFd4QlJjODNRYmc4OVJVL2k1UkJhbE1HUTF6OE1sUVNs?=
 =?utf-8?B?NmxrczdDYkwweDlPbkNIMm00aW4xb203RVJrU3g5TmZwYlFjN25GY0Rmc21K?=
 =?utf-8?B?UC9URnBuR01Sd2tocFU1UHNDUW9maDBpQ3FFU1RHWDdibzhsa1lrU1NNZVVu?=
 =?utf-8?B?VjNOWkI3V3dtWmFObXZGSEVKUmkrOE5CL2MwVUtGVjBxWlgxbGk3L3NBYlBw?=
 =?utf-8?B?UlZReUtubWkwaDhYUm5tQ3ZsdHZDQUtrNU8yV0p6VnFOYU0zMXEwM1IzQ3FT?=
 =?utf-8?B?M3BKUE9KZHdkWTIzSTRoNmtWU1RoajFRdTliYkpUbHhKa2Q1R1FTSjBpcm1j?=
 =?utf-8?B?TUZrWm0zMkE3VTRRN2NFM2FPTTh6cWQ5ZlZiSWZTdTlMVXpGTm9kdnYydFZ2?=
 =?utf-8?B?cWI3NXVVbGdNK0dSK0VLL1dqM1pvRU5TeVVzOUk0QlZ2RFF6T3ZrQkRCVDVy?=
 =?utf-8?B?emh1Q1BtaHUxZUNldHBLc2IwM1IyRGJRU0JhcWJ4b2hMc2lXZDdlUW5xSVNC?=
 =?utf-8?B?dDJxRWY0c1NwMkh3b2JCTEhEbWxxcTNnQUVOd2ZuOU5FcFhuaVl1UjZRQXpP?=
 =?utf-8?B?aUhLc1RTSWIwQUs1bjlCYWRTQzROQmR2RWw3cnVBSjdWWkJuL3BKQmtNK0lX?=
 =?utf-8?B?NWpQYW0yQ2RJQ1N5YkY0THNDUnJhNzlQYnhsemhUWk5YcTFCQ0o0dGIxYjFq?=
 =?utf-8?B?UXhqTmM5ZzNMZUxYbG5SRW9WekRndlJDeWFlY2ZrV2hoMlNiMVVBWWNPU29U?=
 =?utf-8?B?N20zV0VhWWdkSXQ2REJUUXpGZXhqeWNLUkhBNGMrR0tCMjcxRkE5VWg0c0I1?=
 =?utf-8?B?RDV5T0xZS01XWnpsNC9CT3FlNXY3eVBzNlhUTC9BQ0tiWWVxQ0V6TEhDOU1C?=
 =?utf-8?B?M1o5M0l0REY0UnV0QlNLNmZaY0IwMTZXZFZNQ0liT3ZnS1pyTkNNbTE2WEhB?=
 =?utf-8?B?eG1RWWdNUG04aU5yMlBZY1FSTDVWai9zOWxoTnZzSzMzamZNcHJkSG41dHRQ?=
 =?utf-8?B?ZndGU1BYSWtlV3E4T0EyWkVmNWxDNmxnVEZCK0VNR1JRajRSUk5JaWk4OHVF?=
 =?utf-8?Q?Vk0ItZ11Xq3RxjZSgvDvfQvt8od5vjmENpUlX3A?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NndrcERiVEgxdEtHRUdBalEyZmFkdmIzVG5WSWVSQ0RXcXV3Y0RwU1RUa1Jn?=
 =?utf-8?B?dkpsV1UyalBQSGpyM254dUxIaXZRT0lMcWpjM2tGNy9ScmFhWE8yMkpmZ2tx?=
 =?utf-8?B?ZmF6Q0VzV0JEekRIYWQvSzRLeWxsVjBUVlo4VjRIT21uaHZiZThaM2k4WndO?=
 =?utf-8?B?Rk5MRzJyTkxMV1FPcFhxWGZLbG0wT2tld1RsNFM0VDBTUm1hRHlIeUVicndn?=
 =?utf-8?B?MTZwYUZiVG9laVBJVTVYbHZBTUJEeWNLcUNHN0dhZDl5ZUlVU3lJczFpUnNv?=
 =?utf-8?B?Zy80VVJUUzVVNHM0VkdLRkVSL2xrZ2JMd3I2RU9HWnM0amMwNmxVbXFEb0xC?=
 =?utf-8?B?WUxsUDYvc2RaeHRqMkUrSjlWaVc3UzVPd1N6M1F1TFYySFJiN0F0MlFRR0NQ?=
 =?utf-8?B?emxxOVNmTTVBL1FLMUZBL2NJRHpSMXFNbkxhU3VzOWowemlPVFlBMCtwdGQw?=
 =?utf-8?B?eHMwaldIb2I2SzBUUFNvMnF0TWVJV3kvNHJuamR2WWFEMVpEMEdOaGZkcXZz?=
 =?utf-8?B?S1JHOFlzZE1wU2dLK0M5UkFETlNBSGxJMjJVaEY0cHRadXIvMFdSNHAwV3p3?=
 =?utf-8?B?NllKcmFrVmgvNUh0M2hZNDN3anZaL09JdkpSK2dvVGpheHFPUC8zVVQrdFpC?=
 =?utf-8?B?ZmdkVG5kUncyMDJ5M0FURDVsVHRwZW5JU3kzVTRxS0g5UzV2NUdMMXZmWGcw?=
 =?utf-8?B?QUY3UXN3ak50V1BjazNocXRHQlV5dmJvUW9lRzVzOUQwNkhPUXduM0J5cFI1?=
 =?utf-8?B?TzBJZndDQ0VsaEZuM0VaZ2dCQ21SSzZFd3dZdUhsOGoxSU84ZkZodTB6aFRt?=
 =?utf-8?B?ODY5aVNLTHBpWS9wckdsblNVV3RiZmhieW9pcDYxcExjYmRDS0pKNFVkOUVT?=
 =?utf-8?B?dC9aMU5xUEZ3T2RDVHVZU2g4YkgveGFvWmJVMngwK3FZWmF5MXdUdUJBVDJB?=
 =?utf-8?B?bHVacjZiMURmaFZrT1ZCUG9rTXhCSGZ6VTRaUkg5OEcrY0hvd0dVZ0x2S29S?=
 =?utf-8?B?RHhudUxYSFo2Z3dzNUJQaWVxekNXYS9LR0E3aW1xU3hZZ2RFQ0c4eHZXS21I?=
 =?utf-8?B?RGJiNXMwK21qNlFycGFBczMySm1pelYwbjUrblZwSGlKc3lGQnZLaU8vNG9q?=
 =?utf-8?B?MnRxc2dFM0d4eXNQRU40b2lyYTdmUW1kbUR5MXZkQjhKN2UyU0gzNXgvSTll?=
 =?utf-8?B?T20xaWxmNGlGRk96cjJBNWFUSmMyeVErTExQYUFFd25pNVpOdlZBeG9XNGFn?=
 =?utf-8?B?NWVmTzd4Yk5Qbmt1R3Z3STczdnZHdXg5Z1VSNGFQc2doK2NPeWZzQkNoMlA0?=
 =?utf-8?B?ZEVwUkRKRjlDNERXYWRQQmVFK01ibHZiNitNdXhrQnFpbVhmb254ZG9KMitX?=
 =?utf-8?B?bUhDd0xMS0ZVbEhpNDJSZldNR01XL1ZwcmVlelozdExDTUhaSlYzcDFIY2Zj?=
 =?utf-8?B?OWhJY1VlVk1Xem4vVHhhYW94NFRhU0NERjVXR1o0Z24zZ05adTRGa1c2WWNY?=
 =?utf-8?B?dGZNakMyVEdRL3FSVEZ1aFRBa1kxQzZYWmc3ZVhhSUdEcFcySVBGQlUyN3lm?=
 =?utf-8?B?b0lrMUNycmo0VDlsVTBwdnRQRi9JRllpOWs0VDl2ZWNXWWYydFVOQ0ZZMmRT?=
 =?utf-8?B?ck92U1RoZEk1RG1yR1krWWVLNmxkOGtWZFRtTkxEbC9Mckt2ODhBbFoxY1Y4?=
 =?utf-8?B?emdtVnNRN2ZNSmRwayttT2hvMmdBOGt2UG5iRlRRM0N0SmYyL2JHTkNGeXNu?=
 =?utf-8?B?d0ptQlE4ZTBlMnM3aTlEa2ljTnh0dEY4MW4yelNpWkl2bWJEUEgxQkFCNzhV?=
 =?utf-8?B?U1ErVm1uNjBOUWw4UFIwS1I5SGp4Y1NJZTFXN21EbmhGZkN4dDFPTFIzNlk4?=
 =?utf-8?B?ZnhoOHpzWjIrNmhDTjNSL21jWXVqOExTenZjMTN3MmtKUDl6b3pGQ0NmSFo2?=
 =?utf-8?B?YjFralJHMlo5eUNFK3d2czRyR244UW4wSjZOandzeCtDQ1RKd1JzMTFReFVa?=
 =?utf-8?B?cVNSOHdwQjdqZjN3d3NycFlEMVlaUWJ0T09wOVFtdldvN0Z6dG10TiswQWc1?=
 =?utf-8?B?TlM1OE1OdG42MEM0RytOQ1pOd0toL2lDMmdaSGlua1k0RGQzcWRGM0p5Q2ow?=
 =?utf-8?Q?0v0+udh0jVtLnEVIBId9jv4P3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iYagl8X/3OwIoUyAX306wIahSI7v3QahJEiBCLXaNelhKulfJvQB2Ar3jax9ogOZ92i+FxuxI6r55NdXk7hnLwCtViAXwjsBkZOu+edYD8Fl4h5qfm7T+iK/stTwFVNZej+6spA5LeD+ZeTnBq2zoAC4BQmAgXulAQ+MPngGysnAsAtdkuYtmraA2XKH8kvJUNW7D46wGwVPZb8e0DrIh06F3luPbFj5rIF1zUWYv1vgvdA2Pvyjk7UHv8MpG282KT6TNPUdC8Qv5zlu0wlSYea81QTVbooxusFUaHjQBuWHrjpbsDG1XdaL4wVku9AuFa8dYhsnQ7HSd42CQqO0LNpaKxPUBaVMX6nzopw9c3t9F23SutvRG/o+jVKJ2nyEx0Jr4rZ6Ryngh0Akj/yvJkMdblNSnqyKAowf1NbazAQ1PQC7/NYX3pM2cmTBPNDoy3AyHxeLbSigAZDbu3fMOP7MssiCdm2NlAwMgjQXXypcHUpKfgOPyOOXxLYfXfvd2ZzOZK+tf+KkYSLfC9iU9Au6fEWUGDjrdhKdMnHKxCwQLS3gkPCuAqdTa4isEPifO41ls4uZDpPCozmEZrebhDehMNTdhfASO0RUmKYofek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f67a58d-ae68-4e93-3736-08dc86fd6bfb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:23:37.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CJsVvrQ/RkKORSrYKMePvycFBNPMFSYucmRNtgFfqoTKekvCTck3zgiqM9xcUMf8PtHdI/E8P6+YrqAAU2THA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070106
X-Proofpoint-GUID: miiO_sadDP3CTxLkcfwmu4XdmdBgdSzF
X-Proofpoint-ORIG-GUID: miiO_sadDP3CTxLkcfwmu4XdmdBgdSzF

* Suren Baghdasaryan <surenb@google.com> [240606 20:14]:
> On Fri, May 31, 2024 at 9:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > Split the munmap function into a gathering of vmas and a cleanup of the
> > gathered vmas.  This is necessary for the later patches in the series.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>=20
> The refactoring looks correct but it's quite painful to verify all the
> pieces. Not sure if it could have been refactored in more gradual
> steps...

Okay, I'll see if I can make this into smaller patches that still work.

>=20
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>=20
> > ---
> >  mm/mmap.c | 143 ++++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 101 insertions(+), 42 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 31d464e6a656..fad40d604c64 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2340,6 +2340,7 @@ static inline void remove_mt(struct mm_struct *mm=
, struct ma_state *mas)
> >
> >                 if (vma->vm_flags & VM_ACCOUNT)
> >                         nr_accounted +=3D nrpages;
> > +
>=20
> nit: here and below a couple of unnecessary empty lines.

Thanks.  I'll remove them in the next revision.



