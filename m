Return-Path: <linux-fsdevel+bounces-69793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3838DC853CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 14:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D5CA34F195
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9A823E35E;
	Tue, 25 Nov 2025 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtcmpgOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170ED23278D;
	Tue, 25 Nov 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078515; cv=fail; b=owLYUOME1tsibXkHqNiiSqfvJnsPL/EaaPLzzsOypCks6VVEhB4ra6Tv6dV7x9SAOeW8MwVvTuKMsSRtKaOXiRkd+6xdmOZ7bAO5v7KC6v2oVFVTtgzl88NGdFy9lkUUyo1zdPEEg3NlohS9sJA1ErVTHul72F3FuhFQuPpTXHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078515; c=relaxed/simple;
	bh=kzZe86Sr+j5tv5A33ErztYsO879D7KTumKt1g77ZeEQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pnZtgpXzZFvucdg2AO39WZrUP3bqTRxNMSlaLggzktaemU7hzor5DsJxP4Q4b12JSkNaEBdfo/YPfhnmMIvzh7lb+H5eS2fVRrdBU8JwCUWcxY3WOMUF9GutJu23/u1N56XcueL0HMRrjDpv9olmDcVsaORnDCoiCfBkjYrw29U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtcmpgOz; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764078513; x=1795614513;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kzZe86Sr+j5tv5A33ErztYsO879D7KTumKt1g77ZeEQ=;
  b=JtcmpgOzH6xf1YMUrK1sPPWuDtMbjdFBZT/QxmPlUKsvlheN+hxFSDRR
   ystM9ztqWKY3fvbWF+cUGAWOgqRmHKDE856yA1giR2y2B7BgTBirTNnp9
   WQvobGjvGIlILMeowudXuvjvfsogna7LLJNSTKoCxPo3l3UKRrb96nEr1
   kS3JPRHsG25gI6s7SRhTutoqD5l7K0CHwmyiHNPKIy60zl1XUKoJUklfE
   vc5V98hq/UVhWoPB04M56mWcayjdQ4qM0W1cMIEji/9xnOxmhUXCN6ikG
   Xr9QbnN/tgPN9nPeocXT31ZFaQE79B7kEvnJ5TdxmfbYIbQ42vbSb2MkN
   A==;
X-CSE-ConnectionGUID: tQ0C+jKiQH6m4Jc2EEBCIg==
X-CSE-MsgGUID: TnRK+MrzR8+3MAEYIfDfQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="88747179"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="88747179"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 05:48:32 -0800
X-CSE-ConnectionGUID: OmVCOTeTR2qsPJ2nbZp1uw==
X-CSE-MsgGUID: UPUKYqjMS+m81qzA91oLpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="223320360"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 05:48:32 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 05:48:31 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 05:48:31 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 05:48:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOWzfIri75bac5/dxD/BZUYLJbTRcKm1oUMMp6W9X9HaS0hif4dLcIECGZ2oK9d7ATVfI3AMP+fqifZrSv/HHRDk/ytf8u9crCGI0ryckzmwLM0k4CrpS916J3LEcICI0BdKIQYDbUayAbGAOdbStULdd4S67yOFkLOc83hBjC9/tSgIOA/WF14abb5mI0/k+qnFPQfn40BBI6MLmUVA4NvwiwMLKoS9IQUwk0y1Q3Jz8ZyhbiL0Knt1xAZ7G16Lguf/PpXz8egAzO9HFqHIVv5OCpOhyF/NcRttKZRZP6X5MlVySRp8JBQvBxat94T8BxJeNQ6opBkoOudn6wpFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn14+FxTK28QLvhvldLrp8O5CTlrcFxD0GqXgykfbdc=;
 b=rCl52UnYhMySA0UW36KYjeWRNB6BfSadWu00if4d0fsY2+teNRoVRKg3ho506KVCUEcRmWLz/4kxGqu1xTXzC2nE6IMS9XZvy8IlmOZfWUw8wj4Ipsjc/qDEWQb7fxJfsWNi6NmTAMtJ7tv8lKeQq2BaxS1uX+8+qhrHvkPgapnUeHRzW6PpGZ4Rm8NMHIwwZV75mcdhGLwF8dRT8RF51McRavOSBDvl9y/ZGy1HMT7qqv6XMyJJZ9xKkVxBJ0PJwfJ4Km2Im+U5GugOmwvaB0hQH45bkuOHsgjLyWSYGb36hbwmw74i+soHRRkoHJkmKTtYa0NDiG+Hi+2XIotcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8693.namprd11.prod.outlook.com (2603:10b6:408:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Tue, 25 Nov
 2025 13:48:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 13:48:28 +0000
Date: Tue, 25 Nov 2025 21:48:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neil@brown.name>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Amir Goldstein
	<amir73il@gmail.com>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [VFS/nfsd/cachefiles/ovl]  7ab96df840:
 WARNING:at_fs/dcache.c:#umount_check
Message-ID: <202511252132.2c621407-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: bea41a98-9e06-4ccb-1110-08de2c295016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UMa8Vk53hTV7wWtOyp2OFYzBTKijOkqVKnJEy0p9sQI2ilQfqWBAAxlH5xI1?=
 =?us-ascii?Q?eLOXFsOdkr4hKxSL7RCQBE3TVhvuY8LLk5Go9bZPhTYevkpUe0FFjgXnULTE?=
 =?us-ascii?Q?x+D2NxDnfWArUyBw4PTFOQ9z7fn4R3m4PRYSGKvl0nCeudSAfeZs72TpxlOp?=
 =?us-ascii?Q?PpAJTUtGCUjCOZy01Bq/VfFmYaQJxDAYrDXg717BObtXqJLbB83WOYQQ94Zc?=
 =?us-ascii?Q?RAwFTcam731q2mqqGcsGsnKlsFuvRwFCJLRKs9Pg2RpZziSlSnBjrfQHhxjr?=
 =?us-ascii?Q?nxXG/vWK6gsx8jRgdJzknnAWWozB3d2WMx+fTT/3bM3T02cnxJfC+7RO/Fpg?=
 =?us-ascii?Q?IkBHBSrnZvChRiuAI91JS+4SQeV44b3PIt62zlEgBqMAv7R+Xo6eptma3ptq?=
 =?us-ascii?Q?DUEZ61V8JqeJYF7UPc9NdxgkH6/UIcGds/PZgbXU3ssb+B5fl3eYAozhlRqO?=
 =?us-ascii?Q?VWy4c2x1G0Tflnrbsi3n1DAIC1BJN3XxWi7D2fNfmDBntvCMA3wYxZHJzvAg?=
 =?us-ascii?Q?C5dCA620uDGPhmC1IDVNv6Q4JNLXVkPz4I9J014AtNoqboEnV127O81+UgRd?=
 =?us-ascii?Q?SaT2kMx+YdplnKkxFSpfhdlpyIbTVrZ9bVJ0in8T2Er53+mWmrJDZ9NZ7ytJ?=
 =?us-ascii?Q?IZywMElsyVhrNoHQuAHQu/SQM9mTJqxFjtbyfMtBJ6JmK3KtIuNeoRFIJXqj?=
 =?us-ascii?Q?uPsVFfR3BW5Egc/9qz5yBPd5jBwyxDUS7XmqT/kg588ZzFKrx0qkVvCz4q8D?=
 =?us-ascii?Q?JgLUioZe+W/ytuQXULnK2Yvpa+L1tjWZXS0psl1RIdUB84IpkoN/QSTHNbbR?=
 =?us-ascii?Q?pD+D1Hze40DiwJhbJh1wvO6hkGQV828bDH68t90L/It3YomHDWHXRZBQE55J?=
 =?us-ascii?Q?6wQJ582zgAqLL2hEygLKnhqoQF1GMr8crjN77PQHn2S8DglcXjn7TueFeKIe?=
 =?us-ascii?Q?AP/vkotBqQEOukZi2nwMd41A6NHCBUdZnGbtDmwxgubkx4cWr1hoM37ATII5?=
 =?us-ascii?Q?I5Od+BWykU6zw9GMoBVFIei58MifwxpRV1mtmNyC5MW7PCtwg+yu53M0ACPP?=
 =?us-ascii?Q?y/UzUed5vvE/+RNl5DETbtYTFuCaogSoC6jMn7L4gBxr/jM2BOijsqCTL+N3?=
 =?us-ascii?Q?KC+0A18nmwl5L4epZjK9cnsSNHCq1fFjfKtmRKbL05ymkHAeEbr5/JWL/l6E?=
 =?us-ascii?Q?FjysV9rT4QTUYZZ0IYYwTxFOElYC6YKE+5laZGHbqTTFXjodMsaCfA+hjk2L?=
 =?us-ascii?Q?COD+GR4Io2wCQvVdaZbjl4/rAOZV5GaEAgLMX57PZYncSOEWDH4X8SXVmPPC?=
 =?us-ascii?Q?YkqTPrOlqr+oP0n8MxJ0I/gECkOUlEqK4UY/wGgB9twVdHEIa71ChXuK3wfr?=
 =?us-ascii?Q?6krjcEDHlpcIq5MlB1LCiAcU9C1rFxQ8C54EYvWjyB3SvCLrlqjXuHAzQ4Tx?=
 =?us-ascii?Q?x5WYprC2v/Fta+j2+8srzNyYoMYfaZ9toXZ/PIhxcs4FROQkAeZLyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lcIsOf+DFgWCk/THNNYt9peVeprkYoXvxZbXPiPE/qDW9EDisvI58AgFPwU+?=
 =?us-ascii?Q?81i07GHgedrEUBGGs7JvDmGiQosY3+EFPhX6AgmTmppyO1PS3/FIJFuzhh3K?=
 =?us-ascii?Q?xsSSPKQ4CZ2DudoTHGM4nY+AMo4aqQ/vLsyDTMTXNqOMlIA98XqrnwTCaC0z?=
 =?us-ascii?Q?r6b8YyYtSYZN2VVQUfO0Hnpu1X9sa3FaKgx+KFlT7Ut0fqLbRFl5E7kTzVIR?=
 =?us-ascii?Q?127p8yDBn+qBOwsW+61/MjoNDdvbsJmrRn2kGF1JQjLYWzltPdDcUfLpCdhL?=
 =?us-ascii?Q?3fC0lqA3yrqhhb5ATtxqUdp7eN2Yp5Hy6Ootc/Rcd4wyy4tgc0H3j9VyX+kB?=
 =?us-ascii?Q?y8KvUuFWnxRAUoKnNfWBccF0naSJz+KfHbC2FWzQjLCgnHcHU0AfLTFUaH1n?=
 =?us-ascii?Q?tjbnqLNY1Krx0l91Dl/9WwuwEGlsK3qAFFdXq7LNhMXwRzh4rchmZQfOONA5?=
 =?us-ascii?Q?BLeiC5X9Xb0TEVRGqNnPr3jewjyGu775kWOCpw3dzy0DYnE3Z4sMHnM8fKoO?=
 =?us-ascii?Q?Bgl/QXfHHrW303/dQGyltf8nEZfZ1Nrc5frThWPM73Zbz/JxgRtzZq6ABWdH?=
 =?us-ascii?Q?brDgtsUCugv6EXLkhvW6ubfTE9kqFkaoXTwa2gfCUA1GrjKZXfJ6ou2/JFrD?=
 =?us-ascii?Q?82qWcyedkc6WCKIOoqRtcgxnhmwcYvZwjyYy2MkeP21bXcre6Wg7Wt6cSMFl?=
 =?us-ascii?Q?R8XK4xo+PXLTAytMLI5LjbBPOYqD8k/Fi4VL+4HcK/H5MSYI1O0GiB8e553M?=
 =?us-ascii?Q?w3azK8fE5Z6ISJA4y2gn+9ESymZ/1U3/sEzY5LrQEYDssFUSfAll4qtZBlsG?=
 =?us-ascii?Q?G4BHPma/5WzFRPIwbhC/fU6b4i6vPmQBj1N3Uln2B2Pmy7HX3TIjqq242FKc?=
 =?us-ascii?Q?nImscIVbavxQPEEJYmDUxEyu4xrG78Q/LuW7iS+kB99VE6hcAcxZk9EHLCvY?=
 =?us-ascii?Q?mVcR0o2cWUZjlssisAuxfTJhZSSOAYEi1wKdHC8LXZKkN7W+7zHQwnU08ulr?=
 =?us-ascii?Q?BKCAwu//0ud5EIf65BBJ66D01eTc8juyspe+y3G+RGqlj2a9Lyt+gQRtNqSA?=
 =?us-ascii?Q?H8otzHYvyhDBLN/zrjW6cKKqWrvAZLjmOfu9N1RcQ6pP/b9m8+WrcHesOurU?=
 =?us-ascii?Q?IRBbpaEt5cUR3ALQ74V6R3UGkp6Uxc4JnU4v7edSc2y693xHFxutlyTuvr+g?=
 =?us-ascii?Q?OzqGCFJIWtULZeZX4SSb6wfJPBe6YgrXumd2aagfWv4RXoLHkRTj5vsEbSJi?=
 =?us-ascii?Q?OR2OoAnwu3+nfbq1ZQMqISGLi8oIgNILMqwp9xa5e3yAYLRfKJcCefDzaeEO?=
 =?us-ascii?Q?GYv004icNpDbF9wOJJuxU48+o+U3hOgVPMAJNugTQS2ytLWD2XgcX3salpMz?=
 =?us-ascii?Q?VbWSE+a6I+qc+W7YmGxO/3UgbLWYPk1nta65Pd1hanACqJ9CfWqE4EPwQM9+?=
 =?us-ascii?Q?P3Rgo9VVEfwaRPLMeZU4UXONp0WN+1v+mmnN2pLFMkLLhCCanQxBtlrNz2zh?=
 =?us-ascii?Q?XuHraBqYHRw0+sZEIW0jb1aelaT+Wnqee28F9LWSpASUC8pwTS6pNknhtVcB?=
 =?us-ascii?Q?OYfdTkeV9eypaiRG3J/b+8Ewn785HtlWISLQZ9gncQLbIHThYqAq841Bhu6w?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bea41a98-9e06-4ccb-1110-08de2c295016
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:48:28.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRZwdLhbkczHCkbQl60kCl0b2ig3cTtyl9Q1c/IiIWQtnMDwGTY6E5lVTGswJFSZkcvG91JMqLLnoiDRK03spw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8693
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "WARNING:at_fs/dcache.c:#umount_check" on:

commit: 7ab96df840e60eb933abfe65fc5fe44e72f16dc0 ("VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]

in testcase: filebench
version: filebench-x86_64-22620e6-1_20251009
with following parameters:

	disk: 1SSD
	fs: ext4
	fs2: nfsv4
	test: ratelimcopyfiles.f
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511252132.2c621407-lkp@intel.com


Unmount[  252.448780][T17295] ------------[ cut here ]------------
[  252.455068][T17295] WARNING: CPU: 114 PID: 17295 at fs/dcache.c:1590 umount_check (fs/dcache.c:1590 (discriminator 1) fs/dcache.c:1580 (discriminator 1))
m - /opt/rootfs.[  252.540436][T17295] CPU: 114 UID: 0 PID: 17295 Comm: umount Tainted: G S                  6.18.0-rc1-00004-g7ab96df840e6 #1 VOLUNTARY
[  252.553273][T17295] Tainted: [S]=CPU_OUT_OF_SPEC
[  252.558205][T17295] Hardware name: Intel Corporation ............/S9200WKBRD2, BIOS SE5C620.86B.0D.01.0552.060220191912 06/02/2019
[  252.558206][T17295] RIP: 0010:umount_check (fs/dcache.c:1590 (discriminator 1) fs/dcache.c:1580 (discriminator 1))
[  252.575407][T17295] Code: 8d 88 a0 03 00 00 48 8b 40 28 4c 8b 08 48 8b 46 30 48 85 c0 74 04 48 8b 50 40 51 48 c7 c7 88 3b ad 82 48 89 f1 e8 27 07 c0 ff <0f> 0b 58 31 c0 c3 cc cc cc cc 41 83 f8 01 75 bf eb aa 0f 1f 44 00
All code
========
   0:	8d 88 a0 03 00 00    	lea    0x3a0(%rax),%ecx
   6:	48 8b 40 28          	mov    0x28(%rax),%rax
   a:	4c 8b 08             	mov    (%rax),%r9
   d:	48 8b 46 30          	mov    0x30(%rsi),%rax
  11:	48 85 c0             	test   %rax,%rax
  14:	74 04                	je     0x1a
  16:	48 8b 50 40          	mov    0x40(%rax),%rdx
  1a:	51                   	push   %rcx
  1b:	48 c7 c7 88 3b ad 82 	mov    $0xffffffff82ad3b88,%rdi
  22:	48 89 f1             	mov    %rsi,%rcx
  25:	e8 27 07 c0 ff       	call   0xffffffffffc00751
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	58                   	pop    %rax
  2d:	31 c0                	xor    %eax,%eax
  2f:	c3                   	ret
  30:	cc                   	int3
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	41 83 f8 01          	cmp    $0x1,%r8d
  38:	75 bf                	jne    0xfffffffffffffff9
  3a:	eb aa                	jmp    0xffffffffffffffe6
  3c:	0f                   	.byte 0xf
  3d:	1f                   	(bad)
  3e:	44                   	rex.R
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	58                   	pop    %rax
   3:	31 c0                	xor    %eax,%eax
   5:	c3                   	ret
   6:	cc                   	int3
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	41 83 f8 01          	cmp    $0x1,%r8d
   e:	75 bf                	jne    0xffffffffffffffcf
  10:	eb aa                	jmp    0xffffffffffffffbc
  12:	0f                   	.byte 0xf
  13:	1f                   	(bad)
  14:	44                   	rex.R
	...
[  252.575410][T17295] RSP: 0018:ffffc9003672bb88 EFLAGS: 00010282
[  252.601300][T17295] RAX: 0000000000000000 RBX: ffff88ac4c0c55c0 RCX: 0000000000000027
[  252.601301][T17295] RDX: ffff888c5009c1c8 RSI: 0000000000000001 RDI: ffff888c5009c1c0
[  252.601303][T17295] RBP: ffff8881e925da40 R08: 0000000000000000 R09: ffffc9003672b958
[  252.625337][T17295] R10: ffff88ac7fc33fa8 R11: 0000000000000003 R12: ffffffff81748d50
[  252.625338][T17295] R13: ffff8881e925da40 R14: ffff88ac4c0c9200 R15: ffff88ac4c0c9280
[  252.625339][T17295] FS:  00007ffff7bfb840(0000) GS:ffff888ccc272000(0000) knlGS:0000000000000000
[  252.625340][T17295] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  252.625341][T17295] CR2: 00007ffff7ec97a0 CR3: 00000001ce11e005 CR4: 00000000007726f0
[  252.625342][T17295] PKRU: 55555554
[  252.625343][T17295] Call Trace:
[  252.625345][T17295]  <TASK>
[  252.625348][T17295]  d_walk (fs/dcache.c:1322)
[  252.625353][T17295]  shrink_dcache_for_umount (include/linux/spinlock.h:351 fs/dcache.c:601 fs/dcache.c:1606 fs/dcache.c:1621)
[  252.625357][T17295]  generic_shutdown_super (fs/super.c:621)
[  252.689813][T17295]  kill_block_super (fs/super.c:1723)
[  252.689817][T17295] ext4_kill_sb (fs/ext4/super.c:7405) ext4
[  252.699584][T17295]  deactivate_locked_super (fs/super.c:434 fs/super.c:475)
Unmount[  252.704921][T17295]  cleanup_mnt (fs/namespace.c:242 fs/namespace.c:1328)
[  252.704926][T17295]  task_work_run (include/linux/sched.h:2092 kernel/task_work.c:229)
- Legacy Locks D[  252.727385][T17295]  ? __cond_resched (kernel/sched/core.c:7477)
irectory /run/lo[  252.733357][T17295]  ? generic_fillattr (fs/stat.c:99)
[  252.739669][T17295]  ? _copy_to_user (arch/x86/include/asm/uaccess_64.h:126 arch/x86/include/asm/uaccess_64.h:147 include/linux/uaccess.h:197 lib/usercopy.c:26)
[  252.744854][T17295]  ? cp_new_stat (fs/stat.c:506 (discriminator 1))
[  252.744857][T17295]  ? __do_sys_newfstatat (fs/stat.c:546 (discriminator 1))
[  252.744861][T17295]  ? do_syscall_64 (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:261 include/linux/entry-common.h:212 arch/x86/entry/syscall_64.c:100)
[  252.759380][T17295]  ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548)
[  252.764099][T17295]  ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548)
[  252.764101][T17295]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  252.774744][T17295] RIP: 0033:0x7ffff7e54217
[  252.779199][T17295] Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 b1 5b 0d 00 f7 d8 64 89 02 b8
All code
========
   0:	0d 00 f7 d8 64       	or     $0x64d8f700,%eax
   5:	89 02                	mov    %eax,(%rdx)
   7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   c:	c3                   	ret
   d:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  13:	31 f6                	xor    %esi,%esi
  15:	e9 09 00 00 00       	jmp    0x23
  1a:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  21:	00 00 
  23:	b8 a6 00 00 00       	mov    $0xa6,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 01                	ja     0x33
  32:	c3                   	ret
  33:	48 8b 15 b1 5b 0d 00 	mov    0xd5bb1(%rip),%rdx        # 0xd5beb
  3a:	f7 d8                	neg    %eax
  3c:	64 89 02             	mov    %eax,%fs:(%rdx)
  3f:	b8                   	.byte 0xb8

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 01                	ja     0x9
   8:	c3                   	ret
   9:	48 8b 15 b1 5b 0d 00 	mov    0xd5bb1(%rip),%rdx        # 0xd5bc1
  10:	f7 d8                	neg    %eax
  12:	64 89 02             	mov    %eax,%fs:(%rdx)
  15:	b8                   	.byte 0xb8


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251125/202511252132.2c621407-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


