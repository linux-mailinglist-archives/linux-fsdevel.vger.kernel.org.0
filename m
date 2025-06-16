Return-Path: <linux-fsdevel+bounces-51741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EAADAFB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF7517411D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC92E06C3;
	Mon, 16 Jun 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eqym4SFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32799285CA6;
	Mon, 16 Jun 2025 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075179; cv=fail; b=cE2Cr/AhRiO19tTlG+42Z7I/QqAIcV601P+fnu0nKxDh155erQxjUnGgxz8VyGJRe+nA2oQaPMYaTJ+DRkS4RVT7nKi/BLu9UklqVjGFRAgbMqCg0RsUwYsybZjfSgMFwVsgmCKDWHXRdW/u16U1LLJgz8G3vDJygSObvlgyoVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075179; c=relaxed/simple;
	bh=Z2enslmp7jw5+ifS6LY3rfblIKpG22Oms7CRtLMz5SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OjjigCeeFuTnP/gh/TTYJZyCtP8MFBnMmTQ6YuPyRTs1A1Pj774Vu68j2AmGFLyIBp5fvjiJP5hpeY1eS9H1JySiN/FDRVSlqz1Uu3wtKh0AzbQJrmVmES/XIvjbWOIFADDJxXfoPWh35cFWw8HyiZeBkJ5iSV9wGs+gE9+YOgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eqym4SFz; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx35Q2y0N811Qn6of0oo5d7VQNQMM9+B1mwNlHaVD+y6KrO8YCafDpLloU2rUNQGEMDBozclEReoRhpD99yzeMZ1EyzEaM+U5bwKGy/fix01IoE+6+LZVueYPWOGVJ6I0eSIpEPKGN43rYt9Q2iSzTbZIcjDFt6rMXjPit5SCM5Zrtrk+ibrtZtiszkHfaocwOeW0kevi+lTHqePvADGxnGC8Q0zPvR6GLfahRYwykV62Oihb46AeZX8ZfBCVmuvt+/hb4lmSreBNGGZeklvuD6zrnw5Y6SQblGL1cZas4xijrOnz7bYMXcF+LqOXIQwX3PcudYWrNfrcvc6qiubBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0mC7+GlalJghBqb/o7whqEQmBIqkXFeoPyhV+5x4Gc=;
 b=To1Yz4sWG2nnzP5IQjBOTsz8uBzmCy7qvMOW/rVU8Q5Z0VDjKVFGQroNzAzlMDshYCqjA1ZZMmYlM6uY0Mucyw3o847BMlMfTs4pyG/dWhFIAQtgjgNvUWEpxInlqXGkfSQjvjh9ZGzvb6FDLaNtEv85BppXAHcB6MG4HdHDsrZhx0na5u5r01pGMw35ymhfkeMnxCKcRwXueGs9MTsh5XGVsSIqm/8/oD5Jztu0F2deuEk7v/8yhAADW6Y+FarTeV5W4l4wJlbdnW0HtstZlgDATaHLhIzDyLCTPMBeqbhyXb8a/aoIJTX3XfIbtO0pRcHxcTZf+ZvbyK3Mf2GuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0mC7+GlalJghBqb/o7whqEQmBIqkXFeoPyhV+5x4Gc=;
 b=eqym4SFzweX4QvJh3a0U4U8+Uf5m5FrVmvJhe9wVMXs+SrOKelNKx3bus+LIWZz/eHNkQ9nOXe2+MRkXxlKCxuoFsVztnNNLhghDHgErod3u+Kar3+VPCvvc/nx7TzmIFTzJm6oh6WOC/AoVb4FuUCPAbzqIPLWiOnD8VK9qZE3MAloh9lufzAU9xSeCfxhJzFrUsv2MJXLL+nZcFhzpdQ4Q9tjhmi2ZOlm/BJXRPniXpD4qEh5ftTbg1j1HR7PiJB33y2ts4SYDOnt2xuqFz1uZt2XnGIDSbFieBHVjWL/L0NGtqpR1uarfLt32X0RoDTVYRC79CdA9y917AtEkyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:59:31 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:59:31 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com,
	Will Deacon <will@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 11/14] mm: Remove devmap related functions and page table bits
