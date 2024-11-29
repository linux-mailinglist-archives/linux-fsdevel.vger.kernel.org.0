Return-Path: <linux-fsdevel+bounces-36157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714F9DE937
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D53EB20EDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019231420DD;
	Fri, 29 Nov 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Asj//xh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9C13D62B
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732893598; cv=fail; b=KH5aXCMpFVViPShotU6e2v5R+INLnz+Pog6c0ELc1GFgJaczUx3bXn4SeuhwwyhtRp8nB6hoVDbgAK1iWqw3zOdrXZegc/QOu687IbHG0FNxIXX7TdG8srVtbS/DO06WVPhNkNPcKCe2M9OjttUu3tKch0nqtU1rHA+WmSjQePg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732893598; c=relaxed/simple;
	bh=5pJNg29cWMf9rtRxZ8xFXYpG1L58Wp+2pkDSMBya+cY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FiIMDrchpnnnQpO+WQoQ6RlMyUtIY9Pa6uvYz3wCwmzkL341Y8pjT5WcnwGuz4qnaoinrGBXabcHbdOfhCbM5npvV1npHmeMYH2ILblDS73llZCYNoDyFe1wcbPGVwgntmUhmNC/r+3gfOeJZPZi2FT+bnmzj+s96xJmsRiLXpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Asj//xh6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732893596; x=1764429596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5pJNg29cWMf9rtRxZ8xFXYpG1L58Wp+2pkDSMBya+cY=;
  b=Asj//xh6FxV9OfhZr0l4SpM/WR//4bTelBQ9lMNAL9GrhVYzozZLi7a8
   ySjeWc6xf9Va4POySJV07eBxpwHsTfxnQ3evNvip7ax1ouH7GSeoLu6Jv
   b7kjt6/y87AECibsmsyp3sS0vjt+Mp15CGQS/+sT4iw/loN5QAQf4NMzo
   Ra89cAZFJoTCuY20i8eH9UNdlyPX5vW4rt03KZ5OMf76zN267sYsfD5mY
   5pGFUXOFdp603q+At7kRL4eby6U2ohKNOyxZnHkUbB+nnx2ZF9nU3Nw+w
   KR+eVHEaO0Os2jZkLv8/M2A8thBmF8Jn0oAosWJmFpMg3Uhkr8GDZYQWK
   A==;
X-CSE-ConnectionGUID: OGNa0Fy+QIueKvIHJTfYzA==
X-CSE-MsgGUID: VTKlspdHT5WMmOoeCyAGhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="44513660"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="44513660"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 07:19:55 -0800
X-CSE-ConnectionGUID: V9pI6hvcTgiHxyjr4oJr/g==
X-CSE-MsgGUID: QSOp4kHaTV+7cM+RdwENbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="92395290"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2024 07:19:55 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 29 Nov 2024 07:19:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 29 Nov 2024 07:19:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 29 Nov 2024 07:19:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0c9G/afRJlH9BzaZT3Wpe0S7ygM3xAnI8ZsZizV5XFwMImpM5HX0SK3ZyehjPnUloCRmA+TV8TMmbxYvwfFMDUh1EZo1fsPTwYagp8SLg9eyAJKuhyiUUZPwzk43HGllKpeQu/CvWr/ufvTUB5kpMbDn9RCEBsxN9jYBSQNHduYOaWwKLo3ykBOgnJ42/wNNXcF75qiEZMc9jWok4TTHsRVPMkTSe5d0HwUYvqbzEcr5hUzKw6gUxP9+EvGzGJzEZzu5FDZKR2vM/i9pahbi9WKm8030hnnoPBw6zTVeaylGTDQddujTLfb6Lz7MKXUlPhznXffa4/Ip8Rl8lwVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWdB7QkRd5Fw/b/i3KiwJrBzbgF6r0wpOve5utz2paU=;
 b=l0emU0vEEHfZSeI2NPiebcUTblAMqCbDtfAoMxphQh1EEIW5MZT9cRzI12uyAf8htyezjKZCXMTcWhSMLz0F986qgxC7r1pxixAc4rjd1xgL0W2n4hnKSLhHh0rE1kimFD1vSl3kkA0jV2HgJwhwT7pFx9tEH23Rgj/oUtG2NKIG/qTO5FiMhgcyu6uHYjTyFe4P5P6NE9FNGPptc/avfFYsrcgMbXghcbG+plwSPYcep3WmiG83htv+OJ+ysXSmyKmiidlrFOt+yhn0oZz7819MypheA8oJyr182s2LqFV6GN78K7i2dcOz+gMOj1vmUUFnHkIdrHXUkPUPTJ8PDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 15:19:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 15:19:50 +0000
