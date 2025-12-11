Return-Path: <linux-fsdevel+bounces-71165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A2CB75F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 00:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE9563022F13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 23:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4702E62D1;
	Thu, 11 Dec 2025 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oBfNt5Aw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985212E11B8;
	Thu, 11 Dec 2025 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765495245; cv=fail; b=EqcCj2pwHyDxXmpV+0/KmjpiU9iR7Diz53gYcJoOk9T43YIrR5JNQNUlkIifuccgRm9+li9xDIuZBt6FFevPSAoT27eIMW8DMnGXcF8CwPKxrF0W0YqSrVUjNvcPpW9OH0sOnsOulXpy9oPCgQavpi7XrFBDNjryf9+jsJKqlXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765495245; c=relaxed/simple;
	bh=Dl42Zh719wEN6x3r6qwAKoGvxyW0GBxOGC2YbOwUBtg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FT7jZViut7fA6c6h6sMw+6BFIZo5hLfb0OtQLQAMoOCCBLZaOvJKRorb9gz/oe9p3dSyqRFF0ky1lrRNcJlWbCmUse+o2LB7oic/vUTFikeAy0DqvMcOUFzRA1mB9zbYzkuHMPQZac67vZOnIrVK/bvDSfix2UXGEXytFyCSirQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oBfNt5Aw; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLPdcBx8Gc4IRdUeUCULOEu/YVcYohrax04LzlRc9fPX+zi3//z7nLAl0+DfzPP7lQw1yTN4dlJrZtvZtnkm6yXbahuCRrCnX2Fw8Jqz+asx57jEZxXqtKVvHcKaR2oizMjzR2/pxEzFwE1RrLo6+lHOE+ECXvLtnHhrfpGSps1VIrd5rsEXoxO5Pt32waERtCw/P5M4yNWa5CskKeqD7tKhqwzrMYoAN2mWYbp+Q+GxWbFt3ktQyY0edxR+eSkhwuq0Fl21hxPsy5rxDg4Ll1dXlVlPncjL0fHesNUMHT1IkoL9gABDvhfUOdWcj0WgpdcExtaTFWgUSIG0ycHdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN54JRlXCU6Yc5EZCHIhupibLnggsgXA6sfDqDTTNxY=;
 b=m5d5wh1CwcglwpGwJ6xPEwf3VGwZG+tqSFv72gOBax9PRpWsJ6gvOAQBZ57c4B6lfhY/tMjDivMrw/ijZ/C6waLAI/c5qQ+hbz6WwyMkR0TlnqL/SGPCMd2nDhR39hidIEtzCx2qRlsIo0S2mzYhscX0gJYTFhIX/cMt9kJ+iljxlpil9xqgRcEg8yROwg9+7eEDUPuzU4rVHY4pK+C8WO9MgzulYBN7fPuMO9OgV6AO1LRf7mozKWy07MGIbZLktrEt/ue18Pz+J4ssKYeT3f1+zclCb100Oco7UT/OSNZ5FLq5JRJXnh4A3xpoXGHixNSlqWf8lFKLt2jS5n5r7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN54JRlXCU6Yc5EZCHIhupibLnggsgXA6sfDqDTTNxY=;
 b=oBfNt5Aw9JDleBoPDKGs/lnIv645R1GrIMIlX3JWstSp8KQ6e2Pd6JHJOGJ20qThTDMgdKUqxZrqc0Y3OGPUdCkVQHHl1StlVwCPxgLN9QtDPacBzeeaafs4RU5pAVfISWDmUyw0nuoUkngL022g+IeHZJolj+oReMrDTG8vph8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) by
 PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Thu, 11 Dec
 2025 23:20:40 +0000
