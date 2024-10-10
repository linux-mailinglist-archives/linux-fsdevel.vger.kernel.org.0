Return-Path: <linux-fsdevel+bounces-31510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4823997C62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 07:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134381C21C7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5E219EEC7;
	Thu, 10 Oct 2024 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBCTXPAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDA2AEEC
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728537999; cv=fail; b=QOgpCeta3MrgoxLUx7Jriiu9slJ2/Fsc3sdkZRC5Hnt/dbQac92MTQsL+77HBzy54Wz/xEdzz7CWqKZISRCHLTU9AoWTOMMBCcX2XxhIi7+n8gglv9D2jDmpEaTJc/Mww04z02d4xGqDzQEGM/jUfCI38CF+N59eI4Jrmitb2A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728537999; c=relaxed/simple;
	bh=o3g6IXikAfWwMvaeEj5xBbGtzYyLM9jW610ecMDF7rs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RSc8o5sVotwiAsSz6p25NW2HsyngLIYjnFl9FlI94HtjHAQKa5fIchmpdNMxUV5rWg/VltfE3nUkl5/K3I4HQcT7lYW2W1IJUnumIP6SQ6R1WYFjU3fieidvoBP9XfvsSdVOsyOYyL0tz/RSdayPpPnOst6G4kA6cW8rN3UivM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBCTXPAc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728537997; x=1760073997;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o3g6IXikAfWwMvaeEj5xBbGtzYyLM9jW610ecMDF7rs=;
  b=EBCTXPAcwoJrOiANDqcAn/jZQ2cEWNXoXFL3+DGQlxcRD6jnRkY/OuBm
   XnSkar5+OfAgv7Z2edR2Ll4+9TPYgByCY1V/tPSt4DNlbCZ1RaevpAB65
   YI6aXeg1LOzG3wjlgvkAbBMBkjHeuKHimi8/ffJZTH6Bv4z1eXbZvFm7a
   S75fLvryyBhP1XRbUFt3bdUKGTc898QRAEcFcQ026pXhZzZT0mqS91O0L
   03efkkXoDoLgcUE6pk2JU2s2Uej4RmkCjvI2xQkmRVoz32kcSP/ZEUmo1
   lhsDVB4+fClEl9VdDvB6AYiEIxWzRHPxbtTa20VFQJj35aUDzMXVm/tS7
   g==;
X-CSE-ConnectionGUID: NKo3dZdEQjqDV3qQcfqCOg==
X-CSE-MsgGUID: hpPHKgWDRnq3/4mNNoA1kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28003721"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="28003721"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 22:26:37 -0700
X-CSE-ConnectionGUID: 11DSK912Tu+xhKt3prXrOA==
X-CSE-MsgGUID: D1JkniLtRZecWbXJDRSoow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="80473663"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 22:26:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 22:26:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 22:26:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 22:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRu9+ZEsP6Bh0ZhmwWcB9lEuQVvMFQua14VstL55MNE13pUPGa3Q/ijr6HcL5XtLwIYyYFDmb+fReqrMNfXIkqdk4/54kAh+kq79MgaJnBCT0ONPdhdq+TfN/RAmlQ5feXj0IAwCIXp5m58p8z99YTd7M52VZhlHPmBhfQS+P/0NUdRGcuWhLAuGJngojfAQkw6XkC1OSO+mcaSnsH+yjZvfJXvOS7CJM0HTEKnAKLlPBa936r1QagI68tr/NiF4dht04q3DJZTXKQ5UdT64bByPt/dg+IxH38PkWnyT22718s43UUop3cebosVrS/PoHmHfljqQhPCPsqutUp4Dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKCCRdi7V/w5x9pFo0XBBXxaR0PXtyWNQg/AshnR8rI=;
 b=h9nq5wxP1eY8lLr4+UPoWoeqb3MnSQGSftMns4QGpn3yH3iDk7Ze5OGFNBj5yiRngY29N3gZzWQZrO6WgcbSsiqCeCPWAz1oDuGrehNhbQUQ1DJ1Tcul8FOrrI/CRDiqUaEu5CJikniaIL47ZtKqheFkGjZGD/yXLsq1syPJyjMCtnIc2TISPenjVJxmylz4QAqsHE5QqawdiiOksrD2tuEc9J7RS3cjwrPr6nvZF6167XWNa+N1HMHDx8etmvZTn9sOsdzNCY5j4PUIcwEJOewfim/okk9uHuW4Js/y8SxyCniG+5au0fzb2CW8yUfpylc69mUq7hET7oml5V65wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 05:26:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 05:26:33 +0000
