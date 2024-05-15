Return-Path: <linux-fsdevel+bounces-19498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A218C62A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 10:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F020E1C21FC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F9F4F1F8;
	Wed, 15 May 2024 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqCFgFIE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD684EB45;
	Wed, 15 May 2024 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761010; cv=fail; b=cCTMeENb8xtwC+Ke8oNgSQBV7TAiC9ZMpPcXzy8ij6cK57MzHq6Dxao42OoQQ40F7kemNMJIqRj/3cJTWqm0SMlydkKKAuwQRjc+6nqvorXG7yPvBdKn/4tYEABRxpUwvN4Kzw7UReZPZo8lAH+QN7gNoPEIBzt/iztF+vtWCfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761010; c=relaxed/simple;
	bh=JKyAMHRyzD9/bioOLx19JTdm6PD/npChHYz0KKNtEQI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=l1wKLege+WZH0gBMfbeyyu98bDXDLbjYhHWhmJDjnt+O4deJZTiOwfd4e5Eh6KYADgsEIwFCWjjJBzkZiR6kDX+RK7OsJQmYrG5xAncTjcWJg9LyzfpS0+eRxwSPmFfjKhzPkk6DlS6DAUtsZrtUDpK+fDhboOI2FhLDyIgShXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqCFgFIE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715761009; x=1747297009;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JKyAMHRyzD9/bioOLx19JTdm6PD/npChHYz0KKNtEQI=;
  b=PqCFgFIESPcfv/LiBRucpnV8Jwdf1LgNkjqPXAvv3hitbLykzU5XWems
   wng1eBn4MAw2wrnIycrQfU0v0nM3o2Kg3XCoYVrmooTY54/kZpH4yYIw7
   DY4JC9fspgHbKveRITjyUwB8MYCQdRZZs+xlpoWGckoYQSjSkIv4Kx6LZ
   bndWp6fE06XBgsm+6M5qYqIg+9LYiRK2s1d0+XmPaNtx1GPjxbnLS2t9w
   XEtBE20hHFAmsZ9FPk58pn3HXjrerZpA+HlKVxxfAnJS/2x1OqxG/QUfB
   KRZizCk2ZGLUryE2Dw76uthGBF3axB9ucFD7ctiicLV2ZgErTzOpCWvL3
   Q==;
X-CSE-ConnectionGUID: O2di77ASQ5WwWVpCl3Fcvg==
X-CSE-MsgGUID: n8uislLETKe3nDhfVeJa4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11608332"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11608332"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 01:16:48 -0700
X-CSE-ConnectionGUID: KumnAIC6QW6sLXNb3TzQug==
X-CSE-MsgGUID: 0+rdAEKVSAC6QewjfGQMmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35758156"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 01:16:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 01:16:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 01:16:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 01:16:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 01:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS7kIo/uvafZVaSfjK8Smn9x63x5YMA1ZhiMDRb/UczZxYaniiBPbgfKbbNoySxCPARHby1JH7r9GdQ01alkl9n9FwgQp82uacHPWZ1cCmVxtMxMVV+oBuCSjNJYuks0KnGVOlefokrOp/+D1AQzjeSD4EVfyKQHNNx8PvEnmuLNdZROE8sApfqXshMh+PcVHGKkfRLMdf38uwQ8wAYO868hWJBszHrnGtayoJ0fwaOcYfpCHDu8yEeTmQtuvJF0xMVX71XXDk0KWsshDGdZnHz6gOeWK0sxAe7tYNUY3AbMUXhRiLOJuUnqfRrIJMPxRyGtJF91H8ngwvpa7/XIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TudVUxAvvPAekmrcvr5E5QTOa1QJLuB/5PqvOQaEbw=;
 b=ervpfSF3HlpWK7X78vS3l/PAECmesgtOQxo1prUXOz17o1Mog8iNkKe7UJMx3hTEfOu5VYPf8IbRhLao4nzYbeoowFk1cvB85BVFgVtqcsDVzJ9cOfWUMAOsCdjw5q6vGD0yKFxYqkjyn3pZ9CDd9UUCM2zt7XCcRFbe4IdtQ8aoARHgJL7hJQGZRE6IjFksK7KXgCsRK2SlymT6cABRFFUrnfyBgOEqWXlGNSViXJ5o3RoxBmG6uFZRc5foP1bbh4pBEKOtRU06KsHmL5Z3K20CnLn67xXJMg5daJCgly7HNGrrdt8M5Vdkhc1QL+QiAEG2nHRM2hjm3mj2itmRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 08:16:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 08:16:45 +0000
