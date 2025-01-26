Return-Path: <linux-fsdevel+bounces-40124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0034A1C6F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 09:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6D5166CE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFB14884F;
	Sun, 26 Jan 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8QWfXwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9F6A33B;
	Sun, 26 Jan 2025 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737879379; cv=fail; b=bHf2RlBxQAtGuJs9IhJ/6so35JJa/Nnj3x2IuSUXiAtyOkSXUFZLqFeA7myh4Ojcc91jd7pCa0mWMTz9x6blGSSyGD3NlG3irMWmhjQP2nKUD4Yb1IS3HjJBluxh6EDOq1nVMjJYxVsGCh9Inl82uvV8GNAntko3zJ9iQWw02gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737879379; c=relaxed/simple;
	bh=yRUiHprxrNvMQj29bfVYo7OYDBiB59eu0GZbhOTGmiU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bYINYGnYhA3iCmyOn5xFZ7dAcQz9IvJecutzI/IUn7LXrDlKflIsf6EmHcsvkWyrFzQWGvyIL3FnZyzmMiBSOrpgSNlLkgHowbbSVskg3nioy/Zb00Ifu2gJRxP1pBJGZYMoQAqEnJyKryCZEiCSkC6fY3XKoyw3fNH1DmeP4Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8QWfXwQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737879378; x=1769415378;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=yRUiHprxrNvMQj29bfVYo7OYDBiB59eu0GZbhOTGmiU=;
  b=Y8QWfXwQIwNk9YkzkWNnu3oxqd5JkVO3VCxOzUE89xeWlaFPG4880HcD
   ln99fJGk/5KIQbVD8JcJfllXISyXpIp8kYUoCfQXTZ+A7D71XVifFPfsW
   UoTsaxEkdj7gt14K65M8AgH5VDpNYW21NhXdjYDhoMcfjarm+N+GSifQ6
   xXw3Gy3yElI5oIYGEp0gN/3rMOr4DgtpVlE3yVPI6TnpYLVMQRrDLVBjP
   hzCk6wnQpZa3LGJWGyaKwZhLOxEZyYYCOKs0zmOMIjSr7riWxSaRL3vwG
   W8R065WVNSBljyfoj9+HRxzHWkt+RzLzEMmtlgMC0BIeteaaRzzYwfhff
   g==;
