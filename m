Return-Path: <linux-fsdevel+bounces-55019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAB3B06640
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C201188F23E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500462BE7A2;
	Tue, 15 Jul 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGabPSxk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB1225776;
	Tue, 15 Jul 2025 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605167; cv=fail; b=a922ke13P3+2za7lhfUApKLSkAS7FIb3ZcT2Wm2cHS7dEfCTOryzEj1SBngzcgjuPV3Slq3baRNPWa66DkkD9t54GYeDZm3D+eQN+chAVI105slwvXEsJus207ZEHJm73KQ/Ja5gGRvHV0kOMGedjpkxfHzhTOLHgAJ7UIBBwsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605167; c=relaxed/simple;
	bh=Bm2L0MEKlvFKvUvXGTAprUd9oDQJMQIXJikaI4rGyaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AIxAGJozrK2KaFQV56v52O6wEPEgsPYrhkuNUMUr5fLakjFzwP5Sbhqza6leyV412coJLDPflhlsoxB2PflWq4kfv8GiLlgy6W+liVfTlPJWp614WDnES6gIHrYzn2Xg9zTIHmlkxa1JgU80+U648lhAT8bkpNz4/2HlRAVE/V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGabPSxk; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752605165; x=1784141165;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Bm2L0MEKlvFKvUvXGTAprUd9oDQJMQIXJikaI4rGyaQ=;
  b=BGabPSxk6V3hg9b7KLW8A2pgNsfYTnUno1HJYYqNYPtnSy27eSdsq6HB
   ZBCyi6C1ltL5sgCT+WpFA5yUU5jOlKqiJNI+vQRBXVjUbJlzoR+NKF2gK
   vOff+JrT9WPv4vVVDZey1O0aSr9e0A03WQia+Vu6yZEm8o+Qlp4/X8qBZ
   +X+EZQ7HXOqLvS7uvYhZ2jjZjs4dGDv+3mNNfirK3hFmUG3Ffmj/ifV6/
   5qCBAfPvLLwo51/Ve27LRpE/4tA+Z5spsa6hsAhMcSi1Nt2HL7DIAgiQl
   RD62d0ltXSAf9WJtqje2lg79Gf0/SRprhHI8iTNVqB6SlSOBfdKJoTDb7
   g==;
