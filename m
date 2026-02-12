Return-Path: <linux-fsdevel+bounces-77057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFE5FbxDjmmPBQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 22:18:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2E131321
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 22:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 020EB3021B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D632D7F7;
	Thu, 12 Feb 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAHf0mvt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE6205E3B;
	Thu, 12 Feb 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931128; cv=fail; b=G0VQqRVIpiPCUBrvnj6Vq6hzyvbhMpa/8sJLSiv+hBPFUmf0oFJPQKhGT973MwYgbGeH+hRDta4igDfnf+bzsz4HKXYhXgNZm5uDg3OZ6HlcddPLY/h7pyL4qg8Qc3DrzTWmyL9qO8ep3nauUEJCxgCDKpFA9reDTWLWbcN+5vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931128; c=relaxed/simple;
	bh=fH+81+BJUyNufS+g/6dqLNE2NAXdtKyMKM9G8BwEZ7M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fVLsYHPnumvVCePX8bPEoxBZBxai9Lg6VSpAVCtVmhsk26LJd1zKpl6XV0zNfi8xRcGw4tS/XkMJiZ16ozfIOeAkp+aJdDHetm9f+5BQgr+1UjPVExdp59YBmpwwQqEpCX2dc1dhLO/NWdWXgBhcgqQQQMmUI3BVbpGfJKuUn40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAHf0mvt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770931126; x=1802467126;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fH+81+BJUyNufS+g/6dqLNE2NAXdtKyMKM9G8BwEZ7M=;
  b=KAHf0mvthNHv+yX7NOJlJ57ekUB33j+BoeJ/NNA7PE5Tf85Tyf3Udykq
   oPdkFih0e9kaa0Lk7KY2mnpf+/Ds+b2nexwMsu6WRKRrjodD1kuArpKs5
   JiVqNBjQDipV3t242ANYGczp4f/unNKCLDe2/N4NLzuwOR9zfOQBUyXqr
   x3d/tcp20hZNX7kdXLhAFkBWciQOed/bkALU+RFfO+vwy7odbIZX31KKk
   zlMZ2aqPMA2kTjjRiDiHQnr4f0Z6X/2xXyOQLbGNBpsm+wzmyO7SRjVBQ
   kVCsc3xPtWfw0xayrNkkM1MSZCoZFxE8a29I/xJXZe5heRj04TtOdIn9W
   Q==;
