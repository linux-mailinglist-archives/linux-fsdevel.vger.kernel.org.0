Return-Path: <linux-fsdevel+bounces-45061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A01A7108A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 07:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203A93A5544
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 06:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F0918CBFC;
	Wed, 26 Mar 2025 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqGoJAy1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAC1714B4;
	Wed, 26 Mar 2025 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742970465; cv=fail; b=O2EbD2vMitMQjIFWq1nzIOsS3cQbFqlZH/6rQIXJOPnapf48NOmf4V+WZvzWG6Gg0LT1dOQkxSImFLLFwVeQI+3w6QUZQ45vQzM9k4vNfTpVj9rTQeL1JZd2lxMDlWDAZ6AIBWJPzWpEa0NJkasK9yCNCHmtIZ18WKLA+e8QYFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742970465; c=relaxed/simple;
	bh=dxsy1BITnGVzN3Qw4L6bCEjsJUE0+H337xxppm9MqFc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JXyU6sgRh6UNxjaOirXJPgvvkHsM1gzaC6j2l/m2xlIf+fi9fE0SiOxbx3BkAbkB2c7bm1V1sv3GFDTO3P13gGuObaXO14fGcFnMTJlPdjDuVZtXPmbUlq34G0L4b4Maqnj+JrK8vlk6NxJf3hQXQTE0sAGL/Ox7sxpFwulf/bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqGoJAy1; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742970464; x=1774506464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dxsy1BITnGVzN3Qw4L6bCEjsJUE0+H337xxppm9MqFc=;
  b=bqGoJAy1EQCLsdhomC9eWAlmo9gGvZEFxQzMc7h3nRE5gzUjM/hnCq/7
   pvDjGjRk6Ls73qL8GysbBTvyd2Evy3SCyBcGIrBbz7hxEQ+oG9AwAamPL
   ZiCqE/dABIChe5pvKDcu87+qi5liy4djgp9oEyW69OotryZ/HAUt2oR2p
   rEzcT0Nyf+AhYubIokXTI8rRF0gmJ6xutbO/HhVLu5X4BTqpGAtFEgW4d
   HkQLjwNMeTr6SER3gff65rvewRyCmaD9B/Je/oYTtXd6XXMAxFCzamGZu
   xpydcdMHUz/ZqgrJK9Z8+GCxzWVzr8HRHj9EWyzP6QDdvYLOl+H12Knau
   w==;
X-CSE-ConnectionGUID: yfrmMv3wTliiAEJP+5P9EQ==
X-CSE-MsgGUID: vdjzIGrYRSa5E9jnR9tQVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43397021"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="43397021"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 23:27:43 -0700
X-CSE-ConnectionGUID: q9dUuxdbQcms68gjZBnDng==
X-CSE-MsgGUID: 0vVp8LExT4mGAwsUmOGGzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="129676786"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2025 23:27:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 23:27:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 23:27:42 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 23:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ei8X9mF6+bamjiX7mR1OMnvGXojsBMQwziBpZUSb2jWYFul7DUVo7MYZnXBzEZZ5oHheuqgV+krnYzGJUaZ1Osgqrl1LCkbbkL640jmrGIJPXxYkpwekuCObE6WyFtwf/AFo3UodSbYi18ad/8aus8yLIcfRnd7H3TdlR4dxA95MKCRmIfHaklaPPYO/Bz8kmNC9H5RMdfj+LqKBTA7nCKVELZOokogwGyns9JaMGXj2xbzp0SjamSz/V2fKhnTPljs6XQ5gn+0Em6lFkrx6ilue5rvENWRsnorVaz3ssMvVJdTYkLiU6cg6z+P2nKR1T6Tih3N8P3xpq7Xqpgc7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie4234iqMOM9pY3UCPLVMw5t/U6dDG5fTTC9ZHtnxM4=;
 b=KeVQouX1xWbcec6EczaH7Ngs40YjJSmHz5vGPwB79ZhipN00sBiQo/qu99om8dy4kJnll5iWAEypoSYcrIeDNbo1uG4gB5YhQ6AYmn2vDc7eSvC3CwFnYaL48V5hIGUibhTjGNiK9We4lU/8wPOicUdi6PJhCxOyPKqKTv+OkNcqhhYy8M06aiwf188lZWcNCHlh3E3eY7tz8x/JBzPjVRorbqn2SceW0tLIIxw/rcOoXx7N0d6w7L1WwTU/hBvd5gXI6ehavCbu333XQxe/GdmeF5dwYVr9MnXRnVyN6+8krMOl52KXec73lYLs/7oAjr+mpK+qCaZZkPTyqMk5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 06:27:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 06:27:34 +0000
