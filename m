Return-Path: <linux-fsdevel+bounces-3903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37FF7F9A6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7971C20856
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4154CE574;
	Mon, 27 Nov 2023 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7wi7k2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4180085;
	Sun, 26 Nov 2023 22:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701068348; x=1732604348;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xe4Xi5gXR2H9XmyO15Pgk4mQnqBOvrVaE+MOrVxptlc=;
  b=Q7wi7k2Q34uc94gOeONnZuv2YGddYYbkSs2m2wjo1pUmrRl8UMaFx7iA
   SZnmhGsH1hYpbiNMt6YbHmTB+NFy4Z1VAR07mTbZK/V/B1kbxY+MuqE4y
   AaaLPYfX+bVLQOJme5wAq6NKFh+48uezdKxt4zBmJj/jMFi+4l+Ol5pKt
   YMD/wNsqnFjBNeJW76Fj39mDOJq9jS5oI2v8pLXZuglAmy62/hjQJfNyU
   Be8geiDxLIe5RohWBWh7x0tOjnJLeNGr6BC6KlMeRim5815g4ZK61Q84R
   BrYLqrPO/fmz2pH60mbC4GvDVvTF23+pj27I5NFGdp76Umnq/SEAIfqUa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="389793406"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="389793406"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="1099668690"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="1099668690"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2023 22:59:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 22:59:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 26 Nov 2023 22:59:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 26 Nov 2023 22:59:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHzBXZ4lCxeBaa1nOfD+GiTjeiiKyOndTPs1e341W9/9qh4QdlcnJkdW29BOJdt6Tut/lnN+Cpo5+pKgBauyQID0Drp62zreP6GevrPZq2WVtC1mIXeJE4NgZykPrjQNcFr0yl0QHJBcunSSIMx3GK/7/pejT334IaechxzcjT30p3v82+pQCd/+vtdtytWpZx0pdAemUPtvEPlEuLZzkdHcUWWpQUKCTxQ2ehuRcNO5Q9DLY4cds/2EpxGaejFvgbyFhmFbGipC7YGH7X9YnSYOCn0tM+1YP3RwvM6iUCJCfxtd+791zsB+1x4UjS9He++SotSMobQVzaWscAPitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMPKSpXCMyQxIpt1/2JXLbxExKwK9EgLaNOdqAtEbkw=;
 b=kCjOoBe9eZmdw0AiXYxwaqiK6doGveJC9Zf6hT4hPNTxG26dlJofgT1W6RJM6cExqgq99FWmfRH4cMFfXFebkeVUhJZk3xJjrpGvmT64/ZH4HB1LQ3OTq5pZbRafD1ynb/L1FNbwcmy0zpSaqAvTMH7uXFkVH/L9PVKhRsxaM6rY/KYuBs0I3IVDEzvFZVQ77GHy2kqm8A+nYrHirdk3Gq+YeOGTxKZYm/3SFCdhfJj76pqZhRb/wqXo3oueO9A7hQWHqaVxYTMSA48FjA61uhrvESlaOKOboGzV0ozAKXJWV4r+S+9rZThHnSYE+AC/7Bz5wYEBsX6j/j3QIOA86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 06:59:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Mon, 27 Nov 2023
 06:59:04 +0000
Date: Mon, 27 Nov 2023 14:58:52 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Christian Brauner <brauner@kernel.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Jann Horn
	<jannh@google.com>, <linux-doc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <intel-gfx@lists.freedesktop.org>,
	<linux-fsdevel@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<bpf@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [file] 0ede61d858: will-it-scale.per_thread_ops
 -2.9% regression
