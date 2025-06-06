Return-Path: <linux-fsdevel+bounces-50866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588FAD08E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 22:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DB918939FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 20:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B79220F2B;
	Fri,  6 Jun 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zqlAVBya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1529217679;
	Fri,  6 Jun 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240577; cv=fail; b=PkHBkLP/9gEigCbOsNA6XYPoEMimgiGDpvCD8UFDMRSJGTjB7PT5oXyhkvli+kaqfF3v8zr9t5ysgmqX8px83hzjJo1D2RfrQ5ug53ub8/E0gPa2YUJCmNpqAE779CX3HkGNKneR1smxcsxBlhBd+2K3nPSOpYhdTKMfBDZ98qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240577; c=relaxed/simple;
	bh=qozS+yAXkn9OvncEU3vMnAxofzwKbypWgF8hBzRzR+I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cPitON3r7QILAY8CtTBHiyKHvaYQapRd+H7y+zlpol75pClarjiuLWlr+etGv8cGZMRcJRG0lD0vkBDVSu2YBSOwo30iJVHt9pIKAAMQiMKwPji+wmnyTSgg2qRKnCwVKgXoct303TDo6AlKovY1Dtbf9z4uRIBUHRXRqGFMTYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zqlAVBya; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raHIB8FeGMWyY9G8bwOIux81IJ0FOSG7eXejNT7IIzXrHTXLW5gs9xcaRVzw62cf29J7Fuw6BQD7Zu0rfBKgasdVQD0fzJDAX41KWRQ4M5S+blLZD1H2r67cWI+NZ4xV/1Ee0vI8wFNZsdTviLuw8j5LpQob6YMiWVDicXLilowgDEFX6EVPJr8K6Nn8lJOPe5ulTUl92UQrSz5X78Y8F35kwgY7qwnKqV1F3ZmVOLkJma0jasOP8tow6wstSnUQCbGCqIYXJQPa20Al0mMQco8EzWtL58dmdViRoQ3hju7tn3GYtuzX9ExdNw1hTBYMwEeoTYmW6TI01zsTK/O63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72hB59x0XxU8mqjwhJovqr0M6zuhZYLFtg7NlTih6S0=;
 b=BLRt/kjow6EqZ5xgpBTuBUXr5e+aBW81+9qd/2SF5A8qypz76Neq5hA4bafeKCUVmqmPoeLpaNBniY363VktbQCgk5w1YETKjgcD3Q2wRb6ZnJ9y5pAE1fNPQZdAlleTSyjHrtt4mW1IG2LL8SRqV1dTYicXrvjluQsw+LV3d4ic05rETfCDyvxwYZrAqC0HEbMYNEBW5Kc6iQpyr6KJR/clOuaJ3fUSDP97lFBpBo3S/kJP5kV1h0UbKe4P+7I+IbmoRCK0UDYkNVp7rw7qx/CprvjUCsB09/Mii5HrVOQIyl++yFbbtLeMBmhkpyBSASqSMFmAW3n32+BV1hq7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72hB59x0XxU8mqjwhJovqr0M6zuhZYLFtg7NlTih6S0=;
 b=zqlAVByaUxDfbeqvEQw9NkmLqrevlH7i5aMiKVJLCWAAKm5TS9ER8T/vUj54y6Pxo8gi8lrf8xMExzIqS2MAvlpzPaRmojJhKERFagGQctIH/lkh5fmn1LqhNU5oOzZmkBmXIlg7x4B4/TWTHtRgGxZElhlJZ/iapUPfE7+1Yb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 20:09:32 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%7]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 20:09:31 +0000
Message-ID: <26747982-8e9e-44fe-b89d-3a890c9e2cab@amd.com>
Date: Fri, 6 Jun 2025 15:09:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] dax/hmem: Save the DAX HMEM platform device
 pointer
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-7-Smita.KoralahalliChannabasappa@amd.com>
 <f4b861fe-d10e-497e-b7d3-af4af9c58cac@intel.com>
 <c14260c7-666c-4612-a4a5-369aa1e47f8a@fujitsu.com>
