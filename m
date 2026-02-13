Return-Path: <linux-fsdevel+bounces-77182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C+PE6iVj2nqRgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:20:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E138613999D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A47FA304BCFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0F11C5D72;
	Fri, 13 Feb 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G82K6Cvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E93EBF3F;
	Fri, 13 Feb 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017628; cv=fail; b=jtjb0SrXRtf2VPk7QNr3LDcJydav9OPT1lyoY1OObr+XV7qkw8zsO7PvnrC90ppJap/R71CMsyQZF58V6smFwwVBchJJPO1rzGoHrLHNqInANotmr6FUHKDsF+jOm1f4kwKt/fx1cMA63Z2DxvEIhLlPwHIK0QaW/soKoERUoBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017628; c=relaxed/simple;
	bh=IxWPQ5FOLCdeYzixk0qbplD4io4By9Kiia8UUb/wOnE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OvarKnCleNjvqOSi7lUAsm0z+TT1fi5N5wxxxDY7wdzshkRmLqgGnjDpmv/6ObLEs4PqSQl1vdQGpL+OkNwo68KtjNFPiuoS6qNHAgpLNhnFkAmLvwxlxQjYcH6f5jUPDPq+1v766Z9XfIR/zdVzAVfCm+LhiXvhxkcl1EZ5uak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G82K6Cvj; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771017628; x=1802553628;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IxWPQ5FOLCdeYzixk0qbplD4io4By9Kiia8UUb/wOnE=;
  b=G82K6Cvje6ApAkzy0zfoe3bm1gzYUDFHGywyDAcBaLtHKj7OJP2sWEZT
   D60cuA8Pn8KJpjYMQUd4ecEKKMxlLREzgUmPe2bqf/IBYF5eAkL2DF3ll
   Gh5kgnq12ecTb3BMhzidTeFi9Lel2IXHBBJlltkaUtBpxVQiOAoQW7YzA
   vQqaUGm7Ge+yWRhFkmBaKBp5sBcAeEp9olJ6LtXDhY+GPSMAdHz6dH+J4
   /BBTl9Zs+ZC72vsjKlmELnddBsv9R6z5MX3qnY20on8mtnmCLEHXTMWry
   5UAMDuq9iFcjyRVS+CIKJHZvoXenL2O3DFComyQYc/GWFPGfTHTyEM+GH
   A==;
X-CSE-ConnectionGUID: 7I56EazLQQKHoKiuB4JN1A==
X-CSE-MsgGUID: Tp8DjwEgTQ+scrXyeziasA==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="94841011"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="94841011"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:20:27 -0800
X-CSE-ConnectionGUID: BwV75+GMRRmM8bKu52T8pw==
X-CSE-MsgGUID: F9PxtksXRR6r/u0/r3OWtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="217154722"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:20:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 13:20:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 13:20:25 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 13:20:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPmimVW56HRNzXZFcPdNPzYjFlkqmZDkCRT5FhZriACvF+Tax1alGx0/PrChzKJra7/WpQKjsBXjoKnDy+fC5G6FZXzFprSbll5IMOowXoUk3WGWWnBMVcptRrs4tSJU90LMPyhp/xMlZrP+CkGzofvsk0NTCJfZqAGBSDDJSkmgSSN0pFS8wR5NLpQ7d4mWKeywRuDIU1MzU+ysACjNbatRZ74ZZbEMQXC8kfJd4ngCdcvih6rtqxu72D2SkVSb8u+73Po3LWnV4ethFFLVG1Op+soqjq1DZtYCZ8nj4/tN3DRQlJR7MSNxGnpq4mAoeN2GdP1i+KnAqPffFPM+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IWPN46AIH8/VSSmbHzvBuB2Qd1R7CMR8EikN+Lvdy8=;
 b=b51UGnRd1ImHqajmfpAfUj/U2UZljRdsH49b43NqL5qjkzr10qBInl58SC+F1CJP84HCOtY7796sGZOhkfEgGIGJhg1rbuOXZD8gHyx+hzyBBYpLsmX971cG02pIgKkmJKnEqI4iN89xuqDg0VZnuyogiQFr1txGm7MU66g0upT2Y10dbPIE5KCuS8toAy+55teFtyhLOpysS8m+04zWEiTJII9cqPftHdDaIIwdTVIdqkmrn/bS4YRPlzIjY2770iGxWThYP7EVpeDWG8hM7Iag9UtS9E7/oFgsnMiKawVwYfXclo/qDRc66LsgOQjKtrfzhemz0C+h4874UBbcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ2PR11MB8514.namprd11.prod.outlook.com
 (2603:10b6:a03:56b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 21:20:21 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2%2]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 21:20:20 +0000
