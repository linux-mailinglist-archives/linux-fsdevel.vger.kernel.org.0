Return-Path: <linux-fsdevel+bounces-33239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018DF9B5BF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CFE281234
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DA197A7C;
	Wed, 30 Oct 2024 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MA0M7HV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EF13CF82
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270752; cv=fail; b=noXZtUp9oQvgAUSF3M3IcjSiMeYCZDWTk0Mok0kJFQ6tKQ32lPS+f3ON89U2NBrSLg71YH64m48uPUXDnpN7mAVfoj1vupqLzU7HRHUpaOy0NhVC8mnB9yhSoXIJom/6U7PsHNWYFqsXIHTnwVZ6NW+hSSkM1i1xw5YoQxF38Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270752; c=relaxed/simple;
	bh=IZzml8KKRrgmpU8uBExfKVgBq3T03ewMXlyMJ7vd5Dw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bL3JDxRjP0uNnQnWrLTEBXwWEQTGYKupbpnoO5g511WrHR28IEvEGVB5hAnJ32GgZiKaIYNLxMdI2t9SxE7oJ+l6MDmWF2m0020RwX7c0D+X4ZddPn+JPmbJ5DwM1gqzeyVRt/Xqru0JoZMu/b8+HXijEtBU/B9JHZoRbiisIw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MA0M7HV4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730270750; x=1761806750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IZzml8KKRrgmpU8uBExfKVgBq3T03ewMXlyMJ7vd5Dw=;
  b=MA0M7HV4GNQcaxpCYNZGzsT3gWaAGCC0O/IdMJ78nMXuEXyl6BgaCgzm
   LqsAr5w2aGBvhELy0KBYSFfG0KbyMPZzRXlLm1c0sVVR+p0MX3Pwenjto
   XUCql7p0Pt/dHBPYb7uDIZT/zHcPNU65npDBdx68cF6HAO3HDOVvZ5ztV
   8mVko7+Q/S9MtzF2Nh3LkjLsVOc/G5d3hhTsy3SYS2i5Pvlxl9cn4imzi
   SvdPphetMEeypNCidzaoeTgledvrRlTg/vaU+Iznhk2HgE6wA1uyrHLJC
   63ukUoo/uuKJXMo92/Lh6hNIe2q3Cc9BK7LXvT+Z61zXW0X68u8B0MmSe
   Q==;
X-CSE-ConnectionGUID: EAA+4Q9NTOeoG39HosoumA==
X-CSE-MsgGUID: FbW81XFoQbWRWHUG7ACbmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29375358"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="29375358"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 23:45:47 -0700
X-CSE-ConnectionGUID: b4h0dKK4TamY+aNs/isUJQ==
X-CSE-MsgGUID: lV4G1YAOTTy8TVjJ+e6taw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82536110"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 23:45:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 23:45:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 23:45:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 23:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub5iHwUk64KGCW1ecB4T2ff5+gEPTU6sMFZ3EBYfHfavpguYs1ZFI5eBUxvg0+AtwzkD7XjI1yBG09M2O3EYIF0mTqLZrIZvLtWaNApFgkOQN1rzGaS/xmFB+brne0jnT3Z8x+JPbLSsUVB8mZf1NDCvhNYL1leoLifdwXCPxnX5WJxYKoRbCjbZgr0/WhnSVNvec9tr2lOQjZfUO3qCFC7SIRhe5mG03e00pAN98mZPiTJof8GV6OSdsEEC3sSFq2dksLGWkRFhaJYQiJ6iyTHDWaS6JgE8E8tuRV687zzv0TKQT3/9nBz+TQ0+sKOmt/O6uds5o4LtYKv5FdcyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4IilFGHcbx4P8+0/TWtYMnARla7LJrhIxSb7z0mOdk=;
 b=dEcGRBxy++/+soEJXAFm94r4OlIETglcryOL9YLZW+DhJ6HuaeUezLsPL8wMfoeOCRD2K+KlGpYcEt17FMVF4U606hoBTKox8noKzy0kHdwblNwS5BQ3n+YYhSa5TZW26VndYOyKSyew+SSu0VXxnZg6rsl+KGMX6j0/XHhGgFSdwhNgJqZ/xMIFmi3fZoBS1RYD4wV5seiJoIYZkpgQkxQogU+RyGBtcrBQYeY5/hhyxUUMaT02I9bQ1/5T9P+oMjFbWOQN98WF2XuRUky5eyyLM7y6vunC17td5Zffz7oRlwcWkLZeJMYBx8KnCmo7W4yeLyS68SqoWAE+XLb3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:45:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 06:45:39 +0000