Date: Mon, 16 Jun 2025 21:58:13 +1000
Message-ID: <bf6221bf1e3a290845417a60c27cf301203fd99c.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0133.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::17) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: bf876571-1e7a-4ac0-f33e-08ddaccd409b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REJDTm5PSGtkRUxrbUhpbzR4VithZmRFZ2swMXdSVVNhdVdUQ3J4dGFhNmZB?=
 =?utf-8?B?QVNnQUtyVWpLWXVQZXk2Nk1FVDVmTjZmUXFXR2VzZ0h6a3EzU0trVmVGWWhh?=
 =?utf-8?B?SEFKK01FTWM3eTF3VTF5QTdTVmpGS29SOVdQOVNraEt5eGFqNFAyRU9BcG5t?=
 =?utf-8?B?YkpEQUEybGdTY3p4R1NmTXN1SWhPNXNjN3JRZGNvbElEeVdHcjN5ZEg4Qnk4?=
 =?utf-8?B?N2hjTm5KSEJwbUZIV3B2UVNGamZ0VVN2UmJBTUR5d1licVJER3B3Q1ZyWTRO?=
 =?utf-8?B?d1RJN2VHRW12aWpVUUg3SmN5V3h0UXJGdFZRUEtQMVl3TWhKT3RUSFFtNlZ3?=
 =?utf-8?B?RFlzd2I3NU9xWjM3aGc5aVc2SldJZ3RIeS94TEJueG1hZG9aWWV5eEpVSVpZ?=
 =?utf-8?B?YVMzbHhheEJGVElycG5QOE0wMWZQemhTYkdoc01Mam0vWE1GV1drT1RtVmx4?=
 =?utf-8?B?YmNnd2R4dlZBUFhLb08yaUJRWlFHU1lBUzZYU0ZkdlF2bFZvQjdrK1J5Mk5U?=
 =?utf-8?B?MU1qV0w1RndBMElwNjBNeStrSlRPTlM5dEg5dFFFamRSN1JseXhweER2NzlQ?=
 =?utf-8?B?eGYwK0JibzdtUU51d0Yrc1RJbTRodVNtU0ZOWTNmQ3dPN3Y1aThzSExjYjVC?=
 =?utf-8?B?ZTlzRUpiMlFLYUFkOU9ZU0xBYnVUTmx5WkpMVmloakxUNWsxVGdvWGwrVEYw?=
 =?utf-8?B?SnpRZEs1UWg1YzQ5RHEycEU4YkxuUWJxU0h5all0K04wY0tVUVhBdVZTb1pV?=
 =?utf-8?B?UUlmU1dIVlEyVVRaOHBBWVZFaThpRWdxTWhnQmlXWFlxNFZCZWdpTTFRZ3ZI?=
 =?utf-8?B?MTBEeGpRU0VFYmdLQVJ3MUdmUlRVSE5SdFBwL3RmTW9DZlJtNE5yZStrZnVV?=
 =?utf-8?B?YzhFaHp4UVdvS080ejVBMDFIYmJ6aGJ3RjFQNWxsQ2hEL01jTFlEcUJnSUNk?=
 =?utf-8?B?a1MvUGMydmZLT0U4MWNVKzZSYXp4SWJKUVNnc1lncU9jQVgxK2QyZW8zeWpR?=
 =?utf-8?B?VG9kaUMrRnFWcWR5cHliZ1loclYzVElzOVo1U0Mvb0NrZWlwSnF4VjNleXM5?=
 =?utf-8?B?T0lNRWxPZkdoTDVoMWdTNGdLdGdVd3luenJhaWJvU3pZL1ppUGRSOWNpWFI2?=
 =?utf-8?B?QitmN09BSVZ6MWRjMGx6MTl5bXJnaG9ma3ZFNjM5cEhKaGJuTmdRWklCTThu?=
 =?utf-8?B?N2V1eXRFb2w1aEt3dkJYZlgxVWFNeFkzdFZRQmc4N1B3OW81LzVhMnRISE9B?=
 =?utf-8?B?K2hCTEYwbDYrdVQvR3laRXhPcStPMG9hTEt3UDJJMWhlbW5pU1dFL0ZSRmxB?=
 =?utf-8?B?dVY5bkg3OHowUThKUVVpdXlaeFJuRm5DT3Q4YVVGS25PRU9mVHRSUFZZdGwr?=
 =?utf-8?B?eFE5WDJ1REdOVXlSK3FxYUdTZkU3K0h4a2k1Q21pRGhBZGxWUUdMVlBwZE1X?=
 =?utf-8?B?UTlSa2ZuTHVReVZoeFp5TmZXV1l6M1Ribk03TmZ5NHFSM3VPL2RCeXc0SWhK?=
 =?utf-8?B?Sy9sbk5DdDFSWkgvTVhadXY2ZENhWXhma0RDeFJsU1p2U2g5NkxCcG9kK2ZF?=
 =?utf-8?B?cVdzcHpsMDZFRWQ5V2J4M2dTa1o2ZVlpbThHVjhEUEdjRGVlZG5IUVpzSkhw?=
 =?utf-8?B?ekUwQng0TTdtcnAyYi9tWFU1TFdCTVovWnMvT0t3cUtsNkp1ak9HeVJXb2FV?=
 =?utf-8?B?RTFRWkhadUhzU0d3ZmYrYldoeFAreW5pWG04Y1FrRTU3OEJyQ1o0Z3RnUUQ2?=
 =?utf-8?B?VFpvM0hJNzlwajdvaDdIU1BNWVV5RXJ2VnFkQnVsOUpjaUlJVlZSbXF3WUhE?=
 =?utf-8?B?bGo5MWlwNllUWGlZcGdUY2NuR0tzTVc5dXBBdmxvYkM5bloycVh6c2lqUk5K?=
 =?utf-8?B?RVE2bVEyVnI0Sll0WDJsZU1jdThqMCs2TlM2bUdGeEJsQnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2NSRE9KV1FaZ0NLa0s5RGI3aWx3NVQ5NjNSL0VaRlR4RzljQmlzTEpBSFlT?=
 =?utf-8?B?aDJWVzJSUFlhejJGbHRrWVV1aUlUd2xnZDlNTkF4amMxSUQwdzVnTEhBQ1dK?=
 =?utf-8?B?TEQ0cmJyaS83ZG5LK0NXVW9NS2VwRWVWcVRDUlQvT3FzTlBRVjVVbkhTVzJO?=
 =?utf-8?B?ekdxQ3VZR1lqSnFNY2FKTCtzQXNRaWt0dTNsRUlFTHNKaDZSbHgrMWI1RWFw?=
 =?utf-8?B?SFcxN2hUYWtnRHh3bnk3NkFmSEluSTh4VTQzbGM4OGpCcWpRMW5TUU93b0JG?=
 =?utf-8?B?czN0WEh0KzNaU1B3Q011MHhIYzBhc3ZPTExOMjBCNHlzampURzI0QnhWNm84?=
 =?utf-8?B?NWJsY3hWaVhHVnovRm9KMStkdWtIanN4OStndW5WeDRLblp3Mk82K250VHFa?=
 =?utf-8?B?SnVHT3B4K3hpZVZRQ2dHRzE5U2N4V0dYMnpLT2JGZ05ETDdoV28xMmdQZlR2?=
 =?utf-8?B?RnZYY1dydG5nTWtSMkVnQmhUZHpSWEJKT0JmV1hKZGtxYUpGTEh1OFQ1RVlX?=
 =?utf-8?B?d3B1UzJwZC91NkZjVlYrRnYrZ2tNU0Z2S2xHdWI2Vzc2Ni9QZHZUV2IvNWx0?=
 =?utf-8?B?ZjVXSzhWWEVFRDB5cDlzNWdIRG1ZVi9haTZNeEFKMlpIRlNIdk03TUJXdUZW?=
 =?utf-8?B?NkMzVGFjZ21TOXpQQStiR0xNV1BUSG9zSXp0TEo1WVpFTXhtazZLa1NVcXZS?=
 =?utf-8?B?b2hpdlVLaXpJZUpqWGVsN21GNENIdWJIRExiVkMyYzRCYmFQZW5Rd0w5YkhK?=
 =?utf-8?B?R1FRTk9LK3NrL04zdU9lTmFKcCtkR1dsR2RlV1R0MUtUNzBCWjI2YjBsUjA5?=
 =?utf-8?B?VEd2YWNnRHE0cFJ6cVMvamFkNCs0aldGY2labURsTWN4eFZFT01lcFE5c1Vh?=
 =?utf-8?B?ZGsxL2I0UHJGNlhRQkcyVTNhOG9pNlFRNDEzMFFoR1FWNDkwbWtkMFVZcWNq?=
 =?utf-8?B?enV4T0pzYzZqMnpYbEN0UTZlYmIxY0lHYys5Q3Y1Q3JCWmtkTjEybFA3QzVt?=
 =?utf-8?B?UjZoa2MyVWVDUlpUZ2VvQzhwL2lPSEg0SDN3OFNWalVDdFNIaUlIWWg1T1Rj?=
 =?utf-8?B?ODVtTjJOcUhIS2kwRGpFMUxRYVQvVGpPVUQ5ek9tcjh5emhUUFlkOGIyaFFq?=
 =?utf-8?B?MzZSd1g5dkZZNzR4TzBRZURkM2V6S2NzbEF4OC9hWDZSNG0rVnl4TENKNG5o?=
 =?utf-8?B?TnNHNkR3dEczVEZ1dWdybnNBNVpXV0VXWmJCZFh0bHRKZCtvSmQyYm53cVdP?=
 =?utf-8?B?ckdQZGptRjFpdmswdVJEeVR1TWxxeXpOQnBTN1pGZnRNMzN5Nk1OTm84MkhB?=
 =?utf-8?B?bWYxVVVkMUEyKzlmZmRPNFdWajlJbExPazRZSXNTVTF3V2FPTHAxWFhVUFlQ?=
 =?utf-8?B?cURVYlUzdWZEeVRJWjZNOFl3eW9xNWd0RUhMSkEwZE9mcFh3SjViaU5mT3M4?=
 =?utf-8?B?Y2ZUTWJMdFEwMDIzWndKNEVuMGhxUUZ0ckZ1anlGZHhOU2RBMjZ0Tno5SWU4?=
 =?utf-8?B?SnpBMEo3SUpyTGNnbS9FMkg1UmhKTUdCK0J6SllVSEhCVGVva1RNUjh4MHVo?=
 =?utf-8?B?TEVjOGQrTWV5b0xjVzBPQVREVExuR2FRR051QWU1QkR3U0FQK3AxdE55d2xJ?=
 =?utf-8?B?RnZtV0t6TUptVGtmOGFxQ1R4QldXOFNuVlFtNFlJU3JyK0NMOS9xQXdKaWFH?=
 =?utf-8?B?cnVrMnoremI2ME9PYk5EUDIvZ1hKRzNDZlNqdllZTUErT3BpQnJWL1FvYzdE?=
 =?utf-8?B?QlQyNlFmY0VMRGcwZ2YrMzhMK3pPbDBWbHRzRWtUMENGSWtjUWZtMHVCa0s2?=
 =?utf-8?B?Sng3OVh2cGN0eU5iK0htZHFySmJ6Szh5RGYzTlAvcEJwME9ENTZrOXltUTlD?=
 =?utf-8?B?SXNGZlpHREJJa1drUHhSUHJjelJyWm4yYWViYWZIYXlYYWlJYkszUHhiMmpw?=
 =?utf-8?B?RzE0c2FFdHV2R095c29ZdWxzSlZGZDdKY2ZHSjZhanFpYnY2STUxRC85Y0Yy?=
 =?utf-8?B?VzNKMkl3UDBiaE81WU92c3NKMWlPOW5FbEQ0VTR2TDk3VzIzVlYrN3pkbHZO?=
 =?utf-8?B?UHBLUkxKbDVpdSt5VmVxcnJOejJkY1pUdWtqSEdIbVdrcExobVVLZFRFVTg0?=
 =?utf-8?Q?4Sst+5h2o43tEGkUsxhgGgTcZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf876571-1e7a-4ac0-f33e-08ddaccd409b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:59:31.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoXSaADUzSy/JhYi2LQfePQVvc+hWQ7wiZXCdTxD0gDWVi7FMiTS81yxwyiSTfbXyp73EjykIldVeBNUkS3rzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