Date: Fri, 13 Feb 2026 15:23:44 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, "Miklos
 Szeredi" <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, "Bernd
 Schubert" <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>
CC: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, "Jan
 Kara" <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi
	<shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef Bacik
	<josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, James Morse
	<james.morse@arm.com>, Fuad Tabba <tabba@google.com>, Sean Christopherson
	<seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Ackerley Tng
	<ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, Aravind Ramesh
	<arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, John Groves
	<john@groves.net>
Subject: Re: [PATCH V7 04/19] dax: Save the kva from memremap
Message-ID: <698f9660b2e0f_bcb8910088@iweiny-mobl.notmuch>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223138.92368-1-john@jagalactic.com>
 <0100019bd33c54b5-81c8e4b0-2692-47bb-b555-2657a7f297ba-000000@email.amazonses.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0100019bd33c54b5-81c8e4b0-2692-47bb-b555-2657a7f297ba-000000@email.amazonses.com>
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ2PR11MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df7cc64-20f6-4c3e-d683-08de6b45b16f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sq4+mBevH3++Kh3oTXIN0ghVmay52owfetgH7jnFYn5JLtbOlIAkzqD7JTHq?=
 =?us-ascii?Q?fiQ5qlg7I1zUfUgfyDBbugjIFuA/+a4fVUu9m3vZRmH4LVHyyhIIycv8wuwy?=
 =?us-ascii?Q?lMWXDLkLLFCEgF1Mc1W+u2D49FyuGL4tfNbJMlVeW8x4dsnnVgeYLkEihYhO?=
 =?us-ascii?Q?EmH0Yy3SiZhHAy69vlEX5b/EaxWxHytC6pVSseU1MJhic7x+F3fmCzIZUv9d?=
 =?us-ascii?Q?TU1hftwDPryycxaGyxAYMazG5mtqduhLrmkRnqsjnKg0DbBhP3aa15kK1aZG?=
 =?us-ascii?Q?mCtEQMHwW550lm6aQRu0vZR1ai0Iua2JxW9a+bVs8A1RJ9HRqKe6Euuxr0XQ?=
 =?us-ascii?Q?XbTLx34m3u1nLYKhAbF2hSxGec6RqaOAKWOPG0Q+N4Rc5ThtqQQlK+OycyfA?=
 =?us-ascii?Q?G2F5ITxD66RXM/y/XKyipxC/FescF0ixh4TtQJt4k9x5ZmXqJNH+QPsVxMj8?=
 =?us-ascii?Q?WgTzLMBRI9FlWx94huyLn2YdQ8GzJFYI9iXTLuV+SL3oYZj5UAvXGQIrMkuC?=
 =?us-ascii?Q?6U9G23W8Kqp5zzuwRUHqmOpZHpVb1s5Mn/EFFZdL5uMmoksIXBJzAeHLsCyW?=
 =?us-ascii?Q?w4ThWZWQVgH3A3K9qfCXu0hMPgTekV1jEdUaSSnnfpU1/KkbLvczmHLuOhrU?=
 =?us-ascii?Q?EW7XxRUnJl/4v08sRhM4jaV/QvDDsqItfXcbV7ykPqYSS7b1df8GpZmuCqsY?=
 =?us-ascii?Q?mE90lq62fz9mwjE3Xc4U9KdzMDSf0Vdi/D7MPFOw5nbT8a8UI72zn2n2sJwP?=
 =?us-ascii?Q?2VtlCzW310o678hiyaj/+G29/nkGA0+5ClHMB4VCD7bhjjheGEi4aYQpjfB0?=
 =?us-ascii?Q?CGyzdNXInsjy6/Ty4IF1FJBMAaIqa3twxHy4fymwv7xUpiI0/edLJgRh/oug?=
 =?us-ascii?Q?3xGV7IiBmWNUfpgwo0jw4J+ySUD3iCHXLU1tpJIoPkW/V7cZQHPZiFLGgHt4?=
 =?us-ascii?Q?H5DfSiJxp1egR014o+1VjhisjjAKXVdklvt24GgO7ke1T/MDPwHspWAG2ohH?=
 =?us-ascii?Q?5VxmywxfTTxE2y19Vw0clfosn6yFgBsid9jNvuJPYU96ifAsEy2tlrJwXuo5?=
 =?us-ascii?Q?owfRaMM9cwhOQDq6ZD3RgAOUnb86Lk4A+vTh4ewR4rs8HaEgqTC59GabFxhP?=
 =?us-ascii?Q?5a3rTkIIrdxQmvLLuw+TojotF20vYdhwtg/b4nIxKhwbOrTS9FElZPJCLFbx?=
 =?us-ascii?Q?PqTm5vIKvnTcnJM6xlEOhCciIAZD5UouUnN7j0wvHOt+AbCCv5x8HUu4K8DQ?=
 =?us-ascii?Q?+gUGHf6j57UIGrxbHrdtN1JUe/9l4+bUuApS9qFR2fudhdr2K9AxrRVOeqIs?=
 =?us-ascii?Q?N6RnR2u1EDGElUfPdgO8C7rIB4JS19e6mG8pazpy1FV01TUiNp3XcBkQQYIF?=
 =?us-ascii?Q?jSOZODgZigSkUm4BhWgEECGv+oXlyQJfp9hXxf9tlxWSbqyWRhxMZoUb2JXD?=
 =?us-ascii?Q?YMsowagbHhPJOETp+sIbjWAC1oL3GW3DIclzw2jTNPWK1W76aYmmBITThzyf?=
 =?us-ascii?Q?7fomlvQw8u37DuzmahDrn7/0a96xI+ThsdVlERK9N3lUOy9wuMYYxksIMFDj?=
 =?us-ascii?Q?0IpuzXOwPxrQ3yGWwco=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rkbriVy2+V7it+rvr4qFZzOHoBShU6vFTYEowmHbyN9YQO9FANkvKs1LPN/j?=
 =?us-ascii?Q?pTz7i1tgBzXRa4MY+lnaXsMMfCCagCElRhcdmyDQ2Dob1U+Gp7ZsQCPaSiHo?=
 =?us-ascii?Q?+bs7Vkjv5WoH2IJzR3OllVl9mUns4chB+ezJNBNiNGb1QImTdEglR2q4jpvg?=
 =?us-ascii?Q?XmNpb4rIhhrLJchaGH6V8IaJCftymWgR5gkVvZFK7e1dsyzIUe6Rh3joPts0?=
 =?us-ascii?Q?uXT1yUZ8dmYmiLdcVIJKgIiwenBqteLxi6QP7J2U7cnk4tec/tJ3U/aoyXlF?=
 =?us-ascii?Q?giPOnnKeoqafEuSQjIgM2D48vmmcWGZUQZmlJoGHSBUJ8aTWSc6pbzTqbvGa?=
 =?us-ascii?Q?bx0Fyo2oAh6hUIAQYPSKcfCG2N+4oExVlB8WT6f7ByvkvzLvlB9oqpqBU49F?=
 =?us-ascii?Q?oylucioDRlE9xbKuI53+upCrhxKYklaMXuUYjEAZwIcf/m2Cn24udAIf2MV8?=
 =?us-ascii?Q?cLXkpLcjmkBVN7RpGc8WDCuFxldsAq+62Mx/fMBto5qFFyfuSIyhopxtdJjD?=
 =?us-ascii?Q?k0/SxvQZ0FjTHGwNb90W7TS0l3tU3O8OYnffV3ZHLhfSJ4jrqcHskCaM2V7n?=
 =?us-ascii?Q?YLfV3mfGaOxBuMYsCpLQiZcwmoEPrDdrF9YXiraQSN+RW/73vTd1J+WLm7iq?=
 =?us-ascii?Q?hB9yLovHALEcBO2mn/ugtZSVuZ8DoMGMeQLPvMWJ37D7XllumBr/VBhOb1vi?=
 =?us-ascii?Q?HgxdNL3r8ispmBapFAPxI5GWOj6ujmOZtdduQ53LuNqSKRY3mglVSsR25WjK?=
 =?us-ascii?Q?yzMiVs+Ay1n15oS6DRVr0JOrR9cyijcrac6UFLttbQpXDgCWpdzl3ieRNzlc?=
 =?us-ascii?Q?Ivo9Otld/p4zu1rMyhaz02CRyN9OvE06AI9U8ea9wrFAIQrpjED46cwgLaaH?=
 =?us-ascii?Q?eLK7JTaedxQpHn53q/iH7XVK0xq9VTA8ncZa88Ei6c73M2k03OnrCEh6KAwk?=
 =?us-ascii?Q?Z9nqcUFqAg+42KO0ZT4hetsKoo/LbAMRHbB6cYVYwpH3ZkYOeO3S3MO1mizm?=
 =?us-ascii?Q?25rh/MDYkniGG0I2uC4zx8JwP9wbQXXCKj52ltSBlhzXcHMsWNBJUvyYuo4F?=
 =?us-ascii?Q?1z1NxPryiK7vE0w8aLCjJPNToPGSEHku1XZB4SYKECFEdOHr4Qrsjh+2A8CA?=
 =?us-ascii?Q?izYEplD98Eta2FMfxaCWOgt6MDF9gyTwteNW/67dHRn7jsOhcI0v4H/v8XpG?=
 =?us-ascii?Q?+WKQ8qHoE4KCIosJ1rbZcF3I+NeIQCpU9ZMUGyHCWeNskivAXKaPZgE8OR2Y?=
 =?us-ascii?Q?zUYucjDnWqNr+SjGjHAEhCpkntH2p5usHRpWIXStlbAP30ceeWEky9k2iVof?=
 =?us-ascii?Q?rrXNj9jTIxU6PBHvGLEdfR0d61kgAyhnhcxEh3PLemwh2S9xOY8fXbPebNPy?=
 =?us-ascii?Q?Fl/zGt4zq8Hlx5IwwV6FNDgQ1i67SRxpJ8wx7zBM3LdlkPuL+9xur6HpffWQ?=
 =?us-ascii?Q?ijoU/hO7xK3fRP2H4IFfw8zvafVWNfdOUV/OvnifQrUrXoNaw2/rMFTB2EIV?=
 =?us-ascii?Q?1Gw8GQ/2npawpYjDq0J0j8X1byvmL6EczcNTFTnDYdcDyP0DBcPFwn6x6WBb?=
 =?us-ascii?Q?FaLi90RAkfEZd1i6KA+R+TxroWUNj2zgLFXDn2qTIR3PXS5gdfYKFqk9HFz6?=
 =?us-ascii?Q?TjC61Q7RmqUNbMFGdKvD2z4CFAdYqYi2BPW7aKExn7Y/sstqePkIDy8BJdha?=
 =?us-ascii?Q?9oEg1S8wkTMbFiZV3niH5IaYtdhHqooMa2dtesNDDQgA+g/HnjBA2Z5eWwHI?=
 =?us-ascii?Q?5QugOH/7jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df7cc64-20f6-4c3e-d683-08de6b45b16f
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 21:20:20.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOoyVnRXXUlWQA8A8EkQSxtHrf09Z+hYr+1lmQcHlBM3rPamyrJIc+mZWtOe7cLgafqmuqBdphzm35fUWZ2/PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77182-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev,groves.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iweiny-mobl.notmuch:mid,groves.net:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ira.weiny@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E138613999D
X-Rspamd-Action: no action

John Groves wrote:
> From: John Groves <john@groves.net>
> 
> Save the kva from memremap because we need it for iomap rw support.
> 
> Prior to famfs, there were no iomap users of /dev/dax - so the virtual
> address from memremap was not needed.
> 
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

