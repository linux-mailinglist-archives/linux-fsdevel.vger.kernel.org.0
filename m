Return-Path: <linux-fsdevel+bounces-8235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE4E8314BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 09:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333FC1C20CB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A423B1F610;
	Thu, 18 Jan 2024 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ox2ZhATP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FCE1CFA4;
	Thu, 18 Jan 2024 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566226; cv=fail; b=svrmxqb7eHNMVATXt2LI5UrJqReX9mEyo4Sq4GwCMfb5SL5GYAQ0J2In8mb4Gu9S8ymbz6jkEbe9qitTSJcKt4s1JAC7EHn8po7i5r/AoX9eROhjWseLMQ2Hkluqt0dTMyz8yOQtvET1u9/xcyXpUWfh0KHkvDJqSm4pvVn8EX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566226; c=relaxed/simple;
	bh=FDRbuk2EGJ5SWaLL6Q5tKsvRvoy0ED6futlx1HcGsak=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=HtuAgv7iWpXkMS7AgmMzIcnZNaENJBNqZmeVPb5fNLH4lz06MhSyfXrP90lpkezSpkTME9mx0Cwi6kpI/nFyaZ9ihoD3QapW9toap1GB43Gj7j82sVk3WZNGwXx7n2rGOmhrugZSYk9qrX32oy80tss5K1TSrWAeowVYwIVKc+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ox2ZhATP; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705566224; x=1737102224;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=FDRbuk2EGJ5SWaLL6Q5tKsvRvoy0ED6futlx1HcGsak=;
  b=Ox2ZhATPXU9BIuHqZclbDlfxoduxeDWx4PaD6RrNnOjeyInV2/VFKQcS
   MKkPRhyA+okQz+FJE8Wx99KSS1iMCu2RWcsjt7MjWr8+qBQZl9oaZF7E7
   +kR7KsZZPgaojx0rG0qb0gYfZjYjmHEkmTH8RsAWdxZD4VmZflVxBDV1s
   EFlZeFQsM8CDGodAde3pVBRXQEkJylVvUvjwvBO7KRjQ5Y/VxRK+9UvbC
   hrz6xXpxzJ92Cx07YP2woiOR2kRSW4U7lXjSOrMCCLPYDSBmd8/TmuF4Q
   lUGBoY4qUnIHdDEpEJvifynyI1xxYZWZX3FRvZV0HZIaLFwOCRWkbm4qQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="21865734"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="21865734"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 00:23:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="19050334"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 00:23:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 00:23:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 00:23:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 00:23:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsXKSjqOQNBgntifv60QzjvENwkGT/6ss4syE+N+IJcY8c5pZnW9UX1rSCRChU5qdI4CY4VvtjKXlRIQ0lsHPJNAHr3pQPapr8Wpj0XCQaJ6AOSyv7+gcfWTrHEN0uQW20x5teY6yCgi1V2NH7+zPRNRJ9Pnx+1P17j0V9ZUReuL3MgYoq32KEzqwTzLr2rNGAx5Ah51EUSENOf0TcOSSp1E46QzAXi03CnMXbqmTkGipZIowH7f+jfA6cTnX6ayntXmaxadCqL4q/dZkJrbE6eCBZm+6qEBe7UzKBERo856aDB6bpm+OMsoq51Ex/hE3dAZ6KowKLGqXnfsqQrk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNoHNV0YN8Q+o5ga+MXjZ84L1xn2V6YUTWh75eAGfAQ=;
 b=DtrivnJ0uX9IKbo1y7XrWjpvwI30K2gW4gboGf0Tk+8gwjDH19i6kvb+sNVtR1oMTeTshnxBXP1EmMsmmIrgsEJ3Dgydry2U5ZD4pk48yNV+kJ9tU7tCRjiZIXw7kIsazPaBcZlIfC3DukoW17uZAWSrBfeGAwUTXExH1miHL4GnARzlaZs4SeZDIei+tlDiEW4kkeGNEpUWxXdscsH2afKWXilkY0q4CQ524twrToGjjhJ8DnIK7W/JRi5/ZPMjE2ZYRN9t0vRe+4itRFYej6YJY+5DEUFzSVSFLKlHhJTUoBA9lKTMjfpiHNVOMUGbSkzOzNDRWC+BdgU0qJkjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 08:23:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Thu, 18 Jan 2024
 08:23:36 +0000