Now that DAX and all other reference counts to ZONE_DEVICE pages are
managed normally there is no need for the special devmap PTE/PMD/PUD
page table bits. So drop all references to these, freeing up a
software defined page table bit on architectures supporting it.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Will Deacon <will@kernel.org> # arm64
Suggested-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/mm/arch_pgtable_helpers.rst     |  6 +--
 arch/arm64/Kconfig                            |  1 +-
 arch/arm64/include/asm/pgtable-prot.h         |  1 +-
 arch/arm64/include/asm/pgtable.h              | 24 +--------
 arch/loongarch/Kconfig                        |  1 +-
 arch/loongarch/include/asm/pgtable-bits.h     |  6 +--
 arch/loongarch/include/asm/pgtable.h          | 19 +------
 arch/powerpc/Kconfig                          |  1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  6 +--
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  7 +--
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 53 +------------------
 arch/powerpc/include/asm/book3s/64/radix.h    | 14 +-----
 arch/riscv/Kconfig                            |  1 +-
 arch/riscv/include/asm/pgtable-64.h           | 16 +-----
 arch/riscv/include/asm/pgtable-bits.h         |  1 +-
 arch/riscv/include/asm/pgtable.h              | 17 +------
 arch/x86/Kconfig                              |  1 +-
 arch/x86/include/asm/pgtable.h                | 51 +-----------------
 arch/x86/include/asm/pgtable_types.h          |  5 +--
 include/linux/mm.h                            |  7 +--
 include/linux/pfn_t.h                         | 20 +-------
 include/linux/pgtable.h                       | 19 +------
 mm/Kconfig                                    |  4 +-
 mm/debug_vm_pgtable.c                         | 59 +--------------------
 mm/hmm.c                                      |  3 +-
 mm/madvise.c                                  |  8 +--
 26 files changed, 17 insertions(+), 334 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index af24516..c88c7fa 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -30,8 +30,6 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_protnone              | Tests a PROT_NONE PTE                            |
 +---------------------------+--------------------------------------------------+
