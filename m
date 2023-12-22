Return-Path: <linux-fsdevel+bounces-6763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A881C335
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 03:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E29B215A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 02:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A034463C2;
	Fri, 22 Dec 2023 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGmns6OM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEBB566D;
	Fri, 22 Dec 2023 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703213629; x=1734749629;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=BBkhJT4eBnMEtLn9sSlzhJBY/lbD2pcUwdDPLPTlt5s=;
  b=UGmns6OMwa7F4PaoCvcIDjQkgVeCyopeampscPcFc6Wv1Uk2Ei19goEF
   Wvv2yWlwaP+huvELEN7/fg7bNxNOoB+Phkl7viiFFZKCSmS7liI7HFO9c
   FOdyb3uwS3vXJVFBeRHp7tt9+LJ5Qd6HxsMav7xg1NDuOEbJUT+UqTlqP
   H8QEGhgBRma/EhYLsSx0VbDVpdu3DkTFDv+0Gncf8OW7qE9CSoKt7Ye0W
   ysF+lO7NDEocy2Z7ZzC22a5Ye/9N5/Aa3XmB0CCECgvOcUf0xLSYQEa1N
   awFrSGOOtSrmoR3uFOd61EWKnJCcvoB2bAPD1zW3/7ciyVJzZcCZBibqZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393232879"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="393232879"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 18:53:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726651674"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="726651674"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 18:53:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 18:53:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 18:53:44 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 18:53:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKFbbVUcipzzYYv2iidZw+XKaSdDbJAHaCPD1JDzZ4O/p5rPJjgOQrypQ3r3wzeG72337BFi+y0l6P5l6+rmVlDlJXAYRW95lfS7m0gdkb2IdFUTMBUD8HaJ7RqCIOXv0Y3Eo+ybGn7h4+pW8oa7bDQw8jI4Zf2UYkrthb+ibxVTqG7v/Vn3/SACqkE5qbGSVgDL6FEsE+dXZ8rttfT9KdE9CFJnNhO2nigcvxK3kc5KXpmALT1vHpnGrczZ6LlBlFTFXZ3OikbUQKaEnfPgwtf5uXwyRjR+m5+XNk9TgXHNMQjFLZL/89ZCTruLVdnnKkmtiqVNx0MT3K/SnWWrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIAVlVmt53hSmg1lmrrKKkTKZSlt/oqhVMjhEkg9+eQ=;
 b=DlTfptDG+qzeZQcfBypqsC6eK8YFTE/5oVpnuh0X6Blxa2lTKa/Z3/fwqVR6JNbjWeAUhHcTdhphW0vXSfKJBDl7KBco2kazqWqRBBtSwcLuRCgWnF/wL+cjlBKvb89XDQCw3B5QFoicSH03/XMtsxRxkh4KJNspwShL59wP7q8JHlvx8JEZ4cXyG0mvFbZfSt4UHef4SqBl5N6F+CJ2oI8c+ugmIcJDTPKknfQrHlAkJ5g2M4/LFGVQrS5YdJyguX8FmihaoZIa25lvO/J/BuZbNqV4vTgxAovk0jb83AFNOAeQPJUmIrf/1oS9bTdZTvS1h1Xs8TEWHNVxhsFPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 02:53:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7113.016; Fri, 22 Dec 2023
 02:53:39 +0000
Date: Fri, 22 Dec 2023 10:53:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, "kernel test
 robot" <oliver.sang@intel.com>, Jann Horn <jannh@google.com>, Mateusz Guzik
	<mjguzik@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: [linux-next:master] 253ca8678d:  lmbench3.Select.100tcp.latency.us
 -5.0% improvement
