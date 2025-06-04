Return-Path: <linux-fsdevel+bounces-50679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A10FACE5FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FB2178D76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DB214801;
	Wed,  4 Jun 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfoxQQJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550B1DE4FC;
	Wed,  4 Jun 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749071128; cv=fail; b=qIH2g6Go0Gz/guB65ULltuKPMhxK51FzEcrWxjm5o1RSBzt965RLI7rEeTgBXrImIcw0N+R/yXrpWe8QCEuHSTVSwb/IBj+40Ksba/rUUIMkBhr9V605Z4SVvyU9ODhDa+oiGuyaniWvuv4Ha453xq+oayyR8Inf7oNdpNKXTS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749071128; c=relaxed/simple;
	bh=PsgiqNh8JeJPrfLZl6LDq+LRAoqBx7MvuVKnoWRppgs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zy79S0sxuGfNy2CGZCTbAbqelPANBNnUz5DGlmRmVX1m+QQhjN2xVDsCCfiSC1A2XLPwVtLrZLR8sKc4gvWSjV3BhrPTkST/2cOJOsnhP6V3KcMJjXDPYwqXKKuSauvFu3HK+Lj/xBFFQR3Tdut+jDiWOhArn31wiBloTuMBKec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfoxQQJm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749071127; x=1780607127;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PsgiqNh8JeJPrfLZl6LDq+LRAoqBx7MvuVKnoWRppgs=;
  b=ZfoxQQJmuoamss1JcdK9V7v6bdePOWKMVpd7p808WUKE/9DLIqtanp+o
   +u6Ft72jBAfkUXvpneybncaYKDVN6JVyuJj02bbYSqa2JxF3t/Pn+DwyS
   kx/YI9wghAwqzw+pNbdofa+d03GZR9JNTVNC7pqJlTnfJGglf9Lc2qpwq
   YI+K/ZBiZCVthD0YzXQZkrmAhPA5000HgxEJTqVF23mLWfDCXOj8Lt31X
   4oov2w9PIAJjSZOQmv0juZ6Tgy44UAyCdNsigipTMY2ZNA48wFuDxCNGL
   q7AIjHbk0T/TXURUzL8wcupFmmls2gmkDSTsle0vorvNOdsrPV9v39m2x
   w==;
