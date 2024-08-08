Return-Path: <linux-fsdevel+bounces-25420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 801D494BF78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE131C265EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628B318FC79;
	Thu,  8 Aug 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TB7vIZQs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3F18E02D;
	Thu,  8 Aug 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126414; cv=fail; b=djPbOf4koZUVNKeYuorp3EjmSUe6GjxxS7qAl4CvgFYSt39Y4ZcvpKbeAFClj8vxie1HskgnDmZ7eE2haXOTGUsYvx3RKz+/YYsLtl/T/bRPGhxbc3kM/dtHBL2Md5Jwzrwn0VJuBi5cW3OSpyLDS5lDpSltABfLDs7pzMw7XgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126414; c=relaxed/simple;
	bh=Zbsy/+xPrsporutrn5Ew/1Mu7CwGpApG9pfIZTRX2TE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YQzu87DI80RGzyFYHsr2Wy5/F8MRE/wHMIGnyaq8XxooveVFdqsHvFEsTILjLYzsBud/vVLZ6XMHB9VYJitd7Gt18FbOqnRN/xG4avDBWKjz+IhupcHgmG9N78C4OJQEvaxfbBAi+tCtTL/ZW4oxJvRvnefqkhxXJBp7gHOQ7w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TB7vIZQs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723126412; x=1754662412;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zbsy/+xPrsporutrn5Ew/1Mu7CwGpApG9pfIZTRX2TE=;
  b=TB7vIZQs6HYdiDYSjkzj/t5m69I57cymY/fs4LajwLRTFuD9IZqGWcjc
   EtpC8aCeLrvtwrvcwyMEbRsxJ88dujATzwAJ45tuzzkz+zW+tmPgeSwfl
   67DgB4ANamypJVQkKA1q4X/DlXZAzHRgjHSTF2WMI6Uxj6jORLURBZZCR
   KFOC7lFePqKDLK4PJg4tWaR80ECs80tVS5IC0YCBfEPtlyuxjz/bs+50M
   se+hZA3E34tDFh+a+/S1K9SlRv68siG2og3YeJXszygVsvKEET8i9Q7R9
   CaQ5eqgrjuR1omGIvAXmdYIKE3kP0HhiKxzwZVRgE0KyrfdlGMS8/zQvx
   g==;
