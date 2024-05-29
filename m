Return-Path: <linux-fsdevel+bounces-20401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520A28D2CB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729161C241A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 05:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2152015CD61;
	Wed, 29 May 2024 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqmAV9ab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151315B96E;
	Wed, 29 May 2024 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961928; cv=fail; b=Xx0FUHa5wY4J2LhGFMlTdlgp0G/MDVmgyctOMMGYwdc2X52IV1SfbchaPLodv4aDozeNMXBBHLZbg+HotIU3V/9PJhfeB+qxsT5tcrfgCdw67TYGDnnyR5pLHdcFbEFEdSeR+LJ4OclM0vBNfED3dhrSF5s+LMGzm1oixrGTmSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961928; c=relaxed/simple;
	bh=5A8MkGLPci/+mftC0erKHRRBZanSxAJFRjN4j9mpWuA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Te3co+hHdJ93nVognLIM2XmiEp5GvCWuhECsgcoKg7zhl0Zolbcel2yayHrFw3L0KM0jWcfLt/ZPvNsLDHqbbwgAHRX4/NLOXb2n8VtlZKnA3JR6R+mb7D4IVSjUCAAzSJspx7YNd2BNfa0S3nTTjIFfNAXQMSEtMiIgHhg1Stg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqmAV9ab; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716961926; x=1748497926;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=5A8MkGLPci/+mftC0erKHRRBZanSxAJFRjN4j9mpWuA=;
  b=iqmAV9abDXkEpoko02cjCVEM0P8iv2QkT+cMD0vsAduufmQOgvOPXZ9t
   +QFVW0xzt8TWVjqMfRerhzk/NMsoqBBekXsNv3OUiNMTrprOrP62YsP7x
   ndYAf8DvV24+EMipfGfEVQeBulxK6mX9SVOvhAEKlbYMikvuTkyIE+Dsr
   Gi+R1NW36GSZQotyoGw4P1zh5plfFSI4ABKgWk4CYTpMOYadI/Swr/yIG
   fvnACgk0bsbRPAtSR5Lf9QatgqquUJ9Eko+Ojx2Tkh1O8+yr0bggc5acd
   VyTF1vFFfZlMtQsrEmye9g8LfmKvVpFuWNdOd+GNLT8iT8FvZQFqab/cI
   w==;
X-CSE-ConnectionGUID: C1S1PwWMSZqCrC/dRTbixA==
X-CSE-MsgGUID: YnGyI0uHQCS8+jSuPANW7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13192558"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13192558"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:52:05 -0700
X-CSE-ConnectionGUID: A+fQiQfRSKeA0XLcL21MfA==
X-CSE-MsgGUID: bVyj53XeT+uxUsLENAb0tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="40191249"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 22:52:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 22:52:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 22:52:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 22:52:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 22:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyc/jz9mJzHIrm7kyFtJGUOr1xJXP8z4irKjuBHrz0jFM7932k1nS17VyxwjeMCrzdmKIbfNFkf2EwAscQB2nd8DSTn/LiilSUUa88WyCvrfjcu6pknEUicN4GfovUCOp4PsL8v7T9eLVj4e21Wb3l0KnK2gvUVTs3b/pLfoeV+/C7eQGMq4HfjkakXkm0MQJQoJtb4P+Lpf4Q13TiVrLrqnypG/x/pyWDrUwa2NJSGaNacLJBR0VW1ml7UDFezHEPBIMUz807pBnpzJAH562wi5BpKoZaeDYMGV2LQix2SrGmyYCbkXGTd/y34KMwo1nj5oSgZJh+TZuY83f3wrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w57CQBy8U0X0u6i1JCFWyrXZj0utFed81zcxgQHeem8=;
 b=JMk0aSPllSkk89aiX0558/8VNndl1eBVR6gobw9vn6CKzACoOpMpbBi5KBVpM9xVm7nLyr6NTTvxSzuCe/GkQ+VOka3U6lRoeh0Re8x6KWndIFVSmGCbnEy7/GDdu08Z+5Iu7gvTcJL/l7Z1l8jf3P3HTP44aCmTR/fh4MeFm403lyzZp0hEZ3VG3z99brKnOIOi5i8sNSVppA1ZfnyhDhXxKTV6oA0+Z+jIj/mTGxO5ZvSovL5LtKBEt9Euco9Nrlw8OYbEhn4jEmOSK/q4StAvx7sLFPB0x1cdW8XM1n4BuJiL2hKuM5KbAH7Z1dknJjzjWMKf1UvD4BPm9m7IXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 05:52:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 05:52:01 +0000
Date: Wed, 29 May 2024 13:51:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Waiman Long <longman@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, Wangkai <wangkai86@huawei.com>, Colin Walters
	<walters@verbum.org>, kernel test robot <oliver.sang@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: [linus:master] [vfs]  681ce86235:  filebench.sum_operations/s -7.4%
 regression
