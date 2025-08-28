Return-Path: <linux-fsdevel+bounces-59597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE3CB3AE77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BF73B49B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5519F2D8DAA;
	Thu, 28 Aug 2025 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ls05hyCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6681A4E70;
	Thu, 28 Aug 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424100; cv=fail; b=DbD4zkecVXQHEB5j9ebjrLysengmV7BJyak+1hYKR00WzmbFnbGwNOJFftzPNHmhZysVVAN0kFGO5DLD02RaAeE4Rql8lR7+D1CznRDC2Md7dDkL1StJ9OqBoxwgxrePpiBHpHbWrccJmPSODNyVM5pUGuwk8ig7V+eo61yWjAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424100; c=relaxed/simple;
	bh=eoBbYX78Eim+idQb3iwDekoeso9dqVCjsBMHEm1CfEM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mEU/EaAWdmcrIp/wz1zVwKPvew8+IVU78/nNj0BGzDvvv7p9Ueeb37PmwZ3Ecbse9ZRBKnzRJMSBW/C07TzGn9EdTsHcV0bsOrSG5h1vEPyEF60SQ6IGX5sK8R7+3FnZrFFb94UOz+1qAuNR6fYhtBbyPFRmdb+CHUsy+OsXpHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ls05hyCS; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBIK5IWWmUbWB5pH/rV8gQf/K6u7GvM7H8R+TmydGaokxS8IcSDN+rvV9MUWVhexd0J5G3rjghGIdYLfZo9fKUBH0NsXQQCFIqy4gIlVanSwXWzmEThFWj/pYtKhUEPVIbwCHN7cu66ukaZYiNhUU7avDDMsEWbFtkcmi08OETMc90pUkMvEUnnwl3git1LPNJMctnI1u9V3bDhu93aiTxHYcSACdJeh3paduOOGqhG/7RfdlWWC1k+eCNl8ZM4RlRu+C2qaHUw6bGgE4Z7zoDfhDagn3FfFflH8GlFzAuewrp/Z2wE6CVxwnVL8CblR04PvZLXoLDuBHq87F+tkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbGNSbgj5rl1MFxwE06F05zp6IIPBESsi7KiDVCaqxg=;
 b=Fs+d8tZHndNae/SJWaSZIANR7yi72KRbQk650RmKrW07rY08IqY3j5tbocn2JD3q+21pnJ87p+/A6M9Ev5UVILWs9Q0McERlkmg6jen5FmpbOB174+kKuNoaz5gR8b6lKdUyQc6bwbm0y+lggQzJrj4SVUv13pvu+mzYFaKgfKDHq4QfSQDQYManHy9EFSbbqME4njM0OIwFPOKkKHx1Vq9bPaMIpLj711opFz8uE89OPwYaDkfY+eCx7Zkr5sQfgQrB6aYUF5jQyW7jSC6910TydBjD7ZInqHwc6/rlH7LMTvIfVDaGvRrDUbDaF3/LyepfR+h+VZsROaMyFPGRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbGNSbgj5rl1MFxwE06F05zp6IIPBESsi7KiDVCaqxg=;
 b=Ls05hyCS8MQBxCnb5c+9Z3wlsdrCp2awQnyG4XzZboaTCsKWBD+NnxU8QPtOrHp/SRqSyBHGXmcBvEf0vh93EEOH7m5F3UjumiBoN0t6Pb88Qq38j2X/adO40Bl59afPZ2iWzzkxfyTBMCoYcvx49D+vJqHz68Zi4ediT4C72Qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Thu, 28 Aug
 2025 23:34:51 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 23:34:51 +0000