Date: Wed, 26 Mar 2025 14:27:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alistair Popple <apopple@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Asahi Lina <lina@asahilina.net>, Balbir Singh
	<balbirs@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>, Chunyan Zhang <zhang.lyra@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@redhat.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Jan Kara
	<jack@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, linmiaohe
	<linmiaohe@huawei.com>, Logan Gunthorpe <logang@deltatee.com>, Matthew Wilcow
	<willy@infradead.org>, Michael Camp Drill Sergeant Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Peter Xu
	<peterx@redhat.com>, Sven Schnelle <svens@linux.ibm.com>, Ted Ts'o
	<tytso@mit.edu>, Vasily Gorbik <gor@linux.ibm.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Vivek Goyal <vgoyal@redhat.com>, WANG Xuerui
	<kernel@xen0n.name>, Will Deacon <will@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-xfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs/dax]  bde708f1a6:  xfstests.generic.462.fail
Message-ID: <202503261308.e624272d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 4816b4ba-e3b9-45da-3c3a-08dd6c2f4b4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TMZXkNgl8t9bLNTuEms95RYo+fa+N/0HvD1UbRSDpRkpJDb2iwGwEgEmjnY3?=
 =?us-ascii?Q?OQe0PVFQm8sOaozNzQ0gBDlEoXdN1EdLPDSlC7xpvpX7EdJDbvpXrzmv94sN?=
 =?us-ascii?Q?wofddTHKY4MCSahxO73E43wQHm0xuf5dsqSG1uWWDeuThqWuGj0anF9TxSbN?=
 =?us-ascii?Q?4k9+mTZBGg2Cerd4oFRyaIQaVMJBDBkYlEYmg2C2E39yByOWm6Ciw60VjyXi?=
 =?us-ascii?Q?6aXL29kEhUqmR79CDwbvwyRY7Bk7u/hnQdLwvzeF7T/klbHsDO5iW40bg0rT?=
 =?us-ascii?Q?S/RLMYSVW0fEdxKA3CmxXpJ/sIlodWephI7BGxknnvF1nhEnRWxTFFl+HXfq?=
 =?us-ascii?Q?A4qBbSWm9pQPuQh+fg06og/gHTzUvQYL3pn0OUEsBr+3ZR+8gLY78Tk9Rbjj?=
 =?us-ascii?Q?xdZ9KfsfdQSgtfm9KoFZcJLZGNb+aUdmAm1JGa/hJqGD+YJAUCH0pAo665JU?=
 =?us-ascii?Q?bgp1rc/27dRO3hjUdguBXtE/+6dX0gK8oohMH/35HnxXmRg35UQwmwCBsd6D?=
 =?us-ascii?Q?NQybz0tijMgvEG+1SoukxoHXpPP8iUP93zG63Nm+/N7kSTqCAv+UUAxMTV0F?=
 =?us-ascii?Q?m9bb09m38EW0XNYN1eK3fGE/nwipZDa2Bg0maiycMHuR+aYq68+LVAXJPK3q?=
 =?us-ascii?Q?3T21zk0FvhznWOUqOJG7kTD20NeMUwHkKtW8vqKsifAyw7sVJ5uCPQm9VPXu?=
 =?us-ascii?Q?BOvTriCeXTjCVbfCukG5YuQ3U2DmKlkQmC5HgPNL2j/H9LcmtWvuNwsmjNmL?=
 =?us-ascii?Q?iumPGGQhRO1XYNbSI7Nj1+MqitX2mWc/dD8M+eK/ZgyVeiTpivUTIFDWVWYJ?=
 =?us-ascii?Q?tbHUpDqJ1v9YhePAe8bwJhipukuqcBaX46lMb22RIf+C+iiMlRjlp6l6yR09?=
 =?us-ascii?Q?j+SBWp7vMfFcG/Ld2xUniI0SUw6s0u+WW1IKowdiA0QTwfC1YhILl4Jpooyf?=
 =?us-ascii?Q?0WWf4i3I3LZ1y+6snf71JTxvutgllIqUyqrMeaNx0TVgzT5cHPBU54vWBvEL?=
 =?us-ascii?Q?VDXAIN2F/fy0XFw8MEWPxypYFgh0sAN5F2aS2JLOVU9ILtreU7sMJM9Ptz89?=
 =?us-ascii?Q?4y/9E5Y3hQcZeLQagBXgQ7zbgJm58AjJiVqvnkCso0ZBDQJtlJx+hadMslsG?=
 =?us-ascii?Q?XkQ+fQkw6s10c8AYDEW4SG77hQ6nChBf0W+F3g3mKZJ6Su76kskGcXTsF5hC?=
 =?us-ascii?Q?AVcLCGkSWPcgoIqWz/UpP310bor1kZpNE5PXMMhuAD6H9KXefylD215wVvfX?=
 =?us-ascii?Q?jnoZod5hQT1hf7+73cL7ccrOe6PfwyqKLfsUYR8Z3aK6sIpFIyarRSPyBlrB?=
 =?us-ascii?Q?RANZMedbxC74P43HLfNJcfTq+Yz08JGtIBPuT1o2v88Sbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HL3P2hmDvMit6JKPmJCacIdf/dp9PN3jJGwJB1XHcELbdfHDE/qvs1ouJSgs?=
 =?us-ascii?Q?Ob2TJh9geY9+a2T+2dVb8vwa18sKUig3GXeHH3fZ+eW/juGdOAV2sBea2Vw/?=
 =?us-ascii?Q?c3RfIGMN16sWr+Vh8fkZ2xXzU9JsYNQcBZoorkHwavUe+jpfd5Mg5zwUwER0?=
 =?us-ascii?Q?4VfVluswVcNR/WxaYVkrsJpl+Jj0hPBSbWWzaZ1pGe1G/e16JNB5824J/Mls?=
 =?us-ascii?Q?OAxJk6Dzliw0YyWEQ76cE6QMzy1g6aVq54gVe7qAmT0umkMXHvCXYk74aJkG?=
 =?us-ascii?Q?rsdtL9f2DJZYdkSjg54hEmMyEakdorq0otHRxmoSYxFxVsz/1RIfEBCGPqR+?=
 =?us-ascii?Q?Cj33I9gHZntYYfSBQ+J3bu+Iar8X36jfjrA/AWFCSOqy6GUbdKCA8inM0+0v?=
 =?us-ascii?Q?IXRLnvxPBeRREmCUKtOt9TUOTMA5vq1u8TuYnrtd2aIrD7aHNk/WY2HEElnl?=
 =?us-ascii?Q?O7iDe6DC57y8G70bQK0957LdXJY3KEuEWdRo17iKXNeJ8yXhzLSlKZxHDpQY?=
 =?us-ascii?Q?vtmwO0y9yCiCYMcnrAKi+Kkom+d3GmCihI4rp1d7lTvU2aT/sgPqfc0YY521?=
 =?us-ascii?Q?3RRjhgNRDd0lATXhwB+8QyX68JZ7KUPnFYUqyVwYR9vK1Mf2ZBKCGEYOvETd?=
 =?us-ascii?Q?XOqVJbi0Eile+m2b8imzU0QY1a8/KWSMP15FAItUQeEnkISigGtWeW5AxpFi?=
 =?us-ascii?Q?O5iviO/FpGoMpRFHZSVuLxCqOXWnTpqs0YKp+ba2qrrHY9JtH1hwpDxotsT8?=
 =?us-ascii?Q?lJXGl76xdyvZkIfssP9bMTqiPaPlxhvhRAQFN7c8eT1hbeu5neg8F0xrbqIV?=
 =?us-ascii?Q?DV4BpsmQn6xQD7XV5p61ILlhFB06ntktkIV2CDV94d3t3AS4eR2pSR2yYCrp?=
 =?us-ascii?Q?IYLHnGg4uc5dlew/hcbOIPMFhRhWQs1wHR9FMVdvUcT91UVnkzVriKW8lubb?=
 =?us-ascii?Q?jrMCnoS9R3if4WUyd7h/0OFZrPHu6PLv87/pECxK+nsATCFPHkYBibSIdz8s?=
 =?us-ascii?Q?6F9o8oSvHQfxvSmoCbqZvCm6VN9GSLJIS42U3uQlY7UJIWjFKexATC+tDZRG?=
 =?us-ascii?Q?NEqOIQzoJdRW7b5IUlyo256U+ODczXHJ6f9yxbq/0JVyEpJ/mH1rYeG/bvex?=
 =?us-ascii?Q?lIQuDSbymmzIJWVyE7O82GBRg0bHUf0EOzv4Nqh1To0i9+B7ZC8D7mOi0qL2?=
 =?us-ascii?Q?9MRk9F22AiyLjFoq2XV8VjCWZD8gKAYIGlypp58lnWIaLCLg8eObPDKNvhKm?=
 =?us-ascii?Q?PknNmQLWk3FyjufHZLVfEgVRnqOW9cEzj4GPmbdjt3S7Gisw57gpWmKmr/dr?=
 =?us-ascii?Q?pRIJ5PzDxZE3ThtBWX4rS0znQnO3WB67uTh1b61UHqSO1/mxIiPdI423xNh/?=
 =?us-ascii?Q?+c2b3C4aaQixAAsh3TrvKATLnTcOfKLMoI31jjImghAqxSZKQJGNtRITmMYI?=
 =?us-ascii?Q?eyOHbv8JGKK2kMzkCrt6HZpeS1w0UX6ja0hw8bD4kUvPr4SI+toUrE1/0i8A?=
 =?us-ascii?Q?Ev7kT8RvMFv3+ZYSqpMl+Gp3r7oV7/0p9otXQK8b90RIj4SvnJIBZ/zTZ4Db?=
 =?us-ascii?Q?yCU9LKPpcLC1NjiuhDtDn6P39qlluXhdllHSceztUsFjkvZlRylMmKDZK6fY?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4816b4ba-e3b9-45da-3c3a-08dd6c2f4b4d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 06:27:34.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiEodCd+0nUDzY1vJj31LlfpYTUMqr+aKhcSZQzvcsF5vCnydQCAdkU3p0gg8zE68DTtMkiKKqv0/cHWB+ECgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.462.fail" on:

commit: bde708f1a65d025c45575bfe1e7bf7bdf7e71e87 ("fs/dax: always remove DAX page-cache entries when breaking layouts")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: xfstests
version: xfstests-x86_64-8467552f-1_20241215
with following parameters:

	bp1_memmap: 4G!8G
	bp2_memmap: 4G!10G
	bp3_memmap: 4G!16G
	bp4_memmap: 4G!22G
	nr_pmem: 4
	fs: ext2
	test: generic-462



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503261308.e624272d-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250326/202503261308.e624272d-lkp@intel.com


2025-03-24 01:16:32 export TEST_DIR=/fs/pmem0
2025-03-24 01:16:32 export TEST_DEV=/dev/pmem0
2025-03-24 01:16:32 export FSTYP=ext2
2025-03-24 01:16:32 export SCRATCH_MNT=/fs/scratch
2025-03-24 01:16:32 mkdir /fs/scratch -p
2025-03-24 01:16:32 export SCRATCH_DEV=/dev/pmem3
2025-03-24 01:16:32 echo generic/462
2025-03-24 01:16:32 ./check -E tests/exclude/ext2 generic/462
FSTYP         -- ext2
PLATFORM      -- Linux/x86_64 lkp-skl-d01 6.14.0-rc6-00297-gbde708f1a65d #1 SMP PREEMPT_DYNAMIC Mon Mar 24 08:39:37 CST 2025
MKFS_OPTIONS  -- -F /dev/pmem3
MOUNT_OPTIONS -- -o acl,user_xattr /dev/pmem3 /fs/scratch

generic/462       _check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//generic/462.dmesg)

Ran: generic/462
Failures: generic/462
Failed 1 of 1 tests



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


