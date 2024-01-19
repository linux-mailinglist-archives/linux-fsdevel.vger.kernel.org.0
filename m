Return-Path: <linux-fsdevel+bounces-8284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C983235A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 03:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF90285E35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67731392;
	Fri, 19 Jan 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpZB+257"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095341367
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705631807; cv=fail; b=QmqUqBxilxkYgzSmKD0G6+1ZWjniirpKxqc/61c6Sq+qI/YUWqfXrytPYuWAS8b96cEh0vPPKDWwbLDr1QlAi1YT4geStAcWo00lyJcwsKAZ1wIBe6R6f39M/pwkle7eUMKJUejodSEW/5fnQdsibNdlzf/X/iS3ZIbUqSTizro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705631807; c=relaxed/simple;
	bh=9Xi3brFIwCiGfPeVAl7EUTDx7in/czazF0lSYln8d0s=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DS+c9Bf08TR5t3ryPsFYXVcnkdr9eemNQvHc7YsfoUUI+fm6zpIOmS5VNDX3tzX0fNYdHku13lvuiCvZkbqGAXS/cZ2LMZ+oFBguYUShxTHdvdV0k2D/M0nvo8QCl1cZueFsNtEewnLUEWhPPjUMlPQlsdVr0YDw9Z4pPiOogu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpZB+257; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705631805; x=1737167805;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=9Xi3brFIwCiGfPeVAl7EUTDx7in/czazF0lSYln8d0s=;
  b=EpZB+25793Xn96R+FPy1EunKJDBXUvXSxLERAbv3wEnzN60Oyu0IcxeV
   oUvSaVnCAu/rSwvJlU4YjGjmDZXpXCno3LieWLS/RDtg9SO8YV552j5AH
   xQF0U6VJf4aaXjBTSOGP47YgelG/MwVGGg1HMxPR0+8wuBzL/PPnsQq14
   91KTMBnLDOWcDFGACXu1yP3fCzk9bZO+B1YebiJaFt7v3eNU8iOUyX/4h
   GGJ7tc2s/rGu3mGBOOjzgVY9B6PZvDeNooUnDoeM3D1+K6M9S5mvz8YFm
   bMgQH6dMcmPty6eHUWtxs3wrp9KunSZAFwaIuw5Ggq+E92Ub40imN6vj/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="464912757"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="464912757"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 18:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="904023849"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="904023849"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 18:36:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 18:36:43 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 18:36:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 18:36:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 18:36:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snor4is/Cuu8MquKEOvGIj9hjDCV7tFv7yTBQdRAOg59VyL1N8Voor+h7xef1+hxSmTWTDUQkzqolMeO4CKAfkN7HFLWYF/pXIok0E/03wmAsf/TOifYRBOy9JJYqo4AafpJYDb5VCiNYoyHF6gAnKt798JAZ6vjgY3JSXLrRzRX5LDP2hyNgfkeB5hMCBsHKQu8S9wm0H8W8V7Rfgr320QWHF4FxSiymBV5qwsq6Z2WQxF/e++1Eg+be3bZz6thSxwsiMpx7M6f3K1fFc2guAKwlnH+/ggSa0i1C5Hg9csVDeb72Gxq1SzKnDkAhmXIna+JPgkKnTUyycRHlIOwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgAdnFtyvI6RlfBhMZrm9ZIEsnL8vkT319v8V1VUBLs=;
 b=ajDADcAqf6Ob608y1RnEPEtMu0oJMXOG0JddKfquTqid+zwqeMqSpFE7czHOuuqSvfeUnelNNbHoT0fO14KvsP32PVlrkhJf2K3HyiDk4eAT60leWo5QeIMaftSy5SBalyw8/p+FqwqA8m5PbRvt5Zp8maU1tRQ1gqyDRHBUbz+2d7MG1a50S9v3YywsOk6VVbPzcnJODojeqsV7/wxbqMlTt2s+naStpEwPfe9dMuUQNAvTTCFrj9bTN+5xe2v9yeiW/hUmoXSV/EZklmzOxQYkMscwEIOfpvawYY83ZlkqJErb9jeX7AJNZu+S9RQVrnTWR+MkGkD3Fsf4d7e8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4590.namprd11.prod.outlook.com (2603:10b6:806:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 02:36:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Fri, 19 Jan 2024
 02:36:34 +0000
Date: Fri, 19 Jan 2024 10:36:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] filemap: Convert generic_perform_write() to support
 large folios
