Return-Path: <linux-fsdevel+bounces-38799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF8A085C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662C43A8AE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65D61E3761;
	Fri, 10 Jan 2025 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pqsq+g4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8B1E25FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478659; cv=fail; b=BcIMo0r5cvY5zbVmW/98c1zHq+EYC1J6cc62KCiuox24p8m0owYhF8gWwKMx+lYqBopVcPgicrK7JdCVJ7K0J2JYlvlMbfvOFOR7HmPsm2+8VjqL7jgJWw6TJqe5xpoNLOPhE1XvZBT+jOhocr4ptu5uAGpyp4h14snyPaaM37A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478659; c=relaxed/simple;
	bh=+n0yb78l3Ao6HyA1pKp6U5iaB/StEuztjU0GVgK3kpk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Hf+fr3YvzgbQVJq0u36XqSuCBOyLo5Xq1giutl233WsXFBNFRNqj3jjW42XJGSHz8H8UF8SiAIcUYYCfY2jMU4Y20Du2HRyXZJXynh2p0qHW2gJV4vohJKdYvyz8TqdC+MEyYR3IjJgraDAKe3Z1k9/jxHPm56M/A8CV4zbFK3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pqsq+g4R; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736478655; x=1768014655;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=+n0yb78l3Ao6HyA1pKp6U5iaB/StEuztjU0GVgK3kpk=;
  b=Pqsq+g4R07G5qsVnvzcJMZFWLSUae2KKfPg+vYSlj51Dpj6LyAyz91nx
   o63Za1p9p13DL15sy0J3TT9pMjjAdrPpTuRitdIBkq7wOtiEil2hpAPLs
   wxqUtlugnDWNk9Kcj0mtyHrIASbHnJiHeSee6gpav/HH8/dG/0qiiPvyw
   pdTcR8nsL9i6zC5fo3TMjOmdM9rKgLGEynMDYX9NxiTdiGEtmZjyhDhUa
   MG4kPtOUTQ1QJVGdhrMGhco8NivQhR/UG70y0YLGfZ3oaXmxP4OjSemP/
   KccuaDdtMJ2dsbuYvMAlNQO8ZnJ3glHoPZbdYINDz/NpQQty4pvdJVXfM
   g==;
X-CSE-ConnectionGUID: omsIISRKQdSGDy2W2tfgfA==
X-CSE-MsgGUID: VLzSmGcCQ/+7XZrq3QGtwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="62136206"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="62136206"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 19:10:53 -0800
X-CSE-ConnectionGUID: V6B3UPMMQXuMSkCI0pWnbg==
X-CSE-MsgGUID: +AqOnraMSxeG06EosvGenA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104131656"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 19:10:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 19:10:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 19:10:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 19:10:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjKWbGLb8T6Y4UDgt0yuX34wA3HdexwaYNMcF94bukJjfOvSbo0KEn1z7pb7MI0B4PXHkyYVC3kj6fRuKBg7IXC4cDF7Ov78+POpemV6LUNLphjliyb1ZnOxPbYgewKYLjkg1tPUyAGX1L2EN2rRnv4XVP0Nzspp3lbWi+mHi5+wFay+xEbBL81AJpHetTj78pid3F4JNEQN7SZaMcpCbt5Uef26QIq0HRhip1HLiMUIrgVSWb+eePloPjserDQyHFFALVHKuVOBUQVUViBIB7R5DzMm9zjPSyrKEhFdJHcENG9m11s4sMZWMR+w+O7pgkfxgs90xbDvVDLN/rdYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbWRc3J7E/rXEAvcq9eBO9I7LW4mtDcrEVVw7/xxjQU=;
 b=sFVeA+Cgs/9gNgCnUfyci/55JtyuJt+HNi6vHzUIL3aenDA/30bgJbsmn8tQz3ZKN/cYajFVDxj+nES9j6Tnm9SboeulBzncSY0fFcPdd4T5H+TFtWI6/P/uyOukzhh2LTWJB+86ZPvoBMK06xqxhEFVwIIxBvAjRURDToMwKVAzWPMuAdKfQApT7VPQTlOpYfQ5F4WuhTpYaKxuryvQbNMZ82Q/cZplXtFR/xaW6OKfRV+WTvyI9viasjTZzSh2Q/VaVfCrgSRcospZky7mVjVPmB3IXIR3NIYN2V6LGuXtM6BvFqZKFpMvGgS5FBrKgV2Uroxa6U9mIPzaLhxLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 03:10:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 03:10:01 +0000
Date: Fri, 10 Jan 2025 11:09:51 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>,
	WangYuli <wangyuli@uniontech.com>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [brauner-vfs:vfs-6.14.misc] [pipe_read]  aaec5a95d5:
 hackbench.throughput 7.5% regression
