Return-Path: <linux-fsdevel+bounces-50125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E81AC863A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 04:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11FE7ACA05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE918FC80;
	Fri, 30 May 2025 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qJ1WFa53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA51D554;
	Fri, 30 May 2025 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748571785; cv=fail; b=VbFluaQhgd7JqLChxWqHCWrP1XuMFfbQYY03dkxz4X9kp58b8mQeEhT4BZ47+y9a72ew9vGYF6XsRgan9xyQrJwiyNAdCW4kszvbW5P2Pge9EilTna74MRwKJeosD/o+gxY9gGZBuxh14iv116IYFcStzvXCJyIMa7Ffy5AUOeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748571785; c=relaxed/simple;
	bh=hZ7R15yAhHqzjBxZO7xbtQPfqNzhJo/TwLvasjjm3c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IL/rG2GrUZCNRxIcyK7L/Cjnhqr3jOaCiY6t3lg79gnfbeaRa1vvXfjp+PdopR4y9pY9PFKQQXPI7c3obrl8sprW7snBpGfXBGS2HRANdP7Pm9LBppElZ/b2G3jpVqtkcxcN0/PJM5sC4QS1Zwps5/1Iam/gZRVEKbXG7+7TZd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qJ1WFa53; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4pbp1PVTcakjZAqcZlv5RQYku08lbbdcfy/IjCHc9n4cF0+hx12ZbhNJHfAwE/K3QorGihecsYe3sAMFrxldr5vZYnb/lGOh9CRHe18a4wkA4fBgGx0ntyO3e3KYIrGLQC1+ieeO1qqgLfqz5EOlMCzBzP1bnJno+8hCpBJwk1zmnKD0g0csbeaEAtIAqT8vZOeUL2n+U4Adre2gHzSKuQko2xQk7RbgBJjROQXfhGHnAExgml7cFFcZyGtywbDPXxCQ8lJK9p+mmm9rj/IEVV56NKpMAciiUyI88AQvyJwnK+/fezYFmrOO8IEufnBVOwIy55WQ+SubJy476knnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsNoU5zpiGh20r7qCTNQ438G1lz6rL6+4PLzJIMWkoQ=;
 b=B5DLawZrTiomxvj8IVEmGhlcHwPocTdC1TGbZhNh08Gs5SdXcUgoEuvtXsJnS/8TB2h7ali+pvla6j2/cONDoy3n4tL4R956PyHhFLwVai5d8NtanGWhTOW4ob5vPy+PZYa2O28fHCoNLaJhlOsDWu8GS3OOJ1yQGdW+gtKEnI2Futk474KQl4wLQXHE8nIKKpaQeZ47QyAVrWqNl6plJbTlK/osL/adbiKM+TrxeQPKzvGz3VvXBxnhJLiaeAXi4ZCbhtaeLrL85wNROSu/truKhzGoK277W4O+N7Bo8sMHdLXOXmcEuHlU6LYjfd3ODxSWUUGDVzXsOqV1sGYNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsNoU5zpiGh20r7qCTNQ438G1lz6rL6+4PLzJIMWkoQ=;
 b=qJ1WFa53y4eJ3lSWJMMXgEwccgY+h84dfgmdV+8ON7PdvdXaR0ZzJA9jJuX3o6zQO0EnkewfE3M2+awWWajC/0MKtIg/nq/ZLIH4Fo+sRTNnJ2oHXEcfJRjLFGiDxrToNGo/kB+cvWUAmpWn2l2lODtQRaFjUL6j6B/QapnWeRUAcv+LApqe57CHEx2CjFzZqhOB1xPnRBTfn8Hfpb6pssE5HDysQ55lsirb9/g315REKEljM14Q2P40uD9X4vtnCRoK+wvq6pUseogMCcPlCifOi3QrUMZPHW/RPH5ZlKriKHhxeXFupQZ5k5ypi3BtY6rOefyaHcQ2/BAnKouKBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.29; Fri, 30 May 2025 02:22:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 02:22:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: huge_memory: disallow hugepages if the
 system-wide THP sysfs settings are disabled
