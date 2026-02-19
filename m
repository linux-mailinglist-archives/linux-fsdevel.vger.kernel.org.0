Return-Path: <linux-fsdevel+bounces-77661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFZlMleClmkrggIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 04:24:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424215BE19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 04:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0CAA300A259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278D280A5A;
	Thu, 19 Feb 2026 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIoeZCkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27024C676;
	Thu, 19 Feb 2026 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771471442; cv=fail; b=MyEIi6VxcGVuHhREo3UsQjX4JwhEero2iMPY4O7W47f7p+M/thYBAY7XwS9TjG7v4ZfPeszLEXWy1sBqEh+KDdTWLS6rEfM2DFtlunbI0SbQ2mATGQo+wKqLYCya1PY9y1XZk4rStFPZXtegVNI48qQJezuedAK7Pnp77C9mb38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771471442; c=relaxed/simple;
	bh=PfP5Eoxbh6P0uoJGexKWic5zHN7GMXWhamdcZpIuL00=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AT68Io4JWQVtST5bZ/3s8xI0VkoL6KF37M3kKNcqQdWFwal1SgQn+3FImVr7VO6oB3SzdF7S6rUc31S7Rv05tFHfsKC2j7K9trAlf+R/BFIBBSg0jFbGrjNoISBvpijSH+v6MIWe07l8IJ7KP87c57j95s/OoBMTZyIM7nkQLnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIoeZCkY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771471441; x=1803007441;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PfP5Eoxbh6P0uoJGexKWic5zHN7GMXWhamdcZpIuL00=;
  b=nIoeZCkYf/KGJG+j5CDNgyR03iKO+k7NLvGv1inwsASNodMoIjftiVu2
   Z6+ODnTXda8JlJ4CI/3fzJ+d8WEbwCTY8BoG4ZQP+8VX4ha7MrQsK/90L
   oh05BL5ACEXjtF8XFVB44MNj9BCxXwkFouTRrGEH65G3E+MU55X/QqDoI
   WMtvkqnIGk6ZLWbQ6f/gPkW7HG2zlQ6XfRdv5D91TM4QCtV9e+ZXLcFZ/
   XeyU5ZFWRFRLvYZxG4mD/UgICYzJAySSUyYz5CGlna5mGHHcFhgmL9i/X
   VdY8c7vBZITNiBKXEqo/Jpo8M5dV/V9G2brpS12LfdddHeIvvUHJ9R33g
   w==;
