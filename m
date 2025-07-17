Return-Path: <linux-fsdevel+bounces-55303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D92B0971F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD14F1C20310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E2242D7C;
	Thu, 17 Jul 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1hBbk02x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676E881E;
	Thu, 17 Jul 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794459; cv=fail; b=cf+jpQSTW5zMeg1fxlXQwiwlCDqfUSM8mDlvaa5PH5npHbEdF3wTOqsu7qomUPWcRzW7xnKHrL5EX2BBhpBTMsqQ1KrP2cL5ZE8k+IdvlGcay7gopo7WI6S/G6fvit+mrTZqQ4vigVnhy/2lh1ARr2/5yEGLFHWAEN+n0fCP1Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794459; c=relaxed/simple;
	bh=lgm7BtLrKZL4MGeahZdAgu46Vp2muF22qUjSFIJ+sB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EFhj/VJbvSP3wOSgND2ArEWbWc3HsK/saS9sJA6pQv0Z7Hnh+J+/7cziQrEyvDPTbHdyvoIYjZapLVo8gjCkdMOMxeXh/ZP14xcetOowZTU3q9C2TzlH1YUM+ZZM5x84bbmtBaM8KxjMz73YSGSmK7kvuDou9DOgnZW9FNw8LFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1hBbk02x; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3V9YWExLt9tXITCYOv8RuOWOmr9Qk8AwocIJxlljVFYJEXnJcIG8mmyDn7MjXaaUxv8OfxJWKBAP289/gzjRhCRMIMDbbGOd5kNEf7X7TjvVBj4yYW0Zw2vohBonVg/qyB8r61PxxIxU/4EZEpZ55vheA3WR2Hadzx7/UXZd+g3iQum0VaLMYwB4O6fMyLFb2ADU/1zZ68ujSyka40rMZvq8onHQtTfapAKpSV8I9+xn+c8VAyZl1yuxTKWiH+ImNQUWy0901jhgSCIOPP7rqMGqAgLSrMPat6LyZBqP8ydS1fD2ok69j3MxHa2pAGzm8xbPJ0fDcHM1DeHq0jVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zj38vrGor1G9NUFikZ6RYBg7mJZp/fj2zNGD1igG/ag=;
 b=TkjH4eStsqF+MbrN9JaIUdipn/tm+VBO15w2e48r/WWzK5xNigAWdi22cQJUxnDq12dFVosXGNGrOCZO1yB7GzlFcEMXeSkP+ITpCf0hGb+MMm7uliS+c47GmSPW1V09wBPySGBLpeOLZ1yqYHOqQh5wFIgsypFitzQrdoveHFselX77uRU2C59lSkFxMJBs4OczfBbKsjt046PlUewmWkmA+M5gRVaGtZfayeQCEyO2O5pxP/YfXXMgVseStVC/6RLjS3pICZS/5tvavRdOzunTCuRmrbF72YYv8ruevhNQmphWgiLpfdedcFvDzoTm8Myid4DWGJjqiYQcNqRa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj38vrGor1G9NUFikZ6RYBg7mJZp/fj2zNGD1igG/ag=;
 b=1hBbk02xOGbCOQ01se4JW5ww5d6hmwu/417tyKFp6e8hNCxLSukAKO/Ts87FgmViZMoootyhKI7FAPI3YegVbPsVT1GS+W12OxYguDIF7wO7DaPBCaqQkco9fv2OxfADn8s9VDRn/ckBz8l8rY/MTsB+Poq+1QZTFNZgJoDCxBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 23:20:54 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 23:20:54 +0000