Date: Thu, 29 May 2025 22:22:56 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <B55442F0-2387-40B8-A980-F6F2B8FBA4D2@nvidia.com>
In-Reply-To: <31b4bc9e-06fc-4879-be2c-aedea3173f54@linux.alibaba.com>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <d97a9e359ae914e788867b263bb9737afcd3d59d.1748506520.git.baolin.wang@linux.alibaba.com>
 <33577DDE-D88E-44F9-9B91-7AA46EACCCE8@nvidia.com>
 <5acbfc5f-81b6-40e2-b87b-ac50423172f0@linux.alibaba.com>
 <E330B371-C7DC-4E79-9043-56F4AA9BBE54@nvidia.com>
 <31b4bc9e-06fc-4879-be2c-aedea3173f54@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:36e::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffbfe5a-ee1e-46a9-63ca-08dd9f20e4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTZwdW9vRkNrODRPYkxuVEF2TTgrWkd0cy9VL05ZT2ZOTHBBMGk3VTFwSXRU?=
 =?utf-8?B?RkdBUC83OGtMUGo5QlVocmlGV1JiY2pzcXpZQlZma01jZXkyVGFhR1UxZ3U3?=
 =?utf-8?B?VXlWNXRQK3ZncnYzWXQ4M3VGaWNUeHNudzA5dDBTZWFxbmE1N0l1b29CNkUx?=
 =?utf-8?B?RTMyVmhhT3hmcDNEaEVCNnpzdTJ0Vy85TDRSa2N3UXk4Rno2QVptOXFLU3d6?=
 =?utf-8?B?aXlSWWVydWpYSW1nNysvUDlkd1lnS3ZweFRPdVQybFh6UjFiOWNWQVRGc0Jl?=
 =?utf-8?B?NjNVa1FtakIyNUM5R1JvVktqWUVPRjY4bFFJbGdpS1pGV0VIcDBJM20zRE1E?=
 =?utf-8?B?UklCNzl6L05FUEhodEVMbnFGd3RNdFlJSjVFcmJxL3kyb2ZwTnV3R3lIVlp3?=
 =?utf-8?B?Mjl1YnNHVzFxcElKTkRVd1VyOFFPOHU4UFd2OXdaR0QzUUs2ZlN6VDdPYmp2?=
 =?utf-8?B?YWV6dDV2UGdDdjBEWDhWUjRnSzdxWU5vdDcyNTBHOW1UZk1rZDk0enUvYXIz?=
 =?utf-8?B?YWZsRkRsOUx1aW5WT3doQnB6Zmc4NG13aUljd2ZwcUZuZ2JTTWxybWlKK2s0?=
 =?utf-8?B?OCtwQmtQRDBtSWlXUzdleFBnc1pYSWFpRmhFaENhYlhQSFVkcmVuQktDa3hK?=
 =?utf-8?B?b3NRTXlRcjZGTW5Ob3U2TTBYNVJtd2gycVVIbXREbjUrUi9RUXNRSUJQVUov?=
 =?utf-8?B?WGJubUhTVkoyUXdwNHUyYXFXaTNOSGNBS1d3T2p2NjBTa3hwM2VzWGdubVQ4?=
 =?utf-8?B?VzdZUWhPaGo3Vy9RaFk2NTFOL2theE9iVEVaSUJYUUVZUVBaUEZGUVpVUFFE?=
 =?utf-8?B?NnRCeDBOalI1b2tBcXdjTnpPZXloeWs3dkFJUXlJL3UwUG0zbnlkdW93TERS?=
 =?utf-8?B?SENQampXdnppaWo3OGYzNnFYU1NzQitLRGZaYWw3S0FhWWFQTEErZy9wWFJw?=
 =?utf-8?B?OTdnRXgzSktEMTI0WUpYcGlVY25mOUVpcEVtMVNSaFkxVzYxTE9CTllxYXlj?=
 =?utf-8?B?RDJsWGVGWnZRT3pieG5EK3VYdE5peThyK0UzUmczYXd4a1JhNE1tUmxUb21p?=
 =?utf-8?B?eXlDOGpFL3AwaTFwMzJXSCs2NjJDcUpUKytHa3NmU2xxRXR0S1VEdmJ5cUNO?=
 =?utf-8?B?MVhkdU9XeFd6a3BvMy9xeUhUYXpjYmczb0NqalNobFM4MkMvNDZIU3RxVTJi?=
 =?utf-8?B?dEk2YW83cjJuQ1E5SmNxcTZtTGFCVXN6dkllNWJ1K0p2YlpueXJiLzVmTzhT?=
 =?utf-8?B?b2gwc1A3ajE1RVgrS3cveXY1eUNZOWgyazh3a0x2L015Y2NPRGFKbjBPa2s4?=
 =?utf-8?B?azdQOEFNbzI1TjZhcnRDVnIrSFJKZzV6NW5MdmZ3NzgrZmJ5Qmo5WnhmRUly?=
 =?utf-8?B?WG5TVDJvc0pTb00wRSs2aCtzcnVTeVBSZWJSWW9PVnR4eU9sbXNWdWY0SUVQ?=
 =?utf-8?B?S3UyYmpqZk9hZmZzNnZRNHRiU0Qzc045VURHU2FQdHpZMXhoaFZzU0tSem5i?=
 =?utf-8?B?VUtaUU92MVdBTTRFUTdSZnBCa3RVRGl5bEh1eEZKd2hxUjM0N1d1Mnk3cWEy?=
 =?utf-8?B?MkpQTUN5RVZFUVpuZyt6WisvYjRMcEtSL0V4TkE0T2hUSEsvZ0l1dENiTW1C?=
 =?utf-8?B?SCt6Rm0wNUM0KzlGOW5aYTdtSjJ4ZXFkL0JNaURETlpoNmF5bTg0YXFzOEFD?=
 =?utf-8?B?OVM2blhra2krR0g3L2xCK3V6dWRuNVM5K0VMVEFEa0ZORkdhMFByc0ZEajU5?=
 =?utf-8?B?SGdGN3dDamtMQ1h6d29EbFh4SFM1NGNKeEpRcmhjeS9mSVdJMDVvcW96ME1S?=
 =?utf-8?B?bUFvSitEWjVic01wSk1OVHZOL0RRN3lxbklKYTZmeFlvQVU2dmFFK1JoRDRJ?=
 =?utf-8?B?K1o2QitrbEYzWHpKSU43dkVEKzRjekpCb3pmb3hXMFUweWRtbmdFRUFNNGpL?=
 =?utf-8?Q?al+vXmz2tn0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlV3QUhMcmxRbzRBVy9IZEc3Z1RZMi9yUlFHMFRBSTBpTktFdE5lTWJ1cldN?=
 =?utf-8?B?bjB2UkZPMHVISnRYcGhlRG5IYS93N1NEY0ZVeTEvc1oxNGVhc1JCMkRIUU9t?=
 =?utf-8?B?bDdESysvS2FEd3k4bktpcG8zWDFlWkN3SCtEMDZMN0dCZHJtNng5MWVFSzlw?=
 =?utf-8?B?dkF6ay9rdGRyMU5mdnVpTUVVcmdyNXB6SksxM3FJNWJlMHNyVDEvY3h2VTEw?=
 =?utf-8?B?QUNjVDFsdjk1L1hUTmliUkdsMVNIRnQ1NFhrR2F6VHl2ZmVTNkxQZkNFd3V1?=
 =?utf-8?B?T3NFb0c5cCtPUGhFanc1azZZRnJBSVhvUTVVVnZncGZIZC91U0g5a0FUclNW?=
 =?utf-8?B?NHdjY3B0N0ZMZkRNWUtFY3dsdDBtOVVHVUNrSUVWNC9NRDF2NmgrbHQ2UXhj?=
 =?utf-8?B?ZHM1OExOTVA0WWU5aW15VCtTOUFsSFRuaVFkbFFzU3lLc0NHVUJ6UWhHMTQ2?=
 =?utf-8?B?K200RnFmREZrUzJsSlVML1c0SktKclA3NTNkR0N0N1FlUVdKeUVKTC9uUDcx?=
 =?utf-8?B?SXJxaFQ2SkFrQUp4c3c2SDhlOUcxNldMWjZxSG1KdFVxWk1oWkVaQjRmenlS?=
 =?utf-8?B?NlRwa09tY0lJL3pMMnNHZ1NtZHRTQkk4eUQwSWxvVTZlcGd6YTRUR1A4NTJ3?=
 =?utf-8?B?TzYzOXIwak11cWpNcGhwWGhzS1VXL0xBRU1IU2x4aThlRG5XclR6bWc3YzdZ?=
 =?utf-8?B?SVpucFdzVlZXYlh4K20rY0lGOHR1dHNDK29uSUFxMThiWUNpNmk2Y2tORWJP?=
 =?utf-8?B?QnBQRWlEU09mTS9rZFBneTZkNG9XbGxUb0ZtL2E4REhFN0U0YWFsYU5ZVm5n?=
 =?utf-8?B?SXVrTUt4VCtGNldqWTVHV0FTUThTUWlPUXBQVTJGbXJnS1NhSkphZVVCSEZ3?=
 =?utf-8?B?cm5aYnZUYk43VHJUSTAvQ1poYzJuNjF3ZFltTlZzQ08weWdCaFZONjRIRE1x?=
 =?utf-8?B?QklQMkFtdGJFM012UmI1UEZ4ZGdkOFFVRkh4L0dnMFJEdVQzSjI3b0FueU05?=
 =?utf-8?B?Y0I3b3c1V1FLbjFHUXovZkZrMkpUajBqaTQrVmwwYUlaYjNTL2R4ZVR4Y2pB?=
 =?utf-8?B?dzM2dlhQcktrQURMVXRtZkt6YjAvaFR2WGlnSitIL0dETm5NRUg4T24xTWVC?=
 =?utf-8?B?bXdtbURMWmtTdW5Tclc4WnE3R01SY01udE1VQ1dabXVkVHF3WUwrV0pzRE00?=
 =?utf-8?B?N2F0NWpjaHdBWTBGVytaYmQxMFhRSUt6eGFXa095aU9mUXBCcHpwNW84R1N2?=
 =?utf-8?B?QjJzeHUxRUxhNWF2UWo4NUprVEJDVnI0MVA5dFMyY3BrUlBQZjlyRUg4RW9p?=
 =?utf-8?B?aHdxV1pQS3FsQ1dzandkQUcyT1FUVFZIRTNKMGZqSmtwamgyUzJ4MEtuZ0Vv?=
 =?utf-8?B?bTE0eTUrQjdsc21aWG9NaWEreEx0MzAzL0tPVEZHNHovS2RBd1RUMGs3elhX?=
 =?utf-8?B?d3o4aGZUbnVkcCtHMlpHR3ZiSisraDkwTXAxTm9GSnZZUVRIc0VrVGJTSm4y?=
 =?utf-8?B?RjVYbERIVTdMbnZxcldyd2o5NDlZMTAyYW9rUUx5UHZoT09JMWg4MzQybk96?=
 =?utf-8?B?NS9QUUhTZmlnYW1yeVRIQjJ2VkZZZWp6ZjFHUGJpNzhoZ3NMU0RQK1ZkdWp1?=
 =?utf-8?B?ejd0T1B4azJoWUthVGVlWk9HUURvYkxPNnZwemN2T21xT3phcFlGM3JsZml0?=
 =?utf-8?B?ek5NZUlZbzAzUlpTalRpaG5ZTE1zelhKaXhzYVRScmpuT21HdW9hdkUvZWJp?=
 =?utf-8?B?clpvNDg2bk12NDJtZU0yWGsrNkZ3YkZqdDkvMDZwWnBTWlJuZ0l2Tlp1d2Zr?=
 =?utf-8?B?V3JEbXRieGpPYmJIaVhDdWRTaGlwdG05Mm9HVUtUZ0dzMjcwWi9wZXkrYlJq?=
 =?utf-8?B?bEtGUDhCemhEQThsOE9FcEZQMHBNT2NYTVpQV2Y5KzdSVDY4dkZZL2hXVldO?=
 =?utf-8?B?MlUrb3Y1ek15MWRnMnNiVkZWUjNPdnhjdWFXMFlaUVhWRkoweFhUdFBRNDlk?=
 =?utf-8?B?Q1cxRFo5VUxadTZtaDVYK1NSWklkcXgrRU5lZzhKOUt5SE5WNkpOT20yeGwx?=
 =?utf-8?B?RXVqSXV6SXVwWkF1bW5jbjRhSm9aeU5FckZEYnYzajYvV1lMMlhWTWxCbHNU?=
 =?utf-8?Q?m523adS568WgeOEavVdHno8cg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffbfe5a-ee1e-46a9-63ca-08dd9f20e4b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 02:22:58.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNN8OYyp2WD5rO9ghdiJnB3Qr6o1HdT8+t4NHdYQG160zTIZmHJoZ79HC7Sxjfe0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077

