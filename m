Return-Path: <linux-fsdevel+bounces-36945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC289EB322
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6551639E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F51AF0D8;
	Tue, 10 Dec 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FM0YEblb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816D1AC450;
	Tue, 10 Dec 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840745; cv=fail; b=aoCdz2mZTwJez+NY6+5NMLJUzpz2tq53vxBn9ZzA4CY5lFhVLAvslLkGrK7bhC3ZO6pFPptWrzJt5TRvH7peaxMBBs+mxf9Fxu27aKe41pDtkkpU897m3iiPC5NQVRG90b1MzrKJ78pZUhCyTnw9DxRFzyO/ZeiaCwU+QK7NKrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840745; c=relaxed/simple;
	bh=HvPoK+CQ+JQGxE+QlV1bp6JJrYd2S1vWkw19DeUgc60=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=l4hXJbNO2ErUlWcCjG8QyCg7YuERhg2doheBf2KENp7xFbEXPheA3btFl4IgUi19AmDpLda+xxvfm0dz+Ly90Eu0t6K37M3y3cm4nm7A7vzgu+PCkdAMfF2GKivW12+FFGSUQssDGlkbemEUuc/Ic4rNSqpkuy2EhB8jDyXkxbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FM0YEblb; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733840741; x=1765376741;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=HvPoK+CQ+JQGxE+QlV1bp6JJrYd2S1vWkw19DeUgc60=;
  b=FM0YEblbsY+6rHLKgoQNCV+zFFP3v3JIBR167YoIezjU3vllYwMl7Aa8
   o9txy9G5TqMx1Znr5HWFX4pefQYcol8VhB3xdVNWTmHNuCzHWTY0NFM4L
   bIRgOZWcRrUtZm+tnxRidW9xro4il9KVn21LfcWnpYqCgYbnafPwg1yIY
   DAcRWwhJcQiEp5qpaSjUWglCJNsIgQrrz/Dj+LGYdtgyuprjpuLMYPm7R
   ttzM04dIbMbyZaGNRfgWmiNa1L6PN1igNUGxfqYVdMUbgBdejt+diW/xQ
   inH5agcojF4dO9w164wifOFyB6o7wxrenccxUW/L0Meu+fNIons9mXjkV
   w==;
