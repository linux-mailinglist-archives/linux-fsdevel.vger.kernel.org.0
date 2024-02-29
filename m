Return-Path: <linux-fsdevel+bounces-13168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A4E86C27B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 08:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849EE1F22061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45E44C97;
	Thu, 29 Feb 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhY0LaTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262C39855;
	Thu, 29 Feb 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191685; cv=fail; b=nKtTxLq8rj6eHhiZyf3gJwECPflsPeaKydso82Ph4eHMk54dd1zKuEpasoEn1JgU8uHagWLtpPwTYFOkIO4ADJ4rRzGLSfO0BRTTeBPQuMfCwa3/agiblD+wQezob4zoxdMvgZft2X3uZo+TmYw27Udg7hqL7TpyHX7Da9dhSx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191685; c=relaxed/simple;
	bh=ddm9+59idnusmFfxWoQ1ZaRdyAfZ5IZuc3vgfYt7FB4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pO2qw8j410E/xk3ThT4Q/Wf4YzDk9tR2tHofriSh+SFZgC68ipozmkhbGQql9noW82MSZIA0pWQf98uB8A3TX5v7oyDOzGjK+YRpYgslaihijeBC041KNXVLgKORJuevtm00n3n4SVQt0NHKiKElIGFAwZcS2B1dPivHrrEMTZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhY0LaTc; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709191681; x=1740727681;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ddm9+59idnusmFfxWoQ1ZaRdyAfZ5IZuc3vgfYt7FB4=;
  b=QhY0LaTcYsIn0pCwdTrAqHUkVkuA9VOLw41tEOzALjMb693SHjnAVrkZ
   MyFO/QuOdU4hTHnpvuktOehiLac6lM7fQKgXZi3ZNxTlAtM4VuHXbo/cT
   9hsHSKu9SCM4NVuQoJo2j2M0fOePy7jcojh+oN9lF4UL3b2YnpmwVsLdx
   dlsHvRSMGprPH8WJ8nT+hPWjBZV9T9P8eV1tg1at8x73pTaSEp/5ZuI/D
   5k6+r65KJGr8xeaGAbwxcVQo0K4qKYG35t2zAEXhoKkJPxS05zcwPV5Sg
   S+lJkgy5kwLU0ZmtDXoMhcIrXXDok0giW6s1CBXc3ewD8r8FVom8ZotPy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="4224685"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="4224685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="45241571"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 23:28:00 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 23:27:59 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 23:27:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 23:27:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 23:27:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emLvWIdeCWp1xnjUDfxw0Jhea0yog9OeXPu0/vNwGk1LyYZVkRzxFl1c7zjxN0SIUIRTCsQA11BR7x4sqNDVTPQzUUECQly1X9S7rhhsf9oS67i8su6e2WpG6fQVRK9RVUlMe4SMSC2dxmy6oV4WXugg2OKQin5JYy3Nx/4nhs6A9NocmkMWFgoA5Vbgm1bOfjAo1iL9x4tvIrZwl0SedrY0v+sSrCpDtoNGnBsDOoxpQdR7aymzxBPswcII3KzcYhappjJ/BBuBcNJNr42AT8VtaimSoLJOvve6p7mtzREMH86cogTUS8Q94OC+nYVuHb8Jd8A1G2j0Mn8MpTLcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16hwUVAhqLo8dQNA9ODcAmHgIR8jSGS5OsQmi1ltH1E=;
 b=VhVkuOZRdJ0p6YuBp0i8Dxp3EqbGBdG9lCqRHiCyzx9cm7ymQj02KnhOxjMoR4S7DJ9ruijd1qU7kUtRtAWyzHV38QCPF+KZ/ulUgkV+rBg1y59UDmv4pVJ0ibjW7NShHAyANkBKQa4r8jzfjru1zqk9UbsV3VKEi3h/fqgzaxKJlILBffbi7ZZJlAsqTgHWw3v+E3jS5qC04wfUU6+nm5bU42HlriVAzVGM7EQAIxOUnKeg0hui9QtlOTc/8cXIAMJpDX0Sd4NBf1SO+16ZmUAYqbP1QSJMrYjgu03XAGO44N96A9jBxxnRjmezhzyisVp+jJbfDpWfD9YsJlQ4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Thu, 29 Feb
 2024 07:27:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.024; Thu, 29 Feb 2024
 07:27:56 +0000
Date: Thu, 29 Feb 2024 15:27:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steve French
	<sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, "Rohith
 Surabattula" <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [dhowells-fs:cifs-netfs] [cifs]  a05396635d:
 filebench.sum_operations/s -98.8% regression
