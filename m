Return-Path: <linux-fsdevel+bounces-75378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C0nYAmWLdWmMGAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 04:17:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 584627F917
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 04:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52287300291F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 03:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31657214204;
	Sun, 25 Jan 2026 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WkTPj6fs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AE10F2;
	Sun, 25 Jan 2026 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769311066; cv=fail; b=LBWhOH2XjIiBt9/i33NU2XHZUDbRiupkpajIbKzmhWp4hNfWVvKJvx3s7HtHYhyKm/VPF1fGywWQuA9uXcnlRiOC91iHupIFb9MeDkBqgBC31EssJhs73CP1XTKw9nrgv4rerKsl/X3ADPIES6ZsiCqGd8tWB2dxuDxhsf0XzZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769311066; c=relaxed/simple;
	bh=98KTE1/EhrlYxSTfkEKE1mcrd7VFndKx79wxoARjm5Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fYPNSPK2fMjJjha8unNbOBwl0gFR//1qXKbKVPMooAjMlm+G+BxVqQ3fGhD4DE/IObyN5nUCw87N0DpYooeOtxzYexckNpxkP41jigQ09ZN6DWghaI7/2ImZZGTAc62q59hSCLbGGeButqjtumWnbcFl/3fkHGT4GWUJVZVjaLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WkTPj6fs; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ehf8QNJl5G8lidKeGwX4YXiBejoHFTv4OUzVljs7jayRLmoV5nb9ImEf1fQvWQZQ61fCaZhP5kzI1R0+Bwl6BgmWovzcEXF64uVCm7orNRdTNeI80xWX9ZsgvCYgtFbjsUsbsCBfTtF80OXrvlyXxZsth7sJ4PNbzgnz4iN4gGRTAedvHoshTiWIK2mddvBiTN/gnMPj83yREPewGt/l/a40tKxSXCZ/6O1GqPqlA1AT9aJzV1qP+3VLbPKZ4bVmG7fQn0XNDOl0dL6wMPvdreRgZY+hpoVlH7zB6QixZo51rnrgqbHJQh7YiUSS3LlyQu0oakTkdW3lL09UPCWhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY7DxDSDI6vQdtH8GCw9wHJoCiZwNTCG5U2ykmWGIYY=;
 b=H0j32ZxJjSOHK3/XuL4nm8yytkb9MCWNBiZC+Ut8fQTu4hzpI0uvHa/CGlLpgD6YgzgSn3pkunZSi2N54Yozv5hH0jZyoda7IE5/bbJ28hGu8IPRtbuaGgjWMbxhaS9WUrv05xpwavC7t9dFdTz7jpu3yuCK87nIXD7HyrgJqLommgprdiimH1MN2Y8CBefkHknL8vQwgN5ZE3PaYmUBDbExpnG7/X+TO++0UapYMNqMpRn/Q2m1p0IH3K7cSVI53qjW0qUKFVdWmT4tx++ngyPmptaLuLwIOvM1qSfmzk4uLtXxu/hTPLR9Vyi0F7ikyBaANJEuYFrHmxiEVWq9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY7DxDSDI6vQdtH8GCw9wHJoCiZwNTCG5U2ykmWGIYY=;
 b=WkTPj6fsuTSR1WAgH37NEUy66zUpnzVdGlWp4VRo/cWi2MT+7PtAWdQfBn4aBnx9/s3AQ2hBNn4PKZuZQIs7YeoQqtEPcoH/4EGeSbsKVqytFLjlTtcr7LLfLBKJzsYQaaD52Jb8ix6IMSge4+cIe3BJEmuH6l5vbdK9JTvwf4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 03:17:39 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 03:17:39 +0000