X-CSE-ConnectionGUID: bJG51yHoStyiLSeBRgtZ8w==
X-CSE-MsgGUID: mewoW2TgTOGzVLDgieg7Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89700247"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="89700247"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 13:18:45 -0800
X-CSE-ConnectionGUID: PQOpkweHSMakcfc9q8paIw==
X-CSE-MsgGUID: d78YGmV/Rwyrk/TQStZyBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="217265655"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 13:18:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 13:18:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 13:18:44 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 13:18:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etZpe+7c65bebc0CCo7ynO6QuORPWT/w0xPpp/owbcKvT0dA8LH6LQoHNtkzG+V76237Nmv+uQ8+mQl/nekJ0pNWiYoebK6fVzMhwPaXr45jmmo9yHdOcA7TT63svZrXjjADikCvJ6i5W4sI7AoxMkKX1EQmVUb47TZPyJmubITSN6O6HWsyhtTEvtvQ6MPF6NFgBcDKlIO2i+Xot9eXsCyhJ1UDAzWy1A+eXkUQol5pgA7aLPQQFf0aTRHY2oQWxK4qU/KlZvP4lyYihGVjQ79VTY4AhVX5QLffuWR/j3LvI/YrbMt5+XPLs/eeX/Xm/XjxB78UzmEE8Y6laibveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuA90vPUILM8Mdz/Va6yWSPlwGfFH523D0cNeAHqzrs=;
 b=mLTIaqOcrubJsCw4X0IHxuMrlRZ8Bq9ChNnQyKx6jGdsxDD5+lpc01W+Gxyd/TH8ICSMNF2QHV19lXd15cMgUYSSQzMMTp3pPwmfOgZ61ijoFgozAA6fqGebBDK0DviqmzsICXHp4CHu9NvUM07bhFxl0UfGtKmlg38EQy6MN7wU/tDHZSP0CbYLHGrbqyZ1mEkZckvyr/lkI6uicO0HUPOd2yj1QPqGa1UTJ+hn2bpNVo8K7uk1qbXrf/32x+jdY8pHudxcg0eo/wFvZ12Ab/KoQja7p56smtkFZls+5vPkRahFlvWVFA2tuV3x+LZCL9Zb2yuWuKMkhiVE7w+80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB5001.namprd11.prod.outlook.com (2603:10b6:806:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 21:18:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 21:18:41 +0000
Date: Thu, 12 Feb 2026 13:18:30 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Tomasz Wolski <tomasz.wolski@fujitsu.com>
CC: <Smita.KoralahalliChannabasappa@amd.com>, <ardb@kernel.org>,
	<benjamin.cheatham@amd.com>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <gregkh@linuxfoundation.org>,
	<huang.ying.caritas@gmail.com>, <ira.weiny@intel.com>, <jack@suse.cz>,
	<jeff.johnson@oss.qualcomm.com>, <jonathan.cameron@huawei.com>,
	<len.brown@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <lizhijian@fujitsu.com>, <ming.li@zohomail.com>,
	<nathan.fontenot@amd.com>, <nvdimm@lists.linux.dev>, <pavel@kernel.org>,
	<peterz@infradead.org>, <rafael@kernel.org>, <rrichter@amd.com>,
	<terry.bowman@amd.com>, <vishal.l.verma@intel.com>, <willy@infradead.org>,
	<yaoxt.fnst@fujitsu.com>, <yazen.ghannam@amd.com>
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Message-ID: <aY5DpvAvqxqWZczR@aschofie-mobl2.lan>
References: <aYuEIRabA954iSfR@aschofie-mobl2.lan>
 <20260212144415.10418-1-tomasz.wolski@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260212144415.10418-1-tomasz.wolski@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 63891217-a5c7-44f6-8517-08de6a7c4bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sSJYaqXBdzCOQ/Q6BA35RGCBiLuIgXEHWlMJPfV24VBVzHXBJYygRD3MaSJm?=
 =?us-ascii?Q?R6EarvrUtli3Z6juxzEJJaLNFD5opLcNWsYTpH5D9VSNXkA8rWcuyRVDW3by?=
 =?us-ascii?Q?mkOlxC1nYiJSFXC6Hl4kcmpqXVFczL4wKPsNMFe9d1ic4SCz9LVYlv1INx1Y?=
 =?us-ascii?Q?eJqhkMN6eWi8imBikGa6OTgvzW4loUaLa/H6yUMKz1XmQRnRO15LcRIparc2?=
 =?us-ascii?Q?NYn3akjkm3Pu3JsmdJuO7kwVlrRIQf7yHaLuciUggzCn2m5vd885sPn3p3z0?=
 =?us-ascii?Q?QsExUNwUh1pFC1w+8ygCwI8AqmJGQIzWCTE6gaRCXwcaCWYvGg12hKNtz2hd?=
 =?us-ascii?Q?NYzI8lC9sLNoemajqXokW4UfO7xWnLLIgQngyFdYq6D5pnBrZZ2wIRxedIAY?=
 =?us-ascii?Q?dWl2YH1jrJdgqBhzyHmrzJ4B0M/XxVWlzTE3eIhkFsJkbLqbA1vN1+mHUU2a?=
 =?us-ascii?Q?LMHMbs32Eh5MDRr5lel0Fr0JcW8/CZSMAFj+z6yERIhK/I/z5OHDUeupEO+Q?=
 =?us-ascii?Q?a6tl2r7C10qgKrv/lVC/5RTZMMB+KBg+nCRNFTC/ALu5SWYt+4BMJrYdijG6?=
 =?us-ascii?Q?8nJNnNBupiZeawQglR7rhmlgZdqxDdx5mDX+V3uAwbPOVAAcSUaAHcFy9Arw?=
 =?us-ascii?Q?R3LL4pmlCsoyr6Fp5a68l0ADvLhOnSyY1rZ+5KQP41GkFTXLpKfjUCD9ZsMS?=
 =?us-ascii?Q?Uorl3hQX6Rp9d/oOixW587w7ITnj/8v0dPBD1bCZ7vscxvq/7rLnpIbLTwk/?=
 =?us-ascii?Q?Lpt26JdjUIzC2JEWFrbNzamZRVhMEQgcNlRpVonCAZCnHbusXRIcCHq8vnvT?=
 =?us-ascii?Q?YfZ5bb65AgvkePPYhYK9zizNkh6PVkVrLmNT6Yow+RwMFUdYnN1ODtoy6ymi?=
 =?us-ascii?Q?2JDi3X0+9fyYr6V5kPaXRJrQfFC8B8aXEHCCLuhcDiHLEcLenwdQRHuniQR+?=
 =?us-ascii?Q?bsHc/3S3j93cXjikhcDQSgQ9vFBAxN6Y4PrxJOUCiwLpMW6dpFvnx0Tpqy2d?=
 =?us-ascii?Q?2A/KknAtoqN8g3NHjzqiIfCdpmukoE/oRD/PV5ajAv96cQK/4tNt9+TASgli?=
 =?us-ascii?Q?xKIWCGsQgtHv0f+YYR8fhe0zrQmijYO/iHZoyetqvvUlb+sjfyARizRM4B73?=
 =?us-ascii?Q?uHzugj8511VmTmpKXg8FxspxUGu1MbN6w1oBsMD+yV+72Xdn+E2saE9M6WED?=
 =?us-ascii?Q?xM2IGblV54kEIU740IvFDwxEt7YV34Z4tzuo2nnfHHqpKcUrNEAKx6w2J080?=
 =?us-ascii?Q?xfwy5nxLbFpnP2G3nelHV/lyblGLL69gkXL1DWMnFxtDmR9EQt5sROBqwSTP?=
 =?us-ascii?Q?9VmaD4m6+X/9n5Ddle3ceOWzNZpNTqBZxgPuh0NaTQxBkXQ/JUn7ylTNSJfY?=
 =?us-ascii?Q?odf+5wsAyQ+AHOMPCs1II7Qv5AZWbnRPonaT6xm4cm025Cj38Yg+rvv7fUQv?=
 =?us-ascii?Q?xd2dW5qlLMbgyTtHD+idHBlFdqHF2B6vz0t/eRgwZM82/e1X+enqifJBt0z8?=
 =?us-ascii?Q?vldYbVmUztw2WdkGpPtDtkn5Fp7jEPg6IPX3XEvxW92vEbqvZHfsFO/HpAEy?=
 =?us-ascii?Q?jWeewsGz7+qeIqL2rNE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RiVbVEWS7Wo7jHRbboB7XPfzwDkoH+sDfAvojk0vXK5vuoNQYcRC4SpKeaC+?=
 =?us-ascii?Q?1tfwObusW5hQkLEBY7okmeCTIyvj/tRYrd4VPK+UlrHUVYpPgvH5U6Am4gX+?=
 =?us-ascii?Q?Flj3YW30V97sBqnczfMjpHAs7HG4vfJJ0k1TX2oITlZWLlDLEaoYldTb0l6C?=
 =?us-ascii?Q?5TZdbst4PvujrbmEvAL1O0Et6hb69xb+ULbzhY6Lyt72SQV/dXHjQPCiy61Q?=
 =?us-ascii?Q?rEs+Wn9n+wJmxWu7RNGacaoXNvwd0fvUKBtszu71A5+pdfsBjCiavhFds8pd?=
 =?us-ascii?Q?LgNDed8XbPqZlZ7C0S3IzOHA/RY2gKntvfcyDoF9WPwyhp2rd/zlVXq8j7r5?=
 =?us-ascii?Q?fzmQlyLr3US+vtlWDTQLhDTQAgDU1UWfZqNnQJeF7lLS9Jr3XMncKkw/93aV?=
 =?us-ascii?Q?xo0sJdfvMlATnwSjPBQpz1UGAYn9EtfpxWnOv0nBAZO9xfvlqLl2bIknE2rb?=
 =?us-ascii?Q?85GqlFJTBxslCOKtZ367+iyDh8yFuXQSEv7x1ooLLLj9EkldU/k/GScPin7c?=
 =?us-ascii?Q?K7xLWxV85tZcD0HWK6Xd2M+U7rTutvDF5I48ZqwiUBhMm4amAaEhxz+kC0Z5?=
 =?us-ascii?Q?3EOOl4aOxlcoJ6dyliK0ptnAXZAGgQ+uu7vc5JLp85htMScsxW+NLhFguz0i?=
 =?us-ascii?Q?aLdASCb59No9XZtjRWrN4RPkv0jgMvSwLwxWdrn3uN0IZzeohyRSIhQHR0TY?=
 =?us-ascii?Q?Uao/seBQ37nR3gGQ+RnmBNnYmqr1mXNQpu9EGwjc6boiftEbzShWKdRUR7bd?=
 =?us-ascii?Q?O+ryHwwh91fT6bgeZKnFQqW4A0qEAhFrguZD5AA8NEH8XkfG4XeeADJWuua/?=
 =?us-ascii?Q?OyCnt8hCDvfXytFZpUWpSypaJ573TW0VP3/L5vXUZMnS0lu7xuXFCXY6sgKE?=
 =?us-ascii?Q?hcsbov3w57edrDaV9rvyEXIdtNWvri8wJjvlEN8NHjN/gc9S0I9Dk5/bi1Qm?=
 =?us-ascii?Q?rnfV4cOEGm1gEbEUk7GwNQehN0WIawI6lmRwWK3bO6oCLXxv2E5YaTW6rLzd?=
 =?us-ascii?Q?eyj6/NIM7jvfeKNhp924SEQSUBIMxbnItypJ3ru102oMQugLoybk+Jw/zQXa?=
 =?us-ascii?Q?4XMeuTFY5YwgHgTp20HVAkXvdIOMQShvddUsiYVKbjMJAjUDws8YJCcO7jCl?=
 =?us-ascii?Q?M+rgYGZSziH4eqLbP7J0edaUiaEtpFSeu17kZque9PqT0LvEad+WEY12m0nq?=
 =?us-ascii?Q?VAQpQeU8fuqFiYsE/xrbFm10nSQJyDLXMRfHd4WM4ToJYJhMOWD8gBIcdlmZ?=
 =?us-ascii?Q?+r70a3gwynt7tvNnsrEs2qjnJmikcHfJ1gVXcpc6Z1/74ALREGZjMjCyZ5Gm?=
 =?us-ascii?Q?r/HTX7rEFSWgxka91BmiRf3/9kyzEbxS6AEaYgHYt6T1r6N7I3qdao8Obirz?=
 =?us-ascii?Q?21r4RrvuBE1fWLuihkdXQGMfgZDFvxErAc+q+uawGhOnDUOpeTC8YG8kc8BU?=
 =?us-ascii?Q?PVUF3mKKT6fahr+yMnUOcedOpIgn7r3YqzCCaNA2geWTbV49WmTD3OK6zlJh?=
 =?us-ascii?Q?y2JrpTz3y4ojxFYEBLuOIf2HC3Fj2BaPCXCqHwICMyH2zm7Zh2SKtSTORGDB?=
 =?us-ascii?Q?gipobzqRcLlKQZUG43jaesoOxj1bwjSs2vnkfCfpC5eh6BDJOqZyyHyLq7ck?=
 =?us-ascii?Q?r1MEi1MOm+Y5AJMij2JdM6DWqcBQ34ijiWbLeuGCRrH88Xviww7Uk6yoeezp?=
 =?us-ascii?Q?Rlx1v/FfZVNgLe5D8xB8/9HIBuE3IzfmuMrstqduzS8oi/qswCwWoKqsltab?=
 =?us-ascii?Q?1HhwIRb0u7PL+c1FEO8XdQKI8uCosFk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63891217-a5c7-44f6-8517-08de6a7c4bbc
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 21:18:41.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8jUlDVwIuhZxlnRh4l5f+xqL7XYj2lM8abp6nguBnm/0l+E4+I95Q0yf13zz1R/i4YEVQvYrLd6kjOlO8tBGl90sShn5N43uECz9AJopgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5001
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77057-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,alien8.de,intel.com,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,fujitsu.com,zohomail.com,lists.linux.dev,infradead.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3FE2E131321
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 03:44:15PM +0100, Tomasz Wolski wrote:
> >
> >FYI - I am able to confirm the dax regions are back for no-soft-reserved
> >case, and my basic hotplug flow works with v6.
> >
> >-- Alison
> 
> Hello Alison,
> 
> I wanted to ask about this scenario.
> Is my understanding correct that this fix is needed for cases without Soft Reserve and:
> 1) CXL memory is installed in the server (no hotplug) and OS is started
> 2) CXL memory is hot-plugged after the OS starts
> 3) Tests with cxl-test driver 
                               or QEMU

> 
> In such case either the admin fails to manually create region via cxl cli (if there
> was no auto-regions) or regions fails to be created automatically during driver probe

The CXL region creates 'OK'. It is the DAX region that is not created.

> 
> Is this correct?
> 
> Best regards,
> Tomasz

