Return-Path: <linux-fsdevel+bounces-10843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8D84EAB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD06B2EABB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E2C4F5F2;
	Thu,  8 Feb 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG90n0Jg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94364F1EE;
	Thu,  8 Feb 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428274; cv=fail; b=DOQthDcCaMKvZXKOEPwfjwg312ixuc5LLWnbeMt8S+agvZab9zfz2zqfMJ4YCKJF124YJgJxCpMELpaYuUGTYHcOUZf+wtTA1f0YpibeVttwjv7fCoa6zehoXLqV1N+cCPVu1D/36PAP0JZcIGLRceWVugHh7npo0CGbjW9Jaac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428274; c=relaxed/simple;
	bh=FO38my4m3MNo0nqERvvKqRbFW4pKi6a55LnVMFIUBRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n7pQ8Re2sTPvfWO8PFCWgx5fWJ5gXuOcKT9SI4PGnyDEwaZ1UZSbsOLMlPqXlkAZNb6RkEBcJeIw6RFQy481cDLfz9SBGUcbr3xcA2Bt+4VO3XoU0LUz3Qt4jSEzCqpZg8KtkEmhf/xIChX03103Sn03J6mJZEBcwPXdG6erKYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LG90n0Jg; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707428273; x=1738964273;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FO38my4m3MNo0nqERvvKqRbFW4pKi6a55LnVMFIUBRk=;
  b=LG90n0Jg9kT86Hwr0uVSFo2Wh8FDGltYBCaVylI+L2lTy/KxECiu3ZLs
   D9Es7aYFPoh3vws5qcMXro6EFvaaT0v/D+oFWCEzZ9X2Y38SPZLr8/nwx
   tWikPitW2om0FleJQjVi13kWIA7cVfUDc4j+oBUSOQYfUFrpKQEQ8ep6V
   i2hBp9n5dl5gRT6jWKPJx9V+1Ebp5FP13XO0z2ukde3KBSWHwwBxLTy+F
   Te9oTgLnqzFToo5V6Iq+kfgZAZ7198wdRn7+K63Dxs+UOgOL5Qcw/MwML
   lAcbnFBPMkwtiJLLVrn7Ebn+7ci3LXxjXaxZ5znfKSJUjyDYWjHlD9dS5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1620541"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1620541"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6387644"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:37:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:37:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:37:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:37:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgDEZraJrQ1VAEh+902Ro7WKUL7c5UQdaDIfRTaCxD7KRvdymIDR1DzjqS4iCPEJtVN70gjfBR33Wrq18D4MsOJHHIgu5sDdnWfi/f1pdwq0TxD4UWbShLDVypsDYNdxk5ypbgDQYBNVuSKF9jLLNm3V7PwIiFUjaAydUOtDXuA5PeElhxxyVnUl/Jy76gwg890/th8VDaxl/0kSfkaCm8NMAg/ybw8LeHZWv/mHtVf70K+zYDM0s21Ytw5nYGGVkLT1rKg12tplEqWfwz1FUoUCzSjmmDBIaemnQ7EYRK1HO8UbngedFCIWChDmNRaURasC5r0iBOWblejk4Uu0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poEo0ltpYdoDxI1G9ZBivjHiPzfpz1mq1AuWxclYSqE=;
 b=dI09JqhqcMTFA2gV4iJzWTvJycoAcg8BrxqCtrM2c81xEV/C5YE1qvpoEOW+xtnc/uv16zZV2p9qQcqWhBDloggNCTehN92Z+w2dfVkWN59A0EukEHvqUWhlbxmunD/DIhmTIYEpzjeZ08igCZuZLt8pPaPhExVThHpaIw6YaQUCslhOe6c+rEj1YnNvD6q4jvtozLEpzCMx20bHuu2skTYNf5++fy10/Eo1YU9Ss7PvrrZUfzMxRRCSzH8AT0q26YjYWMO0FBQkwvv/po+BZ6a1KzTwrAWvUxy5/qi5kAcf+GZhMP8L6km9QEdMHkee6yO74IHp/58y114n4f4zwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 21:37:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 21:37:49 +0000
Date: Thu, 8 Feb 2024 13:37:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
	<linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <linux-s390@vger.kernel.org>, Alasdair Kergon
	<agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>
