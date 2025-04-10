Return-Path: <linux-fsdevel+bounces-46159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F3EA83824
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 07:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E848A0384
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 05:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BB1F7092;
	Thu, 10 Apr 2025 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ii39sJqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377401C5D4B;
	Thu, 10 Apr 2025 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744262114; cv=fail; b=oPGlLfk1gzBSj/cbrc8vjRAY8F7YAYCG0ObwwxmZ9WQTh9SoDWTgUdiQnyIPqqOFdt3FAICQ4DL4JW6xNOV23GpdrLckDmNnwWf/ub/8ipfL6bqaKUMkv8m5xdoUbI4nUDPW/Lmvg6eqiHgi/e0mYevH0VM8K9XZd0EbNLWDs+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744262114; c=relaxed/simple;
	bh=FSYh4Kb9esbgOAwSSd94VZQizcxeg35jiihEv199H0w=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=fsJKX68jO9d7+V8HYxaxwe+npLvec7+RR7PcIyv3hojKat954qx2VVbI7BYpZyBPaKHdLVt/+Cvwom5/pBdqRowWEZKPoVS5Yv27n80jvg0ofCYp86wV5n4HyYJiDLel0vZzBnkZvJWDwXwLkvfNkLKf4BNSPjX8J7Bp9pbWMTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ii39sJqT; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744262112; x=1775798112;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=FSYh4Kb9esbgOAwSSd94VZQizcxeg35jiihEv199H0w=;
  b=Ii39sJqTsdMUpwpCcjD6JfGBrux1BlkSLd3zTA7eTExVeE5tSDMft0Bh
   y9yykAKDaQIhXlRcZpsziCJ4NbnB/OUi9o2UYLhw/mlOXgcjdEyRRy9mN
   jS58ZQ0jjssv+2b4Q59xjlE+0oJ3yAO1BZHLl6JNN2v+2c3K9NAaG4KGl
   jTvO6n6Mychpjc95FLTJilshErt12FViZusNMoR42uG6DS36LhxqLW8/U
   pbKIbIpzN/D+O9TFuhrURvVavOtq8XBxrJgHeBHc9JW6iU77ei2rl3pOD
   ukLGE6TfXvi8aKuk45PFbQpSBzg3CPqpOS1/WniPJCjy049mRYcQyIjIl
   Q==;