X-CSE-ConnectionGUID: FNeoiow4TKG2wdpCiSNayw==
X-CSE-MsgGUID: kxOSj9KwQia9G0VtRlX6eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34432493"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="34432493"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:25:39 -0800
X-CSE-ConnectionGUID: FWo0425PTzCIamFR6x38Sw==
X-CSE-MsgGUID: 0QG3pToFTXacWo1H6aQGyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95767445"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 06:25:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 06:25:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 06:25:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 06:25:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVtrgndF+zfRbHuES5pJjN4tURXHpLwh+4NStR074+5UR9OPMOeOP8HbEbgUtrchhcItJUmuqbvA5pWmUiPSG3Zttb5XRHqlKjJopj2QZFntqYNG//5YqqGv0mpcb7dCsolrvcCl0yQ3QK4fxdNkMDAbG2bWkcZO1NsYQ1wdB6jqIO/3i0ils28/aUxdKRxjyFZTis1h4KhUA9wopJfEGU7bbpNVNxM/1doKcY8FuIRKhTVDeWT9DIsEdVBK14O1hDzWgUU+y786gWg74zf09SETRBHahdOXpxFxTkg3On7hkGPQ0jeJAuJ7VujMdZ4mmXNqSl2LxaYrdvkePg4Z0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovEiFdj6PPBtxpQvYDFyo77BFhNtiwoKCPXf/xNwB4U=;
 b=SqGfGoPeBHB9ZgiUujvVCw2HdWWakOdpiQCMaUSn4kGwtvuaqFQWyfG4McL+HmhZdIscjh5B4tho9CndO2p9TzLYQWoBX96uZgfXCX9uCM35GgU3CKz5c0YXlOu95IM9fQxMOkYIWbbVINc7aga1aa5AFE+/GJy2qOq9M+GabjFgT3nKdZ8HdrtJ2j6C0NBFEGpTyYbXBPGxnMY4uTxhnvlsu2j4+rNEmm8st56QK7t4zUPKMLgemDDrIDetLmfqwPEknxX3amXvtlmBUH2i+JbcRoeSIsdjB0GoZF4n2YKwCiG0y6KJC/3imVwTG3SYX3z4Y/p3Wt5ASO1h/afLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7063.namprd11.prod.outlook.com (2603:10b6:806:2b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 14:25:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 14:25:31 +0000
Date: Tue, 10 Dec 2024 22:25:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Brian Foster <bfoster@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
	<djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [iomap]  fde4c4c3ec:  stress-ng.metamix.ops_per_sec
 5880.5% improvement
Message-ID: <202412102259.32d49080-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb152d2-2118-40ea-fd2f-08dd19268017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Baieu6kHng3M1sm4g3OZquTR7WdtXEJ4NCG6OJN1LoJWB+UeLMeQO88Qs4?=
 =?iso-8859-1?Q?6xMkvL7qDFOY++czzMtpqs1tPLtJ2ue65x9TSGLWLK7NbJTikiVIMmU78T?=
 =?iso-8859-1?Q?S5u0gFe5f/qcXHzPXZ6K0LRn4T7pLtck9QiuNIsY6Dg5xu3uQqpNl90N/0?=
 =?iso-8859-1?Q?Xi4cMHI6Nnxm9uG7rlevyiWo8FFCC6/gORvFqfftQAMuvMberr3J6WPpiN?=
 =?iso-8859-1?Q?5JD9spt+RhuYa3bCheOAkZlrrAUCxSopgiHs/qwaN63XQc98vURUmavQQP?=
 =?iso-8859-1?Q?VSHC39AgDw2k5zNOsQbIbtU21vTCkYiSynOn3jJqG+pZnG0b2ChQ9vpZuU?=
 =?iso-8859-1?Q?TnFNhLhJXuUtughj3LvM6wR2Se+X+2KZJwMj6ttekgmvvwFFXh8xk5QoUj?=
 =?iso-8859-1?Q?IGiavjlGJRVm7TTz+SaglNcNSrCFbuQf3cshhvdI9oJXc7mZsyGzBP5Q4S?=
 =?iso-8859-1?Q?LlelL0Yb3AOCfDCKM12gFpX5pfOWR0SxzH8g5p774mwOaMoMiBzM7D/zPz?=
 =?iso-8859-1?Q?Qg4qOIuaDeoPV77km5MB68gj/aDGLAprYWNAQ8gEuOIyTWIgINqIVeuleg?=
 =?iso-8859-1?Q?56+VztLErmKXThjM+E/UV4yqLHci7TaDmsfCOeG07BPj372+zABxzXR9MI?=
 =?iso-8859-1?Q?yW2seWmc3GQ/MlugpE3oi2va1OxiNUSS17RTO4J7Y6ZJ+sma8rQOiA7ubW?=
 =?iso-8859-1?Q?kdo4pRDxZu5jGoekSB2kcFih6k7kMWfZXteerZnxynBhBqp7D63zXhZjOa?=
 =?iso-8859-1?Q?hSWM2swxOEWjhEr2A/uVHOcElFoAAGmsQBMXDdTisTDoyc21gPMD18AEbP?=
 =?iso-8859-1?Q?d7lKCNhdsR+gPU+IzEOURm3D7r/w0f29+Jou8E69C7ukSvfSzqUD4jdqX0?=
 =?iso-8859-1?Q?Wybu2W+LkPqq5uys0oC3FndIxeRcVhtqsRVFdoRCmwLdjp91v7yaGypI+g?=
 =?iso-8859-1?Q?hUTrd2tlJqCX9KTzwrQTLea8nKsphjgvmSyTS/aHrVUVZqCfd5YqE2WJNf?=
 =?iso-8859-1?Q?3A3IlsNVpu9E+PA2SXxKssn6tsnIkLQqR8dijZCW9gkxtwCmP0FelD1Txq?=
 =?iso-8859-1?Q?VQqDxd5l7N+/fK4LCR6gokpGzJud9Od6OE7Wm5s0oVfDov3jCwSuNi/yQC?=
 =?iso-8859-1?Q?HFLaoq10BwpC3WPI9ZNsUmHUSJEnWjJMgzzM4DMTdJeoGvGkDQPLyxAnGj?=
 =?iso-8859-1?Q?voFvFjw3zbRWr21uCdcc/k/eLHEG7RCMLw/XhgBvs8m5ucPvUySmjooUWN?=
 =?iso-8859-1?Q?KfJlJ4ALOCZHNVVh4WiO346n9ypy8yJWwyG2xWHv+eix0KbCc9s+yGirsH?=
 =?iso-8859-1?Q?NPv2oiVT0Awd1qU3qc6oTZan4cpSItHBdtUzjr1ffAwPV5QB5mrn5Y9ztq?=
 =?iso-8859-1?Q?i06K75mnzFZ0e75kBLVs8Qq/PvctqbiiV5Lr3R6r3NKpJYJEGYSmE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5gzMecyDG0JkO9hqnIulNqBk40QjFyEE3JtapjP2Wv2QbjHBcI3Sdm4OCE?=
 =?iso-8859-1?Q?HwH36Ek+1Tm/Qxs/Mvbp1xG6V6Iof9qZrVAC3UQq2LoQU1DL1uRDOF5Llc?=
 =?iso-8859-1?Q?wYS66aYgzkVmlPBvtCIiULvFfhh/wBQ6gY/cIoaAL+WhnRrc9YPrfn25Xi?=
 =?iso-8859-1?Q?oufxNyzjvP7g5y0aCNiLaSl/2DQ1trohy+b01gY2/lUYM9D2HrUwnUl5qs?=
 =?iso-8859-1?Q?IxDTbi5EFuc19KTHYn0vVE3vUkw5PjZ37QhH2cRRVdlKJP+6wg6q8YJF58?=
 =?iso-8859-1?Q?VZX2nbxfCfwdK2s9Iyf71+YN7Gn3HhBrxRisTeBoqcThlGZ0fqgeJfcw36?=
 =?iso-8859-1?Q?5wdol8mEeiGsJpvWK6wJSX+cZRlwdWjlWDO13Jw9Xk+wHu6lI9iSXqsY39?=
 =?iso-8859-1?Q?DBt08bLCOwhojVS5dWJzPXt0aWZHcyazpQBx8cWgAeRW9cqFK+LPVJrwYA?=
 =?iso-8859-1?Q?ER2EnDOahTCPgjqb2GrUuN5e4Km7xFECRz7tELKoj1DYSMKkAkyxrJPOov?=
 =?iso-8859-1?Q?8lU5VudeLUjWwDIJ1SM3wiahrCV2h1pCdtp2KkYcEV8ihEza/dQYP72dg0?=
 =?iso-8859-1?Q?8UcUZ8fXRLkRqcfjjDw9/o05TP61sVAm+8Ip4nJh4Cdugt36ja0gvB8uW8?=
 =?iso-8859-1?Q?v3dy49KvGxihX1V51zMDbY/AdwXv+HuY94RNHLGugzFFSdXf//91GcC+tZ?=
 =?iso-8859-1?Q?HAdEF5Wpx7FUI1cznjBA3jiaxULJopQiOdji9qWNnv6fFHOzcjAT/Si1EA?=
 =?iso-8859-1?Q?wIKCqH8AVAQ/Z4ClX/5qCcod2TvzSTzKlyNawq0QwO4+AJF8UvieAC8TFp?=
 =?iso-8859-1?Q?mJ6nP1EUZZoHWODCfqfaP79HU0qLrdMFq1YJ2afsuAEzBGvg0sG21HE4Bk?=
 =?iso-8859-1?Q?I3ZDzXXAmsY40VueE4DPprH+aaFCtvUb5UWn6tnJRCPFtyiiamP3PB2CbY?=
 =?iso-8859-1?Q?Ntt0qEivN59r2HAg14meOew0xPGCb89BYktFWeekLfE/5NosOo7MwGJATX?=
 =?iso-8859-1?Q?xjA9INQiXUbbm/2bfR4vozfN5F/Zv6J9eT2XkHWFHSpL5n74lADZHh4g6J?=
 =?iso-8859-1?Q?lTBBK7ndvMHmehZX519l+7MlUzcF8ty/vgEP229IZAzKlyCRyPYqYmsR8V?=
 =?iso-8859-1?Q?XrgBxgNw2abI77rIHk4xyWcmCdt0FJxmfa3HY3XRrH02LKwQt00vkzz/Hj?=
 =?iso-8859-1?Q?6DI8YS4KxwhufDQzktatL25DYNTGkc7EDP19s33glhMZx5DVzNPi2TV/D4?=
 =?iso-8859-1?Q?kdMUNkntzBLLTRYSK6oiqMvQtZ0MhV8amNbrNRtZPdSBKTAjjZDQqtnTwA?=
 =?iso-8859-1?Q?Riu8XYaFSI5UKxQq8AiJXzwZjpFu4uJmH9SdNcl2XyK00lwi49MwZvAvmo?=
 =?iso-8859-1?Q?5bAyV+NXWrzgyvZPD3w2jI+dDKeulduJSlBhi4ZXUaCjWl81ITmA/XE9qu?=
 =?iso-8859-1?Q?zgeNObYe7sb2/nTszNeRAeVPfzRHEPh7zEQuUm03q0joNYtuRMzw9LVi+y?=
 =?iso-8859-1?Q?eVkAYq6sAlgdV2ogrMRuTC5TIBE+uTUNZrMikzdFcqJBpyp40RIO76njkY?=
 =?iso-8859-1?Q?WDIJLGqwzb9j3/qjcjhkxwRlOF5f+gkWORFnadiLgE9pbkGXVE/1wSM65m?=
 =?iso-8859-1?Q?T7w2D0o2HlivWuVzJKs6Q6+YHfscFecwXIvoNvCEwU1Jzr9xjeDLCDTw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb152d2-2118-40ea-fd2f-08dd19268017
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:25:31.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIN3afzZHu+wLszYb3l7vhWUa8T0Xvw7pc00/Jqoaed5hWMc6o159Je0yyfxU7NdsWbzCjZ7VIRi1+4lmslt1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 5880.5% improvement of stress-ng.metamix.ops_per_sec on:


commit: fde4c4c3ec1c1590eb09f97f9525fa7dd8df8343 ("iomap: elide flush from partial eof zero range")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: xfs
	test: metamix
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241210/202412102259.32d49080-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/xfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/metamix/stress-ng/60s

commit: 
  889ac75787 ("iomap: lift zeroed mapping handling into iomap_zero_range()")
  fde4c4c3ec ("iomap: elide flush from partial eof zero range")

889ac75787cbeb12 fde4c4c3ec1c1590eb09f97f952 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 9.478e+10 ±  2%     -94.0%  5.717e+09 ±  6%  cpuidle..time
   4144232           -88.7%     466301 ±  6%  cpuidle..usage
      1.71 ±  5%    +147.7%       4.23 ± 12%  iostat.cpu.idle
     98.20            -3.2%      95.05        iostat.cpu.iowait
      1525 ±  2%     -91.3%     132.47 ±  4%  uptime.boot
      4063 ±  2%     -34.6%       2659 ±  2%  uptime.idle
   1573533 ± 14%     -61.6%     604344 ±  9%  numa-numastat.node0.local_node
   1598552 ± 13%     -60.0%     638941 ±  9%  numa-numastat.node0.numa_hit
   1661175 ± 15%     -62.3%     626030 ± 16%  numa-numastat.node1.local_node
   1702782 ± 14%     -61.4%     658074 ± 13%  numa-numastat.node1.numa_hit
      7.83 ± 48%    +689.4%      61.83 ±123%  perf-c2c.DRAM.local
     27.83 ± 31%    +275.4%     104.50 ± 67%  perf-c2c.DRAM.remote
     43.67 ± 14%    +124.0%      97.83 ± 48%  perf-c2c.HITM.local
     14.50 ± 33%    +242.5%      49.67 ± 46%  perf-c2c.HITM.remote
      0.00 ±114%    +285.2%       0.02 ± 57%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.37 ± 18%     -57.8%       0.58 ± 25%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 29%    +190.6%       0.02 ± 36%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.00 ±114%  +63970.4%       2.88 ±222%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2079         +1633.1%      36047 ± 16%  vmstat.io.bo
      1.07           +55.6%       1.67 ±  5%  vmstat.procs.r
      2735           +86.3%       5097 ± 10%  vmstat.system.cs
      2958          +110.7%       6234 ±  9%  vmstat.system.in
      1.58 ±  5%      +0.7        2.29 ± 12%  mpstat.cpu.all.idle%
      0.01            +0.0        0.02 ± 13%  mpstat.cpu.all.irq%
      0.05            +0.2        0.22 ±  8%  mpstat.cpu.all.sys%
      0.03 ±  2%      +0.4        0.45 ±  7%  mpstat.cpu.all.usr%
      5.32           +22.4%       6.52        mpstat.max_utilization_pct
    616493 ± 12%     -66.1%     209094 ±  2%  meminfo.AnonHugePages
    516254           -26.0%     381860 ±  5%  meminfo.Dirty
    544746           +67.2%     910918        meminfo.Inactive
    544746           +67.2%     910918        meminfo.Inactive(file)
   6175748           +10.9%    6850934        meminfo.Memused
      1965           -99.4%      11.62        meminfo.Mlocked
    134863 ±  5%     -23.9%     102589 ±  7%  meminfo.Shmem
      6500 ±  2%   +1721.4%     118396 ±  3%  meminfo.Writeback
   6638835           +16.3%    7722525        meminfo.max_used_kB
    627.17 ±  4%    +252.7%       2212 ± 22%  stress-ng.metamix.ops
      0.43 ±  3%   +5880.5%      25.62 ± 23%  stress-ng.metamix.ops_per_sec
      1480 ±  2%     -94.0%      88.24 ±  6%  stress-ng.time.elapsed_time
      1480 ±  2%     -94.0%      88.24 ±  6%  stress-ng.time.elapsed_time.max
      1485 ± 10%     +83.7%       2727 ± 22%  stress-ng.time.involuntary_context_switches
    113287 ±  2%      +6.9%     121085 ±  2%  stress-ng.time.minor_page_faults
      1.00          +533.3%       6.33 ± 14%  stress-ng.time.percent_of_cpu_this_job_got
     17.23 ±  3%     -69.2%       5.31 ± 12%  stress-ng.time.system_time
    811051           -91.6%      67803 ± 13%  stress-ng.time.voluntary_context_switches
    211376 ±  8%    +120.0%     465088 ±  3%  numa-meminfo.node0.Inactive
    211376 ±  8%    +120.0%     465088 ±  3%  numa-meminfo.node0.Inactive(file)
      1407 ± 55%     -99.5%       7.73 ± 70%  numa-meminfo.node0.Mlocked
     46621 ±  4%     -12.1%      40985 ±  7%  numa-meminfo.node0.PageTables
      2315 ±  7%   +2508.5%      60401 ±  3%  numa-meminfo.node0.Writeback
    316162 ±  4%     -41.0%     186519 ±  6%  numa-meminfo.node1.Dirty
    333363 ±  4%     +33.6%     445213 ±  3%  numa-meminfo.node1.Inactive
    333363 ±  4%     +33.6%     445213 ±  3%  numa-meminfo.node1.Inactive(file)
     13082 ±  6%     +15.4%      15099 ±  4%  numa-meminfo.node1.KernelStack
      4173 ±  6%   +1288.3%      57940 ±  5%  numa-meminfo.node1.Writeback
    289367 ±  8%     +43.5%     415253 ± 14%  numa-vmstat.node0.nr_dirtied
     52848 ±  8%    +120.6%     116571 ±  3%  numa-vmstat.node0.nr_inactive_file
    351.90 ± 55%     -99.4%       1.94 ± 70%  numa-vmstat.node0.nr_mlock
     11656 ±  4%     -11.8%      10275 ±  7%  numa-vmstat.node0.nr_page_table_pages
    579.18 ±  7%   +2509.2%      15111 ±  3%  numa-vmstat.node0.nr_writeback
    283307 ±  8%     +46.6%     415212 ± 14%  numa-vmstat.node0.nr_written
     52848 ±  8%    +120.6%     116571 ±  3%  numa-vmstat.node0.nr_zone_inactive_file
     50616 ±  8%     +26.5%      64045 ±  5%  numa-vmstat.node0.nr_zone_write_pending
   1597869 ± 13%     -60.0%     638678 ±  9%  numa-vmstat.node0.numa_hit
   1572850 ± 14%     -61.6%     604081 ±  9%  numa-vmstat.node0.numa_local
     79046 ±  4%     -40.8%      46826 ±  5%  numa-vmstat.node1.nr_dirty
     83347 ±  4%     +33.9%     111614 ±  3%  numa-vmstat.node1.nr_inactive_file
     13083 ±  6%     +15.6%      15126 ±  5%  numa-vmstat.node1.nr_kernel_stack
      1042 ±  6%   +1290.3%      14487 ±  4%  numa-vmstat.node1.nr_writeback
     83347 ±  4%     +33.9%     111614 ±  3%  numa-vmstat.node1.nr_zone_inactive_file
     80088 ±  4%     -23.4%      61313 ±  5%  numa-vmstat.node1.nr_zone_write_pending
   1701834 ± 14%     -61.4%     657542 ± 13%  numa-vmstat.node1.numa_hit
   1660226 ± 15%     -62.3%     625498 ± 16%  numa-vmstat.node1.numa_local
    247667            -3.2%     239788        proc-vmstat.nr_active_anon
    301.02 ± 12%     -66.1%     102.18 ±  2%  proc-vmstat.nr_anon_transparent_hugepages
    129061           -25.9%      95586 ±  5%  proc-vmstat.nr_dirty
   1067954            +7.8%    1151656        proc-vmstat.nr_file_pages
    136175           +67.4%     227901        proc-vmstat.nr_inactive_file
     27521            +6.4%      29281        proc-vmstat.nr_kernel_stack
     36947            +2.0%      37678        proc-vmstat.nr_mapped
    491.30           -99.4%       2.91        proc-vmstat.nr_mlock
     33718 ±  5%     -23.8%      25684 ±  7%  proc-vmstat.nr_shmem
      1624 ±  2%   +1722.4%      29604 ±  3%  proc-vmstat.nr_writeback
    247667            -3.2%     239788        proc-vmstat.nr_zone_active_anon
    136175           +67.4%     227901        proc-vmstat.nr_zone_inactive_file
   3302447           -60.7%    1298849 ±  9%  proc-vmstat.numa_hit
   3235821           -61.9%    1232008 ± 10%  proc-vmstat.numa_local
   3567173 ±  2%     -61.0%    1392877 ±  9%  proc-vmstat.pgalloc_normal
   3774685 ±  2%     -87.9%     456142 ±  2%  proc-vmstat.pgfault
   3531767 ±  2%     -61.1%    1372674 ±  7%  proc-vmstat.pgfree
    162219 ±  2%     -89.7%      16683 ±  3%  proc-vmstat.pgreuse
      1.56 ±  2%     +13.7%       1.78 ±  3%  perf-stat.i.MPKI
  46956495          +796.6%   4.21e+08 ±  7%  perf-stat.i.branch-instructions
      1.73            +0.7        2.47 ±  2%  perf-stat.i.branch-miss-rate%
   1484042 ±  2%   +1223.2%   19636151 ±  7%  perf-stat.i.branch-misses
      9.71            +7.4       17.11 ±  3%  perf-stat.i.cache-miss-rate%
    259439          +476.3%    1495153 ±  9%  perf-stat.i.cache-misses
   2249121          +256.4%    8016471 ±  7%  perf-stat.i.cache-references
      2724           +85.3%       5048 ± 10%  perf-stat.i.context-switches
      1.52           -16.8%       1.26        perf-stat.i.cpi
 2.809e+08          +534.3%  1.782e+09 ±  7%  perf-stat.i.cpu-cycles
     78.92          +163.5%     207.96 ±  7%  perf-stat.i.cpu-migrations
      1034           +16.7%       1207 ±  9%  perf-stat.i.cycles-between-cache-misses
 2.274e+08          +805.1%  2.058e+09 ±  7%  perf-stat.i.instructions
      0.68           +31.8%       0.90        perf-stat.i.ipc
      0.02 ± 62%   +3922.2%       0.87 ± 32%  perf-stat.i.major-faults
      2425           +55.8%       3777 ±  3%  perf-stat.i.minor-faults
      2425           +55.8%       3778 ±  3%  perf-stat.i.page-faults
      1.14           -36.5%       0.72 ±  3%  perf-stat.overall.MPKI
      3.16            +1.5        4.66        perf-stat.overall.branch-miss-rate%
     11.53            +7.0       18.57 ±  2%  perf-stat.overall.cache-miss-rate%
      1.24           -29.6%       0.87        perf-stat.overall.cpi
      1086           +10.9%       1204 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.81           +42.1%       1.15        perf-stat.overall.ipc
  47014242          +786.0%  4.166e+08 ±  7%  perf-stat.ps.branch-instructions
   1485967 ±  2%   +1206.7%   19416732 ±  7%  perf-stat.ps.branch-misses
    259571          +468.6%    1475883 ±  9%  perf-stat.ps.cache-misses
   2250491          +252.9%    7942059 ±  8%  perf-stat.ps.cache-references
      2725           +83.1%       4989 ±  9%  perf-stat.ps.context-switches
     63956            -1.1%      63278        perf-stat.ps.cpu-clock
 2.819e+08          +529.4%  1.774e+09 ±  7%  perf-stat.ps.cpu-cycles
     78.91          +159.7%     204.91 ±  7%  perf-stat.ps.cpu-migrations
 2.277e+08          +794.6%  2.037e+09 ±  7%  perf-stat.ps.instructions
      0.02 ± 62%   +3858.3%       0.86 ± 32%  perf-stat.ps.major-faults
      2423           +53.8%       3726 ±  3%  perf-stat.ps.minor-faults
      2423           +53.8%       3727 ±  3%  perf-stat.ps.page-faults
     63956            -1.1%      63278        perf-stat.ps.task-clock
 3.374e+11 ±  2%     -46.4%  1.807e+11 ±  4%  perf-stat.total.instructions
   7386822 ± 11%     -62.4%    2774018 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.avg
  75203309 ± 72%     -44.2%   41968207 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.max
    508406 ± 45%     -93.5%      32883 ± 36%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.04 ±  5%    +229.5%       0.14 ± 11%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.20 ±  4%     +61.1%       0.32 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
     45.84 ± 60%    +782.5%     404.49 ± 58%  sched_debug.cfs_rq:/.load_avg.avg
      1120 ± 96%    +845.0%      10592 ±140%  sched_debug.cfs_rq:/.load_avg.max
    166.87 ± 78%    +774.0%       1458 ±121%  sched_debug.cfs_rq:/.load_avg.stddev
   7386822 ± 11%     -62.4%    2774018 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
  75203309 ± 72%     -44.2%   41968207 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
    508406 ± 45%     -93.5%      32883 ± 36%  sched_debug.cfs_rq:/.min_vruntime.min
      0.04 ±  5%    +229.5%       0.14 ± 11%  sched_debug.cfs_rq:/.nr_running.avg
      0.20 ±  4%     +61.1%       0.32 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
      6.78 ± 17%    +837.8%      63.54 ± 26%  sched_debug.cfs_rq:/.removed.load_avg.avg
    144.87 ± 35%    +253.4%     512.00        sched_debug.cfs_rq:/.removed.load_avg.max
     26.46 ± 25%    +520.6%     164.23 ± 11%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      2.36 ± 21%    +709.0%      19.07 ± 29%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     72.55 ± 35%    +254.1%     256.92        sched_debug.cfs_rq:/.removed.runnable_avg.max
     11.00 ± 32%    +412.2%      56.34 ± 15%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      2.36 ± 21%    +708.7%      19.07 ± 29%  sched_debug.cfs_rq:/.removed.util_avg.avg
     72.55 ± 35%    +254.1%     256.92        sched_debug.cfs_rq:/.removed.util_avg.max
     11.00 ± 32%    +412.0%      56.31 ± 15%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     36.95 ±  3%    +553.0%     241.30 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
    602.24           +55.6%     937.33 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
     99.40 ±  2%    +112.4%     211.09 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
     36.61 ±  3%    +555.0%     239.79 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    592.79           +58.0%     936.83 ±  5%  sched_debug.cfs_rq:/.util_avg.max
     98.40 ±  2%    +114.3%     210.92 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
      2.74 ± 20%    +572.4%      18.39 ± 19%  sched_debug.cfs_rq:/.util_est.avg
    112.05 ± 16%    +185.4%     319.83 ±  2%  sched_debug.cfs_rq:/.util_est.max
     16.09 ± 16%    +328.3%      68.93 ±  8%  sched_debug.cfs_rq:/.util_est.stddev
    950939           -13.1%     826336        sched_debug.cpu.avg_idle.avg
    115409 ± 13%     +65.1%     190592 ±  7%  sched_debug.cpu.avg_idle.stddev
    754276 ±  2%     -90.2%      73634        sched_debug.cpu.clock.avg
    754281 ±  2%     -90.2%      73638        sched_debug.cpu.clock.max
    754269 ±  2%     -90.2%      73629        sched_debug.cpu.clock.min
      2.80 ±  3%     -20.9%       2.21 ± 11%  sched_debug.cpu.clock.stddev
    753931 ±  2%     -90.3%      73366        sched_debug.cpu.clock_task.avg
    754241 ±  2%     -90.2%      73624        sched_debug.cpu.clock_task.max
    745591 ±  3%     -91.2%      65301        sched_debug.cpu.clock_task.min
    387.66           -15.9%     325.96 ±  9%  sched_debug.cpu.curr->pid.avg
     21331 ±  2%     -81.7%       3912        sched_debug.cpu.curr->pid.max
      2707 ±  2%     -68.7%     848.78 ±  5%  sched_debug.cpu.curr->pid.stddev
      0.04 ± 12%    +260.2%       0.14 ± 12%  sched_debug.cpu.nr_running.avg
      0.18 ±  8%     +65.8%       0.30 ±  9%  sched_debug.cpu.nr_running.stddev
     33552 ±  2%     -87.0%       4377 ±  6%  sched_debug.cpu.nr_switches.avg
    167965 ± 10%     -88.0%      20145 ± 11%  sched_debug.cpu.nr_switches.max
     13815 ±  4%     -89.4%       1463 ± 14%  sched_debug.cpu.nr_switches.min
     21329 ±  9%     -83.1%       3601 ± 14%  sched_debug.cpu.nr_switches.stddev
     13.07           -38.2%       8.07        sched_debug.cpu.nr_uninterruptible.avg
     12.93 ±  5%     -18.2%      10.58 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
    754273 ±  2%     -90.2%      73631        sched_debug.cpu_clk
    753119 ±  2%     -90.4%      72476        sched_debug.ktime
    754998 ±  2%     -90.1%      74397        sched_debug.sched_clk
     43.96 ±  3%      -8.3       35.61 ± 21%  perf-profile.calltrace.cycles-pp.common_startup_64
      8.23 ± 12%      -8.2        0.00        perf-profile.calltrace.cycles-pp.filemap_write_and_wait_range.iomap_zero_range.xfs_file_write_checks.xfs_file_buffered_write.vfs_write
     41.84 ±  3%      -7.9       33.98 ± 20%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     41.86 ±  3%      -7.9       33.99 ± 20%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     41.78 ±  3%      -7.8       33.96 ± 20%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     37.94 ±  3%      -7.5       30.46 ± 20%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     38.58 ±  3%      -7.2       31.43 ± 20%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      7.14 ± 11%      -7.1        0.00        perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.filemap_write_and_wait_range.iomap_zero_range.xfs_file_write_checks.xfs_file_buffered_write
      7.14 ± 11%      -7.1        0.00        perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.filemap_write_and_wait_range.iomap_zero_range.xfs_file_write_checks
      7.08 ± 12%      -7.1        0.00        perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.filemap_write_and_wait_range.iomap_zero_range
      7.06 ± 12%      -7.1        0.00        perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.filemap_write_and_wait_range
     36.03 ±  3%      -7.0       29.00 ± 20%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     19.92 ± 10%      -6.9       13.06 ± 21%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
     10.11 ± 10%      -6.3        3.86 ± 44%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.08 ± 10%      -6.2        3.85 ± 43%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.01 ±  5%      -5.4       18.58 ± 17%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     23.97 ±  5%      -5.4       18.56 ± 17%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      6.86 ± 12%      -5.3        1.58 ± 63%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages.do_writepages
      6.87 ± 12%      -5.3        1.60 ± 63%  perf-profile.calltrace.cycles-pp.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      6.84 ± 11%      -5.3        1.58 ± 63%  perf-profile.calltrace.cycles-pp.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages
      5.80 ± 13%      -4.9        0.94 ± 82%  perf-profile.calltrace.cycles-pp.__blk_flush_plug.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepages
      8.53 ± 11%      -4.6        3.97 ± 66%  perf-profile.calltrace.cycles-pp.iomap_zero_range.xfs_file_write_checks.xfs_file_buffered_write.vfs_write.ksys_write
      5.58 ±  8%      -3.3        2.26 ± 42%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.58 ±  8%      -3.3        2.26 ± 42%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      5.58 ±  8%      -3.3        2.26 ± 42%  perf-profile.calltrace.cycles-pp.execve
      5.57 ±  7%      -3.3        2.25 ± 42%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.51 ±  8%      -3.3        2.25 ± 42%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      4.16 ± 14%      -2.5        1.62 ± 43%  perf-profile.calltrace.cycles-pp.read
      4.85 ±  9%      -2.4        2.43 ± 34%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      3.95 ± 15%      -2.4        1.55 ± 44%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.94 ± 15%      -2.4        1.55 ± 44%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      7.11 ± 11%      -2.4        4.74 ± 20%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      3.74 ± 14%      -2.3        1.48 ± 43%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.82 ± 10%      -2.3        1.56 ± 40%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.38 ± 10%      -2.2        1.18 ± 60%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.31 ± 11%      -2.1        1.16 ± 59%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      3.31 ± 11%      -2.1        1.17 ± 59%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.31 ± 11%      -2.1        1.17 ± 59%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.22 ± 11%      -2.1        2.10 ± 31%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      4.19 ± 12%      -2.1        2.10 ± 32%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.56 ±  7%      -2.1        1.49 ± 41%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      3.56 ±  7%      -2.1        1.49 ± 41%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      3.47 ± 10%      -2.0        1.46 ± 42%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      2.71 ± 10%      -2.0        0.74 ± 55%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.53 ± 10%      -1.9        0.62 ± 76%  perf-profile.calltrace.cycles-pp.__mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      3.66 ± 12%      -1.8        1.84 ± 29%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.47 ± 12%      -1.8        0.68 ± 71%  perf-profile.calltrace.cycles-pp.setlocale
      2.95 ± 14%      -1.7        1.20 ± 77%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      2.92 ± 14%      -1.7        1.18 ± 77%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests
      3.03 ± 15%      -1.7        1.33 ± 65%  perf-profile.calltrace.cycles-pp.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue
      4.08 ± 13%      -1.7        2.40 ± 35%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list
      3.40 ±  9%      -1.7        1.73 ± 29%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.39 ± 13%      -1.6        0.74 ± 74%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.53 ± 17%      -1.6        0.90 ± 64%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      2.53 ± 17%      -1.6        0.90 ± 64%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      2.80 ± 22%      -1.6        1.18 ± 22%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.53 ± 17%      -1.6        0.91 ± 65%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2.77 ± 22%      -1.6        1.16 ± 24%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.33 ± 13%      -1.6        0.74 ± 74%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.27 ± 23%      -1.4        0.82 ± 57%  perf-profile.calltrace.cycles-pp.cmd_stat.run_builtin.handle_internal_command.main
      2.27 ± 23%      -1.4        0.82 ± 57%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat.run_builtin.handle_internal_command.main
      2.26 ± 23%      -1.4        0.82 ± 58%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat.run_builtin.handle_internal_command
      2.42 ± 22%      -1.4        1.00 ± 39%  perf-profile.calltrace.cycles-pp.handle_internal_command.main
      2.42 ± 22%      -1.4        1.00 ± 39%  perf-profile.calltrace.cycles-pp.main
      2.42 ± 22%      -1.4        1.00 ± 39%  perf-profile.calltrace.cycles-pp.run_builtin.handle_internal_command.main
      2.16 ± 14%      -1.4        0.78 ± 57%  perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      2.12 ± 24%      -1.4        0.76 ± 55%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat.run_builtin
      1.87 ± 13%      -1.3        0.59 ± 76%  perf-profile.calltrace.cycles-pp.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.75 ± 16%      -1.2        0.58 ± 77%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
      3.36 ±  6%      -1.2        2.20 ± 13%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry
      1.80 ± 13%      -1.2        0.65 ± 76%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.79 ± 13%      -1.1        0.65 ± 76%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.18 ±  8%      -1.1        2.12 ± 14%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.50 ± 28%      -1.1        0.45 ± 78%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.26 ± 10%      -0.9        0.34 ±105%  perf-profile.calltrace.cycles-pp.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      1.25 ± 12%      -0.9        0.34 ±105%  perf-profile.calltrace.cycles-pp.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot.khugepaged.kthread.ret_from_fork
      1.25 ± 12%      -0.9        0.34 ±105%  perf-profile.calltrace.cycles-pp.khugepaged_scan_mm_slot.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      1.22 ± 24%      -0.9        0.34 ±100%  perf-profile.calltrace.cycles-pp._Fork
      1.63 ± 19%      -0.9        0.77 ± 80%  perf-profile.calltrace.cycles-pp.dd_insert_requests.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug.__submit_bio
      1.06 ± 28%      -0.8        0.25 ±100%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.06 ± 28%      -0.8        0.25 ±100%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.06 ± 28%      -0.8        0.26 ±100%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.06 ± 28%      -0.8        0.26 ±100%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      1.88 ±  7%      -0.6        1.24 ± 20%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.54 ±  5%      -0.5        1.03 ± 20%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.04 ± 15%      -0.5        0.55 ± 72%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepages
      1.04 ± 13%      -0.3        0.74 ± 18%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.23 ±  9%      -0.3        0.94 ± 12%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.7        0.68 ± 39%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.worker_thread
      0.00            +0.7        0.69 ± 39%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.worker_thread.kthread
      0.10 ±223%      +1.0        1.07 ± 25%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.10 ±223%      +1.0        1.07 ± 25%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.5        1.49 ± 51%  perf-profile.calltrace.cycles-pp.llseek.stress_metamix
      0.00            +1.5        1.50 ± 43%  perf-profile.calltrace.cycles-pp.writeback_iter.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      0.00            +1.9        1.94 ± 53%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      0.00            +2.1        2.07 ± 64%  perf-profile.calltrace.cycles-pp.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.vfs_read.ksys_read
      0.00            +2.1        2.11 ± 76%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_iter.iomap_zero_range.xfs_file_write_checks.xfs_file_buffered_write
      0.00            +2.3        2.32 ± 63%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_read.xfs_file_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00            +2.3        2.35 ± 64%  perf-profile.calltrace.cycles-pp.xfs_file_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.5        2.52 ± 55%  perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.__iomap_write_begin.iomap_write_begin.iomap_write_iter
      0.00            +2.5        2.52 ± 64%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_metamix
      0.00            +2.6        2.55 ± 55%  perf-profile.calltrace.cycles-pp.zero_user_segments.__iomap_write_begin.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write
      0.00            +2.7        2.69 ± 62%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_metamix
      0.00            +2.7        2.70 ± 70%  perf-profile.calltrace.cycles-pp.iomap_iter.iomap_zero_range.xfs_file_write_checks.xfs_file_buffered_write.vfs_write
      0.00            +2.7        2.74 ± 61%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.stress_metamix
      0.00            +2.9        2.92 ± 57%  perf-profile.calltrace.cycles-pp.__iomap_write_begin.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      6.50 ±  5%      +2.9        9.44 ±  6%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +3.0        2.97 ± 95%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink.stress_metamix
      0.00            +3.0        2.97 ± 95%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      6.50 ±  5%      +3.0        9.48 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      6.50 ±  5%      +3.0        9.48 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00            +3.0        2.98 ± 96%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink.stress_metamix
      0.00            +3.0        2.98 ± 96%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink.stress_metamix
      0.00            +3.0        2.99 ± 96%  perf-profile.calltrace.cycles-pp.unlink.stress_metamix
      0.00            +3.2        3.22 ± 58%  perf-profile.calltrace.cycles-pp.read.stress_metamix
      2.98 ± 11%      +3.7        6.66 ± 12%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +4.0        3.97 ± 49%  perf-profile.calltrace.cycles-pp.__blk_flush_plug.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepage_map_blocks
      3.39 ± 10%      +4.4        7.83 ± 11%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +5.0        4.98 ± 55%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      0.00            +5.1        5.11 ± 49%  perf-profile.calltrace.cycles-pp.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepage_map_blocks.iomap_writepage_map
      0.00            +5.1        5.13 ± 49%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepage_map_blocks.iomap_writepage_map.iomap_writepages
      0.00            +5.1        5.14 ± 49%  perf-profile.calltrace.cycles-pp.iomap_submit_ioend.iomap_writepage_map_blocks.iomap_writepage_map.iomap_writepages.xfs_vm_writepages
      0.00            +6.0        6.01 ± 44%  perf-profile.calltrace.cycles-pp.iomap_writepage_map_blocks.iomap_writepage_map.iomap_writepages.xfs_vm_writepages.do_writepages
      0.28 ±100%      +6.0        6.31 ± 55%  perf-profile.calltrace.cycles-pp.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write
      0.48 ± 45%      +6.9        7.35 ± 55%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      0.00            +7.2        7.19 ± 43%  perf-profile.calltrace.cycles-pp.iomap_writepage_map.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      0.00           +10.4       10.36 ± 33%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range
      0.00           +10.4       10.36 ± 33%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync
      0.00           +10.4       10.39 ± 33%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.do_fsync.__x64_sys_fdatasync
      0.00           +10.4       10.39 ± 33%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.do_fsync
      0.00           +10.7       10.68 ± 32%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.xfs_file_fsync.do_fsync.__x64_sys_fdatasync.do_syscall_64
      0.00           +14.8       14.79 ± 17%  perf-profile.calltrace.cycles-pp.xfs_file_fsync.do_fsync.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +14.8       14.80 ± 17%  perf-profile.calltrace.cycles-pp.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync.stress_metamix
      0.00           +14.8       14.80 ± 17%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync
      0.00           +14.9       14.88 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync.stress_metamix
      0.00           +14.9       14.88 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fdatasync.stress_metamix
      0.00           +14.9       14.91 ± 16%  perf-profile.calltrace.cycles-pp.fdatasync.stress_metamix
     10.09 ± 10%     +27.7       37.79 ± 33%  perf-profile.calltrace.cycles-pp.stress_metamix
     43.95 ±  3%      -8.4       35.59 ± 21%  perf-profile.children.cycles-pp.do_idle
     43.96 ±  3%      -8.3       35.61 ± 21%  perf-profile.children.cycles-pp.common_startup_64
     43.96 ±  3%      -8.3       35.61 ± 21%  perf-profile.children.cycles-pp.cpu_startup_entry
      8.23 ± 12%      -8.2        0.00        perf-profile.children.cycles-pp.filemap_write_and_wait_range
     41.86 ±  3%      -7.9       33.99 ± 20%  perf-profile.children.cycles-pp.start_secondary
     40.68 ±  3%      -7.7       33.03 ± 20%  perf-profile.children.cycles-pp.cpuidle_idle_call
     38.05 ±  3%      -7.5       30.56 ± 20%  perf-profile.children.cycles-pp.cpuidle_enter
     37.94 ±  3%      -7.5       30.47 ± 20%  perf-profile.children.cycles-pp.cpuidle_enter_state
     24.03 ±  5%      -5.4       18.59 ± 17%  perf-profile.children.cycles-pp.acpi_idle_enter
     23.97 ±  5%      -5.4       18.54 ± 17%  perf-profile.children.cycles-pp.acpi_safe_halt
     23.97 ±  5%      -5.4       18.56 ± 17%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      8.55 ± 11%      -4.6        3.98 ± 66%  perf-profile.children.cycles-pp.iomap_zero_range
     14.20 ±  9%      -4.5        9.68 ± 18%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      5.61 ±  7%      -3.3        2.28 ± 42%  perf-profile.children.cycles-pp.__x64_sys_execve
      5.58 ±  8%      -3.3        2.26 ± 42%  perf-profile.children.cycles-pp.execve
      5.55 ±  8%      -3.3        2.27 ± 42%  perf-profile.children.cycles-pp.do_execveat_common
      6.86 ±  4%      -3.3        3.58 ± 29%  perf-profile.children.cycles-pp.asm_exc_page_fault
      5.87 ±  5%      -2.7        3.12 ± 28%  perf-profile.children.cycles-pp.exc_page_fault
      5.84 ±  5%      -2.7        3.10 ± 28%  perf-profile.children.cycles-pp.do_user_addr_fault
      5.30 ±  6%      -2.4        2.92 ± 27%  perf-profile.children.cycles-pp.handle_mm_fault
      7.70 ± 11%      -2.3        5.35 ± 16%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.88 ±  9%      -2.3        1.58 ± 40%  perf-profile.children.cycles-pp.bprm_execve
      4.98 ±  7%      -2.2        2.74 ± 27%  perf-profile.children.cycles-pp.__handle_mm_fault
      3.88 ± 11%      -2.2        1.71 ± 25%  perf-profile.children.cycles-pp.do_mmap
      3.40 ± 11%      -2.1        1.27 ± 47%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      3.40 ± 11%      -2.1        1.27 ± 47%  perf-profile.children.cycles-pp.do_group_exit
      3.54 ± 12%      -2.1        1.44 ± 40%  perf-profile.children.cycles-pp.x64_sys_call
      3.38 ± 11%      -2.1        1.27 ± 47%  perf-profile.children.cycles-pp.do_exit
      3.59 ±  8%      -2.1        1.49 ± 41%  perf-profile.children.cycles-pp.search_binary_handler
      3.59 ±  8%      -2.1        1.50 ± 41%  perf-profile.children.cycles-pp.exec_binprm
      3.97 ± 11%      -2.1        1.92 ± 18%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      3.58 ±  9%      -2.0        1.54 ± 30%  perf-profile.children.cycles-pp.__mmap_region
      3.24 ± 16%      -2.0        1.23 ± 47%  perf-profile.children.cycles-pp.__mmput
      3.47 ± 10%      -2.0        1.46 ± 42%  perf-profile.children.cycles-pp.load_elf_binary
      3.23 ± 16%      -2.0        1.23 ± 47%  perf-profile.children.cycles-pp.exit_mmap
      3.76 ± 12%      -1.8        2.00 ± 14%  perf-profile.children.cycles-pp.__x64_sys_openat
      3.72 ± 12%      -1.7        1.99 ± 14%  perf-profile.children.cycles-pp.do_sys_openat2
      3.50 ± 15%      -1.7        1.81 ± 12%  perf-profile.children.cycles-pp.do_filp_open
      3.46 ± 14%      -1.7        1.78 ± 13%  perf-profile.children.cycles-pp.path_openat
      2.47 ± 12%      -1.6        0.83 ± 34%  perf-profile.children.cycles-pp.setlocale
      2.55 ± 16%      -1.6        0.96 ± 55%  perf-profile.children.cycles-pp.exit_mm
      3.02 ±  7%      -1.5        1.48 ± 34%  perf-profile.children.cycles-pp.do_pte_missing
      2.42 ± 10%      -1.5        0.89 ± 38%  perf-profile.children.cycles-pp.link_path_walk
      3.03 ± 15%      -1.5        1.57 ± 48%  perf-profile.children.cycles-pp.dd_dispatch_request
      2.42 ± 22%      -1.4        1.00 ± 39%  perf-profile.children.cycles-pp.handle_internal_command
      2.42 ± 22%      -1.4        1.00 ± 39%  perf-profile.children.cycles-pp.main
      2.42 ± 22%      -1.4        1.00 ± 39%  perf-profile.children.cycles-pp.run_builtin
      2.27 ± 23%      -1.4        0.90 ± 38%  perf-profile.children.cycles-pp.cmd_stat
      2.27 ± 23%      -1.4        0.90 ± 38%  perf-profile.children.cycles-pp.dispatch_events
      2.26 ± 23%      -1.4        0.89 ± 40%  perf-profile.children.cycles-pp.process_interval
      2.24 ± 18%      -1.3        0.93 ± 40%  perf-profile.children.cycles-pp.seq_read_iter
      2.78 ± 11%      -1.3        1.47 ± 14%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      2.62 ±  8%      -1.3        1.33 ± 32%  perf-profile.children.cycles-pp.do_read_fault
      2.12 ± 24%      -1.3        0.84 ± 36%  perf-profile.children.cycles-pp.read_counters
      1.90 ± 20%      -1.2        0.70 ± 33%  perf-profile.children.cycles-pp.sched_setaffinity
      1.76 ± 22%      -1.2        0.57 ± 40%  perf-profile.children.cycles-pp.walk_component
      2.38 ± 10%      -1.2        1.21 ± 37%  perf-profile.children.cycles-pp.filemap_map_pages
      3.73 ±  9%      -1.2        2.57 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      3.54 ± 10%      -1.1        2.48 ± 11%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.62 ± 29%      -1.0        0.59 ± 51%  perf-profile.children.cycles-pp.unmap_vmas
      1.67 ± 23%      -1.0        0.65 ± 43%  perf-profile.children.cycles-pp.kernel_clone
      1.55 ± 33%      -1.0        0.56 ± 51%  perf-profile.children.cycles-pp.unmap_page_range
      1.51 ± 32%      -1.0        0.54 ± 53%  perf-profile.children.cycles-pp.zap_pmd_range
      1.45 ± 31%      -0.9        0.52 ± 54%  perf-profile.children.cycles-pp.zap_pte_range
      1.36 ± 24%      -0.9        0.47 ± 48%  perf-profile.children.cycles-pp.__open64_nocancel
      1.19 ± 35%      -0.9        0.34 ± 34%  perf-profile.children.cycles-pp.__lookup_slow
      1.26 ± 14%      -0.8        0.45 ± 44%  perf-profile.children.cycles-pp.__split_vma
      1.34 ± 23%      -0.8        0.54 ± 44%  perf-profile.children.cycles-pp.copy_process
      1.18 ± 23%      -0.8        0.38 ± 44%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      1.30 ± 19%      -0.8        0.51 ± 41%  perf-profile.children.cycles-pp.elf_load
      1.06 ± 20%      -0.8        0.30 ± 69%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      1.26 ± 10%      -0.8        0.50 ± 43%  perf-profile.children.cycles-pp.khugepaged
      1.10 ± 26%      -0.8        0.35 ± 49%  perf-profile.children.cycles-pp.pipe_read
      1.23 ± 23%      -0.8        0.48 ± 42%  perf-profile.children.cycles-pp._Fork
      1.25 ± 12%      -0.7        0.50 ± 44%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      1.25 ± 12%      -0.7        0.50 ± 44%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      1.22 ± 13%      -0.7        0.48 ± 44%  perf-profile.children.cycles-pp.collapse_huge_page
      0.92 ± 23%      -0.7        0.21 ± 84%  perf-profile.children.cycles-pp.folio_wait_writeback
      1.55 ± 25%      -0.7        0.83 ± 30%  perf-profile.children.cycles-pp.kmem_cache_free
      0.92 ± 23%      -0.7        0.21 ± 79%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.99 ± 20%      -0.7        0.30 ± 53%  perf-profile.children.cycles-pp.mas_store_prealloc
      1.15 ± 16%      -0.7        0.46 ± 38%  perf-profile.children.cycles-pp.perf_event_mmap
      1.06 ± 32%      -0.7        0.37 ± 44%  perf-profile.children.cycles-pp.begin_new_exec
      1.14 ± 16%      -0.7        0.45 ± 39%  perf-profile.children.cycles-pp.perf_event_mmap_event
      1.06 ± 28%      -0.7        0.37 ± 39%  perf-profile.children.cycles-pp.__do_sys_clone
      1.07 ± 23%      -0.7        0.40 ± 59%  perf-profile.children.cycles-pp.zap_present_ptes
      1.06 ± 12%      -0.7        0.38 ± 38%  perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      1.07 ± 11%      -0.6        0.42 ± 41%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      0.90 ± 45%      -0.6        0.26 ± 35%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.83 ± 20%      -0.6        0.25 ± 38%  perf-profile.children.cycles-pp.copy_strings
      0.79 ± 39%      -0.6        0.22 ± 24%  perf-profile.children.cycles-pp.d_alloc
      0.89 ± 29%      -0.6        0.32 ± 44%  perf-profile.children.cycles-pp.exec_mmap
      2.08 ±  9%      -0.6        1.52 ± 15%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.16 ± 18%      -0.6        0.60 ± 42%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.79 ± 32%      -0.6        0.24 ± 41%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      1.02 ± 25%      -0.5        0.48 ± 35%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.93 ± 24%      -0.5        0.39 ± 47%  perf-profile.children.cycles-pp.seq_read
      0.86 ±  5%      -0.5        0.32 ± 46%  perf-profile.children.cycles-pp.__i2c_transfer
      0.86 ±  5%      -0.5        0.32 ± 46%  perf-profile.children.cycles-pp.ast_vga_connector_helper_detect_ctx
      0.86 ±  5%      -0.5        0.32 ± 46%  perf-profile.children.cycles-pp.bit_xfer
      0.86 ±  5%      -0.5        0.32 ± 46%  perf-profile.children.cycles-pp.drm_connector_helper_detect_from_ddc
      0.86 ±  5%      -0.5        0.32 ± 46%  perf-profile.children.cycles-pp.drm_do_probe_ddc_edid
      0.86 ±  5%      -0.5        0.32 ± 46%  perf-profile.children.cycles-pp.drm_helper_probe_detect_ctx
      0.86 ±  5%      -0.5        0.32 ± 46%  perf-profile.children.cycles-pp.drm_probe_ddc
      0.86 ±  5%      -0.5        0.32 ± 46%  perf-profile.children.cycles-pp.i2c_transfer
      0.86 ±  5%      -0.5        0.32 ± 46%  perf-profile.children.cycles-pp.output_poll_execute
      0.82 ± 19%      -0.5        0.29 ± 47%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.80 ±  6%      -0.5        0.29 ± 41%  perf-profile.children.cycles-pp.try_address
      0.80 ± 32%      -0.5        0.30 ± 51%  perf-profile.children.cycles-pp.__vfork
      1.24 ± 10%      -0.5        0.74 ± 33%  perf-profile.children.cycles-pp.__mmap
      0.72 ± 19%      -0.5        0.24 ± 37%  perf-profile.children.cycles-pp.vsnprintf
      0.79 ± 16%      -0.5        0.31 ± 42%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.72 ± 18%      -0.5        0.26 ± 53%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.77 ± 44%      -0.5        0.32 ± 28%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.69 ± 37%      -0.5        0.24 ± 37%  perf-profile.children.cycles-pp.dup_mm
      0.65 ± 41%      -0.4        0.22 ± 70%  perf-profile.children.cycles-pp.readn
      0.68 ±  5%      -0.4        0.26 ± 40%  perf-profile.children.cycles-pp.i2c_outb
      0.66 ± 12%      -0.4        0.26 ± 43%  perf-profile.children.cycles-pp.perf_event_mmap_output
      1.67 ±  5%      -0.4        1.28 ± 13%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.68 ± 36%      -0.4        0.29 ± 36%  perf-profile.children.cycles-pp.path_lookupat
      0.68 ± 36%      -0.4        0.30 ± 35%  perf-profile.children.cycles-pp.filename_lookup
      0.62 ± 30%      -0.4        0.24 ± 61%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.54 ± 35%      -0.4        0.16 ± 38%  perf-profile.children.cycles-pp._IO_fwrite
      0.58 ± 23%      -0.4        0.21 ± 50%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.81 ± 27%      -0.4        0.44 ± 38%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.54 ± 33%      -0.4        0.17 ± 35%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.57 ± 27%      -0.4        0.20 ± 40%  perf-profile.children.cycles-pp.dup_mmap
      0.57 ± 16%      -0.4        0.21 ± 53%  perf-profile.children.cycles-pp.mprotect_fixup
      0.52 ± 36%      -0.4        0.16 ± 42%  perf-profile.children.cycles-pp.__d_alloc
      0.57 ± 30%      -0.4        0.22 ± 51%  perf-profile.children.cycles-pp.lookup_fast
      0.64 ± 23%      -0.3        0.30 ± 46%  perf-profile.children.cycles-pp.free_pgtables
      0.62 ± 52%      -0.3        0.28 ± 23%  perf-profile.children.cycles-pp.vfs_fstatat
      0.54 ± 25%      -0.3        0.20 ± 45%  perf-profile.children.cycles-pp.vma_complete
      0.71 ± 22%      -0.3        0.37 ± 21%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.70 ± 19%      -0.3        0.36 ± 23%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.56 ± 22%      -0.3        0.22 ± 51%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.56 ± 22%      -0.3        0.22 ± 51%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.62 ± 29%      -0.3        0.30 ± 56%  perf-profile.children.cycles-pp.dput
      0.71 ± 22%      -0.3        0.38 ± 21%  perf-profile.children.cycles-pp.__vm_munmap
      0.54 ± 45%      -0.3        0.23 ± 33%  perf-profile.children.cycles-pp.vfs_statx
      1.27 ± 12%      -0.3        0.96 ± 11%  perf-profile.children.cycles-pp.menu_select
      0.52 ± 24%      -0.3        0.22 ± 56%  perf-profile.children.cycles-pp.load_elf_interp
      0.47 ± 26%      -0.3        0.16 ± 62%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.39 ± 50%      -0.3        0.09 ± 90%  perf-profile.children.cycles-pp.__mmdrop
      0.40 ± 64%      -0.3        0.10 ± 51%  perf-profile.children.cycles-pp.vma_prepare
      0.47 ± 15%      -0.3        0.18 ± 47%  perf-profile.children.cycles-pp.sclhi
      0.40 ± 36%      -0.3        0.10 ± 57%  perf-profile.children.cycles-pp.vmstat_start
      0.42 ± 26%      -0.3        0.12 ± 63%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.43 ± 27%      -0.3        0.14 ± 45%  perf-profile.children.cycles-pp.__output_copy
      0.54 ± 28%      -0.3        0.26 ± 35%  perf-profile.children.cycles-pp.delay_tsc
      0.46 ± 36%      -0.3        0.18 ± 36%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.46 ±  6%      -0.3        0.18 ± 42%  perf-profile.children.cycles-pp.seq_printf
      0.51 ± 18%      -0.3        0.24 ± 46%  perf-profile.children.cycles-pp.slab_show
      0.36 ± 27%      -0.3        0.10 ± 65%  perf-profile.children.cycles-pp.unlink_anon_vmas
      1.18 ± 11%      -0.3        0.91 ± 11%  perf-profile.children.cycles-pp.update_process_times
      0.39 ± 52%      -0.3        0.13 ± 52%  perf-profile.children.cycles-pp.perf_evsel__read
      0.36 ± 37%      -0.2        0.12 ± 29%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.29 ± 23%      -0.2        0.06 ± 82%  perf-profile.children.cycles-pp.try_to_unlazy
      0.31 ± 33%      -0.2        0.08 ± 85%  perf-profile.children.cycles-pp.acpi_ps_execute_method
      0.31 ± 33%      -0.2        0.08 ± 85%  perf-profile.children.cycles-pp.acpi_ps_parse_aml
      0.34 ± 14%      -0.2        0.12 ± 75%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.39 ± 28%      -0.2        0.17 ± 56%  perf-profile.children.cycles-pp.wait4
      0.31 ± 33%      -0.2        0.09 ± 81%  perf-profile.children.cycles-pp.acpi_ev_asynch_execute_gpe_method
      0.31 ± 33%      -0.2        0.09 ± 81%  perf-profile.children.cycles-pp.acpi_ns_evaluate
      0.36 ± 12%      -0.2        0.15 ± 63%  perf-profile.children.cycles-pp.acpi_os_read_port
      0.26 ± 50%      -0.2        0.05 ± 74%  perf-profile.children.cycles-pp.sched_move_task
      0.38 ± 14%      -0.2        0.17 ± 67%  perf-profile.children.cycles-pp.acpi_ev_sci_xrupt_handler
      0.38 ± 14%      -0.2        0.17 ± 67%  perf-profile.children.cycles-pp.acpi_irq
      0.38 ± 14%      -0.2        0.17 ± 67%  perf-profile.children.cycles-pp.irq_thread_fn
      0.31 ± 33%      -0.2        0.10 ± 61%  perf-profile.children.cycles-pp.acpi_os_execute_deferred
      0.32 ± 46%      -0.2        0.12 ± 55%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.28 ± 32%      -0.2        0.07 ± 79%  perf-profile.children.cycles-pp.copy_p4d_range
      0.28 ± 32%      -0.2        0.07 ± 79%  perf-profile.children.cycles-pp.copy_page_range
      0.34 ± 30%      -0.2        0.13 ± 60%  perf-profile.children.cycles-pp.devkmsg_read
      0.30 ± 25%      -0.2        0.10 ± 91%  perf-profile.children.cycles-pp.mas_split
      0.26 ± 33%      -0.2        0.06 ± 87%  perf-profile.children.cycles-pp.__legitimize_path
      0.33 ± 18%      -0.2        0.13 ± 81%  perf-profile.children.cycles-pp.__dentry_kill
      0.38 ± 14%      -0.2        0.17 ± 62%  perf-profile.children.cycles-pp.irq_thread
      0.28 ± 35%      -0.2        0.08 ± 82%  perf-profile.children.cycles-pp.printk_get_next_message
      0.34 ± 54%      -0.2        0.14 ± 53%  perf-profile.children.cycles-pp.mas_walk
      0.35 ± 17%      -0.2        0.15 ± 63%  perf-profile.children.cycles-pp.acpi_hw_gpe_read
      0.36 ± 19%      -0.2        0.17 ± 67%  perf-profile.children.cycles-pp.acpi_ev_detect_gpe
      0.36 ± 19%      -0.2        0.17 ± 67%  perf-profile.children.cycles-pp.acpi_ev_gpe_detect
      0.25 ± 27%      -0.2        0.06 ± 74%  perf-profile.children.cycles-pp.number
      0.26 ± 19%      -0.2        0.08 ± 76%  perf-profile.children.cycles-pp.do_open_execat
      0.30 ± 20%      -0.2        0.12 ± 74%  perf-profile.children.cycles-pp.vma_modify
      0.30 ± 20%      -0.2        0.12 ± 74%  perf-profile.children.cycles-pp.vma_modify_flags
      0.28 ± 24%      -0.2        0.10 ± 51%  perf-profile.children.cycles-pp.__collapse_huge_page_copy_succeeded
      0.32 ± 29%      -0.2        0.14 ± 68%  perf-profile.children.cycles-pp.kernel_wait4
      0.31 ± 26%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.do_wait
      0.26 ± 23%      -0.2        0.10 ± 65%  perf-profile.children.cycles-pp.affine_move_task
      0.19 ± 54%      -0.2        0.03 ±108%  perf-profile.children.cycles-pp._install_special_mapping
      0.25 ± 35%      -0.2        0.09 ± 68%  perf-profile.children.cycles-pp.format_decode
      0.21 ± 32%      -0.2        0.06 ±121%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.30 ± 31%      -0.2        0.15 ± 46%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.22 ± 52%      -0.1        0.08 ± 80%  perf-profile.children.cycles-pp.clear_page_erms
      0.19 ± 54%      -0.1        0.05 ± 85%  perf-profile.children.cycles-pp.map_vdso
      0.21 ± 34%      -0.1        0.06 ± 83%  perf-profile.children.cycles-pp.folio_putback_lru
      0.20 ± 33%      -0.1        0.05 ± 51%  perf-profile.children.cycles-pp.__perf_sw_event
      0.18 ± 55%      -0.1        0.04 ±124%  perf-profile.children.cycles-pp.seq_path
      0.20 ± 41%      -0.1        0.06 ± 85%  perf-profile.children.cycles-pp.flush_tlb_func
      0.19 ± 32%      -0.1        0.07 ± 57%  perf-profile.children.cycles-pp.__check_object_size
      0.20 ± 37%      -0.1        0.08 ± 66%  perf-profile.children.cycles-pp.__close_nocancel
      0.20 ± 50%      -0.1        0.08 ±117%  perf-profile.children.cycles-pp.schedule_tail
      0.17 ± 41%      -0.1        0.04 ± 79%  perf-profile.children.cycles-pp.scnprintf
      0.29 ± 32%      -0.1        0.17 ± 58%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.17 ± 42%      -0.1        0.05 ± 76%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.28 ± 34%      -0.1        0.17 ± 58%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.16 ± 57%      -0.1        0.05 ± 74%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.14 ± 46%      -0.1        0.06 ± 84%  perf-profile.children.cycles-pp.__put_user_8
      0.24 ± 29%      -0.1        0.15 ± 28%  perf-profile.children.cycles-pp.timer_expire_remote
      0.03 ±141%      +0.1        0.11 ± 35%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.03 ±141%      +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.00            +0.1        0.09 ± 46%  perf-profile.children.cycles-pp.xa_load
      0.01 ±223%      +0.1        0.10 ± 49%  perf-profile.children.cycles-pp.__blk_bios_map_sg
      0.01 ±223%      +0.1        0.10 ± 49%  perf-profile.children.cycles-pp.__blk_rq_map_sg
      0.00            +0.1        0.09 ± 37%  perf-profile.children.cycles-pp.xlog_write
      0.03 ±141%      +0.1        0.12 ± 40%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.01 ±223%      +0.1        0.12 ± 53%  perf-profile.children.cycles-pp.__xa_set_mark
      0.01 ±223%      +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.mempool_alloc_noprof
      0.03 ±141%      +0.1        0.14 ± 36%  perf-profile.children.cycles-pp.atime_needs_update
      0.00            +0.1        0.11 ± 35%  perf-profile.children.cycles-pp.xfs_iread_extents
      0.01 ±223%      +0.1        0.13 ± 52%  perf-profile.children.cycles-pp.xas_set_mark
      0.02 ±223%      +0.1        0.14 ± 56%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.00            +0.1        0.12 ± 28%  perf-profile.children.cycles-pp.inode_to_bdi
      0.01 ±223%      +0.1        0.16 ± 55%  perf-profile.children.cycles-pp.scsi_alloc_sgtables
      0.00            +0.1        0.15 ± 48%  perf-profile.children.cycles-pp.flush_workqueue_prep_pwqs
      0.22 ± 41%      +0.2        0.38 ± 35%  perf-profile.children.cycles-pp.run_timer_softirq
      0.01 ±223%      +0.2        0.18 ± 58%  perf-profile.children.cycles-pp.sd_setup_read_write_cmnd
      0.07 ± 85%      +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.00            +0.2        0.17 ± 44%  perf-profile.children.cycles-pp.stress_metamix_cmp
      0.07 ±125%      +0.2        0.24 ± 45%  perf-profile.children.cycles-pp.down_read
      0.00            +0.2        0.18 ± 69%  perf-profile.children.cycles-pp.xfs_dir_remove_child
      0.04 ±100%      +0.2        0.22 ± 30%  perf-profile.children.cycles-pp.xlog_state_do_callback
      0.04 ±100%      +0.2        0.22 ± 30%  perf-profile.children.cycles-pp.xlog_state_do_iclog_callbacks
      0.05 ±111%      +0.2        0.24 ± 25%  perf-profile.children.cycles-pp.folio_unlock
      0.08 ± 55%      +0.2        0.28 ± 40%  perf-profile.children.cycles-pp.touch_atime
      0.03 ±141%      +0.2        0.23 ± 77%  perf-profile.children.cycles-pp.xfs_ilock_for_iomap
      0.04 ±100%      +0.2        0.24 ± 26%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.00            +0.2        0.20 ± 25%  perf-profile.children.cycles-pp.xas_clear_mark
      0.00            +0.2        0.22 ± 69%  perf-profile.children.cycles-pp.find_lock_entries
      0.00            +0.2        0.22 ± 36%  perf-profile.children.cycles-pp.xlog_cil_push_work
      0.04 ±100%      +0.2        0.26 ± 12%  perf-profile.children.cycles-pp.xlog_ioend_work
      0.03 ±141%      +0.2        0.25 ± 31%  perf-profile.children.cycles-pp.xas_start
      0.00            +0.2        0.23 ± 87%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.40 ± 23%      +0.2        0.63 ± 11%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.08 ±112%      +0.2        0.32 ± 24%  perf-profile.children.cycles-pp.xas_find
      0.01 ±223%      +0.3        0.27 ± 74%  perf-profile.children.cycles-pp.xas_store
      0.03 ±141%      +0.3        0.29 ± 46%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.03 ±141%      +0.3        0.29 ± 74%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.00            +0.3        0.28 ± 31%  perf-profile.children.cycles-pp.blk_mq_run_work_fn
      0.00            +0.3        0.28 ± 62%  perf-profile.children.cycles-pp.blk_mq_requeue_work
      0.14 ± 62%      +0.3        0.42 ± 61%  perf-profile.children.cycles-pp.dd_bio_merge
      0.03 ±223%      +0.3        0.32 ± 62%  perf-profile.children.cycles-pp.blk_mq_run_hw_queues
      0.00            +0.3        0.32 ± 65%  perf-profile.children.cycles-pp.xfs_remove
      0.00            +0.3        0.32 ± 65%  perf-profile.children.cycles-pp.xfs_vn_unlink
      0.00            +0.3        0.34 ± 67%  perf-profile.children.cycles-pp.vfs_unlink
      0.07 ± 81%      +0.3        0.41 ± 88%  perf-profile.children.cycles-pp.stress_metamix_file
      0.00            +0.3        0.35 ± 66%  perf-profile.children.cycles-pp.xfs_create
      0.00            +0.4        0.36 ± 68%  perf-profile.children.cycles-pp.xfs_generic_create
      0.02 ±223%      +0.4        0.38 ± 66%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      0.06 ±116%      +0.4        0.42 ± 67%  perf-profile.children.cycles-pp.lookup_open
      0.01 ±223%      +0.4        0.39 ± 52%  perf-profile.children.cycles-pp.xfs_iunlock
      0.07 ± 82%      +0.4        0.46 ± 66%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.25 ± 20%      +0.4        0.66 ± 44%  perf-profile.children.cycles-pp.__folio_batch_add_and_move
      0.03 ±141%      +0.4        0.45 ± 35%  perf-profile.children.cycles-pp.xfs_map_blocks
      0.01 ±223%      +0.4        0.44 ± 64%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.00            +0.4        0.43 ± 74%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.00            +0.4        0.44 ± 76%  perf-profile.children.cycles-pp.xfs_free_ag_extent
      0.16 ± 26%      +0.5        0.63 ± 24%  perf-profile.children.cycles-pp.__wait_for_common
      0.00            +0.5        0.49 ± 93%  perf-profile.children.cycles-pp.xlog_force_lsn
      0.49 ± 24%      +0.5        0.98 ± 18%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.26 ± 59%      +0.5        0.76 ± 61%  perf-profile.children.cycles-pp.open64
      0.54 ± 20%      +0.5        1.05 ± 25%  perf-profile.children.cycles-pp.__queue_work
      0.10 ±102%      +0.5        0.62 ± 44%  perf-profile.children.cycles-pp.folio_alloc_noprof
      0.10 ± 58%      +0.5        0.63 ± 60%  perf-profile.children.cycles-pp.filemap_dirty_folio
      1.80 ± 21%      +0.5        2.35 ±  6%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.6        0.55 ± 81%  perf-profile.children.cycles-pp.xfs_trans_roll
      0.00            +0.6        0.56 ±102%  perf-profile.children.cycles-pp.xfs_free_extent_fix_freelist
      0.00            +0.6        0.57 ± 82%  perf-profile.children.cycles-pp.xfs_defer_trans_roll
      0.03 ±141%      +0.6        0.62 ± 67%  perf-profile.children.cycles-pp.filemap_get_read_batch
      0.03 ±141%      +0.6        0.66 ± 66%  perf-profile.children.cycles-pp.filemap_get_pages
      0.71 ± 35%      +0.7        1.36 ±  8%  perf-profile.children.cycles-pp.rq_qos_wait
      0.74 ± 32%      +0.7        1.39 ±  7%  perf-profile.children.cycles-pp.wbt_wait
      0.02 ±223%      +0.7        0.67 ± 86%  perf-profile.children.cycles-pp.xfs_alloc_ag_vextent_near
      0.74 ± 32%      +0.7        1.40 ±  7%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.03 ±141%      +0.7        0.70 ± 81%  perf-profile.children.cycles-pp.osq_lock
      0.12 ±105%      +0.7        0.80 ± 32%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.7        0.69 ± 51%  perf-profile.children.cycles-pp.submit_bio_wait
      0.00            +0.7        0.69 ± 51%  perf-profile.children.cycles-pp.blkdev_issue_flush
      0.03 ±223%      +0.7        0.76 ± 50%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.01 ±223%      +0.7        0.76 ± 54%  perf-profile.children.cycles-pp.iomap_iter_advance
      0.11 ± 69%      +0.8        0.87 ± 21%  perf-profile.children.cycles-pp.xas_load
      0.10 ± 58%      +0.8        0.86 ± 58%  perf-profile.children.cycles-pp.iomap_write_end
      0.25 ± 57%      +0.9        1.10 ± 57%  perf-profile.children.cycles-pp._copy_to_iter
      0.47 ± 47%      +0.9        1.33 ± 55%  perf-profile.children.cycles-pp.xlog_cil_commit
      0.03 ±141%      +0.9        0.95 ± 54%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.57 ± 40%      +0.9        1.50 ± 52%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.00            +1.0        0.97 ±103%  perf-profile.children.cycles-pp.xfs_alloc_fix_freelist
      0.00            +1.0        1.04 ±107%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.00            +1.1        1.05 ± 71%  perf-profile.children.cycles-pp.xlog_wait_on_iclog
      0.00            +1.1        1.07 ±106%  perf-profile.children.cycles-pp.xfs_buf_read_map
      1.74 ± 13%      +1.1        2.82 ± 13%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.11 ± 55%      +1.1        1.21 ± 44%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.00            +1.1        1.10 ± 85%  perf-profile.children.cycles-pp.__xfs_free_extent
      2.22 ± 15%      +1.1        3.34 ± 11%  perf-profile.children.cycles-pp.__pick_next_task
      0.00            +1.1        1.15 ± 83%  perf-profile.children.cycles-pp.xfs_extent_free_finish_item
      0.02 ±223%      +1.2        1.17 ± 91%  perf-profile.children.cycles-pp.xfs_alloc_vextent_iterate_ags
      0.02 ±223%      +1.2        1.18 ± 92%  perf-profile.children.cycles-pp.xfs_alloc_vextent_start_ag
      0.03 ±141%      +1.2        1.19 ± 59%  perf-profile.children.cycles-pp.filemap_add_folio
      0.08 ± 55%      +1.2        1.26 ± 66%  perf-profile.children.cycles-pp.schedule_timeout
      0.00            +1.2        1.18 ± 81%  perf-profile.children.cycles-pp.xfs_defer_finish_one
      0.02 ±223%      +1.2        1.22 ± 89%  perf-profile.children.cycles-pp.xfs_bmap_btalloc_best_length
      0.02 ±223%      +1.2        1.24 ± 88%  perf-profile.children.cycles-pp.xfs_bmap_btalloc
      4.54 ±  9%      +1.2        5.77 ±  6%  perf-profile.children.cycles-pp.__schedule
      0.00            +1.2        1.25 ±102%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      1.04 ± 15%      +1.3        2.30 ± 16%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.06 ±223%      +1.3        1.32 ± 47%  perf-profile.children.cycles-pp.try_to_grab_pending
      0.02 ±223%      +1.3        1.29 ± 89%  perf-profile.children.cycles-pp.xfs_bmapi_allocate
      3.27 ±  9%      +1.3        4.55 ± 10%  perf-profile.children.cycles-pp.schedule
      0.06 ±116%      +1.3        1.39 ± 45%  perf-profile.children.cycles-pp.writeback_get_folio
      0.01 ±223%      +1.3        1.35 ± 80%  perf-profile.children.cycles-pp.xfs_defer_finish_noroll
      0.26 ± 48%      +1.4        1.69 ± 42%  perf-profile.children.cycles-pp.folio_end_writeback
      0.08 ± 83%      +1.4        1.52 ± 44%  perf-profile.children.cycles-pp.writeback_iter
      0.00            +1.5        1.46 ± 65%  perf-profile.children.cycles-pp.__flush_workqueue
      0.12 ± 53%      +1.5        1.60 ±115%  perf-profile.children.cycles-pp.__page_cache_release
      0.03 ±141%      +1.5        1.53 ± 86%  perf-profile.children.cycles-pp.xfs_bmapi_convert_one_delalloc
      0.03 ±141%      +1.5        1.54 ± 87%  perf-profile.children.cycles-pp.xfs_bmapi_convert_delalloc
      0.06 ±223%      +1.5        1.56 ± 47%  perf-profile.children.cycles-pp.kblockd_mod_delayed_work_on
      0.03 ±141%      +1.5        1.55 ± 85%  perf-profile.children.cycles-pp.remove_wait_queue
      1.43 ± 22%      +1.5        2.97 ± 17%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.32 ± 41%      +1.6        1.89 ± 42%  perf-profile.children.cycles-pp.iomap_finish_ioend
      0.32 ± 41%      +1.6        1.89 ± 42%  perf-profile.children.cycles-pp.iomap_finish_ioends
      0.07 ±109%      +1.6        1.66 ± 50%  perf-profile.children.cycles-pp.llseek
      0.06 ±223%      +1.6        1.66 ± 41%  perf-profile.children.cycles-pp.mod_delayed_work_on
      0.00            +1.6        1.60 ± 67%  perf-profile.children.cycles-pp.xlog_cil_push_now
      0.66 ± 29%      +1.8        2.43 ± 44%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      0.00            +1.8        1.81 ± 82%  perf-profile.children.cycles-pp.xfs_defer_finish
      0.00            +1.9        1.93 ± 81%  perf-profile.children.cycles-pp.xfs_bunmapi_range
      0.00            +1.9        1.93 ± 81%  perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
      0.00            +2.0        1.98 ± 81%  perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.20 ± 81%      +2.1        2.26 ± 55%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.10 ±110%      +2.1        2.16 ± 60%  perf-profile.children.cycles-pp.filemap_read
      0.00            +2.1        2.15 ± 80%  perf-profile.children.cycles-pp.xfs_inactive
      0.00            +2.2        2.15 ± 80%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.00            +2.3        2.33 ± 63%  perf-profile.children.cycles-pp.xfs_file_buffered_read
      0.00            +2.3        2.34 ± 73%  perf-profile.children.cycles-pp.xlog_cil_force_seq
      0.00            +2.4        2.36 ± 63%  perf-profile.children.cycles-pp.xfs_file_read_iter
      0.00            +2.5        2.50 ±100%  perf-profile.children.cycles-pp.evict
      0.31 ± 49%      +2.5        2.85 ± 51%  perf-profile.children.cycles-pp.memset_orig
      0.00            +2.5        2.54 ±101%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      5.40 ± 16%      +2.6        7.95 ± 18%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.09 ± 82%      +2.6        2.70 ± 74%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      0.16 ± 76%      +2.7        2.84 ± 53%  perf-profile.children.cycles-pp.zero_user_segments
      6.76 ±  5%      +2.8        9.59 ±  5%  perf-profile.children.cycles-pp.ret_from_fork_asm
      6.72 ±  5%      +2.8        9.57 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
      0.14 ± 55%      +2.9        3.01 ± 57%  perf-profile.children.cycles-pp.__iomap_write_begin
      6.50 ±  5%      +2.9        9.44 ±  6%  perf-profile.children.cycles-pp.kthread
      0.00            +3.0        2.97 ± 95%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.00            +3.0        2.97 ± 95%  perf-profile.children.cycles-pp.do_unlinkat
      0.00            +3.0        2.99 ± 96%  perf-profile.children.cycles-pp.unlink
      0.14 ± 73%      +3.5        3.65 ± 66%  perf-profile.children.cycles-pp.iomap_iter
      0.00            +3.5        3.53 ± 73%  perf-profile.children.cycles-pp.xfs_log_force_seq
      2.98 ± 11%      +3.7        6.66 ± 12%  perf-profile.children.cycles-pp.process_one_work
      3.39 ± 10%      +4.4        7.83 ± 11%  perf-profile.children.cycles-pp.worker_thread
      0.29 ± 42%      +5.1        5.39 ± 56%  perf-profile.children.cycles-pp.iomap_write_begin
      0.45 ± 37%      +5.9        6.33 ± 55%  perf-profile.children.cycles-pp.iomap_write_iter
      0.07 ± 79%      +6.0        6.03 ± 43%  perf-profile.children.cycles-pp.iomap_writepage_map_blocks
      0.50 ± 37%      +6.9        7.35 ± 55%  perf-profile.children.cycles-pp.iomap_file_buffered_write
      0.11 ± 80%      +7.1        7.20 ± 43%  perf-profile.children.cycles-pp.iomap_writepage_map
     38.02 ±  3%      +8.8       46.87 ± 16%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     37.87 ±  3%      +8.9       46.73 ± 16%  perf-profile.children.cycles-pp.do_syscall_64
      0.00           +10.7       10.68 ± 32%  perf-profile.children.cycles-pp.file_write_and_wait_range
      0.00           +14.8       14.79 ± 17%  perf-profile.children.cycles-pp.xfs_file_fsync
      0.00           +14.8       14.80 ± 17%  perf-profile.children.cycles-pp.__x64_sys_fdatasync
      0.00           +14.9       14.92 ± 16%  perf-profile.children.cycles-pp.fdatasync
      0.00           +15.3       15.28 ± 13%  perf-profile.children.cycles-pp.do_fsync
     10.09 ± 10%     +27.7       37.79 ± 33%  perf-profile.children.cycles-pp.stress_metamix
     11.38 ±  7%      -3.7        7.66 ± 17%  perf-profile.self.cycles-pp.acpi_safe_halt
      1.02 ± 25%      -0.5        0.48 ± 35%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.79 ± 23%      -0.5        0.26 ± 32%  perf-profile.self.cycles-pp.filemap_map_pages
      1.01 ± 21%      -0.5        0.53 ± 37%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.61 ± 34%      -0.4        0.20 ± 71%  perf-profile.self.cycles-pp.zap_present_ptes
      0.51 ± 38%      -0.4        0.14 ± 46%  perf-profile.self.cycles-pp._IO_fwrite
      0.54 ± 28%      -0.3        0.26 ± 35%  perf-profile.self.cycles-pp.delay_tsc
      0.47 ± 33%      -0.3        0.18 ± 53%  perf-profile.self.cycles-pp.mod_objcg_state
      0.31 ± 38%      -0.2        0.08 ± 56%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.36 ± 12%      -0.2        0.15 ± 63%  perf-profile.self.cycles-pp.acpi_os_read_port
      0.34 ± 54%      -0.2        0.14 ± 53%  perf-profile.self.cycles-pp.mas_walk
      0.35 ± 22%      -0.2        0.16 ± 53%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.22 ± 27%      -0.2        0.04 ±104%  perf-profile.self.cycles-pp.number
      0.22 ± 52%      -0.1        0.08 ± 80%  perf-profile.self.cycles-pp.clear_page_erms
      0.18 ± 49%      -0.1        0.06 ± 54%  perf-profile.self.cycles-pp.__call_rcu_common
      0.17 ± 42%      -0.1        0.05 ± 76%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.15 ± 57%      -0.1        0.04 ±120%  perf-profile.self.cycles-pp.timekeeping_advance
      0.03 ±141%      +0.1        0.11 ± 35%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.01 ±223%      +0.1        0.10 ± 39%  perf-profile.self.cycles-pp.__blk_bios_map_sg
      0.00            +0.1        0.10 ± 40%  perf-profile.self.cycles-pp.inode_to_bdi
      0.01 ±223%      +0.1        0.12 ± 51%  perf-profile.self.cycles-pp.xas_set_mark
      0.00            +0.1        0.12 ± 65%  perf-profile.self.cycles-pp.iomap_writepage_map_blocks
      0.00            +0.1        0.14 ± 51%  perf-profile.self.cycles-pp.__iomap_write_begin
      0.00            +0.2        0.15 ± 59%  perf-profile.self.cycles-pp.find_lock_entries
      0.00            +0.2        0.17 ± 42%  perf-profile.self.cycles-pp.stress_metamix_cmp
      0.00            +0.2        0.17 ± 28%  perf-profile.self.cycles-pp.xas_find
      0.00            +0.2        0.18 ± 52%  perf-profile.self.cycles-pp.llseek
      0.00            +0.2        0.18 ± 36%  perf-profile.self.cycles-pp.xas_clear_mark
      0.00            +0.2        0.18 ± 37%  perf-profile.self.cycles-pp.filemap_read
      0.05 ±111%      +0.2        0.24 ± 24%  perf-profile.self.cycles-pp.folio_unlock
      0.03 ±141%      +0.2        0.22 ± 37%  perf-profile.self.cycles-pp.xas_start
      0.18 ± 48%      +0.2        0.38 ± 32%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.30 ± 23%      +0.2        0.50 ± 16%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.01 ±223%      +0.2        0.22 ± 66%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.01 ±223%      +0.2        0.23 ± 49%  perf-profile.self.cycles-pp.filemap_get_folios_tag
      0.00            +0.2        0.24 ± 56%  perf-profile.self.cycles-pp.writeback_get_folio
      0.03 ±141%      +0.3        0.28 ± 46%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.01 ±223%      +0.3        0.32 ± 47%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.01 ±223%      +0.3        0.35 ± 48%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.02 ±223%      +0.3        0.36 ± 67%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      0.00            +0.4        0.38 ± 50%  perf-profile.self.cycles-pp.folio_end_writeback
      0.03 ±141%      +0.5        0.50 ± 63%  perf-profile.self.cycles-pp.filemap_get_read_batch
      0.08 ± 96%      +0.5        0.62 ± 29%  perf-profile.self.cycles-pp.xas_load
      0.12 ±105%      +0.6        0.68 ± 35%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.03 ±141%      +0.7        0.70 ± 81%  perf-profile.self.cycles-pp.osq_lock
      0.01 ±223%      +0.7        0.74 ± 53%  perf-profile.self.cycles-pp.iomap_iter_advance
      0.31 ± 49%      +2.5        2.82 ± 51%  perf-profile.self.cycles-pp.memset_orig
      5.37 ± 15%      +2.6        7.93 ± 18%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