-| pte_devmap                | Tests a ZONE_DEVICE mapped PTE                   |
-+---------------------------+--------------------------------------------------+
 | pte_soft_dirty            | Tests a soft dirty PTE                           |
 +---------------------------+--------------------------------------------------+
 | pte_swp_soft_dirty        | Tests a soft dirty swapped PTE                   |
@@ -104,8 +102,6 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_protnone              | Tests a PROT_NONE PMD                            |
 +---------------------------+--------------------------------------------------+
-| pmd_devmap                | Tests a ZONE_DEVICE mapped PMD                   |
-+---------------------------+--------------------------------------------------+
 | pmd_soft_dirty            | Tests a soft dirty PMD                           |
 +---------------------------+--------------------------------------------------+
 | pmd_swp_soft_dirty        | Tests a soft dirty swapped PMD                   |
@@ -177,8 +173,6 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_write                 | Tests a writable PUD                             |
 +---------------------------+--------------------------------------------------+
-| pud_devmap                | Tests a ZONE_DEVICE mapped PUD                   |
-+---------------------------+--------------------------------------------------+
 | pud_mkyoung               | Creates a young PUD                              |
 +---------------------------+--------------------------------------------------+
 | pud_mkold                 | Creates an old PUD                               |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 55fc331..94b48b1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -44,7 +44,6 @@ config ARM64
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTDUMP
-	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_SETUP_DMA_OPS
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 7830d03..85dceb1 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -17,7 +17,6 @@
 #define PTE_SWP_EXCLUSIVE	(_AT(pteval_t, 1) << 2)	 /* only for swp ptes */
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
-#define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 
 /*
  * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e511f90..ba63c87 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -190,7 +190,6 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_user(pte)		(!!(pte_val(pte) & PTE_USER))
 #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
 #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
-#define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
 #define pte_tagged(pte)		((pte_val(pte) & PTE_ATTRINDX_MASK) == \
 				 PTE_ATTRINDX(MT_NORMAL_TAGGED))
 
@@ -372,11 +371,6 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
-}
-
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
@@ -653,14 +647,6 @@ static inline pmd_t pmd_mkhuge(pmd_t pmd)
 	return __pmd((pmd_val(pmd) & ~mask) | val);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
-#endif
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
-}
-
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 #define pmd_special(pte)	(!!((pmd_val(pte) & PTE_SPECIAL)))
 static inline pmd_t pmd_mkspecial(pmd_t pmd)
@@ -1302,16 +1288,6 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 	return __ptep_set_access_flags(vma, address, (pte_t *)pmdp,
 							pmd_pte(entry), dirty);
 }
-
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PAGE_TABLE_CHECK
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4b19f93..edb3db2 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -25,7 +25,6 @@ config LOONGARCH
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PREEMPT_LAZY
-	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index 45bfc65..c8777a9 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -22,7 +22,6 @@
 #define	_PAGE_PFN_SHIFT		12
 #define	_PAGE_SWP_EXCLUSIVE_SHIFT 23
 #define	_PAGE_PFN_END_SHIFT	48
-#define	_PAGE_DEVMAP_SHIFT	59
 #define	_PAGE_PRESENT_INVALID_SHIFT 60
 #define	_PAGE_NO_READ_SHIFT	61
 #define	_PAGE_NO_EXEC_SHIFT	62
@@ -36,7 +35,6 @@
 #define _PAGE_MODIFIED		(_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
 #define _PAGE_PROTNONE		(_ULCAST_(1) << _PAGE_PROTNONE_SHIFT)
 #define _PAGE_SPECIAL		(_ULCAST_(1) << _PAGE_SPECIAL_SHIFT)
-#define _PAGE_DEVMAP		(_ULCAST_(1) << _PAGE_DEVMAP_SHIFT)
 
 /* We borrow bit 23 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	(_ULCAST_(1) << _PAGE_SWP_EXCLUSIVE_SHIFT)
@@ -76,8 +74,8 @@
 #define __READABLE	(_PAGE_VALID)
 #define __WRITEABLE	(_PAGE_DIRTY | _PAGE_WRITE)
 
-#define _PAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PAGE_DEVMAP | _PFN_MASK | _CACHE_MASK | _PAGE_PLV)
-#define _HPAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PAGE_DEVMAP | _PFN_MASK | _CACHE_MASK | _PAGE_PLV | _PAGE_HUGE)
+#define _PAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PFN_MASK | _CACHE_MASK | _PAGE_PLV)
+#define _HPAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PFN_MASK | _CACHE_MASK | _PAGE_PLV | _PAGE_HUGE)
 
 #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_NO_READ | \
 				 _PAGE_USER | _CACHE_CC)
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index b301853..40e6e0b 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -409,9 +409,6 @@ static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; 
 static inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |= _PAGE_SPECIAL; return pte; }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
-static inline int pte_devmap(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DEVMAP); }
-static inline pte_t pte_mkdevmap(pte_t pte)	{ pte_val(pte) |= _PAGE_DEVMAP; return pte; }
-
 #define pte_accessible pte_accessible
 static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
 {
@@ -540,17 +537,6 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pmd;
 }
 
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_DEVMAP);
-}
-
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	pmd_val(pmd) |= _PAGE_DEVMAP;
-	return pmd;
-}
-
 static inline struct page *pmd_page(pmd_t pmd)
 {
 	if (pmd_trans_huge(pmd))
@@ -606,11 +592,6 @@ static inline long pmd_protnone(pmd_t pmd)
 #define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
 #define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pud_devmap(pud)		(0)
-#define pgd_devmap(pgd)		(0)
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing
  * constraints placed on us by the cache architecture.
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3e0cc8..7a555c1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -149,7 +149,6 @@ config PPC
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTDUMP
-	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index aa90a04..7132392 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -168,12 +168,6 @@ extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 extern int hash__has_transparent_hugepage(void);
 #endif
 
-static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
-{
-	BUG();
-	return pmd;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0bf6fd0..0fb5b7d 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -259,7 +259,7 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
  */
 static inline int hash__pmd_trans_huge(pmd_t pmd)
 {
-	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DEVMAP)) ==
+	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) ==
 		  (_PAGE_PTE | H_PAGE_THP_HUGE));
 }
 
