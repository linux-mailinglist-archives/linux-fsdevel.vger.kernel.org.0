Return-Path: <linux-fsdevel+bounces-12099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2085B462
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EEF1C20B9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2DE5C057;
	Tue, 20 Feb 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjCS2jTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310215A4FE;
	Tue, 20 Feb 2024 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416238; cv=fail; b=aRSHoNV8j4CUDWI6ZxkLk0ysEv2Qzwx0IBwpjReVGdlWIWC/rtPgB1T8QeGHRaMH51DoVUTPveIz0ljnxWrAd5kuDG5Y/HGbKC+HPkKjnZmr7N0s3df9dqMQn0w69UA6OIQN0Vz2MGfFJmizGkOEMcsfv0+Ha2KPcmuPWU/o04s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416238; c=relaxed/simple;
	bh=yYipiojRLrL0TnxWqjmdNhyRdQTNfPkKNIHm0dP2ekc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=N1PX7u8lKuASizMpN9UAoUYBMhDMlJjiZlHFcwpLF1VYYqvUKZNcHrg13YgV/mabjKCogXeYgM2XIQQV6n8j5o87a+FnSnkZUpKxQESZpIb/9Ojzv5G/04+vXLzCTh04t+dQRcJQLt2ZjfTm+ciCp1QCU/sr62ikmmJ4NRPw0+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjCS2jTc; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708416236; x=1739952236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yYipiojRLrL0TnxWqjmdNhyRdQTNfPkKNIHm0dP2ekc=;
  b=XjCS2jTce1i5PTfv0CqsCjxJwxId1Xb5mS9L4YzvxCpEY/4m34z0EnPi
   +OhySKGSIMtQ7rSzwssLMEspChNuqsltZTogZhlk608l1mv7yuoNP4NN/
   ltYHtQ7iu3Yz8TY/6fXn6Bh6XGqYzrKOKBHFSRk8YrPoGCaLOnMWEMuNC
   z68eea9Hhn+ciFAbJ1o0Y5Lj6i4YXCjiioEsKUWFYoEX6n407jYyuIALW
   YztostFwsh5FZyCRUIBS7o3UlPsJREiMdx9FuW4tH2415XCFIryD9i+H4
   A/LPUup8A7B+EZbHo+H9UvREuIxFSdGTPU2S4UEeAxnwXmu1Ty8MUziuS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2375852"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2375852"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:03:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936414037"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="936414037"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 00:03:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 00:03:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 00:03:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 00:03:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 00:03:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRMO/uxWRdyQaPbmPDrDWHa5H1e/we/u4B0o6u4Oj+QII/5exrE4Dhmji4yIs0LcV0dUqMJO6Wjb6pX4VKBw5/NeT+JxRqNjlFG+FdFdE8W3E6ttIttD8IfO3IM9WA+okj1uzRh+7Knkp7Y5PE590TPbe4cmYCn5sdu6fXRcKlfepOIcAEgk/+K90fI1uooQxqaqhPH9H9ao559We0oJ/C/QWwEoNH9qcM4Ctst1sia2ke+9E2WX7t7txTJ40c7UqHMlVkQcE9pvTgzz+hWavF/fAyZvoUCFlIoFVqNAzJUjLgcJtvEygIEt3maxB1epdY4LDap/3BL2nLZIdVF8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcM2p8PsL05p7A8g0w9d0lnWe+7GV2PmFpwZ35V9rUk=;
 b=SW7OWO1sQCZZcSOp0rMI1GwDN8R/THikGgVRLISSC5D/LLfVKWItpmlPv4kQEdawaMkX5+/imUAGJ56SUfgLiSrMZH4yLD7ndwcSNH/E5jO1a/v/279hg2J2pJ/MOrXqhNwp+I2VF2lIf2Btf03ngT4pOPEKDzQuH1bus6QFZnPQO5m7Iwc/0wkaD8C6jkRbo398sWzNOmxGIXAxYd9LE+StUfCWezawQH9WlJXQ3q1MpTG1aW34/TjVEPkfgmL6SHHkxrhctIWdbpjb3w8YWaaMCE7BmEKV9sMh+cTLRrTg+NAboYiZrXynHqyJupnCD7OxGIrD+c10K2SnG4Le/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5090.namprd11.prod.outlook.com (2603:10b6:303:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 08:03:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 08:03:45 +0000
Date: Tue, 20 Feb 2024 16:03:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [goldwynr:buffered-iomap] [iomap]  5ade73f9dd:
 BUG:KASAN:slab-use-after-free_in_ifs_free
Message-ID: <202402201521.1a5453d-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8a9c55-febb-42c7-5014-08dc31ea753b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH/hwrmM8yCew+jbRZPFcB16jcan7eNiMm9thyyeNl+rhfC6pZL0+wI/OdN3qKybWVNuLlK0UHfSlNXtL4OrWMqCYrVXcNtzAThdJOEWpPTT+eS+Ds2TmEdKXjsLLau3bSMpUjeJzoHahfskRGuNBCFVpx+1rpKDmtnz1nqU8Hc30QYzbefYSbVSwJWWtrNUoe4nZ1/9uNduBqeVOCEOSY6PFyF711hB9vNW5Q77MWLRAEo9oB0h7bB2jpL9AM81vweTw5fRkQMpmiuLAAP2pC/Vlpn417696Wz6ozrsAIGU7v5CjoGwiiyU5vWERskbSCqOznbrxVDStSFZq6j2Vms6o+ERT0EcgZ4DSqzVfUY7zSQQRQDR1gy1LUlKkI1mCAy5JQo/BjAyLYwzal2t6nZ8KjOPQIKjpjqhnJbofWetWV5qURQX/MoZE9LkojAotovI1XrA6oJYAcVI5nKhN/tdUezh3pRP38vPo6c0jppAgOIf6FAviAA+/c2plArv+DV21PNMf85iCWhqSHwSDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ak+9HSHab8XY1rlaifLVV/NrIW3o53Ss9BjoECZz8tyhjpyvIY3qUfhEzirJ?=
 =?us-ascii?Q?JaXwTOysMM9Yk2fBjhAF9lFHfdcsEmnx0PBmWTmPuIXMfCmXK7CP+GojManM?=
 =?us-ascii?Q?5m5is7GsLYcto3R8DlBQ4canzzsNiqdRsZVYhEev/jDPfVpSwu03cW3z89QP?=
 =?us-ascii?Q?urI67FEA7yn4lKoZh3paPnD6a9zpzLHrPM7GfcjlaFZw40eSkg3xSZoXKqY0?=
 =?us-ascii?Q?2pN3VEz6jL7gwwsOoOx1DLhfs3XzQ5HVHtC3iIQWXNRLfBToY06F2VnRXPbo?=
 =?us-ascii?Q?0OBgM6F/wzhnNLy3yO0vKkWxDmzakZwMYszzv7Zcnpo2jy7eUZuXPEDmJHit?=
 =?us-ascii?Q?I04FXm08gPbPZ6FATBrSZ1LAI5jyWpon62AQvO7RkjDnJ1iJoi30sMDskAzN?=
 =?us-ascii?Q?nGCZMkK63KIxr4N8ImjkPckF+pBX0rAqnbgBKIgFro5NBExjVo1ZywAO7zaT?=
 =?us-ascii?Q?s1+aLU+S/spuxtxkEG9HGvobSOYbZohNAr84jDKiEO9gz7zE2YKVnnjdK++i?=
 =?us-ascii?Q?SS/zVu3j0+k0Y/Pb4l0VpKuEio9agyoi+4q6XYp2uN7rqSnjhg6BbKb0S0we?=
 =?us-ascii?Q?ZrtnZXZgSjhnKjXc31TY42sUKb7FGs8oTC1ANjzzzpwrFnk+oIQ+00JogOmh?=
 =?us-ascii?Q?WhT3XGCgSyE27hnS3wT8AeqoY5v+GIOuc/PPBKip+UO/FmN1Exh5cmxWaQRu?=
 =?us-ascii?Q?Yp1/fCDjriatWI9Eyl1Ta01K7+EEBQiDG1078I4YR7AolTBUsHj13Pl8nhhy?=
 =?us-ascii?Q?mbEj0363Q6CmmIweLmgv6TkYy9ybYOZ+AwHQd60ty0i7uksJAQNjnAqEMImf?=
 =?us-ascii?Q?rjutbJzy5cyZeVfhhKbdu00rFm4/hjYYk/IWtyQsqbolXI4hgWhaEpE4hdVh?=
 =?us-ascii?Q?YutT3k72F1cZZkFEBqQcjFrUl6agCemRw8pFsic46cempTSQnIrVezXhvApJ?=
 =?us-ascii?Q?AtsAKKTYwc1fgveSM/Gor0siWYqrdrMTRXewOL/gUg7RVYUPq/1w9TJSPjRC?=
 =?us-ascii?Q?zkhLXAmqNdEWryw/+SXbJp37UFQdhX1fNtnMf/Gy6jKRA1pz/7hMXjkygQdE?=
 =?us-ascii?Q?xdesX1KTldL0B8Bf/J2MuogKbB09PbzDmf9uLoTUU+AMDbZQi3lrL6ISFGTC?=
 =?us-ascii?Q?AuK62/rZJCoTKApo70clyqDrIBR9+GdHdgU6Bw/BUW1aZKc3WFKm9i876Mv2?=
 =?us-ascii?Q?dFdV8pHBNygFt70hwSev9AVS6q0DfhYVXmSS+40KsKaV2mXjwd9uw+pLSwOk?=
 =?us-ascii?Q?cWkQSvjNcqtHgLvwuxqNLT3btJNLMDCgCxUhb/zHvw7GZdmk8a0+t9ASha65?=
 =?us-ascii?Q?3A/RzI4Bbv+97qGwLDD2CZpXag+d0WNlg67EIMbsByAyLLOj8XLjepLNWm1P?=
 =?us-ascii?Q?jZoRfDJFuPKcdZJbZ21NvVS+X0AQOxE6/HF/lBUTQ5w2IHGcxEedMpU+RWiY?=
 =?us-ascii?Q?NOjEaPai9W7GNMP7d2f+tOtg+NPfuXZpkVHYFa/uQ7dUtAzGCbgqkOD83VbV?=
 =?us-ascii?Q?B2Uuo/b/xjBoUu6+5NZJd9NEwWnQx8lo4CPx0zzFmPX9bfxFukBKTi3oxH35?=
 =?us-ascii?Q?+6gsJcH1lGGAFJrp3y98I3AiuEubAGgPNjpX7SxnB9WrVbkCYi1I5DSPNCnD?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8a9c55-febb-42c7-5014-08dc31ea753b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 08:03:45.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ve+7hdtEbxBf0AJXzpQqnbSr0U/04Rj8mg2/9T0gICMMS1hXf51g+laqU7qLGyFoI538Uw63K2sK9/JGk/WwJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5090
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_ifs_free" on:

commit: 5ade73f9dd3a66f007bc8ee76dcb9e1224e9bbfa ("iomap: check if folio size is equal to FS block size")
https://github.com/goldwynr/linux buffered-iomap

in testcase: xfstests
version: xfstests-x86_64-c46ca4d1-1_20240205
with following parameters:

	disk: 4HDD
	fs: xfs
	test: xfs-group-54



compiler: gcc-12
test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402201521.1a5453d-oliver.sang@intel.com


[ 187.766673][ T3992] BUG: KASAN: slab-use-after-free in ifs_free (fs/iomap/buffered-io.c:197) 
[  187.773657][ T3992] Read of size 4 at addr ffff8881901b0584 by task fsstress/3992
[  187.781155][ T3992]
[  187.783353][ T3992] CPU: 3 PID: 3992 Comm: fsstress Not tainted 6.8.0-rc3-00092-g5ade73f9dd3a #1
[  187.792159][ T3992] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
[  187.801746][ T3992] Call Trace:
[  187.804903][ T3992]  <TASK>
[ 187.807713][ T3992] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 187.812075][ T3992] print_address_description+0x2c/0x3a0 
[ 187.818524][ T3992] ? ifs_free (fs/iomap/buffered-io.c:197) 
[ 187.822716][ T3992] print_report (mm/kasan/report.c:489) 
[ 187.826995][ T3992] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 187.831799][ T3992] ? ifs_free (fs/iomap/buffered-io.c:197) 
[ 187.835995][ T3992] kasan_report (mm/kasan/report.c:603) 
[ 187.840282][ T3992] ? ifs_free (fs/iomap/buffered-io.c:197) 
[ 187.844480][ T3992] ifs_free (fs/iomap/buffered-io.c:197) 
[ 187.848499][ T3992] truncate_cleanup_folio (mm/truncate.c:158 mm/truncate.c:178) 
[ 187.853727][ T3992] truncate_inode_partial_folio (mm/truncate.c:195 mm/truncate.c:227) 
[ 187.859470][ T3992] truncate_inode_pages_range (mm/truncate.c:370) 
[ 187.865048][ T3992] ? truncate_inode_partial_folio (mm/truncate.c:322) 
[ 187.870969][ T3992] xfs_flush_unmap_range (fs/xfs/xfs_bmap_util.c:820) xfs
[ 187.876706][ T3992] xfs_file_fallocate (fs/xfs/xfs_file.c:994) xfs
[ 187.882304][ T3992] ? xfs_break_layouts (fs/xfs/xfs_file.c:951) xfs
[ 187.887959][ T3992] ? __do_sys_newfstat (fs/stat.c:481) 
[ 187.892765][ T3992] ? __ia32_sys_fstat (fs/stat.c:476) 
[ 187.897487][ T3992] ? preempt_notifier_dec (kernel/sched/core.c:10131) 
[ 187.902556][ T3992] vfs_fallocate (fs/open.c:328) 
[ 187.907012][ T3992] __x64_sys_fallocate (include/linux/file.h:45 fs/open.c:352 fs/open.c:359 fs/open.c:357 fs/open.c:357) 
[ 187.911899][ T3992] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 187.916263][ T3992] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  187.922007][ T3992] RIP: 0033:0x7ff1a6311246
[ 187.926283][ T3992] Code: b8 ff ff ff ff eb bd 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 1d 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 48 89 54 24 10 89 74 24
All code
========
   0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   5:	eb bd                	jmp    0xffffffffffffffc4
   7:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   e:	00 00 00 
  11:	0f 1f 00             	nopl   (%rax)
  14:	49 89 ca             	mov    %rcx,%r10
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 11                	jne    0x34
  23:	b8 1d 01 00 00       	mov    $0x11d,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 5a                	ja     0x8c
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 83 ec 28          	sub    $0x28,%rsp
  38:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  3d:	89                   	.byte 0x89
  3e:	74 24                	je     0x64

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 5a                	ja     0x62
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 83 ec 28          	sub    $0x28,%rsp
   e:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  13:	89                   	.byte 0x89
  14:	74 24                	je     0x3a