Message-ID: <202312221056.da0e7f9-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: a50a63b0-6478-48da-117a-08dc029932cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gorg7U9WVcIURR3tvg3b0SVehqwRsBs7bykhLol3C/pshSrrqtEMFR8fpUsUxVzkAmrSEreUHP5Ld/y50kQdg/UPA4V3fD4Zpw+BnXkH+OPLnHlei7fznXVfDH1Dk8LiRXU8WHoYGMgcf7499YorIfDIegfV8HMzIMdzNkigWaLoHSYrpPld3GiGl0dA1PM/ijin+0WZxwvqhks0/PyExq/yNBG6J5Ot86Lyir7sFCy6fVlP3nXr4KJBGH9HZzjJTeGIDT5JpSGtbd2xUOtV4ZFUNpIYJ3AQvobkeYanxFW7XKVMrQOoomFdBrgREPPdCVCYzk0+YBDoFKhDtrHafZuk3bXPFzLGLYpOra4LSzPhXw6CGlOe3onLX1FIjrzIIs3bFhw+kZYwgDJ2g40xeArTnY6e4PLre5OgTYnPfV5FlVg6Q5CAQKzcBOSz3leBeDmoQobWDSX+QO4RI+wS1c6C8XDhmZV1rQe1a7U0i7QLuk6BV6tqbrZO/EAObdNAtheXzeYZqPoFCKK74XZjB4nKP2edMfSlZ3Byjn44MeZafR177mqIKAsEBwvThHIjmKbTlhXKJmH3p/MTcKmxYCO5kj4wR6EcEevrrvU8znbNxh4rWrDPiJXT0WcwOohX0h/YBrSsT+DELt7/Y3N6NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(230473577357003)(230373577357003)(64100799003)(186009)(1800799012)(451199024)(966005)(83380400001)(82960400001)(36756003)(86362001)(41300700001)(38100700002)(6486002)(5660300002)(1076003)(4326008)(8676002)(8936002)(316002)(6916009)(54906003)(66946007)(66476007)(66556008)(2616005)(6512007)(26005)(107886003)(478600001)(6506007)(30864003)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?F0TFmijulwm/3x2gEaf9ohivHo/U+Q/4Qw66n4+hgz9DZTioE6I9kyVkGJ?=
 =?iso-8859-1?Q?ueWm4MErEyGVDT04ue9YEBbghG5A3ptOMHAosQO7/aIRigAXhrGRTv7QHR?=
 =?iso-8859-1?Q?8CPjcfAtKSMCLKelE8vLCi+zU8W9IkyE5DWr9xYFCADDAi2CXSuW4qn2Q5?=
 =?iso-8859-1?Q?5ByH/OI6b1yGOZG7neNaRbaosHr8nMbTWiE4KoFSY89395z+dBBKU8NiLs?=
 =?iso-8859-1?Q?cJk3TsC7b/3sV9lpXGMJYgppuBnD++aD1/dAih7mwKPh4Iu/r/V0PJPEz7?=
 =?iso-8859-1?Q?FDWOyn704mbMMGTO3qIYnphRo5D10vuwHcFxNQYD/bwiAkfw/KTO04QUKa?=
 =?iso-8859-1?Q?QpBjzykZqJ2q/RV7QC8uuaD7XQbyYNpJPKGVRjXZuxqb0bj38clOuUjwFT?=
 =?iso-8859-1?Q?jh9wx35ZkKWZqAP1k0HTjJSm3U/DQMcPwlXnMD+9tX8+mWxGP0WdXZE6Fk?=
 =?iso-8859-1?Q?eD3WSxnONAo6TNaiybTTeahJZ2X4j25++jBX41h0fjjIelPMyD+9KxbeMC?=
 =?iso-8859-1?Q?i1NbQdk/a5ryaYxP0PPdY3YUuDADgr3m7tteHXXdHOijQyiCdR9mwvEFN8?=
 =?iso-8859-1?Q?PagOXKfw8FJCEaO+Wkbp4ImO9Iz0sLKPU6779/0IVQ260LvV8JtmSA4fqj?=
 =?iso-8859-1?Q?Az5y5ck/HPBD6go6QZfTKEQsmkMoFlEXQyKR3tR4BsfbD9667SRTMa60H4?=
 =?iso-8859-1?Q?zZ7zRL7kQLP6qpk7etcsTRxxZPhtpeelGGnhppiuaOrHKkWFib9R8oyGrB?=
 =?iso-8859-1?Q?bkVzjxIy3XtEiKcnpQ2mdBq8Ez5w0L1leA3/0/0GITsNd0SVMwpyLHisQY?=
 =?iso-8859-1?Q?nUsbQgF5kdD6Yabdlz7F90wOxKFEJ3o50A5oaJbX9xzzK2lUi7al0Uc+g9?=
 =?iso-8859-1?Q?0Jwra/OkX9MQKScwtSJbHo8Vh7IEy/+R2KVzrpJg0f/U+mFvRfcRmlR7ch?=
 =?iso-8859-1?Q?AvURVNJjAop7FGjl2/tm4BBKRAilqB0MP8FgFGTtrwtTqvP3LkNjNoF4j4?=
 =?iso-8859-1?Q?3xNJqRAS8jV4lehJdqTElFfIYWgizRyo3e5cZKLKkcLNjganxat74SjgbW?=
 =?iso-8859-1?Q?COmWj1XC7KOP48ikEFd4IX2wBNzq/ltklOdhXbxDdx3de37JV3yaz0ALir?=
 =?iso-8859-1?Q?Zbb5uybyKpVeIym6zDHD6mgtjdRts0pke1dB/f253wNNrgqZuDyYLRC0/O?=
 =?iso-8859-1?Q?+oQ+fGPR3V2qfH9xJUSS0l/pELvzCubcJ9sHG6hofqw7rqUThY33JmWuDW?=
 =?iso-8859-1?Q?k3ZoeYWmCx0TRMbnsLY4XHJPkQGy4gQXhEa2A8KtQf/gAsIKJNvmLcQs77?=
 =?iso-8859-1?Q?fll4/U2MsNt6h2rcloOrkoOUiNlLroNAYbMOQ6M/b2V4pycIMdxmsg4J2u?=
 =?iso-8859-1?Q?3teOr8OzzplyJlM3vXUrFVDnQj74teNqYr7viLdVhPIfRkGn3/ZvkSDbyQ?=
 =?iso-8859-1?Q?cqq40nETOB8YIyByVKML8aZdt2QrStdsqFj5CfpVZC8XHf2sT0PGkV8LTO?=
 =?iso-8859-1?Q?E6X/4a99TQ+TUo6QM3hFxwuuy1SoaKU+8IS0xOrdr5P6twHDfZN89Cf+eS?=
 =?iso-8859-1?Q?MQ4jx1g6NGDz+N2l/d3cpAtWNjZnFtH5qUiKwxQZf+mepUKjcnN4H0/p+9?=
 =?iso-8859-1?Q?RQFpHinROAEDHmsCzD+Tg4BLntSc8qeM6f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a50a63b0-6478-48da-117a-08dc029932cc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 02:53:38.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1n5LryJGa9UUnZn2XXnM8W34S2Hbs75NzXU+eBqflGvdvdBGpYiiWcFo0Z8XwKJpFM01ms81mGqFNFFnbbUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
