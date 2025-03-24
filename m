Return-Path: <linux-fsdevel+bounces-44858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4209BA6D5A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 09:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0DF7A4305
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D0D25D1E8;
	Mon, 24 Mar 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkBhiqlt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CE25C6FE;
	Mon, 24 Mar 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803210; cv=fail; b=L4PTHO99aAdBIrvN2/syRmpkX2fJRryNSKVaq6yvEfDehV/8XGpMgSrWUbRoqsL5FQG22cnLqKV200Riko1ctFAzBppdJDbZkcIuxjC1/sDkw9cErS3L5rsdDWFZV62cCDiPXesY0sx3WojoIgl/gCw9j68FjXdh5YwPbI3uj20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803210; c=relaxed/simple;
	bh=vWqDxhhhY3x9w4R2sOboWjmhHLWCoD+pRb8FUqY29o8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=t9kzJASYb+q3yXDumR3oTMiT3rRd1e47vHKg+v02P5/I7JJskgWZxOk98VIoJ8pf0b3Vl3bMBB/+LfZYTRINmKgMN1GtaklJE+H3uHR5H9fEVIkY1Hjvfttgim0BsHiEPXCSs/+/j7luK+yEcH1b//b/Krah50HgV5nq7BM2rNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkBhiqlt; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742803209; x=1774339209;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=vWqDxhhhY3x9w4R2sOboWjmhHLWCoD+pRb8FUqY29o8=;
  b=hkBhiqltqV9t+x3gCxQExU7JMucdt6GhJHZjgiO5LmZ0Kyole2b6fowA
   1yrMd/GbrDZ837w2fbeh2KMzZWnWqgkuefyKpXOrfAlsbOZhJ0oMvH4LZ
   amDAq3MjpI3GEXcMK4xTMCwJXwkrHvDxMPM4WdkMyH3gwsP5guxMM43JW
   dsbq+EWM2Nc53YL5ZL0DoywadgX5Fal4pyz6VIO2dH4VkofuI+f9IWNBT
   HElaflDqQyJZ3sXZ+5W8GF1aB0hAQe7/XcMFNRe9TYMtLkX4jwTDudKph
   0aCP6Q3IKE0ZLcj4jQX5h0rIWYNnKHfkic+O6+n8kjzFBz1Kf8j551qHP
   g==;
X-CSE-ConnectionGUID: cxnfHeQ8Txua7Sp3CtpZYg==
X-CSE-MsgGUID: 4ac0egXTTI2u6zPvZ3v+ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="47648786"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="47648786"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 01:00:08 -0700
X-CSE-ConnectionGUID: uSzzPjHSSjKfandwyW9KlA==
X-CSE-MsgGUID: CfrxVZ13Q++u07ZUMfrxgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="161208436"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 01:00:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 01:00:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 01:00:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 01:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLOBDJJkSjr6jAOQOYCVLZhvDWF5ooxh4b8vpn/ldEoWRpmBu57Eqzl4bZs/Fc56BrufzX+8q6N2zMmWaEHvuCKuuiTAGNXIBMjd7FwU0gl6n1vkrNuN7R071FRqORn5cqcLeBLcYn2fc6tF3EcUj/0jWKO9TOgNBpo6sGVOHNfMaECi4K7up9i5Tds+T14JdHPQSEimmxFuEXOb4/XFiXyFGotZarQZpVtOB4jXR24vp7Zih+GYcMzjRvDfFlce91cElzRWJ86yl+/yQn8kiR7nj9fUz0gjXf9fTePnh4cKL4D0tJ/QQiR+hjClRz8/Dm04YZizKJcVHj1ztVhAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8lXlakD0pvkMui99lO0H3HyfK7G49DdakQtqUKmF/A=;
 b=SwS/osxcR91+K1AuoSKMEydlhDDwLHySaSsqHftZ2CpUwbyK3hUUKs74tyZpuMoYcMdKKrSbeKoIowHd/qYzsxfnVFSRvvYIG1hltVaa64SXige7iPSRkKMcw3kcuDrtEoS4a8oFE42FGURl95OFGxIjgE3qTtVippVIIBiQ2+FjOkYJZThuMca7g9dH0uBiieVk3pQkERXs1ifDD1ucY3nIHJWFnjNrO5q9RQ9Lc/GyBH3b4yx6MyDt2r3hb34BWPfxi0JN+K9kqqf/doMWJATrNApPNkFaBCr6Pdc5K5VX2AqeRfZP/zXliMyrBFdJyC3P4hylpgHavOBOrzTGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:00:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:00:02 +0000
