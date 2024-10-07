Return-Path: <linux-fsdevel+bounces-31178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610B992D63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5427EB254CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DEF1D435F;
	Mon,  7 Oct 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMSPtdQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DED1D4333
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307909; cv=fail; b=d0Wxsn3ac4ozVOodovX6e7fYJ/Oo8iXwSHjf0du4W/xuydWEMbXr5IkTY3FUFQwCfqQucO1srzDjaiVJlJMF+k+r/xxxhWwzOEUUfZ5gxA8mjRIUeK1xfzr32/xpPMfB+LYk56bCSMDL9rspewomJNt+icwqJoZWDH3a4h4yxic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307909; c=relaxed/simple;
	bh=UC0cq2F0PpG4VSJx9+ZMudtNddZ+me+lpaD/v9t9TU0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BRLndujbIIlVRY9v1mCdM6xSzNcJ+ZY1zh3FRCldr/rM9TEB2DA++5cHpCnL3I+so0sTcfcjEZe0Rphkt/p4qnsDqKRSu0QupRuXySxM33Oxb7U9HugJXPZTUNgJXyOu86PmevSr62ZN+37ogq40ZJ5qQE9MgcVUWsKjaAWTKFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMSPtdQy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728307907; x=1759843907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UC0cq2F0PpG4VSJx9+ZMudtNddZ+me+lpaD/v9t9TU0=;
  b=JMSPtdQye8x0tC04xmFfFWn+m9qz95MhYbOpSEk9+iRDUm2lVAeAyodN
   XTFag+UBEC6l5YDZT6Zk7AhlE9AqJheLgv2VllN0ZMyXqGfgWsM6qgaVW
   tkiWSyYDTzmXYXkzpbbWlHfEpOwsDv0udTkrS0SFtlPevarayPfk0Lf+2
   FFQ+EunDWWu+UIoPJ9zXQ4/QBuvCHkuVcbLALHmRknOaRcDDVpFIXRK3r
   0cUGvPI1HEqfWgf7J2CrSvddLQRV/YW8j51TB8dz/Q2Zi5QV5kClnkWCv
   +P8t4dH7y0BIpjm+0cKkSux8yqCGTvgRBRx6Fu2FkoQQazEjD4StXGQV5
   Q==;
X-CSE-ConnectionGUID: rEQzsDJwR4O+yzQjR/IBTg==
X-CSE-MsgGUID: ztfkLn/yQCiZQy5a63Og0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38059626"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38059626"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:31:34 -0700
X-CSE-ConnectionGUID: /9O4c0ZfSEqhlSw9qMdGBA==
X-CSE-MsgGUID: h59H9812RhOVp7CM+Q25rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80452400"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 06:31:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 06:31:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 06:31:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 06:31:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 06:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMCXXdIFIkLFOxpqhB6o7sp0wx68St4Z8yj3euECKCGazkc3x3fjjl1CVeluGNUGa74/86re9Q0SgO6L6vkqEEm83O0mwZ5OLgomoCFJiJX+isqfTNJ/PcnyWXAh/TZheVDwiBsbj9I5mQnaHO2TEIbBt32G17QlmVORncXVYDkbkF3WBr0H0akHCHCrmcopHBQuzruwXn2qlSYoSMR9cZQZ9isRhIhBWiKcP589hkC4+F4cHdvm93+RDEXsNTYXOkII8XxxUJaUnbLwNvM7L/Uw7BT8GIr68Fw1/E5cwXSd2wRFMTRgxxbgYCVo8R2FQuDD8riy5DjW9Ufd8NqA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qef7aEP7OGP+p1UrVk2CzLwkQ8CmauywZ1ytXaLuCFM=;
 b=ugnGbKzGZbqqQj/qoVDZ4NO5UJVYnP7JAg99xqqCtYsCUJbSs4dUeFD4X6+BRhwxzpiA8WW2iSalWhUJd/q9EH6710qE9OLCnBVpoYSU5NpkckfJJ/0xFGouvb3FNm0lsUsmPOn9lDmB24nLzHZZ0+Qrx3YMWzfUUJeVvbb+5dHOgIA6o5s3ZC2AeidNAbF41bllSqM75BF0ZT7Ih/ZXguit5Ia++UOewCFFcZ5Q7o+S9ABvualQTC9n0KJcsZPmmfmgSu7ME7L/JQFLKXAbUjQxEmiWmR/gh7hGyFJtM8m/pvO0Qz45MAd60xTlv/M2RJBYAeY7QlUo7JB3GsBBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:31:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:31:28 +0000
Date: Mon, 7 Oct 2024 21:31:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [viro-vfs:work.fdtable]  2b6b3f37af: segfault_at_ip_sp_error
Message-ID: <202410072137.2c3cf4d2-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be7d36a-9936-40c9-aaec-08dce6d458bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2qDb6qHlef5OjqDNZDk5i9u40gLZ3Ly0cFjzTimmbrewqLIjUl55qOoDqHtp?=
 =?us-ascii?Q?K/g0J2O/sJfUv+05G5s0p6MDS11dhOhLfVIi7J5Zz6NZ/Oq3tmjYX3jjO7qY?=
 =?us-ascii?Q?own7lsHM0Y94z21hMFNEf3CCDS4Vr8tVJsBZdx1vBM35c8uRDGgLFwfDWIJe?=
 =?us-ascii?Q?747rrF+86uDujZ7/ADgH62yjRn2Lk7EPEAnvXX6He+T/2dagYGjmI25PfxuR?=
 =?us-ascii?Q?oW8gzPaGY/WpdoT1yos5Wg0hWXHNpShSkQtOxSQiD6fi24ERgrTRR8c19xuq?=
 =?us-ascii?Q?ERNu/0w2QSMT3U/qhTh+bc5JEigy3G5zcNL7ZQNbdeFu5sb8ZgWay0HD+Mc9?=
 =?us-ascii?Q?8ba+OFjipvayXKu1ZUMlEv2S67arsOirjMki8NXsy/KpChqOCPPHZyEI12hk?=
 =?us-ascii?Q?siQovlVFd9Ythtwr4j+Ygz5fdCRGXda7VRGP5ABwT79+wNXPDvXoAT/S5Le7?=
 =?us-ascii?Q?uBgssxJtvJkvMw2a6/idvL7xNdCpiZKhSxbG1MNZ8jOvEfhJAY1aPnwkW2hl?=
 =?us-ascii?Q?l7f+Zm2woCybtiOMJm9myueMhCy6Clx+5Op9mWzoENogiFEvOCr9UEtqPvVI?=
 =?us-ascii?Q?WdhgA6OeEOKURZS3GwmhVptgbLbdawjOdb2wJ8iH1h9vnC/m9lZxHT9hHhYU?=
 =?us-ascii?Q?B2VGPD7Sa4AIisXIBmBx7PAu2Y53gVc3KEH04iBNSdb9T4bg+22F16cLTWse?=
 =?us-ascii?Q?O37cvLjKRThwbsWsmiD//Bv7Sp1hOUUe1PiHruFu3ZI2jYVlonsLxPbONc1H?=
 =?us-ascii?Q?Sb72cd2fAyVxs57RxyO9+qaVj59v5L/PooJBxeyBSfSIMlHZwlt22at95tL9?=
 =?us-ascii?Q?cLyB/MOGuHFWH6VZo7zc/OvGrMLyToZFRPsETzhm03fogTZGW9ifrS2h7p+L?=
 =?us-ascii?Q?SlHaWTXk7aF0tDWwtKKLxl6N7BePtKIfXskTH3H8xT0EGzUv0UEQFs5CLcZx?=
 =?us-ascii?Q?NhvlhMh8wnD0Ymils28N0xTyYt1k6XrSbcXUwDxpMCvSe4rq57irOJWv1bBa?=
 =?us-ascii?Q?jBftHNxwgSGrp0ydmdXIElkaugsgEQArfJF7zZpmU+b32vhXulLai7OHM6Kl?=
 =?us-ascii?Q?PzSzaJ4kbOi7i2PcpTknn5M/qXRVihDugRSBtxSbhBOMH5kRBP89r3LjULN9?=
 =?us-ascii?Q?WuZ9/DJ0KnzRDJ8UE8u+qKKRcTqpI/PWmV6OR730N1vT4nzUBd8KcYeAnGJn?=
 =?us-ascii?Q?banZpxKYRHMJQ2y1/6kn/HDhbqOrzDQUrVT0OLlKILHwBxOoA9Am5gJmLPry?=
 =?us-ascii?Q?zimPWZqlyHClDB4c8i00TxkbXwZYHd22J0vxE1NmFmQOxBd1jk07q/LDj76T?=
 =?us-ascii?Q?Tp8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1gkkh5Uelb4UOr3rcqfG/2o4NDgv5wjdIacJ5o4DPgqQVlx1S/o8QaoOyGWP?=
 =?us-ascii?Q?+oH6p4iNDdH2/C/BrUW2ysin49R+OEu9GvBwZrG9qO/PDwRLe0Se5g/Gz8jk?=
 =?us-ascii?Q?98Aa8gX2/+ae0yHX2P45j0o/738hgVEVzqbZKaVspRJ/vKU1D42PNMWupoeY?=
 =?us-ascii?Q?cLP4Rbqs9WiI62C6+RZ27UNoY6jq21XjtQrJd/ssXOiGMvWkUjakTdCQkhVp?=
 =?us-ascii?Q?7BK9nXlkM/xjbu43xar2eR6BUKVHFQfXtWZhhVp7CxV5ecgCHbV0sX/MzCbu?=
 =?us-ascii?Q?keb8sTZRhWuhS4hcwvSwCyIa6XWAOoVD3KAwCaQvw53Io3++67lE9Q8pGQTi?=
 =?us-ascii?Q?AZ+M/5nP+66B0Fqkep4DTpRKqsi/26ADzg92NE277sCLuL4sqQXk0EjBsOxt?=
 =?us-ascii?Q?bipJsutJVUvsAFlhJHLGmhz3lMXEVlonZ6wzw6Qbq+gjrkvx9eueFNLBUu4b?=
 =?us-ascii?Q?0utT4kvcyRmeADi8tiWb5NnKmwJLtdmu0S/3PZGDwP3xpVAXTC7DQcBOaCiP?=
 =?us-ascii?Q?fE7MpzylxGuxmKrnp4gmaZZqzChjrXa3LhRac5W8kD3ezB4XwBXrhBKOQsYN?=
 =?us-ascii?Q?fgjxjnsSnfpaqHFKjwwBaAizPN6gTG7fRZlFwNsSZn3nafnhjLyGdg2xKq6i?=
 =?us-ascii?Q?cuxUb018hDpM6Vv6mHxOsHHmYzNN8DrU3sL3FpJy+53CXRnt84AhJJnVcgCh?=
 =?us-ascii?Q?6n/3iN4BWik02SBCa7ZTG5PnuKR2gypct/xOZuw08nnhfS2BK5PtfDS4YTPF?=
 =?us-ascii?Q?roXeNLSLMEAVWXGB9zDLCrUU0mDn8pgQIsnJb//r8NZMMeZMbNGC/HLs7n8Z?=
 =?us-ascii?Q?yTAQjUQfVp5VblkDrHY3zXnJaDrKixpUzxPUWBI5EarjHqLDCMXPomAY1Ymi?=
 =?us-ascii?Q?17wjZdLC120Y9nQmy2m05aa7uhuclzqgySf/yOKIHifmHZ3PWbMxsLJxxU5H?=
 =?us-ascii?Q?Ct9zZ+MXGvCNOrN255dXkQeQgTKhuVB90b21a7TxycSaxFNlDXy8uFbdp3n0?=
 =?us-ascii?Q?qMy7PBVPUulQRuhwJXhRUXSGDLNlptxQ7vOmOMzZWHovr0dFAlDnkqWJLejN?=
 =?us-ascii?Q?0inFAa9a9XDempz/+J3LOlhzYVGUbZpDPsJEvAUOfhbV9tWjcTVUTgiJfRvL?=
 =?us-ascii?Q?ciTWQHDsIKq8VSyjWY0Mrv3mvenPZLajgRtzFYZg+KTxb6OTlzq2jrpOARIL?=
 =?us-ascii?Q?ZdVNUR+4VB8NQjr0dfdYrZzc1VX/mtcuztld1CD4VfGW+5kQ5w66yOOhq52Y?=
 =?us-ascii?Q?X1gklstbfLfe5LdmlwVer+PMaEo9lwQvdo89GA4uYGusUmE4sc/NGyamoOjk?=
 =?us-ascii?Q?bN03CkO8p+Xi/IJ+NlOoyxIjTOwdTGKBQ2HG8OMDZH3fo106amO9v8VLlTip?=
 =?us-ascii?Q?nxk8A5VgR08DxxsR4vvphMwwLlsotqDwsmq2Oj8TqAzmjbYR+USZ+JkoOVre?=
 =?us-ascii?Q?c4qfJi2NWOiozZp95HBBcPs6aQ8wgaVrZgyoExnOwcH8sVPyKbtSePHq8ZvI?=
 =?us-ascii?Q?/emne1q9N+an93yzAdud7zW+MYJ3PUDCVNQDalZMdLZGSFMOzeoUfs3p7rWV?=
 =?us-ascii?Q?4iAHz0vfQ/u6xwjGJXWa3v4ta7hZOsd044hpcEEhFuiREl6894w0tBuGxdP6?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be7d36a-9936-40c9-aaec-08dce6d458bd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:31:27.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgEeaKEbhhYw6FTibi2P1YVgLnvA+ApBw4cKNKC3DV7uqnonvpsvwEqAwg01opQteaYYvOKvGx5DR9QHfMkxKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6779
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "segfault_at_ip_sp_error" on:

commit: 2b6b3f37af99157303aae84beef05719b9c1ae25 ("make __set_open_fd() set cloexec state as well")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git work.fdtable

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------+------------+------------+
|                         | fecbd3b1c4 | 2b6b3f37af |
+-------------------------+------------+------------+
| segfault_at_ip_sp_error | 0          | 30         |
+-------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410072137.2c3cf4d2-oliver.sang@intel.com


[    7.803982][    T1] init: mountall-shell main process (1527) terminated with status 1
[    7.824097][    T1] init: Error while reading from descriptor: Bad file descriptor
[    7.825777][    T1] init: mountall-shell post-stop process (1531) terminated with status 1
LKP: ttyS0: 1523: skip deploy intel ucode as no ucode is specified
LKP: ttyS0: 1523: Kernel tests: Boot OK!
[    7.928802][ T1540] sed[1540]: segfault at 0 ip 00007ff78f062ca0 sp 00007fffc9fc24f8 error 4 in libc-2.15.so[71ca0,7ff78eff1000+1b3000] likely on CPU 0 (core 0, socket 0)
LKP: ttyS0: 1523: HOSTNAME vm-snb, MAC 6e:6f:1b:a7:2f:20, kernel 6.12.0-rc1-00011-g2b6b3f37af99 1
[ 7.931951][ T1540] Code: e8 25 e5 08 00 48 81 c4 80 00 00 00 eb 84 48 8d 3a 48 81 ec 80 00 00 00 e8 3d e5 08 00 48 81 c4 80 00 00 00 eb b4 90 90 90 90 <8b> 0f 31 f6 49 89 f8 f6 c1 20 89 c8 40 0f 95 c6 25 00 80 00 00 75
All code
========
   0:	e8 25 e5 08 00       	callq  0x8e52a
   5:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
   c:	eb 84                	jmp    0xffffffffffffff92
   e:	48 8d 3a             	lea    (%rdx),%rdi
  11:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
  18:	e8 3d e5 08 00       	callq  0x8e55a
  1d:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
  24:	eb b4                	jmp    0xffffffffffffffda
  26:	90                   	nop
  27:	90                   	nop
  28:	90                   	nop
  29:	90                   	nop
  2a:*	8b 0f                	mov    (%rdi),%ecx		<-- trapping instruction
  2c:	31 f6                	xor    %esi,%esi
  2e:	49 89 f8             	mov    %rdi,%r8
  31:	f6 c1 20             	test   $0x20,%cl
  34:	89 c8                	mov    %ecx,%eax
  36:	40 0f 95 c6          	setne  %sil
  3a:	25 00 80 00 00       	and    $0x8000,%eax
  3f:	75                   	.byte 0x75

