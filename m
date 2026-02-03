Return-Path: <linux-fsdevel+bounces-76118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBTFGOtPgWmLFgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 02:31:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6EBD362D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 02:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 333FF3034788
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 01:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E022417D1;
	Tue,  3 Feb 2026 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BI224GMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601FB221FBA;
	Tue,  3 Feb 2026 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082277; cv=fail; b=QGl2zQLe/E1me02BZUO9Uw0wLch9AQGq/nO2g5JlxU7eOlU6bQMgk5QXbVKReff7HaENzty/VovOZ7FUTtBAjJmrnWf4lL+foa4NEiOKU4bVDcihmybwa6eCVCje/Ay3vXeKnRyCMUdImynA4GMmCOlHcOKYfPAyUatx5gY72l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082277; c=relaxed/simple;
	bh=BN5hx8VST0a8TJb0GOM5+3ZljmXDZNU/QvsJy6KQ6V8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gpXyZqNC8VbJiGda7gZja+iTS0RT/5tKnRtqXfECf3Iumc5DsrTVuMvFF+WKbEiO11mLtcFR+KL4BMHpWta4Afpk9DKEvR2UGbsOcC4M8roCash53WdD0YfFk1fkFmxENTVPDZkA9mpSPDSz6A/cWbEquMu5IPLuQvHYJnK4de0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BI224GMd; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770082265; x=1801618265;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BN5hx8VST0a8TJb0GOM5+3ZljmXDZNU/QvsJy6KQ6V8=;
  b=BI224GMdKZtC4YZkR5SD9rc7WKm6Ax2Nofh/YUQ/ugpSgvOOkxsFF6k0
   9RlUNxiF+w6NwTcHILjX2X3e3BZDycVOaKjeKB8BjwT+HKfSiu7qATlXi
   n+Kx75Zjzj/LEra5swJrsxfI+bUHb1OwOhotigkE7ec++eyqu1JdlCWEM
   mXsKGo8OkRs68ud22d903kGU2gE86oslQUxkLLnpdETUrFyCt2Qwc2ifm
   G0mlvmottlYgwlWsgGM3VOC9nbQXsvQYtX0plrY27EnmM+aGsPvopRSjU
   DhR2bnGOiemwUdh1tuT7cEMWYPMZcyVdjePef+cv9O7r4DpP/q//ka6KJ
   Q==;
X-CSE-ConnectionGUID: qbcdYZ60QXiGkZ1szfr2sA==
X-CSE-MsgGUID: Em4Ubx8SQmig5ZWgJcSi4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88668804"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="log'?scan'208";a="88668804"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 17:31:04 -0800
X-CSE-ConnectionGUID: YLcdtg/iQR2PiclN7i1mCw==
X-CSE-MsgGUID: WI9NEbU+ReWfICIgblolsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="log'?scan'208";a="208783675"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 17:31:03 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 17:31:02 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 17:31:02 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 17:31:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsCXKJ5dghakKwAdUCrkAzRBVNp1SDCHR/ThRvq9QCdRs8Av2GQ1o+VrpZ68bpbPw4/p7yZDv5LCbxXS39HB0B147d+qStYJGv/GBQf9CvEe8Y0O++e/v8VvwQ3NfGz2xlcDPLqQh4O9fEKrbk9T99GqdQ73PgH4dH3qOzdhqnPpvCyYK440aKivNHv036LouxuBhT4YIyBcUslYILcnZ3YU7odaabMOVg9DkY1tptrA4OwbSIyZUClMsLx6Ugq3d1LJM6PcfYw4k5I+MOpqRD6D7lYIFNpUSfdK67MzG/rUnWkKc7ouTWU/DgWLXzspHKht8aiBIQxgypwJYDN/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmhsw43sRva/RBYp4BhOMuM8HInwD5UDy0bRz5BDvyA=;
 b=M0OCmBp1GUCeVBSRrd6vkIQdaIWIlBwy/FUkR7vD13Hfw2IPG/bbO+MWzWeLGIOh0/Fz8EMjR1UNF5dOGv8WwNho96qNgK7QBF9DRDCsfaVJkIM45lPEsSop7e37sUWZcCbKxsZ/UKzJd8pP0R6sCij19KhG2lFCDhOVP1fonEVrdPbyosWd32Zo1Tq7z1Kw1TBX3ISHful73rf2ECBHhde0c+MDy1mBhVnnSTZtV4dovxf1QX9qABd2okJr4oC+CzTnLdOCMzIqonE70hl2Uv/Cua8lQ92Rt1krU3ihQxS/KMBfsEhAHttnCTdF32u7g+bpeijfkRiCiZNhYpiarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:30:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:30:52 +0000
Date: Tue, 3 Feb 2026 09:30:43 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jeff Layton
	<jlayton@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [fs]  313c47f4fe:
 BUG:kernel_hang_in_test_stage
Message-ID: <aYFPw4WeItF84APy@xsang-OptiPlex-9020>
References: <202601270735.29b7c33e-lkp@intel.com>
 <20260130-badeunfall-flaggen-d4df12bcb501@brauner>
 <20260131-dahin-nahtlos-06f69134584a@brauner>
Content-Type: multipart/mixed; boundary="csx8ktZH1zvSCQRU"
Content-Disposition: inline
In-Reply-To: <20260131-dahin-nahtlos-06f69134584a@brauner>
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 449aac82-1a5e-4c16-ba5f-08de62c3ddff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|6049299003|13003099007|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tzsCj4LFanQLOLp20FZYxrcJvLmuMvPbVZyi0JOttvBM4+Eio+F4ZHaQnpQY?=
 =?us-ascii?Q?ZVdSMZQGul8mX96PA/ngdnZntAgtxsHrxZwcPBdaMcmjUKtqxJlyIFTvUY0l?=
 =?us-ascii?Q?Gh5leeIXIE6dA1rXBIxc0S63F4zKgo7kvR9JRH1yfT75CdTz15po8QKvGMk3?=
 =?us-ascii?Q?IShk2XmgaIav45tvy4Rjfe+yBJalEycDHsydXsYXSU5CJEfox3lX53jVpZW8?=
 =?us-ascii?Q?XcSOwh2Jj5VVm7ASXCRdWyLBejXNz2Rq8UimgkSbelVUMVkbCp6JSbW/qAcM?=
 =?us-ascii?Q?aXQVV+HJHHylbStKjraJ0AGhqldUsyfWC8DpzItEznkfwV0VdbZzxwEBbE0U?=
 =?us-ascii?Q?BerDhAWgoYRaLwvoV7zcf4yuj1JdQC9+PRyl234UbCzSuqbl0yEULKcyFhgT?=
 =?us-ascii?Q?LICYMeCka0926I7N5w0DCMkRumqEztybfiaxTjs2uoahG/hoqfdX3U3qGyjD?=
 =?us-ascii?Q?jqGC+xXPioauoTj4E5Ru8OuxjD+AkXCvvh9aOCOh9gRbDBUGLTG2axCPAFV3?=
 =?us-ascii?Q?wLyrqhATgOR/jxTuk09jMPK4kh9QOKjUO/PFADfzrrPixa55BRIAX1wMv9J/?=
 =?us-ascii?Q?yRrs0SxTrw9IhGsZ4UINZgefblvlOf4B+IKer0UCZmgjCasWoVqZmmG8tN9n?=
 =?us-ascii?Q?Ou00IO8xxdOGcp2UBmwXm1MWMRYCunoOjDxUNaFSZRGaqtEW0NE5QNFqudrt?=
 =?us-ascii?Q?afEk8Ax4GWs0YO7u5uj/Sh9OVHQ1sjWB7O1s0DGPIRa/r5ccJHDAO3tPOtLw?=
 =?us-ascii?Q?iNfvt469DFlFyL/XXeD+q6GyEZ/uszNNnSMpKNHkLKkxJHZodbp2hjo+E+b2?=
 =?us-ascii?Q?1Iwq87MoHuGL6HRPUfdZ7qcAJsT332AgX/O0IoawAD/jPewGuYVyz++hjCF6?=
 =?us-ascii?Q?CEkrzhLBOw6dfDoim4Hhpeez0eOWs2NgpLts/9ATXXj+o5JXqny581LGEwxE?=
 =?us-ascii?Q?otSpkVNFJyhOP/r0nZUc9mQsSQJlz8dWpQAeyrxEnLm+7M+W0E0aIJ98kEsO?=
 =?us-ascii?Q?lpgXclH+y99JESZjB/cq1sZvUWFCEc6IbDVCN7IWeb1rIozqR7jpdhZkgnwS?=
 =?us-ascii?Q?DjeAHYlgTW2zH1tytakF//ESO6U0WUT7j4Qf/p70VVFICytxAtx2X7f+voSZ?=
 =?us-ascii?Q?5enwZr9fkDNGXxzMBeC2zZ58s+vjlr+2WUrm63ne89EogaZWDMm/TEu7ipy+?=
 =?us-ascii?Q?n2e5gOKK2M15ELBgn7MUN1TnXQEulhuCmSjV7v6YgOh6Z6t2V2ElkzKDlPyY?=
 =?us-ascii?Q?N+QmIX5qfeKESejhff1AYDPgb6hFiVxO7idyWGaOSAGwhNEuuyyzH4jhv4Vl?=
 =?us-ascii?Q?81eFo+zFjIKqYgmYLyuMGElFShHsjWBnNb5SBX8XiXtMZzNudeEqz2wSjyi8?=
 =?us-ascii?Q?iESu+0aHgMprtsQ3o828cu1wsGDigsiKJoZDmEM2nBHAWNc1F9K/dvAY1Ld5?=
 =?us-ascii?Q?2/MyS6kUhcG+CY1FDnaaf3oKyqqhxxIZUzcGrlrt2p1TmhlUwgRBDl8S7R0Z?=
 =?us-ascii?Q?eUKbEOLc00OzIMiK+skgxuVFMd0I2M1IFCQ27ceE7GHjEQIAwZlhsm4Tpw9I?=
 =?us-ascii?Q?NRMwzO2ZIidwTZdzI1fzSINs1bbXw2MRjoUmiVMh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6049299003)(13003099007)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/iYZvmDFUjkg42YOx2z3zL0g4OFD+64PNk9ZTwPxBCxWAyqO5JQUC3Wb/dD?=
 =?us-ascii?Q?TzVBUQ7Zo5O5eX0+122mBVhHelHMdAjxizLFZNeWCREo+DzIQOtlPH8J71WQ?=
 =?us-ascii?Q?//qm42WT/ra0Uf+lGKsy9fsiza11FSKcNU8n86UL3GBDD+xGqQfmcsFIiQfE?=
 =?us-ascii?Q?u66FH6m3iZ5ciFWgEIQ8bKE8Cc9O4pSk4Cl9MQUk1fyO0FOKAoVn7u0CbWGx?=
 =?us-ascii?Q?f6Pm2iY10bL4vWtyRl1MrC0A+sKsOA+W63hbqUBRxNsamX4VDy3M1nO999nQ?=
 =?us-ascii?Q?DSadeMSzpRe5Y++V6e33KJLHH4MHOF3p4R2HWnlnNn7yHKzd/CT8k4PqOOM7?=
 =?us-ascii?Q?WAynELXmVSxtEOZM9Q0t7my8aphrLjSZhs8HfBLzxM8JdGVawWfOmBqPslvI?=
 =?us-ascii?Q?/OH4CAOh1f+belIOlFcHCqR8mX6TB+apVAZAWce8MMx62z0xItlti13jlnlW?=
 =?us-ascii?Q?eFRWJKCrII9mHoO9pShEoQeI+3+n86E01JuZLxlGcrLsC8zdW8Lkaget8nWM?=
 =?us-ascii?Q?nK/ofGp0r0jd90IT0hMK5+mwdnPNe80AuPr3COOcL3kJYjKbwogNX57gCfWo?=
 =?us-ascii?Q?2OOIcQBEBmOegVRiOTFZHbPniEDt4/wJnMunyKoUZuw6CbHueDQXmFHH06Gv?=
 =?us-ascii?Q?mbpGlFEOL0iUT6Y1bvfyWcsbdra1ZQqYpe8d89BVPe4ag33xZgVAZoxHLFJU?=
 =?us-ascii?Q?kQuy9uYEtB9cDUpel3Zh7ohRLtl/0Pcqa4Q+rYO1sYngfFnWO5kaWeBi0Ra3?=
 =?us-ascii?Q?RtxaL1K3xpPxc6GonlQbUHG+qHFvdTkDkpWyrvy8srqenDRd6R2QqOWnt3wy?=
 =?us-ascii?Q?eEe9d3C6JBflW6d0nhYsmrunf+6G8FEynYF9cdX/9WnESWhc6qdZQMOq7wRl?=
 =?us-ascii?Q?useNY8v0B1oojQh4lZtNbG8KuN5mIBeOhW+Tq/XQDFFKjgoveUspD6/HFm+E?=
 =?us-ascii?Q?9x2e8zi8j0CN4/VrMP9mmuCYoxqoOiyUVgK5icHKnClXraAYg5AlTOIsCZq7?=
 =?us-ascii?Q?EEYnJyeV8mR6J8Qhr0CxSCbyvKBbRodbaSGEH1/G6kwBOeZ6k9tKInnk7Muv?=
 =?us-ascii?Q?yYw2JuwA+g7Hb0y/k2fZPIG1Ssv1cO+gOmZ2r76rPJOZGQd/9kl7OtdEyH1a?=
 =?us-ascii?Q?oTeZQshxMTRu+U9b3cmLyAaTPG1NzbFNCivsVfULzecr1cUGO3aAS4FrHrZ7?=
 =?us-ascii?Q?tCrA8nHi7TD+Vo+GkWuN88cviTVE2ayb07QdTsjGsjdeKKStWMVhpvmkUnDs?=
 =?us-ascii?Q?QSA/bbmgcX6Y1DGTOzXdfJt4Bbt9spfiWgOIOzc944oi+rHd+nFIqIShK7Lw?=
 =?us-ascii?Q?klxlEWtbKaZrSNzuuVA4nH41o6oT9hSh69/aLmpLrlfDV/LLBdTU0yK5PV5y?=
 =?us-ascii?Q?edotv44Z9gNEpDFl1cyWN/5vUiy7vCh4Gh4HSDepwmNcVbFP2Ej8hpz3jlc6?=
 =?us-ascii?Q?r+cprbVeGwGX+r9FsxW1jaebCIZtfEG/qfP7i0W/itko0G2m+2pIX53B2aUa?=
 =?us-ascii?Q?JOCOJU+Brw++mhy6DMjJw5s2HspTkCSykJ7sUwIVDx3SBZsjm55/Y8M51CUx?=
 =?us-ascii?Q?5P8HMBG/ffJj6KLpXj4Je3fBUYuUFqpI8d4bxcEv6m6VVMtCCpDwNNOLoyxI?=
 =?us-ascii?Q?KPQqL1qNNeip/HFD3n9qVp5NcdDXkze+WW8wxIZHmCKj3+Gx1b8IlA3m2C1T?=
 =?us-ascii?Q?bvgwHhu1AfvZzm3NdsRM/QiHNMWYbQLw6tjTmge7j7lMRa39wdR9JyaMSUeP?=
 =?us-ascii?Q?GmX+EmKDLQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 449aac82-1a5e-4c16-ba5f-08de62c3ddff
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:30:52.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWh9CsuWGZuPTy0q+fGDBYCEWcHlePvDoZ9+H066DlId1aKZKsspL4ZmRKCkkVta93rrl1zrSil0aZ3MdW0vqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-76118-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vm-snb:email,pengar:email,2c8541ba7c67:email,9cc2038e482f:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:+];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0E6EBD362D
X-Rspamd-Action: no action

--csx8ktZH1zvSCQRU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi, Christian Brauner,

sorry for late. it cost us some time to double confirm.

On Sat, Jan 31, 2026 at 12:41:12PM +0100, Christian Brauner wrote:
> On Fri, Jan 30, 2026 at 05:59:00PM +0100, Christian Brauner wrote:
> > On Tue, Jan 27, 2026 at 02:26:09PM +0800, kernel test robot wrote:
> > >=20
> > >=20
> > > Hello,
> > >=20
> > > kernel test robot noticed "BUG:kernel_hang_in_test_stage" on:
> > >=20
> > > commit: 313c47f4fe4d07eb2969f429a66ad331fe2b3b6f ("fs: use nullfs unc=
onditionally as the real rootfs")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> > >=20
> > > [test failed on linux-next/master ca3a02fda4da8e2c1cb6baee5d72352e9e2=
cfaea]
> > >=20
> > > in testcase: trinity
> > > version:=20
> > > with following parameters:
> > >=20
> > > 	runtime: 300s
> > > 	group: group-00
> > > 	nr_groups: 5
> > >=20
> > >=20
> > >=20
> > > config: x86_64-kexec
> > > compiler: clang-20
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 =
-m 32G
> > >=20
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >=20
> > The reproducer doesn't work:
> >=20
> > ubuntu@pengar:~/data/kernel/linux/MODULES/lkp-tests$ sudo bin/lkp qemu =
-k ../../vmlinux -m ./modules.cgz job-script # job-script
> > result_root: /home/ubuntu/.lkp//result/trinity/group-00-5-300s/vm-snb/y=
octo-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969=
f429a66ad331fe2b3b6f/15
> > downloading initrds ...
> > skip downloading /home/ubuntu/.lkp/cache/osimage/yocto/yocto-x86_64-min=
imal-20190520.cgz
> > 19270 blocks
> > /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-8 =
https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-20180403=
.cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz -N -P /home/ubu=
ntu/.lkp/cache/osimage/pkg/debian-x86_64-20180403.cgz
> > Failed to download osimage/pkg/debian-x86_64-20180403.cgz/trinity-stati=
c-x86_64-x86_64-1c734c75-1_2020-01-06.cgz
> > cat: '': No such file or directory
> > exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev lo=
cal,id=3Dtest_dev,path=3D/home/ubuntu/.lkp//result/trinity/group-00-5-300s/=
vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d=
07eb2969f429a66ad331fe2b3b6f/15,security_model=3Dnone -device virtio-9p-pci=
,fsdev=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel ../../vmlinux -append=
 root=3D/dev/ram0 RESULT_ROOT=3D/result/trinity/group-00-5-300s/vm-snb/yoct=
o-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f42=
9a66ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/linux/x86_64-kexec/clang-20/313c47f4f=
e4d07eb2969f429a66ad331fe2b3b6f/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d bran=
ch=3Dinternal-devel/devel-hourly-20260124-050739 job=3D/lkp/jobs/scheduled/=
vm-meta-17/trinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47=
f4fe4d-20260126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86=
_64-kexec commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6f intremap=3Dpost=
ed_msi watchdog_thresh=3D240 rcuperf.shutdown=3D0 rcuscale.shutdown=3D0 ref=
scale.shutdown=3D0 audit=3D0 kunit.enable=3D0 ia32_emulation=3Don max_uptim=
e=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_always_enab=
led rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Do=
n panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ra=
mdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr i=
gnore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,11=
5200 vga=3Dnormal rw  ip=3Ddhcp result_service=3D9p/virtfs_mount -initrd /h=
ome/ubuntu/.lkp/cache/final_initrd -smp 2 -m 12872M -no-reboot -device i630=
0esb -rtc base=3Dlocaltime -device e1000,netdev=3Dnet0 -netdev user,id=3Dne=
t0 -display none -monitor null -serial stdio
> > qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF N=
ote
> >=20
> > The paths for the downloads in the job script are wrong or don't work.
> > Even if I manually modify the above path I still get in the next step:
> >=20
> > /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-8 =
https://download.01.org/0day-ci/lkp-qemu/modules.cgz -N -P /home/ubuntu/.lk=
p/cache
> > Failed to download modules.cgz
> > cat: '': No such file or directory
> >=20
> > I need a way to reproduce the issue to figure out exactly what is
> > happening.
>=20
> Ok, I got it all working and can run the reproducer.

not sure how you solve it? from above log, the problem is caused by
trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz, do you have any log=
?
internally, it's a soft link pointing to a debian version, so maybe there a=
re
some code issue for uploading to https://download.01.org/0day-ci.

if you could share more information with us, we could check further to impr=
ove
our process and reproducer. thanks a lot!

we will also check by ourselves, so no problem at all if you ignore this.


> But I cannot
> reproduce the error below at all. I've tried vfs.all, vfs-7.0.nullfs,
> vfs-7.0.initrd, and I tried ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea. In
> all cases:
>=20
> root@vm-snb:~# which dmesg
> /bin/dmesg
> root@vm-snb:~# which sleep
> /bin/sleep
> root@vm-snb:~# which grep
> /bin/grep
> root@vm-snb:~# /lkp/lkp/src/bin/event/wait
> Usage: /lkp/lkp/src/bin/event/wait [-t|--timeout seconds] PIPE_NAME
>=20
> root      1736  0.0  0.0   4144  1020 ?        S    10:36   0:00 /bin/sh =
/etc/rc5.d/S77lkp-bootstrap start
> root      1738  0.0  0.0   4408  2676 ?        S    10:36   0:00  \_ /bin=
/sh /lkp/lkp/src/bin/lkp-setup-rootfs
> root      1771  0.0  0.0   4144  1908 ?        S    10:36   0:00      \_ =
tail -f /tmp/stderr
> root      1853  0.0  0.0   4408  2688 ?        S    10:36   0:00      \_ =
/bin/sh /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-17/trinity-gro=
up-00-5-300s-yocto-x86_64-minimal-20190520.c
> root      1875  0.0  0.0   4144  1932 ?        S    10:36   0:00         =
 \_ tail -n 0 -f /tmp/stdout
> root      1876  0.0  0.0   4144  1900 ?        S    10:36   0:00         =
 \_ tail -n 0 -f /tmp/stderr
> root      1877  0.0  0.0   4144  2196 ?        S    10:36   0:00         =
 \_ tail -n 0 -f /tmp/stdout /tmp/stderr
> root      1930  0.0  0.0   4148  2524 ?        S    10:36   0:00         =
 \_ /bin/sh /lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-300s-yocto-x8=
6_64-minimal-20190520.cgz-313c47f4fe4d-20260
> root      1943  0.0  0.0   4016  1892 ?        S    10:36   0:00         =
     \_ cat /proc/kmsg
> root      1974  0.0  0.0   4016  1856 ?        S    10:36   0:00         =
     |   \_ cat /tmp/lkp/fifo-kmsg
> root      1945  0.0  0.0   2476  1732 ?        S    10:36   0:00         =
     \_ vmstat --timestamp -n 10
> root      1989  0.0  0.0   4016  1928 ?        S    10:36   0:00         =
     |   \_ cat /tmp/lkp/fifo-heartbeat
> root      1948  0.1  0.0   4148  2492 ?        S    10:36   0:00         =
     \_ /bin/sh /lkp/lkp/src/monitors/meminfo
> root      1995  0.0  0.0   4280  2120 ?        S    10:36   0:00         =
     |   \_ gzip -c
> root      2532  0.0  0.0   1144   832 ?        S    10:39   0:00         =
     |   \_ /lkp/lkp/src/bin/event/wait post-test --timeout 1
> root      1952  0.0  0.0   4148  2392 ?        S    10:36   0:00         =
     \_ /bin/sh /lkp/lkp/src/monitors/oom-killer
> root      1978  0.0  0.0   4016  1880 ?        S    10:36   0:00         =
     |   \_ cat /tmp/lkp/fifo-oom-killer
> root      2523  0.0  0.0   1144   836 ?        S    10:39   0:00         =
     |   \_ /lkp/lkp/src/bin/event/wait post-test --timeout 11
> root      1955  0.0  0.0   4148  2140 ?        S    10:36   0:00         =
     \_ /bin/sh /lkp/lkp/src/monitors/plain/watchdog
> root      1971  0.0  0.0   1144   832 ?        S    10:36   0:00         =
     |   \_ /lkp/lkp/src/bin/event/wait job-finished --timeout 7200
> root      2026  0.0  0.0   4148  2448 ?        S    10:37   0:00         =
     \_ /bin/sh /lkp/lkp/src/programs/trinity/run
> root      2049  0.0  0.0   4016  1820 ?        S    10:37   0:00         =
         \_ sleep 300
> root      1747  0.0  0.0   4144  2176 ?        Ss   10:36   0:00 /bin/sh =
/bin/start_getty 115200 ttyS0 vt102
> root      1794  0.0  0.0   4188  2424 ttyS0    Ss   10:36   0:00  \_ -sh
> root      2533  0.0  0.0   3288  2272 ttyS0    R+   10:39   0:00      \_ =
ps auxf
> root      1749  0.0  0.0   4144  2176 tty1     Ss+  10:36   0:00 /sbin/ge=
tty 38400 tty1
> root      1963  0.0  0.0   1144   324 ?        Ss   10:36   0:00 /lkp/lkp=
/src/bin/event/wakeup activate-monitor
> root      1968  0.0  0.0   1144   320 ?        Ss   10:36   0:00 /lkp/lkp=
/src/bin/event/wakeup pre-test
> root      2030  0.0  0.0   4148  1972 ?        S    10:37   0:00 tee -a /=
/result/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x8=
6_64-kexec/clang-20/313c47f4fe4d07eb2969f429
>=20
> Is there any more data you can provide or how much and how reliable this
> test fails? Otherwise I have no choice but to discount this for now.

in our bot tests, the results are quite persistent, now we run even more ti=
ll
~120 times for either 313c47f4fe4d07eb2969f429a66 or its parent, always see
the issue for 313c47f4fe4d07eb2969f429a66, and parent keeps clean.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
  vm-snb/trinity/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/30=
0s/group-00/5

7416634fd6f18762 313c47f4fe4d07eb2969f429a66
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :121         98%         119:119   last_state.is_incomplete_run
           :121         98%         119:119   last_state.running
           :121         98%         119:119   dmesg.BUG:kernel_hang_in_test=
_stage

(BTW, in fact we also tried to rebuild the kernel and rerun tests, also got
same results)

I also tried reproducer
https://download.01.org/0day-ci/archive/20260127/202601270735.29b7c33e-lkp@=
intel.com/reproduce
on my local Ubuntu 22.04.5 LTS

can reproduce the issue for 313c47f4fe4d07eb2969f429a66. one log is attache=
d as
313c47f4fe4d-run.log.

no issue if running upon parent commit 7416634fd6f18762. one log is attache=
d as
parent-7416634fd6f1-run.log.

you mentioned you tried ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
(commit ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea (tag: next-20260123))
I can reproduce the issue upon it. one log is attached as
next-20260123-ca3a02fda4da-run.log.


I uploaded the binaries I used for reproducer to
https://download.01.org/0day-ci/archive/20260127/202601270735.29b7c33e-lkp@=
intel.com
not sure if they are useful.

for 313c47f4fe4d07eb2969f429a66:
vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d <-- <bzImage>
modules-313c47f4fe4d.cgz
vmlinux-313c47f4fe4d.xz   <---- not sure if it could supply some informatio=
n

for parent 7416634fd6f18762:
vmlinuz-6.19.0-rc1-00005-g7416634fd6f1
modules-7416634fd6f1.cgz
vmlinux-7416634fd6f1.xz

for ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea (tag: next-20260123):
vmlinuz-6.19.0-rc6-next-20260123
modules-6.19.0-rc6-next-20260123.cgz
vmlinux-next-20260123.xz
config-6.19.0-rc6-next-20260123  <--- since it has diff with config-6.19.0-=
rc1-00006-g313c47f4fe4d

>=20
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202601270735.29b7c33e-lkp@in=
tel.com
> > >=20
> > >=20
> > >=20
> > > [   27.746952][ T1793] /lkp/lkp/src/monitors/meminfo: line 25: /lkp/l=
kp/src/bin/event/wait: not found
> > > [   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 94: dme=
sg: not found
> > > [   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 94: gre=
p: not found
> > > [   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 25: /lk=
p/lkp/src/bin/event/wait: not found
> > > [   65.744824][ T4974] trinity-main[4974]: segfault at 0 ip 000000000=
0000000 sp 00007ffe08d2ec08 error 15 likely on CPU 0 (core 0, socket 0)
> > > [   65.746308][ T4974] Code: Unable to access opcode bytes at 0xfffff=
fffffffffd6.
> > >=20
> > > Code starting with the faulting instruction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > /etc/rc5.d/S77lkp-bootstrap: line 79: sleep: not found
> > > BUG: kernel hang in test stage
> > >=20
> > >=20
> > >=20
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20260127/202601270735.29b7c33=
e-lkp@intel.com
> > >=20
> > >=20
> > >=20
> > > --=20
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > >=20
>=20

--csx8ktZH1zvSCQRU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="313c47f4fe4d-run.log"
Content-Transfer-Encoding: quoted-printable

$ sudo bin/lkp qemu -k vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d -m modules-31=
3c47f4fe4d.cgz job-script
result_root: /home/xsang/.lkp//result/trinity/group-00-5-300s/vm-snb/yocto-=
x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a=
66ad331fe2b3b6f/6
downloading initrds ...
use local modules: /home/xsang/.lkp/cache/modules-313c47f4fe4d.cgz
skip downloading /home/xsang/.lkp/cache/osimage/yocto/yocto-x86_64-minimal-=
20190520.cgz
19270 blocks
skip downloading /home/xsang/.lkp/cache/osimage/pkg/debian-x86_64-20180403.=
cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz
43381 blocks
exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev local,=
id=3Dtest_dev,path=3D/home/xsang/.lkp//result/trinity/group-00-5-300s/vm-sn=
b/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2=
969f429a66ad331fe2b3b6f/6,security_model=3Dnone -device virtio-9p-pci,fsdev=
=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel vmlinuz-6.19.0-rc1-00006-g3=
13c47f4fe4d -append root=3D/dev/ram0 RESULT_ROOT=3D/result/trinity/group-00=
-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c=
47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/linux/x86_64-kexec=
/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/vmlinuz-6.19.0-rc1-00006=
-g313c47f4fe4d branch=3Dinternal-devel/devel-hourly-20260124-050739 job=3D/=
lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-300s-yocto-x86_64-minimal-=
20190520.cgz-313c47f4fe4d-20260126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx=
86_64 kconfig=3Dx86_64-kexec commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3=
b6f intremap=3Dposted_msi watchdog_thresh=3D240 rcuperf.shutdown=3D0 rcusca=
le.shutdown=3D0 refscale.shutdown=3D0 audit=3D0 kunit.enable=3D0 ia32_emula=
tion=3Don max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebu=
g sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0=
 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic o=
ops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 system=
d.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200=
 console=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddhcp result_service=3D9p/virt=
fs_mount -initrd /home/xsang/.lkp/cache/final_initrd -smp 2 -m 32768M -no-r=
eboot -device i6300esb -rtc base=3Dlocaltime -device e1000,netdev=3Dnet0 -n=
etdev user,id=3Dnet0 -display none -monitor null -serial stdio
early console in setup code
No EFI environment detected.
early console in extract_kernel
input_data: 0x00000000031ee2c4
input_len: 0x0000000000ce259d
output: 0x0000000001000000
output_len: 0x0000000002e81808
kernel_total_size: 0x0000000002c28000
needed_size: 0x0000000003000000
trampoline_32bit: 0x0000000000000000

Decompressing Linux... Parsing ELF... done.
Booting the kernel (entry_offset: 0x0000000002718ff0).
[    0.000000][    T0] Linux version 6.19.0-rc1-00006-g313c47f4fe4d (kbuild=
@e073fd8671b0) (clang version 20.1.8 (git://gitmirror/llvm_project 87f0227c=
b60147a26a1eeb4fb06e3b505e9c7261), LLD 20.1.8 (git://gitmirror/llvm_project=
 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)) #1 SMP PREEMPT_DYNAMIC Mon Jan =
26 21:00:53 CET 2026
[    0.000000][    T0] Command line: root=3D/dev/ram0 RESULT_ROOT=3D/result=
/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-ke=
xec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/l=
inux/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/vmlinuz=
-6.19.0-rc1-00006-g313c47f4fe4d branch=3Dinternal-devel/devel-hourly-202601=
24-050739 job=3D/lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-300s-yoct=
o-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-19zhjsh-2.yaml us=
er=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-kexec commit=3D313c47f4fe4d07eb2969=
f429a66ad331fe2b3b6f intremap=3Dposted_msi watchdog_thresh=3D240 rcuperf.sh=
utdown=3D0 rcuscale.shutdown=3D0 refscale.shutdown=3D0 audit=3D0 kunit.enab=
le=3D0 ia32_emulation=3Don max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 =
debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D10=
0 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_w=
atchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor=
_count=3D8 systemd.log_level=3Derr ignore_loglevel console
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0]   Hygon HygonGenuine
[    0.000000][    T0]   Centaur CentaurHauls
[    0.000000][    T0]   zhaoxin   Shanghai
[    0.000000][    T0] x86/CPU: Model not found in latest microcode list
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbf=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009fff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000ffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdfff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000feffc000-0x00000000fefffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000fffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000083ffffff=
f] usable
[    0.000000][    T0] printk: debug: ignoring loglevel setting.
[    0.000000][    T0] printk: legacy bootconsole [earlyser0] enabled
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] APIC: Static calls initialized
[    0.000000][    T0] SMBIOS 2.8 present.
[    0.000000][    T0] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.=
15.0-1 04/01/2014
[    0.000000][    T0] DMI: Memory slots populated: 2/2
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] last_pfn =3D 0xbffe0 max_arch_pfn =3D 0x400000000
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000001][    T0] kvm-clock: using sched offset of 338611590 cycles
[    0.000533][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max=
_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.002227][    T0] tsc: Detected 3000.000 MHz processor
[    0.003344][    T0] e820: update [mem 0x00000000-0x00000fff] usable =3D=
=3D> reserved
[    0.004067][    T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.004675][    T0] last_pfn =3D 0x840000 max_arch_pfn =3D 0x400000000
[    0.005291][    T0] MTRR map: 4 entries (3 fixed + 1 variable; max 19), =
built from 8 variable MTRRs
[    0.006152][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP=
  UC- WT
[    0.006833][    T0] last_pfn =3D 0xbffe0 max_arch_pfn =3D 0x400000000
[    0.007402][    T0] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.007960][    T0] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.008558][    T0] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.013547][    T0] found SMP MP-table at [mem 0x000f5b90-0x000f5b9f]
[    0.014107][    T0]   mpc: f5ba0-f5c78
[    0.014892][    T0] RAMDISK: [mem 0xb215e000-0xbffdffff]
[    0.015396][    T0] ACPI: Early table checksum verification disabled
[    0.016012][    T0] ACPI: RSDP 0x00000000000F5970 000014 (v00 BOCHS )
[    0.016640][    T0] ACPI: RSDT 0x00000000BFFE196E 000034 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.017534][    T0] ACPI: FACP 0x00000000BFFE181A 000074 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.018448][    T0] ACPI: DSDT 0x00000000BFFE0040 0017DA (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.019275][    T0] ACPI: FACS 0x00000000BFFE0000 000040
[    0.019786][    T0] ACPI: APIC 0x00000000BFFE188E 000080 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.020585][    T0] ACPI: HPET 0x00000000BFFE190E 000038 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.021467][    T0] ACPI: WAET 0x00000000BFFE1946 000028 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.022378][    T0] ACPI: Reserving FACP table memory at [mem 0xbffe181a=
-0xbffe188d]
[    0.023042][    T0] ACPI: Reserving DSDT table memory at [mem 0xbffe0040=
-0xbffe1819]
[    0.023701][    T0] ACPI: Reserving FACS table memory at [mem 0xbffe0000=
-0xbffe003f]
[    0.024342][    T0] ACPI: Reserving APIC table memory at [mem 0xbffe188e=
-0xbffe190d]
[    0.025000][    T0] ACPI: Reserving HPET table memory at [mem 0xbffe190e=
-0xbffe1945]
[    0.025741][    T0] ACPI: Reserving WAET table memory at [mem 0xbffe1946=
-0xbffe196d]
[    0.026511][    T0] Mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.027260][    T0] No NUMA configuration found
[    0.027635][    T0] Faking a node at [mem 0x0000000000000000-0x000000083=
fffffff]
[    0.028331][    T0] NODE_DATA(0) allocated [mem 0x83ffe0380-0x83ffe4fff]
[    0.028980][    T0] cma: Reserved 200 MiB at 0x0000000100000000
[    0.103221][    T0] Zone ranges:
[    0.103676][    T0]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]
[    0.105374][    T0]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]
[    0.107078][    T0]   Normal   [mem 0x0000000100000000-0x000000083ffffff=
f]
[    0.108759][    T0]   Device   empty
[    0.109639][    T0] Movable zone start for each node
[    0.110864][    T0] Early memory node ranges
[    0.111905][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ef=
ff]
[    0.113616][    T0]   node   0: [mem 0x0000000000100000-0x00000000bffdff=
ff]
[    0.115332][    T0]   node   0: [mem 0x0000000100000000-0x000000083fffff=
ff]
[    0.117037][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
0083fffffff]
[    0.118956][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.120158][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.165539][    T0] On node 0, zone Normal: 32 pages in unavailable rang=
es
[    0.166390][    T0] ACPI: PM-Timer IO Port: 0x608
[    0.166806][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.167369][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23
[    0.168008][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl =
dfl)
[    0.168600][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID =
0, APIC INT 02
[    0.169276][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)
[    0.169893][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID =
0, APIC INT 05
[    0.170561][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)
[    0.171190][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID =
0, APIC INT 09
[    0.171852][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)
[    0.172479][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID =
0, APIC INT 0a
[    0.173145][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)
[    0.173775][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID =
0, APIC INT 0b
[    0.174445][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID =
0, APIC INT 01
[    0.175119][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID =
0, APIC INT 03
[    0.175781][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID =
0, APIC INT 04
[    0.176453][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID =
0, APIC INT 06
[    0.177130][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID =
0, APIC INT 07
[    0.177800][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID =
0, APIC INT 08
[    0.178467][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID =
0, APIC INT 0c
[    0.179152][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID =
0, APIC INT 0d
[    0.179853][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID =
0, APIC INT 0e
[    0.180522][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID =
0, APIC INT 0f
[    0.181203][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation
[    0.181796][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.182288][    T0] TSC deadline timer available
[    0.182679][    T0] CPU topo: Max. logical packages:   1
[    0.183127][    T0] CPU topo: Max. logical dies:       1
[    0.183573][    T0] CPU topo: Max. dies per package:   1
[    0.184035][    T0] CPU topo: Max. threads per core:   1
[    0.184479][    T0] CPU topo: Num. cores per package:     2
[    0.184942][    T0] CPU topo: Num. threads per package:   2
[    0.185406][    T0] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPU=
s
[    0.185974][    T0] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.186491][    T0] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_=
eoi_write()
[    0.187148][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
000000-0x00000fff]
[    0.187846][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
09f000-0x000fffff]
[    0.188548][    T0] PM: hibernation: Registered nosave memory: [mem 0xbf=
fe0000-0xffffffff]
[    0.189257][    T0] [mem 0xc0000000-0xfeffbfff] available for PCI device=
s
[    0.189841][    T0] Booting paravirtualized kernel on KVM
[    0.190304][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.196197][    T0] setup_percpu: NR_CPUS:512 nr_cpumask_bits:2 nr_cpu_i=
ds:2 nr_node_ids:1
[    0.197253][    T0] percpu: Embedded 55 pages/cpu s185240 r8192 d31848 u=
1048576
[    0.197888][    T0] pcpu-alloc: s185240 r8192 d31848 u1048576 alloc=3D1*=
2097152
[    0.198502][    T0] pcpu-alloc: [0] 0 1
[    0.198867][    T0] Kernel command line: root=3D/dev/ram0 RESULT_ROOT=3D=
/result/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x8=
6_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 BOOT_IMAGE=
=3D/pkg/linux/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6=
f/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d branch=3Dinternal-devel/devel-hour=
ly-20260124-050739 job=3D/lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-=
300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-19zhjsh-=
2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-kexec commit=3D313c47f4fe4=
d07eb2969f429a66ad331fe2b3b6f intremap=3Dposted_msi watchdog_thresh=3D240 r=
cuperf.shutdown=3D0 rcuscale.shutdown=3D0 refscale.shutdown=3D0 audit=3D0 k=
unit.enable=3D0 ia32_emulation=3Don max_uptime=3D7200 LKP_LOCAL_RUN=3D1 sel=
inux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_tim=
eout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=
=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 =
drbd.minor_count=3D8 systemd.log_level=3Derr \
[    0.206599][    T0] Kernel command line: ignore_loglevel console=3Dtty0 =
earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddhc=
p result_service=3D9p/virtfs_mount
[    0.208074][    T0] audit: disabled (until reboot)
[    0.208585][    T0] sysrq: sysrq always enabled.
[    0.209043][    T0] ignoring the deprecated load_ramdisk=3D option
[    0.209674][    T0] Unknown kernel command line parameters "RESULT_ROOT=
=3D/result/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz=
/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 branch=3D=
internal-devel/devel-hourly-20260124-050739 job=3D/lkp/jobs/scheduled/vm-me=
ta-17/trinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4=
d-20260126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-k=
exec commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6f ia32_emulation=3Don =
max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 nmi_watchdog=3Dpanic prompt=
_ramdisk=3D0 vga=3Dnormal result_service=3D9p/virtfs_mount", will be passed=
 to user space.
[    0.214622][    T0] printk: log buffer data + meta data: 1048576 + 36700=
16 =3D 4718592 bytes
[    0.219992][    T0] Dentry cache hash table entries: 4194304 (order: 13,=
 33554432 bytes, linear)
[    0.223158][    T0] Inode-cache hash table entries: 2097152 (order: 12, =
16777216 bytes, linear)
[    0.223980][    T0] software IO TLB: area num 2.
[    0.237876][    T0] Fallback order for Node 0: 0
[    0.237882][    T0] Built 1 zonelists, mobility grouping on.  Total page=
s: 8388478
[    0.238948][    T0] Policy zone: Normal
[    0.239261][    T0] mem auto-init: stack:all(zero), heap alloc:off, heap=
 free:off
[    0.317637][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPU=
s=3D2, Nodes=3D1
[    0.318258][    T0] Kernel/User page tables isolation: enabled
[    0.319042][    T0] ftrace: allocating 59362 entries in 232 pages
[    0.319557][    T0] ftrace: allocated 232 pages with 4 groups
[    0.320982][    T0] Dynamic Preempt: voluntary
[    0.321592][    T0] rcu: Preemptible hierarchical RCU implementation.
[    0.322122][    T0] rcu:     RCU restricting CPUs from NR_CPUS=3D512 to =
nr_cpu_ids=3D2.
[    0.322727][    T0]  RCU CPU stall warnings timeout set to 100 (rcu_cpu_=
stall_timeout).
[    0.323383][    T0]  Trampoline variant of Tasks RCU enabled.
[    0.323851][    T0]  Rude variant of Tasks RCU enabled.
[    0.324285][    T0]  Tracing variant of Tasks RCU enabled.
[    0.324731][    T0] rcu: RCU calculated value of scheduler-enlistment de=
lay is 25 jiffies.
[    0.325422][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr=
_cpu_ids=3D2
[    0.326045][    T0] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_=
cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    0.326828][    T0] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_=
task_cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    0.327634][    T0] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu=
_task_cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    0.331547][    T0] NR_IRQS: 33024, nr_irqs: 440, preallocated irqs: 16
[    0.332486][    T0] rcu: srcu_init: Setting srcu_struct sizes based on c=
ontention.
[    0.336105][    T0] Console: colour VGA+ 80x25
[    0.336481][    T0] printk: legacy console [tty0] enabled
[    0.369485][    T0] printk: legacy console [ttyS0] enabled
[    0.369485][    T0] printk: legacy console [ttyS0] enabled
[    0.370553][    T0] printk: legacy bootconsole [earlyser0] disabled
[    0.370553][    T0] printk: legacy bootconsole [earlyser0] disabled
[    0.371777][    T0] ACPI: Core revision 20250807
[    0.372387][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 19112604467 ns
[    0.373504][    T0] APIC: Switch to symmetric I/O mode setup
[    0.374297][    T0] x2apic enabled
[    0.374893][    T0] APIC: Switched APIC routing to: physical x2apic
[    0.375592][    T0] Masked ExtINT on CPU#0
[    0.376532][    T0] ENABLING IO-APIC IRQs
[    0.376992][    T0] Init IO_APIC IRQs
[    0.377418][    T0] apic 0 pin 0 not connected
[    0.377969][    T0] IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1=
 Level:0 ActiveLow:0)
[    0.378890][    T0] IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0=
 Level:0 ActiveLow:0)
[    0.379840][    T0] IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3=
 Level:0 ActiveLow:0)
[    0.380775][    T0] IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4=
 Level:0 ActiveLow:0)
[    0.381721][    T0] IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5=
 Level:1 ActiveLow:0)
[    0.382664][    T0] IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6=
 Level:0 ActiveLow:0)
[    0.383604][    T0] IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7=
 Level:0 ActiveLow:0)
[    0.384544][    T0] IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8=
 Level:0 ActiveLow:0)
[    0.385475][    T0] IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9=
 Level:1 ActiveLow:0)
[    0.386461][    T0] IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ =
10 Level:1 ActiveLow:0)
[    0.387436][    T0] IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ =
11 Level:1 ActiveLow:0)
[    0.388388][    T0] IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ =
12 Level:0 ActiveLow:0)
[    0.389345][    T0] IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ =
13 Level:0 ActiveLow:0)
[    0.390357][    T0] IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ =
14 Level:0 ActiveLow:0)
[    0.391319][    T0] IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ =
15 Level:0 ActiveLow:0)
[    0.392284][    T0] apic 0 pin 16 not connected
[    0.392794][    T0] apic 0 pin 17 not connected
[    0.393311][    T0] apic 0 pin 18 not connected
[    0.393861][    T0] apic 0 pin 19 not connected
[    0.394377][    T0] apic 0 pin 20 not connected
[    0.394895][    T0] apic 0 pin 21 not connected
[    0.395415][    T0] apic 0 pin 22 not connected
[    0.395933][    T0] apic 0 pin 23 not connected
[    0.396584][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1=
 pin2=3D-1
[    0.397331][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max=
_cycles: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.398605][    T0] Calibrating delay loop (skipped) preset value.. 6000=
.00 BogoMIPS (lpj=3D12000000)
[    0.399698][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.400369][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.401086][    T0] mitigations: Enabled attack vectors: user_kernel, us=
er_user, guest_host, guest_guest, SMT mitigations: auto
[    0.402858][    T0] Speculative Store Bypass: Vulnerable
[    0.403476][    T0] Spectre V2 : Mitigation: Retpolines
[    0.404070][    T0] ITS: Mitigation: Aligned branch/return thunks
[    0.404734][    T0] MDS: Vulnerable: Clear CPU buffers attempted, no mic=
rocode
[    0.405542][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers an=
d __user pointer sanitization
[    0.406821][    T0] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on=
 context switch and VMEXIT
[    0.407809][    T0] active return thunk: its_return_thunk
[    0.408425][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floati=
ng point registers'
[    0.409381][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regist=
ers'
[    0.410147][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regist=
ers'
[    0.410766][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  2=
56
[    0.411521][    T0] x86/fpu: Enabled xstate features 0x7, context size i=
s 832 bytes, using 'standard' format.
[    0.429103][    T0] Freeing SMP alternatives memory: 48K
[    0.429743][    T0] pid_max: default: 32768 minimum: 301
[    0.430392][    T0] Mount-cache hash table entries: 65536 (order: 7, 524=
288 bytes, linear)
[    0.430843][    T0] Mountpoint-cache hash table entries: 65536 (order: 7=
, 524288 bytes, linear)
[    0.431875][    T0] VFS: Finished mounting rootfs on nullfs
[    0.432645][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (fam=
ily: 0x6, model: 0x2a, stepping: 0x1)
[    0.434073][    T1] Performance Events: unsupported CPU family 6 model 4=
2 no PMU driver, software events only.
[    0.434601][    T1] signal: max sigframe size: 1360
[    0.434601][    T1] rcu: Hierarchical SRCU implementation.
[    0.434601][    T1] rcu:     Max phase no-delay instances is 1000.
[    0.434778][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 1 crossnode level
[    0.439249][    T1] smp: Bringing up secondary CPUs ...
[    0.439948][    T1] smpboot: x86: Booting SMP configuration:
[    0.440584][    T1] .... node  #0, CPUs:      #1
[    0.061475][    T0] Masked ExtINT on CPU#1
[    0.444604][    T1] smp: Brought up 1 node, 2 CPUs
[    0.444604][    T1] smpboot: Total of 2 processors activated (12000.00 B=
ogoMIPS)
[    0.446995][    T1] Memory: 32429364K/33553912K available (19529K kernel=
 code, 5589K rwdata, 6912K rodata, 3364K init, 1652K bss, 913912K reserved,=
 204800K cma-reserved)
[    0.451848][    T1] devtmpfs: initialized
[    0.451848][    T1] x86/mm: Memory block size: 128MB
[    0.455638][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645041785100000 ns
[    0.455748][    T1] posixtimers hash table entries: 1024 (order: 2, 1638=
4 bytes, linear)
[    0.458608][    T1] futex hash table entries: 512 (32768 bytes on 1 NUMA=
 nodes, total 32 KiB, linear).
[    0.460332][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.461441][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    0.461443][    T1] thermal_sys: Registered thermal governor 'user_space=
'
[    0.462185][    T1] cpuidle: using governor ladder
[    0.463314][    T1] cpuidle: using governor menu
[    0.464235][    T1] PCI: Using configuration type 1 for base access
[    0.465234][    T1] kprobes: kprobe jump-optimization is enabled. All kp=
robes are optimized if possible.
[    0.511996][    T1] ACPI: Added _OSI(Module Device)
[    0.511996][    T1] ACPI: Added _OSI(Processor Device)
[    0.511996][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    0.512980][    T1] ACPI: 1 ACPI AML tables successfully acquired and lo=
aded
[    0.524104][    T1] ACPI: Interpreter enabled
[    0.524104][    T1] ACPI: PM: (supports S0 S3 S4 S5)
[    0.524104][    T1] ACPI: Using IOAPIC for interrupt routing
[    0.524320][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug
[    0.525681][    T1] PCI: Using E820 reservations for host bridge windows
[    0.526676][    T1] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.529194][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])
[    0.530167][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Seg=
ments MSI HPX-Type3]
[    0.530854][    T1] acpi PNP0A03:00: _OSC: not requesting OS control; OS=
 requires [ExtendedConfig ASPM ClockPM MSI]
[    0.532125][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, c=
an't access extended configuration space under this bridge
[    0.533625][    T1] PCI host bridge to bus 0000:00
[    0.534237][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]
[    0.534843][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
[    0.535776][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
[    0.536795][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfffff window]
[    0.537800][    T1] pci_bus 0000:00: root bus resource [mem 0x840000000-=
0x8bfffffff window]
[    0.538604][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.539395][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
 conventional PCI endpoint
[    0.540872][    T1] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100=
 conventional PCI endpoint
[    0.542118][    T1] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180=
 conventional PCI endpoint
[    0.543277][    T1] pci 0000:00:01.1: BAR 4 [io  0xc080-0xc08f]
[    0.543943][    T1] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy =
IDE quirk
[    0.544771][    T1] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE qui=
rk
[    0.545508][    T1] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy =
IDE quirk
[    0.546336][    T1] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE qui=
rk
[    0.546851][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint
[    0.548030][    T1] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed=
 by PIIX4 ACPI
[    0.548909][    T1] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed=
 by PIIX4 SMB
[    0.549901][    T1] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000=
 conventional PCI endpoint
[    0.552272][    T1] pci 0000:00:02.0: BAR 0 [mem 0xfd000000-0xfdffffff p=
ref]
[    0.553087][    T1] pci 0000:00:02.0: BAR 2 [mem 0xfebb0000-0xfebb0fff]
[    0.553826][    T1] pci 0000:00:02.0: ROM [mem 0xfeba0000-0xfebaffff pre=
f]
[    0.554661][    T1] pci 0000:00:02.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    0.556120][    T1] pci 0000:00:03.0: [1af4:1009] type 00 class 0x000200=
 conventional PCI endpoint
[    0.558030][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
[    0.558608][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfebb1000-0xfebb1fff]
[    0.559336][    T1] pci 0000:00:03.0: BAR 4 [mem 0xfe000000-0xfe003fff 6=
4bit pref]
[    0.560668][    T1] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000=
 conventional PCI endpoint
[    0.562089][    T1] pci 0000:00:04.0: BAR 0 [mem 0xfebb2000-0xfebb200f]
[    0.563749][    T1] pci 0000:00:05.0: [8086:100e] type 00 class 0x020000=
 conventional PCI endpoint
[    0.570628][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfeb80000-0xfeb9ffff]
[    0.572860][    T1] pci 0000:00:05.0: BAR 1 [io  0xc040-0xc07f]
[    0.574685][    T1] pci 0000:00:05.0: ROM [mem 0xfeb00000-0xfeb7ffff pre=
f]
[    0.580362][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.582704][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.584424][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.585963][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.587014][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.588800][    T1] iommu: Default domain type: Translated
[    0.590019][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.593878][    T1] SCSI subsystem initialized
[    0.594601][    T1] libata version 3.00 loaded.
[    0.594601][    T1] ACPI: bus type USB registered
[    0.594601][    T1] usbcore: registered new interface driver usbfs
[    0.594849][    T1] usbcore: registered new interface driver hub
[    0.595779][    T1] usbcore: registered new device driver usb
[    0.596678][    T1] pps_core: LinuxPPS API ver. 1 registered
[    0.597615][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    0.598969][    T1] PTP clock support registered
[    0.604415][    T1] Advanced Linux Sound Architecture Driver Initialized=
.
[    0.604415][    T1] PCI: Using ACPI for IRQ routing
[    0.604415][    T1] PCI: pci_cache_line_size set to 64 bytes
[    0.604415][    T1] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.605035][    T1] e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
[    0.605930][    T1] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.606601][    T1] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.606601][    T1] pci 0000:00:02.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.610604][    T1] vgaarb: loaded
[    0.612161][    T1] clocksource: Switched to clocksource kvm-clock
[    0.673620][    T1] VFS: Disk quotas dquot_6.6.0
[    0.675245][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
[    0.678166][    T1] pnp: PnP ACPI init
[    0.679712][    T1] pnp 00:02: [dma 2]
[    0.681522][    T1] pnp: PnP ACPI: found 6 devices
[    0.689204][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
[    0.691533][    T1] NET: Registered PF_INET protocol family
[    0.693168][    T1] IP idents hash table entries: 262144 (order: 9, 2097=
152 bytes, linear)
[    0.697185][    T1] tcp_listen_portaddr_hash hash table entries: 16384 (=
order: 6, 262144 bytes, linear)
[    0.698702][    T1] Table-perturb hash table entries: 65536 (order: 6, 2=
62144 bytes, linear)
[    0.700045][    T1] TCP established hash table entries: 262144 (order: 9=
, 2097152 bytes, linear)
[    0.701946][    T1] TCP bind hash table entries: 65536 (order: 9, 209715=
2 bytes, linear)
[    0.703594][    T1] TCP: Hash tables configured (established 262144 bind=
 65536)
[    0.704465][    T1] UDP hash table entries: 16384 (order: 8, 1048576 byt=
es, linear)
[    0.705606][    T1] UDP-Lite hash table entries: 16384 (order: 8, 104857=
6 bytes, linear)
[    0.706621][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.707525][    T1] RPC: Registered named UNIX socket transport module.
[    0.708276][    T1] RPC: Registered udp transport module.
[    0.708890][    T1] RPC: Registered tcp transport module.
[    0.709519][    T1] RPC: Registered tcp-with-tls transport module.
[    0.710212][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.
[    0.711009][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
[    0.711753][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]
[    0.712509][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]
[    0.713377][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfff=
ff window]
[    0.714221][    T1] pci_bus 0000:00: resource 8 [mem 0x840000000-0x8bfff=
ffff window]
[    0.715104][    T1] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.715824][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.716578][    T1] PCI: CLS 0 bytes, default 64
[    0.717121][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    0.717289][   T11] Trying to unpack rootfs image as initramfs...
[    0.717720][    T1] software IO TLB: mapped [mem 0x00000000ae15e000-0x00=
000000b215e000] (64MB)
[    0.717990][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.723010][    T1] Initialise system trusted keyrings
[    0.723943][    T1] workingset: timestamp_bits=3D40 max_order=3D23 bucke=
t_order=3D0
[    0.725086][    T1] NFS: Registering the id_resolver key type
[    0.725726][    T1] Key type id_resolver registered
[    0.726274][    T1] Key type id_legacy registered
[    0.726808][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[    0.727642][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[    0.728849][    T1] Key type cifs.idmap registered
[    0.729408][    T1] 9p: Installing v9fs 9p2000 file system support
[    0.738955][    T1] Key type asymmetric registered
[    0.739506][    T1] Asymmetric key parser 'x509' registered
[    0.740147][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 249)
[    0.741025][    T1] io scheduler mq-deadline registered
[    0.741627][    T1] io scheduler kyber registered
[    0.744802][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[    0.745877][    T1] ACPI: button: Power Button [PWRF]
[    0.746835][    T1] ERST DBG: ERST support is disabled.
[    0.756290][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[    0.757243][    T1] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    0.758594][    T1] Non-volatile memory driver v1.3
[    0.762270][    T1] loop: module loaded
[    0.762743][    T1] rdac: device handler registered
[    0.763400][    T1] hp_sw: device handler registered
[    0.763968][    T1] emc: device handler registered
[    0.764674][    T1] alua: device handler registered
[    0.766376][    T1] scsi host0: ata_piix
[    0.766977][    T1] scsi host1: ata_piix
[    0.767489][    T1] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0=
80 irq 14 lpm-pol 0
[    0.768414][    T1] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0=
88 irq 15 lpm-pol 0
[    0.769446][    T1] MACsec IEEE 802.1AE
[    0.772044][    T1] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
[    0.773857][    T1] e100: Intel(R) PRO/100 Network Driver
[    0.774481][    T1] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.775179][    T1] e1000: Intel(R) PRO/1000 Network Driver
[    0.775804][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.786772][    T1] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    0.932273][  T692] ata2: found unknown device (class 0)
[    0.941346][  T692] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    0.942905][   T32] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-RO=
M     2.5+ PQ: 0 ANSI: 5
[    1.101597][    T1] e1000 0000:00:05.0 eth0: (PCI:33MHz:32-bit) 52:54:00=
:12:34:56
[    1.102756][    T1] e1000 0000:00:05.0 eth0: Intel(R) PRO/1000 Network C=
onnection
[    1.103925][    T1] e1000e: Intel(R) PRO/1000 Network Driver
[    1.104759][    T1] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.105764][    T1] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.106659][    T1] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.107841][    T1] Intel(R) 2.5G Ethernet Linux Driver
[    1.108619][    T1] Copyright(c) 2018 Intel Corporation.
[    1.109377][    T1] igbvf: Intel(R) Gigabit Virtual Function Network Dri=
ver
[    1.110135][    T1] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.110873][    T1] ixgbe: Intel(R) 10 Gigabit PCI Express Network Drive=
r
[    1.111616][    T1] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    1.112370][    T1] i40e: Intel(R) Ethernet Connection XL710 Network Dri=
ver
[    1.113151][    T1] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[    1.113898][    T1] jme: JMicron JMC2XX ethernet driver version 1.0.8
[    1.114619][    T1] sky2: driver version 1.30
[    1.115130][    T1] myri10ge: Version 1.5.3-1.534
[    1.115681][    T1] ns83820.c: National Semiconductor DP83820 10/100/100=
0 driver.
[    1.116552][    T1] QLogic 1/10 GbE Converged/Intelligent Ethernet Drive=
r v5.3.66
[    1.117397][    T1] QLogic/NetXen Network Driver v4.0.82
[    1.118423][    T1] tehuti: Tehuti Networks(R) Network Driver, 7.29.3
[    1.119144][    T1] tehuti: Options: hw_csum
[    1.119651][    T1] tlan: ThunderLAN driver v1.17
[    1.120211][    T1] tlan: 0 devices installed, PCI: 0  EISA: 0
[    1.120929][    T1] PPP generic driver version 2.4.2
[    1.121773][    T1] PPP BSD Compression module registered
[    1.122384][    T1] PPP Deflate Compression module registered
[    1.123031][    T1] PPP MPPE Compression module registered
[    1.123658][    T1] NET: Registered PF_PPPOX protocol family
[    1.124313][    T1] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channel=
s, max=3D256) (6 bit encapsulation enabled).
[    1.125447][    T1] SLIP linefill/keepalive option.
[    1.126037][    T1] usbcore: registered new interface driver catc
[    1.126722][    T1] usbcore: registered new interface driver kaweth
[    1.127409][    T1] pegasus: Pegasus/Pegasus II USB Ethernet driver
[    1.128105][    T1] usbcore: registered new interface driver pegasus
[    1.128831][    T1] usbcore: registered new interface driver rtl8150
[    1.129551][    T1] usbcore: registered new interface driver asix
[    1.130227][    T1] usbcore: registered new interface driver ax88179_178=
a
[    1.130971][    T1] usbcore: registered new interface driver cdc_ether
[    1.131689][    T1] usbcore: registered new interface driver cdc_eem
[    1.132388][    T1] usbcore: registered new interface driver dm9601
[    1.133294][    T1] usbcore: registered new interface driver smsc75xx
[    1.134028][    T1] usbcore: registered new interface driver smsc95xx
[    1.134740][    T1] usbcore: registered new interface driver gl620a
[    1.135439][    T1] usbcore: registered new interface driver net1080
[    1.136139][    T1] usbcore: registered new interface driver plusb
[    1.136825][    T1] usbcore: registered new interface driver rndis_host
[    1.137550][    T1] usbcore: registered new interface driver cdc_subset
[    1.138287][    T1] usbcore: registered new interface driver zaurus
[    1.138978][    T1] usbcore: registered new interface driver MOSCHIP usb=
-ethernet driver
[    1.139873][    T1] usbcore: registered new interface driver int51x1
[    1.140579][    T1] usbcore: registered new interface driver kalmia
[    1.141294][    T1] usbcore: registered new interface driver ipheth
[    1.141973][    T1] usbcore: registered new interface driver sierra_net
[    1.142671][    T1] usbcore: registered new interface driver cx82310_eth
[    1.143395][    T1] usbcore: registered new interface driver cdc_ncm
[    1.144083][    T1] usbcore: registered new interface driver lg-vl600
[    1.144772][    T1] usbcore: registered new interface driver r8153_ecm
[    1.149512][    T1] aoe: AoE v85 initialised.
[    1.150095][    T1] usbcore: registered new interface driver cdc_acm
[    1.150788][    T1] cdc_acm: USB Abstract Control Model driver for USB m=
odems and ISDN adapters
[    1.151753][    T1] usbcore: registered new interface driver cdc_wdm
[    1.152464][    T1] usbcore: registered new interface driver usb-storage
[    1.153215][    T1] usbcore: registered new interface driver ums-alauda
[    1.153959][    T1] usbcore: registered new interface driver ums-cypress
[    1.154690][    T1] usbcore: registered new interface driver ums-datafab
[    1.155427][    T1] usbcore: registered new interface driver ums_eneub62=
50
[    1.156167][    T1] usbcore: registered new interface driver ums-freecom
[    1.156899][    T1] usbcore: registered new interface driver ums-isd200
[    1.157637][    T1] usbcore: registered new interface driver ums-jumpsho=
t
[    1.158375][    T1] usbcore: registered new interface driver ums-karma
[    1.159102][    T1] usbcore: registered new interface driver ums-onetouc=
h
[    1.159850][    T1] usbcore: registered new interface driver ums-realtek
[    1.160584][    T1] usbcore: registered new interface driver ums-sddr09
[    1.161316][    T1] usbcore: registered new interface driver ums-sddr55
[    1.162055][    T1] usbcore: registered new interface driver ums-usbat
[    1.162805][    T1] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU=
] at 0x60,0x64 irq 1,12
[    1.164260][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.164893][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.165626][    T1] mousedev: PS/2 mouse device common for all mice
[    1.166474][   T41] input: AT Translated Set 2 keyboard as /devices/plat=
form/i8042/serio0/input/input1
[    1.167656][    T1] rtc_cmos 00:05: RTC can wake from S4
[    1.169101][    T1] rtc_cmos 00:05: registered as rtc0
[    1.169731][    T1] rtc_cmos 00:05: setting system clock to 2026-02-02T1=
3:59:37 UTC (1770040777)
[    1.170741][    T1] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes=
 nvram, hpet irqs
[    1.171772][    T1] intel_pstate: CPU model not supported
[    1.172560][    T1] hid: raw HID events driver (C) Jiri Kosina
[    1.173273][    T1] usbcore: registered new interface driver usbhid
[    1.173947][    T1] usbhid: USB HID core driver
[    1.175056][    T1] NET: Registered PF_PACKET protocol family
[    1.175765][    T1] 9pnet: Installing 9P2000 support
[    1.176324][    T1] Key type dns_resolver registered
[    1.177657][    T1] IPI shorthand broadcast: enabled
[    1.178227][    C0] ... APIC ID:      00000000 (0)
[    1.178799][    C0] ... APIC VERSION: 00050014
[    1.179309][    C0] 0000000000000000000000000000000000000000000000000000=
000000000000
[    1.180182][    C0] 0000000000000000000000000000000000000000000000000000=
000000000000
[    1.181067][    C0] 0000000000000000000000000000000000000000000000000000=
000000000000
[    1.181478][    C0]
[    1.182239][    T1] number of MP IRQ sources: 15.
[    1.182782][    T1] number of IO-APIC #0 registers: 24.
[    1.183364][    T1] testing the IO APIC.......................
[    1.184004][    T1] IO APIC #0......
[    1.184503][    T1] .... register #00: 00000000
[    1.185026][    T1] .......    : physical APIC id: 00
[    1.185606][    T1] .......    : Delivery Type: 0
[    1.186149][    T1] .......    : LTS          : 0
[    1.186678][    T1] .... register #01: 00170011
[    1.187192][    T1] .......     : max redirection entries: 17
[    1.187831][    T1] .......     : PRQ implemented: 0
[    1.188394][    T1] .......     : IO APIC version: 11
[    1.188969][    T1] .... register #02: 00000000
[    1.189501][    T1] .......     : arbitration: 00
[    1.190041][    T1] .... IRQ redirection table:
[    1.190555][    T1] IOAPIC 0:
[    1.190929][    T1]  pin00, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.191889][    T1]  pin01, enabled , edge , high, V(22), IRR(0), S(0), =
physical, D(0001), M(0)
[    1.192862][    T1]  pin02, enabled , edge , high, V(30), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.193835][    T1]  pin03, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.194800][    T1]  pin04, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.195760][    T1]  pin05, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.196723][    T1]  pin06, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.197704][    T1]  pin07, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.198665][    T1]  pin08, enabled , edge , high, V(22), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.199623][    T1]  pin09, enabled , level, high, V(20), IRR(0), S(0), =
physical, D(0001), M(0)
[    1.200617][    T1]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.203496][    T1]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.204471][    T1]  pin0c, enabled , edge , high, V(21), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.205442][    T1]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.206379][    T1]  pin0e, enabled , edge , high, V(20), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.207313][    T1]  pin0f, enabled , edge , high, V(21), IRR(0), S(0), =
physical, D(0001), M(0)
[    1.208239][    T1]  pin10, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.209177][    T1]  pin11, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.210138][    T1]  pin12, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.211089][    T1]  pin13, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.212051][    T1]  pin14, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.213005][    T1]  pin15, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.213975][    T1]  pin16, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.214930][    T1]  pin17, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.215865][    T1] IRQ to pin mappings:
[    1.216318][    T1] IRQ0 -> 0:2
[    1.216700][    T1] IRQ1 -> 0:1
[    1.217076][    T1] IRQ3 -> 0:3
[    1.217460][    T1] IRQ4 -> 0:4
[    1.217848][    T1] IRQ5 -> 0:5
[    1.218226][    T1] IRQ6 -> 0:6
[    1.218599][    T1] IRQ7 -> 0:7
[    1.218978][    T1] IRQ8 -> 0:8
[    1.219359][    T1] IRQ9 -> 0:9
[    1.219738][    T1] IRQ10 -> 0:10
[    1.220137][    T1] IRQ11 -> 0:11
[    1.220539][    T1] IRQ12 -> 0:12
[    1.220938][    T1] IRQ13 -> 0:13
[    1.221335][    T1] IRQ14 -> 0:14
[    1.221743][    T1] IRQ15 -> 0:15
[    1.222139][    T1] .................................... done.
[    1.226941][    T1] sched_clock: Marking stable (1168002013, 57475960)->=
(1230977136, -5499163)
[    1.229766][    T1] registered taskstats version 1
[    1.230359][    T1] Loading compiled-in X.509 certificates
[    1.232293][    T1] Demotion targets for Node 0: null
[    1.232901][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[    1.261410][    T1] Key type .fscrypt registered
[    1.262000][    T1] Key type fscrypt-provisioning registered
[    1.262808][    T1] netconsole: network logging started
[    1.631577][   T41] input: ImExPS/2 Generic Explorer Mouse as /devices/p=
latform/i8042/serio1/input/input3
[    1.642081][   T41] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Fl=
ow Control: RX
[    1.661530][    T1] Sending DHCP requests .
[    2.116982][   T11] Freeing initrd memory: 227848K
[    2.641652][    T1] , OK
[    2.651011][    T1] IP-Config: Got DHCP answer from 10.0.2.2, my address=
 is 10.0.2.15
[    2.653792][    T1] IP-Config: Complete:
[    2.655205][    T1]      device=3Deth0, hwaddr=3D52:54:00:12:34:56, ipad=
dr=3D10.0.2.15, mask=3D255.255.255.0, gw=3D10.0.2.2
[    2.658702][    T1]      host=3D10.0.2.15, domain=3D, nis-domain=3D(none=
)
[    2.660876][    T1]      bootserver=3D10.0.2.2, rootserver=3D10.0.2.2, r=
ootpath=3D
[    2.660880][    T1]      nameserver0=3D10.0.2.3
[    2.664936][    T1] clk: Disabling unused clocks
[    2.666094][    T1] ALSA device list:
[    2.667014][    T1]   No soundcards found.
[    2.671849][    T1] Freeing unused kernel image (initmem) memory: 3364K
[    2.673331][    T1] Write protecting the kernel read-only data: 28672k
[    2.675414][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 948K
[    2.677047][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1280K
[    2.678198][    T1] Run /init as init process
[    2.678803][    T1]   with arguments:
[    2.679323][    T1]     /init
[    2.679757][    T1]   with environment:
[    2.680286][    T1]     HOME=3D/
[    2.680747][    T1]     TERM=3Dlinux
[    2.681256][    T1]     RESULT_ROOT=3D/result/trinity/group-00-5-300s/vm=
-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07=
eb2969f429a66ad331fe2b3b6f/0
[    2.683190][    T1]     branch=3Dinternal-devel/devel-hourly-20260124-05=
0739
[    2.684075][    T1]     job=3D/lkp/jobs/scheduled/vm-meta-17/trinity-gro=
up-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-=
19zhjsh-2.yaml
[    2.685675][    T1]     user=3Dlkp
[    2.686017][    T1]     ARCH=3Dx86_64
[    2.686392][    T1]     kconfig=3Dx86_64-kexec
[    2.686826][    T1]     commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6=
f
[    2.687460][    T1]     ia32_emulation=3Don
[    2.687870][    T1]     max_uptime=3D7200
[    2.688262][    T1]     LKP_LOCAL_RUN=3D1
[    2.688658][    T1]     selinux=3D0
[    2.689003][    T1]     nmi_watchdog=3Dpanic
[    2.689428][    T1]     prompt_ramdisk=3D0
[    2.689826][    T1]     vga=3Dnormal
[    2.690197][    T1]     result_service=3D9p/virtfs_mount
INIT: version 2.88 booting
[    2.706824][ T1549] /dev/root: Can't lookup blockdev
[    2.707381][ T1549] /dev/root: Can't lookup blockdev
[    2.707896][ T1549] /dev/root: Can't lookup blockdev
[    2.708414][ T1549] /dev/root: Can't lookup blockdev
Starting udev
[    2.727678][ T1560] udevd[1560]: starting version 3.2.7
[    3.733523][    C0] random: crng init done
[    3.735162][ T1560] udevd[1560]: specified group 'kvm' unknown
[    3.736379][ T1561] udevd[1561]: starting eudev-3.2.7
[    3.759264][ T1561] udevd[1561]: specified group 'kvm' unknown
[    3.802990][ T1569] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/fo=
rm2 tray
[    3.804791][ T1569] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.841799][ T1569] sr 1:0:0:0: Attached scsi CD-ROM sr0
INIT: Entering runlevel: 5
Configuring network interfaces... ip: RTNETLINK answers: File exists
Starting syslogd/klogd: done
/etc/rc5.d/S77lkp-bootstrap: /lkp/jobs/scheduled/vm-meta-17/trinity-group-0=
0-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-19zh=
jsh-2.sh: line 126: start: not found
PATH=3D/sbin:/usr/sbin:/bin:/usr/bin:/lkp/lkp/src/bin
export VM_VIRTFS=3D1 due to result service 9p/virtfs_mount
[    4.546745][ T1797] redirect stdout and stderr directly
LKP: ttyS0: 1744: Kernel tests: Boot OK!
LKP: ttyS0: 1744: HOSTNAME vm-snb, MAC ce:68:d9:55:0f:a7, kernel 6.19.0-rc1=
-00006-g313c47f4fe4d 1
LKP: ttyS0: 1744:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-17/=
trinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-2026=
0126-53110-19zhjsh-2.yaml
[    4.582001][ T1910] 9p: Could not find request transport: virtio
[    4.597808][ T1980] process 'src/bin/event/wakeup' started with executab=
le stack
INIT: Id "S1" respawning too fast: disabled for 5 minutes

Poky (Yocto Project Reference Distro) 2.7+snapshot vm-snb /dev/ttyS0

vm-snb login: [    5.547047][ T1798] mount: mounting 9p/virtfs_mount on //r=
esult/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_=
64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 failed: Invali=
d argument
[   16.799071][ T5087] UDPLite: UDP-Lite is deprecated and scheduled to be =
removed in 2025, please contact the netdev mailing list
[   16.801107][ T5087] trinity-main uses obsolete (PF_INET,SOCK_PACKET)
[   16.830562][ T5173] Loading iSCSI transport class v2.0-870.
[   16.865286][ T5216] can: controller area network core
[   16.865990][ T5216] NET: Registered PF_CAN protocol family
[   16.868837][ T5217] CAN device driver interface
[   16.870020][ T5217] can: raw protocol
[   16.871397][ T5218] can: broadcast manager protocol
[   16.900769][ T5087] NOTICE: Automounting of tracing to debugfs is deprec=
ated and will be removed in 2030
[   16.936202][ T5284] Invalid ELF header magic: !=3D ELF
[   16.939236][ T5286] Invalid ELF header magic: !=3D ELF
[   17.907791][ T5262] Invalid ELF header magic: !=3D ELF
[   17.913348][ T5269] raw_sendmsg: trinity-c7 forgot to set AF_INET. Fix i=
t!
[   17.919074][ T5269] Invalid ELF header magic: !=3D ELF
[   17.934038][ T5285] Invalid ELF header magic: !=3D ELF
[   17.952884][ T5290] Invalid ELF header magic: !=3D ELF
[   17.954525][ T5290] Invalid ELF header magic: !=3D ELF
[   18.062149][ T5283] Invalid ELF header magic: !=3D ELF
[   18.063723][ T5283] Zero length message leads to an empty skb
[   18.923608][ T5269] Invalid ELF header magic: !=3D ELF
[   19.932497][ T5262] Invalid ELF header magic: !=3D ELF
[   19.935000][ T5262] Invalid ELF header magic: !=3D ELF
[   19.940608][ T5262] Invalid ELF header magic: !=3D ELF
[   19.971579][ T5290] Invalid ELF header magic: !=3D ELF
[   20.924566][ T5263] Invalid ELF header magic: !=3D ELF
[   20.939475][ T5269] Invalid ELF header magic: !=3D ELF
[   20.941000][ T5269] Invalid ELF header magic: !=3D ELF
[   20.946010][ T5263] Invalid ELF header magic: !=3D ELF
[   20.948842][ T5298] Invalid ELF header magic: !=3D ELF
[   20.959459][ T5302] Invalid ELF header magic: !=3D ELF
[   20.962874][ T5297] Invalid ELF header magic: !=3D ELF
[   20.965109][ T5297] Invalid ELF header magic: !=3D ELF
[   20.965807][ T5297] Invalid ELF header magic: !=3D ELF
[   20.967361][ T5302] Invalid ELF header magic: !=3D ELF
[   21.097128][ T5283] Invalid ELF header magic: !=3D ELF
[   21.101221][ T5283] Invalid ELF header magic: !=3D ELF
[   21.955505][ T5284] Invalid ELF header magic: !=3D ELF
[   21.970691][ T5297] Invalid ELF header magic: !=3D ELF
[   21.986261][ T5306] Invalid ELF header magic: !=3D ELF
[   21.987797][ T5306] Invalid ELF header magic: !=3D ELF
[   22.996302][ T5269] Invalid ELF header magic: !=3D ELF
[   23.147234][ T5283] Invalid ELF header magic: !=3D ELF
[   23.953718][ T5262] Invalid ELF header magic: !=3D ELF
[   24.021682][ T5262] Invalid ELF header magic: !=3D ELF
[   24.039381][ T5290] Invalid ELF header magic: !=3D ELF
[   24.155303][ T5283] Invalid ELF header magic: !=3D ELF
[   24.157447][ T5283] Invalid ELF header magic: !=3D ELF
[   24.160642][ T5283] Invalid ELF header magic: !=3D ELF
[   24.164616][ T5283] Invalid ELF header magic: !=3D ELF
[   24.169884][ T5283] Invalid ELF header magic: !=3D ELF
[   25.257089][ T5316] Invalid ELF header magic: !=3D ELF
[   25.556574][ T1798] /lkp/lkp/src/monitors/meminfo: line 45: date: not fo=
und
[   25.556574][ T1798] /lkp/lkp/src/monitors/meminfo: line 46: cat: not fou=
nd
[   25.556574][ T1798] /lkp/lkp/src/monitors/meminfo: line 25: /lkp/lkp/src=
/bin/event/wait: not found
[   26.009083][ T5269] Invalid ELF header magic: !=3D ELF
[   26.013796][ T5269] Invalid ELF header magic: !=3D ELF
[   26.016090][ T5302] Invalid ELF header magic: !=3D ELF
[   26.020689][ T5302] Invalid ELF header magic: !=3D ELF
[   26.084126][ T5306] Invalid ELF header magic: !=3D ELF
[   27.040204][ T5269] Invalid ELF header magic: !=3D ELF
[   27.092837][ T5290] Invalid ELF header magic: !=3D ELF
[   27.144209][ T5306] Invalid ELF header magic: !=3D ELF
[   27.158496][ T5306] Invalid ELF header magic: !=3D ELF
[   27.160797][ T5306] Invalid ELF header magic: !=3D ELF
[   27.569977][ T1798] /lkp/lkp/src/monitors/oom-killer: line 94: dmesg: no=
t found
[   27.569977][ T1798] /lkp/lkp/src/monitors/oom-killer: line 94: grep: not=
 found
[   27.569977][ T1798] /lkp/lkp/src/monitors/oom-killer: line 25: /lkp/lkp/=
src/bin/event/wait: not found
[   28.012488][ T5263] Invalid ELF header magic: !=3D ELF
[   28.020803][ T5263] Invalid ELF header magic: !=3D ELF
[   28.026680][ T5263] Invalid ELF header magic: !=3D ELF
[   28.049996][ T5320] Invalid ELF header magic: !=3D ELF
[   28.127646][ T5321] Invalid ELF header magic: !=3D ELF
[   29.045650][ T5302] Invalid ELF header magic: !=3D ELF
[   29.048577][ T5262] Invalid ELF header magic: !=3D ELF
[   29.054828][ T5320] Invalid ELF header magic: !=3D ELF
[   29.058082][ T5320] Invalid ELF header magic: !=3D ELF
[   29.169582][ T5306] Invalid ELF header magic: !=3D ELF
[   30.059353][ T5322] Invalid ELF header magic: !=3D ELF
[   30.067533][ T5322] Invalid ELF header magic: !=3D ELF
[   30.137799][ T5321] Invalid ELF header magic: !=3D ELF
[   30.144101][ T5321] Invalid ELF header magic: !=3D ELF
[   30.189678][ T5306] Invalid ELF header magic: !=3D ELF
[   30.305978][ T5316] Invalid ELF header magic: !=3D ELF
[   30.309799][ T5316] Invalid ELF header magic: !=3D ELF
[   31.072663][ T5322] Invalid ELF header magic: !=3D ELF
[   31.081355][ T5320] Invalid ELF header magic: !=3D ELF
[   31.211846][ T5306] Invalid ELF header magic: !=3D ELF
[   32.074614][ T5263] Invalid ELF header magic: !=3D ELF
[   32.077790][ T5263] Invalid ELF header magic: !=3D ELF
[   32.079049][ T5263] Invalid ELF header magic: !=3D ELF
[   32.100538][ T5262] Invalid ELF header magic: !=3D ELF
[   32.103459][ T5320] Invalid ELF header magic: !=3D ELF
[   33.090219][ T5322] Invalid ELF header magic: !=3D ELF
[   33.156536][ T5321] Invalid ELF header magic: !=3D ELF
[   34.057746][ T5323] Invalid ELF header magic: !=3D ELF
[   34.222260][ T5306] Invalid ELF header magic: !=3D ELF
[   35.060372][ T5323] Invalid ELF header magic: !=3D ELF
[   35.093733][ T5322] Invalid ELF header magic: !=3D ELF
[   35.100462][ T5322] Invalid ELF header magic: !=3D ELF
[   35.109288][ T5320] Invalid ELF header magic: !=3D ELF
[   35.111687][ T5324] Invalid ELF header magic: !=3D ELF
[   35.227139][ T5306] Invalid ELF header magic: !=3D ELF
[   36.126358][ T5325] Invalid ELF header magic: !=3D ELF
[   36.229974][ T5306] Invalid ELF header magic: !=3D ELF
[   36.230932][ T5306] Invalid ELF header magic: !=3D ELF
[   36.231660][ T5306] Invalid ELF header magic: !=3D ELF
[   38.168575][ T5321] Invalid ELF header magic: !=3D ELF
[   39.126368][ T5320] Invalid ELF header magic: !=3D ELF
[   39.150290][ T5263] Invalid ELF header magic: !=3D ELF
[   39.152270][ T5325] Invalid ELF header magic: !=3D ELF
[   39.152830][ T5325] Invalid ELF header magic: !=3D ELF
[   40.162387][ T5325] Invalid ELF header magic: !=3D ELF
[   40.165657][ T5325] Invalid ELF header magic: !=3D ELF
[   40.174809][ T5263] Invalid ELF header magic: !=3D ELF
[   41.182994][ T5321] Invalid ELF header magic: !=3D ELF
[   41.203045][ T5329] Invalid ELF header magic: !=3D ELF
[   42.058246][ T5325] Invalid ELF header magic: !=3D ELF
[   42.059380][ T5325] Invalid ELF header magic: !=3D ELF
[   42.066113][ T5325] Invalid ELF header magic: !=3D ELF
[   42.210127][ T5329] Invalid ELF header magic: !=3D ELF
[   43.073810][ T5325] Invalid ELF header magic: !=3D ELF
[   43.148946][ T5328] Invalid ELF header magic: !=3D ELF
[   43.192374][ T5321] Invalid ELF header magic: !=3D ELF
[   43.199122][ T5321] Invalid ELF header magic: !=3D ELF
[   43.211915][ T5329] Invalid ELF header magic: !=3D ELF
[   44.170655][ T5327] Invalid ELF header magic: !=3D ELF
[   44.220880][ T5330] Invalid ELF header magic: !=3D ELF
[   44.321324][ T5326] Invalid ELF header magic: !=3D ELF
[   45.082183][ T5325] Invalid ELF header magic: !=3D ELF
[   45.229898][ T5321] Invalid ELF header magic: !=3D ELF
[   45.231042][ T5321] Invalid ELF header magic: !=3D ELF
[   46.421830][ T5331] Invalid ELF header magic: !=3D ELF
[   47.084258][ T5325] Invalid ELF header magic: !=3D ELF
[   47.175216][ T5332] Invalid ELF header magic: !=3D ELF
[   47.178225][ T5327] Invalid ELF header magic: !=3D ELF
[   48.176976][ T5332] Invalid ELF header magic: !=3D ELF
[   48.254305][ T5321] Invalid ELF header magic: !=3D ELF
[   49.182596][ T5327] Invalid ELF header magic: !=3D ELF
[   49.183143][ T5327] Invalid ELF header magic: !=3D ELF
[   49.199024][ T5327] Invalid ELF header magic: !=3D ELF
[   49.254173][ T5330] Invalid ELF header magic: !=3D ELF
[   49.279851][ T5321] Invalid ELF header magic: !=3D ELF
[   49.280521][ T5321] Invalid ELF header magic: !=3D ELF
[   49.286593][ T5321] Invalid ELF header magic: !=3D ELF
[   50.194329][ T5333] Invalid ELF header magic: !=3D ELF
[   50.194979][ T5333] Invalid ELF header magic: !=3D ELF
[   50.220417][ T5333] Invalid ELF header magic: !=3D ELF
[   50.439746][ T5331] Invalid ELF header magic: !=3D ELF
[   51.320188][ T5337] Invalid ELF header magic: !=3D ELF
[   51.448366][ T5331] Invalid ELF header magic: !=3D ELF
[   52.238007][ T5339] Invalid ELF header magic: !=3D ELF
[   53.091581][ T5339] Invalid ELF header magic: !=3D ELF
[   53.097848][ T5339] Invalid ELF header magic: !=3D ELF
[   53.099502][ T5339] Invalid ELF header magic: !=3D ELF
[   53.482300][ T5331] Invalid ELF header magic: !=3D ELF
[   53.483254][ T5331] Invalid ELF header magic: !=3D ELF
[   54.270193][ T5330] Invalid ELF header magic: !=3D ELF
[   54.272082][ T5330] Invalid ELF header magic: !=3D ELF
[   55.107871][ T5339] Invalid ELF header magic: !=3D ELF
[   55.484549][ T5331] Invalid ELF header magic: !=3D ELF
[   55.485181][ T5331] Invalid ELF header magic: !=3D ELF
[   56.220306][ T5340] Invalid ELF header magic: !=3D ELF
[   56.279239][ T5330] Invalid ELF header magic: !=3D ELF
[   56.370266][ T5338] Invalid ELF header magic: !=3D ELF
[   57.063981][ T5339] Invalid ELF header magic: !=3D ELF
[   57.226318][ T5340] Invalid ELF header magic: !=3D ELF
[   58.084732][ T5341] Invalid ELF header magic: !=3D ELF
[   58.090737][ T5341] Invalid ELF header magic: !=3D ELF
[   58.091419][ T5341] Invalid ELF header magic: !=3D ELF
[   58.092189][ T5341] Invalid ELF header magic: !=3D ELF
[   58.093415][ T5341] Invalid ELF header magic: !=3D ELF
[   58.286266][ T5330] Invalid ELF header magic: !=3D ELF
[   58.493307][ T5331] Invalid ELF header magic: !=3D ELF
[   59.254750][ T5333] Invalid ELF header magic: !=3D ELF
[   59.287051][ T5330] Invalid ELF header magic: !=3D ELF
[   59.298173][ T5343] Invalid ELF header magic: !=3D ELF
[   59.315281][ T5343] Invalid ELF header magic: !=3D ELF
[   59.315927][ T5343] Invalid ELF header magic: !=3D ELF
[   59.403672][ T5338] Invalid ELF header magic: !=3D ELF
[   60.405385][ T5338] Invalid ELF header magic: !=3D ELF
[   61.146259][ T5342] Invalid ELF header magic: !=3D ELF
[   61.195438][ T5345] Invalid ELF header magic: !=3D ELF
[   61.199237][ T5346] Invalid ELF header magic: !=3D ELF
[   61.200254][ T5346] Invalid ELF header magic: !=3D ELF
[   61.242566][ T5340] Invalid ELF header magic: !=3D ELF
[   61.510912][ T5344] Invalid ELF header magic: !=3D ELF
[   62.208793][ T5346] Invalid ELF header magic: !=3D ELF
[   62.244519][ T5340] Invalid ELF header magic: !=3D ELF
[   62.280069][ T5347] Invalid ELF header magic: !=3D ELF
[   62.285950][ T5347] Invalid ELF header magic: !=3D ELF
[   62.297388][ T5347] Invalid ELF header magic: !=3D ELF
[   62.330105][ T5343] Invalid ELF header magic: !=3D ELF
[   63.416336][ T5338] Invalid ELF header magic: !=3D ELF
[   63.422616][ T5338] Invalid ELF header magic: !=3D ELF
[   63.423217][ T5338] Invalid ELF header magic: !=3D ELF
[   63.424301][ T5338] Invalid ELF header magic: !=3D ELF
[   64.253943][ T5348] Invalid ELF header magic: !=3D ELF
[   65.230366][ T5346] Invalid ELF header magic: !=3D ELF
[   65.233395][ T5346] Invalid ELF header magic: !=3D ELF
[   65.260100][ T5333] Invalid ELF header magic: !=3D ELF
[   65.435690][ T5338] Invalid ELF header magic: !=3D ELF
[   65.442281][ T5338] Invalid ELF header magic: !=3D ELF
[   66.264479][ T5333] Invalid ELF header magic: !=3D ELF
[   66.282102][ T5348] Invalid ELF header magic: !=3D ELF
[   66.308783][ T5348] Invalid ELF header magic: !=3D ELF
[   66.313904][ T5348] Invalid ELF header magic: !=3D ELF
[   66.354782][ T5343] Invalid ELF header magic: !=3D ELF
[   66.356346][ T5343] Invalid ELF header magic: !=3D ELF
[   67.445782][ T5338] Invalid ELF header magic: !=3D ELF
[   67.451375][ T5338] Invalid ELF header magic: !=3D ELF
[   68.286387][ T5349] Invalid ELF header magic: !=3D ELF
[   68.335387][ T5350] Invalid ELF header magic: !=3D ELF
[   68.338206][ T5350] Invalid ELF header magic: !=3D ELF
[   68.535761][ T5344] Invalid ELF header magic: !=3D ELF
[   69.333770][ T5353] Invalid ELF header magic: !=3D ELF
[   69.378232][ T5347] Invalid ELF header magic: !=3D ELF
[   70.293608][ T5349] Invalid ELF header magic: !=3D ELF
[   70.294323][ T5349] Invalid ELF header magic: !=3D ELF
[   70.384330][ T5347] Invalid ELF header magic: !=3D ELF
[   70.612764][ T5352] Invalid ELF header magic: !=3D ELF
[   71.296617][ T5349] Invalid ELF header magic: !=3D ELF
[   71.297121][ T5349] Invalid ELF header magic: !=3D ELF
[   71.623098][ T5352] Invalid ELF header magic: !=3D ELF
[   72.303379][ T5349] Invalid ELF header magic: !=3D ELF
[   72.309750][ T5349] Invalid ELF header magic: !=3D ELF
[   72.417090][ T5347] Invalid ELF header magic: !=3D ELF
[   72.627427][ T5352] Invalid ELF header magic: !=3D ELF
[   72.629309][ T5352] Invalid ELF header magic: !=3D ELF
[   74.323954][ T5349] Invalid ELF header magic: !=3D ELF
[   74.382244][ T5353] Invalid ELF header magic: !=3D ELF
[   74.384265][ T5354] Invalid ELF header magic: !=3D ELF
[   75.394581][ T5354] Invalid ELF header magic: !=3D ELF
[   75.569792][ T5356] Invalid ELF header magic: !=3D ELF
[   75.659361][ T5355] Invalid ELF header magic: !=3D ELF
[   76.370410][ T5350] Invalid ELF header magic: !=3D ELF
[   76.416470][ T5359] Invalid ELF header magic: !=3D ELF
[   76.418249][ T5359] Invalid ELF header magic: !=3D ELF
[   76.869124][ T5349] Invalid ELF header magic: !=3D ELF
[   77.394402][ T5353] Invalid ELF header magic: !=3D ELF
[   77.395676][ T5353] Invalid ELF header magic: !=3D ELF
[   77.432829][ T5347] Invalid ELF header magic: !=3D ELF
[   77.599261][ T5356] Invalid ELF header magic: !=3D ELF
[   77.678894][ T5355] Invalid ELF header magic: !=3D ELF
[   79.409217][ T5353] Invalid ELF header magic: !=3D ELF
[   79.418691][ T5353] Invalid ELF header magic: !=3D ELF
[   79.428272][ T5360] Invalid ELF header magic: !=3D ELF
[   79.449534][ T5359] Invalid ELF header magic: !=3D ELF
[   80.058269][ T5349] Invalid ELF header magic: !=3D ELF
[   80.393443][ T5350] Invalid ELF header magic: !=3D ELF
[   80.457575][ T5359] Invalid ELF header magic: !=3D ELF
[   80.463688][ T5359] Invalid ELF header magic: !=3D ELF
[   80.464488][ T5359] Invalid ELF header magic: !=3D ELF
[   80.491610][ T5361] Invalid ELF header magic: !=3D ELF
[   80.603683][ T5356] Invalid ELF header magic: !=3D ELF
[   81.433486][ T5350] Invalid ELF header magic: !=3D ELF
[   81.451583][ T5347] Invalid ELF header magic: !=3D ELF
[   82.456720][ T5347] Invalid ELF header magic: !=3D ELF
[   82.470899][ T5347] Invalid ELF header magic: !=3D ELF
[   82.490344][ T5359] Invalid ELF header magic: !=3D ELF
[   82.531296][ T5364] Invalid ELF header magic: !=3D ELF
[   83.540140][ T5364] Invalid ELF header magic: !=3D ELF
[   83.545502][ T5364] Invalid ELF header magic: !=3D ELF
[   83.629244][ T5356] Invalid ELF header magic: !=3D ELF
[   84.524214][ T5365] Invalid ELF header magic: !=3D ELF
[   84.529702][ T5365] Invalid ELF header magic: !=3D ELF
[   84.530237][ T5365] Invalid ELF header magic: !=3D ELF
[   85.715067][ T5355] Invalid ELF header magic: !=3D ELF
[   86.451506][ T5363] Invalid ELF header magic: !=3D ELF
[   86.544741][ T5362] Invalid ELF header magic: !=3D ELF
[   86.550359][ T5366] Invalid ELF header magic: !=3D ELF
[   86.552773][ T5366] Invalid ELF header magic: !=3D ELF
[   86.556978][ T5366] Invalid ELF header magic: !=3D ELF
[   86.574051][ T5366] Invalid ELF header magic: !=3D ELF
[   86.574904][ T5366] Invalid ELF header magic: !=3D ELF
[   87.070308][ T5349] Invalid ELF header magic: !=3D ELF
[   87.126776][ T5349] Invalid ELF header magic: !=3D ELF
[   87.127442][ T5349] scsi_nl_rcv_msg: discarding partial skb
[   88.460810][ T5363] Invalid ELF header magic: !=3D ELF
[   88.462566][ T5363] Invalid ELF header magic: !=3D ELF
[   88.554883][ T5362] Invalid ELF header magic: !=3D ELF
[   88.556693][ T5362] Invalid ELF header magic: !=3D ELF
[   88.559829][ T5362] Invalid ELF header magic: !=3D ELF
[   88.734485][ T5355] Invalid ELF header magic: !=3D ELF
[   89.588064][ T5366] Invalid ELF header magic: !=3D ELF
[   89.591926][ T5366] Invalid ELF header magic: !=3D ELF
[   89.596505][ T5366] Invalid ELF header magic: !=3D ELF
[   90.466241][ T5363] Invalid ELF header magic: !=3D ELF
[   90.587716][ T5368] Invalid ELF header magic: !=3D ELF
[   90.780954][ T5355] Invalid ELF header magic: !=3D ELF
[   90.783317][ T5355] Invalid ELF header magic: !=3D ELF
[   91.475466][ T5363] Invalid ELF header magic: !=3D ELF
[   91.480938][ T5363] Invalid ELF header magic: !=3D ELF
[   91.484755][ T5363] Invalid ELF header magic: !=3D ELF
[   91.601949][ T5366] Invalid ELF header magic: !=3D ELF
[   91.790332][ T5355] Invalid ELF header magic: !=3D ELF
[   92.070498][ T5367] Invalid ELF header magic: !=3D ELF
[   92.555074][ T5364] Invalid ELF header magic: !=3D ELF
[   93.557215][ T5364] Invalid ELF header magic: !=3D ELF
[   93.602353][ T5364] Invalid ELF header magic: !=3D ELF
[   93.603930][ T5368] Invalid ELF header magic: !=3D ELF
[   93.604014][ T5364] Invalid ELF header magic: !=3D ELF
[   93.609616][ T5364] Invalid ELF header magic: !=3D ELF
[   93.611300][ T5364] Invalid ELF header magic: !=3D ELF
[   93.677024][ T5356] Invalid ELF header magic: !=3D ELF
[   94.061817][ T5363] Invalid ELF header magic: !=3D ELF
[   94.091525][ T5367] Invalid ELF header magic: !=3D ELF
[   94.612666][ T5364] Invalid ELF header magic: !=3D ELF
[   94.652196][ T5368] Invalid ELF header magic: !=3D ELF
[   94.653322][ T5368] Invalid ELF header magic: !=3D ELF
[   94.654800][ T5368] Invalid ELF header magic: !=3D ELF
[   95.069654][ T5363] Invalid ELF header magic: !=3D ELF
[   95.075925][ T5363] Invalid ELF header magic: !=3D ELF
[   95.110447][ T5369] Invalid ELF header magic: !=3D ELF
[   95.613558][ T5364] Invalid ELF header magic: !=3D ELF
[   95.614479][ T5364] Invalid ELF header magic: !=3D ELF
[   95.615119][ T5364] Invalid ELF header magic: !=3D ELF
[   95.657829][ T5368] Invalid ELF header magic: !=3D ELF
[   95.664809][ T5368] Invalid ELF header magic: !=3D ELF
[   95.773033][ T5371] Invalid ELF header magic: !=3D ELF
[   96.777226][ T5371] Invalid ELF header magic: !=3D ELF
[   96.787305][ T5371] Invalid ELF header magic: !=3D ELF
[   97.091757][ T5363] Invalid ELF header magic: !=3D ELF
[   97.093391][ T5363] Invalid ELF header magic: !=3D ELF
[   97.646917][ T5366] Invalid ELF header magic: !=3D ELF
[   97.671833][ T5368] Invalid ELF header magic: !=3D ELF
[   97.674225][ T5368] Invalid ELF header magic: !=3D ELF
[   98.680131][ T5368] Invalid ELF header magic: !=3D ELF
[   98.681609][ T5368] Invalid ELF header magic: !=3D ELF
[   98.682619][ T5368] Invalid ELF header magic: !=3D ELF
[   98.824300][ T5371] Invalid ELF header magic: !=3D ELF
[   99.104732][ T5363] Invalid ELF header magic: !=3D ELF
[   99.679506][ T5366] Invalid ELF header magic: !=3D ELF
[   99.690132][ T5364] Invalid ELF header magic: !=3D ELF
[   99.692871][ T5368] Invalid ELF header magic: !=3D ELF
[   99.828139][ T5371] Invalid ELF header magic: !=3D ELF
[   99.833284][ T5373] Invalid ELF header magic: !=3D ELF
[   99.837973][ T5373] Invalid ELF header magic: !=3D ELF
[  100.702071][ T5368] Invalid ELF header magic: !=3D ELF
[  100.708307][ T5372] Invalid ELF header magic: !=3D ELF
[  100.714681][ T5372] Invalid ELF header magic: !=3D ELF
[  100.901901][ T5374] Invalid ELF header magic: !=3D ELF
[  101.111989][ T5363] Invalid ELF header magic: !=3D ELF
[  101.116901][ T5375] Invalid ELF header magic: !=3D ELF
[  101.196105][ T5369] Invalid ELF header magic: !=3D ELF
[  101.198004][ T5369] Invalid ELF header magic: !=3D ELF
[  101.697017][ T5364] Invalid ELF header magic: !=3D ELF
[  101.705128][ T5368] Invalid ELF header magic: !=3D ELF
[  101.713157][ T5376] Invalid ELF header magic: !=3D ELF
[  101.714896][ T5376] Invalid ELF header magic: !=3D ELF
[  101.720676][ T5376] Invalid ELF header magic: !=3D ELF
[  101.904376][ T5374] Invalid ELF header magic: !=3D ELF
[  101.919922][ T5377] Invalid ELF header magic: !=3D ELF
[  101.920874][ T5377] Invalid ELF header magic: !=3D ELF
[  101.923472][ T5377] Invalid ELF header magic: !=3D ELF
[  103.126147][ T5375] Invalid ELF header magic: !=3D ELF
[  103.733832][ T5376] Invalid ELF header magic: !=3D ELF
[  103.743303][ T5376] Invalid ELF header magic: !=3D ELF
[  104.271782][ T5369] Invalid ELF header magic: !=3D ELF
[  104.274204][ T5369] Invalid ELF header magic: !=3D ELF
[  104.280877][ T5381] Invalid ELF header magic: !=3D ELF
[  104.284647][ T5381] Invalid ELF header magic: !=3D ELF
[  104.746076][ T5376] Invalid ELF header magic: !=3D ELF
[  104.754007][ T5376] Invalid ELF header magic: !=3D ELF
[  104.761606][ T5372] Invalid ELF header magic: !=3D ELF
[  104.818295][ T5372] Invalid ELF header magic: !=3D ELF
[  104.818997][ T5372] Invalid ELF header magic: !=3D ELF
[  104.942891][ T5377] Invalid ELF header magic: !=3D ELF
[  105.062636][ T5379] Invalid ELF header magic: !=3D ELF
[  105.144662][ T5380] Invalid ELF header magic: !=3D ELF
[  105.152537][ T5380] Invalid ELF header magic: !=3D ELF
[  105.321618][ T5381] Invalid ELF header magic: !=3D ELF
[  105.341608][ T5381] Invalid ELF header magic: !=3D ELF
[  105.774894][ T5376] Invalid ELF header magic: !=3D ELF
[  105.815404][ T5383] Invalid ELF header magic: !=3D ELF
[  105.955776][ T5377] Invalid ELF header magic: !=3D ELF
[  106.084502][ T5382] Invalid ELF header magic: !=3D ELF
[  106.783127][ T5376] Invalid ELF header magic: !=3D ELF
[  107.103339][ T5382] Invalid ELF header magic: !=3D ELF
[  107.105826][ T5382] Invalid ELF header magic: !=3D ELF
[  107.364754][ T5381] Invalid ELF header magic: !=3D ELF
[  108.066741][ T5372] Invalid ELF header magic: !=3D ELF
[  108.117070][ T5382] Invalid ELF header magic: !=3D ELF
[  108.129440][ T5382] Invalid ELF header magic: !=3D ELF
[  108.132315][ T5382] Invalid ELF header magic: !=3D ELF
[  108.443873][ T5371] Invalid ELF header magic: !=3D ELF
[  109.026462][ T5384] Invalid ELF header magic: !=3D ELF
[  109.028923][ T5384] Invalid ELF header magic: !=3D ELF
[  109.470907][ T5371] Invalid ELF header magic: !=3D ELF
[  109.792024][ T5376] Invalid ELF header magic: !=3D ELF
[  109.796303][ T5376] Invalid ELF header magic: !=3D ELF
[  109.798256][ T5376] Invalid ELF header magic: !=3D ELF
[  109.808122][ T5376] Invalid ELF header magic: !=3D ELF
[  110.474107][ T5371] Invalid ELF header magic: !=3D ELF
[  110.506244][ T5389] Invalid ELF header magic: !=3D ELF
[  110.510696][ T5390] Invalid ELF header magic: !=3D ELF
[  110.845095][ T5383] Invalid ELF header magic: !=3D ELF
[  110.847263][ T5383] Invalid ELF header magic: !=3D ELF
[  110.865836][ T5383] Invalid ELF header magic: !=3D ELF
[  110.871391][ T5392] Invalid ELF header magic: !=3D ELF
[  111.396576][ T5381] Invalid ELF header magic: !=3D ELF
[  111.519489][ T5390] Invalid ELF header magic: !=3D ELF
[  111.844607][ T5391] scsi_nl_rcv_msg: discarding partial skb
[  112.059122][ T5384] Invalid ELF header magic: !=3D ELF
[  112.061117][ T5391] Invalid ELF header magic: !=3D ELF
[  112.061203][ T5392] Invalid ELF header magic: !=3D ELF
[  112.066594][ T5392] Invalid ELF header magic: !=3D ELF
[  112.070081][ T5384] Invalid ELF header magic: !=3D ELF
[  112.205887][ T5386] Invalid ELF header magic: !=3D ELF
[  112.215016][ T5386] Invalid ELF header magic: !=3D ELF
[  113.066628][ T5391] Invalid ELF header magic: !=3D ELF
[  113.180965][ T5382] Invalid ELF header magic: !=3D ELF
[  113.221689][ T5386] Invalid ELF header magic: !=3D ELF
[  114.092095][ T5384] Invalid ELF header magic: !=3D ELF
[  114.185974][ T5382] Invalid ELF header magic: !=3D ELF
[  114.226964][ T5386] Invalid ELF header magic: !=3D ELF
[  114.230899][ T5386] Invalid ELF header magic: !=3D ELF
[  115.251034][ T5386] Invalid ELF header magic: !=3D ELF
[  116.064089][ T5392] Invalid ELF header magic: !=3D ELF
[  116.143723][ T5384] Invalid ELF header magic: !=3D ELF
[  117.129667][ T5385] Invalid ELF header magic: !=3D ELF
[  117.133106][ T5385] Invalid ELF header magic: !=3D ELF
[  119.082150][ T5391] Invalid ELF header magic: !=3D ELF
[  119.262264][ T5394] Invalid ELF header magic: !=3D ELF
[  119.270567][ T5394] Invalid ELF header magic: !=3D ELF
[  119.272298][ T5394] Invalid ELF header magic: !=3D ELF
[  119.295153][ T5386] Invalid ELF header magic: !=3D ELF
[  120.155866][ T5385] Invalid ELF header magic: !=3D ELF
[  120.157427][ T5385] Invalid ELF header magic: !=3D ELF
[  120.161666][ T5385] Invalid ELF header magic: !=3D ELF
[  120.582866][ T5390] Invalid ELF header magic: !=3D ELF
[  121.122000][ T5392] Invalid ELF header magic: !=3D ELF
[  121.139786][ T5395] Invalid ELF header magic: !=3D ELF
[  121.153155][ T5395] Invalid ELF header magic: !=3D ELF
[  121.166360][ T5385] Invalid ELF header magic: !=3D ELF
[  121.168360][ T5385] Invalid ELF header magic: !=3D ELF
[  121.216140][ T5384] Invalid ELF header magic: !=3D ELF
[  121.272109][ T5384] Invalid ELF header magic: !=3D ELF
[  121.285903][ T5394] Invalid ELF header magic: !=3D ELF
[  121.301643][ T5394] Invalid ELF header magic: !=3D ELF
[  121.310078][ T5394] Invalid ELF header magic: !=3D ELF
[  121.856240][ T5396] Invalid ELF header magic: !=3D ELF
[  122.452860][ T5381] Invalid ELF header magic: !=3D ELF
[  122.861270][ T5396] Invalid ELF header magic: !=3D ELF
[  123.318639][ T5384] Invalid ELF header magic: !=3D ELF
[  123.461300][ T5381] Invalid ELF header magic: !=3D ELF
[  124.098550][ T5391] Invalid ELF header magic: !=3D ELF
[  124.324346][ T5394] Invalid ELF header magic: !=3D ELF
[  125.256100][ T5385] Invalid ELF header magic: !=3D ELF
[  126.327074][ T5384] Invalid ELF header magic: !=3D ELF
[  126.356175][ T5400] Invalid ELF header magic: !=3D ELF
[  127.150708][ T5391] Invalid ELF header magic: !=3D ELF
[  127.159302][ T5391] Invalid ELF header magic: !=3D ELF
[  127.335518][ T5384] Invalid ELF header magic: !=3D ELF
[  127.340519][ T5384] Invalid ELF header magic: !=3D ELF
[  127.916623][ T5399] Invalid ELF header magic: !=3D ELF
[  127.927186][ T5399] Invalid ELF header magic: !=3D ELF
[  128.402774][ T5386] Invalid ELF header magic: !=3D ELF
[  129.188534][ T5395] Invalid ELF header magic: !=3D ELF
[  129.200032][ T5395] Invalid ELF header magic: !=3D ELF
[  129.217137][ T5395] Invalid ELF header magic: !=3D ELF
[  129.286822][ T5385] Invalid ELF header magic: !=3D ELF
[  129.394773][ T5384] Invalid ELF header magic: !=3D ELF
[  129.504391][ T5381] Invalid ELF header magic: !=3D ELF
[  129.558849][ T5381] Invalid ELF header magic: !=3D ELF
[  129.559977][ T5381] Invalid ELF header magic: !=3D ELF
[  129.934900][ T5399] Invalid ELF header magic: !=3D ELF
[  130.223301][ T5395] Invalid ELF header magic: !=3D ELF
[  130.294877][ T5385] Invalid ELF header magic: !=3D ELF
[  130.396663][ T5401] Invalid ELF header magic: !=3D ELF
[  130.398736][ T5401] Invalid ELF header magic: !=3D ELF
[  130.415913][ T5386] Invalid ELF header magic: !=3D ELF
[  130.417133][ T5386] Invalid ELF header magic: !=3D ELF
[  130.969277][ T5399] Invalid ELF header magic: !=3D ELF
[  131.408605][ T5384] Invalid ELF header magic: !=3D ELF
[  131.420610][ T5386] Invalid ELF header magic: !=3D ELF
[  131.421584][ T5402] Invalid ELF header magic: !=3D ELF
[  131.440288][ T5403] Invalid ELF header magic: !=3D ELF
[  132.236477][ T5395] Invalid ELF header magic: !=3D ELF
[  132.309862][ T5385] Invalid ELF header magic: !=3D ELF
[  132.425610][ T5402] Invalid ELF header magic: !=3D ELF
[  132.469122][ T5384] Invalid ELF header magic: !=3D ELF
[  132.988151][ T5399] Invalid ELF header magic: !=3D ELF
[  133.448691][ T5405] Invalid ELF header magic: !=3D ELF
[  133.453431][ T5405] Invalid ELF header magic: !=3D ELF
[  133.461021][ T5406] Invalid ELF header magic: !=3D ELF
[  133.475152][ T5384] Invalid ELF header magic: !=3D ELF
[  133.999525][ T5399] Invalid ELF header magic: !=3D ELF
[  134.217717][ T5391] Invalid ELF header magic: !=3D ELF
[  134.221695][ T5391] Invalid ELF header magic: !=3D ELF
[  134.223872][ T5391] Invalid ELF header magic: !=3D ELF
[  134.472573][ T5403] Invalid ELF header magic: !=3D ELF
[  134.478826][ T5384] Invalid ELF header magic: !=3D ELF
[  134.489923][ T5384] Invalid ELF header magic: !=3D ELF
[  135.003760][ T5399] Invalid ELF header magic: !=3D ELF
[  135.038173][ T5399] Invalid ELF header magic: !=3D ELF
[  135.479415][ T5406] Invalid ELF header magic: !=3D ELF
[  135.495427][ T5384] Invalid ELF header magic: !=3D ELF
[  136.372141][ T5404] Invalid ELF header magic: !=3D ELF
[  136.492249][ T5408] Invalid ELF header magic: !=3D ELF
[  136.493346][ T5406] Invalid ELF header magic: !=3D ELF
[  136.501198][ T5408] Invalid ELF header magic: !=3D ELF
[  136.554298][ T5384] Invalid ELF header magic: !=3D ELF
[  137.045814][ T5399] Invalid ELF header magic: !=3D ELF
[  137.388721][ T5404] Invalid ELF header magic: !=3D ELF
[  137.508877][ T5406] Invalid ELF header magic: !=3D ELF
[  137.520294][ T5406] Invalid ELF header magic: !=3D ELF
[  138.054192][ T5399] Invalid ELF header magic: !=3D ELF
[  138.073445][ T5399] Invalid ELF header magic: !=3D ELF
[  138.075319][ T5399] Invalid ELF header magic: !=3D ELF
[  138.331786][ T5407] Invalid ELF header magic: !=3D ELF
[  138.449714][ T5410] Invalid ELF header magic: !=3D ELF
[  138.511333][ T5408] Invalid ELF header magic: !=3D ELF
[  138.514089][ T5408] Invalid ELF header magic: !=3D ELF
[  138.595160][ T5384] Invalid ELF header magic: !=3D ELF
[  138.597348][ T5384] Invalid ELF header magic: !=3D ELF
[  139.397637][ T5407] Invalid ELF header magic: !=3D ELF
[  139.517731][ T5408] Invalid ELF header magic: !=3D ELF
[  140.082331][ T5399] Invalid ELF header magic: !=3D ELF
[  140.247981][ T5391] Invalid ELF header magic: !=3D ELF
[  140.402542][ T5407] Invalid ELF header magic: !=3D ELF
[  141.626626][ T5411] Invalid ELF header magic: !=3D ELF
[  141.870111][ T5412] Invalid ELF header magic: !=3D ELF
[  142.101305][ T5414] Invalid ELF header magic: !=3D ELF
[  142.110164][ T5415] Invalid ELF header magic: !=3D ELF
[  142.261381][ T5391] Invalid ELF header magic: !=3D ELF
[  142.536921][ T5408] Invalid ELF header magic: !=3D ELF
[  142.626048][ T5413] Invalid ELF header magic: !=3D ELF
[  142.626588][ T5413] Invalid ELF header magic: !=3D ELF
[  142.881364][ T5412] Invalid ELF header magic: !=3D ELF
[  142.886045][ T5412] Invalid ELF header magic: !=3D ELF
[  143.577373][ T5408] Invalid ELF header magic: !=3D ELF
[  143.579058][ T5408] Invalid ELF header magic: !=3D ELF
[  143.586933][ T5408] Invalid ELF header magic: !=3D ELF
[  143.903622][ T5412] Invalid ELF header magic: !=3D ELF
[  144.296701][ T5419] Invalid ELF header magic: !=3D ELF
[  144.635131][ T5412] Invalid ELF header magic: !=3D ELF
[  144.635735][ T5412] Invalid ELF header magic: !=3D ELF
[  146.303741][ T5419] Invalid ELF header magic: !=3D ELF
[  146.602149][ T5408] Invalid ELF header magic: !=3D ELF
[  146.603878][ T5408] Invalid ELF header magic: !=3D ELF
[  146.666234][ T5411] Invalid ELF header magic: !=3D ELF
[  147.135691][ T5420] Invalid ELF header magic: !=3D ELF
[  147.313229][ T5419] Invalid ELF header magic: !=3D ELF
[  147.326079][ T5419] Invalid ELF header magic: !=3D ELF
[  147.609001][ T5408] Invalid ELF header magic: !=3D ELF
[  148.709559][ T5411] Invalid ELF header magic: !=3D ELF
[  148.709881][ T5412] Invalid ELF header magic: !=3D ELF
[  148.713229][ T5412] Invalid ELF header magic: !=3D ELF
[  148.713954][ T5411] Invalid ELF header magic: !=3D ELF
[  148.715161][ T5411] Invalid ELF header magic: !=3D ELF
[  149.334741][ T5419] Invalid ELF header magic: !=3D ELF
[  149.666100][ T5422] Invalid ELF header magic: !=3D ELF
[  150.407037][ T5423] Invalid ELF header magic: !=3D ELF
[  150.409016][ T5423] Invalid ELF header magic: !=3D ELF
[  150.670830][ T5422] Invalid ELF header magic: !=3D ELF
[  150.680087][ T5417] Invalid ELF header magic: !=3D ELF
[  150.727825][ T5411] Invalid ELF header magic: !=3D ELF
[  150.735106][ T5411] Invalid ELF header magic: !=3D ELF
[  151.202852][ T5420] Invalid ELF header magic: !=3D ELF
[  151.682251][ T5417] Invalid ELF header magic: !=3D ELF
[  151.682782][ T5417] Invalid ELF header magic: !=3D ELF
[  151.756143][ T5411] Invalid ELF header magic: !=3D ELF
[  151.760312][ T5411] Invalid ELF header magic: !=3D ELF
[  152.464799][ T5423] Invalid ELF header magic: !=3D ELF
[  152.683639][ T5417] Invalid ELF header magic: !=3D ELF
[  152.684208][ T5417] Invalid ELF header magic: !=3D ELF
[  153.451516][ T5407] Invalid ELF header magic: !=3D ELF
[  153.687518][ T5417] Invalid ELF header magic: !=3D ELF
[  155.497650][ T5423] Invalid ELF header magic: !=3D ELF
[  155.739609][ T5422] Invalid ELF header magic: !=3D ELF
[  155.746295][ T5422] Invalid ELF header magic: !=3D ELF
[  156.060519][ T5417] Invalid ELF header magic: !=3D ELF
[  156.061268][ T5417] Invalid ELF header magic: !=3D ELF
[  156.065540][ T5417] Invalid ELF header magic: !=3D ELF
[  156.503665][ T5423] Invalid ELF header magic: !=3D ELF
[  156.750880][ T5422] Invalid ELF header magic: !=3D ELF
[  157.075294][ T5417] Invalid ELF header magic: !=3D ELF
[  157.075842][ T5417] Invalid ELF header magic: !=3D ELF
[  157.077367][ T5417] Invalid ELF header magic: !=3D ELF
[  157.500545][ T5407] Invalid ELF header magic: !=3D ELF
[  157.743448][ T5412] Invalid ELF header magic: !=3D ELF
[  157.744536][ T5412] Invalid ELF header magic: !=3D ELF
[  157.745056][ T5412] Invalid ELF header magic: !=3D ELF
[  157.758108][ T5412] Invalid ELF header magic: !=3D ELF
[  157.759611][ T5412] Invalid ELF header magic: !=3D ELF
[  158.326493][ T5411] Invalid ELF header magic: !=3D ELF
[  158.328481][ T5411] Invalid ELF header magic: !=3D ELF
[  158.518378][ T5423] Invalid ELF header magic: !=3D ELF
[  158.529654][ T5423] Invalid ELF header magic: !=3D ELF
[  158.541163][ T5407] Invalid ELF header magic: !=3D ELF
[  158.760828][ T5412] Invalid ELF header magic: !=3D ELF
[  158.761663][ T5412] Invalid ELF header magic: !=3D ELF
[  158.808675][ T5422] Invalid ELF header magic: !=3D ELF
[  159.340121][ T5411] Invalid ELF header magic: !=3D ELF
[  159.544330][ T5407] Invalid ELF header magic: !=3D ELF
[  160.103552][ T5417] Invalid ELF header magic: !=3D ELF
[  160.567804][ T5423] Invalid ELF header magic: !=3D ELF
[  160.837024][ T5422] Invalid ELF header magic: !=3D ELF
[  161.351821][ T5411] Invalid ELF header magic: !=3D ELF
[  162.112575][ T5417] Invalid ELF header magic: !=3D ELF
[  163.364626][ T5411] Invalid ELF header magic: !=3D ELF
[  163.583739][ T5407] Invalid ELF header magic: !=3D ELF
[  163.603252][ T5407] Invalid ELF header magic: !=3D ELF
[  163.855658][ T5422] Invalid ELF header magic: !=3D ELF
[  164.168326][ T5417] Invalid ELF header magic: !=3D ELF
[  164.279433][ T5426] Invalid ELF header magic: !=3D ELF
[  165.200987][ T5417] Invalid ELF header magic: !=3D ELF
[  165.206036][ T5417] Invalid ELF header magic: !=3D ELF
[  165.386147][ T5427] Invalid ELF header magic: !=3D ELF
[  165.625705][ T5407] Invalid ELF header magic: !=3D ELF
[  165.653230][ T5407] Invalid ELF header magic: !=3D ELF
[  165.796186][ T5425] Invalid ELF header magic: !=3D ELF
[  165.896885][ T5422] Invalid ELF header magic: !=3D ELF
[  166.249550][ T5417] Invalid ELF header magic: !=3D ELF
[  166.250460][ T5417] Invalid ELF header magic: !=3D ELF
[  166.251248][ T5417] Invalid ELF header magic: !=3D ELF
[  167.096497][ T5423] Invalid ELF header magic: !=3D ELF
[  167.287593][ T5426] Invalid ELF header magic: !=3D ELF
[  167.289893][ T5426] Invalid ELF header magic: !=3D ELF
[  167.419123][ T5427] Invalid ELF header magic: !=3D ELF
[  167.659826][ T5407] Invalid ELF header magic: !=3D ELF
[  167.826041][ T5425] Invalid ELF header magic: !=3D ELF
[  168.274404][ T5429] Invalid ELF header magic: !=3D ELF
[  168.421276][ T5427] Invalid ELF header magic: !=3D ELF
[  168.832079][ T5425] Invalid ELF header magic: !=3D ELF
[  169.316987][ T5426] Invalid ELF header magic: !=3D ELF
[  169.840511][ T5425] Invalid ELF header magic: !=3D ELF
[  170.123934][ T5423] Invalid ELF header magic: !=3D ELF
[  170.126574][ T5423] Invalid ELF header magic: !=3D ELF
[  170.148849][ T5423] Invalid ELF header magic: !=3D ELF
[  170.155947][ T5423] Invalid ELF header magic: !=3D ELF
[  170.320102][ T5426] Invalid ELF header magic: !=3D ELF
[  170.330776][ T5426] Invalid ELF header magic: !=3D ELF
[  170.931397][ T5422] Invalid ELF header magic: !=3D ELF
[  170.934356][ T5422] Invalid ELF header magic: !=3D ELF
[  170.940123][ T5422] Invalid ELF header magic: !=3D ELF
[  170.945203][ T5422] Invalid ELF header magic: !=3D ELF
[  170.946406][ T5422] Invalid ELF header magic: !=3D ELF
[  171.333298][ T5426] Invalid ELF header magic: !=3D ELF
[  171.984527][ T5431] Invalid ELF header magic: !=3D ELF
[  172.172182][ T5423] Invalid ELF header magic: !=3D ELF
[  172.322121][ T5087] trinity-main[5087]: segfault at 0 ip 000000000000000=
0 sp 00007ffce61d4518 error 15 likely on CPU 0 (core 0, socket 0)
[  172.325186][ T5087] Code: Unable to access opcode bytes at 0xfffffffffff=
fffd6.
/etc/rc5.d/S77lkp-bootstrap: line 79: sleep: not found


--csx8ktZH1zvSCQRU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="parent-7416634fd6f1-run.log"
Content-Transfer-Encoding: quoted-printable

$ sudo bin/lkp qemu -k vmlinuz-6.19.0-rc1-00005-g7416634fd6f1 -m modules-74=
16634fd6f1.cgz job-script
result_root: /home/xsang/.lkp//result/trinity/group-00-5-300s/vm-snb/yocto-=
x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a=
66ad331fe2b3b6f/3
downloading initrds ...
use local modules: /home/xsang/.lkp/cache/modules-7416634fd6f1.cgz
skip downloading /home/xsang/.lkp/cache/osimage/yocto/yocto-x86_64-minimal-=
20190520.cgz
19270 blocks
skip downloading /home/xsang/.lkp/cache/osimage/pkg/debian-x86_64-20180403.=
cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz
43381 blocks
exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev local,=
id=3Dtest_dev,path=3D/home/xsang/.lkp//result/trinity/group-00-5-300s/vm-sn=
b/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2=
969f429a66ad331fe2b3b6f/3,security_model=3Dnone -device virtio-9p-pci,fsdev=
=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel vmlinuz-6.19.0-rc1-00005-g7=
416634fd6f1 -append root=3D/dev/ram0 RESULT_ROOT=3D/result/trinity/group-00=
-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c=
47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/linux/x86_64-kexec=
/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/vmlinuz-6.19.0-rc1-00006=
-g313c47f4fe4d branch=3Dinternal-devel/devel-hourly-20260124-050739 job=3D/=
lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-300s-yocto-x86_64-minimal-=
20190520.cgz-313c47f4fe4d-20260126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx=
86_64 kconfig=3Dx86_64-kexec commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3=
b6f intremap=3Dposted_msi watchdog_thresh=3D240 rcuperf.shutdown=3D0 rcusca=
le.shutdown=3D0 refscale.shutdown=3D0 audit=3D0 kunit.enable=3D0 ia32_emula=
tion=3Don max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebu=
g sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0=
 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic o=
ops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 system=
d.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200=
 console=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddhcp result_service=3D9p/virt=
fs_mount -initrd /home/xsang/.lkp/cache/final_initrd -smp 2 -m 32768M -no-r=
eboot -device i6300esb -rtc base=3Dlocaltime -device e1000,netdev=3Dnet0 -n=
etdev user,id=3Dnet0 -display none -monitor null -serial stdio
early console in setup code
No EFI environment detected.
early console in extract_kernel
input_data: 0x00000000031ef2c4
input_len: 0x0000000000ce1ad3
output: 0x0000000001000000
output_len: 0x0000000002e81808
kernel_total_size: 0x0000000002c28000
needed_size: 0x0000000003000000
trampoline_32bit: 0x0000000000000000

Decompressing Linux... Parsing ELF... done.
Booting the kernel (entry_offset: 0x0000000002719030).
[    0.000000][    T0] Linux version 6.19.0-rc1-00005-g7416634fd6f1 (kbuild=
@2c8541ba7c67) (clang version 20.1.8 (git://gitmirror/llvm_project 87f0227c=
b60147a26a1eeb4fb06e3b505e9c7261), LLD 20.1.8 (git://gitmirror/llvm_project=
 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)) #1 SMP PREEMPT_DYNAMIC Mon Jan =
26 23:51:53 CET 2026
[    0.000000][    T0] Command line: root=3D/dev/ram0 RESULT_ROOT=3D/result=
/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-ke=
xec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/l=
inux/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/vmlinuz=
-6.19.0-rc1-00006-g313c47f4fe4d branch=3Dinternal-devel/devel-hourly-202601=
24-050739 job=3D/lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-300s-yoct=
o-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-19zhjsh-2.yaml us=
er=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-kexec commit=3D313c47f4fe4d07eb2969=
f429a66ad331fe2b3b6f intremap=3Dposted_msi watchdog_thresh=3D240 rcuperf.sh=
utdown=3D0 rcuscale.shutdown=3D0 refscale.shutdown=3D0 audit=3D0 kunit.enab=
le=3D0 ia32_emulation=3Don max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 =
debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D10=
0 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_w=
atchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor=
_count=3D8 systemd.log_level=3Derr ignore_loglevel console
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0]   Hygon HygonGenuine
[    0.000000][    T0]   Centaur CentaurHauls
[    0.000000][    T0]   zhaoxin   Shanghai
[    0.000000][    T0] x86/CPU: Model not found in latest microcode list
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbf=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009fff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000ffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdfff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000feffc000-0x00000000fefffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000fffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000083ffffff=
f] usable
[    0.000000][    T0] printk: debug: ignoring loglevel setting.
[    0.000000][    T0] printk: legacy bootconsole [earlyser0] enabled
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] APIC: Static calls initialized
[    0.000000][    T0] SMBIOS 2.8 present.
[    0.000000][    T0] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.=
15.0-1 04/01/2014
[    0.000000][    T0] DMI: Memory slots populated: 2/2
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] last_pfn =3D 0xbffe0 max_arch_pfn =3D 0x400000000
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000][    T0] kvm-clock: using sched offset of 338781263 cycles
[    0.000493][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max=
_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001956][    T0] tsc: Detected 3000.000 MHz processor
[    0.002992][    T0] e820: update [mem 0x00000000-0x00000fff] usable =3D=
=3D> reserved
[    0.003603][    T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.004117][    T0] last_pfn =3D 0x840000 max_arch_pfn =3D 0x400000000
[    0.004646][    T0] MTRR map: 4 entries (3 fixed + 1 variable; max 19), =
built from 8 variable MTRRs
[    0.005401][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP=
  UC- WT
[    0.006055][    T0] last_pfn =3D 0xbffe0 max_arch_pfn =3D 0x400000000
[    0.006552][    T0] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.007058][    T0] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.007569][    T0] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.012721][    T0] found SMP MP-table at [mem 0x000f5b90-0x000f5b9f]
[    0.013286][    T0]   mpc: f5ba0-f5c78
[    0.014064][    T0] RAMDISK: [mem 0xb215a000-0xbffdffff]
[    0.014519][    T0] ACPI: Early table checksum verification disabled
[    0.015065][    T0] ACPI: RSDP 0x00000000000F5970 000014 (v00 BOCHS )
[    0.015606][    T0] ACPI: RSDT 0x00000000BFFE196E 000034 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.016395][    T0] ACPI: FACP 0x00000000BFFE181A 000074 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.017175][    T0] ACPI: DSDT 0x00000000BFFE0040 0017DA (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.017963][    T0] ACPI: FACS 0x00000000BFFE0000 000040
[    0.018409][    T0] ACPI: APIC 0x00000000BFFE188E 000080 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.019173][    T0] ACPI: HPET 0x00000000BFFE190E 000038 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.019948][    T0] ACPI: WAET 0x00000000BFFE1946 000028 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.020727][    T0] ACPI: Reserving FACP table memory at [mem 0xbffe181a=
-0xbffe188d]
[    0.021378][    T0] ACPI: Reserving DSDT table memory at [mem 0xbffe0040=
-0xbffe1819]
[    0.022043][    T0] ACPI: Reserving FACS table memory at [mem 0xbffe0000=
-0xbffe003f]
[    0.022731][    T0] ACPI: Reserving APIC table memory at [mem 0xbffe188e=
-0xbffe190d]
[    0.023392][    T0] ACPI: Reserving HPET table memory at [mem 0xbffe190e=
-0xbffe1945]
[    0.024059][    T0] ACPI: Reserving WAET table memory at [mem 0xbffe1946=
-0xbffe196d]
[    0.024739][    T0] Mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.025459][    T0] No NUMA configuration found
[    0.025852][    T0] Faking a node at [mem 0x0000000000000000-0x000000083=
fffffff]
[    0.026499][    T0] NODE_DATA(0) allocated [mem 0x83ffe0380-0x83ffe4fff]
[    0.027082][    T0] cma: Reserved 200 MiB at 0x0000000100000000
[    0.101999][    T0] Zone ranges:
[    0.102315][    T0]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]
[    0.102861][    T0]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]
[    0.103409][    T0]   Normal   [mem 0x0000000100000000-0x000000083ffffff=
f]
[    0.103962][    T0]   Device   empty
[    0.104258][    T0] Movable zone start for each node
[    0.104682][    T0] Early memory node ranges
[    0.105035][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ef=
ff]
[    0.105564][    T0]   node   0: [mem 0x0000000000100000-0x00000000bffdff=
ff]
[    0.106134][    T0]   node   0: [mem 0x0000000100000000-0x000000083fffff=
ff]
[    0.106722][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
0083fffffff]
[    0.107370][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.107931][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.148403][    T0] On node 0, zone Normal: 32 pages in unavailable rang=
es
[    0.149266][    T0] ACPI: PM-Timer IO Port: 0x608
[    0.149682][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.150269][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23
[    0.150902][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl =
dfl)
[    0.151485][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID =
0, APIC INT 02
[    0.152144][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)
[    0.152757][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID =
0, APIC INT 05
[    0.153417][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)
[    0.154022][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID =
0, APIC INT 09
[    0.154673][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)
[    0.155298][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID =
0, APIC INT 0a
[    0.155951][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)
[    0.156578][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID =
0, APIC INT 0b
[    0.157236][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID =
0, APIC INT 01
[    0.157905][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID =
0, APIC INT 03
[    0.158549][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID =
0, APIC INT 04
[    0.159216][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID =
0, APIC INT 06
[    0.159875][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID =
0, APIC INT 07
[    0.160533][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID =
0, APIC INT 08
[    0.161193][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID =
0, APIC INT 0c
[    0.161858][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID =
0, APIC INT 0d
[    0.162523][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID =
0, APIC INT 0e
[    0.163187][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID =
0, APIC INT 0f
[    0.163859][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation
[    0.164458][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.164956][    T0] TSC deadline timer available
[    0.165354][    T0] CPU topo: Max. logical packages:   1
[    0.165797][    T0] CPU topo: Max. logical dies:       1
[    0.166244][    T0] CPU topo: Max. dies per package:   1
[    0.166689][    T0] CPU topo: Max. threads per core:   1
[    0.167141][    T0] CPU topo: Num. cores per package:     2
[    0.167623][    T0] CPU topo: Num. threads per package:   2
[    0.168089][    T0] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPU=
s
[    0.168657][    T0] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.169168][    T0] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_=
eoi_write()
[    0.169814][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
000000-0x00000fff]
[    0.170495][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
09f000-0x000fffff]
[    0.171176][    T0] PM: hibernation: Registered nosave memory: [mem 0xbf=
fe0000-0xffffffff]
[    0.171864][    T0] [mem 0xc0000000-0xfeffbfff] available for PCI device=
s
[    0.172429][    T0] Booting paravirtualized kernel on KVM
[    0.172874][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.178725][    T0] setup_percpu: NR_CPUS:512 nr_cpumask_bits:2 nr_cpu_i=
ds:2 nr_node_ids:1
[    0.179758][    T0] percpu: Embedded 55 pages/cpu s185240 r8192 d31848 u=
1048576
[    0.180384][    T0] pcpu-alloc: s185240 r8192 d31848 u1048576 alloc=3D1*=
2097152
[    0.180981][    T0] pcpu-alloc: [0] 0 1
[    0.181327][    T0] Kernel command line: root=3D/dev/ram0 RESULT_ROOT=3D=
/result/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x8=
6_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 BOOT_IMAGE=
=3D/pkg/linux/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6=
f/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d branch=3Dinternal-devel/devel-hour=
ly-20260124-050739 job=3D/lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-=
300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-19zhjsh-=
2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-kexec commit=3D313c47f4fe4=
d07eb2969f429a66ad331fe2b3b6f intremap=3Dposted_msi watchdog_thresh=3D240 r=
cuperf.shutdown=3D0 rcuscale.shutdown=3D0 refscale.shutdown=3D0 audit=3D0 k=
unit.enable=3D0 ia32_emulation=3Don max_uptime=3D7200 LKP_LOCAL_RUN=3D1 sel=
inux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_tim=
eout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=
=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 =
drbd.minor_count=3D8 systemd.log_level=3Derr \
[    0.188895][    T0] Kernel command line: ignore_loglevel console=3Dtty0 =
earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddhc=
p result_service=3D9p/virtfs_mount
[    0.190357][    T0] audit: disabled (until reboot)
[    0.190858][    T0] sysrq: sysrq always enabled.
[    0.191319][    T0] ignoring the deprecated load_ramdisk=3D option
[    0.191948][    T0] Unknown kernel command line parameters "RESULT_ROOT=
=3D/result/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz=
/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 branch=3D=
internal-devel/devel-hourly-20260124-050739 job=3D/lkp/jobs/scheduled/vm-me=
ta-17/trinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4=
d-20260126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-k=
exec commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6f ia32_emulation=3Don =
max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 nmi_watchdog=3Dpanic prompt=
_ramdisk=3D0 vga=3Dnormal result_service=3D9p/virtfs_mount", will be passed=
 to user space.
[    0.196865][    T0] printk: log buffer data + meta data: 1048576 + 36700=
16 =3D 4718592 bytes
[    0.202251][    T0] Dentry cache hash table entries: 4194304 (order: 13,=
 33554432 bytes, linear)
[    0.205376][    T0] Inode-cache hash table entries: 2097152 (order: 12, =
16777216 bytes, linear)
[    0.206240][    T0] software IO TLB: area num 2.
[    0.220213][    T0] Fallback order for Node 0: 0
[    0.220218][    T0] Built 1 zonelists, mobility grouping on.  Total page=
s: 8388478
[    0.221287][    T0] Policy zone: Normal
[    0.221589][    T0] mem auto-init: stack:all(zero), heap alloc:off, heap=
 free:off
[    0.300416][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPU=
s=3D2, Nodes=3D1
[    0.301069][    T0] Kernel/User page tables isolation: enabled
[    0.301838][    T0] ftrace: allocating 59363 entries in 232 pages
[    0.302371][    T0] ftrace: allocated 232 pages with 4 groups
[    0.303784][    T0] Dynamic Preempt: voluntary
[    0.304397][    T0] rcu: Preemptible hierarchical RCU implementation.
[    0.304933][    T0] rcu:     RCU restricting CPUs from NR_CPUS=3D512 to =
nr_cpu_ids=3D2.
[    0.305521][    T0]  RCU CPU stall warnings timeout set to 100 (rcu_cpu_=
stall_timeout).
[    0.306177][    T0]  Trampoline variant of Tasks RCU enabled.
[    0.306641][    T0]  Rude variant of Tasks RCU enabled.
[    0.307065][    T0]  Tracing variant of Tasks RCU enabled.
[    0.307521][    T0] rcu: RCU calculated value of scheduler-enlistment de=
lay is 25 jiffies.
[    0.308198][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr=
_cpu_ids=3D2
[    0.308807][    T0] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_=
cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    0.309576][    T0] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_=
task_cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    0.310373][    T0] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu=
_task_cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    0.314226][    T0] NR_IRQS: 33024, nr_irqs: 440, preallocated irqs: 16
[    0.315177][    T0] rcu: srcu_init: Setting srcu_struct sizes based on c=
ontention.
[    0.319360][    T0] Console: colour VGA+ 80x25
[    0.319721][    T0] printk: legacy console [tty0] enabled
[    0.352832][    T0] printk: legacy console [ttyS0] enabled
[    0.352832][    T0] printk: legacy console [ttyS0] enabled
[    0.353888][    T0] printk: legacy bootconsole [earlyser0] disabled
[    0.353888][    T0] printk: legacy bootconsole [earlyser0] disabled
[    0.355115][    T0] ACPI: Core revision 20250807
[    0.355724][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 19112604467 ns
[    0.356855][    T0] APIC: Switch to symmetric I/O mode setup
[    0.357639][    T0] x2apic enabled
[    0.358227][    T0] APIC: Switched APIC routing to: physical x2apic
[    0.358911][    T0] Masked ExtINT on CPU#0
[    0.359853][    T0] ENABLING IO-APIC IRQs
[    0.360313][    T0] Init IO_APIC IRQs
[    0.360735][    T0] apic 0 pin 0 not connected
[    0.361284][    T0] IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1=
 Level:0 ActiveLow:0)
[    0.362212][    T0] IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0=
 Level:0 ActiveLow:0)
[    0.363134][    T0] IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3=
 Level:0 ActiveLow:0)
[    0.364066][    T0] IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4=
 Level:0 ActiveLow:0)
[    0.364994][    T0] IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5=
 Level:1 ActiveLow:0)
[    0.365935][    T0] IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6=
 Level:0 ActiveLow:0)
[    0.366872][    T0] IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7=
 Level:0 ActiveLow:0)
[    0.367817][    T0] IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8=
 Level:0 ActiveLow:0)
[    0.368769][    T0] IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9=
 Level:1 ActiveLow:0)
[    0.369719][    T0] IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ =
10 Level:1 ActiveLow:0)
[    0.370669][    T0] IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ =
11 Level:1 ActiveLow:0)
[    0.371630][    T0] IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ =
12 Level:0 ActiveLow:0)
[    0.372581][    T0] IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ =
13 Level:0 ActiveLow:0)
[    0.373550][    T0] IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ =
14 Level:0 ActiveLow:0)
[    0.374501][    T0] IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ =
15 Level:0 ActiveLow:0)
[    0.375426][    T0] apic 0 pin 16 not connected
[    0.375924][    T0] apic 0 pin 17 not connected
[    0.376402][    T0] apic 0 pin 18 not connected
[    0.377098][    T0] apic 0 pin 19 not connected
[    0.378216][    T0] apic 0 pin 20 not connected
[    0.378723][    T0] apic 0 pin 21 not connected
[    0.379225][    T0] apic 0 pin 22 not connected
[    0.379728][    T0] apic 0 pin 23 not connected
[    0.380360][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1=
 pin2=3D-1
[    0.381143][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max=
_cycles: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.382335][    T0] Calibrating delay loop (skipped) preset value.. 6000=
.00 BogoMIPS (lpj=3D12000000)
[    0.383415][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.384073][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.384784][    T0] mitigations: Enabled attack vectors: user_kernel, us=
er_user, guest_host, guest_guest, SMT mitigations: auto
[    0.386595][    T0] Speculative Store Bypass: Vulnerable
[    0.387183][    T0] Spectre V2 : Mitigation: Retpolines
[    0.387762][    T0] ITS: Mitigation: Aligned branch/return thunks
[    0.388428][    T0] MDS: Vulnerable: Clear CPU buffers attempted, no mic=
rocode
[    0.389221][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers an=
d __user pointer sanitization
[    0.390550][    T0] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on=
 context switch and VMEXIT
[    0.391528][    T0] active return thunk: its_return_thunk
[    0.392139][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floati=
ng point registers'
[    0.393056][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regist=
ers'
[    0.394331][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regist=
ers'
[    0.395090][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  2=
56
[    0.395845][    T0] x86/fpu: Enabled xstate features 0x7, context size i=
s 832 bytes, using 'standard' format.
[    0.413115][    T0] Freeing SMP alternatives memory: 48K
[    0.413753][    T0] pid_max: default: 32768 minimum: 301
[    0.414385][    T0] Mount-cache hash table entries: 65536 (order: 7, 524=
288 bytes, linear)
[    0.415338][    T0] Mountpoint-cache hash table entries: 65536 (order: 7=
, 524288 bytes, linear)
[    0.416483][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (fam=
ily: 0x6, model: 0x2a, stepping: 0x1)
[    0.417877][    T1] Performance Events: unsupported CPU family 6 model 4=
2 no PMU driver, software events only.
[    0.418330][    T1] signal: max sigframe size: 1360
[    0.418330][    T1] rcu: Hierarchical SRCU implementation.
[    0.418330][    T1] rcu:     Max phase no-delay instances is 1000.
[    0.418509][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 1 crossnode level
[    0.422966][    T1] smp: Bringing up secondary CPUs ...
[    0.423644][    T1] smpboot: x86: Booting SMP configuration:
[    0.424280][    T1] .... node  #0, CPUs:      #1
[    0.066522][    T0] Masked ExtINT on CPU#1
[    0.428332][    T1] smp: Brought up 1 node, 2 CPUs
[    0.428332][    T1] smpboot: Total of 2 processors activated (12000.00 B=
ogoMIPS)
[    0.430794][    T1] Memory: 32429348K/33553912K available (19529K kernel=
 code, 5589K rwdata, 6912K rodata, 3364K init, 1652K bss, 913928K reserved,=
 204800K cma-reserved)
[    0.435615][    T1] devtmpfs: initialized
[    0.435615][    T1] x86/mm: Memory block size: 128MB
[    0.439088][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645041785100000 ns
[    0.439479][    T1] posixtimers hash table entries: 1024 (order: 2, 1638=
4 bytes, linear)
[    0.440379][    T1] futex hash table entries: 512 (32768 bytes on 1 NUMA=
 nodes, total 32 KiB, linear).
[    0.443234][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.444341][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    0.444343][    T1] thermal_sys: Registered thermal governor 'user_space=
'
[    0.445092][    T1] cpuidle: using governor ladder
[    0.446335][    T1] cpuidle: using governor menu
[    0.447305][    T1] PCI: Using configuration type 1 for base access
[    0.448301][    T1] kprobes: kprobe jump-optimization is enabled. All kp=
robes are optimized if possible.
[    0.508713][    T1] ACPI: Added _OSI(Module Device)
[    0.508713][    T1] ACPI: Added _OSI(Processor Device)
[    0.508713][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    0.509312][    T1] ACPI: 1 ACPI AML tables successfully acquired and lo=
aded
[    0.523103][    T1] ACPI: Interpreter enabled
[    0.523103][    T1] ACPI: PM: (supports S0 S3 S4 S5)
[    0.524200][    T1] ACPI: Using IOAPIC for interrupt routing
[    0.526290][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug
[    0.531217][    T1] PCI: Using E820 reservations for host bridge windows
[    0.533807][    T1] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.538513][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])
[    0.540294][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Seg=
ments MSI HPX-Type3]
[    0.542337][    T1] acpi PNP0A03:00: _OSC: not requesting OS control; OS=
 requires [ExtendedConfig ASPM ClockPM MSI]
[    0.544988][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, c=
an't access extended configuration space under this bridge
[    0.546882][    T1] PCI host bridge to bus 0000:00
[    0.547708][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]
[    0.548993][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
[    0.550265][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
[    0.554666][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfffff window]
[    0.556050][    T1] pci_bus 0000:00: root bus resource [mem 0x840000000-=
0x8bfffffff window]
[    0.557428][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.558376][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
 conventional PCI endpoint
[    0.560109][    T1] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100=
 conventional PCI endpoint
[    0.561415][    T1] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180=
 conventional PCI endpoint
[    0.562920][    T1] pci 0000:00:01.1: BAR 4 [io  0xc080-0xc08f]
[    0.563827][    T1] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy =
IDE quirk
[    0.565810][    T1] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE qui=
rk
[    0.566696][    T1] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy =
IDE quirk
[    0.568326][    T1] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE qui=
rk
[    0.569712][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint
[    0.571011][    T1] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed=
 by PIIX4 ACPI
[    0.572450][    T1] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed=
 by PIIX4 SMB
[    0.574098][    T1] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000=
 conventional PCI endpoint
[    0.577367][    T1] pci 0000:00:02.0: BAR 0 [mem 0xfd000000-0xfdffffff p=
ref]
[    0.582849][    T1] pci 0000:00:02.0: BAR 2 [mem 0xfebb0000-0xfebb0fff]
[    0.585231][    T1] pci 0000:00:02.0: ROM [mem 0xfeba0000-0xfebaffff pre=
f]
[    0.586976][    T1] pci 0000:00:02.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    0.590290][    T1] pci 0000:00:03.0: [1af4:1009] type 00 class 0x000200=
 conventional PCI endpoint
[    0.592744][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
[    0.593854][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfebb1000-0xfebb1fff]
[    0.594646][    T1] pci 0000:00:03.0: BAR 4 [mem 0xfe000000-0xfe003fff 6=
4bit pref]
[    0.597232][    T1] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000=
 conventional PCI endpoint
[    0.598978][    T1] pci 0000:00:04.0: BAR 0 [mem 0xfebb2000-0xfebb200f]
[    0.600166][    T1] pci 0000:00:05.0: [8086:100e] type 00 class 0x020000=
 conventional PCI endpoint
[    0.602128][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfeb80000-0xfeb9ffff]
[    0.602533][    T1] pci 0000:00:05.0: BAR 1 [io  0xc040-0xc07f]
[    0.603315][    T1] pci 0000:00:05.0: ROM [mem 0xfeb00000-0xfeb7ffff pre=
f]
[    0.605488][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.606403][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.607319][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.608160][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.608919][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.609812][    T1] iommu: Default domain type: Translated
[    0.610333][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.614903][    T1] SCSI subsystem initialized
[    0.615018][    T1] libata version 3.00 loaded.
[    0.615018][    T1] ACPI: bus type USB registered
[    0.615463][    T1] usbcore: registered new interface driver usbfs
[    0.616161][    T1] usbcore: registered new interface driver hub
[    0.616820][    T1] usbcore: registered new device driver usb
[    0.617467][    T1] pps_core: LinuxPPS API ver. 1 registered
[    0.618095][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    0.618573][    T1] PTP clock support registered
[    0.622379][    T1] Advanced Linux Sound Architecture Driver Initialized=
.
[    0.623365][    T1] PCI: Using ACPI for IRQ routing
[    0.623925][    T1] PCI: pci_cache_line_size set to 64 bytes
[    0.624630][    T1] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.625363][    T1] e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
[    0.626168][    T1] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.626330][    T1] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.626330][    T1] pci 0000:00:02.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.630342][    T1] vgaarb: loaded
[    0.634330][    T1] clocksource: Switched to clocksource kvm-clock
[    0.651683][    T1] VFS: Disk quotas dquot_6.6.0
[    0.653291][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
[    0.656204][    T1] pnp: PnP ACPI init
[    0.657729][    T1] pnp 00:02: [dma 2]
[    0.659792][    T1] pnp: PnP ACPI: found 6 devices
[    0.667822][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
[    0.670379][    T1] NET: Registered PF_INET protocol family
[    0.671859][    T1] IP idents hash table entries: 262144 (order: 9, 2097=
152 bytes, linear)
[    0.676849][    T1] tcp_listen_portaddr_hash hash table entries: 16384 (=
order: 6, 262144 bytes, linear)
[    0.678644][    T1] Table-perturb hash table entries: 65536 (order: 6, 2=
62144 bytes, linear)
[    0.680244][    T1] TCP established hash table entries: 262144 (order: 9=
, 2097152 bytes, linear)
[    0.681845][    T1] TCP bind hash table entries: 65536 (order: 9, 209715=
2 bytes, linear)
[    0.683350][    T1] TCP: Hash tables configured (established 262144 bind=
 65536)
[    0.684351][    T1] UDP hash table entries: 16384 (order: 8, 1048576 byt=
es, linear)
[    0.685669][    T1] UDP-Lite hash table entries: 16384 (order: 8, 104857=
6 bytes, linear)
[    0.686859][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.687836][    T1] RPC: Registered named UNIX socket transport module.
[    0.688687][    T1] RPC: Registered udp transport module.
[    0.689385][    T1] RPC: Registered tcp transport module.
[    0.690086][    T1] RPC: Registered tcp-with-tls transport module.
[    0.692154][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.
[    0.694500][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
[    0.696738][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]
[    0.698958][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]
[    0.701215][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfff=
ff window]
[    0.702988][    T1] pci_bus 0000:00: resource 8 [mem 0x840000000-0x8bfff=
ffff window]
[    0.704846][    T1] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.706312][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.707906][    T1] PCI: CLS 0 bytes, default 64
[    0.709039][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    0.709234][   T11] Trying to unpack rootfs image as initramfs...
[    0.710273][    T1] software IO TLB: mapped [mem 0x00000000ae15a000-0x00=
000000b215a000] (64MB)
[    0.714126][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.719046][    T1] Initialise system trusted keyrings
[    0.719907][    T1] workingset: timestamp_bits=3D40 max_order=3D23 bucke=
t_order=3D0
[    0.721367][    T1] NFS: Registering the id_resolver key type
[    0.722034][    T1] Key type id_resolver registered
[    0.722615][    T1] Key type id_legacy registered
[    0.723182][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[    0.724027][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[    0.730708][    T1] Key type cifs.idmap registered
[    0.732277][    T1] 9p: Installing v9fs 9p2000 file system support
[    0.754489][    T1] Key type asymmetric registered
[    0.755261][    T1] Asymmetric key parser 'x509' registered
[    0.756150][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 249)
[    0.757388][    T1] io scheduler mq-deadline registered
[    0.758206][    T1] io scheduler kyber registered
[    0.759535][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[    0.763208][    T1] ACPI: button: Power Button [PWRF]
[    0.764007][    T1] ERST DBG: ERST support is disabled.
[    0.774295][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[    0.775275][    T1] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    0.776871][    T1] Non-volatile memory driver v1.3
[    0.783141][    T1] loop: module loaded
[    0.783626][    T1] rdac: device handler registered
[    0.784287][    T1] hp_sw: device handler registered
[    0.784846][    T1] emc: device handler registered
[    0.785416][    T1] alua: device handler registered
[    0.787346][    T1] scsi host0: ata_piix
[    0.787914][    T1] scsi host1: ata_piix
[    0.788392][    T1] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0=
80 irq 14 lpm-pol 0
[    0.789331][    T1] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0=
88 irq 15 lpm-pol 0
[    0.790356][    T1] MACsec IEEE 802.1AE
[    0.793210][    T1] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
[    0.802642][    T1] e100: Intel(R) PRO/100 Network Driver
[    0.803264][    T1] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.803952][    T1] e1000: Intel(R) PRO/1000 Network Driver
[    0.804579][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.815554][    T1] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    0.947736][  T694] ata2: found unknown device (class 0)
[    0.950779][  T694] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    0.955162][  T189] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-RO=
M     2.5+ PQ: 0 ANSI: 5
[    1.127610][    T1] e1000 0000:00:05.0 eth0: (PCI:33MHz:32-bit) 52:54:00=
:12:34:56
[    1.129483][    T1] e1000 0000:00:05.0 eth0: Intel(R) PRO/1000 Network C=
onnection
[    1.130827][    T1] e1000e: Intel(R) PRO/1000 Network Driver
[    1.131734][    T1] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.132797][    T1] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.133773][    T1] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.134800][    T1] Intel(R) 2.5G Ethernet Linux Driver
[    1.135650][    T1] Copyright(c) 2018 Intel Corporation.
[    1.136520][    T1] igbvf: Intel(R) Gigabit Virtual Function Network Dri=
ver
[    1.137615][    T1] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.138683][    T1] ixgbe: Intel(R) 10 Gigabit PCI Express Network Drive=
r
[    1.139756][    T1] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    1.140611][    T1] i40e: Intel(R) Ethernet Connection XL710 Network Dri=
ver
[    1.141369][    T1] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[    1.142114][    T1] jme: JMicron JMC2XX ethernet driver version 1.0.8
[    1.142877][    T1] sky2: driver version 1.30
[    1.143631][    T1] myri10ge: Version 1.5.3-1.534
[    1.144207][    T1] ns83820.c: National Semiconductor DP83820 10/100/100=
0 driver.
[    1.145095][    T1] QLogic 1/10 GbE Converged/Intelligent Ethernet Drive=
r v5.3.66
[    1.145950][    T1] QLogic/NetXen Network Driver v4.0.82
[    1.146748][    T1] tehuti: Tehuti Networks(R) Network Driver, 7.29.3
[    1.147462][    T1] tehuti: Options: hw_csum
[    1.147968][    T1] tlan: ThunderLAN driver v1.17
[    1.148513][    T1] tlan: 0 devices installed, PCI: 0  EISA: 0
[    1.149189][    T1] PPP generic driver version 2.4.2
[    1.149879][    T1] PPP BSD Compression module registered
[    1.150501][    T1] PPP Deflate Compression module registered
[    1.151149][    T1] PPP MPPE Compression module registered
[    1.151769][    T1] NET: Registered PF_PPPOX protocol family
[    1.152405][    T1] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channel=
s, max=3D256) (6 bit encapsulation enabled).
[    1.153538][    T1] SLIP linefill/keepalive option.
[    1.154109][    T1] usbcore: registered new interface driver catc
[    1.154798][    T1] usbcore: registered new interface driver kaweth
[    1.155474][    T1] pegasus: Pegasus/Pegasus II USB Ethernet driver
[    1.156166][    T1] usbcore: registered new interface driver pegasus
[    1.156863][    T1] usbcore: registered new interface driver rtl8150
[    1.157558][    T1] usbcore: registered new interface driver asix
[    1.158245][    T1] usbcore: registered new interface driver ax88179_178=
a
[    1.159003][    T1] usbcore: registered new interface driver cdc_ether
[    1.159718][    T1] usbcore: registered new interface driver cdc_eem
[    1.160414][    T1] usbcore: registered new interface driver dm9601
[    1.161106][    T1] usbcore: registered new interface driver smsc75xx
[    1.161820][    T1] usbcore: registered new interface driver smsc95xx
[    1.162546][    T1] usbcore: registered new interface driver gl620a
[    1.163241][    T1] usbcore: registered new interface driver net1080
[    1.163936][    T1] usbcore: registered new interface driver plusb
[    1.164617][    T1] usbcore: registered new interface driver rndis_host
[    1.165339][    T1] usbcore: registered new interface driver cdc_subset
[    1.166064][    T1] usbcore: registered new interface driver zaurus
[    1.166767][    T1] usbcore: registered new interface driver MOSCHIP usb=
-ethernet driver
[    1.167665][    T1] usbcore: registered new interface driver int51x1
[    1.168368][    T1] usbcore: registered new interface driver kalmia
[    1.169056][    T1] usbcore: registered new interface driver ipheth
[    1.169749][    T1] usbcore: registered new interface driver sierra_net
[    1.170487][    T1] usbcore: registered new interface driver cx82310_eth
[    1.171235][    T1] usbcore: registered new interface driver cdc_ncm
[    1.171938][    T1] usbcore: registered new interface driver lg-vl600
[    1.172655][    T1] usbcore: registered new interface driver r8153_ecm
[    1.174538][    T1] aoe: AoE v85 initialised.
[    1.175171][    T1] usbcore: registered new interface driver cdc_acm
[    1.175882][    T1] cdc_acm: USB Abstract Control Model driver for USB m=
odems and ISDN adapters
[    1.176859][    T1] usbcore: registered new interface driver cdc_wdm
[    1.177591][    T1] usbcore: registered new interface driver usb-storage
[    1.178347][    T1] usbcore: registered new interface driver ums-alauda
[    1.179091][    T1] usbcore: registered new interface driver ums-cypress
[    1.179841][    T1] usbcore: registered new interface driver ums-datafab
[    1.180603][    T1] usbcore: registered new interface driver ums_eneub62=
50
[    1.181376][    T1] usbcore: registered new interface driver ums-freecom
[    1.182117][    T1] usbcore: registered new interface driver ums-isd200
[    1.182891][    T1] usbcore: registered new interface driver ums-jumpsho=
t
[    1.183647][    T1] usbcore: registered new interface driver ums-karma
[    1.184380][    T1] usbcore: registered new interface driver ums-onetouc=
h
[    1.185124][    T1] usbcore: registered new interface driver ums-realtek
[    1.185872][    T1] usbcore: registered new interface driver ums-sddr09
[    1.186617][    T1] usbcore: registered new interface driver ums-sddr55
[    1.187341][    T1] usbcore: registered new interface driver ums-usbat
[    1.188104][    T1] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU=
] at 0x60,0x64 irq 1,12
[    1.189533][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.190174][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.191207][    T1] mousedev: PS/2 mouse device common for all mice
[    1.192165][    T8] input: AT Translated Set 2 keyboard as /devices/plat=
form/i8042/serio0/input/input1
[    1.194747][    T1] rtc_cmos 00:05: RTC can wake from S4
[    1.195646][    T1] rtc_cmos 00:05: registered as rtc0
[    1.196272][    T1] rtc_cmos 00:05: setting system clock to 2026-02-02T1=
1:54:32 UTC (1770033272)
[    1.197308][    T1] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes=
 nvram, hpet irqs
[    1.198328][    T1] intel_pstate: CPU model not supported
[    1.199006][    T1] hid: raw HID events driver (C) Jiri Kosina
[    1.199696][    T1] usbcore: registered new interface driver usbhid
[    1.200392][    T1] usbhid: USB HID core driver
[    1.201522][    T1] NET: Registered PF_PACKET protocol family
[    1.202245][    T1] 9pnet: Installing 9P2000 support
[    1.202832][    T1] Key type dns_resolver registered
[    1.203901][    T1] IPI shorthand broadcast: enabled
[    1.204485][    T1] ... APIC ID:      00000000 (0)
[    1.205034][    T1] ... APIC VERSION: 00050014
[    1.205535][    T1] 0000000000000000000000000000000000000000000000000000=
000000000000
[    1.206410][    T1] 0000000000000000000000000000000000000000000000000000=
000000000000
[    1.207259][    T1] 0000000000000000000000000000000000000000000000000000=
000000001000
[    1.207585][    T1]
[    1.208435][    T1] number of MP IRQ sources: 15.
[    1.208972][    T1] number of IO-APIC #0 registers: 24.
[    1.209557][    T1] testing the IO APIC.......................
[    1.210234][    T1] IO APIC #0......
[    1.210670][    T1] .... register #00: 00000000
[    1.211203][    T1] .......    : physical APIC id: 00
[    1.211791][    T1] .......    : Delivery Type: 0
[    1.212331][    T1] .......    : LTS          : 0
[    1.212872][    T1] .... register #01: 00170011
[    1.213401][    T1] .......     : max redirection entries: 17
[    1.214051][    T1] .......     : PRQ implemented: 0
[    1.214629][    T1] .......     : IO APIC version: 11
[    1.215209][    T1] .... register #02: 00000000
[    1.215742][    T1] .......     : arbitration: 00
[    1.216271][    T1] .... IRQ redirection table:
[    1.216793][    T1] IOAPIC 0:
[    1.217162][    T1]  pin00, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.218139][    T1]  pin01, enabled , edge , high, V(22), IRR(0), S(0), =
physical, D(0001), M(0)
[    1.219108][    T1]  pin02, enabled , edge , high, V(30), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.220074][    T1]  pin03, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.221048][    T1]  pin04, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.222010][    T1]  pin05, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.223001][    T1]  pin06, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.223970][    T1]  pin07, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.224950][    T1]  pin08, enabled , edge , high, V(22), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.225917][    T1]  pin09, enabled , level, high, V(20), IRR(0), S(0), =
physical, D(0001), M(0)
[    1.226890][    T1]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.230033][    T1]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.231017][    T1]  pin0c, enabled , edge , high, V(21), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.231985][    T1]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.232961][    T1]  pin0e, enabled , edge , high, V(20), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.233923][    T1]  pin0f, enabled , edge , high, V(21), IRR(0), S(0), =
physical, D(0001), M(0)
[    1.234879][    T1]  pin10, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.235840][    T1]  pin11, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.236801][    T1]  pin12, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.237744][    T1]  pin13, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.238716][    T1]  pin14, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.239670][    T1]  pin15, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.240637][    T1]  pin16, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.241603][    T1]  pin17, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.242572][    T1] IRQ to pin mappings:
[    1.243042][    T1] IRQ0 -> 0:2
[    1.243428][    T1] IRQ1 -> 0:1
[    1.243814][    T1] IRQ3 -> 0:3
[    1.244207][    T1] IRQ4 -> 0:4
[    1.244593][    T1] IRQ5 -> 0:5
[    1.244975][    T1] IRQ6 -> 0:6
[    1.245359][    T1] IRQ7 -> 0:7
[    1.245743][    T1] IRQ8 -> 0:8
[    1.246130][    T1] IRQ9 -> 0:9
[    1.246515][    T1] IRQ10 -> 0:10
[    1.246926][    T1] IRQ11 -> 0:11
[    1.247328][    T1] IRQ12 -> 0:12
[    1.247739][    T1] IRQ13 -> 0:13
[    1.248142][    T1] IRQ14 -> 0:14
[    1.248546][    T1] IRQ15 -> 0:15
[    1.248958][    T1] .................................... done.
[    1.251955][    T1] sched_clock: Marking stable (1188002094, 62522198)->=
(1254266114, -3741822)
[    1.256139][    T1] registered taskstats version 1
[    1.256734][    T1] Loading compiled-in X.509 certificates
[    1.258627][    T1] Demotion targets for Node 0: null
[    1.259207][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[    1.290586][    T1] Key type .fscrypt registered
[    1.291131][    T1] Key type fscrypt-provisioning registered
[    1.291913][    T1] netconsole: network logging started
[    1.604127][    T8] input: ImExPS/2 Generic Explorer Mouse as /devices/p=
latform/i8042/serio1/input/input3
[    2.107122][   T11] Freeing initrd memory: 227864K
[    3.639326][   T41] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Fl=
ow Control: RX
[    3.662677][    T1] Sending DHCP requests ., OK
[    3.680678][    T1] IP-Config: Got DHCP answer from 10.0.2.2, my address=
 is 10.0.2.15
[    3.683685][    T1] IP-Config: Complete:
[    3.685218][    T1]      device=3Deth0, hwaddr=3D52:54:00:12:34:56, ipad=
dr=3D10.0.2.15, mask=3D255.255.255.0, gw=3D10.0.2.2
[    3.688968][    T1]      host=3D10.0.2.15, domain=3D, nis-domain=3D(none=
)
[    3.691320][    T1]      bootserver=3D10.0.2.2, rootserver=3D10.0.2.2, r=
ootpath=3D
[    3.691323][    T1]      nameserver0=3D10.0.2.3
[    3.694404][    T1] clk: Disabling unused clocks
[    3.695679][    T1] ALSA device list:
[    3.696690][    T1]   No soundcards found.
[    3.701943][    T1] Freeing unused kernel image (initmem) memory: 3364K
[    3.703096][    T1] Write protecting the kernel read-only data: 28672k
[    3.705192][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 948K
[    3.706944][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1280K
[    3.708270][    T1] Run /init as init process
[    3.708917][    T1]   with arguments:
[    3.709492][    T1]     /init
[    3.709985][    T1]   with environment:
[    3.710613][    T1]     HOME=3D/
[    3.711112][    T1]     TERM=3Dlinux
[    3.711645][    T1]     RESULT_ROOT=3D/result/trinity/group-00-5-300s/vm=
-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07=
eb2969f429a66ad331fe2b3b6f/0
[    3.713218][    T1]     branch=3Dinternal-devel/devel-hourly-20260124-05=
0739
[    3.713912][    T1]     job=3D/lkp/jobs/scheduled/vm-meta-17/trinity-gro=
up-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-=
19zhjsh-2.yaml
[    3.715327][    T1]     user=3Dlkp
[    3.715702][    T1]     ARCH=3Dx86_64
[    3.716096][    T1]     kconfig=3Dx86_64-kexec
[    3.716553][    T1]     commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6=
f
[    3.717210][    T1]     ia32_emulation=3Don
[    3.717645][    T1]     max_uptime=3D7200
[    3.718068][    T1]     LKP_LOCAL_RUN=3D1
[    3.718484][    T1]     selinux=3D0
[    3.718874][    T1]     nmi_watchdog=3Dpanic
[    3.719311][    T1]     prompt_ramdisk=3D0
[    3.719747][    T1]     vga=3Dnormal
[    3.720142][    T1]     result_service=3D9p/virtfs_mount
INIT: version 2.88 booting
[    3.747233][ T1547] /dev/root: Can't lookup blockdev
[    3.748367][ T1547] /dev/root: Can't lookup blockdev
[    3.749454][ T1547] /dev/root: Can't lookup blockdev
[    3.750582][ T1547] /dev/root: Can't lookup blockdev
Starting udev
[    3.768524][ T1558] udevd[1558]: starting version 3.2.7
[    4.794574][    C1] random: crng init done
[    4.796174][ T1558] udevd[1558]: specified group 'kvm' unknown
[    4.797672][ T1559] udevd[1559]: starting eudev-3.2.7
[    4.809296][ T1559] udevd[1559]: specified group 'kvm' unknown
[    4.847254][ T1570] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/fo=
rm2 tray
[    4.847931][ T1570] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.886880][ T1570] sr 1:0:0:0: Attached scsi CD-ROM sr0
INIT: Entering runlevel: 5
Configuring network interfaces... ip: RTNETLINK answers: File exists
Starting syslogd/klogd: done
/etc/rc5.d/S77lkp-bootstrap: /lkp/jobs/scheduled/vm-meta-17/trinity-group-0=
0-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-19zh=
jsh-2.sh: line 126: start: not found
PATH=3D/sbin:/usr/sbin:/bin:/usr/bin:/lkp/lkp/src/bin
export VM_VIRTFS=3D1 due to result service 9p/virtfs_mount
[    5.623007][ T1776] redirect stdout and stderr directly
[    5.623007][ T1776] is_virt=3Dtrue
LKP: ttyS0: 1742: Kernel tests: Boot OK!
LKP: ttyS0: 1742: HOSTNAME vm-snb, MAC 1a:07:76:78:49:41, kernel 6.19.0-rc1=
-00005-g7416634fd6f1 1
LKP: ttyS0: 1742:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-17/=
trinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-2026=
0126-53110-19zhjsh-2.yaml
[    5.659707][ T1892] 9p: Could not find request transport: virtio
[    5.676315][ T1958] process 'src/bin/event/wakeup' started with executab=
le stack
INIT: Id "S1" respawning too fast: disabled for 5 minutes

Poky (Yocto Project Reference Distro) 2.7+snapshot vm-snb /dev/ttyS0

vm-snb login: [    6.623103][ T1777] mount: mounting 9p/virtfs_mount on //r=
esult/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_=
64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 failed: Invali=
d argument
[   17.924630][ T5085] UDPLite: UDP-Lite is deprecated and scheduled to be =
removed in 2025, please contact the netdev mailing list
[   17.926764][ T5085] trinity-main uses obsolete (PF_INET,SOCK_PACKET)
[   17.956549][ T5171] Loading iSCSI transport class v2.0-870.
[   17.985310][ T5214] can: controller area network core
[   17.985844][ T5214] NET: Registered PF_CAN protocol family
[   17.988199][ T5215] CAN device driver interface
[   17.989123][ T5215] can: raw protocol
[   17.990706][ T5216] can: broadcast manager protocol
[   18.011874][ T5085] NOTICE: Automounting of tracing to debugfs is deprec=
ated and will be removed in 2030
[   18.044502][ T5281] Invalid ELF header magic: !=3D ELF
[   18.049739][ T5284] Invalid ELF header magic: !=3D ELF
[   18.050536][ T5284] Invalid ELF header magic: !=3D ELF
[   19.022817][ T5260] Invalid ELF header magic: !=3D ELF
[   19.025561][ T5270] Invalid ELF header magic: !=3D ELF
[   19.028348][ T5260] Invalid ELF header magic: !=3D ELF
[   19.032663][ T5264] raw_sendmsg: trinity-c4 forgot to set AF_INET. Fix i=
t!
[   19.037639][ T5260] Invalid ELF header magic: !=3D ELF
[   19.042778][ T5282] Invalid ELF header magic: !=3D ELF
[   19.046402][ T5290] Invalid ELF header magic: !=3D ELF
[   19.057580][ T5264] Invalid ELF header magic: !=3D ELF
[   20.050981][ T5260] Invalid ELF header magic: !=3D ELF
[   20.058300][ T5281] Invalid ELF header magic: !=3D ELF
[   20.067036][ T5284] Invalid ELF header magic: !=3D ELF
[   20.070779][ T5284] Invalid ELF header magic: !=3D ELF
[   21.036479][ T5270] Invalid ELF header magic: !=3D ELF
[   21.042013][ T5270] Invalid ELF header magic: !=3D ELF
[   21.043801][ T5270] Invalid ELF header magic: !=3D ELF
[   21.058902][ T5286] Invalid ELF header magic: !=3D ELF
[   21.064664][ T5294] Invalid ELF header magic: !=3D ELF
[   21.070025][ T5290] Invalid ELF header magic: !=3D ELF
[   22.050822][ T5270] Invalid ELF header magic: !=3D ELF
[   22.059057][ T5301] Invalid ELF header magic: !=3D ELF
[   22.060615][ T5301] Invalid ELF header magic: !=3D ELF
[   23.055858][ T5260] Invalid ELF header magic: !=3D ELF
[   23.089132][ T5290] Zero length message leads to an empty skb
[   23.122357][ T5260] Invalid ELF header magic: !=3D ELF
[   24.072315][ T5282] Invalid ELF header magic: !=3D ELF
[   24.079699][ T5264] Invalid ELF header magic: !=3D ELF
[   24.109732][ T5294] Invalid ELF header magic: !=3D ELF
[   25.083837][ T5282] Invalid ELF header magic: !=3D ELF
[   25.129873][ T5284] Invalid ELF header magic: !=3D ELF
[   25.130924][ T5264] Invalid ELF header magic: !=3D ELF
[   25.131161][ T5290] Invalid ELF header magic: !=3D ELF
[   25.132289][ T5284] Invalid ELF header magic: !=3D ELF
[   25.133305][ T5284] Invalid ELF header magic: !=3D ELF
[   25.134737][ T5284] Invalid ELF header magic: !=3D ELF
[   25.136776][ T5284] Invalid ELF header magic: !=3D ELF
[   26.122640][ T5294] Invalid ELF header magic: !=3D ELF
[   26.124218][ T5294] Invalid ELF header magic: !=3D ELF
[   26.137116][ T5290] Invalid ELF header magic: !=3D ELF
[   26.138986][ T5290] Invalid ELF header magic: !=3D ELF
[   27.131069][ T5282] Invalid ELF header magic: !=3D ELF
[   27.183362][ T5264] Invalid ELF header magic: !=3D ELF
[   28.138072][ T5318] Invalid ELF header magic: !=3D ELF
[   28.212401][ T5319] Invalid ELF header magic: !=3D ELF
[   29.146753][ T5318] Invalid ELF header magic: !=3D ELF
[   29.155357][ T5282] Invalid ELF header magic: !=3D ELF
[   30.074972][ T5301] Invalid ELF header magic: !=3D ELF
[   30.088777][ T5301] Invalid ELF header magic: !=3D ELF
[   30.091704][ T5301] Invalid ELF header magic: !=3D ELF
[   30.152620][ T5318] Invalid ELF header magic: !=3D ELF
[   30.167231][ T5290] Invalid ELF header magic: !=3D ELF
[   30.178002][ T5282] Invalid ELF header magic: !=3D ELF
[   30.187762][ T5332] Invalid ELF header magic: !=3D ELF
[   30.190872][ T5332] Invalid ELF header magic: !=3D ELF
[   31.102833][ T5301] Invalid ELF header magic: !=3D ELF
[   31.161445][ T5318] Invalid ELF header magic: !=3D ELF
[   31.176827][ T5336] Invalid ELF header magic: !=3D ELF
[   31.192615][ T5332] Invalid ELF header magic: !=3D ELF
[   32.119547][ T5301] Invalid ELF header magic: !=3D ELF
[   32.135985][ T5301] Invalid ELF header magic: !=3D ELF
[   32.186849][ T5336] Invalid ELF header magic: !=3D ELF
[   32.196128][ T5332] Invalid ELF header magic: !=3D ELF
[   33.139784][ T5301] Invalid ELF header magic: !=3D ELF
[   33.142770][ T5301] Invalid ELF header magic: !=3D ELF
[   33.145024][ T5301] Invalid ELF header magic: !=3D ELF
[   33.194520][ T5336] Invalid ELF header magic: !=3D ELF
[   33.196902][ T5336] Invalid ELF header magic: !=3D ELF
[   34.222209][ T5341] Invalid ELF header magic: !=3D ELF
[   34.231082][ T5341] Invalid ELF header magic: !=3D ELF
[   35.223012][ T5282] Invalid ELF header magic: !=3D ELF
[   35.233229][ T5341] Invalid ELF header magic: !=3D ELF
[   35.240158][ T5332] Invalid ELF header magic: !=3D ELF
[   36.153814][ T5348] Invalid ELF header magic: !=3D ELF
[   36.242766][ T5332] Invalid ELF header magic: !=3D ELF
[   37.221678][ T5336] Invalid ELF header magic: !=3D ELF
[   37.289914][ T5359] Invalid ELF header magic: !=3D ELF
[   37.291117][ T5359] Invalid ELF header magic: !=3D ELF
[   37.291617][ T5360] Invalid ELF header magic: !=3D ELF
[   37.293651][ T5359] Invalid ELF header magic: !=3D ELF
[   37.297329][ T5341] Invalid ELF header magic: !=3D ELF
[   38.071055][ T5360] Invalid ELF header magic: !=3D ELF
[   39.076519][ T5360] Invalid ELF header magic: !=3D ELF
[   39.092336][ T5370] Invalid ELF header magic: !=3D ELF
[   39.107463][ T5370] Invalid ELF header magic: !=3D ELF
[   39.108333][ T5370] Invalid ELF header magic: !=3D ELF
[   39.325456][ T5341] Invalid ELF header magic: !=3D ELF
[   40.108043][ T5319] Invalid ELF header magic: !=3D ELF
[   40.244633][ T5336] Invalid ELF header magic: !=3D ELF
[   41.255225][ T5336] Invalid ELF header magic: !=3D ELF
[   42.319897][ T5359] Invalid ELF header magic: !=3D ELF
[   42.330549][ T5341] Invalid ELF header magic: !=3D ELF
[   43.125680][ T5370] Invalid ELF header magic: !=3D ELF
[   43.128387][ T5370] Invalid ELF header magic: !=3D ELF
[   43.154033][ T5319] Invalid ELF header magic: !=3D ELF
[   43.156463][ T5319] Invalid ELF header magic: !=3D ELF
[   43.161868][ T5319] Invalid ELF header magic: !=3D ELF
[   43.346651][ T5383] Invalid ELF header magic: !=3D ELF
[   43.354029][ T5352] Invalid ELF header magic: !=3D ELF
[   43.363620][ T5352] Invalid ELF header magic: !=3D ELF
[   44.343114][ T5341] Invalid ELF header magic: !=3D ELF
[   46.169656][ T5370] Invalid ELF header magic: !=3D ELF
[   46.385093][ T5352] Invalid ELF header magic: !=3D ELF
[   46.387171][ T5383] Invalid ELF header magic: !=3D ELF
[   47.232911][ T5319] Invalid ELF header magic: !=3D ELF
[   47.233631][ T5319] Invalid ELF header magic: !=3D ELF
[   47.360603][ T5341] Invalid ELF header magic: !=3D ELF
[   47.423474][ T5383] Invalid ELF header magic: !=3D ELF
[   47.425689][ T5383] Invalid ELF header magic: !=3D ELF
[   47.427673][ T5383] Invalid ELF header magic: !=3D ELF
[   48.203971][ T5348] Invalid ELF header magic: !=3D ELF
[   48.238313][ T5370] Invalid ELF header magic: !=3D ELF
[   48.267866][ T5336] Invalid ELF header magic: !=3D ELF
[   48.365443][ T5341] Invalid ELF header magic: !=3D ELF
[   49.249046][ T5370] Invalid ELF header magic: !=3D ELF
[   49.271066][ T5403] Invalid ELF header magic: !=3D ELF
[   49.295547][ T5399] Invalid ELF header magic: !=3D ELF
[   49.296585][ T5399] Invalid ELF header magic: !=3D ELF
[   49.297212][ T5399] Invalid ELF header magic: !=3D ELF
[   49.299395][ T5399] Invalid ELF header magic: !=3D ELF
[   50.483634][ T5383] Invalid ELF header magic: !=3D ELF
[   50.509552][ T5383] Invalid ELF header magic: !=3D ELF
[   51.207528][ T5348] Invalid ELF header magic: !=3D ELF
[   51.281486][ T5414] Invalid ELF header magic: !=3D ELF
[   52.392937][ T5341] Invalid ELF header magic: !=3D ELF
[   53.074363][ T5410] Invalid ELF header magic: !=3D ELF
[   54.069938][ T5383] Invalid ELF header magic: !=3D ELF
[   54.335477][ T5348] Invalid ELF header magic: !=3D ELF
[   54.456566][ T5352] Invalid ELF header magic: !=3D ELF
[   55.086134][ T5410] Invalid ELF header magic: !=3D ELF
[   55.159443][ T5425] Invalid ELF header magic: !=3D ELF
[   55.163386][ T5425] Invalid ELF header magic: !=3D ELF
[   55.184145][ T5424] Invalid ELF header magic: !=3D ELF
[   55.405046][ T5341] Invalid ELF header magic: !=3D ELF
[   55.416662][ T5341] Invalid ELF header magic: !=3D ELF
[   55.467818][ T5352] Invalid ELF header magic: !=3D ELF
[   56.107913][ T5429] Invalid ELF header magic: !=3D ELF
[   56.354198][ T5348] Invalid ELF header magic: !=3D ELF
[   57.192065][ T5424] Invalid ELF header magic: !=3D ELF
[   57.200482][ T5424] Invalid ELF header magic: !=3D ELF
[   57.376356][ T5439] Invalid ELF header magic: !=3D ELF
[   57.428104][ T5341] Invalid ELF header magic: !=3D ELF
[   57.443041][ T5341] Invalid ELF header magic: !=3D ELF
[   58.356177][ T5403] Invalid ELF header magic: !=3D ELF
[   59.341927][ T5430] Invalid ELF header magic: !=3D ELF
[   59.358820][ T5403] Invalid ELF header magic: !=3D ELF
[   59.484980][ T5352] Invalid ELF header magic: !=3D ELF
[   59.489592][ T5352] Invalid ELF header magic: !=3D ELF
[   59.498643][ T5352] Invalid ELF header magic: !=3D ELF
[   59.499733][ T5352] Invalid ELF header magic: !=3D ELF
[   59.502495][ T5352] Invalid ELF header magic: !=3D ELF
[   60.210239][ T5425] Invalid ELF header magic: !=3D ELF
[   60.236893][ T5424] Invalid ELF header magic: !=3D ELF
[   60.372004][ T5403] Invalid ELF header magic: !=3D ELF
[   60.381811][ T5403] Invalid ELF header magic: !=3D ELF
[   60.390937][ T5439] Invalid ELF header magic: !=3D ELF
[   60.392929][ T5449] Invalid ELF header magic: !=3D ELF
[   60.399521][ T5449] Invalid ELF header magic: !=3D ELF
[   60.401071][ T5449] Invalid ELF header magic: !=3D ELF
[   61.173037][ T5434] Invalid ELF header magic: !=3D ELF
[   62.179593][ T5434] Invalid ELF header magic: !=3D ELF
[   62.396508][ T5439] Invalid ELF header magic: !=3D ELF
[   63.096445][ T5430] Invalid ELF header magic: !=3D ELF
[   63.239491][ T5425] Invalid ELF header magic: !=3D ELF
[   63.530351][ T5450] Invalid ELF header magic: !=3D ELF
[   64.194559][ T5434] Invalid ELF header magic: !=3D ELF
[   64.444509][ T5449] Invalid ELF header magic: !=3D ELF
[   64.448845][ T5449] scsi_nl_rcv_msg: discarding partial skb
[   65.136565][ T5430] Invalid ELF header magic: !=3D ELF
[   65.139350][ T5430] Invalid ELF header magic: !=3D ELF
[   65.139996][ T5430] Invalid ELF header magic: !=3D ELF
[   65.260091][ T5425] Invalid ELF header magic: !=3D ELF
[   65.262102][ T5425] Invalid ELF header magic: !=3D ELF
[   65.535101][ T5450] Invalid ELF header magic: !=3D ELF
[   66.066489][ T5424] Invalid ELF header magic: !=3D ELF
[   66.471196][ T5449] Invalid ELF header magic: !=3D ELF
[   67.147768][ T5430] Invalid ELF header magic: !=3D ELF
[   67.283830][ T5425] Invalid ELF header magic: !=3D ELF
[   67.499093][ T5475] Invalid ELF header magic: !=3D ELF
[   67.517569][ T5475] Invalid ELF header magic: !=3D ELF
[   68.110143][ T5474] Invalid ELF header magic: !=3D ELF
[   68.112791][ T5474] Invalid ELF header magic: !=3D ELF
[   68.115091][ T5474] Invalid ELF header magic: !=3D ELF
[   68.151755][ T5430] Invalid ELF header magic: !=3D ELF
[   68.217047][ T5470] scsi_nl_rcv_msg: discarding partial skb
[   69.063477][ T5481] Invalid ELF header magic: !=3D ELF
[   69.249574][ T5485] Invalid ELF header magic: !=3D ELF
[   69.253954][ T5485] Invalid ELF header magic: !=3D ELF
[   70.067642][ T5480] Invalid ELF header magic: !=3D ELF
[   70.070319][ T5480] Invalid ELF header magic: !=3D ELF
[   70.107839][ T5492] Invalid ELF header magic: !=3D ELF
[   70.164005][ T5430] Invalid ELF header magic: !=3D ELF
[   70.166170][ T5430] Invalid ELF header magic: !=3D ELF
[   71.133114][ T5474] Invalid ELF header magic: !=3D ELF
[   71.182960][ T5430] Invalid ELF header magic: !=3D ELF
[   71.184004][ T5430] Invalid ELF header magic: !=3D ELF
[   71.187588][ T5430] Invalid ELF header magic: !=3D ELF
[   71.190202][ T5450] Invalid ELF header magic: !=3D ELF
[   72.148352][ T5474] Invalid ELF header magic: !=3D ELF
[   72.548660][ T5475] Invalid ELF header magic: !=3D ELF
[   73.203170][ T5450] Invalid ELF header magic: !=3D ELF
[   73.205229][ T5450] Invalid ELF header magic: !=3D ELF
[   73.236104][ T5450] Invalid ELF header magic: !=3D ELF
[   74.239008][ T5450] Invalid ELF header magic: !=3D ELF
[   74.240914][ T5450] Invalid ELF header magic: !=3D ELF
[   76.340248][ T5485] Invalid ELF header magic: !=3D ELF
[   76.342730][ T5485] Invalid ELF header magic: !=3D ELF
[   77.076260][ T5430] Invalid ELF header magic: !=3D ELF
[   77.103219][ T5430] Invalid ELF header magic: !=3D ELF
[   77.142814][ T5480] Invalid ELF header magic: !=3D ELF
[   77.224035][ T5474] Invalid ELF header magic: !=3D ELF
[   77.228738][ T5474] Invalid ELF header magic: !=3D ELF
[   78.125475][ T5430] Invalid ELF header magic: !=3D ELF
[   78.153072][ T5480] Invalid ELF header magic: !=3D ELF
[   78.157777][ T5480] Invalid ELF header magic: !=3D ELF
[   78.167749][ T5523] Invalid ELF header magic: !=3D ELF
[   78.177410][ T5523] Invalid ELF header magic: !=3D ELF
[   78.271339][ T5512] Invalid ELF header magic: !=3D ELF
[   79.226025][ T5492] Invalid ELF header magic: !=3D ELF
[   79.279166][ T5512] Invalid ELF header magic: !=3D ELF
[   80.129051][ T5430] Invalid ELF header magic: !=3D ELF
[   80.206870][ T5523] Invalid ELF header magic: !=3D ELF
[   80.229150][ T5492] Invalid ELF header magic: !=3D ELF
[   80.237765][ T5492] Invalid ELF header magic: !=3D ELF
[   80.288696][ T5512] Invalid ELF header magic: !=3D ELF
[   80.293494][ T5512] Invalid ELF header magic: !=3D ELF
[   81.309312][ T5474] Invalid ELF header magic: !=3D ELF
[   81.313568][ T5474] Invalid ELF header magic: !=3D ELF
[   82.372903][ T5485] Invalid ELF header magic: !=3D ELF
[   82.601752][ T5475] Invalid ELF header magic: !=3D ELF
[   83.170563][ T5430] Invalid ELF header magic: !=3D ELF
[   83.262868][ T5492] Invalid ELF header magic: !=3D ELF
[   83.589183][ T5528] Invalid ELF header magic: !=3D ELF
[   84.222080][ T5523] Invalid ELF header magic: !=3D ELF
[   84.227143][ T5549] Invalid ELF header magic: !=3D ELF
[   84.284395][ T5545] Invalid ELF header magic: !=3D ELF
[   84.286145][ T5545] Invalid ELF header magic: !=3D ELF
[   84.361282][ T5474] Invalid ELF header magic: !=3D ELF
[   84.381252][ T5485] Invalid ELF header magic: !=3D ELF
[   85.366700][ T5474] Invalid ELF header magic: !=3D ELF
[   86.232688][ T5523] Invalid ELF header magic: !=3D ELF
[   86.271729][ T5523] Invalid ELF header magic: !=3D ELF
[   86.373778][ T5474] Invalid ELF header magic: !=3D ELF
[   87.291050][ T5523] Invalid ELF header magic: !=3D ELF
[   87.332795][ T5560] Invalid ELF header magic: !=3D ELF
[   87.369196][ T5560] Invalid ELF header magic: !=3D ELF
[   87.380542][ T5474] Invalid ELF header magic: !=3D ELF
[   87.615115][ T5528] Invalid ELF header magic: !=3D ELF
[   89.305506][ T5523] Invalid ELF header magic: !=3D ELF
[   89.315071][ T5523] Invalid ELF header magic: !=3D ELF
[   89.358153][ T5512] Invalid ELF header magic: !=3D ELF
[   89.361298][ T5512] Invalid ELF header magic: !=3D ELF
[   90.337667][ T5568] Invalid ELF header magic: !=3D ELF
[   90.393955][ T5564] Invalid ELF header magic: !=3D ELF
[   90.460274][ T5572] Invalid ELF header magic: !=3D ELF
[   90.640327][ T5528] Invalid ELF header magic: !=3D ELF
[   90.648266][ T5528] Invalid ELF header magic: !=3D ELF
[   91.340905][ T5568] Invalid ELF header magic: !=3D ELF
[   91.403250][ T5564] Invalid ELF header magic: !=3D ELF
[   91.412433][ T5474] Invalid ELF header magic: !=3D ELF
[   91.418012][ T5578] Invalid ELF header magic: !=3D ELF
[   91.472317][ T5573] Invalid ELF header magic: !=3D ELF
[   91.677934][ T5528] Invalid ELF header magic: !=3D ELF
[   92.481951][ T5579] Invalid ELF header magic: !=3D ELF
[   92.679093][ T5475] Invalid ELF header magic: !=3D ELF
[   92.681597][ T5528] Invalid ELF header magic: !=3D ELF
[   92.682960][ T5475] Invalid ELF header magic: !=3D ELF
[   93.361288][ T5568] Invalid ELF header magic: !=3D ELF
[   93.363044][ T5568] Invalid ELF header magic: !=3D ELF
[   93.429250][ T5578] Invalid ELF header magic: !=3D ELF
[   93.493078][ T5579] Invalid ELF header magic: !=3D ELF
[   93.691066][ T5475] Invalid ELF header magic: !=3D ELF
[   94.409332][ T5577] Invalid ELF header magic: !=3D ELF
[   94.431843][ T5578] Invalid ELF header magic: !=3D ELF
[   94.438814][ T5578] Invalid ELF header magic: !=3D ELF
[   94.442167][ T5578] Invalid ELF header magic: !=3D ELF
[   94.444603][ T5578] Invalid ELF header magic: !=3D ELF
[   95.425846][ T5568] Invalid ELF header magic: !=3D ELF
[   95.433874][ T5596] Invalid ELF header magic: !=3D ELF
[   95.437066][ T5596] Invalid ELF header magic: !=3D ELF
[   95.438413][ T5596] Invalid ELF header magic: !=3D ELF
[   95.451882][ T5578] Invalid ELF header magic: !=3D ELF
[   95.498890][ T5579] Invalid ELF header magic: !=3D ELF
[   95.697306][ T5475] Invalid ELF header magic: !=3D ELF
[   95.704807][ T5475] Invalid ELF header magic: !=3D ELF
[   96.445530][ T5596] Invalid ELF header magic: !=3D ELF
[   96.448576][ T5600] Invalid ELF header magic: !=3D ELF
[   96.454252][ T5578] Invalid ELF header magic: !=3D ELF
[   96.513604][ T5579] Invalid ELF header magic: !=3D ELF
[   96.737699][ T5528] Invalid ELF header magic: !=3D ELF
[   96.745210][ T5528] Invalid ELF header magic: !=3D ELF
[   97.436293][ T5568] Invalid ELF header magic: !=3D ELF
[   97.441507][ T5604] Invalid ELF header magic: !=3D ELF
[   97.444431][ T5604] Invalid ELF header magic: !=3D ELF
[   97.445995][ T5604] Invalid ELF header magic: !=3D ELF
[   97.466664][ T5600] Invalid ELF header magic: !=3D ELF
[   97.468031][ T5596] Invalid ELF header magic: !=3D ELF
[   97.476295][ T5605] Invalid ELF header magic: !=3D ELF
[   97.479806][ T5605] Invalid ELF header magic: !=3D ELF
[   97.485701][ T5606] Invalid ELF header magic: !=3D ELF
[   97.748230][ T5528] Invalid ELF header magic: !=3D ELF
[   97.756179][ T5528] Invalid ELF header magic: !=3D ELF
[   97.761427][ T5528] Invalid ELF header magic: !=3D ELF
[   98.525871][ T5579] Invalid ELF header magic: !=3D ELF
[   98.763932][ T5528] Invalid ELF header magic: !=3D ELF
[   98.766094][ T5475] Invalid ELF header magic: !=3D ELF
[   98.776270][ T5611] Invalid ELF header magic: !=3D ELF
[   99.313316][ T5549] Invalid ELF header magic: !=3D ELF
[   99.531803][ T5579] Invalid ELF header magic: !=3D ELF
[  100.784534][ T5611] Invalid ELF header magic: !=3D ELF
[  101.475584][ T5600] Invalid ELF header magic: !=3D ELF
[  101.484214][ T5600] Invalid ELF header magic: !=3D ELF
[  102.074753][ T5606] Invalid ELF header magic: !=3D ELF
[  102.076630][ T5606] Invalid ELF header magic: !=3D ELF
[  102.379536][ T5549] Invalid ELF header magic: !=3D ELF
[  102.381857][ T5549] Invalid ELF header magic: !=3D ELF
[  102.388377][ T5625] Invalid ELF header magic: !=3D ELF
[  102.391934][ T5625] Invalid ELF header magic: !=3D ELF
[  102.544341][ T5600] Invalid ELF header magic: !=3D ELF
[  102.546690][ T5600] Invalid ELF header magic: !=3D ELF
[  102.808758][ T5621] Invalid ELF header magic: !=3D ELF
[  103.560040][ T5600] Invalid ELF header magic: !=3D ELF
[  103.573570][ T5600] Invalid ELF header magic: !=3D ELF
[  103.574917][ T5600] Invalid ELF header magic: !=3D ELF
[  103.577365][ T5600] Invalid ELF header magic: !=3D ELF
[  103.783811][ T5528] Invalid ELF header magic: !=3D ELF
[  104.088028][ T5630] Invalid ELF header magic: !=3D ELF
[  104.508266][ T5596] Invalid ELF header magic: !=3D ELF
[  104.583551][ T5600] Invalid ELF header magic: !=3D ELF
[  105.409717][ T5625] Invalid ELF header magic: !=3D ELF
[  105.415842][ T5625] Invalid ELF header magic: !=3D ELF
[  106.426560][ T5625] Invalid ELF header magic: !=3D ELF
[  106.485620][ T5604] Invalid ELF header magic: !=3D ELF
[  106.488465][ T5604] Invalid ELF header magic: !=3D ELF
[  106.857023][ T5528] Invalid ELF header magic: !=3D ELF
[  106.868737][ T5629] Invalid ELF header magic: !=3D ELF
[  106.900277][ T5629] Invalid ELF header magic: !=3D ELF
[  107.105639][ T5630] Invalid ELF header magic: !=3D ELF
[  107.108300][ T5630] Invalid ELF header magic: !=3D ELF
[  108.535848][ T5596] Invalid ELF header magic: !=3D ELF
[  108.584441][ T5579] Invalid ELF header magic: !=3D ELF
[  108.615745][ T5643] Invalid ELF header magic: !=3D ELF
[  108.620030][ T5643] Invalid ELF header magic: !=3D ELF
[  108.621972][ T5643] Invalid ELF header magic: !=3D ELF
[  109.614685][ T5579] Invalid ELF header magic: !=3D ELF
[  109.643723][ T5643] Invalid ELF header magic: !=3D ELF
[  110.521102][ T5648] Invalid ELF header magic: !=3D ELF
[  110.522697][ T5648] Invalid ELF header magic: !=3D ELF
[  110.656094][ T5643] Invalid ELF header magic: !=3D ELF
[  110.920046][ T5644] Invalid ELF header magic: !=3D ELF
[  110.939367][ T5629] Invalid ELF header magic: !=3D ELF
[  110.949141][ T5644] Invalid ELF header magic: !=3D ELF
[  111.526625][ T5648] Invalid ELF header magic: !=3D ELF
[  111.586580][ T5596] Invalid ELF header magic: !=3D ELF
[  111.588882][ T5596] Invalid ELF header magic: !=3D ELF
[  112.128228][ T5630] Invalid ELF header magic: !=3D ELF
[  112.139907][ T5630] Invalid ELF header magic: !=3D ELF
[  112.143167][ T5630] Invalid ELF header magic: !=3D ELF
[  112.144830][ T5630] Invalid ELF header magic: !=3D ELF
[  112.148076][ T5630] Invalid ELF header magic: !=3D ELF
[  112.493039][ T5666] Invalid ELF header magic: !=3D ELF
[  112.546170][ T5648] Invalid ELF header magic: !=3D ELF
[  112.548961][ T5648] Invalid ELF header magic: !=3D ELF
[  112.633035][ T5662] Invalid ELF header magic: !=3D ELF
[  112.640956][ T5667] Invalid ELF header magic: !=3D ELF
[  113.579906][ T5672] Invalid ELF header magic: !=3D ELF
[  113.581585][ T5672] Invalid ELF header magic: !=3D ELF
[  113.585253][ T5672] Invalid ELF header magic: !=3D ELF
[  114.506597][ T5666] Invalid ELF header magic: !=3D ELF
[  114.596648][ T5676] Invalid ELF header magic: !=3D ELF
[  114.611986][ T5676] Invalid ELF header magic: !=3D ELF
[  114.990136][ T5629] Invalid ELF header magic: !=3D ELF
[  115.603154][ T5596] Invalid ELF header magic: !=3D ELF
[  116.167743][ T5630] Invalid ELF header magic: !=3D ELF
[  116.607661][ T5596] Invalid ELF header magic: !=3D ELF
[  116.688807][ T5668] Invalid ELF header magic: !=3D ELF
[  116.697551][ T5668] Invalid ELF header magic: !=3D ELF
[  116.704419][ T5668] Invalid ELF header magic: !=3D ELF
[  117.627127][ T5596] Invalid ELF header magic: !=3D ELF
[  117.630064][ T5596] Invalid ELF header magic: !=3D ELF
[  117.634774][ T5596] Invalid ELF header magic: !=3D ELF
[  117.709569][ T5668] Invalid ELF header magic: !=3D ELF
[  117.711292][ T5668] Invalid ELF header magic: !=3D ELF
[  117.713607][ T5668] Invalid ELF header magic: !=3D ELF
[  118.642667][ T5596] Invalid ELF header magic: !=3D ELF
[  118.719979][ T5668] Invalid ELF header magic: !=3D ELF
[  119.182275][ T5630] Invalid ELF header magic: !=3D ELF
[  120.119207][ T5692] Invalid ELF header magic: !=3D ELF
[  120.121001][ T5692] Invalid ELF header magic: !=3D ELF
[  120.659157][ T5676] Invalid ELF header magic: !=3D ELF
[  121.127910][ T5692] Invalid ELF header magic: !=3D ELF
[  121.129710][ T5692] Invalid ELF header magic: !=3D ELF
[  121.196127][ T5630] Invalid ELF header magic: !=3D ELF
[  121.666389][ T5667] Invalid ELF header magic: !=3D ELF
[  122.676963][ T5667] Invalid ELF header magic: !=3D ELF
[  122.688993][ T5706] Invalid ELF header magic: !=3D ELF
[  124.095037][ T5644] Invalid ELF header magic: !=3D ELF
[  124.718709][ T5712] Invalid ELF header magic: !=3D ELF
[  125.168014][ T5716] Invalid ELF header magic: !=3D ELF
[  125.172625][ T5717] Invalid ELF header magic: !=3D ELF
[  125.843262][ T5668] Invalid ELF header magic: !=3D ELF
[  125.851797][ T5668] Invalid ELF header magic: !=3D ELF
[  126.693094][ T5596] Invalid ELF header magic: !=3D ELF
[  126.701545][ T5596] Invalid ELF header magic: !=3D ELF
[  126.743663][ T5712] Invalid ELF header magic: !=3D ELF
[  126.753024][ T5712] Invalid ELF header magic: !=3D ELF
[  127.190347][ T5717] Invalid ELF header magic: !=3D ELF
[  127.192472][ T5717] Invalid ELF header magic: !=3D ELF
[  127.219260][ T5702] Invalid ELF header magic: !=3D ELF
[  128.759737][ T5712] Invalid ELF header magic: !=3D ELF
[  128.921359][ T5733] Invalid ELF header magic: !=3D ELF
[  129.133936][ T5644] Invalid ELF header magic: !=3D ELF
[  129.209715][ T5717] Invalid ELF header magic: !=3D ELF
[  129.236742][ T5702] Invalid ELF header magic: !=3D ELF
[  129.253624][ T5702] Invalid ELF header magic: !=3D ELF
[  129.771851][ T5596] Invalid ELF header magic: !=3D ELF
[  131.246904][ T5717] Invalid ELF header magic: !=3D ELF
[  131.783229][ T5596] Invalid ELF header magic: !=3D ELF
[  131.786509][ T5596] Invalid ELF header magic: !=3D ELF
[  131.960825][ T5733] Invalid ELF header magic: !=3D ELF
[  131.962634][ T5733] Invalid ELF header magic: !=3D ELF
[  131.965618][ T5733] Invalid ELF header magic: !=3D ELF
[  131.994984][ T5733] Invalid ELF header magic: !=3D ELF
[  132.154469][ T5644] Invalid ELF header magic: !=3D ELF
[  132.160542][ T5644] Invalid ELF header magic: !=3D ELF
[  132.162356][ T5644] Invalid ELF header magic: !=3D ELF
[  132.258245][ T5717] Invalid ELF header magic: !=3D ELF
[  132.805665][ T5746] Invalid ELF header magic: !=3D ELF
[  133.164904][ T5644] Invalid ELF header magic: !=3D ELF
[  133.801431][ T5712] Invalid ELF header magic: !=3D ELF
[  133.804387][ T5712] Invalid ELF header magic: !=3D ELF
[  133.840392][ T5746] Invalid ELF header magic: !=3D ELF
[  134.266685][ T5702] Invalid ELF header magic: !=3D ELF
[  134.812368][ T5712] Invalid ELF header magic: !=3D ELF
[  135.829762][ T5754] Invalid ELF header magic: !=3D ELF
[  136.016465][ T5733] Invalid ELF header magic: !=3D ELF
[  136.052351][ T5733] Invalid ELF header magic: !=3D ELF
[  136.217908][ T5758] Invalid ELF header magic: !=3D ELF
[  136.233156][ T5758] Invalid ELF header magic: !=3D ELF
[  136.847030][ T5746] Invalid ELF header magic: !=3D ELF
[  137.053519][ T5733] Invalid ELF header magic: !=3D ELF
[  137.057657][ T5733] Invalid ELF header magic: !=3D ELF
[  137.059975][ T5733] Invalid ELF header magic: !=3D ELF
[  137.235264][ T5758] Invalid ELF header magic: !=3D ELF
[  137.249483][ T5758] Invalid ELF header magic: !=3D ELF
[  137.853419][ T5746] Invalid ELF header magic: !=3D ELF
[  138.895517][ T5772] Invalid ELF header magic: !=3D ELF
[  139.072996][ T5746] Invalid ELF header magic: !=3D ELF
[  139.075578][ T5746] Invalid ELF header magic: !=3D ELF
[  139.294576][ T5758] Invalid ELF header magic: !=3D ELF
[  139.904206][ T5772] Invalid ELF header magic: !=3D ELF
[  140.108058][ T5746] Invalid ELF header magic: !=3D ELF
[  140.331030][ T5758] Invalid ELF header magic: !=3D ELF
[  141.068051][ T5717] Invalid ELF header magic: !=3D ELF
[  141.079293][ T5733] Invalid ELF header magic: !=3D ELF
[  141.351726][ T5780] Invalid ELF header magic: !=3D ELF
[  142.082624][ T5733] Invalid ELF header magic: !=3D ELF
[  142.101486][ T5784] Invalid ELF header magic: !=3D ELF
[  142.106089][ T5784] Invalid ELF header magic: !=3D ELF
[  142.414008][ T5780] Invalid ELF header magic: !=3D ELF
[  143.077056][ T5717] Invalid ELF header magic: !=3D ELF
[  143.086406][ T5717] Invalid ELF header magic: !=3D ELF
[  144.102460][ T5762] Invalid ELF header magic: !=3D ELF
[  144.106125][ T5762] Invalid ELF header magic: !=3D ELF
[  144.107801][ T5762] Invalid ELF header magic: !=3D ELF
[  144.118547][ T5762] Invalid ELF header magic: !=3D ELF
[  145.093743][ T5717] Invalid ELF header magic: !=3D ELF
[  145.124591][ T5762] Invalid ELF header magic: !=3D ELF
[  146.099708][ T5717] Invalid ELF header magic: !=3D ELF
[  146.128406][ T5762] Invalid ELF header magic: !=3D ELF
[  146.164988][ T5799] Invalid ELF header magic: !=3D ELF
[  146.168056][ T5799] Invalid ELF header magic: !=3D ELF
[  146.550019][ T5780] Invalid ELF header magic: !=3D ELF
[  147.226217][ T5803] Invalid ELF header magic: !=3D ELF
[  147.946326][ T5772] Invalid ELF header magic: !=3D ELF
[  149.169631][ T5784] Invalid ELF header magic: !=3D ELF
[  149.193149][ T5798] Invalid ELF header magic: !=3D ELF
[  149.200488][ T5799] Invalid ELF header magic: !=3D ELF
[  149.200521][ T5717] Invalid ELF header magic: !=3D ELF
[  149.202089][ T5717] Invalid ELF header magic: !=3D ELF
[  149.206972][ T5717] Invalid ELF header magic: !=3D ELF
[  149.251502][ T5799] Invalid ELF header magic: !=3D ELF
[  150.204825][ T5798] Invalid ELF header magic: !=3D ELF
[  150.209169][ T5717] Invalid ELF header magic: !=3D ELF
[  150.216783][ T5798] Invalid ELF header magic: !=3D ELF
[  150.282429][ T5816] Invalid ELF header magic: !=3D ELF
[  151.221071][ T5798] Invalid ELF header magic: !=3D ELF
[  151.241004][ T5820] Invalid ELF header magic: !=3D ELF
[  151.262870][ T5799] Invalid ELF header magic: !=3D ELF
[  151.269397][ T5799] Invalid ELF header magic: !=3D ELF
[  151.276896][ T5799] Invalid ELF header magic: !=3D ELF
[  152.242429][ T5798] Invalid ELF header magic: !=3D ELF
[  152.279605][ T5799] Invalid ELF header magic: !=3D ELF
[  153.220597][ T5827] Invalid ELF header magic: !=3D ELF
[  153.361313][ T5799] Invalid ELF header magic: !=3D ELF
[  154.222541][ T5827] Invalid ELF header magic: !=3D ELF
[  154.254571][ T5798] Invalid ELF header magic: !=3D ELF
[  155.224554][ T5827] Invalid ELF header magic: !=3D ELF
[  155.265622][ T5798] Invalid ELF header magic: !=3D ELF
[  155.298618][ T5820] Invalid ELF header magic: !=3D ELF
[  155.299740][ T5820] Invalid ELF header magic: !=3D ELF
[  155.311519][ T5798] Invalid ELF header magic: !=3D ELF
[  155.312776][ T5798] Invalid ELF header magic: !=3D ELF
[  155.334817][ T5816] Invalid ELF header magic: !=3D ELF
[  155.335545][ T5816] Invalid ELF header magic: !=3D ELF
[  155.336080][ T5816] Invalid ELF header magic: !=3D ELF
[  155.343905][ T5798] Invalid ELF header magic: !=3D ELF
[  155.344761][ T5798] Invalid ELF header magic: !=3D ELF
[  156.379592][ T5799] Invalid ELF header magic: !=3D ELF
[  157.306856][ T5820] Invalid ELF header magic: !=3D ELF
[  157.338210][ T5816] Invalid ELF header magic: !=3D ELF
[  158.341677][ T5816] Invalid ELF header magic: !=3D ELF
[  158.386870][ T5799] Invalid ELF header magic: !=3D ELF
[  159.395975][ T5799] Invalid ELF header magic: !=3D ELF
[  159.431610][ T5798] Invalid ELF header magic: !=3D ELF
[  160.239678][ T5827] Invalid ELF header magic: !=3D ELF
[  160.248786][ T5827] Invalid ELF header magic: !=3D ELF
[  160.397433][ T5799] Invalid ELF header magic: !=3D ELF
[  161.348277][ T5816] Invalid ELF header magic: !=3D ELF
[  161.357502][ T5816] Invalid ELF header magic: !=3D ELF
[  161.365831][ T5816] Invalid ELF header magic: !=3D ELF
[  161.478568][ T5798] Invalid ELF header magic: !=3D ELF
[  161.480402][ T5798] Invalid ELF header magic: !=3D ELF
[  162.411305][ T5846] Invalid ELF header magic: !=3D ELF
[  162.413025][ T5846] Invalid ELF header magic: !=3D ELF
[  163.401453][ T5799] Invalid ELF header magic: !=3D ELF
[  163.487345][ T5798] Invalid ELF header magic: !=3D ELF
[  163.489425][ T5798] Invalid ELF header magic: !=3D ELF
[  164.264070][ T5827] Invalid ELF header magic: !=3D ELF
[  164.394318][ T5856] Invalid ELF header magic: !=3D ELF
[  164.403256][ T5868] Invalid ELF header magic: !=3D ELF
[  166.319314][ T5867] Invalid ELF header magic: !=3D ELF
[  166.415379][ T5846] Invalid ELF header magic: !=3D ELF
[  166.421913][ T5868] Invalid ELF header magic: !=3D ELF
[  166.424178][ T5868] Invalid ELF header magic: !=3D ELF
[  166.425523][ T5868] Invalid ELF header magic: !=3D ELF
[  167.364783][ T5867] Invalid ELF header magic: !=3D ELF
[  167.419936][ T5863] Invalid ELF header magic: !=3D ELF
[  167.420660][ T5863] Invalid ELF header magic: !=3D ELF
[  167.500579][ T5880] Invalid ELF header magic: !=3D ELF
[  168.436655][ T5879] Invalid ELF header magic: !=3D ELF
[  168.515955][ T5846] Invalid ELF header magic: !=3D ELF
[  169.422511][ T5863] Invalid ELF header magic: !=3D ELF
[  169.438951][ T5879] Invalid ELF header magic: !=3D ELF
[  169.508867][ T5880] Invalid ELF header magic: !=3D ELF
[  170.438822][ T5887] Invalid ELF header magic: !=3D ELF
[  170.465667][ T5887] Invalid ELF header magic: !=3D ELF
[  170.515495][ T5880] Invalid ELF header magic: !=3D ELF
[  171.398221][ T5897] Invalid ELF header magic: !=3D ELF
[  171.403371][ T5897] Invalid ELF header magic: !=3D ELF
[  171.521798][ T5846] Invalid ELF header magic: !=3D ELF
[  172.412616][ T5897] Invalid ELF header magic: !=3D ELF
[  172.508372][ T5887] Invalid ELF header magic: !=3D ELF
[  172.517635][ T5880] Invalid ELF header magic: !=3D ELF
[  172.518170][ T5880] Invalid ELF header magic: !=3D ELF
[  173.516905][ T5887] Invalid ELF header magic: !=3D ELF
[  173.524720][ T5880] Invalid ELF header magic: !=3D ELF
[  173.587111][ T5898] Invalid ELF header magic: !=3D ELF
[  173.598228][ T5898] Invalid ELF header magic: !=3D ELF
[  173.602671][ T5898] Invalid ELF header magic: !=3D ELF
[  174.435846][ T5897] Invalid ELF header magic: !=3D ELF
[  175.493114][ T5879] Invalid ELF header magic: !=3D ELF
[  176.498593][ T5879] Invalid ELF header magic: !=3D ELF
[  176.499621][ T5879] Invalid ELF header magic: !=3D ELF
[  176.502313][ T5879] Invalid ELF header magic: !=3D ELF
[  176.506659][ T5879] Invalid ELF header magic: !=3D ELF
[  176.649614][ T5898] Invalid ELF header magic: !=3D ELF
[  176.650245][ T5898] Invalid ELF header magic: !=3D ELF
[  177.746721][ T5880] Invalid ELF header magic: !=3D ELF
[  177.748032][ T5880] Invalid ELF header magic: !=3D ELF
[  177.749313][ T5880] Invalid ELF header magic: !=3D ELF
[  177.750485][ T5880] Invalid ELF header magic: !=3D ELF
[  178.532631][ T5920] Invalid ELF header magic: !=3D ELF
[  178.539017][ T5921] Invalid ELF header magic: !=3D ELF
[  178.541259][ T5921] Invalid ELF header magic: !=3D ELF
[  179.546867][ T5921] Invalid ELF header magic: !=3D ELF
[  179.548387][ T5921] Invalid ELF header magic: !=3D ELF
[  180.462941][ T5897] Invalid ELF header magic: !=3D ELF
[  180.593146][ T5887] Invalid ELF header magic: !=3D ELF
[  180.594006][ T5887] Invalid ELF header magic: !=3D ELF
[  180.595103][ T5887] Invalid ELF header magic: !=3D ELF
[  180.595915][ T5887] Invalid ELF header magic: !=3D ELF
[  180.597104][ T5887] Invalid ELF header magic: !=3D ELF
[  180.600040][ T5887] Invalid ELF header magic: !=3D ELF
[  180.601001][ T5887] Invalid ELF header magic: !=3D ELF
[  180.769434][ T5880] Invalid ELF header magic: !=3D ELF
[  181.477187][ T5897] Invalid ELF header magic: !=3D ELF
[  181.565701][ T5921] Invalid ELF header magic: !=3D ELF
[  181.567858][ T5921] Invalid ELF header magic: !=3D ELF
[  181.675821][ T5928] Invalid ELF header magic: !=3D ELF
[  181.772961][ T5880] Invalid ELF header magic: !=3D ELF
[  182.555165][ T5879] Invalid ELF header magic: !=3D ELF
[  182.609486][ T5887] Invalid ELF header magic: !=3D ELF
[  182.697203][ T5928] Invalid ELF header magic: !=3D ELF
[  183.485644][ T5897] Invalid ELF header magic: !=3D ELF
[  183.739694][ T5928] scsi_nl_rcv_msg: discarding partial skb
[  184.804172][ T5880] Invalid ELF header magic: !=3D ELF
[  185.492948][ T5897] Invalid ELF header magic: !=3D ELF
[  185.563687][ T5879] Invalid ELF header magic: !=3D ELF
[  185.605322][ T5921] Invalid ELF header magic: !=3D ELF
[  185.606799][ T5921] Invalid ELF header magic: !=3D ELF
[  186.619378][ T5947] Invalid ELF header magic: !=3D ELF
[  187.763805][ T5928] Invalid ELF header magic: !=3D ELF
[  187.776980][ T5928] Invalid ELF header magic: !=3D ELF
[  187.818448][ T5880] Invalid ELF header magic: !=3D ELF
[  188.633469][ T5879] Invalid ELF header magic: !=3D ELF
[  188.635701][ T5879] Invalid ELF header magic: !=3D ELF
[  188.841184][ T5880] Invalid ELF header magic: !=3D ELF
[  189.632701][ T5947] Invalid ELF header magic: !=3D ELF
[  189.643105][ T5961] Invalid ELF header magic: !=3D ELF
[  189.804444][ T5928] Invalid ELF header magic: !=3D ELF
[  189.806186][ T5928] Invalid ELF header magic: !=3D ELF
[  189.809375][ T5928] Invalid ELF header magic: !=3D ELF
[  190.503847][ T5897] Invalid ELF header magic: !=3D ELF
[  190.557832][ T5897] Invalid ELF header magic: !=3D ELF
[  190.727213][ T5965] Invalid ELF header magic: !=3D ELF
[  191.657325][ T5961] Invalid ELF header magic: !=3D ELF
[  191.661589][ T5961] Invalid ELF header magic: !=3D ELF
[  191.663232][ T5961] Invalid ELF header magic: !=3D ELF
[  191.820219][ T5928] Invalid ELF header magic: !=3D ELF
[  192.643961][ T5948] Invalid ELF header magic: !=3D ELF
[  192.753999][ T5965] Invalid ELF header magic: !=3D ELF
[  193.651834][ T5948] Invalid ELF header magic: !=3D ELF
[  193.655779][ T5948] Invalid ELF header magic: !=3D ELF
[  193.832416][ T5928] Invalid ELF header magic: !=3D ELF
[  193.872054][ T5928] Invalid ELF header magic: !=3D ELF
[  194.797134][ T5965] Invalid ELF header magic: !=3D ELF
[  194.799817][ T5965] Invalid ELF header magic: !=3D ELF
[  194.931677][ T5880] Invalid ELF header magic: !=3D ELF
[  195.673442][ T5961] Invalid ELF header magic: !=3D ELF
[  195.679120][ T5948] Invalid ELF header magic: !=3D ELF
[  195.714166][ T5948] Invalid ELF header magic: !=3D ELF
[  195.714813][ T5948] Invalid ELF header magic: !=3D ELF
[  196.723900][ T5948] Invalid ELF header magic: !=3D ELF
[  197.581388][ T5897] Invalid ELF header magic: !=3D ELF
[  197.696986][ T5978] Invalid ELF header magic: !=3D ELF
[  197.835818][ T5965] Invalid ELF header magic: !=3D ELF
[  198.840747][ T5965] Invalid ELF header magic: !=3D ELF
[  198.932845][ T5928] Invalid ELF header magic: !=3D ELF
[  198.935307][ T5928] Invalid ELF header magic: !=3D ELF
[  198.936078][ T5928] Invalid ELF header magic: !=3D ELF
[  199.101633][ T5948] Invalid ELF header magic: !=3D ELF
[  199.586194][ T5897] Invalid ELF header magic: !=3D ELF
[  199.859195][ T5965] Invalid ELF header magic: !=3D ELF
[  199.861243][ T5965] Invalid ELF header magic: !=3D ELF
[  200.111619][ T5948] Invalid ELF header magic: !=3D ELF
[  200.822502][ T5991] Invalid ELF header magic: !=3D ELF
[  200.864517][ T5965] Invalid ELF header magic: !=3D ELF
[  200.941689][ T5880] Invalid ELF header magic: !=3D ELF
[  201.872002][ T5965] Invalid ELF header magic: !=3D ELF
[  201.873127][ T5965] Invalid ELF header magic: !=3D ELF
[  201.965269][ T5928] Invalid ELF header magic: !=3D ELF
[  202.126939][ T6007] Invalid ELF header magic: !=3D ELF
[  202.145074][ T6007] Invalid ELF header magic: !=3D ELF
[  202.848780][ T5991] Invalid ELF header magic: !=3D ELF
[  203.856950][ T5991] Invalid ELF header magic: !=3D ELF
[  203.968197][ T5880] Invalid ELF header magic: !=3D ELF
[  203.971446][ T5880] Invalid ELF header magic: !=3D ELF
[  203.975514][ T5880] Invalid ELF header magic: !=3D ELF
[  204.174264][ T6007] Invalid ELF header magic: !=3D ELF
[  205.190016][ T6022] Invalid ELF header magic: !=3D ELF
[  205.907694][ T6017] Invalid ELF header magic: !=3D ELF
[  206.911498][ T6017] Invalid ELF header magic: !=3D ELF
[  206.977621][ T6017] Invalid ELF header magic: !=3D ELF
[  207.022946][ T5880] Invalid ELF header magic: !=3D ELF
[  207.027567][ T5880] Invalid ELF header magic: !=3D ELF
[  208.910493][ T5965] Invalid ELF header magic: !=3D ELF
[  208.915267][ T5965] Invalid ELF header magic: !=3D ELF
[  208.921572][ T5965] Invalid ELF header magic: !=3D ELF
[  209.029596][ T5928] Invalid ELF header magic: !=3D ELF
[  210.033240][ T5880] Invalid ELF header magic: !=3D ELF
[  210.036571][ T5880] Invalid ELF header magic: !=3D ELF
[  210.235156][ T6022] Invalid ELF header magic: !=3D ELF
[  211.042068][ T5880] Invalid ELF header magic: !=3D ELF
[  211.044480][ T5880] Invalid ELF header magic: !=3D ELF
[  211.046156][ T5928] Invalid ELF header magic: !=3D ELF
[  212.050564][ T5928] Invalid ELF header magic: !=3D ELF
[  213.023281][ T6045] Invalid ELF header magic: !=3D ELF
[  213.072407][ T6045] Invalid ELF header magic: !=3D ELF
[  213.108397][ T5880] Invalid ELF header magic: !=3D ELF
[  214.077131][ T6056] Invalid ELF header magic: !=3D ELF
[  214.100848][ T6034] Invalid ELF header magic: !=3D ELF
[  215.964837][ T5965] Invalid ELF header magic: !=3D ELF
[  215.973529][ T6022] Invalid ELF header magic: !=3D ELF
[  215.978642][ T6022] Invalid ELF header magic: !=3D ELF
[  215.978948][ T6066] Invalid ELF header magic: !=3D ELF
[  215.992292][ T6066] Invalid ELF header magic: !=3D ELF
[  216.000125][ T6066] Invalid ELF header magic: !=3D ELF
[  216.203669][ T5880] Invalid ELF header magic: !=3D ELF
[  216.742468][ T6038] Invalid ELF header magic: !=3D ELF
[  217.001999][ T6038] Invalid ELF header magic: !=3D ELF
[  217.004921][ T6038] Invalid ELF header magic: !=3D ELF
[  217.135784][ T6034] Invalid ELF header magic: !=3D ELF
[  218.004392][ T6022] Invalid ELF header magic: !=3D ELF
[  218.008205][ T6022] Invalid ELF header magic: !=3D ELF
[  218.010384][ T6022] Invalid ELF header magic: !=3D ELF
[  218.013585][ T6022] Invalid ELF header magic: !=3D ELF
[  218.215516][ T5880] Invalid ELF header magic: !=3D ELF
[  219.014304][ T6066] Invalid ELF header magic: !=3D ELF
[  219.023924][ T6038] Invalid ELF header magic: !=3D ELF
[  220.020016][ T6022] Invalid ELF header magic: !=3D ELF
[  220.044156][ T6081] Invalid ELF header magic: !=3D ELF
[  220.122759][ T6045] Invalid ELF header magic: !=3D ELF
[  221.130561][ T6045] Invalid ELF header magic: !=3D ELF
[  221.132830][ T6045] Invalid ELF header magic: !=3D ELF
[  223.102555][ T6081] Invalid ELF header magic: !=3D ELF
[  223.184267][ T6056] Invalid ELF header magic: !=3D ELF
[  223.198444][ T6056] Invalid ELF header magic: !=3D ELF
[  223.312612][ T6091] Invalid ELF header magic: !=3D ELF
[  224.062894][ T6081] Invalid ELF header magic: !=3D ELF
[  224.066287][ T6081] Invalid ELF header magic: !=3D ELF
[  224.069918][ T6081] Invalid ELF header magic: !=3D ELF
[  224.180131][ T6034] Invalid ELF header magic: !=3D ELF
[  224.327639][ T6091] Invalid ELF header magic: !=3D ELF
[  224.330031][ T6091] Invalid ELF header magic: !=3D ELF
[  225.189273][ T6034] Invalid ELF header magic: !=3D ELF
[  225.218852][ T6056] Invalid ELF header magic: !=3D ELF
[  226.065122][ T6056] Invalid ELF header magic: !=3D ELF
[  226.205212][ T6104] Invalid ELF header magic: !=3D ELF
[  227.701322][ T6104] Invalid ELF header magic: !=3D ELF
[  227.701896][ T6104] Invalid ELF header magic: !=3D ELF
[  228.050997][ T6022] Invalid ELF header magic: !=3D ELF
[  228.052828][ T6022] Invalid ELF header magic: !=3D ELF
[  228.353961][ T6108] Invalid ELF header magic: !=3D ELF
[  228.355717][ T6108] Invalid ELF header magic: !=3D ELF
[  229.059884][ T6022] Invalid ELF header magic: !=3D ELF
[  229.091051][ T6081] Invalid ELF header magic: !=3D ELF
[  229.096121][ T6077] Invalid ELF header magic: !=3D ELF
[  229.098027][ T6077] Invalid ELF header magic: !=3D ELF
[  229.362323][ T6108] Invalid ELF header magic: !=3D ELF
[  229.711369][ T6104] Invalid ELF header magic: !=3D ELF
[  229.721874][ T6104] Invalid ELF header magic: !=3D ELF
[  231.795470][ T6104] Invalid ELF header magic: !=3D ELF
[  231.801224][ T6104] Invalid ELF header magic: !=3D ELF
[  231.807277][ T6104] Invalid ELF header magic: !=3D ELF
[  231.807986][ T6104] Invalid ELF header magic: !=3D ELF
[  232.113809][ T6077] Invalid ELF header magic: !=3D ELF
[  232.115710][ T6077] Invalid ELF header magic: !=3D ELF
[  232.133232][ T6118] Invalid ELF header magic: !=3D ELF
[  233.128745][ T6056] Invalid ELF header magic: !=3D ELF
[  233.138912][ T6118] Invalid ELF header magic: !=3D ELF
[  233.151002][ T6056] Invalid ELF header magic: !=3D ELF
[  233.186370][ T6118] Invalid ELF header magic: !=3D ELF
[  234.097024][ T6125] Invalid ELF header magic: !=3D ELF
[  234.189125][ T6045] Invalid ELF header magic: !=3D ELF
[  234.422049][ T6130] Invalid ELF header magic: !=3D ELF
[  235.140912][ T6077] Invalid ELF header magic: !=3D ELF
[  235.216656][ T6056] Invalid ELF header magic: !=3D ELF
[  235.217758][ T6056] Invalid ELF header magic: !=3D ELF
[  235.221997][ T6045] Invalid ELF header magic: !=3D ELF
[  235.228748][ T6045] Invalid ELF header magic: !=3D ELF
[  235.816823][ T6104] Invalid ELF header magic: !=3D ELF
[  235.820477][ T6104] Invalid ELF header magic: !=3D ELF
[  236.441153][ T6130] Invalid ELF header magic: !=3D ELF
[  237.245260][ T6045] Invalid ELF header magic: !=3D ELF
[  239.149642][ T6077] Invalid ELF header magic: !=3D ELF
[  239.181197][ T6140] Invalid ELF header magic: !=3D ELF
[  239.245128][ T6118] Invalid ELF header magic: !=3D ELF
[  239.253174][ T6118] Invalid ELF header magic: !=3D ELF
[  239.474793][ T6130] Invalid ELF header magic: !=3D ELF
[  239.479182][ T6130] Invalid ELF header magic: !=3D ELF
[  239.874104][ T6104] Invalid ELF header magic: !=3D ELF
[  239.878119][ T6104] Invalid ELF header magic: !=3D ELF
[  239.885710][ T6104] Invalid ELF header magic: !=3D ELF
[  240.929152][ T6156] Invalid ELF header magic: !=3D ELF
[  241.199864][ T6140] Invalid ELF header magic: !=3D ELF
[  241.489759][ T6130] Invalid ELF header magic: !=3D ELF
[  241.493331][ T6130] Invalid ELF header magic: !=3D ELF
[  241.495934][ T6130] Invalid ELF header magic: !=3D ELF
[  241.497730][ T6130] Invalid ELF header magic: !=3D ELF
[  241.936319][ T6156] Invalid ELF header magic: !=3D ELF
[  241.941910][ T6156] Invalid ELF header magic: !=3D ELF
[  242.205275][ T6140] Invalid ELF header magic: !=3D ELF
[  242.279413][ T6118] Invalid ELF header magic: !=3D ELF
[  242.301701][ T6056] Invalid ELF header magic: !=3D ELF
[  243.263858][ T6166] Invalid ELF header magic: !=3D ELF
[  244.513234][ T6130] Invalid ELF header magic: !=3D ELF
[  245.050866][ T6056] Invalid ELF header magic: !=3D ELF
[  245.052877][ T6056] Invalid ELF header magic: !=3D ELF
[  245.309604][ T6077] Invalid ELF header magic: !=3D ELF
[  245.519099][ T6130] Invalid ELF header magic: !=3D ELF
[  246.070321][ T6170] Invalid ELF header magic: !=3D ELF
[  246.075846][ T6170] Invalid ELF header magic: !=3D ELF
[  246.080139][ T6170] Invalid ELF header magic: !=3D ELF
[  246.525636][ T6130] Invalid ELF header magic: !=3D ELF
[  247.101410][ T6178] Invalid ELF header magic: !=3D ELF
[  247.540233][ T6130] Invalid ELF header magic: !=3D ELF
[  248.005242][ T6156] Invalid ELF header magic: !=3D ELF
[  248.008630][ T6156] Invalid ELF header magic: !=3D ELF
[  248.111633][ T6181] Invalid ELF header magic: !=3D ELF
[  249.337885][ T6077] Invalid ELF header magic: !=3D ELF
[  250.080660][ T6156] Invalid ELF header magic: !=3D ELF
[  250.116708][ T6181] Invalid ELF header magic: !=3D ELF
[  250.359112][ T6077] Invalid ELF header magic: !=3D ELF
[  251.132571][ T6170] Invalid ELF header magic: !=3D ELF
[  251.135300][ T6170] Invalid ELF header magic: !=3D ELF
[  251.362824][ T6077] Invalid ELF header magic: !=3D ELF
[  252.129880][ T6181] Invalid ELF header magic: !=3D ELF
[  252.320029][ T6045] Invalid ELF header magic: !=3D ELF
[  252.605562][ T6201] Invalid ELF header magic: !=3D ELF
[  253.149629][ T6170] Invalid ELF header magic: !=3D ELF
[  253.150384][ T6170] Invalid ELF header magic: !=3D ELF
[  253.155697][ T6170] Invalid ELF header magic: !=3D ELF
[  253.682139][ T6201] Invalid ELF header magic: !=3D ELF
[  254.137400][ T6181] Invalid ELF header magic: !=3D ELF
[  254.331739][ T6208] Invalid ELF header magic: !=3D ELF
[  254.692047][ T6201] Invalid ELF header magic: !=3D ELF
[  254.692873][ T6201] Invalid ELF header magic: !=3D ELF
[  255.396870][ T6077] Invalid ELF header magic: !=3D ELF
[  255.402673][ T6077] Invalid ELF header magic: !=3D ELF
[  257.390894][ T6209] Invalid ELF header magic: !=3D ELF
[  257.713360][ T6201] Invalid ELF header magic: !=3D ELF
[  257.728737][ T6201] Invalid ELF header magic: !=3D ELF
[  258.400969][ T6209] Invalid ELF header magic: !=3D ELF
[  258.418724][ T6077] Invalid ELF header magic: !=3D ELF
[  258.428385][ T6209] Invalid ELF header magic: !=3D ELF
[  259.235152][ T6231] Invalid ELF header magic: !=3D ELF
[  259.235720][ T6231] Invalid ELF header magic: !=3D ELF
[  259.236571][ T6231] Invalid ELF header magic: !=3D ELF
[  259.420965][ T6077] Invalid ELF header magic: !=3D ELF
[  259.455031][ T6077] Invalid ELF header magic: !=3D ELF
[  259.751652][ T6201] Invalid ELF header magic: !=3D ELF
[  259.752201][ T6201] Invalid ELF header magic: !=3D ELF
[  260.439609][ T6209] Invalid ELF header magic: !=3D ELF
[  261.244016][ T6231] Invalid ELF header magic: !=3D ELF
[  261.494758][ T6232] Invalid ELF header magic: !=3D ELF
[  262.506956][ T6232] Invalid ELF header magic: !=3D ELF
[  263.064402][ T6209] Invalid ELF header magic: !=3D ELF
[  263.078692][ T6209] Invalid ELF header magic: !=3D ELF
[  264.256106][ T6231] Invalid ELF header magic: !=3D ELF
[  264.532719][ T6232] Invalid ELF header magic: !=3D ELF
[  265.543882][ T6232] Invalid ELF header magic: !=3D ELF
[  267.134972][ T6209] Invalid ELF header magic: !=3D ELF
[  267.135724][ T6209] Invalid ELF header magic: !=3D ELF
[  269.066879][ T6232] Invalid ELF header magic: !=3D ELF
[  269.279612][ T6231] Invalid ELF header magic: !=3D ELF
[  269.280280][ T6231] Invalid ELF header magic: !=3D ELF
[  270.151089][ T6209] Invalid ELF header magic: !=3D ELF
[  272.123103][ T6231] Invalid ELF header magic: !=3D ELF
[  273.190982][ T6209] Invalid ELF header magic: !=3D ELF
[  277.207488][ T6209] Invalid ELF header magic: !=3D ELF
[  277.218727][ T6209] Invalid ELF header magic: !=3D ELF
[  277.219914][ T6209] Invalid ELF header magic: !=3D ELF
[  278.097597][ T6232] Invalid ELF header magic: !=3D ELF
[  278.107965][ T6232] Invalid ELF header magic: !=3D ELF
[  279.230153][ T6231] Invalid ELF header magic: !=3D ELF
[  279.276150][ T6231] Invalid ELF header magic: !=3D ELF
[  280.282950][ T6231] Invalid ELF header magic: !=3D ELF
[  280.347430][ T6231] Invalid ELF header magic: !=3D ELF
[  281.228446][ T6209] Invalid ELF header magic: !=3D ELF
[  282.131610][ T6296] Invalid ELF header magic: !=3D ELF
[  282.291347][ T6209] Invalid ELF header magic: !=3D ELF
[  283.138548][ T6296] Invalid ELF header magic: !=3D ELF
[  283.300328][ T6209] Invalid ELF header magic: !=3D ELF
[  284.131079][ T6309] Invalid ELF header magic: !=3D ELF
[  284.137848][ T6315] Invalid ELF header magic: !=3D ELF
[  284.143352][ T6315] Invalid ELF header magic: !=3D ELF
[  284.318948][ T6209] Invalid ELF header magic: !=3D ELF
[  285.323099][ T6209] Invalid ELF header magic: !=3D ELF
[  286.147206][ T6315] Invalid ELF header magic: !=3D ELF
[  286.149446][ T6316] Invalid ELF header magic: !=3D ELF
[  286.161702][ T6315] Invalid ELF header magic: !=3D ELF
[  286.192123][ T6316] Invalid ELF header magic: !=3D ELF
[  286.327292][ T6209] Invalid ELF header magic: !=3D ELF
[  288.164565][ T6317] Invalid ELF header magic: !=3D ELF
[  288.176859][ T6311] Invalid ELF header magic: !=3D ELF
[  288.188264][ T6311] Invalid ELF header magic: !=3D ELF
[  289.101281][ T6335] Invalid ELF header magic: !=3D ELF
[  289.161093][ T6336] Invalid ELF header magic: !=3D ELF
[  289.163634][ T6336] Invalid ELF header magic: !=3D ELF
[  289.222803][ T6316] Invalid ELF header magic: !=3D ELF
[  289.397700][ T6324] Invalid ELF header magic: !=3D ELF
[  290.165722][ T6336] Invalid ELF header magic: !=3D ELF
[  290.200963][ T6311] Invalid ELF header magic: !=3D ELF
[  290.228128][ T6337] Invalid ELF header magic: !=3D ELF
[  291.278861][ T6338] Invalid ELF header magic: !=3D ELF
[  291.287321][ T6338] Invalid ELF header magic: !=3D ELF
[  291.290179][ T6338] Invalid ELF header magic: !=3D ELF
[  292.148353][ T6335] Invalid ELF header magic: !=3D ELF
[  292.185200][ T6342] Invalid ELF header magic: !=3D ELF
[  292.206504][ T6317] Invalid ELF header magic: !=3D ELF
[  292.217208][ T6317] Invalid ELF header magic: !=3D ELF
[  292.420311][ T6324] Invalid ELF header magic: !=3D ELF
[  292.440511][ T6324] Invalid ELF header magic: !=3D ELF
[  293.161828][ T6335] Invalid ELF header magic: !=3D ELF
[  293.218903][ T6317] Invalid ELF header magic: !=3D ELF
[  293.228373][ T6317] Invalid ELF header magic: !=3D ELF
[  293.249903][ T6311] Invalid ELF header magic: !=3D ELF
[  293.282294][ T6357] Invalid ELF header magic: !=3D ELF
[  293.283832][ T6357] Invalid ELF header magic: !=3D ELF
[  295.183014][ T6335] Invalid ELF header magic: !=3D ELF
[  295.373493][ T6357] Invalid ELF header magic: !=3D ELF
[  295.376129][ T6357] Invalid ELF header magic: !=3D ELF
[  296.345236][ T6369] Invalid ELF header magic: !=3D ELF
[  296.388380][ T6357] Invalid ELF header magic: !=3D ELF
[  297.285735][ T6342] Invalid ELF header magic: !=3D ELF
[  297.287786][ T6342] Invalid ELF header magic: !=3D ELF
[  297.399380][ T6357] Invalid ELF header magic: !=3D ELF
[  297.401873][ T6369] Invalid ELF header magic: !=3D ELF
[  297.405222][ T6357] Invalid ELF header magic: !=3D ELF
[  298.077811][ T6355] Invalid ELF header magic: !=3D ELF
[  298.080654][ T6355] Invalid ELF header magic: !=3D ELF
[  298.339317][ T6342] Invalid ELF header magic: !=3D ELF
[  298.414276][ T6357] Invalid ELF header magic: !=3D ELF
[  299.356521][ T6368] Invalid ELF header magic: !=3D ELF
[  300.110072][ T6355] Invalid ELF header magic: !=3D ELF
[  300.110729][ T6311] Invalid ELF header magic: !=3D ELF
[  300.214849][ T6335] Invalid ELF header magic: !=3D ELF
[  300.358251][ T6368] Invalid ELF header magic: !=3D ELF
[  300.368129][ T6342] Invalid ELF header magic: !=3D ELF
[  300.370772][ T6368] Invalid ELF header magic: !=3D ELF
[  300.397672][ T6368] Invalid ELF header magic: !=3D ELF
[  301.156547][ T6355] Invalid ELF header magic: !=3D ELF
[  301.159709][ T6355] Invalid ELF header magic: !=3D ELF
[  302.066137][ T6357] Invalid ELF header magic: !=3D ELF
[  302.247910][ T6335] Invalid ELF header magic: !=3D ELF
[  303.174229][ T6311] Invalid ELF header magic: !=3D ELF
[  303.176171][ T6311] Invalid ELF header magic: !=3D ELF
[  304.080056][ T6357] Invalid ELF header magic: !=3D ELF
[  304.081827][ T6357] Invalid ELF header magic: !=3D ELF
[  304.184631][ T6311] Invalid ELF header magic: !=3D ELF
[  304.186447][ T6311] Invalid ELF header magic: !=3D ELF
[  304.465207][ T6368] Invalid ELF header magic: !=3D ELF
[  305.470626][ T6368] Invalid ELF header magic: !=3D ELF
[  305.488242][ T6368] Invalid ELF header magic: !=3D ELF
[  305.491015][ T6368] Invalid ELF header magic: !=3D ELF
[  306.195693][ T6311] Invalid ELF header magic: !=3D ELF
[  306.292848][ T6335] Invalid ELF header magic: !=3D ELF
[  307.099296][ T6405] Invalid ELF header magic: !=3D ELF
[  307.210772][ T6311] Invalid ELF header magic: !=3D ELF
[  307.220650][ T6311] Invalid ELF header magic: !=3D ELF
[  307.404716][ T6388] Invalid ELF header magic: !=3D ELF
INIT: Id "S1" respawning too fast: disabled for 5 minutes
[  308.109725][ T6572] Invalid ELF header magic: !=3D ELF
[  308.420151][ T6409] Invalid ELF header magic: !=3D ELF
[  308.502779][ T6368] Invalid ELF header magic: !=3D ELF
[  309.117735][ T6405] Invalid ELF header magic: !=3D ELF
[  309.125662][ T6572] Invalid ELF header magic: !=3D ELF
[  309.315468][ T6335] Invalid ELF header magic: !=3D ELF
[  309.437930][ T6573] Invalid ELF header magic: !=3D ELF
[  310.129735][ T6405] Invalid ELF header magic: !=3D ELF
[  310.149696][ T6405] Invalid ELF header magic: !=3D ELF
[  310.235610][ T6311] Invalid ELF header magic: !=3D ELF
[  310.321040][ T6335] Invalid ELF header magic: !=3D ELF
[  310.334867][ T6335] Invalid ELF header magic: !=3D ELF
[  310.347055][ T6591] Invalid ELF header magic: !=3D ELF
[  310.348832][ T6591] Invalid ELF header magic: !=3D ELF
[  310.350232][ T6591] Invalid ELF header magic: !=3D ELF
[  310.351867][ T6591] Invalid ELF header magic: !=3D ELF
LKP: ttyS0: 1742: LKP: tbox cant kexec and rebooting forcely
[  310.711907][ T1742] sysrq: Emergency Sync
[  310.712335][   T41] Emergency Sync complete
[  310.712739][ T1742] sysrq: Resetting

--csx8ktZH1zvSCQRU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="next-20260123-ca3a02fda4da-run.log"
Content-Transfer-Encoding: quoted-printable

$ sudo bin/lkp qemu -k vmlinuz-6.19.0-rc6-next-20260123 -m modules-6.19.0-r=
c6-next-20260123.cgz job-script
result_root: /home/xsang/.lkp//result/trinity/group-00-5-300s/vm-snb/yocto-=
x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a=
66ad331fe2b3b6f/11
downloading initrds ...
use local modules: /home/xsang/.lkp/cache/modules-6.19.0-rc6-next-20260123.=
cgz
skip downloading /home/xsang/.lkp/cache/osimage/yocto/yocto-x86_64-minimal-=
20190520.cgz
19270 blocks
skip downloading /home/xsang/.lkp/cache/osimage/pkg/debian-x86_64-20180403.=
cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz
43381 blocks
exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev local,=
id=3Dtest_dev,path=3D/home/xsang/.lkp//result/trinity/group-00-5-300s/vm-sn=
b/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2=
969f429a66ad331fe2b3b6f/11,security_model=3Dnone -device virtio-9p-pci,fsde=
v=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel vmlinuz-6.19.0-rc6-next-20=
260123 -append root=3D/dev/ram0 RESULT_ROOT=3D/result/trinity/group-00-5-30=
0s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4f=
e4d07eb2969f429a66ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/linux/x86_64-kexec/clan=
g-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/vmlinuz-6.19.0-rc1-00006-g313=
c47f4fe4d branch=3Dinternal-devel/devel-hourly-20260124-050739 job=3D/lkp/j=
obs/scheduled/vm-meta-17/trinity-group-00-5-300s-yocto-x86_64-minimal-20190=
520.cgz-313c47f4fe4d-20260126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx86_64=
 kconfig=3Dx86_64-kexec commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6f i=
ntremap=3Dposted_msi watchdog_thresh=3D240 rcuperf.shutdown=3D0 rcuscale.sh=
utdown=3D0 refscale.shutdown=3D0 audit=3D0 kunit.enable=3D0 ia32_emulation=
=3Don max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sy=
srq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 pri=
ntk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=
=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.l=
og_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 co=
nsole=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddhcp result_service=3D9p/virtfs_=
mount -initrd /home/xsang/.lkp/cache/final_initrd -smp 2 -m 32768M -no-rebo=
ot -device i6300esb -rtc base=3Dlocaltime -device e1000,netdev=3Dnet0 -netd=
ev user,id=3Dnet0 -display none -monitor null -serial stdio
early console in setup code
No EFI environment detected.
early console in extract_kernel
input_data: 0x00000000031dc2c4
input_len: 0x0000000000cf4a2d
output: 0x0000000001000000
output_len: 0x0000000002e81880
kernel_total_size: 0x0000000002c28000
needed_size: 0x0000000003000000
trampoline_32bit: 0x0000000000000000

Decompressing Linux... Parsing ELF... done.
Booting the kernel (entry_offset: 0x0000000002724870).
[    0.000000][    T0] Linux version 6.19.0-rc6-next-20260123 (kbuild@9cc20=
38e482f) (clang version 20.1.8 (git://gitmirror/llvm_project 87f0227cb60147=
a26a1eeb4fb06e3b505e9c7261), LLD 20.1.8 (git://gitmirror/llvm_project 87f02=
27cb60147a26a1eeb4fb06e3b505e9c7261)) #1 SMP PREEMPT_DYNAMIC Sun Jan 25 17:=
41:18 CET 2026
[    0.000000][    T0] Command line: root=3D/dev/ram0 RESULT_ROOT=3D/result=
/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-ke=
xec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/l=
inux/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/vmlinuz=
-6.19.0-rc1-00006-g313c47f4fe4d branch=3Dinternal-devel/devel-hourly-202601=
24-050739 job=3D/lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-300s-yoct=
o-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-19zhjsh-2.yaml us=
er=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-kexec commit=3D313c47f4fe4d07eb2969=
f429a66ad331fe2b3b6f intremap=3Dposted_msi watchdog_thresh=3D240 rcuperf.sh=
utdown=3D0 rcuscale.shutdown=3D0 refscale.shutdown=3D0 audit=3D0 kunit.enab=
le=3D0 ia32_emulation=3Don max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 =
debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D10=
0 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_w=
atchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor=
_count=3D8 systemd.log_level=3Derr ignore_loglevel console
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0]   Hygon HygonGenuine
[    0.000000][    T0]   Centaur CentaurHauls
[    0.000000][    T0]   zhaoxin   Shanghai
[    0.000000][    T0] x86/CPU: Model not found in latest microcode list
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbf=
f]  System RAM
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009fff=
f]  device reserved
[    0.000000][    T0] BIOS-e820: [gap 0x00000000000a0000-0x00000000000efff=
f]
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000ffff=
f]  device reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdfff=
f]  System RAM
[    0.000000][    T0] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bffffff=
f]  device reserved
[    0.000000][    T0] BIOS-e820: [gap 0x00000000c0000000-0x00000000feffbff=
f]
[    0.000000][    T0] BIOS-e820: [mem 0x00000000feffc000-0x00000000fefffff=
f]  device reserved
[    0.000000][    T0] BIOS-e820: [gap 0x00000000ff000000-0x00000000fffbfff=
f]
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000fffffff=
f]  device reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000083ffffff=
f]  System RAM
[    0.000000][    T0] printk: debug: ignoring loglevel setting.
[    0.000000][    T0] printk: legacy bootconsole [earlyser0] enabled
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] APIC: Static calls initialized
[    0.000000][    T0] SMBIOS 2.8 present.
[    0.000000][    T0] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.=
15.0-1 04/01/2014
[    0.000000][    T0] DMI: Memory slots populated: 2/2
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] last_pfn =3D 0xbffe0 max_arch_pfn =3D 0x400000000
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000002][    T0] kvm-clock: using sched offset of 393908548 cycles
[    0.000555][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max=
_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.002105][    T0] tsc: Detected 3000.000 MHz processor
[    0.003147][    T0] e820: update [mem 0x00000000-0x00000fff] System RAM =
=3D=3D> device reserved
[    0.003851][    T0] e820: remove [mem 0x000a0000-0x000fffff] System RAM
[    0.004412][    T0] last_pfn =3D 0x840000 max_arch_pfn =3D 0x400000000
[    0.004977][    T0] MTRR map: 4 entries (3 fixed + 1 variable; max 19), =
built from 8 variable MTRRs
[    0.005751][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP=
  UC- WT
[    0.006410][    T0] last_pfn =3D 0xbffe0 max_arch_pfn =3D 0x400000000
[    0.006924][    T0] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.007476][    T0] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.008013][    T0] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.013350][    T0] found SMP MP-table at [mem 0x000f5b90-0x000f5b9f]
[    0.013943][    T0]   mpc: f5ba0-f5c78
[    0.014718][    T0] RAMDISK: [mem 0xb211b000-0xbffdffff]
[    0.015172][    T0] ACPI: Early table checksum verification disabled
[    0.015703][    T0] ACPI: RSDP 0x00000000000F5970 000014 (v00 BOCHS )
[    0.016329][    T0] ACPI: RSDT 0x00000000BFFE196E 000034 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.017136][    T0] ACPI: FACP 0x00000000BFFE181A 000074 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.017928][    T0] ACPI: DSDT 0x00000000BFFE0040 0017DA (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.018703][    T0] ACPI: FACS 0x00000000BFFE0000 000040
[    0.019155][    T0] ACPI: APIC 0x00000000BFFE188E 000080 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.019929][    T0] ACPI: HPET 0x00000000BFFE190E 000038 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.020691][    T0] ACPI: WAET 0x00000000BFFE1946 000028 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)
[    0.021494][    T0] ACPI: Reserving FACP table memory at [mem 0xbffe181a=
-0xbffe188d]
[    0.022157][    T0] ACPI: Reserving DSDT table memory at [mem 0xbffe0040=
-0xbffe1819]
[    0.022823][    T0] ACPI: Reserving FACS table memory at [mem 0xbffe0000=
-0xbffe003f]
[    0.023489][    T0] ACPI: Reserving APIC table memory at [mem 0xbffe188e=
-0xbffe190d]
[    0.024139][    T0] ACPI: Reserving HPET table memory at [mem 0xbffe190e=
-0xbffe1945]
[    0.024831][    T0] ACPI: Reserving WAET table memory at [mem 0xbffe1946=
-0xbffe196d]
[    0.025545][    T0] Mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.026279][    T0] No NUMA configuration found
[    0.026669][    T0] Faking a node at [mem 0x0000000000000000-0x000000083=
fffffff]
[    0.027304][    T0] NODE_DATA(0) allocated [mem 0x83ffe0380-0x83ffe4fff]
[    0.027879][    T0] cma: Reserved 200 MiB at 0x0000000100000000
[    0.028595][    T0] ACPI: PM-Timer IO Port: 0x608
[    0.029022][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.029577][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23
[    0.030212][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl =
dfl)
[    0.030811][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID =
0, APIC INT 02
[    0.031520][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)
[    0.032201][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID =
0, APIC INT 05
[    0.032871][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)
[    0.033497][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID =
0, APIC INT 09
[    0.034164][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)
[    0.034818][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID =
0, APIC INT 0a
[    0.035521][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)
[    0.036136][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID =
0, APIC INT 0b
[    0.036802][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID =
0, APIC INT 01
[    0.037464][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID =
0, APIC INT 03
[    0.038131][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID =
0, APIC INT 04
[    0.038833][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID =
0, APIC INT 06
[    0.039567][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID =
0, APIC INT 07
[    0.040231][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID =
0, APIC INT 08
[    0.040911][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID =
0, APIC INT 0c
[    0.041613][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID =
0, APIC INT 0d
[    0.042308][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID =
0, APIC INT 0e
[    0.042983][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID =
0, APIC INT 0f
[    0.043640][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation
[    0.044237][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.044730][    T0] TSC deadline timer available
[    0.045113][    T0] CPU topo: Max. logical packages:   1
[    0.045556][    T0] CPU topo: Max. logical dies:       1
[    0.046004][    T0] CPU topo: Max. dies per package:   1
[    0.046501][    T0] CPU topo: Max. threads per core:   1
[    0.046976][    T0] CPU topo: Num. cores per package:     2
[    0.047444][    T0] CPU topo: Num. threads per package:   2
[    0.047907][    T0] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPU=
s
[    0.048480][    T0] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.048989][    T0] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_=
eoi_write()
[    0.049698][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
000000-0x00000fff]
[    0.050397][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
09f000-0x000fffff]
[    0.051092][    T0] PM: hibernation: Registered nosave memory: [mem 0xbf=
fe0000-0xffffffff]
[    0.051794][    T0] [gap 0xc0000000-0xfeffbfff] available for PCI device=
s
[    0.052360][    T0] Booting paravirtualized kernel on KVM
[    0.052816][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.131336][    T0] Zone ranges:
[    0.131662][    T0]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]
[    0.132280][    T0]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]
[    0.132927][    T0]   Normal   [mem 0x0000000100000000-0x000000083ffffff=
f]
[    0.133531][    T0]   Device   empty
[    0.133828][    T0] Movable zone start for each node
[    0.134241][    T0] Early memory node ranges
[    0.134596][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ef=
ff]
[    0.135194][    T0]   node   0: [mem 0x0000000000100000-0x00000000bffdff=
ff]
[    0.135791][    T0]   node   0: [mem 0x0000000100000000-0x000000083fffff=
ff]
[    0.136382][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
0083fffffff]
[    0.137046][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.137614][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.177279][    T0] On node 0, zone Normal: 32 pages in unavailable rang=
es
[    0.177970][    T0] setup_percpu: NR_CPUS:512 nr_cpumask_bits:2 nr_cpu_i=
ds:2 nr_node_ids:1
[    0.179091][    T0] percpu: Embedded 55 pages/cpu s185304 r8192 d31784 u=
1048576
[    0.179802][    T0] pcpu-alloc: s185304 r8192 d31784 u1048576 alloc=3D1*=
2097152
[    0.180429][    T0] pcpu-alloc: [0] 0 1
[    0.180783][    T0] Kernel command line: root=3D/dev/ram0 RESULT_ROOT=3D=
/result/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x8=
6_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 BOOT_IMAGE=
=3D/pkg/linux/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6=
f/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d branch=3Dinternal-devel/devel-hour=
ly-20260124-050739 job=3D/lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-=
300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-19zhjsh-=
2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-kexec commit=3D313c47f4fe4=
d07eb2969f429a66ad331fe2b3b6f intremap=3Dposted_msi watchdog_thresh=3D240 r=
cuperf.shutdown=3D0 rcuscale.shutdown=3D0 refscale.shutdown=3D0 audit=3D0 k=
unit.enable=3D0 ia32_emulation=3Don max_uptime=3D7200 LKP_LOCAL_RUN=3D1 sel=
inux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_tim=
eout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=
=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 =
drbd.minor_count=3D8 systemd.log_level=3Derr \
[    0.188386][    T0] Kernel command line: ignore_loglevel console=3Dtty0 =
earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddhc=
p result_service=3D9p/virtfs_mount
[    0.190055][    T0] audit: disabled (until reboot)
[    0.190558][    T0] sysrq: sysrq always enabled.
[    0.191142][    T0] Unknown kernel command line parameters "RESULT_ROOT=
=3D/result/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz=
/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 branch=3D=
internal-devel/devel-hourly-20260124-050739 job=3D/lkp/jobs/scheduled/vm-me=
ta-17/trinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4=
d-20260126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-k=
exec commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6f ia32_emulation=3Don =
max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 nmi_watchdog=3Dpanic load_r=
amdisk=3D2 prompt_ramdisk=3D0 vga=3Dnormal result_service=3D9p/virtfs_mount=
", will be passed to user space.
[    0.196119][    T0] printk: log buffer data + meta data: 1048576 + 36700=
16 =3D 4718592 bytes
[    0.201525][    T0] Dentry cache hash table entries: 4194304 (order: 13,=
 33554432 bytes, linear)
[    0.204746][    T0] Inode-cache hash table entries: 2097152 (order: 12, =
16777216 bytes, linear)
[    0.205621][    T0] software IO TLB: area num 2.
[    0.219473][    T0] Fallback order for Node 0: 0
[    0.219479][    T0] Built 1 zonelists, mobility grouping on.  Total page=
s: 8388478
[    0.220584][    T0] Policy zone: Normal
[    0.220920][    T0] mem auto-init: stack:all(zero), heap alloc:off, heap=
 free:off
[    0.298959][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPU=
s=3D2, Nodes=3D1
[    0.299642][    T0] Kernel/User page tables isolation: enabled
[    0.300472][    T0] ftrace: allocating 59546 entries in 234 pages
[    0.301037][    T0] ftrace: allocated 234 pages with 5 groups
[    0.301988][    T0] Dynamic Preempt: lazy
[    0.302570][    T0] rcu: Preemptible hierarchical RCU implementation.
[    0.303106][    T0] rcu:     RCU restricting CPUs from NR_CPUS=3D512 to =
nr_cpu_ids=3D2.
[    0.303710][    T0]  RCU CPU stall warnings timeout set to 100 (rcu_cpu_=
stall_timeout).
[    0.304359][    T0]  Trampoline variant of Tasks RCU enabled.
[    0.304828][    T0]  Rude variant of Tasks RCU enabled.
[    0.305259][    T0]  Tracing variant of Tasks RCU enabled.
[    0.305711][    T0] rcu: RCU calculated value of scheduler-enlistment de=
lay is 25 jiffies.
[    0.306389][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr=
_cpu_ids=3D2
[    0.307000][    T0] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_=
cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    0.307767][    T0] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_=
task_cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    0.311904][    T0] NR_IRQS: 33024, nr_irqs: 440, preallocated irqs: 16
[    0.312691][    T0] rcu: srcu_init: Setting srcu_struct sizes based on c=
ontention.
[    0.316858][    T0] Console: colour VGA+ 80x25
[    0.317255][    T0] printk: legacy console [tty0] enabled
[    0.350111][    T0] printk: legacy console [ttyS0] enabled
[    0.350111][    T0] printk: legacy console [ttyS0] enabled
[    0.351268][    T0] printk: legacy bootconsole [earlyser0] disabled
[    0.351268][    T0] printk: legacy bootconsole [earlyser0] disabled
[    0.352577][    T0] ACPI: Core revision 20251212
[    0.353186][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 19112604467 ns
[    0.354299][    T0] APIC: Switch to symmetric I/O mode setup
[    0.355088][    T0] x2apic enabled
[    0.355674][    T0] APIC: Switched APIC routing to: physical x2apic
[    0.356346][    T0] Masked ExtINT on CPU#0
[    0.357276][    T0] ENABLING IO-APIC IRQs
[    0.357726][    T0] Init IO_APIC IRQs
[    0.358148][    T0] apic 0 pin 0 not connected
[    0.358686][    T0] IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1=
 Level:0 ActiveLow:0)
[    0.359601][    T0] IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0=
 Level:0 ActiveLow:0)
[    0.360593][    T0] IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3=
 Level:0 ActiveLow:0)
[    0.361610][    T0] IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4=
 Level:0 ActiveLow:0)
[    0.362539][    T0] IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5=
 Level:1 ActiveLow:0)
[    0.363458][    T0] IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6=
 Level:0 ActiveLow:0)
[    0.364384][    T0] IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7=
 Level:0 ActiveLow:0)
[    0.365299][    T0] IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8=
 Level:0 ActiveLow:0)
[    0.366227][    T0] IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9=
 Level:1 ActiveLow:0)
[    0.367181][    T0] IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ =
10 Level:1 ActiveLow:0)
[    0.368173][    T0] IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ =
11 Level:1 ActiveLow:0)
[    0.369171][    T0] IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ =
12 Level:0 ActiveLow:0)
[    0.370186][    T0] IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ =
13 Level:0 ActiveLow:0)
[    0.371194][    T0] IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ =
14 Level:0 ActiveLow:0)
[    0.372137][    T0] IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ =
15 Level:0 ActiveLow:0)
[    0.373065][    T0] apic 0 pin 16 not connected
[    0.373565][    T0] apic 0 pin 17 not connected
[    0.374073][    T0] apic 0 pin 18 not connected
[    0.374628][    T0] apic 0 pin 19 not connected
[    0.375133][    T0] apic 0 pin 20 not connected
[    0.375640][    T0] apic 0 pin 21 not connected
[    0.376138][    T0] apic 0 pin 22 not connected
[    0.376648][    T0] apic 0 pin 23 not connected
[    0.377276][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1=
 pin2=3D-1
[    0.378095][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max=
_cycles: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.379437][    T0] Calibrating delay loop (skipped) preset value.. 6000=
.00 BogoMIPS (lpj=3D12000000)
[    0.380526][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.381177][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.381880][    T0] mitigations: Enabled attack vectors: user_kernel, us=
er_user, guest_host, guest_guest, SMT mitigations: auto
[    0.383684][    T0] Speculative Store Bypass: Vulnerable
[    0.384259][    T0] Spectre V2 : Mitigation: Retpolines
[    0.384839][    T0] ITS: Mitigation: Aligned branch/return thunks
[    0.385478][    T0] MDS: Vulnerable: Clear CPU buffers attempted, no mic=
rocode
[    0.386267][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers an=
d __user pointer sanitization
[    0.387666][    T0] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on=
 context switch and VMEXIT
[    0.388756][    T0] active return thunk: its_return_thunk
[    0.389379][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floati=
ng point registers'
[    0.390291][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regist=
ers'
[    0.391052][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regist=
ers'
[    0.391599][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  2=
56
[    0.392344][    T0] x86/fpu: Enabled xstate features 0x7, context size i=
s 832 bytes, using 'standard' format.
[    0.409959][    T0] Freeing SMP alternatives memory: 48K
[    0.410629][    T0] pid_max: default: 32768 minimum: 301
[    0.411299][    T0] Mount-cache hash table entries: 65536 (order: 7, 524=
288 bytes, linear)
[    0.411682][    T0] Mountpoint-cache hash table entries: 65536 (order: 7=
, 524288 bytes, linear)
[    0.414694][    T0] VFS: Finished mounting rootfs on nullfs
[    0.416268][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (fam=
ily: 0x6, model: 0x2a, stepping: 0x1)
[    0.419722][    T1] Performance Events: unsupported CPU family 6 model 4=
2 no PMU driver, software events only.
[    0.423482][    T1] signal: max sigframe size: 1360
[    0.424796][    T1] rcu: Hierarchical SRCU implementation.
[    0.426182][    T1] rcu:     Max phase no-delay instances is 1000.
[    0.427492][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 1 crossnode level
[    0.435844][    T1] smp: Bringing up secondary CPUs ...
[    0.436889][    T1] smpboot: x86: Booting SMP configuration:
[    0.437859][    T1] .... node  #0, CPUs:      #1
[    0.062046][    T0] Masked ExtINT on CPU#1
[    0.441435][    T1] smp: Brought up 1 node, 2 CPUs
[    0.443971][    T1] smpboot: Total of 2 processors activated (12000.00 B=
ogoMIPS)
[    0.445265][    T1] Memory: 32428984K/33553912K available (19549K kernel=
 code, 5618K rwdata, 6920K rodata, 3372K init, 1600K bss, 914180K reserved,=
 204800K cma-reserved)
[    0.448725][    T1] devtmpfs: initialized
[    0.449074][    T1] x86/mm: Memory block size: 128MB
[    0.459559][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645041785100000 ns
[    0.460037][    T1] posixtimers hash table entries: 1024 (order: 2, 1638=
4 bytes, linear)
[    0.461992][    T1] futex hash table entries: 512 (32768 bytes on 1 NUMA=
 nodes, total 32 KiB, linear).
[    0.465234][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.467645][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    0.467647][    T1] thermal_sys: Registered thermal governor 'user_space=
'
[    0.471437][    T1] cpuidle: using governor ladder
[    0.473345][    T1] cpuidle: using governor menu
[    0.473345][    T1] PCI: Using configuration type 1 for base access
[    0.475476][    T1] kprobes: kprobe jump-optimization is enabled. All kp=
robes are optimized if possible.
[    0.503436][    T1] ACPI: Added _OSI(Module Device)
[    0.503436][    T1] ACPI: Added _OSI(Processor Device)
[    0.503436][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    0.503713][    T1] ACPI: 1 ACPI AML tables successfully acquired and lo=
aded
[    0.515441][    T1] ACPI: \_SB_: platform _OSC: OS support mask [002a7ef=
e]
[    0.516279][    T1] ACPI: Interpreter enabled
[    0.516777][    T1] ACPI: PM: (supports S0 S3 S4 S5)
[    0.517324][    T1] ACPI: Using IOAPIC for interrupt routing
[    0.517957][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug
[    0.517957][    T1] PCI: Using E820 reservations for host bridge windows
[    0.517957][    T1] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.518268][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])
[    0.519039][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Seg=
ments MSI HPX-Type3]
[    0.519665][    T1] acpi PNP0A03:00: _OSC: not requesting OS control; OS=
 requires [ExtendedConfig ASPM ClockPM MSI]
[    0.520803][    T1] acpi PNP0A03:00: _OSC: platform retains control of P=
CIe features (AE_ERROR)
[    0.521772][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, c=
an't access extended configuration space under this bridge
[    0.523139][    T1] PCI host bridge to bus 0000:00
[    0.523575][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]
[    0.524442][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
[    0.525303][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
[    0.526220][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfffff window]
[    0.527143][    T1] pci_bus 0000:00: root bus resource [mem 0x840000000-=
0x8bfffffff window]
[    0.531664][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.532369][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
 conventional PCI endpoint
[    0.533729][    T1] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100=
 conventional PCI endpoint
[    0.535002][    T1] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180=
 conventional PCI endpoint
[    0.536139][    T1] pci 0000:00:01.1: BAR 4 [io  0xc080-0xc08f]
[    0.536818][    T1] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy =
IDE quirk
[    0.538016][    T1] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE qui=
rk
[    0.539444][    T1] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy =
IDE quirk
[    0.541523][    T1] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE qui=
rk
[    0.543188][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint
[    0.544368][    T1] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed=
 by PIIX4 ACPI
[    0.546109][    T1] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed=
 by PIIX4 SMB
[    0.547655][    T1] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000=
 conventional PCI endpoint
[    0.551503][    T1] pci 0000:00:02.0: BAR 0 [mem 0xfd000000-0xfdffffff p=
ref]
[    0.552605][    T1] pci 0000:00:02.0: BAR 2 [mem 0xfebb0000-0xfebb0fff]
[    0.553607][    T1] pci 0000:00:02.0: ROM [mem 0xfeba0000-0xfebaffff pre=
f]
[    0.554718][    T1] pci 0000:00:02.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    0.556388][    T1] pci 0000:00:03.0: [1af4:1009] type 00 class 0x000200=
 conventional PCI endpoint
[    0.558730][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
[    0.559440][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfebb1000-0xfebb1fff]
[    0.560175][    T1] pci 0000:00:03.0: BAR 4 [mem 0xfe000000-0xfe003fff 6=
4bit pref]
[    0.561448][    T1] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000=
 conventional PCI endpoint
[    0.562829][    T1] pci 0000:00:04.0: BAR 0 [mem 0xfebb2000-0xfebb200f]
[    0.563714][    T1] pci 0000:00:05.0: [8086:100e] type 00 class 0x020000=
 conventional PCI endpoint
[    0.565623][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfeb80000-0xfeb9ffff]
[    0.566377][    T1] pci 0000:00:05.0: BAR 1 [io  0xc040-0xc07f]
[    0.567056][    T1] pci 0000:00:05.0: ROM [mem 0xfeb00000-0xfeb7ffff pre=
f]
[    0.572601][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.573372][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.574153][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.574912][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.575629][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.576494][    T1] iommu: Default domain type: Translated
[    0.577101][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.579483][    T1] SCSI subsystem initialized
[    0.583475][    T1] libata version 3.00 loaded.
[    0.584064][    T1] ACPI: bus type USB registered
[    0.584643][    T1] usbcore: registered new interface driver usbfs
[    0.585368][    T1] usbcore: registered new interface driver hub
[    0.586058][    T1] usbcore: registered new device driver usb
[    0.586732][    T1] pps_core: LinuxPPS API ver. 1 registered
[    0.587377][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    0.587697][    T1] PTP clock support registered
[    0.591483][    T1] Advanced Linux Sound Architecture Driver Initialized=
.
[    0.592499][    T1] PCI: Using ACPI for IRQ routing
[    0.593088][    T1] PCI: pci_cache_line_size set to 64 bytes
[    0.593849][    T1] e820: register RAM buffer resource [mem 0x0009fc00-0=
x0009ffff]
[    0.595435][    T1] e820: register RAM buffer resource [mem 0xbffe0000-0=
xbfffffff]
[    0.599475][    T1] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.600262][    T1] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.601014][    T1] pci 0000:00:02.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.601014][    T1] vgaarb: loaded
[    0.601014][    T1] clocksource: Switched to clocksource kvm-clock
[    0.601014][    T1] VFS: Disk quotas dquot_6.6.0
[    0.601563][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
[    0.614215][    T1] pnp: PnP ACPI init
[    0.614753][    T1] pnp 00:02: [dma 2]
[    0.615327][    T1] pnp: PnP ACPI: found 6 devices
[    0.621113][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
[    0.622229][    T1] NET: Registered PF_INET protocol family
[    0.623366][    T1] IP idents hash table entries: 262144 (order: 9, 2097=
152 bytes, linear)
[    0.626102][    T1] tcp_listen_portaddr_hash hash table entries: 16384 (=
order: 6, 262144 bytes, linear)
[    0.627162][    T1] Table-perturb hash table entries: 65536 (order: 6, 2=
62144 bytes, linear)
[    0.628099][    T1] TCP established hash table entries: 262144 (order: 9=
, 2097152 bytes, linear)
[    0.629467][    T1] TCP bind hash table entries: 65536 (order: 9, 209715=
2 bytes, linear)
[    0.630747][    T1] TCP: Hash tables configured (established 262144 bind=
 65536)
[    0.631595][    T1] UDP hash table entries: 16384 (order: 8, 1048576 byt=
es, linear)
[    0.632728][    T1] UDP-Lite hash table entries: 16384 (order: 8, 104857=
6 bytes, linear)
[    0.633731][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.642198][    T1] RPC: Registered named UNIX socket transport module.
[    0.643157][    T1] RPC: Registered udp transport module.
[    0.643937][    T1] RPC: Registered tcp transport module.
[    0.644712][    T1] RPC: Registered tcp-with-tls transport module.
[    0.645598][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.
[    0.646635][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
[    0.647598][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]
[    0.648555][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]
[    0.649643][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfff=
ff window]
[    0.650741][    T1] pci_bus 0000:00: resource 8 [mem 0x840000000-0x8bfff=
ffff window]
[    0.651809][    T1] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.652548][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.653338][    T1] PCI: CLS 0 bytes, default 64
[    0.653896][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    0.654714][    T1] software IO TLB: mapped [mem 0x00000000ae11b000-0x00=
000000b211b000] (64MB)
[    0.655977][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.657241][   T33] Trying to unpack rootfs image as initramfs...
[    0.686606][    T1] Initialise system trusted keyrings
[    0.687515][    T1] workingset: timestamp_bits=3D40 max_order=3D23 bucke=
t_order=3D0
[    0.688458][    T1] NFS: Registering the id_resolver key type
[    0.689109][    T1] Key type id_resolver registered
[    0.689655][    T1] Key type id_legacy registered
[    0.690239][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[    0.691073][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[    0.710305][    T1] Key type cifs.idmap registered
[    0.710908][    T1] 9p: Installing v9fs 9p2000 file system support
[    0.728402][    T1] Key type asymmetric registered
[    0.731173][    T1] Asymmetric key parser 'x509' registered
[    0.731823][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 249)
[    0.732726][    T1] io scheduler mq-deadline registered
[    0.733305][    T1] io scheduler kyber registered
[    0.734232][    T1] input: Power Button as /devices/platform/LNXPWRBN:00=
/input/input0
[    0.735170][    T1] ACPI: button: Power Button [PWRF]
[    0.738462][    T1] ERST DBG: ERST support is disabled.
[    0.747131][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[    0.748050][    T1] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    0.749217][    T1] Non-volatile memory driver v1.3
[    0.751087][    T1] loop: module loaded
[    0.751563][    T1] rdac: device handler registered
[    0.752146][    T1] hp_sw: device handler registered
[    0.752703][    T1] emc: device handler registered
[    0.753255][    T1] alua: device handler registered
[    0.758104][    T1] scsi host0: ata_piix
[    0.766172][    T1] scsi host1: ata_piix
[    0.766833][    T1] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0=
80 irq 14 lpm-pol 0
[    0.768023][    T1] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0=
88 irq 15 lpm-pol 0
[    0.769327][    T1] MACsec IEEE 802.1AE
[    0.771384][    T1] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
[    0.782196][    T1] e100: Intel(R) PRO/100 Network Driver
[    0.782827][    T1] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.783980][    T1] e1000: Intel(R) PRO/1000 Network Driver
[    0.784589][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.793728][    T1] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    0.926890][  T684] ata2: found unknown device (class 0)
[    0.927874][  T684] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    0.929251][   T11] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-RO=
M     2.5+ PQ: 0 ANSI: 5
[    1.107641][    T1] e1000 0000:00:05.0 eth0: (PCI:33MHz:32-bit) 52:54:00=
:12:34:56
[    1.110801][    T1] e1000 0000:00:05.0 eth0: Intel(R) PRO/1000 Network C=
onnection
[    1.112678][    T1] e1000e: Intel(R) PRO/1000 Network Driver
[    1.114033][    T1] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.115642][    T1] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.117097][    T1] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.118655][    T1] Intel(R) 2.5G Ethernet Linux Driver
[    1.119928][    T1] Copyright(c) 2018 Intel Corporation.
[    1.120913][    T1] igbvf: Intel(R) Gigabit Virtual Function Network Dri=
ver
[    1.122128][    T1] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.123300][    T1] ixgbe: Intel(R) 10 Gigabit PCI Express Network Drive=
r
[    1.124472][    T1] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    1.125660][    T1] i40e: Intel(R) Ethernet Connection XL710 Network Dri=
ver
[    1.126883][    T1] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[    1.128034][    T1] jme: JMicron JMC2XX ethernet driver version 1.0.8
[    1.129175][    T1] sky2: driver version 1.30
[    1.130008][    T1] myri10ge: Version 1.5.3-1.534
[    1.130667][    T1] ns83820.c: National Semiconductor DP83820 10/100/100=
0 driver.
[    1.131627][    T1] QLogic 1/10 GbE Converged/Intelligent Ethernet Drive=
r v5.3.66
[    1.132567][    T1] QLogic/NetXen Network Driver v4.0.82
[    1.133567][    T1] tehuti: Tehuti Networks(R) Network Driver, 7.29.3
[    1.134363][    T1] tehuti: Options: hw_csum
[    1.134927][    T1] tlan: ThunderLAN driver v1.17
[    1.135520][    T1] tlan: 0 devices installed, PCI: 0  EISA: 0
[    1.136706][    T1] PPP generic driver version 2.4.2
[    1.137579][    T1] PPP BSD Compression module registered
[    1.138277][    T1] PPP Deflate Compression module registered
[    1.138988][    T1] PPP MPPE Compression module registered
[    1.139639][    T1] NET: Registered PF_PPPOX protocol family
[    1.140313][    T1] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channel=
s, max=3D256) (6 bit encapsulation enabled).
[    1.141457][    T1] SLIP linefill/keepalive option.
[    1.142020][    T1] usbcore: registered new interface driver catc
[    1.142719][    T1] usbcore: registered new interface driver kaweth
[    1.143429][    T1] pegasus: Pegasus/Pegasus II USB Ethernet driver
[    1.144143][    T1] usbcore: registered new interface driver pegasus
[    1.144858][    T1] usbcore: registered new interface driver rtl8150
[    1.145582][    T1] usbcore: registered new interface driver asix
[    1.146317][    T1] usbcore: registered new interface driver ax88179_178=
a
[    1.147087][    T1] usbcore: registered new interface driver cdc_ether
[    1.147823][    T1] usbcore: registered new interface driver cdc_eem
[    1.148550][    T1] usbcore: registered new interface driver dm9601
[    1.149259][    T1] usbcore: registered new interface driver smsc75xx
[    1.149989][    T1] usbcore: registered new interface driver smsc95xx
[    1.150731][    T1] usbcore: registered new interface driver gl620a
[    1.151416][    T1] usbcore: registered new interface driver net1080
[    1.152105][    T1] usbcore: registered new interface driver plusb
[    1.152783][    T1] usbcore: registered new interface driver rndis_host
[    1.153507][    T1] usbcore: registered new interface driver cdc_subset
[    1.154265][    T1] usbcore: registered new interface driver zaurus
[    1.154960][    T1] usbcore: registered new interface driver MOSCHIP usb=
-ethernet driver
[    1.155849][    T1] usbcore: registered new interface driver int51x1
[    1.156533][    T1] usbcore: registered new interface driver kalmia
[    1.157212][    T1] usbcore: registered new interface driver ipheth
[    1.157900][    T1] usbcore: registered new interface driver sierra_net
[    1.158625][    T1] usbcore: registered new interface driver cx82310_eth
[    1.159353][    T1] usbcore: registered new interface driver cdc_ncm
[    1.160046][    T1] usbcore: registered new interface driver lg-vl600
[    1.160764][    T1] usbcore: registered new interface driver r8153_ecm
[    1.162073][    T1] aoe: AoE v85 initialised.
[    1.162668][    T1] usbcore: registered new interface driver cdc_acm
[    1.163355][    T1] cdc_acm: USB Abstract Control Model driver for USB m=
odems and ISDN adapters
[    1.164319][    T1] usbcore: registered new interface driver cdc_wdm
[    1.165018][    T1] usbcore: registered new interface driver usb-storage
[    1.165759][    T1] usbcore: registered new interface driver ums-alauda
[    1.166556][    T1] usbcore: registered new interface driver ums-cypress
[    1.167279][    T1] usbcore: registered new interface driver ums-datafab
[    1.168014][    T1] usbcore: registered new interface driver ums_eneub62=
50
[    1.168774][    T1] usbcore: registered new interface driver ums-freecom
[    1.169511][    T1] usbcore: registered new interface driver ums-isd200
[    1.170235][    T1] usbcore: registered new interface driver ums-jumpsho=
t
[    1.170971][    T1] usbcore: registered new interface driver ums-karma
[    1.171690][    T1] usbcore: registered new interface driver ums-onetouc=
h
[    1.172435][    T1] usbcore: registered new interface driver ums-realtek
[    1.173163][    T1] usbcore: registered new interface driver ums-sddr09
[    1.173881][    T1] usbcore: registered new interface driver ums-sddr55
[    1.174671][    T1] usbcore: registered new interface driver ums-usbat
[    1.175416][    T1] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU=
] at 0x60,0x64 irq 1,12
[    1.176886][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.177517][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.186148][    T1] mousedev: PS/2 mouse device common for all mice
[    1.187348][   T40] input: AT Translated Set 2 keyboard as /devices/plat=
form/i8042/serio0/input/input1
[    1.188539][    T1] rtc_cmos 00:05: RTC can wake from S4
[    1.189597][    T1] rtc_cmos 00:05: registered as rtc0
[    1.190251][    T1] rtc_cmos 00:05: setting system clock to 2026-02-02T2=
0:57:43 UTC (1770065863)
[    1.191430][    T1] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes=
 nvram, hpet irqs
[    1.192733][    T1] intel_pstate: CPU model not supported
[    1.193540][    T1] hid: raw HID events driver (C) Jiri Kosina
[    1.194433][    T1] usbcore: registered new interface driver usbhid
[    1.195321][    T1] usbhid: USB HID core driver
[    1.196441][    T1] NET: Registered PF_PACKET protocol family
[    1.197360][    T1] 9pnet: Installing 9P2000 support
[    1.198141][    T1] Key type dns_resolver registered
[    1.202502][    T1] IPI shorthand broadcast: enabled
[    1.203093][    C0] ... APIC ID:      00000000 (0)
[    1.203648][    C0] ... APIC VERSION: 00050014
[    1.204156][    C0] 0000000000000000000000000000000000000000000000000000=
000000000000
[    1.205022][    C0] 0000000000000000000000000000000000000000000000000000=
000000000000
[    1.205884][    C0] 0000000000000004000000000000000000000000000000000000=
000000000000
[    1.206073][    C0]
[    1.207041][    T1] number of MP IRQ sources: 15.
[    1.207599][    T1] number of IO-APIC #0 registers: 24.
[    1.208179][    T1] testing the IO APIC.......................
[    1.208831][    T1] IO APIC #0......
[    1.209250][    T1] .... register #00: 00000000
[    1.209761][    T1] .......    : physical APIC id: 00
[    1.210355][    T1] .......    : Delivery Type: 0
[    1.210890][    T1] .......    : LTS          : 0
[    1.211417][    T1] .... register #01: 00170011
[    1.211933][    T1] .......     : max redirection entries: 17
[    1.212570][    T1] .......     : PRQ implemented: 0
[    1.213132][    T1] .......     : IO APIC version: 11
[    1.213695][    T1] .... register #02: 00000000
[    1.214220][    T1] .......     : arbitration: 00
[    1.214758][    T1] .... IRQ redirection table:
[    1.215275][    T1] IOAPIC 0:
[    1.215645][    T1]  pin00, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.216614][    T1]  pin01, enabled , edge , high, V(22), IRR(0), S(0), =
physical, D(0001), M(0)
[    1.217583][    T1]  pin02, enabled , edge , high, V(30), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.218558][    T1]  pin03, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.219514][    T1]  pin04, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.220474][    T1]  pin05, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.221451][    T1]  pin06, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.222425][    T1]  pin07, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.225566][    T1]  pin08, enabled , edge , high, V(22), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.226532][    T1]  pin09, enabled , level, high, V(20), IRR(0), S(0), =
physical, D(0001), M(0)
[    1.227491][    T1]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.228460][    T1]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.229421][    T1]  pin0c, enabled , edge , high, V(21), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.230384][    T1]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.231338][    T1]  pin0e, enabled , edge , high, V(20), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.232297][    T1]  pin0f, enabled , edge , high, V(21), IRR(0), S(0), =
physical, D(0001), M(0)
[    1.233258][    T1]  pin10, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.234232][    T1]  pin11, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.235192][    T1]  pin12, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.236173][    T1]  pin13, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.237139][    T1]  pin14, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.238099][    T1]  pin15, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.239077][    T1]  pin16, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.240049][    T1]  pin17, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)
[    1.241002][    T1] IRQ to pin mappings:
[    1.241461][    T1] IRQ0 -> 0:2
[    1.241845][    T1] IRQ1 -> 0:1
[    1.242235][    T1] IRQ3 -> 0:3
[    1.242628][    T1] IRQ4 -> 0:4
[    1.243015][    T1] IRQ5 -> 0:5
[    1.243395][    T1] IRQ6 -> 0:6
[    1.243780][    T1] IRQ7 -> 0:7
[    1.244155][    T1] IRQ8 -> 0:8
[    1.244532][    T1] IRQ9 -> 0:9
[    1.244918][    T1] IRQ10 -> 0:10
[    1.245316][    T1] IRQ11 -> 0:11
[    1.245708][    T1] IRQ12 -> 0:12
[    1.246116][    T1] IRQ13 -> 0:13
[    1.246515][    T1] IRQ14 -> 0:14
[    1.246928][    T1] IRQ15 -> 0:15
[    1.247328][    T1] .................................... done.
[    1.250197][    T1] sched_clock: Marking stable (1192003024, 58046707)->=
(1258483286, -8433555)
[    1.253280][    T1] registered taskstats version 1
[    1.253874][    T1] Loading compiled-in X.509 certificates
[    1.256163][    T1] Demotion targets for Node 0: null
[    1.256752][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[    1.279405][    T1] Key type .fscrypt registered
[    1.279947][    T1] Key type fscrypt-provisioning registered
[    1.280738][    T1] netconsole: network logging started
[    1.607738][   T40] input: ImExPS/2 Generic Explorer Mouse as /devices/p=
latform/i8042/serio1/input/input3
[    1.618693][   T40] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Fl=
ow Control: RX
[    1.638160][    T1] Sending DHCP requests .
[    2.071173][   T33] Freeing initrd memory: 228116K
[    2.618211][    T1] , OK
[    2.627660][    T1] IP-Config: Got DHCP answer from 10.0.2.2, my address=
 is 10.0.2.15
[    2.630373][    T1] IP-Config: Complete:
[    2.631791][    T1]      device=3Deth0, hwaddr=3D52:54:00:12:34:56, ipad=
dr=3D10.0.2.15, mask=3D255.255.255.0, gw=3D10.0.2.2
[    2.635209][    T1]      host=3D10.0.2.15, domain=3D, nis-domain=3D(none=
)
[    2.637320][    T1]      bootserver=3D10.0.2.2, rootserver=3D10.0.2.2, r=
ootpath=3D
[    2.637323][    T1]      nameserver0=3D10.0.2.3
[    2.641341][    T1] clk: Disabling unused clocks
[    2.642686][    T1] ALSA device list:
[    2.643576][    T1]   No soundcards found.
[    2.648158][    T1] Freeing unused kernel image (initmem) memory: 3372K
[    2.649666][    T1] Write protecting the kernel read-only data: 28672k
[    2.652170][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 928K
[    2.653722][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1272K
[    2.654897][    T1] Run /init as init process
[    2.655499][    T1]   with arguments:
[    2.656023][    T1]     /init
[    2.656460][    T1]   with environment:
[    2.656988][    T1]     HOME=3D/
[    2.657439][    T1]     TERM=3Dlinux
[    2.657917][    T1]     RESULT_ROOT=3D/result/trinity/group-00-5-300s/vm=
-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07=
eb2969f429a66ad331fe2b3b6f/0
[    2.659835][    T1]     branch=3Dinternal-devel/devel-hourly-20260124-05=
0739
[    2.660710][    T1]     job=3D/lkp/jobs/scheduled/vm-meta-17/trinity-gro=
up-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-=
19zhjsh-2.yaml
[    2.662433][    T1]     user=3Dlkp
[    2.662785][    T1]     ARCH=3Dx86_64
[    2.663154][    T1]     kconfig=3Dx86_64-kexec
[    2.663611][    T1]     commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6=
f
[    2.664229][    T1]     ia32_emulation=3Don
[    2.664630][    T1]     max_uptime=3D7200
[    2.665021][    T1]     LKP_LOCAL_RUN=3D1
[    2.665430][    T1]     selinux=3D0
[    2.665788][    T1]     nmi_watchdog=3Dpanic
[    2.666198][    T1]     load_ramdisk=3D2
[    2.666586][    T1]     prompt_ramdisk=3D0
[    2.666992][    T1]     vga=3Dnormal
[    2.667348][    T1]     result_service=3D9p/virtfs_mount
INIT: version 2.88 booting
[    2.683993][ T1533] /dev/root: Can't lookup blockdev
[    2.684504][ T1533] /dev/root: Can't lookup blockdev
[    2.684978][ T1533] /dev/root: Can't lookup blockdev
[    2.685459][ T1533] /dev/root: Can't lookup blockdev
Starting udev
[    2.696039][ T1544] udevd[1544]: starting version 3.2.7
[    3.694158][    C1] random: crng init done
[    3.695792][ T1544] udevd[1544]: specified group 'kvm' unknown
[    3.697021][ T1545] udevd[1545]: starting eudev-3.2.7
[    3.719269][ T1545] udevd[1545]: specified group 'kvm' unknown
[    3.770458][ T1549] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/fo=
rm2 tray
[    3.771136][ T1549] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.818477][ T1549] sr 1:0:0:0: Attached scsi CD-ROM sr0
INIT: Entering runlevel: 5
Configuring network interfaces... ip: RTNETLINK answers: File exists
Starting syslogd/klogd: done
/etc/rc5.d/S77lkp-bootstrap: /lkp/jobs/scheduled/vm-meta-17/trinity-group-0=
0-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260126-53110-19zh=
jsh-2.sh: line 126: start: not found
PATH=3D/sbin:/usr/sbin:/bin:/usr/bin:/lkp/lkp/src/bin
export VM_VIRTFS=3D1 due to result service 9p/virtfs_mount
[    4.424418][ T1780] redirect stdout and stderr directly
[    4.424418][ T1780] is_virt=3Dtrue
LKP: ttyS0: 1730: Kernel tests: Boot OK!
LKP: ttyS0: 1730: HOSTNAME vm-snb, MAC 3e:72:62:1e:9b:51, kernel 6.19.0-rc6=
-next-20260123 1
LKP: ttyS0: 1730:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-17/=
trinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-2026=
0126-53110-19zhjsh-2.yaml
[    4.462400][ T1901] 9p: Could not find request transport: virtio
[    4.476690][ T1964] process 'src/bin/event/wakeup' started with executab=
le stack
INIT: Id "S1" respawning too fast: disabled for 5 minutes

Poky (Yocto Project Reference Distro) 2.7+snapshot vm-snb /dev/ttyS0

vm-snb login: [    5.424581][ T1781] mount: mounting 9p/virtfs_mount on //r=
esult/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_=
64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2b3b6f/0 failed: Invali=
d argument
[   16.670541][ T5073] UDPLite: UDP-Lite is deprecated and scheduled to be =
removed in 2025, please contact the netdev mailing list
[   16.673587][ T5073] trinity-main uses obsolete (PF_INET,SOCK_PACKET)
[   16.704486][ T5158] Loading iSCSI transport class v2.0-870.
[   16.727534][ T5201] can: controller area network core
[   16.728059][ T5201] NET: Registered PF_CAN protocol family
[   16.729619][ T5202] can: raw protocol
[   16.731272][ T5203] can: broadcast manager protocol
[   16.752829][ T5073] NOTICE: Automounting of tracing to debugfs is deprec=
ated and will be removed in 2030
[   16.767328][ T5255] Zero length message leads to an empty skb
[   16.788086][ T5267] Invalid ELF header magic: !=3D ELF
[   16.799682][ T5272] raw_sendmsg: trinity-c4 forgot to set AF_INET. Fix i=
t!
[   17.764828][ T5249] Invalid ELF header magic: !=3D ELF
[   17.792351][ T5277] Invalid ELF header magic: !=3D ELF
[   17.801218][ T5272] Invalid ELF header magic: !=3D ELF
[   18.766270][ T5247] Invalid ELF header magic: !=3D ELF
[   18.796095][ T5271] Invalid ELF header magic: !=3D ELF
[   18.799209][ T5277] Invalid ELF header magic: !=3D ELF
[   18.801227][ T5269] Invalid ELF header magic: !=3D ELF
[   18.804753][ T5271] Invalid ELF header magic: !=3D ELF
[   18.806946][ T5269] Invalid ELF header magic: !=3D ELF
[   18.812822][ T5271] Invalid ELF header magic: !=3D ELF
[   18.813504][ T5277] Invalid ELF header magic: !=3D ELF
[   19.803865][ T5281] Invalid ELF header magic: !=3D ELF
[   20.769860][ T5247] Invalid ELF header magic: !=3D ELF
[   20.784396][ T5276] Invalid ELF header magic: !=3D ELF
[   20.785929][ T5276] Invalid ELF header magic: !=3D ELF
[   20.840193][ T5247] Invalid ELF header magic: !=3D ELF
[   20.854514][ T5271] Invalid ELF header magic: !=3D ELF
[   21.837475][ T5272] Invalid ELF header magic: !=3D ELF
[   22.831586][ T5281] Invalid ELF header magic: !=3D ELF
[   22.836394][ T5281] Invalid ELF header magic: !=3D ELF
[   22.849512][ T5248] Invalid ELF header magic: !=3D ELF
[   22.858343][ T5271] Invalid ELF header magic: !=3D ELF
[   22.860186][ T5271] Invalid ELF header magic: !=3D ELF
[   22.862415][ T5271] Invalid ELF header magic: !=3D ELF
[   22.864856][ T5271] Invalid ELF header magic: !=3D ELF
[   22.868521][ T5271] Invalid ELF header magic: !=3D ELF
[   23.809551][ T5276] Invalid ELF header magic: !=3D ELF
[   23.850559][ T5277] Invalid ELF header magic: !=3D ELF
[   23.881579][ T5248] Invalid ELF header magic: !=3D ELF
[   23.889520][ T5272] Invalid ELF header magic: !=3D ELF
[   24.899791][ T5248] Invalid ELF header magic: !=3D ELF
[   24.932086][ T5271] Invalid ELF header magic: !=3D ELF
[   25.815702][ T5276] Invalid ELF header magic: !=3D ELF
[   25.898960][ T5281] Invalid ELF header magic: !=3D ELF
[   25.907512][ T5281] Invalid ELF header magic: !=3D ELF
[   26.434250][ T1781] /lkp/lkp/src/monitors/meminfo: line 45: date: not fo=
und
[   26.434250][ T1781] /lkp/lkp/src/monitors/meminfo: line 46: cat: not fou=
nd
[   26.434250][ T1781] /lkp/lkp/src/monitors/meminfo: line 25: /lkp/lkp/src=
/bin/event/wait: not found
[   26.950642][ T5247] Invalid ELF header magic: !=3D ELF
[   26.954758][ T5272] Invalid ELF header magic: !=3D ELF
[   27.440435][ T1781] /lkp/lkp/src/monitors/oom-killer: /lkp/lkp/src/monit=
ors/oom-killer: line 94: dmesg: not found
[   27.440435][ T1781] line 94: grep: not found
[   27.440435][ T1781] /lkp/lkp/src/monitors/oom-killer: line 25: /lkp/lkp/=
src/bin/event/wait: not found
[   27.931650][ T5308] Invalid ELF header magic: !=3D ELF
[   27.934351][ T5308] Invalid ELF header magic: !=3D ELF
[   27.954708][ T5247] Invalid ELF header magic: !=3D ELF
[   27.978354][ T5309] Invalid ELF header magic: !=3D ELF
[   28.941958][ T5308] Invalid ELF header magic: !=3D ELF
[   28.945502][ T5308] Invalid ELF header magic: !=3D ELF
[   29.008951][ T5247] Invalid ELF header magic: !=3D ELF
[   29.011691][ T5310] Invalid ELF header magic: !=3D ELF
[   29.014156][ T5310] Invalid ELF header magic: !=3D ELF
[   29.016691][ T5310] Invalid ELF header magic: !=3D ELF
[   29.843052][ T5276] Invalid ELF header magic: !=3D ELF
[   29.971301][ T5308] Invalid ELF header magic: !=3D ELF
[   29.979606][ T5308] Invalid ELF header magic: !=3D ELF
[   30.021343][ T5310] Invalid ELF header magic: !=3D ELF
[   30.872883][ T5276] Invalid ELF header magic: !=3D ELF
[   30.945512][ T5248] Invalid ELF header magic: !=3D ELF
[   30.977619][ T5301] Invalid ELF header magic: !=3D ELF
[   30.989177][ T5309] Invalid ELF header magic: !=3D ELF
[   31.023060][ T5247] Invalid ELF header magic: !=3D ELF
[   31.053207][ T5310] Invalid ELF header magic: !=3D ELF
[   31.963426][ T5248] Invalid ELF header magic: !=3D ELF
[   31.968986][ T5248] Invalid ELF header magic: !=3D ELF
[   32.000971][ T5301] Invalid ELF header magic: !=3D ELF
[   32.038335][ T5312] Invalid ELF header magic: !=3D ELF
[   32.041681][ T5312] Invalid ELF header magic: !=3D ELF
[   32.878734][ T5276] Invalid ELF header magic: !=3D ELF
[   33.000677][ T5308] Invalid ELF header magic: !=3D ELF
[   33.056675][ T5312] Invalid ELF header magic: !=3D ELF
[   33.057156][ T5310] Invalid ELF header magic: !=3D ELF
[   33.066409][ T5312] Invalid ELF header magic: !=3D ELF
[   33.068970][ T5312] Invalid ELF header magic: !=3D ELF
[   33.071935][ T5312] Invalid ELF header magic: !=3D ELF
[   33.893186][ T5276] Invalid ELF header magic: !=3D ELF
[   33.896476][ T5276] Invalid ELF header magic: !=3D ELF
[   33.898859][ T5276] Invalid ELF header magic: !=3D ELF
[   34.013994][ T5308] Invalid ELF header magic: !=3D ELF
[   34.044679][ T5309] Invalid ELF header magic: !=3D ELF
[   34.046425][ T5309] Invalid ELF header magic: !=3D ELF
[   34.060851][ T5310] Invalid ELF header magic: !=3D ELF
[   34.064858][ T5310] Invalid ELF header magic: !=3D ELF
[   34.974255][ T5314] Invalid ELF header magic: !=3D ELF
[   34.975692][ T5248] Invalid ELF header magic: !=3D ELF
[   35.026696][ T5313] Invalid ELF header magic: !=3D ELF
[   35.081156][ T5312] Invalid ELF header magic: !=3D ELF
[   35.084110][ T5312] Invalid ELF header magic: !=3D ELF
[   36.040115][ T5308] Invalid ELF header magic: !=3D ELF
[   36.989729][ T5314] Invalid ELF header magic: !=3D ELF
[   36.993307][ T5248] Invalid ELF header magic: !=3D ELF
[   37.003122][ T5314] Invalid ELF header magic: !=3D ELF
[   37.082282][ T5310] scsi_nl_rcv_msg: discarding partial skb
[   37.085938][ T5315] Invalid ELF header magic: !=3D ELF
[   37.089919][ T5315] Invalid ELF header magic: !=3D ELF
[   37.092682][ T5315] Invalid ELF header magic: !=3D ELF
[   37.096082][ T5315] Invalid ELF header magic: !=3D ELF
[   37.101570][ T5315] Invalid ELF header magic: !=3D ELF
[   37.117399][ T5315] Invalid ELF header magic: !=3D ELF
[   37.120790][ T5315] Invalid ELF header magic: !=3D ELF
[   38.078664][ T5313] Invalid ELF header magic: !=3D ELF
[   38.101634][ T5312] Invalid ELF header magic: !=3D ELF
[   38.128180][ T5315] Invalid ELF header magic: !=3D ELF
[   40.035131][ T5248] Invalid ELF header magic: !=3D ELF
[   40.040599][ T5248] scsi_nl_rcv_msg: discarding partial skb
[   40.125018][ T5319] Invalid ELF header magic: !=3D ELF
[   40.127095][ T5319] Invalid ELF header magic: !=3D ELF
[   40.128584][ T5319] Invalid ELF header magic: !=3D ELF
[   41.063405][ T5313] Invalid ELF header magic: !=3D ELF
[   41.134637][ T5319] Invalid ELF header magic: !=3D ELF
[   41.157816][ T5315] Invalid ELF header magic: !=3D ELF
[   41.165109][ T5315] Invalid ELF header magic: !=3D ELF
[   42.026511][ T5314] Invalid ELF header magic: !=3D ELF
[   42.053914][ T5248] Invalid ELF header magic: !=3D ELF
[   42.110448][ T5308] Invalid ELF header magic: !=3D ELF
[   42.148830][ T5319] Invalid ELF header magic: !=3D ELF
[   44.064095][ T5248] Invalid ELF header magic: !=3D ELF
[   44.083962][ T5313] Invalid ELF header magic: !=3D ELF
[   44.085179][ T5313] Invalid ELF header magic: !=3D ELF
[   45.088997][ T5313] Invalid ELF header magic: !=3D ELF
[   45.211389][ T5319] Invalid ELF header magic: !=3D ELF
[   46.051109][ T5321] Invalid ELF header magic: !=3D ELF
[   46.068046][ T5321] Invalid ELF header magic: !=3D ELF
[   46.092549][ T5248] Invalid ELF header magic: !=3D ELF
[   46.131441][ T5322] Invalid ELF header magic: !=3D ELF
[   46.133081][ T5322] Invalid ELF header magic: !=3D ELF
[   46.246525][ T5323] Invalid ELF header magic: !=3D ELF
[   47.073261][ T5314] Invalid ELF header magic: !=3D ELF
[   47.074811][ T5314] Invalid ELF header magic: !=3D ELF
[   47.103890][ T5248] Invalid ELF header magic: !=3D ELF
[   47.228439][ T5319] Invalid ELF header magic: !=3D ELF
[   47.250715][ T5323] Invalid ELF header magic: !=3D ELF
[   47.253073][ T5323] Invalid ELF header magic: !=3D ELF
[   47.255035][ T5323] Invalid ELF header magic: !=3D ELF
[   47.261473][ T5323] Invalid ELF header magic: !=3D ELF
[   48.123346][ T5313] Invalid ELF header magic: !=3D ELF
[   49.099450][ T5321] Invalid ELF header magic: !=3D ELF
[   49.123607][ T5326] Invalid ELF header magic: !=3D ELF
[   49.125214][ T5326] Invalid ELF header magic: !=3D ELF
[   49.162775][ T5313] Invalid ELF header magic: !=3D ELF
[   49.291956][ T5327] Invalid ELF header magic: !=3D ELF
[   50.102959][ T5321] Invalid ELF header magic: !=3D ELF
[   50.307480][ T5329] Invalid ELF header magic: !=3D ELF
[   50.340514][ T5328] Invalid ELF header magic: !=3D ELF
[   52.113883][ T5321] Invalid ELF header magic: !=3D ELF
[   52.116800][ T5321] Invalid ELF header magic: !=3D ELF
[   52.172615][ T5326] Invalid ELF header magic: !=3D ELF
[   52.182551][ T5326] Invalid ELF header magic: !=3D ELF
[   52.187110][ T5326] Invalid ELF header magic: !=3D ELF
[   52.203559][ T5313] Invalid ELF header magic: !=3D ELF
[   52.361246][ T5328] Invalid ELF header magic: !=3D ELF
[   53.191492][ T5326] Invalid ELF header magic: !=3D ELF
[   53.206917][ T5314] Invalid ELF header magic: !=3D ELF
[   53.214230][ T5314] Invalid ELF header magic: !=3D ELF
[   53.361067][ T5329] Invalid ELF header magic: !=3D ELF
[   53.364783][ T5328] Invalid ELF header magic: !=3D ELF
[   53.370682][ T5328] Invalid ELF header magic: !=3D ELF
[   53.372657][ T5328] Invalid ELF header magic: !=3D ELF
[   53.387880][ T5330] Invalid ELF header magic: !=3D ELF
[   54.232123][ T5314] Invalid ELF header magic: !=3D ELF
[   55.211783][ T5326] Invalid ELF header magic: !=3D ELF
[   55.253689][ T5331] Invalid ELF header magic: !=3D ELF
[   55.257169][ T5331] Invalid ELF header magic: !=3D ELF
[   55.258723][ T5331] Invalid ELF header magic: !=3D ELF
[   55.260370][ T5331] Invalid ELF header magic: !=3D ELF
[   55.266453][ T5331] Invalid ELF header magic: !=3D ELF
[   55.404374][ T5329] Invalid ELF header magic: !=3D ELF
[   55.431782][ T5329] Invalid ELF header magic: !=3D ELF
[   55.432483][ T5329] Invalid ELF header magic: !=3D ELF
[   55.434698][ T5329] Invalid ELF header magic: !=3D ELF
[   56.184992][ T5322] Invalid ELF header magic: !=3D ELF
[   56.212783][ T5313] Invalid ELF header magic: !=3D ELF
[   56.217006][ T5326] Invalid ELF header magic: !=3D ELF
[   56.220383][ T5313] Invalid ELF header magic: !=3D ELF
[   56.456697][ T5329] Invalid ELF header magic: !=3D ELF
[   57.447102][ T5333] Invalid ELF header magic: !=3D ELF
[   57.459415][ T5329] Invalid ELF header magic: !=3D ELF
[   58.058563][ T5322] Invalid ELF header magic: !=3D ELF
[   58.292062][ T5332] Invalid ELF header magic: !=3D ELF
[   59.116098][ T5322] Invalid ELF header magic: !=3D ELF
[   59.122620][ T5322] Invalid ELF header magic: !=3D ELF
[   59.123237][ T5322] Invalid ELF header magic: !=3D ELF
[   59.156821][ T5322] Invalid ELF header magic: !=3D ELF
[   59.171013][ T5322] Invalid ELF header magic: !=3D ELF
[   59.228916][ T5313] Invalid ELF header magic: !=3D ELF
[   59.461702][ T5333] Invalid ELF header magic: !=3D ELF
[   60.146399][ T5334] Invalid ELF header magic: !=3D ELF
[   60.316547][ T5336] Invalid ELF header magic: !=3D ELF
[   60.319869][ T5336] Invalid ELF header magic: !=3D ELF
[   61.250223][ T5326] Invalid ELF header magic: !=3D ELF
[   62.093251][ T5329] Invalid ELF header magic: !=3D ELF
[   62.099524][ T5329] Invalid ELF header magic: !=3D ELF
[   62.100695][ T5329] Invalid ELF header magic: !=3D ELF
[   62.103054][ T5329] Invalid ELF header magic: !=3D ELF
[   62.500256][ T5333] Invalid ELF header magic: !=3D ELF
[   62.501974][ T5333] Invalid ELF header magic: !=3D ELF
[   63.180008][ T5322] Invalid ELF header magic: !=3D ELF
[   63.518142][ T5333] Invalid ELF header magic: !=3D ELF
[   64.181457][ T5322] Invalid ELF header magic: !=3D ELF
[   64.191179][ T5337] Invalid ELF header magic: !=3D ELF
[   64.270444][ T5341] Invalid ELF header magic: !=3D ELF
[   64.331535][ T5336] Invalid ELF header magic: !=3D ELF
[   65.186125][ T5322] Invalid ELF header magic: !=3D ELF
[   65.203730][ T5337] Invalid ELF header magic: !=3D ELF
[   66.193734][ T5322] Invalid ELF header magic: !=3D ELF
[   66.195666][ T5322] Invalid ELF header magic: !=3D ELF
[   66.197271][ T5322] Invalid ELF header magic: !=3D ELF
[   66.202396][ T5322] Invalid ELF header magic: !=3D ELF
[   66.203546][ T5322] Invalid ELF header magic: !=3D ELF
[   66.221782][ T5343] Invalid ELF header magic: !=3D ELF
[   66.234026][ T5343] Invalid ELF header magic: !=3D ELF
[   66.291172][ T5341] Invalid ELF header magic: !=3D ELF
[   67.209385][ T5322] Invalid ELF header magic: !=3D ELF
[   67.270297][ T5342] Invalid ELF header magic: !=3D ELF
[   67.289515][ T5342] Invalid ELF header magic: !=3D ELF
[   67.290962][ T5342] Invalid ELF header magic: !=3D ELF
[   67.291582][ T5342] Invalid ELF header magic: !=3D ELF
[   68.409224][ T5343] Invalid ELF header magic: !=3D ELF
[   68.411150][ T5343] Invalid ELF header magic: !=3D ELF
[   68.412720][ T5343] Invalid ELF header magic: !=3D ELF
[   69.407771][ T5346] Invalid ELF header magic: !=3D ELF
[   70.199827][ T5338] Invalid ELF header magic: !=3D ELF
[   70.201962][ T5338] Invalid ELF header magic: !=3D ELF
[   70.282536][ T5322] Invalid ELF header magic: !=3D ELF
[   70.289993][ T5326] Invalid ELF header magic: !=3D ELF
[   70.297056][ T5347] Invalid ELF header magic: !=3D ELF
[   70.315924][ T5345] Invalid ELF header magic: !=3D ELF
[   70.553163][ T5340] Invalid ELF header magic: !=3D ELF
[   70.565891][ T5340] Invalid ELF header magic: !=3D ELF
[   71.211180][ T5338] Invalid ELF header magic: !=3D ELF
[   71.216747][ T5338] Invalid ELF header magic: !=3D ELF
[   71.300956][ T5347] Invalid ELF header magic: !=3D ELF
[   71.424340][ T5346] Invalid ELF header magic: !=3D ELF
[   72.301247][ T5322] Invalid ELF header magic: !=3D ELF
[   72.303180][ T5322] Invalid ELF header magic: !=3D ELF
[   72.316415][ T5322] Invalid ELF header magic: !=3D ELF
[   72.321503][ T5322] Invalid ELF header magic: !=3D ELF
[   73.225512][ T5338] Invalid ELF header magic: !=3D ELF
[   73.324709][ T5341] Invalid ELF header magic: !=3D ELF
[   73.398814][ T5347] Invalid ELF header magic: !=3D ELF
[   73.431231][ T5346] Invalid ELF header magic: !=3D ELF
[   73.481209][ T5343] Invalid ELF header magic: !=3D ELF
[   74.458152][ T5346] Invalid ELF header magic: !=3D ELF
[   74.465651][ T5346] Invalid ELF header magic: !=3D ELF
[   74.500128][ T5343] Invalid ELF header magic: !=3D ELF
[   75.369132][ T5341] Invalid ELF header magic: !=3D ELF
[   75.371759][ T5341] Invalid ELF header magic: !=3D ELF
[   75.372601][ T5341] Invalid ELF header magic: !=3D ELF
[   75.406709][ T5347] Invalid ELF header magic: !=3D ELF
[   75.504714][ T5343] Invalid ELF header magic: !=3D ELF
[   76.065251][ T5322] Invalid ELF header magic: !=3D ELF
[   76.409659][ T5347] Invalid ELF header magic: !=3D ELF
[   76.581049][ T5340] Invalid ELF header magic: !=3D ELF
[   76.585057][ T5340] Invalid ELF header magic: !=3D ELF
[   76.587134][ T5340] Invalid ELF header magic: !=3D ELF
[   77.278184][ T5338] Invalid ELF header magic: !=3D ELF
[   77.287438][ T5338] Invalid ELF header magic: !=3D ELF
[   77.401093][ T5322] Invalid ELF header magic: !=3D ELF
[   78.380261][ T5345] Invalid ELF header magic: !=3D ELF
[   78.385030][ T5345] Invalid ELF header magic: !=3D ELF
[   78.482235][ T5346] Invalid ELF header magic: !=3D ELF
[   78.483906][ T5346] Invalid ELF header magic: !=3D ELF
[   79.309673][ T5338] Invalid ELF header magic: !=3D ELF
[   79.442803][ T5347] Invalid ELF header magic: !=3D ELF
[   79.457737][ T5347] Invalid ELF header magic: !=3D ELF
[   79.466779][ T5347] Invalid ELF header magic: !=3D ELF
[   79.514245][ T5343] Invalid ELF header magic: !=3D ELF
[   80.447987][ T5322] Invalid ELF header magic: !=3D ELF
[   81.475701][ T5350] Invalid ELF header magic: !=3D ELF
[   81.650929][ T5349] Invalid ELF header magic: !=3D ELF
[   82.328006][ T5338] Invalid ELF header magic: !=3D ELF
[   82.497508][ T5345] Invalid ELF header magic: !=3D ELF
[   82.655264][ T5349] Invalid ELF header magic: !=3D ELF
[   83.479625][ T5347] Invalid ELF header magic: !=3D ELF
[   84.060691][ T5350] Invalid ELF header magic: !=3D ELF
[   84.340103][ T5338] Invalid ELF header magic: !=3D ELF
[   84.341888][ T5338] Invalid ELF header magic: !=3D ELF
[   85.540743][ T5343] Invalid ELF header magic: !=3D ELF
[   86.561483][ T5343] Invalid ELF header magic: !=3D ELF
[   86.569101][ T5354] Invalid ELF header magic: !=3D ELF
[   87.511520][ T5347] Invalid ELF header magic: !=3D ELF
[   89.597421][ T5351] Invalid ELF header magic: !=3D ELF
[   90.537403][ T5356] Invalid ELF header magic: !=3D ELF
[   90.545066][ T5356] Invalid ELF header magic: !=3D ELF
[   91.544970][ T5347] Invalid ELF header magic: !=3D ELF
[   91.606469][ T5351] Invalid ELF header magic: !=3D ELF
[   91.608253][ T5351] Invalid ELF header magic: !=3D ELF
[   92.561999][ T5347] Invalid ELF header magic: !=3D ELF
[   92.573403][ T5347] Invalid ELF header magic: !=3D ELF
[   92.580764][ T5347] Invalid ELF header magic: !=3D ELF
[   92.642652][ T5358] Invalid ELF header magic: !=3D ELF
[   92.645935][ T5358] Invalid ELF header magic: !=3D ELF
[   93.112076][ T5355] Invalid ELF header magic: !=3D ELF
[   93.436464][ T5353] Invalid ELF header magic: !=3D ELF
[   93.634315][ T5357] Invalid ELF header magic: !=3D ELF
[   94.132196][ T5355] Invalid ELF header magic: !=3D ELF
[   94.594694][ T5354] Invalid ELF header magic: !=3D ELF
[   94.601246][ T5356] Invalid ELF header magic: !=3D ELF
[   94.716214][ T5349] Invalid ELF header magic: !=3D ELF
[   95.152683][ T5356] Invalid ELF header magic: !=3D ELF
[   95.679896][ T5357] Invalid ELF header magic: !=3D ELF
[   95.681176][ T5357] Invalid ELF header magic: !=3D ELF
[   95.739428][ T5349] Invalid ELF header magic: !=3D ELF
[   96.666776][ T5358] Invalid ELF header magic: !=3D ELF
[   96.669114][ T5358] Invalid ELF header magic: !=3D ELF
[   96.684354][ T5357] Invalid ELF header magic: !=3D ELF
[   97.166337][ T5356] scsi_nl_rcv_msg: discarding partial skb
[   97.459201][ T5361] Invalid ELF header magic: !=3D ELF
[   97.469912][ T5361] Invalid ELF header magic: !=3D ELF
[   97.676273][ T5358] Invalid ELF header magic: !=3D ELF
[   97.679748][ T5358] Invalid ELF header magic: !=3D ELF
[   97.682108][ T5358] Invalid ELF header magic: !=3D ELF
[   97.803402][ T5349] Invalid ELF header magic: !=3D ELF
[   98.119455][ T5347] Invalid ELF header magic: !=3D ELF
[   98.183498][ T5363] Invalid ELF header magic: !=3D ELF
[   98.185311][ T5363] Invalid ELF header magic: !=3D ELF
[   98.216076][ T5355] Invalid ELF header magic: !=3D ELF
[   98.225747][ T5364] Invalid ELF header magic: !=3D ELF
[   98.227245][ T5364] Invalid ELF header magic: !=3D ELF
[   98.242921][ T5364] Invalid ELF header magic: !=3D ELF
[   98.512642][ T5365] Invalid ELF header magic: !=3D ELF
[   98.613985][ T5354] Invalid ELF header magic: !=3D ELF
[   98.623996][ T5366] Invalid ELF header magic: !=3D ELF
[   98.629733][ T5366] Invalid ELF header magic: !=3D ELF
[   98.806636][ T5349] Invalid ELF header magic: !=3D ELF
[   99.195999][ T5363] Invalid ELF header magic: !=3D ELF
[   99.213515][ T5367] Invalid ELF header magic: !=3D ELF
[   99.214579][ T5367] Invalid ELF header magic: !=3D ELF
[   99.216855][ T5367] Invalid ELF header magic: !=3D ELF
[   99.640322][ T5366] Invalid ELF header magic: !=3D ELF
[   99.645003][ T5366] Invalid ELF header magic: !=3D ELF
[   99.649992][ T5366] Invalid ELF header magic: !=3D ELF
[   99.668649][ T5366] Invalid ELF header magic: !=3D ELF
[   99.687914][ T5358] Invalid ELF header magic: !=3D ELF
[  100.146894][ T5362] Invalid ELF header magic: !=3D ELF
[  100.148759][ T5362] Invalid ELF header magic: !=3D ELF
[  100.150402][ T5362] Invalid ELF header magic: !=3D ELF
[  101.171303][ T5362] Invalid ELF header magic: !=3D ELF
[  101.247031][ T5367] Invalid ELF header magic: !=3D ELF
[  101.248442][ T5367] Invalid ELF header magic: !=3D ELF
[  101.523248][ T5365] Invalid ELF header magic: !=3D ELF
[  101.712325][ T5358] Invalid ELF header magic: !=3D ELF
[  101.713146][ T5357] Invalid ELF header magic: !=3D ELF
[  101.716922][ T5357] Invalid ELF header magic: !=3D ELF
[  102.252754][ T5364] Invalid ELF header magic: !=3D ELF
[  102.727627][ T5369] Invalid ELF header magic: !=3D ELF
[  102.758241][ T5370] Invalid ELF header magic: !=3D ELF
[  102.763246][ T5369] Invalid ELF header magic: !=3D ELF
[  102.765946][ T5369] Invalid ELF header magic: !=3D ELF
[  103.302950][ T5364] Invalid ELF header magic: !=3D ELF
[  103.309561][ T5371] Invalid ELF header magic: !=3D ELF
[  103.313485][ T5371] Invalid ELF header magic: !=3D ELF
[  103.760599][ T5370] Invalid ELF header magic: !=3D ELF
[  103.762559][ T5370] Invalid ELF header magic: !=3D ELF
[  103.797752][ T5369] Invalid ELF header magic: !=3D ELF
[  104.186411][ T5362] Invalid ELF header magic: !=3D ELF
[  104.243150][ T5362] Invalid ELF header magic: !=3D ELF
[  104.243877][ T5362] Invalid ELF header magic: !=3D ELF
[  104.266802][ T5367] Invalid ELF header magic: !=3D ELF
[  104.735048][ T5358] Invalid ELF header magic: !=3D ELF
[  104.771497][ T5370] Invalid ELF header magic: !=3D ELF
[  105.256359][ T5362] Invalid ELF header magic: !=3D ELF
[  105.266238][ T5362] Invalid ELF header magic: !=3D ELF
[  105.280727][ T5375] Invalid ELF header magic: !=3D ELF
[  105.815601][ T5369] Invalid ELF header magic: !=3D ELF
[  105.826097][ T5369] Invalid ELF header magic: !=3D ELF
[  105.828949][ T5369] Invalid ELF header magic: !=3D ELF
[  106.282431][ T5367] Invalid ELF header magic: !=3D ELF
[  106.563832][ T5365] Invalid ELF header magic: !=3D ELF
[  107.593841][ T5365] Invalid ELF header magic: !=3D ELF
[  107.783818][ T5370] Invalid ELF header magic: !=3D ELF
[  108.597329][ T5365] Invalid ELF header magic: !=3D ELF
[  109.370465][ T5371] Invalid ELF header magic: !=3D ELF
[  109.768253][ T5367] Invalid ELF header magic: !=3D ELF
[  109.770109][ T5367] Invalid ELF header magic: !=3D ELF
[  109.885477][ T5377] Invalid ELF header magic: !=3D ELF
[  110.080126][ T5380] Invalid ELF header magic: !=3D ELF
[  110.083436][ T5380] Invalid ELF header magic: !=3D ELF
[  110.898808][ T5379] Invalid ELF header magic: !=3D ELF
[  110.911736][ T5379] Invalid ELF header magic: !=3D ELF
[  111.085630][ T5380] Invalid ELF header magic: !=3D ELF
[  111.319781][ T5376] Invalid ELF header magic: !=3D ELF
[  111.780226][ T5367] Invalid ELF header magic: !=3D ELF
[  112.107392][ T5380] Invalid ELF header magic: !=3D ELF
[  112.119889][ T5380] Invalid ELF header magic: !=3D ELF
[  112.124661][ T5380] Invalid ELF header magic: !=3D ELF
[  112.127090][ T5380] Invalid ELF header magic: !=3D ELF
[  112.132498][ T5380] Invalid ELF header magic: !=3D ELF
[  112.133593][ T5380] Invalid ELF header magic: !=3D ELF
[  112.134619][ T5380] Invalid ELF header magic: !=3D ELF
[  112.139491][ T5381] Invalid ELF header magic: !=3D ELF
[  112.149411][ T5381] Invalid ELF header magic: !=3D ELF
[  112.780801][ T5372] Invalid ELF header magic: !=3D ELF
[  112.785620][ T5367] Invalid ELF header magic: !=3D ELF
[  112.789864][ T5367] Invalid ELF header magic: !=3D ELF
[  112.817167][ T5382] Invalid ELF header magic: !=3D ELF
[  113.810261][ T5372] Invalid ELF header magic: !=3D ELF
[  114.152508][ T5381] Invalid ELF header magic: !=3D ELF
[  114.823686][ T5383] Invalid ELF header magic: !=3D ELF
[  114.848262][ T5382] scsi_nl_rcv_msg: discarding partial skb
[  114.921811][ T5379] Invalid ELF header magic: !=3D ELF
[  114.926342][ T5379] Invalid ELF header magic: !=3D ELF
[  114.928445][ T5379] Invalid ELF header magic: !=3D ELF
[  115.161440][ T5381] Invalid ELF header magic: !=3D ELF
[  115.864320][ T5382] Invalid ELF header magic: !=3D ELF
[  115.894559][ T5369] Invalid ELF header magic: !=3D ELF
[  115.930027][ T5379] Invalid ELF header magic: !=3D ELF
[  115.945695][ T5379] Invalid ELF header magic: !=3D ELF
[  117.827492][ T5383] Invalid ELF header magic: !=3D ELF
[  117.970422][ T5379] Invalid ELF header magic: !=3D ELF
[  118.060073][ T5376] Invalid ELF header magic: !=3D ELF
[  118.061526][ T5376] Invalid ELF header magic: !=3D ELF
[  118.065675][ T5376] Invalid ELF header magic: !=3D ELF
[  118.945400][ T5385] Invalid ELF header magic: !=3D ELF
[  118.947307][ T5385] Invalid ELF header magic: !=3D ELF
[  118.973296][ T5379] Invalid ELF header magic: !=3D ELF
[  119.076181][ T5376] Invalid ELF header magic: !=3D ELF
[  119.078241][ T5376] Invalid ELF header magic: !=3D ELF
[  119.081090][ T5376] Invalid ELF header magic: !=3D ELF
[  119.084821][ T5376] Invalid ELF header magic: !=3D ELF
[  119.953243][ T5385] Invalid ELF header magic: !=3D ELF
[  119.954912][ T5385] Invalid ELF header magic: !=3D ELF
[  120.921584][ T5367] Invalid ELF header magic: !=3D ELF
[  120.926106][ T5367] Invalid ELF header magic: !=3D ELF
[  120.933404][ T5367] Invalid ELF header magic: !=3D ELF
[  120.966635][ T5385] Invalid ELF header magic: !=3D ELF
[  121.088323][ T5376] Invalid ELF header magic: !=3D ELF
[  121.094163][ T5376] Invalid ELF header magic: !=3D ELF
[  121.942729][ T5367] Invalid ELF header magic: !=3D ELF
[  121.945644][ T5367] Invalid ELF header magic: !=3D ELF
[  121.979621][ T5385] Invalid ELF header magic: !=3D ELF
[  121.983150][ T5385] Invalid ELF header magic: !=3D ELF
[  121.987950][ T5385] Invalid ELF header magic: !=3D ELF
[  122.202315][ T5386] Invalid ELF header magic: !=3D ELF
[  122.206779][ T5386] Invalid ELF header magic: !=3D ELF
[  122.831496][ T5383] Invalid ELF header magic: !=3D ELF
[  122.832683][ T5383] Invalid ELF header magic: !=3D ELF
[  123.106260][ T5376] Invalid ELF header magic: !=3D ELF
[  123.838411][ T5383] Invalid ELF header magic: !=3D ELF
[  124.004848][ T5385] Invalid ELF header magic: !=3D ELF
[  124.025303][ T5379] Invalid ELF header magic: !=3D ELF
[  124.895567][ T5382] Invalid ELF header magic: !=3D ELF
[  124.951149][ T5367] Invalid ELF header magic: !=3D ELF
[  124.952178][ T5367] Invalid ELF header magic: !=3D ELF
[  125.030318][ T5379] Invalid ELF header magic: !=3D ELF
[  125.042609][ T5379] Invalid ELF header magic: !=3D ELF
[  125.961621][ T5367] Invalid ELF header magic: !=3D ELF
[  126.020996][ T5385] Invalid ELF header magic: !=3D ELF
[  126.225234][ T5386] Invalid ELF header magic: !=3D ELF
[  126.853421][ T5383] Invalid ELF header magic: !=3D ELF
[  126.866729][ T5383] Invalid ELF header magic: !=3D ELF
[  126.900115][ T5383] Invalid ELF header magic: !=3D ELF
[  126.900981][ T5383] Invalid ELF header magic: !=3D ELF
[  127.238831][ T5386] Invalid ELF header magic: !=3D ELF
[  127.926404][ T5383] Invalid ELF header magic: !=3D ELF
[  127.926921][ T5383] Invalid ELF header magic: !=3D ELF
[  127.927510][ T5383] Invalid ELF header magic: !=3D ELF
[  128.026919][ T5385] Invalid ELF header magic: !=3D ELF
[  128.929306][ T5383] Invalid ELF header magic: !=3D ELF
[  128.932904][ T5383] Invalid ELF header magic: !=3D ELF
[  128.945773][ T5387] Invalid ELF header magic: !=3D ELF
[  130.025705][ T5382] Invalid ELF header magic: !=3D ELF
[  130.954964][ T5387] Invalid ELF header magic: !=3D ELF
[  131.042347][ T5388] Invalid ELF header magic: !=3D ELF
[  131.043447][ T5388] Invalid ELF header magic: !=3D ELF
[  131.055577][ T5379] Invalid ELF header magic: !=3D ELF
[  131.077840][ T5388] Invalid ELF header magic: !=3D ELF
[  132.027531][ T5367] Invalid ELF header magic: !=3D ELF
[  132.057110][ T5379] Invalid ELF header magic: !=3D ELF
[  132.062489][ T5379] Invalid ELF header magic: !=3D ELF
[  132.074491][ T5367] Invalid ELF header magic: !=3D ELF
[  132.075012][ T5367] Invalid ELF header magic: !=3D ELF
[  132.089150][ T5388] Invalid ELF header magic: !=3D ELF
[  132.089910][ T5388] Invalid ELF header magic: !=3D ELF
[  132.970413][ T5387] Invalid ELF header magic: !=3D ELF
[  132.973440][ T5387] Invalid ELF header magic: !=3D ELF
[  133.040065][ T5385] Invalid ELF header magic: !=3D ELF
[  133.059397][ T5385] Invalid ELF header magic: !=3D ELF
[  133.065908][ T5379] Invalid ELF header magic: !=3D ELF
[  133.072956][ T5379] Invalid ELF header magic: !=3D ELF
[  134.001916][ T5389] Invalid ELF header magic: !=3D ELF
[  134.081406][ T5367] Invalid ELF header magic: !=3D ELF
[  134.092465][ T5391] Invalid ELF header magic: !=3D ELF
[  134.099773][ T5386] Invalid ELF header magic: !=3D ELF
[  135.127083][ T5367] Invalid ELF header magic: !=3D ELF
[  136.019054][ T5390] Invalid ELF header magic: !=3D ELF
[  136.026609][ T5390] Invalid ELF header magic: !=3D ELF
[  136.036211][ T5390] Invalid ELF header magic: !=3D ELF
[  136.036834][ T5390] Invalid ELF header magic: !=3D ELF
[  136.125859][ T5392] Invalid ELF header magic: !=3D ELF
[  136.126755][ T5392] Invalid ELF header magic: !=3D ELF
[  136.133849][ T5388] Invalid ELF header magic: !=3D ELF
[  136.189647][ T5376] Invalid ELF header magic: !=3D ELF
[  137.067427][ T5379] Invalid ELF header magic: !=3D ELF
[  137.067944][ T5379] Invalid ELF header magic: !=3D ELF
[  137.081482][ T5379] Invalid ELF header magic: !=3D ELF
[  137.130320][ T5392] Invalid ELF header magic: !=3D ELF
[  137.139695][ T5392] Invalid ELF header magic: !=3D ELF
[  137.151047][ T5388] Invalid ELF header magic: !=3D ELF
[  137.155097][ T5367] Invalid ELF header magic: !=3D ELF
[  137.195407][ T5376] Invalid ELF header magic: !=3D ELF
[  138.088801][ T5379] Invalid ELF header magic: !=3D ELF
[  138.144070][ T5073] trinity-main[5073]: segfault at 0 ip 000000000000000=
0 sp 00007ffee2c76798 error 15 likely on CPU 1 (core 1, socket 0)
[  138.150093][ T5073] Code: Unable to access opcode bytes at 0xfffffffffff=
fffd6.
/etc/rc5.d/S77lkp-bootstrap: line 79: sleep: not found


--csx8ktZH1zvSCQRU--