X-CSE-ConnectionGUID: 0Z2hJP3bSBWNrddY/v9srw==
X-CSE-MsgGUID: P4i6jQLXS1SpOKYWQbQOZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="49021065"
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="49021065"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 00:16:17 -0800
X-CSE-ConnectionGUID: bfkuNtZySVyq4I2m1Ai05w==
X-CSE-MsgGUID: 1vBcvhi6RPyG+NPURrzfYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112177321"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2025 00:16:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 26 Jan 2025 00:16:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 26 Jan 2025 00:16:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 26 Jan 2025 00:16:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyVchuAlZWcfc29u0wGDTtTUh3EIBxurBdzRefqQyIECnxJxLjz4eIBmPo/4PvAnAeuoYp8wlriukGotIQyqKPpsIDOVC1vkDHqeyv4SxJNTImrXBs6pdi/0jOme+dlC2z9ty1TXLREPS7nAbNR7z/JpKhcZtlQoKwCYKf8S3Mo+mBfpX97AO3b6/uZJ7ZuXynXyiibq5Lk2LB0p4CPjs+k4/bob0Tkd1k8AtyOvhF4tZlXd4beaMPSZu1jK6pdJdOM2b/hJZJ7uilGbEt75vzwO4+9XDeL55fRodwCQ5nDeiJPoyrJm4ep1Mv/4oG8xILFtDqrbfnLR88cTu1e8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsCIzQdoLTC34AzIIiYms0lmbEuTvm0RgqioVb1/quQ=;
 b=ITdbj4cyky9jPkX7Qa+qOWbDroJwTUpeiqgdHmLFo2S/9d9Qc1cbQHnbinQeGh6p4bj/NY8u1dvzm/WF5YpPOnSOVB3x1V2QiHaFAFYACJvFRfBAZpCHTYQPWjmeU18uO6dO8dzlfMByOM07Myd8Ff1stptvIxamwMu0aDcwqNJLLM9XCkmn3kLT2qgjZpFfbK3WuFj8vC4FCHZbEPdqgYZsCtvANbt/LbqRDLQkoMMwpW5t6k+58qUO8aULYghn/erRS4P55yvmIfTDNzgwCOjISdq0lCmgcJr6QK03oqgOzLUcgilLynemNvWhi9DL82SJEGhWSTOgRKw1Phqbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5312.namprd11.prod.outlook.com (2603:10b6:5:393::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sun, 26 Jan
 2025 08:16:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.009; Sun, 26 Jan 2025
 08:16:13 +0000
Date: Sun, 26 Jan 2025 16:16:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [do_pollfd()]  8935989798:
 will-it-scale.per_process_ops 11.7% regression
Message-ID: <202501261509.b6b4260d-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0073.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b121ec2-2548-4dd2-3280-08dd3de1b2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Z0S//4XIHPHlyiWOcPkU5wjyufGDay8rl+6+oM2/jx9cFvmiiXzhetyMDI?=
 =?iso-8859-1?Q?B6YaCtwf/2NonnHj0fdXULfi7avHH6WY3Dd7z/8Ku1GJ5xRp91rxHBe8xY?=
 =?iso-8859-1?Q?34zv6ccy2CJn15KacixGQ5hPiu+KKsQDjNqbisqMFJl9gzej3gD5quTiaO?=
 =?iso-8859-1?Q?Pzaat8mDZ28zymKUGclesiWvkVyfR7yhGBwtXA2oK4zHtaelbBfwpTmBbo?=
 =?iso-8859-1?Q?nz+Z74YOzOZbdRDL6u/y4WLQGKGCvYeXPiQdRAoY+HsFvR49HXIA0USl/4?=
 =?iso-8859-1?Q?BCCbrKJPpByOppUOowl0RXFEZjsXg6dXvDqLX4wo9FmrJmdDg3RwYxJt3d?=
 =?iso-8859-1?Q?MRBhovy5z3OUejYPMi1N1VrIXzu5Zrql+ygUcFcBd9/hBZ8Nn99XZxs223?=
 =?iso-8859-1?Q?YmHgCbKDtTyPwbzAYaDo2SWZ2q2zLiwqpP7CjKOrB4JZXPwnucolYNl61N?=
 =?iso-8859-1?Q?BOgmJrxsc1PAHiYoMJOC3B7LAEa3S2qXoryPIAyMf+i+CX4MBTZBubC4cx?=
 =?iso-8859-1?Q?Pni6b6WhILOza+mJP0pbgFtq8MyQXIn9+lN8vs+p0RLLXLjsWOCkkOopl4?=
 =?iso-8859-1?Q?oPud+r6NolP4mn/LyrAppVt2G/uFiEWWY3bhKROesnjmh6FOA00CTPnXNI?=
 =?iso-8859-1?Q?jLyLjDTADDVnStgH7ibBTqyXi1Gv+gMcYk1PVT1tI2bb4il22i99D2p4Gq?=
 =?iso-8859-1?Q?a2oc6ttvwau+HccBgE4Gq/6zWhHYdBJPcw28Fa9BjwqMfuj2whTVBCy1rq?=
 =?iso-8859-1?Q?Y06YVt65+Xsbfs4yXugwbAC0YlHefWDioXF7fR/uMvqXuB0EjzXq5KHNEl?=
 =?iso-8859-1?Q?0HtTrLqvOf7x+NeB9Twbt3pLXLgVVN9qgcwCCw8jRTgEDP8WkkH0zWgAXo?=
 =?iso-8859-1?Q?GESk90S7g0/VqjdQX+k3YTCcbdlx4l1m+4rW0RgSuRTcaXpxGTQCnACSZ2?=
 =?iso-8859-1?Q?+gMVlEwNd/mlCtuRUgdo62lEZTWvESkEuJ+UL2XYdK1MxhRSTudiZAoESC?=
 =?iso-8859-1?Q?Mi3qciL0lgiaMxvEGgsGSVOB9C2apraTNyLlPTH6eHhnm8pEpJbtVsQ2jY?=
 =?iso-8859-1?Q?e977up54NDJcdBWqeS7g7v5YGpIBi12FesIgOvQ2zcGER+2y1kbqmsMLE1?=
 =?iso-8859-1?Q?Th5l7NYJOxmHF69ZPUXC8+80m4UJs46vQ7wJ+06XHQaZosKCEiz154pvlm?=
 =?iso-8859-1?Q?EzEgQZC1QLKaebrqhPZ8ZGl3p2ssAvJy10PlOJsYjtjVbuWkhc5yOe8dBE?=
 =?iso-8859-1?Q?x+bObBbIuW2QhmLVgzPxNJR7UhvULVhEJYZYe9XdLuM4c3Of3JTJ6f4F/x?=
 =?iso-8859-1?Q?RtU/qBvPRqasbiRRxV4W2IKsK+ZWPNz8Q/FRkuh+xPZQDWVanX7j2MBHj6?=
 =?iso-8859-1?Q?rhIID/02gVXz2cz56d4WRxYpJIFSFFnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?p2gJs5XT12dHD1SpdmjEtqH0RYpQkOfLR142aOjgcVGnKtDgqV40PhOIlO?=
 =?iso-8859-1?Q?u/uaGV2i4tcdHN8vIbtJSVXP4vrs1fTSGgskKipQON+JsUb+EExab4IDs6?=
 =?iso-8859-1?Q?3xiW6urZptp98gB5X3yWg8XChELu9S0QuItHlwZZawul6/LgCXgYHCa6gg?=
 =?iso-8859-1?Q?ws4iGWf+QeSf62VoA34AcTJMUJz4mkJXDtL2RyiS2X4r+ZfXwI0/rwB72d?=
 =?iso-8859-1?Q?Yztcr5/W6Q4JDv0SgTvcR7qv3jd+X+7/mpW0ICI4PbHOoiI/38rvZqUnI5?=
 =?iso-8859-1?Q?0GTYi6VwQ4yC5ScWYYeycP1v5uIBiO9dSSTyGvXt1OXuerm73Lh1wj9Ebo?=
 =?iso-8859-1?Q?yP5gY5kYvGkVGf2kITepydSVWtlHI8cOnJY+lM2c7DRlrYFI0um0NkyjGN?=
 =?iso-8859-1?Q?CrLLm/FJCyKO+xcwSbvmCYWWDyZXOPkCmEV2MIII5wLJGKt3exRJKcArvA?=
 =?iso-8859-1?Q?pT9ZsxSqIFwyl7LaJkC3JcWe5PdUdlVMeQrhBfsY4/Ic5LQWz9c7vqQiHa?=
 =?iso-8859-1?Q?61qWKoFpqWYjrIws3JiL5AXfwQMGMfSly84I/Q5e/2mwiRLQALvW2gf/UA?=
 =?iso-8859-1?Q?G7a9xU9TrP7tBngnQTXTSbpOB6ZREc69+ehgaqpMPnaKSJZ3VPVCkdCB+b?=
 =?iso-8859-1?Q?13KJEXWxq9pDIbYURpKrhM8xzd+6Lj1pBnH3A78EtUAAFTplphcjOXNnl5?=
 =?iso-8859-1?Q?1SF4UaL+c6p2u/Ypw4Zil+HtA07JnNC8iOarXqq+E4hViH4Ye+fQsXVcUP?=
 =?iso-8859-1?Q?plwLqly6g2Od56rE7YP/y5ZrAEnxa8a7rLiMFLg+z5yXSr+9RPTesIW/hF?=
 =?iso-8859-1?Q?+3WGiO2u396ZARMrmGNpkzZDLl8GSz3HvuB3FQxanaFhCLF8XN53qQftrI?=
 =?iso-8859-1?Q?VAwf4HWukTFtxy/weOURUhm6wsfJcaautJfLTiGwmAKX2I1apqGM7eDFh8?=
 =?iso-8859-1?Q?3nkdNbHrB4xhKMt/Eon7oAkjhcu8yjMsRS/71PdadOiQogtVSgMRGIwvDp?=
 =?iso-8859-1?Q?rDaEt6ZpbRSxQnZ+WSRXwxy7MikCGBdo63jA4J/b3P8DafBK3pRcTrF/Le?=
 =?iso-8859-1?Q?t6KniTHaq08hoXGmJFqw5PVAFurgjti7X9VmXQ8/NdnFpXAP7MbsyeqtF/?=
 =?iso-8859-1?Q?zZkR4cNN5H3R28PBbz8GlksnwhRRBP/bDBIDbpTejqrrouDWQO7kzhMGE8?=
 =?iso-8859-1?Q?OzFX5FswDhOmaxujC3/8hr3MPR5nlWBYcBbIB6KjMZtbWE4UOk8Hdb9hH8?=
 =?iso-8859-1?Q?LMyFNslRD1jjPz1ZZJkJeljqKDqAYdokOiOCdZbBrtf6zxUcHJJqYsjjh+?=
 =?iso-8859-1?Q?j0xLgEstplLjDqK6zR0tw6eH6PqtvNyJhmgKeuELy1i7XXG/fwqtSVebMa?=
 =?iso-8859-1?Q?WO0WLmX2PwQKUNNzbp+a6FRfNw0q1BWZ9G6vAhilfhh8jFpQNOl6qyPupi?=
 =?iso-8859-1?Q?v+95TnjVh1oh8/o1Eg7ihSsR7IoVQgt4CKy4inS87Hi7EcCdibu/8aCgPG?=
 =?iso-8859-1?Q?lNE1zsPUr5+8DlT/kcwjk84MlMmabN/KsQZYXSKObAGc1U+un5wspW/VhQ?=
 =?iso-8859-1?Q?Lp6OZO3fJhm1ThnchmpIWFx1nQktCEcZ0fw0qjr6ApqwKYYWrw8+Sp1Mjb?=
 =?iso-8859-1?Q?gCWMl7HWoAW/rRTs6kiib7xt6ctVpRiRLFBe01N54iSf4SzJ5oGw1gfw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b121ec2-2548-4dd2-3280-08dd3de1b2fa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 08:16:13.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSyGUKswZXJeHq4wBRhyy1qxxDjWWRUR5aMEOxyq9eki8DzlRWms9IJrSDUMXyGRttRlDBapZpTLIELncDgayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5312
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 11.7% regression of will-it-scale.per_process_ops on:


commit: 89359897983825dbfc08578e7ee807aaf24d9911 ("do_pollfd(): convert to CLASS(fd)")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test faield on linus/master      b46c89c08f4146e7987fc355941a93b12e2c03ef]
[test failed on linux-next/master 5ffa57f6eecefababb8cbe327222ef171943b183]

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: poll2
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501261509.b6b4260d-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250126/202501261509.b6b4260d-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/poll2/will-it-scale

