Return-Path: <linux-fsdevel+bounces-39110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF50A0FEE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 03:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039AA18861C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 02:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442242309B5;
	Tue, 14 Jan 2025 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWbT+8st"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088578488;
	Tue, 14 Jan 2025 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736822580; cv=fail; b=j1WJ2mQNW6ud3owbXGkflE7NKy8KHnd2jKNKOPqil3vaOLiyLSHU/bwDtlRzHpT9DP+oLG8ZhYfeDR/psXC+8s1VCqbicRuSn8THNhOo7OLK/KwLPimQJCLAQAhEvSTeMEDAuzUmip/vI1ChbK0UspLs1IAXm8ENyLWe1lntAY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736822580; c=relaxed/simple;
	bh=28noauLCixfn72KxxDsQx0fKG2JZXvOkemx6YL0mlRA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DvkfPcmfwQq+G7r90ye3YqICL7F7JbgfxtVsSPmisAasrgTiksWasAzlzOWZx787NJOjQo2ayvmQTwPxSmYJ7z/NcYHTSysoBqvvYhgbHbGDw7NOY8KYIjvFW/IMm48GuyVgISfCxV9VYTsFYvYfnGl8kGdy+Du7QpUO6RgULco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWbT+8st; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736822579; x=1768358579;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=28noauLCixfn72KxxDsQx0fKG2JZXvOkemx6YL0mlRA=;
  b=CWbT+8stBCLx2kBmAcyAYLnZYQMr//JnotEjZTZ7fmSvVt5FV0LeFfCF
   nXDNCLYR4sb8WP6b0XT/r5yDWrim8oOpgVqDVGuIc9WxEO8r53RTb5N6s
   Yd8cJbHY2lgULVXcNhH1f2dnOEmSt9CYt34yCsQrVlYJrjCplVRyELeTV
   3VTfB2GINn/+7YDN6WXbA+QXmX0MTOoJqwDevcv2YBTVM2uYWEnutJXyt
   9XjSZ0xVOpxPkKEWQ7Qg8l5mPxsbEBqM8AF53uThNgD+BlaAoPMnZPLrJ
   1yEKpodTmw13WJUfYR/VTXLA1QcTxIKmv3e2Hhcyzrlu3U9pjt+P77bPG
   w==;
X-CSE-ConnectionGUID: +CGZ2J6cSPqNfBYyxc+iSQ==
X-CSE-MsgGUID: 6zLJMAhITXGOtxaog3hpJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36995509"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="36995509"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 18:42:58 -0800
X-CSE-ConnectionGUID: PQzJnjVNSe2K3Fjjd15ezQ==
X-CSE-MsgGUID: 2/igtmoqS1ifObUXAkGXQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="104751695"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 18:42:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 18:42:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 18:42:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 18:42:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOUA9jyQCs2vXzQJu+qQE+nPfpOFrrNk+9iXH0XuUur7ACYZFZJYFU476Qru6Lm3c4B0Eu7DTFCyPHlTnlti9ITKrVHDGbP8cNrlBNFHLeBy9zJEuIg56y8/DCvpfNmhaNwZBEJzLimkDnrM9omlsMLeeE6htmgWMelss1EHQyxNynQbk4+bYkslpINyVuro146eMvPAt2PL3/Kz6F8rdZ+1FgBbzNECBpHXUfGi/2CA/+04zsKJ5zAm/YaZuG5adHXpQx/yOMDUvG9ZMSUtlx39j0E9ndi5OE1XJ5hCuu3VaZuiQmV+63sq5aLsQIfGyATF0LzPlYKe53Z5oRSlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJmm6VNmE6RAeWxfWyDuUi7gBfTXFc4XZixsvSo803Y=;
 b=YH3RNPCEydZcx2TD1nVzQ3USS7tcEROgs0I0pw5X20KKHXCXN0ukHsxa0384uy1flztCKjLj6BCehkufwdqPkyoBrgOTXurfZ06zTdfwgGENvimWU5es2o11UPceH8d65BON7NlKoHoBg3Pa2WC5E0ksO2KIW4+3QrM9O2dftwbozXs0PrYw1VzLiO6pk6mNw5++2WrD6Foy99fEJd3elV0ncvX3WLxMUrXUzXCnb5bgajFoM0EpyuLaz50h1r5m/5CvN+o1H+s1LecmglkJMAFMPDJmaRCsob1yfKKolRamfD9XD3LVKbDhwiSOZGzVgt5dMM4bcnS+09vyRsiLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:42:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 02:42:51 +0000
