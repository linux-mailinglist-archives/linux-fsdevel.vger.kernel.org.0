Return-Path: <linux-fsdevel+bounces-29799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAAC97DFCC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 03:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818E4B21147
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF819308C;
	Sun, 22 Sep 2024 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIH4d2Fg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512C192B84;
	Sun, 22 Sep 2024 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726969331; cv=fail; b=Urd8uyljSnHVpQqGpUYcfsDYvnefIUuhf2s1o7A7wnaNDZ69/oNuKhfnT7ikclFYHJWrPdSVD4O4aRzarM00ofNHFeevIOkc6GqljLpimPnhc9KJinBiKnpbHsQ7uw/yfhrzZgs9RPdFfs8mxRPvvQYiopCdsm6ZFVh9mpcmX7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726969331; c=relaxed/simple;
	bh=/L1XxYzad/VZdn+jj7xpr+AMD85mxOdRWetT7qxXCf8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mGM+xKA0ZbVP06HWoxKQ/EpnrOKDdXLuCxS5tRGhrY8kfNiMoSKgvLjKTHhOT8xZOVBGKC1tDT0DcRTEwxfBxPNrtHSbMeJXPeKZ5XUrB1DluUdHYMMsrto9ZSl8eSBtdWLQlvMBknxwN6P1DpE1sb85QmAvhaEkFA87v6f/IgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIH4d2Fg; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726969329; x=1758505329;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/L1XxYzad/VZdn+jj7xpr+AMD85mxOdRWetT7qxXCf8=;
  b=MIH4d2Fg3SCbPD1v37N/Vq1ipi/uJnjbdSY17iIFgktYYho9uyh5ZhBP
   5eKeV0fEgPM17x0JBbg2MPMo/QnjHhW8C+opmNaJ2BulutDfD0X1KiwRL
   6OgNVI8dcJgE5KLYn/mRCrG2tk070XS8A8K1B+Ss9lcHaNTGViy8LUwys
   az/HC80EI26T34dCoePEouDXfS+e2AHWRJG7mBnahxD3foBTEjar42K6y
   KBHcL8vTPL0J6+1EkRTCN8YE6KGbWzhDW2ZmZ3qWEKsrosLInjDxyruqi
   n8q621Ies6Z8SFw4YnuAh5qyChcjwlUSpZIgd8hD+jxjQkja4uLkm70C+
   g==;
X-CSE-ConnectionGUID: BYvDmojMRwWQ/AjlDesYkw==
X-CSE-MsgGUID: rfw3DERHRkmoI5zibQaKKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26038143"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="26038143"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 18:42:07 -0700
X-CSE-ConnectionGUID: Wo3Tns3uRp6xS/URIhSWjQ==
X-CSE-MsgGUID: /E8kPoMoTbmJfBheWHPa9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="70690625"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2024 18:42:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 18:42:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 21 Sep 2024 18:42:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 21 Sep 2024 18:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO2WHTx1NEQYjGE2KIl5+yLIWFcTz7oWAF6mOjS+76jOA2x4g0ZkKqlpWlU2Uyem9iQ5HT2D7/IAw48QPu+HrIp4ZcJhyV2ei7UQvKb2w/cWJu27paAyNUVxvK3wxRWw4+6jDIyXW5UJorr+6b9LlaDINLhSTB0zz20iYd3KLDzx0ye5gDJ9SsqgwMv77oOK6mGCM+1EpI7PyplYJvuEH/AkLQR1Ndny0UAeqVK3xpFvvpxgJ+COFmmI3NRcG0RK2EYdfWNC+C+GuVWYdK2GsOm/Gan6Trc0OYtvd9fMpDkoYktsEtlO4zOtLfQgR4CuUosemNdKZV6AOdGSdpAsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COTf4xb1EIpYlLQ0Pg2yTI8lVe2qW0B0HWQqOe0qbbo=;
 b=bW8Cp+zZbjWy+/H9rDSX/+EGaWYHh15vlHimx9CO3d+L4Peo6mUmfymFBE4ANhfYxvAI1DIu+oOWOONKpv6PQHvzWoffD6IAnB8juoNXXsBI5MDf9rmIBDyuSxUYv5lWIkxLWEi3DE1J1ZokcXrAsvjKsdPCKztgqIELoROF3SXGVj5vPsYllxmqFl9aXHz1GzR/hIX3CPyzbh5Y+nliilbGy9Nffkho3CHhbQRHNRyZb6eBYa9UPLztbBDSzqHCMRLu29ejJ4kMvs3ZBMIchTeWMW425TkhXoGhBs0i+XXmr6soIwklYjVXro9FKcZiB2rQATe4P5wpRBDYxo91Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 01:42:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7962.027; Sun, 22 Sep 2024
 01:42:02 +0000