Message-ID: <ZWQ+LEcfFFi4YOAU@xsang-OptiPlex-9020>
References: <202311201406.2022ca3f-oliver.sang@intel.com>
 <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
 <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 595b2815-026c-4ab1-532d-08dbef16568c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQVoKt5VuZWSTX0aiJV1KTgZk+IqOhXO54TaKfK/D2WuT/yCOqOmtOCFGHGGlzRgLqhfREi5NErIEBgwoPOYDTxMhAGRFbUlMWhj2Z2zzHELjudkuIii/R8ZyehvImWPrQA6A8rig5zSCJcOAf0k6ojA9Mr4F9DDBeXoJ+cMYMX4B1od4obxm/V11WvVNhDqaA/TGZsDPX8yKlh+nuYYh08c2q0ERgBB00fTWhg0alF6DSSxDVov0Ce1covrD6siQkDoHmFhjE+Oxqh2SMLsKasvoQx2E/IvZIPwoOXENKBbr9/0UdyAfx9GVfRWYOQJURE5Vv+WQ0BWdvpIjUHh2bs5ydjo27QQ3fCpFRyqny3esj/PqtTGdUNgWwak6qZwPNwuQvtdIvlG0O5pq5EA3gs3XSHX0rtHtomzzBEcXAPTGCHXJAp9aT5jEOlNVRk2oPkLXkDnj5sIH6YbsYsAnvjiLCC6kF3yR4Q/CJcUHRztuMVoly9OOiH9ES3gvsyvj4QbseN5XDdnwPtQF79vHJPtfZfJDejgdmtRubha5XZM80K34Q9Sv8Nl0+Oukz4imVkwIMza34UvG98751Y1pKvkhj4L4/azcoZ76EvDBmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(38100700002)(82960400001)(9686003)(6512007)(6506007)(6666004)(4326008)(8936002)(66556008)(66946007)(316002)(6486002)(54906003)(6916009)(66476007)(5660300002)(44832011)(7416002)(8676002)(478600001)(86362001)(19627235002)(41300700001)(2906002)(33716001)(26005)(107886003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FaYHz5sP5efG8WeNg+b63qT4Qrn6WKoOzD6HALty1qNoqdJ+wU9UMjSxou?=
 =?iso-8859-1?Q?EQ2+oDWGtDkco7Na526selGL5Q7O44z2p+auBttuxBMQGnwdJVdWCMDm8D?=
 =?iso-8859-1?Q?XyfDS5iFuFikOrNEdOTt/hAAVQRwY0mmtmvuJ1ZQRCcdYVL1lHLOckB+ja?=
 =?iso-8859-1?Q?DClU6qKFulEzg4QAfB0LCGQFP1NylND8QD91Ui7FYoqLv2HjYTi6n+8avm?=
 =?iso-8859-1?Q?QNmBq1QtV/pF0Wy+F+fpMU9k7GJlacbR9qm51blQITvF0lb/I8YyUiWSF6?=
 =?iso-8859-1?Q?8wB9ydR8NLohKpJ9PBV5v6oLJCaRvaQT9iAm7AkH3KvxAucANOz/N6Swvh?=
 =?iso-8859-1?Q?shZ0RPje/azd/WBfe8TMI84218Mh3rhJYgFiXWgYVXuwtFLEqFHyPXY17p?=
 =?iso-8859-1?Q?Dm/l53JeNFhvUAzHbLOCYdz13XmOIHdEGARD18QlulqsI1967g5/YATF+W?=
 =?iso-8859-1?Q?2FFL1/BDup0GxHUGuLYijbCGua0XLauXNIcNXTQryfTK5GH9KPIQfSCwD8?=
 =?iso-8859-1?Q?zEao5T1h0rdlzKMsG2QUQUn1XpdzmfFDKmTw2t6N7RMoKTYrfjPKOL8Lbo?=
 =?iso-8859-1?Q?xc4VizeiZWnU9yWg33LDZH2Nxu48x8ZUiVn2Z+w38fJCt5qFPMK+KJmod9?=
 =?iso-8859-1?Q?3PPy1rXTpNWiDRqSgc6YM/3YKNHoUvYHNZVK3FejinJ1y1LxheHbQQVMtD?=
 =?iso-8859-1?Q?yeyMoi//AwqYZGJA6B/7pxF1LzUY6GPeYn7xP4ZcQxfxLxGYnt1HVwTCg9?=
 =?iso-8859-1?Q?BguMTvNdZDXb8mIT/1IaC5GBOURPL0IJctObgvBMbWj/e6ytGyTBEsYNn7?=
 =?iso-8859-1?Q?tYI7JeHs1p4BSH3bPuM+ukOTgnZ0Gq41i5O5AtqaDWVzS5hT8FdbWh/Txk?=
 =?iso-8859-1?Q?DEqZLG8T+8OgCdx8Ebgk3Lm32IpzEgVikiuaMB+TRd7F+z4L9GZ2OxAOTO?=
 =?iso-8859-1?Q?//cuXN9Y+w/CaMWfO1OygUX1/PPYUXkC39kkRiuJZyklD1YNixQ45dVenE?=
 =?iso-8859-1?Q?HHjn2OOZiNBxN+VK5Yc/B0T/CuR50OJcX/NDi6Jrm40HIr33zQ4K6x5Q/+?=
 =?iso-8859-1?Q?RRl5I9unx2vXMPe/k+7j95ji9ZF+ynOub/pl2qwjcyxMs7PoFH2jJ0brmF?=
 =?iso-8859-1?Q?Ita90T8oP8wTkCVnbMvG6kIH1TCusLJw2sIfF1lxQ2KRM1crMf9NQuF1V7?=
 =?iso-8859-1?Q?Ys/78SKvZqgXf7/C1GdzEZA03ON1SRFL/P8WssuKPN50Vv8D1HRL0KuRuz?=
 =?iso-8859-1?Q?7yjmdja9RJDJYenGBmISwPXSg1jLA4//xngHcHyy19lXca5JR0bvNzOIrt?=
 =?iso-8859-1?Q?FADP//IBH4rtoQFu8mMNBiaYRVbJvJVIqdgzBgbvLJCDbB9pXavdX/YFCy?=
 =?iso-8859-1?Q?EC9G5jZYCRv8i8b7v7eOW9EKLwkwpa15ohfu9SEkPqsanrJAmunt1TusiI?=
 =?iso-8859-1?Q?YaKUtLsbR0ZCUAhFk2rAapvjZiP0iPNzKgCYajN1SqZWxFOH2Np2TIEjuX?=
 =?iso-8859-1?Q?OKr4bp24vWs1jVGfK+W3LomlK+6CHgdp3+YlAXkV26AMtu3f2f3nbx01rC?=
 =?iso-8859-1?Q?vc1DzGV6Vuea1vWnbX8rHm4g3YS2R21VEO28ZF7FJ4fCOFcGJwQC4PSAcE?=
 =?iso-8859-1?Q?UHhnLw6NYn3YBLvZd/8c40tHJfs+V2yKvFefiQJJFxQmcl1pYStcpADA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 595b2815-026c-4ab1-532d-08dbef16568c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 06:59:02.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PlgihOOf85Bm8oMn6Qu2w6nyGF21GfH56NDVglvFaXttAOdRMdwbMTDQeHzNlz7cCnXpzJx5aSodDH5yfJO/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com

hi, Linus,

On Sun, Nov 26, 2023 at 03:20:58PM -0800, Linus Torvalds wrote:
> On Sun, 26 Nov 2023 at 12:23, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > IOW, I might have messed up some "trivial cleanup" when prepping for
> > sending it out...
> 
> Bah. Famous last words. One of the "trivial cleanups" made the code
> more "obvious" by renaming the nospec mask as just "mask".
> 
> And that trivial rename broke that patch *entirely*, because now that
> name shadowed the "fmode_t" mask argument.
> 
> Don't even ask how long it took me to go from "I *tested* this,
> dammit, now it doesn't work at all" to "Oh God, I'm so stupid".
> 
> So that nobody else would waste any time on this, attached is a new
> attempt. This time actually tested *after* the changes.

we applied the new patch upon 0ede61d858, and confirmed regression is gone,
even 3.4% better than 93faf426e3 now.

Tested-by: kernel test robot <oliver.sang@intel.com>

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/16/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/poll2/will-it-scale

commit:
  93faf426e3 ("vfs: shave work on failed file open")
  0ede61d858 ("file: convert to SLAB_TYPESAFE_BY_RCU")
  c712b4365b ("Improve __fget_files_rcu() code generation (and thus __fget_light())")

93faf426e3cc000c 0ede61d8589cc2d93aa78230d74 c712b4365b5b4dbe1d1380edd37
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    228481 ±  4%      -4.6%     217900 ±  6%     -11.7%     201857 ±  5%  meminfo.DirectMap4k
     89056            -2.0%      87309            -1.6%      87606        proc-vmstat.nr_slab_unreclaimable
     16.28            -0.7%      16.16            -1.0%      16.12        turbostat.RAMWatt
      0.01 ±  9%  +58125.6%       4.17 ±175%  +23253.5%       1.67 ±222%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    781.67 ± 10%      +6.5%     832.50 ± 19%     -14.3%     670.17 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     97958 ±  7%      -9.7%      88449 ±  4%      -0.6%      97399 ±  4%  sched_debug.cpu.avg_idle.stddev
      0.00 ± 12%     +24.2%       0.00 ± 17%      -5.2%       0.00 ±  7%  sched_debug.cpu.next_balance.stddev
   6391048            -2.9%    6208584            +3.4%    6605584        will-it-scale.16.threads
    399440            -2.9%     388036            +3.4%     412848        will-it-scale.per_thread_ops
   6391048            -2.9%    6208584            +3.4%    6605584        will-it-scale.workload
     19.99 ±  4%      -2.2       17.74            +1.2       21.18 ±  2%  perf-profile.calltrace.cycles-pp.fput.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      1.27 ±  5%      +0.8        2.11 ±  3%     +31.1       32.36 ±  2%  perf-profile.calltrace.cycles-pp.__fdget.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
     32.69 ±  4%      +5.0       37.70           -32.7        0.00        perf-profile.calltrace.cycles-pp.__fget_light.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.00           +27.9       27.85            +0.0        0.00        perf-profile.calltrace.cycles-pp.__get_file_rcu.__fget_light.do_poll.do_sys_poll.__x64_sys_poll
     20.00 ±  4%      -2.3       17.75            +0.4       20.43 ±  2%  perf-profile.children.cycles-pp.fput
      0.24 ± 10%      -0.1        0.18 ±  2%      -0.1        0.18 ± 10%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.48 ±  5%      +0.5        1.98 ±  3%     +30.8       32.32 ±  2%  perf-profile.children.cycles-pp.__fdget
     31.85 ±  4%      +6.0       37.86           -31.8        0.00        perf-profile.children.cycles-pp.__fget_light
      0.00           +27.7       27.67            +0.0        0.00        perf-profile.children.cycles-pp.__get_file_rcu
     30.90 ±  4%     -20.6       10.35 ±  2%     -30.9        0.00        perf-profile.self.cycles-pp.__fget_light
     19.94 ±  4%      -2.4       17.53            -0.3       19.62 ±  2%  perf-profile.self.cycles-pp.fput
      9.81 ±  4%      -2.4        7.42 ±  2%      +1.7       11.51 ±  4%  perf-profile.self.cycles-pp.do_poll
      0.23 ± 11%      -0.1        0.17 ±  4%      -0.1        0.18 ± 11%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.44 ±  7%      +0.0        0.45 ±  5%      +0.1        0.52 ±  4%  perf-profile.self.cycles-pp.__poll
      0.85 ±  4%      +0.1        0.92 ±  3%     +30.3       31.17 ±  2%  perf-profile.self.cycles-pp.__fdget
      0.00           +26.5       26.48            +0.0        0.00        perf-profile.self.cycles-pp.__get_file_rcu
 2.146e+10 ±  2%      +8.5%  2.329e+10 ±  2%      -2.1%  2.101e+10        perf-stat.i.branch-instructions
      0.22 ± 14%      -0.0        0.19 ± 14%      -0.0        0.20 ±  3%  perf-stat.i.branch-miss-rate%
 2.424e+10 ±  2%      +4.1%  2.524e+10 ±  2%      -4.7%  2.311e+10        perf-stat.i.dTLB-loads
 1.404e+10 ±  2%      +8.7%  1.526e+10 ±  2%      -6.2%  1.316e+10        perf-stat.i.dTLB-stores
     70.87            -2.3       68.59            -1.0       69.90        perf-stat.i.iTLB-load-miss-rate%
   5267608            -5.5%    4979133 ±  2%      -0.4%    5244253        perf-stat.i.iTLB-load-misses
   2102507            +5.4%    2215725            +5.7%    2222286        perf-stat.i.iTLB-loads
     18791 ±  3%     +10.5%      20757 ±  2%      -1.8%      18446        perf-stat.i.instructions-per-iTLB-miss
    266.67 ±  2%      +6.8%     284.75 ±  2%      -4.1%     255.70        perf-stat.i.metric.M/sec
      0.01 ± 10%     -10.5%       0.01 ±  5%      -1.8%       0.01 ±  6%  perf-stat.overall.MPKI
      0.19            -0.0        0.17            +0.0        0.20        perf-stat.overall.branch-miss-rate%
      0.65            -3.1%       0.63            +6.1%       0.69        perf-stat.overall.cpi
      0.00 ±  4%      -0.0        0.00 ±  4%      +0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
     71.48            -2.3       69.21            -1.2       70.24        perf-stat.overall.iTLB-load-miss-rate%
     18757           +10.0%      20629            -3.2%      18161        perf-stat.overall.instructions-per-iTLB-miss
      1.54            +3.2%       1.59            -5.8%       1.45        perf-stat.overall.ipc
   4795147            +6.4%    5100406            -9.0%    4365017        perf-stat.overall.path-length
  2.14e+10 ±  2%      +8.5%  2.322e+10 ±  2%      -2.1%  2.094e+10        perf-stat.ps.branch-instructions
 2.417e+10 ±  2%      +4.1%  2.516e+10 ±  2%      -4.7%  2.303e+10        perf-stat.ps.dTLB-loads
   1.4e+10 ±  2%      +8.7%  1.522e+10 ±  2%      -6.3%  1.312e+10        perf-stat.ps.dTLB-stores
   5253923            -5.5%    4966218 ±  2%      -0.5%    5228207        perf-stat.ps.iTLB-load-misses
   2095770            +5.4%    2208605            +5.7%    2214962        perf-stat.ps.iTLB-loads
 3.065e+13            +3.3%  3.167e+13            -5.9%  2.883e+13        perf-stat.total.instructions

> 
>                   Linus


