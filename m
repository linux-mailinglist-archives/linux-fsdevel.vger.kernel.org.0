Return-Path: <linux-fsdevel+bounces-77179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IYGHW6Rj2lwRgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:02:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D57139881
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5683C3027946
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725120DD51;
	Fri, 13 Feb 2026 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MftTNaxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A827057D;
	Fri, 13 Feb 2026 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771016544; cv=fail; b=jUuAcWkbNvnu1U54Ot3LL7K01n82chJuqcUwhy17z71cp0BqKwuvhPhDWxhd5Gf6UaMWKUxuz1PEL74lfyUucrx3MbnPIABU6VRPClmWTuN/wAC179XvTdR5CLpRfGHwjeCs6mVZiS+3YQ7tZDw1uNzMDLYfZHIQWdJCFS1fkyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771016544; c=relaxed/simple;
	bh=viouRttJfFyoZ/huOWTCmt34UvI/H26i6hMHUTjll5A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gONjgeDSyYspIfqtPihPT3KOA2kw1tWLAJ+0txpIqT5vkGXTT7hWxibAtuS6RfnDhieMhk26JjInaolLzUOdMC4tI2vrdRdOv3jusQgTk6O3BpHFsUuChpJtndhmvwg7ky7iq4WOQfEjtRhFDwUYZ0OfyIZfsncgyyqMqdBwsXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MftTNaxT; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771016542; x=1802552542;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=viouRttJfFyoZ/huOWTCmt34UvI/H26i6hMHUTjll5A=;
  b=MftTNaxTtNQ7XChILd/0b60Za0suxqYopcDhynYV4Vtb1p/NCeVVeS+7
   +0ILDf+hBzn4Iw8qFAzphsu+2BI8cGk2q3Ay2GW973lhcsuyTpbx0TP9W
   uQXEaTY+yl9B4GuUdL3s0/2wGmonPZKmY6itcWpcEhNAQpCRIejxnbOCP
   t09KtlZl6U8HFppnllFQ5qax2GtruhOeEYYW2jASkmH9QzEXz4VBScr0q
   WXAHN6ehGW+++Ix418ssB9ovj3DACW5GhLx1PdbCbwV0cYnyTOMbs43uJ
   p4+3U4ddAargyAX8YGM7VWEqgxKxtWbPYCx5FV1GmY0J4IM63vmuJHktv
   A==;
X-CSE-ConnectionGUID: 6L+K+1aeTdmlc+Vsb8lA7A==
X-CSE-MsgGUID: bH4pFieAQ6WC5qWrdpXnIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72382365"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="72382365"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:02:21 -0800
X-CSE-ConnectionGUID: lB2EWXl7QPSGfMEzK1T8tQ==
X-CSE-MsgGUID: TToWMfI3RyW2Qrg5ubuMMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="211692842"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:02:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 13:02:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 13:02:20 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.45)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 13:02:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2C5NHbIm7llMb7i0VSeNSaYTO/hpwO9Q31vsJ92DReosoTAmEuVbeqmNsSHTVsHdz+6N3MYzBwPfI7M7IvqYemR694uabkBWzehzJpVWew1WJ/d4kMAa0ChPGDM786bhbNLMtYuczymfSt6opx1zOAweFt8CEdu99AgFgtF8FJwaaUIF6QZISSjxmsebpe7znQExwPdLLxWWZ6CzthVfzbo4pRLq3MJEryN/ukHbZT+9qz6EfKYp2tqEiitRTYZkIup0MnVaAJzbKWIPCedzezqCqVfnx5G+dQTcCZCaEicINcR3XgOeE0uC8lINsCOVSssVlGORpxs0beGPDi9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6NBskhrTKHiziuEhyZqlgf5O1HUiXC4ypEtJumrCas=;
 b=q8tmS7DB3v96TMlYZF6J+GVxVfBf2mSMu4Yqsq3f3L/fu3d73SwuBvFNWvWHMhRp3Ynf39qTyD3jyhBbb7aQzjqAd9oPXBhyt1xUqTIwj0eiDKsXrjgFzGHhZAu7uCqLDV/t2ae3smimlAgycjjHFmhiKHh0GrahOjy+i/J4G217Lkt0lJ92hD2PqtRP+AAN1/MpyKBlqp3xQLCjDqPsuitbP5dcJYrc9W4JF/UlSTEPUS/2JUVrX97kAzXkfhYoy78bnWXEQ+YBjhG6bGErBesTH297+nR+oA9FWzByHFKW20tPVWfFBAP9OraFhDF+OPWuUHv/LDneOIUasDpX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA1PR11MB8352.namprd11.prod.outlook.com
 (2603:10b6:806:377::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 21:02:15 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2%2]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 21:02:15 +0000
