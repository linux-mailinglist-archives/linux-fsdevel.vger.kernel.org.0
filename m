Return-Path: <linux-fsdevel+bounces-5453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59580C27F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 08:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817611F21007
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 07:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D120B1A;
	Mon, 11 Dec 2023 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtWrJosY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FF9FE;
	Sun, 10 Dec 2023 23:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702281485; x=1733817485;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NhSIdIj1u7QiLkF4r9Q4N3h47baSrI5FF+Hko4dWfHA=;
  b=WtWrJosYDuBgP99jaEtXWDuxUhkAzLv6qBWlW7hIqinobsmTDixI2KPt
   6aN0OzP6avJHJ06hXnQr7+kV5XY10rPRTg9h/1FE9SY8cXBO+dh7+xSOK
   9J+dx3rFZqpKYWWLya1m1DcHkAXlB8LM/EwGJT4V5Ibr714WxW/2EAg3J
   hdC6U162pWzwguKyKiX/UXRdgo1sx9B2k8V2z8voELgx2fUx726Ugjvl/
   XjgaMFPsBgxiGovchwvo1zrxRd/u62vXB1zFuyj4DKyBsHaakC7SZHfDo
   HjK1YxryJA336ScsRN9bUGKXtOIWqvnNYrQuw9+dLlQsD6cvb1bR/JW1n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="394345901"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="394345901"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 23:58:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="772947141"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="772947141"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 23:58:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 23:58:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 23:58:02 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 23:58:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX1LGgwX0DIHwa9dI/uwasmwMF1fhfhaFZK92kCIBRJ2XtwYOrvOttFgV9zEjXyZUNDFAHjOmRoQSZ6fJ/nBVU4AhFp21tG0ASTAOh9Dwb3ZqHbOjCF8DL/VRHmW6r1Jsr/+x2CarJiyANsZQiXNmWzjLi3MW64uGTJVZG74JvXYbMcMahiZeIsDWwe2X7f7FV8kHP2fdJVfXofuyu7T7okR71yv6loJTGJBTIux3nnoRZ3lmg7RbK4u7LGRKkcApV9wDy+qw5F44mLOeYMwhNAEisMp3p3TehKXJFt8qBVtl2oqYcDzsx5Hdc8PJjRDyFwX/lt8c/bnuS9M+YAyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XakeFH5qKMQIUji+yZo7ilI4bCmbi595+i3tObAvevI=;
 b=mN/LYpab3ruyKS9KibeBAtodbLkiCXNZoX5YoBZkcMmaKbAhhdebDZ+FA1dZtYlxfgmdmK0EYtE6owJTZHOa57R0RlNyWzcmqC+eCCaLtDA6HZFhoagMEtpN+L3WDGmKvjt67ebl62Wmk1jAVvMX77tZqDu2GS+Riq0h2QPPfEQkkqbXpvTpEJHLakodHH7bcvppegDRYAU3N4SMJQY60GxeAqcu1ct46u1M+ViDBqX08lxKjpll6VOvywE6KUsBfCdSISchGAgcCFho2PIoFDNVjBxp0fFhfs6OP2HCGfHY4X4UemtdGwQ68sY+9NHtOLZvoJUAKgbXEW7LzgsQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 07:57:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 07:57:55 +0000
Date: Mon, 11 Dec 2023 15:57:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-security-module@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, Christian Brauner
	<brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, Paul Moore
	<paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, James Morris
	<jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi
	<miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<audit@vger.kernel.org>, <linux-unionfs@vger.kernel.org>, "Seth Forshee
 (DigitalOcean)" <sforshee@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH 15/16] commoncap: use vfs fscaps interfaces for killpriv
 checks
