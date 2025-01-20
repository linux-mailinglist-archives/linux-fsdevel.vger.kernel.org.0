Return-Path: <linux-fsdevel+bounces-39706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78EFA171BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D063AAFCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52A41EE00A;
	Mon, 20 Jan 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rps18d1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D82219F40B;
	Mon, 20 Jan 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393992; cv=fail; b=mfFzcCw1kpiSbVBQ/7wMnTBqh6XKm5Nx2eJGqKxrUG/iRLvUl2xFrlpretVkJWWKuD+ofnj8yVlzA/hRPUbHR8ElMDjOr4P0FkSOSG/pIQwiuTzKJI9Z+Zqtze1qOnHx5xFlKDZph4qUsKvTQ6HwT5Dgk9IJRSkubPgLOVxP39I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393992; c=relaxed/simple;
	bh=FlKNT7FQG0ZQF0ILFTM5yd2nk3zjeDyI/X8IuoFMMWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FviRSBpbTsgwBOX6E9pjKjMJ9QoyNiNdgrTtLqkxEDHkqQbvnfC/uD0FYw1zrJlQTSFcRPwpltCqxe7xRe9X+10swkoj2CKncrv5zgVgqbbKaVjO7G2aXxSN8pOjhxKtdqcktQLuYERaEaKKxyaxhs8iKg3hUlNlyHCnjYNoF+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rps18d1F; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKQ0pXSXoTCe+Vr8csGgm1RmGNyeD5mclLKpNSgFKma6V3DWHJxOHBeUMcfmEtVgBkcrT6tBUvtU1ngdZEiKfet8FbQITWs9fok+1ocRAB3lYWais9K5HDKPv/k1ei4tst9cXNT3R8L0mJ9fkMMNC1EFnDNMRtrSfWrTCrl6xAV91sUCVpQYmIRbbsIm374h4PLpuaCXzcu1PHGTSwxpLAhzSAHme605ELc0d3hs9dTQmXWtnPYBZL9/WPj14qnI2m6TscfEZlyKMcqtCMgmHe7YWMcEXz/0eHf9IdMNDbIeC1q2r8eI1DdlLN/VYtA8CPgUgWLw4w3E3H/OVVo8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwcfkrC0n5sqiHHrhl+KKYLHlC8ZORKoyx2jrAGxzqQ=;
 b=iIhT8/MEHVKWeFCGv2WGxJ3jCmCJ67Rgv3mJePa74PjTaHylyNhVCk36cAsy6dcXzwi8tX9PgtusfFLUFFu69L28ssWdnxXzI+EHfyD9Ee4IhyssUHPv5sh+3ZZRFE5dJITr1jLtvp0iAoU54gR8v+kkrAc4YE7Q00shU90XCYPOIt5fJawVx6fbpXqh4EFx/Ai+IBMEzgLYD73q4Sh237C0q9N3UsDddd9Sc+8QF/bdr9Ch4nNARwCPCb7UrDBWAivv/lwZhT6Yl1cj3Lglrm2WF/Q6JK+Wtiu8+WI6qHzGRNvpllyl+2LOgwXl7qWdKfQ9qXJttxmek6bHZiFpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwcfkrC0n5sqiHHrhl+KKYLHlC8ZORKoyx2jrAGxzqQ=;
 b=Rps18d1FJmAj3lSQmVAjDR3UDv0VjPe0YGZ0rODhyl1Wb9wow+W6aN6QmPGbXk6NPePRD7ixgfKdccn2BVklj+77DMx2dGkpCePBYS+CBCz4evEch95Jrw4y78aDwvRwMrnNFpDyfdu/3Ps43nT8stvlsZysPJ8QPj3X3nsypkYAf9DhqI71LQw/nGiqrANOEgct+RBd5DIFG1y1iPcIX8lcJPpxg7KBfOB8I6K3tOOd9yPQQV2nCDv7kTnhfaJbk1XW9Hy+POt2YxAa5lYHY2jHi5KUNuVBBsXjzMzJO1N9rixyOfzhaL7sKN1gqLz9tbj98tw+SJRHdCFRLxNllQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:26:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 17:26:27 +0000
