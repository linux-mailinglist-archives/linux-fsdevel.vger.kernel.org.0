Return-Path: <linux-fsdevel+bounces-22686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B18C91B053
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 22:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2831A1F221AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E8019DF9D;
	Thu, 27 Jun 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGZerlIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDBD19B5BB;
	Thu, 27 Jun 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519853; cv=fail; b=uPPvuCU5l2fCEYrmXCnRDmUDRCicvyn0dikh4x6ol4eoiZxdT6HaNVzFJL9j31fTMzrY3WIck6FXby5UFXLVpVc2G1z9ZZ6rlRXLazKEh0yewteJ0C/oz74RDPAK8nJUWcXjR6Z5wftJhFjRrROzZUm2CFBG4NVkMflaHVXsx6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519853; c=relaxed/simple;
	bh=ujPBEfxzAdLtCL5AEYUnQkt1XfMgJQK8RMByLLYBPFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PguPkGkGcJe0M7LWLglD4abImL2HVihDMMmmuqSbuMYPXh4CURnQoaGemZLrxvoJPf0cZTAcHdl+aA/+jYL2CdFNVrWVP74TkjXbmOR8XclsbSQytCJCRTlZ+19SPqZlJLllMxiL3Wz3iUbCmvgjk6Iu6gj+bXVumQ0vaJufa7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGZerlIA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719519851; x=1751055851;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ujPBEfxzAdLtCL5AEYUnQkt1XfMgJQK8RMByLLYBPFc=;
  b=AGZerlIA0AGItbeLMnoc4eiVJZmC/TvzdHHRWfTNizR87hynEYYxcPmo
   /Fb3WQRKP9a+/hgRt/0iohVj6hZmZuYquU50dNfsTAu2yIHPKOATk1QTo
   EcOu6gKAGQ4sGzzOMcrjooCKL7pE5+nMgTlZSj8Ohby+tMaQSkQXjbQtv
   HdRYZTagPAjIMZ02V3JnBkV3PiDpghF0eZELGv0Y+nAFRfaPbRaSfRvAU
   2OHUuCQE04h4G8DzzUG3LtWYAjVW2PYfxU3cQ2vv8YlgtsDGNGEj9KbZ2
   oYpbfc9s8VpOUW2rVwt8tZJ2ZWnZRnPOLKilpDGQb6IgQWZFEY0mxH/bV
   w==;
X-CSE-ConnectionGUID: pG+yUK1fTFuDADdct0PBug==
X-CSE-MsgGUID: r6ShbAvaQxKtT9+qMeRpfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="12288469"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="12288469"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:24:10 -0700
X-CSE-ConnectionGUID: T7WWb5LwRYaROFdY5wTSnQ==
X-CSE-MsgGUID: 9zQcIHh+RTiDkyKHMPsUrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44570892"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 13:24:10 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 13:24:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 13:24:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 13:24:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe6VI6yQi/se06pujXXFoVoiSdcFhMb3PVjbmDeIqpQ/MxG43gULKIvHyNR993k3w0gPZ/yDXRdpzXuywnR+9QsM2vgfJB0m5xqDpRbkX+4VBWKFVRItJwW1MVnWsEblgOWNj+v/gjG2Hvnh9V5IjfaU20NycSTLRRYvMY+eMRz4BMdAsSHxPuCOeNrGEE7ub3gl1KS/LFa+4PtO9nR+WqQQEDtd2yRqbE6dRRacKU16En8eecTipBPURFTq57sY1esEov1B0q1bDsHQxuLe7dPe7VH3HQWW7nnMnZHhgZMj4SbIg1WSHWUqSNhnf+DuOOQvHoFOylkZOUF96kR8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD7/ZeYBRDgY8CYXPE2jgQjbDufqOwpetlCBLRRL9yE=;
 b=IDiToqaWyrODDHGEIOgIh6rP9PIRYup05E3qbAnBQRjJjO62kKWZOrYiFzcZ8rQQRn2PWJq1fqtOw3h4pbPKUQ9gjvLc4fAE8lj2o6l7RVkC1T0p5neTSQplqfAnq54rJ1zO4CACxO1to2eljF74qO54eMqGQk+P6SCkFmjaDzA9jYMClurYZx4XKxDkMdof5hnAHbcEKbDFDSM+O28ECiPVKBQeIVX5t6O8eo2/ATh44iG12N5WluVtILFvmlznrJ1meVYRYO4MNHYVnPxQzmtNyY8lK2xuhJIV+1VW4gAkAaO6jViab1pYe8Ya9qpU7IDxWJjAOW6uOxM9khIg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 20:24:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 20:24:06 +0000
