Return-Path: <linux-fsdevel+bounces-75563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPJ/ICQXeGkynwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 02:38:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C78EC50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 02:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88384302FE9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98D8221F1C;
	Tue, 27 Jan 2026 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/X0DULm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA20199949;
	Tue, 27 Jan 2026 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477914; cv=fail; b=QIPKzXdw2901HXUE8vm2FDW/HD6eRyrFBjC4vo0CPSALzVao1DPP8wdi23dGVuAI1+khJAy5mpm0JizKQa/XcICaz/64fY+pDlVwcOLDGS5rzwBKwYNYTBAq/awBZWK9HUQLpML9rSDj0K2b6KAba7+upJLIw/UfiL6NAnaLOSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477914; c=relaxed/simple;
	bh=UDb4YbFtqMdNjqhTYduyLskXI6Be7BEtsUnS2BDnzoY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HmLj8SvbJqHecoHo5ZfhdvewUJ1CqLKelgomJu8VkMTOkB85mZXXNRq+jd/UyelgmmvgJdWtEVK8Gi0jgcOLodfX1lFQ7jOOknyfUxHRsY7XbtArx5UciibzwxzUlBzztrb9JFHEx5RLhJZbtsf19+C7DocK1v1hwfuufMTyFzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/X0DULm; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769477913; x=1801013913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UDb4YbFtqMdNjqhTYduyLskXI6Be7BEtsUnS2BDnzoY=;
  b=P/X0DULmfnVzV2MZ6ViPikwMmb9fLym4GSCbJ7sR5mL94Kk3NeGh0Ea4
   r6sGAINxRT4zrDz9clbOsMy+SbURWSmMCqxEY4O+btr+gpT+56rLTb/bO
   bOoEyGMJ8764nwPgmN4lMeqIjsLOjCTyKAzPIyFV7ou9IEKs9jBpi8oQq
   g7/PuN5cz4xirZZ01Y2GtD5XFAEVQDFqXGvsOi+Qg+Tl/6jtYUzeL1WTm
   hHbGeZFyS+FFBjMxLeMZHZTZc3qEh9rYbZ00L2hfbnoKf6scXzPL+qKIF
   TyvuiMqZD3z8Mm2mu7GEXwal93dKBSxMgUW9a5DrmInlvszxfZS1jrt8z
   w==;
