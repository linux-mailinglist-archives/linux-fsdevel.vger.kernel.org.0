Return-Path: <linux-fsdevel+bounces-77662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE8lO06HlmmZgwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 04:45:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5683415BE92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 04:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A9F3039813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F0E284B58;
	Thu, 19 Feb 2026 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3xLMlVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AD2274FFD;
	Thu, 19 Feb 2026 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771472696; cv=fail; b=S+4H5PQCWqYdh22g4tihKNCt/zamv4RhW6krrjaCpXHK9sMWnfaJB0Y43mjIgTRTpTn9PEzq0ZziATS4yIYDF/3N5974SO/1hU+ZqV4eMT4zWXTDlfyLN4rMx4BU05V7LL46+W+5ByduMNb6Nura02AwKy6GTT1lcInGXWspjPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771472696; c=relaxed/simple;
	bh=ouLzLyFP26Xxp8hC0ee6DRJOu/FEJ3LboNS6xBRwmLE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SeJH4GLoLbV3HlPDEP45wVbYfRmylOBjykDL4rD4iDWyL310yEB0KC1BYXNMh9k+BLakvi5OkhKdbf6dLQoRJlWNU8HOo+sh4mjHETnktNT6WIlcHIPLofkHHs8qtrRV8PSGTTTTE/RWFB1lbTbC/ILRMVp4ZeVgNbQcOhBBn88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3xLMlVx; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771472695; x=1803008695;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ouLzLyFP26Xxp8hC0ee6DRJOu/FEJ3LboNS6xBRwmLE=;
  b=e3xLMlVxNgLQyiR8stEwJd4RGjkfc0AZMbFTZzJxw6mT4BEkGpAnNU9r
   DgxmD12FrGStha/efrjmj+nJqmEObeJYpdqzcD8pASeEu1yYV+XiCaCIb
   Ry0PC9hHolikUm+L7wD7Z5kooy1QBqIKJBFsUuZS9MNqKS7OgE0CMTK3I
   5P67ddNADj5aaJ4YjiKh4Ks5oWNn1Ab+dJyP7BX3BpOD/aHExt6YsEzN0
   e4pztfp7eY0JN6K6lmebWuQjO+VeanIcveTfOJAtztTQu9EL7VCbeS5JK
   fdVHSagsLS/7QUGL1OnPeUdogroVsbfKtrvhQ6SyUVn8Ee1PEeCCpymAu
   w==;