[  187.945763][ T3992] RSP: 002b:00007ffde302b2c8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
[  187.954046][ T3992] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff1a6311246
[  187.961897][ T3992] RDX: 00000000001e9d02 RSI: 0000000000000003 RDI: 0000000000000004
[  187.969717][ T3992] RBP: 0000000000000004 R08: 0000000000000071 R09: 00007ffde302aef7
[  187.977541][ T3992] R10: 00000000000ad212 R11: 0000000000000246 R12: 0000000000000029
[  187.985363][ T3992] R13: 00000000000ad212 R14: 00000000001e9d02 R15: 0000000000000003
[  187.993188][ T3992]  </TASK>
[  187.996070][ T3992]
[  187.998261][ T3992] Allocated by task 3992:
[ 188.002453][ T3992] kasan_save_stack (mm/kasan/common.c:48) 
[ 188.006996][ T3992] kasan_save_track (arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 mm/kasan/common.c:70) 
[ 188.011527][ T3992] __kasan_kmalloc (mm/kasan/common.c:372 mm/kasan/common.c:389) 
[ 188.015970][ T3992] __kmalloc (include/linux/kasan.h:211 mm/slub.c:3981 mm/slub.c:3994) 
[ 188.020068][ T3992] ifs_alloc (include/linux/slab.h:594 include/linux/slab.h:711 fs/iomap/buffered-io.c:176) 
[ 188.024164][ T3992] iomap_writepage_map (fs/iomap/buffered-io.c:1923) 
[ 188.029213][ T3992] write_cache_pages (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/page-flags.h:785 include/linux/page-flags.h:806 include/linux/mm.h:2059 mm/page-writeback.c:2475) 
[ 188.034010][ T3992] iomap_writepages (fs/iomap/buffered-io.c:2123) 
[ 188.038559][ T3992] xfs_vm_writepages (fs/xfs/xfs_aops.c:502) xfs
[ 188.044041][ T3992] do_writepages (mm/page-writeback.c:2553) 
[ 188.048499][ T3992] filemap_fdatawrite_wbc (mm/filemap.c:389 mm/filemap.c:378) 
[ 188.053740][ T3992] __filemap_fdatawrite_range (mm/filemap.c:413) 
[ 188.059156][ T3992] filemap_write_and_wait_range (mm/filemap.c:676 mm/filemap.c:667) 
[ 188.064732][ T3992] xfs_setattr_size (fs/xfs/xfs_iops.c:900) xfs
[ 188.070155][ T3992] xfs_vn_setattr (fs/xfs/xfs_iops.c:1021) xfs
[ 188.075275][ T3992] notify_change (fs/attr.c:503) 
[ 188.079718][ T3992] do_truncate (fs/open.c:67) 
[ 188.083990][ T3992] vfs_truncate (fs/open.c:112) 
[ 188.088356][ T3992] __x64_sys_truncate (fs/open.c:136 fs/open.c:147 fs/open.c:145 fs/open.c:145) 
[ 188.093250][ T3992] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 188.097621][ T3992] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  188.103385][ T3992]
[  188.105581][ T3992] Freed by task 3992:
[ 188.109432][ T3992] kasan_save_stack (mm/kasan/common.c:48) 
[ 188.113979][ T3992] kasan_save_track (arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 mm/kasan/common.c:70) 
[ 188.118520][ T3992] kasan_save_free_info (mm/kasan/generic.c:643) 
[ 188.123406][ T3992] poison_slab_object (mm/kasan/common.c:243) 
[ 188.128281][ T3992] __kasan_slab_free (mm/kasan/common.c:257) 
[ 188.132924][ T3992] kfree (mm/slub.c:4299 mm/slub.c:4409) 
[ 188.136598][ T3992] iomap_release_folio (fs/iomap/buffered-io.c:675) 
[ 188.141576][ T3992] split_huge_page_to_list (mm/huge_memory.c:3032) 
[ 188.146902][ T3992] truncate_inode_partial_folio (mm/truncate.c:242) 
[ 188.152666][ T3992] truncate_inode_pages_range (mm/truncate.c:370) 
[ 188.158255][ T3992] xfs_flush_unmap_range (fs/xfs/xfs_bmap_util.c:820) xfs
[ 188.164000][ T3992] xfs_file_fallocate (fs/xfs/xfs_file.c:994) xfs
[ 188.169566][ T3992] vfs_fallocate (fs/open.c:328) 
[ 188.174012][ T3992] __x64_sys_fallocate (include/linux/file.h:45 fs/open.c:352 fs/open.c:359 fs/open.c:357 fs/open.c:357) 
[ 188.178901][ T3992] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 188.183274][ T3992] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  188.189029][ T3992]
[  188.191222][ T3992] The buggy address belongs to the object at ffff8881901b0580
[  188.191222][ T3992]  which belongs to the cache kmalloc-32 of size 32
[  188.204985][ T3992] The buggy address is located 4 bytes inside of
[  188.204985][ T3992]  freed 32-byte region [ffff8881901b0580, ffff8881901b05a0)
[  188.218401][ T3992]
[  188.220588][ T3992] The buggy address belongs to the physical page:
[  188.226868][ T3992] page:000000007b2fa282 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1901b0
[  188.236992][ T3992] flags: 0x17ffffc0000800(slab|node=0|zone=2|lastcpupid=0x1fffff)
[  188.244660][ T3992] page_type: 0xffffffff()
[  188.248868][ T3992] raw: 0017ffffc0000800 ffff88810c842500 dead000000000100 dead000000000122
[  188.257321][ T3992] raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
[  188.265749][ T3992] page dumped because: kasan: bad access detected
[  188.272024][ T3992]
[  188.274222][ T3992] Memory state around the buggy address:
[  188.279724][ T3992]  ffff8881901b0480: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
[  188.287658][ T3992]  ffff8881901b0500: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
[  188.295593][ T3992] >ffff8881901b0580: fa fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
[  188.303520][ T3992]                    ^
[  188.307443][ T3992]  ffff8881901b0600: fa fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
[  188.315365][ T3992]  ffff8881901b0680: fb fb fb fb fc fc fc fc 00 00 03 fc fc fc fc fc
[  188.323301][ T3992] ==================================================================
[  188.331310][ T3992] Disabling lock debugging due to kernel taint


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240220/202402201521.1a5453d-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