Received: from DS4PR12MB9707.namprd12.prod.outlook.com
 ([fe80::5c6a:7b27:8163:da54]) by DS4PR12MB9707.namprd12.prod.outlook.com
 ([fe80::5c6a:7b27:8163:da54%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 23:20:40 +0000
Message-ID: <b3f230eb-b11a-4a83-ae6c-3ac0a70e8e20@amd.com>
Date: Thu, 11 Dec 2025 15:20:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] dax/hmem, e820, resource: Defer Soft Reserved
 insertion until hmem is ready
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
 <20251120031925.87762-2-Smita.KoralahalliChannabasappa@amd.com>
 <692f65ecb5603_261c110090@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <692f65ecb5603_261c110090@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::18) To DS4PR12MB9707.namprd12.prod.outlook.com
 (2603:10b6:8:278::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9707:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: eac3d321-af0b-4dfa-7172-08de390be629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnpjT29TTjBSR2pJVUFrNW5qSndZOUQvclRQVzJoY2lCK2hFYkR0Y2FaMExt?=
 =?utf-8?B?K1F6L0d1djRKUlpCci9QZ3ZkaUpsTFQvbTMvS2Y3d2RrMU9tUEgyMDNwTjdU?=
 =?utf-8?B?eURpbnQ3Y2c2ckt0ZW9kOVRyd1pPUWpTeXFEd0d4KzBwNWl3VUhGemk3Zjlw?=
 =?utf-8?B?L3ZSZk13a2MxemU2S0lBZ0NDMnhvNEhUN3NQSXZRTnkvRTlCQ083cHlEZy95?=
 =?utf-8?B?bWFtcGsxRXJjUTFzSUswTDdBMEx0cllLSUl3VE53bm5kaTRoZ21ybkVnZk5P?=
 =?utf-8?B?ODdGY1BKdnhtdm1zeDJuZVRITUJ6MzRwVnhZUEhPamtFU0tuc25IQVExcEhO?=
 =?utf-8?B?Wm4vVzkvL0RzdTI5K0tHd2FmMTQ2ZWdKRFVpeStxc3lHa0k2TThySXB3OVVG?=
 =?utf-8?B?ZlVxNi9ZNFArR0hGMnhncGNtK1RvaEloWC83U0RpcW5RUkxGV3VCaHVzTnJJ?=
 =?utf-8?B?aEp0SWJhWHJFV1ZYOEVxUTB2N2RhR2Y2UGtXZStvcDYvWU5Ob3lDL2V0VFhM?=
 =?utf-8?B?dzVGQ2FrZVVHWXVsWHNXdFpYc3pCNk9pTmQ2YzNCTlRpTlZKSTlNMzFUNDV5?=
 =?utf-8?B?QnlGN010c1FQNi9qMEk3ODdYWXMvcmF5bzV3anVOMi9naG1nczJYeDUrRm9h?=
 =?utf-8?B?T0dpV2JuZVg1Vm1MNXN4cGl4bXJIS0ZNT3dCV3B1MUpHSFJuU0NZbyt1STFs?=
 =?utf-8?B?U2dscWIxNWcwOC9STUZWZG91Z0RtRW5QVTB3bUN5aGo3WmFrNE5DancvaFhG?=
 =?utf-8?B?SVFxMHRyUGo2N2tmSGlHcWxuQWw4aFlDS3JkRXZmb1o3M3BxaUhCbExQZ0Y3?=
 =?utf-8?B?WVBrZjVwZ092S01YTlp0U0lwR1FTSTZKOTdiREtFdSs3c2ZxQklIeDFUUkhk?=
 =?utf-8?B?SnpYRnp2QThnaXNqTTZmSXJteTF5TFlab1FUcThCQ2J3MkthTDZGOU5FbDRl?=
 =?utf-8?B?MEhFYXprakVRbGxyZStVaVFtRVhrdHNhY3RDQ1RERGVqRkxUL1UvM2NDeGt3?=
 =?utf-8?B?UVVwV1BvZmxuVm8wTVd4RDFSbnJkSFl1L2NwVmhRTUZmU2haak1EK2x4dmVP?=
 =?utf-8?B?bGpnRFFvek1ha09OQkVpZWZrS1dHUWg0WEZ5VXN6MElwU2N1dTRRR0tZdzc3?=
 =?utf-8?B?N1FyNUo2K1RqRkhkZUNjTjZhNmdxNEU0b1QvdGpCVEV5VHBWb00rVE1ZQmxr?=
 =?utf-8?B?N2RpRU1CLzlXNHpsRmlTM2JTM015eVdMZlBhUVZKVnVlSGNtNzI3UWtWRGpm?=
 =?utf-8?B?U2tEUCtFZ0Y1RXZHUDJ4WEd3a2dMd2ZiK05GdFNFa3dHSG5yS3lzUmgwMmRi?=
 =?utf-8?B?aFRWRnNDcHE5bWJpRmw0dUtSOFV2UzhCcG1EWjV5S0grdzBJRFBRRHZ4RjNJ?=
 =?utf-8?B?WllTRjdVZHZjZmVxcmVyZy83WFB5QVVTcWw2Z0h6TmtOamswVURIM0EyZjhp?=
 =?utf-8?B?ZjZDd1AwYTRab3B3YXBtWFBrK0lHdlNXSlRaSDNBc1UwaURsdHBLTnIrRUd0?=
 =?utf-8?B?WXU5RmdlQ0ZvU090aVUzZEtCbnB4OHZhcUpxVjh3UFRBNWVPSStDaUx3T2d4?=
 =?utf-8?B?QXIvbFZJd2psakhZaHBEL1BlQ1FmdU9OSFp5cE9ZSlc5M3haYTlMQmprcDBK?=
 =?utf-8?B?bklWTXBZcFhRVW5GcUIzV0FRMkZKejZSRFM2ZUZnOHNLL2Z1TlBvT1RtdXR3?=
 =?utf-8?B?bkxyM2dkVEVLay94WjhHVktjSkZjdUJESkNscjljWTRpQnR1ZXppVmRjWDli?=
 =?utf-8?B?UUZpcXNjSDJEMlFuUmsyWmxscSt1R2R4Nm1vSU5rL0wxRUVGVFd0b1RFeUNM?=
 =?utf-8?B?UURlMlFVN2J6SnovcHlvOXBOcGRDSjhNSDFiVkpOSnFPdnJZVTBQQ0twSUpO?=
 =?utf-8?B?U2l0dGtXRnhkam9Ba3dRQkZveFJ4cHJzYWQwd3FudFpJRWw3VWhscjQ2YXMr?=
 =?utf-8?B?aytORkpNYWtnMmpCYjdlNDBQaWJnc2Z6K3FKMHJYZzFQQ1c2RS9uT280SzdT?=
 =?utf-8?B?Tm5RQVlxbXNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9707.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlcyblpuenpTQ0xJU3BJRlVLNG5iVEE1RklldjhqSUNaYUNaOEVjK2docDA4?=
 =?utf-8?B?ZzMvZmtXTERqcTdFUlplbHFOajlqaENBemZ4b0hONzVxam56cEo1VldydDZK?=
 =?utf-8?B?YXBjaXBBZHhtdmN2L2Q3eXNaRFZhVzFIeWhaNmpjS0lvMFNET0p5bjFEUHpq?=
 =?utf-8?B?RUpNVFlwRjhyRWl4SHhTUGlqWjBSQkRjb2ZmT2VaZkFEenNBQVovRFFpbnoz?=
 =?utf-8?B?eE5wM1F4RWJXZE1adzBFWTFNaTA4ZmU0Sm9kSFJPc2NMZzM2RmVCT0E1TG13?=
 =?utf-8?B?SGR5ZkdibEptZmhJK2RFVjJva2o5UHE0YmRDUjN1WlFqc09KYk5MekNNU1dx?=
 =?utf-8?B?cmtRMHJ5R3h0WVcyYm56L3JWRU1HTFBmQ0lZS2lNaXNCMHBGUVhGcksvMnpr?=
 =?utf-8?B?dEVDUHBQK2ZGb3BCTFlQU0x3ZExEU1JKQkI3Z2t5Zk9Va0U3SnFsSzM1SUN3?=
 =?utf-8?B?Mm9ZV2xPV1lsZGtxeXZjdWw3ak9YMndnU1VEMFEyeHlUNTFGOGtpTkJiTFF0?=
 =?utf-8?B?U0JHa0RaNnI3OWRZb3ZDM3NHQTdhOW9odGNMcnk4MWVaSFRMRWtUNG5xR1dm?=
 =?utf-8?B?Qy92Y1hHUFdZR0tlQlo1R2F0RS9yS3ZuQ21FRXkxRCtxUWlrTmUyY0s5L0Ez?=
 =?utf-8?B?NlJ1QlZJeVBpcml1ODYrektRRG1DWW1KUmZ6RTJveDRhUWR4RDFLR0FKbUha?=
 =?utf-8?B?ckFaOXd5bDlNcUJ4R1QyWlZvbS9LS1I2SXZHMURIcDFQYllwZ2QzdWVxVHkz?=
 =?utf-8?B?dGhHcGtyTVVQbUhVN2pKdEhhKzViUjJWM3NzSXZaR01VT0MvQXRJZUlYdVRx?=
 =?utf-8?B?RWlLK3k5aEtlRW94SVVmS25RU3NRNDVPM0RSSm5QYlNuU2s0YXhybm5JaFZR?=
 =?utf-8?B?VG9GZFZvR3Q5aGtTRCsrUjBoMi93REpzTGgwNXF6aXhoNzdOa1Z4QitHblN4?=
 =?utf-8?B?cWkzaTlTVzVYeVNXUWdLYmdDVHVCSWtrd3lvMTYyYXlKc1BFOGEyUFJvMHhz?=
 =?utf-8?B?a3N1MDgzZXR4K05jS0FvSjcvdjFsUnNMRjRBNjMxSWpERGpta0FwL25rejFI?=
 =?utf-8?B?OEwrekFEZVNBZGU2WXhFalJCaTlVb2NtZ2Q5aEovUHpacVdpWFRRM3ZKeHQ2?=
 =?utf-8?B?dGhnb0NQc3prS0ZQcTJsQlFrQ29qVTl0Qkp0NkxPeEwrZ1RVOUI2L1FPS0pV?=
 =?utf-8?B?bWFUdkptdjM2Yyt1UnUxQUh2ZG12UWNnOWZvQzJMQTh2VjM4bzFIT2IvelZx?=
 =?utf-8?B?SmxvOXVlcm5KTWxHaXl6VGFpbWdZNkJ0TkZla2RrSDVWaTZJeHZWejdIZjZt?=
 =?utf-8?B?ZlBUQzJSSk4xYUhyUUczbjVJaFp3TkliNi9pM1l5cXJDTUdhZEJpQ0l5SUg2?=
 =?utf-8?B?cmU0VEViZDkvUVlsSDNNaGVhNGdXSUNUdFlJcUNpdDBhV0J1N1hqVHM3SjlR?=
 =?utf-8?B?TDM2NHlTd0YyRFNteDhtVjc1NnpEV0NKelBibm1BaUdJUlBxbXg1aFljckVJ?=
 =?utf-8?B?OFl0dFJXQy90OXBYRE1wS3diMXBzTnhaZzBiNUpBOXN3NE0ybU5US3UvTVJK?=
 =?utf-8?B?Wkl0Q0Rla0dqd3dpK3FHVng1M3UyU0xBeE9jM0pRVTd6S0NJTGxld3FVcExv?=
 =?utf-8?B?K2VJdUtGd2pEN0tTTXlVNTBFM1dmN3BYNGlwZ2RmUkJpKzF4Ri91djF5eHdP?=
 =?utf-8?B?blJlbC82U3VGenBEWTJuSHpnSngvWGdmRzBnSDQyZlpuYjQ5TjFxL3BDQXdl?=
 =?utf-8?B?MTJxWVlpVklIck9ON1psNktoUEV6UVhIMy9Xbng0d09JMGF6VUxsWkljbG51?=
 =?utf-8?B?Skc1MEl0ODRoRHhkSVlLNlpGQWIrbUtFY29tRS9FTEl2MlVEQlo5NVByYUlM?=
 =?utf-8?B?ME9Wc3RhdVcrdTdyQzdlNE0yM2lDL1VJRzJZVnc4R1g1a2tJOW1Qay9WakRk?=
 =?utf-8?B?UWEzY1lrcUtUaGxqSmkwTWpNRFFsdXE3N1RESDNjTEZSSGxQWEk0d09ZZDNi?=
 =?utf-8?B?UGlwRVN4THMvcWFjVnkxZXRiaHVYTWpSeXRWVkxZMlRONlViSUdCYlArb0pr?=
 =?utf-8?B?MkhOV2ZsazE3eEVsa2hmVE1iVVRtRDA3NnZsZUdoL3pOVTMvdzViTHV2eER3?=
 =?utf-8?Q?3+PIXw5WSQf4JrINuCEHcp7ur?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac3d321-af0b-4dfa-7172-08de390be629
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9707.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 23:20:40.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuoT6X+1Kk8ugsFU4NjDHMllg+k3ClLCxavtXSzTVt1GAwbn9uB2WLv9QHWtjVC9KxmTSnvzlwPpyyR5TnOGSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

Hi,

Sorry for the delay here. I was on vacation. Responses inline.

On 12/2/2025 2:19 PM, dan.j.williams@intel.com wrote:
> Smita Koralahalli wrote:
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> Insert Soft Reserved memory into a dedicated soft_reserve_resource tree
>> instead of the iomem_resource tree at boot. Delay publishing these ranges
>> into the iomem hierarchy until ownership is resolved and the HMEM path
>> is ready to consume them.
>>
>> Publishing Soft Reserved ranges into iomem too early conflicts with CXL
>> hotplug and prevents region assembly when those ranges overlap CXL
>> windows.
>>
>> Follow up patches will reinsert Soft Reserved ranges into iomem after CXL
>> window publication is complete and HMEM is ready to claim the memory. This
>> provides a cleaner handoff between EFI-defined memory ranges and CXL
>> resource management without trimming or deleting resources later.
> 
> Please, when you modify a patch from an original, add your
> Co-developed-by: and clarify what you changed.

Thanks Dan. Yeah, this was a bit of a gray area for me. I had the
impression or remember reading somewhere that Co-developed-by tags are
typically added only when the modifications are substantial, so I didn’t
include it initially. I will add the Co-developed-by: line.

> 
>>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   arch/x86/kernel/e820.c    |  2 +-
>>   drivers/cxl/acpi.c        |  2 +-
>>   drivers/dax/hmem/device.c |  4 +-
>>   drivers/dax/hmem/hmem.c   |  7 ++-
>>   include/linux/ioport.h    | 13 +++++-
>>   kernel/resource.c         | 92 +++++++++++++++++++++++++++++++++------
>>   6 files changed, 100 insertions(+), 20 deletions(-)
>>
> [..]
>> @@ -426,6 +443,26 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
>>   }
>>   EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
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
> 
> It looks like one of the things you changed from my RFC was the addition
> of walk_soft_reserve_res_desc() and region_intersects_soft_reserve().
> With those APIs not only does this symbol not need to be exported, but
> it also can be static / private to resource.c.

