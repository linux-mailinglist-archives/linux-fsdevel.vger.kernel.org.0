Return-Path: <linux-fsdevel+bounces-75578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMiJMJxaeGkupgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:26:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F79060B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA5AE30327C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 06:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C9332AAA5;
	Tue, 27 Jan 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRuADJuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6B299920;
	Tue, 27 Jan 2026 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769495189; cv=fail; b=ATry09KEgjRzSphs4raRxOOwa1XN/E/9Dbw2sTEFfIWu0Ew1UjJWKRpGbWhzHC0Z3MhxPMo73dF5/4Sq2V2vfvDtOVtA2HL+CkPuUx/wlSHpJoToOEMD6HNcNV3F3E58dkjY/T6ceOTr22OD4bJS0pi1nf2sT392Ur9YO4KD0F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769495189; c=relaxed/simple;
	bh=UHdAPtON/89xoTcqsyTo8pXv1x5sgtlyz74iYt/8zuY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=DR37rH5TjdLatXCz3KDjT2+/IsWufdPAwJBVUQnAQK042CIhn1fh4IVS9MkjckOCY7PQ56jmf6pvjW6BVHkTDhg5x1DOrzXTEShwfWQ1elJAqP4XbxZjI/Y0nK2ImFfMoPDa2QH6dZrMWYUY22irhk9gZqFxZjJeLOyJKUSi+AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRuADJuH; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769495187; x=1801031187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UHdAPtON/89xoTcqsyTo8pXv1x5sgtlyz74iYt/8zuY=;
  b=DRuADJuHRz2GN1WEGakWNke3OzI2Beg1xKbjbS/EXms6MEZ0z+da99Fv
   qagkcXSIfhmTcAn1sTWnVJc1M2ugyvx9/RDh+UVX6CV1pi6h6watIpAsf
   P5j1kNRfIgEOuxPaF58eaANMQSFbXUAWUFUKselbDJUIoYjlIL0BP1tWm
   yboZ0zylOO0kwhx0aYwj+RPtgePyQ2jcDhi7fRXjAG9Z/AcljIMln04xC
   QLhxlb2BfdBbHjF0vR6lMT4Pwd/TS/Ozmhkq6EWmZvu2pqD762fp8Jtdy
   nFsNqLbBxpvwsIIk+IIcSFy+IO3+yqHqlFkIoRx8KCLhdy9ek/zlVdCMM
   w==;
X-CSE-ConnectionGUID: aFsuWKdeQdq01tcoq346Bg==
X-CSE-MsgGUID: VAqepzYfTx2vvwooROke4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70841747"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70841747"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 22:26:26 -0800
X-CSE-ConnectionGUID: DwgBEA6zSLq0Zh7dqwV2lQ==
X-CSE-MsgGUID: zT4qI+CBRFSgvJcPRWxb6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="208131392"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 22:26:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 22:26:25 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 22:26:25 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 22:26:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM9QGjkwn5dQ4tXtI0IdIXgFHsWOJbwXEtdXhPt7H6JaeRBH0WS+xc8FQBHyl2/GD8innaHzYjwpSExdnpSUi6v9qTVupSMhg5d5XAN/ibRZxzoaq7PlXnBKmJ0Ollm3Swe9RGfAxsSqEcv9N8PD0XCcuZezpNkjM6t6cpWNFapFzz+FhiNHMAdKEqX6x3HWr4NZpuh7Vb1yWfVFaIaJayUPiBUWnkylSTkq6VaGDp1O6kCp1SjdlPsMZTcFmFE4+CMOi9QLskSFtvu5v8rWHSWTZX7dNUTRlwlkGaQdg01gPrvGVkSaGUp5+YT5lyjse7M43Wxs7jzVGpPPJe1FLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSIti7o20ycMgGvKQJ9OlagijYRooxvuArcC+8Fn4Gg=;
 b=vO5qOGrcMOFt2mhnT0DOMqhqaf/pZbzJ/NSJR/aXb4CV/VDDsFf+GI3yumVtqal0IlgQQgqn8aZ/VctSkWkNIqGiL9dtiyKE/ao35uoes0bEI/u4uD0Wsp+OtnUS4xqWlL1TLAh6v1wG8mT5CYbOLHa2cTk223LdEaPNtevELxyOiSDUQpKjepkxNSKeN8HrqHEP2GiJ8RV/9iNxZoQjj6Tp9lXyaU3Fm7RtFoaiTLCRn5OIA/4nGr2nrIF+SoMx+KeJgQs/9fOnL3WCsUXqMmdACiwsQa/9vrr5ell3vYYcBp/D/LBJ5UAIvVkCZ7CKox0w5kA4J7w9WUJUq0xX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 06:26:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 06:26:18 +0000
