Return-Path: <linux-fsdevel+bounces-29797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF5C97DFAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 03:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3301F21480
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC8191F60;
	Sun, 22 Sep 2024 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OczzbYdm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98D1917CC;
	Sun, 22 Sep 2024 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726966872; cv=fail; b=NqFCLU2FlzD5RtnDbzAr48sPZPz1dJf2OfhkJWnxlPaTmlhja1jnviUlEnHPnA1OtN9+NIvZODweTP2uM+ydhm8i9+QfRqipnrkK1dYWXmIHiH37rVvHsw/yHjgIXINlu2+uf0azafvq43Udh8qFULFPk1Y/bZY6IyorgMo+Hp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726966872; c=relaxed/simple;
	bh=9Vrrx1YRfKNwQa+T4E1l0C/HEH5iuM8HFnpWrb9B5F0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jty8/8DBcJ2Ui0gh/aul3deeFaECmpVTtGRvLjNY8S7B/9Mvslu6I69Ci5hW0fN9pHxcELn7SBMNBjSt+CCy/WFwInHoQwEIlJz4tYXU7mhlj4OxGyl5+vRPJqVjn/DVMyQDu6s/OtTxTvIV78q7C88b2DYvZXIXLM5j2gFzXOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OczzbYdm; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726966871; x=1758502871;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9Vrrx1YRfKNwQa+T4E1l0C/HEH5iuM8HFnpWrb9B5F0=;
  b=OczzbYdmF+vB3k2TFEKqxootGnBlj1QQYM1BAuXQzinDIJdnAUcaUIpV
   UkhaY/vJas/zOeyD8iPvmMrkDCVxWPW/4332g4l26NQ/BD1vZe3r3uVZN
   KxGNmo5OWLbnrH4NrlGBZgjFopUfG2oQC+I2V5P/P0OpAVwAo/hnhufKm
   a3Squn+WIJmDq0qDRIEd/ZtMfN25OwcEPuEV4yzy8I3j3lrThAQ/IloDS
   bqabzEUcrWnpRMWkEAPjBqWSFW4ywXM6MT1ehHfNSHUblQVhV79Vxd5NG
   gO6zK6QYHwuJCIlrSQbE+JtmLMD0oyCAzoOjq3KPqyksopcZ3k8rUYs49
   w==;
X-CSE-ConnectionGUID: dvO+Rr7SRcmhZJHGqRNhuA==
X-CSE-MsgGUID: qxXihG9RSKaDNMUodYijqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="25459620"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="25459620"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 18:01:10 -0700
X-CSE-ConnectionGUID: 1mn1dEBiQL2K6vfJHG13ng==
X-CSE-MsgGUID: xfRw8tS4RhyKdxBNP4l72g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="101409980"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2024 18:01:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 18:01:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 18:01:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 21 Sep 2024 18:01:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 21 Sep 2024 18:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaUcIbhRF0wxq6XxK71wKzfBLm5MD/fLr8+O1AB+qnN1VVK6SjZ0vvnCTYps6sBNLEMwsHGwX3ZwIF0LQDsQUlqmATbGQisdUt9uOZDynWYh9DPXy5Y4+adNYnjmjeYH0+Adk475+ZI+ThbZRCtWKHMDci1giRbJxvxyUKjTcTR0fR2nPC6LQHuyXzjyWhFC6v1BhLADIF2y2bUKG4wwqUA5JphKSslVm5b/kjyRYAUJIzOxtJKgzg0FjG/bvIg7MTjkB9e2nM8T/xJYejTN59VcFnaOtbp63rZVtkPNw35tncALDC204xxdAQ1OEEkSUgIW82uCW1U5KN7CNHyFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgfDg8A4KnnscMVrY8WmrQLQYbE82PYhso4UPM3tj5I=;
 b=aHL+HrUyTgq/AXp2fV26hhMt6vNBgWz0/Qg/RsqQuXuIWfTUbtCt4F82m551BYq5qrYdGiuoTp38cTjOxtnADd/WfPU/zmBfMxX/qPc0+7WPHlcJ3m0eoNU+Q/rLK+yMknAWp6/gdRbWV2tQ5DX6rBfZYyRMVlFOvW9RZEtrRpzgql2OkDNT8vMEHhmgiC5LXL34X1oe5tRxAGzjgTgitjRx88EylMxf4dyBqQAOAJNjuQlJx8S2gDDZ/gSf4bPjUy/7DQrffEYEiC+KAHNF1FB18wjqTKsa/nuS40hVLFJp+4f091s6jc+AOHzyzeQmLmpZF5qEaxEdiR137HIAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 01:01:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7962.027; Sun, 22 Sep 2024
 01:01:06 +0000
Date: Sun, 22 Sep 2024 03:01:01 +0200
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <vishal.l.verma@intel.com>,
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
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>
Subject: Re: [PATCH 03/12] fs/dax: Refactor wait for dax idle page
Message-ID: <66ef6c4d9e855_1099829454@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <b77b3b3ee12049a9c7cbe64e4a117295a6d0d5c9.1725941415.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b77b3b3ee12049a9c7cbe64e4a117295a6d0d5c9.1725941415.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:303:87::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 0adf1b9a-c2a4-432a-55e0-08dcdaa20990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4/hVVsM2pkYO1csKgKUwPbkZ0VzBvER6AmLVeBGUUtxHo4ogUuKf0Y9AaexC?=
 =?us-ascii?Q?4qHgBTiOWieexsQMxd5f5KA9Fq9sxClSffMSoZAa1w+AEbW9+uttj4AUzL+j?=
 =?us-ascii?Q?vvQsA0QHNgCUHr+dDisDrVUxztHpSokbthzM6AA0CD0/IqYJeVN5ete500wN?=
 =?us-ascii?Q?9P63waBbJVhiHy9lPXmd1t1TkTjtH+UfeDjphiRFU5OtUtwY5Njqb+B2gAAY?=
 =?us-ascii?Q?+01Ahd3KzZCW50i+wr5AVtrjVkjMvEFARyUrV+7akQIqSrCe3dK6rqEnwXCW?=
 =?us-ascii?Q?h0ndEJXMlkDGtH73In4eGe8Axo0EsAWEQUopkc4k4HqTMtwhuIOuKw8Hecgx?=
 =?us-ascii?Q?+FjeHFGHBuaZzAJFHDfFNGxDFZZh5GbtGSgeozLIpoI/5AVd8/pMRMK3P4Lc?=
 =?us-ascii?Q?q7h++VKpeDTXa/fT7CzRmAekAci2WOvmomIbfAdMY4earcsQHnOgoUK4Mlii?=
 =?us-ascii?Q?u3ElvyYhXW7Om+TCumvuFQ6awYaR9UXhkWsWgPWzDjCqe353RLoMslaBwjcX?=
 =?us-ascii?Q?1kM14clKIMTqg02M54Yob2GXRaUaUPZOzhGHOQlG9CrTL7hbOrEEjJ9t3ElF?=
 =?us-ascii?Q?ZoeyyWQkKPJYVjwa8Pjd04y7r87ClPh051tlPvAHbNTIgQJRdzl4IjRBWz5V?=
 =?us-ascii?Q?NMybDLINTsoOIDTzlGVFe3TQn1XG4+8qU2IfHM9JBvA2jS0qGbewwKsJGNwt?=
 =?us-ascii?Q?/90pVJXREDfZSdsCS8iZESEfHq90Ro0zEeAN8lymcr0jbyNGxdSXgMw2fZY8?=
 =?us-ascii?Q?c3ZEVK2UsOt5PBrlZL3nHxhKMxiCSN9vvrdN+dDOZhUxdkibddAcbV6bhUwY?=
 =?us-ascii?Q?bSkGw4LHPBhOL44Mvj5OpFVBb+XRXFN+0G77zGIcJxHrGUJSBiTlpzq9zeBH?=
 =?us-ascii?Q?39xm29S/4aQcrvDlyb1QUbmGkQhnzP07MVvIk4LV9wEl6BBIbZBBc9lr4Fpg?=
 =?us-ascii?Q?ugE6/7wje6x5/Ru5xlx5T0TFK+rAQIt4h2DLWoaIWYvXGkFC3CgGk3j+Ma11?=
 =?us-ascii?Q?AQJFiuJz6PQFNAU8wn0by2ATBUu7oWfq2/C/WeGGu4dCsdnDeP3s3YJ7UlNu?=
 =?us-ascii?Q?OfhKQkrtDPrIpaArmm/MOE/O3h9aZpuA2AtSdKHdoxxMjn21YgX4KkfEIjLJ?=
 =?us-ascii?Q?uHdkmd+ZuaufOVe0Xvtnfd6WoO4ewn4M6B7wY85F6vQEZyLBTcD19MN06382?=
 =?us-ascii?Q?veXjO+fxuWR1F30UFYOFZDxEQsMqJlsvKrgWXW75xRyQBcXq9h9iP0ridfxi?=
 =?us-ascii?Q?1gdRhgTxGw540sNx5AIqaGhWkBYEdJ8H8Dde5h3XO+lv8hwpCWc3anrJjc7h?=
 =?us-ascii?Q?NXKfPmQ7EZkR2oBbJqDbpvjSP1ZMog66Hl7WfcUFQbkeSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Rjf9gBju9Owq0OPEr4s3TA6dJ27eEEf92OhfYYSf6OOjz0AQT2pGmcntCzx?=
 =?us-ascii?Q?xTSA0vnwUrKeykJ2to04ZKBUJdd8+ZGRww9UEv5Te30VhRe01BwY5NRDCk+g?=
 =?us-ascii?Q?tRIY4Cw1QgpvCyr9VwbgBx6+d7gWyi8o3qy4yQXQ3LNwnc36jPTtHa1Ue2fH?=
 =?us-ascii?Q?tEOdX36J2o1Cmiqx/wFIh6WuceGzNO192HsB3ar3BbSqz4jOb/KXWafxkaCw?=
 =?us-ascii?Q?uC9Jc6SeNfV6/WddFXBFD0TlYSLxnciZbKVu+hkj0n2YlWrZpIEvz9fyd9lv?=
 =?us-ascii?Q?drX7qAcXH+SZm4Bg/dnsluBIcESAKdTZTc1YMJF1MbKZSXLRx/reUBODnzGl?=
 =?us-ascii?Q?6vN1psPpIJsu4yumBa/Hs62IP1hzX+xTkY9WbCmj0N6kCPFhYm+k+G+iy03v?=
 =?us-ascii?Q?tRLAN8QnuVCduc2exxOoo/8npMw6BZhaT8GF+tpbZKKDsnSriW61XG5eR0ql?=
 =?us-ascii?Q?WTGjGiQ4SqNHUUMZfpuG+kzrMXsAlPU/pcKUH+qFljhw7F6248tyfW5ntauP?=
 =?us-ascii?Q?bmJDFp6BINEjvx6ZybeY+EbPXRiavkuYXSmbrIZiLz9nZ5x99EZIkMhecKX1?=
 =?us-ascii?Q?M24p8InSvIpBWKCItW+W6AXrQqEugGvQ13uyzBQqJi3sgzBIFmYeBVmGJDzE?=
 =?us-ascii?Q?W52v8uR+Udk48fUIZgA/XT0T6s/I6fyHCgprCpifzP09eeTC+xquK//14gaG?=
 =?us-ascii?Q?YyTYYUPN/R+Te34qbJzv91jTt354lq/E9grzuVSoHjVTOIWG+1QoFKJHJ+pV?=
 =?us-ascii?Q?QMOzK3Ukdzwp0unGikX10cMXEl3RI/ZtcRLFep6uIghohW4i6WuYG2NP0TRe?=
 =?us-ascii?Q?gIbgS8ndHhCvhF4vkvX0A6mZHFrfdUzf67gGikZqgNuPkp6v6+Ye2WpGRrIc?=
 =?us-ascii?Q?pN4qecqOhA8bTnD+47h7JT9eroJDg48LGcSXi0u7hlcpPVlpjOCiIeJ+mzpQ?=
 =?us-ascii?Q?e4Wj/dGSfPrQkHh8+e7DQ9G2zfwuSQiQsyJILzPsIuHqbSN9O7B1XG6usdnx?=
 =?us-ascii?Q?1LHOTUQjfty9pkVLfWyuhX+JivDJmcfl9rwVYLgNA+8gcmSE0ZPNCuN8Ba3i?=
 =?us-ascii?Q?hYtdFmpdV2jZG5OBkZkwhVDA7DFWlg4P7Y7vETtI7V/daW+21rdNX2WZ+mPn?=
 =?us-ascii?Q?6ES9bXAgHOrP/4P5J32sqBltNhc1px8LJ85T75MtmOJBUEiV66Ov19jlNpY5?=
 =?us-ascii?Q?WAfYXZMoCTf+P/COq+9c+bXQprA+rxieg5/98Pc4s5EOSIz3wNORNAl0jQWX?=
 =?us-ascii?Q?U1grLCzCWlKUnPiLZSI1GQuUfNHQtAtDWbQj1nsK1th91DkwwUkdHgUPHZqz?=
 =?us-ascii?Q?rRE0PXJPCPl/MCDS2JzwOGWcKO9oM3Ub+wxaZqzDXjXdf/8uQyoMNwAp64Ub?=
 =?us-ascii?Q?dOYlvx8DjwDsReZgXADSXotFyIO3LmB1u7XykoMN83cXk4LZ6+1m37xv1y/3?=
 =?us-ascii?Q?/rH5NNa6aW2bCQDejYGwyafYY1u/ruPeHDUlon1aFG/TwMtHzBPNwo4/3BJ7?=
 =?us-ascii?Q?zx5DVVyJ1Zkp32+NIFaRGEWjuM0yCX/bUB/wq4nP7eGq5UU+UZEPLMyyNWue?=
 =?us-ascii?Q?k8BuY0OORIihmxtn07j6+kZWNzLa4E6zVfmkVRmuyeNV7cKTdH/qcmFJ9e5a?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adf1b9a-c2a4-432a-55e0-08dcdaa20990
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 01:01:06.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdeJDpLyMov76/jVkqotUZfDPxyvIH3F96j9ahHW5TlPsVFl9zzL666g1u7t8v+4GiqVP3eqKb3P234owiEW0E102+VZR3XUTXG3Bboocno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> A FS DAX page is considered idle when its refcount drops to one. This
> is currently open-coded in all file systems supporting FS DAX. Move
> the idle detection to a common function to make future changes easier.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

