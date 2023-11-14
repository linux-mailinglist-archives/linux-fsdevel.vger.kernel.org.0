Return-Path: <linux-fsdevel+bounces-2818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B55A7EAACC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 08:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2854281118
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8783211733;
	Tue, 14 Nov 2023 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SH6irnOr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4411732
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:16:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E17B198;
	Mon, 13 Nov 2023 23:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699946162; x=1731482162;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=1mm+U/Gf6C9ZlmFQVJ42fF2iq/SO3Ujp2QlSMrNoEKA=;
  b=SH6irnOr6Ep5S9/MmV+Jtu18PASLgMX3Kak9ERov+b8cjEUG3vseJnkz
   AUj78HhG/36cGPF3jYJ313WB4kWYOn9b3bdakzOf8We/3SR4vbJnIzTBX
   bXU/rsJYyrV3QXSQbFqElkq0nBu8HfO5J/lAENzgKFcCQUQ+cJWVoSl2n
   7V9spY4wtbL05x2rVOAgFUfTILUlMUydyctsaLWsCPTX6y25EDRcy01mQ
   MvszTUNeaBNUPYNV4dzqHrauZ65aoLc8Wr2PPrjAzrsrTt4sG8niOi8cd
   j1O6AUBQAEY/MABGxFylT+Pn4sRRk//2MoCIxWHn0pbskPtNobLufY3f8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394511342"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="394511342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 23:16:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="830501215"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="830501215"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 23:16:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 23:15:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 23:15:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 23:15:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTBS0IH0hzc8r69gy/H5gLf6dLTV9hoQ2DhDYi/1r4OC4oyHporB5deEK6rOgJDadnCTBEe7cYRDdWyGDG8s/DnBb7LBORuFO9wzXCSnyh0ngUdLl4/vlyO+fHo5l9bd/3fJWX0qkir1sD+chIfFvr9zuNsyNWgfZ3VLGgw82truWot4brfUseJdMGWilGE4kbVQltkoL85z5FPaRu5Bh1tRWmTNfyGGg/I/ufBqR+sV0flaEudajOi9s7ywCnrtjPE2Xszvd6VcKsSbzfzBN5iPfiM8CuKGzyY4flkY72Ok5cbH4ExqYXBtcHNmeyJ0ldzeAZau/JvWplQKNADwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWrFzYY3bvi3NN6ZXYqnBetanAfxuNzbUYZKcQyCQ1Y=;
 b=Ql0rOjCH7fciC5JLeJ1Oia3roOcGch4LyNMfzqaK/7SX3vH4O0NUPpZSnOnxErAkiQoCz325FRnLzW5eafb8T6Rehm/1bJa4ch7GTpkDPSA1u7gazadCH8N69x918/+oGNp0S7tug5z3/G2l+80CwUsVCDNaLakWVGfHjtxzh3IeWQJ5DA6WZ8WtnYmZokjhzXnJQM2CjtEgw9reRKu1Q4pUs/U4ljZUkdJHBxzhHJwIePL7fjTi02PQJ+Sv7DVKJgRBjOYSUIj3ma4uy7u0DjeylWcVzIT4IM3x9EO9l0GNBxqLOwQysMFWHNV2GqiWus1bzfJMWF7dy8eOLD69Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB8549.namprd11.prod.outlook.com (2603:10b6:510:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 14 Nov
 2023 07:15:45 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 07:15:45 +0000
Date: Tue, 14 Nov 2023 15:15:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [fs/pipe]  478dbf1217: stress-ng.pipeherd.ops_per_sec
 -6.6% regression
Message-ID: <202311141453.1f47a9fa-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dddb063-0241-4759-1161-08dbe4e18460
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ynqf5pWj48fclQwGyKAHfJDrMUb2STVxKWaAM9yAydUL5dFhvbKDST6N8R/H2/oyyS4eCVeHlW56sJg2RWMCzOvX8IOC5uUJbEQqrX7w3rPuiW/yVdcPnlldcoo+L3s5fAYvLuV2yijpZ8n9h2cbE+OeY/KzS7XDraeb8HLg7RzhZa107FBSzCO+Lw//1dWdypAJl8ePpfFY8gANuNKvHqF5W9OdnMU0IK5ZXRwqIVpD53p9NxGBgYPSxR3os+d79+VspeREFLRFxgkm+MEPxfYczQg2R81fdtKTehiwgA2ppxenLWQlwraanomqcYXey2SiXNfRmboVCS05Q7i3ohF0h1LtPaUrpobH7nv8zuXtil9Pb+Ru713lLwGJN8CNODVa6M6ZBLvMwQ++XOJgOLOyRsUvC8gGu4pZ4VFJk8oxoGklzvbFX3iXz+GpKzZqEU6gw1HNe1TLSeuu42Bb/nyiTDqXCwUP4R6ZIAdStiqDZ0gynmlnFsyGxshO4mvmDGkqwYlaqXK1G14Tc2MPV1RDQ9cgyE1T/gDTh5yKg5CGgHkTP1RmzSdfxEQ4pzUEMQSaAPMIBUeUB0jLc0coNdpT2+FF24A8cjiFVXEDm1TG/lfhWXpdtXn0KDjsKaBWU8WtM20TUoN6fVlaAa1fOBxk6RMTh89dlnZHVdLoJVMFED+YgXQmFOBKRn9cthyt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230473577357003)(230373577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(5660300002)(38100700002)(41300700001)(2906002)(30864003)(36756003)(82960400001)(83380400001)(478600001)(66946007)(1076003)(2616005)(107886003)(26005)(6512007)(6666004)(66556008)(316002)(66476007)(54906003)(6916009)(6486002)(966005)(6506007)(4326008)(8936002)(8676002)(579004)(559001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KuVHP+fWT06cNN5ir3KxHfkJPHSFBHD0iWoXJVVzOBpyIATE3E61VcXCmT?=
 =?iso-8859-1?Q?Z6hvkTOggKbB9AGbY1BeKuqM9SX/mtptEq9cvUxbfCO7IhQYmqDsvpoY21?=
 =?iso-8859-1?Q?+JACl5RV+ZRFvgyg7pt9+zvLUo7GyS4NJ4u4Ii8WLIeKSKJTcFAAbK4ikO?=
 =?iso-8859-1?Q?nzeTILrTbWP+I+0Z8AMzHGEDYHcjlJKJ4k1YWWc+W7dHQr6UEm3EU4NzeG?=
 =?iso-8859-1?Q?zYx24PUV3Z+BZxV5c44ND6xW3m+K0JAURjE+Sqf7zGg4kEwsVgCz1ZfwUf?=
 =?iso-8859-1?Q?Nf1etvkvAmlDOH9OCbbNhN5ziX/eqSW9XKlCHugrmSwdrL8yptUuPiD/IQ?=
 =?iso-8859-1?Q?OFn2GGXRC750ZNn6uBarcXxVxjt22qaPqmcfGhJhv3cYBVteaGaSD44gHy?=
 =?iso-8859-1?Q?HFaeVnQpJ0w8WTJXrHY+uQmuRIj/BMLDK4hdMwgAf4mQ3+5F+U+zhWl54V?=
 =?iso-8859-1?Q?jvX3Kdwqall2FCgjKj5nZ1YkzOVEaigQN9rtUbbxWgC7aY55rw11lJ1dSD?=
 =?iso-8859-1?Q?FCLkBlgOI1d2+9dVdNaHIQ7HWTjl6p9J59K/IWyja/WZrVx+TMJqgbflTl?=
 =?iso-8859-1?Q?ZNfFWCUlRgJClcLA5rspmKh0fuVU+Gy5sjankmKwWMYjj0/U5L5L5+EnRy?=
 =?iso-8859-1?Q?c0qXjO4O4WwGYOvfMaSf6XUvpF85oDf+CXW9e61vhkwYYKluT6mGEY3WxN?=
 =?iso-8859-1?Q?ZwqMprayckwvrR6+/AiIMXFC6pWHVjtr2bqMWclCoWQjryWHng8LfJY8+5?=
 =?iso-8859-1?Q?KhS6ynib+QghUcxi5x+xULqEWD3gigAGWypzDdeYjsnrAe2fDbR2L3bs6i?=
 =?iso-8859-1?Q?qjegH1rPWzIXQtDkIkeZhslVlFwqaCO66IOGE1p20FrgoWFdhUI5WEUAA+?=
 =?iso-8859-1?Q?7lDTPv0IHPk9DlTPcn+/uD5b+l6qaGZxA8fV63ZkTBZ5q/LmVUf3Zf+FZi?=
 =?iso-8859-1?Q?55kr3s7YVDVKWdI8hu37z1c9Uc/RMd/xyftqIkeIJy/pkU1YND9LZoftGO?=
 =?iso-8859-1?Q?iJTHGrP22vYwPuHMBuUBMowFx/gTWUInPDyvnikKM6iPPLcjqFWVkbtPTn?=
 =?iso-8859-1?Q?kCCyI/EwB3vaWwtuM8nHl4cUOKb3JhD0LGvFCmNoMBCtShTXrptLyP9cHb?=
 =?iso-8859-1?Q?VWzozLgHzAw/x33SF7A44+oEdof5zrKFyYDnKOk2VLuLWmrimb1EBc8PMY?=
 =?iso-8859-1?Q?9MM5BKZhG5g8OjgXIIA9/ZabfffLAzMuQ6dJVpzV1yGy5UuM/y1SbVJEZM?=
 =?iso-8859-1?Q?D70LoRGhy+ORz+gzgXlIKpMdVyKZe05i6MFvJSogCAgn/vO/97AC+d5jT4?=
 =?iso-8859-1?Q?FirOWKJmtMpFd8hJJRb+VcU6KWp6l3UQyFl2g9Nx+qMPo2bTmJNaRDyhWJ?=
 =?iso-8859-1?Q?kK9vZx8oUggCJK6MRMnJnka7j4d8D/IhB+haNQkG0OvPHEuI3986HHqMaA?=
 =?iso-8859-1?Q?qapF8qOHSLS66SJIB/kTukueU/Gt1HCf3WoSwWKmX2HT6YeCMtRSD0J+Fl?=
 =?iso-8859-1?Q?DlfiZ/LCrBRYQDudwooTWe9YC5ITkav3W+YEvGQ6wGV+SzyIZ/mZckC+5X?=
 =?iso-8859-1?Q?Nr0StaqAbVi7D8YLqaYhKyQTqjiaEq7ESPUkH8/ri/EtSwKT48/c5Ojzqa?=
 =?iso-8859-1?Q?7ltgqrybURIv91jqdqV0AkfN8ZdSoRaFnc3V1bqNTXLkcNED7lEhgiDA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dddb063-0241-4759-1161-08dbe4e18460
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 07:15:45.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W6ZGD6f4OxC1oBLT9aa9XZkVETYa2bbzCpLzAGTXl8AzT6RDXExp8R/Q3mAOC31WEh5TQ1OP8t+zubG32hBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8549
X-OriginatorOrg: intel.com


hi, Max Kellermann,

when this commit is:
commit: 8114dc703a4833be4a98a37f5ed0a3abb55dcb34 ("fs/pipe: use spinlock in pipe_read() only if there is a watch_queue")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.misc.backing_file

we reported 'a 70.9% improvement of stress-ng.pipeherd.ops_per_sec' in
https://lore.kernel.org/all/202310202136.48fa5db-oliver.sang@intel.com/

as in below
"In addition to that, the commit also has significant impact on the following tests:"
part, after this commit merged into mainline, we still observed similar
improvement on same platform for previous report.

but now we also notice a relatively small regression on another platform (Ice
Lake). just FYI.


Hello,

kernel test robot noticed a -6.6% regression of stress-ng.pipeherd.ops_per_sec on:


commit: 478dbf12176700f28d836dd03ae93a6888278230 ("fs/pipe: use spinlock in pipe_read() only if there is a watch_queue")
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
| testcase: change | stress-ng: stress-ng.pipeherd.ops_per_sec 54.2% improvement                                     |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=memory                                                                                    |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=1                                                                                    |
|                  | test=pipeherd                                                                                   |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.pipeherd.ops_per_sec 65.9% improvement                                     |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=os                                                                                        |
|                  | cpufreq_governor=performance                                                                    |
|                  | disk=1HDD                                                                                       |
|                  | fs=ext4                                                                                         |
|                  | nr_threads=1                                                                                    |
|                  | test=pipeherd                                                                                   |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.pipeherd.ops_per_sec 67.1% improvement                                     |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=pipe                                                                                      |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=1                                                                                    |
|                  | test=pipeherd                                                                                   |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311141453.1f47a9fa-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231114/202311141453.1f47a9fa-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/pipeherd/stress-ng/60s

commit: 
  dfaabf916b ("fs/pipe: remove unnecessary spinlock from pipe_write()")
  478dbf1217 ("fs/pipe: use spinlock in pipe_read() only if there is a watch_queue")

dfaabf916b1ca83c 478dbf12176700f28d836dd03ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    526626 ± 74%     -69.6%     159872 ± 21%  numa-numastat.node0.local_node
      5863 ±  8%     -36.9%       3701 ±  9%  uptime.idle
 2.411e+09 ±  9%     -89.7%  2.484e+08 ±  6%  cpuidle..time
  76903274           -99.6%     271718 ±  6%  cpuidle..usage
     63.57 ±  2%     -87.7%       7.85 ±  7%  iostat.cpu.idle
     34.90 ±  4%    +160.5%      90.92        iostat.cpu.system
      1.49 ±  9%     -18.0%       1.22 ±  4%  iostat.cpu.user
     26.67 ± 19%    +710.6%     216.17 ± 32%  perf-c2c.DRAM.local
      1238 ±  9%   +1528.0%      20160        perf-c2c.DRAM.remote
     27866 ±  2%     -28.3%      19976 ±  2%  perf-c2c.HITM.local
    821.83 ±  9%   +1762.9%      15310 ±  2%  perf-c2c.HITM.remote
     28688 ±  2%     +23.0%      35286        perf-c2c.HITM.total
     62.55 ±  3%     -57.3        5.23 ± 13%  mpstat.cpu.all.idle%
      0.03 ± 28%      -0.0        0.00 ± 87%  mpstat.cpu.all.iowait%
      1.04 ±  7%      +0.7        1.76        mpstat.cpu.all.irq%
      0.08            -0.1        0.02 ±  2%  mpstat.cpu.all.soft%
     34.78 ±  5%     +57.0       91.79        mpstat.cpu.all.sys%
      1.51 ±  9%      -0.3        1.21 ±  4%  mpstat.cpu.all.usr%
     63.60 ±  2%     -87.6%       7.89 ±  6%  vmstat.cpu.id
     34.89 ±  4%    +160.5%      90.89        vmstat.cpu.sy
   6015779           -34.6%    3937070 ±  3%  vmstat.memory.cache
     22.73 ±  5%   +2270.7%     538.97        vmstat.procs.r
   2264275 ±  5%     -75.6%     552750        vmstat.system.cs
    106734 ±  2%    +164.4%     282256        vmstat.system.in
    926253 ±107%     -98.6%      12925 ± 28%  numa-meminfo.node0.Active
    923516 ±107%     -99.0%       9610 ±  9%  numa-meminfo.node0.Active(anon)
    987699 ±107%     -98.2%      17930 ± 10%  numa-meminfo.node0.Shmem
   1934288 ± 53%     -96.3%      72485 ± 41%  numa-meminfo.node1.Active
   1929735 ± 53%     -96.4%      68621 ± 42%  numa-meminfo.node1.Active(anon)
    339310 ± 36%    +250.3%    1188705 ± 11%  numa-meminfo.node1.Inactive
    330949 ± 37%    +257.3%    1182584 ± 10%  numa-meminfo.node1.Inactive(anon)
    230892 ±107%     -99.0%       2408 ±  8%  numa-vmstat.node0.nr_active_anon
    246933 ±107%     -98.2%       4486 ± 10%  numa-vmstat.node0.nr_shmem
    230892 ±107%     -99.0%       2408 ±  8%  numa-vmstat.node0.nr_zone_active_anon
    526461 ± 74%     -69.7%     159396 ± 21%  numa-vmstat.node0.numa_local
    481592 ± 53%     -96.4%      17224 ± 42%  numa-vmstat.node1.nr_active_anon
     82836 ± 37%    +257.0%     295752 ± 10%  numa-vmstat.node1.nr_inactive_anon
    481591 ± 53%     -96.4%      17224 ± 42%  numa-vmstat.node1.nr_zone_active_anon
     82836 ± 37%    +257.0%     295752 ± 10%  numa-vmstat.node1.nr_zone_inactive_anon
      1.00           -49.8%       0.50        stress-ng.pipeherd.context_switches_per_bogo_op
    212749           -53.2%      99609        stress-ng.pipeherd.context_switches_per_sec
  76601132            -6.6%   71546484        stress-ng.pipeherd.ops
   1275768            -6.6%    1191345        stress-ng.pipeherd.ops_per_sec
      3077 ±  7%  +64016.3%    1972964        stress-ng.time.involuntary_context_switches
      2300          +162.0%       6027        stress-ng.time.percent_of_cpu_this_job_got
      1401          +165.8%       3724        stress-ng.time.system_time
  76594217           -55.7%   33909068        stress-ng.time.voluntary_context_switches
   2861043 ±  3%     -97.0%      86607 ± 32%  meminfo.Active
   2853751 ±  3%     -97.2%      79425 ± 35%  meminfo.Active(anon)
    370040           +17.1%     433497        meminfo.AnonPages
   5887524           -34.9%    3833012 ±  3%  meminfo.Cached
   9202449 ±  2%     -19.7%    7387275        meminfo.Committed_AS
    577677 ±  7%    +135.6%    1360963 ±  8%  meminfo.Inactive
    565253 ±  7%    +138.6%    1348750 ±  8%  meminfo.Inactive(anon)
    721987 ± 17%     -29.7%     507823 ±  5%  meminfo.Mapped
   7431362           -25.0%    5570370 ±  2%  meminfo.Memused
   3049597 ±  2%     -67.4%     995298 ± 13%  meminfo.Shmem
   7631133           -26.4%    5615499 ±  2%  meminfo.max_used_kB
      1426 ±  5%    +103.9%       2908        turbostat.Avg_MHz
     46.20 ±  4%     +47.8       94.04        turbostat.Busy%
    462647 ±  2%     -98.0%       9228 ± 15%  turbostat.C1
      0.22 ±  4%      -0.2        0.00 ±141%  turbostat.C1%
  76043040          -100.0%      31605 ±  5%  turbostat.C1E
     48.76 ±  5%     -48.6        0.14 ±  3%  turbostat.C1E%
     53.44 ±  4%     -89.5%       5.60 ±  6%  turbostat.CPU%c1
      0.08 ±  5%     -52.0%       0.04        turbostat.IPC
   7167100 ±  3%    +156.2%   18365074        turbostat.IRQ
     51823 ±  2%     -96.9%       1614 ± 49%  turbostat.POLL
      0.04 ±  9%      -0.0        0.00        turbostat.POLL%
    199.14            +6.2%     211.54        turbostat.PkgWatt
     56.50            +6.4%      60.09        turbostat.RAMWatt
    712852 ±  2%     -97.2%      19859 ± 35%  proc-vmstat.nr_active_anon
     92566           +17.0%     108330        proc-vmstat.nr_anon_pages
   1473145           -34.8%     960026 ±  3%  proc-vmstat.nr_file_pages
    141419 ±  7%    +138.4%     337140 ±  8%  proc-vmstat.nr_inactive_anon
    180483 ± 17%     -29.7%     126961 ±  5%  proc-vmstat.nr_mapped
    761859 ±  2%     -67.3%     248821 ± 13%  proc-vmstat.nr_shmem
     26214            -5.0%      24914        proc-vmstat.nr_slab_reclaimable
    712852 ±  2%     -97.2%      19859 ± 35%  proc-vmstat.nr_zone_active_anon
    141419 ±  7%    +138.4%     337140 ±  8%  proc-vmstat.nr_zone_inactive_anon
   1508913           -45.7%     819289 ±  5%  proc-vmstat.numa_hit
   1442579           -47.8%     752958 ±  6%  proc-vmstat.numa_local
    230268 ±  4%     -81.8%      41917 ±  4%  proc-vmstat.pgactivate
   1560001           -44.4%     867821 ±  5%  proc-vmstat.pgalloc_normal
    574253 ±  3%      -5.6%     542249        proc-vmstat.pgfault
    441076           -21.9%     344410        proc-vmstat.pgfree
    289408          +551.2%    1884528        sched_debug.cfs_rq:/.avg_vruntime.avg
    364822 ±  5%    +595.8%    2538349 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.max
    272926 ±  2%    +565.9%    1817529        sched_debug.cfs_rq:/.avg_vruntime.min
     14026 ± 15%    +678.3%     109165 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.35 ±  6%   +1278.8%       4.83 ±  2%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.42 ± 37%    +376.5%       6.75 ±  7%  sched_debug.cfs_rq:/.h_nr_running.max
      0.48 ±  6%     +92.2%       0.92 ± 16%  sched_debug.cfs_rq:/.h_nr_running.stddev
     14065 ± 22%     -99.6%      54.87 ±174%  sched_debug.cfs_rq:/.left_vruntime.avg
    289572 ±  2%     -98.9%       3240 ±170%  sched_debug.cfs_rq:/.left_vruntime.max
     61238 ± 11%     -99.3%     403.18 ±170%  sched_debug.cfs_rq:/.left_vruntime.stddev
    393508 ± 98%     -48.6%     202268 ±117%  sched_debug.cfs_rq:/.load.max
     64958 ± 97%     -59.2%      26528 ±106%  sched_debug.cfs_rq:/.load.stddev
      3.00 ± 19%    +125.0%       6.75 ±  5%  sched_debug.cfs_rq:/.load_avg.min
    289408          +551.2%    1884528        sched_debug.cfs_rq:/.min_vruntime.avg
    364822 ±  5%    +595.8%    2538349 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
    272926 ±  2%    +565.9%    1817529        sched_debug.cfs_rq:/.min_vruntime.min
     14026 ± 15%    +678.3%     109165 ± 18%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.35 ±  6%     +78.0%       0.62 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
      0.47 ±  6%     -54.2%       0.22 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
     14065 ± 22%     -99.6%      54.87 ±174%  sched_debug.cfs_rq:/.right_vruntime.avg
    289572 ±  2%     -98.9%       3240 ±170%  sched_debug.cfs_rq:/.right_vruntime.max
     61238 ± 11%     -99.3%     403.18 ±170%  sched_debug.cfs_rq:/.right_vruntime.stddev
    424.02 ±  3%   +1113.9%       5147        sched_debug.cfs_rq:/.runnable_avg.avg
      1025 ±  5%    +573.2%       6900 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    134.42 ± 10%   +2171.7%       3053 ± 37%  sched_debug.cfs_rq:/.runnable_avg.min
    200.79 ±  4%    +311.3%     825.76 ± 12%  sched_debug.cfs_rq:/.runnable_avg.stddev
    421.09 ±  3%     +76.6%     743.61 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
      1023 ±  5%     +23.8%       1267 ±  4%  sched_debug.cfs_rq:/.util_avg.max
    134.00 ± 10%    +211.3%     417.08        sched_debug.cfs_rq:/.util_avg.min
     28.58 ± 34%   +1246.8%     384.95 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    459.42 ± 23%    +128.0%       1047 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.max
     82.49 ± 22%     +66.4%     137.24 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    384961 ±  2%     +16.3%     447594 ±  3%  sched_debug.cpu.avg_idle.avg
    575142 ± 10%     +40.3%     807182 ±  6%  sched_debug.cpu.avg_idle.max
     10472 ±  4%    +116.2%      22636 ± 24%  sched_debug.cpu.avg_idle.min
    133104 ±  7%     +27.8%     170087 ±  5%  sched_debug.cpu.avg_idle.stddev
      2.94 ±  2%    +684.3%      23.10 ± 19%  sched_debug.cpu.clock.stddev
      1594 ±  8%     +84.8%       2947        sched_debug.cpu.curr->pid.avg
      1985           -54.7%     899.37 ±  3%  sched_debug.cpu.curr->pid.stddev
      0.00 ±  9%    +179.7%       0.00 ± 18%  sched_debug.cpu.next_balance.stddev
      0.35 ±  7%   +1277.0%       4.82        sched_debug.cpu.nr_running.avg
      1.25 ± 30%    +440.0%       6.75 ±  7%  sched_debug.cpu.nr_running.max
      0.47 ±  5%     +97.1%       0.93 ± 16%  sched_debug.cpu.nr_running.stddev
   1129961           -76.0%     270748        sched_debug.cpu.nr_switches.avg
   1230736           -73.6%     324498 ±  4%  sched_debug.cpu.nr_switches.max
    889548 ±  6%     -72.0%     248742        sched_debug.cpu.nr_switches.min
     55881 ± 13%     -72.1%      15568 ± 18%  sched_debug.cpu.nr_switches.stddev
      0.68 ±  9%    +274.8%       2.56 ±  4%  perf-stat.i.MPKI
      1.22            -0.5        0.69 ±  2%  perf-stat.i.branch-miss-rate%
  53919038 ±  5%     -47.4%   28362095 ±  3%  perf-stat.i.branch-misses
      7.77 ±  9%     +31.4       39.22 ±  4%  perf-stat.i.cache-miss-rate%
  16836662 ±  7%    +189.5%   48749241 ±  3%  perf-stat.i.cache-misses
 2.355e+08 ±  4%     -47.2%  1.244e+08        perf-stat.i.cache-references
   2386604 ±  5%     -75.8%     577272        perf-stat.i.context-switches
      4.42          +123.1%       9.86        perf-stat.i.cpi
 9.829e+10 ±  4%     +92.6%  1.893e+11        perf-stat.i.cpu-cycles
    467023 ±  4%     -65.7%     160277        perf-stat.i.cpu-migrations
      7207 ± 11%     -46.2%       3874 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.09 ±  5%      -0.0        0.04 ±  8%  perf-stat.i.dTLB-load-miss-rate%
   5621309 ±  6%     -62.2%    2122334 ±  6%  perf-stat.i.dTLB-load-misses
 6.152e+09 ±  5%     -18.8%  4.995e+09        perf-stat.i.dTLB-loads
      0.01 ± 16%      -0.0        0.00 ±  9%  perf-stat.i.dTLB-store-miss-rate%
    194620 ±  9%     -70.7%      57018 ± 10%  perf-stat.i.dTLB-store-misses
 3.088e+09 ±  5%     -53.5%  1.437e+09        perf-stat.i.dTLB-stores
 2.278e+10 ±  5%     -15.1%  1.933e+10        perf-stat.i.instructions
      0.26           -48.8%       0.13 ±  2%  perf-stat.i.ipc
      1.54 ±  4%     +92.6%       2.96        perf-stat.i.metric.GHz
    332.10 ± 11%    +135.2%     780.97 ±  2%  perf-stat.i.metric.K/sec
    220.73 ±  5%     -22.9%     170.20        perf-stat.i.metric.M/sec
     89.76 ±  3%      +6.5       96.26        perf-stat.i.node-load-miss-rate%
   8050438 ±  7%    +242.5%   27576187 ±  2%  perf-stat.i.node-load-misses
     24.75 ±  3%     +46.8       71.52        perf-stat.i.node-store-miss-rate%
   1463258 ±  8%    +910.5%   14785780 ±  3%  perf-stat.i.node-store-misses
   6111881 ±  5%      -8.6%    5588094 ±  3%  perf-stat.i.node-stores
      0.74 ±  9%    +240.9%       2.53 ±  4%  perf-stat.overall.MPKI
      1.16            -0.5        0.65        perf-stat.overall.branch-miss-rate%
      7.16 ±  9%     +32.1       39.24 ±  4%  perf-stat.overall.cache-miss-rate%
      4.32          +127.1%       9.81        perf-stat.overall.cpi
      5873 ±  9%     -33.9%       3883 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.09 ±  4%      -0.0        0.04 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 11%      -0.0        0.00 ± 10%  perf-stat.overall.dTLB-store-miss-rate%
      0.23           -56.0%       0.10        perf-stat.overall.ipc
     89.56 ±  3%      +7.8       97.35        perf-stat.overall.node-load-miss-rate%
     19.29 ±  3%     +53.3       72.60        perf-stat.overall.node-store-miss-rate%
  53131153 ±  4%     -47.6%   27850694 ±  3%  perf-stat.ps.branch-misses
  16572483 ±  7%    +190.1%   48069542 ±  3%  perf-stat.ps.cache-misses
 2.321e+08 ±  4%     -47.2%  1.226e+08        perf-stat.ps.cache-references
   2350599 ±  5%     -75.8%     568552        perf-stat.ps.context-switches
 9.682e+10 ±  4%     +92.6%  1.865e+11        perf-stat.ps.cpu-cycles
    460172 ±  4%     -65.7%     157887        perf-stat.ps.cpu-migrations
   5533567 ±  6%     -62.2%    2092824 ±  6%  perf-stat.ps.dTLB-load-misses
 6.059e+09 ±  5%     -18.8%  4.917e+09        perf-stat.ps.dTLB-loads
    191690 ±  9%     -70.6%      56451 ±  9%  perf-stat.ps.dTLB-store-misses
 3.041e+09 ±  5%     -53.5%  1.415e+09        perf-stat.ps.dTLB-stores
 2.243e+10 ±  5%     -15.2%  1.902e+10        perf-stat.ps.instructions
   7932536 ±  7%    +242.8%   27192073 ±  2%  perf-stat.ps.node-load-misses
   1439876 ±  8%    +912.5%   14579379 ±  3%  perf-stat.ps.node-store-misses
   6012349 ±  5%      -8.5%    5503370 ±  3%  perf-stat.ps.node-stores
 1.444e+12           -17.2%  1.196e+12        perf-stat.total.instructions
      0.01 ± 20%  +21015.2%       1.62 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.01 ±  7%  +20429.0%       1.06 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 23%  +28172.1%       3.20 ± 22%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 14%  +70602.0%      11.67 ± 46%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 11%  +7.7e+05%      24.36 ± 32%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ±  6%  +86766.2%      11.15 ±142%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01        +13264.6%       1.07 ± 22%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ±  6%  +20197.7%       1.49 ± 23%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±144%  +16369.8%       4.09 ±120%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  8%  +11767.6%       0.67 ± 21%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 17%  +39790.2%       3.39 ± 34%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ±  7%   +9498.3%       0.93 ± 70%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  5%  +64131.4%       5.46 ±136%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01        +95047.6%       6.66 ± 43%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 22%  +31469.2%       3.42 ± 98%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ± 30%  +27246.7%       0.68 ± 20%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.03 ± 22%  +4.3e+05%     112.55 ± 72%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 50%  +28074.5%       4.41 ± 25%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ± 40%  +3.9e+05%     123.78 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.03 ± 69%     -81.2%       0.01 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 32%  +14863.7%       3.64 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.02 ± 31%  +21396.6%       5.27 ± 17%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 18%  +59092.4%      11.74 ± 45%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.03 ± 24%  +3.5e+06%       1005        perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.06 ± 20%  +5.9e+05%     342.13 ±140%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 16%  +8.7e+05%     312.90 ±100%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      6.61 ±  9%  +20499.9%       1361 ± 36%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.68 ±218%  +18756.7%     127.85 ±137%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 16%  +22014.1%       2.62 ± 42%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 20%  +41560.3%       5.07 ±  7%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.02 ± 36%  +36628.8%       6.37 ± 63%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.03 ± 31%  +5.4e+05%     176.12 ±212%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.03 ± 46%    +2e+06%     512.00 ± 22%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 26%  +39380.8%       5.13 ± 98%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.02 ± 86%  +17118.9%       2.73 ± 12%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      3.71 ±  8%  +61141.9%       2271 ± 31%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  6%  +20252.3%       1.49 ± 24%  perf-sched.total_sch_delay.average.ms
      6.61 ±  9%  +34276.1%       2271 ± 31%  perf-sched.total_sch_delay.max.ms
      0.86          +443.3%       4.68 ± 19%  perf-sched.total_wait_and_delay.average.ms
   4286519           -70.1%    1279647 ± 14%  perf-sched.total_wait_and_delay.count.ms
      3830 ±  9%     +64.1%       6287 ± 19%  perf-sched.total_wait_and_delay.max.ms
      0.85          +273.1%       3.18 ± 17%  perf-sched.total_wait_time.average.ms
      3830 ±  9%     +31.9%       5050 ± 10%  perf-sched.total_wait_time.max.ms
     10.52           +87.3%      19.71 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    688.11 ± 30%     -99.9%       0.83 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    802.75           +31.5%       1055 ± 29%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    186.90 ± 10%     -32.2%     126.70 ± 27%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.75 ±145%  +13752.5%     103.71 ± 45%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.70          +502.7%       4.24 ± 20%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.47 ± 11%   +1183.5%      31.76 ± 45%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    373.25           +61.4%     602.50 ± 13%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    453.57           +97.8%     897.15 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     18.03 ± 11%     +82.3%      32.86 ± 30%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    571.44 ±  5%     +40.4%     802.53 ± 14%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    579.27 ±  3%     +82.5%       1057 ± 19%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    382.00           -30.7%     264.67 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      5.67 ± 24%     -94.1%       0.33 ±223%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.17 ±  3%     -44.3%       5.67 ± 13%  perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.00           -58.3%       0.83 ± 44%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      6.00           -61.1%       2.33 ± 76%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    125.33           -35.2%      81.17 ± 18%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
   4283821           -71.4%    1223670 ± 14%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     19.83           -44.5%      11.00 ± 25%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     13.00           -33.3%       8.67 ± 14%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     20.00           -44.2%      11.17 ± 17%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    275.83 ± 11%     -34.7%     180.17 ± 26%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    585.50           -32.7%     393.83 ± 12%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    452.83 ±  3%     -54.3%     207.17 ± 16%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2011 ± 39%     -99.9%       1.66 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    999.73          +168.2%       2680 ± 17%  perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     74.83 ±148%   +1726.9%       1367 ± 35%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1009          +353.7%       4579 ± 31%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.67 ±  9%  +11279.5%     531.33 ± 50%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1000          +166.9%       2671 ± 27%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    499.97          +183.4%       1416 ± 13%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    505.00          +266.0%       1848 ± 12%  perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    375.83 ± 11%    +187.1%       1078 ± 15%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2686 ± 16%    +130.3%       6186 ± 22%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%  +3.8e+05%      18.61 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
     10.52           +87.0%      19.67 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.04 ± 29%  +56775.8%      24.65 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.67 ±  2%    +351.9%       3.03 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.10 ±223%    +929.7%       1.04 ±107%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.67 ±  5%    +175.1%       1.83 ± 60%  perf-sched.wait_time.avg.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±223%  +1.4e+06%      27.78 ± 35%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
    688.10 ± 30%     -99.9%       0.83 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ±223%   +1407.2%       1.69 ± 80%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    802.74           +31.1%       1052 ± 29%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.95 ± 11%     -88.6%       0.22 ±223%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    186.90 ± 10%     -45.2%     102.33 ± 39%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.05 ± 84%   +8736.4%      92.56 ± 38%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.32 ± 21%   +9484.2%      30.89 ±196%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.66 ±  2%    +224.3%       2.14 ± 17%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.70          +295.4%       2.75 ± 17%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.45 ± 10%   +1029.6%      27.67 ± 38%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    373.24           +61.2%     601.57 ± 13%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.10 ±223%   +1432.1%       1.60 ± 65%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.67        +28106.1%     188.32 ± 50%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    453.56           +97.8%     897.14 ± 17%  perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    571.43 ±  5%     +40.4%     802.12 ± 14%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  8%   +2310.4%       0.27 ± 71%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    579.24 ±  3%     +63.1%     944.72 ± 15%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%  +5.4e+05%      25.90 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.53 ± 72%   +2321.4%      12.75 ±123%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.15 ± 46%  +3.9e+05%     591.60 ± 65%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.94 ±  6%  +13779.0%     130.35 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.10 ±223%   +2299.3%       2.43 ± 66%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.76 ± 15%   +1852.9%      14.88 ±110%  perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±223%    +9e+06%     180.20 ± 92%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      2011 ± 39%     -99.9%       1.66 ±223%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ±223%  +10815.4%      12.21 ±166%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    999.72          +167.7%       2676 ± 17%  perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3.90 ± 11%     -88.6%       0.44 ±223%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     75.92 ±145%   +1253.8%       1027        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.66 ±  7%  +14655.7%      97.22 ±185%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.12 ±223%   +1139.0%       1.48 ±116%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.98 ±  6%  +2.2e+05%       2203 ± 74%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1009          +269.0%       3725 ± 25%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.66 ±  9%   +9253.2%     435.81 ± 26%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1000          +166.8%       2671 ± 27%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    499.95          +183.4%       1416 ± 13%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.95 ±  8%   +1017.7%      10.57 ± 88%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.10 ±223%   +2784.5%       3.01 ±112%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      1.51 ±  8%  +1.3e+05%       2034 ± 57%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    504.99          +266.0%       1848 ± 12%  perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    375.82 ± 11%     +57.6%     592.31 ±  9%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.04 ± 15%   +4237.2%       1.83 ± 55%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2686 ± 16%     +83.8%       4939 ± 12%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     24.50           -24.5        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     24.14           -24.1        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     24.13           -24.1        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     24.10           -24.1        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     14.32           -14.3        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     13.35 ±  2%     -13.3        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     13.25 ±  2%     -13.2        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     12.23           -12.2        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     14.36 ±  2%     -11.8        2.55        perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
     10.68 ±  4%      -8.2        2.51        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     10.43 ±  4%      -8.0        2.44        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      8.08 ±  3%      -7.0        1.05        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_read.vfs_read.ksys_read
      5.76 ±  2%      -5.8        0.00        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.28 ±  2%      -5.3        0.00        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      4.18            -3.4        0.82        perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.pipe_read.vfs_read.ksys_read
      3.37 ±  3%      -3.1        0.25 ±100%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      3.64 ±  3%      -2.8        0.86        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      1.69            -1.2        0.52 ±  2%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      4.46 ±  2%      -0.8        3.67        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      4.62 ±  2%      -0.8        3.84        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      4.86 ±  2%      -0.5        4.36        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.54            -0.2        1.30        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.66 ±  3%      -0.2        0.51        perf-profile.calltrace.cycles-pp.__list_del_entry_valid_or_report.finish_wait.pipe_read.vfs_read.ksys_read
      1.36            -0.0        1.32        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.59 ±  3%      +0.1        0.66        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.79            +0.1        0.90        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.43 ± 44%      +0.4        0.86        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.00            +0.6        0.65 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.prepare_to_wait_event.pipe_read
      0.00            +0.6        0.65 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.prepare_to_wait_event
      0.00            +0.7        0.69 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.prepare_to_wait_event.pipe_read.vfs_read
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +0.8        0.76        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.00            +0.8        0.76 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
     60.97            +4.1       65.02        perf-profile.calltrace.cycles-pp.read
     60.32            +4.3       64.65        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     60.18            +4.4       64.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     59.43            +4.8       64.19        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     59.28            +4.8       64.13        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     59.02            +4.9       63.97        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.25            +9.7       20.98        perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
     10.56            +9.9       20.44        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
     10.16           +10.0       20.18        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
     13.01           +20.5       33.55        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      9.04           +22.0       30.99        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
     11.10           +22.5       33.65        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.02           +22.6       30.57        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
     10.98           +22.6       33.57        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     10.76           +22.7       33.42        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.30           +22.7       34.03        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     11.27           +22.7       34.01        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     11.62           +22.8       34.42        perf-profile.calltrace.cycles-pp.write
      6.95           +23.7       30.62        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      2.01 ±  2%     +24.1       26.08        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.90 ±  2%     +24.1       26.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
     24.50           -24.5        0.00        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     24.50           -24.5        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     24.48           -24.5        0.00        perf-profile.children.cycles-pp.do_idle
     24.14           -24.1        0.00        perf-profile.children.cycles-pp.start_secondary
     14.54           -14.5        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     13.55           -13.5        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     13.48           -13.5        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     16.06 ±  2%     -13.0        3.07        perf-profile.children.cycles-pp.__mutex_lock
     12.41           -12.4        0.00        perf-profile.children.cycles-pp.intel_idle
     13.86 ±  3%     -11.4        2.51        perf-profile.children.cycles-pp.__schedule
     10.69 ±  4%      -8.1        2.57        perf-profile.children.cycles-pp.schedule
      9.31 ±  2%      -8.0        1.31        perf-profile.children.cycles-pp.osq_lock
      5.85 ±  2%      -5.8        0.00        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      5.43 ±  2%      -4.6        0.86        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      4.78 ±  8%      -4.5        0.32 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      4.78 ±  2%      -4.1        0.67 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      4.23            -3.3        0.94        perf-profile.children.cycles-pp.mutex_spin_on_owner
      3.44 ±  3%      -2.9        0.50 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      3.69 ±  3%      -2.8        0.86        perf-profile.children.cycles-pp.dequeue_task_fair
      3.88 ±  3%      -2.7        1.17        perf-profile.children.cycles-pp.activate_task
      3.93 ±  3%      -2.6        1.31        perf-profile.children.cycles-pp.ttwu_do_activate
      3.00 ±  3%      -2.3        0.70        perf-profile.children.cycles-pp.update_load_avg
      3.28 ±  3%      -2.2        1.06        perf-profile.children.cycles-pp.enqueue_task_fair
      2.93 ±  4%      -2.2        0.75        perf-profile.children.cycles-pp.enqueue_entity
      2.01 ±  7%      -1.8        0.26 ±  2%  perf-profile.children.cycles-pp.update_cfs_group
      1.31 ±  2%      -1.3        0.05        perf-profile.children.cycles-pp.select_idle_sibling
      1.62 ± 34%      -1.2        0.41 ± 25%  perf-profile.children.cycles-pp.__cmd_record
      1.58 ± 34%      -1.2        0.40 ± 26%  perf-profile.children.cycles-pp.record__finish_output
      1.58 ± 34%      -1.2        0.40 ± 26%  perf-profile.children.cycles-pp.perf_session__process_events
      1.58 ± 34%      -1.2        0.39 ± 26%  perf-profile.children.cycles-pp.reader__read_event
      1.63 ±  2%      -1.1        0.49        perf-profile.children.cycles-pp._raw_spin_lock
      1.53            -1.1        0.41        perf-profile.children.cycles-pp.select_task_rq
      1.48 ±  2%      -1.1        0.40        perf-profile.children.cycles-pp.select_task_rq_fair
      1.38            -1.0        0.34        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.14            -0.9        0.21 ±  2%  perf-profile.children.cycles-pp.__smp_call_single_queue
      1.20 ±  2%      -0.9        0.26 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      4.47 ±  2%      -0.8        3.69        perf-profile.children.cycles-pp.try_to_wake_up
      4.62 ±  2%      -0.8        3.84        perf-profile.children.cycles-pp.autoremove_wake_function
      0.88            -0.7        0.19 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.06            -0.7        0.40 ±  2%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.91 ±  4%      -0.6        0.28 ±  3%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.76            -0.6        0.20 ±  2%  perf-profile.children.cycles-pp.llist_add_batch
      0.69 ±  5%      -0.5        0.14 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.60 ±  2%      -0.5        0.07 ±  6%  perf-profile.children.cycles-pp.set_task_cpu
      0.60 ±  4%      -0.5        0.09 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
      4.87 ±  2%      -0.5        4.36        perf-profile.children.cycles-pp.__wake_up_common
      0.59 ±  2%      -0.5        0.08 ±  5%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.98 ±  2%      -0.5        0.48 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.56 ±  2%      -0.5        0.07        perf-profile.children.cycles-pp.llist_reverse_order
      0.54 ±  2%      -0.5        0.06 ±  6%  perf-profile.children.cycles-pp.migrate_task_rq_fair
      0.59            -0.5        0.12        perf-profile.children.cycles-pp.__switch_to_asm
      0.90 ±  2%      -0.5        0.44 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.62 ±  2%      -0.4        0.18 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.53 ±  2%      -0.4        0.12 ±  4%  perf-profile.children.cycles-pp.osq_unlock
      0.58 ±  2%      -0.4        0.21 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.80 ±  3%      -0.3        0.48        perf-profile.children.cycles-pp.update_curr
      0.45 ±  2%      -0.3        0.20 ±  3%  perf-profile.children.cycles-pp.switch_fpu_return
      0.67 ±  2%      -0.3        0.42 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.67 ±  2%      -0.3        0.42 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.34            -0.2        0.12        perf-profile.children.cycles-pp.update_rq_clock_task
      0.58 ±  2%      -0.2        0.37 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.53 ± 27%      -0.2        0.32 ± 22%  perf-profile.children.cycles-pp.process_simple
      0.28 ± 18%      -0.2        0.07 ± 12%  perf-profile.children.cycles-pp.stress_pipeherd_read_write
      0.51 ±  3%      -0.2        0.32 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.28 ±  2%      -0.2        0.09 ±  4%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.47 ±  2%      -0.2        0.31 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.47 ±  3%      -0.2        0.30 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.74            -0.2        0.58        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.59            -0.2        0.43 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.24 ±  3%      -0.2        0.09 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      2.34            -0.2        2.19        perf-profile.children.cycles-pp.mutex_unlock
      0.21            -0.1        0.06        perf-profile.children.cycles-pp.update_rq_clock
      0.21 ±  4%      -0.1        0.07        perf-profile.children.cycles-pp.sched_clock
      0.28 ±  4%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.23 ± 10%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.39 ±  2%      -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.83 ±  3%      -0.1        0.71        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.20 ±  4%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.20 ±  4%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.15 ±  6%      -0.1        0.06        perf-profile.children.cycles-pp.__fdget_pos
      0.17 ±  5%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.19 ±  8%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.14 ±  6%      -0.1        0.05        perf-profile.children.cycles-pp.__fget_light
      0.17 ±  9%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp._copy_from_iter
      0.17 ± 30%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.perf_tp_event
      0.12 ± 13%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.copyin
      0.13 ±  5%      -0.1        0.07        perf-profile.children.cycles-pp.security_file_permission
      0.12 ±  9%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.11 ±  7%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.14 ±  3%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.reweight_entity
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  5%      -0.0        0.14        perf-profile.children.cycles-pp.cpuacct_charge
      0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.task_work_run
      0.11 ±  6%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.15 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.40 ±  3%      +0.0        0.44        perf-profile.children.cycles-pp.copy_page_to_iter
      0.14 ±  6%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__enqueue_entity
      0.38 ±  3%      +0.1        0.43        perf-profile.children.cycles-pp._copy_to_iter
      0.36 ±  3%      +0.1        0.42        perf-profile.children.cycles-pp.copyout
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.irqtime_account_irq
      0.04 ± 44%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.pick_eevdf
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.15 ±  3%      +0.1        0.24        perf-profile.children.cycles-pp.__entry_text_start
      0.08            +0.1        0.17 ±  5%  perf-profile.children.cycles-pp.kill_fasync
      0.04 ± 73%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.check_preempt_curr
      0.00            +0.2        0.20        perf-profile.children.cycles-pp.task_h_load
      0.08 ±  4%      +0.2        0.31        perf-profile.children.cycles-pp.wake_affine
      0.00            +0.3        0.28        perf-profile.children.cycles-pp.__task_rq_lock
      0.07 ±  5%      +0.8        0.86 ±  2%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.08 ±  4%      +0.9        0.93        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.09 ±  8%      +1.0        1.04        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     61.05            +4.0       65.06        perf-profile.children.cycles-pp.read
     59.44            +4.8       64.20        perf-profile.children.cycles-pp.ksys_read
     59.30            +4.8       64.14        perf-profile.children.cycles-pp.vfs_read
     59.07            +4.9       64.00        perf-profile.children.cycles-pp.pipe_read
     11.26            +9.7       20.98        perf-profile.children.cycles-pp.finish_wait
     13.03           +20.6       33.64        perf-profile.children.cycles-pp.prepare_to_wait_event
     11.12           +22.6       33.68        perf-profile.children.cycles-pp.ksys_write
     11.00           +22.6       33.59        perf-profile.children.cycles-pp.vfs_write
     10.78           +22.7       33.45        perf-profile.children.cycles-pp.pipe_write
     11.68           +22.8       34.45        perf-profile.children.cycles-pp.write
      6.96           +23.7       30.64        perf-profile.children.cycles-pp.__wake_up_common_lock
     71.77           +27.0       98.74        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     71.60           +27.1       98.69        perf-profile.children.cycles-pp.do_syscall_64
     24.51           +52.5       76.99        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     22.25           +56.2       78.42        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     12.41           -12.4        0.00        perf-profile.self.cycles-pp.intel_idle
      9.25 ±  2%      -8.0        1.30        perf-profile.self.cycles-pp.osq_lock
      4.21            -3.3        0.94        perf-profile.self.cycles-pp.mutex_spin_on_owner
      2.00 ±  7%      -1.7        0.25 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      2.84            -1.5        1.35        perf-profile.self.cycles-pp.prepare_to_wait_event
      1.69 ±  5%      -1.3        0.35        perf-profile.self.cycles-pp.update_load_avg
      1.56 ±  2%      -1.3        0.26        perf-profile.self.cycles-pp._raw_spin_lock
      1.96            -1.3        0.69        perf-profile.self.cycles-pp.__mutex_lock
      1.26 ±  2%      -1.0        0.30 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.86            -0.7        0.18 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      1.06            -0.7        0.40 ±  2%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.90 ±  4%      -0.6        0.28 ±  2%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.76            -0.6        0.20 ±  2%  perf-profile.self.cycles-pp.llist_add_batch
      2.18            -0.5        1.66        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.60 ±  4%      -0.5        0.09 ±  5%  perf-profile.self.cycles-pp.available_idle_cpu
      0.59 ±  2%      -0.5        0.08 ±  5%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.56 ±  2%      -0.5        0.07        perf-profile.self.cycles-pp.llist_reverse_order
      0.60 ±  2%      -0.5        0.13 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.59 ±  2%      -0.5        0.12 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      0.58 ± 10%      -0.4        0.14        perf-profile.self.cycles-pp.prepare_task_switch
      0.61 ±  2%      -0.4        0.18 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.53 ±  2%      -0.4        0.12 ±  4%  perf-profile.self.cycles-pp.osq_unlock
      1.29            -0.3        0.96        perf-profile.self.cycles-pp.pipe_read
      0.35 ±  3%      -0.3        0.06 ±  6%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.33 ±  2%      -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.28 ±  2%      -0.2        0.09 ±  4%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.23 ±  6%      -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.stress_pipeherd_read_write
      2.31            -0.2        2.15        perf-profile.self.cycles-pp.mutex_unlock
      0.23 ±  3%      -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.schedule
      0.23 ±  3%      -0.1        0.08        perf-profile.self.cycles-pp.dequeue_task_fair
      0.19 ± 27%      -0.1        0.06 ± 19%  perf-profile.self.cycles-pp.read
      0.20 ±  2%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.enqueue_entity
      0.21 ± 12%      -0.1        0.09        perf-profile.self.cycles-pp.__update_load_avg_se
      0.25 ±  5%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.17 ±  2%      -0.1        0.05        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.82 ±  3%      -0.1        0.71        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.14 ±  5%      -0.1        0.05        perf-profile.self.cycles-pp.__fget_light
      0.20 ±  4%      -0.1        0.12        perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.13 ±  6%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.reweight_entity
      0.12 ± 15%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.copyin
      0.15 ±  4%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.vfs_read
      0.17 ±  4%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.switch_fpu_return
      0.12 ±  9%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.09 ±  5%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.vfs_write
      0.10 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  6%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.cpuacct_charge
      0.10 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.10 ±  3%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.15 ±  4%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.14 ±  7%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__enqueue_entity
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.ksys_write
      0.35 ±  3%      +0.1        0.41        perf-profile.self.cycles-pp.copyout
      0.47 ±  5%      +0.1        0.53 ±  2%  perf-profile.self.cycles-pp.pipe_write
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.place_entity
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.check_preempt_curr
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.07 ±  6%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.kill_fasync
      0.04 ± 75%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.10 ±  5%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.01 ±223%      +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.pick_eevdf
      0.05 ±  7%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.00            +0.2        0.20        perf-profile.self.cycles-pp.task_h_load
      0.24            +0.3        0.51        perf-profile.self.cycles-pp.__wake_up_common
      0.12 ±  4%      +0.4        0.54 ±  2%  perf-profile.self.cycles-pp.try_to_wake_up
     24.49           +52.5       76.99        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/pipeherd/stress-ng/60s

commit: 
  dfaabf916b ("fs/pipe: remove unnecessary spinlock from pipe_write()")
  478dbf1217 ("fs/pipe: use spinlock in pipe_read() only if there is a watch_queue")

dfaabf916b1ca83c 478dbf12176700f28d836dd03ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8603 ± 12%     +17.5%      10111 ±  3%  perf-c2c.HITM.local
      3042 ± 14%     -48.7%       1560 ± 46%  uptime.idle
 2.229e+09 ± 21%     -67.9%  7.145e+08 ± 92%  cpuidle..time
  28028489 ±  3%     -97.1%     810118 ± 85%  cpuidle..usage
     88.08           -68.0       20.13 ± 83%  mpstat.cpu.all.idle%
     10.35 ± 15%     +67.9       78.24 ± 21%  mpstat.cpu.all.sys%
     88.33           -74.9%      22.18 ± 72%  vmstat.cpu.id
     10.81 ± 12%    +615.2%      77.30 ± 20%  vmstat.cpu.sy
   3844276           -14.5%    3285820        vmstat.memory.cache
      4.22 ± 16%   +1708.7%      76.30 ± 20%  vmstat.procs.r
    737453 ± 16%     -78.6%     157732 ± 25%  vmstat.system.cs
     56136 ±  4%     +49.3%      83808 ± 13%  vmstat.system.in
      1.00           -70.0%       0.30 ± 14%  stress-ng.pipeherd.context_switches_per_bogo_op
    416502 ±  4%     -54.2%     190940 ±  6%  stress-ng.pipeherd.context_switches_per_sec
  24976673 ±  4%     +54.3%   38526698 ±  8%  stress-ng.pipeherd.ops
    416194 ±  4%     +54.2%     641978 ±  8%  stress-ng.pipeherd.ops_per_sec
     12656 ±  8%  +17042.2%    2169605        stress-ng.time.involuntary_context_switches
    418.67 ±  9%    +722.0%       3441        stress-ng.time.percent_of_cpu_this_job_got
    256.62 ±  9%    +730.2%       2130        stress-ng.time.system_time
  24977642 ±  4%     -62.8%    9287021 ±  7%  stress-ng.time.voluntary_context_switches
    874362 ±  7%     -52.8%     412641 ±  9%  meminfo.Active
    874215 ±  7%     -52.8%     412493 ±  9%  meminfo.Active(anon)
   3758519           -14.7%    3205853        meminfo.Cached
   2362981 ±  4%     -27.5%    1714057 ±  9%  meminfo.Committed_AS
    437679 ±  6%     -22.4%     339632 ±  5%  meminfo.Inactive
    437498 ±  6%     -22.4%     339452 ±  5%  meminfo.Inactive(anon)
    113085 ± 11%     -41.1%      66608 ± 11%  meminfo.Mapped
   4522886           -13.0%    3936630        meminfo.Memused
   1007947 ±  5%     -54.8%     455265 ±  6%  meminfo.Shmem
   4699970           -12.5%    4110226        meminfo.max_used_kB
    218555 ±  7%     -52.8%     103125 ±  9%  proc-vmstat.nr_active_anon
    939642           -14.7%     801478        proc-vmstat.nr_file_pages
    109380 ±  6%     -22.4%      84873 ±  5%  proc-vmstat.nr_inactive_anon
     28279 ± 11%     -41.0%      16676 ± 11%  proc-vmstat.nr_mapped
    251993 ±  5%     -54.8%     113825 ±  6%  proc-vmstat.nr_shmem
     19860            -2.0%      19458        proc-vmstat.nr_slab_reclaimable
    218555 ±  7%     -52.8%     103125 ±  9%  proc-vmstat.nr_zone_active_anon
    109380 ±  6%     -22.4%      84873 ±  5%  proc-vmstat.nr_zone_inactive_anon
    598000 ±  3%     -33.1%     400291 ±  2%  proc-vmstat.numa_hit
    593890 ±  2%     -32.6%     400270 ±  2%  proc-vmstat.numa_local
    312421 ±  3%     -53.5%     145140 ±  2%  proc-vmstat.pgactivate
    629037 ±  2%     -30.0%     440277 ±  4%  proc-vmstat.pgalloc_normal
    546.00 ± 12%    +449.4%       2999 ± 20%  turbostat.Avg_MHz
     14.73 ±  8%     +64.9       79.68 ± 19%  turbostat.Busy%
   4330713 ± 10%     -99.8%      10550 ± 20%  turbostat.C1
      8.68 ± 19%      -8.7        0.02 ± 33%  turbostat.C1%
  23233631 ±  2%     -99.7%      63441 ±  4%  turbostat.C1E
     65.25 ± 14%     -65.1        0.19 ± 10%  turbostat.C1E%
     81.35 ±  5%     -84.3%      12.80 ± 66%  turbostat.CPU%c1
      0.11 ±  8%     -73.1%       0.03        turbostat.IPC
   4029671 ± 13%     +65.0%    6649120 ±  9%  turbostat.IRQ
     62641 ±  3%     -93.9%       3839 ±  6%  turbostat.POLL
      0.04 ± 14%      -0.0        0.00        turbostat.POLL%
     91.90 ±  9%     +36.3%     125.23 ± 16%  turbostat.PkgWatt
     21202 ± 12%   +4673.9%    1012191        sched_debug.cfs_rq:/.avg_vruntime.avg
     44364 ± 10%   +2314.4%    1071128 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
     16887 ± 15%   +5806.3%     997400        sched_debug.cfs_rq:/.avg_vruntime.min
      6102 ±  4%    +160.4%      15892 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.31 ± 10%    +444.7%       1.66        sched_debug.cfs_rq:/.h_nr_running.avg
      1.50 ± 27%    +105.6%       3.08 ± 11%  sched_debug.cfs_rq:/.h_nr_running.max
      0.46 ±  7%     +30.1%       0.60 ± 10%  sched_debug.cfs_rq:/.h_nr_running.stddev
     21202 ± 12%   +4673.9%    1012191        sched_debug.cfs_rq:/.min_vruntime.avg
     44364 ± 10%   +2314.4%    1071128 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
     16886 ± 15%   +5806.3%     997400        sched_debug.cfs_rq:/.min_vruntime.min
      6102 ±  4%    +160.4%      15892 ± 14%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.31 ± 10%    +133.3%       0.71        sched_debug.cfs_rq:/.nr_running.avg
      0.46 ±  7%     -41.4%       0.27 ± 10%  sched_debug.cfs_rq:/.nr_running.stddev
    384.17 ±  2%    +352.4%       1737 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      1150 ± 10%    +155.9%       2944 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
     12.25 ± 52%   +6198.6%     771.58 ± 15%  sched_debug.cfs_rq:/.runnable_avg.min
    248.32 ± 10%    +105.2%     509.54 ± 14%  sched_debug.cfs_rq:/.runnable_avg.stddev
    381.95 ±  2%    +117.5%     830.83        sched_debug.cfs_rq:/.util_avg.avg
      1141 ± 10%     +40.1%       1599 ± 10%  sched_debug.cfs_rq:/.util_avg.max
     12.17 ± 53%   +2363.7%     299.75 ± 15%  sched_debug.cfs_rq:/.util_avg.min
     34.78 ± 10%   +1282.8%     480.87 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    355.00 ± 21%    +162.2%     930.75 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.max
     93.73 ± 12%     +88.5%     176.68 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
     18301 ± 24%     -57.5%       7772 ± 19%  sched_debug.cpu.avg_idle.min
      0.77 ±  3%    +147.8%       1.91 ± 28%  sched_debug.cpu.clock.stddev
    970.32 ±  6%    +155.7%       2480 ±  2%  sched_debug.cpu.curr->pid.avg
      1500 ±  2%     -44.1%     839.20 ±  9%  sched_debug.cpu.curr->pid.stddev
      0.33 ±  6%    +408.5%       1.67 ±  2%  sched_debug.cpu.nr_running.avg
      1.58 ± 28%     +94.7%       3.08 ± 11%  sched_debug.cpu.nr_running.max
    689795 ±  4%     -76.0%     165666 ±  5%  sched_debug.cpu.nr_switches.avg
    761385 ±  5%     -71.2%     218907 ±  4%  sched_debug.cpu.nr_switches.max
    629289 ±  4%     -76.6%     146963 ±  7%  sched_debug.cpu.nr_switches.min
     29571 ± 12%     -45.9%      15995 ± 25%  sched_debug.cpu.nr_switches.stddev
 1.452e+09 ± 14%     +86.2%  2.704e+09 ± 21%  perf-stat.i.branch-instructions
  29026461 ± 12%     -38.0%   18003501 ± 20%  perf-stat.i.branch-misses
   1799227 ±  6%     -35.0%    1169320 ±  9%  perf-stat.i.cache-misses
    770793 ± 16%     -78.8%     163414 ± 25%  perf-stat.i.context-switches
      3.86 ± 40%    +161.9%      10.10 ±  7%  perf-stat.i.cpi
 2.002e+10 ± 12%    +448.0%  1.097e+11 ± 21%  perf-stat.i.cpu-cycles
    285495 ± 18%    +570.0%    1912682 ± 20%  perf-stat.i.cycles-between-cache-misses
   1022908 ±  6%     -47.3%     539430 ± 25%  perf-stat.i.dTLB-load-misses
 1.807e+09 ± 14%     +62.4%  2.935e+09 ± 21%  perf-stat.i.dTLB-loads
     39.71 ± 15%     +36.2       75.87 ±  3%  perf-stat.i.iTLB-load-miss-rate%
   6486811 ± 16%     -82.9%    1106716 ± 25%  perf-stat.i.iTLB-loads
  7.01e+09 ± 14%     +64.8%  1.156e+10 ± 21%  perf-stat.i.instructions
      2094 ±  8%     +51.4%       3171 ± 17%  perf-stat.i.instructions-per-iTLB-miss
      0.35 ± 14%     -62.1%       0.13 ± 10%  perf-stat.i.ipc
      0.10 ± 46%     -84.4%       0.02 ± 47%  perf-stat.i.major-faults
      0.56 ± 12%    +448.1%       3.05 ± 21%  perf-stat.i.metric.GHz
    261027 ± 15%     -43.8%     146804 ± 21%  perf-stat.i.node-loads
      0.26 ± 16%     -58.8%       0.11 ± 31%  perf-stat.overall.MPKI
      2.01 ±  7%      -1.3        0.67 ± 13%  perf-stat.overall.branch-miss-rate%
      1.76 ± 15%      -0.6        1.19 ± 30%  perf-stat.overall.cache-miss-rate%
      2.88 ±  8%    +230.4%       9.50        perf-stat.overall.cpi
     11182 ± 15%    +762.2%      96416 ± 28%  perf-stat.overall.cycles-between-cache-misses
      0.06 ± 19%      -0.0        0.02 ± 48%  perf-stat.overall.dTLB-load-miss-rate%
     36.83           +39.0       75.86 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      1863 ±  3%     +79.8%       3351 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
      0.35 ±  8%     -69.9%       0.11        perf-stat.overall.ipc
  1.43e+09 ± 13%     +86.5%  2.668e+09 ± 21%  perf-stat.ps.branch-instructions
  28597432 ± 12%     -37.9%   17753411 ± 20%  perf-stat.ps.branch-misses
   1774283 ±  6%     -35.0%    1153774 ± 10%  perf-stat.ps.cache-misses
    759052 ± 16%     -78.8%     161170 ± 25%  perf-stat.ps.context-switches
 1.972e+10 ± 12%    +448.9%  1.083e+11 ± 20%  perf-stat.ps.cpu-cycles
   1008110 ±  6%     -47.2%     532619 ± 26%  perf-stat.ps.dTLB-load-misses
  1.78e+09 ± 14%     +62.6%  2.895e+09 ± 20%  perf-stat.ps.dTLB-loads
   6388075 ± 16%     -82.9%    1091500 ± 24%  perf-stat.ps.iTLB-loads
 6.905e+09 ± 13%     +65.1%   1.14e+10 ± 20%  perf-stat.ps.instructions
      0.10 ± 46%     -84.5%       0.02 ± 47%  perf-stat.ps.major-faults
    257449 ± 15%     -43.8%     144773 ± 20%  perf-stat.ps.node-loads
  4.73e+11 ±  3%     +82.7%   8.64e+11        perf-stat.total.instructions
      0.00 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_write
      0.00 ±223%  +1.7e+05%       0.28 ± 66%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.01 ± 40%    +716.3%       0.07 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00 ± 20%  +25442.9%       0.60 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00 ± 10%  +19830.8%       0.86 ± 30%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 23%  +13800.0%       0.70 ± 67%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 33%   +1777.8%       0.03 ±  3%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ± 17%  +18623.1%       0.41 ± 14%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +3379.2%       0.14 ± 33%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ± 35%    +226.1%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00         +5183.3%       0.11 ±  7%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 14%    +400.0%       0.02 ± 17%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 14%  +26861.9%       0.94 ± 53%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 28%    +856.7%       0.05 ± 55%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00        +10516.7%       0.32 ± 19%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00 ±  9%    +108.7%       0.01 ± 30%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ± 14%    +455.0%       0.02 ± 22%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 47%   +7563.6%       0.42 ± 58%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00        +16866.7%       0.34 ± 37%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.01 ± 11%    +263.3%       0.02 ± 29%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_write
      0.00 ± 23%  +24375.0%       1.14 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +3.4e+05%       1.12 ± 69%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.72 ± 64%    +962.7%       7.65 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00 ± 20%    +1e+05%       2.39 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.01 ± 16%  +40029.4%       2.27 ± 55%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 27%  +17475.8%       0.97 ± 37%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.08 ± 77%   +6307.9%       4.87 ± 14%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 30%  +39070.8%       3.13 ± 29%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 38%   +8252.4%       0.88 ± 47%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.49 ± 88%   +1842.2%       9.53 ± 45%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.32 ±  9%    +487.2%      13.62 ± 20%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 20%   +1054.3%       0.07 ± 23%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  9%  +32851.5%       1.81 ± 22%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ± 17%  +36980.8%       1.61 ± 53%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 17%   +5271.4%       0.50 ± 87%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ± 27%     -71.4%       0.00 ±141%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.01 ± 37%  +27248.1%       2.37 ± 38%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 11%   +3235.1%       0.21 ±113%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     34.64 ±107%     -97.3%       0.92 ± 52%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 53%   +7588.6%       0.56 ± 57%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ± 90%  +48484.6%       2.11 ± 40%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.04 ± 14%   +1334.4%       0.58 ±116%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00         +4258.3%       0.09 ±  8%  perf-sched.total_sch_delay.average.ms
      0.59 ±  4%    +127.3%       1.35        perf-sched.total_wait_and_delay.average.ms
   1531048 ±  4%     -61.2%     593676 ±  2%  perf-sched.total_wait_and_delay.count.ms
      0.59 ±  4%    +113.4%       1.26 ±  2%  perf-sched.total_wait_time.average.ms
     14.68 ± 52%     -84.2%       2.32 ± 55%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      4.70 ± 73%    +165.6%      12.47 ± 26%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.12           +60.1%       0.18 ± 12%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    268.20 ±  6%     -13.0%     233.42 ±  6%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.37 ±  4%    +137.4%       0.87 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.11 ±  7%     -23.1%       3.16 ±  7%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     27.41 ±  3%    +136.9%      64.94 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     91.53 ±  7%     -27.6%      66.23 ± 12%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    116.38 ± 11%     +64.2%     191.11 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.17 ± 64%   +1300.0%      58.33 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     75321           -42.9%      43036 ±  2%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     71.00 ±223%  +87493.9%      62191 ±  2%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
   1451839 ±  4%     -69.5%     442901 ±  3%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    586.17 ±  4%     -61.4%     226.17 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     52.50 ±  5%     +44.1%      75.67 ± 14%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1611 ± 10%     -39.0%     982.83 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     15.07 ± 79%    +828.8%     139.99 ± 29%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    166.69 ±223%    +501.4%       1002        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.31 ± 20%     -58.0%       0.13 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_write
     14.68 ± 52%     -83.2%       2.46 ± 41%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      4.70 ± 73%    +165.5%      12.47 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.32 ±  3%     +30.0%       0.42 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.30 ± 17%     -45.0%       0.17 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      6.47 ± 60%     -81.6%       1.19 ±162%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.62 ±105%     -91.7%       0.05 ±107%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    268.20 ±  6%     -13.1%     233.01 ±  6%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.24 ±  2%    +219.8%       0.75 ± 19%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±166%   +3612.2%       0.25 ± 49%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.36 ±  4%    +109.7%       0.76 ±  3%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.10 ±  7%     -23.5%       3.14 ±  8%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     27.41 ±  3%    +136.8%      64.92 ±  3%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.32 ±  2%    +335.2%       1.40 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     91.53 ±  7%     -27.7%      66.21 ± 12%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    116.35 ± 11%     +64.2%     191.09 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 44%  +14140.0%       0.12 ± 43%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.36 ±  4%    +403.1%       1.83 ± 60%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
     15.07 ± 79%    +828.6%     139.98 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.61 ± 64%   +1225.8%       8.07 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.37 ±  6%    +221.4%       1.20 ± 73%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.39 ±  6%    +435.7%       2.07 ±113%  perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.10 ±207%     -98.8%       0.06 ±104%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.71          +325.0%       3.00 ± 29%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±188%  +64933.3%       7.80 ±130%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    501.89 ± 99%     -66.5%     168.27 ±221%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    170.24 ±218%    +488.1%       1001        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.39 ±  4%    +201.2%       1.17 ± 78%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.73 ±  3%    +553.1%       4.74 ± 21%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 19%  +16302.1%       1.31 ± 50%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     57.90 ±  2%     -57.9        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     56.34 ±  2%     -56.3        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     56.33 ±  2%     -56.3        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     56.30 ±  2%     -56.3        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     52.69           -52.7        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     52.61 ±  2%     -52.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     51.32 ±  2%     -51.3        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     45.08           -45.1        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      9.82 ±  8%      -9.4        0.38 ± 71%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.69 ± 11%      -5.7        0.00        perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      5.49 ± 15%      -5.5        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_read.vfs_read.ksys_read
      1.96 ±  5%      -1.6        0.38 ± 70%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.91 ±  5%      -1.5        0.38 ± 70%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      1.34 ±  8%      +0.2        1.56        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      1.25 ±  8%      +0.3        1.52        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      7.23 ± 10%     +13.6       20.80 ±  2%  perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.74 ± 11%     +14.0       20.74 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
      6.30 ± 12%     +14.4       20.68 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
     34.82 ±  5%     +19.8       54.60 ±  4%  perf-profile.calltrace.cycles-pp.read
     34.31 ±  5%     +20.1       54.45 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     34.25 ±  5%     +20.2       54.44 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     33.99 ±  5%     +20.4       54.37 ±  4%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     33.92 ±  5%     +20.4       54.34 ±  4%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     33.75 ±  5%     +20.5       54.24 ±  4%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.49 ±  8%     +22.8       31.30 ±  5%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.11 ± 13%     +24.8       30.93 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      5.10 ± 16%     +25.7       30.81 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      6.68 ±  3%     +38.6       45.30 ±  5%  perf-profile.calltrace.cycles-pp.write
      6.38 ±  3%     +38.7       45.08 ±  5%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.47 ±  3%     +38.7       45.20 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      6.30 ±  3%     +38.7       45.04 ±  5%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.44 ±  3%     +38.7       45.19 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.13 ±  3%     +38.8       44.96 ±  5%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.94 ±  7%     +40.4       42.38 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.73 ±  8%     +40.5       42.26 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      3.61           +40.7       44.31 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     57.90 ±  2%     -57.9        0.00        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     57.90 ±  2%     -57.9        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     57.88 ±  2%     -57.9        0.00        perf-profile.children.cycles-pp.do_idle
     56.34 ±  2%     -56.3        0.00        perf-profile.children.cycles-pp.start_secondary
     54.08 ±  2%     -54.1        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     52.75           -52.7        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     52.74           -52.7        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     45.08           -45.1        0.00        perf-profile.children.cycles-pp.intel_idle
     11.33 ±  7%     -10.7        0.61 ± 20%  perf-profile.children.cycles-pp.__mutex_lock
      6.79 ± 10%      -6.8        0.00        perf-profile.children.cycles-pp.intel_idle_irq
      6.45 ± 13%      -6.2        0.22 ± 25%  perf-profile.children.cycles-pp.osq_lock
      3.35 ±  7%      -2.7        0.63 ±  6%  perf-profile.children.cycles-pp.__schedule
      2.50 ±  2%      -2.4        0.13 ± 31%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      1.75 ±  3%      -1.5        0.26 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.04 ±  5%      -1.4        0.60 ±  6%  perf-profile.children.cycles-pp.schedule
      1.53 ±  2%      -1.0        0.48 ±  3%  perf-profile.children.cycles-pp.mutex_lock
      1.20 ±  4%      -0.8        0.35 ±  2%  perf-profile.children.cycles-pp.mutex_unlock
      0.84 ±  7%      -0.7        0.11 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
      0.91 ±  6%      -0.7        0.23 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.91 ±  7%      -0.6        0.32 ±  6%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.65 ±  3%      -0.6        0.07 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      0.84 ±  7%      -0.6        0.28 ±  7%  perf-profile.children.cycles-pp.activate_task
      0.80 ±  4%      -0.6        0.23 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.70 ±  8%      -0.6        0.14 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.78 ±  7%      -0.5        0.26 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.55 ±  2%      -0.5        0.06 ±  9%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.54 ±  2%      -0.5        0.08 ± 10%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.63 ±  3%      -0.4        0.22 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.62 ±  3%      -0.4        0.22 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.41 ±  7%      -0.3        0.07 ± 11%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.53 ±  6%      -0.3        0.20 ±  7%  perf-profile.children.cycles-pp.update_load_avg
      0.46 ±  9%      -0.3        0.14 ± 10%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.51 ±  3%      -0.3        0.20 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.35 ± 13%      -0.3        0.04 ± 45%  perf-profile.children.cycles-pp.prepare_task_switch
      0.41 ±  8%      -0.3        0.13 ±  5%  perf-profile.children.cycles-pp.select_task_rq
      0.39 ±  9%      -0.3        0.13 ±  7%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.37 ±  4%      -0.2        0.15 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.34 ±  6%      -0.2        0.15 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.33 ±  7%      -0.2        0.15 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.20 ± 10%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.set_next_entity
      0.29 ±  6%      -0.2        0.13 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.21 ± 11%      -0.2        0.06 ±  6%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.21 ± 11%      -0.2        0.06 ±  6%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.17 ±  9%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.19 ± 11%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.26 ±  6%      -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.26 ±  9%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.22 ±  9%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.15 ± 16%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__entry_text_start
      0.11 ± 13%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.10 ±  8%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.14 ± 13%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.security_file_permission
      0.14 ±  9%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.reweight_entity
      0.19 ±  8%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.18 ± 10%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp._copy_to_iter
      0.12 ± 17%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.15 ± 11%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.16 ± 10%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.copyout
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.wake_affine
      1.34 ±  8%      +0.2        1.56        perf-profile.children.cycles-pp.autoremove_wake_function
      1.30 ±  7%      +0.2        1.53        perf-profile.children.cycles-pp.try_to_wake_up
      7.24 ± 10%     +13.6       20.80 ±  2%  perf-profile.children.cycles-pp.finish_wait
     34.88 ±  5%     +19.7       54.62 ±  4%  perf-profile.children.cycles-pp.read
     33.99 ±  5%     +20.4       54.37 ±  4%  perf-profile.children.cycles-pp.ksys_read
     33.93 ±  5%     +20.4       54.34 ±  4%  perf-profile.children.cycles-pp.vfs_read
     33.78 ±  5%     +20.5       54.25 ±  4%  perf-profile.children.cycles-pp.pipe_read
      8.50 ±  8%     +22.8       31.33 ±  5%  perf-profile.children.cycles-pp.prepare_to_wait_event
      6.72 ±  4%     +38.6       45.33 ±  5%  perf-profile.children.cycles-pp.write
      6.38 ±  3%     +38.7       45.09 ±  5%  perf-profile.children.cycles-pp.ksys_write
      6.30 ±  3%     +38.8       45.06 ±  5%  perf-profile.children.cycles-pp.vfs_write
      6.13 ±  3%     +38.8       44.96 ±  5%  perf-profile.children.cycles-pp.pipe_write
      3.61           +40.7       44.33 ±  5%  perf-profile.children.cycles-pp.__wake_up_common_lock
     40.95 ±  3%     +58.8       99.70        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.86 ±  3%     +58.8       99.67        perf-profile.children.cycles-pp.do_syscall_64
     15.58 ± 12%     +78.2       93.75        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     15.12 ± 11%     +79.6       94.76        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     45.08           -45.1        0.00        perf-profile.self.cycles-pp.intel_idle
      6.48 ± 10%      -6.5        0.00        perf-profile.self.cycles-pp.intel_idle_irq
      6.43 ± 13%      -6.2        0.22 ± 24%  perf-profile.self.cycles-pp.osq_lock
      2.48 ±  2%      -2.4        0.12 ± 30%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      2.00 ±  3%      -1.8        0.23 ± 12%  perf-profile.self.cycles-pp.__mutex_lock
      1.81 ±  4%      -1.6        0.26 ±  8%  perf-profile.self.cycles-pp.prepare_to_wait_event
      1.49 ±  2%      -1.1        0.44 ±  3%  perf-profile.self.cycles-pp.mutex_lock
      1.98 ±  4%      -1.0        1.01 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.19 ±  4%      -0.8        0.35 ±  2%  perf-profile.self.cycles-pp.mutex_unlock
      0.98 ± 40%      -0.8        0.22 ± 20%  perf-profile.self.cycles-pp.pipe_read
      0.63 ±  4%      -0.6        0.06 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock
      0.55 ±  2%      -0.5        0.06 ±  9%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.54 ±  2%      -0.5        0.08 ± 10%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.40 ±  7%      -0.3        0.07 ± 11%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.30 ± 11%      -0.2        0.06 ± 11%  perf-profile.self.cycles-pp.__schedule
      0.24 ± 47%      -0.1        0.10 ± 22%  perf-profile.self.cycles-pp.pipe_write
      0.17 ±  8%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.18 ± 11%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.17 ±  8%      -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.update_load_avg
      0.11 ± 13%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.10 ±  4%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.10 ± 16%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.08 ± 14%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.vfs_read
      0.13 ± 12%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.update_curr
      0.13 ± 10%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.06 ± 11%      +0.2        0.28 ±  4%  perf-profile.self.cycles-pp.try_to_wake_up
     15.57 ± 12%     +78.2       93.75        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/pipeherd/stress-ng/60s

commit: 
  dfaabf916b ("fs/pipe: remove unnecessary spinlock from pipe_write()")
  478dbf1217 ("fs/pipe: use spinlock in pipe_read() only if there is a watch_queue")

dfaabf916b1ca83c 478dbf12176700f28d836dd03ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3218 ±  7%     -64.0%       1159 ±  3%  uptime.idle
  2.15e+09 ± 10%     -92.7%  1.569e+08 ± 26%  cpuidle..time
  28312679 ±  3%     -99.2%     226773 ± 20%  cpuidle..usage
     88.51           -90.4%       8.53 ± 22%  iostat.cpu.idle
     10.66 ±  8%    +751.3%      90.73 ±  2%  iostat.cpu.system
     88.29           -82.5        5.80 ± 34%  mpstat.cpu.all.idle%
      0.18 ±  6%      -0.2        0.02 ±127%  mpstat.cpu.all.iowait%
      0.03 ± 41%      -0.0        0.01 ± 72%  mpstat.cpu.all.soft%
     10.18 ±  9%     +82.7       92.92 ±  2%  mpstat.cpu.all.sys%
     88.52           -90.4%       8.53 ± 22%  vmstat.cpu.id
     10.58 ±  7%    +760.1%      90.96 ±  2%  vmstat.cpu.sy
   3961072           -15.3%    3355228        vmstat.memory.cache
      0.06 ± 26%     +60.2%       0.10 ± 26%  vmstat.procs.b
      4.30 ± 10%   +1980.9%      89.58 ±  2%  vmstat.procs.r
    762268 ± 11%     -77.0%     175567 ±  5%  vmstat.system.cs
     56813 ±  3%     +62.5%      92337 ±  2%  vmstat.system.in
      1.00           -73.7%       0.26 ± 16%  stress-ng.pipeherd.context_switches_per_bogo_op
    422393 ±  3%     -57.3%     180352 ±  7%  stress-ng.pipeherd.context_switches_per_sec
  25330501 ±  3%     +65.9%   42034438 ±  9%  stress-ng.pipeherd.ops
    422091 ±  3%     +65.9%     700420 ±  9%  stress-ng.pipeherd.ops_per_sec
     12279 ± 10%  +17973.5%    2219247 ±  2%  stress-ng.time.involuntary_context_switches
    404.83 ±  8%    +750.4%       3442        stress-ng.time.percent_of_cpu_this_job_got
    247.92 ±  8%    +759.8%       2131        stress-ng.time.system_time
  25331495 ±  3%     -66.0%    8602230 ±  9%  stress-ng.time.voluntary_context_switches
    895561 ±  4%     -57.3%     382181 ±  3%  meminfo.Active
    879277 ±  4%     -58.4%     366187 ±  3%  meminfo.Active(anon)
   3872564           -15.5%    3270847        meminfo.Cached
   2401045 ±  3%     -22.8%    1853555        meminfo.Committed_AS
    475367 ±  4%     -18.7%     386563        meminfo.Inactive
    445059 ±  4%     -19.8%     356852        meminfo.Inactive(anon)
    114606 ±  7%     -36.4%      72849        meminfo.Mapped
   4667746           -13.1%    4054799        meminfo.Memused
   1016981 ±  3%     -59.1%     415879 ±  3%  meminfo.Shmem
   4840062           -13.2%    4200782        meminfo.max_used_kB
    534.83 ±  7%    +562.8%       3545        turbostat.Avg_MHz
     14.40 ±  5%     +79.0       93.38        turbostat.Busy%
   4475560 ±  9%     -99.8%      10024 ± 16%  turbostat.C1
      9.11 ± 15%      -9.1        0.02        turbostat.C1%
  23453364 ±  2%     -99.7%      60473 ±  3%  turbostat.C1E
     66.62 ±  8%     -66.4        0.21 ± 12%  turbostat.C1E%
     82.30 ±  3%     -93.4%       5.44 ± 16%  turbostat.CPU%c1
      0.11 ±  8%     -73.1%       0.03        turbostat.IPC
   3944836 ±  6%     +53.8%    6067439 ±  2%  turbostat.IRQ
     79658 ±  2%     -93.2%       5424 ± 14%  turbostat.POLL
      0.05 ± 10%      -0.0        0.00        turbostat.POLL%
     91.93 ±  6%     +55.9%     143.28        turbostat.PkgWatt
    219821 ±  4%     -58.4%      91547 ±  3%  proc-vmstat.nr_active_anon
    972204           -15.5%     821697        proc-vmstat.nr_file_pages
    111279 ±  4%     -19.8%      89224        proc-vmstat.nr_inactive_anon
     28666 ±  7%     -36.4%      18241        proc-vmstat.nr_mapped
    254259 ±  3%     -59.1%     103980 ±  3%  proc-vmstat.nr_shmem
     20769            -1.9%      20366        proc-vmstat.nr_slab_reclaimable
    219821 ±  4%     -58.4%      91547 ±  3%  proc-vmstat.nr_zone_active_anon
    111279 ±  4%     -19.8%      89224        proc-vmstat.nr_zone_inactive_anon
    609301           -34.1%     401281        proc-vmstat.numa_hit
    609146           -34.1%     401295        proc-vmstat.numa_local
    317114 ±  2%     -54.7%     143501 ±  3%  proc-vmstat.pgactivate
    645016           -32.7%     434024        proc-vmstat.pgalloc_normal
    276064 ±  2%      -4.9%     262486        proc-vmstat.pgfault
    265446 ±  3%      -4.6%     253118        proc-vmstat.pgfree
     20100 ± 11%   +4962.1%    1017513        sched_debug.cfs_rq:/.avg_vruntime.avg
     42918 ±  9%   +2577.2%    1149014 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
     15663 ± 16%   +6273.5%     998340        sched_debug.cfs_rq:/.avg_vruntime.min
      6190 ±  4%    +314.0%      25629 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.31 ± 22%    +422.6%       1.61 ±  3%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.33 ± 35%    +112.5%       2.83 ±  8%  sched_debug.cfs_rq:/.h_nr_running.max
     20100 ± 11%   +4962.1%    1017513        sched_debug.cfs_rq:/.min_vruntime.avg
     42918 ±  9%   +2577.2%    1149014 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
     15663 ± 16%   +6273.5%     998340        sched_debug.cfs_rq:/.min_vruntime.min
      6190 ±  4%    +314.0%      25629 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.31 ± 21%    +126.1%       0.70 ±  3%  sched_debug.cfs_rq:/.nr_running.avg
      0.47 ± 15%     -39.1%       0.29 ± 11%  sched_debug.cfs_rq:/.nr_running.stddev
    397.84 ±  5%    +330.1%       1711 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      1165 ± 14%    +141.1%       2810 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
     19.42 ± 37%   +3062.2%     614.00 ± 42%  sched_debug.cfs_rq:/.runnable_avg.min
    254.87 ± 13%    +100.1%     509.97 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
    395.21 ±  5%    +107.4%     819.58 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
      1155 ± 14%     +29.7%       1499 ±  8%  sched_debug.cfs_rq:/.util_avg.max
     17.83 ± 39%   +1436.9%     274.08 ± 18%  sched_debug.cfs_rq:/.util_avg.min
     35.85 ± 23%   +1205.0%     467.81 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    409.50 ± 22%    +119.8%     900.25 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.max
    102.77 ± 20%     +71.8%     176.52 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    594564 ±  2%     -15.3%     503507 ±  4%  sched_debug.cpu.avg_idle.max
     18062 ± 12%     -61.3%       6998 ± 31%  sched_debug.cpu.avg_idle.min
    131393 ±  4%     -13.6%     113547 ±  6%  sched_debug.cpu.avg_idle.stddev
      0.77 ±  4%    +158.6%       2.00 ± 18%  sched_debug.cpu.clock.stddev
      1039 ± 13%    +147.2%       2570        sched_debug.cpu.curr->pid.avg
      1599 ±  5%     -42.5%     919.09 ± 11%  sched_debug.cpu.curr->pid.stddev
      0.32 ± 16%    +406.6%       1.61 ±  3%  sched_debug.cpu.nr_running.avg
      1.33 ± 35%    +118.8%       2.92 ± 11%  sched_debug.cpu.nr_running.max
    699532 ±  3%     -77.4%     158114 ±  6%  sched_debug.cpu.nr_switches.avg
    779983 ±  5%     -73.8%     204106 ±  4%  sched_debug.cpu.nr_switches.max
    637227 ±  3%     -78.4%     137662 ±  9%  sched_debug.cpu.nr_switches.min
     28918 ± 15%     -43.3%      16398 ± 21%  sched_debug.cpu.nr_switches.stddev
 1.401e+09 ±  8%    +127.4%  3.184e+09        perf-stat.i.branch-instructions
      2.44 ± 38%      -1.8        0.65 ± 25%  perf-stat.i.branch-miss-rate%
  25035828 ±  7%     -28.6%   17879988        perf-stat.i.branch-misses
      2.19 ± 11%      -0.6        1.63 ±  7%  perf-stat.i.cache-miss-rate%
   1702174 ±  2%     -38.4%    1048083 ±  2%  perf-stat.i.cache-misses
    795145 ± 11%     -77.0%     182966 ±  5%  perf-stat.i.context-switches
      3.65 ± 25%    +159.4%       9.47        perf-stat.i.cpi
 1.966e+10 ±  7%    +560.8%  1.299e+11        perf-stat.i.cpu-cycles
     16144 ±  9%     +23.0%      19862 ±  6%  perf-stat.i.cpu-migrations
    284722 ±  9%    +623.7%    2060501 ±  7%  perf-stat.i.cycles-between-cache-misses
   1109773 ± 19%     -68.8%     346133 ± 10%  perf-stat.i.dTLB-load-misses
 1.769e+09 ±  8%     +95.9%  3.465e+09 ±  2%  perf-stat.i.dTLB-loads
     66506 ± 39%     -40.4%      39643 ±  9%  perf-stat.i.dTLB-store-misses
 9.259e+08 ± 10%     -30.2%  6.466e+08 ±  3%  perf-stat.i.dTLB-stores
     38.77 ±  8%     +38.3       77.03 ±  2%  perf-stat.i.iTLB-load-miss-rate%
   6678944 ± 10%     -81.6%    1227520 ±  5%  perf-stat.i.iTLB-loads
 6.754e+09 ±  8%    +101.2%  1.359e+10        perf-stat.i.instructions
      1867 ±  4%     +75.4%       3274 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.35 ±  9%     -59.0%       0.15        perf-stat.i.ipc
      0.55 ±  7%    +560.8%       3.61        perf-stat.i.metric.GHz
    328.36 ± 35%     -79.3%      67.84 ± 30%  perf-stat.i.metric.K/sec
    116.61 ±  9%     +76.5%     205.80 ±  2%  perf-stat.i.metric.M/sec
    271723 ±  8%     -37.1%     170829 ±  3%  perf-stat.i.node-loads
    226836 ±  8%     -21.4%     178231 ±  2%  perf-stat.i.node-stores
      0.25 ±  7%     -69.6%       0.08 ±  3%  perf-stat.overall.MPKI
      1.79            -1.2        0.56        perf-stat.overall.branch-miss-rate%
      1.62 ± 12%      -0.7        0.93 ± 10%  perf-stat.overall.cache-miss-rate%
      2.92 ±  6%    +227.4%       9.56        perf-stat.overall.cpi
     11542 ±  7%    +974.3%     124010 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.06 ± 23%      -0.1        0.01 ± 12%  perf-stat.overall.dTLB-load-miss-rate%
     36.56           +41.3       77.82 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      1760 ±  3%     +79.0%       3151 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
      0.34 ±  5%     -69.6%       0.10        perf-stat.overall.ipc
 1.379e+09 ±  8%    +127.2%  3.134e+09        perf-stat.ps.branch-instructions
  24660045 ±  7%     -28.7%   17594596        perf-stat.ps.branch-misses
   1678152 ±  2%     -38.5%    1031881 ±  2%  perf-stat.ps.cache-misses
    782993 ± 11%     -77.0%     180068 ±  5%  perf-stat.ps.context-switches
 1.937e+10 ±  7%    +560.4%  1.279e+11        perf-stat.ps.cpu-cycles
     15898 ±  9%     +22.9%      19547 ±  6%  perf-stat.ps.cpu-migrations
   1093700 ± 19%     -68.8%     340896 ± 10%  perf-stat.ps.dTLB-load-misses
 1.742e+09 ±  8%     +95.8%   3.41e+09 ±  2%  perf-stat.ps.dTLB-loads
     65581 ± 39%     -40.5%      39007 ±  9%  perf-stat.ps.dTLB-store-misses
 9.119e+08 ± 10%     -30.2%  6.364e+08 ±  3%  perf-stat.ps.dTLB-stores
   6576933 ± 10%     -81.6%    1208036 ±  5%  perf-stat.ps.iTLB-loads
 6.652e+09 ±  8%    +101.0%  1.337e+10        perf-stat.ps.instructions
    267948 ±  7%     -37.2%     168159 ±  3%  perf-stat.ps.node-loads
    223475 ±  8%     -21.3%     175847 ±  2%  perf-stat.ps.node-stores
 4.458e+11           +89.7%  8.456e+11        perf-stat.total.instructions
      0.00 ±223%  +55600.0%       0.19 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.01 ± 76%    +839.5%       0.06 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00        +36191.7%       0.73 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00 ±  8%  +17264.0%       0.72 ± 37%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 17%  +10940.6%       0.59 ±117%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 35%   +1925.0%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ± 20%  +16614.3%       0.39 ± 14%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +3762.5%       0.15 ± 40%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ± 50%    +213.0%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00         +4758.3%       0.10 ± 11%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 14%    +850.0%       0.03 ± 84%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 20%  +13977.3%       0.52 ± 33%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ± 10%   +1184.6%       0.06 ± 81%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ± 19%     -93.3%       0.00 ±223%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.00 ± 19%  +11040.0%       0.28 ± 22%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00 ± 10%   +7046.2%       0.31 ± 24%  perf-sched.sch_delay.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.00 ±  9%    +552.2%       0.02 ±102%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.00 ±  9%    +100.0%       0.01 ± 30%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ± 14%    +571.4%       0.02 ± 28%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ± 17%  +13523.1%       0.30 ± 28%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.01          +320.0%       0.02 ± 33%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 50%  +35767.6%       2.03 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +2.3e+05%       0.78 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.47 ±139%   +1516.2%       7.53 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00 ± 30%    +1e+05%       2.58 ± 20%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.01 ± 45%  +28441.8%       2.62 ± 39%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 15%  +13754.3%       0.81 ± 84%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.05 ± 42%   +9708.0%       4.89 ± 15%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 34%  +36008.0%       3.01 ± 27%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 18%  +17247.7%       1.27 ± 55%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.39 ±136%   +2779.1%      11.16 ± 30%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00 ± 73%    +173.7%       0.01 ± 40%  perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      2.03 ±  5%    +556.3%      13.30 ± 13%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 31%   +5304.7%       0.39 ±158%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 16%  +14850.0%       0.90 ± 44%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ± 18%  +19431.0%       0.94 ± 43%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 29%   +5383.0%       0.43 ± 95%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 67%     -93.5%       0.00 ±223%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.01 ± 13%  +41400.0%       2.35 ± 39%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 31%  +15031.8%       1.11 ± 35%  perf-sched.sch_delay.max.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.01 ± 17%    +350.0%       0.02 ± 94%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 10%   +7702.4%       0.53 ± 90%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    124.90 ±130%     -98.6%       1.69 ±128%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±111%  +44190.3%       2.29 ± 44%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.04 ± 12%   +2205.3%       0.94 ± 82%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 17%   +3561.5%       0.08 ± 12%  perf-sched.total_sch_delay.average.ms
      0.60 ±  4%    +137.3%       1.43 ±  2%  perf-sched.total_wait_and_delay.average.ms
   1555993 ±  3%     -62.7%     580398 ±  2%  perf-sched.total_wait_and_delay.count.ms
      0.60 ±  4%    +124.9%       1.35 ±  3%  perf-sched.total_wait_time.average.ms
      4.70 ± 66%    +284.8%      18.08 ± 44%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    799.89           -20.7%     634.47 ±  7%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.12           +51.9%       0.17 ± 19%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.36 ±  3%    +146.9%       0.89 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     26.35          +143.3%      64.11 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    369.62 ±  6%      +7.8%     398.37 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6.11 ±  6%     +12.4%       6.87 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
     81.79 ±  6%     -20.5%      65.05 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    121.06 ± 10%     +66.4%     201.44 ±  5%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     18.67 ± 28%    +546.4%     120.67 ± 49%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.67 ± 66%   +2940.0%      50.67 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     75350           -41.5%      44079 ±  2%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
   1476824 ±  3%     -71.1%     427269 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    599.33 ±  3%     -62.9%     222.17 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     58.17 ±  4%     +30.7%      76.00 ±  7%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1536 ± 11%     -38.7%     941.17 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.25 ± 59%   +4653.5%     296.94 ±107%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      2501 ± 44%     +40.8%       3523 ± 14%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     14.63 ± 65%     -83.5%       2.42 ±202%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.31 ±  2%     -39.6%       0.19 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.00 ±223%   +3033.3%       0.05 ± 64%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      4.70 ± 66%    +284.6%      18.07 ± 43%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.31 ±  3%     +36.2%       0.43 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.31 ±  3%     -40.9%       0.18 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±107%  +8.4e+06%     250.60 ±152%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    799.88           -20.8%     633.74 ±  7%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.24          +276.8%       0.91 ±  6%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.36 ±  3%    +121.4%       0.80 ±  4%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     26.35          +143.3%      64.10 ±  5%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    369.62 ±  6%      +7.8%     398.31 ±  5%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.32 ± 15%     -75.5%       0.08 ± 59%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.33 ±  3%    +326.7%       1.39 ± 14%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     81.79 ±  6%     -20.5%      65.02 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    120.97 ± 10%     +66.5%     201.42 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 99%  +1.6e+06%       7.75 ±219%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.35 ±  8%    +197.0%       1.04 ± 33%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.00 ±223%  +19500.0%       0.29 ± 73%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      6.25 ± 59%   +4653.3%     296.93 ±107%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.39 ±  5%   +2162.3%       8.88 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.34 ± 10%    +282.9%       1.31 ± 46%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.37 ±  6%    +255.4%       1.32 ± 46%  perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±101%  +9.6e+06%     334.29 ±141%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.72          +395.7%       3.55 ± 15%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      7.15 ± 65%  +13915.0%       1001        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.00           -13.6%       4.32 ±  8%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.37 ±  8%     -66.8%       0.12 ± 70%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.71 ±  2%    +562.9%       4.74 ± 18%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2501 ± 44%     +40.8%       3523 ± 14%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 14%  +2.1e+06%     168.01 ±221%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     58.44 ±  2%     -58.4        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     56.88           -56.9        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     56.88           -56.9        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     56.84           -56.8        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     53.06           -53.1        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     53.03           -53.0        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     51.71           -51.7        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     45.22           -45.2        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      9.56 ±  7%      -9.4        0.19 ±141%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.91 ±  8%      -5.9        0.00        perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.69 ±  7%      +0.1        1.82        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.37 ±  8%      +0.2        1.56        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      1.28 ±  8%      +0.2        1.52        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      0.00            +0.7        0.73 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      6.95 ± 10%     +13.0       19.97 ±  3%  perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.48 ± 11%     +13.4       19.91 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
      6.04 ± 11%     +13.8       19.84 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
     34.20 ±  4%     +17.5       51.74 ±  5%  perf-profile.calltrace.cycles-pp.read
     33.65 ±  4%     +17.9       51.58 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     33.59 ±  4%     +18.0       51.56 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     33.33 ±  4%     +18.2       51.51 ±  5%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     33.26 ±  4%     +18.2       51.47 ±  5%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     33.07 ±  4%     +18.3       51.36 ±  5%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.24 ±  7%     +21.2       29.46 ±  7%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.84 ± 11%     +23.3       29.11 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      4.75 ± 15%     +24.3       29.00 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      6.75 ±  4%     +41.4       48.16 ±  6%  perf-profile.calltrace.cycles-pp.write
      6.45 ±  3%     +41.5       47.91 ±  6%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.54 ±  3%     +41.5       48.05 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      6.36 ±  3%     +41.5       47.88 ±  6%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.51 ±  3%     +41.5       48.04 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.18 ±  3%     +41.6       47.79 ±  6%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.86 ±  5%     +43.3       45.18 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.64 ±  6%     +43.4       45.06 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      3.58           +43.6       47.14 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     58.44 ±  2%     -58.4        0.00        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     58.44 ±  2%     -58.4        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     58.41 ±  2%     -58.4        0.00        perf-profile.children.cycles-pp.do_idle
     56.88           -56.9        0.00        perf-profile.children.cycles-pp.start_secondary
     54.48           -54.5        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     53.11           -53.1        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     53.10           -53.1        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     45.22           -45.2        0.00        perf-profile.children.cycles-pp.intel_idle
     11.06 ±  6%     -10.6        0.51 ± 24%  perf-profile.children.cycles-pp.__mutex_lock
      6.98 ±  8%      -7.0        0.00        perf-profile.children.cycles-pp.intel_idle_irq
      6.16 ± 11%      -6.0        0.18 ± 31%  perf-profile.children.cycles-pp.osq_lock
      3.43 ±  6%      -2.8        0.60 ±  9%  perf-profile.children.cycles-pp.__schedule
      2.51            -2.4        0.09 ± 47%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      2.09 ±  4%      -1.5        0.57 ±  9%  perf-profile.children.cycles-pp.schedule
      1.72 ±  2%      -1.5        0.26 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.50 ±  3%      -1.0        0.50 ±  3%  perf-profile.children.cycles-pp.mutex_lock
      1.22 ±  3%      -0.9        0.35        perf-profile.children.cycles-pp.mutex_unlock
      0.90 ±  6%      -0.8        0.10 ± 10%  perf-profile.children.cycles-pp.dequeue_entity
      0.97 ±  6%      -0.8        0.21 ±  9%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.95 ±  9%      -0.7        0.30 ± 11%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.88 ±  9%      -0.6        0.25 ± 10%  perf-profile.children.cycles-pp.activate_task
      0.74 ±  9%      -0.6        0.13 ± 10%  perf-profile.children.cycles-pp.enqueue_entity
      0.83 ±  9%      -0.6        0.24 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.65 ±  3%      -0.6        0.07 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.78 ±  5%      -0.5        0.23 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.55 ±  2%      -0.5        0.06 ± 13%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.52 ±  2%      -0.4        0.08 ± 10%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.62 ±  5%      -0.4        0.22 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.61 ±  5%      -0.4        0.22 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.56 ±  5%      -0.4        0.19 ±  9%  perf-profile.children.cycles-pp.update_load_avg
      0.42 ±  8%      -0.3        0.07 ± 11%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.45 ±  9%      -0.3        0.13 ±  9%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.51 ±  5%      -0.3        0.19 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.36 ±  8%      -0.3        0.04 ± 71%  perf-profile.children.cycles-pp.prepare_task_switch
      0.42 ± 12%      -0.3        0.12 ± 10%  perf-profile.children.cycles-pp.select_task_rq
      0.39 ± 12%      -0.3        0.12 ± 10%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.35 ±  7%      -0.2        0.15 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.20 ±  9%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.set_next_entity
      0.32 ±  5%      -0.2        0.14 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.31 ±  5%      -0.2        0.14 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.19 ±  7%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.26 ±  5%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.20 ± 10%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.19 ±  7%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.27 ± 10%      -0.1        0.13 ±  9%  perf-profile.children.cycles-pp.update_curr
      0.17 ±  6%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.26 ±  5%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.22 ±  6%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.16 ±  8%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__entry_text_start
      0.12 ± 13%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.16 ± 10%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.reweight_entity
      0.15 ± 13%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.security_file_permission
      0.13 ± 12%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.10 ± 13%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__fdget_pos
      0.11 ±  9%      -0.1        0.05        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.20 ±  8%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.18 ± 10%      -0.1        0.13 ±  8%  perf-profile.children.cycles-pp._copy_to_iter
      0.15 ± 13%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.12 ± 12%      -0.0        0.08 ± 19%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.wake_affine
      1.69 ±  7%      +0.1        1.83        perf-profile.children.cycles-pp.__wake_up_common
      1.38 ±  8%      +0.2        1.56        perf-profile.children.cycles-pp.autoremove_wake_function
      1.34 ±  8%      +0.2        1.54        perf-profile.children.cycles-pp.try_to_wake_up
      6.96 ± 10%     +13.0       19.97 ±  3%  perf-profile.children.cycles-pp.finish_wait
     34.26 ±  4%     +17.5       51.76 ±  5%  perf-profile.children.cycles-pp.read
     33.33 ±  4%     +18.2       51.51 ±  5%  perf-profile.children.cycles-pp.ksys_read
     33.27 ±  4%     +18.2       51.47 ±  5%  perf-profile.children.cycles-pp.vfs_read
     33.09 ±  4%     +18.3       51.38 ±  5%  perf-profile.children.cycles-pp.pipe_read
      8.25 ±  7%     +21.2       29.48 ±  7%  perf-profile.children.cycles-pp.prepare_to_wait_event
      6.80 ±  4%     +41.4       48.19 ±  6%  perf-profile.children.cycles-pp.write
      6.45 ±  3%     +41.5       47.92 ±  6%  perf-profile.children.cycles-pp.ksys_write
      6.37 ±  3%     +41.5       47.89 ±  6%  perf-profile.children.cycles-pp.vfs_write
      6.18 ±  3%     +41.6       47.79 ±  6%  perf-profile.children.cycles-pp.pipe_write
      3.58           +43.6       47.16 ±  6%  perf-profile.children.cycles-pp.__wake_up_common_lock
     40.36 ±  3%     +59.3       99.69        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.27 ±  3%     +59.4       99.66        perf-profile.children.cycles-pp.do_syscall_64
     14.85 ± 11%     +79.1       93.91        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     14.51 ±  9%     +80.4       94.95        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     45.22           -45.2        0.00        perf-profile.self.cycles-pp.intel_idle
      6.68 ±  8%      -6.7        0.00        perf-profile.self.cycles-pp.intel_idle_irq
      6.15 ± 11%      -6.0        0.18 ± 32%  perf-profile.self.cycles-pp.osq_lock
      2.50            -2.4        0.09 ± 49%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      1.99 ±  3%      -1.8        0.21 ± 11%  perf-profile.self.cycles-pp.__mutex_lock
      1.82 ±  3%      -1.6        0.23 ±  5%  perf-profile.self.cycles-pp.prepare_to_wait_event
      2.08 ±  6%      -1.0        1.04 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.46 ±  2%      -1.0        0.44 ±  4%  perf-profile.self.cycles-pp.mutex_lock
      1.07 ± 34%      -0.9        0.18 ± 29%  perf-profile.self.cycles-pp.pipe_read
      1.21 ±  3%      -0.9        0.35        perf-profile.self.cycles-pp.mutex_unlock
      0.64 ±  2%      -0.6        0.06 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock
      0.55 ±  2%      -0.5        0.06 ± 13%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.51 ±  2%      -0.4        0.08 ±  8%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.41 ±  8%      -0.3        0.07 ± 13%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.32 ±  8%      -0.3        0.05 ± 45%  perf-profile.self.cycles-pp.__schedule
      0.27 ± 37%      -0.2        0.08 ± 36%  perf-profile.self.cycles-pp.pipe_write
      0.19 ±  9%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.16 ±  6%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.19 ±  3%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.update_load_avg
      0.12 ± 13%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.10 ± 19%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.read
      0.11 ± 12%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.14 ±  9%      -0.1        0.09 ±  8%  perf-profile.self.cycles-pp.update_curr
      0.09 ± 14%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.vfs_read
      0.10 ±  9%      -0.1        0.05        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.08 ± 12%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.vfs_write
      0.05 ± 45%      +0.2        0.29        perf-profile.self.cycles-pp.try_to_wake_up
     14.84 ± 11%     +79.1       93.91        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pipe/gcc-12/performance/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/pipeherd/stress-ng/60s

commit: 
  dfaabf916b ("fs/pipe: remove unnecessary spinlock from pipe_write()")
  478dbf1217 ("fs/pipe: use spinlock in pipe_read() only if there is a watch_queue")

dfaabf916b1ca83c 478dbf12176700f28d836dd03ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2706 ±  2%     -67.7%     874.90 ±  9%  uptime.idle
  1.99e+09 ±  2%     -91.3%  1.735e+08 ± 44%  cpuidle..time
  27596300 ±  4%     -99.1%     243213 ± 33%  cpuidle..usage
     87.25           -80.7        6.54 ± 50%  mpstat.cpu.all.idle%
      0.02 ± 12%      -0.0        0.01 ± 86%  mpstat.cpu.all.soft%
     11.25 ± 10%     +80.6       91.89 ±  3%  mpstat.cpu.all.sys%
     87.49           -89.4%       9.28 ± 33%  vmstat.cpu.id
     11.51 ± 10%    +681.0%      89.93 ±  3%  vmstat.cpu.sy
   3810602           -14.8%    3247858        vmstat.memory.cache
      4.93 ±  7%   +1711.7%      89.39 ±  3%  vmstat.procs.r
    787528 ±  4%     -77.6%     176046 ±  6%  vmstat.system.cs
     58145           +56.4%      90930 ±  2%  vmstat.system.in
      1.00           -73.3%       0.27 ± 16%  stress-ng.pipeherd.context_switches_per_bogo_op
    413282 ±  4%     -55.8%     182721 ±  6%  stress-ng.pipeherd.context_switches_per_sec
  24783439 ±  4%     +67.1%   41421976 ±  9%  stress-ng.pipeherd.ops
    412974 ±  4%     +67.1%     690219 ±  9%  stress-ng.pipeherd.ops_per_sec
     12734 ± 10%  +17284.8%    2213931 ±  2%  stress-ng.time.involuntary_context_switches
    419.00 ±  8%    +720.2%       3436        stress-ng.time.percent_of_cpu_this_job_got
    256.78 ±  9%    +728.5%       2127        stress-ng.time.system_time
  24784402 ±  4%     -64.7%    8749587 ±  8%  stress-ng.time.voluntary_context_switches
    832100 ±  4%     -55.9%     367365 ±  4%  meminfo.Active
    831955 ±  4%     -55.9%     367209 ±  4%  meminfo.Active(anon)
   3725457           -15.0%    3166933        meminfo.Cached
   2407415           -23.8%    1835476        meminfo.Committed_AS
    450884           -21.8%     352604        meminfo.Inactive
    450704           -21.8%     352440        meminfo.Inactive(anon)
    118763           -39.0%      72428 ±  2%  meminfo.Mapped
   4501461           -12.8%    3927452        meminfo.Memused
    974916 ±  4%     -57.3%     416402 ±  3%  meminfo.Shmem
   4668198           -12.6%    4078843        meminfo.max_used_kB
    585.00 ±  6%    +502.4%       3524 ±  3%  turbostat.Avg_MHz
     15.46 ±  6%     +77.4       92.83 ±  3%  turbostat.Busy%
   4234423 ± 11%     -99.8%       8757 ± 13%  turbostat.C1
      9.09 ±  9%      -9.1        0.02        turbostat.C1%
  23137625 ±  2%     -99.7%      60924 ±  2%  turbostat.C1E
     70.26           -70.0        0.21 ±  3%  turbostat.C1E%
     83.54           -93.1%       5.76 ± 25%  turbostat.CPU%c1
      0.12 ±  4%     -73.9%       0.03        turbostat.IPC
   3797086           +58.8%    6031215 ±  2%  turbostat.IRQ
     70205 ±  2%     -94.4%       3916 ± 17%  turbostat.POLL
      0.04 ± 10%      -0.0        0.00        turbostat.POLL%
     96.94           +47.9%     143.36 ±  2%  turbostat.PkgWatt
    207990 ±  4%     -55.9%      91807 ±  4%  proc-vmstat.nr_active_anon
    931391           -15.0%     791754        proc-vmstat.nr_file_pages
    112697           -21.8%      88124        proc-vmstat.nr_inactive_anon
     29706           -39.0%      18121 ±  2%  proc-vmstat.nr_mapped
    243750 ±  4%     -57.3%     104115 ±  3%  proc-vmstat.nr_shmem
     19827            -2.0%      19427        proc-vmstat.nr_slab_reclaimable
    207990 ±  4%     -55.9%      91807 ±  4%  proc-vmstat.nr_zone_active_anon
    112697           -21.8%      88124        proc-vmstat.nr_zone_inactive_anon
    592754 ±  2%     -33.9%     391886        proc-vmstat.numa_hit
    590194 ±  2%     -32.8%     396447 ±  3%  proc-vmstat.numa_local
    311548 ±  3%     -54.3%     142271 ±  2%  proc-vmstat.pgactivate
    621508 ±  2%     -31.9%     423150        proc-vmstat.pgalloc_normal
    272471            -2.9%     264503        proc-vmstat.pgfault
     21335 ± 12%   +4675.1%    1018778        sched_debug.cfs_rq:/.avg_vruntime.avg
     44329 ± 12%   +2339.0%    1081194 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
     16832 ± 14%   +5838.5%     999612        sched_debug.cfs_rq:/.avg_vruntime.min
      6139 ±  6%    +181.1%      17255 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.29 ± 12%    +477.4%       1.66 ±  2%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.17 ± 20%    +142.9%       2.83 ± 13%  sched_debug.cfs_rq:/.h_nr_running.max
      0.45 ±  8%     +30.5%       0.58 ±  4%  sched_debug.cfs_rq:/.h_nr_running.stddev
     79.99 ± 29%     +51.1%     120.89 ± 13%  sched_debug.cfs_rq:/.load_avg.avg
      1.08 ± 62%    +776.9%       9.50 ±  8%  sched_debug.cfs_rq:/.load_avg.min
     21335 ± 12%   +4675.1%    1018778        sched_debug.cfs_rq:/.min_vruntime.avg
     44329 ± 12%   +2339.0%    1081194 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
     16832 ± 14%   +5838.5%     999612        sched_debug.cfs_rq:/.min_vruntime.min
      6139 ±  6%    +181.1%      17255 ± 14%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.29 ± 12%    +140.0%       0.69        sched_debug.cfs_rq:/.nr_running.avg
      0.45 ±  8%     -44.9%       0.25 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
    380.03 ±  6%    +363.6%       1761 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      1172 ± 17%    +148.7%       2914 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
     16.92 ± 39%   +3556.7%     618.58 ± 40%  sched_debug.cfs_rq:/.runnable_avg.min
    255.57 ± 13%     +97.7%     505.25 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    377.64 ±  6%    +121.6%     836.86        sched_debug.cfs_rq:/.util_avg.avg
     16.50 ± 41%   +1693.4%     295.92 ± 18%  sched_debug.cfs_rq:/.util_avg.min
     29.99 ± 31%   +1542.6%     492.56 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    408.67 ± 23%    +149.2%       1018 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.max
     93.96 ± 26%    +109.6%     196.95 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    238216 ±  5%     -10.3%     213762 ±  4%  sched_debug.cpu.avg_idle.avg
    605848 ±  6%     -14.9%     515585        sched_debug.cpu.avg_idle.max
     31407 ± 65%     -76.8%       7295 ± 19%  sched_debug.cpu.avg_idle.min
      0.74 ±  3%    +173.1%       2.02 ± 13%  sched_debug.cpu.clock.stddev
    929.06 ± 15%    +161.3%       2427        sched_debug.cpu.curr->pid.avg
      1488 ±  5%     -44.8%     821.94 ±  8%  sched_debug.cpu.curr->pid.stddev
      0.30 ± 10%    +454.3%       1.66        sched_debug.cpu.nr_running.avg
      1.17 ± 20%    +142.9%       2.83 ± 13%  sched_debug.cpu.nr_running.max
      0.46 ±  6%     +26.4%       0.58 ±  5%  sched_debug.cpu.nr_running.stddev
    684980 ±  4%     -76.7%     159497 ±  5%  sched_debug.cpu.nr_switches.avg
    759516 ±  4%     -74.0%     197100 ±  3%  sched_debug.cpu.nr_switches.max
    624974 ±  3%     -77.8%     139035 ±  8%  sched_debug.cpu.nr_switches.min
     28080 ± 15%     -46.3%      15076 ± 17%  sched_debug.cpu.nr_switches.stddev
      5.19 ±  2%     +13.6%       5.90 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
  1.57e+09          +108.0%  3.265e+09 ±  3%  perf-stat.i.branch-instructions
      2.04 ±  8%      -1.1        0.91 ± 37%  perf-stat.i.branch-miss-rate%
  31772550 ±  4%     -24.2%   24086374 ±  3%  perf-stat.i.branch-misses
   1817847 ±  2%     -33.0%    1217441 ±  3%  perf-stat.i.cache-misses
    818713 ±  4%     -77.5%     183823 ±  6%  perf-stat.i.context-switches
      3.14 ±  5%    +195.4%       9.28        perf-stat.i.cpi
 2.142e+10 ±  6%    +503.3%  1.292e+11 ±  3%  perf-stat.i.cpu-cycles
    300745 ± 10%    +488.2%    1769110 ±  5%  perf-stat.i.cycles-between-cache-misses
   1033250 ±  8%     -65.9%     352633 ± 11%  perf-stat.i.dTLB-load-misses
 1.947e+09           +81.8%  3.538e+09 ±  3%  perf-stat.i.dTLB-loads
     54076 ± 20%     -27.8%      39051 ± 12%  perf-stat.i.dTLB-store-misses
 9.853e+08 ±  3%     -32.0%  6.703e+08 ±  4%  perf-stat.i.dTLB-stores
     36.72 ±  2%     +40.3       77.01 ±  2%  perf-stat.i.iTLB-load-miss-rate%
   6882922 ±  3%     -82.0%    1236826 ±  6%  perf-stat.i.iTLB-loads
 7.581e+09           +84.8%  1.401e+10 ±  3%  perf-stat.i.instructions
      2265 ±  4%     +55.9%       3531 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.37 ±  5%     -60.4%       0.15        perf-stat.i.ipc
      0.60 ±  6%    +503.3%       3.59 ±  3%  perf-stat.i.metric.GHz
    254.50 ±  8%     -67.0%      84.10 ± 50%  perf-stat.i.metric.K/sec
    127.96           +64.5%     210.49 ±  3%  perf-stat.i.metric.M/sec
      2836            -5.3%       2686        perf-stat.i.minor-faults
    284823 ±  3%     -40.3%     170117 ±  3%  perf-stat.i.node-loads
    234762 ±  2%     -24.6%     176899 ±  3%  perf-stat.i.node-stores
      2836            -5.3%       2686        perf-stat.i.page-faults
      0.24 ±  2%     -63.7%       0.09 ±  5%  perf-stat.overall.MPKI
      2.02 ±  2%      -1.3        0.74        perf-stat.overall.branch-miss-rate%
      1.72 ±  7%      -0.6        1.15 ±  4%  perf-stat.overall.cache-miss-rate%
      2.83 ±  6%    +226.5%       9.23        perf-stat.overall.cpi
     11798 ±  8%    +801.3%     106347 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.05 ±  8%      -0.0        0.01 ± 13%  perf-stat.overall.dTLB-load-miss-rate%
     36.64           +41.1       77.72 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      1908 ±  4%     +69.9%       3242 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
      0.36 ±  6%     -69.5%       0.11        perf-stat.overall.ipc
 1.545e+09          +108.0%  3.214e+09 ±  3%  perf-stat.ps.branch-instructions
  31282752 ±  4%     -24.3%   23695577 ±  3%  perf-stat.ps.branch-misses
   1790563 ±  2%     -33.1%    1197953 ±  3%  perf-stat.ps.cache-misses
    805736 ±  4%     -77.5%     180928 ±  6%  perf-stat.ps.context-switches
 2.108e+10 ±  6%    +503.4%  1.272e+11 ±  3%  perf-stat.ps.cpu-cycles
   1017150 ±  8%     -65.9%     347336 ± 11%  perf-stat.ps.dTLB-load-misses
 1.916e+09           +81.7%  3.483e+09 ±  3%  perf-stat.ps.dTLB-loads
     53246 ± 20%     -27.8%      38432 ± 12%  perf-stat.ps.dTLB-store-misses
 9.699e+08 ±  3%     -32.0%  6.598e+08 ±  4%  perf-stat.ps.dTLB-stores
   6773860 ±  3%     -82.0%    1217329 ±  6%  perf-stat.ps.iTLB-loads
 7.462e+09           +84.8%  1.379e+10 ±  3%  perf-stat.ps.instructions
      2792            -5.3%       2645        perf-stat.ps.minor-faults
    280640 ±  3%     -40.3%     167446 ±  3%  perf-stat.ps.node-loads
    231142 ±  2%     -24.5%     174587 ±  3%  perf-stat.ps.node-stores
      2792            -5.3%       2645        perf-stat.ps.page-faults
 4.745e+11           +85.6%  8.804e+11        perf-stat.total.instructions
      0.00         +1977.8%       0.06 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00        +28100.0%       0.56 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00 ± 20%  +17416.7%       0.70 ± 47%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ± 20%   +1345.5%       0.03 ±  3%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ± 17%  +19446.2%       0.42 ± 26%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +3870.8%       0.16 ± 30%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ± 38%   +1175.0%       0.05 ±114%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ± 43%    +140.0%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00         +4808.3%       0.10 ±  9%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 14%    +423.8%       0.02 ± 22%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 17%  +25573.9%       0.98 ± 50%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ± 15%    +425.0%       0.02 ± 67%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.00 ± 17%  +11250.0%       0.30 ± 13%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00 ±  9%    +113.0%       0.01 ± 25%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ±  9%    +400.0%       0.02 ± 31%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 72%   +1090.2%       0.10 ± 74%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ± 20%  +13845.5%       0.26 ± 41%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.00 ±  7%    +203.4%       0.01 ± 22%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±  7%  +46565.5%       2.26 ± 57%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.02 ± 56%  +52891.7%      10.60 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00 ± 17%  +1.1e+05%       2.31 ± 48%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ± 22%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.01 ± 28%  +30500.0%       2.14 ± 30%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.10 ±112%   +4770.8%       4.83 ± 22%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 55%  +31457.9%       3.00 ± 18%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 21%  +17328.6%       1.42 ± 53%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ± 38%   +2023.9%       0.49 ±132%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.76 ± 74%    +876.1%       7.44 ± 27%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.23 ±  5%    +472.0%      12.77 ± 23%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 13%   +1233.3%       0.07 ± 41%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 19%  +20384.6%       1.33 ± 43%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ± 15%  +40464.3%       1.89 ± 66%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 11%  +46393.3%       2.32 ± 33%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 11%    +332.4%       0.03 ± 73%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 16%   +4625.0%       0.32 ±137%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     71.65 ± 93%     -95.2%       3.47 ±115%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 54%   +1608.3%       0.17 ± 86%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ± 73%  +28622.6%       1.48 ± 26%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.04 ± 29%    +857.3%       0.38 ± 77%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00         +3916.7%       0.08 ± 11%  perf-sched.total_sch_delay.average.ms
      0.60 ±  4%    +126.9%       1.36 ±  2%  perf-sched.total_wait_and_delay.average.ms
   1523483 ±  4%     -61.7%     583504 ±  2%  perf-sched.total_wait_and_delay.count.ms
      0.60 ±  4%    +114.4%       1.28 ±  3%  perf-sched.total_wait_time.average.ms
     14.36 ± 27%     -67.7%       4.63 ± 39%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.11 ±  4%     +61.2%       0.18 ± 11%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    281.24 ±  8%     -17.3%     232.69 ±  7%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.37 ±  4%    +139.5%       0.88 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.03 ±  3%     -23.7%       3.07 ±  3%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     26.68 ±  4%    +153.4%      67.60 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     91.66 ±  3%     -26.2%      67.62 ± 14%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    119.27 ± 11%     +62.9%     194.31 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    576.50 ±  4%     +13.8%     656.21        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     20.00 ± 36%    +775.0%     175.00 ± 29%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      2.33 ±112%   +2228.6%      54.33 ± 25%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     75286           -41.4%      44124 ±  2%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    138.83 ±141%  +47169.0%      65625 ±  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
   1444349 ±  4%     -70.3%     429367 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    586.17 ±  2%     -62.8%     218.00 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     52.17 ±  3%     +42.5%      74.33 ± 14%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1591 ± 11%     -40.1%     953.33 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    222.50 ±  4%     -12.3%     195.17 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    130.67 ± 51%    +101.9%     263.87 ± 25%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    333.50 ±141%    +159.4%     865.14 ± 35%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.00           -15.1%       4.25 ±  8%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.32 ±  8%     -43.9%       0.18 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.00 ±143%   +2137.5%       0.06 ± 94%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.00 ±223%  +33440.0%       0.56 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     14.36 ± 27%     -67.7%       4.63 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.32 ±  3%     +32.6%       0.43 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.31 ±  4%     -29.3%       0.22 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.30 ±  6%     -80.9%       0.06 ± 99%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.11 ±  4%     +39.5%       0.16 ± 13%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    281.24 ±  8%     -17.4%     232.27 ±  7%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.24         +1480.4%       3.76 ±176%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2.38 ±128%     -87.4%       0.30 ±  7%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.36 ±  4%    +114.1%       0.78 ±  3%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.02 ±  3%     -24.1%       3.05 ±  3%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     26.68 ±  4%    +153.3%      67.59 ±  3%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.32 ±  8%     -72.3%       0.09 ± 52%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.33          +303.9%       1.32 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     91.66 ±  3%     -26.2%      67.60 ± 14%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    119.22 ± 11%     +63.0%     194.28 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±100%  +15266.7%       0.15 ± 31%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    576.50 ±  4%     +13.8%     656.19        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±143%  +12831.2%       0.34 ± 97%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.00 ±223%  +92390.0%       1.54 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
    130.67 ± 51%    +101.9%     263.87 ± 25%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.46 ± 24%   +1911.2%       9.23 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.37 ±  6%    +329.9%       1.59 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.39 ±  8%    +311.1%       1.60 ± 35%  perf-sched.wait_time.max.ms.__cond_resched.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±223%  +28933.3%       0.29 ±204%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.36 ±  5%     -80.7%       0.07 ± 96%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.72 ±  2%  +23400.6%     169.60 ±219%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.14 ±149%  +1.2e+05%     177.13 ±209%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      5.00           -15.7%       4.21 ±  8%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.42          +342.4%       1.84 ± 62%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_read
      0.77 ±  9%    +441.8%       4.17 ± 15%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 85%  +16142.9%       1.52 ± 44%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     57.80 ±  2%     -57.8        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     56.12           -56.1        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     56.11           -56.1        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     56.08           -56.1        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     52.62           -52.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     52.42           -52.4        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     51.15           -51.2        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     45.20           -45.2        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      9.98 ±  9%      -9.7        0.27 ±100%  perf-profile.calltrace.cycles-pp.__mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.61 ± 15%      -5.6        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.pipe_read.vfs_read.ksys_read
      5.52 ± 11%      -5.5        0.00        perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.96 ±  5%      -1.7        0.27 ±100%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.92 ±  5%      -1.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      1.60 ±  7%      +0.2        1.82        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.30 ±  8%      +0.2        1.55        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      1.22 ±  8%      +0.3        1.51        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      0.00            +0.7        0.72 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      7.26 ±  9%     +12.8       20.03 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.77 ± 10%     +13.2       19.97 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read.ksys_read
      6.33 ± 11%     +13.6       19.91 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.pipe_read.vfs_read
     34.92 ±  5%     +17.2       52.16 ±  5%  perf-profile.calltrace.cycles-pp.read
     34.40 ±  5%     +17.6       52.01 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     34.33 ±  5%     +17.7       52.00 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     34.09 ±  5%     +17.8       51.94 ±  5%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     34.02 ±  5%     +17.9       51.90 ±  5%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     33.84 ±  5%     +18.0       51.80 ±  5%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.40 ±  7%     +21.4       29.79 ±  6%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.03 ± 11%     +23.4       29.44 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      5.01 ± 15%     +24.3       29.32 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read
      6.67 ±  4%     +41.1       47.73 ±  6%  perf-profile.calltrace.cycles-pp.write
      6.38 ±  4%     +41.1       47.49 ±  6%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.47 ±  4%     +41.2       47.63 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      6.30 ±  4%     +41.2       47.46 ±  6%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.44 ±  4%     +41.2       47.61 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.12 ±  4%     +41.2       47.37 ±  6%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.92 ±  6%     +42.8       44.76 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      1.68 ±  8%     +42.9       44.63 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.vfs_write
      3.55 ±  2%     +43.2       46.72 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     57.80 ±  2%     -57.8        0.00        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     57.80 ±  2%     -57.8        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     57.77 ±  2%     -57.8        0.00        perf-profile.children.cycles-pp.do_idle
     56.12           -56.1        0.00        perf-profile.children.cycles-pp.start_secondary
     53.99           -54.0        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     52.67           -52.7        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     52.66           -52.7        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     45.20           -45.2        0.00        perf-profile.children.cycles-pp.intel_idle
     11.53 ±  7%     -11.0        0.54 ± 23%  perf-profile.children.cycles-pp.__mutex_lock
      6.59 ± 11%      -6.6        0.00        perf-profile.children.cycles-pp.intel_idle_irq
      6.58 ± 12%      -6.4        0.20 ± 30%  perf-profile.children.cycles-pp.osq_lock
      3.36 ±  7%      -2.8        0.59 ±  6%  perf-profile.children.cycles-pp.__schedule
      2.53 ±  2%      -2.4        0.09 ± 44%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      2.05 ±  5%      -1.5        0.56 ±  7%  perf-profile.children.cycles-pp.schedule
      1.72 ±  4%      -1.5        0.26 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.52 ±  2%      -1.0        0.50 ±  5%  perf-profile.children.cycles-pp.mutex_lock
      1.21 ±  4%      -0.8        0.36        perf-profile.children.cycles-pp.mutex_unlock
      0.86 ±  7%      -0.8        0.11 ±  9%  perf-profile.children.cycles-pp.dequeue_entity
      0.93 ±  7%      -0.7        0.21 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.89 ±  9%      -0.6        0.31 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.65 ±  4%      -0.6        0.07 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.83 ±  9%      -0.6        0.26 ± 10%  perf-profile.children.cycles-pp.activate_task
      0.79 ±  6%      -0.6        0.24 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.69 ± 10%      -0.6        0.14 ± 12%  perf-profile.children.cycles-pp.enqueue_entity
      0.77 ±  9%      -0.5        0.25 ±  9%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.55 ±  3%      -0.5        0.05 ±  8%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.54 ±  5%      -0.5        0.08 ±  8%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.62 ±  7%      -0.4        0.22 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.61 ±  6%      -0.4        0.22 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.54 ±  8%      -0.3        0.19 ±  8%  perf-profile.children.cycles-pp.update_load_avg
      0.40 ±  9%      -0.3        0.06 ± 14%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.46 ± 11%      -0.3        0.13 ±  8%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.50 ±  7%      -0.3        0.19 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.35 ± 10%      -0.3        0.05 ±  8%  perf-profile.children.cycles-pp.prepare_task_switch
      0.41 ±  8%      -0.3        0.12 ±  7%  perf-profile.children.cycles-pp.select_task_rq
      0.38 ±  8%      -0.3        0.12 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.36 ±  9%      -0.2        0.15 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
      0.32 ±  8%      -0.2        0.15 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.32 ±  7%      -0.2        0.15 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.20 ± 18%      -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.set_next_entity
      0.27 ±  8%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.20 ±  9%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.17 ± 11%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.20 ±  8%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.26 ±  8%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.update_curr
      0.18 ±  8%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.25 ±  8%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.21 ±  9%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.15 ± 12%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__entry_text_start
      0.10 ± 15%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.__fdget_pos
      0.14 ± 15%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.security_file_permission
      0.14 ± 11%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.reweight_entity
      0.12 ± 15%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.19 ± 11%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.09 ±  9%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ± 12%      -0.1        0.13 ±  8%  perf-profile.children.cycles-pp._copy_to_iter
      0.16 ± 14%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.copyout
      0.15 ± 11%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.wake_affine
      1.60 ±  7%      +0.2        1.82        perf-profile.children.cycles-pp.__wake_up_common
      1.31 ±  8%      +0.2        1.55        perf-profile.children.cycles-pp.autoremove_wake_function
      1.27 ±  7%      +0.3        1.53        perf-profile.children.cycles-pp.try_to_wake_up
      7.26 ±  9%     +12.8       20.04 ±  4%  perf-profile.children.cycles-pp.finish_wait
     34.96 ±  5%     +17.2       52.19 ±  5%  perf-profile.children.cycles-pp.read
     34.10 ±  5%     +17.8       51.94 ±  5%  perf-profile.children.cycles-pp.ksys_read
     34.02 ±  5%     +17.9       51.90 ±  5%  perf-profile.children.cycles-pp.vfs_read
     33.86 ±  5%     +17.9       51.81 ±  5%  perf-profile.children.cycles-pp.pipe_read
      8.40 ±  7%     +21.4       29.81 ±  6%  perf-profile.children.cycles-pp.prepare_to_wait_event
      6.72 ±  4%     +41.0       47.76 ±  6%  perf-profile.children.cycles-pp.write
      6.39 ±  4%     +41.1       47.50 ±  6%  perf-profile.children.cycles-pp.ksys_write
      6.31 ±  4%     +41.2       47.47 ±  6%  perf-profile.children.cycles-pp.vfs_write
      6.12 ±  4%     +41.2       47.38 ±  6%  perf-profile.children.cycles-pp.pipe_write
      3.56 ±  2%     +43.2       46.74 ±  6%  perf-profile.children.cycles-pp.__wake_up_common_lock
     41.06 ±  3%     +58.6       99.69        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.96 ±  3%     +58.7       99.66        perf-profile.children.cycles-pp.do_syscall_64
     15.52 ± 11%     +78.4       93.87        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     15.04 ± 10%     +79.9       94.90        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     45.20           -45.2        0.00        perf-profile.self.cycles-pp.intel_idle
      6.56 ± 13%      -6.4        0.20 ± 30%  perf-profile.self.cycles-pp.osq_lock
      6.29 ± 11%      -6.3        0.00        perf-profile.self.cycles-pp.intel_idle_irq
      2.52 ±  2%      -2.4        0.09 ± 44%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      2.03 ±  2%      -1.8        0.22 ± 13%  perf-profile.self.cycles-pp.__mutex_lock
      1.79 ±  4%      -1.6        0.24 ±  8%  perf-profile.self.cycles-pp.prepare_to_wait_event
      1.49 ±  2%      -1.0        0.44 ±  5%  perf-profile.self.cycles-pp.mutex_lock
      2.01 ±  6%      -1.0        1.04 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.21 ±  3%      -0.8        0.36 ±  2%  perf-profile.self.cycles-pp.mutex_unlock
      0.96 ± 37%      -0.8        0.19 ± 29%  perf-profile.self.cycles-pp.pipe_read
      0.64 ±  5%      -0.6        0.06 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock
      0.55 ±  3%      -0.5        0.05 ±  8%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.53 ±  5%      -0.5        0.08 ±  9%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.40 ±  8%      -0.3        0.06 ± 14%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.31 ±  8%      -0.3        0.06 ±  9%  perf-profile.self.cycles-pp.__schedule
      0.22 ± 46%      -0.1        0.07 ± 32%  perf-profile.self.cycles-pp.pipe_write
      0.18 ±  8%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.18 ± 11%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.update_load_avg
      0.09 ±  9%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.11 ± 12%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.08 ± 17%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.vfs_read
      0.07 ±  9%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.vfs_write
      0.13 ±  7%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.update_curr
      0.05 ±  8%      +0.2        0.28 ±  4%  perf-profile.self.cycles-pp.try_to_wake_up
     15.51 ± 11%     +78.4       93.87        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


