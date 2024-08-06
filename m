Return-Path: <linux-fsdevel+bounces-25105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D2949201
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907E11F22CF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC27A1D47D3;
	Tue,  6 Aug 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyFuKlGD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1A1D47A2;
	Tue,  6 Aug 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952120; cv=fail; b=VHod0e9glX7qKhLci2dFWBYj0+YMe0xwmeiM2YUSMRNdSJO2RyYy0zTUhcPhUdkEmKx76hZJEpMUD7syt0wOWdTQW5krn4BfhRzyQk8vSJdkVGGWbXO1GzHpCk77nlUOvBfvHAkMrBM0378IwrGASAznvUqtL3WPJ/vHOhzfuvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952120; c=relaxed/simple;
	bh=XKq6MUIIlfvHa4f2glFchTAZRV3ifHE7/kDlgbA+Ibg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ujaE6yg1hRGv1c25+pWlX9ocsOpUH09ijPuukkuGjWWyZd3dha57ylnyjBFhFZ5+yrCIwYk7dgNMaXcigxFz8wr+0aYsDBKc4klxlD//bdWeoO/YVes4JLdAjcatU7/5W9RPogwjXCezMFpKmOdCw+yDuoI9Q78Bf+LieAHMT0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyFuKlGD; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722952117; x=1754488117;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XKq6MUIIlfvHa4f2glFchTAZRV3ifHE7/kDlgbA+Ibg=;
  b=LyFuKlGDuD/RN01+BqGMUdb3wrzpOQ+t1YOrpZ+9gdxUmNC6noFwCZmY
   +FSf0JApAovjvxPDq4AhTiR4rVr9oZGymFSFGuLzUYENH6LeclLL1xezu
   Gfc4ldle36WCYUhQO/CrSX08gb+12/Hd/JigDX9gJCwjQtjYs+TWEwkx4
   4HFWEDarNSb1a07VHqx/Y46gRZcH0SAfVG7u8yW5Yr1iH7orNngcX5VP2
   2g3Wx+TlDHCoSMwW3c1eUdi0jh13V1y3t2BFFhxLkJS5Cr/j12kIEK48K
   v/rUNGPYUZOCHZ4/rtniBwQJ7jFhTBKSZKt0rGUH/QIW2rLEZwE61ufYi
   Q==;
X-CSE-ConnectionGUID: h3tQJIeTRTOQ2jPMVIA9sA==
X-CSE-MsgGUID: 0Fo/FsH8SZKdSyZMKFMisA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="43494078"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="43494078"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:48:36 -0700
X-CSE-ConnectionGUID: KuKWTUeES6u9LDFRF58S1A==
X-CSE-MsgGUID: D0CXufXDQUiMG5P1v4r1Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="87461011"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 06:48:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 06:48:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 06:48:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 06:48:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 06:48:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7ehzTtuyWNrquF9blDab+y8oK5vC+nVRO3WFH3kCSoViwakWSUtbtNg7z8Wt56L1fMnob0asQIhjKr/vySSZrf6dXanNWaPc/hoPocuJ0Hxnq7n1tzsRvMRVlCFQl3f5Nx71QuFNgwZsaInRYeKiyX6+0fgN/0zrChtvs9C8AIzfc6D68hg1/KjmbiueB1niJFYd/+Ts3/6Cjt9zkyGawl+GRpq6wm/aFiPVfI0ro4d/H+Rvin8OC3KYF3vwF4ctBBLSAsxRfZyQLAS0DhTleQI9hT/ST0ChyrDEZ7i/X94CGsUjIeGZRj3JkY7ljco0uURIlyqwWnkBeVKlLB7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9y28FEq1DKGymogP8Vvv8q2EBcfUseqSuwK0twYlR4=;
 b=kcwxjJotbEkuGtuXkfuX8athpw8wT9zk3brK2PsXrSwbxweLcjJRg9Xm5qnixWAEUDdPOy+TMy1beCw26GykgBq7BJC2PH4oG9fKzOALfXbTZpflS+c6o88XxZPFG0cKhAMDlFlfiKGM9SyZqMAvPv0CM5yUDvLWCBdmRSM8zXzTYsl9bvvtl3oBKy37Uxn7WY+KKGmNaMRsJ2w33T2ssFW5mCNIHjLYv3wYDS2dHrQomqjfQSDc1EjEfpFydO4BT3fjGxXKv/+u85xoHk9bLhwivqOeXI+yRsMz8eTp3j/+nTcS4djhGYBxXOrxpw+Src6TON/DOvADFMVWEBXnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 13:48:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 13:48:32 +0000
