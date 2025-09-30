Return-Path: <linux-fsdevel+bounces-63084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F1ABAB6E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A1C3AB419
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49F265629;
	Tue, 30 Sep 2025 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JHHIoL+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF60288DB;
	Tue, 30 Sep 2025 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759208183; cv=fail; b=EtvQtXmnt4ZIkFtdu2m0NyNDr8pv7KZr/QCuuVuZ6+iaxZjsoFK5DfGo/fU4A/8JzJl0hXdinIbCOv8JGHPDMuQMby27ZushgRFYjVUk06+eglFPiUFoTClonseNO6rgh0yFnN+TDxdpzmNpvOgOdJPTBiebW1HiUGYXQHi8Hqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759208183; c=relaxed/simple;
	bh=h+HL6aM8gQMka7N5ZB+s6P0nDHeDbOyKpufwHQrIHGM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ADk099UHHEjg1MEqriP1lsEUXAUKt1oxouMp3gToR2PmwglZe/u1OSUagIc+pVmgYICtHR1CL5f2i7TROPgfMOvegY0q0jdt/vz0XuGLvFCoOykJzDMmqy6Ua3y8OJWTjcyLkJyvu7WSM9oLZ4/LwS6W6nNBiQhQPVXkxSgTDK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JHHIoL+P; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWTtm5I7yIkAUQaVQ7VyyvUC6DnJCFloaDCrlWbYjaHIEJ49qrrAOjOhAWBKW5kCr6SzVHJlvjDdskV0TffrpqgsAAxqUYZ0NCbdOLlXoYrbpRAR5UmzsxA5Nx8zjfFastZJVUufTdCGU3ln47J0tjqilww3w4HkCHTRGedOO7yMm8+bTWqW5jt2qt+ClJ1p64Oc9PU9FN6A2GtW50kaWrzMXaRwgAzyYGqrX0YkieOvp79hQyjIksLOiyWKxXLYoAt2jogmBTeHlobBCHp2ofaahpnLC4f30Rjfe87fZZaLlvnZPgR1o5U5vbz/n0Kln9WRM4YkQeicOEQx1T8uDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWQmyC9rw3VE8aOtQf4auPgL9fRkiumA0Qw8emhvtTA=;
 b=JHxcUC8xk2qP9JEtLrHlD+Cpz+HotegYbIkWaHwT15tYkMWV68Qw4SEfcPsfyxa1JTFag493VNnNPxctHNSh8Y/AHgEvQUrsmFHafLokxWrOvlsd0ZsvB0jBgtnfTnueEJv27KLZ8i2ip0SLT2plqFFnKYI6JRbOnySJNwqty5XC8f2l5daytSxLI42yaaylyhUq6ExZYnjaDXDbF0ECjmcoIBYBCEu3eRfbW9Cz8s6wujwBZuKs74W4ULSamg6r4HZaBUk7Ms/GvcsvA5SiCPULcfT2f5ap0SyqOOXS6bcKuC3apraMvj7QnIi4BEo9U5ojO+cgI9FYgCwfmEeMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWQmyC9rw3VE8aOtQf4auPgL9fRkiumA0Qw8emhvtTA=;
 b=JHHIoL+PE4ECum13n6F2/axwIu9q3KaG1qhmh41zPcuSmuWbhu3IJVv7E0MtTwit1wPNXc4OFjC5/SBwEG6aGWgQb7MaJxs39/qVYztZjiPP0abdGXUTii0ZnZwPhfLlMwwcpSKNs0aGkAofBojwCjgx9Srk0iXrVMNRvhRa8VA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 30 Sep
 2025 04:56:14 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 04:56:14 +0000
Message-ID: <a72ffd72-3731-426b-a875-fc85e006a31b@amd.com>
Date: Mon, 29 Sep 2025 21:56:11 -0700
User-Agent: Mozilla Thunderbird
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Subject: Re: [PATCH 1/6] dax/hmem, e820, resource: Defer Soft Reserved
 registration until hmem is ready
