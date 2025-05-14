Return-Path: <linux-fsdevel+bounces-48936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D732AB64A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 09:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF8C4A372D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 07:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DBC210F53;
	Wed, 14 May 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWt6Py7k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC121421C
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208355; cv=fail; b=RgDay4OKrFfqgst5ElNF8LJYLFTC9OD2o4P7Bbno/mUq6UOQWYlZFzrObScWNgl8gCCZfV8bXT4CHSnr9U1Lx4PVZDm+C7GuuL5ZJlA/k+ZWOrP1/h7sqy1/G4GZhkniRwY3QdYQgPKLeCG7ifTPqwUTOB+yQ81CvlkCIhoZ3gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208355; c=relaxed/simple;
	bh=U/4gFpYzlJ0Fl9/JIN9+v5JBLx8PpeON6yyOPjATZv0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JbMWxittZGDvlTmLf2fQ3bXnbgOOmXrQGFXXw1AiOgEsRLmb/8ilslKToA5OfJf8ttioPMO2TWebp0LN76nAzCGj4Pkr0fQL2V4+jwPhFDJaq8fMAVVHgMACOkivbJRMK1Oxjt4O+7+ohDryEiJzbpQR384XfBsT1v9PSQv3PQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWt6Py7k; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747208353; x=1778744353;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U/4gFpYzlJ0Fl9/JIN9+v5JBLx8PpeON6yyOPjATZv0=;
  b=XWt6Py7kM4kuoIqYMGpIa6Fb7CQ36/A3435OYOzkg3Y23v3Fvf1uWksA
   TJxqpQnc5T7fe0F0bhDrR6xaQySNg2xBKqbxEpVBor9Ickn0G5E42A8in
   hYVWqvcekz6ZuuADsaEBErLDeXFJbQbUnZG6lMu4R6gCxFd72xddFB4MR
   Y0lmZGKCXlbkIBf864jcppMPi6lp0xU4/QUWULDPfUZTJ5pi4Ce9IdiQd
   JEjXaJzroZLgJ+B5hEU0eqinM4Rce7TVq+7VThe9UsETwuADrXcesVCbO
   +F1lQkYTJFW36+cT28NfOpdj1zeisR8BzQBbQbRjdxhW9knMGDNPDLDtj
   w==;
X-CSE-ConnectionGUID: kgdP77a/Tv+B/d+Jz8PKkg==
X-CSE-MsgGUID: tvWx3hmeS1iTqZzlJUtMFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49021629"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="49021629"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 00:39:13 -0700
X-CSE-ConnectionGUID: kZ5cTSKbR1OZJ+N7HDHeRg==
X-CSE-MsgGUID: KSsvAW87SAeEUNSnQ3cbfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="143074745"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 00:39:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 00:39:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 00:39:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 00:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9VQUDhsOsLeODJ/ggVdF0lWqvs0cTY6uDDCpGFAzwk0FN2puIpaxUkca9/1o1U1gDzJsDUR4xBWLOnu6QFIqrgDh/Z1O/PqucSbkLXi9h7lhh7TzcMgdHc7zKBLwq87mQMRUJ32DMgnSx+CQIjE8w4Bd2/znUGs+zKc8iGMdBEIecmi8Y2kcCwWEnaT13Lyqie11yEzuEyi+ZRghqOfBUCnlbd5znzo2JWGusMZdLzROTHjemnqkNFYeMvdnW4JjKpEueqaIu6CEg4mvzjRers45E/SKRVKDvcbSLz+LJcPQIyC4QU30LlmmeDae3lS1HVKLo/4qoXbLewsNPoLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhnn3HhGl5xJ+UAY6fVUtD1/M5bfkmw1eXInMLpAJJY=;
 b=oj9IZTEdF8DPvC5BArk8qehW6iZJdiHv+oANwRvI6uf415Zm3B2ynw8ahW0/wVDxeiYS28yU/oIMruvz+1gOhDmXK//rJ/Dk5U5eOgH9mq60PVUzpC07LrnjCEklvPhk8iMmNLjuSqep12D9Bg878n/GOoENqwiZy9GoMkmxu0DgcXap1vJLWl8BnJbMR3JWUrfGgFT1HDAFjt+0iyESF4cm0vV26DVGAgnLzABNU1u5qCOMv0cRrzcqV442sryYLRNz9b0qb1SlqUP3Lt/egoY7/5sz3hvdNYbpmD/TyYhVTfTmkzG0RgbYVgpbDgGBiVwboD5LwSESRjMthHhucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 07:39:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:39:09 +0000
