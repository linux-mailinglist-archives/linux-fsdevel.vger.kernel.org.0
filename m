Return-Path: <linux-fsdevel+bounces-69259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F52C75E25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 19:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C04E11F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFCD35CB84;
	Thu, 20 Nov 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OqP9nmdx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0162FE59D;
	Thu, 20 Nov 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662644; cv=fail; b=sOstdsG0IlIEDB1ZwD4dhGrbcQ1WEu3qFzkJ38kRQNYgTIef2L7+VzqhmCXBHEuAQ1+39tnJ4rWqFndVHvf/mPrGMFZKaQtppvaWhKI2dqN4+KaAOJKF56eJ7ttJjXQP55JTuvJbz3Wt/8t6IvxW3qRq7RaoG4ipSy8mjiiX0lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662644; c=relaxed/simple;
	bh=8jrzn+6thMOEqyGnqJMxh+OV60PxH9sKECHYwW+7sE0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S56h+KENOzFexrBn8PnzToGo20kU6UlWx6gUWZ2oZXMtD9LGEaNKVGSxyNPUjqVeJCjU1QSqXg6LcIk6yS6yxmZXNA0Jd45vGkhQVaita05FM09Xv4/MwhKcg5Epley0tMtOOwV91mEg7a5sfTYCHhQlY4Yt7k1pjrhEHr3KlG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OqP9nmdx; arc=fail smtp.client-ip=40.107.208.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr0RLiEsMrQqcayWcL4JMVPw1Yb4vQK3U+NmU+SJxvlczfhSvVYbt+4j7H99QJkY0Qrjs/5E+IE+ebfLeb73gqYVpekpqWFchIn5O6LoCFGDxANwcHOqznGZinMS6Y3u30u/rMa+18GoCk7jcvnPNx89gtK/lAlOcic2yhsw4P1ODn+PrAjt6qzC1ekTKtcb2NNIk1PfK+wNboDCpJikiJ1hRNJPS1U3l2IJjp7dPM++tGdHdKQLnfhEMCvQthu5KWtVDYSEZXy5l5XzFSU1bodscDZe/7padLl6lYsuE/tJ76rxNW9STAfx/X2JrbUXol0aVPEKCXy3IRmfpr0E1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n41uNGE8yXSFfTuWwYeEuw2U2841BciV2gzoytPLEI=;
 b=m9eBi7qgPzDj/C2YrG/vqI/HSDze1yL7Rv/u5cbgxuetIz1mrgncUqlqOiGJvm79QQU3h5y4lCxZ6L0Qdlz67WdsPMAN0YeRbP3Gl6YyLEqbdbH/CM5PtFg0vKfZE8cNlsHZIMIR6HpEussGTJGjZkrN6I8BTm99kTpICNoLeCOvTMYyVVf78P4pGNM8AywGypM0BzQ1cWtk+sR86CyqyFeeJE9obzsNtFq+xx3v5jVXx61/gZdyj1NzGDg+U42AzQ8DMjadQLDej7tOgN/O1GZ0rEBGNeVTVWgzC7CnklXNwRni8KxrrME4DNgiJJQgFGooMQ4yjNFElMM8YOX3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n41uNGE8yXSFfTuWwYeEuw2U2841BciV2gzoytPLEI=;
 b=OqP9nmdxMSN32A/ypHEdpe7WbkWZDKv1i534kltcoDgNndgbhoQTTKeCLRjgjtKE+Hmp6Y/FzlVz3AaPEkv0QcRmiMVl7U3TwN3afYn1oAOtDdrZ3XUgRf+dTTNXonikR5BdgxZqMJoW6yMTnPoMQvAp7L+kxM9lC+QkQH7tHx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 18:17:18 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 18:17:18 +0000