Subject: RE: [PATCH v4 05/12] virtio: Treat alloc_dax() -EOPNOTSUPP failure
 as non-fatal
Message-ID: <65c549aa701cb_afa42943d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-6-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208184913.484340-6-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:303:86::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c080037-6626-4b2c-b158-08dc28ee328d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+AeLm8L71hvh40J9MTFmferGjzrKZ5Ti6Dq3Mx59DmGLByJY6i84PZ0cv3OpRjoxhZkXFThHDiRdMX6ww41gElnHEmsCFm7xjI+DEO7xSj9BLp1U2xRNwrdAJy1VaD8bwVfr9rNqhSsQGvSOIUyZED6kgS/FTGf04aoArAA3SXQ1YDmciwdrrqfAvBydcukuywEPHculfKBCKfWjaGO8frvnmm2JQQXaR/KSI8/8PFHPnepD+kXq//gr6sOovj2T6pXBnN8Kt0OePhjrhk1vrLgOCSOFadGfPvzccR+Ww7T9PEG9doByS0wnxReHo5FObl0nztmmfteI7B8St51tuxkI8UvlZfMPpx1jW7mSaytH5f6LQsgedTPnhjjcvOS9RFAbBl+RyAGKtJ/D3eoC0cWkO9WB7TkIV8Pv9QfA031DotFEPa4wIKoUYmmC89/I7WoJ9/p1jSPkiCpzsCmiO8RnFYhMAK3Ptc+FJwx0eY1eXxFt5GY4bq7+0XP5bHJQonQVHvsk82MibEJcrv5566Ovka1ST0HeAS6xchO/IAB4nPc8f3hZtHISLlaw7GF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6486002)(478600001)(9686003)(6512007)(26005)(2906002)(66946007)(5660300002)(7416002)(110136005)(66556008)(54906003)(83380400001)(66476007)(8676002)(8936002)(316002)(86362001)(4326008)(82960400001)(38100700002)(6666004)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PxebArmx3FaRa8AEFKB4ae6QibrEI73EJPI8j5kOA3sOkcQZTyfLcc8wgChS?=
 =?us-ascii?Q?WnxqkngjUIbQD0XKNlQvLs7B69jv1+w7KPJTvmfU3OZE331SPSMC5ID2QOpO?=
 =?us-ascii?Q?DGRbbVKjbusS/G8ga3EgEqq+YuIfYTUlTm8vR+OtdZ0Xrkc/cSk2GxTjn9kW?=
 =?us-ascii?Q?EI0PgSwteme0GzCI201y/zDrc4INqQ7F/R45XhBUc82wvEYgISH4ReFSXCpk?=
 =?us-ascii?Q?Y1qeUoWt4Jn+HtlXhJMEfyC52kePRCH1hDcQ2Xvw+JBMBGSLb2jtmPYYf4C+?=
 =?us-ascii?Q?ZeIF9HOjSeJ2dfZACX9HMu14ChRZQXNFFwREWiJ0Z3N1f0MGA17NzAfOskJw?=
 =?us-ascii?Q?Np+nOw1Y9uG5G5Guiqxr0AHwbY3rN+1W1i9Lthz+AEj3GgIrz7ws8I15cT2C?=
 =?us-ascii?Q?DyyKb8Gf/+kz86jP2azKW6G0S4GBt9Z30yXHHSMy3G3hXw3RHyRC90j6dFMi?=
 =?us-ascii?Q?46/JWPo/rXkvFe+YQQweNkX0BKU6JgVxAjjkiZOfH0Pbnz6zYXLcR3X/t8pL?=
 =?us-ascii?Q?0xD9GSRHKQQ5RFJPOc+g4XH257bjQ2L/EkKQVKrW+XQuG8oHIPysY4JEVnsf?=
 =?us-ascii?Q?utvhWsuf/0CkDIX2S42iB31yPAx1z/jG6Jm+bg2sb/Kh2KoMRunm1i3BZ7hi?=
 =?us-ascii?Q?0RgImjYQ+brthKvJ67BRnd3rkPeNTSh7IAju2zCfo+izlTjMBeBYRBzjSrBu?=
 =?us-ascii?Q?jjzJr7YEMLsrxGBQdbO6kbvXX2VJwAJXZziKp9+jH6UYZedRLc+VYaEuD56j?=
 =?us-ascii?Q?IO1YUmdnKDuaogRNXkVqiu1l0lDGGp/DuhBu4XqUi5PGCCBXlBQ96L5fJS5W?=
 =?us-ascii?Q?M2DMdbCv98FPZlI1VfRxF0pZb5dGeEskx9q5mhM9yKHVohlSJzpmp3DVngea?=
 =?us-ascii?Q?xwNwhCb6Cs2tS0zlYwmr5q4TJ+lmoHctcNQLr0XZwL2CVI84jbzpN6Az+tvb?=
 =?us-ascii?Q?UD9AbQ9Uykdpgt3rVV+8fgZH6HwZz+HI5pERVLTxlp2U3DrRXnz1qIi1rwnY?=
 =?us-ascii?Q?2D+kZHy0xHajTXSLT00B4reixVgS95q/BvQ6Ny2ODLlUrQVzGEmShkK8/9UQ?=
 =?us-ascii?Q?IjcaXH80qm8zr5tF75deBgPG0Oi466xe2S74b4/fOi6UczAHBFo4cR4ot7Ch?=
 =?us-ascii?Q?q+nc23ro9fPAcXSOGz1dsNZxkSg0Vq01g91fjmJyScYCkig6lwBtCzuh18bu?=
 =?us-ascii?Q?MjT6cH4h3ncQS8sRClVA3UbrzjfI7rpKaqfkDfC1wrtmX3sxLb5DlupPYCVz?=
 =?us-ascii?Q?fLWbN21KF+Pd2cpt0wNaoDzei5R7bjzWFZC8vuL2N1iJnMF4tJdcI1S9C339?=
 =?us-ascii?Q?ZcZ26CP8MI6Au2CqMBFRvJBhRYh8GGJGmTlZNSWRB8cdcTok3qxQPMcldrLS?=
 =?us-ascii?Q?Ep8l+dotmeXXbMdL1QQtIhTa+H8b2/dzmNwH1ax4J33xTQjb0zuF/x6CRJm2?=
 =?us-ascii?Q?IE1JOnaLz7oHHHyKCamjdUHBu5QFtlUrtdg+/mhlcJ1tP+2ovaRl0T2OgPqO?=
 =?us-ascii?Q?AgLAThVqzLSZRYyOaZGPm1E8kBf0kapXTn7tQlufMt2vpieCrZ0kNPurnHLo?=
 =?us-ascii?Q?pSmjanaNMKhLGIuv4S/9l68dB7Svtu5pArKxvRqmYpUstRAc+cTR1a3v5hOm?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c080037-6626-4b2c-b158-08dc28ee328d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:37:49.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRCDhrFc+cmfPRXT/OwsfIflxsixqxAlO0F4NPAceWmVbu3S6l1UtYyupUcNqKmWy3CXC8diP3q6XMl8Vmstzt8u1lzYzFLeXt0jfH22JYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> In preparation for checking whether the architecture has data cache
> aliasing within alloc_dax(), modify the error handling of virtio
> virtio_fs_setup_dax() to treat alloc_dax() -EOPNOTSUPP failure as
> non-fatal.
> 
> For the transition, consider that alloc_dax() returning NULL is the
> same as returning -EOPNOTSUPP.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-xfs@vger.kernel.org
> Cc: dm-devel@lists.linux.dev
> Cc: nvdimm@lists.linux.dev
> ---
>  fs/fuse/virtio_fs.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 5f1be1da92ce..621b1bca2d55 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -16,6 +16,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  #include <linux/highmem.h>
> +#include <linux/cleanup.h>
>  #include <linux/uio.h>
>  #include "fuse_i.h"
>  
> @@ -795,8 +796,11 @@ static void virtio_fs_cleanup_dax(void *data)
>  	put_dax(dax_dev);
>  }
>  
> +DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))

This IS_ERR_OR_NULL is ok because dax_dev is initialized to NULL, but
maybe this could just be IS_ERR() and then initialize @dax_dev to
ERR_PTR(-EOPNOTSUPP)?

