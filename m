Return-Path: <linux-fsdevel+bounces-69708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C82C823B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 20:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2261C3A2498
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37F2C21DD;
	Mon, 24 Nov 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qGTY1zGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06612B93;
	Mon, 24 Nov 2025 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011308; cv=fail; b=FDiSkvcagb5f7/dAlCi1wzWr+Tm7jnkvRyz+HdOiHln4mlIyu8SuXbSuhQiNF0GZmUzCSuVWrUDWtkcHhLOAiLXFvG6C/86Mym/GM4OhSgzDTNKO6M+tD890EX3rtWkvEjr94aOUuLzKFp213dILQ+19+YX8B6zW5QvlY37Kt7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011308; c=relaxed/simple;
	bh=6BFYe1v7hg51e3xVjeK9mZEnvPkN2jHytxg0EUKQMTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sDlA78J7rbKkyLslNqLDbkhUT1QpVovT0CgB2e4S8RFbbACocbLa7pDYkKowCHVdx3vHy/Z6+icbDP0M150PCGaRfMiOhJ3t/SxNiaJx7qBTAQGPYno+jRJuVOR7JO6hfBVti1xV9heL1mGZ9KScjrBIeRQ/p9S5316pDNYe9jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qGTY1zGN; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJZAuXkDn0soI9RxfSxHldg6jFBcK8YaO6ZhgxRxQTYPG1L1aIzoEU+luddzOQQ66eXhbkbNUphXBXY7LoXXYGxbi5N0/p4UphKNaDspwbqQmaIYdBwubaS2gbRMd0wuADHxgYFKcBDokmY2p16NdqglSEN+AIiF2jrAS42epZoahUStNnk8eFIJ3pAUwCujCPIIF+0uwMp1oMoRucGg8OgsYdERMYXe82eh6Z8EkAYvUQq2xgQS8vXtem2/zbE1X9vKh6ro6MDXQc/ofXYfudQ/U9+MrhvpJBQnr6V0yCGk/Qk3Ire95BDAAnxwyq/AHAFmBAbICkbQz+PJcFsxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLCBer1Z+cnddVHAvdalG7T9kzvzqW4yicckWgkNzo0=;
 b=oL7BFh3rw81GzaCmkmaPCgmd+6c+MAu9Qo++yKVULsI8aAt+myRJV+U/4V4CCuN/JJoroQ9SGwmN4AQ+y/Qg3GWw5jfCg7HWm9fPj66e7Q4uXbAB0pzE6KB8+p9zL/T6QcfXaa/RWeRf+ojFO5+sYLs+uzOyCGEBxarcuF9QvlFa6VSZ7B1NOG5oZgK9Af2puXr8iaMXGCyPyluKzovwIVr8ei+5BGPOcylwbJhmbkJxXb+wrvqmLA/fsgOfE/LpoDgW5G2FWiTqh1syvUOTry8fl0nIImuvjJswDMFI3YXpCvSwOZ/4MNvoO37wI8YKzvY+YjpuHXJeoXlAk18Pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLCBer1Z+cnddVHAvdalG7T9kzvzqW4yicckWgkNzo0=;
 b=qGTY1zGNxmEJ35aXPr0hp5+jlppYmljKskH6sTLwegnZS+Wm7yGaz4N2WjFTBqxuULeRX9AFCwg57h4yz8hEqM+qEN2/885PXlJ7+y668UP/Ky4CfDQwZpECIfUsl8Cat2gR7khYw9KqkVCk1qvIeIDRuhZaeFZ1HusUR63fAFeomnnZdJhzAedObpSpB4e8QysNIJR/M1mv7kQwBv1Vi+8aulnylwTBeDau7RGGFDdq+noSfTtPMwRn2b1cfAMPousSKlowWSrcoJ0lpcnLN5qp3/TLvss2veiXufpCI60iIvE2pNVpc6mc3CFSWeHSsD/K68I/B2Ddep18Oswbtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA4PR12MB9836.namprd12.prod.outlook.com (2603:10b6:208:5d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 19:08:20 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 19:08:20 +0000
Date: Mon, 24 Nov 2025 15:08:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
Message-ID: <20251124190818.GI153257@nvidia.com>
References: <aRxWvsdv1dQz8oZ4@kernel.org>
 <20251118140300.GK10864@nvidia.com>
 <aRyLbB8yoQwUJ3dh@kernel.org>
 <CA+CK2bBFtG3LWmCtLs-5vfS8FYm_r24v=jJra9gOGPKKcs=55g@mail.gmail.com>
 <20251118153631.GB90703@nvidia.com>
 <CA+CK2bC6sZe1qYd4=KjqDY-eUb95RBPK-Us+-PZbvkrVsvS5Cw@mail.gmail.com>
 <20251118161526.GD90703@nvidia.com>
 <CA+CK2bCguutAdsXETdDSEPCPT_=OQupgyTfGKQuxi924mOfhTQ@mail.gmail.com>
 <20251118232517.GD120075@nvidia.com>
 <CA+CK2bCtJD-FGtmCOfz8arUGqO6hFkxWcjG-wHz_S1Abt7rXEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCtJD-FGtmCOfz8arUGqO6hFkxWcjG-wHz_S1Abt7rXEw@mail.gmail.com>
X-ClientProxiedBy: BN0PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:408:e9::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA4PR12MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 397ce520-65c0-4fbd-381d-08de2b8cd48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmcyaHJqYU9GcmZxLzZnYWhPV1ExdW81cGlaR3B0NFZ0TmkwbXo1U1pWcDh4?=
 =?utf-8?B?TnFBT3pJQUV0a0tHdmtKbGFsYjViRUVVZlNlc0hxd2RwcHhCeHFQbnE5WUVQ?=
 =?utf-8?B?TG9EK3F2K2FnYWdKc2g3Rmt4OEczSjU1Y2xDYVROZFNCcnU4anc5aDliN2dy?=
 =?utf-8?B?RllVbWhZQmRCMjdtR3h6Uktick1mRGlpN1hhZzNhRVF4OFYzclZZZm0xRzRG?=
 =?utf-8?B?OFREWnY4Unk2Y081VTBoaGVtNlFwT213ckF2MUpzbVhRMThkV1JwbDJJaGxj?=
 =?utf-8?B?RkhNc1VUT3ZmaWhUOXdsclZoQ2o2VlcwYUZlNlFRcGNGc0pDbHptNnZRa1BU?=
 =?utf-8?B?VjBOSmJhNWVkZ09KSWFjRXlhUktLSUUxWEV2YzVkM09TMjF4cDVpd2RmSDVy?=
 =?utf-8?B?S2ZvR3dGYndtZFVIeU1WVzZMVGdsTWdFUUFPdDB1dUhUdk1uaDNTVHNVUVcw?=
 =?utf-8?B?aFFHSSthaFMyUlo5ZlJPb2ZiNTg5TTNQRGo0WmU0VTM5TlppUk40T0VYcHIz?=
 =?utf-8?B?YStBZGplMHU2dncwWXRMOGtlMnNXSjdZSFZjeWNpV05vOVZIVVlDYVVFU1ZB?=
 =?utf-8?B?WDlBM1BmcmMxNkxaR3ZGbGNqNVRjZ0dEaUhRNjhPNUo5a3MvOHIxMzZMTnho?=
 =?utf-8?B?STNxbm8xZUhBUDd6bmJRUGhUdGNSR0dMaDBQWWJYZzlxaGl4TzkzQmFSSmta?=
 =?utf-8?B?RTlHV2h1RE1IamdsbGxHSmcvNDlZSGtCbDdVc3krRE5KeDRaeFR4M1loUndt?=
 =?utf-8?B?bEdUMmphZDNtMWdoaVM4cG42ZytxMUFWUmo0S0p2eUlaQUdMV08xaGFLQUd1?=
 =?utf-8?B?cVFNMWcxVlVjSDZHY0lhY2czd2JNZzduT05VNTcrbndaemtUQXFuYldXTGN0?=
 =?utf-8?B?NUd2YXJaMVJBMGZJbUw2VGhWeFJNSXNrUnlwemxPM3RKdHlOQ01QVE9aZXNt?=
 =?utf-8?B?bU9Fa0RwNC9SMm4zNys1U1FuWkJxS2tBdmYwbDljR3hMVkd3RHB2ZG5iOVM2?=
 =?utf-8?B?ZmFFTkJzTjUrL3V6eVhaMGNvb3RHV2dYSTdmSEhTeHhVbkRpc21zQmFCT1Qw?=
 =?utf-8?B?eGo4ZGZadERUUzlqcnlyd3M1QmNqS25Uck9LbjhiMlo1T0FyL1N2bURwaE1B?=
 =?utf-8?B?cjMvd1B3ZUdVd3k5bW14dnFpV2tUblY1N2VmaUlseWFZc1JLOG01TE9tUWFN?=
 =?utf-8?B?RlhRU2NpdzF5M2dsaldvSjRFcEw1SWFXeGZFUUpvYThaTzBBNjdiRmhlaURG?=
 =?utf-8?B?VE4yTGNMMUpVMEtueWxVcnFnWnFRZzlYcGN6eC9MM3JKVEdjRVdNV1ZackRj?=
 =?utf-8?B?WWptbzBRbUMzOXU2OTRIV0p4Z0kxbGV1Sm1OTCtUSWlxdFFOQkFUeFZmTllG?=
 =?utf-8?B?MkhBcWFpb1VYR1N1VEkzQUZZUmU0U0hkVlJJbStiUU5ycFgvcFFLK3VJZFB6?=
 =?utf-8?B?ZlVmUExwbUU3NStXeUMybEthZjVBTkRMc212c0c5MURlR1ozR0xhZnBkWDRm?=
 =?utf-8?B?T01rc2NLYWFRRlVyWS9SY2h2ZkE2bElLUmZ6QnJ2Y3ZXbkNlYU9oclJ0TmVL?=
 =?utf-8?B?dzg2WUdUTWhINTBZYTN6Q2xxSGxzdE9UYzJVTHQ1V3h6RHppSm1PSFBTb3Zl?=
 =?utf-8?B?RHAwN2E0NUFlQUFhMWZDaHF3STd6ZHV2Y3hjZFBOMHphNGg3MUdNbU9jOHQx?=
 =?utf-8?B?dkVmS0w5K3NmeUQ1a1d3My91cDNzL1JYdC9XcjNrTFVOMXhQSEIvamozNDUx?=
 =?utf-8?B?M1JNcU0rdjBOQ1JGRzJoZytIUFZGN0NOeW5oWGpqNm5DVnNQdjBQMG85V0pp?=
 =?utf-8?B?TVBjNWt5bTMxUmRmNHlMMDhIRlB3eGJnU2RLalk1NmpMNmdwTGY2dDNOOFJp?=
 =?utf-8?B?SDZpeDNDemJ0bnBaS05JM1RqTlAySjFaRkM4Q0c3SGVmR3VLWis0M2lZdEhL?=
 =?utf-8?Q?6ajhMu5BdUV3aVCKaSjVUfpTXgyRHG1Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzNqRVBBdUVXT1pVaUVoTkl3YjAyNXFKU1EwR2UwWll1bHI4L3VIcVVnbUpC?=
 =?utf-8?B?VjBDdkg1QkR1U3BEbnpFTHlJUVdaOEN6VFp0SnVmWk8wZy9oQ0pjZzdFeVU5?=
 =?utf-8?B?U3RPZTJXVjRWc1RveWlTOFNoU0xkaCtsUzhjN2ljYzVVRm9tdXdPcHhrc1ky?=
 =?utf-8?B?Yy9uKzU5Mmh6bzV3eUhRUmN0aEhSYUNPVkNCcHFzNFJzTEJFOUprNDZ2V2lH?=
 =?utf-8?B?YWdydlR2Tmp0R2x2dUZiNkZ5VXF1dVdSaWhHeW9LKzVBTlBHcElVVHJkbTE0?=
 =?utf-8?B?Sk1jNnRaUTNDcllCb1pzOVhhcGFCWUFSZW12YjRrL2twYUJkaGZXbjRjOUZq?=
 =?utf-8?B?MVpWSWVCVktwRWtockFkeW1EN3Y3QlJKTHBIb0I2eXNqa0huMk5BK0pTRWFF?=
 =?utf-8?B?RnZ1d3lYL3BFbllHUWo4aXhDamVLbkdyb0F1MThzb1FLTVZMejFVSDdRRVhk?=
 =?utf-8?B?TG0rWG11VlozMjZUeWNmQm1UZXJ4OUUrVU9hd2JqS2VlK0h1SVNNUnBGQUsx?=
 =?utf-8?B?SGNpU1pyRE5NZUx4SUZTZExZWWhacnhQK1JqT09iRFVSZlZVck9mYnVwZC9W?=
 =?utf-8?B?cXl2Q05tNExhVHZCT1JrOWNVS0kzY0NJUFdVT0VyNktnUFdqQ003Z2ZIRXhD?=
 =?utf-8?B?ZUo4cFhxcWlXdUs4OUdaZU5nUDB6TWdrMWZLK2FRc0FUOHFQaCtvOTJpQVBi?=
 =?utf-8?B?VGhXdnNHa1NsVXBhcWdIUWlQUThXNWdEZlJKTkRMVUNXK25BNkVxdk5Qc1FG?=
 =?utf-8?B?eUVRN1h3ZE5TZFBTZWdub0dneThmK3BlWWtxQStuWWNhRnkrR3NoS0xIdmNk?=
 =?utf-8?B?cUp5Z1hQWk9RNlhvbjZXY1FEaWZTb0dhK2kwZXRpekUxN2UrOWtjdyszdkJy?=
 =?utf-8?B?bWUrNE10ZVZQbm0zd3p1d3hrS2FXbW9EOVFNc1VIZ0ZHQ3NIaUtUZ0JHNy9Q?=
 =?utf-8?B?Ynp2RVdUWWttTk9xdzZ0eXVZT0Nsb0l1MVJDMVZlaEIydVN1cHRySnRnTURW?=
 =?utf-8?B?Mk1BRjVGZDhKbDZxZHBhMkVxVDdyK2RpcXAyRm5rNytLMnF6TSttWkJzZjBi?=
 =?utf-8?B?dG1lU3k2bzcwTmhLRWI1OUY5bkFZSWp4WXJoLzQ3YWxTZmYza2g4T1l2dExP?=
 =?utf-8?B?WjF6L1F2VklpWS81UjNxTEFORUc4OTVSUkYyME5yREliTlBDdGpsU2FwL2hw?=
 =?utf-8?B?T0JPWVZjYThsQ1FETDJRaUMyc2IzaTZSdm04NE05dTZpQVhWb1VlNXhUbUFL?=
 =?utf-8?B?b2NFaWc3Rnk3T2JTSHg3Y3RmcmlyOXNTclI2RTVoM1hEQitSZnNjY1JDelNH?=
 =?utf-8?B?V1pIWmpHKzh4d09ZaVNQZmFPcmFSWjRVOXd0RHRvVVcrM0lXV1dHSU1NdUR4?=
 =?utf-8?B?TG9tN3BaVDdpVEpRMWYzS3Rmd21hOXhtZnpENVJBM2VxektEMmpuSnh4Wldp?=
 =?utf-8?B?WHRBSWd2eWRKRWpDZDhyczJmMGExQVYwYmFvUU94SGgzb2RjMUdndWVlNGFa?=
 =?utf-8?B?Y3ZYWExYUnNXLzFwK3RrQ0U1TGVQSjBPUmMyVWZuOGl6aXA0SmIyN00ySVQ3?=
 =?utf-8?B?U0czaUtuNVQxbG55MThwaVIyamtDL1h1T3NLcC96ZVRiRFFPR1ZvWG9MczFB?=
 =?utf-8?B?TjFuV2xQV1Z0SktxMXVnK1MxY0RBOTFBL256WlFIenZ3azAxMlZKRlhHYzBw?=
 =?utf-8?B?aFYwYlZ5Wnc0OGR5SFRmTlZTM2NEbGY4RXlZWG5Pb1kvU20vNXRZOTZMckJx?=
 =?utf-8?B?ZVc0Z2FidWVLTm5nU0lWc3NvSHVWSmFPR1gzMlp4ZWt4czQ2ZHJJa2RZY0FN?=
 =?utf-8?B?VnVoelFPR25HZTZsUVBLcFFiNXZBZzljVFdLYnVJZHRWK0xwcXRYbUgxREpq?=
 =?utf-8?B?UVdWQ1RHMWxiZUdnY3NLMDRwa2xwTGxJY29qbEMvU2FtZUJsblBRa09pV1cr?=
 =?utf-8?B?dExZZmJ3WlBKQXFXd0E0c2psY3VnVmovYW5PZlVRdnNwTGpld1QrODFTQ1hj?=
 =?utf-8?B?ZUNyQmhDQ0V6Y2JHUjNSRUxnK3J4ZWt2TEkzVVJuOEZtVFk5ZmlublNLV1JD?=
 =?utf-8?B?SVFiWGxRTWN4NUZ4MWNjaUVZNkR2L3Q2OW44QzZVeFpyTURmZnpqMG1samNy?=
 =?utf-8?Q?1vYU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397ce520-65c0-4fbd-381d-08de2b8cd48c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 19:08:20.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYTaB3MKZomG1kNdniynAidH1BIepiRXDg+xfwDaiQ8gLoBuuTbROFJ2VGaV5enR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9836

On Tue, Nov 18, 2025 at 10:03:03PM -0500, Pasha Tatashin wrote:
> On Tue, Nov 18, 2025 at 6:25 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Nov 18, 2025 at 05:07:15PM -0500, Pasha Tatashin wrote:
> >
> > > In this case, we cannot even rely on having "safe" memory, i.e. this
> > > scratch only boot to preserve dmesg/core etc, this is unfortunate. Is
> > > there a way to avoid defaulting to identify mode when we are booting
> > > into the "maintenance" mode?
> >
> > Maybe one could be created?
> >
> > It's tricky though because you also really want to block drivers from
> > using the iommu if you don't know they are quieted and you can't do
> > that without parsing the KHO data, which you can't do because it
> > doesn't understand it..
> >
> > IDK, I think the "maintenance" mode is something that is probably best
> > effort and shouldn't be relied on. It will work if the iommu data is
> > restored or other lucky conditions hit, so it is not useless, but it
> > is certainly not robust or guaranteed.
> 
> Right, even kdump has always been best-effort; many types of crashes
> do not make it to the crash kernel.
> 
> > You are better to squirt a panic message out of the serial port and
> 
> For early boot LUO mismatches, or if FLB data is inaccessible for any
> reason, devices might go rogue, so triggering a panic during boot is
> appropriate.
> 
> However, session and file data structures are deserialized later, when
> /dev/liveupdate is first opened by userspace. If deserialization fails
> at that stage, I think we should simply fail the open(/dev/liveupdate)
> call with an error such as -EIO.

That seems reasonable, if you reached this point then it is probably
OK.

Most likely the prior kernel should mark some critical things like kho,
iommu and pci data as 'madatory early boot' and if the new kernel
doesn't use them then blow up right away.

Jason