Message-ID: <84d0ede7-b39d-4a41-b2b6-8183d9ccbb9e@amd.com>
Date: Sat, 24 Jan 2026 19:17:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <e38625c5-16fd-4fa2-bec0-6773d91fd2b4@amd.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <e38625c5-16fd-4fa2-bec0-6773d91fd2b4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: e2616ea1-4ff6-4532-a50a-08de5bc04b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVpwc1lGcncwT1ZwVjU3MFl2bkNzYTMvOWRvNW0rUGxFSklpRUxwQUo5TFdR?=
 =?utf-8?B?MkZpdmFyTXdtVHo2YXpRTUhqdkZ2cExRZU8rSzFzT1Z6Q2xWM2llejFZZUU3?=
 =?utf-8?B?ZVFnc2ZnVUg5Vm11M1kzK0VyMm04bEFQU2RCWno0aDUyQ0RiaExTNTRkeGxk?=
 =?utf-8?B?RThMSkQ3bFJWMnc2Rlo5YUdqM1lRNWQ2TFVxMHhXZWNWbjFnUDlYL2lBN0l4?=
 =?utf-8?B?Y05PSzFkRmJnaGJPdlhMOHJ3enVyQTRLa1BmRDBNa0ZtUzQzc2p5UTZaNmlR?=
 =?utf-8?B?MkV0ZU52bUhNSXh1ODFEdndINUNuWWlaTkRZdG1nVkR6WlBydGk2eFBvWmpk?=
 =?utf-8?B?MDZZblJ5Yjl1Mm5oTGtNZzV6S3NReGV5VkI4SmZCME1PSUw0SmJDYW1QeStK?=
 =?utf-8?B?bTM2R1J6M3BNcUhocjRwc0htZlI2RUorczdmeFFHYzhWc1B2ekdjT1hoZDMy?=
 =?utf-8?B?ZUpGM1h0K2FBeDhtSE5wTUd1SVNhK3pCZ0UyMGJVM0dxalVkM0M2VERDd1Zn?=
 =?utf-8?B?UWRCSlkrUHV1L0M4VkQwTmUrMStDRUwrdEk0RGUvRTRyMnF0bDZSTENQSTZQ?=
 =?utf-8?B?NHI1WVNCRVMrUEl0ZmlPbTBwTFBPcllLUDZ5TDhwbUxDeDlYSHM5c05uQ1Zt?=
 =?utf-8?B?WnFCYlh0S0J3TEJ1enpsU2k1T1IrbjR3Q1lVTnJwQ0ZNTzR6cEdFQnAwSXB5?=
 =?utf-8?B?TGQ3ZU04K0wzRnh5K3doUnFMMjZ5dUowL3ZwWnp4bmpaWEZRLzd5bU9ZMzVj?=
 =?utf-8?B?YjBRVURaOElPcE5RckNiVnk0R2ZDczFiMmJtbXFiTEcxODNXWW80aXVnanBV?=
 =?utf-8?B?UU1LakhmUjM5UWdVenVDVnpXNC93cmF2N29XWVJkMU0rc1AzeFBEQ3JqUWJj?=
 =?utf-8?B?QXNyK1FuRGZ1RTdIcUZ6dmtOTG5JMXZMcldvMjhJeWxIOVVCVWgwUXkybWNJ?=
 =?utf-8?B?c3J5U3NLcTlWYTU1VTBZWE8zTXljazJQVEdva0YwZWZQbjM5ZllieHpEU00w?=
 =?utf-8?B?eFZCays3ODVsUXRPdWJueFpJN3FqMjVzQlBVbzZRWTVudzR0bkRKUHRmY3h0?=
 =?utf-8?B?ZXBaMGJOYnUrZWV3MDdvRTV5YzNSY0lvRzVvbXJpa0RZb0VoN29YcWtQNGZY?=
 =?utf-8?B?MWdsd21QeGVveVlhZ2hTdFpCd1pyNGVYVnVka2ZVNHJKT1A1WUdPK3l6QUMr?=
 =?utf-8?B?Mm9uUm9Fbmh2QURWUDZ1eEhER1ZGdkZsby9lWkI1Mnk2RnZPcTBDRUNWQ2Zl?=
 =?utf-8?B?UUsvREQvTzdlTXFKT3M2NFZWazFhMEQ5TzQ3amMzMnRKZnQ0bm9mM0FkV3Zi?=
 =?utf-8?B?ZTBNSEZ4S3JQMkRrWk9GSFgxRGUvNGFETHRSM2ZhUWRIOVRBOUoyU2JsSXl4?=
 =?utf-8?B?MlhFMjltNDlFYVNtQXhxQWc1a1lmT2ZTUlhqOWdRZ2VYMXFJenBHVFM1R25q?=
 =?utf-8?B?YXR2SEpLQU8xdTEzQngrbDRKNDVuc21FMmRhUW1RU1lwQ2cyUlJocWtDVmRM?=
 =?utf-8?B?bjcxUTZGajFZS0QvN1lXekUwU0RBcmRFaGlNQXUxMXR5SlZuVlFOL2Q1ajlo?=
 =?utf-8?B?SzlxM21EaFc3L3R1V0tvN0VSMzlGTHBPcG9QNVVsVHBlcDQ3YlVuN3BtT1hM?=
 =?utf-8?B?Um14eHRJY0tyWENmS1ZsY0JjVTU3c0RNZXZWdEJzVzN5d29TVkhRaW85K2x6?=
 =?utf-8?B?eE0zeFY1anlVc2IwSW93U0tmV3lyUmlwU3A4ZWs3dS9yMFAzNUYyUlplODRY?=
 =?utf-8?B?TXU1ZkxIby9RMFhkQ2loekwzWGRXb1h5QUtEZVJZMHBwM3pDdlZGNmZCYnBG?=
 =?utf-8?B?bGRlZDZ3MkZ6akY5VXlTY1BvVzJwaXFUcmNVRE5Ra0VGM0JmOENQWk05RHRq?=
 =?utf-8?B?Q3Z5VzQ2Y2ZqT1lTcEpBYWNNcnd3ZStEcFN3UUl2SGxNWjZnV0MzNE1FR0Z2?=
 =?utf-8?B?aGo4dDEzeHNuMnF5QUE1SG95K0IyVmRrZEFLeGE3UGdhMjNTUVNYUTBkWGJi?=
 =?utf-8?B?enNsZlVCL0N2SlVKL1VOR29nTTVUQzVXM2dOalNzOFBGZ0VTWFNUSlJHeVdD?=
 =?utf-8?B?UmNndGtiRnhiQ0x4VlkveW5vVnpZMVNBeTJIVXlEWnh0Y2dqS2w3WjRoRWJm?=
 =?utf-8?Q?/YfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWNZOFQ2WEU4VDFxTVZMN2xudnJJQkw2Y1hmYm5WQmQyditvOFRNdThjdWdE?=
 =?utf-8?B?d0JjL0xCVWZ2ejFWUDE2SkF4dTdDRGkxTmJTNEswNVZXUExPMm50czUrZ0g5?=
 =?utf-8?B?YkVaSXRjYXFQUEdNSjFOZ0NhcFZVZ2locFg5UzZ3NlFWSGl0V3RiOFhBU1VN?=
 =?utf-8?B?YVVJM3FCTUQ0cnF0dWJDbXhjL0drU0VjZWYxcWZXbDN5NjlvaXpwcWlSYXpE?=
 =?utf-8?B?ZWM1bWRsM05NWDFIbWRzNUdCeDBFUWpXZGpRU2tCQ3IzU2dBc3R0V290U0xk?=
 =?utf-8?B?YTA4Rm0yUnJ1MXdDK0dTVnR5SnN0RkMyL0RzdmFYaFVHbmdaWXRFM1hTVEp6?=
 =?utf-8?B?c0tVVEJPaHRVUDNnTjQ4NXBhcVZCRVA0c1p3QjIxTkVLbG5yWHBjUlJIMFNM?=
 =?utf-8?B?UXRMbk9CTk1RVkQ2UTFOUXAwSmpJZXVsUXZMeHliT0hTbm1DbFlnUjk1VWh1?=
 =?utf-8?B?dVRKQUlPSjkzTzdxL2VqTHp5ajEraGVOd2l4ZkVBZ3MzUndHd0xFc3pIalhS?=
 =?utf-8?B?cEJYOXpXL01OOVBNWk02R2ZaSm9yc3RTUlZDZmtuSC9WWm4wb2NDdFlzcURa?=
 =?utf-8?B?cW9lMjYydjFEODQ4bzVoeHJTb1RhTXJ5Q3lDdnlkNWJIaUNKYmRBTGJMZytX?=
 =?utf-8?B?T01KNDU4cWhnR3BRVlJTSUZsbVM1bDVGRnVlU0pFWlNFU1hDNFdVL3VaMVZs?=
 =?utf-8?B?UklrSkJmV2ZmVHkrNy84VTEvWk1zUEQ1c3RJaFJSa0VGUHNDRTVEdkN3Z3Zx?=
 =?utf-8?B?Z0VML1FTcHVMdHBteUpZYkpYclFHV0VXU3pFcDVEWFQzWVFFWDhwcnVEVWVK?=
 =?utf-8?B?K29iVUZKcjFMSVFNTWlIMERWS2RBcE9IYjdFZnluUlpQVi82YVQvYk1xVE1W?=
 =?utf-8?B?VmdENHlleDdHb1RuZXlmNDNmYjNMV0RSSEk5cXJZNVI4ZHZ1MUQ4YmFSVFpk?=
 =?utf-8?B?bUJUR1ZUbG0xUEs5VGhHN2xIVWY1NDZhZi8rdlpIblkwNmptQW1RaDBwYjY2?=
 =?utf-8?B?Q2ZiTnc0aWhaMllROHBCV0swL0tIL1F3M0ltUHEwM0ZNNk5YclRXdHZ2K05G?=
 =?utf-8?B?U3plR045YTZpZFJ0WlptSmJFdnN4eDNBWmVBd294VWJhZWRJbUFlYWN0SnI3?=
 =?utf-8?B?R3NWeHRTaWJkUDJ3WEl1clVzcjZhV2pCRmM5WDZLdEFXdEVsM2xHWmR4U0Zi?=
 =?utf-8?B?aVh6QzA2Slg0RS9sL1JWZzF5WFJIQTNMTHNIMUpHQm9hb1lQM2xnV0UwY2JI?=
 =?utf-8?B?QXMvczV2cFg5UzJzc09LdXJwZXBaY3krVGFzTzFDRVh5emF6TGlZZExlYnpJ?=
 =?utf-8?B?ckpTSHNPbFA4VGFPNGkxL3lnQjE3RVYyVjBrNGMzR0VvZFJON3YyTWFDNi9o?=
 =?utf-8?B?UWtwWUZjMEF4eXRYMFR3VmJhOU9maEJBU3A3dnQ3cWxEcUxONEhmeGxxeDdE?=
 =?utf-8?B?SmlxR08xM2JLZFJRUmR4Y3ZJZzF2TkY2RzZPOUt3eHA3TGQyaTUzT0ZNSmlZ?=
 =?utf-8?B?VDQvOGpTT3RyenZieEw5a09sZXhwV0xEUmpwT1dQeEpRY3FOcENFV2kycURl?=
 =?utf-8?B?QnVIN0ZJMkp4V1pzSmUyMXJhdFJ0cXJZZTdlTGJieDhOekppYWN1cnBWdGNM?=
 =?utf-8?B?a0J4QnZTM2QxN1JMUzJCbUtFMElYYXJsL01SYitYWE1MWm91d2pPRVprRjBK?=
 =?utf-8?B?SWc0Nm94SCsvNCtjUzh5UURzaWl1N0VmN1gvWit2dXExWVFWdWlXZlNQZEh6?=
 =?utf-8?B?NmFTVCsrdkE1Vm0wYjJuRlUrY1dsOS9yUDNwUUpRWTVtV0VpWjlxM3JHNHpm?=
 =?utf-8?B?d3BSaEZXOWp0a1F3VE9MTG9aSFVsNlduRjVieUtFYkdCV3hrTXdGVTNEL0Ey?=
 =?utf-8?B?d080VVplWVFWK1J3SWI4UXlxc0ZseUdDZUJzVnVHWFNZUnkvU2NnYWd6cnE4?=
 =?utf-8?B?bThVekd6NGNzbmpxYXZXMGFmc3U3UEZwdXkrT01jaGs0a3p0TmdhQnF5WWZC?=
 =?utf-8?B?WUZqNjB1VjdTSm1mUXluMmtaSXBGSWRRUk8wMnphZjgwUGl4RXphUjVSaTlk?=
 =?utf-8?B?S2FkR0ptRVVyRnlwUDM0d3pad0tZdkgrWEtIQnB6anZPZEFCUjRsUEZLUXJF?=
 =?utf-8?B?V2pXTzAzVFdkTTl4dHhHeHltVU9RejNMQ1kvbHE4d2VKMzdSMFArQWNmNDhx?=
 =?utf-8?B?dTNEOTdJVEd1YjBCaVNhQUpibkdlYXRmbEhTalZnZnZaWEx5UDJNbVErSERC?=
 =?utf-8?B?cm05STBhS3VGc0lZQzQwcHE4RFlsVlY3OE9KLzBZb1BPcEVPWmc3aEFHTnBB?=
 =?utf-8?B?d0Z1S24wbFB1T0p3TW5zQ05BbkJkZ2ljSTh5YkRCc2pqaDlTdlplZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2616ea1-4ff6-4532-a50a-08de5bc04b7e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 03:17:39.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfael5wXsudULduifuJbPC56J3MtsYPNVnduURQy6o72jhKkmSN/yikpqx5KeEBq6JL4Hf4a55yOw/AF5t6tMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75378-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: 584627F917