Date: Sun, 22 Sep 2024 03:41:57 +0200
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
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH 05/12] mm/memory: Add dax_insert_pfn
Message-ID: <66ef75e59c7ea_109b5294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <110d5b177d793ab17ea5d1210606cb7dd0f82493.1725941415.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <110d5b177d793ab17ea5d1210606cb7dd0f82493.1725941415.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:303:b4::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: d49d016b-3b30-4d8f-5612-08dcdaa7c19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uZ72BXUS9lVU5WAtkW+FyN06syIR1UdvFTH1vtN/s0nTGe1Ei4hfg/eTvjmQ?=
 =?us-ascii?Q?lAoDZ5QIVCoPbqgBHr1hfr3l2hnAyz4gBi/h9AsX0oykLfuAtdrMp1pMcRSx?=
 =?us-ascii?Q?Te/UUFasah6ApjDPCdaxTT9WRnkoDg/HbLZFgLe9VuPIn+Ny+dAuvuzGs0wy?=
 =?us-ascii?Q?0IwdwaI91/QV86di8Bp0lGCYIH4VHIh+X1J02wo4hkC6zGtquXCSaREqiP9h?=
 =?us-ascii?Q?/pLKlHUP0EoNq+tnV2tB9bQ2iw2XMSYXP4DlSIA4/pdlD99X8G5IKwrI+U5B?=
 =?us-ascii?Q?LJf+CmLMat6pj/A7gsqvwHNj1pD+MzEZDpPybtH9Vv+VtLY9HIghKrjLsngG?=
 =?us-ascii?Q?2upmssm38B+GgFpMmRSWM0Z4PYeJZRU7hrOr5wNEFpDVcFkfwxCU5YCFaErD?=
 =?us-ascii?Q?3LkhoXnPRtp3gSL7G4V6QumHOrJVz4hgxr1GIZdY/RQbih7CINqrMcygal+p?=
 =?us-ascii?Q?T6rQ3aN1NCJLUd3+l37vshAr4mvAXd7tpzeOEXmj8XmFMA9oH6mqzOBWz0pO?=
 =?us-ascii?Q?7obK1lVc0im9wSA1VZLQS6Rc/OvCbL0Sib5p1cuuEgz9FfmfxOPkvBs/P7/t?=
 =?us-ascii?Q?Q2dUptmRKS5r5aLhu9eUOt3nxp0FjP++DmRgkupczfPTjZFBoz4x6vuDuBaR?=
 =?us-ascii?Q?v6i7qXOHAVPQdefIKzW0QiMyX7Bf4UDhiWdKiLB4ip/we0uZ2lGGtj2Wwlow?=
 =?us-ascii?Q?S/kTg6K1K4F79ei1tntapHHJV3RJQwyZFu7CQpnH4+LBRm8o8mcVW3BhfHwp?=
 =?us-ascii?Q?miqqVD/5YK8L76Hequ/cza5F16lzhdeJzgPc1XHOydDgtJrYLSyaM2O9a/5/?=
 =?us-ascii?Q?2rrWHFdrYIbSZZLI5AytPD3U78Fn3N8U9ou6cd8k/2XKZ2Ac2NY7uYaPJ0mY?=
 =?us-ascii?Q?jxOfb0AyVXMGibYg9SljgdjGCJNL7vMCEoqK+57/XKsPgSDP04SrpPYvldg7?=
 =?us-ascii?Q?cmu2JNs2vB5/5TU7CntVE9fEMKJsQldzirTHRA8lBGDlZ4JWKjiuosXTcn68?=
 =?us-ascii?Q?Ph1lbzTDXzLzW9i5Btd54vTYADqD/0Z2mTtEg7V+oNnWHIsTxAl/UnIVatkd?=
 =?us-ascii?Q?pTcY/CyLGCsfsiO5WrmBZqZrtntFWk4TqShHXwVjvwJ5zevutbnIwldBzUzm?=
 =?us-ascii?Q?tKY7Yztinpfgr5omAcO0qUUJhmV3AO/n9vbCyP/5ut4OqSTI0rMRxazj6QOq?=
 =?us-ascii?Q?8KuRrxSBtz8XE8hz1CEUzs2lRPVhfxYr/HISIlrf+hKC6EGBnmaqM23NTEvA?=
 =?us-ascii?Q?PhumB4Yu1xvbeThSiynJe0DTDXXz429n1V7Y8BCaNWTDtTnrZ/42pNO70NgH?=
 =?us-ascii?Q?Wl3zLUYASP5n5icIkAL71C4jMWGBWjwXrC7Jw6mFYtgXksP766sT8aPZl6DP?=
 =?us-ascii?Q?mryqpFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O8VbIq1g3anv0vdzWWkbx/uwZis9sxxkJ2t5+m/AJEldKgiCXAbp+roQm95R?=
 =?us-ascii?Q?2nUU6SJIZO9BWwnehC2DgVxMdbGGso6B9L+/hAPHP2lDNIaU50jytrNCFp8r?=
 =?us-ascii?Q?zeDJt8tbZoFuE1ikSJlvg4zIhavG4JSJypbq1WSbUTKiHDp8wJOVpdLqRXWb?=
 =?us-ascii?Q?7ESWMK7TGzJ/sNvnCzBpMlnYRocG65gzfomXjty0BVSOAFTv72yd+NgyWj7G?=
 =?us-ascii?Q?7fsIKbENxiAvmld4JW+04jyEF7EbbMoYgMOofnhw23xql2RLCghGigVGHC6h?=
 =?us-ascii?Q?mcdQqpzxpcXFmukGVBY5sNz4qFy297ua8axqQiXNcBRz3zUa3kUxK3pwwrFD?=
 =?us-ascii?Q?zub3ZFemgzTPOOtVWg2qN53VXqMvULAsKDalRmu3TdgFpq3nBhYFgt2W4Soe?=
 =?us-ascii?Q?8QWNzd6p1EHBVTBUfxafamn/VKBVijZoFariLHA6YcLlqMhhZaCqWLuixqhy?=
 =?us-ascii?Q?0tZkqmUnKZxjLBLRJs9HaohX83AtnbYXU0tcwfUqlMdk4miFx5Y63PDwFENs?=
 =?us-ascii?Q?1XW+f7KHGO3eiralcc/iOW9SVh4DIZi20RJ2xUxv7cmbQbkQzRpmjpU7SEmI?=
 =?us-ascii?Q?E87IiuzDJoXWSaPiQquvEmMad2uzlxooPmn0dP/dBxXxx8Z5TjO+93HT/lr/?=
 =?us-ascii?Q?ezFUuug5WgU1qxNLUd/hXkaqGAwXvELp1DI5pIiAql19tFpkNngfpBxcLfeL?=
 =?us-ascii?Q?YHmGAyC7VdRLSFRsCR6f6oDH5sLrETyYtcsSKIDeeWy5xU034DFzx5t0r+Qx?=
 =?us-ascii?Q?AvKgPZN84E4iCKDGN0BCPwtrLtDAB5vkBK9Vo8/KeH4/iSBwE8eKn8lymd3Y?=
 =?us-ascii?Q?akflEamU2c8uBFtDqmYHDAMOkpWyYav5ROEDvW0zGFyG3rYMnybcC08dAY/x?=
 =?us-ascii?Q?an46MP2A4HnSSb25Zn1EeFomPN+GSRP6bq3XoaR4nY267sbuDbnTClXoIFMD?=
 =?us-ascii?Q?Ht51G7AHnwDJ9nwVXEMBvSrHLthX4INFyrr/GWMznYNlqyCfqS2MdmEFxrGw?=
 =?us-ascii?Q?Pf1iPyyZO3jmysJdlJ8BXeBnhUdWAZkJd7psZAHpfSWV0PIQD9M+tGIaqW34?=
 =?us-ascii?Q?3igflp4rK0OvsxVPdKFey+B/68ZYrVUXuXamqcpL8B8WNfBg3vWKdPeI7IuG?=
 =?us-ascii?Q?vpkSJpdJdK/HUJEfxYn/PXcRBoq6y62Mml2od+YVZ5cvZglaXdLkgA90+sV2?=
 =?us-ascii?Q?VTKHbtmFiSOVUFOQFn2CAkrtBaMgQSqgSqwVit87I5UNqrdpjWEnTgzmfCOr?=
 =?us-ascii?Q?xAzcpltMYXz8eZGtCKNCch1RW3XttbGL2+yPkeGYZ6aMufauhmIeU6KIJiKu?=
 =?us-ascii?Q?qtlrZ8eAn8pWb/y/0083yHZjvMMVHCAgmvINJQp6CnLzII5RnlUdTpBRKMiG?=
 =?us-ascii?Q?FPkwgKJ3mCpP6o5CVO5Tszngyymz8NkxjC8pgkenG21/dibOqmnYbDdkh342?=
 =?us-ascii?Q?ejeVNU7LyV1ld1sX+0wr5rbbk+Hy23oUdQklrCCfvYS/rsmr8T/wA11VkvBz?=
 =?us-ascii?Q?kHT2o6OyMFIeVVq/shg/1uxRJxLAs+9ZNGhZI0Kz+dOxFH8bwzK74Oa8z8pp?=
 =?us-ascii?Q?TH2ovygd7d51HNNf4oIeFLmk18hndVehFfJG7uXYwBEUVzmN2AAXu1rJD3CM?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d49d016b-3b30-4d8f-5612-08dcdaa7c19d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 01:42:02.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPnOPiRIg+Aw6BtoQ2/ta6MhwSwQGQvxeOlVQWGIPyfeR4X9uauOcXgTopjZwXfaO6mUEhn5c1Iar7q4fF8AsWYmOi+/ZtFL4w7LKXhgDys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com