Date: Mon, 24 Mar 2025 15:59:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jeff Layton
	<jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [dhowells-fs:ceph-iter] [netfs]  dcd7ee9385:
 refcount_t:underflow;use-after-free
Message-ID: <202503241538.c2138272-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 270a38aa-7777-4adb-8d7b-08dd6aa9e1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NeKWWqCIRQ3hU23PuvMdLLlftOCj+P0Sxrwa2j5rPRb3wCI8YzYdnjZlDdyU?=
 =?us-ascii?Q?uunNSZpDbbAQbSQx2H4RXmm3XCS3r3DXcSGr5lyLZyTSeC3d2rv8vqGfOghs?=
 =?us-ascii?Q?DA2zIf6e9Z5n6zFdnhVW2CkkFiHsvC9/ku/RMWS423IE4uSjkl01m92rO+9y?=
 =?us-ascii?Q?hCQryU0ILOzPvnZWqxUqEFiNcz8bYkaqeMHt7XNx/bSt0KPrA8JVJ/Yh/vj4?=
 =?us-ascii?Q?CtzAbqPwzCbwIIqN1OtBTrTqfA/n4h2JWCWld/IAUI7PIBrYoTW3gtZtGXhH?=
 =?us-ascii?Q?GG56JepDAbF2UlPcCrD9mrGriwYCHy23SvoyFLFrM6rUzGdCal6GL1Pmftk0?=
 =?us-ascii?Q?laGy3LXgXl/mEv2QJ9P5/brkekpcB731lUy/iijORLRDgl03hDlcBTeEFszg?=
 =?us-ascii?Q?uohPPsAII37eGxGF164JDloeDElw/lCIFI08MIOMIfJBRvWoGLYAD4XrSRXs?=
 =?us-ascii?Q?Pfhqxp59fTSFYOTfP6IQU9Guw23iaZVX1y4SaQtDosJxfXh/CdMfQX9ZN2lM?=
 =?us-ascii?Q?PXcPdZ6M/hoRi9SOrCini2dWYaggrJ66V588b+JZwv8NiEy4kCgd14N3EaE9?=
 =?us-ascii?Q?9gujMMPfRJw1i6uJNN7Ir/qEaEKXqZpxfuZ6D5uhDeR/bY3rkmKVpXsmU54R?=
 =?us-ascii?Q?GY1pJnMj2RGMqBSNNU2uaUSciIef8Pqus0itwDPFlv5CAzqpB18SFBJDxREk?=
 =?us-ascii?Q?YdjoeJHKjGO6m/y3XbfxhkGo/I4Vyuu5r7It9whqHA+7RcmZ8WUgFUZ6ju5C?=
 =?us-ascii?Q?p+0eEIdUqlpOLwd6zMbC6T4wnA+gGrVsD8RlwNQ298iz1KWVHgfRStoIZpW9?=
 =?us-ascii?Q?74/kteWrD+Nu/tsU1AFIo/oecL6v5EaYrrXXNMacZGS/YSGfUFVFbadcBAH4?=
 =?us-ascii?Q?TG/SI+GJnxBMx6yErwcgfz6IETX31u9Sx0I1A3Ot9yTOnZYtI1k5u6wVCXXH?=
 =?us-ascii?Q?45Y0C9y+k4Pa+AwmfXqznIddqh48RiEXYi/ywJewi7caxpp8ZJhLxKWkCQYY?=
 =?us-ascii?Q?NPiNY/XqwW8H4fP+tPQyYhgr0JIWokDq/HlSfGeidpYP0chbvg1GWv2vIy+E?=
 =?us-ascii?Q?eAh1NyL2uVa0qRzY+JpkOjpXYchRJygYuli4TJgBp2TdYqZcdmkets0mqaF5?=
 =?us-ascii?Q?6o04rxvrzkC5V4fJm9OsJPC9f2rmSwUdEICNiQRvCNmIGfRAdJ7H/FsJBReL?=
 =?us-ascii?Q?vr6jE4f9AUpwh7YuQXdGAO9DYcEuM9oyp+IOylAYwhqsXHJ3bGL2epcfPuYl?=
 =?us-ascii?Q?2Wmna2Zs/UqHL02K5bp7QD6gni51D4sO+j5L7wlBY86bS4nWXwQMj/Y6+AjY?=
 =?us-ascii?Q?zozHsd0zAICA6AtlZx5BgmHRmPuem+EPhAA4FYbbKEsJ9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3YMzIm1hTzlptrQgSF2qgSsWKph+nSXCXR3muXW4yCw31GSFZSmkd9SwRTn?=
 =?us-ascii?Q?0eD/CFkc3SabuxW1EOQC6F1F8UDeHnKWShhPZ85U/M7BACmL1be41cICdkGC?=
 =?us-ascii?Q?VD607F74ez9iJE7a+tgTTqCThj+yHGFHL6fHbaZtt+nGJOlE6iqoT40BaiFl?=
 =?us-ascii?Q?M/NuPEzfc7EouxfiLPu+YIrpqN5jRsFD064F42zZdMjyGAQaNabziiG5RU0y?=
 =?us-ascii?Q?VUGYiyeR8dHun8Z0/di1klztEGV7rbmj4jMR1069hJlqEMK5RLjyhdqXNGfI?=
 =?us-ascii?Q?qNLH5A2XYKjKSDcs+mmwZ2smdQpAw4VlcFCpc0+CrAxiyM/IhGc0xXygjwI1?=
 =?us-ascii?Q?xKJiPSVo3/CNm6XSA7fH5RX6FXvg73Gg711OAfLv37aRG5DINahmYRjAL4Ii?=
 =?us-ascii?Q?sN1I+HCDKWzagwMoOPUqqCuqE0CNBaJbMfo1KnPORk8907L2QYXO20rsf6Mz?=
 =?us-ascii?Q?825bzBPpBBcokp2ACgqm81wnwGaiUgxsmgg/4Tb9mOLVL7j5+nOvOiiCpeNg?=
 =?us-ascii?Q?s+XSfXz4zrVZRkEgy+p9AiC7hNNUIgWu0ohJ5iVNMjDHwGiH4G2g8e0Xo7wk?=
 =?us-ascii?Q?DdIJu4k5j9rafFThe9QTrhcMcgI77Q33y2avCWwNtrTGBHSBaI9OwqmH9ncI?=
 =?us-ascii?Q?j/1Ep8bBOjLJFIziCx0MwR/pU3BG01QwWCSOd8XF0A+PO/bdSfG3bPUXOU7O?=
 =?us-ascii?Q?eUsG9uoBeyIOTvLIfciX9PPCtPcfRDBbdf4JHe/MQepf6xbSlAc4MmMyu7YR?=
 =?us-ascii?Q?jOIKNdyR8rEgz/JT+GtwRmZtJNoU1zYVOGZys1sAsGcr7F3qvgb8RILR+UJi?=
 =?us-ascii?Q?j8Zrc/rQra6r8/+niANuCMt8murbpcpr69ZjdfWSuj2VOJD2vkyeJx5OpPh+?=
 =?us-ascii?Q?9mNnRVISI2Wv3ecqMCFnfD+djhXsKKD1iRpirB8doxIfDyM6+V1hr4/I5XmM?=
 =?us-ascii?Q?k89ASIkn0VT/gMwnu8qi7qE6lmKl7mzrgxX+0bu39JUhlfaKd62RHCgEZmYo?=
 =?us-ascii?Q?DqZnZh+XOK24TKVyB1w0JiW1vUuyjIjBps8hQ31uHS5GH1gf0qasqhUVsbWd?=
 =?us-ascii?Q?QYsn4eJ60Y87vyFYaHd4zwmWch/j2WjReZfQBl/z+mfczhLsoiX4Qs+HOQK8?=
 =?us-ascii?Q?nzfy8tAfRY4pzQQ6vIa+LTQXt1WIDpjkHh971Y82949YhgkRtDqwglIZNQXh?=
 =?us-ascii?Q?ilkrEBUSQ6ZFbgrUWuOdEmR5izDBALcxG75nH4B3tTOwqBCFxCO3ou9apJfg?=
 =?us-ascii?Q?k9w8cVTj6TUyid8JFEtvrZ+DtQh/4z8WKDtEerJ7/418eMNyhoBBXdK6Brws?=
 =?us-ascii?Q?YyL/3iQgQSRHczlTGoA/ySdBkeW20k1AsSgvw5clNRnRYKuGb/xMwe1pxq7s?=
 =?us-ascii?Q?kss0XoY48k+iDLLyWi/ZuPzs8YP9wSIryfUL30g4UrdN1aAbXq8EVbj4hICG?=
 =?us-ascii?Q?XzJTZJFAxTb3+YEA2yxaxUVuVmZ03luZxmJ8/pc9yoKe48Swj+6XwSpSZ6kk?=
 =?us-ascii?Q?jEPS7UeRm5LAhBztWrP3OfWEfAdPTF2cBL7S5NlConAerqPvR67QsSuqk8be?=
 =?us-ascii?Q?aVcdvCD5lgD/ql/3alva7k4BkSR1ovBB4AB4W9UqGufo4855eTYRw4x1J/J0?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 270a38aa-7777-4adb-8d7b-08dd6aa9e1c7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:00:02.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uObZBLLrHRAiNErRjVtmkSMnhZIp5lvdcesClKpG8zwEM9Ehrn3/mvyRpx/ZXNaBpZKWbLhTfQXPJYOl85qaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "refcount_t:underflow;use-after-free" on:

commit: dcd7ee93858cda3afa28e7d5acd4896a058dd6de ("netfs: Implement bounce-=
buffering for unbuffered/DIO read")
https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git ceph-ite=
r

in testcase: xfstests
version: xfstests-x86_64-8467552f-1_20241215
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv3
	test: generic-214



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) w=
ith 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503241538.c2138272-lkp@intel.co=
m


[  343.427835][ T1682] ------------[ cut here ]------------
[  343.433163][ T1682] refcount_t: underflow; use-after-free.
[ 343.438660][ T1682] WARNING: CPU: 2 PID: 1682 at lib/refcount.c:28 refcou=
nt_warn_saturate (lib/refcount.c:28 (discriminator 3))=20
[  343.447798][ T1682] Modules linked in: nls_utf8 cifs cifs_arc4 nls_ucs2_=
utils rdma_cm iw_cm ib_cm ib_core cifs_md4 dns_resolver snd_hda_codec_hdmi =
snd_ctl_led btrfs snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scode=
c_component snd_soc_avs blake2b_generic xor snd_soc_hda_codec zstd_compress=
 snd_hda_ext_core raid6_pq intel_rapl_msr snd_soc_core intel_rapl_common sn=
d_compress x86_pkg_temp_thermal snd_hda_intel sd_mod intel_powerclamp coret=
emp dell_pc snd_intel_dspcfg sg platform_profile snd_intel_sdw_acpi kvm_int=
el ipmi_devintf ipmi_msghandler i915 kvm dell_wmi snd_hda_codec ghash_clmul=
ni_intel sha512_ssse3 dell_smbios intel_gtt cec drm_buddy sha256_ssse3 sha1=
_ssse3 ttm snd_hda_core rfkill wmi_bmof mei_wdt dcdbas sparse_keymap dell_w=
mi_descriptor rapl drm_display_helper snd_hwdep ahci intel_cstate snd_pcm l=
ibahci drm_kms_helper mei_me intel_uncore snd_timer pcspkr intel_pch_therma=
l libata snd video mei intel_pmc_core i2c_i801 soundcore i2c_smbus intel_vs=
ec wmi pmt_telemetry acpi_pad pmt_class binfmt_misc loop fuse drm
[  343.447976][ T1682]  dm_mod ip_tables
[  343.542088][ T1682] CPU: 2 UID: 0 PID: 1682 Comm: cifsd Not tainted 6.14=
.0-rc4-00008-gdcd7ee93858c #1
[  343.551316][ T1682] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS =
1.8.1 12/05/2017
[ 343.559415][ T1682] RIP: 0010:refcount_warn_saturate (lib/refcount.c:28 (=
discriminator 3))=20
[ 343.565344][ T1682] Code: 9f a1 b5 03 01 e8 26 99 cb fe 0f 0b eb b5 80 3d=
 8c a1 b5 03 00 75 ac 48 c7 c7 20 83 53 84 c6 05 7c a1 b5 03 01 e8 06 99 cb=
 fe <0f> 0b eb 95 80 3d 6a a1 b5 03 00 75 8c 48 c7 c7 e0 83 53 84 c6 05
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	9f                   	lahf
   1:	a1 b5 03 01 e8 26 99 	movabs 0xfecb9926e80103b5,%eax
   8:	cb fe=20
   a:	0f 0b                	ud2
   c:	eb b5                	jmp    0xffffffffffffffc3
   e:	80 3d 8c a1 b5 03 00 	cmpb   $0x0,0x3b5a18c(%rip)        # 0x3b5a1a1
  15:	75 ac                	jne    0xffffffffffffffc3
  17:	48 c7 c7 20 83 53 84 	mov    $0xffffffff84538320,%rdi
  1e:	c6 05 7c a1 b5 03 01 	movb   $0x1,0x3b5a17c(%rip)        # 0x3b5a1a1
  25:	e8 06 99 cb fe       	call   0xfffffffffecb9930
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb 95                	jmp    0xffffffffffffffc3
  2e:	80 3d 6a a1 b5 03 00 	cmpb   $0x0,0x3b5a16a(%rip)        # 0x3b5a19f
  35:	75 8c                	jne    0xffffffffffffffc3
  37:	48 c7 c7 e0 83 53 84 	mov    $0xffffffff845383e0,%rdi
  3e:	c6                   	.byte 0xc6
  3f:	05                   	.byte 0x5

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	eb 95                	jmp    0xffffffffffffff99
   4:	80 3d 6a a1 b5 03 00 	cmpb   $0x0,0x3b5a16a(%rip)        # 0x3b5a175
   b:	75 8c                	jne    0xffffffffffffff99
   d:	48 c7 c7 e0 83 53 84 	mov    $0xffffffff845383e0,%rdi
  14:	c6                   	.byte 0xc6
  15:	05                   	.byte 0x5
