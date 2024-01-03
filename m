Return-Path: <linux-fsdevel+bounces-7158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B47822831
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 07:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEC3284F82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 06:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809C6179AF;
	Wed,  3 Jan 2024 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tpd0g5IZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5711798C;
	Wed,  3 Jan 2024 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704261862; x=1735797862;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=KEZg83sQfnFtZJz7PKA0HT79BIuwdF5ywL+ZgNgVK/U=;
  b=Tpd0g5IZDX8yc6wIYad7Du1r1ZkDCpXyq7lp8B4tes9apnhhHD4KZ2Sf
   6yBnoaI9nv3NumdgZKRC6wRuLV3MYBm7Hg6dPDM6Fp8EwE0vhXbb4YBeW
   DtCQkNg+9qqF/qpmEtgdODdJGqnvs1NFdJvI33XiCHBWRtePVRTadt8kO
   k+048omzbPe5/JltMKoNAWslL7eCxML83wUNjRY/R5//lAlUUOU9DRQzt
   e7xCQzdBfZSapROGX7F5gjHQ0b80XL2QJhCqWC3MytfOIGYjOilMrxcga
   AeRtQz6LGBr1QVZ0keVkQ9VT+FE8F/VF254kl8He4oqfWqiG7eX1DXW6H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="376452205"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="376452205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 22:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="953131688"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="953131688"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 22:04:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 22:04:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 22:04:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 22:04:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePsDIaaF9iD6GkLDxc7eqOoOqmXHzaLEwuQcyhiMFl+CYe7oyeDxsD/xQaCtFkxpLTUw9iO/CJYY5LIbJn23wh4Aq4j1/OkqtkdCTpoZ4YlHto67w08eQStVi2h5iq0upDWN4Kdftg1GsAppFT2PffUpOZXJaGxRITYHWisOWmZggPvajgef+gutvj67ca1Q0BnoIH8GT6AMYU3tQfWrWwEhbXyzoYfgvwOBUA1+sit+NfBdduiXxBaAUyB8abIT3vuM5sZHsDV+z5kQmUJsqZduFLv+GO88GM1+Sf5Waq0lxIle1iiWuZoUBy+KmyJXJQoMyvAKv5fdxLJLr41oVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo4e+Kc6Em9vKAGLDc08exLiw1x8glqxPlKrc30TtN4=;
 b=mbgGipCKwR4oIc1SevTfwinIcbWprAJYhOvgicoCkuwD9yZ44cx5FaMsNzAxp8ea5s/KOwc/P3ORcJhA2pGnD34OKtKuRL4kJMpuABxANwAJrxe8F6XW6xdHjQ2FE7vAM0YyDzep4zSV11TW7PlgzQ7EWvkR1oiG3ZUIYbMlKsbrzC9GOn1qYLIfPSvJg56+1ZTdhSlP08PdI5r+I+/atbbEwAOo5bDVUM9yUaUNHcQNGuD8gxO+naidYrk84PffKmHeNRQ0r/cYBx1Hpj8RBRh/wvq8a1ePZirlSLSKZY4/775fAX1vQh13FAUGVEqypMOLyVnxlvBiV10PhzU5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 06:04:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 06:04:12 +0000
