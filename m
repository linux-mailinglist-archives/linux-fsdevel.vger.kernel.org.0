Return-Path: <linux-fsdevel+bounces-51086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D69AD2B4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 03:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636A3171F58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 01:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8621AD3E0;
	Tue, 10 Jun 2025 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KuPkqfKh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D161D555;
	Tue, 10 Jun 2025 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749518734; cv=fail; b=NTBEO6n7LsNPbeALqAXxL8TVdJllyuJPztomsfiajCmAsBK47rPvjxSOxtsmwzpWuhxSeojtiVrZzPb5PFTT9STCQbqDEh7OGmEnpL6SNaoxkjEdF4GLt6eEgE22A3jyYzquYuwO8rpWWnzkQvnex4UoV8ydygDfVsevEpd30W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749518734; c=relaxed/simple;
	bh=pUituUACN91mc2b1dGLxOQT6rBd12CYKHVwxj1whTzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IOEH4HVRwjHdsmtiwvIpBrRAtSiFusvj5T1c0gzkpGe1BFiPRbk24D/AOTzc8RHPq3zYXC2bNnsllbPmdh4JNHEnhtxHU2dHWjB98CXdIpKUuw8HSNlefqQ3xmkMyKalskOncxoV9B4IxQa54O9aDBgFCzUpktrYcOOzmOofUgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KuPkqfKh; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0cQdBoFD9WrAmB8uz1duJS3bvglSph3tpKIty/uApuGXX34m/8+oFL++XIGMRgqSh/Qhr+KLAVIZA6fTfC74BphDRR9FQx/HB/vxDzRoJpZqJZq7ktL9jDRzKFkQpaOulHr0LOK4z827ef88W7qcSXxmJEmiQ6ehBpmBunVtimSJWWgTrRDoDjC3BbLjdRdiolOs+zPWKd2C0O9nXBplQayB/kia3UWZkrvMACSgSBJtKjRm7oxpYu7GePI8O5e84AYMZG9ilXoVViCGGzq2F/MITzqlp27AmYM5D2m5HM/i9bX5si+YyaJZ71LRPt4xWdpRoiA7IewJnVzLMxHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kjZCvkl/zlKUHXtq7pim0n7OY3FykaT50jDVNgHTWI=;
 b=ipnVQDvlH5thLHuS/tUYBGT6+IbReK1qLzB0JhZe6iH9mfPAo6deYGHiwsN81+gv2TOPulZxGGkkrBVA4HS6Yizawye6N8GVONJKzXLgxGPftcFxYqV23q8r4MkAqt989PKRKcQSXpHqTQST7qwUMGeBRfrKIY481xdP5mB7iiY6HUa66nFVP8wIR5XgUl519dUXx7bAgPlEbYbDeNi1C8SkWzuWCGb3rCaSQtmJILSnV+y80a0DenUNaJNTvLNXkLr1bQdM0hmB2pF1hnHmpGppBkkgSYAfOMLL63ixtrGGSb1elhjjBoytKW1GiG4e5lfyzc517VAiT0fpKFNKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kjZCvkl/zlKUHXtq7pim0n7OY3FykaT50jDVNgHTWI=;
 b=KuPkqfKhGTzgFKa6sjGFcIvFGxUkiayRcJFHwjcWebBIfKaLavvEe+gCOlpOh1/X6orhxrSP02M3B8dlvfeuaasnpqmYH5vF53I41X7pbiXrbm2E1sp/4SQoGOcEPq4GSIXffX37bz7yM3se4W8hPqwN7EYpx0qH/1J5ENEvqvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 01:25:28 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 01:25:27 +0000