Date: Tue, 27 Jan 2026 14:26:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jeff Layton
	<jlayton@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  313c47f4fe: BUG:kernel_hang_in_test_stage
Message-ID: <202601270735.29b7c33e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KL1PR01CA0085.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::25) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 7352b232-5964-45e8-a039-08de5d6cfaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QabtKP92ngXrMkqp1JbMtBwqvy9zSNvgnzlGHsVj9lnI99BFmFdqTYrYyUKf?=
 =?us-ascii?Q?+QpZL7Ss4Ugld8WyEv41W0nKmbAf6NAbSFlZ7pJMa1bLHTUTsFdvTxt5xw9n?=
 =?us-ascii?Q?ejpYcHd4NkIyjGRD3lA1VhZtStqkABaFEMgJILgp3o042rv4j+6ERWFFLs+W?=
 =?us-ascii?Q?HLm3LqB5XoHRh/spImhASwES5PuMypLZ5C6yLfhoNaSvlougp327j/kPF5Tz?=
 =?us-ascii?Q?mhWOqhvkTT2eQ935XlALoGo6bgIPAEjkqFKNIrntKWKcK4KS4eGiNLiv4pyi?=
 =?us-ascii?Q?VuiBov95HSWJXS9DctprcVMJK5Gfl+fsE3/yjz10A5cHTEzEiyx0Ev+vFoC0?=
 =?us-ascii?Q?aszOf82R6BMvHAV26G88dUErJNNMHnX8q5y1XyrsZXqAlcuwBltTDJEPqwuH?=
 =?us-ascii?Q?dGgztM/6E4EGPO5fv9plFlXsn+q4f1KK0cLD96P8dmx2sxI0YBEjhDbclxKN?=
 =?us-ascii?Q?bF/nr2CmiIgPH3OUhPZk2V6NI8Ftx8wY9nuh5DS5AP0LI6nUjh6LU70oMmiQ?=
 =?us-ascii?Q?C/Zv46tyW/qTuOaw1RHKX8dV7sHWmnYPMTpJv/rTKsC4rGPXmTqsrC4thBJk?=
 =?us-ascii?Q?p9P9rc1qJz5mwRETVSCWpfe6SBrN4hjCww2YMHgeIfyZLxWu3z56xuOEo9sQ?=
 =?us-ascii?Q?ljEBvbdDN8NXbBci+NW3H23I8qi7AJs0WECsF/vZGLJsV6iZJNC0Wq0BiMYy?=
 =?us-ascii?Q?+h/chsZzp1VSPj0m9DWYVH9VGvoVYyrtEp7htwa2UrKqOgjhafj/utQgWrcZ?=
 =?us-ascii?Q?Z7pLuzaIuC7Rf0govaLfTiNQ7n1vbjFmaqM/g6aPe1Sp0fopucY5JE6Dp9Ke?=
 =?us-ascii?Q?V1AIEBC8MXYNIMoTtu+ABgQ0+6E2XHzW8bmbDxBBR5EBeic/y+iITfU7KQi8?=
 =?us-ascii?Q?+HvuEijOf9LVaThS812CaKc2BgnfhTmxwLxIkVLUWqEFxiuplgfimXVzaktY?=
 =?us-ascii?Q?eTgafXHE1QkRsGDV2JVovjaVLRu9LeFJREMCISl3ntFEDQ1EhuLxoOXhcAtp?=
 =?us-ascii?Q?XqNPKWaDuaq1zsLBOScmskCsMItYEIIMmqyV78nwDuBQ3vZbZDaVxg5Vj5vy?=
 =?us-ascii?Q?e8Zc/2wlfckrDWhfpa2zQG0J+Wb5U52JGx+B2bFCa8csXMOkCSYH64Wj9dhO?=
 =?us-ascii?Q?TH8GnMNgffB5ZHXtrNbFbJ8uKGKDdLHyynMJ8M9JYEEN0Wg2j0LhipR1MGmr?=
 =?us-ascii?Q?S/lCR7vQYvEfNmW6+HhTeYrvzKqhn0k3sI6CeiOmAvirSGC0ycTg5WkDD05x?=
 =?us-ascii?Q?g/r/ahCA/0OvcXg2mQIFHQxs7lr517FZj4WCswk4wXKWIeSKmhVN/K/M0xQ8?=
 =?us-ascii?Q?edzR8sIwBBW8CvIBVPaKEYj9aIC4xvcl3tHCvyofjd2GZQNC7/IM4ts6NiFo?=
 =?us-ascii?Q?es9kUQD6xf7v3DYBHNdx2G6AXTyelQDCJCwpfwvXEglTzxcrUQe7gth3vbS5?=
 =?us-ascii?Q?fr0YRtfHtW3bNvXTzBc7m0ueqkHl8dJVmFSCzLQLyQNpHYlXfCa36Xp2fVom?=
 =?us-ascii?Q?/kLiW5NWfSeC+0dpcRGHJRtGz26Ub1rB621qVaVvRIX+7HCuw84eZY42nHB8?=
 =?us-ascii?Q?UFp7jxzp78dlXdk7ytRbWdZgJTNJUkBAOqGjzyUM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8TI55d1JxthXR5yzrEBfKVMrWHgrzoZ7K0TSd4rKQ+m3bEcFe3hniwVPU6de?=
 =?us-ascii?Q?WIm+S3nMjIz4dvJE+sfubjmH7m+NIP71ib0sCYXIoMHrrzsn0OivskD3Z3lP?=
 =?us-ascii?Q?R8CsOZVaS7nozsL+6C+PL/rxfZKEF7PDzY0kjy3C3iFMTd7f+KHhf8gjvx8Z?=
 =?us-ascii?Q?kNcWDEO9fiIALFyVFI2Z5QxghuDdwcl3/mAJ8iRJ+wH8GlUVgHpCz7jZHbFQ?=
 =?us-ascii?Q?uQBhbLL4c4C7Ke61XrOt+SOmtZRvciCfxLCse3yHd6i++MXPeAod4LRmfxJg?=
 =?us-ascii?Q?rRH2x3Gx+KEPQc1pdlMGvkVTqtR6/JHZ0g5qmksp9NtyqzxgTOrPW2ll0V6B?=
 =?us-ascii?Q?KlITbTUCqnIaxy+lFNeDf4WnSYhLEen9Hbl+5mldFFm/MbcJmIvciCIxMNRG?=
 =?us-ascii?Q?n8nuUgXumwYu2g9Lz1KPPr3f4NgzzQ+sqhX6sWKK2tgRQGD8W1Ol+UOBXI+d?=
 =?us-ascii?Q?iRBwfFQ4xEIO4zT4SZxB0LPZxsBj5Wem0JXVwLxLGv1SXmOV7AD7BR9s5LTC?=
 =?us-ascii?Q?Jeaffzdeqz0a/MVSjIWn88Ym76bfvM0W4TCdJ6G9zXnQcfackvCSRHy2hfBU?=
 =?us-ascii?Q?g0s9NCFE4Rd5UkfakoGlKlkNXqft3pTAHeB/QyY5uRmu+nT8870CJtxn0BCN?=
 =?us-ascii?Q?2AG/7fFoiIitb7SwuOfLArRW7Op1w7Y6902ESUe2IP251vF+mqPoXuynTZa1?=
 =?us-ascii?Q?NckayI7cXKZEXl6uJLOJqo2Acbmx0lMLVGw7EbJzBRXmv/RUlz4kvZWzLlJb?=
 =?us-ascii?Q?O85pe7XsFokBkF4o117Qlsf9xEIV5lEJ0gN+Ld9DFCigSjIf4QSWp/92LSRc?=
 =?us-ascii?Q?P6/LH3ctFwdg3VkxUennFNwu7xOw/0LUIcQapA7sYmGkFwreJB0mA8ATT8co?=
 =?us-ascii?Q?TMc7Tj8CcMnFjzpxKWTcAxyzD0g924BUOAaphXkB3tM3cSKJ7o7kzO7MQa78?=
 =?us-ascii?Q?7T+mG9WjGUyuyM7VCletbBzWzyYCtWeeKAIOhfnlIyO8fDRqe0C7lhbPXdIX?=
 =?us-ascii?Q?VYWOGigRKPjfO5Ik8yFtkZRIgjvStkdyzSWSZVq6eApx2t8+RTKx5WEGmgM5?=
 =?us-ascii?Q?F6dBZYDoxw7BVtu1VmCd4LYiQtYpijljmzRKHCfyJGWhiuOdXZDEaXJJmbFP?=
 =?us-ascii?Q?bkBYaq/LoPMV9gtCReiYYeNlAsNXEQnM0DotcNv8UvBTrx/7m+4HEKJpHvWZ?=
 =?us-ascii?Q?CTaY/AJwwrcgS9nb+FOg8ksm29bKXduQgrqi7m9fBjLGyFv/Dz91cTi2KuDR?=
 =?us-ascii?Q?IHP+cBkK0bph2CgL8Hz4CC+35S424xQ2CLMH9waeT/+riHje/CfGb0Kb2NQI?=
 =?us-ascii?Q?B1saX3WzWwEjM9HuDtyBSKFwbxBtG+r3f5dBNmohCC+ueyw+RgIHt6lwFdQl?=
 =?us-ascii?Q?6vg+EMsZ6Nkg9XwINDMQHyNgl72o2ykKoJCVCkZD1cfC8bh/5yhGK3XHx7pM?=
 =?us-ascii?Q?dzXk2OoW+t/W5X7YicCArsxIqu12mfLkD5lwfyOA7K9V31dxLTKbxwBxgqlS?=
 =?us-ascii?Q?0pn0Ikyvo6aWC2ZzOJu3NTZd9LRw//3C7SPf+KJzsyVBepVzy+zvvSa3nzHc?=
 =?us-ascii?Q?MF4C2LF0XunfbabH2brvTSI8fW2m3xkYr2B01safu5uAeV7Q38h6Q3+Z56Ca?=
 =?us-ascii?Q?XefreY+wyb4iO0juoHNjPcm8vCrQevGQmQaB1oOf1dyifoF47cAeEN3ZbfIq?=
 =?us-ascii?Q?nRTepGLiHMT5WqymSHFMOgi1ZJpz3peGgbyN7uyoj65eavYRkhCHjQTE4Q1M?=
 =?us-ascii?Q?SK9tGwFLaQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7352b232-5964-45e8-a039-08de5d6cfaf8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 06:26:18.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUykh/1zziL26XCYxYCENcchtesvQgiFCOx9c+6a7v4MlPZVD0vTxwPU8LjeAuNj+QGp2Jy/FZa5iG0hh25c0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75578-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2D5F79060B
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "BUG:kernel_hang_in_test_stage" on:

commit: 313c47f4fe4d07eb2969f429a66ad331fe2b3b6f ("fs: use nullfs unconditionally as the real rootfs")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea]

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



config: x86_64-kexec
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601270735.29b7c33e-lkp@intel.com



[   27.746952][ T1793] /lkp/lkp/src/monitors/meminfo: line 25: /lkp/lkp/src/bin/event/wait: not found
[   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 94: dmesg: not found
[   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 94: grep: not found
[   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 25: /lkp/lkp/src/bin/event/wait: not found
[   65.744824][ T4974] trinity-main[4974]: segfault at 0 ip 0000000000000000 sp 00007ffe08d2ec08 error 15 likely on CPU 0 (core 0, socket 0)
[   65.746308][ T4974] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
/etc/rc5.d/S77lkp-bootstrap: line 79: sleep: not found
BUG: kernel hang in test stage



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260127/202601270735.29b7c33e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


