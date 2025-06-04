Return-Path: <linux-fsdevel+bounces-50673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A60ACE562
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 21:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A35D3A4CCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE14212FB3;
	Wed,  4 Jun 2025 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AOB7THtn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B23111BF;
	Wed,  4 Jun 2025 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066992; cv=fail; b=a1yLoYoclnID9XtgMmsF/xkSbRkcQVtGMNm06Hcbo2VRmLU2dvM0YodmPL/K5XjL2jvm6SZZJg2AfxHTH55CCDnzSverO7CuPi/PE4YHdBAmExBikJ+NV5b9LLQsbcSiTl+RMpycvzc6pOCPCQYLT61DcQnBJiTp0LZnc/xnu3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066992; c=relaxed/simple;
	bh=UqKNzEhwQUj6YWf+BeW2Jp/7N6y3IjkNrVKFd9mwjok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BX78EKKV/O2vnJHq9nQAjxO88heIq/OwqPAZgPclsdDLpJRv85VlfJpOQMrpjYjxDnPXYGgROe4KIxqQcFD/ex5KpfLrQU2T6rxizJowLcf6wtZn/UsmNrFJw/XM/cJRLfp5pu1Rpni+omZOU2GL1uRvp56uiaeIMC2fejL4zy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AOB7THtn; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqwj4g+DIohZv/K+E1QPsQiRLqqKm1YKD7AmXXWRQLq2tXnp3hLuvwX2FsKdnSPmTBAKVU/tIC87mHRD+xdRQ5X/0Mrm+4fv9OHgJnsFh4NzTtPpZW+jCZ6AGt7pbEZouEsMUNAyvWGKMj2LE3sObGPKl0xwsp+h3yvTII/jZ3VZw5YP5TWyLErVQZvcrpZj8oDWdM3lmcn1t954adlBTGYZwWP2IWe0Ayj4jxLcNEICf1JtU7/JXLzaImUP/n9b22tKxM7F1GvdIvwzDLVG+ohdtBT6v49q2u9gfVswPUuIwJ+i0gQGl/Uj6eCJEsAulIFEGfoPuVGuJJvTejh2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqrRYagQO0A/3kjoscxlGaj7ErrJxlVi0C132e6VRMc=;
 b=ym/hnWMBxMnpELR/A+JgKWlFgGomvv4uCgaxO5/AE9L1yXXjbOlMt5uUO93IiM16KFkEDb25qC5EACPcaPYcmSF+X+3uxD/ZNC2nzNpn2CGUVngeGRDhpE7KLY3r5vU7EIYDiNqSI+8LqZuuKrQFZSPDG0hmieBRyWv0mrMvHOaxL8QyQz4NC3gow3/KtEe5x+VphT6ARW/5R1XW0v8nvZaeGboV2LLfTA2ib4K/pbPxcRwAtSbDYEJ6ShVaZWIaRkRYrsKus0On62QUb7VocoxHDr8hanNCYIzeGt/CQDFHuTG2+9s4TbgeReCxlGqMBUxELsuimbvvJkNdXT7rqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqrRYagQO0A/3kjoscxlGaj7ErrJxlVi0C132e6VRMc=;
 b=AOB7THtnKLkHR4jDV7pcUBxXDWS7QdLcjiYWBzQdjydH6b8Hoa2xUBM9ErwiU6h2eoTz77XMjs9SZF3DLJn8Vg0LquUUGUVbFpodoomLeCa6bFJDzJDvhOR78swMD5MP8WTXjmx9/nWUREiUrH+YWMwr/lpX3pgHrAqf7C125zI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:56:26 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%7]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 19:56:26 +0000
Message-ID: <e13cace9-1ab3-4c22-88f7-0d020423c430@amd.com>
Date: Wed, 4 Jun 2025 14:56:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] cxl/region: Avoid null pointer dereference in
 is_cxl_region()
To: Dave Jiang <dave.jiang@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
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
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>, Terry Bowman <terry.bowman@amd.com>,
 Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-2-Smita.KoralahalliChannabasappa@amd.com>
 <3464d8cb-e53c-4e6b-b810-49e51c98e902@intel.com>