X-CSE-ConnectionGUID: HmCaLor1QlegpQupo+VESw==
X-CSE-MsgGUID: f+qrsDchRISaPgQWfYh9cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51035089"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="51035089"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 14:05:26 -0700
X-CSE-ConnectionGUID: 1w0A7deQR0yNY5bmC+u9xg==
X-CSE-MsgGUID: SRc88llqSTy27ZOxdHK9eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="150323967"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 14:05:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 14:05:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 14:05:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.56) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 14:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLrAoe8ovOfaGZPyhJSP9rH4posbBsh3ayyZwvqKXbSfrUWX/lqm2ZEZdDN6E6fhDRYqiPSGT+VA3tNurUq/oPCInT7wXtQBYxq7z56DephZA2mIxjRSXlsUIfcwFRf8y6qWsSUcDkh0Ojrqm7AAL95Tl4Jl3UwVHe6BIkl8p8OAFnUytCECJxvnz6mGJyA0ztJqVPZ/CvYApm1J4YDfZvSfu+NsjGap4h/lEjgUp6kHon/YBK5dHWPUrQUp2558MVceyKMY8d1JIZhwbUhU+FAksFwX0lg8yc1VgBEX3MoyC3swJoXLa9s52tWCFS9apJ6Kyv5j80M0d0hdMfxneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tffwslYcS9wYv6xv8s7cL/iVvooTi77TcpMyFouePAw=;
 b=mLw8gKLMtl9GVIlJUK1UrfrP+8tGHNAOkZKFkTGjUclj8eSogx546ckBSLPjNm51syDR3EbBs+7JNrelW5hQDJNavu4/Ya/53xYL8C05X9ENrdl2dLIX5PC03ygLGJvE+5ElS5QyXXb+aTwhBnCSfi3rIZR9wt8SqTBwfheShZdQUpVfsSiiUwF7tHlMH44NfDGi1hVAa9JxeNEJI+mpyyW/k/aYGOKFMQIR9RgNFjik2JjMye/+FBqH62tG0iL3HeQTkemoi3Vu7KLtNCQ5+uBusgJvs8ZaWGcEEOVYiAjCvcnLfBl/T0LJZgNf/GDDqlPK6PYFDXCykqXigC8nYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8035.namprd11.prod.outlook.com (2603:10b6:510:245::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 4 Jun
 2025 21:05:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Wed, 4 Jun 2025
 21:05:21 +0000
Date: Wed, 4 Jun 2025 14:05:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <gerald.schaefer@linux.ibm.com>,
	<dan.j.williams@intel.com>, <jgg@ziepe.ca>, <willy@infradead.org>,
	<david@redhat.com>, <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<zhang.lyra@gmail.com>, <debug@rivosinc.com>, <bjorn@kernel.org>,
	<balbirs@nvidia.com>, <lorenzo.stoakes@oracle.com>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-cxl@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<John@groves.net>
Subject: Re: [PATCH 01/12] mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
Message-ID: <6840b50cb29bd_24911007e@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <cb45fa705b2eefa1228e262778e784e9b3646827.1748500293.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb45fa705b2eefa1228e262778e784e9b3646827.1748500293.git-series.apopple@nvidia.com>
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 095eb32d-4fa5-4d45-cad7-08dda3ab849a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sSNBqkzwqkChNTGv9qy0YPLO82lgj5OtTE682ySCKw4hI5XStu3glHDRYYPU?=
 =?us-ascii?Q?FUw6jD1qt423LMTI0NMliZfglUmY++fZTnYO67zx5zFrjLOGZkzj+DCx9f68?=
 =?us-ascii?Q?967e/5p8dwqKuRza1RiPcsrX5tbrzLqQkGPKDYLjlLG/F06jYeUR36FMw4F1?=
 =?us-ascii?Q?DL/CpgS8bCVjNv5L9INj+mUT7FdCyJKA+FSeboh8kXRy6JZEIwyhUMP5JedE?=
 =?us-ascii?Q?yr7NKJJ/OGC2/tiCQJdOiPCeGcjoHE/wWAXJp+T2il7euFKz6ItRqhldGTax?=
 =?us-ascii?Q?nuRjevJ8L0vokrFDU9n+lQL6GkS/SKc+zK4z3iUCRhJf0y4pLJtDkPvghnMo?=
 =?us-ascii?Q?8B9oUcEzz+ohs0NsEmw4gS+XJcT8MCFlWzanltOoki28M8PTTX4rVWizvE+M?=
 =?us-ascii?Q?Ezza01LVYFhtXTVxXbwZKOhu1OEaZAL1eXP8AOn0TGhStrcALDv+zzD1SWce?=
 =?us-ascii?Q?91x9Sjf65+4lkyXVDr7LhjPgFC9jLPHZ4OyrXd2H2ERHKN3ZD37bbiXBfSEY?=
 =?us-ascii?Q?LFScZaW7U3W865Kda4BKrVWl2b5HX/e7A/99G8jLL/Bpps2tvJ7R6gJaWwTq?=
 =?us-ascii?Q?owyPquvbrfNBOr0DOg6ydVZ7xVRxLNoM7jEUXiqZc5hhTYjsUrCx6yY9gs+G?=
 =?us-ascii?Q?SMvoQwCQgdj9pD8RUeeDCIYiAGw2CHeFIUHql6sMndikMc1hC8b0vJXybRIG?=
 =?us-ascii?Q?9GHBlX6+Aq31XQNcWlz0P5a+ABrw/1Sj5f/4i69mRQFiWFSLbmhK377Bzrgv?=
 =?us-ascii?Q?/tSo627HmuazwFrbayp9AqLNZvGLdqvRVtLxfhWh16u1h2hJAHKwSZfQW2BH?=
 =?us-ascii?Q?oS6kEqZp2IL8m56VUZoT9VCiEQ1NPe8CoVpefWgz/eaRHbgioa+szGclU58i?=
 =?us-ascii?Q?J/9+yHP3ghc1jdPvK0zzC3X0UsaeyrvKEELFUnS9PLMOlcus58zCpicwh2FY?=
 =?us-ascii?Q?2e+3TzmP8/lqEQ7nLq4ov/NF0zWuotjue9KqZVptNKbv4Hp5vKtOq2Ocu9Ai?=
 =?us-ascii?Q?UfmVVgdaCJxajpG/z58U1IWU/tnTcUV59SlQoX9YKlLB2ijvJWE7Zzhl+3L1?=
 =?us-ascii?Q?vgsgy4I6UkTbpfdrmcsnjQxQnDD9+t2YpjokYo13VPdILkWBGkeIQVRyxSJo?=
 =?us-ascii?Q?cueq1Rl4fN7wolDXqowJKxLz7P9pbEFxRcEdkV1VcFJyX/44vXFWyNPwZnnY?=
 =?us-ascii?Q?8gV0IqnQzqK8R/nLbOXx03UxNIAoYdke7C8hS58o7YkjKSJWFCQmwaXl7jXM?=
 =?us-ascii?Q?nFDw0s8QIoBfk8aAAaJb4gtnLx/EzeTDdXKOls3BMzfsZFnhdNj6CvWJUgrU?=
 =?us-ascii?Q?fYxn2xAu8iIRGoIcqfp8Ja68rJHvzFbB0uR5K9PuT5PnKaLKxefKJkFyUYB0?=
 =?us-ascii?Q?neR960PnjY5rCJGuCqoO/V+3rx3aL4FgQcd3ZO38S1VqSmMAKavWXmLrqP3U?=
 =?us-ascii?Q?JevMYfWN0cw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7sal2s5eXmzc1aLMbzjU/PxAdvY0rT5/lEeUyOldsB/Y2Q+4t+8yc4KxBws2?=
 =?us-ascii?Q?A0XQOmF4s5YN6l+0rLTw2oKAG3Vjkp7rndsLMKCIZcCcVs+P53EcPEQv9hMi?=
 =?us-ascii?Q?GP+w7bIs+zsebKKPD05TKgbakBRTgDaU0ASpj+74umZaTUb+LP4Kjx89QRZU?=
 =?us-ascii?Q?Rl4dldVBLzT92wvRQt2QjG251MOE5T3cBGvNfvSxZ0YvhdSluUatLr56eR1w?=
 =?us-ascii?Q?XdjUUSSuq4EUh6hzK/n5mXWRqgbDkGgWXOpVqnmrjIDTrHxnv9gU7FGpfiNS?=
 =?us-ascii?Q?/9xu8NlDV99A0wmhDzXiGHBiHfMFNfvbUZy31ZPfkrkrYJSwj+FWeTAkkH2u?=
 =?us-ascii?Q?zcmljcSlaE/bbL3zm3F5dvWnJFmz8bPOlyFZznSGsHcRHODnaX+wjtZjqO1y?=
 =?us-ascii?Q?Itpg89Gf7VAMmsIFRVOcZ2S9owa7Y/X76Rv/YAw1imJruK6GJmVePonr4PPH?=
 =?us-ascii?Q?EcAteINsb+3DTgZNWd1DCt8yfwBeQ+kZhjugp4J5pzxPsYj5p2x5U8w80lxR?=
 =?us-ascii?Q?9mUq26obfAJ49wh2S44jnbYRCSjFpcnFJXZc3AWdWrbix2GYJXdnWRSYPsiz?=
 =?us-ascii?Q?DhDdWUk+D0HMJvTMmMYNmTQ+STXS8Q9QWjxaIMBXGgzznfutAeBLbVUm6AmW?=
 =?us-ascii?Q?dhXJGXWnaj5A/nmsVkm0HtAqTihoGBNMDXWA7hP7KKWfekKEiHQyjgnjd2cE?=
 =?us-ascii?Q?9Hx/Qy5bvSJK6mJPUJGlHd8ztI0hSETj7XiFgbsgA0qvKhhSgk5lS/4OWpXo?=
 =?us-ascii?Q?CurjBHSA7lttyNW7+/sIbLeVuDGwrWh6Hm14paNB9AICIbdQdQQrIWwr2eOD?=
 =?us-ascii?Q?j/Z4blVWjtWapVgRiJn1Jq1vH8xUrqOFyO/80jt6qJaoBEzM5t4PXwO0Uo7D?=
 =?us-ascii?Q?cBc+ScNfVWPR2B4VaewhKOdgWTjKyGkFcH8biZQyo8Hj64Y5iv6jN+dUfjOM?=
 =?us-ascii?Q?jHFrDGkEiEGweP9/cqRsWc+K/7Ez3ZTzH90rqcd8VstqcBGz0Mpx/hkU5fqj?=
 =?us-ascii?Q?uOB67m8mWo49oai7jzVYfjG+AdSwvV+aqauWgyhFUPciJzT+RI7IWv+SOgsP?=
 =?us-ascii?Q?F5LklrVnBZs18rELXPqNnKhRAsah1tsLCFa90ofgY60JMG1f8rjQBuW57GIv?=
 =?us-ascii?Q?MLTnqTUnc3eBdnxN3/n4uZz0Etq17ErZewACw5XflzZdoqZihz3/2uya8csy?=
 =?us-ascii?Q?1qw51c3O4i3ngvajqlWy+gPpv4J7wq2R2Z7PGUvNwdWQxzsM8BVRsalHI8wp?=
 =?us-ascii?Q?xSobHJXTDlhZmkXF+l6XsZqQDRkzc5rcrP+mEIjwZWxrl0ezpKywp+cNEAn1?=
 =?us-ascii?Q?lCyOAlSUH8xxzjbwqgDFLr0w+8z0hNxNO9AGkZSB9q0plulgX2IY0YEGMmCn?=
 =?us-ascii?Q?0VQnftGKVYXMsD41sVAw7k+HfFqooRfdyXLw+Xh/cPt4Ia+LWHguOd4YNHxa?=
 =?us-ascii?Q?l6ntELzhuvXZgIzIzfpJ7XgDA+vTw/hskQz3OWMpuWRQq0zb+o7Zo7PFUb9A?=
 =?us-ascii?Q?WA7Ed8f6t7obD9NxpVKp2PUT6l3o8KU9DLFEXNYD3X2SG6zy03wo/EtNNtd/?=
 =?us-ascii?Q?dBh7JwmN1QE7Fbcqlcqe21XarZx2Sino4r/caP06cB5YrCrchAe0K3tvlvFO?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 095eb32d-4fa5-4d45-cad7-08dda3ab849a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 21:05:21.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VWyVI509N+OmqwyuzReqQTRU6of21tMOMVbjQ/MlOJn5z8MzD71tBSnPKsNJAxKiBtPkrOMSX8xpFFwcZUe1qS+4q3glYipfMJ3/MtnkcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> The PFN_MAP flag is no longer used for anything, so remove it. The
> PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been used so
> also remove them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good and I see PFN_DEV goes later in the series:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