[  343.584797][ T1682] RSP: 0018:ffffc900020bfac8 EFLAGS: 00010286
[  343.590720][ T1682] RAX: 0000000000000000 RBX: ffff8887f912fee8 RCX: fff=
fffff8277b84a
[  343.598547][ T1682] RDX: 1ffff110f0fe6ac8 RSI: 0000000000000008 RDI: fff=
f888787f35640
[  343.606377][ T1682] RBP: 0000000000000003 R08: 0000000000000001 R09: fff=
ff52000417f0f
[  343.614205][ T1682] R10: ffffc900020bf87f R11: 0000000000000001 R12: 000=
0000000000000
[  343.622033][ T1682] R13: 000000000000000a R14: ffff88810fa041c8 R15: fff=
f8887f912fee8
[  343.629861][ T1682] FS:  0000000000000000(0000) GS:ffff888787f00000(0000=
) knlGS:0000000000000000
[  343.638643][ T1682] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  343.645082][ T1682] CR2: 0000564d628e7a48 CR3: 000000081aa6c003 CR4: 000=
00000003726f0
[  343.652908][ T1682] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[  343.660735][ T1682] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[  343.668560][ T1682] Call Trace:
[  343.671702][ T1682]  <TASK>
[ 343.674497][ T1682] ? __warn (kernel/panic.c:748)=20
[ 343.678427][ T1682] ? refcount_warn_saturate (lib/refcount.c:28 (discrimi=
nator 3))=20
[ 343.683742][ T1682] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[ 343.688101][ T1682] ? handle_bug (arch/x86/kernel/traps.c:285)=20
[ 343.692286][ T1682] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discri=
minator 1))=20
[ 343.696821][ T1682] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h=
:574)=20
[ 343.701713][ T1682] ? llist_add_batch (lib/llist.c:33 (discriminator 14))=
=20
[ 343.706426][ T1682] ? refcount_warn_saturate (lib/refcount.c:28 (discrimi=
nator 3))=20
[ 343.711749][ T1682] ? refcount_warn_saturate (lib/refcount.c:28 (discrimi=
nator 3))=20
[ 343.717070][ T1682] netfs_put_request (include/linux/refcount.h:275 inclu=
de/linux/refcount.h:307 fs/netfs/objects.c:173)=20
[ 343.721874][ T1682] smb2_readv_callback (include/linux/instrumented.h:96 =
include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:264=
 include/linux/refcount.h:307 include/linux/refcount.h:325 include/linux/kr=
ef.h:64 fs/smb/client/cifsproto.h:744 fs/smb/client/smb2pdu.c:4621) cifs=20
[ 343.727715][ T1682] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 i=
nclude/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic=
-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spin=
lock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:1=
54)=20
[ 343.732249][ T1682] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153=
)=20
[ 343.737303][ T1682] ? __pfx_smb2_readv_callback (fs/smb/client/smb2pdu.c:=
4505) cifs=20
[ 343.743566][ T1682] ? dequeue_mid (include/linux/list.h:215 include/linux=
/list.h:287 fs/smb/client/connect.c:854) cifs=20
[ 343.748690][ T1682] cifs_demultiplex_thread (fs/smb/client/connect.c:1283=
) cifs=20
[ 343.754855][ T1682] ? __pfx_cifs_demultiplex_thread (fs/smb/client/connec=
t.c:1143) cifs=20
[ 343.761451][ T1682] ? __pfx___schedule (kernel/sched/core.c:6646)=20
[ 343.766158][ T1682] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic=
.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomi=
c/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/li=
nux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spin=
lock.c:162)=20
[ 343.771386][ T1682] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206=
 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-=
