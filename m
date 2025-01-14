Return-Path: <linux-fsdevel+bounces-39103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BDEA0FDE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 02:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965A77A3907
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 01:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E685626;
	Tue, 14 Jan 2025 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLUQZOA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662981749;
	Tue, 14 Jan 2025 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817323; cv=fail; b=GU7Zp/OS47qCMqcv5MRZmbg9WvKejnfQHZa5XnbVS9k14/sUWdNqQLH0TXyGvsJ+awrYht7qL6lv6Ph31gYXvc5P/nyePW6wP/aqDEAoj//GOeSMW9kHknre3j/h5Jb7MlbtKbIhFIfdaTBqPKFXVA7mJMXYanrMgzT96wT3DgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817323; c=relaxed/simple;
	bh=BRQQ94cr5iiGR8Hth7+kqN39KLF33bmw2AClMPdcybA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MXCtSagtJIsv+KQ8KFW26Sc9Qi+PbkboUxsFJI170sbzPMnKdaAxsR4E6OkyGetly9atbN8Uxq88F8E96V3MOKX8wh372/GZ8cB7HK9nlMegN9KF/riKPRwMIZKvo81z38kD+stc7V+cIrp6G4cMVlWRU8TogHN8GGZZpNShpVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLUQZOA3; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736817321; x=1768353321;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BRQQ94cr5iiGR8Hth7+kqN39KLF33bmw2AClMPdcybA=;
  b=WLUQZOA3ulAwj1zy0ZNnx7RckAkbJnr+DWxqHDN860MHJ4rbGPS93+SE
   48jRxFxIgcH8vYMa0ZLnASs8XLnjAp9EPWNZKOCHoknADNAgrCHSCAgZ1
   A4W3oFNLOCLcbLQI3PXU0LWqibiyU00+7wrjTvZFKDnoEZO+tMXzzet7N
   a0YblM4wduOh6Otv5MhikSt7Yc2vKfFpEuD6jKAZg4ocr0wrz1ksIaHy7
   0diPXinqyMtrLcsWQpu1/hsGLGbamXWA9fPqt8Zdx/pUGzT/vT6gB91W7
   oDyTMgKIFRyCQYcIBTt89Wu+XI4CHzJt7CipDx0gkt8vK4c2GpL+Ktvj/
   w==;
X-CSE-ConnectionGUID: SEqYIcgpSWqSG9jB+zNV1w==
X-CSE-MsgGUID: 2rL7FbhcQLKDPmriKgjCtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37130447"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="37130447"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 17:15:20 -0800
X-CSE-ConnectionGUID: tbzF2NKgTze2XDKN3HI3Ww==
X-CSE-MsgGUID: f1qImhiRRTWvQ1peveHFtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="109586466"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 17:15:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 17:15:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 17:15:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 17:15:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whztnl+02LR5QrNNxFQ18xn5livDbsUeRR3a0VQOgJvJCE5TTItGcAD5/bDPjIazXRmsRIAzPcnUtu/N/64PPdVaJpsQuktCIxmYFDxB/sr3fFlY1OwV1yqcU2YjGTBBpVVrF/Hh7z0POOju9Bfk7gfK2DdjaXlSWrECflReqhtCz0a/5dJYxAKcGNucE/lMzNNp0iX0XikmQaRk84puZ7oeAHjkaDQWncpsj7Oupu9NEZ+ePja1Kli60cUAaEsWi5AIrfXo7cmLfboTbMMQxWdSLC7pmm3RsgkLcUXapk5bEtHEy5AsLVJkl3q64HRwP/CDLxJycrDPOyIkhJJ5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPB5ptX59Txy06I1RrDHguypOI158TYIYBDNQnf/BEs=;
 b=HZ1jlP89p0rjDdZfnUN6s7SShaZENV9TFN85CIXwx4cLIOxOGpLSA5g7thPeDEh0EfV3OxtQudeezHMs7LuQb+e0t2FOwqMrorOQEPZF4W4SnOWWVsoBIz8122WH2CL25nF7HyMNk2rx6//sK2nwfxCxU3p4Ri4AuWwybOc3phl+GZVD4gHvYBFr599bxJ9mIirpfRBGqpp+SuVLSQDnl5iukOLDeyR8uBS+a4sdpmENo8ioX98+NVWY3+p+p9TsQAdnPgPidrfGCD/7pD81AmathoNe5mnIFTesryLRfSOjrkrARwmEtF6dpsJug4d7HuASmO5o60JJM8WhKTqBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 01:15:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 01:15:17 +0000
