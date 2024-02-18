Return-Path: <linux-fsdevel+bounces-11953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6B859726
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 14:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE611F217A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AFD6BB5F;
	Sun, 18 Feb 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUhm6Tbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD511E898
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708263355; cv=fail; b=SzAmn3myx41td7tJGnc60ss0d6Gf1RJaDyzczfvYDLRPSpSFA2wesTNMXe0ZDMjG7MtoFFpte84bmJaJmUtGGXXPTn8It0QuKqgPbIShYdtGLD9qSi7/Q60bq2vwvedYlgXk6ZILlcWAgBoS7qaU5ajI70UMhsk8H4h/O3Ovi5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708263355; c=relaxed/simple;
	bh=rEdk9GfCcrzZ+7rRIE7ibNM1llif29NRcIOFtuZsqXI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Rt98q3ewi21DDBz4JEr/o2TsbTkegieV6vLGDjq8z09lcoZiMdY1IPgQKWS5JiMWPnYg0J3CgQCf/sFtwj7AEmee57l3afU9kjGKqbP3bcROdF7gdI4LlnBmZ37RznAjIdySOt5gHzPeRSeoQQecGuqS4z6T5qJGCZF78QOcf2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUhm6Tbz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708263353; x=1739799353;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rEdk9GfCcrzZ+7rRIE7ibNM1llif29NRcIOFtuZsqXI=;
  b=TUhm6TbzQXJbe7Rfuw/rZNpYwIT8fWCL/9vrzZUM0qWPdGMS+oLcTpQj
   kIAKrZAwIAWHI9wINR0si6XXLsllvWkfZgEDaJq+kMqGjchbJd5Or2Ay8
   VgxaBVp1vbugLUg1ea5JnWt57Gm94DlDLBIny31UhdlS07SHMWE1ozAMh
   qfAzhFW64/xPVSQbBPGudvop2ZAYwS31tqvP7S9o2XfIawH+hohLe9T3L
   /9oHe+JQ/6zH1fh8XshZyhMd3vaTe6wgrP9Pi1jx7Z/tXkdobx76ijp5c
   ksGC/r1eyfjVPuYchpUYER5vG5DDvxP2jyNwJYwU6KQOdQWMLa77sDEb6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="13744124"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="13744124"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 05:35:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="4651650"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 05:35:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 05:35:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 05:35:51 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 05:35:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7d44L8UosaAdVItSBUzMK6I0aXQyXSa+KrIaWq71xxeL4i/45+DwXwJeUDpRqQgurLbK0oaBMwbr9Oz5qgFTHqX2rqAMRfVjeGAriYUO6F0n2aFYbzibByBQ+Vax/Wn549x2XirraS9mOWZgSZfMpBXR94FjjRU7wyI5gT9a/t9KT1C6J4gTgkslAaeXBOQbLP0XxMMnc8LtFXIpq3Yk5k3Fl5xICMYKJ84/LlMOd6ZwnKwAZQjQgIj5sI/BV7asosTWT09fiZz1ykd0VkLPGlp79FYM/Kh0EZH4grxenIhk3DxDbZgoj+RkIVdX1FsFJdc7LzgS7XlC+52+IKg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBSIcM7xyQzE1iGoqc9Ve6o15DwQly9a7+EH0Gd4Ih8=;
 b=h42NVz7/ArIvcOlZ/r1qtgRpSRSpLqD+MHrqKd0m4l3UMCIpEAJdtrn802GnUO1ifsiit47Y12MDsujLSirMs64ne8bveflg5VwUoDehHq0GhrrVEi8TEMKqMPvps1m/daGX3KLUPcjvzHAkEfAZL80XwVrZZWnsCU3XVwPJ4gkM1HP5cC84n6COb70Q31mNQ/houCiAen97fIMiQ+b49Fw6eemALgxPzTA6EfVifpLgl3bDLxVVtoQ3ipXxisThqmUs5S+YiDGfWyLCDnFH9ZUctJklLPIq9WX/RJEMZ6nwn/EJ7pffsYTMW4ML+s3LJLL8QdxyIPDSVXT8Bms0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 13:35:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Sun, 18 Feb 2024
 13:35:46 +0000
Date: Sun, 18 Feb 2024 21:35:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, NeilBrown
	<neilb@suse.de>, <linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [filelock]  b6be371400: ltp.fcntl17_64.fail
