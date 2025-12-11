Return-Path: <linux-fsdevel+bounces-71168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9057CB767C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 00:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF4EE302B759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 23:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FD8296BC5;
	Thu, 11 Dec 2025 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eTQTouxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885CA265621;
	Thu, 11 Dec 2025 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765496545; cv=fail; b=Q019eI4hR9C74QthQCQW8DxmdYtaJSCJXI+gG7CiJnTp2U04RoG0CA8/FpBvK7/NX1rrBZzWs3UbL8hM2b5aNlAmb7P2zBwX0XgER5sSkZrVDmV5TmgA4shZccm7G46vtyIXD8XQocBiRGs+oJC1lisgVbWrVlSIzLTTjY2cjig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765496545; c=relaxed/simple;
	bh=UtJrOdFewvUHvRZFY2LaWkpmJSszTuntHAebCmDUoYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mYxI2GosCQgAIqSs2VSABX435aec3ING25CFWsViJUcPWQr9h0LAhl1M/zpN6l4+mi8ncMw+nQgXIvoXxR2ULvjKbPDRyv7mP8hB696Ov364IK+51jbyUMsu7fN0+0jbGd4oaUZDOu7YI/gsqM78wTVv3WB1Nm1QlCsS//jlUks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eTQTouxW; arc=fail smtp.client-ip=52.101.85.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1VnPqzc5I+YEd6oMW5AUEEbr/mnem1o4CoETi4+Wj4I3exItZ8ZCuGn7knq3DP6p+RnWy46UYDZaobLsgRiSGaM93KReIeJavf6lUQKmFxpd9UdE8AYx0g0cIyQR6B2iYZcF7vliTrp7a6qDHx2WUm9FMdv7AmpYItsZkwVUZEps2s2SdTbNcvXZWxV1n7GoTPSp2Ts8lh7YUvQkKXr2mTMW8R75A8cLKS3LMAwnBSLTLK7WnoMAUTD/tGwMJt4eJNc/c7FsJmZKabO58ZpMZbYWfsIFDTbQh7ixBnodvarpubHaGKNNKOfgTKw3HksLluI5TsWFy+LZ74/pbzztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7alWP0pC5DoGy3nXOXcpejy/1P2YfLh1PXADuo9vC0=;
 b=sz1d+T3JPA/CzEmR5PUoZea2Axu+Gz7t3MJEaWIsxmNZMYqp32XEjugEnTfM9rqmJJ8dD8Fx0rOd7ZYDGhbiMqOCCLRF+WCerwKvXx1QJmxnAsKHH3BugXcZ05uqiSPcOkb5AzkoYmSrTmN3OCvrfL+gBk+jkNf+wC04P3rhS6vwPHWvkngj4sMR4rGNxyRulxRcn1Gnytsde5ve5ojvQKLvDiU4jYdkxQsJQpKr7mEntumWzTbRrEAp/pwljoydlfVWcvCQS7RxzShsMUr2GFwud+IaJtQJ63vtDyEA1oGei1fXVMdVCn1GUniYEeVnjfoPFlGCUsMYjIldu6SJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7alWP0pC5DoGy3nXOXcpejy/1P2YfLh1PXADuo9vC0=;
 b=eTQTouxWUXLDo1GdN+U3zGXK7Six2IfTw4VmIGrjQZzlcUOWvAO9FbtEOm/Dt5XAkufVNKPSAWH43cyPwPkZsj3U1dldH+wDKlwnRkp25nc+W05oxgGsg8JflaOYgCvGEaU7I+sh9vALkbKH+uXZqEt7kw+xAGh3hyjXw1FQs1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) by
 DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.10; Thu, 11 Dec 2025 23:42:19 +0000