@@ -281,11 +281,6 @@ extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 extern int hash__has_transparent_hugepage(void);
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) | (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DEVMAP));
-}
-
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index a2ddcbb..c198003 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -88,7 +88,6 @@
 
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
-#define _PAGE_DEVMAP		_RPAGE_SW1 /* software: ZONE_DEVICE page */
 
 /*
  * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
@@ -109,7 +108,7 @@
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
+			 _PAGE_SOFT_DIRTY)
 /*
  * user access blocked by key
  */
@@ -123,7 +122,7 @@
  */
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
+			 _PAGE_SOFT_DIRTY)
 
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
@@ -609,24 +608,6 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_SPECIAL | _PAGE_DEVMAP));
-}
-
-/*
- * This is potentially called with a pmd as the argument, in which case it's not
- * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is set.
- * That's because the bit we use for _PAGE_DEVMAP is not reserved for software
- * use in page directory entries (ie. non-ptes).
- */
-static inline int pte_devmap(pte_t pte)
-{
-	__be64 mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
-
-	return (pte_raw(pte) & mask) == mask;
-}
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	/* FIXME!! check whether this need to be a conditional */
@@ -1379,36 +1360,6 @@ static inline bool arch_needs_pgtable_deposit(void)
 }
 extern void serialize_against_pte_lookup(struct mm_struct *mm);
 