X-Rspamd-Action: no action

Hi Alejandro,

On 1/23/2026 3:59 AM, Alejandro Lucero Palau wrote:
> 
> On 1/22/26 04:55, Smita Koralahalli wrote:
>> The current probe time ownership check for Soft Reserved memory based
>> solely on CXL window intersection is insufficient. dax_hmem probing is 
>> not
>> always guaranteed to run after CXL enumeration and region assembly, which
>> can lead to incorrect ownership decisions before the CXL stack has
>> finished publishing windows and assembling committed regions.
>>
>> Introduce deferred ownership handling for Soft Reserved ranges that
>> intersect CXL windows at probe time by scheduling deferred work from
>> dax_hmem and waiting for the CXL stack to complete enumeration and region
>> assembly before deciding ownership.
>>
>> Evaluate ownership of Soft Reserved ranges based on CXL region
>> containment.
>>
>>     - If all Soft Reserved ranges are fully contained within committed 
>> CXL
>>       regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>>       dax_cxl to bind.
>>
>>     - If any Soft Reserved range is not fully claimed by committed CXL
>>       region, tear down all CXL regions and REGISTER the Soft Reserved
>>       ranges with dax_hmem instead.
> 
> 
> I was not sure if I was understanding this properly, but after looking 
> at the code I think I do ... but then I do not understand the reason 
> behind. If I'm right, there could be two devices and therefore different 
> soft reserved ranges, with one getting an automatic cxl region for all 
> the range and the other without that, and the outcome would be the first 
> one getting its region removed and added to hmem. Maybe I'm missing 
> something obvious but, why? If there is a good reason, I think it should 
> be documented in the commit and somewhere else.