Message-ID: <c6891159-1f86-48d8-b411-7115fddf261c@amd.com>
Date: Thu, 17 Jul 2025 16:20:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add managed SOFT RESERVE resource handling
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
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
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <aHbDLaKt30TglvFa@aschofie-mobl2.lan>
 <4ac55e2c-54a9-4fab-b0c5-2a928faef33e@amd.com>
 <aHgJq6mZiATsY-nX@aschofie-mobl2.lan>
 <9fc29940-3d73-4c71-bb2d-e0c9a0259228@amd.com>
 <aHg6Ri74pew-lenA@aschofie-mobl2.lan>
 <844ed7f7-f185-4706-a0ab-efc2f93e6ebb@amd.com>
 <d6844c8e-ea40-451e-8607-a8e6bb4f352b@intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <d6844c8e-ea40-451e-8607-a8e6bb4f352b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 531e71a9-75f6-42da-97ac-08ddc58893e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0toMUJ0WVRrNGVQS2NHYmUybDNoRm9HS3FJQnBkYm1EZjVkcFpldU91ZEJJ?=
 =?utf-8?B?U0NOQitMaEFPYlpqZnJLeDBYN2dmUTMvRnZrRWNmU3hMQmhsNXNySkg1WmRl?=
 =?utf-8?B?QlRuaXNNVERsQkFCeWJaMHAzOXBCTm9DTVFhaXQ5ZXFzRmdvZTdiVDJObTQv?=
 =?utf-8?B?M3pmYmFJVmpHNFNrNU5Ja09NQmhKMU54T3dVeXdWUjVxUEJwak95cEVhRjlK?=
 =?utf-8?B?eG1LWmdIUmE3Q1JHTDFCUURWcWx5ZkFBckJIZTJ5NmNDeGs3YVhpWDAzNVdB?=
 =?utf-8?B?NTQ1eDlUM1JSc0FZYjQzM0NyYUVVS3JnR3gydW9iUHR5UklDeTJqWDFvUGhK?=
 =?utf-8?B?Sm1Bc0tDVVk0OEFYWmp4Q2srSkZVMHByYkVQVVdZbVlPY3ZlUHpIcFBneDNT?=
 =?utf-8?B?dE5OczhleXlUZi9LZUFKdmRJSEtaQ2tmZGV2NWVEMlM3WVU4WElaTUUxVSt5?=
 =?utf-8?B?cnhBbTJMUXlqWXJCcDVCbXo5aEVsYkFkYVg2cW9Ob29rZ2FWekFuRlk0YThi?=
 =?utf-8?B?MnZQOW1idWFwSHF6bVY5Y0U2dnI2QWYxV2pHeGRsdXcwQlRNcjAzRFJEbDlZ?=
 =?utf-8?B?enBwa2ZiRUEyZThKQXRVZVgxeE5pOWlkSGhZaWxTZ04yRzhzU0RhcE9kKzdU?=
 =?utf-8?B?ajYrVFN6SWtLZTVuOWRHU3BKYmF2eGpMcVpLSnhsR3E1ZDRQNjFDZzdCbHE3?=
 =?utf-8?B?OGRTU1dINGpDa1dGL1FtQjQrOGNUc1FDUkQ4VG5FVVVTd0NjWVFkOXhrTmJB?=
 =?utf-8?B?NnpzeHg1VExMZFBINzN3dGZBVTZpRndqUUlyK2hhYnZ3YjJoR1pSbFRnOUk5?=
 =?utf-8?B?WlVGLzliUUpVWUJKMXlhdWo0ZVdKZzkxZXovR2x6MVFMbkhvc0Nwa3ZlTFY1?=
 =?utf-8?B?TnAveVBaQVUyNUVSbzEzS011c1lxZVRCKy9nbDcyK2FKVnpZZFMvbnM5QWV2?=
 =?utf-8?B?STVXYzZUeVArSG03SWNSVTU2dTZOQjFOYVcvRmIxR2JhYk40UmZla3YybW9K?=
 =?utf-8?B?V2ZpSW1ibkRMTHdLd2FGYStjMHA5Vi9OVHdzNVJqR3loRWpYMUlmaTdybFN1?=
 =?utf-8?B?czNITGZ4MTBOZWlzRytLSU1LREpnMzkyMW45NjE0TFJBck92N0NrOGc5ckRJ?=
 =?utf-8?B?S3BRMk9XWlZmZmY3Wk0wcTJRa1lVYWU5Q2J1Wi9maU16a2VOSUFZNEZWcVRn?=
 =?utf-8?B?Yi9OT0lOQVVrM0oyei9zb3JSNmh0bW9zTW1KWG0yTytwaXg1Q1d0eHk2QVFX?=
 =?utf-8?B?UGp4YzVSaGRqRlYwa0dQY3FWa2dWZllQVER5REdUVlNUMEVML3NkUGpyblZp?=
 =?utf-8?B?Vjk5Qi8vck04dGdPb3RGTFpqb3NjbS93Wmhmd25ZNlBkcmRaK2N4YytwbDJL?=
 =?utf-8?B?emEwRThOMzl5QUhUUGREbSs3aWpKWWpIM2VDOEo0Y0hHaHhmeU9NYXZsSXJH?=
 =?utf-8?B?K0lDc3c4dDZ5K3Z2SFBBT2dMdUZYWG5nY0xjQmFBUGord0piWUhjeXE1YndW?=
 =?utf-8?B?NUFPT3pzU1NQQ3NOVWQyU2lFNHFYZWFzdy9RUStmZ0JiakhDWjYrUXc2TjRW?=
 =?utf-8?B?S1hkSkJiUUtEeDdEV3cwZFF6ZDloVE0xakRtTU96eGM5dy9WdmZVdG0yaW0x?=
 =?utf-8?B?dk1tall3bGd6UHFzYVlzOFBVRHl0dzdNMXVNdXBmeldBRTRUMXFuWEk1SG9I?=
 =?utf-8?B?Qks5YXcvVDl6bGlJd2d1VnU0SjNRMkZZTzh0KzRoeFgwMS9GV2JnRStJMG9a?=
 =?utf-8?B?blZxSVhrZGJUcEpVTm5qWjNLWlIyMzB5bHZCQzZGZVhlRHRseGZ0d1ZUckht?=
 =?utf-8?B?WXZGUmF3b09vK1lHZHpJNjBYbEttRFp4OFpjbktvaUZhRGtTY01BUCtUS042?=
 =?utf-8?B?RmRxWEQ0VTE2TWExSldSYzMzZVZHMnhTMHZuWnVPajhCSm8wdnNuZm81OEdW?=
 =?utf-8?Q?KlzNVOSuuf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXh6TFVwVHBVNnVwbFBzaHRUUlJtYTZ5UExuSFE5NkdncFJ5R2w2OEdFQ1Nr?=
 =?utf-8?B?aUxjcG9WMCtSMTRpRzNNUXhaNnZERnJMQndOemlkK1d1THU0RkFLb3c3TERm?=
 =?utf-8?B?S29SVkpiUEczSWNjRmdHNlRqdHBYRnJnWVNlRnRxU2t5NTZVY1NRYkh6eWpz?=
 =?utf-8?B?SDFPVVNoLy9TM1pYVVd2V1lwbkRKTmxHRUEvclBSMXdSaEhIVFplVyswYkdQ?=
 =?utf-8?B?NFovaW9vdXVzb1gvQlJUSHBXY0ZBQlhaSXZncTYzWmkweXN1V2dCUG5VcFFx?=
 =?utf-8?B?aWFWU29hekFtSVBrYi9XNXpSbjgzaW8vWWRuNUhXTWhBZ0FUdVZyQllZMkR0?=
 =?utf-8?B?WHFvc3JSRk1jQ01YVVA5RkJrWi9SMHpqdUVyUWIvQ3oyZ1ZKVUY1TjJHZmRk?=
 =?utf-8?B?enhJdkxDWU5TZnFTVzQxV3pvZEJBVVgzVExwYzhPaExYcVk3bGFOeFhFOVBL?=
 =?utf-8?B?ZVdLbURIc2tqRk15aStLVnNYS203MWJoSHh1RzAyNnpmdVU2cEFMRjA3aGgw?=
 =?utf-8?B?K3puODdsN2x1TXFUb1Q4OEI4ZGRKbWh2K1MzS04xNnNrcXZzQWgwbjc2ZEhx?=
 =?utf-8?B?eTVEWGV1VU9qNnZvV2N6ZXZZZWh2V09oWDBqcW5XdmRDdDZVNVl6Wms4Y2Ex?=
 =?utf-8?B?TVhIN3VSTUdqa3c4K1BYVEFXclJaOHVkOWp1TXNqM3JjdW1xeEV5eGpaYXll?=
 =?utf-8?B?b3lEWWFtTDM2TWxzbXBMVXBEZE9tWm1DNmhWeGJ6SUVlUXhyQ040OEFEY04r?=
 =?utf-8?B?Y0t0WEEvZmN0dXhLNEdzclBKRmZwOGx6L0FqdCtGdVhWSm9BNmVlUEFuYTlR?=
 =?utf-8?B?R3R0Rlh3Z01USzhTNjlyT2UxZ1JiZmNOeHdKWXBGeTd1dVE2NVBqaEhRMzFi?=
 =?utf-8?B?WXNpZ2FpbkFmdUNoN3IyejhoYWpYR3NBb0FNU1lLUW1VZW12L1dpdXpMVVA0?=
 =?utf-8?B?SmI5MXFaVEIyNzh3QkxvVW5lVis4c29FdlYzekFGVUVXNWZlbHE0THRWblVQ?=
 =?utf-8?B?V1ZBeFVGVmwzMlcwcWNmMktrd1pwMTBJdGV1ZTJ3OUxDR0tTUnN5VVJyeVBV?=
 =?utf-8?B?RFhSc2R0R08weUpNYjFtTFphMDFrbHVqcUhtTThwV002elpwQ1d1TEFhaVZU?=
 =?utf-8?B?OUZ6UlE3bnNxeTVnK1Y0MkU2bkJmNFh3QUZjNkdCNVBCOWZBT2VHZmxUUzRt?=
 =?utf-8?B?TEEvTS9uTWc2S0hpaUJxQXNVaHlacjVsTHl1YTV1ZU9HRlR5cm9jSVJ1SkhJ?=
 =?utf-8?B?d1gxZWM1RjNyeENzL2NBbnFDZiswQ2ZwS1ZDVGhrVjBkSkxGQmpXS1ZYbFBL?=
 =?utf-8?B?dUJ4cXFZTU9JR0dHVWlrQ0lXYXBtdXBWZ2pIbUNsczlDS1lvU3VsZ096TEpp?=
 =?utf-8?B?aFBJL05vVGdTWnpiZ1kzeFkyYUV6d09QZ09KM1NuWUZvRlArWkY2NE9wQUho?=
 =?utf-8?B?dTBwS3hNaDJXTE9WWEpjb3pEenpwMGZWSmd3VWlQR08rZDJGTDAwR0V2Zkd6?=
 =?utf-8?B?WVpCV0c5QVoxaTk4ek5wdjk1M211OXFMODFoNSt4WnZSdlVkR21PYkpJSVlm?=
 =?utf-8?B?YU1sbEJ6bnRvMlczNWc0eE14YUpScy9Hb25lYUVHWU1pZ3pXNStXUGxnN3Jx?=
 =?utf-8?B?ejRpcisrcWxITDk3YjFFVnBYMnRWSml4czBya1Vab1FPcWRzWHpoWVZyeDdP?=
 =?utf-8?B?c3pmT2FYbFpXaldBMit0R0hzQVg4bkJiVm9MQjZZZVdyTzJBOVdiQnBWdWRF?=
 =?utf-8?B?T2w5M25nbTkyZVdHcVRTUzRSbjdHTWNEdDFnSmMzTFA3VEo1TUVSbVp2ckNX?=
 =?utf-8?B?dWwxN0lXdGJpRFFndzV0bm5XVk5acGxWeHF2aStYMW5Bd2hGUXg5bGxVeisx?=
 =?utf-8?B?T1c3YzJBUHJuVlFMS2FHU1FxSTdBUkoyWnNsSUZJZHVOeWZ4MUpkcUZZN1NK?=
 =?utf-8?B?SjY3ekNtR1ZyT2FSZi82Si9Tb1pzYm5zSjk1bmJLeVIwM0Q3K3d2cU1kZTVn?=
 =?utf-8?B?MmlSU01raXRBZllEZU42aVU2RWh2MkQ1a25jNGhNcEVVdldBU2xUVlhTVUEz?=
 =?utf-8?B?djBNbHV2YmQwQlVvMmxOc3N4bFB6bm8vYWdKK1BPZnBGL25rczM2S1FpMDcv?=
 =?utf-8?Q?bTbjnAzQ013CMw3oFrWtjNNAO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531e71a9-75f6-42da-97ac-08ddc58893e4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:20:54.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPSJCek7G7y0if4X5Ic8f6rFT2NXk8l5dq4CKoChpFr/2AUO+XF3pdOus3UY7kQrkiCQtkFOR/Msa1KOoV9xkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF

On 7/17/2025 12:06 PM, Dave Jiang wrote:
> 
> 
> On 7/17/25 10:58 AM, Koralahalli Channabasappa, Smita wrote:
>>
>>
>> On 7/16/2025 4:48 PM, Alison Schofield wrote:
>>> On Wed, Jul 16, 2025 at 02:29:52PM -0700, Koralahalli Channabasappa, Smita wrote:
>>>> On 7/16/2025 1:20 PM, Alison Schofield wrote:
>>>>> On Tue, Jul 15, 2025 at 11:01:23PM -0700, Koralahalli Channabasappa, Smita wrote:
>>>>>> Hi Alison,
>>>>>>
>>>>>> On 7/15/2025 2:07 PM, Alison Schofield wrote:
>>>>>>> On Tue, Jul 15, 2025 at 06:04:00PM +0000, Smita Koralahalli wrote:
>>>>>>>> This series introduces the ability to manage SOFT RESERVED iomem
>>>>>>>> resources, enabling the CXL driver to remove any portions that
>>>>>>>> intersect with created CXL regions.
>>>>>>>
>>>>>>> Hi Smita,
>>>>>>>
>>>>>>> This set applied cleanly to todays cxl-next but fails like appended
>>>>>>> before region probe.
>>>>>>>
>>>>>>> BTW - there were sparse warnings in the build that look related:
>>>>>>>       CHECK   drivers/dax/hmem/hmem_notify.c
>>>>>>> drivers/dax/hmem/hmem_notify.c:10:6: warning: context imbalance in 'hmem_register_fallback_handler' - wrong count at exit
>>>>>>> drivers/dax/hmem/hmem_notify.c:24:9: warning: context imbalance in 'hmem_fallback_register_device' - wrong count at exit
>>>>>>
>>>>>> Thanks for pointing this bug. I failed to release the spinlock before
>>>>>> calling hmem_register_device(), which internally calls platform_device_add()
>>>>>> and can sleep. The following fix addresses that bug. I’ll incorporate this
>>>>>> into v6:
>>>>>>
>>>>>> diff --git a/drivers/dax/hmem/hmem_notify.c b/drivers/dax/hmem/hmem_notify.c
>>>>>> index 6c276c5bd51d..8f411f3fe7bd 100644
>>>>>> --- a/drivers/dax/hmem/hmem_notify.c
>>>>>> +++ b/drivers/dax/hmem/hmem_notify.c
>>>>>> @@ -18,8 +18,9 @@ void hmem_fallback_register_device(int target_nid, const
>>>>>> struct resource *res)
>>>>>>     {
>>>>>>            walk_hmem_fn hmem_fn;
>>>>>>
>>>>>> -       guard(spinlock)(&hmem_notify_lock);
>>>>>> +       spin_lock(&hmem_notify_lock);
>>>>>>            hmem_fn = hmem_fallback_fn;
>>>>>> +       spin_unlock(&hmem_notify_lock);
>>>>>>
>>>>>>            if (hmem_fn)
>>>>>>                    hmem_fn(target_nid, res);
>>>>>> -- 
>>>>>
>>>>> Hi Smita,  Adding the above got me past that, and doubling the timeout
>>>>> below stopped that from happening. After that, I haven't had time to
>>>>> trace so, I'll just dump on you for now:
>>>>>
>>>>> In /proc/iomem
>>>>> Here, we see a regions resource, no CXL Window, and no dax, and no
>>>>> actual region, not even disabled, is available.
>>>>> c080000000-c47fffffff : region0
>>>>>
>>>>> And, here no CXL Window, no region, and a soft reserved.
>>>>> 68e80000000-70e7fffffff : Soft Reserved
>>>>>      68e80000000-70e7fffffff : dax1.0
>>>>>        68e80000000-70e7fffffff : System RAM (kmem)
>>>>>
>>>>> I haven't yet walked through the v4 to v5 changes so I'll do that next.
>>>>
>>>> Hi Alison,
>>>>
>>>> To help better understand the current behavior, could you share more about
>>>> your platform configuration? specifically, are there two memory cards
>>>> involved? One at c080000000 (which appears as region0) and another at
>>>> 68e80000000 (which is falling back to kmem via dax1.0)? Additionally, how
>>>> are the Soft Reserved ranges laid out on your system for these cards? I'm
>>>> trying to understand the "before" state of the resources i.e, prior to
>>>> trimming applied by my patches.
>>>
>>> Here are the soft reserveds -
>>> [] BIOS-e820: [mem 0x000000c080000000-0x000000c47fffffff] soft reserved
>>> [] BIOS-e820: [mem 0x0000068e80000000-0x0000070e7fffffff] soft reserved
>>>
>>> And this is what we expect -
>>>
>>> c080000000-17dbfffffff : CXL Window 0
>>>     c080000000-c47fffffff : region2
>>>       c080000000-c47fffffff : dax0.0
>>>         c080000000-c47fffffff : System RAM (kmem)
>>>
>>>
>>> 68e80000000-8d37fffffff : CXL Window 1
>>>     68e80000000-70e7fffffff : region5
>>>       68e80000000-70e7fffffff : dax1.0
>>>         68e80000000-70e7fffffff : System RAM (kmem)
>>>
>>> And, like in prev message, iv v5 we get -
>>>
>>> c080000000-c47fffffff : region0
>>>
>>> 68e80000000-70e7fffffff : Soft Reserved
>>>     68e80000000-70e7fffffff : dax1.0
>>>       68e80000000-70e7fffffff : System RAM (kmem)
>>>
>>>
>>> In v4, we 'almost' had what we expect, except that the HMEM driver
>>> created those dax devices our of Soft Reserveds before region driver
>>> could do same.
>>>
>>
>> Yeah, the only part I’m uncertain about in v5 is scheduling the fallback work from the failure path of cxl_acpi_probe(). That doesn’t feel like the right place to do it, and I suspect it might be contributing to the unexpected behavior.
>>
>> v4 had most of the necessary pieces in place, but it didn’t handle situations well when the driver load order didn’t go as expected.
>>
>> Even if we modify v4 to avoid triggering hmem_register_device() directly from cxl_acpi_probe() which helps avoid unresolved symbol errors when cxl_acpi_probe() loads too early, and instead only rely on dax_hmem to pick up Soft Reserved regions after cxl_acpi creates regions, we still run into timing issues..
>>
>> Specifically, there's no guarantee that hmem_register_device() will correctly skip the following check if the region state isn't fully ready, even with MODULE_SOFTDEP("pre: cxl_acpi") or using late_initcall() (which I tried):
>>
>> if (IS_ENABLED(CONFIG_CXL_REGION) &&
>>          region_intersects(res->start, resource_size(res), IORESOURCE_MEM, IORES_DESC_CXL) != REGION_DISJOINT) {..
>>
>> At this point, I’m running out of ideas on how to reliably coordinate this.. :(
>>
>> Thanks
>> Smita
>>
>>>>
>>>> Also, do you think it's feasible to change the direction of the soft reserve
>>>> trimming, that is, defer it until after CXL region or memdev creation is
>>>> complete? In this case it would be trimmed after but inline the existing
>>>> region or memdev creation. This might simplify the flow by removing the need
>>>> for wait_event_timeout(), wait_for_device_probe() and the workqueue logic
>>>> inside cxl_acpi_probe().
>>>
>>> Yes that aligns with my simple thinking. There's the trimming after a region
>>> is successfully created, and it seems that could simply be called at the end
>>> of *that* region creation.
>>>
>>> Then, there's the round up of all the unused Soft Reserveds, and that has
>>> to wait until after all regions are created, ie. all endpoints have arrived
>>> and we've given up all hope of creating another region in that space.
>>> That's the timing challenge.
>>>
>>> -- Alison
>>>
>>>>
>>>> (As a side note I experimented changing cxl_acpi_init() to a late_initcall()
>>>> and observed that it consistently avoided probe ordering issues in my setup.
>>>>
>>>> Additional note: I realized that even when cxl_acpi_probe() fails, the
>>>> fallback DAX registration path (via cxl_softreserv_mem_update()) still waits
>>>> on cxl_mem_active() and wait_for_device_probe(). I plan to address this in
>>>> v6 by immediately triggering fallback DAX registration
>>>> (hmem_register_device()) when the ACPI probe fails, instead of waiting.)
>>>>
>>>> Thanks
>>>> Smita
>>>>
>>>>>
>>>>>>
>>>>>> As for the log:
>>>>>> [   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for
>>>>>> cxl_mem probing
>>>>>>
>>>>>> I’m still analyzing that. Here's what was my thought process so far.
>>>>>>
>>>>>> - This occurs when cxl_acpi_probe() runs significantly earlier than
>>>>>> cxl_mem_probe(), so CXL region creation (which happens in
>>>>>> cxl_port_endpoint_probe()) may or may not have completed by the time
>>>>>> trimming is attempted.
>>>>>>
>>>>>> - Both cxl_acpi and cxl_mem have MODULE_SOFTDEPs on cxl_port. This does
>>>>>> guarantee load order when all components are built as modules. So even if
>>>>>> the timeout occurs and cxl_mem_probe() hasn’t run within the wait window,
>>>>>> MODULE_SOFTDEP ensures that cxl_port is loaded before both cxl_acpi and
>>>>>> cxl_mem in modular configurations. As a result, region creation is
>>>>>> eventually guaranteed, and wait_for_device_probe() will succeed once the
>>>>>> relevant probes complete.
>>>>>>
>>>>>> - However, when both CONFIG_CXL_PORT=y and CONFIG_CXL_ACPI=y, there's no
>>>>>> guarantee of probe ordering. In such cases, cxl_acpi_probe() may finish
>>>>>> before cxl_port_probe() even begins, which can cause wait_for_device_probe()
>>>>>> to return prematurely and trigger the timeout.
>>>>>>
>>>>>> - In my local setup, I observed that a 30-second timeout was generally
>>>>>> sufficient to catch this race, allowing cxl_port_probe() to load while
>>>>>> cxl_acpi_probe() is still active. Since we cannot mix built-in and modular
>>>>>> components (i.e., have cxl_acpi=y and cxl_port=m), the timeout serves as a
>>>>>> best-effort mechanism. After the timeout, wait_for_device_probe() ensures
>>>>>> cxl_port_probe() has completed before trimming proceeds, making the logic
>>>>>> good enough to most boot-time races.
>>>>>>
>>>>>> One possible improvement I’m considering is to schedule a
>>>>>> delayed_workqueue() from cxl_acpi_probe(). This deferred work could wait
>>>>>> slightly longer for cxl_mem_probe() to complete (which itself softdeps on
>>>>>> cxl_port) before initiating the soft reserve trimming.
>>>>>>
>>>>>> That said, I'm still evaluating better options to more robustly coordinate
>>>>>> probe ordering between cxl_acpi, cxl_port, cxl_mem and cxl_region and
>>>>>> looking for suggestions here.
> 
> Hi Smita,
> Reading this thread and thinking about what can be done to deal with this. Throwing out some ideas and see what you think. My idea is to create two global counters that are are protected by a lock. You hava delayed workqueue that checks these counters. If counter1 is 0, go back to sleep and check later continuously with a reasonable time period. Every time a memdev endpoint starts probe, increment counter1 and counter2 atomically. Every time the probe is successful, decrement counter2. When you reach the condition of 'if (counter1 && counter2 == 0)' I think you can start soft reserve discovery.
> 
> A different idea came from Dan. Arm a timer on the first memdev probe. Kick the timer to increment every time a new memdev gets probed. At some point things settles and timer goes off to trigger soft reserved discovery.
> 
> I think either one will not require special ordering of the modules being loaded.
> 
> DJ

I think we might need both, the counters and a settling timer to 
coordinate Soft Reserved trimming and DAX registration.

Here's the rough flow I'm thinking of. Let me know the flaws in this 
approach.

1. cxl_acpi_probe() schedules cxl_softreserv_work_fn() and exits early.
This work item is responsible for trimming leftover Soft Reserved memory 
ranges once all cxl_mem devices have finished probing.

2. A delayed work is initialized for the settle timer:

INIT_DELAYED_WORK(&cxl_probe_settle_work, cxl_probe_settle_fn);

3. In cxl_mem_probe():
      - Increment counter2 (memdevs in progress).
      - Increment counter1 (memdevs discovered).
      - On probe completion (success or failure), decrement counter2.
      - After each probe, re-arm the settle timer to extend the quiet
        period if more devices arrive (this might fail Im not sure if cxl
        mem devices come in too late)..
        mod_delayed_work(system_wq, &cxl_probe_settle_work, 30 * HZ);
      - Call wake_up(&cxl_softreserv_waitq); after each probe to notify
        listeners.

4. The settle timer callback (cxl_probe_settle_fn()) runs when no new 
devices have probed for a while (30s)
      timer_expired = true;
      wake_up(&cxl_softreserv_waitq);

5. In cxl_softreserv_work_fn()
     wait_event(cxl_softreserv_waitq,
     atomic_read(&cxl_mem_counter1) > 0 &&
     atomic_read(&cxl_mem_counter2) == 0 &&
     atomic_read(&timer_expired));

6. Once unblocked, cxl_softreserv_work_fn() trims Soft Reserved regions 
via cxl_region_softreserv_update().
(We do not perform any DAX fallback here as we dont want to endup with 
unresolved symbols when DAX_HMEM loads too late..)

7. Separately, dax_hmem_platform_probe() runs independently on module 
load, but also blocks on the same wait_event() condition if 
CONFIG_CXL_ACPI is enabled. Once the condition is satisfied, it invokes 
hmem_register_device() to register leftover Soft Reserved memory.

Thanks
Smita

> 
>>>>>>
>>>>>> Thanks
>>>>>> Smita
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> This isn't all the logs, I trimmed. Let me know if you need more or
>>>>>>> other info to reproduce.
>>>>>>>
>>>>>>> [   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for cxl_mem probing
>>>>>>> [   53.653293] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
>>>>>>> [   53.653513] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1875, name: kworker/46:1
>>>>>>> [   53.653540] preempt_count: 1, expected: 0
>>>>>>> [   53.653554] RCU nest depth: 0, expected: 0
>>>>>>> [   53.653568] 3 locks held by kworker/46:1/1875:
>>>>>>> [   53.653569]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
>>>>>>> [   53.653583]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
>>>>>>> [   53.653589]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
>>>>>>> [   53.653598] Preemption disabled at:
>>>>>>> [   53.653599] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
>>>>>>> [   53.653640] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Not tainted 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
>>>>>>> [   53.653643] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
>>>>>>> [   53.653648] Call Trace:
>>>>>>> [   53.653649]  <TASK>
>>>>>>> [   53.653652]  dump_stack_lvl+0xa8/0xd0
>>>>>>> [   53.653658]  dump_stack+0x14/0x20
>>>>>>> [   53.653659]  __might_resched+0x1ae/0x2d0
>>>>>>> [   53.653666]  __might_sleep+0x48/0x70
>>>>>>> [   53.653668]  __kmalloc_node_track_caller_noprof+0x349/0x510
>>>>>>> [   53.653674]  ? __devm_add_action+0x3d/0x160
>>>>>>> [   53.653685]  ? __pfx_devm_action_release+0x10/0x10
>>>>>>> [   53.653688]  __devres_alloc_node+0x4a/0x90
>>>>>>> [   53.653689]  ? __devres_alloc_node+0x4a/0x90
>>>>>>> [   53.653691]  ? __pfx_release_memregion+0x10/0x10 [dax_hmem]
>>>>>>> [   53.653693]  __devm_add_action+0x3d/0x160
>>>>>>> [   53.653696]  hmem_register_device+0xea/0x230 [dax_hmem]
>>>>>>> [   53.653700]  hmem_fallback_register_device+0x37/0x60
>>>>>>> [   53.653703]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>>>>>> [   53.653739]  walk_iomem_res_desc+0x55/0xb0
>>>>>>> [   53.653744]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>>>>>> [   53.653755]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>>>>>> [   53.653761]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>>>>>> [   53.653763]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>>>>> [   53.653768]  process_one_work+0x1fa/0x630
>>>>>>> [   53.653774]  worker_thread+0x1b2/0x360
>>>>>>> [   53.653777]  kthread+0x128/0x250
>>>>>>> [   53.653781]  ? __pfx_worker_thread+0x10/0x10
>>>>>>> [   53.653784]  ? __pfx_kthread+0x10/0x10
>>>>>>> [   53.653786]  ret_from_fork+0x139/0x1e0
>>>>>>> [   53.653790]  ? __pfx_kthread+0x10/0x10
>>>>>>> [   53.653792]  ret_from_fork_asm+0x1a/0x30
>>>>>>> [   53.653801]  </TASK>
>>>>>>>
>>>>>>> [   53.654193] =============================
>>>>>>> [   53.654203] [ BUG: Invalid wait context ]
>>>>>>> [   53.654451] 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 Tainted: G        W
>>>>>>> [   53.654623] -----------------------------
>>>>>>> [   53.654785] kworker/46:1/1875 is trying to lock:
>>>>>>> [   53.654946] ff37d7824096d588 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_add_one+0x34/0x390
>>>>>>> [   53.655115] other info that might help us debug this:
>>>>>>> [   53.655273] context-{5:5}
>>>>>>> [   53.655428] 3 locks held by kworker/46:1/1875:
>>>>>>> [   53.655579]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
>>>>>>> [   53.655739]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
>>>>>>> [   53.655900]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
>>>>>>> [   53.656062] stack backtrace:
>>>>>>> [   53.656224] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
>>>>>>> [   53.656227] Tainted: [W]=WARN
>>>>>>> [   53.656228] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
>>>>>>> [   53.656232] Call Trace:
>>>>>>> [   53.656232]  <TASK>
>>>>>>> [   53.656234]  dump_stack_lvl+0x85/0xd0
>>>>>>> [   53.656238]  dump_stack+0x14/0x20
>>>>>>> [   53.656239]  __lock_acquire+0xaf4/0x2200
>>>>>>> [   53.656246]  lock_acquire+0xd8/0x300
>>>>>>> [   53.656248]  ? kernfs_add_one+0x34/0x390
>>>>>>> [   53.656252]  ? __might_resched+0x208/0x2d0
>>>>>>> [   53.656257]  down_write+0x44/0xe0
>>>>>>> [   53.656262]  ? kernfs_add_one+0x34/0x390
>>>>>>> [   53.656263]  kernfs_add_one+0x34/0x390
>>>>>>> [   53.656265]  kernfs_create_dir_ns+0x5a/0xa0
>>>>>>> [   53.656268]  sysfs_create_dir_ns+0x74/0xd0
>>>>>>> [   53.656270]  kobject_add_internal+0xb1/0x2f0
>>>>>>> [   53.656273]  kobject_add+0x7d/0xf0
>>>>>>> [   53.656275]  ? get_device_parent+0x28/0x1e0
>>>>>>> [   53.656280]  ? __pfx_klist_children_get+0x10/0x10
>>>>>>> [   53.656282]  device_add+0x124/0x8b0
>>>>>>> [   53.656285]  ? dev_set_name+0x56/0x70
>>>>>>> [   53.656287]  platform_device_add+0x102/0x260
>>>>>>> [   53.656289]  hmem_register_device+0x160/0x230 [dax_hmem]
>>>>>>> [   53.656291]  hmem_fallback_register_device+0x37/0x60
>>>>>>> [   53.656294]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>>>>>> [   53.656323]  walk_iomem_res_desc+0x55/0xb0
>>>>>>> [   53.656326]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>>>>>> [   53.656335]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>>>>>> [   53.656342]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>>>>>> [   53.656343]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>>>>> [   53.656346]  process_one_work+0x1fa/0x630
>>>>>>> [   53.656350]  worker_thread+0x1b2/0x360
>>>>>>> [   53.656352]  kthread+0x128/0x250
>>>>>>> [   53.656354]  ? __pfx_worker_thread+0x10/0x10
>>>>>>> [   53.656356]  ? __pfx_kthread+0x10/0x10
>>>>>>> [   53.656357]  ret_from_fork+0x139/0x1e0
>>>>>>> [   53.656360]  ? __pfx_kthread+0x10/0x10
>>>>>>> [   53.656361]  ret_from_fork_asm+0x1a/0x30
>>>>>>> [   53.656366]  </TASK>
>>>>>>> [   53.662274] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
>>>>>>> [   53.663552]  schedule+0x4a/0x160
>>>>>>> [   53.663553]  schedule_timeout+0x10a/0x120
>>>>>>> [   53.663555]  ? debug_smp_processor_id+0x1b/0x30
>>>>>>> [   53.663556]  ? trace_hardirqs_on+0x5f/0xd0
>>>>>>> [   53.663558]  __wait_for_common+0xb9/0x1c0
>>>>>>> [   53.663559]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>>> [   53.663561]  wait_for_completion+0x28/0x30
>>>>>>> [   53.663562]  __synchronize_srcu+0xbf/0x180
>>>>>>> [   53.663566]  ? __pfx_wakeme_after_rcu+0x10/0x10
>>>>>>> [   53.663571]  ? i2c_repstart+0x30/0x80
>>>>>>> [   53.663576]  synchronize_srcu+0x46/0x120
>>>>>>> [   53.663577]  kill_dax+0x47/0x70
>>>>>>> [   53.663580]  __devm_create_dev_dax+0x112/0x470
>>>>>>> [   53.663582]  devm_create_dev_dax+0x26/0x50
>>>>>>> [   53.663584]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
>>>>>>> [   53.663585]  platform_probe+0x61/0xd0
>>>>>>> [   53.663589]  really_probe+0xe2/0x390
>>>>>>> [   53.663591]  ? __pfx___device_attach_driver+0x10/0x10
>>>>>>> [   53.663593]  __driver_probe_device+0x7e/0x160
>>>>>>> [   53.663594]  driver_probe_device+0x23/0xa0
>>>>>>> [   53.663596]  __device_attach_driver+0x92/0x120
>>>>>>> [   53.663597]  bus_for_each_drv+0x8c/0xf0
>>>>>>> [   53.663599]  __device_attach+0xc2/0x1f0
>>>>>>> [   53.663601]  device_initial_probe+0x17/0x20
>>>>>>> [   53.663603]  bus_probe_device+0xa8/0xb0
>>>>>>> [   53.663604]  device_add+0x687/0x8b0
>>>>>>> [   53.663607]  ? dev_set_name+0x56/0x70
>>>>>>> [   53.663609]  platform_device_add+0x102/0x260
>>>>>>> [   53.663610]  hmem_register_device+0x160/0x230 [dax_hmem]
>>>>>>> [   53.663612]  hmem_fallback_register_device+0x37/0x60
>>>>>>> [   53.663614]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>>>>>> [   53.663637]  walk_iomem_res_desc+0x55/0xb0
>>>>>>> [   53.663640]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>>>>>> [   53.663647]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>>>>>> [   53.663654]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>>>>>> [   53.663655]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>>>>> [   53.663658]  process_one_work+0x1fa/0x630
>>>>>>> [   53.663662]  worker_thread+0x1b2/0x360
>>>>>>> [   53.663664]  kthread+0x128/0x250
>>>>>>> [   53.663666]  ? __pfx_worker_thread+0x10/0x10
>>>>>>> [   53.663668]  ? __pfx_kthread+0x10/0x10
>>>>>>> [   53.663670]  ret_from_fork+0x139/0x1e0
>>>>>>> [   53.663672]  ? __pfx_kthread+0x10/0x10
>>>>>>> [   53.663673]  ret_from_fork_asm+0x1a/0x30
>>>>>>> [   53.663677]  </TASK>
>>>>>>> [   53.700107] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
>>>>>>> [   53.700264] INFO: lockdep is turned off.
>>>>>>> [   53.701315] Preemption disabled at:
>>>>>>> [   53.701316] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
>>>>>>> [   53.701631] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
>>>>>>> [   53.701633] Tainted: [W]=WARN
>>>>>>> [   53.701635] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
>>>>>>> [   53.701638] Call Trace:
>>>>>>> [   53.701638]  <TASK>
>>>>>>> [   53.701640]  dump_stack_lvl+0xa8/0xd0
>>>>>>> [   53.701644]  dump_stack+0x14/0x20
>>>>>>> [   53.701645]  __schedule_bug+0xa2/0xd0
>>>>>>> [   53.701649]  __schedule+0xe6f/0x10d0
>>>>>>> [   53.701652]  ? debug_smp_processor_id+0x1b/0x30
>>>>>>> [   53.701655]  ? lock_release+0x1e6/0x2b0
>>>>>>> [   53.701658]  ? trace_hardirqs_on+0x5f/0xd0
>>>>>>> [   53.701661]  schedule+0x4a/0x160
>>>>>>> [   53.701662]  schedule_timeout+0x10a/0x120
>>>>>>> [   53.701664]  ? debug_smp_processor_id+0x1b/0x30
>>>>>>> [   53.701666]  ? trace_hardirqs_on+0x5f/0xd0
>>>>>>> [   53.701667]  __wait_for_common+0xb9/0x1c0
>>>>>>> [   53.701668]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>>> [   53.701670]  wait_for_completion+0x28/0x30
>>>>>>> [   53.701671]  __synchronize_srcu+0xbf/0x180
>>>>>>> [   53.701677]  ? __pfx_wakeme_after_rcu+0x10/0x10
>>>>>>> [   53.701682]  ? i2c_repstart+0x30/0x80
>>>>>>> [   53.701685]  synchronize_srcu+0x46/0x120
>>>>>>> [   53.701687]  kill_dax+0x47/0x70
>>>>>>> [   53.701689]  __devm_create_dev_dax+0x112/0x470
>>>>>>> [   53.701691]  devm_create_dev_dax+0x26/0x50
>>>>>>> [   53.701693]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
>>>>>>> [   53.701695]  platform_probe+0x61/0xd0
>>>>>>> [   53.701698]  really_probe+0xe2/0x390
>>>>>>> [   53.701700]  ? __pfx___device_attach_driver+0x10/0x10
>>>>>>> [   53.701701]  __driver_probe_device+0x7e/0x160
>>>>>>> [   53.701703]  driver_probe_device+0x23/0xa0
>>>>>>> [   53.701704]  __device_attach_driver+0x92/0x120
>>>>>>> [   53.701706]  bus_for_each_drv+0x8c/0xf0
>>>>>>> [   53.701708]  __device_attach+0xc2/0x1f0
>>>>>>> [   53.701710]  device_initial_probe+0x17/0x20
>>>>>>> [   53.701711]  bus_probe_device+0xa8/0xb0
>>>>>>> [   53.701712]  device_add+0x687/0x8b0
>>>>>>> [   53.701715]  ? dev_set_name+0x56/0x70
>>>>>>> [   53.701717]  platform_device_add+0x102/0x260
>>>>>>> [   53.701718]  hmem_register_device+0x160/0x230 [dax_hmem]
>>>>>>> [   53.701720]  hmem_fallback_register_device+0x37/0x60
>>>>>>> [   53.701722]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
>>>>>>> [   53.701734]  walk_iomem_res_desc+0x55/0xb0
>>>>>>> [   53.701738]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
>>>>>>> [   53.701745]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
>>>>>>> [   53.701751]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
>>>>>>> [   53.701752]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>>>>> [   53.701756]  process_one_work+0x1fa/0x630
>>>>>>> [   53.701760]  worker_thread+0x1b2/0x360
>>>>>>> [   53.701762]  kthread+0x128/0x250
>>>>>>> [   53.701765]  ? __pfx_worker_thread+0x10/0x10
>>>>>>> [   53.701766]  ? __pfx_kthread+0x10/0x10
>>>>>>> [   53.701768]  ret_from_fork+0x139/0x1e0
>>>>>>> [   53.701771]  ? __pfx_kthread+0x10/0x10
>>>>>>> [   53.701772]  ret_from_fork_asm+0x1a/0x30
>>>>>>> [   53.701777]  </TASK>
>>>>>>>
>>>>>>
>>>>
>>
> 