Message-ID: <202501101015.90874b3a-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b2d772-36c8-4116-de9d-08dd3124458d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?3A0liFEQYhOn9cEE4N4qHPUdXh61SFcQevhgr0w7bmjtAtugPoHDtO5A5S?=
 =?iso-8859-1?Q?/b3kNcOMK6p/AGw87N1rVAoBpIRAnNp9Pr3s0RSq7MVDOPTSxzlmL97KzH?=
 =?iso-8859-1?Q?v2auL6D9PpAudyT8ENbq3ONmWGMQ4qCxc+d49q/1/Rl2dk+RfHG8YzWuvX?=
 =?iso-8859-1?Q?iO6HoRkquew66Lz5oIUSqduSMDLN6PysaIs/I9+uLhC7qM6H25Jx1GulxF?=
 =?iso-8859-1?Q?6FsSMkMNUYwvaTSmlnSzDHU0HCMM/fKkf1N6pFbFWx9NGhQFvajuvP+Rlt?=
 =?iso-8859-1?Q?Flf2l+RDgR5hiZAD19ahulF7z02p458utAQG3GdW/hPfqCd/j3pCiYGUae?=
 =?iso-8859-1?Q?rAvqqdjeeDnV4/xAqQ24x09gS6BOrrsRrtogUc1fuvc3MRYzaNmMGKuZkQ?=
 =?iso-8859-1?Q?ebL7qSThyqXmAmo1OqrcrWI8FaGQIEVvOwX7YIq2RsJ5xQHYOr3RfvUzIA?=
 =?iso-8859-1?Q?E8nwOERJcvLCWFPqSzCjWAdfDuBA/eIz7095jtWxfH9400OV1CkLkc7BxR?=
 =?iso-8859-1?Q?aLdRGkImskX7TQ6fuCEPTopOkSVY9yLv1oGpe2WlGeDgpSff8mRNMTZNFU?=
 =?iso-8859-1?Q?PMd00lykNTE5fCmyILL+uy0Mx//9obZKQIV3M9UNV2JSt4iSYDNxLJh2mX?=
 =?iso-8859-1?Q?GxhN1r3HQOJhXQElfUGziAZDFwX2HzlQYoA1nWzfa96CeaJH0BGgFjzTFg?=
 =?iso-8859-1?Q?qT3YsEyDQcJhzeYp1UlavsmwqySueMJPFjQPhFKlGzkz2PEvFhBefTYB49?=
 =?iso-8859-1?Q?bun+E68hUSGdGx1JXaA6PdnUcD9FFnPj/+A6T34PKMofH1zVdQomt5kSnb?=
 =?iso-8859-1?Q?/YXSojmW/I+gbCn4jhBwpYVFHBy9onMO2yd7TVES5Y23pMvbtoAE/Z0ww3?=
 =?iso-8859-1?Q?7bKe+WJUn0z2t6PbVQrC+q8PExXrLp33b799nw+0Lhzf7BVMjWOcejntdH?=
 =?iso-8859-1?Q?/mQ3xinpxOWk+RWbzTTLRcUdd9wdlhi13Iry6XYov9xSHBuCXB6t725MDG?=
 =?iso-8859-1?Q?pz2pcPSly+8mHgZHsgkRMefhqFlQJK7N1+8WUHW2vvgn2/SDUhJWBGSqFD?=
 =?iso-8859-1?Q?Kg/tiKcEJwad5KelH/Tvr/gufWLsoUF+Dda/6obOuyTRmbKTCau3EYAx1O?=
 =?iso-8859-1?Q?1uCJ5NWItSj2VLTuBZyEBRG9gddaVNqdI3fCyjPZ9uCCZEZOXN4JS/pIg+?=
 =?iso-8859-1?Q?U6AgYibIl7WIDb+IqcLTczPninzYUwYVS599aNrmS6DZKt119RHBN5Kx39?=
 =?iso-8859-1?Q?TIjoHYAFvBuITFdoB6aHcZRctygJVO9gjYpPqZC+v3KXlhjSp+qYpkbuFb?=
 =?iso-8859-1?Q?tjFyG8bJUVGVpqTXG7L3JQ83K1Zziv12qZa0PUXaT4FaGnMEVORCDM1e6F?=
 =?iso-8859-1?Q?R8gTSiqhCO8uG3uIc53cyZEVnEUrZC7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n5GV9OM/XKUvLhKnIhjgvkqowyfXWXpMca+unmBXZ/LMAS7s/im9BU3gif?=
 =?iso-8859-1?Q?S+qj+18zdGo7hqyP9dvIra7TP9eMR5yL9JGITSDYOMe6htK5OKTPJwc90x?=
 =?iso-8859-1?Q?AkA+cwvEmfY7zUhUv33jqVkm47D4j+ownpyXl+ogCtdr8qCSzrOpormFLm?=
 =?iso-8859-1?Q?2PlrvHRlkK6dKnlm2+9GQzhJBLz/iAhGYPRZkPDUp97RDzjJBE8hDj6Kmf?=
 =?iso-8859-1?Q?KftPlnstjX0B2aDS2VfvVdXg7OxU/Y0iurmlAWKGK3fME38gkEYQALI3xp?=
 =?iso-8859-1?Q?mC2Nj6zCQoNUCFanq0ydxSEEE3I1rH8Vc9/ikgkkifmxT7XBZ+5TuPEISe?=
 =?iso-8859-1?Q?f2SufYTioc+K1VEtBZY+yHJyqVQ+Yn3MDJeiwUazAgiaq+O8SaighNdSM+?=
 =?iso-8859-1?Q?bfM33gz4DymXImjNjiMzcGWiv/Fa/jIoRMYJiTu53G+ErqGyj7iYGPl8Hl?=
 =?iso-8859-1?Q?6x5/0AXZQ8Unh3AcM511tMM44QMGKzBiHaZPaHH8nf/IbsAF1Gb19hFnE0?=
 =?iso-8859-1?Q?Ze5SQcRmylzcMax3Ewtmmp6gpBU9R3Rfh7vKBuj/ggh6HdT4n7mRcl4VIM?=
 =?iso-8859-1?Q?cK8yC+W4K5ta1N9xgplXpovBWWgug5zDax96f2TzNhi6Q3BpHU4JIzma2b?=
 =?iso-8859-1?Q?/WMRmVLvMGYUrArikehBvBtTG9AyhjtlaogqlGw1tKuecBl+ntflq3JmLv?=
 =?iso-8859-1?Q?sft0D9QtEBlCq4BkLV7/1dYyuuyi6Ii7aEUYcoUg/oJumUZjg/bZl55R49?=
 =?iso-8859-1?Q?cNSRuR7lYLblgUXOIL5ZR4+/Kpa5ojXg7nSvRfZs5fli3e7BDsBFph281P?=
 =?iso-8859-1?Q?8f19SvVU+C3LA4284jfVj10ArFf9usk+A9nYQ7mXXUu/s/cYmUQ51gp9h3?=
 =?iso-8859-1?Q?/D96rLQNLFcSdC5UOF1n04QlyNfPxluAZHpNhZht0XMN/D7gaQQ669831F?=
 =?iso-8859-1?Q?KT7Nskp0emBBE4sAuoyItrVQ1v50fqd9IuOSZYgyn0/BJQYYmgbUApxnvr?=
 =?iso-8859-1?Q?5qNnIZMiN3st7WAuoJDXunDM4ja4xtSP2DSVw2dRyp9esBVXPnt0W3EgRO?=
 =?iso-8859-1?Q?0ek+18VXSgiWNkLWUCuGI9qDk4sDoYJbGijd1+UeBAcTba30tWiAHTM8eI?=
 =?iso-8859-1?Q?xwTKRMcagXP62jrp5ke4E7ZZAW76dxJjF3GCuF6F/6lnr40uPKGdacu2B1?=
 =?iso-8859-1?Q?Qx9z7qvnC2doGegMdfz35l6P/I4nlzhUFQYK/yGq7MrwiVvEzEvZdVUvVq?=
 =?iso-8859-1?Q?x5mHd/7nBi9UrVg2ZQjdCwGVoMmeYX9It2c5ahCI0IU5P43kKdKKqsgLHH?=
 =?iso-8859-1?Q?V33NPwa3b0HsOKx7ZFFyG4OCf9U5sM8n/PdPzQ46RqFvpAiTsZcDFGoV6Y?=
 =?iso-8859-1?Q?IWO2KXrZhobEUry/XZ4IYVoCVSZBtUhITTDoNAhhIE7EP2SVC0EarZ5zNg?=
 =?iso-8859-1?Q?veNCDKqeAbRAP6cKO7yGbFLNFmj+GuAYlVZv6RUPdgy4dkvodAjJ3iXi+a?=
 =?iso-8859-1?Q?MjLAlh4tZebJCZi0c2RRj+XQo+qWeNSioPn5FiunGo3sSJrJH7FOe+v0un?=
 =?iso-8859-1?Q?rHFOYnkxvvBqR4ciQpkjXG0zpYewfcknPbDVA62I2bZ39LhpNuvphCk5i3?=
 =?iso-8859-1?Q?cl/VCyGX30j3gM3inJSjIA3XPZQQnIM3lWwv9vwNbbDWCjzgmsbhM+3A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b2d772-36c8-4116-de9d-08dd3124458d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 03:10:01.8468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpSEFFa6DgF57wzgwzMcv/JeOdO2si7sVilC/NWzv66AvqINJZA9eEGCtkQwFigkjWrQuIRir7zts3yydTPinA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 7.5% regression of hackbench.throughput on:


commit: aaec5a95d59615523db03dd53c2052f0a87beea7 ("pipe_read: don't wake up the writer if the pipe is still full")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs-6.14.misc

[test failed on linux-next/master 4b90165c7d1173e0f65538d25aa718ec7ecdd5d6]

testcase: hackbench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 50%
	iterations: 4
	mode: process
	ipc: pipe
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.tee.ops_per_sec 500.7% improvement                                   |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=tee                                                                                  |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501101015.90874b3a-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250110/202501101015.90874b3a-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/pipe/4/x86_64-rhel-9.4/process/50%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/hackbench

commit: 
  d2fc0ed52a ("Merge branch 'vfs-6.14.uncached_buffered_io'")
  aaec5a95d5 ("pipe_read: don't wake up the writer if the pipe is still full")