Date: Fri, 13 Feb 2026 15:05:38 -0600
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
Subject: Re: [PATCH V7 03/19] dax: add fsdev.c driver for fs-dax on character
 dax
Message-ID: <698f922296bd0_bcb8910059@iweiny-mobl.notmuch>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223123.92341-1-john@jagalactic.com>
 <0100019bd33c310f-1b4a8555-bc81-4ec3-b45f-27abc01dff05-000000@email.amazonses.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0100019bd33c310f-1b4a8555-bc81-4ec3-b45f-27abc01dff05-000000@email.amazonses.com>
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA1PR11MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 583197d3-7545-4423-98bf-08de6b432a91
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jO3EWQDlrkbk9QP5LCVjHJj2T1/nSHzz9TOFd3lq8VEB0N7Z7SLq3dseia/V?=
 =?us-ascii?Q?h3ooZH7Dg1U2GeTy6pSLRKyqmOPXwNLUJjwy5SdJo+KKIdDJD8Xq/Kk3F98z?=
 =?us-ascii?Q?GH4aJtQAp57BNhkLiCfWjBmnuiKSC7yCrvZVRgoGVq6ik3ZceUdGi0t8gTxb?=
 =?us-ascii?Q?7U37kmadeFwRS3k2B9qEEgYlQmjMYl2KbgEGA/i13XLZa73fOhBha3y4zSY7?=
 =?us-ascii?Q?0g68ERbr94QVAcLUcLc3NBBECHI7DJMxBRZaTUQOFCWDNnrFSVcz7riCB4PT?=
 =?us-ascii?Q?Qxf4qbUi4w1VZBWO1lsG/7mbdt5TrdCfCRYvLQyyqB8pM1xlcsocNlNal0t0?=
 =?us-ascii?Q?fz3uiu2mmqLpiXWbKqgxDQHQQfYrjTKfi2ogtsKW2RxP5+RZmghGgVTtgKj2?=
 =?us-ascii?Q?IiJcUalNeGktx4nUifTebysgqqrjLGuXUBQWjQuqvrCZlF3GfkVBnTAmX938?=
 =?us-ascii?Q?7pqbWMyn5rzDtNQ9WTiPjLXZ31I5WHhkP3r26bZs5Oo13roSdIgzNicYwrLs?=
 =?us-ascii?Q?FJ8y2D1El0cj/JzlyixoM2Z53gPjxqafKBQbbJ+F74bMaUSwXdeU3KJkjkei?=
 =?us-ascii?Q?5IsReMVSgoKeq8vVoOwcsZTQlWBUxWwzzPQRxd/XLRnGecisRNhMgRPMMa4I?=
 =?us-ascii?Q?B9s6vbk3ghT+LhO9Qfb+wYt7Nf3TIoYbKfkI3EdBWgRfUS/RxqGssYelVuvZ?=
 =?us-ascii?Q?jQAiRcaWkxfagVZ2J9pkwSa24Mnt8y5QVwPEtgFxvwSyMjZLe8lYSdc1MFIS?=
 =?us-ascii?Q?AtIK/pVkaFCbowc3njcUSXUW/RvRU2DO8Bv9YJlTdIme5p3PerJhRIPj0pLo?=
 =?us-ascii?Q?azaG4hqEw0eT+xplnhvD6XBvqcBbgFSU4FEZnpsT7W1LnItiaIerVOJkHD/m?=
 =?us-ascii?Q?1GQACD4rxT2FhqSZmPuK7eYzifZV1gyk/iaOI8jAug568/qvzevio1pHop39?=
 =?us-ascii?Q?T9mJMkAvVt3X+fpyzRJCCwXDTTiUwB+PwSFZyece0KyvUBO4IIIEbcx2GFIk?=
 =?us-ascii?Q?akf0a0EOB5B6WM/hvD/kvgsOL/U5NRDzjkkEZ4KS+C/AGEJxhyM87lNhg01z?=
 =?us-ascii?Q?vb9cihUgli3mdUbJQQR4RV7Mr7Hz90wsQlppgOrILyCGgPbVMNytI/KNDrYG?=
 =?us-ascii?Q?xIAOT6DEnnRF16EQqW4wuo5wUXuN7IzXFksLu62IVt8wx8txAQa2fnNIETnX?=
 =?us-ascii?Q?wajv8VYAsLSddRDaA7kA/ua/w4ewk0QB+43SX/vvVGgJJmyyJ6lvG4MZdfN4?=
 =?us-ascii?Q?xoR5zCn9Dec5KbfEPSddkYK/gxK9iBhtXvcKsa804ASWAvLc1ka9qqu/gRkP?=
 =?us-ascii?Q?aEZZWuGz9YPj+nO7sG8VMURtB38sBroZMT3mcNf8gNvXBGVn7iMoPs8vZQ4P?=
 =?us-ascii?Q?6tMVkWNwEvnEpT0SafRVro6dvObMkHb1EpVDrSb4eJXC9ygIVM3MTGvXuCBU?=
 =?us-ascii?Q?EUxJkEtLBZ7PEoGrbipCbgrtlnpdm2LJTMpTU/tGVlYrh5V55Yaazc1E3//S?=
 =?us-ascii?Q?T0TM13lg0veyBvAwLzAdHewrupZvm4tubo/EIHls10r/Sj04ocfiG1p8xYWx?=
 =?us-ascii?Q?6u/Df58eoQs2E367gmM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EnqfKR9oALDwAdvP5qQjvrOD2jbGOBzBkXt+TgbWJMIsFMvW5hAFQwC6T4f3?=
 =?us-ascii?Q?XrLcfuTWDG/9T3CmOz8EUVb+R77MDCvs4iGwUrIVg0baCNjej402BO9WGF38?=
 =?us-ascii?Q?9CEs0FtAAKJPniOpfEa4mAz6zmYMsnqvFkdoP1yIdEaki/I//1mMO5xtib2b?=
 =?us-ascii?Q?6AnH3zpoMpiYC8lJ4IC464NVzVskuwBSiN2OVm1bMB9B8o+2zbm4MSeC8TYn?=
 =?us-ascii?Q?vWyjwyarxnwl6B1H1hHS/FwMf04pf87skv/1OvYxoFsbFelShWjvPa9Ta9xO?=
 =?us-ascii?Q?oB83z/RZ7u7n/Gy8onn4L0vNof9UMY5VD/6vf0t0KLpeCej7o5epZQgKEZgm?=
 =?us-ascii?Q?EsHOA12e2bN4LFFUJmfNQa4yB1Poer0iOiZGy7tQzjqdL45CNATATxM/K9cA?=
 =?us-ascii?Q?FIg941WJFb9Sj59RUD8BdvQQDsCn52TRwdrWJEPp1sYYg5AwZRJN9AZ7ptWx?=
 =?us-ascii?Q?iADU1qLkTG863T0xvLytWDkjZ7jFPZAiFBKhVEXQHafJZSRk4FQSXVIYE4wA?=
 =?us-ascii?Q?AjHwqOVW8gQVKO8xyBTqfGvMWWjD07Y2K0flKaBSnpK8ppshSGY562LnlQTa?=
 =?us-ascii?Q?vbHbzQZlrYgcVNJsW/6oC1j52ODN5sISAai/wRjZNh9h97Rbt7gvI72R+5J4?=
 =?us-ascii?Q?JuaNHJ3goDh3C8K5GW8K0qmMSk/gNTR1aU8NNsOMm6wCG1D+PwKjIGvb0qI+?=
 =?us-ascii?Q?7GAW32QPSL7Aq1zfrZX/+s0OAqm5aD402ymxwxo+BknP//pDUNZvvM+rVX0/?=
 =?us-ascii?Q?QN46sXVMhW6M5BprpmMrLoNv4AdPrm/G1Udq0w6pTfJvc5tVdGRo44w6QfAh?=
 =?us-ascii?Q?mluvR/KbvMj9JZK8EyYb7pVIZzvDY4K/p8F+SRqLnlKlpRvpnbPpi8iVTT7o?=
 =?us-ascii?Q?y+633LxmUWhZoqI1aSDd+QmuxJyMQh3FgZoQaCgqiFxG0/6Lg901rQtmxQsc?=
 =?us-ascii?Q?+fmOfpbsJ+19HDLCZsKVJK6ZAMYYmxYN1+M1rbsgZIoZAaghHM3rXx9JhIJb?=
 =?us-ascii?Q?pb+f6MmKjdeiUBTHbHHx0jwfdUFrR2JWBo1ckoxAjnwohXRQcGhCai989rxz?=
 =?us-ascii?Q?AdVpQ2+eMy3BRCa9THZ0bcAK2Xc/WIWpic2Ub/FyTPuzcCgvdthn3NEXHThc?=
 =?us-ascii?Q?H04SHMryxTt+qfxsvLta+OUEeamP82DfKDBZ4RfE6UHkZLw0yIizA5HYL4SX?=
 =?us-ascii?Q?jW4dycPqNGD3Zz0LijQAzTIvnfHhPMra9YDMseRXudXaqnIv7fITc+w/87yu?=
 =?us-ascii?Q?tVAc5yvFjYXTd2E5u64gC4dwov8UKGdTu8XYaLFHaszIKrmbCun3xuX4tV3b?=
 =?us-ascii?Q?O+repk4Vbi7efXKUzCUoaS28Ki3uM2ePhpm4PNcpTH1TpaRCnJyDL3D6reQ5?=
 =?us-ascii?Q?/gRk6WnHXs8KHb171RdYjulmPIxNIwZkr5FuPzFqEhWnV4ABVEv/PZLffm5D?=
 =?us-ascii?Q?V0p5MI0pI6/kRnh2UHYG4prvZ4QJ3SN049rVgjfJFBVhTBNF29/qxjndGJvM?=
 =?us-ascii?Q?uUfrzmuYdLN9VORKOvclq7eLRl6CM+Rj+GYVpY0yq9M6gJNxAhYit76PksNf?=
 =?us-ascii?Q?i7bn2dFnDGtr8TjuAjmAd8N1qZmvJ6FFJHNyzhlc5e/z0iSZI7h7Bc5hME7O?=
 =?us-ascii?Q?ZxJqs8q8S5vFb1nYwMtrZJ2EdDziYab2byjh7ckOOD/NJB2NLkk0qK4IiBii?=
 =?us-ascii?Q?GS12SPb/w7HrN8tMmhPqS3WKfGUZ4ezxLN3K/jhZxgLGcsZMp0F2z0RwMhD/?=
 =?us-ascii?Q?CiMMANwnjg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 583197d3-7545-4423-98bf-08de6b432a91
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 21:02:15.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCbmQbd9qEKYUP5kuZiZWHVbqAcIFtPDoGCzMF6aswDZNbI5TfnNOZuExLSOQ5FKYUFsdV7ZZhwH1OsE9GIv7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8352
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77179-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev,groves.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[groves.net:email,gourry.net:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ira.weiny@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B8D57139881
X-Rspamd-Action: no action

John Groves wrote:
> From: John Groves <john@groves.net>
> 
> The new fsdev driver provides pages/folios initialized compatibly with
> fsdax - normal rather than devdax-style refcounting, and starting out
> with order-0 folios.
> 
> When fsdev binds to a daxdev, it is usually (always?) switching from the
> devdax mode (device.c), which pre-initializes compound folios according
> to its alignment. Fsdev uses fsdev_clear_folio_state() to switch the
> folios into a fsdax-compatible state.
> 
> A side effect of this is that raw mmap doesn't (can't?) work on an fsdev
> dax instance. Accordingly, The fsdev driver does not provide raw mmap -
> devices must be put in 'devdax' mode (drivers/dax/device.c) to get raw
> mmap capability.
> 
> In this commit is just the framework, which remaps pages/folios compatibly
> with fsdax.
> 
> Enabling dax changes:
> 
> - bus.h: add DAXDRV_FSDEV_TYPE driver type
> - bus.c: allow DAXDRV_FSDEV_TYPE drivers to bind to daxdevs
> - dax.h: prototype inode_dax(), which fsdev needs
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  MAINTAINERS          |   8 ++
>  drivers/dax/Makefile |   6 ++
>  drivers/dax/bus.c    |   4 +
>  drivers/dax/bus.h    |   1 +
>  drivers/dax/fsdev.c  | 242 +++++++++++++++++++++++++++++++++++++++++++
>  fs/dax.c             |   1 +
>  include/linux/dax.h  |   5 +
>  7 files changed, 267 insertions(+)
>  create mode 100644 drivers/dax/fsdev.c
> 