[ add s390 folks to comment on CONFIG_FS_DAX_LIMITED ]

Alistair Popple wrote:
> Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
> creates a special devmap PTE entry for the pfn but does not take a
> reference on the underlying struct page for the mapping. This is
> because DAX page refcounts are treated specially, as indicated by the
> presence of a devmap entry.
> 
> To allow DAX page refcounts to be managed the same as normal page
> refcounts introduce dax_insert_pfn. This will take a reference on the
> underlying page much the same as vmf_insert_page, except it also
> permits upgrading an existing mapping to be writable if
> requested/possible.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Updates from v1:
> 
>  - Re-arrange code in insert_page_into_pte_locked() based on comments
>    from Jan Kara.
> 
>  - Call mkdrity/mkyoung for the mkwrite case, also suggested by Jan.
> ---
>  include/linux/mm.h |  1 +-
>  mm/memory.c        | 83 ++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 76 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b0ff06d..ae6d713 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3463,6 +3463,7 @@ int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
>  				unsigned long num);
>  int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
>  				unsigned long num);
> +vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write);
>  vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  			unsigned long pfn);
>  vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index d2785fb..368e15d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2039,19 +2039,47 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
>  }
>  
>  static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
> -			unsigned long addr, struct page *page, pgprot_t prot)
> +				unsigned long addr, struct page *page,
> +				pgprot_t prot, bool mkwrite)

