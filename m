Return-Path: <linux-fsdevel+bounces-8281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 148BE8322E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 02:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80061F231CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 01:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2483810F4;
	Fri, 19 Jan 2024 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdhZb8I9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A9210B;
	Fri, 19 Jan 2024 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705627142; cv=fail; b=ZT1Q4t2MxkePxNHtYkposxAQyrnETqIWxnaec/mIVMpKx+MaUHE0UPimsigP9S+MgdM0d8WLycjNQG0xqALm0o8SRYswX7vxLR5sounJ3JBKQsJx2xLunp2LgWzM/rVW9IP++RVL0XHMFxhUobRz4fCuKJBxE3+fHXrTyNXhb3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705627142; c=relaxed/simple;
	bh=1CQOrTHmeMTykbm+jVVLYk0VThGFYexZsaAqGTE+ZS0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nQ8UxgZPdBh6jhQICJDOo/IddjsftlwJ5xpbUL2a2k04DTdOabNi7R9o+mUCle9K8GA4oHpl2bvSxezdV/tPHr3zgzwY1HimjOcPDzNc1mlOfIBvUz+DQ0IWROqGCgz3oYx9dXAIKDHvkQfoXrpATj1H/KoGXJ0BjdlyxZxs/Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdhZb8I9; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705627137; x=1737163137;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=1CQOrTHmeMTykbm+jVVLYk0VThGFYexZsaAqGTE+ZS0=;
  b=kdhZb8I9+MeWUecHTLHCIoGFr5XCE1v0ywXnGmIWgB4EuE5rg41njQRF
   ygtjx8MVxaC+t5UfDoQRmcgdrU0N5gvTTn+3btMMydFHp6mRYCjiBWZWc
   6lwT2p0cN2d+cHvsdvbmxdBLu9wLPXzq6UMgVXAz/OOrmz8XVZKxk75F4
   gIptBLyQMzCdxWSAcSNqCfcgu3D7xaJY/JWukSJkscM6DeEHvrtEFcK8U
   3bZwKsEAstFiMEHCdje5RJPc4Dr+OlS3yxi2FIkm85zhOjpfxEl5OMfM+
   UPY233Plbi45/9mo4v31zjtb9eJRIZEioFq9JZFqdzc7AxSqWejWv/c9m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404383652"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="404383652"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 17:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="957989713"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="957989713"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 17:18:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 17:18:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 17:18:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 17:18:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ86bvvHV2m4cuQwHVY875ZPJDC6jFvKggf1MOy46JnM6ibetGbrCW8625LHbsYNBOfYeUJmT9t1rDaWIg1PCTFVBVtyaN36kK7Lb2HYNLmfHB01EAzguhzr7qNCKifSnu6FShhX06imye+M3pAjqvBTYzhuYpshnyQ56z33GaZgMEuWIG1fBAJEkmXmUWgZCua0/X/N79Vp/0wQRA6gid6oqbfUVpBhdrvPweJbkcTz1SAHp1nUPyJyoeanqDQGWVFFOUvTUCVpXKvGmgeZF7eNZpSLZ/vcvpQ3eUO6glxP4fKWT1mDpBzxScoGi209KNzj/v9yrPFnCXSNMppuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWVBCB34fVrmdcw4FQsouTUA7E5prAe6b9U4xLconck=;
 b=YDuFu6w3KEeMAnK63LWgbfwHvLAh7+CXn0CC+tXKsE0ZKTyxwO6tRLCPEhwFZGmCRVzcWUddU6GW/MOss2YAFBbH/Ou1zzaiipS95xza9zU17bUvwoySRYl6kK/5tXZtdgYMpkpKJnk/FBDvJfpoXdsSO1brH++GHhgrQDpjRPYs4M5idokB/FwpusX0fGHscHnLzcGJDM3xyDv/R0YSzCM9MAT7nFG7wBVwsfnjem8WMHXrn07PgISX1LFtQcYKrtedsmbGL85MCrEKAJyNINIPU+lXR6CIYjh8U0r0JbuV0HUlMh8J6/4zCaGVTc8Y5JVmVhHdU1wYz9YVPaSnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 01:18:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Fri, 19 Jan 2024
 01:18:50 +0000
Date: Fri, 19 Jan 2024 09:18:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [fs/pipe]  dfaabf916b: stress-ng.pipeherd.ops_per_sec
 -26.1% regression