X-CSE-ConnectionGUID: A5xGnt0OQL2yeHy1L1xxIQ==
X-CSE-MsgGUID: uBuhYWeNS267VVsg1LRKWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21224441"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21224441"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 07:13:31 -0700
X-CSE-ConnectionGUID: dl1oqiA9Sq6YOXh1kBzNxQ==
X-CSE-MsgGUID: UfyP5Lp7SyK6yFZdrFpvrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57191151"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 07:13:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 07:13:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 07:13:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 07:13:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 07:13:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiXybMe3rVE1SEKtBfReSt/olBgKbIxAWj6A1XUvQ17ZQk7iP1rt+4M7+5iRelREgI17KSs6oobsA8WUXB7BSxnkm8WLo7MXAIGCf1LddqG0JZTabRgUKxt7c0MZm9/NkGd6s3+eFTibHlq0mf+ghyHHZeTwt0wcdjb90G9PeDegKzMv4KyRzs+WjRzs9xPLEgwrcfpNFmBhr5Skoyb86FhItkODmFQ2D1PmWoeZ0ysurMgINZ+DnsgYxCnRrm3V0GfWa7wcZqvolEGfG6qhYiuCmMTG1zVmQbSIb5cF/pTK1Vb/LjHHoS6ij4fDg3+5CewaQ8sElyN9nJBovWGaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqzAgohhDTBbXI/CLlV88KuoVXXPd1PO0fMbtlgqGew=;
 b=Oc6oczw2sOMR8l9sp9uBvtqUt03UI3LnHBb1nLWQgoYa3/Qt7W1zh45Th9a+mTm2bMMAsADYdS1mM/+S9rzr2z7lyIW3L96fNdO3I+VQgEmYa8DfTno88yRcnfllemupPWH4jLuG1mFOhS0sWUBKfuAEZZ/Mc4TQ0HKCTiU4+HtNgTP8RsrZbsXnrVdyp2SCju4+keHILTwIVN4j+Pw0fwNNITxvqc7zW9nVCc0h7PGFxSZatll0zRxgJvfGLCUwoMCCxTy0raS8TRVjPZZSSjyPwcL6wycLpd69bHmzozwgPuZa2esvlrFlOOhFMghhtOw1OpMeoXzd3pXB8lJ69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7576.namprd11.prod.outlook.com (2603:10b6:a03:4c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 14:13:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 14:13:24 +0000
Date: Thu, 8 Aug 2024 22:13:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [axboe-block:rw_iter] [fs/proc]  a461a4f9ee: segfault_at_ip_sp_error
Message-ID: <202408082200.c3349d39-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e46185-2750-48ed-35f6-08dcb7b44426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L4mXggDTGFKgHqPZD4krWi1ziJ8l/fwVSqXlI6b+wzZU1NJ//fAyoUhLevTv?=
 =?us-ascii?Q?XBROMijen6/eXwKso7ydxoLvG5AwqbKJLQBUxGpiI8YXsaaqN9FGP96J7veq?=
 =?us-ascii?Q?A/a2YcDJBS4oZyhsPn0TE8dTNH5vWM6DpXxnF0zhSCghHOVrq7KIhRi2vKDb?=
 =?us-ascii?Q?ibzkZJEZgm1bIFHz6GAR8+aNyjip+ftyK4AmDKGKs6vmHlG4Xm+cANcN/kbc?=
 =?us-ascii?Q?2aqTMHF1oKy2GuGYA7qg35+HFaNsbvibXU8XGyefZ6z3/8w1TJytw6rnreR8?=
 =?us-ascii?Q?pmB2kQXMB+u09tcWV/K6kZfAYzZArR/Wvy2jgRqdNVW84AoN5ws8XbrRf4D4?=
 =?us-ascii?Q?4RhaUwNK9ceQLkoQXPmOV0bMBAxfaSLMu1/a9v6nlSSjIq139+OPOUB190zN?=
 =?us-ascii?Q?eXV7+AxdKYznscP0687RZpP0brpmBrB779vSrLby38k+qWtMn04a2R34/G7q?=
 =?us-ascii?Q?TwOCpxuR/XhCGzBpjHTLvUbzSayDSg8qKvAvMYJMgqJKjgDhqO2Sz330/J9L?=
 =?us-ascii?Q?MdIDWoM1yvNoBGEnWNHx0sv4ykHWrMjk6hVZGGBmIgNo6zUK+T/Eyg6h2NKp?=
 =?us-ascii?Q?lqiEM+KPyiaLtholNRFISBNZc6c3PX7GVS4EN+rxE6Q1CMPfuVYudBAIxXyA?=
 =?us-ascii?Q?8FKokrEdjztx/hVTLUexVH7Bz3WYz6JSuFi0AZhsbnO5iheMWP06fIo5Vqg+?=
 =?us-ascii?Q?KFNRV08VWAQNFVUnfpvUedBh/qAAsbV6S2FJqiqGUtR9/cCsdSt3ELzyVSFR?=
 =?us-ascii?Q?QF/Uw5oqCOIEzr3LLnkuEwRUM6s4zNVlzZEC0VZeg4qZrvilKYl/gcAgKuPS?=
 =?us-ascii?Q?0yEg/iTWENk2179lzCfeW4vwD2K2KFu6YR3JroJSlR66z9kV05qnbYEvBI6v?=
 =?us-ascii?Q?+P3r69UsRcgBlr39KZ9/UTlCMNgCwbZ9gS+fznhX0pHlt5tTpEKJ/OCxZ6rc?=
 =?us-ascii?Q?XuRc2tVwON80SnYMIchLvz9mjY5f7YcC86N9Pp1l9UcTGXcEdFvbEWiV9sCW?=
 =?us-ascii?Q?A7w2rcG7Xj1E85zsaR3dWhD5PNJBmYuPV4+olO10fCJYwARehjobQNVWklQU?=
 =?us-ascii?Q?mU28bKt6AOHZPlcRWbPOQg70mUjJ+pKlRBcWxLFIzBAQZgTUjHvkA9EkA2rA?=
 =?us-ascii?Q?R6nQ7lf5Wgy5n1yeSiOXPUrpG04u5MxdbbWBPqooJ7xM/9p5ZnRLpyF1Ltp4?=
 =?us-ascii?Q?eUYaIyiY2CwZgx7p+tXRXiMU4W9q3WVZu6OUIQtKUP7zOvTVYgUexUwRoYGF?=
 =?us-ascii?Q?EVH++2PMxKLuqoyelKWN7NAjuiAvXFxdKn1UsRwF9N5ooM266f3WgIeVFHwb?=
 =?us-ascii?Q?jRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2mohHidx9MhMEto5m1j334Tv6TDkvrBAYBn/Pk7/NuyoK1PqhJM/h1R+Nzod?=
 =?us-ascii?Q?8wUmPFm77DiE+OJ5aaq1/LsDiCWqdpXbFAENktlFWzI4mrTXYrwRMC+AZVDl?=
 =?us-ascii?Q?/kJYFVacKWEKrwHwjhrCQJUPVTmYaMYAtHYXUqSRnCOWlWLNPkoxmpUH7hC7?=
 =?us-ascii?Q?esIiFReeDzKxxaxGAWq9W09yWT2LJJvKurXXDBJzC73+APQGLIE0OJ/T42gK?=
 =?us-ascii?Q?WMPm/EKLerMUf0nEkp1XZ+1E1FMH6C/X3TWiMYoCZjTPOxZHdvqQjexcp0Vj?=
 =?us-ascii?Q?VsUhw6/CVYi2nt3KoARKj7rgNwYviW+aRNuTInTIU3IENEiIYV0CuadXhJ0z?=
 =?us-ascii?Q?c/THOugDo8H0M3iiLRbAK+15i3OHBfd/BJpL9DmM14leaZIopB8ZpuG55Qgs?=
 =?us-ascii?Q?Jxnjbk3Dnre+mJ82Yl2TVb9yRbyTawAIqnUwDtCO+yxNk6LUPkdEJA2DBjWe?=
 =?us-ascii?Q?seFtBC55EGrYcHmeDvA2Wzrd7sIx2yjJ/8AAgpArIJ6o73lkSqgz8/y4qK48?=
 =?us-ascii?Q?pThuytS5M9txDzszMx04c3cCVqzMbdAKMtvsRKtxPxfHAwICLAGSBnA1+XTR?=
 =?us-ascii?Q?Nx4vS3axdRsRYFBDH+6KouQOyMoX9cCVy8f4eLFUqrSn3FjvKxmJwudCgktd?=
 =?us-ascii?Q?ZUFdIZnhpcbSz565zpe/oDUelgI3d+3r18Lj+ynh4zrBXsAnXnln2TvVZeos?=
 =?us-ascii?Q?dqyWVnG/FYTDp9pWYtH46bZryJq9sMU2vhViZII6yNPRIu68iAjNm6IP9CWR?=
 =?us-ascii?Q?MA/k95uz7pdPV8vTTL9Esv1G/BcxneQA4UnZPcY1GLEzW+STe0fpk8MKFRnw?=
 =?us-ascii?Q?hu5ti0/AaZUmtr54IKmb8a2Qvr82tnAX2OtHyCtNmlT3qHf+nd8x3H5MlBJp?=
 =?us-ascii?Q?JqiUQHg8nSkgaykbExp8YKiRJwpSpO6qWl6GMDm0Zv21t0oibVa9Zd+8s6/4?=
 =?us-ascii?Q?/LM+x3sgQZa2V8Ms+pe4QqZ9HvAryOshQAUgOZphCIIws6fZsTOYDI9A4xRa?=
 =?us-ascii?Q?qRl2PY5CWV1j+JIjEsZe/YyRvDwQrHW+xOqr5RPZT0IWjFrLzaFh4IjijHNH?=
 =?us-ascii?Q?XtOHE44JmYnqXvQKDOuXub06q4cw+mT49EJZaZSf8xYfVDor+7Dl23/VA/yY?=
 =?us-ascii?Q?7TJhvFsPuuMxFFCLR9njGAACV5qT03xlcaMKBfH6kZozd5IxfSXYlLlGoawY?=
 =?us-ascii?Q?hD8YZWjrxKx5yxJ4+VQXnQL3htcMtDwfARd5Ypz7fOqaYmj3ORyogrc/FI6p?=
 =?us-ascii?Q?0mdVnZTrV++RozDwBGC+R2lH2KQ771QGTv2gIuW4bdQ7RT9mAqU+IB8JvPzk?=
 =?us-ascii?Q?gWhW3hxw9VYocOsNSjwQOoT1nwM6HKrvK6RVNc/QItGl8kqoLxhqmhuZuSiL?=
 =?us-ascii?Q?i5g73OVLvMVBx7zEVZtwwYHhfsviXH1nlKMcQFF3278pR+0rJnbLJFwsc3Yt?=
 =?us-ascii?Q?1F6ydcHJUeTcUeBVVDmcukS8NaH84nJIp0JHbuXNjkig6aC068m3XNOhN7TV?=
 =?us-ascii?Q?A9OKvrFw31m3cgKlZ9qbyVbD3bi7YoCT7EenbKk38HLUMF3GrzZ02zv/VWIp?=
 =?us-ascii?Q?533YCnTxHViqUtSEHoqgayQdW/PDw6t+nP2sqzi54R2G4wtWOH0PJfjkkq9e?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e46185-2750-48ed-35f6-08dcb7b44426
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:13:24.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QTJ5+zASi3p1LO+E+bKtbz3iAYKQ8gSvmJPHfhOeNqbQWsiGEu+6T+v5zI75vH5dkMBiBYcT9UIhfyN1ppiEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7576
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "segfault_at_ip_sp_error" on:

commit: a461a4f9eea48aa2bb8ac2a5c5e6b235e233e891 ("fs/proc: convert to read/write iterators")
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git rw_iter

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------+------------+------------+
|                         | a6f483c214 | a461a4f9ee |
+-------------------------+------------+------------+
| segfault_at_ip_sp_error | 0          | 6          |
+-------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408082200.c3349d39-oliver.sang@intel.com


[  OK  ] Started OpenBSD Secure Shell server.
LKP: ttyS0: 221: Kernel tests: Boot OK!
[  OK  ] Started System Logging Service.
LKP: ttyS0: 221: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.11.0-rc2-00295-ga461a4f9eea4 1
LKP: ttyS0: 221:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-189/boot-1-debian-11.1-i386-20220923.cgz-x86_64-randconfig-076-20240807-a461a4f9eea4-20240808-123352-1sio433-5.yaml
[  157.838726][  T408] vmstat[408]: segfault at 56633000 ip 00000000f7f4e774 sp 00000000ffbaee70 error 6 in libprocps.so.8.0.3[3774,f7f4e000+a000] likely on CPU 1 (core 1, socket 0)
[ 157.844239][ T408] Code: 74 24 0c 89 ee 89 cd 8d b4 26 00 00 00 00 57 6a 01 6a 08 55 e8 7d fb ff ff 8b 54 24 24 8b 4c 24 28 83 c4 10 8b 83 20 0b 00 00 <89> 14 30 89 4c 30 04 8b 44 24 14 83 c6 08 85 c0 75 d2 8b 74 24 0c
All code
========
   0:	74 24                	je     0x26
   2:	0c 89                	or     $0x89,%al
   4:	ee                   	out    %al,(%dx)
   5:	89 cd                	mov    %ecx,%ebp
   7:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   e:	57                   	push   %rdi
   f:	6a 01                	pushq  $0x1
  11:	6a 08                	pushq  $0x8
  13:	55                   	push   %rbp
  14:	e8 7d fb ff ff       	callq  0xfffffffffffffb96
  19:	8b 54 24 24          	mov    0x24(%rsp),%edx
  1d:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  21:	83 c4 10             	add    $0x10,%esp
  24:	8b 83 20 0b 00 00    	mov    0xb20(%rbx),%eax
  2a:*	89 14 30             	mov    %edx,(%rax,%rsi,1)		<-- trapping instruction
  2d:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
  31:	8b 44 24 14          	mov    0x14(%rsp),%eax
  35:	83 c6 08             	add    $0x8,%esi
  38:	85 c0                	test   %eax,%eax
  3a:	75 d2                	jne    0xe
  3c:	8b 74 24 0c          	mov    0xc(%rsp),%esi

Code starting with the faulting instruction
===========================================
   0:	89 14 30             	mov    %edx,(%rax,%rsi,1)
   3:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
   7:	8b 44 24 14          	mov    0x14(%rsp),%eax
   b:	83 c6 08             	add    $0x8,%esi
   e:	85 c0                	test   %eax,%eax
  10:	75 d2                	jne    0xffffffffffffffe4
  12:	8b 74 24 0c          	mov    0xc(%rsp),%esi
[  158.373225][  T352] vmstat[352]: segfault at 56630000 ip 00000000f7edd774 sp 00000000ffec1aa0 error 6 in libprocps.so.8.0.3[3774,f7edd000+a000] likely on CPU 1 (core 1, socket 0)
[ 158.434212][ T352] Code: 74 24 0c 89 ee 89 cd 8d b4 26 00 00 00 00 57 6a 01 6a 08 55 e8 7d fb ff ff 8b 54 24 24 8b 4c 24 28 83 c4 10 8b 83 20 0b 00 00 <89> 14 30 89 4c 30 04 8b 44 24 14 83 c6 08 85 c0 75 d2 8b 74 24 0c
All code
========
   0:	74 24                	je     0x26
   2:	0c 89                	or     $0x89,%al
   4:	ee                   	out    %al,(%dx)
   5:	89 cd                	mov    %ecx,%ebp
   7:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   e:	57                   	push   %rdi
   f:	6a 01                	pushq  $0x1
  11:	6a 08                	pushq  $0x8
  13:	55                   	push   %rbp
  14:	e8 7d fb ff ff       	callq  0xfffffffffffffb96
  19:	8b 54 24 24          	mov    0x24(%rsp),%edx
  1d:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  21:	83 c4 10             	add    $0x10,%esp
  24:	8b 83 20 0b 00 00    	mov    0xb20(%rbx),%eax
  2a:*	89 14 30             	mov    %edx,(%rax,%rsi,1)		<-- trapping instruction
  2d:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
  31:	8b 44 24 14          	mov    0x14(%rsp),%eax
  35:	83 c6 08             	add    $0x8,%esi
  38:	85 c0                	test   %eax,%eax
  3a:	75 d2                	jne    0xe
  3c:	8b 74 24 0c          	mov    0xc(%rsp),%esi

Code starting with the faulting instruction
===========================================
   0:	89 14 30             	mov    %edx,(%rax,%rsi,1)
   3:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
   7:	8b 44 24 14          	mov    0x14(%rsp),%eax
   b:	83 c6 08             	add    $0x8,%esi
   e:	85 c0                	test   %eax,%eax
  10:	75 d2                	jne    0xffffffffffffffe4
  12:	8b 74 24 0c          	mov    0xc(%rsp),%esi
[  172.712196][  T457] kill[457]: segfault at 565a1000 ip 00000000f7f70774 sp 00000000fff806a0 error 6 in libprocps.so.8.0.3[3774,f7f70000+a000] likely on CPU 1 (core 1, socket 0)
[ 172.716785][ T457] Code: 74 24 0c 89 ee 89 cd 8d b4 26 00 00 00 00 57 6a 01 6a 08 55 e8 7d fb ff ff 8b 54 24 24 8b 4c 24 28 83 c4 10 8b 83 20 0b 00 00 <89> 14 30 89 4c 30 04 8b 44 24 14 83 c6 08 85 c0 75 d2 8b 74 24 0c
All code
========
   0:	74 24                	je     0x26
   2:	0c 89                	or     $0x89,%al
   4:	ee                   	out    %al,(%dx)
   5:	89 cd                	mov    %ecx,%ebp
   7:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   e:	57                   	push   %rdi
   f:	6a 01                	pushq  $0x1
  11:	6a 08                	pushq  $0x8
  13:	55                   	push   %rbp
  14:	e8 7d fb ff ff       	callq  0xfffffffffffffb96
  19:	8b 54 24 24          	mov    0x24(%rsp),%edx
  1d:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  21:	83 c4 10             	add    $0x10,%esp
  24:	8b 83 20 0b 00 00    	mov    0xb20(%rbx),%eax
  2a:*	89 14 30             	mov    %edx,(%rax,%rsi,1)		<-- trapping instruction
  2d:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
  31:	8b 44 24 14          	mov    0x14(%rsp),%eax
  35:	83 c6 08             	add    $0x8,%esi
  38:	85 c0                	test   %eax,%eax
  3a:	75 d2                	jne    0xe
  3c:	8b 74 24 0c          	mov    0xc(%rsp),%esi

Code starting with the faulting instruction
===========================================
   0:	89 14 30             	mov    %edx,(%rax,%rsi,1)
   3:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
   7:	8b 44 24 14          	mov    0x14(%rsp),%eax
   b:	83 c6 08             	add    $0x8,%esi
   e:	85 c0                	test   %eax,%eax
  10:	75 d2                	jne    0xffffffffffffffe4
  12:	8b 74 24 0c          	mov    0xc(%rsp),%esi
[  174.021512][  T463] ps[463]: segfault at 565da000 ip 00000000f7ede774 sp 00000000fff285e0 error 6 in libprocps.so.8.0.3[3774,f7ede000+a000] likely on CPU 1 (core 1, socket 0)
[ 174.026251][ T463] Code: 74 24 0c 89 ee 89 cd 8d b4 26 00 00 00 00 57 6a 01 6a 08 55 e8 7d fb ff ff 8b 54 24 24 8b 4c 24 28 83 c4 10 8b 83 20 0b 00 00 <89> 14 30 89 4c 30 04 8b 44 24 14 83 c6 08 85 c0 75 d2 8b 74 24 0c
All code
========
   0:	74 24                	je     0x26
   2:	0c 89                	or     $0x89,%al
   4:	ee                   	out    %al,(%dx)
   5:	89 cd                	mov    %ecx,%ebp
   7:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   e:	57                   	push   %rdi
   f:	6a 01                	pushq  $0x1
  11:	6a 08                	pushq  $0x8
  13:	55                   	push   %rbp
  14:	e8 7d fb ff ff       	callq  0xfffffffffffffb96
  19:	8b 54 24 24          	mov    0x24(%rsp),%edx
  1d:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  21:	83 c4 10             	add    $0x10,%esp
  24:	8b 83 20 0b 00 00    	mov    0xb20(%rbx),%eax
  2a:*	89 14 30             	mov    %edx,(%rax,%rsi,1)		<-- trapping instruction
  2d:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
  31:	8b 44 24 14          	mov    0x14(%rsp),%eax
  35:	83 c6 08             	add    $0x8,%esi
  38:	85 c0                	test   %eax,%eax
  3a:	75 d2                	jne    0xe
  3c:	8b 74 24 0c          	mov    0xc(%rsp),%esi

Code starting with the faulting instruction
===========================================
   0:	89 14 30             	mov    %edx,(%rax,%rsi,1)
   3:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
   7:	8b 44 24 14          	mov    0x14(%rsp),%eax
   b:	83 c6 08             	add    $0x8,%esi
   e:	85 c0                	test   %eax,%eax
  10:	75 d2                	jne    0xffffffffffffffe4
  12:	8b 74 24 0c          	mov    0xc(%rsp),%esi
[  174.448659][  T236] is_virt=true
[  174.448714][  T236]
[  175.157784][  T238] Segmentation fault
[  175.157850][  T238]
[  175.163573][  T238] Segmentation fault
[  175.163622][  T238]
[  175.439350][  T471] kill[471]: segfault at 5657f000 ip 00000000f7f2c774 sp 00000000ffc71110 error 6 in libprocps.so.8.0.3[3774,f7f2c000+a000] likely on CPU 1 (core 1, socket 0)
[ 175.443889][ T471] Code: 74 24 0c 89 ee 89 cd 8d b4 26 00 00 00 00 57 6a 01 6a 08 55 e8 7d fb ff ff 8b 54 24 24 8b 4c 24 28 83 c4 10 8b 83 20 0b 00 00 <89> 14 30 89 4c 30 04 8b 44 24 14 83 c6 08 85 c0 75 d2 8b 74 24 0c
All code
========
   0:	74 24                	je     0x26
   2:	0c 89                	or     $0x89,%al
   4:	ee                   	out    %al,(%dx)
   5:	89 cd                	mov    %ecx,%ebp
   7:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   e:	57                   	push   %rdi
   f:	6a 01                	pushq  $0x1
  11:	6a 08                	pushq  $0x8
  13:	55                   	push   %rbp
  14:	e8 7d fb ff ff       	callq  0xfffffffffffffb96
  19:	8b 54 24 24          	mov    0x24(%rsp),%edx
  1d:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  21:	83 c4 10             	add    $0x10,%esp
  24:	8b 83 20 0b 00 00    	mov    0xb20(%rbx),%eax
  2a:*	89 14 30             	mov    %edx,(%rax,%rsi,1)		<-- trapping instruction
  2d:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
  31:	8b 44 24 14          	mov    0x14(%rsp),%eax
  35:	83 c6 08             	add    $0x8,%esi
  38:	85 c0                	test   %eax,%eax
  3a:	75 d2                	jne    0xe
  3c:	8b 74 24 0c          	mov    0xc(%rsp),%esi

Code starting with the faulting instruction
===========================================
   0:	89 14 30             	mov    %edx,(%rax,%rsi,1)
   3:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
   7:	8b 44 24 14          	mov    0x14(%rsp),%eax
   b:	83 c6 08             	add    $0x8,%esi
   e:	85 c0                	test   %eax,%eax
  10:	75 d2                	jne    0xffffffffffffffe4
  12:	8b 74 24 0c          	mov    0xc(%rsp),%esi
[  176.730643][  T236] lkp: kernel tainted state: 131072
[  176.730707][  T236]
[  177.388622][  T236] LKP: stdout: 221: Kernel tests: Boot OK!
[  177.388806][  T236]
[  177.573487][  T485] pgrep[485]: segfault at 565b5000 ip 00000000f7e99774 sp 00000000ff9741c0 error 6 in libprocps.so.8.0.3[3774,f7e99000+a000] likely on CPU 1 (core 1, socket 0)
[ 177.578143][ T485] Code: 74 24 0c 89 ee 89 cd 8d b4 26 00 00 00 00 57 6a 01 6a 08 55 e8 7d fb ff ff 8b 54 24 24 8b 4c 24 28 83 c4 10 8b 83 20 0b 00 00 <89> 14 30 89 4c 30 04 8b 44 24 14 83 c6 08 85 c0 75 d2 8b 74 24 0c
All code
========
   0:	74 24                	je     0x26
   2:	0c 89                	or     $0x89,%al
   4:	ee                   	out    %al,(%dx)
   5:	89 cd                	mov    %ecx,%ebp
   7:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   e:	57                   	push   %rdi
   f:	6a 01                	pushq  $0x1
  11:	6a 08                	pushq  $0x8
  13:	55                   	push   %rbp
  14:	e8 7d fb ff ff       	callq  0xfffffffffffffb96
  19:	8b 54 24 24          	mov    0x24(%rsp),%edx
  1d:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  21:	83 c4 10             	add    $0x10,%esp
  24:	8b 83 20 0b 00 00    	mov    0xb20(%rbx),%eax
  2a:*	89 14 30             	mov    %edx,(%rax,%rsi,1)		<-- trapping instruction
  2d:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
  31:	8b 44 24 14          	mov    0x14(%rsp),%eax
  35:	83 c6 08             	add    $0x8,%esi
  38:	85 c0                	test   %eax,%eax
  3a:	75 d2                	jne    0xe
  3c:	8b 74 24 0c          	mov    0xc(%rsp),%esi

Code starting with the faulting instruction
===========================================
   0:	89 14 30             	mov    %edx,(%rax,%rsi,1)
   3:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
   7:	8b 44 24 14          	mov    0x14(%rsp),%eax
   b:	83 c6 08             	add    $0x8,%esi
   e:	85 c0                	test   %eax,%eax
  10:	75 d2                	jne    0xffffffffffffffe4
  12:	8b 74 24 0c          	mov    0xc(%rsp),%esi
[  177.720110][  T487] ps[487]: segfault at 5668d000 ip 00000000f7f31774 sp 00000000ffd757e0 error 6 in libprocps.so.8.0.3[3774,f7f31000+a000] likely on CPU 1 (core 1, socket 0)
[ 177.724735][ T487] Code: 74 24 0c 89 ee 89 cd 8d b4 26 00 00 00 00 57 6a 01 6a 08 55 e8 7d fb ff ff 8b 54 24 24 8b 4c 24 28 83 c4 10 8b 83 20 0b 00 00 <89> 14 30 89 4c 30 04 8b 44 24 14 83 c6 08 85 c0 75 d2 8b 74 24 0c
All code
========
   0:	74 24                	je     0x26
   2:	0c 89                	or     $0x89,%al
   4:	ee                   	out    %al,(%dx)
   5:	89 cd                	mov    %ecx,%ebp
   7:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   e:	57                   	push   %rdi
   f:	6a 01                	pushq  $0x1
  11:	6a 08                	pushq  $0x8
  13:	55                   	push   %rbp
  14:	e8 7d fb ff ff       	callq  0xfffffffffffffb96
  19:	8b 54 24 24          	mov    0x24(%rsp),%edx
  1d:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  21:	83 c4 10             	add    $0x10,%esp
  24:	8b 83 20 0b 00 00    	mov    0xb20(%rbx),%eax
  2a:*	89 14 30             	mov    %edx,(%rax,%rsi,1)		<-- trapping instruction
  2d:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
  31:	8b 44 24 14          	mov    0x14(%rsp),%eax
  35:	83 c6 08             	add    $0x8,%esi
  38:	85 c0                	test   %eax,%eax
  3a:	75 d2                	jne    0xe
  3c:	8b 74 24 0c          	mov    0xc(%rsp),%esi

Code starting with the faulting instruction
===========================================
   0:	89 14 30             	mov    %edx,(%rax,%rsi,1)
   3:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
   7:	8b 44 24 14          	mov    0x14(%rsp),%eax
   b:	83 c6 08             	add    $0x8,%esi
   e:	85 c0                	test   %eax,%eax
  10:	75 d2                	jne    0xffffffffffffffe4
  12:	8b 74 24 0c          	mov    0xc(%rsp),%esi
[  179.252315][  T238] failed to kill background process	/tmp/lkp/pid-bg-proc-kmsg
[  179.252379][  T238]
[  179.256801][  T238] Segmentation fault
[  179.256847][  T238]
[  179.260181][  T238] Segmentation fault


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240808/202408082200.c3349d39-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