Date: Fri, 29 Nov 2024 23:19:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [mm/readahead]  13da30d6f9:
 BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
Message-ID: <202411292300.61edbd37-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: b20bc07f-c646-4e55-1799-08dd108944cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uKq0/vo0cuck3QcPJGWZoCA1BjuN60vgQjmDFhEtjHzXqYNFO2jg5ZYphKnw?=
 =?us-ascii?Q?3Lsy0VXUthqsvy8+DxvUt+ZpIDZ2aZ+ZMY9tUJFoVp1u8r8dCAm3dzbt6VPV?=
 =?us-ascii?Q?qm/EqB04mSk+osL9r2S6kIGI6vWTYG5l9qVjjgzQvTP4jJSHMUrOdPjQosx2?=
 =?us-ascii?Q?R5AFnuYyxeorPnjZuPY/G8sJh3gd38sXzbJdKHHJmO7JiwjEaCmHgBWSBZmm?=
 =?us-ascii?Q?OiibCMBB182aU8dCuHxzCrT+iOzuRaVz8sugEWi024LNAoYdpWXbdpzR3Mq8?=
 =?us-ascii?Q?mNqsZa2/KeomFZVdtOQLkTx5jPIAVlGmRyzl+m+8ukWalu4UgWxXfHHJJhG5?=
 =?us-ascii?Q?5HASSD854oeI+ulBEjM1gCLqChcgMiZxIiFN17g23hz0U96BpVaT7WBSIQQW?=
 =?us-ascii?Q?ssTHKApbFMav1WWxg5wubqan7mkVGE2/L0G+h2q+IJ9sKNIQ1UNzE9Igvfzv?=
 =?us-ascii?Q?gCHGeOfnF1dDV45Ztn32Y3pDKfsykB3CufZTzOVzODpOFs0chvam9duSRlCJ?=
 =?us-ascii?Q?J1nr5Phi3FfQgpSWGGDnN36h5mV+XtjmHYj3pZydsUFNWaF8JC8F83UiXMs+?=
 =?us-ascii?Q?QXpPPVExJNTYJlFvNkWLNQGO0vnT8k/SiRmRbDXMAY823C9tzNUqFUg4GjpG?=
 =?us-ascii?Q?ol3QmGBM7QDRuggJ2dzzxku4Am4tumk8z95lMR5P3ULx5HiKVvS3JW8ssUp1?=
 =?us-ascii?Q?GxJWGIltCXAVK0S/q9KG1LbrcL40NYVOxLswiyXuobWVK0oxyAhQ6keRVpim?=
 =?us-ascii?Q?drPyVAfu8oDoeRbB+8QgX3ITVHJerUyKYgg0iw/YCRjE8ydyyDGJF5e0+w0l?=
 =?us-ascii?Q?HN9BXCnh8ufGgu64QzX9JezpQNqjJ8wpUI0MxKGa7x5EDCV9LOKQK0he8Jek?=
 =?us-ascii?Q?E/RoGPQf35Bhsq9FlQPop9VzRWwrEGMwQVX+vToa3ZPUttunrWCK97pyoj1w?=
 =?us-ascii?Q?ExyfNpS/eK9Qfaui00FD1TqML+Nt1gk9U0RfzQlOtDUQKdd7FRYq56wEZ16X?=
 =?us-ascii?Q?twUZn0LZ3dbQx6HiQwXJIRzamMDZtbkB8+7DfcBKWtnFzbp4xbc4SIu0sKcz?=
 =?us-ascii?Q?HfsWO6tcCdUNYlYGXalFDeKMOACd5NhMrH7U00YAq9jhJmUOvJbXa/EtS4oe?=
 =?us-ascii?Q?HfNBIOCJj68csW3bKLjb/uefnFGnLhYrF8dWZXtewSF/WLWh78qrG7dNXEvT?=
 =?us-ascii?Q?2zGoL4OFtp2+T9uFpyXY1HWEF228g8izokymkPQAGFMmEli342zI2C3MumnN?=
 =?us-ascii?Q?gRAYjXl9fFPxrpyWzed4EX3LeCXUmZJOKkT06Axj7OB4kXT18E3tMYXmOBcx?=
 =?us-ascii?Q?3l+Ot2oHGnO5AvSe35LxqeO9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fu/lexZcFqa0d99K+8VB8rhOKPauYZxTJ8uYMQ11Pwo9faD3DyCLIu4FuaPJ?=
 =?us-ascii?Q?Ps8+oe28EjqjDBJEILk/NP9GCW2QQS+ufXS1dmgx5Jc+w8RR6DL78cfpPAdv?=
 =?us-ascii?Q?YmgM7ggWiESvcLNiYHiuvoifU8HxDdM9re5AcOhP3+rEV1239b5qk/ICKmBA?=
 =?us-ascii?Q?t8VVbhK5rVDEIY6ajLnUIhguWo81fJKNTQIz20KdUV+XNVtZRCzB+nd0fVHJ?=
 =?us-ascii?Q?X7uOBTt1rABJCZfd6WWdKmmaar3/Ztoh/hCOo19r8WMKNgPHF0LF8/yLQ9UX?=
 =?us-ascii?Q?uz+k08UvfTslpb3lgzZcJ3Qlt4EaikZ+slRoYmcrC22aok15XLGyeIGSuY5F?=
 =?us-ascii?Q?Xo5EdyfdlpAANK1A8M0Diyvps/2uFmimLG8/j18Skctt9f8ahB7kQNVUTIbE?=
 =?us-ascii?Q?EnljbSraedcBhL3ND148bDbMHRM+z6oElj6VabIo2xthT0Ln4StTgAKlwP4c?=
 =?us-ascii?Q?cgy+l1APlpQLNTeelScWYScblKdPE52gKOKXtCJr5b4DbTBo4ZXdPHSSKRQ6?=
 =?us-ascii?Q?ipCYh/PrVXYHrQLzEKMoLtF6l785ObXkYhtRlCbiKvRz5/0xpK8aatAa7vxw?=
 =?us-ascii?Q?HWjB+FgcGgrDfxlLJZU2NeyJEpH8QJU2sGWkxwF6iu/7vefDNxjttdKwfKcm?=
 =?us-ascii?Q?08gXIQTdFvnGgT2DfgSTv+3Z4QBfZgXCQumlWFwNFYkpSeIJCBC7jfISDnct?=
 =?us-ascii?Q?OLcXAx6M5mp+EX6attzYzo9fPWMGKp2+1KmF0NYDdtBd3jzn3u8ZixiIYQYm?=
 =?us-ascii?Q?1wJJ8QDxjugz8EsnpF8Clg9M7+a0ihJRJIIeMFwVCzKtKtLv58qF7p7x3DA5?=
 =?us-ascii?Q?fObU9TTZv3dWeKh1dqJ31Lp9eeSVE8cAdhoEmMoAHinDzExB4hbsXXeS8hwD?=
 =?us-ascii?Q?/MdVQyWQGUoOr0thPT/ttLoyjPqHw1ncomgZ9R+qyLk0Wnc6q52MxoNtH3o/?=
 =?us-ascii?Q?gGXm1dhtuY174EAbcrYOm/8PN28D/0HgBkNvgjoIRphOzx7js+S9PYp/PeNa?=
 =?us-ascii?Q?K+Kek0HAb+cfO7dT6O4KfwnqMiX4LjlcAckVhySbuIrsbvuhRUIzr0s0h6F6?=
 =?us-ascii?Q?pUn1HXJH6KdhmxEuaLlHt6VQDodvFEQbXum4ly0cEvt07PwIwF6U0jADlOD8?=
 =?us-ascii?Q?F4+kv8gUgCaIiHcoIG0aOYcRHHL6yXihjD1CCA1R1fzNY+hvslKy9qrS3ogv?=
 =?us-ascii?Q?861HdrNctIyhNTMn+yclziEi64I32S+xJ+2Ag/j7Hu6RpEgbbYcAtV7Oupxo?=
 =?us-ascii?Q?ENVeC4QAoARuoU+sma/ZLhb4o8zyNmYuLcmL9WtVLGpExpU4IUqIM8wulUH6?=
 =?us-ascii?Q?LifVF/1ui/bNkHOEyTFk1EoIE7wrQXGnlKwQElADd/7+OLPy9399BaDzwO5b?=
 =?us-ascii?Q?VWUxVso4PZs6b+1kVktWe6ENwHwSEjKRTtJnyZGTw7Zuye7GyChIRZ9dYdmf?=
 =?us-ascii?Q?3EWB4iCD40UfWZWzQN49Q7uKnNvO1l7P3TsH2tClal6IdKo6Z54/yHKrbVOB?=
 =?us-ascii?Q?jT0Jxvn6t3QpBPNX7jSJfZK1qaJ/IhYNNLjyzVKzZPhoBXfFKpqrYkGim1ed?=
 =?us-ascii?Q?uDgqQ0ayGN2lvvYzk85fmeUDaSFcn+dsAQN60cj2KfNMPDcVtyy3aOgVtGyk?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b20bc07f-c646-4e55-1799-08dd108944cc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 15:19:50.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd95tC8vEGAfppKru4ewbNUgGBvevWz7KUWEjMTWZJJqdDihCYFDbhOJDcSuhj310csjGWzivLIABx7pdm9s6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![usemem:#]" on:

commit: 13da30d6f9150dff876f94a3f32d555e484ad04f ("mm/readahead: fix large folio support in async readahead")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master cfba9f07a1d6aeca38f47f1f472cfb0ba133d341]