This upgrade of insert_page_into_pte_locked() to handle write faults
deserves to be its own patch with rationale along the lines of:

"In preparation for using insert_page() for DAX, enhance
insert_page_into_pte_locked() to handle establishing writable mappings.
Recall that DAX returns VM_FAULT_NOPAGE after installing a PTE which
bypasses the typical set_pte_range() in finish_fault."


>  {
>  	struct folio *folio = page_folio(page);
> +	pte_t entry = ptep_get(pte);
>  	pte_t pteval;
>  
> -	if (!pte_none(ptep_get(pte)))
> -		return -EBUSY;
> +	if (!pte_none(entry)) {
> +		if (!mkwrite)
> +			return -EBUSY;
> +
> +		/*
> +		 * For read faults on private mappings the PFN passed in may not
> +		 * match the PFN we have mapped if the mapped PFN is a writeable
> +		 * COW page.  In the mkwrite case we are creating a writable PTE
> +		 * for a shared mapping and we expect the PFNs to match. If they
> +		 * don't match, we are likely racing with block allocation and
> +		 * mapping invalidation so just skip the update.
> +		 */
> +		if (pte_pfn(entry) != page_to_pfn(page)) {
> +			WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
> +			return -EFAULT;
> +		}
> +		entry = maybe_mkwrite(entry, vma);
> +		entry = pte_mkyoung(entry);
> +		if (ptep_set_access_flags(vma, addr, pte, entry, 1))
> +			update_mmu_cache(vma, addr, pte);

I was going to say that this should be creating a shared helper with
insert_pfn(), but on closer look the mkwrite case in insert_pfn() is now
dead code (almost, *grumbles about dcssblk*). So I would just mention
that in the changelog for this standalone patch and then we can follow
on with a cleanup like the patch at the bottom of this mail (untested).

> +		return 0;
> +	}
> +
>  	/* Ok, finally just insert the thing.. */
>  	pteval = mk_pte(page, prot);
>  	if (unlikely(is_zero_folio(folio))) {
>  		pteval = pte_mkspecial(pteval);
>  	} else {
>  		folio_get(folio);
> +		entry = mk_pte(page, prot);
> +		if (mkwrite) {
> +			entry = pte_mkyoung(entry);
> +			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +		}
>  		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
>  		folio_add_file_rmap_pte(folio, page, vma);
>  	}
> @@ -2060,7 +2088,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
>  }
>  
>  static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> -			struct page *page, pgprot_t prot)
> +			struct page *page, pgprot_t prot, bool mkwrite)
>  {
>  	int retval;
>  	pte_t *pte;
> @@ -2073,7 +2101,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>  	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
>  	if (!pte)
>  		goto out;
> -	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
> +	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot,
> +					mkwrite);
>  	pte_unmap_unlock(pte, ptl);
>  out:
>  	return retval;
> @@ -2087,7 +2116,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
>  	err = validate_page_before_insert(vma, page);
>  	if (err)
>  		return err;
> -	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
> +	return insert_page_into_pte_locked(vma, pte, addr, page, prot, false);
>  }
>  
>  /* insert_pages() amortizes the cost of spinlock operations
> @@ -2223,7 +2252,7 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
>  		BUG_ON(vma->vm_flags & VM_PFNMAP);
>  		vm_flags_set(vma, VM_MIXEDMAP);
>  	}
> -	return insert_page(vma, addr, page, vma->vm_page_prot);
> +	return insert_page(vma, addr, page, vma->vm_page_prot, false);
>  }
>  EXPORT_SYMBOL(vm_insert_page);
>  
> @@ -2503,7 +2532,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
>  		 * result in pfn_t_has_page() == false.
>  		 */
>  		page = pfn_to_page(pfn_t_to_pfn(pfn));
> -		err = insert_page(vma, addr, page, pgprot);
> +		err = insert_page(vma, addr, page, pgprot, mkwrite);
>  	} else {
>  		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
>  	}
> @@ -2516,6 +2545,44 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
>  	return VM_FAULT_NOPAGE;
>  }
>  
> +vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	pgprot_t pgprot = vma->vm_page_prot;
> +	unsigned long pfn = pfn_t_to_pfn(pfn_t);
> +	struct page *page = pfn_to_page(pfn);