X-CSE-ConnectionGUID: aFmWSdiyTH2OGnE6qLdbkA==
X-CSE-MsgGUID: 48yJuh15SHukk+51yflpmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54928302"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="54928302"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 11:46:04 -0700
X-CSE-ConnectionGUID: Sk1pBsprSSKN6iU1x5fXAQ==
X-CSE-MsgGUID: 3/CBUkglTiGyy408FXm+jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="156964857"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 11:45:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 11:45:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 11:45:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 11:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNnsNyuVXHIeUldcyfdw7lwWzwo3NQiYxsNQM16qHk/3Rh1hVmH8pgpiaVMZ4ZNRiMn8sD8dqiuvWsUiMembCcjvDb/Xst33Aun+NQga0imBCMKBNqJ9xH6EIE6SZxiomETTb1AkCvMgnSYcyhAwIqiDW/poDEWVFAdSemtdS+nwmHhfqg6fD6bSy9IX4TpA8iCQE2UwbmLOvPh+3rzjsGfMomeIpJSFdzpYXfa0UFQTwo3CGNMSgYtCA1KxQSl4a5qVskyEsFX1DGDatrd3szJigyZ/RG7uW8ZOBrKMOj53luXlVD+PhraSuc9+lQ6Md7kLKTC6ZEsgQxagY8gnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3BGNkL9kiOPthtIkMOU6lJ6/G3A14dAF8V32dQ6V8c=;
 b=Nb0vbPpEputiAvs+VnVTK7cCif2D493bA3Pvoi+l8MUvSa0Rv3PLHaYDDonRbDqd6Em9js1YHePBjU6zJ6yYyUHeNCiPqBE9VzcoffifAwOTCkJXLQVynEFgVGZJuPqyC9T5T2U+hY4G92BUMz+yBzT9LcFChWPJbaRE2L0myhTfBM+M8riIaqiDzQlijxTp2v7O0DLYUc1aUWL/y9Q4h+a4y1CVwRB+MR51c7j6B2gI0ISpnPzX8KyuNK0TxZvUG2PeoUide7daira6/w304C4cTCjDJnd762R3+b6P7DUel2DzwnHr8rLVSJ/kWb+f471FW+eskT13EZFhq2hawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB4924.namprd11.prod.outlook.com (2603:10b6:806:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Tue, 15 Jul
 2025 18:45:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Tue, 15 Jul 2025
 18:45:11 +0000
Date: Tue, 15 Jul 2025 11:45:05 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>
Subject: Re: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED
 resources until after CXL region creation
Message-ID: <aHahsRXdQnF87LlC@aschofie-mobl2.lan>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
 <aHaBdj0QrEe_gymR@aschofie-mobl2.lan>
 <4aefce95-0029-49d1-99d2-c132406ec84f@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aefce95-0029-49d1-99d2-c132406ec84f@amd.com>
X-ClientProxiedBy: BY5PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:a03:167::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3e6477-79fb-4549-c7b5-08ddc3cfba3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1J4OUFLSi9CaFhpWVB4WDdOQkJFRUlibFpTMTNNNzBxaVNETnp4NzJBcklv?=
 =?utf-8?B?ZUpMSCtNZDB0RzliQnk4U21GRzFlaE9rejV2MUtiQ3FUUVFCZWVvTHJZNFRU?=
 =?utf-8?B?a1JpaUoyNFUzOEluQXlOUEVKbWFQTkxXNVFQcUFBR1NrRHhpYTdLVElPQmZC?=
 =?utf-8?B?ZXUySVViTlVqeVRoM0ltOWZFcDQ1THVWbW40bHVPcFdRZEgxYkdtWFVMdTEv?=
 =?utf-8?B?K090eUdsMVVldDB1Q2xjUmZxbXZMU3Ywc09jeEltWnFKaythZUc0U3pkS0ti?=
 =?utf-8?B?Y0lLcFRyQ2tXWTRGT0pmNjJSZ0FQSWtQWHF3ZEE2STVFc3NBZVFvTDEvd1B5?=
 =?utf-8?B?cmh1OHJRcWRlSVRGSkp3bm9kSTcyclMyb3BVV2pQR294RU5YQnJoeGZCTmFp?=
 =?utf-8?B?MWU1eGxVcVdNUlpzQ0R3RnBHQ1B5V0J4ZFJpRmtBU3loQ0NmcGViWnpxb0hY?=
 =?utf-8?B?cXc2N2ovVHRESXU1bVE1TkNpbVlFRGR3MFdWMzc0L3R0VWVNMVVpZFFRNHA2?=
 =?utf-8?B?M2hSeG4rR055QXR3SW1TQ1hDek1La3pvazFSV2dBb2M0ak9LcGFkdnpjeHJR?=
 =?utf-8?B?T2JlNmVJQ2s0MDlXZVQwaEFCOTZEOGg1cHZnNGVQbFZrUFZHbndXMUdhLy9T?=
 =?utf-8?B?WW5aSGIyeXZBc0N6blhXL2IxdmZ3YXl6dTlmcWNQUHM5TzRndmR0RWlyazQv?=
 =?utf-8?B?WUJZLzl4MTlhSTk0WS9IVmVvMkNSSktzZmdpTEU0UzBrRzh5T3FpZW04cE0y?=
 =?utf-8?B?Y0d4L0RhVk11NklyTzVhR3g4ejJMOCtGZTIrRGdRaXZpRE94VHhLRW9ISUlR?=
 =?utf-8?B?NVFsWFFiVEQ1Q1hhaldvcitYOXYzMldydmFGanhlZ05XU1pSNWRrS2c3ZU5H?=
 =?utf-8?B?cDFCOStpdDdGNlR1M0prVFFTMDAwQ25JR0xHSlZXbDlOdTl2RWhEc0gvZUtr?=
 =?utf-8?B?OS9vQkI2NjV2dUxVMFdjazlsNXJRME5MV0dtZlg2MDEvZzdUUUE3U3BpbUsv?=
 =?utf-8?B?WG9CTC9FM1ZQQjZqdEl5a2ZYellFQ1ZIM0l6K3RkSmZvU1BxUE1FeUhPekxy?=
 =?utf-8?B?eC9naUYwSnBBd1EzMTN2dElTYnhIRXhwVUZPM3BCdk5hQVJvQzlKZTdKZi9s?=
 =?utf-8?B?ODBkM2NOOHZGa1RKR052TnhVVGIvK0ErSGpjcnhqNzk5UHVoeHo2MlArQTVD?=
 =?utf-8?B?b1pzRlYvZ2xjS1BzSU5yV216MnU2UGN3K2tCSFRpcXZ3dWZYRkVmZGxIaVZr?=
 =?utf-8?B?ZEhCOEUvemJMNWdwRkplODA3UHo0ZlNCNnI0bDEvU29sWGtjSkswNGxZMEZD?=
 =?utf-8?B?TVZBZFh4WlQvZ0NqbWFuR3VNakdrbjNwbWlrRUlXMjZDZzZDMWE5NUlKY1hq?=
 =?utf-8?B?d2ZkbTcwRlJEOWN6TnJLSHN0SXdIWFBVOFlmZk5XaEpMNno2QmVmWFZpMEs2?=
 =?utf-8?B?Q2dSalBrMVVvZXZtMEJlK2tPT0pzZTBFNk9lS1V3OTJGbDZKS29wWnNnYVhw?=
 =?utf-8?B?cXM4TWtrMHJ5Y281c256YU5PWG5PWEU2T1ZXc2l5cWhwWFp5TjY1dGxJV296?=
 =?utf-8?B?emh4TEFCRWhZV3hxYWJWL21YSzZ5RlN4aFc0NVY3SThuWDBtOEFwQUY3M1VK?=
 =?utf-8?B?ZkVsU1RmakJvUm9sVDBqVHJOaWNrNXZWbzRXenU1Uys4dnlpd3o3bExpSHNO?=
 =?utf-8?B?dEJ6V1JiVkdKYllHQ25ndUtDdkFFL3NraFJSTWViVy94VVd4VUEvUjdGcWIz?=
 =?utf-8?B?WEkwT0xoUkVtNElOaitneUN0NGRBUEJmdG52bmYwRFRESUtlamI3WXZiQ1Rw?=
 =?utf-8?Q?+P0rRKureXYuYmC0y0xRgxg1Q5waj89jgYqhw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NStWVXAxQ3ptUzh1UU5pb3BNLy9zejJvcHRuN2h3bUZIYnBVKzZWbjRhOGhV?=
 =?utf-8?B?R0tFYzBSRGorY3FHZWNBN09VWFIvbmxHK1dFZGZDeXEzSUNDb3VqMlBVZkdC?=
 =?utf-8?B?YTFEUE5sU1VEQ3UrWTdycjN5VXErNXNQN29jWnVGbWI2bEJZWTBZZUxWSTM2?=
 =?utf-8?B?QldWbUYrWjRlcmlzcmR5MUc3Zm1EUW1XL2lYdHZOb1NzOC9xS2dSSTFaNWY0?=
 =?utf-8?B?N2dRZzgwK3Faei93U1RlTktXZWJJenZSVEtXcDFETHJNVVFJZjNZVjFxWmNH?=
 =?utf-8?B?Tyt5a3J6UUJ2ZGNSRFRGZHZTd2hIY3VYaml5ak5qY1MrTU9vKzZFNndUK3Fw?=
 =?utf-8?B?L3ViSStRNkhIbElPQ3VOVkFWdTFCcGdyVXJHaG5kN1BsaWRDYW8zVkhhYnRw?=
 =?utf-8?B?WjBSRGVMODMyc0VoL0RDNFROQzk3dGg5TTI4SEV6MjhRK2NUZUxYNlZpdmlO?=
 =?utf-8?B?RDBvYkFqS1FyUWFMOEsyY28zOFhZRHBBaCtRZzNIekhBZkcxS25kUGthYkYw?=
 =?utf-8?B?dFlReXMrd0ZSMm5jTnB4WGxYaThkZFQ1eEsxOUZ4MXZBT01aelVJVUtIWHAw?=
 =?utf-8?B?NncxQUhQNHkxVWNFQVBsb3hqVlVYeTlKdlAzZXlsT2xHNUIxNFpWWWxHVjNi?=
 =?utf-8?B?b3JmYjkzVDVsSU8zb0pFUDRWeU5Qa042QnBWK2xoczZBRWtZZU8yWElUTDk2?=
 =?utf-8?B?S1FPeHVybFJsMFQzdUgwNTJEN0E4YzlVNmxyd2huWG04aEJXWFVDRWxqVGpN?=
 =?utf-8?B?N3ptNlZTZEhJcGFnYmxDTVJRZHhSVjl3Rm1ZcndPQzE2bEdlYXBzQ2ZmdThK?=
 =?utf-8?B?TFRXaFBGVEhNU3duL1FCcDVUdnRqV3pQZHpTZG9mQVIxNkMxVWJqb0cyNFBL?=
 =?utf-8?B?K3hJSFpGUDJjNVJ5REdmblE4dnFxQUNhSWdnMWZQTjhmYno5TVZ3b2JNZlg2?=
 =?utf-8?B?M3Y4Q29CYytiMkpOMzVFTFZqdlArb3I4d2o2K0tseEhzUVVURmthczJ2a2Vz?=
 =?utf-8?B?dHJVTVpTWW9LeG12MndXRGhKa3R1SWQwMksyY0FLellJemlBSHk0QnNFMm5G?=
 =?utf-8?B?QlZ6OUt4djBNL2lsTG5DeHhSMzQ4ZGttSW5UYm5JblNieWhJRUJmb3ExQ2hp?=
 =?utf-8?B?OG8wbkJscnlBcGRCQXd6ZTN6RnkzeFhIcGljTGpWcnBZd1BvUjVLQ2JNUmI1?=
 =?utf-8?B?QXpuV0hEMkVtaUR1b2RTQmdsQS9iR3BRTEJ4NVRXdjgxSWRPcXlSN2Zodmpz?=
 =?utf-8?B?SkQ4V3l5d3RWNmRpeXIyMkxibnQ1blQxS0Q1VExRa1lsMWlQb2kzQjZDNFd4?=
 =?utf-8?B?ZDFkUUdzZUdPMlNoRDBrdXg2UWV1M0xvZXdLN0c4M3VEWGpLai9RZjFpdWFN?=
 =?utf-8?B?ZFNqZ1hMNTRrY2xuZVQwSkdSSm16MXVCWGZqYVhQN05uNkVySUtoYzhobGVB?=
 =?utf-8?B?OEEwdWhVbk9VY05BYjJWMnlPK29PTVJVbGdsNXMwalorYWhRblIyZzYxTUFW?=
 =?utf-8?B?U2RPZ1VsM205Ri93Qm1nWWlUU0xSM21UZVFUeE5oVU9tMVpGUTVpa2x1VEJj?=
 =?utf-8?B?Z29kT0tLM2F4QmxsOWNmVVhJeXo2VkdYMERuc0FvT0JnRUo5YWUvZVJDeVJD?=
 =?utf-8?B?T1ROV3R2bGlZallmRTNaMmpNR3BxK1BodzN5cVkzeXVOV2NlZWtKazZINUFu?=
 =?utf-8?B?VmpSajNpTHYxWStISWRlSDh3bVNFdk9xODcxQmk2QXI1ZldHcFlKMmJuWldH?=
 =?utf-8?B?WTVOdWQrdlJKTEFHSFNudjhYdWthT0NtSHVMZGFjaVdXLzgzQlNLZUFBcE5n?=
 =?utf-8?B?bzRUNlF5eXNSVXpiUkpDdVNGRTFLMGhoUmdwN0JUUHhQSVU3UjBZLzh1akM4?=
 =?utf-8?B?dDJxSDJRN3Y0MjNCTHRxK2VmSThQNnpISWltRGVmdjlEMUUxVkFQUUNwZno1?=
 =?utf-8?B?ZWxUL2JmQVpCRmJGMElDMEFXOWpNaklPZ1Q2Mi9ZSkI3b1k5MVpKQ29YWldV?=
 =?utf-8?B?YVhJQjNzS2xsRG9nR1N3aWRzYXN0MnlSYm5idnM4SVZBckxta2d0S083eUFR?=
 =?utf-8?B?ZGZZeE9nMmFRQWhnalBwZ1JQVkdvRTRESnlFVEt4MWlCNnFIWlIydEczbEF2?=
 =?utf-8?B?dUxMYTVlZXoxRGQ2Z0FjTHIxWVJublF3NjdhdHNtV2hhQjExMWJnclo4QnFR?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3e6477-79fb-4549-c7b5-08ddc3cfba3d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:45:10.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uk2zi/G5Jnr4o//etMrVejU8ZZrVJpJA+DmWKFSB8APXJ+vf/IMTOC0E/imBvVhgKXq1VaSVkjpGrnoktMY5tuDVg97Gq1QEM0h/uryRxGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4924
X-OriginatorOrg: intel.com

On Tue, Jul 15, 2025 at 11:19:05AM -0700, Koralahalli Channabasappa, Smita wrote:
> Hi Alison,
> 
> Sorry I missed this email before sending out v5. Comments inline.

Ah, I see v5 now and will try it out. Thanks!


> 
> On 7/15/2025 9:27 AM, Alison Schofield wrote:
> > On Tue, Jun 03, 2025 at 10:19:49PM +0000, Smita Koralahalli wrote:
> > > From: Nathan Fontenot <nathan.fontenot@amd.com>
> > > 
> > > The DAX HMEM driver currently consumes all SOFT RESERVED iomem resources
> > > during initialization. This interferes with the CXL driver’s ability to
> > > create regions and trim overlapping SOFT RESERVED ranges before DAX uses
> > > them.
> > > 
> > > To resolve this, defer the DAX driver's resource consumption if the
> > > cxl_acpi driver is enabled. The DAX HMEM initialization skips walking the
> > > iomem resource tree in this case. After CXL region creation completes,
> > > any remaining SOFT RESERVED resources are explicitly registered with the
> > > DAX driver by the CXL driver.
> > > 
> > > This sequencing ensures proper handling of overlaps and fixes hotplug
> > > failures.
> > 
> > Hi Smita,
> > 
> > About the issue I first mentioned here [1]. The HMEM driver is not
> > waiting for region probe to finish. By the time region probe attempts
> > to hand off the memory to DAX, the memory is already marked as System RAM.
> > 
> > See 'case CXL_PARTMODE_RAM:' in cxl_region_probe(). The is_system_ram()
> > test fails so devm_cxl_add_dax_region() not possible.
> > 
> > This means that in appearance, just looking at /proc/iomem/, this
> > seems to have worked. There is no soft reserved and the dax and
> > kmem resources are child resources of the region resource. But they
> > were not set up by the region driver, hence no unregister callback
> > is triggered when the region is disabled.
> 
> I believe this should be resolved in v5. I see the following dmesg entries
> indicating that devm_cxl_add_dax_region() is being called successfully for
> all regions:
> 
> # dmesg | grep devm_cxl_add_dax_region
> [   40.730864] devm_cxl_add_dax_region: cxl_region region0: region0:
> register dax_region0
> [   40.756307] devm_cxl_add_dax_region: cxl_region region1: region1:
> register dax_region1
> [   43.689882] devm_cxl_add_dax_region: cxl_region region2: region2:
> register dax_region2
> 
> cat /proc/iomem
> 
> 850000000-284fffffff : CXL Window 0
>   850000000-284fffffff : region0
>     850000000-284fffffff : dax0.0
>       850000000-284fffffff : System RAM (kmem)
> 2850000000-484fffffff : CXL Window 1
>   2850000000-484fffffff : region1
>     2850000000-484fffffff : dax1.0
>       2850000000-484fffffff : System RAM (kmem)
> 4850000000-684fffffff : CXL Window 2
>   4850000000-684fffffff : region2
>     4850000000-684fffffff : dax2.0
>       4850000000-684fffffff : System RAM (kmem)
> 
> I suspect devm_cxl_add_dax_region() didn't execute in v4 because
> hmem_register_resource() (called from hmat.c) preemptively created
> hmem_active entries. These were consumed during walk_hmem_resources() and
> registered by hmem_register_device() before the CXL region probe could
> complete.
> 
> In v5, if CONFIG_CXL_ACPI is enabled, soft reserved resources are stored in
> hmem_deferred_active instead and hmem_register_resource() calls from hmat.c
> are disabled. This ensures DAX registration happens only through CXL drivers
> probing.
> 
> > 
> > It appears like this:
> > 
> > c080000000-17dbfffffff : CXL Window 0
> >    c080000000-c47fffffff : region2
> >      c080000000-c47fffffff : dax0.0
> >        c080000000-c47fffffff : System RAM (kmem)
> > 
> > Now, to make the memory available for reuse, need to do:
> > # daxctl offline-memory dax0.0
> > # daxctl destroy-device --force dax0.0
> > # cxl disable-region 2
> > # cxl destroy-region 2
> > 
> > Whereas previously, did this:
> > # daxctl offline-memory dax0.0
> > # cxl disable-region 2
> >    After disabling region, dax device unregistered.
> > # cxl destroy-region 2
> 
> I haven’t yet tested this specific unregister flow with v5. I’ll verify and
> follow up if I see any issues. Meanwhile, please let me know if you still
> observe the same behavior or need additional debug info from my side.
> 
> Thanks
> Smita
> > 
> > I do see that __cxl_region_softreserv_update() is not called until
> > after cxl_region_probe() completes, so that is waiting properly to
> > pick up the scraps. I'm actually not sure there would be any scraps
> > though, if the HMEM driver has already done it's thing. In my case
> > the Soft Reserved size is same as region, so I cannot tell what
> > would happen if that Soft Reserved had more capacity than the region.
> > 
> > If I do this: # CONFIG_DEV_DAX_HMEM is not set, works same as before,
> > which is as expected.
> > 
> > Let me know if I can try anything else out or collect more info.
> > 
> > --Alison
> > 
> > 
> > [1] https://lore.kernel.org/nvdimm/20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com/T/#m10c0eb7b258af7cd0c84c7ee2c417c055724f921
> > 
> > 
> > > 
> > > Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> > > Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> > > Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > > ---
> > >   drivers/cxl/core/region.c | 10 +++++++++
> > >   drivers/dax/hmem/device.c | 43 ++++++++++++++++++++-------------------
> > >   drivers/dax/hmem/hmem.c   |  3 ++-
> > >   include/linux/dax.h       |  6 ++++++
> > >   4 files changed, 40 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 3a5ca44d65f3..c6c0c7ba3b20 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -10,6 +10,7 @@
> > >   #include <linux/sort.h>
> > >   #include <linux/idr.h>
> > >   #include <linux/memory-tiers.h>
> > > +#include <linux/dax.h>
> > >   #include <cxlmem.h>
> > >   #include <cxl.h>
> > >   #include "core.h"
> > > @@ -3553,6 +3554,11 @@ static struct resource *normalize_resource(struct resource *res)
> > >   	return NULL;
> > >   }
> > > +static int cxl_softreserv_mem_register(struct resource *res, void *unused)
> > > +{
> > > +	return hmem_register_device(phys_to_target_node(res->start), res);
> > > +}
> > > +
> > >   static int __cxl_region_softreserv_update(struct resource *soft,
> > >   					  void *_cxlr)
> > >   {
> > > @@ -3590,6 +3596,10 @@ int cxl_region_softreserv_update(void)
> > >   				    __cxl_region_softreserv_update);
> > >   	}
> > > +	/* Now register any remaining SOFT RESERVES with DAX */
> > > +	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM,
> > > +			    0, -1, NULL, cxl_softreserv_mem_register);
> > > +
> > >   	return 0;
> > >   }
> > >   EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
> > > diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> > > index 59ad44761191..cc1ed7bbdb1a 100644
> > > --- a/drivers/dax/hmem/device.c
> > > +++ b/drivers/dax/hmem/device.c
> > > @@ -8,7 +8,6 @@
> > >   static bool nohmem;
> > >   module_param_named(disable, nohmem, bool, 0444);
> > > -static bool platform_initialized;
> > >   static DEFINE_MUTEX(hmem_resource_lock);
> > >   static struct resource hmem_active = {
> > >   	.name = "HMEM devices",
> > > @@ -35,9 +34,7 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
> > >   static void __hmem_register_resource(int target_nid, struct resource *res)
> > >   {
> > > -	struct platform_device *pdev;
> > >   	struct resource *new;
> > > -	int rc;
> > >   	new = __request_region(&hmem_active, res->start, resource_size(res), "",
> > >   			       0);
> > > @@ -47,21 +44,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
> > >   	}
> > >   	new->desc = target_nid;
> > > -
> > > -	if (platform_initialized)
> > > -		return;
> > > -
> > > -	pdev = platform_device_alloc("hmem_platform", 0);
> > > -	if (!pdev) {
> > > -		pr_err_once("failed to register device-dax hmem_platform device\n");
> > > -		return;
> > > -	}
> > > -
> > > -	rc = platform_device_add(pdev);
> > > -	if (rc)
> > > -		platform_device_put(pdev);
> > > -	else
> > > -		platform_initialized = true;
> > >   }
> > >   void hmem_register_resource(int target_nid, struct resource *res)
> > > @@ -83,9 +65,28 @@ static __init int hmem_register_one(struct resource *res, void *data)
> > >   static __init int hmem_init(void)
> > >   {
> > > -	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> > > -			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
> > > -	return 0;
> > > +	struct platform_device *pdev;
> > > +	int rc;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_CXL_ACPI)) {
> > > +		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> > > +				    IORESOURCE_MEM, 0, -1, NULL,
> > > +				    hmem_register_one);
> > > +	}
> > > +
> > > +	pdev = platform_device_alloc("hmem_platform", 0);
> > > +	if (!pdev) {
> > > +		pr_err("failed to register device-dax hmem_platform device\n");
> > > +		return -1;
> > > +	}
> > > +
> > > +	rc = platform_device_add(pdev);
> > > +	if (rc) {
> > > +		pr_err("failed to add device-dax hmem_platform device\n");
> > > +		platform_device_put(pdev);
> > > +	}
> > > +
> > > +	return rc;
> > >   }
> > >   /*
> > > diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> > > index 3aedef5f1be1..a206b9b383e4 100644
> > > --- a/drivers/dax/hmem/hmem.c
> > > +++ b/drivers/dax/hmem/hmem.c
> > > @@ -61,7 +61,7 @@ static void release_hmem(void *pdev)
> > >   	platform_device_unregister(pdev);
> > >   }
> > > -static int hmem_register_device(int target_nid, const struct resource *res)
> > > +int hmem_register_device(int target_nid, const struct resource *res)
> > >   {
> > >   	struct device *host = &dax_hmem_pdev->dev;
> > >   	struct platform_device *pdev;
> > > @@ -124,6 +124,7 @@ static int hmem_register_device(int target_nid, const struct resource *res)
> > >   	platform_device_put(pdev);
> > >   	return rc;
> > >   }
> > > +EXPORT_SYMBOL_GPL(hmem_register_device);
> > >   static int dax_hmem_platform_probe(struct platform_device *pdev)
> > >   {
> > > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > > index a4ad3708ea35..5052dca8b3bc 100644
> > > --- a/include/linux/dax.h
> > > +++ b/include/linux/dax.h
> > > @@ -299,10 +299,16 @@ static inline int dax_mem2blk_err(int err)
> > >   #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
> > >   void hmem_register_resource(int target_nid, struct resource *r);
> > > +int hmem_register_device(int target_nid, const struct resource *res);
> > >   #else
> > >   static inline void hmem_register_resource(int target_nid, struct resource *r)
> > >   {
> > >   }
> > > +
> > > +static inline int hmem_register_device(int target_nid, const struct resource *res)
> > > +{
> > > +	return 0;
> > > +}
> > >   #endif
> > >   typedef int (*walk_hmem_fn)(int target_nid, const struct resource *res);
> > > -- 
> > > 2.17.1
> > > 
> 
> 

