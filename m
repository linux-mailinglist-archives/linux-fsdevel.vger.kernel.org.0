Return-Path: <linux-fsdevel+bounces-10214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A3848C17
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 09:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698B81F234C1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2EF11724;
	Sun,  4 Feb 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HACTGAtM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A110799;
	Sun,  4 Feb 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707034487; cv=fail; b=Pq590V8FMtt6XHTtpwzzG4BliX6EyZ0GPb2Mstno13E+MfdkzLur2rcQpIp1XgyvEooGvWu/vmtKFAvS765EK0BsWjIQOCh6s0P4lTg5smguR58cExS5JDB1j08XESDtvBR9QvSU1yUV4ILi6JoqxfSSs7375GFENOHgUc3sD80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707034487; c=relaxed/simple;
	bh=kReWrc6RaiVJqETWpwJ0NPUir7xCyna/aycJoxwDqV0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=at8US2EHO5AUVmhoEtq8U3sdzWjMQTbB9ydGEot4fohH2wyBOcKQXwF33QDjuJQHOUzd3R0tblOKkjaqca5jU2smxt2Lyb1JvBrD4qz7YTLD83j06ocGUsSbQR+b7fCexKRhnTTP79FlnTG/LkFbMsgWKpYcJL/ezV4GjyXf6WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HACTGAtM; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707034484; x=1738570484;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=kReWrc6RaiVJqETWpwJ0NPUir7xCyna/aycJoxwDqV0=;
  b=HACTGAtMA+SPwN6qXn/5hlTn2D8mKW9Tw0OBijvbyGbw8wdEfkLVIVIy
   fTvbgDGAflaliDftWjJ4hVA9N1zBhC2mKZYtNB3DfQl6aHYHbuXc2SuOJ
   WraGqhPNihpxvBqoXLieN2/QLME7P4PBqWjX3x7TU/KF16m5v8HICQaKo
   QVpnAAPPjbidCJmctK6naYPtIqeQHf1MozaAHMY8/BXdbqlXO/aYpCt+v
   0frNJMgSvVm5nxt4kUr4lHKh3d09dKlKRSuz+wPX8LhRfJCu5VHu2+Ghf
   8jzf5H0a7sUpjF55DtlS5G7QPApTeM/NB18hLKHTK99ujUGh5f988Y6a1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4267497"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4267497"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 00:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="932872495"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="932872495"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2024 00:14:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 00:14:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 00:14:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 4 Feb 2024 00:14:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 4 Feb 2024 00:14:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYK0wkbBmS1ru3cj8mKdFZ0g8B3cXK0/cHs1ZCAZ/7cLJN9ALCgtmXxbq35jH3XE0P9M3E9e25REeVC9C7WqYHfHumclfmAvH44lc+JZSAST24Us8bq806bIy3uf4RO+UxYIl4mH+w6ZXsTH2Aoj+n8dn8qYSRLnFf+HYHgg2TVf7rQI5PUOH+6GX6Uh0q17c5EKhb8LRQ35gPkWbMJ78qJ6Q2cyTD8AuefWDxIbc1ZdzXcKzEWUXFLVBg5BrCigNdJMmz0rdLAiJj7U6o2FAVCv7F2gJ+itSo7P02kXzO+bA4zXr5R0rcw0muWyZTMycmHYIpCif+bvXY8fR6dYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1k9FCDZiFalpxJin78Uzntuz+pk1EvosPWS6gmcaw8=;
 b=PUPiO0sduPJe0IIA9LxRjCkcU1toXpXCqSqgQxGTTqZKtuzGJryGaIyKxM+mmfsoyvcoLArNJQuvi0iZBI2KRWMB0mDvYqKW1/x9hUhSJi4Bh2wK+2lHVz4d01BoT5cgU6H102XrArSebLcQzPhde68NiHAjE1dRszoIMHBpmp/iQzMiBvWBRVreCxU9JEa+Pzd6B7a1Yf8rh8pT+6bIXhrZjo3xSXy0M4VwkxfULSmXTMeWJTu3fvY7t+dizsmWuoO3JrF5dBdfX4ZXwP27qwUX6zTnuFy1Skk5d37tBTgiT36ZfAxgD+S7DHWBapzSRbesrv9d0kbAJT5N9Ez/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 08:14:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 08:14:36 +0000
Date: Sun, 4 Feb 2024 16:14:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [__dentry_kill()]  1c18edd1b7:
 stress-ng.dynlib.ops_per_sec -39.0% regression
