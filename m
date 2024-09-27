Return-Path: <linux-fsdevel+bounces-30225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0AE987FE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 09:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CB4285680
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A511898F1;
	Fri, 27 Sep 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sxmc4GO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC416EBE6;
	Fri, 27 Sep 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423963; cv=fail; b=l3bmfYgGE2OUeL1IOZUopb/PMtz1NC7yb6y8RvQlXnbc0e7eTPbBRXTy4UtPQPL/BP/UsrJCyjQTBFYrD8ay2/a1U5YBLTh6gfN2ZGcgCmBsB3UH4X1wkCJ7VWF/xEhUBt5hICFieg9iMOIZxiKbT0G6fKRXy31EomQkJTwimGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423963; c=relaxed/simple;
	bh=XvH5a2wyzvZk6PfBrANf+cp/sbc4X9/xY4gtY2lHyvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oDr965xJV5RkF43OK/RKPk/KmmMMe07FFnH+snY5qgnrCzPEbsdQChB5+X7Yq/OH75KU2kXEnM680+cCV6wsQmcnFLZm2MzfEiCEyAO9tQGPokLyUcaize4yc4ma3JwIT1SzQSu4d4M5a8pMuQoaQ+ziVQ+z/COhA+4VRhiAxP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sxmc4GO8; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727423961; x=1758959961;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XvH5a2wyzvZk6PfBrANf+cp/sbc4X9/xY4gtY2lHyvQ=;
  b=Sxmc4GO8+QgcApLEonso9rnYP3FnFA4SB9TMFBt5gPjqQghRS249Acx8
   TvGl2fy9sjWGb19j40z3sXiITSuTooGAE2+GKuDTk7wV+tlWjGcnFJznN
   4p4DmDY+SLFQrZS/M22/q8eeJ5fJ9mVoPrxpwsTcna9QPdOK3GiK8pyFU
   //aaKploM1LyGfIbaTtiRMwcjNaHbKx17RY7getr9hF+Yd+gu/MKDN1l0
   691A2gkZb0iYve8PJbsUPTFDRtrIiv/4U+s6z4fBMYhiu88BC1egixTIo
   XevkCOm1UWcr3ioC54i5xp93hOBdjqp8QpvPNQkfZKJvsq3zVn9VFw04R
   Q==;
X-CSE-ConnectionGUID: +hDazJufSmqvO4ottoHGsQ==
X-CSE-MsgGUID: PmIDDxJ6SMCzFwjf6HAPPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37126528"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="37126528"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 00:59:21 -0700
X-CSE-ConnectionGUID: hkAGLs/xT+Kms5yam7NCiQ==
X-CSE-MsgGUID: gHtWc3S/T/mlkog0aPXFuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="76531058"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 00:59:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 00:59:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 00:59:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 00:59:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cixaqEEz3hRzvMrg3Ucj0tjMLg8tqrPuhZxU2nELsDxttQx/0Z22DrfmbQpxuFVYKo1LQKdq9P4lFC+Rc1JXkg2eM12mXI7N3i5OfF2eH1B4/MIMh2LL6o+nD1ogJ0oG8GBhkWX/HwgWyuJTOfTZzlnbJ8LQOmhqyqpLKVeIL4nRGNsxLjegPZ10G7cMwtcFWAvZqwc9OOZq6VGsTBx2f4wPKLWQa5SrjBjekNxfx6qTFuOjSS75dESLotKCOaaF2wU2Cde9I0/17/BvrmQ0oQcIBQkw+vJipWnkT9MJ526eTz6o6o1yFf4S2HPcg23HXMbJGESYmltjWnvurjy1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykKPEi0HH32xqqB0DaMWCrWwW7TUfdal7NPhNGRNDUM=;
 b=NSIVlUDWECTtOzvohHisHNWeHxmubrY+JnrvJ70/7zEJuIi1UcMBB/4dG4DrhuSxXxLGsQwsolJABXKZUGehrRlKC+zHl41LiqelIIpBallX8cJZDM0WZoJOQYLpEBDPcXtM4Jzpx954OKsNLA6qzCRIAn/iu+acDiVWjMh1hwdTzTo9/toLBdVMYwJZcESPyApZJkwHEygkSYrIMmdZ49O3d0pSV5QzLf1OICqhkGJF2A96NaZU1ShmAnc2Yl9Nva7IkgWTI3V5LPGGiZaObw/WMslU+kzyvUpBfVESKwMBJGP1DVGVtbVVhxZHPvYVGttnxJUEdEorGlXTofZrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Fri, 27 Sep
 2024 07:59:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 07:59:16 +0000
Date: Fri, 27 Sep 2024 00:59:12 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>
Subject: Re: [PATCH 10/12] fs/dax: Properly refcount fs dax pages
Message-ID: <66f665d084aab_964f22948c@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <9f4ef8eaba4c80230904da893018ce615b5c24b2.1725941415.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f4ef8eaba4c80230904da893018ce615b5c24b2.1725941415.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: b69687b7-6e2a-44a9-e771-08dcdeca48a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H7uDEaObp5+A6xWD56zaC2987SHTzEof1VNKgx4gF+DC9rUaCUGZGinclgg6?=
 =?us-ascii?Q?dT3tbJBRMU32cO7BgreQetDvD7aCZi4Yn1G6BxWZMrEmefcOFYDQXRSakKAK?=
 =?us-ascii?Q?OgiWxdTeI5refKV00Y2eCzOOzWrDJA9bOF0dISMEExEXh+mdsG8yZEU4XwJf?=
 =?us-ascii?Q?F7ieyTw+mVsolzMxS1pK89JH7C+Lk3sTlN/RRVv7y2qBT9rIMeAz+Gx0KXd1?=
 =?us-ascii?Q?EQLvSo3ZHv9bd3ElyUTRiyPamzyPEu9LrzJcShrcllL5WlPnrmdiDMfURvBi?=
 =?us-ascii?Q?FYhRGrmhtYnla+FsCKMBWi0hpVyUeR19hlAOSU+1AoQPxD3aPRGffwYG8qbX?=
 =?us-ascii?Q?yrLPqrR9DWJzaNlmFA1VZCwxMz0o0vXb9xzt1yFADUGkfOl02z5yZHbONWL4?=
 =?us-ascii?Q?3TdAFL/5SLtOc2GvaI13CE7EtryqoVRiFO7G7jKC9B11Oo3QO0ZqCzH5/N04?=
 =?us-ascii?Q?UF+37VSK7skOlm/4vFOyw5BVUOUSJLZ2khO+c9FNuBYQZJ/ftfKHx+NRTBoU?=
 =?us-ascii?Q?CHjtX58mBc2AOu9MwebcahcD0Q6jitFYR8woezsWLSWltIYR4glyXZeObHss?=
 =?us-ascii?Q?lLQ7IfO1upX92a17hkb4fVOP9TfIS8xKrM56mE2BquRMKD/QaltiCGbj+10v?=
 =?us-ascii?Q?iJFlbnCAF0/UfngP8UnuKASUpW8iOnHfDHQrsxwpihTbK2gkwK6KCwTDTzjb?=
 =?us-ascii?Q?YdXU9N+Tl7x+3A22Mf7yIju9ZEtXOr/CvuT/CC317UbSTVdJkkZhZyojVafw?=
 =?us-ascii?Q?bv0S7qNy46vmI9DPOl/7Jvqg1fO5KsfvG2Xe5lWU3CQnyuZStzfzwq/wc5vV?=
 =?us-ascii?Q?A58nft7df93x4NqIq2lB0H73HPSLJG6HPV1Wiv8uMMPavK59rNoGBiYk8O0Z?=
 =?us-ascii?Q?TYbXaZCP12SJi83a6CxFYkUGHqahQ/swQjwx1MhYgSWyJLRGkOESJt9LNzlS?=
 =?us-ascii?Q?QMnHMzZV9KFwqnmbaLveyOPV+cjkUmGTL3f5dTjn1MBjkVst0MAtLGGHt//A?=
 =?us-ascii?Q?XgdK8vLavqgnpvFuTDOjyYjhCP4dmw/AyR6w07cwEbx+yGt+D0Ez33knEXz8?=
 =?us-ascii?Q?xQGRx2xXWgVbt6QBboz7+DxtwERJ3Iy8j26jpEjTLDcxYq/vjkGtl+qxfnbf?=
 =?us-ascii?Q?2ydlCyitGG6YHRm9m6onWoYhsT5P9CzNpHKXCgPaluoO6xvZDaPO8BIkuDI+?=
 =?us-ascii?Q?SzYrN7TpPi4YodDDusonsC7hGAuIbOhSujc4gXcizecO+7OB1PgSL47sxc1f?=
 =?us-ascii?Q?ebk2n+NguXEnnAdeDOR4GN1ZicNniN2swn432FJ7Sg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BACCb5rDh0Zzk6QN6btzWhh/I6ChyCBKECU2/q88LVip4TWMvmt6lgEEfB1d?=
 =?us-ascii?Q?qdQyb64169e18Qlzshr9xjQh0aQe/w40EQ/ace5nSfU84d0z4OJQoniFG5dY?=
 =?us-ascii?Q?PHQgKSiwvz6F5EHakpg4uxzZQD04elWhb0ICHS3GiJqp4tZdb07WgTB+UtSX?=
 =?us-ascii?Q?H1S6L39ea1FUDyQT25OAezMQTpVSbCzVXd7Q2lnBUYoVxidkicSzJ0UyCmrA?=
 =?us-ascii?Q?3GfVvxu6NDbQJxCoNOcFGH+YG8G/zxKB0FohBZ4wKdZDixZnzPDpBCXc0fPL?=
 =?us-ascii?Q?kctt82jMjfSZvAw4FwyDsx9UFIDAzhxow1qjdIO8aq99BqGXnvWjqZ7910/R?=
 =?us-ascii?Q?haTWLOVqEB8DCD8VLISDSs+Ad/fZ9Txmh3+NzIME6MtMhJ7dGr0olqpN/rOO?=
 =?us-ascii?Q?uSwR0kqSW5n90eAEUqJ+drmXnCWV/x3N9Bk7sKNwFHEorx40Tshb/A0BVWYV?=
 =?us-ascii?Q?HXSBvcCwuuOrwKW2/tWONrCVdPS7twfD+iza6XtVl+EEFooEP8wFqdz+aBEG?=
 =?us-ascii?Q?fFLXwo2Pj7D+CGlCKT6tpKsrsznqvJNhRCEA6mq6B60vw7kBjXN52JireZVT?=
 =?us-ascii?Q?f59hOWPDVMEi5EQwloyzyDMwU4XOfpqGlHMXBjxzqPVxcJMoutKK41uArjSK?=
 =?us-ascii?Q?qxdxNeilXgL8GsajyU3O91Hb//DDM9DrnP/rreIQ91cD7LYL0iOGTyADIKlq?=
 =?us-ascii?Q?apKsW18pWC3+ESYngdCU9gAfdAbh4eKbzbW9Mx6pf6wwXo2ckAPZJA0yAaJL?=
 =?us-ascii?Q?QoJvpcEej15LM+ceEJWlmHV/w4/6u+Xq7LMcNJXIAxJnyPLviGy9wJeHS8GT?=
 =?us-ascii?Q?lIMHapAafU+EaG1BDcT8nyyuy80iwO38waqIuO1yedTphaqzhj7aCQzdyqLY?=
 =?us-ascii?Q?jL0XRKmMOQ5T8wriGq91a+LigLLYhiCwNUhaO4hBx7sCFcrdeUhlq6Ai4W02?=
 =?us-ascii?Q?KTIMkqWifRn3d4A6rD1zCLMk/gfP5//aB5bSzFLNu/IAwcfrqdRq19vxN+7x?=
 =?us-ascii?Q?k859TYMjUi+CYewrEp/ubwn7jRLC2ZaYMfkjXltNHb5la+TDnsaNp5OAU/66?=
 =?us-ascii?Q?YQtnDC71brceFNaSO02LF8Snlys+7SdQOurSZYiWN52zRdGFcwAuIybyYhen?=
 =?us-ascii?Q?ODh3elcOR0J7VtxVdQsZhE1oqtVTKCXl4gTysO0mHeUCmQQkbGRXPG/btj/I?=
 =?us-ascii?Q?DJB0GYQE+sYhgsadaNBzM2r2yFhMSkwV+/lj9fSVineSqtnFwgN5gm6n+hDU?=
 =?us-ascii?Q?/RemscJshzZfeYbfoDfhk3PcRxovourbvXdhlOu6dMZCTkhclxxE9blyI2xJ?=
 =?us-ascii?Q?FWAVnBJl4N/6a5uTVtf83/6+dJo1PPHYkfFBkErrW8UScNlXTJKW0xQ5y2Uo?=
 =?us-ascii?Q?36vZ8LsvmuZ/OiI1OzwQzKyE34QL9GV5WD2CaqRDmHWF/KGF389wDSlUWVqu?=
 =?us-ascii?Q?e4APf8k3lmX0hfwPdbnbOERZ9n4i/m4XWs2RY/M9IMcrqsNaeDKgVJnOytaU?=
 =?us-ascii?Q?Xs4Kz4GhAFzKsRwGdiTg+GGrPS/KkCOeK+Eh6nHyPsZXZ3Zu79p7FTEtyvGv?=
 =?us-ascii?Q?6N0XFae0BsdlH1OJytXK0puaU0Yy0z6xm4UKGcGz599VBScml33M43XHCJK5?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b69687b7-6e2a-44a9-e771-08dcdeca48a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:59:16.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0mT0jFSnJVjQMg9JU21QY0dhHR811lpXCv0vfbJo5LC+V8rHVJ2pz3t4Jd1DrlWMW3uF/NJXAzzRWAGVpVMK8xgFAwUXdD+64WVkW73bP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Currently fs dax pages are considered free when the refcount drops to
> one and their refcounts are not increased when mapped via PTEs or
> decreased when unmapped. This requires special logic in mm paths to
> detect that these pages should not be properly refcounted, and to
> detect when the refcount drops to one instead of zero.
> 
> On the other hand get_user_pages(), etc. will properly refcount fs dax
> pages by taking a reference and dropping it when the page is
> unpinned.
> 
> Tracking this special behaviour requires extra PTE bits
> (eg. pte_devmap) and introduces rules that are potentially confusing
> and specific to FS DAX pages. To fix this, and to possibly allow
> removal of the special PTE bits in future, convert the fs dax page
> refcounts to be zero based and instead take a reference on the page
> each time it is mapped as is currently the case for normal pages.
> 
> This may also allow a future clean-up to remove the pgmap refcounting
> that is currently done in mm/gup.c.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  drivers/dax/device.c       |  12 +-
>  drivers/dax/super.c        |   2 +-
>  drivers/nvdimm/pmem.c      |   4 +-
>  fs/dax.c                   | 192 ++++++++++++++++++--------------------
>  fs/fuse/virtio_fs.c        |   3 +-
>  include/linux/dax.h        |   6 +-
>  include/linux/mm.h         |  27 +-----
>  include/linux/page-flags.h |   6 +-
>  mm/gup.c                   |   9 +--
>  mm/huge_memory.c           |   6 +-
>  mm/internal.h              |   2 +-
>  mm/memory-failure.c        |   6 +-
>  mm/memory.c                |   6 +-
>  mm/memremap.c              |  40 +++-----
>  mm/mlock.c                 |   2 +-
>  mm/mm_init.c               |   9 +--
>  mm/swap.c                  |   2 +-
>  17 files changed, 143 insertions(+), 191 deletions(-)
> 
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 9c1a729..4d3ddd1 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -126,11 +126,11 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
>  		return VM_FAULT_SIGBUS;
>  	}
>  
> -	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
> +	pfn = phys_to_pfn_t(phys, 0);

