Return-Path: <linux-fsdevel+bounces-63068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60249BAB454
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781E47A3A91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A926B75F;
	Tue, 30 Sep 2025 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wj2N7JjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011879F2;
	Tue, 30 Sep 2025 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759204912; cv=fail; b=DfRH40tztABrXYl7qqg7vbNtptkDvYttXt71dJt/H+AVHwkyryy9yCo2FAvEeuzT2QP5uq30PrNWIZdxBIjah1EqYPD1kVH6QGvx+4k2lfCWlmULmAIdqfCh4wbQNhX2e/sQvFzKk0YKENbb/vZzhGLWMdfg6N8WxvRVEDT9Fco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759204912; c=relaxed/simple;
	bh=141dONpKK0uBNTRV+saoqomSL3268h7Al7B54EteHRc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hc8hxPzkcOCztN7d5R7HjnWM79S+ycNWVJ3F/wTKrzcPI68prUOk1P4tXNd92rkd1xZ6uclh7lj+kQ5/PXvJJrXfM4sqxshP2CJaxglSYqS623aLj3a56JXUbetjrSIK4eyTUIJmcR8kd1gGvf3vrZsdPkkxRVOSzE7+EfUQp44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wj2N7JjP; arc=fail smtp.client-ip=52.101.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M51kVuZPQMcdXMbArBygxFfAai4lzPH9Cz12T9IMPmGwsmdBWEz7NbMjhpycvvjfksysgxwZmkDRGS7A2deNNOY9cOC/JAnOj2gEL2u8wA9JFqDoJyuNjHMG6P2oaPa/24QYFr4r2Sa3ECsxvV4GwYOc2XdMApfhjhL4FaOAhYrr6gy/o3o+w9ca2mPOzs1LBKeDwxiBUzEKWLPiWxMEKRzE4PgSteDlp24ZQbDhFfM5ZRV6PvXYmdPQR/zicv2NkAM7I9V+qkhrFsRiF9yFj+z7q68xpIO3FmKw2V1rP3RH+4mmYP513oLBugNbOfbNlAzm4ojDOIAzGGZhWpOVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gECve8jIviamsmD/OoM+nMQ5GWbn20uscfo0AGB5QPs=;
 b=Ungpm16f6FhRB7XHx7XVz7hzGIylV90I4AHzKd+SlcUnqvZbzUOQRIlGssZo3yV715azl7zf55zRhB/3lArTbtrxrEiO98KOICug7uit/ksuf1BZBj4zR3IQDWS7SbmIo4LCUX4VoJSSyjRmq83a2NeEpjoAGAlakLVoeBr5i+OflhVAtXPvTx45MG8LIaSxwznxtWvmd8xsvcO4vmkRkemqjOhoodmyYC2nsVq8SCL/85771DgBK2Hrq3PeqjltoBVXu5n/e4N1lnpC/n57aNSjHEXeTnd3Rn2rvzQkUzwn5qeU5PDQq587fLX8b9SpbXYFU/n/PGT7CH+Bko5/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gECve8jIviamsmD/OoM+nMQ5GWbn20uscfo0AGB5QPs=;
 b=Wj2N7JjPDoEWMslLzOS5371G8HoftrhuX9XP4+LczEVzKcHhlRYI2tAVqDCrDRHr9dt7teFTcrjiFM2PBk6CyjCbN2KNWh529K4tDuEHAu3l8lHnqij5+NKEV0b1xlDUn6ECkaCHQUCDEzGcU5cXwoHUYUUHGic/7/GlAhyM/Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:01:45 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 04:01:45 +0000
Message-ID: <a6e9ef76-cdb4-4dde-a7e9-955549f3a825@amd.com>
Date: Mon, 29 Sep 2025 21:01:39 -0700
User-Agent: Mozilla Thunderbird
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Subject: Re: [PATCH 1/6] dax/hmem, e820, resource: Defer Soft Reserved
 registration until hmem is ready
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
 <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
 <537527fe-55be-4661-a0c6-ba9fe344bc35@fujitsu.com>