Date: Thu, 27 Jun 2024 13:24:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
	<bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>
Subject: Re: [PATCH 00/13] fs/dax: Fix FS DAX page reference counts
Message-ID: <667dca6259bc8_57ac2946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <667d0da3572c_5be92947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87a5j67szs.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87a5j67szs.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d05c744-cf49-4733-1730-08dc96e717c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2bs77Jw8YryZhi07QFcWe+G2B70sHjUwfUxocD/aRLvRJq74s89uhkWF6RVW?=
 =?us-ascii?Q?ztE+DdUtQz+HEmu4w+V/7F0y0RTiSRh7LCw/UBRG4HLrCBj34sKtuAHVf//k?=
 =?us-ascii?Q?ITv5TNVvyyBOFtnpqreD2DKnOX1TvD9cTWu8wjvXxhfhSlaItCcacpMLa0L1?=
 =?us-ascii?Q?g1EpTUxQB5zlTjYYvasQkXBbroNXy/KwqLAJlZOAuz3ViSDbsU1hgeklMQqX?=
 =?us-ascii?Q?UXurR2Xhg+D6NAeeDzWqGCGuSJMCnTnoP07+L4X/ZffocU/AMbjLFiWvNi3x?=
 =?us-ascii?Q?BkqjCRM9zk5+4jNvVLY/AbCVCYyuNJEQ2D/fK9RdATbdyq256NelhpFGrWkR?=
 =?us-ascii?Q?2S6zW+adIDuxgUYBwBf7KvuL4cc/uZ4yw778MC/YxGdTegIMidZD9eszJQ8S?=
 =?us-ascii?Q?541Z61TPnRNCsYlKhDjC5GJbGiZCqMIcMRnOrHK/24osTKwfWdiSfGWnj20J?=
 =?us-ascii?Q?InUU2dEEtDgrPihCVfteK8p/fx97W0f/tJqEY4umVvg0t3MtSZn+e7oThEW/?=
 =?us-ascii?Q?0zN3eydyVa7UYWCpR8Otjm3wNwCPUKnZ8nZSgoJl5gHjiqAoJmI5+bvfggKA?=
 =?us-ascii?Q?/CkyLo4H08c2NXU5fdhR1XIZo7hebcfqRvk31T1U+K89cPJoo3EvyV+1sDoH?=
 =?us-ascii?Q?zJNUveOibo/zFUxKa6nfFTZ+L6cBWejC2hdjQ/p/AvrK6Oz5egJAOmj/Dmmb?=
 =?us-ascii?Q?kSscSSjw98BnqF1+5hAfZst+3mdjhamwVFcks5eL1p/5dUUwNzroImNNlpfx?=
 =?us-ascii?Q?J2eKHp8+SYdXTlFI2Y3dTPbsIHMGf3NMiiA9DeXms7D0VHeLIT3ha3WPCqrh?=
 =?us-ascii?Q?n1ZCteNtJDlJ3OhNIepeQSeyyyeS8EBHn2HpaBGG8lhli9wr7vq/lXMBB3pY?=
 =?us-ascii?Q?1/nSv2TD53ba4/JagE1OH+eSMOIQ2WZ+Jr8JWHkCbj1yhNtLSnEmwcnAYd/z?=
 =?us-ascii?Q?yxgNqOkhPMTrEKD0t4VCttqEPTi3eJEqjLCvxwZKsiUvcjTcoJTYJHfrB17X?=
 =?us-ascii?Q?gTTJMwNMru0vXktq4q69f1MNIKRgIaxCXkhQNSA3Vf+drYct7/+qc+q74I/E?=
 =?us-ascii?Q?BZ9srmkhYivacSi0nOFPxgu6MCWQLvinDkP5d5jduD47nOLNlhrVvU81BRWq?=
 =?us-ascii?Q?r9pcLOl0zz/a7cLqrHGQIfQRGwNpOJNEayvOzBN3PH7IwN+lIiA0q13IFIkK?=
 =?us-ascii?Q?BH/YrJMbhwOpipnFxzNN162mpWWSIdGacFr4UyMRmqtFoXc7Htd65sku+kYG?=
 =?us-ascii?Q?HqdZ+SbvR7PvSzwFqdGUFZRGGY1ZrP2a8dqt3hoV7WXbIum5z3ynkP2S8fQM?=
 =?us-ascii?Q?T40=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gDP5ySHXrRjE8RSdnT/EFvS0PjcwmqgxeA/Nk2Y+zM6rOdp/ThaJJybPrVbf?=
 =?us-ascii?Q?l2btv0ZiBGmn3WfWbUbl3rvmfR2unss/5cV3v9vMwb26O3Xax5O0udIEuwJ9?=
 =?us-ascii?Q?Ke0OAB7M7g/p4BPmfkGehr0jmaE6ylGCLng0JzWLmnlEAOKNGPJF25m3ToAO?=
 =?us-ascii?Q?qR6CnOqBiivDaezPIYQZ6na8CxF/PoSPTtKuMKGy7jsbfwYKeujAP0OcuuZj?=
 =?us-ascii?Q?47GjBxuLksDiJ6ojssd9otaQ/BHYhXCFoVjz7VpjOIkAMY44TdCN2Zsm63rn?=
 =?us-ascii?Q?WbRAOBXHLNt8s2ICCFc5hhlGlz9ADcjZxzeg5O47Q2h4FjRM5eH22bdBNJ6Z?=
 =?us-ascii?Q?w8sIPx41kvKv0uaiD2fQOInVTwFb+/WfXs+GHoJgE6EU1eTKLUhKpVSM1pqp?=
 =?us-ascii?Q?VF747NrPTtYdjxuLZ0NRFdkd6yIHNhtw3OfrZjAgXf8MsDkqEprpbuwiUa35?=
 =?us-ascii?Q?c/KfPrzf4/CGRKEVKwH+pus2GRqSiMl6IQpPD/N4qE2e3RdgYlhF3pBxJbbb?=
 =?us-ascii?Q?ogdlkaJANtu0+QOXw99U+PvA4RYfwxPgwHgqgjaCoFsocQlv5M00v6pIJYbf?=
 =?us-ascii?Q?d8VoZ5fESGRR4yKFl8dHc4tIMLmk4D4B2OwfDjUVzTlZZeeGuLCHHtO4D5Wu?=
 =?us-ascii?Q?BTvlaC1mnfLTQ1h9ZyvMSnZl72wuLOPnICqsEMRPVTIZa0W30mkMQgq9QEs3?=
 =?us-ascii?Q?9EeD00xb0OT4Oa7o3BGxbB3vcBri5czYO8nW/KFc0IbWl+/LPtFUhS9PcISJ?=
 =?us-ascii?Q?7AWgsCuxO5RJAqQE8Rp5BPkxu1iL81Zm+nIIi1L/L6FE7YhdyMghiyW7gwMG?=
 =?us-ascii?Q?VfQTGvi/vc8PPd1dOQgUML2ym2DrNK2aRetc9nrPoLYdx73wGWEWZy1MsJV0?=
 =?us-ascii?Q?bgRM72j7lY9LvRr3mX7Um0/bRIo5JaBHREF+wx4V1TBz1H6ad2+6qntw4oDg?=
 =?us-ascii?Q?vVzativMqrCOBv9pXLCssE8rq4M9p9zS/49o1mZ/p92b69zxNslEbTkKhYW8?=
 =?us-ascii?Q?mpxca7eHI5QTCPq4krkxH5CzF9K7bhTp8p3LfUC9Gixg9/CVci+nIcR2ysZg?=
 =?us-ascii?Q?i2f8WwiwjSg2YUuuQTIUpMYysecuO5ufAF1hyQHlZI5uAUknENtgGpXvtrw3?=
 =?us-ascii?Q?q+xJRpgQ1/KsL9J1OufldMippM4Czt/26rE7dbuikvzK6737OM0L/HHLGbeo?=
 =?us-ascii?Q?MFto9M3wy8OqYHGRNXpoit9QV3LL3wsC0IkjXDBrCnqAv732xnrXlfEviMIg?=
 =?us-ascii?Q?CNP8D9DoXgrTXGbJd9+IT+tYfT5IOuVD6XEloqoisbjvWlnVLsNgjSmpA0Mk?=
 =?us-ascii?Q?D2ea0JJB0iU/PePZZo3mkYi8/GpOh48aCHlwqPMK0A20sNGPhpaEPXJwEbY3?=
 =?us-ascii?Q?B4hYrXi+pR53F0m1AIw/fV07GJkCUOzIEWaVQo38c8+Sls1R387xvgdKUKJA?=
 =?us-ascii?Q?PEUhMyeu2yNEYczYEgZy+3EVPwoSf4pFHDpZSWPN4wUaYNhTsWQW5K6OAzpK?=
 =?us-ascii?Q?5TCtdjrN6DGQJ58Gg6NNGX4thiYIq4MxBKQaMgnJldXgf4gE6mCW92BxO/+p?=
 =?us-ascii?Q?8T5Q3nCy2fJwBYRIcYRGhDkf2j/dYjrEhWYuDirrddyiWFsWVmghn45Ms0UM?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d05c744-cf49-4733-1730-08dc96e717c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 20:24:06.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zk5DTxLr4IqWNLruzISG7oJJfm2DtYREwTqgqm3S+zDJPmUdvsXpDhD4EGfqfHhRHwuN6PimJWJrSx67zkyaBoKxMlXFqIJDVO1eJX2thbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > Alistair Popple wrote:
> >> FS DAX pages have always maintained their own page reference counts
> >> without following the normal rules for page reference counting. In
> >> particular pages are considered free when the refcount hits one rather
> >> than zero and refcounts are not added when mapping the page.
> >> 
> >> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> >> mechanism for allowing GUP to hold references on the page (see
> >> get_dev_pagemap). However there doesn't seem to be any reason why FS
> >> DAX pages need their own reference counting scheme.
> >> 
> >> By treating the refcounts on these pages the same way as normal pages
> >> we can remove a lot of special checks. In particular pXd_trans_huge()
> >> becomes the same as pXd_leaf(), although I haven't made that change
> >> here. It also frees up a valuable SW define PTE bit on architectures
> >> that have devmap PTE bits defined.
> >> 
> >> It also almost certainly allows further clean-up of the devmap managed
> >> functions, but I have left that as a future improvment.
> >> 
> >> This is an update to the original RFC rebased onto v6.10-rc5. Unlike
> >> the original RFC it passes the same number of ndctl test suite
> >> (https://github.com/pmem/ndctl) tests as my current development
> >> environment does without these patches.
> >
> > Are you seeing the 'mmap.sh' test fail even without these patches?
> 
> No. But I also don't see it failing with these patches :)
> 
> For reference this is what I see on my test machine with or without:
> 
> [1/70] Generating version.h with a custom command
>  1/13 ndctl:dax / daxdev-errors.sh          SKIP             0.06s   exit status 77
>  2/13 ndctl:dax / multi-dax.sh              SKIP             0.05s   exit status 77
>  3/13 ndctl:dax / sub-section.sh            SKIP             0.14s   exit status 77

I really need to get this test built as a service as this shows a
pre-req is missing, and it's not quite fair to expect submitters to put
it all together.

>  4/13 ndctl:dax / dax-dev                   OK               0.02s
>  5/13 ndctl:dax / dax-ext4.sh               OK              12.97s
>  6/13 ndctl:dax / dax-xfs.sh                OK              12.44s
>  7/13 ndctl:dax / device-dax                OK              13.40s
>  8/13 ndctl:dax / revoke-devmem             FAIL             0.31s   (exit status 250 or signal 122 SIGinvalid)
> >>> TEST_PATH=/home/apopple/ndctl/build/test LD_LIBRARY_PATH=/home/apopple/ndctl/build/cxl/lib:/home/apopple/ndctl/build/daxctl/lib:/home/apopple/ndctl/build/ndctl/lib NDCTL=/home/apopple/ndctl/build/ndctl/ndctl MALLOC_PERTURB_=227 DATA_PATH=/home/apopple/ndctl/test DAXCTL=/home/apopple/ndctl/build/daxctl/daxctl /home/apopple/ndctl/build/test/revoke_devmem
> 
>  9/13 ndctl:dax / device-dax-fio.sh         OK              32.43s
> 10/13 ndctl:dax / daxctl-devices.sh         SKIP             0.07s   exit status 77
> 11/13 ndctl:dax / daxctl-create.sh          SKIP             0.04s   exit status 77
> 12/13 ndctl:dax / dm.sh                     FAIL             0.08s   exit status 1
> >>> MALLOC_PERTURB_=209 TEST_PATH=/home/apopple/ndctl/build/test LD_LIBRARY_PATH=/home/apopple/ndctl/build/cxl/lib:/home/apopple/ndctl/build/daxctl/lib:/home/apopple/ndctl/build/ndctl/lib NDCTL=/home/apopple/ndctl/build/ndctl/ndctl DATA_PATH=/home/apopple/ndctl/test DAXCTL=/home/apopple/ndctl/build/daxctl/daxctl /home/apopple/ndctl/test/dm.sh
> 
> 13/13 ndctl:dax / mmap.sh                   OK             107.57s

I need to think through why this one might false succeed, but that can
wait until we get this series reviewed. For now my failure is stable
which allows it to be bisected.

> 
> Ok:                 6   
> Expected Fail:      0   
> Fail:               2   
> Unexpected Pass:    0   
> Skipped:            5   
> Timeout:            0   
> 
> I have been using QEMU for my testing. Maybe I missed some condition in
> the unmap path though so will take another look.

I was able to bisect to:

[PATCH 10/13] fs/dax: Properly refcount fs dax pages

...I will prioritize that one in my review queue.

