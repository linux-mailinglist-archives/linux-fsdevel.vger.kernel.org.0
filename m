Return-Path: <linux-fsdevel+bounces-45107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FFAA7205C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 22:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78CD7A4FE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8807625EF9B;
	Wed, 26 Mar 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPSXN6yI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2D25DB0E;
	Wed, 26 Mar 2025 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023123; cv=fail; b=ihWODPcI/WAeh2FM3UGyWdagsQJtjGTWxsYkCBkLRfc8NRyEaLkNiz9Xc4kvRjg3w/WPCppY6w9PuzjBmnJbtXNFbccxdCrSPLIHqIPfJ1bJtbLz6oXo2FetAGz5vUjV4I/n6A1V8S6d5T5hHbGi0fSiVJZGfriOMgXKPM7y1iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023123; c=relaxed/simple;
	bh=zvDLKSWkJYS9VdMpsWs7XWAFdx38N4LWdVLhQN6TUDw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yxf7bUDnM03g6QdsDj3m6gcoj83oqkS38yCkx9Qhqdx7nf6BBqCjqNcqo5ikw5mb19/vgiagLCqjlMlKiZZ+jl46knKlGKgMqSmZArqdLvO46/2SIU/MBxHTt5r7qqrC3wimep8PB74ay2QZ4ncxOpVFkaHTr4Od7LWR3+rGC64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPSXN6yI; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743023122; x=1774559122;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zvDLKSWkJYS9VdMpsWs7XWAFdx38N4LWdVLhQN6TUDw=;
  b=kPSXN6yILQjeu9NSVhMTf24DYAKYuv3UtJ6B0VGAgSMI2w3SXym9nXXj
   h5GbHiKqQ/wpenrEVbv6pdhh7QWr6IRX4HJ3wjBlMB26aeMBfSy80qvZB
   AswHfrm4DN/lZ8h+aJjz/pph83zPt+GnGegM6H7o7Wb8vL4akE7dcTI01
   dM804WbM7tcI1M0GfnqrgQH8TAiMCYBFYqzE8QX3c8cGmGMPEs38/z7NN
   pTlB2VRvdvY3rFQzGjfjCSOsXXQ8Ey6NA14MqB/TWLAHYuGbs4D1zoYeg
   15T2eUkZTJmbtwSPVPwcwsw7V+GfrS5q8ljkeiL/bN5fTBYZoYBdZHsM4
   g==;
X-CSE-ConnectionGUID: jmnTFJ4CQP+sIJ2bYzpIbw==
X-CSE-MsgGUID: hyV+58MzQIiBnzUQkDAz5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="43577309"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="43577309"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 14:05:20 -0700
X-CSE-ConnectionGUID: elsotlziQuS5qvn3zO3Szw==
X-CSE-MsgGUID: bSQjeyrWQCWbslMl9R2inA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129762236"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 14:05:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 14:05:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 14:05:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 14:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTpaakRBladeYu/Kf96pZuryGkhT0q51drljlPYLIfxGDBvgyWjNiuj2uoPGqCR6BsEFH9QqneD+3e8Z9eopZvgZz64z+vGHBb0NwZIzpp4TNrdzyjPWl/+H2DqbLgSGE1/P0kP8fUcJ2NU/AlfC2NVaAGjs1dmW7x8aMySairRdjICYSQ25O6QQnIrBBSjo681H5OBxLuNHnHgd/Pw2f7ruF24uA37WjQly4qtw2TPaZFqfe2XIikTll+f1V7PrtKgGm5PnHJpx6xpIUdQxYYpojBlL+Api9PtqBOSXRcYIeSkiseGJ0R/r9jvUV0lZ3M8lmmQFiQX9niBCaSxBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw8lRkPlS6v+iGALNKBdXsSsmOX7xD2zL+igRQ4cUsk=;
 b=QNOAhpQl3mm7rtIG+U+dpM05fRjhnikLoIZr4OY8kvo6HcTenuo4yAZdiXWH78PH7CR1joF30RNCbgbGvaJ+RfvgRypZ16Lit6C9X3CROBvbn1jjeBqPDZxDvk87MPCFTRsWGA7XlIJYZckKDuUxrmukRorZtwAgLsHtxJ1s51L5uu7GdQ07Zi/e/iggUwbezNcF2WbJEThHt/VdvtgOKi22U/nqM+Aa/cSQj9Z0799MXXsRf82S7e4xzVnWSKGpriaPFoWPmZ3YmCw5T3jS9ej7btLrSg8UB7nAG5Qd8TS+9S9DpOkNZ90H6EDoMABn++9Rk/xLf/rrXAfKjYucvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 21:04:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 21:04:50 +0000
Date: Wed, 26 Mar 2025 17:04:39 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: David Hildenbrand <david@redhat.com>, Alistair Popple
	<apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: Alison Schofield <alison.schofield@intel.com>, <lina@asahilina.net>,
	<zhang.lyra@gmail.com>, <gerald.schaefer@linux.ibm.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
	<bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v9 19/20] fs/dax: Properly refcount fs dax pages
Message-ID: <67e46be7e0a25_152c29414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
 <c7d886ad7468a20452ef6e0ddab6cfe220874e7c.1740713401.git-series.apopple@nvidia.com>
 <964e8991-44c0-4ff7-91cc-033ed7c09835@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <964e8991-44c0-4ff7-91cc-033ed7c09835@redhat.com>
X-ClientProxiedBy: MW4PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:303:83::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 1883afcb-804f-438b-5bef-08dd6ca9d8aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bCdOexiib1bNW39IgVeQM3iAUL4MOnHzhnei4COkbOOjSDcCvDuWbx+Fv567?=
 =?us-ascii?Q?khTk1c4RuzeU9CPP37Wv3Pg9bWoAkcsZR7bRXntbykaVY+4rxt4CmpAF4G1H?=
 =?us-ascii?Q?TomOccI8EQQ/hfTSusQBgqF3eh4ZHCcHGG/Wl7nswzmNufVYPtlsV/UyYuR2?=
 =?us-ascii?Q?B3Ezu4RbtwePQzmEtIylmZIa+iNTdhB6NHtAxIeiEO/ir/VRUoGSOwADH+Hm?=
 =?us-ascii?Q?AZfeAikYbc9flt8xe7ua//2SLzftuSn9ixBaamJ8N978KskmR/MlBHm23vwD?=
 =?us-ascii?Q?xPcxFKSH/IBb+U6OhLlYFakaVCO+UBnc87A+wTjleuQCAH+nsByM6ZN//bt4?=
 =?us-ascii?Q?1f+7o2hRv/MTkNbmZIjY0pjQLhBGDzB+YCz2nvHj9XcyVPx3QT4CqJminfZp?=
 =?us-ascii?Q?LDI+9xlIz99RgLbPW/OwtCt5Y60SYxJMHKvGIn7LvVIrjoqkZqYWDpRL1pwC?=
 =?us-ascii?Q?iCQSk7IMtgQtUdSIPZsYVr9pwRNBt4cT1jI1MHYGArLwFhU6Elh/SEwmlZG5?=
 =?us-ascii?Q?a+r8PJe88G1Nv21JUlrE19VbP+9D10owUO1z1fr7AX1dKh/+l3NXsAFvd0Iy?=
 =?us-ascii?Q?JcTEQBlSau9ezG957+drQJZo7pDoxhsC0byPPRPEeU66mQb4ArFFL94+b7r5?=
 =?us-ascii?Q?4Ts/w2nUbtYP9QC5wI5FTHUPiXnYaa8Xig1iBaOENxrpP2KPkxofnRRtwW2d?=
 =?us-ascii?Q?WxxQhz9aIWLvu7TS/+fVcWrZXvY/kNOcI7YlJizip4lb082kO3ikEhPvyGzF?=
 =?us-ascii?Q?vmo/GPLkoTmectaNCYUqWBBxiVPY8oJVSFioDcLz/ri11cOICtXv30Bg1VgN?=
 =?us-ascii?Q?XIy0ObgdR/ExXVLq1hfTZWKt94sz+7mywwUKPMXUuByKQ3cy+CpG/6fCI0o3?=
 =?us-ascii?Q?Le38CFgLFUB+N+3mF1SQKK5KEFMeL5W0QVkSqw2Tqx88hxQ4qybziUePD74z?=
 =?us-ascii?Q?KBDW1bKmw2T3RBr0SY78S59n+RXh9c4IP1u6WeUPAlxmt0m6aOsDMKvSMWYI?=
 =?us-ascii?Q?GejUPf3j9j3tHfAetCRQmU/zi9EyeulixVub0Hl+u9uOFBDTEQD4AW6DbobQ?=
 =?us-ascii?Q?RbejP9EEuXKIGuZR8prjXVJ4Gcj8ZWgnyOApqerpxiVQWNetYRaAxN02OjYs?=
 =?us-ascii?Q?+xFMx3BtQl4xaZE8agpByjjsuwW0az4fNgndlSe8mMpPvanLOp8polZmZ1TX?=
 =?us-ascii?Q?Xln0/NrhdDff/W0AFSQQVKERiyEgAPlFbF+NN3JhNmFCNj7YOOnyKHdL/RJd?=
 =?us-ascii?Q?ERxaXBNxziZK7KyrqS5qArOgu96IjRiPstkoiHdurxlp3h4vUpwS/OykksnF?=
 =?us-ascii?Q?twLcCyQ3XYsic1SvKOzT5NnDRfdH+6gUMYCONOyfZahgxG78G23FDIGMcH9k?=
 =?us-ascii?Q?SvBr2z0mz7deUqaXHyg/9y5BZCax?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PTo14G16TBTJ+L5HMEnYESLfLxUMJLyC6JbcEBHPPM9imvPRL7JDkI4CFImS?=
 =?us-ascii?Q?QIMqQsgWIrbEdxV7470cptbfdbsmJ0+MfaOhzHh3RoPPKuHYd+dhS2moTZft?=
 =?us-ascii?Q?ryXdjXp02I+RPQqBgZhDQQlbVOyTgNdDj6IbIrkkHk8kAPrPuDiZF4IlEzqb?=
 =?us-ascii?Q?Phgp+Ge5rLXlV4njuuQ4ayKSYtth1cnQjN2TvjnuySz2ROS8+B1bqGYs0sX0?=
 =?us-ascii?Q?ANZIy9788Jumzu9fJoZLh4hR8YWO8iyLCCTjgYRjWl/UYfr+4skv7CbGfAIU?=
 =?us-ascii?Q?bod9yJkZCq3MiwzbZPiiz2h20Dnj0KkcfP6spyYQkrcvml6ErEsg9vL3ed95?=
 =?us-ascii?Q?V+527g0cMUhle6AW+8awJYY5KcVnDNEw81flmUa9Kt3oHFsA9+dyYxAPRIyz?=
 =?us-ascii?Q?t/h+Fxfv10yBSUqWbcJCIV6EXsdCIQN3Ph439CfYWo2qRzDYrCq8w6QHe/ZE?=
 =?us-ascii?Q?Ro/TE3LBsu4b6w8gmmMmBwS9/FG06yABqOXdPq4sO7P7/mYsAnWIeoHx9HNa?=
 =?us-ascii?Q?0p6OmXvw6RnTsuF7+nDG3P5CCz296ii1jFdxkOb8v0kwUf7PUw3wYvBvWtRx?=
 =?us-ascii?Q?l8BgNZMyLvgHJED8DJftK28IazvO9G2qWDMfvIHoU7a7z1lmwJa6eqSytDfm?=
 =?us-ascii?Q?49AnAKccWOW0Qs0FWVMh7oQvniZMMBguBo064QJ3MBvNQbSTvnRxQlqEeaRi?=
 =?us-ascii?Q?nzooineuqqb3SQGOX7yABFEAi+vjEJ9QOdt39Zz6JWN537NDq99/nC9TpOJM?=
 =?us-ascii?Q?jCu0OgMCXcgdh1eq0WbxBDM9cfKaE3pW6VtxiSr/HRLFTPbroUu7zWeVetf/?=
 =?us-ascii?Q?Nb6CAhgYmVt5Rj6FoyFrDddF0iwn4HGqwwaGHQqfuqJEIWIbhfVVg7VnnaoS?=
 =?us-ascii?Q?ADuADj5wBiwpebo/YjnGttmO2yek+hSD8Qs/kWbf4djz7UCG1bZrcRUfN6H8?=
 =?us-ascii?Q?A/ufE9hQrKTS67BLXyttS2ZTiF7cKk2gQlG3BE7LvVjv70yTZiQi8lFi7cSh?=
 =?us-ascii?Q?5dA/3Bmic5SUygwAQQlcK81Q7p6mk3qpHCcyM9j0+kOxP/Oa3ok1hMrSFIOh?=
 =?us-ascii?Q?tFgG/3XzuMu+9kpc2luiD3SAlRmsah9mNHI+5CISZ2SAesI2PL5uqvppAw5P?=
 =?us-ascii?Q?bah23WhHfz45qnQcEG2aU4jujzQt1yajeXGjQnCAmqn9Pom2adN3S24xLUoA?=
 =?us-ascii?Q?gxunOfwJ5iTp87SF6h8OBSPQNTjseka5mTysSxC6FekXOH8MPAtxXWpD4tyo?=
 =?us-ascii?Q?fL6JK3un9X3GckJE3jBErFHQi1gxbqkMcwIk61NxVUOsHpHIimtU0c+6YJyx?=
 =?us-ascii?Q?gkV/Ev6M6qyxsq399gkILl6ufOIfsOFo6QNFD+aV4lPV91656F6rbKaz5lGD?=
 =?us-ascii?Q?hn2ZC9bZyuoRMVarVQoJMLClqfL0duj9fu3gAHX4Oawm+OM628eHp8R1Aq4o?=
 =?us-ascii?Q?ZOK4yYqKYrtGQ8Kxor20VFBGpqpPEMqfuMmCYyiUf9OAeE2VywLS8Zz+HKkF?=
 =?us-ascii?Q?hT8nZoRugzFTcg/yS/dfUL56V7TOFgHvUm174kNsRgpm/2fc3WJ4SVfyjmxf?=
 =?us-ascii?Q?WP/1wZUhPmv6xR5WMmI3tt1ilD+VmCtkFUhQom14EeuF1hm/NdOoLqWKY5AC?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1883afcb-804f-438b-5bef-08dd6ca9d8aa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 21:04:49.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0w59kmO6HsHiq8M9TK8dwM+IwngD4w4Fk9TeEkaE4nQY9S274H6GB00TMXK9UkgB3eCZRxZAgV7suEnPWDNZS02EVIA/Tzo2xXeU93X/WF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5814
X-OriginatorOrg: intel.com

David Hildenbrand wrote:
> 
> > -static inline unsigned long dax_folio_share_put(struct folio *folio)
> > +static inline unsigned long dax_folio_put(struct folio *folio)
> >   {
> > -	return --folio->page.share;
> > +	unsigned long ref;
> > +	int order, i;
> > +
> > +	if (!dax_folio_is_shared(folio))
> > +		ref = 0;
> > +	else
> > +		ref = --folio->share;
> > +
> 
> It would still be good to learn how this non-atomic update here is safe 
> (@Dan?), but that's independent of this series.

Apologies, I missed this question earlier.

All these manipulations are happening under xas_lock_irq() for @entry
where each @entry is 1:1 correlated with a folio. So concurrent attempts
to associate/disassociate a reflinked block in a file should synchronize
there.

> Staring at it, I would have thought we have to us an atomic_t here.
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks for taking a look!

