Return-Path: <linux-fsdevel+bounces-63071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C018BBAB481
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7381E192233D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E0248F75;
	Tue, 30 Sep 2025 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ueRPZ12Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22D1E1A17;
	Tue, 30 Sep 2025 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759205215; cv=fail; b=ifFKv5umhfKG2bKlw9VFlletXf62+eptJc7Y3dyQ1Iedx95prEVd6iz/5TxA7DqDShVXyzjsxLC0Aod3Z/2O2E+uzyCy/YjljkGzgmuv13lDPIGiwZxAU11hHx8tYNeRLdiSa29IqxSBYNJiRrAw/4EdBE49RIKjiJH2at/jioE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759205215; c=relaxed/simple;
	bh=TaVVWvQkKDLv54VRT/8ZnTDqYe1j9CJjw5r6MYJyQ6o=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oBvelNOX24PV+UjrT5PMaRDcsI+hgXMg5yp+xy3P4JsWWSWQSWGk6mh2Gx53hWU1tGEd3KcD3T4YXeWJYFJNYARS8wYGh+X/prTYQtJhkbul5LXxcNM7Mq0dUJ9ZbzmbNYVNTfImSVBsgxqhpSxkEXlz/1cPbg8o379rlKTsZ9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ueRPZ12Y; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdbYUe1sDOJI5R6+LAd+T7AAfN6CxCe9NUJQSUxTLnIjsKeCeJj3x86T+BMePL7TBSEKsH02nqvMKJvJTEplIsY1Z4n55nXFvXTwGttTO8VqiQie3XD7e3Nzc8YWpB7rN0lzutXMPFtnKuWwIc8sEosp1mmyNMjIiNH6HEXr7kdm2g/6xV2ykiae8D/crhehRVKn8f9Ym3qmXe1gud6Ew6ciNOWuN1Q7YUmUIAnbcyRLXFVF9h+HAm5ENB8i4Ui0t2x/IG8G52h/QPFa+9k8WcdKkufDPX1R2J40vUc1SP1s5ekR+XMtrz+gQmEey/S6kAH1ADgsvGJU7tstXTRu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hG1+gMRQdfaBYpC9ah6/ZSru12Oc+V3RjhTNpAS17kU=;
 b=soapuygmGKlplmN7F3oqlrNmLt3fwKnPh8Y3HenCrM3R0nZec9rf4jm0XNXy4yXFv7BYdvHFnUuaH6zdCFsTnEaxA7Ybcbpt/pxUgl9yosPC7v6ZAPkh/VMZHHVuQ/QJGuptZkoplhDST6FwUW3p7SHay4zIBmfmB/m6+bpR6WSm/OgTmXbKywZbijtSJtdSznViP2U8UUpZTDZtWV9+IXQrBbDn/L0ciL46kAtRT6wxrz1YCqzg2aet3tv3K4pOs+1calObp8cqALfrU3qN91DAwOpbDWrldypqNFjxC6zS+vMlKqNxdZc4j+7J+VdHzyrCn8UOPeA2JDupHlhrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG1+gMRQdfaBYpC9ah6/ZSru12Oc+V3RjhTNpAS17kU=;
 b=ueRPZ12YlOZLSduQXDf4v7+zyeGUdZYiMCbojLsWt5VWf8bUdtlSCXFfDgbeu0Lyk/CKn+ZzJ6z83CvjxEZEL83j62wEffbvwI0lXqT0CcbGWB7IdWx/5UHTwMAaVqm6fPweTSbx8KwxAeHS+XSm70H8+9xgWzPNB1oqnOz7i8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:06:50 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 04:06:49 +0000
Message-ID: <652a4391-4825-46bf-9f64-52e0ef751dff@amd.com>
Date: Mon, 29 Sep 2025 21:06:47 -0700
User-Agent: Mozilla Thunderbird
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Subject: Re: [RFC PATCH 6/6] cxl/region, dax/hmem: Guard CXL DAX region
 creation and tighten HMEM deps
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
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
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-7-Smita.KoralahalliChannabasappa@amd.com>
 <2397ebb5-ae63-402e-bc23-339c74be9210@fujitsu.com>