Date: Thu, 18 Jan 2024 16:23:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fscrypt@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<ebiggers@kernel.org>, <jaegeuk@kernel.org>, <tytso@mit.edu>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <amir73il@gmail.com>, "Gabriel Krisman
 Bertazi" <krisman@suse.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added
Message-ID: <202401181648.4192e541-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240111225816.18117-5-krisman@suse.de>
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: 2349d4fa-6189-4b38-66a7-08dc17fec442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MiF2WOs6nkLzeQiRVlGU3y+ai4Ota9/N1KCqjEU7t+sUU8G4mreg+vYNpIjpQMjIxcmyFc4eD7JvLIRTERMSATpQjmJgcyKF7y9zzRW/JBqDo8VPe/NLxhrGClVgm3qz+PxZeQv+2r/thWVW1qbo2FGeiryOf2pw6Qe9ANDRAbNeihZcFi/4L962zuLen7dBM5v7jGgqJlktqlPyWrTaEVFKpQ+91BzgADYTO9WN7npe7gfm9DHXWh06QK3sRZEgilJ9lOCdDAHFeccpb3RqdTGTKrNkiVdo2CXUKzNaMCyqwqyMHYH8ur9iXMzmGz4sBzmcjF1Mdsp9XKJQ+SvOnFHDoj2TH5Js9Rj21z81nAhPqiC8wpwAgrBzaSMSx71S9/SOy9tytwWkH8fZcDspYk/2l60moP14XdcpBp0rO9rKrApbBnn8V9kPiwYP/ZzyQA5w9pTANYw7elXyUE4WKkb1Qgl1HEnsqkkaVxWIpXNTih2PZMgqOI03SQ8gVBOveCAaeKyMRtktnrc3qbAk6EU0Ru3tuyfO4rEA4sldU1rWyHP5rU01cw83sQkFDB8CayMoHQv7HdVqUg+vCrLdBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66556008)(6486002)(966005)(45080400002)(66946007)(478600001)(6512007)(66476007)(6916009)(316002)(8936002)(6506007)(8676002)(6666004)(86362001)(2906002)(83380400001)(38100700002)(82960400001)(7416002)(41300700001)(26005)(4326008)(2616005)(36756003)(5660300002)(107886003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PpLZj5D1KU73EDMq2Dt+9SiU5WL4eReAlSD9JDXVkND6wMBnnQ286sUDSx/y?=
 =?us-ascii?Q?KP8F2sLQpMXGcWFQ2J6KfKDYxMX0c9xUcbyKMWya6e3U3+fWsdIeP3XQy1IW?=
 =?us-ascii?Q?jxbjDGRK1eLnc/l+HJeQoJY+dsZi2pTpNXPeSEQNOSoq/YU20e1oMOoFadfu?=
 =?us-ascii?Q?Qb0RMha0SPHN741ADC5dMzuPvp0jQUl+wIkWkNmlgU3q7uRG2sGaCbjDsp2d?=
 =?us-ascii?Q?+GS1cqum/bXzThpkh33gNiTXwAom32VDzZVjZVuo+t3WvdplNbKdtKOp5e7Q?=
 =?us-ascii?Q?IpgYDm6CC3PJelEFAvFfVTEvzjkRJz8zOC6/LxejaJgyaz3gwqO6Z+Gtt6ZJ?=
 =?us-ascii?Q?yLG0zNOCV9bPLVF8HA3hDkk2FETa9dv6E1nK2d3RsGZjVEo2X9llI8R9lvM9?=
 =?us-ascii?Q?jsum6zYf5xvNd+xxMw9rBoLX/6WxgVCkmvrSUJ0xaioHG5CNIeNOAxGG6zPu?=
 =?us-ascii?Q?QNO1X+o6M6+6mG8pSjfNOz0vSLY986X/bhVVuh8ptAORpPKi79Ph/fTdDqMq?=
 =?us-ascii?Q?MyeTkpZw3UAyqbq6gCcpBnzTCD5a1YDwMBSbpdrs90DjMNseYJT+54LKJYFj?=
 =?us-ascii?Q?eJ66rkQ6WnsJp+g8G9v1oZk45bLn4P7GF3aHhkcS0IIaJtmocWYoUrRHl17h?=
 =?us-ascii?Q?LJGytdTjFn99Z/Rkwl0QIX96FOH4HDwAsWVeVzP/X93JB7iLZs9bXQRwxoI8?=
 =?us-ascii?Q?1mR7IBh0GesrB4LTNQKbVBg8DTxNRHFltRrJZ2dfg36qqPSGMp59j5QtF/em?=
 =?us-ascii?Q?PeL+aU0LBUfc0YxdR5ZcnEATwCkgsHL6gh/QOYMbQo9Sia39pYuhKz+k5Ntq?=
 =?us-ascii?Q?VbK6+wP0Q//qLIK68K4xVNW6Ljj8oj4f48y4Iy+4dRG5JiCDi6Nja+PFhqo4?=
 =?us-ascii?Q?KkeIVTMXWtD5j9XjJDd4Jw4w+WYmM4IVzbZEU0xUJrrbdLAOUvaB5GmZV1Pb?=
 =?us-ascii?Q?DBqiDxo52JCrjCCZZ/Y0XmS9Q9vzNM9hl1LLW1ZYYVmoHCufQS1HhjZH+pbb?=
 =?us-ascii?Q?CHdHUQ9aHI55dfAOoQASR4vAw8SB0tiHnLVl52mURlGCmgRlsHfaALYEUJMM?=
 =?us-ascii?Q?u9BLy8i0pIeFY0D918y7Ojw4ys5joC3nlRGd3VVUGmQ/p6I/Qp/SdJmzGjTc?=
 =?us-ascii?Q?JO+oZ5YAVO6xibOMLJczULWiAzEQQfLQceRDm+eMyIJtHDpVKBYbz9DeAymD?=
 =?us-ascii?Q?HS54W7TkWXLuNbdlkE8hPZc7T8Gs9tuVpg3zAQM2xJ14PewKtA0a8e5TUN6L?=
 =?us-ascii?Q?oxScKTbtCYvDqSIagKS8zD2GV3U+GIkA+DHY741yCYoR1vtjINBFpEE61bYw?=
 =?us-ascii?Q?oc0rpn8yEhSR+Kau84+IWBWHThQdSIUdN/gK3CK2n2i96ipBjuYIHhHQQCnP?=
 =?us-ascii?Q?9Ev/wIQUuWujqmGSogVqcYs2CWtqtWdvm1/eyoc9LEVqeXLscj7Z7ZqgERxP?=
 =?us-ascii?Q?60gQy3Y/jT7s/SFTtQQ7sF5KeUVS/VhWfztPL8izZ7/DpxBaikQcKpbHBWIP?=
 =?us-ascii?Q?z2JYDlwWIpburMlWVpV1Qlv+WcCcKQx8NPtw/tJfqsBVdyLwypHGd0MyMgjg?=
 =?us-ascii?Q?3+PdlljPR2LDFvkIAPGvf6ou6HnlL8iH1yKk6+b77cRQqnhUfP10q+V3VP9L?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2349d4fa-6189-4b38-66a7-08dc17fec442
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 08:23:36.4971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rsRDKNYIlVRBMw4GN/tsSMnQsrULFxL7HDdawmSgO7hUhct6rXvOg3zjEb/ul1RPyUZ1Njd4j256mEMBs4eIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4943
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 1cfe4ba685d9eb6123648a0d9bef2d3d57b078ef ("[PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added")
url: https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/ovl-Reject-mounting-case-insensitive-filesystems/20240112-070113
base: https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link: https://lore.kernel.org/all/20240111225816.18117-5-krisman@suse.de/
patch subject: [PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added

in testcase: fxmark
version: fxmark-x86_64-0ce9491-1_20220601
with following parameters:

	disk: 1SSD
	media: ssd
	test: MWRL
	fstype: xfs
	directio: bufferedio
	cpufreq_governor: performance



compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401181648.4192e541-oliver.sang@intel.com


[   73.173380][ T6828] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   73.181338][ T6828] #PF: supervisor read access in kernel mode
[   73.187453][ T6828] #PF: error_code(0x0000) - not-present page
[   73.193566][ T6828] PGD 11cc47067 P4D 0
[   73.197762][ T6828] Oops: 0000 [#1] SMP NOPTI
[   73.202383][ T6828] CPU: 16 PID: 6828 Comm: fxmark Tainted: G S                 6.7.0-rc1-00176-g1cfe4ba685d9 #1
[   73.212818][ T6828] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[ 73.224837][ T6828] RIP: 0010:__d_move (include/linux/fscrypt.h:241 fs/dcache.c:3003) 
[ 73.229912][ T6828] Code: c1 00 00 00 08 0f 84 ed 00 00 00 81 e1 3f 10 07 00 0f 84 e1 00 00 00 80 cc 40 89 c1 81 e1 ff ff ff fd 41 89 4d 00 49 8b 4d 60 <48> 81 39 10 21 4e 81 0f 84 66 01 00 00 83 43 04 01 41 83 45 04 01
All code
========
   0:	c1 00 00             	roll   $0x0,(%rax)
   3:	00 08                	add    %cl,(%rax)
   5:	0f 84 ed 00 00 00    	je     0xf8
   b:	81 e1 3f 10 07 00    	and    $0x7103f,%ecx
  11:	0f 84 e1 00 00 00    	je     0xf8
  17:	80 cc 40             	or     $0x40,%ah
  1a:	89 c1                	mov    %eax,%ecx
  1c:	81 e1 ff ff ff fd    	and    $0xfdffffff,%ecx
  22:	41 89 4d 00          	mov    %ecx,0x0(%r13)
  26:	49 8b 4d 60          	mov    0x60(%r13),%rcx
  2a:*	48 81 39 10 21 4e 81 	cmpq   $0xffffffff814e2110,(%rcx)		<-- trapping instruction
  31:	0f 84 66 01 00 00    	je     0x19d
  37:	83 43 04 01          	addl   $0x1,0x4(%rbx)
  3b:	41 83 45 04 01       	addl   $0x1,0x4(%r13)

Code starting with the faulting instruction
===========================================
   0:	48 81 39 10 21 4e 81 	cmpq   $0xffffffff814e2110,(%rcx)
   7:	0f 84 66 01 00 00    	je     0x173
   d:	83 43 04 01          	addl   $0x1,0x4(%rbx)
  11:	41 83 45 04 01       	addl   $0x1,0x4(%r13)
[   73.249920][ T6828] RSP: 0018:ffa000000a99bce8 EFLAGS: 00010206
[   73.256134][ T6828] RAX: 0000000000480000 RBX: ff1100012cab5380 RCX: 0000000000000000
[   73.264248][ T6828] RDX: ff1100012cab4609 RSI: 0000000000000000 RDI: ff1100012cab4600
[   73.272366][ T6828] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000020c
[   73.280473][ T6828] R10: ff110001622ddde0 R11: 0000000000010000 R12: 0000000000000000
[   73.288584][ T6828] R13: ff1100012cab4600 R14: 0000000000000000 R15: ff1100012cab5200
[   73.296699][ T6828] FS:  00007f1073011600(0000) GS:ff1100103f600000(0000) knlGS:0000000000000000
[   73.305766][ T6828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   73.312488][ T6828] CR2: 0000000000000000 CR3: 000000012af2a006 CR4: 0000000000771ef0
[   73.320596][ T6828] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   73.328699][ T6828] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   73.336803][ T6828] PKRU: 55555554
[   73.340485][ T6828] Call Trace:
[   73.343900][ T6828]  <TASK>
[ 73.346960][ T6828] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 73.350983][ T6828] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[ 73.355957][ T6828] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
[ 73.360837][ T6828] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[ 73.365974][ T6828] ? __d_move (include/linux/fscrypt.h:241 fs/dcache.c:3003) 
[ 73.370410][ T6828] ? __d_move (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 include/linux/fsnotify_backend.h:580 fs/dcache.c:3002) 
[ 73.374846][ T6828] d_move (include/linux/seqlock.h:500 include/linux/seqlock.h:572 include/linux/seqlock.h:910 fs/dcache.c:3032) 
[ 73.378757][ T6828] vfs_rename (include/linux/fs.h:807 fs/namei.c:4864) 
[ 73.383189][ T6828] ? do_renameat2 (fs/namei.c:4996) 
[ 73.387963][ T6828] do_renameat2 (fs/namei.c:4996) 
[ 73.392568][ T6828] __x64_sys_rename (fs/namei.c:5040) 
[ 73.397336][ T6828] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
[ 73.401835][ T6828] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[   73.407817][ T6828] RIP: 0033:0x7f1072e83ed7
[ 73.412325][ T6828] Code: e8 6e 82 09 00 85 c0 0f 95 c0 0f b6 c0 f7 d8 5d c3 66 90 b8 ff ff ff ff 5d c3 66 0f 1f 84 00 00 00 00 00 b8 52 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 89 8f 17 00 f7 d8 64 89 02 b8
All code
========
   0:	e8 6e 82 09 00       	callq  0x98273
   5:	85 c0                	test   %eax,%eax
   7:	0f 95 c0             	setne  %al
   a:	0f b6 c0             	movzbl %al,%eax
   d:	f7 d8                	neg    %eax
   f:	5d                   	pop    %rbp
  10:	c3                   	retq   
  11:	66 90                	xchg   %ax,%ax
  13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  18:	5d                   	pop    %rbp
  19:	c3                   	retq   
  1a:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  21:	00 00 
  23:	b8 52 00 00 00       	mov    $0x52,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 01                	ja     0x33
  32:	c3                   	retq   
  33:	48 8b 15 89 8f 17 00 	mov    0x178f89(%rip),%rdx        # 0x178fc3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 02             	mov    %eax,%fs:(%rdx)
  3f:	b8                   	.byte 0xb8

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 01                	ja     0x9
   8:	c3                   	retq   
   9:	48 8b 15 89 8f 17 00 	mov    0x178f89(%rip),%rdx        # 0x178f99
  10:	f7 d8                	neg    %eax
  12:	64 89 02             	mov    %eax,%fs:(%rdx)
  15:	b8                   	.byte 0xb8