Content-Language: en-US
In-Reply-To: <537527fe-55be-4661-a0c6-ba9fe344bc35@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 04505d06-51dd-45c0-0c44-08ddffd6121b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1dtSFhLQ0k3ZTI3bWo4RXhDVVhMNlVSV05VZVkrNmpwOHF5TWIyN3RBZmRT?=
 =?utf-8?B?L3A4a0RaMkRSUFFtajFhRHBlZGtvOGlKYmhKaXBvZ1BQQjJ2UEZKTTZOSnRz?=
 =?utf-8?B?SDZvV0lZcmdEQzN1UmdId28yT1l3WGI3WVdOaVhJeVV3b0JmRFo0M1Y5NDdw?=
 =?utf-8?B?Mlc0R0hVanlRcWJNQ0dzancyUWhydDNKZnJJMVZiVENMMVNqQTRyMllhKzNt?=
 =?utf-8?B?eTF0VXRMSC94VGVIS1FhMk5zdFJQeG5KbFNSWFo2QkYzOXQvVURQanRuZkNO?=
 =?utf-8?B?Ump4UndFMDg1Z2F5YzhIRVZJcDU3VlRRdlk5NWVualdTbWRYWHpnRGxJdHBw?=
 =?utf-8?B?U2ZtMDNlb2g4aDlyc1dEeTVRemo1Wmc5U0hQc1JEQVhWZHhIN3lRR0lOVzkw?=
 =?utf-8?B?RFQrbzVwMlFXb25DS013dTZXY0hqREFYRnkvRGZBbE5GdDZ0Rms2dE9MSUN3?=
 =?utf-8?B?dVUzdTFqR1IxUksxbmlObHZWdUZPejdBUjFRZi9ZMWNqUnY2OXNGeE1YdytX?=
 =?utf-8?B?RzNxOXBtTG1pNDBIYUZOdEkyUHpkRmdlNGkrNlFKdnRBWDlCVFg2a3hZMnh3?=
 =?utf-8?B?eGt0aGhGQmk5NnZQeEo1ZHZHaWdlSWxzR2hScldmVVJjOW9VMmRuWHhPTDly?=
 =?utf-8?B?WUsvQlBpSkdDWXU5UGZ3OWVKV1ZqSjJXbTY1RGQ2RFpBeTVVbWxVc2p3STFz?=
 =?utf-8?B?dFRZN1lQS1VBcWxhcjVaUEJ4cWJtOVBNeWlBYmg5TE1YUlpiTEZwbDZTdFNz?=
 =?utf-8?B?Q3V1cXA1NjFCcjRveG5lNXpZM3VocE5ac0tlSytGeTRpQmJUUXl0RmhPQXlh?=
 =?utf-8?B?WnJXejVSVmRrMVZ2bk43VitRNndvaUZMMzZmek84aDVsQUZKVWFnTTlRRWVG?=
 =?utf-8?B?bit2RG94Q3ZWcWxEV0FsQUJMd3l6Ry9QTEg3SGEzRytnMm4wb21jYWt0NVRm?=
 =?utf-8?B?RkdYZzFwYlFFL3l4dWFINzFIWm53dmJUaEFFWENCcWJjaXhMNHhmV0k1dWtH?=
 =?utf-8?B?MjlqeTE1ZzZaa3E0VUo4dEVuWlczMDVIT09Cb0dnblZzSVNaNGFnbFdEVEVI?=
 =?utf-8?B?MTEySlg1Q0dyaWU1dnFDdFpSZjFmL1JGNUp6dmU1cjZlNjZ1Y1ZHdVh1TG5L?=
 =?utf-8?B?ckNJOVBqc1M3STkyczJqYnRWS2V1SG5NUUJWRDBKbFZtOWk3QVNlc3E2YU5W?=
 =?utf-8?B?Rk1OcGdMeng1YjNPeHJZczJERUEycDFXQm9Gc2NhNDUySkFCb1Z4UTBtMHAr?=
 =?utf-8?B?MlFmd2I4L25HeExzdHk5YVhSMWZCaytSbzZCZmpwRnY3UXRkUFB0VDFTTnRp?=
 =?utf-8?B?TnZKTW5WMHhIbmY0czdNTEMyTjRBVFhiTVlxOU56Mml6WGxqZ3E5TFJXbWFs?=
 =?utf-8?B?WGlpYzU5WlBTNUJRdDBsVmdTejgyV1FsdkpISWd2Z3dvWG9NdDNHZFFpeXhx?=
 =?utf-8?B?RXYvMEJ0MkZPbDBQNnFJRGZTdmNvaWRTRjRZTFNEbXQ4YVVCalNsSFExQmhu?=
 =?utf-8?B?dmV5VFR3blhDclZHTjVJR0JDVGU0Z2lBc00yalJ1aElsY21OKzZXVCtBYTZr?=
 =?utf-8?B?anovbjUwRjZmV0p5bkZWRnJBa1BsSHBoRUdaU3ZGRElZeGtUL3VEQitpQzNK?=
 =?utf-8?B?SlEvUVRKUU9ucVRLazg4Z3ZxazVRYlNzczgwVVBVcHhHTlZLOG9ZMUZyYWtp?=
 =?utf-8?B?NnJVbk82YTBiY1MxM29ud1RWMGZCNzhCc1UvRjM1UW00WXFOeVU1bGZJMzhn?=
 =?utf-8?B?OGFCRlJkSHNOMUNrdXpQd1ZWNUN3QU1GRmgxT3RURWtYdlFIUUR6YWVKTUlC?=
 =?utf-8?B?U2xlTlFPanZoMlBPcG1PYWs5WStFU3ZWUnpnTEhaN0Ezdk9zangvVStVVllL?=
 =?utf-8?B?cFNCUlpEZWJwNzJJUGM2Q09sK3c0VXJLWXFnSll6R3ROOEJMRTlkdlJKYXFn?=
 =?utf-8?Q?+TVy8L9aH9BtRv74vkGbfhWOeRtobGXS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aS90OUpWRXBFL3k2K0FwdTBML09qcHhySTA1b3R0ZllQSXVlWFhRdEdhK3dy?=
 =?utf-8?B?aE8wUS9OV1BpdksvaDVKM3d5aXp2RkUzMFBjSHZMb2xITkhXZGU5UTZFaHV1?=
 =?utf-8?B?SjFBWW1EZXJmQ2dncUVJQSsrZXRFOE9QMk1UYkRJd1hTTWZpTlZTUnoyZUVr?=
 =?utf-8?B?TkNBZnY5M1g3dXUyQ1BvMUIxRnpBMENiTUN1NEFJK0JsdTBmVmpvYTdXc3R6?=
 =?utf-8?B?bExITzRmOU9EWC83NEJXOVJPTVY1MEtJK2N3NDVMajN4V0hSSnlYS0djY3lZ?=
 =?utf-8?B?TmExSlhrMWsrMmJVNHd6d0JCNTc1RWJ1SkJQSmFGVEhpc1BoaHlSTVRGeVdQ?=
 =?utf-8?B?SUt0cld5eW9nc1RVNnd0cXB2M1JXaXkyV25sM3hBQ043QlA5R0J2a0FsLzZx?=
 =?utf-8?B?WlF3SlNVL2VVY0ZTcG5mRHBibVdaYVp3VG5xbCtTNEc1TW5TdjdGTnZpY09D?=
 =?utf-8?B?ZFYrTjF4Vko4dExsWlIxZ0Z5Qk5tNFI0WFpsREdYUVliOStFTDhaZS8vdVZT?=
 =?utf-8?B?N1EwVlJ3UWE2NGx5aisvNEZibHFrNnNBQjJhRXJoZHlvOGdKcHJmZDg1ZlZL?=
 =?utf-8?B?ZjRUZE0xa1RvVDNpRC9QQXc3VlFrejd0TjdXbDZ4VGtOZEljYWE4Z2tsOFdi?=
 =?utf-8?B?OTRZekxkZDBGVXhmb0U3MFNJdjlFY0xobGFZUFNWOFgxZzc1Yko3WW5QS0pG?=
 =?utf-8?B?c2YyYnZwSElmK2Q5TGdEUmJwajYwTTZZQ3JGcUUySm1OSkVZZjEwUmJuWi9o?=
 =?utf-8?B?UVEwSGV5b2wveTl6eGtORkRwcFhrUkhpeWRPVEZmYlVpVmNpREgxd3MxYml1?=
 =?utf-8?B?NG8ySm9zTWtLRkFEN1pybEY3T0N0aFFXN3c1UWdtOGJGdWsra3NUZDRSOTBH?=
 =?utf-8?B?SVZ0OCtBNUE2UmpLTEx6Y3p1MVJBWlNhUnFrUFM3Q0VaYzIrV0hwS1g2citE?=
 =?utf-8?B?WFJaMnFRbzJZT3JDc2JxMjhGMTJZcjRtMzBtTXRGV1ZMRU01QUNjMXhmK2Nh?=
 =?utf-8?B?SFhzTmwwUGZCSDlmQU9mOFlZeWJKeWZ4RmtnbXFIbUNTNEYybnBvVVVhYnMy?=
 =?utf-8?B?VUV5aGovU21NZHl1V0Q0Njk4VitSY3IvV2k1STUyb21iaWxjV05XMVlLTURk?=
 =?utf-8?B?TjNhVTlmOVY5NnhUQUVybmtxaE5ndXUrWktJeEpJNUZITWpHZi9ZOHNZTkgx?=
 =?utf-8?B?ay9laDZmbUtZdkRxS2JXV3ROcHhLdFB0R0ZQWitRYlovSGpkcTRvN2FDUFhh?=
 =?utf-8?B?eGtOU09ONEpreEhGNXhSZTYxVFU4U3p3MWlGY3p2WEJtcXpBejBZTjBJa0FH?=
 =?utf-8?B?clRGZmJWUWJMeFBqSXNhVDA3KzlNNWpieE9LUk1GbFNoSFNNRnpDVE9ZMFJm?=
 =?utf-8?B?WFFleThQbFB6Q1hGQjBoYmZIcXVLL0tQS2ZoR3ZmVGdQT1RnRHVtemJrTG43?=
 =?utf-8?B?QUhUMWN2aGo2STc0V2VUQS9UZDZ5MmZFd2tBMkg4WXhxRE00M3p4aVpOaHBN?=
 =?utf-8?B?a1NNK0I2WVg4TE9razJROCs4QmFucVpXcTZWbnZNMW5SUFhIS2ZWYVhxWjJv?=
 =?utf-8?B?UDNqdzlRY3JPdTVnaWxXaWJNVHdXRC9yQkU3OEhYUVpyMzJzOXJMMWp5QVVI?=
 =?utf-8?B?MkUxRU1TenpQeWE3aDBhY2Z4QW9iOVVVMVVwZWNuNFoyNHNEZ2crNkhEU1Ar?=
 =?utf-8?B?b1hCVlJGcXF3RFgrWnBWWEsydnRIQzU5UWhRQ0FtTEpldlp6Uk9BUVhUYkJH?=
 =?utf-8?B?Y3ViRGlVVktmTnBwczdVMldwVHBtNWhLRWJNZzZOaWg5ZUN4dStaTFJnN1o5?=
 =?utf-8?B?eDFpU1U2Q1dpellhbGtHc1JuaENsaGlob00wY2N5RG4rMDcxREF1eEdGVnFF?=
 =?utf-8?B?enl3TFBVaG1uR2NFWjg5TlBOdFFRQUpvSCtrOXhlZzFVVVhqdHNmT0JtQ1ls?=
 =?utf-8?B?M2tLd29qRVlEZEFpYkxvOXV0N1hkTDlGMlVEWnZlVnlLSDRodzFFVVRYOHh5?=
 =?utf-8?B?OUZPMEpNN29QdisvZFpSL0cvT0hBcGVuWVArN2k4NEVQTzNaNVBMWmcxYVRT?=
 =?utf-8?B?OW9STFpMbHFTQkhsUndNOXRYcEdpbzkrbk50VkJHSlp0bENXeGl5N1lPV2N1?=
 =?utf-8?Q?ePuxI0E15lU7uA5i3+xQ7bNb5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04505d06-51dd-45c0-0c44-08ddffd6121b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:01:45.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYqQVfd3ugVtcmeI0gG0eAZDns3ehbcwgsZJL079kdYowEX6ilZtHipNvEaVZE9czzfHXEFi2zeMNykfjQw09w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598