From: Nathan Fontenot <nathan.fontenot@amd.com>
Content-Language: en-US
Organization: AMD
In-Reply-To: <c14260c7-666c-4612-a4a5-369aa1e47f8a@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dcf7c0-ae08-4696-e694-08dda5360cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ay9taERKMUJrcUJ4SmZLTEdObUFaU2tBVzBYQjkveldGVXR1MVhiRXJVdEVD?=
 =?utf-8?B?cHBxRkdCY3NSN0dyRFg0QXovSHdsbGp3QlN4aUxoRHV3Vjg2bmlHMDZTS2l3?=
 =?utf-8?B?Ykxnell0dUgrS3BlM2p3RGRhVW5aWFVkVXNJY0YwUjNkZTdKbUQzclpMdFdN?=
 =?utf-8?B?UnpSaEJTMXlxTTJsWmNVcy9XOUxuNUUyUTNuY3NqLzNxQnpZWEtoa1VNR3pi?=
 =?utf-8?B?dkRKajRoZkRYZWJTNXkzZjVEb3hWb0swZHdIUXpxQlFNTDNhMGVZVklyeFlT?=
 =?utf-8?B?NUxBMURVZk85Vk1hYVZLbGpra01SSFRqZGdTY05NRGl3Tk16Wkg1SlMvV1FD?=
 =?utf-8?B?c0dpSG5mYjYvU2E4M2F6OVRpbUcvM1JZRURsaHBLYUFKSVlhMjF1TG0yemJ1?=
 =?utf-8?B?ekhpakFxZEVaSmRJUGttV2w4SCt0dVhTRGV6YmJSUmR6UHBJaE5zdnM5Mksy?=
 =?utf-8?B?VmhYaW1oWFFqcXN0Sjg2SlhscHpNN21QOGJ3bVpEU0h0a2xPd0FEbTlpRFk0?=
 =?utf-8?B?ZTFEWWU0SWhETm5XYXhHSDNJclp2SHJMSm1lTzNKa0RidzBSa3NoNkZhRnNL?=
 =?utf-8?B?TUQ0a1RNZy93QXJvQWpNWjFmWTFBTnhUMjNYUEduOXREZDhsVHI5anV3b3lC?=
 =?utf-8?B?VHFGUEI2ZjdXTUlpNStqc09tSE5hd1JUd2xNUXRsdEg4RjhXeFA0bFJkVzFP?=
 =?utf-8?B?eVcrS0hVTTJkMkxpRUUxNVVwZUtzNnY5NVM5Smx4cUpDOGRPbnJKZDVnbHMy?=
 =?utf-8?B?QkNUaklJTUpTY3JNbVhzNjVtLy9lSGdOWnJtUjYxRkVUS280S0pRM21SZVox?=
 =?utf-8?B?ZjhFSS9uWmxZZ0s5VXVuYlR6MllZRlp6ZlgzVVNObE1DT2sxOVZUaFVXdWgy?=
 =?utf-8?B?ajArZjVYakRuT1NZcjNpSGdVblpFZm5ReUFmREZMVFNzSkF2NEFSM2pRRmkw?=
 =?utf-8?B?bWZ1S1VkQ1pEZWxsQ1liMithcG4xMUZFalJFek5JSTZYbFhGTFpaNVNMRm41?=
 =?utf-8?B?cmE5TVl1aVJMbWxmS3c1NDh0Qmd4NjRRVEs3empnQlhVMm02bENjQ01GS3dW?=
 =?utf-8?B?YWEvNzFqak1nQllQOGIzYitUZ2NyVGZHeWIrbXdQNlljR1FUUERJa2dpVzdK?=
 =?utf-8?B?MXFaUXRKSUplbmNFTTQ2dWZoZHFpTXlpTzlyZ28rYjlBT1hUanBVK2MvS3hk?=
 =?utf-8?B?aWYrNjBDSVVXbUx6MUduVXF2emZ0aXh6Wm9ZZnM4T2NBOFgrUGJuWEJWSFdF?=
 =?utf-8?B?SzY4ZEpJM2RuM0U2bUR4ZXlnT1REODJYYk5xSHZUZEJEb2dhczBwQUhTdnQy?=
 =?utf-8?B?eC81YjNZSGE2OXhVMWxTU21kNDZlNG1RS1pKSlRnaWN0anMxZWVjTlFPdkJM?=
 =?utf-8?B?TjRHZzdRTFJVVldRSDdxRDJhVDgyNlp2M29yV1N6WS9EcVBxUVc5RWtmNk9N?=
 =?utf-8?B?TEREaDNTTmUxNjJZWGJzY3dOQWFxMUp4V1BzcHBmTnJaTGdma2tIR3dVVm9V?=
 =?utf-8?B?WDl2emVZenNyaUNTUy85cTkyOWpyOCtjdlJTSGxyRXJ1TU5sV24xMlV0cDE2?=
 =?utf-8?B?VmVta0NMOHoyK3dEaElNL056elk1RGFKTEZKUTNkVkxRMjI5OUNYakcxUzFW?=
 =?utf-8?B?aTVZRFdYM0o0ZVFVOWpHREFoc01xYjk5Wm9mODQ4OWJXbVdWbE1CbUxUMmxU?=
 =?utf-8?B?MlVhWHBjaU1jQ1ZSemZRVG5NRk13d29oZitpbHhXcTlWZitDQzJVbHBQaTJZ?=
 =?utf-8?B?Z3FtSW40dlBzSjR1UjRaNWJVUWVQekd2OERKSFg5d2ZNOURqaDdEM2x6VlZQ?=
 =?utf-8?B?MFMzblhsd0dpTXdFcmt6U3FzR25QbDZscHJLc0J6bWpuRXduK2lmb2JvdTNS?=
 =?utf-8?B?Q2lwQWpBcC9LVkdvNUo0N3VsRDNLbjZXZHJ4V05obVFhVlV4WDFUY2tzRm9K?=
 =?utf-8?Q?jutvu2Smvfg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXZjaVhhQnBnQWUwc1Q5UnZWc21rWXBiakF2dkJnOXNYUHZJdTU2RXVYTVNm?=
 =?utf-8?B?eVFmbEZZT3JwQm9ET0V4NlJBR2xSQmhkTzRRbE1vdHVIaFplOU5uYzROME9k?=
 =?utf-8?B?ditGUlpvVGZsSEtKVUtPMFRENUxhZkdhaTJRZWoxUG5rQjhnQWZvWk03bWx5?=
 =?utf-8?B?RUlia3puS0VoTU4vRUtmUlkyTEt3YWtFS1pQMHo3RmRPRGhlYm5IZDJDZkpo?=
 =?utf-8?B?YnI2QWRCR2pPRjU5K0VTejdLUEVYYUdqUXFnSHE5eTJJZGg0ejlrYnp1UHJV?=
 =?utf-8?B?Sjd6TlkvaVRUajh6MUdHaUlubVBJSmYzUVQ3OVhVcUprdk9VTS9neC8yZldC?=
 =?utf-8?B?eENxa3FzWThOcHpJTzE1eWdTUVBvbDlYUTBuY3FmVzdtamQ5aXlaWk50bnY2?=
 =?utf-8?B?RmxIakptQXcyanFSNEh4SU1yNm1YbTc5QSs4cnJpNnNwM0toU2h1UGI1V2ZK?=
 =?utf-8?B?VWVwYzUwU2VvcDJuWDVYTVl3TVlpZWdpTkEvc2hGQ0FySWhJYUdpekRFRFc5?=
 =?utf-8?B?U0VTYW5aaVRYKytWQ1FZU216aThHZ2ozdXpoNjZleXFSdE5sU3U2a0Z0NWFo?=
 =?utf-8?B?UmVQWjJUN1VXNUpiQjFTb0Z6bmtCUDJUYzlVdEprVXBOZjJ1elEzUzlxdXll?=
 =?utf-8?B?dVh1ZGN0UWcwVFVubTlKb2p0SnlQQS85Mm1zVFNMUGVrMldVNEJjRitCQ0VT?=
 =?utf-8?B?Q1pWSlV1NDc0WGMvT2xiN2RGK0J1dTcvNi82dm9NSFFkZi9JR1Z1T3RlandK?=
 =?utf-8?B?M0RoSHFZcUQyK09scmlhQjJnZDQrdUUrdENwdTJDMTNYQkhFTkJQd2IvSUt6?=
 =?utf-8?B?SSs1VHVYcmFMcmJKeUhKTjNKbXRLNVlLdXRrRGJKWU9xVGtEb0FIcG4xRU1a?=
 =?utf-8?B?QmNqQ2R0REtlVHgvOHcrRjJpTHJDUVYwT1Y2Ni9xb2R2aHBsMVRmTzhCQzlz?=
 =?utf-8?B?TytHZTZ0RHZjaVhFN0w1MEc2UWJETXU2RWFQajgwZEJlMzE1OXQyUy9ZQUFr?=
 =?utf-8?B?Ti8yT0NvaVlTTyt5Y1lGUmxJSFN0cWFZbk5YZXVuZGlOb29MQUdDR1Z1R2lv?=
 =?utf-8?B?SWhyNi9qNTlISmk3YnFPRlRCWW1EQzNNVUozeEJCY1hDaENTL0FCUys3VmVz?=
 =?utf-8?B?YXkrL3k0cnlZYVJScXY1UFkvUFhmOHVNQmJiSzBiWkFaek4wSVBhbFdLLyt0?=
 =?utf-8?B?ZWxBN2s3WWtDbWhReDAwY05vT2RCTjhiSjhNajhxcGNQRi9xRERQdnhyTzIv?=
 =?utf-8?B?WTh4RDRoRDBuZXo5NW9FUWJhbGNsZUFFWnFFMzVnUTVWdExuVmpYa041VnJy?=
 =?utf-8?B?aEdlNVRGRWd2dUl0dk1FM20zTTY3T2krSy9hUXM0dmZHV1FkUmEvMmgyRTZw?=
 =?utf-8?B?V0UxTTVPRklvT1VHVU5JcS9qWDBLYnc5SkhMVk1kb016c0pUY3ZMTStXNEdN?=
 =?utf-8?B?WndtaDhUSzhDMnE5VDFCaHljOEM5R1ZaYnMyclJQM2xHU0psTFZTRk13MDhD?=
 =?utf-8?B?cXMvZkxmU0xjYVVlQ2JOVkpzenJSSEtHR043d0lPRmpoTEwvTEpBU0xjV3Fo?=
 =?utf-8?B?ZWkxdHd1SnFUL0VEb09PdTdjVUlWVWtYTTJGUnVHWFlsTHI2VlJBZHc5eVJm?=
 =?utf-8?B?RFFwaFFYTHJHa25EVVg2dGM2cnBlb2dqL2ZkcFBZbVhrL3dIVTBqWnl3b0Fm?=
 =?utf-8?B?VDNlYUZOSHBJaTZTSThldEhmbFFJWFlkMVZjUkkwVE5aMWNJdFJhSUFKZ0xI?=
 =?utf-8?B?bG4wTExobTFjVVEyQ1d1NUJ5QnQzSldiWTQ1b01YQnY0QmI3M2g4RzhCWGM3?=
 =?utf-8?B?ZnZiRnp5R2V3ZkdlZE0zbHluRHZRcy9DZ0FMWkNhOFlGMUcxM1Azd3dmcGRn?=
 =?utf-8?B?T1pFZkVFb2tCOXRxUEF5OGJtNE9XYkRSVHhITXBEZS9HanJFSGNQVjYveFlS?=
 =?utf-8?B?aklFNVRKUm9RcVgzeFRFTUdqSlRyL2JlZHR6eHV6WWYzOFlzZmk4TFUwRlpO?=
 =?utf-8?B?MzB3cWdjbkV1UjdBbzJXK0s4aWdLWXkyZUlIRktlaldEVTNWRGxsaWZxSC9B?=
 =?utf-8?B?NVprS1ZRNURKQ0RtQWNPditPNTBqVVdDMFYzS3BuTm92dmlXRURQckdGT0Zv?=
 =?utf-8?Q?xvVeN414cJKKvoIaDdycQ3a4u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dcf7c0-ae08-4696-e694-08dda5360cc1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:09:31.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClHtnsL4p+YFpP5rCU4SJ8bXhzbY6HBtE1DTttiGQYuZII1E5BrEjRnW9IhTDmQQ5stoYWF6AonmthiCmOybew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817

