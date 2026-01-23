Return-Path: <linux-fsdevel+bounces-75218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGgiISYXc2mwsAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:37:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0671106
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9964E302413B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F8335559;
	Fri, 23 Jan 2026 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FE3qAl5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B412F6928;
	Fri, 23 Jan 2026 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150171; cv=fail; b=NSya9jmlVy6x8z7oZWQMt4pQMh6hidhle+1LR/glg4QgWtnvxObxNc6BqM57JnLXsWu05v5hugFeDCXcsVOgsCIZ+G/IJJdDJKFjmeFe3JBTwhEL5cGNQOGsh9fObiAOtB0bFPxO4fXcluz3J/aukS+Qlv8rxXcNfph7sOL9QtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150171; c=relaxed/simple;
	bh=zOPD4LLPyrmsh7ghtPOQBFZG12K41pw9pZnNUzaBqrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iiZG16yqXJK1nySQDfoZokGR+crsSpI+arkfuzY5TRu3Vr6EJrYuz8YIXseKb79k9UmKDIzsHWFE1oNqaU4iQfUyiMcDodqwZ0lTz+tcTN9ve3chFu1/KleP65ZEp2XP6NEA6QH7he2EQriRtp/rqwSop+kvzaejq8y5Ek9xvCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FE3qAl5i; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769150168; x=1800686168;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zOPD4LLPyrmsh7ghtPOQBFZG12K41pw9pZnNUzaBqrg=;
  b=FE3qAl5iDF0MAIbqQ7/is1KdZ3LfmJXon7EII8PlvD4sVldkw4nlfz3B
   Q9071qAh01Xq9Et+mzU4WPTL5VDhNVa19bCTshBx6HBlMGX6iSYRCuJFh
   NVdeNT8RBHvmz3Y9j9FO1PZDN35LlqqOQfK01FDqg9Cp6PiUj5qKsmf/r
   5OMtkiGzfs6N0HTb0ap6Mk8Aar80bMfbowhKqPfMEkvgREcuGqyAMyHcB
   h1eQYjXXZJ0m+k6NXtoSzE7QXnCatZgClFEq/QJgRjcQ6fngoX22G3s+r
   1dllRvKak4b8jqmy54Ujk7TjJkFGg48/LuR+fzbHsnrWUywpemRNr8GM/
   w==;
X-CSE-ConnectionGUID: KmjMMFboRGWcXP0XhGB/Fg==
X-CSE-MsgGUID: ZDLi0SuVSfqzwspo4YEAbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81029410"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="81029410"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 22:36:07 -0800
X-CSE-ConnectionGUID: Y+KKzVQKQl6Gd7aqMIm5Aw==
X-CSE-MsgGUID: GEpegaP4TXGdzb2gSn+loA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="244561536"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 22:36:07 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 22:36:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 22:36:05 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 22:36:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OupWf2ue+UA3ou0ug244XTfBIc6Tilh7cUef+/jmVEJ3pUfF9UuiJBVlV6KHObUxjB+Exb8deatcqJQOhGdiWP3C2UHdXEuRcLcvRR34k1tiItKLSXIeGNUsx3WVRgT6gdTBe+TNgnBFd7a4whXrcwG2b/OiUP6XJRyObzfjipgx5tjBS9fyN5fo/8Q1/EgEnInxBhL2WF50KcgZ8SyhxHWkh3Xt7ucbXYqvJVJRsxYjAgdxioisSveN1tPbcPC6idOz5MjuTACIRdxFQtyX0x1/9HybY/5rf4uOxpV6gB3uMpqCAhFatxQMeaDrHIFDTcGl2WDJlIcqIidSMxYbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vydFYlfLL90hpZkVCy53P6vozb/YF2cYKn7GS5fldGg=;
 b=SZoyuh2l7pdEtuqZaGON++Mt+UebRwqYA9EjJAZvl7+sy4VWhTiWggOceb42YQNGNlTrUdNSQnmh5rr7dcWe+gOys3h/oTzRILQujcdkWf6G8OD37BZSfjMdyzI6dXvqtkraadNV0l3VIQv9Q+0nQfVaG8RakLzEqgurXD9DqlpOTazQPMvu0+nKjho9gCSak1ZBg7sYuOYNLkitVWHLzxBI7OUPB40TwCcJ6TpDCzgRgAoisdHkPxo5Ca4es/yPAyw/B2K9x3UDBzGdrCgoaD+0PcQ3o1vA8DUZFGP8Hw6ypxJ7zzwHDKWLg8qxXQPOhsMwwGI/6IordalqbamdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 06:36:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 06:36:03 +0000