Date: Wed, 14 May 2025 15:38:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Jan Kara
	<jack@suse.cz>, Jann Horn <jannh@google.com>, Liam Howlett
	<liam.howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, Michal Hocko
	<mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  54fc2b6358:
 WARNING:at_include/linux/fs.h:#file_has_valid_mmap_hooks
Message-ID: <202505141434.96ce5e5d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d1646c-1a89-4088-5d7e-08dd92ba6993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Btx77trB7XDIMN46i5Qnb9HOFEAgsrD7lGwxRY3OBYD3KlXhu0QpB2eAp0jC?=
 =?us-ascii?Q?ayGqR9g1jBvs4Mz/QbzdugHB85EqJPGJsqm9UzczxIth1ltXp4h8kCPlLfbM?=
 =?us-ascii?Q?sf+J98NGFWNh4qCm8hbTieIOgIp0VHi1iscRcAG2ETbFcaP6/uBqEOXdRSuK?=
 =?us-ascii?Q?VN/zoizIjYm4ohL+b+h/dFXolBy0hsG1qTJolojvm2d1OMezjDyrBly7hI75?=
 =?us-ascii?Q?zrYQqCngF/JQLR5FAKqnceyFckYAfIh4zwzj8dzjG2JCbve85TMJKsDleBYc?=
 =?us-ascii?Q?RsXZRrADPkG7szXspLbPK0ESJa2PHuj4eq08eJYR7pZu4GfwKXUsr9ZDmxVK?=
 =?us-ascii?Q?v57gocLXjGKaA5nJ+paPCcITk3xgwNScC2RC5SZBDgLsG0lEhOKrv0Lm7EJC?=
 =?us-ascii?Q?9Nq49foLSBgKgmXc5I7g+iJvXGNYj7q6YKsZAGDB/21dfIf+fdxB/C/qbzfI?=
 =?us-ascii?Q?wFxLbxVjnOJGOVG/LiT/RJ7CaoqV1zBFwHFQYnELyfVq5/p9h/v+KjyC7T9k?=
 =?us-ascii?Q?digo6pWxNVEHrOUuRAiAV4g6BQTmAWAf5X3Wj2UIOsfWuRHDP1C4gHOYXYEc?=
 =?us-ascii?Q?hZ7asyYzJhV2Hb01qq17uzhNJgPyqf0UIiUbbhZ8Q3kjI8d54fFAVIQ1udNw?=
 =?us-ascii?Q?4k72vpLKy+H//xk0gcjzn4W2y9TE9ScpAyM0aSdnlr9+mUzfehGiaFP4m8ea?=
 =?us-ascii?Q?EOirqLgijAPgji+/PW6d0hLtMxG4ZP2WVKpL3ONS9UfSsmQcIMc59a3LDyr/?=
 =?us-ascii?Q?ESVNq5nDEPi5n7eEv8ZSOFRjtP6KtFllfCLoMMUVYkY6Faek/cvz9WsUgkzO?=
 =?us-ascii?Q?0QXnbtNlRAzKs9IgjA/M+nA+r+dWMWnsVOPd6lCMCwN8YEr8QkNX7cIfsRtW?=
 =?us-ascii?Q?X7WCDdHGYS4K1gyZl3CKTB+SQEIOjwHVwB2OegFq6eCW0uLXq/wCmBLwTNaM?=
 =?us-ascii?Q?HfDJwkKukfEXKXg/QF/H0I3u7YfM/g3mskvs+vwlnPsxzaqAbhQ0qOodKhGc?=
 =?us-ascii?Q?8vLxgUG/NPJrExK+MuOrLPtPpc0ZSutKG7afpvVfEx8+CzQp49Okb+Beb4UG?=
 =?us-ascii?Q?J4a69INWOsO285tIW5tIDUqhiWmVMVOJNejZcPwZyJw6QBV5BIJpl8EN5WaX?=
 =?us-ascii?Q?eO+6dAoErtc+iuGJ2DDgZSK05+GI83Uzbk9NL0npv8fcwqsXA5bmMKU9t5WW?=
 =?us-ascii?Q?fl5imdSM/xPH5Bb1qPARhgVquB+dEYjlZgGpUPPch3ydv4fb9t/UZmC1igoQ?=
 =?us-ascii?Q?AVqMSHe1nQIISDDRgExFuBK1vKehyYfz/8k1a6I/xgBppxA7VYyAbBP+dllZ?=
 =?us-ascii?Q?btfleuWbxK31t7G1svnNJ1zstT6Pw745hExDNT4v0gX2Eq4j6SiEY7DZgCOB?=
 =?us-ascii?Q?wgCbwihXPndJbvAGIcZ6f8vVxRe+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0cT8rwRWgB6IW2ApRLhL7kqJmCtVvPdzsoYdbOGNoqbANy5+833bUb3jY0I?=
 =?us-ascii?Q?Xvsog+Gcoth+sooYXGrSJUikdAYz6rAiOn+DceEBzSsS+w6VjMD8QUvrBTHF?=
 =?us-ascii?Q?SzuVDilDFdtw6BsWPcOZ5AcYIHmF2I2BuEsAqPQqi0NBdb1ZXzojRNgY62/c?=
 =?us-ascii?Q?tpAoB8xNxDezWifc6CwzKHspzyh2dHaqWK8cD7qxt1ymKT8PgTcI+Fc/8j9K?=
 =?us-ascii?Q?nPvrZlEUKNfBOVrC4zBAOu2xe/csCm3lOQdHGMGHqavoIaO/HYNBH1D7hkI1?=
 =?us-ascii?Q?CBfyJ5nr1Qdjvgv6MCR4rHB2mJcGOF/RX5v/TfSETpl+us342KBMLhVHHo3o?=
 =?us-ascii?Q?LMrEiFsum3ihRrj3OOC7/qoa4FQ1vrzXlojWYu+aQku1LdmDQ0mICL+VvwwF?=
 =?us-ascii?Q?SGOLIFHogxKw8Q0fGAdIfK/TzWiwAqKtB7CcbYgp+e0E7YQdWGFuXuhYdlM7?=
 =?us-ascii?Q?nHPIeP0fQj1EV4UrU0vqiUs9LuTf4VuDqGP1ASE8fD+SV35bjZE2huUg6Iyj?=
 =?us-ascii?Q?bW++gbsxeRItXI9Y7hx9avjuMDkbqy7Up7fre5VPksyz2vshWyS5KUZ2oCA/?=
 =?us-ascii?Q?2131MGevYReO4arRjJoGzgxJDXKR2Bv9dVTGuFTOD01hayg6B7mJD7NgjXxI?=
 =?us-ascii?Q?0Hy3cfX3pQmiWOie0UQLz5M77WClx5XZsO7aEZLLrib1TUrSOsZcv0lOCskb?=
 =?us-ascii?Q?dYyDq3LmpGZArvR8P2Lr+Hs9FBPSWrEX238cRGI2wilMjJM2K2LBcE1Igv+V?=
 =?us-ascii?Q?HUKT22dOS94KsNLlmXxLePgS/8/Q089qMuUyYMZkoD7BGe/q1dBIZsHuMzE6?=
 =?us-ascii?Q?hONRS+ZAY8xd1YpOsx2SbE1foFSH8hjrz2Onbt78owFm3JUAsXtmFvLI72dm?=
 =?us-ascii?Q?dFJSHEv9WFjiWeTOhar6pzOLn7MlPusBsio9enSroK7txfaWaqVZk6Lep8Y9?=
 =?us-ascii?Q?+MOosMpYkZjFqivj4e3lvg5mycuTwou648ppU6+QAZ+sriCrGRr5HTkO1odw?=
 =?us-ascii?Q?5rmyHLYirULL1sYe2NMk0vJKxycX4i+LnbzAcnbGXfveZCk7PGvSpPj1gp5X?=
 =?us-ascii?Q?NJ27bzysHvcl/9BQF4EoFMTy3p6LcybSQ9zKWFk1jFadUQtP9dZGQ78dkBG7?=
 =?us-ascii?Q?GduQTRv+Cl8Zuoq1PMw2rag6e9qXFqv69yob22AxHah98/r3m7WgXw34m1br?=
 =?us-ascii?Q?ZfCNy0xucqiYHG68ykRzJOKiDgNV6bEkYJCNLO5jhPNpcqksm8UDN6gS+TvE?=
 =?us-ascii?Q?LWV1BBHuhDpuvBJignWHl/z4JjPXZyhiDnjc0Enj2QiVB75M2Rq/eDrAHBXi?=
 =?us-ascii?Q?EvxHETB3k/05o63SotWbv72WgiTUnU2Yw/SPhwfFs+JtLdDu/IteXSQdqnqM?=
 =?us-ascii?Q?EkyHae3NXOAmJfF70dDjgk0z7aAjWZDQuz1K2KY4XOY4i6Wu82GXs8vyWoPq?=
 =?us-ascii?Q?QOIZyaoPR+WSnMIf62CGYleEIwU+jZ5Nko5KqCwdMKis0r4mFg48Lwf9t0dF?=
 =?us-ascii?Q?gEEHFoViOEAa5VRtZWP0BCT1OHSc8uC3Kz4Brx910ZgF5HUCu+H02F0zr0Xj?=
 =?us-ascii?Q?xAy+P3ZZJKXj0vDlV5ywpf+XV41WP9rKlMZk/7m59KKMtD3PZ599T+x3kaBA?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d1646c-1a89-4088-5d7e-08dd92ba6993
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:39:09.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dZ4VizjCZKR4LDC3CQjB6AqJSC7LxJxUFtrv/CLIClPT0c8d8OUtCb+gK4ia8C7Y1m+tNwA/Ni4M/WVE2kC4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_include/linux/fs.h:#file_has_valid_mmap_hooks" on:

commit: 54fc2b63585940cce17810a9ef5d273087b0939e ("mm: introduce new .mmap_prepare() file callback")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master edef457004774e598fc4c1b7d1d4f0bcd9d0bb30]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



config: i386-randconfig-141-20250512
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------+------------+------------+
|                                                          | 7661dba205 | 54fc2b6358 |
+----------------------------------------------------------+------------+------------+
| WARNING:at_include/linux/fs.h:#file_has_valid_mmap_hooks | 0          | 12         |
| EIP:file_has_valid_mmap_hooks                            | 0          | 12         |
+----------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505141434.96ce5e5d-lkp@intel.com


[   81.501132][ T3731] ------------[ cut here ]------------
[ 81.502015][ T3731] WARNING: CPU: 0 PID: 3731 at include/linux/fs.h:2251 file_has_valid_mmap_hooks (kbuild/obj/consumer/i386-randconfig-141-20250512/include/linux/fs.h:2251 (discriminator 14)) 
[   81.503344][ T3731] Modules linked in:
[   81.503951][ T3731] CPU: 0 UID: 65534 PID: 3731 Comm: trinity-c1 Not tainted 6.15.0-rc5-00294-g54fc2b635859 #1 PREEMPT(lazy)
[ 81.505454][ T3731] EIP: file_has_valid_mmap_hooks (kbuild/obj/consumer/i386-randconfig-141-20250512/include/linux/fs.h:2251 (discriminator 14)) 
[ 81.506235][ T3731] Code: 8b 48 30 8b 90 84 00 00 00 85 c9 0f 95 c0 85 d2 0f 95 c4 20 c4 80 fc 01 74 0c b0 01 09 d1 74 0a 5d 31 c9 31 d2 c3 0f 0b eb 02 <0f> 0b 31 c0 eb f0 90 90 90 90 90 90 90 90 90 90 3e 8d 74 26 00 55
All code
========
   0:	8b 48 30             	mov    0x30(%rax),%ecx
   3:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
   9:	85 c9                	test   %ecx,%ecx
   b:	0f 95 c0             	setne  %al
   e:	85 d2                	test   %edx,%edx
  10:	0f 95 c4             	setne  %ah
  13:	20 c4                	and    %al,%ah
  15:	80 fc 01             	cmp    $0x1,%ah
  18:	74 0c                	je     0x26
  1a:	b0 01                	mov    $0x1,%al
  1c:	09 d1                	or     %edx,%ecx
  1e:	74 0a                	je     0x2a
  20:	5d                   	pop    %rbp
  21:	31 c9                	xor    %ecx,%ecx
  23:	31 d2                	xor    %edx,%edx
  25:	c3                   	ret
  26:	0f 0b                	ud2
  28:	eb 02                	jmp    0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	31 c0                	xor    %eax,%eax
  2e:	eb f0                	jmp    0x20
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  3f:	55                   	push   %rbp

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	31 c0                	xor    %eax,%eax
   4:	eb f0                	jmp    0xfffffffffffffff6
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  15:	55                   	push   %rbp
[   81.508815][ T3731] EAX: d1880001 EBX: fffffff3 ECX: 00000000 EDX: 00000000
[   81.509606][ T3731] ESI: ebd21c00 EDI: 00000001 EBP: ee6fbebc ESP: ee6fbebc
[   81.510420][ T3731] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010246
[   81.511506][ T3731] CR0: 80050033 CR2: 042df000 CR3: 2e7c0000 CR4: 00040690
[   81.512398][ T3731] Call Trace:
[ 81.512840][ T3731] do_mmap (kbuild/obj/consumer/i386-randconfig-141-20250512/mm/mmap.c:?) 
[ 81.513390][ T3731] vm_mmap_pgoff (kbuild/obj/consumer/i386-randconfig-141-20250512/mm/util.c:579) 
[ 81.513966][ T3731] __ia32_sys_mmap_pgoff (kbuild/obj/consumer/i386-randconfig-141-20250512/mm/mmap.c:607 (discriminator 256)) 
[ 81.514625][ T3731] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-141-20250512/./arch/x86/include/generated/asm/syscalls_32.h:318 (discriminator 201523200)) 
[ 81.515267][ T3731] __do_fast_syscall_32 (kbuild/obj/consumer/i386-randconfig-141-20250512/arch/x86/entry/syscall_32.c:?) 
[ 81.515980][ T3731] do_fast_syscall_32 (kbuild/obj/consumer/i386-randconfig-141-20250512/arch/x86/entry/syscall_32.c:331) 
[ 81.516686][ T3731] do_SYSENTER_32 (kbuild/obj/consumer/i386-randconfig-141-20250512/arch/x86/entry/syscall_32.c:369) 
[ 81.517325][ T3731] entry_SYSENTER_32 (kbuild/obj/consumer/i386-randconfig-141-20250512/arch/x86/entry/entry_32.S:836) 
[   81.517972][ T3731] EIP: 0xb7f71539
[ 81.518452][ T3731] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 58 b8 77 00 00 00 cd 80 90 90 90
All code
========
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:*	55                   	push   %rbp		<-- trapping instruction
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250514/202505141434.96ce5e5d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