X-CSE-ConnectionGUID: VzVEiX8HS2mwzJdzoQCSHQ==
X-CSE-MsgGUID: 9wFYMgn0SgG+RG7GXrts8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83918617"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83918617"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 19:24:00 -0800
X-CSE-ConnectionGUID: p21uynuXRyOOBFDg9UnbNg==
X-CSE-MsgGUID: l55mBXHPT9ivgv9LdYNl/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214400863"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 19:24:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 19:23:58 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 19:23:58 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 19:23:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9Rp74fDdnGtEG9bbXRf6EzI0zxIKfg9Og1vMIZOQmx2wLHDsMWtUfHjUgTAazmaVyj2A19JyuEc1w607HqULgNM+G8jHjKJgrYi4ZmMVhRnRIiQxFt6BI3+qIhQ3k4nESbPsN0eUhOJJ7Bm9hdczH3vwvGwJAEIWxIpa1Mn/q9Oy9tN114pQvg6Dn25PdWt/qBKBqaecG3j4/I87LxYDG4Z9UjbQhEvQYKTGvUCZy8ubXPCYXrjpm1qd/ga9e93ghX1Y0G2Pq+kvjn8c8tj/9QU8ktmTdZWwS88LNN5rTSXQ/9BufuGJfD5VosyZINlKPdXQjGEm/1I3iFIhNiH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sopi7/60k4acBV2Rn2nr5VKcGWOVuv2HNS0zpoc/bCI=;
 b=WcPPQFyhJY+9tCzQuSsXerWhBo2dA2ok7f0btgdjY/i9CK5wZugPH+AcXWbzuBVB5kI1WqLkCGARNZo2k8fNEbYgitBpC77gEfUlQw6RplkmVESnBtw1gybOWggDEJo/Bpedq0bd5YvboHtz+a2qWE1HFt4lEg2iBjSElWUNPB/CGzZlL/thW2c1xRQ1ZC/xiUQE47gxYO6x/Mu5+3DxYK/Du3ogsV/vz4ojDF6I5uqehE8dHrgZ6euYd/uTh39QDwdmDdbcVyqkUSbQbSZlhE9JCEacyB9DIulDHLA40aiLMgZUYyyx6IehXUo8Y8mWUWX3+os2f+qODFHITrIM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL4PR11MB8798.namprd11.prod.outlook.com (2603:10b6:208:5a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 03:23:54 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 03:23:54 +0000
Date: Wed, 18 Feb 2026 19:23:48 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Subject: Re: [PATCH v6 2/9] dax/hmem: Gate Soft Reserved deferral on
 DEV_DAX_CXL
Message-ID: <aZaCRCQG9UwG3gYy@aschofie-mobl2.lan>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260210064501.157591-3-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BYAPR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:a03:54::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL4PR11MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac83304-55c7-4b1f-a5a4-08de6f664f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4MXe2Tl1UcI7XLjtoAXOiCtdrVO16/pZtoYfKVs4sElhw2cvMlpfgr2ERW/A?=
 =?us-ascii?Q?C3qbI90/9vOy0agJVq0aq/NOyHx3eHMcThy3Uvrry0PdGUYO2r70yoB8b/qO?=
 =?us-ascii?Q?kg8HRPcEcZSIZQdOk8shcc/Y96MOmTKYsCRjAyWsrYLe5qiFvBRqx3uXlzoz?=
 =?us-ascii?Q?nvwzXIO0f9eQAsRfnEUT5DacVVfzp1nsVR9BjjC614HBLBZOr9qoL/G+yzDS?=
 =?us-ascii?Q?KABvJVGTbe/ii6VS1nExThTbXiX0tDvQ/sdQtOXFsvcNyag8n1t0fpsZKHah?=
 =?us-ascii?Q?yDxb24aMtXPBLXDtm4ITJzwffhIL9U3Ja7aGJnUKcar2nHXSa0haJLoEfYEO?=
 =?us-ascii?Q?7Aek68TjM5VsgmfdhtENZFWMdb3YEXNq1M3sUVuYO0Jhla477dweIoUgghA0?=
 =?us-ascii?Q?HNUjC2PP2qilpXd4blxYG8AfNBaOkfw/qjiG6tbV9X3yH1JOPFo52Kg2ud56?=
 =?us-ascii?Q?1GHJ8zJUCf5EH7DDCWn3uRyfT5r/Z4Y+051oVoT/2HqFV2VvbMRdY5xWUHm7?=
 =?us-ascii?Q?K2cmLEVfSZmVAd24rDafqVKxR/FBL8LA9wHSg0m3FUulLJdnUpFr3XWsEZRR?=
 =?us-ascii?Q?Ti6cET4GoICILblPuGZhm4k26nnhcxUs1hS8CrNIdOM9EaIr5gDUjTZTNeI2?=
 =?us-ascii?Q?ju10RiSTniD0l6UBWqGF62N+ObHzMSj7fTLFigyA2KKB7Jei7z1PPLR+VaDY?=
 =?us-ascii?Q?AL/k0vb7yOiVeRTXGyeGAo0vK/mMcN2TUx/eIwXXFCfRZJQXWs1Rke2Hq95c?=
 =?us-ascii?Q?kET95qeajk3hvkMDzagnomvcTP08hP30ZMxYpBhkv2f3lCPAgGeddN1cuvfK?=
 =?us-ascii?Q?wlkaI1DHXeTN3hRSOuqo2tQcC+EHpjI1+pDqmGFJjNO7IfxWMmlAi8R2afH5?=
 =?us-ascii?Q?80MnkFR84J0LXgFyeLX7QT+K7Ye6QRdOeHbmD6cC/4e2/3eEnLhh6UN6Wo2U?=
 =?us-ascii?Q?4pREBaRjHAFIltVsEwIF8spkntNuDKivco16ud3OLcx6Y2v/U2D/xjfqI5E3?=
 =?us-ascii?Q?ZfLFyjrWWr3U2Uw1XI0/iizyBPlQMr2/9qUcSO23qj9zDyUGHniMCsc5TTNA?=
 =?us-ascii?Q?6Fk8xIGaNt1HPJslmaDbUv7r30OvEHUcabbGu/ZtD7QJQRdjTez/bwnLe4Pn?=
 =?us-ascii?Q?AN5zRMY5//WezjkfNgLVj5ELLgfaH0Ex75XagHuu+aldY3lfCvBc+YPQehp5?=
 =?us-ascii?Q?HdlkLGvTw892KWwi7XQTLB/iHc/g2chd9sUVWIlRFIP9F+rkcVtkr8epjD0X?=
 =?us-ascii?Q?Elo8qbZFrdIPQrbZP5BFCR4zN2mT42yJnOqIZB5LBjP4PHULGJ3xIzTdpaYb?=
 =?us-ascii?Q?uerAy4Y33hndzc8EMxsxp0mXApkFoGbMIxT6fY3qD908I3i4ywDvBjxsA3S6?=
 =?us-ascii?Q?4QKkM2XQ3ETXacDfRTYXfmqZBK/bN/sfMqfCV2u7vuZ3DOD8G3g3EKNHx1Ci?=
 =?us-ascii?Q?SEZZEJiLIFPW7yfVF5EUhe0ncol7kfqEf/IQln47Ablhzga7qvTaIh8Nk101?=
 =?us-ascii?Q?WFSvXpRnlntXHYdVYIN3VhHecHJTG9GKOsv5cH4DhXmeqIQ146Qrtd7UcYTR?=
 =?us-ascii?Q?RMBBrFISlXOKCpaLQdY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ACn/DBfRiYEZq6zPmraie04Xi4dOx2oMaW9vb3XBtY9vO7d2WnH1I/I+gxy?=
 =?us-ascii?Q?PpPqt/QyWh6md5DXk7hwFdBbB1q3dA51SQnhRWQ/pooEg7KCnm/aUNMECMSo?=
 =?us-ascii?Q?CbViECZaAtO0ExMXJJSQVTSLiTac/wbdmuilW7xjcRaBD2T1gJuPMHsJNOxH?=
 =?us-ascii?Q?419jGlkSiV5cwHS1iLvyDWrVaZ240sYbgfDTlsJiBlIMOq3P8ecTqqqqxBd8?=
 =?us-ascii?Q?fXMKOVxqoDP/iRcz/SqsPnfaAKIdG132l2vDLmUtu/Cbr97Gk8mYpDi0YBeX?=
 =?us-ascii?Q?sYut1/NipbHkn1acqECHIN6t+UUGm+DdLQzu2PlNkEk8LDMtHTUAfItO93ix?=
 =?us-ascii?Q?EeEywXQm0lrPjh14UiYCMDJN08rZEVmIw67MYzcG6uAcT+X/yghPuR9roue3?=
 =?us-ascii?Q?KriV5jzLlSdNsTQ2k4W2qgv+yBxK6EtphS2RmURSZVxhYM6mC9v9IX1AyX80?=
 =?us-ascii?Q?0mfIniWwVbq5Z4ciNGiJChQcR9Ilh/CfRi1KQqKx3ppSXTFbE2xp8DiDLzxE?=
 =?us-ascii?Q?rYc8kwoZvywQpQjLrXxlXH/1h8PaThnlasy8wXOb5TZay+Nx26l/gXjdKTG1?=
 =?us-ascii?Q?agu3eRmOULCUW9E8e8sisGQXKqvJy52BtU8oJLm07mEUxPId76+oB+uPzK8F?=
 =?us-ascii?Q?0ndDmzkyRcOcq9GtEgqhkNP3wijYB58MKHMs1LMy5qK+iJYhZF0iOWUVjx/+?=
 =?us-ascii?Q?Qoxus7gGxW6NTtKNPjOJS6FL2Hd7aa4t5xv40LTyZAoeUPmXuBxBhaCkfACm?=
 =?us-ascii?Q?8oEKoBgaHfmWY/Cbs/kFpIWI14VTGmpvdf2hEPd+d0WhaKYJhz9XUc+OZqV6?=
 =?us-ascii?Q?yqsDXFjAIEZg9KMz5p6eYQgH1bxd701Ou9IRJI7Imkhak2FsJ3i6xTSSj/Zn?=
 =?us-ascii?Q?7daaCCo3OnaMJ0aEQi2I8Y+kghbi4oNUt/PumEOyRA09B0TKL57+Eg/3lhjz?=
 =?us-ascii?Q?mtJqAWuwZREcNM1pgxfIjvE3Y2gNPuQPsg08Zgyk3OzmrjfJ7cwrCNPkc0GT?=
 =?us-ascii?Q?e0Jnyr0CWgGTogcbCP3DxdTRXo7zVzP8gnJKE12JP6ugmBxF8oaYBGH5KhK4?=
 =?us-ascii?Q?r8w38tgo3nwCN95krVLPyzYrsY4tQ0qaTITlk4k3JT+QYAOGxvjbxCQAueuA?=
 =?us-ascii?Q?kDlSiSdGG5ThxR7MsnkamJH+Fo7kemUwjtQ4edhps4YDuiWSoYyRZeLVAAAb?=
 =?us-ascii?Q?AhxNo5OyE094rUwEqexI2dws7qKN5K3vDJcQO8GpW/kRf8cB8tTvECmWQdMX?=
 =?us-ascii?Q?4g0ir5yKFBLngMquyCvTxFyjx1TOqB5ClfJr9YA9FFSw0yf899j5cv0rFYRc?=
 =?us-ascii?Q?BpJZRx7YEnITiglm1xGkXU/08XEh5KyONR+UKs2wRiCd0rTE8jzSw7DPJu9g?=
 =?us-ascii?Q?KUZZUIAiOKXCF4ucU4Y9G1eiHGtuubaj412SD367rmZ+JWJswr37+D+NTaOa?=
 =?us-ascii?Q?TQf/Phw3ZQGH1qA2RMfRAbi99HakR7N4tFV4AqIRHwZgtQFHZ0c8FFxqmRZ3?=
 =?us-ascii?Q?hzkoaOPdsTk5wo1+SiCfar1oOgTYMFAXMw2Zozhx15DoqaF8Ovs3KPbUEXk2?=
 =?us-ascii?Q?7GLSjWmrAtEBXRnTi9TOMwOBdltnz5s0Tg6VUqaGLF9amcx5iSX9pAUIwSAI?=
 =?us-ascii?Q?4pX2c0CJ8RMM0LUXMsoP5TJazntO2s9OYELjQ/w6kSjOO6SVfhjkEdbdoVFP?=
 =?us-ascii?Q?Vd5EcFl9yo+m1NsKNVvjEVcQMotogODgwZIT5NyYc99SNyffswsrxhN3/cW0?=
 =?us-ascii?Q?IkiXKR6bRZi51z7ckWh/MxNTeSyF/DI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac83304-55c7-4b1f-a5a4-08de6f664f45
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 03:23:54.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4kMXlBTBumFgPolav1N9yQOurHQ2XD40M6PYx/mJz2ulrnYYHdijwNWCOGz46RVXN2vxm24AtT1BLWkJaNeCSplxIXimJcQbxTcQQxRf78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8798
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-77661-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,aschofie-mobl2.lan:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0424215BE19
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:44:54AM +0000, Smita Koralahalli wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Replace IS_ENABLED(CONFIG_CXL_REGION) with IS_ENABLED(CONFIG_DEV_DAX_CXL)
> so that HMEM only defers Soft Reserved ranges when CXL DAX support is
> enabled. This makes the coordination between HMEM and the CXL stack more
> precise and prevents deferral in unrelated CXL configurations.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