Date: Wed, 3 Jan 2024 14:03:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
	Maria Yu <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
	<quic_pkondeti@quicinc.com>, <keescook@chromium.or>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <oleg@redhat.com>,
	<dhowells@redhat.com>, <jarkko@kernel.org>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <keyrings@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Message-ID: <202401031032.b7d5324-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZY30k7OCtxrdR9oP@casper.infradead.org>
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 533de969-e7a4-4997-0aab-08dc0c21ceb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/RTJwkY7he6QRYfDWrQBKlpicX7ZfaXkA8dPyGE0eOMVVDEtQK3NvnwHkAGfrgqcIB8NFrSYko84v0KcJfU4ioiyG2gbnawDQNVB+OczGpvcSl6CC0SGgRev/pU0WJQiUHLGb2xn1NeFx3ohbCvo7eRl3qc3HjnOSxXORQRFzG6iYAt+SYKoYotUfpVZE/sobKJJ74Z4GYFMt4U5sA0dLKvE413hXHA5YPXsJ/Q1NBEQcIw1E+7uYHMOEbboQ705N7ThRRqjT/ifEyDjse2CMsTgoiRHfvSCqs7xV+APtB0fd7I9bDRqbaItBna4bRXQLbPcpwEmkR7vosZuPOU7HyNvqXK67snd/TdZfm8ZS1KjEQy/YS9zC9BYu37ioAdYeYYOQXzsWcaKb15z14Mar9iFez6bN35DVpAX8Cgk46izlm/cRVBeULe66t+4+mdz6lbkSNg0K6liff9NySOX/sWxls5qS2uer8icxNHnsRgB3umY01RSn1YKhi9jCeZaQ0hKX0RLRw7kcvrkDtDgfvmhdvZjIUVNfO123XGQIyWCJ1Qz7KK8gx9G2eGgOk0eSvLvinF9KjPSaxyI6ezFOVjqycLkGN9auF5nHvJJy6tioLhgqt+d1KS1bOrQSCyBItxEe68v9cB9Ahe0PZgwqF/JaiICJCCkCc7IQMf4+BPH0jNEg7tzNq8HYeggFu0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2906002)(8676002)(8936002)(83380400001)(38100700002)(26005)(7416002)(30864003)(5660300002)(1076003)(82960400001)(2616005)(107886003)(966005)(478600001)(6666004)(6506007)(6486002)(6512007)(41300700001)(36756003)(66946007)(66476007)(6916009)(86362001)(66556008)(316002)(54906003)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3d2++IKJXeVvc7CIs7hrCb1I0CfqsVfQX7LHfPP3Bj9Jy7MMQOL2o/urxbJ?=
 =?us-ascii?Q?4v+4JS2185a7pgtnDk24Dgu/BqoG6XB1RN4nC6oDf9JK7Ji+e5LYZtObQOaE?=
 =?us-ascii?Q?Kn8WoWnHp+ZiABZNIUcCHTEAozgoDVLpMNjLFh2xcvYlVXnaZE0oMaKX/+7h?=
 =?us-ascii?Q?3xaLNNRI3rv9xYcSGdIMfiBPrZYL9ggYLX7cvsgLWrHrt1Ex6VID9VtE/TP5?=
 =?us-ascii?Q?fHIl/5IOVHrDwBHgHx156yjVcPivmLymVxnY2AaO5frRB+f1uBqNmU1QZtGc?=
 =?us-ascii?Q?BNR5gLVsyMUc9hNM7ELHwMicqAWt+xkVcoMAndrPkFTJGo8ufnWaLjwO8SJU?=
 =?us-ascii?Q?+2NSHYjk6P3bmTXX/EHhQjPRXV++4yxRC3j/tdJuF+ipYHyZb5zvblVdNoUs?=
 =?us-ascii?Q?CrItwhEE0AGQm5pj8jtADGkAu74ZHOiNuGxuM1VMv/ElB5bR5e9GmLUPPoyX?=
 =?us-ascii?Q?uULrOuJgxwQUAq31Rsuuj6o0Uvh9rVPViloMALmOL/ZZtc5i9qv2/+45yys0?=
 =?us-ascii?Q?Qg58mnTIALVXMdBuaLFrj2cdHvpOcruAc6Xg4PcQTpdQN/g6nEVl3SvI0+Hu?=
 =?us-ascii?Q?NLOzUTcvKO+76vRi9ZcwcJUGUP6F1hsTFNaDiFD9j9N8m74XKD2sWvqYWE0d?=
 =?us-ascii?Q?2h77VIsN61SZDKMYrQBh/uZauk0HAboKcYPdU+bKrTo7+dlKAdCfBd5d9Y3d?=
 =?us-ascii?Q?6Nfh5m0GvDdj7VaNLZXTIMFDxSjGhzaoV9n0q1UrUejUYjiDYxTh6dTOGxnh?=
 =?us-ascii?Q?t1Seu/3oY/gW+u30N5BTqIjsgQYC4wjwfP5eUtZcc7hBcRLAwfpJxRRbZDSB?=
 =?us-ascii?Q?Z1svYRkaJfIDoYWknqeUscAWFypjq2DrqqjxzATZSoxlpya66mAPwKdyd1+O?=
 =?us-ascii?Q?NMDBscv0Ua+lovDuC4FdzGlw2JDipm9mJmsTxQnHgq6Nnci+B7Ma/1HQoiul?=
 =?us-ascii?Q?3MxUoUMkeODDz4DmxfabB7yGGu2q/9AEBVxMV0NHp4YT0BrH8iAo9eCrEnKO?=
 =?us-ascii?Q?fvoMW/GZ04d2FHG+1g+9ZLPiVwBTriz+gEkWmcbErITsAeIgO9FIUqZonG3d?=
 =?us-ascii?Q?32boDxJHS+PQDnpvUMzs5CZdz6qHEl8udTnsLTAAeq/fqi2HQZryk+Oj1Owq?=
 =?us-ascii?Q?bp4zWziZf96m969JK33vJwFBYZ7DKwfBmWVFMe8JKZPkkg7IMSxZjm3ryZzj?=
 =?us-ascii?Q?+NXkOrRXA0qNPb3SNFvv5S3zK0mAKWv1uregH8z9OmHWEHrXuKZM97RmP2Ni?=
 =?us-ascii?Q?H+PE1XoLS4Sp8nBdI2URnJFGz9zwyqtN47+vVNrWSxB2ip5o0ggBNDvUfm0Q?=
 =?us-ascii?Q?52FTP0usFvzIayH5n8KACYel823vMK9xbM9LS7irBOw4LBWnaLNfI8ZnP/KL?=
 =?us-ascii?Q?yMdxC3VqO/GlCdyOk7IzdsE83RoTBkInm1pnTnNIV8AfLsrs6nMRCQF4L8aN?=
 =?us-ascii?Q?kEKEj5Ixf9tlWTdpY4ChUkk16PDcvN4PXVGnyuYw4An2Ai6R3xBqYgf8SPvM?=
 =?us-ascii?Q?UB/bIDkuQUUol7hRiVXZwhOllxG86ARTRJIf5R+qxY6pK1xzN/gsv8L7UHUc?=
 =?us-ascii?Q?5Or3g5f1DuNcRzza6A1WPi0ozP2JX1/MlEOSpqJTvXjr55/AuGLtGLo7tY+T?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 533de969-e7a4-4997-0aab-08dc0c21ceb6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:04:12.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBX/kM1Alc0qOfXHgLTdyGIllyCXFrQG9cj7rMK/XN5e5SavGmlPKEa9ORveS7wXyVDejpbuo7PwJUO/rP8uAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:inconsistent_lock_state" on:

commit: 30ebdbe58c5be457f329cb81487df2a9eae886b4 ("Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for tasklist_lock")
url: https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox/Re-PATCH-kernel-Introduce-a-write-lock-unlock-wrapper-for-tasklist_lock/20231229-062352
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git a51749ab34d9e5dec548fe38ede7e01e8bb26454
patch link: https://lore.kernel.org/all/ZY30k7OCtxrdR9oP@casper.infradead.org/
patch subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for tasklist_lock

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------+------------+------------+
|                                                     | a51749ab34 | 30ebdbe58c |
+-----------------------------------------------------+------------+------------+
| WARNING:inconsistent_lock_state                     | 0          | 10         |
| inconsistent{IN-HARDIRQ-R}->{HARDIRQ-ON-W}usage     | 0          | 10         |
+-----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401031032.b7d5324-oliver.sang@intel.com


[   75.968288][  T141] WARNING: inconsistent lock state
[   75.968550][  T141] 6.7.0-rc1-00006-g30ebdbe58c5b #1 Tainted: G        W        N
[   75.968946][  T141] --------------------------------
[   75.969208][  T141] inconsistent {IN-HARDIRQ-R} -> {HARDIRQ-ON-W} usage.
[   75.969556][  T141] systemd-udevd/141 [HC0[0]:SC0[0]:HE0:SE1] takes:
[ 75.969889][ T141] ffff888113a9d958 (&ep->lock){+-.-}-{2:2}, at: ep_start_scan (include/linux/list.h:373 (discriminator 31) include/linux/list.h:571 (discriminator 31) fs/eventpoll.c:628 (discriminator 31)) 
[   75.970329][  T141] {IN-HARDIRQ-R} state was registered at:
[ 75.970620][ T141] __lock_acquire (kernel/locking/lockdep.c:5090) 
[ 75.970873][ T141] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 75.971113][ T141] _raw_read_lock_irqsave (include/linux/rwlock_api_smp.h:161 kernel/locking/spinlock.c:236) 
[ 75.971387][ T141] ep_poll_callback (include/net/busy_poll.h:37 fs/eventpoll.c:434 fs/eventpoll.c:1178) 
[ 75.971638][ T141] __wake_up_common (kernel/sched/wait.c:90) 
[ 75.971894][ T141] __wake_up (include/linux/spinlock.h:406 kernel/sched/wait.c:108 kernel/sched/wait.c:127) 
[ 75.972110][ T141] irq_work_single (kernel/irq_work.c:222) 
[ 75.972363][ T141] irq_work_run_list (kernel/irq_work.c:251 (discriminator 3)) 
[ 75.972619][ T141] update_process_times (kernel/time/timer.c:2074) 
[ 75.972895][ T141] tick_nohz_highres_handler (kernel/time/tick-sched.c:257 kernel/time/tick-sched.c:1516) 
[ 75.973188][ T141] __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752) 
[ 75.973460][ T141] hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 75.973719][ T141] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1083) 
[ 75.974031][ T141] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 14)) 
[ 75.974324][ T141] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 75.974636][ T141] kasan_check_range (mm/kasan/generic.c:186) 
[ 75.974888][ T141] trace_preempt_off (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/cpumask.h:504 include/linux/cpumask.h:1104 include/trace/events/preemptirq.h:51 kernel/trace/trace_preemptirq.c:109) 
[ 75.975144][ T141] _raw_spin_lock (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
[ 75.975383][ T141] __change_page_attr_set_clr (arch/x86/mm/pat/set_memory.c:1765) 
[ 75.975683][ T141] change_page_attr_set_clr (arch/x86/mm/pat/set_memory.c:1849) 
[ 75.975971][ T141] set_memory_ro (arch/x86/mm/pat/set_memory.c:2077) 
[ 75.976206][ T141] module_enable_ro (kernel/module/strict_rwx.c:19 kernel/module/strict_rwx.c:47) 
[ 75.976460][ T141] do_init_module (kernel/module/main.c:2572) 
[ 75.976715][ T141] load_module (kernel/module/main.c:2981) 
[ 75.976959][ T141] init_module_from_file (kernel/module/main.c:3148) 
[ 75.977233][ T141] idempotent_init_module (kernel/module/main.c:3165) 
[ 75.977514][ T141] __ia32_sys_finit_module (include/linux/file.h:45 kernel/module/main.c:3187 kernel/module/main.c:3169 kernel/module/main.c:3169) 
[ 75.977796][ T141] __do_fast_syscall_32 (arch/x86/entry/common.c:164 arch/x86/entry/common.c:230) 
[ 75.978060][ T141] do_fast_syscall_32 (arch/x86/entry/common.c:255) 
[ 75.978315][ T141] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[   75.978644][  T141] irq event stamp: 226426
[ 75.978866][ T141] hardirqs last enabled at (226425): syscall_enter_from_user_mode_prepare (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 kernel/entry/common.c:122) 
[ 75.979436][ T141] hardirqs last disabled at (226426): _raw_write_lock_irq (include/linux/rwlock_api_smp.h:193 kernel/locking/spinlock.c:326) 
[ 75.979932][ T141] softirqs last enabled at (225118): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 75.980407][ T141] softirqs last disabled at (225113): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644) 
[   75.980892][  T141]
[   75.980892][  T141] other info that might help us debug this:
[   75.981299][  T141]  Possible unsafe locking scenario:
[   75.981299][  T141]
[   75.981676][  T141]        CPU0
[   75.981848][  T141]        ----
[   75.982019][  T141]   lock(&ep->lock);
[   75.982224][  T141]   <Interrupt>
[   75.982405][  T141]     lock(&ep->lock);
[   75.982617][  T141]
[   75.982617][  T141]  *** DEADLOCK ***
[   75.982617][  T141]
[   75.983028][  T141] 2 locks held by systemd-udevd/141:
[ 75.983299][ T141] #0: ffff888113a9d868 (&ep->mtx){+.+.}-{3:3}, at: ep_send_events (fs/eventpoll.c:1695) 
[ 75.983758][ T141] #1: ffff888113a9d958 (&ep->lock){+-.-}-{2:2}, at: ep_start_scan (include/linux/list.h:373 (discriminator 31) include/linux/list.h:571 (discriminator 31) fs/eventpoll.c:628 (discriminator 31)) 
[   75.984215][  T141]
[   75.984215][  T141] stack backtrace:
[   75.984517][  T141] CPU: 1 PID: 141 Comm: systemd-udevd Tainted: G        W        N 6.7.0-rc1-00006-g30ebdbe58c5b #1 f53d658e8913bcc30100423f807a4e1a31eca25f
[   75.985251][  T141] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   75.985777][  T141] Call Trace:
[   75.985950][  T141]  <TASK>
[ 75.986105][ T141] dump_stack_lvl (lib/dump_stack.c:107) 
[ 75.986344][ T141] mark_lock_irq (kernel/locking/lockdep.c:4216) 
[ 75.986591][ T141] ? print_usage_bug (kernel/locking/lockdep.c:4206) 
[ 75.986847][ T141] ? stack_trace_snprint (kernel/stacktrace.c:114) 
[ 75.987115][ T141] ? save_trace (kernel/locking/lockdep.c:586) 
[ 75.987350][ T141] mark_lock (kernel/locking/lockdep.c:4677) 
[ 75.987576][ T141] ? mark_lock_irq (kernel/locking/lockdep.c:4638) 
[ 75.987836][ T141] mark_held_locks (kernel/locking/lockdep.c:4273) 
[ 75.988077][ T141] lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4291 kernel/locking/lockdep.c:4358) 
[ 75.988377][ T141] trace_hardirqs_on (kernel/trace/trace_preemptirq.c:62) 
[ 75.988631][ T141] queued_write_lock_slowpath (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 kernel/locking/qrwlock.c:87) 
[ 75.988926][ T141] ? queued_read_lock_slowpath (kernel/locking/qrwlock.c:68) 
[ 75.989226][ T141] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 75.989473][ T141] ? lock_sync (kernel/locking/lockdep.c:5721) 
[ 75.989706][ T141] do_raw_write_lock_irq (include/asm-generic/qrwlock.h:115 kernel/locking/spinlock_debug.c:217) 
[ 75.989980][ T141] ? do_raw_write_lock (kernel/locking/spinlock_debug.c:215) 
[ 75.990245][ T141] ? _raw_write_lock_irq (include/linux/rwlock_api_smp.h:195 kernel/locking/spinlock.c:326) 
[ 75.990512][ T141] ep_start_scan (include/linux/list.h:373 (discriminator 31) include/linux/list.h:571 (discriminator 31) fs/eventpoll.c:628 (discriminator 31)) 
[ 75.990749][ T141] ep_send_events (fs/eventpoll.c:1701) 
[ 75.990995][ T141] ? _copy_from_iter_nocache (lib/iov_iter.c:181) 
[ 75.991296][ T141] ? __ia32_sys_epoll_create (fs/eventpoll.c:1678) 
[ 75.991579][ T141] ? mark_lock (arch/x86/include/asm/bitops.h:227 (discriminator 3) arch/x86/include/asm/bitops.h:239 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:228 (discriminator 3) kernel/locking/lockdep.c:4655 (discriminator 3)) 
[ 75.991813][ T141] ep_poll (fs/eventpoll.c:1865) 
[ 75.992030][ T141] ? ep_send_events (fs/eventpoll.c:1827) 
[ 75.992290][ T141] do_epoll_wait (fs/eventpoll.c:2318) 
[ 75.992532][ T141] __ia32_sys_epoll_wait (fs/eventpoll.c:2325) 
[ 75.992810][ T141] ? clockevents_program_event (kernel/time/clockevents.c:336 (discriminator 3)) 
[ 75.993112][ T141] ? do_epoll_wait (fs/eventpoll.c:2325) 
[ 75.993366][ T141] __do_fast_syscall_32 (arch/x86/entry/common.c:164 arch/x86/entry/common.c:230) 
[ 75.993627][ T141] do_fast_syscall_32 (arch/x86/entry/common.c:255) 
[ 75.993879][ T141] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[   75.994204][  T141] RIP: 0023:0xf7f55579
[ 75.994417][ T141] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240103/202401031032.b7d5324-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