Message-ID: <202405291318.4dfbb352-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b06a4a-d853-43fc-c17d-08dc7fa3759d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Uch0MMKjjVQjmStmJ1WPi0sJBX5iYQpHRG6WV2WZGa0P1mI2JN/TJB7wyE?=
 =?iso-8859-1?Q?X0F2Ck7f5/aOlZ9z8drA8tRuLiZcErGau/D8R/OhwzSe52T3cUIL2nLtv+?=
 =?iso-8859-1?Q?rqbb1xRL8iTAEsnorS+eXuQvvrfWRkVIFTGw6F53Zb/s68+b2v4ANyWNIx?=
 =?iso-8859-1?Q?oWd0OsvEHDJhiOWRdRj+W5+7Y3PVwpiqK/NyDylO3Aw8s7d+liaHtZfywR?=
 =?iso-8859-1?Q?aQlM//xyb80nMnqnOHjtv0kYoL2tZxGwl6iLAedNeh24fU9Ib+Jdbv6N3n?=
 =?iso-8859-1?Q?66CTILzSz3RhQmEGkgnv7V58tvLzmSrRu08ecQOKZ97LEyjy6+XSxGJ8Sv?=
 =?iso-8859-1?Q?yftAw02SKZMDLvB07rQOffJO3A9vUoTUNRxOSGLsSNtpN6izBNPA0HTK8b?=
 =?iso-8859-1?Q?E5t2eVmTCnuHnD/ZKBGY8kPBIazqP1MoWjMHxlrSba8O8ASTnKjNjUvBGp?=
 =?iso-8859-1?Q?YyAqvmrJbcxaGjDrkl6vDbxzKiBZSvkgSN99WH1VWZUTYJEDtiRIIJmfck?=
 =?iso-8859-1?Q?DhZzwyrXGzPNZMffLBOg5kbpNU7iqppg+y+LtxXWbVxGIs1Gd/TRmuPOz3?=
 =?iso-8859-1?Q?ES7t6HWl+aajzWIT5Hb6b3E7TV+5uWBxp2GjbmIZq4FU9zwAnM02+JaG/m?=
 =?iso-8859-1?Q?JRGydWPCckWvlqnvWq6/NdVsIiYJmVOVOwokUIXRNwxM6D1HPXXgVC3nXK?=
 =?iso-8859-1?Q?wlRI+IDxNMGvzdKAnODhL/RKcOP89/6urT7vSSY9u32jKp6LIoH1Fbh90N?=
 =?iso-8859-1?Q?DDmWtcETcBJleWP9iDN53s3A7tXVO+hlimmeZMHYOq3/ZEkbnu35vvKxNW?=
 =?iso-8859-1?Q?E7yQtvBE2G20BjICg0B9lWG6Nu/XakFs4xs5oLAHF8I3g4PD7o7D24wa4P?=
 =?iso-8859-1?Q?aQQsNq0yaYaEIia2FFgdNXy2iV8myVKJu85vWSK6kzfgjmgAUQbwZ4q/qu?=
 =?iso-8859-1?Q?k2WZmdNqhlFaOcY6vD2UtycR6Fh/SYZlI+uY9qij9SiOp7IHVrQDMxJ42e?=
 =?iso-8859-1?Q?11OqCoFcuvkCU4K/4ZYQXBpJDYtH2LzUaAz6JwAL9DMYsIYg4OEL+Se1fD?=
 =?iso-8859-1?Q?7a9lW8BGo+lw9KFeJyOp0VHRznoFM6HI6gt9HQlnWMPw4Si6FDeKENZeac?=
 =?iso-8859-1?Q?7Cu12G0Fq4aajgv58JMBgcn7TllHKrxnpg5NVUYsB7bQh1H5UpvVbCOqjO?=
 =?iso-8859-1?Q?+QZpWKVpOmUd02IfxIK1aZDzZ0MK5tBluATBgDzpjyHaz0aOHuUQpQdWJz?=
 =?iso-8859-1?Q?VCdYhuBtDNoGQ24MQluNc1Fx6Exe5NyoFW6Pv49A8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Nr426USNFgGoZOhCgLXWvjIh7eK1VsTFoNC+TJurxdkb4CHCV9e3Td5hb4?=
 =?iso-8859-1?Q?+1fgk8gWkG9Qekbl3zsG1EY8teSU7+wTSQk7iusf22X0iOfCMOK2VV1wFf?=
 =?iso-8859-1?Q?gSOfVAKvQ22RtbqFcMNsa3nnYHKiFraJd8xIGXB2L0yVOFnfH/QzJzCQYI?=
 =?iso-8859-1?Q?hWpKAsNYvLUOp5j+vULW/oRMMyRgnMY/BF43/iBi2DnpnMnnvatvxtQQpK?=
 =?iso-8859-1?Q?/RCJWlnQ4lZDO0R300nYB1/nw0K92Pzbrkc+YwHlIxI/V3c0z1GeEUNKZA?=
 =?iso-8859-1?Q?eZXLrBuKRnsJV6RJ+Kd/fa96Ge+EQBmnqCirR9H1qvJP1+zD0Tbct1nuAe?=
 =?iso-8859-1?Q?pxiGeC4YmNISlZVyn34xBD/v7ljs7QuewVM/dTBRCNZ9pwmOXNhXFr2/0a?=
 =?iso-8859-1?Q?fPLAzsfprD3L/Rs03Yqq8+wKdAMQrQfcD3GuSY+cZ2vM6e/y+Szob/mKhU?=
 =?iso-8859-1?Q?kIsvtzMMpH6Y7plx/UHc1ZjVu+dxP+vPPenW+KkHV2unlrTQorDWUnykg7?=
 =?iso-8859-1?Q?8JPqJIEsJeeL1owj4+B1E+XOwJeKoB2bTB7b5GPv5Lg9+AE9me/M8xfAi2?=
 =?iso-8859-1?Q?iUNiTjzYx2NTccjOczXy6sYboGd/A1RRjqoHBevKwFilaFL0oE9sePfJ9j?=
 =?iso-8859-1?Q?lbAyKrUv7BAYRHb47vb9S9YkrYCFdGbZf303qe3SVnfSv4RTJEnJaBLuen?=
 =?iso-8859-1?Q?RXaYc+mfHefLkx/mOZ1kiccgO8VnjN7stpDFEfLvdT+RFJU0e62BGhxss5?=
 =?iso-8859-1?Q?LELUysi8KjNpnYtKOD0rZ57gnmsQ/QC3ZDDdpm+iUR8jXbYGuiC8eprP/l?=
 =?iso-8859-1?Q?VQsb1cz7wiX8js2tinw+v1pF5CTfEA0CnxHwMDsj3c9pjkPi3TL+yKH8Rm?=
 =?iso-8859-1?Q?C3yP91jgQIDofqgHuUxl884zITb855CGKzAB2AJDFp3yo0rXFmkcQxp/my?=
 =?iso-8859-1?Q?xFSJuZE8CUs5R6aSCa1zwregkPtLM6AwvVNZU6yFTP+q6Usg6WEbzie32l?=
 =?iso-8859-1?Q?zkVtNNQJ3iqPv/aa0uCiT5HEbKPQvlbVA4oMHxSRiHRwubc25dpBJTASZO?=
 =?iso-8859-1?Q?pLv/YrnUiA2NuZlqvMBZnanL/SfIGRXrPtsG3vm19EcRNvVBl4wnbPwG8M?=
 =?iso-8859-1?Q?HO3G6Uy8pg9s89N6sagbTMRXUart7+Yo5Mqa0uadyddgU3aklvl7B4UOye?=
 =?iso-8859-1?Q?H+J/Gi6LVggO0JfAajTSSrO9r0TWpNwM01AbjBbuOlEbEZMHgIJdvurMAk?=
 =?iso-8859-1?Q?cBQkJI7rruIdZlKC/YyTLalu6/9s5X9OjWUOua11d28zQ31sERwkdEexKQ?=
 =?iso-8859-1?Q?H/iRtdH8DX7bpjEfNsDKLjNb2nswFUhdNjrlAJzKXLWPv5b/GwKRaIJxmC?=
 =?iso-8859-1?Q?1QsSXMwCsd5NBNCOFTN+Rp5x8yjjvKglA6NI2OjPnVToQJhGigt0I5Z8td?=
 =?iso-8859-1?Q?Z9l/llpUnNWGsoJM+nc1rUL5CnkMrqNOVkCAZ80Cz+pjEaFK1pvHQ49rMt?=
 =?iso-8859-1?Q?hKysVqNlLdPxggPSD7dxoXHWw33P/a5Ee0B9oLBVX2/ZNAxen7iuV5s91n?=
 =?iso-8859-1?Q?Ciadnerwpg6VEZwsIiwdWYKHYlsm5NBqtlMZxNpUvwVbKJPVVoxalYzXwJ?=
 =?iso-8859-1?Q?Mr2uy5Aj4fACO0LAj7mJKfj0jxGZH+svjPNwhSSLIch4sjQu1nl1lcBA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b06a4a-d853-43fc-c17d-08dc7fa3759d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 05:52:01.2693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obOjjlvODJ1/VFKrie7kBIp8WewnzpLbg6BmxMWg3H4nZlREeAL9mN/kXsjNaWW3p4hQpFiE6bwTyS6G2iR1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com


