Return-Path: <linux-fsdevel+bounces-67854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37663C4C11E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795484235C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FDF34A78C;
	Tue, 11 Nov 2025 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G93jSm5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF505346E66
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844768; cv=fail; b=JiJywlICr9NDW1GfY861Aml5ngEVTuowIAdP4/yJhrgC8LTKQ5q/WnY3RbDH7gsNPg1Ilz/ZJHzcawZpq30ku4gJx9Jg0FdsG6laHLkrXJpzhZewCwzZcesOmQVAgQznzULy9Jjl1M2Zb3txz5R19GnlPqWrPwggWGeeLEt/0yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844768; c=relaxed/simple;
	bh=joJ8gqicDFmkO14QYXxSLjWLPbrTSwyZv+5vog5jFoA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GDNDvpQdPyol1KoXl7tPaYzgEM7mYpapTIzTSZMvjvYRW0CYLQRx+zNmaEVkck1mJhk/PVTkpkvYFNHzGHGvKIgMzSk6adIpQfCwrhqHSv2N/yo9IR3x8Zd8wKogGSutnuumKbRO66HjqpBiAk8AHNAFncjf6dYB5bPRxCDlErU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G93jSm5o; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762844767; x=1794380767;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=joJ8gqicDFmkO14QYXxSLjWLPbrTSwyZv+5vog5jFoA=;
  b=G93jSm5o+T4GsNakrzlX+vKy9xMnW2fgS/hnw2ct+qCnVzuJrT7mHvMa
   KPh5NKVAoA+S+kzcx2n+CBasF6H63F+rYfzMsfTexYzcWBO61nqhMhryu
   Gcd9TiuO0slrsF5KfFWjIqHxv1zcs1IWCme543YJphIgM/Zy+bV8521+N
   TreQPdmWcEcH4JibnM76vfDkpeeUYyL+egiSHZcZBAIhcClWN4cOj8K7X
   D+0epFH8slC6nAEdNX0ZsWl7MJYWFra0im2xPX5WF+sR+MExfKhmyi3r+
   YkPgukNeO5fjDuLrfZMk4nVqzm45NQ6fEs8tZ1+ABygDyXGQtcCjMIduR
   g==;