Message-ID: <f157ff2c-0849-4446-9870-19d4df9d29c5@amd.com>
Date: Mon, 9 Jun 2025 18:25:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] cxl/region: Introduce SOFT RESERVED resource
 removal on region teardown
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
 <20250609135444.0000703f@huawei.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250609135444.0000703f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0048.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::29) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 219132b2-0d92-425c-818e-08dda7bdae5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUg1Tk1FN3ZoV2RvOHVWd2xBRjliRElPcmpDM2oyVWtVSlcrNlFPcTBSQktG?=
 =?utf-8?B?c2gzdHp1VTN1QmpmQWRWOFN1a1c1d2tHWWdKZmhmNEYvaG1VcXNONU4zSlps?=
 =?utf-8?B?VHlldEVycFUycmxqZTBBaC9sR002U2VpSHFNSWRxNG1XOG9VbXlSbXVBZXht?=
 =?utf-8?B?RGwxZDBqYjFtNmVwVlo5eGFNLzhCTWZRSE5uMFdKNGNoajlXaTZuVnB2RFZE?=
 =?utf-8?B?MENLRWVIc0dTb1pHaTFFckJEcWcxeUY2cERjckZVek9DejYyM0NacnFweVpP?=
 =?utf-8?B?SFZSeXBNYVVKazJtdit0aGhLYWNhdEx4Q3pTMVVCOFpCWEpyVFRoN0h2N3Rl?=
 =?utf-8?B?NUN6YlVhZUN3NDBCRGlqSytZS3JydXA2aHJpWFVYem8xb0g2eGZuQnphVGpE?=
 =?utf-8?B?TDlRVmMwVE5nMGNCU0VMT04xQUtpdWQzMDJ0YnRCNWloWEp1Tm1ab0xCVGxE?=
 =?utf-8?B?enhvem0rK2V0WG4zWUllb01XYXlqM1N2ZWllek1aREVpNC9CMHRYV1R5NnMy?=
 =?utf-8?B?b3pDK2NwSWlWQkdZMGROYUV4cWFxQ2VMVndUUElTcHA5d1lsN0ZKRm5VRk80?=
 =?utf-8?B?UFM2S1U2WUNwc1BkRVJ0azBCcEFBaWxOTDJuMHozYWM1dGZzUThZNVZLck1H?=
 =?utf-8?B?WUtLa0NWNXl6alFtU3c4cml0STliVm9SdVVueGsvNmhNeGcvbUV5ZDFqazZV?=
 =?utf-8?B?bmt5d0xzVjc1RUlpOHNPQmZBM1dhZ0dBMDNQNi9US3Vsc1c1Qm5Ob2pzQys0?=
 =?utf-8?B?dk0xYThiQTMxcHdDcXZuOEg4T0ttVEUvWFlWVDFLRTNKaGJGQ3BQbkR0WnVO?=
 =?utf-8?B?WmhUak01R2JWTFArWENwbURabndCRVFJUTRWKzA1OStRNnU5bjd2bHV6bDdn?=
 =?utf-8?B?Rmd3Vi92bjNQbkN0VzJRRzFkVGoxZHNNTWJzcVlrMHNrdzhqQmRoTXMyQ0Jl?=
 =?utf-8?B?b1RtLzRLd0pLbTRHYlZINHhJWFF6U3haOWVzL3JhZGVPaEpiUUVBS2RHdDYy?=
 =?utf-8?B?UUFQcnd6dDU2MWp1bHYwSVhkc1IwZmhlQ0N2T2ZNWXZ1Nzg0am5ZMDVjclY1?=
 =?utf-8?B?RktEazNWZnBtaXNpU2orUmVRTHhqbDdJWkNGWWdHRk5pS1ZZbnF1eVA0Qm9U?=
 =?utf-8?B?ZnNTS3hMWkdXZ0p0d2o5SEVtOEd3bnhnaWdWNGU0U2NyK3cxcUZWK2N3ek5Y?=
 =?utf-8?B?ODZwREJxL3RYS3M5c2NPbzBKOWZtZVpuVzluM29Fc3dLQ3hSYnd6eWg3cHh6?=
 =?utf-8?B?M0tDa3ZDQmhtWmgrUXFNMWJNWjl2TkhNQVAvT3oxWVRzUUovcGZmY3lvdnpP?=
 =?utf-8?B?ZE4zMzRUYmpRNzdTNkdjZG5mT2tVWUZDTmx6cGowenM3dVBNb2dKWXNOZHBv?=
 =?utf-8?B?S0RIT0NQM2lBNVY2eXVNRjFNSTlxUDNCUlBUdExYbzFYWVpmVHlYd0xmaVVi?=
 =?utf-8?B?R2RyeTUvWE9oM1RRbS9DWk54eGZjTHBzTDJ6YXd6MDY1UmV6aTdteFVvZ0dl?=
 =?utf-8?B?cktQaHB5T2g1eGs1UFhzUjhHUSs1TzlZK0laOHlCQmlSaWRPVXBFMktwNm5M?=
 =?utf-8?B?R3c2OEZhd21mTW94cVJnTlBKdzdLSkhMNDExUzFGNS9sLzB0VVRUZzBpTWZn?=
 =?utf-8?B?RTNkNVFxb3c0RElDRTl4UHFtd2tUdEpha0txQ1pGMmoyTzRUak1WdDlZOFR4?=
 =?utf-8?B?U2Q2STlOWE5Od2VmSmdHSk1mcGozNjlRbG5rckNJTHdCTERjeHpURVZrT3la?=
 =?utf-8?B?Mk91YVFJY2FOdXUrUXd2ZnBkZlFvSlNTYVRXamJ4eVpUOGVjKytaS2p0MitI?=
 =?utf-8?B?NERzSFg2Z3lqSFFRQllScW5DbSs5d09JbVFFaEpuOXozOXdtRER3UU1FYTQ4?=
 =?utf-8?B?S1dpM2hzRkN3d2NOUVozSVdTRUhmRDAyTXZqcThBbVp4WDNKbmZQKzJaR25Z?=
 =?utf-8?Q?QYPQv2RpeDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVFOWo4VlRWb1JXUXJEUUxJVDFtV2VucXk3aTVyQlF6emlTSkUyOHVZZlA0?=
 =?utf-8?B?RUF5MkgzQURZQi9TQkpOM1FXSm81OFdXR09PbGNsRUs3ZzNuTCs5bFhkRjlq?=
 =?utf-8?B?WnJOcEs0T2VxSmFBVDk0VjJFa0QrVzhoY0hzZHBtZXZ0VGhqN0czelh5MHVx?=
 =?utf-8?B?dk4yNnUvTlVGR1AwblJLVE8wTWFHNEFQeWhhYWNiQk5SRkRmRlFWSTNrYVVO?=
 =?utf-8?B?ZVVxR2VqOHgzbUNIVEpxQ2VzdnJSR25YdU4xeERYZ3YwRkNFNWJnK1loMjdo?=
 =?utf-8?B?RkdCbTZDUU1VcFZXcThlV2FxenBVNEc3MmgxNkJ6aldiaEF3VFFySGlaRlJm?=
 =?utf-8?B?d1BkN0VzM2RjOWg5STFERGFCYzB5YkUzQk5uSnBibUI5a1ZPYVE4S1pUTloz?=
 =?utf-8?B?U0F4WWpzOWxjZ0ZqNGtrczg4dnUydSs1UDBCbEtnV05oekdaQWFIT3VVRjRJ?=
 =?utf-8?B?K1hqeXlXUzBTWFo3TmdjNWozV3dsNVg5RU5GOTRDdEVDVGNiL09xUUR5SExZ?=
 =?utf-8?B?T1ZTOGhRcUk5OWZPYmQ5UEhGNW9tYXNkeHI4NXpybi9xTFNvY1lzaEowa2Nu?=
 =?utf-8?B?NHhDM3VMdmhRbExUQjBBTmVNcVdidVNYbElPQVh1WitTcWxGZnFFMDZqY2VK?=
 =?utf-8?B?WFFYYzVGNEFEamJ4NG1EMDl6a05BOWYwdTZzVkxIbVN3ekx2UXQyN215elVa?=
 =?utf-8?B?YmttZDcvYTRBN2l6TFR4TEY5MEZBdGMwZUFDRVBHcFJpK2ZGTkdXSDE4Y3ZM?=
 =?utf-8?B?NDlqd2pjMlN4UXVUTEUrUHVDaSt3Z21peVBmcm1uUVZNM0dnWmVDNC81TXc4?=
 =?utf-8?B?bXp0SS9nWmNKU0hSdG9seU1zNFVYSXdGcFlGZGIzaHdDSGxVOERwQUxtQ0xX?=
 =?utf-8?B?TDlWUUVtRnlRZk1xZjU4Qlo1SE1BdnplYjUwR3Nub1lDWUZ1NnBaNFZwaGRY?=
 =?utf-8?B?c0JUMWhtaE1RMm5jdHVGeTdVWTF0Qm9Lbk9XbVZxY3NBNkxsd2pzUEUvNEJK?=
 =?utf-8?B?a0NwMVh5MlpkK1lWUlBNVzhMeXZqRG83Nng2c09PV1NmN0JsaDBjYXg3TDAz?=
 =?utf-8?B?RTBENmN3cmVwUnovaTR0SjFrR01PYWlQcXQ5eVkxMXNRVDM0S2ZTUWhSWXYw?=
 =?utf-8?B?Q0JvL2I0QU9nN1grZUFiWDZrZ2dhaW1MSStrVzdUUkNuZVEzRUw3MXJDNVJW?=
 =?utf-8?B?NUEweVJGby9IVm5DczkwTzVYZFpMOWdpTlFCMHpYNHgxWlN1V0JvdDBsbVEz?=
 =?utf-8?B?bTlnUUdydlRSKzFmZFFYWjlTRUFqTkdGaklXNXJJSzRINUg1UVFyUCtWU3Qv?=
 =?utf-8?B?ZkNHZTJQdzhjN3RFMkxXTysxd0IvSHhWQ0cwSzRwZmpmdVFZUkpYQ3NrYlJa?=
 =?utf-8?B?a2EyeU5mUVVOaXZuZGhPOUFFV1drT2xNWFY1ZmhqaWEyOVl4cXh6Z0ZnNFhJ?=
 =?utf-8?B?REFaZlpXUkNvRWYxYXZFY3RhOWdCalRjYjJ2TWY3Zmlsb3pDSHM5NlpPamhi?=
 =?utf-8?B?OWhCa2NZM1lkUzNoa3V4VytrRDUwWmpqM2l6TnRzRDFWTlQ3bHkwdkpEdXI0?=
 =?utf-8?B?dkxJNGxaMEFqYjdRblBhTE9UM2FHZ2gzS0k2by84VmQxeW85M084cGFqcW05?=
 =?utf-8?B?aTMxUUFKazExd1NXa2JkZnVJRXJhWmdzdDlGZUpNY3c4ako5bW45QWVTSHBz?=
 =?utf-8?B?a0VGNVhwZHN3ZEJoMlArbFEybEFYWHRHak1GUkNHTXl3N1hraXBQN2huekVL?=
 =?utf-8?B?THBocnZGckR0ZUUwQTJrVG1IczFFOHJJL0RyTXFDOUQvSWZ3UEMzeVQxMFIw?=
 =?utf-8?B?RmVaQXZrd3JsMjlQSWdtK2dpcGlVNnBIYUtSRUFlakhncEFocGZsTnFublZ2?=
 =?utf-8?B?cDhJSjRHa05IQmh4WXdzSkN2ZXFYMGhHUWtMQlN6Nkk2eWd4NmRJTk43a3Y0?=
 =?utf-8?B?T200anFibHoxMjJqWmdWTWxkQ25MNmxYdE1WaFFlaEpEcGhVUzZiZU9BTGt3?=
 =?utf-8?B?dk1QYVBaZE5DZ21IeG5QOXFMRFNNdWlZNWdPVmFQMUF2Tlk3N0FlZTZoUzY2?=
 =?utf-8?B?cGZ2bHBqdmtwcTFwRGlJQUF4Z1U5TDNVK2VCZjhqYmNRQU9BSzduakZRdis4?=
 =?utf-8?Q?wxOfhg5WjKdPTs8TpkFy8TdOW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219132b2-0d92-425c-818e-08dda7bdae5e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 01:25:27.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gV9fFcV9hT6OmnUeT4yJ4/RDgl/LA3jdPWd4rAAW34OiH4U+FAl0G24s8we/JjExltB4wR16XFMIgejHgGPXgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631

