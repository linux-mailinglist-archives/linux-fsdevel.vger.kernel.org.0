Return-Path: <linux-fsdevel+bounces-76995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMGIH3N1jWnN2wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 07:38:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D6F12ACA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 07:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA13330762CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA6E29AB15;
	Thu, 12 Feb 2026 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daYQP2pY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B85D296BD2;
	Thu, 12 Feb 2026 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770878308; cv=fail; b=B3mGhRESnZCRAvEYVmKTfz5PETAyJ+QuWFvYb8XuqWuvIbsrpwpKn1GjiTNjasrxWUlz26bXXRsE8DxZrtFMtUdG+83w+OoZENVaIsghXvdD8UD3gSFFYm1YkrXdDqJHd7DwwrF0QRZKdUKqbF5fEIV/fxO1lwn0e54h++n6a4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770878308; c=relaxed/simple;
	bh=ze6ietHYCZofNJXRefNrlCQYIOCLPGATzsgZtvQycas=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lJP6kpRJYFhXgKty+oogr+qiRy8avgBBM9OysqYlYrk9FFG3ShTMZmMEuvOEfTg7c4tTJ83OuxBROGhpdaNAmlwMqi5zo/0iz5u7K9TB4mmHsa9CBHeJrICWS5Dpc7jKFJ9Husfy2DnZqOMcCwoi82lGKBnVMC8v0zhHalopZ1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daYQP2pY; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770878306; x=1802414306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ze6ietHYCZofNJXRefNrlCQYIOCLPGATzsgZtvQycas=;
  b=daYQP2pYKXnyEAe80wPebkN9rJZCF9D1IGDVF7rcd39eTn4cU/wcifr3
   zFloouTrv7To2e78IgCD6zOGw0alS4+ooAGx+MifUfPJXsn2K7qzJQ2OS
   3psPvETrny81l1y2cS6OJpvgNZD1hG8QSvG9Prnwqg7h382pcSGPeqMaO
   C5C4DCmtnqTUxn8Qsa6ZYCW1ZwVSfpbf+OJ4KrSgv5UMDbK/sekxQWlQI
   u/QfWhrHCl6Vv9dUpk13aawTNelJWCTHVaSzxT/sm67x7hUHbRLSqUeSk
   xN/vQlzBFfR+QumnDlV6Oy27bpVLSj5XLYYjDfIaT81kc7oj1jH6mW8c/
   A==;
