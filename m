Return-Path: <linux-fsdevel+bounces-21512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788F904D12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 09:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32FD28390C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449216B729;
	Wed, 12 Jun 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8b+2Viy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186C376E6;
	Wed, 12 Jun 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178362; cv=fail; b=OYLWI4mjXNMcfRJT3Lm1+NlB2GqKC+QFcY2aIhSd4nC+fdotad18lJ00TZuduuclqstTCafGnv/pzCrYsSNJ/UYBTQcePBxoQevKWconAMbFTdGhm5sT7S+kadBXzFUkx2q4YFy1g3CwEK3VjAlo6ZgFq5JPkk5/vcDuoKK5gU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178362; c=relaxed/simple;
	bh=KDIiWbkpUmwU1kUlgb7wzKDxrlpRQhagK3HowuKiyWw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BejKPsN27KLMKELmmsNYkLuIO5/NhDbrdHK70cxkvjJpcp+q/uxcAiU1g6AhEFtNGZyL2+mnWMmZc5zvpgtmzQDeBf/vgy1bcySv9Fx21PmgKhGWKr7yBCZqQec/HM/kBhbRcG0RCNtTcXHSz68fcWo6orts/C/IeUZii1uPm7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8b+2Viy; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718178360; x=1749714360;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KDIiWbkpUmwU1kUlgb7wzKDxrlpRQhagK3HowuKiyWw=;
  b=O8b+2ViyIEddV6mqKB/ElSxge7suRKV5nh/wvDBjNQl/wYJ0QqW/0Vqr
   xjOYpkbb8Pdz+g+5YmLzM9usqT8Vj1jW3vxZSMwE1XiZIfjjwxQaVaLxy
   cLpatMPB6p8CoDZXNuOuJjUgHlR3yqjHcp30qpNgXJ41YzOanSUxnZugp
   DXpdUmzw9u45UxL8+puFkQlRvCqdzz8XR6m2Kn8Ou79Pxd4AOqs3W4XSF
   A/fdsa56oLwqV2+hJ9eeCV/PeWf60kA+jCNDKgkSkD3ijmLvIgq7s9rXv
   8LixuiEacIYnjkWLf61A43hSDv42K6wLFlMbK9jD3/a/5QR/pLvn0BcWK
   Q==;