Message-ID: <202402041509.ae663efc-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cba5685-902f-441a-f1d6-08dc25595345
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5l456zrSXaI27PrY/sZ6NrC1cCqPw0Vs5FWiWBDOcvEZAiCybATh8eMvRbhNZD0NGQ78S3e7LtbtPbEnq4pbxbNGNLhZax9M0sWhKiNdw3j3JSo4Ge/tFrb1yUotgJmGdqYdz/vSepVIf1xvcLS8rN8IC4an4BnwjQm3ApbQbdrLmcsjUAqPtQhev53yufu0xFceX9j6IPDI+3AvzQyHCktRXBFFJqOMHtcKRn7P62V7HrHBGNTDeJRTnGqlIlk7Ti3zAagIeM3eCj6wK4wabx4PCg/W1FMoIRuTjy4h6GmRTU8AUIusb2lK5NWrCpGhYuY77Ir5dOdyEQKLHkmA3vIkHXyk8pumxeQPILQeeFz502DHvn6mrdz31LsG2ZB1WMiFXbEIC8z+k68tw/Svolk9+viuT/EoZ7PEa4RKpIAYD0Wf/p5pUjGTU01JKKLMaFPyCmoK23l89+vOD6oxRqZJYcyl6MeQSuhrRnPW90h2+wfThHlu1J48ArNcfD/lwuxR2XQK7vXq9DFyPO6JCYlgmyMjhhX7hL5jcmkaKkD2gmUY0Qg8osXJDhZhTph95NcFl8xJTnM8qsr1rTIAqqsO2RAvg65QAlpSrsCdqdUO2bQ+m0MHw/ueaE1CpZblMJGVdzDlAeR6tpl7ZrlLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(230922051799003)(230473577357003)(451199024)(64100799003)(186009)(1800799012)(2616005)(107886003)(1076003)(36756003)(6512007)(6666004)(6506007)(86362001)(26005)(38100700002)(82960400001)(41300700001)(83380400001)(478600001)(6486002)(966005)(4326008)(8936002)(8676002)(2906002)(30864003)(5660300002)(316002)(6916009)(66946007)(66476007)(66556008)(579004)(559001)(568244002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?A5FOWu83AqLwWh7wpSbnMH50EZt+XJTZ7WQ2E0y/dID+BBS2PSFdp8gsoJ?=
 =?iso-8859-1?Q?K52uvDLct/nwA4KfzFEY91Z5b4MLyyuid+RnKiTnuOb69BpuYF0AE+FI+9?=
 =?iso-8859-1?Q?dJ1s87OhAvSsohDgvvzfPaK87nhYsFwqyGvbqmIl74wTe901Nv5SU3p3ap?=
 =?iso-8859-1?Q?WhTdwu+BP4cprUoEMYBF/QUHk90gKI3XbvRi7uUet9hSyXBUhYPHabjBhA?=
 =?iso-8859-1?Q?7PsWzIndlDc4Ee9fqlzWOjYo/5CwI3uZgR1RSTsLO5tJd94ZyaELh7D2Da?=
 =?iso-8859-1?Q?/EbPNNiMd8fUotlk+2rZutVsF6qZd/Gdty5Pntk9TGxq+07EtpgDmzuoyG?=
 =?iso-8859-1?Q?ukpaz0s0gm2a/2Iy0VtVgpNi9o9RjCRXrCfdxx2C0uqsoZ6128+3Z7rEWy?=
 =?iso-8859-1?Q?xTPIPASRDophUNQd+JQhBCtZX/qoIEG891vv9m5tKCBm+hn3OfiX3fG7Wu?=
 =?iso-8859-1?Q?mpjVshvWe3SfJscdfgjGIEf+0xKOtuJBtTJb0hv4aR1x4S0LRnakFib95N?=
 =?iso-8859-1?Q?RdOCwQ8LY43suzf6SzN1zJnHsUCJYUAN7ozHuPxc1M7c+NewNHaNkGRi6v?=
 =?iso-8859-1?Q?egfHE7PPuNn+X12yZCoA2SDBOSnptFu+nyMrLwu9yh/PyZmld51lOOznL+?=
 =?iso-8859-1?Q?7kJ6dWXVYZ3m7YPKulb40Dvm3Z7wvuvMk2h38BmZ/eu9zDjvawN3viP9zZ?=
 =?iso-8859-1?Q?9H79dLskqqp+hlIALR+/OEkhzwdOrb1k/tOTqD/0yxrL7nMkbYqG0hncmC?=
 =?iso-8859-1?Q?DzUH+SS18sR1ORRbqRN1W4Lwv6+5LRylTV+uuo2NrUm8azAeYUPOC7rvXK?=
 =?iso-8859-1?Q?ty1zulKXqzMqm7FKlcFpDaTjIFCNvguaPiCwLJGprRjWXepLymjK41Soiu?=
 =?iso-8859-1?Q?QeYiPWStzu1EMHjZdgWPpHqK3daXsu3B2LfiN/6xgqC4MFGchBfBabjnHm?=
 =?iso-8859-1?Q?zWhxw/Y9tIBbIWtnaanBXt6a6m/zRd8qp0wXhQ8WrsM9TOly3ZECFKDyQ3?=
 =?iso-8859-1?Q?PIDngK0HCOovMSrop7sRqaC5lGkdgYjQH/aIK24kP+8CC2XXAC43N/6lK0?=
 =?iso-8859-1?Q?sNGBr4oaaE98RSJVqYABOfkPKFqns/5WYHeSauZZefIHdLKLUAvKCtaEYk?=
 =?iso-8859-1?Q?pT505WHvnQkb2+swUVgv/14j75Ruh/pWjQVHX86ZWxYIiYtoJokJHTnDig?=
 =?iso-8859-1?Q?VO97VXeVjKg0MOJRmS6BG/mQJ3Cz9W+qiOD25F0JVEXieWAzfw4Ww/ZTDX?=
 =?iso-8859-1?Q?sQRwA5meq8HiINc65wUCctSnnn3cY3S7M7EYJnDulYfP+WXeGSzhrl+c3x?=
 =?iso-8859-1?Q?HDmmhB8bmx4FEn5McZdsUxtfnopMNfjZ6AzZJwRprT9Ti2axt/fBgy0Kgf?=
 =?iso-8859-1?Q?ETJoWcTxoBd+7fEoScVenxf6UPBPr2ghMSRp4IcZs4X2ewQeMVRjjq2WMf?=
 =?iso-8859-1?Q?JkLUsTK8KJPWtxx590/2dfBYrmK8uh+XKoTCAqOXlic5BWtc2xdQgdLi5/?=
 =?iso-8859-1?Q?igc10LUIv5WphKKFR4dDoJKDfng8i7ZmfQUYm0HaxdyWLBX8qb+EFHlkEh?=
 =?iso-8859-1?Q?mbVQ7H6wKYxPJDUQBIMJkXjGpagJryS9sgxqQEzfVWdzrJL6rTfTSVuI3R?=
 =?iso-8859-1?Q?QexRHFp1nMlcr200qKEzdGO6VNHs09HL6NMmTaAkTmhbJcNE4albVqxw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cba5685-902f-441a-f1d6-08dc25595345
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 08:14:36.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oq3n2Vc/AlHlQARkZ3OVWXuADdkV9DtYRHXk2pnjcjjsoRGkeAVyVPVfBw57awZUx47/LAociETNL4rsefCB8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6054
X-OriginatorOrg: intel.com


hi, Al Viro,

we noticed this commit is merged in v6.8-rc1 now.
there are lots of discussions/tests upon our first report for this commit:
https://lore.kernel.org/all/202311300906.1f989fa8-oliver.sang@intel.com/

but I'm kind of lost if there is a clear conclusion that these microbench marks
results could be ignored.

here we just made out report again FYI what we observed in our tests.
if there is fix in any branch or you have some patches want us to test, please
just let us know. Thanks a lot!


Hello,

kernel test robot noticed a -39.0% regression of stress-ng.dynlib.ops_per_sec on:


commit: 1c18edd1b7a068e07fed7f00e059f22ed67c04c9 ("__dentry_kill(): new locking scheme")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: dynlib
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sysinfo.ops_per_sec -30.5% regression                                |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | class=os                                                                                  |
|                  | cpufreq_governor=performance                                                              |
|                  | disk=1HDD                                                                                 |
|                  | fs=ext4                                                                                   |
|                  | nr_threads=10%                                                                            |
|                  | test=sysinfo                                                                              |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402041509.ae663efc-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240204/202402041509.ae663efc-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/dynlib/stress-ng/60s

commit: 
  b4cc0734d2 ("d_prune_aliases(): use a shrink list")
  1c18edd1b7 ("__dentry_kill(): new locking scheme")

b4cc0734d25746d4 1c18edd1b7a068e07fed7f00e05 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.01            -0.3        0.68 ±  3%  mpstat.cpu.all.soft%
      3.56            -1.2        2.38 ±  2%  mpstat.cpu.all.usr%
      0.08 ± 16%     -30.0%       0.06 ±  6%  turbostat.IPC
    366.64            -3.1%     355.32        turbostat.PkgWatt
     74.36            -4.1%      71.34        turbostat.RAMWatt
  17114647           -38.2%   10569750 ±  2%  numa-numastat.node0.local_node
  17143191           -38.2%   10600776 ±  2%  numa-numastat.node0.numa_hit
  17398272           -38.5%   10707229 ±  2%  numa-numastat.node1.local_node
  17435524           -38.4%   10742331 ±  2%  numa-numastat.node1.numa_hit
    422081 ±  2%     -20.6%     335248        meminfo.Active
    421953 ±  2%     -20.6%     335120        meminfo.Active(anon)
    256968 ±  2%     -15.8%     216280 ±  2%  meminfo.Mapped
    309251 ±  2%     -17.6%     254892        meminfo.SUnreclaim
    673282           -20.4%     535639        meminfo.Shmem
    429497           -11.9%     378461        meminfo.Slab
    166940 ±  3%     -18.3%     136439 ±  2%  numa-meminfo.node0.SUnreclaim
    203652 ±  7%     -16.5%     170003 ±  4%  numa-meminfo.node0.Slab
    341933 ±  7%     -13.8%     294623 ±  4%  numa-meminfo.node1.Active
    341891 ±  7%     -13.8%     294580 ±  4%  numa-meminfo.node1.Active(anon)
    145566 ±  5%     -16.6%     121353 ±  2%  numa-meminfo.node1.SUnreclaim
    547329 ±  6%     -16.2%     458895 ±  7%  numa-meminfo.node1.Shmem
    715728           -39.0%     436874 ±  2%  stress-ng.dynlib.ops
     11928           -39.0%       7280 ±  2%  stress-ng.dynlib.ops_per_sec
     44724 ±  3%      -6.0%      42032 ±  2%  stress-ng.time.major_page_faults
  50331777           -37.1%   31683535 ±  6%  stress-ng.time.minor_page_faults
      3610            +1.7%       3672        stress-ng.time.system_time
    114.39           -36.7%      72.40 ±  2%  stress-ng.time.user_time
     41912 ±  3%     -18.8%      34045 ±  2%  numa-vmstat.node0.nr_slab_unreclaimable
  17143309           -38.2%   10596416 ±  2%  numa-vmstat.node0.numa_hit
  17114765           -38.3%   10565389 ±  2%  numa-vmstat.node0.numa_local
     85518 ±  7%     -13.9%      73627 ±  4%  numa-vmstat.node1.nr_active_anon
    136994 ±  6%     -16.3%     114713 ±  7%  numa-vmstat.node1.nr_shmem
     36486 ±  4%     -17.1%      30264 ±  2%  numa-vmstat.node1.nr_slab_unreclaimable
     85518 ±  7%     -13.9%      73627 ±  4%  numa-vmstat.node1.nr_zone_active_anon
  17435482           -38.4%   10738005 ±  2%  numa-vmstat.node1.numa_hit
  17398230           -38.5%   10702903 ±  2%  numa-vmstat.node1.numa_local
    105527 ±  2%     -20.3%      84064        proc-vmstat.nr_active_anon
    128508            -2.1%     125808        proc-vmstat.nr_anon_pages
    881453            -3.9%     847006        proc-vmstat.nr_file_pages
    191392            -8.1%     175855        proc-vmstat.nr_inactive_anon
     64498 ±  2%     -16.1%      54133 ±  3%  proc-vmstat.nr_mapped
    168455           -20.5%     134006        proc-vmstat.nr_shmem
     30065            +2.7%      30885        proc-vmstat.nr_slab_reclaimable
     77487 ±  2%     -17.3%      64109        proc-vmstat.nr_slab_unreclaimable
    105527 ±  2%     -20.3%      84064        proc-vmstat.nr_zone_active_anon
    191392            -8.1%     175855        proc-vmstat.nr_zone_inactive_anon
     34142 ± 10%     -38.3%      21058 ± 18%  proc-vmstat.numa_hint_faults
     24667 ± 15%     -38.8%      15086 ± 13%  proc-vmstat.numa_hint_faults_local
  34555455           -38.2%   21338406 ±  2%  proc-vmstat.numa_hit
  34489660           -38.3%   21272276 ±  2%  proc-vmstat.numa_local
    305551 ±  3%      -5.6%     288299 ±  3%  proc-vmstat.numa_pte_updates
    268351 ±  3%     -18.2%     219564 ±  3%  proc-vmstat.pgactivate
  39256832           -38.4%   24177908 ±  2%  proc-vmstat.pgalloc_normal
  50781973           -36.7%   32131262 ±  6%  proc-vmstat.pgfault
  38876503           -38.5%   23895388 ±  2%  proc-vmstat.pgfree
      0.01 ±162%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      5.00 ± 22%     -29.3%       3.54 ± 23%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.20 ±179%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      3.05 ± 44%     -41.8%       1.77 ± 71%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4.06 ± 10%     -18.3%       3.32 ± 10%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    294.75 ±144%     -97.1%       8.53 ± 34%  perf-sched.total_sch_delay.max.ms
     16.01 ±  5%     -22.3%      12.44 ± 12%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.30 ± 39%     -57.1%       0.13 ± 24%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.23 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.d_alloc_parallel.lookup_open.isra
      0.31 ± 44%     -53.9%       0.14 ± 42%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.27 ± 48%     -75.0%       0.07 ± 87%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    319.33 ±  3%     +20.3%     384.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    315.67 ±  8%    +151.0%     792.33 ± 44%  perf-sched.wait_and_delay.count.__cond_resched.down_read.walk_component.link_path_walk.part
     64.67 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.d_alloc_parallel.lookup_open.isra
    308.00 ±  6%    +156.7%     790.50 ± 43%  perf-sched.wait_and_delay.count.__cond_resched.dput.step_into.link_path_walk.part
    156.50 ±  9%    +230.7%     517.50 ± 44%  perf-sched.wait_and_delay.count.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      5.99 ± 59%     -36.6%       3.80 ± 17%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      3.70 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.d_alloc_parallel.lookup_open.isra
     16.00 ±  5%     -22.3%      12.43 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.29 ± 41%     -56.7%       0.13 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.29 ± 44%     -52.4%       0.14 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.13 ± 74%     -89.5%       0.01 ± 68%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      5.99 ± 59%     -36.6%       3.80 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      3.70 ± 28%     -96.7%       0.12 ±196%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.lookup_open.isra
      0.06 ±112%   +2221.3%       1.45 ±125%  perf-sched.wait_time.max.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
      0.30 ±108%     -96.1%       0.01 ±131%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.81 ± 70%     -94.0%       0.11 ±111%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
 1.048e+10           -21.8%  8.197e+09        perf-stat.i.branch-instructions
      1.00            -0.1        0.89        perf-stat.i.branch-miss-rate%
  1.05e+08           -30.3%   73134213 ±  2%  perf-stat.i.branch-misses
     35.70            +0.3       35.98        perf-stat.i.cache-miss-rate%
 1.008e+08           -24.9%   75751256 ±  3%  perf-stat.i.cache-misses
  2.83e+08           -25.4%  2.111e+08 ±  2%  perf-stat.i.cache-references
      4.49           +32.2%       5.93        perf-stat.i.cpi
    174.91 ±  2%      -4.7%     166.67        perf-stat.i.cpu-migrations
      2252           +33.2%       3000 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.05 ±  2%      -0.0        0.05 ±  4%  perf-stat.i.dTLB-load-miss-rate%
   6988598 ±  2%     -33.9%    4620724 ±  5%  perf-stat.i.dTLB-load-misses
 1.302e+10           -24.6%  9.823e+09        perf-stat.i.dTLB-loads
   4558908           -36.1%    2913949 ±  5%  perf-stat.i.dTLB-store-misses
 5.495e+09           -35.3%  3.553e+09 ±  2%  perf-stat.i.dTLB-stores
 5.059e+10           -24.2%  3.834e+10        perf-stat.i.instructions
      0.22           -24.2%       0.17        perf-stat.i.ipc
    739.08 ±  2%      -5.7%     697.01 ±  2%  perf-stat.i.major-faults
    968.40           -27.6%     701.00 ±  2%  perf-stat.i.metric.K/sec
    457.35           -25.6%     340.23        perf-stat.i.metric.M/sec
    838500           -36.9%     529483 ±  6%  perf-stat.i.minor-faults
     86.42            +0.9       87.32        perf-stat.i.node-load-miss-rate%
  25059767           -27.3%   18222191 ±  2%  perf-stat.i.node-load-misses
   4000499           -33.0%    2680018 ±  3%  perf-stat.i.node-loads
     50.38            +6.6       57.02        perf-stat.i.node-store-miss-rate%
  13448084           -15.2%   11398580 ±  2%  perf-stat.i.node-store-misses
  13256380           -35.1%    8604744 ±  3%  perf-stat.i.node-stores
    839239           -36.8%     530180 ±  6%  perf-stat.i.page-faults
      1.00            -0.1        0.89        perf-stat.overall.branch-miss-rate%
      4.47           +32.1%       5.90        perf-stat.overall.cpi
      2240           +33.4%       2989 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.05 ±  2%      -0.0        0.05 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.22           -24.3%       0.17        perf-stat.overall.ipc
     86.23            +0.9       87.17        perf-stat.overall.node-load-miss-rate%
     50.31            +6.7       56.98        perf-stat.overall.node-store-miss-rate%
 1.031e+10           -21.8%  8.064e+09        perf-stat.ps.branch-instructions
 1.033e+08           -30.4%   71969923 ±  2%  perf-stat.ps.branch-misses
  99277019           -24.9%   74527038 ±  3%  perf-stat.ps.cache-misses
 2.788e+08           -25.5%  2.078e+08 ±  2%  perf-stat.ps.cache-references
    172.95 ±  2%      -5.0%     164.38        perf-stat.ps.cpu-migrations
   6885676 ±  2%     -33.9%    4553176 ±  5%  perf-stat.ps.dTLB-load-misses
 1.281e+10           -24.6%  9.664e+09        perf-stat.ps.dTLB-loads
   4487277           -36.1%    2866955 ±  5%  perf-stat.ps.dTLB-store-misses
 5.409e+09           -35.4%  3.496e+09 ±  2%  perf-stat.ps.dTLB-stores
 4.978e+10           -24.2%  3.772e+10        perf-stat.ps.instructions
    730.48 ±  2%      -6.0%     686.30 ±  2%  perf-stat.ps.major-faults
    825030           -36.9%     520850 ±  6%  perf-stat.ps.minor-faults
  24668497           -27.3%   17925430 ±  2%  perf-stat.ps.node-load-misses
   3938602           -33.0%    2639269 ±  3%  perf-stat.ps.node-loads
  13233380           -15.3%   11211671 ±  2%  perf-stat.ps.node-store-misses
  13071889           -35.2%    8468100 ±  3%  perf-stat.ps.node-stores
    825761           -36.8%     521536 ±  6%  perf-stat.ps.page-faults
 3.025e+12           -24.2%  2.292e+12        perf-stat.total.instructions
     17.91           -17.9        0.00        perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_openat.do_filp_open
     17.80           -17.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.terminate_walk.path_openat
     17.76           -17.8        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.terminate_walk
     11.21           -11.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lock_for_kill.dput.d_alloc_parallel
     11.13           -11.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.d_alloc_parallel
     20.36           -11.0        9.34        perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
     10.16           -10.2        0.00        perf-profile.calltrace.cycles-pp.lock_for_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
     10.12           -10.1        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.lock_for_kill.dput.d_alloc_parallel.__lookup_slow
     10.08           -10.1        0.00        perf-profile.calltrace.cycles-pp.fast_dput.dput.d_alloc_parallel.__lookup_slow.walk_component
     10.03           -10.0        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.d_alloc_parallel.__lookup_slow
     19.36            -7.3       12.05        perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      5.20            -5.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lock_for_kill.dput.step_into
     31.83            -4.1       27.72        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
     31.85            -4.0       27.81        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
      5.99            -2.8        3.16        perf-profile.calltrace.cycles-pp.dput.step_into.open_last_lookups.path_openat.do_filp_open
      6.51            -2.8        3.70        perf-profile.calltrace.cycles-pp.step_into.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      6.06            -2.8        3.28 ±  2%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      6.01            -2.8        3.24 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_filp_open
      5.12 ±  2%      -1.9        3.22 ±  4%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.08            -1.9        3.20 ±  4%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.90 ±  2%      -1.8        3.10 ±  4%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.70 ±  2%      -1.7        2.97 ±  4%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      6.69            -1.7        5.01 ±  2%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      6.60            -1.6        4.95 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
      6.59            -1.6        4.95 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
      6.59            -1.6        4.95 ±  2%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
      3.27            -1.4        1.88 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.26            -1.4        1.88 ±  3%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.25            -1.4        1.87 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.21            -1.4        1.85 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      2.36            -1.0        1.34 ±  3%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      2.65 ±  2%      -1.0        1.69 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      2.58 ±  2%      -0.9        1.65 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      1.81 ±  2%      -0.7        1.14 ±  3%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      1.38 ±  3%      -0.7        0.71 ±  6%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.74 ±  2%      -0.7        1.08 ±  5%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.59 ±  2%      -0.6        0.98 ±  5%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      1.05 ±  4%      -0.6        0.44 ± 44%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      1.58 ±  2%      -0.6        0.97 ±  5%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.38 ±  2%      -0.5        0.85 ±  5%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.30 ±  2%      -0.5        0.80 ±  5%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.84 ±  3%      -0.5        0.35 ± 70%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.60            -0.5        3.13 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_openat
      3.54            -0.5        3.09        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
      3.47            -0.4        3.05 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open
      1.08 ±  2%      -0.4        0.66 ±  6%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.79 ±  4%      -0.3        0.51 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.35 ± 70%      +0.2        0.54        perf-profile.calltrace.cycles-pp.pick_link.step_into.open_last_lookups.path_openat.do_filp_open
     96.74            +1.2       97.95        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.70            +1.2       97.92        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.79            +2.2       46.02        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +3.1        3.12        perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.open_last_lookups
      0.00            +3.2        3.15        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.open_last_lookups.path_openat
     18.05            +4.6       22.68        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
     17.98            +4.7       22.69        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
     87.45            +4.8       92.28        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     87.43            +4.8       92.26        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     86.69            +5.1       91.80        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     86.61            +5.1       91.75        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     17.94            +5.4       23.31        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     17.92            +5.4       23.30        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      2.66            +6.1        8.79 ±  2%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      2.63            +6.1        8.77 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
     11.73            +6.2       17.98        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
     11.61            +6.3       17.88        perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
     11.60            +6.3       17.87        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
     11.61            +6.3       17.88        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
     11.02            +6.7       17.67        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
     11.14            +6.7       17.83        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
     11.25            +6.7       18.00        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
     46.59            +8.3       54.90        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +8.6        8.64 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.link_path_walk
      0.00            +8.7        8.72 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_openat
      0.00            +9.2        9.17        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel
      0.00            +9.3        9.26        perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      0.00            +9.3        9.33        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.00           +11.6       11.63        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
      0.00           +23.1       23.15        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00           +23.2       23.18        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
     32.44           -32.4        0.00        perf-profile.children.cycles-pp.fast_dput
     16.62           -16.6        0.00        perf-profile.children.cycles-pp.lock_for_kill
     19.36            -7.3       12.06        perf-profile.children.cycles-pp.open_last_lookups
     37.84            -6.9       30.96        perf-profile.children.cycles-pp.d_alloc_parallel
     49.26            -4.6       44.64        perf-profile.children.cycles-pp.dput
     31.85            -4.0       27.81        perf-profile.children.cycles-pp.__lookup_slow
      6.06            -2.8        3.28 ±  2%  perf-profile.children.cycles-pp.lookup_open
      5.96            -2.4        3.60 ±  3%  perf-profile.children.cycles-pp.do_vmi_munmap
      5.86            -2.3        3.54 ±  3%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      5.17            -1.9        3.25 ±  4%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      5.12            -1.9        3.22 ±  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      4.99 ±  2%      -1.8        3.16 ±  4%  perf-profile.children.cycles-pp.do_mmap
      4.79 ±  2%      -1.8        3.03 ±  4%  perf-profile.children.cycles-pp.mmap_region
      3.27            -1.4        1.89 ±  3%  perf-profile.children.cycles-pp.__x64_sys_munmap
      3.26            -1.4        1.88 ±  3%  perf-profile.children.cycles-pp.__vm_munmap
      2.88 ±  2%      -1.2        1.69 ±  3%  perf-profile.children.cycles-pp.unmap_region
      2.36 ±  2%      -0.9        1.48 ±  3%  perf-profile.children.cycles-pp.__split_vma
      1.80 ±  2%      -0.7        1.11 ±  5%  perf-profile.children.cycles-pp.asm_exc_page_fault
      1.39 ±  3%      -0.7        0.72 ±  6%  perf-profile.children.cycles-pp.alloc_empty_file
      1.63 ±  2%      -0.6        1.00 ±  5%  perf-profile.children.cycles-pp.exc_page_fault
      1.62 ±  2%      -0.6        1.00 ±  5%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.42 ±  2%      -0.6        0.87 ±  5%  perf-profile.children.cycles-pp.handle_mm_fault
      1.06 ±  4%      -0.5        0.52 ±  8%  perf-profile.children.cycles-pp.init_file
      1.40 ±  5%      -0.5        0.87 ±  4%  perf-profile.children.cycles-pp.down_write
      1.24 ±  3%      -0.5        0.72 ±  2%  perf-profile.children.cycles-pp.free_pgtables
      1.34 ±  2%      -0.5        0.82 ±  5%  perf-profile.children.cycles-pp.__handle_mm_fault
      1.01 ±  4%      -0.5        0.49 ±  7%  perf-profile.children.cycles-pp.security_file_alloc
      0.89 ±  4%      -0.5        0.42 ±  8%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      1.14 ±  6%      -0.4        0.70 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.11 ±  2%      -0.4        0.68 ±  6%  perf-profile.children.cycles-pp.do_fault
      1.06            -0.4        0.64 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.99 ±  3%      -0.4        0.57 ±  3%  perf-profile.children.cycles-pp.unlink_file_vma
      1.07 ±  6%      -0.4        0.66 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.10 ±  4%      -0.4        0.71 ±  3%  perf-profile.children.cycles-pp.vma_prepare
      1.03 ±  9%      -0.4        0.68 ±  8%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.87 ±  2%      -0.4        0.52 ±  7%  perf-profile.children.cycles-pp.do_read_fault
      0.79 ±  3%      -0.3        0.44 ±  4%  perf-profile.children.cycles-pp.release_empty_file
      0.85 ±  2%      -0.3        0.51 ±  7%  perf-profile.children.cycles-pp.filemap_map_pages
      1.04 ±  9%      -0.3        0.70 ±  7%  perf-profile.children.cycles-pp.rcu_core
      1.04 ±  9%      -0.3        0.70 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      1.04 ±  8%      -0.3        0.71 ±  7%  perf-profile.children.cycles-pp.__do_softirq
      1.38 ±  7%      -0.3        1.04 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.36 ±  7%      -0.3        1.02 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.57 ±  4%      -0.3        0.24 ±  8%  perf-profile.children.cycles-pp.security_file_free
      0.56 ±  4%      -0.3        0.23 ±  9%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.88 ±  2%      -0.3        0.56 ±  4%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.76 ±  2%      -0.3        0.44 ±  4%  perf-profile.children.cycles-pp.unmap_vmas
      0.78 ±  2%      -0.3        0.47 ±  5%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.80            -0.3        0.50 ±  4%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.80 ±  2%      -0.3        0.50 ±  3%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.77 ±  2%      -0.3        0.47 ±  3%  perf-profile.children.cycles-pp._dl_catch_exception
      0.70 ±  2%      -0.3        0.40 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
      0.81            -0.3        0.51 ±  4%  perf-profile.children.cycles-pp.vma_complete
      0.65 ±  2%      -0.3        0.37 ±  5%  perf-profile.children.cycles-pp.zap_pmd_range
      0.69 ±  2%      -0.3        0.43 ±  4%  perf-profile.children.cycles-pp.mprotect_fixup
      0.62 ±  2%      -0.3        0.36 ±  5%  perf-profile.children.cycles-pp.zap_pte_range
      0.67            -0.3        0.42 ±  3%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.56            -0.2        0.34 ±  3%  perf-profile.children.cycles-pp.mas_store_gfp
      0.54 ±  2%      -0.2        0.32 ±  8%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.56            -0.2        0.33 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
      0.50 ± 10%      -0.2        0.28 ±  4%  perf-profile.children.cycles-pp.osq_lock
      0.54            -0.2        0.32 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.56 ±  3%      -0.2        0.35 ±  4%  perf-profile.children.cycles-pp.vma_modify
      0.60 ±  4%      -0.2        0.39 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.49 ±  2%      -0.2        0.30 ±  5%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.46 ±  2%      -0.2        0.29 ±  5%  perf-profile.children.cycles-pp.flush_tlb_func
      0.44 ±  2%      -0.2        0.27 ±  4%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.45 ±  2%      -0.2        0.28 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.50 ±  2%      -0.2        0.34 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.41 ±  2%      -0.2        0.25 ±  3%  perf-profile.children.cycles-pp.up_write
      0.38            -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.getname_flags
      0.44 ±  8%      -0.1        0.30 ±  8%  perf-profile.children.cycles-pp.__slab_free
      0.36            -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.30 ±  4%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.do_open
      0.38            -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.35            -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.30 ±  2%      -0.1        0.17 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.31 ±  2%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.mas_wr_spanning_store
      0.27 ±  3%      -0.1        0.15 ±  5%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.26            -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
      0.25 ±  4%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.27            -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.23            -0.1        0.13 ± 13%  perf-profile.children.cycles-pp._compound_head
      0.21 ±  5%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.do_dentry_open
      0.23 ±  4%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.26            -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.mas_split
      0.26 ±  9%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.26 ±  3%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.strncpy_from_user
      0.22 ±  4%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.task_work_run
      0.24            -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.mas_preallocate
      0.24            -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.mas_spanning_rebalance
      0.24 ±  2%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.23            -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.23 ±  2%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.vm_area_alloc
      0.22 ±  3%      -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.24 ±  5%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.mod_objcg_state
      0.22 ±  2%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.___slab_alloc
      0.23 ±  3%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.do_cow_fault
      0.24 ±  3%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.lockref_put_return
      0.19 ±  4%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.release_pages
      0.18 ±  4%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.__fput
      0.21 ±  3%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.vma_expand
      0.17 ±  3%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.set_pte_range
      0.18 ±  2%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.get_unmapped_area
      0.20 ±  6%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.17 ±  2%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.mas_walk
      0.18 ±  2%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.16            -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.mtree_range_walk
      0.14 ±  2%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.d_path
      0.11 ±  6%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.security_mmap_file
      0.10 ±  5%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.apparmor_mmap_file
      0.16 ±  4%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.13 ±  5%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.page_remove_rmap
      0.14            -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.allocate_slab
      0.14 ±  3%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.mas_find
      0.15            -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.mas_topiary_replace
      0.14            -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.14 ±  6%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__check_object_size
      0.27            -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.__call_rcu_common
      0.14 ±  2%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.13 ±  2%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.sync_regs
      0.14 ±  4%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.14 ±  3%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.wp_page_copy
      0.08 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.mas_update_gap
      0.14 ±  3%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.alloc_fd
      0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mas_push_data
      0.12 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__rb_erase_color
      0.10 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.shuffle_freelist
      0.10 ±  3%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.mas_next_slot
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.11 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.vfs_read
      0.10 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.prepend_path
      0.07 ±  5%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.check_heap_object
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.12 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.10            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.09            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.lru_add_drain
      0.09 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.mab_mas_cp
      0.08 ±  4%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.mas_destroy
      0.08            -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__perf_sw_event
      0.11 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.ksys_read
      0.10 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.10 ±  9%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.09 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.10 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.mas_wr_walk
      0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.09 ±  7%      -0.0        0.06        perf-profile.children.cycles-pp.__alloc_pages
      0.08            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.08 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__memcpy
      0.08 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.mas_prev_slot
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.up_read
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.16 ±  5%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.down_read
      0.06 ±  6%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.simple_lookup
      0.05 ±  7%      +0.1        0.11 ±  5%  perf-profile.children.cycles-pp.__d_add
     97.48            +0.9       98.42        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     97.44            +1.0       98.40        perf-profile.children.cycles-pp.do_syscall_64
     43.80            +2.2       46.04        perf-profile.children.cycles-pp.walk_component
      9.17            +3.3       12.49        perf-profile.children.cycles-pp.step_into
     18.44            +4.6       23.01        perf-profile.children.cycles-pp.lookup_fast
     18.86            +4.6       23.51        perf-profile.children.cycles-pp.lockref_get_not_dead
     18.70            +4.7       23.37        perf-profile.children.cycles-pp.__legitimize_path
     18.71            +4.7       23.38        perf-profile.children.cycles-pp.try_to_unlazy
     87.46            +4.8       92.29        perf-profile.children.cycles-pp.__x64_sys_openat
     87.45            +4.8       92.28        perf-profile.children.cycles-pp.do_sys_openat2
     86.70            +5.1       91.81        perf-profile.children.cycles-pp.do_filp_open
     86.63            +5.1       91.77        perf-profile.children.cycles-pp.path_openat
     17.95            +5.4       23.33        perf-profile.children.cycles-pp.terminate_walk
     14.86            +6.3       21.14        perf-profile.children.cycles-pp.d_alloc
     82.15            +6.4       88.52        perf-profile.children.cycles-pp._raw_spin_lock
     81.53            +6.4       87.92        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     46.61            +8.3       54.92        perf-profile.children.cycles-pp.link_path_walk
      0.17 ±  2%     +21.1       21.25        perf-profile.children.cycles-pp.__dentry_kill
      0.88 ±  4%      -0.5        0.41 ±  8%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.56 ±  5%      -0.3        0.23 ±  9%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.87 ±  2%      -0.3        0.55 ±  4%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.49 ± 10%      -0.2        0.28 ±  4%  perf-profile.self.cycles-pp.osq_lock
      0.51 ±  2%      -0.2        0.30 ±  8%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.44 ±  2%      -0.2        0.27 ±  4%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.50 ±  2%      -0.2        0.33 ±  5%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.44 ±  3%      -0.2        0.28 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.40 ±  2%      -0.2        0.25 ±  3%  perf-profile.self.cycles-pp.up_write
      0.37            -0.2        0.22 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.42 ±  8%      -0.1        0.29 ±  8%  perf-profile.self.cycles-pp.__slab_free
      0.37 ±  3%      -0.1        0.24 ±  4%  perf-profile.self.cycles-pp.kmem_cache_free
      0.28            -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.22            -0.1        0.12 ± 14%  perf-profile.self.cycles-pp._compound_head
      0.23 ±  3%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.down_write
      0.24 ±  2%      -0.1        0.15 ±  3%  perf-profile.self.cycles-pp.lockref_put_return
      0.22 ±  4%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.mod_objcg_state
      0.20 ±  6%      -0.1        0.13 ±  9%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.17 ±  3%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.zap_pte_range
      0.34            -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.16 ±  2%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.mtree_range_walk
      0.09 ±  5%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.apparmor_mmap_file
      0.15 ±  3%      -0.1        0.09 ±  6%  perf-profile.self.cycles-pp.filemap_map_pages
      0.14 ±  3%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.08 ±  8%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.link_path_walk
      0.13 ±  5%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.12 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.page_remove_rmap
      0.08 ±  6%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__split_vma
      0.07 ±  6%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.13            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.sync_regs
      0.12 ±  4%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.08            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.shuffle_freelist
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.do_filp_open
      0.12 ±  3%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.09 ±  5%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.mas_next_slot
      0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.strncpy_from_user
      0.08 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.mab_mas_cp
      0.11 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.10            -0.0        0.06        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  5%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.release_pages
      0.11 ±  3%      -0.0        0.07        perf-profile.self.cycles-pp.__cond_resched
      0.10 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__rb_erase_color
      0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__call_rcu_common
      0.12 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.10 ±  3%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.mas_topiary_replace
      0.10 ±  4%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.mmap_region
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mas_wr_walk
      0.22 ±  3%      -0.0        0.20 ±  4%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.07            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.08            -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.up_read
      0.15 ±  3%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.down_read
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__dentry_kill
      0.10 ±  5%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.d_alloc_parallel
     80.37            +6.6       86.99        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s

commit: 
  b4cc0734d2 ("d_prune_aliases(): use a shrink list")
  1c18edd1b7 ("__dentry_kill(): new locking scheme")

b4cc0734d25746d4 1c18edd1b7a068e07fed7f00e05 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.10 ±  4%     -14.3%       0.09        turbostat.IPC
    338724 ±  3%     -30.5%     235420 ±  3%  stress-ng.sysinfo.ops
      5645 ±  3%     -30.5%       3923 ±  3%  stress-ng.sysinfo.ops_per_sec
    463895            +9.8%     509584        proc-vmstat.numa_hit
    395830           +12.0%     443348        proc-vmstat.numa_local
    551165           +15.9%     639027        proc-vmstat.pgalloc_normal
    508650           +17.5%     597607        proc-vmstat.pgfree
      0.17 ± 55%     -85.9%       0.02 ± 76%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.11 ±149%     -89.5%       0.22 ±109%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.17 ± 46%     -70.0%       0.05 ± 81%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.kernfs_iop_permission.inode_permission.link_path_walk
      0.16 ± 64%     -70.7%       0.05 ±151%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.24 ± 74%     -94.1%       0.01 ± 96%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.vfs_statx.__do_sys_newstat
      0.17 ± 55%     -84.1%       0.03 ± 58%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.69 ± 44%     -78.2%       0.15 ±117%  perf-sched.wait_time.max.ms.__cond_resched.down_read.kernfs_iop_permission.inode_permission.link_path_walk
      0.57 ± 68%     -86.1%       0.08 ±172%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.53 ± 42%     -96.1%       0.02 ± 97%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.vfs_statx.__do_sys_newstat
      2.11 ±149%     -86.9%       0.28 ± 85%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.71 ±  4%      +9.4%       1.87 ±  4%  perf-stat.i.MPKI
 1.161e+09 ±  2%     -14.0%  9.982e+08        perf-stat.i.branch-instructions
  23875764 ±  3%      -8.9%   21751878 ±  2%  perf-stat.i.cache-references
      3.82 ±  2%     +20.6%       4.61        perf-stat.i.cpi
 1.474e+09 ±  2%     -15.4%  1.247e+09        perf-stat.i.dTLB-loads
     47417 ± 11%     -12.5%      41490        perf-stat.i.dTLB-store-misses
 7.252e+08 ±  3%     -20.1%  5.793e+08 ±  2%  perf-stat.i.dTLB-stores
 5.773e+09 ±  2%     -15.2%  4.895e+09 ±  2%  perf-stat.i.instructions
      0.27 ±  2%     -15.7%       0.23        perf-stat.i.ipc
    517.29 ±  2%      -8.9%     471.04 ±  2%  perf-stat.i.metric.K/sec
     52.46 ±  2%     -16.0%      44.08        perf-stat.i.metric.M/sec
     87.04            +2.5       89.49        perf-stat.i.node-store-miss-rate%
    571361 ±  6%     -22.1%     445036 ±  4%  perf-stat.i.node-stores
      1.61 ±  4%      +7.4%       1.73 ±  4%  perf-stat.overall.MPKI
      3.60 ±  2%     +18.1%       4.25        perf-stat.overall.cpi
      0.28 ±  2%     -15.3%       0.24        perf-stat.overall.ipc
     86.25            +2.3       88.53        perf-stat.overall.node-store-miss-rate%
 1.141e+09 ±  2%     -14.0%  9.808e+08        perf-stat.ps.branch-instructions
  23469608 ±  3%      -8.9%   21382589 ±  2%  perf-stat.ps.cache-references
 1.449e+09 ±  2%     -15.4%  1.225e+09        perf-stat.ps.dTLB-loads
     46583 ± 11%     -12.5%      40740        perf-stat.ps.dTLB-store-misses
 7.129e+08 ±  3%     -20.1%  5.694e+08 ±  2%  perf-stat.ps.dTLB-stores
 5.674e+09 ±  2%     -15.2%  4.809e+09 ±  2%  perf-stat.ps.instructions
    560788 ±  6%     -22.2%     436272 ±  4%  perf-stat.ps.node-stores
 3.437e+11 ±  2%     -14.8%  2.927e+11        perf-stat.total.instructions
     18.99 ±  2%     -19.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.terminate_walk
     18.47           -18.5        0.00        perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_lookupat.filename_lookup
     17.16           -17.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.terminate_walk.path_lookupat
      8.33            -7.6        0.74 ± 10%  perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
     16.71            -4.2       12.53        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup
     16.94            -3.9       13.02        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      9.53            -2.5        7.06        perf-profile.calltrace.cycles-pp.open64
      9.44            -2.4        7.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      9.43            -2.4        7.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      9.41            -2.4        6.98        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      9.40            -2.4        6.97        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      8.87 ±  2%      -2.3        6.60        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.84 ±  2%      -2.3        6.58        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      7.92            -2.2        5.74        perf-profile.calltrace.cycles-pp.__xstat64
      7.84            -2.2        5.69        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
      7.83            -2.2        5.68        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      7.80            -2.1        5.66        perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      7.48            -2.0        5.44        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      6.70            -1.8        4.85        perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.67            -1.8        4.83        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      6.94 ±  2%      -1.8        5.12        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      7.35 ±  2%      -1.6        5.71        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk
      6.08            -1.4        4.65        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat
      6.13            -1.4        4.72        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup
      3.38            -1.0        2.38        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      1.76 ±  4%      -0.9        0.84 ±  3%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
      4.11            -0.9        3.23        perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      3.34 ±  2%      -0.8        2.50        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.28 ±  5%      -0.7        1.54 ±  6%  perf-profile.calltrace.cycles-pp.syscall
      2.20 ±  5%      -0.7        1.49 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      2.19 ±  5%      -0.7        1.48 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.16 ±  5%      -0.7        1.46 ±  6%  perf-profile.calltrace.cycles-pp.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.67 ±  3%      -0.7        0.99 ±  2%  perf-profile.calltrace.cycles-pp.__close
      1.59 ±  3%      -0.7        0.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      1.58 ±  3%      -0.7        0.93        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.55 ±  3%      -0.6        0.91        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.03 ±  4%      -0.6        1.45 ±  3%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.92 ± 24%      -0.6        0.35 ± 77%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
      1.29 ±  3%      -0.6        0.73 ±  3%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.55 ±  2%      -0.6        1.99        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.54 ±  2%      -0.6        1.98        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      1.18 ±  3%      -0.5        0.63 ±  5%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.path_lookupat.filename_lookup
      1.58 ±  6%      -0.5        1.04 ±  3%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.04 ±  2%      -0.5        1.51 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      1.43 ±  8%      -0.5        0.90 ±  5%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      2.19            -0.5        1.68 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      2.18            -0.5        1.68 ±  2%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      1.45 ±  5%      -0.5        0.99 ±  2%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      2.02 ±  2%      -0.4        1.58        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_openat
      2.04 ±  2%      -0.4        1.61 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.do_filp_open
      2.05 ±  2%      -0.4        1.62 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.24 ±  5%      -0.4        0.82 ±  6%  perf-profile.calltrace.cycles-pp.user_get_super.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.73 ±  5%      -0.4        0.33 ± 77%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.88 ±  7%      -0.4        0.52 ± 38%  perf-profile.calltrace.cycles-pp.shmem_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64
      1.21 ±  3%      -0.4        0.86 ±  3%  perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      1.20 ±  3%      -0.4        0.85 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
      0.90 ±  6%      -0.3        0.62 ±  7%  perf-profile.calltrace.cycles-pp.fstatfs64
      0.97 ±  6%      -0.3        0.70 ±  4%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      0.83 ±  4%      -0.3        0.56 ±  5%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
      0.96 ±  6%      -0.3        0.70 ±  4%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.88 ±  3%      -0.2        0.66 ±  3%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      0.63 ±  8%      +0.3        0.89 ±  3%  perf-profile.calltrace.cycles-pp.down_read.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      0.50 ± 38%      +0.3        0.84 ±  6%  perf-profile.calltrace.cycles-pp.__legitimize_mnt.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      0.00            +0.7        0.68 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      0.00            +0.7        0.73 ± 10%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.00            +1.2        1.25 ±  4%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_lookupat.filename_lookup
     31.36            +1.7       33.06        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      0.00            +1.7        1.74        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00            +1.8        1.80        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      5.64 ±  2%      +2.7        8.30        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
      7.18 ±  2%      +2.7        9.86        perf-profile.calltrace.cycles-pp.step_into.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      6.84            +2.8        9.60        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
      6.30 ±  2%      +2.8        9.09        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      6.65 ±  2%      +2.8        9.48        perf-profile.calltrace.cycles-pp.dput.step_into.path_lookupat.filename_lookup.user_path_at_empty
     17.42 ±  2%      +4.3       21.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
     16.32            +5.4       21.68        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty
     16.37            +5.4       21.73        perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
     13.30            +5.4       18.71        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.user_path_at_empty
     11.21 ±  2%      +5.8       17.01        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
     10.63 ±  2%      +5.9       16.54        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
     11.77 ±  2%      +6.1       17.85        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.path_lookupat
     11.79 ±  2%      +6.1       17.87        perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.path_lookupat.filename_lookup
     68.75            +6.1       74.86        perf-profile.calltrace.cycles-pp.__statfs
     68.47            +6.2       74.64        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__statfs
     68.42            +6.2       74.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     68.29            +6.2       74.52        perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     68.05            +6.3       74.36        perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     65.70            +7.1       72.79        perf-profile.calltrace.cycles-pp.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
     63.65            +7.3       70.97        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
     63.48            +7.4       70.85        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs
      0.00            +7.4        7.42 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
      0.00            +8.6        8.58 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.path_lookupat
      0.13 ±173%      +9.2        9.29        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.path_lookupat.filename_lookup
      0.00           +21.7       21.66        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_lookupat
      0.00           +22.0       21.96        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_lookupat.filename_lookup
     29.04           -29.0        0.00        perf-profile.children.cycles-pp.fast_dput
      8.31            -8.3        0.00        perf-profile.children.cycles-pp.lock_for_kill
     16.74            -4.2       12.57        perf-profile.children.cycles-pp.d_alloc_parallel
     16.96            -3.9       13.05        perf-profile.children.cycles-pp.__lookup_slow
     13.80            -3.7       10.14        perf-profile.children.cycles-pp.link_path_walk
      9.55            -2.5        7.08        perf-profile.children.cycles-pp.open64
      9.57            -2.4        7.16        perf-profile.children.cycles-pp.__x64_sys_openat
      9.56            -2.4        7.15        perf-profile.children.cycles-pp.do_sys_openat2
      9.05 ±  2%      -2.3        6.78        perf-profile.children.cycles-pp.do_filp_open
      9.02 ±  2%      -2.3        6.77        perf-profile.children.cycles-pp.path_openat
      7.94            -2.2        5.76        perf-profile.children.cycles-pp.__xstat64
      7.84            -2.1        5.71        perf-profile.children.cycles-pp.__do_sys_newstat
      7.52            -2.0        5.49        perf-profile.children.cycles-pp.vfs_statx
     38.36            -1.2       37.11        perf-profile.children.cycles-pp.dput
      2.90 ±  9%      -1.0        1.86 ±  4%  perf-profile.children.cycles-pp.inode_permission
      2.71 ±  6%      -0.9        1.81 ±  4%  perf-profile.children.cycles-pp.statfs_by_dentry
      2.31 ±  5%      -0.8        1.56 ±  6%  perf-profile.children.cycles-pp.syscall
      2.16 ±  5%      -0.7        1.46 ±  6%  perf-profile.children.cycles-pp.__do_sys_ustat
      1.69 ±  3%      -0.7        1.02 ±  2%  perf-profile.children.cycles-pp.__close
      1.80 ±  8%      -0.7        1.14 ±  5%  perf-profile.children.cycles-pp.kernfs_iop_permission
      1.56 ±  3%      -0.6        0.92        perf-profile.children.cycles-pp.__x64_sys_close
      2.20 ±  4%      -0.6        1.60 ±  3%  perf-profile.children.cycles-pp.complete_walk
      1.61 ±  4%      -0.6        1.02 ±  4%  perf-profile.children.cycles-pp.__d_lookup_rcu
      2.04 ±  4%      -0.6        1.46 ±  2%  perf-profile.children.cycles-pp.do_open
      1.83 ±  7%      -0.6        1.26 ±  4%  perf-profile.children.cycles-pp.__percpu_counter_sum
      2.57 ±  3%      -0.6        2.00 ±  2%  perf-profile.children.cycles-pp.lockref_put_return
      1.29 ±  3%      -0.6        0.74 ±  3%  perf-profile.children.cycles-pp.__fput
      1.55 ±  6%      -0.5        1.05 ±  6%  perf-profile.children.cycles-pp.shmem_statfs
      1.42            -0.5        0.95 ±  3%  perf-profile.children.cycles-pp.lockref_get
      1.46 ±  5%      -0.5        1.00 ±  2%  perf-profile.children.cycles-pp.do_dentry_open
      1.24 ±  5%      -0.4        0.82 ±  6%  perf-profile.children.cycles-pp.user_get_super
      0.48 ±  5%      -0.4        0.10 ± 18%  perf-profile.children.cycles-pp._raw_spin_trylock
      1.20 ±  4%      -0.4        0.83 ±  3%  perf-profile.children.cycles-pp.getname_flags
      2.50 ±  4%      -0.4        2.14        perf-profile.children.cycles-pp.down_read
      0.61 ±  4%      -0.3        0.27 ±  4%  perf-profile.children.cycles-pp.dcache_dir_close
      1.11 ± 10%      -0.3        0.77 ± 11%  perf-profile.children.cycles-pp.up_read
      0.96 ±  6%      -0.3        0.66 ±  7%  perf-profile.children.cycles-pp.fstatfs64
      0.80 ±  2%      -0.3        0.52 ±  3%  perf-profile.children.cycles-pp.__traverse_mounts
      0.60 ± 15%      -0.2        0.37 ±  9%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      0.76 ±  4%      -0.2        0.53 ±  4%  perf-profile.children.cycles-pp.strncpy_from_user
      1.04 ±  3%      -0.2        0.81 ±  3%  perf-profile.children.cycles-pp.try_to_unlazy_next
      0.84 ±  2%      -0.2        0.63 ±  3%  perf-profile.children.cycles-pp.path_put
      0.56 ±  4%      -0.2        0.36 ±  7%  perf-profile.children.cycles-pp.kmem_cache_free
      0.66 ±  5%      -0.2        0.46 ±  6%  perf-profile.children.cycles-pp.__do_sys_fstatfs
      0.59 ±  7%      -0.2        0.40 ±  9%  perf-profile.children.cycles-pp.__d_lookup
      0.61 ±  8%      -0.2        0.43 ±  2%  perf-profile.children.cycles-pp.alloc_empty_file
      0.58 ± 15%      -0.2        0.40 ± 11%  perf-profile.children.cycles-pp.ext4_statfs
      0.54 ±  8%      -0.2        0.37 ±  5%  perf-profile.children.cycles-pp.dcache_dir_open
      0.42 ±  6%      -0.2        0.25 ±  7%  perf-profile.children.cycles-pp.path_init
      0.54 ±  8%      -0.2        0.37 ±  5%  perf-profile.children.cycles-pp.d_alloc_cursor
      0.57 ±  6%      -0.2        0.40 ±  6%  perf-profile.children.cycles-pp.fd_statfs
      0.34 ±  6%      -0.2        0.19 ±  8%  perf-profile.children.cycles-pp.nd_jump_root
      0.48 ±  6%      -0.1        0.33 ±  8%  perf-profile.children.cycles-pp._find_next_or_bit
      0.46 ±  6%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.46 ±  8%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.init_file
      0.34 ±  6%      -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.super_lock
      0.45 ±  7%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.security_file_alloc
      0.63 ±  6%      -0.1        0.51 ± 15%  perf-profile.children.cycles-pp.rcu_do_batch
      0.39 ±  6%      -0.1        0.27 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      0.42 ±  7%      -0.1        0.29 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.64 ±  5%      -0.1        0.52 ± 14%  perf-profile.children.cycles-pp.rcu_core
      0.40 ±  7%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.31 ±  7%      -0.1        0.21 ±  7%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.29 ±  7%      -0.1        0.20 ±  6%  perf-profile.children.cycles-pp.open_last_lookups
      0.20 ±  9%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.set_root
      0.23 ± 12%      -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.security_file_free
      0.23 ± 13%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.24 ±  6%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.ioctl
      0.20 ±  4%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.simple_statfs
      0.19 ±  9%      -0.1        0.11 ± 14%  perf-profile.children.cycles-pp.generic_permission
      0.25 ±  5%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp._copy_to_user
      0.38 ±  3%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.16 ± 11%      -0.1        0.09 ± 19%  perf-profile.children.cycles-pp.vfs_statfs
      0.22 ±  8%      -0.1        0.16 ± 13%  perf-profile.children.cycles-pp.__cond_resched
      0.19 ±  6%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.do_statfs_native
      0.13 ± 14%      -0.1        0.07 ± 16%  perf-profile.children.cycles-pp.apparmor_file_open
      0.19 ±  8%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.check_heap_object
      0.14 ± 16%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.security_file_open
      0.23 ± 13%      -0.1        0.18 ± 15%  perf-profile.children.cycles-pp.drop_super
      0.16 ±  3%      -0.1        0.11 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.12 ± 16%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.may_open
      0.12 ± 14%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.btrfs_statfs
      0.11 ± 13%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.__check_heap_object
      0.10 ± 13%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.14 ± 12%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.filp_flush
      0.07 ±  8%      -0.0        0.03 ± 78%  perf-profile.children.cycles-pp.kernfs_iop_getattr
      0.13 ±  8%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.security_inode_getattr
      0.11 ±  8%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.autofs_d_manage
      0.12 ±  7%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.common_perm_cond
      0.07 ± 14%      -0.0        0.04 ± 78%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.10 ± 13%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.dnotify_flush
      0.08 ± 10%      -0.0        0.05 ± 38%  perf-profile.children.cycles-pp.cp_new_stat
      0.08 ± 13%      -0.0        0.05 ± 40%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.09 ± 11%      -0.0        0.06 ± 15%  perf-profile.children.cycles-pp.fsnotify_find_mark
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__wake_up
      0.01 ±173%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.__d_lookup_unhash
      0.07 ± 12%      +0.1        0.16 ±  8%  perf-profile.children.cycles-pp.__d_rehash
      0.12 ± 10%      +0.2        0.28 ±  8%  perf-profile.children.cycles-pp.__call_rcu_common
      0.01 ±173%      +0.2        0.20 ± 12%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.20 ±  8%      +0.2        0.44 ±  6%  perf-profile.children.cycles-pp.__d_add
      0.21 ±  9%      +0.2        0.45 ±  6%  perf-profile.children.cycles-pp.simple_lookup
     33.52            +1.1       34.65        perf-profile.children.cycles-pp.walk_component
      8.19 ±  2%      +2.3       10.50        perf-profile.children.cycles-pp.step_into
      6.86            +2.8        9.64        perf-profile.children.cycles-pp.d_alloc
     22.68            +3.0       25.69        perf-profile.children.cycles-pp.lockref_get_not_dead
     23.18            +3.5       26.63        perf-profile.children.cycles-pp.__legitimize_path
     22.23            +3.7       25.89        perf-profile.children.cycles-pp.try_to_unlazy
     21.17            +4.3       25.49        perf-profile.children.cycles-pp.terminate_walk
     15.50            +4.8       20.31        perf-profile.children.cycles-pp.lookup_fast
     70.40            +5.5       75.87        perf-profile.children.cycles-pp.filename_lookup
     70.20            +5.5       75.74        perf-profile.children.cycles-pp.path_lookupat
     63.14            +5.7       68.82        perf-profile.children.cycles-pp._raw_spin_lock
     68.88            +6.1       74.95        perf-profile.children.cycles-pp.__statfs
     58.70            +6.1       64.80        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     68.30            +6.2       74.53        perf-profile.children.cycles-pp.__do_sys_statfs
     68.06            +6.3       74.37        perf-profile.children.cycles-pp.user_statfs
     65.72            +7.1       72.81        perf-profile.children.cycles-pp.user_path_at_empty
      0.86 ±  6%      +9.4       10.30        perf-profile.children.cycles-pp.__dentry_kill
      2.62 ±  3%      -1.0        1.64 ±  4%  perf-profile.self.cycles-pp.lockref_get_not_dead
      1.58 ±  4%      -0.6        1.00 ±  4%  perf-profile.self.cycles-pp.__d_lookup_rcu
      2.53 ±  3%      -0.6        1.98 ±  3%  perf-profile.self.cycles-pp.lockref_put_return
      4.43 ±  3%      -0.4        4.00 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.48 ±  5%      -0.4        0.10 ± 18%  perf-profile.self.cycles-pp._raw_spin_trylock
      1.18 ±  9%      -0.4        0.82 ±  5%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.96 ± 11%      -0.3        0.61 ±  6%  perf-profile.self.cycles-pp.inode_permission
      2.43 ±  4%      -0.3        2.09        perf-profile.self.cycles-pp.down_read
      1.09 ± 10%      -0.3        0.76 ± 11%  perf-profile.self.cycles-pp.up_read
      0.77 ±  3%      -0.3        0.48 ±  5%  perf-profile.self.cycles-pp.lockref_get
      0.59 ±  6%      -0.2        0.39 ±  7%  perf-profile.self.cycles-pp.user_get_super
      0.43 ±  4%      -0.2        0.25 ±  8%  perf-profile.self.cycles-pp.kmem_cache_free
      0.40 ±  6%      -0.1        0.25 ±  6%  perf-profile.self.cycles-pp.do_dentry_open
      0.37 ±  6%      -0.1        0.26 ±  8%  perf-profile.self.cycles-pp._find_next_or_bit
      0.39 ±  7%      -0.1        0.28 ±  3%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.37 ±  7%      -0.1        0.27 ±  8%  perf-profile.self.cycles-pp.strncpy_from_user
      0.30 ±  6%      -0.1        0.20 ±  7%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.28 ±  5%      -0.1        0.18 ±  6%  perf-profile.self.cycles-pp.shmem_statfs
      0.22 ± 12%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.20 ±  3%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.simple_statfs
      0.25 ±  4%      -0.1        0.17 ±  5%  perf-profile.self.cycles-pp._copy_to_user
      0.26 ±  6%      -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.20 ± 10%      -0.1        0.12 ± 12%  perf-profile.self.cycles-pp.statfs_by_dentry
      0.24 ±  9%      -0.1        0.17 ±  6%  perf-profile.self.cycles-pp.link_path_walk
      0.15 ± 12%      -0.1        0.09 ± 20%  perf-profile.self.cycles-pp.vfs_statfs
      0.33 ±  5%      -0.1        0.27 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.13 ± 14%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.apparmor_file_open
      0.19 ± 10%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.filename_lookup
      0.15 ± 11%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.generic_permission
      0.14 ±  7%      -0.1        0.09 ± 13%  perf-profile.self.cycles-pp.lookup_fast
      0.18 ±  9%      -0.1        0.13 ±  7%  perf-profile.self.cycles-pp.step_into
      0.18 ± 14%      -0.1        0.13 ± 11%  perf-profile.self.cycles-pp.__statfs
      0.14 ±  9%      -0.0        0.09 ± 13%  perf-profile.self.cycles-pp.__cond_resched
      0.11 ± 15%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.__check_heap_object
      0.16 ± 12%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.generic_fillattr
      0.11 ± 11%      -0.0        0.07 ± 16%  perf-profile.self.cycles-pp.getname_flags
      0.11 ± 10%      -0.0        0.07 ± 15%  perf-profile.self.cycles-pp.do_syscall_64
      0.11 ± 12%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.__do_sys_statfs
      0.09 ± 15%      -0.0        0.06 ± 12%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.10 ±  8%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.11 ± 10%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.common_perm_cond
      0.11 ± 11%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.09 ± 13%      -0.0        0.06 ± 15%  perf-profile.self.cycles-pp.set_root
      0.06 ± 15%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.dput
      0.01 ±173%      +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.__d_lookup_unhash
      0.07 ± 12%      +0.1        0.16 ±  8%  perf-profile.self.cycles-pp.__d_rehash
      0.00            +0.2        0.20 ± 13%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.08 ± 11%      +0.3        0.38 ±  6%  perf-profile.self.cycles-pp.__dentry_kill
      0.57 ±  6%      +0.9        1.51 ±  3%  perf-profile.self.cycles-pp.d_alloc_parallel
     58.18            +6.1       64.24        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


