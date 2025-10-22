Return-Path: <linux-fsdevel+bounces-65053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C11BFA232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D717567486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E674A2E8B68;
	Wed, 22 Oct 2025 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hucB5zqy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB521B9C1;
	Wed, 22 Oct 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112722; cv=fail; b=G+9cXAId09u7l01hTkN11QoA8Jlx39eoc7VNTI7XwNAUz82ZFjlnmImq/7wPiB0kKw6j/hk3mk0BlzSnLyfxv2hjCucV+M43fb78BLO8SPU2cfiltZ/NMjh9JbowHamvSr7S1/uUqL5iFaeQFM0+hc3ykU1l42UApEDtMzkjmGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112722; c=relaxed/simple;
	bh=zB++H5YO426RDpulV+7rg3vixdWzftSGpDUYm5Ndj14=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=c3+edO1S4+/sZZaKcU1g6CKInf8QjqW/TBPsnUtTLYjSNP0/1aaZllsD8tZnsMUwQWHub9TGDUEodt9TvJF791n8Hjcz6w+3RQg0ZzYF6K7yQ32pCwEwXlBk0tobFg743XbGNYS+/LkFcuDITplnRk54AP83z3Ym/b7ztugc2EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hucB5zqy; arc=fail smtp.client-ip=40.107.209.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqisXd1ZVB+BMcrISSGOtDjTDnUTD3j/ILfN3HbtOIqvSUpFksvW973AuWVvCMv6gOu9SJoPG+S9utzqus4mmOo7IlODF0SyGQYi1w76mR8ris++Y6vidVUyTSS8BXUz2da6Ylr34IaD9iwOKf+Msd/DhtUlN2h0dGTBqn2UvIcbxzNQfcwGgyZcSlWu+fpvBle5T24h4etj2TH1DOkgTGARHTHbssW+ki0Cc2ecl+kUg0JbcsA4CKARImp/d5iC+SPg+9RaEuh9JyIwpfj6oW7qMWqBJ6ikRz5cSxwIOUi7RH2Wqaa3X5FOWXJCyZHUWYwCgK/Irh0NdbP1XwcEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLOVfVWD+mxTzOWNcQ5S9sX0lvXKNPs+EMDkn6uI/kA=;
 b=gRHg5eWsTrXlqCVfSdBSkbF7gLFL5lGNd7loDqukDsqR6ZYp1ZZI9na3vBGiqkrK9phv2pxZZml5zsmhB7jWZ+aOYdnLoEdLEOdkiHQpKBrQ/rrsTZrO68YTc0q5wMYzpxt9K3JSM71MsmaANdv3O5pBRKcldld5cuQclv6TrduBX7kOzCeF2FM1pZ5nRZ+AVCn1rh8NqvwDqW5SQX2+ocfQUEAdMEucqHlxg8kmPDTrz8ySfNnTo2rwf3wLY/zj45Ls9YdcWDRxp6s4vwp5GBcDbv7fzrz3dCdf9DG/HWBftfy6pwTqyOxNI9B0AFvW5PuDH6uZgqkAO2j6/gFGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLOVfVWD+mxTzOWNcQ5S9sX0lvXKNPs+EMDkn6uI/kA=;
 b=hucB5zqyaCrb1myVjn3EQVaIp0NGW9Z3hFGkG+Zg+NEAdQWGZKTabbzejtMs+hklAd6deAJ3oNz9NepyubDszta9R3HEpc0z4MQUQCQz85rm3QAEBkggfZ2886Nv9O7Ew0SRzj43rarLHJTXR6L0hYmyaQBbEhpaTfm1zjUTzYbJCdEocr0CGJMpmMf2WaPmzgbVYhGwWGEJUy9e2m5utQfOnd1+wP7Vb/47dxlXcMoLj1r89BjwSqzEKqQ44PSG69fBYqaV3G578wJGsXHXPxr5qdGaMEi7a1TNJ6O9kzNqVR+NCtcNQQA0rY8Zd/KsG7NzneHNo/n+/sceZ0MZ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 05:58:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 05:58:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:58:35 +0900
