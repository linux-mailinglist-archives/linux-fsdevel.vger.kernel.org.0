Return-Path: <linux-fsdevel+bounces-4536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0780019B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 03:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419D52815F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E5A11710
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5y1E+ju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE58112;
	Thu, 30 Nov 2023 18:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701396807; x=1732932807;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZRWziuyns8TA/aW/Ar6QtEc59g7M2MNg9xGqdwdQWxU=;
  b=A5y1E+juMsVTOJiHPquFaAVHiN5EVQ6cBPEK1WFF5fQuLiVY0vMXFEtk
   6RXuXtmitOq2WC418/0MtsmY+a3KPGl0eP/AGE4n0TUZ0dLEZ34zHoSSM
   T434zKHXgHZdCSGced2sRh4L2gT2/NR0H3SUNI10dvrLXkvBtze59lF9v
   +Ia3YMF3/0bBWKclHMgc3SnfT0FuV7ftApuyC0sY2sqVTWKDZVKTPv05J
   z6oZW+RMFaOkJXLV+m1mBEmpctbf/pCpBgRnIf/r3eWxeAr6o5h9bnLNg
   vDa4Ih2P5VijepfA5LIqDgBDbTlFWt9NRV2mHix7gh/u7BIXXP3WiEhho
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="396228515"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="396228515"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 18:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="1016858960"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="1016858960"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 18:13:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 18:13:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 18:13:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 18:13:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD95sekurmXkYwY8qKaeV/DR3hRnTZg0Wu6O+U9/E4FL/RUDv0BfCEk1Dcip7sd8e3FewI8ULFBijnHFV4P4PvDa/kBnztWPDjlI9pQRii0AvkT8caNA4CDFwK0L7NMBbsxJOP5zm09SHrozIzXpHw7+iJPH/TF9DBBU0QebJdD4p6p5ZBOasYQB5iD/uOL+qe0TafFXBnmF+jDWojVxzIlGJsgViEkkS9pBsbF7NTvW6QMk3thTIUzie39riq3jceobFMGO33CKvFa3TSPAklcer+ErJO8VAVmAWCNBeR5BzC5SRcW5JDfvKSglvL+Bjo9KzV5sA2bLpP9+tvw7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOwElNZyuyhq1hgLX4W8HwDbF8wuAh0H7Qd00D1Me1M=;
 b=K4XOUz91upxVpylTp07hUutViFCsWzWIIHQhgZSd0N3KaYsuj9aEhrgjrmQ/tsxm/edyW1LCfuiWi0Y/4tkqnQxpP/8JhH9tmzSyEeXK4JW4mZIqp0HE5Wxcm3D8SxFRRm52fS9GgHx48slTeWpaZaHudD2X3yq9/dH2am1/mU9moLwhqXhH/DWAN0D89qQg1iGw6+KltbrF1+mAjkXasjN7u40kZSF9sOA9maf9+JiVqO66xtrHda4c5MtUOgdV5iIAFj612dEtQujk98CxYkzTx7+z8inauV/T6RBykFEFBkN3gXIeW1YHcquDVNNcllFudceolf8dGGxRbrXW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6652.namprd11.prod.outlook.com (2603:10b6:510:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 02:13:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 02:13:19 +0000
Date: Fri, 1 Dec 2023 10:13:09 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	<linux-doc@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()]  1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <ZWlBNSblpWghkJyW@xsang-OptiPlex-9020>
References: <202311300906.1f989fa8-oliver.sang@intel.com>
 <20231130075535.GN38156@ZenIV>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130075535.GN38156@ZenIV>
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 6765e34a-5972-4d71-d3eb-08dbf213150f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50OBT6L7blMcw3RxN/LTfhvBttdNLeoJO9G252uLJK45QkR+sBvms5ufzLsPF1pMU5LIs+7n3QP7d5ftjXk0txUWOST/lOrvMNtsqKYMu8Yio/0J5sWtK9iGxv7vNG+c0ZNbUmAqBz784027hV864IPERUjc6QOxJAB7QnYFNFbfWAZgVgks46QnB8/atNJn0sq+/gWfrF1i4EX7rlyVL3KilsWI9D1X5ga+s+emYYgo8oyhvwJ0VX0hfwbLjT5y8L6WgvPAaaYEFR9pq4Mh/9dlKLl3D5yWfZzUbft7Txp6zHESwjpkE1AG/6mMlm5hTmIhVSDouW5p4TcHrs9zHySpGmG44BcPwb9jjHEexH2zxpAsGbQCmFej5Pj0VzbNl1iZ230dGsG1rbwhFmRWAH7eqbLFruSPmrNUIpdq/tXwJbmJAESF5Fo80qZZim58CjfVedZIQ+qcsHajSlRzak1CrF35i6GlTIbqJCpeYKFYQIaofUrg3prAIQn+hRNHh1bQXcol0lSYTDkuOXbkJfnd0Dr7GA6bLGS88eozYFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(66556008)(66476007)(6916009)(82960400001)(38100700002)(86362001)(83380400001)(26005)(6506007)(6512007)(107886003)(9686003)(6666004)(6486002)(19627235002)(478600001)(2906002)(966005)(316002)(33716001)(41300700001)(8676002)(4326008)(44832011)(30864003)(5660300002)(8936002)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/XLaSG2eT7IeBNa+up2OpxkE5K/7SRyh0Qemv27mCXWnXEr+CfwjWWq20j?=
 =?iso-8859-1?Q?6XVxF3Vp+mVE3So98JUm1KbBTeA5yVUzAPPNEtUO/Uz9WTIS3bhDkyvTbk?=
 =?iso-8859-1?Q?zCfi11+qvxeFzQLamhEreMybiu4hOGG0m1MeNeIz47Ot4poewfqfrWb4Dk?=
 =?iso-8859-1?Q?oDrpiYUEL0minOyv4vxmy1wx3xn+aSoenmULzeSETQkh7wJZryCMKXzIm1?=
 =?iso-8859-1?Q?ru0mPQ5alfTPcQHj9g++7DDu+QusnDE4n1CNaDgSXySiaiivUg1+Xro0ZI?=
 =?iso-8859-1?Q?cb93i5cylZxTQpbyfHeMhqXET6uDVZYXgWmt3gFWFkvazIHs2EFg4hWc3j?=
 =?iso-8859-1?Q?2U0dASR99Xbcl+DBKoPFpb/e7Q2h9fbtYxJQ4Ztu8qH6htWqyDUnAXlnkG?=
 =?iso-8859-1?Q?v7aB5BzlDR12oQF4CAfG7XMrHAPyxLyYU1vPlKvMqeHO7AG8jOaTC8v6hk?=
 =?iso-8859-1?Q?J6Fu2nGQvQaSNHBYkFnAYig8FoEsbpwn/IDXEnb6WG571Ap9B5gY4WdfNP?=
 =?iso-8859-1?Q?XT5HeDpM+rb8M4Uf09qvmLLisxxyuMq1ZMneml8cWVmZ2zinWz5BSCe9PE?=
 =?iso-8859-1?Q?l4SJXxjAjPQMO0saaLAkIqBy74QpA6lT0ToBQcPvRPVDfX+QJjdJLPZxwZ?=
 =?iso-8859-1?Q?Jwz+eEtFoqW9hcXPnTOaL64zT+A5R3Lj9UqJW4MMUeKsyQ1nUsxHIh8QjS?=
 =?iso-8859-1?Q?wPzesk9KqTolcKQs9Wg5ilIuDaiOBjbLGh2ct9KEdD+g2Jz9lQTPwvQY8O?=
 =?iso-8859-1?Q?CPGoM1c5RPwW/28Tw4ODNo6pr5SqBA1oBdavnul5U3MtwRrtc+wlNEWXfy?=
 =?iso-8859-1?Q?JVdbnb2CasjRSLhCDNXFiiK6ZSvw2cDECW0mm9OE8NXvVfKFlq4mG7EMxp?=
 =?iso-8859-1?Q?x0o1N1GKWdYnyaXMU4F2CatvLAnP0pTBIqfDRUkTu66ZFylmgDLQAXXbzw?=
 =?iso-8859-1?Q?Jh+BO1yV3ikrGutQGWlkI7m3evZvnd8Rnv22rtp21gTfq9+a1BZwQGx+T0?=
 =?iso-8859-1?Q?zZkNqE+JOPar1w5rq0VIHTaG/jaXpcdx6IDjHl51JcooakshaHGpWGDvKL?=
 =?iso-8859-1?Q?yW7RI1wSB2r1S/LTI61aYg8jMCbvEu99TxvIYfH6F1Vd3re3aYJtN2pPpx?=
 =?iso-8859-1?Q?2DpeHUA5mnAWXMn6mo4qmn6gk6foXocEHscCeOIXvmQeCrfuIXK3LwOXck?=
 =?iso-8859-1?Q?0uoIkCtnXNdCJB5S64uiVLzANvcG72UnM6HXggfSgNw5BJnivbdYES/WGj?=
 =?iso-8859-1?Q?MU63RxlRYue8+BJqeckVdd5Jr4/J8fYbxOXTewyukigUJ5Cu5jltrkqXiU?=
 =?iso-8859-1?Q?f1s5nq3Uhtg2715M3t0Uz7EGj1LXEoU8NfcxFBNpmsoSoIkWkNlCn9BSr3?=
 =?iso-8859-1?Q?y5/BuJ/kRF0vHjkYAvMIUd9PYJOyKrBFvfPvaM0PssgkYrWh4Y34qXGWdG?=
 =?iso-8859-1?Q?iLEEPNCTI841NkbXTpzU06iuPnpHniVa2Iq81sThUz+gmiIaIfCqkfs5tZ?=
 =?iso-8859-1?Q?Pr730YXHJUBNznJQX1MBv07w4qosTtDEc77w2K0xd+3NlC6y/UTrkELYmF?=
 =?iso-8859-1?Q?kir37/mNiXgnaCyptnfeyqxwa/hyF3B+q8o1GExB29vog2vaI/gUmJndDh?=
 =?iso-8859-1?Q?fh8TX2RUKxytKgrCTY0FaOOFcr/LPk3cd98uokIMkqr3g8yThVsOsZCQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6765e34a-5972-4d71-d3eb-08dbf213150f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 02:13:18.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: by1Lc6qbNCC7dkEOhul2AtffAtyiBoQRkfIiiWm01PJX16GlWYTexkxF1Mwz7s/KdHqol4mn1yn9PM30PscDGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6652
X-OriginatorOrg: intel.com

hi, Al Viro,

On Thu, Nov 30, 2023 at 07:55:35AM +0000, Al Viro wrote:
> On Thu, Nov 30, 2023 at 12:54:01PM +0800, kernel test robot wrote:
> 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20231130/202311300906.1f989fa8-oliver.sang@intel.com
> > 
> > =========================================================================================
> > class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
> >   os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s
> > 
> > commit: 
> >   e3640d37d0 ("d_prune_aliases(): use a shrink list")
> >   1b738f196e ("__dentry_kill(): new locking scheme")
> 
> Very interesting...  Out of curiosity, what effect would the following
> have on top of 1b738f196e?

I applied the patch upon 1b738f196e (as below fec356fd0c), but seems less
useful.

(I also rebuild and rerun 1b738f196e and its parent since we have some config
updates, now 3 commits are built with same config, as attached. since rerun,
you would see the data have some difference for 1b738f196e and its parent,
but similar as before)

for stress-ng (full comparison as below [1]):

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s

commit:
  e3640d37d0 ("d_prune_aliases(): use a shrink list")
  1b738f196e ("__dentry_kill(): new locking scheme")
  fec356fd0c ("fix for 1b738f196e from Al Viro")

e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 fec356fd0c7d05c7dbcbaf593c3
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    323525 ±  4%     -28.6%     230913 ±  2%     -27.1%     235723 ±  4%  stress-ng.sysinfo.ops
      5415 ±  3%     -28.9%       3848 ±  2%     -27.5%       3928 ±  4%  stress-ng.sysinfo.ops_per_sec


for unixbench (full comparison as below [2]):

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp9/shell1/unixbench

commit:
  e3640d37d0 ("d_prune_aliases(): use a shrink list")
  1b738f196e ("__dentry_kill(): new locking scheme")
  fec356fd0c ("fix for 1b738f196e from Al Viro")


e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 fec356fd0c7d05c7dbcbaf593c3
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
     35237           -15.4%      29823           -15.4%      29798        unixbench.score



[1]
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s

commit:
  e3640d37d0 ("d_prune_aliases(): use a shrink list")
  1b738f196e ("__dentry_kill(): new locking scheme")
  fec356fd0c ("fix for 1b738f196e from Al Viro")