[snip]

> +
> +static int fsdev_dax_probe(struct dev_dax *dev_dax)
> +{
> +	struct dax_device *dax_dev = dev_dax->dax_dev;
> +	struct device *dev = &dev_dax->dev;
> +	struct dev_pagemap *pgmap;
> +	u64 data_offset = 0;
> +	struct inode *inode;
> +	struct cdev *cdev;
> +	void *addr;
> +	int rc, i;
> +
> +	if (static_dev_dax(dev_dax))  {
> +		if (dev_dax->nr_range > 1) {
> +			dev_warn(dev, "static pgmap / multi-range device conflict\n");
> +			return -EINVAL;
> +		}
> +
> +		pgmap = dev_dax->pgmap;
> +	} else {
> +		size_t pgmap_size;
> +
> +		if (dev_dax->pgmap) {
> +			dev_warn(dev, "dynamic-dax with pre-populated page map\n");
> +			return -EINVAL;
> +		}
> +
> +		pgmap_size = struct_size(pgmap, ranges, dev_dax->nr_range - 1);
> +		pgmap = devm_kzalloc(dev, pgmap_size,  GFP_KERNEL);
> +		if (!pgmap)
> +			return -ENOMEM;
> +
> +		pgmap->nr_range = dev_dax->nr_range;
> +		dev_dax->pgmap = pgmap;
> +
> +		for (i = 0; i < dev_dax->nr_range; i++) {
> +			struct range *range = &dev_dax->ranges[i].range;
> +
> +			pgmap->ranges[i] = *range;
> +		}
> +	}
> +
> +	for (i = 0; i < dev_dax->nr_range; i++) {
> +		struct range *range = &dev_dax->ranges[i].range;
> +
> +		if (!devm_request_mem_region(dev, range->start,
> +					range_len(range), dev_name(dev))) {
> +			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve range\n",
> +				 i, range->start, range->end);
> +			return -EBUSY;
> +		}
> +	}