Message-ID: <3854edd6-5ce1-49cb-b4c7-49367c153231@amd.com>
Date: Thu, 20 Nov 2025 10:17:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] cxl/region: Add register_dax flag to defer DAX
 setup
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
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
 <20251120031925.87762-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <20251120031925.87762-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 087b0ce1-54fd-47e9-a52d-08de286109fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0I5NUQ3N0N3R3hTcnpKekVqNEhrcGV1dGc5bkZmV2UxekJhNnhOSzFHOXBh?=
 =?utf-8?B?RndZTmRTUzV1d2VqeHJ5dUJIcEJ5WGhwLzVnSFBCUFBGeWV1dm83R2hmVXQ4?=
 =?utf-8?B?R1U1ZGtmZ2JHMFc5ckEvbVJ3R082aEhMTWJmcUREZjV5TWRjTDRsdDVIZFNY?=
 =?utf-8?B?MjVWcko2RksxMlp3VkpreTM0MFI3SGhZZ0YzSy8reTNMc1kvNHhxS3NTdExn?=
 =?utf-8?B?bDVaVTkrQ2FuRk83aVNiK2xiOVg2TG5SWHZhVTlqSHVuWWRxVFd3RFdjNFM2?=
 =?utf-8?B?U0ZYNFdPbjV6TkhjNmlHdUdIeFovRSt3U1JIanM3Rk10V0ROMWViZkRvRVNa?=
 =?utf-8?B?V21UOGNKU0Zsb0NwUGt0MnRwa1MzUmFlUlJOL092QzJyWjRvVmU0YnFKejR6?=
 =?utf-8?B?bFpPRWZXb1prK1k0UVpEdFYrd082YUgyZGtCMDJJV1JDaE02OTZSNGQ3TDk4?=
 =?utf-8?B?NWxmdDA1MDM0YjZzNkhPbEtLUWdxaVNwL0krdG0wVzdBc25mM0hlakRVYXZP?=
 =?utf-8?B?RXVNUlJlSmVEQzluNDUrM1lOeHdMejJTVExpekdWdzVQcUpCQXBVaXhoeFcx?=
 =?utf-8?B?MncxaWdCTVczMzdib0tJTHd0RElDcGlxOWFtN2hnRm5JcEFkNXgrcXdWUjdH?=
 =?utf-8?B?ZXJoMndmZkpKQkxvalNUTndtYnhCMXUrWi9kWEwxNDRJSlV3NnJrM1BVay93?=
 =?utf-8?B?ZW4yb2laWDA3TjlEWDRlL0Z0aXp2cUVVdHNXdlBPdzVHNG9QVEJ0V2g5WmQv?=
 =?utf-8?B?V085V1VGejhGdERzVUdLQ2RGV0J5Q1BGZkU5MGlDbzUrN29mcERreTV5L1Rh?=
 =?utf-8?B?ZmNZSDdoN05ZV0ZaaTkxNk1WaWlaZ0Q1WFl3c0I4ZnVpeDdZU1p3VGR3NUNR?=
 =?utf-8?B?NXQ3aWViOGNhQUNabk1BV1p6OE1WcFRFRVFZZXNTMDJGb1hqRkxoY25SYkFD?=
 =?utf-8?B?ZkhBRDVYQzMvM0Z0SEh1VHVkeFNWZG9HRkxLTHRPcUlNeFF2Q1pBZ1J2bUU3?=
 =?utf-8?B?MDFGKzdDVmQvL24yT3hMRnhialpjcnhPNFRjYzhyVHFUZnppL2I2UTJReUE4?=
 =?utf-8?B?ajNPL3FlaEVEYm9wQ3cza3VkSE5ON2ZPV3pqWnFTZmVROWN2eGVudFg4NDdj?=
 =?utf-8?B?dVZrb212U0g3RXh2UzhTdkFiNHFJRGlMYW9OdE45MXV0NXJlVHpsbGYyR2Q5?=
 =?utf-8?B?RC9RRTdYWGcydHo0WnpmSERhY1RPdm4vT2JwNDgrWXVjcTBBNkdkMW10L2NK?=
 =?utf-8?B?dURhNDV2K2ZZNm5mY2UySDAxRGdxa1pidW40MktueGRhRXBwc1lkYkJIWnpr?=
 =?utf-8?B?TW04YWEraXB2enZJclZmQmdnZ3VOMCtKOGgycTZ4SEFKSDBaU1BoZ0pSd3Jm?=
 =?utf-8?B?bTVKY2VCd3BRdTRTbGdZbVlOK2dKYUQ3UGttZnVpaWdoNXVTVmYzYmJGWjY1?=
 =?utf-8?B?ckhVdE41VHVodkdneGR1aGRLbDlBZXZWMkhDUks0R0pRNmdSb1NidUFsT3pO?=
 =?utf-8?B?OVBWb3hQL0RPZjQwV1cvMGRTNlFYaVhYUzlSMGpRbmxHSU1aRGFJdXZiMGhU?=
 =?utf-8?B?UkNmK0J1U1VmbTNRbzEvWmY3dllPS29remthYmVuS2dTZ09NTi90cGdpWkRB?=
 =?utf-8?B?OHUxWG1nU1ZSRlFTNTl4VEFybzJ6SVIwcnVNZWphVVFsWUIvMytUdVdHamNK?=
 =?utf-8?B?ajFlZmkwRTU0K2ZmMFpUaUJycmhyeTd2K20vanQwOXhKYncyTlFYWXZxRStX?=
 =?utf-8?B?UzY4WTdZbUhuRmxtUUxnallxR3A5bFcvTURZSFpuWlRQRTBBWk1Tb3RhVk80?=
 =?utf-8?B?YTFDODAvb3pMVUp6ZEZ4eDZpZ2VRdE5jQVNJMG9QUXZDdzhMM3FzNkZISDRP?=
 =?utf-8?B?L1NLNXZNOWpHZU9rdDJ6UEM2NTIrN1VUR282TW1yVzZvS3NNRGgxUDVoWE1w?=
 =?utf-8?Q?jfhpNGJ9VSPIPT4mq7iZcCIC5aUf+6ox?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlpMcUREUTErY0czL0MrdDZXQ3Uwb2dabG5BNjlpcTAyaXg2ZEtMSTFKRXht?=
 =?utf-8?B?cXlsSHh2YVRWM1NlZVp2bkFFK01jeEhkd0Q0aFFRTm1tdk1tT1NSMWtEeUQx?=
 =?utf-8?B?RVRxVjFIZmNsRDhQeWU3NllvU1E1VVZyUm9tQURIZ3ZNaEhSWDF3MExUSENK?=
 =?utf-8?B?S1VTVE5MRnl6Yk4xdFBIcHF6eEx5WXpMRThhUDNtbzcwWHd2L01uakhCMU9Z?=
 =?utf-8?B?QmplWDY5QXpPWkYyM2hWM3g2Y2MyNGhqYmZWVGYreWZUVTJSeGY4WXB6VFRV?=
 =?utf-8?B?enZEUEg1dUxNT3JNZEVSU1ZWL0tpNnVzRmtFMlJPOENxZzdmU1lZRWxSM1l6?=
 =?utf-8?B?QlJzY05BRk82TmxubFFSSW1pZFhLS0k4Q2hDQkMxNHBqTmRqaWYwNllpTUkw?=
 =?utf-8?B?cTRjTUlwb1g3bnRRbStnRGpmTWFnT2xrUTlsOFNiTWVCNnRkcVpLUStSSWNV?=
 =?utf-8?B?TWYvZkhiWHFnUURjdEduRU96UEhTdGRHNXBSU3pTMGJENm9IVE9QRW5MZHRN?=
 =?utf-8?B?dzR4UGtyNHhESFpqY1RpUGNTOFU2UWtZQW10MmJXNGJ6Z3RVbStuaXh3QktB?=
 =?utf-8?B?RjFXN3dwSHkyQStxV0dSVGJYWXdCUzY1Y3Z1VkFIT25yWTFja2VsQlp3eDQw?=
 =?utf-8?B?aW5HUTViUytXdW9kYmtLQUtqZFNNYWRWbHNEb1A0QzN5ODRRMzZXaFFKOGZl?=
 =?utf-8?B?cEFZcVZhS2FRZHZSUDdLcVFyWFV0bHk5UzcvRlZoVmNURFl4SFNuM0ZKZ0kx?=
 =?utf-8?B?NG96d0I0ZDB6WW1VMWN0STU0Znp6dURaSEtMYzJkelNpNDUyblFkNWpLakhs?=
 =?utf-8?B?SjN3NnZOdGhFcjdueGNGUVdXR2IxbmhLOTZSZVgrcGtTNzhoQlkxbmN3Zkhz?=
 =?utf-8?B?YzB5d3dXVlVnNXdsaFJib3psc0ZtS25wdWZIZlZlSnBKa2VnYjExTE5DNTc5?=
 =?utf-8?B?V1pqOUN4dWwvNTlLbjNiWGZBK2ZoVEhYRWlJQndDUWJvNVhEdU5hWWFOTERG?=
 =?utf-8?B?c1dzbnhLUjJkQnlxOCtoS1k0RWlwb0FCOTdHWm45c3Znb3VaaHgvaFdFTGhF?=
 =?utf-8?B?dXNUK2pSdERpRzFLTGFDdzdWZUhQd0tVbXlFU0UreGw1bkZGQ0Y2K0g4eDY3?=
 =?utf-8?B?cmpaZDdsRjducG83N0pMS29yY2VOS3FVY3IyVnJPL1FsbzNLdFU0L3Y2aE0w?=
 =?utf-8?B?bHlIUVZ0Wk1HTCs4bnF0N0pNZHFlQ1FPaEdQNmtKam5KVFBJbm5GMEw4K01N?=
 =?utf-8?B?UzNMZ1haNVdlMDhzajVyci9QNFNMWm5PSldUeXBiQ1F4TDgyOUJhdnZsNko4?=
 =?utf-8?B?M2hpMnZCYVpUZHAvRWJOajJnN0JiREU4K0JDaEdSbkRlSHIxRk9hc0h6YjFB?=
 =?utf-8?B?WndrbXV3OXlRQU9KaW16bzM3eENXZWRYNHR0ZjdLMG1IZExkMFVSSDlJZExV?=
 =?utf-8?B?MzJ1dE8zNi8rRjh1YlBYQTJBL1NGakRVemVtQVN4SVg2SUd4eHNyeG5qc1FM?=
 =?utf-8?B?TUU3cDViS2NaeVlmRnhlOWQ3bkgwOWF6WW04aU9QQXdEQWVsWmtqbmlDemZm?=
 =?utf-8?B?NldXejRXVUpxYTVKbHNwVWtWNlpUTkxiRVZIRERxclhlRVFjbHYwYU5YTGVz?=
 =?utf-8?B?L0psYlg0MkFuWXEyMEtKREwwc2JPayt0b2xnMzVQemIzOXIwTkViUkJ6b1V4?=
 =?utf-8?B?cmdxbjFxOE9XYm15akJsM28vNTlQeENDZmVOV3p5VVU5UXM5Tm0wRHd2RWcv?=
 =?utf-8?B?c2NHcGt0R3NqVm9MakdrTy9maFBNMGY1Ym9WeEZUbnE1NVZmS0c5WHJxdUNv?=
 =?utf-8?B?WFVhY2ptK2p6ZkRMM1NlQmZTZEEzdjJnM0JCL1JQd2VOYWJIVnlyaVRHTTg4?=
 =?utf-8?B?T0d4cmxZelpJWWg2cE43bGZDV3hVSDgrYi9YN2gzU09vNmtneCt4OFFIT3g0?=
 =?utf-8?B?RGkxM3pLNE9MVFB3UWZLZ2ovY3NYSE1oU2w4eE15bDhGWlBzWGE0bXZPRGY5?=
 =?utf-8?B?Wkp2ZTA4cmtoWE5WVmtKUjU4eGFTMWI5ak5EQy9ob1NVNVI1ZHdqZWErSitX?=
 =?utf-8?B?Q0Z5a2k2Wm1xR3NZZi9qbVYxVER3VjkyK3VLUDZvM2ZSYWV3VXpnU1FNSm5H?=
 =?utf-8?Q?GAIN67YtOXgt5vrGicRp/VNhK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087b0ce1-54fd-47e9-a52d-08de286109fc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:17:17.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHPTBfTRCNxv0Kv/fDQ1fuQrhlYY30n1B/y842RYmrrRcU7FLrwyPk0kYQj3kM23tjTFFo/jA1UL07DnbTZzNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