To: Borislav Petkov <bp@alien8.de>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
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
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
 <20250909161210.GBaMBR2rN8h6eT9JHe@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20250909161210.GBaMBR2rN8h6eT9JHe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: b19b22c8-f30b-4ddf-3d82-08ddffddaeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2RqdWkxa1ljT3Jyd1BwRVRUV05TOVFJOG9oQ0p5SXpHYVMyS1BNS2pMQ3NB?=
 =?utf-8?B?RG05VkFLMUc0VVhRQXJiYUJSb2dhMk1RQ1NKU1psVUp1aEtVNHB6cUdHS2c1?=
 =?utf-8?B?YmZreFJqZlFnOHJ5ZVJPdUdNYXo5UStLSFNldWdvMXNPa0RmSG91ZllyWTdP?=
 =?utf-8?B?dkxJWWp6UkdEeGdmUGZVd3NQMzVwWXVPRjE1UUV4eW0wK2ZCQTZtTEptMW9o?=
 =?utf-8?B?NllHVFBmWG9aUjZTTmczTGtjSzVvTW1IbHAzYS9vbWhFNXdIZE5nRTd5Z2Mw?=
 =?utf-8?B?dEpSZHJLWWxkNWJRbzcramt2TDZjUFBnSWlKTHl6YlVaTzhya0ZOMG5VcjAr?=
 =?utf-8?B?cDhiU3lGYm1xNFdhYkN4VFZZaEorUWxJU3o4QUtTbVV5NW10STZKK1RWZVJN?=
 =?utf-8?B?T2JDWkNaUmt2WEhhelNMVkM4ZjlLVi9Ndi9OamowdmFBQXpZTjN5M1VPUlhQ?=
 =?utf-8?B?Wnl3c1JjZWQ2ZzB1c2Y3bGh1VXI3cmVwWHVBK25yY3B2dEVpREtFbGhnbzU0?=
 =?utf-8?B?dVFsQmxmc1VBM0ltRENBajkvUzRHQy9GK2RMQ0dXSWJBRU80RUpuWWcvekpv?=
 =?utf-8?B?dWFQRmErSTJwUDJjeTdMLytGYUVjQ2s1REZJTVlkV1F4MkdHMDlRc1o2TFhT?=
 =?utf-8?B?Z3dGSHJ1dEwrYXh6QkZ2eEVOd3FzNytLNCtXZEN5WkZIVkpaOTRpUTArcVU2?=
 =?utf-8?B?TmllR3QrMXhFOTNIdW5EV0VyWDdCeFBJSWgweHNBMG93U2t3ZlRiaHc1Z092?=
 =?utf-8?B?YjRQbGZzbCtRMk5HbGNmcjFUbnNPNkxDWUE2aVk2am15NVI3TFhZc01lSm5t?=
 =?utf-8?B?R2NQbGFUSTh6SkVSdnFkb3Z5bDMrS3hVZThrM3pVb1p4VTYrQ05lT012aXNr?=
 =?utf-8?B?M1I4QWkyRHpSWDRPTUJtQlh0SnhPOFN1clY1U2Y3c3NxUDdudVdhSGZ4TWo1?=
 =?utf-8?B?dWtiOXRMN3VkRm03SERVeUkzMXRVNU9XejF0WnlHSzRuRWJKU09JOHpEWStp?=
 =?utf-8?B?ZHNEM1lNNHRqaC9WeFRyMFFFdU1lVEhrL2lqQWRaNzNwV2tqZ1lFVDd5Y3gy?=
 =?utf-8?B?NUk4ajNCZ2dSR0dtVGcvOFdzZXZ2VVBIeHFOaFlGdGExdzcyQnVoM3pCazBD?=
 =?utf-8?B?V296aXcydFMzRnovSWpPTkFJRjVjVitIL1NIb2lyeEVhRVROTTNMOXAwWWI0?=
 =?utf-8?B?eUlrcHZmcUNjc041cnJzbzIzNXV5UzhWWXU1ejRYU1g5amRyR2hwOVE2QXJK?=
 =?utf-8?B?S013WmFFbFJwczZkY1RLS2xSNzJNcERTbWxRbllDaFdXUzhJNW5uZ1VnWmlO?=
 =?utf-8?B?dE11elhiQVVHeDhXRmQ3WkdGMVNKZ28rU1F6VjBOdmtCZmhsTVJ3Wmg3SlRu?=
 =?utf-8?B?aXFyUlJobHNQUWR3Z1NHc0xGQzJtMVdjakoxNU01dU84NlRiSzVoWmp5SWJV?=
 =?utf-8?B?cHo1V2Y0c3lMRURFWXZPNUZKVEhpa2k5NzlkUXkyQUJOcHBLYlAxZGNMalN4?=
 =?utf-8?B?REVQUGdCRE5MckxjK0ppTDNYUlREYk4vYmZIWkI3ekNQYTR6bHFGSkZiQUdE?=
 =?utf-8?B?UHlXUzVSUWN1d210dGw0RHkxQzRWeCtBdTRpS0lGM3J4ZHA4TEF1YUNiYXB4?=
 =?utf-8?B?Qm9nMDRrNWZhZHl5RjkybHdFTks3UVR5WStoaU5Nb3hyckFwTHBKcldteWFW?=
 =?utf-8?B?QmxnNFYrd1dUUWhlS2ZQeDJ5OGpRS25PRUpNNWs2ZThtcUhCOUJXTEZRNmtD?=
 =?utf-8?B?NWdvZjZOYzR0Z2dOKzZKYnN0dUdhRlVsNzV2NzhJQXRkSTJUemo0bmV4U2E2?=
 =?utf-8?B?bmtLTHNNSlpycFNKWUg0QTluWWVRaHlURWlhNzhpRmR2QzBXMnQ2WWVVVm5v?=
 =?utf-8?B?MGJPWGlxVjdzVER5b2pBbjdLbWdrR2RUbkJncmZrY1RSRnA4T3h0Zm9jSTdM?=
 =?utf-8?B?SE9YY1RmWXFoNjRPZFlzRlFDZGRzSG1QeHRZSTdNdkFlcEI3eEM1MkxDTXIx?=
 =?utf-8?B?Mnl0aVhKeWh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2hQNzA2UHdqY0t5WDUzdk1uRTFrSU9vWmFULzVtbVVaY0VjOFNibHVXMnps?=
 =?utf-8?B?Slc1cS9lamtYb0RBeThncXRnakhDeGRhRUxlMGR6M1U0cVprTzErd3dsbVJN?=
 =?utf-8?B?Qm9kVEI5TDVjWGpkSDZ6QUwvY0UweHJUcXNqdFYxOUYxc1dhb2tFU3g3cktK?=
 =?utf-8?B?QW00MEpYMTl2VXhGcVdFeC9pcVRSRlY2cWYyWnBhUFh0eG9iSFhwT1JKQi8z?=
 =?utf-8?B?bjBlcjNGUlZaT1huQUYxSXJXWjAvci92TWVPTmczamVWdTFiL0xkYWpYQXlq?=
 =?utf-8?B?QXA3Vkg2UnpscGZKRFJ3Q3BPVDdDSHZFYTNNbzJPb1NBVmtDMFRZeU5paGVk?=
 =?utf-8?B?b3h5Tk9udTMrQmNGejNEMVRBbm01R3NRWTZYRlVQOFFiVEQzMWdNSnFRUkwz?=
 =?utf-8?B?QWx0RzlLRnhFRDBTTUhvZWFDQWtVQm9MTWgvazIzZWt0c2I1RjkxS3VxN1Nu?=
 =?utf-8?B?aVpiTEk2V1pENzdZMHJFdTdMWFd2eG5UYmVKbU5tZ3Q4aHBIeWcwQkVNeUlR?=
 =?utf-8?B?QXBJbmYybG5vQ0gvRDBjeG9XM1I3bGYySWdDakxSdmR1eS9seGxLNGNNalQw?=
 =?utf-8?B?dks1cTd1dktrSlM0N29xbkQrZkk4aGM4ZEI1akdaMS9CQmkxanJVUE82Qkxh?=
 =?utf-8?B?dWZFTXFDODhldU1jL25MZUtuYjlMQ2ZBTkZsT0lhdGtubXplZStKcG53aTdr?=
 =?utf-8?B?V3lSSHo1SW1ZVlRUZ1hOaVk3cGs5Q1A5ZWkzK3htU012RWtKNmxObFM5WFJ2?=
 =?utf-8?B?S0dmSzJ2aHZFMWp1b0xXY3R2K05rUjhlL25QSDArVisvSVNZVnlmSWRtSk9F?=
 =?utf-8?B?Qzdld1RSZTdPdlpJQlVMUEF5Ny9DMFp2aWxWL2U0bUU2TzZGM21rNlY5dFp2?=
 =?utf-8?B?NW9hWGhNcFlqMXhvWGlJWDAwYVJRV3B3eVVpNXA1WlcyUnl4TDMydjdGQ3JG?=
 =?utf-8?B?RUMrWHE5Mm1FTGhzdkhCL1NKSzVxZFNTc3h0Q2oyTHo5UGhMQUhZcW5DUGc2?=
 =?utf-8?B?eDBrRkhoc2NjcW15c1pWTVZyZGZEVjJTYm5oYWtPb2ZSWVRrYjFsOHd6Q3p2?=
 =?utf-8?B?c0dvU2Nxb2lJOWR1QXpyZU5TODZKeWM3Y1B0TVU4MWdQa2xqRU84K2RBd20w?=
 =?utf-8?B?dUhEb3NjWDU3N1NpVGFtZXZlZ0R1VDVHa2RKY1lJSHV4Z0hrazBvVUlCNW5V?=
 =?utf-8?B?N1VjYWk5YXZPa2JFQ0s1V25RM1JkeVdOR0VObElVb2lIQTBjVjRvMWF4c2pa?=
 =?utf-8?B?a0pTcVZUc3V5a0M5bWhmdEdYb0x6QVhUU0h6U05yMFJEYVFxb0NnV1dJTko1?=
 =?utf-8?B?TWhYelU0ZlNNMTJlZ2ZMVjdRbGpxWFlkQ0M5bzVucVgvRFJWWmtjVVptWTZ2?=
 =?utf-8?B?VjIyQlo3OHZkSWJxRGdvZkpMYktrNnNNQUJUM2tXcVBKYzMwZUJRRWlwUE1I?=
 =?utf-8?B?VWJmb2kyQnVqNkt3a0Z5L1hLK2ZXblppV3I1NEQwcm9ldnlueGV4ZC9ic0xX?=
 =?utf-8?B?SmxnUkMzYSszazB0QSsycDNxL3dPU3NWbUduL0FlRU1EQnZ0WFAxY0dkK0xp?=
 =?utf-8?B?RWMxa1dUNDJ5U1hoMXJFSlNqd3FoWlpuekFnU2QwWk8xUXo3WlpPSkVWZHRM?=
 =?utf-8?B?YTlzVmNqVXJ5UW1LOWc5SENxV3RNTVRkTzBYQ3k0U2tNeGdNWnhJTEJsNXlr?=
 =?utf-8?B?MGtJdHlEUTYxNWxtVGxvWWJPek9EM1AvRTk3U01Tam43aVpXeUN1K0UrUzRF?=
 =?utf-8?B?WVFNVkNYMFY4T0xVMWVlYk8xYmthalZXNVhLbUlpT2Vva3RXSHYzdlRTV2dz?=
 =?utf-8?B?UW0rU3ZZWTVUQ2FFOEYwT0RzUHN3a1k4MjcwNmJFeS9KM1dTNGo0a3c5anJ5?=
 =?utf-8?B?c0JDQmZDaDRiZUZHOXJuNVNmcmVUMExyTDcwWk5HVTFmRkZHUXRqR0xrQW5E?=
 =?utf-8?B?VldTekdUMDNNcXJUL1pkVzRvUTVvUEZGczM4SWJWMDNuU21FQkcwNFJ0TnZO?=
 =?utf-8?B?bDhkNHdkdURMaTNhTnJYeGJFdkJYdm9UejRRNUwyL0M2bnowQlgzdWd1MTdp?=
 =?utf-8?B?a3hvZTlkdDBDNVlXSzdtUzlnbGxTcjZVemF5QWlXbEV5bCtoN1h6TGlrR1BS?=
 =?utf-8?Q?mLH2uotK4oCTJj9lcvXjrqM+c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19b22c8-f30b-4ddf-3d82-08ddffddaeb3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:56:14.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vK6i+wPUSLYlmyZUu2XrU4VDrxKg4vtPLAAk9m9SrtZZ+F4dL8KfHW89pMvgE2kLuR+KLgxIyK/M+YMr39GEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066

