Return-Path: <linux-fsdevel+bounces-50605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763BDACDB52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3073A62C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C838628CF75;
	Wed,  4 Jun 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IDVIXXqy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99E28CF56;
	Wed,  4 Jun 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030112; cv=fail; b=j5drV4rB7AI1qvN982xBg2glHIh+ueRF+O0SBMRELifIWmGMUArDbc9pXxzTTqabVoOeZL1/K2ZaH+Gompl/va9y5bRgQheLGEC38LUqDl2xuYtNM0midWRsn/nlgxKnMi4m/f+ngkkM085d+BX5HeY82PKH6l1baBVOLwutsAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030112; c=relaxed/simple;
	bh=WJG2HsAgxv2tzT1aNBp0RhcMQ/rboQmaaqN0mn1CSGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGxzcff3gmdPkYwmI8CKGf4wDX1dYvxATaJFJSYscEcL3ZrFdR991FEXSoX8xw6HrdZ50UJMeNWWqggVR1skFRs/dGwBnIzNhWah0Ma1qXojWRvQ2iUQRmK5IBZIHjgGA0CmPQVFajrZLEeh06xxb6dWVV4TEO/7vGQKGWVwGbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IDVIXXqy; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749030109; x=1780566109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WJG2HsAgxv2tzT1aNBp0RhcMQ/rboQmaaqN0mn1CSGQ=;
  b=IDVIXXqyEwTVTTVa2e2LrXBB7sHaBhlWKXZf5+sd/peY6XWVnjGABStc
   A5p8adnvUeME/KRjRm3hiFJ2kXBanW1t8cszjQAYrWeTpRGtAInPsdk0+
   9nTWKLvTp3a4+L9PA0jlHnwowmzj7CmazUqX1sStFIX0tb51tzWYh+q5L
   wk54wFdNtbrCJSCYvq5E9OGoWRY4K95mAeSHIQmEfPEGEyfHO2pDTuf2b
   8udFvfelld9i8fGZGQ7J86OfAQ7Sk5kCBYJIa3kEOn7+wjcYfbQm06Jcn
   lC86+GTnGBj1xE08+OhsTYzDYzzJWq2q3kMWJmgCBY1MuJ68wvh7lHzbU
   Q==;
X-CSE-ConnectionGUID: nMkvKkJiTOaZ7n8VnxtryA==
X-CSE-MsgGUID: 3XMSCgf8SS+CjiY0a0Ty7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="158018173"
X-IronPort-AV: E=Sophos;i="6.16,208,1744038000"; 
   d="scan'208";a="158018173"
Received: from mail-japanwestazon11010068.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.68])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 18:40:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlKpRGmPqI35w6ne/bceV6JuG0hY+1Rexpyr92vtg3iKu0utsBr+8ZQ0s9NKF4qjquYqgmgeTeF3CY+a0ULCh84PICYQiR4C6f7VaIq+NEsr1cRlL6kyCrvgyEIeTQ+xaaTLOIXnq201JjVOCATq3wXdbMf5ZLGgFkpv0EQjNffrh1ZxDAEZ4A1JBfSCi2jv7v4yhZlQQgFOaqZS8nndI9rDitbzBPknFBSzHVIyWB9bZx9Tqxg89jCaeUW1P1cnR6stjP9Thr5c1jimJzJ/ncaVkHfXsvWPWlANVvuQiUmGZ5c5moPkC411a7wFqwuYvUBTb82eVCJ31p/X8/QwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJG2HsAgxv2tzT1aNBp0RhcMQ/rboQmaaqN0mn1CSGQ=;
 b=GNQMgG4ZD17RebCoKr4sQ+U7OPbVk5m0rY4qolzy2Fr9g9HTQ08i3s6WuLN4BUtiXyWRmgtPtZvSdnE+G3y+l4vkpGD5TR15EUESjLTGPH5R+n0O/VPiKN7LNs45HzOzRg5YAE+7LehK3+R8b6V+q7AoN+IDpu7AbuCVqOkzsXuHzk9tI5hkIsrCK/bPj0nAzfamHATNfvwIzBomsiWRZa1JBGigmbj2skinY+Z6LRcNIEXNDuGxNu4OkFAsiXXUaS2SAfWWToVGD0mJ8yarYX6xTnhPLjLrZMv0vV7ieDPPPB9D452M4S6h5ayg/onL/k30Znokn4u3EvPzRVdf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB9740.jpnprd01.prod.outlook.com (2603:1096:400:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 09:40:26 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 09:40:26 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 4/7] cxl/acpi: Add background worker to wait for
 cxl_pci and cxl_mem probe
