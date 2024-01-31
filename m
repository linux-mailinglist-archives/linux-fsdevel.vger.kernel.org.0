Return-Path: <linux-fsdevel+bounces-9656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311EB84418E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CC71C260F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB0D83CB7;
	Wed, 31 Jan 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkcD6JPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3183CA6;
	Wed, 31 Jan 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710418; cv=fail; b=dwiPhc5pbm06bR32G5Ahpgm2n1jujR3J4YVI0aJX0ZRAOudfIZn2sVtUq/zZIqnwVwZpoq7TArN/0GQg5pej2w9XdoG6hTxaNfQB1WlfHY21Br3/2Gp3PeFPW4IWbNlnn52OqlQYDH503yE3RwHk20miRD51Zd7GaNTOv7pXKB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710418; c=relaxed/simple;
	bh=FxFpLCsVOLcmHV0BkeQLtHRTlwjUKypEN8BU1K+YHXU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=OJzUPDzEiJ1hAgsUhYwVG0wasLpfXRZzIjH8I/wre2diWDatQ4XXOXAK6mbvNFdFvOuN/OcBC2MWXWAJ905DfvbAKd2cq24tDbmFUwDgda7OmznGOIheUAYy5qt9tD62V1C6g1xz9NtOjWK4glUnK2Mk47h2bvuiFpXJmQ2NJPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkcD6JPT; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706710416; x=1738246416;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=FxFpLCsVOLcmHV0BkeQLtHRTlwjUKypEN8BU1K+YHXU=;
  b=GkcD6JPT/lEZ99o2kjft9BfaH2jN7PqJokaIQV3YX508ArAIjuHDA35i
   Sktcg4lHHyp1wOMShcXw83GKFQHkZOCaSOZE2rVBK3Xccyw+uQVyQcZ2r
   ewAd22nKTtiQ8MzxTQpY5xYTAsw046wkRWuwZGU8hkVhD5eGTbhfe/NMv
   dyAAF68bLkepeD5eBICehQdmTPXnnqMgjPgQUFFwPXO+BEWzAPNJllWgn
   G/TiEhlrXBor9xBOXX/vfkLu3U3fE3KpYtst8pbEwM2DFENjeKm9vSNx4
   5A0oI5f6hs78Zl37o1VyR5j8phPAhlHCmER/5AcBeKRq+k+cGaqFAJN1R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403231687"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="403231687"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="931854665"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="931854665"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 06:13:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 06:13:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 06:13:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 06:13:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKzOBBSnVhFl1WW9xLs59V/k7QQdGCox/F7P/rrIyYfpIAncQLARhYTloc0D3DaWbASocJ432ZNJazB8McXxy2AdhvupCnmbokH4pfG89gdWDW2Y4Al0f3u1qzEqWTnKbWt2AJ9LqYYh62VvKUllCjuE1Pjebl3xuP/vnxQK8TufFpoGWHjxTfx6d2hrynV5ShkB5OMcxjUDtZcGlrHOQk3rQ1WGPitO1Sx09QGHh5wDhcYplZxCkNs8AZqSaLdraac+y3TqIpjvHn5QzlB2DdJGsSvmEOueP71McQjuT2PTrMdWCD79pfO/AnK1wcJznSiISuFvEbTh4DAiPXliyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUQthj4n7Ysa9+OREWAfEa0XyJibRV9pGPyNWqLK6f4=;
 b=m0T6wi7ro2V1f58GbwmaIQCq2+WNApdFVa4nViaCaZrkRFoF/06h1fVAXOUNtG4ZwszzvqUraWsBLfwL00X7DpyIXyl3F6EBAPWW/LSkttb+/TIBr6OCYS+XHXYD90UYrwnRNUnLe1b8c08oI2d/eio9Vwpfaq/Adq11dywf759+o7fGgAy2SNXx8ig5qC75+oI3NNYoJ1y+lx+FHCBpirMUY5B1aI9J4LD3b56cXpA2PKfG9pcrXCTCI89PSrs6mdlFHXyjJvbQkJzjDzQam7tPKFq/NjPOeqj4lKPx8W/mmVO4dB1eVrHB32NHPdD4ICZTEIfjAEwpggbUaVVC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7310.namprd11.prod.outlook.com (2603:10b6:8:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 14:13:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 14:13:26 +0000
Date: Wed, 31 Jan 2024 22:13:16 +0800
From: kenel test robot <oliver.sang@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [remap_range]  dfad37051a:
 stress-ng.file-ioctl.ops_per_sec -11.2% regression
Message-ID: <202401312229.eddeb9a6-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b06c13-6079-4c98-ed93-08dc2266ca81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZpR4RRhg6MbAzfjuECtFxdjS2of2USXz3vHJUhU7YieUgvOmgYU5g3aCmdNZKHlH+ic4l8E4g4X6PSuFE6yYMXmxFpoqB4+8r1qSot1lB/jCMayJ2mgk/LR6LCd0ENa9/v3lEOPB9k3G2OnR/tpqh3PD7o3zsK8OExOA0uKnZbgt1l290A1aZNOczqg0WiJtrAeSfJWmLLePbsbUvtF57mJCH4wo7oZSLPk1sAL3XI1Emi1lGGX7sOIm5WKDl3jgA///KmzGj3uNCRhh2YAVzb9pcCSX+8F1PSyk763ObWE+UXfKibmk6jFsUnf3M3CMYbF6fmzUkrW8riuigDNj0L0XCKi7sQKw6G7AqKIEwROf1WgkQndezGpTytGoN5zth2MRsE2worrqAH/ld3S2ACTQufC1m/5PwWMTu9XmsISjuCQPG6Y0/2PTdxDUFS6Hot7pWonRTLvlpyaxEn+ELUZ6z1hOzpVuFH7NUyBnqYaUiD8sDVymlrLrMbpqprGRsHpVnxdNDZSgKGbr7J/LCi3nWx3/xVAERw2RISGuxrJouT5Zi/FURByrVy93FcPn6qwjPnSqQ55PYLrs1vyaGeLxil1hnnaELqEVBSZWgZ8XCUoiufA5+G3EvBMnAhWacYjsBfk2zZwIogBtFvsXsYH9rJb82urLBAIS5ylHBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230373577357003)(230922051799003)(230473577357003)(451199024)(64100799003)(1800799012)(186009)(1076003)(2616005)(26005)(966005)(107886003)(41300700001)(6486002)(316002)(6916009)(36756003)(478600001)(6506007)(83380400001)(6666004)(38100700002)(6512007)(82960400001)(54906003)(5660300002)(86362001)(2906002)(30864003)(66476007)(66556008)(66946007)(8936002)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Jen5QQEUj8M7YsGbTB0kmovauMd96gc4uxqhjAp9TYdu9mASHGRLJZu2li?=
 =?iso-8859-1?Q?6KhQhxVABic4Eez6+0KeTDIeIV0+vgfrYyawmrnLPimZlL3Tyu7j4y0kwq?=
 =?iso-8859-1?Q?MHAbv3cJiWClnbWbcFsFoNcfI7Pa7fiF9kEG1yjErKYSPYZohdWUag4dnk?=
 =?iso-8859-1?Q?21OeNPiXeZ2Rw6mIKUUZveV+r6zJ27Zq2hYHv3tFehHbO5LPMcQKPccO10?=
 =?iso-8859-1?Q?aVzR9MSC8969VEMHlCrPJE/AXdqTtn4lzVpOK5Ch+lfR5q9QbK8T1oT+rG?=
 =?iso-8859-1?Q?BMfZkDpXX4LwmrbtNac6h+X9Qyje/ElSjblfdE8GMS0DBqRFQmk++JfSFJ?=
 =?iso-8859-1?Q?u0dLHbxrH3ZO4D2AMBl+E0WUgSd06WhM4qVGwPZut2EDn4zfJwLpUW5ELP?=
 =?iso-8859-1?Q?ddrvVYiqHxPzCcRBIb96EtHUVa5ZNLbVLHXiCEYgO56i+Eq+DEKDQv5Tdy?=
 =?iso-8859-1?Q?q7s/bidb4dxQbwd468QeONOyN7wGauDi70XW8015KcQmXQXS/ZmB9V1Dxh?=
 =?iso-8859-1?Q?7FEqjssfZKAC7p2iMUUcj1mvyCQCD+2MYOHuo/UG5fyjBZQIoYdENu0ilO?=
 =?iso-8859-1?Q?36ryudnwiJocxeY7fjUq2YciNvUskIyE0iHRsXy3xdrRpGBgFvjThXLgfA?=
 =?iso-8859-1?Q?k6nJi/89SZrpUzklBhWylF2SQYCiECB754hJHEUqTVsEapyVaqG51e15va?=
 =?iso-8859-1?Q?4m2ltymM/nROWtXEneJKjKtrekS30MGjG8Csrj7wrXIUDrrgggc4AcXUJF?=
 =?iso-8859-1?Q?bVj62LcvWaQC2obt6vAtnWAIk13wRJcV5wdcFtPaMsff+r8QKVP6vSHHrk?=
 =?iso-8859-1?Q?T5Qv0wQKBNGMhPAcs5wsyjukOkObg0R3gk4OYhWmlzY2TlASUw7/aMCiY+?=
 =?iso-8859-1?Q?y6RCLvAXPbE+oiNDVjoDyHV2kkALNWKucvbR5lfnDhlE0Gzl+l3/1Y73pY?=
 =?iso-8859-1?Q?cPtvywK2q8mB9GYTFcJDE/bhfcZz2tiJuWZYxo7DcaWp+MLfUR15/utIfB?=
 =?iso-8859-1?Q?XQt3qtGFsir1FkuHZUp6Sy8o0eJBIDWrNrSN4Gvs4V8Hl6Ce7wLcjqGypS?=
 =?iso-8859-1?Q?TZUcnZuQjGmeidM3z1PFLeUtI845RqQonCyP6ZdnpUonD+uDLUJlkpjIuW?=
 =?iso-8859-1?Q?us9uPf31L2FrPBKxAo3/NsBwWFKcdDy8xIhav8DBU0yjf9I+UUaWdImwLY?=
 =?iso-8859-1?Q?ACcrAUTn29nKKctN8zgXecvL1OOobSXi5vY6xK813tvcl6Kdcpv0vVjTeg?=
 =?iso-8859-1?Q?PwB1U5GznAwELDPLers1UxE0tsG6kDpahbmdtbO6m14Cvrv5Nw+4nXHFT7?=
 =?iso-8859-1?Q?FLjx8M9w3hgTTM0SEkML+LUB2XbhqYPpNtDCJ9JIbi3WdM3AvMxQ8b08ZL?=
 =?iso-8859-1?Q?2MhrqS32qAPC34+PPW4sjtLTND4WwWF7HvqEzZhChE0zHSSBrfM4l7F1IN?=
 =?iso-8859-1?Q?9v6iNdB9YpNGZSN0ihOH92/kNERTPUBE4rsEikWRXVcLAoKBSHBGnaQUbB?=
 =?iso-8859-1?Q?UxnUTrQk9iPL3N9P4HwbUD3B7QV/3Ojfezm5UmLXUE/8Abp0rWqQhxu//+?=
 =?iso-8859-1?Q?CelJNKj2Nw0+BIZ2VNf5acOv9RMjW6dtR5ulIgipmE0HeOQpnu/bIEeXcm?=
 =?iso-8859-1?Q?rK5Dm3fpWugjC5zzMToF6WiKQxd0wv/eOdbqkTAQXLzrqpir/xu7Vofg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b06c13-6079-4c98-ed93-08dc2266ca81
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:13:26.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tM/C+/bNYqtQhR2eamOIg/Pm0m1FClmEMGTR+f1Z1SYLgjDnBaBqDjMVR4rk4rQ8aizz+0xVv8bXRa+v75lLVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7310
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -11.2% regression of stress-ng.file-ioctl.ops_per_sec on:


commit: dfad37051ade6ac0d404ef4913f3bd01954ee51c ("remap_range: move permission hooks out of do_clone_file_range()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: file-ioctl
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401312229.eddeb9a6-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240131/202401312229.eddeb9a6-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/file-ioctl/stress-ng/60s

commit: 
  d53471ba6f ("splice: remove permission hook from iter_file_splice_write()")
  dfad37051a ("remap_range: move permission hooks out of do_clone_file_range()")

d53471ba6f7ae97a dfad37051ade6ac0d404ef4913f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.57            -0.3        2.27        mpstat.cpu.all.usr%
      7.40            +3.4%       7.65        iostat.cpu.system
      2.50           -11.5%       2.22        iostat.cpu.user
  95739218           -11.2%   84990543 ±  2%  stress-ng.file-ioctl.ops
   1595650           -11.2%    1416506 ±  2%  stress-ng.file-ioctl.ops_per_sec
    267.41            +4.2%     278.66        stress-ng.time.system_time
     90.19           -12.5%      78.96        stress-ng.time.user_time
      0.12 ±  9%     +37.6%       0.16 ±  3%  perf-stat.i.MPKI
 5.619e+09            -4.9%  5.346e+09        perf-stat.i.branch-instructions
     25.26 ± 12%      +5.4       30.67 ±  2%  perf-stat.i.cache-miss-rate%
   3226271 ±  8%     +32.3%    4268159 ±  2%  perf-stat.i.cache-misses
  13880671 ±  2%      +7.6%   14934433        perf-stat.i.cache-references
      0.83            +3.9%       0.86        perf-stat.i.cpi
      7405 ±  8%     -26.1%       5473 ±  2%  perf-stat.i.cycles-between-cache-misses
 5.186e+09            -6.0%  4.873e+09        perf-stat.i.dTLB-stores
 2.807e+10            -3.9%  2.696e+10        perf-stat.i.instructions
      1.21            -3.7%       1.17        perf-stat.i.ipc
    257.16           +12.9%     290.46        perf-stat.i.metric.K/sec
    290.80            -4.2%     278.45        perf-stat.i.metric.M/sec
   1580051 ± 11%     +38.0%    2180479 ±  5%  perf-stat.i.node-load-misses
    228848 ± 22%    +116.2%     494834 ± 27%  perf-stat.i.node-loads
      0.11 ±  9%     +37.7%       0.16 ±  3%  perf-stat.overall.MPKI
     23.29 ± 11%      +5.3       28.58 ±  2%  perf-stat.overall.cache-miss-rate%
      0.82            +3.9%       0.86        perf-stat.overall.cpi
      7231 ±  8%     -25.1%       5416 ±  2%  perf-stat.overall.cycles-between-cache-misses
      1.21            -3.7%       1.17        perf-stat.overall.ipc
 5.524e+09            -4.8%  5.257e+09        perf-stat.ps.branch-instructions
   3170718 ±  8%     +32.4%    4196610 ±  2%  perf-stat.ps.cache-misses
  13646445 ±  2%      +7.6%   14686495 ±  2%  perf-stat.ps.cache-references
 5.099e+09            -6.0%  4.792e+09        perf-stat.ps.dTLB-stores
 2.759e+10            -3.9%  2.651e+10        perf-stat.ps.instructions
   1553350 ± 11%     +38.1%    2144498 ±  5%  perf-stat.ps.node-load-misses
    224907 ± 22%    +116.2%     486304 ± 27%  perf-stat.ps.node-loads
 1.668e+12            -3.4%  1.611e+12 ±  2%  perf-stat.total.instructions
      5.57 ±  3%      -0.7        4.85 ±  2%  perf-profile.calltrace.cycles-pp.__fget_light.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.89 ± 23%      -0.4        0.45 ± 44%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      2.30 ±  2%      -0.3        2.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.69 ±  3%      -0.3        1.39 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
      1.99 ±  2%      -0.3        1.72        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.16 ±  3%      -0.2        1.00 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ±  4%      -0.2        0.44 ± 45%  perf-profile.calltrace.cycles-pp.__fget_light.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.5        1.52 ±  2%  perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
      0.00            +6.9        6.94 ±  6%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl
      0.00            +7.4        7.41 ±  6%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
     21.11            +7.4       28.53        perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      3.18 ±  2%      +8.7       11.87 ±  3%  perf-profile.calltrace.cycles-pp.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46 ±  9%      +8.9       10.36 ±  4%  perf-profile.calltrace.cycles-pp.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
     10.70            -1.3        9.39 ±  3%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     11.31            -1.1       10.24 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      7.87 ±  3%      -1.0        6.90        perf-profile.children.cycles-pp.__fget_light
      5.13            -0.7        4.46 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.89            -0.4        0.46 ±  5%  perf-profile.children.cycles-pp.do_clone_file_range
      3.45 ±  2%      -0.4        3.10        perf-profile.children.cycles-pp.llseek
      1.80 ±  4%      -0.3        1.49 ±  3%  perf-profile.children.cycles-pp.stress_file_ioctl
      1.83            -0.2        1.63 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.53 ±  3%      -0.2        1.34 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      2.32 ±  3%      -0.2        2.13        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.58 ±  2%      -0.2        1.40        perf-profile.children.cycles-pp.memdup_user
      1.81            -0.2        1.62        perf-profile.children.cycles-pp.__get_user_4
      1.26 ±  3%      -0.2        1.08 ±  3%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      1.32 ±  2%      -0.2        1.14 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      2.06 ±  2%      -0.2        1.90 ±  3%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      1.12 ±  3%      -0.1        0.99 ±  2%  perf-profile.children.cycles-pp.security_file_ioctl
      0.84 ±  3%      -0.1        0.73 ±  3%  perf-profile.children.cycles-pp.ksys_lseek
      0.29 ±  4%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.generic_file_rw_checks
      0.76 ±  3%      -0.1        0.68        perf-profile.children.cycles-pp.amd_clear_divider
      0.84 ±  3%      -0.1        0.75 ±  3%  perf-profile.children.cycles-pp.__put_user_4
      0.86 ±  4%      -0.1        0.78 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.53 ±  3%      -0.1        0.46 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      0.19 ± 11%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.stress_mwc8
      0.54 ±  5%      -0.1        0.48 ±  6%  perf-profile.children.cycles-pp.__check_object_size
      0.73 ±  2%      -0.1        0.67 ±  5%  perf-profile.children.cycles-pp.__fdget
      0.49 ±  2%      -0.1        0.43 ±  3%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      0.51 ±  4%      -0.1        0.45 ±  5%  perf-profile.children.cycles-pp.ioctl@plt
      0.58 ±  3%      -0.0        0.54 ±  4%  perf-profile.children.cycles-pp.__get_user_2
      0.38 ±  3%      -0.0        0.33 ±  4%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.44 ±  3%      -0.0        0.40 ±  3%  perf-profile.children.cycles-pp.__libc_fcntl64
      0.24 ±  6%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.do_fcntl
      0.48 ±  3%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.set_close_on_exec
      0.16 ±  8%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.__check_heap_object
      0.00            +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.fsnotify_perm
      0.57            +0.6        1.15 ±  3%  perf-profile.children.cycles-pp.aa_file_perm
     85.52            +1.4       86.91        perf-profile.children.cycles-pp.ioctl
      0.00            +1.6        1.55        perf-profile.children.cycles-pp.__fsnotify_parent
     62.60            +4.0       66.55        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     59.77            +4.3       64.05        perf-profile.children.cycles-pp.do_syscall_64
     47.98            +5.7       53.66        perf-profile.children.cycles-pp.__x64_sys_ioctl
     21.64            +7.3       28.98        perf-profile.children.cycles-pp.do_vfs_ioctl
      8.29 ±  4%      +7.4       15.74 ±  6%  perf-profile.children.cycles-pp.apparmor_file_permission
      8.78 ±  4%      +7.9       16.64 ±  5%  perf-profile.children.cycles-pp.security_file_permission
      3.30 ±  2%      +8.7       11.96 ±  3%  perf-profile.children.cycles-pp.ioctl_file_clone
      1.68            +8.9       10.55 ±  3%  perf-profile.children.cycles-pp.vfs_clone_file_range
     10.33            -1.3        9.02 ±  3%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
     11.15            -1.2        9.92 ±  2%  perf-profile.self.cycles-pp.ioctl
      7.55 ±  3%      -0.9        6.61        perf-profile.self.cycles-pp.__fget_light
      3.16 ±  4%      -0.5        2.69 ±  2%  perf-profile.self.cycles-pp.do_vfs_ioctl
      2.95 ±  2%      -0.4        2.55 ±  2%  perf-profile.self.cycles-pp.__x64_sys_ioctl
      3.32            -0.4        2.93 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      3.08 ±  2%      -0.4        2.72 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.13            -0.4        2.78 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.39 ±  2%      -0.3        2.10 ±  2%  perf-profile.self.cycles-pp.ioctl_preallocate
      0.57 ±  2%      -0.3        0.31 ±  9%  perf-profile.self.cycles-pp.do_clone_file_range
      2.02 ±  2%      -0.3        1.77 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.54 ±  4%      -0.2        1.29 ±  3%  perf-profile.self.cycles-pp.stress_file_ioctl
      1.83            -0.2        1.62 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      2.32 ±  3%      -0.2        2.13        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.77            -0.2        1.58        perf-profile.self.cycles-pp.__get_user_4
      1.28 ±  2%      -0.2        1.11 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      1.76 ±  2%      -0.1        1.62 ±  3%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.25 ±  6%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.generic_file_rw_checks
      0.48 ±  2%      -0.1        0.38 ±  4%  perf-profile.self.cycles-pp.ioctl_file_clone
      0.79 ±  3%      -0.1        0.70 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.81 ±  3%      -0.1        0.73 ±  4%  perf-profile.self.cycles-pp.__put_user_4
      0.81 ±  5%      -0.1        0.73 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.52 ±  4%      -0.1        0.44 ±  3%  perf-profile.self.cycles-pp.amd_clear_divider
      0.17 ± 11%      -0.1        0.12 ± 10%  perf-profile.self.cycles-pp.stress_mwc8
      0.57 ±  3%      -0.0        0.52 ±  4%  perf-profile.self.cycles-pp.__get_user_2
      0.42 ±  4%      -0.0        0.38 ±  3%  perf-profile.self.cycles-pp.__libc_fcntl64
      0.30 ±  3%      -0.0        0.26 ±  5%  perf-profile.self.cycles-pp.__x64_sys_fcntl
      0.22 ±  5%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.do_fcntl
      0.28 ±  3%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.00            +0.2        0.22 ±  4%  perf-profile.self.cycles-pp.fsnotify_perm
      0.49 ±  3%      +0.4        0.92 ±  2%  perf-profile.self.cycles-pp.security_file_permission
      0.46 ±  2%      +0.5        0.96 ±  2%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +1.5        1.52 ±  2%  perf-profile.self.cycles-pp.__fsnotify_parent
      7.75 ±  4%      +6.8       14.58 ±  7%  perf-profile.self.cycles-pp.apparmor_file_permission




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


