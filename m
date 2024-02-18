Return-Path: <linux-fsdevel+bounces-11943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E448594EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 07:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444431F22D2F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 06:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBD45394;
	Sun, 18 Feb 2024 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RadcMNsp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43D29A0
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708236523; cv=fail; b=nNMGA/haAS43m1aMQMyy2Ky9OzAPaVbo+kEqkR9GAWIEZ4Pewa4XFZ8ZXhYeRh8jkc1GoPnxYkLW8KcAke3vUAd4OjpKeRZs8tCVXmmLGwZcLdqTUvwel2Gn8Z3QhJeTHmRSGQCK7pJ5IfS3+DIxsauc2kPa9EYda9h53kybj/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708236523; c=relaxed/simple;
	bh=NrJD3TxNIbT8XAo4maSaaqVWbUVc++WcW01RY7ErtAQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hIOTz2kB9aUE9Ak4WNQ6xBGEcJhbiAV60RF45LpKSqUI4IpcHPr8rmzTXfaaJiwPM0wd9t+J6ET2eq+MsoKGw9nLGMf5TgpFf7GlPX0ZeOO0u2lFD/FFFtackqbjcd5Qk/Jx2SXIE8yxpup6/A2Wp1AHVVrjqS0AOTRUfdIjB34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RadcMNsp; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708236517; x=1739772517;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=NrJD3TxNIbT8XAo4maSaaqVWbUVc++WcW01RY7ErtAQ=;
  b=RadcMNspcYfKKclfDjIEHaATI8OK3QpIMTZUkNSaNl9HbLyBo5gVaM9T
   i9NkwTGxj7YQP6OQlAJlL+poHG1N1seDVusbNcHHoBW01UnM3CwWYe5J8
   DQLM16QldqddpeCSQuGC7IiAfqw9JekFUo0geKRFY5b9E2MFxY/YGvSon
   fIRZnVmYzwEDF0pNMRcL4iezZOlgLkmkhbwcm2blGjAwy/+NvQizsXBrP
   hnETmk//cqqJsJmrGcalpEWDJSHWooKLtoqriy6sWsG5pk0Xx2lgP3Az3
   PbReTieHpgUSZrbnETUfZI/Q0kB3cvAPfn3emxqv3J/rRAbJ1AdKSNvXG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2191558"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2191558"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 22:08:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="41697853"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2024 22:08:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 22:08:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 17 Feb 2024 22:08:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 17 Feb 2024 22:08:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvYvHJZqr8Onh/Vy0RAIx2ylvNofmKe1q4pRfEyY/9SIyh2ZeUaYGsVw1u3Ozg3RR7E0RkiVwk9ZS86fxuVzM0eqPkhUa/qoK8m1zYy+WdEUbFKwMwCiZhBXT4sfjz7+ADVSMZsbi3SGnV0j75xmBVf4oN1iWlZp7KglcCn9kniaUTnsajyLbxELTNmPznenV5INvoEn0yvYqS4H19EreolfEzmGQycBQReIcZ9orfrCAf8dEKsIHLDOdLFIZSkRZXWKGRAhw+aSFpi4gIq3od/KltIOHkukAK9YmbyGnSCKKTJmUThqbku8E9mC7b8UdtnC6pDzzcyhInfrzXLp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9seesgTYrihpFsxu54SzSYJ6ojkl4zBcCwmVDK9+nyk=;
 b=WlpuesjuPwrY6UqhUZqY4NTM4C1T83diW//C/2K82lSm6kv+cuqVJRHUOxqdg+rLIGAsJYajeIFs0oUDyuIhH+LXB9JHPzKkiQEVwK9O81RNeVRPqnCzSqY2OZ3nP5AwH5absfycR/raXOuUbCxlrZEaraEBriqKbKVE+PZH6gUxZGQ4FEGXdGxB8WBISv4bC1kATV0tpQZPmGyIvl2bg1hcd/crZ/cBLC0hZXoRi8VkgzRmLx+CjJBLOpPLrHrJF3jLDVEUI+wtE/VpB2L8s2don72PwMJsmJSmIcqLeOxvXBar8JgZBdExL9hRt0POBB8Qh+aX84HbirrrLEWrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by DM6PR11MB4580.namprd11.prod.outlook.com (2603:10b6:5:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.33; Sun, 18 Feb
 2024 06:08:29 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4ad0:937f:995f:3c95]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4ad0:937f:995f:3c95%7]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:08:29 +0000
Date: Sun, 18 Feb 2024 14:08:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, NeilBrown
	<neilb@suse.de>, <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [filelock]  b6be371400:
 stress-ng.lockf.ops_per_sec -100.0% regression
Message-ID: <202402181229.f8147f40-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|DM6PR11MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7990ec-c491-49f0-23af-08dc30480498
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jN3DIVDCIhdM/0rYKG/tUqKsfFo1DyRU4dQegrzT5S9zK9ycGjVTp6HllhZmAM62hrFF4RoVLaAkakAgenGYXIjVZIkQhlqcG+rKAWL9SsZaxScMtGko4RlgfNtmkEwxQhFGtR4s3zMfuUAH9g66WjxbfzrduUoGCtibsSMj9HxOVte0A8+4F9OzP+i2QwEuQ44+KTmSTdgwuEL9Ll9vvAEE1lLadnhaXdbml26OUM7oLiJlSJ/LGHualzqaxeZw05etl2vh0bvFpWGeJjZbsaZ3Vv1sR9Hn6+PUTjHLmKkJrUjNDD5MWS7jagKY96F5uSCxwYl/cl13H4wRn2+s8D3SPVmFkLmHZ/6qJrbK/PtuZmjP5rmcXUjLTdaS5ooYPvOuRZfOvh+GyZ6JrnIAjyhw4S7UvnEarzsO1+vZD0QuU3P99o0PXPAGVJvz/K1q9aLqy8ND8HDd5yvmAe6cncZpDOrFbib9PADdXAztir4ZqqQc/zqhlruUoxau/atdZXAt9fuqLpYdmxaV1+8YmwuJ8jUF+hVSqVEmfQB5Lr6TWhNtes9z0UrmmqIEkdbm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230473577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(1076003)(8676002)(2616005)(41300700001)(107886003)(83380400001)(8936002)(66556008)(66476007)(66946007)(4326008)(6916009)(316002)(6666004)(478600001)(54906003)(966005)(6486002)(6506007)(6512007)(36756003)(38100700002)(82960400001)(86362001)(2906002)(30864003)(5660300002)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gtAmDkAapkaDmF493Of5obnD6N/e96ILZKGZ4s2sGYffNVNjtjItfvFi8u?=
 =?iso-8859-1?Q?XOKMYWokGjnXp5oDAOUCEo5RKTV8z8DVefBEA4k9Ojj6TmSsezv34ZWCLD?=
 =?iso-8859-1?Q?FOsEwNMRB1WiKsltbZQ12wnBA7y4M0ZNFvV9L94cMrxBfs+66vab5gKRoa?=
 =?iso-8859-1?Q?Q/feCV0Lg/ngyVqitpz43vbd3/pNSGgj+8u8wplvMkLJpp1hxapwMD+Bjc?=
 =?iso-8859-1?Q?Jg7J0JzOzxawsk607FfKeA9rQCEcsohT3YFLgCNP504ldkA2AqosAFrrez?=
 =?iso-8859-1?Q?LaNBaQ2bXW6MBYPi6T+Es0Q4Ztw/9zgAFu/42wzP1wjHz+k3FciM2ib4Dv?=
 =?iso-8859-1?Q?bQj7bLt17LktE0CpZlz9YnECrQIBxSY4QpWHLr469nfhQNUN8m20HQVdeT?=
 =?iso-8859-1?Q?jMEgUoxZmlZ6XiR1vxW7yBWFhPuNxR2bhNx62GhCbJVe0bKUnwrSlxC38o?=
 =?iso-8859-1?Q?chWk5Tsb5DkjZ3eGaJN1bpe7tvGAiS3YkzfjetmWXlEomz8YDY4s0p2t/M?=
 =?iso-8859-1?Q?R7HWZtg0LzRgmC4o/AJnlxT17B60BUosRYPH8K24z1VSD1HFmTozMbl8KY?=
 =?iso-8859-1?Q?q1o7q8Ek5TQ+fJKV+ZwPXUtFFBJExFnCzAZ1rmhQUKC8mR/6gJaVMnzZKc?=
 =?iso-8859-1?Q?E12PA/67GMxAs4+8o0Scdf6nv99Nd9tFaVwxs48dj0WvgbN6XIif0n+C3b?=
 =?iso-8859-1?Q?k/e7iQGKADiak8hvPVzh9KroHBz78c37PCCE/tT+RU82srdK8GZ96GwH/v?=
 =?iso-8859-1?Q?AyP0fV1k0UPJAGxSCS9yOzVy7ZsXfQEY0LIqfgST4MW9A1925yMUKyBpCs?=
 =?iso-8859-1?Q?VIohdz1de/wLFGMxK3ELooIgXdXHKNI1xIA10hstrDgFnTZ077lLpWlyJe?=
 =?iso-8859-1?Q?boY9HWoaKfQ82WE3r5uK3bjYRtpAYztBTWAFXqIC09aJnFuETurr3/TNij?=
 =?iso-8859-1?Q?Z9NrIrKJis5YtUciY+a4dqdkur66WJ57MkXCjGItEYi33wemZ54nGZcWn+?=
 =?iso-8859-1?Q?wahd8YsRxDTdQaT2RltCZk6IyfpTPPoy4Rt8SsjGO1mqwDFzeZCRBaFrw5?=
 =?iso-8859-1?Q?VGVS/SxeqepScmxfXzmGRqLawDjSyFwlfbCPJXYtYuf2S8IdLPNQcTP2jY?=
 =?iso-8859-1?Q?FVjmsMSrQkKq4IjgjKlvyngiry7S4FRa4gBWxbuq2bM4l5Yqco/pr/UvKs?=
 =?iso-8859-1?Q?hhnvbdCW+uP34qgPlUuKFQDNCj1TYh+4zAyMK6Q1gDKpezB6EWiIN1/Zmr?=
 =?iso-8859-1?Q?vAqrrLCbbT7h5U0PIEgwHnEvmk8rPSe14MScMjz4SzvMflHv24ZiyCNgiQ?=
 =?iso-8859-1?Q?pSJ/JaFknfVbqxFxR5GkEUgvZMS2nY5wtIUSQ+5byDR5Jnu4hbPSucHaNp?=
 =?iso-8859-1?Q?V1yhw5N6Q13NWLMUwYe1OyEbC5IXOFhnxre7liUF1OeU2sg3G2DHNIBBmH?=
 =?iso-8859-1?Q?L/Ptcj2Xwmd2ieOCyyt8Q5uVdfhswu6lwX0Wj/jZaD4Msuo+QgLrybaObI?=
 =?iso-8859-1?Q?p6o0jaQr1b5nao+89cKuANUucbVCxsz3G8N7MQCUiKX0h9q2MNVv9vP4rj?=
 =?iso-8859-1?Q?YdLAE4A6JzSXr7Yh33glHeNp1e6yqaLBCOYKN5dJn391MSmmB5jhP1OZ24?=
 =?iso-8859-1?Q?RajkDx7rafb+wiDFqef5GNLKGymt1C0yeqWHxtvQcaPw0zCI3ZzjW3eQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7990ec-c491-49f0-23af-08dc30480498
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:08:29.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA43Dwh919TfREJXLgnuMK8FpnTjAIEtQ3t2tGbBt2L8hWnKNgM5alg7iFhTYFgnyKTZhVDdAQe4eB3HAH9IeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4580
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -100.0% regression of stress-ng.lockf.ops_per_sec on:


commit: b6be3714005c3933886be71011f19119e219e77c ("filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	test: lockf
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.lockf.ops_per_sec -100.0% regression                                          |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1HDD                                                                                          |
|                  | fs=btrfs                                                                                           |
|                  | nr_threads=10%                                                                                     |
|                  | test=lockf                                                                                         |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 23.3% improvement                                     |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=process                                                                                       |
|                  | nr_task=100%                                                                                       |
|                  | test=lock2                                                                                         |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.lockf.ops_per_sec -100.0% regression                                          |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1HDD                                                                                          |
|                  | fs=xfs                                                                                             |
|                  | nr_threads=10%                                                                                     |
|                  | test=lockf                                                                                         |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402181229.f8147f40-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240218/202402181229.f8147f40-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/lockf/stress-ng/60s

commit: 
  1a62c22a15 ("filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core")
  b6be371400 ("filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core")

1a62c22a156f7235 b6be3714005c3933886be71011f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.572e+09           +10.4%  3.944e+09        cpuidle..time
     90.09           +10.0%      99.08        iostat.cpu.idle
      9.64           -92.6%       0.71        iostat.cpu.system
     15185 ± 97%    +208.7%      46869 ± 34%  numa-numastat.node0.other_node
     51039 ± 29%     -62.1%      19340 ± 84%  numa-numastat.node1.other_node
     27650 ±  2%     -44.4%      15373 ±  2%  meminfo.Active
     21321 ±  2%     -57.9%       8981 ±  2%  meminfo.Active(anon)
     98479           -14.4%      84297        meminfo.Shmem
     89.85            +9.3       99.12        mpstat.cpu.all.idle%
      9.25            -9.2        0.07 ±  3%  mpstat.cpu.all.sys%
      0.21            -0.1        0.14        mpstat.cpu.all.usr%
     23916 ±  9%     -49.3%      12134 ± 24%  numa-meminfo.node1.Active
     19703 ±  3%     -60.1%       7867 ±  4%  numa-meminfo.node1.Active(anon)
     57867 ± 60%     -43.6%      32652 ±101%  numa-meminfo.node1.Shmem
     90.17            +9.6%      98.83        vmstat.cpu.id
      6.29           -91.9%       0.51 ±  4%  vmstat.procs.r
      3738 ±  8%     -35.1%       2427 ± 19%  vmstat.system.cs
     70698            -7.4%      65440        vmstat.system.in
     15185 ± 97%    +208.7%      46869 ± 34%  numa-vmstat.node0.numa_other
      4926 ±  3%     -60.1%       1967 ±  4%  numa-vmstat.node1.nr_active_anon
     14467 ± 60%     -43.6%       8163 ±101%  numa-vmstat.node1.nr_shmem
      4926 ±  3%     -60.1%       1967 ±  4%  numa-vmstat.node1.nr_zone_active_anon
     51039 ± 29%     -62.1%      19340 ± 84%  numa-vmstat.node1.numa_other
     30.50 ± 86%     -91.3%       2.67 ± 51%  perf-c2c.DRAM.local
      1492 ± 56%     -98.9%      15.67 ± 23%  perf-c2c.DRAM.remote
      3001 ±  9%     -98.1%      57.83 ± 14%  perf-c2c.HITM.local
    146.83 ± 43%     -94.6%       8.00 ± 20%  perf-c2c.HITM.remote
      3148 ±  9%     -97.9%      65.83 ± 13%  perf-c2c.HITM.total
  17091608 ±  2%    -100.0%       7384 ±  3%  stress-ng.lockf.ops
    284857 ±  2%    -100.0%     123.07 ±  3%  stress-ng.lockf.ops_per_sec
      1077 ±  5%     -99.1%       9.50 ± 31%  stress-ng.time.involuntary_context_switches
    601.83          -100.0%       0.00        stress-ng.time.percent_of_cpu_this_job_got
    359.06          -100.0%       0.10 ±  3%  stress-ng.time.system_time
     34700 ±  7%     -99.5%     161.33 ± 10%  stress-ng.time.voluntary_context_switches
    367.83           -89.6%      38.17        turbostat.Avg_MHz
     10.24            -9.2        1.06        turbostat.Busy%
     90.54            +9.2       99.79        turbostat.C1%
     89.76           +10.2%      98.94        turbostat.CPU%c1
      0.20 ±  2%     +19.2%       0.24 ±  2%  turbostat.IPC
    264.20            -9.4%     239.43        turbostat.PkgWatt
     66.96            -8.6%      61.21        turbostat.RAMWatt
      5330 ±  2%     -58.1%       2234        proc-vmstat.nr_active_anon
     26927            -1.9%      26403        proc-vmstat.nr_mapped
     24621           -14.3%      21111        proc-vmstat.nr_shmem
     39703            -1.4%      39164        proc-vmstat.nr_slab_unreclaimable
      5330 ±  2%     -58.1%       2234        proc-vmstat.nr_zone_active_anon
    384532            -2.0%     376963        proc-vmstat.numa_hit
    318307            -2.4%     310753        proc-vmstat.numa_local
     29018           -22.0%      22637        proc-vmstat.pgactivate
    434537            -1.6%     427527        proc-vmstat.pgalloc_normal
     10289            +2.8%      10572        proc-vmstat.pgreuse
      0.01 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.00           -45.8%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00           +50.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ±  9%     +65.2%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.05 ± 15%     -80.9%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5.99 ± 84%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      3.61 ± 11%     -26.4%       2.66        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 17%     -53.8%       0.00        perf-sched.total_sch_delay.average.ms
      7.06 ± 56%     -62.3%       2.66        perf-sched.total_sch_delay.max.ms
    129.01 ±  5%    +139.6%     309.15 ±  5%  perf-sched.total_wait_and_delay.average.ms
      5439 ±  3%     -59.5%       2200 ±  2%  perf-sched.total_wait_and_delay.count.ms
    129.00 ±  5%    +139.6%     309.14 ±  5%  perf-sched.total_wait_time.average.ms
     10.83 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      1.40 ±101%    +193.8%       4.12 ± 11%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      8.12 ±  6%    +567.9%      54.22 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      9.16 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    536.30 ±  4%     -13.1%     466.10 ±  5%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2660 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
    233.67 ±  5%      +9.6%     256.00 ±  2%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     14.83 ±100%    +132.6%      34.50 ±  3%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    608.33 ±  6%     -85.2%      90.00 ± 13%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     82.33 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    475.90 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     60.67 ± 81%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     10.83 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      2.72 ±  9%     +51.2%       4.12 ± 11%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      8.11 ±  6%    +568.1%      54.21 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      9.16 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    536.24 ±  4%     -13.1%     466.09 ±  5%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    475.90 ± 20%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     60.66 ± 81%    -100.0%       0.00        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3528 ±  4%     +10.3%       3890 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
      0.25 ±  7%     -41.6%       0.14 ± 16%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.43 ±  2%     -28.3%       0.31 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
   1048576           -34.2%     690362 ±  6%  sched_debug.cfs_rq:/.load.max
    138483 ± 14%     -29.0%      98365 ± 12%  sched_debug.cfs_rq:/.load.stddev
      1201 ± 84%     -82.7%     207.67 ± 24%  sched_debug.cfs_rq:/.load_avg.avg
     47820 ± 84%     -87.5%       5972 ± 37%  sched_debug.cfs_rq:/.load_avg.max
      6721 ± 87%     -88.3%     788.02 ± 37%  sched_debug.cfs_rq:/.load_avg.stddev
      3528 ±  4%     +10.3%       3890 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
      0.25 ±  7%     -41.6%       0.14 ± 16%  sched_debug.cfs_rq:/.nr_running.avg
      0.43 ±  2%     -28.3%       0.31 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
    508.54 ±  5%     -48.1%     263.75 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      1473 ± 27%     -29.3%       1042 ±  9%  sched_debug.cfs_rq:/.runnable_avg.max
    340.50 ±  6%     -31.4%     233.62 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    507.78 ±  5%     -48.2%     263.28 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
      1472 ± 27%     -29.2%       1042 ±  9%  sched_debug.cfs_rq:/.util_avg.max
    339.88 ±  6%     -31.3%     233.44 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
     50.39 ± 12%     -43.8%      28.32 ± 18%  sched_debug.cfs_rq:/.util_est.avg
      1004 ±  2%     -35.8%     645.25 ± 17%  sched_debug.cfs_rq:/.util_est.max
    168.87 ±  5%     -38.0%     104.65 ± 17%  sched_debug.cfs_rq:/.util_est.stddev
    654911 ±  3%     +25.2%     819757        sched_debug.cpu.avg_idle.avg
      3664 ± 18%   +6033.5%     224784 ± 23%  sched_debug.cpu.avg_idle.min
    268181 ±  6%     -34.3%     176135 ±  4%  sched_debug.cpu.avg_idle.stddev
     58667 ±  7%     +47.3%      86389 ±  7%  sched_debug.cpu.clock.avg
     58669 ±  7%     +47.3%      86392 ±  7%  sched_debug.cpu.clock.max
     58662 ±  7%     +47.3%      86387 ±  7%  sched_debug.cpu.clock.min
      1.61 ± 15%     -21.9%       1.26 ±  8%  sched_debug.cpu.clock.stddev
     58402 ±  7%     +47.2%      85940 ±  7%  sched_debug.cpu.clock_task.avg
     58660 ±  7%     +46.9%      86198 ±  7%  sched_debug.cpu.clock_task.max
     50177 ±  8%     +55.2%      77858 ±  8%  sched_debug.cpu.clock_task.min
    811.59 ±  4%     -38.4%     499.73 ± 19%  sched_debug.cpu.curr->pid.avg
      3752           +26.6%       4749        sched_debug.cpu.curr->pid.max
      1494           -19.8%       1199 ±  7%  sched_debug.cpu.curr->pid.stddev
      0.25 ±  4%     -42.1%       0.14 ± 15%  sched_debug.cpu.nr_running.avg
      0.43           -29.0%       0.31 ±  5%  sched_debug.cpu.nr_running.stddev
      3334 ±  2%     +36.2%       4541 ±  5%  sched_debug.cpu.nr_switches.avg
    226.00 ± 24%     +95.5%     441.92 ± 23%  sched_debug.cpu.nr_switches.min
     58665 ±  7%     +47.3%      86388 ±  7%  sched_debug.cpu_clk
     57434 ±  8%     +48.3%      85159 ±  7%  sched_debug.ktime
     59405 ±  7%     +46.9%      87244 ±  7%  sched_debug.sched_clk
      1.69 ± 27%     -72.0%       0.47 ±  5%  perf-stat.i.MPKI
 3.498e+09 ±  2%     -94.5%  1.938e+08        perf-stat.i.branch-instructions
      0.20            +0.9        1.07        perf-stat.i.branch-miss-rate%
   7639452           -53.1%    3582812        perf-stat.i.branch-misses
     29.10 ± 22%     -19.0       10.12 ±  3%  perf-stat.i.cache-miss-rate%
  22489354 ± 26%     -98.3%     380411 ±  2%  perf-stat.i.cache-misses
  76176693 ±  5%     -95.7%    3277871        perf-stat.i.cache-references
      3582 ±  8%     -38.0%       2220 ± 21%  perf-stat.i.context-switches
      1.73 ±  2%     +61.6%       2.79        perf-stat.i.cpi
 2.302e+10           -93.0%  1.604e+09        perf-stat.i.cpu-cycles
    101.29           -15.1%      86.04        perf-stat.i.cpu-migrations
      1203 ± 37%    +446.5%       6577 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.00 ±127%      +0.0        0.03 ± 10%  perf-stat.i.dTLB-load-miss-rate%
    115925 ±124%     -62.4%      43584 ±  9%  perf-stat.i.dTLB-load-misses
 4.818e+09 ±  2%     -95.0%  2.411e+08        perf-stat.i.dTLB-loads
      0.00 ±  4%      +0.0        0.02 ±  2%  perf-stat.i.dTLB-store-miss-rate%
 4.374e+08 ±  2%     -76.7%  1.019e+08        perf-stat.i.dTLB-stores
 1.341e+10 ±  2%     -93.0%  9.429e+08        perf-stat.i.instructions
      0.58 ±  2%     -25.7%       0.43        perf-stat.i.ipc
      0.36           -93.0%       0.03        perf-stat.i.metric.GHz
    107.37 ± 26%    +531.8%     678.37 ±  8%  perf-stat.i.metric.K/sec
    137.92 ±  2%     -94.4%       7.75        perf-stat.i.metric.M/sec
      2941 ±  2%      -3.7%       2832 ±  2%  perf-stat.i.minor-faults
     97.31           -11.5       85.76 ±  2%  perf-stat.i.node-load-miss-rate%
   4628803 ± 28%     -98.7%      58166 ±  3%  perf-stat.i.node-load-misses
    129680 ± 32%     -83.1%      21863 ± 12%  perf-stat.i.node-loads
     19.67 ± 15%     +16.8       36.51 ± 28%  perf-stat.i.node-store-miss-rate%
    268706 ± 15%     -90.5%      25560 ± 19%  perf-stat.i.node-store-misses
   1157938 ± 27%     -94.8%      59983 ±  8%  perf-stat.i.node-stores
      2941 ±  2%      -3.7%       2832 ±  2%  perf-stat.i.page-faults
      1.68 ± 26%     -76.0%       0.40 ±  2%  perf-stat.overall.MPKI
      0.22            +1.6        1.85        perf-stat.overall.branch-miss-rate%
     29.26 ± 22%     -17.7       11.60 ±  2%  perf-stat.overall.cache-miss-rate%
      1118 ± 33%    +277.1%       4218 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±127%      +0.0        0.02 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  4%      +0.0        0.02 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
     97.29           -24.6       72.71 ±  4%  perf-stat.overall.node-load-miss-rate%
     19.49 ± 15%     +10.4       29.90 ± 19%  perf-stat.overall.node-store-miss-rate%
  3.44e+09 ±  2%     -94.5%  1.907e+08        perf-stat.ps.branch-instructions
   7510361           -53.0%    3526771        perf-stat.ps.branch-misses
  22114471 ± 26%     -98.3%     374166 ±  2%  perf-stat.ps.cache-misses
  74907353 ±  5%     -95.7%    3224303        perf-stat.ps.cache-references
      3521 ±  8%     -38.0%       2184 ± 21%  perf-stat.ps.context-switches
 2.264e+10           -93.0%  1.577e+09        perf-stat.ps.cpu-cycles
     99.62           -15.1%      84.61        perf-stat.ps.cpu-migrations
    113992 ±124%     -62.4%      42865 ±  9%  perf-stat.ps.dTLB-load-misses
 4.738e+09 ±  2%     -95.0%  2.372e+08        perf-stat.ps.dTLB-loads
 4.301e+08 ±  2%     -76.7%  1.002e+08        perf-stat.ps.dTLB-stores
 1.318e+10 ±  2%     -93.0%  9.277e+08        perf-stat.ps.instructions
   4551594 ± 28%     -98.7%      57203 ±  3%  perf-stat.ps.node-load-misses
    127466 ± 32%     -83.1%      21507 ± 12%  perf-stat.ps.node-loads
    264208 ± 15%     -90.5%      25142 ± 19%  perf-stat.ps.node-store-misses
   1138534 ± 27%     -94.8%      58991 ±  8%  perf-stat.ps.node-stores
 8.023e+11 ±  2%     -93.0%  5.609e+10        perf-stat.total.instructions
     92.48           -92.5        0.00        perf-profile.calltrace.cycles-pp.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     91.75           -91.7        0.00        perf-profile.calltrace.cycles-pp.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
     91.34           -91.3        0.00        perf-profile.calltrace.cycles-pp.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     70.08           -70.1        0.00        perf-profile.calltrace.cycles-pp.__libc_fcntl64
     69.85           -69.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     69.82           -69.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     69.76           -69.8        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     69.69           -69.7        0.00        perf-profile.calltrace.cycles-pp.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     23.10 ±  2%     -23.1        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.05 ±  2%     -23.0        0.00        perf-profile.calltrace.cycles-pp.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.23 ±  2%     -22.5        0.73 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.21 ±  2%     -22.5        0.73 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.72 ± 12%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.7        0.74 ± 13%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.9        0.88 ± 14%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.00            +0.9        0.91 ± 21%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu
      0.00            +1.0        0.99 ± 51%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.1        1.06 ± 10%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.2        1.21 ± 14%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.5        1.47 ±  7%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.5        1.52 ± 19%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.00            +1.5        1.53 ± 11%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.6        1.61 ± 18%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.00            +1.6        1.62 ± 18%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.00            +1.6        1.62 ± 18%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.6        1.62 ± 18%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.00            +1.6        1.62 ± 18%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.00            +1.6        1.62 ± 18%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.6        1.62 ± 18%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.6        1.62 ± 18%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.7        1.68 ± 11%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.7        1.68 ± 13%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.9        1.94 ± 25%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.0        1.97 ± 15%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00            +2.2        2.23 ± 67%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +2.4        2.43 ± 10%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +2.5        2.47 ± 10%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.5        2.52 ± 58%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +3.1        3.06 ±  8%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +3.9        3.86 ±  6%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +4.6        4.55 ±  6%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.08 ±223%      +7.7        7.76 ± 12%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      0.66 ±  9%     +11.5       12.12 ±  6%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.67 ±  9%     +11.8       12.44 ±  6%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.88 ± 10%     +15.2       16.06 ±  4%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.97 ± 10%     +16.5       17.48 ±  4%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.98 ± 10%     +16.7       17.65 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.11 ± 10%     +18.9       20.00 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.32 ±  9%     +23.0       24.34 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.54 ± 10%     +27.3       28.85 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.59 ±  9%     +28.2       29.82 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      2.10 ±  8%     +36.5       38.64 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      2.51 ±  8%     +45.1       47.58 ±  4%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.72 ±  8%     +83.7       88.46        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.84 ±  8%     +84.3       89.14        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.81 ±  8%     +85.4       90.18        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      5.07 ±  7%     +88.6       93.63        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.12 ±  7%     +89.4       94.50        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.13 ±  7%     +89.6       94.72        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.13 ±  7%     +89.6       94.72        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      5.22 ±  8%     +91.1       96.35        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      6.52 ±  7%    +117.2      123.76        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     92.88           -92.9        0.00        perf-profile.children.cycles-pp.__x64_sys_fcntl
     92.75           -92.8        0.00        perf-profile.children.cycles-pp.do_fcntl
     92.51           -92.5        0.00        perf-profile.children.cycles-pp.fcntl_setlk
     91.76           -91.8        0.00        perf-profile.children.cycles-pp.do_lock_file_wait
     93.81           -91.7        2.10 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     93.74           -91.6        2.10 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     91.40           -91.4        0.00        perf-profile.children.cycles-pp.posix_lock_inode
     70.15           -70.1        0.00        perf-profile.children.cycles-pp.__libc_fcntl64
      1.45 ±  5%      -1.4        0.08 ± 54%  perf-profile.children.cycles-pp.kmem_cache_alloc
      1.26 ±  7%      -1.1        0.13 ± 26%  perf-profile.children.cycles-pp.kmem_cache_free
      2.12 ±  6%      -1.0        1.16 ± 21%  perf-profile.children.cycles-pp._raw_spin_lock
      1.02 ±  3%      -1.0        0.06 ± 54%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.1        0.07 ± 29%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.00            +0.1        0.08 ± 28%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.00            +0.1        0.08 ± 30%  perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.1        0.09 ± 30%  perf-profile.children.cycles-pp.__bitmap_and
      0.00            +0.1        0.09 ± 40%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.00            +0.1        0.10 ± 44%  perf-profile.children.cycles-pp.begin_new_exec
      0.00            +0.1        0.10 ± 26%  perf-profile.children.cycles-pp._dl_addr
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.00            +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.elf_load
      0.00            +0.1        0.10 ± 41%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.1        0.10 ± 38%  perf-profile.children.cycles-pp.cpu_util
      0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.10 ± 17%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.1        0.11 ± 44%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.1        0.11 ± 48%  perf-profile.children.cycles-pp.__do_sys_clone
      0.00            +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.00            +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.__mmap
      0.00            +0.1        0.11 ± 35%  perf-profile.children.cycles-pp.copy_process
      0.00            +0.1        0.12 ± 36%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.1        0.12 ± 24%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.12 ± 36%  perf-profile.children.cycles-pp.zap_pte_range
      0.00            +0.1        0.12 ± 34%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.00            +0.1        0.12 ± 36%  perf-profile.children.cycles-pp.zap_pmd_range
      0.00            +0.1        0.13 ± 29%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.13 ± 31%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.1        0.13 ± 26%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.13 ± 37%  perf-profile.children.cycles-pp.__libc_fork
      0.00            +0.1        0.13 ± 36%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.00            +0.1        0.14 ± 50%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +0.1        0.14 ± 22%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.1        0.14 ± 32%  perf-profile.children.cycles-pp.unmap_page_range
      0.00            +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.1        0.14 ± 21%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.1        0.14 ± 27%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.14 ± 22%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.ct_nmi_exit
      0.00            +0.1        0.14 ± 29%  perf-profile.children.cycles-pp.unmap_vmas
      0.00            +0.1        0.14 ± 32%  perf-profile.children.cycles-pp.kernel_clone
      0.00            +0.2        0.15 ± 34%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.00            +0.2        0.15 ± 18%  perf-profile.children.cycles-pp.hrtimer_forward
      0.02 ± 99%      +0.2        0.18 ± 27%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.2        0.16 ± 32%  perf-profile.children.cycles-pp.schedule
      0.00            +0.2        0.16 ± 19%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.2        0.17 ± 29%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.2        0.17 ± 16%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +0.2        0.18 ± 23%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.2        0.18 ± 38%  perf-profile.children.cycles-pp.error_return
      0.00            +0.2        0.18 ± 42%  perf-profile.children.cycles-pp.path_openat
      0.00            +0.2        0.19 ± 43%  perf-profile.children.cycles-pp.do_filp_open
      0.00            +0.2        0.20 ± 39%  perf-profile.children.cycles-pp.cmd_stat
      0.00            +0.2        0.20 ± 24%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.00            +0.2        0.20 ± 39%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +0.2        0.20 ± 38%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.2        0.20 ± 39%  perf-profile.children.cycles-pp.process_interval
      0.00            +0.2        0.20 ± 36%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.2        0.21 ± 23%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.2        0.21 ± 23%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.2        0.21 ±  9%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.2        0.21 ± 36%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +0.2        0.21 ± 40%  perf-profile.children.cycles-pp.__libc_start_main
      0.00            +0.2        0.21 ± 40%  perf-profile.children.cycles-pp.main
      0.00            +0.2        0.21 ± 40%  perf-profile.children.cycles-pp.run_builtin
      0.01 ±223%      +0.2        0.23 ± 32%  perf-profile.children.cycles-pp.__schedule
      0.00            +0.2        0.22 ± 27%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.00            +0.2        0.24 ± 34%  perf-profile.children.cycles-pp.__memcpy
      0.00            +0.2        0.24 ± 25%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.2        0.24 ± 33%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.00            +0.2        0.24 ± 22%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.exit_mm
      0.00            +0.3        0.25 ± 29%  perf-profile.children.cycles-pp.filemap_map_pages
      0.00            +0.3        0.26 ± 24%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.3        0.26 ± 11%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.00            +0.3        0.26 ± 31%  perf-profile.children.cycles-pp.mmap_region
      0.00            +0.3        0.27 ± 27%  perf-profile.children.cycles-pp.do_read_fault
      0.00            +0.3        0.27 ± 19%  perf-profile.children.cycles-pp.irqentry_exit
      0.01 ±223%      +0.3        0.28 ± 41%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.3        0.28 ± 40%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.3        0.28 ± 32%  perf-profile.children.cycles-pp.do_mmap
      0.00            +0.3        0.28 ± 23%  perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.3        0.28 ± 24%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.3        0.29 ± 27%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +0.3        0.30 ± 29%  perf-profile.children.cycles-pp.__mmput
      0.00            +0.3        0.30 ± 30%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +0.3        0.30 ± 26%  perf-profile.children.cycles-pp.do_fault
      0.00            +0.3        0.30 ± 19%  perf-profile.children.cycles-pp.read
      0.00            +0.3        0.30 ± 56%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.00            +0.3        0.30 ± 29%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.3        0.30 ± 28%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.3        0.30 ± 28%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.3        0.31 ± 15%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.3        0.31 ± 18%  perf-profile.children.cycles-pp.vfs_read
      0.00            +0.3        0.32 ± 26%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.exec_binprm
      0.00            +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.search_binary_handler
      0.00            +0.3        0.33 ± 21%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.3        0.33 ± 19%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.3        0.34 ± 15%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.3        0.34 ± 13%  perf-profile.children.cycles-pp.irqentry_enter
      0.00            +0.4        0.35 ± 17%  perf-profile.children.cycles-pp.bprm_execve
      0.00            +0.4        0.36 ± 21%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.4        0.39 ± 19%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.4        0.40 ± 13%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.00            +0.4        0.42 ± 30%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.4        0.42 ± 18%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.4        0.43 ± 14%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +0.4        0.43 ± 12%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.4        0.44 ± 25%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.4        0.44 ± 17%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.4        0.44 ± 22%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.4        0.45 ±  8%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.5        0.46 ± 17%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.5        0.46 ± 12%  perf-profile.children.cycles-pp.kthread
      0.00            +0.5        0.46 ±  9%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.5        0.47 ± 16%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +0.5        0.48 ± 24%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.5        0.48 ± 15%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.5        0.49 ± 28%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.5        0.50 ± 12%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.5        0.50 ±  9%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +0.5        0.50 ±  9%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.5        0.50 ±  9%  perf-profile.children.cycles-pp.execve
      0.00            +0.5        0.50 ± 18%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.5        0.50 ± 12%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.5        0.50 ± 13%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.01 ±223%      +0.5        0.52 ± 15%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +0.5        0.51 ± 23%  perf-profile.children.cycles-pp.should_we_balance
      0.01 ±223%      +0.5        0.52 ± 14%  perf-profile.children.cycles-pp.exc_page_fault
      0.00            +0.5        0.53 ± 21%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.02 ±141%      +0.6        0.58 ± 14%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.02 ±141%      +0.6        0.59 ± 10%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.01 ±223%      +0.6        0.58 ± 13%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.6        0.60 ± 11%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.04 ± 44%      +0.6        0.64 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.7        0.68 ± 15%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.02 ±141%      +0.7        0.74 ± 13%  perf-profile.children.cycles-pp.update_blocked_averages
      0.06 ± 11%      +0.7        0.80 ± 22%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.02 ± 99%      +0.7        0.76 ±  7%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.02 ±141%      +0.7        0.76 ± 14%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.03 ± 70%      +0.8        0.85 ± 17%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.05 ± 47%      +0.8        0.90 ±  7%  perf-profile.children.cycles-pp.sched_clock
      0.05 ±  7%      +0.9        0.92 ± 13%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.07 ±  9%      +0.9        0.98 ± 20%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.07 ±  6%      +1.0        1.03 ± 19%  perf-profile.children.cycles-pp.find_busiest_group
      0.06 ± 46%      +1.0        1.02 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.08 ± 59%      +1.0        1.12 ± 42%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.07 ± 16%      +1.1        1.17 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.07 ± 16%      +1.2        1.28 ± 14%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.07 ± 12%      +1.3        1.38 ± 13%  perf-profile.children.cycles-pp.read_tsc
      0.09 ± 13%      +1.5        1.54 ±  7%  perf-profile.children.cycles-pp.perf_rotate_context
      0.08 ±  4%      +1.5        1.60 ± 10%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.10 ± 11%      +1.5        1.62 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ± 41%      +1.5        1.62 ± 18%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.08 ± 41%      +1.5        1.62 ± 18%  perf-profile.children.cycles-pp.rest_init
      0.08 ± 41%      +1.5        1.62 ± 18%  perf-profile.children.cycles-pp.start_kernel
      0.08 ± 41%      +1.5        1.62 ± 18%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.08 ± 41%      +1.5        1.62 ± 18%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.10 ± 13%      +1.6        1.73 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      0.12 ±  8%      +1.7        1.81 ± 13%  perf-profile.children.cycles-pp.load_balance
      0.10 ± 60%      +1.9        1.98 ± 25%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.10 ± 11%      +1.9        2.02 ± 14%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.16 ± 43%      +2.1        2.29 ± 67%  perf-profile.children.cycles-pp.tick_irq_enter
      0.14 ±  6%      +2.4        2.54 ± 10%  perf-profile.children.cycles-pp.rebalance_domains
      0.14 ± 12%      +2.4        2.53 ±  9%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.18 ± 37%      +2.4        2.58 ± 58%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.17 ±  6%      +3.0        3.18 ±  7%  perf-profile.children.cycles-pp.menu_select
      0.24 ± 36%      +3.6        3.79 ± 51%  perf-profile.children.cycles-pp.ktime_get
      0.22 ±  8%      +3.7        3.97 ±  6%  perf-profile.children.cycles-pp.__do_softirq
      0.27 ±  7%      +4.4        4.66 ±  6%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.54 ±  8%      +8.5        9.06 ± 11%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.76 ±  8%     +11.8       12.58 ±  6%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.76 ±  8%     +11.9       12.66 ±  6%  perf-profile.children.cycles-pp.perf_event_task_tick
      1.04 ±  8%     +15.4       16.41 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      1.14 ±  8%     +16.7       17.83 ±  4%  perf-profile.children.cycles-pp.update_process_times
      1.16 ±  8%     +16.8       17.97 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      1.30 ±  8%     +19.0       20.32 ±  3%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      1.55 ±  7%     +23.1       24.67 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.79 ±  8%     +27.3       29.10 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.84 ±  8%     +28.2       30.03 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.38 ±  8%     +36.5       38.84 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.68 ±  7%     +77.3       81.94        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      4.80 ±  8%     +83.5       88.33        perf-profile.children.cycles-pp.acpi_safe_halt
      4.81 ±  8%     +83.7       88.52        perf-profile.children.cycles-pp.acpi_idle_enter
      4.90 ±  8%     +85.3       90.24        perf-profile.children.cycles-pp.cpuidle_enter_state
      4.92 ±  8%     +85.8       90.71        perf-profile.children.cycles-pp.cpuidle_enter
      5.13 ±  7%     +89.6       94.72        perf-profile.children.cycles-pp.start_secondary
      5.16 ±  8%     +90.2       95.39        perf-profile.children.cycles-pp.cpuidle_idle_call
      5.22 ±  8%     +91.1       96.35        perf-profile.children.cycles-pp.cpu_startup_entry
      5.22 ±  8%     +91.1       96.35        perf-profile.children.cycles-pp.do_idle
      5.22 ±  8%     +91.1       96.35        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     86.59           -86.6        0.00        perf-profile.self.cycles-pp.posix_lock_inode
      1.01 ±  3%      -1.0        0.06 ± 54%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.34 ±  4%      -0.3        0.03 ±101%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.08 ± 31%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.08 ± 33%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.1        0.08 ± 40%  perf-profile.self.cycles-pp.cpu_util
      0.00            +0.1        0.08 ± 33%  perf-profile.self.cycles-pp.ct_idle_exit
      0.00            +0.1        0.09 ± 43%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.__bitmap_and
      0.00            +0.1        0.09 ± 40%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.10 ± 35%  perf-profile.self.cycles-pp.ct_kernel_exit
      0.00            +0.1        0.10 ± 43%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.10 ± 39%  perf-profile.self.cycles-pp.note_gp_changes
      0.00            +0.1        0.10 ± 31%  perf-profile.self.cycles-pp.tick_nohz_highres_handler
      0.00            +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.11 ± 20%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.00            +0.1        0.11 ± 35%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.00            +0.1        0.11 ± 39%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.00            +0.1        0.11 ± 43%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.12 ± 27%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.12 ± 21%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.12 ± 22%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.13 ± 19%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.1        0.13 ± 21%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.1        0.13 ± 21%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.1        0.13 ± 21%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.1        0.14 ± 30%  perf-profile.self.cycles-pp.ct_nmi_exit
      0.00            +0.1        0.14 ± 29%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.15 ± 39%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.2        0.15 ± 20%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.16 ± 39%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.2        0.16 ± 22%  perf-profile.self.cycles-pp.__do_softirq
      0.00            +0.2        0.16 ± 21%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.00            +0.2        0.16 ± 32%  perf-profile.self.cycles-pp.menu_reflect
      0.00            +0.2        0.16 ± 39%  perf-profile.self.cycles-pp.acpi_idle_enter
      0.00            +0.2        0.16 ± 39%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.2        0.17 ± 22%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.2        0.19 ± 33%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.2        0.19 ± 36%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.2        0.20 ± 31%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.2        0.22 ± 34%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.2        0.22 ± 20%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.00            +0.2        0.22 ± 46%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.2        0.24 ± 34%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.2        0.24 ± 21%  perf-profile.self.cycles-pp.tick_irq_enter
      0.00            +0.2        0.24 ± 26%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.3        0.26 ± 15%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.3        0.26 ± 25%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.3        0.27 ± 29%  perf-profile.self.cycles-pp.perf_rotate_context
      0.01 ±223%      +0.3        0.28 ± 39%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.3        0.28 ± 33%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.00            +0.3        0.28 ± 26%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.3        0.28 ± 25%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.3        0.28 ± 27%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.3        0.29 ± 15%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.3        0.30 ± 57%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.00            +0.3        0.31 ± 25%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.3        0.32 ± 15%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.3        0.33 ± 15%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.3        0.33 ±  8%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.3        0.35 ± 19%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.4        0.37 ± 19%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.4        0.38 ± 26%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.4        0.38 ± 24%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.4        0.40 ± 19%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.00            +0.4        0.40 ± 29%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.4        0.43 ± 26%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.00            +0.4        0.44 ± 22%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.5        0.46 ± 18%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.5        0.48 ± 20%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.5        0.50 ± 16%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.03 ± 70%      +0.5        0.56 ± 16%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.01 ±223%      +0.6        0.58 ± 24%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.01 ±223%      +0.6        0.61 ±  6%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.7        0.68 ± 15%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.01 ±223%      +0.7        0.71 ± 15%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.04 ±103%      +0.8        0.84 ± 56%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.02 ± 99%      +0.8        0.84 ± 17%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.06 ± 13%      +0.9        1.00 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.06 ± 11%      +1.0        1.11 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.07 ± 16%      +1.2        1.28 ± 15%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.07 ±  8%      +1.3        1.33 ± 13%  perf-profile.self.cycles-pp.read_tsc
      0.10 ± 11%      +1.5        1.62 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.08 ± 78%      +1.7        1.74 ± 31%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.10 ± 11%      +1.9        2.01 ± 14%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.17 ± 50%      +2.5        2.65 ± 74%  perf-profile.self.cycles-pp.ktime_get
      0.23 ±  9%      +3.6        3.82 ±  7%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.54 ±  8%      +8.5        9.06 ± 11%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      2.49 ±  8%     +44.1       46.62 ±  3%  perf-profile.self.cycles-pp.acpi_safe_halt


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/lockf/stress-ng/60s

commit: 
  1a62c22a15 ("filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core")
  b6be371400 ("filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core")

1a62c22a156f7235 b6be3714005c3933886be71011f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.564e+09           +10.4%  3.936e+09        cpuidle..time
    154041 ± 18%     -22.2%     119887 ± 19%  numa-numastat.node0.local_node
     89.96           +10.0%      98.96        iostat.cpu.idle
      9.69           -92.1%       0.76 ±  2%  iostat.cpu.system
     23891 ±  2%     -51.7%      11536 ±  5%  meminfo.Active
     23794 ±  2%     -51.9%      11438 ±  5%  meminfo.Active(anon)
    101119           -13.8%      87125        meminfo.Shmem
     89.72            +9.3       99.00        mpstat.cpu.all.idle%
      9.30            -9.2        0.11 ±  8%  mpstat.cpu.all.sys%
      0.33            -0.1        0.26        mpstat.cpu.all.usr%
     21669 ±  6%     -55.8%       9584 ± 13%  numa-meminfo.node1.Active
     21620 ±  6%     -56.1%       9487 ± 13%  numa-meminfo.node1.Active(anon)
     58079 ± 54%     -75.5%      14200 ± 70%  numa-meminfo.node1.Mapped
     59989 ± 58%     -81.8%      10889 ± 10%  numa-meminfo.node1.Shmem
     90.01            +9.7%      98.72        vmstat.cpu.id
      6.42           -90.7%       0.59 ±  8%  vmstat.procs.r
      3806 ±  5%     -30.5%       2643 ± 10%  vmstat.system.cs
     70870            -7.3%      65727        vmstat.system.in
    154071 ± 18%     -22.2%     119942 ± 19%  numa-vmstat.node0.numa_local
      5405 ±  6%     -56.1%       2372 ± 13%  numa-vmstat.node1.nr_active_anon
     14521 ± 54%     -75.5%       3552 ± 70%  numa-vmstat.node1.nr_mapped
     14997 ± 58%     -81.8%       2723 ± 10%  numa-vmstat.node1.nr_shmem
      5405 ±  6%     -56.1%       2372 ± 13%  numa-vmstat.node1.nr_zone_active_anon
     42.00 ± 37%     -95.6%       1.83 ± 79%  perf-c2c.DRAM.local
      1731 ± 26%     -98.9%      18.67 ± 25%  perf-c2c.DRAM.remote
      2997 ±  5%     -98.4%      48.33 ± 16%  perf-c2c.HITM.local
    175.83 ± 16%     -93.2%      12.00 ± 30%  perf-c2c.HITM.remote
      3173 ±  5%     -98.1%      60.33 ± 16%  perf-c2c.HITM.total
  17216632 ±  3%    -100.0%       7605 ± 23%  stress-ng.lockf.ops
    286941 ±  3%    -100.0%     126.75 ± 23%  stress-ng.lockf.ops_per_sec
      1046           -98.9%      11.17 ± 34%  stress-ng.time.involuntary_context_switches
    601.67          -100.0%       0.00        stress-ng.time.percent_of_cpu_this_job_got
    359.02          -100.0%       0.10 ± 12%  stress-ng.time.system_time
     34085 ±  4%     -99.5%     157.67        stress-ng.time.voluntary_context_switches
    374.83           -88.3%      44.00 ±  3%  turbostat.Avg_MHz
     10.42            -9.2        1.22 ±  2%  turbostat.Busy%
     90.37            +9.3       99.65        turbostat.C1%
     89.58           +10.3%      98.78        turbostat.CPU%c1
    264.50            -9.3%     239.88        turbostat.PkgWatt
     66.25            -7.2%      61.47        turbostat.RAMWatt
      5949 ±  2%     -51.9%       2860 ±  5%  proc-vmstat.nr_active_anon
     27014            -1.8%      26540        proc-vmstat.nr_mapped
     25283           -13.8%      21783        proc-vmstat.nr_shmem
      5949 ±  2%     -51.9%       2860 ±  5%  proc-vmstat.nr_zone_active_anon
    390760            -2.3%     381957        proc-vmstat.numa_hit
    324547            -2.7%     315713        proc-vmstat.numa_local
     29359           -22.5%      22739        proc-vmstat.pgactivate
    439365            -2.0%     430491        proc-vmstat.pgalloc_normal
    311598            -2.6%     303623        proc-vmstat.pgfault
      0.00 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.01           -20.0%       0.00        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00           -41.7%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 14%     +50.0%       0.01        perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.04 ± 16%     -77.2%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 57%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      7.44 ± 91%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.01 ± 26%     -38.1%       0.00 ± 10%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3.71 ± 10%     -30.3%       2.58        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 27%     -63.0%       0.00 ± 22%  perf-sched.total_sch_delay.average.ms
     10.55 ± 42%     -75.5%       2.58        perf-sched.total_sch_delay.max.ms
     10.86 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      7.93 ± 10%    +581.3%      54.00 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    576.90 ±  3%     +12.0%     645.96 ±  7%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.05 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    533.07 ±  4%     -11.7%     470.88 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2654 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
    628.17 ± 11%     -85.9%      88.50 ±  9%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     80.50 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    617.43 ± 72%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     98.69 ± 95%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     10.85 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      2.72 ±  9%     +67.6%       4.56 ±  5%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      7.92 ± 10%    +581.9%      54.00 ± 10%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    576.90 ±  3%     +12.0%     645.95 ±  7%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.05 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    533.03 ±  4%     -11.7%     470.87 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    617.43 ± 72%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     98.69 ± 95%    -100.0%       0.00        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3298 ±  7%     +28.1%       4225 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
      0.24 ± 14%     -40.8%       0.14 ±  8%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.43 ±  5%     -29.5%       0.30 ±  2%  sched_debug.cfs_rq:/.h_nr_running.stddev
      2508 ± 20%     -52.1%       1200 ± 25%  sched_debug.cfs_rq:/.load_avg.avg
      3299 ±  7%     +28.1%       4225 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
      0.24 ± 14%     -40.8%       0.14 ±  8%  sched_debug.cfs_rq:/.nr_running.avg
      0.43 ±  5%     -29.5%       0.30 ±  2%  sched_debug.cfs_rq:/.nr_running.stddev
    102.39 ± 29%     -43.6%      57.72 ± 25%  sched_debug.cfs_rq:/.removed.load_avg.avg
    300.71 ± 12%     -30.8%     208.15 ± 18%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     39.94 ± 23%     -41.1%      23.52 ± 22%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    124.58 ± 10%     -25.8%      92.37 ± 19%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     39.94 ± 23%     -41.1%      23.52 ± 22%  sched_debug.cfs_rq:/.removed.util_avg.avg
    124.58 ± 10%     -25.9%      92.37 ± 19%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    518.50 ±  2%     -49.0%     264.40 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    331.76 ±  6%     -27.4%     240.71 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    516.26 ±  2%     -48.9%     263.71 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    330.53 ±  6%     -27.3%     240.22 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
     35.91 ± 17%     -48.3%      18.58 ± 15%  sched_debug.cfs_rq:/.util_est.avg
    119.46 ± 11%     -35.9%      76.63 ± 12%  sched_debug.cfs_rq:/.util_est.stddev
    659224 ±  2%     +23.8%     816276        sched_debug.cpu.avg_idle.avg
      9328 ±140%   +2769.4%     267661 ± 23%  sched_debug.cpu.avg_idle.min
    251490 ±  4%     -32.4%     170059 ±  7%  sched_debug.cpu.avg_idle.stddev
     38723           +78.0%      68945        sched_debug.cpu.clock.avg
     38726           +78.0%      68947        sched_debug.cpu.clock.max
     38719           +78.1%      68942        sched_debug.cpu.clock.min
     38467           +78.1%      68495        sched_debug.cpu.clock_task.avg
     38717           +77.6%      68756        sched_debug.cpu.clock_task.max
     30438           +98.3%      60372        sched_debug.cpu.clock_task.min
    772.45 ± 15%     -35.9%     495.18 ± 10%  sched_debug.cpu.curr->pid.avg
      3765           +26.5%       4761        sched_debug.cpu.curr->pid.max
      1460 ±  5%     -19.5%       1176 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.24 ± 15%     -39.0%       0.14 ± 10%  sched_debug.cpu.nr_running.avg
      0.43 ±  5%     -28.9%       0.30 ±  2%  sched_debug.cpu.nr_running.stddev
      3221           +40.4%       4522 ±  4%  sched_debug.cpu.nr_switches.avg
    200.83 ± 31%    +132.5%     467.00 ± 26%  sched_debug.cpu.nr_switches.min
     38721           +78.0%      68942        sched_debug.cpu_clk
     37491           +80.6%      67714        sched_debug.ktime
     39619           +75.5%      69552        sched_debug.sched_clk
      1.43 ± 24%     -69.4%       0.44 ±  4%  perf-stat.i.MPKI
 3.644e+09 ±  2%     -91.5%  3.091e+08        perf-stat.i.branch-instructions
      0.26            +0.9        1.20 ±  2%  perf-stat.i.branch-miss-rate%
  11046112           -36.5%    7011370        perf-stat.i.branch-misses
     25.61 ± 21%     -16.2        9.40 ±  4%  perf-stat.i.cache-miss-rate%
  19569987 ± 22%     -97.8%     432368 ±  4%  perf-stat.i.cache-misses
  76067317 ±  2%     -93.9%    4664346 ±  4%  perf-stat.i.cache-references
      3632 ±  5%     -32.5%       2450 ± 11%  perf-stat.i.context-switches
      1.69 ±  3%     +63.1%       2.76 ±  2%  perf-stat.i.cpi
  2.34e+10           -91.4%   2.02e+09 ±  2%  perf-stat.i.cpu-cycles
    102.01           -13.6%      88.19        perf-stat.i.cpu-migrations
      1373 ± 29%    +435.4%       7352 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.00 ±  3%      +0.0        0.03 ±  6%  perf-stat.i.dTLB-load-miss-rate%
     60346 ±  3%     -20.0%      48305 ±  4%  perf-stat.i.dTLB-load-misses
 4.972e+09 ±  3%     -92.9%  3.515e+08        perf-stat.i.dTLB-loads
      0.00 ±  3%      +0.0        0.02 ±  3%  perf-stat.i.dTLB-store-miss-rate%
  4.71e+08 ±  2%     -71.4%  1.346e+08        perf-stat.i.dTLB-stores
 1.409e+10 ±  2%     -89.2%  1.515e+09        perf-stat.i.instructions
      0.60 ±  2%     -19.0%       0.48        perf-stat.i.ipc
      0.37           -91.4%       0.03 ±  2%  perf-stat.i.metric.GHz
     82.44 ± 24%    +704.2%     662.99 ±  4%  perf-stat.i.metric.K/sec
    143.09 ±  2%     -91.7%      11.82        perf-stat.i.metric.M/sec
      3068            -3.6%       2957 ±  2%  perf-stat.i.minor-faults
     97.29           -11.9       85.43        perf-stat.i.node-load-miss-rate%
   3921273 ± 24%     -98.3%      64858 ±  7%  perf-stat.i.node-load-misses
    112374 ± 27%     -78.6%      23993 ±  9%  perf-stat.i.node-loads
    250279 ± 14%     -89.7%      25720 ± 26%  perf-stat.i.node-store-misses
   1000679 ± 22%     -93.0%      69547 ± 10%  perf-stat.i.node-stores
      3068            -3.6%       2957 ±  2%  perf-stat.i.page-faults
      1.40 ± 24%     -79.6%       0.29 ±  3%  perf-stat.overall.MPKI
      0.30 ±  2%      +2.0        2.27        perf-stat.overall.branch-miss-rate%
     25.66 ± 21%     -16.4        9.28 ±  5%  perf-stat.overall.cache-miss-rate%
      1.66 ±  2%     -19.9%       1.33        perf-stat.overall.cpi
      1263 ± 24%    +270.2%       4679 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  3%      +0.0        0.01 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  4%      +0.0        0.02 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
      0.60 ±  2%     +24.7%       0.75        perf-stat.overall.ipc
     97.22           -24.3       72.94 ±  3%  perf-stat.overall.node-load-miss-rate%
 3.583e+09 ±  2%     -91.5%  3.044e+08        perf-stat.ps.branch-instructions
  10853668           -36.4%    6905902        perf-stat.ps.branch-misses
  19246929 ± 22%     -97.8%     425360 ±  4%  perf-stat.ps.cache-misses
  74805635 ±  2%     -93.9%    4591171 ±  4%  perf-stat.ps.cache-references
      3577 ±  5%     -32.6%       2412 ± 11%  perf-stat.ps.context-switches
 2.301e+10           -91.4%  1.988e+09 ±  2%  perf-stat.ps.cpu-cycles
    100.30           -13.5%      86.72        perf-stat.ps.cpu-migrations
     59318 ±  3%     -19.9%      47521 ±  4%  perf-stat.ps.dTLB-load-misses
 4.889e+09 ±  3%     -92.9%  3.461e+08        perf-stat.ps.dTLB-loads
 4.631e+08 ±  2%     -71.4%  1.325e+08        perf-stat.ps.dTLB-stores
 1.386e+10 ±  2%     -89.2%  1.492e+09        perf-stat.ps.instructions
      3012            -3.5%       2908 ±  2%  perf-stat.ps.minor-faults
   3856694 ± 24%     -98.3%      63801 ±  7%  perf-stat.ps.node-load-misses
    110488 ± 27%     -78.6%      23605 ±  9%  perf-stat.ps.node-loads
    246141 ± 14%     -89.7%      25326 ± 26%  perf-stat.ps.node-store-misses
    984054 ± 22%     -93.0%      68412 ± 10%  perf-stat.ps.node-stores
      3012            -3.5%       2908 ±  2%  perf-stat.ps.page-faults
 8.444e+11 ±  2%     -89.3%  9.025e+10 ±  2%  perf-stat.total.instructions
     92.72           -92.7        0.00        perf-profile.calltrace.cycles-pp.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     91.98           -92.0        0.00        perf-profile.calltrace.cycles-pp.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
     91.58           -91.6        0.00        perf-profile.calltrace.cycles-pp.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     70.02           -70.0        0.00        perf-profile.calltrace.cycles-pp.__libc_fcntl64
     69.78           -69.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     69.76           -69.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     69.70           -69.7        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     69.62           -69.6        0.00        perf-profile.calltrace.cycles-pp.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     23.41           -23.4        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.36           -23.4        0.00        perf-profile.calltrace.cycles-pp.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.54           -22.8        0.74 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.52           -22.8        0.73 ± 20%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.57 ± 10%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.6        0.61 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.6        0.61 ±  9%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.76 ± 12%  perf-profile.calltrace.cycles-pp.native_apic_msr_eoi.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +0.8        0.79 ± 12%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.00            +0.9        0.86 ± 14%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
      0.00            +0.9        0.91 ± 16%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu
      0.00            +1.0        0.95 ±  6%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.2        1.20 ±  9%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.4        1.36 ±  6%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.5        1.47 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.6        1.56 ±  6%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.7        1.66 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.00            +1.7        1.66 ± 10%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.7        1.74 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.00            +1.8        1.76 ± 13%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.00            +1.8        1.76 ± 13%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.8        1.76 ± 13%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.00            +1.8        1.76 ± 13%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.00            +1.8        1.76 ± 13%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.8        1.76 ± 13%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.8        1.76 ± 13%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +2.1        2.06 ± 10%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00            +2.1        2.14 ± 10%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +2.2        2.18 ± 29%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.3        2.34 ±  5%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +3.1        3.11 ±  4%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +3.5        3.53 ±  3%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +4.2        4.22 ±  2%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +4.2        4.22 ± 47%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +4.6        4.58 ± 43%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +7.7        7.68 ±  9%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      0.62 ±  5%     +10.9       11.48 ±  5%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.64 ±  4%     +11.1       11.79 ±  5%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.85 ±  3%     +14.8       15.60 ±  5%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.92 ±  3%     +16.1       17.02 ±  5%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.94 ±  3%     +16.2       17.13 ±  5%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.05 ±  6%     +18.4       19.46 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.27 ±  5%     +22.1       23.40 ±  4%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.45 ±  7%     +26.7       28.19 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.50 ±  7%     +27.8       29.34 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      1.94 ±  8%     +38.1       40.06 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      2.35 ±  7%     +46.1       48.49 ±  3%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.54 ±  4%     +84.0       88.55        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.65 ±  4%     +84.4       89.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.62 ±  4%     +85.5       90.12        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      4.89 ±  4%     +88.5       93.41        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.94 ±  4%     +89.3       94.28        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.96 ±  4%     +89.5       94.43        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.96 ±  4%     +89.5       94.43        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      5.02 ±  4%     +91.2       96.19        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      6.30 ±  4%    +116.9      123.16        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     93.13           -93.1        0.00        perf-profile.children.cycles-pp.__x64_sys_fcntl
     92.99           -93.0        0.00        perf-profile.children.cycles-pp.do_fcntl
     92.75           -92.8        0.00        perf-profile.children.cycles-pp.fcntl_setlk
     92.00           -92.0        0.00        perf-profile.children.cycles-pp.do_lock_file_wait
     94.01           -91.8        2.21 ± 12%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     93.94           -91.8        2.20 ± 12%  perf-profile.children.cycles-pp.do_syscall_64
     91.64           -91.6        0.00        perf-profile.children.cycles-pp.posix_lock_inode
     70.08           -70.1        0.00        perf-profile.children.cycles-pp.__libc_fcntl64
      1.46 ±  2%      -1.4        0.10 ± 25%  perf-profile.children.cycles-pp.kmem_cache_alloc
      2.08 ±  5%      -1.2        0.93 ± 15%  perf-profile.children.cycles-pp._raw_spin_lock
      1.23 ±  4%      -1.1        0.14 ± 34%  perf-profile.children.cycles-pp.kmem_cache_free
      1.03 ±  4%      -1.0        0.03 ±106%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.77 ±  9%      -0.7        0.03 ±100%  perf-profile.children.cycles-pp.__slab_free
      0.12 ±  9%      -0.1        0.06 ± 76%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.1        0.07 ± 24%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.00            +0.1        0.07 ± 29%  perf-profile.children.cycles-pp.path_lookupat
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.update_group_capacity
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.08 ± 36%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.08 ± 49%  perf-profile.children.cycles-pp.evsel__read_counter
      0.00            +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.__split_vma
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.walk_component
      0.00            +0.1        0.09 ± 38%  perf-profile.children.cycles-pp.cpu_util
      0.00            +0.1        0.09 ± 49%  perf-profile.children.cycles-pp.exec_mmap
      0.00            +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.00            +0.1        0.10 ± 39%  perf-profile.children.cycles-pp.copy_process
      0.00            +0.1        0.10 ± 26%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.00            +0.1        0.10 ± 24%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.00            +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.sched_setaffinity
      0.00            +0.1        0.10 ± 33%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.1        0.10 ± 44%  perf-profile.children.cycles-pp.elf_load
      0.00            +0.1        0.10 ± 38%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.00            +0.1        0.11 ± 43%  perf-profile.children.cycles-pp.schedule
      0.00            +0.1        0.11 ± 42%  perf-profile.children.cycles-pp.__libc_fork
      0.00            +0.1        0.11 ± 37%  perf-profile.children.cycles-pp.begin_new_exec
      0.00            +0.1        0.11 ± 42%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.1        0.12 ± 39%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.00            +0.1        0.12 ± 32%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +0.1        0.12 ± 30%  perf-profile.children.cycles-pp._dl_addr
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.ct_nmi_exit
      0.00            +0.1        0.13 ± 39%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.00            +0.1        0.13 ± 22%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +0.1        0.13 ± 20%  perf-profile.children.cycles-pp.kernel_clone
      0.00            +0.1        0.13 ± 39%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.1        0.14 ± 24%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.error_return
      0.00            +0.1        0.15 ± 36%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.2        0.15 ± 29%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.00            +0.2        0.15 ± 38%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.2        0.16 ± 30%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.2        0.16 ± 23%  perf-profile.children.cycles-pp.tick_program_event
      0.00            +0.2        0.17 ± 11%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.2        0.17 ± 10%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.00            +0.2        0.18 ± 21%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.00            +0.2        0.18 ± 33%  perf-profile.children.cycles-pp.__schedule
      0.00            +0.2        0.18 ± 33%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.2        0.18 ± 36%  perf-profile.children.cycles-pp.hrtimer_forward
      0.00            +0.2        0.19 ± 40%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.2        0.19 ± 49%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.2        0.19 ± 33%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.2        0.19 ± 26%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.2        0.19 ± 25%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.2        0.20 ± 24%  perf-profile.children.cycles-pp.read_counters
      0.00            +0.2        0.20 ± 34%  perf-profile.children.cycles-pp.exit_mm
      0.00            +0.2        0.21 ± 22%  perf-profile.children.cycles-pp.process_interval
      0.00            +0.2        0.21 ± 22%  perf-profile.children.cycles-pp.cmd_stat
      0.00            +0.2        0.21 ± 22%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.filemap_map_pages
      0.00            +0.2        0.22 ± 25%  perf-profile.children.cycles-pp.path_openat
      0.00            +0.2        0.22 ± 46%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.00            +0.2        0.22 ± 19%  perf-profile.children.cycles-pp.__libc_start_main
      0.00            +0.2        0.22 ± 19%  perf-profile.children.cycles-pp.main
      0.00            +0.2        0.22 ± 19%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.2        0.22 ± 29%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.2        0.22 ± 24%  perf-profile.children.cycles-pp.do_filp_open
      0.00            +0.2        0.23 ± 32%  perf-profile.children.cycles-pp.__memcpy
      0.00            +0.2        0.23 ± 26%  perf-profile.children.cycles-pp.do_read_fault
      0.00            +0.2        0.23 ± 19%  perf-profile.children.cycles-pp._find_next_and_bit
      0.01 ±223%      +0.2        0.24 ± 28%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.2        0.23 ± 51%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.2        0.23 ± 51%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.2        0.24 ± 23%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.2        0.25 ± 30%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.00            +0.3        0.26 ± 29%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.00            +0.3        0.26 ± 31%  perf-profile.children.cycles-pp.do_fault
      0.00            +0.3        0.27 ± 20%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +0.3        0.27 ± 20%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.3        0.27 ± 21%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.3        0.28 ± 29%  perf-profile.children.cycles-pp.mmap_region
      0.00            +0.3        0.28 ± 24%  perf-profile.children.cycles-pp.__mmput
      0.00            +0.3        0.28 ± 24%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +0.3        0.28 ± 18%  perf-profile.children.cycles-pp.irqentry_exit
      0.00            +0.3        0.29 ± 16%  perf-profile.children.cycles-pp.read
      0.00            +0.3        0.30 ± 12%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.3        0.30 ± 21%  perf-profile.children.cycles-pp.vfs_read
      0.00            +0.3        0.31 ± 26%  perf-profile.children.cycles-pp.do_mmap
      0.00            +0.3        0.32 ± 21%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.3        0.32 ± 28%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +0.3        0.33 ± 30%  perf-profile.children.cycles-pp.irqentry_enter
      0.00            +0.3        0.33 ± 26%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.3        0.34 ± 31%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.3        0.34 ± 68%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.3        0.34 ± 23%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.4        0.36 ± 14%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.4        0.36 ± 14%  perf-profile.children.cycles-pp.search_binary_handler
      0.00            +0.4        0.36 ± 15%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.4        0.36 ± 17%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.4        0.36 ± 15%  perf-profile.children.cycles-pp.exec_binprm
      0.00            +0.4        0.36 ± 21%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.00            +0.4        0.38 ± 18%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.4        0.38 ± 13%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.4        0.39 ± 20%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +0.4        0.41 ± 12%  perf-profile.children.cycles-pp.bprm_execve
      0.00            +0.4        0.41 ± 18%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.4        0.41 ± 12%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.4        0.42 ± 28%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.4        0.42 ± 14%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.4        0.42 ± 31%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.4        0.43 ± 20%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +0.4        0.43 ± 17%  perf-profile.children.cycles-pp.should_we_balance
      0.00            +0.4        0.43 ± 13%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.4        0.45 ± 34%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.5        0.47 ± 24%  perf-profile.children.cycles-pp.kthread
      0.00            +0.5        0.48 ± 17%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.5        0.48 ± 25%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.5        0.49 ± 26%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.5        0.49 ± 22%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +0.5        0.50 ± 22%  perf-profile.children.cycles-pp.exc_page_fault
      0.00            +0.5        0.50 ± 13%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.01 ±223%      +0.5        0.52 ±  8%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.5        0.52 ± 20%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.5        0.52 ± 20%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.5        0.53 ± 14%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.5        0.53 ± 14%  perf-profile.children.cycles-pp.execve
      0.00            +0.5        0.53 ± 14%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.04 ± 45%      +0.5        0.59 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.6        0.56 ± 18%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.03 ±100%      +0.6        0.60 ±  9%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.6        0.59 ± 11%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.03 ±100%      +0.6        0.62 ±  8%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.01 ±223%      +0.6        0.62 ± 20%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.6        0.65 ±  9%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.04 ± 45%      +0.7        0.72 ± 16%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.04 ± 45%      +0.8        0.83 ± 12%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.02 ±141%      +0.8        0.83 ±  9%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.04 ± 44%      +0.9        0.94 ±  7%  perf-profile.children.cycles-pp.sched_clock
      0.06 ±  7%      +0.9        0.96 ± 12%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.04 ± 44%      +0.9        0.95 ±  6%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.07 ±  8%      +0.9        1.00 ± 13%  perf-profile.children.cycles-pp.find_busiest_group
      0.06 ±  8%      +1.0        1.08 ±  7%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.07 ± 64%      +1.1        1.14 ± 61%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.06 ±  6%      +1.1        1.18 ± 11%  perf-profile.children.cycles-pp.native_sched_clock
      0.07 ±  5%      +1.2        1.22 ± 18%  perf-profile.children.cycles-pp.read_tsc
      0.07 ± 12%      +1.2        1.28 ± 10%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.09 ± 10%      +1.3        1.43 ±  6%  perf-profile.children.cycles-pp.perf_rotate_context
      0.10 ±  6%      +1.4        1.52 ±  4%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ± 16%      +1.5        1.54 ±  8%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.11 ±  9%      +1.6        1.68 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.10 ± 12%      +1.6        1.72 ± 10%  perf-profile.children.cycles-pp.clockevents_program_event
      0.05 ± 80%      +1.7        1.76 ± 13%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.05 ± 80%      +1.7        1.76 ± 13%  perf-profile.children.cycles-pp.rest_init
      0.05 ± 80%      +1.7        1.76 ± 13%  perf-profile.children.cycles-pp.start_kernel
      0.05 ± 80%      +1.7        1.76 ± 13%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.05 ± 80%      +1.7        1.76 ± 13%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.11 ± 13%      +2.0        2.08 ± 11%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.14 ±  7%      +2.1        2.24 ± 10%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.05 ± 85%      +2.2        2.27 ± 31%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.14 ±  7%      +2.3        2.42 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.17 ±  8%      +3.0        3.21 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.22 ±  5%      +3.4        3.63 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      0.26 ±  6%      +4.1        4.34 ±  2%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.10 ± 43%      +4.2        4.34 ± 47%  perf-profile.children.cycles-pp.tick_irq_enter
      0.12 ± 39%      +4.6        4.67 ± 43%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.16 ± 35%      +5.5        5.70 ± 37%  perf-profile.children.cycles-pp.ktime_get
      0.53 ±  5%      +8.4        8.88 ±  9%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.72 ±  5%     +11.2       11.92 ±  5%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.72 ±  5%     +11.3       12.00 ±  5%  perf-profile.children.cycles-pp.perf_event_task_tick
      1.01 ±  4%     +14.9       15.95 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      1.10 ±  4%     +16.1       17.25 ±  4%  perf-profile.children.cycles-pp.update_process_times
      1.11 ±  4%     +16.2       17.35 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      1.24 ±  6%     +18.5       19.76 ±  4%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      1.49 ±  5%     +22.2       23.70 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.70 ±  6%     +26.7       28.45 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.76 ±  6%     +27.7       29.50 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.22 ±  7%     +37.9       40.10 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.46 ±  4%     +77.7       82.17        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      4.59 ±  4%     +83.9       88.45        perf-profile.children.cycles-pp.acpi_safe_halt
      4.60 ±  4%     +84.0       88.59        perf-profile.children.cycles-pp.acpi_idle_enter
      4.69 ±  4%     +85.5       90.19        perf-profile.children.cycles-pp.cpuidle_enter_state
      4.71 ±  4%     +86.0       90.69        perf-profile.children.cycles-pp.cpuidle_enter
      4.96 ±  4%     +89.5       94.43        perf-profile.children.cycles-pp.start_secondary
      4.96 ±  4%     +90.3       95.27        perf-profile.children.cycles-pp.cpuidle_idle_call
      5.02 ±  4%     +91.2       96.19        perf-profile.children.cycles-pp.do_idle
      5.02 ±  4%     +91.2       96.19        perf-profile.children.cycles-pp.cpu_startup_entry
      5.02 ±  4%     +91.2       96.19        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     86.88           -86.9        0.00        perf-profile.self.cycles-pp.posix_lock_inode
      1.03 ±  4%      -1.0        0.03 ±106%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.76 ±  8%      -0.7        0.03 ±100%  perf-profile.self.cycles-pp.__slab_free
      0.41 ±  6%      -0.4        0.03 ±101%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.enqueue_hrtimer
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.00            +0.1        0.07 ± 28%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.error_return
      0.00            +0.1        0.09 ± 29%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.09 ± 29%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.00            +0.1        0.09 ± 28%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.10 ± 50%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.00            +0.1        0.10 ± 28%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.10 ± 32%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.00            +0.1        0.10 ± 23%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.00            +0.1        0.10 ± 36%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.menu_reflect
      0.00            +0.1        0.11 ± 24%  perf-profile.self.cycles-pp.tick_nohz_highres_handler
      0.00            +0.1        0.11 ± 36%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.11 ± 28%  perf-profile.self.cycles-pp.__do_softirq
      0.00            +0.1        0.11 ± 32%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.1        0.12 ± 30%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.1        0.12 ± 37%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.acpi_idle_enter
      0.00            +0.1        0.12 ± 16%  perf-profile.self.cycles-pp.ct_nmi_exit
      0.00            +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.ct_kernel_exit
      0.00            +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.13 ± 30%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.14 ± 31%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.14 ± 42%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.15 ± 10%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.2        0.16 ± 40%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.2        0.16 ± 38%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.2        0.16 ± 35%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.00            +0.2        0.16 ± 29%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.2        0.16 ± 19%  perf-profile.self.cycles-pp.tick_program_event
      0.00            +0.2        0.16 ± 46%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.2        0.17 ± 43%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.2        0.18 ± 34%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.2        0.18 ± 39%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.18 ± 32%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.00            +0.2        0.19 ± 26%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.2        0.19 ± 27%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.2        0.21 ± 31%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.2        0.21 ± 35%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.2        0.21 ± 10%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.2        0.22 ± 48%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.00            +0.2        0.22 ± 29%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.2        0.22 ± 19%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.2        0.24 ± 21%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.2        0.24 ± 35%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.2        0.25 ± 21%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.3        0.25 ± 27%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.3        0.27 ± 21%  perf-profile.self.cycles-pp.tick_irq_enter
      0.00            +0.3        0.28 ± 15%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.3        0.28 ± 17%  perf-profile.self.cycles-pp.perf_rotate_context
      0.00            +0.3        0.28 ± 12%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.3        0.31 ± 32%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.3        0.32 ± 16%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.00            +0.3        0.32 ± 16%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.3        0.33 ± 24%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.3        0.33 ± 10%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.00            +0.3        0.34 ± 10%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.3        0.34 ± 68%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.4        0.35 ± 34%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.4        0.37 ± 21%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.4        0.37 ± 13%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.4        0.44 ± 34%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.5        0.46 ± 10%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.5        0.46 ± 16%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.00            +0.5        0.47 ± 16%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.5        0.49 ± 18%  perf-profile.self.cycles-pp.cpuidle_enter
      0.03 ±100%      +0.5        0.52 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.5        0.54 ± 17%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.6        0.55 ± 30%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.6        0.60 ±  9%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.01 ±223%      +0.6        0.63 ± 20%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.6        0.65 ±  9%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.04 ±109%      +0.8        0.85 ± 69%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.03 ± 70%      +0.9        0.94 ±  5%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.06 ± 13%      +1.0        1.03 ± 14%  perf-profile.self.cycles-pp.menu_select
      0.06 ±  9%      +1.1        1.14 ± 10%  perf-profile.self.cycles-pp.native_sched_clock
      0.07 ±  8%      +1.1        1.19 ± 18%  perf-profile.self.cycles-pp.read_tsc
      0.07 ± 12%      +1.2        1.27 ± 10%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.10 ±  6%      +1.4        1.52 ±  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.11 ± 13%      +2.0        2.07 ± 10%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.04 ±110%      +2.0        2.06 ± 34%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.22 ±  6%      +3.2        3.40 ±  6%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.10 ± 59%      +4.6        4.68 ± 45%  perf-profile.self.cycles-pp.ktime_get
      0.53 ±  5%      +8.4        8.88 ±  9%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      2.45 ±  2%     +43.2       45.67 ±  4%  perf-profile.self.cycles-pp.acpi_safe_halt



***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/lock2/will-it-scale

commit: 
  1a62c22a15 ("filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core")
  b6be371400 ("filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core")

1a62c22a156f7235 b6be3714005c3933886be71011f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    133.17 ±  6%     -12.1%     117.00 ±  9%  perf-c2c.DRAM.local
    149977           +14.1%     171164        turbostat.POLL
    325602           +20.8%     393265        vmstat.system.cs
    387975            +8.6%     421447        vmstat.system.in
    582204           +14.2%     664729        meminfo.Active
    582149           +14.2%     664656        meminfo.Active(anon)
    616646           +12.2%     691874        meminfo.Shmem
    237394           +23.3%     292682        will-it-scale.224.processes
      1059           +23.3%       1306        will-it-scale.per_process_ops
    237394           +23.3%     292682        will-it-scale.workload
     13657            -9.6%      12344        sched_debug.cfs_rq:/.avg_vruntime.avg
     73337 ±  9%     -22.2%      57023 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
     13657            -9.6%      12344        sched_debug.cfs_rq:/.min_vruntime.avg
     73337 ±  9%     -22.2%      57023 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
    219789           +20.7%     265218        sched_debug.cpu.nr_switches.avg
    255037 ±  2%     +18.5%     302323 ±  3%  sched_debug.cpu.nr_switches.max
    209846 ±  2%     +21.8%     255607        sched_debug.cpu.nr_switches.min
      4.00 ±  2%     -12.2%       3.51        perf-sched.total_wait_and_delay.average.ms
    669729           +14.3%     765519        perf-sched.total_wait_and_delay.count.ms
      3.99           -12.1%       3.50        perf-sched.total_wait_time.average.ms
      1.67           -12.6%       1.46        perf-sched.wait_and_delay.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
    400.71 ±  6%     +30.9%     524.36 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    662115           +14.5%     757922        perf-sched.wait_and_delay.count.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     37.83 ±  4%     -35.2%      24.50 ±  5%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.66           -12.6%       1.45        perf-sched.wait_time.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
    400.71 ±  6%     +30.9%     524.36 ±  4%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    145523           +14.2%     166149        proc-vmstat.nr_active_anon
    862163            +2.2%     880985        proc-vmstat.nr_file_pages
    124709            -1.2%     123171        proc-vmstat.nr_inactive_anon
    154176           +12.2%     172985        proc-vmstat.nr_shmem
    145523           +14.2%     166149        proc-vmstat.nr_zone_active_anon
    124709            -1.2%     123171        proc-vmstat.nr_zone_inactive_anon
   1425665            +1.4%    1446048        proc-vmstat.numa_hit
   1077854            +1.9%    1098250        proc-vmstat.numa_local
    147680           -11.9%     130044 ±  3%  proc-vmstat.pgactivate
   1558057            +2.0%    1589070        proc-vmstat.pgalloc_normal
 9.087e+08           +12.8%  1.025e+09        perf-stat.i.branch-instructions
      1.42            -0.0        1.39        perf-stat.i.branch-miss-rate%
  13798311            +9.5%   15103350        perf-stat.i.branch-misses
     30.80 ±  2%      -2.3       28.55        perf-stat.i.cache-miss-rate%
  54798388           +10.4%   60498606        perf-stat.i.cache-references
    328899           +20.9%     397786        perf-stat.i.context-switches
      4.86 ±  3%     -13.3%       4.21        perf-stat.i.cpi
    293.37            +1.8%     298.66        perf-stat.i.cpu-migrations
 1.148e+09           +12.9%  1.296e+09        perf-stat.i.dTLB-loads
 5.986e+08           +14.7%  6.863e+08        perf-stat.i.dTLB-stores
     43.88            -0.7       43.16        perf-stat.i.iTLB-load-miss-rate%
   3572993            +6.4%    3802659        perf-stat.i.iTLB-load-misses
   4398820            +9.4%    4810728        perf-stat.i.iTLB-loads
 4.277e+09           +12.7%  4.818e+09        perf-stat.i.instructions
      1233            +6.3%       1310        perf-stat.i.instructions-per-iTLB-miss
      0.21 ±  3%     +14.8%       0.24        perf-stat.i.ipc
    323.47            +8.7%     351.66        perf-stat.i.metric.K/sec
     11.85           +13.3%      13.42        perf-stat.i.metric.M/sec
   3261416            +3.9%    3388295        perf-stat.i.node-store-misses
     84282 ±  4%     +10.9%      93462 ±  3%  perf-stat.i.node-stores
      1.52            -0.0        1.47        perf-stat.overall.branch-miss-rate%
     30.30 ±  2%      -2.0       28.28        perf-stat.overall.cache-miss-rate%
      4.68 ±  3%     -13.0%       4.07        perf-stat.overall.cpi
     44.83            -0.7       44.15        perf-stat.overall.iTLB-load-miss-rate%
      1197            +5.9%       1267        perf-stat.overall.instructions-per-iTLB-miss
      0.21 ±  3%     +14.8%       0.25        perf-stat.overall.ipc
   5421716            -8.6%    4953128        perf-stat.overall.path-length
  9.06e+08           +12.8%  1.022e+09        perf-stat.ps.branch-instructions
  13764794            +9.4%   15064434        perf-stat.ps.branch-misses
  54625355           +10.4%   60305066        perf-stat.ps.cache-references
    327802           +20.9%     396457        perf-stat.ps.context-switches
    292.51            +1.8%     297.70        perf-stat.ps.cpu-migrations
 1.145e+09           +12.9%  1.292e+09        perf-stat.ps.dTLB-loads
 5.967e+08           +14.7%  6.842e+08        perf-stat.ps.dTLB-stores
   3562048            +6.4%    3791062        perf-stat.ps.iTLB-load-misses
   4384208            +9.4%    4794704        perf-stat.ps.iTLB-loads
 4.264e+09           +12.7%  4.804e+09        perf-stat.ps.instructions
   3250653            +3.9%    3377096        perf-stat.ps.node-store-misses
     84093 ±  4%     +10.9%      93276 ±  3%  perf-stat.ps.node-stores
 1.287e+12           +12.6%   1.45e+12        perf-stat.total.instructions
     68.54 ±  2%      -4.1       64.45        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     22.64            -1.6       21.01        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.posix_lock_inode.do_lock_file_wait.fcntl_setlk
     23.45            -1.4       22.06        perf-profile.calltrace.cycles-pp._raw_spin_lock.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl
      0.77 ±  5%      -0.2        0.59 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.do_lock_file_wait.fcntl_setlk.do_fcntl
      0.92 ±  4%      -0.1        0.82 ±  5%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.64 ±  3%      +0.1        0.73 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      0.75 ±  3%      +0.1        0.86 ±  3%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      0.71 ±  3%      +0.1        0.82 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.71 ±  3%      +0.1        0.83 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.82 ±  3%      +0.1        0.94 ±  3%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      0.74 ±  3%      +0.1        0.86 ±  4%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.56 ±  3%      +0.2        0.71 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up.__locks_wake_up_blocks
      0.91 ±  5%      +0.2        1.06 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_lock_file_wait.fcntl_setlk.do_fcntl
      0.56 ±  3%      +0.2        0.72 ±  3%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up.__locks_wake_up_blocks.locks_unlink_lock_ctx
      0.93 ±  5%      +0.2        1.09 ±  2%  perf-profile.calltrace.cycles-pp.schedule.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.88 ±  3%      +0.2        1.06 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up.__locks_wake_up_blocks.locks_unlink_lock_ctx.posix_lock_inode.do_lock_file_wait
      0.64 ±  3%      +0.2        0.84 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up.__locks_wake_up_blocks.locks_unlink_lock_ctx.posix_lock_inode
      0.94 ±  3%      +0.2        1.14 ±  2%  perf-profile.calltrace.cycles-pp.__locks_wake_up_blocks.locks_unlink_lock_ctx.posix_lock_inode.do_lock_file_wait.fcntl_setlk
      1.15 ±  4%      +0.2        1.38        perf-profile.calltrace.cycles-pp.locks_unlink_lock_ctx.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl
      1.38 ±  3%      +0.2        1.60 ±  2%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      2.00 ±  2%      +0.4        2.40 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.98 ±  2%      +0.4        2.38 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.17 ±141%      +0.4        0.57 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up.__locks_wake_up_blocks.posix_lock_inode.do_lock_file_wait.fcntl_setlk
      0.17 ±141%      +0.4        0.60 ±  3%  perf-profile.calltrace.cycles-pp.__locks_wake_up_blocks.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl
      0.09 ±223%      +0.5        0.56 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.do_lock_file_wait.fcntl_setlk
      2.47 ±  3%      +0.5        2.96 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      4.74 ±  2%      +0.6        5.32        perf-profile.calltrace.cycles-pp.posix_locks_conflict.__locks_insert_block.posix_lock_inode.do_lock_file_wait.fcntl_setlk
     10.52 ±  3%      +0.7       11.26        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     62.09            +0.9       62.98        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     59.20 ±  2%      +1.4       60.62        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     59.72 ±  2%      +1.5       61.24        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     59.82 ±  2%      +1.5       61.34        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     37.86 ±  2%      +6.1       43.94        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     22.67            -1.6       21.06        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     24.33            -1.2       23.12        perf-profile.children.cycles-pp._raw_spin_lock
      0.92 ±  4%      -0.1        0.83 ±  5%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.20 ±  8%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.update_blocked_averages
      0.04 ± 45%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.13 ±  7%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.10 ±  5%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.set_next_entity
      0.11 ±  6%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.memset_orig
      0.35 ±  6%      +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.22 ±  3%      +0.0        0.26 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.16 ±  6%      +0.0        0.20 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.19 ±  3%      +0.0        0.22 ±  7%  perf-profile.children.cycles-pp.available_idle_cpu
      0.19 ±  3%      +0.0        0.23 ±  5%  perf-profile.children.cycles-pp.select_idle_sibling
      0.22 ±  4%      +0.0        0.27 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.22 ±  3%      +0.0        0.27 ±  4%  perf-profile.children.cycles-pp.select_task_rq
      0.24 ±  6%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.poll_idle
      0.28 ±  9%      +0.1        0.33 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.34 ±  8%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      0.45 ±  5%      +0.1        0.51 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.22 ± 10%      +0.1        0.28 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free
      0.21 ± 11%      +0.1        0.28 ±  6%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.49 ±  3%      +0.1        0.56 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.20 ± 11%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.llist_add_batch
      0.27 ± 10%      +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.50 ±  4%      +0.1        0.56 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.33 ±  5%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.28 ±  4%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.irqentry_exit
      0.28 ± 10%      +0.1        0.36 ±  6%  perf-profile.children.cycles-pp.llist_reverse_order
      0.35 ±  6%      +0.1        0.43 ±  5%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.65 ±  3%      +0.1        0.74 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.72 ±  3%      +0.1        0.83 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.76 ±  2%      +0.1        0.87 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.82 ±  3%      +0.1        0.95 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.74 ±  2%      +0.1        0.86 ±  4%  perf-profile.children.cycles-pp.schedule_idle
      0.96 ±  5%      +0.2        1.12 ±  2%  perf-profile.children.cycles-pp.schedule
      0.86 ±  3%      +0.2        1.07 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      0.86 ±  3%      +0.2        1.07 ±  3%  perf-profile.children.cycles-pp.autoremove_wake_function
      1.15 ±  4%      +0.2        1.38        perf-profile.children.cycles-pp.locks_unlink_lock_ctx
      1.38 ±  3%      +0.2        1.62 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.99 ±  3%      +0.3        1.25 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
      1.35 ±  2%      +0.3        1.64        perf-profile.children.cycles-pp.__wake_up
      1.66 ±  4%      +0.3        1.95        perf-profile.children.cycles-pp.__schedule
      1.44 ±  3%      +0.3        1.74 ±  2%  perf-profile.children.cycles-pp.__locks_wake_up_blocks
      2.01 ±  2%      +0.4        2.41        perf-profile.children.cycles-pp.__sysvec_call_function_single
      2.00 ±  2%      +0.4        2.40 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      2.48 ±  3%      +0.5        2.98 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
      4.77 ±  2%      +0.6        5.38        perf-profile.children.cycles-pp.posix_locks_conflict
     62.39            +0.9       63.30        perf-profile.children.cycles-pp.cpuidle_idle_call
     59.42 ±  2%      +1.4       60.85        perf-profile.children.cycles-pp.acpi_safe_halt
     59.48 ±  2%      +1.4       60.92        perf-profile.children.cycles-pp.acpi_idle_enter
     60.02 ±  2%      +1.5       61.55        perf-profile.children.cycles-pp.cpuidle_enter_state
     60.09 ±  2%      +1.5       61.63        perf-profile.children.cycles-pp.cpuidle_enter
     20.39 ±  2%      +3.4       23.74        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     22.62            -1.6       21.01        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.08 ±  4%      -0.7        0.36 ±  4%  perf-profile.self.cycles-pp.__locks_insert_block
      1.18 ±  5%      -0.3        0.91 ±  6%  perf-profile.self.cycles-pp.posix_lock_inode
      0.13 ±  7%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      0.11 ±  6%      +0.0        0.14 ±  9%  perf-profile.self.cycles-pp.try_to_wake_up
      0.10 ±  9%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.memset_orig
      0.12 ± 16%      +0.0        0.16 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.22 ±  2%      +0.0        0.26 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.19 ±  3%      +0.0        0.22 ±  7%  perf-profile.self.cycles-pp.available_idle_cpu
      0.24 ±  8%      +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.prepare_task_switch
      0.19 ±  9%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.24 ±  6%      +0.1        0.29 ±  4%  perf-profile.self.cycles-pp.poll_idle
      0.12 ± 16%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.__wake_up_common
      0.21 ± 10%      +0.1        0.28 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.61 ±  4%      +0.1        0.68 ±  3%  perf-profile.self.cycles-pp.menu_select
      0.20 ± 11%      +0.1        0.27 ±  5%  perf-profile.self.cycles-pp.llist_add_batch
      0.28 ± 10%      +0.1        0.36 ±  6%  perf-profile.self.cycles-pp.llist_reverse_order
      0.32 ±  5%      +0.1        0.40 ±  5%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.14 ±  7%      +0.1        0.24 ±  6%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.33 ±  5%      +0.1        0.43 ±  2%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      1.68 ±  8%      +0.4        2.09 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      4.73 ±  2%      +0.6        5.32        perf-profile.self.cycles-pp.posix_locks_conflict



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/lockf/stress-ng/60s

commit: 
  1a62c22a15 ("filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core")
  b6be371400 ("filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core")

1a62c22a156f7235 b6be3714005c3933886be71011f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.567e+09           +10.5%  3.943e+09        cpuidle..time
     90.04           +10.0%      99.05        iostat.cpu.idle
      9.66           -92.4%       0.73        iostat.cpu.system
     20817 ±  7%     -53.2%       9742 ± 15%  numa-meminfo.node1.Active
     20753 ±  6%     -53.4%       9662 ± 15%  numa-meminfo.node1.Active(anon)
      5188 ±  6%     -53.4%       2416 ± 15%  numa-vmstat.node1.nr_active_anon
      5188 ±  6%     -53.4%       2416 ± 15%  numa-vmstat.node1.nr_zone_active_anon
     23890           -52.3%      11399 ±  3%  meminfo.Active
     23794           -52.5%      11303 ±  3%  meminfo.Active(anon)
    101138           -14.3%      86632        meminfo.Shmem
     89.80            +9.3       99.09        mpstat.cpu.all.idle%
      9.27            -9.2        0.08 ±  3%  mpstat.cpu.all.sys%
      0.29 ±  5%      -0.1        0.21 ±  5%  mpstat.cpu.all.usr%
     90.11            +9.6%      98.78        vmstat.cpu.id
      6.37           -91.6%       0.53 ± 12%  vmstat.procs.r
      3738 ±  7%     -31.6%       2557 ± 14%  vmstat.system.cs
     70882            -7.6%      65491        vmstat.system.in
     33.00 ± 40%     -83.8%       5.33 ± 62%  perf-c2c.DRAM.local
      1443 ± 39%     -98.6%      20.33 ± 21%  perf-c2c.DRAM.remote
      2894 ± 10%     -98.1%      54.17 ± 10%  perf-c2c.HITM.local
    157.00 ± 31%     -92.0%      12.50 ± 26%  perf-c2c.HITM.remote
      3051 ±  8%     -97.8%      66.67 ± 12%  perf-c2c.HITM.total
  17106853 ±  3%    -100.0%       8118 ± 16%  stress-ng.lockf.ops
    285111 ±  3%    -100.0%     135.30 ± 16%  stress-ng.lockf.ops_per_sec
      1074           -99.1%       9.67 ± 18%  stress-ng.time.involuntary_context_switches
    601.83          -100.0%       0.00        stress-ng.time.percent_of_cpu_this_job_got
    359.07          -100.0%       0.11 ±  8%  stress-ng.time.system_time
     34160           -99.5%     158.00 ±  2%  stress-ng.time.voluntary_context_switches
    371.33           -88.9%      41.33        turbostat.Avg_MHz
     10.34            -9.2        1.15        turbostat.Busy%
     90.44            +9.3       99.69        turbostat.C1%
     89.66           +10.2%      98.85        turbostat.CPU%c1
      0.20 ±  2%     +42.5%       0.28        turbostat.IPC
    263.93            -8.6%     241.16        turbostat.PkgWatt
     66.49            -7.9%      61.26        turbostat.RAMWatt
      5949           -52.5%       2826 ±  3%  proc-vmstat.nr_active_anon
    112033            -1.1%     110855        proc-vmstat.nr_inactive_anon
     26996            -2.3%      26371        proc-vmstat.nr_mapped
     25286           -14.3%      21660        proc-vmstat.nr_shmem
      5949           -52.5%       2826 ±  3%  proc-vmstat.nr_zone_active_anon
    112033            -1.1%     110855        proc-vmstat.nr_zone_inactive_anon
    387344            -1.9%     379991        proc-vmstat.numa_hit
    321142            -2.3%     313733        proc-vmstat.numa_local
     29314           -22.6%      22680        proc-vmstat.pgactivate
    435252            -2.1%     426323        proc-vmstat.pgalloc_normal
    309358            -2.2%     302701        proc-vmstat.pgfault
      3492 ±  8%     +19.6%       4177 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.avg
      0.25 ±  7%     -43.2%       0.14 ± 17%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.45 ±  5%     -33.5%       0.30 ±  4%  sched_debug.cfs_rq:/.h_nr_running.stddev
    624.21 ± 77%     -60.7%     245.18 ± 25%  sched_debug.cfs_rq:/.load_avg.avg
      3492 ±  8%     +19.6%       4177 ±  5%  sched_debug.cfs_rq:/.min_vruntime.avg
      0.25 ±  8%     -43.8%       0.14 ± 17%  sched_debug.cfs_rq:/.nr_running.avg
      0.46 ±  5%     -33.7%       0.30 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
    486.22 ±  4%     -45.9%     262.93 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
      1601 ± 26%     -38.7%     981.42 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    348.83 ±  8%     -33.4%     232.42 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    483.77 ±  4%     -45.9%     261.67 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1592 ± 26%     -38.4%     981.08 ±  8%  sched_debug.cfs_rq:/.util_avg.max
    347.61 ±  8%     -33.2%     232.24 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
    507.00 ±  4%     -28.6%     361.92 ±  8%  sched_debug.cfs_rq:/.util_est.max
    116.95 ± 13%     -38.7%      71.73 ±  7%  sched_debug.cfs_rq:/.util_est.stddev
    681223           +21.4%     827062        sched_debug.cpu.avg_idle.avg
      3455 ± 19%   +7429.4%     260152 ±  6%  sched_debug.cpu.avg_idle.min
    253772 ±  8%     -31.3%     174307 ±  8%  sched_debug.cpu.avg_idle.stddev
     41050           +74.5%      71632        sched_debug.cpu.clock.avg
     41053           +74.5%      71635        sched_debug.cpu.clock.max
     41047           +74.5%      71629        sched_debug.cpu.clock.min
     40790           +74.5%      71181        sched_debug.cpu.clock_task.avg
     41044           +74.1%      71443        sched_debug.cpu.clock_task.max
     32724           +92.8%      63088        sched_debug.cpu.clock_task.min
    812.42 ±  4%     -38.9%     496.02 ± 17%  sched_debug.cpu.curr->pid.avg
      3755           +26.7%       4756        sched_debug.cpu.curr->pid.max
      1501           -21.7%       1175 ±  4%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 48%     -48.5%       0.00 ± 13%  sched_debug.cpu.next_balance.stddev
      0.24 ±  4%     -43.6%       0.14 ± 18%  sched_debug.cpu.nr_running.avg
      0.45 ±  4%     -33.8%       0.30 ±  4%  sched_debug.cpu.nr_running.stddev
      3334 ±  5%     +36.0%       4533 ±  4%  sched_debug.cpu.nr_switches.avg
    211.17 ± 11%    +129.5%     484.58 ±  8%  sched_debug.cpu.nr_switches.min
      0.02 ± 31%     -64.3%       0.01 ± 44%  sched_debug.cpu.nr_uninterruptible.avg
     41048           +74.5%      71630        sched_debug.cpu_clk
     39819           +76.8%      70400        sched_debug.ktime
     41966           +72.2%      72275        sched_debug.sched_clk
      0.01 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.01 ± 45%     -69.8%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00           -50.0%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 30%     -77.3%       0.01 ± 24%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 21%     -88.5%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      6.50 ± 83%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.01 ± 22%     -35.1%       0.01 ± 22%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.70 ±155%     -97.1%       0.02 ± 98%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 50%     -52.2%       0.00 ± 40%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      3.73 ± 10%     -30.9%       2.58        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 17%     -58.2%       0.00 ±  9%  perf-sched.total_sch_delay.average.ms
      9.66 ± 44%     -73.3%       2.58        perf-sched.total_sch_delay.max.ms
    128.25 ±  2%    +109.5%     268.64 ± 19%  perf-sched.total_wait_and_delay.average.ms
      5436           -49.7%       2736 ± 22%  perf-sched.total_wait_and_delay.count.ms
    128.24 ±  2%    +109.5%     268.63 ± 19%  perf-sched.total_wait_time.average.ms
     10.85 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.52 ± 92%     -64.8%       0.18        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.66 ±141%    +598.7%       4.63 ±  8%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      8.07 ± 22%    +564.3%      53.58 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    576.42           +20.5%     694.78        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      8.99 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ± 11%     -36.8%       0.00        perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    534.01 ±  2%     -11.6%     472.08 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.50 ± 26%     -79.5%       1.33 ±111%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2638 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
    242.17 ±  5%      +9.7%     265.67 ±  3%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     10.67 ±141%    +260.9%      38.50 ±  6%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    639.50 ± 20%     -86.0%      89.33 ±  9%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     80.83 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    401.77 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     41.17 ±146%     -98.6%       0.58 ±  5%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.50 ±142%    +222.1%       4.83 ±  7%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     65.22 ± 68%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ±112%     -79.0%       0.00 ± 40%  perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     10.85 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.51 ± 93%     -65.2%       0.18        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2.34 ± 13%     +98.0%       4.63 ±  8%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      8.06 ± 21%    +564.9%      53.57 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    576.41           +20.5%     694.78        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      8.98 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    533.96 ±  2%     -11.6%     472.06 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    401.77 ± 39%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     41.16 ±146%     -98.6%       0.58 ±  5%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     65.21 ± 68%    -100.0%       0.00        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.58 ± 22%     -70.5%       0.47 ±  5%  perf-stat.i.MPKI
 3.568e+09 ±  2%     -92.9%  2.535e+08 ±  4%  perf-stat.i.branch-instructions
      0.23 ±  3%      +0.9        1.09        perf-stat.i.branch-miss-rate%
   9431955 ±  4%     -45.9%    5102225 ±  6%  perf-stat.i.branch-misses
     27.67 ± 19%     -17.9        9.79 ±  4%  perf-stat.i.cache-miss-rate%
  21303699 ± 22%     -98.0%     420040 ±  5%  perf-stat.i.cache-misses
  76281674 ±  4%     -94.8%    3954225 ±  3%  perf-stat.i.cache-references
      3584 ±  8%     -33.8%       2374 ± 17%  perf-stat.i.context-switches
      1.72 ±  2%     +59.4%       2.73        perf-stat.i.cpi
 2.321e+10           -92.4%  1.766e+09        perf-stat.i.cpu-cycles
    102.00           -14.0%      87.67        perf-stat.i.cpu-migrations
      1431 ± 49%    +381.5%       6893 ±  9%  perf-stat.i.cycles-between-cache-misses
 7.008e+11 ±223%    -100.0%      46327 ±  8%  perf-stat.i.dTLB-load-misses
  4.89e+09 ±  2%     -93.8%  3.011e+08 ±  3%  perf-stat.i.dTLB-loads
      0.00 ±  5%      +0.0        0.02 ±  4%  perf-stat.i.dTLB-store-miss-rate%
     21150 ±  2%      -5.6%      19968 ±  4%  perf-stat.i.dTLB-store-misses
   4.6e+08 ±  2%     -73.6%  1.217e+08 ±  2%  perf-stat.i.dTLB-stores
 1.375e+10 ±  2%     -91.0%  1.238e+09 ±  4%  perf-stat.i.instructions
      0.59 ±  2%     -23.3%       0.45        perf-stat.i.ipc
      0.36           -92.4%       0.03        perf-stat.i.metric.GHz
     96.64 ± 19%    +581.4%     658.49 ±  3%  perf-stat.i.metric.K/sec
    140.47 ±  2%     -92.9%       9.95 ±  3%  perf-stat.i.metric.M/sec
      3112            -4.1%       2985 ±  2%  perf-stat.i.minor-faults
     97.01           -10.6       86.40        perf-stat.i.node-load-miss-rate%
   4341366 ± 23%     -98.6%      61707 ±  7%  perf-stat.i.node-load-misses
    130129 ± 23%     -81.5%      24070 ±  8%  perf-stat.i.node-loads
     19.88 ± 11%     +14.4       34.30 ± 37%  perf-stat.i.node-store-miss-rate%
    258621 ± 14%     -89.4%      27505 ± 31%  perf-stat.i.node-store-misses
   1098576 ± 22%     -94.1%      64637 ± 15%  perf-stat.i.node-stores
      3112            -4.1%       2985 ±  2%  perf-stat.i.page-faults
      1.55 ± 22%     -78.1%       0.34 ±  5%  perf-stat.overall.MPKI
      0.26 ±  5%      +1.7        2.01 ±  2%  perf-stat.overall.branch-miss-rate%
     27.79 ± 19%     -17.2       10.62 ±  4%  perf-stat.overall.cache-miss-rate%
      1.69 ±  2%     -15.5%       1.43 ±  2%  perf-stat.overall.cpi
      1153 ± 25%    +265.5%       4216 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  3%      +0.0        0.02 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      0.59 ±  2%     +18.3%       0.70 ±  2%  perf-stat.overall.ipc
     97.08           -25.2       71.89 ±  3%  perf-stat.overall.node-load-miss-rate%
     19.38 ±  9%     +10.5       29.93 ± 32%  perf-stat.overall.node-store-miss-rate%
 3.509e+09 ±  2%     -92.9%  2.494e+08 ±  4%  perf-stat.ps.branch-instructions
   9255727 ±  4%     -45.8%    5018172 ±  6%  perf-stat.ps.branch-misses
  20949807 ± 22%     -98.0%     413148 ±  5%  perf-stat.ps.cache-misses
  75014008 ±  4%     -94.8%    3890322 ±  3%  perf-stat.ps.cache-references
      3526 ±  8%     -33.7%       2337 ± 17%  perf-stat.ps.context-switches
 2.282e+10           -92.4%  1.737e+09        perf-stat.ps.cpu-cycles
    100.39           -14.1%      86.22        perf-stat.ps.cpu-migrations
 6.887e+11 ±223%    -100.0%      45567 ±  8%  perf-stat.ps.dTLB-load-misses
 4.808e+09 ±  2%     -93.8%  2.962e+08 ±  3%  perf-stat.ps.dTLB-loads
     20759 ±  2%      -5.4%      19640 ±  4%  perf-stat.ps.dTLB-store-misses
 4.521e+08 ±  2%     -73.5%  1.197e+08 ±  2%  perf-stat.ps.dTLB-stores
 1.352e+10 ±  2%     -91.0%  1.217e+09 ±  4%  perf-stat.ps.instructions
   4269190 ± 23%     -98.6%      60705 ±  7%  perf-stat.ps.node-load-misses
    127894 ± 23%     -81.5%      23684 ±  8%  perf-stat.ps.node-loads
    254298 ± 14%     -89.4%      27066 ± 31%  perf-stat.ps.node-store-misses
   1080200 ± 22%     -94.1%      63573 ± 15%  perf-stat.ps.node-stores
 8.241e+11 ±  2%     -91.0%  7.381e+10 ±  3%  perf-stat.total.instructions
     92.78           -92.8        0.00        perf-profile.calltrace.cycles-pp.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     92.06           -92.1        0.00        perf-profile.calltrace.cycles-pp.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
     91.64           -91.6        0.00        perf-profile.calltrace.cycles-pp.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl.__x64_sys_fcntl
     70.27           -70.3        0.00        perf-profile.calltrace.cycles-pp.__libc_fcntl64
     70.03           -70.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     70.01           -70.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     69.95           -69.9        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     69.88           -69.9        0.00        perf-profile.calltrace.cycles-pp.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fcntl64
     23.21           -23.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.15           -23.2        0.00        perf-profile.calltrace.cycles-pp.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.33           -22.6        0.75 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.31           -22.6        0.74 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.55 ±  4%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.00            +0.7        0.68 ±  9%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.7        0.68 ±  5%  perf-profile.calltrace.cycles-pp.ktime_get.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.7        0.68 ±  9%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains
      0.00            +0.7        0.69 ±  8%  perf-profile.calltrace.cycles-pp.native_apic_msr_eoi.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +0.7        0.74 ± 11%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.9        0.94 ± 14%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
      0.00            +1.0        0.98 ±  9%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.00            +1.1        1.06 ± 15%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu
      0.00            +1.2        1.17 ±  9%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.2        1.17 ± 12%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.3        1.28 ± 18%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +1.4        1.37 ± 38%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.5        1.50 ± 26%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.00            +1.5        1.53 ± 10%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.6        1.58 ± 24%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.00            +1.6        1.60 ±  9%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.6        1.60 ± 17%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +1.6        1.61 ± 24%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.00            +1.6        1.61 ± 24%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.6        1.61 ± 24%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.00            +1.6        1.61 ± 24%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.00            +1.6        1.61 ± 24%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.6        1.61 ± 24%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.6        1.61 ± 24%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.7        1.72 ±  5%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.8        1.81 ± 11%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.8        1.82 ± 17%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00            +2.5        2.52 ±  9%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.6        2.55 ±  7%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +3.3        3.33 ±  4%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +3.8        3.84 ± 10%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +4.5        4.49 ±  8%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +7.6        7.59 ±  7%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      0.60 ±  8%     +11.1       11.66 ±  6%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.61 ±  8%     +11.4       12.01 ±  6%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.81 ±  7%     +14.9       15.70 ±  5%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.89 ±  6%     +16.4       17.30 ±  4%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.90 ±  6%     +16.6       17.49 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.03 ±  8%     +17.6       18.65 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.24 ±  7%     +21.9       23.12 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.45 ±  9%     +25.6       27.02 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.50 ±  9%     +26.5       27.99 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      1.98 ± 11%     +33.9       35.88 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      2.38 ±  9%     +43.2       45.58        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.48 ±  5%     +83.8       88.30        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.60 ±  5%     +84.4       89.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.57 ±  5%     +85.3       89.92        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      4.84 ±  5%     +89.0       93.81        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.89 ±  5%     +89.7       94.55        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.90 ±  5%     +89.8       94.75        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.90 ±  5%     +89.8       94.75        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      4.98 ±  5%     +91.4       96.36        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      6.14 ±  5%    +118.3      124.43        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     93.18           -93.2        0.00        perf-profile.children.cycles-pp.__x64_sys_fcntl
     93.04           -93.0        0.00        perf-profile.children.cycles-pp.do_fcntl
     92.80           -92.8        0.00        perf-profile.children.cycles-pp.fcntl_setlk
     92.07           -92.1        0.00        perf-profile.children.cycles-pp.do_lock_file_wait
     94.06           -91.9        2.15 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     94.00           -91.9        2.15 ± 15%  perf-profile.children.cycles-pp.do_syscall_64
     91.71           -91.7        0.00        perf-profile.children.cycles-pp.posix_lock_inode
     70.33           -70.3        0.00        perf-profile.children.cycles-pp.__libc_fcntl64
      1.46 ±  5%      -1.4        0.08 ± 51%  perf-profile.children.cycles-pp.kmem_cache_alloc
      1.24 ±  4%      -1.1        0.13 ± 28%  perf-profile.children.cycles-pp.kmem_cache_free
      2.12 ±  6%      -1.0        1.14 ± 15%  perf-profile.children.cycles-pp._raw_spin_lock
      1.04 ±  4%      -1.0        0.06 ± 56%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.25 ±  8%      -0.2        0.04 ±105%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.11 ±  6%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.07 ± 36%  perf-profile.children.cycles-pp.evsel__read_counter
      0.00            +0.1        0.07 ± 29%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.00            +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.__split_vma
      0.00            +0.1        0.08 ± 32%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.1        0.08 ± 42%  perf-profile.children.cycles-pp.timekeeping_update
      0.00            +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.__libc_read
      0.00            +0.1        0.09 ± 36%  perf-profile.children.cycles-pp.copy_process
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.__bitmap_and
      0.00            +0.1        0.09 ± 25%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.00            +0.1        0.09 ± 25%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.readn
      0.00            +0.1        0.09 ± 45%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.00            +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp._dl_addr
      0.00            +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.00            +0.1        0.10 ± 42%  perf-profile.children.cycles-pp.write
      0.00            +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.elf_load
      0.00            +0.1        0.10 ± 43%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.00            +0.1        0.10 ± 33%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.10 ± 44%  perf-profile.children.cycles-pp.kernel_clone
      0.00            +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.11 ± 47%  perf-profile.children.cycles-pp.zap_pmd_range
      0.00            +0.1        0.11 ± 37%  perf-profile.children.cycles-pp.schedule
      0.00            +0.1        0.11 ± 46%  perf-profile.children.cycles-pp.unmap_page_range
      0.00            +0.1        0.12 ± 32%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.00            +0.1        0.12 ± 30%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.12 ± 36%  perf-profile.children.cycles-pp.unmap_vmas
      0.00            +0.1        0.12 ± 24%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.00            +0.1        0.12 ± 41%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.14 ± 29%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.00            +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.ct_nmi_exit
      0.00            +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.tick_program_event
      0.00            +0.1        0.14 ± 22%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.00            +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.00            +0.1        0.14 ± 17%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +0.2        0.15 ± 22%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.2        0.15 ± 16%  perf-profile.children.cycles-pp.error_return
      0.00            +0.2        0.16 ± 34%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.2        0.16 ± 44%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.00            +0.2        0.16 ± 33%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.2        0.16 ± 29%  perf-profile.children.cycles-pp.sched_setaffinity
      0.00            +0.2        0.17 ± 16%  perf-profile.children.cycles-pp.hrtimer_forward
      0.01 ±223%      +0.2        0.19 ± 23%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.2        0.19 ± 25%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.2        0.19 ± 30%  perf-profile.children.cycles-pp.path_openat
      0.00            +0.2        0.19 ± 31%  perf-profile.children.cycles-pp.do_filp_open
      0.00            +0.2        0.20 ± 24%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.00            +0.2        0.20 ± 22%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.2        0.20 ± 28%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.2        0.20 ± 16%  perf-profile.children.cycles-pp.exit_mm
      0.00            +0.2        0.20 ± 31%  perf-profile.children.cycles-pp.__schedule
      0.00            +0.2        0.21 ± 20%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.2        0.21 ± 23%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.2        0.21 ± 20%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.2        0.21 ± 24%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +0.2        0.21 ± 30%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.2        0.21 ± 30%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.2        0.22 ± 28%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.00            +0.2        0.23 ± 14%  perf-profile.children.cycles-pp.filemap_map_pages
      0.00            +0.2        0.23 ± 20%  perf-profile.children.cycles-pp.__memcpy
      0.00            +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.2        0.24 ± 24%  perf-profile.children.cycles-pp.read_counters
      0.00            +0.2        0.25 ± 23%  perf-profile.children.cycles-pp.do_read_fault
      0.00            +0.2        0.25 ±  7%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.3        0.25 ±  9%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.3        0.26 ± 24%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +0.3        0.26 ± 22%  perf-profile.children.cycles-pp.__mmput
      0.00            +0.3        0.26 ± 28%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.00            +0.3        0.26 ± 15%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.3        0.26 ± 11%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.3        0.26 ± 20%  perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.3        0.26 ± 11%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.3        0.26 ± 11%  perf-profile.children.cycles-pp.do_group_exit
      0.01 ±223%      +0.3        0.28 ± 20%  perf-profile.children.cycles-pp.__libc_start_main
      0.01 ±223%      +0.3        0.28 ± 20%  perf-profile.children.cycles-pp.main
      0.01 ±223%      +0.3        0.28 ± 20%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.3        0.27 ± 19%  perf-profile.children.cycles-pp.process_interval
      0.00            +0.3        0.27 ± 13%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.3        0.28 ± 20%  perf-profile.children.cycles-pp.cmd_stat
      0.00            +0.3        0.28 ± 20%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +0.3        0.28 ± 25%  perf-profile.children.cycles-pp.do_fault
      0.00            +0.3        0.29 ± 34%  perf-profile.children.cycles-pp.irqentry_exit
      0.00            +0.3        0.29 ± 25%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.00            +0.3        0.30 ± 23%  perf-profile.children.cycles-pp.read
      0.00            +0.3        0.30 ± 21%  perf-profile.children.cycles-pp.exec_binprm
      0.00            +0.3        0.30 ± 21%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.3        0.30 ± 21%  perf-profile.children.cycles-pp.search_binary_handler
      0.00            +0.3        0.31 ± 20%  perf-profile.children.cycles-pp.vfs_read
      0.00            +0.3        0.32 ± 33%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.3        0.33 ± 18%  perf-profile.children.cycles-pp.bprm_execve
      0.00            +0.3        0.33 ± 23%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.3        0.33 ± 29%  perf-profile.children.cycles-pp.mmap_region
      0.00            +0.4        0.35 ± 34%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.4        0.36 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.4        0.36 ± 28%  perf-profile.children.cycles-pp.do_mmap
      0.00            +0.4        0.36 ± 14%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.4        0.37 ± 21%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.4        0.37 ± 24%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.4        0.37 ± 27%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +0.4        0.38 ± 22%  perf-profile.children.cycles-pp.irqentry_enter
      0.00            +0.4        0.38 ± 14%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.4        0.40 ± 26%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +0.4        0.41 ± 31%  perf-profile.children.cycles-pp.kthread
      0.00            +0.4        0.42 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.08 ± 58%      +0.4        0.50 ± 34%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.00            +0.4        0.42 ± 29%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.4        0.42 ± 29%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.4        0.44 ± 28%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +0.4        0.44 ±  7%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.4        0.44 ±  9%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.4        0.44 ± 51%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.5        0.46 ± 21%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.5        0.46 ± 41%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.5        0.46 ± 25%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +0.5        0.46 ± 25%  perf-profile.children.cycles-pp.exc_page_fault
      0.00            +0.5        0.47 ± 18%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.00            +0.5        0.48 ± 15%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.5        0.49 ± 13%  perf-profile.children.cycles-pp.should_we_balance
      0.00            +0.5        0.49 ± 17%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.5        0.49 ± 17%  perf-profile.children.cycles-pp.execve
      0.00            +0.5        0.49 ± 18%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +0.5        0.52 ± 16%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.5        0.52 ± 20%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.5        0.52 ± 17%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.5        0.54 ± 25%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.00            +0.5        0.54 ±  5%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.6        0.55 ± 28%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.6        0.56 ± 15%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.6        0.58 ± 22%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.6        0.58 ± 14%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.6        0.59 ±  4%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.04 ± 71%      +0.6        0.67 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.02 ± 99%      +0.7        0.69 ± 20%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.02 ± 99%      +0.7        0.71 ±  9%  perf-profile.children.cycles-pp.update_blocked_averages
      0.02 ± 99%      +0.7        0.74 ± 11%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.04 ± 45%      +0.8        0.81 ± 12%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.02 ±141%      +0.8        0.82 ± 11%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.03 ±100%      +0.8        0.85 ±  5%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.04 ± 45%      +0.9        0.95 ±  8%  perf-profile.children.cycles-pp.sched_clock
      0.07 ± 11%      +1.0        1.05 ± 14%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.04 ± 73%      +1.0        1.03 ±  9%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.05 ± 45%      +1.1        1.12 ±  9%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.07 ±  8%      +1.1        1.16 ± 15%  perf-profile.children.cycles-pp.find_busiest_group
      0.06 ±  7%      +1.1        1.16 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
      0.07 ±  8%      +1.2        1.24 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.07 ± 10%      +1.2        1.25 ±  9%  perf-profile.children.cycles-pp.read_tsc
      0.14 ± 61%      +1.2        1.34 ± 17%  perf-profile.children.cycles-pp.tick_irq_enter
      0.08 ± 81%      +1.3        1.39 ± 38%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.16 ± 55%      +1.5        1.63 ± 18%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.09 ±  5%      +1.5        1.58 ±  9%  perf-profile.children.cycles-pp.perf_rotate_context
      0.08 ± 14%      +1.5        1.61 ± 24%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.08 ± 14%      +1.5        1.61 ± 24%  perf-profile.children.cycles-pp.rest_init
      0.08 ± 14%      +1.5        1.61 ± 24%  perf-profile.children.cycles-pp.start_kernel
      0.08 ± 14%      +1.5        1.61 ± 24%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.08 ± 14%      +1.5        1.61 ± 24%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.09 ± 11%      +1.5        1.63 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      0.09 ±  7%      +1.6        1.64 ± 10%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ± 14%      +1.7        1.78 ±  4%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.10 ± 19%      +1.7        1.85 ± 17%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.12 ±  9%      +1.8        1.94 ± 11%  perf-profile.children.cycles-pp.load_balance
      0.22 ± 46%      +2.1        2.28 ± 10%  perf-profile.children.cycles-pp.ktime_get
      0.15 ±  7%      +2.4        2.58 ±  9%  perf-profile.children.cycles-pp.rebalance_domains
      0.14 ±  7%      +2.5        2.64 ±  8%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.18 ± 10%      +3.3        3.44 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.22 ±  6%      +3.7        3.92 ±  9%  perf-profile.children.cycles-pp.__do_softirq
      0.27 ±  6%      +4.3        4.59 ±  8%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.49 ±  8%      +8.5        9.00 ±  6%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.69 ±  8%     +11.5       12.21 ±  6%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.69 ±  8%     +11.6       12.27 ±  6%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.96 ±  7%     +15.0       15.96 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      1.06 ±  6%     +16.5       17.58 ±  4%  perf-profile.children.cycles-pp.update_process_times
      1.06 ±  6%     +16.7       17.75 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      1.22 ±  8%     +17.7       18.95 ±  3%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      1.46 ±  7%     +22.0       23.41 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.69 ±  8%     +25.5       27.23 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.74 ±  8%     +26.4       28.18 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.25 ± 10%     +33.8       36.07 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.41 ±  6%     +76.4       80.81        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      4.55 ±  5%     +83.6       88.16        perf-profile.children.cycles-pp.acpi_safe_halt
      4.56 ±  5%     +83.8       88.35        perf-profile.children.cycles-pp.acpi_idle_enter
      4.65 ±  5%     +85.3       89.99        perf-profile.children.cycles-pp.cpuidle_enter_state
      4.68 ±  5%     +85.8       90.52        perf-profile.children.cycles-pp.cpuidle_enter
      4.90 ±  5%     +89.8       94.75        perf-profile.children.cycles-pp.start_secondary
      4.93 ±  5%     +90.6       95.50        perf-profile.children.cycles-pp.cpuidle_idle_call
      4.98 ±  5%     +91.4       96.36        perf-profile.children.cycles-pp.cpu_startup_entry
      4.98 ±  5%     +91.4       96.36        perf-profile.children.cycles-pp.do_idle
      4.98 ±  5%     +91.4       96.36        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     86.87           -86.9        0.00        perf-profile.self.cycles-pp.posix_lock_inode
      1.03 ±  4%      -1.0        0.06 ± 56%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.32 ±  7%      -0.3        0.04 ± 79%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.06 ± 35%  perf-profile.self.cycles-pp.nohz_balancer_kick
      0.00            +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.ct_idle_exit
      0.00            +0.1        0.08 ± 27%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.08 ± 24%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.1        0.09 ± 26%  perf-profile.self.cycles-pp.__bitmap_and
      0.00            +0.1        0.09 ± 45%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.00            +0.1        0.09 ± 32%  perf-profile.self.cycles-pp.ct_kernel_exit
      0.00            +0.1        0.09 ± 34%  perf-profile.self.cycles-pp.error_return
      0.00            +0.1        0.09 ± 26%  perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.1        0.10 ± 33%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.10 ± 32%  perf-profile.self.cycles-pp.irqentry_enter
      0.00            +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.1        0.11 ± 28%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.11 ± 17%  perf-profile.self.cycles-pp.__do_softirq
      0.00            +0.1        0.11 ± 25%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.1        0.11 ± 34%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.00            +0.1        0.12 ± 29%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.00            +0.1        0.12 ± 46%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.12 ± 24%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.00            +0.1        0.12 ± 20%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.13 ± 29%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.13 ± 25%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.13 ± 43%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.1        0.13 ± 37%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.13 ± 29%  perf-profile.self.cycles-pp.tick_program_event
      0.00            +0.1        0.13 ± 13%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.14 ± 39%  perf-profile.self.cycles-pp.ct_nmi_exit
      0.00            +0.1        0.15 ± 34%  perf-profile.self.cycles-pp.acpi_idle_enter
      0.00            +0.1        0.15 ± 36%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.2        0.15 ± 23%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.2        0.15 ± 14%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.2        0.16 ± 33%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.2        0.16 ± 33%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.00            +0.2        0.16 ± 18%  perf-profile.self.cycles-pp.menu_reflect
      0.00            +0.2        0.16 ± 25%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.17 ± 35%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.2        0.18 ± 30%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.2        0.19 ± 22%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.2        0.20 ± 39%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.2        0.20 ± 46%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.21 ± 29%  perf-profile.self.cycles-pp.perf_rotate_context
      0.00            +0.2        0.22 ± 28%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.2        0.22 ± 29%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.00            +0.2        0.22 ± 27%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.2        0.22 ± 34%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.2        0.22 ± 22%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.2        0.23 ± 26%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.2        0.25 ± 16%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.2        0.25 ± 14%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.2        0.25 ± 32%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.00            +0.2        0.25 ± 25%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.3        0.26 ± 14%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.3        0.26 ±  8%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.3        0.26 ± 14%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.3        0.28 ± 11%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.3        0.28 ± 31%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.00            +0.3        0.30 ± 17%  perf-profile.self.cycles-pp.tick_irq_enter
      0.00            +0.3        0.31 ± 33%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.3        0.32 ± 23%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.00            +0.3        0.32 ± 14%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.3        0.32 ±  8%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.3        0.33 ± 33%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.3        0.35 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.4        0.36 ± 14%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.4        0.38 ± 15%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.4        0.40 ± 11%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.4        0.41 ± 44%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.4        0.43 ± 53%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.5        0.49 ± 23%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.5        0.50 ± 18%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.5        0.50 ± 17%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.00            +0.5        0.51 ± 13%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.02 ± 99%      +0.6        0.59 ± 20%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.6        0.58 ± 22%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.6        0.59 ± 20%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.01 ±223%      +0.6        0.62 ± 12%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.01 ±223%      +0.6        0.63 ± 17%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.7        0.66 ± 11%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.02 ± 99%      +0.8        0.85 ±  5%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.06 ± 11%      +1.0        1.04 ± 12%  perf-profile.self.cycles-pp.menu_select
      0.06 ±  6%      +1.1        1.12 ±  7%  perf-profile.self.cycles-pp.native_sched_clock
      0.16 ± 64%      +1.1        1.24 ± 18%  perf-profile.self.cycles-pp.ktime_get
      0.08 ± 85%      +1.1        1.21 ± 45%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.07 ± 14%      +1.1        1.21 ± 10%  perf-profile.self.cycles-pp.read_tsc
      0.07 ± 10%      +1.2        1.23 ± 11%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.09 ±  7%      +1.6        1.64 ± 10%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.10 ± 19%      +1.7        1.84 ± 17%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.21 ±  6%      +3.4        3.60 ±  6%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.49 ±  8%      +8.5        9.00 ±  6%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      2.37 ±  4%     +46.9       49.28 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