[   73.432265][ T6828] RSP: 002b:00007ffe3fb6db98 EFLAGS: 00000202 ORIG_RAX: 0000000000000052
[   73.440777][ T6828] RAX: ffffffffffffffda RBX: 00007f107300d840 RCX: 00007f1072e83ed7
[   73.448853][ T6828] RDX: 0000000000000000 RSI: 00007ffe3fb6eba0 RDI: 00007ffe3fb6dba0
[   73.456921][ T6828] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffe3fb6d937
[   73.464983][ T6828] R10: fffffffffffffa2e R11: 0000000000000202 R12: 000055ef6a56d0a2
[   73.473046][ T6828] R13: 00007ffe3fb6eba0 R14: 00007ffe3fb6dba0 R15: 00007f1073004000
[   73.481105][ T6828]  </TASK>
[   73.484219][ T6828] Modules linked in: xfs loop btrfs blake2b_generic xor raid6_pq libcrc32c sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl intel_cstate ast ahci libahci ipmi_ssif mei_me acpi_ipmi ioatdma drm_shmem_helper intel_uncore i2c_i801 dax_hmem ipmi_si libata drm_kms_helper mei joydev i2c_smbus dca intel_pch_thermal wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter drm fuse ip_tables
[   73.538153][ T6828] CR2: 0000000000000000
[   73.542418][ T6828] ---[ end trace 0000000000000000 ]---
[   73.560053][ T6828] pstore: backend (erst) writing error (-28)
[ 73.566136][ T6828] RIP: 0010:__d_move (include/linux/fscrypt.h:241 fs/dcache.c:3003) 
[ 73.571178][ T6828] Code: c1 00 00 00 08 0f 84 ed 00 00 00 81 e1 3f 10 07 00 0f 84 e1 00 00 00 80 cc 40 89 c1 81 e1 ff ff ff fd 41 89 4d 00 49 8b 4d 60 <48> 81 39 10 21 4e 81 0f 84 66 01 00 00 83 43 04 01 41 83 45 04 01
All code
========
   0:	c1 00 00             	roll   $0x0,(%rax)
   3:	00 08                	add    %cl,(%rax)
   5:	0f 84 ed 00 00 00    	je     0xf8
   b:	81 e1 3f 10 07 00    	and    $0x7103f,%ecx
  11:	0f 84 e1 00 00 00    	je     0xf8
  17:	80 cc 40             	or     $0x40,%ah
  1a:	89 c1                	mov    %eax,%ecx
  1c:	81 e1 ff ff ff fd    	and    $0xfdffffff,%ecx
  22:	41 89 4d 00          	mov    %ecx,0x0(%r13)
  26:	49 8b 4d 60          	mov    0x60(%r13),%rcx
  2a:*	48 81 39 10 21 4e 81 	cmpq   $0xffffffff814e2110,(%rcx)		<-- trapping instruction
  31:	0f 84 66 01 00 00    	je     0x19d
  37:	83 43 04 01          	addl   $0x1,0x4(%rbx)
  3b:	41 83 45 04 01       	addl   $0x1,0x4(%r13)

Code starting with the faulting instruction
===========================================
   0:	48 81 39 10 21 4e 81 	cmpq   $0xffffffff814e2110,(%rcx)
   7:	0f 84 66 01 00 00    	je     0x173
   d:	83 43 04 01          	addl   $0x1,0x4(%rbx)
  11:	41 83 45 04 01       	addl   $0x1,0x4(%r13)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240118/202401181648.4192e541-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


