Return-Path: <linux-fsdevel+bounces-55744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8322FB0E48F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C641C24024
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102BB280332;
	Tue, 22 Jul 2025 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7N24BUG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89523B61D;
	Tue, 22 Jul 2025 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214902; cv=fail; b=qAPtZ4LrwqdSPalnv3tvaNExb5vnSkAE/M465iBKlEl7JSkTERlkfvgWs7CrqsplTKqK62arxfjkgviSpZLj8p1kuYK/SxDGGt+8+H+IzPn5IAn8lrqcw0USe5Xmmd+ZMoPJJ0YyJ2CbD2l1aBcZ/tASDMqA5JORHhSTyxh+NWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214902; c=relaxed/simple;
	bh=RUbSLS2Eyeu6zkv5wgZMUyOSZ5A+lEkFnW4BqKLYLpY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=IL2WQaQV7OpVVDjWdmH4Mel5FqCjaFTG4jqtcKnJ1FMCYaMnbdz6TLU7Ws7hIbPiAZ8rvG0MD2St8U/G6wKf/Hcmi6NeW/cfrgpe+hbFqUXCwthgZ2JLIPBlurqzF0ojr6PdoDvuGL3sl8ZSSiSL2SmDNMpSl1igfgCvOf0SB+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7N24BUG; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753214901; x=1784750901;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=RUbSLS2Eyeu6zkv5wgZMUyOSZ5A+lEkFnW4BqKLYLpY=;
  b=C7N24BUGBqgYpTyUb9ooehDolM97EegewzS4gWTJMMvra0yXuF5NXnkL
   pEZARKmSz44iw5f3s+LB3QVDNUd2hVuDoJTxrttkG6oLj4VDQSx+s2b7M
   h9CaMcYXvTQa4LNxycQFgQvPJ2njhkXV6eLOh6KTYf+EdSE+9u0mLrxr5
   MTnIkhfosgv48QZ/1iNMtExjBup13xbVaDRQG01bX+inRktowC8nygNZW
   rciC1yUaImPeyKFr/cHIixC4hQjXLZhwk1hujtyDbLMMtwAFQjHXpIoFy
   W6P480nkRe5ZOy277OtXTIug0HfNDk+sd8NE0bayy8nX3ubHfdnpS6Ky+
   w==;
