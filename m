Return-Path: <linux-fsdevel+bounces-5087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE80807E86
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 03:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2977282555
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 02:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DAB10947
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZdBxeSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20967D59;
	Wed,  6 Dec 2023 18:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701916181; x=1733452181;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/XNwhHDfFXOu4jt+f7x743V+e1Rjg9wsnhC4kILKcbU=;
  b=GZdBxeSfJ75J4zkUkeo5EJfXtkSHmdt/8+JMmoAk8RqYJdnGDuMJgtmF
   gorC2uPmZB0kOP75W1eD9n4Z2hiKaTi6a7R1+UwHUQ0MD6OCpwOl6fKXX
   BDskBUVEd6dU3lz0m+/N4KQHoDInthnigKPg0t+1bPx6P7Zv+r09fiFv1
   HvNID5roGkyq37rpQChG7uMMnV5wDso1uBgtfLwTTK86pBAbwVgyD1jdA
   7cYjM5aWfd7XZW55RyVQ/wbEdIk0Ac4dHieuK80SqLHKiuPYwjqdjXXtU
   XsCt85NMbimhEid1UAenhNxTkCLSj+L1PKqoux851HZ4h1k8qFrnq3Bi5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391331733"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391331733"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 18:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="764941047"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="764941047"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 18:29:40 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 18:29:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 18:29:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 18:29:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 18:29:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSzPG+7ngorDSFXSt8L0tzr8kEZfki0wDO/hSzVxWV3vWjxNS0ovJLxcFKkERyHRey+8SRHXprsu0AB3hXCViNY+74CGqZo9+BcxrRWVOa/OSVhXbJwKQbVzKQ6fOhbqICyPxh17KuIyH5QIS1R8TvONTMY+8CNAzaS/L6r51WO7JeVLJhwNsOehR9O2Zo57OXqKfhXCB3lyImPU32RLaVSGmB7TsIaayYB+nRKk/BB/jESK04kvXo74SogqezydljyoTNyJzpyayECgCr4flSwzpN6MoLJM0zbaHwlfWSlr68Xmd8Rl0AJ4IBJMKEsH/V6QTjdd8hxoG3uEH+67aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIfYnSm0WajgBOLcDDFzGdSmbzZ+/oC5kfu9VQ8cFdU=;
 b=mExU3Q1jXlsbkhjX0VT90Wl4A+SXaLMGPIJMaQC2lpwUxpAc6AOUOmEF3DKuYoWwfz80+Cqcf/D6bdI38erHOKo99OLLiyDcNQJnmloMg7e8ZZVej6adF92wABA0Nt5n1nWpWpxmY2HFG9+LwaIMB+AKrUYEsgIEQVaFk6mngs5bIUfVewOQ2GQ5GlSMczxJfwqg3+8YDb0HSIPCNFm2PGGI6w59aBs+RaelmbprmrPSRn5L8y8Ffiij8/UIcJh+juQ91e6RKBkixkG7b+PY4BsD8V1MhInl914jYm/0cRJ+INMkrKo06BKeFfQltXWuWCv7m4Cf5RzmWkAQl3IpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7442.namprd11.prod.outlook.com (2603:10b6:8:14d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 02:29:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 02:29:36 +0000
Date: Thu, 7 Dec 2023 10:29:26 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: Al Viro <viro@zeniv.linux.org.uk>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-fsdevel@vger.kernel.org>, Christian Brauner
	<brauner@kernel.org>, <linux-doc@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, <oliver.sang@intel.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()] 1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <ZXEuBnX4FTDdaqn0@xsang-OptiPlex-9020>