Date: Thu, 22 Jan 2026 22:35:56 -0800
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
Message-ID: <aXMWzC8zf3bqIHJ0@aschofie-mobl2.lan>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA0PR11MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f331b7-e56b-400a-b250-08de5a49add3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4IU+0bsCNLZaQVWYL2I0hGFSyufbpNZ8DI/w1U4votk+XZx1Bf+tzHPVkiUV?=
 =?us-ascii?Q?tCPHG0sk8tddl2t9MSdkQRjLB6FM2Dz4afLSBNBTvUntpF92N2ryERmxF5SX?=
 =?us-ascii?Q?r063OJ14b3dl7qzw1GpUaUo+AU0vJHFOOSgR+1Y6AGfaiY1aF6Kr6Ii3BZbh?=
 =?us-ascii?Q?37eymnhUXrB14E7YPG1Ugwf9CRmirmkTHGDTWGjoS2VowD6hDxcfUIJg/OM6?=
 =?us-ascii?Q?XXE7CAMPGOT81lB4tZs6LiRCwc3ITYUz3A1rlLsijgrzTtodpPdX/f3eQzE6?=
 =?us-ascii?Q?yg4qyCyL0ZtYpSl6Uu9d5Jo0rQMF0P60MSK6JAMEczCCOFzZXRXyHS2xd0HD?=
 =?us-ascii?Q?ZpxO90++7p3YM4aHk+kBNvIRwXKO9aHCl250Tt88pvxb9JzhXN79921FvS4Z?=
 =?us-ascii?Q?VGI2CTKPgFBdF5PxSRIS/ZoVpNmRVgCujdUzYb0y42VUwTgT8jd7+KAIk+84?=
 =?us-ascii?Q?jIFDb8URaEOxBF3PQc6HfFKueyplZl49S5pthVDNnTShkdMwbUdYbfuElj9r?=
 =?us-ascii?Q?+V6ONqYQ1AG3DSW4bDkOAlAXqVgX8rWM64QpqJ6zI3j9nLLgqPWSwTivaNOj?=
 =?us-ascii?Q?eLQFvpV/9pu5SLQLA8XURuvFaIXZN3wbMm2Tztoca91uSd8ayETprxcI9hby?=
 =?us-ascii?Q?/z90UvJNXwUdPLg/1cJZHOK0zNEkyLOVXZKxY2jeSY7TA62mHcZdhOOuPADE?=
 =?us-ascii?Q?zpzb/nR5rquuOPnGwbqEZW/9qw6taRCCjkytcCtzz4I8JWpUxtDCp5rTCFMM?=
 =?us-ascii?Q?gAQmHJWAhRnIP6zVq8GQdj68T/TdDu5YfrU9djMjrefhATMqPcXvDRKXrDTi?=
 =?us-ascii?Q?IF89xptzdB6Y1cBUiANz296M9GqilrUfj8DN0pttfq62ACw5LXYaRWCneB5n?=
 =?us-ascii?Q?ClNGHAKLdPaWPuvQT6fD9AmwcZpIMRTK29okYT2U6zwgfG2EEnP+Y68XP3Ej?=
 =?us-ascii?Q?f7hD2kDwbyFuNrfo3krE86Q642EnTuLi/jRaW1njK8TkrcLeW8ox4UYQiTAF?=
 =?us-ascii?Q?2O5dD2wkqldsyVs5SBWhMNRRUckLgkIEdsAHLEQ/ACF5OKOs815EGHkgFSrA?=
 =?us-ascii?Q?dYB4AlKNONI9QLmZr1JHynbMKACIucpQ7boTyelcLeSVN3KCpU80HrhRzBrx?=
 =?us-ascii?Q?+mPvU3cDwFOjMXZn8Iv8mF0jvSmo2N7/Ym+A3PT4hsoIgl3LKMCECyAidKRq?=
 =?us-ascii?Q?at2/stJlJXylgYjKJmwHcbwIsPF4YocSO34vkNUsY+IaamKR++G7+v2XkQGG?=
 =?us-ascii?Q?cciOBS8JuDPIJ8z1LVruazro0NN8Fylb5d+Mq38ScEpGjg4THXxcX4hDkiu+?=
 =?us-ascii?Q?Z+s8hAN08reis9rzCkiaPqpO7KiQSf60ipzmmt2Uq+2Qiq8Yg+RY1WagkkH1?=
 =?us-ascii?Q?7+pTBbQhVMxdb5IBuFsaYvFNakQFn114Xnkw25az2gPJszhdWvl7KSbWTdHd?=
 =?us-ascii?Q?YSBgpqf5ezOycrubw8LNAQczyiS04ePNcz+u3IdtfFvMYou0jKW4GoCOBij+?=
 =?us-ascii?Q?2rMY2la7gavO3YyKhLw3oAJObzT9HUXYTo8AYF5zJOQbwytHkJmeZo4yQDe8?=
 =?us-ascii?Q?JZHMChi2aSIYKj9Ww/U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDTRfUaSYdb+lKb9v7u6OIMTnqZQGjqaX5SvT0L3i6FE3lPcG0+aN9iFBiuu?=
 =?us-ascii?Q?2zNDJ8H2xzfxFjgtf7i5p/R7GVOEa2Hmpmp9fbySt5YsUlSf/wH6m/uUkRW4?=
 =?us-ascii?Q?hHoDKgTkPepHLo7NcZAApHCPlpzuDLJu3BgBjz3kIVv4/rNr+QBhEHqoJrp/?=
 =?us-ascii?Q?HulPdALAnCVw+pmVg/bAQLepi8jjwTpesf54G4LhkClAJqaM0PKxNgtxHuby?=
 =?us-ascii?Q?kh4sUQynLNXnwMHE9Y3CzKa/Zo5ZhDLC1fd4MGaJth+csfnxWfg4iSi7swpv?=
 =?us-ascii?Q?ez2Y0hnb2waEUBMWel+XSKVMqN3werhVnCMs+ksW/IW1D/3O201axAuXKa/F?=
 =?us-ascii?Q?ap6bg8RYNVYMRKHBJ24Rdy+B9bBUOhwCJ9I00gNdlaTEyVPTiV57p8MRXkuz?=
 =?us-ascii?Q?efTZTZ+z9HSJxPIH0CfeBbIJp1Ic8195vEvDWMZBO24n/Ote/oeqYCylma0X?=
 =?us-ascii?Q?ZjUwnO846B/3ey30upUl8F/GzEvPL3Lo6xLHH9whjE3u6jwCJM/OH8HWbkQZ?=
 =?us-ascii?Q?cRDHqfmFRtBuHKut4eFSTRh/D/R0aeGizNu/OUpjnxPlKn2Drjt47Ltz8H/K?=
 =?us-ascii?Q?EI2eU3PN5HUMsQcyEfTcDYRPeNFugjij0kg10YdrJKjgG8zPSsGmsrmTkUPi?=
 =?us-ascii?Q?Xk0brNtGhIBZCDOELoY8lGVVTR5wCDi77DzQmOsOy8owgZn/ZbfN66bIvCTJ?=
 =?us-ascii?Q?napKZOgHMZfSCm5zcZtPqC9KwqUh7Fa4LZVpDrCp5MGlre6yvgyr9LdYdS0H?=
 =?us-ascii?Q?iPebwtVczUayRyVct7dCJmgr+tv1G/qn75k8f6asP9vec/KgobP++V9RZVty?=
 =?us-ascii?Q?5YcqxZOvZBCJM6Kq+hf7NsQWzYK/6zm3Dy1Kz8SgsHqzxmaZ7x4Q6qxlBU5+?=
 =?us-ascii?Q?/y2yj82le2hfy4Oz4QR90C2gn9xvQmjsYdegBFaK1WPR6jqIN+b2LuvjtM66?=
 =?us-ascii?Q?XS16wBI7qJj+5EVWymbv+H/TBnSth7obVQQgncdEpX85NVEwQesoLkKt8SE2?=
 =?us-ascii?Q?TrHDEwOVxFjfDpQd45Gj395cSRAKhgraeqpP7TXiUJaaIcsTBi+2EKUInrLa?=
 =?us-ascii?Q?QS36QGApSf/iwLpPzk8brYQKqfG7zbd8HeIPqc/MIEJt1qhoSjQaOmJiyE7w?=
 =?us-ascii?Q?Nu2JlnJMt6Bd4AHZGZnURB89/4lEHgSsjVZ+rB88euQQcWu1UOd/ljiAvDf9?=
 =?us-ascii?Q?LnU1+Brv2K9fV2w77DjdhcuZ6B2V/eRsC6rp17O9mo4IaO504FaSrqlaXD2b?=
 =?us-ascii?Q?Wg9hX64LAFG5gZ1NkPrFSm5I4FL91k/wtfbZu7KRMVHMBUXy74Bs64nSpnEB?=
 =?us-ascii?Q?aNECb+2/lo7fNFbdieRHWai/n1A/plr4zYyRrGwF8gjmjgnlCdiUhs568wKj?=
 =?us-ascii?Q?KwaCxFC5T6Ou4zF7t4vGdRDCUGOPSIozPTpaelnRDuDOCtWxTKQxdteqCwZZ?=
 =?us-ascii?Q?k8V2AybTPJkgOZm+YMFmd0f8wnFSA1vdc90be3OyxD4dbxgXs9yb0uhlZ1c8?=
 =?us-ascii?Q?DqkJNIViMLO+qgbLANw3Vsn5h/ZGGdUYXOP+4G+cd0d+I6lC5m8SBZze18Ph?=
 =?us-ascii?Q?T+yuHx9DwViOi5FXKgXWxrc1BlWfol7elLzuzFi2A2tcSIh0/m1Mbf3qaTbR?=
 =?us-ascii?Q?QFGuBi19NGOB3wW53mOXuwfkAzeQDC32c+a9z7XY13A4ry9BweF5u1ED+LE6?=
 =?us-ascii?Q?41wjzh36DBHu3mMqd7FOU64AobZMNEzyw3KYawEoE/iSSwOXgGxm+Fgizjo3?=
 =?us-ascii?Q?Fpxi9PhsLpZ2K5JV8gWXjXRzNrcYc18=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f331b7-e56b-400a-b250-08de5a49add3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 06:36:03.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icBi3BRDZzpX7sctP1LjeLOQJkUE0muWjwf7/FH5tPLGVzCKO3a3oWk+8RZ8/T6PoXIg2n8CewprJSTl5viWxhmq/8MvgT1u2kOw896viR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-75218-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aschofie-mobl2.lan:mid,intel.com:email,intel.com:dkim,amd.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 22B0671106
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
> 
> While ownership resolution is pending, gate dax_cxl probing to avoid
> binding prematurely.

This patch is the point in the set where I begin to fail creating DAX
regions on my non soft-reserved platforms.

Before this patch, at region probe, devm_cxl_add_dax_region(cxlr) succeeded
without delay, but now those calls result in EPROBE DEFER.

That deferral is wanted for platforms with Soft Reserveds, but for
platforms without, those probes will never resume.

IIUC this will impact platforms without SRs, not just my test setup.
In my testing it's visible during both QEMU and cxl-test region creation.

Can we abandon this whole deferral scheme if there is nothing in the
new soft_reserved resource tree?

Or maybe another way to get the dax probes UN-deferred in this case?

-- Alison

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