X-CSE-ConnectionGUID: T62Cswp/SwScVRPtZRCfOQ==
X-CSE-MsgGUID: uKDQc76QTHWuidZGXhvVAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="96127420"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="96127420"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 17:38:25 -0800
X-CSE-ConnectionGUID: 1vXvL+yfTGGImgk/vsWkJA==
X-CSE-MsgGUID: 4GJx6IqiSsq1T3utbtUBiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="208194872"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 17:38:24 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 17:38:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 17:38:23 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 17:38:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrbhqe/TtOWCJpaG5KYPsarurBRam27YIwsd1jUq2gO9Hq5AFzCH3f25TSoMIZAF8fCvj9hYlrakTDOLKnV/xljeDSDStHOksgj42S4ECWngVYqZnO1aZkYZxmuMLefPsMz7G8DHYHU3n7ZQDBRbvxL2y4ZCHRjuS5WXdFDDEYNTx5ZudE/UVECGjeTpqnznkzY9lkRFryGzvzaKsZLTNNIqVZ5fUKvxGRad3iBhMa3WJwvprUQ8Nb8cgo+1Xg7QFhQCVJPcouwsFn+a8iO3v07U9v7Z4E7o1ePTJyhy8S5wjpxJT3eaTLD+nIWYGDsge4VuDGvXdnRQHK6F4gdaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSb2WdGMTYFuAvsria+NcZ5HJPkuk3gD+YhEzH8LH3I=;
 b=MDwUoGkjs857KM7cZQf4OuEErBrZzBAx7NQj9wpljiSV9DBri2bxIckHP+yicOg8U4UYrJaWxdd8HY2tP1z6IHTwlMcvTWCppipDIzFLWlQxinfzEHoqUwdDVHmKQjlNcsVe9HYVlLp2ZnMg4T7XCw0ux53hUEsNpAwcsoqUmi9vW9yQXJ9RU82+VBp1ji6YgHC8VTqkHmjQbhJfbbm5g6QsyeUD4Ki1n685jcG82ig8RPAm28NH6eCkA1f8d19ImTaJ2ZoMjJst/UUWlkvY6SzyLJiI2S9J+mreXokjNC7UrcGYywi5fWMvH9h+FLgrqe5E4nPW3VaWhaOGxm4DAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9424.namprd11.prod.outlook.com (2603:10b6:208:583::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 01:38:21 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 01:38:21 +0000
Date: Mon, 26 Jan 2026 17:38:11 -0800
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
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of
 Soft Reserved memory ranges
Message-ID: <aXgXA2OYOUfyGlQF@aschofie-mobl2.lan>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb89926-8cc9-45d1-7340-08de5d44c139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U/GErVttnxf4YSMCaWNJTa5TRXEEFFd14KYxIQ1L7W55NzMjoKEN7VbB+Sbn?=
 =?us-ascii?Q?k3pccDT8JbLjkVpRv/d6lSEYg55FVLhx4mfl2inkPYiWHN6G3CNMD6zywDHS?=
 =?us-ascii?Q?8etC+woaBAXJbJCIhKUtjLRpHHBq44xq97mdcLGl9v3ETy3DcAaXsBrSA4Dv?=
 =?us-ascii?Q?fzj4iw9IkmV5/lxk2Lm3IOO1MxuEhFeIzCM2Q1e9MeltyRvd9Kdw0xPM31i9?=
 =?us-ascii?Q?mQPo6pHkvu9qnuJvLP0UAmU2BowL0b5R3/GHwJiDfbw5e3E8XCejDhZL9dhD?=
 =?us-ascii?Q?jMVK0OGMj6N2rqt1BrwkTrQhA6woNNH9EZAa1k3PLSDKn49HSeDbK76UZfq1?=
 =?us-ascii?Q?tUojmhUwvX085nWnU1eeqBdkAnMMLtXqIzrdy52W3+oJr1IrFOq8n1wsdSbf?=
 =?us-ascii?Q?tUpERwZyRZNxfdkhE+y1dJwbhF5fwg04+/AGSFJDGL/iNC4VTcLzrZa4aiGb?=
 =?us-ascii?Q?ngLQS9BC1EoltjJLeHR3LETKiMVr2g2A4CXu7rXGz1hd+crhi+O6P42bF41l?=
 =?us-ascii?Q?FjAkuV1Pwv/sjabdCCwibxUT2PAB8zDmRR1QaR68n5bO/JsQDJaI4fUQpbbV?=
 =?us-ascii?Q?qk77oQKKleosB+RDyBUvc6cESTvPfqafqUiCpundrD9bBlo/WZeDgaOICLiH?=
 =?us-ascii?Q?5uFZUqf+qONVWD7uG9q/iL/ByZaMXxOqFLgNBF13Op85Ukx95+35kepGErd5?=
 =?us-ascii?Q?2Cg611K1UADwseEd0/6Exgw554COnoclsxWlfEAE3tah2QZlT1vkoRDhHCGt?=
 =?us-ascii?Q?ficW3jQkgwEE//SnOxL5t1SPEhxJ9qmXcjwH6Zr5D0mAb38V9fsXuGpBTJ4Y?=
 =?us-ascii?Q?POm83uBr8KRYFR/EvV33pOOaKK2VzccJQmOrQNe/nmIpHiWoueBoTlNIjAc6?=
 =?us-ascii?Q?ORRZ9MCfcQvNqvkoM7eDSkfKq6pQH9LJPwmveKiyGRFuEZy19E97fFK0Hj/u?=
 =?us-ascii?Q?fjbrSEDse1inNdceu5QrRwKS15lgaCvdmiZ9/gS4Cp0jXoP9Kop9XSRIu2Cg?=
 =?us-ascii?Q?aOxG10uan/+kSG+HM33FlW56Y4BOiaEFnZisc20aFvwuD7zhT0R9FqLo8HDs?=
 =?us-ascii?Q?NmLp71//8GmEz2BjFykUemotPKwj+dLma8HU+CsxBZrI8uQITbvI9qW7THq2?=
 =?us-ascii?Q?2Sr36KyQ+iClqBn87fRilvO0JOJerSdLBx9GjIGdvYANyWSSiLo79Qr+5rnj?=
 =?us-ascii?Q?EQ6K1IqfCQ0GtIjfS8V8Pz5De3TPsBYM9qX9Lx/Po97nOAq1Kc9sNacO0Npz?=
 =?us-ascii?Q?Cjpnh4tRrbezddICynXvo9hDdN2rq1yuAZFJKaRVyS4qdLipP5fEk8/A5ZBm?=
 =?us-ascii?Q?cDhHkMNADMlanp44+JDUwFTqnzRwNy9Y8OiP0HQCGcL521nsj9sx2cOLnrt3?=
 =?us-ascii?Q?eGcLnMBNf0qlwjIMbal67jaWwAEumyaVxrHZneqhSIfJIxuu9Hkfz6oAb70o?=
 =?us-ascii?Q?bBwPc/s+93vLfsrIrRmFOuLiU99zIG9Li6IvvBTVOSEvWzSQ6ecdf8wtFmEu?=
 =?us-ascii?Q?mrzt+7N1dBUITeLWFu9Qa1jsSiL4ZLsp4+1BA58RjSfxoZJ+z+OqNbnEhcXH?=
 =?us-ascii?Q?gSybrLYA7ZP16ra6Nmw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/hZ+o5IK7xdKqKgeQPq9zb45z8aPy7SMNcXkF5R4X+tZvEJsFh/j++njRM8P?=
 =?us-ascii?Q?2qNadwDhV7NzFZ7fSwj4D9p2GUSKwGZnJe9jdUjW1ve0uHjduvkLUKDsApw8?=
 =?us-ascii?Q?05wCRgagqLaNN5Ec8mi+I2sHzTMhZ6tqzt+7yvBAhri0VcVaoagHyBJopcvm?=
 =?us-ascii?Q?ZgOnP1XMfylywJMnhdf6j9rVWtF4jPdryreUtrxaoTg5MKN1sJzlxatyIJav?=
 =?us-ascii?Q?jyq9LX8hOJykYKmZrppajOBGbWRtYjdQuYUHN4y5653qa+monjuom8npf/xR?=
 =?us-ascii?Q?9G5StZVPjmxsmUoARwknAmZMnwtzNWkj9VEcKPSneT11zuDxC+uDUGyNVR0w?=
 =?us-ascii?Q?HyfieTEDB05rn5v/BLq6UNdTc0sNDviba8BeWETz1ZhQp27ArNWdrTzmGQVl?=
 =?us-ascii?Q?43d35T6WtldI4qUfJx/UtTQo/KU/GZCqkYxPdpnFjwhtAmDeJ9p90c4kKt1r?=
 =?us-ascii?Q?mBiGQdH0GjwEfOWhIuGCIbIeeiEkmpZC16pEBp3f8fAoRtTF5uFzQTsI81PO?=
 =?us-ascii?Q?x4mwcZ3wOnMUnRKlry8TbVljgjuFsHu+byeHYbArha8w9vwOJEwjTUmOQxCt?=
 =?us-ascii?Q?LgbX2FqaesvbZnt5wyfXACiIsL6oDZlSRuJzV6LYehv9T05vC8ZHKTCo+9zM?=
 =?us-ascii?Q?hG51RHdV5ueU50rn6g82OywdObnzs9KsoZRTf+u42Opoj3uC7LWIm6Y+RBw4?=
 =?us-ascii?Q?OiC+ejA7JBcdzotf97Lvwh6NGqn286+rvEsYrm8Lp/YwpqNlm+XdRYmGxhM5?=
 =?us-ascii?Q?lOfqsN244b/BMPtMbde5dFlr3xTON1Y3g98pwkFEZhp9EKdhosZ+fWaesbAl?=
 =?us-ascii?Q?dUS2uWm8VhNCIlabwt87FVPjJhOQB1u6Dh+zpmPYxLhl67SL75StJJo0zHFn?=
 =?us-ascii?Q?fTe1ITrlgEM5P0dthiOFHKq0LAaW1y4OXMAWpzaCYFYmkQXEqJ2eUYK6nqY7?=
 =?us-ascii?Q?wFKmtv7PDhhlVZf2EDnBvsaU7sbVbB5O0E+VWO9Bl1BUV5eow+O1r7vYhFdb?=
 =?us-ascii?Q?SeAry95gU6d1XwRKt9bKJDyLw9/vZQxgyZ/f4UmYJpOARYvs4I3vFFXybKEP?=
 =?us-ascii?Q?/rfKRwnYivrM87FmT8RFIeUWW2HoK63/+S703WKf+5i8yvnjvLiRoslYk2jq?=
 =?us-ascii?Q?8GSPYdj8b7Q6TSSA1xPAevD22ZE3mdaxXtVrzdBBmlJAGweDzxdEgrASgKtA?=
 =?us-ascii?Q?AhQLeiEEXOlrDHwv9Q0NXgLuIvS0jNLPPvOHySoGOWMfNNf4NP8tzlvRPWnE?=
 =?us-ascii?Q?aM8FBxltUDJzuVBTFS2gnI1rD5PD2VgxJTcr81lrnRbrXQhUduEymuWgNX/7?=
 =?us-ascii?Q?S2JY84hHLW4PDTHQrvVkFGm3YOT0ZzchVA6boU+LFs5nDURIKYfdnHwKz5qA?=
 =?us-ascii?Q?26RBoduCXfnCIJ/+JPi22z+laOdyBV4Ft7JcypCJCijPv7K9F0epNZC8XpVB?=
 =?us-ascii?Q?fywe/N5hrrn7guktYayREAevIXexc+zSIb+xP0Ll+L3rR6e+aIatVxTxdeHr?=
 =?us-ascii?Q?Aj4oOr8PbXaF4qkaTc23ZXvOhhrR3zmJ0U2W2EzJ4qTatUDIJGQ/11cJWLo0?=
 =?us-ascii?Q?vBGjfLx3MrsXgu0+B8sVioMM5jnwk3Gk6r9AZJ3k9uztqNNcl8REkQYwIuDH?=
 =?us-ascii?Q?bYBzMR9svvenSKrWZWOkiFqS+6ktW1fjmvAc3tpR61LpJIo9Zf4N6XiijUq0?=
 =?us-ascii?Q?7jN4e2jqahPVKtzd9ZfV4Cs9UgQrAhuT/UjVBQqNyJtgbWB0ZQtm8KXyYQBl?=
 =?us-ascii?Q?z0XxykhZzO7RDP+qMDn7AiCMs8izzpE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb89926-8cc9-45d1-7340-08de5d44c139
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 01:38:21.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRRJSmznD0OFER1bY8w7M3HwtGZ1htMKBLxrlWZ3BEGqbqa0tRFo0Pu3DTwwxNAfEATnmm7wbjHjyiHcIJMQUuDtd5lg3Da0HnUfp3PKZ/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9424
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-75563-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,aschofie-mobl2.lan:mid,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 408C78EC50
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:55:42AM +0000, Smita Koralahalli wrote:
> The current probe time ownership check for Soft Reserved memory based
> solely on CXL window intersection is insufficient. dax_hmem probing is not
> always guaranteed to run after CXL enumeration and region assembly, which
> can lead to incorrect ownership decisions before the CXL stack has
> finished publishing windows and assembling committed regions.
> 
> Introduce deferred ownership handling for Soft Reserved ranges that
> intersect CXL windows at probe time by scheduling deferred work from
> dax_hmem and waiting for the CXL stack to complete enumeration and region
> assembly before deciding ownership.
> 
> Evaluate ownership of Soft Reserved ranges based on CXL region
> containment.
> 
>    - If all Soft Reserved ranges are fully contained within committed CXL
>      regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>      dax_cxl to bind.
> 
>    - If any Soft Reserved range is not fully claimed by committed CXL
>      region, tear down all CXL regions and REGISTER the Soft Reserved
>      ranges with dax_hmem instead.

Question about the teardown below..


> 
> While ownership resolution is pending, gate dax_cxl probing to avoid
> binding prematurely.
> 
> This enforces a strict ownership. Either CXL fully claims the Soft
> Reserved ranges or it relinquishes it entirely.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/region.c | 25 ++++++++++++
>  drivers/cxl/cxl.h         |  2 +
>  drivers/dax/cxl.c         |  9 +++++
>  drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9827a6dd3187..6c22a2d4abbb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_region_debugfs_poison_clear, "%llx\n");
>  
> +static int cxl_region_teardown_cb(struct device *dev, void *data)
> +{
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region *cxlr;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr = to_cxl_region(dev);
> +
> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +
> +	return 0;
> +}
> +
> +void cxl_region_teardown_all(void)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
> +}
> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
> +
>  static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>  {
>  	struct resource *res = data;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b0ff6b65ea0b..1864d35d5f69 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>  bool cxl_region_contains_soft_reserve(const struct resource *res);
> +void cxl_region_teardown_all(void);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
>  {
> @@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
>  {
>  	return false;
>  }
> +static inline void cxl_region_teardown_all(void) { }
>  #endif
>  
>  void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 13cd94d32ff7..b7e90d6dd888 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>  	struct dax_region *dax_region;
>  	struct dev_dax_data data;
>  
> +	switch (dax_cxl_mode) {
> +	case DAX_CXL_MODE_DEFER:
> +		return -EPROBE_DEFER;
> +	case DAX_CXL_MODE_REGISTER:
> +		return -ENODEV;
> +	case DAX_CXL_MODE_DROP:
> +		break;
> +	}
> +
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>  
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 1e3424358490..bcb57d8678d7 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -3,6 +3,7 @@
>  #include <linux/memregion.h>
>  #include <linux/module.h>
>  #include <linux/dax.h>
> +#include "../../cxl/cxl.h"
>  #include "../bus.h"
>  
>  static bool region_idle;
> @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
>  	platform_device_unregister(pdev);
>  }
>  
> +struct dax_defer_work {
> +	struct platform_device *pdev;
> +	struct work_struct work;
> +};
> +
>  static int hmem_register_device(struct device *host, int target_nid,
>  				const struct resource *res)
>  {
> +	struct dax_defer_work *work = dev_get_drvdata(host);
>  	struct platform_device *pdev;
>  	struct memregion_info info;
>  	long id;
> @@ -69,8 +76,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>  			      IORES_DESC_CXL) != REGION_DISJOINT) {
> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
> -		return 0;
> +		switch (dax_cxl_mode) {
> +		case DAX_CXL_MODE_DEFER:
> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
> +			schedule_work(&work->work);
> +			return 0;
> +		case DAX_CXL_MODE_REGISTER:
> +			dev_dbg(host, "registering CXL range: %pr\n", res);
> +			break;
> +		case DAX_CXL_MODE_DROP:
> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
> +			return 0;
> +		}
>  	}
>  
>  	rc = region_intersects_soft_reserve(res->start, resource_size(res));
> @@ -123,8 +140,67 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	return rc;
>  }
>  
> +static int cxl_contains_soft_reserve(struct device *host, int target_nid,
> +				     const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +		if (!cxl_region_contains_soft_reserve(res))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void process_defer_work(struct work_struct *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +	struct platform_device *pdev = work->pdev;
> +	int rc;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();
> +
> +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
> +
> +	if (!rc) {
> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
> +		rc = bus_rescan_devices(&cxl_bus_type);
> +		if (rc)
> +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
> +	} else {
> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> +		cxl_region_teardown_all();

The region teardown appears as a one-shot sweep of existing regions
without considering regions not yet assembled. After this point will
a newly arriving region, be racing with HMEM again to create a DAX
region?


> +	}
> +
> +	walk_hmem_resources(&pdev->dev, hmem_register_device);
> +}
> +
> +static void kill_defer_work(void *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +
> +	cancel_work_sync(&work->work);
> +	kfree(work);
> +}
> +
>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>  {
> +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
> +	int rc;
> +
> +	if (!work)
> +		return -ENOMEM;
> +
> +	work->pdev = pdev;
> +	INIT_WORK(&work->work, process_defer_work);
> +
> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
> +	if (rc)
> +		return rc;
> +
> +	platform_set_drvdata(pdev, work);
> +
>  	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>  }
>  
> @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>  MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Intel Corporation");
> +MODULE_IMPORT_NS("CXL");
> -- 
> 2.17.1
> 