X-CSE-ConnectionGUID: FtzP5oPDR/SiHxN8d1lSyw==
X-CSE-MsgGUID: ZeobWWsZQHO3MLEXyiMVFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71246644"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71246644"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 22:38:25 -0800
X-CSE-ConnectionGUID: E2hNm9iLTIi9nTb+BvD2ig==
X-CSE-MsgGUID: sxr+0hQdTd2fJzc13nmyxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="216732898"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 22:38:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 22:38:24 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 22:38:24 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 22:38:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNYgIpgsHoRBTq6ldKL48z4VN3aXgLfS1LXxq6IJnY2dXrrXNuXVeFW3qE58e+OcY3sXrDbto4sYy+o4jXqe0PONV2NxvSFmaPEx+Ss34xCDqUqMucPlmCJqDWx2NFQJOEHwVzZQ89oZiCK7OnB8m6+7GBNb3I4qgpxofG3ykUEQkxqY3jculnxQDWIuhor+eQgUY+AhNmjIIKH6YDhI1qnc5hvkqFj3wCApvzYnWU51fJDduZoopHF1236/lzLU8nD5lQD5UJ6U8qgaHUbJhOHOXj2gTRZqU96yXogcGVrlfgTN03Dojgypdy2SwbjDOFICipDu3gIN88acxK13vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FauLIkAHrMNDQjwIQ94PAawMBu990v/8eZ0JxQxUx+c=;
 b=y9ILyv+hrgq/AfpFBqtSaAlJ7NkFTIbMlaNgLhhmxW7on4gQaqaAoa69xbe2lTGFU/Qo0q1Y3rtaWPRY3EPrmhoqPvowMqhmJzt21pPXdMQbl5aCuiz7JD/zb7ckF9PD4Jd781TSj+rJlfPmsd83zwfa+2gY5gU1kXJjZo2nNiwwfUMRSXfZGqR0J18PDtYP2rQaEFJ6p79ApN/6c7RGCLGNm5p1Js0CGl/3fwGHn5QUrE68VOOyyCc3uaO3rrZZNAAA0GWo3SZiEOvswCA6P0a8teCivD25Wafh57gPPWJjASAkpWeZbSIm2HNzD2Cpj7eXE0KO44+TFEnNAYUq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB6653.namprd11.prod.outlook.com (2603:10b6:806:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 06:38:14 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 06:38:14 +0000
Date: Wed, 11 Feb 2026 22:38:04 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Message-ID: <aY11TGmQvzuSKxyO@aschofie-mobl2.lan>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <aYuEIRabA954iSfR@aschofie-mobl2.lan>
 <d06fb76f-3fb3-4422-a8b1-51ea0c5e48f5@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d06fb76f-3fb3-4422-a8b1-51ea0c5e48f5@amd.com>
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 07662aaa-2913-4c10-3be6-08de6a014c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P4waPTfF1Siw1YXPbn2+QCGz09d8JrgvVPjLlDNobASfb25L8fE4gKEuA5GG?=
 =?us-ascii?Q?LmlRvu3H+SqKeEWd3wtn/li8iRR6GeaueeWTpuLyyHlLLDZ4AvYq4RWmTDg4?=
 =?us-ascii?Q?JHMKWkpOYF0dhWDGmox91IIJw44SNf0m3QdBqrhZJPrfH74nPehn9tS9h3e9?=
 =?us-ascii?Q?AjYWQK2zWONramjO1iIz41qNBhllP6jNdOUaOjBqmwKB79tBGjbKaLGEI5vD?=
 =?us-ascii?Q?c42J6Sf/lHOvQ5PsxH6E0PWSoJ/kr18cU08p+A1CT/M5jTinvko/NkC8kIIM?=
 =?us-ascii?Q?cTw3qwA5S6rxspp4jBKd9nAUkBtX/u5IJ2SU8vTs4+99pE7kfBeJjlnDZiAZ?=
 =?us-ascii?Q?XiDsyKI94xpqXQh0kvGB1DCweiwchTtxddg871rG4ibJWjo5ShcmggFMY1Ct?=
 =?us-ascii?Q?ZQr27jv7JRySfwbhyQi5qr154xMWjfdEsZARE09GZu6xxY4OKZauQKC6uvGo?=
 =?us-ascii?Q?mKWY2ZugXqHIuU3opAlQ5qx6X9rf9qv72TZB9ds8MIoxaoPgpM4JGQhqx05/?=
 =?us-ascii?Q?+xUEfVcFoBf3BCqp1esxFz3Tm8/vKCmspVsGedQLD2r9iOq9fv5Js8b0ygpD?=
 =?us-ascii?Q?ziZjp26DPoJO7ZnsQ7upRiucX7NbhaQCd2IdHmQEDLQgX4wBHnhSR3CVedDU?=
 =?us-ascii?Q?iu1Z195wfhyLSOBiEMvmzT9cmgb0c0k/1pmTv1tYqzYKMgcZLxPU5BgyY5UA?=
 =?us-ascii?Q?fi9Ww7XsoU89LOm5jM4UZH6OJZAbd4zbRDzGimCOXxdyXu238W3TuM8uoNOW?=
 =?us-ascii?Q?Qk4MtMAUZ4gr3PlnT2XilR+P2O4nYpAJIapvolXb2E/VNdfdl649bx0HkRpt?=
 =?us-ascii?Q?Kk/szE0HGP5om1KDf0l9fe5TYwm9OM3MOTrC289nTwH1/n06o9N5Pe/Im5Vs?=
 =?us-ascii?Q?HAPU5udPVZ6O+psyReQhJjd1X7wEqdBpu+vlgSxZ4OkLzaIpowdmSYv3ubnY?=
 =?us-ascii?Q?vyIcCH5dUBm6ieo55QHs3FHTBI/bB7qKQKJSCZHXb46AiYM7GysbFhbr9mgX?=
 =?us-ascii?Q?KxDsJohyCBC2NTtk223vxXidBoSfFHLNqBx8cTQjPVvviCbAO6ztcjXGvfIr?=
 =?us-ascii?Q?mz1HFXDT/7Q/mEBt+K48I81aMJR9hu65f88g4kkPqkg/OJtHX0kAj6ZZB5n+?=
 =?us-ascii?Q?wQsGLfKVkponzUtAzjUi0S+yUhBDdQfssE4PtGz8OvI6Ci4CNDbHdgG+wr3W?=
 =?us-ascii?Q?BW7Rq0/JUAXeCVNd9E7FtT4+/DiTPd9aezhU/CQZcppvfdYY5lEM0U6UOi8l?=
 =?us-ascii?Q?vr0sbPrku5RwImrMI6SxxKRUa7vvaely2r2aHzjGZmn5OWJVfZDZQK9glngK?=
 =?us-ascii?Q?YnIjEypOO5LHUX53LDWHnxkrgIKdDxoYP4saXrG1GuVT/f3RPwXG2xrhpOW3?=
 =?us-ascii?Q?zgnNBfAvuex7WH6jOof4wx6muupwnIQzH0qI45xu9jZwBdre4MAEE+xKosaw?=
 =?us-ascii?Q?j5funMKNhPqKXWneQC5A8CRAJnXE/qzIH4sNmIM6nPX8iRqbF8Tu5flNW8V4?=
 =?us-ascii?Q?uTe4DX8sXcmvcXNCKpmmHe5PM5HsxhnrLRjigqcKk5ehqefs8r+pYhkuteh6?=
 =?us-ascii?Q?T7pBQFwZY7vPy9Drm1rlc9u9U8FqKUOlYaCLFXx3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FKE2JcfZEuXJukB44oWJWOXaak3SlVYnAagxskYf25YZvrDqXdBeRsfmJaBc?=
 =?us-ascii?Q?SA0GjWlWybXk7A7GU9dHbrip9KyQ8ZjiuS0I+85dKnbMZuta3Jyi/XVumNDB?=
 =?us-ascii?Q?FnK/AsErP0+PD4taVrYj+nPDSr05SoSKiSUuaWJ9JlAlvlLbkRVrlLaii4aE?=
 =?us-ascii?Q?eMUoAysULlBXQhv3nnKbi0CiGseZuAVd4d6Jx74zJVetlkRHRE9e5o2NjwEw?=
 =?us-ascii?Q?GJeFA3QOGQ7Cc6P+LcP8ECCJ7xWycIHhPjOhJJxbhD2WaJHQstR85zqY1Owf?=
 =?us-ascii?Q?umd56Snc6nsUmpJFRBdx8bHrmZSDJqvpIfcfl7b5+WoUQBbJAIu6yKOHYtmm?=
 =?us-ascii?Q?OIm1+Uyjdyc6bPO5Kpg8KvGX0PuN8J6kN6M+EhasHd+awenDTi2S4160sHnw?=
 =?us-ascii?Q?OpWwalTfPFnzn6N8JMYDexCFwilI49L2D/0yM3r3YjCA65XX5439Nc0JxMGD?=
 =?us-ascii?Q?gAHd0yX0KKTseq3bfKYEKp4x1jGYqFuijvV7qLO5AG981ogDan2UhUpYIqK3?=
 =?us-ascii?Q?JAX/iCyMb1x5sZ0uQC+cYdCyf1fjT4qT/n7lW7Xy8Nn1S7aLQmcDNBVM8wXs?=
 =?us-ascii?Q?h8TI+NxQymgaXVyr6S0ef5ihpgsAWLXGjWQwHxoXsEwNzPHKA+X1ZFE5IR3F?=
 =?us-ascii?Q?9fJBcr/OQvTcO3xMMAgSfexkdekabzK5jLscR3q9EciJt+XAQEI4yNLhA5Km?=
 =?us-ascii?Q?0Ya5OQhLxcdao3+mv7vBSaJKknKS/R8hRkRC/C4SRAr+mddRLLhQ5tt1ywAi?=
 =?us-ascii?Q?8echEoyfi26wYP/unBjELgmq9PSypmoxIPZkblSdnlGN9u+F52D5EjN8vrCg?=
 =?us-ascii?Q?dHOP2+Ys83FWbCb8LyvwW1rI3VNeRjA5FFj0T2kYWz4T9dDeDqYiEnNz8YI6?=
 =?us-ascii?Q?EZ14ems/n7K4YfvlaYBeRbMhuTWAXhng7eklt8xdtEqGPPNbx5D17ZE7s/gF?=
 =?us-ascii?Q?zM76g+oQEAhE+1Bri+ZmMJKR4YMNs88LO1mc/Xvrz9utgcAzYzF0t3ZEWg95?=
 =?us-ascii?Q?YA2+fbE/oSUv+POx0CF/T3SvT8+wzfRVbbUhZZ1cJ5fPevAOz2nHqAEeio9M?=
 =?us-ascii?Q?Tqu9hoALFKOqqs9tIR3hp48iEo5KjcfKrqek0aEWZIyaVy3pXd83XZclZ1K2?=
 =?us-ascii?Q?Fbm9wdjK3uv2XAefznogDD/cUzaDPIG6UcnSDQLTfdkEOjWa3MziIvZBtlPM?=
 =?us-ascii?Q?bjZU/GjSCoCBN6DDaJPqk39qxf9ujaO8JSJLoBbtCA+DrAskN3KXYgczZkBj?=
 =?us-ascii?Q?ii2F+KuvmNRG18EBF/N8sCaPb/VQdK1Ii5lAN9xEiUM6/42Xj3GjRoCvoQeI?=
 =?us-ascii?Q?aBZwfLxAU8F0YIOvsVRq+U1ZlP8li+f1kF2OL/BSzXLEnI/+ACMGu7VS+H7D?=
 =?us-ascii?Q?L+cF7uu5+z45u99vAwN+drQFaXS0MsPHiZhAsVwWkbdou2DkPuxLWENnhOQs?=
 =?us-ascii?Q?JdbvxBaAnqKVJKo/G4vDk6IlPicr+knvjvzIcm0TpxYPnN2EWjkO/R2uBAH9?=
 =?us-ascii?Q?g3zvtCFW2osWY1fmgUNkg65BkoNNXtBky8eguAsXDTh8OCPGdygZDg4fhH5Z?=
 =?us-ascii?Q?RqODBJJmoHUUotxJQGF8j3f31l/JiFBGbB7NttK07umB+7E/WQ/cFWzYvifb?=
 =?us-ascii?Q?GMihHHD48EH2j+HkDMc4+koEENSRI0K3XvafSEsL6FmuE/M3jsFRoy+c5Jiy?=
 =?us-ascii?Q?9OM7bwto4ZO7T3SDeXGfIrI37bIL3OGIF7g/MJzAcRY09GpaXdB0AugZXWAs?=
 =?us-ascii?Q?ZEpj03fVRRrnydQXITuAwg7wflLTnTk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07662aaa-2913-4c10-3be6-08de6a014c51
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 06:38:14.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgfL8jmrflUa/Mol4biDAA2OD9t3L0WVagNLZIDCTs0qn5XbIF/SeQ7NQVbLs8pmg5WkKsOOh4b1WNBIrNqlMFOq3zm09aMCPBaA55g5nzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6653
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76995-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,aschofie-mobl2.lan:mid,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E7D6F12ACA5
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:49:04AM -0800, Koralahalli Channabasappa, Smita wrote:
> Hi Alison,
> 
> On 2/10/2026 11:16 AM, Alison Schofield wrote:
> > On Tue, Feb 10, 2026 at 06:44:52AM +0000, Smita Koralahalli wrote:
> > > This series aims to address long-standing conflicts between HMEM and
> > > CXL when handling Soft Reserved memory ranges.
> > > 
> > > Reworked from Dan's patch:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
> > > 
> > > Previous work:
> > > https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
> > > 
> > > Link to v5:
> > > https://lore.kernel.org/all/20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com
> > > 
> > > The series is based on branch "for-7.0/cxl-init" and base-commit is
> > > base-commit: bc62f5b308cbdedf29132fe96e9d591e526527e1
> > > 
> > > [1] After offlining the memory I can tear down the regions and recreate
> > > them back. dax_cxl creates dax devices and onlines memory.
> > > 850000000-284fffffff : CXL Window 0
> > >    850000000-284fffffff : region0
> > >      850000000-284fffffff : dax0.0
> > >        850000000-284fffffff : System RAM (kmem)
> > > 
> > > [2] With CONFIG_CXL_REGION disabled, all the resources are handled by
> > > HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
> > > and dax devices are created from HMEM.
> > > 850000000-284fffffff : CXL Window 0
> > >    850000000-284fffffff : Soft Reserved
> > >      850000000-284fffffff : dax0.0
> > >        850000000-284fffffff : System RAM (kmem)
> > > 
> > > [3] Region assembly failure works same as [2].
> > > 
> > > [4] REGISTER path:
> > > When CXL_BUS = y (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = y),
> > > the dax_cxl driver is probed and completes initialization before dax_hmem
> > > probes. This scenario was tested with CXL = y, DAX_CXL = m and
> > > DAX_HMEM = m. To validate the REGISTER path, I forced REGISTER even in
> > > cases where SR completely overlaps the CXL region as I did not have access
> > > to a system where the CXL region range is smaller than the SR range.
> > > 
> > > 850000000-284fffffff : Soft Reserved
> > >    850000000-284fffffff : CXL Window 0
> > >      850000000-280fffffff : region0
> > >        850000000-284fffffff : dax0.0
> > >          850000000-284fffffff : System RAM (kmem)
> > > 
> > > "path":"\/platform\/ACPI0017:00\/root0\/decoder0.0\/region0\/dax_region0",
> > > "id":0,
> > > "size":"128.00 GiB (137.44 GB)",
> > > "align":2097152
> > > 
> > > [   35.961707] cxl-dax: cxl_dax_region_init()
> > > [   35.961713] cxl-dax: registering driver.
> > > [   35.961715] cxl-dax: dax_hmem work flushed.
> > > [   35.961754] alloc_dev_dax_range:  dax0.0: alloc range[0]:
> > > 0x000000850000000:0x000000284fffffff
> > > [   35.976622] hmem: hmem_platform probe started.
> > > [   35.980821] cxl_bus_probe: cxl_dax_region dax_region0: probe: 0
> > > [   36.819566] hmem_platform hmem_platform.0: Soft Reserved not fully
> > > contained in CXL; using HMEM
> > > [   36.819569] hmem_register_device: hmem_platform hmem_platform.0:
> > > registering CXL range: [mem 0x850000000-0x284fffffff flags 0x80000200]
> > > [   36.934156] alloc_dax_region: hmem hmem.6: dax_region resource conflict
> > > for [mem 0x850000000-0x284fffffff]
> > > [   36.989310] hmem hmem.6: probe with driver hmem failed with error -12
> > > 
> > > [5] When CXL_BUS = m (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = m),
> > > DAX_CXL = m and DAX_HMEM = y the results are as expected. To validate the
> > > REGISTER path, I forced REGISTER even in cases where SR completely
> > > overlaps the CXL region as I did not have access to a system where the
> > > CXL region range is smaller than the SR range.
> > > 
> > > 850000000-284fffffff : Soft Reserved
> > >    850000000-284fffffff : CXL Window 0
> > >      850000000-280fffffff : region0
> > >        850000000-284fffffff : dax6.0
> > >          850000000-284fffffff : System RAM (kmem)
> > > 
> > > "path":"\/platform\/hmem.6",
> > > "id":6,
> > > "size":"128.00 GiB (137.44 GB)",
> > > "align":2097152
> > > 
> > > [   30.897665] devm_cxl_add_dax_region: cxl_region region0: region0:
> > > register dax_region0
> > > [   30.921015] hmem: hmem_platform probe started.
> > > [   31.017946] hmem_platform hmem_platform.0: Soft Reserved not fully
> > > contained in CXL; using HMEM
> > > [   31.056310] alloc_dev_dax_range:  dax6.0: alloc range[0]:
> > > 0x0000000850000000:0x000000284fffffff
> > > [   34.781516] cxl-dax: cxl_dax_region_init()
> > > [   34.781522] cxl-dax: registering driver.
> > > [   34.781523] cxl-dax: dax_hmem work flushed.
> > > [   34.781549] alloc_dax_region: cxl_dax_region dax_region0: dax_region
> > > resource conflict for [mem 0x850000000-0x284fffffff]
> > > [   34.781552] cxl_bus_probe: cxl_dax_region dax_region0: probe: -12
> > > [   34.781554] cxl_dax_region dax_region0: probe with driver cxl_dax_region
> > > failed with error -12
> > > 
> > > v6 updates:
> > > - Patch 1-3 no changes.
> > > - New Patches 4-5.
> > > - (void *)res -> res.
> > > - cxl_region_contains_soft_reserve -> region_contains_soft_reserve.
> > > - New file include/cxl/cxl.h
> > > - Introduced singleton workqueue.
> > > - hmem to queue the work and cxl to flush.
> > > - cxl_contains_soft_reserve() -> soft_reserve_has_cxl_match().
> > > - Included descriptions for dax_cxl_mode.
> > > - kzalloc -> kmalloc in add_soft_reserve_into_iomem()
> > > - dax_cxl_mode is exported to CXL.
> > > - Introduced hmem_register_cxl_device() for walking only CXL
> > > intersected SR ranges the second time.
> > 
> > During v5 review of this patch:
> > 
> > [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory ranges
> > 
> > there was discussion around handling region teardown. It's not mentioned
> > in the changelog, and the teardown is completely removed from the patch.
> > 
> > The discussion seemed to be leaning towards not tearing down 'all', but
> > it's not clear to me that we decided not to tear down anything - which
> > this update now does.
> > 
> > And, as you may be guessing, I'm seeing disabled regions with DAX children
> > and figuring out what can be done with them.
> > 
> > Can you explain the new approach so I can test against that intention?
> > 
> > FYI - I am able to confirm the dax regions are back for no-soft-reserved
> > case, and my basic hotplug flow works with v6.
> > 
> > -- Alison
> 
> Hi Alison,
> 
> Thanks for the test and confirming the no-soft-reserved and hotplug cases
> work.
> 
> You're right that cxl_region_teardown_all() was removed in v6. I should have
> called this out more clearly in the changelog. Here's what I learnt from v5
> review. Correct me if I misunderstood.
> 
> During v5 review, regarding dropping teardown (comments from Dan):
> 
> "If we go with the alloc_dax_region() observation in my other mail it means
> that the HPA space will already be claimed and cxl_dax_region_probe() will
> fail. If we can get to that point of "all HMEM registered, and all CXL
> regions failing to attach their
> cxl_dax_region devices" that is a good stopping point. Then can decide if a
> follow-on patch is needed to cleanup that state (cxl_region_teardown_all())
> , or if it can just idle that way in the messy state and wait for userspace
> to cleanup if it wants."
> 
> https://lore.kernel.org/all/697aad9546542_30951007c@dwillia2-mobl4.notmuch/
> 
> Also:
> 
> "In other words, I thought total teardown would be simpler, but as the
> feedback keeps coming in, I think that brings a different set of complexity.
> So just inject failures for dax_cxl to trip over and then we can go further
> later to effect total teardown if that proves to not be enough."
> 
> https://lore.kernel.org/all/697a9d46b147e_309510027@dwillia2-mobl4.notmuch/
> 
> The v6 approach replaces teardown with the alloc_dax_region() resource
> exclusion in patch 5. When HMEM wins the ownership decision (REGISTER path),
> it successfully claims the dax_region resource range first. When dax_cxl
> later tries to probe, its alloc_dax_region() call hits a resource conflict
> and fails, leaving the cxl_dax_region device in a disabled state.
> 
> (There is a separate ordering issue when CXL is built-in and HMEM is a
> module, where dax_cxl may claim the dax_region first as observed in
> experiments [4] and [5], but that is an independent topic and might not be
> relevant here.)
> 
> So the disabled regions with DAX children you are seeing on the CXL side are
> likely expected as Dan mentioned - they show that CXL tried to claim the
> range but HMEM got there first. Though the cxl region remains committed, no
> dax_region gets created for it because the HPA space is already taken.

Hi Smita,

The disable regions I'm seeing are the remnants of failed region assemblies
where HMEM rightfully took over. So the take over is good, but the expected
view shown way above and repasted below is not what I'm seeing. Case [3]
is not the same as Case [2], but have a region btw the SR and DAX.


> > > [2] With CONFIG_CXL_REGION disabled, all the resources are handled by
> > > HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
> > > and dax devices are created from HMEM.
> > > 850000000-284fffffff : CXL Window 0
> > >    850000000-284fffffff : Soft Reserved
> > >      850000000-284fffffff : dax0.0
> > >        850000000-284fffffff : System RAM (kmem)
> > > 
> > > [3] Region assembly failure works same as [2].
> > > 

I posted a patch[1] that I think gets us to what is expected.
FWIW I do agree with abandoning the teardown all approach. In this
patch I still don't suggest tearing down the region. It can stay for
'forensics', but I do think we should make /proc/iomem accurately
reflect the memory topology.

[1] https://lore.kernel.org/linux-cxl/20260212062250.1219043-1-alison.schofield@intel.com/

-- Alison

> 
> Thanks
> Smita
> 

