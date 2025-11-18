Return-Path: <linux-fsdevel+bounces-69029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28226C6BFC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 00:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 6F99C2907C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 23:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DC630FC2E;
	Tue, 18 Nov 2025 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KirDvURg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14446277011;
	Tue, 18 Nov 2025 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508324; cv=fail; b=IPNuug6nf6pjyim5EAxtfUnIYMpr3YqKXTmgZ0kYvyLD0UhM20oCq79icUsH5ETG0+Fhp4wELTm9ZmB65l5fXCZep/rXkl2r4Q/fyzcK1ZnbPcecLXLZWBsln+qvQCU6RW5RmlShBowxB5HYsjrKoZQoUGetn0wrH+m7B7wsGAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508324; c=relaxed/simple;
	bh=PKxMVNgpbupr8e9R0di3WDFezuWWw8NqTqdSKYvxZVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GdYAItEYMVzkznEIBS3pn+PB8zKkXvm+UZs+Twusu1OwCfa4xDTIhpwE9RmrOWyi+9b89SyK4NDVZEL9xFQaCw3mqhke39Y8DImUcY6rzLv9e1wZF3w2VyO1bQ7zzkmz8+kPUVuJGqrHNYhH8coE0irPp9yEv/cnVSwVdj00RWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KirDvURg; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/w4AYP4I8qAZ7BVrkwOuN1K6NmFuAqwzgL1R7zd5GgsiqI/boUvwUXYI2e1ftKWfeiGbiMfRpfrqsTE+HDUUpR21lWwe/85M/9hS5AH3yvxjmeHaIkpZBMgmstQp9UxmvCW5yra5a3ONrNq9xq3cqM522O6E60/iYuZw6AoqVa3pBXsI02mcUYam7KHdBxp+jIC37oG6CA+ejIr9gFBLFXEnDaptFfJgv3VcckUUXS1fuCZxFRlIX0LYppqfLULC0vsVk+OgT+diLiuIBP0pYXwkrkgKPojGIl3nEYFTar6BhrXk2TdRoaXMFzNzzzP5Ujknfg6Pi785avsEKpH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKxMVNgpbupr8e9R0di3WDFezuWWw8NqTqdSKYvxZVU=;
 b=J42Wni+NjICa84laYFBx911f0/UkSSdzkERuFRry+slbNAvyw51jc50uafV6LX235Xw8ywgEUsqenZUtC5N2lNv+vyE1CNxt4s3iYMrk30GM96GUqq4oerqoOrzs+ytNXnwLhLSO8ki+c+65odYl4UI17VstUBOGHcZYbBid2pAASYhPMLtgyfuxCD93imR41GyC9On7cjjOYGQ6D28MLibrCpC/bQZZJL2wNddqjaSlp7BlYGtDq1UzZOU1kFEgrrSoFUXdr5bCm5skkbiKxDcPdHsJjX3LykMas/J/ZUx4YLicOlQ64sKagLQyrSJmpU9Cl6nwwRMDeFadnqBMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKxMVNgpbupr8e9R0di3WDFezuWWw8NqTqdSKYvxZVU=;
 b=KirDvURg92Hg9Z0Jj0jcWjsDScJHMDIkmECBjdTfanU3+r+POTfWH7kWYHNITSSt7brDWAcF8Q6VDBKb02yj6ENNU9vokkcvMS3447a89HptJcJ7wHLkfdNxqvKKl4Vv7dVRd/8tMm0AzRPOgT5X6kKpS/5ZeE4fiSxOVDennMYFtBZfgwkcNrUDf101yi/qoH2Ou6vs8JwNS7AP5NudS7bJcVrPHkfzf1Xkc6eK1aRsQPPrDpuqzCB5w+TQkjp4XWj5FfF1e8ndoVL+icVw2SETVkJbrkEcXW5eDNWBH7ewZFmEgeLVgNa/rnPcJ8Wyn0Fz0olenDEnuMEUsIsILA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 23:25:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 23:25:18 +0000
Date: Tue, 18 Nov 2025 19:25:17 -0400
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
Message-ID: <20251118232517.GD120075@nvidia.com>
References: <aRuODFfqP-qsxa-j@kernel.org>
 <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
 <aRxWvsdv1dQz8oZ4@kernel.org>
 <20251118140300.GK10864@nvidia.com>
 <aRyLbB8yoQwUJ3dh@kernel.org>
 <CA+CK2bBFtG3LWmCtLs-5vfS8FYm_r24v=jJra9gOGPKKcs=55g@mail.gmail.com>
 <20251118153631.GB90703@nvidia.com>
 <CA+CK2bC6sZe1qYd4=KjqDY-eUb95RBPK-Us+-PZbvkrVsvS5Cw@mail.gmail.com>
 <20251118161526.GD90703@nvidia.com>
 <CA+CK2bCguutAdsXETdDSEPCPT_=OQupgyTfGKQuxi924mOfhTQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCguutAdsXETdDSEPCPT_=OQupgyTfGKQuxi924mOfhTQ@mail.gmail.com>
X-ClientProxiedBy: BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: bfeeeadd-a33d-4707-7fc4-08de26f9bc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UdMvBiMtbcyMlCSMxiIW/Hj7fYrvzoNjVm/mDl8vykVIsoBMJhQn7hqswb7S?=
 =?us-ascii?Q?/VmMR4z1BFZEaYgQ7Ot5Pf5InWKQBDncgDv/dc3XGG3FgweThOvBNYCgFBy/?=
 =?us-ascii?Q?6hrMOrBQ0G+BNRL1DAWhIR8DZ7svax1aURsphCiG6ociB4x/PM1Q+JdvuYwm?=
 =?us-ascii?Q?roAEuXRBD8f3pzZ4CBw483AXaW8Vk45k/elaLx+n1UAkYO7PCUYvd6mBWfpV?=
 =?us-ascii?Q?xN2MR9zsnCMZk2Bkj3Jmgz624xYYKCjYP3YjVU+9EEmqKC3vTGn7Wt4SNl+O?=
 =?us-ascii?Q?trmxRyiD6OXDPvcEO/AFBYo1x5eq7GOn9967kbJqpfQl2uhx+82iLzKpLhZ1?=
 =?us-ascii?Q?oj0RTu7gUYY9sh8PAlw5Vcd8SJVO2TLCAqR7pxgrLYcg/MGtberBszNHb6SJ?=
 =?us-ascii?Q?R/u1SjxL5wpYUOFJiFeD95hwfscQCXQLPR3UXrL/5k8n6xWlB+6kdvHpRWxG?=
 =?us-ascii?Q?Ii/gBgXx17shZHcjUCAaxZTlncrQPQEeNd6s26o0NfcScmbKZrV53am8FGkw?=
 =?us-ascii?Q?ELclpZkyYsiUA37tsGxYndjb0q7iwLYlSLdTsgmeJcHtYHvORAzS77KDGc51?=
 =?us-ascii?Q?S/hfFHgveVxMtE2vT1rcI4H0ppG5WcdF8qYb5Ek10NUomtZ9JTJHlepTyRbN?=
 =?us-ascii?Q?Ap0/EgX5bFQtOCrnIZjV6i/l7BnOIr9M/sMc0gr0Yafno9GewTno7eCyW5YG?=
 =?us-ascii?Q?v7HlFns0f5ckyYcyfdPvgfcvly8/J6W3yHB1emC7WKeFIcdxJVXTKR/9pmCp?=
 =?us-ascii?Q?t0CztIA54HYqFgXSlPlZbYKwUTGSxFTpfJyuSKarwX1ep1FoF+fSNHQWZm8t?=
 =?us-ascii?Q?05nJv351um+3dpu+B5Gt3yt/EnSjSDXTVNmnW3Wz5B9gdFHy+b7sOtxru7iH?=
 =?us-ascii?Q?ZhzLm/PsF1tuZXR2W2B2zqOYQR6r1ga/JfN+8yURDXIKvwGoGmDxOcfOp897?=
 =?us-ascii?Q?n+kkPh8vIy6ao6HFbS8R78uMP2XAtJkeCC4rDhtUs+NzSLQyeTdVL+mCBdXb?=
 =?us-ascii?Q?480AWmBGJ1MmMV4vJzVLOPzqVu4pQKF05XiBp6R7pKf3gCKZvlSxF0YgPMFV?=
 =?us-ascii?Q?pHXppjdjvTXtSHxg6Avjagn2h/4Sr+X7lwq6ZeEEPDwXgCA5HunPyNqDJquw?=
 =?us-ascii?Q?Buq2krt2ebX59Rs+KUOODG+71JIS2qMb3HCbn1NsyuQoCuSNsKFQ7H/ObIM4?=
 =?us-ascii?Q?UYmfaqzvYCY1eWY4Si9ur2yx9uXqOdt2UFx0BGgV7pXMJ+YNiFxrvB4bFSY4?=
 =?us-ascii?Q?nQoqXiZievq6btvL6ke6bb+PimEsBGhYc1af5hYnGSPi0aFV4CqbYR3BNItY?=
 =?us-ascii?Q?ELp3z8Su6yjKOsWjoJOQgm/MC8N1ssxo56R5VFxqsALasxlZw8K9QWsZZDi1?=
 =?us-ascii?Q?Xraio3WkhUL00IVFhNjWK2gJIJfKnBhSfhfbBH+ooSE+lgFqWoxTGmMcGTl7?=
 =?us-ascii?Q?SmnWpl+ugjeyWhHgjosRzMIIw+u8G8Tb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qR7gcDsiZE3B/i5IfVFDElltut2+4bHqdQ+UQDy1I71z5BnCnvfaIeQe6vr+?=
 =?us-ascii?Q?BORIYJTYTocUh/YfZOR2s2pVe70s7EiZZcaPrsbDemv16Fqq5uaQGDVLn2Fb?=
 =?us-ascii?Q?L9VF7FnqKuiTIXarX2y3oAGOEHrQpxs2uyLi8T1MYUx+oGTTz/NPCAXVTDRq?=
 =?us-ascii?Q?GXqzVmharGG+fZll0868bvnpfB2Vb9CtgcvpRPDkxGo+c+0CcuIWmsl4/V/Y?=
 =?us-ascii?Q?Py/hPDyusWoEidtuegonHSKNsAqZMH+cZFtwdtKcWkSaYOBxe/W2J+B4pmK5?=
 =?us-ascii?Q?PC5ETc3OYOjCYh93Jbs0zI9pRqFzahbXDX3lK56edn7ZmpUOJ0TtqljqtMyn?=
 =?us-ascii?Q?aU8BiqTacZUoQqHZxvvWNxAQUBVeqId1t9W2NG9ZgBe7XopHsnMeERGys017?=
 =?us-ascii?Q?cMEkzQSdDmvIDFpwnJ/cmuL3FciPutZ+sXXxWawWrMBvptO6sqodJWRFKq/m?=
 =?us-ascii?Q?ZgoRG4xhaj+aR0prCrMZ63MgtGJ+4KGOElScmAhPuPNc3R9xfG0jqxTKiUJg?=
 =?us-ascii?Q?t7YHUbDlH84Mhin2AOI9LMgwc8TZnaeaeSToIacLXudDdkstVYrA/p8JSiAz?=
 =?us-ascii?Q?GdnAEC74bc/HfFYk16BiTiWKnlDkNuqbpO1CTrdOJ1pChk7/eSZPD7K3dBbt?=
 =?us-ascii?Q?Rb1B9jfhCHs1sGYdZLBgUM7/k9MNTeNuIiBqSNNPRrhE+OxRpkBRjsH3/inN?=
 =?us-ascii?Q?HB07v3+897dcU4VYtmpRw6Box1ulxla+VFavryVZF9mkYqtbs54eRTvsjBeS?=
 =?us-ascii?Q?+AQZosoUbgjsAOpqJlb2gMVZYTBeRM+0L3MP3Rbq4xJmX89ks5UZtwCKeWJH?=
 =?us-ascii?Q?iaj2KfDAjByKXBhISowZHAhqhhKGrafxbMxJQpgr/+V68j8wADTHd+tZnsut?=
 =?us-ascii?Q?0HdW2isCETnmRgL5KwJFLVkw30ro8DKdiOLVJz4DoDTx6gl0658Sc8uf3y4C?=
 =?us-ascii?Q?C8q26qgUKiiD+levvmrqC6jv9k1pXZ+36NKwpnvogbyca20hueR18x7SKwtO?=
 =?us-ascii?Q?vkVmEO5d1dvlSAI0FWHkyhsmNegILfcE+eH7OY+D38uDMC7c6RWYPv/z+ndy?=
 =?us-ascii?Q?8KzDKU35Pw3c/HKcKUJC3vAup0ovO20GnDG3ZRokfhcsykSlOv8Uc8tfkRvk?=
 =?us-ascii?Q?/W9Q9zJ97woho0dII6G4MYVkefg5KkvMyxjS/fUZBDtkKVWn7ZhvXBA4ThAi?=
 =?us-ascii?Q?kp3m3stlQ/rCqIq4oYNrfXgmWhVI1/XA7HMi9fuMQbu3Oogyk9Da5kjBDmbF?=
 =?us-ascii?Q?pfNEXA/LdIwT0NVLBaOsiZa2T3WLFDpDPhhyclzwEvb3r+LwnQfqGxHlVJtz?=
 =?us-ascii?Q?/g0wcxhHJSaq7vjVJy36d+03cgNT2NuLEKSnsu4UBgfiQ0a2LlyueiH3TmbQ?=
 =?us-ascii?Q?fOhoyULVY0gdxhwbyuCXlFDujXEth36bOly5DOWDFRiNX1S78+UIkqOMlJGh?=
 =?us-ascii?Q?R8qLq4Bhjh40RiFyZ1URF8s1s6CSMa69WYdOszo4GcK0P3W6xg2wgQcoEay0?=
 =?us-ascii?Q?fOOK5HllatfVgp/qsAf3jPsD2n/7/nDB2R4/FSvs2FvuEU4bAcUHmotUb/eO?=
 =?us-ascii?Q?uvwY+FPf8GX6vMr4wbQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeeeadd-a33d-4707-7fc4-08de26f9bc7d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:25:18.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nGpowmSVjhz5/XQjvwdjURPJd/iVOaVhJ/T0VddUSZpa5+Q1iOUTOWrtLu926Ri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316

On Tue, Nov 18, 2025 at 05:07:15PM -0500, Pasha Tatashin wrote:

> In this case, we cannot even rely on having "safe" memory, i.e. this
> scratch only boot to preserve dmesg/core etc, this is unfortunate. Is
> there a way to avoid defaulting to identify mode when we are booting
> into the "maintenance" mode?

Maybe one could be created?

It's tricky though because you also really want to block drivers from
using the iommu if you don't know they are quieted and you can't do
that without parsing the KHO data, which you can't do because it
doesn't understand it..

IDK, I think the "maintenance" mode is something that is probably best
effort and shouldn't be relied on. It will work if the iommu data is
restored or other lucky conditions hit, so it is not useless, but it
is certainly not robust or guaranteed.

You are better to squirt a panic message out of the serial port and
hope for the best I guess.

Jason