Content-Language: en-US
In-Reply-To: <2397ebb5-ae63-402e-bc23-339c74be9210@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: fc375d5f-c580-4a22-bf97-08ddffd6c7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHRQUS8wbXkrZlJJeXA2VjNYV3dtTHBacElQRG0yYXBnclBqRkVLSzJWREtn?=
 =?utf-8?B?QjA1Sy9scE5aajVzM1lhR0R1MmttV1FmTUhUWWtDdmpaWUd1MExibjJsTUpo?=
 =?utf-8?B?NHVTejdGRzIrT0pqSzRxVlRTL2lFM1dXN2NNS2wvcUd3TThwMXQ5QzkzZGFY?=
 =?utf-8?B?SXhkaDYxWTVXcTIzQk1jUjNXZm5LeGJ6UjI2TzY0S1JFNTJSa3FPOGlhRWpP?=
 =?utf-8?B?MFd1SlAxYzBwNW5aM1g2YVpDMXVLUGtSU3RwYXpSR3RuNWVCSUJiaEpyRXVU?=
 =?utf-8?B?Skk5WXZtWFE4WTl6TW16OWRHWDRJdmVrMjJKTTdVL0R3VE5FSkl3MXc2UU9R?=
 =?utf-8?B?YXlzdGd3clZRalJ1VlNKMnRzT0VPenhyblBNZDFUaVVvOWplUkh6RDJnYnBo?=
 =?utf-8?B?MGJleU9abXJud3FMY3QyOWUzcVFLNGN2V3B3Mk9aUEVCaURlM29XMmJVMWxm?=
 =?utf-8?B?dDJFMEVDYjlhQ210WnhTKzNlTlp4VE85VVladWw3ME01Sjg4SzY3K1BKZEhB?=
 =?utf-8?B?SWt2NnpiRUdrVmNzR1hYaVFSaSs0SW5nbGtrbTJaZjNBRm9hb0t3NDI4Qktt?=
 =?utf-8?B?K0ZZUFpPUUVyQi9JN0ZVVjdoQkVOYk54RzVTQzBxRmVod1UzK1YyazdTeSty?=
 =?utf-8?B?VnVrbUJPNEhZVmJsWXJnNmJPNGhSWXV1SnRHSDNXUDVtOHpPRWJpM0hLL0Ey?=
 =?utf-8?B?aWZpQk1pR3dEd1JNT1ZLQU53NmZGcHZYR1NTaWpyNlgwU2RDNW9rQ2xncUUr?=
 =?utf-8?B?SGtXd2FNSFhOSC9tT0xnaGx3QUxqRlhpV3d6dW5tMzNqbGY1UUk2Z2ZRSEFX?=
 =?utf-8?B?VkM1d2hLM2xqZDhkUVp6ZTllWTRkSFNycWpCNjUwRGU4TjZjQ3RhRzVkRUJU?=
 =?utf-8?B?NzlkOUowYnpZOGQxQUFFbVFEbVBCRUdyb2xJM3ZBR3ljYUM4Tm9HdHA2UlJQ?=
 =?utf-8?B?d00raUhYUnBWS1RhTTJWcXdoY1JlK0xrQnYvUjVDRnVRY1ZRcTBvd3ZCR1Yy?=
 =?utf-8?B?Q2QvU2pqTmcvcVpac0tVeTU0V0hVdUxaWEhQa3FNd21lTElrMzZvb0VPamtH?=
 =?utf-8?B?QzlRaENEVFg5T3dkR1lLRGovMVYrT0NIQ1hjUnk0YXhnNDJhSGhHQWFyZmE5?=
 =?utf-8?B?ZWNKWUxJc0VGREFRQ2pEV0tpemdzdnJrNW9JRU5hK2xhSFVzTnUyQVNlWmFm?=
 =?utf-8?B?cGcxWlFHWjVtZVhNdHNSanpEbjEyNkFXL1YrblIvd3cwY0VrSUFBWTBPUlJ0?=
 =?utf-8?B?a25xTVoycVRsMHpuVTJ3OXlrWUNDQ2Y4ZTdYTks0YmlhT1hCUW8rVk51dzdK?=
 =?utf-8?B?a3RUK0xveGw0ci9VWks0U0RSVXVqNVNpZzRuRFBxTkxSU2MvQ1BXaENGRS9H?=
 =?utf-8?B?b2cyZzNicmtwRDVaSDdiQU9GVjFjOTFUbGZFaVhOaGxqczl3MEFJT2VFNDlp?=
 =?utf-8?B?WExpMFN2bkRZcEJhV0lXZzU2dWhBbXBRTm92ZDhWODdQdVBoRUE3ZHBiWW40?=
 =?utf-8?B?OTNWdGJXZi9BUzhHbEx6OXJZUDJjNTF3STJybHp2MjJSUW9yVTZlWGdmUU1h?=
 =?utf-8?B?TTJ5bEhRL0g0SFgvYnl0TmZ3MGQ0ekl0OVl4anJQQjJPYlZIN2h0YmlCcHR6?=
 =?utf-8?B?TnVuTGk0OHVocmV4bzRtQ2czUitvUkRxWkI5cklOQ0JSNVdFSmdvREg5QVpr?=
 =?utf-8?B?cDU1L1I4SjQrUlFQRkwzVWptUnJlUjd6NmJORXNTdTZFWHFtcTJHRDRmQ29F?=
 =?utf-8?B?a2RMSEdrQWRqYUF3dytzeER0YTZmM0dBaW9mQ0NVaStYWEM5Q1FDUEw3ZDhC?=
 =?utf-8?B?SEJhUURXcHNPdklaNXMwVXpFd3VVOXhzTkRIdXBxVXhmamJOVmhjT1ZvR1FB?=
 =?utf-8?B?OElCbXJsbnJLUWNYOHdaSFB1TnN3OXN4eCttMStXc3piUHdtM2VGUG01SnRS?=
 =?utf-8?Q?YuhRNYu7671GOExSc3GJeD02U38Xql+S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFNESzdFc3kxZElPZDNPMjRqYWc4QW5tVllxUkxDaGRXd01BRjdMZ3hxdzhY?=
 =?utf-8?B?akFQenVsQnAxTU9qN3E0cnE1U3Z5a1ZYTnNNWmo0SFV1ZjRaWGZ0d2VwZ056?=
 =?utf-8?B?akZBbjV4WWJsZzhWNnRqOWtwc0RrUEV4OVBwb1RRYk9KY211bDZ3cXNpZGxw?=
 =?utf-8?B?Mkl4ZkN3RVp4Qzc0d1prRStuUVNtZTRScjJqZ3poc0xvSmxDeHVwZUJrT3F6?=
 =?utf-8?B?ZTJORUh5b1lFU3J0QU1RU3JZRzdXenREd0Fqc2grQXdxUmd1ZHVaQUVRVE5o?=
 =?utf-8?B?UU52alppRkVabzRleFh1V05LSXppVGtYNGxIWkkvQXltbzZzZk5qU2xma1dZ?=
 =?utf-8?B?Q0ViYTlGOWJNMkVrQ0RVYVAwQ0xxdUNNVElkc3pxWDZHMVFpUFA2QmJWUlNh?=
 =?utf-8?B?cFNFamJYQVpuaWdaVzJmR1F6T2RyNHd1d01JVmdUTm9mUWVHek83RVZIZ1Jn?=
 =?utf-8?B?cXdiTm5CRVFSOFhDelRFMkhxeVQ5ak9ORXhRTmJKYnRvL0VLWmhJVWpVMk4r?=
 =?utf-8?B?cXh6bzJpREFGWE5vNStsalo4YWdiNTd5eE5QdHJhZTNzNVp5REpCdkI0a1hT?=
 =?utf-8?B?bDIxMmdaM2FkRVVpVVJBWVY2MThhSXpTUHlZNlBDN3p1ZDV1M0F3YmpSc3RE?=
 =?utf-8?B?ZUYyU0dNcVMzMkZFenU0eTAxYVJsRXMxMDN2VGpRL25FK1h2V2pzOVA4UVJu?=
 =?utf-8?B?MUFiMTUxZ2JrN0pna24xVmRBWlNwQmNMSHc5aHMrYkRncXF4OUw0OGRRYWpC?=
 =?utf-8?B?Z3djOEFOeUZtOFAxaDc0MGkvdkVjaW5oZlExN1d2SXB6cks5QXpOSEMyVlJu?=
 =?utf-8?B?OHF2RVdqL25pdDlJekdONXlINmdYZUcvSzczZzI4U1VSVWc1ZWtQWlMvYXM2?=
 =?utf-8?B?MUE2aUJTc01zaGJKZnpFTTF4TE1sekZHcDRnQzc5bk8wR1RGME50RTFkYTZz?=
 =?utf-8?B?ZXJKbkJGOVV2b0xlQTVISWtibnRqYVkrRlZYaWRLZERvR09pMjVjRnNQY2N3?=
 =?utf-8?B?VUdpajJzK1JJQXh4SlVUYWxGQkxLamZZNW1NNG1QbkpGOExUem1XL1NhWk8v?=
 =?utf-8?B?cUlIMHRBb1FlS0piMUdBalpGZlhUVUZmRlk0eDZkc2IyZjB6cks2NHhTcW92?=
 =?utf-8?B?RkcwMFZUQ0Z0NUdoSUlyM2NBMUk1dHhxWFdJNFFwa0hKc2ZTZk5mcFFzdjgw?=
 =?utf-8?B?ZDVyVzZkZWdkcVNPQmJSR1dvQTJiajI3YjFhYS9LUUdINHdwSzErUXh1Rjcr?=
 =?utf-8?B?QTNVaTZpSjEzK0FXZVhncXlOV0RsNllUMU9jdEpnaGZxOFd0Z2kyS1MzYXRY?=
 =?utf-8?B?SzZuY085czlHNys4NzF3RForNWpXZXlGcXRIZW4rVlBybUtSTFY2b29ROUMy?=
 =?utf-8?B?NlBQc0QvaWJNcFBCNGhYK1NFbE1hUHI0eWx5K2g3eEh0WG56b3pwdXlvREUr?=
 =?utf-8?B?UFFvakdZZFptSHgrM2hwVklQRllFbEtJdHgrNGNQcjhKZUFhalVFa29yNmVD?=
 =?utf-8?B?YUkyZ2tZWFBnTFEySnMrdWxPWGd3ekYvSllwQVZxYTNXZ2VGaUxnNGhhTTh4?=
 =?utf-8?B?NG5zaldBM2ZQNzEvR1FPNGhEb1pWZlpFVWh2QlI0UExCVEJlN211UzFGYlJ0?=
 =?utf-8?B?TExGTHh5NExLSHhqUUsydWRNMWxBZmxwM0NCbDlmYncxYUI4T1ZGTExsYTN4?=
 =?utf-8?B?WXFDejhaRkFxdS9jam9DUkg4SjhyUkdvWGVQMy9SV1dFaVpkRzg3Q09pRlZu?=
 =?utf-8?B?dDVGYjBVOUFwVzdhWldzMHVXTkhXUjZxK3VBajR1TFU0c29LMmluZ0dCcjlr?=
 =?utf-8?B?T0o3d0pudXl5cU5VWnZmVEFxK3hBQ2N5WDBlVGJTVXllMUVjaEsyeG1vdjlj?=
 =?utf-8?B?M0lFVTZiVTR6QUlwS3VUbjljcHhHSmlGRmw1eGw0S2lsNFF3MWR5Zk5hbGd5?=
 =?utf-8?B?ekh2M0N1MEN5djg2QzY5Z0FCOXU4dHZWZ2RMQ0Y3UmNha1ZJL2ZONlpxeEZ1?=
 =?utf-8?B?UEo5NTZTUmg3aFI0WDhGVTFSWVlvMS9YaG9wOW4rYVZ2ZzZRVHRnM0xVK1l1?=
 =?utf-8?B?eWsrRU9CNG8rMUFUNnljRzRBcFpLRUtPd3dyeWZWbWovcEh5RDQwN3kxekJV?=
 =?utf-8?Q?ZQz4NNdlEAoTvmXpAvNbv+Oed?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc375d5f-c580-4a22-bf97-08ddffd6c7bc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:06:49.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mth+6WF7SZ75xLj4QkGsu3Ha5GADXXcU1w8x5rNkLnLf9H1Leenpvyxvoq/8hzoNaPvH+la/DHhp9TcLZvf9hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139