-
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	if (radix_enabled())
-		return radix__pmd_mkdevmap(pmd);
-	return hash__pmd_mkdevmap(pmd);
-}
-
-static inline pud_t pud_mkdevmap(pud_t pud)
-{
-	if (radix_enabled())
-		return radix__pud_mkdevmap(pud);
-	BUG();
-	return pud;
-}
-
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return pte_devmap(pmd_pte(pmd));
-}
-
-static inline int pud_devmap(pud_t pud)
-{
-	return pte_devmap(pud_pte(pud));
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 8f55ff7..df23a82 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -264,7 +264,7 @@ static inline int radix__p4d_bad(p4d_t p4d)
 
 static inline int radix__pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (_PAGE_PTE | _PAGE_DEVMAP)) == _PAGE_PTE;
+	return (pmd_val(pmd) & _PAGE_PTE) == _PAGE_PTE;
 }
 
 static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
@@ -274,7 +274,7 @@ static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
 
 static inline int radix__pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PTE | _PAGE_DEVMAP)) == _PAGE_PTE;
+	return (pud_val(pud) & _PAGE_PTE) == _PAGE_PTE;
 }
 
 static inline pud_t radix__pud_mkhuge(pud_t pud)
@@ -315,16 +315,6 @@ static inline int radix__has_transparent_pud_hugepage(void)
 }
 #endif
 
-static inline pmd_t radix__pmd_mkdevmap(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) | (_PAGE_PTE | _PAGE_DEVMAP));
-}
-
-static inline pud_t radix__pud_mkdevmap(pud_t pud)
-{
-	return __pud(pud_val(pud) | (_PAGE_PTE | _PAGE_DEVMAP));
-}
-
 struct vmem_altmap;
 struct dev_pagemap;
 extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 36061f4..15f5172 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -46,7 +46,6 @@ config RISCV
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
 	select ARCH_HAS_PTDUMP if MMU
-	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 7de05db..1018d22 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -397,24 +397,8 @@ static inline struct page *pgd_page(pgd_t pgd)
 p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pte_devmap(pte_t pte);
 static inline pte_t pmd_pte(pmd_t pmd);
 static inline pte_t pud_pte(pud_t pud);