Message-ID: <202312111506.39e728bf-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129-idmap-fscap-refactor-v1-15-da5a26058a5b@kernel.org>
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 977b0397-7e90-47e7-4a16-08dbfa1ee1f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3zRDK4P3LTsPZ/WYLetukmwCfOLf5Rt4tur+XpX3Wps7xNk2/Y4x6wUHOKiTpIyFMJcQiPWskk8balf4H1psyHCIlvYPq379bTyFbOtFEDdToUbV4GNrtH9Cpt1Ic6BUE6RdzyCtrR51bOPlkPFLd7q9xTdunqDJcryfKpJhlpnBMoPChKWCAm7Yu4Ck9sjCVtZw/rJaHI9QUaQ3F0X0TJAVUgOmzqXIgRoBlthRQvnZSuaJZ3wYclzLGmwzL0ui1C7/YMGd9A62nSZ7eHt+eSEDA4x0iHO9ag5bSCbNHWVY78C/sz5rKeBu/9gb6ePjhjkpv+3Q0ZyepUDNJZR7gaRmssrKGp8xVjkpgWWy3BWuG+SW2/xd1oP/Eo9AYg0uTLwJYZ1XiUummEow8Jz9Q/vsbLwz+2KWEqCfxsMxiXvlVfAfRwly6idbR4v9bQui6qxaGXDb3zqcro+Pg6QyqVJgEvJVjPr9Z0KYa+QPf93OPVcM585FhfTiJLqYSbqa41BWhKWuzKYR3ymq+pXTPO1vnqSi/DPnC3TTTDduWe4SsXuen/e2pptUfmwxihqOabwX9s83+NlpNulskfunGeuNQoXonmNQWGTEn30ww4KVFYQ9+3LgNDDdNbmiJQfX8ruDzpScE/1gUzEss19GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(230473577357003)(230373577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(478600001)(41300700001)(82960400001)(66556008)(66476007)(54906003)(6916009)(7416002)(66946007)(30864003)(966005)(6486002)(316002)(38100700002)(6666004)(86362001)(4326008)(8936002)(8676002)(6506007)(6512007)(36756003)(5660300002)(1076003)(107886003)(26005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zQp7bUx+WFnYj5YV4JUsqvlRSeGoSaIFqmbeZoZcsX9STTgPsfpWRmTSmT?=
 =?iso-8859-1?Q?KbOWjDcnLsVipK7bFyoF8Ct1snTqCngUxSrDQZ7ij0l6cK/Z50iYzeIhPC?=
 =?iso-8859-1?Q?e7i1S/1WsyMlEga2UvRdNO9nm4gmLRM1im+9yncpAThme5I00tk+Nj7ZgT?=
 =?iso-8859-1?Q?hIeuPJylJUM2KuzB7k9Rb23/X4kjbSUFnx6akYe2zz0f2nfluQy1sVXYkQ?=
 =?iso-8859-1?Q?+wSYnHU/xAwMCGYY9SakNdN0jKmwjJDpiKk/BGGzO5xIaMtT1x1BGhEz4L?=
 =?iso-8859-1?Q?cEabIUEWlfKeAl+dtdLEgxX2mgvReRo3YmfgSLGCOVZBIcnw/+oK5MyD+4?=
 =?iso-8859-1?Q?MuoWZGCjpQX7bbDnVxxQMraXSR3M+cD5oT8ATqWPYLNw086VXY9hPYkPDs?=
 =?iso-8859-1?Q?7TI6yhZxGy1zMrB0IvXNVPc1USCrgg55t6IrTQztmjB0amZ6UiRcIP7Scg?=
 =?iso-8859-1?Q?NLDZm3ofrMXD6W7m67odTfaUWvXrW4NZUwEFMD3mZ1mzBLx1yhuvYjA+ba?=
 =?iso-8859-1?Q?0TH1X/hjXBU+IEktdtpYZpoJDb+c3rI5XCDu9O8cBRpA7bSPuV8Ni4CRUw?=
 =?iso-8859-1?Q?FkQ+s4upQluV4fWMp8JYBRNikiZTNCiFe25+yEHc4G6YKiXvdgMG+HkBEV?=
 =?iso-8859-1?Q?OibXlGWvydT4JYnpjEOdUF48yQYBDuSnH5sknxJzi6+kDZF+AGE0xZx1Wb?=
 =?iso-8859-1?Q?OBhebJUciTGjGanPRnhIVC3ZsXbb2c7BzfpUEaJq6xrIKvj4TR/zSPDEl2?=
 =?iso-8859-1?Q?97Q3OjVZrjTCx/BAxXX8JIcx2EQb3zIEKPbNdKyhRjNIdwHAlMXrJxxalJ?=
 =?iso-8859-1?Q?Ol+lBfxCS3R7WU3tPEmn//UB0K9LtnRaouVACkDIFxHz1MyC3TrHCixaA4?=
 =?iso-8859-1?Q?33z4w2ON/4hGeG6uZ6k47cX9YDa33c5Zu7RLOtHsLwqfEpRGDaF54xppOi?=
 =?iso-8859-1?Q?68MBg1f0tF6EPOnCLh8PKyLwmJd50dAftqVk+F2gT439uTbiP/9JgTm6Ol?=
 =?iso-8859-1?Q?PBM0GmL3lyEdrVUNw9cJNcMtOWITfw/L5b01N0QhfRcV/boNuirAGQ5f77?=
 =?iso-8859-1?Q?RNIxU8YZYjFoKpRo4vmyubBuN0bz7NizPWZQKxaKyogJ12ykNXjp27mIgp?=
 =?iso-8859-1?Q?f6Yw4U3+acsMNTbcfo1eh3miaHL8k/To3imE+TFRBpuLuVasZT3mpi5w3I?=
 =?iso-8859-1?Q?sv2T+hwE7IhppIJSKh4kOiO3qTFCGNcnTOhjeblOKXGM4jPgEVUNDh11qU?=
 =?iso-8859-1?Q?AbWE43JowskjEV5vn1mgzK4UPxypI3JNO3XfUPwQXz5U2V8aMoWytA4Aeb?=
 =?iso-8859-1?Q?1AZ0EdvUZTYceSedHwsoW45A/VzZs5ogBNus6fI/THqK/pU5J1srk2+S4t?=
 =?iso-8859-1?Q?pa22aU5wzkiwjTVrl9jKhp5Rdc4wxxGO+c3rhdNspiWTZ2tGyQvE7CD72I?=
 =?iso-8859-1?Q?aGnhZj9hKA+bSghZEsHL++FtWbSJ6WjQL/xt9qUumOHs3WCEPWsUfCNc2t?=
 =?iso-8859-1?Q?mLCkZCx2ZAXhFDUMLXz4BTlV1lkgLfBu8hMFDm64rOq4UAOQTJ0T7+HdQ8?=
 =?iso-8859-1?Q?z1hKStPUiW6XAEi6s6wodD8zP1doJiPdbh05KduejNFzTtUOb/xQ+HWE1n?=
 =?iso-8859-1?Q?1FaX9C+Wq5lVd0zVuz0iNTx7FOGWCYzUuhZw0VGLCdj7JgrHJLHxpR8g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 977b0397-7e90-47e7-4a16-08dbfa1ee1f9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 07:57:55.2324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0De/Lgh2eAPEHtu2NF2/recyqIAWOKLyHzjYbniZ3RxHrFPWaNUGf38Ss9cuC1TH3SDfrUaDO1p3Wy0uzRyVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -3.4% regression of unixbench.score on:


commit: 4d9674015c6c6b0d3dd2013f7fbff6a8648e59dd ("[PATCH 15/16] commoncap: use vfs fscaps interfaces for killpriv checks")
url: https://github.com/intel-lab-lkp/linux/commits/Seth-Forshee-DigitalOcean/mnt_idmapping-split-out-core-vfs-ug-id_t-definitions-into-vfsid-h/20231130-055846
patch link: https://lore.kernel.org/all/20231129-idmap-fscap-refactor-v1-15-da5a26058a5b@kernel.org/
patch subject: [PATCH 15/16] commoncap: use vfs fscaps interfaces for killpriv checks

testcase: unixbench
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: fsbuffer
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312111506.39e728bf-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231211/202312111506.39e728bf-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp9/fsbuffer/unixbench

commit: 
  28b9eedcb5 ("commoncap: remove cap_inode_getsecurity()")
  4d9674015c ("commoncap: use vfs fscaps interfaces for killpriv checks")

28b9eedcb59f6969 4d9674015c6c6b0d3dd2013f7fb 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    442.83 ±  8%     +13.6%     503.17 ±  5%  perf-c2c.DRAM.local
    106496            -3.4%     102870        unixbench.score
  8.46e+09            -3.3%  8.181e+09        unixbench.workload
     22955 ±  9%     -15.1%      19480 ±  8%  sched_debug.cfs_rq:/.load.avg
     52666 ±  8%     -20.2%      42050 ±  6%  sched_debug.cfs_rq:/.load.stddev
    696.27 ± 10%     -22.2%     541.75 ±  9%  sched_debug.cpu.curr->pid.stddev
      0.15 ± 13%     -18.8%       0.12 ± 10%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
      0.23 ± 12%     -25.8%       0.17 ± 14%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    413.00 ±  4%     +17.7%     486.00 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
      0.15 ± 13%     -18.8%       0.12 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
      0.22 ± 14%     -28.2%       0.16 ± 13%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
 3.277e+10            +1.2%  3.316e+10        perf-stat.i.branch-instructions
 4.128e+08            -3.2%  3.997e+08        perf-stat.i.cache-references
    282058            -4.5%     269378        perf-stat.i.dTLB-load-misses
      7803 ± 44%     +24.8%       9740        perf-stat.overall.path-length
 2.728e+10 ± 44%     +21.4%  3.313e+10        perf-stat.ps.branch-instructions
     17.86            -1.0       16.83        perf-profile.calltrace.cycles-pp.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      6.26            -0.3        5.93        perf-profile.calltrace.cycles-pp.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      5.75            -0.3        5.43        perf-profile.calltrace.cycles-pp.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write
      3.71            -0.2        3.50        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3.79            -0.2        3.58        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      2.55            -0.2        2.34        perf-profile.calltrace.cycles-pp.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3.11 ±  2%      -0.2        2.93        perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
      2.34            -0.1        2.20        perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.08            -0.1        1.94        perf-profile.calltrace.cycles-pp.file_update_time.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      2.74            -0.1        2.62        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      1.70            -0.1        1.59        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.__generic_file_write_iter.generic_file_write_iter.vfs_write
      1.32 ±  2%      -0.1        1.23        perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.__filemap_get_folio.simple_write_begin.generic_perform_write
      1.20            -0.1        1.11 ±  2%  perf-profile.calltrace.cycles-pp.down_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.57 ±  3%      -0.1        0.52 ±  2%  perf-profile.calltrace.cycles-pp.xas_descend.xas_load.filemap_get_entry.__filemap_get_folio.simple_write_begin
      0.78 ±  2%      -0.0        0.74        perf-profile.calltrace.cycles-pp.up_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      1.01            -0.0        0.96        perf-profile.calltrace.cycles-pp.generic_write_checks.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.75            -0.0        0.71 ±  2%  perf-profile.calltrace.cycles-pp.folio_unlock.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write
      0.68 ±  5%      +0.1        0.77        perf-profile.calltrace.cycles-pp.xas_descend.xas_load.filemap_get_read_batch.filemap_get_pages.filemap_read
      1.72 ±  3%      +0.1        1.84        perf-profile.calltrace.cycles-pp.xas_load.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read
     43.59            +0.3       43.87        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     42.78            +0.3       43.10        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     40.44            +0.4       40.84        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     38.06            +0.5       38.58        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.6        0.55 ±  4%  perf-profile.calltrace.cycles-pp.xattr_resolve_name.vfs_getxattr_alloc.__vfs_get_fscaps.cap_inode_need_killpriv.security_inode_need_killpriv
     28.82            +0.9       29.74        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.5        1.47        perf-profile.calltrace.cycles-pp.strncmp.xattr_permission.vfs_getxattr_alloc.__vfs_get_fscaps.cap_inode_need_killpriv
      0.00            +1.8        1.84        perf-profile.calltrace.cycles-pp.xattr_permission.vfs_getxattr_alloc.__vfs_get_fscaps.cap_inode_need_killpriv.security_inode_need_killpriv
      6.70            +2.2        8.92        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      3.86            +2.4        6.26        perf-profile.calltrace.cycles-pp.__file_remove_privs.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      2.37            +2.5        4.90        perf-profile.calltrace.cycles-pp.security_inode_need_killpriv.__file_remove_privs.__generic_file_write_iter.generic_file_write_iter.vfs_write
      1.94            +2.6        4.52        perf-profile.calltrace.cycles-pp.cap_inode_need_killpriv.security_inode_need_killpriv.__file_remove_privs.__generic_file_write_iter.generic_file_write_iter
      0.00            +3.0        2.98        perf-profile.calltrace.cycles-pp.vfs_getxattr_alloc.__vfs_get_fscaps.cap_inode_need_killpriv.security_inode_need_killpriv.__file_remove_privs
      0.00            +4.1        4.08        perf-profile.calltrace.cycles-pp.__vfs_get_fscaps.cap_inode_need_killpriv.security_inode_need_killpriv.__file_remove_privs.__generic_file_write_iter
     18.27            -1.0       17.22        perf-profile.children.cycles-pp.generic_perform_write
      6.36            -0.3        6.03        perf-profile.children.cycles-pp.simple_write_begin
      5.96            -0.3        5.64        perf-profile.children.cycles-pp.__filemap_get_folio
      2.71            -0.2        2.49        perf-profile.children.cycles-pp.simple_write_end
      3.76            -0.2        3.55        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      3.21 ±  2%      -0.2        3.02        perf-profile.children.cycles-pp.filemap_get_entry
      2.23            -0.1        2.08        perf-profile.children.cycles-pp.file_update_time
      1.90            -0.1        1.77        perf-profile.children.cycles-pp.inode_needs_update_time
      2.86            -0.1        2.74        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      4.92            -0.1        4.81        perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.44            -0.1        2.33        perf-profile.children.cycles-pp.fault_in_readable
      1.31            -0.1        1.21 ±  2%  perf-profile.children.cycles-pp.down_write
      3.93            -0.1        3.86        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.55 ±  3%      -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.85 ±  3%      -0.1        0.79 ±  2%  perf-profile.children.cycles-pp.up_write
      0.56            -0.1        0.50        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.80            -0.1        0.75 ±  2%  perf-profile.children.cycles-pp.folio_unlock
      0.58 ±  2%      -0.0        0.53 ±  2%  perf-profile.children.cycles-pp.w_test
      1.16            -0.0        1.11        perf-profile.children.cycles-pp.generic_write_checks
      1.12            -0.0        1.07        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.54            -0.0        0.50 ±  2%  perf-profile.children.cycles-pp.folio_mapping
      0.62 ±  2%      -0.0        0.59        perf-profile.children.cycles-pp.timestamp_truncate
      0.52            -0.0        0.49 ±  2%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.42            -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.folio_wait_stable
      0.37            -0.0        0.35        perf-profile.children.cycles-pp.setattr_should_drop_suidgid
      0.22 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.inode_to_bdi
      0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.is_bad_inode
      0.58 ±  2%      +0.1        0.66 ±  4%  perf-profile.children.cycles-pp.xattr_resolve_name
      0.00            +0.3        0.27 ±  2%  perf-profile.children.cycles-pp.kfree
     86.62            +0.3       86.93        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     85.38            +0.3       85.71        perf-profile.children.cycles-pp.do_syscall_64
     40.67            +0.4       41.06        perf-profile.children.cycles-pp.ksys_write
     38.45            +0.5       38.96        perf-profile.children.cycles-pp.vfs_write
     29.06            +0.9       29.98        perf-profile.children.cycles-pp.generic_file_write_iter
      0.00            +1.5        1.54        perf-profile.children.cycles-pp.strncmp
      0.00            +2.0        2.00        perf-profile.children.cycles-pp.xattr_permission
      6.86            +2.2        9.07        perf-profile.children.cycles-pp.__generic_file_write_iter
      4.03            +2.4        6.42        perf-profile.children.cycles-pp.__file_remove_privs
      2.49            +2.5        5.00        perf-profile.children.cycles-pp.security_inode_need_killpriv
      2.07            +2.6        4.63        perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.00            +3.3        3.26        perf-profile.children.cycles-pp.vfs_getxattr_alloc
      0.00            +4.3        4.27        perf-profile.children.cycles-pp.__vfs_get_fscaps
      3.70            -0.2        3.49        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      3.91            -0.2        3.72        perf-profile.self.cycles-pp.vfs_write
      1.30            -0.1        1.18        perf-profile.self.cycles-pp.simple_write_end
      1.23            -0.1        1.12 ±  2%  perf-profile.self.cycles-pp.__file_remove_privs
      1.86            -0.1        1.75        perf-profile.self.cycles-pp.generic_perform_write
      2.37            -0.1        2.26        perf-profile.self.cycles-pp.fault_in_readable
      1.83            -0.1        1.73        perf-profile.self.cycles-pp.write
      0.90            -0.1        0.81 ±  3%  perf-profile.self.cycles-pp.down_write
      1.98            -0.1        1.89        perf-profile.self.cycles-pp.__filemap_get_folio
      7.88            -0.1        7.80        perf-profile.self.cycles-pp.__fsnotify_parent
      3.80            -0.1        3.73        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.97            -0.1        0.90 ±  2%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.80 ±  3%      -0.1        0.74 ±  2%  perf-profile.self.cycles-pp.up_write
      0.42            -0.0        0.36 ±  3%  perf-profile.self.cycles-pp.security_inode_need_killpriv
      0.52 ±  2%      -0.0        0.48 ±  2%  perf-profile.self.cycles-pp.w_test
      0.74            -0.0        0.70 ±  2%  perf-profile.self.cycles-pp.folio_unlock
      0.96            -0.0        0.91        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.71            -0.0        0.67        perf-profile.self.cycles-pp.ksys_write
      0.83            -0.0        0.79        perf-profile.self.cycles-pp.generic_file_write_iter
      0.38            -0.0        0.35        perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.42 ±  2%      -0.0        0.39 ±  3%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.43 ±  2%      -0.0        0.40 ±  2%  perf-profile.self.cycles-pp.folio_mapping
      0.28 ±  5%      -0.0        0.25 ±  2%  perf-profile.self.cycles-pp.folio_mark_dirty
      1.00            -0.0        0.97        perf-profile.self.cycles-pp.__get_task_ioprio
      1.22            -0.0        1.20        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.41            -0.0        0.39        perf-profile.self.cycles-pp.simple_write_begin
      0.39            -0.0        0.37 ±  2%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.36 ±  5%      +0.1        0.42 ±  6%  perf-profile.self.cycles-pp.xattr_resolve_name
      0.18 ±  3%      +0.2        0.36        perf-profile.self.cycles-pp.cap_inode_need_killpriv
      0.00            +0.2        0.18 ±  2%  perf-profile.self.cycles-pp.kfree
      0.00            +0.5        0.48        perf-profile.self.cycles-pp.xattr_permission
      0.00            +0.8        0.76        perf-profile.self.cycles-pp.vfs_getxattr_alloc
      0.00            +0.8        0.83        perf-profile.self.cycles-pp.__vfs_get_fscaps
      0.00            +1.4        1.42        perf-profile.self.cycles-pp.strncmp




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