Yeah, if I understood Dan correctly, that's exactly the intended behavior.

I'm trying to restate the "why" behind this based on Dan's earlier 
guidance. Please correct me if I'm misrepresenting it Dan.

The policy is meant to be coarse: If all SR ranges that intersect CXL 
windows are fully contained by committed CXL regions, then we have high 
confidence that the platform descriptions line up and CXL owns the memory.

If any SR range that intersects a CXL window is not fully covered by 
committed regions then we treat that as unexpected platform shenanigans. 
In that situation the intent is to give up on CXL entirely for those SR 
ranges because partial ownership becomes ambiguous.

This is why the fallback is global and not per range. The goal is to
leave no room for mixed some SR to CXL, some SR to HMEM configurations. 
Any mismatch should push the platform issue back to the vendor to fix 
the description (ideally preserving the simplifying assumption of a 1:1 
correlation between CXL Regions and SR).

Thanks for pointing this out. I will update the why in the next revision.

> 
> 
> I have also problems understanding the concurrency when handling the 
> global dax_cxl_mode variable. It is modified inside process_defer_work() 
> which I think can have different instances for different devices 
> executed concurrently in different cores/workers (the system_wq used is 
> not ordered). If I'm right race conditions are likely.

Yeah, this is something I spent sometime thinking on. My rationale 
behind not having it and where I'm still unsure:

My assumption was that after wait_for_device_probe(), CXL topology 
discovery and region commit are complete and stable. And each deferred 
worker should observe the same CXL state and therefore compute the same 
final policy (either DROP or REGISTER).

Also, I was assuming that even if multiple process_defer_work() 
instances run, the operations they perform are effectively safe to 
repeat.. though I'm not sure on this.

cxl_region_teardown_all(): this ultimately triggers the 
devm_release_action(... unregister_region ...) path. My expectation was 
that these devm actions are single shot per device lifecycle, so 
repeated teardown attempts should become noops. And 
cxl_region_teardown_all() ultimately leads to cxl_decoder_detach(), 
which takes "cxl_rwsem.region". That should serialize decoder detach and 
region teardown.

bus_rescan_devices(&cxl_bus_type): I assumed repeated rescans during 
boot are fine as the rescan path will simply rediscover already present 
devices..

walk_hmem_resources(.., hmem_register_device): in the DROP case,I 
thought running the walk multiple times is safe because devm managed 
platform devices and memregion allocations should prevent duplicate 
lifetime issues.

So, even if multiple process_defer_work() instances execute 
concurrently, the CXL operations involved in containment evaluation 
(cxl_region_contains_soft_reserve()) and teardown are already guarded.

But I'm still trying to understand if bus_rescan_devices(&cxl_bus_type) 
is not safe when invoked concurrently?