X-OriginatorOrg: intel.com



Hello,

this commit fixes the
"[linus:master] [file]  0ede61d858:  will-it-scale.per_thread_ops -2.9% regression"
we reported in
https://lore.kernel.org/oe-lkp/202311201406.2022ca3f-oliver.sang@intel.com/

in our tests, besides the improvment in will-it-scale tests, we also noticed
the improvement in lmbench3 latency tests. so just report as below FYI.



kernel test robot noticed a -5.0% improvement of lmbench3.Select.100tcp.latency.us on:


commit: 253ca8678d30bcf94410b54476fc1e0f1627a137 ("Improve __fget_files_rcu() code generation (and thus __fget_light())")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: lmbench3
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
parameters:

	test_memory_size: 50%
	nr_threads: 50%
	mode: development
	test: SELECT
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 10.3% improvement                                     |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=process                                                                                       |
|                  | nr_task=100%                                                                                       |
|                  | test=poll2                                                                                         |
+------------------+----------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231222/202312221056.da0e7f9-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-12/performance/x86_64-rhel-8.3/development/50%/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/SELECT/50%/lmbench3

commit: 
  7cb537b6f6 ("file: massage cleanup of files that failed to open")
  253ca8678d ("Improve __fget_files_rcu() code generation (and thus __fget_light())")