Date: Mon, 13 Jan 2025 17:15:12 -0800
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
Subject: Re: [PATCH v6 13/26] mm/memory: Add vmf_insert_page_mkwrite()
Message-ID: <6785baa0b6b03_20fa294dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <e75232267bb9b5411b67df267e16aa27597eba33.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e75232267bb9b5411b67df267e16aa27597eba33.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f01bbe-79e6-4402-37cf-08dd3438e7ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IVoC5NEKSeP5Hmp4310+POBioAlnS0DbHAsTqWaLtCWzoNabN3PZCqZ3vkQ3?=
 =?us-ascii?Q?E7ubiaXOSm+HtTFQpH1sH0fAxrzCIzoCjSOfrGNDZ1BFdOdvVZyPHCUGLe4E?=
 =?us-ascii?Q?BGB50/BBltjFV5++KRkTDamJcdozzWlijWa/MJ+z2uPdVwR2RGo3xTZNzzvt?=
 =?us-ascii?Q?TduvTkcG2o08SeAWxAMa9w7L4DbH83oUswa4b7fU2oQsB3Hrhr6ZbWJ5RAMa?=
 =?us-ascii?Q?r5AyYAv0144vp+27aGQ8MKSmHlbQ0AzfSG/SNEpZgkuyM0qZYHD6emSE1JfZ?=
 =?us-ascii?Q?A0xNkL/BDVkc+iaWZJld1tzDBlN0P3SDOKKn7W7oMLWQWeaC+nupCzqt8zNw?=
 =?us-ascii?Q?BKp+ITgG0yruGoYpEHd+ZStgHHD7q0TxQ3DArOaq+yGU4/j57Nvdh9SN/3cf?=
 =?us-ascii?Q?tSBa7HUBaKjRe7r1BlViO0I6oQgdsDa0dduEbP+r+YsiAynda0dnUftjbVci?=
 =?us-ascii?Q?4x7sLd9Chqrnmf1up4tjLwwaidCg2IYkC7LoHtB8AVVWK92CuWBbdVqso3fY?=
 =?us-ascii?Q?PJOz+6ciZ33XQG0OawBx3CjyVqqUAIetdICaqpTab/qvheWrRUPofvTLQqEI?=
 =?us-ascii?Q?0wfscxuGNN3SOyagdOI9AO4NUwpUS4Rg955ByjrqZw9IGe+MPHgXXW6BUrbU?=
 =?us-ascii?Q?fF0Y9o0Sl8qNbHuf7zljRG7QOf+czmWe1TOJqvCLzn/wZ4BhIk+q1DM+xthk?=
 =?us-ascii?Q?Saett+CpWWJSGITWNPMUTzWN2O6eq98AmlCXKTPpav2n6QuYeIZqu71ePYPQ?=
 =?us-ascii?Q?y8m4OEyT1j8qdB536JUCRp8YUAskEFCFKsYU+A//uWAo+OgmTuHHecSIJqzj?=
 =?us-ascii?Q?ruibxLBfoHNxViwVwfeAUR2UDN6DorxmZJPOnpY9nbX7ag50992uCkLIy2LF?=
 =?us-ascii?Q?7CRE/2oYMT99c50cPc95CsKeKMrYkTjSJWSK0XweW1Ad6KoBE0w+BATS1LBN?=
 =?us-ascii?Q?X1rAa6qrqnhLEGwD+qxq3nH5zCUKF8PBkiDqM7bNtxDNXVuxSOmHA9zNMaxy?=
 =?us-ascii?Q?tKQKON9jg9BVbOMnPXQuDvsHTRkliGv0UWIbZRHzIqAmvJbH2gdcT8428y5s?=
 =?us-ascii?Q?qG00S2c9IgjlziVB+k7KDVCBf/yiHHTsaAelIRR+VmtO6fhPeUKzAMQiU7Mf?=
 =?us-ascii?Q?R4wG8FJOiIZLCqNLSZHs4RxJhgCtE6OHuGZp0Qtf7WJ7tjZU/5mgJsJqLgO2?=
 =?us-ascii?Q?HD0iCQCTDU3DwaN3PRT4RDWfbNvOeNWOnuJLrnYHOg0NL6RflngchzeTpl68?=
 =?us-ascii?Q?xX/x+c6l06i7bJcSlqlSS55CokARibXMtnKWqNH+jI5ltZj4Qg+PWrTEJhcH?=
 =?us-ascii?Q?M5n2QfKLbwReS0bDfFnb/2FWrIwswOdOIsgQLunq/3cul3F+Am5q7gUbfu/B?=
 =?us-ascii?Q?nE9SPKqLYSzpK5aalD/iCQ1IoKpz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n5V+VzQxej8nfRZ71VLYEcWNd6Vb0+fo+PpQPcwOtlDe+bxpMh9JnuOWh/RM?=
 =?us-ascii?Q?EWUJqoyEkbZovvM1Oo0fLQQrOXn0KS712u6KNqsmB7ZOmtkMp5XoxhuZ8L2a?=
 =?us-ascii?Q?BR00FfkYlIzbbTG8M9+Il8GOapbuZgt3L3ihBL+mic0acHYMaw4BkMQBJdDL?=
 =?us-ascii?Q?QB9SjybUzDzObgaqRM9vJF5HaJtNN6YzkDQz3MvTk/KQNf+Y134UIsoddzgt?=
 =?us-ascii?Q?iUfSuTXdFxACPcEmLfO25BVu80kZRqRytQjp8rkSv/ct63XB71uQfSBN5Oaf?=
 =?us-ascii?Q?QklnVWlWQYWd1/Ger+5bHtcKtzDLlP37k+NSyNrWSSOJljVKQhw8D/GXiFzY?=
 =?us-ascii?Q?vf5KjutwpdILQUnIrRAQ6Ms4ZrwWiDbOtF6/3nsRzi2qZE9n+ACxM/tXrGgv?=
 =?us-ascii?Q?2SSRKe7pYJoexWgrV62d0889r2ycxlndwFOBzmpqqwgkJb26PXVdOtIcr/dZ?=
 =?us-ascii?Q?roQESTW92ubBJoHVeaJiSPzQhmST+7gH2eA2Oqmp30qY6eiUA+czPyTmK3on?=
 =?us-ascii?Q?ygHmhOio+nPrPnMFagwi9DR2kweD1aa3p0FCAKvIuWY+o99Yw4AnSiRliCnl?=
 =?us-ascii?Q?s+8megJ1iZcBAaMooWqqLgVPZE4ZQ3o26gpL9KoZSTeCwZ000Tgc5AoApIA7?=
 =?us-ascii?Q?OBMVl2k+HLVus9f0VLhVreyggdPRMxfKyrxU6RqsFgJ4/hKffa98z9R6FK/U?=
 =?us-ascii?Q?9N0MYmfjbJ++JjgVWAIvUuJEfrlZ0OlAZnazoF4q+IS80yybwHwvPDe43efm?=
 =?us-ascii?Q?560KUXhq3QO2XaxA17zHwgSHiEbWDAe7J2JTgJCI2idqdoOcXQPfYX0me011?=
 =?us-ascii?Q?CjYuz9fFzeFJ/bT2XgWu6fo+WN0V4ZDJpyHyT83Vw+58/fZTfQFX2l22/BYD?=
 =?us-ascii?Q?ibe/gmmugkgGazYklo8Qzxjwpq7jz6ZWOATwnxy/uQh4tqxpYPDEGBbK1Sic?=
 =?us-ascii?Q?QKc6L0LqkA4UPzUvs3kG1amYET81f/+DSYyfxzJfEYoWlSfxQCefXFS5xkPT?=
 =?us-ascii?Q?OKAua5dpzvzcGKmETM6zMoXxslJERQQ3wCt9s/7uFrYV7eEM7fjpYEv3dLPO?=
 =?us-ascii?Q?F7VXeO1TYXSomjidH86TLMf0xM912OR2jgKO4MPgC8e1g4vWVfaxlYtNGCXH?=
 =?us-ascii?Q?05nSFpZ1fb4kYV7ksdjSDqRytnvhbuLy0MefO0bFFJ6pNlTOgc0/Qc/ULsjz?=
 =?us-ascii?Q?npNibLmQ2sL7odW8HsBXNLYs1PDUy/EAmHCAnoQsFH8XD6GWdK59mwYxQKQs?=
 =?us-ascii?Q?bOqr44wCiiBnHvb1+IJa0lH+WGTZc4wgG1TUeV3r8fwMi4wHVEKGIBJZ4FO3?=
 =?us-ascii?Q?Nx0066yo0FdQ3A2eJ9kC7bxjMghbxCwsdKq9fdxYcZH+1v6epSBTATj/RaMS?=
 =?us-ascii?Q?rzWtyTL5vLlaH1NrLpSUj4gCXuBDqdYq8/BNlsxrPJwSXkLCIlEt6nQEX9fR?=
 =?us-ascii?Q?hKgPwGXDSdzEo3IxlkF/N2LfLxjFXpuzqqBg4rw7TdWRYjfpYmpmAJVGErTA?=
 =?us-ascii?Q?ni4v0Q04ctUyKgtfmA3zicmumCENrkGonISda784zlZF6xwBGYOtHwqgoR/Q?=
 =?us-ascii?Q?+yWlgfTK/hcNvRkOucFvC7GApOWN696J/YudVCKLNow/dgQv8SyvrDaSqzrc?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f01bbe-79e6-4402-37cf-08dd3438e7ff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 01:15:17.2950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6N8Lzb+lTc4iwguJdsHiZqEfYQw/F8qB537fIIAnP5C3Eb4yZ6rG0+VMCAM2RMqMBKwFIMdDPIfh9R41jyYVx4DBHHIGAkATnUhnR2xDoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7828
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
> creates a special devmap PTE entry for the pfn but does not take a
> reference on the underlying struct page for the mapping. This is
> because DAX page refcounts are treated specially, as indicated by the
> presence of a devmap entry.
> 
> To allow DAX page refcounts to be managed the same as normal page
> refcounts introduce vmf_insert_page_mkwrite(). This will take a
> reference on the underlying page much the same as vmf_insert_page,
> except it also permits upgrading an existing mapping to be writable if
> requested/possible.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Updates from v2:
> 
>  - Rename function to make not DAX specific
> 
>  - Split the insert_page_into_pte_locked() change into a separate
>    patch.
> 
> Updates from v1:
> 
>  - Re-arrange code in insert_page_into_pte_locked() based on comments
>    from Jan Kara.
> 
>  - Call mkdrity/mkyoung for the mkwrite case, also suggested by Jan.
> ---
>  include/linux/mm.h |  2 ++
>  mm/memory.c        | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

Looks good to me, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

