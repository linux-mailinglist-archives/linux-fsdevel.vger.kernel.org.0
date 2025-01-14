Return-Path: <linux-fsdevel+bounces-39112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C2A0FF8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 04:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C107169851
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 03:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F35233D93;
	Tue, 14 Jan 2025 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBKJuGhg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C123026F;
	Tue, 14 Jan 2025 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825721; cv=fail; b=NjOywKuX6WzQhDmfYeYgV4eppjTuNL2TOahmEula1zggZLhJkiQb1FoaBRaN7EbsIEhdSEYhe+3PZ3bm5kqJFNvY00c2O3T2PWlHtj0mF9f8feG5y7+GKZgKR6xeKtrju+en1CAts4c8HZAU6QNQnn5pxqhVGVYecmJlNiOsahQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825721; c=relaxed/simple;
	bh=9mjNXdtojVKAdRSNBxM9/SK6edWCKbvfiqdwQohIrcg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rJLT8Gv2E9epJXFXBYZqwBrxB6w6v460lYX2Sq0L81hUrqjXGZS1vLvuiaQeO2N0E1rPaZtZYaT4igLB2LP5QKd99X8WE5Q0epj/jpU0KZG6CDjs08dE/hQ5PXWl4rDJV1XNTCwdaYJ+YJng2eWC1OIS5sdjK0nM0prgAa1REts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBKJuGhg; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736825719; x=1768361719;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9mjNXdtojVKAdRSNBxM9/SK6edWCKbvfiqdwQohIrcg=;
  b=jBKJuGhgXykBzCiER18KVoqzqa3Zluoy4DuJtBmj6YiS1T7s2DZ2/5mU
   20uD9Ky8UWMTqJOHahm7hlNnb5Kn3vnsEoY4aQgH/Q5uWs5wC3Fg9pPTM
   MaHE2Dwe9zjhqCWQDKykGiObKdjumgNZop6FXrt+3oBAWimbiDpHAA1kL
   l3AkhHeXxz0r1UFbQCjYQflOvKYw3Ij6FNdoLL7otWUqGhAzX1mTH61U/
   b251W+PZEFQC9GO4OoM/AwOxObiHeRk8A0HXlcU6r0BJHi2MGBzRJqnR/
   Im+0I5gPnK/YuLZ0qLx/+BhkfJmY49IbjM+HDXIvziFNWpHtOK78A9LAj
   w==;
X-CSE-ConnectionGUID: Jo2oyTieSTa2pU2WHESdgA==
X-CSE-MsgGUID: 56pdVcIIQQyvfsqN73WMhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48492407"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="48492407"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 19:35:17 -0800
X-CSE-ConnectionGUID: hEOPKjNuQpC/XVeMBOuQdQ==
X-CSE-MsgGUID: 4+WW7aOxSNy4dDRqGChGcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108741792"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 19:35:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 19:35:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 19:35:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 19:35:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC+C9PETVfYRymX2wISgTm0T3hf3c453yUc+pvNEz3qqi/hz4Z+qlY3ulLuVL/AG3ceuwUiepuxvzL5ndVtbefliRTG8zt2ci10VcMZ/NdeKPKP7gR61mpUjc/T1ODzLQPdfqI4WBlR2Mc98tETAjaY5N3FYiPnEUT244M5FPGkFspAJVy3fHEWAv4xCaf2+rhd2J5fvcretoAH/rdBYSoa/1PlGJXvce9/za/3qqhw4KBCkMRadmFypJd7GzKgWb4OZJFk+bMFehQdglMzt1VdFyC/JKbPy4zwxDsxeQ/EucEn8BR0ajICisBfH1A963n6u4TXwtN0w0qnb8Ky8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95vIoAOe8CqoA5XjEcq8FJSjEz+YWO5Ah2XeYvJPaZw=;
 b=E+3gijDKD3TnW3vL8YquzntUyOC9V7eQaf9SRNJfi3SbKQ0irO8XdNFnoWGeUl+Sve5FwIj42OypjXdDOyvTN62PFOsdaTxnric2UZHj/1/qvvnv7G3gQVPLoLfpfQFDAzJyQJGbN8i64DSe4gMCD7jOcW1pH1/8IPRw/nfyuBK9zhTlsaARnqCh5yePiINYlxXeaTgA84J+BSW8hhLzbRNjYJo0AcEaNrIMONSoWQBHClwRk9WvJ2NDCxvNY8ay+d7wcQkmTGDjigv18HLhN9e7bEIdKHY4W6Jlb4ysHy9YXx5G5iKiZrX9NyjJyxjzA2rcv0rcouf7uXcsRk04tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 03:35:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 03:35:12 +0000