Date: Tue, 6 Aug 2024 21:48:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Ma <yu.ma@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jan Kara <jack@suse.cz>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<brauner@kernel.org>, <mjguzik@gmail.com>, <edumazet@google.com>,
	<yu.ma@intel.com>, <linux-kernel@vger.kernel.org>, <pan.deng@intel.com>,
	<tianyou.li@intel.com>, <tim.c.chen@intel.com>, <viro@zeniv.linux.org.uk>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v5 3/3] fs/file.c: add fast path in find_next_fd()
Message-ID: <202408062152.7e5b5d6d-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240717145018.3972922-4-yu.ma@intel.com>
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba4e961-8226-434d-af51-08dcb61e758c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9v/6Sz2ppJlV35Zw4HtHsb6VSg1AcY9mVtQclnC13pQjr5fMYhx7aFeHLV?=
 =?iso-8859-1?Q?e/0xGsGPM4nipvjQPVUesbLJoAgtRKCqY3Vopj8HRDfDc0u7KFN5Yj9Oh2?=
 =?iso-8859-1?Q?86rvD0JEsn5vrP/2QKUHC1V/RJMzIa77yJCsDppHQ+KIhOU+k2y1biu02Z?=
 =?iso-8859-1?Q?vHzeHg/Hev2s0vm9Ep2jbiXSl6xNbXOyr8RzXwls8PNlmn3B++kRw8WLe2?=
 =?iso-8859-1?Q?ccCXa8j2ceesiLesAdfB88K5o+FS1bnvHi+qCrIKpKRuud+9ijHR25JUcA?=
 =?iso-8859-1?Q?d26zVOgebuXXRKwjVwG0kmZM8Bsd9fUf5+q6nyB3G245DimVy5RPsY/5X0?=
 =?iso-8859-1?Q?Rs/QOZMSLzpk42whclUxO8d7b7jzUguE/mi1ZmQNTgT5oTSwcRiqiLjuHB?=
 =?iso-8859-1?Q?NurlNWAw2j7pbnI1ZI3qX1kgAtfvZjJGGehtnpVpy0tSy+UwtXiGYBsiv9?=
 =?iso-8859-1?Q?UUoFQDbdu0qltxgmzzg3bk685WBEtnd3yYC36prY5w849VYlvOMW1ukiPA?=
 =?iso-8859-1?Q?BI9sUZDjBJp1vqM3Hmgc4JRWgo6U6zKoks3QLXQnh09fCoHqC3hX2923LL?=
 =?iso-8859-1?Q?esinMEkOX6s4EMjd5hXHT0r76zKbxDg72mFw1Gal8qBK9q0CWcQZ+x51xd?=
 =?iso-8859-1?Q?sH+cYF/xN/Y6tRQJpKxRmn0u+GT+q9zvDnL4x71YcVrYXegWBUTLKBK57K?=
 =?iso-8859-1?Q?sq/C44htb3xuxw53o23mUrgQDNYdz8MBt3N2GsmBNKzB6FOuumTai2h0N7?=
 =?iso-8859-1?Q?SgpaDssUnQh66kGoi/vjdIG0LcKiO+dLw/gE94Occszvgs+c82/Hq6svcq?=
 =?iso-8859-1?Q?wRT5LvCvadFJ8nRJckg7XMl3UcNpeYoKUDK/YlohSsEuLWIFgKv1IknsC/?=
 =?iso-8859-1?Q?ZMg5oSRy7lTveS3x6uoEcStjcyOq7gJgEvafv3goNuUDsdMdvsBbUzlGBc?=
 =?iso-8859-1?Q?9dHyUhsL4/LnurYxUQMns6XtF6REvhB6hT7/uZdAJNHQduFSKcTxbqoTg8?=
 =?iso-8859-1?Q?FUdSKNNKPrbdvfMQB/eNk/KX5DBPclx1bBo9Tbsffq6xBxGSkMDYvjBWcL?=
 =?iso-8859-1?Q?J1ppCEIjCyuSi5C6rB4eog+e/1JpGaKUC2I9QA4q+j7sNPvI8+WsOx1eSL?=
 =?iso-8859-1?Q?j/BgY+zw5uKvO+jED259mZUWuD/ZMZbntCZmVaTcJIGtATGRXHOGYtH7cw?=
 =?iso-8859-1?Q?7Tne/okLTdLUQ+NZXG1noe4psH+qe7MUi5NOolOcXZHnWrQfwxMLaH/g0y?=
 =?iso-8859-1?Q?xo8kTwYX86GHWdFdKsUjFequEICHXOiqTgL4bJCuNxvVSj1zh1lqiBuowM?=
 =?iso-8859-1?Q?p3WChuAu1xg5677/WbvjGw3aLgpTAdgZ9ADLmwNSp/AJWfXnsYRQ6Xepag?=
 =?iso-8859-1?Q?ohw64w78EF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+kmROrRvvBEGVzjpENqNL64KQhHtknjuhfRFpLnKd7p/AwQb9kv7xe0kf8?=
 =?iso-8859-1?Q?WxoTPHj5xNk7aOTWVO0pvo2c9ecYlbdspArRif60v3FB32v8upqz3dE3na?=
 =?iso-8859-1?Q?sOQXrz0k7zN1s7/L0jzqVebJKYl/okT+vKsTtVRVTMdOG6+zLW3GWnB6N4?=
 =?iso-8859-1?Q?Qb7C5fhd4KEchLMeMxbqgokEUcixCvxcTqNddbpHjj6Z2JeiLOcVZOBSi6?=
 =?iso-8859-1?Q?t+JRFdcBjTX+WoabPmzdaACe+Y2pKNrm1MoFKu3g5btDIzQSdyQ2qZQ/v2?=
 =?iso-8859-1?Q?CsduolFfhTHFrEWQz3IxKejFao1MCWS3m25to8fL5+/POEp5scOr41dc/T?=
 =?iso-8859-1?Q?w1WPk6YSMiV5KK7RD0lKX7lVAVXdNW3s2icPKhsnmlrTrQfkI1WrRsHltr?=
 =?iso-8859-1?Q?uFXToXmuDTdjRZ9sssUTaRpUVXNr2jgJgkLUmpJdWfJJ9uhGs+v0TSslID?=
 =?iso-8859-1?Q?UcE1EihtM0vdaJRfgqD1BrsLnZWChk+7rMFKoBGBGAr8Dm0/PF2Xmif8AR?=
 =?iso-8859-1?Q?R7tO00q3QwuaJXhRbhtmue2ZVt2Rl5O+5y2ObF+juRNkmA9gONES+LSUlP?=
 =?iso-8859-1?Q?5w4XYoqwSJoEtYGKra8j0sE/+65aQek0JWXS3MrzLjhH3PHWLF2YEwwYWF?=
 =?iso-8859-1?Q?DK056iWcx6p1aFjKMPOzY5HD9sZbjeA0O6EIiiludjQj55e2J35q7k5nIq?=
 =?iso-8859-1?Q?ZTlEzBX+7plkIVEEL0K8aY+MdDwswSJGHeoDr0eXvxfyzpQNN2awHS464S?=
 =?iso-8859-1?Q?Ng/y9YMXYcAmxN33nOAWxeSXqOupWSvtejKQOpyafcd6U0r6oEbL4CO3jf?=
 =?iso-8859-1?Q?Crkn+6JAyIc+1rW9nhgWXbfEwfflnB45I0Hy6Ybqj0zcop4dc9faDjfD2t?=
 =?iso-8859-1?Q?rnLg/tbQhQcpXNOdZa0dPrdJzWfRGcTo81ppII+dDCvdSZWIaMGdGnwmkw?=
 =?iso-8859-1?Q?qE9g2H5HzGkMK9XhfybPCZCJc3X+PEh12gLAaG6MfcPjEpC5tZXy43cvxc?=
 =?iso-8859-1?Q?Ph9vA3gkcBvc842cGOKVGSscFlTg8owUEOHdBDAQTgns9sLqDZt8GiYb6e?=
 =?iso-8859-1?Q?9CnTGkwTY0vohq8K+goxvmOg5wTuSjJZWynTPaAWJNt9pqaUZgpKiCWvvV?=
 =?iso-8859-1?Q?UBcTnYkn3rlIIrQKuimmsYBN8NlIPj3Jm31oDwvnBb3FCLXMawLESIoC9U?=
 =?iso-8859-1?Q?0hpczuiBm4ZH8Xo3zZuV5oKRXdecwR2WoQ7yDS5Er3V8izBxAeHfeVX4s7?=
 =?iso-8859-1?Q?Uc6fZN6EYoioRkjo/EIFDThMfuoCPyn812XJckL8ZYU/dllZnWqG7cAWEM?=
 =?iso-8859-1?Q?l4X4avO9sDv707wNCjYCp5TgQEYf+7fBMtTmJY346lfFpKhuCTYNDoT4XW?=
 =?iso-8859-1?Q?gqX+26zOsdx4TXKeLXNOlZTaxwIUNrk+9JVz+pqwXU0tg8lanOvg7QXp9c?=
 =?iso-8859-1?Q?4Ccpx3y/MRPLgQsUcP0wFlc/Fylv1nlyr0rCoFAA86nnRVlkMno9nQ1Q4r?=
 =?iso-8859-1?Q?dWehu4LycvPYt33Gt1lji+mZY2lzDIlgasCwBiULnGv1+3FUA4UnDwvRJy?=
 =?iso-8859-1?Q?TraMKY511xrmcUocrxUNulDDK9ALYylKRgdyYbh1EMNfY6rBY4zZpxt9zw?=
 =?iso-8859-1?Q?tzg3ngLbJbxYnj/8SU1DkKsAbI9aPodtd+zcalcI3Sf8e1Z+iQOFU4FQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba4e961-8226-434d-af51-08dcb61e758c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:48:32.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvnqpdNOPToXNA01UBaHIuyJ1rgSfFzpn0TN4so6YL55t3iZ9guUmVAVwB4VixzU1NNZTtPKPC+kwvioykvqPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.3% improvement of will-it-scale.per_thread_ops on:


commit: b8decf0015a8b1ff02cdac61c0aa54355d8e73d7 ("[PATCH v5 3/3] fs/file.c: add fast path in find_next_fd()")
url: https://github.com/intel-lab-lkp/linux/commits/Yu-Ma/fs-file-c-remove-sanity_check-and-add-likely-unlikely-in-alloc_fd/20240717-224830
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20240717145018.3972922-4-yu.ma@intel.com/
patch subject: [PATCH v5 3/3] fs/file.c: add fast path in find_next_fd()

testcase: will-it-scale
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_task: 100%
	mode: thread
	test: open3
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240806/202408062152.7e5b5d6d-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/open3/will-it-scale

commit: 
  5bb3423bf9 ("fs/file.c: conditionally clear full_fds")
  b8decf0015 ("fs/file.c: add fast path in find_next_fd()")

5bb3423bf9f9d91e b8decf0015a8b1ff02cdac61c0a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    848151            +6.2%     901119 ±  2%  will-it-scale.224.threads
      3785            +6.3%       4022 ±  2%  will-it-scale.per_thread_ops
    848151            +6.2%     901119 ±  2%  will-it-scale.workload
      0.28 ±  4%     +13.3%       0.32 ±  3%  perf-stat.i.MPKI
     31.31 ±  3%      +2.0       33.28        perf-stat.i.cache-miss-rate%
  14955855 ±  4%     +13.6%   16995785 ±  4%  perf-stat.i.cache-misses
  49676581            +6.7%   53009444 ±  3%  perf-stat.i.cache-references
     43955 ±  4%     -12.3%      38549 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.28 ±  4%     +13.4%       0.32 ±  4%  perf-stat.overall.MPKI
     29.84 ±  3%      +1.9       31.78 ±  2%  perf-stat.overall.cache-miss-rate%
     43445 ±  4%     -12.1%      38200 ±  4%  perf-stat.overall.cycles-between-cache-misses
  19005976            -5.4%   17972604 ±  2%  perf-stat.overall.path-length
  14869677 ±  4%     +13.6%   16898438 ±  4%  perf-stat.ps.cache-misses
  49821402            +6.7%   53168235 ±  3%  perf-stat.ps.cache-references
     49.42            -0.1       49.34        perf-profile.calltrace.cycles-pp.alloc_fd.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.40            -0.1       49.32        perf-profile.calltrace.cycles-pp.file_close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     49.25            -0.1       49.18        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.file_close_fd.__x64_sys_close.do_syscall_64
     49.20            -0.1       49.13        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_fd.do_sys_openat2.__x64_sys_openat
     49.33            -0.1       49.26        perf-profile.calltrace.cycles-pp._raw_spin_lock.file_close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.28            -0.1       49.22        perf-profile.calltrace.cycles-pp._raw_spin_lock.alloc_fd.do_sys_openat2.__x64_sys_openat.do_syscall_64
     50.14            +0.0       50.18        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     50.17            +0.0       50.21        perf-profile.calltrace.cycles-pp.open64
      0.64 ±  5%      +0.1        0.75 ±  6%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.62 ±  5%      +0.1        0.74 ±  6%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     49.42            -0.1       49.34        perf-profile.children.cycles-pp.alloc_fd
     49.40            -0.1       49.32        perf-profile.children.cycles-pp.file_close_fd
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.file_close_fd_locked
      0.15 ±  5%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.init_file
      0.22 ±  3%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.alloc_empty_file
      0.18 ±  6%      +0.0        0.22 ±  6%  perf-profile.children.cycles-pp.__fput
     50.14            +0.0       50.18        perf-profile.children.cycles-pp.__x64_sys_openat
     50.18            +0.0       50.22        perf-profile.children.cycles-pp.open64
      0.18 ± 14%      +0.0        0.23 ±  7%  perf-profile.children.cycles-pp.do_dentry_open
      0.30 ±  8%      +0.1        0.36 ±  8%  perf-profile.children.cycles-pp.do_open
      0.64 ±  5%      +0.1        0.75 ±  6%  perf-profile.children.cycles-pp.do_filp_open
      0.63 ±  5%      +0.1        0.75 ±  6%  perf-profile.children.cycles-pp.path_openat
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.file_close_fd_locked
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.08 ± 12%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__fput
      0.05 ±  7%      +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.alloc_fd




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