X-CSE-ConnectionGUID: dC+87XFaQTmi4c18p+NNFA==
X-CSE-MsgGUID: LRnS56RyT3qreD5t9p9Obw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="80929329"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="80929329"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:08:20 -0700
X-CSE-ConnectionGUID: 7oBLbF5iTumLhY2WKC7nYw==
X-CSE-MsgGUID: 2YPYkmZ8T1mEED55lqhpDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158899402"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:08:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 13:08:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 13:08:18 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 13:08:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKERgP/rnPBAR/1VsNrG/XZkHBcxRk1mwaMHNCRRsrG05+QadLJxf0JjIuw/sR7iCj5bjgt/uQoLsxzm+WLIvYbFw7FuwQ+h2ufJXmJ2gvuWHeXswvODXrRey0OIHvj1DdrLSVPIllgyCAuA1PPivDqG2IQSDFuujUyqbqK853JuuF80HavPDhaNleFED+vLUP4HL5rV2BQaOWUWo5CsRPQUUw6zygBBfw6XZr29vmmwI9uxPik1MC5Raot3dRoNLhYbxJtrUiAV5V3sTJuY1Od0iKx/FjK5YJ/1sqgM5tyg1r1yVzDYVKDpHGpK15y4MbhScie2IklgFua7H1O1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNCAPVVZjGOdhwt74eQC7MtpDZJfPKtUnT1eOBbfoM4=;
 b=FLzA+y1vM+3Ht6z93rCDX3dTiZbbbwiDBxx8n61zfvlollD/dAlQqGjq9d03NaVl12AmmUBU1eM/avUHub18OC/6V5nZQnem/qPTCPMqRtuNuURh747DgfILrSUZZatzqjZM6bBQ2d1us0RRHCt4mV7Ds5yCSP/GbMdrwBazOvW7rCDRy6sP8RIQuXwb+h1ZHUIIhS1wZ//y2FpeorRrd+opg1IasB5rVnRCP9aQmqhE9azI1wn10wje/0iE6opbDUEgTkHRw5xkNf1HqbLcBDF8ew1GxX4GJwBYIfdZTiLv+3BexjmvcnB80d7YkrtchHaEPpnLGNwPQIFvhmaKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 20:08:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 20:08:01 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 13:07:58 -0700
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Message-ID: <687fef9ec0dd9_137e6b100c8@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v5 0/7] Add managed SOFT RESERVE resource handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fd0f5e-22ba-46ef-9f32-08ddc95b7594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekltTk5yd1JCS0Y1STJQQzFWZStVbHFqakNWMkswQ29QZEp4SHBkbjBjM0tF?=
 =?utf-8?B?S29yUU9nd0JMMzE1bE02OGs3OUJMQzN3dzFLZUhqSmx6dDJJcHduM0lZS3ZN?=
 =?utf-8?B?MGlKMWhIY3BkVFFGRnVJZG03d3RvWmxtOSt4b3MrZ3RnNmoxcllGdXBOYm9w?=
 =?utf-8?B?K09hYUhzVnFUK3BTU2oyQ2o0TGlEQUtJQ3RTNUwyMGs0TmtpWnBsSDVNZTNw?=
 =?utf-8?B?cnV1VFZZS0R3V1VVbzFteUNtV1FWZzZXY0YyYmwwZXNmY3huRUN1R296a3h4?=
 =?utf-8?B?VFVBN2VNV3lYaTF3VUkwQkg3VXBsdFE5M1FWT2ZYSno5T3YwT0cyS1BBOGMx?=
 =?utf-8?B?ekMvWkNoVXljbHRreFNjYldncVZDMVE3bURBdkM3Y1R0c3ByREVtQkl3SDZp?=
 =?utf-8?B?emViRUMxU1Z6amVHUmQ0a0NweUZXKzRZOGhLbVBQeGlMbXlZWXhzNjZiWG5U?=
 =?utf-8?B?VlZHUFRhU3pET1dDZW9SejJycE85SS84bk9xYVIxZnphZWN4ZFdhc2lPYnB6?=
 =?utf-8?B?aEZTbkJpRG5GOUZCVWlKWlArYXhzYng5VU1PVzJhUzg3NngyNFN5T29VcXJj?=
 =?utf-8?B?dDFhN05nRzU3Yjl4d2Qwb2h2WHdCTVlaU2gwdEp4UWx2N0dZd3psemJpc0M4?=
 =?utf-8?B?cUVoSUVDOW1mZGt5d0lDMXFpTi9pbkd1SVpBNXY1ZUhkeDJ2MnkvZ1VHY3Vp?=
 =?utf-8?B?dlZZVnVHVjVXMkRQRlUxL3RVaUgyUUdLdzAxYmVHanJDNjFyMWlhQVU0M2ZG?=
 =?utf-8?B?dTg4cHYzSE95TnFoWHFVWjJxUFVBcTIyTGtLRFp3SzdHeE9Va0dmVzdCZHV1?=
 =?utf-8?B?RTFhUmJvUFN2KzZzdFBkZlhaZ0RoMEQ1WlFWclc0ZERXL1dCN0l2Z0pUVUth?=
 =?utf-8?B?MWdEeGV6U0xRZG56MUhPeFVWSmdNVFR1NEJqMmlEb3MxVkJONVFYbVl4UjdV?=
 =?utf-8?B?TEhNNUo2clN3QkFicG90QzVEamMxRG1pQUNBeGtuT05MK2pxci9YRFhXVmU3?=
 =?utf-8?B?MDRJN1JrMkJoQk1WMzNxVDY4cUVOU2x6NEQxV1oxVzIyc01ydmNaalViVERr?=
 =?utf-8?B?eHhCQkVMUVZiTkY2akJRcFQvNWFjVy9sc2tOZ3ZRV2lKSGF3Ym5sMW9SM2hW?=
 =?utf-8?B?SUErMFpCUGljaEcrVWtqUTVlUVkrdGxSdGYrM24yMXN1UzhUN3NHRmZrZmpD?=
 =?utf-8?B?YTlHNnEreEw4NW5MZEdJdjJyMEE1c3Z4dHBKdkVIZHUrdmp4eTlvOStuTmFO?=
 =?utf-8?B?UGRTVWhRRysxRHk0ZXhYWEQrR0pkWldjSDc0UXZEZDdocWU1WXJudmV5L096?=
 =?utf-8?B?blZtL3RxN3Y3N2VpUkJpenhGS2Z6QkxTLzNMMlo2TnJLWnVXUUpNYVFqZjYv?=
 =?utf-8?B?VzZEcnRMZFhrblVFdHFCQm9yYjljVE9UUDlqSEEzVWJjcFlrUDBNNTdHc2hG?=
 =?utf-8?B?SVlCVWxRd1RoVWdRMmJ0R2o2eXFySnI1aGZRd29ZVUg1Ry90Nk42ekF5Umx0?=
 =?utf-8?B?eGdwbUFWTjZTQjZ5THRRZ1dLVEVCRXk4SHhPVW02blFrQXJrdytSYzRMcnpz?=
 =?utf-8?B?WmhOdW51QjNTWGl2UzZ3bEVPdDhJNW1MbS83a2VWQitkV3FZQk1kZVZUcEEz?=
 =?utf-8?B?dVJuUHJTc2ltYkExdFFaM1FzRTR5OUFnczVod25jWUgrVW04TXhXOVdkMlB6?=
 =?utf-8?B?RzFMMnFDMXBvbEltM25oUXMvdW53WTVrVGdpVDhqdmZaSEsvdDBaTEtONmJt?=
 =?utf-8?B?QmVpdHpUWm5EMnhaMk10K0VVdGsyWjZtbStKTjhsUVpYQVF4TGs3WkJsMkJT?=
 =?utf-8?B?SUV3VU9JWFpVZngvZlU0ZDRnb2kvUUVUNWVLU01QODlmQmIyNmpNTVpmL1lK?=
 =?utf-8?B?Nm1ONXk3QnFVQW9SYXh0VFZDSEQ4MFJWb2dvUGtXUWhoNFBvb0lwaDJpdkxJ?=
 =?utf-8?Q?ofuYjUzFwzE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWFyUlByTXNVL3ByWUhqazl0KzM1dm9nV2hUMjA3RzJlQW5CSWpadG5mMGxO?=
 =?utf-8?B?UzdaREc3R2xTRzc0V0JESGhZeXFYQjZZQ2M1bjcwVk54UkREeDQxcTFZZVN5?=
 =?utf-8?B?QVpwQ29pdjArK0JCeEVZRnhWQVUyL2pRV09WblRUeFlyQ2lLNEF3d0hnZ0ZG?=
 =?utf-8?B?Wnc2VmZFUS9qaElvR0RZYzdFbExWbzVrdDRLQW9HWlRNbmQ1NWxtTEpmcm9K?=
 =?utf-8?B?NmhWMnVUT2NjcDNCaE1ZSnlNREx2czhPU3FQN0Zsd1ZPRDg3UUZ1ckZWMEhp?=
 =?utf-8?B?ZTdlMHlIeFFRVVBwbElZT056dXQwTHZDT1BIbVBHVnN0aW1iQlhQMnhyOEZ1?=
 =?utf-8?B?WHZwYWN1M0NNR1lpN01zRzJqRnlYMHRWUG1IWWl6RmlhUUg4aC9MaTZCWXNP?=
 =?utf-8?B?MjlpNlJ6ZGtFdWNyU2pPMDJXaHFIMUYzQU1LN2NaNHhoMFdLczVXbW5rOFBZ?=
 =?utf-8?B?N3NhUWhQcHhvQ2Z6YklqT09INGc5YktwT0FlZTJIcHZRVGpES2pLTk1rV2dj?=
 =?utf-8?B?dFlGN3pVRS95TVVXbDZFV0FmM0o1ZFBUUk4zTWhhTzVueUVBN243bnl4bmpy?=
 =?utf-8?B?S0dMUkxXaXpRNGJ1bzVoVE5TNHpnNlk1MitsS2VKMG1GMTJQcWU1Rm50NTVj?=
 =?utf-8?B?Q1pTVDdHcXdpaEVGRTl2SVl2VDRtY2haOVNUTVkzMHNmUUVMb3ZRUGZOSFVo?=
 =?utf-8?B?RXRXYVNMZEFSUzZnQUttZFdmRGFZdjdGLzlFNWFJQVZ0Z0VlV1BncDFGbzlj?=
 =?utf-8?B?U3VHSGU2amt0S1RvUHNDbU50TDhxRmZIVjhyRnZhZUtUanBHUnE5dGJYdUta?=
 =?utf-8?B?b0czSkFjUFI2Zjd1Qm8wYWRCbHJTaU85ZWtjdlFiR2EycjRjYm1PR0FQcGxl?=
 =?utf-8?B?TGlHVjQySUwrcDNrdEcrN25PUzJNTnZBRGhCVFBwdkV2YlgrQnpZcys4TjNa?=
 =?utf-8?B?Y1AxSzVnNE8zQmNEL3d0aWNwQ2l1a2NaM29nektQa3BrcG9iUStxb3dQWWlF?=
 =?utf-8?B?NGkvdjg5Y1Q1NFBxb0UwQnQ0L0lrcVFpaXV2MFYwaWNJdlFoTVFrdW5ORXZn?=
 =?utf-8?B?R2I3OVV5T3o0ZVpnK2VkLy9uOThoMmEwbzNTVW5BdFpYSk5ZTW93T1JDSjJz?=
 =?utf-8?B?TnJuOFRHK3lzbXd3SU1jVUd0SXcwdi9kSUFSbGFCK1cyVEZSZ05KMkdFc01W?=
 =?utf-8?B?QXpNTGdQODNKT0xyZ0Vnc2haWVk3VkszNHZXS3ZSSW40UG5nRVZGV2k0OVhr?=
 =?utf-8?B?WEo1NGFzTFRNZnRZcWRvcUpScGhYdjliVGhzS1MydHB2RW1kQVMzcVdHckNO?=
 =?utf-8?B?ZDdteHFWVXlScXNMSlNCTTYraFNBL3VoZ2h1c0RTbWlvdHJ4bndPQzd6OU5y?=
 =?utf-8?B?a1JGd3R5V2x1RlVyOUN4Sm94RXBnOE42bHZQN01Qai96UzJoQThBVGtYNENt?=
 =?utf-8?B?dDVCN25yaDhhdW1FS3FpMEs2d08xek5lMG5EcjF2bis2NVRrbG1qUnh4YXd6?=
 =?utf-8?B?akJoT2Z4cVFUaDNPSjZiNW9IbWNiNWpmTVRLbTlTNlN4MGJ6eTZSbE14QlBS?=
 =?utf-8?B?V0h5T1BLRW1aTHovN2w0aEszK3VuSndSeFhQZmxwZXNlVkVVdnJwRU9kSmNr?=
 =?utf-8?B?UGhKM0hYUzI4dHh3TGlHR2RnYUZHeFNHWlVzZHhBNzdjUmM2bi9JTmZ2bUxj?=
 =?utf-8?B?bUl5QU9zdXlQYlh3bG9jazcyWTRzZmtqMU10cGErbmxHVThST1JEMWhCUm1z?=
 =?utf-8?B?YUc0YkZoaFM4Qjd3Z3BrUlB4RTNVS2VJSG5Hc0RaZGxhUDdlMVBLc2pib0t4?=
 =?utf-8?B?cEZacXAxNFFwT0VlZXBXME1NL1B0eThQbmh1S0NaU0lrUUVPellmclJ1QmpP?=
 =?utf-8?B?RS9TTlh2UDRUdCtuVTQ0NlFXV0hkYjdxOW42cDZNQnpIUVczRXNBUlN2Wmdw?=
 =?utf-8?B?aUhqRE8zRWFmSmJ6QUwrUEhJeDIrczA1emtnOWgydS9kZmFXWGNnSEFwR1h1?=
 =?utf-8?B?SU1RT3l5Z2xQcEpXZGhLVE5TamcrUG1xSXVMT3FCTWdqWVNkVEVNVWxMeGxZ?=
 =?utf-8?B?Qi9XOG56Q2xZSzlQTnRtcU5uNy8xU1NsM2ZMaEViUHFhbElDVkxSTkhXczdw?=
 =?utf-8?B?UGR0ZVlxQnluMEJkYXBUb0tCKzhGeFk0QkZkV1dDR3cwbjZtdUU2QXlZQ2cy?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fd0f5e-22ba-46ef-9f32-08ddc95b7594
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 20:08:01.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owEJFCTOhT47HkgN+KnselkifEq7X42LD4xBXES6llwoUxDNTzf7/3VfMe/ZV8+mKE1Hjnt1qCk4CbtIc+wwaogC3h0HpjtG2uaQE3xiycg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7773
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> This series introduces the ability to manage SOFT RESERVED iomem
> resources, enabling the CXL driver to remove any portions that
> intersect with created CXL regions.
> 
> The current approach of leaving SOFT RESERVED entries as is can result
> in failures during device hotplug such as CXL because the address range
> remains reserved and unavailable for reuse even after region teardown.