Message-ID: <202401191032.c8606703-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240111192513.3505769-1-willy@infradead.org>
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: a22ea6df-6e00-40a8-17ed-08dc189773ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: trKbIjVPQG5HTeA6DGiuXQQmLdgLbBzSa82jo36G5cHZeC9lQ5XmaPhvNKhAPfgkaKErvWuaZpBhYtt7gvoFZZhXghjkCvq/8mq59yZd4l77So1wKlha+5tLZkKY+/JSFA1Jg17YqWjfoxfdz9aYFBEA28fhbicefNL8fKGyUijuKFXtJVsQjQ+9zTunoSTtmWxcwC5lWK44k6eyxvqv9dlRDHX/o9KB3uTtuiszkOdQd3pXFrYF0KrcSVQyM6wedyE3rKOsq9t1PMYD6hDn1bhL/iQK5lfXDvsC2YQNVltdungmgwym3PnoE/+eyhgyAEd4TRLyi9QPXFMd5ZHWftCUp7p1FxWiro/gTZZ6JhZTq6biEP+PthalqW3U+fdAPeSBxEMknr+m+L4XO+Hcrd9+9Uwtbw+Be/q2YrvF6vRH+gT+zpe5ImCPW4rl0ZRmpJXQOVd9ZQDSms2/FRpLrsF8R1i4/tu7CrHKbXCdGB+qh/KAJQQr/HjWf/pvZwQ0KScQuszgmtbtmF3eBW6bdLJTUeJt5GoSitiptu2iPgh9DTcjM3ySDi+69sGXEC5VjByfN6uREJsHJJafYm3ybzJddDrKExm4P1DmV/8lhCoc4sFLQ8yHxkczVvpPQLK0EcI4wfv89FHGPfuhlR0DJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(8676002)(38100700002)(8936002)(316002)(2616005)(1076003)(107886003)(6506007)(6666004)(2906002)(41300700001)(82960400001)(478600001)(86362001)(6486002)(36756003)(26005)(6512007)(6916009)(54906003)(66556008)(66946007)(5660300002)(66476007)(966005)(83380400001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqDuLoiP3PRYeNWEpzcKwTe5PIdPpY2BJ7xQdfSutcf7RNpCMY/p7V/7O18P?=
 =?us-ascii?Q?45ONnUJn52a9pfxk4pUmFTW6J9/PRnRul0PkbAFYHTie8/nnFJOOqnc2GEqx?=
 =?us-ascii?Q?HmScvbffvlxYa8mCQMhYUuCuN1iW72s0SjnvItrxWVH6+Gu5tGpVOglTX5nc?=
 =?us-ascii?Q?vzm30zuaPvVIAqyarU7ESnTo/AlH8HzHN5U0czRe8IHnxi38kKfJNfACB9SZ?=
 =?us-ascii?Q?BX9lvTTk68oK9kpy9QHa0R+9P1cMuvgVtGFozKUJd9E8KxSLifarrDW6XTTx?=
 =?us-ascii?Q?1z1J9od6cAUZfFSPIKs5+lJkoAN+t+4WGQvv8onkSRkXJFAOvp7dp39GVXNC?=
 =?us-ascii?Q?/DU4rFFIaBktFpL4xUtTaqejluinoMo/KqMKx8U7Bg8voXMjj2t9CHH20hxi?=
 =?us-ascii?Q?CNpfK1dCLjgw9g507n2KhhAcnKzR/IhAPZgBo0s2kbfrM8m6bBIPWa1CgS/W?=
 =?us-ascii?Q?t0GsiooQY7qm1zgSUUhGIzMxj3SpCfTqellE1ES4M+m+1vsrKcDupspQ5o1B?=
 =?us-ascii?Q?9cQyqp7X6hDUfxnGdD9SkSWV2WEvVqTZFu7vr98qBaOcVhRoDkAIil0P4A5X?=
 =?us-ascii?Q?d9zZdCoxeBBYqCvbGCJqCXneJuP2LjTv34nr61evBIsIp1R3HgPqsG6ToOaR?=
 =?us-ascii?Q?ehziWz5DfSQ8JU3xEMLqe3fvLh+us9oAxww2bFgq6+Qs/CxnTGAsPIXT+uNk?=
 =?us-ascii?Q?R0L9Eqb75T1FtfLUV5RmfS2/bq1LDmZ5swNZRQ4PnkZ8GMKuu04QstHqzhlG?=
 =?us-ascii?Q?G68JedULnXbL6GOvrYjsDWWjAKuH/b6mVI1I4KVMQJolsRXz7JRGEXzKPl+E?=
 =?us-ascii?Q?nUM7M8/pSdQQr/YS98Mqh36Oe9F5yMUWEjW52rjY+fdLTCR3QHx3YLUCb9/o?=
 =?us-ascii?Q?SMu7mQBeMa/bbGBDDOqZtM/DG6QnQPMYPwsUF7OEaC3uiLD3DUzzDu7jUZvv?=
 =?us-ascii?Q?OyzJsfBpPLKsOi192q/wzMKP+HjKYgiOQmeSsLHsf4/wqyGYDzXmcq6emtGP?=
 =?us-ascii?Q?m2v/MbTBFF1XBOzkIfPD9Zs/LK334bkse48JpQp6SHGi6BF9cXHJB9s7R8fB?=
 =?us-ascii?Q?xq9o+ibSq1BBHWl3svT7RbUQ1geikLhMeX+czwu6CQdTMRdCpSOJvi/lSkKl?=
 =?us-ascii?Q?lHcoe3OIKGIGj1I/8UrGlIsS+TixWp4gu5AkfaEbKLsJVF1Kx8bd6OCPlQ2I?=
 =?us-ascii?Q?uDMtfnMjGFzSWbdTR01pFySz8+9LiNujfY1FfHmLTd0u3SSYM7hLBQhHUUdg?=
 =?us-ascii?Q?dDCQXlCcGm18NZeYYZhkjBwXXVYPaBtmnL12ubLvXa/qZIlj+393Zqhe4xOS?=
 =?us-ascii?Q?lzh5E4QOq0Jskta8D5HYMUMDOGCFYvX7Feu4OGtjSV3jvAiEFDJ9T0omIXdD?=
 =?us-ascii?Q?ATuQ4faH7jxyunYafaHEgGx9X0YZpEfZloK+Dno0Am/XRxyiUt5KAOhIV+vt?=
 =?us-ascii?Q?iehkxEejBZcm9EnyiLbD5KCFp5khKpF9uojUZvOe/rl7aFIJex38ysXWoRRe?=
 =?us-ascii?Q?P5IxCw5PCltPVYCV267KtTJAAZHZG4SxMC15PYFLXceo4oKP/Wl8k1iCYtXP?=
 =?us-ascii?Q?8IgA9P+I9ByBxFzOmPHR8JKdG7ePWHoj/LbP3VLGzuazUgP4ukgwDrmq+lhX?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a22ea6df-6e00-40a8-17ed-08dc189773ed
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 02:36:34.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU1+E7NTSvU4j8upNhfprw4a6PZN8Q1dcqNCYs9Vdoxa3ECccrMTHQi9xOBFFCFEaJfKBpF3RbhssGIFkT2Stw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4590
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_fs/buffer.c" on:

commit: 5e90db780eee7cd4635d0b784603424f66d101e1 ("[PATCH] filemap: Convert generic_perform_write() to support large folios")
url: https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/filemap-Convert-generic_perform_write-to-support-large-folios/20240112-032734
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20240111192513.3505769-1-willy@infradead.org/
patch subject: [PATCH] filemap: Convert generic_perform_write() to support large folios

in testcase: xfstests
version: xfstests-x86_64-17324dbc-1_20240115
with following parameters:

	bp1_memmap: 4G!8G
	bp2_memmap: 4G!10G
	bp3_memmap: 4G!16G
	bp4_memmap: 4G!22G
	nr_pmem: 4
	fs: ext2
	test: generic-dax



compiler: gcc-12
test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz (Broadwell-DE) with 48G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401191032.c8606703-oliver.sang@intel.com


[  264.977376][ T4263] ------------[ cut here ]------------
[  264.984538][ T4263] kernel BUG at fs/buffer.c:2081!
[  264.991338][ T4263] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  264.999394][ T4263] CPU: 1 PID: 4263 Comm: cp Tainted: G S                 6.7.0-01803-g5e90db780eee #1
[  265.010554][ T4263] Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
[ 265.021275][ T4263] RIP: 0010:__block_write_begin_int (fs/buffer.c:2081 (discriminator 1)) 
[ 265.029168][ T4263] Code: 65 48 2b 14 25 28 00 00 00 0f 85 3c 01 00 00 48 81 c4 c0 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 0b e9 4d fb ff ff 0f 0b <0f> 0b 0f 0b 48 8b 54 24 08 48 8b 74 24 10 48 89 ef 89 04 24 e8 fd
All code
========
   0:	65 48 2b 14 25 28 00 	sub    %gs:0x28,%rdx
   7:	00 00 
   9:	0f 85 3c 01 00 00    	jne    0x14b
   f:	48 81 c4 c0 00 00 00 	add    $0xc0,%rsp
  16:	5b                   	pop    %rbx
  17:	5d                   	pop    %rbp
  18:	41 5c                	pop    %r12
  1a:	41 5d                	pop    %r13
  1c:	41 5e                	pop    %r14
  1e:	41 5f                	pop    %r15
  20:	c3                   	retq   
  21:	0f 0b                	ud2    
  23:	e9 4d fb ff ff       	jmpq   0xfffffffffffffb75
  28:	0f 0b                	ud2    
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	0f 0b                	ud2    
  2e:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  33:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  38:	48 89 ef             	mov    %rbp,%rdi
  3b:	89 04 24             	mov    %eax,(%rsp)
  3e:	e8                   	.byte 0xe8
  3f:	fd                   	std    

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	0f 0b                	ud2    
   4:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
   9:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
   e:	48 89 ef             	mov    %rbp,%rdi
  11:	89 04 24             	mov    %eax,(%rsp)
  14:	e8                   	.byte 0xe8
  15:	fd                   	std    