hi, Yafang Shao,

we captured this filebench regression after this patch is merged into mailine.

we noticed there is difference with original version in
https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail.com/

but we confirmed there is similar regression by origial version. details as
below [1] FYI.



Hello,

kernel test robot noticed a -7.4% regression of filebench.sum_operations/s on:


commit: 681ce8623567ba7e7333908e9826b77145312dda ("vfs: Delete the associated dentry when deleting a file")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


[still regression on linus/master 2bfcfd584ff5ccc8bb7acde19b42570414bf880b]


testcase: filebench
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: ext4
	test: webproxy.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405291318.4dfbb352-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240529/202405291318.4dfbb352-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/webproxy.f/filebench

commit: 
  29c73fc794 ("Merge tag 'perf-tools-for-v6.10-1-2024-05-21' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools")
  681ce86235 ("vfs: Delete the associated dentry when deleting a file")

29c73fc794c83505 681ce8623567ba7e7333908e982 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  31537383 ±  2%     -75.1%    7846497 ±  4%  cpuidle..usage
     27.21            +1.4%      27.59        iostat.cpu.system
   3830823 ±  5%     -16.2%    3208825 ±  4%  numa-numastat.node1.local_node
   3916065 ±  5%     -16.3%    3277633 ±  3%  numa-numastat.node1.numa_hit
    455641           -74.2%     117514 ±  4%  vmstat.system.cs
     90146           -34.9%      58712        vmstat.system.in
      0.14            -0.0        0.12 ±  2%  mpstat.cpu.all.irq%
      0.07            -0.0        0.04 ±  2%  mpstat.cpu.all.soft%
      0.56            -0.2        0.36 ±  2%  mpstat.cpu.all.usr%
      2038 ±  6%     -25.8%       1511 ±  3%  perf-c2c.DRAM.local
     20304 ± 14%     -62.9%       7523 ±  2%  perf-c2c.DRAM.remote
     18850 ± 16%     -71.0%       5470 ±  2%  perf-c2c.HITM.local
     13220 ± 15%     -68.1%       4218 ±  3%  perf-c2c.HITM.remote
     32070 ± 15%     -69.8%       9688 ±  2%  perf-c2c.HITM.total
    191435 ±  7%     +37.3%     262935 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    191435 ±  7%     +37.3%     262935 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
    285707           -72.1%      79601 ± 11%  sched_debug.cpu.nr_switches.avg
    344088 ±  2%     -69.8%     103953 ±  9%  sched_debug.cpu.nr_switches.max
    206926 ±  8%     -73.0%      55912 ± 15%  sched_debug.cpu.nr_switches.min
     26177 ± 10%     -63.9%       9453 ± 10%  sched_debug.cpu.nr_switches.stddev
      5.00 ±  9%     +21.2%       6.06 ±  6%  sched_debug.cpu.nr_uninterruptible.stddev
    497115 ± 40%     -44.8%     274644 ± 44%  numa-meminfo.node0.AnonPages
   2037838 ± 26%     -78.4%     440153 ± 49%  numa-meminfo.node1.Active
   2001934 ± 26%     -79.8%     405182 ± 52%  numa-meminfo.node1.Active(anon)
    527723 ± 38%     +42.4%     751463 ± 16%  numa-meminfo.node1.AnonPages
   3853109 ± 35%     -85.5%     559704 ± 33%  numa-meminfo.node1.FilePages
     93331 ± 18%     -58.7%      38529 ± 22%  numa-meminfo.node1.Mapped
   5189577 ± 27%     -61.5%    1999161 ± 13%  numa-meminfo.node1.MemUsed
   2014284 ± 26%     -78.2%     439808 ± 51%  numa-meminfo.node1.Shmem
    123485 ± 41%     -45.0%      67888 ± 44%  numa-vmstat.node0.nr_anon_pages
    500704 ± 26%     -79.8%     101309 ± 52%  numa-vmstat.node1.nr_active_anon
    131174 ± 38%     +42.6%     187092 ± 16%  numa-vmstat.node1.nr_anon_pages
    963502 ± 35%     -85.5%     139952 ± 33%  numa-vmstat.node1.nr_file_pages
     23724 ± 18%     -59.2%       9690 ± 22%  numa-vmstat.node1.nr_mapped
    503779 ± 26%     -78.2%     109954 ± 51%  numa-vmstat.node1.nr_shmem
    500704 ± 26%     -79.8%     101309 ± 52%  numa-vmstat.node1.nr_zone_active_anon
   3915420 ±  5%     -16.3%    3276906 ±  3%  numa-vmstat.node1.numa_hit
   3830177 ±  5%     -16.2%    3208097 ±  4%  numa-vmstat.node1.numa_local
   2431824           -65.5%     839190 ±  4%  meminfo.Active
   2357128           -67.3%     770208 ±  4%  meminfo.Active(anon)
     74695 ±  3%      -7.6%      68981 ±  2%  meminfo.Active(file)
   5620559           -27.6%    4067556        meminfo.Cached
   3838924           -40.4%    2286726        meminfo.Committed_AS
     25660 ± 19%     +25.8%      32289 ±  5%  meminfo.Inactive(file)
    141631 ±  5%     -32.4%      95728 ±  4%  meminfo.Mapped
   8334057           -18.6%    6783406        meminfo.Memused
   2390655           -64.9%     837973 ±  4%  meminfo.Shmem
   9824314           -15.2%    8328190        meminfo.max_used_kB
      1893            -7.4%       1752        filebench.sum_bytes_mb/s
  45921381            -7.4%   42512980        filebench.sum_operations
    765287            -7.4%     708444        filebench.sum_operations/s
    201392            -7.4%     186432        filebench.sum_reads/s
      0.04          +263.5%       0.14        filebench.sum_time_ms/op
     40278            -7.4%      37286        filebench.sum_writes/s
  48591837            -7.4%   44996528        filebench.time.file_system_outputs
      6443 ±  3%     -88.7%     729.10 ±  4%  filebench.time.involuntary_context_switches
      3556            +1.4%       3605        filebench.time.percent_of_cpu_this_job_got
      5677            +2.1%       5798        filebench.time.system_time
     99.20           -41.4%      58.09 ±  2%  filebench.time.user_time
  37526666           -74.5%    9587296 ±  4%  filebench.time.voluntary_context_switches
    589410           -67.3%     192526 ±  4%  proc-vmstat.nr_active_anon
     18674 ±  3%      -7.6%      17253 ±  2%  proc-vmstat.nr_active_file
   6075100            -7.4%    5625692        proc-vmstat.nr_dirtied
   3065571            +1.3%    3104313        proc-vmstat.nr_dirty_background_threshold
   6138638            +1.3%    6216217        proc-vmstat.nr_dirty_threshold
   1407207           -27.6%    1019126        proc-vmstat.nr_file_pages
  30829764            +1.3%   31217496        proc-vmstat.nr_free_pages
    262267            +3.4%     271067        proc-vmstat.nr_inactive_anon
      6406 ± 19%     +26.1%       8076 ±  5%  proc-vmstat.nr_inactive_file
     35842 ±  5%     -32.2%      24284 ±  4%  proc-vmstat.nr_mapped
    597809           -65.0%     209518 ±  4%  proc-vmstat.nr_shmem
     32422            -3.3%      31365        proc-vmstat.nr_slab_reclaimable
    589410           -67.3%     192526 ±  4%  proc-vmstat.nr_zone_active_anon
     18674 ±  3%      -7.6%      17253 ±  2%  proc-vmstat.nr_zone_active_file
    262267            +3.4%     271067        proc-vmstat.nr_zone_inactive_anon
      6406 ± 19%     +26.1%       8076 ±  5%  proc-vmstat.nr_zone_inactive_file
    100195 ± 10%     -54.0%      46112 ± 10%  proc-vmstat.numa_hint_faults
     48654 ±  9%     -50.1%      24286 ± 13%  proc-vmstat.numa_hint_faults_local
   7506558           -12.4%    6577262        proc-vmstat.numa_hit
   7373151           -12.6%    6444638        proc-vmstat.numa_local
    803560 ±  4%      -6.4%     752097 ±  5%  proc-vmstat.numa_pte_updates
   4259084            -3.8%    4098506        proc-vmstat.pgactivate
   7959837           -11.3%    7064279        proc-vmstat.pgalloc_normal
    870736            -9.4%     789267        proc-vmstat.pgfault
   7181295            -5.6%    6775640        proc-vmstat.pgfree
      1.96 ±  2%     -36.9%       1.23        perf-stat.i.MPKI
 3.723e+09           +69.5%  6.309e+09        perf-stat.i.branch-instructions
      2.70            -0.0        2.66        perf-stat.i.branch-miss-rate%
  16048312           -38.4%    9889213        perf-stat.i.branch-misses
     16.44            -2.0       14.42        perf-stat.i.cache-miss-rate%
  43146188           -47.3%   22744395 ±  2%  perf-stat.i.cache-misses
 1.141e+08           -39.8%   68732731        perf-stat.i.cache-references
    465903           -75.4%     114745 ±  4%  perf-stat.i.context-switches
      4.11           -36.6%       2.61        perf-stat.i.cpi
  1.22e+11            -5.2%  1.157e+11        perf-stat.i.cpu-cycles
    236.15           -18.3%     192.90        perf-stat.i.cpu-migrations
      1997 ±  2%     +40.1%       2798        perf-stat.i.cycles-between-cache-misses
 1.644e+10           +90.3%   3.13e+10        perf-stat.i.instructions
      0.38           +14.7%       0.43        perf-stat.i.ipc
      3.63           -75.7%       0.88 ±  4%  perf-stat.i.metric.K/sec
      4592 ±  2%     -11.6%       4057        perf-stat.i.minor-faults
      4592 ±  2%     -11.6%       4057        perf-stat.i.page-faults
      2.62           -72.3%       0.73 ±  2%  perf-stat.overall.MPKI
      0.43            -0.3        0.16        perf-stat.overall.branch-miss-rate%
     37.79            -4.6       33.22        perf-stat.overall.cache-miss-rate%
      7.41           -50.1%       3.70        perf-stat.overall.cpi
      2827           +80.1%       5092 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.13          +100.5%       0.27        perf-stat.overall.ipc
 3.693e+09           +77.2%  6.544e+09        perf-stat.ps.branch-instructions
  15913729           -36.1%   10173711        perf-stat.ps.branch-misses
  42783592           -44.9%   23577137 ±  2%  perf-stat.ps.cache-misses
 1.132e+08           -37.3%   70963587        perf-stat.ps.cache-references
    461953           -74.2%     118964 ±  4%  perf-stat.ps.context-switches
    234.44           -17.3%     193.77        perf-stat.ps.cpu-migrations
 1.632e+10           +99.0%  3.246e+10        perf-stat.ps.instructions
      4555 ±  2%     -10.9%       4060        perf-stat.ps.minor-faults
      4555 ±  2%     -10.9%       4060        perf-stat.ps.page-faults
 2.659e+12           +99.2%  5.299e+12        perf-stat.total.instructions



[1]

for patch in
https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail.com/

we apply it upon 
  3c999d1ae3 ("Merge tag 'wq-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq")

there is similar regression


=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/webproxy.f/filebench

commit: 
  3c999d1ae3 ("Merge tag 'wq-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq")
  3681ce3644 ("vfs: Delete the associated dentry when deleting a file")

3c999d1ae3c75991 3681ce364442ce2ec7c7fbe90ad 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     31.06            +2.8%      31.94        boot-time.boot
  30573542 ±  2%     -77.0%    7043084 ±  5%  cpuidle..usage
     27.25            +1.3%      27.61        iostat.cpu.system
      0.14            -0.0        0.12        mpstat.cpu.all.irq%
      0.07            -0.0        0.04        mpstat.cpu.all.soft%
      0.56            -0.2        0.34 ±  2%  mpstat.cpu.all.usr%
      0.29 ±100%     -77.4%       0.07 ± 28%  vmstat.procs.b
    448491 ±  2%     -76.3%     106251 ±  5%  vmstat.system.cs
     90174           -36.5%      57279        vmstat.system.in
   3460368 ±  4%     -10.3%    3103696 ±  4%  numa-numastat.node0.local_node
   3522472 ±  4%      -9.2%    3197492 ±  3%  numa-numastat.node0.numa_hit
   3928489 ±  4%     -17.7%    3232163 ±  3%  numa-numastat.node1.local_node
   3998985 ±  3%     -18.2%    3270980 ±  3%  numa-numastat.node1.numa_hit
      1968 ±  5%     -23.2%       1511        perf-c2c.DRAM.local
     16452 ± 22%     -54.2%       7541 ±  4%  perf-c2c.DRAM.remote
     14780 ± 26%     -64.0%       5321 ±  4%  perf-c2c.HITM.local
     10689 ± 24%     -60.1%       4262 ±  5%  perf-c2c.HITM.remote
     25469 ± 25%     -62.4%       9584 ±  4%  perf-c2c.HITM.total
    196899 ± 10%     +31.1%     258125 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    196899 ± 10%     +31.1%     258125 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
    299051 ± 12%     -76.0%      71664 ± 15%  sched_debug.cpu.nr_switches.avg
    355466 ± 11%     -73.4%      94490 ± 14%  sched_debug.cpu.nr_switches.max
    219349 ± 12%     -76.6%      51435 ± 12%  sched_debug.cpu.nr_switches.min
     25523 ± 11%     -67.4%       8322 ± 18%  sched_debug.cpu.nr_switches.stddev
     36526 ±  4%     -16.4%      30519 ±  6%  numa-meminfo.node0.Active(file)
    897165 ± 14%     -26.7%     657740 ±  9%  numa-meminfo.node0.AnonPages.max
     23571 ± 10%     -14.5%      20159 ± 10%  numa-meminfo.node0.Dirty
   2134726 ± 10%     -76.9%     493176 ± 35%  numa-meminfo.node1.Active
   2096208 ± 11%     -78.3%     455673 ± 38%  numa-meminfo.node1.Active(anon)
    965352 ± 13%     +23.5%    1192437 ±  2%  numa-meminfo.node1.AnonPages.max
     18386 ± 17%     +23.8%      22761 ±  4%  numa-meminfo.node1.Inactive(file)
   2108104 ± 11%     -76.7%     492042 ± 37%  numa-meminfo.node1.Shmem
   2395006 ±  2%     -67.4%     779863 ±  3%  meminfo.Active
   2319964 ±  2%     -69.3%     711848 ±  4%  meminfo.Active(anon)
     75041 ±  2%      -9.4%      68015 ±  2%  meminfo.Active(file)
   5583921           -28.3%    4002297        meminfo.Cached
   3802632           -41.5%    2224370        meminfo.Committed_AS
     28940 ±  5%     +13.6%      32890 ±  4%  meminfo.Inactive(file)
    134576 ±  6%     -31.2%      92641 ±  3%  meminfo.Mapped
   8310087           -19.2%    6718172        meminfo.Memused
   2354275 ±  2%     -67.1%     775732 ±  4%  meminfo.Shmem
   9807659           -15.7%    8271698        meminfo.max_used_kB
      1903            -9.3%       1725        filebench.sum_bytes_mb/s
  46168615            -9.4%   41846487        filebench.sum_operations
    769403            -9.4%     697355        filebench.sum_operations/s
    202475            -9.4%     183514        filebench.sum_reads/s
      0.04          +268.3%       0.14        filebench.sum_time_ms/op
     40495            -9.4%      36703        filebench.sum_writes/s
  48846906            -9.3%   44298468        filebench.time.file_system_outputs
      6633           -89.4%     701.33 ±  6%  filebench.time.involuntary_context_switches
      3561            +1.3%       3607        filebench.time.percent_of_cpu_this_job_got
      5686            +2.1%       5804        filebench.time.system_time
     98.62           -44.2%      55.04 ±  2%  filebench.time.user_time
  36939924 ±  2%     -76.6%    8653175 ±  5%  filebench.time.voluntary_context_switches
      9134 ±  4%     -16.5%       7628 ±  6%  numa-vmstat.node0.nr_active_file
   3141362 ±  3%     -11.5%    2780445 ±  4%  numa-vmstat.node0.nr_dirtied
      9134 ±  4%     -16.5%       7628 ±  6%  numa-vmstat.node0.nr_zone_active_file
   3522377 ±  4%      -9.2%    3197360 ±  3%  numa-vmstat.node0.numa_hit
   3460272 ±  4%     -10.3%    3103565 ±  4%  numa-vmstat.node0.numa_local
    524285 ± 11%     -78.3%     113936 ± 38%  numa-vmstat.node1.nr_active_anon
      4630 ± 17%     +22.6%       5674 ±  4%  numa-vmstat.node1.nr_inactive_file
    527242 ± 11%     -76.7%     123018 ± 37%  numa-vmstat.node1.nr_shmem
    524285 ± 11%     -78.3%     113936 ± 38%  numa-vmstat.node1.nr_zone_active_anon
      4630 ± 17%     +22.5%       5674 ±  4%  numa-vmstat.node1.nr_zone_inactive_file
   3998675 ±  3%     -18.2%    3270307 ±  3%  numa-vmstat.node1.numa_hit
   3928179 ±  4%     -17.7%    3231491 ±  3%  numa-vmstat.node1.numa_local
      1.82 ± 18%      -0.5        1.28 ± 16%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      1.58 ±  8%      -0.5        1.13 ± 18%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.53 ±  9%      -0.4        1.13 ± 18%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.05 ±  7%      -0.3        1.76 ± 11%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.balance_fair
      3.80 ±  5%      -0.3        3.52 ±  5%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.11 ± 11%      +0.3        2.39 ±  4%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
      3.55 ± 10%      +0.3        3.86 ±  4%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      2.63 ±  9%      +0.4        3.03 ±  6%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events.cmd_stat
      3.47 ±  2%      -0.6        2.86 ± 10%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      3.30 ±  2%      -0.6        2.73 ± 10%  perf-profile.children.cycles-pp.do_mmap
      3.02 ±  6%      -0.6        2.46 ± 11%  perf-profile.children.cycles-pp.mmap_region
      2.34 ±  8%      -0.6        1.80 ± 12%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      3.80 ±  5%      -0.3        3.52 ±  5%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.29 ±  2%      -0.1        0.17 ± 71%  perf-profile.children.cycles-pp.acpi_evaluate_dsm
      0.29 ±  2%      -0.1        0.17 ± 71%  perf-profile.children.cycles-pp.acpi_evaluate_object
      0.29 ±  2%      -0.1        0.17 ± 71%  perf-profile.children.cycles-pp.acpi_nfit_ctl
      0.29 ±  2%      -0.1        0.17 ± 71%  perf-profile.children.cycles-pp.acpi_nfit_query_poison
      0.29 ±  2%      -0.1        0.17 ± 71%  perf-profile.children.cycles-pp.acpi_nfit_scrub
      0.16 ± 36%      -0.1        0.05 ± 44%  perf-profile.children.cycles-pp._find_first_bit
      0.10 ± 44%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.mtree_load
      0.30 ± 25%      +0.2        0.47 ± 13%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.23 ± 55%      -0.2        0.08 ± 70%  perf-profile.self.cycles-pp.malloc
      0.16 ± 40%      -0.1        0.05 ± 44%  perf-profile.self.cycles-pp._find_first_bit
      0.19 ± 30%      -0.1        0.09 ± 84%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.86 ± 17%      +0.3        1.12 ± 10%  perf-profile.self.cycles-pp.menu_select
    580113 ±  2%     -69.3%     177978 ±  4%  proc-vmstat.nr_active_anon
     18761 ±  2%      -9.3%      17008 ±  2%  proc-vmstat.nr_active_file
   6107024            -9.3%    5538417        proc-vmstat.nr_dirtied
   3066271            +1.3%    3105966        proc-vmstat.nr_dirty_background_threshold
   6140041            +1.3%    6219526        proc-vmstat.nr_dirty_threshold
   1398313           -28.3%    1002802        proc-vmstat.nr_file_pages
  30835864            +1.3%   31234154        proc-vmstat.nr_free_pages
    262597            +2.8%     269986        proc-vmstat.nr_inactive_anon
      7233 ±  5%     +13.4%       8201 ±  4%  proc-vmstat.nr_inactive_file
     34066 ±  6%     -31.1%      23487 ±  3%  proc-vmstat.nr_mapped
    588705 ±  2%     -67.0%     193984 ±  4%  proc-vmstat.nr_shmem
     32476            -3.6%      31292        proc-vmstat.nr_slab_reclaimable
    580113 ±  2%     -69.3%     177978 ±  4%  proc-vmstat.nr_zone_active_anon
     18761 ±  2%      -9.3%      17008 ±  2%  proc-vmstat.nr_zone_active_file
    262597            +2.8%     269986        proc-vmstat.nr_zone_inactive_anon
      7233 ±  5%     +13.4%       8201 ±  4%  proc-vmstat.nr_zone_inactive_file
    148417 ± 19%     -82.3%      26235 ± 17%  proc-vmstat.numa_hint_faults
     76831 ± 23%     -84.5%      11912 ± 33%  proc-vmstat.numa_hint_faults_local
   7524741           -14.0%    6471471        proc-vmstat.numa_hit
   7392150           -14.2%    6338859        proc-vmstat.numa_local
    826291 ±  4%     -12.3%     724471 ±  4%  proc-vmstat.numa_pte_updates
   4284054            -6.1%    4024194        proc-vmstat.pgactivate
   7979760           -12.9%    6948927        proc-vmstat.pgalloc_normal
    917223 ±  2%     -16.2%     768255        proc-vmstat.pgfault
   7212208            -7.4%    6679624        proc-vmstat.pgfree
      1.97           -39.5%       1.19 ±  2%  perf-stat.i.MPKI
 3.749e+09           +65.2%  6.195e+09        perf-stat.i.branch-instructions
      2.69            -0.0        2.65        perf-stat.i.branch-miss-rate%
  15906654           -39.7%    9595633        perf-stat.i.branch-misses
     16.53            -2.2       14.37        perf-stat.i.cache-miss-rate%
  43138175           -48.8%   22080984 ±  2%  perf-stat.i.cache-misses
 1.137e+08           -41.1%   67035007 ±  2%  perf-stat.i.cache-references
    458704 ±  2%     -77.4%     103593 ±  6%  perf-stat.i.context-switches
      4.04           -39.3%       2.45        perf-stat.i.cpi
 1.221e+11            -5.4%  1.155e+11        perf-stat.i.cpu-cycles
    238.75           -19.5%     192.29        perf-stat.i.cpu-migrations
      1960           +45.0%       2843 ±  2%  perf-stat.i.cycles-between-cache-misses
 1.678e+10          +103.7%  3.419e+10        perf-stat.i.instructions
      0.39           +17.5%       0.46        perf-stat.i.ipc
      3.58 ±  2%     -77.8%       0.80 ±  6%  perf-stat.i.metric.K/sec
      4918 ±  3%     -19.9%       3940        perf-stat.i.minor-faults
      4918 ±  3%     -19.9%       3940        perf-stat.i.page-faults
      2.57           -74.9%       0.65 ±  2%  perf-stat.overall.MPKI
      0.42            -0.3        0.15        perf-stat.overall.branch-miss-rate%
     37.92            -4.8       33.07        perf-stat.overall.cache-miss-rate%
      7.27           -53.5%       3.38        perf-stat.overall.cpi
      2830           +85.1%       5239 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.14          +115.0%       0.30        perf-stat.overall.ipc
  3.72e+09           +72.8%  6.428e+09        perf-stat.ps.branch-instructions
  15775403           -37.5%    9854215        perf-stat.ps.branch-misses
  42773264           -46.5%   22897139 ±  2%  perf-stat.ps.cache-misses
 1.128e+08           -38.6%   69221969 ±  2%  perf-stat.ps.cache-references
    454754 ±  2%     -76.4%     107434 ±  6%  perf-stat.ps.context-switches
    237.02           -18.5%     193.17        perf-stat.ps.cpu-migrations
 1.666e+10          +113.0%  3.548e+10        perf-stat.ps.instructions
      4878 ±  3%     -19.3%       3937        perf-stat.ps.minor-faults
      4878 ±  3%     -19.3%       3937        perf-stat.ps.page-faults
 2.715e+12          +113.5%  5.796e+12        perf-stat.total.instructions


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


