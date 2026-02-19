Return-Path: <linux-fsdevel+bounces-77660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E3i1Kh2ClmksggIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 04:23:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4351F15BDF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 04:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BB0E300D0D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 03:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840227FB1E;
	Thu, 19 Feb 2026 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEoid1Uw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7F24C676;
	Thu, 19 Feb 2026 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771471383; cv=fail; b=lMyapWvqvVerqhcYye/Dpd1xA+GxFI0FvJ1fSjUKLYJYWiG/exasBlCdTGujZaAUeF9rnfG/J1PSv/32/sVNMzXDf8swjOSA0f1ttNwt7msHH/YeOFpCTL6q2mK3qciyXDt+4mHAWdonK3wC5XAvyBVE6ZLQME3BZacdhaYUA+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771471383; c=relaxed/simple;
	bh=OXZZxg0Y/vIZan6Zxh6MEVF/ZkhLHQYBrYwueo83qtA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eGDvd9RnsR1KgMiS3IuAGcZYChSi41xd0MJ28zM/hEywJzVZFgerH1GeOA2PcSvJHHzEr2JuFDPbp77UP6S6fxjPjghYztasl8gdPA1QNJ9X+hvKFUx/U2NoH6QMwyRNBT/W+LMM08EACqgM30gUhLgjeNaQjDE0sOaIPm32sv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEoid1Uw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771471381; x=1803007381;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OXZZxg0Y/vIZan6Zxh6MEVF/ZkhLHQYBrYwueo83qtA=;
  b=JEoid1UwbAA/Qc6cp8/12Y15pCjxlrYWe4AlvrFrC46xtVtji+10yqJE
   x+18VcoNxYBi9Pjgg6lNRFFdAFIE9e9yWpu0AyGX5aIzzmOufvqKjOu8p
   XBrWhU4w6Zvx6vRKjxENttUkX3aUoGnG92Wd8RxKZCNQDsUP6Hj0yhGjg
   02b9al0JKZ6mVfAcNWm3VOlfhPTwm62u36OjLJfGeKb98lOiebaB7s9Ni
   NtJ0ErpOxtT6KDmGdt/lXIB6HKoAsiW0b20g2ZIzC4ZCxXsc3ABnwCeu2
   szg5qDOAAZk7WF+7HFRqU8OvhGij9j3sGlAkqb2oLWNV3lwzJRGduExCv
   w==;
X-CSE-ConnectionGUID: ju11DvK4T8ujxgB4I07aCA==
X-CSE-MsgGUID: lvHI/HU5QTuxHrtlO2tBeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83918528"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83918528"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 19:23:00 -0800
X-CSE-ConnectionGUID: Nucu9iFXRqacPVKGCGwQew==
X-CSE-MsgGUID: 3RK5hqPkTlKQqNoIbHTHmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214400602"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 19:23:00 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 19:22:58 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 19:22:58 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 19:22:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRr/DrhGOaxu/f8RxMPQWEQKb/diwT9jFljF5NNr547D5IUpvnHnBaV8DgmVtlib8GJsR9CL3mNP1X/n/y4uMFtQxglFirmqg63dkyS4Wqh5XrYo1xJTvUm4Dq+2uB9Rbxkuzz57DCoSBN79DV46zFLF44LSVKQj9YZoJxrflNG/V80hhgk9i2yeVk6pC/TE2pJOZC+rn73OiMLAcn1F1Yp6vaRgmBx5y+QscYGadaA+WsrXayTJxNgwIJCeJc6T5eOZbCos+8ZgxXwEes2HBX+AQD6XQBPgQl7M3wOOoVqzLPvhxlIXPGxCmEycNzMoOVkVBBpwhtl+SzTIaAJEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XcwVwsO3M6UEd96rE9JngKiKuEgrLcwDVhL/6AKUwE=;
 b=tUMYg6OSYBt84lvxGi0T/FS6uuN80Clxc3SiOYy/hJBBoL2fDTSe19kvHNpDFvAfD2Ja7Y/XQpSOCbK/Wp6gG6DFxqbA+VUoc2hfMo7rF4slOgKh0OwUtr7I/CgxoKuQhU/UfUWy++m8blxOscs33wF7v29WdBPnromYZl6uySbWxgtMCtF7MVnpw3vzle2ITtgZCF5PYtOx2qH2bVsHmlvqtTiEsn8LBTPEMECTrXI4EvCAIwkqd/b/5gyahyMQk6rrTtsuPtvKAigE5JuajysGlm7h04WRXXF5CLzJ8RrIPm6Az6MMvPBMNeIFd+FjzyI+iwxWe1Gv0+ZIuIpsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL4PR11MB8798.namprd11.prod.outlook.com (2603:10b6:208:5a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 03:22:54 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 03:22:54 +0000
Date: Wed, 18 Feb 2026 19:22:48 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Subject: Re: [PATCH v6 1/9] dax/hmem: Request cxl_acpi and cxl_pci before
 walking Soft Reserved ranges
Message-ID: <aZaCCOlXSrjBe8Gj@aschofie-mobl2.lan>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260210064501.157591-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL4PR11MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: a749f916-97be-4429-636e-08de6f662bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3e2fUzr2hlDe4LfMWvs/B8XLUndAW0sQwkShTXdqIq2iiBJABcCyhnKwODia?=
 =?us-ascii?Q?j8DCsJqpdE+D7gB/JobCW14HjNDTk96fpkqQXzISUPc11X0OFD0RWXAFYOGU?=
 =?us-ascii?Q?5j9Rh4k+mNjfx7i1R4jwlJk2DgGIzSxmNBBQ1sCATXzMcqq6bUz8Ti4iAF2A?=
 =?us-ascii?Q?u0tVSwd5gUmDS4tlrZy9DHeWlMMJ9SqWPMFKvfI0GTRS52crhl9uWQfG7Pqm?=
 =?us-ascii?Q?aUVvIOBwPP4hZVWNUeTXhBp2Lybi8xjS6Il+gb9Y0rtmXbcyTzUV7Sypw86G?=
 =?us-ascii?Q?H9CuQErKB440YlbjWDSeMkVYXu4o7nkx3YHhWlAn4WNBjLYlEMB4mRsU7pZ+?=
 =?us-ascii?Q?W4Ba0BH2GEVze+RGF9juzHr0Dbnwyl7Q1oMpXHjKWWxW9plyzx8hYv+hm2Q7?=
 =?us-ascii?Q?st5Pzu3Qhhtp8brtKKtqqTEfxWAFSqll0gIXs4dbrQjnQ24gc6CVPtgGlAZ9?=
 =?us-ascii?Q?B35EH2nE2kvUBFFBCLNIsNbjpEcNMOsG3OaoMX7CKPZPsLaTAz/raCJhG6qb?=
 =?us-ascii?Q?NqNn5hSfGo/Yrn/dYKrL1SqFUp8Ju/h0eLe+uUr5TtKSh0L6gJFF0chQdAiU?=
 =?us-ascii?Q?ZfaQA2+vnznp7H9AbmqNu5bb/hu0Un+HeM7yhlEXYRlk4IWXw9KFgT2b9Bid?=
 =?us-ascii?Q?y4vK53/PQfdfHhJ2Xe5CcuVosqk1ALEmsF8jmB4/dR7e9yvLiN0zHR8hHMDQ?=
 =?us-ascii?Q?nZHq1ewuwu3yG0zh7Hp1JaX+U6JCqR7UENB7QnQ5MNJUwEGgyNeTHA0HNu1V?=
 =?us-ascii?Q?Olgn9vPRIc0HXrcN5uqilDr5/6yWF1dVjVfD1rgANhONalNiL8xZGWNY7PZb?=
 =?us-ascii?Q?V9P6gxCzcggGTPZm3mae9wb6MC78f34eisx3esktk5lvdZhHPiq8P4psWky8?=
 =?us-ascii?Q?hWA2+ieHrVshoq4NOhE9H7BcJt7LjChRokBxhWpflEqQp6stUa/PIbqg1Ccs?=
 =?us-ascii?Q?TGCjMs7XUd8PmXlC69LEEU/ONRk7Y4NjK4xP7PaGiNcmGB0xarf9MMo2mjov?=
 =?us-ascii?Q?sL1o4A9naQePH/7Oaby1guCdkF0y2IJjeVeaFQSLiGZozuB5RN/TvKECPq6S?=
 =?us-ascii?Q?eWCirI7D3cB4XsctfCc6R5b/ieMjgBu6nK13U9RBOxvJkqmWSTJVBpR44K0B?=
 =?us-ascii?Q?WxBrkVedu9yGhRmr+58dCPwPE/1pGoj5ssXWPyD7WxsgnKuifIs4nACQD7Ni?=
 =?us-ascii?Q?1kTKF37lDuDbzq5wKp7X5SKPNTIren7K2DkvrB6pgFVVx/wstzxclQYk/g9B?=
 =?us-ascii?Q?VRjKIqIZiwEr9qtRE9/+rbVFzUfcE9hSoArTH4S+vey4vcf2zanz0/1/SwQJ?=
 =?us-ascii?Q?UcfknagSe2MUcvKb1LmbNsiMjo63Io475tVYhduAZjUikFO94Sx1hoRvUBsJ?=
 =?us-ascii?Q?yyzpOlImTzlpuQ6ooAHzlM20+e4iuTIOk75xeY/f8gvkU3/5ugnD2is8K09K?=
 =?us-ascii?Q?tNYP7BBrYDmdUE0jIVrpn5Z7GBKUTh89zbF7Sg/E+ueVpfUk4wQnNub6d6Jk?=
 =?us-ascii?Q?LDGecKbJ97h0/wfIsf8uu/qNGWxhgAtIZBwKITezHqtuHi6MEir9hMWSoL7b?=
 =?us-ascii?Q?oQ6rZ8bVgcl5bIbE3sQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kZRjaVpanDoaf/ZwFF/F8Es5B9W+e7K+sq+A20mhTKoYnI4lXnNGuJkKC1YZ?=
 =?us-ascii?Q?4WUUcQR5cSFe8LbY4GNV8xs5eyfq3ihUUXnUq7ryk/DILvF8Ik1+khIpGOIU?=
 =?us-ascii?Q?DKYQM/t2aHvl10iZc79LXqv9EP4LhZjVojaX56Us5S2ib4GiSgjI0SbOzjzZ?=
 =?us-ascii?Q?vhdKAqD1w79Y7hGTA6hNfBRzMS2/qBac28sLZien0kA3FoHoxqkmArgy28M+?=
 =?us-ascii?Q?Jg3Fo++xtzGQPU7Ek0tstI21cdJhwavBwNYlUWbRMnDEIpIkFk7Y+LmUveix?=
 =?us-ascii?Q?HCB3J1F2YheRty8GuqZmbzXjNQSk9gCKHht0RGJqn69UQSp1vnunlFNMBeQv?=
 =?us-ascii?Q?pwWOGRpIKPenX4sCuVVFk8HB5JNRBAMB1KACxm1tE+j9n+kBYop6ZnISm0nn?=
 =?us-ascii?Q?HF+insygy2rr8b2Zr6Cq4zxnNYdt5Mk2mLA6kucM+ynZ52OFRQRSWScCZUDI?=
 =?us-ascii?Q?PzxSP6bFv1tBO/aOURd/pjLUfjbOIhpt3Ez1UdABmCdnAT01pFtT5fMTmD+l?=
 =?us-ascii?Q?RaIATmtZoyn4GalIJP+5vQ6h2X2V0Fo0Y1Qu7FsNulFhL2mfdXynhTgDbBSg?=
 =?us-ascii?Q?vPhpfDUwwF0/Zq9YHFihGyEWwOv0QMF5xzub3kWGlI9nE4oXS0OG34jBveWM?=
 =?us-ascii?Q?MNVv9C6FFupyZ/B/6P3JL4D39UgHlq7SN8Ec74jip5QjGFGASdIFTwDoiPYR?=
 =?us-ascii?Q?+0talmDYasxj6B/X/IV9IrxrskgRburZrdPqZCZ2Z/E7hk8DU9NvWswfmYtl?=
 =?us-ascii?Q?aB1YF4ALAinu/baa6V2j6xnao72G4rS3AqYG1gc4jUzO0RH9FYl16DwDjeV5?=
 =?us-ascii?Q?imp1k/YJx9sVWcdEvOKpPFY2Qvw0W6kk3M3ro0G7vNaDsspHYDRHJG6e0DfC?=
 =?us-ascii?Q?EpZZ6DrcL5M4MQGeFV453KDPhINJuRKylGmY5lAif4caQz5v4GA/NsbEb4wA?=
 =?us-ascii?Q?Cgk6oyGwehpR23871nvpnyme0H81iT4TKbtJaBhboMPJg6EEioDKU4OWTEQy?=
 =?us-ascii?Q?gha2hp3ela8KiZav3Jel0SgneBuyzZrKo/F/C8RqPVihCjNjMuyMJRWYuD3s?=
 =?us-ascii?Q?hcNITiRE20/snH27Qwrzecz+VQ2ucw8hO5IRfoGotqwzkN8ecFaht7BwEheE?=
 =?us-ascii?Q?/SkPKEne9TyKRyyIqRKgXrhDUOpcvF+S2zqEi5OTNyW6PBJRdNGfDtaK+fAV?=
 =?us-ascii?Q?wgJWL+YKXz1bEdiZYtQnZlR7jrOZRszG3FlmhsZ5Lv1R65M/3Lib5tKlejvA?=
 =?us-ascii?Q?3Txm0kAKB8mOFq8CJ1nY+sg60qVt0oFcwnzmNPE2N9OVUmZV/Xm2FCKGdgFN?=
 =?us-ascii?Q?0DYaFxkk48OWs0ZLMeohLLKp6U3cqFTrRVe4Xi5V91R8B22FJ7MLbZjmB3+Z?=
 =?us-ascii?Q?BZGm8LHOARHrI4QkGohYJnOGIV+R6mtk/759YAMXLjch5Er8IXvI25wTRfAL?=
 =?us-ascii?Q?5XFfXYM4Th7g0nDNrk1dgIZumeLGaNKXqhTBOIpOE4LEkvjqwL3W7l4rhzFZ?=
 =?us-ascii?Q?ewiJxt/eUZfdyDnv1+MoDR6BERkEy+anq+F+GTSFgrpW2KNuFDyp0tv6SopJ?=
 =?us-ascii?Q?Q1iFG7p8noG3nNs9XSXm8zPUz48wiBm3H/yZn5p9hIdzpNCtNI3Rgf4lcjq7?=
 =?us-ascii?Q?H0Mhp+hf24kdq1TMNHqQNhoNSWym08YbQ9gqTsa6Hx86WCKzkQ/pfiReehZH?=
 =?us-ascii?Q?J3hHuHRhb/cJp+H4Td4x9Et+pRGZdKCgYj98CmqyNHiDMgu1aC5JPexe7QZ4?=
 =?us-ascii?Q?uaVYDA1+VE7nbf0/DMHQgii18FUZmq8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a749f916-97be-4429-636e-08de6f662bc2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 03:22:54.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqLwTCGBE4P/zJnLRTjJ0y4eS3ow87BiYDiX3PNRZUI/3W/50ZdsypFWpyJkexgRJyyFgWKjm5FpYndD+TBExTxNcTERIYms3tnlhm1Bk9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8798
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-77660-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,aschofie-mobl2.lan:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4351F15BDF4
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:44:53AM +0000, Smita Koralahalli wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Ensure cxl_acpi has published CXL Window resources before HMEM walks Soft
> Reserved ranges.
> 
> Replace MODULE_SOFTDEP("pre: cxl_acpi") with an explicit, synchronous
> request_module("cxl_acpi"). MODULE_SOFTDEP() only guarantees eventual
> loading, it does not enforce that the dependency has finished init
> before the current module runs. This can cause HMEM to start before
> cxl_acpi has populated the resource tree, breaking detection of overlaps
> between Soft Reserved and CXL Windows.
> 
> Also, request cxl_pci before HMEM walks Soft Reserved ranges. Unlike
> cxl_acpi, cxl_pci attach is asynchronous and creates dependent devices
> that trigger further module loads. Asynchronous probe flushing
> (wait_for_device_probe()) is added later in the series in a deferred
> context before HMEM makes ownership decisions for Soft Reserved ranges.
> 
> Add an additional explicit Kconfig ordering so that CXL_ACPI and CXL_PCI
> must be initialized before DEV_DAX_HMEM. This prevents HMEM from consuming
> Soft Reserved ranges before CXL drivers have had a chance to claim them.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip


