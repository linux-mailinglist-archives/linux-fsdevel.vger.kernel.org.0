Return-Path: <linux-fsdevel+bounces-39171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185BCA110C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 20:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373AC168AD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0620458B;
	Tue, 14 Jan 2025 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HK3XVSDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA761D5143;
	Tue, 14 Jan 2025 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881520; cv=fail; b=Bu/hECmoj4kn2zLJ79AEaIi1PM1yPRqHhN+/gPJoxoH7zBnfIbAtctLbRK/rQp8Hcj7FlSwwoPH1GBf+PJutYPFbTyptTwSvZBYOVH48gfrUzJYAeTS+HnDiE3G9ufahAgUYu4BEhUP7KNT57G5HyFzkqggxi3+ySwxwaoYbwbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881520; c=relaxed/simple;
	bh=BpDA5mU4L0PPNZzo0g4pNf/kJLFJ+/ntb2ma2NNkuA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R7mEMtxMk/jpk+fG2mJO/GscATtG1fD+Rxjqo8Z+BJizlpEe/KN13bUsQKiFCM05CFHm/2ERjT6KZSG8Qm+RlU6fvHKlNEetmlxjry+8L8hpx64QWUdyfaIiIYsZJUGUPBge4lMOoi40z4WCqzpP8vVzOH0fnOO4AAIYOO4rifk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HK3XVSDa; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736881518; x=1768417518;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BpDA5mU4L0PPNZzo0g4pNf/kJLFJ+/ntb2ma2NNkuA0=;
  b=HK3XVSDaTp3UnJH2jpMT2eOcmsP6+OqPneC48Z76in2D490HzAvNeJGA
   Qs8xroJ5iwAilt+kz55tQ75OLo6nhczXtLlkU9vBsGvYBZBfZI+FjS3Se
   XBl6MAF4tH6aHlSWYzjsI11jyd/RLd+Spt1B8vhlA/nb4CUlgdJzhh6eB
   4qEUPjHqVMByh0Atjqg55e88toXhLaflZR/5WfDVqV/RXKfZhlDVNOZcB
   pQO6dyCyqPdFl0rxyJg6bINog7XIDgU717GXUde+xUTOtQufevYjE9XDD
   VYjUX6lRFXXK7673mlUxfX4qYfq8ub0/Vl6wAPFnMroUv/i3F8GYQl2rG
   Q==;
X-CSE-ConnectionGUID: 3dSc2KgMQlOXaK1hviQsJQ==
X-CSE-MsgGUID: J+kIQM/FShWe7Owtw3Xh5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40872916"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40872916"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 11:04:09 -0800
X-CSE-ConnectionGUID: IHadNigEQv6jB96c0tlPzw==
X-CSE-MsgGUID: sLbsqhXvQgiZ2O6dMuZt6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108947757"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 11:03:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 11:03:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 11:03:41 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 11:03:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGbnHAztHucjTe12A9XHRxrZYgIwIey4NY6Bqm5BuILQsP6iWRcdsOEub7g9cvljOb/UeDR8CeUEdeaBlZjES27Ig03jDWM10u3Mql44tes3uQGB67Xq1M2KR8TxL64QDq+Ha6obbnruZWNM2nvztkl5cuPITso0VhHDOB6w06mkTPgLsgKiaZWkjx70Z0TsUflLB6BI/jA2cncdml8NcMp3Vs+JRwsqYg4Xc0X10Vx4/eAZiO3RJx4H0bID/8Eb16l+zA6UJ7K5gFXyfWCcaQ6u1U6ZhbtlzlBmkhEoCb4GuNkuVHeJUouHeVbBwez1cKKg7n4b0jWHEuVZ1egCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V7nhTs2/DcjENjxuMrL/VjH32rJOKo1iudfcp3h9NM=;
 b=XPi0WCFKv85Ch2ZCimUAdgtO7qpJuiTu4jnXc1Dq+/kYO+Ki3jKjD/eQG9h516gUGqlhERIjDRQjV/aa3zf7zJiXCuC15IBwFXwdCqFfNLFVx3uxRqa+GgA4gWw8K2s7uIKSJjWJNRckDYRatTP2o1XK05Jw9mff+9x7J202xNFT0q13mQGdDLPYLITzB0QM5GVfW7qjzWA5kl6VG76M0thzClTwwCsG7Ph6TYVsfQnNIQQLj5HhURGFr3FTsALg91DYlV8B+W0/0KjX0y4k3S+o9OJ8s0zVqigh2/HH2rWmm6mOablqa2vz46jnvL8/wIrvf498fGo6OoVc2csPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 19:03:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 19:03:36 +0000
Date: Tue, 14 Jan 2025 11:03:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: <alison.schofield@intel.com>, Alistair Popple <apopple@nvidia.com>,
	<lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 24/26] mm: Remove devmap related functions and page
 table bits
Message-ID: <6786b5042faaf_20f329461@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <42a318bcbb65931958e52ce4b1334f3d012cbd6f.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <42a318bcbb65931958e52ce4b1334f3d012cbd6f.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 485f96f0-8827-4d03-df61-08dd34ce264b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LT6FEb7V+IJQpITwnWrQ+H6dYvISB9/G/LOXF6Vh50UbvmBqlIpLJg5BSage?=
 =?us-ascii?Q?2o2V/Onsqo6PncDZAUjJqtJoYBfQ614bIyDJGoFBbCLUXa8KKNAR2Qt+4lla?=
 =?us-ascii?Q?f2jD2vind31400UNb3BMPLGewAr06T6hfUSQHh0KZpgiZpcjE6CfwKwng2kT?=
 =?us-ascii?Q?RD8mKIUjWaxPzyvxoiZLKUrkSicSoDiIKAQt/flQsIdZRiKZjyLyly/lrvGG?=
 =?us-ascii?Q?Pd7aw1Bzz4lY2xiMopHIyoGuuZvoIfnyvEZyJ5BUywnoJVjv2dHpZOH0FXcD?=
 =?us-ascii?Q?GhrEO4yLNriTJwGNSb6RUker/y6AvLS5ao8NGPycER/bsBOpJ4xDawdM0Qe3?=
 =?us-ascii?Q?lxVv9W7p56gdPWWMJQimyGYgIGQQcJxRH+JvAndBm4PHWph0FZHPwX9hy1kt?=
 =?us-ascii?Q?0ZNpSWtqoL39K/x/nKhCcNefuy5TOithZGSg9hEgvYdmQq7MzFgZvqCdz2fR?=
 =?us-ascii?Q?RVjepnPD/vZiQ99NCtWNSYajr9/XU/zM+8nxpfq3PZEeooywVZkSJiP7Dhxw?=
 =?us-ascii?Q?oCfsg/Ik26N2hwZtQRKCr7XpaMbWf/ANmQPXgYaLBOaOHP3INIfTLwf0guLR?=
 =?us-ascii?Q?ltlxM0UVXfdFEo0XZANNPz5SJD/KhPOVtvQyhawF4re5yiDA3BWMlHg553Qs?=
 =?us-ascii?Q?U0YgoJgM/SgptyEva/n4rXl43532xX9Q42W+pi59yWZVJzENjEsrIx/IXU1x?=
 =?us-ascii?Q?20TijyyRqaEWzDXnsiJgQN+tCgd/n//hdiNSE4kYnJrmpbgYhBhJRCxz+M7i?=
 =?us-ascii?Q?UI8/EddFFMIqNuyIbdrWDy44e9Zn4PB2HhvKgSJamzmZ99QivnQ3N8X557Et?=
 =?us-ascii?Q?/TqdTRpwOJTy/ihlKg0zWk9RieQg4Li/aH6Qd8hgeQS6PgeSEs48Mrd+W2r0?=
 =?us-ascii?Q?ANvbxTgOp9nNDWbTai0AI3UyTJfwG19IjdtWhxPWtVi3IH3LoubYwYYeCv0k?=
 =?us-ascii?Q?uQF4WEA6GQlXwph2BgRev/Jp7V5jhYxewA7eh2xdftcKYVKRg490DLTyBBZ9?=
 =?us-ascii?Q?w2Yz/zptsBoJQLwd7KUFuPCNqr3l8pT6ew/EDBrjfW4bSTJ1M7elpe6Wl5gI?=
 =?us-ascii?Q?LUWKOCewhCXD4Anlnz/7kyjYhTQvVRKeYsJkp12asTLz7fdTMoetOfDCbtu8?=
 =?us-ascii?Q?QrhBiVvHoGMfxWuqXNlXZY02/P8IoLL0d1ypRlJco4sr/mYrOGVE0+eEg5kB?=
 =?us-ascii?Q?7E7t69lih9JzxRCAHrJhpMASXaUND6Pa4Z1UaWUay66nYN8GadThLF31Cm+s?=
 =?us-ascii?Q?H71NF1Up457/vFGDbBPFIACO8Tmk1anehLdD5QMsMZaqqM7Tzm0ogFBXiLQJ?=
 =?us-ascii?Q?6IHI1wkEuHuX7WZ7nPC/M7eXx0Y8T69Z5PENc1iOOXhHESPq4fG5+MpMvfum?=
 =?us-ascii?Q?ZfVaKJnuGdXzPYvsBXKVVH+cweek?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5QvotG+uk+5cELluKYFpXxqVNrqtPycJ6oVG/PhbfsUAfC2BhcheJYsmY1dT?=
 =?us-ascii?Q?v2DH7a2n71pVLstI7UNfskRzOah+3FFBT7zd1cI4YqlUR+lkjmmnzEclNHpP?=
 =?us-ascii?Q?ZZP19svUpmhLb3WJvtBMfwoSCiCIp/3oUC1Nl1JIrKzy1rLdKyDU2UthKFUM?=
 =?us-ascii?Q?HbNjcvn+UKbCq2Mi97yD5riU+70bA2xSX7IA/6gJm14SgLY5fkINW9hmkkEV?=
 =?us-ascii?Q?ig6NHZu6O64LFOp+NKmgrz9ULAKK6knoH1Hl3fHY99j4/BwQXymO8A2uCFHT?=
 =?us-ascii?Q?Ni0IFe+nxPh83MxJ/RjbDfDN5HS+O/2/57+mt9p/1sIJubrLjGIKSYqxzTJs?=
 =?us-ascii?Q?sg/TgGBNGlNXWvAdkqMREYJKdePrI8maAIvOKPK954rDrYKg3cb4GPVjjJgm?=
 =?us-ascii?Q?XHyYCBZrpauN0cRwnm1LQ/ilDk6xvTN30EpYiOxOUOXTdbO68FHb25F4E1wl?=
 =?us-ascii?Q?17pgs4zlBWv6vzRDLQJnApRcYVnEvtykc2X3yzigk2xigzwwPL53nEjZ2Pzf?=
 =?us-ascii?Q?2QEQwXHrR2uuS+/yi24+4TWfiBMwKSlcoRUUhOIiIGZQgoK9htNOcSpGYqHo?=
 =?us-ascii?Q?lC7fWneRMC6vHNPaRw23WX2LmldY+TSrCa707yyLvVUkQkyaFF3/8LCScstQ?=
 =?us-ascii?Q?8BD4H19KrMEDIqWNhj30k9dKl8/PcDaTqBDHIaJNeSlq8Ys4T82B888ZkLl/?=
 =?us-ascii?Q?qMyaXd4NLSH8oHcdpg142qqr/Qjv6PM4nqtZ+48u4KueKWP9RMOvDuPd+n3R?=
 =?us-ascii?Q?hMeZVC9u642wdXN9SsLcV/Np8Y8L8JJd5OMMl9TdHQUZ+R5aLXvgGPqywS06?=
 =?us-ascii?Q?0hfZKv/24Q/NCrfyCwLrS36HkD1gR1VRbHAtx7eRCFf/XhMNK7gsevcphhF+?=
 =?us-ascii?Q?KFq+5d1fjFTw/ARxTmMALIsE8bwyMLEO5X4rS7jnQ0/eZt7Q0+s7f33bCJF+?=
 =?us-ascii?Q?bwRQzJjGCqHZkW47uyI8awDWCnqsQJ5Wf103NlRLzYmGHzUt92OdKe5V1XDF?=
 =?us-ascii?Q?DciOthfrjXS7adUIs0U0nn8u6Cjp2hebvtCGydozFiUlw15txIBGApEvxD9p?=
 =?us-ascii?Q?aWaIBGH+g07GjPaxgN6lGALEdPgBWWFeVvrw5e3+BYQL52gH/KOLTd6Du2Vu?=
 =?us-ascii?Q?iMFmcJlLvqJYeEPP3Ghux/YlBvu0TbGlid8GYTKC9iFV1E9GjkDgBY9m2AY7?=
 =?us-ascii?Q?ht3Wh3PSibM9HdAN2e2LkyMYPN9jzDhBO0jl+77FiVjqrLLV/zOM2HB7+fjm?=
 =?us-ascii?Q?Lfw3GsUhT/dnxtOahiwVv0vHeSelNGOLTchrEm4ZS1SIJQ6ixsZxVVDLlHbx?=
 =?us-ascii?Q?U1FRUfN3ZfNia0aSQ/ZMUn+aRDc6lvl5MEAwaCb2pVvp4XR5Ad5IDMu5aY1y?=
 =?us-ascii?Q?z8ce503XfUR2gNRITaiTZZadoCGiZeeCXyU4CDGnXYZHlPClRiUnmGKfEoBE?=
 =?us-ascii?Q?bJ+Hy0wzZN52gammQf4gA5g1i4uAYpVUxuwFOrNq5DuYlO+Ua730bjh/BBjJ?=
 =?us-ascii?Q?2+w4ROtEsJXD92+gni13iFPhlEplR7GyBJ/ekZ3tzmUm0h0om8+JpGkFoX55?=
 =?us-ascii?Q?uq4YV7inHvnledb1QG9t5ltF/SOcT7b9dlmY5f3TGPx1hnh8XJi/V8YVW4Yd?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 485f96f0-8827-4d03-df61-08dd34ce264b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:03:36.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4gQ/mdMWOSFyyJiXIWA61+kggst/stmMmqObVTSu+/NUgGTfVew0sR9IrZJsIFth93d3WOFoLre6JzD8TKz5M67VhGqEK4/CVTBHG8A4MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Now that DAX and all other reference counts to ZONE_DEVICE pages are
> managed normally there is no need for the special devmap PTE/PMD/PUD
> page table bits. So drop all references to these, freeing up a
> software defined page table bit on architectures supporting it.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org> # arm64

Hooray! Looks good to me modulo breaking up the previous patch.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