From: Nathan Fontenot <nathan.fontenot@amd.com>
Content-Language: en-US
Organization: AMD
In-Reply-To: <3464d8cb-e53c-4e6b-b810-49e51c98e902@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:806:126::31) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4c70f9-0605-4f4b-e937-08dda3a1e3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUtKcTc1N3BEaHAyeS9Ic2JGOWxaZGpxQ3c4REorQXdwMTNLR1Zoc3NsUGRw?=
 =?utf-8?B?TWk5OFQxMU1RQUU2S3VvM3BLN2k1SU1yVmZRSlJWd3hUVExPbUtORXRzSGJs?=
 =?utf-8?B?NnNSdW04b3psMmkrVWZqbWFYam8rdnJueFBqNnF1OW44SDBldjI2SGgxWGdF?=
 =?utf-8?B?eXNZZUdhdGhPSjBJS0hkKzB4bFduRlE3NFM2NFZLTXBNbHdkMnc1bFo0NEVK?=
 =?utf-8?B?MmRPYUdGT2FTNlp5K250REtMQW1aMjJtUzJzSGxLM2Y4Zk9NSERibkQ1K0kv?=
 =?utf-8?B?RWEzbytSLzhUQjlGTWw3UHhzREVTYXJ5KzRmWFFrVEorTk8zaDVYTndoOUQ1?=
 =?utf-8?B?VDBGcmJDYlM3TXFJcnpKYlBnc1RsTWpaQ1c0bTBIRTVyNURqVGRCY2NpcTNi?=
 =?utf-8?B?VUtxTFhCTmFyV3BLYVNybnZoVzNlaDgvdDRVL1RmdkQ1ZUtNRmtUN3k1eE43?=
 =?utf-8?B?MGROZU5FNGxDcG5WQTVJZDNZemp5SE5OS3VaYjZXRmFpVWgxTUROdlhzMXNH?=
 =?utf-8?B?anBSOGh5UWx4QUVsdHp0LzM0K0QzZ1NxNXRiUlloQy9BRk5sTjJIMllQaFdQ?=
 =?utf-8?B?UVFhRUVhTE9lbUJzS3VDaUdJenBZMjZZZGx2Q3pVR05iQUdWUVlrQXV6NkxP?=
 =?utf-8?B?d1ZwdDMzR2R2NmN1NTFzNjhsaWVsZWJSR0ZHNWV3ZjBtQjVDNjJ6QlhZU1dN?=
 =?utf-8?B?UDVvMkNjcjJwcU0yNXJVNUxCY3JOWEJ0aDBrblZwdDFEMDFUOGh5Z2M1aEsv?=
 =?utf-8?B?alY4cUgvQUlNWVRaUGpleWNuQW5GRWswRHlhTWhCNmdxY2s5N2tZRVV5Qldq?=
 =?utf-8?B?bXoyb1Qrc3VEb1hlL0ZlczdKaHp1YVpXaUN1cHUyNERhR2pFVjB6Sng0VEFG?=
 =?utf-8?B?U3lHbG8rV25CRVdIdGo1ZWNOVVVrb2ZBZmdIWmlFQmJjTDEyNEhuaXhWcDA5?=
 =?utf-8?B?T1Rtd296SlhNSVhEQWhuOVlob1ZvRU81T3IwdDdCZ0Nzc0grUTlGeTVDVFZL?=
 =?utf-8?B?b0pNSkUvUmxNVXpEYVZVVVp5ODNrNWtKNHhCSWV5eDBwSEE1a0g5T053TlVs?=
 =?utf-8?B?RmN3Wks2UlYzaldGakdyZy92aTNXRHZabEw5WW9lby9Sb0V4R3RHcjZXbGpK?=
 =?utf-8?B?NHRYSjdTWDJnSTc5T1JpQkVrZitSU0JVWWJnUyttbndnemkzT2RNTXpPcE1G?=
 =?utf-8?B?bEU3dm5jblJ5OGJnbmpzQjZxRmFwN1dIQ2E2aTdLMmVsZU9LcEd4eGYwN0V3?=
 =?utf-8?B?UE9Ebm1mcEZGUTFvM3BqWlYvUEY2MjRUc0FEYUVrekowMmEwekE4ODlqcTVJ?=
 =?utf-8?B?N0NqWnNKZVQ2MGVsSUo3cTh6ZGFUNTRzQlZRd25maTJBcXpRR3I0enlpbk5o?=
 =?utf-8?B?Z25KSEgrU0ZMbCsyeFF0SGlLLzNQM2ZCWkx3bkNuSXJSeWRCYWhCa1E4VjZ6?=
 =?utf-8?B?WjR5VDRvaDQ1Z2cvY2JqWEhjak92OXFrbG1IWi93b3pMZEc1TWlZSnFkMVNQ?=
 =?utf-8?B?SzkzeVU1elFDOCs2YVhoM2pDRmxOTStDcG5CYlBMUkN6bGNvTFZMVkhKTExV?=
 =?utf-8?B?KzJNbGNOSjl1Zy9vbTVNcVVCci8xQkVEMUl5YlEvdEV0b1g2eTUrOGdPcVVR?=
 =?utf-8?B?QmRlN2tTVEhMUERiNXB5WWFsbzhuTGlPWXBDdUxxNnVDT2xNaDBOdHA2VUQ3?=
 =?utf-8?B?RTZ3NHRrcTVPTnZpYkNON0pzZEVrVWhtcGdGQ09FNEF4RGYwdHkrMFNiU0ds?=
 =?utf-8?B?ZHpkYTh3MlJVZXZwVUVKUkhrU0lnM3JLS081c3Q2RjcrVlZpajFhb21qN3ly?=
 =?utf-8?B?SEtGeWRSUUdZOXliTXFLSitidEVQWGhqUDU5M0tOSFpaK3d3WnlZM3FjYVlB?=
 =?utf-8?B?SkNpL05uN3B2T25QSHlaeFVSeVErZzhIeEE1QjlEQ1dHZ1NNbXViNXowMkhi?=
 =?utf-8?Q?CFekoWNhB/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uyt4UFRaZ0tPbnZzUGR3NVQvVHZBcXFKQVFadVZVRUorR2JsQTlzSmxlQkpQ?=
 =?utf-8?B?bXUzTUwzcHNsTzNaOUtGWkg4NUpUMUs5QnlrWDVsZEw2MDc4aXBFcDFuUnE3?=
 =?utf-8?B?eHp1OHA5Y2xsaWJ4bmNUZHhscEFYekxkVno2OHhYNXdERFg2TDNRaTBFVzJu?=
 =?utf-8?B?dTdrQ2NVaFc5ZENZWnROQnBMSHFiWitSOFVEdHNNYlhUN0FWY0d2R1FKR25l?=
 =?utf-8?B?cjJQaTZrbnI2ZzBZdmdXWEhmM2tiRTUzU3pDWTJFVXBScGc0Z0dZUS9BKzIx?=
 =?utf-8?B?cjJQZzlDWWdBSjRxYnRnY1NueGVaSHJhblJRUiticmtNN1VKSXRFdUEwbGJa?=
 =?utf-8?B?dEVzSmdjbStMWGFSdXhoVE96Z3FHR1Z4U2gxL0RkTkdMcVZHUHdjY2Q0UWlo?=
 =?utf-8?B?WUhad090ZFlFOS9ITjNqSFBTOHh4QXJJTkdTeStzelBrSnNMR0wxcm9RbmJu?=
 =?utf-8?B?M0JENG54U2xBSzVIQ2NzL2xvN0NRMGYxMjZDWmF3bGUzN0pGeFlzcHp6T1FC?=
 =?utf-8?B?M2JQMEgwTDBNZlgxQjd3U041UWJaekhxSHBKcGhGN212UGUreUhVc2NiMWs1?=
 =?utf-8?B?Z3pGTUNMNTRlMzU4VFdZWTFMTE5VbkU4TTRpODNlQTNWQlUzYUxGQ1QrRDBF?=
 =?utf-8?B?VFU4Zjd4bjFGSG5vcndnTXo1KzJya2lsS25vdWVjS3lWVm5xYjh6Ylltc0NL?=
 =?utf-8?B?MnhuekVoVHBpZCs5QmE0Q1dpQVY0d2s4L1NoNVJVWndNN1BQcW4reGVnRHQ4?=
 =?utf-8?B?eVdKc2JWcVlodUR3QnRBclNmclZaeFN0dFNYcmtqYXZsOVBKQlpETktqSThT?=
 =?utf-8?B?eEI1aW9CdlBBYlY5ekRLcHhXek12b0Zqa2lUelgzUkZiNngwd3JjSVdqZHZC?=
 =?utf-8?B?MnpKdG5hTWVpYkVFRUl3TENybUZ4eittbldmVVhlZFQ1OGZBN1o0TFF5VmxV?=
 =?utf-8?B?dzQzdDZjUjR3Ukw3a0duWHd3aWRqOFU1NExtWGE4OXVyL3UrTTVmUU5uci9i?=
 =?utf-8?B?N0VETFZLRnNWUHVWRXVKSUJGWEVLUHoxNDd1M3JvdXEvUk5oMmlqaWpXOWsr?=
 =?utf-8?B?N2JZZUhvZ0JxQm1rK2h1bFpwWFNrVURTZWZ5L1VYRmlYZm1ZdjUxRVFWaFVH?=
 =?utf-8?B?NU1JUWpJMlM2TEQ5RUgweEpsdkNpOUI3TmlWdy9yNkQ1RmJ1R1hkbE1ZY2lB?=
 =?utf-8?B?eXVIM3BTSDZ0VTBUc3NOWGF3alZZR0VPcElBaGorVDBTZ1czQ0NGQWdzenA1?=
 =?utf-8?B?UG1YdUlzc25TWWY1cDBzaGIxc3NTWS96aEY0bFJlcHBWNjFQMytqdHpoVmJW?=
 =?utf-8?B?alQ0YTdWSjg5VGpKekVObHdTcFJ3UHdTdUVEQXlXWngvc2FaRVZmS0RvZkY5?=
 =?utf-8?B?d2IzOWw5c0Y1alNDRGpjc3IrSE5Tam5IQ2w4SkJvY1VGWWVrdDYzTmhNVSs3?=
 =?utf-8?B?UlB0cmJrY0NCRVhLOU5XNHpGYkxYUUZ2UTU1bUNBSTRJMmtqZmgybGVFVGFL?=
 =?utf-8?B?WGVjZGgrVEE0QU9uUitNdWRFa1E1TTJ6VHVKcEwrSTVmcTNaejgxQ2lJdjBr?=
 =?utf-8?B?WDBKUXhQYmt4SE12MGg2ZnVBSWNwOUF6U2c4UUF5MUh0ZnJMQ29VL3VpUXJv?=
 =?utf-8?B?Vm9yRXJXT0hnOElIbDJ5N2tqVTBLTnZFT0x2TVVOTVdMSG1iUTJyZUc5Si9E?=
 =?utf-8?B?YVA4bDQzNForaFA5b3kzeGFHWnVCSW1ldStqZnJPSlJvaElnNW9wU08zTWpH?=
 =?utf-8?B?SlE0Rk42ZmdYODVxK2ZXNy9tV0lnZGFjd2JBZ3M2NlFxN1dIRWx1ODZHa1Fp?=
 =?utf-8?B?d1RQaVNtY3lpSEZlWmNIalYwM2RkeUFTYjVDaFNteGVEQXA5RUcxaXBCNVVj?=
 =?utf-8?B?ZTdLSU8xcDVXZXZqODhDbGZmZzhBbkpJZDdQbmR4UHlvUDdsNldNdmhhNysx?=
 =?utf-8?B?dFQ2SUF2NFdNeE1QcVh4M2o5MWswVVIxalpZTHNHd0VqWGR6ME5pUGYyQk1m?=
 =?utf-8?B?Uytxa2FlNWd0Z3NRUS92MXZQZmNTenRNYUVLTWZNUzk2ZWxvdmNYL3lEeEVS?=
 =?utf-8?B?L25BZFoybzlvdGhJUGtraEZ6UlhrMW5NYS81Lzk5aVJoRG0zTHhCSlkxd2hN?=
 =?utf-8?Q?+4NcLqkMEx10G05YLJ+VS6YgQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4c70f9-0605-4f4b-e937-08dda3a1e3b6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:26.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utmuX9vxORd0XIueRTJMAauKbzMcC0BSU1VSqnk5hboGQBfck2mHKtRW8oU/nsHMn0sMvPxr78P83yLXxO+u/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

On 6/3/2025 6:49 PM, Dave Jiang wrote:
> 
> 
> On 6/3/25 3:19 PM, Smita Koralahalli wrote:
>> Add a NULL check in is_cxl_region() to prevent potential null pointer
>> dereference if a caller passes a NULL device. This change ensures the
>> function safely returns false instead of triggering undefined behavior
>> when dev is NULL.
> 
> Don't think this change is necessary. The code paths should not be hitting any NULL region devices unless it's a programming error.

I originally added this to the patchset during some initial development to handle possible
NULL dev pointers when updating soft reserve resources, see cxl_region_softreserv_update()
in patch 5/7.

In the current form of the that routine it appears we shouldn't execute the while loop
if dev is NULL so this could get from the patch set.

-Nathan 

> 
>>
>> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>  drivers/cxl/core/region.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index c3f4dc244df7..109b8a98c4c7 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2333,7 +2333,7 @@ const struct device_type cxl_region_type = {
>>  
>>  bool is_cxl_region(struct device *dev)
>>  {
>> -	return dev->type == &cxl_region_type;
>> +	return dev && dev->type == &cxl_region_type;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(is_cxl_region, "CXL");
>>  
> 