-
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return pte_devmap(pmd_pte(pmd));
-}
-
-static inline int pud_devmap(pud_t pud)
-{
-	return pte_devmap(pud_pte(pud));
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 
 #endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index a8f5205..179bd4a 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -19,7 +19,6 @@
 #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
 
 #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
-#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 438ce7d..f0a8c95 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -409,13 +409,6 @@ static inline int pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_DEVMAP;
-}
-#endif
-
 /* static inline pte_t pte_rdprotect(pte_t pte) */
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -457,11 +450,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DEVMAP);
-}
-
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	return pte;
@@ -790,11 +778,6 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
 }
 
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
-}
-
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 static inline bool pmd_special(pmd_t pmd)
 {
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 340e546..bdf8816 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -101,7 +101,6 @@ config X86
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PREEMPT_LAZY
-	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 97954c9..e33df3d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -301,16 +301,15 @@ static inline bool pmd_leaf(pmd_t pte)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_leaf */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pmd_val(pmd) & _PAGE_PSE) == _PAGE_PSE;
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline int pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pud_val(pud) & _PAGE_PSE) == _PAGE_PSE;
 }
 #endif
 
@@ -320,24 +319,6 @@ static inline int has_transparent_hugepage(void)
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_DEVMAP);
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static inline int pud_devmap(pud_t pud)
-{
-	return !!(pud_val(pud) & _PAGE_DEVMAP);
-}
-#else
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 static inline bool pmd_special(pmd_t pmd)
 {
@@ -361,12 +342,6 @@ static inline pud_t pud_mkspecial(pud_t pud)
 	return pud_set_flags(pud, _PAGE_SPECIAL);
 }
 #endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline pte_t pte_set_flags(pte_t pte, pteval_t set)
@@ -527,11 +502,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return pte_set_flags(pte, _PAGE_SPECIAL);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return pte_set_flags(pte, _PAGE_SPECIAL|_PAGE_DEVMAP);
-}
-
 /* See comments above mksaveddirty_shift() */
 static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
 {
@@ -603,11 +573,6 @@ static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_DIRTY);
 }
 
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pmd_set_flags(pmd, _PAGE_DEVMAP);
-}
-
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_PSE);
@@ -673,11 +638,6 @@ static inline pud_t pud_mkdirty(pud_t pud)
 	return pud_mksaveddirty(pud);
 }
 
-static inline pud_t pud_mkdevmap(pud_t pud)
-{
-	return pud_set_flags(pud, _PAGE_DEVMAP);
-}
-
 static inline pud_t pud_mkhuge(pud_t pud)
 {
 	return pud_set_flags(pud, _PAGE_PSE);
@@ -1008,13 +968,6 @@ static inline int pte_present(pte_t a)
 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t a)
-{
-	return (pte_flags(a) & _PAGE_DEVMAP) == _PAGE_DEVMAP;
-}
-#endif
-
 #define pte_accessible pte_accessible
 static inline bool pte_accessible(struct mm_struct *mm, pte_t a)
 {
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b74ec5c..f63ae8d 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -34,7 +34,6 @@
 #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_KERNEL_4K	_PAGE_BIT_SOFTW3 /* page must not be converted to large */
-#define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
 #ifdef CONFIG_X86_64
 #define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf) */
@@ -121,11 +120,9 @@
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_NX	(_AT(pteval_t, 1) << _PAGE_BIT_NX)
-#define _PAGE_DEVMAP	(_AT(u64, 1) << _PAGE_BIT_DEVMAP)
 #define _PAGE_SOFTW4	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW4)
 #else
 #define _PAGE_NX	(_AT(pteval_t, 0))
-#define _PAGE_DEVMAP	(_AT(pteval_t, 0))
 #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
@@ -154,7 +151,7 @@
 #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	\
 				 _PAGE_SPECIAL | _PAGE_ACCESSED |	\
 				 _PAGE_DIRTY_BITS | _PAGE_SOFT_DIRTY |	\
-				 _PAGE_DEVMAP | _PAGE_CC | _PAGE_UFFD_WP)
+				 _PAGE_CC | _PAGE_UFFD_WP)
 #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
 #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 912b6d4..7c2f760 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2709,13 +2709,6 @@ static inline pud_t pud_mkspecial(pud_t pud)
 }
 #endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
 
-#ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t pte)
-{
-	return 0;
-}
-#endif
-
 extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 			       spinlock_t **ptl);
 static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 2b0d6e0..2869095 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -94,26 +94,6 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
 #endif
 #endif
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline bool pfn_t_devmap(pfn_t pfn)
-{
-	const u64 flags = PFN_MAP;
-
-	return (pfn.val & flags) == flags;
-}
-#else
-static inline bool pfn_t_devmap(pfn_t pfn)
-{
-	return false;
-}
-pte_t pte_mkdevmap(pte_t pte);
-pmd_t pmd_mkdevmap(pmd_t pmd);
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
-	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
-pud_t pud_mkdevmap(pud_t pud);
-#endif
-#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
-
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 static inline bool pfn_t_special(pfn_t pfn)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 0298e55..1d44394 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1643,21 +1643,6 @@ static inline int pud_write(pud_t pud)
 }
 #endif /* pud_write */
 