Message-ID: <202401181624.1534a30e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0f0466-8219-4af6-9cac-08dc188c978c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v1hw6dxF2HaGLN2GcHCPfnK3PuzeYSzCronVM0SgqYQH5dBEhN5CefnmBwrB+dhSaFg5pzU661FMMY4MBjAVq60AXajDHslVOaHlu4wF38chK7xxTGOnt8ToGA10DBhBmIk87jsmyKuA+KuxVb3jVGmwGAYPEQ/0QHK9zWrJLNpIgy3XdE1wAg39bpRcg4JTGboM04AnHa3/bgTEuo1w/2cey5ueIkC5PHGxJcgr6KQZix9mU/Fpfcttln1QW+aQiwchqCyKZ26g1GBbjhUugmM0CcHnG6xq5k01VtdBDpuXd9KJaVK/J99izq2NExVf1NGsYODpCmaCNKPJax/MqitDWagyNqxWj4RZf4inqqeXXDdbKekS9NUJcreoZKxvhwT5RqwJ24kQDMNGrU5W3OwcLWX2A3SUHxF4Df+YCx4WB0AIRafcVKCUn5q0dzWeYWa6D1Nk5BEvX3FO9l50GcEA37OpXve9xB3bZ3mctG7U9Fffi41T+6am+g4qX5ytLpqo4Dqu3fIPvQy2o8aRjnlf9gFwwAXJWhAzCd+XIm1nepiffFPQnE0dA5YpQQtcSeI4DES4U30i8hWtoeK3wfd8tenTHxH2SDRsFa/3Vu6C66nUkRhQcTi6aV7+sHhuT3gPf+JeQXFu7oJxrwuwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230373577357003)(230922051799003)(230473577357003)(186009)(451199024)(64100799003)(1800799012)(8676002)(6486002)(8936002)(83380400001)(5660300002)(4326008)(316002)(6512007)(66476007)(6916009)(6666004)(54906003)(19627235002)(6506007)(66946007)(478600001)(1076003)(966005)(2616005)(26005)(107886003)(66556008)(38100700002)(82960400001)(30864003)(2906002)(36756003)(41300700001)(86362001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ot0phPT01z/wE4/DRyM6a7yRB2z66fNNjBaG6C630cjsGMQndyFCfjQZzC?=
 =?iso-8859-1?Q?583aBIyXkFnfyJgK9Gyrlm0Mmn5u+khvZ0QRzc3zVEEvmoSOUK/x1/Yaos?=
 =?iso-8859-1?Q?FfhoCziUKTh7Keu3NS/mWEtOwaTFcpYNCQVpTswFDoJZpBDkOcsLSOwmks?=
 =?iso-8859-1?Q?n0sg4pfHKsDdvpExEIwnoiN6UjLbovPwIRCq1keMiNpAeIgYMPsIDFbWg1?=
 =?iso-8859-1?Q?4EdwSvmCu/tIFL8ZEkrunnVg5l/jYG0J1K++1ccGkXwK2wrvirhhZGWTau?=
 =?iso-8859-1?Q?negxEbIZkanFaGY+thuk4hDaYP1IVLjwSOQnXsAKUu0+1ck0XzT/qBeKm+?=
 =?iso-8859-1?Q?NNPNey00Tl1i14fSUDl2Sy6rUHmcy9ZhQAOIg2Mr+eN6CNxDRldr72xG0Z?=
 =?iso-8859-1?Q?Gni/jqZLK4Rrh1qDQK0pPQveMDKRrFtUmoFJ1ioU2AF+XMZ9ULj47pHjJX?=
 =?iso-8859-1?Q?zlyQtsBKE1yiv0TKuy11lF3EEgs9Uy35KQ4lQTWEK4I4dlntzC5h/Ujitr?=
 =?iso-8859-1?Q?CWpdqhcWTLuXF+Ea+6mHYjZBe80v5cg1Yr3F54+PxpXFiwzUWw7DWA68Cv?=
 =?iso-8859-1?Q?jnQUiekzasCU3qFxjCGtQjDO+K2LS1q5EBf7nsyhsOsg3JEhj4S3cmRV/s?=
 =?iso-8859-1?Q?exQYwQjjArvjPF2NU1sH/9fi97X4Ny0hL+0tMnhgzdzHVOF6gHO4WRgee7?=
 =?iso-8859-1?Q?J92EWJozxRthWxXw43YQ89Hu9oPhmWyWR3FXDhvul4mxLL2oijZTJWdyas?=
 =?iso-8859-1?Q?jAWbcajvVIxJNTvSfhflI/pAy51LyJRuDYEsERHeUvBsL+kESSnCUQgtDH?=
 =?iso-8859-1?Q?rIoNGdDwIgbKzgn0/SFZWpho1OAI+f66C4XVNqYbjdR5dEInH5bkkZdoS5?=
 =?iso-8859-1?Q?DPV1kFH3o/bjrmlAsjX8lYG4eAPW1DDPhHj7fVQaqOZHYVAJhA5zdgrxxp?=
 =?iso-8859-1?Q?0Reh7rasRvmL5OJzjUwALp6CLan80I6REXFiqRdNtOStCagGf6bPPWFICz?=
 =?iso-8859-1?Q?xcJE10weLA/b2GruMEHq1GoZkE75r5ConPUP2PtAyo7NPm7w8I3At1vxx4?=
 =?iso-8859-1?Q?e8n3oiG9h3lbBv75CJjF2TlRL536MZ1yje9hirzFJtj8y+Wrw1gjqmbF9k?=
 =?iso-8859-1?Q?OMhWifQSiovkwGfQs/AhCkx48fAxwwH6iZ4/NZNFuCnu6NBVwf30iqoTP3?=
 =?iso-8859-1?Q?0f8wRVMNaPdErzUQZZGqnZXLgzr+1nkxkNTuj5cCSy5831kw4Q6gPh/ZQq?=
 =?iso-8859-1?Q?B+P2zzP5oL5E6+wSX2vTa+nLSAJJGOXEMFckwox83JxeZrW1HqHH0fKvFK?=
 =?iso-8859-1?Q?ogFR/EjDPc1HRflksylq81LR1UThS6s6RME2zdCJZnV9p311ZSeyxmeotZ?=
 =?iso-8859-1?Q?bsaqnTM4x+Nv0uNmEd/60nIDAJQx+6q78L2qxetKfW0MfwjkzWXNrA+kGW?=
 =?iso-8859-1?Q?8jd713lUMKe2lzfwg9ri/s7lMLP1O1OKLgbI73iQre3xH91PSc0WzdrdBE?=
 =?iso-8859-1?Q?pGAJgq12cQ6stTbMEBZmYSPhnJGrnyZVxLxcOBvIKiGD/hU4RgUMcEgR83?=
 =?iso-8859-1?Q?ED+8dQ3vsfQxRngeAFWB7tElD55WMrxzVganpGB/pYsR2G7UUSzV00KGO+?=
 =?iso-8859-1?Q?Qa1bOO9ZmKRJErk7ohBp0MzHQlEWrPm4cDlCacqTjzJqefhXTbAjw3bA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0f0466-8219-4af6-9cac-08dc188c978c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 01:18:50.3068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqZ51TG3DWtpKxDBA2cNX7ABC21qbFXQU1l/Z+CXsH4SIjEH6L6uqxTdQFzigSkzvbVH5JqIQ60/QnQ5NJ0n4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
X-OriginatorOrg: intel.com



Hello,

we reported
"[brauner-vfs:vfs.misc.backing_file] [fs/pipe]  cc03a5d65a: stress-ng.pipeherd.ops_per_sec -22.9% regression"
in
https://lore.kernel.org/all/202310261611.90b9e38c-oliver.sang@intel.com/
when this commit is
commit: cc03a5d65a4032f8c53940927343c1795f2d2c53 ("fs/pipe: remove unnecessary spinlock from pipe_write()")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.misc.backing_file

now we observed similar regression while this commit is merged in mainline.
at the same time, we also observed improvement in unixbench tests.


below details just FYI.



kernel test robot noticed a -26.1% regression of stress-ng.pipeherd.ops_per_sec on:


commit: dfaabf916b1ca83cfac856745db2fc9d57d9b13a ("fs/pipe: remove unnecessary spinlock from pipe_write()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: pipeherd
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput 51.8% improvement                                               |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory       |
| test parameters  | cpufreq_governor=performance                                                                    |
|                  | nr_task=100%                                                                                    |
|                  | runtime=300s                                                                                    |
|                  | test=pipe                                                                                       |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.pipeherd.ops_per_sec -34.2% regression                                     |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=memory                                                                                    |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=1                                                                                    |
|                  | test=pipeherd                                                                                   |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401181624.1534a30e-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240118/202401181624.1534a30e-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/pipeherd/stress-ng/60s

commit: 
  b4bd6b4bac ("fs/pipe: move check to pipe_has_watch_queue()")
  dfaabf916b ("fs/pipe: remove unnecessary spinlock from pipe_write()")

b4bd6b4bac8edd61 dfaabf916b1ca83cfac856745db 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7179 ± 20%     -18.3%       5863 ±  8%  uptime.idle
 3.346e+09 ± 22%     -28.0%  2.411e+09 ±  9%  cpuidle..time
 1.046e+08           -26.5%   76903274        cpuidle..usage
     75.94 ±  4%     -16.3%      63.57 ±  2%  iostat.cpu.idle
     22.46 ± 12%     +55.4%      34.90 ±  4%  iostat.cpu.system
     75.35 ±  4%     -12.8       62.55 ±  3%  mpstat.cpu.all.idle%
     21.81 ± 14%     +13.0       34.78 ±  5%  mpstat.cpu.all.sys%
     58684 ± 14%     -44.6%      32531 ± 68%  numa-numastat.node0.other_node
   1412129 ±  6%     -35.2%     914436 ± 42%  numa-numastat.node1.local_node
   1419809 ±  6%     -33.2%     948240 ± 40%  numa-numastat.node1.numa_hit
     75.96 ±  4%     -16.3%      63.60 ±  2%  vmstat.cpu.id
   6865831           -12.4%    6015779        vmstat.memory.cache
     15.39 ± 14%     +47.7%      22.73 ±  5%  vmstat.procs.r
   1088887 ± 37%     -68.8%     339310 ± 36%  numa-meminfo.node1.Inactive
   1080606 ± 38%     -69.4%     330949 ± 37%  numa-meminfo.node1.Inactive(anon)
    915963 ± 35%     -51.3%     446173 ± 26%  numa-meminfo.node1.Mapped
   3488008 ±  8%     -40.9%    2061072 ± 51%  numa-meminfo.node1.Shmem
   6742528           -12.7%    5887524        meminfo.Cached
   1363945 ± 31%     -57.6%     577677 ±  7%  meminfo.Inactive
   1351521 ± 31%     -58.2%     565253 ±  7%  meminfo.Inactive(anon)
   8298482           -10.4%    7431362        meminfo.Memused
   3856294 ±  2%     -20.9%    3049597 ±  2%  meminfo.Shmem
   8504922           -10.3%    7631133        meminfo.max_used_kB
 1.036e+08           -26.1%   76601132        stress-ng.pipeherd.ops
   1725189           -26.1%    1275768        stress-ng.pipeherd.ops_per_sec
      1918 ±  7%     +60.4%       3077 ±  7%  stress-ng.time.involuntary_context_switches
      1677           +37.1%       2300        stress-ng.time.percent_of_cpu_this_job_got
      1015           +38.1%       1401        stress-ng.time.system_time
 1.036e+08           -26.1%   76594217        stress-ng.time.voluntary_context_switches
     58684 ± 14%     -44.6%      32531 ± 68%  numa-vmstat.node0.numa_other
    270039 ± 38%     -69.3%      82836 ± 37%  numa-vmstat.node1.nr_inactive_anon
    228757 ± 35%     -51.2%     111712 ± 26%  numa-vmstat.node1.nr_mapped
    872073 ±  8%     -41.0%     514493 ± 51%  numa-vmstat.node1.nr_shmem
    270039 ± 38%     -69.3%      82836 ± 37%  numa-vmstat.node1.nr_zone_inactive_anon
   1419989 ±  6%     -33.2%     948013 ± 40%  numa-vmstat.node1.numa_hit
   1412309 ±  6%     -35.3%     914209 ± 42%  numa-vmstat.node1.numa_local
      1078 ± 15%     +32.3%       1426 ±  5%  turbostat.Avg_MHz
     35.18 ± 14%     +11.0       46.20 ±  4%  turbostat.Busy%
    680452 ±  3%     -32.0%     462647 ±  2%  turbostat.C1
 1.029e+08           -26.1%   76043040        turbostat.C1E
    946815 ± 81%     -64.7%     334320 ± 71%  turbostat.C6
     17.72 ± 67%      -9.7        8.05 ± 57%  turbostat.C6%
     64.50 ±  8%     -17.2%      53.44 ±  4%  turbostat.CPU%c1
      0.11           -24.2%       0.08 ±  5%  turbostat.IPC
   7862367 ±  9%      -8.8%    7167100 ±  3%  turbostat.IRQ
     63090 ±  4%     -17.9%      51823 ±  2%  turbostat.POLL
   1687064           -12.7%    1473145        proc-vmstat.nr_file_pages
    338030 ± 31%     -58.2%     141419 ±  7%  proc-vmstat.nr_inactive_anon
    963697           -20.9%     761859 ±  2%  proc-vmstat.nr_shmem
     26816            -2.2%      26214        proc-vmstat.nr_slab_reclaimable
    718428            -1.7%     706356        proc-vmstat.nr_unevictable
    338030 ± 31%     -58.2%     141419 ±  7%  proc-vmstat.nr_zone_inactive_anon
    718428            -1.7%     706356        proc-vmstat.nr_zone_unevictable
   1749576           -13.8%    1508913        proc-vmstat.numa_hit
   1683212 ±  2%     -14.3%    1442579        proc-vmstat.numa_local
    636656 ± 11%     -63.8%     230268 ±  4%  proc-vmstat.pgactivate
   1802369           -13.4%    1560001        proc-vmstat.pgalloc_normal
    636575 ±  4%      -9.8%     574253 ±  3%  proc-vmstat.pgfault
    471340 ±  3%      -6.4%     441076        proc-vmstat.pgfree
    652416 ± 10%     -11.6%     577024 ±  4%  proc-vmstat.unevictable_pgs_scanned
      0.00 ± 27%     +70.4%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.01           +16.7%       0.01        perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 23%    +427.8%       0.03 ± 26%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.70 ±  3%     +22.8%       0.86        perf-sched.total_wait_and_delay.average.ms
   5319883 ±  3%     -19.4%    4286519        perf-sched.total_wait_and_delay.count.ms
      0.69 ±  3%     +22.8%       0.85        perf-sched.total_wait_time.average.ms
    216.66 ±  6%     -13.7%     186.90 ± 10%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.57 ±  3%     +23.0%       0.70        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     13.61 ±  5%     +32.5%      18.03 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
   5317357 ±  3%     -19.4%    4283821        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    361.00 ±  5%     -23.6%     275.83 ± 11%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.55 ±  5%     +21.7%       0.67 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.45 ± 45%     +49.3%       0.67 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
    216.65 ±  6%     -13.7%     186.90 ± 10%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.54 ±  5%     +23.4%       0.66 ±  2%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.57 ±  3%     +23.1%       0.70        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     13.60 ±  5%     +32.5%      18.02 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.46 ± 45%     +66.5%       0.76 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.86 ±  3%     +14.6%       0.98 ±  6%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.57 ± 17%     +66.9%       0.95 ±  8%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
    163887           +76.6%     289408        sched_debug.cfs_rq:/.avg_vruntime.avg
    290077 ± 12%     +25.8%     364822 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.max
    135347 ± 10%    +101.6%     272926 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
    167779 ±  2%     +72.6%     289572 ±  2%  sched_debug.cfs_rq:/.left_vruntime.max
     40973 ± 14%     +49.5%      61238 ± 11%  sched_debug.cfs_rq:/.left_vruntime.stddev
    163887           +76.6%     289408        sched_debug.cfs_rq:/.min_vruntime.avg
    290077 ± 12%     +25.8%     364822 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
    135347 ± 10%    +101.6%     272926 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
    167779 ±  2%     +72.6%     289572 ±  2%  sched_debug.cfs_rq:/.right_vruntime.max
     40973 ± 14%     +49.5%      61238 ± 11%  sched_debug.cfs_rq:/.right_vruntime.stddev
    377.43 ±  3%     +12.3%     424.02 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    104.83 ±  7%     +28.2%     134.42 ± 10%  sched_debug.cfs_rq:/.runnable_avg.min
    375.36 ±  3%     +12.2%     421.09 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    104.25 ±  7%     +28.5%     134.00 ± 10%  sched_debug.cfs_rq:/.util_avg.min
      9255 ±  6%     +13.1%      10472 ±  4%  sched_debug.cpu.avg_idle.min
      1275 ±  9%     +25.0%       1594 ±  8%  sched_debug.cpu.curr->pid.avg
      0.28 ± 10%     +26.3%       0.35 ±  7%  sched_debug.cpu.nr_running.avg
   1528268           -26.1%    1129961        sched_debug.cpu.nr_switches.avg
   1646995 ±  2%     -25.3%    1230736        sched_debug.cpu.nr_switches.max
    132312 ± 23%     -57.8%      55881 ± 13%  sched_debug.cpu.nr_switches.stddev
      0.51 ±  7%     +34.8%       0.68 ±  9%  perf-stat.i.MPKI
      1.04 ±  6%      +0.2        1.22        perf-stat.i.branch-miss-rate%
  13019839 ± 12%     +29.3%   16836662 ±  7%  perf-stat.i.cache-misses
      3.37 ±  3%     +31.3%       4.42        perf-stat.i.cpi
 7.645e+10 ± 16%     +28.6%  9.829e+10 ±  4%  perf-stat.i.cpu-cycles
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-stat.i.dTLB-load-miss-rate%
      0.01 ± 27%      -0.0        0.01 ± 16%  perf-stat.i.dTLB-store-miss-rate%
      0.33 ±  3%     -20.9%       0.26        perf-stat.i.ipc
      1.19 ± 16%     +28.6%       1.54 ±  4%  perf-stat.i.metric.GHz
   5953184 ± 17%     +35.2%    8050438 ±  7%  perf-stat.i.node-load-misses
     21.85 ±  5%      +2.9       24.75 ±  3%  perf-stat.i.node-store-miss-rate%
    907395 ± 12%     +61.3%    1463258 ±  8%  perf-stat.i.node-store-misses
   5141037 ± 13%     +18.9%    6111881 ±  5%  perf-stat.i.node-stores
      0.59 ±  8%     +26.7%       0.74 ±  9%  perf-stat.overall.MPKI
      1.01            +0.2        1.16        perf-stat.overall.branch-miss-rate%
      3.40 ±  2%     +26.9%       4.32        perf-stat.overall.cpi
      0.08 ±  2%      +0.0        0.09 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.29 ±  2%     -21.2%       0.23        perf-stat.overall.ipc
     15.04 ±  2%      +4.2       19.29 ±  3%  perf-stat.overall.node-store-miss-rate%
  12852451 ± 12%     +28.9%   16572483 ±  7%  perf-stat.ps.cache-misses
  1.89e+08 ± 17%     +22.8%  2.321e+08 ±  4%  perf-stat.ps.cache-references
 7.545e+10 ± 16%     +28.3%  9.682e+10 ±  4%  perf-stat.ps.cpu-cycles
   5883748 ± 16%     +34.8%    7932536 ±  7%  perf-stat.ps.node-load-misses
    895770 ± 12%     +60.7%    1439876 ±  8%  perf-stat.ps.node-store-misses
   5068727 ± 13%     +18.6%    6012349 ±  5%  perf-stat.ps.node-stores
 1.596e+12 ±  2%      -9.5%  1.444e+12        perf-stat.total.instructions
     35.92           -11.4       24.50        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     35.43           -11.3       24.14        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     35.41           -11.3       24.13        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.37           -11.3       24.10        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     21.72            -7.4       14.32        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     20.29            -6.9       13.35 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     20.14            -6.9       13.25 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     18.70            -6.5       12.23        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      7.88            -2.1        5.76 ±  2%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     13.72 ±  2%      -2.1       11.62        perf-profile.calltrace.cycles-pp.write
     13.37 ±  2%      -2.1       11.30        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     13.32 ±  2%      -2.1       11.27        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.53 ± 18%      -1.9        1.58 ± 34%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      3.54 ± 18%      -1.9        1.59 ± 34%  perf-profile.calltrace.cycles-pp.__cmd_record
      3.53 ± 18%      -1.9        1.58 ± 34%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      3.51 ± 18%      -1.9        1.58 ± 34%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     13.02 ±  3%      -1.9       11.10        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     12.88 ±  3%      -1.9       10.98        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      7.15 ±  2%      -1.9        5.28 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
     12.57 ±  3%      -1.8       10.76        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.39 ±  5%      -1.7       10.68 ±  4%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     12.07 ±  5%      -1.6       10.43 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      6.18 ±  2%      -1.5        4.64 ±  3%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      4.84 ±  2%      -1.5        3.38        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.76 ±  2%      -1.4        3.34        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      5.88            -1.4        4.46 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      6.00            -1.4        4.62 ±  2%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      6.21            -1.4        4.86 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      4.83            -1.2        3.64 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      4.96 ±  2%      -1.1        3.82 ±  3%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      4.87 ±  3%      -1.1        3.74 ±  3%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      4.48            -1.1        3.37 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      4.18 ±  3%      -1.0        3.13 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.61 ± 20%      -1.0        0.63 ± 57%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      1.61 ± 21%      -1.0        0.63 ± 58%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
      1.57 ± 21%      -1.0        0.62 ± 58%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      3.68 ±  2%      -0.9        2.80 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      2.02            -0.6        1.37        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.41 ±  8%      -0.5        0.86 ±  8%  perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.66            -0.5        1.14        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.55 ±  4%      -0.5        1.05 ±  7%  perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.10 ±  3%      -0.4        0.66 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.77            -0.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.08            -0.3        0.76        perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function
      1.20 ±  4%      -0.3        0.88 ±  4%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.84            -0.3        0.54 ±  2%  perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.01 ± 11%      -0.3        0.72 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.04 ± 16%      -0.3        0.76 ±  3%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.88            -0.3        0.62 ±  2%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.59 ±  5%      -0.2        1.42 ±  4%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.64 ±  2%      -0.1        1.53        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.32 ±  2%      -0.1        1.21 ±  3%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.62 ±  2%      -0.1        0.57 ±  3%  perf-profile.calltrace.cycles-pp.sched_mm_cid_migrate_to.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.64            -0.1        0.59 ±  3%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.43 ± 44%      +0.1        0.54 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.15 ± 11%      +0.2        1.36        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.26 ±  4%      +0.3        1.54        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
      0.00            +0.6        0.62 ±  4%  perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
      0.00            +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.__list_del_entry_valid_or_report.finish_wait.pipe_read.vfs_read.ksys_read
      0.78 ±  2%      +0.9        1.69        perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.86 ±  9%      +1.2        2.01 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      3.02 ±  2%      +1.2        4.18        perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.pipe_read.vfs_read.ksys_read
      0.74 ± 11%      +1.2        1.90 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      0.00            +1.2        1.22        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_write.vfs_write.ksys_write
      7.36 ±  4%      +1.7        9.04        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      3.10 ±  9%      +1.7        4.82        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.58 ± 13%      +1.8        4.36        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read
     11.12 ±  8%      +1.9       13.01        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.10 ±  5%      +1.9        8.02        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      2.55 ±  4%      +5.5        8.08 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_read.vfs_read.ksys_read
      4.49 ±  6%      +5.7       10.16        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
      4.81 ±  3%      +5.7       10.56        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
      5.02 ±  5%      +6.2       11.25        perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.74 ±  3%      +7.6       14.36 ±  2%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
     45.33           +15.6       60.97        perf-profile.calltrace.cycles-pp.read
     44.47           +15.8       60.32        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     44.33           +15.8       60.18        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     43.54           +15.9       59.43        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     43.29           +16.0       59.28        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     42.94           +16.1       59.02        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.92           -11.4       24.50        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     35.92           -11.4       24.50        perf-profile.children.cycles-pp.cpu_startup_entry
     35.88           -11.4       24.48        perf-profile.children.cycles-pp.do_idle
     35.43           -11.3       24.14        perf-profile.children.cycles-pp.start_secondary
     22.04            -7.5       14.54        perf-profile.children.cycles-pp.cpuidle_idle_call
     20.58            -7.0       13.55        perf-profile.children.cycles-pp.cpuidle_enter
     20.47            -7.0       13.48        perf-profile.children.cycles-pp.cpuidle_enter_state
     18.95            -6.5       12.41        perf-profile.children.cycles-pp.intel_idle
     16.98 ±  3%      -3.1       13.86 ±  3%  perf-profile.children.cycles-pp.__schedule
      8.00            -2.1        5.85 ±  2%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
     13.81 ±  2%      -2.1       11.68        perf-profile.children.cycles-pp.write
      3.53 ± 18%      -1.9        1.58 ± 34%  perf-profile.children.cycles-pp.record__finish_output
      3.53 ± 18%      -1.9        1.58 ± 34%  perf-profile.children.cycles-pp.perf_session__process_events
      3.56 ± 18%      -1.9        1.62 ± 34%  perf-profile.children.cycles-pp.__cmd_record
      3.52 ± 18%      -1.9        1.58 ± 34%  perf-profile.children.cycles-pp.reader__read_event
     13.06 ±  3%      -1.9       11.12        perf-profile.children.cycles-pp.ksys_write
     12.91 ±  3%      -1.9       11.00        perf-profile.children.cycles-pp.vfs_write
      7.34            -1.9        5.43 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     12.60 ±  3%      -1.8       10.78        perf-profile.children.cycles-pp.pipe_write
     12.40 ±  5%      -1.7       10.69 ±  4%  perf-profile.children.cycles-pp.schedule
      6.34            -1.6        4.78 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      4.93 ±  2%      -1.5        3.44        perf-profile.children.cycles-pp.schedule_idle
      5.90            -1.4        4.47 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      6.01            -1.4        4.62 ±  2%  perf-profile.children.cycles-pp.autoremove_wake_function
      6.22            -1.4        4.87 ±  2%  perf-profile.children.cycles-pp.__wake_up_common
      5.10 ±  2%      -1.2        3.93 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      4.86            -1.2        3.69 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      5.02 ±  2%      -1.1        3.88 ±  3%  perf-profile.children.cycles-pp.activate_task
      4.53            -1.1        3.44 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      4.34 ±  2%      -1.1        3.28 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      3.04 ±  6%      -1.0        2.01 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      3.85 ±  2%      -0.9        2.93 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      1.61 ± 20%      -0.9        0.72 ± 35%  perf-profile.children.cycles-pp.__ordered_events__flush
      1.61 ± 20%      -0.9        0.72 ± 35%  perf-profile.children.cycles-pp.perf_session__process_user_event
      1.58 ± 21%      -0.9        0.71 ± 35%  perf-profile.children.cycles-pp.perf_session__deliver_event
      1.24 ± 14%      -0.7        0.53 ± 27%  perf-profile.children.cycles-pp.process_simple
      1.19 ± 25%      -0.7        0.49 ± 43%  perf-profile.children.cycles-pp.evlist__parse_sample
      2.03            -0.6        1.38        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.25 ±  4%      -0.6        1.63 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      1.02 ± 26%      -0.6        0.45 ± 44%  perf-profile.children.cycles-pp.evsel__parse_sample
      0.90 ± 14%      -0.5        0.36 ± 23%  perf-profile.children.cycles-pp.ordered_events__queue
      0.87 ± 14%      -0.5        0.35 ± 24%  perf-profile.children.cycles-pp.queue_event
      1.67            -0.5        1.14        perf-profile.children.cycles-pp.__smp_call_single_queue
      1.17 ±  3%      -0.4        0.80 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.71 ±  2%      -0.4        0.34 ± 31%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      3.38 ±  2%      -0.4        3.00 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      1.54 ± 10%      -0.3        1.20 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      1.23 ±  4%      -0.3        0.91 ±  4%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.08            -0.3        0.76        perf-profile.children.cycles-pp.llist_add_batch
      0.86            -0.3        0.56 ±  2%  perf-profile.children.cycles-pp.llist_reverse_order
      0.91            -0.3        0.64 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.42 ±  6%      -0.2        0.19 ±  8%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.39 ±  3%      -0.2        0.17 ± 30%  perf-profile.children.cycles-pp.perf_tp_event
      0.38 ±  6%      -0.2        0.17 ±  9%  perf-profile.children.cycles-pp._copy_from_iter
      0.38 ±  4%      -0.2        0.18 ±  5%  perf-profile.children.cycles-pp.cpuacct_charge
      0.54 ±  3%      -0.2        0.34        perf-profile.children.cycles-pp.update_rq_clock_task
      0.56            -0.2        0.37        perf-profile.children.cycles-pp.call_function_single_prep_ipi
      1.06 ±  3%      -0.2        0.88        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.50 ±  4%      -0.2        0.34 ±  3%  perf-profile.children.cycles-pp.cpus_share_cache
      0.78            -0.2        0.62 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.74 ±  2%      -0.1        0.59        perf-profile.children.cycles-pp.__switch_to_asm
      0.41 ±  2%      -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.41 ±  4%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.26 ± 25%      -0.1        0.13 ± 46%  perf-profile.children.cycles-pp.evsel__parse_sample_timestamp
      0.37 ±  4%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.33 ±  3%      -0.1        0.21 ±  4%  perf-profile.children.cycles-pp.ktime_get
      1.65 ±  2%      -0.1        1.53        perf-profile.children.cycles-pp.select_task_rq
      0.80            -0.1        0.69 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
      0.32 ±  3%      -0.1        0.21 ±  4%  perf-profile.children.cycles-pp.sched_clock
      1.09            -0.1        0.98 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.24 ± 20%      -0.1        0.13 ± 23%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.68 ±  3%      -0.1        0.58 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      1.00            -0.1        0.90 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.30 ±  3%      -0.1        0.21        perf-profile.children.cycles-pp.update_rq_clock
      0.21 ±  4%      -0.1        0.13        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.27 ±  3%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.10 ± 20%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.thread__find_map
      0.14 ±  6%      -0.1        0.08 ± 26%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.20 ±  2%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.security_file_permission
      0.19 ±  3%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.intel_idle_irq
      0.18 ±  3%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.18 ±  4%      -0.1        0.11 ±  5%  perf-profile.children.cycles-pp.read_tsc
      0.32 ± 17%      -0.1        0.26 ±  7%  perf-profile.children.cycles-pp.update_blocked_averages
      0.19 ±  3%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.19 ±  3%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.reweight_entity
      0.64 ±  2%      -0.1        0.59 ±  2%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.15 ±  4%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.19 ± 19%      -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.16 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.10 ± 18%      -0.1        0.05 ± 50%  perf-profile.children.cycles-pp.machine__findnew_thread
      0.09 ±  5%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.12 ± 19%      -0.1        0.07 ± 23%  perf-profile.children.cycles-pp.machines__deliver_event
      0.12 ±  3%      -0.0        0.07 ± 27%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.18 ±  6%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.16 ±  2%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.13 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.get_cpu_device
      0.24 ±  4%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.72 ±  2%      -0.0        0.67 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.13 ±  3%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.place_entity
      0.25 ±  5%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.07 ± 10%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.71            -0.0        0.67 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.27 ±  5%      -0.0        0.23 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.08 ± 13%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.do_fault
      0.08 ± 13%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.do_read_fault
      0.62 ±  2%      -0.0        0.58 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.15 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.avg_vruntime
      0.10 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
      0.19 ±  3%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.__fdget_pos
      0.11 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.ct_idle_exit
      0.10 ±  7%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.exc_page_fault
      0.10 ± 10%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.10 ± 10%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.15 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.10 ±  9%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.09 ± 11%      -0.0        0.06 ± 20%  perf-profile.children.cycles-pp.handle_mm_fault
      0.17 ±  4%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.__fget_light
      0.09            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.15 ± 19%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.11 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.touch_atime
      0.10 ± 10%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.tick_irq_enter
      0.09 ±  9%      -0.0        0.06 ± 20%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.09            -0.0        0.06        perf-profile.children.cycles-pp.ct_kernel_enter
      0.10 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.atime_needs_update
      0.09 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.file_update_time
      0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.pick_eevdf
      0.18 ±  5%      -0.0        0.15 ±  7%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.08 ± 11%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__dequeue_entity
      0.10 ±  3%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.call_cpuidle
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__calc_delta
      0.11 ±  6%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.18 ±  3%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.10 ±  3%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.task_work_run
      0.14 ±  5%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.08 ±  5%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.poll_idle
      0.13 ±  6%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.10 ±  8%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.wake_affine
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.09 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.kill_fasync
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.attach_entity_load_avg
      0.30 ±  2%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.25 ±  4%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.07 ±  7%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.41 ±  2%      +0.0        0.45 ±  2%  perf-profile.children.cycles-pp.switch_fpu_return
      0.06 ±  7%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.detach_tasks
      0.42 ±  9%      +0.1        0.49 ± 11%  perf-profile.children.cycles-pp.idle_cpu
      0.49 ±  5%      +0.1        0.60 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
      0.34 ±  4%      +0.3        0.60 ±  3%  perf-profile.children.cycles-pp.select_idle_core
      0.26 ±  5%      +0.3        0.53 ±  2%  perf-profile.children.cycles-pp.osq_unlock
      0.36 ±  5%      +0.3        0.63 ±  3%  perf-profile.children.cycles-pp.select_idle_cpu
      2.07 ±  3%      +0.3        2.34        perf-profile.children.cycles-pp.mutex_unlock
      0.27 ±100%      +0.6        0.83 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      3.08 ±  2%      +1.2        4.23        perf-profile.children.cycles-pp.mutex_spin_on_owner
     11.14 ±  8%      +1.9       13.03        perf-profile.children.cycles-pp.prepare_to_wait_event
      5.02 ±  5%      +6.2       11.26        perf-profile.children.cycles-pp.finish_wait
      2.99 ±  3%      +6.3        9.31 ±  2%  perf-profile.children.cycles-pp.osq_lock
     13.95 ±  3%      +8.3       22.25        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      7.53 ±  3%      +8.5       16.06 ±  2%  perf-profile.children.cycles-pp.__mutex_lock
     15.76 ±  7%      +8.7       24.51        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     57.97           +13.8       71.77        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     57.80           +13.8       71.60        perf-profile.children.cycles-pp.do_syscall_64
     45.42           +15.6       61.05        perf-profile.children.cycles-pp.read
     43.54           +15.9       59.44        perf-profile.children.cycles-pp.ksys_read
     43.31           +16.0       59.30        perf-profile.children.cycles-pp.vfs_read
     42.99           +16.1       59.07        perf-profile.children.cycles-pp.pipe_read
     18.95            -6.5       12.41        perf-profile.self.cycles-pp.intel_idle
      3.00 ±  5%      -1.0        2.00 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      2.20 ±  5%      -0.6        1.56 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      1.01 ± 26%      -0.6        0.44 ± 44%  perf-profile.self.cycles-pp.evsel__parse_sample
      0.86 ± 14%      -0.5        0.34 ± 24%  perf-profile.self.cycles-pp.queue_event
      2.60 ±  6%      -0.4        2.18        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.85 ±  7%      -0.4        0.48 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      1.08            -0.3        0.76        perf-profile.self.cycles-pp.llist_add_batch
      1.22 ±  4%      -0.3        0.90 ±  4%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.59 ± 28%      -0.3        0.28 ± 49%  perf-profile.self.cycles-pp.reader__read_event
      0.85            -0.3        0.56 ±  2%  perf-profile.self.cycles-pp.llist_reverse_order
      3.11            -0.3        2.84        perf-profile.self.cycles-pp.prepare_to_wait_event
      0.71 ±  3%      -0.3        0.46        perf-profile.self.cycles-pp.flush_smp_call_function_queue
      1.50            -0.2        1.26 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.82 ± 19%      -0.2        0.58 ± 10%  perf-profile.self.cycles-pp.prepare_task_switch
      0.52 ±  3%      -0.2        0.33 ±  2%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.37 ±  4%      -0.2        0.18 ±  6%  perf-profile.self.cycles-pp.cpuacct_charge
      0.56            -0.2        0.37 ±  2%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      1.05 ±  3%      -0.2        0.86        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      1.87 ±  3%      -0.2        1.69 ±  5%  perf-profile.self.cycles-pp.update_load_avg
      0.21 ±  5%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp._copy_from_iter
      0.49 ±  3%      -0.2        0.34 ±  2%  perf-profile.self.cycles-pp.cpus_share_cache
      0.24 ±  4%      -0.2        0.09 ± 36%  perf-profile.self.cycles-pp.perf_tp_event
      0.76            -0.2        0.61 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.50 ±  7%      -0.2        0.35 ±  3%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.74 ±  2%      -0.1        0.59 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
      0.74            -0.1        0.60 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      1.43 ±  3%      -0.1        1.29        perf-profile.self.cycles-pp.pipe_read
      0.39 ±  3%      -0.1        0.25 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.39 ±  3%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.26 ± 24%      -0.1        0.12 ± 47%  perf-profile.self.cycles-pp.evsel__parse_sample_timestamp
      0.33 ± 26%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.enqueue_entity
      0.24 ±  5%      -0.1        0.12 ± 29%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.42 ±  2%      -0.1        0.30 ±  2%  perf-profile.self.cycles-pp.menu_select
      0.41 ± 15%      -0.1        0.29 ±  7%  perf-profile.self.cycles-pp.newidle_balance
      0.32 ±  3%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.57 ±  5%      -0.1        0.47 ±  5%  perf-profile.self.cycles-pp.pipe_write
      0.35 ±  8%      -0.1        0.24 ±  2%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.25 ±  3%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.do_idle
      0.31 ±  2%      -0.1        0.23 ±  3%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.19 ±  3%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.reweight_entity
      0.17 ±  4%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.15 ±  3%      -0.1        0.09 ±  6%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.29 ±  4%      -0.1        0.23 ±  3%  perf-profile.self.cycles-pp.schedule
      0.64 ±  2%      -0.1        0.59 ±  2%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.17 ±  4%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.17 ±  4%      -0.1        0.11 ±  5%  perf-profile.self.cycles-pp.read_tsc
      0.47 ±  4%      -0.1        0.41 ±  2%  perf-profile.self.cycles-pp.finish_task_switch
      0.16 ±  6%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.ktime_get
      0.27 ±  4%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.dequeue_entity
      0.18 ± 18%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.17 ±  5%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.09            -0.1        0.04 ± 75%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.12 ±  4%      -0.0        0.07 ± 29%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.15 ±  5%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.15            -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.13 ±  2%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.intel_idle_irq
      0.13 ±  3%      -0.0        0.08        perf-profile.self.cycles-pp.get_cpu_device
      0.16 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.try_to_wake_up
      0.14 ±  3%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.vfs_write
      0.19 ±  4%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.vfs_read
      0.24 ±  4%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.select_idle_sibling
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.cpuidle_enter
      0.10 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.11 ±  3%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.write
      0.12 ±  3%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.14 ±  6%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.avg_vruntime
      0.17 ±  4%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__fget_light
      0.10 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.10 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.call_cpuidle
      0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.08 ±  8%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.17 ±  6%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.11 ±  8%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.08 ±  8%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__calc_delta
      0.14 ±  5%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.07 ± 18%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.09 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.update_rq_clock
      0.06 ±  7%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.09            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.attach_entity_load_avg
      0.25 ±  3%      +0.0        0.28 ±  2%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.21 ±  3%      +0.0        0.24        perf-profile.self.cycles-pp.__wake_up_common
      0.05 ±  7%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.select_idle_core
      0.06 ± 11%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp._find_next_bit
      0.42 ±  9%      +0.1        0.48 ± 11%  perf-profile.self.cycles-pp.idle_cpu
      0.48 ±  5%      +0.1        0.60 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
      0.26 ±  5%      +0.3        0.53 ±  2%  perf-profile.self.cycles-pp.osq_unlock
      2.04 ±  3%      +0.3        2.31        perf-profile.self.cycles-pp.mutex_unlock
      0.26 ±100%      +0.6        0.82 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      1.20 ±  2%      +0.8        1.96        perf-profile.self.cycles-pp.__mutex_lock
      3.05 ±  2%      +1.2        4.21        perf-profile.self.cycles-pp.mutex_spin_on_owner
      2.97 ±  3%      +6.3        9.25 ±  2%  perf-profile.self.cycles-pp.osq_lock
     15.74 ±  7%      +8.8       24.49        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp9/pipe/unixbench

commit: 
  b4bd6b4bac ("fs/pipe: move check to pipe_has_watch_queue()")
  dfaabf916b ("fs/pipe: remove unnecessary spinlock from pipe_write()")

b4bd6b4bac8edd61 dfaabf916b1ca83cfac856745db 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  11392341 ±  4%     -15.3%    9645397 ±  5%  meminfo.DirectMap2M
     42770 ± 24%     -57.9%      17999 ±109%  numa-numastat.node0.other_node
     24.86 ±  3%      -1.2       23.67        turbostat.C1%
     62.00 ±  2%      +7.0%      66.33        turbostat.PkgTmp
      8329 ±  5%      +9.4%       9113 ±  4%  numa-meminfo.node0.KernelStack
      1857 ±  4%     +16.7%       2167 ±  7%  numa-meminfo.node0.Mapped
      7896 ±  5%      -9.9%       7112 ±  5%  numa-meminfo.node1.KernelStack
      8329 ±  5%      +9.4%       9115 ±  4%  numa-vmstat.node0.nr_kernel_stack
     42770 ± 24%     -57.9%      17999 ±109%  numa-vmstat.node0.numa_other
      7899 ±  5%      -9.9%       7115 ±  5%  numa-vmstat.node1.nr_kernel_stack
     14.67 ±  8%     -29.5%      10.33 ± 12%  perf-c2c.DRAM.local
     73.33 ± 18%     +21.4%      89.00 ±  6%  perf-c2c.DRAM.remote
     96.00 ±  6%     +14.2%     109.67 ±  3%  perf-c2c.HITM.local
     52.67 ± 18%     +23.4%      65.00 ±  2%  perf-c2c.HITM.remote
      9019            +1.0%       9112        proc-vmstat.nr_mapped
   1997539            -1.2%    1974166        proc-vmstat.numa_hit
   1931156            -1.2%    1907811        proc-vmstat.numa_local
   2118929            -1.1%    2094589        proc-vmstat.pgalloc_normal
   2026002            -1.3%    2000324        proc-vmstat.pgfree
     15820 ±  9%     +20.1%      19006 ±  9%  sched_debug.cfs_rq:/.load.avg
     23187 ± 40%     +60.4%      37191 ± 11%  sched_debug.cfs_rq:/.load.stddev
      0.09 ±  5%     +10.0%       0.10 ±  8%  sched_debug.cfs_rq:/.nr_running.stddev
      6.45 ± 18%     +32.1%       8.53 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      0.00 ± 17%     -42.4%       0.00 ± 19%  sched_debug.cpu.next_balance.stddev
     50406           -16.5%      42082 ± 13%  sched_debug.cpu.nr_switches.max
     88653            +1.1%      89668        unixbench.score
  73491273 ± 70%     +51.8%  1.115e+08        unixbench.throughput
   1453075            -1.1%    1436609        unixbench.time.minor_page_faults
      4802            +1.2%       4862        unixbench.time.percent_of_cpu_this_job_got
      2578            +2.5%       2643        unixbench.time.user_time
 4.312e+10            +1.1%  4.362e+10        unixbench.workload
      0.08 ±  7%      -6.6%       0.08        perf-stat.i.MPKI
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-stat.i.branch-miss-rate%
   6918885 ±  8%     -32.8%    4651719 ±  5%  perf-stat.i.branch-misses
    580993            -2.1%     568663        perf-stat.i.cache-misses
      1.31 ±  2%      -3.9%       1.25        perf-stat.i.cpi
    514928            +5.8%     545029        perf-stat.i.cycles-between-cache-misses
     26064 ±  2%      -6.0%      24489 ±  2%  perf-stat.i.node-loads
     22.62 ±  2%     +11.2       33.77        perf-stat.i.node-store-miss-rate%
     32126 ±  4%     +24.8%      40087 ±  2%  perf-stat.i.node-store-misses
    128256 ±  2%     -11.0%     114161 ±  3%  perf-stat.i.node-stores
     25.57            -1.2       24.34        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.33            -0.9       37.39        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     35.13            -0.9       34.21        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     41.26            -0.8       40.42        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     42.88            -0.8       42.04        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     53.55            -0.7       52.86        perf-profile.calltrace.cycles-pp.write
      2.99            -0.1        2.92        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      1.53            -0.0        1.49        perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.86            -0.0        1.83        perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.57            +0.0        0.59        perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.69            +0.0        0.71        perf-profile.calltrace.cycles-pp.__get_task_ioprio.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81            +0.0        0.83        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      0.63            +0.0        0.66        perf-profile.calltrace.cycles-pp.aa_file_perm.apparmor_file_permission.security_file_permission.vfs_read.ksys_read
      1.94            +0.0        1.97        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.23            +0.0        1.27        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.57 ±  2%      +0.0        0.60        perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.72            +0.0        0.76        perf-profile.calltrace.cycles-pp.timestamp_truncate.inode_needs_update_time.file_update_time.pipe_write.vfs_write
      1.95            +0.0        2.00        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.17            +0.0        1.22        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.74            +0.1        3.80        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.25            +0.1        1.31        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.92 ±  2%      +0.1        1.01        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      6.45            +0.1        6.54        perf-profile.calltrace.cycles-pp.__entry_text_start.read
      6.17            +0.1        6.28        perf-profile.calltrace.cycles-pp.__entry_text_start.write
      7.20            +0.1        7.31        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      1.05            +0.1        1.16        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
      2.20            +0.1        2.32        perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_read.ksys_read.do_syscall_64
      6.97            +0.1        7.09        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      2.22 ±  3%      +0.1        2.35        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
      2.72 ±  2%      +0.1        2.86        perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
      8.13            +0.1        8.27        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.85            +0.1        3.00        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.14 ±  2%      +0.1        2.28        perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_write.ksys_write.do_syscall_64
      8.77            +0.2        8.93        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      2.79            +0.2        2.96        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.55            +0.2       20.75        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.17 ±141%      +0.4        0.52        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     34.24            +0.5       34.71        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     31.03            +0.5       31.50        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     37.08            +0.5       37.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     38.65            +0.6       39.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     49.34            +0.7       50.07        perf-profile.calltrace.cycles-pp.read
      2.86            -1.4        1.44        perf-profile.children.cycles-pp._raw_spin_lock_irq
     26.42            -1.3       25.10        perf-profile.children.cycles-pp.pipe_write
     35.58            -0.9       34.65        perf-profile.children.cycles-pp.vfs_write
     38.61            -0.9       37.68        perf-profile.children.cycles-pp.ksys_write
     53.84            -0.7       53.16        perf-profile.children.cycles-pp.write
     79.41            -0.3       79.11        perf-profile.children.cycles-pp.do_syscall_64
     81.80            -0.3       81.54        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.54            -0.1        3.48        perf-profile.children.cycles-pp.atime_needs_update
      3.88            -0.0        3.83        perf-profile.children.cycles-pp.touch_atime
      0.25            -0.0        0.24        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.25            -0.0        0.24        perf-profile.children.cycles-pp.cpu_startup_entry
      0.25            -0.0        0.24        perf-profile.children.cycles-pp.do_idle
      0.25            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.start_secondary
      0.89            +0.0        0.91        perf-profile.children.cycles-pp.__wake_up_common
      0.56            +0.0        0.58        perf-profile.children.cycles-pp.rcu_all_qs
      0.26 ±  6%      +0.0        0.29        perf-profile.children.cycles-pp.tick_sched_timer
      0.84            +0.0        0.87        perf-profile.children.cycles-pp.rw_verify_area
      0.64            +0.0        0.67        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      2.66            +0.0        2.70        perf-profile.children.cycles-pp.mutex_unlock
      5.71            +0.0        5.75        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.64            +0.0        1.68        perf-profile.children.cycles-pp.__get_task_ioprio
      1.43            +0.0        1.48        perf-profile.children.cycles-pp.aa_file_perm
      1.12            +0.0        1.17        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.50            +0.1        1.56        perf-profile.children.cycles-pp.__cond_resched
      1.66            +0.1        1.72        perf-profile.children.cycles-pp.timestamp_truncate
      4.22            +0.1        4.29        perf-profile.children.cycles-pp.__wake_up_common_lock
      7.55            +0.1        7.64        perf-profile.children.cycles-pp._copy_from_iter
      4.22            +0.1        4.32        perf-profile.children.cycles-pp.mutex_lock
      7.26            +0.1        7.36        perf-profile.children.cycles-pp.__entry_text_start
      3.09            +0.1        3.20        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.15            +0.1        7.27        perf-profile.children.cycles-pp._copy_to_iter
      2.54 ±  3%      +0.1        2.68        perf-profile.children.cycles-pp.inode_needs_update_time
      8.30            +0.1        8.45        perf-profile.children.cycles-pp.copy_page_to_iter
      2.96 ±  2%      +0.1        3.11        perf-profile.children.cycles-pp.file_update_time
      9.11            +0.2        9.27        perf-profile.children.cycles-pp.copy_page_from_iter
      2.16            +0.2        2.36        perf-profile.children.cycles-pp.syscall_return_via_sysret
     21.38            +0.2       21.61        perf-profile.children.cycles-pp.pipe_read
      4.77            +0.3        5.05        perf-profile.children.cycles-pp.apparmor_file_permission
      6.15            +0.3        6.45        perf-profile.children.cycles-pp.security_file_permission
     34.50            +0.5       34.96        perf-profile.children.cycles-pp.ksys_read
     31.53            +0.5       32.01        perf-profile.children.cycles-pp.vfs_read
     49.55            +0.7       50.29        perf-profile.children.cycles-pp.read
      2.69            -1.3        1.36        perf-profile.self.cycles-pp._raw_spin_lock_irq
      5.28            -0.4        4.90        perf-profile.self.cycles-pp.pipe_write
      1.88            -0.1        1.79        perf-profile.self.cycles-pp.atime_needs_update
      0.16            +0.0        0.17        perf-profile.self.cycles-pp.__wake_up_sync_key
      1.02            +0.0        1.04        perf-profile.self.cycles-pp.ksys_read
      0.49            +0.0        0.51        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.72            +0.0        0.75        perf-profile.self.cycles-pp.__wake_up_common
      1.16            +0.0        1.19        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.39            +0.0        1.42        perf-profile.self.cycles-pp.__get_task_ioprio
      1.27            +0.0        1.30        perf-profile.self.cycles-pp._copy_to_iter
      2.70            +0.0        2.73        perf-profile.self.cycles-pp.mutex_lock
      5.52            +0.0        5.56        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.32            +0.0        1.35        perf-profile.self.cycles-pp.__wake_up_common_lock
      0.94            +0.0        0.98        perf-profile.self.cycles-pp.__cond_resched
      2.54            +0.0        2.58        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.08            +0.0        1.12        perf-profile.self.cycles-pp.ksys_write
      0.95            +0.1        1.00        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      1.66            +0.1        1.71        perf-profile.self.cycles-pp.copy_page_from_iter
      1.36            +0.1        1.42        perf-profile.self.cycles-pp.timestamp_truncate
      2.09            +0.1        2.16        perf-profile.self.cycles-pp._copy_from_iter
      5.46            +0.1        5.56        perf-profile.self.cycles-pp.vfs_read
      1.37 ±  4%      +0.1        1.49        perf-profile.self.cycles-pp.inode_needs_update_time
      2.15            +0.2        2.33        perf-profile.self.cycles-pp.syscall_return_via_sysret
      5.21            +0.2        5.40        perf-profile.self.cycles-pp.vfs_write
      3.25 ±  2%      +0.3        3.51        perf-profile.self.cycles-pp.apparmor_file_permission



***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/pipeherd/stress-ng/60s

commit: 
  b4bd6b4bac ("fs/pipe: move check to pipe_has_watch_queue()")
  dfaabf916b ("fs/pipe: remove unnecessary spinlock from pipe_write()")

b4bd6b4bac8edd61 dfaabf916b1ca83cfac856745db 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  41401292           -32.3%   28028489 ±  3%  cpuidle..usage
      5.49 ± 16%      +4.9       10.35 ± 15%  mpstat.cpu.all.sys%
      7049 ±  8%     +22.0%       8603 ± 12%  perf-c2c.HITM.local
      7049 ±  8%     +22.0%       8603 ± 12%  perf-c2c.HITM.total
      2.67 ± 15%     +58.2%       4.22 ± 16%  vmstat.procs.r
    973076 ± 15%     -24.2%     737453 ± 16%  vmstat.system.cs
   1155970 ±  7%     -24.4%     874362 ±  7%  meminfo.Active
   1155822 ±  7%     -24.4%     874215 ±  7%  meminfo.Active(anon)
   1276090 ±  5%     -21.0%    1007947 ±  5%  meminfo.Shmem
    288959 ±  7%     -24.4%     218555 ±  7%  proc-vmstat.nr_active_anon
   1006691            -6.7%     939642        proc-vmstat.nr_file_pages
    319042 ±  5%     -21.0%     251993 ±  5%  proc-vmstat.nr_shmem
    288959 ±  7%     -24.4%     218555 ±  7%  proc-vmstat.nr_zone_active_anon
    672348           -11.1%     598000 ±  3%  proc-vmstat.numa_hit
    672345           -11.7%     593890 ±  2%  proc-vmstat.numa_local
    711347 ±  2%     -11.6%     629037 ±  2%  proc-vmstat.pgalloc_normal
    632945           -34.2%     416502 ±  4%  stress-ng.pipeherd.context_switches_per_sec
  37968269           -34.2%   24976673 ±  4%  stress-ng.pipeherd.ops
    632676           -34.2%     416194 ±  4%  stress-ng.pipeherd.ops_per_sec
      8449 ±  5%     +49.8%      12656 ±  8%  stress-ng.time.involuntary_context_switches
    261.33           +60.2%     418.67 ±  9%  stress-ng.time.percent_of_cpu_this_job_got
    158.27           +62.1%     256.62 ±  9%  stress-ng.time.system_time
  37968591           -34.2%   24977642 ±  4%  stress-ng.time.voluntary_context_switches
    392.00 ± 12%     +39.3%     546.00 ± 12%  turbostat.Avg_MHz
     11.14 ±  6%      +3.6       14.73 ±  8%  turbostat.Busy%
  13053767           -66.8%    4330713 ± 10%  turbostat.C1
     17.57 ± 15%      -8.9        8.68 ± 19%  turbostat.C1%
  27519662           -15.6%   23233631 ±  2%  turbostat.C1E
      0.16 ±  2%     -31.6%       0.11 ±  8%  turbostat.IPC
     86032           -27.2%      62641 ±  3%  turbostat.POLL
  78281965 ±  8%     +33.4%  1.044e+08 ± 14%  perf-stat.i.cache-references
   1010492 ± 15%     -23.7%     770793 ± 16%  perf-stat.i.context-switches
 1.458e+10 ± 12%     +37.3%  2.002e+10 ± 12%  perf-stat.i.cpu-cycles
     11457 ± 15%     +44.2%      16519 ± 15%  perf-stat.i.cpu-migrations
   1162226 ±  3%     -12.0%    1022908 ±  6%  perf-stat.i.dTLB-load-misses
      0.45 ± 12%     -21.0%       0.35 ± 14%  perf-stat.i.ipc
      0.04 ± 77%    +138.8%       0.10 ± 46%  perf-stat.i.major-faults
      0.40 ± 12%     +37.3%       0.56 ± 12%  perf-stat.i.metric.GHz
      2.47 ±  7%      -0.7        1.76 ± 15%  perf-stat.overall.cache-miss-rate%
      1.98           +45.1%       2.88 ±  8%  perf-stat.overall.cpi
      7598 ± 12%     +47.2%      11182 ± 15%  perf-stat.overall.cycles-between-cache-misses
     34.28            +2.6       36.83        perf-stat.overall.iTLB-load-miss-rate%
      0.50           -30.6%       0.35 ±  8%  perf-stat.overall.ipc
  77236506 ±  8%     +33.2%  1.028e+08 ± 14%  perf-stat.ps.cache-references
    996570 ± 15%     -23.8%     759052 ± 16%  perf-stat.ps.context-switches
 1.438e+10 ± 12%     +37.1%  1.972e+10 ± 12%  perf-stat.ps.cpu-cycles
     11299 ± 15%     +44.0%      16269 ± 15%  perf-stat.ps.cpu-migrations
   1147284 ±  3%     -12.1%    1008110 ±  6%  perf-stat.ps.dTLB-load-misses
      0.04 ± 77%    +138.3%       0.10 ± 46%  perf-stat.ps.major-faults
 5.686e+11 ±  2%     -16.8%   4.73e+11 ±  3%  perf-stat.total.instructions
     11798           +79.7%      21202 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.avg
     35545 ±  4%     +24.8%      44364 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.max
      7825 ±  2%    +115.8%      16887 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.24 ± 11%     +26.9%       0.31 ± 10%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.39 ±  3%     +20.1%       0.46 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
     19291 ± 11%    +117.4%      41944 ± 37%  sched_debug.cfs_rq:/.load.avg
     11798           +79.7%      21202 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
     35545 ±  4%     +24.8%      44364 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
      7825 ±  2%    +115.8%      16886 ± 15%  sched_debug.cfs_rq:/.min_vruntime.min
      0.24 ± 11%     +26.9%       0.31 ± 10%  sched_debug.cfs_rq:/.nr_running.avg
      0.39 ±  3%     +20.1%       0.46 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
      4.00 ± 36%    +206.2%      12.25 ± 52%  sched_debug.cfs_rq:/.runnable_avg.min
    193.19 ± 10%     +28.5%     248.32 ± 10%  sched_debug.cfs_rq:/.runnable_avg.stddev
      3.83 ± 32%    +217.4%      12.17 ± 53%  sched_debug.cfs_rq:/.util_avg.min
    192.68 ± 10%     +28.2%     247.04 ±  9%  sched_debug.cfs_rq:/.util_avg.stddev
    227345           +12.7%     256128 ±  5%  sched_debug.cpu.avg_idle.avg
     12384 ± 17%     +47.8%      18301 ± 24%  sched_debug.cpu.avg_idle.min
    746.38 ± 12%     +30.0%     970.32 ±  6%  sched_debug.cpu.curr->pid.avg
      3592 ±  4%      +6.8%       3838        sched_debug.cpu.curr->pid.max
      1237 ± 11%     +21.2%       1500 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.24 ± 11%     +36.5%       0.33 ±  6%  sched_debug.cpu.nr_running.avg
      0.37 ±  7%     +36.5%       0.50 ±  9%  sched_debug.cpu.nr_running.stddev
   1030752           -33.1%     689795 ±  4%  sched_debug.cpu.nr_switches.avg
   1160111           -34.4%     761385 ±  5%  sched_debug.cpu.nr_switches.max
    919187           -31.5%     629289 ±  4%  sched_debug.cpu.nr_switches.min
     60982 ±  8%     -51.5%      29571 ± 12%  sched_debug.cpu.nr_switches.stddev
      0.00 ± 35%    +200.0%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ± 23%   +6255.9%       0.72 ± 64%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.01 ±  5%   +2144.0%       0.19 ±212%  perf-sched.sch_delay.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  7%    +212.3%       0.08 ± 77%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 35%    +362.5%       0.02 ± 51%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.49           +21.1%       0.59 ±  4%  perf-sched.total_wait_and_delay.average.ms
   1872181           -18.2%    1531048 ±  4%  perf-sched.total_wait_and_delay.count.ms
      0.49           +21.1%       0.59 ±  4%  perf-sched.total_wait_time.average.ms
      5.79 ±104%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.30           +21.9%       0.37 ±  4%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    149.15 ±  2%     -22.0%     116.38 ± 11%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      8.33 ± 24%     -76.0%       2.00 ± 95%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1.33 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
   1793631           -19.1%    1451839 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      1264           +27.5%       1611 ± 10%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.40 ± 89%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.28           +12.8%       0.32 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.09 ±141%    +236.4%       0.31 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_write
      5.39 ± 72%     -93.5%       0.35 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.28           +16.4%       0.32 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.26 ±  4%     +19.6%       0.31 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.27          +129.6%       0.62 ±105%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      5.79 ±104%     -99.9%       0.01 ±166%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.30           +21.9%       0.36 ±  4%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    149.11 ±  2%     -22.0%     116.35 ± 11%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.31 ±  5%     +19.4%       0.36 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.09 ±141%    +278.6%       0.34 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_write
     10.55 ± 65%     -96.7%       0.35 ±223%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.32 ±  2%     +90.7%       0.61 ± 64%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.31           +21.1%       0.37 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.30           +27.2%       0.39 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.29 ±  2%   +1656.1%       5.10 ±207%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      6.40 ± 89%     -99.8%       0.01 ±188%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.32           +23.0%       0.39 ±  4%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.28           +25.0%       0.36 ±  5%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.01 ± 20%     -33.3%       0.01 ± 19%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     68.52           -10.6       57.90 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     66.83           -10.5       56.34 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     66.82           -10.5       56.33 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     66.75           -10.4       56.30 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     15.28            -9.6        5.69 ± 11%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     59.97            -7.4       52.61 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     57.88            -6.6       51.32 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     59.25            -6.6       52.69        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.53            -1.6        1.88 ±  8%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.19            -1.5        1.69 ±  8%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      3.22            -1.3        1.96 ±  5%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.11            -1.2        1.91 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      2.43            -1.1        1.30 ±  8%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      2.44 ±  2%      -1.1        1.34 ±  8%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      7.77            -1.1        6.68 ±  3%  perf-profile.calltrace.cycles-pp.write
      2.46 ±  4%      -1.1        1.37 ±  9%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.29            -1.0        1.25 ±  8%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      2.33 ±  4%      -1.0        1.30 ±  9%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      2.63 ±  2%      -1.0        1.64 ±  8%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      7.42            -0.9        6.47 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      7.36            -0.9        6.44 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      7.26            -0.9        6.38 ±  3%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      7.13            -0.8        6.30 ±  3%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.81            -0.8        2.03 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      6.82            -0.7        6.13 ±  3%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.52            -0.7        0.85 ±  8%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      1.52            -0.6        0.87 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      1.42 ±  2%      -0.6        0.79 ±  8%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      1.34 ±  2%      -0.6        0.73 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.38            -0.6        0.80 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      1.00 ±  2%      -0.5        0.47 ± 45%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.16 ±  2%      -0.5        0.64 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      1.52 ±  3%      -0.5        1.00 ±  7%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.63 ±  6%      -0.1        0.54 ±  2%  perf-profile.calltrace.cycles-pp.__list_add_valid_or_report.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      0.63            +0.3        0.90 ±  4%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.83            +0.4        1.18 ±  3%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.80 ±  4%      +0.9        2.71 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.9        0.95 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_write.vfs_write.ksys_write
      1.47 ±  4%      +1.0        2.45 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.pipe_read.vfs_read.ksys_read
      0.71 ±  3%      +1.0        1.73 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      1.38            +1.1        2.44 ±  2%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.pipe_read.vfs_read.ksys_read
      0.86            +1.1        1.94 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      0.34 ± 70%      +1.2        1.50 ±  4%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      6.45 ±  2%      +2.0        8.49 ±  8%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.03 ±  5%      +2.1        5.10 ± 16%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      4.01 ±  2%      +2.1        6.11 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
     41.50            +3.6       45.08        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.42            +3.9        6.30 ± 12%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
      2.79            +4.0        6.74 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
      3.02            +4.2        7.23 ± 10%  perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.12            +4.4        5.49 ± 15%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_read.vfs_read.ksys_read
      3.54            +6.3        9.82 ±  8%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
     22.75           +12.1       34.82 ±  5%  perf-profile.calltrace.cycles-pp.read
     21.81           +12.5       34.31 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     21.73           +12.5       34.25 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     21.43           +12.6       33.99 ±  5%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     21.31           +12.6       33.92 ±  5%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     21.01           +12.7       33.75 ±  5%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     68.52           -10.6       57.90 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     68.52           -10.6       57.90 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     68.46           -10.6       57.88 ±  2%  perf-profile.children.cycles-pp.do_idle
     66.83           -10.5       56.34 ±  2%  perf-profile.children.cycles-pp.start_secondary
     16.63            -9.8        6.79 ± 10%  perf-profile.children.cycles-pp.intel_idle_irq
     61.48            -7.4       54.08 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
     59.33            -6.6       52.75        perf-profile.children.cycles-pp.cpuidle_enter
     59.31            -6.6       52.74        perf-profile.children.cycles-pp.cpuidle_enter_state
      5.65            -2.3        3.35 ±  7%  perf-profile.children.cycles-pp.__schedule
      3.63 ±  2%      -1.7        1.94 ±  8%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      3.29 ±  2%      -1.5        1.74 ±  8%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.32            -1.3        2.04 ±  5%  perf-profile.children.cycles-pp.schedule
      2.51            -1.2        1.34 ±  8%  perf-profile.children.cycles-pp.sched_ttwu_pending
      7.85            -1.1        6.72 ±  4%  perf-profile.children.cycles-pp.write
      2.53 ±  2%      -1.1        1.41 ±  9%  perf-profile.children.cycles-pp.schedule_idle
      2.45 ±  2%      -1.1        1.34 ±  8%  perf-profile.children.cycles-pp.autoremove_wake_function
      2.35            -1.1        1.30 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
      2.64 ±  2%      -1.0        1.64 ±  8%  perf-profile.children.cycles-pp.__wake_up_common
      7.26            -0.9        6.38 ±  3%  perf-profile.children.cycles-pp.ksys_write
      7.14            -0.8        6.30 ±  3%  perf-profile.children.cycles-pp.vfs_write
      1.62            -0.7        0.91 ±  7%  perf-profile.children.cycles-pp.ttwu_do_activate
      6.83            -0.7        6.13 ±  3%  perf-profile.children.cycles-pp.pipe_write
      1.57            -0.7        0.91 ±  6%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.50            -0.7        0.84 ±  7%  perf-profile.children.cycles-pp.activate_task
      1.41 ±  2%      -0.6        0.78 ±  7%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.44            -0.6        0.84 ±  7%  perf-profile.children.cycles-pp.dequeue_entity
      1.25 ±  2%      -0.5        0.70 ±  8%  perf-profile.children.cycles-pp.enqueue_entity
      1.57            -0.5        1.04 ±  6%  perf-profile.children.cycles-pp.menu_select
      3.20 ±  4%      -0.5        2.73 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.01 ±  2%      -0.5        0.55 ±  9%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.20 ±  3%      -0.4        1.75 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.08 ±  8%      -0.4        0.65 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.79 ±  3%      -0.3        0.44 ±  9%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.88            -0.3        0.53 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.76 ±  4%      -0.3        0.41 ±  8%  perf-profile.children.cycles-pp.select_task_rq
      0.72 ±  5%      -0.3        0.39 ±  9%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.77 ±  5%      -0.3        0.46 ±  9%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.71 ±  2%      -0.3        0.41 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.61            -0.3        0.34 ± 10%  perf-profile.children.cycles-pp.__switch_to_asm
      0.60 ±  4%      -0.3        0.34 ± 10%  perf-profile.children.cycles-pp.llist_add_batch
      0.56 ±  3%      -0.3        0.30 ± 10%  perf-profile.children.cycles-pp.select_idle_sibling
      0.61 ±  4%      -0.3        0.35 ± 13%  perf-profile.children.cycles-pp.prepare_task_switch
      0.50 ±  2%      -0.2        0.26 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.46 ±  2%      -0.2        0.26 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.37            -0.2        0.19 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.48 ±  5%      -0.2        0.30 ±  8%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.36 ±  3%      -0.2        0.18 ±  8%  perf-profile.children.cycles-pp.cpus_share_cache
      0.37 ±  3%      -0.2        0.20 ± 10%  perf-profile.children.cycles-pp.set_next_entity
      0.36 ±  4%      -0.2        0.20 ± 13%  perf-profile.children.cycles-pp.llist_reverse_order
      0.95 ±  7%      -0.2        0.80 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.31 ±  4%      -0.1        0.17 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.32            -0.1        0.19 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.27            -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.reweight_entity
      0.28 ±  5%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.sched_clock
      0.29 ±  3%      -0.1        0.17 ± 11%  perf-profile.children.cycles-pp.___perf_sw_event
      0.27 ± 10%      -0.1        0.15 ± 16%  perf-profile.children.cycles-pp.__entry_text_start
      0.25 ±  3%      -0.1        0.14 ± 13%  perf-profile.children.cycles-pp.security_file_permission
      0.74 ±  6%      -0.1        0.63 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.73 ±  6%      -0.1        0.62 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.28 ±  5%      -0.1        0.17 ± 11%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.66 ±  5%      -0.1        0.55 ±  2%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.28            -0.1        0.17 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.21 ±  4%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.29 ±  6%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
      0.23 ±  7%      -0.1        0.12 ± 11%  perf-profile.children.cycles-pp.avg_vruntime
      0.27 ±  4%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.ktime_get
      0.23 ±  9%      -0.1        0.13 ± 14%  perf-profile.children.cycles-pp.poll_idle
      0.19 ±  6%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.61 ±  8%      -0.1        0.51 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.17 ±  4%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.19 ±  8%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.19 ±  9%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp.place_entity
      0.22 ±  6%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.20 ±  4%      -0.1        0.12 ± 17%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.15            -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__enqueue_entity
      0.17 ±  7%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.16 ± 11%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp._copy_from_iter
      0.18 ±  5%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.16 ±  7%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.available_idle_cpu
      0.17 ±  2%      -0.1        0.09 ± 11%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.10 ±  8%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.update_min_vruntime
      0.19 ±  8%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.finish_task_switch
      0.10 ±  8%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.10 ±  8%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.copyin
      0.12 ±  6%      -0.1        0.05 ± 49%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.18 ±  7%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.12 ±  7%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.call_cpuidle
      0.15 ± 14%      -0.1        0.08 ± 23%  perf-profile.children.cycles-pp.__calc_delta
      0.10 ± 16%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.cpuacct_charge
      0.21 ± 14%      -0.1        0.15 ± 12%  perf-profile.children.cycles-pp.clock_nanosleep
      0.14 ±  9%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.__fget_light
      0.15 ±  6%      -0.1        0.09 ± 20%  perf-profile.children.cycles-pp.__fdget_pos
      0.16 ± 10%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.09 ±  9%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.12 ±  6%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.get_cpu_device
      0.17 ± 12%      -0.1        0.12 ± 16%  perf-profile.children.cycles-pp.newidle_balance
      0.09 ± 14%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.touch_atime
      0.10 ±  9%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.07 ± 12%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.atime_needs_update
      0.15 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.15 ± 11%      -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.14 ± 11%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.common_nsleep
      0.14 ± 11%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.11 ± 11%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.__dequeue_entity
      0.09 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.13 ± 10%      -0.0        0.09 ± 14%  perf-profile.children.cycles-pp.do_nanosleep
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.09 ± 13%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.11 ± 11%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.23 ±  9%      -0.0        0.19 ±  8%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.09            -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.19 ±  6%      +0.2        0.38 ±  3%  perf-profile.children.cycles-pp.osq_unlock
      0.35 ±  2%      +0.2        0.54 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.97            +0.2        1.20 ±  4%  perf-profile.children.cycles-pp.mutex_unlock
      1.28 ±  2%      +0.2        1.53 ±  2%  perf-profile.children.cycles-pp.mutex_lock
      1.41            +1.1        2.50 ±  2%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      6.46 ±  2%      +2.0        8.50 ±  8%  perf-profile.children.cycles-pp.prepare_to_wait_event
     41.51            +3.6       45.08        perf-profile.children.cycles-pp.intel_idle
      3.03            +4.2        7.24 ± 10%  perf-profile.children.cycles-pp.finish_wait
      1.33 ±  2%      +5.1        6.45 ± 13%  perf-profile.children.cycles-pp.osq_lock
      8.80 ±  4%      +6.8       15.58 ± 12%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      8.21            +6.9       15.12 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      4.06            +7.3       11.33 ±  7%  perf-profile.children.cycles-pp.__mutex_lock
     29.47           +11.5       40.95 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     29.32           +11.5       40.86 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     22.84           +12.0       34.88 ±  5%  perf-profile.children.cycles-pp.read
     21.43           +12.6       33.99 ±  5%  perf-profile.children.cycles-pp.ksys_read
     21.31           +12.6       33.93 ±  5%  perf-profile.children.cycles-pp.vfs_read
     21.03           +12.7       33.78 ±  5%  perf-profile.children.cycles-pp.pipe_read
     16.11            -9.6        6.48 ± 10%  perf-profile.self.cycles-pp.intel_idle_irq
      1.07 ±  9%      -0.4        0.63 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.59 ±  8%      -0.3        0.28 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.70 ±  2%      -0.3        0.40 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.61            -0.3        0.34 ± 10%  perf-profile.self.cycles-pp.__switch_to_asm
      0.60 ±  4%      -0.3        0.34 ± 10%  perf-profile.self.cycles-pp.llist_add_batch
      0.87 ±  2%      -0.3        0.61 ±  6%  perf-profile.self.cycles-pp.menu_select
      0.48 ±  2%      -0.2        0.25 ±  5%  perf-profile.self.cycles-pp.__switch_to
      0.52            -0.2        0.30 ± 11%  perf-profile.self.cycles-pp.__schedule
      0.43 ±  6%      -0.2        0.22 ±  7%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.38 ±  3%      -0.2        0.17 ± 10%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.36            -0.2        0.18 ±  7%  perf-profile.self.cycles-pp.native_sched_clock
      0.35 ±  2%      -0.2        0.18 ±  8%  perf-profile.self.cycles-pp.cpus_share_cache
      0.36 ±  4%      -0.2        0.19 ± 12%  perf-profile.self.cycles-pp.llist_reverse_order
      0.34 ±  4%      -0.1        0.20 ±  9%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.33 ±  6%      -0.1        0.19 ± 15%  perf-profile.self.cycles-pp.prepare_task_switch
      0.32            -0.1        0.18 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.27            -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.reweight_entity
      0.26 ±  4%      -0.1        0.13 ±  9%  perf-profile.self.cycles-pp.enqueue_entity
      0.26 ±  3%      -0.1        0.14 ± 10%  perf-profile.self.cycles-pp.do_idle
      0.28 ±  2%      -0.1        0.17 ±  8%  perf-profile.self.cycles-pp.update_load_avg
      0.66 ±  5%      -0.1        0.55 ±  2%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.22 ±  5%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.avg_vruntime
      0.25 ±  3%      -0.1        0.15 ± 12%  perf-profile.self.cycles-pp.___perf_sw_event
      0.26            -0.1        0.17 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.18 ±  6%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.28 ±  6%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.17 ±  4%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.16 ±  7%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.available_idle_cpu
      0.19 ±  8%      -0.1        0.11 ± 15%  perf-profile.self.cycles-pp.poll_idle
      0.17 ±  7%      -0.1        0.09 ± 10%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.18 ± 15%      -0.1        0.10 ± 18%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.20 ±  4%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.21 ±  2%      -0.1        0.13 ± 12%  perf-profile.self.cycles-pp.update_curr
      0.14            -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__enqueue_entity
      0.18 ±  7%      -0.1        0.10 ± 16%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.17 ±  4%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.15 ± 11%      -0.1        0.08 ± 22%  perf-profile.self.cycles-pp.dequeue_entity
      0.12 ±  7%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.call_cpuidle
      0.13 ± 10%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.11 ±  8%      -0.1        0.05 ± 46%  perf-profile.self.cycles-pp.schedule_idle
      0.10 ± 12%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.cpuacct_charge
      0.14 ± 11%      -0.1        0.08 ± 19%  perf-profile.self.cycles-pp.__calc_delta
      0.17 ±  7%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.finish_task_switch
      0.09 ± 14%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.schedule
      0.13 ±  6%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.__fget_light
      0.09 ±  9%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.16 ±  8%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.read_tsc
      0.15 ±  8%      -0.1        0.09 ± 20%  perf-profile.self.cycles-pp.read
      0.12 ±  6%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.get_cpu_device
      0.13 ±  3%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.vfs_read
      0.08 ±  5%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.13 ±  3%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.vfs_write
      0.12 ±  4%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.__entry_text_start
      0.13 ±  3%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.13 ±  6%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp.write
      0.15 ±  9%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.14 ±  3%      -0.1        0.09 ± 17%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.12 ±  6%      -0.1        0.07 ± 13%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.11 ± 14%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.try_to_wake_up
      0.11 ±  4%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.ktime_get
      0.13 ± 18%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.newidle_balance
      0.09 ± 15%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.__dequeue_entity
      0.11 ± 11%      -0.0        0.07 ± 15%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.10 ±  4%      -0.0        0.07 ± 15%  perf-profile.self.cycles-pp.stress_pipeherd_read_write
      0.09            -0.0        0.06 ± 17%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.19 ±  4%      +0.1        0.29 ±  7%  perf-profile.self.cycles-pp.__wake_up_common
      0.19 ±  6%      +0.2        0.37 ±  2%  perf-profile.self.cycles-pp.osq_unlock
      0.35 ±  2%      +0.2        0.54 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.96            +0.2        1.19 ±  4%  perf-profile.self.cycles-pp.mutex_unlock
      1.23 ±  2%      +0.3        1.49 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      1.13 ±  2%      +0.9        2.00 ±  3%  perf-profile.self.cycles-pp.__mutex_lock
      1.40            +1.1        2.48 ±  2%  perf-profile.self.cycles-pp.mutex_spin_on_owner
     41.51            +3.6       45.08        perf-profile.self.cycles-pp.intel_idle
      1.32 ±  2%      +5.1        6.43 ± 13%  perf-profile.self.cycles-pp.osq_lock
      8.77 ±  4%      +6.8       15.57 ± 12%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