Message-ID: <202402182151.3a4faafd-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN6PR11MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: d2101c4e-ecd7-4800-6b10-08dc308682d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/+moHhrFkHWzHYWcnwV7EpuzH8a3cDH1ql5JR+07/VZAKclVj/iJwIER1KvvdE3tvlWtb8rAjcmI0yZ/6PNl5k860l8JAkRe0c5CZPaeHYeMKLBHIkUv/w8ju8jzojBkOc8RAhRK9hrdpX4mU2Mc/Ty1lKAF9vs2z8ZckAB6RY8Z1os8Hyg4a49/LjO4Kwhk83hAoCDiLEFgvq7q02W3BUq+SIGzvwM5n76SY7B0Y3G/v0bNxEgATGHs953jh4t2O5kpVULiExwzndj0DYT9xDHikKz7Gqz7bhlZENdeL2s/IKHUKalIiUOnJhuJomdtS7ykRgvW9mtOCwgqJvV6TCm59NcIBm2nqYT0Nlri+q79my0P5oVueJovWoWIuscXg7yKRuo1RWZQg/Nh2Vy9UPoixOaz17Nju1qNoEUPuRsBrzw1V/jsc/mjCjYDCUWJogxXuoHJyRaMz/0+D+ZcvVWrLmf/MK1DtBtr/AEYtPkxHeaBT6OlujMbudowylpemWox5qs/CK3/uEczHJMxq4GgXGAFn55Lobez/hkodc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(82960400001)(83380400001)(38100700002)(86362001)(26005)(107886003)(2616005)(66946007)(6666004)(6506007)(6486002)(1076003)(66556008)(66476007)(54906003)(6916009)(316002)(966005)(478600001)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HG4uFFF8pIENDHeJQPfNny5acY3UnLEGFBgmYLbqf4d9nKlNZhT5u+Rb5B8R?=
 =?us-ascii?Q?ZNH1vJkAfyZYqVpqMtfTpwZ0203GyU/xidAXKPZff4LAOhnb9faC/mHjq+fB?=
 =?us-ascii?Q?gzpSoB1NQ2sJAbeySptA65GU7bOsjIgpGYuTcM06dH0PvDTk5s2AiphUVcTl?=
 =?us-ascii?Q?fbqZP4eE/5yAaR/B+ZtHQeohUmmOULpPL5QPZ98sHpzmfZhrO5rqOoAVHPYh?=
 =?us-ascii?Q?OXdg2pV9luJx6m6TIPTbSLe0KhRmNj8TJVo9apHEoAB4qCERsaB0HQKC8UWl?=
 =?us-ascii?Q?SAtxgpLrLp6kDfVE2+/L0HTikvID5T6Xy5qwE2G/I/bKnS7iNC71dsfVSQCS?=
 =?us-ascii?Q?lSGilP/ufMO4IBvnZ7zawfIJpfACXsOlCxs9z5bOvODwxGu3eZbAWQILmQV7?=
 =?us-ascii?Q?ttnzSV6Fe0xJeL8rHc/RXvOZWHQA7fah6zCKr2v+BoHEAyj6/Y9hHoIh1yCx?=
 =?us-ascii?Q?He6of+z7POCTgS4/Dk4i6DfHwbS7yhpCcjKpGm3QNOPjJRueBswFiTcnz7h7?=
 =?us-ascii?Q?MhHogItu3V4aJZcaaM8YFdS62NliJf/UFJ2QMsYS6Gy39P7enut7wOs41zfk?=
 =?us-ascii?Q?y0XyhO6C6hqFZK8VvQNzJJ8T0GCBn06Mq1GWIAoavHDFsvNZHMk6sQTccvgt?=
 =?us-ascii?Q?RaUwEXasCKorhLJyH1roARi3axNMpu7JZwepSIk+xxzDVRp6/LZTjQQolUf1?=
 =?us-ascii?Q?ABHHL2op8QmiAkU4EoRxGt9cm3vZqxyg2amqpE0nFt3q29YTUFPKNHAt2BdT?=
 =?us-ascii?Q?33kVEk3CfyphRYN4zwl5KW2jq+Gcuu+wBx9EaIh8BK1tgXVubCkh4/XWIKn6?=
 =?us-ascii?Q?MQeyooXuM90vSVZjuSgF5ZrK5+c+Q8bx3Gi4Z9DmL3f+FWvNhF8bZ2IXKRSD?=
 =?us-ascii?Q?pWuuGS1HvzmFoaX/C3gnnuUSGIfyXURZhufpau2x3//mPZqmhZChNr2FZk3O?=
 =?us-ascii?Q?JjMz8yY3mkyh8R/tfgQDmOftCmoivwnEpAaRMDmdXE/NXkoJCNov5nksFNDb?=
 =?us-ascii?Q?TKSJq2CVCRTjXoyU2MoSV+Z32sCzryUVIA/CL9H9RajCaBONKEs7c49OFy6t?=
 =?us-ascii?Q?6iefcume32SBMQsUC/lWVqfKhXtdQY6sVEMJCUTDyzjeCTeQo1Q++fC88YJr?=
 =?us-ascii?Q?/n3aEKNUprXewp2ScK3DP4HnkNfi/X9QWzMr1IDh03O+xT/nKWTj1izNsFxr?=
 =?us-ascii?Q?nZFXe0b1OBUSdUgOVadiJ4cS8nXGXNmXPQzlnkxNvrL55s3s7qqIkp1mAGFv?=
 =?us-ascii?Q?YsEoP7t28HNiEqjS7cNx916EJ0zR1x45tKv8c7xpgHJ00ChwrFMpzsM018zA?=
 =?us-ascii?Q?glFQnvaTNKUjROqHlhJDF60I1a2se8LyfgH5AgnqFFjC9mDOmI6g6D1yEfTY?=
 =?us-ascii?Q?C78MwrCjuu6XYpno1uycCCzE6U2pUH96H/iYHzWS7KuNGn/cusCC237RsRgc?=
 =?us-ascii?Q?f3xcRFY5SMcK0j92RddzxRkAGvup6mtXx+w2Br4INBCd1y6vLFe4Y5gRKOez?=
 =?us-ascii?Q?xlseiCqVV9YG5eN35gf9I/Ua195DYZf4XP9X3N9iILekeveq4kEbMfV8BOEn?=
 =?us-ascii?Q?IJsoBH9H0jd/8SMWAKXQjkHRLnDvLtPhd2Za+HfMqVHwIy1NmLg7HFLWwI7M?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2101c4e-ecd7-4800-6b10-08dc308682d9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 13:35:45.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZA2evOyfWLMcZOx9JtbwmHvX1dethXPnign8N0UmmLiXrLkhHZPq5N16a8k/bUMBbz8XvX1dSMG5OhCqUyCjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com