The problem here is that we stubbornly have __dcssblk_direct_access() to
worry about. That is the only dax driver that does not return
pfn_valid() pfns.

In fact, it looks like __dcssblk_direct_access() is the only thing
standing in the way of the removal of pfn_t.

It turns out it has been 3 years since the last time the question of
bringing s390 fully into the ZONE_DEVICE regime was raised:

https://lore.kernel.org/all/20210820210318.187742e8@thinkpad/

Given that this series removes PTE_DEVMAP which was a stumbling block,
would it be feasible to remove CONFIG_FS_DAX_LIMITED for a few kernel
cycles until someone from the s390 side can circle back to add full
ZONE_DEVICE support?

> +	unsigned long addr = vmf->address;
> +	int err;
> +
> +	if (addr < vma->vm_start || addr >= vma->vm_end)
> +		return VM_FAULT_SIGBUS;
> +
> +	track_pfn_insert(vma, &pgprot, pfn_t);
> +
> +	if (!pfn_modify_allowed(pfn, pgprot))
> +		return VM_FAULT_SIGBUS;
> +
> +	/*
> +	 * We refcount the page normally so make sure pfn_valid is true.
> +	 */
> +	if (!pfn_t_valid(pfn_t))
> +		return VM_FAULT_SIGBUS;
> +
> +	WARN_ON_ONCE(pfn_t_devmap(pfn_t));
> +
> +	if (WARN_ON(is_zero_pfn(pfn) && write))
> +		return VM_FAULT_SIGBUS;
> +
> +	err = insert_page(vma, addr, page, pgprot, write);
> +	if (err == -ENOMEM)
> +		return VM_FAULT_OOM;
> +	if (err < 0 && err != -EBUSY)
> +		return VM_FAULT_SIGBUS;
> +
> +	return VM_FAULT_NOPAGE;
> +}
> +EXPORT_SYMBOL_GPL(dax_insert_pfn);