Date: Wed, 30 Oct 2024 14:45:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:fs-next] [fs]  0eccf222d7:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_SMP_KASAN_PTI
Message-ID: <202410301313.50e4d05c-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f531d9-fc0a-445f-3180-08dcf8ae7755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Vm7bhC59T0Ub2quzfq0tY5sneW0wD3uem9JTbmBswM7MvBmURyR9lEucysP?=
 =?us-ascii?Q?PGadUWOZ//C1l/JV92Phubdrf3ZW8Y5zMvmj13FeRbSjtFh2/qiCODzDoLW6?=
 =?us-ascii?Q?x8x3kNEHeCetIc+ugGzk7s7n2QtEqSGhpgv4/onRxTGebj4AAzjFUkiZ2nYc?=
 =?us-ascii?Q?C1j6xCpnDTowldm0qd5XMABCVzgwipOc3J1QORwx8BTu1ZA7uAWVT5zHEtMU?=
 =?us-ascii?Q?E2RmzE2UrRbDPbAVID3aGx3PI0er/4hhbKLDoKPksFKrZUbuB9t5zAjlepfs?=
 =?us-ascii?Q?IMXQeSE9JJG/sjkSaonBlcRR6AUcgTfp1ou119mCCjd5jz5mvD/yVs7YmhA5?=
 =?us-ascii?Q?YX145lAXnOqvjIB0aqwtBmLFAr4Nfb/GhNvIoNyXMPt9IQu/sec4AnOE+nz2?=
 =?us-ascii?Q?0UqS4mhthrZyN8YRSxGrfxxpXPT+0xJ62f9PzmmNA9lKeK5sGDvTMCx/U8wb?=
 =?us-ascii?Q?26VrMkssDPeZicdowVwcgy307xMSmbZWzXjDFL/JO2+am6nx6H7FHPDznd2V?=
 =?us-ascii?Q?ZP35/x5a8Tg797gy3jrz63Y51S7qHu4xtMaN+sf20sjr+sQnMiA6kiuBKZkS?=
 =?us-ascii?Q?K81ymBPKGdq5y84udZkbLhjEBxs867cE9Q/Gn/hIiGtZEUBMKufxFXqQdRue?=
 =?us-ascii?Q?+kAGjffJi5jp8gV6IvKfqVaifL7bOUa2zB+0oVybhyTfAYFkzQtv62IeW6Cr?=
 =?us-ascii?Q?vdNWJLwunwRXzTaBLG6a43dT/ZyjtyXqSVqns8HY7mUIDiuydS20I0VWxqXV?=
 =?us-ascii?Q?Sry41G8mDfAVJEzP4jEpG9+wajAFwluLlYtwLL4Upby07BLuMPhUcBagWtXK?=
 =?us-ascii?Q?feRYN4/zLdwrtJn2XKFk7cZvVhmys0/oZP5wiXbW9QLtt+jF1z1cp3WB+L+e?=
 =?us-ascii?Q?T1kq6AD2J5b0hYHYkzeduea7G0oRh6YZmBMKtee7LkdD2K1EytPr2y54H/9t?=
 =?us-ascii?Q?JqaxtbbgrragMIrOsI9y7Yg5u+bAVqzBVUey6Kjh+jpzrdRa5GOtmwCYk/Jq?=
 =?us-ascii?Q?PzZ3d51AMm3CBDLvx3DRoKUgfaq8puQs+3OxHEX2tno6K1zegBD42pyatiVV?=
 =?us-ascii?Q?COxwf3Ml3797zXlEiqLOaUmw9DQkHmBFvZgBRCULQlg8IuVeo2Vl9cWq5hrS?=
 =?us-ascii?Q?bNpsWYgdiDXiGqM4TUKxfg9JQCeT9AJ2OFfE6LAiw63HQW6hzMIxd3h/uSSZ?=
 =?us-ascii?Q?mUci7odSYyCSChcMlB3jX+eYbSQ0ZhJvaLMXr0CxBwAu5h22Eme5kJle+207?=
 =?us-ascii?Q?1mgJlDrwTtt6K6S4UYdFwWlv8sncvC2yCBJqIpI4Pg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14VbFEJjVIYm633hXYooXjGxWm++OowUZ+VARO0Lui9y/6Xnr4nYdL8e3Z6/?=
 =?us-ascii?Q?3035Vz1I23YLfINDWeyvLNdsnwIUgS7+vUp5LZxE6wHzWlWrFGNtRIbWka6i?=
 =?us-ascii?Q?4SZO++h1ej7DRESw1H1vZoGZcN7oxOBdpVVZD96JpW5l6heC6yIadAwTr6ao?=
 =?us-ascii?Q?JCWnkOE4VqHt1v44Hs3lLkVd4Dhyjm9oQTCXbjPmnf9JzIUP3ORrztwK7JUD?=
 =?us-ascii?Q?IZiEh9swgq+V7FbRJk6q0tSBU+DJRvNc01fm26lNRnJoMXcqf0FnLxnn+lck?=
 =?us-ascii?Q?JJ1/shCTk8EnyvX6FEnYVRqm1FKHaEDwOZb2KSHFYxEpzrnRRiM3h0mx+6Rg?=
 =?us-ascii?Q?6q19zN/xsiebiOGsgoisiM/LHjW45rxZfB7kTPwBfFQ4CgDdCx6HHsuvzZlF?=
 =?us-ascii?Q?/c3TihSllvUFMRWBv2Ra7tJvww3FUvSNIe5YOBelc1R2UxDfx8KESZA9Wj+u?=
 =?us-ascii?Q?HPEe2mKvtDeLZFI8TveG/+jeSQ9CytEUht250ZHbnXedotEWRJnDTLV/RX/k?=
 =?us-ascii?Q?5Zv+k7xVm/qJLs++ZG4ANhBK0rcmi5KbJgevL97oEBXQXf6BuxNuTFLLoc0R?=
 =?us-ascii?Q?+q2SEPmbha0JN/6nspivwV9anmwuZ7gloogc51PkcwU78++9jhRljh2KVGJU?=
 =?us-ascii?Q?osALqxg01E+IVK10tOcp3qTsCepW3PNdnu9Who1b3XjGO814fNt7MnBDxX4S?=
 =?us-ascii?Q?+HX/wNeHBNb9VStBnvKgACurXRy1I04tJPw7BYSPzU+thH0pJbDJ3AXSQnN/?=
 =?us-ascii?Q?kZV1IKQ25K/+cNA8T171WE4lueMVQtNyX18gPu3eKlFvClxXr7VCp4NfI61b?=
 =?us-ascii?Q?ga7qMHhhzUTVWiOH+ljypTHbqByozY4lrFKJcfFWJ5tlDhH8ZdHkHe2sR6xD?=
 =?us-ascii?Q?TuW+aHP1JrUT0SNo8i17nLX/6XGs0K2oAydJUC59fz/GN2jSsfBbNI5OJsqz?=
 =?us-ascii?Q?I7cqNN5lJdl7w3d2lNzBsv/YuVCoClxX9+V7XFUEbu9uieEtKVYaHK5I4jzV?=
 =?us-ascii?Q?QZKaJxcKEbuoZKv/shfHlO9Z5D3q0i9YB8MG6UeFlxMv8qJSM3+3o46ON0n8?=
 =?us-ascii?Q?Jv0phNndGrEILnilUjgtfgUNiQ2INBG0ibZDOUMeTPfsveeuaL3ya1bz4QyS?=
 =?us-ascii?Q?4FDi87xLMAcRmlsQpP+PIvNcPEeGLg5aXiy5jR6saV1xSI+zTz+DggR7snDP?=
 =?us-ascii?Q?0E7xc8vJHu7nlXSPe12ecK7jjsKtBozSqjimCM3vKIo+ufDTsDsHneyVHTg9?=
 =?us-ascii?Q?1uDE40LWeqU5FlbWZ6C2se4zfW8PQJssY1IBoxVc59NioxYYeJaE28eUgc04?=
 =?us-ascii?Q?gUbPA+B6rLV1R6dK3ET6oH2dlQlxA4aRX8bVWnqU31Y784xvhMWEWWqPuJnN?=
 =?us-ascii?Q?O4MBwU5KB1DEmNTXWK4Hgk0zLHMs2Jkjg5hvwZNv7s/4COjuHt69dqQmUy9R?=
 =?us-ascii?Q?mIQYM0mZADMLUSlvKu9cC9CwAIR+mQxDewh2piKSYb00M3y23/C4NZ/vlV6Y?=
 =?us-ascii?Q?SMag4Uf8z5aDHexnLzvqeS5Yp/lk7lV9JlibRrAV9PZ2YKxJEigRLtL4XEnl?=
 =?us-ascii?Q?9bNZtev2BQtfe7tNtZtNoYiJPOshREE51S8tGyEWlIEnFEFsrgDJ7Mmn60DP?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f531d9-fc0a-445f-3180-08dcf8ae7755
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:45:39.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +snYK1n8OI4g+6AK6HAx2PSYYLMY6dvOjmb8Qj7GK12GHLwRf95WQrFEQXvH4zBuxsXdsxzHpMQJjWJ9yl9azQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-OriginatorOrg: intel.com