X-CSE-ConnectionGUID: XbbNCEZ8RW2Pb1kRgj6eNg==
X-CSE-MsgGUID: EPXM9xN6Q2yZ0pnQtswEsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18705978"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="18705978"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 00:45:59 -0700
X-CSE-ConnectionGUID: 2ohvquY3RQerDUB91ZGHEA==
X-CSE-MsgGUID: 2OlLgcFvToq0LwOVT9UZIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="44266038"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 00:45:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 00:45:58 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 00:45:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 00:45:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 00:45:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnVBlpG/Md4ME+UXmyPFVdUYB0tVIcPkGvD7tSYP6EhZiFfBWMiEeBrouP1KmEIUKph78s5/t8rvIb3FkRV4dXjyElxGlzKyFwFR8mJeZqPDiInYE1dvDEWo7ElSGyg1fYVjJTnX86AMEKXQ5FGrWs0eCsqgDUCI0KAlo+Hf8L0g6A8Z0B0la2dMzOS1LBZepAbKJMqMm7DXvEBH0PVKiNPWonDvSmxOsm+p1DYATSryPNVc8+Rw7T7Trn9uMN+0Cbt9bao7MqtvxYZbyNhi5PWXEXepn5+KnuYlEqS8PzPOP96cz5dJxwQD6FD3ndmGFz7HrzfQRImUmaaSQ94nKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkZ2CVjnzu8LBWg1bhpl4bj6j3rZlJ2B5MHqa71Z8AY=;
 b=RQofGkRw/f4Lxsz8SHNIcyeEkWg+AUEnOKOoRpj+dxD4bM1ERuY5X0/t8hyfHZLUanD4JcwQmRBFVkucV1GagqADoEKv98mMhyqVmkU8UKrCbDRjYWQ3wOtjpfsbk0A4Z3keMFu+7gcFP/VFMyIsUbbHsEbX+fTF7h8N+IcO/BoLXxGGB3+PLEZnwgG1fWeNYKXhrXJiUQe8pi/kLmngQykkkQtsUQsLS37t0c5zBYGL3Vuqq1iiT0+RojvBBetIDm7/P0A5H0+QLhbSzcwwY8waauJ47LuwH1A9HKEt+im+hHrv++BrBtCosygTMRiPVSdSmyrw66YtOZjBpTYbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6658.namprd11.prod.outlook.com (2603:10b6:510:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 07:45:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 07:45:50 +0000
Date: Wed, 12 Jun 2024 15:45:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [brauner-vfs:vfs.open_tree] [fs]  6d2ad41f48:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202406121525.65264f68-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 855e3c17-1cb3-46f5-beab-08dc8ab3ad96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Yh6AUQwiYTqxhGUOAt0azBM8dLMeadcMMY7I4Myp17NF/6y7vZ5Ih3dAGHn?=
 =?us-ascii?Q?te5Rb0FQyGQqJVzCQ7g4eQB8jnTBfEEw6zEsplM55gyRh6Kj504vzEvSm6JT?=
 =?us-ascii?Q?Hi+M4tO+r+MbPwd/uKejHW0eJwmMv3M1XFRUYl2wNo64cokP2B3K3jOXKYAO?=
 =?us-ascii?Q?77i9KPkY/KvMa/0JCU8ifQDlfEfNHSFEYP21nQk6TKsglrwGUWr4jgc74lYd?=
 =?us-ascii?Q?NMjIvTnGFSNYuklfpVBhOlGh65bAfQC8wirudDV43irA+b9EHir8hKBVDaOy?=
 =?us-ascii?Q?q7EyxFTec8zp5DDRWKExFdf7cZPUfw6EG6G0TwphcJEj8fjne0n/Xo/iC/EM?=
 =?us-ascii?Q?VDxV4JChZrOvpeTkVE/wUSMpKdQY4GFPQXOR/5I+NPauUgs+rB2M9dd10ZBf?=
 =?us-ascii?Q?Hzl+El/JvT/YyT+1Zcq6snDPMth+KKgtgq7z7uJK0q1J7bQaW4A4EglvyTib?=
 =?us-ascii?Q?lWixfjimWwaesftc/UmwS+GEov58wa8hbIeHEIFck2G9JQYBxAda1waBB+TG?=
 =?us-ascii?Q?IGbfkjdRjXfAh03HBOBTBx3y82Z+znRLyjwDbyZYKZhPjdoSyVi/UMei6wCg?=
 =?us-ascii?Q?LqLeJh1ZVQaOUJgAQhe8dhIBqFo9wZG1GWuboYLUlPT+LT2+YQZV2QLKviFz?=
 =?us-ascii?Q?6RCFlvZNoRd7FoBAnn4UOE49PBqZOJ57rmKULirfzrpC/MIXLLBtLuqvf8cc?=
 =?us-ascii?Q?JM8fUrsvOLVO2PRv4M3EasN8UyhYp1w0HPOSRLEvv9PqHYqpjP83hiCX2C8O?=
 =?us-ascii?Q?9JXTwad0fCvgMAaSUh7o159Nz3xD244xtjK7K9Mze2rfr7PN6N/j3U4aWDK3?=
 =?us-ascii?Q?skKujHHstj0Nn0HmgVFWhp//Zx75UzDTg4Dcp/uaGnzT4gpoOAgxpiJjTEE9?=
 =?us-ascii?Q?M8y1WVj6peimpuydkmleoXBVTHLrwtQLO34hZF06zchndIN4E2D8qqEhNtV4?=
 =?us-ascii?Q?JpumPBWOPtxjRZc/cg1EdjSHAmjLzWPgScPj03tBmVUoU6LWuWpZzeZ8bgVn?=
 =?us-ascii?Q?9ATt9HGTNK6Ev5pwg4ZJQUvpvV2Q5EwIMHCdYhcDSWLPT/XlCRCtaKlLNbmX?=
 =?us-ascii?Q?urpWZwVj7opzYiir3RSzWwPcJviJUgFIx09KC1vmlGvDRWeLTT0Q2Z1a2qJc?=
 =?us-ascii?Q?mvvX5hPwWLUm7fwsZ7GyBGu0hTDnGbB11dk9sw8grF4AlqwVS3M3X0X9kbn1?=
 =?us-ascii?Q?y7Xg/ix7DXxSLTlfOdqQBu2J/+i7UoZlbQszYdGoOfmAWscANmykdwUzQEsF?=
 =?us-ascii?Q?Rmpl2IGhIohmBO/ITUGU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/myga6paqoMYi8jZYFhlXNSMI74kmGc9U3pWDjyxWit2q8I8B3+REhrmsfd?=
 =?us-ascii?Q?95gNPNiPNnvkIZ6/rxS1SofB5B99U35CdgONqJpeR4TJgGELIaMI5XlVfoqL?=
 =?us-ascii?Q?Xr/NfplHke9DKtciN3TadlynVJG+2056cG9EWwCXS3V9VZ2kfC4zYCgDKi5o?=
 =?us-ascii?Q?bR1+QcUNlk3d0O89DtbqSrWVlliOJMEqlSOgF3MOHtrxDcbLEIVLJtrPSqTB?=
 =?us-ascii?Q?rnuf9kN4UKqdVhqwq0ipyR9/RtHXcGTv5JpoT/sz41apBPQNj4RHoLWq5jwf?=
 =?us-ascii?Q?cgxWzaTmY6/eZeMWtFnudlKrbY8fYPv9SUtjn9iz1InBBp5sHQfFVhjRWssM?=
 =?us-ascii?Q?F4UPul3HGRW9qcl86ybDk1fV1kyt+cL8xTd2eCEWY/mmVe7+xyb5S9A+Pbmx?=
 =?us-ascii?Q?seLsPlLOI6VjFNfCjT1qrk50iqyeVmK5IoB4D2HdG3Lu+pk2eOHmSzWSH4aw?=
 =?us-ascii?Q?nQNQH0Os64r9py2lINBAVgfw27I71jJSmy5hfZT7M63dZJw1kJwdH4AvqDza?=
 =?us-ascii?Q?08MjBy6nagBKsb1e0PBi734n7E3z3fo6lHhz+sGIwlpDsbze/bZumpKlJZfv?=
 =?us-ascii?Q?nkpMAlBGJ/pQ/eFF+57FoWSFADdYBpjKB0qEmh+KSP2qfypr1uz+rfjkYDCm?=
 =?us-ascii?Q?7Q0gEMVvShhUeyWFQkcdo1DLKKMmxHnHR++ukCwgK+/7TL2I/Htnbz/BnA4S?=
 =?us-ascii?Q?OGAdao6eTUZw14i38w7RIMmcmf53eBvnhu5qrht+VrQydVL91OVzBLkSBNqO?=
 =?us-ascii?Q?RI/VTeRtdGy2nrVJy64fSNTvuMWYMBctUypbEycQFSxvQsdt7GZ82KNJhVet?=
 =?us-ascii?Q?T0sgkLn2jY5M8Lrf9ttjqkbZAfrPdGHMAu40QkVcll7g13QEljbDuKWOtiE1?=
 =?us-ascii?Q?2Gfeej5dJ5M/vP89wMNX96CWQiWW6mnRAgt7hptpJS+eigcfU6q8RLW+lbzm?=
 =?us-ascii?Q?QrmjRpMmixiqpEgblH+PMXOOMXoQO2NHxkhF8wf8+YjkJhBxNLoP36iOCQP0?=
 =?us-ascii?Q?u2HBwp0vh99Ou3lBGcTJBkkcU29S9eq59+8u6lASwj56hDsii+XeI4tXakfT?=
 =?us-ascii?Q?NTruoSviEWvnSc6LeWpPR4uohBAs6IzNVFu9moKoF6VyeStNYYd0Ut+NdZ0N?=
 =?us-ascii?Q?KwWLkcMR+nuVqiaYQQxS5iL9QG8U/phVrGf5ichnSGoCdfH0HnPmuPJ4DB7m?=
 =?us-ascii?Q?Ee0LhinO7r65shrbAK6wii8nqk4lb52hkyiwagBqgFdz835yWQV9gUUt3Xlv?=
 =?us-ascii?Q?/kIToAjF9t9K3YLkrvosD9XKSBQqNzRrwyI7E7uKQ6Y3v9tD3/VuyafoTWGt?=
 =?us-ascii?Q?b3vAs7ob2fyF6yATDDS1ucsbEo2ImkoyhDyo+DGfzX+SHums0quUl5NajwZa?=
 =?us-ascii?Q?vyzax2ArQSHzoO+z0T7Vn9nkriD+SSL1RaeGRRviiZSJ5JVnDv8EaqfumfjA?=
 =?us-ascii?Q?oL3zRGzFANyHpJ+L09jkrxd1LFRI7pQCxFzzwxBlP41FUU0K2tanZajFejJh?=
 =?us-ascii?Q?inq00P5g3EswJeDok02ZzYDZD/8mcSiog9L8I08FsgUOWrZIGqAthDcJp9iZ?=
 =?us-ascii?Q?YmerveUiyK7qsvlg41otHJQgJxTXFavrvzZafBHIHyc+FPK29IWYCeL5IpKW?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 855e3c17-1cb3-46f5-beab-08dc8ab3ad96
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 07:45:50.3095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWRGuCb5ZiG2YWRe1myfQL4SoYRtY9IpMKbD92slhykyJk/O9r2ndv9UhnweBcKDZzprLCyBsXZqiHQrpYI8Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6658
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 6d2ad41f48768f325a552666b71724bc40ba52c3 ("fs: allow updating idmappings")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.open_tree

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 2c673193e1 | 6d2ad41f48 |
+---------------------------------------------+------------+------------+
| BUG:kernel_NULL_pointer_dereference,address | 0          | 6          |
| Oops                                        | 0          | 6          |
| RIP:mnt_idmap_put                           | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 6          |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406121525.65264f68-oliver.sang@intel.com


[   15.358677][  T206] BUG: kernel NULL pointer dereference, address: 0000000000000090
[   15.359960][  T206] #PF: supervisor write access in kernel mode
[   15.360932][  T206] #PF: error_code(0x0002) - not-present page
[   15.361897][  T206] PGD 0 P4D 0
[   15.362470][  T206] Oops: Oops: 0002 [#1] SMP PTI
[   15.363270][  T206] CPU: 0 PID: 206 Comm: (crub_all) Not tainted 6.10.0-rc1-00007-g6d2ad41f4876 #1
[   15.364699][  T206] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 15.366361][ T206] RIP: 0010:mnt_idmap_put (arch/x86/include/asm/atomic.h:93 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 fs/mnt_idmapping.c:315) 
[ 15.367186][ T206] Code: 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 81 ff e8 37 c8 88 74 26 b8 ff ff ff ff <f0> 0f c1 87 90 00 00 00 83 f8 01 75 12 53 83 3f 06 73 14 83 7f 48
All code
========
   0:	1f                   	(bad)  
   1:	84 00                	test   %al,(%rax)
   3:	00 00                	add    %al,(%rax)
   5:	00 00                	add    %al,(%rax)
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
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
  16:	90                   	nop
  17:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1c:	48 81 ff e8 37 c8 88 	cmp    $0xffffffff88c837e8,%rdi
  23:	74 26                	je     0x4b
  25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2a:*	f0 0f c1 87 90 00 00 	lock xadd %eax,0x90(%rdi)		<-- trapping instruction
  31:	00 
  32:	83 f8 01             	cmp    $0x1,%eax
  35:	75 12                	jne    0x49
  37:	53                   	push   %rbx
  38:	83 3f 06             	cmpl   $0x6,(%rdi)
  3b:	73 14                	jae    0x51
  3d:	83                   	.byte 0x83
  3e:	7f 48                	jg     0x88

Code starting with the faulting instruction
===========================================
   0:	f0 0f c1 87 90 00 00 	lock xadd %eax,0x90(%rdi)
   7:	00 
   8:	83 f8 01             	cmp    $0x1,%eax
   b:	75 12                	jne    0x1f
   d:	53                   	push   %rbx
   e:	83 3f 06             	cmpl   $0x6,(%rdi)
  11:	73 14                	jae    0x27
  13:	83                   	.byte 0x83
  14:	7f 48                	jg     0x5e
[   15.370213][  T206] RSP: 0018:ffffa44d80513e20 EFLAGS: 00010217
[   15.371181][  T206] RAX: 00000000ffffffff RBX: ffff95d25d031800 RCX: ffff95d25d031858
[   15.372426][  T206] RDX: 0000000010000040 RSI: 0000000010000041 RDI: 0000000000000000
[   15.373695][  T206] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000003
[   15.374968][  T206] R10: 0000000000000018 R11: 0000000000000002 R12: 0000000000000000
[   15.376229][  T206] R13: ffff95d25d031820 R14: ffffa44d80513e70 R15: ffff95d25d031800
[   15.377492][  T206] FS:  00007fd6818e7940(0000) GS:ffff95d52fc00000(0000) knlGS:0000000000000000
[   15.378934][  T206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.379980][  T206] CR2: 0000000000000090 CR3: 000000015d008000 CR4: 00000000000406f0
[   15.382019][  T206] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   15.383918][  T206] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   15.385811][  T206] Call Trace:
[   15.387072][  T206]  <TASK>
[ 15.388218][ T206] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 15.389618][ T206] ? page_fault_oops (arch/x86/mm/fault.c:711) 
[ 15.391056][ T206] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 15.392444][ T206] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 15.393938][ T206] ? mnt_idmap_put (arch/x86/include/asm/atomic.h:93 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 fs/mnt_idmapping.c:315) 
[ 15.395356][ T206] do_mount_setattr (fs/namespace.c:4388 fs/namespace.c:4528 fs/namespace.c:4607) 
[ 15.396817][ T206] __se_sys_mount_setattr (fs/namespace.c:4826 fs/namespace.c:4749) 
[ 15.398325][ T206] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 15.399628][ T206] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   15.401168][  T206] RIP: 0033:0x7fd68245ad6a
[ 15.402449][ T206] Code: 73 01 c3 48 8b 0d 96 80 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 ba 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 66 80 0c 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	retq   
   3:	48 8b 0d 96 80 0c 00 	mov    0xc8096(%rip),%rcx        # 0xc80a0
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	retq   
  14:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	66 90                	xchg   %ax,%ax
  20:	49 89 ca             	mov    %rcx,%r10
  23:	b8 ba 01 00 00       	mov    $0x1ba,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 66 80 0c 00 	mov    0xc8066(%rip),%rcx        # 0xc80a0
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 66 80 0c 00 	mov    0xc8066(%rip),%rcx        # 0xc8076
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240612/202406121525.65264f68-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