Hi Zhijian,

Sorry for the delay here.

On 8/31/2025 7:59 PM, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 22/08/2025 11:41, Smita Koralahalli wrote:
>> Insert Soft Reserved memory into a dedicated soft_reserve_resource tree
>> instead of the iomem_resource tree at boot.
>>
>> Publishing Soft Reserved ranges into iomem too early causes conflicts with
>> CXL hotplug and region assembly failure, especially when Soft Reserved
>> overlaps CXL regions.
>>
>> Re-inserting these ranges into iomem will be handled in follow-up patches,
>> after ensuring CXL window publication ordering is stabilized and when the
>> dax_hmem is ready to consume them.
>>
>> This avoids trimming or deleting resources later and provides a cleaner
>> handoff between EFI-defined memory and CXL resource management.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>    arch/x86/kernel/e820.c    |  2 +-
>>    drivers/dax/hmem/device.c |  4 +--
>>    drivers/dax/hmem/hmem.c   |  8 +++++
>>    include/linux/ioport.h    | 24 +++++++++++++
>>    kernel/resource.c         | 73 +++++++++++++++++++++++++++++++++------
>>    5 files changed, 97 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index c3acbd26408b..aef1ff2cabda 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -1153,7 +1153,7 @@ void __init e820__reserve_resources_late(void)
>>    	res = e820_res;
>>    	for (i = 0; i < e820_table->nr_entries; i++) {
>>    		if (!res->parent && res->end)
>> -			insert_resource_expand_to_fit(&iomem_resource, res);
>> +			insert_resource_late(res);
>>    		res++;
>>    	}
>>    
>> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
>> index f9e1a76a04a9..22732b729017 100644
>> --- a/drivers/dax/hmem/device.c
>> +++ b/drivers/dax/hmem/device.c
>> @@ -83,8 +83,8 @@ static __init int hmem_register_one(struct resource *res, void *data)
>>    
>>    static __init int hmem_init(void)
>>    {
>> -	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
>> -			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
>> +	walk_soft_reserve_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0,
>> +				   -1, NULL, hmem_register_one);
>>    	return 0;
>>    }
>>    
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index c18451a37e4f..d5b8f06d531e 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -73,10 +73,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>>    		return 0;
>>    	}
>>    
>> +#ifdef CONFIG_EFI_SOFT_RESERVE
> 
> 
> Note that dax_kmem currently depends on CONFIG_EFI_SOFT_RESERVED, so this conditional check may be redundant.