Message-ID: <eb466a9a-ce5b-4832-8d63-ef2f81a29302@amd.com>
Date: Thu, 28 Aug 2025 16:34:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] dax/hmem, cxl: Coordinate Soft Reserved handling with
 CXL
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <aK5BY7bQ_dMZLFNT@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <aK5BY7bQ_dMZLFNT@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb2ea3e-bb38-437a-24ab-08dde68b7bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFkzNHlXcW9tSllGcnJZOVJZQzJpTk1uVFlEdm1XYnJaYkR2eEJGSERkTTVR?=
 =?utf-8?B?THFSa0hTQ0dFVTlqRndweGluRHNSS1pxaHV6KzIxRkZ3VEtJcTBJbWRhYUl5?=
 =?utf-8?B?dHpkVU5YQTJGUkswSE1xc3BBK3FCb2Nsa0tVeVRNZEpIaUE3cVNMVTZtd3p2?=
 =?utf-8?B?Vk96cFNrNUNLamlGd0lHUzE2d2pIb2NuYnJjajh4YkpEV3J3V25pUmR5Q1ky?=
 =?utf-8?B?YzVGSXA1cmNlR25XdEtxdHlqMmhnb2hQVmZHRWNRbWNYdWcxellpM2VKanFv?=
 =?utf-8?B?cDcyUHh5ME13MTBzZUNLV2pMalIvREI3WmI1SnBpVklaZHBsVkREYWt4YzZF?=
 =?utf-8?B?RjhXT1JkOHdyNDhSZEZ4OG9tWTdweUNNZTd3UXIzSmcrdjdmSFloeVhsT3R4?=
 =?utf-8?B?MU96ZVJqUXR1dlNrWWV2M1JDVVh4Q2NzZW82Zk8vdW9DQWNScEU4MWN4aUMv?=
 =?utf-8?B?RkZ6L1J0d2VJZkNxMUZFaVBiTVpiVTVPdGpic3ppR05rMzZrY2U5SFg0UERC?=
 =?utf-8?B?YTE4enZNaHh3NUJKU2luQ2RaYjVyZ3pRNktyK2I5MDIzRmJYei9jQy96WXh2?=
 =?utf-8?B?RDhTd0k0NmtTS0kxVS9iMEpEa3FZeWJic3BKNkpsTUpqeHJXL2RSaDV6MzVD?=
 =?utf-8?B?YWd6Y1FKREx5NTlVVUE4N0pRMGhqdXBtc2dvbC9XalJvR2NpU1VBc05WaVJk?=
 =?utf-8?B?QW9leXNzbFBabWIyaWE0YTJMbWdNT1NVcmpCTCtod1JORjNzaVNneGEyZmlz?=
 =?utf-8?B?YmFhcUNuYmRWVUk2QmR1V0ZYdFJNK0owREx6b1FOajJJc3N2UnpUYVlGb1dk?=
 =?utf-8?B?MFJ2c0JRSUFXS0RrZy82U0swWW1wNi9uMTRUVGZoYjJjZkttMmdsNFpneS9a?=
 =?utf-8?B?T3BHeHRyRnRMOXJKTFdSa1VFYnF3QWY4eWpJMnFYalh1dG1FbUFwenhkbDha?=
 =?utf-8?B?SzRPcFVWRTYwd0h3QVorVlpqK3J4MFd6S1NxMTJlUWVmK1diSjhtOHJnbWZZ?=
 =?utf-8?B?OC8wNmY3WVVHZHZuR0dBQzlaNUZQT0RyNVNiYnRwTGxyMXF5MGx2U2ZoWmtk?=
 =?utf-8?B?MkcvSXJFYWtYcmZtOEpSQ1NxZ2dPbVhOUktHUmNTT0I4QkI4cWtLY1BCUnBy?=
 =?utf-8?B?S1NkL21EaTZ2U3plbWVuQStuMjBqMEFGd0xnS0JxTnVZL2hkdzNIa0hlVFZa?=
 =?utf-8?B?QjIwTFJLZHg0bE92UjlyalMzTk9kZjhIVnZOa3NOSTdFVDlzSlFOM1lXNTNI?=
 =?utf-8?B?TnlyaHQxbEgzM0g0MERsQUtMV2EvaUhhYVFDS3djdTlqREVpR3ZaQVNXMWFx?=
 =?utf-8?B?am5aNm9JanpEYk52QnpQd3lXNXlneUgwSkI3SVZUR0NFK2RZZlNyTlRLaDhR?=
 =?utf-8?B?MkRhS1FDT3hId1VGR3V5d0VBMWlXUlVFU2Q0Vi9LQy9HcThab29vSDV3d2sy?=
 =?utf-8?B?RURPOEtzVDFEYTA0TVl4L0hUckVIUW9lUkF1VEM0bFRKZUZRMUJQckVUR2NZ?=
 =?utf-8?B?YndZR3RqcVIyRU1xdXBXc29tdEFLRFdrbzcwYzV3VzNqWmRuVTBGaXI2ZU9R?=
 =?utf-8?B?WEZKRGtwMEFlTDJqTFpDbzNtamF2MjJzZHNUNFBoaWsva1VyVCs0TkFIMVRT?=
 =?utf-8?B?U3FDL2Y0WDRBTE05QmhReVVlOG9YVGExREwreGo3QU8zU3RpT0x3N0pZTEox?=
 =?utf-8?B?L3V2NTBSdmhuVHRDUGh2S2FnTERvUE9SL2tMeGJCU21xWHhCYUJxSDdGc3hi?=
 =?utf-8?B?T3ZtQVZ0OXdLdjM5d3R0Qzh5YURaaEpvOWtrbWp3MWIrUXZxeXVRY3lQTUJQ?=
 =?utf-8?B?YjZoR3BENUlKQ2JjaG9IV2VpanhrbkxPa3R6a3FtbXFBRlBVM01mRFh5aUhi?=
 =?utf-8?B?T2hwS00vQkVpeWZZM3I5em9lWTE3MVNlRVJvY3d4RFZQQlkvZlNOS0xLWUNk?=
 =?utf-8?Q?E3cLfRWPiqA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDlRUlhXbVRiNWJzMkVERTV1ekVCRzBuTzk1aGJvejhmNStxbkpQVWs4Ujgz?=
 =?utf-8?B?WGN4Ujl1ZWpqODVob0V5Z0F3TFNkd2FWRXdHakxWdGY2b09xNEU3Q0lwdEpa?=
 =?utf-8?B?N2kvWXBSWlFNZk1TVWVCK3hrTUhkd29rOHByb0dkYlFPQzlGNzNmZnV4TFlz?=
 =?utf-8?B?WTh4aUFtZ1Q0ZWtJb3p4MVU4eHRsUkhEMHlNTDl4cGtXSFdGQ0JaakhvcTN0?=
 =?utf-8?B?ZDNUU2JXaTNjczVUTnlOc3RwNTRtbi9XcERxQUN1cWJ6bW9lUFNjRFYwT05E?=
 =?utf-8?B?S3lLSGJrWUtTWjZWT2lWQVZhaXZjZVhUcXg2REFRQWFvTFU5aFIwNVhCaFlD?=
 =?utf-8?B?QTJhUHBZQzFWODNkRU51cXF3MG9DbnROTDROWUhtWmJWZmZ2bUdWQ3VnYjE5?=
 =?utf-8?B?dUY5Q3dEWXVWSGllUVZjV3ZkNEcwOW1xTmlEcWdwKzNTZ1JHSVhabGpBNW1z?=
 =?utf-8?B?V1Z1aFN3MkFZbGFxcFNzSHFCTmJGbGpxYzdzMkw1cWhlMm5sZlJ2M0xDQTJP?=
 =?utf-8?B?ZjQ3QW5UQVJaZGtlNGNMMldvVkgyeGliaGNkL2VqN2pvV1lpZGttWm9PM0tN?=
 =?utf-8?B?T1FOcUszOS9aK2hrSkdmWXU0NW40WDhVTjQ0VzVueklMcnIyQjNud1FlWlVN?=
 =?utf-8?B?c2FseU1DS0dCalREcDZ5dXZFb0tUS2I5UnlYL2xzNDRaQzVlQ0dOVEVVamhK?=
 =?utf-8?B?UGFZUU91UXN4QmdBUk1YZDZweEpGUkRrdENCVWJYS0lPd2o5cmZjV29NMHRa?=
 =?utf-8?B?R0h6bi9pWVNhTWN6d29oWWl4S2xkU0VZVzM1eWFWem16TDVFV3dMb0tTRmpO?=
 =?utf-8?B?YW82ejV3YlRqQzAxRkd1a2pQbzhvY2MwQUF0OGpFNWd1UVk2TXRiMEVzT0ZN?=
 =?utf-8?B?eXF6bWNNejdnWFdpTjFaWDhmTXd0WkFmQnArQnVMaFZFMHhiUjJjMlFXSmds?=
 =?utf-8?B?SWEyYk0xL3FNaWZCV0FqNGQ5Uy9NU0NITm9acm5ZZGJNQnFuSm5JS3JacGxj?=
 =?utf-8?B?bWNOQmV2Yy9pVkg3aFUxM3dSekhZbDJiTytPbVRKMGRTbjlBd212ZWpFWFhT?=
 =?utf-8?B?aHF2MWtxUHgrNHJvS013UnVNN1REZURQNE41RWwzaWZGc2d4SXZxak91UGg4?=
 =?utf-8?B?cDlkTzJpaWV2RFA3bU9qRU9CZDM0TUtoWExkc2hJd2Rjckc1NzRZdzJ6N2VN?=
 =?utf-8?B?RmJmZ2FyNTVoUGtrZEZ1MnhIOUlkdmo1UkMyRytZUFJ2V1hSZkJqM2x6UFh5?=
 =?utf-8?B?ZXBCVTExSEVPTC92U0FGQUltQ1hMWFRLOGd1U29JOUg0VFFKUmV4a3lzSkI4?=
 =?utf-8?B?R3FncUhFc3hhUVlRNWZnV0ZPL1VMSjVYNjQxQjdTQVBuUmJBM1E2QlZNMFFY?=
 =?utf-8?B?S3hsVzNxOXVNVlQ2L0ZrVUkrUi9LNWhjMDRmWjRSZ0RJNFpQclBhbmZXWUFE?=
 =?utf-8?B?bXBLVzNVbitza0hnNDQwTjNRK296aVB1T1QxTDVoQkNpWXNWcmFjWFNpZE5Z?=
 =?utf-8?B?eURFMlE4ZWZkU0lDQjkrYVdoVWROc0pBMWMrWnRyQ0hRV2lwbmhTdU56YmNm?=
 =?utf-8?B?Z1duUEo3cU9xeUsxQWtIZFZON2JBNXVqcVd4MlZpaitnMktJWDdsZ25ZRTVk?=
 =?utf-8?B?dEVvcDZGZlhXS1RoakdIOXJNcEI1NTdFSmhrMGw1emp6MnBXbERQOWIzem10?=
 =?utf-8?B?blVwc3VpaHlBUVZaK3hCQW43RWltRXptc05CbmcwaHE2aENMRjZqQ2NzZkxr?=
 =?utf-8?B?UDQzZWM5d1pMbE9WTVNFbHVnQUpuanhkVkp4b3NCL1kwemwvQ1AvcCtxTnov?=
 =?utf-8?B?Z3BVVlNCdUtmYTlrallodWx3Y09vVmZiREtJTG5PWFdoSmtRRnoxakZjbnBZ?=
 =?utf-8?B?Z296cnhmSlI3MmlkV0ZmSStQKzlzUlJ4Rm1VN00vMVMrUEZJbWExRmpHbkta?=
 =?utf-8?B?cE1uNW9XR05ja1lEMjZBZVlONWJKSTVCTUZQN0xtV20vYTdwNlJtZW8zeWRk?=
 =?utf-8?B?MDJOY1hHVkgzSE03T1pQUFY4ZTNLUFNGZG1HSm5JRTJ2RFRRUW85blc3L1NR?=
 =?utf-8?B?MjBucVZha0hVbU5SaDlVOHc5ZXBsSW9SZGQrZjlhdFNSNU1XUFRLQVpjU1pq?=
 =?utf-8?Q?enqT9iAhYY1Wuxaqrhv2D47aJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb2ea3e-bb38-437a-24ab-08dde68b7bbd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 23:34:50.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeoRMDpKLFLP1UJboF92CiLPTT9MlAZMzvii3hglTJ3Mt0OCDa1RFRGzL8cclVZMFsyIUJgSMk98ddhrMHqKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947