Date: Mon, 13 Jan 2025 18:42:46 -0800
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
Subject: Re: [PATCH v6 20/26] mm/mlock: Skip ZONE_DEVICE PMDs during mlock
Message-ID: <6785cf266ea89_20fa29487@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <e08dfe5ec6a654e8cb48f9203d7406326368f5a6.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e08dfe5ec6a654e8cb48f9203d7406326368f5a6.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0257.namprd04.prod.outlook.com
 (2603:10b6:303:88::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4789:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a41af75-ca19-4c66-57b1-08dd34452378
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NfZ7MWbcSsvWXNgPD+8TB/rWtHzR9LwriWU7cLfXDS3AK8a2U+nDVF3cqXFd?=
 =?us-ascii?Q?K6bvzDSyzDZ0ysyJvCS6YtHMs7wQJO0KCmAidHplAhkhgTFz1dewWmktH/eg?=
 =?us-ascii?Q?wH4ZbAlgfdCDFhj9JWwj7cwpzx/JGMwDRQE/8VhmnW/Cv5qY7tFMg5G7haU7?=
 =?us-ascii?Q?B1bVGTYrXvsxerrX9vaBiOM9Q9CXs9OE7mp/nqGAVKWhdB679TFUH3DY/xiF?=
 =?us-ascii?Q?cbx8n8jJJgvdhI9bb+9gxhJ3yrj/SV0z8fiVKNuZ1UByX8PMhbZCuMeC9aU5?=
 =?us-ascii?Q?z8TBhLjxZdCqwOTMJcDZso0arkMWV1z7RWAnJ4+J0b4R7RGgGvkPAQIZl8JA?=
 =?us-ascii?Q?/L+Y4FdhQ9bk4oZT03zN9HKsHQL/Xskhew/5MWjDWdqiYRcbuvQzZFZoU5ga?=
 =?us-ascii?Q?spaHk6FCCTuQS5XbtrEzMoeLWJKqWm5P4EMjL5Nrr0seZFx74VgrgXiLg3OO?=
 =?us-ascii?Q?3GFJnE9jS1qU6tJMlV1P3aLly2THvae5PX9oqtzlcqG1FDuFuivVAHU9wmS9?=
 =?us-ascii?Q?+nkjij+2GF6LTMCKbi4r8CCIigfNX4YbaE3UuFz8ASvh0kmwE57gLu21tV0Q?=
 =?us-ascii?Q?VnYJGEJkGHGJgVGjrtxsNPAXQdMIx2fwsUadP81ZBRn4y0sZQSOtfV4vSxer?=
 =?us-ascii?Q?oUvVWuJLUTexPcBfY9fgDzJhdkDXUpC3PSSwtKWa4oGHWfIhsJH09tQtF12M?=
 =?us-ascii?Q?+FGQFW5JQ1vWD1Z8BFZAwXMrtd8mrdyx4DMVYyVPxlmGcncWSD5JbxbDwfGq?=
 =?us-ascii?Q?DanDhbsHjDwhh4EKAn/df7kNMfJyQ3VSqPMeFT2B6Zos1gJA2+u1bDNRag4x?=
 =?us-ascii?Q?lQhHH5pcU+ahy+JNQyLEgNX40wxOr8SRZd20HjTaHb3tNCcXPLlGzRrKua2f?=
 =?us-ascii?Q?S4DQFrvDLg3Iw5gBsAXRuQLb8jBczZY0+ZW+15sGM0iM34aQcVQqCtlSw+XO?=
 =?us-ascii?Q?3vpOgy8UoZhAB20NXTEFGywSReGbe+LfPmMj5GZ4pT8bMFvo8sSBFLpP9pc5?=
 =?us-ascii?Q?HqDW2GWjhx++Nz49x4utjj+jR+fSIn0ezUUZ3Td1SZyRmInnx7AowVEt/t4+?=
 =?us-ascii?Q?ihlvr86xHvKAp3DGri/t2bVbEdHvhdEIOz+7mYpTCDKJP3j/Vs7KsIRKU6jV?=
 =?us-ascii?Q?LVrU1RDwz37liKbHilfEqV+8+PG8IC0TRALFQX9ahwRnwlHRIn6scBft0PRm?=
 =?us-ascii?Q?9GJr0XZub3JwaTAS9GoG/kzQFfK/huoyrQJgl2duTuhYDH1RBJCqxahbKBOg?=
 =?us-ascii?Q?G5vJW/1pE5rmIFVpuRHBKDkcDHaLUuj6q1JarxG3pTp5HSFSpFMnNIhMTU4E?=
 =?us-ascii?Q?Vv2Mt+oBBGqbhbDd4eIC0z1i9HMiJ3iErQhWnboLfQAXx1Zb324Mr0AMTQkk?=
 =?us-ascii?Q?Qz9KYuMjSXxQLtoCDJIZrui/Xd8d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4UNtRw//LLQQpH0XvNr4dKY+UblTsVHRv+LsDbonoTYZE8y5nyLcV0Lx1DW?=
 =?us-ascii?Q?zMfQFsWxii2QSWW+jaRhwjV9C7Zutcinyej9yfDa57p64XgB/ClSQxGiWLXd?=
 =?us-ascii?Q?YVUwz2ZhKLrhxZhUNvul5LyDbJYvHvmoZRfR42SbaUqg0bXCh1sWJ1lsQIKZ?=
 =?us-ascii?Q?Tkr8jRKTGELn/iEDlYctTyFL8RbllwEG2p6WGpGKmzXsqw0Jrw8tu6cgtCKk?=
 =?us-ascii?Q?JmLCA0V1zRJmnlpXaKDrRn7LIUDz7nqejKMCrcUKsJ87HtqiaHRi5xibjuO6?=
 =?us-ascii?Q?vWDQx3XctOCzWGgdJIgDVgw4vQLvZ5VnbuOp3KezxyVnPCyISRVhArfRi161?=
 =?us-ascii?Q?iVA/msqeXc0y6osgZ/vYZWWhWMvnhn2gcqgFACTso9VDJoyDC99lQzhTmruR?=
 =?us-ascii?Q?wIMXQGfSt9rwdWt7skFgw2sj2Im2dhQBllV1qFsXn0spo+U1YB/namRQEr5Y?=
 =?us-ascii?Q?GRFxdaMVzNJymQqzuIjCCLr+uzV96gVJGcHFVo9dhY4oEuHUUDC+np2bEsmL?=
 =?us-ascii?Q?S71hKFd8W1hYhV46Tx1p9QfsM6Plz2ThzzUvEZkxdUsSJrpKxgyC2QUUoC+4?=
 =?us-ascii?Q?j7qJrt7ikszLmyyjxTaYbOHMTfLtJ9zT4+WQR/+JI/XlexKseAD5TAFAVaBp?=
 =?us-ascii?Q?0xi37BCdx0QsOsYb/Qa11rjJL1B4HtYm3lzxCjhWjEClQJEhpq9VIaDsiJky?=
 =?us-ascii?Q?GW51OzgmRMsEYYyPnpD7e7tmg6eipKlZD5fYiRdX1QP1gErD2bDlTsEh772w?=
 =?us-ascii?Q?f9rrTpWuGgwf6gfT55/PjMN3V9T35+zotTE8IpH+m3+lNEG327z+tEihXXYK?=
 =?us-ascii?Q?Zz/+uARgIxEIXp6VDkTaClqi3hypKbQgZdtsQETqe35CK2OAuFPdsvbxNi0L?=
 =?us-ascii?Q?90DXm15M+VtwAUwO5XY1wsD+mbP9V9eEGdkudpWOii4AXWBL/DkFCkhTj1lm?=
 =?us-ascii?Q?aqAO/2Fat+7j1VraEyZDVpF77twKh2QT3FltOFlCpJoCX1bRS3U/gEpaMsCi?=
 =?us-ascii?Q?e4znKKLUV90BcTiLtAnBPNcIxqw5CCx99g1KloOn7LXwWy6Qxs+GjWO/N0hJ?=
 =?us-ascii?Q?b32CHmIliJT75APAUYHaaO3mHtzi2S1YKXriFq7SzIRiaQEAgU2mnhoYK4Ap?=
 =?us-ascii?Q?saTDeKft4c5l//4LzZhSycFS3bEx5ngYcMXpuw6UK99H0VIRwwdXK5qguZY2?=
 =?us-ascii?Q?nCBc9TwogvEH8Nbvj9Mcj2KFgDgpPgDhsW1y4kSxC1DR1QKcMxioEz8gG8hN?=
 =?us-ascii?Q?AEVA9aSK2boCdSElxlEeNGRYBL6weVARW/a3CJ1Hz9MN4WzLVRwi+wOYQU6f?=
 =?us-ascii?Q?MW32JeCvOvgYog6Ld3SDz4FSYgp7JgeqeUbLYz3KBpephb/ylF+SPkCm4AwB?=
 =?us-ascii?Q?iPxwIMfoLay/hn621Q8f5KT6PR6sMrliRhnW0yG/5Qvlyi34750P7aRS7aYM?=
 =?us-ascii?Q?scM6b3gjFuHD8iMSwkDjK1h1iQcWyrrZoN8WUK0Qxs3Wqr4jspZPpcGF6Rf8?=
 =?us-ascii?Q?oHxoEkMrXT4ATqNG3ZZEvyrEn3/7Yk7gwOI/VlsiamCVE7E5LadwibyaePBJ?=
 =?us-ascii?Q?S38wNpg6Mn9eRV7EKP7bM+VBFBfZOKVj+4IzXM4SmhxmsvYWXkehmg2hY3Qa?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a41af75-ca19-4c66-57b1-08dd34452378
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:42:51.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QYfBrhakpcNH6giBimHcyxEJAPDeyPg4E7zgO1K+OcCagzKGy4jdHMTV0PTy5UTm4a6DvP5QhZTcjnCEjX+3fAyboef6tNcLCD0R5+Xy98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> At present mlock skips ptes mapping ZONE_DEVICE pages. A future change
> to remove pmd_devmap will allow pmd_trans_huge_lock() to return
> ZONE_DEVICE folios so make sure we continue to skip those.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>

This looks like a fix in that mlock_pte_range() *does* call mlock_folio() 
when pmd_trans_huge_lock() returns a non-NULL @ptl.

So it is not in preparation for a future change it is making the pte and
pmd cases behave the same to drop mlock requests.

The code change looks good, but do add a Fixes tag and reword the
changelog a bit before adding:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