-#if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || !defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return 0;
-}
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
-
 #if !defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
 	!defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 static inline int pud_trans_huge(pud_t pud)
@@ -1912,8 +1897,8 @@ typedef unsigned int pgtbl_mod_mask;
  * - It should contain a huge PFN, which points to a huge page larger than
  *   PAGE_SIZE of the platform.  The PFN format isn't important here.
  *
- * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
- *   pXd_devmap(), or hugetlb mappings).
+ * - It should cover all kinds of huge mappings (i.e. pXd_trans_huge()
+ *   or hugetlb mappings).
  */
 #ifndef pgd_leaf
 #define pgd_leaf(x)	false
diff --git a/mm/Kconfig b/mm/Kconfig
index 3b2060a..cb6dfea 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1110,9 +1110,6 @@ config ARCH_HAS_CURRENT_STACK_POINTER
 	  register alias named "current_stack_pointer", this config can be
 	  selected.
 
-config ARCH_HAS_PTE_DEVMAP
-	bool
-
 config ARCH_HAS_ZONE_DMA_SET
 	bool
 
@@ -1130,7 +1127,6 @@ config ZONE_DEVICE
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
 	depends on SPARSEMEM_VMEMMAP
-	depends on ARCH_HAS_PTE_DEVMAP
 	select XARRAY_MULTI
 
 	help
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 7731b23..d84d0c4 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -348,12 +348,6 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	vaddr &= HPAGE_PUD_MASK;
 
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
-	/*
-	 * Some architectures have debug checks to make sure
-	 * huge pud mapping are only found with devmap entries
-	 * For now test with only devmap entries.
-	 */
-	pud = pud_mkdevmap(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
 	pudp_set_wrprotect(args->mm, vaddr, args->pudp);
@@ -366,7 +360,6 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
-	pud = pud_mkdevmap(pud);
 	pud = pud_wrprotect(pud);
 	pud = pud_mkclean(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
@@ -384,7 +377,6 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
-	pud = pud_mkdevmap(pud);
 	pud = pud_mkyoung(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
@@ -693,53 +685,6 @@ static void __init pmd_protnone_tests(struct pgtable_debug_args *args)
 static void __init pmd_protnone_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static void __init pte_devmap_tests(struct pgtable_debug_args *args)
-{
-	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
-
-	pr_debug("Validating PTE devmap\n");
-	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
-}
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args)
-{
-	pmd_t pmd;
-
-	if (!has_transparent_hugepage())
-		return;
-
-	pr_debug("Validating PMD devmap\n");
-	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
-	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_devmap_tests(struct pgtable_debug_args *args)
-{
-	pud_t pud;
-
-	if (!has_transparent_pud_hugepage())
-		return;
-
-	pr_debug("Validating PUD devmap\n");
-	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
-	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
-}
-#else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-#else  /* CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-#else
-static void __init pte_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
-
 static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
@@ -1333,10 +1278,6 @@ static int __init debug_vm_pgtable(void)
 	pte_protnone_tests(&args);
 	pmd_protnone_tests(&args);
 
-	pte_devmap_tests(&args);
-	pmd_devmap_tests(&args);
-	pud_devmap_tests(&args);
-
 	pte_soft_dirty_tests(&args);
 	pmd_soft_dirty_tests(&args);
 	pte_swap_soft_dirty_tests(&args);
diff --git a/mm/hmm.c b/mm/hmm.c
index f1b579f..07d507f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -405,8 +405,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && \
-    defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+#if defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 static inline unsigned long pud_to_hmm_pfn_flags(struct hmm_range *range,
 						 pud_t pud)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index 267d8e4..efe5d64 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1069,7 +1069,7 @@ static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
 	pud_t pudval = pudp_get(pud);
 
 	/* If huge return >0 so we abort the operation + zap. */
-	return pud_trans_huge(pudval) || pud_devmap(pudval);
+	return pud_trans_huge(pudval);
 }
 
 static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -1078,7 +1078,7 @@ static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t pmdval = pmdp_get(pmd);
 
 	/* If huge return >0 so we abort the operation + zap. */
-	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
+	return pmd_trans_huge(pmdval);
 }
 
 static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
@@ -1189,7 +1189,7 @@ static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
 	pud_t pudval = pudp_get(pud);
 
 	/* If huge, cannot have guard pages present, so no-op - skip. */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_trans_huge(pudval))
 		walk->action = ACTION_CONTINUE;
 
 	return 0;
@@ -1201,7 +1201,7 @@ static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t pmdval = pmdp_get(pmd);
 
 	/* If huge, cannot have guard pages present, so no-op - skip. */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+	if (pmd_trans_huge(pmdval))
 		walk->action = ACTION_CONTINUE;
 
 	return 0;
-- 
git-series 0.9.1