hi, Jeff Layton,

we reported a (dramatic) performance regression for this commit
([linux-next:master] [filelock]  b6be371400: stress-ng.lockf.ops_per_sec -100.0% regression)

now we also observed it could cause some func failure. FYI.


Hello,

kernel test robot noticed "ltp.fcntl17_64.fail" on:

commit: b6be3714005c3933886be71011f19119e219e77c ("filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master ae00c445390b349e070a64dc62f08aa878db7248]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240210
with following parameters:

	disk: 1HDD
	fs: ext4
	test: syscalls-03/fcntl17_64



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402182151.3a4faafd-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=fcntl17_64 stime=1708853783
cmdline="fcntl17_64"
contacts=""
analysis=exit
<<<test_output>>>
fcntl17     0  TINFO  :  Enter preparation phase
fcntl17     0  TINFO  :  Exit preparation phase
fcntl17     0  TINFO  :  Enter block 1
fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child processes by hand
fcntl17     2  TFAIL  :  fcntl17.c:363: parent_wait() failed
fcntl17     3  TFAIL  :  fcntl17.c:605: child 2 didn't deadlock, returned: 4
fcntl17     4  TFAIL  :  fcntl17.c:295: fcntl on file failed, errno =9
fcntl17     5  TFAIL  :  fcntl17.c:295: fcntl on file failed, errno =9
fcntl17     6  TFAIL  :  fcntl17.c:619: Block 1 FAILED
fcntl17     0  TINFO  :  Exit block 1
fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir: rmobj(/fs/sda2/tmpdir/ltp-qtpqayjsB8/LTP_fcn2s19iy) failed: unlink(/fs/sda2/tmpdir/ltp-qtpqayjsB8/LTP_fcn2s19iy) failed; errno=2: ENOENT
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=10 termination_type=exited termination_id=5 corefile=no
cutime=0 cstime=1
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240129-39-g3f79bcb94

       ###############################################################

            Done executing testcases.
            LTP Version:  20240129-39-g3f79bcb94
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240218/202402182151.3a4faafd-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