Hi Alison,

On 8/26/2025 4:21 PM, Alison Schofield wrote:
> On Fri, Aug 22, 2025 at 03:41:56AM +0000, Smita Koralahalli wrote:
>> This series aims to address long-standing conflicts between dax_hmem and
>> CXL when handling Soft Reserved memory ranges.
> 
> Hi Smita,
> 
> I was able to try this out today and it looks good. See one question
> about the !CXL_REGION case below.
> 
> Test case of a hot replace a dax region worked as expected. It appeared
> with no soft reserved and after tear down, the same region could be
> rebuilt in place.
> 
> Test case with CONFIG_CXL_REGION=N looks good too, as in DAX consumed
> the entire resource. Do we intend the Soft Reserved resource to remain
> like this:
> c080000000-17dbfffffff : CXL Window 0
>    c080000000-c47fffffff : Soft Reserved
>      c080000000-c47fffffff : dax2.0
>        c080000000-c47fffffff : System RAM (kmem)

Yes, that is how it currently looks. Maybe we should also add a log 
message to make it clear that this dax is coming from dax_hmem and not 
dax_cxl?

Another thought I had is that if we hand off fully to CXL even with 
regions disabled, we could avoid showing the Soft Reserved layer 
entirely (along with the kmem and devdax under it). The question is 
whether that approach would be preferable, since in that case the memory 
would end up left unclaimed/unavailable to Linux. Would be good to get 
your perspective on this.

https://lore.kernel.org/all/a2e900b0-1b89-4e88-a6d4-8c0e6de50f52@amd.com/

Thanks
Smita

> 
> These other issues noted previously did not re-appear:
> - kmem dax3.0: probe with driver kmem failed with error -16
> - resource: Unaddressable device  [ ] conflicts with []
> 
> -- Alison
> 
> snip
> 