Date: Wed, 15 May 2024 16:16:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton
	<jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<samba-technical@lists.samba.org>, <oliver.sang@intel.com>
Subject: [linus:master] [cifs]  3ee1a1fc39: canonical_address#:#[##]
Message-ID: <202405151506.639f3fc9-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f75c27-b4db-44ec-c08f-08dc74b75be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OPr7EztAhdaye63+LRisqiDsRCtVRxilpaJgim/LHuW+O/nb66HMrGD9osNw?=
 =?us-ascii?Q?vcF9rKWplzEoPGW5ids0KNI1DN8lJa/Z8DjyKM5QTV+ixz3TGi5rtpx1Ttf0?=
 =?us-ascii?Q?t7o1Cx98SBvw75Di/FFWvL5Ptaipfpae+U+VtaDjP0Wc7owDbTtSCnqMAV1P?=
 =?us-ascii?Q?KFR2MjUyP3VB66HJ/3Himq6oOutuZl7raf2UushvBZ6T6LaB/PPtDGca4cDD?=
 =?us-ascii?Q?XKEmNF7Sgkhkol2yubeOMa7F+sJPf6lKt4eKR6c8XSw/HUbEYfuUy4SuWHAS?=
 =?us-ascii?Q?/xMfl/Hi0+o9oLE1mo1pUHDvfgl52NpeCGQf1EpI+s154MZyZSKI9xU3w6jA?=
 =?us-ascii?Q?H7Ybyz+iFo0t790kPTvenIRiL5gWF2YzPCeKDHCynuwBDnKGOdpNWTvpG4hN?=
 =?us-ascii?Q?j4kGvvTzwHHMWvpbWs0EAkEiu6esQdYu+myxhpBglDIBkwZRUYlN8K1PjlhQ?=
 =?us-ascii?Q?qqzMzByN7ut72gFn9Khihs3KwiC6Gzkx1g0Lx4RPVXDcqSnJvznobCMeLoph?=
 =?us-ascii?Q?96ri3L89O3NyLY+Hdc9wzDv+5vGp9GZZoZgbbF3bXCqML5M2/82X8kMYWhT1?=
 =?us-ascii?Q?tilWCrcJKvBukLuAXxTmpWYw0fSEJyO1CimnzFlXTLpG+HdVUbkZ0pFSC/s2?=
 =?us-ascii?Q?3yaYOpITdyMzOMDIgdaN03V6phu5tVPvt7w5rB+T2YoliHI9//TOVx5svWnK?=
 =?us-ascii?Q?qXPMoNR5mFGJ9oKYaHIs044ee+DTS0Vx+CYVTnIJ5HY0LvgG0rBy4Amh4Oqj?=
 =?us-ascii?Q?c+Q8az9zGBOPazIKkWJ8WxTcy/WfTHQTam+snkZ8SYL/QRkgn+HVVN+IA205?=
 =?us-ascii?Q?/e2qsjQYpWDs0B2UE/lfr1gzWS8rFlXcMnwlXDpEyK47xfjVP6wwb6VhaEW0?=
 =?us-ascii?Q?qKT+UMj+EB5u18fcFdHvUfn+/L2zXUrn6Bng/mAnBzgCeaOFD0Va8Sz3n1gs?=
 =?us-ascii?Q?2bwn454yyFLroNUE7sQ28ucv5u7XlBcx9vdaGpwBrlbgyaVq39zEsWt0JsNW?=
 =?us-ascii?Q?Ja/Ng0ll9j3A4Iduq6bar2rlpcVMqugA7HHup/JXS8xHEOjlNWfce7Xeup0O?=
 =?us-ascii?Q?BHKMB5mlHVmwPL6Oyw2P0uB3jxdihv4YW1tTtopY5yoCO/1dIsNh947hWnVl?=
 =?us-ascii?Q?CGAfxINRoFu1kuYOmxByDrtN1DYiWf4jO7wA/Kf5vmd5FoqGzXi66hJfT8tf?=
 =?us-ascii?Q?+TVQVHmV5aZ3zajO6izq/lHoyrAvAOc5jFfSDxsp/3whCX2RE4x6krcHlBk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWt7UED+BZcGQjr7McC/hv0j1odQex7SF2bU49ax5CnwuG+0N64j/aqY1Si3?=
 =?us-ascii?Q?Fo+zh3xno8bgNE4SIaI2FQMEyzBYlCh74Ei022Xk1nKnMvGjOd+DIkAvv+d/?=
 =?us-ascii?Q?GOY8BPVhWnbgziL3ZL7A2nWik1zM4XCjnIEZ9mfoNfQ0gOrEfoQTrTTFcAKy?=
 =?us-ascii?Q?8i11DbiLVRVjgsNCMmx3RQKNRR35t9LqnmWXNgsWecEoH3ETq00zjvCv/HI/?=
 =?us-ascii?Q?Ll3tf/uOnJ8gKlmi/BBxhIzlBhoJ5Ser+UK897cuvd3Mtv94fmzVLTLS4AZt?=
 =?us-ascii?Q?ev0OBqXxsEM6hD1y7M8V0TdpMiGCSlTjasWZTueVA3kOBnnRmScOUw1+dLVn?=
 =?us-ascii?Q?103J5omezoDlNIyRP+GH6oejJWDGFe9rnMgW4BrickaA08btbdBnLqeOHa1Z?=
 =?us-ascii?Q?fDNPeOU8uHENBhO/xYTHtdj5ijxSVmj2SA+CvZiWFoKi/A6yaFeqOUTYLUqg?=
 =?us-ascii?Q?l3lhx8i/Yt3MZEcy8ZPERL8CLjY/0ONKvvutXO+1aVG/Wkd+hiPy2U1k/ySA?=
 =?us-ascii?Q?6HOpxsaPNJer/zBY+jRBxfnSMCB2oRvfUSlqS+OYGuSGO0XHMygV4NuG+CjP?=
 =?us-ascii?Q?sTFiopjQa+RgBTc6/z9oQa3YNtMgH9sJNWaQNulyvy+HfBTiuGYVrmR0t6jI?=
 =?us-ascii?Q?PmauTaM8ay56ogeYqZS7cqca99l/LE0JyKzZs/uYYS8PjzercVMhQucf7slT?=
 =?us-ascii?Q?WflLWVrMT0f1I/fLd1UtBHYI5WaNkN9hl1XAitMKIS2JlOvYX3BFsynKgFdv?=
 =?us-ascii?Q?kLe/VSn28whQrSJkwBmRN5YOxFsxzuejefI1YBL2RE/YM/WOevsqGjaGWpEI?=
 =?us-ascii?Q?ooN5XLHKwxxCwIaPOnUdktl5+bQdxQIDsz9rohnE5+yfnZJVyaoEPryaCKwN?=
 =?us-ascii?Q?WzgSXl6t51FyR/H8Qo8LMp+dWsIMlZIoawTfc4AnOuZDWwr4f3H8kXSx2d42?=
 =?us-ascii?Q?0w1Edl4/RnKmSyD+EuT1AkWRTNXe0YALf/FhaOF/x42Zl/i9pahwxL7FdP8o?=
 =?us-ascii?Q?D/sfV/MreWN3jq6wGz9Za0HzIiqLy1srFkGj8JLMlmdXSa2FFsLiuRxoCQ1Z?=
 =?us-ascii?Q?IhiWScQDJIoJLwgtAqGZdyrRKT8HAfbSele9mW+3b277co77CCpvIlx/yLPg?=
 =?us-ascii?Q?hY0auMSTjsnpNgzuAg9y+a3+5K186JYuTXIks40o1wz2hYkK13cNM+c71RKL?=
 =?us-ascii?Q?7lQ/mkOKLD16I6UCjF1xwlnIw7zPLJD9l3X38VmX8A/UyLePR45L/jJg1a71?=
 =?us-ascii?Q?Z63NT9SXqm/jAcscgl5jkO9BmJqJNzrTeY9IOAq32xFz5G0P17n3UuTbCETP?=
 =?us-ascii?Q?DSGx2Jk+elrBKZiqPtYm4lBAIljPE1Ii5Ykuo1nK78vbvlRpFYilpzi/dHep?=
 =?us-ascii?Q?jJyVypy6BLBGy9pwN6tryBAqySVOjm6OFK+GAGBogCvBh0OU+drT2+3ACgkr?=
 =?us-ascii?Q?834VEJlA+K+I35gWFwcbpQ6UQnqS03klcGJ9LqD/ytJHVxpG9Zft6A2JRRfr?=
 =?us-ascii?Q?ZE1Y4dZQg7Q3ZqhK0OqHLGEFNmzVqSMSZ/jI6cg/f0owGnFF8f/UwFOeKkwR?=
 =?us-ascii?Q?yK1cBy0/bJKg0G0gLQ58lCcPpRCEztxAdXYwVRAE5TiL2iN/9dFfvvrw2Eoj?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f75c27-b4db-44ec-c08f-08dc74b75be5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 08:16:45.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBosSBKW5Q5OWCGJ0/c5jG1YcoeEeWGzQJxXuBdFjtgDmREiZ3pPixhpJgfFy437uwzx/iK+rqLLOzkVugjqmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "canonical_address#:#[##]" on:

commit: 3ee1a1fc39819906f04d6c62c180e760cd3a689d ("cifs: Cut over to using netfslib")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test still failed on linus/master 4f8b6f25eb1e51febd426da764a0b0ea652ad238]
[test still failed on linux-next/master 26dd54d03cd94ecc035d9e1e9fd4fc0f3ab311cf]
[test still failed on fix commit 14b1cd25346b1d615616a9c2dfdad9b4e6581e0d]

in testcase: xfstests
version: xfstests-x86_64-0e5c12df-1_20240430
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv3
	test: generic-group-03



compiler: gcc-13
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405151506.639f3fc9-oliver.sang@intel.com


[  428.991058][  T306]
[  429.032352][  T306] generic/035       [expunged]
[  429.032372][  T306]
[  429.110038][ T1629] run fstests generic/036 at 2024-05-05 13:17:33
[  430.012974][   T10] ==================================================================
[  430.014766][   T42] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
[ 430.020950][ T10] BUG: KASAN: slab-use-after-free in netfs_write_collection_worker (kbuild/src/consumer/fs/netfs/write_collect.c:693) 
[  430.032914][   T42] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[  430.041739][   T10] Read of size 8 at addr ffff888209bef808 by task kworker/u16:0/10
[  430.050041][   T42] CPU: 3 PID: 42 Comm: kworker/u16:2 Tainted: G S                 6.9.0-rc6-00034-g3ee1a1fc3981 #1
[  430.057819][   T10]
[  430.057821][   T10] CPU: 2 PID: 10 Comm: kworker/u16:0 Tainted: G S                 6.9.0-rc6-00034-g3ee1a1fc3981 #1
[  430.068389][   T42] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  430.070583][   T10] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  430.081152][   T42] Workqueue: events_unbound netfs_write_collection_worker
[  430.089277][   T10] Workqueue: events_unbound netfs_write_collection_worker
[  430.097401][   T42]
[  430.104393][   T10]
[ 430.111386][ T42] RIP: 0010:aio_complete_rw (kbuild/src/consumer/fs/aio.c:1507) 
[  430.113579][   T10] Call Trace:
[  430.113581][   T10]  <TASK>
[ 430.115772][ T42] Code: 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2b 04 00 00 48 8b ad a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 01 0f 8e 1a 04 00 00 0f b7 45 00 66 25
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	fa                   	cli    
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	0f 85 2b 04 00 00    	jne    0x43d
  12:	48 8b ad a8 00 00 00 	mov    0xa8(%rbp),%rbp
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df 
  23:	48 89 ea             	mov    %rbp,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 01                	cmp    $0x1,%al
  34:	0f 8e 1a 04 00 00    	jle    0x454
  3a:	0f b7 45 00          	movzwl 0x0(%rbp),%eax
  3e:	66                   	data16
  3f:	25                   	.byte 0x25

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4:	84 c0                	test   %al,%al
   6:	74 08                	je     0x10
   8:	3c 01                	cmp    $0x1,%al
   a:	0f 8e 1a 04 00 00    	jle    0x42a
  10:	0f b7 45 00          	movzwl 0x0(%rbp),%eax
  14:	66                   	data16
  15:	25                   	.byte 0x25
[ 430.121193][ T10] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:117) 
[  430.124345][   T42] RSP: 0018:ffffc90000337d18 EFLAGS: 00010246
[ 430.127150][ T10] print_address_description+0x30/0x410 
[  430.146700][   T42]
[ 430.151076][ T10] ? netfs_write_collection_worker (kbuild/src/consumer/fs/netfs/write_collect.c:693) 
[  430.157019][   T42] RAX: dffffc0000000000 RBX: ffff888269500300 RCX: 0000000000000000
[ 430.163490][ T10] print_report (kbuild/src/consumer/mm/kasan/report.c:489) 
[  430.165683][   T42] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc90000337ce0
[ 430.171723][ T10] ? kasan_addr_to_slab (kbuild/src/consumer/mm/kasan/common.c:37) 
[  430.179601][   T42] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1041350f07
[ 430.183897][ T10] ? netfs_write_collection_worker (kbuild/src/consumer/fs/netfs/write_collect.c:693) 
[  430.191773][   T42] R10: ffff888209a8783f R11: 0000000000000400 R12: ffff888269500390
[ 430.196594][ T10] kasan_report (kbuild/src/consumer/mm/kasan/report.c:603) 
[  430.204460][   T42] R13: 0000000000000200 R14: 0000000000000200 R15: ffff888269500398
[ 430.210493][ T10] ? netfs_write_collection_worker (kbuild/src/consumer/fs/netfs/write_collect.c:693) 
[  430.218354][   T42] FS:  0000000000000000(0000) GS:ffff888795180000(0000) knlGS:0000000000000000
[ 430.222641][ T10] netfs_write_collection_worker (kbuild/src/consumer/fs/netfs/write_collect.c:693) 
[  430.230506][   T42] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 430.236538][ T10] process_one_work (kbuild/src/consumer/kernel/workqueue.c:3254) 
[  430.245360][   T42] CR2: 00007efd4765f000 CR3: 000000081a85a001 CR4: 00000000003706f0
[ 430.251220][ T10] worker_thread (kbuild/src/consumer/kernel/workqueue.c:3329 (discriminator 2) kbuild/src/consumer/kernel/workqueue.c:3416 (discriminator 2)) 
[  430.257686][   T42] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 430.262498][ T10] ? __pfx_worker_thread (kbuild/src/consumer/kernel/workqueue.c:3362) 
[  430.270360][   T42] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 430.274909][ T10] kthread (kbuild/src/consumer/kernel/kthread.c:388) 
[  430.282775][   T42] Call Trace:
[ 430.287759][ T10] ? __pfx_kthread (kbuild/src/consumer/kernel/kthread.c:341) 
[  430.295623][   T42]  <TASK>
[ 430.299564][ T10] ret_from_fork (kbuild/src/consumer/arch/x86/kernel/process.c:147) 
[ 430.302716][ T42] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 430.307176][ T10] ? __pfx_kthread (kbuild/src/consumer/kernel/kthread.c:341) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240515/202405151506.639f3fc9-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