X-CSE-ConnectionGUID: 9BOPgiMOTsiwzAt9BvFzbA==
X-CSE-MsgGUID: XN6sT2FHRk6nCHK/WXgH1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56401424"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56401424"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:15:11 -0700
X-CSE-ConnectionGUID: ++9NzUysREKzcK507WuoAQ==
X-CSE-MsgGUID: kZ15x0sBROynq+PNr1rV5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129624644"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:15:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 22:15:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 22:15:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 22:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gb1c/ktBsNOdWXKvTtuF5k8I7VbSh5NwcnfxCpj3TIQyzMvycIQymWAxN4pF67efHriIgglEaLuu2pajHW88OwfTL1TuAn6XBmektWGnicaPpjbTnUt0q7eHyN1BM2BMrMfHQFG6DF7bpBsFMxkGsSCz9RblvFE1XmdbmBJ7Gg+7NPDsH7v3gMDy8ZrVQNGAjX/ZxQ5+QjYmlYql+x6HmZrZyjEpbHgc3C5bwLKAqJtGgt2okkjcHmCX9crBP+SD781RZW/EE3K4LbJ1lL3qliJLHweyGfAhaMXmGJkC8m7WmAH3SsoqbmdfWjZr0RuSE6xdEUPizIAh5LOHG3Ak6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Msgqn5MS68pHKZ0ZkDt2ghDH9VgeFBZKJzPWrNWzpr8=;
 b=VPTQpDohCrbgcmGIru+y90qEPtWylMv/22CuPxNI8b/LsWz2pX2eGE4lRH7cSoC6+R1eEbD94zx8ZZGpPbilGVVuGVvIadJWTiBpO2/v2kqNgi1SJdqs6eesZt0B+IYLkw+QXYFhsRChKu6SchjaY+v2OFEs5Z/4r02XpLRh80w/zorH7tKDTufVnpGODVYSkD8+TXvJ/TxvXtvlO5Jm6dJtkB/0ByMUbOdrTtIeHSgXPfsYQlhJ/8pRvsIHhkDycWyPTaPAEGl6KT4OM/IfWnBTAMq0zeup5INAI3CYaQXnIJqY077qv2tLjGYZJbEakxetyBzYBUwtwohWSHoxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8162.namprd11.prod.outlook.com (2603:10b6:8:166::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 05:15:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 05:15:01 +0000
Date: Thu, 10 Apr 2025 13:14:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alistair Popple <apopple@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Asahi Lina <lina@asahilina.net>,
	Balbir Singh <balbirs@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Chunyan Zhang
	<zhang.lyra@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner
	<david@fromorbit.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang
	<dave.jiang@intel.com>, David Hildenbrand <david@redhat.com>, Gerald Schaefer
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
Subject: [linus:master] [fs/dax]  bde708f1a6:
 WARNING:at_mm/truncate.c:#truncate_folio_batch_exceptionals
Message-ID: <202504101036.390f29a5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: df34b696-ea22-47f4-b21c-08dd77eea52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MLrSsmsiDOqnYfm/HAvhIU5kBSwcAdq0S2HCgO1tCBhiLW8srwF7WVByJGqd?=
 =?us-ascii?Q?/axGXmjsoYXTxoruItAxnroI6B94nabW7C9Qgq9TdDqorLcItq6+0wJMAs6Q?=
 =?us-ascii?Q?Dsvbv3j/gqaXrbO1V859NS25t254Tt0HFiGjvGTowMr3sBfE0MbORJ91B+sy?=
 =?us-ascii?Q?W0yHC4iQKk03d5ztvVTpL3z0rpEBWJepBCQ2EwNJV+4xcmrtPKEtGyAGjwQm?=
 =?us-ascii?Q?an/KJNgrnrSZNRDLou9g+KbGJW6Y2St9pjLYtVSqK2xIsfIIFQDyqfjyCO8Z?=
 =?us-ascii?Q?LbAqQbu6Eplas3EvHLoXq763AovAB95i1nNKWMCYzptyjXzOgxmAZRKUjtz9?=
 =?us-ascii?Q?AdOMlIi59gmsbxmlAUbjZIBknmcw8XV6UEJi3dgb5r7363oA+NQIyqMrkbbv?=
 =?us-ascii?Q?MJSj3dX1mqOyWYQcXYAcB5Pw1Ul8/KxdXtckTIYGaq8tPMB481ZsDd9jpl+v?=
 =?us-ascii?Q?gJb5XZ/kHeT1bfdsHQjLu6IBHIob8qTj9sqGJKPGjQtnrq9ssWI+vXGgrQnK?=
 =?us-ascii?Q?eBTYlItjonKeqqZNHy8IFB3nXfDtlGl0eiJZSMmoniXVSTVu9039BOEhstBP?=
 =?us-ascii?Q?h3/CJMKKE0YEr1e3fyx00BiSNp8nW8wNGXCL0rMsKQPI5RyT9u81sQD7QtJY?=
 =?us-ascii?Q?QOwcNdrQfUwj50o4Sh3jHMzwf6wACnZCXV/cPS150ZkLeRuczqHmwn9PlQa5?=
 =?us-ascii?Q?Ze3no6uRZTFN5SV4QLR66UZsovqCfrYPAU/xHEG/hz/qaav1QdlGj1+lAueG?=
 =?us-ascii?Q?hkCNUVoLrckIabXtrJql14jPAZ55ORd7ntsTGXsVP+sARU36Wurx0v/54B8d?=
 =?us-ascii?Q?q2BE3n6yQruJ0JqwaYp1/wWC0xEJ2iNfFZ5retgiuAop/anP4e2b9nLRUSR1?=
 =?us-ascii?Q?KWqPrO1UhWPIafjbSHb/BbfaIlTNJ9wiTvPnw3iKHj+w8RgDTXSX4/C2pR4/?=
 =?us-ascii?Q?R0zbP/vVYgrXz3YZracwdF7fSSJLfFVLOG7Pumj6DaYU6cV2R/4zSjXgHkDO?=
 =?us-ascii?Q?Rkxt0gB+fVcqnbOH8yUy5I1POh4XzhgCUEV7YVKqSkU2H8gSqMBfWNNTliiD?=
 =?us-ascii?Q?od09vfekJbyhLahl0k4HD2vN/dJ1a33O72fACTSgRZUTlQM4nwwhiEHU5Wvz?=
 =?us-ascii?Q?0jV5MtGw1dsLomJ105OjmunMg0P4oD8ZPQbwpD66ib6SN19AwZKLJtJTwns0?=
 =?us-ascii?Q?9LQotzm+0jks2EiE3IXsZcLMH8hvA1Tthl8FO+5F8guxpoI6jZ8InIqNwQ31?=
 =?us-ascii?Q?PS4hlVzyHIB2Skjyk91U5J0QTMAbU30Xm8wBHizGxqlUIuagiZBJMT6TXHGF?=
 =?us-ascii?Q?3ZBoRt6cTDEbjpjvlppW9Xjux78n+jGbtSt8qvJ5aWgV15mX2pZsyn0u7rEb?=
 =?us-ascii?Q?iR+znFLLBnIgtGdunR22ZSDWgDi6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFzq5q7zFTwfR0H/Z5aInfNl9duI5g5bo09edoUNlToE4Zw2HwthdBeNlcUg?=
 =?us-ascii?Q?LgzQ5PoiHb057jy4TTd8F9+/MsMGk6w4Hnznw+v4AFos7OvcxOrFM47Sx0za?=
 =?us-ascii?Q?1bJcoSuBG82oRxP+pPHX9br+mMCcDjhk/uCwOMFXxKMKjKiI3I5hMmPRo2F+?=
 =?us-ascii?Q?lUOu/D5lYMwMjEQoZNroSN56lN1lGWIZMFXXRw5wQoOSzN3uxqdaP5GGgS4B?=
 =?us-ascii?Q?ukbiZwih+brq+MLWQcgE5Xb1naUZuUOM4s7qte+atl0c0fMQvubjp13nMdp9?=
 =?us-ascii?Q?T/iIu1LE8DbiiJGuiCkmMQoiM/rBofljKi+NLGbIb6M4FUEcjQDe7n4xZjbI?=
 =?us-ascii?Q?s0Vi6ucCe8hyKntHkxZk6mnGFyovSbUDzjHxdRazDkVtdDznvPyNbrKRLD9F?=
 =?us-ascii?Q?uvWFigmkZqyISEnpxfB8HpJYfQf0PvQ0aeUoEytHOCCiu9cIAHhcpd87WnPl?=
 =?us-ascii?Q?bNo2r1QK39WlrRWQm0DOBUXLhnkRUKt4eJWCByNlcjdKu06CG5fghqY0VRQq?=
 =?us-ascii?Q?BRq+LRB2oT41dSfFaKgNY0VKE65cAEc0ovsRBGE2OfH08FnWIK6qdeHUsFJd?=
 =?us-ascii?Q?W0BZtTgsGvzUQcuLCwE/o9Ym7KCMzuujJN0S6CIuB/noaCRF3nrvTVHFJGR/?=
 =?us-ascii?Q?GPUedlB4AsDWLGX2ePkCOPr4Ccf37C6J5Osh6A3Z4RAJHsBvHnUZ+cZdMgby?=
 =?us-ascii?Q?zJpp7DdRTmKrtjHuNWUt83qA33PGA4y8EUNQle+9t1DEi/vPM5jxbcGWs/eY?=
 =?us-ascii?Q?6pgKfghBhTnWn/luozalXj5TKjVJ6Tt+UDVLH/R0hgXd8mzULqopQXeWYQT/?=
 =?us-ascii?Q?9XqynqE+FdbIC0YB+mqCZjDq4djW5XhZJ1IeoILAW+utrVMpjjQjZLjoUDdQ?=
 =?us-ascii?Q?vFiIjvvzFtGIFbfm8dW7OR5W9K90jvgeS5oSnIKzWXjm1JAIQTJ3XsjSyZYs?=
 =?us-ascii?Q?EIBlGAQFvyaShkCj3Bf3npTSURrVtqUJORvxtP3hlK7rOdilXzxfcA/TSKAY?=
 =?us-ascii?Q?P5pVr1UR4ZijPrX/+qBdNpMQD8QJOwXGQTvX8Ce4YAClNiFqUe/sEnS65NIP?=
 =?us-ascii?Q?UEdzqDj/oUI8/VytnU8nMDFFM/XCl0idKXB5TYzQyTo/yTkJW/BuUQIOvF1a?=
 =?us-ascii?Q?Q/CKSRURVIqcl0QVh5w4ed/bjr8BNxfWsfZXPMiZVPlBv0yALN+S1crr0O++?=
 =?us-ascii?Q?1uxoMtc+B5nAHMOAxouFC6EEdpg6hDE30je1YfmWhFl+rMO31Mrgu/xKqqtC?=
 =?us-ascii?Q?hSIkejvHSFMwVs5wjwodB3QsuWf6vemYcRSYP6+rtV0JIB5J2j3YnqCYmoCD?=
 =?us-ascii?Q?4eRZ95EdJCys1zseZFPrqCQndNCcVPXtk8mwgARnk9q7lwcVT9w8uRCX94Z0?=
 =?us-ascii?Q?83we9twzCjZReCBhA8jpKMRvJR/LmvQlt1ieELqFLFV1nyl6H2M/mJtjf4hp?=
 =?us-ascii?Q?S/9TEtMvPhE/QJksiAtCg0JUpkdjiUnwoW6AFqkr5SQeumEfu8UeMwO3gfa9?=
 =?us-ascii?Q?by5HAVnd5iYD6YjRftvQV7yftGdCs6/m4tuv2W/SgQKiSct3MEpkpmpZbITn?=
 =?us-ascii?Q?RwIZN7GKRcxC/p5RV4/dPYDdqjlCR3rn9C3bfYrjnDF4aFVybahZOUM+kIaU?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df34b696-ea22-47f4-b21c-08dd77eea52a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 05:15:01.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOvYh5OqCscrqGMWCcZEMEYqFm6N1j1dLduEXmxwf9s6kdboHho/sZjQIJ4HXlZC1S4vJ/qCOf2C6mnbSSij2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8162
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/truncate.c:#truncate_folio_batch_e=
xceptionals" on:

commit: bde708f1a65d025c45575bfe1e7bf7bdf7e71e87 ("fs/dax: always remove DA=
X page-cache entries when breaking layouts")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: xfstests
version: xfstests-x86_64-8467552f-1_20241215
with following parameters:

	bp1_memmap: 4G!8G
	bp2_memmap: 4G!10G
	bp3_memmap: 4G!16G
	bp4_memmap: 4G!22G
	nr_pmem: 4
	fs: ext2
	test: generic-dax



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) w=
ith 28G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504101036.390f29a5-lkp@intel.co=
m


[   46.394237][ T4025] ------------[ cut here ]------------
[ 46.399593][ T4025] WARNING: CPU: 7 PID: 4025 at mm/truncate.c:89 truncate=
_folio_batch_exceptionals (mm/truncate.c:89 (discriminator 1))=20
[   46.409748][ T4025] Modules linked in: ext2 snd_hda_codec_hdmi snd_ctl_l=
ed snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component int=
el_rapl_msr btrfs intel_rapl_common blake2b_generic xor ipmi_devintf zstd_c=
ompress ipmi_msghandler x86_pkg_temp_thermal snd_soc_avs intel_powerclamp r=
aid6_pq snd_soc_hda_codec snd_hda_ext_core coretemp snd_soc_core snd_compre=
ss kvm_intel i915 sd_mod snd_hda_intel kvm snd_intel_dspcfg sg snd_intel_sd=
w_acpi intel_gtt snd_hda_codec cec dell_pc platform_profile drm_buddy ghash=
_clmulni_intel snd_hda_core sha512_ssse3 dell_wmi ttm sha256_ssse3 snd_hwde=
p nd_pmem sha1_ssse3 dell_smbios drm_display_helper nd_btt snd_pcm dax_pmem=
 mei_wdt rapl drm_kms_helper ahci mei_me snd_timer libahci rfkill nd_e820 i=
ntel_cstate sparse_keymap video wmi_bmof dcdbas dell_wmi_descriptor libnvdi=
mm libata pcspkr intel_uncore i2c_i801 snd mei i2c_smbus soundcore intel_pc=
h_thermal intel_pmc_core intel_vsec wmi pmt_telemetry acpi_pad pmt_class bi=
nfmt_misc fuse loop drm dm_mod ip_tables
[   46.498759][ T4025] CPU: 7 UID: 0 PID: 4025 Comm: umount Not tainted 6.1=
4.0-rc6-00297-gbde708f1a65d #1
[   46.508156][ T4025] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS =
1.2.8 01/26/2016
[ 46.516324][ T4025] RIP: 0010:truncate_folio_batch_exceptionals (mm/trunca=
te.c:89 (discriminator 1))=20
[ 46.523347][ T4025] Code: 84 70 ff ff ff 4d 63 fd 49 83 ff 1e 0f 87 d4 01 =
00 00 4c 89 f0 48 c1 e8 03 42 80 3c 00 00 0f 85 9b 01 00 00 41 f6 06 01 74 =
c6 <0f> 0b 48 89 c8 48 c1 e8 03 42 80 3c 00 00 0f 85 d6 01 00 00 48 8b
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	84 70 ff             	test   %dh,-0x1(%rax)
   3:	ff                   	(bad)
   4:	ff 4d 63             	decl   0x63(%rbp)
   7:	fd                   	std
   8:	49 83 ff 1e          	cmp    $0x1e,%r15
   c:	0f 87 d4 01 00 00    	ja     0x1e6
  12:	4c 89 f0             	mov    %r14,%rax
  15:	48 c1 e8 03          	shr    $0x3,%rax
  19:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1)
  1e:	0f 85 9b 01 00 00    	jne    0x1bf
  24:	41 f6 06 01          	testb  $0x1,(%r14)
  28:	74 c6                	je     0xfffffffffffffff0
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 89 c8             	mov    %rcx,%rax
  2f:	48 c1 e8 03          	shr    $0x3,%rax
  33:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1)
  38:	0f 85 d6 01 00 00    	jne    0x214
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	48 89 c8             	mov    %rcx,%rax
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1)
   e:	0f 85 d6 01 00 00    	jne    0x1ea
  14:	48                   	rex.W
  15:	8b                   	.byte 0x8b