Hi Jonathan,

On 6/9/2025 5:54 AM, Jonathan Cameron wrote:
> On Tue, 3 Jun 2025 22:19:47 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
>>
>> Previously, when CXL regions were created through autodiscovery and their
>> resources overlapped with SOFT RESERVED ranges, the soft reserved resource
>> remained in place after region teardown. This left the HPA range
>> unavailable for reuse even after the region was destroyed.
>>
>> Enhance the logic to reliably remove SOFT RESERVED resources associated
>> with a region, regardless of alignment or hierarchy in the iomem tree.
>>
>> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
>> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/acpi.c        |   2 +
>>   drivers/cxl/core/region.c | 151 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   5 ++
>>   3 files changed, 158 insertions(+)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 978f63b32b41..1b1388feb36d 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -823,6 +823,8 @@ static void cxl_softreserv_mem_work_fn(struct work_struct *work)
>>   	 * and cxl_mem drivers are loaded.
>>   	 */
>>   	wait_for_device_probe();
>> +
>> +	cxl_region_softreserv_update();
>>   }
>>   static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
>>   
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 109b8a98c4c7..3a5ca44d65f3 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3443,6 +3443,157 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
>>   
>> +static int add_soft_reserved(resource_size_t start, resource_size_t len,
>> +			     unsigned long flags)
>> +{
>> +	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
>> +	int rc;
>> +
>> +	if (!res)
>> +		return -ENOMEM;
>> +
>> +	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
>> +
>> +	res->desc = IORES_DESC_SOFT_RESERVED;
>> +	res->flags = flags;
> 
> I'm a bit doubtful about using a define that restricts a bunch of the
> elements, then overriding 2 of them immediate after.
> 
> DEFINE_RES_NAMED_DESC(start, len, "Soft Reserved", flags | IORESOURCE_MEM,
> 		      IORES_DESC_SOFT_RESERVED);

Sure, I will change to the above.

> 
>> +	rc = insert_resource(&iomem_resource, res);
>> +	if (rc) {
>> +		kfree(res);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
>> +				 resource_size_t start, resource_size_t end)
>> +{
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	resource_size_t new_start, new_end;
>> +	int rc;
>> +
>> +	/* Prevent new usage while removing or adjusting the resource */
>> +	guard(mutex)(&cxlrd->range_lock);
>> +
>> +	/* Aligns at both resource start and end */
>> +	if (soft->start == start && soft->end == end)
>> +		goto remove;
>> +
> 
> Might be a clearer flow with else if rather than
> a goto.

Okay will change.

> 
>> +	/* Aligns at either resource start or end */
>> +	if (soft->start == start || soft->end == end) {
>> +		if (soft->start == start) {
>> +			new_start = end + 1;
>> +			new_end = soft->end;
>> +		} else {
>> +			new_start = soft->start;
>> +			new_end = start - 1;
>> +		}
>> +
>> +		rc = add_soft_reserved(new_start, new_end - new_start + 1,
>> +				       soft->flags);
> 
> This is the remnant of what was there before, but the flags are from
> the bit we are dropping?  That feels odd.  They might well be the same
> but maybe we need to make that explicit?

Okay. Probably I can update code to clarify this by adding a comment, or 
I can also filter or copy only the relevant flag bits if you think 
that's more appropriate.

> 
>> +		if (rc)
>> +			dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
>> +				 &new_start);
>> +
>> +		/* Remove the original Soft Reserved resource */
>> +		goto remove;
>> +	}
>> +
>> +	/*
>> +	 * No alignment. Attempt a 3-way split that removes the part of
>> +	 * the resource the region occupied, and then creates new soft
>> +	 * reserved resources for the leading and trailing addr space.
>> +	 */
>> +	new_start = soft->start;
>> +	new_end = soft->end;
>> +
>> +	rc = add_soft_reserved(new_start, start - new_start, soft->flags);
>> +	if (rc)
>> +		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
>> +			 &new_start);
>> +
>> +	rc = add_soft_reserved(end + 1, new_end - end, soft->flags);
>> +	if (rc)
>> +		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa + 1\n",
>> +			 &end);
>> +
>> +remove:
>> +	rc = remove_resource(soft);
>> +	if (rc)
>> +		dev_warn(&cxlr->dev, "cannot remove soft reserved resource %pr\n",
>> +			 soft);
>> +}
>> +
>> +/*
>> + * normalize_resource
>> + *
>> + * The walk_iomem_res_desc() returns a copy of a resource, not a reference
>> + * to the actual resource in the iomem_resource tree. As a result,
>> + * __release_resource() which relies on pointer equality will fail.
> 
> Probably want some statement on why nothing can race with this give
> the resource_lock is not being held.

Hmm, probably you are right that normalize_resource() is accessing the 
resource tree without holding resource_lock, which could lead to races.

I will update the function to take a read_lock(&resource_lock) before 
walking res->parent->child..

Let me know if you'd prefer this locking be handled before calling 
normalize_resource() instead..

> 
>> + *
>> + * This helper walks the children of the resource's parent to find and
>> + * return the original resource pointer that matches the given resource's
>> + * start and end addresses.
>> + *
>> + * Return: Pointer to the matching original resource in iomem_resource, or
>> + *         NULL if not found or invalid input.
>> + */
>> +static struct resource *normalize_resource(struct resource *res)
>> +{
>> +	if (!res || !res->parent)
>> +		return NULL;
>> +
>> +	for (struct resource *res_iter = res->parent->child;
>> +	     res_iter != NULL; res_iter = res_iter->sibling) {
> 
> I'd move the res_iter != NULL to previous line as it is still under 80 chars.

Sure will fix.

> 
> 
>> +		if ((res_iter->start == res->start) &&
>> +		    (res_iter->end == res->end))
>> +			return res_iter;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int __cxl_region_softreserv_update(struct resource *soft,
>> +					  void *_cxlr)
>> +{
>> +	struct cxl_region *cxlr = _cxlr;
>> +	struct resource *res = cxlr->params.res;
>> +
>> +	/* Skip non-intersecting soft-reserved regions */
>> +	if (soft->end < res->start || soft->start > res->end)
>> +		return 0;
>> +
>> +	soft = normalize_resource(soft);
>> +	if (!soft)
>> +		return -EINVAL;
>> +
>> +	remove_soft_reserved(cxlr, soft, res->start, res->end);
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_region_softreserv_update(void)
>> +{
>> +	struct device *dev = NULL;
>> +
>> +	while ((dev = bus_find_next_device(&cxl_bus_type, dev))) {
>> +		struct device *put_dev __free(put_device) = dev;
> This free is a little bit outside of the constructor and destructor
> together rules.
> 
> I wonder if bus_for_each_dev() is cleaner here or is there a reason
> we have to have released the subsystem lock + grabbed the device
> one before calling __cxl_region_softreserv_update?

Thanks for the suggestion. I will replace the bus_find_next_device() 
with bus_for_each_dev(). I think bus_for_each_dev() simplifies the flow 
as there's also no need to call put_device() explicitly.

Thanks
Smita

> 
>> +		struct cxl_region *cxlr;
>> +
>> +		if (!is_cxl_region(dev))
>> +			continue;
> If you stick to bus_find_X   I wonder if we should define helpers for
> 
> the match function and use bus_find_device()
> 
>> +
>> +		cxlr = to_cxl_region(dev);
>> +
>> +		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
>> +				    IORESOURCE_MEM, 0, -1, cxlr,
>> +				    __cxl_region_softreserv_update);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
> 
> 