Code starting with the faulting instruction
===========================================
   0:	8b 0f                	mov    (%rdi),%ecx
   2:	31 f6                	xor    %esi,%esi
   4:	49 89 f8             	mov    %rdi,%r8
   7:	f6 c1 20             	test   $0x20,%cl
   a:	89 c8                	mov    %ecx,%eax
   c:	40 0f 95 c6          	setne  %sil
  10:	25 00 80 00 00       	and    $0x8000,%eax
  15:	75                   	.byte 0x75
[    7.946359][ T1542] sed[1542]: segfault at 0 ip 00007f3e8dad5ca0 sp 00007ffdac63ab68 error 4 likely on CPU 1 (core 1, socket 0)
[ 7.948095][ T1542] Code: e8 25 e5 08 00 48 81 c4 80 00 00 00 eb 84 48 8d 3a 48 81 ec 80 00 00 00 e8 3d e5 08 00 48 81 c4 80 00 00 00 eb b4 90 90 90 90 <8b> 0f 31 f6 49 89 f8 f6 c1 20 89 c8 40 0f 95 c6 25 00 80 00 00 75
All code
========
   0:	e8 25 e5 08 00       	callq  0x8e52a
   5:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
   c:	eb 84                	jmp    0xffffffffffffff92
   e:	48 8d 3a             	lea    (%rdx),%rdi
  11:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
  18:	e8 3d e5 08 00       	callq  0x8e55a
  1d:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
  24:	eb b4                	jmp    0xffffffffffffffda
  26:	90                   	nop
  27:	90                   	nop
  28:	90                   	nop
  29:	90                   	nop
  2a:*	8b 0f                	mov    (%rdi),%ecx		<-- trapping instruction
  2c:	31 f6                	xor    %esi,%esi
  2e:	49 89 f8             	mov    %rdi,%r8
  31:	f6 c1 20             	test   $0x20,%cl
  34:	89 c8                	mov    %ecx,%eax
  36:	40 0f 95 c6          	setne  %sil
  3a:	25 00 80 00 00       	and    $0x8000,%eax
  3f:	75                   	.byte 0x75

Code starting with the faulting instruction
===========================================
   0:	8b 0f                	mov    (%rdi),%ecx
   2:	31 f6                	xor    %esi,%esi
   4:	49 89 f8             	mov    %rdi,%r8
   7:	f6 c1 20             	test   $0x20,%cl
   a:	89 c8                	mov    %ecx,%eax
   c:	40 0f 95 c6          	setne  %sil
  10:	25 00 80 00 00       	and    $0x8000,%eax
  15:	75                   	.byte 0x75



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241007/202410072137.2c3cf4d2-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