non-atomic.h:142 kernel/kthread.c:291)=20
[ 343.776179][ T1682] ? __pfx_cifs_demultiplex_thread (fs/smb/client/connec=
t.c:1143) cifs=20
[ 343.782774][ T1682] kthread (kernel/kthread.c:464)=20
[ 343.786699][ T1682] ? __pfx_kthread (kernel/kthread.c:413)=20
[ 343.791143][ T1682] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c=
:169)=20
[ 343.796544][ T1682] ? __pfx_kthread (kernel/kthread.c:413)=20
[ 343.800989][ T1682] ret_from_fork (arch/x86/kernel/process.c:148)=20
[ 343.805265][ T1682] ? __pfx_kthread (kernel/kthread.c:413)=20
[ 343.809714][ T1682] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)=20
[  343.814337][ T1682]  </TASK>
[  343.817220][ T1682] ---[ end trace 0000000000000000 ]---
[  343.975682][  T287] generic/214       _check_dmesg: something found in d=
mesg (see /lkp/benchmarks/xfstests/results//generic/214.dmesg)
[  343.975695][  T287]
[  343.992249][  T287] - output mismatch (see /lkp/benchmarks/xfstests/resu=
lts//generic/214.out.bad)
[  343.992259][  T287]
[  344.004869][  T287]     --- tests/generic/214.out	2024-12-15 06:14:52.00=
0000000 +0000
[  344.004879][  T287]
[  344.017021][  T287]     +++ /lkp/benchmarks/xfstests/results//generic/21=
4.out.bad	2025-03-22 22:47:49.975533744 +0000
[  344.017032][  T287]
[  344.030312][  T287]     @@ -33,11 +33,7 @@
[  344.030321][  T287]
[  344.037642][  T287]      =3D=3D=3D falloc, write, sync, truncate, read =
=3D=3D=3D
[  344.037651][  T287]
[  344.047135][  T287]      wrote 65536/65536 bytes at offset 73728
[  344.047144][  T287]
[  344.056685][  T287]      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and X=
XX ops/sec)
[  344.056695][  T287]
[  344.068253][  T287]     -00000000:  00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00  ................
[  344.068263][  T287]
[  344.079832][  T287]     -*
[  344.079841][  T287]
[  344.086467][  T287]     -00012000:  aa aa aa aa aa aa aa aa aa aa aa aa =
aa aa aa aa  ................
[  344.086477][  T287]
[  344.098043][  T287]     -*
[  344.098051][  T287]
[  344.103114][  T287]     ...
[  344.103122][  T287]
[  344.111416][  T287]     (Run 'diff -u /lkp/benchmarks/xfstests/tests/gen=
eric/214.out /lkp/benchmarks/xfstests/results//generic/214.out.bad'  to see=
 the entire diff)
[  344.111426][  T287]
[  344.128641][  T287] Ran: generic/214
[  344.128649][  T287]
[  344.134850][  T287] Failures: generic/214
[  344.134858][  T287]
[  344.141454][  T287] Failed 1 of 1 tests


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250324/202503241538.c2138272-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