Date: Mon, 20 Jan 2025 13:26:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, tony.luck@intel.com,
	wangkefeng.wang@huawei.com, willy@infradead.org,
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de,
	rientjes@google.com, duenwen@google.com, jthoughton@google.com,
	ankita@nvidia.com, peterx@redhat.com, sidhartha.kumar@oracle.com,
	david@redhat.com, dave.hansen@linux.intel.com,
	muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
Message-ID: <20250120172626.GO5556@nvidia.com>
References: <20250118231549.1652825-1-jiaqiyan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250118231549.1652825-1-jiaqiyan@google.com>
X-ClientProxiedBy: BN9PR03CA0702.namprd03.prod.outlook.com
 (2603:10b6:408:ef::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f604b25-dd73-405b-7a75-08dd39779213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3hhU3RZaXpnSGV0SDZkb1ZDVm82aHoyVUcwNnhxNWpHSlhEWGZoaS8xL1ky?=
 =?utf-8?B?VGZkLzlrWk4zQTFEVjFyekpmNWcvbU1pckVZNC8rWGJNM3NGR3Q0b0tIOEpV?=
 =?utf-8?B?OWpzYW5vOVBQaDBBZS9GakRJOEtaNFh1NjQvNHpSd2dJcURvVmdwc2VUVDRv?=
 =?utf-8?B?VU5HcEQ0OXZLRytVV0JTQkhlb3M0R29qVVp6Zll5M2V4aU9ES2MxTXdRenVI?=
 =?utf-8?B?amx3VlhQVWhONW5wMG9MZFE4RmR4Vk5jUkNuaDl6SnlIUmlyZzJHMXpOOFVK?=
 =?utf-8?B?TUxGZVJRSnhRb1IrTEJKeG9NdFFmZ250S201MGlxNnFGY1Z2dWNZZHdBemVo?=
 =?utf-8?B?NU1IWG1ZN3lna2dlYzlvUk5QZ0NoUDBGcWxySm9sNkNaNkU3THR6bEdER3pw?=
 =?utf-8?B?OWRwclE5L2xtSHlLT1F4dkJzYUtpR2dXUnJQdGhMMkZETHBYTHJDNThGcFVF?=
 =?utf-8?B?SDBXN1NEMlF2azREUEIweEZOR1hsN3dMRkdxcUVjM1o0ZmMrSVNETytjMkxa?=
 =?utf-8?B?SXpaUUVObHdacFVxK24xVTdTSFFHKzlqbjJlc0czdU11d0dVYktJVWxNeS8x?=
 =?utf-8?B?QTBKcXhHTkpLRlp4cjIzOWdmNlMvSEI3OGtYQUtqakNkTSs1N0dwWDJoK0tx?=
 =?utf-8?B?THRlaDRhckpNMVByZ1ZXWSs4cUhmR01Tb2FCZzNzek9ZVDJGZmpoR09PUm9L?=
 =?utf-8?B?OUFYc1pvUGtZaktjOGwzWHRIdzlIUEUwYVNCb0NyMEJDTHVwYmVpd21HMlF2?=
 =?utf-8?B?NFV2aXM0eEQ4TUh4MVNGTTZMN3RMYjhGUkdVa24vZ2pvUm5teTEwT29XSy8v?=
 =?utf-8?B?OStObkNvRkg0QVhiQlhJa2NvdlRjcVlsWUhWRlpObWhSKzVnWXEzVEs4VGo2?=
 =?utf-8?B?MG9zZWc2bWxialBjN3hpOWFRb1VMaWpCWm9qSXNiY3VuWDVzMEJYSGxLZHBF?=
 =?utf-8?B?RVpnejNzYUlOK2ZhaFQ2L2VTQklSMzR6d0hqQTlTREp4Z0Z3RFhUSFRTL0dH?=
 =?utf-8?B?bWNybUpkT2ZDRndkNUswV21mb1V5bE80cjhpYkxpbDh5MlN1QmZYZGdYa0Vo?=
 =?utf-8?B?S0tjR3JPUVNXNlB5R1haS2craVEraWJ4VmZlWVg1bG5hTUxUZ2VnRklheXhh?=
 =?utf-8?B?VzBBcUxackF0bDBtdGRSSS9vckwxY1puVVVBMnNjSjgzaC9PS1h4TmRGQkVv?=
 =?utf-8?B?dllsMm9rZ0ltWms3clhvSm80Z09ySzkwSHVLZjFrdTZiL2hxUTl6TTZBN0Ri?=
 =?utf-8?B?Ti9TdFNUSHlDY240L3VSVmoxeHFscUtLOEh5MnM0eTFpUEFBYVFTV0hjdmFh?=
 =?utf-8?B?TjNhZTZKL3d6UXVjNmF6bk5XZEhsc21FaktLeDNURHdGTEluUG1JSXhhZnpY?=
 =?utf-8?B?QUUxQ3puVmc1MThHSmtnNUNrbzJCaCt0RU4yd3A3MnhtbHZpMDM4Y0JpZUZ6?=
 =?utf-8?B?azE1REJsYnVPRHJmcThnYm9HcGVsMzdPODZnQnRMOUJhTVM0V05Oc2xoMUJ1?=
 =?utf-8?B?cDAwUVBtRHFIZmRBd3BQQ0h0UGdPeVV0UGRhY3JkMVZ1ODZkZlQ5UDF4UVU3?=
 =?utf-8?B?RHdxa2c3VnhUNHZPdzJoS1FrbEptcDcwd3F5MWI1S2ZuMmxVTTJEOUc3T3R5?=
 =?utf-8?B?dUtSVXpqZUVVWWZ2cVg3eW8rWjg2cXdzVlZBMDljNnZ4VEhuV2o1dkp5aEdS?=
 =?utf-8?B?TWUzaXpuWk9RaDZmckRzelRSNmdIQjhLQWNLUGVvamZKTGhXZ0dtM2hUUmRQ?=
 =?utf-8?B?QkhzR0h3TUJNdko1ODZjc3FhMnRudnlzd1RTb2dXdUZzRUZLYzU4cUNNT0hz?=
 =?utf-8?B?eHgzV1FsK0dUTVZrV0JPUnFRUkN3eVdTekdaQTlCU3R6YXpBOUZpRE1DZGRq?=
 =?utf-8?Q?cBxxJMyDKuLp7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHFzaUZWZ200WFdhaTNIcndyaXhjaWtpdkZsTSt5T0tlZUlwRmt0NlZlR3dP?=
 =?utf-8?B?MTBVS095UFBGTVdOQXVodGtabnpCT2FGRVhaZWpXdHoycWNDczJpNlhZTXRL?=
 =?utf-8?B?VGYydGd5Nis0Q0h2aTFRWVowc2VSSGF2WFRLdDRhT3JzQVVkZnBrTzM4RVVi?=
 =?utf-8?B?ZDlTQU9jN1NoeWw3Y2Vpd3lqQlovN05CQ0VIRm94eTFyWDUxeTJROVBWYUha?=
 =?utf-8?B?TXZsZ0JQQ214UzBvTDVTSXBHbFJSdERpalkwWncwMGxqaDRWNm1QOTNYWXpI?=
 =?utf-8?B?RVRHTDFqTVFXa1Z3VVhnVURZaTB5RWpkcEFyZU9nTEJaWkpwWFdoRlJBeHBF?=
 =?utf-8?B?eUhXYzAxWGZIdUlKYlBPd0lCdXBpd2VURzM1b0IraFZTK2VNbUNJSUlGTEIx?=
 =?utf-8?B?U3dhNUQ3WnI4Uy8vYmdQb2N5SFA0MnM3OVYyMXVTbFk5dVFCQXBqRWJDV1dO?=
 =?utf-8?B?QzdLVzM4T2tROVpEeUZHZHh1bjdyT1ZmUUplNStRQzFkSktuTExPOUtpRTdH?=
 =?utf-8?B?YkNPelNvQ1M5ekQvaU05M0ZjaG9yQWZDUHNldXRucEN5WUtZT0tuemdOMEE3?=
 =?utf-8?B?VnQ0TlRXeVFkRGU5dllaWWZOcXNIUHBSTXdaVW9XRlZ1VXFkSkZIZFJ5VmJq?=
 =?utf-8?B?bkJtL0tCd2RMMTJVQ2VVNXRMVGFUYnd0bWprRGx5SzB5Q3VTeEs2TXhucThp?=
 =?utf-8?B?QU1EZGcvRXN0dy9zY0ZDb1V0YmFHblhKd09JcUw1TGxnWUQ4TUtMcVFVOWZl?=
 =?utf-8?B?Vnlac1Q0V3RBd0VCRjlSeHpTV01BMzd3OWk2aWo3T1JKdi81QTI0QTB0aU1H?=
 =?utf-8?B?ckp3RWZsTkdCZk1Nb0RYdXlkVFhRdnBQbVJTVDFpY1ZJclJzU0FXUmpyWGo1?=
 =?utf-8?B?d3ZnS1NMS1lUcjBWQ0hpQmpEdzNhbTQwT3d3V05PUWpqWmtMNGxnSHBLQ0VW?=
 =?utf-8?B?ZytGSDVWdFlMdFJhVSsyV2dBZjczalVwbndYS2UvZnVKbjZ2elBHZE9YZUNp?=
 =?utf-8?B?bHBBaktEaERtZ0JxbHFnaVlUckdyWUNDQTF1bVBPei9vdWhlT0xrOXExK2lT?=
 =?utf-8?B?R2RSeVhIUVBqeTdSTHVvZE9nazVHc3NWZ1dXaHhmemNkTGhGVWRwY0pGakRy?=
 =?utf-8?B?b1hpa2lHaVFRWGtLVCt1S2Zpa3JRTDljTUt0Vk1yeExwL3FBeDBUUVhycXht?=
 =?utf-8?B?OUl1cHFLandkdTc5Ky9yRzNaclQ3RC91Y2ZxUHU5VG5KVGNSV25OMlVNdFk1?=
 =?utf-8?B?Q1V6ZkRwZFVINUNzeEk3bW5ZUmZvTUpyR1VZNW1kYTN4UEdGczBibU1Qd2dH?=
 =?utf-8?B?ZU4wL0dvKy9vc2JTanhYbERLd0Z2OVZxczFISm9EZVoySzRueUQ1Yyt3UkNM?=
 =?utf-8?B?SFQ2UXRFdk1RT3NrUGhYMHVwTnpzdCtFR1BZYm4vUHJrcDhIUms1d3VrZHhP?=
 =?utf-8?B?VlB0Q1NSZytTN0lheGI4L0JLS0NFS1VGcG9abUViUWw3Um5pdzdCWlJYRHBL?=
 =?utf-8?B?VUJ6dGVLU282aGx1UjBCSzBxaUhCYlpZcGxNRE5vWHoxVWdDYXNZdU5XbHdE?=
 =?utf-8?B?anpXenh4WnQxSUZrNjRjRDY0QUlaZ2Nxd2lsaXMwNVh3WkxGM3o1ay9aY2t4?=
 =?utf-8?B?MHJQR1lVWGZyWSthNExrOTNGZWp1NWNYaGlJU2dPeGVRVlFEdDJ6Sjk1VExK?=
 =?utf-8?B?Ynk5cU1NT09GV25vYWZRNnRCbWFUYVBQMDdlUW5kLzNtVk5pdjZwSHdWdjNt?=
 =?utf-8?B?eU1JQWVyY2pZcDVKVkcvSUMyb2xhRzE5SENYRllKTUhFdUJ0SW5ZelJ3Ri8x?=
 =?utf-8?B?NXJ0R0M5OW1ZMUZIcy9YdnlvNExpS0J6VlhRbHFqNE1PQnZlMlRyVmZOVkFI?=
 =?utf-8?B?cUk0enR3MmxnNi9FbzhtVFlMNnJTRjhyV1NvUjZ5MTV3eTNJbXl6UlhqTjRj?=
 =?utf-8?B?ejlxcm50RStOS09YUDBXVGlBUm1DY0kyM1A4NlNRMWNtT3JYcG5reFFla1dt?=
 =?utf-8?B?UHNCNks4NmxGSkMrWm9Xbk1mUEtZZFdTdjVMc3JlK0tHaWxaQnh2bzZQaTdS?=
 =?utf-8?B?WVFuZk9XSjl4RHRHb0dZYm1tSDdWcTZvUWRTdCtoZGlZakdRNzI5MWw0TEw1?=
 =?utf-8?Q?7rM1dXYpdU/o4QwRDa1fDZHAy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f604b25-dd73-405b-7a75-08dd39779213
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 17:26:27.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCV4ocFM1h5zv3YoL6d85+4cvezp59rUCCsCojH0fQwWviHk6ihqkA+C2iI6v/+q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591

On Sat, Jan 18, 2025 at 11:15:46PM +0000, Jiaqi Yan wrote:
> In the experimental case, all the setups are identical to the baseline
> case, however 25% of the guest memory is split from THP to 4K pages due
> to the memory failure recovery triggered by MADV_HWPOISON. I made some
> minor changes in the kernel so that the MADV_HWPOISON-ed pages are
> unpoisoned, and afterwards the in-guest MemCycle is still able to read
> and write its data. The final aggregate rate is 16,355.11, which is
> decreased by 5.06% compared to the baseline case. When 5% of the guest
> memory is split after MADV_HWPOISON, the final aggregate rate is
> 16,999.14, a drop of 1.20% compared to the baseline case.

I think it was mentioned in one of the calls, but this is good data on
the CPU side, but for VMs doing IO, the IO performance is impacted
also. IOTLB miss on (random) IO performance, especially with two
dimensional IO paging, tends to have a performance curve that drops
off a cliff once the IOTLB is too small for the workload.

Specifically, systems seem to be designed to require high IOTLB hit
rate to maintain their target performance and IOTLB miss is much more
expensive than CPU TLB miss.

So, I would view MemCycle as something of a best case work load that
is not as sensitive to TLB size. A worst case is a workload that just
fits inside the TLB and reducing the page sizes pushes it to no longer
fit.

> Per-memfd MFR Policy associates the userspace MFR policy with a memfd
> instance. This approach is promising for the following reasons:
> 1. Keeping memory with UE mapped to a process has risks if the process
>    does not do its duty to prevent itself from repeatedly consuming UER.
>    The MFR policy can be associated with a memfd to limit such risk to a
>    particular memory space owned by a particular process that opts in
>    the policy. This is much preferable than the Global MFR Policy
>    proposed in the initial RFC, which provides no granularity
>    whatsoever.

Yes, very much agree

> 3. Although MFR policy allows the userspace process to keep memory UE
>    mapped, eventually these HWPoison-ed folios need to be dealt with by
>    the kernel (e.g. split into smallest chunk and isolated from
>    future allocation). For memfd once all references to it are dropped,
>    it is automatically released from userspace, which is a perfect
>    timing for the kernel to do its duties to HWPoison-ed folios if any.
>    This is also a big advantage to the Global MFR Policy, which breaks
>    kernel’s protection to HWPoison-ed folios.

iommufd will hold the memory pinned for the life of the VM, is that OK
for this plan?

> 4. Given memfd’s anonymous semantic, we don’t need to worry about that
>    different threads can have different and conflicting MFR policies. It
>    allows a simpler implementation than the Per-VMA MFR Policy in the
>    initial RFC [1].

Your policy is per-memfd right?

> However, the affected memory will be immediately protected and isolated
> from future use by both kernel and userspace once the owning memfd is
> gone or the memory is truncated. By default MFD_MF_KEEP_UE_MAPPED is not
> set, and kernel hard offlines memory having UEs. Kernel immediately
> poisons the folios for both cases.

I'm reading this and thinking that today we don't have any callback
into the iommu to force offline the memory either, so a guest can
still do DMA to it.

> Part2: When a AS_MF_KEEP_UE_MAPPED memfd is about to be released, or
> when the userspace process truncates a range of memory pages belonging
> to a AS_MF_KEEP_UE_MAPPED memfd:
> * When the in-memory file system is evicting the inode corresponding to
>   the memfd, it needs to prepare the HWPoison-ed folios that are easily
>   identifiable with the PG_HWPOISON flag. This operation is implemented
>   by populate_memfd_hwp_folios and is exported to file systems.
> * After the file system removes all the folios, there is nothing else
>   preventing MFR from dealing with HWPoison-ed folios, so the file
>   system forwards them to MFR. This step is implemented by
>   offline_memfd_hwp_folios and is exported to file systems.

As above, iommu won't release its refcount after truncate or zap.

> * MFR has been holding refcount(s) of each HWPoison-ed folio. After
>   dropping the refcounts, a HWPoison-ed folio should become free and can
>   be disposed of.

So you have to deal with "should" being "won't" in cases where VFIO is
being used...

> In V2 I can probably offline each folio as they get remove, instead of
> doing this in batch. The advantage is we can get rid of
> populate_memfd_hwp_folios and the linked list needed to store poisoned
> folios. One way is to insert filemap_offline_hwpoison_folio into
> somewhere in folio_batch_release, or into per file system's free_folio
> handler.

That sounds more workable given the above, though we keep getting into
cases where people want to hook free_folio..

> 2. In react to later fault to any part of the HWPoison-ed folio, guest
>    memfd returns KVM_PFN_ERR_HWPOISON, and KVM sends SIGBUS to VMM. This
>    is good enough for actual hardware corrupted PFN backed GFNs, but not
>    ideal for the healthy PFNs “offlined” together with the error PFNs.
>    The userspace MFR policy can be useful if VMM wants KVM to 1. Keep
>    these GFNs mapped in the stage-2 page table 2. In react to later
>    access to the actual hardware corrupted part of the HWPoison-ed
>    folio, there is going to be a (repeated) poison consumption event,
>    and KVM returns KVM_PFN_ERR_HWPOISON for the actual poisoned PFN.

I feel like the guestmemfd version of this is not about userspace
mappings but about what is communicated to the secure world.

If normal memfd would leave these pages mapped to the VMA then I'd
think the guestmemfd version would be to leave the pages mapped to the
secure world?

Keep in mind that guestmemfd is more complex that kvm today as several
of the secure world implementations are sharing the stage2/ept
translation between CPU and IOMMU HW. So you can't just unmap 1G of
memory without completely breaking the guest.

> This RFC [4] proposes a MFR framework for VFIO device managed userspace
> memory (i.e. memory regions mapped by remap_pfn_region). The userspace
> MFR policy can instruct the device driver to keep all PFN mapped in a
> VMA (i.e. don’t unmap_mapping_range).

Ankit has some patches that cause the MFR framework to send the
poision events for non-struct page memory to the device driver that
owns the memory.

> * IOCTL to the VFIO Device File. The device driver usually expose a
>   file-like uAPI to its managed device memory (e.g. PCI MMIO BAR)
>   directly with the file to the VFIO device. AS_MF_KEEP_UE_MAPPED can be
>   placed in the address_space of the file to the VFIO device. Device
>   driver can implement a specific IOCTL to the VFIO device file for
>   userspace to set AS_MF_KEEP_UE_MAPPED.

I don't think address spaces are involved in the MFR path after Ankit's
patch? The dispatch is done entirely on phys_addr_t.

What happens will be up to the driver that owns the memory.

You could have a VFIO feature that specifies one behavior or the
other, but perhaps VFIO just always keeps things mapped. I don't know.

Jason

