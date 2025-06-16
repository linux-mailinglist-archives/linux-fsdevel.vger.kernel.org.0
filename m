Return-Path: <linux-fsdevel+bounces-51718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CAEADAAE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7D63ADB54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A29226D4D0;
	Mon, 16 Jun 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaByXiql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEEE1FFC6D;
	Mon, 16 Jun 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750063079; cv=fail; b=NQp6Hl2fdWLbAJ+ovnAq5ytncNPPazJMgffdaooBDXAZMggEI7XqiIaIJY4j3QKkFN4/4toDTngHOfAdQKYXdW22vNqM1mB+hfCXsP3yRVqICqzrua9J63mAbkWYpSmUEcAPEX0W5FstEAfCNAT8FfcWvZyNWcT4R6ZEU5oRphc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750063079; c=relaxed/simple;
	bh=WNGrhXlq5sEtEunRAwdDxcBxaN0H+ElRYmCXYMvajuU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YrmCKItGoZ4/3BScEBqCur8+uWoX92t+GCurxJgj8hFPOzCLKLgERKw+AVa1FCAt7txr8FuBYDH2H7Aa6AjMDwnKIKDzCUYIakTLxvKNUDr3TSkwm0rTOd3rkDDvyOZk3PVYNU86oi3jpa8hDShHkbd55b11HO6wWjEuBD1BF2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaByXiql; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750063079; x=1781599079;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=WNGrhXlq5sEtEunRAwdDxcBxaN0H+ElRYmCXYMvajuU=;
  b=FaByXiqlMAH+UOnPu0V7cGnbXZOKGoFD2yzPOKrOdpv7Xs7UxiQFkQe9
   kMCbfVMEVmtXDLbhGY0eWigK6mX+lnXsyy9CTP6oGF4YBHSNL6lVOjyqn
   TDCkB1mlgQDuZsaJoUZtJRcSp6VrAfwnH+wKsltXXWidhNXSyeHHHLDkf
   ww4zi9C9Jx7i8cER6c4F1oys2wPj5lFe1IQEQrXF8S5s4wo1rqNYQi78V
   BzqSrepo1adtg60eH+Jx9arbaixuMJiFauI6opRoqSUsONN1XbY2A8NQh
   2IQM+haPcn2aJdr+C3rLlcqQJr+CSOirKDY6u9U11GChZvYcUwHJPR+Gz
   g==;
X-CSE-ConnectionGUID: cvLAGYvNR+eywvztkP2aHQ==
X-CSE-MsgGUID: +YSuNv5aQHGknRRGlCsgWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="74729360"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="74729360"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:37:58 -0700
X-CSE-ConnectionGUID: 0nG0rPVfQKKZ0JHvGUqoNQ==
X-CSE-MsgGUID: /GdLKrT3SiaAnC1ahu5uVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="153559597"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:37:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:37:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 01:37:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkXDi8vsbJ79Pec+PigXV3GggaqABdrNpJGGNgLGPIa4ODhF7L+nlqo2ccNZ9NSQ3V3Q6joZaD79H7YX4R4MNbH1rI8quoQ6M5qXdM/G+VcAUVdxsaHSzcjp15HraAkYxsjyCF1640NUekfInBIakhd1IqagnRguf4yYvKD47kh3bLCfabrA69CFeM7TzyddKF/4cLdRI2elyn3t1Uv11+/9yZ5RoJVG+WtyBeLBtR6sJvpJN5BsDxz2HSH2lnJkaBLf8V4WD67qvLkK8hA5yqwXDqdCyJknuzAJPiIcDr5dg4scZbf/QPFDSMgmfmRMoxjXEP9vKEn+ECRiF3woBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35eJZoGsTq11G7g6/MlQYgB3fXVquINoghkcrG2uJ+Y=;
 b=VHfLdQqiNOrfkSMqMXNGYPkViar8BDY/r0bM3rG068ebuwY5N+JQqX9VVRCKWTyUUI+hDZEGzC2Ed1xmaI9mEa73hWc7VfZFeXtJRxX+TwfNSbDVG3HsJ5b5Vhbu4GICZcBH8/amG6lMDIk04V0MNMwTTjQe8eaU/g6Gh6q4kKKF/icYpBqCGNniqg/oVYfRUJC/k4DhfFap9k0LBO7RljM7dpiGvBbuyUlBkkqvBBWm5T9i8BnbXcz16QkYRdDc5tNY9elH8c7//8x9X3mo/wY2/srVeSA/JfsjWDP79Ot4Jux5mXTiPZ6Z4KNualIU81PEKVKHStIy4KzAgSz1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 08:37:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Mon, 16 Jun 2025
 08:37:51 +0000
Date: Mon, 16 Jun 2025 16:37:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neil@brown.name>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>, Al Viro
	<viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, Joel Granados
	<joel.granados@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] proc_sysctl: Fix up ->is_seen() handling