X-CSE-ConnectionGUID: 68aAS5qrRFe0B7zRw7T8AQ==
X-CSE-MsgGUID: 7Io37KTcQDSfeCfbqR4rtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="65059379"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="65059379"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 23:06:05 -0800
X-CSE-ConnectionGUID: TqOIBBvoSPiFmgnS1pXkMg==
X-CSE-MsgGUID: nMYD7pN2SkqRJAl7rH4C2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189629992"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 23:06:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 23:06:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 23:06:03 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 23:06:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MB0QT2zgCTY/s9zkd8Om851AzLGxKftmKau5oblyjYP0nIGaW6tIMx2zBAvZZ9K0YghfdSBwx89f443bSvL4hxDG10KqG2voal55cwcknmBAgwYXMpmTOEIpbfkt/Jrkmh7Wl31D+jrGqmla6SQ2kxgPR8pw/HyWSaYaG7GTForN/EHAgZP8hhGR2mJ+gG8jlb60W39WtVkKM/2PW7Msm120LlSGQQZIYfKeghflDa5ozw+pxyrHmvObO8z2q26t+65RBkGzy7/7paz+JPF8akiNBkTsSoyD+24fdovRpnngdJXmIu2Y3cO1VvRiDlRGV/KcP42MuIUaVLHai711dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KpC39WL8NM+3KQ+0I20JaGlgFMlTaXCwzd4LIoSovQ=;
 b=XmFKHason+8AclvHjiJRQDPz1Eo8jXJ6C4LZEtw1efrh9TsvO5/sqMFlSBf888apRaEF3X6tEkgkE5oJKX/QmkKhAikXu34eVvq5YhNVuJq08J0IW4WYvyt7+mLhVl7cNygdOXkugMo/vj+/JiVcMvKDBDp8NEnpP6jZq5NMNrYVapdPj9by1IdoA7cwd9uEMndy5/hGbMmj4QkOp5KIRw5IjDgcq4mG3eDndJokX/nB+77WwiWVj5p8/s0+BoIQTc7zD3JWMpGg4IS8DY9n66XLIv+x4g7uLE0OQazANW2JYqsrSnPS49vkdBuMhuN0B8YoWWSkCR/LTf1U4rWlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPFF2B8F6C64.namprd11.prod.outlook.com (2603:10b6:518:1::d60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:06:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:06:01 +0000
Date: Tue, 11 Nov 2025 15:05:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Christoph Hellwig
	<hch@lst.de>, Hugh Dickins <hughd@google.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  60a70e6143: xfstests.generic.363.fail
Message-ID: <202511111513.2c44a63e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU1PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:802:18::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPFF2B8F6C64:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b6ce2c-8b2b-472f-0ce5-08de20f0c566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GKgBiaeIdJOh4v1jIKDHTQ5RpoiQhHf0jH8WScWbQ7EIy6XEsNrM5yPiXJiM?=
 =?us-ascii?Q?U+5/4dW/fmL13YW+F1KxQLCRNl4KLOUhfIZ+JRI/YQfj9Uffl0txMEnNDTIz?=
 =?us-ascii?Q?PJhk44Ewvmnt31aEBaASP9ljFsnEUs242pLotQFC1Ll+kOxXlOBk+vJPCqZC?=
 =?us-ascii?Q?1BfPym99EqEfJlyRDxJm8W/XeGe9R5pUuHjANrtBA0BzS6aiX7Rgr7qSN1LV?=
 =?us-ascii?Q?eXU2U+V4XJzr2RVV1RXA/5U9xYYIUx2auCzNoPZrgdChIdoCxlCrLCbfkqMZ?=
 =?us-ascii?Q?Tq3YU5bprs4euT026/rxecN3IWAdOAyAmrL1DVfkWfcXRF1pPeKjGGTK4iHI?=
 =?us-ascii?Q?mPgD2sA062Aet8q0YVYCsYsAf8o/RK9p604waFq6TQtQWIsJWFAmfh/Or6wi?=
 =?us-ascii?Q?t15uQI5+fodWkKUZDorXgUct5ckmVxvzDNSDqONyL3dcvqbtFW49wY1/j+EH?=
 =?us-ascii?Q?J7rUAmlj43gQosrPtYgqLiCn8vwycyqQhJmMiyEGWF36y9WoyNcnlnfPTQvq?=
 =?us-ascii?Q?dmVo+6FYPXQeu4UNLvs/ftKZ/phpzuWIZdTpwRY0Dc59zcNwGv1d1w84EvD7?=
 =?us-ascii?Q?0wGvnXVH6l2ibHJM48gigOmWxPOb0IOqRblv+AZqf5piJSW2JLCRuJUBPEsa?=
 =?us-ascii?Q?FDhjkeGNMklJMUACtr4oyeZH2VzHMkB4pdf7ppE/hZybLZYjlz5LkU1wNYgk?=
 =?us-ascii?Q?YocOo0ePdBuEYqJfMd+GVCt/Iq3MUWuxqjf0eq7Yuf5ZMZx+GCgtWGK1aK7G?=
 =?us-ascii?Q?6fwyH00kBDp/EN7ber8bNRjjoSr4e4EPLhwmU0zD4p9G68/E9Gg3EdT6vSlM?=
 =?us-ascii?Q?YCQDaQ+mTn7auMxSC3+sVbFZPrH/wJTZQJ3UxtLrnLAh2PwgDE4Zu+rZDN4i?=
 =?us-ascii?Q?MbyXmbWiSf0AFuKAhljCl3FSEkr0/C9xG95D3VS6bRcc8qH6Ejior8HniaJs?=
 =?us-ascii?Q?UDhPT0qtLchNXxhapXxr2SXo/GhIw2alTKkn9eyjGCCdN33rwwEuECHAPa9T?=
 =?us-ascii?Q?LcTMA2SPnWX8lWNHmB95tb+uyBQakRukbKRB/Fs43s0ONkIYuzNFxevPHtAR?=
 =?us-ascii?Q?zyPLMd1bjqt7R3TCzWt6pplIjXkRfAGoBvSdGayqvJhLQ90B8mVBYKyZMKxc?=
 =?us-ascii?Q?1yYfljRm+oBAUotJ4EAGSY2+C+WRMw3CwEAw2K1EY0q8Qq8zRTSksTKBNsyn?=
 =?us-ascii?Q?2ygMPxoV6Xwo3XY2U9NC1AIAY5pJ8NoyQ0/zAAz1KA3IwOmRvD+UzV/Ce0JR?=
 =?us-ascii?Q?yZW1vsYsYxsRG3BrDC/xzqybKOooGExNvMC0Xhs/mu7beh6LaKe1TqDuXULy?=
 =?us-ascii?Q?BLMV+rTfvZrYzcqUAUGWeZ+J4oJydQVqqExw14QNnBj0sUzQMIBShiF3hiXD?=
 =?us-ascii?Q?yD8TH+LbNKIDzeqMnuk47SLfp+5dVVCsKdrnEXwDsuT7a5QwPScGgdD08MDX?=
 =?us-ascii?Q?bcXLq2HO6m2/+oPi8jiofEXuYwKndlFTsrRQ1iYORUy18eZiJhN4KA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EADDwzhsS8SrJ5XA9OHzdh/e2UTR66gjQCHLyORwMrRdBLhP1xwYMuqQsiJG?=
 =?us-ascii?Q?6ml6mfqHrBWE/R+GW712hHmVA0agD4kXPhfRPTtdNLeKTLkbWeYI1T2EiopY?=
 =?us-ascii?Q?yqrIZCgTC4Q2oRCKauAMEM5kO80pOFL+c/+3UkRxJPoUBI9jewLza7/v/WB0?=
 =?us-ascii?Q?bSalu87EfnoX8at/4hqBi9otLUSZLzrfYFxTIX23LsxXXILtUeYqxPEMAhJl?=
 =?us-ascii?Q?e3No+drGSearfDL+Pozij5CQbNj4HVDKYvNM4KwRKpY3WbU+RXWtXExZ28TV?=
 =?us-ascii?Q?WlGqXcIbMBj4p+8vqSSGIZibQ+Rei+i3ejdw9BVeInWqqILpbWbDgodNyUFn?=
 =?us-ascii?Q?j1fveXwH04vHlDg4QFfoz9yrd+tAM/36fdmI8dMcgsEEEp4JeKCLrH8x0q+G?=
 =?us-ascii?Q?SFWIDXoQYA0TY94QUX9MGILfP1N3q8DUf9FA6iI6+HRZo8avuEd6L96NL7/+?=
 =?us-ascii?Q?rp3Ym59pGzToztGpvQDT4a15pYOlaH+9qLs/PU9FIAbtN6evh6Tz6X8avJ86?=
 =?us-ascii?Q?EFFqQgBMy3UDHP/A29DoYlXjqK1bk4glmwiMO5yBOzIA4e/uZQHkZhHWIH2I?=
 =?us-ascii?Q?VhQDH+HnDl1jawoutwEXYHZOkbtzRC6YtLczJxb7jEdxy+ZFfImOXeqt6B14?=
 =?us-ascii?Q?aU7Crvvsl5WmbPt28dlZkLlVE0CZg8e11/w1DmsNXgU3w5ydW5mLyTSClQa/?=
 =?us-ascii?Q?W/wZP/OXbFIWzASPRr6LxF3c3FU3Wket3pD4fMjIq63nr0+IHI4xWFqd4fUl?=
 =?us-ascii?Q?YBsrXt0wpGOEnBVFudAGGwiKTlzy5l+Bu9+TgZ55QhHcDxXtr+dkTUvcEBoq?=
 =?us-ascii?Q?twg+yHOYPVp+VbPDrtuxB4so5u9sFla82amzitzi5HV1BO9oPtQw8S/mtHzG?=
 =?us-ascii?Q?enzreMDzdYPq3rYjAd+DASWBX0+2gIdf/udhpYuA5H1Qn/8fexbecmcHKtYl?=
 =?us-ascii?Q?f+wctwTVLI7qWIjRQgXvSWMXwd57UXV+E5Joi2wteD2i7iXKR0+Rmd8O9hMu?=
 =?us-ascii?Q?4Hk/nPTrTe9pGyFKRvfw3iwfvps31Qb5hdAqfAgHdP3SR8Wg08bwURHCeFt+?=
 =?us-ascii?Q?D/3C87hbKZ8OegO4jwYr/Xr+2+rtMkXBRHJIq15CFNgJ21BTXLif7LnvCY1R?=
 =?us-ascii?Q?nc9zXHtGvhjPJIgR73f+xogH+zhxcdYgzpsllzh6NlyKg/wGxwqtqBLRg51x?=
 =?us-ascii?Q?/lWft/hmVatyfCqeL0ZrHe0ZVVTguyRXpvpWDbpYcAaNJGHvpMyTtSoumCJn?=
 =?us-ascii?Q?yEdYEphbF9OXdqmf3uShNdN1sazgGga4DvrxdKm0kJEkvPNoqYjAsXugCaPw?=
 =?us-ascii?Q?jSpNO5UVnsSby1+Ipuq9lnAsTbTV3l86fw2wiosWEp/wzedAz3gTv8OAcMuL?=
 =?us-ascii?Q?vouEHHwsfvCnJtGAXrT7f8bJHBv/FhCUga48ChHAe+2Fq2nObDygCtAtXMkT?=
 =?us-ascii?Q?rKSKUhqLk9Ge1iySC9ugRtkPEqdir5uo87J2neiShOiBAUCCrQq8pfRzsamO?=
 =?us-ascii?Q?25ggrkmylw2bBRzPRt6ZEhYRaaYMifH6y6o5dHNQHRMCkGFfpqDcMJE26WxL?=
 =?us-ascii?Q?Q0MJt3L/2PV2hYK4V7qvSF5zQowY0rEPKmU5GV8mhulzSM1QyCEPM5q8YoPV?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b6ce2c-8b2b-472f-0ce5-08de20f0c566
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:06:01.1240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1ff8YHT7ZHca+RkFTTTBkS0KbqVoJGOc1ALBUbvSbsdqijDb9YXjztkextMF9Q8QXUl5yy0CKgRrlYqhWQ9vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF2B8F6C64
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.363.fail" on:

commit: 60a70e61430b2d568bc5e96f629c5855ee159ace ("mm: Use folio_next_pos()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 9c0826a5d9aa4d52206dd89976858457a2a8a7ed]

in testcase: xfstests
version: xfstests-x86_64-2cba4b54-1_20251020
with following parameters:

	disk: 4HDD
	fs: ext4
	test: generic-363



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511111513.2c44a63e-lkp@intel.com

2025-11-09 02:50:19 cd /lkp/benchmarks/xfstests
2025-11-09 02:50:19 export TEST_DIR=/fs/sda1
2025-11-09 02:50:19 export TEST_DEV=/dev/sda1
2025-11-09 02:50:19 export FSTYP=ext4
2025-11-09 02:50:19 export SCRATCH_MNT=/fs/scratch
2025-11-09 02:50:19 mkdir /fs/scratch -p
2025-11-09 02:50:19 export SCRATCH_DEV=/dev/sda4
2025-11-09 02:50:19 echo generic/363
2025-11-09 02:50:19 ./check -E tests/exclude/ext4 generic/363
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 lkp-skl-d02 6.18.0-rc1-00010-g60a70e61430b #1 SMP PREEMPT_DYNAMIC Sun Nov  9 10:29:45 CST 2025
MKFS_OPTIONS  -- -F /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/363       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/363.out.bad)
    --- tests/generic/363.out	2025-10-20 16:48:15.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/363.out.bad	2025-11-09 02:51:05.593092955 +0000
    @@ -1,2 +1,9399 @@
     QA output created by 363
     fsx -q -S 0 -e 1 -N 100000
    +READ BAD DATA: offset = 0x28db4, size = 0xed5, fname = /fs/sda1/junk
    +OFFSET      GOOD    BAD     RANGE
    +0x29a39     0x0000  0xa079  0x0
    +operation# (mod 256) for the bad data may be 121
    +0x29a3a     0x0000  0x79a6  0x1
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/363.out /lkp/benchmarks/xfstests/results//generic/363.out.bad'  to see the entire diff)
Ran: generic/363
Failures: generic/363
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251111/202511111513.2c44a63e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