On 29 May 2025, at 22:21, Baolin Wang wrote:

> On 2025/5/30 10:04, Zi Yan wrote:
>> On 29 May 2025, at 21:51, Baolin Wang wrote:
>>
>>> On 2025/5/29 23:10, Zi Yan wrote:
>>>> On 29 May 2025, at 4:23, Baolin Wang wrote:
>>>>
>>>>> The MADV_COLLAPSE will ignore the system-wide Anon THP sysfs settings=
, which
>>>>> means that even though we have disabled the Anon THP configuration, M=
ADV_COLLAPSE
>>>>> will still attempt to collapse into a Anon THP. This violates the rul=
e we have
>>>>> agreed upon: never means never.
>>>>>
>>>>> To address this issue, should check whether the Anon THP configuratio=
n is disabled
>>>>> in thp_vma_allowable_orders(), even when the TVA_ENFORCE_SYSFS flag i=
s set.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>>    include/linux/huge_mm.h | 23 +++++++++++++++++++----
>>>>>    1 file changed, 19 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>> index 2f190c90192d..199ddc9f04a1 100644
>>>>> --- a/include/linux/huge_mm.h
>>>>> +++ b/include/linux/huge_mm.h
>>>>> @@ -287,20 +287,35 @@ unsigned long thp_vma_allowable_orders(struct v=
m_area_struct *vma,
>>>>>    				       unsigned long orders)
>>>>>    {
>>>>>    	/* Optimization to check if required orders are enabled early. */
>>>>> -	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
>>>>> -		unsigned long mask =3D READ_ONCE(huge_anon_orders_always);
>>>>> +	if (vma_is_anonymous(vma)) {
>>>>> +		unsigned long always =3D READ_ONCE(huge_anon_orders_always);
>>>>> +		unsigned long madvise =3D READ_ONCE(huge_anon_orders_madvise);
>>>>> +		unsigned long inherit =3D READ_ONCE(huge_anon_orders_inherit);
>>>>> +		unsigned long mask =3D always | madvise;
>>>>> +
>>>>> +		/*
>>>>> +		 * If the system-wide THP/mTHP sysfs settings are disabled,
>>>>> +		 * then we should never allow hugepages.
>>>>> +		 */
>>>>> +		if (!(mask & orders) && !(hugepage_global_enabled() && (inherit & =
orders)))
>>>>
>>>> Can you explain the logic here? Is it equivalent to:
>>>> 1. if THP is set to always, always_mask & orders =3D=3D 0, or
>>>> 2. if THP if set to madvise, madvise_mask & order =3D=3D 0, or
>>>> 3. if THP is set to inherit, inherit_mask & order =3D=3D 0?
>>>>
>>>> I cannot figure out why (always | madvise) & orders does not check
>>>> THP enablement case, but inherit & orders checks hugepage_global_enabl=
ed().
>>>
>>> Sorry for not being clear. Let me try again:
>>>
>>> Now we can control per-sized mTHP through =E2=80=98huge_anon_orders_alw=
ays=E2=80=99, so always does not need to rely on the check of hugepage_glob=
al_enabled().
>>>
>>> For madvise, referring to David's suggestion: =E2=80=9Callowing for col=
lapsing in a VM without VM_HUGEPAGE in the "madvise" mode would be fine", s=
o we can just check 'huge_anon_orders_madvise' without relying on hugepage_=
global_enabled().
>>
>> Got it. Setting always or madvise knob in per-size mTHP means user wants=
 to
>> enable that size, so their orders are not limited by the global config.
>> Setting inherit means user wants to follow the global config.
>> Now it makes sense to me. I wonder if renaming inherit to inherit_global
>> and huge_anon_orders_inherit to huge_anon_orders_inherit_global
>> could make code more clear (We cannot change sysfs names, but changing
>> kernel variable names should be fine?).
>
> The 'huge_anon_orders_inherit' is also a per-size mTHP interface. See the=
 doc:
> "
> Alternatively it is possible to specify that a given hugepage size
> will inherit the top-level "enabled" value::
>
>         echo inherit  >/sys/kernel/mm/transparent_hugepage/hugepages-<siz=
e>kB/enabled
> "
>
> The 'inherit' already implies that it is meant to inherit the top-level '=
enabled' value, so I personally still prefer the variable name 'inherit', j=
ust as we use it elsewhere.

OK. No problem.

>
>>> In the case where hugepage_global_enabled() is enabled, we need to chec=
k whether the 'inherit' has enabled the corresponding orders.
>>>
>>> In summary, the current strategy is:
>>>
>>> 1. If always & orders =3D=3D 0, and madvise & orders =3D=3D 0, and huge=
page_global_enabled() =3D=3D false (global THP settings are not enabled), i=
t means mTHP of the orders are prohibited from being used, then madvise_col=
lapse() is forbidden.
>>>
>>> 2. If always & orders =3D=3D 0, and madvise & orders =3D=3D 0, and huge=
page_global_enabled() =3D=3D true (global THP settings are enabled), and in=
herit & orders =3D=3D 0, it means mTHP of the orders are still prohibited f=
rom being used, and thus madvise_collapse() is not allowed.
>>
>> Putting the summary in the comment might be very helpful. WDYT?
>
> Sure. will do.

Thanks.

>
>> Otherwise, the patch looks good to me. Thanks.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> Thanks.


Best Regards,
Yan, Zi