Or is the primary issue that dax_cxl_mode is a global updated from one 
context and read from others, and should be synchronized even if the 
computed final value will always be the same?

Happy to correct if my understanding is incorrect.

Thanks
Smita

> 
> 
>>
>> While ownership resolution is pending, gate dax_cxl probing to avoid
>> binding prematurely.
>>
>> This enforces a strict ownership. Either CXL fully claims the Soft
>> Reserved ranges or it relinquishes it entirely.
>>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 25 ++++++++++++
>>   drivers/cxl/cxl.h         |  2 +
>>   drivers/dax/cxl.c         |  9 +++++
>>   drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 115 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 9827a6dd3187..6c22a2d4abbb 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void 
>> *data, u64 offset)
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>                cxl_region_debugfs_poison_clear, "%llx\n");
>> +static int cxl_region_teardown_cb(struct device *dev, void *data)
>> +{
>> +    struct cxl_root_decoder *cxlrd;
>> +    struct cxl_region *cxlr;
>> +    struct cxl_port *port;
>> +
>> +    if (!is_cxl_region(dev))
>> +        return 0;
>> +
>> +    cxlr = to_cxl_region(dev);
>> +
>> +    cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +    port = cxlrd_to_port(cxlrd);
>> +
>> +    devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +
>> +    return 0;
>> +}
>> +
>> +void cxl_region_teardown_all(void)
>> +{
>> +    bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
>> +}
>> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
>> +
>>   static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>>   {
>>       struct resource *res = data;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index b0ff6b65ea0b..1864d35d5f69 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder 
>> *cxled);
>>   struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>>   u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>>   bool cxl_region_contains_soft_reserve(const struct resource *res);
>> +void cxl_region_teardown_all(void);
>>   #else
>>   static inline bool is_cxl_pmem_region(struct device *dev)
>>   {
>> @@ -933,6 +934,7 @@ static inline bool 
>> cxl_region_contains_soft_reserve(const struct resource *res)
>>   {
>>       return false;
>>   }
>> +static inline void cxl_region_teardown_all(void) { }
>>   #endif
>>   void cxl_endpoint_parse_cdat(struct cxl_port *port);
>> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
>> index 13cd94d32ff7..b7e90d6dd888 100644
>> --- a/drivers/dax/cxl.c
>> +++ b/drivers/dax/cxl.c
>> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>>       struct dax_region *dax_region;
>>       struct dev_dax_data data;
>> +    switch (dax_cxl_mode) {
>> +    case DAX_CXL_MODE_DEFER:
>> +        return -EPROBE_DEFER;
>> +    case DAX_CXL_MODE_REGISTER:
>> +        return -ENODEV;
>> +    case DAX_CXL_MODE_DROP:
>> +        break;
>> +    }
>> +
>>       if (nid == NUMA_NO_NODE)
>>           nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index 1e3424358490..bcb57d8678d7 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/memregion.h>
>>   #include <linux/module.h>
>>   #include <linux/dax.h>
>> +#include "../../cxl/cxl.h"
>>   #include "../bus.h"
>>   static bool region_idle;
>> @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
>>       platform_device_unregister(pdev);
>>   }
>> +struct dax_defer_work {
>> +    struct platform_device *pdev;
>> +    struct work_struct work;
>> +};
>> +
>>   static int hmem_register_device(struct device *host, int target_nid,
>>                   const struct resource *res)
>>   {
>> +    struct dax_defer_work *work = dev_get_drvdata(host);
>>       struct platform_device *pdev;
>>       struct memregion_info info;
>>       long id;
>> @@ -69,8 +76,18 @@ static int hmem_register_device(struct device 
>> *host, int target_nid,
>>       if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>>           region_intersects(res->start, resource_size(res), 
>> IORESOURCE_MEM,
>>                     IORES_DESC_CXL) != REGION_DISJOINT) {
>> -        dev_dbg(host, "deferring range to CXL: %pr\n", res);
>> -        return 0;
>> +        switch (dax_cxl_mode) {
>> +        case DAX_CXL_MODE_DEFER:
>> +            dev_dbg(host, "deferring range to CXL: %pr\n", res);
>> +            schedule_work(&work->work);
>> +            return 0;
>> +        case DAX_CXL_MODE_REGISTER:
>> +            dev_dbg(host, "registering CXL range: %pr\n", res);
>> +            break;
>> +        case DAX_CXL_MODE_DROP:
>> +            dev_dbg(host, "dropping CXL range: %pr\n", res);
>> +            return 0;
>> +        }
>>       }
>>       rc = region_intersects_soft_reserve(res->start, 
>> resource_size(res));
>> @@ -123,8 +140,67 @@ static int hmem_register_device(struct device 
>> *host, int target_nid,
>>       return rc;
>>   }
>> +static int cxl_contains_soft_reserve(struct device *host, int 
>> target_nid,
>> +                     const struct resource *res)
>> +{
>> +    if (region_intersects(res->start, resource_size(res), 
>> IORESOURCE_MEM,
>> +                  IORES_DESC_CXL) != REGION_DISJOINT) {
>> +        if (!cxl_region_contains_soft_reserve(res))
>> +            return 1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void process_defer_work(struct work_struct *_work)
>> +{
>> +    struct dax_defer_work *work = container_of(_work, typeof(*work), 
>> work);
>> +    struct platform_device *pdev = work->pdev;
>> +    int rc;
>> +
>> +    /* relies on cxl_acpi and cxl_pci having had a chance to load */
>> +    wait_for_device_probe();
>> +
>> +    rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
>> +
>> +    if (!rc) {
>> +        dax_cxl_mode = DAX_CXL_MODE_DROP;
>> +        rc = bus_rescan_devices(&cxl_bus_type);
>> +        if (rc)
>> +            dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
>> +    } else {
>> +        dax_cxl_mode = DAX_CXL_MODE_REGISTER;
>> +        cxl_region_teardown_all();
>> +    }
>> +
>> +    walk_hmem_resources(&pdev->dev, hmem_register_device);
>> +}
>> +
>> +static void kill_defer_work(void *_work)
>> +{
>> +    struct dax_defer_work *work = container_of(_work, typeof(*work), 
>> work);
>> +
>> +    cancel_work_sync(&work->work);
>> +    kfree(work);
>> +}
>> +
>>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>>   {
>> +    struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
>> +    int rc;
>> +
>> +    if (!work)
>> +        return -ENOMEM;
>> +
>> +    work->pdev = pdev;
>> +    INIT_WORK(&work->work, process_defer_work);
>> +
>> +    rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
>> +    if (rc)
>> +        return rc;
>> +
>> +    platform_set_drvdata(pdev, work);
>> +
>>       return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>   }
>> @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>>   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' 
>> memory");
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_AUTHOR("Intel Corporation");
>> +MODULE_IMPORT_NS("CXL");