Hello,

for this commit but in linux-next/fs-next branch, we notice crash issue in
vm/booting tests

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_SMP_KASAN_PTI" on:

commit: 0eccf222d798166ce42a4ed0da91a0cb14945c7a ("fs: port files to file_ref")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git fs-next

in testcase: boot

config: x86_64-rhel-8.3-kselftests
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------------------+------------+------------+
|                                                                                              | 08ef26ea9a | 0eccf222d7 |
+----------------------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                               | 18         | 0          |
| boot_failures                                                                                | 0          | 18         |
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_SMP_KASAN_PTI | 0          | 18         |
| KASAN:null-ptr-deref_in_range[#-#]                                                           | 0          | 18         |
| RIP:hook_file_free_security                                                                  | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception                                                     | 0          | 18         |
+----------------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410301313.50e4d05c-oliver.sang@intel.com


[    3.605271][    T1] pci_bus 0000:00: resource 8 [mem 0x440000000-0x4bfffffff window]
[    3.608369][    T1] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    3.609815][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    3.611533][    T1] PCI: CLS 0 bytes, default 64
[    3.615146][   T30] Trying to unpack rootfs image as initramfs...
[    3.622946][    T9] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
[    3.623645][    T9] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
[    3.623645][    T9] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-rc2-00003-g0eccf222d798 #1
[    3.623645][    T9] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    3.623645][    T9] Workqueue: events delayed_fput
[ 3.623645][ T9] RIP: 0010:hook_file_free_security (kbuild/src/consumer/security/landlock/fs.c:1662) 
[ 3.623645][ T9] Code: b6 14 11 38 d0 7c 04 84 d2 75 2f 48 63 05 21 1f ae 02 48 01 c3 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1f 48 8b 7b 08 5b e9 25 d1 ff ff 48 c7 c7 e4 0c a1
All code
========
   0:	b6 14                	mov    $0x14,%dh
   2:	11 38                	adc    %edi,(%rax)
   4:	d0 7c 04 84          	sarb   -0x7c(%rsp,%rax,1)
   8:	d2 75 2f             	shlb   %cl,0x2f(%rbp)
   b:	48 63 05 21 1f ae 02 	movslq 0x2ae1f21(%rip),%rax        # 0x2ae1f33
  12:	48 01 c3             	add    %rax,%rbx
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df 
  1f:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	75 1f                	jne    0x4f
  30:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  34:	5b                   	pop    %rbx
  35:	e9 25 d1 ff ff       	jmpq   0xffffffffffffd15f
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	c7                   	(bad)  
  3d:	e4 0c                	in     $0xc,%al
  3f:	a1                   	.byte 0xa1

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	75 1f                	jne    0x25
   6:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
   a:	5b                   	pop    %rbx
   b:	e9 25 d1 ff ff       	jmpq   0xffffffffffffd135
  10:	48                   	rex.W
  11:	c7                   	.byte 0xc7
  12:	c7                   	(bad)  
  13:	e4 0c                	in     $0xc,%al
  15:	a1                   	.byte 0xa1