[   46.542938][ T4025] RSP: 0018:ffffc9000d74f370 EFLAGS: 00010202
[   46.548900][ T4025] RAX: 1ffff92001ae9ec8 RBX: ffff8881e2d959d8 RCX: fff=
fc9000d74f4f8
[   46.556787][ T4025] RDX: 0000000000000001 RSI: ffffc9000d74f638 RDI: fff=
f8881e2d95874
[   46.564676][ T4025] RBP: 1ffff92001ae9e74 R08: dffffc0000000000 R09: fff=
ff52001ae9eec
[   46.572557][ T4025] R10: 0000000000000003 R11: 1ffff110d4bf8d9c R12: fff=
fc9000d74f638
[   46.580439][ T4025] R13: 0000000000000000 R14: ffffc9000d74f640 R15: 000=
0000000000000
[   46.588319][ T4025] FS:  00007fe696f3a840(0000) GS:ffff8886a5f80000(0000=
) knlGS:0000000000000000
[   46.597163][ T4025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.603691][ T4025] CR2: 00007fff266c5ec0 CR3: 00000001ead7e002 CR4: 000=
00000003726f0
[   46.611586][ T4025] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   46.619468][ T4025] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   46.627353][ T4025] Call Trace:
[   46.630520][ T4025]  <TASK>
[ 46.633337][ T4025] ? __warn (kernel/panic.c:748)=20
[ 46.637296][ T4025] ? truncate_folio_batch_exceptionals (mm/truncate.c:89 =
(discriminator 1))=20
[ 46.643697][ T4025] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[ 46.648091][ T4025] ? handle_bug (arch/x86/kernel/traps.c:285)=20
[ 46.652322][ T4025] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discrim=
inator 1))=20
[ 46.656905][ T4025] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:=
574)=20
[ 46.661838][ T4025] ? truncate_folio_batch_exceptionals (mm/truncate.c:89 =
(discriminator 1))=20
[ 46.668239][ T4025] ? __kernel_text_address (kernel/extable.c:79)=20
[ 46.673356][ T4025] ? __pfx_truncate_folio_batch_exceptionals (mm/truncate=
.c:62)=20
[ 46.680123][ T4025] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)=20
[ 46.684782][ T4025] truncate_inode_pages_range (mm/truncate.c:339)=20
[ 46.690407][ T4025] ? __pfx_truncate_inode_pages_range (mm/truncate.c:304)=
=20
[ 46.696546][ T4025] ? __pfx_i_callback (fs/inode.c:322)=20
[ 46.701292][ T4025] ? kasan_save_stack (mm/kasan/common.c:49)=20
[ 46.706032][ T4025] ? kasan_record_aux_stack (mm/kasan/generic.c:548)=20
[ 46.711298][ T4025] ? __call_rcu_common+0xc3/0x9e0=20
[ 46.717279][ T4025] ? evict (fs/inode.c:772 (discriminator 2))=20
[ 46.721236][ T4025] ? dispose_list (fs/inode.c:846)=20
[ 46.725751][ T4025] ? evict_inodes (fs/inode.c:860)=20
[ 46.730339][ T4025] ? generic_shutdown_super (fs/super.c:633)=20
[ 46.735699][ T4025] ? kill_block_super (fs/super.c:1711)=20
[ 46.740447][ T4025] ? deactivate_locked_super (fs/super.c:473)=20
[ 46.745905][ T4025] ? cleanup_mnt (fs/namespace.c:281 fs/namespace.c:1414)=
=20
[ 46.750400][ T4025] ? task_work_run (kernel/task_work.c:227 (discriminator=
 1))=20
