Return-Path: <linux-fsdevel+bounces-76875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGVuHFeEi2neVAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:17:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6D11E94C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B014305E391
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2D2392814;
	Tue, 10 Feb 2026 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OL0pYQ79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858630C348;
	Tue, 10 Feb 2026 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770751027; cv=fail; b=MqfbLFr8rkTm44R47MFhv5cXG/e3qHkwzrE5M1tKAXM+kI4+Uqi6zu9Y9Fqm5b+smYrRbA569e0RGKDmv0e3ajDDKdCvGq0FKnjV4BU6+1OvBm0bg3Dql7XDBPb9uYLJhpaQirQNEEe9TgIYtE57IhQMJVKQNqfNxKEqU7uSYAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770751027; c=relaxed/simple;
	bh=VgZa9DXgnXi1al9nfT72qQJ7tbQyZ7SnL4AfLT3E/ug=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBBvNJ9qyaDvvrdilShPV8J338R07TDJl3VQGgz93msAzI/QbKctPgGbu3ag4kqldfL0nYSD0bON/xwTPQgnd3E4UP+zjPq1kZqQpig+ihq2c562BSy8iHfbsjpOOOgaUpqcANdwITL2HyNoRifLITem+TCYzuznSgmHmHdK3no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OL0pYQ79; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770751026; x=1802287026;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VgZa9DXgnXi1al9nfT72qQJ7tbQyZ7SnL4AfLT3E/ug=;
  b=OL0pYQ79U4IkjUWVX8ZL7qeCUSxqnu9XLrvfSHykLYFLJ278sJx1Km/l
   S/9DjeH63JQSgcl3bePrSKb5E2FRthnuKtwhn+hKnPSwwdh3mJmAStiqM
   kAMKdr7bpSDz7LIgSDnJLYcWUSWznNZRGcfDbHYB7zY/BaOXyT0v3nFrb
   tlf9SzjCrHIvSZbziv4dZp4nyPWQSiSPzr2FT6iOhp+/y9zg2YzuGHgjW
   8f8xQM1Ws4gwPXgJ89p0UfYeKkv0MWRV7W2/Y9Ixssba9J+v9IxjezwbZ
   TSifNcWcBrQyL61QlD2rpvxV1DYY0z5M76Hh7Ko+IyVgdepW2c9kPdVu4
   g==;
