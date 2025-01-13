Return-Path: <linux-fsdevel+bounces-39096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE92A0C5C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 00:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983C87A2376
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3271FA267;
	Mon, 13 Jan 2025 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm3AaFPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABF16EC19;
	Mon, 13 Jan 2025 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736811258; cv=fail; b=ACkmROGIyF37sqP1Ua1EdM5ouONcyiFLEdCAAy1pOYHOcnIQ8n42RKksMRo40PF/3r4vJhQxfnu0WIIgnN0MEdcUPkA0EEssNoh6/h9T+zQ4iTEvqMQCO8doyxxoOP3ew+LeRIMUf4PPNIfJr1Ay0zR3lBG57q5ZRZFlNqrRg8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736811258; c=relaxed/simple;
	bh=rRldNJDABWS/ErMAb/fm2hco35qM8ZOEtP6kCr1vH6M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uC3LhLGRF6ZTbAOh/OsuUdDXvV+Fyyua6Azc8D+mJs4AN06DReYMVPvJSHw71ED5dpeey5fgLLcIdSTEVCeqX86prHSZzT6XG7FUBc3Ps4HqFedoX5Jt4msCedQiDIs764QxaRPJy9i9lE3/VXC5jjXQ4UuuMwwP9NPFqMxJ7tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm3AaFPX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736811256; x=1768347256;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rRldNJDABWS/ErMAb/fm2hco35qM8ZOEtP6kCr1vH6M=;
  b=Lm3AaFPXwOxORWdOOgm3GWjw3sWnsB7ZLP6MsMBmRyrCt0vuuyVBWysc
   ACHmEhaqZ1z1BHm6AaVL2F5O4jIBm3SCA9VbDb4+yMjAiugKBJfgyJuWW
   BjnimvskSDKiHxKQINDaPcI7OzIS4k3gKaVw3Q/uWdn4Hn6wSPEjR5U8w
   ELNJQYpdyfkPexFutC/z8B71Drjk4YopZd7mzGDB78U44mP4FbK+yqnAG
   Jv4yTAoEF5yj75tbm+Dy7uDb2RqBfdICyPggZMkbrZFkF01lIl369LdN0
   rdN0EdQwUCvi45QOTpv+IZjNwM5CB4SWFu956j5QTNTey92b4lu5mDbPL
   w==;
X-CSE-ConnectionGUID: hdmRjvLwRLiBzmuhbj/Jtw==
X-CSE-MsgGUID: ug/MKpIUR5uL/g17TfchZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36783944"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="36783944"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 15:34:09 -0800
X-CSE-ConnectionGUID: 7BKw4ZPLR0WrMXaMJNIRPA==
X-CSE-MsgGUID: 3O/c0vNkSQy2EaNxfBUkxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="105193901"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 15:34:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 15:33:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 15:33:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 15:32:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRcnXvMfOP3s5lko/yDCkdufG76w2OkLO/k1n6kZ1RHQgeghuiZQFwpCRcF/O897C4q7PyC7vsLhqPmoWIe49kqbSKEx+Hxu4RBvmSZL9T0rYbgoLV25tK2eu8rua3xyZf4vKMpGbrTgo9tYKW28x+fEp4ZvPrjX5zqLvF/nie9Z3KMSHzAbhcXbqKu8OgGlkn6I/7xqwnTgGw+lUKJowI3iqA0A22FksKqNoPeNLXQxI7vdk1b87iL7/dm4xoMtqZS7p0rrFuwg2twOrm8v1IHGNr8FPO0BmTnuWiBzQsaBPrhH+24cgmWtZbwGhCpyMnHB0UjD261F8u/PcJpHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJKwwErMumYDN8Wouu0Ayr8OB+AQpU/FzlUg/+dZkcc=;
 b=WbUiI4vdbFnlpMhP4ZRjLDGTMevrYZFvQuZK9zPpb8B1XBRZyQ9K4On1iHDFyRJL+w5p/5A5IQFOiwgXf+5AQQCu1bvWuI6t+JCGHh+euO1Vy1w5vS/pyq7uGNOn6wYQmNOn+Pl+z1fuaDoKRrDxTF5v08XFqylS7dnWynLP9NBKsgvb97NzWB2RPmmEMQI8cdanmDTC+fhLmsHh77NRLecYENgXKVNhWnGhzwWx4T6ZSlkKjDq2EL3T6GsBuooIU6irXwn8pdbah448XuE5js6+37/E7SP0P5vCTrob7wdMemZMviUu/JpHIrEvF4PbroXav7WB+gqXOp5Bw5tLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 23:32:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 23:32:01 +0000
Date: Mon, 13 Jan 2025 15:31:57 -0800
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
Subject: Re: [PATCH v6 06/26] fs/dax: Always remove DAX page-cache entries
 when breaking layouts
Message-ID: <6785a26d48c86_20fa294d8@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <47bef43b54474a8ba7f266b9b5fc68ed91b1d7b8.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <47bef43b54474a8ba7f266b9b5fc68ed91b1d7b8.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: fa84e37b-649d-4aec-3194-08dd342a7b2a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M3MqWwqVFSPdKCzfDk9k08XOkKbEVKegAhrTY2/AcfbH7RThi8HG1EDtoALn?=
 =?us-ascii?Q?1djpLtKt4rdgdccyJzx0ufLh98GBhqy3OEquUGUK3d/e8oA5bwM0uwBOa6Lt?=
 =?us-ascii?Q?q9G86m8cCnmkZPdevX6G4iQRpi7X1vA46Uz+PP9igPgBAGCuusG87p6Tvl9u?=
 =?us-ascii?Q?f76+7Qh5ihbyw5TBvPkBNd5cUjDhUrJUh00+03VJCCb0qWvYENkEW68ZsIXs?=
 =?us-ascii?Q?f1krXnTbrKXceZOffa6Xv1YZiqz3E8z2Ma5S8WsLe68A/Ns9KVJOOM6C5sRN?=
 =?us-ascii?Q?5OoB9OfvbilXpk9J9aa+CBCyT4f70wqHZcS6M3VdQhR244GaWnziQeEsi3e/?=
 =?us-ascii?Q?y5edMVOBnGRFllh4xrRzHqAzKRAa/IHpPyVzDH4ziqAbl7kFpITc2xdl0Lbo?=
 =?us-ascii?Q?juXsrOeD0eaMqaHnzVrT4eK2CrxBwOqodXI55PFYfBFjXHX0SNKTv+4Jpaol?=
 =?us-ascii?Q?bs2zNF3RGrwv4aw/85qDI0MB5dCrSLzGXu28zCEYRb3EFhsX4hefnJiprDY9?=
 =?us-ascii?Q?3ujTWgurFN9CAzP9S7o/Iz5MNVigvShqPaCaxawuxDJhJELGZe67ZdYyIXR/?=
 =?us-ascii?Q?rCLagcPM60KBjh1oKGR+60ZEGfNC9PCwEOY5dMLzX3+ERdpwQm95/7qV0KmF?=
 =?us-ascii?Q?4+2PIuYRFcXSPb+SzS4uxZmcsf3Xuw3s164S4inyZeGroWHXFrOFusVunnzV?=
 =?us-ascii?Q?q1sL+TeGzYncBu4NkI19iozhssiTRJjUAVVrreET4cvHcs/0uHglDw6X34BV?=
 =?us-ascii?Q?9BU6eenmChaLcsAlUJJxIFETLN0UXSQjgzmbhBz948FjcF0Lxe3SvFyt0L6k?=
 =?us-ascii?Q?AMo4/HyPxgC9mohMTe2w5/Om5xwvkUhJFO+n6jajQ2ZCGoGE1Cyxnpid12QR?=
 =?us-ascii?Q?cLTX7H6RxLS2A5LJCAkUlCzwsXICgiRCM1UH/SVdzAKCrUuCUIhFhd6fqXIb?=
 =?us-ascii?Q?2xCqKnetHhQ30kjsQCCiPLIDrtAqLf8wZaBVM9Z1hOi0CYeHY2JGD/h5sDkN?=
 =?us-ascii?Q?lo2GqyGGnId4FeINYVrn8zsZhD1KDEGKfu9cEYp04Vlia3i0KwIJdeWDXzB0?=
 =?us-ascii?Q?GQWL9fqedh9ry0gMK11KTN1qLc7W2JdIjWlvOrZK/PL4M2LSu/UZew0Fb6u4?=
 =?us-ascii?Q?G7hm4RbnDWOgf8Z2nBgfjwmLM35yweraarUhHtt3v6LNGccl/5l6bVB1VXMF?=
 =?us-ascii?Q?BcJR07CJRCQfDShZbpyN6pdLftKRPKaI+1Ops8wVz54kjwTP8euWdi0BoJgq?=
 =?us-ascii?Q?fqAdkURuKT/bniS9r7G+h1iFK/8GvbBs+MoGqPSJHEl+ECn22XPjc1yYIXFd?=
 =?us-ascii?Q?0OLX4OFEYflOPd+DbokAYmWa9qjj+JCXH8LuVP1SEEgE1oEFKWeUriGyVwEo?=
 =?us-ascii?Q?kc7emO1lrQ+d8UP4a1c5aHlE79T0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qp78a7pGpLaTo116YazmM9iLO1LKnON12TMyL0NtI5+i+hVACW/fUjvyx0jm?=
 =?us-ascii?Q?2AxfoZXDuoGOKd9pT2UD1aj8ZJV5q4v1mDZQy6ZW6ITYKuBJG3HJY/B6Z8dy?=
 =?us-ascii?Q?dAFd2ZapGV1uqcI4ytv7eNaUBxnwWmVCIaAkghuQVOo3JUELDCVMLg6l/lCU?=
 =?us-ascii?Q?L8g0fwRoz6PiBb19AY5Y/xEhpbYy01DWe1hiZHD6Bt2FDWlL0roDb5WFMr+B?=
 =?us-ascii?Q?TVqOa8x/XMfuf35n8r+q2fBfXv0jgeTetjUHBqtzNCmBXCf7LMyVJadZMdXW?=
 =?us-ascii?Q?Rg+qT4ePj/jxbFmst38Mt3oGq1UDHDf2dzCTaao5Ze+iqcX17ZJsLsmKiuX4?=
 =?us-ascii?Q?42M7QC5hff+DAwT1klZtZ/Gs+1gruv9AU8cZD+96Ub151k+dFqv9ZwFEs3Fe?=
 =?us-ascii?Q?IHB59ilrV9+pPP/Wa3fXHe2d5IStN0PQWsY1X61Hhf/kys7HeTB7YnmT0bJO?=
 =?us-ascii?Q?Xsyc8+DG3c0ftIzcDwbJxzWrcEy2M2PwhSbXNUn5PbDzmlQNWoePLgrL+kf2?=
 =?us-ascii?Q?NGCN9jp8e2ZR/+mbdQQ/shBIQ28wtqqMvVTiuB2Zrh4SCRP0s+y8oVoMQt1f?=
 =?us-ascii?Q?4cSmx7wJcktbOHw8i0csfgeVH+NUapO1b4i3wZ1QbSSW0eD2stDxTNlhlvaB?=
 =?us-ascii?Q?kFiYXAjI9o0yXkyYPgsdJ2cq0vG21dq5uLsJC4VeyeitNNkpNJ8os370Q/NL?=
 =?us-ascii?Q?EtJHS+4o7zLCDwL6NDN5k9YGGQAVPP8JptdoO+MNl2p/dTS1klyFDSk1JTym?=
 =?us-ascii?Q?hpZKrGzkGS3HM1vmfiEqsh2UOqhIRKvJK1GZqeNfkon+tHg+TRMZ10aFJ+3M?=
 =?us-ascii?Q?pNSWWV/QTEz1sWZaTsaw6VKfVhrmed6j7Wdq+r8TEvKob7OxhULJ940n5N2B?=
 =?us-ascii?Q?0zsAG+B9FY9+bgebJPz3juJ7IYKKP7Qr84EK0CX2qjmRTGgDP/9IXnc/aSss?=
 =?us-ascii?Q?qF2c5iLc8t6y8nFMSzTn7SSVTpQhg2Xu7NeMDRa1djLMkketrmVRl1FLovTX?=
 =?us-ascii?Q?8CDdnuxEeXvKyvydnXppBYTx2ew6akrPc1jZPbA4QbS504IHSiX4xjeEp+3r?=
 =?us-ascii?Q?rXp0oVe04jzJKZXCDDsW6aeb42a+y7JFdaPlqj83fcGT2XINK9lsiPFns8q2?=
 =?us-ascii?Q?93hedxMSTStS7NfJTZSZrQO+IcO2fL2C2vCdyGOhkc25HONZxIQnUvzfQzDc?=
 =?us-ascii?Q?kSqDSpm+M5NSXMrlj5CuIj2TK9LPUDE0vrZzh71kyA4WF5yDt//+yCPaN4oD?=
 =?us-ascii?Q?pJxI8pQpjyMgN3QnKmCfm5nTsxtkiD2QOGBzUHc1oeAUhfR8w9xpEva2cFIU?=
 =?us-ascii?Q?X4DIxMskUVS2NTduSSBFCx8kLsuJj/LH+H4xXHUTeH9KPypSkl8uyLz3tssX?=
 =?us-ascii?Q?/aGmmBEiWQ6Yt50rksdxMUppjCggv9Y8QsJZGVfl9jB9h05st7ixxhjgd89l?=
 =?us-ascii?Q?8QlLInbYl0i/puwsUDTKmrW1poB1jo9WRTnCHapTLGhsP5tjPOSv+vhLXj9q?=
 =?us-ascii?Q?Vnj1AxVxiYbngBCedZC6AgEO/tUQ7OHOU9OpSgdbpRfsyyUwVYPFTQN49/14?=
 =?us-ascii?Q?GyqPL6eYP9FXOUB4rGrM1ig9Brewt4RJIcrMA3WaCN5HMC++crpUL9XxSV59?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa84e37b-649d-4aec-3194-08dd342a7b2a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 23:32:01.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDAA1ZDr0PpD/xo0OH7fjCo80k7U0A4Hi4yLDBIeFGjqf9GPqCqQPepGuQU8pd4xa/tuIXP5JnBHcQGJucmSaMpvh7GHQEC37cMC3tccEpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Prior to any truncation operations file systems call
> dax_break_mapping() to ensure pages in the range are not under going
> DMA. Later DAX page-cache entries will be removed by
> truncate_folio_batch_exceptionals() in the generic page-cache code.
> 
> However this makes it possible for folios to be removed from the
> page-cache even though they are still DMA busy if the file-system
> hasn't called dax_break_mapping(). It also means they can never be
> waited on in future because FS DAX will lose track of them once the
> page-cache entry has been deleted.
> 
> Instead it is better to delete the FS DAX entry when the file-system
> calls dax_break_mapping() as part of it's truncate operation. This
> ensures only idle pages can be removed from the FS DAX page-cache and
> makes it easy to detect if a file-system hasn't called
> dax_break_mapping() prior to a truncate operation.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Ideally I think we would move the whole wait-for-idle logic directly
> into the truncate paths. However this is difficult for a few
> reasons. Each filesystem needs it's own wait callback, although a new
> address space operation could address that. More problematic is that
> the wait-for-idle can fail as the wait is TASK_INTERRUPTIBLE, but none
> of the generic truncate paths allow for failure.
> 
> So it ends up being easier to continue to let file systems call this
> and check that they behave as expected.
> ---
>  fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_inode.c  |  6 ++++++
>  include/linux/dax.h |  2 ++
>  mm/truncate.c       | 16 +++++++++++++++-
>  4 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 9c3bd07..7008a73 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -845,6 +845,36 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
>  	return ret;
>  }
>  
> +void dax_delete_mapping_range(struct address_space *mapping,
> +				loff_t start, loff_t end)
> +{
> +	void *entry;
> +	pgoff_t start_idx = start >> PAGE_SHIFT;
> +	pgoff_t end_idx;
> +	XA_STATE(xas, &mapping->i_pages, start_idx);
> +
> +	/* If end == LLONG_MAX, all pages from start to till end of file */
> +	if (end == LLONG_MAX)
> +		end_idx = ULONG_MAX;
> +	else
> +		end_idx = end >> PAGE_SHIFT;
> +
> +	xas_lock_irq(&xas);
> +	xas_for_each(&xas, entry, end_idx) {
> +		if (!xa_is_value(entry))
> +			continue;
> +		entry = wait_entry_unlocked_exclusive(&xas, entry);
> +		if (!entry)
> +			continue;
> +		dax_disassociate_entry(entry, mapping, true);
> +		xas_store(&xas, NULL);
> +		mapping->nrpages -= 1UL << dax_entry_order(entry);
> +		put_unlocked_entry(&xas, entry, WAKE_ALL);
> +	}
> +	xas_unlock_irq(&xas);
> +}
> +EXPORT_SYMBOL_GPL(dax_delete_mapping_range);
> +
>  static int wait_page_idle(struct page *page,
>  			void (cb)(struct inode *),
>  			struct inode *inode)
> @@ -874,6 +904,9 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
>  		error = wait_page_idle(page, cb, inode);
>  	} while (error == 0);
>  
> +	if (!page)
> +		dax_delete_mapping_range(inode->i_mapping, start, end);
> +