[ 46.755076][ T4025] ? syscall_exit_to_user_mode (include/linux/resume_user=
_mode.h:50 kernel/entry/common.c:114 include/linux/entry-common.h:329 kerne=
l/entry/common.c:207 kernel/entry/common.c:218)=20
[ 46.760796][ T4025] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
[ 46.765381][ T4025] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry=
_64.S:130)=20
[ 46.771363][ T4025] ? blk_finish_plug (block/blk-core.c:1241 block/blk-cor=
e.c:1237)=20
[ 46.776026][ T4025] ? blkdev_writepages (block/fops.c:453)=20
[ 46.780864][ T4025] ? __pfx_blkdev_writepages (block/fops.c:453)=20
[ 46.786241][ T4025] ? __blk_flush_plug (include/linux/blk-mq.h:234 block/b=
lk-core.c:1220)=20
[ 46.791152][ T4025] ? xas_find_marked (lib/xarray.c:1382)=20
[ 46.795990][ T4025] ? __pfx_inode_free_by_rcu (security/security.c:1708)=20
[ 46.801351][ T4025] ? rcu_segcblist_enqueue (arch/x86/include/asm/atomic64=
_64.h:25 include/linux/atomic/atomic-arch-fallback.h:2672 include/linux/ato=
mic/atomic-long.h:121 include/linux/atomic/atomic-instrumented.h:3261 kerne=
l/rcu/rcu_segcblist.c:214 kernel/rcu/rcu_segcblist.c:231 kernel/rcu/rcu_seg=
cblist.c:332)=20
[ 46.806537][ T4025] ? fsnotify_grab_connector (fs/notify/mark.c:702)=20
[ 46.811898][ T4025] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 in=
clude/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-=
instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinl=
ock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:15=
4)=20
[ 46.816473][ T4025] ? inode_wait_for_writeback (arch/x86/include/asm/atomi=
c.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic=
/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 fs/fs-writebac=
k.c:1541)=20
[ 46.822012][ T4025] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:10=
7 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/ato=
mic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/s=
pinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.=
c:170)=20
[   46.824528][  T331] LKP: stdout: 302: HOSTNAME lkp-skl-d01, MAC f4:8e:38=
:7c:5b:de, kernel 6.14.0-rc6-00297-gbde708f1a65d 1
[ 46.826917][ T4025] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:=
169)=20
[   46.826949][  T331]
[ 46.838033][ T4025] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 in=
clude/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-=
instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinl=
ock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:15=
4)=20
[ 46.838054][ T4025] ext2_evict_inode (fs/ext2/inode.c:99) ext2=20
[   46.847318][  T333] 262144 bytes (262 kB, 256 KiB) copied, 0.0043872 s, =
59.8 MB/s
[ 46.850251][ T4025] evict (fs/inode.c:796)=20
[   46.855527][  T333]
[ 46.863038][ T4025] ? __pfx_evict (fs/inode.c:772)=20
[ 46.863056][ T4025] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 in=
clude/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-=
instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinl=
ock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:15=
4)=20
[   46.867191][  T333] 512+0 records in
[ 46.869033][ T4025] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)=
=20
[   46.873347][  T333]
[ 46.877892][ T4025] dispose_list (fs/inode.c:846)=20
[   46.881842][  T333] 512+0 records out
[ 46.886610][ T4025] evict_inodes (fs/inode.c:860)=20
[   46.888832][  T333]
[ 46.893113][ T4025] ? __pfx_evict_inodes (fs/inode.c:860)=20
[ 46.893135][ T4025] ? filemap_check_errors (arch/x86/include/asm/bitops.h:=
206 (discriminator 6) arch/x86/include/asm/bitops.h:238 (discriminator 6) i=
nclude/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 6) m=
m/filemap.c:349 (discriminator 6))=20
[ 46.913439][ T4025] generic_shutdown_super (fs/super.c:633)=20
[ 46.918627][ T4025] kill_block_super (fs/super.c:1711)=20
[ 46.923204][ T4025] deactivate_locked_super (fs/super.c:473)=20
[ 46.928477][ T4025] cleanup_mnt (fs/namespace.c:281 fs/namespace.c:1414)=20
[ 46.932792][ T4025] task_work_run (kernel/task_work.c:227 (discriminator 1=
))=20
[ 46.937282][ T4025] ? __pfx_task_work_run (kernel/task_work.c:195)=20
[ 46.942292][ T4025] ? __x64_sys_umount (fs/namespace.c:2074 fs/namespace.c=
:2079 fs/namespace.c:2077 fs/namespace.c:2077)=20
[ 46.947218][ T4025] ? __pfx___x64_sys_umount (fs/namespace.c:2077)=20
[ 46.952480][ T4025] ? vfs_fstatat (fs/stat.c:372)=20
[ 46.956809][ T4025] syscall_exit_to_user_mode (include/linux/resume_user_m=
ode.h:50 kernel/entry/common.c:114 include/linux/entry-common.h:329 kernel/=
entry/common.c:207 kernel/entry/common.c:218)=20
[ 46.962348][ T4025] do_syscall_64 (arch/x86/entry/common.c:102)=20
[ 46.966749][ T4025] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqf=
lags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:2=
32 kernel/entry/common.c:206 kernel/entry/common.c:218)=20
[ 46.972284][ T4025] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqf=
lags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:2=
32 kernel/entry/common.c:206 kernel/entry/common.c:218)=20
[ 46.977832][ T4025] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqf=
lags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:2=
32 kernel/entry/common.c:206 kernel/entry/common.c:218)=20
[ 46.983369][ T4025] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
[ 46.987953][ T4025] ? check_heap_object (mm/usercopy.c:189)=20
[ 46.992887][ T4025] ? kasan_save_track (arch/x86/include/asm/current.h:49 =
mm/kasan/common.c:60 mm/kasan/common.c:69)=20
[ 46.997649][ T4025] ? kmem_cache_free (mm/slub.c:4622 mm/slub.c:4724)=20
[   47.000912][  T333] 262144 bytes (262 kB, 256 KiB) copied, 0.00767215 s,=
 34.2 MB/s