7cb537b6f6d7d652 253ca8678d30bcf94410b54476f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.78            -9.8%       1.61        lmbench3.Select.100fd.latency.us
      5.70            -5.0%       5.41        lmbench3.Select.100tcp.latency.us
     12.09 ± 36%     -12.1        0.00        perf-profile.calltrace.cycles-pp.__fget_light.do_select.core_sys_select.kern_select.__x64_sys_select
      0.05 ±299%     +14.9       14.97 ± 51%  perf-profile.calltrace.cycles-pp.__fdget.do_select.core_sys_select.kern_select.__x64_sys_select
     12.09 ± 36%     -12.1        0.00        perf-profile.children.cycles-pp.__fget_light
      0.36 ± 42%     +14.6       14.98 ± 51%  perf-profile.children.cycles-pp.__fdget
     12.05 ± 36%     -12.1        0.00        perf-profile.self.cycles-pp.__fget_light
      0.31 ± 42%     +14.6       14.91 ± 52%  perf-profile.self.cycles-pp.__fdget
      0.19 ±  2%      +0.0        0.20 ±  3%  perf-stat.i.dTLB-store-miss-rate%
   1585715 ±  8%     +93.4%    3067285 ± 30%  perf-stat.i.iTLB-load-misses
      0.17 ±  2%      +0.0        0.19 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     88.15 ±  5%      +4.9       93.07        perf-stat.overall.iTLB-load-miss-rate%
     48830 ±  8%     -45.0%      26871 ± 25%  perf-stat.overall.instructions-per-iTLB-miss
      1.41            -1.8%       1.38        perf-stat.overall.ipc
   1573086 ±  8%     +93.7%    3047643 ± 30%  perf-stat.ps.iTLB-load-misses


***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/poll2/will-it-scale

commit: 
  7cb537b6f6 ("file: massage cleanup of files that failed to open")
  253ca8678d ("Improve __fget_files_rcu() code generation (and thus __fget_light())")