[  265.052266][ T4263] RSP: 0018:ffffc9000c9dfaa0 EFLAGS: 00010287
[  265.059752][ T4263] RAX: 0000000000020000 RBX: 0000000000000000 RCX: ffffffff81b86bf2
[  265.069035][ T4263] RDX: 1ffffd4000bbc0b0 RSI: 0000000000000008 RDI: ffffea0005de0580
[  265.078345][ T4263] RBP: ffffea0005de0580 R08: 0000000000000000 R09: fffff94000bbc0b0
[  265.087668][ T4263] R10: ffffea0005de0587 R11: 0000000000000001 R12: 0000000000000000
[  265.096944][ T4263] R13: 0000000000001000 R14: ffffea0005de0588 R15: ffffffffc149b940
[  265.106163][ T4263] FS:  00007f4d3456c800(0000) GS:ffff888ba9c80000(0000) knlGS:0000000000000000
[  265.116366][ T4263] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  265.124278][ T4263] CR2: 00007f4d3456a000 CR3: 0000000138c2c002 CR4: 00000000003706f0
[  265.133569][ T4263] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  265.142841][ T4263] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  265.152019][ T4263] Call Trace:
[  265.156536][ T4263]  <TASK>
[ 265.160748][ T4263] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 265.165703][ T4263] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
[ 265.171181][ T4263] ? __block_write_begin_int (fs/buffer.c:2081 (discriminator 1)) 
[ 265.178019][ T4263] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
[ 265.183817][ T4263] ? __block_write_begin_int (fs/buffer.c:2081 (discriminator 1)) 
[ 265.190674][ T4263] ? handle_invalid_op (arch/x86/kernel/traps.c:212) 
[ 265.196850][ T4263] ? __block_write_begin_int (fs/buffer.c:2081 (discriminator 1)) 
[ 265.203673][ T4263] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
[ 265.209523][ T4263] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 265.215747][ T4263] ? ext2_iomap_begin (fs/ext2/inode.c:785) ext2
[ 265.222523][ T4263] ? __block_write_begin_int (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:785 include/linux/page-flags.h:806 include/linux/mm.h:1090 include/linux/mm.h:2141 fs/buffer.c:2081) 
[ 265.229300][ T4263] ? __block_write_begin_int (fs/buffer.c:2081 (discriminator 1)) 
[ 265.236035][ T4263] ? mode_strip_sgid (fs/inode.c:1889) 
[ 265.242047][ T4263] ? ext2_iomap_begin (fs/ext2/inode.c:785) ext2
[ 265.248757][ T4263] ? invalidate_bh_lrus_cpu (fs/buffer.c:2070) 
[ 265.255144][ T4263] ? ext2_iomap_begin (fs/ext2/inode.c:785) ext2
[ 265.261773][ T4263] block_write_begin (fs/buffer.c:2152 fs/buffer.c:2211) 
[ 265.267589][ T4263] ext2_write_begin (fs/ext2/inode.c:924) ext2
[ 265.273935][ T4263] generic_perform_write (mm/filemap.c:3930) 
[ 265.280191][ T4263] ? preempt_notifier_dec (kernel/sched/core.c:10130) 
[ 265.286318][ T4263] ? do_sync_mmap_readahead (mm/filemap.c:3891) 
[ 265.292783][ T4263] ? file_update_time (fs/inode.c:2170) 
[ 265.298599][ T4263] generic_file_write_iter (include/linux/fs.h:807 mm/filemap.c:4059) 
[ 265.304874][ T4263] vfs_write (include/linux/fs.h:2085 fs/read_write.c:497 fs/read_write.c:590) 
[ 265.310003][ T4263] ? kernel_write (fs/read_write.c:571) 
[ 265.315543][ T4263] ksys_write (fs/read_write.c:643) 
[ 265.320595][ T4263] ? __ia32_sys_read (fs/read_write.c:633) 
[ 265.326141][ T4263] ? do_user_addr_fault (include/linux/mm.h:689 arch/x86/mm/fault.c:1366) 
[ 265.332146][ T4263] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 265.337434][ T4263] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  265.344113][ T4263] RIP: 0033:0x7f4d3471c473
[ 265.349297][ T4263] Code: 8b 15 21 2a 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
All code
========
   0:	8b 15 21 2a 0e 00    	mov    0xe2a21(%rip),%edx        # 0xe2a27
   6:	f7 d8                	neg    %eax
   8:	64 89 02             	mov    %eax,%fs:(%rdx)
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	eb b7                	jmp    0xffffffffffffffcb
  14:	0f 1f 00             	nopl   (%rax)
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 55                	ja     0x87
  32:	c3                   	retq   
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 28          	sub    $0x28,%rsp
  3b:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 55                	ja     0x5d
   8:	c3                   	retq   
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 28          	sub    $0x28,%rsp
  11:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240119/202401191032.c8606703-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