Removed in v2.

> 
> 
> 
>> +	rc = region_intersects_soft_reserve(res->start, resource_size(res),
>> +					    IORESOURCE_MEM,
>> +					    IORES_DESC_SOFT_RESERVED);
>> +	if (rc != REGION_INTERSECTS)
>> +		return 0;
>> +#else
>>    	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>>    			       IORES_DESC_SOFT_RESERVED);
>>    	if (rc != REGION_INTERSECTS)
>>    		return 0;
>> +#endif
>>    
> 
> Additionally, please add a TODO note here (e.g., "Add soft-reserved memory back to iomem").

Added.

> 
> 
>>    	id = memregion_alloc(GFP_KERNEL);
>>    	if (id < 0) {
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index e8b2d6aa4013..889bc4982777 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -232,6 +232,9 @@ struct resource_constraint {
>>    /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
>>    extern struct resource ioport_resource;
>>    extern struct resource iomem_resource;
>> +#ifdef CONFIG_EFI_SOFT_RESERVE
>> +extern struct resource soft_reserve_resource;
>> +#endif
>>    
>>    extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
>>    extern int request_resource(struct resource *root, struct resource *new);
>> @@ -255,6 +258,22 @@ int adjust_resource(struct resource *res, resource_size_t start,
>>    		    resource_size_t size);
>>    resource_size_t resource_alignment(struct resource *res);
>>    
>> +
>> +#ifdef CONFIG_EFI_SOFT_RESERVE
>> +static inline void insert_resource_late(struct resource *new)
>> +{
>> +	if (new->desc == IORES_DESC_SOFT_RESERVED)
>> +		insert_resource_expand_to_fit(&soft_reserve_resource, new);
>> +	else
>> +		insert_resource_expand_to_fit(&iomem_resource, new);
>> +}
>> +#else
>> +static inline void insert_resource_late(struct resource *new)
>> +{
>> +	insert_resource_expand_to_fit(&iomem_resource, new);
>> +}
>> +#endif
>> +
>>    /**
>>     * resource_set_size - Calculate resource end address from size and start
>>     * @res: Resource descriptor
>> @@ -409,6 +428,11 @@ walk_system_ram_res_rev(u64 start, u64 end, void *arg,
>>    extern int
>>    walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>>    		    void *arg, int (*func)(struct resource *, void *));
>> +int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
>> +			       u64 start, u64 end, void *arg,
>> +			       int (*func)(struct resource *, void *));
>> +int region_intersects_soft_reserve(resource_size_t start, size_t size,
>> +				   unsigned long flags, unsigned long desc);
>>    
>>    struct resource *devm_request_free_mem_region(struct device *dev,
>>    		struct resource *base, unsigned long size);
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index f9bb5481501a..8479a99441e2 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -321,13 +321,14 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
>>    }
>>    
>>    /**
>> - * find_next_iomem_res - Finds the lowest iomem resource that covers part of
>> - *			 [@start..@end].
>> + * find_next_res - Finds the lowest resource that covers part of
>> + *		   [@start..@end].
>>     *
>>     * If a resource is found, returns 0 and @*res is overwritten with the part
>>     * of the resource that's within [@start..@end]; if none is found, returns
>>     * -ENODEV.  Returns -EINVAL for invalid parameters.
>>     *
>> + * @parent:	resource tree root to search
>>     * @start:	start address of the resource searched for
>>     * @end:	end address of same resource
>>     * @flags:	flags which the resource must have
>> @@ -337,9 +338,9 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
>>     * The caller must specify @start, @end, @flags, and @desc
>>     * (which may be IORES_DESC_NONE).
>>     */
>> -static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>> -			       unsigned long flags, unsigned long desc,
>> -			       struct resource *res)
>> +static int find_next_res(struct resource *parent, resource_size_t start,
>> +			 resource_size_t end, unsigned long flags,
>> +			 unsigned long desc, struct resource *res)
>>    {
>>    	struct resource *p;
>>    
>> @@ -351,7 +352,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>>    
>>    	read_lock(&resource_lock);
>>    
>> -	for_each_resource(&iomem_resource, p, false) {
>> +	for_each_resource(parent, p, false) {
>>    		/* If we passed the resource we are looking for, stop */
>>    		if (p->start > end) {
>>    			p = NULL;
>> @@ -382,16 +383,23 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>>    	return p ? 0 : -ENODEV;
>>    }
>>    
>> -static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
>> -				 unsigned long flags, unsigned long desc,
>> -				 void *arg,
>> -				 int (*func)(struct resource *, void *))
>> +static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>> +			       unsigned long flags, unsigned long desc,
>> +			       struct resource *res)
>> +{
>> +	return find_next_res(&iomem_resource, start, end, flags, desc, res);
>> +}
>> +
>> +static int walk_res_desc(struct resource *parent, resource_size_t start,
>> +			 resource_size_t end, unsigned long flags,
>> +			 unsigned long desc, void *arg,
>> +			 int (*func)(struct resource *, void *))
>>    {
>>    	struct resource res;
>>    	int ret = -EINVAL;
>>    
>>    	while (start < end &&
>> -	       !find_next_iomem_res(start, end, flags, desc, &res)) {
>> +	       !find_next_res(parent, start, end, flags, desc, &res)) {
>>    		ret = (*func)(&res, arg);
>>    		if (ret)
>>    			break;
>> @@ -402,6 +410,15 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
>>    	return ret;
>>    }
>>    
>> +static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
>> +				 unsigned long flags, unsigned long desc,
>> +				 void *arg,
>> +				 int (*func)(struct resource *, void *))
>> +{
>> +	return walk_res_desc(&iomem_resource, start, end, flags, desc, arg, func);
>> +}
>> +
>> +
>>    /**
>>     * walk_iomem_res_desc - Walks through iomem resources and calls func()
>>     *			 with matching resource ranges.
>> @@ -426,6 +443,26 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
>>    }
>>    EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
>>    
>> +#ifdef CONFIG_EFI_SOFT_RESERVE
>> +struct resource soft_reserve_resource = {
>> +	.name	= "Soft Reserved",
>> +	.start	= 0,
>> +	.end	= -1,
>> +	.desc	= IORES_DESC_SOFT_RESERVED,
>> +	.flags	= IORESOURCE_MEM,
>> +};
>> +EXPORT_SYMBOL_GPL(soft_reserve_resource);
>> +
>> +int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
>> +			       u64 start, u64 end, void *arg,
>> +			       int (*func)(struct resource *, void *))
>> +{
>> +	return walk_res_desc(&soft_reserve_resource, start, end, flags, desc,
>> +			     arg, func);
>> +}
>> +EXPORT_SYMBOL_GPL(walk_soft_reserve_res_desc);
>> +#endif
>> +
>>    /*
>>     * This function calls the @func callback against all memory ranges of type
>>     * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
>> @@ -648,6 +685,20 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>>    }
>>    EXPORT_SYMBOL_GPL(region_intersects);
>>    
>> +int region_intersects_soft_reserve(resource_size_t start, size_t size,
>> +				   unsigned long flags, unsigned long desc)
> 
> 
> Shouldn't this function be implemented uder `#if CONFIG_EFI_SOFT_RESERVE`? Otherwise it may cause compilation failures when the config is disabled.

Fixed it.

Thanks
Smita
> 
> Thanks
> Zhijian