Date: Mon, 13 Jan 2025 19:35:07 -0800
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
Subject: Re: [PATCH v6 21/26] fs/dax: Properly refcount fs dax pages
Message-ID: <6785db6bdd17d_20fa294fc@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <b2175bb80d5be44032da2e2944403d97b48e2985.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b2175bb80d5be44032da2e2944403d97b48e2985.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0254.namprd04.prod.outlook.com
 (2603:10b6:303:88::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: f31e6fe1-5db3-4151-79e4-08dd344c73c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OF0+EUQ7qfNiXiDxdjSyMcMOWPJ/94jyn1nNB3VHESTBbyUX8blO+QuChm8z?=
 =?us-ascii?Q?lqer5wUa0JQgI1tON16XyrPPe7AakdBMjFF5p/P80O7rIJ49YacQT/Wk3cKG?=
 =?us-ascii?Q?JUbPa5KnezDpzSztTnF4ks0uwHFtGxc6bqEWiWTsgLmX+/Ml3e8kDWfA+YJq?=
 =?us-ascii?Q?eXp2DXJ2yWSOUtM9R5SgqK+oXLvw9/22xh05GLGXAv9eAwAS+f5/P8Cg+DiQ?=
 =?us-ascii?Q?0RsTkm0zLRwAPX7tbLO9nE/YThaHb/IMz+neqDRPEA1AWJzzpUoCk/7/WzJb?=
 =?us-ascii?Q?hhRpnES8nOjlXQbJC167n0Wvy2eqWuKoQ1offNnrB8fy1KsxQOnu0VcB/Cxo?=
 =?us-ascii?Q?Fdi+qVZowB4bNIHJH7jmx+JJjBTG8hC7xmKh8PrRYkrpIxI1q24yrLEvpjHY?=
 =?us-ascii?Q?5BYc1WzdRs+uoqqgW9cmyo6WJgm11+xVkFi+sPUL/fZzevPPjwi2XLhFk4V5?=
 =?us-ascii?Q?CMYqYoO9s4mhdombjWPETldnQeywixDQ7pxUXMgcbE1ol+5wr1ks4xqzsvTe?=
 =?us-ascii?Q?yEa8btfUP+y2xMQKaOz3feJUu1SDNBn1tChg/ZVv3zRwSiUSYDSx0BKnNDdF?=
 =?us-ascii?Q?r5agh6g5ylxnfG4gZ1nse9nry9MoreC5MGCJvDKm2sQpbbbyO+0ps7IRAFc9?=
 =?us-ascii?Q?tiF9cYKrA4SzGuEFL4C5TV4vM4SnOGbFrNWpYuM/oq7l70+wOq1siWIhZH3K?=
 =?us-ascii?Q?pPy/OykaqdgwOVRNgoEmhcDI7m5luCiZHMgZlBL4FBWuFtTFLGJUXgCONr1a?=
 =?us-ascii?Q?FXZwDAPxEKoMedwE54NVVOf3QwUzSf/nHjN+UBGYCoefQZThM2w9+vWt2wV4?=
 =?us-ascii?Q?RlAlelZekPFoWb5eHLijnc9iC+9Gyy6Gev/quff5PvoGqbEMrOcjoRWP+svA?=
 =?us-ascii?Q?2fRsfuJo6G3FpA9O1orPJmIcY3f/b5FHUmAbob+ss7gXCzbi6NiyeUCtEgUs?=
 =?us-ascii?Q?tTqCCLkAgHD+qGiHtfrumN24cXkhI/cYF175cps9gfakki7N6JTECiCx/p5V?=
 =?us-ascii?Q?d3GMsGxkmb290zYK2iir6hfaOIlVykOyL1i74C6Yz43DN1qa8CjS84+wnWqD?=
 =?us-ascii?Q?P6a0iHAP1NoEg18jv6saMHqJw/SUQxn6KBB4qKmFrJfH6sD3FAfYPZkZMAF4?=
 =?us-ascii?Q?haeUPUYePU0cEcKUaXMyZ0E2z8a9U1PHTLRegZzkU5b2aRE8y+agDpVvAzRd?=
 =?us-ascii?Q?bbeRGBXpoHnHJeU4DyEw6EL/9pyXoXfAfGuzLelInHEyMojso1jpOvtX+IpN?=
 =?us-ascii?Q?eK78LQTVDfhqSrVCYhtxZratBG4bzyoMFT2fgAarhvriSy1grJTe4SaDdUlO?=
 =?us-ascii?Q?+wkVac5osJqaMcusOl5fPWDRRIYaY9dy2q6M3f3A1VUyWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fTCPyxX9nidZPQia9egsCsAW7hBjRUv+kDFBnAE7Tyy/Q3+Q+YhwZB0634lR?=
 =?us-ascii?Q?BlqvLFjgwDHay+eAPKA5xQyKm5RL44F3cCjuy2z1UP5xAFT0NK059pDgRmfy?=
 =?us-ascii?Q?OFQYGJPVeUE9dnn4oVYtPZLU+5ZVSkOzixgcFGYFXSai70IVZBab7kkF0ZK8?=
 =?us-ascii?Q?XiM01B623yd6Wya7F6z9+jJhImsuLtW+CPqI3iBKHC3ep4Y9aNv11jd1gBIU?=
 =?us-ascii?Q?bhEQZRfWs+j1EpRXr/h0ltQAYNaAuDFUPGLIKn1L/ML1isycel9kjwgT8Wop?=
 =?us-ascii?Q?HLfNVKwS5px1lTHzOigKjOlT9MwwWZi6rlQVPhGTO9zo3o8GMgHi0gQe5C6a?=
 =?us-ascii?Q?90YpgoC6Xh8o5YKUJZxJOB9WvBrnlCXM5QP3DJvKeqXd4f4nVLOu5QF3Qdc8?=
 =?us-ascii?Q?idJCxlVhkxIqZ0xlP4VYAr5M/GXO/mxQEt9HV4bXqyzk8kPpKdRPpdBramhV?=
 =?us-ascii?Q?dHHNfuNxMLj2EK5yjwRS8XoFeIk48N6nXQglJpN1jHGt9jeyR7rQfxXCK4Ko?=
 =?us-ascii?Q?kTs2l4+idvp6VCCt74I7jAmrQODAhElJ6N1OLbhI9oPUOfJEblJIjuNjyiAr?=
 =?us-ascii?Q?dAEKYpo4W5Dvt46Q89QsuMoMgDwmRjRuxLFhiVXaL/dirP9jZZUPLv8iffhG?=
 =?us-ascii?Q?J6oKl7Ev1YhJWz0a6Y8MqPdTmmFhpkcQ599JYOEvepxpmYRts67TYk8UeIMH?=
 =?us-ascii?Q?mqEwJGl3kxeJQdNFb95yDkSWeguEYQVzI1an06ys//0pmlVUH7/z91u1gVa6?=
 =?us-ascii?Q?X+ocZ1xZyLieZSjCqsANE/GmCrHOJV3aI+UFlKwSyNdKjiSnjz11ST2wF20W?=
 =?us-ascii?Q?wdQlyCF9eycaFH9O5/QOdoXpfkk7twdSNQ/X5b7J3All+lIrGdPuYjhzqBBn?=
 =?us-ascii?Q?VFBQtxQd4/14c5/ZxlWAwIlg5dt6jm+LgGJuifmH6VEsxhMWBSkvdcg0uGk/?=
 =?us-ascii?Q?5td5qLAILu9nHt+pr3B1zOny4LX65P410eCdbKcXVLerbzyEn5mGO8G+dqXW?=
 =?us-ascii?Q?cdATemJpO6nvBi+IvlAaCGiq+Iv9ADgCFrohXuTsvbHz6Ed3tPxqBPP0izJu?=
 =?us-ascii?Q?VUAkXRI4zI++tD8cazeePE+9YwEgGOWFYkpCPcVM4dqz+2Hcyq7pP3c5FUy+?=
 =?us-ascii?Q?4zPtQ/R3Hm7pLr2K56tMCIi++dvbDhJNLzLqdIQTeP0AO6Chg9eBvTNC971C?=
 =?us-ascii?Q?793ZBQzsY0sVC4TyCSSEpMmv3UbFMytLXEkiVaX0qRdaHvAQ4c6U6tqWUo94?=
 =?us-ascii?Q?/16Hr8M3IBFbISegKHi+u+Yg9Csox7DC5pFAp+al+L9UP3+i5kCIElap07ip?=
 =?us-ascii?Q?BGLs5A7XlMOong99IQ/2t5fLhrW3w464UbfNFCb5PzBp+mITIZbmTBL6XH4Y?=
 =?us-ascii?Q?OsyU1hgyBkcs81uTWEdORszTe7zDxqsEypRpkxbGoFnAeQBiRroOIeJH8ups?=
 =?us-ascii?Q?+DTxS1V7YBt6WAmktGt877x1O/IIHXXEH+NaV7MmLWMnHxpc5XQV/0cY2LPk?=
 =?us-ascii?Q?uWStQdC3HFMQoossa1r4R25cl31jEepqGq0eRg+E654CNILEUzYIylmay2an?=
 =?us-ascii?Q?29InDfV2mx5qgEJpZCC1fkBCPeTliw5GdpVtzfP7hJTHvqOC3HCXYmigT/3u?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f31e6fe1-5db3-4151-79e4-08dd344c73c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 03:35:12.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEXyKvnkCUYJvk2+Rt1Ho90W0R4ReUjUc5etFWg1sGNPA5r8UOgHdriWmP/TiS0hQXylzglATBzq7RWYc4c1FAvixJtpXQYnBnJ+N4pBfXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Currently fs dax pages are considered free when the refcount drops to
> one and their refcounts are not increased when mapped via PTEs or
> decreased when unmapped. This requires special logic in mm paths to
> detect that these pages should not be properly refcounted, and to
> detect when the refcount drops to one instead of zero.
> 
> On the other hand get_user_pages(), etc. will properly refcount fs dax
> pages by taking a reference and dropping it when the page is
> unpinned.
> 
> Tracking this special behaviour requires extra PTE bits
> (eg. pte_devmap) and introduces rules that are potentially confusing
> and specific to FS DAX pages. To fix this, and to possibly allow
> removal of the special PTE bits in future, convert the fs dax page
> refcounts to be zero based and instead take a reference on the page
> each time it is mapped as is currently the case for normal pages.
> 
> This may also allow a future clean-up to remove the pgmap refcounting
> that is currently done in mm/gup.c.

This patch depends on FS_DAX_LIMITED being abandoned first, so do
include the patch at the bottom of this reply in your series before this
patch.

> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes since v2:
> 
> Based on some questions from Dan I attempted to have the FS DAX page
> cache (ie. address space) hold a reference to the folio whilst it was
> mapped. However I came to the strong conclusion that this was not the
> right thing to do.
> 
> If the page refcount == 0 it means the page is:
> 
> 1. not mapped into user-space
> 2. not subject to other access via DMA/GUP/etc.
> 
> Ie. From the core MM perspective the page is not in use.
> 
> The fact a page may or may not be present in one or more address space
> mappings is irrelevant for core MM. It just means the page is still in
> use or valid from the file system perspective, and it's a
> responsiblity of the file system to remove these mappings if the pfn
> mapping becomes invalid (along with first making sure the MM state,
> ie. page->refcount, is idle). So we shouldn't be trying to track that
> lifetime with MM refcounts.
> 
> Doing so just makes DMA-idle tracking more complex because there is
> now another thing (one or more address spaces) which can hold
> references on a page. And FS DAX can't even keep track of all the
> address spaces which might contain a reference to the page in the
> XFS/reflink case anyway.
> 
> We could do this if we made file systems invalidate all address space
> mappings prior to calling dax_break_layouts(), but that isn't
> currently neccessary and would lead to increased faults just so we
> could do some superfluous refcounting which the file system already
> does.
> 
> I have however put the page sharing checks and WARN_ON's back which
> also turned out to be useful for figuring out when to re-initialising
> a folio.

I feel like these comments are a useful analysis that deserve not to be
lost to the sands of time on the list.

Perhaps capture a flavor of this relevant for future consideration in a
"DAX page Lifetime" section of Documentation/filesystems/dax.rst?

> ---
>  drivers/nvdimm/pmem.c    |   4 +-
>  fs/dax.c                 | 212 +++++++++++++++++++++++-----------------
>  fs/fuse/virtio_fs.c      |   3 +-
>  fs/xfs/xfs_inode.c       |   2 +-
>  include/linux/dax.h      |   6 +-
>  include/linux/mm.h       |  27 +-----
>  include/linux/mm_types.h |   7 +-
>  mm/gup.c                 |   9 +--
>  mm/huge_memory.c         |   6 +-
>  mm/internal.h            |   2 +-
>  mm/memory-failure.c      |   6 +-
>  mm/memory.c              |   6 +-
>  mm/memremap.c            |  47 ++++-----
>  mm/mm_init.c             |   9 +--
>  mm/swap.c                |   2 +-
>  15 files changed, 183 insertions(+), 165 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index d81faa9..785b2d2 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -513,7 +513,7 @@ static int pmem_attach_disk(struct device *dev,
>  
>  	pmem->disk = disk;
>  	pmem->pgmap.owner = pmem;
> -	pmem->pfn_flags = PFN_DEV;
> +	pmem->pfn_flags = 0;
>  	if (is_nd_pfn(dev)) {
>  		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
>  		pmem->pgmap.ops = &fsdax_pagemap_ops;
> @@ -522,7 +522,6 @@ static int pmem_attach_disk(struct device *dev,
>  		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
>  		pmem->pfn_pad = resource_size(res) -
>  			range_len(&pmem->pgmap.range);
> -		pmem->pfn_flags |= PFN_MAP;
>  		bb_range = pmem->pgmap.range;
>  		bb_range.start += pmem->data_offset;
>  	} else if (pmem_should_map_pages(dev)) {
> @@ -532,7 +531,6 @@ static int pmem_attach_disk(struct device *dev,
>  		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
>  		pmem->pgmap.ops = &fsdax_pagemap_ops;
>  		addr = devm_memremap_pages(dev, &pmem->pgmap);
> -		pmem->pfn_flags |= PFN_MAP;
>  		bb_range = pmem->pgmap.range;
>  	} else {
>  		addr = devm_memremap(dev, pmem->phys_addr,
> diff --git a/fs/dax.c b/fs/dax.c
> index d35dbe1..19f444e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -71,6 +71,11 @@ static unsigned long dax_to_pfn(void *entry)
>  	return xa_to_value(entry) >> DAX_SHIFT;
>  }
>  
> +static struct folio *dax_to_folio(void *entry)
> +{
> +	return page_folio(pfn_to_page(dax_to_pfn(entry)));
> +}
> +
>  static void *dax_make_entry(pfn_t pfn, unsigned long flags)
>  {
>  	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
> @@ -338,44 +343,88 @@ static unsigned long dax_entry_size(void *entry)
>  		return PAGE_SIZE;
>  }
>  
> -static unsigned long dax_end_pfn(void *entry)
> -{
> -	return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
> -}
> -
> -/*
> - * Iterate through all mapped pfns represented by an entry, i.e. skip
> - * 'empty' and 'zero' entries.
> - */
> -#define for_each_mapped_pfn(entry, pfn) \
> -	for (pfn = dax_to_pfn(entry); \
> -			pfn < dax_end_pfn(entry); pfn++)
> -
>  /*
>   * A DAX page is considered shared if it has no mapping set and ->share (which
>   * shares the ->index field) is non-zero. Note this may return false even if the
>   * page is shared between multiple files but has not yet actually been mapped
>   * into multiple address spaces.
>   */
> -static inline bool dax_page_is_shared(struct page *page)
> +static inline bool dax_folio_is_shared(struct folio *folio)
>  {
> -	return !page->mapping && page->share;
> +	return !folio->mapping && folio->share;
>  }
>  
>  /*
> - * Increase the page share refcount, warning if the page is not marked as shared.
> + * Increase the folio share refcount, warning if the folio is not marked as shared.
>   */
> -static inline void dax_page_share_get(struct page *page)
> +static inline void dax_folio_share_get(void *entry)
>  {
> -	WARN_ON_ONCE(!page->share);
> -	WARN_ON_ONCE(page->mapping);
> -	page->share++;
> +	struct folio *folio = dax_to_folio(entry);
> +
> +	WARN_ON_ONCE(!folio->share);
> +	WARN_ON_ONCE(folio->mapping);
> +	WARN_ON_ONCE(dax_entry_order(entry) != folio_order(folio));
> +	folio->share++;
> +}
> +
> +static inline unsigned long dax_folio_share_put(struct folio *folio)
> +{
> +	unsigned long ref;
> +
> +	if (!dax_folio_is_shared(folio))
> +		ref = 0;
> +	else
> +		ref = --folio->share;
> +
> +	WARN_ON_ONCE(ref < 0);
> +	if (!ref) {
> +		folio->mapping = NULL;
> +		if (folio_order(folio)) {
> +			struct dev_pagemap *pgmap = page_pgmap(&folio->page);
> +			unsigned int order = folio_order(folio);
> +			unsigned int i;
> +
> +			for (i = 0; i < (1UL << order); i++) {
> +				struct page *page = folio_page(folio, i);
> +
> +				ClearPageHead(page);
> +				clear_compound_head(page);
> +
> +				/*
> +				 * Reset pgmap which was over-written by
> +				 * prep_compound_page().
> +				 */
> +				page_folio(page)->pgmap = pgmap;
> +
> +				/* Make sure this isn't set to TAIL_MAPPING */
> +				page->mapping = NULL;
> +				page->share = 0;
> +				WARN_ON_ONCE(page_ref_count(page));
> +			}
> +		}
> +	}
> +
> +	return ref;
>  }
>  
> -static inline unsigned long dax_page_share_put(struct page *page)
> +static void dax_device_folio_init(void *entry)

s/dax_device_folio_init/dax_folio_init/

...otherwise I do not see any connection to a "device" concept in this
file.


>  {
> -	WARN_ON_ONCE(!page->share);
> -	return --page->share;
> +	struct folio *folio = dax_to_folio(entry);
> +	int order = dax_entry_order(entry);
> +
> +	/*
> +	 * Folio should have been split back to order-0 pages in
> +	 * dax_folio_share_put() when they were removed from their
> +	 * final mapping.
> +	 */
> +	WARN_ON_ONCE(folio_order(folio));
> +
> +	if (order > 0) {
> +		prep_compound_page(&folio->page, order);
> +		if (order > 1)
> +			INIT_LIST_HEAD(&folio->_deferred_list);
> +		WARN_ON_ONCE(folio_ref_count(folio));
> +	}
>  }
>  
>  /*
> @@ -388,72 +437,58 @@ static inline unsigned long dax_page_share_put(struct page *page)
>   * dax_holder_operations.
>   */
>  static void dax_associate_entry(void *entry, struct address_space *mapping,
> -		struct vm_area_struct *vma, unsigned long address, bool shared)
> +				struct vm_area_struct *vma, unsigned long address, bool shared)
>  {
> -	unsigned long size = dax_entry_size(entry), pfn, index;
> -	int i = 0;
> +	unsigned long size = dax_entry_size(entry), index;
> +	struct folio *folio = dax_to_folio(entry);
>  
>  	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
>  		return;
>  
>  	index = linear_page_index(vma, address & ~(size - 1));
> -	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> -
> -		if (shared && page->mapping && page->share) {
> -			if (page->mapping) {
> -				page->mapping = NULL;
> +	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {

This change in logic aligns with the previous feedback on the suspect

    "if (shared && page->mapping && page->share)"

...statememt, right?

...and maybe the dax_make_shared() suggestion makes the diff smaller
here.

> +		if (folio->mapping) {
> +			folio->mapping = NULL;
>  
> -				/*
> -				 * Page has already been mapped into one address
> -				 * space so set the share count.
> -				 */
> -				page->share = 1;
> -			}
> -
> -			dax_page_share_get(page);
> -		} else {
> -			WARN_ON_ONCE(page->mapping);
> -			page->mapping = mapping;
> -			page->index = index + i++;
> +			/*
> +			 * folio has already been mapped into one address
> +			 * space so set the share count.
> +			 */
> +			folio->share = 1;
>  		}
> +
> +		dax_folio_share_get(entry);
> +	} else {
> +		WARN_ON_ONCE(folio->mapping);
> +		dax_device_folio_init(entry);
> +		folio = dax_to_folio(entry);
> +		folio->mapping = mapping;
> +		folio->index = index;
>  	}
>  }
>  
>  static void dax_disassociate_entry(void *entry, struct address_space *mapping,
> -		bool trunc)
> +				bool trunc)
>  {
> -	unsigned long pfn;
> +	struct folio *folio = dax_to_folio(entry);
>  
>  	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
>  		return;
>  
> -	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> -
> -		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> -		if (dax_page_is_shared(page)) {
> -			/* keep the shared flag if this page is still shared */
> -			if (dax_page_share_put(page) > 0)
> -				continue;
> -		} else
> -			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> -		page->mapping = NULL;
> -		page->index = 0;
> -	}
> +	dax_folio_share_put(folio);

Probably should not call this "share_put" anymore since it is handling
both the shared and non-shared case.

>  }
>  
>  static struct page *dax_busy_page(void *entry)

Hmm, will this ultimately become dax_busy_folio()?

[..]
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 54b59b8..e308cb9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -295,6 +295,8 @@ typedef struct {
>   *    anonymous memory.
>   * @index: Offset within the file, in units of pages.  For anonymous memory,
>   *    this is the index from the beginning of the mmap.
> + * @share: number of DAX mappings that reference this folio. See
> + *    dax_associate_entry.
>   * @private: Filesystem per-folio data (see folio_attach_private()).
>   * @swap: Used for swp_entry_t if folio_test_swapcache().
>   * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
> @@ -344,7 +346,10 @@ struct folio {
>  				struct dev_pagemap *pgmap;
>  			};
>  			struct address_space *mapping;
> -			pgoff_t index;
> +			union {
> +				pgoff_t index;
> +				unsigned long share;
> +			};

This feels like it should be an immediate follow-on change if only to
separate fsdax conversion bugs from ->index ->share aliasing bugs, and
due to the significance of touching 'struct page'.

[..]

As I only have cosmetic comments you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...and here is that aformentioned patch:

-- 8< --
Subject: dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support

From: Dan Williams <dan.j.williams@intel.com>

The dcssblk driver has long needed special case supoprt to enable
limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
works around the incomplete support for ZONE_DEVICE on s390 by forgoing
the ability of dax-mapped pages to support GUP.

Now, pending cleanups to fsdax that fix its reference counting [1] depend on
the ability of all dax drivers to supply ZONE_DEVICE pages.

To allow that work to move forward, dax support needs to be paused for
dcssblk until ZONE_DEVICE support arrives. That work has been known for
a few years [2], and the removal of "pte_devmap" requirements [3] makes the
conversion easier.

For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
(dcssblk was the only user).

Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/filesystems/dax.rst |    1 -
 drivers/s390/block/Kconfig        |   12 ++++++++++--
 drivers/s390/block/dcssblk.c      |   27 +++++++++++++++++----------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index 719e90f1988e..08dd5e254cc5 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -207,7 +207,6 @@ implement direct_access.
 
 These block devices may be used for inspiration:
 - brd: RAM backed block device driver
-- dcssblk: s390 dcss block device driver
 - pmem: NVDIMM persistent memory driver
 
 
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index e3710a762aba..4bfe469c04aa 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -4,13 +4,21 @@ comment "S/390 block device drivers"
 
 config DCSSBLK
 	def_tristate m
-	select FS_DAX_LIMITED
-	select DAX
 	prompt "DCSSBLK support"
 	depends on S390 && BLOCK
 	help
 	  Support for dcss block device
 
+config DCSSBLK_DAX
+	def_bool y
+	depends on DCSSBLK
+	# requires S390 ZONE_DEVICE support
+	depends on BROKEN
+	select DAX
+	prompt "DCSSBLK DAX support"
+	help
+	  Enable DAX operation for the dcss block device
+
 config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 0f14d279d30b..7248e547fefb 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -534,6 +534,21 @@ static const struct attribute_group *dcssblk_dev_attr_groups[] = {
 	NULL,
 };
 
+static int dcssblk_setup_dax(struct dcssblk_dev_info *dev_info)
+{
+	struct dax_device *dax_dev;
+
+	if (!IS_ENABLED(CONFIG_DCSSBLK_DAX))
+		return 0;
+
+	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
+	if (IS_ERR(dax_dev))
+		return PTR_ERR(dax_dev);
+	set_dax_synchronous(dax_dev);
+	dev_info->dax_dev = dax_dev;
+	return dax_add_host(dev_info->dax_dev, dev_info->gd);
+}
+
 /*
  * device attribute for adding devices
  */
@@ -547,7 +562,6 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	int rc, i, j, num_of_segments;
 	struct dcssblk_dev_info *dev_info;
 	struct segment_info *seg_info, *temp;
-	struct dax_device *dax_dev;
 	char *local_buf;
 	unsigned long seg_byte_size;
 
@@ -674,14 +688,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	if (rc)
 		goto put_dev;
 
-	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
-	if (IS_ERR(dax_dev)) {
-		rc = PTR_ERR(dax_dev);
-		goto put_dev;
-	}
-	set_dax_synchronous(dax_dev);
-	dev_info->dax_dev = dax_dev;
-	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
+	rc = dcssblk_setup_dax(dev_info);
 	if (rc)
 		goto out_dax;
 
@@ -917,7 +924,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
 		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
-				PFN_DEV|PFN_SPECIAL);
+				      PFN_DEV);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }

