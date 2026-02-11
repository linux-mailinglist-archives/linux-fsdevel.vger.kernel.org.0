Return-Path: <linux-fsdevel+bounces-76946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FQMKSeQjGlQrAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:20:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB4125261
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DF273007533
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5929BDAB;
	Wed, 11 Feb 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtdXKwqH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1705B1DF748;
	Wed, 11 Feb 2026 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819617; cv=fail; b=ItQhx3QHvMwNL+Fq4UWRaTi9Nvc/XqvWngtY7MtKg+SUyVOi61TFOPg8JbWTBV0IyLT3TIDYtGZ5yQAgA/9kRTCnbSuhyROz3dXDMds2bYGxycYXla42EWHWKLKXIUT5pc28lE8UKS7bGKGgxOtwx8Wurmf7c4uLghCj4kPJlUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819617; c=relaxed/simple;
	bh=LQgTarkPvQjml3SxEgK1tb6oHiKuI7gptC0L/Axwzzs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QnsueNSykdGq3spJjj/R/tbktA5ccOpbALFtZ/zdGSx4Dp/sY3WtSC8Pw1lC1KUrKjO0Ju0WNJBjhtpsSL38RgKPQdvqp8YG01Dd/LMsQau0Y46h1oL8wxaWhL0dqqGwPne4eUSXXcRRpK6h7EVNL4IIXLVaG5zJHCJHwRYO58E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtdXKwqH; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770819615; x=1802355615;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LQgTarkPvQjml3SxEgK1tb6oHiKuI7gptC0L/Axwzzs=;
  b=AtdXKwqHDjp+Vmx4S0LquZRwCr+hmf6S+lLvoUFbypZX9HiT/1bZslQm
   /+T4uTA1OWd49YePPPao8ZvhQc6QRNUUctLXwrBz9Y6lkM3Yf6A4KkD7j
   E0Yk9N1vQzfcxdqNBIAe/UZxfgqyNHX4VBmgtnr/Y/F1PzyOE7O0rDONM
   7Si/d38tj3SkJFvrT+h4Oz8McN0Y8XAXaOnRL92+hxLLZelHFWcKaFKWB
   z/BgbrYF+Z0A0vB6RmUXlJqHSTIyhYUedJgQV4bJt5oPQgaOlME4/o3EG
   1/Jkd0ZDn3tcf2fPoJ+wsbVN2ItHzjwU94kSQSbP878T/h4lsA9/DoG6P
   Q==;
X-CSE-ConnectionGUID: oT5dpAMSTZq9OTQ+I4QJuA==
X-CSE-MsgGUID: JH4xfgpvR1aIQRVCQNJcfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866593"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71866593"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 06:20:14 -0800
X-CSE-ConnectionGUID: C4SAf7NWRv29yQgnzp/AfQ==
X-CSE-MsgGUID: j7JVz5HBSoqCUC538bso6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212364337"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 06:20:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:20:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 06:20:13 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:20:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEdpth6C0jhVOD3zPHsMVtZrE6CHZY00XVZQlkcgAwE2nYgMgMR2Nx03r93/2Fs5Z28qQEON2pl42bVLiK8cMsuu3yhheNKME+GgITTkzkHzqzsHczMHble5GP04S2Qwki1yQTUDTAYYEPTnmQFAt78fjs/X4F6flKd2WIMmO5DfRZKQLbdBC4Kr0/KibZ2YDOK3HQbWGdbiGwdFg1sraf1s9kzWCdB9fVbFAcFpTPSP3IEkgSZbjH8sXbfTR/GtaYyCculZuZCwNkNT2AVHdSNE9z8X/Ct2dSRRWhaRZAIrdsjQx/0NJtwp5kCu0gjjjkv852ZtILIfN2I1ELdr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjvspPbZGUijBSu5PH6sr/oTu/q2Hw3ui1zkGPzDxq4=;
 b=H/ldzg35CKrvxcKheqB81JmHhqpfYvbj65/cA8c2kSEsgRd/wTa/+gvuGFlgHmYtpYG9ty6fwlPYjf7YPhY4oLilgWKKJ0IuUlODJOPE5pGGgNtCdjN1mXLwAQ4Ms5khY2lWpZVtBCnZN3NBTf+TtV2YUFgW2vf1z/tq7HeN5p6kO9uQkYv0/TTd6q2r2DJ99i0hl7CaHQO3hSky83bkDOcx8/FWKeeCugesSK5omM9KOXPW4na+dbJwfOOcLZYfDry3umSGqCfI+rlVPbBbqa9XsmBJbZIyccS0jq0Us2yO/QvAhXJQhfZCDrEhVxlyFx4TXBVZ4nP4wadpZ4dNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DM4PR11MB8226.namprd11.prod.outlook.com
 (2603:10b6:8:182::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 14:20:08 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2%2]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 14:20:06 +0000
Date: Wed, 11 Feb 2026 08:23:28 -0600
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
Subject: Re: [PATCH V7 01/19] dax: move dax_pgoff_to_phys from [drivers/dax/]
 device.c to bus.c
Message-ID: <698c90e02cec2_bcb8910026@iweiny-mobl.notmuch>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223100.92299-1-john@jagalactic.com>
 <0100019bd33bc40a-12130f8b-289d-4a38-ab4b-7dfedf614d34-000000@email.amazonses.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0100019bd33bc40a-12130f8b-289d-4a38-ab4b-7dfedf614d34-000000@email.amazonses.com>
X-ClientProxiedBy: BYAPR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::49) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DM4PR11MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: f7322fd3-c440-42bf-dacd-08de6978a7cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z71uKl46P4UzzsuggDFY2Iug111w5EJa1Evd+BlvapuVkMXuljpY8bsMUlOR?=
 =?us-ascii?Q?QGyMwIGPozJahPDGIJ+n9ETGMNUa61XVrW57f6Tp6U+Do11gGXBT/lNPZXvi?=
 =?us-ascii?Q?RwbmTIqTpv5eP+oiXWV+HMd/Mv30pLdQ8hBfIqC9qymgs/wArQLvWN7KoOjP?=
 =?us-ascii?Q?eQsMJkeUCcsVj3Zw+2wunimGp1TuhFH/VwHbAa1WiVItOo+0duWqXnXOIipx?=
 =?us-ascii?Q?1wSb5miB9ySWmviv42qj507Y9qNHV2hCh/m6PJ0q/xacskDEVBFqMC+hDLKa?=
 =?us-ascii?Q?QvTUVSgOkO4hnXa9U0VdpOKWcilu9rJFtwKoMV6BWa2TdwVswuaWgrNR62yc?=
 =?us-ascii?Q?TNrHdZZSgHBqQkM1Acqzdl4ws+gMKnJsXAz7j51gO44/LGjTG6alZ87aMRNj?=
 =?us-ascii?Q?7e3Yk0e2dJNO+0QS8kyambdRWQhecFHPVN3VsDYaFL/5le+ts8aqYMZO4ZGg?=
 =?us-ascii?Q?pu2ru3zJrPpBRPdCo952sCnFJTjT04lrZu3sgWosJnez/zlok0JJioXUo4At?=
 =?us-ascii?Q?Ax69sTqvqPlGENdgc1v9/xGLUmTkInP/x/Hll1F3gVTI1T43mTnus7GtqBKt?=
 =?us-ascii?Q?LrBVt/ENBykpKkcsJzfoHZgpfDKpf9eJWd5j9lhGnLWfMFdWTsIfaIhPoFQd?=
 =?us-ascii?Q?4Te7koYH6piLwiL0cDCBfUIYvdVbQNmcCk1dfypp85/1pYSGYvLbPTZIL7Yu?=
 =?us-ascii?Q?joOFZzNMpDjKDGGa/Yq5K+EkwMm8EH+xWW0pbsdGiBY3f77xyVa289RNk9Xy?=
 =?us-ascii?Q?4bXIkYcKTLeC55XYnan6DKo/KB8cSSx0HoIf1wNHqkuA9kUjUh5XI+QCZ/Qw?=
 =?us-ascii?Q?yfUWz9sPgVt/SpbxZNRpJ2HKXq046sBe9u7ysHyP1nUu2OC+98AdXAaEPIbJ?=
 =?us-ascii?Q?yX0J5hdwPSWhtzGfaV0NFQ7ofxa0GsTMHeaIbpvTZvg7vMTGUxtpxE9zSHNK?=
 =?us-ascii?Q?+zIiTUHrw/iCyOuJde7oDT8FFnhYHWEjrto8ubWZ/oQwuyvXcaxf5oP4LUbe?=
 =?us-ascii?Q?BGe97H4RtiVJdx08ArG4l6cJHTj2lRN9pI5Z4QFh6/PG7IRJpM6+b1aaNIE2?=
 =?us-ascii?Q?jqGjbliINUjrGKr7MAhnyLZDLu27+poJnFzSG5dtCkOmQb9PlpC/4AYtlMgV?=
 =?us-ascii?Q?2cGBIqRRKKjq9UsNy5Y5i5A6NVrjLrPUr/mx7pUooZvNYMsHx+8u8pHbWsH/?=
 =?us-ascii?Q?ovrdfe71UAQp4YQK6+IFORXg4AivZ6IOiKuKY4DCkwLo6tGi9qm7duRuM5J0?=
 =?us-ascii?Q?5dgFhiKzLdSL10eG8xTOmzwn+z5hEYXyKBa552PKB8sKT3wXV3SxNPI7qp90?=
 =?us-ascii?Q?grqAqJdnBhpGFHMoxXskv/i7Ctf2lUavF10mFmodRuaZ38X2Q8TbiLD0VeD1?=
 =?us-ascii?Q?RDLmIvuDdzDQbimN0bHdXljbuGvl4qNDbxj469tp8z7C+RLOIIB35QsEgpVN?=
 =?us-ascii?Q?T+f/3jbi6mKTtHyVCA1UEHPTwHnYalH5SuK1pgea9VlSdbZkXkWDMkwo5OVJ?=
 =?us-ascii?Q?WVQM3VOtws6ROSGb+fYQwvexXuT+PjYg04ggYiU1JwQENt0+I7w5PNbS60up?=
 =?us-ascii?Q?nlila+yPxwgu/UxzeYU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?18Gbje4njs0AYqN6RPJS6vZUWbq0b6DnwD2lxgA69StRGOUSXUY5Kkxc2rBR?=
 =?us-ascii?Q?6ED48i08WaPYQWrSs3PIgDMaYbFj1Zhf3IDl3we1pAw6c9IoFz6tjPDeEeFZ?=
 =?us-ascii?Q?DJvC7swstztZDQEmmGizCRAi/4hV1p7MH1/mZuM6vgH9xBBQXXvfNkAvYcRC?=
 =?us-ascii?Q?StZqPuuC8P0esEqRdK7ukqtLwbXuBfn0fEzFQprMqsIcE4rXREc1YXrFPKtK?=
 =?us-ascii?Q?T0eOV9w9SHNstDPNOUs54xu4Yj43mo0Gg2OeVqggXwaPV3Jk2vFcpXNz5KZM?=
 =?us-ascii?Q?xdQtNlrJ3cVKVMrFX0fPniafi5fLbpUjmDsGVdsEQXU0YrUBstjNUJjwn5L3?=
 =?us-ascii?Q?UzRYW3iJ/Od3QLb1W9pgYFH0AnLvVv1KqdFSa6A3zhhq1Q0XgEpm6kap/f2r?=
 =?us-ascii?Q?p9GgtSJAPpaFaKDh8mvJp4vkbqUZFgV2bqWIAtLTP/7GHAmMXRaA9bNGHqPR?=
 =?us-ascii?Q?8b2imQDNMMhfWePM/Iaf9iUT+eVdD/oMcACgSrGfzmbqQIS0VMdpuVZxY6DS?=
 =?us-ascii?Q?BZF9aJgYjAkjGEkeEpy26O+kDduptpUmKMPhx4Tq22qXOgeVKB5tsZN6r5eM?=
 =?us-ascii?Q?B7hZ91QQyXDzYIWy8Q1sNH9aBATwSg5GDjGjXyILAWMD0ucgYTnEC3JtDg9l?=
 =?us-ascii?Q?mvuQ7TMK7pYST3qHb24HoNnOMWUQq9+WFWn0CBnrigEPZpkPht+dEdBmuGYK?=
 =?us-ascii?Q?QXHc+rw7HkxjF0XfsX/0Shp6xODkArezfDtCHXglcb+1xSIcfDf+u+suUaRL?=
 =?us-ascii?Q?a7fJ6KXFhRJAp6Ygn2Cw87N4SS6M/etKYJSHmcB9rescjtk+o0/IHcbvm+rf?=
 =?us-ascii?Q?Z007By7DWHOBD1OK4OsmmGvTKIoYs3pAkdVITMxDXqJ/RWwm21jKza6BLXY9?=
 =?us-ascii?Q?Ar66QOEpVRGWzGxFi5fAPzq1+jMS0trjSYLna3KjBK5wc1ftZV3q/juSC1KU?=
 =?us-ascii?Q?CXtNR2JWegpsDstweTMfwKFRSgWBxu+dg1J1Tg3ewhwl5aw2i6AxRehmm7hC?=
 =?us-ascii?Q?BnIdRobQ2XdbzwSdUe0z/aIq9xaMZMcfI2vZfw5CHBMW2uwV8CHrI41F5r1f?=
 =?us-ascii?Q?DIFAgMn/HIUCdBj8hXz4S0nFNAud/iNgN+3G+OpcnFqL2aLv/352UAtOSrOK?=
 =?us-ascii?Q?CwL3AaH/0bQFakZlrYMutRtowcl0DlZch2SKULVrgVpZ9Dy0iFJM9BZhxiEq?=
 =?us-ascii?Q?GybpfqUxd0G2j6fCv6DZoP6KEhEz7verMMNnpWaKd2IoFzJu0kkmlNqFgzp2?=
 =?us-ascii?Q?78p7Y7U2vs6qkNQMoVpSSpUiCoXi0+jdaPibYH8jhKjgIwrVvZBooVYEe2/E?=
 =?us-ascii?Q?QLv2/9DZNz5i9WMcUkfN7Cs3P2QMbkIclMnlOuCWwsKneTRgjwDt0uwrJZgx?=
 =?us-ascii?Q?CbgfCZF/eWmMVeZ4NoqzgAUwZtn7guMTy6yd0jsWVF6Qup4u1bA4W1xYDoEH?=
 =?us-ascii?Q?7scF8x3Iop+ydFNYesAsJPiKXliQ/P7CGrAAOfWsMHwbDZ0rzgWT9HD4qEwi?=
 =?us-ascii?Q?ulNXbiAaRwKMAY6zpHC4vHl/j0+M+lRhDuRNpL7xyFA0o0OUMfYYYwz5dKoE?=
 =?us-ascii?Q?ZbQd7hlZxI0ZRgWoEgGt0dkWzx20OWfAq4uWZZXvWRtGq2NcwPvHunD3Uc/W?=
 =?us-ascii?Q?+m0T08szyllYRGv67E3Pg3tgBzBunTfygDKeLj4SRRa+Pfj4uUHQQWZRnUfA?=
 =?us-ascii?Q?OOeBDjnZNa7g86Tu9dIB8BakHvBVwsv1ojF9flI7O6d7YfcXkZjKrmuKSjo1?=
 =?us-ascii?Q?RmMpkpj+7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7322fd3-c440-42bf-dacd-08de6978a7cc
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 14:20:06.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23aBkCfqt8IDPzbybX8/JKGUU4xxY21v0s4WpFFOuPnAglX8pQGOP3WcDXw7Fam+X0BMH4KwYPIvdvnZ7HVC8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76946-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev,groves.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iweiny-mobl.notmuch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,groves.net:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ira.weiny@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 79DB4125261
X-Rspamd-Action: no action

John Groves wrote:
> From: John Groves <john@groves.net>
> 
> This function will be used by both device.c and fsdev.c, but both are
> loadable modules. Moving to bus.c puts it in core and makes it available
> to both.
> 
> No code changes - just relocated.
> 
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