Thread-Topic: [PATCH v4 4/7] cxl/acpi: Add background worker to wait for
 cxl_pci and cxl_mem probe
Thread-Index: AQHb1NWwFxOtCct2okebJfTHnbLTZbPyv7mA
Date: Wed, 4 Jun 2025 09:40:26 +0000
Message-ID: <860121d7-4f40-4da5-b49a-cfeea5bc14c5@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-5-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250603221949.53272-5-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB9740:EE_
x-ms-office365-filtering-correlation-id: 422d74dc-1a4b-4008-ce39-08dda34bd630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3F2NVJGNy80ZDE1ZUlwSnAyT2xUZEtPQUszTExmZGpyaWg4UmhyeDJLWFNy?=
 =?utf-8?B?Nng4cXBTT1Z1eitzd1ZoanV5R01EZTFsK0VkYk0zekJvMlBJdVVVaVpONU55?=
 =?utf-8?B?allqMERuLy9RQS93UHA5RFY2M3IvUm56RzdHYjZJY0FmSHJ5T2luSThKUEts?=
 =?utf-8?B?b2I3NGlsRDR0K0tXMlBjZllsM0w3UklYdCtHWU16Nkl1QSttcEo0bFhGRVA0?=
 =?utf-8?B?aXpSQ0g5VHVhTkNjWTFkZGVWTXlVM3ZKeDFwczVuZ0p5K0pDdzN1R3hidklI?=
 =?utf-8?B?NUE3cGR3RWp6TDlvcUs3QWxVTWV3SmR1ZENHM2xBWDhQb2ZlcEJBVy8wTmhL?=
 =?utf-8?B?VHpxYTR1NVRkYkFMeFRBUzAvQVVPM3NZdk1TV1FLUU41K3V3Tk10QnVlcFJJ?=
 =?utf-8?B?QkxRSzJSZ3hXVmtTK2MrU1RIS0ZtaklaTEd1NFhialRvRHdva205M29UOStK?=
 =?utf-8?B?d1QyWWZYelNZMEMwcjIxaWF5WWgrQzFtaDNyUFdPcWhUREhJbFYyd0p6ZDh3?=
 =?utf-8?B?K210clpHQ2ptZnJIazRUOE13ZlBTeEQ4eFF6REI4SGVMRmtUWCt4TkxpRElU?=
 =?utf-8?B?ZFFDR09USU1LM0xXWUdpMDJTSy93bE1TcUdJekhYbDVzczdHYk0vbXBJNmtB?=
 =?utf-8?B?WXUyM3B5clBrRFBORXgxdVpiWitEWm1rQTNONWZnR3pqaVJMVVA2eWF4WmJR?=
 =?utf-8?B?VDZsc25iakcwOVR4T3VKN3J6UksvVFNxSWdKcXNub2xyL1lEUlpyZmpKdlhw?=
 =?utf-8?B?dTJSc1MyaW5SSk12NXF4b1F0aG45NlFPTXNaUTd2YWVZMHhRSTBhK3lic2RH?=
 =?utf-8?B?T3N1R1FFS0ljVC83RDB5eUUxYXFtOXZEMXE3cEZBbkx1M1JoMkxyeW53eTUy?=
 =?utf-8?B?bW1ERzg1a3QyNDM1Zjd5UndpL2wrai9DcmVzSUJ0SFBFZ2JJRUp5bzRpVnNv?=
 =?utf-8?B?VEtEVldqMHhyaEthQzdidjFxNy9waUdTVzh3TFJOcFNtR3lZaERhc3RmRklH?=
 =?utf-8?B?QzFZVUJkYStjdnpvblVIRUZHZzdIUUl3Mng0WVd6bkI4QmR4ZjREd2RXK3ZT?=
 =?utf-8?B?Q3NZbm1wT21Qc2tycVhXbHZRUGp1dGRhSWVOZFNvRmlQS1d2MVV3ek9NL3F2?=
 =?utf-8?B?UmloT3laT2EyL2dLMnUzQlB1SGJDTE1rcC83cC9RR1NPQ0EyRXlCV3RJdjQv?=
 =?utf-8?B?Sit2M2FIWHFUc2xSZkVYMHA2ODFORWNCVE1xNHo3ZUJrNGNTT0hTTGd6VUNs?=
 =?utf-8?B?L1YzOEZnR2pMbGJkcW42TmNTMEVBVGRpOFZMM3hvZWJJYmdhanhyd0FFeXdh?=
 =?utf-8?B?dXBqT01uMURHY1R3RnR1T3I3QnMzMU14cTdvLzgwU1p4U2pmcUo0TE9scDRC?=
 =?utf-8?B?empoU0krV1JiTTBUYTR3VmIyRGYxYjduYlEwcWVUU1J4MWd1cGlzdjNDTE1w?=
 =?utf-8?B?a2dFWDNEQk5KRkwxYktqWWhmVjBybXhDbkVZVnpMUWZSZWhqN3pWNWZZcWlB?=
 =?utf-8?B?UUtaNGlrN0hpYjFpZDR2SzZqS0tiTnNLK1c3ajJYUHVybzdwb2dYc0x4L09P?=
 =?utf-8?B?OVduN1M4U2ExVEkvWVliL1VHVkdKeEJHVGZYcS9iQll4eDhZK1dwV0F5M1pC?=
 =?utf-8?B?M2RBZm1nKy94MUoweU9rVGpmNSs3SEQ5aTVWUnUyaENGTW9CQkxzNVVqMUlh?=
 =?utf-8?B?MkNPRjZEMVJnNFUzWmFwbzBsSEpQaHFRdm53TGF0QytMcmFPRWZRZGtyaTNp?=
 =?utf-8?B?TXduKzhiKzU2QUpsQVU1TXJKcUUrRzcxWFEza1BOMC9WSTdZenZJMUZHeEVN?=
 =?utf-8?B?eGc2MVhQUk91S1FVMUhWbUlBZmdnUnlHNHh1enArbUgyYmEyV3lmekllZXM4?=
 =?utf-8?B?L0FLRWk0RHpPZFRiNWlzS2pmZHhhTUpjZGNLd3VFMkRSSG00U3lWdnBYWVp1?=
 =?utf-8?B?ZjlRK1hXSzlObkFvOElMRmtVVjc3OHY3OGQycXNLVmNDUDVwaE5NWkhsd01x?=
 =?utf-8?B?dFVLcTY4b2RXODVMQXRwL2RUQ01lTlZqcGx5UzZnT0p4ZThGMTNRL1I2b1BJ?=
 =?utf-8?Q?6+p/TK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk1SUVBud3NnZzZsSndzQUtIWFhhT3lteFQvb0xOT0R2Sk9VeW16WmRaYWJi?=
 =?utf-8?B?WXYvWWFKWjN5RUg1OHNrK0VxVTVMRUVSdktGNDUvYmtPQTllKysvS0NSdy9j?=
 =?utf-8?B?TklrNHBoTk1ZMC9Yc2JVOURwMURCSStDYmFSZlZsbjMxU3FFZVlUUGRlaEdQ?=
 =?utf-8?B?Q1RnRTBYdU0xKzlJbWpjeDBwLzRtREV0bS9ZMTFOajJRRzFFeGNiaG5DMnh6?=
 =?utf-8?B?SEV4ZGRDNnZlRldFeWt1aHpxNWJIbHp0NHpud1djUGhOeWQ3b3pQVVg3TTRL?=
 =?utf-8?B?aGk1NC9CNlNLdkJERklkelZFcUd0akRsVU1iYjF2UC9sblFxcGY1RndWMzBD?=
 =?utf-8?B?QXduVFFSUGZzcHhCU1VicnA3VHVOVW9DU0tDaVphelNEZmtEOEFWTE0vUFpz?=
 =?utf-8?B?cjBmMEdZa0t5NmdhTHNzUm9NTG5TTG1INy9oUGtwUXhndmJaeHN4VjFmdnRK?=
 =?utf-8?B?QWxsOWVFandTYnJTdmJlNjkvK05MRVVxdVh4NG44cmhoT1lYUU16NWZyeXhz?=
 =?utf-8?B?TitWV211QVRLcVVDMnFYZTdodkszenU0VzV3WmhPRTBaUGFvN3lnS1V4SlRm?=
 =?utf-8?B?T2diUlU2UEFYdDVHS2IrZVZXSDZPcTVYTWg0bldITGlLc1BrVDUzM0ttUDFk?=
 =?utf-8?B?UVNqdlVoVDdhZk1ESEdMREt0bTM5a3BPWjliTmtzelNRTVZMbUVjUks0RTN2?=
 =?utf-8?B?eU93L3hjZENDZ0VHZ1ZRa3o0bnZVQ3MxQjlQY0l5SC9qeVNydGFoYU5nQVMw?=
 =?utf-8?B?TVFNb2tlcXNMakxOdGk4M2UyWlNLQ0dxL3h1dmhWZzUxU3BIZHZCampqWmhx?=
 =?utf-8?B?VUpBNHgxVzU0WVEvQlo0OS95REQzaTF0TUgzMk94MVVPU2k4UlM2SXhSMDZT?=
 =?utf-8?B?TkNxKzdYU1NJQzFqNkw1TW10L3dpNDdZTEFCbEdSMGkvTkcyd3VUUk5rK013?=
 =?utf-8?B?THpkM09rKzVmdWV5M0NzcUlVR0RIdFFCU1h5Q0NyQy9Zb1FmZE1PV1lXUGFO?=
 =?utf-8?B?cFRxcGczWUQyeFVFbnpIWjhwNDk5YTNqdGRrcWt2KzRmUXNDd0NWWktjbXdu?=
 =?utf-8?B?aUFUS3Q5K0ZmY0JRaTdLSHZZSmI4NThZVWlqd3Evem9yeW9PS2RIZlo0dUV6?=
 =?utf-8?B?dDV5NFdFelczdTU2bFFYb0hVMUsrWmNpYzl2WG8vMmdWaGkySTh4V2ZIbmNK?=
 =?utf-8?B?ZmZpQXpNenNScEVvbFR2RFZUVFR2L0UzMHdRNkVwLzVoL21yYXFTR2hKcTVB?=
 =?utf-8?B?Q2FiV2NLeUtEZnV5YjI0VWQ4Ykd0emJnbEhsQ0tESmZlekhMeU02TFJPVmdF?=
 =?utf-8?B?TGZxUjFTdkloMnpqc2RyaGt3S0MrZDNDZE95NjluZFFTOWc3TkFjL1hLT09S?=
 =?utf-8?B?Q3pYZU03ZGpHZ3RqVCtXTlVBeWwwNEs3eW8vM3V4d2hVVTl6VGM0QmFJZ2Fo?=
 =?utf-8?B?VlF6QzhIc1AzaDdDbHhmUjNkV0FjYmphTXlmQWdhU0U0LzE4ZnVOZ3dGakdD?=
 =?utf-8?B?cVFnMlJjbHgwUVpVY1U0RURRZ244KzB6SmEwVmJvZW5QVVlZWXdWRkgybTQr?=
 =?utf-8?B?OTJ1UDNqQTlOVGsydjRvcXMwSVFKMTlmemFZMzRYM0Zab3pDbGRxdzdjV0R2?=
 =?utf-8?B?cjl5aTU3dllrQ0ZETmNzcExZYjJCTkJDTEhPWGQvSy9zR29kNHdYSzRBbDY1?=
 =?utf-8?B?elhxQmNCYWFxMmN1cDhycTBLd05UUzJDRmE3VkxpczZJWExKU3ltdmpCZzdY?=
 =?utf-8?B?VWZCUXlkVWpIbDY3WkZwUVdrdTEwSG9JTVpsMTJDbjkyUHptSlZBME5UN2dZ?=
 =?utf-8?B?QlJLYUVYSDBCY3M0cUx4ZVVmaGxMRnJMYlhaU3FOY2N3VnF4WElDOXZuT29V?=
 =?utf-8?B?dkhTRUxkVGVIOG5nSUdtZEdGNmNWcWtRcWtWTHRidTh2KzVVNUFDZFNuT2px?=
 =?utf-8?B?Q29zMUlWQmx2cUcvd2V1NDNNR1N1WTRMZ0d1VXowQkY2RnhRV3FpY0t4d3dO?=
 =?utf-8?B?dnVvOTRJdVpiY2ZuSnVpZVRMS0IrdTUxTUUzQnM4NUNNajA1bjdwNDhad1l3?=
 =?utf-8?B?YWVVWkpRRytsRHhwYTZpUjgyaFltSWYvRlUvRjhkQzJoQ0Fzb3l5UXEwL0ZO?=
 =?utf-8?B?UFNvN3BBV1MrdGhYTVcrMVM0VlFYeVgwYVJremxiV0FnYnJ4a3NNd3pVelM3?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67367577E0CCE64B8B97A89E5089F7F9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oHKfOAP0znuOWiu27gPKANMrJmJ8U9QhCOFx81TEwC0m3ItlmOvzKFTDFT88netvH33QBO2c1U5Nyi11duyhx+vmGvGODlYnELR8ppFAvNyMpw/1bEB044wqjjm8+ASrnj2WeeAvRjtQ8QMFo/G08lvsH3cCd15SnMgtEz/4dCP+eBOcxs8c6Bsq2bSx0PY7c8FyW+hdprbD3lyw17Rwy/icvw04BuOC6M83kO0RxQsfnYoK40B+xiHWl+4qaZvEEGtFQXApOlfd/6RrwSwJqSxkLaKIzGiQ5XqF/qm5j5e61WXZXpViwZdCOvdky5iSrGYWsNZ+muhfZHogrnXMNn/+cegRG7ne/a0hO+U+bps4FPG0NheAzkE+dA8Wt2BGaUepHD7QVApFUsDAZLYLKr0AiJtLimvSojYOr6HJWJU7ngtoukmU+CM+pV/h/w32syhfVqwS1sSeo1uAwhp/0Uz6m/F5vG84Bmtsm+Kt3p7APdCksalNGsVwwTTnaZlKOMkyc57VGV6qFPlzMmp50krO0XsVZATetSxsWqAIQXzDZSrainvjFaSzwlRyyvEGXpXOByXs7vr4LJ5BqEUNfCIpSRl8N8CFYjaPdAAVdcBGZdIozCBbvB0piM7ODNGI
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422d74dc-1a4b-4008-ce39-08dda34bd630
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 09:40:26.7481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9Twhc9O9CUUZlvcgj13rDtf1e4giRdb7lAkjXHwesxgcT576lwMQe8FH0+j1dKpY23gCyVocmvAFeCyrVcTAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9740