e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 fec356fd0c7d05c7dbcbaf593c3
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      1416 ± 22%    +589.0%       9760 ±151%     -45.1%     777.25 ± 32%  sched_debug.cfs_rq:/.load_avg.max
    533.10 ± 21%     +33.9%     713.75 ± 24%     +53.0%     815.50 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.max
      3146 ± 47%     -65.7%       1080 ±  7%     -64.3%       1123 ±  3%  time.involuntary_context_switches
      3.41 ±  3%     -25.8%       2.53 ±  3%     -24.4%       2.58 ±  5%  time.user_time
    323525 ±  4%     -28.6%     230913 ±  2%     -27.1%     235723 ±  4%  stress-ng.sysinfo.ops
      5415 ±  3%     -28.9%       3848 ±  2%     -27.5%       3928 ±  4%  stress-ng.sysinfo.ops_per_sec
      3146 ± 47%     -65.7%       1080 ±  7%     -64.3%       1123 ±  3%  stress-ng.time.involuntary_context_switches
     25957            +1.4%      26330            +1.8%      26423        proc-vmstat.nr_slab_reclaimable
    463457 ±  3%      +7.1%     496419            +6.5%     493401        proc-vmstat.numa_hit
    397193 ±  4%      +8.3%     430180            +7.6%     427182        proc-vmstat.numa_local
    567604 ±  5%     +10.9%     629697           +11.0%     629767        proc-vmstat.pgalloc_normal
    525529 ±  6%     +11.9%     588107 ±  2%     +11.9%     588208        proc-vmstat.pgfree
      7100 ± 29%     -19.8%       5693 ± 41%     -48.6%       3651 ± 68%  numa-meminfo.node0.Active
      5321 ± 38%     -35.3%       3444 ± 89%     -56.1%       2338 ±111%  numa-meminfo.node0.Active(file)
    211480 ± 15%     -25.2%     158279 ± 38%     +26.0%     266468 ± 12%  numa-meminfo.node0.AnonPages.max
      2007 ±104%     +80.4%       3621 ± 81%    +144.9%       4916 ± 54%  numa-meminfo.node1.Active(file)
    163193 ± 11%     +36.4%     222671 ± 31%     -36.3%     103907 ± 35%  numa-meminfo.node1.AnonPages
      2500 ±197%    +149.8%       6245 ± 98%    +236.9%       8421 ± 69%  numa-meminfo.node1.Inactive(file)
     30483 ±  5%      -7.8%      28110 ±  3%      -0.8%      30225 ±  5%  numa-meminfo.node1.Shmem
      1330 ± 38%     -35.3%     861.17 ± 89%     -56.1%     584.50 ±111%  numa-vmstat.node0.nr_active_file
      1330 ± 38%     -35.3%     861.17 ± 89%     -56.1%     584.50 ±111%  numa-vmstat.node0.nr_zone_active_file
    501.85 ±104%     +80.4%     905.34 ± 81%    +144.9%       1229 ± 54%  numa-vmstat.node1.nr_active_file
     40727 ± 11%     +36.7%      55672 ± 31%     -36.3%      25940 ± 36%  numa-vmstat.node1.nr_anon_pages
    625.02 ±197%    +149.8%       1561 ± 98%    +236.9%       2105 ± 69%  numa-vmstat.node1.nr_inactive_file
      7628 ±  5%      -7.9%       7028 ±  3%      -0.9%       7557 ±  5%  numa-vmstat.node1.nr_shmem
    501.85 ±104%     +80.4%     905.34 ± 81%    +144.9%       1229 ± 54%  numa-vmstat.node1.nr_zone_active_file
    625.02 ±197%    +149.8%       1561 ± 98%    +236.9%       2105 ± 69%  numa-vmstat.node1.nr_zone_inactive_file
      0.04 ±  8%     -30.7%       0.03 ± 13%    +542.8%       0.28 ±195%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 15%     -25.5%       0.01 ±  8%     -11.3%       0.01 ± 20%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3820 ±  2%     +10.2%       4210 ±  2%      +5.9%       4044 ± 10%  perf-sched.total_wait_and_delay.max.ms
      3820 ±  2%     +10.2%       4210 ±  2%      +5.9%       4044 ± 10%  perf-sched.total_wait_time.max.ms
      0.13 ±109%     -97.8%       0.00 ±158%     -46.6%       0.07 ±162%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast.walk_component
      0.19 ± 88%     -85.6%       0.03 ± 62%     -93.2%       0.01 ±136%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.15 ±100%     -98.1%       0.00 ±158%     -54.5%       0.07 ±162%  perf-sched.wait_time.max.ms.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast.walk_component
      0.55 ± 76%     -95.2%       0.03 ± 62%     -97.2%       0.02 ±124%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      1.63           +11.8%       1.82           +10.8%       1.81        perf-stat.i.MPKI
 1.119e+09 ±  2%     -11.7%  9.883e+08           -11.1%  9.943e+08 ±  2%  perf-stat.i.branch-instructions
      0.74            +0.1        0.79            +0.1        0.79 ±  2%  perf-stat.i.branch-miss-rate%
   8657774 ±  2%      -4.7%    8250673 ±  2%      -4.8%    8244070 ±  2%  perf-stat.i.cache-misses
  22243026 ±  3%      -6.2%   20859613 ±  2%      -5.1%   21119529 ±  3%  perf-stat.i.cache-references
      3.76 ±  2%     +18.1%       4.43           +17.3%       4.40 ±  2%  perf-stat.i.cpi
 1.429e+09 ±  2%     -13.5%  1.236e+09           -12.8%  1.246e+09 ±  2%  perf-stat.i.dTLB-loads
      0.01            +0.0        0.01            +0.0        0.01 ±  3%  perf-stat.i.dTLB-store-miss-rate%
     40681            +1.1%      41124            +2.5%      41696        perf-stat.i.dTLB-store-misses
 6.991e+08 ±  2%     -18.2%  5.715e+08 ±  2%     -17.1%  5.796e+08 ±  3%  perf-stat.i.dTLB-stores
 5.579e+09 ±  2%     -12.9%  4.858e+09           -12.3%  4.893e+09 ±  2%  perf-stat.i.instructions
      0.30 ±  2%     -13.6%       0.26           -13.2%       0.26 ±  2%  perf-stat.i.ipc
      0.06 ± 66%      -7.8%       0.05 ± 74%    +136.9%       0.14 ± 48%  perf-stat.i.major-faults
    482.25 ±  2%      -5.8%     454.13 ±  2%      -5.0%     458.03 ±  2%  perf-stat.i.metric.K/sec
     50.70 ±  2%     -13.9%      43.66           -13.2%      44.03 ±  2%  perf-stat.i.metric.M/sec
   4621654 ±  3%      -5.9%    4348981 ±  2%      -6.2%    4336159 ±  2%  perf-stat.i.node-load-misses
     86.87            +1.7       88.62            +1.3       88.20        perf-stat.i.node-store-miss-rate%
    478923 ±  4%     -12.7%     418279 ±  6%      -8.8%     436833 ±  7%  perf-stat.i.node-stores
      1.55 ±  2%      +9.5%       1.70            +8.6%       1.69        perf-stat.overall.MPKI
      0.86            +0.1        0.96 ±  2%      +0.1        0.95 ±  3%  perf-stat.overall.branch-miss-rate%
      3.58 ±  2%     +15.6%       4.14           +15.0%       4.12 ±  2%  perf-stat.overall.cpi
      2307 ±  2%      +5.6%       2435 ±  2%      +5.8%       2440 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.01            +0.0        0.01            +0.0        0.01 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
      0.28 ±  2%     -13.5%       0.24           -13.0%       0.24 ±  2%  perf-stat.overall.ipc
     87.65            +1.2       88.87            +0.7       88.37        perf-stat.overall.node-store-miss-rate%
   1.1e+09 ±  2%     -11.7%  9.716e+08           -11.2%  9.774e+08 ±  2%  perf-stat.ps.branch-instructions
   8518482 ±  2%      -4.7%    8118194 ±  2%      -4.8%    8112169 ±  2%  perf-stat.ps.cache-misses
  21885056 ±  3%      -6.2%   20519540 ±  2%      -5.1%   20773225 ±  3%  perf-stat.ps.cache-references
 1.405e+09 ±  2%     -13.5%  1.215e+09           -12.8%  1.225e+09 ±  2%  perf-stat.ps.dTLB-loads
     39970            +1.1%      40404            +2.4%      40947        perf-stat.ps.dTLB-store-misses
 6.877e+08 ±  2%     -18.3%  5.621e+08 ±  2%     -17.1%    5.7e+08 ±  3%  perf-stat.ps.dTLB-stores
 5.487e+09 ±  2%     -13.0%  4.776e+09           -12.3%   4.81e+09 ±  2%  perf-stat.ps.instructions
      0.06 ± 66%      -7.3%       0.05 ± 74%    +137.1%       0.14 ± 48%  perf-stat.ps.major-faults
   4548215 ±  3%      -5.9%    4279880 ±  2%      -6.2%    4267801 ±  2%  perf-stat.ps.node-load-misses
    470504 ±  4%     -12.7%     410550 ±  6%      -8.9%     428587 ±  7%  perf-stat.ps.node-stores
 3.443e+11 ±  2%     -13.1%  2.992e+11           -12.4%  3.016e+11 ±  2%  perf-stat.total.instructions
     18.88           -18.9        0.00           -18.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.terminate_walk
     18.44           -18.4        0.00           -18.4        0.00        perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_lookupat.filename_lookup
     17.06           -17.1        0.00           -17.1        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.terminate_walk.path_lookupat
      8.57            -7.8        0.80 ±  7%      -7.8        0.76 ±  8%  perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
     17.14            -4.6       12.53            -4.9       12.26        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup
     17.38            -4.3       13.06            -4.5       12.85        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      9.32            -2.4        6.89            -2.4        6.95 ±  2%  perf-profile.calltrace.cycles-pp.open64
      9.22            -2.4        6.82            -2.3        6.87 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      9.22            -2.4        6.83            -2.3        6.88 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      9.19            -2.4        6.80            -2.3        6.85 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      9.18            -2.4        6.80            -2.3        6.84 ±  2%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      8.63            -2.2        6.42            -2.2        6.47 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.59            -2.2        6.40            -2.2        6.44 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      7.74            -2.1        5.66 ±  2%      -2.1        5.65 ±  2%  perf-profile.calltrace.cycles-pp.__xstat64
      7.66            -2.1        5.60 ±  2%      -2.1        5.60 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
      7.65            -2.1        5.59 ±  2%      -2.1        5.59 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      7.62            -2.0        5.58 ±  2%      -2.1        5.57 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      7.30            -2.0        5.34 ±  2%      -2.0        5.33 ±  2%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      6.77            -1.8        5.00 ±  2%      -1.8        4.99 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      6.52            -1.7        4.78 ±  2%      -1.7        4.78 ±  2%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.48            -1.7        4.76 ±  2%      -1.7        4.75 ±  2%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      7.13 ±  3%      -1.5        5.63            -1.5        5.58        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk
      5.90 ±  2%      -1.3        4.62            -1.3        4.56        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat
      5.93 ±  2%      -1.2        4.68            -1.3        4.65 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup
      3.25 ±  2%      -0.9        2.40            -0.8        2.45 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.67            -0.9        0.82 ±  3%      -0.8        0.83 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
      3.22 ±  2%      -0.8        2.37 ±  3%      -0.9        2.34 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      4.01            -0.8        3.19 ±  2%      -0.8        3.18 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      1.67 ±  7%      -0.7        0.96 ±  4%      -0.7        0.98        perf-profile.calltrace.cycles-pp.__close
      1.58 ±  6%      -0.7        0.90 ±  4%      -0.7        0.92        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.58 ±  6%      -0.7        0.90 ±  4%      -0.7        0.92        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      1.55 ±  7%      -0.7        0.88 ±  4%      -0.7        0.90        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.29 ±  7%      -0.6        1.66 ±  8%      -0.6        1.65 ±  7%  perf-profile.calltrace.cycles-pp.syscall
      2.20 ±  7%      -0.6        1.60 ±  8%      -0.6        1.58 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      1.29 ±  7%      -0.6        0.68 ±  4%      -0.6        0.71        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.19 ±  7%      -0.6        1.59 ±  8%      -0.6        1.58 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.16 ±  8%      -0.6        1.57 ±  8%      -0.6        1.56 ±  6%  perf-profile.calltrace.cycles-pp.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.51 ±  2%      -0.6        1.93            -0.6        1.92        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.49            -0.6        1.92            -0.6        1.91        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.84 ±  7%      -0.6        0.27 ±100%      -0.4        0.44 ± 44%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
      2.14 ±  4%      -0.5        1.62 ±  3%      -0.5        1.63 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      1.93 ±  4%      -0.5        1.41 ±  3%      -0.5        1.43 ±  5%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.12 ±  3%      -0.5        1.61 ±  3%      -0.5        1.62 ±  2%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      1.14 ±  3%      -0.5        0.64 ±  6%      -0.5        0.67 ±  7%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.path_lookupat.filename_lookup
      1.35 ±  6%      -0.5        0.86 ±  5%      -0.5        0.86 ±  4%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      1.64 ±  5%      -0.5        1.16 ±  7%      -0.5        1.18 ±  6%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.98 ±  4%      -0.5        1.52            -0.4        1.54 ±  2%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_openat
      2.00 ±  4%      -0.5        1.55            -0.4        1.58 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.do_filp_open
      2.00 ±  4%      -0.5        1.55            -0.4        1.58 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.94 ±  3%      -0.4        1.51 ±  3%      -0.5        1.48 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      1.08 ± 33%      -0.4        0.66 ±  3%      -0.4        0.68 ±  7%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      1.39 ±  3%      -0.4        0.98 ±  4%      -0.4        0.98 ±  4%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      1.19 ±  5%      -0.3        0.84 ±  7%      -0.3        0.84 ±  5%  perf-profile.calltrace.cycles-pp.user_get_super.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.01 ± 18%      -0.3        0.67 ±  4%      -0.4        0.66 ±  5%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      0.79 ±  6%      -0.3        0.47 ± 46%      -0.3        0.48 ± 46%  perf-profile.calltrace.cycles-pp.shmem_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64
      0.98 ± 13%      -0.3        0.67 ±  3%      -0.3        0.68 ±  7%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      1.11 ±  2%      -0.3        0.83 ±  3%      -0.3        0.84 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
      1.12 ±  2%      -0.3        0.84 ±  3%      -0.3        0.85 ±  2%  perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      0.99 ±  6%      -0.3        0.74 ±  3%      -0.3        0.73 ±  3%  perf-profile.calltrace.cycles-pp.fstatfs64
      0.82 ±  7%      -0.2        0.59 ±  7%      -0.2        0.59 ±  4%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
      0.81 ±  7%      -0.2        0.61 ±  3%      -0.2        0.61 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.79 ±  7%      -0.2        0.60 ±  4%      -0.2        0.60 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.74 ±  7%      -0.2        0.56 ±  4%      -0.2        0.56 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_fstatfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.66 ±  5%      +0.2        0.88 ±  4%      +0.2        0.89 ±  6%  perf-profile.calltrace.cycles-pp.down_read.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      0.57 ±  5%      +0.2        0.80 ±  5%      +0.3        0.84 ±  3%  perf-profile.calltrace.cycles-pp.__legitimize_mnt.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      0.00            +0.6        0.61 ±  6%      +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel
      0.00            +0.7        0.72 ±  7%      +0.7        0.69 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      0.00            +0.8        0.78 ±  7%      +0.7        0.75 ±  8%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.00            +1.2        1.24            +1.2        1.23 ±  5%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_lookupat.filename_lookup
     31.75            +1.4       33.19            +1.2       32.95        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      0.00            +1.7        1.70 ±  2%      +1.7        1.69 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00            +1.7        1.75            +1.7        1.74        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      5.79 ±  2%      +2.5        8.30            +2.4        8.21 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
      6.47            +2.6        9.06            +2.5        9.02        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      6.97            +2.6        9.62            +2.6        9.57        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
      7.13            +2.8        9.93            +2.9        9.99        perf-profile.calltrace.cycles-pp.step_into.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      6.55            +3.0        9.54            +3.0        9.60        perf-profile.calltrace.cycles-pp.dput.step_into.path_lookupat.filename_lookup.user_path_at_empty
     17.13 ±  2%      +4.5       21.66            +4.4       21.55        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
     16.40            +5.5       21.86            +5.4       21.79        perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
     16.35            +5.5       21.82            +5.4       21.75        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty
     13.19            +5.6       18.77            +5.6       18.74        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.user_path_at_empty
     11.12 ±  2%      +6.0       17.09            +5.9       16.99        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
     10.54 ±  2%      +6.1       16.61            +6.0       16.51        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
     11.69 ±  2%      +6.2       17.90 ±  2%      +6.1       17.84        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.path_lookupat
     11.71 ±  2%      +6.2       17.92 ±  2%      +6.1       17.85        perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.path_lookupat.filename_lookup
     68.92            +6.4       75.32            +6.1       74.98        perf-profile.calltrace.cycles-pp.__statfs
     68.63            +6.5       75.10            +6.1       74.76        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__statfs
     68.58            +6.5       75.06            +6.2       74.73        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     68.45            +6.5       74.98            +6.2       74.64        perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     68.22            +6.6       74.80            +6.2       74.46        perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     65.82            +7.3       73.09            +6.9       72.76        perf-profile.calltrace.cycles-pp.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +7.4        7.43            +7.5        7.48        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
     63.75            +7.5       71.23            +7.2       70.93        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
     63.59            +7.5       71.10            +7.2       70.81        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs
      0.00            +8.6        8.58            +8.6        8.64        perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.path_lookupat
      0.00            +9.3        9.34            +9.4        9.40        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.path_lookupat.filename_lookup
      0.00           +21.7       21.74           +21.7       21.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_lookupat
      0.00           +22.0       22.02           +22.0       21.98        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_lookupat.filename_lookup
     29.00           -29.0        0.00           -29.0        0.00        perf-profile.children.cycles-pp.fast_dput
      8.50            -8.5        0.00            -8.5        0.00        perf-profile.children.cycles-pp.lock_for_kill
     17.17            -4.6       12.56            -4.9       12.31        perf-profile.children.cycles-pp.d_alloc_parallel
     17.42            -4.3       13.08            -4.5       12.88        perf-profile.children.cycles-pp.__lookup_slow
     13.42            -3.5        9.91            -3.5        9.92 ±  2%  perf-profile.children.cycles-pp.link_path_walk
      9.35            -2.4        6.91            -2.4        6.97 ±  2%  perf-profile.children.cycles-pp.open64
      9.37            -2.4        6.98            -2.4        7.01 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
      9.36            -2.4        6.97            -2.4        7.00 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      8.81            -2.2        6.60            -2.2        6.63 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      8.78            -2.2        6.58            -2.2        6.61 ±  2%  perf-profile.children.cycles-pp.path_openat
      7.77            -2.1        5.68 ±  2%      -2.1        5.67 ±  2%  perf-profile.children.cycles-pp.__xstat64
      7.67            -2.0        5.62 ±  2%      -2.1        5.61 ±  2%  perf-profile.children.cycles-pp.__do_sys_newstat
      7.35            -2.0        5.38 ±  2%      -2.0        5.38 ±  2%  perf-profile.children.cycles-pp.vfs_statx
     38.44            -1.2       37.22            -1.3       37.12        perf-profile.children.cycles-pp.dput
      2.71 ±  6%      -0.9        1.76 ±  3%      -0.9        1.77 ±  3%  perf-profile.children.cycles-pp.inode_permission
      2.90 ±  6%      -0.8        2.10 ±  6%      -0.8        2.12 ±  4%  perf-profile.children.cycles-pp.statfs_by_dentry
      1.70 ±  6%      -0.7        0.98 ±  4%      -0.7        1.00        perf-profile.children.cycles-pp.__close
      1.56 ±  7%      -0.7        0.88 ±  4%      -0.7        0.90        perf-profile.children.cycles-pp.__x64_sys_close
      1.71 ±  7%      -0.6        1.06 ±  3%      -0.6        1.08 ±  5%  perf-profile.children.cycles-pp.kernfs_iop_permission
      2.32 ±  7%      -0.6        1.68 ±  8%      -0.7        1.66 ±  6%  perf-profile.children.cycles-pp.syscall
      2.63 ±  2%      -0.6        2.00 ±  2%      -0.7        1.97 ±  5%  perf-profile.children.cycles-pp.lockref_put_return
      1.30 ±  7%      -0.6        0.69 ±  4%      -0.6        0.72        perf-profile.children.cycles-pp.__fput
      2.11 ±  7%      -0.6        1.51 ±  7%      -0.6        1.54 ±  6%  perf-profile.children.cycles-pp.__percpu_counter_sum
      2.16 ±  7%      -0.6        1.57 ±  8%      -0.6        1.56 ±  6%  perf-profile.children.cycles-pp.__do_sys_ustat
      1.59 ±  3%      -0.5        1.04 ±  5%      -0.5        1.12 ±  8%  perf-profile.children.cycles-pp.__d_lookup_rcu
      1.93 ±  4%      -0.5        1.41 ±  3%      -0.5        1.44 ±  5%  perf-profile.children.cycles-pp.do_open
      2.07 ±  2%      -0.5        1.57 ±  3%      -0.5        1.60 ±  4%  perf-profile.children.cycles-pp.complete_walk
      1.39 ±  2%      -0.4        0.95 ±  5%      -0.4        0.98 ±  5%  perf-profile.children.cycles-pp.lockref_get
      1.39 ±  4%      -0.4        0.99 ±  4%      -0.4        0.99 ±  4%  perf-profile.children.cycles-pp.do_dentry_open
      2.48 ±  6%      -0.4        2.08 ±  3%      -0.4        2.12        perf-profile.children.cycles-pp.down_read
      1.39 ±  7%      -0.4        1.01 ±  9%      -0.4        1.03 ±  7%  perf-profile.children.cycles-pp.shmem_statfs
      0.50            -0.4        0.14 ± 16%      -0.4        0.12 ± 14%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.62 ±  8%      -0.4        0.26 ±  6%      -0.4        0.26 ±  6%  perf-profile.children.cycles-pp.dcache_dir_close
      1.12 ± 23%      -0.4        0.76 ±  2%      -0.3        0.79 ±  3%  perf-profile.children.cycles-pp.try_to_unlazy_next
      1.19 ±  6%      -0.4        0.84 ±  7%      -0.3        0.84 ±  5%  perf-profile.children.cycles-pp.user_get_super
      1.20 ±  6%      -0.3        0.86 ±  5%      -0.3        0.87 ±  4%  perf-profile.children.cycles-pp.getname_flags
      0.87 ±  5%      -0.3        0.54 ±  4%      -0.3        0.55 ±  8%  perf-profile.children.cycles-pp.__traverse_mounts
      0.40 ± 43%      -0.3        0.10 ± 14%      -0.3        0.10 ± 11%  perf-profile.children.cycles-pp.ret_from_fork
      0.40 ± 43%      -0.3        0.10 ± 13%      -0.3        0.10 ± 11%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.40 ± 44%      -0.3        0.10 ± 11%      -0.3        0.10 ± 11%  perf-profile.children.cycles-pp.kthread
      1.08 ±  8%      -0.3        0.78 ±  3%      -0.3        0.78 ±  9%  perf-profile.children.cycles-pp.up_read
      0.97 ±  5%      -0.3        0.70 ±  5%      -0.3        0.71 ±  6%  perf-profile.children.cycles-pp.ext4_statfs
      1.05 ±  6%      -0.3        0.78 ±  3%      -0.3        0.77 ±  3%  perf-profile.children.cycles-pp.fstatfs64
      0.77 ±  8%      -0.2        0.55 ±  6%      -0.2        0.56 ±  5%  perf-profile.children.cycles-pp.strncpy_from_user
      0.83 ±  4%      -0.2        0.64 ±  4%      -0.2        0.62 ±  5%  perf-profile.children.cycles-pp.path_put
      0.56 ± 18%      -0.2        0.38 ±  6%      -0.2        0.40 ± 12%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      0.63 ±  5%      -0.2        0.45            -0.2        0.44 ±  8%  perf-profile.children.cycles-pp._find_next_or_bit
      0.74 ±  8%      -0.2        0.56 ±  4%      -0.2        0.57 ±  3%  perf-profile.children.cycles-pp.__do_sys_fstatfs
      0.59 ±  7%      -0.2        0.42 ±  9%      -0.2        0.40 ± 10%  perf-profile.children.cycles-pp.__d_lookup
      0.65 ±  7%      -0.2        0.49 ±  5%      -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.fd_statfs
      0.52 ±  5%      -0.2        0.36 ±  8%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.dcache_dir_open
      0.52 ±  5%      -0.2        0.36 ±  8%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.d_alloc_cursor
      0.52 ± 11%      -0.2        0.37 ± 10%      -0.2        0.35 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.60 ±  4%      -0.1        0.46 ±  8%      -0.2        0.45 ±  6%  perf-profile.children.cycles-pp.alloc_empty_file
      0.45 ±  7%      -0.1        0.32 ±  6%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.42 ± 11%      -0.1        0.29 ±  7%      -0.2        0.25 ±  7%  perf-profile.children.cycles-pp.path_init
      0.44 ±  5%      -0.1        0.32 ±  8%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.security_file_alloc
      0.39 ±  8%      -0.1        0.28 ±  6%      -0.1        0.27 ± 10%  perf-profile.children.cycles-pp.__check_object_size
      0.46 ±  5%      -0.1        0.35 ±  8%      -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.init_file
      0.45 ±  6%      -0.1        0.34 ±  7%      -0.1        0.32 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.32 ±  6%      -0.1        0.21 ±  5%      -0.1        0.20 ±  9%  perf-profile.children.cycles-pp.super_lock
      0.39 ±  7%      -0.1        0.28 ±  8%      -0.1        0.30 ±  9%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.34 ± 11%      -0.1        0.23 ±  8%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.nd_jump_root
      0.23 ± 11%      -0.1        0.13 ± 13%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.23 ± 12%      -0.1        0.14 ± 13%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.security_file_free
      0.28 ± 11%      -0.1        0.20 ±  6%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.open_last_lookups
      0.26 ±  8%      -0.1        0.18 ±  6%      -0.1        0.20 ±  8%  perf-profile.children.cycles-pp._copy_to_user
      0.25 ±  5%      -0.1        0.18 ±  5%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.ioctl
      0.18 ±  7%      -0.1        0.11 ± 10%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.generic_permission
      0.19 ± 12%      -0.1        0.13 ± 11%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.set_root
      0.18 ±  9%      -0.1        0.12 ± 10%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.generic_fillattr
      0.19 ±  8%      -0.1        0.14 ±  7%      -0.1        0.13 ± 12%  perf-profile.children.cycles-pp.check_heap_object
      0.18 ±  7%      -0.1        0.12 ± 11%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.simple_statfs
      0.17 ± 12%      -0.1        0.12 ± 10%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.30 ± 10%      -0.1        0.24 ±  7%      -0.1        0.21 ± 11%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.17 ±  3%      -0.1        0.12 ±  4%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.15 ±  8%      -0.1        0.10 ± 16%      -0.1        0.09 ± 28%  perf-profile.children.cycles-pp.vfs_statfs
      0.12 ±  4%      -0.1        0.06 ± 14%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.may_open
      0.13 ± 12%      -0.1        0.08 ± 13%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.security_file_open
      0.13 ± 13%      -0.1        0.08 ± 14%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.apparmor_file_open
      0.14 ±  5%      -0.0        0.09 ± 10%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.common_perm_cond
      0.19 ± 12%      -0.0        0.14 ±  3%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.do_statfs_native
      0.15 ±  6%      -0.0        0.10 ±  5%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.security_inode_getattr
      0.21 ±  6%      -0.0        0.17 ±  8%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.__cond_resched
      0.12 ± 27%      -0.0        0.08 ± 14%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.autofs_d_manage
      0.14 ± 11%      -0.0        0.10 ± 18%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.filp_flush
      0.08 ± 17%      -0.0        0.05 ± 48%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.07 ± 12%      -0.0        0.04 ± 45%      -0.1        0.02 ±142%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.10 ± 17%      -0.0        0.07 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__x64_sys_ioctl
      0.11 ±  9%      -0.0        0.08 ±  8%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__check_heap_object
      0.10 ±  7%      -0.0        0.07 ±  9%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.stress_sysinfo
      0.09 ± 14%      -0.0        0.07 ±  8%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.10 ± 13%      +0.1        0.15 ± 10%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.___d_drop
      0.01 ±200%      +0.1        0.08 ± 12%      +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.__wake_up
      0.03 ± 82%      +0.1        0.12 ±  3%      +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.__d_lookup_unhash
      0.07 ± 10%      +0.1        0.18 ±  8%      +0.1        0.22 ± 13%  perf-profile.children.cycles-pp.__d_rehash
      1.08 ±  3%      +0.2        1.23 ±  7%      +0.3        1.33 ±  8%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.11 ± 13%      +0.2        0.30 ±  5%      +0.2        0.29 ±  6%  perf-profile.children.cycles-pp.__call_rcu_common
      0.00            +0.2        0.21 ±  7%      +0.2        0.21 ± 10%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.21 ± 11%      +0.3        0.48 ±  3%      +0.3        0.52 ±  8%  perf-profile.children.cycles-pp.__d_add
      0.22 ±  9%      +0.3        0.49 ±  4%      +0.3        0.54 ±  8%  perf-profile.children.cycles-pp.simple_lookup
     33.96            +0.8       34.74            +0.6       34.52        perf-profile.children.cycles-pp.walk_component
      8.16            +2.4       10.57            +2.5       10.64        perf-profile.children.cycles-pp.step_into
      7.00            +2.6        9.64            +2.6        9.59        perf-profile.children.cycles-pp.d_alloc
     22.54            +3.1       25.68            +3.0       25.50        perf-profile.children.cycles-pp.lockref_get_not_dead
     22.81            +3.7       26.49            +3.7       26.46        perf-profile.children.cycles-pp.__legitimize_path
     21.77            +4.0       25.80            +4.0       25.74        perf-profile.children.cycles-pp.try_to_unlazy
     21.12            +4.4       25.50            +4.3       25.42        perf-profile.children.cycles-pp.terminate_walk
     15.42            +4.9       20.34            +4.9       20.32        perf-profile.children.cycles-pp.lookup_fast
     70.33            +5.7       76.06            +5.4       75.76        perf-profile.children.cycles-pp.filename_lookup
     63.07            +5.7       68.81            +5.4       68.51        perf-profile.children.cycles-pp._raw_spin_lock
     70.14            +5.8       75.93            +5.5       75.63        perf-profile.children.cycles-pp.path_lookupat
     58.67            +6.1       64.81            +5.8       64.51        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     69.05            +6.4       75.42            +6.0       75.08        perf-profile.children.cycles-pp.__statfs
     68.46            +6.5       74.98            +6.2       74.65        perf-profile.children.cycles-pp.__do_sys_statfs
     68.23            +6.6       74.81            +6.2       74.47        perf-profile.children.cycles-pp.user_statfs
     65.85            +7.3       73.10            +6.9       72.77        perf-profile.children.cycles-pp.user_path_at_empty
      0.79 ±  5%      +9.6       10.40            +9.6       10.43        perf-profile.children.cycles-pp.__dentry_kill
      2.73 ±  2%      -1.1        1.68            -1.1        1.65 ±  4%  perf-profile.self.cycles-pp.lockref_get_not_dead
      2.60            -0.6        1.98 ±  2%      -0.7        1.94 ±  5%  perf-profile.self.cycles-pp.lockref_put_return
      1.56 ±  3%      -0.5        1.02 ±  5%      -0.5        1.10 ±  8%  perf-profile.self.cycles-pp.__d_lookup_rcu
      4.40 ±  2%      -0.4        3.98 ±  3%      -0.4        4.00 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      2.42 ±  6%      -0.4        2.04 ±  3%      -0.4        2.07        perf-profile.self.cycles-pp.down_read
      0.50 ±  2%      -0.4        0.14 ± 16%      -0.4        0.12 ± 14%  perf-profile.self.cycles-pp._raw_spin_trylock
      1.30 ±  7%      -0.4        0.94 ±  8%      -0.3        0.97 ±  8%  perf-profile.self.cycles-pp.__percpu_counter_sum
      1.07 ±  7%      -0.3        0.77 ±  3%      -0.3        0.77 ±  8%  perf-profile.self.cycles-pp.up_read
      0.75 ±  2%      -0.3        0.47 ±  6%      -0.2        0.52 ±  9%  perf-profile.self.cycles-pp.lockref_get
      0.85 ±  6%      -0.2        0.60 ±  8%      -0.3        0.58 ±  6%  perf-profile.self.cycles-pp.inode_permission
      0.56 ±  6%      -0.2        0.40 ±  6%      -0.1        0.42 ±  2%  perf-profile.self.cycles-pp.user_get_super
      0.40 ± 12%      -0.1        0.26 ±  9%      -0.2        0.24 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      0.49 ±  4%      -0.1        0.35 ±  3%      -0.1        0.34 ± 10%  perf-profile.self.cycles-pp._find_next_or_bit
      0.37 ±  6%      -0.1        0.26 ±  6%      -0.1        0.26 ±  5%  perf-profile.self.cycles-pp.do_dentry_open
      0.39 ±  6%      -0.1        0.28 ±  8%      -0.1        0.30 ±  8%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.38 ±  8%      -0.1        0.27 ±  7%      -0.1        0.29 ±  6%  perf-profile.self.cycles-pp.strncpy_from_user
      0.23 ± 11%      -0.1        0.13 ± 13%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.26 ± 11%      -0.1        0.17 ± 10%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.link_path_walk
      0.25 ±  8%      -0.1        0.18 ±  9%      -0.1        0.18 ±  7%  perf-profile.self.cycles-pp._copy_to_user
      0.25 ±  6%      -0.1        0.19 ±  5%      -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.shmem_statfs
      0.37 ±  5%      -0.1        0.31 ±  8%      -0.0        0.32 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.26 ±  6%      -0.1        0.20 ± 10%      -0.1        0.19 ±  9%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.14 ±  8%      -0.1        0.08 ± 16%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.generic_permission
      0.18 ±  7%      -0.1        0.12 ± 11%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.simple_statfs
      0.17 ± 11%      -0.1        0.11 ± 12%      -0.1        0.11 ± 12%  perf-profile.self.cycles-pp.generic_fillattr
      0.15 ± 10%      -0.1        0.09 ±  9%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.lookup_fast
      0.18 ±  6%      -0.1        0.13 ± 12%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.filename_lookup
      0.15 ±  9%      -0.1        0.10 ± 16%      -0.1        0.09 ± 27%  perf-profile.self.cycles-pp.vfs_statfs
      0.19 ±  5%      -0.1        0.14 ± 12%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.statfs_by_dentry
      0.28 ± 10%      -0.0        0.24 ±  8%      -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.13 ±  8%      -0.0        0.08 ±  8%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.common_perm_cond
      0.13 ± 12%      -0.0        0.08 ± 14%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.apparmor_file_open
      0.17 ± 11%      -0.0        0.13 ±  9%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__statfs
      0.18 ±  8%      -0.0        0.14 ± 11%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.step_into
      0.12 ±  9%      -0.0        0.08 ± 11%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.11 ±  4%      -0.0        0.08 ±  8%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.getname_flags
      0.08 ±  9%      -0.0        0.05 ± 45%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.check_heap_object
      0.10 ±  7%      -0.0        0.07 ±  7%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.10 ±  9%      -0.0        0.07 ± 10%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.__do_sys_statfs
      0.08 ±  7%      -0.0        0.05 ± 47%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.13 ±  5%      -0.0        0.10 ± 10%      -0.0        0.09 ± 11%  perf-profile.self.cycles-pp.__cond_resched
      0.07 ±  6%      -0.0        0.05 ± 45%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.__check_object_size
      0.09 ± 11%      -0.0        0.06 ± 13%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.stress_sysinfo
      0.10 ±  7%      -0.0        0.08 ± 12%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.__check_heap_object
      0.10 ±  7%      -0.0        0.08 ± 10%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.do_syscall_64
      0.09 ± 17%      -0.0        0.07 ± 20%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.set_root
      0.09 ± 15%      -0.0        0.07 ± 11%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.08 ± 10%      -0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.fstatfs64
      0.06 ± 14%      +0.0        0.10 ± 10%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.dput
      0.10 ± 13%      +0.1        0.15 ± 10%      +0.1        0.15 ± 10%  perf-profile.self.cycles-pp.___d_drop
      0.01 ±200%      +0.1        0.08 ±  6%      +0.1        0.08 ± 18%  perf-profile.self.cycles-pp.__d_add
      0.03 ± 82%      +0.1        0.12 ±  6%      +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.__d_lookup_unhash
      0.07 ± 10%      +0.1        0.18 ±  7%      +0.1        0.21 ± 15%  perf-profile.self.cycles-pp.__d_rehash
      1.06 ±  3%      +0.2        1.21 ±  7%      +0.3        1.31 ±  8%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.00            +0.2        0.21 ±  8%      +0.2        0.21 ± 10%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.09 ± 18%      +0.3        0.39 ±  5%      +0.3        0.39 ±  5%  perf-profile.self.cycles-pp.__dentry_kill
      0.57 ±  7%      +0.8        1.42 ±  3%      +0.7        1.23 ±  4%  perf-profile.self.cycles-pp.d_alloc_parallel
     58.29            +5.9       64.24            +5.7       63.96        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