References: <20231204195321.GA1674809@ZenIV>
 <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020>
 <20231206054946.GM1674809@ZenIV>
 <ZXCLgJLy2b5LvfvS@xsang-OptiPlex-9020>
 <20231206161509.GN1674809@ZenIV>
 <20231206163010.445vjwmfwwvv65su@f>
 <CAGudoHF-eXYYYStBWEGzgP8RGXG2+ER4ogdtndkgLWSaboQQwA@mail.gmail.com>
 <20231206170958.GP1674809@ZenIV>
 <CAGudoHErh41OB6JDWHd2Mxzh5rFOGrV6PKC7Xh8JvTn0ws3L_A@mail.gmail.com>
 <CAGudoHGgqH=2mb52T4ZMx9bWtyMm7hV9wPvh+7JbtBq0x4ymYA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGudoHGgqH=2mb52T4ZMx9bWtyMm7hV9wPvh+7JbtBq0x4ymYA@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 59605c31-1cc1-4b46-3f65-08dbf6cc5a93
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gk438OhB1ADhNk4V9eDAP8zgkicYWtFx49YXa6jCPEMcFcG4orJ4edPj6hVpN8MZeF4Zz6m9ww5nZ+SmAw1dzn1NL3HUjsXLTbaF4NaFd7rVzq4PdFHHrZx5hhgjaLwJMNa0zxzdMWNC8o71Z/OBLxrKrqKtueADLv6RfPfV9Kh5NXWZXkQCP2SM9eg/sGvZQSLA0V8ZcxhhmFBcSCKnOY4BAiMZPPbN/JOWR2YBevPkgo5BDIy1Ka0ntpBAs1Jfv4/+HwaYN4WmWg2wmhp1EfDp3U3jbuPUvvrvNm+5iYzTfuM/H7qvUQC0a6lOqwiHGOdJ2/aZUX60HE77QToBF2AMMOeb/cbgH+KtLdzvM+oH1Z3uOQRWWhypJv818rfdiR2UvsWKE4SJ9VMMHYVWcUmPp9KNPMvBDRPXzENohp65aqF0ci8k37UIMSIBNw2EZ51Otg5Uix9GysqAhjfrFFRO9MNzuQ0af1hAsOnyr1Go0nHAsrYOMlxjyoFzLP8RrJQPLOJV2fr6ww/iHMB2IwDdnApZv0EG0+HV0UePsBWWU9pdDtn+lgsodjiOHKmC0p2iwmzsYSC/Mcexbcs5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(8936002)(8676002)(86362001)(316002)(478600001)(82960400001)(4744005)(83380400001)(6512007)(44832011)(9686003)(41300700001)(107886003)(5660300002)(6506007)(66946007)(66476007)(66556008)(54906003)(6916009)(6486002)(966005)(6666004)(33716001)(4326008)(2906002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ej88c0tFE1jUkdTJTvU0v/83g+pqNwpjqcYzDQJcBR095LO38sn8GF1kNJBX?=
 =?us-ascii?Q?os1+lIAzsRpKPZq53hE8D4EUcsX6EIFn/IyktZel1H6seOI0G2suple42Gpe?=
 =?us-ascii?Q?HXjXC4C2na1MZBSVkoPXZQWXlFOkkm0nfgC6IBrclUQKHrkbzKuoIlEVMJpW?=
 =?us-ascii?Q?V/VeDW43116KYn3veBBZWVKlec+pcgx01swzDy/ufWpWVokuV+3dbv90AEN1?=
 =?us-ascii?Q?2m18PEa9gj+ikbpInhZq9LrEv6SrWtsG4CgqjdRq8CYMjpeLvY92tTKxyHFO?=
 =?us-ascii?Q?4j/p3/87YhS+H/rL2u/I8azgRwEXHV0E57whSJ5PJR4lQDWy0FuXP1/a0kkA?=
 =?us-ascii?Q?1Bc4hRqwvX0kgR5pi++ixXmV9z9dBsWpqtvFsbVn4+1zToTLs+fVgjzx+n4G?=
 =?us-ascii?Q?uRjfuX2n3w9cWtJSTpewgMKoZSAv3qdJdbm458D9+lsNciXY1jHnhYFKoafq?=
 =?us-ascii?Q?ja44BzEe2bbErHL8CuOLYLcl8mKJBnF19zRkw+Ftc7zfYfPD5UB4rCM4DM19?=
 =?us-ascii?Q?DqaY8jHVQOQKbCpV2PA26E/U77Kv/Or48PCkTNIElU5eOFKjSKXQQHDfkfow?=
 =?us-ascii?Q?Db+RzmcHQobYBtQX9lA/ywofy1A1R2BvjsH+ktGr4ssHOfwtyGjYLuXO9l9+?=
 =?us-ascii?Q?Ha58cHtznDoURObR9KJ9GJR/Q6Y1LW2EQBCQF+78wR5Y24VwUL07tXv3YzqN?=
 =?us-ascii?Q?1x/hkoZUVYNa4857vY8pR5Tmkw6O/aiTw6Rntq63kW+htohpa4UDbzL4jP2O?=
 =?us-ascii?Q?jEO3qhdyoqi9ozL08Knd6cTER+JX7uRVdzmrEgH0KeHzv0+hjSTpNTRQ7yRp?=
 =?us-ascii?Q?w/X/QeHRN3GD20fHVO3WqIUtsha0xzgvhZfbFpJauqB1kiWHsRkNx1w459Lr?=
 =?us-ascii?Q?fgbG4tdYBCJ7cudhqZNvXCb/o1jwp0HOL8vW9x70uVlF4x4Txdxyi3b8Tw0R?=
 =?us-ascii?Q?rwAqbdF+h0SDfyjvaAXRYafNoovDkoJj5NcH0MLqcwRXPboMfyhx0ZttXQZe?=
 =?us-ascii?Q?2XCHKv2uRAUVBXMl2elgN5Ls/J8ehgHo7DeoVCw4UpibHbSD24fUUW0Eqf0G?=
 =?us-ascii?Q?WweXWXqbKO5awjfbf4CfZwqAu9Ew2uI66nw70601/75Gpx7AnUwhicWLfrYi?=
 =?us-ascii?Q?VBF6dOBvUVCu4b/gguRjAkLsKs6Qo9Sdo7Z9tc/wt6hRmIsz7ih3uHw49SSN?=
 =?us-ascii?Q?k1ssHIYOr/EcpTXbAYf/cKWE1V1uDfWxUGkgmA/wVG9oDM4Gn/yLBRZbt+iY?=
 =?us-ascii?Q?eOsbuulOAc4fqstatm+nFViLm6F7XrAUxA/uCLupduGGN5kQjXttomdzc67Z?=
 =?us-ascii?Q?9Yg/IzJVABqNPfqJKtM8M3Vz01c7nMBzQmNn/ejhWp1b09Voyjxk5l3oN3fO?=
 =?us-ascii?Q?K374UQD5d39jLXMZPPwW+6XIv6M9oe1PfZxkFLZ4NcssaUL6bLzNzv36bxwC?=
 =?us-ascii?Q?zxYnKKaeh14OrDvHxoDznt5k5fkDZPLBFo2tUcQ/qmmsqzM4HRVVYRLO9bIG?=
 =?us-ascii?Q?QEiS7p3o+13Wscbk2BNYxGd8VXwXHKeJeqpZFY3ioi3lWXTMtbyy37lDk0PO?=
 =?us-ascii?Q?eaW5/LNtvHwE+VmRpI2PHTUkXEA9bZznsY1FMrwzOLOJujWSGLTxG7/L0VTv?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59605c31-1cc1-4b46-3f65-08dbf6cc5a93
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 02:29:35.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8VnOakduv7UCdrfXX0Y4EQUTVCxOXCM1lVZacd/dKS1GQ3lhBz3Z0j3RrrNhduD2n6Z25ThwfKL+oGa4lK/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7442
X-OriginatorOrg: intel.com

hi, Mateusz Guzik,

On Wed, Dec 06, 2023 at 07:30:36PM +0100, Mateusz Guzik wrote:
> Can I get instructions how to reproduce the unixbench regression?

I uploaded the reproducer for unixbench in
https://download.01.org/0day-ci/archive/20231207/202312070941.6190a04c-oliver.sang@intel.com

as in
https://download.01.org/0day-ci/archive/20231207/202312070941.6190a04c-oliver.sang@intel.com/reproduce

To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


> 
> I only found them for stressng.
> 
> -- 
> Mateusz Guzik <mjguzik gmail.com>