7cb537b6f6d7d652 253ca8678d30bcf94410b54476f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    685.00 ±  5%     +62.3%       1111 ± 13%  perf-c2c.HITM.local
      0.04 ±187%    +482.9%       0.21 ± 50%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    136406            +2.0%     139095        proc-vmstat.nr_active_anon
    136406            +2.0%     139095        proc-vmstat.nr_zone_active_anon
  98393191           +10.3%  1.085e+08        will-it-scale.224.processes
    439254           +10.3%     484377        will-it-scale.per_process_ops
  98393191           +10.3%  1.085e+08        will-it-scale.workload
      0.00           +28.2%       0.00 ± 17%  perf-stat.i.MPKI
 2.226e+11            -2.2%  2.178e+11        perf-stat.i.branch-instructions
      0.28            +0.0        0.30        perf-stat.i.branch-miss-rate%
 6.155e+08            +7.4%  6.608e+08        perf-stat.i.branch-misses
     12.91            -3.3        9.62 ± 13%  perf-stat.i.cache-miss-rate%
   1955843           +22.9%    2402856 ± 17%  perf-stat.i.cache-misses
  15946481           +59.2%   25391906 ±  9%  perf-stat.i.cache-references
      0.59            +5.0%       0.62        perf-stat.i.cpi
    408471           -17.9%     335390 ± 14%  perf-stat.i.cycles-between-cache-misses
 2.901e+11            -4.0%  2.784e+11        perf-stat.i.dTLB-loads
      0.00 ±  9%      +0.0        0.00 ± 10%  perf-stat.i.dTLB-store-miss-rate%
 1.814e+11           -12.6%  1.585e+11        perf-stat.i.dTLB-stores
  26765498            +9.7%   29360826        perf-stat.i.iTLB-load-misses
  1.23e+12            -4.4%  1.176e+12        perf-stat.i.instructions
     46105           -12.9%      40163        perf-stat.i.instructions-per-iTLB-miss
      1.69            -4.8%       1.61        perf-stat.i.ipc
      1.30            -4.1%       1.24        perf-stat.i.metric.G/sec
     75.67           +56.5%     118.40 ±  9%  perf-stat.i.metric.K/sec
      1802            -6.9%       1679        perf-stat.i.metric.M/sec
     91.19            +1.9       93.14        perf-stat.i.node-load-miss-rate%
    603847           +29.4%     781631 ± 13%  perf-stat.i.node-load-misses
      0.00 ± 44%     +54.2%       0.00 ± 17%  perf-stat.overall.MPKI
      0.23 ± 44%      +0.1        0.30        perf-stat.overall.branch-miss-rate%
      0.49 ± 44%     +26.0%       0.62        perf-stat.overall.cpi
      0.00 ± 46%      +0.0        0.00 ± 10%  perf-stat.overall.dTLB-store-miss-rate%
     73.34 ± 44%     +18.0       91.29        perf-stat.overall.node-load-miss-rate%
 5.111e+08 ± 44%     +28.9%  6.586e+08        perf-stat.ps.branch-misses
   1626781 ± 44%     +47.4%    2397620 ± 17%  perf-stat.ps.cache-misses
  13269755 ± 44%     +91.5%   25415998 ±  9%  perf-stat.ps.cache-references
  22231799 ± 44%     +31.6%   29255242        perf-stat.ps.iTLB-load-misses
    501267 ± 44%     +55.4%     779219 ± 13%  perf-stat.ps.node-load-misses
     16030 ± 45%     +33.6%      21409 ±  6%  perf-stat.ps.node-stores
     47.56           -47.6        0.00        perf-profile.calltrace.cycles-pp.__fget_light.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
     67.41            -2.9       64.56        perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     87.35            -1.2       86.15        perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     87.96            -1.1       86.82        perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     88.69            -1.1       87.62        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     89.02            -1.1       87.97        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
     91.89            -0.8       91.12        perf-profile.calltrace.cycles-pp.__poll
      0.81            +0.0        0.85        perf-profile.calltrace.cycles-pp.__check_heap_object.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.64            +0.1        0.69 ±  2%  perf-profile.calltrace.cycles-pp.__kmem_cache_free.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68            +0.1        0.74        perf-profile.calltrace.cycles-pp.kfree.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26            +0.1        1.32        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.84            +0.1        0.94 ±  2%  perf-profile.calltrace.cycles-pp.__virt_addr_valid.check_heap_object.__check_object_size.do_sys_poll.__x64_sys_poll
      1.53            +0.1        1.67        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.do_sys_poll.__x64_sys_poll.do_syscall_64
      1.82            +0.2        1.98        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__poll
      2.60            +0.2        2.76        perf-profile.calltrace.cycles-pp.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.91            +0.2        2.09        perf-profile.calltrace.cycles-pp.__kmalloc.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.44 ±  2%      +0.2        2.62        perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64
      3.86            +0.3        4.20        perf-profile.calltrace.cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.94            +0.8        8.70        perf-profile.calltrace.cycles-pp.testcase
      3.60           +42.4       45.95        perf-profile.calltrace.cycles-pp.__fdget.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
     45.80           -45.8        0.00        perf-profile.children.cycles-pp.__fget_light
     69.22            -2.7       66.50        perf-profile.children.cycles-pp.do_poll
     87.48            -1.2       86.29        perf-profile.children.cycles-pp.do_sys_poll
     87.99            -1.1       86.85        perf-profile.children.cycles-pp.__x64_sys_poll
     88.74            -1.1       87.67        perf-profile.children.cycles-pp.do_syscall_64
     89.06            -1.0       88.01        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     91.99            -0.8       91.23        perf-profile.children.cycles-pp.__poll
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.14 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.24            +0.0        0.26        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.16 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.rcu_all_qs
      0.13 ±  3%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.kmalloc_slab
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.21 ±  2%      +0.0        0.24        perf-profile.children.cycles-pp.check_stack_object
      0.24 ±  2%      +0.0        0.27        perf-profile.children.cycles-pp.poll@plt
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.24 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.__cond_resched
      0.36            +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.81            +0.0        0.86        perf-profile.children.cycles-pp.__check_heap_object
      0.48            +0.0        0.53        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.65            +0.1        0.70        perf-profile.children.cycles-pp.__kmem_cache_free
      0.68            +0.1        0.74        perf-profile.children.cycles-pp.kfree
      0.70            +0.1        0.76        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.32            +0.1        1.39        perf-profile.children.cycles-pp.check_heap_object
      1.14            +0.1        1.23        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.85            +0.1        0.96        perf-profile.children.cycles-pp.__virt_addr_valid
      1.60            +0.1        1.76        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      2.76            +0.2        2.94        perf-profile.children.cycles-pp.__check_object_size
      1.94            +0.2        2.13        perf-profile.children.cycles-pp.__kmalloc
      2.48 ±  2%      +0.2        2.67        perf-profile.children.cycles-pp.rep_movs_alternative
      4.09            +0.4        4.45        perf-profile.children.cycles-pp._copy_from_user
      8.04            +0.8        8.81        perf-profile.children.cycles-pp.testcase
      3.58           +40.5       44.04        perf-profile.children.cycles-pp.__fdget
     43.81           -43.8        0.00        perf-profile.self.cycles-pp.__fget_light
      0.40            -0.0        0.38        perf-profile.self.cycles-pp.check_heap_object
      0.15            +0.0        0.16        perf-profile.self.cycles-pp.poll_select_set_timeout
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.is_vmalloc_addr
      0.10 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.14 ±  2%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.11 ±  4%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.kmalloc_slab
      0.11            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.21            +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.14 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.poll@plt
      0.18 ±  2%      +0.0        0.20        perf-profile.self.cycles-pp.check_stack_object
      0.15 ±  2%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.22 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__kmalloc
      0.32 ±  2%      +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.25            +0.0        0.28        perf-profile.self.cycles-pp.do_syscall_64
      0.43            +0.0        0.47        perf-profile.self.cycles-pp.__check_object_size
      0.45            +0.0        0.48        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.36            +0.0        0.40 ±  2%  perf-profile.self.cycles-pp.__x64_sys_poll
      0.81            +0.0        0.85        perf-profile.self.cycles-pp.__check_heap_object
      0.48            +0.0        0.52        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.65            +0.1        0.70        perf-profile.self.cycles-pp.__kmem_cache_free
      0.68            +0.1        0.74        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.66            +0.1        0.72        perf-profile.self.cycles-pp.kfree
      0.81            +0.1        0.91 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      1.05 ±  4%      +0.1        1.16 ±  3%  perf-profile.self.cycles-pp.__poll
      1.13            +0.1        1.24        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      1.73            +0.2        1.90        perf-profile.self.cycles-pp._copy_from_user
      2.33 ±  2%      +0.2        2.52        perf-profile.self.cycles-pp.rep_movs_alternative
      8.10            +0.7        8.80        perf-profile.self.cycles-pp.do_sys_poll
      7.94            +0.8        8.69        perf-profile.self.cycles-pp.testcase
     23.27            +1.0       24.26        perf-profile.self.cycles-pp.do_poll
      1.79           +40.1       41.93        perf-profile.self.cycles-pp.__fdget





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