Just reinforcing the rename comment on the last patch...

I think this is an example where the
s/dax_break_mapping/dax_break_layout/ rename helps disambiguate what is
related to mapping cleanup and what is related to mapping cleanup as
dax_break_layout calls dax_delete_mapping.

>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(dax_break_mapping);
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 295730a..4410b42 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2746,6 +2746,12 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
>  		goto again;
>  	}
>  
> +	/*
> +	 * Normally xfs_break_dax_layouts() would delete the mapping entries as well so
> +	 * do that here.
> +	 */
> +	dax_delete_mapping_range(VFS_I(ip2)->i_mapping, 0, LLONG_MAX);
> +

I think it is unfortunate that dax_break_mapping is so close to being
useful for this case... how about this incremental cleanup?

diff --git a/fs/dax.c b/fs/dax.c
index facddd6c6bbb..1fa5521e5a2e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -942,12 +942,15 @@ static void wait_page_idle_uninterruptible(struct page *page,
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
+ *
+ * For NOWAIT behavior, pass @cb as NULL to early-exit on first found
+ * busy page
  */
 int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 		void (cb)(struct inode *))
 {
 	struct page *page;
-	int error;
+	int error = 0;
 
 	if (!dax_mapping(inode->i_mapping))
 		return 0;
@@ -956,6 +959,10 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
 		if (!page)
 			break;
+		if (!cb) {
+			error = -ERESTARTSYS;
+			break;
+		}
 
 		error = wait_page_idle(page, cb, inode);
 	} while (error == 0);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 7bfb4eb387c6..0988a9088259 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2739,19 +2739,13 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
 	 * for this nested lock case.
 	 */