Message-ID: <202402291526.7c11cd51-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3cf6aa-a30d-4a36-8908-08dc38f7f27a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3BGfyKpEZah+MQll17mhKDV/9uS4BTNDnADR+qg7byXsF0NQrEvamuCFsozyeT538w58swuUIEt5/AeGbiw2KTxJac0zOwZieb6xHrl9qvm4GPesxPOW4TRmz7Xe63jfnC4MYIt091bHheilE5Jpv/hSLzsvZQQRrUU7krPiBVjADTnwIfDf9QdhJyggrMmJi9D1Iy00/3eOj2aNLd2C4dCFBPhrw7sMbVjxiPn/4QWLn8u/mpStyFvHYgt6nbwmMi8WEgJee5yMJSQEte5J//Z5imWytEugMXqRDL6hsCnwjajfQYZCZcbd4rnlM++RGVaTlpqZRrnsPAatKENqjE3irMcU2JoMjs3KFkEMmFS9Ca3A7Kl6tbJ7gBU/U9+dGdra6/qGu7d9kLLglpg7fpYyS0VIcHHDWbTr+NzWR2wAQOptcuxz1TK89xFjXjw6R+YsC+1I+hZCc6IgA2exkWn4Gg0ywr28tYShf7TVM17U1ncrc/qdl1K7oFO9I+800tJFYKQsh1p8P55hIDPBvk6De1eGLKH3TSa8ApgC8W+aLX4QlHDxQ7JCSGZAc/NZlzi8C+sZ48uLjPTa7LzdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4hC9fiOwSzJMj1M123j8k0WF1Tu5LmTqXPXgpU5/wSBlL+tFjGlOvKIth+?=
 =?iso-8859-1?Q?m+JgHSQe3xgopJ0icyeOYGkv6WkfyAviSTsVlmgcyOx8OjHeyUoMTRxMKb?=
 =?iso-8859-1?Q?lyAembU5/GkDOcE9qnB3Ko/DY4VvA0+45LXwh+yydHqXcbxbC8miblW2Jf?=
 =?iso-8859-1?Q?EQoVCfi3HXXaZsxCCmXqMXETlF/B6NV9W2hjjoHLyKpoMm03gOT9J6suA/?=
 =?iso-8859-1?Q?uMRs2YO3X+kqybYF/sj00S27mz/cqVJzDbWsRnUZJze4X4SRoc1pjNyoAV?=
 =?iso-8859-1?Q?1fX9c4Jaf0YUke7JZ3PK3VS6PFsZ8BXqzUlwM2WMRNhTvVlCCuR96BjNg/?=
 =?iso-8859-1?Q?PIJLgO5ND9/2LlXZAZQxCiXXYBSk90FgEfEY1zEsPcH9fNs3exTfV90qxn?=
 =?iso-8859-1?Q?F39tmleWl1twXO6V+yJLlfuLca8VnA/fFOhaLXozHgDJ1jmA+yAQXalVF9?=
 =?iso-8859-1?Q?excDLkFPW7PQBD4Kr8vXWgJpBN6wu8e/P8mZBILlpBmgj/etVZGzwAnRwE?=
 =?iso-8859-1?Q?RPsksxrm081MWf/6vaHF+9akTLMeOiDepuQ6w6PTEQcACBeJs3xBg3lVV7?=
 =?iso-8859-1?Q?fjrc5LGzzHym+hlI6UaN4NeUPYbGsN87VWDfAB7W9yuXFCXc4/CPOmHM1o?=
 =?iso-8859-1?Q?B3T0OMc13go/HIqLN97jHznCFz7uOXOwaxXJU7T9NLyNOmBG5Nd6mO+K7E?=
 =?iso-8859-1?Q?uMRadTeNfFksiMIRC70Wo4FZjjB/+A6MUlZI1TOKmPMODG/pBy9CvyjGHM?=
 =?iso-8859-1?Q?HdP6xUkNnujyXwDYb/J+xnNruXCljGri+zquPVzXWuTFqaAuNruLIlAZYO?=
 =?iso-8859-1?Q?LTqtJVHWjw77ZlXIxQEkXvxkHLhdsyG/afzOfqWXP4GC1+11xx10/fyHGH?=
 =?iso-8859-1?Q?HNcjd4hY6JKLn1C/D48F5FsVp2PHNZcBEs1/ReL8QY1ovdp7wH1QAZ2z/c?=
 =?iso-8859-1?Q?PWWHQwkMF+i3QP/hVqK2JK/mB9u4fCANzmfOb60O1xtY8W3PwYMwtoKi1v?=
 =?iso-8859-1?Q?vrnKUby3KJXgqNfV0kQsFsvqoc+9/ZnNL7whYu0RuSCZ+cM9gT2OflMFn/?=
 =?iso-8859-1?Q?3+gc2tyNctysCN7KcWJPw47xY9KiY+2o/jzNWALZ25HogfpNbrburY9ahf?=
 =?iso-8859-1?Q?HDS7yfxKCv8wl3mp6Aw0EwaGYjNec64J6dL08vr8IuKUb2AU2BR2aOSQMo?=
 =?iso-8859-1?Q?C075MAXQNUVVPOlWUclj2XMikYaJjEh+vENr7wfiSY4p+KTpy6NG8Jw0j+?=
 =?iso-8859-1?Q?Ai0WBDSiUSavLtzqWYgBkKM+fBycCPjMPg/KKUkkj4iWQdxiIGsAroIJy/?=
 =?iso-8859-1?Q?FH6NgKPI7ndtM7cw0X/unihHGnw8UOokPx9QbgLLMJGiakepz7yGcar3GH?=
 =?iso-8859-1?Q?i7NC2+VMgCBzA50s1dfY0EXBkvvbbCdlLB6wxF8XZUgn2BOeecMJXfk597?=
 =?iso-8859-1?Q?6+UCx/Wz3yj6LM5UOKThRqpcDJO8r0TN8KrtP5JZDuo3hXQVJOlzyuzGwZ?=
 =?iso-8859-1?Q?r7CyKsZhwkh4vcjS6UGTZs3NNkHh5SN4tS2/+NIXllSfENro1Dyp4PqfvZ?=
 =?iso-8859-1?Q?514a7E+oQu5GJ+IP+TgsseEuR4UcA1Y+38eSvwJtJUC5Od1QizkPZKb0vT?=
 =?iso-8859-1?Q?zlGvQqIpI5ORAk8FBolrR9k6ZVx2qW+etJrwAeihdjCI80dTuA2Ye6jw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3cf6aa-a30d-4a36-8908-08dc38f7f27a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 07:27:56.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fs88ZzxLtmkn1KZvu4fnLy8aMmCyC41ZZoR5vBDDzlf5YGfSv3SRL7MmxBgh0gjwBhK7P7cvVSOUp2JM46ltOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -98.8% regression of filebench.sum_operations/s on:


commit: a05396635dc359f7047b4e35d2fdc66cd79bc3ee ("cifs: Cut over to using netfslib")
https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git cifs-netfs

testcase: filebench
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: btrfs
	fs2: cifs
	test: randomrw.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402291526.7c11cd51-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240229/202402291526.7c11cd51-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/btrfs/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/randomrw.f/filebench

commit: 
  f016508de3 ("cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c")
  a05396635d ("cifs: Cut over to using netfslib")

f016508de30bff78 a05396635dc359f7047b4e35d2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    366.67 ± 56%    +327.0%       1565 ± 20%  perf-c2c.HITM.local
      3.27 ±  7%      +0.8        4.10        mpstat.cpu.all.irq%
      1.28 ± 29%      -1.1        0.14 ±  8%  mpstat.cpu.all.sys%
      0.15 ± 14%      -0.1        0.06 ±  2%  mpstat.cpu.all.usr%
     67201           -42.4%      38722 ±  2%  vmstat.io.bo
      6.43           -13.8%       5.55 ±  2%  vmstat.memory.buff
      2.04 ± 40%     -80.5%       0.40 ±  9%  vmstat.procs.r
    770257 ± 81%     -77.9%     170216 ± 44%  numa-meminfo.node0.AnonPages
   2815098 ± 48%     -89.3%     301906 ± 33%  numa-meminfo.node0.AnonPages.max
    774717 ± 81%     -77.0%     177831 ± 43%  numa-meminfo.node0.Inactive(anon)
   4906919 ± 30%     -88.5%     562079 ±127%  numa-meminfo.node1.Active
     67755 ± 28%     -27.0%      49485 ±  4%  numa-meminfo.node1.Active(anon)
   4839164 ± 31%     -89.4%     512593 ±139%  numa-meminfo.node1.Active(file)
   2429235 ± 21%     -90.9%     221192 ±157%  numa-meminfo.node1.Dirty
    102.17 ± 12%     -41.8%      59.50        turbostat.Avg_MHz
      1646 ±  6%     -40.8%     975.00 ±  2%  turbostat.Bzy_MHz
    207440 ± 55%     -71.9%      58371 ± 33%  turbostat.C1
    908208 ± 58%    +149.2%    2263209 ±  7%  turbostat.C1E
     89634 ± 66%     -85.5%      13012 ±  4%  turbostat.POLL
    177.44           -17.9%     145.73        turbostat.PkgWatt
    196.62            -1.7%     193.26        turbostat.RAMWatt
      6445 ± 13%     -98.8%      75.82 ±  7%  filebench.sum_bytes_mb/s
  49504320 ± 13%     -98.8%     582393 ±  7%  filebench.sum_operations
    825011 ± 13%     -98.8%       9705 ±  7%  filebench.sum_operations/s
    446193 ± 15%     -98.9%       4924 ±  7%  filebench.sum_reads/s
      0.00        +10050.0%       0.20 ±  5%  filebench.sum_time_ms/op
    378818 ± 13%     -98.7%       4781 ±  7%  filebench.sum_writes/s
  36223497 ± 17%    -100.0%       0.00        filebench.time.file_system_outputs
     72.33           -95.4%       3.33 ± 14%  filebench.time.percent_of_cpu_this_job_got
    102.51 ±  3%     -93.7%       6.43 ± 12%  filebench.time.system_time
     19.94 ± 18%     -98.6%       0.28 ±  9%  filebench.time.user_time
     66626 ± 95%    +778.0%     584989 ±  7%  filebench.time.voluntary_context_switches
    192593 ± 81%     -77.9%      42554 ± 44%  numa-vmstat.node0.nr_anon_pages
    193708 ± 81%     -77.0%      44457 ± 43%  numa-vmstat.node0.nr_inactive_anon
    193708 ± 81%     -77.0%      44457 ± 43%  numa-vmstat.node0.nr_zone_inactive_anon
     16939 ± 28%     -27.0%      12371 ±  4%  numa-vmstat.node1.nr_active_anon
   1209717 ± 31%     -89.4%     128098 ±139%  numa-vmstat.node1.nr_active_file
   4365951 ± 26%     -89.7%     451077 ±145%  numa-vmstat.node1.nr_dirtied
    607224 ± 21%     -90.9%      55289 ±157%  numa-vmstat.node1.nr_dirty
   4364476 ± 26%     -74.1%    1130525 ±127%  numa-vmstat.node1.nr_written
     16939 ± 28%     -27.0%      12371 ±  4%  numa-vmstat.node1.nr_zone_active_anon
   1209717 ± 31%     -89.4%     128098 ±139%  numa-vmstat.node1.nr_zone_active_file
    613248 ± 21%     -90.7%      57212 ±156%  numa-vmstat.node1.nr_zone_write_pending
   8414844           -78.7%    1793875 ±  5%  meminfo.Active
     70870 ± 26%     -25.0%      53122        meminfo.Active(anon)
   8343973           -79.1%    1740752 ±  5%  meminfo.Active(file)
   1060561 ± 62%     -65.4%     366619        meminfo.AnonPages
   1462800 ± 46%     -56.0%     643519        meminfo.Committed_AS
   3999161           -76.2%     949812        meminfo.Dirty
   2993310 ± 21%    +195.5%    8844258        meminfo.Inactive
   1084787 ± 60%     -64.3%     387289        meminfo.Inactive(anon)
   1908522 ±  7%    +343.1%    8456969        meminfo.Inactive(file)
      9353 ± 12%     -34.9%       6085        meminfo.PageTables
     98169 ± 19%     -21.2%      77321        meminfo.Shmem
     61703 ± 49%     -51.3%      30022 ±  4%  meminfo.Writeback
     34412 ± 47%     -87.4%       4346 ± 23%  sched_debug.cfs_rq:/.avg_vruntime.avg
    183836 ± 22%     -86.3%      25138 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.max
      6982 ± 92%     -95.9%     287.46 ± 34%  sched_debug.cfs_rq:/.avg_vruntime.min
     27635 ± 19%     -81.3%       5174 ± 17%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     34412 ± 47%     -87.4%       4346 ± 23%  sched_debug.cfs_rq:/.min_vruntime.avg
    183836 ± 22%     -86.3%      25138 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
      6982 ± 92%     -95.9%     287.46 ± 34%  sched_debug.cfs_rq:/.min_vruntime.min
     27635 ± 19%     -81.3%       5174 ± 17%  sched_debug.cfs_rq:/.min_vruntime.stddev
    946.39 ±  4%     -10.7%     844.94 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
    209.58 ±  5%     -10.6%     187.32 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    938.61 ±  4%     -10.4%     840.78 ±  5%  sched_debug.cfs_rq:/.util_avg.max
    208.81 ±  5%     -10.7%     186.45 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
     24.32 ± 22%     -45.7%      13.22 ± 35%  sched_debug.cfs_rq:/.util_est.avg
    693.56 ±  2%     -38.8%     424.28 ± 11%  sched_debug.cfs_rq:/.util_est.max
    111.18 ± 10%     -44.9%      61.23 ± 23%  sched_debug.cfs_rq:/.util_est.stddev
    134421 ± 81%    +203.9%     408479 ± 22%  sched_debug.cpu.nr_switches.max
      2172 ± 96%     -80.2%     430.94 ±  4%  sched_debug.cpu.nr_switches.min
     18269 ± 72%    +202.2%      55214 ± 12%  sched_debug.cpu.nr_switches.stddev
     73.17 ± 54%     -67.4%      23.89 ± 26%  sched_debug.cpu.nr_uninterruptible.max
    -41.61           -55.1%     -18.67        sched_debug.cpu.nr_uninterruptible.min
     13.17 ± 38%     -59.6%       5.32 ± 11%  sched_debug.cpu.nr_uninterruptible.stddev
     17719 ± 26%     -25.0%      13281        proc-vmstat.nr_active_anon
   2085401           -79.1%     435069 ±  5%  proc-vmstat.nr_active_file
    264806 ± 62%     -65.4%      91659        proc-vmstat.nr_anon_pages
   7404786 ± 11%     -77.7%    1652087 ±  2%  proc-vmstat.nr_dirtied
    999649           -76.2%     237433        proc-vmstat.nr_dirty
    270866 ± 60%     -64.3%      96829        proc-vmstat.nr_inactive_anon
    477101 ±  7%    +343.1%    2113828        proc-vmstat.nr_inactive_file
      2337 ± 12%     -34.9%       1521        proc-vmstat.nr_page_table_pages
     24546 ± 19%     -21.2%      19332        proc-vmstat.nr_shmem
     15460 ± 50%     -51.5%       7503 ±  4%  proc-vmstat.nr_writeback
   7402470 ± 11%     -52.3%    3528032 ±  2%  proc-vmstat.nr_written
     17719 ± 26%     -25.0%      13281        proc-vmstat.nr_zone_active_anon
   2085401           -79.1%     435069 ±  5%  proc-vmstat.nr_zone_active_file
    270866 ± 60%     -64.3%      96829        proc-vmstat.nr_zone_inactive_anon
    477101 ±  7%    +343.1%    2113828        proc-vmstat.nr_zone_inactive_file
   1015085           -75.9%     244924        proc-vmstat.nr_zone_write_pending
    245536 ± 60%     -94.9%      12642 ± 23%  proc-vmstat.numa_hint_faults
    183808 ± 69%     -94.8%       9568 ± 16%  proc-vmstat.numa_hint_faults_local
   4814514 ± 16%     -24.3%    3646436        proc-vmstat.numa_hit
   4682055 ± 16%     -24.4%    3539376        proc-vmstat.numa_local
     75208 ± 73%     -86.0%      10525 ± 82%  proc-vmstat.numa_pages_migrated
    460513 ± 21%     -82.8%      79134 ± 10%  proc-vmstat.numa_pte_updates
   2639438           -78.1%     578107 ±  6%  proc-vmstat.pgactivate
   9375153 ± 14%     -41.5%    5480137        proc-vmstat.pgalloc_normal
   1492361 ± 25%     -56.6%     647374        proc-vmstat.pgfault
   8814351 ± 15%     -38.2%    5449272        proc-vmstat.pgfree
     75208 ± 73%     -86.0%      10525 ± 82%  proc-vmstat.pgmigrate_success
  11513882           -42.5%    6621853 ±  2%  proc-vmstat.pgpgout
     58851 ± 63%     -50.3%      29269 ±  3%  proc-vmstat.pgreuse
    789.83 ± 36%     -95.4%      36.33 ±  2%  proc-vmstat.thp_fault_alloc
      7.17 ±  9%     -85.0%       1.07 ± 13%  perf-stat.i.MPKI
  6.68e+08 ± 17%     -55.5%  2.975e+08 ±  2%  perf-stat.i.branch-instructions
      7.59 ±  4%      +2.3        9.92 ±  6%  perf-stat.i.branch-miss-rate%
      8.81 ±  5%      -7.4        1.39 ± 20%  perf-stat.i.cache-miss-rate%
  34419687 ±  9%     -92.2%    2684939 ± 18%  perf-stat.i.cache-misses
 2.303e+08 ±  6%     -41.0%  1.359e+08        perf-stat.i.cache-references
      4.67 ±  2%     +15.8%       5.40        perf-stat.i.cpi
 1.099e+10 ± 14%     -50.9%  5.398e+09        perf-stat.i.cpu-cycles
    664.70 ± 71%     -78.3%     144.02        perf-stat.i.cpu-migrations
      7387 ±  2%     +75.2%      12941 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.97 ±  2%      +0.4        1.37        perf-stat.i.dTLB-load-miss-rate%
 8.978e+08 ± 17%     -55.6%  3.988e+08 ±  2%  perf-stat.i.dTLB-loads
      0.25            +0.1        0.31 ±  2%  perf-stat.i.dTLB-store-miss-rate%
    495053 ±  7%     -17.3%     409523 ±  2%  perf-stat.i.dTLB-store-misses
 3.783e+08 ± 10%     -46.5%  2.024e+08 ±  2%  perf-stat.i.dTLB-stores
 3.294e+09 ± 17%     -55.2%  1.477e+09 ±  2%  perf-stat.i.instructions
      0.25 ±  5%     -10.2%       0.23 ±  2%  perf-stat.i.ipc
      0.09 ± 14%     -50.9%       0.04        perf-stat.i.metric.GHz
     15.93 ± 16%     -56.6%       6.91 ±  2%  perf-stat.i.metric.M/sec
      7478 ± 30%     -67.2%       2456        perf-stat.i.minor-faults
   4183111 ± 69%     -94.2%     243090 ± 56%  perf-stat.i.node-load-misses
   3532527 ± 84%     -94.6%     189686 ± 17%  perf-stat.i.node-loads
   3482820 ±105%     -93.7%     219634 ± 82%  perf-stat.i.node-store-misses
   6918310 ± 62%     -90.4%     662878 ± 10%  perf-stat.i.node-stores
      7478 ± 30%     -67.2%       2456        perf-stat.i.page-faults
     10.72 ± 15%     -83.1%       1.82 ± 17%  perf-stat.overall.MPKI
      2.99 ± 14%      +3.4        6.36 ±  7%  perf-stat.overall.branch-miss-rate%
     14.94 ±  5%     -13.0        1.98 ± 18%  perf-stat.overall.cache-miss-rate%
      3.36 ±  5%      +8.8%       3.66 ±  2%  perf-stat.overall.cpi
    320.58 ± 14%    +545.6%       2069 ± 15%  perf-stat.overall.cycles-between-cache-misses
      0.42 ± 17%      +0.5        0.90        perf-stat.overall.dTLB-load-miss-rate%
      0.13 ±  6%      +0.1        0.20 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
 6.643e+08 ± 17%     -55.5%  2.954e+08 ±  2%  perf-stat.ps.branch-instructions
  34259811 ±  9%     -92.2%    2667623 ± 18%  perf-stat.ps.cache-misses
  2.29e+08 ±  6%     -41.1%   1.35e+08        perf-stat.ps.cache-references
 1.093e+10 ± 14%     -50.9%  5.364e+09        perf-stat.ps.cpu-cycles
    661.95 ± 71%     -78.4%     143.11        perf-stat.ps.cpu-migrations
  8.93e+08 ± 17%     -55.6%  3.961e+08 ±  2%  perf-stat.ps.dTLB-loads
    492202 ±  7%     -17.3%     407012 ±  2%  perf-stat.ps.dTLB-store-misses
 3.764e+08 ± 10%     -46.6%  2.011e+08 ±  2%  perf-stat.ps.dTLB-stores
 3.276e+09 ± 17%     -55.2%  1.467e+09 ±  2%  perf-stat.ps.instructions
      7438 ± 30%     -67.2%       2439        perf-stat.ps.minor-faults
   4166071 ± 69%     -94.2%     241572 ± 57%  perf-stat.ps.node-load-misses
   3514062 ± 84%     -94.6%     188439 ± 17%  perf-stat.ps.node-loads
   3469703 ±105%     -93.7%     218414 ± 82%  perf-stat.ps.node-store-misses
   6883534 ± 61%     -90.4%     658670 ± 11%  perf-stat.ps.node-stores
      7439 ± 30%     -67.2%       2439        perf-stat.ps.page-faults
 5.535e+11 ± 18%     -55.3%  2.472e+11 ±  3%  perf-stat.total.instructions
      0.00 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.01 ± 36%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      0.01 ± 21%    +110.0%       0.02 ±  8%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.09 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.cleaner_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 59%     -80.3%       0.00 ± 36%  perf-sched.sch_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.00 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
      0.01 ± 29%    +101.7%       0.02 ± 18%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 35%    +129.2%       0.02 ±  4%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 58%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
      0.01 ± 79%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
      0.01 ± 68%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
      0.01 ± 29%     +66.7%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.02 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      0.01 ± 19%     +75.7%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 54%    +805.4%       0.11 ± 32%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 19%     +63.9%       0.04 ±  4%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.30 ± 40%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.01 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      0.06 ±135%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      0.25 ± 14%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      0.02 ± 33%    +106.9%       0.04 ± 62%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.09 ± 23%    -100.0%       0.00        perf-sched.sch_delay.max.ms.cleaner_kthread.kthread.ret_from_fork.ret_from_fork_asm
      4.45 ±143%     -96.8%       0.14 ± 20%  perf-sched.sch_delay.max.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.00 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
      0.02 ± 33%    +157.3%       0.05 ± 52%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 73%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
      0.02 ±136%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
      0.01 ± 68%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
      0.02 ± 42%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
     41.21 ± 34%    +265.4%     150.55 ±  5%  perf-sched.total_wait_and_delay.average.ms
     35294 ± 56%     -80.1%       7009 ±  6%  perf-sched.total_wait_and_delay.count.ms
      3612 ±  9%     +37.8%       4977        perf-sched.total_wait_and_delay.max.ms
     41.19 ± 34%    +265.4%     150.53 ±  5%  perf-sched.total_wait_time.average.ms
      3612 ±  9%     +37.8%       4977        perf-sched.total_wait_time.max.ms
      8.72 ± 18%     +35.2%      11.78        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.01 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.00 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      0.44 ± 99%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      0.18 ± 51%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      3.11 ± 45%     -97.7%       0.07 ± 18%  perf-sched.wait_and_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
     29.45 ± 19%    +165.1%      78.07 ± 24%  perf-sched.wait_and_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      1.23 ± 23%   +1435.4%      18.84 ± 24%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    999.94          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
    688.75 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
     19.70 ± 50%    +187.1%      56.55 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     67.85 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      0.13 ± 80%  +12207.2%      16.47 ± 23%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     75.06 ± 22%    +407.1%     380.59 ±  8%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4648 ± 92%    -100.0%       0.00        perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
    681.17 ±110%    -100.0%       0.00        perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      1762 ±117%    -100.0%       0.00        perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
    784.33 ± 34%    -100.0%       0.00        perf-sched.wait_and_delay.count.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
     10623 ± 82%     -97.8%     238.00 ± 32%  perf-sched.wait_and_delay.count.futex_wait_queue.__futex_wait.futex_wait.do_futex
     27.17 ± 16%     -22.7%      21.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      4396 ± 24%     -88.8%     493.67 ± 31%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      7.00 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
      3.50 ± 85%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
      1.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      1380 ± 64%     -82.5%     241.83 ± 31%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      4996 ± 47%     -87.4%     631.50 ±  5%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2757 ± 32%     +80.5%       4977        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.72 ± 53%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.07 ±129%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
    304.09 ±102%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      2.77 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      1000           -99.9%       0.93 ± 22%  perf-sched.wait_and_delay.max.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
    329.46 ± 19%     +55.6%     512.76 ±  8%  perf-sched.wait_and_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      1576 ± 16%     -36.5%       1000        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    499.97          +211.0%       1554 ± 14%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
    999.69          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
     67.85 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
     69.35 ±117%   +2142.1%       1554 ± 14%  perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.01 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.cifs_write_begin.generic_perform_write
      8.72 ± 18%     +35.2%      11.78        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.01 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.cifs_strict_writev.vfs_write.__x64_sys_pwrite64
      0.01 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.00 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      0.44 ± 99%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      0.17 ± 52%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      5.96 ±107%   +2687.1%     166.05 ± 31%  perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_do_write_iter
     16.05 ±114%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.09 ± 45%     -97.8%       0.07 ± 18%  perf-sched.wait_time.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      6.95 ± 42%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
     29.44 ± 19%    +164.2%      77.78 ± 24%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      3.38 ±  6%     +31.2%       4.43 ±  7%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1.22 ± 23%   +1440.1%      18.83 ± 24%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     16.73 ±105%   +1142.3%     207.81 ± 58%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    999.93          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
    688.74 ± 37%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
      1.37 ±105%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
     23.93 ± 19%    +136.2%      56.52 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     67.83 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      0.13 ± 84%  +12930.6%      16.46 ± 23%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      5.58 ±215%    -100.0%       0.00        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     75.03 ± 22%    +407.2%     380.55 ±  8%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 76%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.cifs_write_begin.generic_perform_write
      2757 ± 32%     +80.5%       4977        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ± 43%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.cifs_strict_writev.vfs_write.__x64_sys_pwrite64
      1.70 ± 54%    -100.0%       0.00        perf-sched.wait_time.max.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.06 ±135%    -100.0%       0.00        perf-sched.wait_time.max.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
    304.04 ±102%    -100.0%       0.00        perf-sched.wait_time.max.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      2.74 ± 20%    -100.0%       0.00        perf-sched.wait_time.max.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
    833.98 ± 84%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1000           -99.9%       0.84 ± 25%  perf-sched.wait_time.max.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      6.95 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
    329.45 ± 19%     +55.6%     512.75 ±  8%  perf-sched.wait_time.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      1576 ± 16%     -36.5%       1000        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    499.95          +211.0%       1554 ± 14%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    520.29 ± 61%    +335.4%       2265 ± 19%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
    999.67          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
      1.37 ±105%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
     67.83 ± 15%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
     69.26 ±117%   +2144.9%       1554 ± 14%  perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     60.14 ±220%    -100.0%       0.00        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.95 ±  6%      -0.1        0.82 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.81 ±  4%      -0.1        0.70 ±  6%  perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call
      0.88 ± 10%      +0.2        1.06 ±  7%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.48 ± 45%      +0.2        0.67 ±  3%  perf-profile.calltrace.cycles-pp.arch_cpu_idle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.47 ± 46%      +0.2        0.69 ± 13%  perf-profile.calltrace.cycles-pp.irqtime_account_process_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.93 ±  4%      +0.3        1.20 ±  6%  perf-profile.calltrace.cycles-pp.run_posix_cpu_timers.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      1.34 ±  5%      +0.3        1.65 ±  3%  perf-profile.calltrace.cycles-pp.timerqueue_del.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.73 ±  4%      +0.3        1.04 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_idle.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.56 ±  5%      +0.4        0.93 ±  6%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.14 ±  2%      +0.4        3.50 ± 13%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.36 ± 71%      +0.4        0.75 ±  9%  perf-profile.calltrace.cycles-pp.irqentry_enter.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.58 ±  5%      +0.4        0.98 ±  5%  perf-profile.calltrace.cycles-pp.tick_check_oneshot_broadcast_this_cpu.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.09 ±223%      +0.5        0.55 ±  7%  perf-profile.calltrace.cycles-pp.rb_erase.timerqueue_del.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.28 ±  4%      +0.5        1.79 ± 17%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00            +0.5        0.55 ±  5%  perf-profile.calltrace.cycles-pp.nr_iowait_cpu.tick_nohz_stop_idle.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt
      0.71 ± 15%      +0.6        1.34 ± 19%  perf-profile.calltrace.cycles-pp.check_cpu_stall.rcu_pending.rcu_sched_clock_irq.update_process_times.tick_sched_handle
      0.00            +0.7        0.67 ±  7%  perf-profile.calltrace.cycles-pp.rb_next.timerqueue_del.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.47 ±  9%      +0.7        2.14 ± 10%  perf-profile.calltrace.cycles-pp.rcu_pending.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      1.71 ±  8%      +0.7        2.42 ±  8%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      5.17 ±  2%      +0.8        5.97 ±  4%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      2.76 ±  4%      +0.9        3.68 ±  2%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.62 ±  5%      +1.0        3.58 ±  2%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      9.43 ±  2%      +2.3       11.70 ±  4%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
     10.57 ±  2%      +2.5       13.04 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
     11.85 ±  2%      +2.8       14.66 ±  5%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     95.06            +3.0       98.02        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     93.90            +3.1       96.97        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     93.90            +3.1       96.97        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     93.76            +3.1       96.86        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     92.07            +3.1       95.20        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     19.21            +3.1       22.36        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     81.45            +3.2       84.68        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     22.86            +3.2       26.09        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
     23.16            +3.3       26.50        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     82.52            +3.6       86.13        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     33.90            +4.2       38.10        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     39.33            +4.5       43.82        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.58 ± 41%      -3.1        0.45 ± 12%  perf-profile.children.cycles-pp.kthread
      3.58 ± 41%      -3.1        0.47 ± 12%  perf-profile.children.cycles-pp.ret_from_fork
      3.58 ± 41%      -3.1        0.47 ± 12%  perf-profile.children.cycles-pp.ret_from_fork_asm
      2.16 ± 19%      -2.0        0.19 ± 28%  perf-profile.children.cycles-pp.worker_thread
      2.14 ± 20%      -2.0        0.17 ± 35%  perf-profile.children.cycles-pp.process_one_work
      4.74 ±  3%      -0.6        4.17 ±  4%  perf-profile.children.cycles-pp.__do_softirq
      5.47 ±  4%      -0.5        4.93 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      1.12 ±  5%      -0.2        0.91 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      1.81 ±  4%      -0.2        1.64 ±  5%  perf-profile.children.cycles-pp.irqtime_account_irq
      1.29 ±  3%      -0.2        1.13 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      1.24 ±  5%      -0.1        1.09 ±  5%  perf-profile.children.cycles-pp.read_tsc
      0.65 ±  9%      -0.1        0.52 ±  5%  perf-profile.children.cycles-pp.rb_insert_color
      0.98 ±  5%      -0.1        0.86 ±  8%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.84 ±  5%      -0.1        0.72 ±  6%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.33 ± 14%      -0.1        0.22 ± 17%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      1.06 ±  5%      -0.1        0.98 ±  5%  perf-profile.children.cycles-pp.sched_clock
      0.61 ±  7%      -0.1        0.53 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.18 ± 11%      -0.1        0.11 ± 15%  perf-profile.children.cycles-pp.hrtimer_forward
      0.08 ± 24%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
      0.15 ± 18%      -0.0        0.11 ± 15%  perf-profile.children.cycles-pp.cpu_util
      0.14 ± 12%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.sched_idle_set_state
      0.09 ± 23%      +0.0        0.13 ±  8%  perf-profile.children.cycles-pp.__memcpy
      0.24 ±  8%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.16 ± 17%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.ct_irq_enter
      0.20 ± 17%      +0.1        0.27 ± 14%  perf-profile.children.cycles-pp.__schedule
      0.18 ± 21%      +0.1        0.26 ±  8%  perf-profile.children.cycles-pp.check_tsc_unstable
      0.25 ± 12%      +0.1        0.35 ± 13%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.22 ±  9%      +0.1        0.32 ±  9%  perf-profile.children.cycles-pp.account_process_tick
      0.22 ± 18%      +0.1        0.32 ± 19%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.56 ±  9%      +0.1        0.67 ±  4%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.58 ±  8%      +0.1        0.69 ±  3%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.21 ± 13%      +0.1        0.33 ± 10%  perf-profile.children.cycles-pp.native_apic_mem_eoi
      0.56 ± 11%      +0.1        0.70 ± 13%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.46 ±  5%      +0.1        0.60 ±  4%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.65 ±  9%      +0.2        0.82 ±  6%  perf-profile.children.cycles-pp.rb_next
      2.40 ±  3%      +0.2        2.60 ±  2%  perf-profile.children.cycles-pp.perf_rotate_context
      0.59 ± 12%      +0.2        0.84 ±  7%  perf-profile.children.cycles-pp.irqentry_enter
      0.94 ±  5%      +0.3        1.22 ±  6%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      1.39 ±  5%      +0.3        1.69 ±  2%  perf-profile.children.cycles-pp.timerqueue_del
      0.75 ±  4%      +0.3        1.07 ±  5%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.60 ±  5%      +0.3        0.95 ±  6%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      3.22 ±  2%      +0.3        3.56 ± 13%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.64 ±  3%      +0.4        1.07 ±  4%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      1.29 ±  4%      +0.5        1.81 ± 17%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.72 ± 15%      +0.6        1.35 ± 18%  perf-profile.children.cycles-pp.check_cpu_stall
      1.50 ± 10%      +0.7        2.17 ± 10%  perf-profile.children.cycles-pp.rcu_pending
      1.74 ±  9%      +0.7        2.45 ±  8%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      5.32 ±  2%      +0.8        6.12 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      2.79 ±  5%      +0.9        3.72 ±  2%  perf-profile.children.cycles-pp.irq_enter_rcu
      2.74 ±  4%      +0.9        3.68 ±  2%  perf-profile.children.cycles-pp.tick_irq_enter
      9.66 ±  2%      +2.3       11.94 ±  4%  perf-profile.children.cycles-pp.update_process_times
     10.68 ±  2%      +2.5       13.18 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
     12.02 ±  2%      +2.8       14.84 ±  5%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
     95.06            +3.0       98.02        perf-profile.children.cycles-pp.cpu_startup_entry
     95.06            +3.0       98.02        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     95.06            +3.0       98.02        perf-profile.children.cycles-pp.do_idle
     93.41            +3.0       96.42        perf-profile.children.cycles-pp.cpuidle_idle_call
     93.90            +3.1       96.97        perf-profile.children.cycles-pp.start_secondary
     19.49            +3.2       22.65        perf-profile.children.cycles-pp.__hrtimer_run_queues
     23.14            +3.2       26.38        perf-profile.children.cycles-pp.hrtimer_interrupt
     23.40            +3.4       26.76        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     83.59            +3.5       87.13        perf-profile.children.cycles-pp.cpuidle_enter
     83.12            +3.6       86.71        perf-profile.children.cycles-pp.cpuidle_enter_state
     34.32            +4.3       38.58        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     37.37            +4.5       41.84        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.00 ±  8%      -0.2        0.76 ±  7%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      1.12 ±  5%      -0.2        0.91 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      1.25 ±  3%      -0.1        1.10 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      1.20 ±  5%      -0.1        1.06 ±  5%  perf-profile.self.cycles-pp.read_tsc
      0.62 ±  9%      -0.1        0.50 ±  6%  perf-profile.self.cycles-pp.rb_insert_color
      0.60 ±  9%      -0.1        0.51 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.38 ± 12%      -0.1        0.31 ±  7%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.15 ± 12%      -0.1        0.10 ± 19%  perf-profile.self.cycles-pp.hrtimer_forward
      0.32 ±  6%      -0.0        0.28 ±  5%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.10 ± 13%      -0.0        0.07 ± 23%  perf-profile.self.cycles-pp.sched_idle_set_state
      0.09 ± 24%      +0.0        0.13 ±  7%  perf-profile.self.cycles-pp.__memcpy
      0.22 ±  9%      +0.1        0.28 ± 10%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.20 ± 15%      +0.1        0.26 ± 11%  perf-profile.self.cycles-pp.local_clock_noinstr
      0.10 ± 28%      +0.1        0.16 ± 11%  perf-profile.self.cycles-pp.ct_irq_enter
      0.15 ± 22%      +0.1        0.22 ± 11%  perf-profile.self.cycles-pp.check_tsc_unstable
      0.20 ± 16%      +0.1        0.28 ± 10%  perf-profile.self.cycles-pp.sched_clock
      0.37 ± 11%      +0.1        0.45 ±  3%  perf-profile.self.cycles-pp.irq_work_tick
      0.24 ± 21%      +0.1        0.32 ±  8%  perf-profile.self.cycles-pp.irqentry_enter
      0.25 ± 14%      +0.1        0.35 ± 12%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.21 ± 11%      +0.1        0.31 ±  8%  perf-profile.self.cycles-pp.account_process_tick
      0.22 ± 18%      +0.1        0.32 ± 20%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.20 ± 13%      +0.1        0.33 ± 10%  perf-profile.self.cycles-pp.native_apic_mem_eoi
      0.56 ± 11%      +0.1        0.70 ± 13%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.44 ±  5%      +0.2        0.59 ±  5%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.32 ±  4%      +0.2        0.48 ±  9%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
      0.64 ±  8%      +0.2        0.82 ±  6%  perf-profile.self.cycles-pp.rb_next
      0.94 ±  9%      +0.2        1.12 ±  6%  perf-profile.self.cycles-pp.perf_rotate_context
      0.94 ±  5%      +0.3        1.21 ±  6%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.39 ±  5%      +0.4        0.78 ±  8%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.62 ±  4%      +0.4        1.05 ±  4%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      1.28 ±  4%      +0.5        1.80 ± 17%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      1.06 ±  6%      +0.5        1.60 ± 55%  perf-profile.self.cycles-pp.ktime_get
      0.72 ± 15%      +0.6        1.34 ± 19%  perf-profile.self.cycles-pp.check_cpu_stall




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


