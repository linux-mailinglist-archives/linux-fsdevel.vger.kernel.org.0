Return-Path: <linux-fsdevel+bounces-64989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54515BF82CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 327584EF320
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2534F24B;
	Tue, 21 Oct 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gp0BqNWb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D481A2392;
	Tue, 21 Oct 2025 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073083; cv=fail; b=iYg2OZPDD2CYDk+UW3b0G7yqSHm5dclOByu49LnJfn6Qzq9zU0HVGKlT5rlk5P1UwBAtE22W7lQ317FTl9t7BT0FCsmpIZYaaJM/S2CJMh/7g/ph08fCGs5aITPy4TrV/1bEe0o/iHVxZgV7GWthsWDuq+PT/6vNt8nVLVYYFcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073083; c=relaxed/simple;
	bh=yqHylliNIfqZUD8EBpbulsTOlpsgi25DClAMru/djLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hC34yNtPgHoaLGzKBn+PJlEUctfNJ//oqlfcU98L1Y5A7UPH6reZ27OJSYlNp/i2XQXOc5lgOQmJehgyK+mTys0Bn23tCx8InOM1pWnRl2ReMWyPARmvTEkA4yKmPk1oq7GIwLJbsG3N/CDApvlzlT6mE2YjZxXrkarkiGH8iqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gp0BqNWb; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivUiOrnllnj+eACYVd/YKO4Xp5PFV5aP4QKNmmEkOSUOKmSMUiVCTp0s4BRWysz5UyPHIKQE42T9FEs/2Xq6xDdCG/w62On/qkjwrS2YvlFQM9npPf5saGqjjMS5K7Bon+098AkWyNU8sfZrGKn4y/xkXqgZeobgHtAEODaQIre9OC30wMwnB0eia+NfgVEEbkDOWpHJLr7nWbs4eHqpd0yTm57J2ZyYLHc7CaumbJZAV9YtVuawpRjpeTw7zUvmGiqU0DBZ33NyEfnGqKA+d17sPjSXt6Xhyd2Dzd7Uh93lHNw9TTu6o6o9XrvGoBEoT7dbgCEso3RMWEJcf+BTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTQzjvQ8NE6ViGqQ9SQkcAhO5i6edhyiT1TNGN3M5O0=;
 b=FntNgFkDim2WbT6Vn3C16KH0RR6+2/0LCJUBttcGBRgihiY3hZB7BAJXbjS/HghkPGIfkZC7jB1MHyQaYluWuqE0gLjX1bPofrD8v6waQDFEIbcofMJD1KA2hKjnb9+wLzYQD+Wkq8GN8I+cohRwh5mkuajsHqTmuAdMS27h+61ypYWa2lVnb0b1g4zCkyhGFkv87G0B1UVd99VLrQWwa/tq6y6VAhiiXMqT0zdE07/6NggxUOQpQwY8/OguMdgPks9u6VRrHnf27mSdt0WoLHJ6dMRpow9BMxTWmueR6ZPqSID3T1vUxbIrHr7fSvvsDxa5YS7NFHTX5Y3JMDNsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTQzjvQ8NE6ViGqQ9SQkcAhO5i6edhyiT1TNGN3M5O0=;
 b=Gp0BqNWbGVBf6pwjTejPkQ9oxO0Qsf1Ut1Qzpogfp6dCx8G8Z40ALE86wUpCHWP2Nq7H2JuVg6OIJeeJLy6NoM7MxkA8h5xdabGMLm4qJCr+z2jY5ymfjgVfRaSRmFX8J1fq3W3TTYahxMKwlwsIOetE9pG+9Kx35PRzFD9z6otHoMmyjl3B6TUmYOs5RNkfLmXzcbq6CSbe7Xj4vWtlV90j4Yghyp0MaEuVQmyfMI8MBZCLuOb1dhlr0EujQCxNl7Au/sOZ0wdXbVez3SaaG+OIFGy3MJve+f1/mjH/3fZ4RYNAsom4Nx7msLcCkCeG77i2N+uVC7SAhs0hLCHukA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Tue, 21 Oct 2025 18:57:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 18:57:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, linmiaohe@huawei.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio
 handling.
Date: Tue, 21 Oct 2025 14:57:51 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <6ACA0358-4C83-430A-892C-F0A6CC1DC8EA@nvidia.com>
In-Reply-To: <595b41b0-428a-4184-9abc-6875309d8cbd@redhat.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-3-ziy@nvidia.com>
 <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
 <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com>
 <CAHbLzkp8ob1_pxczeQnwinSL=DS=kByyL+yuTRFuQ0O=Eio0oA@mail.gmail.com>
 <A4D35134-A031-4B15-B7A0-1592B3AE6D78@nvidia.com>
 <b353587b-ef50-41ab-8dd2-93330098053e@redhat.com>
 <893332F4-7FE8-4027-8FCC-0972C208E928@nvidia.com>
 <595b41b0-428a-4184-9abc-6875309d8cbd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:408:142::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ba6138-9162-4d10-74ef-08de10d3beeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzRGMmxSSDJGZGJIM3poYStXaEdNUTdISTVCS2pDdzRLanRCdjY4Rk16OFU5?=
 =?utf-8?B?QTNVdE9zemJKZ0hpQ0Nrc2JMZnVLdjRJZFJHT0djY05kN1EwTFhTN0pzakR6?=
 =?utf-8?B?YitwQnczS28vSTBLdU42d2dDZ29tR09qOWxaTlIveUVKTDN4aitsRml2UEVh?=
 =?utf-8?B?clUyRXBPcThEQkpiSmJiZkJENjk5WURLR0NiWDI2NTJ5NDQ2bjBLUVcrUFdt?=
 =?utf-8?B?QWFobGpRNVpqdEF5T1hjQnUzeWJnbGVNdDBYbHkyRDhwclQyOW9SRXh1VjB3?=
 =?utf-8?B?ZWM1cnJ4QlUzaTg2bi9odUxsc0lLODdGL0dFaXhLY1pSSkY3Z0x3NkdTM09T?=
 =?utf-8?B?M3hQd212TlRVL0trb0NXcTY2elFUTWh3eFpNbVY4NE1DS3lDb2tOcWtRK2hR?=
 =?utf-8?B?ODZ4M21EL05Yci9seWU5VWg1RlFUWTBzSVJWRk9qcEhVb09tZlhJNEpaQ08z?=
 =?utf-8?B?SGpEWWEvWXdGaFVXOW1Ra2krRktMOVdCeDZPeFo5WnpnbVhRSzI2NVp4eVRa?=
 =?utf-8?B?d0VqWXdoaTdDRWxHdTlEem4vb1FITVlPb0R4aUR3SkFiSnBWZmtnckdzUmRa?=
 =?utf-8?B?U0k3T21SZDFpU0hmTEQ5bkFJQk9zMXIxalZFSng2VGFjMkdzTUlMM3JqWFFF?=
 =?utf-8?B?ZGplYVBkcGdtZVJmbE9ITnQyeWQxeDFBQWxaOXJVbUl5N1FObStvK3Vya2o3?=
 =?utf-8?B?UU4zNklqSnA1d2tGU1FSM2xzWk12a0xZTFRlTXBYOHRmeFg2VFRuc3ozYTZY?=
 =?utf-8?B?cHlBeHB4VWpLcHErMVlGM1BQU2hjd1ZCTXVjR0tySHhOZ293MEhDRlJ5VDg0?=
 =?utf-8?B?WTd0WER4LzNrZ1dzSkdaU3p1dVlVYS8xNlNGMHhhbUZHVTJyWlAyUlFTR3Az?=
 =?utf-8?B?OTJDc0xDYk1OQTFWcG9rcWVYNHg3WDMxbFk1UVJITUk3c1VSdklzemdOQytw?=
 =?utf-8?B?WERyVWZzd3ZjWE1raW5udERERDU2Q3RDSUNXdFcxb0p4WTArZUhNNEtSb0px?=
 =?utf-8?B?NDZsbnpRMUgvYUZDNHlkRCt3dk1UanEzM3ZZNUNRWElTR0FuWkxhT0g1USta?=
 =?utf-8?B?NmdlSzBSWnhET2MzK1RzZGV3eEVvU0RBb0d0MXVFVnkyMGNPdzFkV2YveWRS?=
 =?utf-8?B?KzRUZC80YXhVMkptNDBubmxzRXVvbjBUMjIrRTZNU25DMWV2TkZkTjh2dDEy?=
 =?utf-8?B?RFgwVG9ud3NlbHdIUEFaV3ZpeTdLbmIxSXVBU0Y1a1RQMHhFVi9wbm56dTJW?=
 =?utf-8?B?d3M3L1EvOTJvL1JvRGNFaGN6TjJ5ZFRvK0RJVTJPdEZaZExLNWt6L1p1TGlM?=
 =?utf-8?B?Z2VDY0syTm5naXkxOXNibUt3b0JHZmtUd09LakR3b3dRTVVvQ1h4NGNsaHFm?=
 =?utf-8?B?dndQbXh4a2ljWjR6MlIwRmk5bXBnejRwQm9kajZGakZuSU1OTDBJRng4ZFJ6?=
 =?utf-8?B?TDhMRFlvMEVqOWlXRG1BTGtCdVJXZ093YlNyODZmZzZGVkpOd0FyVzBBWTlu?=
 =?utf-8?B?RFFzNjcvVTlhUnYxZCtVeDlhbkh5SnBFQ21ienVjWk9UMHBvRHVtUUU0RGVS?=
 =?utf-8?B?Z3BFQWpGeW1Da0FjVGZtN0VxcWhESk1ka2xTUkh3cUtTdkFKbS9Ha2VxZita?=
 =?utf-8?B?dFk5OGZzcS9FOXY3R3FYUUIvUG1TMXJ0cU9LNitqNENNMWppU09BdFB1WE9B?=
 =?utf-8?B?eG9WejU5SmVPOHNCK0VCRUdJcVFpY1BlMUZqc00yZWtKWHhFYnNjdGhTK1hp?=
 =?utf-8?B?dC9PelZsODE3RlQ1cmc1SDROOUVRK0t4ejZvZDhlWk00dmdmL29UUWQyRDBU?=
 =?utf-8?B?cGlwbWJCaWlGZ1QzRlVQWGo0YVlqemF4OVpNSVdHeXJ4SVNqdHozOG94aVNE?=
 =?utf-8?B?aWpia29nUFVRMzBaQWNqTGhuUG5hTXZNNU5laEpGcUhDdzY4WDZjM3pjaFZx?=
 =?utf-8?Q?Zn6sdJnJTmt18pgIIJ4oNe9D9AhXHOKa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVZDc040QnZoc0tqZW44KzZzYXlqVksyd3VITjVlQlZGMWFpOGhEaXYwWFdr?=
 =?utf-8?B?RmRwWkpMS0FWS1lzR3AwekphOHV3SEpkT2Y3bDdZdG9jVTVOeTNxcDNCOHJk?=
 =?utf-8?B?dldmTUQ4Qmc5Mkx2QVVsODN1SUltRVpSV2ZaN0RNdWFYS3lFb3lpK0lPN0Vr?=
 =?utf-8?B?OFZEV28xVENvRnBvUkFwc01CWFM5OTNaRXNESU9HeFltbWF5MUQwRkJ6eC9V?=
 =?utf-8?B?c1gxMXFnTlI3aVc1SlA5dUkvUGU0SGdqR1Z6K2FPbEo4RXBOQStsUmwxaUU3?=
 =?utf-8?B?STFQeFRsZzFBNjliU0tMbUVnZlV4RmQzeGc3VVZ6MlJwcnR6U0NUdE1qU1ZZ?=
 =?utf-8?B?MzFLeEszRGNKMm8wMXQrQngvS0pibjFzK1ZmTjVmRFVua2FXMFR0blFTaUh0?=
 =?utf-8?B?Y3MwdjFqUXlWb1RBZW5GS1dERUk0c2V4SW8vckQ5TTBicE9xSXVIei9hTmg2?=
 =?utf-8?B?Nll3OHdpcnF1c2xVVldVL3lyZnljaVFUazlmRkxGYlFQOUovaHFaWVBZS3FK?=
 =?utf-8?B?TWtSU0ZRUnhvV0dZbUNxNXFPZnRSK1lSNEQ1MzVmOGpDekEzakZ5WHl5dm9U?=
 =?utf-8?B?SUxVVFB0QmxhQTNnSHh2TnZvaHpBR2RFajRuMzc0Mkx1cDZRRm1XbWRHdGdL?=
 =?utf-8?B?MURKamMwbG5KcllibzJnMXZUTWVPYm9VZjJiYlBHSkw4dW45TFU4d0pEZVY4?=
 =?utf-8?B?VDZBZWQxTUhEN2tpMUJyTUpzUmZXaDZhdnhaYUJUWUgwVThWQ1RaZU9NbW9E?=
 =?utf-8?B?QW9heG1PakJMbzR5Z1pLMGltbVg0dW1wUXdNR2wxUktDZEFHc2ZGNzA2WHZa?=
 =?utf-8?B?WG9TVnMzY01kRmQzbkJ3QU1zSEJ5STJtcVNBaWpvSzUrTUkxczA3ZmhsMU5o?=
 =?utf-8?B?eDlCZXBVSmZ0cE53Zkp3ZDBabFc5K0dUTm8yWU9vYXhhTVdZTGlxOXlMK0xi?=
 =?utf-8?B?RHNxYTAvYkRnNmVQUjR2cmVmTkVVdldjbXRDTEk4Q3dkdkZyZkEvaTc2dDlv?=
 =?utf-8?B?cHhmTmgrVnhaS2pwc0NIOTVsclN2V0V3YXJMVmF3R2p1YzVsdmx0V3VNR1BE?=
 =?utf-8?B?d1hxQUs3TS9WbjN6T2RSc1h3WjRLRjdLODRuQSsrWjlWZVhHRmZrQTcyZE9R?=
 =?utf-8?B?S0pQR29qK0J5TWQ5ODdmZnl5cEIvRHoyMFdWSlJWOSs0ZUdMdXozdEd5U2Vj?=
 =?utf-8?B?dW12NVk1eGttTXlIcWlaOG1hUHYyTXpDRVZSK3lmTEgyYSsySDhKS1IwWlJS?=
 =?utf-8?B?S0xnTXpiN1A1citHOTR6a1JLM1Fwa2ZpNzdkTEVsL00weTdxVzlpY2hyOVQr?=
 =?utf-8?B?a2QzS1dwUlg2YUdHeFhCdGpnYUY4RHNySFFQcTJ5YzVnRmg3WktaOTFCS3hM?=
 =?utf-8?B?TEtRYVBnVnBjRnVQU1pQbmNwNTRJUUp3MWRXeXN0NnoxTFpQZDZzTWJuQTll?=
 =?utf-8?B?M2prTlhxajZmMWY2VjVVNTdHRDlDcHo5bkhpSmVyamorb0dHbkFoNEtsL1FB?=
 =?utf-8?B?TTdsQlphWGJJOXBldHRPY1VZcUhqYjBKei9LY0l5d3UwN052WWFZR3Vwc2tP?=
 =?utf-8?B?dVZRSjhZMGpPS0F0T0oyZHp3NjhsWFVlbHFVMi85Q0V6UFZ5K3FUamxuamxw?=
 =?utf-8?B?RnhsbU1Ba3FTc1E4dkRmL1ZaeGhTVzNqelplaElLZDNzZlVsZUpPT2o4Tndu?=
 =?utf-8?B?Wmp0ais2bzBWK3VyNmFuVlgzelV3ZHFFMnFTaXFQS0NJNWRJTXZGLy8zcWdB?=
 =?utf-8?B?N2dUUUtnd2RPNXUzaU5JNGZ6YmxzWTlMQ1VnM2hYYUt2YkxncmtlazlrSjFE?=
 =?utf-8?B?ZDJWQllnd2g0TW5SeUFGcWxyR3Q1NXFoWHpIQlVwTzJreGY0anJDWVR3WnY0?=
 =?utf-8?B?RVZkSlVuSWFNdFVrQUtyYkNpMnM3ZjZ2QTN6bEg0Ui9IZjBiakx6ekRFNDkw?=
 =?utf-8?B?WmE4a2VRbXFzQ1BNK1ZSWnFMVDZXcVpWM3ZJSVhsTXJuYVdrV3l3Q3lNL0d6?=
 =?utf-8?B?MUJpR0c0d2cweURBY3NLVTVJcXhRVU92YjRzMzZxbWNmNHRkK0ZJeUluazN4?=
 =?utf-8?B?UUF6eXp5K2pRNjArYXg0MkxuOHRzd2pXUVhITVN1NXA4V2l1dU9FdzBhQXcw?=
 =?utf-8?Q?/Q2sVFwLalGoRHVcA0+lsULcU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ba6138-9162-4d10-74ef-08de10d3beeb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 18:57:56.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpbMWuCpBqQufvMfV9N2SYks1jpZHDSLQ0hvoHuBrOX8C4UkGPLFbR8RQRoo9xik
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