With insert_page_into_pte_locked() split out into its own patch and the
dcssblk issue resolved to kill that special case, this patch looks good
to me.

> +
>  vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
>  		pfn_t pfn)
>  {
> -- 
> git-series 0.9.1

-- >8 --
Subject: mm: Remove vmf_insert_mixed_mkwrite()

From: Dan Williams <dan.j.williams@intel.com>

Now that fsdax has switched to dax_insert_pfn() which uses
insert_page_into_pte_locked() internally, there are no more callers of
vmf_insert_mixed_mkwrite(). This also reveals that all remaining callers
of insert_pfn() never set @mkrite to true, so also cleanup insert_pfn()'s
@mkwrite argument.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h |    2 --
 mm/memory.c        |   60 +++++++---------------------------------------------
 2 files changed, 8 insertions(+), 54 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5976276d4494..d9517e109ac3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3444,8 +3444,6 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn);
-vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
 
 static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
diff --git a/mm/memory.c b/mm/memory.c
index 000873596672..80b07dbd8304 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2327,7 +2327,7 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 EXPORT_SYMBOL(vm_map_pages_zero);
 
 static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn, pgprot_t prot, bool mkwrite)
+			     pfn_t pfn, pgprot_t prot)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, entry;
@@ -2337,38 +2337,12 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	if (!pte)
 		return VM_FAULT_OOM;
 	entry = ptep_get(pte);
-	if (!pte_none(entry)) {
-		if (mkwrite) {
-			/*
-			 * For read faults on private mappings the PFN passed
-			 * in may not match the PFN we have mapped if the
-			 * mapped PFN is a writeable COW page.  In the mkwrite
-			 * case we are creating a writable PTE for a shared
-			 * mapping and we expect the PFNs to match. If they
-			 * don't match, we are likely racing with block
-			 * allocation and mapping invalidation so just skip the
-			 * update.
-			 */
-			if (pte_pfn(entry) != pfn_t_to_pfn(pfn)) {
-				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
-				goto out_unlock;
-			}
-			entry = pte_mkyoung(entry);
-			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
-				update_mmu_cache(vma, addr, pte);
-		}
+	if (!pte_none(entry))
 		goto out_unlock;
-	}
 
 	/* Ok, finally just insert the thing.. */
 	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
 
-	if (mkwrite) {
-		entry = pte_mkyoung(entry);
-		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-	}
-
 	set_pte_at(mm, addr, pte, entry);
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
 
@@ -2433,8 +2407,7 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
-			false);
+	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
@@ -2480,8 +2453,8 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 	return false;
 }
 
-static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn, bool mkwrite)
+vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
+			    pfn_t pfn)
 {
 	pgprot_t pgprot = vma->vm_page_prot;
 	int err;
@@ -2513,9 +2486,9 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		err = insert_page(vma, addr, page, pgprot, mkwrite);
+		err = insert_page(vma, addr, page, pgprot, false);
 	} else {
-		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
+		return insert_pfn(vma, addr, pfn, pgprot);
 	}
 
 	if (err == -ENOMEM)
@@ -2525,6 +2498,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 
 	return VM_FAULT_NOPAGE;
 }
+EXPORT_SYMBOL(vmf_insert_mixed);
 
 vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write)
 {
@@ -2562,24 +2536,6 @@ vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write)
 }
 EXPORT_SYMBOL_GPL(dax_insert_pfn);
 
-vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-		pfn_t pfn)
-{
-	return __vm_insert_mixed(vma, addr, pfn, false);
-}
-EXPORT_SYMBOL(vmf_insert_mixed);
-
-/*
- *  If the insertion of PTE failed because someone else already added a
- *  different entry in the mean time, we treat that as success as we assume
- *  the same entry was actually inserted.
- */
-vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn)
-{
-	return __vm_insert_mixed(vma, addr, pfn, true);
-}
-
 /*
  * maps a range of physical memory into the requested pages. the old
  * mappings are removed. any references to nonexistent pages results