Message-ID: <202506161619.6738c86c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <174977507817.608730.3467596162021780258@noble.neil.brown.name>
X-ClientProxiedBy: KL1PR0401CA0027.apcprd04.prod.outlook.com
 (2603:1096:820:e::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a96fc50-7461-46bc-1c69-08ddacb1145d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GTGKKIkAOxsgY7UgtWGggtInB6qtWVXhb5fzzvtMZPNkzinnY3QSPlX8aaC+?=
 =?us-ascii?Q?wEeeB1GgNo83mDd3seyas0XEDgsbK3O9mmHNlbFhwkqRQ51D1iJiwcvgrAt7?=
 =?us-ascii?Q?OuLrgypY4cN1iCeClnY0L1BBekpR06zDmR9KoGGqtyc6j5fxJyGLrBYfbMYu?=
 =?us-ascii?Q?oDk1K8MpWh4PTiVOaw2PpjsmP6979RzSgJsKH0Rt3E5tP8YoKTlM6weBM06n?=
 =?us-ascii?Q?7UNGuSreyEVRlWAPYxl/07rGCN8rj0HrD9i2ZIJsHhLG44J+ivRQNlR4wDYd?=
 =?us-ascii?Q?oatQQnmS5M9elM/Zgdhjg4fgBwTTx5HqpFfcJEFxOHUjW7q1mcKLWqj7xzXj?=
 =?us-ascii?Q?wGYfZdJEM6M3eE0VzLzoTtjxLAIqKInzGKB7qLzAtmemhMkEqHQtex5+DjD5?=
 =?us-ascii?Q?yzfJuaVvrKhCJOpz6U7i0DLgbHF+NMTZto47Y4WC1A0Rny+G4d4RgOgqNs6c?=
 =?us-ascii?Q?H2sj8C7SGnBAbjdXjCu2QOn2Fcm+EWYpSCxJaNxKfXEDVu6Q4KmKmY2GSWo6?=
 =?us-ascii?Q?QPAApw9hfEebqoPMYpZzYhGglzNlgWzBN/q6o1ddl0n1HVDnIkBgWr4B2x5B?=
 =?us-ascii?Q?q3nw9312OIKaQ73kRJ9OG4VEIiLqJetKt9S08go0N1/xSoHTDiJNusOMdjkB?=
 =?us-ascii?Q?vAFo0w8KRa11+3HFPzzBUk7JniCXXANR7RKWh7BkngcOSwnTadTyZJVjfytW?=
 =?us-ascii?Q?ap9EBqTjPdeUxCFYvf2gyBWXJOK3kBOXGXRzYvXfPGef2PKTqezI9++zgpB/?=
 =?us-ascii?Q?p6Ckc2GYp0jMUBg5Rl8tdxpY4dk1QgpZOcesw3khlUSWs4jyzVT32Y+sHOuw?=
 =?us-ascii?Q?75GrbVIxLM0oqfs96RSv6J8FWzC+DPwaiecSWFU3QSCVQ/Lbx/7+OwzXjTdY?=
 =?us-ascii?Q?/CNLGyZO3UippLCe0ONrItW8g2OeLMFflI/QcVxlvSw/XpLhs7h7LbEmF6x1?=
 =?us-ascii?Q?bq3FB5+Kq5mCh1du4in0CzuXWqvPV1VIHBXqba+Z35ubA3qjnlzv+948Hz9/?=
 =?us-ascii?Q?l3S1v7DMlJ52o47/zJ+AaTgiYLoA8JeoyfPRFD6M4PVD8olAaqzam5yiegh3?=
 =?us-ascii?Q?nB/aheR/BdMj3bv5XpFxYk5cK9+SQbvfa0k4RKdsEx/lOzSqHJG1JaUTbrbH?=
 =?us-ascii?Q?20XeZV+dLDjttqOThxQqHBJqxxOSxtzYqsq9I4g5ooC3Nqk2bvW85LShaKBo?=
 =?us-ascii?Q?sNW/SJ0QSqgHZsWcX0Yp6YVjQOt6Hi5kMu7C3r6gOq3jMAVcqiD4v4iB5xbI?=
 =?us-ascii?Q?z6j5uQroAEhx3PQU8A93h3BWVsjRwlvlW8a5HmMOqn/RvKXvAdtvvcvdOy0x?=
 =?us-ascii?Q?NMPVCP43bx9ozvTBZVOv90oMoWctlXVy17Kz/wyvwOoBbdobN37fDaZkifSH?=
 =?us-ascii?Q?cwuFTJJ9cBySLYkCI5eu9xeNaQi1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhpp3V3R5PWThN2Te2gaA/yK/n0ij2A+Lraz7bI2zI7rywyyl/xAT8d5EdhJ?=
 =?us-ascii?Q?OM/sX/zq3bEH/fBKhrn91ut4d5UulrsviItYjNdOgR23iV2w0ln47gniJMBN?=
 =?us-ascii?Q?MJpIZ3ObLV6pRLMPVJc/tkCiedNDCJGuwdCfP/uLomusMfisgO67LAc7HdL3?=
 =?us-ascii?Q?sjNlrlIZPpaskBQPMV7txWjVVIR/MjLorDawUrBWoMPGuxM3DZJ+tp8TaWRW?=
 =?us-ascii?Q?LTrD6K/PDUhlY77YQqV8qKgls3Mq6P2QL7WESf2qHu1/w4zpJgR9ia8hUndc?=
 =?us-ascii?Q?oJYL85NqdpWFvO24L9zSnHIo6cGx1uAc33lAvkkrp44CB15OVg5kJGjVLLKO?=
 =?us-ascii?Q?vXsxW69nkYWy+rpF4zLsbCF/ds/kcfhxyf2eNIrZrW3w5iqAA9spl5Idh9/2?=
 =?us-ascii?Q?lTi+t2mZiuiGzJUw3CXcjtHzVqkzEy7K/Q0d7L7FpItHog2w1ENZrjBmSAEd?=
 =?us-ascii?Q?QvL277/bv1xe1zavlL2IMGTCD7+ZKWDIADf8X+OyKusiizaBIl6m2kPwB2LY?=
 =?us-ascii?Q?sBVlpIeTznponvY6r+QeMMbpg7FDfpKutueETsEob3yqvZ/hKOkxZTLt7xxZ?=
 =?us-ascii?Q?OCR9Mf9HmI8gNJO/OgF1YdXcpZtQsMFhh2eqfIuuCvIw51pYb8EgVDl58DUL?=
 =?us-ascii?Q?cw0N1PcOEUpmWb/H0A6p5GHVqSNCPG8LUnc6xSTFv2XJyXxtzs4T4H/I0+DV?=
 =?us-ascii?Q?K1Y/DuKLkYnDylu0tm0n38uf7AlmAbORm7Iygq2IKhvoKOVCxzQ9zCRjSsty?=
 =?us-ascii?Q?zwhliEFfePlbhb7ZwRb96kTzqdwo3bdusBsz/p6zstRLgTC67KlGi7ROwLgw?=
 =?us-ascii?Q?asrUaOalZSKqCXaJy1ygK9d4gbD8/pyv9Pd/K4vie6RyM8Hrn4xEJa+98EFs?=
 =?us-ascii?Q?CTnNUnMoyFuJX+ZjAE1YTzHJ47uQJz0HLh272BLngzC52ygsCLItkwtPYUci?=
 =?us-ascii?Q?QVVk/YGNLFAzaS7ZJyVUjr/M+BNx1EHI84UDuhmQCYL2m4uNVp7bsp2oBT/i?=
 =?us-ascii?Q?LAWZHz+4jwhs0JFR/wI3JarweHkqnoQjfcZEwhUuAH0CUWncBd/CxxMzRPLr?=
 =?us-ascii?Q?ekyspEcvdS4jWfrTy42wSoAWC2KPUu+B+yX5cWJ/oLwVZFPMmzO+hab1cBAM?=
 =?us-ascii?Q?aIYx0FSe9j6c+XN0IoehJ50TKVA4NWuEBphSY11f+9hNEZWboiTZTHejuFgj?=
 =?us-ascii?Q?kNEHExLAnSpfxP9Nld7vNqU8EXMABI9YvK8TQ/tdjfEMjHs8QEGZNBg19MTc?=
 =?us-ascii?Q?j40Qd/CC9N6kVeHuDbF+5/nIxYxqHb7eFo2eUBZnvRzZJLtSW36uWOH5d49D?=
 =?us-ascii?Q?sifLNz1p93Yh+gjd6GqaSnMLpGGOI+fnLn3GMEIIbB2pyOJ1+ETqn9O/YMNl?=
 =?us-ascii?Q?EyLKT7PgbKkV0iYOjQtpLebebma2OWCXL6I0RNQWhXQEFFT15/nI+RpNj2i1?=
 =?us-ascii?Q?AHgnmHWTStCqMMRFQLiHZWY75N//SZddEgt0bAxcgvjCR12o2jq8qI2wtodw?=
 =?us-ascii?Q?s4k+qvEQW0AHZPmjgCfc7cxMI2QbMSvs0wfuzY8QDRTUnPyDxUmFfBfJ6ZqB?=
 =?us-ascii?Q?0TQ6uOLj/OBMY0CTKHZWEmXp39x8xNgNt/h4LWiOYkk+bhJU4rcs+Ieolt84?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a96fc50-7461-46bc-1c69-08ddacb1145d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 08:37:51.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW38OxKDOWWwA2CpMd/sRKfWsfaZDOtPz/6V5T//Zn6U7anoe/I9ahVClGOwCqnjVGXvBlys9I2h7AsbhPNHDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "segfault_at_ip_sp_error" on:

commit: 981dfb28e2d5851435754da557baadfdcbc828a8 ("[PATCH] proc_sysctl: Fix up ->is_seen() handling")
url: https://github.com/intel-lab-lkp/linux/commits/NeilBrown/proc_sysctl-Fix-up-is_seen-handling/20250613-083900
base: https://git.kernel.org/cgit/linux/kernel/git/sysctl/sysctl.git sysctl-next
patch link: https://lore.kernel.org/all/174977507817.608730.3467596162021780258@noble.neil.brown.name/
patch subject: [PATCH] proc_sysctl: Fix up ->is_seen() handling

in testcase: ltp
version: ltp-x86_64-99ebf35b3-1_20250607
with following parameters:

	test: net.tirpc_tests



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506161619.6738c86c-lkp@intel.com


kern  :info  : [  157.002007] tirpc_clnt_cont[10507]: segfault at 8 ip 000055c92e030119 sp 00007ffd50302fb0 error 4 in tirpc_clnt_control[1119,55c92e030000+1000] likely on CPU 2 (core 2, socket 0)
kern :info : [ 157.002435] Code: 1d 0f 00 00 31 db 48 89 c1 4c 8d 44 24 10 ba 01 00 00 00 0f 29 44 24 10 e8 44 ff ff ff 48 8d 54 24 0c be 06 00 00 00 48 89 c7 <48> 8b 40 08 ff 50 28 48 8d 35 e3 0e 00 00 bf 01 00 00 00 83 f8 01
All code
========
   0:	1d 0f 00 00 31       	sbb    $0x3100000f,%eax
   5:	db 48 89             	fisttpl -0x77(%rax)
   8:	c1 4c 8d 44 24       	rorl   $0x24,0x44(%rbp,%rcx,4)
   d:	10 ba 01 00 00 00    	adc    %bh,0x1(%rdx)
  13:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
  18:	e8 44 ff ff ff       	call   0xffffffffffffff61
  1d:	48 8d 54 24 0c       	lea    0xc(%rsp),%rdx
  22:	be 06 00 00 00       	mov    $0x6,%esi
  27:	48 89 c7             	mov    %rax,%rdi
  2a:*	48 8b 40 08          	mov    0x8(%rax),%rax		<-- trapping instruction
  2e:	ff 50 28             	call   *0x28(%rax)
  31:	48 8d 35 e3 0e 00 00 	lea    0xee3(%rip),%rsi        # 0xf1b
  38:	bf 01 00 00 00       	mov    $0x1,%edi
  3d:	83 f8 01             	cmp    $0x1,%eax

Code starting with the faulting instruction
===========================================
   0:	48 8b 40 08          	mov    0x8(%rax),%rax
   4:	ff 50 28             	call   *0x28(%rax)
   7:	48 8d 35 e3 0e 00 00 	lea    0xee3(%rip),%rsi        # 0xef1
   e:	bf 01 00 00 00       	mov    $0x1,%edi
  13:	83 f8 01             	cmp    $0x1,%eax
user  :warn  : [  157.168019] LTP: starting tirpc_rpc_reg (rpc_test.sh -c tirpc_rpc_reg)
user  :warn  : [  158.080633] LTP: starting tirpc_rpc_call (rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_call)
user  :warn  : [  159.209909] LTP: starting tirpc_rpc_broadcast (rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast)
user  :warn  : [  160.241552] LTP: starting tirpc_rpc_broadcast_exp (rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast_exp -e "1,2")
user  :warn  : [  161.182028] LTP: starting tirpc_clnt_create (rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_create)
user  :warn  : [  162.081857] LTP: starting tirpc_clnt_create_timed (rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_create_timed)
user  :warn  : [  163.234462] LTP: starting tirpc_svc_create (rpc_test.sh -c tirpc_svc_create)
user  :notice: [  163.507518] Gnu C                  gcc (Debian 12.2.0-14+deb12u1) 12.2.0

user  :notice: [  163.508419] Clang

user  :notice: [  163.509434] Gnu make               4.3

user  :notice: [  163.510405] util-linux             2.38.1

user  :warn  : [  164.010443] LTP: starting tirpc_toplevel_clnt_call (rpc_test.sh -s tirpc_svc_2 -c tirpc_toplevel_clnt_call)
user  :warn  : [  165.054172] LTP: starting tirpc_clnt_destroy (rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_destroy)
user  :warn  : [  166.170592] LTP: starting tirpc_svc_destroy (rpc_test.sh -c tirpc_svc_destroy)
user  :err   : [  166.988060] -------------------------------------------



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250616/202506161619.6738c86c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