On 21 Oct 2025, at 14:28, David Hildenbrand wrote:

> On 21.10.25 17:55, Zi Yan wrote:
>> On 21 Oct 2025, at 11:44, David Hildenbrand wrote:
>>
>>> On 21.10.25 03:23, Zi Yan wrote:
>>>> On 20 Oct 2025, at 19:41, Yang Shi wrote:
>>>>
>>>>> On Mon, Oct 20, 2025 at 12:46=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrot=
e:
>>>>>>
>>>>>> On 17 Oct 2025, at 15:11, Yang Shi wrote:
>>>>>>
>>>>>>> On Wed, Oct 15, 2025 at 8:38=E2=80=AFPM Zi Yan <ziy@nvidia.com> wro=
te:
>>>>>>>>
>>>>>>>> Large block size (LBS) folios cannot be split to order-0 folios bu=
t
>>>>>>>> min_order_for_folio(). Current split fails directly, but that is n=
ot
>>>>>>>> optimal. Split the folio to min_order_for_folio(), so that, after =
split,
>>>>>>>> only the folio containing the poisoned page becomes unusable inste=
ad.
>>>>>>>>
>>>>>>>> For soft offline, do not split the large folio if it cannot be spl=
it to
>>>>>>>> order-0. Since the folio is still accessible from userspace and pr=
emature
>>>>>>>> split might lead to potential performance loss.
>>>>>>>>
>>>>>>>> Suggested-by: Jane Chu <jane.chu@oracle.com>
>>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>>>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>>>>>>>> ---
>>>>>>>>    mm/memory-failure.c | 25 +++++++++++++++++++++----
>>>>>>>>    1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>>>>> index f698df156bf8..443df9581c24 100644
>>>>>>>> --- a/mm/memory-failure.c
>>>>>>>> +++ b/mm/memory-failure.c
>>>>>>>> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned lo=
ng pfn, struct page *p,
>>>>>>>>     * there is still more to do, hence the page refcount we took e=
arlier
>>>>>>>>     * is still needed.
>>>>>>>>     */
>>>>>>>> -static int try_to_split_thp_page(struct page *page, bool release)
>>>>>>>> +static int try_to_split_thp_page(struct page *page, unsigned int =
new_order,
>>>>>>>> +               bool release)
>>>>>>>>    {
>>>>>>>>           int ret;
>>>>>>>>
>>>>>>>>           lock_page(page);
>>>>>>>> -       ret =3D split_huge_page(page);
>>>>>>>> +       ret =3D split_huge_page_to_list_to_order(page, NULL, new_o=
rder);
>>>>>>>>           unlock_page(page);
>>>>>>>>
>>>>>>>>           if (ret && release)
>>>>>>>> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int fl=
ags)
>>>>>>>>           folio_unlock(folio);
>>>>>>>>
>>>>>>>>           if (folio_test_large(folio)) {
>>>>>>>> +               int new_order =3D min_order_for_split(folio);
>>>>>>>>                   /*
>>>>>>>>                    * The flag must be set after the refcount is bu=
mped
>>>>>>>>                    * otherwise it may race with THP split.
>>>>>>>> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int f=
lags)
>>>>>>>>                    * page is a valid handlable page.
>>>>>>>>                    */
>>>>>>>>                   folio_set_has_hwpoisoned(folio);
>>>>>>>> -               if (try_to_split_thp_page(p, false) < 0) {
>>>>>>>> +               /*
>>>>>>>> +                * If the folio cannot be split to order-0, kill t=
he process,
>>>>>>>> +                * but split the folio anyway to minimize the amou=
nt of unusable
>>>>>>>> +                * pages.
>>>>>>>> +                */
>>>>>>>> +               if (try_to_split_thp_page(p, new_order, false) || =
new_order) {
>>>>>>>
>>>>>>> folio split will clear PG_has_hwpoisoned flag. It is ok for splitti=
ng
>>>>>>> to order-0 folios because the PG_hwpoisoned flag is set on the
>>>>>>> poisoned page. But if you split the folio to some smaller order lar=
ge
>>>>>>> folios, it seems you need to keep PG_has_hwpoisoned flag on the
>>>>>>> poisoned folio.
>>>>>>
>>>>>> OK, this means all pages in a folio with folio_test_has_hwpoisoned()=
 should be
>>>>>> checked to be able to set after-split folio's flag properly. Current=
 folio
>>>>>> split code does not do that. I am thinking about whether that causes=
 any
>>>>>> issue. Probably not, because:
>>>>>>
>>>>>> 1. before Patch 1 is applied, large after-split folios are already c=
ausing
>>>>>> a warning in memory_failure(). That kinda masks this issue.
>>>>>> 2. after Patch 1 is applied, no large after-split folios will appear=
,
>>>>>> since the split will fail.
>>>>>
>>>>> I'm a little bit confused. Didn't this patch split large folio to
>>>>> new-order-large-folio (new order is min order)? So this patch had
>>>>> code:
>>>>> if (try_to_split_thp_page(p, new_order, false) || new_order) {
>>>>
>>>> Yes, but this is Patch 2 in this series. Patch 1 is
>>>> "mm/huge_memory: do not change split_huge_page*() target order silentl=
y."
>>>> and sent separately as a hotfix[1].
>>>
>>> I'm confused now as well. I'd like to review, will there be a v3 that o=
nly contains patch #2+#3?
>>
>> Yes. The new V3 will have 3 patches:
>> 1. a new patch addresses Yang=E2=80=99s concern on setting has_hwpoisone=
d on after-split
>> large folios.
>> 2. patch#2,
>> 3. patch#3.
>
> Okay, I'll wait with the review until you resend :)
>
>>
>> The plan is to send them out once patch 1 is upstreamed. Let me know if =
you think
>> it is OK to send them out earlier as Andrew already picked up patch 1.
>
> It's in mm/mm-new + mm/mm-unstable, AFAIKT. So sure, send it against one =
of the tress (I prefer mm-unstable but usually we should target mm-new).

Sure.
>
>>
>> I also would like to get some feedback on my approach to setting has_hwp=
oisoned:
>>
>> folio's has_hwpoisoned flag needs to be preserved
>> like what Yang described above. My current plan is to move
>> folio_clear_has_hwpoisoned(folio) into __split_folio_to_order() and
>> scan every page in the folio if the folio's has_hwpoisoned is set.
>
> Oh, that's nasty indeed ... will have to think about that a bit.
>
> Maybe we can keep it simple and always set folio_set_has_hwpoisoned() on =
all split folios? Essentially turning it into a "maybe_has" semantics.
>
> IIUC, the existing folio_stest_has_hwpoisoned users can deal with that?

folio_test_has_hwpoisoned() direct users are fine. They are shmem.c
and memory.c, where the former would copy data in PAGE_SIZE instead of foli=
o size
and the latter would not install PMD entry for the folio (impossible to hit
this until we have > PMD mTHPs and split them to PMD THPs).

The caller of folio_contain_hwpoisoned_page(), which calls
folio_test_has_hwpoisoned(), would have issues:

1. shmem_write_begin() in shmem.c: it returns -EIO for shmem writes.
2. thp_underused() in huge_memory.c: it does not scan the folio.
3. shrink_folio_list() in vmscan.c: it does not reclaim large hwpoisoned fo=
lios.
4. do_migrate_range() in memory_hotplug.c: it skips the large hwpoisoned fo=
lios.

These behaviors are fine for folios truly containing hwpoisoned pages,
but might not be desirable for false positive cases. A scan to make sure
hwpoisoned pages are indeed present is inevitable. Rather than making
all callers to do the scan, scanning at split time might be better, IMHO.

Let me send a patchset with scanning at split time. Hopefully, more people
can chime in to provide feedbacks.


--
Best Regards,
Yan, Zi

