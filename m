Return-Path: <linux-fsdevel+bounces-9884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C36845B00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348E41F28134
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1E62151;
	Thu,  1 Feb 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNgnPpqC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA215F49E;
	Thu,  1 Feb 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800393; cv=fail; b=PdEO88nfxKt1Z6aDLBxe//lcp6YbXknYgYb0jG0av3wOL14j63eIJa/K2p/4w7WYmQZ+sBmDSk8Xm2dgNKJ/WNhEvinABBKBfCQxKRVDiU6Nbp+0I4K+GCuQtR8/QlYG8qPpWBGOIJh1WA+bQJnDsUkx9TIbNzwSTihiH9xh8Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800393; c=relaxed/simple;
	bh=Q/Pk+P2tcitsLHDj53y65KzTj/Iz1ztvSEivKF5MFw4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l1ku0tJFYJaIeBsLVySwHAOmfqpnbclEt153njSD/5ZJdUJMqoyVnMLlRZ52AEURClcJUN5dzEl0k831cHZTfhkA6Hlbf7jNFSUbtfsZPH1CA2w3AvMgZSPqNe4rwhG3y0amQeb7QQ4cu4e54xI9bmJccm7vA8jijciqyChlxFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNgnPpqC; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800390; x=1738336390;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Q/Pk+P2tcitsLHDj53y65KzTj/Iz1ztvSEivKF5MFw4=;
  b=WNgnPpqCMuzLtX7lVmpbqsLKdhtVfdklUBHtu2rzOtVTsbRycUA8+Fxc
   tHegSK3mncmr3NjrouHE7ueV5LTsw+wjWvxM1Z1IFMNoRgdW+VYuWAEQN
   eULbk1j8Mtu9u8ESNP3BNlPMOX1+S4taQgEyVx0HwSqn/TGShuVR9pWEX
   utFHQqca6z/0HHaiF0ryk33kG3OqslnvYorXwE5uPIn7wsHetdAbq+Eff
   MpME41Y1KgX/k4/fW/rXslkDkPuczMjgXi+TlsN2JDi/cpIyQCS6YpEqI
   YqVfhNfjBK5dDi+TgoAshBaRTIBctuRq+AhV/FcJWCfjiDMHb9sd4SWOI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10570079"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10570079"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:13:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961942039"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="961942039"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 07:13:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 07:13:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 07:13:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 07:13:07 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 07:13:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7D3pnjxYXnsUygklxiKVbkLoM84qdac1xE47zMsUXT2ifUwL9EwpLRkQXgMiLeurdVDtV1U9mqlLu9o5NW1zx9AvUplQwMfoLEqQXrV9ZGY3Ohkzfl8Afg7OPJMkDb91Z+gxzM9ON34esZV/LIUHJd3MZXy3qtrJ0j1Kkzb8TlIDJDpwne6T4lbjD8WCC+gy4Xko2lhVmyqDdldjyaOw4XUKiX5gVdjtQhVxuBxS8wKuXEXIlhKQI611nnOghAse1qhg/SZX98yqZ8CXgzQSujXlVEA/BU2Q7hz2x5yuz1exij3U7p9T56h8bmISfbtdmgJMHjfBoCUZRSjtEHkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nZsDocyvmtItJeXoHGFvwwBzaUYUOvFGCk2Yhoxf2Y=;
 b=ZYxFkZsAQqao+X6uWR7OSq8sJtZoKA80xZ3/7qmwtWXkUQj/tk4tIAZC05/+U1AB7bnsNE9q/wILflGfik73k8z3QB7a9Csni+zVj57lpBY1/xiD/rAoDilXmfy5DPB9iY8fs9qYfCqpnJs459r9KaTd633IHv+AmG4N2MbH2xLf1OBWuACACLW++/LTarjwZIawSYdqwbo3Fzns82TkdcJXi0b/JrwoU6yhbc84mJKSeM14i3yKjwt1aSfbHuxhlLfAqhhKc/wYtdjtIeWBkTryUbDzptM8Q+iGQGkeqmLkl4tEuFiFs9/S304jVl57AuLn4bF7Db34NbF6rVgJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 15:12:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 15:12:59 +0000