On 8/31/2025 11:21 PM, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 22/08/2025 11:42, Smita Koralahalli wrote:
>> Prevent cxl_region_probe() from unconditionally calling into
>> devm_cxl_add_dax_region() when the DEV_DAX_CXL driver is not enabled.
>> Wrap the call with IS_ENABLED(CONFIG_DEV_DAX_CXL) so region probe skips
>> DAX setup cleanly if no consumer is present.
> 
> A question came to mind:
>    
> Why is the case of `CXL_REGION && !DEV_DAX_CXL` necessary? It appears to fall back to the hmem driver in that scenario.
> If so, could we instead simplify it as follows?
>    
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -200,6 +200,7 @@ config CXL_REGION
>           depends on SPARSEMEM
>           select MEMREGION
>           select GET_FREE_REGION
> +       select DEV_DAX_CXL
> 

I’m not entirely sure about the full implications of disabling 
CXL_REGION when DEV_DAX_CXL is disabled.

The primary intent of this patch was to address the scenario where 
DEV_DAX_HMEM=y and CXL=m, which results in DEV_DAX_CXL being disabled. 
In that configuration, ownership of the soft-reserved ranges incorrectly 
falls back to hmem instead of being managed by CXL. This leads to 
misleading output in /proc/iomem, as I illustrated earlier.