I remember these helpers were introduced in your RFC but I think they
weren't yet defined. With them in place, agreed there’s no need to
export soft_reserve_resource. Will fix this in the next revision.

> 
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
>>   /*
>>    * This function calls the @func callback against all memory ranges of type
>>    * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
>> @@ -648,6 +685,22 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>>   }
>>   EXPORT_SYMBOL_GPL(region_intersects);
>>   
>> +#ifdef CONFIG_EFI_SOFT_RESERVE
>> +int region_intersects_soft_reserve(resource_size_t start, size_t size,
>> +				   unsigned long flags, unsigned long desc)
>> +{
>> +	int ret;
>> +
>> +	read_lock(&resource_lock);
>> +	ret = __region_intersects(&soft_reserve_resource, start, size, flags,
>> +				  desc);
>> +	read_unlock(&resource_lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(region_intersects_soft_reserve);
>> +#endif
>> +
>>   void __weak arch_remove_reservations(struct resource *avail)
>>   {
>>   }
>> @@ -966,7 +1019,7 @@ EXPORT_SYMBOL_GPL(insert_resource);
>>    * Insert a resource into the resource tree, possibly expanding it in order
>>    * to make it encompass any conflicting resources.
>>    */
>> -void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
>> +void __insert_resource_expand_to_fit(struct resource *root, struct resource *new)
>>   {
>>   	if (new->parent)
>>   		return;
>> @@ -997,7 +1050,20 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
>>    * to use this interface. The former are built-in and only the latter,
>>    * CXL, is a module.
>>    */
>> -EXPORT_SYMBOL_NS_GPL(insert_resource_expand_to_fit, "CXL");
>> +EXPORT_SYMBOL_NS_GPL(__insert_resource_expand_to_fit, "CXL");
>> +
>> +void insert_resource_expand_to_fit(struct resource *new)
>> +{
>> +	struct resource *root = &iomem_resource;
>> +
>> +#ifdef CONFIG_EFI_SOFT_RESERVE
>> +	if (new->desc == IORES_DESC_SOFT_RESERVED)
>> +		root = &soft_reserve_resource;
>> +#endif
> 
> I can not say I am entirely happy with this change, I would prefer to
> avoid ifdef in C, and I would prefer not to break the legacy semantics
> of this function, but it meets the spirit of the original RFC without
> introducing a new insert_resource_late(). I assume review feedback
> requested this?

Yeah here, 
https://lore.kernel.org/all/20250909161210.GBaMBR2rN8h6eT9JHe@fat_crate.local/

> 
>> +	__insert_resource_expand_to_fit(root, new);
>> +}
>> +EXPORT_SYMBOL_GPL(insert_resource_expand_to_fit);
> 
> There are no consumers for this export, so it can be dropped.

Okay.

Thanks
Smita