BTW, this is part of what prompted me to do the pfn_t cleanup [1] that I
will rebase on top of your series:

[1]: http://lore.kernel.org/66f34a9caeb97_2a7f294fa@dwillia2-xfh.jf.intel.com.notmuch

[..]
> @@ -318,85 +323,58 @@ static unsigned long dax_end_pfn(void *entry)
>   */
>  #define for_each_mapped_pfn(entry, pfn) \
>  	for (pfn = dax_to_pfn(entry); \
> -			pfn < dax_end_pfn(entry); pfn++)
> +		pfn < dax_end_pfn(entry); pfn++)
>  
> -static inline bool dax_page_is_shared(struct page *page)
> +static void dax_device_folio_init(struct folio *folio, int order)
>  {
> -	return page->mapping == PAGE_MAPPING_DAX_SHARED;
> -}
> +	int orig_order = folio_order(folio);
> +	int i;
>  
> -/*
> - * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
> - * refcount.
> - */
> -static inline void dax_page_share_get(struct page *page)
> -{
> -	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
> -		/*
> -		 * Reset the index if the page was already mapped
> -		 * regularly before.
> -		 */
> -		if (page->mapping)
> -			page->share = 1;
> -		page->mapping = PAGE_MAPPING_DAX_SHARED;
> -	}
> -	page->share++;
> -}
> +	if (orig_order != order) {
> +		struct dev_pagemap *pgmap = page_dev_pagemap(&folio->page);

Was there a discussion I missed about why the conversion to typical
folios allows the page->share accounting to be dropped.

I assume this is because the page->mapping validation was dropped, which
I think might be useful to keep at least for one development cycle to
make sure this conversion is not triggering any of the old warnings.

Otherwise, the ->share field of 'struct page' can also be cleaned up.

> -static inline unsigned long dax_page_share_put(struct page *page)
> -{
> -	return --page->share;
> -}
> +		for (i = 0; i < (1UL << orig_order); i++) {
> +			struct page *page = folio_page(folio, i);
>  
> -/*
> - * When it is called in dax_insert_entry(), the shared flag will indicate that
> - * whether this entry is shared by multiple files.  If so, set the page->mapping
> - * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
> - */
> -static void dax_associate_entry(void *entry, struct address_space *mapping,
> -		struct vm_area_struct *vma, unsigned long address, bool shared)
> -{
> -	unsigned long size = dax_entry_size(entry), pfn, index;
> -	int i = 0;
> +			ClearPageHead(page);
> +			clear_compound_head(page);
>  
> -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> -		return;
> -
> -	index = linear_page_index(vma, address & ~(size - 1));
> -	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> +			/*
> +			 * Reset pgmap which was over-written by
> +			 * prep_compound_page().
> +			 */
> +			page_folio(page)->pgmap = pgmap;
>  
> -		if (shared) {
> -			dax_page_share_get(page);
> -		} else {
> -			WARN_ON_ONCE(page->mapping);
> -			page->mapping = mapping;
> -			page->index = index + i++;
> +			/* Make sure this isn't set to TAIL_MAPPING */
> +			page->mapping = NULL;
>  		}
>  	}
> +
> +	if (order > 0) {
> +		prep_compound_page(&folio->page, order);
> +		if (order > 1)
> +			INIT_LIST_HEAD(&folio->_deferred_list);
> +	}
>  }
>  
> -static void dax_disassociate_entry(void *entry, struct address_space *mapping,
> -		bool trunc)
> +static void dax_associate_new_entry(void *entry, struct address_space *mapping,
> +				pgoff_t index)

Lets call this dax_create_folio(), to mirror filemap_create_folio() and
have it transition the folio refcount from 0 to 1 to indicate that it is
allocated.

While I am not sure anything requires that, it seems odd that page cache
pages have an elevated refcount at map time and dax pages do not.

It does have implications for the dax dma-idle tracking thought, see
below.

>  {
> -	unsigned long pfn;
> +	unsigned long order = dax_entry_order(entry);
> +	struct folio *folio = dax_to_folio(entry);
>  
> -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> +	if (!dax_entry_size(entry))
>  		return;
>  
> -	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> -
> -		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> -		if (dax_page_is_shared(page)) {
> -			/* keep the shared flag if this page is still shared */
> -			if (dax_page_share_put(page) > 0)
> -				continue;
> -		} else
> -			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> -		page->mapping = NULL;
> -		page->index = 0;
> -	}
> +	/*
> +	 * We don't hold a reference for the DAX pagecache entry for the
> +	 * page. But we need to initialise the folio so we can hand it
> +	 * out. Nothing else should have a reference either.
> +	 */
> +	WARN_ON_ONCE(folio_ref_count(folio));

Per above I would feel more comfortable if we kept the paranoia around
to ensure that all the pages in this folio have dropped all references
and cleared ->mapping and ->index.

That paranoia can be placed behind a CONFIG_DEBUB_VM check, and we can
delete in a follow-on development cycle, but in the meantime it helps to
prove the correctness of the conversion.

[..]
> @@ -1189,11 +1165,14 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  	struct inode *inode = iter->inode;
>  	unsigned long vaddr = vmf->address;
>  	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
> +	struct page *page = pfn_t_to_page(pfn);
>  	vm_fault_t ret;
>  
>  	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
>  
> -	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
> +	page_ref_inc(page);
> +	ret = dax_insert_pfn(vmf, pfn, false);
> +	put_page(page);

Per above I think it is problematic to have pages live in the system
without a refcount.

One scenario where this might be needed is invalidate_inode_pages() vs
DMA. The invaldation should pause and wait for DMA pins to be dropped
before the mapping xarray is cleaned up and the dax folio is marked
free.

I think this may be a gap in the current code. I'll attempt to write a
test for this to check.

[..]
> @@ -1649,9 +1627,10 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>  	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
>  	bool write = iter->flags & IOMAP_WRITE;
>  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
> -	int err = 0;
> +	int ret, err = 0;
>  	pfn_t pfn;
>  	void *kaddr;
> +	struct page *page;
>  
>  	if (!pmd && vmf->cow_page)
>  		return dax_fault_cow_page(vmf, iter);
> @@ -1684,14 +1663,21 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>  	if (dax_fault_is_synchronous(iter, vmf->vma))
>  		return dax_fault_synchronous_pfnp(pfnp, pfn);
>  
> -	/* insert PMD pfn */
> +	page = pfn_t_to_page(pfn);

I think this is clearer if dax_insert_entry() returns folios with an
elevated refrence count that is dropped when the folio is invalidated
out of the mapping.

[..]
> @@ -519,21 +529,3 @@ void zone_device_page_init(struct page *page)
>  	lock_page(page);
>  }
>  EXPORT_SYMBOL_GPL(zone_device_page_init);
> -
> -#ifdef CONFIG_FS_DAX
> -bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
> -{
> -	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
> -		return false;
> -
> -	/*
> -	 * fsdax page refcounts are 1-based, rather than 0-based: if
> -	 * refcount is 1, then the page is free and the refcount is
> -	 * stable because nobody holds a reference on the page.
> -	 */
> -	if (folio_ref_sub_return(folio, refs) == 1)
> -		wake_up_var(&folio->_refcount);
> -	return true;

It follow from the refcount disvussion above that I think there is an
argument to still keep this wakeup based on the 2->1 transitition.
pagecache pages are refcount==1 when they are dma-idle but still
allocated. To keep the same semantics for dax a dax_folio would have an
elevated refcount whenever it is referenced by mapping entry.