That said, as you pointed out, dax_hmem is not exclusive to CXL, so I 
will drop this patch in v2. The next revision will therefore not cover 
the case of DEV_DAX_HMEM=y and CXL=m. I would appreciate input on how 
best to handle this scenario efficiently.

Thanks
Smita

>>
>> In parallel, update DEV_DAX_HMEM’s Kconfig to depend on
>> !CXL_BUS || (CXL_ACPI && CXL_PCI) || m. This ensures:
>>
>> Built-in (y) HMEM is allowed when CXL is disabled, or when the full
>> CXL discovery stack is built-in. Module (m) HMEM remains always possible.
> 
> Hmm,IIUC, `dax_hmem` isn't exclusively designed for CXL. It could support other special memory types (e.g., HBM).
> 
> Thanks
> Zhijian
> 
> 
> 
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> I did not want to override Dan’s original approach, so I am posting this
>> as an RFC.
>>
>> This patch addresses a corner case when applied on top of Patches 1–5.
>>
>> When DEV_DAX_HMEM=y and CXL=m, the DEV_DAX_CXL option ends up disabled.
>> In that configuration, with Patches 1–5 applied, ownership of the Soft
>> Reserved ranges falls back to dax_hmem. As a result, /proc/iomem looks
>> like this:
>>
>> 850000000-284fffffff : CXL Window 0
>>     850000000-284fffffff : region3
>>       850000000-284fffffff : Soft Reserved
>>         850000000-284fffffff : dax0.0
>>           850000000-284fffffff : System RAM (kmem)
>> 2850000000-484fffffff : CXL Window 1
>>     2850000000-484fffffff : region4
>>       2850000000-484fffffff : Soft Reserved
>>         2850000000-484fffffff : dax1.0
>>           2850000000-484fffffff : System RAM (kmem)
>> 4850000000-684fffffff : CXL Window 2
>>     4850000000-684fffffff : region5
>>       4850000000-684fffffff : Soft Reserved
>>         4850000000-684fffffff : dax2.0
>>           4850000000-684fffffff : System RAM (kmem)
>>
>> In this case the dax devices are created by dax_hmem, not by dax_cxl.
>> Consequently, a "cxl disable-region <regionx>" operation does not
>> unregister these devices. In addition, the dmesg output can be misleading
>> to users, since it looks like the CXL region driver created the devdax
>> devices:
>>
>>     devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.2: created region5
>>     ..
>>     ..
>>
>> This patch addresses those situations. I am not entirely sure how clean
>> the approach of using “|| m” is, so I am sending it as RFC for feedback.
>> ---
>>    drivers/cxl/core/region.c | 4 +++-
>>    drivers/dax/Kconfig       | 1 +
>>    2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 71cc42d05248..6a2c21e55dbc 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3617,7 +3617,9 @@ static int cxl_region_probe(struct device *dev)
>>    					p->res->start, p->res->end, cxlr,
>>    					is_system_ram) > 0)
>>    			return 0;
>> -		return devm_cxl_add_dax_region(cxlr);
>> +		if (IS_ENABLED(CONFIG_DEV_DAX_CXL))
>> +			return devm_cxl_add_dax_region(cxlr);
>> +		return 0;
>>    	default:
>>    		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>>    			cxlr->mode);
>> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
>> index 3683bb3f2311..fd12cca91c78 100644
>> --- a/drivers/dax/Kconfig
>> +++ b/drivers/dax/Kconfig
>> @@ -30,6 +30,7 @@ config DEV_DAX_PMEM
>>    config DEV_DAX_HMEM
>>    	tristate "HMEM DAX: direct access to 'specific purpose' memory"
>>    	depends on EFI_SOFT_RESERVE
>> +	depends on !CXL_BUS || (CXL_ACPI && CXL_PCI) || m
>>    	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
>>    	default DEV_DAX
>>    	help