[ 47.002474][ T4025] ? vfs_fstatat (fs/stat.c:372)=20
[   47.002504][  T333]
[ 47.010137][ T4025] ? vfs_fstatat (fs/stat.c:372)=20
[   47.014750][  T333] 512+0 records in
[ 47.016647][ T4025] ? __do_sys_newfstatat (fs/stat.c:533)=20
[ 47.016665][ T4025] ? __pfx___do_sys_newfstatat (fs/stat.c:528)=20
[   47.020981][  T333]
[ 47.024567][ T4025] ? __count_memcg_events (mm/memcontrol.c:583 mm/memcont=
rol.c:859)=20
[ 47.024588][ T4025] ? handle_mm_fault (mm/memory.c:6102 mm/memory.c:6255)=
=20
[ 47.024593][ T4025] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqf=
lags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:2=
32 kernel/entry/common.c:206 kernel/entry/common.c:218)=20
[   47.029926][  T333] 512+0 records out
[ 47.035106][ T4025] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
[ 47.035129][ T4025] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 a=
rch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1488 arch/x86/mm/faul=
t.c:1538)=20
[   47.037332][  T333]
[ 47.042576][ T4025] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_6=
4.S:130)=20
[   47.042596][ T4025] RIP: 0033:0x7fe697166af7
[   47.048552][  T333] 262144 bytes (262 kB, 256 KiB) copied, 0.00560232 s,=
 46.8 MB/s
[ 47.052938][ T4025] Code: 0f 93 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f =
44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 d9 92 0c 00 f7 d8 64 89 02 b8
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 93 0c 00          	setae  (%rax,%rax,1)
   4:	f7 d8                	neg    %eax
   6:	64 89 01             	mov    %eax,%fs:(%rcx)
   9:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
   d:	c3                   	ret


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250410/202504101036.390f29a5-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