X-CSE-ConnectionGUID: oeLKiXmOSJGgE+uBh15tFw==
X-CSE-MsgGUID: 2Zg2iMWkQ0uYIh/Fy4iTOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72444169"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72444169"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 19:44:55 -0800
X-CSE-ConnectionGUID: zXX9PsVmSX+vbo278bFCTg==
X-CSE-MsgGUID: jvdMeiN6TO6VNNQVrJd56Q==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 19:44:54 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 19:44:53 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 19:44:53 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 19:44:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6nNtYzon3jskxwmDwu75h4UdKs7Xht9euJHcqX7gFu/vnPqF2jOUmc+yJdHRlSOBmbZbf7LIP+34TLC2J8VonkQ62gKgZ3foPYzPK1de3XD4dUQeZgWCasar3ACD2haWl12F+B9pN1EyT7tfQwn05a7AOMNyu694x9ESeyJAJjTiU7QUwemtGRRh/pUi7Ca7MPg0D1aSqhEfuNfz2rdXL1BxrSqZhUcqpk/3j7VgDtGZXmOcQak/QgsWHsi4xGmZBup3i8NXSwUx9yk8IAd3O46U5xWUbDq6A5zgEk5JyoIZbpzQ1+AtC+zRnN//B+B57h15SA6cX7CVePlhWg/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3rdA9NQ3JTju6jDJ4ZRVT4X3tIW2NFY6EXVDKIMjEo=;
 b=tXI7CUnLjPi2GkrOe5G2kNfDFeTvGtSnKNQ8x5kbRZGhPdnfwe/gl6DWtw+oNMI0V+5+GAs6189J5KMOa3Q9/yRraZUyaTaGaMecxK+qul0Ylt37kCKgnDdz8ayNF2Cp3LtuTHJf9xe86clrbwd0COuNcAkyFEoGRVIpqhMxLQDrxx0Z60zOuXi+Is9m95vYCTuwoIcJBX+djVx1EVYNfXownqC3PZdBSTzCtLMICkbH3jepPuZ2r8Jm44TFU2KdyFd/JSyI6lYbN5sRzXIWiCXeEUISG/cDZ1rftpotUSb0HH29M337ycezBCrMThliFOTpzCQehGI+Jz+OfiL9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6983.namprd11.prod.outlook.com (2603:10b6:303:226::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 03:44:45 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 03:44:45 +0000
Date: Wed, 18 Feb 2026 19:44:36 -0800
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
Subject: Re: [PATCH v6 3/9] cxl/region: Skip decoder reset on detach for
 autodiscovered regions
Message-ID: <aZaHJPdKMy56dLcW@aschofie-mobl2.lan>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260210064501.157591-4-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c54fcb7-5ff9-46be-10bd-08de6f693904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rhqt+vtC5A1EhIIdagNqjbVgEaHCXAuj2vXwjBXOfj2OER20O+lo+f2Q0DJm?=
 =?us-ascii?Q?LS07i/uAD710kpkJs0cwUrCgNPFNWq2NS1xBs5iT+YmljTiJQjjgnImbyBdB?=
 =?us-ascii?Q?91HPOtWeemYMyGto/CTcg6XKXEjwB6r6dJVL1FAjRJb89gHnux+PPbOURbtc?=
 =?us-ascii?Q?Qo0BaSQ91IzINOm3gLm9c7vihjNMDKabXgCnxZJ07LNGslK123EsCEHMsl/X?=
 =?us-ascii?Q?+1rKxTMUpx0Y8P6PhYdg1jgk2DR7HenJ0N/P9aemkAbgw1FssXnCiXV0em/W?=
 =?us-ascii?Q?lxI/ZWIaQ2iiWjztiMLdGcCM8VhhtX+ZZMA1pV0Y2Nd5zaU4FafKWotjEi/O?=
 =?us-ascii?Q?18JR+YVZ4OK1oTpgeGlJz0NZ0w3z4Fd2JF2Nlea+NzKTSSlCr3+LXRTXIdnN?=
 =?us-ascii?Q?K3KxRvhKZH7cH0NHgKA+eFg1CI/Pe72ysMNPapB6EPI5Lwnutirb3/yEdqvV?=
 =?us-ascii?Q?QIZMYsRZxZVSmghFZ4FcbQyqdp5rf+KOWz1nEbtntO2naGF/SGm/E3eGZX2B?=
 =?us-ascii?Q?i8An4VFc+lAk9Pa1k4xjMfzPAfmqLeumsw15SXsYZ7n+RgCmv2M8qtR43Dfh?=
 =?us-ascii?Q?GeiK1TQBa++N++assU9czI8oTc1XT6cxnNiX0oKnnNs1NIvlVuj4VvEgwMWO?=
 =?us-ascii?Q?5WoLEwOIZ1g5dU4saaIguCu6gN+oAn8aUjIjps8/AcIjqnEoftb3/5x4ic9g?=
 =?us-ascii?Q?MbEmVmjSzgveC2YGboWxBrlPfBl3A/hU4n7QN6mv6QjYZkxxFZq8rIojGFJK?=
 =?us-ascii?Q?Dglo6lynmquysJrnAe1k1S77hYwwdYVpDOc1cEEVjJ2FRmgQn9gm3Q3RzwPx?=
 =?us-ascii?Q?chAQFGuHYl/Tol9J3i3NcLVwjpp7QvuFD1dT5Yw3sO27VMTW1n/8nkXnBt7f?=
 =?us-ascii?Q?lTl44AttwzCDy48z4nFfsqAsfDPU+aSvvYj/3oi5eSo4d1mFbZthtn8hqZmx?=
 =?us-ascii?Q?gjJxcLwoLklzJPZq9fvbn2U+0AUTIeb8Ct0y9DClbmbMF85SLxvX2N7XR1Em?=
 =?us-ascii?Q?UdTbSv7p4oOUoT2eo3qrXlgXVBET6lrmMpwBQp2LcPspB4dkZXgNYwsrNkbj?=
 =?us-ascii?Q?DgWV7XeDmVo7n1JecDuBlhStwW0gY2cfcvfKTUJE7CbPmQLn3+hx4xPn09xL?=
 =?us-ascii?Q?SL8kTBEQ2AtUjVu/hxr10FYFlE3jJD6aUMJsEtaa8dMzy0FGrl8t6khuMszK?=
 =?us-ascii?Q?4l+L8wj4OhPCoL6d9kMNCvWcItrNY3o3Q2tttoCUrmenrOFNgk+iV/5eh1q6?=
 =?us-ascii?Q?1x/y9a+85znVaWivmSSIecpWnvxUt9qXpnBchamjsp/mMU48hgbScS+v26Rf?=
 =?us-ascii?Q?3C/6hVpRIdlWsi0v5xKpt7b5CgOU+eznzn3ovs53yHbE8AGLnoJv6y+5o08Z?=
 =?us-ascii?Q?tS1OMS44cbFGjo6euhdnXaezKhdrlGcYxnFLx8u7anS3yJqY1cPmMidGfeBc?=
 =?us-ascii?Q?Km+r3y8JgdypSwq2GO+5qO6Oa84vRbNjnx6O35l0XBMhQzBJ3X1SXBUW5JED?=
 =?us-ascii?Q?KCzNUz2+1GQjKGbSy6riAFsivKgHgFUmxMCgbQ8ITdCriJR+aFhRUCdIGvO+?=
 =?us-ascii?Q?9hlAZef4A6S4iXT6d/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJOAZ+SGeCstMBYym2+Tat4oHOt2bOmNsG2U7Ze7xWZEknOum61t6jPo4Mgw?=
 =?us-ascii?Q?ZV3SxXThO1wQxVt9INWgGlvEAqyI6to9SUxIK/SHS9nAj4Mrkh73pqQ54JDf?=
 =?us-ascii?Q?SoDAwyvTtVQFEHJva/iB2DX06t0PaW6oCE4sNMZGkZzibbNERh/Si8c5ivTr?=
 =?us-ascii?Q?hRehvRte+us1pNg6XgVM9OxrmzovbRraJgVn1veB3kR4TTs8nxkfXTTyNxFq?=
 =?us-ascii?Q?unWUeyCthXX+NTBITJHh5I4r6C8dc6IzmweqYOknfN1FrER69Ss2o8ALmq9/?=
 =?us-ascii?Q?iQHBZpn/WxZJFaMJZ9pxpXw7thSmimfSIv+p/qBrxPzQ09NLunCBhnmJCK7h?=
 =?us-ascii?Q?Tz/NlKrXXu6bT4KYuugS//4XLeJdn04chIkGTIBpHr49eXoDrVlKR+okkNIx?=
 =?us-ascii?Q?Vu8V/0TMI+49qpqUOA2tZNnCkuPX0R+hEfIyq2VXtnLKqtKB8YAU2Xa7xRJ4?=
 =?us-ascii?Q?ypo1tRAoXhtpSNDwaPEf302DT7f1Q7GSaG2TLuUAWuEnzQ5J0Ho1eff+qiji?=
 =?us-ascii?Q?WEiRna6b95ypeZTWOPAxn4dHi1YKFjWQfVw1/zMoLj1sHGXA261rfASPFaUw?=
 =?us-ascii?Q?5dzwHrzf9O12CQHsFyDu3yYr2pYsY8i5maif8I5Oc1vRMoMNL/OJCml8GuRb?=
 =?us-ascii?Q?yJEdT1R6ZMp4v8UfDx54ggWyldjM1VlDmUo+588WpkO9o7zYSs0WurecZdDE?=
 =?us-ascii?Q?kapN4zK2ofA9+QkjaCxe5ZEXWC92CB1YsXYnD9/tZd6lBsc+xCUavsCq6olj?=
 =?us-ascii?Q?AvEkuFQlvEfXpDKLnFiRLMuh6Ig7KuA4nIMXAh4qdTbeceHm3NFO6qq+71yN?=
 =?us-ascii?Q?Li6IdH9CeHIHz4LI51Wek/8KKDNO15qP43W/vl5gjBTUGYGoh5ChN19VVB7m?=
 =?us-ascii?Q?Lak1OIYEX27wa5nYwPW+uNNU7m0wxjwDRR28p79/DcHnvca3E900lUMK/XbL?=
 =?us-ascii?Q?kmVkwM7EgQQAS533zq+gxSIjgF5BPJwdMaHOl7FWNPUe0u1z5ufya7Y0I63o?=
 =?us-ascii?Q?QokScxfUePpYXRI2+KHtfAdQB8tetLFCE4vTDeQFqGw9w1cGw8sPfeStM6G9?=
 =?us-ascii?Q?0+VlRUaNviAUlzgf/KZwdNROdBXsDJnYqTDmsrAeIXIWEhmK/kNOfDmGAAXW?=
 =?us-ascii?Q?4D8Tvqwz/dDUa/GwxScDWaZkn15YzYJXbp4OnsVg0siKx33QjNDuT6pZHMmi?=
 =?us-ascii?Q?jISu41LxRyqTE621Y+C0T7Kw8EooiN/u6GMBxs87ByYWex+B0yMCObKdykX9?=
 =?us-ascii?Q?Gh7P5B2tlmVsHY+jZPcxDdIPJBchKobEU7+AoQaeGnGIc5I9POHi/P3cAjeu?=
 =?us-ascii?Q?CzRjpHUd2Mz+l9MywKiC2YALK/zGSYaqE2Ln8h/kEaqU+YZfT2MtfLEUrwfl?=
 =?us-ascii?Q?e5Fqs4ci6kdvw0IcRgIqv4BEC9b9GnAwx4FBtM6fU5kBa4Uoomaa1/oHJsTw?=
 =?us-ascii?Q?uuv9ZP/A4Kaek/ZOT+9JNOtvufg1aOcv3jLD3WrVBgIhJ+TNRFgExGZUJAuH?=
 =?us-ascii?Q?H+1yQiRfJr6bnP2GdrB0uTx0QLlmpZm8iDZzxmxR0sa8Bw1GJjvNt3JQTMJc?=
 =?us-ascii?Q?+szRPW/1leseAQrirLmj9wbVBqkYOrXAFSVaE0IzkysQ4XfF4N9tMIX/MoMD?=
 =?us-ascii?Q?kuUDa+EhCVijDrK5APdVfXyR9NP4xKWITpejQKCI+zNLbZ/Zrg4oEQNPk04g?=
 =?us-ascii?Q?4I6NIfqAZIOn057ALTu4Lawp8SANqI2UreUn6Ea7qJ0uwTrUQko7qNuT2td5?=
 =?us-ascii?Q?CvzSh7r975VMf0r0XuwNSjPQ7a5IS7s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c54fcb7-5ff9-46be-10bd-08de6f693904
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 03:44:45.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erhFL8vcmVgAFPPchX31MJGJsrLJ5d2wt7L7k+03GyR9B1VUQOVBwYPewfehTKELHSYPDjDzRflxokLXmlgg/60TLFWaDQcnmlpwJ1wRI+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6983
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-77662-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,aschofie-mobl2.lan:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,amd.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5683415BE92
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:44:55AM +0000, Smita Koralahalli wrote:
> __cxl_decoder_detach() currently resets decoder programming whenever a
> region is detached if cxl_config_state is beyond CXL_CONFIG_ACTIVE. For

Not sure 'detached' is the right word. Unregistered maybe?

> autodiscovered regions, this can incorrectly tear down decoder state
> that may be relied upon by other consumers or by subsequent ownership
> decisions.
> 
> Skip cxl_region_decode_reset() during detach when CXL_REGION_F_AUTO is
> set.

I get how this is needed in the failover to DAX case, yet I'm not clear
how it fits in with folks that just want to destroy that auto region
and resuse the pieces.

Your other recent patch cxl/hdm: Avoid DVSEC fallback after region teardown[1],
showed me that the memdevs, when left with the endpoint decoders not reset,
will keep trying to create another region when reprobed.

[1] https://lore.kernel.org/linux-cxl/aY6pTk63ivjkanlR@aschofie-mobl2.lan/

I think the patch does what it says it does. Perhaps expand on why that 
is always the right thing to do.

--Alison


> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..45ee598daf95 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2178,7 +2178,9 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
>  		cxled->part = -1;
>  
>  	if (p->state > CXL_CONFIG_ACTIVE) {
> -		cxl_region_decode_reset(cxlr, p->interleave_ways);
> +		if (!test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +			cxl_region_decode_reset(cxlr, p->interleave_ways);
> +
>  		p->state = CXL_CONFIG_ACTIVE;
>  	}
>  
> -- 
> 2.17.1
> 