Date: Thu, 10 Oct 2024 13:26:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master]  218a562f27: segfault_at_ip_sp_error
Message-ID: <202410101245.48a4dc5b-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 5011747e-d7cd-4670-92f4-08dce8ec1a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mO6P6YSrhfETOlpSNn/PckJR2BDJRebXOLlkcMZ41FclBU2Xb21Dew3Fnv9P?=
 =?us-ascii?Q?+j5MQJu5UK5fm3colioOIwlJAFkRpidoCUndkSdEU/oq8gWLrRAuIHX3Akoe?=
 =?us-ascii?Q?++tb+7t+l1rS7hmZ+2gzofNIL26OZOZ8nFBv5V9fGlJMttIGm7592VY9/uF6?=
 =?us-ascii?Q?/eNOAIxEv5oSFfMeCTqcDx0fyO/ClH382FNp5iJ8N6ab2FEDSKGK6MfBw+A6?=
 =?us-ascii?Q?xhRYugYFAGJgtEW5pGvEeoB7T0Z+JBM1HHtFsvaBVFXfFgR+2xfbRY7qon4b?=
 =?us-ascii?Q?+vq11T3AceFNDK/UPOA6DMpvb1yNRAI9Te9H5uokq6XLiFwAh88/M0LMDKfM?=
 =?us-ascii?Q?nN7NykbmK6YZdzC9IBjaoVVsEqyKlYiU5d2ioh3dSnlZ3EYkNpOhZLphMpGr?=
 =?us-ascii?Q?qXezOoPo7OrzC5UN3jfSyr5ICD7Z7DS5QqcJAQS4WLUiePtJMDkRgT9gQFUW?=
 =?us-ascii?Q?a0ANTpC4RJ/HGmJDA6iswddIxzEAEyVtqrA84E6RaN1uUV4yCz/sgjrXJ/t+?=
 =?us-ascii?Q?9dZOm8NO9YeZ0DqAy/kvqMkNG71HgHkR7A/Zs5rhM9cH6xt/KgSe7zBCdb/k?=
 =?us-ascii?Q?b/7S2M1eZGMH+0pDlcMPbO5r1yQKyfi1dcmBYVZSoE4UQV/QBCa91B+JUHw1?=
 =?us-ascii?Q?uJsnwvJXqtBS8EsCncHmWPiA0djuwzQxMI/Tg84+Nl3rdFG5hSOlIwpooeZH?=
 =?us-ascii?Q?ftla+Cyv24yXzK8YiLL1QKXSD57vpUPcRNFHb8FxKOSYOJ1MUOVKcXWjzTfC?=
 =?us-ascii?Q?Yz9pRneqY9tZHjzG07ljFRMw6rA63oULkggM+fE05jFmI3r2HIiP/fmn/7G9?=
 =?us-ascii?Q?wLSXSjQNk47IwRSYShBnHmIMa4IULCFokna2pOE4hDz4jB4/PDP/R0FfMm7F?=
 =?us-ascii?Q?7NMS27dQaDATtY6j/racml/zUthcJSsO4/1pyzLTfnWqux8zx2obLyXYj8B6?=
 =?us-ascii?Q?yGvKWW081D7kkLfP4R/NCDJo0KXQRKZbw2DsvJ+nyK0KhwhIFkaLWk8FgxcS?=
 =?us-ascii?Q?OVnGRV3zovTkZNlK5Cxsv21G4B2VsyhY4B/VrJmnT/5OgyeSqFasDGQCy+r6?=
 =?us-ascii?Q?q52IW0bOVtR4z7YQzqJBFNB0V4rAP0edH2LHhD17cTEB3GS71KhNmsVQV/wC?=
 =?us-ascii?Q?AQzUwFX5x62ZmJ40Vg5GaOhnOpLALHBr85FcXnQFDeNtlqcOeClLxwo1eS1r?=
 =?us-ascii?Q?X2t5wHv1zqZ1JxMZGQVrikVCfQ0Wxgs17vMJusUkZeZz3t3ULQ2pnFQEfms?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iTotgG6aUrIshIdpEgM2C/74CJvzOkv6z6ncgtyY7OGZU9Sf+RupjwIZABUc?=
 =?us-ascii?Q?mApW2yLcHGo021+Tnx4x9RMHB3CrLdjKYWC6RPeSx+nFGhkwzujTnFUfrWeu?=
 =?us-ascii?Q?Q3Bk/Kqn2KHlvE1d4G2qLYmYOKct6duBAfEKWhscPMoZ97e08VQXpe0PEPqd?=
 =?us-ascii?Q?sE7mWpvpwcvXarN8CEDPJooDspCi06tv1BV3PA3ZmzVqDg0odAqZ/By9RuwH?=
 =?us-ascii?Q?ol3hpULAZ6qcBwWI28UzmGnlJelIiypJsbkJlRU40F0RQ+u3xsQe25dqld5R?=
 =?us-ascii?Q?j+KGfWF54nj4Fw+49pfEJCRULlfnk3tkjavGea5Slf04ItGABlFWkOuRUo9y?=
 =?us-ascii?Q?xz/PK+Z/gNSLNm6jXfX9HzQQTgSYU7zCOqKnyOESs9Uu+m7781kOgHfY/xf/?=
 =?us-ascii?Q?4EHKAkjbWZaVGhnJE/zl8vcNgl17CwFTOfyEeux8Eh3auaQ14mAqBDd8Bb9f?=
 =?us-ascii?Q?5S66Qzhp1/SxDJuQX2yVDoF7jeNDkuBKygCvFixxv0NsxBtTGl6Y1GsrOTDb?=
 =?us-ascii?Q?naY3R2uz2SdP2YOlFGw6XmODyF7Ox5KSUnr8IwxgPNyrf3WfC1emD9m8b+QD?=
 =?us-ascii?Q?Hetsem4r5qu43AGDnA8UN7IUGCuus5HxxZBgGdPfERWfDqh36sv9HSRneDPe?=
 =?us-ascii?Q?I6EFwK5bvEeTlLtNZ5bJUJzAZgHdjrztD5arzb0WOkQ3oaiP0GBE+hPee0qy?=
 =?us-ascii?Q?Iw5U4g2evlF5f9kIYeZM3CU4U2Lib0jzWWwADUOEd+B71oKqMVCls7Wvpw4E?=
 =?us-ascii?Q?5azcyxm4vYbB/xLOqZjVPZWZQA7UlWYI0GssH3rMFk/09e2xBvvanTG0wpBv?=
 =?us-ascii?Q?ZhgVe93RbgraGS8GdIBiOI1HPxeIH83uAnv6rXtT+XDI7Pkqk7qZ7MyXsQgf?=
 =?us-ascii?Q?EUXIfA54CimWXLrkQ+RjmjiB4aUVI94wMwmbNILVTU/U7HqYh2Rl68W151pR?=
 =?us-ascii?Q?OrAr53Ld4bc0tXF0PiuokcpNNnwKQ5b575/b/nSAC0STSprFbHCrSIXBTfB+?=
 =?us-ascii?Q?mQqmKGhdVOpIa3wZqeVSwNP6IP20kDjrsZUZd+wKlpU91UtUvfcPcSuHUHBs?=
 =?us-ascii?Q?JkNtf6KVeJBlI66mjR2y3rbEeSw0yGq76sfnpfXDD1Klxd0ja8eovskhiXnk?=
 =?us-ascii?Q?ZgFYSkhZ+6uSTgrHzO/XVXoUjph7+DPBXvnbdfxKPlpQRUyqTFc0QM0JkxrS?=
 =?us-ascii?Q?8wJVrm7CuG546w+EqCIM+/NJhzSguEmTNF1cLtzD+CKmxmMva1vc2+4Nc+1l?=
 =?us-ascii?Q?/iBQ2z1bn/rU0v23JgFPAR54DTQib8GhdygX+NOwc4Sz3QKE+dsMcqnxSSwn?=
 =?us-ascii?Q?td49VrpON7EGqpiqFawdFMGXddtFLug+FO+JVKzh1ys11PC5FcnqmNa3Rvi0?=
 =?us-ascii?Q?Y3qCnOSBk6rDGyqzCNMI57WwUSGO3Sn6QNjdXMY56/1YWnM8LR48t4H53fae?=
 =?us-ascii?Q?iJcUuz4Ui/25aIQ0VsLMbTEJJayCnBPrBV0uIRSL3nBMYOU8lmQQ/k35Lr/n?=
 =?us-ascii?Q?rkr7IGGNd7avu+3BqfvKY3ADWoCHyo8WP0jQqWLFbyqLGpJ9pTSMUUbl+C3G?=
 =?us-ascii?Q?F3NcfwHUS6BWx+iWWymwfVn+tMC9OwPnz06vaXUDc9skMIdTvlwnv6rmjOIk?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5011747e-d7cd-4670-92f4-08dce8ec1a40
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 05:26:33.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTP9L8Y11zytVUw4f9n35eCWnhemgKTWlkaGQihG0bODUK4XQso0F+OdV/aFlr1S+CrI5s8AJNk2bVt1aDluIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "segfault_at_ip_sp_error" on:

commit: 218a562f273bec7731af4e713df72d2c8c8816e8 ("make __set_open_fd() set cloexec state as well")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master b6270c3bca987530eafc6a15f9d54ecd0033e0e3]

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------+------------+------------+
|                         | 53d05c3162 | 218a562f27 |
+-------------------------+------------+------------+
| segfault_at_ip_sp_error | 0          | 6          |
+-------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410101245.48a4dc5b-oliver.sang@intel.com


[   10.259055][    T1] init: Error while reading from descriptor: Bad file descriptor
/bin/sh: /proc/self/fd/9: No such file or directory
[   10.262474][    T1] init: mountall-shell post-stop process (108) terminated with status 1
LKP: ttyS0: 99: skip deploy intel ucode as no ucode is specified
[   10.379560][  T126] cat (126) used greatest stack depth: 5692 bytes left
[   10.415045][  T117] sed[117]: segfault at 0 ip 37e0ef44 sp 3f99b000 error 4 in libc-2.15.so[66f44,37da8000+19f000] likely on CPU 1 (core 1, socket 0)
[ 10.416009][ T117] Code: eb 90 8d 02 e8 2d 18 09 00 eb c9 90 90 90 90 90 90 90 90 90 90 90 83 ec 0c 31 c9 89 34 24 8b 74 24 10 89 6c 24 08 89 7c 24 04 <8b> 2e f7 c5 20 00 00 00 89 e8 0f 95 c1 25 00 80 00 00 75 66 8b 56
All code
========
   0:	eb 90                	jmp    0xffffffffffffff92
   2:	8d 02                	lea    (%rdx),%eax
   4:	e8 2d 18 09 00       	callq  0x91836
   9:	eb c9                	jmp    0xffffffffffffffd4
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	83 ec 0c             	sub    $0xc,%esp
  19:	31 c9                	xor    %ecx,%ecx
  1b:	89 34 24             	mov    %esi,(%rsp)
  1e:	8b 74 24 10          	mov    0x10(%rsp),%esi
  22:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
  26:	89 7c 24 04          	mov    %edi,0x4(%rsp)
  2a:*	8b 2e                	mov    (%rsi),%ebp		<-- trapping instruction
  2c:	f7 c5 20 00 00 00    	test   $0x20,%ebp
  32:	89 e8                	mov    %ebp,%eax
  34:	0f 95 c1             	setne  %cl
  37:	25 00 80 00 00       	and    $0x8000,%eax
  3c:	75 66                	jne    0xa4
  3e:	8b                   	.byte 0x8b
  3f:	56                   	push   %rsi

Code starting with the faulting instruction
===========================================
   0:	8b 2e                	mov    (%rsi),%ebp
   2:	f7 c5 20 00 00 00    	test   $0x20,%ebp
   8:	89 e8                	mov    %ebp,%eax
   a:	0f 95 c1             	setne  %cl
   d:	25 00 80 00 00       	and    $0x8000,%eax
  12:	75 66                	jne    0x7a
  14:	8b                   	.byte 0x8b
  15:	56                   	push   %rsi
LKP: ttyS0: 99: Kernel tests: Boot OK!
LKP: ttyS0: 99: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.12.0-rc2-00014-g218a562f273b 1
[   10.441864][  T119] sed[119]: segfault at 0 ip 37de2f44 sp 3f88cf20 error 4 in libc-2.15.so[66f44,37d7c000+19f000] likely on CPU 0 (core 0, socket 0)
[ 10.442831][ T119] Code: eb 90 8d 02 e8 2d 18 09 00 eb c9 90 90 90 90 90 90 90 90 90 90 90 83 ec 0c 31 c9 89 34 24 8b 74 24 10 89 6c 24 08 89 7c 24 04 <8b> 2e f7 c5 20 00 00 00 89 e8 0f 95 c1 25 00 80 00 00 75 66 8b 56
All code
========
   0:	eb 90                	jmp    0xffffffffffffff92
   2:	8d 02                	lea    (%rdx),%eax
   4:	e8 2d 18 09 00       	callq  0x91836
   9:	eb c9                	jmp    0xffffffffffffffd4
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	83 ec 0c             	sub    $0xc,%esp
  19:	31 c9                	xor    %ecx,%ecx
  1b:	89 34 24             	mov    %esi,(%rsp)
  1e:	8b 74 24 10          	mov    0x10(%rsp),%esi
  22:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
  26:	89 7c 24 04          	mov    %edi,0x4(%rsp)
  2a:*	8b 2e                	mov    (%rsi),%ebp		<-- trapping instruction
  2c:	f7 c5 20 00 00 00    	test   $0x20,%ebp
  32:	89 e8                	mov    %ebp,%eax
  34:	0f 95 c1             	setne  %cl
  37:	25 00 80 00 00       	and    $0x8000,%eax
  3c:	75 66                	jne    0xa4
  3e:	8b                   	.byte 0x8b
  3f:	56                   	push   %rsi

Code starting with the faulting instruction
===========================================
   0:	8b 2e                	mov    (%rsi),%ebp
   2:	f7 c5 20 00 00 00    	test   $0x20,%ebp
   8:	89 e8                	mov    %ebp,%eax
   a:	0f 95 c1             	setne  %cl
   d:	25 00 80 00 00       	and    $0x8000,%eax
  12:	75 66                	jne    0x7a
  14:	8b                   	.byte 0x8b
  15:	56                   	push   %rsi
[   10.550743][  T155] mkdir (155) used greatest stack depth: 5668 bytes left


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241010/202410101245.48a4dc5b-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