I will go through the patches, but the main concern here is not hotplug,
it is region assembly failure.

We have a constant drip of surprising platform behaviors that trip up
the driver leaving memory stranded. Specifically, device-dax defers to
CXL to assemble the region representing the soft-reserve range, CXL
fails to complete that assembly due to being confused by the platform,
end user wonders why their platform BIOS sees memory capacity that Linux
does not see.

So the priority order of solutions needed here is:

1/ Fix all shipping platform "quirks", try to prevent new ones from
   being created. I.e. ideally, long term, Linux doed not need a
   soft-reserve fallback and just always ignores Soft Reserve in
   CXL Windows because the CXL subsystem will handle it.

2/ In the near term forseeable future, for all yet to be solved or yet
   to be discovered platform quirks, provide a device-dax fallback to
   recover baseline device-dax behavior (equivalent to putting cxl_acpi on
   a modprobe deny-list).

3/ For hotplug, remove the conflicting resource.

> To address this, the CXL driver now uses a background worker that waits
> for cxl_mem driver probe to complete before scanning for intersecting
> resources. Then the driver walks through created CXL regions to trim any
> intersections with SOFT RESERVED resources in the iomem tree.

The precision of this gives me pause. I think it is fine to make this
more coarse because any mismatch between Soft Reserve and a CXL Window
resource should be cause to give up on the CXL side.

If a Soft Reserve range straddles a CXL window and "System RAM", give up
on trying to use the CXL driver on that system.

CXL does not completely cover a soft-reserve region, give up on trying
to use the CXL driver on that system.

Effectively anytime we detect unexpected platform shenanigans it is
likely indicating missing understanding in the Linux driver.

> The following scenarios have been tested:

Nice! Appreciate you including the test case results.

[..]
> Example 3: No alignment
> |---------- "Soft Reserved" ----------|
> 	|---- "Region #" ----|

Per above, CXL subsystem should completely give up in this scenario. The
BIOS said that all of the range is Conventional memory and CXL is only
creating a region for part of it. Somebody is wrong. Given the fact that
non-CXL aware OSes would try to use the entirety of the Soft Reserved
region, then this scenario is "disable CXL, it clearly does not
understand this platform".