in testcase: vm-scalability
version: vm-scalability-x86_64-6f4ef16-0_20241103
with following parameters:

	runtime: 300s
	test: mmap-xread-seq-mt
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411292300.61edbd37-lkp@intel.com


[  133.054592][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [usemem:5463]
[  133.062611][    C1] Modules linked in: xfs intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common isst_if_mbox_msr isst_if_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal coretemp btrfs blake2b_generic xor kvm_intel raid6_pq libcrc32c kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sd_mod rapl sg intel_cstate ipmi_ssif acpi_power_meter binfmt_misc snd_pcm dax_hmem cxl_acpi snd_timer cxl_port snd ast ahci mei_me cxl_core libahci soundcore drm_shmem_helper ioatdma i2c_i801 intel_uncore einj pcspkr libata megaraid_sas drm_kms_helper mei ipmi_si acpi_ipmi i2c_smbus dca intel_pch_thermal wmi ipmi_devintf ipmi_msghandler joydev drm fuse loop dm_mod ip_tables
[  133.127927][    C1] CPU: 1 UID: 0 PID: 5463 Comm: usemem Not tainted 6.12.0-rc6-00041-g13da30d6f915 #1
[  133.137519][    C1] Hardware name: Inspur NF8260M6/NF8260M6, BIOS 06.00.01 04/22/2022
[ 133.145595][ C1] RIP: 0010:memset_orig (arch/x86/lib/memset_64.S:71)
[ 133.150781][ C1] Code: c1 41 89 f9 41 83 e1 07 75 70 48 89 d1 48 c1 e9 06 74 35 0f 1f 44 00 00 48 ff c9 48 89 07 48 89 47 08 48 89 47 10 48 89 47 18 <48> 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d8
All code
========
   0:	c1 41 89 f9          	roll   $0xf9,-0x77(%rcx)
   4:	41 83 e1 07          	and    $0x7,%r9d
   8:	75 70                	jne    0x7a
   a:	48 89 d1             	mov    %rdx,%rcx
   d:	48 c1 e9 06          	shr    $0x6,%rcx
  11:	74 35                	je     0x48
  13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  18:	48 ff c9             	dec    %rcx
  1b:	48 89 07             	mov    %rax,(%rdi)
  1e:	48 89 47 08          	mov    %rax,0x8(%rdi)
  22:	48 89 47 10          	mov    %rax,0x10(%rdi)
  26:	48 89 47 18          	mov    %rax,0x18(%rdi)
  2a:*	48 89 47 20          	mov    %rax,0x20(%rdi)		<-- trapping instruction
  2e:	48 89 47 28          	mov    %rax,0x28(%rdi)
  32:	48 89 47 30          	mov    %rax,0x30(%rdi)
  36:	48 89 47 38          	mov    %rax,0x38(%rdi)
  3a:	48 8d 7f 40          	lea    0x40(%rdi),%rdi
  3e:	75 d8                	jne    0x18

Code starting with the faulting instruction
===========================================
   0:	48 89 47 20          	mov    %rax,0x20(%rdi)
   4:	48 89 47 28          	mov    %rax,0x28(%rdi)
   8:	48 89 47 30          	mov    %rax,0x30(%rdi)
   c:	48 89 47 38          	mov    %rax,0x38(%rdi)
  10:	48 8d 7f 40          	lea    0x40(%rdi),%rdi
  14:	75 d8                	jne    0xffffffffffffffee
[  133.170775][    C1] RSP: 0018:ffffc900126efa20 EFLAGS: 00000206
[  133.177015][    C1] RAX: 0000000000000000 RBX: ffffea00a7c878c0 RCX: 0000000000000030
[  133.185139][    C1] RDX: 0000000000001000 RSI: 0000000000000000 RDI: ffff88a9f21e33c0
[  133.193229][    C1] RBP: ffff88a9f21e3000 R08: 0000000000000000 R09: 0000000000000000
[  133.201373][    C1] R10: ffff88a9f21e3000 R11: 0000000000001000 R12: 0000000000000000
[  133.209522][    C1] R13: 0000000000000000 R14: 0000000000000000 R15: 00000026b5fdf000
[  133.217642][    C1] FS:  00007f21a47e86c0(0000) GS:ffff888c0f680000(0000) knlGS:0000000000000000
[  133.226703][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.233410][    C1] CR2: 00005641d476a000 CR3: 0000000c4b6b6003 CR4: 00000000007726f0
[  133.241514][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  133.249679][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  133.257776][    C1] PKRU: 55555554
[  133.261446][    C1] Call Trace:
[  133.264848][    C1]  <IRQ>
[ 133.267875][ C1] ? watchdog_timer_fn (kernel/watchdog.c:762)
[ 133.273139][ C1] ? __pfx_watchdog_timer_fn (kernel/watchdog.c:677)
[ 133.278704][ C1] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1691 kernel/time/hrtimer.c:1755)
[ 133.284250][ C1] ? hrtimer_interrupt (kernel/time/hrtimer.c:1820)
[ 133.289443][ C1] ? __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1038 arch/x86/kernel/apic/apic.c:1055)
[ 133.295587][ C1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 arch/x86/kernel/apic/apic.c:1049)
[  133.301543][    C1]  </IRQ>
[  133.304608][    C1]  <TASK>
[ 133.307641][ C1] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702)
[ 133.313886][ C1] ? memset_orig (arch/x86/lib/memset_64.S:71)
[ 133.318457][ C1] zero_user_segments (include/linux/highmem.h:280)
[ 133.323465][ C1] iomap_readpage_iter (fs/iomap/buffered-io.c:392)
[ 133.328698][ C1] ? xas_load (include/linux/xarray.h:175 include/linux/xarray.h:1264 lib/xarray.c:240)
[ 133.332919][ C1] iomap_readahead (fs/iomap/buffered-io.c:514 fs/iomap/buffered-io.c:550)
[ 133.337765][ C1] read_pages (mm/readahead.c:160)
[ 133.342137][ C1] ? alloc_pages_mpol_noprof (mm/mempolicy.c:2267)
[ 133.347774][ C1] page_cache_ra_unbounded (include/linux/fs.h:882 mm/readahead.c:291)
[ 133.353303][ C1] filemap_fault (mm/filemap.c:3230 mm/filemap.c:3329)
[ 133.357982][ C1] __do_fault (mm/memory.c:4882)
[ 133.362292][ C1] do_read_fault (mm/memory.c:5297)
[ 133.366985][ C1] do_pte_missing (mm/memory.c:5431 mm/memory.c:3965)
[ 133.371754][ C1] __handle_mm_fault (mm/memory.c:5909)
[ 133.376818][ C1] handle_mm_fault (mm/memory.c:6077)
[ 133.381717][ C1] do_user_addr_fault (arch/x86/mm/fault.c:1339)
[ 133.386820][ C1] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[ 133.391500][ C1] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
[  133.396396][    C1] RIP: 0033:0x55578aeb9acc
[ 133.400849][ C1] Code: 00 00 e8 b7 f8 ff ff bf 01 00 00 00 e8 0d f9 ff ff 89 c7 e8 6c ff ff ff bf 00 00 00 00 e8 fc f8 ff ff 85 d2 74 08 48 8d 04 f7 <48> 8b 00 c3 48 8d 04 f7 48 89 30 b8 00 00 00 00 c3 41 54 55 53 48
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	e8 b7 f8 ff ff       	call   0xfffffffffffff8be
   7:	bf 01 00 00 00       	mov    $0x1,%edi
   c:	e8 0d f9 ff ff       	call   0xfffffffffffff91e
  11:	89 c7                	mov    %eax,%edi
  13:	e8 6c ff ff ff       	call   0xffffffffffffff84
  18:	bf 00 00 00 00       	mov    $0x0,%edi
  1d:	e8 fc f8 ff ff       	call   0xfffffffffffff91e
  22:	85 d2                	test   %edx,%edx
  24:	74 08                	je     0x2e
  26:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
  2a:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
  2d:	c3                   	ret
  2e:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
  32:	48 89 30             	mov    %rsi,(%rax)
  35:	b8 00 00 00 00       	mov    $0x0,%eax
  3a:	c3                   	ret
  3b:	41 54                	push   %r12
  3d:	55                   	push   %rbp
  3e:	53                   	push   %rbx
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 8b 00             	mov    (%rax),%rax
   3:	c3                   	ret
   4:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
   8:	48 89 30             	mov    %rsi,(%rax)
   b:	b8 00 00 00 00       	mov    $0x0,%eax
  10:	c3                   	ret
  11:	41 54                	push   %r12
  13:	55                   	push   %rbp
  14:	53                   	push   %rbx
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241129/202411292300.61edbd37-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