Received: from DS4PR12MB9707.namprd12.prod.outlook.com
 ([fe80::5c6a:7b27:8163:da54]) by DS4PR12MB9707.namprd12.prod.outlook.com
 ([fe80::5c6a:7b27:8163:da54%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 23:42:19 +0000
Message-ID: <c1ddae30-688f-425e-abb0-b0fa55b5f37c@amd.com>
Date: Thu, 11 Dec 2025 15:42:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] cxl/region, dax/hmem: Arbitrate Soft Reserved
 ownership with cxl_regions_fully_map()
To: dan.j.williams@intel.com,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-6-Smita.KoralahalliChannabasappa@amd.com>
 <692fb37395f3e_261c11002e@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <692fb37395f3e_261c11002e@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To DS4PR12MB9707.namprd12.prod.outlook.com
 (2603:10b6:8:278::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9707:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d8c81d-1c57-4a70-9af2-08de390eec41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bi9hK3ExQk4zbkl0Q0NzNkE0eVpnbzVrcjAzT0plZ1FSVjJwRE82TDhUN0lV?=
 =?utf-8?B?bG9WV29NOHhVd0ZrcE16TENER3RtZUJLbjNaMXkrYU05OVRGVDMyN3l3M1Z5?=
 =?utf-8?B?VVJDa3hmWXQ5UzBlOFE4TXhuM1R6ZTh3a1NYTHVDRzdQU0RWNUZ4VllFVlA1?=
 =?utf-8?B?bzRqb0xma29RUDRCSDNZRldDN08xZjB2c0JEdnhrY0pkTE0vNDVSaXh2aEpH?=
 =?utf-8?B?a3dJRWRlN3Z4dzEvRnk1ekU1dklFZm5mYm9GQ2Q3UUYvTUV0TFZEMTluVnRk?=
 =?utf-8?B?bXZPVWkwZnN0YkJQbG4xNlBrOGptaDdMTEpyaGZLU3VSVGQrdE5wRzJBb1N1?=
 =?utf-8?B?ejBiWEFZSGJqUlhGMmUvMXZWckloRXRrWUlNWWFFZWp4OFdxNkdYdnErdEZI?=
 =?utf-8?B?U0RZVThoakJmTFFMMmVuN3ltd052T3k4VktSR2xieXZsQVNzcU9hTThHT2cz?=
 =?utf-8?B?MWNFc1EzdGF0clFMdWV1NWU1ZXIxZitUZFY1NzJtT3VULytGd1U3NnpaL205?=
 =?utf-8?B?MzRHb2t2VURBejdLaFpyaUV1WFhuQmxYdmg0aGp2NUZnSzJnU045NThiUEpy?=
 =?utf-8?B?dVJ5YW5ueFRvMDVIbEFySk9vbno5YlZXR1Q1NE9jTndiODdyaHRTcU1CV0hy?=
 =?utf-8?B?NllWNmp2YkNOU2JyY3NmZFF5YXAxMnpJdU1OQU5lUmVZbWxPQ2JibnhxRXdi?=
 =?utf-8?B?QnkzQy9qSTZ3T3dENTZGNC8zNHU0VWlEdlVkYTJKZFdWdUpHZ2FhQWFkTmMw?=
 =?utf-8?B?dEh1YmNzL0RidU4rd01aekJwZnM2cWxkUVNQNlZycHhSbERxSWxHK1hSK0dR?=
 =?utf-8?B?Q242NEtTWXVJTDhmQ2RGNVFSRUNLU1hxdnVUUVlpbjlZelFNMVJ6S2dOVXNY?=
 =?utf-8?B?U2VESktiOE11d0pmTzM2aXRiT1BBOHgyemJUNUJiZTAyVlBhWGpKd2lYajRl?=
 =?utf-8?B?RG8wamNnbGFhbE1JTldmTGlGYkRjU1kvYTM0RGlWdnlXOENCc0VwdC9BS0tt?=
 =?utf-8?B?NTNYa3ZvaEViZkduZFlyc3F2YUJueVJ3RmYwc1dQNFNneTNBZUdXaWQ0WHgr?=
 =?utf-8?B?Mjl2aW54ZHVhaVFBRDdKNk5ZUjRYMDdYVlU5eFpvemNlMzVUOGxndzlOeE55?=
 =?utf-8?B?OWJLR0N3NDNVbWZ4OWRaUUlTZzkvS1RTakQxMzg4YVoydE5ZZCsrM3FlZDFQ?=
 =?utf-8?B?N2luNkM2d2tWNWoweDNCemE4M2FhMDZhT1NaYmhUY0dZRkdTcENnZ1hncmEx?=
 =?utf-8?B?U3UzNG5oN2Z1RGxRZG4wM3MxM2wyS0JPaDA0OW0vTkgycXZzQ1JHK1NsdEpO?=
 =?utf-8?B?aU5mbjhNTFFYbTJIdkwyVTllVFlya2M2V0xHVFB5VXZ4bUpjNWdueCtBMlUx?=
 =?utf-8?B?dGdJM2wvQVRiSEc3dk9lYUlsQ0MxV3B3UFlVZUVnNGdMMmJBRWNFc0hmWkxT?=
 =?utf-8?B?WmZkejRpbTQ4NWkwa3NtWCtMM1Jyck5LRk03V1pYSWdZQnBtUys2NmhJT2NK?=
 =?utf-8?B?OStERmpPK2NranZxbGlDVXpoNmtYRlpCNklpY3BhV3R4NDFrdC91c1R2dks3?=
 =?utf-8?B?YlhkR1dsak1zWXdHUHNRcjkyMlg1amJxY1RKSnBXcEk0UGNhMkVrSmtQQ1NI?=
 =?utf-8?B?YTloLzdabUNkaEpuMjFlbDdwK2RvOUdGYnFLK243MVUvbnk3R1RvZlFkY0Rv?=
 =?utf-8?B?UGJ5MVJZUVQ2VURmNEJvdTExVzF1TE1FWkN1VE94cndVbUNpUzgzZDBUcGhY?=
 =?utf-8?B?K2VDbGFLNmo5cHBaa0xsaVZhdGY0bmRVeTZzM1I0RzFwWXJ4T1FjSTFHVGlJ?=
 =?utf-8?B?UHdXSDA3VzR2QUNiVTBIQ2VEbE9raU9RMnlBYXhPSGoxb2pYZytiVVk4MVNM?=
 =?utf-8?B?eW45aFVndHZKM1dhSEZYZjh5Y2VNa24xRDBpUmJwbyt1M2lVZkV0eDByWVMr?=
 =?utf-8?Q?qmr6LGtsXYl2uojAsNbJp9qF54hHAtjm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9707.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDVVMTRNUWpCUFRMYWtPUEREblpkeXhUaXE1ZndMNXg0WlRFTVdxQitWbFdk?=
 =?utf-8?B?VDUybXFOQ3h1U2wvSVpRUFRjd0YrMmpyZjRQV0VyWCtIWmwxME5oVkt3SjJK?=
 =?utf-8?B?UHQ0VGovaGpqU1dRbndqMDZaVG0veVJRbE5aemloUE1TUmFaWlRTcWRuSXVQ?=
 =?utf-8?B?bllQb1hKOEZpYXVHcGpsTU9iRG9pT0tENnZ1bnFia00wQUM3ZTlZT2VVOFpv?=
 =?utf-8?B?WnUrMVZtUmNaL3diNjI0UUJWK25VYmEwU0g3VGNVSkVwSGx4ZkJaOTZlS3p5?=
 =?utf-8?B?M294WE5haGxNbmJiMTYvd3dwMHhXeFQ3VndCalBpZ3B0N05OZlhDM0xoN0JG?=
 =?utf-8?B?R1d0MVR2QjdIb3VtcFB0QmdQNldCS3NaZFlnYlZoRGxFK1ppTDZYVHNJSDg3?=
 =?utf-8?B?RWcyUURBNU9aTlFkQU1SZXluQk5maGpsYlNic094RkFWd2FzQXkwbFNTeGpH?=
 =?utf-8?B?ZENPMXdBSE1PaWVTemV2c3k3WDAwQmJsWG9sdFZ4L2VySVlVK1MzWmN2TS9J?=
 =?utf-8?B?ald5bjZWOGJTTlU2Q0lEeFpkSlFFQTZ5bU03NEhuTWNHQXczWndRMXU1UDFB?=
 =?utf-8?B?WFB1TnA5ZGx6Sksxd000QmVBa2pXeG1hN3lHcVA4M3JnNExVem5QZHJhb2Zl?=
 =?utf-8?B?NmFkUlhjSXQxemowNWh1QlhZRVhYUUxzcVp1cmNNYTIweSt6ZHRpSG5xVEJh?=
 =?utf-8?B?NnY4Y0Y5WHVkRjlyQnJoc0FMRWZzdXRIK1EyaVQrc0Z1d3U3U0FCOFNpMTdO?=
 =?utf-8?B?MDNkOUE0S2FMU256NHVyOWpGYlN6dy84RGdLeW9mTkczY1dGdU9XT21KWG9w?=
 =?utf-8?B?eFRFaHEwdzZNK0lxc1A0dXQ5VWdrOEdGck5xbDZrc29PNWpFQVFLYzJwUzVC?=
 =?utf-8?B?SzFtQ0VvRHBSZllFWFBCYnQ0UXBhdmNVTTNyc0ljaCtPdi9RTFE5L0ltVzcz?=
 =?utf-8?B?S0twbEwrV3N1VmRFQlliZkZsMWNOeTVIMWI3SUQ3bnNwYitvTllrUjg4ZHRh?=
 =?utf-8?B?ZGZYWjRnbHZ3YXI3Q0RlOVV1VjRwYWN2M2JiUlZUNkVqa05aNFR3YzNZN2c4?=
 =?utf-8?B?enZVaFZTZHB5S0xwSE42ZEpZekJwOGxFSllvVGtGVnV0aEFmV1NESGFzOCtT?=
 =?utf-8?B?a2ZLT3JzVEFSUFhTbFMybFJ5dnc5SFNnTHRBL3FjVnNydTUrcXRLTkNpS0h3?=
 =?utf-8?B?RVBCcGd4dXlOdTB2UE1SS1NnNk5SLytyRGtaOUdrZ1B6aTZWVTZndDJROC9M?=
 =?utf-8?B?RWhPWG1Lc1BqZXdsalJwTUVINmY4TVBNTlFuTGt4U0Z4dXBuK0RldzlMUXJD?=
 =?utf-8?B?R1FoVVdvYmlTWWhlYnNtOFlpanBJdmRTVEVyYXRvbkFKQnEvQVJYTjZKa2Rk?=
 =?utf-8?B?c1k0SHArb2cwZFZ0VjVxeUxqSW9LUHdMM2ErcUt0cGg0MHpZOU9nNFh1cEZ1?=
 =?utf-8?B?OHhrTmN3TUtCbzc2MzVBYTQyS1kwZDA0REw4SUcrZU5rSXFoaXI0bGlTRi96?=
 =?utf-8?B?dW1naTU1R01DbW5sZVVodW11QSt0bTJtWnF4Uys4cTNmb3RFRlJIMGFobUZL?=
 =?utf-8?B?OTFDVUs3bnU3M1R5YkxmYnA0L0NScnRkTnR6eEE0Nk12WCtsTnZzT3pZTit5?=
 =?utf-8?B?aGlzTVg3dThtUVR4YXRwa2F2cmQ5eFZaQmFHZk9zMTJUTG4rVnJrdUh4NUVu?=
 =?utf-8?B?S3RvTG9HSVkxYWQ0b0VUUDF1VENLcHFSN0hTNGhyQmplVlJiVFZEMWNmVVNJ?=
 =?utf-8?B?Nk1hcjJoZk16ZUF5YXNiNGZtTXlaSXNNNGNvZzNXL0pEbkVDbjNOejI0R0xK?=
 =?utf-8?B?M3F2NGQ2aGdPZHBtdWMrTG5SazhFZW9MeDJrYzBaWEtneXZWSGtTcStsNkRV?=
 =?utf-8?B?MWlCMVY2UFdOdC9QV09ucnZiZDFRT3JVSXFvSFhKNzBwbjJhM2pzcGFPM0tv?=
 =?utf-8?B?NkxOMFpiNDk5MWdJSEp6Q1MyQ0poYWZUK01JYTR2OXJHaDd5eHZiZTNqWjB6?=
 =?utf-8?B?R0dhZlFuZWhMYWVTNUg0T0tMNllEcXloa05wbVVteGxOTEhlOXUwb0hHUFA0?=
 =?utf-8?B?VG1qOFVQb0kxY2JZRDN3TjBSNlVXbW8wQlh5YkJHcHAzdGRmS1RIZU04eWlz?=
 =?utf-8?Q?p5n/OiBqnJ/jEA0KVUMiiziyY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d8c81d-1c57-4a70-9af2-08de390eec41
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9707.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 23:42:19.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyWJqkTSizizobPUiWsxBEAStouEYA3eLDQGhHfavdNpnbPExaDRFGdqqZ8u/fO2dnJ9S93QY03TUu+x4N6pKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321

On 12/2/2025 7:50 PM, dan.j.williams@intel.com wrote:
> Smita Koralahalli wrote:
>> Introduce cxl_regions_fully_map() to check whether CXL regions form a
>> single contiguous, non-overlapping cover of a given Soft Reserved range.
>>
>> Use this helper to decide whether Soft Reserved memory overlapping CXL
>> regions should be owned by CXL or registered by HMEM.
>>
>> If the span is fully covered by CXL regions, treat the Soft Reserved
>> range as owned by CXL and have HMEM skip registration. Else, let HMEM
>> claim the range and register the corresponding devdax for it.
> 
> This all feels a bit too custom when helpers like resource_contains()
> exist.
> 
> Also remember that the default list of soft-reserved ranges that dax
> grabs is filtered by the ACPI HMAT. So while there is a chance that one
> EFI memory map entry spans multiple CXL regions, there is a lower chance
> that a single ACPI HMAT range spans multiple CXL regions.
> 
> I think it is fair for Linux to be simple and require that an algorithm
> of:
> 
> cxl_contains_soft_reserve()
>      for_each_cxl_intersecting_hmem_resource()
>          found = false
>          for_each_region()
>             if (resource_contains(cxl_region_resource, hmem_resource))
>                 found = true
>          if (!found)
>              return false
>      return true
> 
> ...should be good enough, otherwise fallback to pure hmem operation, and
> do not worry about the corner cases.
> 
> If Linux really needs to understand that ACPI HMAT ranges may span
> multiple CXL regions then I would want to understand more what is
> driving that configuration.

I was trying to handle a case like Tomasz's setup in [2], where a single 
Soft Reserved span and CFMWS cover two CXL regions:

kernel: [    0.000000][    T0] BIOS-e820: [mem 
0x0000000a90000000-0x0000000c8fffffff] soft reserved

a90000000-c8fffffff : CXL Window 0
   a90000000-b8fffffff : region1
   b90000000-c8fffffff : region0

…so I ended up with the more generic cxl_regions_fully_map() walker. I 
missed the detail that the HMAT filtered Soft reserved ranges we 
actually act on are much less likely to span multiple regions, and on 
AMD platforms we effectively have a 1:1 mapping. Im fine with 
simplifying this per your suggestion.

> 
> Btw, I do not see a:
> 
>      guard(rwsem_read)(&cxl_rwsem.region)
> 
> ...anywhere in the proposed patch. That needs to be held be sure the
> region's resource settings are not changed out from underneath you. This
> should probably also be checking that the region is in the commit state
> because it may still be racing regions under creation post
> wait_for_device_probe().

Sure, I will add this.

> 
>>   void cxl_endpoint_parse_cdat(struct cxl_port *port);
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index f70a0688bd11..db4c46337ac3 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -3,6 +3,8 @@
>>   #include <linux/memregion.h>
>>   #include <linux/module.h>
>>   #include <linux/dax.h>
>> +
>> +#include "../../cxl/cxl.h"
>>   #include "../bus.h"
>>   
>>   static bool region_idle;
>> @@ -150,7 +152,17 @@ static int hmem_register_device(struct device *host, int target_nid,
>>   static int handle_deferred_cxl(struct device *host, int target_nid,
>>   			       const struct resource *res)
>>   {
>> -	/* TODO: Handle region assembly failures */
>> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
>> +
>> +		if (cxl_regions_fully_map(res->start, res->end))
>> +			dax_cxl_mode = DAX_CXL_MODE_DROP;
>> +		else
>> +			dax_cxl_mode = DAX_CXL_MODE_REGISTER;
>> +
>> +		hmem_register_device(host, target_nid, res);
>> +	}
>> +
> 
> I think there is enough content to just create the new
> cxl_contains_soft_reserve() ABI, and then hookup handle_deferred_cxl in
> a follow-on patch.

Okay.

Thanks
Smita