[2]

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp9/shell1/unixbench

commit:
  e3640d37d0 ("d_prune_aliases(): use a shrink list")
  1b738f196e ("__dentry_kill(): new locking scheme")
  fec356fd0c ("fix for 1b738f196e from Al Viro")


e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 fec356fd0c7d05c7dbcbaf593c3
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
 1.364e+08 ±  6%     +16.1%  1.584e+08           +15.5%  1.575e+08        cpuidle..usage
    441644 ± 15%     +24.0%     547554           +23.6%     546067        vmstat.system.cs
    261268 ± 11%     +20.2%     313947           +19.9%     313253        vmstat.system.in
  4.91e+08           -15.4%  4.154e+08           -15.3%   4.16e+08        numa-numastat.node0.local_node
  4.91e+08           -15.4%  4.155e+08           -15.3%   4.16e+08        numa-numastat.node0.numa_hit
 4.872e+08           -15.1%  4.139e+08           -15.3%  4.127e+08        numa-numastat.node1.local_node
 4.872e+08           -15.1%  4.139e+08           -15.3%  4.127e+08        numa-numastat.node1.numa_hit
  4.91e+08           -15.4%  4.155e+08           -15.3%   4.16e+08        numa-vmstat.node0.numa_hit
  4.91e+08           -15.4%  4.154e+08           -15.3%   4.16e+08        numa-vmstat.node0.numa_local
 4.872e+08           -15.1%  4.139e+08           -15.3%  4.127e+08        numa-vmstat.node1.numa_hit
 4.872e+08           -15.1%  4.139e+08           -15.3%  4.127e+08        numa-vmstat.node1.numa_local
     94.24 ± 19%     +39.3%     131.32 ±  8%     +21.8%     114.80 ± 12%  sched_debug.cfs_rq:/.runnable_avg.min
     80.86 ± 20%     +44.9%     117.18 ±  9%     +25.8%     101.70 ± 15%  sched_debug.cfs_rq:/.util_avg.min
    366562 ± 25%     -25.6%     272726 ±  4%     -14.9%     312032 ± 15%  sched_debug.cpu.avg_idle.max
     58176 ±  7%     -14.1%      49984 ±  3%      -9.2%      52808 ±  7%  sched_debug.cpu.avg_idle.stddev
   9790886           -11.9%    8621542           -12.1%    8605511        time.involuntary_context_switches
   1005638           -32.8%     675724 ±  3%     -31.5%     689261        time.major_page_faults
 1.424e+09           -15.5%  1.203e+09           -15.6%  1.202e+09        time.minor_page_faults
      5634           -16.3%       4714           -16.3%       4717        time.user_time
 1.423e+08           +19.9%  1.706e+08           +19.5%    1.7e+08        time.voluntary_context_switches
 1.361e+08 ±  6%     +16.1%   1.58e+08           +15.5%  1.572e+08        turbostat.C1
      0.20 ±  5%      -9.8%       0.18 ±  8%     -12.2%       0.18        turbostat.IPC
      0.86 ± 42%      -0.9        0.00            -0.9        0.00        turbostat.PKG_%
    302367           +10.4%     333804           +12.5%     340026        turbostat.POLL
      0.03 ± 13%      +0.0        0.04 ±  9%      +0.0        0.04        turbostat.POLL%
     35237           -15.4%      29823           -15.4%      29798        unixbench.score
   9790886           -11.9%    8621542           -12.1%    8605511        unixbench.time.involuntary_context_switches
   1005638           -32.8%     675724 ±  3%     -31.5%     689261        unixbench.time.major_page_faults
 1.424e+09           -15.5%  1.203e+09           -15.6%  1.202e+09        unixbench.time.minor_page_faults
      5634           -16.3%       4714           -16.3%       4717        unixbench.time.user_time
 1.423e+08           +19.9%  1.706e+08           +19.5%    1.7e+08        unixbench.time.voluntary_context_switches
  94125276           -15.3%   79705880           -15.4%   79659908        unixbench.workload
 9.783e+08           -15.2%  8.293e+08           -15.3%  8.287e+08        proc-vmstat.numa_hit
 9.782e+08           -15.2%  8.293e+08           -15.3%  8.286e+08        proc-vmstat.numa_local
   1370380            -6.6%    1280337            -6.7%    1278475        proc-vmstat.pgactivate
 1.034e+09           -15.2%  8.762e+08           -15.3%  8.756e+08        proc-vmstat.pgalloc_normal
 1.429e+09           -15.5%  1.207e+09           -15.6%  1.206e+09        proc-vmstat.pgfault
 1.033e+09           -15.2%  8.755e+08           -15.3%  8.748e+08        proc-vmstat.pgfree
  56430676           -15.3%   47783381           -15.4%   47750943        proc-vmstat.pgreuse
     49542           -15.6%      41803           -15.7%      41769        proc-vmstat.thp_fault_alloc
  20816069           -15.3%   17633995           -15.4%   17618805        proc-vmstat.unevictable_pgs_culled
      2.74 ± 13%     +11.7%       3.06           +11.7%       3.06        perf-stat.i.MPKI
      1.74 ±  8%      +0.1        1.84            +0.1        1.84        perf-stat.i.branch-miss-rate%
    443434 ± 15%     +24.1%     550391           +23.7%     548526        perf-stat.i.context-switches
    118140 ± 15%      +9.9%     129799            +9.3%     129095        perf-stat.i.cpu-migrations
      2.99            +5.5%       3.15            +5.4%       3.15        perf-stat.overall.MPKI
      1.83            +0.0        1.87            +0.0        1.87        perf-stat.overall.branch-miss-rate%
      1.69           +11.3%       1.88           +11.4%       1.88        perf-stat.overall.cpi
    566.13            +5.5%     597.00            +5.7%     598.56        perf-stat.overall.cycles-between-cache-misses
      0.12            -0.0        0.12 ±  2%      -0.0        0.12        perf-stat.overall.dTLB-store-miss-rate%
      0.59           -10.1%       0.53           -10.3%       0.53        perf-stat.overall.ipc
     37.30            +1.8       39.06            +1.6       38.92        perf-stat.overall.node-store-miss-rate%
    576160            +2.9%     592690            +2.7%     591830        perf-stat.overall.path-length
    443139 ± 15%     +24.0%     549513           +23.6%     547703        perf-stat.ps.context-switches
    118077 ± 15%      +9.8%     129616            +9.2%     128929        perf-stat.ps.cpu-migrations
 5.423e+13           -12.9%  4.724e+13           -13.1%  4.714e+13        perf-stat.total.instructions
      0.02 ± 35%     -42.5%       0.01 ± 42%     -47.8%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      0.02 ± 15%     -35.8%       0.01 ±  9%     -38.7%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.02 ± 73%     -57.4%       0.01 ± 40%     -64.3%       0.01 ± 30%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.04 ± 76%     -73.1%       0.01 ± 69%     -37.9%       0.03 ± 55%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.07 ±132%     -76.4%       0.02 ± 19%     -62.3%       0.03 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.04 ± 59%     -64.2%       0.01 ± 76%     -69.8%       0.01 ± 35%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      0.03 ±  8%     -33.5%       0.02 ± 17%     -43.3%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.01 ± 27%     -61.1%       0.00 ± 72%     -36.1%       0.00 ± 77%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.dcache_dir_close.__fput.__x64_sys_close
      0.02 ± 15%     -26.2%       0.01 ± 18%     -30.1%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.04 ± 30%     -58.6%       0.02 ± 29%     -54.1%       0.02 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.02 ± 27%     -57.0%       0.01 ± 30%     -31.0%       0.01 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.02 ±150%     -78.4%       0.00 ± 12%     -75.5%       0.00 ± 29%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_expand
      0.02 ± 20%     -64.3%       0.01 ± 26%     -36.6%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      0.03 ± 19%     -36.5%       0.02 ± 30%     -26.9%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.02 ± 87%     -40.3%       0.01 ± 85%     -62.1%       0.01 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
      0.01 ± 24%     -14.6%       0.01 ± 55%     -48.8%       0.00 ± 54%  perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      0.04 ± 43%     -61.1%       0.01 ± 65%     -62.1%       0.01 ± 64%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.01           -12.5%       0.01           -10.4%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.02 ± 18%     -25.9%       0.02 ± 32%     -39.9%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.02 ± 12%     -28.7%       0.02 ± 18%     -42.6%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.03 ±  3%     -14.6%       0.03 ±  9%     -10.4%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ±  7%     -36.2%       0.01 ± 13%     -35.2%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.02 ±  4%     -44.1%       0.01 ±  5%     -36.4%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ± 12%     -24.5%       0.01 ±  8%     -34.0%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.02 ±  5%     -35.4%       0.01 ±  4%     -38.4%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.02 ±  3%     -32.3%       0.01 ±  4%     -32.3%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  3%     -44.1%       0.01 ±  3%     -44.1%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.02 ±  2%     -18.6%       0.01 ±  2%     -18.6%       0.01 ±  2%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.01 ±  4%     -30.0%       0.01 ±  4%     -30.0%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.01 ±  4%     -28.6%       0.01 ±  5%     -25.7%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ±  8%     -28.2%       0.02 ± 11%     -24.2%       0.02 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ±  8%     -36.4%       0.01 ±  6%     -36.4%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03           -10.6%       0.02 ±  4%     -11.8%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 71%     -55.3%       0.02 ± 92%     -78.0%       0.01 ± 90%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.__handle_mm_fault
      0.92 ± 34%     -49.5%       0.47 ±100%     -58.2%       0.39 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      0.79 ± 42%     -66.7%       0.26 ± 70%      +2.3%       0.81 ± 63%  perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.15 ±122%     -95.1%       0.01 ± 18%     -96.0%       0.01 ± 23%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.31 ± 18%     -41.7%       0.76 ± 35%     -39.6%       0.79 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.02 ± 82%     -79.6%       0.00 ± 76%     -78.5%       0.00 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_link.insert_vm_struct.__install_special_mapping
      0.18 ±216%     -97.2%       0.01 ± 30%     -98.2%       0.00 ± 61%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.alloc_bprm.do_execveat_common.isra
      0.08 ±126%     -91.5%       0.01 ± 22%     -94.2%       0.00 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 31%     -64.3%       0.00 ± 75%     -42.9%       0.00 ± 76%  perf-sched.sch_delay.max.ms.__cond_resched.dput.dcache_dir_close.__fput.__x64_sys_close
      0.96 ± 32%     -65.2%       0.33 ± 22%     -51.3%       0.47 ± 26%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.13 ±121%     -74.0%       0.03 ±165%     -91.0%       0.01 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_cow_fault.do_fault
      1.06 ± 42%     -53.8%       0.49 ± 47%     -68.5%       0.33 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.48 ± 68%     -76.7%       0.11 ± 90%     -54.2%       0.22 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.49 ± 43%     -59.3%       0.20 ± 69%     -40.0%       0.30 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      0.76 ± 29%     -69.9%       0.23 ± 65%     -15.5%       0.64 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      0.35 ± 90%     -37.0%       0.22 ±127%     -80.2%       0.07 ±105%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
      0.36 ± 56%     -53.8%       0.17 ± 77%     -73.6%       0.10 ± 73%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      0.25 ±154%     -93.0%       0.02 ± 74%     -40.8%       0.15 ±107%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.41 ± 15%     +31.6%       9.75 ± 11%     +21.6%       9.01 ± 11%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      1.55 ±  8%     -29.7%       1.09 ±  9%     -26.3%       1.14 ± 29%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      2.91 ± 81%     -60.7%       1.14 ± 13%     -27.8%       2.10 ±110%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      1.51 ±  7%     -17.8%       1.24 ± 13%     -22.7%       1.17 ± 22%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
     23.59 ±  6%      +9.9%      25.94 ± 14%     +12.1%      26.45 ±  4%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.89 ±  8%      +5.6%       2.00 ± 14%     +31.2%       2.48 ± 21%  perf-sched.sch_delay.max.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02           -19.3%       0.02 ±  3%     -20.2%       0.02 ±  2%  perf-sched.total_sch_delay.average.ms
      1.52           -10.0%       1.37           -10.1%       1.37        perf-sched.total_wait_and_delay.average.ms
   1435243           +13.3%    1626751           +13.5%    1629491        perf-sched.total_wait_and_delay.count.ms
      1.50            -9.8%       1.35           -10.0%       1.35        perf-sched.total_wait_time.average.ms
     22.26 ± 26%     -41.9%      12.94 ± 38%     -38.2%      13.76 ± 47%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      1.37 ± 73%     +93.0%       2.65 ± 15%    +143.6%       3.35 ± 44%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1.54 ±116%    +198.3%       4.61 ± 64%    +207.3%       4.75 ± 29%  perf-sched.wait_and_delay.avg.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      2.61 ± 75%    +137.8%       6.21 ± 45%    +101.5%       5.26 ± 39%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      5.01 ± 30%     +60.3%       8.03 ± 39%     +60.0%       8.02 ± 27%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      3.22 ± 67%     +95.1%       6.29 ± 40%      +5.0%       3.38 ± 55%  perf-sched.wait_and_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      3.54           +18.6%       4.20           +18.4%       4.19        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      6.54           +13.3%       7.41           +13.2%       7.40        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.90           +22.2%       2.32           +26.2%       2.40        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     24.82 ±  3%      -9.8%      22.38 ±  3%      -9.5%      22.45 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.26           -16.6%       0.22           -16.7%       0.22        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.24           -11.4%       0.21           -11.4%       0.21        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.24           -16.3%       0.20           -16.5%       0.20        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.16           -17.9%       0.13           -17.6%       0.13        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.31 ± 10%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.12 ±  5%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.24 ±  4%     -12.8%       0.21 ±  5%     -12.1%       0.21 ±  3%  perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.03           +11.1%       7.81           +10.6%       7.78        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     11.50 ± 14%     -59.4%       4.67 ± 81%     -39.1%       7.00 ± 54%  perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
    103.17 ± 11%     -31.0%      71.17 ± 13%     -29.9%      72.33 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    136.83 ±  7%     -27.3%      99.50 ± 13%     -23.5%     104.67 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
    676.67 ±  4%     -35.9%     433.83 ±  6%     -31.3%     465.00 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
     36.83 ± 11%     -42.1%      21.33 ± 51%     -20.8%      29.17 ± 17%  perf-sched.wait_and_delay.count.__cond_resched.dput.__fput.task_work_run.do_exit
      4131           -20.5%       3284           -20.6%       3281        perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     43604           -13.4%      37756           -13.0%      37942        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     15.83 ± 22%     +45.3%      23.00 ± 34%     +61.1%      25.50 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
    468.00 ±  3%     -23.6%     357.50 ±  5%     -21.4%     368.00 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      1.50 ±126%    +211.1%       4.67 ± 58%    +288.9%       5.83 ± 34%  perf-sched.wait_and_delay.count.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    838.83 ±  4%     -14.9%     714.00 ±  4%     -13.5%     725.33 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     94940           -10.3%      85118           -10.2%      85273        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     75003           -10.4%      67207           -10.2%      67318        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     40580           -22.7%      31376           -24.2%      30777        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     74192            +9.9%      81531           +11.1%      82410        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
    832443           +30.9%    1089632           +31.1%    1091462        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
     11573 ±  4%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
     13294 ±  6%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
     21167           -10.4%      18974           -10.2%      19016        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     10543           -10.4%       9447           -10.2%       9471        perf-sched.wait_and_delay.count.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.12 ±  3%    +919.7%     358.10 ±126%    +919.6%     358.05 ±126%  perf-sched.wait_and_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
     34.12 ±  6%    +481.1%     198.26 ±180%     +12.1%      38.23 ±  2%  perf-sched.wait_and_delay.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
     32.50 ±  5%      +6.3%      34.54 ± 11%     +14.4%      37.17        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
     33.13 ±  5%      +9.5%      36.27 ±  3%     +10.2%      36.50 ±  8%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
     13.58 ± 87%    +107.6%      28.20 ± 45%    +122.1%      30.17 ± 29%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
     26.37 ± 36%     +17.1%      30.87 ± 34%     +34.7%      35.50 ±  7%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
     27.24 ± 35%     +26.6%      34.48 ±  8%     +36.5%      37.19 ±  3%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
     32.13 ±  7%    +511.2%     196.40 ±183%     +14.3%      36.73 ±  5%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
     31.01 ± 16%     -51.4%      15.06 ± 56%      -6.9%      28.87 ± 34%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
     34.54 ±  3%      +8.3%      37.41 ±  3%      +6.3%      36.71 ±  2%  perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     12.72 ±  8%     +21.7%      15.48 ±  9%     +31.2%      16.68 ± 16%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      6.20 ± 12%     -26.5%       4.56 ± 15%      -8.4%       5.67 ± 23%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     35.18 ±  6%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      3.84 ± 13%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
     22.26 ± 26%     -41.9%      12.94 ± 38%     -38.2%      13.76 ± 47%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.19 ±  3%     -18.3%       0.16 ±  3%     -19.3%       0.15 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.23 ±  6%     -15.0%       0.19 ±  8%     -14.3%       0.20 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.change_pmd_range.isra.0.change_protection_range
      0.22 ±  4%     -17.4%       0.18 ±  3%     -14.9%       0.18 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.21           -13.8%       0.18           -13.5%       0.18        perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.19 ± 46%     -41.2%       0.11 ± 68%     -54.6%       0.09 ± 62%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__anon_vma_prepare.do_cow_fault.do_fault
      0.18 ± 13%     -15.3%       0.15 ± 15%     -14.2%       0.15 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.20 ±  7%     -17.3%       0.16 ±  5%     -19.0%       0.16 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      0.22 ±  5%      -8.2%       0.20 ±  7%     -12.3%       0.19 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.18 ± 31%     -23.3%       0.14 ± 23%     -44.6%       0.10 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.22 ±  7%     -14.9%       0.19 ±  8%      -8.6%       0.20 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      1.80 ± 21%     +47.0%       2.64 ± 15%     +85.7%       3.34 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.21 ±  2%     -12.6%       0.18           -11.5%       0.19 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.20 ±  4%     -13.9%       0.17 ±  7%      -7.4%       0.19 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.lookup_open.isra
      0.27 ±  5%     -25.8%       0.20 ±  3%     -27.9%       0.19 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.22           -13.7%       0.19           -12.8%       0.19        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.21 ±  4%      -9.2%       0.19 ±  2%      -9.5%       0.19 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.24 ± 11%     -12.6%       0.21 ±  9%     -17.3%       0.20 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      0.21 ±  2%     -12.2%       0.18           -11.4%       0.18        perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      1.68 ±100%    +175.3%       4.63 ± 63%    +181.8%       4.74 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.69 ± 16%    +107.8%       1.43 ± 42%     +90.3%       1.31 ± 50%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.21 ±  7%     -15.3%       0.18 ±  4%     -14.2%       0.18 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      2.81 ± 62%    +120.7%       6.20 ± 45%     +87.0%       5.25 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      5.00 ± 30%     +60.4%       8.02 ± 39%     +60.1%       8.00 ± 27%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      0.16 ±  4%     -13.6%       0.14 ± 10%     -21.0%       0.12 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.26 ± 11%     -17.3%       0.22 ±  9%     -10.9%       0.24 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      0.05 ± 28%     -62.0%       0.02 ± 39%     -57.7%       0.02 ± 24%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping.map_vdso
      0.19 ±  9%     -16.7%       0.16 ±  2%     -16.0%       0.16 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      0.23           -14.6%       0.19 ±  2%     -12.7%       0.20 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.24 ± 16%     -17.1%       0.20 ±  6%     -24.5%       0.18 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
      0.24 ± 15%     -34.4%       0.16 ± 17%     -45.7%       0.13 ± 53%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      0.22 ±  2%     -13.6%       0.19 ±  6%      -9.6%       0.20 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.01 ± 80%    +816.0%       0.08 ± 46%    +598.0%       0.06 ±121%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
      3.33 ± 59%     +88.0%       6.27 ± 41%      +5.3%       3.51 ± 46%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      0.25 ±  6%     -27.0%       0.18 ±  4%     -22.4%       0.19 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.20 ±  3%     -18.9%       0.17 ±  3%     -18.7%       0.17 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.23 ±  7%     -13.1%       0.20 ±  3%     -15.9%       0.20 ±  3%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      3.51           +18.7%       4.17           +18.6%       4.16        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      6.50           +13.4%       7.38           +13.3%       7.37        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.14           -21.4%       0.11 ±  2%     -17.8%       0.12 ±  2%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      1.88           +22.6%       2.31           +26.6%       2.39        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     24.82 ±  3%      -9.8%      22.38 ±  3%      -9.5%      22.45 ±  3%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.24           -13.8%       0.21           -14.1%       0.21        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.23           -10.9%       0.20           -10.9%       0.20        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.22           -15.5%       0.19           -15.9%       0.19        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.12 ± 12%     -24.4%       0.09 ±  4%     -19.8%       0.10 ± 11%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      0.15           -16.9%       0.12           -16.9%       0.12        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.30 ± 10%     +14.8%       0.35 ± 12%     +12.9%       0.34 ± 12%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.12 ±  5%     -22.5%       0.09 ±  5%     -28.0%       0.08 ±  6%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.22 ±  5%     -10.8%       0.20 ±  5%     -10.1%       0.20 ±  3%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.01           +11.1%       7.79           +10.7%       7.76        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.50 ± 37%     -26.4%       0.37 ± 21%     -40.8%       0.29 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
      4.42 ± 66%     +96.1%       8.66 ± 19%     +62.7%       7.19 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_anonymous_page
      1.75 ± 11%     -29.0%       1.24 ± 19%     -19.2%       1.41 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      9.82 ±  9%     +22.6%      12.05 ± 10%     +22.7%      12.06 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
     35.11 ±  3%    +919.9%     358.10 ±126%    +919.8%     358.04 ±126%  perf-sched.wait_time.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
     34.11 ±  6%    +481.0%     198.16 ±180%     +12.0%      38.19 ±  2%  perf-sched.wait_time.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      1.06 ± 23%     -42.4%       0.61 ± 30%     -49.8%       0.53 ± 37%  perf-sched.wait_time.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      1.05 ± 51%     -69.6%       0.32 ± 42%     -74.1%       0.27 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.vma_modify.mprotect_fixup
     32.50 ±  5%      +6.3%      34.53 ± 11%     +14.4%      37.17        perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
     33.06 ±  6%      +9.6%      36.23 ±  3%     +10.4%      36.50 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      1.40 ± 21%      -8.8%       1.28 ± 49%     -42.1%       0.81 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.40 ± 44%     -39.6%       0.24 ± 14%     -49.8%       0.20 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.97 ±129%     -65.9%       0.33 ± 12%     -58.8%       0.40 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      1.24 ± 11%     -24.6%       0.93 ± 16%     -17.4%       1.02 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      7.94 ± 17%     +27.2%      10.09 ± 12%      +7.5%       8.53 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.46 ± 30%     -33.6%       0.31 ± 19%     -36.8%       0.29 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_cow_fault.do_fault
      1.43 ± 24%     -48.0%       0.75 ± 25%     -53.0%       0.67 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
     14.60 ± 74%     +93.0%      28.19 ± 45%    +106.6%      30.16 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
     26.36 ± 36%     +17.1%      30.86 ± 35%     +34.7%      35.50 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
     27.23 ± 35%     +26.6%      34.47 ±  8%     +36.5%      37.18 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
     32.12 ±  7%    +511.5%     196.39 ±183%     +14.4%      36.72 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      0.61 ± 31%     -58.6%       0.25 ± 43%     -59.1%       0.25 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping.map_vdso
      1.41 ± 43%     -53.1%       0.66 ± 18%     -34.0%       0.93 ± 39%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      1.02 ± 78%     -43.6%       0.58 ± 38%     -64.6%       0.36 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
     30.99 ± 16%     -51.4%      15.05 ± 56%      -6.9%      28.86 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.03 ±105%   +1059.1%       0.35 ± 39%    +719.9%       0.25 ±140%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
     34.44 ±  3%      +8.6%      37.40 ±  3%      +6.4%      36.65 ±  2%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     28.01 ± 29%     +34.5%      37.66 ±  9%      +6.8%      29.90 ± 32%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.35 ± 50%     -70.6%       0.10 ±103%     -45.0%       0.19 ± 43%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      6.75 ± 10%     +20.3%       8.13 ±  7%     +30.8%       8.83 ± 12%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      3.65 ± 12%     -29.2%       2.58 ± 15%      -2.4%       3.56 ± 22%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      4.19 ± 10%     -33.7%       2.78 ± 28%     -35.7%       2.69 ± 34%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      3.83 ± 13%     -34.5%       2.51 ± 21%     -37.5%       2.40 ±  9%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
     14.35            -6.2        8.12 ±  7%      -6.6        7.75 ±  4%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.09            -6.2        7.90 ±  7%      -6.6        7.52 ±  4%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     12.77 ±  2%      -6.0        6.80 ±  8%      -6.3        6.44 ±  5%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.75            -6.0        6.78 ±  8%      -6.3        6.42 ±  5%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.18            -4.8        4.41 ± 13%      -5.1        4.09 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      6.70 ±  2%      -4.3        2.40 ± 20%      -4.6        2.14 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
      6.06 ±  3%      -4.1        2.00 ± 14%      -4.2        1.83 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
      8.36            -4.0        4.34 ± 10%      -4.2        4.12 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      5.19 ±  2%      -3.5        1.65 ± 14%      -3.7        1.52 ±  9%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      6.11            -3.0        3.13 ±  2%      -2.9        3.20 ±  2%  perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      4.80 ±  2%      -2.9        1.88 ± 14%      -3.1        1.74 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
      5.30            -2.5        2.80 ±  9%      -2.6        2.66 ±  5%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      9.77            -2.4        7.32            -2.5        7.24        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.77            -2.4        7.32            -2.5        7.24        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.77            -2.4        7.32            -2.5        7.24        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.67 ±  2%      -2.4        2.28 ± 11%      -2.5        2.15 ±  6%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      4.25 ±  2%      -2.3        1.94 ± 13%      -2.5        1.80 ±  7%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      4.21 ±  2%      -2.3        1.91 ± 13%      -2.4        1.77 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      8.19            -2.3        5.89 ±  2%      -2.4        5.78        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      8.20            -2.3        5.90 ±  2%      -2.4        5.80        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      8.17            -2.3        5.87 ±  2%      -2.4        5.76        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      3.70 ±  2%      -2.3        1.41 ± 11%      -2.4        1.32 ±  6%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      3.48 ±  2%      -2.2        1.26 ± 12%      -2.3        1.17 ±  7%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      3.41 ±  2%      -2.2        1.23 ± 12%      -2.3        1.14 ±  7%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      3.61 ±  3%      -2.2        1.43 ± 28%      -2.5        1.16 ±  6%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      3.34 ±  2%      -2.1        1.20 ± 13%      -2.2        1.11 ±  7%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap
      3.48 ±  3%      -2.1        1.35 ± 29%      -2.4        1.08 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
      3.31 ±  2%      -2.1        1.18 ± 13%      -2.2        1.09 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.unmap_region
      8.90            -2.1        6.82            -2.2        6.71        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.33            -2.0        7.28            -2.2        7.18        perf-profile.calltrace.cycles-pp.execve
      9.32            -2.0        7.28            -2.2        7.16        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      9.32            -2.0        7.28            -2.2        7.17        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      9.32            -2.0        7.28            -2.2        7.17        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      9.31            -2.0        7.26            -2.1        7.16        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      8.29            -2.0        6.29            -2.1        6.20        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      8.28            -2.0        6.28            -2.1        6.19        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      8.18            -2.0        6.19            -2.1        6.10        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      4.59            -1.6        2.96 ±  8%      -1.8        2.82        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.39            -1.6        2.79            -1.7        2.74        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      3.74            -1.5        2.22 ±  3%      -1.6        2.16        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      4.12 ±  5%      -1.5        2.65            -1.5        2.60        perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      3.69 ±  2%      -1.4        2.24 ±  6%      -1.5        2.15 ±  3%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      3.42            -1.4        1.98 ±  4%      -1.5        1.92        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      2.89 ±  2%      -1.3        1.58 ±  9%      -1.4        1.48 ±  4%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      2.36 ±  2%      -1.3        1.09 ± 10%      -1.4        0.98 ±  8%  perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      2.32 ±  2%      -1.3        1.06 ± 11%      -1.4        0.96 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      2.29 ±  3%      -1.3        1.04 ± 11%      -1.4        0.94 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
      7.41            -1.2        6.19            -1.2        6.18        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      2.11 ±  3%      -1.2        0.91 ± 11%      -1.3        0.82 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
      4.75            -1.1        3.61            -1.2        3.54        perf-profile.calltrace.cycles-pp.__libc_fork
      6.74            -1.1        5.61            -1.1        5.61        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      6.70            -1.1        5.58            -1.1        5.57        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.19            -1.1        3.13 ±  2%      -1.1        3.07        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      4.19            -1.1        3.13 ±  2%      -1.1        3.07        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      4.19            -1.1        3.14 ±  2%      -1.1        3.07        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      4.19            -1.1        3.14 ±  2%      -1.1        3.07        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      3.43            -1.0        2.42 ±  2%      -1.1        2.37        perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      3.41            -1.0        2.40 ±  2%      -1.1        2.36        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      5.90            -1.0        4.91            -1.0        4.91        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.62            -0.9        4.67            -0.9        4.68        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.68            -0.7        0.96 ±  5%      -0.8        0.92        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
      1.18 ±  3%      -0.7        0.47 ± 45%      -0.8        0.43 ± 44%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exec_mmap
      3.70            -0.7        3.02            -0.7        3.05        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.35 ±  3%      -0.7        0.70 ± 13%      -0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
      1.27 ±  3%      -0.6        0.64 ± 14%      -0.7        0.59 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
      3.37            -0.6        2.74            -0.6        2.77        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.24 ±  4%      -0.6        0.62 ± 14%      -0.7        0.58 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
      3.19            -0.6        2.59            -0.6        2.62        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      2.94            -0.5        2.42            -0.5        2.42        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      1.71            -0.5        1.23 ±  3%      -0.5        1.22        perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.71            -0.5        1.23 ±  3%      -0.5        1.21        perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.75            -0.5        2.28            -0.5        2.26        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      1.22            -0.5        0.74 ±  6%      -0.5        0.71 ±  2%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.20            -0.5        0.73 ±  6%      -0.5        0.70 ±  2%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.56            -0.5        1.10 ±  3%      -0.5        1.08        perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.15            -0.5        0.69 ±  6%      -0.5        0.66 ±  2%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.41            -0.4        0.97 ±  4%      -0.5        0.95        perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.38            -0.4        0.94 ±  4%      -0.5        0.92        perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      2.34            -0.4        1.92            -0.4        1.91        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      2.19            -0.4        1.80            -0.4        1.79        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.88            -0.4        1.51            -0.3        1.54        perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.93 ±  2%      -0.4        0.57 ±  7%      -0.4        0.55 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      0.61            -0.4        0.25 ±100%      -0.2        0.42 ± 44%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.61            -0.4        0.25 ±100%      -0.3        0.34 ± 70%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      1.34 ±  3%      -0.4        0.98 ±  5%      -0.4        0.96 ±  5%  perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      1.32 ±  3%      -0.3        0.98 ±  5%      -0.4        0.95 ±  5%  perf-profile.calltrace.cycles-pp.elf_load.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm
      0.59 ±  2%      -0.3        0.25 ±100%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp._IO_default_xsputn
      1.65            -0.3        1.34            -0.3        1.36        perf-profile.calltrace.cycles-pp.setlocale
      1.38            -0.3        1.08 ±  2%      -0.3        1.08        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.82            -0.3        1.52            -0.3        1.51        perf-profile.calltrace.cycles-pp.__mmap
      1.79            -0.3        1.49            -0.3        1.49        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.79            -0.3        1.49            -0.3        1.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      1.36            -0.3        1.06 ±  2%      -0.3        1.06        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      1.30            -0.3        1.00            -0.3        0.99        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.30            -0.3        1.00            -0.3        0.99        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.75            -0.3        1.46            -0.3        1.46        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.73            -0.3        1.45            -0.3        1.44        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.08            -0.2        0.84            -0.2        0.84        perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.66 ±  2%      -0.2        0.43 ± 44%      -0.1        0.52        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups.path_openat
      0.66 ±  2%      -0.2        0.43 ± 44%      -0.1        0.52        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.87 ±  4%      -0.2        0.64 ±  6%      -0.2        0.62 ±  5%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary.search_binary_handler
      0.84 ±  3%      -0.2        0.61 ±  6%      -0.2        0.60 ±  5%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary
      0.82 ±  3%      -0.2        0.59 ±  7%      -0.2        0.58 ±  6%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp
      1.42            -0.2        1.20            -0.2        1.20        perf-profile.calltrace.cycles-pp._dl_addr
      0.74            -0.2        0.52 ±  2%      -0.2        0.51        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74            -0.2        0.52 ±  2%      -0.2        0.51        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.88 ±  2%      -0.2        0.67 ±  3%      -0.2        0.66        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.08            -0.2        0.88            -0.2        0.89        perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
      1.04            -0.2        0.85            -0.2        0.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.02            -0.2        0.84            -0.2        0.85        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.03            -0.2        0.85            -0.2        0.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.02            -0.2        0.83            -0.2        0.84        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      1.08            -0.2        0.92 ±  2%      -0.2        0.91 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.08 ±  2%      -0.2        0.92 ±  2%      -0.2        0.91        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.82            -0.2        0.66 ±  2%      -0.2        0.66 ±  2%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.74 ±  2%      -0.2        0.58            -0.1        0.60        perf-profile.calltrace.cycles-pp.down_read.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      1.05            -0.2        0.89 ±  2%      -0.2        0.88 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.72 ±  2%      -0.2        0.56            -0.1        0.58        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.open_last_lookups.path_openat.do_filp_open
      0.86            -0.1        0.71            -0.1        0.72        perf-profile.calltrace.cycles-pp.elf_load.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.91            -0.1        0.77 ±  2%      -0.1        0.77        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.87 ±  2%      -0.1        0.74 ±  2%      -0.1        0.73        perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.73            -0.1        0.59 ±  2%      -0.1        0.60        perf-profile.calltrace.cycles-pp.wait4
      0.71            -0.1        0.58 ±  2%      -0.1        0.58        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.82            -0.1        0.69 ±  2%      -0.1        0.68        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exec_mmap
      0.71            -0.1        0.58 ±  2%      -0.1        0.58        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.82            -0.1        0.70            -0.1        0.70        perf-profile.calltrace.cycles-pp.__strcoll_l
      0.76            -0.1        0.65            -0.1        0.64        perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.72            -0.1        0.61 ±  2%      -0.1        0.61        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.67            -0.1        0.57            -0.1        0.57 ±  2%  perf-profile.calltrace.cycles-pp.copy_strings.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78            +0.0        0.81            +0.0        0.81        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      1.34            +0.1        1.39            +0.0        1.39 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat
      1.00            +0.1        1.06            +0.1        1.06        perf-profile.calltrace.cycles-pp.open64
      0.98            +0.1        1.05            +0.1        1.05        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.98            +0.1        1.05            +0.1        1.05        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.97            +0.1        1.04            +0.1        1.04        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.97            +0.1        1.04            +0.1        1.04        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.38            +0.1        1.46            +0.1        1.46 ±  2%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.73            +0.1        0.84            +0.1        0.86        perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.74            +0.1        0.85            +0.1        0.86        perf-profile.calltrace.cycles-pp.unlinkat
      0.73            +0.1        0.85            +0.1        0.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
      0.73            +0.1        0.85            +0.1        0.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.72            +0.1        0.84            +0.1        0.86        perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.56 ±  3%      +0.1        0.70 ±  2%      +0.1        0.69 ±  3%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.66 ±  2%      +0.2        0.83 ±  2%      +0.2        0.82 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.69 ±  2%      +0.2        0.85 ±  2%      +0.2        0.84 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      0.82 ±  3%      +0.2        1.01            +0.2        1.00 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.75 ±  2%      +0.2        0.96 ±  4%      +0.2        0.98 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.71 ±  3%      +0.2        0.93 ±  4%      +0.2        0.95 ±  3%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
      0.71 ±  3%      +0.2        0.94 ±  4%      +0.2        0.95 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.71 ±  3%      +0.2        0.94 ±  4%      +0.2        0.95 ±  3%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
      0.64 ±  3%      +0.2        0.88 ±  3%      +0.3        0.89 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.66 ±  2%      +0.2        0.90 ±  3%      +0.3        0.92 ±  2%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      1.71            +0.2        1.96            +0.2        1.95        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.53            +0.3        0.78            +0.3        0.79 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.57 ±  2%      +0.3        0.82 ±  3%      +0.3        0.83 ±  2%  perf-profile.calltrace.cycles-pp.step_into.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.53 ±  2%      +0.3        0.79 ±  4%      +0.3        0.80 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.open_last_lookups.path_openat.do_filp_open
      1.96            +0.3        2.30            +0.3        2.30 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      2.22            +0.5        2.70            +0.5        2.71 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      2.90            +0.5        3.41            +0.5        3.39        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.02            +0.5        3.54            +0.5        3.54        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.00            +0.5        3.53            +0.5        3.52        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +0.5        0.55 ±  2%      +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      3.26            +0.6        3.81            +0.5        3.79        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.89            +0.6        4.48            +0.6        4.47        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.90            +0.6        4.49            +0.6        4.48        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      3.89            +0.6        4.48            +0.6        4.47        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.96            +0.6        4.56            +0.6        4.55        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +0.6        0.61 ±  2%      +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_lookupat
      0.00            +0.6        0.62            +0.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_lookupat
      0.00            +0.6        0.63 ±  2%      +0.6        0.63 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_lookupat.filename_lookup
      3.60            +0.6        4.24 ±  2%      +0.7        4.29        perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.42 ±  2%      +0.7        2.11 ±  2%      +0.7        2.11 ±  2%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.00            +0.7        0.69 ±  3%      +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open
      0.00            +0.7        0.71 ±  3%      +0.7        0.72 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
      2.66            +0.7        3.39            +0.7        3.38 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.00            +0.7        0.74 ±  3%      +0.7        0.75 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_openat
      0.00            +0.7        0.75 ±  2%      +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      1.58 ±  2%      +0.8        2.33 ±  2%      +0.8        2.33        perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.00            +0.8        0.75 ±  2%      +0.8        0.75 ±  4%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      1.60 ±  2%      +0.8        2.36 ±  2%      +0.8        2.36 ±  2%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.00            +0.8        0.76 ±  4%      +0.8        0.78 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.open_last_lookups
      0.00            +0.8        0.78 ±  4%      +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.open_last_lookups.path_openat
      2.94            +0.8        3.74            +0.8        3.74 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.82            +0.8        3.64            +0.8        3.64 ±  2%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.81            +0.8        3.64            +0.8        3.63 ±  2%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.79            +0.8        3.62            +0.8        3.62 ±  2%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      2.63 ± 11%      +0.8        3.47            +0.9        3.49 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath
      2.51 ± 10%      +0.9        3.42            +0.9        3.44        perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled
      2.13 ±  2%      +1.0        3.12            +1.0        3.13 ±  2%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      3.85            +1.1        4.97 ±  4%      +1.2        5.07        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read
      3.20            +1.3        4.55            +1.4        4.56        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      3.20            +1.4        4.56            +1.4        4.56        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk
      3.56 ±  2%      +1.6        5.11            +1.6        5.13 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk.path_openat
      3.64 ±  2%      +1.6        5.25            +1.6        5.27 ±  2%  perf-profile.calltrace.cycles-pp.down_read.walk_component.link_path_walk.path_openat.do_filp_open
      9.02            +1.9       10.96 ±  2%      +2.2       11.22        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
      9.10            +2.1       11.17 ±  2%      +2.3       11.42        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +3.0        2.95 ±  2%      +3.0        3.02 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel
      0.00            +3.0        3.04 ±  2%      +3.1        3.11 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      1.25            +3.1        4.34 ±  2%      +3.2        4.45 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
      1.28            +3.1        4.36 ±  2%      +3.2        4.47 ±  2%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +3.1        3.11 ±  2%      +3.2        3.18 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
      2.26 ±  2%      +3.8        6.09 ±  2%      +4.0        6.21 ±  2%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      1.97 ±  2%      +3.9        5.84 ±  2%      +4.0        5.96 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
      2.41            +4.0        6.45 ±  2%      +4.2        6.57 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
      0.00            +4.1        4.06 ±  3%      +4.2        4.17 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.link_path_walk
      2.46 ±  2%      +4.2        6.70 ±  5%      +4.3        6.75        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
      0.00            +4.2        4.24 ±  2%      +4.4        4.35 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_openat
      2.91            +4.2        7.16 ±  2%      +4.4        7.32        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
      3.06            +4.4        7.44 ±  2%      +4.5        7.61        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      1.93 ±  2%      +4.4        6.35 ±  2%      +4.5        6.46        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      1.96 ±  2%      +4.5        6.45 ±  2%      +4.6        6.56        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
      3.34            +4.6        7.91 ±  2%      +4.7        8.08        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      3.49            +4.6        8.08 ±  2%      +4.8        8.25 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      3.47            +4.6        8.06 ±  2%      +4.8        8.23 ±  2%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +4.6        4.64 ±  3%      +4.8        4.77 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
     56.81            +6.1       62.89            +6.3       63.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     56.78            +6.1       62.86            +6.3       63.05        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.15            +7.5       22.67            +7.9       23.06        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +7.8        7.81 ±  2%      +8.0        7.97 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00            +7.9        7.86 ±  2%      +8.0        8.02 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
     16.57           +10.6       27.14           +11.1       27.65        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     26.43           +15.3       41.72           +16.0       42.44        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.36           +15.3       41.65           +16.0       42.37        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     25.29           +15.3       40.58           +16.0       41.30        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.26           +15.3       40.56           +16.0       41.28        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.46 ±  2%      -9.3        9.17 ± 10%      -9.9        8.54 ±  5%  perf-profile.children.cycles-pp.down_write
     17.62 ±  2%      -9.1        8.49 ± 11%      -9.8        7.86 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     17.05 ±  2%      -9.0        8.05 ± 12%      -9.6        7.42 ±  6%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     15.24 ±  3%      -8.5        6.70 ± 13%      -9.1        6.11 ±  7%  perf-profile.children.cycles-pp.osq_lock
      8.12            -8.1        0.00            -8.1        0.00        perf-profile.children.cycles-pp.fast_dput
     17.23            -7.1       10.15 ±  6%      -7.5        9.73 ±  3%  perf-profile.children.cycles-pp.vm_mmap_pgoff
     17.01            -7.0        9.97 ±  6%      -7.5        9.55 ±  3%  perf-profile.children.cycles-pp.do_mmap
     16.65            -7.0        9.66 ±  6%      -7.4        9.24 ±  3%  perf-profile.children.cycles-pp.mmap_region
     14.52            -6.3        8.26 ±  7%      -6.6        7.90 ±  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
     10.35            -4.7        5.70 ±  8%      -4.9        5.42 ±  4%  perf-profile.children.cycles-pp.do_vmi_munmap
     10.25            -4.6        5.61 ±  8%      -4.9        5.34 ±  4%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      9.30            -4.2        5.10 ±  7%      -4.5        4.84 ±  3%  perf-profile.children.cycles-pp.free_pgtables
      7.85 ±  2%      -3.9        3.92 ± 10%      -4.2        3.66 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma
     12.10            -3.5        8.63 ±  2%      -3.6        8.47        perf-profile.children.cycles-pp.__mmput
     12.06            -3.5        8.60 ±  2%      -3.6        8.44        perf-profile.children.cycles-pp.exit_mmap
      6.66            -3.3        3.37 ± 10%      -3.5        3.18 ±  5%  perf-profile.children.cycles-pp.vma_prepare
      7.04            -3.0        4.04 ±  7%      -3.2        3.87 ±  3%  perf-profile.children.cycles-pp.__split_vma
      9.94            -2.5        7.46            -2.6        7.39        perf-profile.children.cycles-pp.do_group_exit
      9.94            -2.5        7.47            -2.6        7.39        perf-profile.children.cycles-pp.__x64_sys_exit_group
      9.93            -2.5        7.46            -2.6        7.38        perf-profile.children.cycles-pp.do_exit
     10.60            -2.3        8.26            -2.5        8.14        perf-profile.children.cycles-pp.do_execveat_common
     10.62            -2.3        8.28            -2.5        8.16        perf-profile.children.cycles-pp.__x64_sys_execve
      8.22            -2.3        5.92 ±  2%      -2.4        5.81        perf-profile.children.cycles-pp.exit_mm
      8.96            -2.1        6.87            -2.2        6.77        perf-profile.children.cycles-pp.bprm_execve
      9.33            -2.0        7.28            -2.2        7.18        perf-profile.children.cycles-pp.execve
      4.28            -2.0        2.26 ±  8%      -2.1        2.14 ±  4%  perf-profile.children.cycles-pp.unmap_region
      8.29            -2.0        6.29            -2.1        6.20        perf-profile.children.cycles-pp.exec_binprm
      8.28            -2.0        6.28            -2.1        6.19        perf-profile.children.cycles-pp.search_binary_handler
      8.18            -2.0        6.19            -2.1        6.11        perf-profile.children.cycles-pp.load_elf_binary
     10.54            -1.7        8.80            -1.8        8.79        perf-profile.children.cycles-pp.asm_exc_page_fault
      9.48            -1.6        7.88            -1.6        7.88        perf-profile.children.cycles-pp.exc_page_fault
      9.43            -1.6        7.84            -1.6        7.84        perf-profile.children.cycles-pp.do_user_addr_fault
      8.63            -1.5        7.17            -1.4        7.18        perf-profile.children.cycles-pp.handle_mm_fault
      8.23            -1.4        6.84            -1.4        6.85        perf-profile.children.cycles-pp.__handle_mm_fault
      5.37            -1.3        4.03 ±  2%      -1.4        3.95        perf-profile.children.cycles-pp.kernel_clone
      4.92            -1.3        3.66 ±  2%      -1.3        3.58        perf-profile.children.cycles-pp.__do_sys_clone
      4.82            -1.3        3.57 ±  2%      -1.3        3.50        perf-profile.children.cycles-pp.copy_process
      4.39            -1.2        3.16            -1.3        3.10        perf-profile.children.cycles-pp.begin_new_exec
      4.20            -1.2        3.00 ±  2%      -1.3        2.94        perf-profile.children.cycles-pp.exec_mmap
      4.79            -1.1        3.64            -1.2        3.57        perf-profile.children.cycles-pp.__libc_fork
      3.74            -1.1        2.60 ±  3%      -1.2        2.52        perf-profile.children.cycles-pp.dup_mm
      3.43            -1.1        2.32 ±  4%      -1.2        2.26        perf-profile.children.cycles-pp.dup_mmap
      5.47            -1.0        4.47            -1.0        4.51        perf-profile.children.cycles-pp.do_fault
      5.02            -0.9        4.09            -0.9        4.13        perf-profile.children.cycles-pp.do_read_fault
      4.85            -0.9        3.96            -0.9        3.99        perf-profile.children.cycles-pp.filemap_map_pages
      3.58            -0.6        2.96            -0.6        2.96        perf-profile.children.cycles-pp.unmap_vmas
      3.32            -0.6        2.74            -0.6        2.73        perf-profile.children.cycles-pp.unmap_page_range
      2.86            -0.6        2.30            -0.5        2.34        perf-profile.children.cycles-pp.next_uptodate_folio
      3.21            -0.6        2.66            -0.6        2.64        perf-profile.children.cycles-pp.zap_pmd_range
      2.46            -0.6        1.90 ±  3%      -0.6        1.88 ±  3%  perf-profile.children.cycles-pp.elf_load
      3.15            -0.5        2.60            -0.6        2.59        perf-profile.children.cycles-pp.zap_pte_range
      1.03 ±  2%      -0.5        0.51 ± 10%      -0.5        0.48 ±  5%  perf-profile.children.cycles-pp.vma_expand
      1.71            -0.5        1.23 ±  3%      -0.5        1.22        perf-profile.children.cycles-pp.__x64_sys_mprotect
      1.71            -0.5        1.23 ±  3%      -0.5        1.21        perf-profile.children.cycles-pp.do_mprotect_pkey
      1.56            -0.5        1.10 ±  3%      -0.5        1.08        perf-profile.children.cycles-pp.mprotect_fixup
      2.14            -0.4        1.69            -0.5        1.68        perf-profile.children.cycles-pp.tlb_finish_mmu
      1.53            -0.4        1.08 ±  3%      -0.4        1.08 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.41            -0.4        0.97 ±  4%      -0.5        0.95        perf-profile.children.cycles-pp.vma_modify
      1.93            -0.4        1.52            -0.4        1.51        perf-profile.children.cycles-pp.tlb_batch_pages_flush
      1.48 ±  3%      -0.4        1.09 ±  5%      -0.4        1.06 ±  5%  perf-profile.children.cycles-pp.load_elf_interp
      1.61            -0.4        1.26            -0.4        1.24        perf-profile.children.cycles-pp.release_pages
      1.66            -0.3        1.35            -0.3        1.37        perf-profile.children.cycles-pp.setlocale
      1.83            -0.3        1.52            -0.3        1.52        perf-profile.children.cycles-pp.__mmap
      1.85            -0.3        1.58            -0.3        1.55        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.24 ±  2%      -0.3        0.96 ±  3%      -0.3        0.95        perf-profile.children.cycles-pp.alloc_empty_file
      1.69            -0.3        1.42            -0.3        1.42        perf-profile.children.cycles-pp.vma_interval_tree_insert
      1.39            -0.2        1.14            -0.2        1.15        perf-profile.children.cycles-pp.__open64_nocancel
      0.89 ±  3%      -0.2        0.65 ±  3%      -0.2        0.64        perf-profile.children.cycles-pp.init_file
      1.48            -0.2        1.25            -0.2        1.24 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.78 ±  3%      -0.2        0.55 ±  3%      -0.2        0.55 ±  2%  perf-profile.children.cycles-pp.security_file_alloc
      1.19            -0.2        0.96            -0.2        0.96 ±  2%  perf-profile.children.cycles-pp.page_remove_rmap
      1.41            -0.2        1.19            -0.2        1.18 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      1.07            -0.2        0.85 ±  2%      -0.2        0.84 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
      1.43            -0.2        1.22            -0.2        1.21        perf-profile.children.cycles-pp._dl_addr
      0.67 ±  4%      -0.2        0.47 ±  4%      -0.2        0.47 ±  3%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      1.30            -0.2        1.10 ±  2%      -0.2        1.09        perf-profile.children.cycles-pp.ret_from_fork_asm
      1.26            -0.2        1.07 ±  2%      -0.2        1.07        perf-profile.children.cycles-pp.ret_from_fork
      0.47 ±  4%      -0.2        0.30 ±  6%      -0.2        0.30 ±  3%  perf-profile.children.cycles-pp.security_file_free
      0.74            -0.2        0.56 ±  2%      -0.2        0.55        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.46 ±  4%      -0.2        0.29 ±  6%      -0.2        0.30 ±  3%  perf-profile.children.cycles-pp.apparmor_file_free_security
      1.00            -0.2        0.83            -0.2        0.82        perf-profile.children.cycles-pp.set_pte_range
      1.06            -0.2        0.89            -0.2        0.89 ±  2%  perf-profile.children.cycles-pp.do_anonymous_page
      0.90 ±  2%      -0.2        0.74 ±  3%      -0.2        0.74 ±  2%  perf-profile.children.cycles-pp._compound_head
      0.97            -0.2        0.81            -0.2        0.80        perf-profile.children.cycles-pp.get_page_from_freelist
      1.52            -0.2        1.36            -0.2        1.34        perf-profile.children.cycles-pp.kmem_cache_free
      1.05            -0.2        0.89 ±  2%      -0.2        0.88 ±  2%  perf-profile.children.cycles-pp.kthread
      0.86            -0.2        0.70 ±  3%      -0.2        0.69        perf-profile.children.cycles-pp.vma_complete
      0.93            -0.2        0.78            -0.1        0.78        perf-profile.children.cycles-pp.perf_event_mmap
      0.90            -0.1        0.76            -0.1        0.76        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.94            -0.1        0.80 ±  2%      -0.1        0.79        perf-profile.children.cycles-pp.mas_store_prealloc
      0.73            -0.1        0.59 ±  2%      -0.1        0.60        perf-profile.children.cycles-pp.wait4
      0.22 ±  3%      -0.1        0.08 ±  4%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.87 ±  2%      -0.1        0.74 ±  2%      -0.1        0.73        perf-profile.children.cycles-pp.smpboot_thread_fn
      1.60            -0.1        1.47 ±  2%      -0.1        1.46        perf-profile.children.cycles-pp.__do_softirq
      0.83            -0.1        0.70            -0.1        0.70        perf-profile.children.cycles-pp.__strcoll_l
      0.95            -0.1        0.82            -0.1        0.81        perf-profile.children.cycles-pp.wp_page_copy
      0.70            -0.1        0.57 ±  2%      -0.1        0.58        perf-profile.children.cycles-pp.kernel_wait4
      0.70            -0.1        0.57 ±  2%      -0.1        0.58        perf-profile.children.cycles-pp.__do_sys_wait4
      0.68            -0.1        0.56 ±  2%      -0.1        0.56        perf-profile.children.cycles-pp.do_wait
      0.56 ±  3%      -0.1        0.43 ±  2%      -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.release_empty_file
      1.38            -0.1        1.26 ±  2%      -0.1        1.24        perf-profile.children.cycles-pp.rcu_do_batch
      1.43            -0.1        1.30 ±  2%      -0.1        1.29        perf-profile.children.cycles-pp.rcu_core
      0.78            -0.1        0.66            -0.1        0.66 ±  2%  perf-profile.children.cycles-pp.copy_strings
      0.66            -0.1        0.55            -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.98            -0.1        0.87            -0.1        0.86 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.60            -0.1        0.50            -0.1        0.50        perf-profile.children.cycles-pp.perf_iterate_sb
      0.51 ±  2%      -0.1        0.41 ±  2%      -0.1        0.42        perf-profile.children.cycles-pp.do_open
      0.64            -0.1        0.54 ±  2%      -0.1        0.53        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.28 ±  2%      -0.1        0.18 ±  2%      -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.60            -0.1        0.50 ±  2%      -0.1        0.50        perf-profile.children.cycles-pp.copy_page_range
      0.58            -0.1        0.48 ±  2%      -0.1        0.48        perf-profile.children.cycles-pp.copy_p4d_range
      0.68            -0.1        0.58 ±  4%      -0.1        0.56        perf-profile.children.cycles-pp.mm_init
      0.59            -0.1        0.50            -0.1        0.49        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.57            -0.1        0.48 ±  4%      -0.1        0.48        perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.63 ±  2%      -0.1        0.54 ±  2%      -0.1        0.54 ±  3%  perf-profile.children.cycles-pp._IO_default_xsputn
      0.80            -0.1        0.71            -0.1        0.69 ±  2%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.52            -0.1        0.43 ±  3%      -0.1        0.44 ±  3%  perf-profile.children.cycles-pp.vfs_read
      0.45 ±  3%      -0.1        0.36 ±  2%      -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.dup_task_struct
      0.54            -0.1        0.45 ±  3%      -0.1        0.46 ±  2%  perf-profile.children.cycles-pp.ksys_read
      0.48            -0.1        0.39 ±  3%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.__fput
      0.60            -0.1        0.51 ±  3%      -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.__mmdrop
      0.60 ±  2%      -0.1        0.51 ±  2%      -0.1        0.51        perf-profile.children.cycles-pp.sync_regs
      0.49            -0.1        0.40 ±  3%      -0.1        0.41 ±  2%  perf-profile.children.cycles-pp.read
      0.50            -0.1        0.42            -0.1        0.42        perf-profile.children.cycles-pp.clear_page_erms
      0.48 ±  4%      -0.1        0.40 ±  4%      -0.1        0.40 ±  3%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.71            -0.1        1.63            -0.1        1.62        perf-profile.children.cycles-pp.up_write
      0.48 ±  2%      -0.1        0.39 ±  3%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.task_work_run
      0.59            -0.1        0.50 ±  3%      -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.getname_flags
      1.94            -0.1        1.85            -0.1        1.85        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.55            -0.1        0.47 ±  2%      -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.63            -0.1        0.55            -0.1        0.54 ±  2%  perf-profile.children.cycles-pp.find_idlest_cpu
      0.59            -0.1        0.51 ±  2%      -0.1        0.52        perf-profile.children.cycles-pp.native_irq_return_iret
      0.46            -0.1        0.38 ±  2%      -0.1        0.38        perf-profile.children.cycles-pp.rmqueue
      2.10            -0.1        2.02            -0.1        2.01        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.50            -0.1        0.42 ±  2%      -0.1        0.42        perf-profile.children.cycles-pp.vm_area_alloc
      0.49            -0.1        0.41            -0.1        0.41        perf-profile.children.cycles-pp.__vfork
      0.47            -0.1        0.39 ±  2%      -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
      0.32 ±  5%      -0.1        0.24 ±  3%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.41 ±  3%      -0.1        0.34            -0.1        0.34        perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.44 ±  2%      -0.1        0.36 ±  2%      -0.1        0.36        perf-profile.children.cycles-pp.mas_wr_node_store
      0.35 ±  3%      -0.1        0.28            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.do_dentry_open
      0.41 ±  2%      -0.1        0.34            -0.1        0.34        perf-profile.children.cycles-pp.do_task_dead
      0.44            -0.1        0.36            -0.1        0.36        perf-profile.children.cycles-pp.do_cow_fault
      0.45            -0.1        0.38            -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.strnlen_user
      0.46            -0.1        0.40            -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.44            -0.1        0.37 ±  4%      -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.44            -0.1        0.38 ±  2%      -0.1        0.37        perf-profile.children.cycles-pp.mas_walk
      0.38            -0.1        0.31 ±  2%      -0.1        0.31        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.41            -0.1        0.34 ±  3%      -0.1        0.35        perf-profile.children.cycles-pp.perf_event_mmap_output
      0.45 ±  2%      -0.1        0.38 ±  2%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.get_arg_page
      0.34            -0.1        0.28            -0.1        0.27 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.54            -0.1        0.48            -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
      0.36 ±  2%      -0.1        0.29 ±  3%      -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.free_swap_cache
      0.47 ±  2%      -0.1        0.40 ±  3%      -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.alloc_bprm
      0.36 ±  2%      -0.1        0.30            -0.1        0.30        perf-profile.children.cycles-pp.__perf_sw_event
      0.44            -0.1        0.38            -0.1        0.37        perf-profile.children.cycles-pp.__x64_sys_vfork
      0.67            -0.1        0.61 ±  2%      -0.1        0.59 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.40 ±  2%      -0.1        0.34 ±  2%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.pte_alloc_one
      0.31 ±  3%      -0.1        0.25            -0.1        0.25        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.31            -0.1        0.24 ±  2%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.lru_add_drain
      0.39            -0.1        0.33 ±  2%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.64            -0.1        0.58            -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.40            -0.1        0.34 ±  2%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.mas_split
      0.31            -0.1        0.25 ±  2%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.38            -0.1        0.32            -0.1        0.32        perf-profile.children.cycles-pp.mtree_range_walk
      0.41            -0.1        0.35            -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.create_elf_tables
      0.50            -0.1        0.44            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.31            -0.1        0.25 ±  4%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.pipe_read
      0.29            -0.1        0.24 ±  3%      -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__do_wait
      0.39 ±  2%      -0.1        0.33 ±  2%      -0.1        0.34        perf-profile.children.cycles-pp.setup_arg_pages
      0.44 ±  3%      -0.1        0.38 ±  2%      -0.1        0.37        perf-profile.children.cycles-pp.__cond_resched
      0.41 ±  2%      -0.1        0.35 ±  2%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.sched_exec
      0.37 ±  2%      -0.1        0.31 ±  3%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.36 ±  2%      -0.1        0.30 ±  2%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.__get_user_pages
      0.41 ±  2%      -0.1        0.35 ±  3%      -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      0.41 ±  2%      -0.1        0.36 ±  2%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.31 ±  2%      -0.1        0.25 ±  2%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      0.39            -0.1        0.34 ±  2%      -0.1        0.33        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.36 ±  2%      -0.1        0.30 ±  3%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.39            -0.1        0.34 ±  5%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.pcpu_alloc
      0.37            -0.1        0.32            -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.__vm_area_free
      0.34            -0.1        0.28 ±  3%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.20 ±  5%      -0.1        0.15 ±  5%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.36            -0.1        0.31 ±  2%      -0.1        0.31        perf-profile.children.cycles-pp.mas_preallocate
      0.42 ±  2%      -0.1        0.36            -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.wake_up_new_task
      0.29            -0.1        0.24 ±  2%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.33            -0.1        0.28 ±  2%      -0.1        0.28        perf-profile.children.cycles-pp.copy_pte_range
      0.93            -0.1        0.88            -0.1        0.87 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.22 ±  2%      -0.0        0.16 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__rb_erase_color
      0.38 ±  2%      -0.0        0.33 ±  2%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.32 ±  2%      -0.0        0.27 ±  2%      -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.get_unmapped_area
      0.28 ±  2%      -0.0        0.23 ±  3%      -0.0        0.24        perf-profile.children.cycles-pp.mas_next_slot
      0.37 ±  2%      -0.0        0.33            -0.0        0.33        perf-profile.children.cycles-pp.___perf_sw_event
      0.27 ±  3%      -0.0        0.22 ±  4%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp._IO_fwrite
      0.26 ±  2%      -0.0        0.22 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__close
      0.32 ±  2%      -0.0        0.28            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.shift_arg_pages
      0.22            -0.0        0.18 ±  2%      -0.1        0.17        perf-profile.children.cycles-pp.rmqueue_bulk
      0.28 ±  2%      -0.0        0.24 ±  3%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.14 ±  9%      -0.0        0.09 ±  7%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.28 ±  3%      -0.0        0.23 ±  2%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.30 ±  2%      -0.0        0.26 ±  2%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.__pte_alloc
      0.31            -0.0        0.27 ±  5%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.vfs_write
      0.26            -0.0        0.22 ±  4%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.14 ±  9%      -0.0        0.10 ± 24%      -0.1        0.09 ± 19%  perf-profile.children.cycles-pp.osq_unlock
      0.13 ±  8%      -0.0        0.09 ± 10%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.30            -0.0        0.25            -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.write
      0.24 ±  3%      -0.0        0.20 ±  3%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.__fxstat64
      0.20 ±  9%      -0.0        0.15 ±  2%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.inode_permission
      0.25            -0.0        0.21 ±  3%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.32            -0.0        0.28 ±  6%      -0.1        0.27 ±  2%  perf-profile.children.cycles-pp.ksys_write
      1.15            -0.0        1.10            -0.1        1.10        perf-profile.children.cycles-pp.irq_exit_rcu
      0.29            -0.0        0.24 ±  2%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.27            -0.0        0.22 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.free_unref_page
      0.31            -0.0        0.26            -0.0        0.27 ±  2%  perf-profile.children.cycles-pp._IO_padn
      0.28 ±  3%      -0.0        0.24 ±  5%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.memset_orig
      0.28 ±  3%      -0.0        0.24            -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.copy_string_kernel
      0.25            -0.0        0.21 ±  3%      -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.22 ±  3%      -0.0        0.18 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.wait_task_zombie
      0.43 ±  2%      -0.0        0.39 ±  2%      -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.78 ±  2%      -0.0        0.74 ±  2%      -0.0        0.75 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.59            -0.0        0.55 ±  2%      -0.0        0.55        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.29            -0.0        0.25 ±  4%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.25 ±  3%      -0.0        0.21 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__x64_sys_close
      0.29 ±  2%      -0.0        0.26            -0.0        0.26        perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.28 ±  2%      -0.0        0.25            -0.0        0.25        perf-profile.children.cycles-pp.__check_object_size
      0.21 ±  4%      -0.0        0.17 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.do_open_execat
      0.11 ±  4%      -0.0        0.08 ±  6%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.security_file_open
      0.77 ±  2%      -0.0        0.73 ±  2%      -0.0        0.73        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.71 ±  2%      -0.0        0.68 ±  2%      -0.0        0.67 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.19 ±  3%      -0.0        0.16 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.memmove
      0.23 ±  2%      -0.0        0.20 ±  4%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.22 ±  2%      -0.0        0.19            -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.__pmd_alloc
      0.20 ±  4%      -0.0        0.17 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__close_nocancel
      0.24            -0.0        0.21 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.17 ±  2%      -0.0        0.13 ±  2%      -0.0        0.13        perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.20 ±  2%      -0.0        0.16 ±  3%      -0.0        0.16        perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.26 ±  2%      -0.0        0.23 ±  3%      -0.0        0.24        perf-profile.children.cycles-pp.try_charge_memcg
      0.22 ±  2%      -0.0        0.19 ±  5%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.18 ±  4%      -0.0        0.15            -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.20 ±  2%      -0.0        0.16 ±  4%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp._exit
      0.11 ±  3%      -0.0        0.08 ±  6%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.apparmor_file_open
      0.20            -0.0        0.17 ±  2%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__count_memcg_events
      0.21 ±  2%      -0.0        0.17 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      0.22 ±  3%      -0.0        0.18 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.map_vdso
      0.23 ±  3%      -0.0        0.19 ±  2%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.anon_vma_clone
      0.37 ±  2%      -0.0        0.34 ±  2%      -0.0        0.34        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.22 ±  2%      -0.0        0.19 ±  5%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp._copy_to_iter
      0.22 ±  2%      -0.0        0.19 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.24 ±  3%      -0.0        0.21 ±  5%      -0.0        0.21 ±  5%  perf-profile.children.cycles-pp.filemap_read
      0.19 ±  4%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.d_path
      0.18            -0.0        0.15 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.exit_notify
      0.26            -0.0        0.23 ±  3%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      0.19 ±  2%      -0.0        0.16 ±  2%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__pud_alloc
      0.20 ±  3%      -0.0        0.17 ±  4%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.__install_special_mapping
      0.18 ±  2%      -0.0        0.15 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mas_store_gfp
      0.18 ±  2%      -0.0        0.15 ±  4%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.release_task
      0.20 ±  2%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mas_find
      0.20 ±  2%      -0.0        0.18 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.schedule_tail
      0.18 ±  2%      -0.0        0.15 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.do_brk_flags
      0.19 ±  3%      -0.0        0.16 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.20 ±  3%      -0.0        0.17 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.11            -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.security_mmap_file
      0.10            -0.0        0.07 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.wait_for_completion_state
      0.13 ±  3%      -0.0        0.11 ±  4%      -0.0        0.11        perf-profile.children.cycles-pp.__unfreeze_partials
      0.16 ±  3%      -0.0        0.13 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.lru_add_fn
      0.20 ±  2%      -0.0        0.18 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.malloc
      0.19            -0.0        0.16 ±  3%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp._IO_file_xsputn
      0.16 ±  3%      -0.0        0.13            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.insert_vm_struct
      0.18 ±  2%      -0.0        0.15 ±  5%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.pgd_alloc
      0.17 ±  3%      -0.0        0.14 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.18 ±  4%      -0.0        0.16 ±  5%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mas_store
      0.18 ±  2%      -0.0        0.15 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__get_free_pages
      0.22 ±  2%      -0.0        0.20 ±  3%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__memcpy
      0.18 ±  2%      -0.0        0.15 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.15 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.15 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.down_read_trylock
      0.14 ±  3%      -0.0        0.11            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sched_move_task
      0.15            -0.0        0.12 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.12 ±  5%      -0.0        0.09 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.vfs_fstat
      0.16 ±  2%      -0.0        0.13 ±  3%      -0.0        0.14        perf-profile.children.cycles-pp.brk
      0.16 ±  6%      -0.0        0.13 ±  6%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.wmemchr
      0.15 ±  4%      -0.0        0.13 ±  4%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp._copy_from_user
      0.21 ±  4%      -0.0        0.19            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func
      0.10            -0.0        0.08 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__wait_for_common
      0.18 ±  2%      -0.0        0.15 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.check_heap_object
      0.15 ±  2%      -0.0        0.12 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__do_sys_brk
      0.14 ±  3%      -0.0        0.11 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.fopen
      0.14 ±  3%      -0.0        0.11 ±  3%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.remove_vma
      0.10 ±  4%      -0.0        0.08            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.schedule_timeout
      0.21            -0.0        0.18 ±  6%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.15 ±  3%      -0.0        0.13 ±  3%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.15 ±  3%      -0.0        0.13 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__put_anon_vma
      0.17 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.move_page_tables
      0.16 ±  4%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__cxa_atexit
      0.23 ±  2%      -0.0        0.20 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.13 ±  5%      -0.0        0.11            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__do_fault
      0.14 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__sysconf
      0.14 ±  2%      -0.0        0.12 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.open_exec
      0.14 ±  2%      -0.0        0.12 ±  6%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.prepend_path
      0.11 ±  6%      -0.0        0.09 ±  5%      -0.0        0.09        perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.15 ±  3%      -0.0        0.13 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.13 ±  2%      -0.0        0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.12 ±  4%      -0.0        0.09 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.do_wp_page
      0.14 ±  3%      -0.0        0.12 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.vma_link
      0.18 ±  2%      -0.0        0.16 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.balance_fair
      0.14            -0.0        0.12 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.do_notify_parent
      0.18 ±  3%      -0.0        0.16 ±  2%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.10            -0.0        0.08            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.16 ±  3%      -0.0        0.14 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.worker_thread
      0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__vsnprintf_chk
      0.11 ±  6%      -0.0        0.09 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.vm_normal_page
      0.10 ±  3%      -0.0        0.08 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.13 ±  2%      -0.0        0.11 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.13 ±  4%      -0.0        0.11            -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.10 ±  4%      -0.0        0.08 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__free_one_page
      0.07            -0.0        0.05            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.security_inode_getattr
      0.11 ±  6%      -0.0        0.09 ±  7%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp._setjmp
      0.12 ±  4%      -0.0        0.10 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.mas_rev_awalk
      0.16 ±  3%      -0.0        0.14 ±  9%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.generic_perform_write
      0.13 ±  3%      -0.0        0.11 ±  6%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__get_user_8
      0.13 ±  5%      -0.0        0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mas_push_data
      0.12 ±  6%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.alloc_fd
      0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.handle_pte_fault
      0.08 ±  8%      -0.0        0.06            -0.0        0.06        perf-profile.children.cycles-pp.mas_pop_node
      0.10 ±  3%      -0.0        0.08            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__p4d_alloc
      0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__exit_signal
      0.08 ±  4%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.apparmor_mmap_file
      0.12 ±  4%      -0.0        0.10 ±  6%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.put_cred_rcu
      0.11            -0.0        0.09 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.process_one_work
      0.15 ±  2%      -0.0        0.13 ±  5%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.free_pgd_range
      0.15            -0.0        0.13 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__put_user_4
      0.17 ±  2%      -0.0        0.16 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp._find_next_bit
      0.10            -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp._copy_to_user
      0.08 ±  6%      -0.0        0.06            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.mast_fill_bnode
      0.08 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.move_queued_task
      0.10 ±  3%      -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.pipe_write
      0.09 ±  4%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.filemap_fault
      0.12 ±  4%      -0.0        0.11 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.mas_wr_walk
      0.10 ±  4%      -0.0        0.09 ±  7%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.free_percpu
      0.10 ±  6%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.getenv
      0.09            -0.0        0.07 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.copy_present_pte
      0.11 ±  4%      -0.0        0.09            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.08 ±  5%      -0.0        0.07 ± 10%      -0.0        0.07        perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.stop_one_cpu
      0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.cpu_stopper_thread
      0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.mas_topiary_replace
      0.09 ±  4%      -0.0        0.07 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.09 ±  4%      -0.0        0.07 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.find_mergeable_anon_vma
      0.11 ±  4%      -0.0        0.10 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.12 ±  6%      -0.0        0.10            -0.0        0.10        perf-profile.children.cycles-pp.do_faccessat
      0.14 ±  3%      -0.0        0.13 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.10 ±  5%      -0.0        0.08            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.fput
      0.10 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__pte_offset_map
      0.10 ±  5%      -0.0        0.08 ±  7%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__snprintf_chk
      0.09            -0.0        0.08 ±  6%      -0.0        0.08        perf-profile.children.cycles-pp.acct_collect
      0.09 ±  5%      -0.0        0.08 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__sigsuspend
      0.14 ±  4%      -0.0        0.12 ±  6%      -0.0        0.12        perf-profile.children.cycles-pp.free_p4d_range
      0.11 ±  3%      -0.0        0.09 ±  5%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.11 ±  4%      -0.0        0.09 ±  7%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.strchrnul@plt
      0.09 ±  5%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.unmap_single_vma
      0.08 ±  4%      -0.0        0.07 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.11 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__kernel_read
      0.11 ±  6%      -0.0        0.09 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.expand_downwards
      0.11 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.prepare_creds
      0.09 ±  4%      -0.0        0.07 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.vm_brk_flags
      0.14 ±  3%      -0.0        0.12 ±  6%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.10 ±  5%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.count
      0.10            -0.0        0.09 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__munmap
      0.07 ±  6%      -0.0        0.06            -0.0        0.06        perf-profile.children.cycles-pp.__mod_node_page_state
      0.07 ±  6%      -0.0        0.06            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.perf_event_task_output
      0.07 ±  6%      -0.0        0.06            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.touch_atime
      0.07            -0.0        0.06 ±  8%      -0.0        0.06        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.08            -0.0        0.07 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.simple_write_begin
      0.09 ±  5%      -0.0        0.08            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.evict
      0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.vfree
      0.08            -0.0        0.07 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.prepend_copy
      0.08 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.08 ±  5%      -0.0        0.07 ±  8%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.perf_output_begin
      0.11            -0.0        0.10 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.10 ±  4%      -0.0        0.09 ±  7%      -0.0        0.09        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.10 ±  5%      -0.0        0.08 ±  5%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.11 ±  3%      -0.0        0.10 ±  5%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.mas_update_gap
      0.07 ±  5%      -0.0        0.06            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      0.09            -0.0        0.08 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mt_find
      0.07 ±  5%      -0.0        0.06            -0.0        0.06        perf-profile.children.cycles-pp.finish_fault
      0.07 ± 11%      -0.0        0.06 ± 97%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.main
      0.07 ± 11%      -0.0        0.06 ± 97%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.run_builtin
      0.06 ±  6%      -0.0        0.05            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.sigsuspend
      0.10 ±  3%      -0.0        0.09            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.08 ±  4%      -0.0        0.07            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.cfree
      0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.__send_signal_locked
      0.08 ±  4%      -0.0        0.07 ±  8%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.filemap_get_entry
      0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.arch_dup_task_struct
      0.08 ±  4%      -0.0        0.07            -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.get_zeroed_page
      0.06 ±  6%      -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.__wake_up_sync_key
      0.08            -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.10 ±  3%      -0.0        0.09            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.refill_obj_stock
      0.07            -0.0        0.06 ±  9%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.complete_signal
      0.08 ±  5%      -0.0        0.08 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp._IO_setb
      0.08 ±  6%      -0.0        0.07 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.07            -0.0        0.06 ±  9%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.copy_from_kernel_nofault
      0.09            -0.0        0.08            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.07            -0.0        0.06 ±  9%      -0.0        0.06        perf-profile.children.cycles-pp.__getrlimit
      0.06 ±  6%      -0.0        0.05 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__x64_sys_rt_sigsuspend
      0.06            -0.0        0.05 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.06            -0.0        0.05 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.remove_vm_area
      0.06 ±  7%      -0.0        0.06 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.security_bprm_creds_for_exec
      0.06 ±  7%      -0.0        0.06 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.kmalloc_trace
      0.07 ±  7%      -0.0        0.06            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.06 ±  7%      -0.0        0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.apparmor_bprm_creds_for_exec
      0.06 ±  6%      -0.0        0.06 ±  8%      -0.0        0.05        perf-profile.children.cycles-pp.dup_userfaultfd
      0.06            +0.0        0.07            +0.0        0.07        perf-profile.children.cycles-pp.reweight_entity
      0.06            +0.0        0.07            +0.0        0.07        perf-profile.children.cycles-pp.llist_reverse_order
      0.11 ±  4%      +0.0        0.12 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.05 ±  8%      +0.0        0.07 ±  5%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.resched_curr
      0.12 ±  5%      +0.0        0.14 ±  3%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.08 ±  8%      +0.0        0.10 ±  3%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.wakeup_preempt
      0.10 ±  4%      +0.0        0.12 ±  3%      +0.0        0.12        perf-profile.children.cycles-pp.wake_affine
      0.18 ±  2%      +0.0        0.20 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.16 ±  2%      +0.0        0.18 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.menu_select
      0.15 ±  3%      +0.0        0.17 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.21 ±  4%      +0.0        0.23            +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.update_blocked_averages
      0.18 ±  4%      +0.0        0.20            +0.0        0.20        perf-profile.children.cycles-pp.update_rq_clock
      0.09 ±  5%      +0.0        0.11 ±  3%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.llist_add_batch
      0.11 ±  3%      +0.0        0.14 ±  2%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.09 ±  4%      +0.0        0.12 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.17 ±  5%      +0.0        0.20 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.find_busiest_queue
      0.31 ±  3%      +0.0        0.35            +0.0        0.34        perf-profile.children.cycles-pp.select_task_rq
      0.02 ±141%      +0.0        0.05 ±  7%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.poll_idle
      0.03 ± 70%      +0.0        0.07 ±  5%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__filename_parentat
      0.03 ± 70%      +0.0        0.07 ±  5%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.path_parentat
      0.08 ±  7%      +0.0        0.12 ±  4%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.23 ±  2%      +0.0        0.26            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp._find_next_and_bit
      0.19 ±  3%      +0.0        0.23 ±  3%      +0.0        0.24 ±  4%  perf-profile.children.cycles-pp.complete_walk
      0.25 ±  3%      +0.0        0.30 ±  2%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.67            +0.0        0.72            +0.1        0.72 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.16 ±  2%      +0.0        0.20 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.33 ±  3%      +0.0        0.38 ±  2%      +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.cpu_util
      0.31 ±  3%      +0.1        0.36            +0.1        0.37 ±  3%  perf-profile.children.cycles-pp.__d_alloc
      0.50 ±  2%      +0.1        0.56            +0.1        0.55 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.16 ±  3%      +0.1        0.21 ±  4%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.lockref_get
      0.15 ±  4%      +0.1        0.21 ±  3%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.copy_fs_struct
      0.00            +0.1        0.06 ±  6%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.___d_drop
      0.00            +0.1        0.06 ±  7%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__d_lookup_unhash
      0.24 ±  2%      +0.1        0.30 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.__call_rcu_common
      0.00            +0.1        0.06 ± 11%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__wake_up
      0.84            +0.1        0.90            +0.1        0.90        perf-profile.children.cycles-pp.try_to_wake_up
      1.00            +0.1        1.06            +0.1        1.06        perf-profile.children.cycles-pp.open64
      0.66 ±  2%      +0.1        0.73            +0.1        0.72 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.10 ±  3%      +0.1        0.17 ±  3%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.01 ±223%      +0.1        0.08            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__d_rehash
      0.49            +0.1        0.56 ±  2%      +0.1        0.56 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.34 ±  2%      +0.1        0.42 ±  2%      +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.idle_cpu
      0.74            +0.1        0.81            +0.1        0.80 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.65            +0.1        0.73            +0.1        0.73 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.20 ±  7%      +0.1        0.30 ±  5%      +0.1        0.32 ±  6%  perf-profile.children.cycles-pp.exit_fs
      0.68            +0.1        0.77            +0.1        0.77        perf-profile.children.cycles-pp.wake_up_q
      0.78            +0.1        0.88            +0.1        0.88        perf-profile.children.cycles-pp.rwsem_wake
      0.32 ±  4%      +0.1        0.42            +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.63 ±  2%      +0.1        0.74            +0.1        0.74 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.74            +0.1        0.86            +0.1        0.86        perf-profile.children.cycles-pp.unlinkat
      0.73            +0.1        0.84            +0.1        0.86        perf-profile.children.cycles-pp.__x64_sys_unlinkat
      0.26 ±  4%      +0.1        0.38 ±  3%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.path_put
      0.73            +0.1        0.84            +0.1        0.86        perf-profile.children.cycles-pp.do_unlinkat
      0.32 ±  9%      +0.1        0.44 ±  8%      +0.1        0.45 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.13 ±  2%      +0.1        0.27 ±  2%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.__d_add
      0.65 ±  2%      +0.1        0.80            +0.1        0.78 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.14 ±  3%      +0.1        0.28            +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.simple_lookup
      0.78 ±  2%      +0.2        0.94 ±  2%      +0.2        0.93 ±  3%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.80 ±  2%      +0.2        0.96            +0.2        0.96 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.94 ±  2%      +0.2        1.13            +0.2        1.12 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.78 ±  2%      +0.2        0.99 ±  3%      +0.2        1.01        perf-profile.children.cycles-pp.lookup_open
      1.90            +0.5        2.37            +0.5        2.36 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      2.95            +0.5        3.46            +0.5        3.45        perf-profile.children.cycles-pp.acpi_idle_enter
      2.94            +0.5        3.45            +0.5        3.44        perf-profile.children.cycles-pp.acpi_safe_halt
      3.06            +0.5        3.58            +0.5        3.58        perf-profile.children.cycles-pp.cpuidle_enter_state
      2.63            +0.5        3.16            +0.5        3.17        perf-profile.children.cycles-pp.update_sg_lb_stats
      3.07            +0.5        3.60            +0.5        3.60        perf-profile.children.cycles-pp.cpuidle_enter
      2.84            +0.6        3.39            +0.6        3.41        perf-profile.children.cycles-pp.update_sd_lb_stats
      2.88            +0.6        3.43            +0.6        3.45        perf-profile.children.cycles-pp.find_busiest_group
      3.31            +0.6        3.87            +0.6        3.86        perf-profile.children.cycles-pp.cpuidle_idle_call
      3.90            +0.6        4.49            +0.6        4.48        perf-profile.children.cycles-pp.start_secondary
      3.96            +0.6        4.56            +0.6        4.54        perf-profile.children.cycles-pp.do_idle
      3.96            +0.6        4.56            +0.6        4.55        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      3.96            +0.6        4.56            +0.6        4.55        perf-profile.children.cycles-pp.cpu_startup_entry
      3.82            +0.6        4.42 ±  2%      +0.7        4.47        perf-profile.children.cycles-pp.open_last_lookups
      3.83            +0.7        4.53            +0.7        4.56        perf-profile.children.cycles-pp.load_balance
      4.17            +0.8        4.93            +0.8        4.96        perf-profile.children.cycles-pp.newidle_balance
      4.21            +0.8        5.00            +0.8        5.05        perf-profile.children.cycles-pp.pick_next_task_fair
      3.17            +0.8        3.98            +0.8        3.98 ±  2%  perf-profile.children.cycles-pp.filename_lookup
      3.15            +0.8        3.96            +0.8        3.96 ±  2%  perf-profile.children.cycles-pp.path_lookupat
      3.30            +0.8        4.12            +0.8        4.12 ±  2%  perf-profile.children.cycles-pp.__do_sys_newstat
      3.16            +0.8        4.00            +0.8        4.01 ±  2%  perf-profile.children.cycles-pp.vfs_statx
      6.22            +0.9        7.12            +0.9        7.14        perf-profile.children.cycles-pp.__schedule
      5.24            +1.0        6.20            +1.0        6.22        perf-profile.children.cycles-pp.schedule
      4.21            +1.1        5.35            +1.2        5.37        perf-profile.children.cycles-pp.schedule_preempt_disabled
      4.27 ±  2%      +1.4        5.67            +1.4        5.70 ±  2%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      4.41            +1.4        5.86            +1.5        5.90 ±  2%  perf-profile.children.cycles-pp.down_read
     78.66            +2.1       80.80            +2.2       80.82        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     78.60            +2.1       80.74            +2.2       80.77        perf-profile.children.cycles-pp.do_syscall_64
     10.67            +2.1       12.81            +2.4       13.06        perf-profile.children.cycles-pp.__lookup_slow
     11.22            +2.2       13.45 ±  2%      +2.5       13.71        perf-profile.children.cycles-pp.d_alloc_parallel
      2.16            +3.5        5.64 ±  2%      +3.6        5.77 ±  2%  perf-profile.children.cycles-pp.step_into
      3.82            +4.3        8.11 ±  2%      +4.4        8.24        perf-profile.children.cycles-pp.lookup_fast
      3.35            +4.5        7.81 ±  2%      +4.6        7.95        perf-profile.children.cycles-pp.try_to_unlazy
      3.33            +4.5        7.79 ±  2%      +4.6        7.93        perf-profile.children.cycles-pp.__legitimize_path
      4.24            +4.5        8.78 ±  2%      +4.7        8.96        perf-profile.children.cycles-pp.d_alloc
      3.49            +4.5        8.04 ±  2%      +4.7        8.18        perf-profile.children.cycles-pp.lockref_get_not_dead
      4.00            +4.9        8.90 ±  2%      +5.1        9.05        perf-profile.children.cycles-pp.terminate_walk
     12.88            +5.8       18.63 ±  2%      +6.1       19.01        perf-profile.children.cycles-pp.dput
     17.51            +7.8       25.35            +8.2       25.74        perf-profile.children.cycles-pp.walk_component
      0.35            +8.7        9.02 ±  2%      +8.9        9.21        perf-profile.children.cycles-pp.__dentry_kill
     19.14           +11.0       30.14           +11.5       30.66        perf-profile.children.cycles-pp.link_path_walk
     19.01           +14.6       33.62 ±  2%     +15.3       34.32        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     20.14           +14.8       34.92 ±  2%     +15.5       35.61        perf-profile.children.cycles-pp._raw_spin_lock
     27.57           +15.1       42.70           +15.8       43.42        perf-profile.children.cycles-pp.__x64_sys_openat
     27.55           +15.1       42.68           +15.8       43.40        perf-profile.children.cycles-pp.do_sys_openat2
     26.90           +15.2       42.10           +15.9       42.82        perf-profile.children.cycles-pp.do_filp_open
     26.83           +15.2       42.03           +15.9       42.75        perf-profile.children.cycles-pp.path_openat
     15.06 ±  2%      -8.4        6.62 ± 13%      -9.0        6.04 ±  7%  perf-profile.self.cycles-pp.osq_lock
      2.66            -0.5        2.14            -0.5        2.17        perf-profile.self.cycles-pp.next_uptodate_folio
      1.49            -0.4        1.05 ±  3%      -0.4        1.05 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.67            -0.3        1.40            -0.3        1.40        perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.99            -0.2        0.77            -0.2        0.76        perf-profile.self.cycles-pp.release_pages
      1.10            -0.2        0.89            -0.2        0.89 ±  2%  perf-profile.self.cycles-pp.page_remove_rmap
      0.65 ±  4%      -0.2        0.45 ±  4%      -0.2        0.45 ±  2%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      1.28            -0.2        1.08            -0.2        1.08        perf-profile.self.cycles-pp._dl_addr
      0.94            -0.2        0.76 ±  3%      -0.2        0.76        perf-profile.self.cycles-pp.up_write
      0.46 ±  3%      -0.2        0.28 ±  6%      -0.2        0.29 ±  3%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.97            -0.2        0.80 ±  2%      -0.2        0.81        perf-profile.self.cycles-pp.filemap_map_pages
      0.77            -0.2        0.62 ±  2%      -0.2        0.62        perf-profile.self.cycles-pp.down_write
      0.82 ±  2%      -0.1        0.67 ±  3%      -0.2        0.66 ±  2%  perf-profile.self.cycles-pp._compound_head
      0.88            -0.1        0.75            -0.1        0.75        perf-profile.self.cycles-pp.zap_pte_range
      0.21 ±  2%      -0.1        0.08 ±  6%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.81            -0.1        0.69            -0.1        0.69        perf-profile.self.cycles-pp.__strcoll_l
      1.03            -0.1        0.92            -0.1        0.91        perf-profile.self.cycles-pp.kmem_cache_free
      0.96            -0.1        0.86            -0.1        0.85 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.56            -0.1        0.47 ±  4%      -0.1        0.47        perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.61            -0.1        0.52            -0.1        0.51 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.60 ±  2%      -0.1        0.51 ±  2%      -0.1        0.50        perf-profile.self.cycles-pp.sync_regs
      0.59 ±  2%      -0.1        0.50            -0.1        0.50 ±  3%  perf-profile.self.cycles-pp._IO_default_xsputn
      0.50            -0.1        0.41            -0.1        0.42        perf-profile.self.cycles-pp.clear_page_erms
      0.59            -0.1        0.51 ±  2%      -0.1        0.52        perf-profile.self.cycles-pp.native_irq_return_iret
      0.55            -0.1        0.47 ±  2%      -0.1        0.48        perf-profile.self.cycles-pp.lockref_get_not_dead
      0.38 ±  2%      -0.1        0.31            -0.1        0.30 ±  2%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.44 ±  2%      -0.1        0.37            -0.1        0.38 ±  2%  perf-profile.self.cycles-pp.strnlen_user
      0.48            -0.1        0.42            -0.1        0.41 ±  2%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.33 ±  2%      -0.1        0.27 ±  2%      -0.1        0.27        perf-profile.self.cycles-pp.free_swap_cache
      0.29 ±  3%      -0.1        0.23 ±  3%      -0.1        0.23        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.38            -0.1        0.32            -0.1        0.32        perf-profile.self.cycles-pp.mtree_range_walk
      0.54            -0.1        0.48 ±  2%      -0.1        0.47        perf-profile.self.cycles-pp.mod_objcg_state
      0.18 ±  4%      -0.1        0.13 ±  2%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.44            -0.1        0.39            -0.1        0.38 ±  3%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.37 ±  2%      -0.1        0.32            -0.1        0.32 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.28 ±  2%      -0.1        0.22 ±  2%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.19 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__rb_erase_color
      0.25 ±  3%      -0.0        0.20 ±  4%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp._IO_fwrite
      0.28            -0.0        0.24 ±  3%      -0.0        0.25 ±  2%  perf-profile.self.cycles-pp._IO_padn
      0.14 ±  9%      -0.0        0.10 ± 24%      -0.0        0.09 ± 19%  perf-profile.self.cycles-pp.osq_unlock
      0.30            -0.0        0.26 ±  2%      -0.0        0.25 ±  2%  perf-profile.self.cycles-pp.set_pte_range
      0.27 ±  3%      -0.0        0.23 ±  5%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.memset_orig
      0.25 ±  2%      -0.0        0.21 ±  3%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.mas_next_slot
      0.31 ±  3%      -0.0        0.27            -0.0        0.27        perf-profile.self.cycles-pp.___perf_sw_event
      0.24            -0.0        0.20 ±  2%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.22 ±  2%      -0.0        0.18 ±  2%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.mmap_region
      0.58            -0.0        0.54 ±  2%      -0.0        0.54        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.21            -0.0        0.17 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.11 ±  4%      -0.0        0.07 ± 10%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.apparmor_file_open
      0.16            -0.0        0.13 ±  5%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.20            -0.0        0.17 ±  4%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.17 ±  2%      -0.0        0.14 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.17 ±  4%      -0.0        0.14 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.link_path_walk
      0.23 ±  4%      -0.0        0.20 ±  2%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
      0.14 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.down_read_trylock
      0.09 ± 15%      -0.0        0.06 ±  6%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.inode_permission
      0.16 ±  3%      -0.0        0.14 ±  7%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.strncpy_from_user
      0.17 ±  2%      -0.0        0.14 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp._IO_file_xsputn
      0.34            -0.0        0.32 ±  2%      -0.0        0.32 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.13 ±  5%      -0.0        0.11 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__fput
      0.15 ±  4%      -0.0        0.12 ±  6%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp._copy_from_user
      0.21            -0.0        0.18 ±  6%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.19            -0.0        0.17 ±  4%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      0.22 ±  2%      -0.0        0.20            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.09 ±  5%      -0.0        0.07 ±  6%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.vm_area_dup
      0.13 ±  2%      -0.0        0.11 ±  3%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.14 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.handle_mm_fault
      0.14 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.malloc
      0.18 ±  2%      -0.0        0.16 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.12 ±  4%      -0.0        0.10 ±  6%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.12 ±  5%      -0.0        0.10 ±  7%      -0.0        0.10        perf-profile.self.cycles-pp.__get_user_8
      0.20            -0.0        0.18 ±  4%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__memcpy
      0.10 ±  4%      -0.0        0.08            -0.0        0.08        perf-profile.self.cycles-pp.rcu_all_qs
      0.08 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.apparmor_mmap_file
      0.09 ±  6%      -0.0        0.07 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.unmap_page_range
      0.12            -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_wr_walk
      0.11 ±  3%      -0.0        0.10 ±  5%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.unmap_vmas
      0.09 ±  6%      -0.0        0.07 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.09 ±  5%      -0.0        0.07            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.unmap_single_vma
      0.08            -0.0        0.06 ±  7%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.11 ±  4%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_rev_awalk
      0.13 ±  5%      -0.0        0.11 ±  3%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.09            -0.0        0.08 ±  6%      -0.0        0.08        perf-profile.self.cycles-pp.__free_one_page
      0.13 ±  3%      -0.0        0.11 ±  6%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.mas_walk
      0.11 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.11 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.09 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__pte_offset_map
      0.08 ±  4%      -0.0        0.06 ±  7%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.anon_vma_clone
      0.18 ±  6%      -0.0        0.17 ±  4%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.07            -0.0        0.06 ±  8%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.17 ±  2%      -0.0        0.16 ±  3%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.08 ±  4%      -0.0        0.06 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__split_vma
      0.08 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__perf_sw_event
      0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.mas_preallocate
      0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__snprintf_chk
      0.06 ±  7%      -0.0        0.05            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.08 ±  5%      -0.0        0.07            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.vm_normal_page
      0.08 ±  5%      -0.0        0.07            -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.08 ±  5%      -0.0        0.07            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.generic_permission
      0.07            -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.08 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06        perf-profile.self.cycles-pp.perf_output_begin
      0.08 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__libc_fork
      0.09 ±  5%      -0.0        0.08 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
      0.07 ±  5%      -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp.mas_pop_node
      0.06 ±  7%      -0.0        0.05 ±  8%      -0.0        0.05        perf-profile.self.cycles-pp.d_path
      0.06 ±  6%      -0.0        0.05            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__check_object_size
      0.08 ±  4%      -0.0        0.07            -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.dup_mmap
      0.08 ±  4%      -0.0        0.07            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.24 ±  3%      -0.0        0.23 ± 22%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.08 ±  5%      -0.0        0.08 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mas_prev_slot
      0.07            -0.0        0.06            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.copy_strings
      0.09 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.mas_topiary_replace
      0.08 ±  5%      -0.0        0.08 ±  6%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap_event
      0.06 ±  7%      -0.0        0.05 ±  8%      -0.0        0.05        perf-profile.self.cycles-pp.lru_add_fn
      0.06            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.06            -0.0        0.05 ±  7%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.mab_mas_cp
      0.06            +0.0        0.07            +0.0        0.07        perf-profile.self.cycles-pp.llist_reverse_order
      0.22 ±  2%      +0.0        0.24 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.13 ±  2%      +0.0        0.14 ±  2%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.newidle_balance
      0.14 ±  4%      +0.0        0.16 ±  4%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.05 ±  8%      +0.0        0.07 ±  5%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.resched_curr
      0.12            +0.0        0.14 ±  3%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.14 ±  6%      +0.0        0.16 ±  3%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      0.18 ±  2%      +0.0        0.20 ±  3%      +0.0        0.20 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.16 ±  6%      +0.0        0.18 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.update_sd_lb_stats
      0.11 ±  4%      +0.0        0.13 ±  2%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.release_empty_file
      0.14 ±  4%      +0.0        0.16            +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.update_rq_clock
      0.15 ±  6%      +0.0        0.17 ±  2%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.find_busiest_queue
      0.12 ±  4%      +0.0        0.14 ±  4%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.load_balance
      0.09 ±  5%      +0.0        0.11 ±  3%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.llist_add_batch
      0.20 ±  3%      +0.0        0.24 ±  2%      +0.0        0.24 ±  4%  perf-profile.self.cycles-pp._find_next_and_bit
      0.07 ±  6%      +0.0        0.11 ±  3%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.12 ± 11%      +0.0        0.16 ±  6%      +0.0        0.16 ± 12%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.29 ±  3%      +0.0        0.33 ±  2%      +0.0        0.33 ±  3%  perf-profile.self.cycles-pp.cpu_util
      0.18 ±  5%      +0.0        0.22 ±  4%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.d_alloc
      0.13 ±  5%      +0.0        0.18 ±  2%      +0.1        0.19 ±  5%  perf-profile.self.cycles-pp.down_read
      0.00            +0.1        0.05 ±  7%      +0.0        0.04 ± 45%  perf-profile.self.cycles-pp.__d_add
      0.00            +0.1        0.06            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__d_lookup_unhash
      0.00            +0.1        0.06            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.___d_drop
      0.32 ±  3%      +0.1        0.39 ±  2%      +0.1        0.40 ±  2%  perf-profile.self.cycles-pp.idle_cpu
      0.09 ±  4%      +0.1        0.17 ±  2%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.00            +0.1        0.08 ±  6%      +0.1        0.08        perf-profile.self.cycles-pp.__d_rehash
      1.72            +0.1        1.86            +0.1        1.86        perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.2        0.16 ±  2%      +0.2        0.16 ±  3%  perf-profile.self.cycles-pp.__dentry_kill
      0.20 ±  3%      +0.3        0.48            +0.3        0.47 ±  3%  perf-profile.self.cycles-pp.d_alloc_parallel
      1.33            +0.3        1.61            +0.3        1.61        perf-profile.self.cycles-pp.acpi_safe_halt
      1.90            +0.4        2.26 ±  2%      +0.4        2.27        perf-profile.self.cycles-pp.update_sg_lb_stats
     18.76           +14.4       33.21 ±  2%     +15.1       33.90        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b212a65ed190..d4a95e690771 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1053,16 +1053,14 @@ void d_prune_aliases(struct inode *inode)
