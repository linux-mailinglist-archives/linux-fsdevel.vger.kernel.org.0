Return-Path: <linux-fsdevel+bounces-3006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B38A7EEB30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 03:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D275F2811D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 02:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973314693;
	Fri, 17 Nov 2023 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMhsNMvW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DCAD4D;
	Thu, 16 Nov 2023 18:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700188994; x=1731724994;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=vL8nc51E19QGfXuvAjJYls7Eol0G9xPMhW/h7nRnxJU=;
  b=CMhsNMvWp8d6wMKvFr+Comn65NkR8qo1bFL2VWYRrZ6b9LQxuZKrNvcG
   4gPsduYc8kK4pZTqrB9Jc0jEyfjhfZ6aBcFJVAr95eVKx4gLHeOciFaMQ
   hv37SM1XLd5mdIBqgbJV529/DfZWyzcqzmgulbrycDhmYH1id8EkK1/OD
   e63KUP5xuS+JuFdrg6dyLnyAXaPJUQhKYBMAoLzi94adpmvsxI5xd56wO
   +GFR3pU1C9XkAYSMF+gcceI+67FWLEL+cLaezso8c4lYiFnQlrK5T6zhb
   wG9zUb2VPUwC8cvUgjJVZER8S8An4tQtz1TXzlJ8syO6D2ZR5ndfFboAB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="395149530"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="395149530"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 18:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="889106655"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="889106655"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 18:43:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 18:43:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 18:43:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 18:43:06 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 18:43:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4eiQ5Lv8d4fpa6vHtUDu+EpQ0bpd9SQgidxWWAX0CYNgIGnVHb9FVzFzf/nXQlrxwC/l8h1+79sru53jFZ0NZM0sNXJwnXgjopHHyUzvtRpCxNkbMr8FTSO3S+VvEuCKsLt4SnB5GMfrDjitYOe7A9RffKI806Cc5hu0gA8q2714P6ZC1grzG1dXILdVUL/HpufY871Ny5glP5kbgBKjs3Uzcc8s2wnMr1Wf89WI7JQuPkc3no1kWxu0CUVmCOtxVdETUMXsjQxTVBy+S4/3I4FnWQWN+XsngPy8UaHxttOmF+aIacZouq5WuOIlSgDmwgGqANxmgldammJ+JGW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3Hq8OjwjyfBzbGiUsCVwshEW1EsB0hI8w5AF/sFoGM=;
 b=KrG6tZY+VvYeO8veIRry5eQg4pOEFfEgNmpqB7+oV3vwsG+0Uf+cvLYTldsvqbNxz4AJ2EHj6KhbD6BtmxI4K/OHTM5ei7bKRuXHpzi6iBKJy2hkxKPhpXbI1WJFsNUISgR9CIKWQRiaLIj7mKcKkUfb+Bq2YT73wiC5/OAJIsrz4XrtAVUS8hRKWsNHxRG7ERcYZyU0pJWJm3haZ8429ub2AkGRdSTGaNwMWiHPisQFxYNQkq1siJziIPRi2zdkaAY26jO9Hj/pu6RjlcgX2x0tPiQrqcTOCkXeVAZl2Jaljt4obkyRrPE9RAfL7gqXxtCmcM+9as0eyFs4QA+c8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB6669.namprd11.prod.outlook.com (2603:10b6:a03:449::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 02:43:04 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 02:43:03 +0000
Date: Fri, 17 Nov 2023 10:42:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sourav Panda <souravpanda@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <corbet@lwn.net>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <rppt@kernel.org>, <david@redhat.com>,
	<rdunlap@infradead.org>, <chenlinxuan@uniontech.com>,
	<yang.yang29@zte.com.cn>, <souravpanda@google.com>,
	<tomas.mudrunka@gmail.com>, <bhelgaas@google.com>, <ivan@cloudflare.com>,
	<yosryahmed@google.com>, <hannes@cmpxchg.org>, <shakeelb@google.com>,
	<kirill.shutemov@linux.intel.com>, <wangkefeng.wang@huawei.com>,
	<adobriyan@gmail.com>, <vbabka@suse.cz>, <Liam.Howlett@oracle.com>,
	<surenb@google.com>, <linux-doc@vger.kernel.org>, <willy@infradead.org>,
	<weixugc@google.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
Message-ID: <202311171013.fb3e52d3-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231101230816.1459373-2-souravpanda@google.com>
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ea009c-6bdf-4702-2e52-08dbe716ebaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRTABPd+T0rvVEMzUlh8YPORok0cbRlxEK6uVMBnS1xO0Gaj8J2OzoSwX8QmnHsljTK36ltzQfHGyrRjY43NwagkNnQnlzxaIxEns+M0kTXlxy5xDD0uGSTpDur2PDYPjA9QCvXgHtnUjBK6bdD9fJ839fW7Ts3mBTzh2rgShdJWWKoXbw9Cm9q3gTmqqoR4EVnehxP8ahB1zkTlxA0oklRwSsh3ElVBC0YsxeF5Hsf+nrV4Kl18zVYcthTtsZJl69bT6WkO6T4sxCun61HUzGd3gdASgaN2o3r4mX/kxWg02oKV4ZPyY3Vgx9NA3JWPWJqO9vOe9Jj+setaQqZmxk4cNeAfe2ZfmJFGG21EjKCG4KJ+7VaxD9tpBap+X7p9I7CHV3VQQHCtByWktirNGy8ECw60cTbsvJB8M0V7eg2PUjEfFQP1zOeBFj7tVrhLcP7L30oQiG4kxTVkPi2t2+rBxP0oQP4A2ZyN7Rmx09qpqYCi9wCMwGaohiAdzt3RJ8Mhqp4k/UH8/YSKuVVdoOs4G8PMuAQQL7dmWJo3lyoY69DxAdPdUPjfDetWumsBP9ClQmQXhHUoKoVCtLBGbJgCciwS4pmdSEBkBLsYu6JnLLQsTaT3XBTZTELi0eTLKRpmoT7gE8z4dx8BmI2PKzSOFix7+Wd1vo48OoMM6aM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(2616005)(66946007)(66556008)(66476007)(316002)(6916009)(41300700001)(1076003)(82960400001)(8676002)(4326008)(8936002)(36756003)(6486002)(966005)(83380400001)(478600001)(26005)(86362001)(5660300002)(7416002)(7406005)(2906002)(30864003)(6666004)(6512007)(45080400002)(6506007)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0XtBFqG72w9NcJuE4a180zlU/+Kc5vzEh5/5X498spQBBi0XD9WGzLIvCIC?=
 =?us-ascii?Q?vN9/oHAG6yEFOcbKtEYi5p3NfWURejytvYIm3duMZ1FrPs3IKbh54hVLNjb9?=
 =?us-ascii?Q?I459f3ZUhr+bwrruVrWLlpDC3IeBVfVKoa2Y4jymPPotrrs/irVLmbzi/n0M?=
 =?us-ascii?Q?E4cie1UPQUt3JUKJL6rj2RyvwqlsVKKz+qCVS76CtPE9lTRC9V0ae+8AvE2I?=
 =?us-ascii?Q?kSvRE39ZDQRn/gAO7DDY1gdxpMi6esU9Yegprc2XtwBmKM4u/mf4xP8KrNy+?=
 =?us-ascii?Q?CLjDuAj2EvchTOIOR9vEhu5NSKIT/peHJ5gychXg/nrSh8LsB+KodOzIvhF+?=
 =?us-ascii?Q?DwLxrBBvOhEuHfPmlxwutsMC1R3RlpIa0TJmzbi3bdMKYtGpdvFdTQUlYjvh?=
 =?us-ascii?Q?7Y4RIk70Pec8ZfEsSIHDC58OnSfUTiLhwANd19eIsv1oi/tKsNtXV3KXZqcQ?=
 =?us-ascii?Q?PNQk8zR8FTapnt7vL/te8Hog7Wakp2QBeDHypuOprwkthplwT46HwHfwXH3c?=
 =?us-ascii?Q?UntWp9cYRBYYGZiRKGJmOJAjGTSOU+lyfViLk6J9pkK9XDz+sMToz5Jg7cml?=
 =?us-ascii?Q?fU6XuRk/YaOAn8yQO2Yu1T3NYTq+AO7U18fNS6HSWCjqhnFx9O/HIam+B8b2?=
 =?us-ascii?Q?136VYlHd3oziUGg2PJ0bXwMzkYVqRYEFSTAvT8xG4fBuS+VjW4/S4pJJkQIU?=
 =?us-ascii?Q?OkEWfDMvdHkImwVgDswqfKD7iagbK0ABKZV5z/FXRbrolMPpIBnFoG+IiN/c?=
 =?us-ascii?Q?aI5Uspm0N6E8j/LaDxhYlVQp4UjCh+aZl1C6QzwKQXkNqSqxh00wJvNAhIqj?=
 =?us-ascii?Q?03PvP52JsPXw6wJ4825HCHROdSs1thGvXfkFgwBJJdjA4g2LJL48kJde+STZ?=
 =?us-ascii?Q?R6YIx5TAmObdOznXySFpaG8mCZgQcoJsGoeoFTdv0IN/NzYsQr30wxjvsopn?=
 =?us-ascii?Q?gsTTobMR6HS8OTb4TZLWHuKErg3Poonhh4mPk9dm1wSbKIX4iGItSw0IACDa?=
 =?us-ascii?Q?weBamo3rCrKfKkQ4YNHOanjKJFDUK7WojqrR7G9GMV7h05MtYkE7pl+d5SD6?=
 =?us-ascii?Q?FB3uozmt6XNX4RXiq9AGvghW7Aqzxu9qRQiZPkcm1ZBlZQWpNRMqupyM9EI9?=
 =?us-ascii?Q?ILdM3oXOPDBbqxV17eT/i6UU8uYWxtQWTv0IJnCF/PmDv+jeQ2cXUz117esn?=
 =?us-ascii?Q?NDzJw4+A364Zxj7PIdJbnc4KHTKpuDptYZwoQTyb40BTJBde3q9AVQWHJX89?=
 =?us-ascii?Q?flurRsXbNWPBQ3zNlFW7UbHGC6dEP5NTiM8gPYxirVwyXicxT1knJsqtXROf?=
 =?us-ascii?Q?PXjOovVXasBvZNysdf6SnDvtpqfFP7fR1Eqvb/xLDHGkooE1jiQK3ZCJ9Zzj?=
 =?us-ascii?Q?myibR7OdCPTtoY23zaq4C/hHH2XSEpF781ZWuRm3l527ibKzh0+3qsDHYoRF?=
 =?us-ascii?Q?382Z9FNxvmVI2w7xOnBK2APlu3gZZMOAklJgkv0zjKMkPcBK/897WeVTvaps?=
 =?us-ascii?Q?VW6TcXxI4g4DqdEgS2iJu6XiSO8Egv2CQU64kLMVtlYtP7JtemdHleu/NJMA?=
 =?us-ascii?Q?VfJZefuravaAzudLUvYF5UkOXyYD/hFRLgc4wsLqayxWF4maMQbm6KQa54R3?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ea009c-6bdf-4702-2e52-08dbe716ebaf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 02:43:03.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJzsr/A5Qa9o9vZV1V5b5ytP6dDnXha6mNkNwB4HOYzWPUnpCHlZbUuZ96KNAQykhWDJTvKwTAgnx193dYLlQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6669
X-OriginatorOrg: intel.com


hi, Sourav Panda,

we are not sure if this patch is NACKed since
https://lore.kernel.org/all/2023110205-enquirer-sponge-4f35@gregkh/

but seems you still have plan for next version
https://lore.kernel.org/all/CA+CK2bCFgwLXp=pUTKezWtRoCKiDC41DqGXx_kahg0UcB53sPw@mail.gmail.com/

so still send below report to you FYI about what we observed in our tests.


Hello,

kernel test robot noticed "WARNING:at_mm/vmstat.c:#__mod_node_page_state" on:

commit: 77348e22542ef30ac2e12e111fdbe2debe4c8bf7 ("[PATCH v5 1/1] mm: report per-page metadata information")
url: https://github.com/intel-lab-lkp/linux/commits/Sourav-Panda/mm-report-per-page-metadata-information/20231102-071047
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git effd7c70eaa0440688b60b9d419243695ede3c45
patch link: https://lore.kernel.org/all/20231101230816.1459373-2-souravpanda@google.com/
patch subject: [PATCH v5 1/1] mm: report per-page metadata information

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	sc_nr_hugepages: 2
	group: mm



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311171013.fb3e52d3-oliver.sang@intel.com


kern  :warn  : [  625.944628] ------------[ cut here ]------------
kern :warn : [  625.945623] WARNING: CPU: 30 PID: 16422 at mm/vmstat.c:393 __mod_node_page_state (mm/vmstat.c:393) 
kern  :warn  : [  625.946550] Modules linked in: test_hmm(+) netconsole openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp btrfs blake2b_generic xor coretemp kvm_intel raid6_pq zstd_compress kvm libcrc32c irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl intel_cstate nvme nvme_core ahci t10_pi ipmi_devintf libahci ipmi_msghandler wmi_bmof mxm_wmi intel_wmi_thunderbolt crc64_rocksoft_generic i2c_i801 crc64_rocksoft intel_uncore wdat_wdt crc64 libata mei_me i2c_smbus ioatdma mei dca wmi binfmt_misc fuse drm ip_tables
kern  :warn  : [  625.951800] CPU: 30 PID: 16422 Comm: modprobe Not tainted 6.6.0-rc4-00022-g77348e22542e #1
kern  :warn  : [  625.952689] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
kern :warn : [  625.953692] RIP: 0010:__mod_node_page_state (mm/vmstat.c:393) 
kern :warn : [ 625.954310] Code: 1c 24 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 65 8b 05 78 ad 77 7e a9 ff ff ff 7f 75 bb 65 8b 05 9e 79 76 7e 85 c0 74 b0 <0f> 0b eb ac 49 83 fd 2c 77 7b 4e 8d 34 ed c8 a5 02 00 be 08 00 00
All code
========
   0:	1c 24                	sbb    $0x24,%al
   2:	48 83 c4 08          	add    $0x8,%rsp
   6:	5b                   	pop    %rbx
   7:	5d                   	pop    %rbp
   8:	41 5c                	pop    %r12
   a:	41 5d                	pop    %r13
   c:	41 5e                	pop    %r14
   e:	41 5f                	pop    %r15
  10:	c3                   	retq   
  11:	65 8b 05 78 ad 77 7e 	mov    %gs:0x7e77ad78(%rip),%eax        # 0x7e77ad90
  18:	a9 ff ff ff 7f       	test   $0x7fffffff,%eax
  1d:	75 bb                	jne    0xffffffffffffffda
  1f:	65 8b 05 9e 79 76 7e 	mov    %gs:0x7e76799e(%rip),%eax        # 0x7e7679c4
  26:	85 c0                	test   %eax,%eax
  28:	74 b0                	je     0xffffffffffffffda
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb ac                	jmp    0xffffffffffffffda
  2e:	49 83 fd 2c          	cmp    $0x2c,%r13
  32:	77 7b                	ja     0xaf
  34:	4e 8d 34 ed c8 a5 02 	lea    0x2a5c8(,%r13,8),%r14
  3b:	00 
  3c:	be                   	.byte 0xbe
  3d:	08 00                	or     %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb ac                	jmp    0xffffffffffffffb0
   4:	49 83 fd 2c          	cmp    $0x2c,%r13
   8:	77 7b                	ja     0x85
   a:	4e 8d 34 ed c8 a5 02 	lea    0x2a5c8(,%r13,8),%r14
  11:	00 
  12:	be                   	.byte 0xbe
  13:	08 00                	or     %al,(%rax)
	...
kern  :warn  : [  625.956115] RSP: 0018:ffffc90000d7f548 EFLAGS: 00010202
kern  :warn  : [  625.956726] RAX: 0000000000000001 RBX: 00000003ffff8000 RCX: 1ffffffff0aeddef
kern  :warn  : [  625.957526] RDX: 0000000000000000 RSI: 0000000000000026 RDI: ffff88889fffe5c0
kern  :warn  : [  625.958414] RBP: ffff88889ffd4000 R08: 0000000000000007 R09: fffffbfff091ebd4
kern  :warn  : [  625.959207] R10: ffffffff848f5ea3 R11: 0000000000000001 R12: 00000000000427ec
kern  :warn  : [  625.960008] R13: 000000000000002b R14: 0000000000000200 R15: 00000000000427c0
kern  :warn  : [  625.960786] FS:  00007fca350f5740(0000) GS:ffff88880f100000(0000) knlGS:0000000000000000
kern  :warn  : [  625.961664] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  625.962342] CR2: 00007f643c75d000 CR3: 00000002c7c44003 CR4: 00000000003706e0
kern  :warn  : [  625.963132] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kern  :warn  : [  625.963923] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kern  :warn  : [  625.964702] Call Trace:
kern  :warn  : [  625.965089]  <TASK>
kern :warn : [  625.965436] ? __warn (kernel/panic.c:673) 
kern :warn : [  625.965898] ? __mod_node_page_state (mm/vmstat.c:393) 
kern :warn : [  625.966450] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
kern :warn : [  625.966947] ? handle_bug (arch/x86/kernel/traps.c:237) 
kern :warn : [  625.967409] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
kern :warn : [  625.967914] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
kern :warn : [  625.968445] ? __mod_node_page_state (mm/vmstat.c:393) 
kern :warn : [  625.969014] __populate_section_memmap (mm/sparse-vmemmap.c:475) 
kern :warn : [  625.969591] ? kasan_set_track (mm/kasan/common.c:52) 
kern :warn : [  625.970103] sparse_add_section (mm/sparse.c:867 mm/sparse.c:907) 
kern :warn : [  625.970628] ? sparse_buffer_alloc (mm/sparse.c:897) 
kern :warn : [  625.971177] __add_pages (mm/memory_hotplug.c:403) 
kern :warn : [  625.971650] add_pages (arch/x86/mm/init_64.c:956) 
kern :warn : [  625.972113] pagemap_range (mm/memremap.c:250) 
kern :warn : [  625.972609] ? memremap_compat_align (mm/memremap.c:163) 
kern :warn : [  625.973162] ? percpu_ref_init (arch/x86/include/asm/atomic64_64.h:20 include/linux/atomic/atomic-arch-fallback.h:2602 include/linux/atomic/atomic-long.h:79 include/linux/atomic/atomic-instrumented.h:3196 lib/percpu-refcount.c:98) 
kern :warn : [  625.973678] memremap_pages (mm/memremap.c:367) 
kern :warn : [  625.974187] ? pagemap_range (mm/memremap.c:292) 
kern :warn : [  625.974697] ? kasan_set_track (mm/kasan/common.c:52) 
kern :warn : [  625.975209] ? __kmalloc_node_track_caller (include/trace/events/kmem.h:54 include/trace/events/kmem.h:54 mm/slab_common.c:1024 mm/slab_common.c:1043) 
kern :warn : [  625.975802] dmirror_allocate_chunk (include/linux/err.h:72 lib/test_hmm.c:552) test_hmm
kern :warn : [  625.976483] hmm_dmirror_init (lib/test_hmm.c:267) test_hmm
kern  :warn  : [  625.977092]  ? 0xffffffffc14b1000
kern :warn : [  625.977539] do_one_initcall (init/main.c:1232) 
kern :warn : [  625.978044] ? trace_event_raw_event_initcall_level (init/main.c:1223) 
kern :warn : [  625.978718] ? kasan_unpoison (mm/kasan/shadow.c:160 mm/kasan/shadow.c:194) 
kern :warn : [  625.979261] do_init_module (kernel/module/main.c:2530) 
kern :warn : [  625.979761] load_module (kernel/module/main.c:2981) 
kern :warn : [  625.980267] ? post_relocation (kernel/module/main.c:2830) 
kern :warn : [  625.980782] ? kernel_read_file (arch/x86/include/asm/atomic.h:53 include/linux/atomic/atomic-arch-fallback.h:979 include/linux/atomic/atomic-instrumented.h:436 include/linux/fs.h:2740 fs/kernel_read_file.c:122) 
kern :warn : [  625.981318] ? __x64_sys_fspick (fs/kernel_read_file.c:38) 
kern :warn : [  625.981858] ? init_module_from_file (kernel/module/main.c:3148) 
kern :warn : [  625.982408] init_module_from_file (kernel/module/main.c:3148) 
kern :warn : [  625.982959] ? __ia32_sys_init_module (kernel/module/main.c:3124) 
kern :warn : [  625.983508] ? __lock_release+0x111/0x440 
kern :warn : [  625.984078] ? idempotent_init_module (kernel/module/main.c:3094 kernel/module/main.c:3159) 
kern :warn : [  625.984743] ? idempotent_init_module (kernel/module/main.c:3094 kernel/module/main.c:3159) 
kern :warn : [  625.985347] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:444 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140) 
kern :warn : [  625.985895] idempotent_init_module (kernel/module/main.c:3165) 
kern :warn : [  625.986448] ? init_module_from_file (kernel/module/main.c:3152) 
kern :warn : [  625.987029] ? security_capable (security/security.c:946 (discriminator 13)) 
kern :warn : [  625.987540] __x64_sys_finit_module (include/linux/file.h:45 kernel/module/main.c:3187 kernel/module/main.c:3169 kernel/module/main.c:3169) 
kern :warn : [  625.988090] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
kern :warn : [  625.988576] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
kern  :warn  : [  625.989174] RIP: 0033:0x7fca352005a9
kern :warn : [ 625.989645] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 08 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 27 08 0d 00 	mov    0xd0827(%rip),%rcx        # 0xd0861
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 27 08 0d 00 	mov    0xd0827(%rip),%rcx        # 0xd0837
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231117/202311171013.fb3e52d3-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