DQoNCk9uIDA0LzA2LzIwMjUgMDY6MTksIFNtaXRhIEtvcmFsYWhhbGxpIHdyb3RlOg0KPiAgIGRy
aXZlcnMvY3hsL2FjcGkuYyAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4g
ICBkcml2ZXJzL2N4bC9jb3JlL3N1c3BlbmQuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrKw0K
PiAgIGRyaXZlcnMvY3hsL2N4bC5oICAgICAgICAgIHwgIDIgKysNCj4gICAzIGZpbGVzIGNoYW5n
ZWQsIDQ2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9hY3Bp
LmMgYi9kcml2ZXJzL2N4bC9hY3BpLmMNCj4gaW5kZXggY2IxNDgyOWJiOWJlLi45NzhmNjNiMzJi
NDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2FjcGkuYw0KPiArKysgYi9kcml2ZXJzL2N4
bC9hY3BpLmMNCj4gQEAgLTgxMyw2ICs4MTMsMjQgQEAgc3RhdGljIGludCBwYWlyX2N4bF9yZXNv
dXJjZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpDQo+ICAgCXJldHVybiAwOw0KPiAg
IH0NCj4gICANCj4gK3N0YXRpYyB2b2lkIGN4bF9zb2Z0cmVzZXJ2X21lbV93b3JrX2ZuKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykNCj4gK3sNCj4gKwkvKiBXYWl0IGZvciBjeGxfcGNpIGFuZCBj
eGxfbWVtIGRyaXZlcnMgdG8gbG9hZCAqLw0KPiArCWN4bF93YWl0X2Zvcl9wY2lfbWVtKCk7DQo+
ICsNCj4gKwkvKg0KPiArCSAqIFdhaXQgZm9yIHRoZSBkcml2ZXIgcHJvYmUgcm91dGluZXMgdG8g
Y29tcGxldGUgYWZ0ZXIgY3hsX3BjaQ0KPiArCSAqIGFuZCBjeGxfbWVtIGRyaXZlcnMgYXJlIGxv
YWRlZC4NCj4gKwkgKi8NCj4gKwl3YWl0X2Zvcl9kZXZpY2VfcHJvYmUoKTsNCj4gK30NCj4gK3N0
YXRpYyBERUNMQVJFX1dPUksoY3hsX3NyX3dvcmssIGN4bF9zb2Z0cmVzZXJ2X21lbV93b3JrX2Zu
KTsNCj4gKw0KPiArc3RhdGljIHZvaWQgY3hsX3NvZnRyZXNlcnZfbWVtX3VwZGF0ZSh2b2lkKQ0K
PiArew0KPiArCXNjaGVkdWxlX3dvcmsoJmN4bF9zcl93b3JrKTsNCj4gK30NCj4gKw0KPiAgIHN0
YXRpYyBpbnQgY3hsX2FjcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
ICB7DQo+ICAgCWludCByYzsNCj4gQEAgLTg4Nyw2ICs5MDUsMTAgQEAgc3RhdGljIGludCBjeGxf
YWNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIA0KPiAgIAkvKiBJ
biBjYXNlIFBDSSBpcyBzY2FubmVkIGJlZm9yZSBBQ1BJIHJlLXRyaWdnZXIgbWVtZGV2IGF0dGFj
aCAqLw0KPiAgIAljeGxfYnVzX3Jlc2NhbigpOw0KPiArDQo+ICsJLyogVXBkYXRlIFNPRlQgUkVT
RVJWRSByZXNvdXJjZXMgdGhhdCBpbnRlcnNlY3Qgd2l0aCBDWEwgcmVnaW9ucyAqLw0KPiArCWN4
bF9zb2Z0cmVzZXJ2X21lbV91cGRhdGUoKTsNCj4gKw0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+
ICAgDQo+IEBAIC05MTgsNiArOTQwLDcgQEAgc3RhdGljIGludCBfX2luaXQgY3hsX2FjcGlfaW5p
dCh2b2lkKQ0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIF9fZXhpdCBjeGxfYWNwaV9leGl0KHZvaWQp
DQo+ICAgew0KPiArCWNhbmNlbF93b3JrX3N5bmMoJmN4bF9zcl93b3JrKTsNCj4gICAJcGxhdGZv
cm1fZHJpdmVyX3VucmVnaXN0ZXIoJmN4bF9hY3BpX2RyaXZlcik7DQo+ICAgCWN4bF9idXNfZHJh
aW4oKTsNCj4gICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3N1c3BlbmQuYyBi
L2RyaXZlcnMvY3hsL2NvcmUvc3VzcGVuZC5jDQo+IGluZGV4IDcyODE4YTJjOGVjOC4uYzBkOGY3
MGFlZDU2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3N1c3BlbmQuYw0KPiArKysg
Yi9kcml2ZXJzL2N4bC9jb3JlL3N1c3BlbmQuYw0KPiBAQCAtMiwxMiArMiwxNSBAQA0KPiAgIC8q
IENvcHlyaWdodChjKSAyMDIyIEludGVsIENvcnBvcmF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVk
LiAqLw0KPiAgICNpbmNsdWRlIDxsaW51eC9hdG9taWMuaD4NCj4gICAjaW5jbHVkZSA8bGludXgv
ZXhwb3J0Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvd2FpdC5oPg0KPiAgICNpbmNsdWRlICJjeGxt
ZW0uaCINCj4gICAjaW5jbHVkZSAiY3hscGNpLmgiDQo+ICAgDQo+ICAgc3RhdGljIGF0b21pY190
IG1lbV9hY3RpdmU7DQo+ICAgc3RhdGljIGF0b21pY190IHBjaV9sb2FkZWQ7DQo+ICAgDQo+ICtz
dGF0aWMgREVDTEFSRV9XQUlUX1FVRVVFX0hFQUQoY3hsX3dhaXRfcXVldWUpOw0KDQpHaXZlbiB0
aGF0IHRoaXMgZmlsZSAoc3VzcGVuZC5jKSBmb2N1c2VzIG9uIHBvd2VyIG1hbmFnZW1lbnQgZnVu
Y3Rpb25zLA0KaXQgbWlnaHQgYmUgbW9yZSBhcHByb3ByaWF0ZSB0byBtb3ZlIHRoZSB3YWl0IHF1
ZXVlIGRlY2xhcmF0aW9uIGFuZCBpdHMNCnJlbGF0ZWQgY2hhbmdlcyB0byBhY3BpLmMgaW4gd2hl
cmUgdGhlIGl0cyBjYWxsZXIgaXMuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gKw0KPiAgIGJv
b2wgY3hsX21lbV9hY3RpdmUodm9pZCkNCj4gICB7DQo+ICAgCWlmIChJU19FTkFCTEVEKENPTkZJ
R19DWExfTUVNKSkNCj4gQEAgLTE5LDYgKzIyLDcgQEAgYm9vbCBjeGxfbWVtX2FjdGl2ZSh2b2lk
KQ0KPiAgIHZvaWQgY3hsX21lbV9hY3RpdmVfaW5jKHZvaWQpDQo+ICAgew0KPiAgIAlhdG9taWNf
aW5jKCZtZW1fYWN0aXZlKTsNCj4gKwl3YWtlX3VwKCZjeGxfd2FpdF9xdWV1ZSk7DQo+ICAgfQ0K
PiAgIEVYUE9SVF9TWU1CT0xfTlNfR1BMKGN4bF9tZW1fYWN0aXZlX2luYywgIkNYTCIpOw0KPiAg
IA0KPiBAQCAtMjgsOCArMzIsMjUgQEAgdm9pZCBjeGxfbWVtX2FjdGl2ZV9kZWModm9pZCkNCj4g
ICB9DQo+ICAgRVhQT1JUX1NZTUJPTF9OU19HUEwoY3hsX21lbV9hY3RpdmVfZGVjLCAiQ1hMIik7
DQo+ICAgDQo+ICtzdGF0aWMgYm9vbCBjeGxfcGNpX2xvYWRlZCh2b2lkKQ0KPiArew0KPiArCWlm
IChJU19FTkFCTEVEKENPTkZJR19DWExfUENJKSkNCj4gKwkJcmV0dXJuIGF0b21pY19yZWFkKCZw
Y2lfbG9hZGVkKSAhPSAwOw0KPiArDQo+ICsJcmV0dXJuIGZhbHNlOw0KPiArfQ0KPiArDQo+ICAg
dm9pZCBtYXJrX2N4bF9wY2lfbG9hZGVkKHZvaWQpDQo+ICAgew0KPiAgIAlhdG9taWNfaW5jKCZw
Y2lfbG9hZGVkKTsNCj4gKwl3YWtlX3VwKCZjeGxfd2FpdF9xdWV1ZSk7DQo+ICAgfQ0KPiAgIEVY
UE9SVF9TWU1CT0xfTlNfR1BMKG1hcmtfY3hsX3BjaV9sb2FkZWQsICJDWEwiKTsNCj4gKw0KPiAr
dm9pZCBjeGxfd2FpdF9mb3JfcGNpX21lbSh2b2lkKQ0KPiArew0KPiArCWlmICghd2FpdF9ldmVu
dF90aW1lb3V0KGN4bF93YWl0X3F1ZXVlLCBjeGxfcGNpX2xvYWRlZCgpICYmDQo+ICsJCQkJY3hs
X21lbV9hY3RpdmUoKSwgMzAgKiBIWikpDQo+ICsJCXByX2RlYnVnKCJUaW1lb3V0IHdhaXRpbmcg
Zm9yIGN4bF9wY2kgb3IgY3hsX21lbSBwcm9iaW5nXG4iKTsNCj4gK30=