On 11/19/2025 7:19 PM, Smita Koralahalli wrote:
> Stop creating cxl_dax during cxl_region_probe(). Early DAX registration
> can online memory before ownership of Soft Reserved ranges is finalized.
> This makes it difficult to tear down regions later when HMEM determines
> that a region should not claim that range.
> 
> Introduce a register_dax flag in struct cxl_region_params and gate DAX
> registration on this flag. Leave probe time registration disabled for
> regions discovered during early CXL enumeration; set the flag only for
> regions created dynamically at runtime to preserve existing behaviour.
> 
> This patch prepares the region code for later changes where cxl_dax
> setup occurs from the HMEM path only after ownership arbitration
> completes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>   drivers/cxl/core/region.c | 21 ++++++++++++++++-----
>   drivers/cxl/cxl.h         |  1 +
>   2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 94dbbd6b5513..c17cd8706b9d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2540,9 +2540,11 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>   static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>   					      int id,
>   					      enum cxl_partition_mode mode,
> -					      enum cxl_decoder_type type)
> +					      enum cxl_decoder_type type,
> +					      bool register_dax)
>   {
>   	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> +	struct cxl_region_params *p;
>   	struct cxl_region *cxlr;
>   	struct device *dev;
>   	int rc;
> @@ -2553,6 +2555,9 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>   	cxlr->mode = mode;
>   	cxlr->type = type;
>   
> +	p = &cxlr->params;
> +	p->register_dax = register_dax;
> +
>   	dev = &cxlr->dev;
>   	rc = dev_set_name(dev, "region%d", id);
>   	if (rc)
> @@ -2593,7 +2598,8 @@ static ssize_t create_ram_region_show(struct device *dev,
>   }
>   
>   static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  enum cxl_partition_mode mode, int id)
> +					  enum cxl_partition_mode mode, int id,
> +					  bool register_dax)
>   {
>   	int rc;
>   
> @@ -2615,7 +2621,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>   		return ERR_PTR(-EBUSY);
>   	}
>   
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
> +	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM,
> +				   register_dax);
>   }
>   
>   static ssize_t create_region_store(struct device *dev, const char *buf,
> @@ -2629,7 +2636,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>   	if (rc != 1)
>   		return -EINVAL;
>   
> -	cxlr = __create_region(cxlrd, mode, id);
> +	cxlr = __create_region(cxlrd, mode, id, true);
>   	if (IS_ERR(cxlr))
>   		return PTR_ERR(cxlr);
>   
> @@ -3523,7 +3530,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   
>   	do {
>   		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
> -				       atomic_read(&cxlrd->region_id));
> +				       atomic_read(&cxlrd->region_id), false);
>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>   
>   	if (IS_ERR(cxlr)) {
> @@ -3930,6 +3937,10 @@ static int cxl_region_probe(struct device *dev)
>   					p->res->start, p->res->end, cxlr,
>   					is_system_ram) > 0)
>   			return 0;
> +
> +		if (!p->register_dax)
> +			return 0;

Sorry, I missed this. It should continue registering DAX if HMEM is 
disabled. I will fix this in v5 and add a comment here

-		if (!p->register_dax)
-			return 0;
+		/*
+		 * Only skip probe time DAX if HMEM will handle it
+		 * later.
+		 */
+		if (IS_ENABLED(CONFIG_DEV_DAX_HMEM) && !p->register_dax)
+			return 0;
> +
>   		return devm_cxl_add_dax_region(cxlr);
>   	default:
>   		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index af78c9fd37f2..324220596890 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -495,6 +495,7 @@ struct cxl_region_params {
>   	struct cxl_endpoint_decoder *targets[CXL_DECODER_MAX_INTERLEAVE];
>   	int nr_targets;
>   	resource_size_t cache_size;
> +	bool register_dax;
>   };
>   
>   enum cxl_partition_mode {