commit: 
  d000e073ca ("convert do_select()")
  8935989798 ("do_pollfd(): convert to CLASS(fd)")

d000e073ca2a08ab 89359897983825dbfc08578e7ee 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     21281 ±147%    +197.5%      63313 ± 84%  numa-meminfo.node0.Shmem
      5318 ±147%    +197.5%      15825 ± 84%  numa-vmstat.node0.nr_shmem
  27370126           -11.7%   24170828        will-it-scale.104.processes
    263173           -11.7%     232411        will-it-scale.per_process_ops
  27370126           -11.7%   24170828        will-it-scale.workload
      0.12 ± 16%     -42.1%       0.07 ± 42%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.33 ± 28%    +154.2%      11.02 ± 61%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    268.62 ± 53%     -61.2%     104.10 ±114%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1053 ±  6%     -17.1%     873.33 ± 15%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1687 ± 10%     +11.7%       1884 ±  6%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      3519 ±  4%     +11.2%       3913 ±  5%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      8.67 ± 28%    +154.2%      22.04 ± 61%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    268.45 ± 53%     -61.4%     103.72 ±115%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.33 ± 28%    +154.2%      11.02 ± 61%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.01 ±  2%     +10.0%       0.01        perf-stat.i.MPKI
 5.157e+10           -11.7%  4.554e+10        perf-stat.i.branch-instructions
 1.573e+08           -11.8%  1.387e+08        perf-stat.i.branch-misses
      0.97           +13.1%       1.09        perf-stat.i.cpi
   2.9e+11           -11.7%  2.561e+11        perf-stat.i.instructions
      1.04           -11.7%       0.91        perf-stat.i.ipc
      0.00 ±  2%     +17.9%       0.00        perf-stat.overall.MPKI
      0.96           +13.2%       1.09        perf-stat.overall.cpi
      1.04           -11.7%       0.92        perf-stat.overall.ipc
  5.14e+10           -11.7%  4.538e+10        perf-stat.ps.branch-instructions
 1.567e+08           -11.8%  1.382e+08        perf-stat.ps.branch-misses
 2.891e+11           -11.7%  2.552e+11        perf-stat.ps.instructions
 8.743e+13           -11.7%  7.724e+13        perf-stat.total.instructions
      7.61            -0.6        7.03        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__poll
      6.16            -0.5        5.66        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__poll
      5.11 ±  2%      -0.5        4.62 ±  2%  perf-profile.calltrace.cycles-pp.testcase
      2.92 ±  2%      -0.4        2.55 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.91            -0.3        2.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__poll
      1.92 ±  5%      -0.3        1.67 ±  4%  perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64
      2.12            -0.2        1.91        perf-profile.calltrace.cycles-pp.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.32            -0.2        1.17        perf-profile.calltrace.cycles-pp.__kmalloc_noprof.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.84            -0.1        1.72        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__poll
      0.98            -0.1        0.88 ±  2%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.97            -0.1        0.88        perf-profile.calltrace.cycles-pp.kfree.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72            -0.1        0.66        perf-profile.calltrace.cycles-pp.__virt_addr_valid.check_heap_object.__check_object_size.do_sys_poll.__x64_sys_poll
      0.62            -0.1        0.57        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     94.36            +0.5       94.89        perf-profile.calltrace.cycles-pp.__poll
     75.76            +2.0       77.76        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
     71.45            +2.4       73.83        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     69.72            +2.5       72.24        perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     69.19            +2.6       71.77        perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     54.05            +4.1       58.18        perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.56            +4.5       43.08        perf-profile.calltrace.cycles-pp.fdget.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      7.68            -0.6        7.10        perf-profile.children.cycles-pp.syscall_return_via_sysret
      6.61            -0.6        6.06        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      5.12 ±  2%      -0.5        4.64 ±  2%  perf-profile.children.cycles-pp.testcase
      3.15 ±  2%      -0.4        2.74 ±  2%  perf-profile.children.cycles-pp._copy_from_user
      3.70            -0.4        3.33        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.94 ±  4%      -0.3        1.69 ±  4%  perf-profile.children.cycles-pp.rep_movs_alternative
      2.26            -0.2        2.04        perf-profile.children.cycles-pp.__check_object_size
      1.35            -0.2        1.19        perf-profile.children.cycles-pp.__kmalloc_noprof
      1.04            -0.1        0.94        perf-profile.children.cycles-pp.check_heap_object
      0.97            -0.1        0.88        perf-profile.children.cycles-pp.kfree
      1.07            -0.1        1.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.74            -0.1        0.66        perf-profile.children.cycles-pp.__virt_addr_valid
      0.57            -0.1        0.50        perf-profile.children.cycles-pp.__check_heap_object
      0.63            -0.0        0.58        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.18 ±  3%      -0.0        0.16        perf-profile.children.cycles-pp.__cond_resched
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.is_vmalloc_addr
      0.13            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.x64_sys_call
      0.34            -0.0        0.33        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.12 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.rcu_all_qs
     94.98            +0.5       95.45        perf-profile.children.cycles-pp.__poll
     75.89            +2.0       77.89        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     71.52            +2.4       73.89        perf-profile.children.cycles-pp.do_syscall_64
     69.78            +2.5       72.29        perf-profile.children.cycles-pp.__x64_sys_poll
     69.28            +2.6       71.85        perf-profile.children.cycles-pp.do_sys_poll
     54.18            +4.1       58.28        perf-profile.children.cycles-pp.do_poll
     38.44            +4.6       43.00        perf-profile.children.cycles-pp.fdget
      7.24            -0.6        6.60        perf-profile.self.cycles-pp.do_sys_poll
      7.68            -0.6        7.09        perf-profile.self.cycles-pp.syscall_return_via_sysret
     16.95            -0.6       16.39        perf-profile.self.cycles-pp.do_poll
      6.55            -0.5        6.00        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.93 ±  2%      -0.5        4.46 ±  2%  perf-profile.self.cycles-pp.testcase
      4.46            -0.4        4.06        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.25            -0.3        2.92        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.78 ±  5%      -0.2        1.54 ±  4%  perf-profile.self.cycles-pp.rep_movs_alternative
      1.34            -0.2        1.18        perf-profile.self.cycles-pp._copy_from_user
      1.16            -0.1        1.02 ±  2%  perf-profile.self.cycles-pp.__kmalloc_noprof
      0.96            -0.1        0.87        perf-profile.self.cycles-pp.kfree
      0.68            -0.1        0.61 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.56            -0.1        0.50        perf-profile.self.cycles-pp.__check_heap_object
      0.43            -0.0        0.39        perf-profile.self.cycles-pp.__x64_sys_poll
      0.49            -0.0        0.45        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.29 ±  2%      -0.0        0.26 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.19            -0.0        0.17 ±  3%  perf-profile.self.cycles-pp.check_stack_object
      0.26            -0.0        0.25 ±  3%  perf-profile.self.cycles-pp.check_heap_object
      0.12            -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.x64_sys_call
     36.98            +4.6       41.62        perf-profile.self.cycles-pp.fdget




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