d2fc0ed52a284a13 aaec5a95d59615523db03dd53c2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.04 ±  2%      -0.0        0.03 ±  6%  mpstat.cpu.all.soft%
     13470 ± 44%     +47.4%      19860 ± 22%  numa-vmstat.node1.nr_slab_reclaimable
     53825 ± 44%     +47.6%      79444 ± 22%  numa-meminfo.node1.KReclaimable
     53825 ± 44%     +47.6%      79444 ± 22%  numa-meminfo.node1.SReclaimable
      1423           -14.8%       1212 ±  2%  vmstat.procs.r
   1419871 ±  3%     +22.4%    1737760 ±  2%  vmstat.system.in
     28551 ± 13%     -37.8%      17760 ±  8%  perf-c2c.DRAM.remote
    122888 ±  7%     +55.5%     191041 ±  2%  perf-c2c.HITM.local
      4310 ± 13%     -20.0%       3448 ±  9%  perf-c2c.HITM.remote
    127198 ±  7%     +52.9%     194489 ±  2%  perf-c2c.HITM.total
    903976            -7.5%     836425        hackbench.throughput
    866824            -7.6%     801128        hackbench.throughput_avg
    903976            -7.5%     836425        hackbench.throughput_best
    785145            -6.8%     731474        hackbench.throughput_worst
     69.85            +8.1%      75.53        hackbench.time.elapsed_time
     69.85            +8.1%      75.53        hackbench.time.elapsed_time.max
 1.986e+08           +22.1%  2.424e+08        hackbench.time.involuntary_context_switches
      7559            +9.7%       8296        hackbench.time.system_time
    985.62            +4.1%       1026        hackbench.time.user_time
      6.06 ±  4%     -16.2%       5.08 ±  2%  sched_debug.cfs_rq:/.h_nr_running.avg
     14.20 ± 13%     -19.0%      11.50 ±  4%  sched_debug.cfs_rq:/.h_nr_running.max
      3.32 ±  3%     -18.4%       2.71 ±  2%  sched_debug.cfs_rq:/.h_nr_running.stddev
      5996 ±  2%     +34.3%       8054 ± 23%  sched_debug.cfs_rq:/.load.avg
     24211 ±  8%   +1091.3%     288431 ± 88%  sched_debug.cfs_rq:/.load.max
      4439 ±  3%    +504.9%      26851 ± 81%  sched_debug.cfs_rq:/.load.stddev
      1.00 ± 54%     +83.3%       1.83 ± 12%  sched_debug.cfs_rq:/.load_avg.min
      6203 ±  2%     -15.4%       5246 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      1886 ±  7%     -22.5%       1461 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
    151.50 ± 28%     +55.7%     235.83 ± 11%  sched_debug.cfs_rq:/.util_avg.min
    667.32 ±  3%     -21.3%     525.24 ±  8%  sched_debug.cfs_rq:/.util_est.avg
      6.06 ±  4%     -16.1%       5.09 ±  2%  sched_debug.cpu.nr_running.avg
     14.20 ± 13%     -19.0%      11.50 ±  4%  sched_debug.cpu.nr_running.max
      3.30 ±  4%     -18.7%       2.68 ±  2%  sched_debug.cpu.nr_running.stddev
    130727 ± 33%     -46.7%      69684 ± 27%  sched_debug.cpu.nr_switches.stddev
      6.98 ± 11%      -2.4        4.61 ± 24%  perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      6.98 ± 11%      -2.4        4.61 ± 24%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.67 ± 11%      -2.1        4.61 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn
      6.67 ± 11%      -2.1        4.61 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn.perf_mmap__push
      6.67 ± 11%      -2.1        4.61 ± 24%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen
      3.02 ± 44%      -1.9        1.09 ± 47%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      6.67 ± 11%      -1.8        4.86 ± 17%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      6.67 ± 11%      -1.8        4.86 ± 17%  perf-profile.calltrace.cycles-pp.write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      6.67 ± 11%      -1.8        4.86 ± 17%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      2.72 ± 21%      -1.2        1.50 ± 57%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.17 ±122%      +2.5        3.65 ± 43%  perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.81 ± 62%      +2.8        4.59 ± 21%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.52 ± 65%      +3.1        4.63 ± 39%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.52 ± 65%      +3.1        4.63 ± 39%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.98 ± 11%      -2.4        4.61 ± 24%  perf-profile.children.cycles-pp.generic_perform_write
      6.98 ± 11%      -2.4        4.61 ± 24%  perf-profile.children.cycles-pp.shmem_file_write_iter
      3.93 ± 39%      -2.2        1.75 ± 66%  perf-profile.children.cycles-pp.mutex_unlock
      6.67 ± 11%      -1.8        4.86 ± 17%  perf-profile.children.cycles-pp.record__pushfn
      6.67 ± 11%      -1.4        5.30 ± 11%  perf-profile.children.cycles-pp.writen
      2.72 ± 21%      -1.2        1.50 ± 57%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      2.72 ± 21%      -1.2        1.50 ± 57%  perf-profile.children.cycles-pp.fault_in_readable
      1.17 ±122%      +2.5        3.65 ± 43%  perf-profile.children.cycles-pp.do_pte_missing
 6.169e+10            -6.4%  5.773e+10        perf-stat.i.branch-instructions
 2.704e+08            -3.6%  2.607e+08        perf-stat.i.branch-misses
     13.54 ± 10%      -4.4        9.18 ±  2%  perf-stat.i.cache-miss-rate%
 1.343e+09 ±  9%     +40.2%  1.883e+09 ±  3%  perf-stat.i.cache-references
  12981250 ±  2%      -2.9%   12601747        perf-stat.i.context-switches
      1.18            +7.0%       1.26        perf-stat.i.cpi
    656622 ±  3%     +43.2%     940118        perf-stat.i.cpu-migrations
 2.674e+11            -6.3%  2.506e+11        perf-stat.i.instructions
      0.85            -6.3%       0.80        perf-stat.i.ipc
     13648 ±  2%      -7.1%      12676 ±  3%  perf-stat.i.minor-faults
     13650 ±  2%      -7.1%      12677 ±  3%  perf-stat.i.page-faults
      0.44            +0.0        0.45        perf-stat.overall.branch-miss-rate%
     13.19 ± 10%      -4.3        8.94 ±  3%  perf-stat.overall.cache-miss-rate%
      1.18            +7.3%       1.26        perf-stat.overall.cpi
      0.85            -6.8%       0.79        perf-stat.overall.ipc
 6.089e+10            -6.3%  5.703e+10        perf-stat.ps.branch-instructions
 2.666e+08            -3.5%  2.572e+08        perf-stat.ps.branch-misses
 1.324e+09 ±  9%     +40.3%  1.858e+09 ±  3%  perf-stat.ps.cache-references
  12791040 ±  2%      -2.8%   12432936        perf-stat.ps.context-switches
    646715 ±  3%     +43.3%     926916        perf-stat.ps.cpu-migrations
  2.64e+11            -6.2%  2.476e+11        perf-stat.ps.instructions
     13461 ±  2%      -7.7%      12426 ±  3%  perf-stat.ps.minor-faults
     13463 ±  2%      -7.7%      12427 ±  3%  perf-stat.ps.page-faults
      3.22 ± 92%    +235.4%      10.78 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
      0.24 ±100%     -84.4%       0.04 ±102%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.08 ± 90%     -88.4%       0.01 ±112%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
     10.19 ±196%     -99.8%       0.02 ±134%  perf-sched.sch_delay.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      2.47 ±196%     -99.8%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.10 ± 45%     -83.6%       0.02 ±153%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.09 ± 86%     -92.9%       0.01 ±172%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      7.03 ± 19%    +243.1%      24.13 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      5.62 ±195%     -99.6%       0.02 ± 92%  perf-sched.sch_delay.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     15.78 ± 28%    +338.0%      69.12 ± 19%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.99 ± 19%     +59.4%       1.57 ± 12%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.84 ± 20%    +945.2%      61.00 ± 11%  perf-sched.sch_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     15.78 ± 21%    +208.2%      48.63 ± 11%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     12.67 ± 71%    +452.9%      70.03 ± 81%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.22 ± 17%    +252.3%       4.30 ± 11%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.12 ± 83%    +577.2%       0.83 ± 61%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.20 ±104%     -94.9%       0.01 ±115%  perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
     20.36 ±196%     -99.9%       0.02 ±129%  perf-sched.sch_delay.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      2.48 ±195%     -99.7%       0.01 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.28 ± 88%     -89.8%       0.03 ±148%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.14 ±105%     -95.5%       0.01 ±172%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      1095 ± 14%    +118.2%       2389 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
     16.66 ±198%     -99.7%       0.05 ±104%  perf-sched.sch_delay.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
    797.45 ± 24%    +149.6%       1990 ± 17%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1768 ± 22%     +94.8%       3445 ± 11%  perf-sched.sch_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    746.96 ± 15%    +265.4%       2729 ± 21%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.01 ± 15%     -33.9%       0.01 ± 45%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1716 ± 29%    +121.7%       3804 ± 17%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.54 ±107%    +338.8%       2.37 ± 51%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.41 ± 19%     +78.0%       2.51 ± 11%  perf-sched.total_sch_delay.average.ms
      2305 ± 20%     +82.3%       4203 ± 11%  perf-sched.total_sch_delay.max.ms
      4.38 ± 18%     +68.2%       7.37 ± 11%  perf-sched.total_wait_and_delay.average.ms
   4583511 ± 23%     -32.5%    3091848 ± 17%  perf-sched.total_wait_and_delay.count.ms
      5607 ± 10%     +48.2%       8309 ±  8%  perf-sched.total_wait_and_delay.max.ms
      2.97 ± 18%     +63.5%       4.86 ± 11%  perf-sched.total_wait_time.average.ms
      5092 ±  4%     +13.9%       5800 ±  6%  perf-sched.total_wait_time.max.ms
     11.10 ± 59%    +210.8%      34.49 ± 24%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
     21.29 ± 17%    +235.3%      71.40 ± 12%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
    110.43 ± 47%    +250.5%     387.09 ± 45%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.98 ± 24%    +319.4%     205.43 ± 16%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      2.87 ± 19%     +56.2%       4.48 ± 11%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     19.17 ± 20%    +835.0%     179.22 ± 10%  perf-sched.wait_and_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     48.33 ± 24%    +209.7%     149.70 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     38.33 ± 45%    +401.4%     192.16 ± 68%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.58 ± 17%    +253.9%      12.65 ± 11%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     56.40 ± 39%     -72.8%      15.33 ± 46%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    785.60 ± 53%     -49.5%     396.83 ± 49%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    356336 ± 23%     -93.6%      22658 ± 16%  perf-sched.wait_and_delay.count.pipe_write.vfs_write.ksys_write.do_syscall_64
    203.40 ± 27%     -71.1%      58.83 ± 63%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    779.32 ± 74%    +132.5%       1812 ± 26%  perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
      2209 ± 14%    +116.3%       4779 ± 15%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      1679 ± 22%    +139.3%       4019 ± 18%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      3543 ± 22%     +98.8%       7042 ± 10%  perf-sched.wait_and_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      1595 ± 26%    +243.1%       5471 ± 21%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      5048 ±  4%     +12.6%       5685 ±  6%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4052 ± 22%     +88.2%       7626 ± 17%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.88 ± 48%    +200.8%      23.70 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
      0.24 ±100%     -84.4%       0.04 ±102%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      6.22 ± 65%    +237.5%      21.00 ± 59%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_write
      0.08 ± 90%     -88.4%       0.01 ±112%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
     18.06 ± 14%     +43.8%      25.98 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     10.19 ±196%     -99.8%       0.02 ±134%  perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      2.47 ±196%     -99.8%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.10 ± 45%     -83.5%       0.02 ±153%  perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.09 ± 86%     -92.9%       0.01 ±172%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     14.26 ± 16%    +231.5%      47.27 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      6.86 ±196%     -99.6%       0.02 ± 92%  perf-sched.wait_time.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      2.44 ± 44%    +137.1%       5.78 ± 46%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.20 ± 23%    +310.5%     136.31 ± 16%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1.88 ± 19%     +54.5%       2.91 ± 11%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     13.33 ± 21%    +786.7%     118.22 ± 10%  perf-sched.wait_time.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     32.55 ± 25%    +210.5%     101.07 ± 12%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     25.66 ± 34%    +375.9%     122.14 ± 60%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.35 ± 18%    +254.7%       8.35 ± 11%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ± 84%    +731.0%       0.70 ± 43%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    502.86 ± 46%    +115.0%       1081 ± 38%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
    188.34 ±175%     -97.8%       4.23 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.20 ±104%     -94.9%       0.01 ±115%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
     20.36 ±196%     -99.9%       0.02 ±129%  perf-sched.wait_time.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      2.48 ±195%     -99.7%       0.01 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.28 ± 88%     -89.8%       0.03 ±148%  perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.14 ±105%     -95.5%       0.01 ±172%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      1126 ± 15%    +132.8%       2622 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
     20.38 ±198%     -99.8%       0.05 ±104%  perf-sched.wait_time.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
    951.43 ± 18%    +142.5%       2307 ± 15%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1820 ± 24%    +107.0%       3767 ±  7%  perf-sched.wait_time.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    994.33 ± 39%    +179.3%       2776 ± 19%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
    921.59 ± 39%     +70.0%       1566 ± 29%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5048 ±  4%     +12.6%       5685 ±  6%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2400 ± 36%     +64.8%       3954 ± 12%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.42 ±103%    +470.3%       2.37 ± 50%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/tee/stress-ng/60s