-	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (page && page_ref_count(page) != 0) {
+	error = dax_break_layout(VFS_I(ip2), 0, -1, NULL);
+	if (error) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
 	}
 
-	/*
-	 * Normally xfs_break_dax_layouts() would delete the mapping entries as well so
-	 * do that here.
-	 */
-	dax_delete_mapping_range(VFS_I(ip2)->i_mapping, 0, LLONG_MAX);
-
 	return 0;
 }
 

This also addresses Darrick's feedback around introducing
dax_page_in_use() which xfs does not really care about, only that no
more pages are busy.

>  	return 0;
>  }
>  
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index f6583d3..ef9e02c 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -263,6 +263,8 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
>  vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  		unsigned int order, pfn_t pfn);
>  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
> +void dax_delete_mapping_range(struct address_space *mapping,
> +				loff_t start, loff_t end);
>  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
>  int __must_check dax_break_mapping(struct inode *inode, loff_t start,
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 7c304d2..b7f51a6 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -78,8 +78,22 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
>  
>  	if (dax_mapping(mapping)) {
>  		for (i = j; i < nr; i++) {
> -			if (xa_is_value(fbatch->folios[i]))
> +			if (xa_is_value(fbatch->folios[i])) {
> +				/*
> +				 * File systems should already have called
> +				 * dax_break_mapping_entry() to remove all DAX
> +				 * entries while holding a lock to prevent
> +				 * establishing new entries. Therefore we
> +				 * shouldn't find any here.
> +				 */
> +				WARN_ON_ONCE(1);
> +
> +				/*
> +				 * Delete the mapping so truncate_pagecache()
> +				 * doesn't loop forever.
> +				 */
>  				dax_delete_mapping_entry(mapping, indices[i]);
> +			}

Looks good.

With the above additional fixup you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