>  }
>  EXPORT_SYMBOL(d_prune_aliases);
>  
> -static inline void shrink_kill(struct dentry *victim)
> +static inline void shrink_kill(struct dentry *victim, struct list_head *list)
>  {
> -	do {
> -		rcu_read_unlock();
> -		victim = __dentry_kill(victim);
> -		rcu_read_lock();
> -	} while (victim && lock_for_kill(victim));
>  	rcu_read_unlock();
> -	if (victim)
> +	victim = __dentry_kill(victim);
> +	if (victim) {
> +		to_shrink_list(victim, list);
>  		spin_unlock(&victim->d_lock);
> +	}
>  }
>  
>  void shrink_dentry_list(struct list_head *list)
> @@ -1084,7 +1082,7 @@ void shrink_dentry_list(struct list_head *list)
>  			continue;
>  		}
>  		d_shrink_del(dentry);
> -		shrink_kill(dentry);
> +		shrink_kill(dentry, list);
>  	}
>  }
>  
> @@ -1514,7 +1512,7 @@ void shrink_dcache_parent(struct dentry *parent)
>  				spin_unlock(&data.victim->d_lock);
>  				rcu_read_unlock();
>  			} else {
> -				shrink_kill(data.victim);
> +				shrink_kill(data.victim, &data.dispose);
>  			}
>  		}
>  		if (!list_empty(&data.dispose))

