Return-Path: <linux-fsdevel+bounces-25654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B994E87C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 10:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071F01F21F64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9314E16A92C;
	Mon, 12 Aug 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIuhOD0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22116A947
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451138; cv=fail; b=DjYC4bME5bCB7nDvsKy5rmFR3fevSfdLsaic79081Oz/BNwMzGJdGgpVnXUn3EA03Fmj6hsv1EQX7Omt6ws4reByCxkxHvlKNYQSEYWS3C6ZQlHFFGk00BpEV6NeLVAyKNHIxOwckK0uuoKr7Y3XkdAJmeLGyAT1gWwT2a76DLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451138; c=relaxed/simple;
	bh=b84APw0vuyMvVAYt1cOghiTw11jGeLt38p9TsuMP+Tc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Df17Mgc3tNs8ScJ70IiN/5nMm4wwfIzGloWWNpUYzyPHfAmoMfW31wNktQ0WXxHg5ZCmtEJY/IIiyal0KoVAOC3GSA/Dx4I8oXncSGMDLcPw2srRy5IH2N7yVU+mqgIg3SjYs6bcdvX/XseB6g/75ZyIJRA6aHS8jLjCHwz3lvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIuhOD0s; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723451134; x=1754987134;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=b84APw0vuyMvVAYt1cOghiTw11jGeLt38p9TsuMP+Tc=;
  b=bIuhOD0soGh5Ud9KEafxwfwoH2qHuQlbEw5phv7XS0NYRgHM/llMExLA
   50KcCLW6vR7Z8bnNVswjN7wFCVlI4ZO3eSy/kK20+Gd9lmq8Mu/MTQiH7
   qRmUV4Q8UHSYbkLgxl7/2d1IjbcRR9WbSgxX0q5/vQIy9wqQhrd8Nl0SE
   TDEPKLq4FIaj7/o25tGPz4b390pEwPpjA4DBPFoajrq58Iy13a8luXwfQ
   qfL8kd75wmalg6yRY18g1buA2yCYRJY24eCLsMCNndy8HPlIQo/bSGxmv
   pym0iCN8xPPCxz/Q6E5Q6rpB/QZ7Ob8DzQLRa0OERdQZMXqmnDQzd6NsU
   w==;
X-CSE-ConnectionGUID: 3jpStFyaQSa1eP+VKTDNlQ==
X-CSE-MsgGUID: tdYAQ8FnQXeogprQx84DBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="12960772"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="12960772"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 01:25:34 -0700
X-CSE-ConnectionGUID: RxKaefWzTCCDFTfZjvIGkA==
X-CSE-MsgGUID: h+X113TdSJC0OLKb+m8Evg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58263239"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 01:25:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 01:25:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 01:25:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 01:25:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 01:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9vvx5KlL/TWbhGtvhwyg0MTjd3fjpK/EOvA0YNVuaiq+CHSTMEXqO9nE4KD+L4IWQkGOjnRmIm6LnSvEiuUn3mWhppCTLpZPbSu1aiVJlDPHkp1wTXq6nFFGVHfxlmsbYsw6k0pgqx/6BSNRaDoCkOF6CTOgbicjuHCZ2t82Y6qFmdRlmcFy8gytM4yaN1r3ucDS1WKJJuJoLsBV4HL+mCXUldxuJbUdzrb2F/AnErIRxoKn4h6o75D9QIUW8MuuUHxkX+SPcvoywzpbNjbVK0MoCJJiVhTdifAep22q4W9A3PLIaEMWtWd44w7j41c/GANeiAM8fUkvaY5Gu07qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ikkiOwchTBEdDumD5Dt4ctVLJNjyCCjVL6YGbNb+As=;
 b=n/z0mVbow59IUXw5zYHkFQ6r1kbaOBI6o9g3IvuE5HTrRnsHuLj4VOznaO0buGdQBC5n7mDsVKvQDeDAL2CjytIyKTpyaBYUSCnK0SD86FLDhyHsi7SY0qjW7JmOSWDDEuha2ly9NIXlI0rj0ElIfmN5/JDyXY5Tqfi0DI3DfaOP1teqzhO07qL9OoxdSS8W+ceHpY/mkvaBtdcAFN2TRdxPr6jNEvDHA3qJveOzsZLiqUrYCrahBoeailtnTbkABT7iInB2GZbMhXFMFXMwhxqQnmdOgH0rWGp7INV9Qb6ElqN5vPEi547jT5qFOIiV8JVqhv9cNUf48HUY6ZlxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 12 Aug
 2024 08:25:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 08:25:24 +0000
Date: Mon, 12 Aug 2024 16:25:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [brauner-vfs:vfs.misc] [fs]  10c62724d2:  aim7.jobs-per-min 117.1%
 improvement
Message-ID: <202408121617.2ed71f61-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0ddd22-5557-4c05-e6f5-08dcbaa84ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kJlD7D1RLX7A4M91RqRBEu6dCDNIXtk4CyZZQC6y7dyi8+nWSZvt6cP/Tr?=
 =?iso-8859-1?Q?2slMkKGCoIg7AWganOq2eDgkVBDMI9gC2/lWll9fn51e2SmizPDm8fSi3m?=
 =?iso-8859-1?Q?Q7mlzOFrvO26KGUkYbw9h/DzF0SFCp6866w3Su8Gq/UvY3JLcmhI5BpWw8?=
 =?iso-8859-1?Q?H3AW9T+2BvCcAe3GW+vEM7G+EWQpJxGbpjb1d1MpPCQnyfpqigiYJ/PgEi?=
 =?iso-8859-1?Q?/tRioJZ4E3TJlxQZs9WH+0VDyPPRnXfRRcAifjpZzdVGz5225fE56Q1r7g?=
 =?iso-8859-1?Q?yzwosuqiZg/atViEV5Ez3IYUHe5OuNCxL5UiO+tzlwvfsqk7kj043lvCqL?=
 =?iso-8859-1?Q?yVJLPmSNpOnQkeM3Nl1QMPFVbQgdJ7FDz/bg2SgChhzEJIH4MhfcIi2bqx?=
 =?iso-8859-1?Q?8fmSGzyugGUgeCiJRR2L1W+Ijyu9BvA4hYtW6Ta3SEmV6UiwTX68vNwog6?=
 =?iso-8859-1?Q?EjT8BwR2A3gn8MMMccDvBd1TcJXCjDbcJBEMYpmDgQBKNplVdKDFEPZq3d?=
 =?iso-8859-1?Q?1atLjN3zg5B5L48fcpdFQWoH8plxyHurVJuHhkZxpQT0LbuBkjPW53w2lJ?=
 =?iso-8859-1?Q?JiomdqL/aVGTWW4S/al+/7AFvCTUDZP+5pkszEVJaADnXoHp0sPqv/c9gu?=
 =?iso-8859-1?Q?8yjcXpMH29ZCVxXSRhHwCf71ubFnrDpKOoDzWld34V/mP7bBRm5vVJhLVT?=
 =?iso-8859-1?Q?apwOuQblTGYSG/wH1uwph31mjXQ6goyzsCIr8/VyWWi7YCOmImpQO4xKqL?=
 =?iso-8859-1?Q?rSSzQzu66G21D6kz+tY3eGKSOpnTYGdyNSMhsr+V7tmj0daoW8QIUHTCsw?=
 =?iso-8859-1?Q?IKQyPcJGAxO7dsGzthHRmYoeO+gaAh+JHTOQrmUjHvVdGeV4MDkhBhcNDC?=
 =?iso-8859-1?Q?O2U5amjyvcS7L0Syh9QMuEOB7B8UfBwVuDm30QahJ/yF5Efe1ELWtYGnd4?=
 =?iso-8859-1?Q?k7zXwjAWHapT18CHlSVH84tu5tSrln4Xm9gHcmPpDGUD/Cve6/7ZDHWRhN?=
 =?iso-8859-1?Q?C+1t4AQ17g9NDhgs/f2evYcfcF5su7jUSuAiLZwRsQaKQovk90Js/l3lTN?=
 =?iso-8859-1?Q?PiMZZM/Bg7aZhnQr8X7iXGp++i5zVKYKzbZcxYZdsjVAMYaPKLu6973nMz?=
 =?iso-8859-1?Q?hw6UoJUjWt0oYRx2Ag7BAOiI2gK07cyq2exOVUvSo0jwnlwp4L3/XB3tQi?=
 =?iso-8859-1?Q?OHheIbzwzTP2nK46YKhuNsfMcUj9Q+myzxwk4SQRmDyA7RZweedlW40gip?=
 =?iso-8859-1?Q?YMxlh1akyAq5hYyKj5pchYsroILfCH8s9s+D1TDVegEoB59PYVGHEry0wX?=
 =?iso-8859-1?Q?cps0aBNkdqxEd9wI4x7QBkfmWIsSHmI14XgWTGag2wqkx2IjBkweOq+uv8?=
 =?iso-8859-1?Q?XB/+aoFQ2Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/AMel222m3EChLftwEtSMWUKPblkA6HOBwf24XT57AtP2lpzhKM7OjMOVQ?=
 =?iso-8859-1?Q?tPBARdTYKLNKkEdCyop7CGC5z3JCDV9dtGJyfxRc4EVGBew4Vhb5YI1nH3?=
 =?iso-8859-1?Q?1wfBsZF+VlXfCSJObOppT19d0OF8oxmaA6YHA2aMFIR66/RUBpR8VKFkm3?=
 =?iso-8859-1?Q?YUOrhx6ZvkWL3FJwP0iAFbwdAL+5iHIBeQAggA2iRU12y4HxeniJlb1z5M?=
 =?iso-8859-1?Q?ExeSl8X80OwMzFtIJo7lpjNoqJPzrwcB0ULfhFY//RWYI59KAFyeGOUNac?=
 =?iso-8859-1?Q?Kg5Ywk/05nYf5n4ZTS/+LuiazYfUmzWGit7/z4Xy7lQrCEIA9oZIP7Cu4j?=
 =?iso-8859-1?Q?0LBi5spRCQFK9kvdRHNCRpIyXbpAQ9pN7b4LpJpGaG9B3igLbeCwbkdi6A?=
 =?iso-8859-1?Q?p8urn9QLMcthP1oQJ2LRmgqiRZTiB9XfYl1ZIBZ/ULjL/SWR9YCnTycZ3D?=
 =?iso-8859-1?Q?VoHd2XoGcNqd0a4UiVlkx9nC4JTWXQOgNI0qthjvjSlZ+Svdpt4RPNkiFZ?=
 =?iso-8859-1?Q?vMjJ3HZ2ymMgDmoxB02LB0jy0lTrGmHaYa57QcaXhaVYcrZ4PQsL+6Wpj3?=
 =?iso-8859-1?Q?tbDmsm7bC39NXLIE0MjiBf1fuwRhyu3pz3ykg3P6LrkSanxSCn0/Qaz27h?=
 =?iso-8859-1?Q?KyheH0Cr5F4Gazp0LmXGc7WMbE4BwlEcV9rjMjsVka+VhBFODfmPEKHveu?=
 =?iso-8859-1?Q?fiPAHU8oeu3jgb9+xY6AiA7SdHPdQwB8/+boUA9X3oqsutEH60pPst41eO?=
 =?iso-8859-1?Q?R+GhE+abTZDa8DXMDfBWKbYYY3nRBeWqSW+kj6OpoX3qIL9XI5QzsCvSZz?=
 =?iso-8859-1?Q?cvPVHVLGl1XTAOPgcmdAx+Lh4kPYN2REhNPCkwymXwExp6LBpkwKMIcSV1?=
 =?iso-8859-1?Q?LQszWiLOPnTgWgpxMqH+63Fzv28Yi1QuxD7PVgwPzSzWVqw0KYmT7BHWR6?=
 =?iso-8859-1?Q?9cvgwRpcs71yOGGUKSE5d1xmmzQG2LolBzamN0q0/s9KvFMlbOqmXr4JjX?=
 =?iso-8859-1?Q?w0unJnV/dKH3Y3jZZeakVnb/ocvrJcl/mHqpd7GucYYcXHokL/ydewSjzq?=
 =?iso-8859-1?Q?O020ULa3+PH/1RrFQdI6wbLvlt/6kXLd3xjpDr5zs50tWJDn7Q0hdgktMD?=
 =?iso-8859-1?Q?0IQ6DLbe/ydIyZLGrbK7XTG3n+mEpyJ7ogX3qOoRPbsMFtoBU089+44wB/?=
 =?iso-8859-1?Q?b79Nh81y1XGZ533IZSDnRw9kz0VIT+7Fn3bmw6t42PrdYV2TrVeb53NVJV?=
 =?iso-8859-1?Q?dG0WFefpXp9KX8asIAzWHHDCLLaxmGFNSySVBcvtDYq6AfoKpEQs3x8byP?=
 =?iso-8859-1?Q?eWwQHWFDaZc4uNqhH1UtsbbvrSL1we0eNMCqLNIWNbPThLqr886JPBf9FE?=
 =?iso-8859-1?Q?2N9fJbChoR2m2MmacMJZ8Xiu1T9oKUBYCyA6Zi+WbwlqGILFo59E/GZSjL?=
 =?iso-8859-1?Q?6Q7v/ypSZukejzxM0YegIQLhnfZ0Lu3y29K0lYFU5RGNTKfONybQlkk51g?=
 =?iso-8859-1?Q?SOPjYY9lr3G5SglcZCtSSeVyKbLWGt6wsYMwJLnp6YMxESXnP2NVROPe0e?=
 =?iso-8859-1?Q?+u0I3YrS4PSsvSyzgULB5ufY5JSebZAVpWBrFYdgkVY8fFaWiNpYpHSNCP?=
 =?iso-8859-1?Q?sjb9d3tlaefM1fudcu+FwBguSoVYFIZ1xjuvz9rPEbCGLmg/Ihxb22iQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0ddd22-5557-4c05-e6f5-08dcbaa84ff2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 08:25:24.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1XK+pONerLpX5wPDf6TSLq4xsxpeQkSRFpYbmk6amyPotyI18onVHQU8l2J0IHUitGnTBldfxCIsuMfotj5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 117.1% improvement of aim7.jobs-per-min on:


commit: 10c62724d2b5e7025b9b086e401fea6686b191ed ("fs: try an opportunistic lookup for O_CREAT opens too")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.misc

testcase: aim7
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	disk: 1BRD_48G
	fs: xfs
	test: creat-clo
	load: 1500
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240812/202408121617.2ed71f61-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/xfs/x86_64-rhel-8.3/1500/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/creat-clo/aim7

commit: 
  b4988e3bd1 ("eventpoll: Annotate data-race of busy_poll_usecs")
  10c62724d2 ("fs: try an opportunistic lookup for O_CREAT opens too")

b4988e3bd1f05bd8 10c62724d2b5e7025b9b086e401 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.988e+09           +37.0%  5.466e+09        cpuidle..time
   2672567           +14.6%    3063964        cpuidle..usage
     26.07          +184.6%      74.20        iostat.cpu.idle
     73.47           -66.0%      25.01        iostat.cpu.system
    173.96           -37.0%     109.64        uptime.boot
      9988           +16.5%      11640        uptime.idle
    359070 ±  9%     -27.8%     259224 ±  9%  numa-numastat.node0.local_node
    425436 ±  7%     -31.9%     289854 ±  9%  numa-numastat.node0.numa_hit
    457040 ±  7%     -47.2%     241268 ±  8%  numa-numastat.node1.local_node
    523860 ±  6%     -34.4%     343879 ±  7%  numa-numastat.node1.numa_hit
      1762 ±  2%     -99.5%       8.83 ± 28%  perf-c2c.DRAM.local
     29295           -99.9%      25.00 ± 23%  perf-c2c.DRAM.remote
     32727           -99.9%      19.67 ± 21%  perf-c2c.HITM.local
     20103          -100.0%       7.67 ± 34%  perf-c2c.HITM.remote
     52831           -99.9%      27.33 ± 22%  perf-c2c.HITM.total
     26.00          +185.3%      74.19        vmstat.cpu.id
     73.52           -66.0%      25.03        vmstat.cpu.sy
     60.42 ± 11%    +162.1%     158.36 ± 14%  vmstat.io.bo
     94.73 ±  2%     -63.4%      34.64 ±  3%  vmstat.procs.r
     26558           -21.5%      20835        vmstat.system.cs
    187260           -35.2%     121372        vmstat.system.in
    661862           -77.0%     152254 ±  2%  meminfo.Active
    661830           -77.0%     152222 ±  2%  meminfo.Active(anon)
    103560 ± 16%     -45.7%      56244 ±  9%  meminfo.AnonHugePages
   3862174           -14.1%    3315885        meminfo.Cached
   2674293           -21.3%    2105832        meminfo.Committed_AS
     95376 ±  2%     -33.4%      63556 ±  2%  meminfo.Mapped
    723240           -75.5%     177209        meminfo.Shmem
     24.89           +48.5       73.36        mpstat.cpu.all.idle%
      0.40 ±  2%      -0.2        0.20 ±  2%  mpstat.cpu.all.irq%
      0.03 ±  2%      +0.0        0.05 ±  2%  mpstat.cpu.all.soft%
     74.22           -48.6       25.60        mpstat.cpu.all.sys%
      0.46            +0.3        0.80        mpstat.cpu.all.usr%
     24.67 ± 12%     -51.4%      12.00        mpstat.max_utilization.seconds
     84.38           -50.7%      41.58 ±  7%  mpstat.max_utilization_pct
    169914 ± 34%     -98.0%       3369 ± 17%  numa-meminfo.node0.Active
    169898 ± 34%     -98.0%       3337 ± 17%  numa-meminfo.node0.Active(anon)
     39483 ± 30%     -47.7%      20641 ± 57%  numa-meminfo.node0.Mapped
    183159 ± 34%     -96.0%       7319 ± 10%  numa-meminfo.node0.Shmem
    492271 ± 11%     -69.7%     148912 ±  2%  numa-meminfo.node1.Active
    492255 ± 11%     -69.7%     148912 ±  2%  numa-meminfo.node1.Active(anon)
    540234 ± 11%     -68.5%     170086        numa-meminfo.node1.Shmem
     74075          +117.1%     160794        aim7.jobs-per-min
    121.60           -53.9%      56.09        aim7.time.elapsed_time
    121.60           -53.9%      56.09        aim7.time.elapsed_time.max
     80591           +46.5%     118071        aim7.time.involuntary_context_switches
    133103           -23.3%     102089        aim7.time.minor_page_faults
      9590           -65.4%       3322        aim7.time.percent_of_cpu_this_job_got
     11644           -84.2%       1845        aim7.time.system_time
   1354797           -83.8%     218855        aim7.time.voluntary_context_switches
     42454 ± 34%     -98.0%     834.97 ± 17%  numa-vmstat.node0.nr_active_anon
      9896 ± 31%     -47.1%       5237 ± 58%  numa-vmstat.node0.nr_mapped
     45753 ± 34%     -96.0%       1830 ± 10%  numa-vmstat.node0.nr_shmem
     42454 ± 34%     -98.0%     834.95 ± 17%  numa-vmstat.node0.nr_zone_active_anon
    424164 ±  7%     -31.9%     288846 ±  9%  numa-vmstat.node0.numa_hit
    357798 ±  9%     -27.8%     258216 ± 10%  numa-vmstat.node0.numa_local
    122877 ± 11%     -69.8%      37113 ±  2%  numa-vmstat.node1.nr_active_anon
    134969 ± 11%     -68.6%      42430        numa-vmstat.node1.nr_shmem
    122877 ± 11%     -69.8%      37113 ±  2%  numa-vmstat.node1.nr_zone_active_anon
    522253 ±  7%     -34.3%     342864 ±  7%  numa-vmstat.node1.numa_hit
    455433 ±  7%     -47.2%     240255 ±  8%  numa-vmstat.node1.numa_local
    165479           -77.0%      38065 ±  2%  proc-vmstat.nr_active_anon
    965468           -14.1%     829031        proc-vmstat.nr_file_pages
    195284            -4.8%     185969        proc-vmstat.nr_inactive_anon
     23945 ±  3%     -32.1%      16254 ±  2%  proc-vmstat.nr_mapped
    180732           -75.5%      44359        proc-vmstat.nr_shmem
     36251            -4.1%      34777        proc-vmstat.nr_slab_reclaimable
    165479           -77.0%      38065 ±  2%  proc-vmstat.nr_zone_active_anon
    195284            -4.8%     185969        proc-vmstat.nr_zone_inactive_anon
     53879 ±  8%     -60.7%      21172 ± 29%  proc-vmstat.numa_hint_faults
     21227           -69.8%       6400 ± 17%  proc-vmstat.numa_hint_faults_local
    950499           -33.1%     635950        proc-vmstat.numa_hit
    817313           -38.5%     502708        proc-vmstat.numa_local
    172268           -62.0%      65513        proc-vmstat.pgactivate
   1082163           -35.2%     701149        proc-vmstat.pgalloc_normal
    697030           -37.0%     439446        proc-vmstat.pgfault
    787583           -30.0%     551061        proc-vmstat.pgfree
     41414 ±  2%     -39.0%      25254 ±  3%  proc-vmstat.pgreuse
 1.366e+10           -53.7%  6.321e+09        perf-stat.i.branch-instructions
      0.70            +0.9        1.60        perf-stat.i.branch-miss-rate%
  29804438           +69.0%   50360505 ±  2%  perf-stat.i.branch-misses
     30.69            -9.0       21.73 ±  4%  perf-stat.i.cache-miss-rate%
  48703090           -48.0%   25348473 ±  4%  perf-stat.i.cache-misses
 1.507e+08           -28.7%  1.074e+08        perf-stat.i.cache-references
     26681           -20.7%      21151        perf-stat.i.context-switches
      3.37           -27.3%       2.45        perf-stat.i.cpi
 2.474e+11           -64.5%  8.791e+10        perf-stat.i.cpu-cycles
      4360           -82.3%     772.20        perf-stat.i.cpu-migrations
      4890           -29.9%       3427 ±  5%  perf-stat.i.cycles-between-cache-misses
 6.815e+10           -53.6%  3.166e+10        perf-stat.i.instructions
      0.39           +45.9%       0.56        perf-stat.i.ipc
      5088           +33.9%       6810 ±  3%  perf-stat.i.minor-faults
      5089           +33.8%       6811 ±  3%  perf-stat.i.page-faults
      0.72           +11.9%       0.80 ±  5%  perf-stat.overall.MPKI
      0.21            +0.6        0.79        perf-stat.overall.branch-miss-rate%
     32.12            -8.5       23.58 ±  5%  perf-stat.overall.cache-miss-rate%
      3.63           -23.4%       2.78        perf-stat.overall.cpi
      5074           -31.3%       3483 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.28           +30.6%       0.36        perf-stat.overall.ipc
 1.369e+10           -54.4%  6.249e+09        perf-stat.ps.branch-instructions
  29092300           +69.0%   49158314 ±  2%  perf-stat.ps.branch-misses
  48913289           -48.8%   25051975 ±  4%  perf-stat.ps.cache-misses
 1.523e+08           -30.2%  1.063e+08        perf-stat.ps.cache-references
     26654           -21.7%      20865        perf-stat.ps.context-switches
 2.482e+11           -64.9%  8.708e+10        perf-stat.ps.cpu-cycles
      4369           -82.5%     765.55        perf-stat.ps.cpu-migrations
 6.832e+10           -54.2%   3.13e+10        perf-stat.ps.instructions
      5174           +26.9%       6567 ±  2%  perf-stat.ps.minor-faults
      5175           +26.9%       6567 ±  2%  perf-stat.ps.page-faults
 8.405e+12           -78.7%  1.789e+12        perf-stat.total.instructions
   4457363           -99.9%       2865 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.avg
   4578163           -99.2%      38272 ± 29%  sched_debug.cfs_rq:/.avg_vruntime.max
   3923953 ±  2%    -100.0%      40.02 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.min
     66544 ± 15%     -92.2%       5173 ± 16%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.57 ±  2%     -82.8%       0.10 ± 12%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.61 ±  7%     -37.9%       1.00        sched_debug.cfs_rq:/.h_nr_running.max
      0.39 ±  6%     -23.8%       0.30 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
      8111 ± 25%     -80.7%       1563 ± 15%  sched_debug.cfs_rq:/.load.avg
     63.32 ± 15%    +167.5%     169.37 ±  8%  sched_debug.cfs_rq:/.load_avg.avg
      3.06 ± 11%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
    152.85 ± 21%    +178.6%     425.83 ±  3%  sched_debug.cfs_rq:/.load_avg.stddev
   4457363           -99.9%       2865 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
   4578163           -99.2%      38272 ± 29%  sched_debug.cfs_rq:/.min_vruntime.max
   3923953 ±  2%    -100.0%      40.02 ± 18%  sched_debug.cfs_rq:/.min_vruntime.min
     66544 ± 15%     -92.2%       5173 ± 16%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.56 ±  3%     -82.6%       0.10 ± 12%  sched_debug.cfs_rq:/.nr_running.avg
      0.38 ±  4%     -21.5%       0.30 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
     16.64 ± 53%    +180.1%      46.60 ± 51%  sched_debug.cfs_rq:/.removed.load_avg.avg
    418.67 ± 29%    +142.3%       1014 ±  2%  sched_debug.cfs_rq:/.removed.load_avg.max
     74.90 ± 23%    +168.9%     201.45 ± 27%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    207.28 ± 19%    +158.6%     536.00 ±  7%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     34.61 ± 23%    +164.2%      91.43 ± 28%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
    205.56 ± 18%    +160.8%     536.00 ±  7%  sched_debug.cfs_rq:/.removed.util_avg.max
     34.47 ± 23%    +165.2%      91.42 ± 28%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    603.76 ±  2%     -59.1%     246.79 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
    303.06 ±  6%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    168.28 ±  3%     +70.3%     286.59 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
    593.74           -58.7%     245.40 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    296.22 ±  8%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    161.73 ±  4%     +77.0%     286.24 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
    131.07 ±  7%     -91.6%      11.01 ± 38%  sched_debug.cfs_rq:/.util_est.avg
    109.34 ± 11%     -39.1%      66.61 ± 28%  sched_debug.cfs_rq:/.util_est.stddev
    193271 ± 27%     -97.9%       4146 ±  9%  sched_debug.cpu.avg_idle.min
    170312 ±  4%     +27.7%     217494 ±  7%  sched_debug.cpu.avg_idle.stddev
    111599           -52.5%      52972 ±  2%  sched_debug.cpu.clock.avg
    111611           -52.5%      52980 ±  2%  sched_debug.cpu.clock.max
    111586           -52.5%      52961 ±  2%  sched_debug.cpu.clock.min
      6.82 ±  8%     -41.6%       3.98 ±  5%  sched_debug.cpu.clock.stddev
    111199           -52.5%      52828 ±  2%  sched_debug.cpu.clock_task.avg
    111351           -52.4%      52963 ±  2%  sched_debug.cpu.clock_task.max
    102513           -56.8%      44330 ±  3%  sched_debug.cpu.clock_task.min
      2587 ±  4%     -89.4%     273.04 ± 14%  sched_debug.cpu.curr->pid.avg
      6241           -49.0%       3184        sched_debug.cpu.curr->pid.max
      1645 ±  4%     -47.6%     862.89 ±  6%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 10%     -22.3%       0.00 ± 19%  sched_debug.cpu.next_balance.stddev
      0.56 ±  2%     -83.8%       0.09 ± 12%  sched_debug.cpu.nr_running.avg
      1.61 ±  7%     -37.9%       1.00        sched_debug.cpu.nr_running.max
      0.39 ±  6%     -26.4%       0.29 ±  5%  sched_debug.cpu.nr_running.stddev
     13465           -91.8%       1101 ±  4%  sched_debug.cpu.nr_switches.avg
     40151 ±  8%     -72.2%      11170 ± 20%  sched_debug.cpu.nr_switches.max
     11046 ±  3%     -98.8%     133.50 ±  9%  sched_debug.cpu.nr_switches.min
      3346 ±  5%     -50.1%       1671 ±  8%  sched_debug.cpu.nr_switches.stddev
      6.20 ± 14%     -99.8%       0.01 ± 48%  sched_debug.cpu.nr_uninterruptible.avg
    110.67 ± 17%     -80.4%      21.67 ± 20%  sched_debug.cpu.nr_uninterruptible.max
    -60.67           -71.2%     -17.50        sched_debug.cpu.nr_uninterruptible.min
     28.80 ± 18%     -82.3%       5.11 ± 16%  sched_debug.cpu.nr_uninterruptible.stddev
    111587           -52.5%      52966 ±  2%  sched_debug.cpu_clk
    110422           -53.1%      51801 ±  3%  sched_debug.ktime
    112474           -52.1%      53869 ±  2%  sched_debug.sched_clk
     93.78           -89.7        4.10 ±  3%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
     90.66           -87.1        3.60 ±  3%  perf-profile.calltrace.cycles-pp.down_write.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
     90.41           -86.8        3.59 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat.do_filp_open
     89.92           -86.4        3.50 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat
     89.34           -86.1        3.20 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
     98.22           -13.0       85.22        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
     98.24           -12.8       85.42        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     98.51           -11.3       87.18        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     98.52           -11.3       87.25        perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     98.64           -11.1       87.58        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     98.65           -11.0       87.63        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
     98.80           -10.2       88.59        perf-profile.calltrace.cycles-pp.creat64
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc.xfs_trans_alloc_ichange
      0.00            +0.6        0.58 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inode_to_log_dinode.xfs_inode_item_format.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_creat.do_syscall_64
      0.00            +0.6        0.61 ±  3%  perf-profile.calltrace.cycles-pp.xfs_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.63 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.7        0.67 ±  3%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +0.8        0.85 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        0.99 ±  3%  perf-profile.calltrace.cycles-pp.xfs_inode_item_format.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit
      0.00            +1.1        1.09 ±  3%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +1.1        1.10 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_setattr_nonsize
      0.00            +1.1        1.11 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.1        1.12 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.2        1.17        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      0.00            +1.2        1.18 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.2        1.22 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.2        1.22 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.2        1.22 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.00            +1.3        1.26 ±  3%  perf-profile.calltrace.cycles-pp.common_startup_64
      0.00            +1.4        1.36 ± 26%  perf-profile.calltrace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open
      0.00            +1.4        1.38 ± 25%  perf-profile.calltrace.cycles-pp.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open.path_openat
      0.00            +1.6        1.57 ± 22%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
      0.00            +1.6        1.59 ± 22%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +2.5        2.46 ±  6%  perf-profile.calltrace.cycles-pp.up_read.__xfs_trans_commit.xfs_setattr_nonsize.xfs_setattr_size.xfs_vn_setattr
      0.00            +2.6        2.63 ± 17%  perf-profile.calltrace.cycles-pp.common_perm_cond.security_file_truncate.do_open.path_openat.do_filp_open
      0.00            +2.7        2.66 ± 16%  perf-profile.calltrace.cycles-pp.security_file_truncate.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +2.8        2.78 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_setattr_nonsize.xfs_setattr_size
      0.00            +3.8        3.78 ± 16%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.vfs_open.do_open
      0.00            +3.8        3.81 ± 16%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.vfs_open.do_open.path_openat
      0.00            +3.8        3.81 ± 12%  perf-profile.calltrace.cycles-pp.xfs_log_space_wake.xfs_log_ticket_ungrant.xlog_cil_commit.__xfs_trans_commit.xfs_setattr_nonsize
      0.00            +4.1        4.10 ± 12%  perf-profile.calltrace.cycles-pp.xlog_grant_head_check.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc.xfs_trans_alloc_ichange
      0.00            +4.4        4.36 ±  6%  perf-profile.calltrace.cycles-pp.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_setattr_nonsize.xfs_setattr_size
      0.00            +4.4        4.44 ± 13%  perf-profile.calltrace.cycles-pp.do_dentry_open.vfs_open.do_open.path_openat.do_filp_open
      0.00            +4.5        4.52 ± 13%  perf-profile.calltrace.cycles-pp.vfs_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +5.3        5.28 ±  9%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
      0.00            +5.3        5.29 ±  9%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +6.8        6.80 ±  7%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.52            +7.4        7.89 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.55            +7.5        8.07 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.56            +7.6        8.12 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.69            +8.2        8.90 ±  6%  perf-profile.calltrace.cycles-pp.__close
      0.00            +8.9        8.92 ±  6%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      0.00            +9.1        9.15 ±  6%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      0.00            +9.3        9.33 ±  6%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.00           +10.1       10.05 ±  5%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      0.00           +10.5       10.54 ± 11%  perf-profile.calltrace.cycles-pp.xfs_log_ticket_ungrant.xlog_cil_commit.__xfs_trans_commit.xfs_setattr_nonsize.xfs_setattr_size
      0.54           +11.3       11.80 ±  9%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc.xfs_trans_alloc_ichange.xfs_setattr_nonsize.xfs_setattr_size.xfs_vn_setattr
      0.00           +11.3       11.33 ± 10%  perf-profile.calltrace.cycles-pp.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc.xfs_trans_alloc_ichange.xfs_setattr_nonsize
      0.00           +11.4       11.41 ± 10%  perf-profile.calltrace.cycles-pp.xfs_trans_reserve.xfs_trans_alloc.xfs_trans_alloc_ichange.xfs_setattr_nonsize.xfs_setattr_size
      0.62 ±  2%     +12.0       12.58 ±  9%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc_ichange.xfs_setattr_nonsize.xfs_setattr_size.xfs_vn_setattr.notify_change
      0.00           +17.5       17.49 ±  6%  perf-profile.calltrace.cycles-pp.apparmor_capable.security_capable.has_capability_noaudit.xfs_setattr_nonsize.xfs_setattr_size
      0.00           +17.6       17.57 ±  6%  perf-profile.calltrace.cycles-pp.security_capable.has_capability_noaudit.xfs_setattr_nonsize.xfs_setattr_size.xfs_vn_setattr
      0.00           +17.6       17.60 ±  6%  perf-profile.calltrace.cycles-pp.has_capability_noaudit.xfs_setattr_nonsize.xfs_setattr_size.xfs_vn_setattr.notify_change
      0.79 ±  2%     +22.3       23.07 ±  7%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_setattr_nonsize.xfs_setattr_size.xfs_vn_setattr
      0.92 ±  2%     +25.3       26.27 ±  7%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_setattr_nonsize.xfs_setattr_size.xfs_vn_setattr.notify_change
      1.91 ±  2%     +55.1       57.03 ±  3%  perf-profile.calltrace.cycles-pp.xfs_setattr_nonsize.xfs_setattr_size.xfs_vn_setattr.notify_change.do_truncate
      1.94 ±  2%     +55.2       57.19 ±  3%  perf-profile.calltrace.cycles-pp.xfs_setattr_size.xfs_vn_setattr.notify_change.do_truncate.do_open
      2.05 ±  2%     +56.2       58.22 ±  3%  perf-profile.calltrace.cycles-pp.xfs_vn_setattr.notify_change.do_truncate.do_open.path_openat
      2.13 ±  2%     +56.5       58.65 ±  3%  perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_open.path_openat.do_filp_open
      2.18           +57.1       59.24 ±  3%  perf-profile.calltrace.cycles-pp.do_truncate.do_open.path_openat.do_filp_open.do_sys_openat2
      2.62 ±  2%     +66.8       69.40        perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
     93.79           -89.7        4.11 ±  3%  perf-profile.children.cycles-pp.open_last_lookups
     90.50           -86.6        3.90 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     90.02           -86.4        3.62 ±  3%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     89.46           -86.2        3.30 ±  4%  perf-profile.children.cycles-pp.osq_lock
     90.81           -86.1        4.72 ±  2%  perf-profile.children.cycles-pp.down_write
     98.25           -13.0       85.27        perf-profile.children.cycles-pp.path_openat
     98.27           -12.8       85.44        perf-profile.children.cycles-pp.do_filp_open
     98.54           -11.3       87.23        perf-profile.children.cycles-pp.do_sys_openat2
     98.52           -11.3       87.26        perf-profile.children.cycles-pp.__x64_sys_creat
     98.83           -10.1       88.75        perf-profile.children.cycles-pp.creat64
     99.40            -3.1       96.33        perf-profile.children.cycles-pp.do_syscall_64
     99.42            -2.9       96.50        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.24 ± 24%      -1.1        1.11 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      1.26 ± 22%      -1.1        0.14 ±  3%  perf-profile.children.cycles-pp.lockref_get_not_dead
      1.36 ± 21%      -1.0        0.32 ±  2%  perf-profile.children.cycles-pp.dput
      1.22 ± 23%      -1.0        0.21 ±  2%  perf-profile.children.cycles-pp.terminate_walk
      1.29 ± 22%      -0.9        0.38 ±  3%  perf-profile.children.cycles-pp.__legitimize_path
      0.94 ±  3%      -0.9        0.06 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.30 ± 21%      -0.9        0.43 ±  2%  perf-profile.children.cycles-pp.try_to_unlazy
      1.47 ±  2%      -0.7        0.76 ±  4%  perf-profile.children.cycles-pp.up_write
      0.33 ±  4%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.lockref_put_return
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.10 ±  7%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.update_cfs_group
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.task_work_run
      0.05            +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.main
      0.05            +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.run_builtin
      0.07 ±  6%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.04 ± 71%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.14 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.24 ±  4%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.sched_tick
      0.17 ±  3%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.schedule
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.18 ±  5%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.step_into
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.file_close_fd_locked
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xfs_inode_item_release
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xfs_qm_dqrele
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.xfs_buf_offset
      0.18 ±  3%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__schedule
      0.11 ±  3%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.___down_common
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__down
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.xfs_inode_item_size
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.evm_inode_setattr
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.set_root
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.xfs_trans_unreserve_and_mod_sb
      0.12 ±  3%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.list_sort
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.schedule_timeout
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.close@plt
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.sched_balance_domains
      0.12 ±  3%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.41 ±  3%      +0.1        0.47 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__check_heap_object
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.fd_install
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.mntput_no_expire
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.security_inode_post_setattr
      0.14 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.current_time
      0.42 ±  3%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.refill_obj_stock
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.down
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.map_id_up
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.xfs_break_dax_layouts
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.xfs_buf_find_lock
      0.00            +0.1        0.09 ±  6%  perf-profile.children.cycles-pp.crng_fast_key_erasure
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.security_inode_permission
      0.00            +0.1        0.09 ±  6%  perf-profile.children.cycles-pp.write
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.xfs_vn_setattr_size
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.security_file_release
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.xfs_ialloc_read_agi
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.security_inode_setattr
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.crng_make_state
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.nd_jump_root
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.xfs_read_agi
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.xfs_difree
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.xfs_trans_free
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.xlog_calc_unit_res
      0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.xfs_buf_lookup
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.xfs_can_free_eofblocks
      0.00            +0.1        0.11 ±  5%  perf-profile.children.cycles-pp.xfs_inode_uninit
      0.07            +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.xfs_ifree
      0.00            +0.1        0.12        perf-profile.children.cycles-pp.make_vfsuid
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.00            +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.down_write_trylock
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.00            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.lockref_get
      0.00            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.putname
      0.00            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.chacha_permute
      0.00            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.xfs_remove
      0.00            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.xfs_vn_unlink
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.vfs_unlink
      0.10            +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.build_open_flags
      0.00            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.chacha_block_generic
      0.32 ±  2%      +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.00            +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.locks_remove_posix
      0.00            +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.00            +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.00            +0.2        0.16 ±  4%  perf-profile.children.cycles-pp.__fput_sync
      0.00            +0.2        0.16 ±  4%  perf-profile.children.cycles-pp.xfs_inode_item_precommit
      0.00            +0.2        0.16 ±  5%  perf-profile.children.cycles-pp.process_measurement
      0.00            +0.2        0.16 ± 10%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.2        0.17 ±  6%  perf-profile.children.cycles-pp.inode_maybe_inc_iversion
      0.00            +0.2        0.17 ±  5%  perf-profile.children.cycles-pp.xfs_ilock_nowait
      0.00            +0.2        0.17 ±  4%  perf-profile.children.cycles-pp.path_init
      0.06            +0.2        0.23 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.2        0.18 ±  3%  perf-profile.children.cycles-pp._get_random_bytes
      0.00            +0.2        0.18 ±  5%  perf-profile.children.cycles-pp.xfs_create
      0.00            +0.2        0.18 ±  3%  perf-profile.children.cycles-pp.xfs_inactive
      0.00            +0.2        0.18 ±  3%  perf-profile.children.cycles-pp.xfs_inactive_ifree
      0.00            +0.2        0.18 ±  5%  perf-profile.children.cycles-pp.xfs_generic_create
      0.05            +0.2        0.23 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +0.2        0.18 ±  2%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.03 ± 70%      +0.2        0.22 ±  3%  perf-profile.children.cycles-pp.handle_softirqs
      0.00            +0.2        0.19 ±  5%  perf-profile.children.cycles-pp.mod_objcg_state
      0.00            +0.2        0.19 ± 11%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.00            +0.2        0.19 ±  3%  perf-profile.children.cycles-pp.xfs_assert_ilocked
      0.05 ±  7%      +0.2        0.25 ± 10%  perf-profile.children.cycles-pp.mnt_want_write
      0.00            +0.2        0.20 ±  9%  perf-profile.children.cycles-pp.ktime_get
      0.05 ±  8%      +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.get_random_u32
      0.00            +0.2        0.21 ±  3%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.2        0.21 ±  7%  perf-profile.children.cycles-pp.xlog_cil_push_background
      0.00            +0.2        0.21 ±  2%  perf-profile.children.cycles-pp.check_heap_object
      0.00            +0.2        0.21 ±  4%  perf-profile.children.cycles-pp.hash_name
      0.00            +0.2        0.22 ±  5%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.00            +0.2        0.22 ± 10%  perf-profile.children.cycles-pp.xfs_log_ticket_put
      0.00            +0.2        0.22 ±  3%  perf-profile.children.cycles-pp.file_close_fd
      0.47 ±  3%      +0.2        0.70 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +0.2        0.23 ±  9%  perf-profile.children.cycles-pp.xfs_trans_del_item
      0.00            +0.2        0.23 ±  3%  perf-profile.children.cycles-pp.filp_flush
      0.05            +0.2        0.28 ±  4%  perf-profile.children.cycles-pp.mnt_get_write_access
      0.00            +0.2        0.23 ±  3%  perf-profile.children.cycles-pp.xfs_trans_run_precommits
      0.48 ±  3%      +0.2        0.71 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.2        0.24 ±  3%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.2        0.24 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.02 ±141%      +0.2        0.26 ±  5%  perf-profile.children.cycles-pp.creat_clo
      0.00            +0.3        0.25 ±  3%  perf-profile.children.cycles-pp.kthread
      0.00            +0.3        0.25 ±  2%  perf-profile.children.cycles-pp.may_open
      0.05            +0.3        0.30 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.00            +0.3        0.26 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.3        0.26 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.07            +0.3        0.32 ±  4%  perf-profile.children.cycles-pp.walk_component
      0.00            +0.3        0.26 ±  2%  perf-profile.children.cycles-pp.generic_permission
      0.00            +0.3        0.26 ±  3%  perf-profile.children.cycles-pp.xlog_prepare_iovec
      0.03 ± 70%      +0.3        0.30 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.3        0.28        perf-profile.children.cycles-pp.memset_orig
      0.00            +0.3        0.29 ±  4%  perf-profile.children.cycles-pp.xfs_trans_ijoin
      0.05 ±  8%      +0.3        0.35        perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.3        0.31 ±  7%  perf-profile.children.cycles-pp.xfs_ilock
      0.00            +0.3        0.32 ±  6%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.06            +0.3        0.38 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.4        0.35 ±  3%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.00            +0.4        0.35 ±  2%  perf-profile.children.cycles-pp.alloc_fd
      0.06            +0.4        0.41 ±  3%  perf-profile.children.cycles-pp.lookup_fast
      0.06            +0.4        0.41 ±  3%  perf-profile.children.cycles-pp.xfs_trans_log_inode
      0.07 ±  7%      +0.4        0.42 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.12 ±  4%      +0.4        0.48 ±  2%  perf-profile.children.cycles-pp.do_unlinkat
      0.12 ±  4%      +0.4        0.48 ±  2%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.12 ±  4%      +0.4        0.50 ±  2%  perf-profile.children.cycles-pp.unlink
      0.19 ±  3%      +0.4        0.58 ±  2%  perf-profile.children.cycles-pp.xlog_ticket_alloc
      0.08 ± 10%      +0.4        0.48 ±  2%  perf-profile.children.cycles-pp.inode_permission
      0.52 ±  3%      +0.4        0.93 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.12 ±  3%      +0.4        0.54        perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.5        0.46 ±  2%  perf-profile.children.cycles-pp.complete_walk
      0.10 ±  4%      +0.5        0.61        perf-profile.children.cycles-pp.strncpy_from_user
      0.07            +0.5        0.61 ±  4%  perf-profile.children.cycles-pp.xfs_inode_to_log_dinode
      0.08 ±  4%      +0.6        0.63 ±  4%  perf-profile.children.cycles-pp.xfs_release
      0.13 ±  2%      +0.6        0.70 ±  2%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.06            +0.7        0.72 ±  3%  perf-profile.children.cycles-pp.xfs_iunlock
      0.15            +0.7        0.86 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      0.14 ±  2%      +0.7        0.87        perf-profile.children.cycles-pp.getname_flags
      0.57 ±  3%      +0.8        1.35 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.11 ±  3%      +0.9        1.03 ±  3%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.23 ±  3%      +1.0        1.21        perf-profile.children.cycles-pp.link_path_walk
      0.13 ±  2%      +1.0        1.13 ±  3%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.13            +1.0        1.13 ±  3%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.14 ±  3%      +1.0        1.15 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.14 ±  3%      +1.0        1.15 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
      0.18 ±  2%      +1.0        1.22 ±  3%  perf-profile.children.cycles-pp.start_secondary
      0.14 ±  3%      +1.0        1.18 ±  3%  perf-profile.children.cycles-pp.xlog_cil_insert_format_items
      0.16 ±  3%      +1.1        1.22 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.18 ±  2%      +1.1        1.26 ±  3%  perf-profile.children.cycles-pp.common_startup_64
      0.18 ±  2%      +1.1        1.26 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.18 ±  2%      +1.1        1.26 ±  3%  perf-profile.children.cycles-pp.do_idle
      0.31            +1.2        1.49        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.00            +1.4        1.37 ± 26%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      0.00            +1.4        1.38 ± 26%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      0.07 ±  5%      +1.5        1.58 ± 22%  perf-profile.children.cycles-pp.ima_file_check
      0.08 ±  6%      +1.5        1.60 ± 22%  perf-profile.children.cycles-pp.security_file_post_open
      0.00            +2.5        2.47 ±  6%  perf-profile.children.cycles-pp.up_read
      0.32            +2.5        2.86 ±  3%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.04 ± 71%      +2.6        2.64 ± 17%  perf-profile.children.cycles-pp.common_perm_cond
      0.05 ±  7%      +2.6        2.66 ± 17%  perf-profile.children.cycles-pp.security_file_truncate
      0.12 ±  8%      +3.7        3.79 ± 16%  perf-profile.children.cycles-pp.apparmor_file_open
      0.12 ±  8%      +3.7        3.82 ± 16%  perf-profile.children.cycles-pp.security_file_open
      0.06 ±  8%      +3.8        3.82 ± 12%  perf-profile.children.cycles-pp.xfs_log_space_wake
      0.14 ±  3%      +4.0        4.12 ± 12%  perf-profile.children.cycles-pp.xlog_grant_head_check
      0.14 ±  5%      +4.2        4.38 ±  6%  perf-profile.children.cycles-pp.down_read
      0.21 ±  5%      +4.3        4.48 ± 13%  perf-profile.children.cycles-pp.do_dentry_open
      0.22 ±  5%      +4.3        4.54 ± 13%  perf-profile.children.cycles-pp.vfs_open
      0.15 ±  3%      +5.1        5.28 ±  9%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.16 ±  4%      +5.1        5.30 ±  9%  perf-profile.children.cycles-pp.security_file_free
      0.36 ±  2%      +6.5        6.86 ±  7%  perf-profile.children.cycles-pp.__fput
      0.52            +7.4        7.90 ±  7%  perf-profile.children.cycles-pp.__x64_sys_close
      0.72            +8.3        9.06 ±  6%  perf-profile.children.cycles-pp.__close
      0.20 ±  5%      +8.7        8.93 ±  6%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.23 ±  4%      +8.9        9.16 ±  6%  perf-profile.children.cycles-pp.security_file_alloc
      0.25 ±  4%      +9.1        9.35 ±  6%  perf-profile.children.cycles-pp.init_file
      0.36 ±  4%      +9.7       10.07 ±  5%  perf-profile.children.cycles-pp.alloc_empty_file
      0.16 ±  8%     +10.4       10.56 ± 11%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.44 ±  2%     +10.9       11.38 ± 10%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.44 ±  2%     +11.0       11.46 ± 10%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.55 ±  2%     +11.3       11.86 ±  9%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.62 ±  2%     +12.0       12.60 ±  9%  perf-profile.children.cycles-pp.xfs_trans_alloc_ichange
      0.27 ±  5%     +17.2       17.50 ±  7%  perf-profile.children.cycles-pp.apparmor_capable
      0.28 ±  4%     +17.3       17.58 ±  6%  perf-profile.children.cycles-pp.security_capable
      0.29 ±  4%     +17.3       17.61 ±  6%  perf-profile.children.cycles-pp.has_capability_noaudit
      0.81 ±  2%     +22.5       23.27 ±  7%  perf-profile.children.cycles-pp.xlog_cil_commit
      0.94 ±  2%     +25.5       26.48 ±  7%  perf-profile.children.cycles-pp.__xfs_trans_commit
      1.92 ±  2%     +55.1       57.07 ±  3%  perf-profile.children.cycles-pp.xfs_setattr_nonsize
      1.94 ±  2%     +55.3       57.20 ±  3%  perf-profile.children.cycles-pp.xfs_setattr_size
      2.06 ±  2%     +56.2       58.24 ±  3%  perf-profile.children.cycles-pp.xfs_vn_setattr
      2.13 ±  2%     +56.6       58.68 ±  3%  perf-profile.children.cycles-pp.notify_change
      2.19 ±  2%     +57.1       59.25 ±  3%  perf-profile.children.cycles-pp.do_truncate
      2.63 ±  2%     +66.8       69.43        perf-profile.children.cycles-pp.do_open
     89.00           -85.7        3.27 ±  3%  perf-profile.self.cycles-pp.osq_lock
      0.28 ±  6%      -0.2        0.13 ±  5%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.33 ±  3%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.lockref_put_return
      0.10 ±  7%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.08 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__x64_sys_creat
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.current_time
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.list_sort
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.xfs_trans_free
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.xfs_trans_unreserve_and_mod_sb
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.xlog_ticket_alloc
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.xfs_vn_setattr
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.mntput_no_expire
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.set_root
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.vfs_open
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.check_heap_object
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__check_heap_object
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.fd_install
      0.06 ±  9%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.xfs_trans_alloc
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.xfs_inode_item_precommit
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__check_object_size
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.security_capable
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.xfs_release
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.get_random_u32
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.getname_flags
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.xfs_can_free_eofblocks
      0.00            +0.1        0.07 ±  8%  perf-profile.self.cycles-pp.path_init
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.lookup_fast
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.refill_obj_stock
      0.00            +0.1        0.07 ± 25%  perf-profile.self.cycles-pp.xfs_trans_reserve
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.map_id_up
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.security_inode_permission
      0.00            +0.1        0.08 ±  7%  perf-profile.self.cycles-pp.__xfs_trans_commit
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.do_sys_openat2
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.xlog_cil_insert_format_items
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.x64_sys_call
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.xfs_ilock
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.xfs_trans_alloc_ichange
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.make_vfsuid
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.path_openat
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.open_last_lookups
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.xfs_setattr_size
      0.00            +0.1        0.10 ± 13%  perf-profile.self.cycles-pp.xlog_calc_unit_res
      0.00            +0.1        0.10 ±  5%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.down_write_trylock
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.lockref_get
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.putname
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.xfs_setattr_nonsize
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.xfs_trans_log_inode
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.alloc_fd
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.xfs_inode_item_format
      0.00            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.05            +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.chacha_permute
      0.00            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.xfs_iunlock
      0.00            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.locks_remove_posix
      0.00            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.do_truncate
      0.00            +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.build_open_flags
      0.32 ±  2%      +0.1        0.46 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.00            +0.2        0.15 ±  6%  perf-profile.self.cycles-pp.__fput_sync
      0.00            +0.2        0.15 ±  4%  perf-profile.self.cycles-pp.process_measurement
      0.00            +0.2        0.16 ±  5%  perf-profile.self.cycles-pp.inode_maybe_inc_iversion
      0.00            +0.2        0.16 ±  2%  perf-profile.self.cycles-pp.xfs_assert_ilocked
      0.00            +0.2        0.16 ±  3%  perf-profile.self.cycles-pp.do_filp_open
      0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.2        0.17 ±  4%  perf-profile.self.cycles-pp.__close
      0.01 ±223%      +0.2        0.18 ±  3%  perf-profile.self.cycles-pp.inode_permission
      0.00            +0.2        0.18 ±  2%  perf-profile.self.cycles-pp.step_into
      0.00            +0.2        0.18 ±  8%  perf-profile.self.cycles-pp.init_file
      0.00            +0.2        0.18 ±  5%  perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.2        0.18 ±  3%  perf-profile.self.cycles-pp.notify_change
      0.00            +0.2        0.18 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.2        0.18 ± 11%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.00            +0.2        0.18 ± 11%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.2        0.19 ±  4%  perf-profile.self.cycles-pp.hash_name
      0.00            +0.2        0.19 ±  8%  perf-profile.self.cycles-pp.creat64
      0.00            +0.2        0.19 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.00            +0.2        0.20 ±  4%  perf-profile.self.cycles-pp.generic_permission
      0.00            +0.2        0.20 ±  3%  perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.2        0.20 ±  5%  perf-profile.self.cycles-pp.xlog_cil_push_background
      0.00            +0.2        0.20 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.2        0.21 ±  4%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.00            +0.2        0.21 ±  9%  perf-profile.self.cycles-pp.xfs_log_ticket_put
      0.05            +0.2        0.27 ±  5%  perf-profile.self.cycles-pp.mnt_get_write_access
      0.00            +0.2        0.22 ±  9%  perf-profile.self.cycles-pp.xfs_trans_del_item
      0.06            +0.2        0.29        perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.2        0.23 ±  3%  perf-profile.self.cycles-pp.creat_clo
      0.00            +0.2        0.25 ±  4%  perf-profile.self.cycles-pp.xlog_prepare_iovec
      0.00            +0.3        0.26 ±  2%  perf-profile.self.cycles-pp.strncpy_from_user
      0.00            +0.3        0.26 ±  2%  perf-profile.self.cycles-pp.memset_orig
      0.00            +0.3        0.27 ±  6%  perf-profile.self.cycles-pp.xfs_inode_to_log_dinode
      0.02 ±141%      +0.3        0.29 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.3        0.28 ±  4%  perf-profile.self.cycles-pp.do_dentry_open
      0.00            +0.3        0.32 ±  3%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.01 ±223%      +0.4        0.41 ±  3%  perf-profile.self.cycles-pp.__fput
      0.29 ±  2%      +0.4        0.70 ±  7%  perf-profile.self.cycles-pp.down_write
      0.00            +0.4        0.43 ±  5%  perf-profile.self.cycles-pp.do_open
      0.06 ±  8%      +0.4        0.49 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.09            +0.4        0.54 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.18 ±  2%      +0.5        0.65 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.19 ±  2%      +0.5        0.71 ±  4%  perf-profile.self.cycles-pp.up_write
      0.12 ±  4%      +0.6        0.69 ±  2%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.27            +0.8        1.07 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +1.4        1.36 ± 26%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
      0.18 ±  3%      +1.5        1.68 ±  6%  perf-profile.self.cycles-pp.xlog_cil_insert_items
      0.00            +2.5        2.46 ±  6%  perf-profile.self.cycles-pp.up_read
      0.02 ± 99%      +2.6        2.61 ± 17%  perf-profile.self.cycles-pp.common_perm_cond
      0.12 ±  8%      +3.6        3.77 ± 16%  perf-profile.self.cycles-pp.apparmor_file_open
      0.06 ±  8%      +3.7        3.80 ± 12%  perf-profile.self.cycles-pp.xfs_log_space_wake
      0.14 ±  3%      +4.0        4.09 ± 12%  perf-profile.self.cycles-pp.xlog_grant_head_check
      0.14 ±  4%      +4.2        4.33 ±  6%  perf-profile.self.cycles-pp.down_read
      0.08 ±  5%      +4.3        4.41 ±  7%  perf-profile.self.cycles-pp.xlog_cil_commit
      0.15 ±  4%      +5.1        5.26 ±  9%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.10 ±  7%      +6.6        6.67 ± 10%  perf-profile.self.cycles-pp.xfs_log_reserve
      0.10 ±  6%      +6.6        6.71 ± 11%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.19 ±  5%      +8.7        8.86 ±  6%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.27 ±  5%     +17.1       17.42 ±  6%  perf-profile.self.cycles-pp.apparmor_capable




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