Message-Id: <DDOMCSEPNIIT.24H3Y1KQYHYG0@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] rust: debugfs: support for binary large objects
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <mmaurer@google.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251020222722.240473-1-dakr@kernel.org>
 <20251020222722.240473-5-dakr@kernel.org>
In-Reply-To: <20251020222722.240473-5-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 4996fd6f-8b00-4ae2-1a8d-08de11300b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlVSemNRNVpzQzFVUXFZSytVSWpoNmE4Q3ZHd0lRS0U5bWNVKzNRZnVhZFFS?=
 =?utf-8?B?bFRRemMvU2ZMTXdkeVR6R1QraUVBZ2hqU1Bya1NHOEpmbUh1b1JwS3dOaXFs?=
 =?utf-8?B?a2lHY0dYRDlXSDR3T0xCL1BwMEVkcjArRVBWbmVJbzViSkpoMTYrQmY5NGMv?=
 =?utf-8?B?UlQwVUh2WXhNQWRZUlV3QnRENWJTWXd1eEVhRmVCUUR3c0pRU24zVFJrYmNX?=
 =?utf-8?B?WjQzNWY1VldYUVJyaVorbzFYZzdoa3UyV01pczZaZGUrMWN1aTJoUmhjVFFU?=
 =?utf-8?B?TzZqNnhHSzNVU2phMlpKZHdOeWUrei9veFBBdXRFemRuRGFRbDB5MXVFMjZ0?=
 =?utf-8?B?SC8wUXZkQkxzMU5uS3FUVHcvWjNLb3dIMklnUFlFajF2MTZ4RUlneHlMTXFK?=
 =?utf-8?B?YlVFRGtQTFA4MVVQZWtiNmRocUUwU1lyOVhMK3lNL1VPOFlhQjdHQmVLekk3?=
 =?utf-8?B?Yy91UGJkeTByVTdLa2cxejM1T2dlS2M3VDhBNTFabi9zNHFTaXprb2RQMExV?=
 =?utf-8?B?OCtYZ2xCNVc5UE5xTG5DcXhTNjdCR1FtcE45ZmhYOFl5UnRtODZheHA5VjJP?=
 =?utf-8?B?Tk56K1EzMmZYcG55MjhNN2RuRUhQTHVqL2U4Zk1uNlZ2aktERm1UNXdlampv?=
 =?utf-8?B?MGExYkp5QXpNMXUvSmtlZHVMTlhsTVJKNkFqbyt0c1NySWlmNVdtbTBhZTEw?=
 =?utf-8?B?YTc0TjBaYzRKUlo2bEs5WTlLdHZNUDRIY0JmditEaWJTZGs2SnN0a1VMM0Rq?=
 =?utf-8?B?Zk5EVnJGalAvV25kVE1TS21ONEVKVU5KRURMVE9GQXA1blZGa09wTnVMblBG?=
 =?utf-8?B?Y0lINzRjanRmM21iVTFNaVBid0xaL0NSNGdGVGlOSytIdTBrcitkK0Z6b2pa?=
 =?utf-8?B?MXpXbzgvK0Vscm01WnRCZytGUzVBaXE5TEMydVpMc0FZV2N0Yi8wdVZkSzN5?=
 =?utf-8?B?Y015TmllUjg4eGJWc1NMSlh6dXczSTlDZ29XYkcvTjRQYUd5aGgzS1oxUmtX?=
 =?utf-8?B?cDdTbktWeDVLQTViSHVFQWVKME5rbkx0QUpMNkRqMXhJVkNOTnR1N3prdmZZ?=
 =?utf-8?B?Qzl4N2xBSUhNS0lDcXJsZ1poakFTdFZlMFRjMFltOWhEUUp4WGF2SHM5a3hn?=
 =?utf-8?B?eUJaK0RnamxJZThCUmdzdWxsWGpCOEtnOEdoRVI1S0VhdElSWmVwM2ljeEdQ?=
 =?utf-8?B?WGdsQmgrZGFuQXJuVmY2dDhVWG4yenZBWHYwRFRwWnFJZndtcm02ZDZrbHZM?=
 =?utf-8?B?NCtiSXlyeHpqUUhRVUdyRWVNVDBkM3hWN0dteGlFZldBanNuU2xUZ3ExMkVx?=
 =?utf-8?B?TWNHOFUzRkNSWFAxcEpTN1dOQW1QTHQ1Y3hxWlpFYVh3Y1czdTE1WC8yaVF0?=
 =?utf-8?B?Y3puelhMV0J5ck54aGdoNFRNRE8wUlZFRG1WL0NQZ0xFQVhPbDR0NWxHY2dP?=
 =?utf-8?B?a0RzMUxXSmVUcCtrdDBpMFhQN3pSUlVqNnVDWEJXUmNxWFpsZTJHODd0NG9R?=
 =?utf-8?B?VDB0Nmgzc3IrN1UrTkptNGk3ZzUzUUI1TWx0eDhRam9BVmtsZGszczVpNjQw?=
 =?utf-8?B?eVVnNldlcktNWUUxelFzclZPRW54S2REbUNvUGFEVytxZmxqajgwam91TW5Q?=
 =?utf-8?B?R2pudlpJeTFrV3hkSjhFR3hIUE5xVitxekR5VWJzYWQ5NjFCeEw4dXRicGdT?=
 =?utf-8?B?RWgyNm81U3FKYUNlSjM5dkVTSWFTejRJdkMxVXFydCsvS0tLNFpKNW4vZHlJ?=
 =?utf-8?B?eFZlRDlYL3ZkVlpIYzJKQStVVTYvbzd1MmFIdTU1M0ZRdlc0bnRRL0V2OTN1?=
 =?utf-8?B?SEovOG1WakNQYmVRVHliTmNkQXA2K0loS203aGFkSWNQVG1NVlN2d1ZFaVg3?=
 =?utf-8?B?WkJzdlYzd1hXMUllaXVWQ3lrT2poaTA5Z3RZdDVLV1NWaU5XSG50NzNsbE1I?=
 =?utf-8?B?Z0JxUDFYYlRDdHUyYTR2TkpHbTMzMHlHMGpRb05PNU81dDdFZFUwVEpzT0dS?=
 =?utf-8?Q?dRRDJXq+bL6woNwVCK6ml2LQs65V84=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS8xWlVTbWVPbTJGWGlKSnMxb2tJZEtLd2IvQVBVcUZHa2c5a1pTclZOL2tK?=
 =?utf-8?B?VXlIT25DZkhqNnUwQ2tWMkUraGRhVXR3NTNyY3dqRSs5c2k3eldhZUkwUUJ5?=
 =?utf-8?B?bW1BT1dXaTJvZm03YllDRmdyRmREbXNxeThDWHEyV3Z3T1NyaHM2TUdNMWZF?=
 =?utf-8?B?d3lYaExFMDZmWGdIL1BLU3E4RnUrZVBrc3F1QUExNkEvbEQyR09ZSjc5S2lV?=
 =?utf-8?B?TUo5OEFpelo1RmsxMWVSWUpGNWVPWXRybzY5d2VHUW1pa0tCUElKaFpxY3h5?=
 =?utf-8?B?V2l0TVpVdVZMQ0prWisvTVdwUnQ3Q0liUjIxekdUNVZ1Qjk5dXowbkNvWmF4?=
 =?utf-8?B?UUJkWXNFaGY1RWwrOXgzODRIUlh3Z1ZSckg2THdSUXI4ZVJkZUJ2WWhyNlpD?=
 =?utf-8?B?M2poYXVNNE1sb0pmQVFvRXpSRnlkdTY2YXRXNnNHekxUNUhERzhmeWF4MHJp?=
 =?utf-8?B?Z0Z0TmJxbkFaZkZvRmcwREdjS0x5dmdKajVNdS9PRVRpUU9zYVp5RzZVejBw?=
 =?utf-8?B?eTV3bWUva0lxdXNHTTdUcXhyMnBiSS9GQ3g0VjB6RWJsMjJQK0JJVTRyOXZq?=
 =?utf-8?B?elR6M2hlZnJTNHp3M20vSDlvQ0RiZWt5aGxPNC9ycnJVaVhiUmd3ZnA5ZlUy?=
 =?utf-8?B?K3UvdFpTU3czYlE0Mjg0T3JjVzROWjIrbEJmTzNuK3AvcE9qdzdtRWpOR0Ro?=
 =?utf-8?B?SERZOU1vMFNUd2JNdGxnK2F5Z0pldVVGTjRpYzcrWVVNWTZYSkY4WXBGUUEy?=
 =?utf-8?B?UmNvSEFQYTVVbUVhVEpsc2VTNTM2QzUxaldEYUk5T0NXK2l0Wis2dUxZYUYw?=
 =?utf-8?B?RllvVWFIc1FsUW5PRU9TcG9JdDIxTVZhRW54VFByWTNKV2svdjgvZ3hva1JY?=
 =?utf-8?B?TGVMRnNIaUJra1gzb0ZnN3RvU04xbGU0cmVFN1JJellDaTFQTkVpVkJlS3ov?=
 =?utf-8?B?U0hHY3VFTmhmcWNaS08xU1g4VzRndWtBWVBldlZtUFJMSDBCcmtzUFhwYzNo?=
 =?utf-8?B?WFZFeVk0UG4wMW9rZjhLV0k2WFNLRUlaUkROaDY5Y1g3L01MSzVXd1gxZlhP?=
 =?utf-8?B?cFc4NUtBa1hEMjA1bXBkc0ZxTno3VlBETzh5TldIUjl3R1A4a0x2VWVsMjFm?=
 =?utf-8?B?c3B0WmV4SGZTc3g3QjMrSkJvL3FvNHVRdE5UT0l5UmFpTUU3OUtaWXhic2FK?=
 =?utf-8?B?T0xUNlhTcGdoUEJObm5yWkVzL0x4SzM4WDJGYzF2UnNBK0RCUnpKdjJWZ3Yx?=
 =?utf-8?B?UGp5eEp4S0cyMVo0Yk9vemh3bFdtblZlaVdKUjQzYkVvSDBhc2ZNUHRncW5X?=
 =?utf-8?B?Q2trTVVLcGZaa0Qwelp5NFo0c3J4QUFHVndDYi9VQ0RxRG9WUE5jdUJIZUNZ?=
 =?utf-8?B?VE9tYjZHaHlxZS9LcjlRUEw0eWhWc0RtbW8vZm1aTTdaNzN3YUtpSTdSWkxH?=
 =?utf-8?B?WDVDN0FWTkZXWlprVnRpb1dIZDRGR1lZb0xmUVUyWWUveTUybUp6LzNtVEdP?=
 =?utf-8?B?anpXbmY5N29CRVVkT1VNVXl1bUw0alRGRU0vRWdyaXIzQ0FQWEprMmhGQklx?=
 =?utf-8?B?RFNYZWdoSzBuOUFuQ25zM2RKUWF4SWpUOEhtdkdkc1J0cDZXcHBOeTc3RmVk?=
 =?utf-8?B?TWhrbFFpM3hjWTN6UWIyTmxTaFFWZU82M1JBODZkd2hnc0ppS3VTWDBtbEpn?=
 =?utf-8?B?ZlgxRkd4RnM0dGlvL3hPYlhYN0U5aVd3SEFvZTM2MVdKOThKWVlIdWxoS0wy?=
 =?utf-8?B?WHJONEZsM09JMWQ1OW9RaitLN1k5NVMybFJtbkRmWDBUMDVOU0R6RWs1QUNT?=
 =?utf-8?B?S0tjMGY2c2c2cjVMOTZ4UHN3ODlUV2dKQ0tXVmdzR1Q4ZkxZZXJZWHlxVlp5?=
 =?utf-8?B?b1B4MVNNd0FtOHpVNVJiTTZpQ0pWK1JxbmF5dVdHM2JTQ3pNdUpDbitBRTE5?=
 =?utf-8?B?YzhpaVVaV1lFYW5SekgvZi9PYnMvbndOMEFuaGVVVTlBaFgyTlR6QkdYeGN5?=
 =?utf-8?B?cFFSeEo3UlFZV2RNczdqbHRLc3Jpb0tmK0hDSW1PNEZRcUgwRU9mSEgzcTU3?=
 =?utf-8?B?UWZHc282TW4rUnNFUWM0d3NmZVV2TTdPVkRMVjJJekJzalN3bk9hYTBsYjUx?=
 =?utf-8?B?YXVaUkpDNkRzUG0vL05XcXFSTUMrUnUxZVU5T0M2NkZOQ0Q3eU1sTHhlaTBh?=
 =?utf-8?Q?hZWhA+wEI5HNV1QpUJxSeVq4h/2cgr8dldpdgOTSFm5P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4996fd6f-8b00-4ae2-1a8d-08de11300b7c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 05:58:38.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efWDkMpRNV0bA7vlX1vSvdan4JZ6X9NfLD+L1YCyood6B9t8Z7jSN6RHar7Gfq8TXT8zEgMiDND1LQuceMP2/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