On 6/6/2025 3:11 AM, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 06/06/2025 00:54, Dave Jiang wrote:
>>> -static int hmem_register_device(struct device *host, int target_nid,
>>> -				const struct resource *res)
>>> +static int hmem_register_device(int target_nid, const struct resource *res)
>>>   {
>>> +	struct device *host = &dax_hmem_pdev->dev;
>>>   	struct platform_device *pdev;
>>>   	struct memregion_info info;
>>>   	long id;
>>> @@ -125,7 +127,8 @@ static int hmem_register_device(struct device *host, int target_nid,
>>>   
>>>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>>>   {
>>> -	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>> +	dax_hmem_pdev = pdev;
> 
>> Is there never more than 1 DAX HMEM platform device that can show up? The global pointer makes me nervous.
> 
> IIUC,
> 
> Referring to the device creation logic in `__hmem_register_resource()` (shown below),
> only one `hmem_platform` instance can ever be registered. This ensures the change is safe.
> 
> 
> However, I agree that using a global pointer in a function that may be called multiple times
> does raise valid concerns.

Note: The creation of the platform device is moved in patch 7/7. I think the placed
it was moved to may not be correct. The creation of the platform device should be
in hmem_init so that it is always create one instance.

-Nathan

> 
> To strengthen this, how about:
> 1. Add a comment clarifying single-instance enforcement
> 2. Add a warn_on/bug_on for it: `WARN_ON(dax_hmem_pdev && dax_hmem_pdev != pdev)`
> 
> 
> static void __hmem_register_resource(int target_nid, struct resource *res)
> {
> 	struct platform_device *pdev;
> 	struct resource *new;
> 	int rc;
> 
> 	new = __request_region(&hmem_active, res->start, resource_size(res), "",
> 			       0);
> 	if (!new) {
> 		pr_debug("hmem range %pr already active\n", res);
> 		return;
> 	}
> 
> 	new->desc = target_nid;
> 
> 	if (platform_initialized)
> 		return;
> 
> 	pdev = platform_device_alloc("hmem_platform", 0);
> 	if (!pdev) {
> 		pr_err_once("failed to register device-dax hmem_platform device\n");
> 		return;
> 	}
> 
> 	rc = platform_device_add(pdev);
> 	if (rc)
> 		platform_device_put(pdev);
> 	else
> 		platform_initialized = true;
> }
> 
> Thanks
> Zhijian
> 
> 
> 
> 
> 
>>
>> DJ