Date: Thu, 1 Feb 2024 23:12:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-ext4@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 3/3] ext4: Convert to buffered_write_operations
Message-ID: <202402012226.578a5c20-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240130055414.2143959-4-willy@infradead.org>
X-ClientProxiedBy: TYCP286CA0329.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcba5f3-6da5-44f4-6574-08dc233846c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q79AlwCArB1VHEPhcJdNLKLZp1xPmkmkvRbawrI8+pcQGyIs4P7N/aCbxQFPMJIyotuOjVcBGCV65PzLtFq1VzT739v8TwOoAzl0ZPZHMP9LO0Ib0Du/kRsyxeaGhn6p3nbazJM0gihJGvZrsUCzU3uAos33UUgm5ocXUigKT3Cchq3CRfSUkLc9ApFonIPobbY+IU4uRIW1SjZcWeRu9uwCmEe3ishsnc/Y+HEJY8WSUKI726dX2TvlnIv6vLzkP9nKlKyZPTJ64LhQLitVm05yCrG30AlH+zZ9xz6wuU+VNE92/HktOmDNIWUiPCEvXi7YoJLN/CCHGZNnThDcw2C9MsFiZ+sdbD3z6FBtPpuTDjzpvb80gmBQ9XmAgukP0Op3pXP7/7YgWE1AFnXj2/eSIyFSosfNbCF2Ean5I9tJoKzyv2VaD6trEXmue7aCxdgQJOmo0PV9fBRsVOIzPs4KvRINBpxIHR9B72aZkTzitj7S6aNPQ/52xBPdFpmBKlCbfCFGzXaOAveXlYdet24TaKdC5a8+fSKIVhHwXh1vCqNZb1Wc1iuTc+zPFOEzRe0CUkph6GpQ9H61jNGXsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(1076003)(107886003)(41300700001)(2616005)(26005)(6486002)(36756003)(6512007)(6666004)(478600001)(45080400002)(6506007)(83380400001)(82960400001)(38100700002)(966005)(86362001)(30864003)(5660300002)(66946007)(316002)(6916009)(54906003)(66476007)(66556008)(8676002)(4326008)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBOfUP29/LOBbR4GOfA1AiUQzfYOci+Z7Ztly4G+YXqAZC8tv2KurYXMnAwv?=
 =?us-ascii?Q?ZRz3VYhM/IZWX9dSgx1TOVl4aRQwFbLX9IuV5uNW5PCMJ0TcVBX3D5UGtJjC?=
 =?us-ascii?Q?KDK35esTaJgiNwBAZwC6yPkF+yJd3KHvCt0sVmB7oSYJ0OK0HZh5q/DFbHrm?=
 =?us-ascii?Q?Qwb+DgEpnjfDvuYYiuYFUyuiWRw9HFcVTuduyECAqT0LxZY7kmDYyw++4MDT?=
 =?us-ascii?Q?wqBJaCPF0zSAk3/2xJFY7LcDLSXgiKalyi2c7lsnMwgTEqTPXC21vac4y+3j?=
 =?us-ascii?Q?Lnvrk7Rf3qIBj4NL1f7QdkJtN6zDYK+2M/54upxDpiOF46CaB/GLNukR74Kb?=
 =?us-ascii?Q?SHRCvaY2YXQmxWwC6b3LrGxywuHP5VNxoDh0VP1hem4ynghiQWWBTX93MNvy?=
 =?us-ascii?Q?X4QsiehU2ATqBzC/wrNTI3ZVEgn1dCQxJMLW5btHRmcjw4Ui783NHbaEDReL?=
 =?us-ascii?Q?KNeHn2mpDNywBzuFwZSnyp9Cr4xSH/6oJ00dslKZ8Q8TfxBynEdmyl7iyAc8?=
 =?us-ascii?Q?tioYUm+7a30/a3pQKWU7DDGVGyqo/wNfeezGrqTCCdkZmHbatS2ysw8aOcFs?=
 =?us-ascii?Q?1BoaBAB7W1JCjgTbB+GNpekUeg6KsKkF/Joy1OYiBCFpSseax2yHGN0L1yCs?=
 =?us-ascii?Q?O5DU9UiBroVAardpPrXlAO9mRk/TkOiVOfhTfp63kr2Ml9nxETgIhdYSx+rJ?=
 =?us-ascii?Q?sbXw3K9TAwu8VBnRJf2/M/elIsL0ISTKg4DYhSMn38UyiIFkEfBFLPDuMs/j?=
 =?us-ascii?Q?R2vTCug/e+lMT2Bdgb+t4BSH22yKO0vRtyOyanjc6AP3w48/C3wt8inXMnvb?=
 =?us-ascii?Q?uQgfQzCFYfJFxdJ5ZnoRoZ1ipBZ0q0T78KCW2c0nMJHaAmT6lVcYDraK+EHC?=
 =?us-ascii?Q?xbPg61gX0MkVfUQr1URRB5ndzhC9n4MNRc3nMw1sAhSSFYDY4eQZZsmLW4f0?=
 =?us-ascii?Q?jJz7mjidg99VGKcY/N3yWK2gfsVsHzZTaIm+D3pljNGCjrVSWQPWBdP4HPm3?=
 =?us-ascii?Q?d/OFQuydrBnOkkcAeQRFM5C6wMeHerKBGtmz67jzSq0PB5AYCcNoMOVPZdYP?=
 =?us-ascii?Q?MMsgv/ENZLYstyZlv8FyVbGwyHaQ+malz6cVPy9GxYJVXCtG0fv0ZrLo8+q7?=
 =?us-ascii?Q?2iJ8v7qMDoFAkDQnS8rhA2bsSPTCQfW8u7O1jJ88UBJ/AKBKdYREzBsrKuKo?=
 =?us-ascii?Q?EVCgO1uo79TkAD85Koe4rL7Y/29MhvuMUcDSRj4PbukN/pY59XWeclxxU+eZ?=
 =?us-ascii?Q?hkkFtnB44yvAuWDySnZ+OrR6pTszbgRo5d+tB5qUDxKc2UTMd3BA6YBqQZim?=
 =?us-ascii?Q?kUQ74QkGJS8QfyPKHkIzaEdCMeKxJM+mJ8S/WQPbsYbeU+fo6ZUdSC1WuTV2?=
 =?us-ascii?Q?tGILseW1LEbsPRr55Pi5tyQ2XaYfqtzWufgPuc4nayJW90N1B3UtCSj3NUMC?=
 =?us-ascii?Q?kN6QHPGsKUJ8SWKs0ovGasT3cs+qjcIsHRj5b5EVW047cRxoskwMgF+5moZr?=
 =?us-ascii?Q?eTEB6RX0yC6PlZjnsHMnV9lzzlkxE/FWgPtWuyKkrIcL3iWFOEu6Sc38Wzjy?=
 =?us-ascii?Q?YigT/f9JI91OFduZDw9n7QCpow4P4t3QBjR9PbdYqyXmIuLmVNBJHuJaFF/4?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcba5f3-6da5-44f4-6574-08dc233846c7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:12:59.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebCu+5TVCuoU+pe9HN2QZqoV2xFFh7EUDL7xtVo3m2ysb9qQLnk9aDO/5KAW8QxAk3Nx4wJjRZL5hYD3duk4/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5247
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_fs/ext4/inode.c" on:

commit: 06094684ce207c4f2ce3f0d0f541361158579818 ("[PATCH 3/3] ext4: Convert to buffered_write_operations")
url: https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Introduce-buffered_write_operations/20240130-135555
base: https://github.com/kleikamp/linux-shaggy jfs-next
patch link: https://lore.kernel.org/all/20240130055414.2143959-4-willy@infradead.org/
patch subject: [PATCH 3/3] ext4: Convert to buffered_write_operations

in testcase: fxmark
version: fxmark-x86_64-0ce9491-1_20220601
with following parameters:

	disk: 1SSD
	media: ssd
	test: DWAL
	fstype: ext4_no_jnl
	directio: bufferedio
	cpufreq_governor: performance



compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402012226.578a5c20-oliver.sang@intel.com


[   68.790992][ T6736] ------------[ cut here ]------------
[   68.790993][ T6738] ------------[ cut here ]------------
[   68.790995][ T6738] kernel BUG at fs/ext4/inode.c:1385!
[   68.790998][ T6824] ------------[ cut here ]------------
[   68.791001][ T6680] ------------[ cut here ]------------
[   68.791001][ T6738] invalid opcode: 0000 [#1] SMP NOPTI
[   68.791003][ T6680] kernel BUG at fs/ext4/inode.c:1385!
[   68.791004][ T6738] CPU: 31 PID: 6738 Comm: fxmark Tainted: G S                 6.8.0-rc2-00004-g06094684ce20 #1
[   68.791006][ T6738] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[ 68.791007][ T6738] RIP: 0010:ext4_journalled_write_end (fs/ext4/inode.c:1385) 
[ 68.791014][ T6738] Code: 48 8b 05 c1 5e bf 01 48 85 c0 74 11 48 8b 78 08 48 8b 54 24 10 48 89 de e8 d3 36 02 00 48 81 fd ff 0f 00 00 0f 87 25 fe ff ff <0f> 0b 66 83 bb f2 02 00 00 00 0f 84 27 fe ff ff 4c 8b 44 24 18 48
All code
========
   0:	48 8b 05 c1 5e bf 01 	mov    0x1bf5ec1(%rip),%rax        # 0x1bf5ec8
   7:	48 85 c0             	test   %rax,%rax
   a:	74 11                	je     0x1d
   c:	48 8b 78 08          	mov    0x8(%rax),%rdi
  10:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  15:	48 89 de             	mov    %rbx,%rsi
  18:	e8 d3 36 02 00       	callq  0x236f0
  1d:	48 81 fd ff 0f 00 00 	cmp    $0xfff,%rbp
  24:	0f 87 25 fe ff ff    	ja     0xfffffffffffffe4f
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	66 83 bb f2 02 00 00 	cmpw   $0x0,0x2f2(%rbx)
  33:	00 
  34:	0f 84 27 fe ff ff    	je     0xfffffffffffffe61
  3a:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	66 83 bb f2 02 00 00 	cmpw   $0x0,0x2f2(%rbx)
   9:	00 
   a:	0f 84 27 fe ff ff    	je     0xfffffffffffffe37
  10:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
  15:	48                   	rex.W
[   68.791016][ T6738] RSP: 0018:ffa000000d65fd28 EFLAGS: 00010293
[   68.791019][ T6738] RAX: 0000000000000000 RBX: ff1100011001d870 RCX: 0000000000001000
[   68.791020][ T6738] RDX: 0000000000000000 RSI: ff1100011001d9e8 RDI: ff110001088edf00
[   68.791021][ T6738] RBP: 0000000000000001 R08: 0000000000001000 R09: ffd4000006a4ac00
[   68.791022][ T6738] R10: ff110001097e0548 R11: ffd4000006a4ac00 R12: 0000000000001000
[   68.791023][ T6738] R13: 0000000000001000 R14: ffffffff8245b350 R15: ffa000000d65fe68
[   68.791023][ T6738] FS:  00007f540d431600(0000) GS:ff1100103f9c0000(0000) knlGS:0000000000000000
[   68.791025][ T6738] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   68.791026][ T6738] CR2: 000055b84bf3f000 CR3: 00000001e7bd0002 CR4: 0000000000771ef0
[   68.791027][ T6738] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   68.791027][ T6738] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   68.791028][ T6738] PKRU: 55555554
[   68.791029][ T6738] Call Trace:
[   68.791029][ T6853] ------------[ cut here ]------------
[   68.791031][ T6738]  <TASK>
[   68.791031][ T6853] kernel BUG at fs/ext4/inode.c:1385!
[ 68.791033][ T6738] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 68.791038][ T6738] ? do_trap (arch/x86/kernel/traps.c:113 arch/x86/kernel/traps.c:154) 
[   68.791040][ T6820] ------------[ cut here ]------------
[ 68.791040][ T6738] ? ext4_journalled_write_end (fs/ext4/inode.c:1385) 
[   68.791041][ T6820] kernel BUG at fs/ext4/inode.c:1385!
[ 68.791043][ T6738] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:175) 
[   68.791044][ T6823] ------------[ cut here ]------------
[   68.791045][ T6674] ------------[ cut here ]------------
[ 68.791045][ T6738] ? ext4_journalled_write_end (fs/ext4/inode.c:1385) 
[   68.791047][ T6755] ------------[ cut here ]------------
[   68.791047][ T6823] kernel BUG at fs/ext4/inode.c:1385!
[   68.791048][ T6674] kernel BUG at fs/ext4/inode.c:1385!
[   68.791049][ T6755] kernel BUG at fs/ext4/inode.c:1385!
[ 68.791048][ T6738] ? exc_invalid_op (arch/x86/kernel/traps.c:266) 
[ 68.791053][ T6738] ? ext4_journalled_write_end (fs/ext4/inode.c:1385) 
[   68.791054][ T6793] ------------[ cut here ]------------
[   68.791056][ T6763] ------------[ cut here ]------------
[   68.791056][ T6793] kernel BUG at fs/ext4/inode.c:1385!
[   68.791057][ T6763] kernel BUG at fs/ext4/inode.c:1385!
[   68.791059][ T6669] ------------[ cut here ]------------
[ 68.791055][ T6738] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[   68.791061][ T6669] kernel BUG at fs/ext4/inode.c:1385!
[ 68.791062][ T6738] ? ext4_journalled_write_end (fs/ext4/inode.c:1385) 
[   68.791063][ T6774] ------------[ cut here ]------------
[   68.791064][ T6774] kernel BUG at fs/ext4/inode.c:1385!
[ 68.791065][ T6738] filemap_perform_write (mm/filemap.c:3951) 
[   68.791068][ T6765] ------------[ cut here ]------------
[   68.791070][ T6765] kernel BUG at fs/ext4/inode.c:1385!
[   68.791072][ T6777] ------------[ cut here ]------------
[   68.791072][ T6809] ------------[ cut here ]------------
[   68.791073][ T6777] kernel BUG at fs/ext4/inode.c:1385!
[ 68.791070][ T6738] ? generic_update_time (fs/inode.c:1907) 
[   68.791073][ T6809] kernel BUG at fs/ext4/inode.c:1385!
[   68.791074][ T6828] ------------[ cut here ]------------
[   68.791076][ T6841] ------------[ cut here ]------------
[   68.791076][ T6671] ------------[ cut here ]------------
[   68.791077][ T6828] kernel BUG at fs/ext4/inode.c:1385!
[   68.791077][ T6841] kernel BUG at fs/ext4/inode.c:1385!
[   68.791078][ T6786] ------------[ cut here ]------------
[ 68.791078][ T6738] ext4_buffered_write_iter (include/linux/fs.h:807 fs/ext4/file.c:310) 
[   68.791081][ T6786] kernel BUG at fs/ext4/inode.c:1385!
[   68.791081][ T6671] kernel BUG at fs/ext4/inode.c:1385!
[ 68.791082][ T6738] vfs_write (include/linux/fs.h:2085 fs/read_write.c:497 fs/read_write.c:590) 
[ 68.791086][ T6738] ksys_write (fs/read_write.c:643) 
[   68.791087][ T6807] ------------[ cut here ]------------
[   68.791088][ T6807] kernel BUG at fs/ext4/inode.c:1385!
[ 68.791089][ T6738] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[   68.791093][ T6737] ------------[ cut here ]------------
[   68.791094][ T6804] ------------[ cut here ]------------
[   68.791094][ T6737] kernel BUG at fs/ext4/inode.c:1385!
[   68.791094][ T6705] ------------[ cut here ]------------
[ 68.791094][ T6738] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[   68.791098][ T6738] RIP: 0033:0x7f540d33a473
[   68.791100][ T6804] kernel BUG at fs/ext4/inode.c:1385!
[ 68.791100][ T6738] Code: 8b 15 21 2a 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
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
[   68.791103][ T6738] RSP: 002b:00007ffe5f9adbb8 EFLAGS: 00000246
[   68.791103][ T6684] ------------[ cut here ]------------
[   68.791105][ T6738]  ORIG_RAX: 0000000000000001
[   68.791105][ T6684] kernel BUG at fs/ext4/inode.c:1385!
[   68.791106][ T6738] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f540d33a473
[   68.791106][ T6705] kernel BUG at fs/ext4/inode.c:1385!
[   68.791107][ T6738] RDX: 0000000000001000 RSI: 000055b84bf3f000 RDI: 0000000000000003
[   68.791109][ T6738] RBP: 00007f540d424000 R08: 000055b84bf3f000 R09: 00007f540d41dbe0
[   68.791109][ T6700] ------------[ cut here ]------------
[   68.791110][ T6738] R10: fffffffffffffa2e R11: 0000000000000246 R12: 000055b84bf3f000
[   68.791110][ T6700] kernel BUG at fs/ext4/inode.c:1385!
[   68.791111][ T6738] R13: 0000000000000003 R14: 00007f540d42dfc0 R15: 0000000000000000
[   68.791113][ T6738]  </TASK>
[   68.791114][ T6738] Modules linked in: loop btrfs blake2b_generic xor
[   68.791117][ T6718] ------------[ cut here ]------------
[   68.791118][ T6673] ------------[ cut here ]------------
[   68.791118][ T6688] ------------[ cut here ]------------
[   68.791118][ T6738]  raid6_pq
[   68.791120][ T6718] kernel BUG at fs/ext4/inode.c:1385!
[   68.791121][ T6673] kernel BUG at fs/ext4/inode.c:1385!
[   68.791122][ T6688] kernel BUG at fs/ext4/inode.c:1385!
[   68.791122][ T6738]  libcrc32c sd_mod t10_pi
[   68.791126][ T6715] ------------[ cut here ]------------
[   68.791126][ T6850] ------------[ cut here ]------------
[   68.791126][ T6738]  crc64_rocksoft_generic
[   68.791127][ T6715] kernel BUG at fs/ext4/inode.c:1385!
[   68.791129][ T6738]  crc64_rocksoft
[   68.791129][ T6850] kernel BUG at fs/ext4/inode.c:1385!
[   68.791131][ T6822] ------------[ cut here ]------------
[   68.791131][ T6738]  crc64
[   68.791133][ T6799] ------------[ cut here ]------------
[   68.791134][ T6738]  sg
[   68.791134][ T6822] kernel BUG at fs/ext4/inode.c:1385!
[   68.791136][ T6799] kernel BUG at fs/ext4/inode.c:1385!
[   68.791137][ T6738]  intel_rapl_msr
[   68.791138][ T6805] ------------[ cut here ]------------
[   68.791140][ T6738]  intel_rapl_common
[   68.791140][ T6805] kernel BUG at fs/ext4/inode.c:1385!
[   68.791142][ T6738]  x86_pkg_temp_thermal
[   68.791143][ T6761] ------------[ cut here ]------------
[   68.791144][ T6738]  intel_powerclamp
[   68.791145][ T6761] kernel BUG at fs/ext4/inode.c:1385!
[   68.791147][ T6738]  coretemp
[   68.791147][ T6692] ------------[ cut here ]------------
[   68.791149][ T6738]  kvm_intel kvm
[   68.791150][ T6692] kernel BUG at fs/ext4/inode.c:1385!
[   68.791151][ T6710] ------------[ cut here ]------------
[   68.791152][ T6722] ------------[ cut here ]------------
[   68.791151][ T6738]  irqbypass
[   68.791154][ T6710] kernel BUG at fs/ext4/inode.c:1385!
[   68.791155][ T6738]  crct10dif_pclmul
[   68.791155][ T6722] kernel BUG at fs/ext4/inode.c:1385!
[   68.791158][ T6738]  crc32_pclmul crc32c_intel
[   68.791160][ T6780] ------------[ cut here ]------------
[   68.791161][ T6716] ------------[ cut here ]------------
[   68.791161][ T6738]  ghash_clmulni_intel
[   68.791162][ T6685] ------------[ cut here ]------------
[   68.791163][ T6767] ------------[ cut here ]------------
[   68.791163][ T6780] kernel BUG at fs/ext4/inode.c:1385!
[   68.791164][ T6732] ------------[ cut here ]------------
[   68.791165][ T6738]  ipmi_ssif
[   68.791165][ T6857] ------------[ cut here ]------------
[   68.791165][ T6672] ------------[ cut here ]------------
[   68.791165][ T6716] kernel BUG at fs/ext4/inode.c:1385!
[   68.791166][ T6811] ------------[ cut here ]------------
[   68.791166][ T6689] ------------[ cut here ]------------
[   68.791165][ T6795] ------------[ cut here ]------------
[   68.791167][ T6816] ------------[ cut here ]------------
[   68.791165][ T6677] ------------[ cut here ]------------
[   68.791168][ T6667] ------------[ cut here ]------------
[   68.791169][ T6732] kernel BUG at fs/ext4/inode.c:1385!
[   68.791170][ T6746] ------------[ cut here ]------------
[   68.791170][ T6757] ------------[ cut here ]------------
[   68.791171][ T6845] ------------[ cut here ]------------
[   68.791170][ T6848] ------------[ cut here ]------------
[   68.791172][ T6749] ------------[ cut here ]------------
[   68.791173][ T6670] ------------[ cut here ]------------
[   68.791172][ T6816] kernel BUG at fs/ext4/inode.c:1385!
[   68.791173][ T6790] ------------[ cut here ]------------
[   68.791174][ T6751] ------------[ cut here ]------------
[   68.791172][ T6753] ------------[ cut here ]------------
[   68.791172][ T6758] ------------[ cut here ]------------
[   68.791174][ T6682] ------------[ cut here ]------------
[   68.791174][ T6760] ------------[ cut here ]------------
[   68.791175][ T6746] kernel BUG at fs/ext4/inode.c:1385!
[   68.791171][ T6725] ------------[ cut here ]------------
[   68.791172][ T6839] ------------[ cut here ]------------
[   68.791173][ T6696] ------------[ cut here ]------------
[   68.791174][ T6723] ------------[ cut here ]------------
[   68.791172][ T6668] ------------[ cut here ]------------
[   68.791174][ T6833] ------------[ cut here ]------------
[   68.791177][ T6689] kernel BUG at fs/ext4/inode.c:1385!
[   68.791178][ T6848] kernel BUG at fs/ext4/inode.c:1385!
[   68.791179][ T6723] kernel BUG at fs/ext4/inode.c:1385!
[   68.791182][ T6685] kernel BUG at fs/ext4/inode.c:1385!
[   68.791181][ T6725] kernel BUG at fs/ext4/inode.c:1385!
[   68.791182][ T6672] kernel BUG at fs/ext4/inode.c:1385!
[   68.791183][ T6790] kernel BUG at fs/ext4/inode.c:1385!
[   68.791184][ T6749] kernel BUG at fs/ext4/inode.c:1385!
[   68.791186][ T6758] kernel BUG at fs/ext4/inode.c:1385!
[   68.791186][ T6767] kernel BUG at fs/ext4/inode.c:1385!
[   68.791187][ T6795] kernel BUG at fs/ext4/inode.c:1385!
[   68.791189][ T6682] kernel BUG at fs/ext4/inode.c:1385!
[   68.791187][ T6757] kernel BUG at fs/ext4/inode.c:1385!
[   68.791190][ T6670] kernel BUG at fs/ext4/inode.c:1385!
[   68.791191][ T6839] kernel BUG at fs/ext4/inode.c:1385!
[   68.791190][ T6668] kernel BUG at fs/ext4/inode.c:1385!
[   68.791194][ T6751] kernel BUG at fs/ext4/inode.c:1385!
[   68.791195][ T6811] kernel BUG at fs/ext4/inode.c:1385!
[   68.791196][ T6760] kernel BUG at fs/ext4/inode.c:1385!
[   68.791196][ T6753] kernel BUG at fs/ext4/inode.c:1385!
[   68.791197][ T6857] kernel BUG at fs/ext4/inode.c:1385!
[   68.791200][ T6833] kernel BUG at fs/ext4/inode.c:1385!
[   68.791200][ T6667] kernel BUG at fs/ext4/inode.c:1385!
[   68.791201][ T6677] kernel BUG at fs/ext4/inode.c:1385!
[   68.791203][ T6696] kernel BUG at fs/ext4/inode.c:1385!
[   68.791204][ T6738]  sha512_ssse3
[   68.791205][ T6845] kernel BUG at fs/ext4/inode.c:1385!
[   68.791206][ T6738]  rapl
[   68.791210][ T6703] ------------[ cut here ]------------
[   68.791214][ T6738]  ahci
[   68.791214][ T6703] kernel BUG at fs/ext4/inode.c:1385!
[   68.791219][ T6738]  ast intel_cstate acpi_ipmi mei_me libahci drm_shmem_helper ioatdma intel_uncore i2c_i801 ipmi_si dax_hmem libata drm_kms_helper mei joydev i2c_smbus intel_pch_thermal dca wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter drm fuse ip_tables
[   68.791234][ T6680] invalid opcode: 0000 [#2] SMP NOPTI
[   68.791237][ T6680] CPU: 9 PID: 6680 Comm: fxmark Tainted: G S    D            6.8.0-rc2-00004-g06094684ce20 #1
[   68.791239][ T6680] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[   68.791242][ T6738] ---[ end trace 0000000000000000 ]---
[ 68.791240][ T6680] RIP: 0010:ext4_journalled_write_end (fs/ext4/inode.c:1385) 
[ 68.791244][ T6680] Code: 48 8b 05 c1 5e bf 01 48 85 c0 74 11 48 8b 78 08 48 8b 54 24 10 48 89 de e8 d3 36 02 00 48 81 fd ff 0f 00 00 0f 87 25 fe ff ff <0f> 0b 66 83 bb f2 02 00 00 00 0f 84 27 fe ff ff 4c 8b 44 24 18 48
All code
========
   0:	48 8b 05 c1 5e bf 01 	mov    0x1bf5ec1(%rip),%rax        # 0x1bf5ec8
   7:	48 85 c0             	test   %rax,%rax
   a:	74 11                	je     0x1d
   c:	48 8b 78 08          	mov    0x8(%rax),%rdi
  10:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  15:	48 89 de             	mov    %rbx,%rsi
  18:	e8 d3 36 02 00       	callq  0x236f0
  1d:	48 81 fd ff 0f 00 00 	cmp    $0xfff,%rbp
  24:	0f 87 25 fe ff ff    	ja     0xfffffffffffffe4f
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	66 83 bb f2 02 00 00 	cmpw   $0x0,0x2f2(%rbx)
  33:	00 
  34:	0f 84 27 fe ff ff    	je     0xfffffffffffffe61
  3a:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	66 83 bb f2 02 00 00 	cmpw   $0x0,0x2f2(%rbx)
   9:	00 
   a:	0f 84 27 fe ff ff    	je     0xfffffffffffffe37
  10:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240201/202402012226.578a5c20-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