All of the above code is AFAICT exactly the same as the dev_dax driver.
Isn't there a way to make this common?

The rest of the common code is simple enough.

> +
> +	/*
> +	 * FS-DAX compatible mode: Use MEMORY_DEVICE_FS_DAX type and
> +	 * do NOT set vmemmap_shift. This leaves folios at order-0,
> +	 * allowing fs-dax to dynamically create compound folios as needed
> +	 * (similar to pmem behavior).
> +	 */
> +	pgmap->type = MEMORY_DEVICE_FS_DAX;
> +	pgmap->ops = &fsdev_pagemap_ops;
> +	pgmap->owner = dev_dax;
> +
> +	/*
> +	 * CRITICAL DIFFERENCE from device.c:
> +	 * We do NOT set vmemmap_shift here, even if align > PAGE_SIZE.
> +	 * This ensures folios remain order-0 and are compatible with
> +	 * fs-dax's folio management.
> +	 */
> +
> +	addr = devm_memremap_pages(dev, pgmap);
> +	if (IS_ERR(addr))
> +		return PTR_ERR(addr);
> +
> +	/*
> +	 * Clear any stale compound folio state left over from a previous
> +	 * driver (e.g., device_dax with vmemmap_shift).
> +	 */
> +	fsdev_clear_folio_state(dev_dax);
> +
> +	/* Detect whether the data is at a non-zero offset into the memory */
> +	if (pgmap->range.start != dev_dax->ranges[0].range.start) {
> +		u64 phys = dev_dax->ranges[0].range.start;
> +		u64 pgmap_phys = dev_dax->pgmap[0].range.start;
> +
> +		if (!WARN_ON(pgmap_phys > phys))
> +			data_offset = phys - pgmap_phys;
> +
> +		pr_debug("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx\n",
> +		       __func__, phys, pgmap_phys, data_offset);
> +	}
> +
> +	inode = dax_inode(dax_dev);
> +	cdev = inode->i_cdev;
> +	cdev_init(cdev, &fsdev_fops);
> +	cdev->owner = dev->driver->owner;
> +	cdev_set_parent(cdev, &dev->kobj);
> +	rc = cdev_add(cdev, dev->devt, 1);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_add_action_or_reset(dev, fsdev_cdev_del, cdev);
> +	if (rc)
> +		return rc;
> +
> +	run_dax(dax_dev);
> +	return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
> +}
> +

[snip]

> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 9d624f4d9df6..fe1315135fdd 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -51,6 +51,10 @@ struct dax_holder_operations {
>  
>  #if IS_ENABLED(CONFIG_DAX)
>  struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
> +
> +#if IS_ENABLED(CONFIG_DEV_DAX_FS)
> +struct dax_device *inode_dax(struct inode *inode);
> +#endif

I don't understand why this hunk is added here but then removed in a later
patch?  Why can't this be placed below? ...

>  void *dax_holder(struct dax_device *dax_dev);
>  void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
> @@ -153,6 +157,7 @@ static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
>  #if IS_ENABLED(CONFIG_FS_DAX)
>  int dax_writeback_mapping_range(struct address_space *mapping,
>  		struct dax_device *dax_dev, struct writeback_control *wbc);
> +int dax_folio_reset_order(struct folio *folio);

... Here?

Ira

[snip]