On Tue Oct 21, 2025 at 7:26 AM JST, Danilo Krummrich wrote:
<snip>
> @@ -65,8 +66,8 @@ fn deref(&self) -> &Self::Target {
> =20
>  struct WriterAdapter<T>(T);
> =20
> -impl<'a, T: Writer> Display for WriterAdapter<&'a T> {
> -    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
> +impl<'a, T: Writer> fmt::Display for WriterAdapter<&'a T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>          self.0.write(f)
>      }
>  }
> @@ -245,3 +246,139 @@ impl<T: Reader + Sync> WriteFile<T> for T {
>          unsafe { FileOps::new(operations, 0o200) }
>      };
>  }
> +
> +extern "C" fn blob_read<T: BinaryWriter>(
> +    file: *mut bindings::file,
> +    buf: *mut c_char,
> +    count: usize,
> +    ppos: *mut file::Offset,
> +) -> isize {
> +    // SAFETY:
> +    // - `file` is a valid pointer to a `struct file`.
> +    // - The type invariant of `FileOps` guarantees that `private_data` =
points to a valid `T`.
> +    let this =3D unsafe { &*((*file).private_data.cast::<T>()) };
> +
> +    // SAFETY: `ppos` is a valid `file::Offset` pointer.
> +    let pos =3D unsafe { &mut *ppos };
> +
> +    let mut writer =3D UserSlice::new(UserPtr::from_ptr(buf.cast()), cou=
nt).writer();
> +
> +    let ret =3D || -> Result<isize> {
> +        let offset =3D *pos;
> +
> +        let written =3D this.write_to_slice(&mut writer, offset)?;
> +        *pos =3D offset.saturating_add(file::Offset::try_from(written)?)=
;
> +
> +        Ok(written.try_into()?)
> +    }();
> +
> +    match ret {
> +        Ok(n) =3D> n,
> +        Err(e) =3D> e.to_errno() as isize,
> +    }
> +}
> +
> +pub(crate) trait BinaryReadFile<T> {

I know this trait is crate-local, but having a short documentation for
it would be helpful for first-time readers like myself. :)