Hi Boris,

On 9/9/2025 9:12 AM, Borislav Petkov wrote:
> On Fri, Aug 22, 2025 at 03:41:57AM +0000, Smita Koralahalli wrote:
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index c3acbd26408b..aef1ff2cabda 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -1153,7 +1153,7 @@ void __init e820__reserve_resources_late(void)
>>   	res = e820_res;
>>   	for (i = 0; i < e820_table->nr_entries; i++) {
>>   		if (!res->parent && res->end)
>> -			insert_resource_expand_to_fit(&iomem_resource, res);
>> +			insert_resource_late(res);
>>   		res++;
>>   	}
>>
> 
> Btw, this doesn't even build and cover letter doesn't say what it applies
> ontop so I applied it on my pile of tip/master.
> 
> kernel/resource.c: In function ‘region_intersects_soft_reserve’:
> kernel/resource.c:694:36: error: ‘soft_reserve_resource’ undeclared (first use in this function); did you mean ‘devm_release_resource’?
>    694 |         ret = __region_intersects(&soft_reserve_resource, start, size, flags,
>        |                                    ^~~~~~~~~~~~~~~~~~~~~
>        |                                    devm_release_resource
> kernel/resource.c:694:36: note: each undeclared identifier is reported only once for each function it appears in
> make[3]: *** [scripts/Makefile.build:287: kernel/resource.o] Error 1
> make[2]: *** [scripts/Makefile.build:556: kernel] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:2011: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2

Apologies for the delay.

This was based on mainline. I have rebased the series onto the latest 
mainline and sent out a new revision and noted it in the cover letter.

https://lore.kernel.org/all/20250930044757.214798-2-Smita.KoralahalliChannabasappa@amd.com/

> 
> Also, I'd do this resource insertion a bit differently:
> 
> insert_resource_expand_to_fit(struct resource *new)
> {
> 	struct resource *root = &iomem_resource;
> 
> 	if (new->desc == IORES_DESC_SOFT_RESERVED)
> 		root = &soft_reserve_resource;
> 
> 	return __insert_resource_expand_to_fit(root, new);
> }
> 
> and rename the current insert_resource_expand_to_fit() to the __ variant.

I have made these changes as well.

Thanks
Smita

> 
> It looks like you want to intercept all callers of
> insert_resource_expand_to_fit() instead of defining a separate set which works
> on the soft-reserve thing.
> 
> Oh well, the resource code is yucky already.
> 