[    3.623645][    T9] RSP: 0000:ffffc9000009fc38 EFLAGS: 00010202
[    3.623645][    T9] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffffffff414219c
[    3.623645][    T9] RDX: 0000000000000001 RSI: ffffffffa11601e0 RDI: 0000000000000008
[    3.623645][    T9] RBP: ffff888100438bf8 R08: ffffffff9d900c82 R09: fffffbfff4398cdc
[    3.623645][    T9] R10: ffffffffa1cc66e7 R11: ffffffffa30a4960 R12: 0000000000000000
[    3.623645][    T9] R13: ffff88810627a240 R14: ffff88810627a228 R15: ffff88810627a1c0
[    3.623645][    T9] FS:  0000000000000000(0000) GS:ffff8883aee00000(0000) knlGS:0000000000000000
[    3.623645][    T9] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.623645][    T9] CR2: ffff88843ffff000 CR3: 000000021e27e000 CR4: 00000000000406f0
[    3.623645][    T9] Call Trace:
[    3.623645][    T9]  <TASK>
[ 3.623645][ T9] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 3.623645][ T9] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751 kbuild/src/consumer/arch/x86/kernel/traps.c:693) 
[ 3.623645][ T9] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:617) 
[ 3.623645][ T9] ? mntput_no_expire (kbuild/src/consumer/include/linux/rcupdate.h:347 kbuild/src/consumer/include/linux/rcupdate.h:880 kbuild/src/consumer/fs/namespace.c:1411) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241030/202410301313.50e4d05c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