commit: 
  d2fc0ed52a ("Merge branch 'vfs-6.14.uncached_buffered_io'")
  aaec5a95d5 ("pipe_read: don't wake up the writer if the pipe is still full")

d2fc0ed52a284a13 aaec5a95d59615523db03dd53c2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    123346 ± 30%     -48.2%      63936 ± 24%  cpuidle..usage
     11.44            +5.9       17.37        mpstat.cpu.all.usr%
      1237 ± 32%     -83.3%     206.40 ± 20%  perf-c2c.DRAM.local
    934.33 ±  7%     +53.9%       1438 ± 10%  perf-c2c.DRAM.remote
    263.67 ± 11%     +26.7%     334.00 ±  5%  perf-c2c.HITM.remote
     11.14           +51.4%      16.87        vmstat.cpu.us
  22963300           -95.8%     968409        vmstat.system.cs
    197683            -8.3%     181346        vmstat.system.in
   5623585 ± 19%     -55.7%    2490490 ± 19%  numa-meminfo.node1.Active
   5623585 ± 19%     -55.7%    2490490 ± 19%  numa-meminfo.node1.Active(anon)
   1738706 ±  8%     -70.3%     516074 ± 29%  numa-meminfo.node1.Mapped
   5336025 ± 20%     -61.3%    2063073 ± 14%  numa-meminfo.node1.Shmem
   7701721           +79.2%   13801344        numa-numastat.node0.local_node
   7732133           +79.0%   13842144        numa-numastat.node0.numa_hit
   9660861 ±  4%     +51.6%   14643708        numa-numastat.node1.local_node
   9696676 ±  4%     +51.3%   14669530        numa-numastat.node1.numa_hit
   4203288          +500.7%   25250189        stress-ng.tee.ops
     70053          +500.7%     420829        stress-ng.tee.ops_per_sec
 7.264e+08           -96.5%   25607922        stress-ng.time.involuntary_context_switches
      3392            -7.6%       3134        stress-ng.time.system_time
    356.72           +78.5%     636.76        stress-ng.time.user_time
  7.31e+08           -95.1%   35783971        stress-ng.time.voluntary_context_switches
   7716552           +79.4%   13841559        numa-vmstat.node0.numa_hit
   7686141           +79.6%   13800760        numa-vmstat.node0.numa_local
   1403134 ± 19%     -55.6%     622772 ± 19%  numa-vmstat.node1.nr_active_anon
    432841 ±  7%     -69.9%     130433 ± 27%  numa-vmstat.node1.nr_mapped
   1331229 ± 19%     -61.3%     515736 ± 14%  numa-vmstat.node1.nr_shmem
   1403134 ± 19%     -55.6%     622771 ± 19%  numa-vmstat.node1.nr_zone_active_anon
   9682370 ±  3%     +51.5%   14668660        numa-vmstat.node1.numa_hit
   9646555 ±  4%     +51.8%   14642837        numa-vmstat.node1.numa_local
   6151580 ± 17%     -51.1%    3005085 ±  4%  meminfo.Active
   6151580 ± 17%     -51.1%    3005085 ±  4%  meminfo.Active(anon)
   8920705 ± 11%     -35.0%    5794702        meminfo.Cached
   7882102 ± 13%     -40.6%    4678787        meminfo.Committed_AS
   1893975 ±  6%     -63.9%     682914 ± 24%  meminfo.Mapped
  11167190 ±  9%     -28.6%    7968104        meminfo.Memused
     27261 ±  2%     -13.4%      23618 ±  6%  meminfo.PageTables
   5395896 ± 19%     -57.9%    2269891        meminfo.Shmem
  11232918 ±  9%     -27.7%    8115848        meminfo.max_used_kB
      0.55 ±  5%     -24.7%       0.42 ±  4%  sched_debug.cfs_rq:/.h_nr_running.stddev
    267.15 ± 77%     -71.5%      76.26 ± 16%  sched_debug.cfs_rq:/.load_avg.avg
     10410 ±122%     -93.8%     641.30 ± 33%  sched_debug.cfs_rq:/.load_avg.max
      1371 ±112%     -88.1%     163.88 ± 10%  sched_debug.cfs_rq:/.load_avg.stddev
    833.50 ± 23%     +24.0%       1033        sched_debug.cfs_rq:/.runnable_avg.min
    247.56 ± 10%     -14.6%     211.50 ± 12%  sched_debug.cfs_rq:/.runnable_avg.stddev
    485.86 ±  5%     +30.5%     633.96 ±  5%  sched_debug.cfs_rq:/.util_est.avg
      1085 ±  5%     +16.3%       1262 ±  9%  sched_debug.cfs_rq:/.util_est.max
    173.70 ±  7%     +36.8%     237.65 ±  6%  sched_debug.cfs_rq:/.util_est.stddev
    398375 ±  4%     +12.5%     448175 ±  2%  sched_debug.cpu.avg_idle.avg
    176609 ± 11%     +38.4%     244462 ±  5%  sched_debug.cpu.avg_idle.stddev
      0.55 ±  5%     -22.3%       0.43 ±  3%  sched_debug.cpu.nr_running.stddev
  11181287           -95.8%     474442        sched_debug.cpu.nr_switches.avg
  11740535           -95.7%     505782 ±  2%  sched_debug.cpu.nr_switches.max
   8593260 ±  5%     -95.1%     424452 ±  4%  sched_debug.cpu.nr_switches.min
    569340 ± 10%     -97.7%      12920 ± 14%  sched_debug.cpu.nr_switches.stddev
   1537988 ± 17%     -51.2%     751031 ±  3%  proc-vmstat.nr_active_anon
   6276579            +1.3%    6356360        proc-vmstat.nr_dirty_background_threshold
  12568504            +1.3%   12728261        proc-vmstat.nr_dirty_threshold
   2230307 ± 11%     -35.1%    1448223        proc-vmstat.nr_file_pages
  63142546            +1.3%   63941500        proc-vmstat.nr_free_pages
    472553 ±  6%     -64.0%     170048 ± 22%  proc-vmstat.nr_mapped
      6828 ±  2%     -13.2%       5929 ±  6%  proc-vmstat.nr_page_table_pages
   1349103 ± 19%     -58.0%     567019        proc-vmstat.nr_shmem
     26209 ±  2%      -6.9%      24399        proc-vmstat.nr_slab_reclaimable
   1537988 ± 17%     -51.2%     751031 ±  3%  proc-vmstat.nr_zone_active_anon
    167438 ± 12%     -50.9%      82288 ± 24%  proc-vmstat.numa_hint_faults
    106871 ± 19%     -62.1%      40516 ± 33%  proc-vmstat.numa_hint_faults_local
  17429790 ±  2%     +63.6%   28512466        proc-vmstat.numa_hit
  17363565 ±  2%     +63.8%   28445844        proc-vmstat.numa_local
  17470213 ±  2%     +63.5%   28565863        proc-vmstat.pgalloc_normal
    645222           -20.6%     512041 ±  3%  proc-vmstat.pgfault
  15401346           +80.1%   27730965        proc-vmstat.pgfree
 5.248e+10            +8.6%  5.701e+10        perf-stat.i.branch-instructions
      0.33 ±  3%      -0.2        0.10 ± 11%  perf-stat.i.branch-miss-rate%
 1.647e+08 ±  2%     -71.0%   47792335 ±  9%  perf-stat.i.branch-misses
     19.40 ±  8%      +5.2       24.63 ±  7%  perf-stat.i.cache-miss-rate%
   9432268 ± 15%     -23.5%    7215380 ± 14%  perf-stat.i.cache-misses
  46766538 ± 10%     -34.7%   30557228 ±  8%  perf-stat.i.cache-references
  23928853           -95.8%    1009521        perf-stat.i.context-switches
    373.88           -95.8%      15.81        perf-stat.i.metric.K/sec
      8711 ±  3%     -23.2%       6694 ±  4%  perf-stat.i.minor-faults
      8711 ±  3%     -23.1%       6694 ±  4%  perf-stat.i.page-faults
      0.31 ±  2%      -0.2        0.08 ±  9%  perf-stat.overall.branch-miss-rate%
     20.07 ±  7%      +3.3       23.33 ±  6%  perf-stat.overall.cache-miss-rate%
  5.16e+10            +8.6%  5.606e+10        perf-stat.ps.branch-instructions
 1.616e+08 ±  2%     -71.0%   46862413 ±  9%  perf-stat.ps.branch-misses
   9324763 ± 15%     -23.8%    7101263 ± 15%  perf-stat.ps.cache-misses
  46321216 ± 10%     -34.6%   30283901 ±  8%  perf-stat.ps.cache-references
  23514896           -95.8%     992706        perf-stat.ps.context-switches
      8550 ±  2%     -23.0%       6584 ±  4%  perf-stat.ps.minor-faults
      8550 ±  2%     -23.0%       6584 ±  4%  perf-stat.ps.page-faults
      0.00 ±223%   +2945.0%       0.08 ±150%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     13.16 ± 77%     -93.4%       0.87 ±132%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +74228.0%       0.62 ± 53%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.98 ± 30%     -70.0%       0.30 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.18 ±140%    +313.8%       0.76 ± 45%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     14.41 ±148%     -99.1%       0.12 ± 18%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 53%    +564.2%       0.10 ± 44%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.33 ± 33%     -33.3%       0.22 ± 34%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.86 ± 27%     -77.3%       0.20        perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.29 ± 27%     -89.3%       0.14 ± 40%  perf-sched.sch_delay.avg.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
      0.02 ± 23%     -56.7%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
      0.34 ± 15%     -69.1%       0.10 ±  2%  perf-sched.sch_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      9.19 ± 61%     -99.8%       0.01 ± 67%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02 ± 20%    +287.4%       0.09        perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     17.13 ± 92%     -99.0%       0.18 ±112%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%   +3485.6%       0.15 ±164%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.10 ±158%   +1534.9%       1.65 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
    863.48 ± 36%     -70.7%     252.62 ±149%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +5.5e+05%       4.62 ± 63%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      1.28 ±217%    +504.3%       7.74 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
    203.65 ± 26%     -95.4%       9.44 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.04 ±223%    +444.1%       0.20 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.54 ±142%   +1407.1%       8.13 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.27 ±135%   +1223.4%       3.63 ± 81%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      2014 ± 40%     -99.0%      19.92 ± 29%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    299.74 ± 13%     -96.5%      10.45 ± 64%  perf-sched.sch_delay.max.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
    328.92 ± 16%     -91.7%      27.21 ±166%  perf-sched.sch_delay.max.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
    309.06 ± 14%     -89.4%      32.70 ±100%  perf-sched.sch_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    444.84 ± 29%     -99.7%       1.19 ±129%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    939.99 ± 61%     -94.4%      52.33 ±127%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1372 ± 80%     -98.8%      16.87 ±160%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 20%    +127.0%       0.07        perf-sched.total_sch_delay.average.ms
      2159 ± 40%     -87.1%     278.03 ±131%  perf-sched.total_sch_delay.max.ms
      0.12 ± 15%    +213.1%       0.38 ±  2%  perf-sched.total_wait_and_delay.average.ms
  12670156 ± 20%     -65.4%    4386881        perf-sched.total_wait_and_delay.count.ms
      5167 ± 12%     -20.5%       4108        perf-sched.total_wait_and_delay.max.ms
      0.09 ± 14%    +242.6%       0.31 ±  2%  perf-sched.total_wait_time.average.ms
     38.76 ± 39%     -69.3%      11.90 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.00 ± 29%     -68.8%       0.62 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.35 ±149%    +330.4%       1.52 ± 45%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.66 ± 33%     -38.7%       0.41 ± 53%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.94 ± 47%     -81.1%       0.56 ± 62%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      3.20 ± 14%     -51.5%       1.55 ± 23%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.99 ± 27%     -86.5%       0.40 ± 29%  perf-sched.wait_and_delay.avg.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
      0.05 ± 22%    +215.4%       0.17        perf-sched.wait_and_delay.avg.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
      5.84 ± 22%     -94.9%       0.30 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     22.31 ± 37%     -86.9%       2.92 ± 15%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     60.96 ± 64%     -95.9%       2.48 ± 15%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    694.35 ± 24%     -34.8%     452.48        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     41.35 ± 51%     -61.4%      15.94 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    837.15 ±  9%     -38.7%     513.26 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 18%    +287.7%       0.19        perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    974.67 ± 43%     -81.2%     183.00 ± 98%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
    172.83 ± 12%    +115.7%     372.80 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2935 ± 44%     -60.9%       1147 ± 26%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.00 ±141%  +17520.0%     176.20 ± 25%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      1742 ± 16%     +66.8%       2906 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
    517.00 ± 55%    +596.3%       3600 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      1.00 ±141%  +32440.0%     325.40 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
    885.67 ± 41%     -65.1%     308.80 ± 54%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      1.17 ± 76%    +328.6%       5.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     46.17 ± 21%    +102.3%      93.40 ±  3%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.33 ± 61%    +203.2%      19.20 ±  5%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    827.50 ± 20%    +192.3%       2418 ±  8%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     23590 ± 24%    +194.3%      69429 ± 22%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     34754 ± 32%    +467.3%     197159 ± 28%  perf-sched.wait_and_delay.count.pipe_wait_readable.ipipe_prep.part.0.do_tee
   6287013 ± 20%     -74.8%    1585356 ±  3%  perf-sched.wait_and_delay.count.pipe_wait_writable.opipe_prep.part.0.do_tee
     46312 ± 21%   +1467.4%     725907 ±  6%  perf-sched.wait_and_delay.count.pipe_write.vfs_write.ksys_write.do_syscall_64
     24.50 ± 22%     +92.7%      47.20 ± 15%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     11.67 ± 24%     +98.9%      23.20        perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     40.67 ± 22%    +114.4%      87.20        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      8.83 ± 28%    +121.9%      19.60 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    319.00 ± 16%    +103.7%     649.80 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
   6266766 ± 20%     -71.4%    1792099        perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     15.00 ± 27%    +144.0%      36.60        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    207.17 ± 33%    +104.6%     423.80 ±  8%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1843 ± 20%     -34.8%       1201 ± 33%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.56 ±218%    +505.4%      15.49 ± 17%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
    407.31 ± 26%     -95.4%      18.88 ± 10%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      1.04 ±149%   +1457.6%      16.26 ± 32%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1185 ± 57%     -94.0%      70.68 ±122%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4839 ± 21%     -63.0%       1788 ± 64%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    599.48 ± 13%     -94.8%      30.94 ± 68%  perf-sched.wait_and_delay.max.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
    657.85 ± 16%     -91.5%      55.93 ±160%  perf-sched.wait_and_delay.max.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
    673.79 ± 21%     -90.3%      65.42 ±100%  perf-sched.wait_and_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    284.00 ± 52%     -95.5%      12.82 ±110%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1366 ± 52%     -98.7%      17.62 ± 86%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2100 ± 52%     -76.0%     505.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1044 ± 29%     -61.4%     403.20 ± 22%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2349 ± 19%     -57.4%       1000        perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     25.60 ± 21%     -56.9%      11.03 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +74228.0%       0.62 ± 53%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      1.02 ± 28%     -67.7%       0.33 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.18 ±140%    +313.8%       0.76 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.33 ± 33%     -33.3%       0.22 ± 34%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.63 ± 50%     -87.7%       0.32 ± 47%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      2.34 ± 14%     -42.1%       1.36 ± 26%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.70 ± 27%     -84.4%       0.26 ± 24%  perf-sched.wait_time.avg.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
      0.03 ± 20%    +408.2%       0.16        perf-sched.wait_time.avg.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
      5.51 ± 23%     -96.5%       0.19 ±  2%  perf-sched.wait_time.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     19.69 ± 35%     -85.8%       2.79 ±  8%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%  +20831.4%       0.24 ± 55%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_double_lock
     49.52 ± 60%     -95.6%       2.19 ± 15%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    694.34 ± 24%     -34.8%     452.47        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    837.02 ±  9%     -38.7%     513.25 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 17%    +287.0%       0.10        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.19 ±131%   +1122.8%       2.33 ± 76%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
      0.00 ±223%  +5.5e+05%       4.62 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      1.28 ±217%    +504.3%       7.74 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
    203.65 ± 26%     -95.4%       9.44 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.54 ±142%   +1407.1%       8.13 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     32.46 ± 99%     -80.2%       6.42 ± 74%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    300.67 ± 13%     -91.3%      26.05 ± 75%  perf-sched.wait_time.max.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
    328.99 ± 16%     -86.2%      45.34 ±151%  perf-sched.wait_time.max.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
    391.47 ± 23%     -86.7%      51.90 ±136%  perf-sched.wait_time.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    239.99 ± 46%     -96.1%       9.32 ± 77%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%  +49648.6%       0.58 ± 61%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_double_lock
    864.13 ± 37%     -98.0%      17.07 ± 89%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2100 ± 52%     -76.0%     504.99        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2172 ± 17%     -54.0%       1000        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     16.97           -15.7        1.26 ±  3%  perf-profile.calltrace.cycles-pp.tee
     15.24           -14.7        0.59 ±  2%  perf-profile.calltrace.cycles-pp.opipe_prep.do_tee.__x64_sys_tee.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.19           -14.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.pipe_wait_writable.opipe_prep.do_tee.__x64_sys_tee.do_syscall_64
     15.29           -14.6        0.69 ±  3%  perf-profile.calltrace.cycles-pp.do_tee.__x64_sys_tee.do_syscall_64.entry_SYSCALL_64_after_hwframe.tee
     15.30           -14.6        0.73 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_tee.do_syscall_64.entry_SYSCALL_64_after_hwframe.tee
     15.34           -14.4        0.94 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.tee
     15.34           -14.4        0.96 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.tee
     14.06           -14.0        0.10 ±200%  perf-profile.calltrace.cycles-pp.schedule.pipe_wait_writable.opipe_prep.do_tee.__x64_sys_tee
     13.67           -13.6        0.10 ±200%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_wait_writable.opipe_prep.do_tee
     40.88           -11.1       29.80        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     10.86           -10.9        0.00        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_read.vfs_read.ksys_read.do_syscall_64
     13.96           -10.7        3.26        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     41.52           -10.6       30.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     10.50           -10.5        0.00        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.pipe_read.vfs_read.ksys_read
     10.35           -10.3        0.00        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_read.vfs_read
     10.12           -10.1        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_read
      9.38            -9.4        0.00        perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      9.02            -9.0        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     52.99            -7.3       45.71        perf-profile.calltrace.cycles-pp.read
      6.05 ±  2%      -6.0        0.00        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      5.49            -5.5        0.00        perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.pipe_wait_writable.opipe_prep
      5.25            -5.2        0.00        perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.pipe_wait_writable
      5.02            -5.0        0.00        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
     20.87            -4.0       16.84        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.38            -2.3       21.12        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     25.16            -1.2       23.92        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.91            -0.2        0.73 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      0.54 ±  2%      +0.3        0.83 ±  2%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64_mg.current_time.atime_needs_update.touch_atime.pipe_read
      0.61            +0.5        1.07        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72            +0.5        1.24 ±  2%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.07            +0.5        1.62 ±  2%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.78            +0.6        1.42        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.17 ±141%      +0.7        0.91        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.75        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.17            +0.8        1.93        perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
      0.00            +0.8        0.76 ±  4%  perf-profile.calltrace.cycles-pp.stress_tee_pipe_write
      0.00            +0.8        0.77        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.08 ±223%      +0.8        0.88        perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64_mg.current_time.inode_needs_update_time.file_update_time.pipe_write
      0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
      1.14            +0.8        1.96 ±  2%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.98            +0.9        1.84 ±  2%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.16            +0.9        2.08        perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.pipe_write.vfs_write
      1.18            +1.0        2.13        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.63            +1.3        2.93        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
      2.33            +1.4        3.72        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      1.72            +1.4        3.16        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.63            +1.6        4.22        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.98            +1.6        3.57        perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
      2.86            +2.1        4.95        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      3.43            +2.5        5.92        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.99            +2.6        5.54        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      3.52            +2.6        6.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      4.25            +2.9        7.12        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      3.50            +3.0        6.47        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      3.75            +3.2        6.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      4.49            +3.8        8.33        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      9.78            +8.2       17.98        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.20           +10.2       22.45        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     13.89           +11.7       25.59        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     17.18           +14.4       31.62        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     17.86           +15.0       32.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     26.99           +22.8       49.78        perf-profile.calltrace.cycles-pp.write
     23.67           -22.6        1.11 ±  2%  perf-profile.children.cycles-pp.schedule
     23.19           -22.1        1.09 ±  2%  perf-profile.children.cycles-pp.__schedule
     16.98           -15.7        1.30 ±  3%  perf-profile.children.cycles-pp.tee
     15.24           -14.7        0.56 ±  3%  perf-profile.children.cycles-pp.pipe_wait_writable
     15.24           -14.7        0.59 ±  3%  perf-profile.children.cycles-pp.opipe_prep
     15.29           -14.6        0.70 ±  3%  perf-profile.children.cycles-pp.do_tee
     15.30           -14.6        0.73 ±  3%  perf-profile.children.cycles-pp.__x64_sys_tee
     73.87           -10.7       63.20        perf-profile.children.cycles-pp.do_syscall_64
     10.91           -10.5        0.45 ±  5%  perf-profile.children.cycles-pp.__wake_up_sync_key
     10.61           -10.1        0.52 ±  7%  perf-profile.children.cycles-pp.__wake_up_common
     75.40           -10.0       65.40        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.44            -9.9        0.51 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
     10.32            -9.8        0.51 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
     16.00            -9.0        6.96        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     53.19            -7.3       45.93        perf-profile.children.cycles-pp.read
      6.34            -6.1        0.29 ±  2%  perf-profile.children.cycles-pp.__pick_next_task
      6.16            -5.9        0.28 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      6.13 ±  2%      -5.8        0.28        perf-profile.children.cycles-pp.ttwu_do_activate
      5.56            -5.3        0.27 ±  4%  perf-profile.children.cycles-pp.try_to_block_task
      5.32            -5.1        0.26 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      5.12            -4.9        0.25 ±  3%  perf-profile.children.cycles-pp.dequeue_entities
      4.92 ±  3%      -4.7        0.25 ±  2%  perf-profile.children.cycles-pp.enqueue_task
      4.69 ±  3%      -4.5        0.23 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      4.57            -4.3        0.22 ±  5%  perf-profile.children.cycles-pp.update_curr
      4.42            -4.2        0.21        perf-profile.children.cycles-pp.update_load_avg
      4.31            -4.1        0.19 ±  2%  perf-profile.children.cycles-pp.switch_mm_irqs_off
     21.23            -3.8       17.41        perf-profile.children.cycles-pp.pipe_read
      3.28            -3.1        0.15 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      2.87 ±  3%      -2.7        0.12 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
     23.53            -2.2       21.36        perf-profile.children.cycles-pp.vfs_read
      2.17            -2.1        0.09 ±  4%  perf-profile.children.cycles-pp.pick_task_fair
      1.90            -1.8        0.09 ±  7%  perf-profile.children.cycles-pp.set_next_entity
      1.70            -1.6        0.08 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      1.70            -1.6        0.09 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      1.59            -1.5        0.07 ±  7%  perf-profile.children.cycles-pp.__switch_to_asm
      1.65            -1.5        0.14        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      1.54            -1.5        0.07        perf-profile.children.cycles-pp.__switch_to
      1.43            -1.4        0.07        perf-profile.children.cycles-pp.put_prev_entity
      1.39            -1.3        0.06        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.36            -1.3        0.07        perf-profile.children.cycles-pp.wakeup_preempt
      1.28            -1.2        0.07        perf-profile.children.cycles-pp.pick_eevdf
     25.30            -1.1       24.16        perf-profile.children.cycles-pp.ksys_read
      1.17 ±  9%      -1.1        0.06 ±  8%  perf-profile.children.cycles-pp.select_task_rq
      0.98 ± 11%      -0.9        0.04 ± 50%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.99            -0.9        0.06 ±  6%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.90            -0.8        0.08 ±  6%  perf-profile.children.cycles-pp.rseq_ip_fixup
      1.05 ± 16%      -0.7        0.34 ±113%  perf-profile.children.cycles-pp.reader__read_event
      1.05 ± 16%      -0.7        0.34 ±112%  perf-profile.children.cycles-pp.perf_session__process_events
      1.05 ± 16%      -0.7        0.34 ±112%  perf-profile.children.cycles-pp.record__finish_output
      0.71            -0.6        0.06        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.61            -0.6        0.04 ± 50%  perf-profile.children.cycles-pp.os_xsave
      0.62 ±  5%      -0.5        0.08 ±  5%  perf-profile.children.cycles-pp.reweight_entity
      0.59            -0.5        0.05 ±  7%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.22 ±  2%      -0.1        0.11        perf-profile.children.cycles-pp.switch_fpu_return
      0.19 ±  3%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.18 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.sched_tick
      0.07            +0.0        0.09 ± 15%  perf-profile.children.cycles-pp.__wake_up
      0.09 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.page_counter_cancel
      0.09 ± 10%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.07 ±  5%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.__splice_from_pipe
      0.11 ±  9%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.uncharge_batch
      0.07 ±  6%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.08 ±  5%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.12 ± 11%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
      0.12 ±  9%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__folio_put
      0.00            +0.1        0.06 ± 12%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.08            +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.splice_from_pipe
      0.18 ±  8%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.__x64_sys_read
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.09 ±  5%      +0.1        0.19 ±  7%  perf-profile.children.cycles-pp.do_splice
      0.09 ±  4%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.__x64_sys_splice
      0.19            +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.make_vfsuid
      0.19            +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.make_vfsgid
      0.16 ±  2%      +0.1        0.29        perf-profile.children.cycles-pp.__x64_sys_write
      0.22 ±  5%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.read@plt
      0.19 ±  2%      +0.2        0.34 ±  6%  perf-profile.children.cycles-pp.write@plt
      1.00            +0.2        1.16 ±  3%  perf-profile.children.cycles-pp.stress_tee_pipe_read
      0.14 ±  3%      +0.2        0.33 ±  5%  perf-profile.children.cycles-pp.splice
      0.36            +0.2        0.60        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.38            +0.3        0.68        perf-profile.children.cycles-pp.kill_fasync
      1.48            +0.3        1.78        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.40            +0.3        0.73        perf-profile.children.cycles-pp.rcu_all_qs
      0.56            +0.4        0.96        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.56            +0.4        1.00        perf-profile.children.cycles-pp.stress_tee_pipe_write
      0.58            +0.5        1.04        perf-profile.children.cycles-pp.security_file_permission
      1.13            +0.7        1.88        perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.96            +0.8        1.72        perf-profile.children.cycles-pp.x64_sys_call
      0.92            +0.8        1.69        perf-profile.children.cycles-pp.__cond_resched
      1.30            +1.0        2.33        perf-profile.children.cycles-pp.rw_verify_area
      1.59            +1.3        2.87        perf-profile.children.cycles-pp.mutex_unlock
      1.72            +1.4        3.11        perf-profile.children.cycles-pp.inode_needs_update_time
      2.14            +1.5        3.62        perf-profile.children.cycles-pp.fdget_pos
      2.51            +1.5        4.04        perf-profile.children.cycles-pp.atime_needs_update
      2.72            +1.7        4.37        perf-profile.children.cycles-pp.touch_atime
      2.08            +1.7        3.75        perf-profile.children.cycles-pp.file_update_time
      2.52            +1.8        4.35        perf-profile.children.cycles-pp.current_time
      2.52            +2.0        4.49        perf-profile.children.cycles-pp.mutex_lock
      2.92            +2.1        5.03        perf-profile.children.cycles-pp._copy_to_iter
      3.53            +2.6        6.09        perf-profile.children.cycles-pp.copy_page_to_iter
      3.04            +2.6        5.64        perf-profile.children.cycles-pp._copy_from_iter
      3.27            +2.7        5.96        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.65            +3.1        6.75        perf-profile.children.cycles-pp.copy_page_from_iter
      4.17            +3.3        7.49        perf-profile.children.cycles-pp.entry_SYSCALL_64
      8.86            +6.9       15.76        perf-profile.children.cycles-pp.clear_bhb_loop
     10.12            +8.5       18.62        perf-profile.children.cycles-pp.pipe_write
     12.38           +10.4       22.74        perf-profile.children.cycles-pp.vfs_write
     14.06           +11.8       25.89        perf-profile.children.cycles-pp.ksys_write
     27.17           +22.9       50.09        perf-profile.children.cycles-pp.write
      4.22            -4.0        0.19        perf-profile.self.cycles-pp.switch_mm_irqs_off
      2.34            -2.2        0.11 ±  4%  perf-profile.self.cycles-pp.__schedule
      1.73 ±  4%      -1.6        0.08 ± 12%  perf-profile.self.cycles-pp.update_curr
      1.57            -1.5        0.07 ±  7%  perf-profile.self.cycles-pp.__switch_to_asm
      1.56            -1.5        0.08 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      1.46            -1.4        0.07 ±  7%  perf-profile.self.cycles-pp.__switch_to
      1.43            -1.4        0.07        perf-profile.self.cycles-pp.update_load_avg
      1.30            -1.2        0.06 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.82 ±  2%      -0.8        0.05 ±  7%  perf-profile.self.cycles-pp.prepare_task_switch
      0.81            -0.8        0.04 ± 50%  perf-profile.self.cycles-pp.pick_eevdf
      0.67            -0.6        0.05 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.60            -0.6        0.04 ± 50%  perf-profile.self.cycles-pp.os_xsave
      0.08 ± 12%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.read@plt
      0.08 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.page_counter_cancel
      0.13 ± 11%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__x64_sys_read
      0.05            +0.1        0.10 ± 17%  perf-profile.self.cycles-pp.write@plt
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.tee
      0.11 ±  3%      +0.1        0.19        perf-profile.self.cycles-pp.__x64_sys_write
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.14 ±  2%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.make_vfsgid
      0.14            +0.1        0.24        perf-profile.self.cycles-pp.make_vfsuid
      0.20 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.touch_atime
      0.20 ±  2%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.kill_fasync
      0.87            +0.2        1.04 ±  3%  perf-profile.self.cycles-pp.stress_tee_pipe_read
      0.30            +0.2        0.54        perf-profile.self.cycles-pp.rcu_all_qs
      0.34            +0.2        0.59        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.35            +0.3        0.63        perf-profile.self.cycles-pp.file_update_time
      0.45            +0.3        0.78        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.50 ±  2%      +0.4        0.86 ±  2%  perf-profile.self.cycles-pp.stress_tee_pipe_write
      0.47            +0.4        0.85        perf-profile.self.cycles-pp.inode_needs_update_time
      0.48            +0.4        0.86        perf-profile.self.cycles-pp.security_file_permission
      0.62            +0.4        1.06        perf-profile.self.cycles-pp.copy_page_to_iter
      0.51            +0.4        0.96        perf-profile.self.cycles-pp.__cond_resched
      0.70            +0.5        1.18 ±  2%  perf-profile.self.cycles-pp.ksys_read
      0.96            +0.5        1.47        perf-profile.self.cycles-pp.atime_needs_update
      0.66            +0.5        1.19        perf-profile.self.cycles-pp.copy_page_from_iter
      1.18            +0.6        1.74        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.72            +0.6        1.29        perf-profile.self.cycles-pp.rw_verify_area
      0.71            +0.6        1.31        perf-profile.self.cycles-pp.ksys_write
      1.51            +0.7        2.18        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.85            +0.7        1.52        perf-profile.self.cycles-pp.x64_sys_call
      1.03            +0.7        1.70        perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      1.04            +0.8        1.82        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.87            +1.0        2.92        perf-profile.self.cycles-pp.pipe_read
      1.39            +1.1        2.47        perf-profile.self.cycles-pp.current_time
      1.64            +1.1        2.78 ±  2%  perf-profile.self.cycles-pp.vfs_read
      1.59            +1.2        2.78        perf-profile.self.cycles-pp.mutex_lock
      1.49            +1.2        2.68        perf-profile.self.cycles-pp.mutex_unlock
      1.81            +1.2        3.04        perf-profile.self.cycles-pp.read
      2.03            +1.4        3.39        perf-profile.self.cycles-pp.do_syscall_64
      2.03            +1.4        3.44 ±  2%  perf-profile.self.cycles-pp.fdget_pos
      1.64            +1.4        3.07        perf-profile.self.cycles-pp.vfs_write
      1.84            +1.6        3.43        perf-profile.self.cycles-pp.write
      3.60            +1.8        5.36        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      2.13            +1.8        3.94 ±  2%  perf-profile.self.cycles-pp.pipe_write
      2.86            +2.1        4.93        perf-profile.self.cycles-pp._copy_to_iter
      2.93            +2.5        5.44        perf-profile.self.cycles-pp._copy_from_iter
      3.16            +2.6        5.75        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      8.75            +6.8       15.58        perf-profile.self.cycles-pp.clear_bhb_loop





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