X-CSE-ConnectionGUID: CJVaKAZfSg28aLey5lYe8A==
X-CSE-MsgGUID: bb6/vq4TTUK2LeXBrg3eSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59455363"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="59455363"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:17:05 -0800
X-CSE-ConnectionGUID: u9DNiRkRR22uFjXPYTbW0A==
X-CSE-MsgGUID: ohuI3/hGRO+UOjznoaJ66w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211638250"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:17:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 11:17:04 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 11:17:04 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.36)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 11:17:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4UznF63zjsF4nUg7EhG61ibjc9bmvsOdP3VGXheB88h2ZnnpP6DPNmXEnroIoNmnvbiWa0SYPl6AbX6bbu+khSGb1nzwvEsiymLsldhie6R/Nv1bK2WPLWINp5RuRgyphHCtbDQApTrRRhSU4i74dVnMVJSi7cbgmbL75s0eGnS7hWq25NjfXzC7fyKaYAxnmhmFeUp9KWo6Q/YStbdVMoAYfytDWJF5iXrp4PE1waPUmcMEx6ulXnQyFEm7Gj4StXuHBCqmQqJSkH5ZnIQsNH4kRSHm/m6Z9SYTguF42gmaviCVaNun9NYazzfXcegcBLsTCEswzGWdi5gGKybAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZr9vQHnUHRRorGPltbuPMNWo9ccXwkpdr0kuyH5MOc=;
 b=W1ekCjzdn5C90RBP5AypbZtuBeiDC4oSoPreI8QA1V0vjRtiR7VUduOSWkOY8mpsQlDJvZoJsmCvJIPFZts+7Gz/R+Bt0g6JpiZV3Q8aL8QXnfOkEJxrSjuGuUA9LsU+MYK/lp+sGoooe9htxkRBMHi6IFn3XH7R6wibVAQiwyy0j+Y+zGQ3RIOy2ZhzGeW0fGEHvgs/ZweDZP9ErV/x3UK9DfR6NK3HLEKYNxH3yXrY1RRN6O44RCDyi6Uy48jv3B20pmlm3bHPuiJOq6uYIQIvpjV/PBG4ELeeWi01VUfMOYsWrQlkXuMysXZOYZlFuRbw/wWPurWv38fsP+tfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB8267.namprd11.prod.outlook.com (2603:10b6:303:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 19:17:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 19:16:59 +0000
Date: Tue, 10 Feb 2026 11:16:49 -0800
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
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Message-ID: <aYuEIRabA954iSfR@aschofie-mobl2.lan>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5bbb18-1282-4208-65ce-08de68d8f6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w1sIAhyrlgSJdEfUkeDECe9xUVtOlVASI7ezHJmrVqPDEhY/jTDQiCoeireW?=
 =?us-ascii?Q?I/Gk+/iiNRkBlXqNW6qbHRCvDJruv4xTHGW1lfC4yA0coGHA0N1CQpqhcbEU?=
 =?us-ascii?Q?HCUJ6QnVPreFRdvNpRfvG4a1P6S/juKmvyqPeEhSFCJwIpvDn0haE3gfEX7f?=
 =?us-ascii?Q?lbgo+RY+TZ0ChdNXVs13M3q+Mk7xCIJ53i7/Bv+yS//8Qgc3gDJmuh+ci8BU?=
 =?us-ascii?Q?wEVXwigVyQ0aekj7vzr9duC0rPeeBZQrG4Iq0raxXwwpCA/lXMujNdIP49mZ?=
 =?us-ascii?Q?KH9jjMjgr4dEpS/lyB3bDnV8K4Cju3D2LBM1UayNGnHOosMDLy2v2pDyJnl7?=
 =?us-ascii?Q?HEPYB8K3fEka7Wh6zj9pWJUPSo5PIOJyxlhbrdJzl2wJA6+vuwHTN2ag9tOV?=
 =?us-ascii?Q?DVFujSA94T9HlCkXhavqn3lwmMDJQH47M61I7lIdl4df9APV8HkNoxro+R/i?=
 =?us-ascii?Q?6iUwThZ+n94g+u85nTS1ciFJ+FYoJUaVznJLbO/mU/GtHfol9p+SgwlsCIbs?=
 =?us-ascii?Q?uQVtOD2YoFRWV1S9ePYvH5tGS/uHho4ZDlxRbf8/aFEsUirB+PphWJolWL5b?=
 =?us-ascii?Q?8lOEEJBJBi/y/M2ZRCsXuDfNvQ7J/qewb8wgimsiSbR6/dkILkrQPArKrXvU?=
 =?us-ascii?Q?ah52kAOSLc3FxStazdtnZaChaBB/nNeKRgE+1f7oORMK0Yj2fR9Uoak7Ru4y?=
 =?us-ascii?Q?i0aFCchcEiSWf9OLwQTdN4/nf2jrxRPRCzyT2+YmDkDv8i4Wgpxw177s6t+S?=
 =?us-ascii?Q?u9aUERLFhuAPmIokBOtKPK+Q90572tCRi4OTYdcmfA/lhHfl101oRxeoyY4A?=
 =?us-ascii?Q?5FYNx3J1X37uNZYBDyt6e/QAdr+BuTbuhUna/1eUZUbLCvuKcaOLKogFGjMS?=
 =?us-ascii?Q?PBRQ3XzWXEL6mEz4hbMsmKhOl1RZTUTDBMcNQcHFe0ySvf1GSWsCPIinFrPU?=
 =?us-ascii?Q?aSBBtsssw2xvcofXGtwYJ5MXqKZxn2vCalYa1ygTJFZzYsdiIZauEiCE8K5y?=
 =?us-ascii?Q?xeGNptCuUybYO2RAsHgbpgaD7OCVnpLxvS96izNdY9/9UGm7ZAa2hLUc5c1c?=
 =?us-ascii?Q?k0TaDS/o+DBb8NAJq//8zb9WYpKBCoV7qUN5A6vK+eLWvDDHhUNT8NPQjV1o?=
 =?us-ascii?Q?7E35tAfRKiLyxety/Gx3vLaS5BdSDejyS2Wf9Va9EE2Ddo5JfVFhrLPgi3zS?=
 =?us-ascii?Q?xk0d4Rnu15mN8MZDgr4CYSvnaW19jS0LZVD5/Fuad2xGLVnIlqcunLf3bvbq?=
 =?us-ascii?Q?Toj34b6kX4lKsqFXY/QTKFPl7RVaNTQdNiEBRVKwM5emipAklVg5IfAiam4w?=
 =?us-ascii?Q?VRnvMtukglDLJe1TlBLgxUUezw9KUeB9X8zf58+Rf86MHGuSq8PXaoqdmSRA?=
 =?us-ascii?Q?TNb5ndwXxYCOggGMGrdX/UdIdxXtzzvwepZDyFZrQhR7qsLOHPsV3iBjPzwG?=
 =?us-ascii?Q?UphiHeN4dChgTgMTZTGovgQITTeGIv9wI94tPXoiKly+rSmccUX+iB8zkkii?=
 =?us-ascii?Q?GW2T9QbMhsf9QUGGM4wMNBTEiO/S4XdNt21ANIaTMRBeGS7gTDOqE6D0JCm/?=
 =?us-ascii?Q?63MCI29bPO9LejPDHN1VVqWfmquH9mqSR53l4OCW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ilxvwRRfbAaUEtCsVnT7cOPkYUXb7wn05Uwa0FjFW6D/wWdNucPbmwezl4U2?=
 =?us-ascii?Q?+k4IOHA94EuJPoCz7l1PKTcRL3jdr+8p89O3SsVr5GQZe9XoI/3jqcIFnQ36?=
 =?us-ascii?Q?tPqvLfNOCmrJFjZRyVXp5zgX10rJEnXHp5KCELz/aJnAO2JLYia7SqdA+4ER?=
 =?us-ascii?Q?appX0cK7Rdo+HWv7qwcUN4gCbeujzBRTJ6mxEp2neuz5YA0cES5KnxSdiOSB?=
 =?us-ascii?Q?prHqowM7nWISRQVOga3k3CmJm2eUAaq4E0oZoy5KxBNAJV7n5SKXTKRNkOQ1?=
 =?us-ascii?Q?1QxB41DBzkUL4sV8I+1DOVHNK8VXRNy+AtkItiODnwSYah4x8SbMoKyPawGt?=
 =?us-ascii?Q?MvLt+l28gCKq4amVBoNoReR7rul+sBx2eL407VtZiwRCvKFJjO2wypCgm62D?=
 =?us-ascii?Q?djW9C/79m8fYp4vJ9QqR3ZKvtt5bWS9XNJlz5oEp16rjc0PxA1sLSy+sXOPO?=
 =?us-ascii?Q?Nqv8Q1QbE4+QXB0ezaGPMuSbuYwTcZ7q3dpdDWeV3ZaSer+Gd2NBrWuS+uTr?=
 =?us-ascii?Q?9X1O5iHKB8kasMM4THu2CpNi5iu4W580zk/lPXuhfuaqhnMaKlYo/3pl4AKQ?=
 =?us-ascii?Q?doqM07SpUOdBKhK33/j7eX3kltUAxyLKJ7dqRpTa9ZS9xHvVeLopxOIDQTd9?=
 =?us-ascii?Q?EECh4IuygDOcnPdU32Chg+geJRVg2eOJILbBGzfzR77ej1n+SFpToJLNEx/g?=
 =?us-ascii?Q?Du+Aj9qpz2pqT6NiSkChRLShLcV2rJrk9I6lbCDlGx/ir1Fu+X8rrwl2bEwn?=
 =?us-ascii?Q?1myQWW3IvVx3v4dZhlPV5VrVi/MAKGEj9uzP1OxaqIigJ/y9awqdqGt1peZg?=
 =?us-ascii?Q?wx+ezDDYml4Eu+87c4csfxjAxlg+C8yxRaDLot4nYlVnxNSkUhhF72xcs7of?=
 =?us-ascii?Q?puxLTT/AzfPHGYTyFQgBL5ilGSuXDAFoztkZw1sCmpAMd77fG4i/NpyUpL9z?=
 =?us-ascii?Q?tWWA0aMXECA77+KMIL228zTVBgcTodqN7fGpiWHBnuln2HozRehl7s0HOCOE?=
 =?us-ascii?Q?2BFhN296d3GXIbJfAjtByBThM3j20TYq/X+8MhAgb2x6DiFsVYR+HOzKsGyg?=
 =?us-ascii?Q?MhtSSHMRZkWsGx8N1YJMcd3US4lzAuaiQ82/2J+qbut/B0XXnd+LEjpfcqwk?=
 =?us-ascii?Q?qaFXMAs/ofZG/xGP4C4AEFzZYbmCcc4lxtdNgxFpgkm6l1gfVyh0HGwwIAD5?=
 =?us-ascii?Q?Yfcv/6YhySvybTbDruBusY/LLhio1t9mT6WIsXkygAUuHpSR/f7etHKA1Ks8?=
 =?us-ascii?Q?fYprbw8ZjDmdILHV2BB99t4vlrIQwawtiImKyb5DK6j/R1o0tOP/7we1Lb00?=
 =?us-ascii?Q?/arUKhg6qoEJWbYTt2RkRrSINHz0ILXe0sdIyciJooZPyJTLhFx3R0mf5hOH?=
 =?us-ascii?Q?H18gMRjxHMwACS/4r6BN6PseI6ydyXEwrFgTQCk7reXl2As5ogj5wbhq1nWq?=
 =?us-ascii?Q?dtb7PbIjuTXFcwY6Vh/4Gaqw2cdQm9oZXhFyhlHAz44nFArn+X3kryDPQVE4?=
 =?us-ascii?Q?GhWvSYHIsdb2LP0oI+hEyI+SGrjWgfs3plRQZfZ1PQ+aMv4GpPnfma7eRV6+?=
 =?us-ascii?Q?LyYHDmEQq29rXeE+dAGr7kY1AXXYXeMgd+rr57Sls+vtEXq070qjwkzIhYK/?=
 =?us-ascii?Q?8ZuoL41xTrC1+DXbvm1bJ7xvNkCaX7ypGK2zdhJi4KUavYtx+d4z69oB2ZvF?=
 =?us-ascii?Q?IMSDOoq6w5wFVnG0Tkysljr4VyZKINJ8xS0hQ1OfDgvDesgLd4AIyfqGehhe?=
 =?us-ascii?Q?spP+M3YIH/bcwf957IQdy+OIAWif8jM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5bbb18-1282-4208-65ce-08de68d8f6d3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 19:16:59.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uV/Qf5LIZ52YLrc8hbSG3ZBLXU0x6XDOlP/QuRFo12PY6GmkJU5NgswILfitRz+21TG4hERiP2eEMqnN2hbQNo/XUNKyKouBj8/oUhC/iFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8267
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76875-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aschofie-mobl2.lan:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F3C6D11E94C
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:44:52AM +0000, Smita Koralahalli wrote:
> This series aims to address long-standing conflicts between HMEM and
> CXL when handling Soft Reserved memory ranges.
> 
> Reworked from Dan's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
> 
> Previous work:
> https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
> 
> Link to v5:
> https://lore.kernel.org/all/20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com
> 
> The series is based on branch "for-7.0/cxl-init" and base-commit is
> base-commit: bc62f5b308cbdedf29132fe96e9d591e526527e1
> 
> [1] After offlining the memory I can tear down the regions and recreate
> them back. dax_cxl creates dax devices and onlines memory.
> 850000000-284fffffff : CXL Window 0
>   850000000-284fffffff : region0
>     850000000-284fffffff : dax0.0
>       850000000-284fffffff : System RAM (kmem)
> 
> [2] With CONFIG_CXL_REGION disabled, all the resources are handled by
> HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
> and dax devices are created from HMEM.
> 850000000-284fffffff : CXL Window 0
>   850000000-284fffffff : Soft Reserved
>     850000000-284fffffff : dax0.0
>       850000000-284fffffff : System RAM (kmem)
> 
> [3] Region assembly failure works same as [2].
> 
> [4] REGISTER path:
> When CXL_BUS = y (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = y),
> the dax_cxl driver is probed and completes initialization before dax_hmem
> probes. This scenario was tested with CXL = y, DAX_CXL = m and
> DAX_HMEM = m. To validate the REGISTER path, I forced REGISTER even in
> cases where SR completely overlaps the CXL region as I did not have access
> to a system where the CXL region range is smaller than the SR range.
> 
> 850000000-284fffffff : Soft Reserved
>   850000000-284fffffff : CXL Window 0
>     850000000-280fffffff : region0
>       850000000-284fffffff : dax0.0
>         850000000-284fffffff : System RAM (kmem)
> 
> "path":"\/platform\/ACPI0017:00\/root0\/decoder0.0\/region0\/dax_region0",
> "id":0,
> "size":"128.00 GiB (137.44 GB)",
> "align":2097152
> 
> [   35.961707] cxl-dax: cxl_dax_region_init()
> [   35.961713] cxl-dax: registering driver.
> [   35.961715] cxl-dax: dax_hmem work flushed.
> [   35.961754] alloc_dev_dax_range:  dax0.0: alloc range[0]:
> 0x000000850000000:0x000000284fffffff
> [   35.976622] hmem: hmem_platform probe started.
> [   35.980821] cxl_bus_probe: cxl_dax_region dax_region0: probe: 0
> [   36.819566] hmem_platform hmem_platform.0: Soft Reserved not fully
> contained in CXL; using HMEM
> [   36.819569] hmem_register_device: hmem_platform hmem_platform.0:
> registering CXL range: [mem 0x850000000-0x284fffffff flags 0x80000200]
> [   36.934156] alloc_dax_region: hmem hmem.6: dax_region resource conflict
> for [mem 0x850000000-0x284fffffff]
> [   36.989310] hmem hmem.6: probe with driver hmem failed with error -12
> 
> [5] When CXL_BUS = m (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = m),
> DAX_CXL = m and DAX_HMEM = y the results are as expected. To validate the
> REGISTER path, I forced REGISTER even in cases where SR completely
> overlaps the CXL region as I did not have access to a system where the
> CXL region range is smaller than the SR range.
> 
> 850000000-284fffffff : Soft Reserved
>   850000000-284fffffff : CXL Window 0
>     850000000-280fffffff : region0
>       850000000-284fffffff : dax6.0
>         850000000-284fffffff : System RAM (kmem)
> 
> "path":"\/platform\/hmem.6",
> "id":6,
> "size":"128.00 GiB (137.44 GB)",
> "align":2097152
> 
> [   30.897665] devm_cxl_add_dax_region: cxl_region region0: region0:
> register dax_region0
> [   30.921015] hmem: hmem_platform probe started.
> [   31.017946] hmem_platform hmem_platform.0: Soft Reserved not fully
> contained in CXL; using HMEM
> [   31.056310] alloc_dev_dax_range:  dax6.0: alloc range[0]:
> 0x0000000850000000:0x000000284fffffff
> [   34.781516] cxl-dax: cxl_dax_region_init()
> [   34.781522] cxl-dax: registering driver.
> [   34.781523] cxl-dax: dax_hmem work flushed.
> [   34.781549] alloc_dax_region: cxl_dax_region dax_region0: dax_region
> resource conflict for [mem 0x850000000-0x284fffffff]
> [   34.781552] cxl_bus_probe: cxl_dax_region dax_region0: probe: -12
> [   34.781554] cxl_dax_region dax_region0: probe with driver cxl_dax_region
> failed with error -12
> 
> v6 updates:
> - Patch 1-3 no changes.
> - New Patches 4-5.
> - (void *)res -> res.
> - cxl_region_contains_soft_reserve -> region_contains_soft_reserve.
> - New file include/cxl/cxl.h
> - Introduced singleton workqueue.
> - hmem to queue the work and cxl to flush.
> - cxl_contains_soft_reserve() -> soft_reserve_has_cxl_match().
> - Included descriptions for dax_cxl_mode.
> - kzalloc -> kmalloc in add_soft_reserve_into_iomem()
> - dax_cxl_mode is exported to CXL.
> - Introduced hmem_register_cxl_device() for walking only CXL
> intersected SR ranges the second time.

During v5 review of this patch:

[PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory ranges

there was discussion around handling region teardown. It's not mentioned
in the changelog, and the teardown is completely removed from the patch.

The discussion seemed to be leaning towards not tearing down 'all', but
it's not clear to me that we decided not to tear down anything - which
this update now does. 

And, as you may be guessing, I'm seeing disabled regions with DAX children
and figuring out what can be done with them.

Can you explain the new approach so I can test against that intention?

FYI - I am able to confirm the dax regions are back for no-soft-reserved
case, and my basic hotplug flow works with v6.

-- Alison

